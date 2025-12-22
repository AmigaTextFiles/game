************************************************************
*
*  BOOTBLOCK INSTALLER (C) PAUL HAYTER 1990
*   WORKS FROM BOTH CLI AND WORKBENCH
*
************************************************************

* This one is for installing squash!

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

;SQUASH in your Bootblock V4.3 (Speeds up after every 5 balls)
;Copyright 1990 by Paul Hayter
;This code is public DOMAIN
;
;exit by pressing key and now has mouse control(Thanks Wayne!)
;
;This program directly accesses hardware registers and then
;returns control to the OS
;
;
;january 1990

vposr	equ	$4
clxdat	equ	$00e
intreqr	equ	$01e
copjmp1	equ	$088
diwstrt	equ	$08e
diwstop	equ	$090
ddfstrt	equ	$092
ddfstop	equ	$094
dmacon	equ	$096
clxcon	equ	$098
intena	equ	$09a
intreq	equ	$09c
bpl1pth	equ	$0e0
bplcon0	equ	$100
bplcon1	equ	$102
bplcon2	equ	$104
bpl1mod	equ	$108
bpl2mod	equ	$10a
spr0pth	equ	$120
spr1pth	equ	$124
spr2pth	equ	$128
spr3pth	equ	$12c
spr4pth	equ	$130
spr5pth	equ	$134
spr6pth	equ	$138
spr7pth	equ	$13c
color00	equ	$180
color01	equ	$182
color02	equ	$184
color03	equ	$186
color16	equ	$1a0
color17	equ	$1a2
color18	equ	$1a4
color19	equ	$1a6
color21	equ	$1aa
joy1dat	equ	$00c
joy0dat	equ	$00a

bat_height equ	20
bat_movement equ	3

*_LVOAllocMem	equ	-198
*_LVOFreeMem	equ	-210



*	JMP start (semi colon me to asm for bootblock)
bbstart:	dc.b 'DOS',0	THIS IS THE STANDARD BOOTBLOCK CODE
	dc.l 0		This is the bootblock checksum. You'll need a machine code mon to fix this
	dc.l $370
	movem.l d0-d7/a0-a6,-(a7)
	bsr start
	movem.l (a7)+,d0-d7/a0-a6
	lea dosname(pc),a1
	jsr -$60(a6)
	move.l d0,a0
	move.l $16(a0),a0
	moveq #0,d0
	rts
	
dosname:	dc.b 'dos.library',0
	even


memsize	equ 8192+100

start:	move.l 4,a6	Allocate mem for 1 bp and sprite0
	move.l #$10002,d1
	move.l #memsize,d0
	jsr _LVOAllocMem(a6)	allocmem
	move.l d0,a1
	move.b $bfec01,d7	d7 holds old key code DON'T modify
	lea $dff000,a0   LEAVE A0 & A1 & A3 ALONE
	lea start(pc),a3	Have base pointer
	bsr zero_score
	lea reg_table(pc),a2
	bsr load_regs
	bsr make_sprite0
	bsr draw_screen
	bsr showSC	Draw the score
	bsr active_screen	Main loop
	bsr restore_regs
	move.l #memsize,d0	Deallocate memory
	jsr _LVOFreeMem(a6)
	moveq #0,d0	NEED THIS to return OK
	rts
	
active_screen:
;The 68000 behaves as the Copper being in a constant loop in sync
;with the vertical blank
	
	move.l a1,bpl1pth(a0)
	move.w #$8120,dmacon(a0) bp's & spr's on
l1:	andi.w #$0020,intreqr(a0) WAIT FOR VERTICAL BLANK
	beq.s l1
	move.w #$0020,intreq(a0) TURN VB OFF
	move.l a1,bpl1pth(a0)
	bsr set_sprite_ptrs
	bsr collisions
	bsr move_ball
	bsr mouse_move_bat
	
key:	cmp.b $bfec01,d7	exit if any key pressed
	beq.s l1
	rts

zero_score:
	lea chargen(pc),a2
	move.l a2,char_ptr0-start(a3)
	move.l a2,char_ptr1-start(a3)
	rts
	
restore_regs:
	move.w d1,copjmp1(a0)	dummy strobe
	move.w #$81f0,dmacon(a0)	restore DMA
	move.w #$c000,intena(a0)	Turn all ints back on
	rts


load_regs:
;enter with a2 pointing to table
	moveq #0,d0
	move.b (a2)+,d0
	cmpi.b #$ff,d0
	bne.s l4
	rts
l4:	asl.w #1,d0
	move.b (a2)+,d1
	asl.w #8,d1
	move.b (a2)+,d1
	move.w d1,0(a0,d0)
	bra.s load_regs

reg_table:
	dc.b	dmacon/2,$01,$a0
	dc.b	intena/2,$40,$00
	dc.b	color00/2,$00,$00
	dc.b	color01/2,$0f,$ff
	dc.b	color21/2,$0b,$f0	ball color
	dc.b	color18/2,$0f,$f0	bat color
	dc.b	bplcon0/2,$12,$00
	dc.b	bplcon1/2,$0,$0
	dc.b	ddfstrt/2,$00,$38
	dc.b	ddfstop/2,$00,$d0
	dc.b	diwstrt/2,$2c,$81
	dc.b	diwstop/2,$f4,$c1
	dc.b	$ff	;END				
	even			very important!!!

draw_screen:
	move.l a1,a2	screen loc DRAW TOP BAR
	moveq #-1,d0
	moveq #$50,d1
l5:	move.l d0,(a2)+
	subq.b #1,d1
	bne.s l5
	lea $1e00(a1),a2  DRAW BOTTOM BAR
	moveq #$50,d1
l6:	move.l d0,(a2)+
	subq.b #1,d1
	bne.s l6
	move.l a1,a2  DRAW LEFT WALL
	move.b #200,d1
l7:	move.b d0,(a2)
	lea 40(a2),a2
	subq.b #1,d1
	bne.s l7
	rts
	
set_sprite_ptrs:
	lea sprite0(a1),a2
	move.l a2,spr0pth(a0)
	lea sprite2(pc),a2
	move.l a2,spr2pth(a0)
	lea sprite1(pc),a2
	move.l a2,spr1pth(a0)
	move.l a2,spr3pth(a0)
	move.l a2,spr4pth(a0)
	move.l a2,spr5pth(a0)
	move.l a2,spr6pth(a0)
	move.l a2,spr7pth(a0)
	rts

convertxy:
;writes the appropriate values to the sprite data table based on x,y coords	
;ENTRY	d0.w= x
;	d1.w= y
;	a2.l= sprite ptr
;	d2.w= height
	moveq #0,d3
	add.w d1,d2
	move.b d1,(a2)
	move.b d2,2(a2)
	asl.w #2,d1
	asl.w #1,d2
	andi.w #$0400,d1
	andi.w #$0200,d2
	or.w d1,d2
	lsr.w #8,d2
	move.w d0,d1
	andi.b #$1,d1
	or.b d1,d2
	lsr.w #1,d0
	move.b d0,1(a2)
	move.b d2,3(a2)
	rts
		
move_ball:
	move.w ballx-start(a3),d0
	move.w bally-start(a3),d1
	add.w ballxdir-start(a3),d0
	add.w ballydir-start(a3),d1
	move.w d0,ballx-start(a3)		BALLX
	move.w d1,bally-start(a3)		BALLY
	moveq #4,d2
	lea sprite2(pc),a2
	bra convertxy
	
		
collisions:
	cmpi.w #232,bally-start(a3)	bottom wall
	blt.s l9
	neg.w ballydir-start(a3)
l9:	cmpi.w #52,bally-start(a3)	top wall
	bgt.s l10
	neg.w ballydir-start(a3)
l10:	cmpi.w #136,ballx-start(a3)	left wall
	bgt.s l19
	neg.w ballxdir-start(a3)
l19:	cmpi.w #450,ballx-start(a3)	behind the bat
	blt.s l11
	neg.w ballxdir-start(a3)
	bsr zero_score
	bsr init_ball_speed
	bsr showSC
l11:	move.w clxdat(a0),d0	Check collision spr0 to spr2
	andi.w #$200,d0
	beq.s l14
	tst.w ballxdir-start(a3)
	bmi.s l14
	bsr change_score
	bsr difficulty
	neg.w ballxdir-start(a3)	HIT BAT
l14:	rts

mouse_move_bat:
	move.w joy0dat(a0),d0	
	lsr.w #8,d0
	move.b old_mouse-start(a3),d1
	sub.b d0,d1	previous-current
	ext.w d1
l41:	move.b d0,old_mouse-start(a3)
	
	sub.w d1,baty-start(a3)
	move.w batx-start(a3),d0
	move.w baty-start(a3),d1
	lea sprite0(a1),a2
	moveq #bat_height,d2
	bra convertxy

	
expand_font:
;Draws character from table to screen. 4x bigger. Each char =6 bytes	
;ENTRY	a2= screen addr to write to
;	a4= ptr to char to print
	moveq #6,d3
l15:	move.b (a4)+,d0
	moveq #8,d2
l16:	asl.l #4,d1
	asl.b #1,d0
	bcc.s l17
	ori.b #$0f,d1
l17:	subq.b #$1,d2
	bne.s l16
	move.l d1,(a2)
	move.l d1,40(a2)
	move.l d1,80(a2)
	move.l d1,120(a2)
	lea 160(a2),a2
	subq.b #1,d3
	bne.s l15
	rts
	
change_score:
	addq.l #6,char_ptr0-start(a3)		LSDigit
	lea endchars(pc),a2
	cmp.l char_ptr0-start(a3),a2
	bne.s showSC
	lea chargen(pc),a2
	move.l a2,char_ptr0-start(a3)
	addq.l #6,char_ptr1-start(a3)		MSdigit
showSC:	lea 6032(a1),a2
	move.l char_ptr1-start(a3),a4
	bsr expand_font
	lea 6036(a1),a2
	move.l char_ptr0-start(a3),a4
	bra expand_font


difficulty:
;speed the ball up a bit after every 10 hits
	subq #1,iteration-start(a3)	
	beq.s l20
	rts
l20:	move.w #5,iteration-start(a3)
	moveq #1,d2
	move.w ballxdir-start(a3),d0
	bpl.s l21
	neg.w d2
l21:	add.w d2,ballxdir-start(a3)
	moveq #1,d2
	move.w ballydir-start(a3),d0
	bpl.s l22
	neg.w d2
l22:	add.w d2,ballydir-start(a3)
	rts
	
init_ball_speed:
	move.w #-2,ballxdir-start(a3)
	move.w #2,ballydir-start(a3)
	move.w #5,iteration-start(a3)
	rts
	
make_sprite0:
	lea sprite0(a1),a2
	move.l #$64c07400,(a2)+
	moveq #bat_height,d0
	move.l #$0000f000,d1
l30:	move.l d1,(a2)+
	subq #1,d0
	bne.s l30
	clr.l (a2)
	rts
	
sprite0	equ 	$2000	8k past screen start	

sprite2:	dc.w $5052,$5400
	dc.w $6000,0
	dc.w $f000,0
	dc.w $f000,0
	dc.w $6000,0
	dc.w $00,0
sprite1:	dc.w $0,0

char_ptr0: dc.l 0
char_ptr1: dc.l 0
ballx:	dc.w 384
bally:	dc.w 64
ballxdir: dc.w -2
ballydir: dc.w 2
batx:	dc.w 364
baty:	dc.w 130
old_mouse:dc.b 0

chargen:	dc.b $3c,$66,$66,$66,$66,$3c 		'0'
	dc.b $18,$38,$18,$18,$18,$7e		'1'
	dc.b $3c,$66,$06,$3c,$60,$7e		'2'
	dc.b $7c,$06,$1c,$06,$06,$7c		'3'
	dc.b $1c,$3c,$6c,$cc,$fe,$0c		'4'
	dc.b $7e,$60,$7c,$06,$66,$3c		'5'
	dc.b $3e,$60,$7c,$66,$66,$3c		'6'
	dc.b $7e,$06,$0c,$18,$30,$30
	dc.b $3c,$66,$3c,$66,$66,$3c
	dc.b $3c,$66,$3e,$06,$0c,$38		'9'
endchars:
;make sure there is a gap here(don't put EVEN on the same line as endchars

	even	VERY IMPORTANT 

iteration: dc.w 5
ego:	dc.b 'Squash4.3(c)PLH90'




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

bodytx1	dc.b	'SQUASH V4.3  Installer',0
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
