; *** Desert Strike Hard Disk Loader
; *** Written by Jean-François Fabre (jffabre@club-internet.fr)

;                                           fastsize   fastbuff
;                                               |          |
; on A500: $200: E  T  C  !  00 00 02 08 00 17 E3 18 00 C0 04 E8
; 2MB      $210: 00 05 00 07 FB E0 00 00 04 20 00 03 00 00 00 00    
;                            |            |
;                          topchip     lowchip

; on A500: $200: E  T  C  !  00 00 02 08 00 07 E3 18 00 C0 04 E8
; 1MB      $210: 00 05 00 07 FB E0 00 00 04 20 00 03 00 00 00 00    

; on 1200: $200: E  T  C  !  00 00 02 08 00 F7 FF E0 68 00 02 00
; 68060    $210: 00 05 00 1F EF E0 00 00 10 20 07 03 00 00 00 00    


	include	"jst.i"

	HD_PARAMS	"DStrike.d",STD_DISK_SIZE,3	; JST parameters
	SET_VARZONE	startvar,endvar			; local variables

loader:
	move.l	#$80000,D0
	JSRABS	Alloc24BitMem
	RELOC_MOVEL	D0,ExtBase
	beq	MemErr

	Mac_printf	"Desert Strike HD Loader V2.1"
	Mac_printf	"Coded by Jean-Francois Fabre © 1996/1998"

	JSRABS	LoadDisks

	moveq.l	#0,D0
	move.l	#CACRF_CopyBack,D1
	JSRABS	Degrade		; Also flushes the caches

;	WAIT_LMB

	GO_SUPERVISOR
	SAVE_OSDATA	$80000
	
	MOVE	#$2700,SR		;0DA: 46FC2700

	bsr	InstallBoot

	bsr	MemoryConfig

	JSRGEN	FlushCachesHard
	JMP	$5800E

	nop
	nop
	nop
	nop

JsrIntro2:
;	move.l	ExtBase(pc),$210E.W

	move.l	$210E.W,A0
	add.l	#$1C566,A0
	cmp.l	#$48E77FFC,(A0)
	bne	exit$

	; *** rob loader

	PATCHUSRJMP	(A0),ReadSectors

	; *** store extbase

	RELOC_MOVEL	$210E.W,ExtBase

	; *** intercept copper pointer pokes

	STORE_REGS
	move.l	$210E.W,A0
	lea	($67C0,A0),A0
	move.l	$210E.W,A1
	add.l	#$1D000,A1
	move.l	#$F,D1
	JSRGEN	PatchMoveCList_Ind
	RESTORE_REGS

	; *** remove trap handler

	move.l	$210E.W,A0		; ExtBase, actually
	add.l	#$1B2A4,A0
	move.w	#$4E75,(A0)

	; *** 2nd button check

	move.l	$210E.W,A0
	add.l	#$99A2,A0
	move.w	#$4E71,(A0)+
	PATCHUSRJSR	(A0),Check2ndButton

	; *** 2nd button detect in VBLANK interrupt

	move.l	$210E.W,A0
	add.l	#$A9C,A0
	move.w	#$4E71,(A0)+
	PATCHUSRJSR	(A0),Read2ndButton

	; *** keyboard interrupt

	move.l	$210E.W,A0
	PATCHUSRJSR	(A0,$976),KbInt_1


	; *** decrunch in fastmem

	move.l	$210E.W,A0
	add.l	#$1CAD2,A0
	PATCHGENJMP	(A0),RNCDecrunch

	; *** patch another loader

	move.l	$210E.W,A0
	add.l	#$1BC38,A0	
	PATCHUSRJSR	(A0),JsrLoader3

	; *** patch set disk

	move.l	$210E.W,A0
	add.l	#$1C2CA,A0
	PATCHUSRJMP	(A0),SetDisk

	; *** drive light

	move.l	$210E.W,A0
	add.l	#$1C10C,A0
	move.w	#$4E75,(A0)

exit$

	; *** flush and run

	JSRGEN	FlushCachesHard
	move.l	$210E.W,A0
	nop
	nop
	rts
	nop
	nop

JsrLoader3:

	; contenu de $1BCEA+ExtBase

	cmp.l	#$48E77FFC,$3AF4.W
	bne	patch2$

	; *** rob read

	PATCHUSRJMP	$3AF4.W,ReadSectors	; rob read

	; *** decrunch

	PATCHGENJMP	$4060.W,RNCDecrunch	; decrunch

	; *** no LED

	move.l	#$4E714E71,$33C0.W		; led off
	move.w	#$4E75,$369A.W			; led off
	bra	go$

patch2$
	cmp.l	#$13C00000,$F92.W
	bne	patch3$
	PATCHUSRJSR	$F92.W,KbInt_2		; keyboard menu
	bra	go$

patch3$
	cmp.l	#$48E7FFFE,$1A170
	bne	patch4$

	PATCHUSRJMP	$1A170,SetDisk		; set proper disk
	PATCHUSRJMP	$1A40C,ReadSectors	; rob read
	move.w	#$4E75,$19FB2			; led off
	bra	go$

patch4$
go$
	JSRGEN	FlushCachesHard

	; bugfix (A0 was fixed at $200)

	move.l	ExtBase(pc),A0
	add.l	#$1BCEA,A0
	move.l	(A0),A0

	rts


Read2ndButton:
	move.l	D0,-(A7)
	RELOC_CLRL	Fire2Pressed

	move.w	$DFF016,D0
	btst	#14,D0
	bne	exit$
	RELOC_STL	Fire2Pressed
	move.w	#$CC01,$DFF034
exit$
	move.l	(a7)+,D0
	move.w	#$70,$DFF000+intreq
	rts

Check2ndButton:
	movem.l	D0/A0,-(sp)

	move.l	ExtBase(pc),A0
	add.l	#$186D6,A0

	RELOC_TSTL	Fire2Pressed
	beq	nob2$

	bset.b	#7,(A0)		; simulate space pressed
nob2$
	btst.b	#7,(A0)		; original code
	movem.l	(sp)+,D0/A0
	rts

JsrIntro:
	JSRGEN	FlushCachesHard
	move.l	IntroAddr(pc),-(A7)
	rts

KbInt_2:
	move.b	D0,($FD6).W
	cmp.b	#$54,D0
	bne	noquit$
	JSRGEN	InGameExit
noquit$
	rts

KbInt_1:
	lea	$BFE001,A0
	move.l	D0,-(a7)
	move.b	(A0,$C00),D0
	ror.b	#1,D0
	not.b	D0
	cmp.b	#$54,D0
	bne	noquit$
	JSRGEN	InGameExit
noquit$
	cmp.b	#$42,D0
	bne	noicon$
	JSRGEN	InGameIconify
	STORE_REGS
	move.l	ExtBase(pc),A0
	JSR	$74E6(A0)		; restart chopper noise
	RESTORE_REGS
noicon$
	move.l	(a7)+,D0
	rts

Patch800:
	lea	$2714.W,A7
	move	#$2700,SR
	move.w	#$1FF,dmacon+$DFF000

	RELOC_MOVEL	$86A.W,IntroAddr
	PATCHUSRJMP	$12D4.W,ReadSectors
	PATCHUSRJMP	$1840.W,Decrunch
	PATCHUSRJSR	$868.W,JsrIntro
	PATCHUSRJSR	$205C.W,JsrIntro2
	JSRGEN	GoECS
	JSRGEN	FlushCachesHard
	nop
	nop
	jmp	$840.W


MemoryConfig:
	lea	$200.W,A1
	move.l	#'ETC!',(A1)+		; $200
	move.l	#$208,(A1)+		; $204
	move.l	#$80000,(A1)+		; $208 fastsize
	move.l	ExtBase(pc),(a1)+	; $20C fastbuf
	move.w	#$5,(A1)+		; $20E
	move.l	#$0007FBE0,(A1)+	; $210 topchip (512K)
	move.l	#$420,(A1)+		; $214 lowchip
	move.w	#$300,(A1)+		; $218 ??
	clr.l	(A1)+			; $21C
	rts

InstallBoot:
	JSRGEN	InitTrackDisk
	MOVEQ	#0,D7		
	move.l	#$10400,D0
	MOVE.L	D0,D3		
	MOVE.L	D0,40(A1)	
	MOVE.L	#$00000200,36(A1)
	MOVE.L	#$00000400,44(A1)
	MOVE	#$0002,28(A1)
	JSRGEN	TrackLoad

	MOVEA.L	D3,A0			;062: 2043
	MOVE.L	4(A0,D7.W),D0		;064: 20307004
	ADDI.L	#$000003FF,D0		;068: 0680000003FF
	ANDI.L	#$FFFFFE00,D0		;06E: 0280FFFFFE00
	MOVE.L	D0,D5			;074: 2A00
	SUBI.L	#$00000200,D5		;076: 048500000200

	MOVEA.L	D3,A0			;090: 2043
	MOVE.L	#$00058000,40(A1)	;094: 237C000580000028
	MOVE.L	D5,36(A1)		;09C: 23450024
	MOVE.L	0(A0,D7.W),44(A1)	;0A0: 23707000002C
	MOVE	#$0002,28(A1)		;0A6: 337C0002001C
	JSRGEN	TrackLoad

	MOVEA.L	D3,A1			;0E6: 2243
	CLR.L	(A1)+			;106: 4299

	MOVEA.L	D3,A2			;126: 2443
	LEA	$200.W,A6		;128: 4DF900000200
	MOVE.L	#$45544321,0(A6)	;12E: 2D7C455443210000
	LEA	8(A6),A4		;136: 49EE0008
	MOVE.L	A4,4(A6)		;13A: 2D4C0004
LAB_0005:
	MOVE.L	(A2)+,(A4)+		;13E: 28DA
	BEQ.S	LAB_0006		;140: 6706
	MOVE.L	(A2)+,(A4)+		;142: 28DA
	MOVE	(A2)+,(A4)+		;144: 38DA
	BRA.S	LAB_0005		;146: 60F6
LAB_0006:

	lea	$58000,A0
	PATCHUSRJMP	($BFE,A0),ReadSectors
	PATCHUSRJMP	($1A2,A0),Patch800
	PATCHGENJMP	($116A,A0),RNCDecrunch
	move.w	#$4E75,($962,A0)		; remove insert disk 1

	rts

; ReadSectors (Rob Northen)

ReadSectors:
	STORE_REGS
	move.w	currdisk(PC),D0
	and.w	#3,D0

	JSRGEN	ReadRobSectors
	
	RESTORE_REGS
	rts


Decrunch:
	JSRGEN	RNCDecrunch
	JSRGEN	FlushCachesHard
	rts

PatchBoot:
	STORE_REGS
	moveq.l	#0,D0
	JSRGEN	GetDiskPointer		; 1st disk
	move.l	D0,A0

	; *** Patch so it's compatible with another version

	move.l	A0,A2
	add.l	#$6E014,A2
	move.l	#$9223455a,(A2)

	move.l	A0,A2
	add.l	#$6E1A4,A2

	move.l	#$1608,(A2)+
	move.l	#$4a9,(A2)+
	move.l	#$5d,(A2)+

	move.l	A0,A2
	add.l	#$6E1C4,A2

	move.l	#$31652044,(A2)+
	move.l	#$69736b20,(A2)+
	move.l	#$31000000,(A2)+

	move.l	A0,A2
	add.l	#$6E1E4,A2

	move.l	#$1608,(A2)+
	move.l	#$4a9,(A2)+
	move.l	#$5d,(A2)+

	RESTORE_REGS
	rts

SetDisk:
	and.w	#15,D0
	RELOC_MOVEW	D0,currdisk
	rts

MemErr:
	Mac_printf	"** Not enough memory!!"
	JMPABS	CloseAll

startvar:

ExtBase:
	dc.l	0
IntroAddr:
	dc.l	0
Fire2Pressed:
	dc.l	0
currdisk:
	dc.w	0
endvar:
