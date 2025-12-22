
; *** Shadow Of The Beast 3 Hard Disk Loader V1.1a
; *** Written by Jean-François Fabre

	include	"jst.i"

	HD_PARAMS	"",0,0

COMM_NONE = 0
COMM_PAUSE = 1
COMM_RESTART = 3


_loader:
	RELOC_MOVEL	D0,trainer
	RELOC_MOVEL	D2,joypad

	Mac_printf	"Shadow Of The Beast 3 HD Loader V1.2a"
	Mac_printf	"Programmed by Jean-François Fabre © 1997"

	lea	mainname(pc),A0
	move.l	A0,D0
	JSRABS	TestFile
	tst.l	D0
	bne	MainErr

	; ** test if a file from disk 2 is here (to see if disk 2 has been installed)

	lea	f40name(pc),A0
	move.l	A0,D0
	JSRABS	TestFile
	tst.l	D0
	bne	MainErr

	move.l	#5000,D0
	JSRABS	LoadSmallFiles

;	bsr	MemoryConfig

	moveq.l	#0,D0
	move.l	#CACRF_CopyBack,D1
	JSRABS	Degrade

;	WAIT_LMB

	GO_SUPERVISOR
	SAVE_OSDATA	$80000

	lea	$80000,A7
	JSRGEN	FreezeAll
	move	#$2700,SR

	move.l	ExtBase(pc),D0
	MOVE.L	ExtSize(pc),D1
	MOVE.l	ExtFlag(pc),D2

	MOVE.L	D0,$4.W		; extension base pointer
	MOVE.L	D1,$8.W		; memory extension size

	; *** read the file 'main'

	lea	mainname(pc),A0
	lea	$70000,A1	
	moveq.l	#0,D0
	moveq.l	#-1,D1
	JSRGEN	ReadFile

	bsr	PatchMain
	GETUSRADDR	PatchLoader1
	move.l	D0,$BC.W

	; *** flush the caches (just in case)

	JSRGEN	FlushCachesHard

	; *** and start the dance

	JMP	$7001A


PatchMain:
	lea	version(pc),A4

	cmp.l	#$01E02049,$70100
	bne	not_pal$

	; *** removes a check for NTSC
	; *** (both versions are country-protected)

	move.b	#$60,$7008A

	move.l	#1,(A4)
	bra	verok$

not_pal$	
	cmp.l	#$C7806100,$70100
	bne	not_ntsc$

	; *** NTSC version

	; *** removes a check for PAL
	; *** (both versions are country-protected)

	move.w	#$4E71,$7008A

	move.l	#2,(A4)
	bra	verok$

	; *** unrecognized version: quit

not_ntsc$
	lea	UnrecogErr(pc),A0
	JSRGEN	SetExitRoutine
	JSRGEN	InGameExit
verok$
	; *** patch the file

	lea	$70684,A0
	cmp.l	#2,(A4)
	bne	1$

	; *** NTSC version is shifted by 4 bytes

	lea	$4(A0),A0
1$
	GETUSRADDR	DiskRoutine
	move.w	#$4EF9,(A0)+
	move.l	D0,(A0)

	lea	$702C4,A0
	cmp.l	#2,(A4)
	bne	2$

	; *** NTSC version is shifted by 4 bytes

	lea	$4(A0),A0
2$

	move.w	#$4E4F,(A0)
	rts

PatchLoader1:
	STORE_REGS

	; *** patch the disk routine
	
	PATCHUSRJMP	$6B4D2,DiskRoutine

	; *** remove a mask of the memory zone
	; *** which overrides some of the memory

	move.w	#$6024,$4AFC.W
	
	; *** installs the quit patch (menu)

	PATCHUSRJSR	$7BEE.W,kbint2

	; *** installs the quit patch (in game)

	PATCHUSRJSR	$7D10.W,kbint
	move.w	#$4E71,$7D16

	; *** activates the original cheat keys

	move.w	#$4E71,$7D2C.W

	; *** patch for joypad

	move.l	joypad(pc),D0
	beq	sk$
	
	PATCHUSRJSR	$7BD0.W,CheckJoypad
	PATCHUSRJMP	$7778.W,JoyPatch

sk$

	; *** and starts the main program

	JSRGEN	GoECS
	JSRGEN	FlushCachesHard

	RESTORE_REGS
	jmp	$256.W

CheckJoypad:
	movem.l	D0/A0,-(sp)
	cmp.b	#$7F,($29A).W	; space pressed
	bne.b	sksp$
	lea	spaceemu(pc),A0
	tst.l	(A0)
	beq.b	sksp$
	clr.l	(A0)
	move.b	#$7E,($29A).W	; space released
sksp$

	moveq.l	#1,D0
	JSRGEN	JoypadState
	tst.w	D0
	beq	exit$

	lea	command(pc),A0

	; ** button 2: change weapon
	
	btst	#AFB_FIRE2,D0
	beq.b	1$

	lea	spaceemu(pc),A0
	move.l	#1,(A0)
	move.b	#$7F,($29A).W		; space pressed
	bra	exit$

	; ** start: pause
1$
	btst	#AFB_START,D0
	beq.b	2$

	move.l	#COMM_PAUSE,(A0)
	bra.b	exit$

	; ** forward: cheat on
2$

	btst	#AFB_FORWD,D0
	beq.b	3$
	move.b	#1,$2CB.W
	bra.b	exit$

	; ** back: cheat off

3$
	btst	#AFB_BACWD,D0
	beq.b	4$
	clr.b	$2CB.W
	bra.b	exit$

	; *** green: restart part
4$
	btst	#AFB_FIRE3,D0
	beq.b	5$

	move.l	#COMM_RESTART,(A0)
	bra.b	exit$
5$
exit$
	movem.l	(sp)+,D0/A0
	move.w	#$20,(intreq,A6)
	rts

JoyPatch:
loop$
	move.l	D0,-(sp)
	move.l	command(pc),D0
	bne.b	action$
	move.l	(sp)+,D0
cont$
	tst.b	($30E).W
	beq.b	loop$
	rts

action$
	move.l	A0,-(sp)
	lea	command(pc),A0
	clr.l	(A0)
	move.l	(sp)+,A0	

	cmp.l	#COMM_RESTART,D0
	beq.b	rest$

	cmp.l	#COMM_PAUSE,D0
	beq.b	pause$

	move.l	(sp)+,D0
	bra.b	cont$

weapon$
	move.l	(sp)+,D0
	jmp	($7E0C).W	

pause$
	move.l	(sp)+,D0
	jmp	($7DF4).W	
rest$
	move.l	(sp)+,D0
	jmp	($7E68).W

DiskRoutine:
	cmp.b	#5,D1
	beq	DR_DirRead
	cmp.b	#0,D1
	beq	DR_FileRead

	moveq.l	#0,D0
	bra	DR_End

	; *** load the file

DR_FileRead:
	moveq.l	#0,D0
	moveq.l	#-1,D1

	JSRGEN	ReadFile
	tst.l	D0
	bmi	DR_Error	; not found : fatal error : quit

	move.l	D0,D1
	moveq.l	#0,D0
	bra	DR_End

; *** read directory

DR_DirRead:
	moveq.l	#0,D0
	moveq.l	#0,D1
DR_End:
	MOVEM.L	(A7)+,D2-D7/A0-A6
	RTS

; *** other commands, still not supported

DR_Other:
	cmp.w	#1,D1
	beq	DR_FileWrite
DR_Error:
	lea	FileNotFound(pc),A0
	JSRGEN	SetExitRoutine
	JSRGEN	InGameExit
	bra	DR_Error

; *** write file (not used in SOTB3)
; D0 holds the length to write but we ignore it
; because we write only the scores

DR_FileWrite:
	moveq.l	#-1,D0
	moveq.l	#0,D1
	bra	DR_End


kbint2:
	move.b	$BFEC01,D0
	move.l	D0,-(sp)
	ror.b	#1,D0
	not.b	D0
	cmp.b	#$54,D0	; raw keycode for F5
	bne	noquit$
	JSRGEN	InGameExit
noquit$
	move.l	(sp)+,D0
	tst.b	$BFEC01
	rts

kbint:
	cmp.b	#$57,D0	; their code for F5
	bne	noquit$
	JSRGEN	InGameExit
noquit$
	cmp.b	#$75,D0	; original game
	bne	nothing$
	jmp	$7E58.W
nothing$	
	rts


LocalPatchExcept:
	move.l	$8.W,-(sp)	; used by the game to store data
	JSRGEN	PatchExceptions
	move.l	(sp)+,$8.W
	rts

MemoryConfig:
	move.l	#$100000,D0
	JSRABS	AllocExtMem
	RELOC_MOVEL	D0,ExtBase
	beq	not1MB$

	RELOC_MOVEL	#$100000,ExtSize
	RELOC_MOVEL	#$0F0,ExtFlag
	bra	suite$
not1MB$
	move.l	#$80000,D0
	JSRABS	AllocExtMem
	RELOC_MOVEL	D0,ExtBase
	beq	not512Fast$

	RELOC_MOVEL	#$80000,ExtSize
	RELOC_MOVEL	#$00F,ExtFlag
	bra	suite$

not512Fast$:
	; *** only the 512K chipmem used
	RELOC_CLRL	ExtSize
	RELOC_CLRL	ExtFlag
	RELOC_CLRL	ExtBase

suite$
	rts



	; ** in case the user tries to run the game without having installed
	; ** the game properly

MainErr:
	Mac_printf	"** File ''main'' missing or disk 2 not installed."
	Mac_printf	"   Please install the game properly and try again !!"
	JMPABS	CloseAll

MemErr:
	Mac_printf	"** Not enough memory to run Shadow Of The Beast III"
	JMPABS	CloseAll

FileNotFound:
	Mac_printf	"** Run-time error: a file is missing."
	Mac_printf	"   Please install the game properly and try again !!"
	JSRABS	WaitReturn
	rts

UnrecogErr:
	Mac_printf	"** Version of game not supported"
	Mac_printf	"   Please contact the author!"
	JSRABS	WaitReturn
	rts

trainer:
	dc.l	0
joypad:
	dc.l	0
spaceemu:
	dc.l	0
ExtBase:
	dc.l	0
ExtSize:
	dc.l	0
ExtFlag:
	dc.l	0
version:
	dc.l	0
command:
	dc.l	0
mainname:
	dc.b	"main",0
f40name:
	dc.b	"f40",0
