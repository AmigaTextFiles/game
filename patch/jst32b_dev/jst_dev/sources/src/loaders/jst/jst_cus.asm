
adkcon_off = $6
dmacon_off = $4
intena_off = $2
intreq_off = $0

; *** Save readable custom registers
; *** in the custom regs system buffer

RelFun_SaveCustomRegs:
	move.l	A1,-(sp)
	lea	Var_customregs(PC),A1
	bsr	GetCustomRegs
	move.l	(sp)+,A1
	rts

; *** Store custom registers in the given buffer
; in: A1: buffer

GetCustomRegs:
	STORE_REGS
	lea	$DFF000,A5
	move.l	A1,A4
	MOVE.W	intreqr(A5),(intreq_off,A4)	; and intreq of the running game
	ORI.W	#$8000,(intreq_off,A4)
	MOVE.W	intenar(A5),(intena_off,A4)	; saves the old values of intena
	ORI.W	#$8000,(intena_off,A4)
	MOVE.W	dmaconr(A5),(dmacon_off,A4)	; and dmacon too
	ORI.W	#$8000,(dmacon_off,A4)
	MOVE.W	adkconr(A5),(adkcon_off,A4)	; and akdcon too
	ORI.W	#$8000,(adkcon_off,A4)
	RESTORE_REGS
	rts


; *** Sets custom registers from given buffer
; in: A1: buffer

SetCustomRegs:
	STORE_REGS
	
	; remove old values

	bsr	RelFun_FreezeAll

	; set new values

	lea	$DFF000,A5		
	move.l	A1,A4
	MOVE.W	(intreq_off,A4),intreq(A5)
	MOVE.W	(intena_off,A4),intena(A5)
	MOVE.W	(dmacon_off,A4),dmacon(A5)
	MOVE.W	(adkcon_off,A4),adkcon(A5)
	RESTORE_REGS
	rts

; *** Restore previously saved custom registers

RelFun_RestoreCustomRegs:
	move.l	A1,-(sp)
	lea	Var_customregs(PC),A1
	bsr	SetCustomRegs
	move.l	(sp)+,A1
	rts

; *** Restore previously saved custom registers, but without DMA
; *** to avoid graphics corruption (on Shadow Fighter, for instance)

RelFun_RestoreCustomNoDMA:
	movem.l	D0/A1/A2,-(sp)
	lea	Var_customregs(PC),A1
	lea	Var_nodispregs(PC),A2
	move.w	(A1)+,(A2)+	; copy intreq
	move.w	(A1)+,(A2)+	; copy intena
	move.w	(A1)+,D0	; dmacon
;	and.w	#$FC70,D0	; all but bitplane, copper and sound things :-)
	moveq.l	#0,D0		; finally, no DMA at all
	move.w	D0,(A2)+
	move.w	(A1)+,(A2)+	; copy adkcon
	
	lea	Var_nodispregs(PC),A1
	bsr	SetCustomRegs
	movem.l	(sp)+,D0/A1/A2
	rts

; *** CIA-A/B code (store/restore)

; *** timer storage offsets

TimerAA = $0
TimerAB = $5
TimerBA = $A
TimerBB = $F

CR = 0
THI = 1
TLO = 2
LHI = 3
LLO = 4


; *** Save CIA registers in a buffer
; in: A1: buffer

GetCiaRegs:
	STORE_REGS
	LEA	$BFE001,A2
	lea	$BFD000,a4

	move.l	A1,A5		; buffer for timers, base

	lea	$1E01(a4),a0
	lea	$1401(a4),a1
	lea	$1501(a4),a2
	lea	TimerAA(A5),A3	; offset
	bsr	GetTimer

	lea	$1F01(a4),a0
	lea	$1601(a4),a1
	lea     $1701(a4),a2
	lea	TimerAB(A5),A3	; offset
	bsr	GetTimer

	lea	$E00(a4),a0
	lea	$400(a4),a1
	lea	$500(a4),a2
	lea	TimerBA(A5),A3	; offset
	bsr	GetTimer

	lea	$F00(a4),a0
	lea	$600(a4),a1
	lea	$700(a4),a2
	lea	TimerBB(A5),A3	; offset
	bsr	GetTimer

	clr.b	$1E01(a4)
	clr.b	$1F01(a4)
	clr.b	$E00(a4)
	clr.b	$F00(a4)

	RESTORE_REGS
	rts

; *** Restore CIA regs from a buffer
; in: A1: buffer

SetCiaRegs:
	STORE_REGS
	lea     $BFD000,a4
	move.l	A1,A5		; timer base

	lea     $1E01(a4),a0
	lea     $1401(a4),a1
	lea     $1501(a4),a2
	lea     TimerAA(A5),a3
	bsr	SetTimer

	lea     $1F01(a4),a0
	lea     $1601(a4),a1
	lea     $1701(a4),a2
	lea     TimerAB(A5),a3
	bsr   SetTimer

	lea     $E00(a4),a0
	lea     $400(a4),a1
	lea     $500(a4),a2
	lea	TimerBA(A5),a3
	bsr   SetTimer

	lea     $F00(a4),a0
	lea     $600(a4),a1
	lea     $700(a4),a2
	lea	TimerBB(A5),a3
	bsr   SetTimer
	RESTORE_REGS
	rts


; *** get timer values
; *** thanks to Alain Malek for the source code

GetTimer:
	move.b  (a0),CR(a3)             ;store state of control register
	bclr    #0,(a0)                 ;stop the timer
	nop
	move.b  (a1),TLO(a3)            ;store the actual timer values
	move.b  (a2),THI(a3)
	bclr    #3,(a0)                 ;set continuous mode
	nop
	bclr    #1,(a0)                 ;clear PB operation mode
	nop
	bset    #4,(a0)                 ;force load latch->timer
	nop
	move.b  (a1),LLO(a3)            ;store latch values
	move.b  (a2),LHI(a3)

	bsr	SetTimer

	rts

; *** set timer values
; *** thanks to Alain Malek for the source code

SetTimer:
	clr.b   CR(a0)                  ;clear all CR values
	nop
	move.b  TLO(a3),(a1)            ;set latch to original timer value
	move.b  THI(a3),(a2)
	nop
	bset    #4,(a0)                 ;move latch->timer
	nop
	move.b  LLO(a3),(a1)            ;set latch to original latch value
	move.b  LHI(a3),(a2)
	nop
	move.b  CR(a3),(a0)             ;restore the timer's work
	rts


; *** Save CIA registers

RelFun_SaveCIARegs
	movem.l	D0/A1,-(sp)
	lea	Var_ciaregs(pc),A1
	bsr	GetCiaRegs
	bsr	GetLed
	movem.l	(sp)+,D0/A1
	rts


GetLed:
	movem.l	D0/A1,-(sp)
	lea	Var_led(pc),A1
	move.b	$BFE001,D0	; CIAPRA
	lsr.b	#1,D0
	and.b	#1,D0
	move.w	D0,(A1)		; store LED value

	movem.l	(sp)+,D0/A1
	rts

; *** Restore CIA registers

RelFun_RestoreCIARegs
	movem.l	D0/A1,-(sp)
	lea	Var_ciaregs(pc),A1
	bsr	SetCiaRegs
	bsr	ResetCIAs
	movem.l	(sp)+,A1/D0
	rts

SetLed:
	movem.l	D0/A1,-(sp)

	; ** reset LED/Filter
	
	move.w	Var_led(pc),D0
	bne	1$
	bclr.b	#1,$BFE001
	bra	2$
1$
	bset.b	#1,$BFE001
2$
	movem.l	(sp)+,A1/D0
	rts


; *** Reset the CIAs for the keyboard
; *** Thanks to Alain Malek for this piece of code

	RESET_CIA_CODE


; *** Freeze DMA and interrupts

; be sure to save the custom registers before
; with _SaveCustomRegs

RelFun_FreezeAll:
	MOVE.W	#$7FFF,intena+$DFF000
	MOVE.W	#$7FFF,dmacon+$DFF000
	MOVE.W	#$7FFF,intreq+$DFF000
	MOVE.W	#$7FFF,adkcon+$DFF000
	rts

start_snapshot:
	dc.l	0	; snapshot sysdata version here
reserved_snapshot:
	dc.l	0	; snapshot reserved for future use

datastream:

; do not change anything below (format for RawDoFmt)

Var_pc:
	dc.l	0
Var_offset:
	dc.l	0
Var_reloc_extbuf:
	dc.l	0	; copy of reloc_extbuf
Var_reloc_24bitbuf:
	dc.l	0	; copy of reloc_24bit buf
Var_sr:
	dc.w	0
Var_gamecustomregs:
Var_intreq:
	dc.w	0	; intreq
Var_intena:
	dc.w	0	; intena
Var_dmacon:
	dc.w	0	; dmacon
Var_adkcon:
	dc.w	0	; adkcon

Var_gameciaregs:
	blk.l	6,0

Var_customregs:
	dc.w	0	; intreq
	dc.w	0	; intena
	dc.w	0	; dmacon
	dc.w	0	; adkcon

	; now the following order has got no importance for RawDoFmt
	; BUT will change version of the snapshot file!

Var_ciaregs:
	blk.l	6,0
Var_stack:
	dc.l	0
Var_cpuregs:
	blk.l	16,0

Var_nodispregs:
	dc.w	0	; intreq
	dc.w	0	; intena
	dc.w	0	; dmacon
	dc.w	0	; adkcon

Var_led:
	dc.w	0	; LED/ audio filter

end_snapshot:
	dc.l	0	; safety
