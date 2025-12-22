;
; Vector/Matrix operation, assembler version
;
; $Id: vecmat.s,v 1.4 1998/04/09 16:20:45 tfrieden Exp $
; $Revision: 1.4 $
; $Author: tfrieden $
; $Log: vecmat.s,v $
; Revision 1.4  1998/04/09 16:20:45  tfrieden
; Inserted Jyrki`s changes
;
; Revision 1.3  1998/04/01 21:21:09  tfrieden
; Added two more function pointers
;
; Revision 1.1  1998/03/30 02:19:49  tfrieden
; Initial version
;
;

X       equ        0
Y       equ        4
Z       equ        8

		section    code,code

; External references

		xref       _quad_sqrt

; External definitions
		xdef       _vm_vec_avg
		xdef       _vm_vec_dotprod_fpu
		xdef       _vm_vec_dotprod_int
		xdef       _vm_vec_dot3_fpu
		xdef       _vm_vec_dot3_int
		xdef       _vm_vec_mag_fpu
		xdef       _vm_vec_mag_int
*        xdef       _vm_vec_mag_quick
		xdef       _vm_vec_crossprod_fpu
		xdef       _vm_vec_crossprod_int


;       a0 - dest
;       a1 - src0
;       a2 - src1
_vm_vec_avg:
; jxsaarin - tried to make use of free cycles after a memory write
;            do a0/a1/a2 must be not touched?
;            did a bit scheduling and space-optimization, also a bit
;            faster on some CPU's

		move.l  d2,-(a7)    ; save d2
		move.l  (a1)+,d0
		move.l  (a1)+,d1
		move.l  (a1),d2
		add.l   (a2)+,d0
		add.l   (a2)+,d1
		add.l   (a2),d2
		asr.l   #1,d0
		move.l  d0,(a0)+
		asr.l   #1,d1
		move.l  d1,(a0)+
		asr.l   #1,d2
		move.l  d2,(a0)
		move.l  a0,d0
		move.l  (a7)+,d2
		subq.l  #8,d0
		rts

;
;       Dot product
;       Compute x1*x2+y1*y2+z1*z2 / 65536
;
;       a0 - v0
;       a1 - v1
;
; jxsaarin - scheduled, fp2 was to be saved though
;            don't know if faster or not
;            fmove.l fp0,-(a7) move.l (a7)+,d0 faster on 060 than
;            fmove.l fp0,d0, I recall it is better on 040 also!

_vm_vec_dotprod_fpu:
		fmove.x     fp2,-(a7)       ; save fp2
		fmove.l     (a0)+,fp0
		fmove.l     (a0)+,fp1
		fmove.l     (a0),fp2
		fmul.l      (a1)+,fp0
		fmul.l      (a1)+,fp1
		fmul.l      (a1),fp2
		fadd.x      fp2,fp0
		fmove.x     (a7)+,fp2       ; fp2 back
		fadd.x      fp1,fp0
		fmul.d      #1.52587890625e-05,fp0 ; "divide" by 65536.0
		fmove.l     fp0,-(a7)
		move.l      (a7)+,d0        
		rts

_vm_vec_dotprod_int:
; jxsaarin - used postincrement addressing, faster and tighter
;            two moves faster than movem with two regs

		move.l     d2,-(a7)
		move.l     d3,-(a7)
		move.l     (a0)+,d0            ; v0->x
		muls.l     (a1)+,d1:d0         ; first product
		move.l     (a0)+,d2            ; v0->y
		muls.l     (a1)+,d3:d2         ; second product
		add.l      d2,d0               ; add it up
		addx.l     d3,d1
		move.l     (a0),d2             ; v0->z
		muls.l     (a1),d3:d2          ; last product
		add.l      d2,d0               ; add it up
		addx.l     d3,d1
		move.w     d1,d0               ; correct the result
		swap       d0
		move.l     (a7)+,d3
		move.l     (a7)+,d2
		rts


;
;       Dot product, first vector in d0-d2
;
;       d2 - x
;       d3 - y
;       d4 - z
;       a0 - vector
_vm_vec_dot3_fpu:
; jxsaarin - same like before

		fmove.x     fp2,-(a7)
		fmove.l     d2,fp0
		fmove.l     d3,fp1
		fmove.l     d4,fp2
		fmul.l      (a0)+,fp0
		fmul.l      (a0)+,fp1
		fmul.l      (a0),fp2
		fadd.x      fp2,fp0
		fmove.x     (a7)+,fp2       ; fp2 back
		fadd.x      fp1,fp0
		fmul.d      #1.52587890625e-05,fp0 ; "divide" by 65536.0
		fmove.l     fp0,-(a7)
		move.l      (a7)+,d0
		rts

_vm_vec_dot3_int:
; jxsaarin - replaced movem with two moves, same size also!

		move.l     d5,-(a7)
		move.l     d6,-(a7)
		move.l     (a0)+,d0
		muls.l     d2,d1:d0
		move.l     (a0)+,d5
		muls.l     d3,d6:d5
		add.l      d5,d0
		addx.l     d6,d1
		move.l     (a0),d5
		muls.l     d4,d6:d5
		add.l      d5,d0
		addx.l     d6,d1
		move.w     d1,d0
		swap       d0
		move.l     (a7)+,d6
		move.l     (a7)+,d5
		rts

;
;       magnitude of vector
;
;       a0 - vector
_vm_vec_mag_fpu:
		fmove.l    (a0)+,fp0           ; v->x
		fmul.x     fp0,fp0             ; v->x ^ 2
		fmove.l    (a0)+,fp1           ; v->y
		fmul.x     fp1,fp1             ; v->y ^ 2
		fadd.x     fp1,fp0
		fmove.l    (a0),fp1            ; v->z
		fmul.x     fp1,fp1             ; v->z ^ 2
		fadd.x     fp1,fp0
		fsqrt.x    fp0
		fmove.l    fp0,-(a7)
		move.l     (a7)+,d0
		rts

_vm_vec_mag_int:
; jxsaarin - here a assembly version of quad_sqrt should be used
;            is this function used a lot?
;            replaced movem

		move.l     d5,-(a7)
		move.l     d6,-(a7)
		move.l     (a0),d0
		muls.l     d2,d1:d0
		move.l     4(a0),d5
		muls.l     d3,d6:d5
		add.l      d5,d0
		addx.l     d6,d1
		move.l     8(a0),d5
		muls.l     d4,d6:d5
		add.l      d5,d0
		addx.l     d6,d1
		move.l     d1,-(sp)
		move.l     d0,-(sp)
		jsr        _quad_sqrt
		add.l      #8,sp
		move.l     (a7)+,d6
		move.l     (a7)+,d5
		rts


;
;       fast version of magnitude
;
;       a0 - vector
; jxsaarin - used exg instead of three moves!
;            freed d3
;            some kind of distance approximation I see?
;            used a1 to store d2

_vm_vec_mag_quick:
		move.l     d2,a1               ; save d2

		move.l     (a0)+,d0            ; get x and set N bit
		bpl        vvmq_skip1          ; it`s positive, no neg needed
		neg.l      d0
vvmq_skip1:
		move.l     (a0)+,d1            ; get y
		bpl        vvmq_skip2
		neg.l      d1
vvmq_skip2:
		move.l     (a0),d2             ; get z
		bpl        vvmq_skip3
		neg.l      d2
vvmq_skip3:
		cmp.l      d0,d1               ; a < b
		bgt        vvmq_skip4          ; no

		exg        d0,d1

;       move.l     d0,d3               ; yes, swap
;       move.l     d1,d0
;       move.l     d3,d1
vvmq_skip4:
		cmp.l      d1,d2               ; b < c
		bgt        vvmq_skip5          ; no

		exg        d1,d2

;       move.l     d1,d3               ; yes, swap
;       move.l     d2,d1
;       move.l     d3,d2
		cmp.l      d0,d1               ; test a < b again
		bgt        vvmq_skip5
		
		exg        d0,d1

;       move.l     d0,d3
;       move.l     d1,d0
;       move.l     d3,d1
vvmq_skip5:
		asr.l      #2,d1               ; b >> 2
		asr.l      #3,d2               ; c >> 3
		add.l      d1,d0               ; a + bc
		add.l      d2,d1               ; bc = b>>2 + c>>3
		asr.l      #1,d1               ; bc >> 1
		add.l      d1,d0

		move.l     a1,d2               ; d2 back
		rts



;
;       Crossproduct
;
;       a0 - dest
;       a1 - src0
;       a2 - src1
_vm_vec_crossprod_fpu:
		fmove.l    4(a1),fp0           ; src0->y
		fmul.l     8(a2),fp0           ; * src1->z
		fmove.l    8(a1),fp1           ; src0->z
		fmul.l     4(a2),fp1           ; src1->y
		fsub.x     fp1,fp0             ; accumulate
		fmul.d     #1.52587890625e-05,fp0 ; "divide" by 65536.0
		fmove.l    fp0,(a0)            ; store in dest->x

		fmove.l    8(a1),fp0           ; src0->z
		fmul.l     (a2),fp0            ; * src1->x
		fmove.l    (a1),fp1            ; src0->x
		fmul.l     8(a2),fp1           ; src1->z
		fsub.x     fp1,fp0             ; accumulate
		fmul.d     #1.52587890625e-05,fp0 ; "divide" by 65536.0
		fmove.l    fp0,4(a0)           ; store in dest->y

		fmove.l    0(a1),fp0           ; src0->x
		fmul.l     4(a2),fp0           ; * src1->y
		fmove.l    4(a1),fp1           ; src0->y
		fmul.l     0(a2),fp1           ; src1->x
		fsub.x     fp1,fp0             ; accumulate
		fmul.d     #1.52587890625e-05,fp0 ; "divide" by 65536.0
		fmove.l    fp0,8(a0)           ; store in dest->z

		move.l     a0,d0               ; return value
		rts

_vm_vec_crossprod_int:
; jxsaarin - movem with 2 moves
;            eliminated neg.l's with sub/subx
;            not much but hey, every small optimization
;            counts when there are enough of them.. ;)

		move.l     d2,-(a7)
		move.l     d3,-(a7)

		move.l     Y(a1),d0            ; src0->y
		move.l     Z(a2),d1            ; src1->z
		muls.l     d1,d1:d0
		move.l     Z(a1),d2            ; src0->z
		move.l     Y(a2),d3            ; src1->y
		muls.l     d2,d2:d3
		sub.l      d2,d0
		subx.l     d3,d1
		move.w     d1,d0
		swap       d0
		move.l     d0,X(a0)

		move.l     Z(a1),d0            ; src0->z
		move.l     X(a2),d1            ; src1->x
		muls.l     d1,d1:d0
		move.l     X(a1),d2            ; src0->x
		move.l     Z(a2),d3            ; src1->z
		muls.l     d2,d2:d3
		sub.l      d2,d0
		subx.l     d3,d1
		move.w     d1,d0
		swap       d0
		move.l     d0,Y(a0)

		move.l     X(a1),d0            ; src0->x
		move.l     Y(a2),d1            ; src1->y
		muls.l     d1,d1:d0
		move.l     Y(a1),d2            ; src0->y
		move.l     X(a2),d3            ; src1->x
		muls.l     d2,d2:d3
		sub.l      d2,d0
		subx.l     d3,d1
		move.w     d1,d0
		swap       d0
		move.l     d0,Z(a0)

		move.l     a0,d0               ; return value

		move.l     (a7)+,d3
		move.l     (a7)+,d2
		rts

		end
