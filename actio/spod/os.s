
	include "include/exec_lib.i"
	include "include/dos_lib.i"
	include "include/intuition_lib.i"
	include "include/graphics_lib.i"
	
;************************************************
;*
;* Init
;*
;* return d0 != 0 -> error
;*
;************************************************

Init
	bsr	OpenLibs
	tst.l	d0
	bne	.ErrorOpenLibs
	
	;cli or wb
	
	suba.l	a1,a1
	move.l	4.w,a6
	jsr	_LVOFindTask(a6)	;find self
	move.l	d0,a4
	
	clr.l	workbenchMsg
	
	tst.l	pr_CLI(a4)		;cli data ?
	bne.s	.fromCli
	
	clr	FromCLI

	lea	pr_MsgPort(a4),a0
	move.l	4.w,a6
	jsr	_LVOWaitPort(a6)	;wait for message
	
	lea	pr_MsgPort(a4),a0
	move.l	4.w,a6
	jsr	_LVOGetMsg(a6)		;get message
	move.l	d0,workbenchMsg
	
	move.l	d0,a0	
	move.l	sm_ArgList(a0),a2	;first wbarg
	move.l	0(a2),d1		;get lock
	;move.l	4(a2),a3		;string
	
	move.l	_DOSBase,a6		;set to current dir
	jsr	_LVOCurrentDir(a6)

.fromCli

	move	#1,FromCLI
	
	;check cpu / get vbr
	
	move.l	4.w,a6
	move	AttnFlagsOffset(a6),d0
	moveq	#0,d7			;default is zero
	btst	#0,d0			;bit 0 is set at least for 68010
	beq	.is68k
	
	lea 	.getVBR(pc),a5		;
	jsr 	_LVOSupervisor(a6)	;exec .getVBR in supervisor mode
.is68k	
	move.l	d7,vecBase
	
	;end
	
	moveq	#0,d0
	
.ErrorOpenLibs	

	rts

	mc68010
	
.getVBR	movec	vbr,d7
	rte
	
	mc68000
	
;************************************************
;*
;* Cleanup
;*
;* return d0
;*
;************************************************

Cleanup
	bsr	CloseLibs
	
	tst.l	workbenchMsg
	beq.s	.wasCli
	
	move.l	4.w,a6
        jsr	_LVOForbid(a6)

	move.l	workbenchMsg,a1
	move.l	4.w,a6
	jsr	_LVOReplyMsg(a6)
	
.wasCli	
	rts	

;************************************************
;*
;* OSOff
;*
;************************************************

OSOff
	;store and open view to switch rtg etc., own blitter, ....
	
	move.l	_GfxBase,a6
	move.l	gb_ActiView(a6),oldView
	
	sub.l	a1,a1		
	jsr 	_LVOLoadView(a6) 	
	jsr	_LVOWaitTOF(a6) 	
	jsr	_LVOWaitTOF(a6) 	;two times for interlaced
	jsr	_LVOOwnBlitter(a6)	
	jsr	_LVOWaitBlit(a6)
	
	;
	
	lea	$dff000,a6
	move	$2(a6),oldDMACON	;DMACONR
	move	$1c(a6),oldINTENA	;INTENAR
	move	#$7fff,$9a(a6)		;disable all
	move	#$e000,$9a(a6)		;enable master and extern (level 6)
	clr	$1fc(a6)		;FMODE disable aga fmodes
	move	#$20,$1dc(a6)		;force to PAL
	
	;store vec
	
	lea	IVECSave,a1
	move.l	vecBase,a0
		
	move.l	Ex_BusErr(a0),(a1)+
	move.l	Ex_AdrErr(a0),(a1)+
	move.l	Ex_IllInst(a0),(a1)+
	move.l	Ex_DivNull(a0),(a1)+
        move.l	Ex_ChkInt(a0),(a1)+
	
	;set vec
	
	move.l	#BusErrINT,Ex_BusErr(a0)
	move.l	#AdrErrINT,Ex_AdrErr(a0)
	move.l	#IllInstINT,Ex_IllInst(a0)
	move.l	#DivNullINT,Ex_DivNull(a0)
	move.l	#ChkINT,Ex_ChkInt(a0)
	
	
		
	rts

;************************************************
;*
;* OSOn
;*
;************************************************
	
OSOn
	;restore vec
	
	lea	IVECSave,a0
	move.l	vecBase,a1

	move.l	(a0)+,Ex_BusErr(a1)
	move.l	(a0)+,Ex_AdrErr(a1)
	move.l	(a0)+,Ex_IllInst(a1)
	move.l	(a0)+,Ex_DivNull(a1)
	move.l	(a0)+,Ex_ChkInt(a1)

	;restore dmacon / intena

	lea	$dff000,a6
	move	oldDMACON,d0
	or	#$8000,d0		;SET
	move	d0,$96(a6)		;DMACON
	
	move	oldINTENA,d0
	or	#$c000,d0		;SET + INTEN
	move	d0,$9a(a6)		;INTEN
	
	;restore view, disown blitter

	move.l	oldView,a1
	move.l	_GfxBase,a6
	jsr	_LVOLoadView(a6) 	
	jsr	_LVODisownBlitter(a6)	
	move.l	gb_copinit(a6),$dff080

	rts

;*******************************************************************************
;
; ExecptionHandler
;
;*******************************************************************************


BusErrINT       
		bra	Execption
AdrErrINT       
		bra	Execption
IllInstINT  	
		bra	Execption
DivNullINT  	
		bra	Execption
ChkINT      	
		bra	Execption
PrivINT		
		bra	Execption
		nop
		
Execption	

	move.l	8(sp),exOldPC
	movem.l	d0-d7/a0-a6,-(sp)

	bsr	OSOn 			;os recover
	bsr	Cleanup			;cleanup	

	movem.l	(sp)+,d0-d7/a0-a6
	rte
	
		

;************************************************
;*
;* OpenLibs
;*
;* return d0 != 0 -> error
;*
;* use a1,a6
;************************************************

OpenLibs     

	;open dos
	
	lea	DosName,a1
	move.l 	4.w,a6
	jsr     _LVOOldOpenLibrary(a6)
	tst.l	d0
	beq	.InitFail
	move.l	d0,_DOSBase
	
	;open intuition
	
	move.l 4.w,a6
	lea    IntuitionName,a1
	jsr    _LVOOldOpenLibrary(a6)
	tst.l	d0
	beq	.InitFailCloseDos
	move.l d0,_IntuitionBase

	;open graphics
	 
	move.l 4.w,a6
	lea    GfxName,a1
	jsr    _LVOOldOpenLibrary(a6)
	tst.l	d0
	beq	.InitFailCloseIntuitionAndDos
	move.l d0,_GfxBase
 
	moveq	#0,d0
	rts

.InitFailCloseIntuitionAndDos

	move.l 4.w,a6
	move.l _IntuitionBase,a1
	jmp    _LVOCloseLibrary(a6)

.InitFailCloseDos

	move.l 4.w,a6
	move.l _DOSBase,a1
	jmp    _LVOCloseLibrary(a6)
	
.InitFail	
	moveq	#1,d0
	rts
	
;************************************************
;*
;* CloseLibs
;*
;************************************************

CloseLibs    

	;close graphics

	move.l 4.w,a6
	move.l _GfxBase,a1
	jmp    _LVOCloseLibrary(a6)
	
	;close intuition

	move.l 4.w,a6
	move.l _IntuitionBase,a1
	jmp    _LVOCloseLibrary(a6)
	
	;close dos

	move.l 4.w,a6
	move.l _DOSBase,a1
	jmp    _LVOCloseLibrary(a6)
	rts
	
;************************************************
;*
;* Printf
;*
;* a0 text
;* a1 parameter adr
;*
;************************************************

Printf  

        movem.l d0-d7/a0-a6,-(sp)

        move.l  4.w,a6
					;a0 is text
					;a1 is data
        lea     .printPutC(PC),a2	;put function
        lea     .printStream,a3       	;buffer
        jsr     _LVORawDoFmt(a6)   	;

        move.l  a3,d2   		;store buffer start
        moveq   #-1,d3
.printStrLen
        addq.l  #1,d3
        tst.b   (a3)+ 
        bne.s   .printStrLen

        move.l  _DOSBase,a6		
	jsr	_LVOOutput(a6)		;d0 = get output handle
	
	
        move.l  d0,d1
					;d2 = buffer
					;d3 = length
        jsr     _LVOWrite(a6)

        movem.l (sp)+,d0-d7/a0-a6
        rts

.printPutC
        move.b  d0,(a3)+
        rts
	
.printStream  ds.b    256 
	
	cnop	0,4
	
;************************************************
;*
;* data
;*
;************************************************

GfxName 	dc.b   	"graphics.library",0
DosName		dc.b	"dos.library",0
IntuitionName	dc.b	'intuition.library',0

	cnop	0,4
	
	;exec/screen/prefs/graphics defs

pr_CLI		equ	$ac	
pr_MsgPort	equ	$5c
AttnFlagsOffset equ	$128
gb_ActiView	equ	$22
gb_copinit 	equ 	$26
sm_NumArgs	equ	$1c
sm_ArgList	equ	$24

_IntuitionBase	dc.l	0	
_GfxBase        dc.l	0
_DOSBase	dc.l	0

FromCLI		dc.w	0
workbenchMsg	dc.l	0
oldView		dc.l	0
oldDMACON	dc.w	0
oldINTENA	dc.w	0
vecBase		dc.l	0

exOldPC		dc.l	0

IVECSave	dc.l	0	;BusErr		
		dc.l	0	;AdrErr
		dc.l	0	;IllInst
		dc.l	0	;DivNull
		dc.l	0	;ChkInt
		
Ex_BusErr		equ	$8		;=	Bus Error
Ex_AdrErr		equ	$C		;=	Address Error
Ex_IllInst		equ	$10		;=	Illegal	Instruction
Ex_DivNull		equ	$14		;=	/0
Ex_ChkInt		equ	$18		;=	CHK(2)
Ex_TrapVInt		equ	$1c		;=	TRAPV
Ex_PrivInt		equ	$20		;=	Privilege Violation
Ex_TrapeInt		equ	$24		;=	Trace Trap
Ex_LinaAInt		equ	$28		;=	Line A Emulator
Ex_LineFInt		equ	$2c		;=	Line F Emulator
Ex_CoprInt        	equ	$30		;=	Coproc.	Protocol
Ex_FromInt		equ	$34		;=	Format Error
Ex_UniInt	        equ	$3c		;=	Uninit. Interrupt
Ex_SpuInt		equ	$60		;=	Spurious Interrupt

Int_Lev1		equ	$64		;=	Level 1 Interrupt (Soft,DiskBlk,TBE)
Int_Lev2		equ	$68             ;             2           (I/O Ports)
Int_Lev3		equ	$6C             ;             3           (Copper,VertB,Blit)
Int_Lev4		equ	$70             ;             4		  (Audio 0-3)
Int_Lev5		equ	$74             ;             5		  (DskSyn,RBF)
Int_Lev6    		equ	$78             ;             6           (Extern)
Int_Lev7		equ	$7c		;	      7		

	cnop	0,4
	