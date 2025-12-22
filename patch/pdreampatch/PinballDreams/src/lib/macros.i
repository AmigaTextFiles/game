
	include	"/lib/utils_macros.i"

GO_SUPERVISOR:MACRO
	move.l	_SysBase,A6
	JSRLIB	SuperState
	move.l	D0,_userstack
	ENDM

SAVE_OSDATA:MACRO
	move.l	D0,-(sp)
	move.l	#\1,D0
	JSRABS	SaveOSData
	move.l	(sp)+,D0
	ENDM

GETUSRADDR:MACRO
	move.l	_user_pbuffer(PC),D0
	add.l	#\1,D0
	sub.l	#_UserPatchRoutines,D0
	ENDM

PATCHABSJMP:MACRO
	movem.l	D0/A1,-(sp)
	lea	\1,A1
	move.w	#$4EF9,(A1)+
	move.l	#\2,(A1)+
	movem.l	(sp)+,D0/A1
	ENDM

PATCHABSJSR:MACRO
	movem.l	D0/A1,-(sp)
	lea	\1,A1
	move.w	#$4EB9,(A1)+
	move.l	#\2,(A1)+
	movem.l	(sp)+,D0/A1
	ENDM


PATCHUSRJMP:MACRO
	movem.l	D0/A1,-(sp)
	GETUSRADDR	\2
	lea	\1,A1
	move.w	#$4EF9,(A1)+
	move.l	D0,(A1)+
	movem.l	(sp)+,D0/A1
	ENDM

PATCHUSRJSR:MACRO
	movem.l	D0/A1,-(sp)
	GETUSRADDR	\2
	lea	\1,A1
	move.w	#$4EB9,(A1)+
	move.l	D0,(A1)+
	movem.l	(sp)+,D0/A1
	ENDM

PATCHGENJMP:MACRO
	movem.l	D0/A1,-(sp)
	GETGENADDR	\2
	lea	\1,A1
	move.w	#$4EF9,(A1)+
	move.l	D0,(A1)+
	movem.l	(sp)+,D0/A1
	ENDM

PATCHGENJSR:MACRO
	movem.l	D0/A1,-(sp)
	GETGENADDR	\2
	lea	\1,A1
	move.w	#$4EB9,(A1)+
	move.l	D0,(A1)+
	movem.l	(sp)+,D0/A1
	ENDM


RELOCATE:MACRO
	movem.l	D0/A0/A1,-(sp)
	GETUSRADDR	\1
	move.l	D0,A0
	move.l	#\1,A1		; to be sure to get absolute address.
	move.l	(A1),(A0)	; relocation in the usr patch routines zone.
	movem.l	(sp)+,D0/A0/A1
	ENDM

HD_PARAMS:MACRO
fname:
	dc.b	\1
nname:
	dc.b	"0",0
	XDEF	_conname
_conname:
	dc.b	\2,0
	cnop	0,4
	XDEF	_fname_val
_fname_val:
	dc.l	fname
	XDEF	_nname_val
_nname_val:
	dc.l	nname
	XDEF	_filesize
_filesize:
	dc.l	\3
	XDEF	_nbdisks
_nbdisks:
	dc.l	\4
	ENDM
