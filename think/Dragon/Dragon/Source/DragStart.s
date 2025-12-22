*************************************************************************
*									*
*			  Dragon Startup Code.				*
*			  --------------------				*
*									*
*			  --------------------				*
*			     Nick Christie				*
*			   35 De Lisle Road				*
*			  Bournemouth BH3 7NF				*
*			     Great Britain				*
*			  --------------------				*
*									*
* Tab size = 8.								*
*									*
* Version 1.0	(18/12/92)						*
* ========================						*
* Startup for C using a4 base-relative data and registerized parameters	*
* callable from WB or shell. Adapted from SAS/C 5.10 startup "c.a".	*
* Sets up _SysBase, opens/closes dos.library, allows stack checking,	*
* initializes _WBenchMsg and __StackPtr. Does not set up __ProgramName,	*
* oserr, ONBREAK, etc. Calls @main (@ == register args) as:		*
*	LONG rc [d0] = @main(char *cmdline [a0], ULONG cmdlen [d0])	*
* Can't use exit(), as it needs other stuff.				*
*									*
* Version 1.1	(1/7/94)						*
* ======================						*
* Edited for V40 includes.						*
*									*
* Assembles under GenAm3 with:						*
*	genam INCDIR <whatever> ALINK DragStart.s			*
* Should assemble easily under other assemblers, me thinks.		*
*									*
*************************************************************************

*************************************************************************
******************************  INCLUDES  *******************************
*************************************************************************

		INCLUDE		"exec/exec.i"
		INCLUDE		"exec/funcdef.i"
		INCLUDE		"exec/exec_lib.i"
		INCLUDE		"dos/dosextens.i"

*************************************************************************
*****************************  REFERENCES  ******************************
*************************************************************************

		XREF		_LinkerDB	; linker defined base value
		XREF		__BSSBAS	; linker defined base of BSS
		XREF		__BSSLEN	; linker defined length of BSS

		XREF		@main		; name of C routine to start
		XREF		_DOSBase	; must supply externally

		XDEF		_SysBase	; exec.library base
		XDEF		_WBenchMsg	; Workbench Startup Msg
		XDEF		__StackPtr	; sp for quick exit
		XDEF		__base		; for stack checking

*************************************************************************
*****************************  DEFINITIONS  *****************************
*************************************************************************

ABSEXECBASE	EQU		4

*************************************************************************
********************************  START  ********************************
*************************************************************************
* Called from shell with cmd line info, from WB with nothing.
*
* In:	a0 = ptr to cmd line (if shell)
*	d0 = len of cmd line (if shell)
* Out:	d0 = return code (if shell)
*
*************************************************************************

		SECTION		TEXT,CODE

		RSRESET					; stack map.
		rs.b		4
SAVEDREGS	rs.b		13*4
STACKSIZE	rs.b		4

Start:		movem.l		d1-d6/a0-a6,-(a7)

		move.l		a0,a2			; save command pointer
		move.l		d0,d2			;  and command length
		lea.l		_LinkerDB,a4		; load data base reg
		move.l		ABSEXECBASE.w,a6

		lea.l		__BSSBAS,a3		; get base of BSS seg
		moveq.l		#0,d1
		move.l		#__BSSLEN,d0		; len of BSS in longs
		bra.s		S_ClrBSS2
S_ClrBSS1:	move.l		d1,(a3)+		; clear BSS segment
S_ClrBSS2:	dbra		d0,S_ClrBSS1

		move.l		sp,__StackPtr(A4)	; save stack ptr
		move.l		a6,_SysBase(a4)		; save SysBase
		clr.l		_WBenchMsg(A4)		; clr WB msg ptr

		moveq.l		#0,d0			; clear any pending
		move.l		#$3000,d1		;   signals
		jsr		_LVOSetSignal(a6)

		lea.l		DOSName(pc),a1		; attempt to open
		moveq.l		#0,d0			;  DOS library
		jsr		_LVOOpenLibrary(a6)
		move.l		d0,_DOSBase(a4)
		bne.s		S_DosOpen
		moveq.l		#100,d0			; failed, return
		bra.s		S_Exit			;  error level 100

S_DosOpen:	move.l		ThisTask(a6),a3		; ptr to my process
		tst.l		pr_CLI(a3)		; called from WB ?
		beq.s		S_FromWB		; yes...

S_FromShell:	move.l		sp,d0			; d0 = top of stack
		sub.l		STACKSIZE(sp),d0	; d0 = bottom of stk
		addi.l		#128,d0			; + 128 for overflow
		move.l		d0,__base(a4)		; save for stack check
		bra.s		S_GoMain		; ready to call program

S_FromWB:	move.l		TC_SPLOWER(a3),d0	; get stack bottom
		addi.l		#128,d0			; + 128 for overflow
		move.l		d0,__base(a4)		; save for checking

		lea.l		pr_MsgPort(a3),a0	; now wait for and
		jsr		_LVOWaitPort(a6)	;  get the WB startup
		lea.l		pr_MsgPort(a3),a0	;   message...
		jsr		_LVOGetMsg(a6)
		move.l		d0,_WBenchMsg(a4)	; save ptr to WB msg,
		movea.l		d0,a2			;  also into a2
		moveq.l		#0,d2			; cmdlen = 0 for WB

S_GoMain:	movea.l		a2,a0			; move cmdlen and
		move.l		d2,d0			;  cmdline into a0/d0
		jsr		@main(pc)		; call C program

S_Exit:		movea.l		__StackPtr(a4),sp	; restore original sp
		move.l		d0,-(a7)		;  & save return code

		tst.l		_WBenchMsg(a4)		; came from WB ?
		beq.s		S_CloseDOS		; nope...

		move.l		ABSEXECBASE.w,a6	; yes...reply the WB msg
		jsr		_LVOForbid(a6)		; but Forbid() first so
		movea.l		_WBenchMsg(a4),a1	; WB doesn't UnLoadSeg()
		jsr		_LVOReplyMsg(a6)	;  us before we're done

S_CloseDOS:	move.l		_DOSBase(a4),d0
		beq.s		S_Return
		movea.l		d0,a1
		move.l		ABSEXECBASE.w,a6
		jsr		_LVOCloseLibrary(a6)

S_Return:	move.l		(a7)+,d0		; retrieve return code
		movem.l		(a7)+,d1-d6/a0-a6
		rts

DOSName:	dc.b		'dos.library',0

*************************************************************************
********************************  DATA  *********************************
*************************************************************************

		SECTION		__MERGED,BSS

__base:		ds.l		1
_SysBase:	ds.l		1
_WBenchMsg:	ds.l		1
__StackPtr:	ds.l		1

		END

