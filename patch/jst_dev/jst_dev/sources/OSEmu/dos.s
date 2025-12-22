;APS00000000000000000000000000000000000000000000000000000000000000000000000000000000
* $Id: dos.s 1.1 1999/02/03 04:09:58 jotd Exp $
**************************************************************************
*   DOS-LIBRARY                                                          *
**************************************************************************
**************************************************************************
*   INITIALIZING                                                         *
**************************************************************************

DOSINIT		move.l	_dosbase,d0
		beq	.init
		rts

.init		move.l	#1050,d0	;(reserved function)
		move.l	#$46,d1
		lea	_dosname,a0
		bsr	_InitLibrary
		move.l	d0,a0
		move.l	d0,_dosbase
		
		patch	_LVOLoadSeg(a0),DOSLOADSEG(pc)
		patch	_LVOUnLoadSeg(a0),DOSUNLOADSEG(pc)
		patch	_LVOOpen(a0),DOSOPEN(PC)
		patch	_LVOClose(a0),DOSCLOSE(PC)
		patch	_LVORead(a0),DOSLOAD(PC)
		patch	_LVOWrite(a0),DOSSAVE(PC)
		patch	_LVOSeek(a0),DOSSEEK(PC)
		patch	_LVOLock(A0),DOSLOCK(PC)
		patch	_LVOInput(A0),MYRTZ(PC)
		patch	_LVOOutput(A0),MYRTZ(PC)
		patch	_LVODeviceProc(A0),MYRTZ(PC)
		patch	_LVOExamine(A0),_EXAMINE(PC)
		patch	_LVOExNext(A0),_EXNEXT(PC)		; added by JOTD
		patch	_LVOExamineFH(A0),_EXAMINEFH(PC)	; added by JOTD
		patch	_LVOIoErr(A0),_IOERR(PC)		; added by JOTD
		patch	_LVOUnLock(A0),_DOSUNLOCK(PC)
		patch	_LVOInfo(A0),DOSINFO(PC)
		patch	_LVODupLock(A0),_DUPLOCK(PC)

		patch	_LVOWaitForChar(A0),MYRTZ(PC)
		patch	_LVOCurrentDir(A0),MYRTZ(PC)
		patch	_LVODelay(A0),DOSDELAY(PC)	; added by JOTD
		patch	_LVOAssignPath(a0),ASSIGNPATH(PC)
		patch	_LVOAssignLock(a0),ASSIGNLOCK(PC)
		patch	_LVORunCommand(a0),RUNCOMMAND(PC) ; added by JOTD
		patch	_LVOGetArgStr(a0),GETARGSTR(PC) ; added by JOTD

		rts

**************************************************************************
*   PROGRAM EXECUTION                                                    *
**************************************************************************

;<D1:SEGLIST
;<D2:STACKSIZE
;<D3:ARGPTR
;<D4:ARGSIZE

;RUNCOMMAND will ignore STACKSIZE: it will use the current stack

RUNCOMMAND:
	move.l	D3,args_ptr
;;	move.l	D4,D0

	LSL.L	#2,D1
	MOVE.L	D1,A1
	ADDQ.L	#4,A1


	jmp	(A1)	; executes the program

GETARGSTR:
	move.l	args_ptr(pc),D0
	rts

args_ptr:
	dc.l	0

_IOERR:
	move.l	last_io_error(pc),D0
	move.l	#ERROR_DIR_NOT_FOUND,last_io_error
	rts

last_io_error:
	dc.l	0

; ******************************************
; 2 special macros added by JOTD for LoadSeg:

; calls EnterDebugger when a condition is reached:

BREAK_ON_COND:MACRO
	cmp.l	\1,\2
	bne.b	.ok\@
	bsr	EnterDebugger
	nop
	nop
.ok\@
	ENDM

; branch with call to EnterDebugger when true
; (to trap error code source)

; uncomment to activate

;BRANCH_COND:MACRO
;	\1	.sk\@
;	bra.b	.end\@
;.sk\@
;	bsr	EnterDebugger
;	bra	\2
;.end\@
;	ENDM

BRANCH_COND:MACRO
	\1	\2	; this is the non-debug configuration
	ENDM

;>D1:FILENAME
;<D0:FIRST SEGMENT
;INTERNAL: D7-TOTAL # OF SEGMENTS
;	D6-FILEHANDLE
;	D5-SEGMENTBASE
;	A4-8 BYTES SPACE ON STACK FOR HUNKHEADERS
;LIMITATIONS: ONLY FOLLOWING HUNKS ALLOWED: HUNK_CODE, HUNK_DATA, HUNK_BSS,
;		HUNK_END, HUNK_RELOC32, HUNK_HEADER, HUNK_DEBUG, HUNK_SYMBOL
;               CONTACT IF YOU HAVE AN EXE WITH OTHER HUNKS, IM SIMPLY MISSING 
;		THE EXAMPLES TO IMPLEMENT THEM

DOSLOADSEG:
	MOVEM.L	D2-D7/A2-A4,-(A7)
	SUBQ.L	#8,A7
	MOVE.L	A7,A4
	MOVE.L	#MODE_OLDFILE,D2
	BSR.W	DOSOPEN
	TST.L	D0
	BRANCH_COND	BEQ.W,.ERR

	MOVE.L	D0,D6
	MOVE.L	D6,D1
	MOVE.L	A4,D2
	MOVEQ.L	#4,D3
	BSR.W	DOSLOAD
	TST.L	D0
	BRANCH_COND	BEQ.W,.ERR2
	CMP.L	#$3F3,(A4)		;FIRST LW=HUNK_HEADER?
	BRANCH_COND	BNE.W,.ERR2
	MOVE.L	D6,D1
	MOVE.L	A4,D2
	MOVEQ.L	#4,D3
	BSR.W	DOSLOAD
	TST.L	D0
	BRANCH_COND	BEQ.W,.ERR2
	TST.L	(A4)			;NO NAME PLEASE
	BRANCH_COND	BNE.W,.ERR2
	MOVE.L	D6,D1
	MOVE.L	A4,D2
	MOVEQ.L	#4,D3
	BSR.W	DOSLOAD
	TST.L	D0
	BRANCH_COND	BEQ.W,.ERR2
	MOVE.L	(A4),D7			;TOTAL # OF HUNKS
	SUBQ.L	#1,D7	
	MOVE.L	D6,D1
	MOVE.L	A4,D2
	MOVEQ.L	#8,D3
	BSR.W	DOSLOAD
	TST.L	D0
	BRANCH_COND	BEQ.W,.ERR2
	TST.L	(A4)			;FIRST HUNK HAS TO BE 0
	BRANCH_COND	BNE.W,.ERR2
	CMP.L	4(A4),D7		;LAST HUNK HAS TO BE HUNK_COUNT
	BRANCH_COND	BNE.W,.ERR2

	MOVEQ.L	#0,D4			;ALLOC MEM FOR ALL SEGMENTS
	MOVEQ.L	#0,D5
.1

	MOVE.L	D6,D1
	MOVE.L	A4,D2
	MOVEQ.L	#4,D3			;GET SIZE AND MEMFLAGS OF HUNK
	BSR.W	DOSLOAD
	TST.L	D0
	BRANCH_COND	BEQ.W,.ERR3

	MOVE.L	(A4),D0

	; added by JOTD: check memtype requirement

	bsr	.getmemflag	; >D1: MEMF_xxx

	; compute mem size

	LSL.L	#2,D0
	ADDQ.L	#8,D0
	MOVE.L	D0,D2			;ALLOC MEM IN SIZE
	ADDQ.L	#7,D0
	AND.L	#$FFFFFFF8,D0

	BSR.W	ALLOCM
	TST.L	D0
	BRANCH_COND	BEQ.W,.ERR3
	MOVE.L	D0,A3
	MOVE.L	D2,(A3)
	CLR.L	4(A3)

	TST.L	D4
	BNE.S	.2
	MOVE.L	D0,D5			;D5-POINTER TO 1ST SEGMENT
	BRA.S	.3

.2
	MOVE.L	D5,A3			;POINTER TO 1ST SEGMENT
.5	TST.L	4(A3)
	BEQ.S	.4
	MOVE.L	4(A3),D2		;NEXT SEGMENT
	LSL.L	#2,D2
	SUBQ.L	#4,D2
	MOVE.L	D2,A3
	BRA.S	.5


.4	ADDQ.L	#4,D0
	LSR.L	#2,D0
	MOVE.L	D0,4(A3)
.3	ADDQ.L	#1,D4
	CMP.L	D7,D4
	BLS.S	.1
					;HEADER COMPLETE, MEM ALLOCATED

			;NOW PROCESSING THE HUNK_CODE, HUNK_DATA AND HUNK_BSS
	MOVEQ.L	#0,D4
.HN	MOVE.L	D6,D1
	MOVE.L	A4,D2
	MOVEQ.L	#4,D3			;GET TYPE OF HUNK
	BSR.W	DOSLOAD
	TST.L	D0
	BRANCH_COND	BEQ.W,.ERR3	;END OF FILE ENCOUNTERED
.MAINHUNKS:
	AND.L	#$3FFFFFFF,(A4)
	CMP.L	#$3E9,(A4)		;HUNK_CODE?
	BEQ.W	.HCD
	CMP.L	#$3F1,(A4)		;HUNK_DEBUG?
	BEQ.S	.HDEBUG1
	CMP.L	#$3EA,(A4)		;HUNK_DATA?
	BEQ.S	.HCD
	CMP.L	#$3EB,(A4)		;HUNK_BSS?
	BEQ.S	.HBSS
	BRANCH_COND	BRA.W,.ERR3

	; debug hunk support, added by JOTD
.HDEBUG1:
	bsr.s	.HDEBUG
	BRA.W	.HN

.HDEBUG2
	bsr.s	.HDEBUG
	bra	.INNERHUNK
	
.HDEBUG:
	MOVE.L	D6,D1
	MOVE.L	A4,D2
	MOVEQ.L	#4,D3
	BSR.W	DOSLOAD			;GET HUNK LENGTH
	MOVE.L	(A4),D0
	add.l	D0,D0
	add.l	D0,D0

	MOVE.L	D6,D1
	MOVE.L	D0,D2
	MOVE.L	#OFFSET_CURRENT,D3
	BSR.W	DOSSEEK			;SKIP DEBUG DATA
	CMP.L	#-1,D0
	BRANCH_COND	BEQ.W,.ERR3
	RTS

.HBSS	
	MOVE.L	D6,D1			;BSS-HUNK
	MOVE.L	A4,D2
	MOVEQ.L	#4,D3			;IGNORE SIZE OF HUNK
	BSR.W	DOSLOAD
	TST.L	D0
	BRANCH_COND	BEQ.W,.ERR3
	BRA.S	.INNERHUNK

.HCD
	MOVE.L	D6,D1			;CODE- AND DATA-HUNK
	MOVE.L	A4,D2
	MOVEQ.L	#4,D3			;GET SIZE OF HUNK
	BSR.W	DOSLOAD
	TST.L	D0
	BRANCH_COND	BEQ.W,.ERR3
	MOVE.L	(A4),D3			;LEN OF HUNK
	beq	.INNERHUNK		; added by JOTD, hunk code can be of 0 length
	LSL.L	#2,D3
	MOVE.L	D4,D1			;ACTUAL HUNK
	MOVE.L	D5,A3			;START OF 1ST SEGMENT
	BRA.S	.HCD1

.HCD2	MOVE.L	4(A3),D2
	LSL.L	#2,D2
	SUBQ.L	#4,D2
	MOVE.L	D2,A3
.HCD1	DBF	D1,.HCD2
	MOVE.L	A3,D2
	ADDQ.L	#8,D2
	MOVE.L	D6,D1

	BSR.W	DOSLOAD
	TST.L	D0
	BRANCH_COND	BEQ.W,.ERR3

.INNERHUNK:
	MOVE.L	D6,D1
	MOVE.L	A4,D2
	MOVEQ.L	#4,D3			;GET TYPE OF HUNK
	BSR.W	DOSLOAD
	TST.L	D0
	BRANCH_COND	BEQ.W,.ERR3
	CMP.L	#$3EC,(A4)		;HUNK_RELOC32?
	BEQ.S	.HRELOCT
	CMP.L	#$3F2,(A4)		;HUNK_END?
	BEQ.W	.HENDT
	CMP.L	#$3F0,(A4)		;HUNK_SYMBOL?
	BEQ.W	.HSYMBOLT
	CMP.L	#$3F1,(A4)		;HUNK_DEBUG?
	BEQ.W	.HDEBUG2
	BRANCH_COND	BRA.W,.ERR3

.HRELOCT
	MOVE.L	D6,D1
	MOVE.L	A4,D2
	MOVEQ.L	#4,D3			;GET COUNT OF LW-RELOCS
	BSR.W	DOSLOAD
	TST.L	D0
	BRANCH_COND	BEQ.W,.ERR3
	TST.L	(A4)			;END OF RELOCATION?
	BEQ.S	.INNERHUNK
	MOVE.L	D6,D1
	MOVE.L	A4,D2
	ADDQ.L	#4,D2
	MOVEQ.L	#4,D3			;GET CORRESPONDING HUNK TO RELOCATE TO
	BSR.W	DOSLOAD
	TST.L	D0
	BRANCH_COND	BEQ.W,.ERR3

	MOVE.L	(A4),D0

	bsr	.getmemflag

	LSL.L	#2,D0			;ALLOC MEM OF SIZE OF RELOCTABLE
	ADDQ.L	#7,D0
	AND.L	#$FFFFFFF8,D0

	BSR.W	ALLOCM
	TST.L	D0
	BRANCH_COND	BEQ.W,.ERR4
	MOVE.L	D0,A2
	MOVE.L	D6,D1
	MOVE.L	A2,D2
	MOVE.L	(A4),D3			;GET CORRESPONDING RELOCS TO RELOCATE
	LSL.L	#2,D3
	BSR.W	DOSLOAD
	TST.L	D0
	BRANCH_COND	BEQ.W,.ERR4
	MOVE.L	(A4),D3			;# OF RELOCS
	MOVE.L	4(A4),D2		;WHICH HUNK TO RELOCATE TO?
	MOVE.L	D5,A0
	BRA.S	.HRELOCT3

.HRELOCT4
	MOVE.L	4(A0),D0
	LSL.L	#2,D0
	SUBQ.L	#4,D0
	MOVE.L	D0,A0
.HRELOCT3
	DBF	D2,.HRELOCT4		

	ADDQ.L	#8,A0
	MOVE.L	A0,D0			;GOT THE HUNK TO RELOCATE TO
	LEA.L	8(A3),A1		;THIS HUNK WILL BE RELOCATED
	MOVE.L	A2,A0			;HERE ARE THE RELOCS
	BRA.S	.HRELOCT5

.HRELOCT6
	MOVE.L	(A0)+,D1
	ADD.L	D0,(A1,D1.L)
.HRELOCT5
	DBF	D3,.HRELOCT6
	MOVE.L	A2,A1			;FREE THE MEM OF SIZE OF RELOCTABLE
	MOVE.L	(A4),D0
	LSL.L	#2,D0
	ADDQ.L	#7,D0
	AND.L	#$FFFFFFF8,D0
	BSR.W	FREEM
	BRA.W	.HRELOCT

.HSYMBOLT
	MOVE.L	D6,D1
	MOVE.L	A4,D2
	MOVEQ.L	#4,D3
	BSR.W	DOSLOAD			;GET NAMELENGTH
	TST.L	D0
	BRANCH_COND	BEQ.W,.ERR3
	MOVE.L	(A4),D0
	AND.L	#$FFFFFF,D0
	BEQ.W	.INNERHUNK		;IF NO NAMELENGTH -> END OF HUNK
	LSL.L	#2,D0			;LEN OF NAME IS IN LONGWORDS
	ADDQ.L	#4,D0			;SKIP ALSO SYMBOLOFFSET
	MOVE.L	D6,D1
	MOVE.L	D0,D2
	MOVE.L	#OFFSET_CURRENT,D3
	BSR.W	DOSSEEK
	CMP.L	#-1,D0
	BRANCH_COND	BEQ.S,.ERR3
	BRA.S	.HSYMBOLT

.HENDT
	ADDQ.L	#1,D4
	CMP.L	D7,D4
	BLS.W	.HN

.END	MOVE.L	D6,D1
	BSR.W	DOSCLOSE
	MOVE.L	D5,D0
	ADDQ.L	#4,D0
	MOVE.L	D0,OSM_LASTLOADSEG
	LSR.L	#2,D0
	ADDQ.L	#8,A7

	move.l	(_RESLOAD),a2
	jsr	(resload_FlushCache,a2)		; added by JOTD: cache flush

	MOVEM.L	(A7)+,D2-D7/A2-A4
	RTS
	dc.b	"Errors",0,0
.ERR4
.ERR3
.ERR2	MOVE.L	D6,D1
	BSR.W	DOSCLOSE
.ERR	MOVEQ.L	#0,D0

	ADDQ.L	#8,A7
	MOVEM.L	(A7)+,D2-D7/A2-A4
	RTS

; utility routines used by LoadSeg()

.getmemflag:
	btst	#HUNKB_CHIP,D0			; CHIPMEM required?
	beq.b	.nochip

	move.l	#MEMF_CHIP,D1
	bra.b	.doalloc
.nochip
	btst	#HUNKB_FAST,D0			; FASTMEM required?
	beq.b	.nofast

	move.l	#MEMF_FAST,D1
	bra.b	.doalloc

.nofast
	MOVEQ.L	#MEMF_ANY,D1			;any memtype will do
.doalloc
	rts

; UnLoadSeg()

DOSUNLOADSEG
	MOVE.L	A2,-(A7)
	LSL.L	#2,D1
.1	MOVE.L	D1,A1
	MOVE.L	(A1),D1
	LSL.L	#2,D1
	MOVE.L	D1,A2

	SUBQ.L	#4,A1
	MOVE.L	(A1),D0
	BSR.W	FREEM

	MOVE.L	A2,D1
	BNE.S	.1

	MOVEQ.L	#0,D0
	MOVE.L	(A7)+,A2
	RTS

**************************************************************************
*   I/O FILE FUNCTIONS                                                   *
**************************************************************************

;will not work properly if the program assigns a subdir
;I (JOTD) added it for SlamTilt, which only assigns to PROGDIR:
;so it's OK

ASSIGNLOCK:
	moveq.l	#1,D0
	rts

;will not work properly if the program assigns a subdir
;I (JOTD) added it for SlamTilt, which only assigns to PROGDIR:
;so it's OK

ASSIGNPATH:
	moveq.l	#1,D0
	rts

;filehandle represents the following structure (do not try to access it!):
;0-allocated len
;4-total filelength
;8-pointer in file
;$c-openmodus
;$10-filename

;open strips the device from the filename (avoiding problems with assigns)
DOSOPEN
	MOVEM.L	D4-D5/A3-A5,-(A7)
	MOVE.L	D1,A3
	MOVEQ.L	#$10,D4			;HEADERLEN
	TST.B	(A3)
	BEQ.S	.ERR
.1	ADDQ.L	#1,D4
	TST.B	(A3)+
	BNE.S	.1
	ADDQ.L	#7,D4			;NEXT $8-BOUNDARY
	AND.L	#$FFFFFFF8,D4
	MOVE.L	D1,D5			;^NAME
	MOVE.L	D4,D0			;ALLOC. LENGTH
	MOVEQ.L	#0,D1
	BSR.W	ALLOCM
	TST.L	D0
	BEQ.S	.ERR
	MOVE.L	D0,A3
	MOVE.L	D4,(A3)			;ALLOC. LENGTH
	MOVE.L	D2,$C(A3)		;OPENMODE
	CLR.L	$8(A3)			;INFILE-POINTER TO 0
	LEA.L	$10(A3),A4		;TRANS FILENAME
	MOVE.L	D5,A5
.2	MOVE.B	(A5)+,(A4)
	BEQ.S	.4
	CMP.B	#':',(A4)
	BNE.S	.3
	LEA.L	$10-1(A3),A4
.3	ADDQ.W	#1,A4
	BRA.S	.2

.4	CMP.W	#MODE_NEWFILE,D2	;IF MODE_NEWFILE, DELETE FILE
	BEQ.S	.NEWFILE




					;CHECK IF FILE EXISTS
	LEA.L	$10(A3),A0		;filename
;	CMP.L	#'b/fs',(A0)		;LORDS OF WAR
;	BEQ.S	.ERR2
	move.l	_RESLOAD(PC),a1
	jsr	(resload_GetFileSize,a1)
	MOVE.L	D0,$4(A3)
	MOVE.L	A3,D0
.END	MOVEM.L	(A7)+,D4-D5/A3-A5
	RTS

.ERR2
	MOVE.L	A3,A1
	MOVE.L	(A1),D0
	BSR.W	FREEM

.ERR	MOVEQ.L	#0,D0
	BRA.S	.END

.NEWFILE				;REDUCE FILE TO 0 BYTE
	CLR.L	$4(A3)
	LEA.L	$10(A3),A0
	MOVEQ.L	#0,D0
	LEA.L	$0.W,A1

	move.l	OSM_JSTFLAGS,D4
	btst	#AFB_NOOSSWAP,D4
	bne.b	.SKIPZFILE		;no write to disk if NOOSSWAP is on

	move.l	_RESLOAD(pc),a5
	jsr	(resload_SaveFile,a5)

.SKIPZFILE
	MOVE.L	A3,D0
	BRA.S	.END

; reads a file (call to Read())

; < D1: file handler
; < D2: destination buffer
; < D3: number of bytes to read

DOSLOAD:
	MOVEM.L	D3/A2-A3,-(A7)
	MOVE.L	D1,A3
	MOVE.L	$8(A3),D1		;OFFSET (current)
	MOVE.L	D2,A1			;DEST
	LEA.L	$10(A3),A0		;NAME
	MOVE.L	$4(A3),D0		;TOTAL LENGTH OF FILE
	SUB.L	D1,D0
	EXG	D3,D0
	CMP.L	D0,D3			;CMP REQUESTED/REAL
	BHI.S	.1			;IF REQUESTED<=REAL
	MOVE.L	D3,D0
.1	MOVE.L	D0,D3
					;LOAD IT
	MOVE.L	_RESLOAD(PC),A2
;	MOVE.W	#$80,$DFF096
	JSR	resload_LoadFileOffset(A2)
;	MOVE.L	GRABAS+$32(PC),$DFF084
;	MOVE.W	#$8080,$DFF096
	ADD.L	D3,$8(A3)
	MOVE.L	D3,D0
	MOVEM.L	(A7)+,D3/A2-A3
	RTS


DOSSAVE
	MOVEM.L	D3-D4/A2-A3,-(A7)
	MOVE.L	D1,A3
	MOVE.L	$8(A3),D1		;OFFSET
	MOVE.L	D2,A1			;DEST
	LEA.L	$10(A3),A0		;NAME
	MOVE.L	D3,D0

	btst	#AFB_NOOSSWAP,D4	; added by JOTD
	bne.b	.SKIPWFILE		; no write to disk if NOOSSWAP is on

	MOVE.L	_RESLOAD(PC),A2		;SAVE IT
	JSR	resload_SaveFileOffset(A2)
.SKIPWFILE:
	ADD.L	D3,$8(A3)
	LEA.L	$10(A3),A0		;filename
	move.l	_RESLOAD(PC),a1
	jsr	(resload_GetFileSize,a1)
	MOVE.L	D0,$4(A3)
	MOVE.L	D3,D0
	MOVEM.L	(A7)+,D3-D4/A2-A3
	RTS

;free allocated structure
_DOSUNLOCK
DOSCLOSE
	MOVE.L	D1,A1
	MOVE.L	(A1),D0
	BSR.W	FREEM
	RTS

DOSSEEK:
	MOVE.L	D1,A1
	CMP.L	#OFFSET_BEGINNING,D3
	BEQ.S	.BEGM
	CMP.L	#OFFSET_END,D3
	BEQ.S	.ENDM
	CMP.L	#OFFSET_CURRENT,D3
	BEQ.S	.CURM
.ERR	MOVEQ.L	#-1,D0
	RTS

.CURM
	MOVE.L	$8(A1),D0
	MOVE.L	D0,D1
	ADD.L	D2,D1
	CMP.L	$4(A1),D1
	BHI.S	.ERR
	MOVE.L	D1,$8(A1)
	RTS

.ENDM	MOVE.L	$8(A1),D0
	MOVE.L	$4(A1),D1
	ADD.L	D2,D1
	CMP.L	$4(A1),D1
	BHI.S	.ERR
	MOVE.L	D1,$8(A1)
	RTS

.BEGM	MOVE.L	$8(A1),D0
	MOVE.L	D2,D1
	CMP.L	$4(A1),D1
	BHI.S	.ERR
	MOVE.L	D1,$8(A1)
	RTS

; Added by JOTD. Now Flashback works

DOSINFO:
	movem.l	A1,-(A7)
	move.l	D2,A1

	move.l	#0,(id_NumSoftErrors,A1)	; no errors!
	move.l	#0,(id_UnitNumber,A1)		; unit 0 should be OK
	move.l	#ID_VALIDATED,(id_DiskState,A1)	; disk validated
	move.l	#10000,(id_NumBlocks,A1)	; number of blocks = 500 Megs
	move.l	#ID_DOS_DISK,(id_DiskType,A1)	; disk type: OFS
	move.l	#0,(id_VolumeNode,A1)		; zero this entry. it sucks but...
	move.l	#0,(id_InUse,A1)		; not in use

	movem.l	(A7)+,A1
	moveq.l	#-1,D0		; returns TRUE (success)
	rts

DOSDELAY:			; added by JOTD
	tst.l	D1
	beq	.exit
.loop
	bsr	_waitvb
	subq.l	#1,D1
	bne.b	.loop
.exit
	rts

**************************************************************************
*   FILE MANAGEMENT FUNCTIONS                                            *
**************************************************************************

;filehandle represents the following structure (do not try to access it!):
;0-allocated len
;4-total filelength
;8-pointer in file
;$c-openmodus
;$10-filename

;if $10 of filehandle is a : its the volumelock
;atm: 0.L-$1000 len, 4.W-# of file in examine/exnext (-1:invalid), 
;6.W-MAX# OF FILES, 8.L-pointer in table, $c.L-openmode

DOSLOCK:
	MOVEM.L	D4-D5/A3-A5,-(A7)
	MOVE.L	D1,A3
	MOVEQ.L	#$10,D4			;HEADERLEN
	TST.B	(A3)
	BEQ.S	.ERR
.1	ADDQ.L	#1,D4
	TST.B	(A3)+
	BNE.S	.1
	ADDQ.L	#7,D4			;NEXT $8-BOUNDARY
	AND.L	#$FFFFFFF8,D4
	MOVE.L	D1,D5			;^NAME
	MOVE.L	D4,D0			;ALLOC. LENGTH
	MOVE.L	#MEMF_CLEAR,D1
	BSR.W	ALLOCM
	TST.L	D0
	BEQ.S	.ERR

	MOVE.L	D0,A3
	MOVE.L	D4,(A3)			;ALLOC. LENGTH
	MOVE.L	D2,$C(A3)		;OPENMODE
	CLR.L	$8(A3)			;INFILE-POINTER TO 0
	LEA.L	$10(A3),A4		;TRANS FILENAME
	MOVE.L	D5,A5
.2	MOVE.B	(A5)+,(A4)		; remove the volume name
	BEQ.S	.4
	CMP.B	#':',(A4)
	BNE.S	.3
	TST.B	(A5)
	BEQ.S	.VOLUMELOCK

	LEA.L	$10-1(A3),A4
.3	ADDQ.W	#1,A4
	BRA.S	.2

.4					;CHECK IF FILE EXISTS
	LEA.L	$10(A3),A0		;filename
	move.l	_RESLOAD(PC),a1
	jsr	(resload_GetFileSize,a1)
	MOVE.L	D0,$4(A3)

	TST.L	D0
	BEQ.S	.LOCKFAILED
	MOVE.L	A3,D0
.END	MOVEM.L	(A7)+,D4-D5/A3-A5
	RTS

.ERR	MOVEQ.L	#0,D0
	BRA.S	.END

.VOLUMELOCK
	MOVE.L	(A3),D0			;free mem because we need a larger area
	MOVE.L	A3,A1			; JOTD: bugfix: changed D1 to A1
	BSR.W	FREEM

	MOVE.L	#$1000,D0
	MOVE.L	#MEMF_CLEAR,D1	; MEMF_CHIP removed
	BSR.W	ALLOCM
	TST.L	D0
	BEQ.S	.ERR
	MOVE.L	D0,A3
	MOVE.B	#':',$10(A3)	; addressing error bug: ':' instead of #':'
	MOVE.L	D2,$C(A3)
	MOVE.W	#-1,4(A3)
					;8(A3) is already clear due MEMF_CLEAR
	MOVE.L	#$1000,(A3)
	BRA.S	.END

.LOCKFAILED
	MOVEQ.L	#0,D0
.FREEMEM
	MOVE.L	D0,D5
	MOVE.L	(A3),D0
	MOVE.L	A3,A1			; bugfix there too
	BSR.W	FREEM
	MOVE.L	D5,D0
	BRA.S	.END

_DUPLOCK
	TST.L	D0
	BEQ.S	.ROOTLOCK
	MOVE.L	D1,-(A7)
	MOVE.L	D1,A0
	MOVE.L	(A0),D0
	MOVE.L	#MEMF_CLEAR,D1
	BSR.W	ALLOCM
	MOVE.L	(A7)+,A0
	TST.L	D0
	BEQ.S	.ERR
	MOVE.L	D0,A1
	MOVE.L	(A0),D1
	SUBQ.L	#1,D1
.1	MOVE.B	(A0)+,(A1)+
	DBF	D1,.1
	RTS

.ERR	MOVEQ.L	#0,D0
	RTS

.ROOTLOCK
	MOVEQ.L	#$14,D0
	MOVE.L	#MEMF_CLEAR,D1
	BSR.W	ALLOCM
	TST.L	D0
	BEQ.S	.ERR
	MOVE.L	D0,A0
	MOVE.L	#$14,(A0)
	RTS

; Examine next directory entry

_EXNEXT
	MOVEM.L	A2-A3,-(A7)

	move.l	D1,A3
	move.l	8(A3),A2
	tst.b	(A2)
	beq.b	.nomorefiles
	bsr	ExamineOneFile
	moveq.l	#0,D0
.exit
	MOVEM.L	(A7)+,A2-A3
	RTS
.nomorefiles
	move.l	#ERROR_NO_MORE_ENTRIES,last_io_error
	moveq.l	#-1,D0
	bra.b	.exit

ExamineOneFile:
	move.l	8(A3),A0	; current file pointer

	MOVE.L	_RESLOAD(PC),A2
	jsr	(resload_GetFileSize,a2)
	TST.L	D0
	BEQ.W	.ERR
	MOVE.W	#1,$4(A3)
	MOVE.L	D2,A2		; FIB
	MOVE.L	D0,fib_Size(A2)
	MOVE.L	#2,(A2)	
	MOVE.L	#-3,fib_DirEntryType(A2)
	SUBQ.L	#1,D0
	LSR.L	#8,D0			;ASSUMED FFS
	LSR.L	#1,D0
;	DIVU	#$1E8,D0		;WOULD BE OFS
	ADDQ.L	#1,D0
	MOVE.L	D0,fib_NumBlocks(A2)	
	move.l	8(A3),A0	; current file pointer
	LEA.L	fib_FileName(A2),A1
.COPYFILENAME2
	MOVE.B	(A0)+,(A1)+
	TST.B	-1(A0)
	BNE.S	.COPYFILENAME2
	MOVE.L	A0,8(A3)		; UPDATE FILENAME POINTER
.ERR
	MOVEQ.L	#-1,D0
	rts


_EXAMINE
	MOVEM.L	A2-A3,-(A7)
	MOVE.L	D1,A3

	CMP.B	#':',$10(A3)
	BNE.W	.ONEFILE

	; volume lock

	LEA.L	$20(A3),A0
	MOVE.W	#($1000-$20)/4-1,D0
.CLR1	CLR.L	(A0)+
	DBF	D0,.CLR1
					;GET FILEDIR
	MOVE.L	#$1000-$20,D0
	LEA.L	$20(A3),A1
	LEA.L	FILEPATH(PC),A0
	move.l	_RESLOAD(pc),a2

	jsr	(resload_ListFiles,a2)

	MOVE.W	D0,$6(A3)
	TST.W	D0
	BEQ.W	.ERR

	LEA.L	$20(A3),A0
	MOVE.L	A0,8(A3)	; init file pointer with first file of dir

;;	bsr	ExamineOneFile

	MOVEM.L	(A7)+,A2-A3
	RTS


.ONEFILE
	lea	$10(A3),a0		;filename
	move.l	_RESLOAD(PC),a2
	jsr	(resload_GetFileSize,a2)
	TST.L	D0
	BEQ.S	.ERR
	MOVE.L	D2,A2
	MOVE.L	D0,fib_Size(A2)
	MOVE.L	#2,(A2)	
	MOVE.L	#ST_FILE,fib_DirEntryType(A2)
	MOVE.L	#ST_FILE,fib_EntryType(A2)	; added by JOTD, Sensible Soccer CD32 v1.2
	MOVE.L	#$F,fib_Protection(A2)		; added by JOTD, File rwxd
	LSR.L	#8,D0			;ASSUMED FFS
	LSR.L	#1,D0
;	DIVU	#$1E8,D0		;WOULD BE OFS
	ADDQ.L	#1,D0
	MOVE.L	D0,fib_NumBlocks(A2)	
	LEA.L	$10(A3),A0
	LEA.L	fib_FileName(A2),A1
.COPYFILENAME
	MOVE.B	(A0)+,(A1)+
	TST.B	-1(A0)
	BNE.S	.COPYFILENAME
	MOVEQ.L	#-1,D0
	MOVEM.L	(A7)+,A2-A3
	RTS

.ERR		pea	_LVOExamine
		pea	_dosname
		bra	_emufail

; added by JOTD (needed by SlamTilt)

_EXAMINEFH:
	MOVEM.L	D3/A3,-(A7)
	MOVE.L	D1,A3
	MOVE.L	D2,D3			;output struct
	LEA.L	$10(A3),A0		;NAME
	move.l	A0,D1
	move.l	#MODE_OLDFILE,D2
	bsr	DOSOPEN	
	move.l	D0,-(A7)

	move.l	D3,D2
	move.l	D0,D1			;filehandle!
	bsr	_EXAMINE

	move.l	(A7)+,D1
	bsr	DOSCLOSE

	MOVEM.L	(A7)+,D3/A3
	RTS



	rts

FILEPATH
	DC.B	0
	EVEN

