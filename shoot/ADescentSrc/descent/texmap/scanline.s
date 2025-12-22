;
; scanline texture mapper
;
; $Revision: 1.4 $
; $Author: nobody $
; $Date: 1998/09/26 15:13:28 $
;
; $Log: scanline.s,v $
; Revision 1.4  1998/09/26 15:13:28  nobody
; Added Warp3D support
;
; Revision 1.3  1998/04/09 16:20:11  tfrieden
; Inserted Jyrki`s changes
;
; Revision 1.2  1998/03/29 21:24:08  tfrieden
; Scanliner now lit/unlit transparent/opaque
;
; Revision 1.1  1998/03/25 22:10:34  tfrieden
; Initial import
;
;

        section    data,data
        xref _gr_fade_table

        section    code,code
        xdef _asm_tmap_scanline_linear_nolight
        xdef _asm_tmap_scanline_linear_nolight_t
        xdef _asm_tmap_scanline_linear
        xdef _asm_tmap_scanline_linear_t


;
; linear texture mapper, non-transparent and tranparent
; Non-lighting versions
;
; Registers:
;       d0 - U (16:16)
;       d1 - V (16:16)
;       d2 - dU/dX (16:16)
;       d3 - dV/dX (16:16)
;       d7 - loop counter
;       a0 - texture map pointer
;       a1 - destination buffer
;
; jxsaarin - first try to speed up

_asm_tmap_scanline_linear_nolight
        move.l      d4,-(a7)
        move.l      d5,-(a7)
        move.l      d6,-(a7)

        move.l      #16,d6          ; for long shifts

tsln_inner_loop:
        move.l      d0,d4
        move.l      d1,d5
        ror.l       d6,d4
        ror.l       d6,d5
        and.w       #63,d4
        and.w       #63*64,d5
        add.l       d2,d0           ; u += du
        or.w        d5,d4           ; build offset
        add.l       d3,d1           ; v += dv
        move.b      (a0,d4.w),(a1)+
        dbra        d7,tsln_inner_loop

        move.l      (a7)+,d6
        move.l      (a7)+,d5
        move.l      (a7)+,d4
        rts

; jxsaarin - like earlier routine but with transparency

_asm_tmap_scanline_linear_nolight_t
        move.l      d4,-(a7)
        move.l      d5,-(a7)
        move.l      d6,-(a7)

        move.l      #16,d6          ; for long shifts

tslnt_inner_loop:
        move.l      d0,d4
        move.l      d1,d5
        ror.l       d6,d4
        ror.l       d6,d5
        and.w       #63,d4
        and.w       #63*64,d5
        add.l       d2,d0           ; u += du
        or.w        d5,d4           ; build offset
        add.l       d3,d1           ; v += dv
        move.b      (a0,d4.w),d4
        cmp.b       #255,d4
        beq.s       .transp
        move.b      d4,(a1)
.transp
        addq        #1,a1
        dbra        d7,tslnt_inner_loop

        move.l      (a7)+,d6
        move.l      (a7)+,d5
        move.l      (a7)+,d4
        rts


;
; linear texture mapper, non-transparent and tranparent
; Lighting with linear shading
;
; Registers:
;       d0 - U (16:16)
;       d1 - V (16:16)
;       d2 - L (16:16)
;       a2 - dU/dX (16:16)
;       a3 - dV/dX (16:16)
;       a4 - dL/dX (16:16)
;       d7 - loop counter
;       a0 - texture map pointer
;       a1 - destination buffer
;       a6 - fade table pointer
;

_asm_tmap_scanline_linear
        cmp.l      #0,36(a0)           ; Check for this stupid 0-runs
        bne        tsl_start           ; We`ve got somethin to do....
        rts

tsl_start:
        movem.l    d0-d7/a0-a6,-(sp)

        moveq      #16,d6              ; Setup d6 for long shift
        moveq      #0,d4               ; Clear working registers to allow
        moveq      #0,d5               ; byte/word access
        moveq      #0,d3

        move.l     0(a0),a1            ; Load destination pointer
        move.l     8(a0),a6            ; Load fade table pointer
        move.l     12(a0),d0           ; Load U
        move.l     16(a0),d1           ; Load V
        move.l     20(a0),d2           ; Load L
        move.l     24(a0),a2           ; Load dU/dX
        move.l     28(a0),a3           ; Load dV/dX
        move.l     32(a0),a4           ; Load dL/dX
        move.l     36(a0),d7           ; Load span counter
        move.l     4(a0),a0            ; Load texture map pointer

tsl_inner_loop:
        ror.l      d6,d0               ; Bring integer parts to front
        ror.l      d6,d1
        move.w     d1,d4               ; Build texel offset v
        and.w      #$fc0,d4            ; mask it
        move.w     d0,d5               ; same for u
        and.w      #$3f,d5
        add.w      d5,d4               ; correct displacement
        move.w     d2,d3               ; same for l
        and.w      #$ff00,d3
        ror.l      d6,d0               ; restore
        ror.l      d6,d1
        or.b       (a0,d4.w),d3        ; where to get fade value
        add.l      a2,d0               ; linear advance
        add.l      a3,d1               ; for U and V
        add.l      a4,d2
        move.b     (a6,d3.l),(a1)+     ; move it
        dbra       d7,tsl_inner_loop

        movem.l    (sp)+,d0-d7/a0-a6
        rts


_asm_tmap_scanline_linear_t
        cmp.l      #0,36(a0)           ; Check for these stupid 0-runs
        bne        tslt_start          ; We`ve got something to do....
        rts

tslt_start:
        movem.l    d0-d7/a0-a6,-(sp)

        moveq      #16,d6              ; Setup d6 for long shift
        moveq      #0,d4               ; Clear working registers to allow
        moveq      #0,d5               ; byte/word access
        moveq      #0,d3

        move.l     0(a0),a1            ; Load destination pointer
        move.l     8(a0),a6            ; Load fade table pointer
        move.l     12(a0),d0           ; Load U
        move.l     16(a0),d1           ; Load V
        move.l     20(a0),d2           ; Load L
        move.l     24(a0),a2           ; Load dU/dX
        move.l     28(a0),a3           ; Load dV/dX
        move.l     32(a0),a4           ; Load dL/dX
        move.l     36(a0),d7           ; Load span counter
        move.l     4(a0),a0            ; Load texture map pointer

tslt_inner_loop:
        ror.l      d6,d0               ; Bring integer parts to front
        ror.l      d6,d1
        move.w     d1,d4               ; Build texel offset v
        and.w      #$fc0,d4            ; mask it
        move.w     d0,d5               ; same for u
        and.w      #$3f,d5
        add.w      d5,d4               ; correct displacement
        move.w     d2,d3               ; same for l
        move.b     (a0,d4.w),d4
        cmp.b      #255,d4             ; Check for transparency
        beq        tslt_skip
        and.w      #$ff00,d3
        or.b       d4,d3               ; where to get fade value
        move.b     (a6,d3.l),(a1)      ; move it
tslt_skip
        ror.l      d6,d0               ; restore
        ror.l      d6,d1
        addq       #1,a1
        add.l      a2,d0               ; linear advance
        add.l      a3,d1               ; for U and V
        add.l      a4,d2
        dbra       d7,tslt_inner_loop

        movem.l    (sp)+,d0-d7/a0-a6
        rts

