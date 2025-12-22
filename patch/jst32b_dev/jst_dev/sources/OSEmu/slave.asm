;*---------------------------------------------------------------------------
;  :Program.	slave.asm
;  :Contents.	Slave for "xy"
;  :Author.	Wepl
;  :Version.	$Id: slave.asm 1.14 1998/12/15 21:07:08 jah Exp jah $
;  :History.	06.09.98 initial
;		14.12.98 adapted for WHDLoad v8.1
;  :Requires.	-
;  :Copyright.	Public Domain
;  :Language.	68000 Assembler
;  :Translator.	Devpac 3.14 / Barfly 2.9
;  :To Do.
;---------------------------------------------------------------------------*

 IFD BARFLY
	INCDIR	Includes:
	INCLUDE	lvo/exec.i
	INCLUDE	devices/trackdisk.i
	INCLUDE	whdload.i
	OUTPUT	"WArt:xy.Slave"
	BOPT	O+ OG+				;enable optimizing
	BOPT	ODd- ODe-			;disable mul optimizing
	BOPT	w4-				;disable 64k warnings
	SUPER					;disable supervisor warnings
 ELSE
	INCDIR	Include:
	INCLUDE	whdload.i
	OUTPUT	dh1:demos/xy.slave
	OPT	O+ OG+			;enable optimizing
 ENDC

;============================================================================

_base		SLAVE_HEADER			;ws_Security + ws_ID
		dc.w	8			;ws_Version
		dc.w	WHDLF_NoError		;ws_flags
		dc.l	$80000			;ws_BaseMemSize
		dc.l	0			;ws_ExecInstall
		dc.w	Start-_base		;ws_GameLoader
		dc.w	0			;ws_CurrentDir
		dc.w	0			;ws_DontCache
_keydebug	dc.b	0			;ws_keydebug
_keyexit	dc.b	$59			;ws_keyexit = F10
		dc.l	0			;ws_ExpMem

 IFD BARFLY
	DOSCMD	"WDate >T:date"
		dc.b	"$VER: xy.Slave by Wepl "
	INCBIN	"T:date"
		dc.b	0
 ELSE
	dc.b	'$VER: xy HD by Mr.Larmer/Wanted Team - V0.1 (..98)',0
 ENDC
 EVEN

;============================================================================
Start	;	A0 = resident loader
;============================================================================

		lea	_resload(pc),a1
		move.l	a0,(a1)			;save for later use
		move.l	a0,a2			;A2 = resload

	;load the osemu module
		lea	(_OSEmu,pc),a0		;file name
		lea	($400).w,a3		;A3 = OSEmu base address
		move.l	a3,a1			;address
		jsr	(resload_LoadFileDecrunch,a2)

	;init the osemu module
		move.l	a2,a0			;resload
		lea	(_base,pc),a1		;slave structure
		jsr	(a3)

	;switch to user mode
		move.w	#0,sr

	;load the bootblock (do this if neccessary)
		jsr	(_LVODoIO,a6)
		move.l	(IO_DATA,a1),a0

	;call bootblock
		jmp	(12,a0)

;--------------------------------

_resload	dc.l	0		;address of resident loader
_OSEmu		dc.b	'OSEmu.400',0

;============================================================================

	END

