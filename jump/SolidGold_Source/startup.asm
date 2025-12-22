*
* Startup/cleanup code.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* startup(a0=bootLogoColors)
* d0=returnCode = cleanup()
*
* BootLogoColors (16 entries)
*

	include	"custom.i"


; from linker
	xref	_LinkerDB

; from memory.asm
	xref	initmem
	xref	exitmem

; from os.asm
	xref	takeover
	xref	restore

; from init.asm
	xref	init
	xref	restorehw

; from input.asm
	xref	exitKeyboard

; from main.asm
	xref	makeseed
	xref	panic

; from music.asm
	xref	exitMusic



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	startup
startup:
; This is the program's entry point after being loaded by the boot block.
; As soon as the OS is disabled all sub routines can expect to find the
; custom chip base address in A6 and the small data base in A4.
; a0 = Boot logo color table
; -> d0 = dos return code

	lea	_LinkerDB,a4
	move.l	sp,InitialSP(a4)

	ifd	BOOTLOGO
	move.l	a0,BootLogoColors(a4)
	endif

	bsr	makeseed
	bsr	initmem		; get all Chip RAM

	bsr	takeover	; take over the hardware from the OS
	move.l	d0,d7
	bne	exit

	; initialize hardware and call main function in supervisor mode
	bsr	init


;---------------------------------------------------------------------------
	xdef	cleanup
cleanup:
; Exit the program from any point back into the OS.
; d0 = DOS return code

	lea	CUSTOM,a6
	lea	_LinkerDB,a4

	move.l	InitialSP(a4),sp
	move.l	d0,d7

	bsr	exitMusic
	bsr	exitKeyboard
	bsr	restorehw
	bsr	restore			; restore the OS
exit:
	bsr	exitmem			; free Chip RAM

	ifd	KILLOS
	; There is nothing we could return to. Panic.
	move.w	#$ffa,d0
	bra	panic

	else

	move.l	d7,d0
	rts
	endif	; KILLOS



	section	__MERGED,bss


InitialSP:
	ds.l	1

	ifd	BOOTLOGO
	xdef	BootLogoColors
BootLogoColors:
	ds.l	1
	endif	; BOOTLOGO
