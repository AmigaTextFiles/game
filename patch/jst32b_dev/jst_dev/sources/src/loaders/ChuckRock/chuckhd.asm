; *** Chuck Rock Hard Disk Loader V1.0
; *** Written by Jean-François Fabre

	include	"jst.i"


	HD_PARAMS	"ChuckRock.d",STD_DISK_SIZE,2

loader:
	Mac_printf	"Chuck Rock Floppy/CD32 HD Loader V1.1a"
	Mac_printf	"Coded by Jean-François Fabre © 1997"

	JSRABS	LoadDisks

	moveq.l	#0,D0
	move.l	#-1,D1
	JSRABS	Degrade

	GO_SUPERVISOR
	SAVE_OSDATA	$80000

	lea	$80000,A7
	lea	$10000,A3
	move.w	#$7FFF,dmacon+$DFF000

	; **** boot stuff and patch

	JSRGEN	InitTrackDisk

	MOVE.L	A3,40(A1)		;2C: 234B0028
	MOVE.L	#$00002800,36(A1)	;30: 237C000028000024
	MOVE.L	#$0009D200,44(A1)	;38: 237C0009D200002C
	MOVE	#$0002,28(A1)		;40: 337C0002001C
	JSRGEN	TrackLoad

	PATCHUSRJMP	$11E14,ReadSectors	; load
	move.l	#$6000092A,$11474		; remove prot
	PATCHUSRJMP	$11DC2,PatchLoader1

	MOVEA.L	$8.W,A5

	JMP	$1E(A3)


ReadSectors:
	move.l	currdisk(pc),D0
	JSRGEN	ReadRobSectors
	tst.l	D0
	rts


PatchLoader1:
	JSRGEN	GoECS

	; ** patch rob load #2

	PATCHUSRJMP	$29A0,ReadSectors
	PATCHUSRJMP	$613EE,ReadSectors

	; ** restore the protection

	move.l	#$487A000A,$2000.W

	; ** patch next load

	PATCHUSRJMP	$613A0,PatchLoader2

	JSRGEN	FlushCachesHard
	JMP	$60000

PatchLoader2:
	PATCHUSRJSR	$9670,kbint
	PATCHUSRJSR	$159A4,DiskChange
	PATCHUSRJSR	$14C40,EmuSpace
	move.w	#$4E71,$14C46
	PATCHUSRJSR	$14C64,EmuSpace
	move.w	#$4E71,$14C6A

	; ** disk load

	PATCHUSRJMP	$16488,ReadSectors

	; ** remove another fucking protection

	move.l	#$6000093A,$15ADC

	; ** and go

	JSRGEN	FlushCachesHard
	jmp	$1000.W

DiskChange:
	move.l	A0,-(sp)
	lea	currdisk(pc),A0
	move.l	#1,(a0)
	move.l	(sp)+,A0
	JMP	$1644A		; load track

kbint:
	move.b	D0,$964D
	cmp.b	#$59,D0
	bne	noquit$
	JSRGEN	InGameExit
noquit$
	rts

EmuSpace:
	btst	#6,$BFE001
	beq	quit$

	cmp.w	#$40,($964C)
	beq	exit$

	movem.l	D0/A0,-(sp)
	move.w	#$CC01,$DFF034
	moveq.l	#3,D0
	JSRGEN	BeamDelay
	move.w	$DFF016,D0
	move.w	#$CC01,$DFF034
	btst	#14,D0
	movem.l	(sp)+,D0/A0
exit$
	rts

quit$
	JSRGEN	InGameExit
	bra	quit$



currdisk:
	dc.l	0
