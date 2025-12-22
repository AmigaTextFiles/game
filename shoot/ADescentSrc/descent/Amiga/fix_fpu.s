*
* 68040/060/881 specific fixpoint stuff
*
* $Revision: 1.5 $
* $Author: tfrieden $
* $Log: fix_fpu.s,v $
* Revision 1.5  1998/03/28 23:05:17  tfrieden
* fixmulaccum replaced by assembler
*
* Revision 1.4  1998/03/27 00:54:20  tfrieden
* Got rid of this monster overkill fixdivquadlong
*
* Revision 1.3  1998/03/25 21:58:48  tfrieden
* Removed the fint stuff (It`s not needed)
*
* Revision 1.2  1998/03/22 15:21:23  tfrieden
* tried to make it SAS/C compilable, but failed so far
*
* Revision 1.1  1998/03/22 01:59:55  tfrieden
* Initial check-in
*

		section    data,data

		xref       _UtilityBase

		section    code,code

		xdef       _fixmul_fpu
		xdef       _fixdiv_fpu
		xdef       _fixmuldiv_fpu
		xdef       _fixdivquadlong_fpu
		xdef       _fixmulaccum_fpu

_fixmul_fpu:
		fmove.l    d0,fp0
		fmul.l     d1,fp0
		fmul.d     #1.52587890625e-05,fp0
		fmove.l    fp0,d0
		rts       

_fixdiv_fpu:
		fmove.d    #65536.0,fp0
		fmul.l     d0,fp0
		fdiv.l     d1,fp0
		fmove.l    fp0,d0
		rts    

_fixmuldiv_fpu:
		fmove.l    d1,fp0
		fmul.l     d0,fp0
		fdiv.l     d2,fp0
		fmove.l    fp0,d0
		rts

_fixdivquadlong_fpu:
		move.l     d7,-(sp)
		move.l     d0,d7               ; copy qlow (unsigned)
		lsr.l      #1,d7               ; shift qlow to divide by 2
		fmove.l    d7,fp0              ; copy to fp0
		fadd.l     d7,fp0              ; double it again (eventually)
		moveq      #1,d7               ; Bit mask for odd/even test
		and.l      d7,d0               ; mask it
		fadd.l     d0,fp0              ; and add the bit
		fmove.d    #4294967296.0,fp1   ; 2^32 to fp1
		fdmul.l    d1,fp1              ; get qhigh up
		fadd.x     fp1,fp0             ; build the "quad"
		fdiv.l     d2,fp0              ; and divide it by d
		fmove.l    fp0,d0              ; return it
		move.l     (sp)+,d7
		rts

_fixmulaccum_fpu:
		move.l     _UtilityBase,a1     ; get base of library
		jsr        -198(a1)            ; SMult
		add.l      d0,(a0)             ; and add low to qlow
		move.l     4(a0),d0            ; get qhigh
		addx.l     d1,d0               ; hight to qhigh with carry
		move.l     d0,4(a0)            ; write it back
		rts

		end
