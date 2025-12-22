; *** $GAME Hard Disk Loader V$VER
; *** Written by Jean-François Fabre


	include	"jst.i"

	HD_PARAMS	"",0,0

MUSIC_NAME:MACRO
music\1name:
	dc.b	"MOD"
	dc.b	\2
	dc.b	".PAK",0
	ENDM

BUILD_TABLE:MACRO
	lea	MusicTable(pc),A0
	lea	music\1name(pc),A1
	move.l	#\2,(A0,8*(\1-1))	; disk offset
	move.l	A1,(A0,8*(\1-1)+4)	; pointer on filename
	ENDM

loader:
	tst.l	D5
	bne	LowmemErr

	Mac_printf	"Street Racer HD version V1.1"
	Mac_printf	"Coded by Jean-François Fabre © 1997"
	Mac_printf	"Thanks to K. Krellwitz for stack fix"

	JSRGEN	CheckAGA
	tst.l	D0
	bne	AgaErr
	
	JSRABS	CheckFastMem
	tst.l	D0
	beq	MemErr

	; set current directory for load files

	lea	datadir(pc),A0
	JSRABS	SetFilesPath

	; check if the main proggy is here

	TESTFILE	mainname
	tst.l	D0
	bne	MainErr

	; load the files in the data dir

	JSRABS	LoadFiles

	BUILD_TABLE	1,$21C
	BUILD_TABLE	2,$234
	BUILD_TABLE	3,$1D4
	BUILD_TABLE	4,$24C
	BUILD_TABLE	5,$204
	BUILD_TABLE	6,$15C
	BUILD_TABLE	7,$1A4
	BUILD_TABLE	8,$1EC
	BUILD_TABLE	9,$174
	BUILD_TABLE	10,$1BC

	moveq.l	#0,D0
	move.l	#CACRF_CopyBack,D1
	JSRABS	Degrade

;	WAIT_LMB

	GO_SUPERVISOR
	SAVE_OSDATA	$200000
	JSRGEN	FreezeAll

	lea		$1ffffc,a7				;Abaddon added and now the game works
									;Same error I got with Dennis AGA and Out to Lunch AGA

	bsr	InstallBoot

	JSRGEN	FlushCachesHard

	jmp	($48D00)

InstallBoot:
	lea	mainname(pc),A0
	lea	$48D00,A1
	moveq.l	#0,D0
	moveq.l	#-1,D1
	JSRGEN	ReadFile		; read the program file
	move.l	A1,A0
	JSRGEN	RNCDecrunch		; unpack it

	PATCHUSRJSR	$1C321E,KbInt	; keyboard patch
	PATCHUSRJMP	$4A874,Clear	; faster clr
	PATCHUSRJMP	$4A748,Decrunch1; faster decrunch
	PATCHUSRJMP	$4A3E8,Decrunch2; faster decrunch

	PATCHGENJMP	$1C0AA2,RNCDecrunch
	PATCHUSRJSR	$1C0E0E,LoadMusic	; disk routine

	move.w	#$6006,$49A7E		; no force PAL
	move.w	#$6006,$49AEA

	; copper store

	lea	$4A000,A0
	lea	$4A100,A1
	move.l	#$6,D0
	move.l	#$F,D1
	JSRGEN	PatchMoveCList_Idx
	rts

LoadMusic:
	STORE_REGS
	
	move.l	A0,A1

	bsr	SearchFile
	cmp.l	#0,A0
	bne	read$	; file found

	lea	music11name(pc),A0	; not found
	bra	read$			; load race music

	RESTORE_REGS
	lea	$BFE201,A4
	rts
read$

	moveq.l	#0,D0
	moveq.l	#-1,D1
	JSRGEN	ReadFile
	tst.l	D0
	bne	filenotfound$
	RESTORE_REGS
	moveq	#0,D0
	addq.l	#4,A7	; pops up stack
	rts

filenotfound$
	lea	FileErr(pc),A0
	JSRGEN	SetExitRoutine
	JSRGEN	InGameExit
	bra	filenotfound$

SearchFile:
	lea	MusicTable(pc),A2
loop$
	move.l	(A2)+,D2
	beq	end$
	cmp.l	D0,D2
	beq	end$
	addq.l	#4,A2
	bra	loop$
end$
	move.l	(A2),A0	; 0 or valid filename pointer
	rts

Clear:
	LEA	$29500,A0
	MOVE.L	#$00003EFF,D7
	BSR	clrloop$
	LEA	$39100,A0
	MOVE.L	#$00003EFF,D7
clrloop$:
	CLR.L	(A0)+
	DBF	D7,clrloop$
	ADDQ	#1,D7
	SUBQ.L	#1,D7
	BPL.S	clrloop$
	RTS

KbInt:
	move.b	D0,($1C3330)
	cmp.b	#$59,D0
	bne	noquit$
	JSRGEN	InGameExit
noquit$:
	cmp.b	#$42,D0
	bne	noicon$
	JSRGEN	InGameIconify
	move.w	#$400F,$DFF000+fmode
noicon$:
	rts

MainErr:
	Mac_printf	"** Program file not found"
	JMPABS	CloseAll

AgaErr:
	Mac_printf	"** This game needs a A1200 or A4000 to run!"
	JMPABS	CloseAll

MemErr:
	Mac_printf	"** This game needs 2MB of fastmem to run."
	JMPABS	CloseAll

LowmemErr:
	Mac_printf	"** This loader does not support LOWMEM!"
	JMPABS	CloseAll

FileErr:
	Mac_printf	"** Run-time error: file not found"
	Mac_printf	"   Hit RETURN to exit"
	JSRABS	WaitReturn
	rts

mainname:
	dc.b	"MAIN.PAK",0

	MUSIC_NAME	1, "HOD"
	MUSIC_NAME	2, "FRA"
	MUSIC_NAME	3, "SUZ"
	MUSIC_NAME	4, "BIF"
	MUSIC_NAME	5, "RAP"
	MUSIC_NAME	6, "SUR"
	MUSIC_NAME	7, "HEL"
	MUSIC_NAME	8, "SUM"
	MUSIC_NAME	9, "RUM"
	MUSIC_NAME	10,"END"
	MUSIC_NAME	11,"RAC"

	cnop	0,4

trainer:
	dc.l	0
ExtBase:
	dc.l	0

datadir:
	dc.b	"data",0
	cnop	0,4

MusicTable:
	blk.l	$20,0

Decrunch1:
	incbin	"decr4A748"
	even
Decrunch2:
	incbin	"decr4A3E8"
