;***************************************************************
; The user copper struct
;***************************************************************

	rsreset
COPPER_LIST rs.l  1  ;pointer to list of copper instructions
COPPER_CTRL rs.l  1  ;pointer to controlling struct for user copper lists (UCopList)
                     ;This is NULL for 1st call & alloced by copper routines
                     ;Additional calls to copper routines use same struct
COPPER_DISPLAY rs.l  1  ;ptr to controlling display struct.  Either
				;an Intuition Screen struct or a ViewPort struct
COPPER_SIZEOF rs.b   0  ;size of copper struct

; user copper instructions:

UC_WAIT		EQU	1	;wait for display beam position (y,x)
UC_MOVE		EQU	2	;move data to a hardware register (register,data)
UC_NOSPRITES	EQU	3	;turn sprites off
UC_SPRITES	EQU	4	;turn sprites back on
UC_SETCOLOR	EQU	5	;set a color register (color number,color value)
UC_END		EQU	0	;marks end of user copper list.  MUST be last command in table

; copper setup flags

UCFLAGS_INTUITION	EQU	$01	;attach copper list to Intuition screen
UCFLAGS_VIEWPORT	EQU	$02	;attach copper list to custom ViewPort

