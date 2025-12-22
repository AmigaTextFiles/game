; in V3 $76162.W could be set to $8000 if any protection problem occurs

	include	"jst.i"


	HD_PARAMS	"lotus.d",958464,1

HDLOAD = 1

BUILD_MOVEW_REG:MACRO
movw\1_\2:
	move.w	\1,$\2
	JSRGEN_FREEZE	FlushCachesHard
	rts
	ENDM

BUILD_MOVEB_REG:MACRO
movb\1_\2:
	move.b	\1,$\2
	JSRGEN_FREEZE	FlushCachesHard
	rts
	ENDM

loader:
	move.l	#$2000,D0
	JSRABS	Alloc24BitMem
	RELOC_MOVEL	D0,StackBase
	beq	MemErr

	Mac_printf	"Lotus HD Loader & Fix (3 versions) V1.1"
	Mac_printf	"Coded by JF Fabre © 1997-1998"
	JSRABS	LoadDisks

	bsr	ReadBoot

	bsr	CheckVersion

	moveq.l	#0,D0
	move.l	#CACRF_CopyBack,D1
	JSRABS	Degrade

;	WAIT_LMB

	GO_SUPERVISOR
	SAVE_OSDATA	$80000
	
	bsr	InstallBoot

	JSRGEN	FreezeAll

	move.l	StackBase(pc),A7
	lea	($1C00,A7),A7

	JSRGEN	FlushCachesHard
	move.l	version(pc),D0
	cmp.l	#2,D0
	beq	jmpv2$
	cmp.l	#3,D0
	beq	jmpv3$
	JMP	$70024
jmpv3$
	jmp	$1010.W
jmpv2$
	JMP	$A1C.W

SetInt03:
	STORE_REGS

	move.w	#$40,intreq+$DFF000	; clear blitter interrupt
	lea	NewInt03(pc),A0
	move.l	A0,($6C).W

	move.l	NoIconify(pc),D0
	bne	skip$			; already set
	move	SR,-(A7)
	move	#$2700,SR		; freeze!!
	RELOC_STL	NoIconify
	move	(A7)+,SR
skip$

	RESTORE_REGS
	rts

NewInt03:
	btst	#6,dmaconr+$DFF000	; blitter finished?
	bne.b	retry$			; no? just retry next time

	move.l	$D0.W,-(A7)		; jump to next blit routine
	rts

retry$
	move.w	#$8040,intreq+$DFF000	; sets blitter interrupt
	rte

PatchProg_V3:
	; *** protection

	move.w	#$4E75,$72B92	; seems to be a disk protection

	; *** some in game checks for the protection

	move.w	#$4E75,$72C2A
	move.l	#$4E714E71,$73D70
	move.w	#$4E75,$74748

	PATCHGENJMP	$747A6,InGameExit	; just in case...

	; *** keyboard

	PATCHUSRJSR	$72C52,KbInt_V3	; quit key
	move.w	#$676A,$72C46		; correct acknowledge

	; *** self modifying code remove (prefetch problems)

	PATCHUSRJSR	$7888E,movwd5_788D6
	PATCHUSRJSR	$78AFC,movwd0_78B06
	PATCHUSRJSR	$78C22,movwd0_78C4A
	PATCHUSRJSR	$788CE,movbd3_78915
	PATCHUSRJSR	$78E94,movwd6_78ED8

	; *** blitter stuff (tricky)

	bsr	PatchBlit
	PATCHUSRJSR	$7879C,SetInt03		; don't move this line above
						; the PatchBlit call
	
	; *** dbf delays

	bsr	PatchDbfs

	; *** copper/iconify stuff

	bsr	PatchCopper

	JSRGEN	FlushCachesHard
	nop
	nop
	rts
	nop
	nop
	nop

PatchCopper:
	STORE_REGS
	lea	$72000,A0
	lea	$78000,A1
	move.l	#6,D0
	move.l	#$F,D1
	JSRGEN	PatchMoveCList_Idx

	PATCHUSRJMP	$DC.W,StoreCopperPtr
	move.l	#$2D480080,D0
	move.l	#$4EB800DC,D1
	JSRGEN	HexReplaceLong
	RESTORE_REGS
	rts

StoreCopperPtr:
	move.l	D0,-(A7)
	move.l	A0,D0
	JSRGEN_FREEZE	StoreCopperPointer
	move.l	A0,($80,A6)			; original game
	move.l	(A7)+,D0
	rts

PatchDbfs:
	rts

	PATCHUSRJMP	$D6.W,DbfDelay
	move.l	#$51C8FFFE,D0
	move.l	#$4EB800D6,D1
	lea	$72000,A0
	lea	$79000,A1
	JSRGEN	HexReplaceLong
	rts

DbfDelay:
	divu.w	#$28,D0
	swap	D0
	clr.w	D0
	swap	D0
	BEAM_DELAY	D0
	rts

PatchBlit:
	STORE_REGS

	; search for the blitter interrupt clear/ $6C vector change
	; (just before the blit)

	move.l	#$006C3D7C,D0
	move.l	#$0040009C,D1
	lea	$78000,A0
	lea	$7B000,A1

loop$
	addq	#2,A0
	move.l	(A0),D2
	cmp.l	D0,D2
	beq.b	found1$
	cmp.l	A0,A1
	bcs.b	exit$
	bra.b	loop$
found1$
	move.l	4(A0),D2
	cmp.l	D1,D2
	beq.b	found2$
	cmp.l	A0,A1
	bcs.b	exit$
	bra.b	loop$

found2$
	move.w	#$D0,(A0)	; replace $6C by $D0
;	move.w	#$4E71,(2,A0)
;	move.l	#$4E714E71,(4,A0)
	bra.b	loop$

exit$
	RESTORE_REGS
	rts


KbInt_V3:
	move.b	D0,$7D7AE

KbInt_Common:
	move.l	D1,-(A7)

	cmp.b	#$5F,D0		; Help quits
	bne	noquit$
	JSRGEN_FREEZE	InGameExit
noquit$
	move.l	NoIconify(pc),D1
	bne	noicon$		; no iconify during races

	cmp.b	#$42,D0		; TAB iconifies
	bne	noicon$
	JSRGEN_FREEZE	InGameIconify
noicon$

	move.l	(A7)+,D1
	rts

InstallBoot:
	move.l	version(pc),D0
	cmp.l	#2,D0
	beq	InstallBoot_V2
	cmp.l	#3,D0
	beq	InstallBoot_V3

InstallBoot_V1:

	; ** install program in $400

	lea	boot(pc),A0
	lea	$400(A0),A0
	lea	$400.W,A1

	move.w	#$3FF,D0
copy$
	move.l	(A0)+,(A1)+
	dbf	D0,copy$

	; ** install program in $70000

	lea	boot(pc),A0
	lea	$66(A0),A0
	lea	$70000,A1

	move.w	#$3FF,D0
copy2$
	move.l	(A0)+,(A1)+	; strange to copy $1000 bytes as
	dbf	D0,copy2$	; only $400 bytes are read.

	PATCHUSRJMP	$5B0.W,ReadDisk_V1
	move.w	#$4E75,$4FA.W
	move.w	#$4E75,$4CC.W
	move.w	#$4E75,$536.W

	PATCHUSRJMP	$700EA,PatchProg_V1
	rts


InstallBoot_V2:
	lea	boot(pc),A0
	lea	$400(A0),A0
	lea	$A00.W,A1	; install in $A00

	move.w	#$3FF,D0
copy$
	move.l	(A0)+,(A1)+
	dbf	D0,copy$

	move.w	#$4E75,$E0E.W
	move.w	#$4E75,$AD6.W
	move.w	#$4E75,$AFE.W
	move.w	#$4E75,$B2E.W
	move.w	#$4E75,$16BC.W

	PATCHUSRJMP	$BDE.W,ReadDisk_V2
	
	rts

InstallBoot_V3:
	LEA	boot(PC),A0
	lea	($4A,A0),A0

	LEA	$40000,A1
	LEA	$1000.W,A3
	MOVEA.L	A1,A2
	MOVE	#$00FF,D7
	MOVE	D7,D6

LAB_0002:
	MOVE.L	(A0)+,(A1)+
	DBF	D7,LAB_0002	; install in $40000

	PATCHUSRJMP	$40110,ReadDisk_V3
	move.w	#$4E75,$400A4
	move.w	#$4E75,$4007C
	move.w	#$4E75,$400D0
	move.w	#$4E75,$4017C
;	move.w	#$600A,$40038

LAB_0003:
	MOVE.L	(A2)+,(A3)+
	DBF	D6,LAB_0003	; install in $1000


	rts

ReadDisk_V3:
	movem.l	D1-D6/A0-A6,-(sp)

	bsr	NibRead
	
	movem.l	(sp)+,D1-D6/A0-A6
	moveq	#0,D0

	cmp.l	#$72000,(sp)
	beq	PatchProg_V3
	rts

ReadDisk_V1:
	movem.l	D1-D6/A0-A6,-(sp)

	bsr	NibRead
	
	movem.l	(sp)+,D1-D6/A0-A6
	moveq	#0,D0

	rts

ReadDisk_V2:
	movem.l	D1-D6/A0-A6,-(sp)

	bsr	NibRead
	
	movem.l	(sp)+,D1-D6/A0-A6
	moveq	#0,D0

	cmp.l	#$72300,(A7)
	beq	PatchProg_V2

	rts

PatchProg_V2:
	STORE_REGS

	bsr	PatchProgCommon

	; *** reset sprites, flush caches

	JSRGEN	FlushCachesHard

	RESTORE_REGS

	rts	; jmp $72300


PatchProg_V1:
	; *** finish code

	lea	$72308,A0
	JSR	$408.W

	STORE_REGS

	bsr	PatchProgCommon

	; *** reset sprites, flush caches

	JSRGEN	FlushCachesHard

	RESTORE_REGS

	JMP	$72308


PatchProgCommon:
	; *** kb int

	PATCHUSRJSR	$72EFE,KbInt_V12
;;;;;	move.w	#$4E71,$72F62		; allows kb reset

	; *** prefetch remove

	PATCHUSRJSR	$78802,movwd5_7884A
	PATCHUSRJSR	$78A70,movwd0_78A7A
	PATCHUSRJSR	$78B96,movwd0_78BBE
	PATCHUSRJSR	$78842,movbd3_78889
	PATCHUSRJSR	$78ED8,movwd6_78E4C

	; *** blitter stuff (tricky)

	bsr	PatchBlit
	PATCHUSRJSR	$78710,SetInt03		; don't move this line above

	; *** dbf delays

	bsr	PatchDbfs

	; *** copper/iconify stuff

	bsr	PatchCopper

	RTS

	; v1 and v2

	BUILD_MOVEW_REG	d5,7884A
	BUILD_MOVEW_REG	d0,78A7A
	BUILD_MOVEW_REG	d0,78BBE
	BUILD_MOVEW_REG	d6,78E4C
	BUILD_MOVEB_REG	d3,78889

	; v3 (old version from Harry)

	BUILD_MOVEW_REG	d5,788D6
	BUILD_MOVEW_REG	d0,78B06
	BUILD_MOVEW_REG	d0,78C4A
	BUILD_MOVEW_REG	d6,78ED8
	BUILD_MOVEB_REG	d3,78915

; Routine patchant la lecture

; D1: Longueur en octets
; D0: Offset en octets (-$3000)
; A0: Buffer

NibRead:
	RELOC_CLRL	NoIconify

skip$
	sub.l	#$3000,D0		; Substract the 2 track offset

	move.l	D1,D7			; length read, returned in D7
	beq	ReadNothing

	; Calcul de l'offset fichier

	move.l	D0,D2
	moveq.l	#0,D0
	JSRGEN	ReadDiskPart

ReadNothing:
	rts

KbInt_V12:
	move.b	D0,$7D868
	bra	KbInt_Common

ReadBoot:
	lea	bootname(pc),A0
	lea	boot(pc),A1
	moveq	#0,D0
	move.l	#$1200,D1
	JSRGEN	ReadFileHD
	tst.l	D0
	bne	BootErr
	RTS



CheckVersion:
	moveq	#0,d0
	moveq.l	#4,D2
	moveq.l	#4,D1
	lea	verbuff(pc),A0
	JSRGEN	ReadDiskPart
	move.l	(A0),D0

	cmp.l	#$B322C,D0
	bne	notv1$		; the patched ver
	RELOC_MOVEL	#1,version
	rts
notv1$
	cmp.l	#$B3268,D0
	bne	notv2$		; the version from CD32 rip
	RELOC_MOVEL	#2,version
	rts
notv2$
	cmp.l	#$B3774,D0
	bne	notv3$		; the version from Harry
	RELOC_MOVEL	#3,version
	rts

notv3$
	Mac_printf	"** Unknown version. Contact author."
	JMPABS	CloseAll

BootErr:
	Mac_printf	"** File ''lotus.b1'' not found!"
	JMPABS	CloseAll

MemErr:
	Mac_printf	"** Low memory. Can't run!"
	JMPABS	CloseAll

verbuff:
	dc.l	0

version:	
	dc.l	0

StackBase:
	dc.l	0

NoIconify
	dc.l	0

boot:
	blk.b	$1200,0
	even

bootname:
	dc.b	"lotus.b1",0
	cnop	0,4

