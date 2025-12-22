; *** Pinball Dreams Turbo Board Launcher
; *** Written by Jean-François Fabre in 1997

; *** For more infomation about this source code
; *** and the HDStartup technology, see my web site

; *** http://www.ensica.fr/~jffabre/patches.html
; *** e-mail: jffabre@ensica.fr


	include	"/lib/libs.i"
	include	"/lib/macros.i"
	include	"/lib/refs.i"

; *** This game is a cool game, but it's programmed
; *** like shit (but I could not do such a game)

_loader:
	move.l	#$80000,D0
	JSRABS	AllocExtMem
	move.l	D0,ExtBase
	beq	MemErr

	Mac_printf	"Pinball dreams turbo board patch"
	Mac_printf	"Programmed by Jean-François Fabre © 1997"
	NEWLINE
	Mac_printf	"Please insert Pinball Dreams Disk 1 in DF0:"
	Mac_printf	"And click the left mouse button"

	JSRABS	TransfRoutines

	WAIT_LMB

	moveq.l	#0,D0
	move.l	#CACRF_CopyBack,D1
	JSRABS	Degrade

	GO_SUPERVISOR
	SAVE_OSDATA	$80000
	move.w	#$2700,SR

	; **** boot stuff and patch


	lea	boot,A0
	lea	$100.W,A1

copy$
	move.l	(A0)+,(A1)+
	cmp.l	#$2900,A1
	bne.b	copy$

	; *** replaces memory check

	move.l	ExtBase(pc),$3B4.W
	move.l	#$60000076,$162.W

	; *** installs level 6 interrupt

	GETUSRADDR	PatchIntCIAB
	move.l	D0,$78.W

	; *** a patch

	PATCHUSRJSR	$262.W,Patch262

	; *** flush caches

	JSRGEN	FlushCachesHard

	nop
	nop
	jmp	$100.W		; GO GO GO
	nop
	nop


MemErr:
	Mac_printf	"** Not enough mem to run Pinball Dreams!"
	JMPABS	CloseAll

; *** routines relocated on the top of the memory, either in chip or fast

_UserPatchRoutines:

; *** on 68060, this interrupt occurs at least once
; *** We have to trap it, and acknowledge

PatchIntCIAB:
	move.w	#$2000,intreq+$DFF000
	btst.b	#0,$BFDD00		; acknowledge CIA-B Timer A interrupt
	RTE

Patch1372:

	; *** Removes a check causing incompatibility
	; *** with 68060 boards (possibly 68040 too)

	move.l	A0,-(sp)
	move.l	ExtBase(pc),A0
	add.l	#$C968,A0
	cmp.l	#'FUCK',2(A0)
	bne	nopatch0$

	move.l	#$4E754E75,(A0)	
	JSRGEN	GoECS			; normal sprite size

nopatch0$
	move.l	(sp)+,A0

	; *** keyboard interrupt (menu only, needs 1MB of fast memory)

	cmp.l	#$423900BF,$1F4E.W
	bne	nopatch2$
	PATCHUSRJSR	$1F4E.W,KbInt
nopatch2$

	MOVEA.L	$7C000,A0		;02: 20790007C000
	MOVEA.L	$257A.W,A1		;08: 2278257A
LAB_0000:
	MOVE.B	(A0)+,(A1)+		;0C: 12D8
	SUBQ.L	#1,$257E.W		;0E: 53B8257E
	BNE.S	LAB_0000		;12: 66F8
	MOVE.L	A0,$7C000

	PATCHUSRJMP	$1372.W,Patch1372	; re installs the patch

	JSRGEN	FlushCachesHard
	RTS

Patch262:
	move.l	#'PD00',D0
	PATCHUSRJMP	$1372.W,Patch1372
	JSRGEN	FlushCachesHard
	rts

KbInt:
	move.l	D0,-(sp)
	not.b	D0
	ror.b	#1,D0
	cmp.b	#$45,D0		; ESC from the menu
	bne	noquit$
	JSRGEN	InGameExit
noquit$:
	move.l	(sp)+,D0
	rts


_user_pbuffer:
	dc.l	0
_general_pbuffer:
	dc.l	0
ExtBase:
	dc.l	0
_EndUserPatchRoutines:

	; ** not used, but necessary for the link

	HD_PARAMS	"","CON:20/20/400/250/Pinball Dreams Patch",0,1

	; ** the startup program I had to rip on a 68020
	; ** I could not do any other way, sorry...
boot:
	incbin	"pdmain.bin"
end_boot:
