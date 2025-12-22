; // Amiga Exec Offset list //
Openlibrary:      equ   -408
Closelibrary:     equ   -414
Forbid:           equ   -132
Permit:           equ   -138
Allocmem:         equ   -198
Freemem:          equ   -210
; // _AbsExecBase
Sysbase:	  equ	$04
; // Amiga Dos Offset list //
Open:             equ   -30
Close:            equ   -36
Read:             equ   -42
Write:            equ   -48
Deletefile:       equ   -72
LoadSeg:          equ   -150
Delay:            equ   -198
Execute:          equ   -222
Input:		  equ	-54
Output:		  equ	-60
; // FileModes //
Mode_Newfile:     equ   $3ee
Mode_Oldfile:     equ   $3ed

	move.l	sysbase,a6
	lea	dosname,a1
	jsr	OpenLibrary(a6)
	move.l	d0,dosbase
	lea	gfxname,a1
	jsr	OpenLibrary(a6)
	move.l	d0,gfxbase
	add.l	#$32,d0
	move.l	d0,copbase	
	move.l	#270000,d0
	move.l	#65538,d1
	jsr	AllocMem(a6)
	cmp.l	#0,d0
	beq	slut
	move.l	d0,membase
	add.l	#190000,d0
	move.l	d0,chars
	move.l	membase,d0
	add.l	#210000,d0
	move.l	d0,mtdata
	move.l	#chfile,a0
	move.l	chars,d0
	jsr	LoadFile
	move.l	#pgfile,a0
	move.l	#playground,d0
	jsr	LoadFile
	move.l	#musfile,a0
	move.l	mtdata,d0
	jsr	LoadFile
	lea	cpr,a2
	move.l	membase,d0
	swap	d0
	move.w	d0,2(a2)
	swap	d0
	move.w	d0,6(a2)
	add.l	#81920,d0
	swap	d0
	move.w	d0,10(a2)
	swap	d0
	move.w	d0,14(a2)
	move.l	membase,d0
	add.l	#165000,d0
	move.l	d0,bakgr
	lea	pblank,a2
	swap	d0
	move.w	d0,2(a2)
	swap	d0
	move.w	d0,6(a2)
	move.l	membase,d0
	add.l	#206000,d0
	move.l	d0,infoscr
	lea	info,a2
	swap	d0
	move.w	d0,2(a2)
	swap	d0
	move.w	d0,6(a2)
	move.w	#$6666,rugr
	move.w	#$6666,rugl
	move.l	#gubbsprite,d0
	lea	sprite,a2
	swap	d0
	move.w	d0,2(a2)
	swap	d0
	move.w	d0,6(a2)

	move.l	bakgr,a0
	move.l	#24980,d0
fylla:	move.b	#$ff,(a0)+
	dbra	d0,fylla
	jsr	blackout
	move.l	#38,d0
	jsr	ritagubbe
	move.l	#200,d0
hdf:	jsr	realrsync
	dbra	d0,hdf


	jsr	Forbid(a6)
	move.w	#$0080,$dff096
	move.l	copbase,a0
	move.l	(a0),oldcop
	move.l	#cpr,(a0)
	move.w	#$8080,$dff096
;	jsr	Permit(a6)

greset:	move.l	startinglevel,level
	jsr	spritesgone
	jsr	blackout
	jsr	clearinfo
	jsr	introduction
	move.l	antalliv,lives
	jsr	clearinfo
	jsr	mt_init

weiron:
	jsr	spritesgone
	jsr	blackout
	jsr	Draw
	jsr	spritesetup
	jsr	lightson
	move.l	#0,d0
	jsr	ritagubbe
nextra:	lea	levline,a0
	jsr	drawinfo
	jsr	spritestartup
	move.l	level,d0
	lsl.l	#4,d0
	lea	leveldata,a0
	add.l	d0,a0	
	move.l	(a0),gubbx
	move.l	4(a0),gubby
	move.l	#0,nycklar
	move.l	#0,hoppa
	move.l	#10,detect
	move.l	#0,fall
	move.l	#0,klarat
	move.l	8(a0),nyckn
	move.l	#0,slafs

scrl:
	cmp.l	#1,slafs
	beq	doedens
	move.l	gubby,gamy
	move.l	gubbx,d0
	move.l	gubby,d1
	sub.l	#145,d0
	sub.l	#76,d1
	jsr	plotscn
	jsr	getgaddrs
	jsr	collision
	jsr	zpritte
	jsr	checkers
	jsr	hanglas
	cmp.l	#1,klarat
	beq	jaaahhh
	jsr	rutsch
	cmp.l	#1,ruts
	beq	tyx
	cmp.l	#0,hoppa
	bne	gh
	jsr	akatrappa
	move.l	#1,ramla
	jsr	down
gh:	cmp.l	#0,fall
	bne	nehe2
	btst	#1,$dff00c
	beq	nehe
	move.l	#8,gubbh	;move left
	sub.l	#1,gubbg
	jsr	ritagubben
	jsr	huppe	
	cmp.l	#0,hoppa
	bne	nehe2
	jsr	left
	jmp	guft
nehe:	btst	#1,$dff00d
	beq	nehe2		;move right
	move.l	#0,gubbh	
	add.l	#1,gubbg
	jsr	ritagubben
	jsr	huppe
	cmp.l	#0,hoppa
	bne	nehe2
	jsr	right
	jmp	guft
nehe2:
	jsr	huppe
guft:	jsr	hopp

tyx:	move.l	gamy,d0
	cmp.l	gubby,d0
	blt	snyggve
	jsr	uppdat
	jsr	livingchars
	jsr	rsync
	jsr	rullband
	jsr	rsync
	jmp	mw
snyggve:jsr	rsync
	jsr	uppdat
	jsr	livingchars
	jsr	rullband
	jsr	rsync
mw:	btst	#6,$bfe001
	bne	scrl

finis:  jsr	mt_end
	move.l	SysBase,a6
;	jsr	Forbid(a6)
	move.w	#$0080,$dff096
	move.l	copbase,a0
	move.l	oldcop,(a0)
	move.w	#$8080,$dff096
	jsr	Permit(a6)
	move.l	membase,a1
	move.l	#270000,d0
	jsr	FreeMem(a6)

slut:	rts
realrsync:btst	#0,$dff005
	bne	realrsync
rr2:	btst	#0,$dff005
	beq	rr2
	rts

Rsync:  btst	#0,$dff005
	bne	rsync
r2:	btst	#0,$dff005
	beq	r2
	jsr	mt_music
	rts

collision:
	move.w	$dff00e,d0
	sub.l	#1,detect
	cmp.l	#0,detect
	bne	slink
	add.l	#1,detect
	and.l	#$0e00,d0
	cmp.w	#$00,d0
	beq	slink
	move.l	#1,slafs
slink:	rts
jaaahhh:jsr	spritesgone
	move.l	#30,d0
gf:	jsr	rsync
	dbra	d0,gf
	move.l	#31,d4
rt:	add.l	#1,gubby
	move.l	gubbx,d0
	move.l	gubby,d1
	sub.l	#145,d0
	sub.l	#76,d1
	jsr	plotscn
	jsr	rsync
	dbra	d4,rt		
	add.l	#1,level
	jmp	nextra

hanglas:move.l	nycklar,d0
	cmp.l	nyckn,d0
	bne	aetsdf
	move.l	gaddr,d0
	cmp.l	gsaddr,d0
	bne	aetsdf
	move.l	gubby,d0
	and.l	#7,d0
	cmp.l	#0,d0
	bne	aetsdf	
	move.l	gaddr,a0
	cmp.b	#'w',160(a0)
	bne	aetsdf
	move.l	#1,klarat
aetsdf:	rts
doedens:jsr	gubbdo
	move.l	#40,d0
swett:	jsr	rsync
	dbra	d0,swett
	cmp.l	#0,lives
	beq	gove
	sub.l	#1,lives
	jmp	weiron
gove:move.l	#gotxt,a0
	move.l	infoscr,a1
	add.l	#642,a1
	jsr	drawline
	move.l	#200,d6
ubg:	jsr	rsync
	dbra	d6,ubg
	jsr	mt_end
	jmp	greset	

mew:	btst	#6,$bfe001
	bne	mew
	jmp	finis
checkers:move.l	gaddr,a2
	jsr	testa
	sub.l	#160,a2
	jsr	testa
	move.l	gsaddr,a2
	jsr	testa
	sub.l	#160,a2
	jsr	testa
	move.l	gubby,d0
	and.l	#7,d0
	cmp.l	#0,d0
	beq	rets
	move.l	gaddr,a2
	add.l	#160,a2
	jsr	testa
	move.l	gsaddr,a2
	add.l	#160,a2
	jsr	testa
rets:	rts
testa:	cmp.b	#'u',(a2)
	beq	nyckel
	cmp.b	#'r',(a2)
	beq	dod
	cmp.b	#'s',(a2)
	beq	dod
	cmp.b	#'t',(a2)
	beq	dod
	rts

nyckel:	move.l	a2,d0
	move.l	#playground,d1
	sub.l	d1,d0
	move.l	#0,d1
	jsr	writech
	move.b	#'v',(a2)
	add.l	#1,nycklar	
	rts

dod:	move.l	#1,slafs
	rts
rullband:
	move.l	gaddr,a0
	cmp.b	#'c',160(a0)
	bne	ghj
	jsr	right
ghj:	move.l	gsaddr,a0
	cmp.b	#'d',160(a0)
	bne	ghyj
	jsr	left
ghyj:	rts
rutsch:	move.l	#0,ruts
	cmp.l	#0,hoppa
	bne	guhd
	move.l	gaddr,a0
	cmp.b	#'m',160(a0)
	bne	ghd
	move.l	#1,ruts
	add.l	#1,gubbx
	move.l	#0,ramla
	move.l	#0,fall
	jsr	down
	rts
ghd:	move.l	gsaddr,a0
	cmp.b	#'n',160(a0)
	bne	guhd
	move.l	#1,ruts
	sub.l	#1,gubbx
	move.l	#0,fall
	move.l	#0,ramla
	jsr	down
guhd:	rts



huppe:	btst	#7,$bfe001
	bne	nupe
	cmp.l	#0,fall
	bne	nupe
	cmp.l	#0,hoppa
	bne	nupe
	move.l	#3,hoppa
	move.l	#0,hoppctr
	btst	#1,$dff00c
	beq	huft
	move.l	#1,hoppa			
huft:	btst	#1,$dff00d
	beq	huftt
	move.l	#2,hoppa			
huftt:	
nupe:	rts

hopp:	cmp.l	#0,hoppa
	beq	ejhopp
	add.l	#1,hoppctr
	cmp.l	#1,hoppa
	bne	tyu
	jsr	left
tyu:	cmp.l	#2,hoppa
	bne	tayu
	jsr	right
tayu:	cmp.l	#22,hoppctr
	bge	tayus
	jsr	up
	jmp	ejhopp
tayus:	cmp.l	#43,hoppctr
	beq	landat
	move.l	#0,ramla
	jsr	down	
ejhopp:	rts
landat:	move.l	#0,hoppa
	rts	


getgaddrs:
	move.l	gubby,d1
	lsr.l	#3,d1
	mulu	#160,d1
	move.l	gubbx,d2
	lsr.l	#3,d2
	add.l	d2,d1
	move.l	#playground,gaddr
	add.l	d1,gaddr
	move.l	gaddr,gsaddr
	move.l	gubbx,d1
	move.l	gubbx,d2
	lsr.l	#3,d1
	lsl.l	#3,d1
	cmp.l	d1,d2
	beq	coit
	add.l	#1,gsaddr
coit:	rts	

left:	move.l	gsaddr,a2
	cmp.b	#'h',-1(a2)
	beq	nixxe
	cmp.b	#'j',-1(a2)
	beq	nixxe
	cmp.b	#'h',-161(a2)
	beq	nixxe
	cmp.b	#'j',-161(a2)
	beq	nixxe
	move.l	gubby,d2
	and.l	#7,d2
	cmp.l	#0,d2
	beq	wez
	cmp.b	#'h',159(a2)
	beq	nixxe
	cmp.b	#'j',159(a2)
	beq	nixxe
wez:	sub.l	#1,gubbx
nixxe:	rts

right:	move.l	gaddr,a2
	cmp.b	#'h',1(a2)
	beq	nizze
	cmp.b	#'j',1(a2)
	beq	nizze
	cmp.b	#'h',-159(a2)
	beq	nizze
	cmp.b	#'j',-159(a2)
	beq	nizze
	move.l	gubby,d2
	and.l	#7,d2
	cmp.l	#0,d2
	beq	wezz
	cmp.b	#'h',161(a2)
	beq	nizze
	cmp.b	#'j',161(a2)
	beq	nizze
wezz:	add.l	#1,gubbx
nizze:	rts




down:	jsr	getgaddrs
	cmp.l	#28,fall
	bne	lever
	lea	sclrs,a0
	move.w	#$0fff,2(a0)
lever:	cmp.l	#1,aktrapp
	beq	stayput
	move.l	gubby,d0
	and.l	#7,d0
	cmp.b	#0,d0
	beq	ryft
	add.l	#1,gubby
	move.l	ramla,d0
	add.l	d0,fall
	rts
ryft:	move.l	gaddr,a1
	add.l	#160,a1
	jsr	chk
	cmp.l	#0,d3
	beq	stayput
	cmp.b	#'a',(a1)
	bne	ewrt
	cmp.l	#22,hoppctr
	blt	ewrt
	move.l	#0,hoppa
ewrt:	cmp.b	#'b',-160(a1)
	beq	fdhg
	cmp.b	#'b',(a1)
	beq	stayput
fdhg:	cmp.b	#'a',-160(a1)
	beq	fdhgl
	cmp.b	#'a',(a1)
	beq	stayput
fdhgl:	move.l	gsaddr,a1
	add.l	#160,a1
	jsr	chk
	cmp.l	#0,d3
	beq	stayput
	add.l	#1,gubby
	move.l	ramla,d0
	add.l	d0,fall	
	rts
stayput:cmp.l	#0,hoppa
	beq	nhe
	move.l	#0,hoppa
nhe:	lea	sclrs,a0	
	cmp.w	#$0fff,2(a0)
	bne	guxx
	move.l	#1,slafs
guxx:	move.l	#0,fall
	rts
chk:	move.l	#0,d3
	cmp.b	#'h',(a1)
	beq	jah
	cmp.b	#'i',(a1)
	beq	jah
	cmp.b	#'j',(a1)
	beq	jah
	cmp.b	#'c',(a1)
	beq	jah
	cmp.b	#'d',(a1)
	beq	jah
	cmp.b	#'x',(a1)
	beq	jah
	cmp.b	#'y',(a1)
	beq	jah
	cmp.b	#'w',(a1)
	beq	jah
	cmp.b	#0,ch5
	beq	ert
	cmp.b	#'e',(a1)
	beq	jah
ert:	move.l	#1,d3
jah:	rts
up:	jsr	getgaddrs
	move.l	gubby,d0
	and.l	#7,d0
	cmp.b	#0,d0
	beq	dryft
	sub.l	#1,gubby
	rts
dryft:	move.l	gaddr,a0
	cmp.b	#'h',-320(a0)
	beq	staypuut
	cmp.b	#'j',-320(a0)
	beq	staypuut
	move.l	gsaddr,a0
	cmp.b	#'h',-320(a0)
	beq	staypuut
	cmp.b	#'j',-320(a0)
	beq	staypuut
	sub.l	#1,gubby
	rts
staypuut:rts

akatrappa:
	move.l	#0,aktrapp
	move.l	gaddr,a0
	cmp.l	gsaddr,a0
	bne	ght
	cmp.b	#'b',(a0)
	beq	fyg
ght:	cmp.b	#'a',(a0)
	beq	fyg
	move.l	gubby,d0
	and.l	#7,d0
	cmp.l	#0,d0
	beq	nejjjj
	move.l	gaddr,a0
	cmp.l	gsaddr,a0
	bne	ghht
	cmp.b	#'b',160(a0)
	beq	fyg
ghht:	cmp.b	#'a',160(a0)
	beq	fyg
	rts
fyg:	jsr 	up
	move.l	#1,aktrapp
nejjjj:	rts


Loadfile:
	move.l	d0,d6
	move.l	dosbase,a6
	move.l	a0,d1
	move.l	#$3ed,d2
	jsr	Open(a6)
	move.l	d6,d2
	move.l	d0,d1
	move.l	d0,d6
	cmp.l	#0,d6
	beq	endlf
	move.l	#$10000,d3
	jsr	Read(a6)
	move.l	d6,d1
	jsr	Close(a6)	
endlf:	move.l	sysbase,a6
	move.l	d6,d0
	rts
draw:	lea	playground,a1
	move.l	#0,d6
dlp:	move.l	d6,d0
	clr.l	d1
	move.b	(a1)+,d1
	cmp.b	#'v',d1
	bne	ezz
	move.b	#'u',d1
	move.b	#'u',-1(a1)
ezz:	jsr	writech
	add.l	#1,edika
	cmp.l	#100,edika
	bne	nij
	jsr	rsync
	move.l	#0,edika
nij:	add.l	#1,d6
	cmp.l	#10240,d6
	bne	dlp	
	rts
Writech:move.l	d0,d2
	divu	#160,d2
	move.l	d2,d3
	mulu	#1280,d2
	mulu	#160,d3
	neg.l	d3
	add.l	d0,d3
	add.l	d3,d2
	move.l	membase,a3
	add.l	d2,a3
	move.l 	chars,a0
	and.l	#31,d1
	add.l	d1,a0
	move.b	(a0),(a3)
	move.b	40(a0),160(a3)
	move.b	80(a0),320(a3)
	move.b	120(a0),480(a3)
	move.b	160(a0),640(a3)
	move.b	200(a0),800(a3)
	move.b	240(a0),960(a3)
	move.b	280(a0),1120(a3)
	add.l	#81920,a3
	move.b	8000(a0),(a3)
	move.b	8040(a0),160(a3)
	move.b	8080(a0),320(a3)
	move.b	8120(a0),480(a3)
	move.b	8160(a0),640(a3)
	move.b	8200(a0),800(a3)
	move.b	8240(a0),960(a3)
	move.b	8280(a0),1120(a3)
	rts
Plotscn:lea	cpr,a2
	move.l	d0,d2
	lsr     #4,d2
	move.l	d2,d6
	asl	#4,d2
	sub.l	d2,d0
	neg.l	d0
	add.l	#15,d0
	move.l	d0,d2
	asl.l	#4,d2
	add.l	d0,d2
	move.b	d2,51(a2)		
	mulu	#160,d1
	add.l	membase,d1
	asl.l	#1,d6
	add.l	d6,d1
	swap	d1
	move.w	d1,2(a2)
	swap	d1
	move.w	d1,6(a2)
	add.l	#81920,d1
	swap	d1
	move.w	d1,10(a2)
	swap	d1
	move.w	d1,14(a2)
	rts
ritagubben:
	move.l	gubbg,d0
	and.l	#6,d0
	add.l	gubbh,d0
ritagubbe:
	move.l	chars,a2
	add.l	#3520,a2
	add.l	d0,a2
	lea	gdata,a1
	move.l	#15,d0
ritz:	move.w	(a2),(a1)+
	move.w	8000(a2),(a1)+
	add.l	#40,a2
	dbra	d0,ritz
	rts
uppdat:	move.l	#playground,d0
	move.l	gaddr,d1
	sub.l	#1618,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	d1,d2
	divu	#160,d2
	move.l	d2,d3
	mulu	#1280,d2
	mulu	#160,d3
	neg.l	d3
	add.l	d0,d3
	add.l	d3,d2
	move.l	membase,a3
	add.l	d2,a3
	move.l	gaddr,a0
	sub.l	#1618,a0
	move.l	#19,d1
liloop:	move.l	a0,a1
	move.l	a3,a2
	move.l	#39,d2
bloop:	move.b  (a1),d0
	cmp.b	#32,d0
	beq	byyp
	and.b	#24,d0
	cmp.b	#0,d0
	bne	byyp
	jsr	andra
byyp:	add.l	#1,a2
	add.l	#1,a1
	dbra	d2,bloop
	add.l	#160,a0
	add.l	#1280,a3
	dbra	d1,liloop
	rts
	
andra:	clr.l	d0
	move.b	(a1),d0
	and.b	#7,d0
	sub.b	#1,d0
	lsl.b	#3,d0
	lea	ch1,a4
	add.l	d0,a4
	move.b	(a4),(a2)
	move.b	1(a4),160(a2)
	move.b	2(a4),320(a2)
	move.b	3(a4),480(a2)
	move.b	4(a4),640(a2)
	move.b	5(a4),800(a2)
	move.b	6(a4),960(a2)
	move.b	7(a4),1120(a2)
	rts

livingchars:
	move.l	tsteg,d0
	lea	ch1,a1
	and.l	#7,d0
	move.l	a1,a2
	add.l	d0,a2	
	move.b	#64,(a2)
	move.b	#2,8(a2)
	sub.l	#1,tsteg
	move.l	tsteg,d0	
	and.l	#7,d0
	move.l	a1,a2
	add.l	d0,a2	
	move.b	#127,(a2)
	move.b	#254,8(a2)
	ror.w	#1,rugr
	rol.w	#1,rugl
	lea	ch3,a2
	move.w	rugr,d0
	move.w	d0,(a2)
	move.w	d0,14(a2)
	move.w	rugl,d0
	move.w	d0,6(a2)
	move.w	d0,8(a2)
	add.l	#1,skajag
	move.l	skajag,d0
	and.l	#7,d0
	cmp.l	#0,d0
	bne	jaaaa
	move.l	footctr,d0
	lea	ch5,a2
	lea	footholddata,a1
	add.l	d0,a1
	clr.l	d1
	move.b	(a1),d1
	add.l	d1,a2
	move.b  1(a1),d1
	move.b	d1,(a2)
	add.l	#2,footctr
	cmp.b	#13,2(a1)
	bne	jaaaa
	move.l	#0,footctr	
jaaaa:	rts	

gubbdo:	move.l	#16,d4
	lea	sclrs,a0
	move.w	#$0faa,2(a0)
blowup:	move.l	d4,d0
	jsr	ritagubbe
	jsr	rsync
	jsr	rsync
	jsr	rsync
	jsr	rsync
	jsr	rsync
	add.l	#2,d4
	cmp.l	#38,d4
	bne	blowup
	rts
blackout:
	lea	clrs,a0
	move.w	#0,2(a0)
	move.w	#0,6(a0)
	move.w	#0,10(a0)
	move.w	#0,14(a0)
	rts
lightson:
	lea	clrs,a0
	move.w	#$0888,2(a0)
	move.w	#$0000,6(a0)
	move.w	#$0eee,10(a0)
	move.w	#$004f,14(a0)
	rts
clearinfo:
	move.l	infoscr,a0
	move.l	#3998,d0
scnclr:	clr.b	(a0)+
	dbra	d0,scnclr
	rts
	
drawinfo:move.l	level,d0
	lsl.l	#5,d0
	add.l	d0,a0	
	move.l	infoscr,a1
	add.l	#642,a1
	jsr	drawline
	move.l	level,d0
	and.l	#15,d0
	add.l	#49,d0
	lea	airline,a0
	move.b	d0,7(a0)
	lea	airline,a0
	move.l	infoscr,a1
	add.l	#1122,a1
	jsr	drawline
	lea	scline,a0
	move.l	infoscr,a1
	add.l	#1602,a1
	jsr	drawline
	lea	lifeline,a0
	move.l	lives,d0
	add.l	#48,d0
	move.b	d0,7(a0)
	move.l	infoscr,a1
	add.l	#2082,a1
	jsr	drawline
	rts
	
drawline:
	move.l	#31,d0
	clr.l	d1
	move.l	chars,a2
	add.l	#2560,a2
qwerty:	move.b	(a0)+,d1
	move.l	a2,a3
	cmp.b	#32,d1
	beq	ewq
	cmp.b	#60,d1
	bge	ewq
	add.l	#320,a3
	and.l	#15,d1
ewq:	and.l	#31,d1
	add.l	d1,a3
	move.b	(a3),(a1)
	move.b	40(a3),40(a1)
	move.b	80(a3),80(a1)
	move.b	120(a3),120(a1)
	move.b	160(a3),160(a1)
	move.b	200(a3),200(a1)
	move.b	240(a3),240(a1)
	move.b	280(a3),280(a1)
	add.l	#1,a1
	dbra	d0,qwerty
	rts	
spritesetup:
	lea	zprite,a0
	move.l	#spr0,d0
	jsr	bestam
	add.l	#8,a0
	move.l	#spr1,d0
	jsr	bestam
	add.l	#8,a0
	move.l	#spr2,d0
	jsr	bestam
	add.l	#8,a0
	move.l	#spr3,d0
	jsr	bestam
	add.l	#8,a0
	move.l	#spr4,d0
	jsr	bestam
	add.l	#8,a0
	move.l	#spr5,d0
	jsr	bestam
	lea	nouse,a0
	move.l	#nospr,d0
	rts
bestam:	move.w	d0,6(a0)
	swap	d0
	move.w	d0,2(a0)
	rts
	
spritestartup:
	move.l	level,d0
	mulu	#192,d0
	lea	levelsprites,a0
	add.l	d0,a0
	lea	sprs0,a1
	jsr	plocka
	add.l	#32,a0
	lea	sprs1,a1	
	jsr 	plocka
	add.l	#32,a0
	lea	sprs2,a1	
	jsr 	plocka
	add.l	#32,a0
	lea	sprs3,a1	
	jsr 	plocka
	add.l	#32,a0
	lea	sprs4,a1	
	jsr 	plocka
	add.l	#32,a0
	lea	sprs5,a1	
	jsr 	plocka
	rts
plocka:	move.l	(a0),(a1)
	move.w	4(a0),4(a1)
	clr.w	6(a1)
	move.w	6(a0),8(a1)
	clr.w	10(a1)
	move.l	8(a0),12(a1)
	move.l	12(a0),16(a1)
	move.l	16(a0),20(a1)
	move.l	20(a0),24(a1)
	move.l	24(a0),28(a1)
	move.w	28(a0),32(a1)
	rts
spritesgone:
	move.l	#0,spr0
	move.l	#0,spr1
	move.l	#0,spr2
	move.l	#0,spr3
	move.l	#0,spr4
	move.l	#0,spr5
	rts
zpritte:lea	sprs0,a0
	lea	spr0,a1
	move.l	#zclrs0,d1	
	jsr	handle	
	lea	sprs1,a0
	lea	spr1,a1
	move.l	#trash,d1	
	jsr	handle	
	lea	sprs2,a0
	lea	spr2,a1
	move.l	#zclrs1,d1	
	jsr	handle	
	lea	sprs3,a0
	lea	spr3,a1
	move.l	#trash,d1	
	jsr	handle	
	lea	sprs4,a0
	lea	spr4,a1
	move.l	#zclrs2,d1	
	jsr	handle	
	lea	sprs5,a0
	lea	spr5,a1
	move.l	#trash,d1	
	jsr	handle	
	rts
handle:	cmp.w	#0,(a0)
	beq	outta
	add.w	#1,10(a0)
	move.w	10(a0),d0
	cmp.w	8(a0),d0
	bne	neeeee
	move.w	#0,10(a0)
	move.w	20(a0),d0
	add.w	d0,30(a0)
	move.w	30(a0),d0
	cmp.w	12(a0),d0
	bne	nee
	neg.w	20(a0)
nee:	cmp.w	14(a0),d0
	bne	neee
	neg.w	20(a0)
neee:	move.w	22(a0),d0
	add.w	d0,32(a0)
	move.w	32(a0),d0
	cmp.w	16(a0),d0
	bne	neeee
	neg.w	22(a0)
neeee:	cmp.w	18(a0),d0
	bne	neeeee
	neg.w	22(a0)
neeeee:	add.w	#1,6(a0)
	move.w	4(a0),d0
	cmp.w	6(a0),d0
	bne	selik
	move.w	#0,6(a0)
	eor.w	#2,2(a0)
selik:	move.l	d1,a2
	move.w	24(a0),2(a2)
	move.w	26(a0),6(a2)
	move.w	28(a0),10(a2)
	clr.l	d0
	move.w	32(a0),d0
	sub.l	gubby,d0
	add.l	#$70,d0
	cmp.w	#10,d0
	blt	outta
	cmp.w	#$c0,d0
	bge	outta
	move.b	d0,(a1)
	add.l	#23,d0
	move.b	d0,2(a1)
	cmp.w	#$c0,d0
	blt	ovan
	move.b	#$c0,2(a1)
ovan:	move.w	30(a0),d0
	sub.l	gubbx,d0
	add.l	#268,d0
	cmp.w	#100,d0
	blt	outta
	cmp.w	#480,d0
	bge	outta
	move.w	d0,d1
	and.l	#1,d1
	move.b	d1,3(a1)
	lsr.w	#1,d0
	move.b	d0,1(a1)
	move.l	#22,d1
	move.l	chars,a3
	move.w	2(a0),d0
	add.l	d0,a3
	add.l	#4480,a3
reeta:	move.w	(a3),4(a1)
	move.w	8000(a3),6(a1)			
	add.l	#4,a1
	add.l	#40,a3
	dbra	d1,reeta
	rts
outta:	move.l	#0,(a1)
	rts

;нннннннннннннннннннннннннннннннннннннн
;н   NoisetrackerV2.0 Normal replay   н
;н     Uses registers d0-d3/a0-a5     н
;н Mahoney & Kaktus - (C) E.A.S. 1990 н
;нннннннннннннннннннннннннннннннннннннн

;mt_data=$58000

mt_init:movem.l	d0-d2/a0-a2,-(a7)
	move.l	mtdata,a0
	lea	$3b8(a0),a1
	moveq	#$7f,d0
	moveq	#0,d2
	moveq	#0,d1
mt_lop2:move.b	(a1)+,d1
	cmp.b	d2,d1
	ble.s	mt_lop
	move.l	d1,d2
mt_lop:	dbf	d0,mt_lop2
	addq.b	#1,d2

	asl.l	#8,d2
	asl.l	#2,d2
	lea	4(a1,d2.l),a2
	lea	mt_samplestarts(pc),a1
	add.w	#42,a0
	moveq	#$1e,d0
mt_lop3:clr.l	(a2)
	move.l	a2,(a1)+
	moveq	#0,d1
	move.w	(a0),d1
	asl.l	#1,d1
	add.l	d1,a2
	add.l	#$1e,a0
	dbf	d0,mt_lop3

	or.b	#2,$bfe001
	move.b	#6,mt_speed
	moveq	#0,d0
	lea	$dff000,a0
	move.w	d0,$a8(a0)
	move.w	d0,$b8(a0)
	move.w	d0,$c8(a0)
	move.w	d0,$d8(a0)
	clr.b	mt_songpos
	clr.b	mt_counter
	clr.w	mt_pattpos
	movem.l	(a7)+,d0-d2/a0-a2
	rts

mt_end:	clr.w	$dff0a8
	clr.w	$dff0b8
	clr.w	$dff0c8
	clr.w	$dff0d8
	move.w	#$f,$dff096
	rts


mt_music:
	movem.l	d0-d3/a0-a5,-(a7)
	move.l	mtdata,a0
	addq.b	#1,mt_counter
	move.b	mt_counter(pc),d0
	cmp.b	mt_speed(pc),d0
	blt	mt_nonew
	clr.b	mt_counter

	move.l  mtdata,a0
	lea	$c(a0),a3
	lea	$3b8(a0),a2
	lea	$43c(a0),a0

	moveq	#0,d0
	moveq	#0,d1
	move.b	mt_songpos(pc),d0
	move.b	(a2,d0.w),d1
	lsl.w	#8,d1
	lsl.w	#2,d1
	add.w	mt_pattpos(pc),d1
	clr.w	mt_dmacon

	lea	$dff0a0,a5
	lea	mt_voice1(pc),a4
	bsr	mt_playvoice
	addq.l	#4,d1
	lea	$dff0b0,a5
	lea	mt_voice2(pc),a4
	bsr	mt_playvoice
	addq.l	#4,d1
	lea	$dff0c0,a5
	lea	mt_voice3(pc),a4
	bsr	mt_playvoice
	addq.l	#4,d1
	lea	$dff0d0,a5
	lea	mt_voice4(pc),a4
	bsr	mt_playvoice

	move.w	mt_dmacon(pc),d0
	beq.s	mt_nodma

	bsr	mt_wait
	or.w	#$8000,d0
	move.w	d0,$dff096
	bsr	mt_wait
mt_nodma:
	lea	mt_voice1(pc),a4
	lea	$dff000,a3
	move.l	$a(a4),$a0(a3)
	move.w	$e(a4),$a4(a3)
	move.l	$a+$1c(a4),$b0(a3)
	move.w	$e+$1c(a4),$b4(a3)
	move.l	$a+$38(a4),$c0(a3)
	move.w	$e+$38(a4),$c4(a3)
	move.l	$a+$54(a4),$d0(a3)
	move.w	$e+$54(a4),$d4(a3)

	add.w	#$10,mt_pattpos
	cmp.w	#$400,mt_pattpos
	bne.s	mt_exit
mt_next:clr.w	mt_pattpos
	clr.b	mt_break
	addq.b	#1,mt_songpos
	and.b	#$7f,mt_songpos
	move.b	-2(a2),d0
	cmp.b	mt_songpos(pc),d0
	bne.s	mt_exit
	move.b	-1(a2),mt_songpos
mt_exit:tst.b	mt_break
	bne.s	mt_next
	movem.l	(a7)+,d0-d3/a0-a5
	rts

mt_wait:moveq	#3,d3
mt_wai2:move.b	$dff006,d2
mt_wai3:cmp.b	$dff006,d2
	beq.s	mt_wai3
	dbf	d3,mt_wai2
	moveq	#8,d2
mt_wai4:dbf	d2,mt_wai4
	rts

mt_nonew:
	lea	mt_voice1(pc),a4
	lea	$dff0a0,a5
	bsr	mt_com
	lea	mt_voice2(pc),a4
	lea	$dff0b0,a5
	bsr	mt_com
	lea	mt_voice3(pc),a4
	lea	$dff0c0,a5
	bsr	mt_com
	lea	mt_voice4(pc),a4
	lea	$dff0d0,a5
	bsr	mt_com
	bra.s	mt_exit

mt_mulu:
dc.w $000,$01e,$03c,$05a,$078,$096,$0b4,$0d2,$0f0,$10e,$12c,$14a
dc.w $168,$186,$1a4,$1c2,$1e0,$1fe,$21c,$23a,$258,$276,$294,$2b2
dc.w $2d0,$2ee,$30c,$32a,$348,$366,$384,$3a2

mt_playvoice:
	move.l	(a0,d1.l),(a4)
	moveq	#0,d2
	move.b	2(a4),d2
	lsr.b	#4,d2
	move.b	(a4),d0
	and.b	#$f0,d0
	or.b	d0,d2
	beq.s	mt_oldinstr

	lea	mt_samplestarts-4(pc),a1
	asl.w	#2,d2
	move.l	(a1,d2.l),4(a4)
	lsr.w	#1,d2
	move.w	mt_mulu(pc,d2.w),d2
	move.w	(a3,d2.w),8(a4)
	move.w	2(a3,d2.w),$12(a4)
	moveq	#0,d3
	move.w	4(a3,d2.w),d3
	tst.w	d3
	beq.s	mt_noloop
	move.l	4(a4),d0
	asl.w	#1,d3
	add.l	d3,d0
	move.l	d0,$a(a4)
	move.w	4(a3,d2.w),d0
	add.w	6(a3,d2.w),d0
	move.w	d0,8(a4)
	bra.s	mt_hejaSverige
mt_noloop:
	move.l	4(a4),d0
	add.l	d3,d0
	move.l	d0,$a(a4)
mt_hejaSverige:
	move.w	6(a3,d2.w),$e(a4)
	moveq	#0,d0
	move.b	$13(a4),d0
	move.w	d0,8(a5)

mt_oldinstr:
	move.w	(a4),d0
	and.w	#$fff,d0
	beq	mt_com2
	tst.w	8(a4)
	beq.s	mt_stopsound
	tst.b	$12(a4)
	bne.s	mt_stopsound
	move.b	2(a4),d0
	and.b	#$f,d0
	cmp.b	#5,d0
	beq.s	mt_setport
	cmp.b	#3,d0
	beq.s	mt_setport

	move.w	(a4),$10(a4)
	and.w	#$fff,$10(a4)
	move.w	$1a(a4),$dff096
	clr.b	$19(a4)

	move.l	4(a4),(a5)
	move.w	8(a4),4(a5)
	move.w	$10(a4),6(a5)

	move.w	$1a(a4),d0	;dmaset
	or.w	d0,mt_dmacon
	bra	mt_com2

mt_stopsound:
	move.w	$1a(a4),$dff096
	bra	mt_com2

mt_setport:
	move.w	(a4),d2
	and.w	#$fff,d2
	move.w	d2,$16(a4)
	move.w	$10(a4),d0
	clr.b	$14(a4)
	cmp.w	d0,d2
	beq.s	mt_clrport
	bge	mt_com2
	move.b	#1,$14(a4)
	bra	mt_com2
mt_clrport:
	clr.w	$16(a4)
	rts

mt_port:move.b	3(a4),d0
	beq.s	mt_port2
	move.b	d0,$15(a4)
	clr.b	3(a4)
mt_port2:
	tst.w	$16(a4)
	beq.s	mt_rts
	moveq	#0,d0
	move.b	$15(a4),d0
	tst.b	$14(a4)
	bne.s	mt_sub
	add.w	d0,$10(a4)
	move.w	$16(a4),d0
	cmp.w	$10(a4),d0
	bgt.s	mt_portok
	move.w	$16(a4),$10(a4)
	clr.w	$16(a4)
mt_portok:
	move.w	$10(a4),6(a5)
mt_rts:	rts

mt_sub:	sub.w	d0,$10(a4)
	move.w	$16(a4),d0
	cmp.w	$10(a4),d0
	blt.s	mt_portok
	move.w	$16(a4),$10(a4)
	clr.w	$16(a4)
	move.w	$10(a4),6(a5)
	rts

mt_sin:
dc.b $00,$18,$31,$4a,$61,$78,$8d,$a1,$b4,$c5,$d4,$e0,$eb,$f4,$fa,$fd
dc.b $ff,$fd,$fa,$f4,$eb,$e0,$d4,$c5,$b4,$a1,$8d,$78,$61,$4a,$31,$18

mt_vib:	move.b	$3(a4),d0
	beq.s	mt_vib2
	move.b	d0,$18(a4)

mt_vib2:move.b	$19(a4),d0
	lsr.w	#2,d0
	and.w	#$1f,d0
	moveq	#0,d2
	move.b	mt_sin(pc,d0.w),d2
	move.b	$18(a4),d0
	and.w	#$f,d0
	mulu	d0,d2
	lsr.w	#7,d2
	move.w	$10(a4),d0
	tst.b	$19(a4)
	bmi.s	mt_vibsub
	add.w	d2,d0
	bra.s	mt_vib3
mt_vibsub:
	sub.w	d2,d0
mt_vib3:move.w	d0,6(a5)
	move.b	$18(a4),d0
	lsr.w	#2,d0
	and.w	#$3c,d0
	add.b	d0,$19(a4)
	rts


mt_arplist:
dc.b 0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1,2,0,1

mt_arp:	moveq	#0,d0
	move.b	mt_counter(pc),d0
	move.b	mt_arplist(pc,d0.w),d0
	beq.s	mt_arp0
	cmp.b	#2,d0
	beq.s	mt_arp2
mt_arp1:moveq	#0,d0
	move.b	3(a4),d0
	lsr.b	#4,d0
	bra.s	mt_arpdo
mt_arp2:moveq	#0,d0
	move.b	3(a4),d0
	and.b	#$f,d0
mt_arpdo:
	asl.w	#1,d0
	move.w	$10(a4),d1
	and.w	#$fff,d1
	lea	mt_periods(pc),a0
	moveq	#$24,d2
mt_arp3:cmp.w	(a0)+,d1
	bge.s	mt_arpfound
	dbf	d2,mt_arp3
mt_arp0:move.w	$10(a4),6(a5)
	rts
mt_arpfound:
	move.w	-2(a0,d0.w),6(a5)
	rts

mt_normper:
	move.w	$10(a4),6(a5)
	rts

mt_com:	move.w	2(a4),d0
	and.w	#$fff,d0
	beq.s	mt_normper
	move.b	2(a4),d0
	and.b	#$f,d0
	tst.b	d0
	beq.s	mt_arp
	cmp.b	#1,d0
	beq.s	mt_portup
	cmp.b	#2,d0
	beq.s	mt_portdown
	cmp.b	#3,d0
	beq	mt_port
	cmp.b	#4,d0
	beq	mt_vib
	cmp.b	#5,d0
	beq.s	mt_volport
	cmp.b	#6,d0
	beq.s	mt_volvib
	move.w	$10(a4),6(a5)
	cmp.b	#$a,d0
	beq.s	mt_volslide
	rts

mt_portup:
	moveq	#0,d0
	move.b	3(a4),d0
	sub.w	d0,$10(a4)
	move.w	$10(a4),d0
	cmp.w	#$71,d0
	bpl.s	mt_portup2
	move.w	#$71,$10(a4)
mt_portup2:
	move.w	$10(a4),6(a5)
	rts

mt_portdown:
	moveq	#0,d0
	move.b	3(a4),d0
	add.w	d0,$10(a4)
	move.w	$10(a4),d0
	cmp.w	#$358,d0
	bmi.s	mt_portdown2
	move.w	#$358,$10(a4)
mt_portdown2:
	move.w	$10(a4),6(a5)
	rts

mt_volvib:
	 bsr	mt_vib2
	 bra.s	mt_volslide
mt_volport:
	 bsr	mt_port2

mt_volslide:
	moveq	#0,d0
	move.b	3(a4),d0
	lsr.b	#4,d0
	beq.s	mt_vol3
	add.b	d0,$13(a4)
	cmp.b	#$40,$13(a4)
	bmi.s	mt_vol2
	move.b	#$40,$13(a4)
mt_vol2:moveq	#0,d0
	move.b	$13(a4),d0
	move.w	d0,8(a5)
	rts

mt_vol3:move.b	3(a4),d0
	and.b	#$f,d0
	sub.b	d0,$13(a4)
	bpl.s	mt_vol4
	clr.b	$13(a4)
mt_vol4:moveq	#0,d0
	move.b	$13(a4),d0
	move.w	d0,8(a5)
	rts

mt_com2:move.b	$2(a4),d0
	and.b	#$f,d0
	cmp.b	#$e,d0
	beq.s	mt_filter
	cmp.b	#$d,d0
	beq.s	mt_pattbreak
	cmp.b	#$b,d0
	beq.s	mt_songjmp
	cmp.b	#$c,d0
	beq.s	mt_setvol
	cmp.b	#$f,d0
	beq.s	mt_setspeed
	rts

mt_filter:
	move.b	3(a4),d0
	and.b	#1,d0
	asl.b	#1,d0
	and.b	#$fd,$bfe001
	or.b	d0,$bfe001
	rts

mt_pattbreak:
	move.b	#1,mt_break
	rts

mt_songjmp:
	move.b	#1,mt_break
	move.b	3(a4),d0
	subq.b	#1,d0
	move.b	d0,mt_songpos
	rts

mt_setvol:
	cmp.b	#$40,3(a4)
	bls.s	mt_sv2
	move.b	#$40,3(a4)
mt_sv2:	moveq	#0,d0
	move.b	3(a4),d0
	move.b	d0,$13(a4)
	move.w	d0,8(a5)
	rts

mt_setspeed:
	moveq	#0,d0
	move.b	3(a4),d0
	cmp.b	#$1f,d0
	bls.s	mt_sp2
	moveq	#$1f,d0
mt_sp2:	tst.w	d0
	bne.s	mt_sp3
	moveq	#1,d0
mt_sp3:	move.b	d0,mt_speed
	rts

mt_periods:
dc.w $0358,$0328,$02fa,$02d0,$02a6,$0280,$025c,$023a,$021a,$01fc,$01e0
dc.w $01c5,$01ac,$0194,$017d,$0168,$0153,$0140,$012e,$011d,$010d,$00fe
dc.w $00f0,$00e2,$00d6,$00ca,$00be,$00b4,$00aa,$00a0,$0097,$008f,$0087
dc.w $007f,$0078,$0071,$0000

mt_speed:	dc.b	6
mt_counter:	dc.b	0
mt_pattpos:	dc.w	0
mt_songpos:	dc.b	0
mt_break:	dc.b	0
mt_dmacon:	dc.w	0
mt_samplestarts:blk.l	$1f,0
mt_voice1:	blk.w	13,0
		dc.w	1
mt_voice2:	blk.w	13,0
		dc.w	2
mt_voice3:	blk.w	13,0
		dc.w	4
mt_voice4:	blk.w	13,0
		dc.w	8

introduction:
	lea	intrline,a0
	move.l	infoscr,a1
	add.l	#1122,a1
	jsr	drawline
	lea	fireline,a0
	move.l	infoscr,a1
	add.l	#1602,a1
	jsr	drawline
	lea	scrolltext,a0
	move.l	a0,scrlctr
	move.l	#0,chctr
scrolla:move.l	infoscr,d1
	add.l	#2242,d1
	and.l	#$fffffffe,d1
	move.l	d1,a1
	lea	scchr,a0
	move.l	#7,d1
scrline: roxl.w	(a0)
	roxl.w	38(a1)
	roxl.w	36(a1)
	roxl.w	34(a1)
	roxl.w	32(a1)
	roxl.w	30(a1)
	roxl.w	28(a1)
	roxl.w	26(a1)
	roxl.w	24(a1)
	roxl.w	22(a1)
	roxl.w	20(a1)
	roxl.w	18(a1)
	roxl.w	16(a1)
	roxl.w	14(a1)
	roxl.w	12(a1)
	roxl.w	10(a1)
	roxl.w	8(a1)
	roxl.w	6(a1)
	roxl.w	4(a1)
	roxl.w	2(a1)
	roxl.w	(a1)
	add.l	#40,a1
	add.l	#2,a0
	dbra	d1,scrline
	add.l	#1,chctr
	cmp.l	#8,chctr
	bne	fwait
	move.l	scrlctr,a0
	move.b	(a0),d0
	cmp.b	#0,d0
	bne	ej0
	lea	scrolltext,a0
	move.l	a0,scrlctr
	move.l	#32,d0
ej0:	add.l	#1,scrlctr
	move.l	#0,chctr
	move.l	chars,a2
	add.l	#2560,a2
	move.b	d0,d1
	and.b	#$70,d1
	cmp.b	#$20,d1
	bne 	bulle
	sub.l	#320,a2
bulle:	cmp.b	#$30,d1
	bne 	bulle1
	add.l	#320,a2
	and.l	#15,d0
bulle1:	and.l	#31,d0
	add.l	d0,a2
	lea	scchr,a0
	move.b	(a2),(a0)
	move.b	40(a2),2(a0)
	move.b	80(a2),4(a0)
	move.b	120(a2),6(a0)
	move.b	160(a2),8(a0)
	move.b	200(a2),10(a0)
	move.b	240(a2),12(a0)
	move.b	280(a2),14(a0)
fwait:	jsr	realrsync
	btst	#7,$bfe001
	bne	scrolla
	move.l	#scchr,a0
	move.l	#0,(a0)
	move.l	#0,4(a0)
	move.l	#0,8(a0)
	move.l	#0,12(a0)
	rts	



chfile:	dc.b	'blagger',0
pgfile:	dc.b	'pg',0
musfile:dc.b	'jomus',0

Dosname:dc.b	'dos.library',0
Gfxname:dc.b	'graphics.library',0

even
Dosbase:dc.l	0
GfxBase:dc.l	0
copbase:dc.l	0
Oldcop:	dc.l	0
Membase:dc.l	0
chars:	dc.l	0
bakgr:	dc.l	0
infoscr:dc.l	0
mtdata: dc.l	0
level:	dc.l	0
gmod:	dc.l	0
gubbg:	dc.l	0
gubbf:	dc.l 	0
gubbx:	dc.l	0
gubby:	dc.l	0
gubbh:	dc.l	0
gaddr:	dc.l	0
gsaddr:	dc.l	0
offset:	dc.l	0
fall:	dc.l	0
hoppa:	dc.l	0
hoppctr:dc.l	0
aktrapp:dc.l	0
ruts:	dc.l	0
tsteg:	dc.l	0
rugr:	dc.w	0
rugl:	dc.w	0	
gamy:	dc.l	0
footctr:dc.l	0
skajag:	dc.l	0
ramla:	dc.l	0
slafs:	dc.l	0
nycklar:dc.l	0
nyckn:	dc.l	0	
klarat:	dc.l	0
detect:	dc.l	0
edika:	dc.l	0
lives:	dc.l	9
scrlctr:dc.l	0
chctr:	dc.l	0
Cpr:	dc.w	$00e0,$0000,$00e2,$c808,$00e4,$0000,$00e6,$e808
pblank:	dc.w	$00e8,$0000,$00ea,$0000
	dc.w	$0100,$3300,$008e,$2c81,$0090,$10ba,$0092,$0030
	dc.w	$0108,$0077,$010a,$0077,$0102,$00ff,$0094,$00d0
sprite:	dc.w	$0120,$0000,$0122,$0000,$0098,$e000
nouse:	dc.w	$0124,$0000,$0126,$0000
zprite:	dc.w	$0128,$0000,$012a,$0000,$012c,$0000,$012e,$0000
	dc.w	$0130,$0000,$0132,$0000,$0134,$0000,$0136,$0000
	dc.w	$0138,$0000,$013a,$0000,$013c,$0000,$013e,$0000
sclrs:	dc.w	$01a2,$0faa,$01a4,$0a40,$01a6,$0dd0	
zclrs0:	dc.w	$01aa,$0fac,$01ac,$0660,$01ae,$0dd0	
zclrs1:	dc.w	$01b2,$0f00,$01b4,$00f0,$01b6,$000f	
zclrs2:	dc.w	$01ba,$0f00,$01bc,$00f0,$01be,$000f	
	dc.w	$0180,$0000,$0182,$0000,$0184,$004f,$0186,$004f
clrs:	dc.w	$0188,$0888,$018a,$0000,$018c,$004f,$018e,$004f
low:	dc.w	$c001,$fffe,$0100,$1300,$0180,$0000,$0182,$0888
info:	dc.w	$00e0,$0000,$00e2,$0000
	dc.w	$01aa,$0000,$01ac,$0000,$01ae,$0000	
	dc.w	$01b2,$0000,$01b4,$0000,$01b6,$0000	
	dc.w	$01ba,$0000,$01bc,$0000,$01be,$0000	
	dc.w	$0108,$ffff,$010a,$ffff,$0102,$0000	
	dc.w	$d801,$fffe,$0182,$0c66
	dc.w	$e401,$fffe,$0182,$0099
	dc.w	$f201,$fffe,$0182,$0bb0
	dc.w	$ffff,$fffe

varchars:
ch1:	dc.b	63,0,0,0,0,0,0,0
ch2:	dc.b	252,0,0,0,0,0,0,0
ch3:	dc.b	102,102,0,102,102,0,102,102
ch4:	dc.b	102,102,0,102,102,0,102,102
ch5:	dc.b	255,102,255,102,255,102,255,102

even
scchr:  dc.l	0,0,0,0,0,0
even
gubbsprite:
	dc.w	$7086,$8000
gdata:	dc.l	10,20,30,40,50,60,0,80,90,50,30,50,0,20,30,40,0
footholddata:
	dc.b	0,255,1,102,2,255,3,102,4,255,5,102,6,255,7,102
	dc.b	7,102,7,0,6,0,5,0,4,0,3,0,2,0,1,0,0,0,0,0
	dc.b	0,0,13,13,13,13

intrline:dc.b	'     Welcome to jonas fulstrand '
fireline:dc.b	'            press fire          '
airline: dc.b   ' level 0                        '
scline:	 dc.b	' score 000000                   '
lifeline:dc.b	' lives 3                        '
gotxt:	 dc.b   '              game over         '
levline: dc.b	' Welcome to the first level     '
	 dc.b	' this is the toilet paper level '
	 dc.b	' level three yessiree           '
	 dc.b   ' Gnuff gnuff uhu                '
	 dc.b   ' i killed laura palmer          '
	 dc.b   ' aargh   pommes fritzen flyr    '
	 dc.b	' var alltid bizarr              '
	 dc.b   ' congratulations   You did it   '
even

trash:	dc.l	0,0,0
nospr:	dc.l	0,0,0,0,0,0
leveldata:
	dc.l	338,176,4,0
	dc.l	600,136,5,0
	dc.l	672,248,7,0
	dc.l	184,384,6,0
	dc.l	608,352,2,0
	dc.l	856,344,6,0
	dc.l	1056,376,3,0
	dc.l	824,128,4,0

sprs0:	dc.w	1,0,25,0,1,0,0,0,135,215,0,1,$f11,$000,$fff,268,186
sprs1:	dc.l	0,0,0,0,0,0,0,0,0
sprs2:	dc.l	0,0,0,0,0,0,0,0,0
sprs3:	dc.l	0,0,0,0,0,0,0,0,0
sprs4:	dc.l	0,0,0,0,0,0,0,0,0
sprs5:	dc.l	0,0,0,0,0,0,0,0,0

spr0:	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
spr1:	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
spr2:	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
spr3:	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
spr4:	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
spr5:	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	dc.l	0,0,0,0
levelsprites:
lv0:   	dc.w	1,0,25,1,0,0,135,215,0,1,$f11,$000,$fff,268,186,0
	dc.l	0,0,0,0,0,0,0,0
	dc.w	1,8,30,1,360,460,0,0,1,0,$ff0,$000,$f00,368,86,0
	dc.l	0,0,0,0,0,0,0,0
	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
lv1:   	dc.w	1,4,25,1,0,0,160,210,0,1,$c70,$000,$fff,500,176,0
	dc.l	0,0,0,0,0,0,0,0
   	dc.w	1,12,5,2,690,626,0,0,1,0,$f11,$000,$fff,678,120,0
   	dc.w	1,12,6,2,690,626,0,0,1,0,$f11,$000,$fff,638,80,0
	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
lv2:   	dc.w	1,24,20,1,500,650,0,0,1,0,$f00,$000,$ff0,555,256,0
	dc.w	1,24,25,1,500,650,0,0,1,0,$f00,$000,$ff0,645,256,0
	dc.w	1,16,14,1,274,380,0,0,1,0,$bbb,$000,$f80,346,246,0
	dc.w	0,28,4,2,0,0,275,242,0,1,$ccc,$000,$888,456,266,0
	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
lv3:   	dc.w	1,36,20,1,236,508,0,0,1,0,$ff0,$000,$fff,440,396,0
	dc.l	0,0,0,0,0,0,0,0
	dc.w	1,28,4,1,0,0,460,428,0,1,$ccc,$000,$888,245,431,0
	dc.w	1,28,4,2,0,0,465,435,0,1,$ccc,$000,$888,340,441,0
	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
lv4:  	dc.w	1,20,11,2,0,0,304,350,0,1,$fff,$000,$ff0,645,346,0
	dc.w	1,20,13,1,0,0,322,360,0,1,$fff,$000,$ff0,682,336,0
	dc.w	1,20,45,2,0,0,304,336,0,1,$fff,$000,$ff0,728,316,0
	dc.w	1,20,02,1,0,0,334,360,0,1,$fff,$000,$ff0,777,336,0
	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
lv5:  	dc.w	1,960,17,2,0,0,374,406,0,1,$0c0,$fff,$000,856,396,0
	dc.w	1,960,13,1,652,812,0,0,1,0,$0c0,$fff,$000,802,403,0
	dc.w	1,32,14,2,940,1000,0,0,1,0,$fff,$000,$ccc,980,433,0
	dc.l	0,0,0,0,0,0,0,0
	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
lv6:  	dc.w	1,964,17,1,910,1066,0,0,1,0,$f00,$fc0,$000,926,305,0
	dc.l	0,0,0,0,0,0,0,0
	dc.w	1,968,13,2,712,772,238,280,1,1,$f77,$fff,$000,752,253,0
	dc.w	0,968,14,2,0,0,70,170,0,1,$f77,$fff,$000,752,133,0
	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
lv7:  	dc.w	1,984,0,2,900,1080,0,0,1,0,$0a0,$ff0,$000,1049,160,0
	dc.w	1,986,0,2,916,1096,0,0,1,0,$0a0,$ff0,$000,1065,160,0
	dc.w	1,1944,0,2,900,1080,0,0,1,0,$0a0,$ff0,$000,1049,183,0
	dc.w	1,1946,0,2,916,1096,0,0,1,0,$0a0,$ff0,$000,1065,183,0
	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

scrolltext:
dc.b '  hello.            this game was written by marcus g. '
dc.b 'and the music was '
dc.b 'made by daniel f. using "noisetracker" from hallonsoft. '
dc.b '  the face on the intro-picture belongs to'
dc.b ' jonas sjostrand.   this game is intended for people like me, '
dc.b 'who think that the most enjoyable computer games were those '
dc.b 'designed for the c64 before 1987, and especially for people '
dc.b 'who liked "manic miner" and "son of blagger".  this game'
dc.b ' does not contain any beautiful graphics, mainly because i"m'
dc.b ' so bad at drawing, but i hope that you will like it anyway.'
dc.b '   "jonas fulstrand" is, of course, public domain! '
dc.b '    there will be no greetings to any hacker-groups,  because'
dc.b ' there is no longer anyone who deserves it. a little hello though'
dc.b ' to the following persons - mattias f, stefan g, christian, jocke,'
dc.b ' hans f, mikael w, per o, joakim r, jonny b, fredrik f '
dc.b 'and others.     -    be-bop originalaskkopp !!!!         ',0


even
playground:                                   
	blk.b	13000,0

even
startinglevel:	dc.l	0
antalliv:	dc.l	9

