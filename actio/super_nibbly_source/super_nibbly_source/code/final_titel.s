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
subychar:	equ	48*5*85

aud0lc = $a0
aud0len = $a4
aud0per = $a6
aud0vol = $a8
aud1lc = $b0
aud1len = $b4
aud1per = $b6
aud1vol = $b8
aud2lc = $c0
aud2len = $c4
aud2per = $c6
aud2vol = $c8
aud3lc = $d0
aud3len = $d4
aud3per = $d6
aud3vol = $d8
adkcon = $9e

BITMAP=48*535*5

UPY = 70
	;	SECTION Prog,CODE_C
		
j:

start:
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

	move.l	d1,blacklist


        move.l  4,a6
        lea     gfxname,a1
	move.l	#0,d0
        jsr     openlibrary(a6)
        move.l  d0,gfxbase
	

	move.w	$dff014,number
	move.l	a7,savea7

	move.l	4.w,a6
	jsr	forbid(a6)
	move.l	#$dff000,a5


	move.l	4,a6
	move.l	#12510,d0
	move.l	#0,d1
	jsr	allocmem(a6)
	move.l	d0,titel
	tst.l	d0
	beq	error

	move.l	4,a6
	move.l	#52400,d0
	move.l	#0,d1
	jsr	allocmem(a6)
	move.l	d0,mt_data
	tst.l	d0
	beq	error

	move.l	4,a6
	move.l	#58750,d0
	move.l	#2,d1
	jsr	allocmem(a6)
	move.l	d0,logobuffer
	tst.l	d0
	beq	error

	move.l	logobuffer,d0
	
	move.l	d0,logon
	add.l	#4200,d0
	move.l	d0,logon_m
	add.l	#4200,d0
	move.l	d0,logoi
	add.l	#2160,d0
	move.l	d0,logoi_m
	add.l	#2160,d0
	move.l	d0,logob1
	add.l	#3750,d0
	move.l	d0,logob1_m
	add.l	#3750,d0
	move.l	d0,logob2
	add.l	#3500,d0
	move.l	d0,logob2_m
	add.l	#3500,d0
	move.l	d0,logol
	add.l	#3900,d0
	move.l	d0,logol_m
	add.l	#3900,d0
	move.l	d0,logoy
	add.l	#4100,d0	
	move.l	d0,logoy_m
	add.l	#4100,d0
	move.l	d0,flusi
	add.l	#3840,d0
	move.l	d0,flusi_m
	add.l	#3840,d0
	move.l	d0,wolki
	add.l	#480,d0
	move.l	d0,wolki_m
	add.l	#480,d0
	move.l	d0,motor
	add.l	#4356,d0
	move.l	d0,donner

	move.l	4,a6
	move.l	#8640,d0
	move.l	#0,d1
	jsr	allocmem(a6)
	move.l	d0,credits
	tst.l	d0
	beq	error

	move.l	4,a6
	move.l	#8640,d0
	move.l	#0,d1
	jsr	allocmem(a6)
	move.l	d0,credits_m
	tst.l	d0
	beq	error


	move.l	4,a6
	move.l	#BITMAP,d0
	move.l	#2,d1
	jsr	allocmem(a6)
	move.l	d0,bitplanes
	move.l	d0,save4clr
	tst.l	d0
	beq	error	
	add.l	#48*5*(22+256),d0
	move.l	d0,bitplanes2


	move.l	gfxbase,a6
	jsr	-228(a6)
	jsr	ownblitter(a6)

	move.l	save4clr,d0
	bsr	cls

	move.l	gfxbase,a6
	jsr	-228(a6)
	jsr	disownblitter(a6)

	bsr	loadfiles

	move.l	gfxbase,a6
	jsr	-228(a6)
	jsr	ownblitter(a6)

	move.l	#$ffffffff,bltafwm(a5)

	bsr	transfer

	bsr	newcopper


	move.l	#0,leftx

	;bra	erste_sequenz

	lea	flugi1,a0
	move.w	#0,(a0)
	move.w	#80,2(a0)
	move.w	#0,4(a0)
	move.w	#0,6(a0)
	move.l	#0,8(a0)
	move.l	#buffer1,12(a0)
	move.w	#0,16(a0)
	move.l	#moves1,18(a0)

	lea	flugi2,a0
	move.w	#78,(a0)
	move.w	#8,2(a0)
	move.w	#0,4(a0)
	move.w	#0,6(a0)
	move.l	#0,8(a0)
	move.l	#buffer2,12(a0)
	move.w	#0,16(a0)
	move.l	#moves2,18(a0)

	lea	flugi3,a0
	move.w	#170,(a0)
	move.w	#8,2(a0)
	move.w	#0,4(a0)
	move.w	#0,6(a0)
	move.l	#0,8(a0)
	move.l	#buffer3,12(a0)
	move.w	#0,16(a0)
	move.l	#moves3,18(a0)


	move.w	#0,volume
	
.chvol
	bsr	vposup
	bsr	smokie
	bsr	vposup
	bsr	smokie
	add.w	#1,volume
	bsr	flugmotor
	cmp.w	#32,volume
	bne	.chvol

flieger:	
	bsr	vposdown
	bsr	smokie
	lea	flugi1,a0
	bsr	doflusi
	lea	flugi2,a0
	bsr	doflusi
	lea	flugi3,a0
	bsr	doflusi

	lea	flugi1,a0
	move.l	18(a0),a1
	cmp.b	#$ff,3(a1)
	bne	flieger
	lea	flugi2,a0
	move.l	18(a0),a1
	cmp.b	#$ff,3(a1)
	bne	flieger
	lea	flugi3,a0
	move.l	18(a0),a1
	cmp.b	#$ff,3(a1)
	bne	flieger

noflieger:	
	bsr	transfer2	
	
	bsr	waitblit
	bsr	vposup
	move.l	bitplanes,d0
	add.l	#48*5*20,d0
	bsr	switch


.chvol2
	bsr	vposup
	bsr	smokie
	bsr	vposup
	bsr	smokie
	sub.w	#1,volume
	bsr	flugmotor
	cmp.w	#0,volume
	bne	.chvol2


	;bsr	soundoff

	move.w	#10,dropy
dropB1:
	bsr	vposdown
	bsr	smokie
	move.w	#94,d0
	move.w	dropy,d1
	move.w	#5,d2
	move.w	#75,d3
	bsr	restore
	add.w	#15,dropy
	move.w	#94,d0
	move.w	dropy,d1
	move.w	#5,d2
	move.w	#75,d3
	move.l	logoB1,d4
	move.l	LogoB1_m,d5
	bsr	bitblit
	cmp.w	#190,dropy
	blt	dropb1
	move.l	bitplanes2,d0
	move.l	d0,activeplanes
	move.w	#94,d0
	move.w	dropy,d1
	move.w	#5,d2
	move.w	#75,d3
	move.l	logoB1,d4
	move.l	LogoB1_m,d5
	bsr	bitblit
	move.l	bitplanes,d0
	add.l	#48*5*20,d0
	move.l	d0,activeplanes

	bsr	do_donner

	move.w	#0,waoff

	move.w	#8,dropy
dropB2:
	bsr	wackel
	bsr	vposdown
	bsr	smokie
	move.w	#150,d0
	move.w	dropy,d1
	move.w	#5,d2
	move.w	#70,d3
	bsr	restore
	add.w	#15,dropy
	move.w	#150,d0
	move.w	dropy,d1
	move.w	#5,d2
	move.w	#70,d3
	move.l	logoB2,d4
	move.l	LogoB2_m,d5
	bsr	bitblit
	cmp.w	#188,dropy
	blt	dropb2
	move.l	bitplanes2,d0
	move.l	d0,activeplanes
	move.w	#150,d0
	move.w	dropy,d1
	move.w	#5,d2
	move.w	#70,d3
	move.l	logoB2,d4
	move.l	logoB2_m,d5
	bsr	bitblit
	move.l	bitplanes,d0
	add.l	#48*5*20,d0
	move.l	d0,activeplanes


 	bsr	do_donner

	move.w	#0,waoff

	move.w	#20,dropy
dropI:
	bsr	wackel
	bsr	vposdown
	bsr	smokie
	move.w	#68,d0
	move.w	dropy,d1
	move.w	#3,d2
	move.w	#72,d3
	bsr	restore
	add.w	#15,dropy
	move.w	#68,d0
	move.w	dropy,d1
	move.w	#3,d2
	move.w	#72,d3
	move.l	logoI,d4
	move.l	LogoI_m,d5
	bsr	bitblit
	cmp.w	#200,dropy
	blt	dropI
	move.l	bitplanes2,d0
	move.l	d0,activeplanes
	move.w	#68,d0
	move.w	dropy,d1
	move.w	#3,d2
	move.w	#72,d3
	move.l	logoI,d4
	move.l	LogoI_m,d5
	bsr	bitblit
	move.l	bitplanes,d0
	add.l	#48*5*20,d0
	move.l	d0,activeplanes

	bsr	do_donner

	move.w	#0,waoff

	move.w	#10,dropy
dropL:
	bsr	wackel
	bsr	vposdown
	bsr	smokie
	move.w	#202,d0
	move.w	dropy,d1
	move.w	#5,d2
	move.w	#78,d3
	bsr	restore
	add.w	#15,dropy
	move.w	#202,d0
	move.w	dropy,d1
	move.w	#5,d2
	move.w	#78,d3
	move.l	logoL,d4
	move.l	LogoL_m,d5
	bsr	bitblit
	cmp.w	#190,dropy
	blt	dropL
	move.l	bitplanes2,d0
	move.l	d0,activeplanes
	move.w	#202,d0
	move.w	dropy,d1
	move.w	#5,d2
	move.w	#78,d3
	move.l	logoL,d4
	move.l	LogoL_m,d5
	bsr	bitblit
	move.l	bitplanes,d0
	add.l	#48*5*20,d0
	move.l	d0,activeplanes

	bsr	do_donner

	move.w	#0,waoff

	move.w	#0,dropy
dropN:
	bsr	wackel
	bsr	vposdown
	bsr	smokie
	move.w	#27,d0
	move.w	dropy,d1
	move.w	#5,d2
	move.w	#84,d3
	bsr	restore
	add.w	#15,dropy
	move.w	#27,d0
	move.w	dropy,d1
	move.w	#5,d2
	move.w	#84,d3
	move.l	logoN,d4
	move.l	LogoN_m,d5
	bsr	bitblit
	cmp.w	#210,dropy
	blt	dropN
	move.l	bitplanes2,d0
	move.l	d0,activeplanes
	move.w	#27,d0
	move.w	dropy,d1
	move.w	#5,d2
	move.w	#84,d3
	move.l	logoN,d4
	move.l	LogoN_m,d5
	bsr	bitblit
	move.l	bitplanes,d0
	add.l	#48*5*20,d0
	move.l	d0,activeplanes

	bsr	do_donner

	move.w	#0,waoff

	move.w	#20,dropy
CdropY:
	bsr	wackel
	bsr	vposdown
	bsr	smokie
	move.w	#245,d0
	move.w	dropy,d1
	move.w	#5,d2
	move.w	#82,d3
	bsr	restore
	add.w	#20,dropy
	move.w	#245,d0
	move.w	dropy,d1
	move.w	#5,d2
	move.w	#82,d3
	move.l	logoY,d4
	move.l	LogoY_m,d5
	bsr	bitblit
	cmp.w	#200,dropy
	blt	CdropY
	move.l	bitplanes2,d0
	move.l	d0,activeplanes
	move.w	#245,d0
	move.w	dropy,d1
	move.w	#5,d2
	move.w	#82,d3
	move.l	logoY,d4
	move.l	LogoY_m,d5
	bsr	bitblit
	move.l	bitplanes,d0
	add.l	#48*5*20,d0
	move.l	d0,activeplanes

	bsr	do_donner

	move.w	#0,waoff

	move.w	#50,d7
.saasd
	bsr	vposup
	bsr	wackel
	bsr	smokie
	sub.w	#1,d7
	bne	.saasd
	

	bsr	waitblit

	bsr	transfer2	

	bsr	vposup

	move.l	bitplanes,d0
	add.l	#48*5*20,d0
	bsr	switch

	move.l	mt_data,a0
	move.l	logobuffer,a1
	
	move.l	#52338/4,d0
	sub.w	#1,d0
trans:
	move.l	(a0)+,(a1)+
	dbra	d0,trans


erste_sequenz:		;************************************

	move.w	#0,timer

	move.l	logobuffer,a0
	bsr	mt_init	

	move.w	#40,fishx
	move.w	#100,fishy
	move.w	#0,fishseq
	move.l	#fishies,fishoff

	move.w	#14,d1
	bsr	rnd
	and.l	#%1110,d0
	move.l	d0,what2dopoint
	lea	what2dotab,a0
	add.l	d0,a0
	move.w	(a0),what2do

	bsr	music_on

	bra	doinit

main:
	move.l	bitplanes,activeplanes
	add.l	#48*5*20,activeplanes
	
	bsr	smokie
	bsr	copyfish

	;bsr	mt_music


	cmp.w	#1640+800,timer
	blt	.notimerreset
	move.w	#0,timer
.notimerreset
	
	cmp.w	#300,timer
	beq	doinit

	bra	notfire

helpme:	dc.w	0

doinit:
	move.w	timert2,helpme
	move.w	timer,timert2

	move.w	#0,babytuut
	move.w	#0,period
	move.w	#0,initvor
	move.w	#0,initverfolg
	move.w	#0,initfruitjump
	move.w	#0,initfruitjump2
	move.w	#0,initfruitjump3
	move.w	#0,initfruitjump4
	move.w	#0,initfruitjump5
	move.w	#0,teilflag

	not.w	switchbaby

	move.l	what2dopoint,d0
	addq.l	#2,d0
	move.l	d0,what2dopoint
	lea	what2dotab,a0
	and.l	#%1110,d0
	add.l	d0,a0
	move.w	(a0),what2do

	move.l	#0,hpointer

	move.w	#0,vor1ht
	move.w	#0,brems
	
	add.l	#1,chaseoff
	cmp.l	#3,chaseoff
	bne	.notover
	move.l	#0,chaseoff
.notover

notfire:

	tst.w	brems
	beq	normal

	move.l	#$10000,d0
pause:
	sub.l	#1,d0
	bne	pause

normal:

	add.w	#1,timer
	add.w	#1,timert2


	;**************************************
	;* Verfolgen
	;**************************************

	cmp.l	#2,chaseoff
	beq	do_chase5

	cmp.l	#1,chaseoff
	beq	do_chase4

	bsr	do_chase1
	bra	do_chase3


do_chase1:
	tst.w	initfruitjump3
	bne	verfolg_aus2

	tst.w	initfruitjump2
	bne	verfolg_aus

	cmp.w	#1950,timert2			;1950
	bls	verfolg_aus

	tst.w	initfruitjump
	bne	.init_done2
	move.w	#1,initfruitjump
	move.l	#fruitjump1,fruitpointer
	move.w	#56,fruitx
	move.w	#240,fruity
.init_done2

	tst.w	initfruitjump
	beq	.no_fruit


	move.l	#12,leftx

	move.w	fruitx,d0
	move.w	fruity,d1
	move.w	#4,d2
	move.w	#37,d3
	bsr	restore

	cmp.w	#320+12*8,fruitx
	bge	.no_fruit
	
	add.w	#5,fruitx

	move.l	fruitpointer,a0
	move.w	(a0)+,d0
	cmp.w	#$4711,d0
	beq	.no_fruit
	add.w	d0,fruity
	move.l	a0,fruitpointer
	
	move.w	fruitx,d0
	move.w	fruity,d1
	move.w	#4,d2
	move.w	#37,d3
	move.l	#smallfruit,d4
	move.l	#smallfruit_m,d5
	bsr	bitblit
.no_fruit
	


	cmp.w	#30+1945,timert2		;1975
	bls	verfolg_aus
	
	tst.w	initverfolg
	bne	.init_done
	move.w	#1,initverfolg
	move.w	#0,verx
.init_done
	
	tst.w	initverfolg
	beq	.nix_verfolgen

	bsr	vposup
		
	move.l	#12,leftx

	move.w	verx,d0
	move.w	#271,d1
	move.w	#6,d2
	move.w	#55,d3
	bsr	restore
	
	add.w	#5,verx
	
	cmp.w	#320+12*8,verx
	bge	.nix_verfolgen
	
	move.w	verx,d0
	move.w	#271,d1
	move.w	#6,d2
	move.w	#55,d3
	move.l	#verrechts,d4
	move.l	#verrechts_m,d5
	bsr	bitblit

	cmp.w	#50,verx
	bge	.nix_loesch

	move.w	#320,d0
	move.w	#271,d1
	move.w	#6,d2
	move.w	#55,d3
	bsr	restore
		
.nix_loesch

	cmp.w	#300,verx
	bls	.nix_verfolgen

	move.w	#96,d0
	move.w	#271,d1
	move.w	#6,d2
	move.w	#55,d3
	bsr	restore
		
.nix_verfolgen


verfolg_aus:

	cmp.w	#130+1945,timert2		;2075
	bls	verfolg_aus2

	tst.w	initfruitjump2
	bne	.init_done2
	move.w	#1,initfruitjump2
	move.l	#fruitjump1,fruitpointer
	move.w	#320+12*8,fruitx
	move.w	#240,fruity
	move.w	#0,initverfolg
.init_done2

	tst.w	initfruitjump2
	beq	.no_fruit

	move.l	#12,leftx

	cmp.w	#54,fruitx
	bls	.no_fruit

	move.w	fruitx,d0
	move.w	fruity,d1
	move.w	#4,d2
	move.w	#37,d3
	bsr	restore


	sub.w	#5,fruitx

	move.l	fruitpointer,a0
	move.w	(a0)+,d0
	cmp.w	#$4711,d0
	beq	.no_fruit
	add.w	d0,fruity
	move.l	a0,fruitpointer
	
	move.w	fruitx,d0
	move.w	fruity,d1
	move.w	#4,d2
	move.w	#37,d3
	move.l	#smallfruit,d4
	move.l	#smallfruit_m,d5
	bsr	bitblit
.no_fruit
	
	
	cmp.w	#160+1945,timert2		;2105
	bls	verfolg_aus2
	
	tst.w	initverfolg
	bne	.init_done
	move.w	#1,initverfolg
	move.w	#320+12*8,verx
.init_done
	
	tst.w	initverfolg
	beq	.nix_verfolgen

	bsr	vposup

	tst.w	verx
	bmi	.nix_verfolgen
		
	move.l	#12,leftx

	move.w	verx,d0
	move.w	#271,d1
	move.w	#6,d2
	move.w	#55,d3
	bsr	restore
	
	sub.w	#5,verx
	
	tst.w	verx
	bmi	.nix_verfolgen
	
	move.w	verx,d0
	move.w	#271,d1
	move.w	#6,d2
	move.w	#55,d3
	move.l	#verlinks,d4
	move.l	#verlinks_m,d5
	bsr	bitblit

	cmp.w	#100,verx
	bge	.nix_loesch

	move.w	#320+32,d0
	move.w	#271,d1
	move.w	#4,d2
	move.w	#55,d3
	bsr	restore	
.nix_loesch

	cmp.w	#320,verx
	bls	.nix_verfolgen

	move.w	#96,d0
	move.w	#271,d1
	move.w	#4,d2
	move.w	#55,d3
	bsr	restore		
.nix_verfolgen

verfolg_aus2:
	rts


	;*********************************
	;* Big Fruit chasing
	;*********************************

do_chase3:
	cmp.w	#130+125+1945,timert2			;2200
	bls	verfolg_aus3

	tst.w	initfruitjump3
	bne	.init_done3
	move.w	#1,initfruitjump3
	move.l	#fruitjump1,fruitpointer
	move.w	#56,fruitx
	move.w	#210,fruity
	move.w	#0,initverfolg
.init_done3

	tst.w	initfruitjump3
	beq	.no_fruit

	bsr	vposup

	cmp.w	#130+125+40+1945,timert2	;2240
	bls	.no_fruit

	move.l	#12,leftx

	move.w	fruitx,d0
	move.w	fruity,d1
	move.w	#6,d2
	move.w	#74,d3
	bsr	restore

	cmp.w	#320+12*8,fruitx
	bge	.no_fruit
	
	add.w	#5,fruitx

	move.l	fruitpointer,a0
	move.w	(a0)+,d0
	cmp.w	#$4711,d0
	beq	.no_fruit
	add.w	d0,fruity
	move.l	a0,fruitpointer
	
	move.w	fruitx,d0
	move.w	fruity,d1
	move.w	#6,d2
	move.w	#74,d3
	move.l	#bigfruit,d4
	move.l	#bigfruit_m,d5
	bsr	bitblit

	cmp.w	#400,fruitx
	bls	.no_fruit
	move.w	#96,d0
	move.w	fruity,d1
	move.w	#2,d2
	move.w	#74,d3
	bsr	restore
.no_fruit


	cmp.w	#131+125+1945,timert2		;2201
	bls	verfolg_aus3
	
	tst.w	initverfolg
	bne	.init_done
	move.w	#1,initverfolg
	move.w	#0,verx
.init_done
	
	tst.w	initverfolg
	beq	.nix_verfolgen

		
	move.l	#12,leftx

	move.w	verx,d0
	move.w	#271,d1
	move.w	#6,d2
	move.w	#55,d3
	bsr	restore
	
	add.w	#5,verx
	
	cmp.w	#320+12*8,verx
	bge	.nix_verfolgen
	
	move.w	verx,d0
	move.w	#271,d1
	move.w	#6,d2
	move.w	#55,d3
	move.l	#BF_behind,d4
	move.l	#BF_behind_m,d5
	bsr	bitblit

	cmp.w	#50,verx
	bge	.nix_loesch

	move.w	#320,d0
	move.w	#271,d1
	move.w	#6,d2
	move.w	#55,d3
	bsr	restore
		
.nix_loesch

	cmp.w	#300,verx
	bls	.nix_verfolgen

	move.w	#96,d0
	move.w	#271,d1
	move.w	#6,d2
	move.w	#55,d3
	bsr	restore
		
.nix_verfolgen


verfolg_aus3:
	bra	end_of_chase



	;*********************************
	;* Big Fruit mampf
	;*********************************

do_chase4:
	tst.w	initfruitjump4
	bne	verfolg_aus4

	cmp.w	#5+1945,timert2			;1950
	bls	verfolg_aus4

	tst.w	initfruitjump
	bne	.init_done2
	move.w	#1,initfruitjump
	move.l	#fruitjump1,fruitpointer
	move.w	#56,fruitx
	move.w	#210,fruity
.init_done2

	tst.w	initfruitjump
	beq	.no_fruit

	bsr	vposup

	move.l	#12,leftx

	move.w	fruitx,d0
	move.w	fruity,d1
	move.w	#6,d2
	move.w	#74,d3
	bsr	restore

	cmp.w	#320+12*8,fruitx
	bge	.no_fruit
	
	add.w	#5,fruitx

	move.l	fruitpointer,a0
	move.w	(a0)+,d0
	cmp.w	#$4711,d0
	beq	.no_fruit
	add.w	d0,fruity
	move.l	a0,fruitpointer
	
	move.w	fruitx,d0
	move.w	fruity,d1
	move.w	#6,d2
	move.w	#74,d3
	move.l	#bigfruit,d4
	move.l	#bigfruit_m,d5
	bsr	bitblit

	cmp.w	#400,fruitx
	bls	.no_fruit
	move.w	#96,d0
	move.w	fruity,d1
	move.w	#2,d2
	move.w	#74,d3
	bsr	restore
.no_fruit


	cmp.w	#30+1945,timert2		;1975
	bls	verfolg_aus4
	
	tst.w	initverfolg
	bne	.init_done
	move.w	#1,initverfolg
	move.w	#0,verx
.init_done
	
	tst.w	initverfolg
	beq	.nix_verfolgen
		
	move.l	#12,leftx

	move.w	verx,d0
	move.w	#271,d1
	move.w	#6,d2
	move.w	#55,d3
	bsr	restore
	
	add.w	#5,verx
	
	cmp.w	#320+12*8,verx
	bge	.nix_verfolgen
	
	move.w	verx,d0
	move.w	#271,d1
	move.w	#6,d2
	move.w	#55,d3
	move.l	#verrechts,d4
	move.l	#verrechts_m,d5
	bsr	bitblit

	cmp.w	#50,verx
	bge	.nix_loesch

	move.w	#320,d0
	move.w	#271,d1
	move.w	#6,d2
	move.w	#55,d3
	bsr	restore
		
.nix_loesch

	cmp.w	#300,verx
	bls	.nix_verfolgen

	move.w	#96,d0
	move.w	#271,d1
	move.w	#6,d2
	move.w	#55,d3
	bsr	restore
		
.nix_verfolgen

verfolg_aus4:


	cmp.w	#140+1945,timert2		;2085
	bls	.no_slup

	cmp.w	#170+1945,timert2		
	bge	.no_slup

	move.w	#350,d0
	move.w	#210,d1
	move.w	#5,d2
	move.w	#39,d3
	move.l	#slup,d4
	move.l	#slup_m,d5
	bsr	bitblit
		
.no_slup


	cmp.w	#230+1945,timert2	;2175
	bne	.no_clr_slup
	move.w	#350,d0
	move.w	#210,d1
	move.w	#5,d2
	move.w	#39,d3
	bsr	restore
.no_clr_slup


	tst.w	initfruitjump5
	bne	.too_early

	cmp.w	#150+200+1945,timert2	;2295
	bls	.too_early

	tst.w	initfruitjump4
	bne	.initdone44
	move.w	#1,initfruitjump4
	move.w	#326,vor1y
	move.l	#vor11tab,hpointer
.initdone44

	bsr	vposup

	move.w	#208,d0
	move.w	vor1y,d1
	move.w	#6,d2
	move.w	#71,d3
	bsr	restore

	move.l	hpointer,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tab2
	lea	2(a0),a0
.end_of_tab2
	move.l	a0,hpointer

	move.w	vor1y,d1
	sub.w	d2,d1
	move.w	d1,vor1y
	
	move.w	#208,d0
	move.w	vor1y,d1
	move.w	#6,d2
	move.w	#71,d3
	move.l	#flups_dick,d4
	move.l	#flups_dick_m,d5
	bsr	bitblit

.too_early



	cmp.w	#200+200+1945,timert2
	bls	.no_sprechers

	cmp.w	#390+200+1945,timert2
	bge	.no_sprechers

	move.w	#270,d0
	move.w	#180,d1
	move.w	#7,d2
	move.w	#51,d3
	move.l	#uff,d4
	move.l	#uff_m,d5
	bsr	bitblit	


	move.w	#260,d0
	move.w	#230,d1
	move.w	#3,d2
	move.w	#24,d3
	move.l	#blobs1,d4
	move.l	#blobs1_m,d5
	bsr	bitblit	

.no_sprechers

	cmp.w	#395+200+1945,timert2
	bne	.no_sprech_weg
	
	move.w	#270,d0
	move.w	#180,d1
	move.w	#7,d2
	move.w	#51,d3
	bsr	restore

	move.w	#260,d0
	move.w	#230,d1
	move.w	#3,d2
	move.w	#24,d3
	bsr	restore

.no_sprech_weg

	cmp.w	#400+200+1945,timert2
	bls	.too_early2

	tst.w	initfruitjump5
	bne	.initdone45
	move.w	#1,initfruitjump5
	move.l	#vor11tabend-2,hpointer
.initdone45

	bsr	vposup

	move.w	#208,d0
	move.w	vor1y,d1
	move.w	#6,d2
	move.w	#71,d3
	bsr	restore

	move.l	hpointer,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tab222
	lea	-2(a0),a0
.end_of_tab222
	move.l	a0,hpointer

	move.w	vor1y,d1
	add.w	d2,d1
	move.w	d1,vor1y
	
	move.w	#208,d0
	move.w	vor1y,d1
	move.w	#6,d2
	move.w	#71,d3
	move.l	#flups_dick,d4
	move.l	#flups_dick_m,d5
	bsr	bitblit

.too_early2


	bra	end_of_chase


	;*********************************
	;* 
	;*********************************

do_chase5:	
	tst.w	initverfolg
	bne	.is_set

	cmp.w	#1950,timer
	bls	no_flieger

	tst.w	initverfolg
	bne	.init_done
	move.w	#1,initverfolg
	move.w	#12,fliegx
	move.w	#2,fliegy
	move.w	#0,propo
	move.l	#0,proflieg
	move.w	#0,protimer
.init_done	


	tst.w	initverfolg
	beq	no_flieger

.is_set
	add.w	#1,protimer
	
	move.l	#12,leftx

	cmp.w	#376,protimer
	bge	.aus_mitn_flieger
	
	cmp.w	#40,fliegy
	bge	.nixmehr
	bsr	vposup
.nixmehr	
	
	;btst	#7,$bfe001
	;beq	.isfire
	;bsr	vposup
.vpos
	move.w	$dff006,d1
	lsr.w	#8,d1
	and.w	#$ff,d1
	move.w	#$60,d2
	add.w	fliegy,d2
	sub.w	#50,d2
	cmp.w	d2,d1
	bls.s	.vpos
.isfire

	bsr	waitblit


	cmp.w	#100,protimer
	bne	.no_sprech
	move.w	#304,d0
	move.w	#80,d1
	move.w	#6,d2
	move.w	#51,d3
	move.l	#wbest,d4
	move.l	#wbest_m,d5
	bsr	bitblit	
	bra	.overall
.no_sprech

	cmp.w	#270,protimer
	bne	.no_sprech11
	move.w	#304,d0
	move.w	#80,d1
	move.w	#6,d2
	move.w	#51,d3
	bsr	restore
	bra	.overall
.no_sprech11

	move.w	fliegx,d0
	move.w	fliegy,d1
	add.w	#101,d0
	add.w	#30,d1
	move.w	#2,d2
	move.w	#47,d3
	bsr	restore


	cmp.w	#360,protimer
	bls	.nosplit

	move.w	fliegx,d0
	move.w	fliegy,d1
	move.w	#4,d2
	move.w	#78,d3
	bsr	restore
	bra	.issplit
.nosplit
	move.w	fliegx,d0
	move.w	fliegy,d1
	move.w	#8,d2
	move.w	#78,d3
	bsr	restore
.issplit

	lea	profliegtabx,a0
	move.l	proflieg,d2
	move.w	(a0,d2.w),d0
	cmp.w	#$4711,d0
	beq	.endtab
	lea	profliegtaby,a0
	move.w	(a0,d2.w),d1
	add.l	#2,d2
	bra	.intab
.endtab
	move.w	#0,d0
	move.w	#0,d1
.intab
	move.l	d2,proflieg

	add.w	d0,fliegx
	add.w	d1,fliegy

	move.w	fliegx,d0
	move.w	fliegy,d1
	move.w	#8,d2
	move.w	#78,d3
	move.l	#BigFlieger,d4
	move.l	#BigFlieger_m,d5
	bsr	bitblit



	cmp.w	#360,protimer
	bls	.nosplit2
	move.w	#96,d0
	move.w	fliegy,d1
	move.w	#4,d2
	move.w	#78,d3
	bsr	restore
	bra	.overall
.nosplit2

	add.w	#1,propo
	and.w	#1,propo

	cmp.w	#0,propo
	bne	.nopro1
	move.w	fliegx,d0
	move.w	fliegy,d1
	add.w	#101,d0
	add.w	#30,d1
	move.w	#2,d2
	move.w	#47,d3
	move.l	#prop1,d4	
	move.l	#prop1_m,d5	
	bsr	bitblit
.nopro1

	cmp.w	#1,propo
	bne	.nopro3
	move.w	fliegx,d0
	move.w	fliegy,d1
	add.w	#101,d0
	add.w	#50,d1
	move.w	#2,d2
	move.w	#7,d3
	move.l	#prop3,d4	
	move.l	#prop3_m,d5	
	bsr	bitblit
.nopro3


.overall

	cmp.w	#100,protimer
	blt	.no_sprech2
	cmp.w	#270,protimer
	bge	.no_sprech2
	move.w	#287,d0
	move.w	#130,d1
	move.w	#3,d2
	move.w	#24,d3
	move.l	#blobs1,d4
	move.l	#blobs1_m,d5
	bsr	bitblit	
.no_sprech2

	cmp.w	#270,protimer
	blt	.no_sprech22
	move.w	#287,d0
	move.w	#130,d1
	move.w	#3,d2
	move.w	#24,d3
	bsr	restore
.no_sprech22

	bra	no_flieger

.aus_mitn_flieger
	bsr	vposup

	cmp.w	#376+50,protimer
	bne	.toff1
	move.w	#335,d0
	move.w	#190,d1
	move.w	#5,d2
	move.w	#39,d3
	move.l	#toff,d4
	move.l	#toff_m,d5
	bsr	bitblit		
.toff1


	cmp.w	#376+60,protimer
	bne	.zack1
	move.w	#360,d0
	move.w	#154,d1
	move.w	#5,d2
	move.w	#34,d3
	move.l	#zack,d4
	move.l	#zack_m,d5
	bsr	bitblit		
.zack1

	cmp.w	#376+80,protimer
	bne	.toff12
	move.w	#335,d0
	move.w	#190,d1
	move.w	#5,d2
	move.w	#39,d3
	bsr	restore
.toff12

	cmp.w	#376+80,protimer
	bne	.zack12
	move.w	#360,d0
	move.w	#154,d1
	move.w	#5,d2
	move.w	#34,d3
	bsr	restore
.zack12



	cmp.w	#376+85,protimer
	bls	no_flieger

	tst.w	teilflag
	bne	.isset
	move.w	#1,teilflag
	move.w	#360,teil1x
	move.w	#170,teil1y
	move.w	#330,teil2x
	move.w	#220,teil2y
	move.w	#365,teil3x
	move.w	#240,teil3y
	move.w	#340,teil4x
	move.w	#200,teil4y
	move.l	#teiltabs,teil1poi
	move.l	#teiltabs+14,teil2poi
	move.l	#teiltabs+2,teil3poi
	move.l	#teiltabs+30,teil4poi
	move.w	#0,teil1aus
	move.w	#0,teil2aus
	move.w	#0,teil3aus
	move.w	#0,teil4aus
.isset

	move.l	#0,leftx

	tst.w	teil1aus
	bne	.teil1weg2
	move.w	teil1x,d0
	move.w	teil1y,d1
	move.w	#3,d2
	move.w	#32,d3
	bsr	restore
.teil1weg2

	tst.w	teil2aus
	bne	.teil2weg2
	move.w	teil2x,d0
	move.w	teil2y,d1
	move.w	#3,d2
	move.w	#19,d3
	bsr	restore
.teil2weg2

	tst.w	teil3aus
	bne	.teil3weg2
	move.w	teil3x,d0
	move.w	teil3y,d1
	move.w	#3,d2
	move.w	#32,d3
	bsr	restore
.teil3weg2	
	
	tst.w	teil4aus
	bne	.teil4weg2
	move.w	teil4x,d0
	move.w	teil4y,d1
	move.w	#4,d2
	move.w	#19,d3
	bsr	restore
.teil4weg2

	tst.w	teil1aus
	bne	.teil1weg
	move.l	teil1poi,a0
	move.w	(a0),d0
	cmp.w	#$4711,d0
	beq	.isende
	lea	2(a0),a0
	bra	.nonich
.isende
	move.w	#1,teil1aus
	move.w	#0,d0
.nonich
	move.l	a0,teil1poi
	add.w	d0,teil1y
	cmp.w	#325,teil1y
	bls	.gehtno1
	move.w	#1,teil1aus
.gehtno1
	sub.w	#3,teil1x
	move.w	teil1x,d0
	move.w	teil1y,d1
	move.w	#3,d2
	move.w	#32,d3
	move.l	#crash1,d4
	move.l	#crash1_m,d5
	bsr	bitblit		
.teil1weg


	tst.w	teil2aus
	bne	.teil2weg
	move.l	teil2poi,a0
	move.w	(a0),d0
	cmp.w	#$4711,d0
	beq	.isende2
	lea	2(a0),a0
	bra	.nonich2
.isende2
	move.w	#1,teil2aus
	move.w	#0,d0
.nonich2
	move.l	a0,teil2poi
	add.w	d0,teil2y
	cmp.w	#325,teil2y
	bls	.gehtno2
	move.w	#1,teil2aus
.gehtno2
	sub.w	#5,teil2x
	move.w	teil2x,d0
	move.w	teil2y,d1
	move.w	#3,d2
	move.w	#19,d3
	move.l	#crash2,d4
	move.l	#crash2_m,d5
	bsr	bitblit		
.teil2weg


	tst.w	teil3aus
	bne	.teil3weg
	move.l	teil3poi,a0
	move.w	(a0),d0
	cmp.w	#$4711,d0
	beq	.isende3
	lea	2(a0),a0
	bra	.nonich3
.isende3
	move.w	#1,teil3aus
	move.w	#0,d0
.nonich3
	move.l	a0,teil3poi
	add.w	d0,teil3y
	cmp.w	#325,teil3y
	bls	.gehtno3
	move.w	#1,teil3aus
.gehtno3
	sub.w	#5,teil3x
	move.w	teil3x,d0
	move.w	teil3y,d1
	move.w	#3,d2
	move.w	#32,d3
	move.l	#crash3,d4
	move.l	#crash3_m,d5
	bsr	bitblit		
.teil3weg



	tst.w	teil4aus
	bne	.teil4weg
	move.l	teil4poi,a0
	move.w	(a0),d0
	cmp.w	#$4711,d0
	beq	.isende4
	lea	2(a0),a0
	bra	.nonich4
.isende4
	move.w	#1,teil4aus
	move.w	#0,d0
.nonich4
	move.l	a0,teil4poi
	add.w	d0,teil4y
	cmp.w	#325,teil4y
	bls	.gehtno4
	move.w	#1,teil4aus
.gehtno4
	sub.w	#5,teil4x
	move.w	teil4x,d0
	move.w	teil4y,d1
	move.w	#4,d2
	move.w	#19,d3
	move.l	#crash4,d4
	move.l	#crash4_m,d5
	bsr	bitblit		
.teil4weg

no_flieger:

end_of_chase:


	;**************************************
	;* Baby Tuut
	;**************************************

	cmp.w	#920,timer
	bls	kein_tuut2

	cmp.w	#1010,timer
	bge	kein_tuut2

	tst.w	switchbaby
	bne	baby2

	tst.w	babytuut
	bne	.init_done
	move.w	#1,babytuut
	move.w	#320,babyx
	move.w	#160,babyy
	move.l	#babytab,babypointer
	move.w	#0,babytime
.init_done

	add.w	#1,babytime

	tst.w	babytuut
	beq	.noch_nicht


.vpos
	move.w	$dff006,d1
	lsr.w	#8,d1
	cmp.b	#$90,d1
	bls.s	.vpos

	move.l	#0,leftx

	move.w	babyx,d0
	move.w	babyy,d1
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore


	cmp.w	#40,babytime
	bge	.teil_zwei
	

	move.l	babypointer,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tab23
	lea	2(a0),a0
.end_of_tab23
	move.l	a0,babypointer

	move.w	babyx,d1
	sub.w	d2,d1
	move.w	d1,babyx

	move.w	babyy,d1
	sub.w	d2,d1
	move.w	d1,babyy
	
	move.w	babyx,d0
	move.w	babyy,d1
	move.w	#3,d2
	move.w	#26,d3
	move.l	#baby_left,d4
	move.l	#baby_left_m,d5
	bsr	bitblit
	
.noch_nicht

	cmp.w	#28,babytime
	bls	.no_tuut
	
	move.w	#240,d0
	move.w	#100,d1
	move.w	#5,d2
	move.w	#34,d3
	move.l	#tuut,d4
	move.l	#tuut_m,d5
	bsr	bitblit
	
.no_tuut


.teil_zwei

	cmp.w	#40,babytime
	bne	.clr_tuut
	move.w	#240,d0
	move.w	#100,d1
	move.w	#5,d2
	move.w	#34,d3
	bsr	restore
	sub.l	#2,babypointer
.clr_tuut

	cmp.w	#40,babytime
	blt	kein_tuut
	cmp.w	#70,babytime
	bge	.nix_zeige
	move.w	babyx,d0
	move.w	babyy,d1
	move.w	#3,d2
	move.w	#26,d3
	move.l	#baby_left,d4
	move.l	#baby_left_m,d5
	bsr	bitblit
.nix_zeige
	

	cmp.w	#70,babytime
	blt	kein_tuut

	move.l	babypointer,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tab3
	lea	-2(a0),a0
.end_of_tab3
	move.l	a0,babypointer

	move.w	babyx,d1
	add.w	d2,d1
	move.w	d1,babyx

	move.w	babyy,d1
	add.w	d2,d1
	move.w	d1,babyy
	
	move.w	babyx,d0
	move.w	babyy,d1
	move.w	#3,d2
	move.w	#26,d3
	move.l	#baby_left,d4
	move.l	#baby_left_m,d5
	bsr	bitblit

kein_tuut:	

	bra	kein_tuut2
	
	
	
baby2:


	;******************
	;* baby 2
	;******************	
	
	
	tst.w	babytuut
	bne	.init_done
	move.w	#1,babytuut
	move.w	#66,babyx
	move.w	#160,babyy
	move.l	#babytab,babypointer
	move.w	#0,babytime
.init_done

	add.w	#1,babytime

	tst.w	babytuut
	beq	.noch_nicht


.vpos
	move.w	$dff006,d1
	lsr.w	#8,d1
	cmp.b	#$90,d1
	bls.s	.vpos

	move.l	#12,leftx

	move.w	babyx,d0
	move.w	babyy,d1
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore


	cmp.w	#40,babytime
	bge	.teil_zwei
	

	move.l	babypointer,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tab2
	lea	2(a0),a0
.end_of_tab2
	move.l	a0,babypointer


	move.w	babyx,d1
	add.w	d2,d1
	move.w	d1,babyx

	move.w	babyy,d1
	sub.w	d2,d1
	move.w	d1,babyy
	
	move.w	babyx,d0
	move.w	babyy,d1
	move.w	#3,d2
	move.w	#26,d3
	move.l	#baby_right,d4
	move.l	#baby_right_m,d5
	bsr	bitblit
	
.noch_nicht

	cmp.w	#28,babytime
	bls	.no_tuut
	
	move.w	#120,d0
	move.w	#100,d1
	move.w	#5,d2
	move.w	#34,d3
	move.l	#tuut,d4
	move.l	#tuut_m,d5
	bsr	bitblit
	
.no_tuut


.teil_zwei

	cmp.w	#40,babytime
	bne	.clr_tuut
	move.w	#120,d0
	move.w	#100,d1
	move.w	#5,d2
	move.w	#34,d3
	bsr	restore
	sub.l	#2,babypointer
.clr_tuut

	cmp.w	#40,babytime
	blt	kein_tuut2
	cmp.w	#70,babytime
	bge	.nix_zeige
	move.w	babyx,d0
	move.w	babyy,d1
	move.w	#3,d2
	move.w	#26,d3
	move.l	#baby_right,d4
	move.l	#baby_right_m,d5
	bsr	bitblit
.nix_zeige
	

	cmp.w	#70,babytime
	blt	kein_tuut2

	move.l	babypointer,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tab3
	lea	-2(a0),a0
.end_of_tab3
	move.l	a0,babypointer

	move.w	babyx,d1
	sub.w	d2,d1
	move.w	d1,babyx

	move.w	babyy,d1
	add.w	d2,d1
	move.w	d1,babyy
	
	move.w	babyx,d0
	move.w	babyy,d1
	move.w	#3,d2
	move.w	#26,d3
	move.l	#baby_right,d4
	move.l	#baby_right_m,d5
	bsr	bitblit

kein_tuut2:	

	;bra	fuckcredits

	cmp.w	#125,timer
	bne	.notclrcred
	move.w	#0,creditsinit	
.notclrcred

	move.w	#0,creditsactive

	cmp.w	#150,timer
	bls	.no_credits
	cmp.w	#360,timer
	bge	.no_credits

	move.w	#1,creditsactive
	
	tst.w	creditsinit
	bne	.is_inited
	move.w	#448,creditsx
	move.w	#-1,creditsinit
	lea	creditsbuffer,a2
	lea	creditsbuffer+480,a3
	move.l	credits,a0
	move.l	credits_m,a1
	clr.l	d0
	move.w	creditsoff,d0
	mulu	#960,d0
	add.l	d0,a0
	add.l	d0,a1
	move.w	#480/4-1,d0
.ccopy
	move.l	(a0)+,(a2)+
	move.l	(a1)+,(a3)+
	dbra	d0,.ccopy
	lea	480(a2),a2
	lea	480(a3),a3
	move.w	#480/4-1,d0
.ccopy2
	move.l	(a0)+,(a2)+
	move.l	(a1)+,(a3)+
	dbra	d0,.ccopy2
	
	add.w	#1,creditsoff	
	cmp.w	#9,creditsoff
	blt	.is_inited
	move.w	#0,creditsoff
.is_inited

	cmp.w	#5,creditsx
	bls	.no_credits

	move.l	#16,leftx

	move.w	#448+8,d0
	sub.w	creditsx,d0
	move.w	#90,d1
	move.w	#8,d2
	move.w	#6,d3
	bsr	restore

	move.w	creditsx,d0
	move.w	#100,d1
	move.w	#8,d2
	move.w	#6,d3
	bsr	restore

	sub.w	#2,creditsx
	move.w	#448+8,d0
	sub.w	creditsx,d0
	move.w	#90,d1
	move.w	#8,d2
	move.w	#6,d3
	move.l	#creditsbuffer,d4
	move.l	#creditsbuffer+480,d5
	bsr	bitblit

	move.w	creditsx,d0
	move.w	#100,d1
	move.w	#8,d2
	move.w	#6,d3
	move.l	#creditsbuffer2,d4
	move.l	#creditsbuffer2+480,d5
	bsr	bitblit

	cmp.w	#400,creditsx
	bls	.nohilfclr1
	move.w	#128+320-48,d0
	move.w	#89,d1
	move.w	#3,d2
	move.w	#6,d3
	bsr	restore
	move.w	#128,d0
	move.w	#100,d1
	move.w	#3,d2
	move.w	#6,d3
	bsr	restore
.nohilfclr1

	cmp.w	#70,creditsx
	bge	.nohilfclr2
	move.w	#128+320-64,d0
	move.w	#99,d1
	move.w	#4,d2
	move.w	#7,d3
	bsr	restore
	move.w	#128,d0
	move.w	#90,d1
	move.w	#3,d2
	move.w	#7,d3
	bsr	restore
.nohilfclr2

		
.no_credits

fuckcredits:

	cmp.w	#370,timer
	bls	dance_only

	cmp.w	#820,timer
	bge	dance_only

	cmp.w	#0,period	;VORSTELLUNG
	bne	keine_vorstellung


	;btst	#7,$bfe001
	;beq	.isfire
	bsr	vposup
.isfire

	;*************************
	;* VOR 1
	;*************************


	cmp.w	#0,what2do
	bne	vor10

	move.l	#0,leftx

	tst.w	initvor
	bne	.no_more_init1
	move.w	#1,initvor
	
	move.w	#150,d1
	bsr	rnd
	add.w	#24,d0
	move.w	d0,blinzler

	
	move.w	#0,vor1ht
	

	move.w	#130,d1
	bsr	rnd
	and.w	#$f0,d0
	move.w	#0,d0
	move.w	d0,vor1off
	
.no_more_init1

	tst.w	initvor
	beq	.zu_frueh


	add.w	#1,vor1ht

	cmp.w	#50,vor1ht
	blt	.zu_frueh
	cmp.w	#50,vor1ht
	bgt	.no_more_init
	move.l	#vor1tab,hpointer
	move.w	#326,vor1y
.no_more_init

	cmp.w	#100,vor1ht
	blt	.no_nicht

	sub.w	#1,blinzler

	cmp.w	#300,vor1ht
	bge	.kein_blinz
	
	cmp.w	#12,blinzler
	bgt	.nix_bl1
	
	lea	blinztab,a0
	move.w	blinzler,d0
	lsr.w	#1,d0
	add.w	d0,d0
	move.w	(a0,d0.w),d0
	move.l	#eyes,d4
	move.l	#eyes_m,d5
	and.l	#$ffff,d0
	add.l	d0,d4
	
	move.w	#48,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	add.w	#5,d1
	move.w	#2,d2
	move.w	#9,d3
	bsr	bitblit	
	
	tst.w	blinzler
	bne	.nix_bl1 

	move.w	#150,d1
	bsr	rnd
	add.w	#24,d0
	move.w	d0,blinzler
.nix_bl1 

.kein_blinz
	
	cmp.w	#110,vor1ht
	bge	.keine_sblase_mehr	;Nur 1 mal Blase kopieren
	move.w	#79,d0
	add.w	vor1off,d0
	move.w	#180,d1
	move.w	#7,d2
	move.w	#51,d3
	move.l	#hungry1,d4
	move.l	#hungry1_m,d5
	bsr	bitblit	


	move.w	#73,d0
	add.w	vor1off,d0
	move.w	#230,d1
	move.w	#3,d2
	move.w	#24,d3
	move.l	#blobs1,d4
	move.l	#blobs1_m,d5
	bsr	bitblit	

.keine_sblase_mehr


	cmp.w	#280,vor1ht
	blt	.noch_ein_bisschen	;Kurz warten dann Blase loeschen
	cmp.w	#290,vor1ht
	bge	.noch_ein_bisschen
	move.w	#79,d0	
	add.w	vor1off,d0
	move.w	#180,d1
	move.w	#7,d2
	move.w	#51,d3
	bsr	restore

	move.w	#73,d0
	add.w	vor1off,d0
	move.w	#230,d1
	move.w	#3,d2
	move.w	#24,d3
	bsr	restore

	move.l	#vor1tabend-2,hpointer
.noch_ein_bisschen


	cmp.w	#300,vor1ht
	blt	.bleibt_noch		;Flups versenken

	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore

	move.l	hpointer,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tab
	lea	-2(a0),a0
.end_of_tab
	move.l	a0,hpointer

	move.w	vor1y,d1
	add.w	d2,d1
	move.w	d1,vor1y

	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#4,d2
	move.w	#71,d3
	move.l	#flupsvunten1,d4
	move.l	#flupsvunten1_m,d5
	bsr	bitblit
	
.bleibt_noch

	bra	.kein_auftauchen_mehr
	
.no_nicht:
	tst.l	hpointer
	beq	.zu_frueh

	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore

	move.l	hpointer,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tab2
	lea	2(a0),a0
.end_of_tab2
	move.l	a0,hpointer

	move.w	vor1y,d1
	sub.w	d2,d1
	move.w	d1,vor1y
	
	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#4,d2
	move.w	#71,d3
	move.l	#flupsvunten1,d4
	move.l	#flupsvunten1_m,d5
	bsr	bitblit

.zu_frueh
.kein_auftauchen_mehr

vor10:



	;*************************
	;* VOR 2
	;*************************


	bra	vor20

	cmp.w	#1,what2do
	bne	vor20

	move.l	#12,leftx

	tst.w	initvor
	bne	.no_more_init1
	move.w	#1,initvor

	move.w	#150,d1
	bsr	rnd
	add.w	#24,d0
	move.w	d0,blinzler
	
	move.w	#0,vor1ht
	

	move.w	#25,vor2x
.no_more_init1

	tst.w	initvor
	beq	.zu_frueh


	add.w	#1,vor1ht

	cmp.w	#50,vor1ht
	blt	.zu_frueh
	cmp.w	#50,vor1ht
	bgt	.no_more_init
	move.l	#vor1tab,hpointer
	move.w	#226,vor1y
.no_more_init


	cmp.w	#300,vor1ht
	bge	.do_copy		;Flups kopieren (fuer Fisch)

	move.w	vor2x,d0
	move.w	vor1y,d1
	;add.w	vor1off,d0
	move.w	#5,d2
	move.w	#76,d3
	;move.l	#flupsschief,d4
	;move.l	#flupsschief_m,d5
	bsr	bitblit

.do_copy

	cmp.w	#100,vor1ht
	blt	.no_nicht


	sub.w	#1,blinzler

	cmp.w	#300,vor1ht
	bge	.kein_blinz

	cmp.w	#12,blinzler
	bgt	.nix_bl1

	lea	blinztab2,a0
	move.w	blinzler,d0
	lsr.w	#1,d0
	add.w	d0,d0
	move.w	(a0,d0.w),d0
	;move.l	#eyes2,d4
	;move.l	#eyes2_m,d5
	and.l	#$ffff,d0
	add.l	d0,d4

	move.w	vor2x,d0
	add.w	#32,d0
	move.w	vor1y,d1
	add.w	#4,d1
	move.w	#2,d2
	move.w	#17,d3
	bsr	bitblit	
	
	tst.w	blinzler
	bne	.nix_bl1 

	move.w	#150,d1
	bsr	rnd
	add.w	#24,d0
	move.w	d0,blinzler
.nix_bl1 

.kein_blinz
	
	cmp.w	#110,vor1ht
	bge	.keine_sblase_mehr	;Nur 1 mal Blase kopieren
	move.w	vor2x,d0
	add.w	#60,d0
	;add.w	vor1off,d0
	move.w	vor1y,d1
	sub.w	#70,d1
	move.w	#7,d2
	move.w	#51,d3
	move.l	#hungry1,d4
	move.l	#hungry1_m,d5
	bsr	bitblit	

	move.w	vor2x,d0
	add.w	#58,d0
	;add.w	vor1off,d0
	move.w	vor1y,d1
	sub.w	#22,d1
	move.w	#3,d2
	move.w	#24,d3
	move.l	#blobs1,d4
	move.l	#blobs1_m,d5
	bsr	bitblit	

.keine_sblase_mehr


	cmp.w	#280,vor1ht
	blt	.noch_ein_bisschen	;Kurz warten dann Blase loeschen
	cmp.w	#290,vor1ht
	bge	.noch_ein_bisschen

	move.w	vor2x,d0
	add.w	#60,d0
	;add.w	vor1off,d0
	move.w	vor1y,d1
	sub.w	#70,d1
	move.w	#7,d2
	move.w	#51,d3
	bsr	restore

	move.w	vor2x,d0
	add.w	#58,d0
	;add.w	vor1off,d0
	move.w	vor1y,d1
	sub.w	#22,d1
	move.w	#3,d2
	move.w	#24,d3
	bsr	restore

	move.l	#vor1tabend-2,hpointer
.noch_ein_bisschen



	cmp.w	#300,vor1ht
	blt	.bleibt_noch		;Flups versenken

	move.w	vor2x,d0
	;add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#5,d2
	move.w	#76,d3
	bsr	restore

	move.l	hpointer,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tab
	lea	-2(a0),a0
.end_of_tab
	move.l	a0,hpointer

	move.w	vor2x,d1
	sub.w	d2,d1
	cmp.w	#30,d1
	bge	.ok_posi
	move.w	#30,d1
.ok_posi
	move.w	d1,vor2x

	move.w	vor1y,d1
	add.w	d2,d1
	move.w	d1,vor1y
	
	move.w	vor2x,d0
	move.w	vor1y,d1
	;add.w	vor1off,d0
	move.w	#5,d2
	move.w	#76,d3
	;move.l	#flupsschief,d4
	;move.l	#flupsschief_m,d5
	bsr	bitblit
	
.bleibt_noch

	bra	.kein_auftauchen_mehr
	
.no_nicht:
	tst.l	hpointer
	beq	.zu_frueh

	move.w	vor2x,d0
	;add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#5,d2
	move.w	#76,d3
	bsr	restore

	move.l	hpointer,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tab2
	lea	2(a0),a0
.end_of_tab2
	move.l	a0,hpointer


	move.w	vor2x,d1
	add.w	d2,d1
	move.w	d1,vor2x

	move.w	vor1y,d1
	sub.w	d2,d1
	move.w	d1,vor1y
	
	move.w	vor2x,d0
	;add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#5,d2
	move.w	#76,d3
	;move.l	#flupsschief,d4
	;move.l	#flupsschief_m,d5
	bsr	bitblit

.zu_frueh
.kein_auftauchen_mehr
	
	bsr	vposdown

vor20:



	;*************************
	;* VOR 3
	;*************************

	cmp.w	#2,what2do
	bne	vor30

	move.l	#0,leftx

	tst.w	initvor
	bne	.no_more_init1
	move.w	#1,initvor


	move.w	#150,d1
	bsr	rnd
	add.w	#24,d0
	move.w	d0,blinzler

	
	move.w	#0,vor1ht
	

	move.w	#130,d1
	bsr	rnd
	and.w	#$f0,d0
	move.w	d0,vor1off
	
.no_more_init1

	tst.w	initvor
	beq	.zu_frueh

	add.w	#1,vor1ht

	cmp.w	#50,vor1ht
	blt	.zu_frueh
	cmp.w	#50,vor1ht
	bgt	.no_more_init
	move.l	#vor1tab,hpointer
	move.w	#0,vor1y
.no_more_init

	cmp.w	#100,vor1ht
	blt	.no_nicht

	sub.w	#1,blinzler

	cmp.w	#300,vor1ht
	bge	.kein_blinz
	
	cmp.w	#12,blinzler
	bgt	.nix_bl1
	
	lea	blinztab,a0
	move.w	blinzler,d0
	lsr.w	#1,d0
	add.w	d0,d0
	move.w	(a0,d0.w),d0
	move.l	#eyes,d4
	move.l	#eyes_m,d5
	and.l	#$ffff,d0
	add.l	d0,d4
	
	move.w	#48,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	add.w	#5,d1
	move.w	#2,d2
	move.w	#9,d3
	;bsr	bitblit	
	
	tst.w	blinzler
	bne	.nix_bl1 

	move.w	#150,d1
	bsr	rnd
	add.w	#24,d0
	move.w	d0,blinzler
.nix_bl1 

.kein_blinz
	
	cmp.w	#281,vor1ht
	bge	.keine_sblase_mehr	;Nur 1 mal Blase kopieren
	move.w	#75,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	add.w	#90,d1
	move.w	#7,d2
	move.w	#51,d3
	move.l	#welcome,d4
	move.l	#welcome_m,d5
	bsr	bitblit	

	move.w	#70,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	add.w	#70,d1
	move.w	#3,d2
	move.w	#24,d3
	move.l	#blobs2,d4
	move.l	#blobs2_m,d5
	bsr	bitblit	

.keine_sblase_mehr


	cmp.w	#280,vor1ht
	blt	.noch_ein_bisschen	;Kurz warten dann Blase loeschen
	cmp.w	#290,vor1ht
	bge	.noch_ein_bisschen
	move.w	#75,d0	
	add.w	vor1off,d0
	move.w	vor1y,d1
	add.w	#90,d1
	move.w	#7,d2
	move.w	#51,d3
	bsr	restore

	move.w	#70,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	add.w	#70,d1
	move.w	#3,d2
	move.w	#24,d3
	bsr	restore

	move.l	#vor1tabend-2,hpointer
.noch_ein_bisschen


	cmp.w	#300,vor1ht
	blt	.bleibt_noch		;Flups versenken

	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	sub.w	#1,d1
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore

	move.l	hpointer,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tab
	lea	-2(a0),a0
.end_of_tab
	move.l	a0,hpointer

	move.w	vor1y,d1
	sub.w	d2,d1
	move.w	d1,vor1y

	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	sub.w	#1,d1
	move.w	#3,d2
	move.w	#71,d3
	move.l	#flupsvoben,d4
	move.l	#flupsvoben_m,d5
	bsr	bitblit
	
.bleibt_noch

	bra	.kein_auftauchen_mehr
	
.no_nicht:
	tst.l	hpointer
	beq	.zu_frueh

	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	sub.w	#1,d1
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore

	move.l	hpointer,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tab2
	lea	2(a0),a0
.end_of_tab2
	move.l	a0,hpointer

	move.w	vor1y,d1
	add.w	d2,d1
	move.w	d1,vor1y

	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	sub.w	#1,d1
	move.w	#3,d2
	move.w	#71,d3
	move.l	#flupsvoben,d4
	move.l	#flupsvoben_m,d5
	bsr	bitblit

.zu_frueh
.kein_auftauchen_mehr

	bsr	vposdown

vor30:





	;*************************
	;* VOR 4
	;*************************

	cmp.w	#3,what2do
	bne	vor40


	move.l	#0,leftx

	tst.w	initvor
	bne	.no_more_init1
	move.w	#1,initvor

	move.w	#150,d1
	bsr	rnd
	add.w	#24,d0
	move.w	d0,blinzler

	
	move.w	#0,vor1ht
	

	move.w	#130,d1
	bsr	rnd
	and.w	#$f0,d0
	move.w	d0,vor1off

	move.l	#eyetab4,eyepointer4
.no_more_init1

	tst.w	initvor
	beq	.zu_frueh

	add.w	#1,vor1ht

	cmp.w	#50,vor1ht
	blt	.zu_frueh
	cmp.w	#50,vor1ht
	bgt	.no_more_init
	move.l	#vor1tab,hpointer
	move.l	#vor2tab,hpointer2
	move.w	#326,vor1y
	move.w	#250,vor4y
.no_more_init

	cmp.w	#100,vor1ht
	blt	.no_nicht

	cmp.w	#150,vor1ht
	bge	.no_son_up

	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor4y,d1
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore

	move.l	hpointer2,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tab3
	lea	2(a0),a0
.end_of_tab3
	move.l	a0,hpointer2

	move.w	vor4y,d1
	sub.w	d2,d1
	move.w	d1,vor4y
	
	move.w	#43,d0
	add.w	vor1off,d0
	move.w	vor4y,d1
	add.w	#7,d1
	move.w	#2,d2
	move.w	#24,d3
	move.l	#flupsson,d4
	move.l	#flupsson_m,d5
	bsr	bitblit

	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#4,d2
	move.w	#71,d3
	move.l	#flupsvunten1,d4
	move.l	#flupsvunten1_m,d5
	bsr	bitblit


.no_son_up



	move.l	eyepointer4,a0
	move.w	4(a0),d0
	tst.w	d0
	beq	.no_more_eyes

	move.w	2(a0),d4

	cmp.w	vor1ht,d0
	bne	.take_old
	add.l	#4,eyepointer4
.take_old
	
	mulu	#9*4*5,d4
	move.l	d4,d5
	
	move.w	#48,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	add.w	#5,d1
	move.w	#2,d2
	move.w	#9,d3
	add.l	#eyes,d4
	move.l	#eyes_m,d5
	bsr	bitblit


.no_more_eyes

	cmp.w	#150,vor1ht
	bls	.wait_4_blase


	cmp.w	#331,vor1ht
	bge	.keine_sblase_mehr	;Nur 1 mal Blase kopieren
	move.w	#65,d0
	add.w	vor1off,d0
	move.w	#155,d1
	move.w	#7,d2
	move.w	#51,d3
	move.l	#hungry2,d4
	move.l	#hungry2_m,d5
	bsr	bitblit	

	move.w	#65,d0
	add.w	vor1off,d0
	move.w	#205,d1
	move.w	#3,d2
	move.w	#24,d3
	move.l	#blobs1,d4
	move.l	#blobs1_m,d5
	bsr	bitblit	

.keine_sblase_mehr


	cmp.w	#330,vor1ht
	blt	.noch_ein_bisschen	;Kurz warten dann Blase loeschen
	cmp.w	#340,vor1ht
	bge	.noch_ein_bisschen
	move.w	#65,d0	
	add.w	vor1off,d0
	move.w	#155,d1
	move.w	#7,d2
	move.w	#51,d3
	bsr	restore

	move.w	#65,d0
	add.w	vor1off,d0
	move.w	#205,d1
	move.w	#3,d2
	move.w	#24,d3
	bsr	restore

	move.l	#vor3tabend-2,hpointer2
	move.l	#vor1tabend-2,hpointer
.noch_ein_bisschen

.wait_4_blase


	cmp.w	#350,vor1ht
	blt	.son_bleibt_noch	;son versenken

	cmp.w	#400,vor1ht
	bge	.son_bleibt_noch	;Ende son

	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor4y,d1
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore

	move.l	hpointer2,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tab4
	lea	-2(a0),a0
.end_of_tab4
	move.l	a0,hpointer2

	move.w	vor4y,d1
	add.w	d2,d1
	move.w	d1,vor4y
	
.son_bleibt_noch


	cmp.w	#350,vor1ht
	blt	.bleibt_noch		;Flups versenken

	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore

	move.l	hpointer,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tab
	lea	-2(a0),a0
.end_of_tab
	move.l	a0,hpointer

	move.w	vor1y,d1
	add.w	d2,d1
	move.w	d1,vor1y

	move.w	#43,d0
	add.w	vor1off,d0
	move.w	vor4y,d1
	add.w	#7,d1
	move.w	#2,d2
	move.w	#24,d3
	move.l	#flupsson,d4
	move.l	#flupsson_m,d5
	bsr	bitblit
	
	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#4,d2
	move.w	#71,d3
	move.l	#flupsvunten1,d4
	move.l	#flupsvunten1_m,d5
	bsr	bitblit
	
.bleibt_noch

	bra	.kein_auftauchen_mehr
	
.no_nicht:
	tst.l	hpointer
	beq	.zu_frueh

	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore

	move.l	hpointer,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tab2
	lea	2(a0),a0
.end_of_tab2
	move.l	a0,hpointer

	move.w	vor1y,d1
	sub.w	d2,d1
	move.w	d1,vor1y
	
	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#4,d2
	move.w	#71,d3
	move.l	#flupsvunten1,d4
	move.l	#flupsvunten1_m,d5
	bsr	bitblit

.zu_frueh
.kein_auftauchen_mehr

	bsr	vposdown
vor40:





	;*************************
	;* VOR 5
	;*************************

	cmp.w	#4,what2do
	bne	vor50

	move.l	#12,leftx

	tst.w	initvor
	bne	.no_more_init1
	move.w	#1,initvor


	move.w	#150,d1
	bsr	rnd
	add.w	#24,d0
	move.w	d0,blinzler

	
	move.w	#0,vor1ht
	

	move.w	#212,vor1off
	move.l	#eyetab5,eyepointer4	
	move.l	#fruittab5,fruitpointer

	move.w	#56,fruitx
	move.w	#140,fruity
.no_more_init1

	tst.w	initvor
	beq	.zu_frueh

	add.w	#1,vor1ht

	cmp.w	#50,vor1ht
	blt	.zu_frueh
	cmp.w	#50,vor1ht
	bgt	.no_more_init
	move.l	#vor1tab,hpointer
	move.w	#326,vor1y
.no_more_init


	cmp.w	#70,vor1ht
	blt	.no_nicht

	move.l	eyepointer4,a0
	move.w	4(a0),d0
	tst.w	d0
	beq	.no_more_eyes

	move.w	2(a0),d4

	cmp.w	vor1ht,d0
	bne	.take_old
	add.l	#4,eyepointer4
.take_old
	
	mulu	#9*4*5,d4
	move.l	d4,d5
	
	move.w	#48,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	add.w	#5,d1
	move.w	#2,d2
	move.w	#9,d3
	add.l	#eyes,d4
	move.l	d4,lasteye
	move.l	#eyes_m,d5
	bsr	bitblit

.no_more_eyes


	cmp.w	#100,vor1ht
	blt	.no_nicht


	move.l	fruitpointer,a0
	cmp.l	#fruittabend,a0
	beq	.endfruit


	move.w	fruitx,d0
	move.w	fruity,d1
	move.w	#4,d2
	move.w	#37,d3
	move.l	#smallfruit,d4
	move.l	#smallfruit_m,d5
	bsr	restore


	cmp.w	#150,vor1ht
	bls	.nix_rund
	cmp.w	#198,vor1ht
	bge	.nix_rund

	move.w	#33+11,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	add.w	#24,d1
	move.w	#4,d2
	move.w	#11,d3
	move.l	#Mundrund,d4
	move.l	#Mundmask,d5
	bsr	bitblit

.nix_rund

	cmp.w	#198,vor1ht
	bls	.nix_stauch
	cmp.w	#202,vor1ht
	bge	.nix_stauch


	
	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	sub.w	#5,d1
	move.w	#4,d2
	move.w	#50,d3
	bsr	restore

	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	add.w	#0,d1
	move.w	#4,d2
	move.w	#50,d3
	move.l	#flupsvunten2,d4
	move.l	#flupsvunten2_m,d5
	bsr	bitblit

.nix_stauch

	cmp.w	#202,vor1ht
	blt	.nix_Kopf
	cmp.w	#210,vor1ht
	bge	.nix_Kopf


	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	sub.w	#5,d1
	move.w	#4,d2
	move.w	#50,d3
	bsr	restore

	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#4,d2
	move.w	#50,d3
	move.l	#flupsvunten1,d4
	move.l	#flupsvunten1_m,d5
	bsr	bitblit

	move.w	#22,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	add.w	#23,d1
	move.w	#6,d2
	move.w	#13,d3
	move.l	#flups_dick+12*5*23,d4
	move.l	#flups_dick_m+12*5*23,d5
	bsr	bitblit


.nix_Kopf

	move.w	#2,d0
	move.w	(a0)+,d1
	move.l	a0,fruitpointer
	add.w	d0,fruitx
	add.w	d1,fruity
	
	move.w	fruitx,d0
	move.w	fruity,d1
	move.w	#4,d2
	move.w	#37,d3
	move.l	#smallfruit,d4
	move.l	#smallfruit_m,d5
	bsr	bitblit


	cmp.w	#196,vor1ht
	bls	.nix_blitz
	cmp.w	#200,vor1ht
	bgt	.nix_blitz

	move.w	#41,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	sub.w	#12,d1
	move.w	#4,d2
	move.w	#18,d3
	move.l	#headcrash,d4
	move.l	#headcrash_m,d5
	bsr	bitblit

.nix_blitz

.endfruit



	cmp.w	#230,vor1ht
	blt	.noch_ein_bisschen
	cmp.w	#235,vor1ht
	bge	.noch_ein_bisschen

	move.l	#vor4tabend-2,hpointer
.noch_ein_bisschen



	cmp.w	#240,vor1ht
	blt	.bleibt_noch		;Flups versenken

	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore

	move.l	hpointer,a0
	move.w	(a0),d2
	cmp.w	#-1,d2
	beq	.end_of_tab2
	lea	-2(a0),a0
	bra	.end_of_tab
.end_of_tab2
	move.w	#0,d2
.end_of_tab
	
	move.l	a0,hpointer

	move.w	vor1y,d1
	add.w	d2,d1
	move.w	d1,vor1y
	
	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#4,d2
	move.w	#71,d3
	move.l	#flupsvunten1,d4
	move.l	#flupsvunten1_m,d5
	bsr	bitblit

	move.w	#22,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	add.w	#23,d1
	move.w	#6,d2
	move.w	#13,d3
	move.l	#flups_dick+12*5*23,d4
	move.l	#flups_dick_m+12*5*23,d5
	bsr	bitblit

	move.w	#48,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	add.w	#5,d1
	move.w	#2,d2
	move.w	#9,d3
	move.l	lasteye,d4
	move.l	#eyes_m,d5
	bsr	bitblit
	
.bleibt_noch

	bra	.kein_auftauchen_mehr

	
.no_nicht:
	cmp.w	#70,vor1ht
	bge	.zu_frueh

	tst.l	hpointer
	beq	.zu_frueh

	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore

	move.l	hpointer,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tabxx
	lea	2(a0),a0
.end_of_tabxx
	move.l	a0,hpointer

	move.w	vor1y,d1
	sub.w	d2,d1
	move.w	d1,vor1y
	
	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#4,d2
	move.w	#71,d3
	move.l	#flupsvunten1,d4
	move.l	#flupsvunten1_m,d5
	bsr	bitblit

.zu_frueh
.kein_auftauchen_mehr

	bsr	vposdown
vor50:



	;*************************
	;* VOR 6
	;*************************

	cmp.w	#5,what2do
	bne	vor60

jojo:

	move.l	#0,leftx

	tst.w	initvor
	bne	.no_more_init1
	move.w	#1,initvor


	move.w	#150,d1
	bsr	rnd
	add.w	#24,d0
	move.w	d0,blinzler

	
	move.w	#0,vor1ht
	

	move.w	#130,d1
	bsr	rnd
	and.w	#$f0,d0
	move.w	d0,vor1off
	
.no_more_init1

	tst.w	initvor
	beq	.zu_frueh


	add.w	#1,vor1ht

	cmp.w	#50,vor1ht
	blt	.zu_frueh
	cmp.w	#50,vor1ht
	bgt	.no_more_init
	move.l	#vor1tab,hpointer
	move.w	#326,vor1y
.no_more_init

	cmp.w	#100,vor1ht
	blt	.no_nicht



	cmp.w	#280,vor1ht
	blt	.noch_ein_bisschen
	cmp.w	#290,vor1ht
	bge	.noch_ein_bisschen

	move.l	#vor1tabend-2,hpointer
.noch_ein_bisschen



	cmp.w	#300,vor1ht
	blt	.bleibt_noch		;Flups versenken

	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore

	move.l	hpointer,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tab
	lea	-2(a0),a0
.end_of_tab
	move.l	a0,hpointer

	move.w	vor1y,d1
	add.w	d2,d1
	move.w	d1,vor1y
	
	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#4,d2
	move.w	#71,d3
	move.l	#flupsvunten1,d4
	move.l	#flupsvunten1_m,d5
	bsr	bitblit
	
.bleibt_noch

	bra	.kein_auftauchen_mehr
	
.no_nicht:
	tst.l	hpointer
	beq	.zu_frueh

	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore

	move.l	hpointer,a0
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	.end_of_tab2
	lea	2(a0),a0
.end_of_tab2
	move.l	a0,hpointer

	move.w	vor1y,d1
	sub.w	d2,d1
	move.w	d1,vor1y
	
	move.w	#33,d0
	add.w	vor1off,d0
	move.w	vor1y,d1
	move.w	#4,d2
	move.w	#71,d3
	move.l	#flupsvunten1,d4
	move.l	#flupsvunten1_m,d5
	bsr	bitblit

.zu_frueh
.kein_auftauchen_mehr

vor60:

	bra	nach_vorstellung
			
keine_vorstellung:	



dance_only:

	;btst	#7,$bfe001
	;beq	.isfire

	tst.w	creditsactive
	beq	.doch_dieser

	bsr	vposup2
	
.yvpos
	move.w	$dff006,d1
	lsr.w	#8,d1
	cmp.b	#$60,d1
	bls.s	.yvpos

	bra	.isfire

.doch_dieser

	tst.w	initverfolg
	bne	.isfire

	bsr	vposdown
.vpos
	move.w	$dff006,d1
	lsr.w	#8,d1
	cmp.b	#$27,d1
	bls.s	.vpos
.isfire


dancing:

	cmp.w	#1770,timer
	bge	nach_vorstellung

	cmp.w	#50,timer
	bne	.not_fifty

	move.l	#0,dancetimer

	lea	dancetab,a3
	
	move.l	(a3)+,a0
	
	lea	tabpointer1,a2
	move.l	a0,(a2)		;tabpointer
	move.w	2(a0),4(a2)	;status
	move.w	#0,10(a2)	;timer
	move.w	#16,6(a2)	;xpos
	move.w	#326,8(a2)	;ypos
	move.w	#0,12(a2)	;seqcounter
	move.w	#1,18(a2)	;extra
	move.w	#0,20(a2)	;mynum
	move.w	#0,22(a2)
	move.w	#0,28(a2)
	bsr	initdance

	move.l	(a3)+,a0
	lea	tabpointer2,a2
	move.l	a0,(a2)		;tabpointer
	move.w	2(a0),4(a2)	;status
	move.w	#0,10(a2)	;timer
	move.w	#96,6(a2)	;xpos
	move.w	#326,8(a2)	;ypos
	move.w	#0,12(a2)	;seqcounter
	move.w	#2,18(a2)	;extra
	move.w	#1,20(a2)	;mynum
	move.w	#0,22(a2)
	move.w	#0,28(a2)
	bsr	initdance

	move.l	(a3)+,a0
	lea	tabpointer3,a2
	move.l	a0,(a2)		;tabpointer
	move.w	2(a0),4(a2)	;status
	move.w	#0,10(a2)	;timer
	move.w	#176,6(a2)	;xpos
	move.w	#326,8(a2)	;ypos
	move.w	#0,12(a2)	;seqcounter
	move.w	#3,18(a2)	;extra
	move.w	#2,20(a2)	;mynum
	move.w	#0,22(a2)
	move.w	#0,28(a2)
	bsr	initdance

	move.l	(a3)+,a0
	lea	tabpointer4,a2
	move.l	a0,(a2)		;tabpointer
	move.w	2(a0),4(a2)	;status
	move.w	#0,10(a2)	;timer
	move.w	#256,6(a2)	;xpos
	move.w	#326,8(a2)	;ypos
	move.w	#0,12(a2)	;seqcounter
	move.w	#4,18(a2)	;extra
	move.w	#3,20(a2)	;mynum
	move.w	#0,22(a2)
	move.w	#0,28(a2)
	bsr	initdance

.not_fifty

	cmp.w	#850,timer
	bls	.no_early
	add.w	#1,dancetimer

	lea	tabpointer1,a2
	bsr	dodance
	lea	tabpointer2,a2
	bsr	dodance
	lea	tabpointer3,a2
	bsr	dodance
	lea	tabpointer4,a2
	bsr	dodance

.no_early


nach_vorstellung:

	btst	#7,$bfe001
	bne	main


cleanup:
	bsr	music_off
	move.l  savea7,a7

	move.l	gfxbase,a6
	jsr	-228(a6)
	jsr	disownblitter(a6)

	;bsr	mt_end
	move.w 	#$0008,dmacon(a5)
	move.l	4,a6
	jsr	permit(a6)
	bsr	oldcopper
	move.l	4.w,a6
	move.l	save4clr,a1
	move.l	#BITMAP,d0
	jsr	freemem(a6)
	move.l	mt_data,a1
	move.l	#52400,d0
	jsr	freemem(a6)
	move.l	logobuffer,a1
	move.l	#58750,d0
	jsr	freemem(a6)
	move.l	credits,a1
	move.l	#8640,d0
	jsr	freemem(a6)
	move.l	credits_m,a1
	move.l	#8640,d0
	jsr	freemem(a6)
	move.l	titel,a1
	move.l	#12510,d0
	jsr	freemem(a6)

	move.l  gfxbase,a1
        move.l  4,a6
	jsr	closelibrary(a6)

	move.l	#0,d0
	rts	

volume:	dc.w	30

flugmotor:
	lea	$dff000,a5
	move.w 	#$0008,dmacon(a5)
	move.l	motor,d0
	add.l	#100,d0
	move.l	d0,aud0lc(a5)
	move.w	#2128,aud0len(a5)
	move.w	volume,aud0vol(a5)
	move.w	#1010,aud0per(a5)
	move.w	#$00ff,adkcon(a5)

	move.l	d0,aud1lc(a5)
	move.w	#2128,aud1len(a5)
	move.w	volume,aud1vol(a5)
	move.w	#1000,aud1per(a5)
	move.w	#$00ff,adkcon(a5)

	move.l	d0,aud2lc(a5)
	move.w	#2128,aud2len(a5)
	move.w	volume,aud2vol(a5)
	move.w	#990,aud2per(a5)
	move.w	#$00ff,adkcon(a5)

	move.w	#$8207,dmacon(a5)
	rts


soundoff:
	move.w 	#$000f,dmacon(a5)
	move.l	#stopsnd,aud0lc(a5)
	move.w	#2,aud0len(a5)
	move.l	#stopsnd,aud1lc(a5)
	move.w	#2,aud1len(a5)
	move.l	#stopsnd,aud2lc(a5)
	move.w	#2,aud2len(a5)
	move.l	#stopsnd,aud3lc(a5)
	move.w	#2,aud3len(a5)	
	move.w 	#$800f,dmacon(a5)

	move.w	#10,d7
.aaddbb
	bsr	vposup
	sub.w	#1,d7
	bne	.aaddbb
	rts

	
do_donner:
	move.w 	#$0003,dmacon(a5)
	bsr	vposup

	move.l	donner,d0
	add.l	#100,d0
	move.l	d0,aud0lc(a5)
	move.w	#2410/2,aud0len(a5)
	move.w	#64,aud0vol(a5)
	move.w	#880,aud0per(a5)
	move.w	#$00ff,adkcon(a5)

	move.l	d0,aud1lc(a5)
	move.w	#2410/2,aud1len(a5)
	move.w	#64,aud1vol(a5)
	move.w	#880,aud1per(a5)
	move.w	#$00ff,adkcon(a5)

	bsr	vposdown
	
	move.w	#$8203,dmacon(a5)

	bsr	vposup

	move.l	#stopsnd,aud0lc(a5)
	move.w	#2,aud0len(a5)
	move.l	#stopsnd,aud1lc(a5)
	move.w	#2,aud1len(a5)


	rts

wackel:
	move.w	waoff,d0
	lea	watab,a0
	move.w	(a0,d0.w),d1
	cmp.w	#$4711,d1
	beq	.endwa

	add.w	#2,waoff
	
	add.w	#10,d1

	move.l	bitplanes,d0
	add.l	#48*5*20,d0

	mulu	#48*5,d1
	add.l	d1,d0
	sub.l	#48*5*10,d0
	move.l	wasave,a0
	move.w	d0,planes+6
	swap	d0
	move.w	d0,planes+2
	swap	d0
	add.l	#48,d0
	move.w	d0,planes+14
	swap	d0
	move.w	d0,planes+10
	swap	d0
	add.l	#48,d0
	move.w	d0,planes+22
	swap	d0
	move.w	d0,planes+18
	swap	d0
	add.l	#48,d0
	move.w	d0,planes+30
	swap	d0
	move.w	d0,planes+26
	swap	d0
	add.l	#48,d0
	move.w	d0,planes+38
	swap	d0
	move.w	d0,planes+34
.endwa	
	rts	
	
waoff:	dc.w	0
watab:	dc.w	-1,-2,-3,-3,-2,-1,0,1,1,0,0,0
	dc.w	$4711
	
wasave:	dc.l	0

music_on:
	move.l	$6c.w,oldvbl+2
	move.l	#newvbl,$6c.w
	rts
	
music_off:
	move.l	oldvbl+2,$6c.w
	bsr	mt_end
	rts	
	
	
	
newvbl:
	movem.l	d0-d7/a0-a6,-(sp)
	bsr	mt_music
	movem.l	(sp)+,d0-d7/a0-a6
oldvbl:
	jmp	0




dodance:	
	move.l	#12,leftx

	move.w	dancetimer,d0
	cmp.w	10(a2),d0
	blt	check_neu

	cmp.w	#1,4(a2)	;status
	bne	nix_auftauchen_1

	
	tst.w	12(a2)		;seqcounter
	bne	.init_done
	move.w	#1,12(a2)	;seqcounter
	move.l	#vor5tab,14(a2)	;htabpointer
.init_done

	move.l	14(a2),a0	;htabpointer
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	nix_auftauchen_1

	move.w	6(a2),d0	;xpos
	move.w	8(a2),d1	;ypos
	add.w	#96,d0
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore

	bsr	restoreextra
	
	move.l	14(a2),a0	;htabpointer
	move.w	(a0),d2
	lea	2(a0),a0
.end_of_tab2
	move.l	a0,14(a2)	;htabpointer

	move.w	8(a2),d1	;ypos
	sub.w	d2,d1
	move.w	d1,8(a2)	;ypos
	
	move.w	6(a2),d0	;xpos
	move.w	8(a2),d1	;ypos
	add.w	#96,d0
	move.w	#4,d2
	move.w	#71,d3
	move.l	#flupsvunten1,d4
	move.l	#flupsvunten1_m,d5
	bsr	bitblit

	bsr	put_extra

nix_auftauchen_1:


	cmp.w	#2,4(a2)	;status
	bne	nix_abtauchen_1

	
	tst.w	12(a2)		;seqcounter
	bne	.init_done
	move.w	#1,12(a2)	;seqcounter
	move.l	#vor5tabend-2,14(a2)
.init_done

	move.l	14(a2),a0	;htabpointer
	move.w	(a0),d2
	cmp.w	#0,d2
	beq	nix_abtauchen_1

	move.w	6(a2),d0	;xpos
	move.w	8(a2),d1	;ypos
	add.w	#96,d0
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore

	bsr	restoreextra


	move.l	14(a2),a0	;htabpointer
	move.w	(a0),d2
	lea	-2(a0),a0
.end_of_tab2
	move.l	a0,14(a2)	;htabpointer

	move.w	8(a2),d1	;ypos
	add.w	d2,d1
	move.w	d1,8(a2)	;ypos
	
	move.w	6(a2),d0	;xpos
	move.w	8(a2),d1	;ypos
	add.w	#96,d0
	move.w	#4,d2
	move.w	#71,d3
	move.l	#flupsvunten1,d4
	move.l	#flupsvunten1_m,d5
	bsr	bitblit
	
	bsr	put_extra

nix_abtauchen_1


	cmp.w	#20,4(a2)	;status
	bne	nix_dance_normal

	tst.w	12(a2)		;seqcounter
	bne	nix_dance_normal
	move.w	#1,12(a2)	;seqcounter

	move.w	6(a2),d0	;xpos
	move.w	8(a2),d1	;ypos
	add.w	#96,d0
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore

	bsr	restoreextra

	move.w	6(a2),d0	;xpos
	move.w	8(a2),d1	;ypos
	add.w	#96,d0
	move.w	#4,d2
	move.w	#71,d3
	move.l	#flupsvunten1,d4
	move.l	#flupsvunten1_m,d5
	bsr	bitblit

	bsr	put_extra
nix_dance_normal:



	cmp.w	#21,4(a2)	;status
	bne	nix_dance_unten

	tst.w	12(a2)		;seqcounter
	bne	nix_dance_unten
	move.w	#1,12(a2)	;seqcounter

	move.w	6(a2),d0	;xpos
	move.w	8(a2),d1	;ypos
	add.w	#96,d0
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore

	bsr	restoreextra

	move.w	6(a2),d0	;xpos
	move.w	8(a2),d1	;ypos
	add.w	#96,d0
	move.w	#4,d2
	move.w	#71,d3
	move.l	#flupsvunten2,d4
	move.l	#flupsvunten2_m,d5
	bsr	bitblit
	
	add.w	#4,8(a2)
	bsr	put_extra
	sub.w	#4,8(a2)
nix_dance_unten:


	cmp.w	#22,4(a2)	;status
	bne	nix_dance_left

	tst.w	12(a2)		;seqcounter
	bne	nix_dance_left
	move.w	#1,12(a2)	;seqcounter

	move.w	6(a2),d0	;xpos
	move.w	8(a2),d1	;ypos
	add.w	#96,d0
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore

	bsr	restoreextra

	move.w	6(a2),d0	;xpos
	move.w	8(a2),d1	;ypos
	add.w	#96,d0
	move.w	#4,d2
	move.w	#71,d3
	move.l	#danceleft,d4
	move.l	#danceleft_m,d5
	bsr	bitblit
	
	
	add.w	#8,8(a2)
	sub.w	#11,6(a2)
	bsr	put_extra
	add.w	#11,6(a2)
	sub.w	#8,8(a2)
nix_dance_left:

	cmp.w	#23,4(a2)	;status
	bne	nix_dance_right

	tst.w	12(a2)		;seqcounter
	bne	nix_dance_right
	move.w	#1,12(a2)	;seqcounter

	move.w	6(a2),d0	;xpos
	move.w	8(a2),d1	;ypos
	add.w	#96,d0
	move.w	#4,d2
	move.w	#71,d3
	bsr	restore

	bsr	restoreextra

	move.w	6(a2),d0	;xpos
	move.w	8(a2),d1	;ypos
	add.w	#96,d0
	move.w	#4,d2
	move.w	#71,d3
	move.l	#danceright,d4
	move.l	#danceright_m,d5
	bsr	bitblit
	
	
	add.w	#8,8(a2)
	add.w	#11,6(a2)
	bsr	put_extra
	sub.w	#11,6(a2)
	sub.w	#8,8(a2)
nix_dance_right:


	move.l	#0,leftx

check_neu:
	move.l	(a2),a0
	move.w	(a0),d0
	tst.w	d0
	bpl	.positiv
	neg.w	d0
	add.w	#1,d0
.positiv
	add.w	22(a2),d0
	cmp.w	dancetimer,d0
	bne	no_switch

initdance:
	move.l	(a2),a0		;tabpointer1
	move.w	(a0),d5
	move.w	2(a0),4(a2)	;status
	move.w	#0,d0
	tst.w	d5
	bpl	no_diff
	not.w	d5
	add.w	#1,d5

	
	move.w	20(a2),d0
	cmp.w	#20,4(a2)
	bge	less_diff
	lea	difftab1,a1
	add.w	d0,d0
	move.w	(a1,d0.w),d0	
	bra	adddiff
less_diff:
	lea	difftab2,a1
	add.w	d0,d0
	move.w	(a1,d0.w),d0	
adddiff:
no_diff:
	add.w	d5,22(a2)
	move.w	d0,d5	;timer

	
	move.w	20(a2),d0
	and.w	#%1,d0
	add.w	d0,d5		;timer ungerade machen
	
	add.w	#1,d5

	move.w	22(a2),10(a2)
	add.w	d5,10(a2)	;timer

	add.l	#4,a0
	move.l	a0,(a2)		;tabpointer1
	move.w	#0,12(a2)	;seqcounter
no_switch:

	rts

difftab1:	dc.w	0,15,30,45
difftab2:	dc.w	0,10,20,30



restoreextra:
	tst.w	28(a2)
	beq	.nix_ex_res
	move.w	24(a2),d0
	move.w	26(a2),d1
	move.w	#4,d2
	move.w	28(a2),d3
	bsr	restore
.nix_ex_res
	rts

put_extra:
	move.w	18(a2),d0	;extra

	cmp.w	#7,d0
	bne	.not_brille
	move.w	6(a2),d0
	move.w	8(a2),d1
	add.w	#96,d0
	add.w	#15,d0
	add.w	#5,d1
	move.w	d0,24(a2)
	move.w	d1,26(a2)
	move.w	#3,d2
	move.w	#9,d3
	move.w	d3,28(a2)
	move.l	#Brille,d4
	move.l	#Brille_m,d5
	bsr	bitblit	
.not_brille

	cmp.w	#1,d0
	bne	.not_krautkopf
	move.w	6(a2),d0
	move.w	8(a2),d1
	add.w	#96,d0
	add.w	#5,d0
	sub.w	#4,d1
	move.w	d0,24(a2)
	move.w	d1,26(a2)
	move.w	#4,d2
	move.w	#16,d3
	move.w	d3,28(a2)
	move.l	#faces,d4
	move.l	#faces_m,d5
	bsr	bitblit	
.not_krautkopf

	cmp.w	#2,d0
	bne	.not_zipfelmuetz
	move.w	6(a2),d0
	move.w	8(a2),d1
	add.w	#96,d0
	add.w	#5,d0
	sub.w	#10,d1
	move.w	d0,24(a2)
	move.w	d1,26(a2)
	move.w	#4,d2
	move.w	#25,d3
	move.w	d3,28(a2)
	move.l	#faces+8*5*16,d4
	move.l	#faces_m+8*5*16,d5
	bsr	bitblit	
.not_zipfelmuetz

	cmp.w	#3,d0
	bne	.not_Fraulein
	move.w	6(a2),d0
	move.w	8(a2),d1
	add.w	#96,d0
	add.w	#5,d0
	sub.w	#5,d1
	move.w	d0,24(a2)
	move.w	d1,26(a2)
	move.w	#4,d2
	move.w	#19,d3
	move.w	d3,28(a2)
	move.l	#faces+8*5*41,d4
	move.l	#faces_m+8*5*41,d5
	bsr	bitblit	
.not_Fraulein

	cmp.w	#4,d0
	bne	.not_Gentleman
	move.w	6(a2),d0
	move.w	8(a2),d1
	add.w	#96,d0
	add.w	#5,d0
	sub.w	#6,d1
	move.w	d0,24(a2)
	move.w	d1,26(a2)
	move.w	#4,d2
	move.w	#16,d3
	move.w	d3,28(a2)
	move.w	d3,28(a2)
	move.l	#faces+8*5*60,d4
	move.l	#faces_m+8*5*60,d5
	bsr	bitblit	
	move.w	6(a2),d0
	move.w	8(a2),d1
	add.w	#96,d0
	add.w	#5,d0
	add.w	#23,d1
	move.w	#4,d2
	move.w	#5,d3
	move.l	#faces+8*5*96,d4
	move.l	#faces_m+8*5*96,d5
	bsr	bitblit	

.not_Gentleman

	cmp.w	#8,d0
	bne	.not_Fliegermann
	move.w	6(a2),d0
	move.w	8(a2),d1
	add.w	#96,d0
	add.w	#5,d0
	sub.w	#2,d1
	move.w	#4,d2
	move.w	d0,24(a2)
	move.w	d1,26(a2)
	move.w	#20,d3
	move.w	d3,28(a2)
	move.l	#faces+8*5*76,d4
	move.l	#faces_m+8*5*76,d5
	bsr	bitblit	
.not_Fliegermann

	rts


dancetimer:	dc.w	0

tabpointer1:	dc.l	0	;+0
status1:	dc.w	0	;+4
xpos1:		dc.w	0	;+6
ypos1:		dc.w	0	;+8
timer1:		dc.w	0	;+10
seqcounter:	dc.w	0	;+12
htabpointer:	dc.l	0	;+14
extra1:		dc.w	0	;+18
mynum1:		dc.w	0	;+20
htime1:		dc.w	0	;+22
exx1:		dc.w	0	;+24
exy1:		dc.w	0	;+26
esize1:		dc.w	0	;+28

tabpointer2:	dc.l	0	;+0
status2:	dc.w	0	;+4
xpos2:		dc.w	0	;+6
ypos2:		dc.w	0	;+8
timer2:		dc.w	0	;+10
seqcounter2:	dc.w	0	;+12
htabpointer2:	dc.l	0	;+14
extra2:		dc.w	0	;+18
mynum2:		dc.w	0	;+20
htime2:		dc.w	0	;+22
exx2:		dc.w	0	;+24
exy2:		dc.w	0	;+26
esize2:		dc.w	0	;+28

tabpointer3:	dc.l	0	;+0
status3:	dc.w	0	;+4
xpos3:		dc.w	0	;+6
ypos3:		dc.w	0	;+8
timer3:		dc.w	0	;+10
seqcounter3:	dc.w	0	;+12
htabpointer3:	dc.l	0	;+14
extra3:		dc.w	0	;+18
mynum3:		dc.w	0	;+20
htime3:		dc.w	0	;+22
exx3:		dc.w	0	;+24
exy3:		dc.w	0	;+26
esize3:		dc.w	0	;+28

tabpointer4:	dc.l	0	;+0
status4:	dc.w	0	;+4
xpos4:		dc.w	0	;+6
ypos4:		dc.w	0	;+8
timer4:		dc.w	0	;+10
seqcounter4:	dc.w	0	;+12
htabpointer4:	dc.l	0	;+14
extra4:		dc.w	0	;+18
mynum4:		dc.w	0	;+20
htime4:		dc.w	0	;+22
exx4:		dc.w	0	;+24
exy4:		dc.w	0	;+26
esize4:		dc.w	0	;+28

creditsactive:	dc.w	0
creditsinit:	dc.w	0
creditsx:	dc.w	0
creditsoff:	dc.w	0

initvor:	dc.w	0

dancetab:	dc.l	dance1,dance2,dance1,dance2

dance1:		dc.w	-20,1
		dc.w	92,22,20,20,20,23,20,20
		dc.w	20,22,20,20,20,23,20,20
		dc.w	20,22,20,20,20,23,20,20
		dc.w	20,22,20,20,20,23,20,20
		
		dc.w	20,22,10,20,10,23,10,20
		dc.w	10,22,10,20,10,23,10,20
		dc.w	10,22,10,20,10,23,10,20
		dc.w	10,22,10,20,10,23,10,20

		dc.w	10,22,10,20,10,23,10,20
		dc.w	10,22,10,20,10,23,10,20
		dc.w	10,22,10,20,10,23,10,20
		dc.w	10,22,10,20,10,23,10,20
		
		dc.w	-100,2
		dc.w	60000,0

dance2:		dc.w	-20,1
		dc.w	92,23,20,20
		dc.w	20,22,20,20,20,23,20,20
		dc.w	20,22,20,20,20,23,20,20
		dc.w	20,22,20,20,20,23,20,20,20,22,20,20
		
		dc.w	20,23,10,20
		dc.w	10,22,10,20,10,23,10,20
		dc.w	10,22,10,20,10,23,10,20
		dc.w	10,22,10,20,10,23,10,20

		dc.w	10,22,10,20,10,23,10,20
		dc.w	10,22,10,20,10,23,10,20
		dc.w	10,22,10,20,10,23,10,20
		dc.w	10,22,10,20,10,23,10,20,10,22,10,20
		
		dc.w	-100,2
		dc.w	60000,0

dance3:		dc.w	-20,1
		dc.w	-92,23
		
		dc.w	-100,2
		dc.w	60000,0

fruitjump1:	dc.w	4,4,5,5,6,6,7,7,8,8
		dc.w	8,8,8,8,-8,-8,-8,-8
		dc.w	-8,-8,-8,-8,-7,-7,-6,-6,-5,-5,-4,-4,-3,-3,-2,-2,-1,-1
		dc.w	0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,8,8
		dc.w	8,8,8,8,-8,-8,-8,-8
		dc.w	-8,-8,-8,-8,-7,-7,-6,-6,-5,-5,-4,-4,-3,-3,-2,-2,-1,-1
		dc.w	$4711

profliegtabx:	dc.w	0,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
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
		dc.w	1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4
		dc.w	4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
		dc.w	4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
		dc.w	4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
		dc.w	$4711

profliegtaby:	dc.w	0,8,8,8,8,8,8,7,7,7,7,6,6,6,6,5,5,5,5
		dc.w	4,4,4,4,3,3,3,3,2,2,2,2,1,1,1,1
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
		dc.w	3,3,3,3,3,3,3,3,2,2,2,2,1,1,1,1,0,1,0,1
		dc.w	0,0,0,0,0,0,0,0,-1,0,-1,0,-1,0,-1,0	
		dc.w	-1,-1,-1,-1,-1,-1,-1,-1,-2,-2,-2,-2,-2,-2,-2,-2
		dc.w	-1,-1,-1,-1,-1,-1,-1,-1,0,-1,0,-1,0,-1,0,-1
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0


teiltabs:	dc.w	-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-3,-3,-3,-3
		dc.w	-2,-2,-2,-2,-1,-1,-1,-1-0,-1,0,-1,0,0,0,0
		dc.w	1,0,1,0,1,1,1,1,2,2,2,2,3,3,3,3
		dc.w	4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,8,8,8,8,8,8,8,8,8,8,8
		dc.w	8,8,8,8,8,8,8,8,$4711

proflieg:	dc.l	0
initfruitjump:	dc.w	0
initfruitjump2:	dc.w	0
initfruitjump3:	dc.w	0
initfruitjump4:	dc.w	0
initfruitjump5:	dc.w	0
initverfolg:	dc.w	0
verx:		dc.w	0
propo:		dc.w	0
protimer:	dc.w	0
teil1y:		dc.w	0
teil2y:		dc.w	0
teil3y:		dc.w	0
teil4y:		dc.w	0
teil1x:		dc.w	0
teil2x:		dc.w	0
teil3x:		dc.w	0
teil4x:		dc.w	0
teil1aus:	dc.w	0
teil2aus:	dc.w	0
teil3aus:	dc.w	0
teil4aus:	dc.w	0
teilflag:	dc.w	0
teil1poi:	dc.l	0
teil2poi:	dc.l	0
teil3poi:	dc.l	0
teil4poi:	dc.l	0

fliegx:		dc.w	0
fliegy:		dc.w	0

babyx:		dc.w	0
babyy:		dc.w	0
babypointer:	dc.l	0
switchbaby:	dc.w	0
babytuut:	dc.w	0
		dc.w	0
babytab:	dc.w	3,3,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1
endbabytab:	dc.w	0
babytime:	dc.w	0

hpointer:	dc.l	0	
hpointer2:	dc.l	0	
lasteye:	dc.l	0

vor1off:	dc.w	0
vor1y:		dc.w	0
vor4y:		dc.w	0
vor1ht:		dc.w	0
		dc.w	0
vor11tab:	dc.w	3,3,3,3,3,3,3,3,3,3,3,3,3,3
		dc.w	2,2,2,2,2,2,2,2,2,2
		dc.w	1,1,1,1,1,1,1,1,1
vor11tabend:	dc.w	0
		dc.w	0,5
vor1tab:	dc.w	5,5,5,5,5,5,5,5,5,5,4,4,3,3,2,2,1,1,1
vor1tabend:	dc.w	0
vor2tab:	dc.w	2,2,2,2,2,2,2,2,2,2,1,1,1,1
vor2tabend:	dc.w	0
vor3tab:	dc.w	5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,4,4,3,3,2,2,1,1,1
vor3tabend:	dc.w	0
		dc.w	-1
vor4tab:	dc.w	3,3,3,3,3,3,3,3,3,3,3,3,2,2,2,2,2,2,2,2,2,2
		dc.w	1,1,1,1,1,1,1,1,1,1,0,1,0,1,0,1,0,1,0,1,0,1
vor4tabend:	dc.w	0

		dc.w	5,5
vor5tab:	dc.w	5,5,5,5,5,5,5,5,5,5,4,4,3,3,2,2,1,1,1
vor5tabend:	dc.w	0

eyepointer4:	dc.l	0
eyetab4:	dc.w	105,0,110,15,111,16,112,17,113,18
		dc.w	240,17,243,16,246,15,249,0
		dc.w	270,1,272,2,274,3,276,2,278,1,280,0,282,0
		dc.w	0,0


eyetab5:	dc.w	70,0,71,0,72,4,76,5,78,6
		dc.w	80,7,111,6,115,5,120,4
		dc.w	155,5,160,6,166,7,172,8,178,9
		dc.w	205,0
		dc.w	230,2,235,3
		dc.w	0,0

fruitpointer:	dc.l	0
fruittab5:	dc.w	0
		dc.w	1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6
		dc.w    7,7,7,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
		dc.w    -8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8
		dc.w    -7,-7,-7,-6,-6,-6,-5,-5,-5,-4,-4,-4
		dc.w	-3,-3,-3,-2,-2,-2,-1,-1,-1,0,0,0,0,0,0,0,0
		dc.w	1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7
		dc.w	-8,-8,-8,-8,-8,-8
		dc.w	-7,-7,-7,-6,-6,-6,-5,-5,-5,-4,-4,-4
		dc.w	-3,-3,-3,-2,-2,-2,-1,-1,-1,0,0,0,0,0,0,0,0
		dc.w    1,1,1,2,2,2,3,3,3,4,4,4
		dc.w	5,5,5,6,6,6,7,7,7,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
		
fruittabend:	

leftx:		dc.l	0
vor2x:		dc.w	0

fruitx:		dc.w	0
fruity:		dc.w	0
blinztab:	dc.w	0,9*4*5,9*4*5*2,9*4*5*3
		dc.w	9*4*5*2,9*4*5,9*4*5
blinztab2:	dc.w	0,17*4*5,17*4*5*2,17*4*5*3
		dc.w	17*4*5*2,17*4*5,17*4*5
lookuptab:	dc.w	9*4*5*15,9*4*5*16,9*4*5*17,9*4*5*18
endlooktab:			

chaseoff:	dc.l	0
what2do: 	dc.w	0
what2dotab:	dc.w	0,2,3,4,5,0,3
what2dopoint:	dc.l	0
period:		dc.w	0
timer:		dc.w	0
timert2:	dc.w	0
blinzler:	dc.w	0

brems:		dc.w	0
dropy:	dc.w	0


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


error:
	move.l	#$100000,d0
erloop:
	move.w	#$f00,$dff180
	sub.l	#1,d0
	bne	erloop
	rts


oldcopper:
	move.w	#$03e0,dmacon(a5)
	move.l	blacklist,cop1lc(a5)
	clr.w	copjmp1(a5)
	move.w	#$83c0,dmacon(a5)
	move.l	#0,$dff144

nogfx:
	rts

newcopper:
	bsr	newcop2
	
	move.w	#$03e0,dmacon(a5)
	move.l	#clist,cop1lc(a5)
	clr.w	copjmp1(a5)
	move.w	#$83c0,dmacon(a5)
	move.l	#0,$dff144
	rts
	
	
newcop2:	
	move.l	a0,wasave
	move.l	bitplanes,d0
	add.l	#48*5*20,d0
switch:
	move.l	d0,activeplanes
	move.w	d0,planes+6
	swap	d0
	move.w	d0,planes+2
	swap	d0
	add.l	#48,d0
	move.w	d0,planes+14
	swap	d0
	move.w	d0,planes+10
	swap	d0
	add.l	#48,d0
	move.w	d0,planes+22
	swap	d0
	move.w	d0,planes+18
	swap	d0
	add.l	#48,d0
	move.w	d0,planes+30
	swap	d0
	move.w	d0,planes+26
	swap	d0
	add.l	#48,d0
	move.w	d0,planes+38
	swap	d0
	move.w	d0,planes+34
	rts

cls:	
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d0,bltdpth(a5)
	move.w	#$0100,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#0,bltdmod(a5)
	move.w	#705*64+40,bltsize(a5)
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.w	#$0100,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#0,bltdmod(a5)
	move.w	#900*64+40,bltsize(a5)
	bsr	waitblit
	rts

transfer:
	move.l	#$ffffffff,bltafwm(a5)

	move.l	titel,a4
	move.l	bitplanes,a0
	add.l	#48*5*20,a0
	bsr	DCruncher
	
transfer2:
	move.l	bitplanes,d0
	add.l	#48*5*20,d0
	move.l	bitplanes2,d1
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d0,bltapth(a5)
	move.l	d1,bltdpth(a5)
	move.w	#$09f0,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#8,bltamod(a5)
	move.w	#8,bltdmod(a5)
	move.w	#640*64+20,bltsize(a5)
	bsr	waitblit
	move.w	#640*64+20,bltsize(a5)
	bsr	waitblit
	rts

smokie:	
	move.l	activeplanes,d0
	add.l	#48*5*81+30,d0
	move.l	#smoke,d1
	add.l	seq,d1

	add.w	#1,delay
	cmp.w	#6,delay
	bne	notoverseqend
	move.w	#0,delay

	add.l	#2*13*5,seq
	cmp.l	#2*13*5*6,seq
	blt	notoverseqend
	move.l	#0,seq
notoverseqend:

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.w	#$09f0,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.l	d1,bltapth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#46,bltdmod(a5)
	move.w	#13*5*64+1,bltsize(a5)
	rts

delay: dc.w	0
seq:   dc.l	0

doflusi:
	move.l	18(a0),a1
	cmp.b	#$ff,3(a1)
	beq	nixmehr1
	add.l	#4,18(a0)
	move.w	#0,d0
	move.b	(a1),d0
	ext.w	d0
	add.w	d0,(a0)
	move.w	#0,d0
	move.b	1(a1),d0
	ext.w	d0	
	add.w	d0,2(a0)
	move.b	2(a1),4(a0)
	move.b	3(a1),5(a0)
nixmehr1:
	bsr	flusis
	rts

flusis:
	tst.w	6(a0)
	beq	no_saved
	move.l	8(a0),d0
	move.l	12(a0),d5
	bsr	waitblit	
	move.w	#$09f0,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	d5,bltapth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#44,bltdmod(a5)
	move.w	#12*5*64+2,bltsize(a5)
no_saved:

	bsr	wolke

	move.w	#1,6(a0)
	move.w	(a0),d0
	move.w	2(a0),d1
	move.l	12(a0),d5
	mulu	#240,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	sub.l	#2,d0
	add.l	bitplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	bsr	waitblit
	move.w	#$09f0,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	d0,bltapth(a5)
	move.l	d5,bltdpth(a5)
	move.w	#44,bltamod(a5)
	move.w	#0,bltdmod(a5)
	move.w	#12*5*64+2,bltsize(a5)

	move.l	d0,8(a0)

	move.w	(a0),d0
	move.w	2(a0),d1
	mulu	#240,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	sub.l	#2,d0
	add.l	bitplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	move.b	4(a0),d2
	and.l	#$ff,d2
	move.w	d2,d3
	add.w	d2,d2
	add.w	d3,d2
	lsl.w	#4,d2
	move.w	d2,d3
	add.w	d2,d2
	add.w	d2,d2
	add.w	d3,d2
	move.l	d2,d3
	add.l	flusi,d2
	add.l	flusi_m,d3

	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0ff2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#44,bltcmod(a5)
	move.w	#44,bltdmod(a5)
	move.w	#12*5*64+2,bltsize(a5)
	rts


diagoff:	dc.w	0


;* d0.w  xpos
;* d1.w  ypos
;* d2.w	 woerter in x
;* d3.w	 Zeilen
;* d4.w	 pointer zum image	 
;* d5.w	 pointer zur maske	 
bitblit:
	move.w	d7,-(sp)
	sub.w	#UPY,d1
	bmi	.not_bot_clip

	move.w	d1,d7
	add.w	d3,d7
	cmp.w	#256,d7
	bls	.not_bot_clip
	
	sub.w	#256,d7
	sub.w	d7,d3
	bmi	.noblit
	cmp.w	#1,d3
	bge	.not_bot_clip
	bra	.noblit 
.not_bot_clip

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
	
	mulu	d2,d6
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
	
	mulu	#240,d1
	move.w	d0,d6
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	sub.l	leftx,d0
	add.l	activeplanes,d0
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
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#48,d0
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
	move.w	(sp)+,d7
	rts

;* d0.w	xpos
;* d1.w	ypos
;* d2.w	 woerter in x
;* d3.w	 Zeilen

restore:
	move.w	d7,-(sp)
	sub.w	#UPY,d1
	bmi	.not_bot_clip

	move.w	d1,d7
	add.w	d3,d7
	cmp.w	#256,d7
	bls	.not_bot_clip
	
	sub.w	#256,d7
	sub.w	d7,d3
	bmi	.noblit
	cmp.w	#1,d3
	bge	.not_bot_clip
	bra	.noblit 
.not_bot_clip

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

	mulu	d2,d6
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

	
	mulu	#240,d1
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	sub.l	leftx,d0
	move.l	d0,d1

	add.l	bitplanes2,d0
	add.l	activeplanes,d1
	
	bsr	waitblit
	move.w	#$09f0,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	d0,bltapth(a5)
	move.l	d1,bltdpth(a5)

	move.w	#48,d0
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
	move.w	(sp)+,d7
	rts




copyfish:
	move.w	#0,allowed
	add.w	#1,fdelay
	cmp.w	#5,fdelay
	bne	nofish
	move.w	#0,fdelay

	cmp.w	#17,fishseq
	beq	nextfish
	move.w	fishx,d0
	move.w	fishy,d1
	mulu	#240,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	sub.l	#2,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	move.w	fishseq,d2
	add.w	#1,fishseq
	and.l	#$ff,d2
	mulu	#200,d2
	move.l	d2,d3
	add.l	#fish,d2
	add.l	#fish_m,d3

	bsr	waitblit
	move.w	#$09f0,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	d2,bltapth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#44,bltdmod(a5)
	move.w	#10*5*64+2,bltsize(a5)
nofish:
	rts

nextfish:
	move.w	#1,allowed
	sub.w	#1,fishcount
	tst.w	fishcount
	bne	nofish
	move.l	fishoff,a0
	cmp.w	#$ffff,(a0)
	beq	restfish
	add.l	#4,fishoff
backfish:
	move.w	(a0),fishx	
	move.w	2(a0),fishy
	move.w	#30,fishcount
	move.w	#0,fishseq
	rts

restfish:
	move.l	#fishies,fishoff
	move.l	#fishies,a0
	bra	backfish

fishx:	 dc.w	0
fishy:	 dc.w 	0
fishseq: dc.w	17
fdelay:	 dc.w 	0
allowed: dc.w	0



wolke:
	tst.b	5(a0)
	beq	nowolke
	
	;add.b	#1,17(a0)
	;cmp.b	#2,17(a0)
	;bne	nowolke
	;move.b	#0,17(a0)
	
	move.w	(a0),d0
	move.w	2(a0),d1
	sub.w	#4,d0
	sub.w	#3,d1
	
	move.b	4(a0),d2
	and.w	#$f,d2
	add.w	d2,d2
	add.w	d2,d2
	lea	wolkoff,a1
	add.w	(a1,d2.w),d0
	add.w	2(a1,d2.w),d1
		
	mulu	#240,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	sub.l	#2,d0
	add.l	bitplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	move.b	16(a0),d2
	and.l	#$ff,d2
	move.w	d2,d3
	add.w	d2,d2
	add.w	d2,d2
	add.w	d3,d2
	add.w	d2,d2
	add.w	d2,d2
	move.w	d2,d3
	add.w	d2,d2
	add.w	d3,d2
	add.w	d2,d2
	move.l	d2,d3
	add.l	wolki,d2
	add.l	wolki_m,d3
	add.b	#1,16(a0)
	and.b	#%11,16(a0)

	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0ff2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#44,bltcmod(a5)
	move.w	#44,bltdmod(a5)
	move.w	#6*5*64+2,bltsize(a5)
nowolke:
	rts



restorechar:
	add.w	#20,d1
	mulu	#240,d1
	sub.l	#subychar,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	move.l	d0,d1
	add.l	bitplanes2,d0
	add.l	bitplanes,d1
	add.l	#48*5*20,d1
	and.w	#$f,d4
	ror.w	#4,d4
	
	bsr	waitblit
	move.w	#$09f0,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	d1,bltapth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#38,bltamod(a5)
	move.w	#38,bltdmod(a5)
	move.w	#85*5*64+5,bltsize(a5)
	rts



char_N:
	add.w	#20,d1
	mulu	#240,d1
	sub.l	#subychar,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	move.l	logoN,d2
	move.l	LogoN_m,d3

	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0ff2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#38,bltcmod(a5)
	move.w	#38,bltdmod(a5)
	move.w	#84*5*64+5,bltsize(a5)
	rts

char_I:
	add.w	#20,d1
	mulu	#240,d1
	sub.l	#subychar,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	move.l	logoI,d2
	move.l	LogoI_m,d3

	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0ff2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#42,bltcmod(a5)
	move.w	#42,bltdmod(a5)
	move.w	#72*5*64+3,bltsize(a5)
	rts


char_B1:
	add.w	#20,d1
	mulu	#240,d1
	sub.l	#subychar,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	move.l	logoB1,d2
	move.l	LogoB1_m,d3

	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0ff2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#38,bltcmod(a5)
	move.w	#38,bltdmod(a5)
	move.w	#75*5*64+5,bltsize(a5)
	rts

char_B2:
	add.w	#20,d1
	mulu	#240,d1
	sub.l	#subychar,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	move.l	logoB2,d2
	move.l	LogoB2_m,d3

	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0ff2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#38,bltcmod(a5)
	move.w	#38,bltdmod(a5)
	move.w	#70*5*64+5,bltsize(a5)
	rts


char_L:
	add.w	#20,d1
	mulu	#240,d1
	sub.l	#subychar,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	move.l	logoL,d2
	move.l	LogoL_m,d3

	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0ff2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#38,bltcmod(a5)
	move.w	#38,bltdmod(a5)
	move.w	#78*5*64+5,bltsize(a5)
	rts

char_Y:
	add.w	#20,d1
	mulu	#240,d1
	sub.l	#subychar,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	activeplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	move.l	logoY,d2
	move.l	LogoY_m,d3

	bsr	waitblit
	move.w	d4,bltcon1(a5)
	or.w	#$0ff2,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d3,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#38,bltcmod(a5)
	move.w	#38,bltdmod(a5)
	move.w	#82*5*64+5,bltsize(a5)
	rts



waitblit:
	move.l	gfxbase,a6
	jsr	-228(a6)
	rts


vposdown:
	;btst	#7,$bfe001
	;beq	.isfire

.vpos1
	tst.b	5(a5)
	bne	.vpos1
.vpos2
	tst.b	5(a5)
	beq	.vpos2
.isfire
	rts

vposup:
	tst.w	creditsactive
	bne	.isfire

	;btst	#7,$bfe001
	;beq	.isfire
.vpos11
	tst.b	5(a5)
	beq	.vpos11
.vpos22
	tst.b	5(a5)
	bne	.vpos22
.isfire
	rts

vposup2:
	;btst	#7,$bfe001
	;beq	.isfire
.vpos11
	tst.b	5(a5)
	beq	.vpos11
.vpos22
	tst.b	5(a5)
	bne	.vpos22
.isfire
	rts



opendos:
        move.l  4.w,a6
        jsr     permit(a6)

        move.l  execbase,a6
        clr.l   d0
        lea     dosname,a1
        jsr     openlibrary(a6)
        move.l  d0,dosbase
        rts


closefile:
        move.l  handle,d1
        move.l  dosbase,a6
        jsr     -36(a6)         ;close
	rts

openfile:
        move.l  #1005,d2
        move.l  dosbase,a6
        jsr     -30(a6)         ;open
        move.l  d0,handle       
	rts

loadfiles:
        bsr     opendos


        move.l  #titelbild,d1
	bsr	openfile

        tst.l   d0
        beq     fileerror

        move.l  handle,d1
        move.l  titel,d2
        move.l  #12508,d3
        move.l  dosbase,a6
        jsr     -42(a6)         ;read

	bsr	closefile


        move.l  #cred1,d1
	bsr	openfile

        tst.l   d0
        beq     fileerror

        move.l  handle,d1
        move.l  mt_data,d2
        move.l  #2000,d3
        move.l  dosbase,a6
        jsr     -42(a6)         ;read


	bsr	closefile

        move.l  mt_data,a4
        move.l  credits,a0
        bsr     Dcruncher



        move.l  #cred2,d1
	bsr	openfile
        tst.l   d0
        beq     fileerror

        move.l  handle,d1
        move.l  mt_data,d2
        move.l  #2000,d3
        move.l  dosbase,a6
        jsr     -42(a6)         ;read

	bsr	closefile

        move.l  mt_data,a4
        move.l  credits_m,a0
        bsr     Dcruncher




        move.l  #logogfx,d1
	bsr	openfile
        tst.l   d0
        beq     fileerror

        move.l  handle,d1
        move.l  mt_data,d2
        move.l  #16508,d3
        move.l  dosbase,a6
        jsr     -42(a6)         ;read

	bsr	closefile

        move.l  mt_data,a4
        move.l  logobuffer,a0
        bsr     Dcruncher



        move.l  #titelmusic,d1
	bsr	openfile
        tst.l   d0
        beq     fileerror

        move.l  handle,d1
        move.l  mt_data,d2
        move.l  #52338,d3
        move.l  dosbase,a6
        jsr     -42(a6)         ;read

	bsr	closefile

qayqay:

        move.l  4.w,a6
        jsr     forbid(a6)
        rts


fileerror:
        move.l  #50000,d0
.ferloop:
        move.w  #$f00,$dff180
        move.w  #$000,$dff180
        sub.l   #1,d0
        bne     .ferloop
        move.l  4.w,a6
        jsr     forbid(a6)
        rts

loadbuffer:	dc.l	0

cred1:        dc.b    "nibbly:nibbly/titel/credits_rb.pk",0
        even
cred2:        dc.b    "nibbly:nibbly/titel/credits_m.pk",0
        even
logogfx:      dc.b    "nibbly:nibbly/titel/logogfx.pk",0
        even
titelmusic:   dc.b    "nibbly:nibbly/titel/titelmusic",0
        even
titelbild:   dc.b     "nibbly:nibbly/titel/titel.pk",0
        even
        
handle: dc.l    0






;a4.l	source
;a0.l	destination
DCruncher:
	bsr	doDCrunch
	move.l	4.w,a6
	lea	$dff000,a5
	rts

doDCrunch:
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
deloop:
	lsr.l	#1,d7
	bne.s	not_empty0
	move.l	-(a5),d7
	roxr.l	#1,d7
not_empty0:
	bcc.s	copydata
	moveq	#0,d2
bytekpl:
	move	d5,d1
	bsr.s	getbits
	add	d0,d2
	cmp	d6,d0
	beq.s	bytekpl
	subq	#1,d2
byteloop:
	move	d6,d1
bytebits:
	lsr.l	#1,d7
	bne.s	not_empty2
	move.l	-(a5),d7
	roxr.l	#1,d7
not_empty2:
	roxr.b	#1,d0
	dbf	d1,bytebits
	move.b	d0,-(a0)
	dbf	d2,byteloop
	bra.s	test

copydata:
	moveq	#2-1,d1
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
not_empty3:
	bcs.s	copykpl

copykpl127:
	move	d6,d1
	bsr.s	getbits
	add	d0,d2
	cmp	d3,d0
	beq.s	copykpl127
	add	d6,d2
	add	d6,d2
	bra.s	copyskip

copykpl:
	move	d5,d1
	bsr.s	getbits
	add	d0,d2
	cmp	d6,d0
	beq.s	copykpl
copyskip:
	move	d4,d1
copyfast:
	addq	#1,d2
	bsr.s	getfast
copyloop:
	move.b	0(a0,d0.w),-(a0)
	dbf	d2,copyloop
test:
	cmp.l	a0,a3
	blo.s	deloop
	rts

getbits:
	subq	#1,d1
getfast:
	moveq	#0,d0
bitloop:
	lsr.l	#1,d7
	bne.s	not_empty1
	move.l	-(a5),d7
	roxr.l	#1,d7
not_empty1:
	addx.l	d0,d0
	dbf	d1,bitloop
	rts


*****************************************
* Pro-Packer v2.1 Replay-Routine.	*
* Based upon the PT1.1B-Replayer	*
* by Lars 'ZAP' Hamre/Amiga Freelancers.*
* Modified by Estrup/Static Bytes.	*
*****************************************

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
	CLR.W	$42(A0)
	MOVE.W	#$F,(A0)
	RTS

mt_music
	MOVEM.L	D0-D4/D7/A0-A6,-(SP)
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



blacklist:	dc.l	0
gfxlib:	dc.l	0

	 even
gfxbase:	dc.l	0

gfxname: dc.b	"graphics.library",0
	 cnop 0,2
dosname: dc.b	"dos.library",0
	 cnop 0,2

bitplanes:	dc.l 0
bitplanes2:	dc.l 0
save4clr:	dc.l 0
activeplanes:	dc.l 0
dosbase:	dc.l 0

	EVEN
	
flugi1:	dcb.b	22,0
flugi2:	dcb.b	22,0
flugi3:	dcb.b	22,0

savea7: dc.l 0

moves1:	dc.b	2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0
	dc.b	2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0
	dc.b	2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0
	dc.b	2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0
	dc.b	2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0
	dc.b	2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0
	dc.b	2,-1,1,1,2,-2,2,1,1,-2,3,1,0,-2,4,1,0,-2,4,1
	dc.b	0,-2,4,1,-1,-2,5,1,-2,-2,6,1,-2,-1,7,1,-2,-1,7,1
	dc.b	-2,-1,7,1,-2,-1,7,1,-2,-1,7,1,-2,-1,7,1,-2,-2,6,1
	dc.b	-1,-2,5,1,0,-2,4,1,0,-2,4,1,1,-2,3,1,1,-2,3,1
	dc.b	2,-2,2,1,2,-2,2,1,2,-1,1,1,2,-1,1,1,2,-1,1,1
	dc.b	2,-1,1,0,2,-1,1,0,2,-2,2,0,2,-2,2,0,2,-2,2,0
	dc.b	1,-2,3,0,1,-2,3,0,1,-2,3,0,1,-2,3,0,1,-2,3,0
	dc.b	1,-2,3,0,1,-2,3,0,0,-2,4,0,0,-2,4,0,0,-2,4,0
	dc.b	0,-2,4,0,0,-2,4,0
	dc.b	0,-5,0,0
	dc.b	0,0,0,$ff

moves2:
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	dc.b	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	dc.b	0,3,12,0,0,3,12,0,0,3,12,0,0,3,12,0,0,3,12,0,0,3,12,0
	dc.b	1,3,13,0,1,3,13,0,1,3,13,0,1,3,13,0,1,3,13,0,1,3,13,0
	dc.b	1,3,13,0,1,3,13,0,1,3,13,0,1,3,13,0,1,3,13,1,1,3,13,1
	dc.b	1,3,13,1,1,3,13,1,2,2,14,1,3,1,15,1,2,-1,0,1,2,-1,1,1
	dc.b	1,-2,2,1,0,-2,3,1,-1,-2,4,1,-1,-2,5,1,-1,-2,5,1,-1,-2,5,1
	dc.b	-1,-2,5,1,-1,-2,5,1,-1,-2,5,1,-2,-2,6,0,-2,-1,7,0
	dc.b	-2,0,8,0,-2,1,9,0,-2,2,10,0,-1,3,11,0,0,3,12,0,	1,3,13,0
	dc.b	2,3,14,0,3,2,15,0,3,2,15,0,3,1,15,0
	dc.b	3,0,0,0,3,0,0,0,3,0,0,0,3,0,0,0,3,0,0,0,3,0,0,0,3,0,0,0
	dc.b	3,0,0,0,3,0,0,0,3,1,15,0,2,2,14,0,1,2,13,0
	dc.b	0,3,12,0,-1,2,11,0,-2,1,10,0,-2,0,8,0,-2,-1,7,0
	dc.b	-2,-2,6,0,-1,-2,5,0
	dc.b	-1,-2,5,1,-1,-2,5,1,-1,-2,5,1,-1,-2,5,1,-1,-2,5,1
	dc.b	-1,-2,5,1,-1,-2,5,1,-1,-2,5,1,-1,-2,5,1,-1,-2,5,1
	dc.b	-1,-2,5,1,-1,-2,5,1,-1,-2,5,1
	dc.b	0,-2,4,1,1,-2,3,1,2,2,2,1,2,-1,1,1,2,-1,1,1
	dc.b	2,-1,1,1,2,-1,1,1,2,0,0,1,2,0,0,1,2,0,0,1
	dc.b	2,1,15,1,2,2,14,1,2,3,13,1,0,3,12,1,0,3,12,1,0,3,12,1
	dc.b	-1,2,11,1,-2,2,10,1,-2,1,9,1,-2,0,8,1,-2,0,8,1
	dc.b	-2,-1,7,1,-2,-2,6,1
	dc.b	-2,-2,6,0,-2,-2,6,0,-2,-2,6,0,-2,-2,6,0,-2,-2,6,0
	dc.b	-1,-2,5,0,-1,-2,5,0,-1,-2,5,0,-1,-2,5,0
	dc.b	0,-2,4,0,0,-2,4,0,0,-2,4,0,0,-2,4,0
	dc.b	0,-2,4,0,0,-2,4,0,0,-2,4,0,0,-2,4,0
	dc.b	0,-2,4,0,0,-2,4,0,0,-2,4,0,0,-2,4,0
	dc.b	0,-2,4,0,0,-2,4,0,0,-2,4,0,0,-2,4,0
	dc.b	0,-2,4,0
	dc.b	0,-5,0,0
	dc.b	0,0,0,$ff


moves3:
	dc.b	-1,3,11,0,-1,3,11,0,-1,3,11,0,-1,3,11,0,-1,3,11,0
	dc.b	-1,3,11,0,-1,3,11,0,-1,3,11,0,-1,3,11,0,-1,3,11,0
	dc.b	-1,3,11,0,-1,3,11,0,-1,3,11,0,-1,3,11,0,-1,3,11,0
	dc.b	-2,2,10,0,-2,2,9,0,-2,1,9,0,-2,1,9,0,-2,1,9,0
	dc.b	-2,0,8,0,-2,0,8,0,-2,1,7,0,-2,1,7,0,-2,-2,6,0
	dc.b	-1,-2,5,0,-1,-2,5,0,-1,-2,5,0,-1,-2,5,0,0,-2,4,0
	dc.b	1,-2,3,0,2,-2,2,0,2,-1,1,0,2,-1,1,0
	dc.b	2,-1,1,1,2,-1,1,1,2,-1,1,1,2,-1,1,1
	dc.b	2,-2,2,1,0,-2,4,1,-2,-1,6,1,-2,0,8,1
	dc.b	-2,1,10,1,-2,1,10,1,-2,1,10,1,-2,1,10,1
	dc.b	1,3,12,1,1,3,13,1,2,2,14,1,2,1,15,1,3,2,0,1
	dc.b	2,-1,1,1,2,-1,1,1,2,-1,1,1,2,-1,1,1,2,-1,1,1,2,-1,1,1
	dc.b	2,-1,1,0,2,-1,1,0,2,-1,1,0,2,-1,1,0,2,-1,1,0,2,-1,1,0
	dc.b	2,-1,1,0,2,-1,1,0,2,-1,1,0,2,-1,1,0
	dc.b	2,0,0,0,2,1,15,0,2,2,14,0,1,3,13,0,3,0,12,0
	dc.b	-1,3,11,0,-1,3,11,0,-1,3,11,0,-1,3,11,0,-1,3,11,0
	dc.b	-2,2,10,0,-2,1,9,0,-2,0,8,0,-2,0,8,0,-2,0,8,0,-2,0,8,0
	dc.b	-2,-1,7,0,-2,-2,6,0
	dc.b	-1,-2,5,0,-1,-2,5,0,-1,-2,5,0,-1,-2,5,0
	dc.b	-1,-2,5,1,-1,-2,5,1,-1,-2,5,1,-1,-2,5,1,-1,-2,5,1,-1,-2,5,1
	dc.b	-1,-2,5,1,0,-2,4,1,1,-2,3,1,2,-2,2,1
	dc.b	2,-1,1,1,2,-1,1,1,2,-1,1,1,2,-1,1,1
	dc.b	2,-1,1,0,2,-1,1,0,2,-2,2,0,2,-2,2,0,1,-2,3,0
	dc.b	1,-2,3,0,1,-2,3,0,1,-2,3,0,1,-2,3,0
	dc.b	0,-5,0,0
	dc.b	0,0,0,$ff

wolkoff: dc.w	5,9,6,10,9,10,11,10,12,9,13,8,12,7,12,6
	 dc.w	12,5,10,5,8,5,8,4,8,3,6,5,6,7,6,8


fishies:	dc.w	50,95,70,90,40,93,90,91,70,96,$ffff,$ffff
fishoff:	dc.l 	0
fishcount:	dc.w	30

credits:	dc.l	0	;incbin	"credits_128x108x5.rb"
credits_m:	dc.l	0	;incbin	"credits_128x108x5.mask"
mt_data:	dc.l	0	;incbin	"mod.nibbly-title"
logobuffer:	dc.l	0
titel:		dc.l	0	;incbin	"titel.pk"

LogoN:		dc.l	0
LogoN_m:	dc.l	0
LogoI:		dc.l	0
LogoI_m:	dc.l	0
LogoB1:		dc.l	0
LogoB1_m:	dc.l	0
LogoB2:		dc.l	0
LogoB2_m:	dc.l	0
LogoL:		dc.l	0
LogoL_m:	dc.l	0
LogoY:		dc.l	0
LogoY_m:	dc.l	0
flusi:		dc.l	0
flusi_m:	dc.l	0
wolki:		dc.l	0
wolki_m:	dc.l	0
motor:		dc.l	0
donner:		dc.l	0


		SECTION Daten,DATA_C


		;incdir	"ram:"
		incdir	"dh0:lo-res/nibbly2/titel/"

;l1:
;LogoN:		incbin	"Logo_N_80x84x5.rb"
;LogoN_m:	incbin	"Logo_N_80x84x5.mask"
;LogoI:		incbin	"Logo_I_48x72x5.rb"
;LogoI_m:	incbin	"Logo_I_48x72x5.mask"
;LogoB1:	incbin	"Logo_B1_80x75x5.rb"
;LogoB1_m:	incbin	"Logo_B1_80x75x5.mask"
;LogoB2:	incbin	"Logo_B2_80x70x5.rb"
;LogoB2_m:	incbin	"Logo_B2_80x70x5.mask"
;LogoL:		incbin	"Logo_L_80x78x5.rb"
;LogoL_m:	incbin	"Logo_L_80x78x5.mask"
;LogoY:		incbin	"Logo_Y_80x82x5.rb"
;LogoY_m:	incbin	"Logo_Y_80x82x5.mask"
;flusi:		incbin	"flusis_32x196x5.rb"
;flusi_m:	incbin	"flusis_32x196x5.mask"
;wolki:		incbin	"minismokie_32x24x5.rb"
;wolki_m:	incbin	"minismokie_32x24x5.mask"

		incdir	"dh0:assem/nibbly/sound/"
;motor:		incbin	"sfx.flugzeug"
;donner:		incbin	"sfx.donner"
;l2:

		incdir	"dh0:lo-res/nibbly2/titel/"
	
smoke:		incbin	"smokie_16x78x5.rb"
fish:		incbin	"fish_32x170x5.rb"
fish_m:		incbin	"fish_32x170x5.mask"

wbest:		incbin	"wbest_96x51x5.rb"
wbest_m:	incbin	"wbest_96x51x5.mask"
BigFlieger:	incbin	"Flieger_128x78x5.rb"
BigFlieger_m:	incbin	"Flieger_128x78x5.mask"
prop1:		incbin	"Prop1_32x47x5.rb"
prop1_m:	incbin	"Prop1_32x47x5.mask"
prop3:		incbin	"Prop3_32x7x5.rb"
prop3_m:	incbin	"Prop3_32x7x5.mask"
crash1:		incbin	"crash1_48x32x5.rb"
crash1_m:	incbin	"crash1_48x32x5.mask"
crash2:		incbin	"crash2_48x19x5.rb"
crash2_m:	incbin	"crash2_48x19x5.mask"
crash3:		incbin	"crash3_48x32x5.rb"
crash3_m:	incbin	"crash3_48x32x5.mask"
crash4:		incbin	"crash4_64x19x5.rb"
crash4_m:	incbin	"crash4_64x19x5.mask"
toff:		incbin	"toff_80x39x5.rb"
toff_m:		incbin	"toff_80x39x5.mask"
zack:		incbin	"zack_80x34x5.rb"
zack_m:		incbin	"zack_80x34x5.mask"
slup:		incbin	"slup_80x39x5.rb"
slup_m:		incbin	"slup_80x39x5.mask"
uff:		incbin	"Uff_big_mum_112x51x5.rb"
uff_m:		incbin	"Uff_big_mum_112x51x5.mask"
BF_behind:	incbin	"BF_behind_96x55x5.rb"
BF_behind_m:	incbin	"BF_behind_96x55x5.mask"
verrechts:	incbin	"looking_right_96x55x5.rb"
verrechts_m: 	incbin	"looking_right_96x55x5.mask"
verlinks:	incbin	"looking_left_96x55x5.rb"
verlinks_m:	incbin	"looking_left_96x55x5.mask"
baby_right:	incbin	"baby_right_48x26x5.rb"
baby_right_m:	incbin	"baby_right_48x26x5.mask"
baby_left:	incbin	"baby_left_48x26x5.rb"
baby_left_m:	incbin	"baby_left_48x26x5.mask"
Tuut:		incbin	"Tuut_80x34x5.rb"
Tuut_m:		incbin	"Tuut_80x34x5.mask"
faces:		incbin	"faces_64x101x5.rb"
faces_m:	incbin	"faces_64x101x5.mask"
danceleft:	incbin	"flupsdanceleft_64x71x5.rb"
danceleft_m:	incbin	"flupsdanceleft_64x71x5.mask"
danceright:	incbin	"flupsdanceright_64x71x5.rb"
danceright_m:	incbin	"flupsdanceright_64x71x5.mask"
Brille:		incbin	"Brille_48x9x5.rb"
Brille_m:	incbin	"Brille_48x9x5.mask"
Flups_dick:	incbin	"Flups_dick_96x71x5.rb"
Flups_dick_m:	incbin	"Flups_dick_96x71x5.mask"
Mundrund:	incbin	"Mund_rund_64x11x5.rb"
Mundtraurig:	incbin	"Mund_traurig_64x11x5.rb"
Mundgerade:	incbin	"Mund_gerade_64x11x5.rb"
Mundmask:	incbin	"Mund_rund_64x11x5.mask"
headcrash:	incbin	"headcrash_64x18x5.rb"
headcrash_m:	incbin	"headcrash_64x18x5.mask"
smallfruit:	incbin	"fruit_64x37x5.rb"
smallfruit_m:	incbin	"fruit_64x37x5.mask"
bigfruit:	incbin	"Big_fruit_96x74x5.rb"
bigfruit_m:	incbin	"Big_fruit_96x74x5.mask"
welcome:	incbin	"Welcome_112x51x5.rb"
welcome_m:	incbin	"Welcome_112x51x5.mask"
flupsvoben:	incbin	"flupsvonoben_48x71x5.rb"
flupsvoben_m:	incbin	"flupsvonoben_48x71x5.mask"
blobs1:		incbin	"blobs1_48x24x5.rb"
blobs1_m:	incbin	"blobs1_48x24x5.mask"
blobs2:		incbin	"blobs2_48x24x5.rb"
blobs2_m:	incbin	"blobs2_48x24x5.mask"
hungry1:	incbin	"hungry1_112x51x5.rb"
hungry1_m:	incbin	"hungry1_112x51x5.mask"
hungry2:	incbin	"hungry2_112x51x5.rb"
hungry2_m:	incbin	"hungry2_112x51x5.mask"
flupsson:	incbin	"flupsson_32x24x5.rb"
flupsson_m:	incbin	"flupsson_32x24x5.mask"
flupsvunten1:	incbin	"flupsvonunten1_64x71x5.rb"
flupsvunten1_m:	incbin	"flupsvonunten1_64x71x5.mask"
flupsvunten2:	incbin	"flupsvonunten2_64x71x5.rb"
flupsvunten2_m:	incbin	"flupsvonunten2_64x71x5.mask"
eyes:		incbin	"eyes_32x171x5.rb"
eyes_m:		incbin	"eyes_32x9x5.mask"



	even

clist:	dc.w	$0001,$ff00,dmacon,$0100,bplcon0,$5000
 	dc.w	bplcon1
wobbel:	dc.w	$22,bplcon2,0,bpl1mod,200,bpl2mod,200
	dc.w	diwstrt,$2081,diwstop,$2fc1
	dc.w	ddfstrt,$0038,ddfstop,$00d0
colors:	dc.w	$180,$0000
	dc.w	$182,$0FFF
	dc.w	$184,$0DDD
	dc.w	$186,$0BBB
	dc.w	$188,$0888
	dc.w	$18a,$0666
	dc.w	$18c,$0444
	dc.w	$18e,$0222
	dc.w	$190,$0E90
	dc.w	$192,$0D80
	dc.w	$194,$0B60
	dc.w	$196,$0A50
	dc.w	$198,$0940
	dc.w	$19a,$0840
	dc.w	$19c,$0630
	dc.w	$19e,$0520
	dc.w	$1a0,$03E4
	dc.w	$1a2,$03C3
	dc.w	$1a4,$02B2
	dc.w	$1a6,$0292
	dc.w	$1a8,$0FAC
	dc.w	$1aa,$0D68
	dc.w	$1ac,$0C34
	dc.w	$1ae,$0A01
	dc.w	$1b0,$0BBF
	dc.w	$1b2,$089E
	dc.w	$1b4,$067E
	dc.w	$1b6,$045D
	dc.w	$1b8,$0EE1
	dc.w	$1ba,$0EC1
	dc.w	$1bc,$0EA0
	dc.w	$1be,$0F90
	dc.w	$1001,$ff00
planes:
	dc.w	bpl1pth,0,bpl1ptl,0
	dc.w	bpl2pth,0,bpl2ptl,0
	dc.w	bpl3pth,0,bpl3ptl,0
	dc.w	bpl4pth,0,bpl4ptl,0
	dc.w	bpl5pth,0,bpl5ptl,0
	dc.w	$2901,$ff00,dmacon,$8100,$ffdf,$fffe
	dc.w	$2901,$ff00
	dc.w	bplcon0,0000,$ffff,$fffe

stopsnd:	dc.w	0,0,0,0,0,0

creditsbuffer:		
buffer1:	dcb.b	4*5*12,0
buffer2:	dcb.b	4*5*12,0
buffer3:	dcb.b	4*5*12,0
		dcb.b	240,0
creditsbuffer2:	dcb.b	960,0		

		
			
	 even
ende:
