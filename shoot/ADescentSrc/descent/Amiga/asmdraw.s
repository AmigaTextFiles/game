;
; Some assemblerized drawing routines
;

TRANSP  equ        255                 ; Transparency color

		section data,data
		xref _BitValues

		section code,code
;
; _virge_repw: Fill memory with word
;
; a0 : Start address
; d0 : number of words to fill
; d1 : word to load
		xdef       _virge_repw
_virge_repw:
		subq       #1,d0
_virge_repw_1:
		move.w     d1,(a0)+
		dbra       d0,_virge_repw_1
		rts

;
; _BlitV3DTriangle
;
; Calls V3D_BlitV3DTriangle in cgx3dvirgin.library
;
		xdef _BlitV3DTriangle
_BlitV3DTriangle:
		jsr        -$A8(a6)
		rts

;
; _CopyBuff
;
; Yoda: A drawing routine this is not
; Jedi: I'm just to lazy to start a new file
; Yoda: Bad behavior this is for a Jedi Knight.
; Jedi: Shut up.
;
; Copies to/from Sana2 buffer
; follows copy convention rules
;
; a0 - Where to copy to
; a1 - Where to copy from
; d0 - number of bytes to copy
;
; might be optimized by unrolling and/or moving longwords if possible
;
		xdef _CopyBuff

_CopyBuff:
		subq       #1,d0
1$      move.b     (a1)+,(a0)+
		dbra       d0,1$
		rts

		end
