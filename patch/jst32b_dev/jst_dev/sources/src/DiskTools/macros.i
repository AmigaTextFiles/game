; ** currently used disk sizes

STD_DISK_SIZE = 901120	; standard dos copiable disks
B12_DISK_SIZE = 970752	; 12 sectored 79 tracks disks, dos bootblock
S12_DISK_SIZE = 983040	; 12 sectored 79 tracks disks, dos bootblock

; ** joypad button definitions (for JoyButtonsState)

; ** masks

AFF_FIRE1 = $20		; red joypad button
AFF_START = $01		; start/pause joypad button
AFF_FIRE2 = $40		; blue joypad button
AFF_FIRE4 = $08		; green joypad button
AFF_FIRE3 = $10		; yellow joypad button
AFF_FORWD = $04		; forward joypad key
AFF_BACWD = $02		; back joypad key

; ** bits

AFB_START = $0		; start/pause joypad button
AFB_BACWD = $1		; back joypad key
AFB_FORWD = $2		; forward joypad key
AFB_FIRE4 = $3		; green joypad button
AFB_FIRE3 = $4		; yellow joypad button
AFB_FIRE1 = $5		; red joypad button
AFB_FIRE2 = $6		; blue joypad button


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
	move.l	_general_pbuffer,D0	; in the user code
	add.l	#\1,D0
	sub.l	#_GeneralPatchRoutines,D0
	move.l	D0,A0
	move.l	#\1,A1		; to be sure to get absolute address.
	move.l	(A1),(A0)	; relocation in the general patch routines zone.
	movem.l	(sp)+,D0/A0/A1
	ENDM
