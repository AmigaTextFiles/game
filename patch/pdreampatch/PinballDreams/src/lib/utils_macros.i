STORE_REGS: MACRO
	movem.l	D0-D7/A0-A6,-(A7)
	ENDM

RESTORE_REGS: MACRO
	movem.l	(A7)+,D0-D7/A0-A6
	ENDM

JSRGEN:MACRO
	move.l	A5,-(sp)
	move.l	_general_pbuffer(PC),A5
	add.l	#_\1,A5
	sub.l	#_GeneralPatchRoutines,A5
	JSR	(A5)
	move.l	(sp)+,A5
	ENDM

JMPGEN:MACRO
	move.l	_general_pbuffer(PC),A5
	add.l	#_\1,A5
	sub.l	#_GeneralPatchRoutines,A5
	JMP	(A5)
	ENDM

GETGENADDR:MACRO
	move.l	_general_pbuffer(PC),D0
	add.l	#_\1,D0
	sub.l	#_GeneralPatchRoutines,D0
	ENDM

WAIT_LMB: MACRO
wl\@
	btst	#6,$BFE001
	bne	wl\@
	ENDM

; ******* Macro Printf ********
; Mac_printf "text"   -> text + linefeed
; Mac_printf "text",*any argument* -> text without linefeed

Mac_printf: MACRO
	move.l	A1,-(A7)
	lea	text\@$(PC),A1
	JSRABS	Display
	bra	ftext\@$
text\@$
	dc.b	\1
	IFLE	NARG-1
	dc.b	10,13
	ENDC
	dc.b	0
	even
ftext\@$
	move.l	(A7)+,A1
	ENDM

PUTS: MACRO
	move.l	A1,-(A7)
	move.l	\1,A1
	JSRABS	Display
	move.l	(A7)+,A1
	ENDM

NEWLINE: MACRO
	move.l	A1,-(A7)
	lea	text\@$(PC),A1
	JSRABS	Display
	bra	ftext\@$
text\@$
	dc.b	10,13,0
	even
ftext\@$
	move.l	(A7)+,A1
	ENDM



JSRABS:MACRO
	jsr	_\1
	ENDM

JMPABS:MACRO
	jmp	_\1
	ENDM

STOP_SOUND:MACRO
	move.l	A5,-(sp)
	lea	$DFF000,A5
	move.w	#$0000,aud0+ac_len(A5)
	move.w	#$0000,aud1+ac_len(A5)
	move.w	#$0000,aud2+ac_len(A5)
	move.w	#$0000,aud3+ac_len(A5)		; shhhhht

	move.w	#$0000,aud0+ac_vol(A5)
	move.w	#$0000,aud1+ac_vol(A5)
	move.w	#$0000,aud2+ac_vol(A5)
	move.w	#$0000,aud3+ac_vol(A5)		; shhhhht
	move.l	(sp)+,A5
	ENDM

RELOCATE_GEN:MACRO
	movem.l	D0/A0/A1,-(sp)
	move.l	_general_pbuffer(PC),D0
	add.l	#\1,D0
	sub.l	#_GeneralPatchRoutines,D0
	move.l	D0,A0
	move.l	#\1,A1		; to be sure to get absolute address.
	move.l	(A1),(A0)	; relocation in the general patch routines zone.
	movem.l	(sp)+,D0/A0/A1
	ENDM
