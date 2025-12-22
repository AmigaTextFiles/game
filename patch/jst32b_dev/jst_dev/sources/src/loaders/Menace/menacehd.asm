; *** Written by Jean-François Fabre

DISK_SIZE = 979600

HDLOAD = 1
;PATCH_LOGGED = 1

	include	"jst.i"

	HD_PARAMS	"menace.d",DISK_SIZE,1

BUILD_BLITWAIT_REG:MACRO
WaitBlit\1A6:
	move.w	\1,($58,A6)
	WAIT_BLIT
	rts
	ENDM
	
loader:
	RELOC_MOVEL	D0,trainer
	RELOC_MOVEL	D4,buttonwait

	move.l	#20000,D0
	JSRABS	AllocExtMem
	tst.l	D0
	beq	MemErr
	add.l	#15000,D0
	RELOC_MOVEL	D0,StackZone

	Mac_printf	"Menace HD Loader & fix v1.2"
	Mac_printf	"Coded by Jean-François Fabre © 1998-1999"

	RELOC_TSTL	trainer
	beq	skip$

;	NEWLINE
;	Mac_printf	"Trainer activated"
skip$
	bsr	ReadScores
	JSRABS	LoadDisks

	moveq.l	#0,D0
	move.l	#CACRF_CopyBack,D1
	JSRABS	Degrade

	GO_SUPERVISOR
	SAVE_OSDATA	$80000

	JSRGEN	FreezeAll
	move	#$2700,SR

	bsr	InstallBoot

	; *** boot stuff and patch

	JSRGEN	FlushCachesHard

	jmp	$2000C

ReplaceBlitsAndCop:

	; blitter fixes

	PATCHUSRJMP	$CC.W,WaitBlitD3A6
	PATCHUSRJMP	$D2.W,WaitBlitD1A6
	PATCHUSRJMP	$D8.W,WaitBlitD0A6
	PATCHUSRJMP	$DE.W,StoreCopperPtr

	; insert blitter waits

	move.l	#$3D430058,D0
	move.l	#$4EB800CC,D1
	lea	$70000,A0
	lea	$74000,A1
	JSRGEN	HexReplaceLong

	move.l	#$3D410058,D0
	move.l	#$4EB800D2,D1
	lea	$70000,A0
	lea	$74000,A1
	JSRGEN	HexReplaceLong

	; ingame iconify

	move.l	#$2D480080,D0
	move.l	#$4EB800DE,D1
	lea	$6FA00,A0
	lea	$73500,A1
	JSRGEN	HexReplaceLong

	; blitter waits (2)

	lea	$70000,A0
	lea	$74000,A1
	moveq	#6,D0		; ($58,A6)
	move.l	#14,D1		; trap #$E (total random)
	JSRGEN	PatchMoveBlit_Idx
	rts

PatchMain:
	cmp.l	#$08B90002,$72B74
	beq	PatchMain_1
	cmp.l	#$08B90002,$72BAA
	beq	PatchMain_2
	lea	VerErr(pc),A0
	JSRGEN	SetExitRoutine
	JSRGEN	InGameExit
	bra	PatchMain

PatchMain_1
	STORE_REGS

	move.l	#$25000,$72EC0

	; ooops, forgot a BRA

	REGISTER_PATCH	$6F9EC,#8
	move.w	#$601A,$6F9EC

	; remove reloc stack at $7FFFE

	REGISTER_PATCH	$6FA28,#8
	move.w	#$6004,$6FA28

	; remove disk stuff

	PATCH_RTS	$72DBC
	PATCH_RTS	$72E0C
	PATCH_RTS	$72E28

	; hiscores read

	PATCHUSRJMP	$72AAC,ReadTracks3

	; disk loading 2

	PATCHUSRJMP	$72B74,ReadTracks2

	; hiscores write

	PATCHUSRJMP	$72BC4,HiSave

	; remove caches off

	REGISTER_PATCH	$72A86,#8
	move.w	#$6020,$72A86

	; keyboard int

	PATCHUSRJMP	$7167A,KbInt

	; keyboard delay fixed

	PATCHUSRJSR	$71664,KbDelay

	; remove original blitter wait

	PATCH_RTS	$73304

	bsr	ReplaceBlitsAndCop

	REGISTER_PATCH	$715B6,#4
	REGISTER_PATCH	$715C6,#4
	move.l	#$4EB800D8,$715B6
	move.l	#$4EB800D8,$715C6

	RESTORE_REGS
	rts

PatchMain_2:
	STORE_REGS

	; believe it or not, the game reads the ROM
	; to get a pseudo-random pattern for the stars
	; in the intro sequence! With $25000 it works
	; rather fine too.

	move.l	#$25000,$72EF6

	; ooops, forgot a BRA

	REGISTER_PATCH	$6F9EC,#8
	move.w	#$601A,$6F9EC

	; blitter waits and copper store

	bsr	ReplaceBlitsAndCop

	; remove reloc stack at $7FFFE

	REGISTER_PATCH	$6FA28,#8
	move.w	#$6004,$6FA28

	; remove disk stuff

	PATCH_RTS	$72DF2
	PATCH_RTS	$72E42
	PATCH_RTS	$72E5E

	; hiscores read

	PATCHUSRJMP	$72ABE,ReadTracks3

	; disk loading 2

	PATCHUSRJMP	$72BAA,ReadTracks2

	; hiscores write

	PATCHUSRJMP	$72BFA,HiSave

	; remove caches off

	REGISTER_PATCH	$72B84,#8
	move.w	#$6020,$72B84

	; keyboard int

	PATCHUSRJMP	$71724,KbInt

	; keyboard delay fixed

	PATCHUSRJSR	$7170E,KbDelay

	; remove original blitter wait

	PATCH_RTS	$7333A

	; some other ones

	REGISTER_PATCH	$715B6,#4
	REGISTER_PATCH	$715C6,#4
	move.l	#$4EB800D8,$715B6
	move.l	#$4EB800D8,$715C6

	RESTORE_REGS
	rts

Jump1B0:
	bsr	PatchMain
	JSRGEN	FlushCachesHard
	lea	$8494,A4
	move.l	(A7)+,A5

	move.l	StackZone(pc),A7

	nop
	nop
	jsr	(A5)
	nop
	nop

	; *** relocate stack

	move.l	StackZone(pc),A7

;	lea	$7FFFE,A7	; original $7FFFF
	JSRGEN	FlushCachesHard
	jmp	$50370

Jump18E:
	PATCHUSRJMP	$71C4.W,ReadTracks

	REGISTER_PATCH $733E,#2
	REGISTER_PATCH $72F4,#2

	move.w	#$4E75,$733E.W	; disk stuff
	move.w	#$4E75,$72F4.W	; disk stuff

	GETUSRADDR	side_flag

	REGISTER_PATCH $70CC,#4
	move.l	D0,$70CC.W

	REGISTER_PATCH $7116,#4
	move.l	D0,$7116.W

	REGISTER_PATCH $714C,#4
	move.l	D0,$714C.W

	REGISTER_PATCH $719C,#4
	move.l	D0,$719C.W

	JSRGEN	FlushCachesHard
	nop
	nop
	jmp	$708E.W
	nop
	nop


Jump140:
	PATCHUSRJMP	$18E.W,Jump18E
	PATCHUSRJMP	$1B0.W,Jump1B0
	JSRGEN	FlushCachesHard
	nop
	nop
	jmp	$140.W
	nop
	nop

	BUILD_BLITWAIT_REG	D0
	BUILD_BLITWAIT_REG	D1
	BUILD_BLITWAIT_REG	D3

StoreCopperPtr:
	move.l	D0,-(A7)
	move.l	A0,D0
	JSRGEN_FREEZE	StoreCopperPointer
	move.l	A0,($80,A6)			; original game
	move.l	(A7)+,D0
	rts

KbInt:
	cmp.b	#$5F,D0
	bne	noquit$
	JSRGEN_FREEZE	InGameExit
noquit$
	cmp.b	#$42,D0
	bne	noicon$
	JSRGEN_FREEZE	InGameIconify
noicon$
	movem.l	(A7)+,D0-D1/A5-A6
	rte

KbDelay:
	BEAM_DELAY	#2
	rts

ReadTracks3:
	movem.l	D0-D6/A1-A6,-(sp)
	bcc.b	nos1$		; one of input params is C flag of CCR !

	add.l	#78,D0		; side 1
nos1$
	clr.b	($1F,A5)

	RELOC_TSTL	buttonwait
	beq	skbw$
bw$
	btst	#7,$BFE001
	bne	bw$
skbw$

	lea	hiscbuff(pc),A2
	cmp.l	#'FUCK',(A2)
	beq	RT_Common	; read hiscores from disk image if none

	; xfer the hiscores to memory

	move.w	#$13F,D0
copy$
	move.b	(A2)+,(A0)+
	dbf	D0,copy$

	movem.l	(sp)+,D0-D6/A1-A6
	rts


ReadTracks2:
	movem.l	D0-D6/A1-A6,-(sp)
	bcc.b	nos1$		; one of input params is C flag of CCR !

	add.l	#78,D0		; side 1
nos1$
	bra	RT_Common

ReadTracks:
	movem.l	D0-D6/A1-A6,-(sp)

	move.b	side_flag(pc),D3
	btst	#2,D3
	beq	nos1$

	add.l	#78,D0		; side 1

nos1$

	addq.l	#1,D1		; first load uses D1+1

RT_Common
	and.l	#$FFFF,D0
	and.l	#$FFFF,D1

	move.w	D0,D3		; save D0 in D3
	move.l	A0,A1		; save A0 in A1

	mulu	#$1838,D0
	mulu	#$1838,D1	; length
	move.l	D0,D2		; offset
	moveq	#0,D0

	; got to read the disk (JST call) with interrupts off
	; because the game accesses A5 during interrupts

	JSRGEN_FREEZE	ReadDiskPart

	add.l	D1,A0		; A0 increase

	movem.l	(sp)+,D0-D6/A1-A6

	add.w	D1,D0

	move.l	#$FFFF,D1
	rts
	
HiSave:
	STORE_REGS

	lea	hiscbuff(pc),A1

	move.w	#$13F,D0
copy$
	move.b	(A0)+,(A1)+
	dbf	D0,copy$

	lea	WriteScores(pc),A0
	JSRGEN	SetExitRoutine

	RESTORE_REGS
	rts


ReadBoot:
	lea	boot(pc),A0
	lea	$400(A0),A0
	lea	$10000,A5
	move.l	A5,A1
	MOVE.W	#$2FF,D0
copy$
	MOVE.L	(A0)+,(A1)+
	DBF	D0,copy$
	JSRGEN	FlushCachesHard
	JMP	$20046
	
InstallBoot:
	lea	boot(pc),A0
	lea	$20000,A1
	MOVE.W	#$FF,D0
copy$
	MOVE.L	(A0)+,(A1)+
	DBF	D0,copy$

	PATCHUSRJMP	$2000E,ReadBoot
	PATCHUSRJMP	$200A6,Jump140
	rts


WriteScores:
	lea	hiscname(pc),A0
	lea	hiscbuff(pc),A1
	moveq	#0,D0
	move.l	#$140,D1
	JSRGEN	WriteUserFileHD
	tst.l	D0
	beq	ok$
	Mac_printf	"** Unable to save hiscores. Hit RETURN"
	JSRABS	WaitReturn
ok$
	rts

ReadScores:
	lea	hiscname(pc),A0
	lea	hiscbuff(pc),A1
	moveq	#0,D0
	move.l	#$140,D1
	JSRGEN	ReadUserFileHD
	tst.l	D0
	beq	ok$
	Mac_printf	"** Unable to read hiscores."
ok$
	rts


MemErr:
	Mac_printf	"** Not enough memory!"
	JSRABS	CloseAll

VerErr:
	Mac_printf	"** Unsupported version. Hit return"
	JSRABS	WaitReturn
	rts

StackZone:
	dc.l	0

trainer:
	dc.l	0
buttonwait:
	dc.l	0

side_flag:
	dc.l	0

hiscname:
	dc.b	"menace.hsc",0
	cnop	0,4

hiscbuff:
	dc.b	"FUCK"
	blk.b	$140,0
boot:
	incbin	"menace.boot"
