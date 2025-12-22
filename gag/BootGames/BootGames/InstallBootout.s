************************************************************
*
*  BOOTBLOCK INSTALLER (C) PAUL HAYTER 1990
*   WORKS FROM BOTH CLI AND WORKBENCH
*
************************************************************

* This one is for installing BootOut.

_AbsExecBase	equ	4
_LVOFindTask	equ	-294
pr_CLI		equ	172
pr_MsgPort	equ	92
_LVOWaitPort	equ	-384
_LVOGetMsg	equ	-372
_LVOForbid	equ	-132
_LVOReplyMsg	equ	-378


startup:            ; reference for Wack users
	move.l   sp,initialSP   ; initial task stack pointer
	move.l   d0,dosCmdLen
	move.l   a0,dosCmdBuf

	;------ get Exec's library base pointer:
	move.l   _AbsExecBase,a6

	;------ get the address of our task
	suba.l   a1,a1
	jsr	_LVOFindTask(a6)
	move.l   d0,a4

	;------ are we running as a son of Workbench?
	tst.l   pr_CLI(A4)
	beq.s   fromWorkbench

;=======================================================================
;====== CLI Startup Code ===============================================
;=======================================================================
fromCLI:

	;------   collect parameters:
	move.l   dosCmdLen,d0
	move.l   dosCmdBuf,a0


	;------ call C main entry point
	jsr   _main

	;------ return success code:
	moveq.l   #0,D0
	move.l   initialSP,sp   ; restore stack ptr
	rts

;=======================================================================
;====== Workbench Startup Code =========================================
;=======================================================================
fromWorkbench:

	;------ we are now set up.  wait for a message from our starter
	bsr.s   waitmsg

	;------ save the message so we can return it later
	move.l   d0,_WBenchMsg

	;------ push the message on the stack for wbmain
	move.l   d0,-(SP)
	clr.l   -(SP)      indicate: run from Workbench

domain:
	jsr   _main
	moveq.l   #0,d0      Successful return code


*
************************************************************************

exit2:
	move.l  initialSP,SP   ; restore stack pointer
	move.l   d0,-(SP)   ; save return code

	;------ close DOS library:
	move.l   _AbsExecBase,A6

	;------ if we ran from CLI, skip workbench cleanup:
	tst.l   _WBenchMsg
	beq.s   exitToDOS


	;------ return the startup message to our parent
	;------   we forbid so workbench can't UnLoadSeg() us
	;------   before we are done:
	jsr	_LVOForbid(a6)
	move.l   _WBenchMsg,a1
	jsr	_LVOReplyMsg(a6)

	;------ this rts sends us back to DOS:
exitToDOS:
	move.l   (SP)+,d0
	rts


;-----------------------------------------------------------------------
; This routine gets the message that workbench will send to us
; called with task id in A4


waitmsg:
	lea   pr_MsgPort(A4),a0     * our process base
	jsr	_LVOWaitPort(a6)
	lea   pr_MsgPort(A4),a0     * our process base
	jsr	_LVOGetMsg(a6)
	rts


************************************************************************

*   DATA

************************************************************************



initialSP   dc.l   0
_WBenchMsg   dc.l   0

dosCmdLen   dc.l   0
dosCmdBuf   dc.l   0

_main

********PUT YOUR PROGRAM HERE***************************
;INSTALL PROGRAM WITH REQUESTER	


************************************************************************
*
* External EXEC references
_LVOSupervisor	EQU	-6*5
_LVOFindResident	EQU	-6*16
_LVOAllocMem	EQU	-6*33
_LVOFreeMem	EQU	-6*35
;_LVOFindTask	EQU	-6*49
_LVOOpenLibrary	EQU	-6*68
_LVOCloseLibrary	EQU	-6*69
_LVOOpenDevice	EQU	-6*74
_LVOCloseDevice	EQU	-6*75
_LVODOIO		EQU	-6*76
*

* Intuition Stuff
_LVOAutoRequest	equ	-348
_LVODisplayBeep	equ	-96




*
* Setup global registers
	MOVEA.L	4,A6		; ExecBase
*
* Open intuition
	MOVEQ	#0,D0
	LEA	intname(PC),A1
	JSR	_LVOOpenLibrary(A6)
	MOVEA.L	D0,A6
	move.l	d0,intbase
	TST.L	D0
	BNE.S	LibraryOpen
	rts

LibraryOpen
	sub.l	a0,a0
	lea	bodytext(pc),a1
	lea	PText(pc),a2
	lea	NText(pc),a3
	moveq	#0,d0
	moveq	#0,d1
	move.l	#350,d2
	move.l	#100,d3
	jsr	_LVOAutoRequest(a6)
	move.l	$4,a6
	sub.l	a4,a4
	moveq	#1,d4
	tst.l	d0
	beq	MadeIt

*********************
		SUBA.L	A4,A4		; Pointer to memory buffer
		LEA	DiskIOReq(PC),A3	; Pointer to disk I/O Request
		MOVEQ	#0,D6		; Completion result
;		MOVE.L	A7,D5		; Stack pointer
		MOVEQ	#1,D4		; Disk opened flag <>0 <>open



		MOVE.L	#$10002,D1
		MOVE.L	#1024,D0	; Boot block size
		JSR	_LVOAllocMem(A6)
		TST.L	D0
		Bne.S	keepgoing
		bsr	MissedIt
		bra	MadeIt
keepgoing
		MOVEA.L	D0,A4
*
* Now we copy the payload into the memory buffer. While doing so we calculate
* the checksum which we will patch into the buffer after the copy.
		MOVEQ	#0,D2		; Zero checksum
		MOVE.l	#PayloadSize/4-1,D0
		MOVEA.L	A4,A1
		LEA	ThePayload(PC),A0
p1		MOVE.L	(A0)+,D1
		MOVE.L	D1,(A1)+	; Shove into buffer
		ADD.L	D1,D2		; Bump checksum
		BCC.S	p2		; Did it rollover?
		ADDQ.L	#1,D2		; Bump by 1 if it rolled
p2		DBF	D0,p1
*
* Patch checksum into buffer
		NOT.L	D2
		MOVE.L	D2,4(A4)
*
* Init the port to use to access the trackdisk.device
		SUBA.L	A1,A1
		JSR	_LVOFindTask(A6)	;get current task
		LEA	DiskPort(PC),A0
		MOVE.L	D0,16(A0)
*
* Open the disk device
		MOVEQ	#0,D1		;flags
		MOVEQ	#0,D0		;unit number
		MOVEA.L	A3,A1		;ptr to IOreq
		LEA	DiskName(PC),A0	;TrackDisk.device
		JSR	_LVOOpenDevice(A6)
		MOVE.L	D0,D4			; Record if we opened device
		Beq.S	write_boot
		bsr.s	MissedIt
		bra.s	MadeIt
*
* Write payload to the disk 
write_boot	MOVEA.L	A3,A1
		MOVE.L	A4,40(A1)		; Pointer to Payload buffer
		JSR	_LVODOIO(A6)
		TST.L	D0
		Beq.S	flush_buffer
		bsr.s	MissedIt
		bra.s	MadeIt

*
* Flush data from track buffer onto the disk
flush_buffer	MOVEA.L	A3,A1
		MOVE.W	#4,28(A1)
		JSR	_LVODOIO(A6)
		TST.L	D0
		Beq.S	Motor_off
		bsr.s	MissedIt
*
* Shutdown the motor
Motor_off		MOVEA.L	A3,A1
		MOVE.W	#9,28(A1)
		CLR.L	36(A1)
		JSR	_LVODOIO(A6)
		TST.L	D0
		BEQ.S	MadeIt
		bsr.s	MissedIt
	
* Send the dog home
MadeIt		MOVEA.L	intbase(pc),A1
		JSR	_LVOCloseLibrary(A6)
*
* Free up the memory buffer if it was allocated
		MOVE.L	A4,D0
		BEQ.S	p4
		MOVEA.L	D0,A1
		MOVE.L	#1024,D0
		JSR	_LVOFreeMem(A6)
*
* Close the disk if we opened it
p4		TST.L	D4
		BNE.S	p5
		MOVEA.L	A3,A1
		JSR	_LVOCloseDevice(A6)
p5		MOVE.L	D6,D0
;		MOVEA.L	D5,A7
		RTS


MissedIt	MOVE.L	D0,D6		; Record error
	move.l	intbase(pc),a6
	move.l	56(a6),a0
	jsr	_LVODisplayBeep(a6)
	move.l	$4,a6
	rts
		CNOP	0,4
*******************************************************************
*
*	BOOTBLOCK CODE GOES HERE
*
********************************************************************
* Payload, this is the code written to the disk's boot block
PayloadStart
ThePayload
**************************************************************


*****************************************************
*
*	BOOT-OUT V5.X
*	9th June 1990
*
*****************************************************


custom	equ	$dff000

bltddat	EQU	$000
dmaconr	EQU	$002
vposr  	EQU	$004
vhposr 	EQU	$006
dskdatr	EQU	$008
joy0dat	EQU	$00A
joy1dat	EQU	$00C
clxdat 	EQU	$00E

adkconr	EQU	$010
pot0dat	EQU	$012
pot1dat	EQU	$014
potinp 	EQU	$016
serdatr	EQU	$018
dskbytr	EQU	$01A
intenar	EQU	$01C
intreqr	EQU	$01E

dskpt  	EQU	$020
dsklen 	EQU	$024
dskdat 	EQU	$026
refptr 	EQU	$028
vposw  	EQU	$02A
vhposw 	EQU	$02C
copcon 	EQU	$02E
serdat 	EQU	$030
serper 	EQU	$032
potgo  	EQU	$034
joytest	EQU	$036
strequ 	EQU	$038
strvbl 	EQU	$03A
strhor 	EQU	$03C
strlong	EQU	$03E

bltcon0	EQU	$040
bltcon1	EQU	$042
bltafwm	EQU	$044
bltalwm	EQU	$046
bltcpt 	EQU	$048
bltbpt 	EQU	$04C
bltapt 	EQU	$050
bltdpt 	EQU	$054
bltsize	EQU	$058

bltcmod	EQU	$060
bltbmod	EQU	$062
bltamod	EQU	$064
bltdmod	EQU	$066

bltcdat	EQU	$070
bltbdat	EQU	$072
bltadat	EQU	$074

dsksync	EQU	$07E

cop1lc 	EQU	$080
cop2lc 	EQU	$084
copjmp1	EQU	$088
copjmp2	EQU	$08A
copins 	EQU	$08C
diwstrt	EQU	$08E
diwstop	EQU	$090
ddfstrt	EQU	$092
ddfstop	EQU	$094
dmacon 	EQU	$096
clxcon 	EQU	$098
intena 	EQU	$09A
intreq 	EQU	$09C
adkcon 	EQU	$09E

aud    	EQU	$0A0
aud0   	EQU	$0A0
aud1   	EQU	$0B0
aud2   	EQU	$0C0
aud3   	EQU	$0D0


bpl1pth  	EQU	$0E0
bpl1ptl	equ	$0e2
bpl2pth	equ	$0e4
bpl2ptl	equ	$0e6

bplcon0	EQU	$100
bplcon1	EQU	$102
bplcon2	EQU	$104
bpl1mod	EQU	$108
bpl2mod	EQU	$10A

bpldat 	EQU	$110

spr0pth  	EQU	$120
spr0ptl  	EQU	$122
spr1pth  	EQU	$124
spr1ptl  	EQU	$126
spr2pth	EQU	$128
spr2ptl	EQU	$12A

spr    	EQU	$140

color00  	EQU	$180
color01	equ	$0182
color02	equ	$184
color03	equ	$186
color17	equ	$1a2
color18	equ	$1a4
color19	equ	$1a6
color20	equ	$1a8
color21	equ	$1aa
*** DIFFERENT STUFF FROM EARLY VERSIONS
MEMBASE		equ	$70000
**MEM ALLOCATION RELATIVE TO MEMBASE
oldcop		equ	0
old_mouse		equ	4

BitMap		equ	20
RastPort		equ	BitMap+40
sprite0_base	equ	RastPort+104
sprite2_base	equ	sprite0_base+20
copper_base	equ	sprite2_base+24
BitPlane1		equ	1024
BitPlane2		equ	BitPlane1+8000

LOFlist		equ	$32
left_mouse	equ	$bfe001

_LVOText		equ	-60
_LVOInitRastPort	equ	-198
_LVOMove		equ	-240
_LVOInitBitMap	equ	-390
_LVOSetAPen	equ	-342
_LVOSetBPen	equ	-348
;_LVOFindResident	equ	-96
_LVORectFill	equ	-306
_LVOReadPixel	equ	-318
_LVOWritePixel	equ	-324
total_bricks	equ	455-38

rp_BitMap		equ	4
bm_Planes		equ	8

ExecBase		equ	4


START

;	move.l	ExecBase,A6
;	bra.s	start2
	dc.b	'DOS',0
	dc.l	0
	dc.l	$0370
	
start2	movem.l	d0-d7/a0-a6,-(a7)
	move.l	(a6),a6
	move.l	(a6),a6		A6=GFXBASE
	lea	MEMBASE,a1
	move.l	a1,a4		A4=MEMBASE
clearmem	clr.l	(a1)+
	move.w	a1,d0
	tst.w	d0
	bpl.s	clearmem
	
;	bsr	init_spr_ptrs
	bsr	init_data

	lea	custom,a5		A5=CUSTOM
	lea	copper_base(a4),a1
	move.w	#$0080,dmacon(a5)
	move.l	LOFlist(a6),oldcop(a4)
	move.l	a1,LOFlist(a6)
	
init_rp_and_bm
	lea	BitMap(a4),a0
	move.l	a0,a2
	moveq	#2,d0
	move.w	#320,d1
	move.w	#200,d2
	jsr	_LVOInitBitMap(a6)
	lea	BitPlane1(a4),a0
	move.l	a0,BitMap+bm_Planes(a4)
	add.w	#8000,a0
	move.l	a0,BitMap+bm_Planes+4(a4)
	lea	RastPort(a4),a1
	move.l	a1,a3			A3=RASTPORT
	jsr	_LVOInitRastPort(a6)
	move.l	a2,rp_BitMap(a3)

	move.w	#$83a0,dmacon(a5)

draw_screen
	lea	rect_table(pc),a2
	move.w	#total_bricks,real_score-rect_table(a2)

	moveq	#3,d7
loop1	move.l	a3,a1
	move.w	(a2)+,d0
	jsr	_LVOSetAPen(a6)
	movem.w	(a2)+,d0-d3

	jsr	_LVORectFill(a6)
	dbf	d7,loop1
MAIN2
wait_for_blank
	moveq	#-1,d0
	cmp.b	vhposr(a5),d0
	beq.s	wait_for_blank
wfb2	cmp.b	vhposr(a5),d0
	bne.s	wfb2


print_headings
	lea	heading_text(pc),a0
	moveq	#text_length,d0
	bsr	print_any_headings



main


mouse_move_bat
	move.w	joy0dat(a5),d0	
	move.b	old_mouse(a4),d1
	sub.b	d0,d1	previous-current
	ext.w	d1
l41:	move.b	d0,old_mouse(a4)
	moveq	#0,d2

	lea	sprite0_base+1(a4),a1
	move.b	(a1),d2
	sub.w	d1,d2
	move.b	d2,(a1)
***************

move_ball
	lea	sprite2_base(a4),a2	A2=sprite2
	move.b	1(a2),d6		get x coord
	move.b	(a2),d7		get y coord
	bsr	spr_coord_conv
	lea	ballxdir(pc),a1	A1=ballxdir
	move.l	a1,d5		D5=BALLXDIR
BALL_DOWN_BOTTOM
	cmp.b	#245,(a2)		check for ball down bottom
	bcs.s	mb4
	neg.b	1(a1)
	lea	man_count(pc),a1
	subq.b	#1,(a1)
	moveq	#$30,d3
	cmp.b	(a1),d3
	bne.s	men_left
no_men_left
	lea	score(pc),a0

	move.b	d3,(a0)+

	move.b	d3,(a0)+
	move.b	d3,(a0)+
	move.b	#$35,(a1)

	subq.b	#3,(a2)
	subq.b	#3,2(a2)
	bra	draw_screen
men_left	
	move.l	d5,a1


mb4	move.w	clxdat(a5),d0
	btst	#9,d0		BALL TO BAT
	beq.s	mb1
	bsr	deflect_ball
mb1	cmp.b	#68,1(a2)		LEFT BORDER TO BAT
	bcc.s	mb2
	neg.b	(a1)
	
mb2	cmp.b	#218,1(a2)		RIGHT BORDER
	bcs.s	mb22
	neg.b	(a1)
mb22	cmp.b	#44+9,(a2)		ceiling check
	bcc.s	mb23
	neg.b	1(a1)
mb23
NEW_BALL_2_BRICK_COLLISION
	movem.l	a1-a2,-(a7)
	addq.l	#2,d7
	addq.l	#1,d6
	move.l	d6,d0
	move.l	d7,d1
	bsr	read_pixel	UNDER THE BALL
	bne.s	hobo
	move.l	d5,a1
	neg.b	1(a1)	REVERSE Y DIRECTION
	bsr	rub_brick
	addq.w	#7,d6
	bsr	read_pixel	CHECK PIXEL TO RIGHT
	bne.s	hobo2
	move.l	d5,a1
	neg.b	(a1)
hobo2	sub.w	#14,d6
	bsr	read_pixel	CHECK PIXEL TO LEFT
	bne.s	hobo3
	move.l	d5,a1
	neg.b	(a1)
hobo3
	
hobo	movem.l	(a7)+,a1-a2

	
mb3	
	move.b	(a1),d0
	add.b	d0,1(a2)
	move.b	1(a1),d0
	add.b	d0,(a2)
	add.b	d0,2(a2)


************

	lea	real_score(pc),a0
	tst.w	(a0)
	bpl.s	wait
	lea	goal_text(pc),a0
	moveq	#goal_length,d0
	bsr.s	print_any_headings
endgame	btst	#10,potinp(a5)
	bne.s	endgame
	bra.s	exit
	
wait	btst	#10,potinp(a5)
	bne	MAIN2


	
exit	move.w	#$0080,dmacon(a5)
	move.l	oldcop(a4),LOFlist(a6)
	move.w	#$83a0,dmacon(a5)
	movem.l	(a7)+,d0-d7/a0-a6
;	bra.s	go_home
	lea	dosname(pc),a1
	jsr	_LVOFindResident(a6)
	move.l	d0,a0
	move.l	$16(a0),a0

go_home	moveq	#0,d0
	rts

	

print_any_headings
	movem.l	a0/d0,-(a7)
	move.l	a3,a1
	moveq	#3,d0
	jsr	_LVOSetAPen(a6)
	moveq	#1,d0
	jsr	_LVOSetBPen(a6)
	
	
	moveq	#7,d1
	moveq	#4,d0
	jsr	_LVOMove(a6)
	movem.l	(a7)+,a0/d0
	jmp	_LVOText(a6)




deflect_ball
	lea	sprite0_base+1(a4),a0
	move.b	1(a2),d1
	move.b	(a0),d0
	sub.b	d0,d1
	addq.b	#3,d1
;	move.b	d1,d2
;	add.b	#$30,d2
;	move.b	d2,score+3

	move.b	(a1),d0	get ballxdir
	asr.b	#1,d0
	or.b	#1,d0
	move.b	d0,(a1)
	
	
	cmp.b	#$c,d1
	blt.s	othertests1
faster	asl.b	#1,d0
	move.b	d0,(a1)
	bra.s	dfb2
othertests1
	cmp.b	#0,d1
	ble.s	faster
	
	cmp.b	#6,d1	middle of bat
	bgt.s	right_side
left_side
	tst.b	d0
	bmi.s	lef1
	neg.b	(a1)	ballxdir
lef1	

	bra.s	dfb2
right_side
	tst.b	d0
	bpl.s	dfb2
	neg.b	(a1)

dfb2	neg.b	1(a1)	ballydir
	bmi.s	dfb3
	neg.b	1(a1)
dfb3	rts
	

spr_coord_conv
* Entry- D6=sprite x, D7=sprite y
* Exit-  D6=screen x, D7=screen y
	moveq	#0,d0
	moveq	#0,d1
	move.b	d7,d1
	sub.w	#44,d1
	move.b	d6,d0
	add.w	d0,d0
	sub.w	#128,d0
	move.l	d0,d6
	move.l	d1,d7
	rts
	
	




update_score
	lea	score+3(pc),a2
us_1	addq.b	#1,-(a2)
	cmp.b	#$3a,(a2)
	bne.s	us_2
	move.b	#$30,(a2)
	bra.s	us_1
us_2	rts

rub_brick
	move.l	a3,a1
	moveq	#0,d0
	jsr	_LVOSetAPen(a6)
	
	move.l	d6,d0
	move.l	d7,d1
	and.w	#$fff8,d0
	and.w	#$fff8,d1
	move.w	d0,d2
	addq.w	#7,d2
	move.w	d1,d3
	addq.w	#7,d3
	jsr	_LVORectFill(a6)
	bsr.s	update_score

	lea	real_score(pc),a0
	subq.w	#1,(a0)
	rts
	


read_pixel
	move.l	d6,d0
	move.l	d7,d1
	move.l	a3,a1
	jsr	_LVOReadPixel(a6)
	cmp.b	#2,d0
	rts

init_data
	lea	sprite0(pc),a1
	lea	sprite0_base(a4),a0
	bsr.s	do_sprites
idx2	move.l	(a1)+,d0
	move.l	d0,(a0)+
	btst	#16,d0
	beq.s	idx2
	move.l	(a1)+,(a0)+	turn on dma instruction
	move.w	(a1)+,d0		get starting wait
	moveq	#-2,d1
	swap	d0		D0=$3c01xxxx
	move.w	d1,d0		should be $3C01FFFE
	move.w	#color02,d1
	swap	d1
idx3	move.w	(a1)+,d1		should $0184XXXX
	bmi.s	no_more_copper	terminate with $ffff
	move.l	d0,(a0)+
	move.l	d1,(a0)+
	add.l	#$08000000,d0
	bra.s	idx3
no_more_copper
	moveq	#-2,d0
	move.l	d0,(a0)+	
	rts
	

do_sprites

	moveq	#2,d2
	bsr.s	dothem
	moveq	#3,d2
dothem	move.l	(a1)+,(a0)+	control words
doug1	moveq	#0,d0
	move.w	(a1)+,d0
	swap	d0
	move.l	d0,(a0)+
	dbf	d2,doug1
	clr.l	(a0)+		
	rts
		

ballxdir	dc.b	$ff
ballydir	dc.b	$fe
real_score
	dc.w	total_bricks

rect_table	dc.w	1,0,0,7,199
		dc.w	1,0,0,319,9
		dc.w	1,312,0,319,199
		dc.w	2,8,16,311,103

	
sprite0	dc.w	$f080,$f300
	dc.w	$ffff
	dc.w	$ffff
	dc.w	$ffff
;	dc.w	0,0	
	
sprite2	dc.w	$c080,$c400
	dc.w	$6000
	dc.w	$f000
	dc.w	$f000
	dc.w	$6000
;	dc.w	0,0
	
copper_list
	dc.w	bplcon0,$0200
	dc.w	bplcon1,0
	dc.w	bpl1mod,0
	dc.w	ddfstrt,$0038
	dc.w	ddfstop,$00d0
	dc.w	diwstrt,$2c81
	dc.w	diwstop,$f4c1
	dc.w	bpl1pth,(MEMBASE+BitPlane1)/65536
	dc.w	bpl1ptl,BitPlane1
	dc.w	bpl2pth,(MEMBASE+BitPlane2)/65536
	dc.w	bpl2ptl,BitPlane2
	dc.w	spr0pth
spr0high	dc.w	(MEMBASE+sprite0_base)/65536
	dc.w	spr0ptl
	dc.w	sprite0_base
	dc.w	spr2pth
spr2high	dc.w	(MEMBASE+sprite2_base)/65536
	dc.w	spr2ptl
	dc.w	sprite2_base
	dc.w	clxcon,$0082
	dc.w	color21,$00f0
	dc.w	color17,$0ff0

	dc.w	color00,$0000
	dc.w	color01,$0fff
	dc.w	color02,$0f00
	dc.w	color03,$0088
	dc.w	$2001,$fffe

	dc.w	bplcon0,$2200
	dc.w	$3c01
	dc.w	$0f00
	

	dc.w	$0e00
	dc.w	$0d00
	dc.w	$0c00
	dc.w	$0b00
	dc.w	$0a00
	dc.w	$0900
	dc.w	$0800
	dc.w	$0700
	dc.w	$0600
	dc.w	$ffff


heading_text	dc.b	'BootOut V5.'
man_count		dc.b	$35
		dc.b	' ',$a9,' Paul Hayter '
score		dc.b	$30,$30,$30,$30
hd_end
*			 BootOut V5.5 C Paul HAYTER
goal_text		dc.b	'Good One Mate!!           :'
goal_end

dosname		dc.b	'dos.library',0
goal_length	equ	goal_end-goal_text
text_length	equ	hd_end-heading_text
	

	cnop	0,4	
***************************************************************
PayloadEnd
PayloadSize	EQU	PayloadEnd-PayloadStart
	cnop 0,4
	
DiskName	DC.B	'trackdisk.device',0

DiskPort	DC.L	0	;0
		DC.L	0	;4
		DC.W	$0400	;8
		DC.L	0	;10
		DC.B	0	;14
		DC.B	31	;15
		DC.L	0	;16	Task addr goes here
LH1		DC.L	LH2	;20
LH2		DC.L	0	;24
		DC.L	LH1	;28
		DC.B	0	;32
		DC.B	0	;33

DiskIOReq		DC.L	0	;0
		DC.L	0	;4
		DC.B	5	;8
		DC.B	0	;9
		DC.L	0	;10
		DC.L	DiskPort ;14
		DC.W	48	;18
		DC.L	0	;20
		DC.L	0	;24
		DC.W	3	;28 IO_CMD
		DC.W	0	;30
		DC.L	0	;32
		DC.L	1024	;36 IO_LENGTH
		DC.L	0	;40 IO_DATA
		DC.L	0	;44 IO_OFFSET
		DC.L	0
		DC.L	0

bodytx1	dc.b	'BOOTOUT V5.X Installer',0
bodytx2	dc.b	'(C) 1990 Paul Hayter',0
Ptx	dc.b	'INSTALL DF0:',0
Ntx	dc.b	'  CANCEL!   ',0
	
	even

bodytext2	dc.b	0
	dc.b	1
	dc.w	0
	dc.w	8
	dc.w	20
	dc.l	0
	dc.l	bodytx2
	dc.l	0
		
	
bodytext	dc.b	0
	dc.b	1
	dc.w	0
	dc.w	8
	dc.w	10
	dc.l	0
	dc.l	bodytx1
	dc.l	bodytext2

PText	dc.b	0
	dc.b	1
	dc.w	0
	dc.w	5
	dc.w	4
	dc.l	0
	dc.l	Ptx
	dc.l	0
	
NText	dc.b	0
	dc.b	1
	dc.w	0
	dc.w	5
	dc.w	4
	dc.l	0
	dc.l	Ntx
	dc.l	0




MYdosname		dc.b	'dos.library',0
intname		dc.b	'intuition.library',0
	even
intbase		dc.l	0
	
		END
