**
** System functions, Keyboard handling, VBI handling, TFS Data system, etc.
** Programmed by Peter Bakota in 1995, (c)1992,95 Tenax Software.
** All rights reserved.
**

* Get all system memory!

REG_FastBase	equr	d4
REG_FastMem	equr	d5
REG_ChipBase	equr	d6
REG_ChipMem	equr	d7

GetAllMem
	moveq	#0,REG_ChipBase
	moveq	#0,REG_FastBase
	bset	#bitMUSICOK,SysFlags(a5)
	move.l	#MIN_CHIP_MEMORY,REG_ChipMem
	move.l	#MEMF_FAST+MEMF_LARGEST,d1
	CallSys	AvailMem
	tst.l	d0
	beq	.NoFast
	move.l	#MAX_PUBL_MEMORY,REG_FastMem
	cmp.l	#MAX_PUBL_MEMORY,d0
	bge	.GetF
	move.l	#MIN_PUBL_MEMORY,REG_FastMem
	cmp.l	#MIN_PUBL_MEMORY,d0
	blt	.NoFast
	bclr	#bitMUSICOK,SysFlags(a5)
.GetF	move.l	REG_FastMem,d0
	move.l	#MEMF_FAST+MEMF_CLEAR,d1
	jsr	AllocMem(a6)
	move.l	d0,REG_FastBase
	bne	.FastOk
	bset	#bitMUSICOK,SysFlags(a5)
.NoFast	move.l	#MEMF_CHIP+MEMF_LARGEST,d1
	jsr	AvailMem(a6)
	move.l	#MAX_PUBL_MEMORY,REG_FastMem
	cmp.l	#MAX_PUBL_MEMORY+MIN_CHIP_MEMORY,d0
	bge	.GetF2
	move.l	#MIN_PUBL_MEMORY,REG_FastMem
	cmp.l	#MIN_PUBL_MEMORY+MIN_CHIP_MEMORY,d0
	blt	.Error
	bclr	#bitMUSICOK,SysFlags(a5)
.GetF2	move.l	REG_FastMem,d0
	move.l	#MEMF_CHIP+MEMF_CLEAR,d1
	jsr	AllocMem(a6)
	move.l	d0,REG_FastBase
	beq	.Error
.FastOk	move.l	#MEMF_CHIP+MEMF_LARGEST,d1
	jsr	AvailMem(a6)
	sub.l	#10*1024,d0		;Reserved for SYSTEM! (10K)
	move.l	d0,REG_ChipMem
	cmp.l	#MIN_CHIP_MEMORY,d0
	blt	.Error
	move.l	#MEMF_CHIP+MEMF_CLEAR,d1
	jsr	AllocMem(a6)
	move.l	d0,REG_ChipBase
	beq	.Error

	movem.l	REG_ChipBase/REG_ChipMem,SysLocMem(a5)
	move.l	REG_ChipBase,LowLocMem(a5)
	move.l	REG_ChipBase,LocTop(a5)
	add.l	REG_ChipMem,REG_ChipBase
	move.l	REG_ChipBase,MaxLocMem(a5)

	movem.l	REG_FastBase/REG_FastMem,SysExtMem(a5)
	move.l	REG_FastBase,LowExtMem(a5)
	move.l	REG_FastBase,ExtTop(a5)
	add.l	REG_FastMem,REG_FastBase
	move.l	REG_FastBase,MaxExtMem(a5)
	rts
	
.Error	tst.l	REG_ChipBase
	beq	.NoChip
	move.l	REG_ChipBase,a1
	move.l	REG_ChipMem,d0
	jsr	FreeMem(a6)
.NoChip	tst.l	REG_FastBase
	beq	.NoPubl
	move.l	REG_FastBase,a1
	move.l	REG_FastMem,d0
	jsr	FreeMem(a6)
.NoPubl	moveq	#0,d0
	rts	
*
* Release System memory...
FreeAllMem
	tst.l	SysExtMem(a5)
	beq	.NoExtMem
	move.l	SysExtMem(a5),a1
	move.l	SysExtLen(a5),d0
	CallSys	FreeMem
.NoExtMem
	tst.l	SysLocMem(a5)
	beq	.NoLocMem
	move.l	SysLocMem(a5),a1
	move.l	SysLocLen(a5),d0
	CallSys	FreeMem
.NoLocMem
	rts

* MyAllocMem(Bytes, Flags), Allocates Memory buffer!
MyAllocMem
	addq.l	#4,d0
	move.l	d0,-(sp)
	CallSys	AllocMem
	tst.l d0
	beq	.A
	move.l	d0,a0
	addq.l	#4,d0
	move.l	(sp),(a0)
.A 	addq.w	#4,sp
	rts

* MyFreeMem(BufferPtr), DeAlloctaes Memory buffer!
MyFreeMem
	move.l	a1,d0
	beq	.NoMem
	move.l	-(a1),d0
	CallSys	FreeMem
.NoMem	rts

NT_INTERRUPT	EQU	2	;Interrupt node type!

* SetUp KB & VBI interrupts!
AddInterrupts
	CallSys	Disable
	jsr	Forbid(a6)
	lea	Interrupt6c(a5),a1
	lea	IRout6c(pc),a0
	move.b	#NT_INTERRUPT,is_Type(a1)
	move.l	a0,is_Code(a1)
	move.l	a5,is_Data(a1)
	moveq 	#5,d0
	jsr	AddIntServer(a6)
	lea	Interrupt68(a5),a1
	lea	IRout68(pc),a0
	move.b	#NT_INTERRUPT,is_Type(a1)
	move.l	a0,is_Code(a1)
	move.l	a5,is_Data(a1)
	moveq 	#3,d0
	jsr	AddIntServer(a6)
	jsr	Enable(a6)
	rts

* Removes Interrupts
RemInterrupts
	CallSys	Disable
	lea	Interrupt6c(a5),a1
	moveq 	#5,d0
	jsr	RemIntServer(a6)
	lea	Interrupt68(a5),a1
	moveq 	#3,d0
	jsr	RemIntServer(a6)
	jsr	Enable(a6)
	jsr	Permit(a6)
	rts

* Sets Copper & Custom Registers
SetChips
	CallGfx	WaitBlit
	jsr	OwnBlitter(a6)
	jsr	WaitBlit(a6)
	lea	$dff000,a6
	move.l	$68.w,Old68(a5)
	move.l	$6c.w,Old6c(a5)
	move.w	$02(a6),s96(a5)
	move.w	$1c(a6),s9a(a5)
	or.w	#$8000,s96(a5)
	or.w	#$c000,s9a(a5)
	move.w	#$7fff,$9c(a6)
.A 	btst	#5,$1f(a6)
	beq	.A
	move.w	#$7fff,$96(a6)
	move.w	#$83d0,$96(a6)
	clr.w 	$106(a6)
	clr.w 	$1fc(a6)
	move.w	#$20,$1dc(a6)
	move.l	#$7fff7fff,$dff09a
	move.l	#IRout68Server,$68.w	;Program Interrupt handler!
	move.l	#IRout6cServer,$6c.w
	move.w	#$c028,$dff09a
	bset	#1,$bfe001
	move.l	IntuiBase(a5),a1
	move.w	#AutoReq,a0
	pea	NewAReq(pc)
	move.l	(sp)+,d0
	CallSys	SetFunc
	move.l	d0,OldAReq(a5)
	rts

* Close down Prog. for Exit witout ReBoot!!!
RestoreChips
	CallGfx	WaitBlit
	lea	$dff000,a6
	move.w	#$7fff,$96(a6)
	move.w	#$7fff,$9c(a6)
	move.w	#$7fff,$9a(a6)
	move.l	Old68(a5),$68.w
	move.l	Old6c(a5),$6c.w
	move.l	GfxBase(a5),a1
	move.l	gb_OldCop(a1),$80(a6)
	clr.w 	$88(a6)
	move.w	#$20,$1dc(a6)
	move.w	s96(a5),d0
	move.w	d0,$96(a6)
	not.w 	d0
	move.w	d0,$96(a6)
	move.w	s9a(a5),d0
	move.w	d0,$9a(a6)
	not.w 	d0
	move.w	d0,$9a(a6)
	CallGfx	DisownBlitter
	move.l	IntuiBase(a5),a1
	move.w	#AutoReq,a0
	move.l	OldAreq(a5),d0
	CallSys	SetFunc
	rts

* Switch System On befor loading a data file...
SwitchSysON
*	move.l	#$7fff7ffff,$dff09a
	move.l	Old68(a5),$68.w
	move.l	Old6c(a5),$6c.w
	move.w	s9a(a5),$dff09a
	move.w	#$a000,$dff09a
	CallGfx	WaitBlit
	jsr	DisownBlitter(a6)
	st 	SystemFlag(a5)
	rts

* Switch system Off after loading...
SwitchSysOFF
	CallGfx	WaitBlit
	jsr	OwnBlitter(a6)
	jsr	WaitBlit(a6)
*	move.l	#$7fff7fff,$dff09a
	move.l	#IRout68Server,$68.w
	move.l	#IRout6cServer,$6c.w
*	move.w	#$e000,$dff09a
	clr.w 	SystemFlag(a5)
	rts

* Switch Disk Motor Off (FORBID()!!!!! )
MtrOFF	or.b	#$f8,$bfd100
	and.b 	#$87,$bfd100
	or.b	#$78,$bfd100
	rts

* Load & Allocate Data From TFS Data file.
* fileid=a0, memtype =d0 (0=CHIP, 1=PUBLIC)
LoadData
	mulu	#12,d0
	lea	MaxLocMem(a5),a2
	lea	mc_Top(a2,d0.l),a2
	tst.l 	(a2)
	bne	.MemExist
	lea	MaxLocMem+mc_Top(a5),a2
.MemExist
	move.l	(a2),a1
	bsr	LoadFile
	move.l	d0,d1
	beq	.End
	move.l	a0,d0
	btst	#0,d1
	beq	.NotOdd		;Size must be EVEN!
	addq.l	#1,d1
.NotOdd	add.l 	d1,(a2)
.End	rts

; fileid=a0, buffer=a1
LoadFile
	pea	TFSHeader+8(a5)
	move.l	(sp)+,d0
	move.l	TFSData(a5),TFSHandler(a5)
	bsr	ReadTFSData
	tst.l 	d0
	bne	.End
.Loop	move.b	$dff006,$dff181
	btst	#6,$bfe001
	bne	.Loop
.End	rts

; Name=a0, Header=a1
; Return : d0=filehandler
OpenTFSFile
	movem.l	d4/a2,-(sp)
	move.l	a1,a2
	move.l	a0,d1
	move.l	#MODE_OLDFILE,d2
	CallDos	Open
	tst.l	d0
	beq	.Exit
	move.l	d0,d4
	move.l	d0,d1
	move.l	a2,d2
	moveq	#8,d3
	jsr	Read(a6)
	cmp.l	#8,d0
	bne	.Error
	cmp.l	#'TFS'<<8+1,(a2)+
	bne	.Error
	move.l	d4,d1
	move.l	(a2)+,d3
	lsl.l	#3,d3
	move.l	a2,d2
	jsr	Read(a6)
	cmp.l	d0,d3
	bne	.Error
	move.l	d4,d0
.Exit	movem.l	(sp)+,d4/a2
	rts
.Error	move.l	d4,d1
	bsr	CloseTFSFile
	moveq	#0,d0
	bra	.Exit

;Handler=d1
CloseTFSFile
	tst.l	d1
	beq	.Exit
	CallDos	Close
.Exit	rts

OpenTFSData
	lea	TFSName,a0
	lea	TFSHeader(a5),a1
	bsr	OpenTFSFile
	move.l	d0,TFSData(a5)
	rts

CloseTFSData
	move.l	TFSData(a5),d1
	bra	CloseTFSFile

; Read data from TFS data file.
;dataid=a0, buffer=a1, headerdata=d0
ReadTFSData
	move.l	a2,-(sp)
	add.w 	a0,a0
	add.w 	a0,a0
	add.w 	a0,a0
	add.l 	d0,a0
	movem.l	a0/a1,-(sp)
	bsr	SwitchSysON
	st	MotorFlag(a5)
	move.l	TFSHandler(a5),d1
	move.l	(sp)+,a2
	move.l	(a2)+,d2
	moveq 	#OFFSET_BEGINING,d3
	CallDos	Seek
	move.l	TFSHandler(a5),d1
	move.l	(sp),d2
	move.l	(a2),d3
	jsr	Read(a6)
	move.l	d0,-(sp)
	bsr	SwitchSysOFF
	movem.l	(sp)+,d0/a0
	cmp.l 	(a2),d0
	bne	.FileError
	cmp.l	#'CrM2',(a0)	;Cruncher $Id! (Crunchmania LZH!)
	bne	.End
	bsr	DepackData
.End	move.l	(sp)+,a2
	rts
.FileError
	moveq #0,d0
	bra	.End

; Get real data size
; fileid=a0, header=d0

REG_FileSize	equr	d4

GetTFSDataSize
	movem.l	REG_FileSize/a2,-(sp)
	lea	-10(sp),sp
	move.l	sp,a2
	add.w	a0,a0	
	add.w	a0,a0	
	add.w	a0,a0
	add.l	d0,a0
	move.l	a0,-(sp)
	bsr	SwitchSysON
	st	MotorFlag(a5)
	move.l	(sp)+,a0
	move.l	(a0)+,d2
	move.l	(a0),REG_FileSize
	move.l	TFSHandler(a5),d1
	moveq	#OFFSET_BEGINING,d3
	CallDos	Seek
	move.l	TFSHandler(a5),d1
	move.l	a2,d2
	moveq	#10,d3
	jsr	Read(a6)
	move.l	d0,-(sp)
	bsr	SwitchSysOFF
	move.l	(sp)+,d0
	cmp.l	#10,d0
	bne	.Error
	cmp.l	#'CrM2',(a2)
	bne	.NoCrm
	move.l	4+2(a2),REG_FileSize
.NoCrm	move.l	REG_FileSize,d0
.Exit	lea	10(sp),sp
	movem.l	(sp)+,REG_FileSize/a2
	rts

.Error	moveq	#0,d0
	bra	.Exit

********************* Set directory from filename & get ROOT volume name!

SetDir	move.l	WBMessage(pc),d0
	beq	.Cli
	move.l	d0,a0
	move.l	sm_ArgList(a0),a0
	move.l	wa_Lock(a0),d6
	move.l	DosBase(a5),a6
	bra	.CDir

.Cli	moveq	#0,d1
	moveq	#ACCESS_READ,d2
	CallDos	Lock
	move.l	d0,d6
.CDir	move.l	d6,-(sp)
	move.l	d6,d1
.Loop5	jsr	ParentDir(a6)
	move.l	d0,d1
	beq	.Loop4
	move.l	d0,d6
	bra	.Loop5
.Loop4	move.l	(sp)+,d1
	jsr	CurrDir(a6)
	move.l	d0,OldDir(a5)
	lsl.l	#2,d6
	move.l	d6,a0
	move.l	fl_Volume(a0),a0
	add.l	a0,a0
	add.l	a0,a0
	move.l	dl_Name(a0),a0
	add.l	a0,a0
	add.l	a0,a0
	lea	MainVolume(a5),a1
	move.b	(a0)+,d0
.Loop6	move.b	(a0)+,(a1)+
	subq.b	#1,d0
	bne	.Loop6
	move.b	#':',(a1)
	rts

***************************** Restore old CD
RestoreDir
	move.l	OldDir(a5),d1
	CallDos	CurrDir
	move.l	WBMessage(pc),d1
	beq	.Cli
	move.l	d0,d1
	jsr	UnLock(a6)
.Cli	rts

***************************** CHECK DISK & WAIT FOR INSERT
REG_CopPlane	equr	d6
REG_CopList	equr	d7
REG_Message	equr	a2

**
** CheckDisk("Path:Filename")
**               a0
CheckDisk
	movem.l	d0-d7/a0-a6,-(sp)
	lea	VolumeName(pc),a1
.Loop	move.b	(a0)+,d0
	move.b	d0,(a1)+
	beq	.RestDisk
	cmp.b	#'/',d0
	beq	.RestDisk
	cmp.b	#':',d0
	bne	.Loop
	clr.b	(a1)
	lea	VolumeText(pc),REG_Message
	bra	.Loop0
.RestDisk
	lea	VolumeName(pc),a0
	lea	MainVolume(a5),a1
.Loop01	move.b	(a1)+,(a0)+
	bne	.Loop01
	lea	RestoreText(pc),REG_Message
.Loop0	bsr	SwitchSysON
	st	MotorFlag(a5)
	CallSys	Permit
	pea	VolumeName(pc)
	move.l	(sp)+,d1
	move.l	#ACCESS_READ,d2
	CallDos	Lock
	tst.l	d0
	beq	.Loop11
	move.l	d0,d1
	jsr	UnLock(a6)
	CallSys	Forbid
	bsr	SwitchSysOFF
	bra	.Exit
.Loop11	move.l	CopperListB(a5),a0
	add.l	#26*4*4,a0
	move.l	a0,REG_CopList
	move.l	a0,d0
	add.l	#20*4,d0
	move.l	d0,REG_CopPlane
	bsr	MakeCListReq
	move.l	REG_CopPlane,a0
	moveq	#(42*8)/4-1,d0
.Loop1	clr.l	(a0)+
	dbf	d0,.Loop1
	move.l	REG_Message,a0
	move.l	a0,d0
.Loop2	tst.b	(a0)+
	bne	.Loop2
	subq.w	#1,a0
	exg	d0,a0
	sub.l	a0,d0
	moveq	#42,d1
	sub.w	d0,d1
	lsr.w	d1
	move.w	d1,a1
	add.l	REG_CopPlane,a1	
	bsr	PrintCText
	bsr	WaitBOF
	move.w	#$7fff,$dff096
	move.l	REG_CopList,$dff080
	clr.w	$dff088
	move.w	#$83d0,$dff096
	move.w	#200,d0
	bsr	WaitX
.Loop3	cmp.b	#$45,KBRaw(a5)		;Check for ABORT! (ESC-Key)
	beq	.Loop5
	pea	VolumeName(pc)
	move.l	(sp)+,d1
	move.l	#ACCESS_READ,d2
	CallDos	Lock
	tst.l	d0
	bne	.Loop4
	moveq	#4,d0
	bsr	WaitX
	bra	.Loop3
.Loop4	move.l	d0,d1
	jsr	UnLock(a6)
.Loop5	CallSys	Forbid
	bsr	SwitchSysOFF
	bsr	WaitBOF
	move.w	#$7fff,$dff096
	move.l	LastCopperList(a5),$dff080
	clr.w	$dff088
	move.w	#$83d0,$dff096
.Exit	movem.l	(sp)+,d0-d7/a0-a6
	rts

RestoreText
	dc.b	"INSERT TENABLASTER DISK",0
VolumeText
	dc.b	"INSERT DISK VOLUME "
VolumeName
	ds.b	40
	even
**
** Print Text to Requester ("Insert/replace volume...")
** Text=a0, Destaddr=a1
PrintCText
	moveq	#0,d0
.Loop	move.b	(a0)+,d0
	beq	.Exit
	movem.l	a0/a1,-(sp)
	lea	Font-$20,a0
	add.w	d0,a0
	move.b	0*FMOD(a0),0*42(a1)
	move.b	1*FMOD(a0),1*42(a1)
	move.b	2*FMOD(a0),2*42(a1)
	move.b	3*FMOD(a0),3*42(a1)
	move.b	4*FMOD(a0),4*42(a1)
	move.b	5*FMOD(a0),5*42(a1)
	move.b	6*FMOD(a0),6*42(a1)
	move.b	7*FMOD(a0),7*42(a1)
	movem.l	(sp)+,a0/a1
	addq.w	#1,a1
	bra	.Loop
.Exit	rts

**
** New SYSTEM auto requester for disk handling...
**
NewAReq	movem.l	d1-d7/a0-a6,-(sp)
	movem.l	d0-d3/a0-a3,-(sp)
	move.l	VarsPtr(pc),a5
	moveq	#0,d7
	tst.w	SystemFlag(a5)
	bne	.SysEna
	moveq	#-1,d7
	bsr	SwitchSysON
.SysEna	moveq	#3,d0
	bsr	WaitX
	move.l	GfxBase(a5),a0
	move.l	gb_OldCop(a0),$dff080
	clr.w	$dff088
	CallInt	WBToFront
	move.w	#-1,IntEnabled(a5)
	move.l	OldAReq(a5),a4
	movem.l	(sp)+,d0-d3/a0-a3
	jsr	(a4)		;Call intuition's auto requester
	move.l	d0,-(sp)
	clr.w	IntEnabled(a5)
	CallInt	WBToBack
	moveq	#3,d0
	bsr	WaitX
	move.l	LastCopperList(a5),$dff080
	clr.w	$dff088
	tst.w	d7
	beq	.Skip
	bsr	SwitchSysOFF
.Skip	movem.l	(sp)+,d0-d7/a0-a6
	rts

**************** Crunchmania LZH ($Id = CrM2) decruncher ******************

SECURITYOFFSET	EQU	60

DepackData				;This part of code 
	movem.l	d1-d7/a0-a6,-(sp)	;is only for safe data decrunching with
	lea	-SECURITYOFFSET(sp),sp	;ovelaped memory areas!
	move.l	sp,a1
	lea	-SECURITYOFFSET(a0),a0
	moveq	#SECURITYOFFSET-1,d1
.Loop1	move.b	(a0)+,(a1)+
	dbf	d1,.Loop1
	moveq	#0,d1
	move.w	4(a0),d1
	moveq	#4+4+4+2,d0
	add.l	4+4+2(a0),d0
	lsr.l	#2,d0
	move.l	a0,a1
.Loop2	move.l	(a1)+,-SECURITYOFFSET-4(a1)
	subq.l	#1,d0
	bpl	.Loop2
	move.l	a0,a1
	sub.l	d1,a1
	lea	-SECURITYOFFSET(a0),a0
	move.l	a0,-(sp)
	move.l	4+2(a0),-(sp)
	bsr	LzhDecrunch
	movem.l	(sp)+,d0/a0
	move.l	sp,a1
	moveq	#SECURITYOFFSET-1,d1
.Loop3	move.b	(a1)+,(a0)+
	dbf	d1,.Loop3
	lea	SECURITYOFFSET(sp),sp
	movem.l	(sp)+,d1-d7/a0-a6
	rts

** This code was ripped from MANIA (The crunchmania run-time decruncher!)
** Sorry! But I want the best compression and the LZH it is!

;********************* Decrunches (LZH) crunchmania (CrM2) data
; CrM2Data=A0, Destination=A1
LZHDecrunch
	MOVE.L	A0,A2
	CMP.L	#'CrM2',(A2)+
	BNE	lbC0009CA
	MOVEQ	#0,D0
	MOVE.W	(A2)+,D0
	MOVE.L	(A2)+,D1
	MOVE.L	(A2)+,D2
	ADD.L	D0,A1
LZHNormal
	LEA	LZHuffmanBuffer+2(PC),A6
	ADD.L	D1,A1
	ADD.L	D2,A2
	MOVE.W	-(A2),D0
	MOVE.L	-(A2),D6
	MOVEQ	#$10,D7
	SUB.W	D0,D7
	LSR.L	D7,D6
	MOVE.W	D0,D7
	MOVEQ	#$10,D3
	BRA	lbC000894

lbC0007BA
	SUBQ.W	#1,D7
	LSR.L	#1,D6
	ADDX.W	D1,D1
	CMP.W	(A4)+,D1
	BMI	lbC00086C
	SUBQ.W	#1,D7
	LSR.L	#1,D6
	ADDX.W	D1,D1
	CMP.W	(A4)+,D1
	BMI	lbC00086C
	SUBQ.W	#1,D7
	LSR.L	#1,D6
	ADDX.W	D1,D1
	CMP.W	(A4)+,D1
	BMI	lbC00086C
	SUBQ.W	#1,D7
	LSR.L	#1,D6
	ADDX.W	D1,D1
	CMP.W	(A4)+,D1
	BMI	lbC00086C
	SUBQ.W	#1,D7
	LSR.L	#1,D6
	ADDX.W	D1,D1
	CMP.W	(A4)+,D1
	BMI.S	lbC00086C
	SUBQ.W	#1,D7
	LSR.L	#1,D6
	ADDX.W	D1,D1
	CMP.W	(A4)+,D1
	BMI.S	lbC00086C
	SUBQ.W	#1,D7
	LSR.L	#1,D6
	ADDX.W	D1,D1
	CMP.W	(A4)+,D1
	BMI.S	lbC00086C
	SUBQ.W	#1,D7
	LSR.L	#1,D6
	ADDX.W	D1,D1
	CMP.W	(A4)+,D1
	BMI.S	lbC00086C
	SUBQ.W	#1,D7
	LSR.L	#1,D6
	ADDX.W	D1,D1
	CMP.W	(A4)+,D1
	BMI.S	lbC00086C
	SUBQ.W	#1,D7
	LSR.L	#1,D6
	ADDX.W	D1,D1
	CMP.W	(A4)+,D1
	BMI.S	lbC00086C
	SUBQ.W	#1,D7
	LSR.L	#1,D6
	ADDX.W	D1,D1
	CMP.W	(A4)+,D1
	BMI.S	lbC00086C
	SUBQ.W	#1,D7
	LSR.L	#1,D6
	ADDX.W	D1,D1
	CMP.W	(A4)+,D1
	BMI.S	lbC00086C
	SUBQ.W	#1,D7
	LSR.L	#1,D6
	ADDX.W	D1,D1
	CMP.W	(A4)+,D1
	BMI.S	lbC00086C
	SUBQ.W	#1,D7
	LSR.L	#1,D6
	ADDX.W	D1,D1
	CMP.W	(A4)+,D1
	BMI.S	lbC00086C
	SUBQ.W	#1,D7
	LSR.L	#1,D6
	ADDX.W	D1,D1
	CMP.W	(A4)+,D1
	BMI.S	lbC00086C
	MOVEQ	#$10,D7
lbC00085A
	MOVE.W	D6,D0
	LSR.L	#1,D6
	ADDX.W	D1,D1
	SWAP	D6
	MOVE.W	-(A2),D6
	SWAP	D6
	CMP.W	(A4)+,D1
	BPL	lbC0007BA
lbC00086C
	ADD.W	$3E(A4),D1
	ADD.W	D1,D1
	MOVE.W	0(A0,D1.W),D0
	RTS
lbB000877	EQU	*-1

	dc.b	$FE,$F4,$EA,$E0,$D6,$CC,$C2,$B8,$AE,$A4,$9A,$90,$84
	dc.b	$78,$6C,$60

lbC000888
	MOVEQ	#-$1,D0
	MOVE.B	lbB000877(PC,D7.W),D0
	MOVEQ	#0,D1
	JMP	lbC00085A(PC,D0.W)

lbC000894
	LEA	$49E(A6),A0
	MOVEQ	#15,D2
lbC00089A
	CLR.L	(A0)+
	DBRA	D2,lbC00089A

	LEA	$4BE(A6),A0
	LEA	$9E(A6),A4
	MOVEQ	#9,D2
	BSR	lbC00095E
	LEA	$49E(A6),A0
	LEA	$80(A6),A4
	MOVEQ	#4,D2
	BSR	lbC00095E
	LEA	$4BE(A6),A3
	LEA	-2(A6),A4
	BSR	lbC000996
	LEA	$49E(A6),A3
	LEA	$1E(A6),A4
	BSR	lbC000996
	MOVEQ	#$10,D1
	BSR.S	lbC000926
	MOVE.W	D0,D5
	LEA	$9E(A6),A0
	LEA	-$1E(A0),A5
lbC0008E2
	MOVE.L	A6,A4
	BSR.S	lbC000888
	BTST	#8,D0
	BNE.S	lbC000914
	MOVE.W	D0,D4
	LEA	$20(A6),A4
	EXG	A0,A5
	BSR.S	lbC000888
	EXG	A0,A5
	MOVE.W	D0,D1
	MOVE.W	D0,D2
	BNE.S	lbC000902
	MOVEQ	#1,D1
	MOVEQ	#$10,D2
lbC000902
	BSR.S	lbC000926
	BSET	D2,D0
	LEA	1(A1,D0.W),A3
lbC00090A
	MOVE.B	-(A3),-(A1)
	DBRA	D4,lbC00090A

	MOVE.B	-(A3),-(A1)
	MOVE.B	-(A3),D0
lbC000914
	MOVE.B	D0,-(A1)
	DBRA	D5,lbC0008E2

	MOVEQ	#1,D1
	BSR.S	lbC000926
	BNE	lbC000894
	BRA	lbC0009CA

lbC000926
	MOVE.W	D6,D0
	LSR.L	D1,D6
	SUB.W	D1,D7
	BGT.S	lbC000936
	ADD.W	D3,D7
	ROR.L	D7,D6
	MOVE.W	-(A2),D6
	ROL.L	D7,D6
lbC000936
	ADD.W	D1,D1
	AND.W	lbC00093C(PC,D1.W),D0
lbC00093C
	RTS

	dc.w	1,3,7,15,$1F,$3F,$7F,$FF,$1FF,$3FF,$7FF,$FFF,$1FFF
	dc.w	$3FFF,$7FFF,$FFFF

lbC00095E
	MOVEM.L	D1-D5/A3,-(SP)
	MOVEQ	#4,D1
	BSR.S	lbC000926
	MOVE.W	D0,D5
	SUBQ.W	#1,D5
	MOVEQ	#0,D4
	SUB.L	A3,A3
lbC00096E
	ADDQ.W	#1,D4
	MOVE.W	D4,D1
	CMP.W	D2,D1
	BLE.S	lbC000978
	MOVE.W	D2,D1
lbC000978
	BSR.S	lbC000926
	MOVE.W	D0,(A0)+
	ADD.W	D0,A3
	DBRA	D5,lbC00096E

	MOVE.W	A3,D5
	SUBQ.W	#1,D5
lbC000986
	MOVE.W	D2,D1
	BSR.S	lbC000926
	MOVE.W	D0,(A4)+
	DBRA	D5,lbC000986

	MOVEM.L	(SP)+,D1-D5/A3
	RTS

lbC000996
	MOVEM.L	D0-D7,-(SP)
	CLR.W	(A4)+
	MOVEQ	#14,D7
	MOVEQ	#-$1,D4
	MOVEQ	#0,D2
	MOVEQ	#0,D3
	MOVEQ	#1,D1
lbC0009A6
	MOVE.W	(A3)+,D6
	MOVE.W	D3,$40(A4)
	MOVE.W	-2(A4),D0
	ADD.W	D0,D0
	SUB.W	D0,$40(A4)
	ADD.W	D6,D3
	MULU	D1,D6
	ADD.W	D6,D2
	MOVE.W	D2,(A4)+
	LSL.W	#1,D2
	DBRA	D7,lbC0009A6

	MOVEM.L	(SP)+,D0-D7
	RTS

lbC0009CA
	RTS

LZHuffmanBuffer
	ds.b	$4e0

;**************************************** CrM! decruncher End!

**
** memstart=AllocMemBlock(Bytes,MemType)
**   D0			 D0	  D1
	rsreset
mc_Upper rs.l	1
mc_Lower rs.l	1
mc_Top	 rs.l	1
mc_SIZEOF equ	__RS

AllocMemBlock
	MOVEM.L	A0-A1,-(SP)
gm_TryAgain
	LEA	MaxLocMem(a5),A1
	TST.L 	D1
	BEQ	gm_LocalMem
	TST.L 	MaxExtMem(a5)
	BEQ	gm_LocalMem
	LEA	MaxExtMem(a5),A1
gm_LocalMem
	MOVE.L	mc_Top(A1),A0
	ADDQ.L	#3,D0
	AND.L 	#-4,D0		;Long word align!
	LEA	(A0,D0.L),A0
	CMP.L 	mc_Upper(A1),A0
	BLS	gm_MemOkay
	TST.L 	D1
	BEQ	MemoryError
	MOVEQ 	#0,D1
	BRA	gm_TryAgain 	;Try Local mem if there no ext mem!
gm_MemOkay
	MOVE.L	mc_Top(A1),D0
	MOVE.L	A0,mc_Top(A1)
	MOVE.L	D0,A1
gm_ClearArea
	CLR.L 	(A1)+		;Always clear the memory!
	CMP.L 	A0,A1
	BLO	gm_ClearArea
gm_End	MOVEM.L	(SP)+,A0-A1
	RTS

MemoryError
.Loop	move.w	#$0aa0,$dff180
	btst	#6,$bfe001
	bne	.Loop
	moveq	#0,d0
	bra	gm_End

* The low level Keyboard interrupt handler!
IRout68Server
	btst	#3,$bfed01
	beq	.Exit
	movem.l	d0/a0/a1,-(sp)
	move.l	VarsPtr(pc),a1
	lea	Interrupt68(a1),a1
	move.l	is_Code(a1),a0
	move.l	is_Data(a1),a1
	jsr	(a0)
	or.b	#$40,$bfee01
	clr.b	$bfec01
	moveq	#$3,d0
	add.b 	$dff006,d0
.Loop 	cmp.b 	$dff006,d0
	bne	.Loop
	move.b	#$ff,$bfec01
	and.b 	#$bf,$bfee01
	movem.l	(sp)+,d0/a0/a1
.Exit 	move.w	#$8,$dff09c
	rte

* The low level VBI interrupt handler!
IRout6cServer
	btst	#5,$dff01f
	beq	.Exit
	movem.l	d0/a0/a1,-(sp)
	move.l	VarsPtr(pc),a1
	lea	Interrupt6c(a1),a1
	move.l	is_Code(a1),a0
	move.l	is_Data(a1),a1
	jsr	(a0)
	movem.l	(sp)+,d0/a0/a1
	move.w	#$20,$dff09c
.Exit 	rte

IRout6c	movem.l	d1-d7/a0-a6,-(sp)
	move.l	a1,a5
	tst.w 	SystemFlag(a5)
	bne	.NoMtr2
	tst.w	MotorFlag(a5)
	beq	.NoMtr
	addq.w	#1,MotorCnt(a5)
	cmp.w	#MOTORDELAY,MotorCnt(a5)
	blo.s	.NoMtr
	bsr	MtrOFF
	clr.w	MotorFlag(a5)
.NoMtr2	clr.w	MotorCnt(a5)
.NoMtr	tst.w 	MusicEnabled(a5)
	beq	.NoMusic
	move.l	a5,-(sp)
	CallMusic mt_music
	move.l	(sp)+,a5
.NoMusic
	bsr	SoundFxCounters
	addq.l	#1,BeamCount(a5)
.Exit 	movem.l	(sp)+,d1-d7/a0-a6
	moveq #0,d0
	rts

IRout68	move.l	a0,-(sp)
	moveq 	#0,d0
	move.b	$bfec01,d0
	lea	KBMatrix(a1),a0
	clr.b 	KBLastK(a1)
	st	KBRaw(a1)
	not.b 	d0
	lsr.w 	d0
	scc	(a0,d0.w)
	bcs	.KBExit
	move.b	KBAsciiTab(pc,d0.w),KBLastK(a1)
	move.b	d0,KBRaw(a1)
.KBExit	move.l	(sp)+,a0
	moveq 	#0,d0
	rts

* The RAW->ASCII conversion table!
KBAsciiTab
	dc.b	"`","1","2","3","4","5","6","7","8","9","0","-","=","`",$00,"0"
	dc.b	"Q","W","E","R","T","Y","U","I","O","P",$00,$00,$00,"1","2","3"
	dc.b	"A","S","D","F","G","H","J","K","L",":","#",$00,$00,"4","5","6"
	dc.b	$00,"Z","X","C","V","B","N","M",",",".","/",$00,$00,"7","8","9"
	dc.b	$20,$08,$09,$0d,$0d,$1b,$7f,$00,$00,$00,$00,$00,$11,$12,$13,$14
	dc.b	$f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9,$fa,$00,$00,$00,$00,$00,$10
	dc.b	$e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7,$00,$00,$00,$00,$00,$00,$00,$00
	ds.b	16
	even

* Custom Input event handler for grab keyboard/mouse event before intuition

SetIEHandler
	moveq	#0,d0
	move.l	d0,a0
	bsr	CreateStdIO
	tst.l	d0
	beq	.IEError
	move.l	d0,IEIOReq(a5)
	move.l	d0,a1
	moveq	#0,d0
	moveq	#0,d1
	lea	InputName(pc),a0
	CallSys	OpenDev
	tst.l	d0
	bmi	.IEError
	lea	IEInterrupt(a5),a2
	lea	IEServer(pc),a0
	move.l	a0,is_Code(a2)
	move.l	a5,is_Data(a2)
	move.b	#NT_INTERRUPT,is_Type(a2)
	move.b	#127,is_Pri(a2)
	move.w	#CMD_ADDINTSERVER,io_Command(a1)
	move.l	a2,io_Data(a1)
	jsr	SendIO(a6)
	tst.b	io_Error(a1)
	bne	.IEError
	move.l	IEIOReq(a5),d0
	rts

.IEError
	tst.l	IEIOReq(a5)
	beq	.End
	move.l	IEIOReq(a5),a1
	bsr	DeleteStdIO
.End	moveq	#0,d0
	rts

RemIEHandler
	tst.l	IEIOReq(a5)
	beq	.NoIO
	move.l	IEIOReq(a5),a1
	move.w	#CMD_REMINTSERVER,io_Command(a1)
	pea	IEInterrupt(a5)
	move.l	(sp)+,io_Data(a1)
	CallSys	SendIO
	jsr	CloseDev(a6)
	bsr	DeleteStdIO
.NoIO	rts

* The input.device server for RAW keys & RAW mouse events

IEServer
	cmp.b	#IE_RAWKEY,ie_Class(a0)
	beq	IEHandleKeys
	cmp.b	#IE_RAWMOUSE,ie_Class(a0)
	beq	IEHandleKeys
IERet	move.l	a0,d0
	rts

IEHandleKeys
	tst.w	IntEnabled(a1)
	bne	IERet
	move.l	ie_Next(a0),a0
	move.l	a0,d0
	bne	IEServer
	rts

* Standard Amiga_Lib functions to Create/Delete StdIO & MsgPorts!

* MsgPort=CreatePort(Name/a0, Pri/d0)

CreatePort
	movem.l	d0/a0,-(sp)
	moveq	#-1,d0
	CallSys	AllocSig
	tst.l	d0
	bpl	.sigok
.porterror
	addq.w	#4,sp
	moveq	#0,d0
	rts
.sigok	move.l	d0,d2
	moveq	#mp_SIZEOF,d0
	move.l	#$10001,d1
	bsr	MyAllocMem
	move.l	d0,a2
	tst.l	d0
	bne	.portmemok
	move.l	d2,d0
	jsr	FreeSig(a6)
	bra	.porterror
.portmemok
	movem.l	(sp)+,d0/a0
	move.b	d2,mp_SigBit(a2)
	move.b	#NT_MSGPORT,mp_Type(a2)
	move.b	d0,mp_Pri(a2)
	move.l	a0,mp_Name(a2)
	move.l	a2,a1
	jsr	AddPort(a6)
	move.l	a2,d0
	rts

* DeletePort(Port/a1)

DeletePort
	move.l	a1,d0
	beq	.noport
	move.l	a2,-(sp)
	move.l	a1,a2
	CallSys	RemPort
	moveq	#0,d0
	move.b	mp_SigBit(a2),d0
	jsr	FreeSig(a6)
	move.l	a2,a1
	bsr	MyFreeMem
	move.l	(sp)+,a2
.noport	rts

* StdIO=CreateStdIO(Name/a0, Pri/d0)

CreateStdIO
	bsr	CreatePort
	tst.l	d0
	beq	.ioerror
	move.l	d0,a3
	moveq	#io_SIZEOF,d0
	move.l	#$10001,d1
	bsr	MyAllocMem
	move.l	d0,a2
	tst.l	d0
	beq	.ionomem
	move.l	a3,io_ReplyPort(a2)
	move.l	a2,d0
.ioerror
	rts

.ionomem
	move.l	a3,a1
	bsr	DeletePort
	moveq	#0,d0
	rts

* DeleteStdIO(StdIO/a1)

DeleteStdIO
	move.l	a1,d0
	beq	.noio
	move.l	d0,a2
	move.l	io_ReplyPort(a2),a1
	bsr	DeletePort
	move.l	a2,a1
	bsr	MyFreeMem
.noio	rts

