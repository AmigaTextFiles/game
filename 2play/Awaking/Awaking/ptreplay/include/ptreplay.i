
;ptreplay.i -- definition of ptreplay.library structures

	IFND	PTREPLAY_BASE_I
PTREPLAY_BASE_I SET 1

	IFND	EXEC_TYPES_I
	INCLUDE	"exec/types.i"
	ENDC

PTREPLAYNAME MACRO
	Dc.B	"ptreplay.library",0
	ENDM

	STRUCTURE Module,0
	APTR	mod_Name
	;The rest is private for now, but more details may be
	;released later.

	ENDC