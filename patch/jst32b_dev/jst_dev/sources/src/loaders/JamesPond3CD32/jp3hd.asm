; *** James Pond CD32 HD Loader

; ** $29A9,$29AB: level. 4 saves
; ** $7D46,$7679: vies
; ** $7676,$7F7A: score

; ** $7BC5 : $FF save item

	include	"jst.i"

	HD_PARAMS	"",0,0

	MACHINE	68020

SAVELEN = 168
DATALEN = SAVELEN+$40

_loader:
	RELOC_MOVEL	D1,noosswap
	RELOC_MOVEL	D2,joypad
	RELOC_MOVEL	D3,hdload
	beq	skalloc$

	move.l	#639000,D0
	JSRABS	AllocExtMem
	RELOC_MOVEL	D0,SwapBase
	beq	MemErr
	cmp.l	#$200000,D0
	bcs	MemErr
skalloc$

	Mac_printf	"James Pond HD Loader V1.1"
	Mac_printf	"Programmed by JF Fabre © 1997"

	TESTFILE	loadername
	tst.l	D0
	bne	MainErr

	TESTFILE	progname
	tst.l	D0
	bne	MainErr

	; *** some system checks

	JSRGEN	GetAttnFlags
	btst	#AFB_68020,D0
	beq	CpuErr

	JSRABS	Test2MBChip
	tst.l	D0
	bne	ChipErr

	; *** load savegame file

	bsr	ReadSaves
	tst.l	D0
	beq	sok$

	NEWLINE
	Mac_printf	"Savegame file not found"
sok$

	; *** load game data

	move.l	#5000,D0
	JSRABS	LoadSmallFiles

	; *** install save game on exit
	
	RELOC_TSTL	noosswap
	bne	sks$

	lea	WriteSaves(pc),A0
	JSRGEN	SetExitRoutine
sks$

	moveq.l	#0,D0
	move.l	#CACRF_CopyBack,D1
	JSRABS	Degrade

; *** Boot the game

	GO_SUPERVISOR
	moveq.l	#0,D1			; enable low memory consumption
	SAVE_OSDATA	$200000

	lea	$200000,A7

	lea	$80000,A1
	lea	loadername(pc),A0
	moveq.l	#0,D0
	moveq.l	#-1,D1
	bsr	ReadAFile
	
	lea	$80000,A0
	bsr	PatchLoader

	JSRGEN	FlushCachesHard

	nop
	nop
	jmp	$88(A0)
	nop
	nop

PatchGame:
	move.w	#$601A,$174.W

	GETUSRADDR	ReadAFile
	move.l	D0,$1B4.W
	move.l	D0,$1EC.W

	GETUSRADDR	PatchProg
	move.l	D0,$20C.W

	JSRGEN	FlushCachesHard
	jmp	$100.W


PatchLoader:
	move.w	#$6016,$CA(A0)
	GETUSRADDR	PatchGame
	move.l	D0,$110(A0)

	STORE_REGS
	move.l	A0,A1
	lea	$42DF(A1),A1
	move.l	A1,D1
	lea	mess1(pc),A2
	move.l	A2,D0
	JSRGEN	StrcpyAsm

	move.l	A0,A1
	lea	$42FA(A1),A1
	move.l	A1,D1
	lea	mess2(pc),A0
	move.l	A0,D0
	JSRGEN	StrcpyAsm


	RESTORE_REGS
	rts

PatchProg:
	PATCHUSRJMP	$112000,ReadAFile

	; *** installs kb patch

	PATCHUSRJSR	$13972E,kbread

	; *** installs button 2/3/4 emulation (if JOYPAD tooltype off)

	RELOC_TSTL	joypad
	bne	skipj$
	PATCHUSRJSR	$1398C6,emubut2

	; *** up = jump (problems with saves, I had to fix it by hand)

	move.l	#$00040011,$1397D4

	; *** removes a $BFE001 bit change

	move.w	#$600E,$139878

	; *** fix the up = jump problem easily

	PATCHUSRJSR	$143BF4,SaveOk
	PATCHUSRJSR	$143C38,SaveOk

	; *** changes START into SPACE

	lea	$11F9FF,A1
	bsr	CorrectStartString
	lea	$11FB3B,A1
	bsr	CorrectStartString
	lea	$12013C,A1
	bsr	CorrectStartString

	; *** changes YELLOW into FIRE

	move.l	#' FIR',$120110
	move.l	#'E  T',$120114
skipj$

	; *** reinstalls my exception handler

	PATCHUSRJMP	$15A866,RestoreTraps

	; *** $144708: load game (low level)
	; *** $14477C: save game (low level)

	; *** we save at a higher level
	; *** in and from RAM:

	PATCHUSRJMP	$143F9A,LoadGame
	PATCHUSRJMP	$143FBA,SaveGame

	; *** to be able to load scores

	PATCHUSRJSR	$143C16,GetScore
	PATCHUSRJSR	$135806,ClearScore

	; *** decrunch in fastmem (fake PP20 file)

	PATCHUSRJMP	$139660,Decrunch

	JSRGEN	FlushCachesHard
	jmp	$11CC00


Decrunch:
	MOVEM.L	D1-D7/A0-A5,-(A7)	;00: 48E77FFC
	PEA	dec_0011(PC)		;04: 487A00AC
	LEA	4(A0),A4		;08: 49E80004
	ADDA.L	(A0),A0			;0C: D1D0
	MOVEA.L	A1,A3			;0E: 2649
	MOVEQ	#3,D6			;10: 7C03
	MOVEQ	#1,D4			;12: 7801
	MOVEQ	#7,D7			;14: 7E07
	MOVEQ	#1,D5			;16: 7A01
	MOVEA.L	A3,A2			;18: 244B
	MOVE.L	-(A0),D1		;1A: 2220
	TST.B	D1			;1C: 4A01
	BEQ.S	dec_0000		;1E: 6706
	BSR.S	dec_0004		;20: 612A
	SUB.L	D4,D1			;22: 9284
	LSR.L	D1,D5			;24: E2AD
dec_0000:
	LSR.L	#8,D1			;26: E089
	ADDA.L	D1,A3			;28: D7C1
	MOVEA.L	D1,A5			;2A: 2A41
dec_0001:
	BSR.S	dec_0004		;2C: 611E
	BCS.S	dec_000B		;2E: 653E
	MOVEQ	#0,D2			;30: 7400
dec_0002:
	MOVE	D4,D0			;32: 3004
	BSR.S	dec_0007		;34: 6124
	ADD	D1,D2			;36: D441
	CMP	D6,D1			;38: B246
	BEQ.S	dec_0002		;3A: 67F6
dec_0003:
	MOVEQ	#7,D0			;3C: 7007
	BSR.S	dec_0007		;3E: 611A
	MOVE.B	D1,-(A3)		;40: 1701
	DBF	D2,dec_0003		;42: 51CAFFF8
	CMPA.L	A3,A2			;46: B5CB
	BCS.S	dec_000B		;48: 6524
	RTS				;4A: 4E75
dec_0004:
	LSR.L	D4,D5			;4C: E8AD
	BEQ.S	dec_0005		;4E: 6702
	RTS				;50: 4E75
dec_0005:
	MOVE.L	-(A0),D5		;52: 2A20
	ROXR.L	D4,D5			;54: E8B5
	RTS				;56: 4E75
dec_0006:
	SUB	D4,D0			;58: 9044
dec_0007:
	MOVEQ	#0,D1			;5A: 7200
dec_0008:
	LSR.L	D4,D5			;5C: E8AD
	BEQ.S	dec_000A		;5E: 6708
dec_0009:
	ROXL.L	D4,D1			;60: E9B1
	DBF	D0,dec_0008		;62: 51C8FFF8
	RTS				;66: 4E75
dec_000A:
	MOVE.L	-(A0),D5		;68: 2A20
	ROXR.L	D4,D5			;6A: E8B5
	BRA.S	dec_0009		;6C: 60F2
dec_000B:
	MOVE	D4,D0			;6E: 3004
	BSR.S	dec_0007		;70: 61E8
	MOVEQ	#0,D0			;72: 7000
	MOVE.B	0(A4,D1.W),D0		;74: 10341000
	MOVE	D1,D2			;78: 3401
	CMP	D6,D2			;7A: B446
	BNE.S	dec_000E		;7C: 6616
	BSR.S	dec_0004		;7E: 61CC
	BCS.S	dec_000C		;80: 6502
	MOVEQ	#7,D0			;82: 7007
dec_000C:
	BSR.S	dec_0006		;84: 61D2
	MOVE	D1,D3			;86: 3601
dec_000D:
	MOVEQ	#2,D0			;88: 7002
	BSR.S	dec_0007		;8A: 61CE
	ADD	D1,D2			;8C: D441
	CMP	D7,D1			;8E: B247
	BEQ.S	dec_000D		;90: 67F6
	BRA.S	dec_000F		;92: 6004
dec_000E:
	BSR.S	dec_0006		;94: 61C2
	MOVE	D1,D3			;96: 3601
dec_000F:
	ADD	D4,D2			;98: D444
dec_0010:
	MOVE.B	0(A3,D3.W),-(A3)	;9A: 17333000
	MOVE	D3,-(A7)		;9E: 3F03
	ANDI	#$000F,D3		;A0: 0243000F
	MOVE	(A7)+,D3		;A4: 361F
	DBF	D2,dec_0010		;A6: 51CAFFF2
	CMPA.L	A3,A2			;AA: B5CB
	BCS	dec_0001		;AC: 6500FF7E
	RTS				;B0: 4E75
dec_0011:
	MOVE.L	A5,D0			;B2: 200D
	MOVEM.L	(A7)+,D1-D7/A0-A5	;B4: 4CDF3FFE
	RTS				;B8: 4E75
	

CorrectStartString
	lea	spacestr(pc),A0
	moveq	#4,D0
cps$
	move.b	(A0)+,(A1)+
	dbf	D0,cps$
	rts

SaveOk:
	movem.l	D1-D2,-(sp)
	move.w	$DFF000+joy1dat,D1
	move.w	D1,D2
	lsr.w	#1,D1
	eor.w	D2,D1

	btst	#8,D1
	movem.l	(sp)+,D1-D2
	bne	up

	lea	$9E954,A0
	rts			; fire pressed: do save/load
up:
	lea	4(A7),A7
	jmp	$143BB0

ClearScore:
	RELOC_TSTB	GameLoaded
	bne	sk$
	clr.l	$7F78.L		; clear score on beginning of game
sk$
	RELOC_CLRB	GameLoaded
	rts

GetScore:
	movem.l	D0/A1,-(sp)
	moveq	#0,D0
	move.w	$807E,D0
	lea	scorebuffer(pc),A1
	move.l	(A1,D0.L*4),$7F78.W	; restore score

	RELOC_STB	GameLoaded		; to tell not to clear the score

	movem.l	(sp)+,D0/A1
	JMP	$143972		; original game

LoadGame:
	movem.l	A0-A1,-(sp)
	lea	savebuffer(pc),A0
	lea	$9E954,A1
	move.b	#SAVELEN-1,D0
copy$
	move.b	(A0)+,(A1)+
	dbf	D0,copy$
	movem.l	(sp)+,A0-A1

	moveq.l	#0,D0		; always OK
	tst.l	D0
	rts

SaveGame:
	movem.l	A0-A1,-(sp)	
	lea	savebuffer(pc),A1
	lea	$9E954,A0
	move.b	#SAVELEN-1,D0
copy$
	move.b	(A0)+,(A1)+
	dbf	D0,copy$

	moveq.l	#0,D0
	move.w	$807E,D0	; # of save

	lea	scorebuffer(pc),A1
	move.l	$7F78.W,(A1,D0.L*4)

	RELOC_STB	SaveChanged

	movem.l	(sp)+,A0-A1

	moveq.l	#0,D0		; always OK
	tst.l	D0
	rts
	
ReadSaves:
	lea	savename(pc),A0
	lea	savebuffer(pc),A1
	move.l	#DATALEN,D1
	moveq.l	#0,D0
	JSRGEN	ReadUserFileHD
	rts

WriteSaves:
	RELOC_TSTB	SaveChanged
	beq	exit$
	lea	savename(pc),A0
	lea	savebuffer(pc),A1
	move.l	#DATALEN,D1
	moveq.l	#0,D0
	JSRGEN	WriteUserFileHD		; write file in the user directory
	tst.l	D0			; specified by SAVEDIR
	bne	error$
exit$
	rts
error$
	Mac_printf	"** Could not write savegame file"
	Mac_printf	"   Hit Return to exit"
	JSRABS	WaitReturn
	rts


FileErr:
	Mac_printf	"** Some files are missing. Please install the game properly"
	Mac_printf	"** Hit RETURN to exit"
	JSRABS	WaitReturn
	rts

MainErr:
	Mac_printf	"** Some files are missing. Please install the game properly"
	JMPABS	CloseAll

MemErr:
	Mac_printf	"** Not enough memory to run James Pond 3"
	JMPABS	CloseAll

ChipErr:
	Mac_printf	"** You need 2MB of chipmem to run James Pond 3"
	JMPABS	CloseAll

CpuErr:
	Mac_printf	"** You need a 68020 or better to run James Pond 3"
	JMPABS	CloseAll


ReadAFile:
	RELOC_TSTL	hdload
	bne	ReadAFileHD

	STORE_REGS

	tst.w	D0
	bne	exit$

	moveq.l	#-1,D1		; read all the file
	JSRGEN	ReadFileFast

	tst.l	D0
	bne	NotFound		; file not found

exit$
	RESTORE_REGS		; length in D1
	moveq.l	#0,D0
	rts

NotFound:
	lea	FileErr(pc),A0
	JSRGEN	SetExitRoutine
	JSRGEN	InGameExit
	move.w	#$F00,$DFF180
	bra	NotFound

ReadAFileHD:
	STORE_REGS

	tst.w	D0
	bne	exit$
	move.l	A1,A2
	move.l	SwapBase(pc),A1

	GETUSRADDR	reloc_name
	move.l	D0,D1
	move.l	A0,D0
	JSRGEN	StrcpyAsm	; relocates the name (because of gap)
	move.l	D1,A0

	moveq.l	#0,D0
	moveq.l	#-1,D1		; read all the file
	JSRGEN	ReadFileHD
	tst.l	D0
	bne	NotFound
	
trans$
	move.l	(A1)+,(A2)+
	subq.l	#4,D1
	bcc.b	trans$

exit$
	RESTORE_REGS
	rts


emubut2:
	move.w	$DFF016,D2
	move.l	D0,-(sp)
	move.b	but3emu(pc),D0
	bne	flash$
	btst	#14,D2
	bne	noflash$
	bset	#14,D2		; clears 2nd button
flash$
	ori.b	#$40,D4		; emulates 3rd button
noflash$
	move.b	but2emu(pc),D0
	beq	nospace$
	bclr	#14,D2		; emulates 2nd button
nospace$
	btst	#7,$BFE001	; fire pressed
	bne	nofire$
	ori.b	#$20,D4		; emulates yellow button (fight+quit when pause)
nofire$

	move.l	(sp)+,D0
	rts

kbread:
	STORE_REGS
	LEA	$00BFD000,A5
	MOVEQ	#$08,D0
	AND.B	$1D01(A5),D0
	BEQ.S	noquit$
	MOVE.B	$1C01(A5),D0
	NOT.B	D0
	ROR.B	#1,D0		; raw key code here

	movem.l	D0,-(sp)
	moveq.l	#2,D0
	JSRGEN	BeamDelay
	move.l	(sp)+,D0

	BSET	#$06,$1E01(A5)
	NOP
	BCLR	#$06,$1E01(A5)	; acknowledge key

	lea	but2emu(pc),A0
	clr.b	(A0)

	cmp.b	#$4E,D0		; ->
	bne	notadvlev$

	cmp.b	#$2B,$29A9.W
	bcc	nospace$	; >=$2B -> skip

	addq.b	#1,$29A9.W
	addq.b	#1,$29AB.W

	bra	nospace$


notadvlev$
	cmp.b	#$4F,D0		; <-
	bne	notrevlev$

	tst.b	$29A9.W
	beq	nospace$	; =0 -> skip

	subq.b	#1,$29A9.W
	subq.b	#1,$29AB.W


	bra	nospace$
notrevlev$

	cmp.b	#$40,D0		; SPACE pressed?
	bne	nospace$

	st.b	(A0)
nospace$

	cmp.b	#$44,D0		; RETURN pressed?
	bne	noret$

	st.b	$7FA6		; completes level
	st.b	$7C8A		; completes level
	clr.b	$7B1F		; no revisit
	st.b	$7BC5		; allow save
noret$

	lea	but3emu(pc),A0
	clr.b	(A0)

	cmp.b	#$5F,D0		; HELP pressed? (flash)
	bne	noflash$

	st.b	(A0)
noflash$

	cmp.b	#$59,D0		; F10 Key?
	bne	noquit$
	JSRGEN	InGameExit
noquit$
	RESTORE_REGS

	move.w	$DFF00C,D0	; original game
	rts

RestoreTraps:
	JSRGEN	PatchExceptions
	ILLEGAL



SwapBase:
	dc.l	0
but2emu:
	dc.l	0
but3emu:
	dc.l	0
joypad:
	dc.l	0
noosswap:
	dc.l	0
hdload:
	dc.l	0


mess1:	;	                                                          
	dc.b	" HD loader by JF Fabre ",0

mess2:	;	                                                          
	dc.b	"    Look out for other prods",0

loadername:
	dc.b	"Loader",0
progname:
	dc.b	"Code.bin",0
savename:
	dc.b	"jp3.sav",0
spacestr:
	dc.b	"SPACE",0
reloc_name:
	blk.b	$20,0
SaveChanged:
	dc.b	0
GameLoaded:
	dc.b	0
	cnop	0,4
savebuffer:
	blk.b	SAVELEN,0
scorebuffer:
	blk.l	$10,0
