_SysBase        equ     4

OPENLIB: macro
	move.l	(_SysBase).w,a6
        moveq   #0,d0
	lea     \1,a1
	jsr     _LVOOldOpenLibrary(A6)
	endm

CLOSELIB: macro
	MOVE.L	(_SysBase).w,a6
	MOVE.L  \1,a1
	jsr     _LVOCloseLibrary(A6)
	ENDM

LIBCALL: MACRO
	MOVE.L	\2,A6
	JSR	_LVO\1(A6)
	ENDM

DOSCALL: MACRO
	LIBCALL	\1,_DOSBase
	ENDM

EXECCALL: MACRO
	LIBCALL \1,_SysBase
	ENDM

GRAFCALL: MACRO
        LIBCALL \1,_GfxBase
        ENDM

INTCALL: MACRO
	LIBCALL \1,_IntuitionBase
	ENDM
