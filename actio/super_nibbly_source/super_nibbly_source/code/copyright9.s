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

yup=30

BITMAP=130*270*4

		;SECTION Prog,CODE_F
		
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

	move.l	d1,blacklist

        move.l  4,a6
        lea     gfxname,a1
	move.l	#0,d0
        jsr     openlibrary(a6)
        move.l  d0,gfxbase	

start:
	move.w	$dff006,d0
	lsr.w	#8,d0
	and.w	#$ff,d0
	cmp.w	#$80,d0
	bls	.otherone
	move.w	#0,whichball
	bra	.thisone
.otherone
	move.w	#1,whichball
.thisone

	move.w	#94,xpos
	move.w	#50,ypos

	move.l	4,a6
	move.l	#BITMAP,d0
	move.l	#clear,d1
	jsr	allocmem(a6)
	move.l	d0,bitplanes
	tst.l	d0
	beq	error

	move.l	4.w,a6
	jsr	forbid(a6)

	move.l	gfxbase,a6
	jsr	-228(a6)
	jsr	ownblitter(a6)

	move.l	#$dff000,a5

	bsr	mt_init	
	bsr	newvbl
	
	move.l	bitplanes,d0
	add.l	#$d0*320,d0
	move.l	d0,splanes
	bsr	insertplanes


	bsr	newcopper

	lea	daten,a3

main:
	cmp.l	#enddat,a3
	beq	dodesigns
	bsr	vposdown

	move.b	(a3)+,d0
	move.b	(a3)+,d1
	ext.w	d0
	ext.w	d1
	add.w	xpos,d0
	add.w	ypos,d1
	move.w	d0,xpos
	move.w	d1,ypos	
	bsr	copy

	cmp.l	#enddat,a3
	beq	endoflist
	move.b	(a3)+,d0
	move.b	(a3)+,d1
	ext.w	d0
	ext.w	d1
	add.w	xpos,d0
	add.w	ypos,d1
	move.w	d0,xpos
	move.w	d1,ypos	
	bsr	copy

	bsr	waitblit

endoflist:
	bra	main

dodesigns:	
	move.l	#flyin,flyoff
	lea	fxpos,a0
	move.w	#38,d0
xploop:
	move.w	#640,(a0)+
	dbra	d0,xploop

dodesigns2:
	bsr	vposup

	lea	fxpos,a3
	move.l	flyoff,a4
	cmp.w	#$a0a0,(a4)
	beq	exit
	add.l	#2,flyoff
	move.l	#0,d7
	
dofly:		
	move.w	(a3),d0
	sub.w	-(a4),d0
	move.w	d0,(a3)+
	move.w	#0,d1
	move.l	#31,d2
	sub.l	d7,d2
	bsr	copyline
	add.l	#1,d7
	cmp.w	#32,d7
	bne	dofly

	bra	dodesigns2


exit:
	move.l	#160,d0
wfade0:
	bsr	vposup
	sub.l	#1,d0
	bne	wfade0

	move.l	#$f,d7	
fadeout:
	bsr	vposdown
	lea	colors,a1
	bsr	fadewhite	
	lea	colors2,a1
	bsr	fadewhite	
	dbra	d7,fadeout

	bsr	showham

	move.l	#30,d0
wfade2:
	bsr	vposup
	sub.l	#1,d0
	bne	wfade2

	bsr	oldvbl
	bsr	mt_end


waitend2:
	;btst	#6,$bfe001
	;bne	waitend2

cleanup:
	bsr	oldcopper

	move.l	gfxbase,a6
	jsr	-228(a6)
	jsr 	disownblitter(a6)
	move.l	4.w,a6
	jsr	permit(a6)
	move.l	4.w,a6
	move.l	bitplanes,a1
	move.l	#BITMAP,d0
	jsr	freemem(a6)
	move.l  gfxbase,a1
        move.l  4,a6
	jsr	closelibrary(a6)
	move.l	#0,d0
	rts

newvbl:
	move.l	$6c,chgvbl+2
	move.l	#thisvbl,$6c
	rts

oldvbl:
	move.l	chgvbl+2,$6c
	rts


thisvbl:
	movem.l	d0-d7/a0-a6,-(sp)
	bsr	mt_music
	movem.l	(sp)+,d0-d7/a0-a6
chgvbl:
	jmp 	0




fadewhite:
	move.w	#$180,d0
dofade:
	move.w	d0,(a1)+
	move.w	(a1),d1
	move.w	d1,d2

	lsr.w	#8,d2
	and.w	#$f,d2
	sub.w	#1,d2
	bpl	notten1	
	move.b	#0,d2
notten1:
	move.w	d2,d3
	lsl.w	#4,d3

	move.w	d1,d2
	lsr.w	#4,d2
	and.w	#$f,d2
	sub.w	#1,d2
	bpl	notten2	
	move.b	#0,d2
notten2:
	or.b	d2,d3
	lsl.w	#4,d3

	move.w	d1,d2
	and.w	#$f,d2
	sub.w	#1,d2
	bpl	notten3
	move.b	#0,d2
notten3:
	or.b	d2,d3
	move.w	d3,(a1)+
	addq.l	#2,d0
	cmp.w	#$1a0,d0
	bne	dofade
	rts


	
flyoff:	dc.l	0
fxpos:	dcb.w	40,400

error:
	move.l	#$10000,d0
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
	rts

newcopper:
	tst.w	whichball
	beq	.otherone
	move.l	#ball+10*25*4,a0
	bra	.thisone
.otherone
	move.l	#ball2+10*25*4,a0
.thisone

	lea	colors,a1
	move.w	#$180,d0
cloop:
	move.w	d0,(a1)+
	move.w	(a0)+,(a1)+
	addq.l	#2,d0
	cmp.w	#$1a0,d0
	bne	cloop

	move.w	#$540,colors+2

	move.l	#designs+50*32*4+2,a0
	lea	colors2+4,a1
	move.w	#$182,d0
cloop2:
	move.w	d0,(a1)+
	move.w	(a0)+,(a1)+
	addq.l	#2,d0
	cmp.w	#$1a0,d0
	bne	cloop2
	
	move.l	colors,colors2

	move.l	bitplanes,d0
	move.w	d0,planes+6
	swap	d0
	move.w	d0,planes+2
	swap	d0
	add.l	#80,d0
	move.w	d0,planes+14
	swap	d0
	move.w	d0,planes+10
	swap	d0
	add.l	#80,d0
	move.w	d0,planes+22
	swap	d0
	move.w	d0,planes+18
	swap	d0
	add.l	#80,d0
	move.w	d0,planes+30
	swap	d0
	move.w	d0,planes+26

	move.w	#$03e0,dmacon(a5)
	move.l	#clist,cop1lc(a5)
	clr.w	copjmp1(a5)
	move.w	#$83c0,dmacon(a5)
	move.l	#0,$dff144
	rts

showham:
	rts
	;move.l	#titel,d0
	move.l	#hplanes,a0
	move.w	d0,6(a0)
	swap	d0
	move.w	d0,2(a0)
	swap	d0
	add.l	#40*256,d0
	move.w	d0,14(a0)
	swap	d0
	move.w	d0,10(a0)
	swap	d0
	add.l	#40*256,d0
	move.w	d0,22(a0)
	swap	d0
	move.w	d0,18(a0)
	swap	d0
	add.l	#40*256,d0
	move.w	d0,30(a0)
	swap	d0
	move.w	d0,26(a0)
	swap	d0
	add.l	#40*256,d0
	move.w	d0,38(a0)
	swap	d0
	move.w	d0,34(a0)
	swap	d0
	add.l	#40*256,d0
	move.w	d0,46(a0)
	swap	d0
	move.w	d0,42(a0)

	move.w	#$03e0,dmacon(a5)
	move.l	#clist2,cop1lc(a5)
	clr.w	copjmp1(a5)
	move.w	#$83c0,dmacon(a5)
	move.l	#0,$dff144
	rts


insertplanes:
	move.w	d0,planes2+6
	swap	d0
	move.w	d0,planes2+2
	swap	d0
	add.l	#130,d0
	move.w	d0,planes2+14
	swap	d0
	move.w	d0,planes2+10
	swap	d0
	add.l	#130,d0
	move.w	d0,planes2+22
	swap	d0
	move.w	d0,planes2+18
	swap	d0
	add.l	#130,d0
	move.w	d0,planes2+30
	swap	d0
	move.w	d0,planes2+26
	rts


cls:	
	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	d0,bltdpth(a5)
	move.w	#$0100,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#0,bltdmod(a5)
	move.w	#900*64+60,bltsize(a5)
	bsr	waitblit
	rts

copy:
	sub.w	#yup,d1
	
	sub.w	#16,d0

	tst.w	whichball
	beq	.otherone
	move.l	#ball,d2
	bra	.thisone
.otherone
	move.l	#ball2,d2
.thisone
	move.l	#mask,d3

	mulu	#320,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	bitplanes,d0
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
	
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#70,bltcmod(a5)
	move.w	#70,bltdmod(a5)
	move.w	#25*4*64+5,bltsize(a5)



	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	#maske,bltdpth(a5)
	move.w	#$0100,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#0,bltdmod(a5)
	move.w	#25*4*64+5,bltsize(a5)


	move.w	xpos,d0
	move.w	ypos,d1
	sub.w	#yup,d1
	add.w	#12,d0
	add.w	#6,d1

	sub.w	#16,d0
	move.l	#maske,d2

	mulu	#320,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	bitplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4

	bsr	waitblit
	move.w	#0,bltcon1(a5)
	move.w	#$0dfc,bltcon0(a5)
	move.l	d0,bltapth(a5)
	move.l	d2,bltbpth(a5)
	move.l	d2,bltdpth(a5)
	move.w	#70+80*3,bltamod(a5)
	move.w	#10*3,bltbmod(a5)
	move.w	#10*3,bltdmod(a5)
	move.w	#25*64+5,bltsize(a5)

	add.l	#80,d0
	bsr	waitblit
	move.w	#0,bltcon1(a5)
	move.w	#$0dfc,bltcon0(a5)
	move.l	d0,bltapth(a5)
	move.l	d2,bltbpth(a5)
	move.l	d2,bltdpth(a5)
	move.w	#70+80*3,bltamod(a5)
	move.w	#10*3,bltbmod(a5)
	move.w	#10*3,bltdmod(a5)
	move.w	#25*64+5,bltsize(a5)

	add.l	#80,d0
	bsr	waitblit
	move.w	#0,bltcon1(a5)
	move.w	#$0dfc,bltcon0(a5)
	move.l	d0,bltapth(a5)
	move.l	d2,bltbpth(a5)
	move.l	d2,bltdpth(a5)
	move.w	#70+80*3,bltamod(a5)
	move.w	#10*3,bltbmod(a5)
	move.w	#10*3,bltdmod(a5)
	move.w	#25*64+5,bltsize(a5)

	add.l	#80,d0
	bsr	waitblit
	move.w	#0,bltcon1(a5)
	move.w	#$0dfc,bltcon0(a5)
	move.l	d0,bltapth(a5)
	move.l	d2,bltbpth(a5)
	move.l	d2,bltdpth(a5)
	move.w	#70+80*3,bltamod(a5)
	move.w	#10*3,bltbmod(a5)
	move.w	#10*3,bltdmod(a5)
	move.w	#25*64+5,bltsize(a5)

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	#maske,bltapth(a5)
	move.l	#maske+10,bltdpth(a5)
	move.w	#$09f0,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#10*3,bltamod(a5)
	move.w	#10*3,bltdmod(a5)
	move.w	#25*64+5,bltsize(a5)

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	#maske+10,bltapth(a5)
	move.l	#maske+20,bltdpth(a5)
	move.w	#$09f0,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#10*3,bltamod(a5)
	move.w	#10*3,bltdmod(a5)
	move.w	#25*64+5,bltsize(a5)

	bsr	waitblit
	move.l	#$ffffffff,bltafwm(a5)
	move.l	#maske+20,bltapth(a5)
	move.l	#maske+30,bltdpth(a5)
	move.w	#$09f0,bltcon0(a5)
	move.w	#$0000,bltcon1(a5)
	move.w	#10*3,bltamod(a5)
	move.w	#10*3,bltdmod(a5)
	move.w	#25*64+5,bltsize(a5)


	move.w	xpos,d0
	move.w	ypos,d1
	sub.w	#yup,d1
	add.w	#12,d0
	add.w	#6,d1

	sub.w	#16,d0

	mulu	#320,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	bitplanes,d0
	and.w	#$f,d4
	ror.w	#4,d4

	bsr	waitblit
	or.w	#$0fb8,d4
	move.w	d4,bltcon0(a5)
	move.w	#0,bltcon1(a5)
	move.l	#shadow,bltapth(a5)
	move.l	#maske,bltbpth(a5)
	move.l	d0,bltcpth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#0,bltbmod(a5)
	move.w	#70,bltcmod(a5)
	move.w	#70,bltdmod(a5)
	move.w	#25*4*64+5,bltsize(a5)
	rts

copyline:	
	add.w	d2,d1
	mulu	#200,d2
	add.l	#designs,d2
	mulu	#520,d1
	move.w	d0,d4
	lsr.w	#3,d0
	and.l	#$fffe,d0
	add.l	d1,d0
	add.l	splanes,d0
	and.w	#$f,d4
	ror.w	#4,d4
	
	bsr	waitblit
	move.w	#0,bltcon1(a5)
	or.w	#$09f0,d4
	move.w	d4,bltcon0(a5)
	move.l	d2,bltapth(a5)
	move.l	d0,bltdpth(a5)
	move.w	#0,bltamod(a5)
	move.w	#80,bltdmod(a5)
	move.w	#1*4*64+25,bltsize(a5)
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


*****************************************
* Pro-Packer v2.1 Replay-Routine.	*
* Based upon the PT1.1B-Replayer	*
* by Lars 'ZAP' Hamre/Amiga Freelancers.*
* Modified by Estrup/Static Bytes.	*
*****************************************

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
	


gfxlib:	dc.l	0

gfxbase:	dc.l	0
	 even
gfxname: dc.b	"graphics.library",0
	 cnop 0,2

bitplanes:	dc.l 0
splanes: 	dc.l	0

xpos:	dc.w	0
ypos:	dc.w	0

daten:
	dc.b	0,0,-6,-2,-7,-1,-7,-1,-8,0,-8,0
	dc.b	-7,1,-6,1,-5,1,-5,2,-4,2,-4,3,-3,3,-2,3,-2,4,-1,4,-1,5,0,5,0,5
	dc.b	1,5,1,4,2,4,2,3,3,3,4,3,4,2,5,2,5,1,6,1,7,1,8,0,8,0
	dc.b	7,-1,6,-1,5,-1,5,-2,4,-2

	dc.b	48,-50
	dc.b	-7,1,-6,1,-5,1,-5,2,-4,2,-4,3,-3,3,-2,3,-2,4,-1,4,0,5
	dc.b	0,5,0,4,1,4,2,3,3,3,3,3,4,2,5,2,6,1,7,1,8,1,8,0
	dc.b	8,-1,7,-1,6,-1,5,-2,4,-2,3,-3,3,-3,2,-3,1,-4,0,-4,0,-5
	dc.b	0,-5,0,-4,-1,-4,-2,-3,-3,-3,-3,-3,-4,-2,-5,-2,-6,-1,-7,-1,-8,-1
	dc.b 	-8,0

	dc.b	-7,1,-5,1,-4,1,-3,2,-2,2,-1,2,0,3
	dc.b	1,2,2,2,3,1,4,1,5,1,7,1	
	dc.b	8,0,8,0,8,-1,8,-1,8,-2,8,-2,7,-2,6,-2,5,-2,4,-2,3,-3,3,-3	
	dc.b	6,2,6,2,6,2,6,2,6,2,6,2,6,2
	dc.b	5,2,5,3,4,3,4,3,2,3,2,3,1,3,1,3,0,3
	dc.b	-1,3,-2,3,-3,3,-4,2,-5,2,-6,2,-7,1,-8,1,-8,0
	dc.b	-7,-1,-6,-2,-5,-2,-4,-2

	dc.b	102,7
	dc.b	-5,-2,-4,-2,-3,-2,-3,-3,-2,-3,-2,-3,-1,-3,-1,-3,0,-3
	dc.b	0,-3,0,-3,0,-3,0,-3,1,-3,1,-3,1,-3,2,-3,2,-3,2,-2		
	dc.b	3,-2,3,-2,3,-1,4,-1,4,0,4,1,3,1,3,2,2,2,2,2,1,3,1,3,0,3
	dc.b    1,-3,1,-3,2,-3,2,-2,2,-2,3,-2,3,-1,4,-1,4,0,4,1,3,1,3,2,3,2
	dc.b	2,2,2,3,2,3,1,3,1,3,1,3,0,3,0,3,0,3,0,3
	dc.b	0,3,-1,3,-1,3,-2,3,-2,3,-3,3,-3,2,-4,2,-5,2

	dc.b	82,-58
	dc.b	-7,1,-6,1,-5,1,-5,2,-4,2,-4,3,-3,3,-2,3,-2,4,-1,4,0,5
	dc.b	0,5,0,4,1,4,2,3,3,3,3,3,4,2,5,2,6,1,7,1,8,1,8,0
	dc.b	8,-1,7,-1,6,-1,5,-2,4,-2,3,-3,3,-3,2,-3,1,-4,0,-4,0,-5
	dc.b	0,-5,0,-4,-1,-4,-2,-3,-3,-3,-3,-3,-4,-2,-5,-2,-6,-1,-7,-1,-8,-1
	dc.b 	-8,0

	dc.b	-7,1,-5,1,-4,1,-3,2,-2,2,-1,2,0,3
	dc.b	1,2,2,2,3,1,4,1,5,1,7,1	
	dc.b	8,0,8,0,8,-1,8,-1,8,-2,8,-2,7,-2,6,-2,5,-2,4,-2,3,-3,3,-3	
	dc.b	6,2,6,2,6,2,6,2,6,2,6,2,6,2
	dc.b	5,2,5,3,4,3,4,3,2,3,2,3,1,3,1,3,0,3
	dc.b	-1,3,-2,3,-3,3,-4,2,-5,2,-6,2,-7,1,-8,1,-8,0
	dc.b	-7,-1,-6,-2,-5,-2,-4,-2

			
enddat:	

	dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
flyin:
	dc.w	$000A,$0009,$0009,$0009,$0009,$0009,$0009,$0009
	dc.w	$0009,$0009,$0009,$0009,$0009,$0009,$0009,$0009
	dc.w	$0009,$0009,$0009,$0009,$0008,$0008,$0008,$0008
	dc.w	$0008,$0008,$0008,$0008,$0008,$0007,$0007,$0007
	dc.w	$0007,$0007,$0007,$0006,$0006,$0006,$0006,$0006
	dc.w	$0006,$0005,$0005,$0005,$0005,$0005,$0005,$0004
	dc.w	$0004,$0004,$0004,$0003,$0003,$0003,$0003,$0003
	dc.w	$0002,$0002,$0002,$0002,$0002,$0001,$0001,$0001
	dc.w	$0001,$0000,$0000,$0000,$0000,$0000
	dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	dc.w	$a0a0

whichball:	dc.w	0
blacklist:	dc.l	0

		SECTION Daten,DATA_C

		incdir	"dh0:assem/nibbly/sound/"
mt_data:	incbin	"mod.copyright"

	even

clist:	dc.w	$0001,$ff00,dmacon,$0100,bplcon0,$c000
	dc.w	bplcon1,0,bplcon2,0,bpl1mod,240,bpl2mod,240
	dc.w	diwstrt,$2081,diwstop,$2fc1
	dc.w	ddfstrt,$003c,ddfstop,$00d4
colors:	dcb.w	16*2,0
	dc.w	$3701,$ff00
planes:
	dc.w	bpl1pth,0,bpl1ptl,0
	dc.w	bpl2pth,0,bpl2ptl,0
	dc.w	bpl3pth,0,bpl3ptl,0
	dc.w	bpl4pth,0,bpl4ptl,0
	dc.w	$3801,$ff00,dmacon,$8100
	dc.w	$c001,$ff00
	dc.w	bplcon0,0000
planes2:
	dc.w	bpl1pth,0,bpl1ptl,0
	dc.w	bpl2pth,0,bpl2ptl,0
	dc.w	bpl3pth,0,bpl3ptl,0
	dc.w	bpl4pth,0,bpl4ptl,0
	dc.w	bpl1mod,440,bpl2mod,440
	dc.w	$c101,$ff00
	dc.w	bplcon0,$c000
colors2:
	dcb.w	16*2,0
	dc.w	$ffdf,$fffe
	dc.w	$2001,$ff00
	dc.w	bplcon0,0000,$ffff,$fffe


clist2:
hcolors:
	dc.w	$180,$323
	dc.w	$182,$343
	dc.w	$184,$346
	dc.w	$186,$832
	dc.w	$188,$736
	dc.w	$18a,$368
	dc.w	$18c,$585
	dc.w	$18e,$b43
	dc.w	$190,$964
	dc.w	$192,$48a
	dc.w	$194,$b57
	dc.w	$196,$d85
	dc.w	$198,$8ab
	dc.w	$19a,$e83
	dc.w	$19c,$c89
	dc.w	$19e,$dde
	dc.w	$008e,$0581,$0100,$0200,$0104,$0024,$0090,$40c1
	dc.w	$0092,$0038,$0094,$00d0,$0102,$0000,$0108,$0000
	dc.w	$010a,$0000
hplanes:
	dc.w	bpl1pth,0,bpl1ptl,0
	dc.w	bpl2pth,0,bpl2ptl,0
	dc.w	bpl3pth,0,bpl3ptl,0
	dc.w	bpl4pth,0,bpl4ptl,0
	dc.w	bpl5pth,0,bpl5ptl,0
	dc.w	bpl6pth,0,bpl6ptl,0
	
	dc.w	$2c01,$fffe,$0100,$6a00,$ffdf,$fffe
	dc.w	$2c01,$fffe,$0100,$0200,$ffff,$fffe

	dc.w	$ffff,$fffe


		
	 even

maske:	dcb.b	80*25*4


	incdir	"dh0:lo-res/nibbly2/"

designs:	incbin	"hires_designs_2_400x32x4.rb"
ball:		incbin	"hiresball1_80x25x4.rb"
ball2:		incbin	"hiresball3_80x25x4.rb"
mask:		incbin	"hiresball3_80x25x4.mask"
shadow:		incbin	"schatten_80x25x4.rb"

ende:
