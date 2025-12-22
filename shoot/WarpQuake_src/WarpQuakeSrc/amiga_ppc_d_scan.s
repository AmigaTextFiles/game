# Copyright (C) 2000 Peter McGavin.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
#
# See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

		.section	".rodata"
		.align 2
.LC6:
		.long 0x41000000
		.align 3
.LC7:
		.long 0x43300000
		.long 0x80000000
		.align 2
.LC8:
		.long 0x47800000
		.align 2
.reciprocals:
		.long 0x55555555	# 1/3
		.long 0x40000000	# 1/4
		.long 0x33333333	# 1/5
		.long 0x2aaaaaab	# 1/6
		.long 0x24924925	# 1/7

########################################################################
		.section	".rodata"
		.align 2
.LC9:
		.long 0x4f000000
		.align 3
.LC10:
		.long 0x43300000
		.long 0x80000000
		.align 3
.LC11:
		.long 0x41e00000
		.long 0x0

		.section	".text"
		.align	2
		.globl	D_DrawZSpans
		.type	D_DrawZSpans,@function
		.globl	_D_DrawZSpans
		.type	_D_DrawZSpans,@function

		.extern	d_pzbuffer
		.extern	d_zwidth
		.extern d_zistepu
		.extern d_zistepv
		.extern d_ziorigin

D_DrawZSpans:
_D_DrawZSpans:
		stwu	r1,-48(r1)
		stw	r26,24(r1)
		stw	r27,28(r1)
		stw	r28,32(r1)
		stw	r29,36(r1)
		stw	r30,40(r1)
		stw	r31,44(r1)

#	izistep = (int)(d_zistepu * 0x8000 * 0x10000);

		lis	r11,.LC9@ha
		lis	r9,d_zistepu@ha
		la	r11,.LC9@l(r11)
		lfs	f0,d_zistepu@l(r9)
		lis	r26,d_pzbuffer@ha
		lfs	f12,0(r11)
		lis	r9,.LC10@ha
		lis	r27,d_zwidth@ha
		la	r9,.LC10@l(r9)
		lfd	f8,0(r9)
		lis	r31,0x4330
		lis	r28,d_ziorigin@ha
		fmuls	f0,f0,f12
		lis	r9,.LC11@ha
		lis	r29,d_zistepv@ha
		la	r9,.LC11@l(r9)
		lis	r30,d_zistepu@ha
		lfd	f7,0(r9)
		fctiwz	f13,f0
		stfd	f13,16(r1)
		lwz	r5,20(r1)

		lfs	f6,d_ziorigin@l(r28)
		lfs	f10,d_zistepv@l(r29)
		lfs	f9,d_zistepu@l(r30)
		lwz	r27,d_zwidth@l(r27)
		lwz	r26,d_pzbuffer@l(r26)
.L171:

#  pdest = d_pzbuffer + (d_zwidth * pspan->v) + pspan->u;
#  count = pspan->count;
#  du = (float)pspan->u;
#  dv = (float)pspan->v;
#  zi = d_ziorigin + dv*d_zistepv + du*d_zistepu;
#  izi = (int)(zi * 0x8000 * 0x10000);

		lwz	r10,0(r3)	# r10 = pspan->u
		lwz	r8,4(r3)	# r8 = pspan->v
		xoris	r11,r10,0x8000	# r11 = pspan->u ^ 0x8000
		xoris	r9,r8,0x8000	# r9 = pspan->v ^ 0x8000
		mullw	r0,r27,r8	# r0 = d_zwidth * pspan->v
		stw	r11,20(r1)
		stw	r31,16(r1)	# 0x4330
		lfd	f12,16(r1)
		stw	r9,20(r1)
		lfd	f13,16(r1)
		fsub	f12,f12,f8	# f12 = (double)pspan->u
		lwz	r4,8(r3)	# count = pspan->count
		fsub	f13,f13,f8	# f13 = (double)pspan->v
		add	r0,r0,r10	# r0 = d_zwidth * pspan->v + pspan->u
		fmadds	f13,f13,f10,f6	# f13 = pspan->v * d_zistepv + d_ziorigin
		add	r0,r0,r0	# r0 = 2*(d_zwidth * pspan->v + pspan->u)
		fmadds	f12,f12,f9,f13	# zi = pspan->u * d_zistepu + f13
		add	r6,r26,r0	# pdest = d_pzbuffer + r0
		fmuls	f0,f12,f7	# f0 = zi * f7
		andi.	r11,r6,2	# pdest & 2
		fctiwz	f11,f0
		stfd	f11,16(r1)
		lwz	r8,20(r1)	# izi = (int)(zi * f7)

#  if ((long)pdest & 0x02) {
#    *pdest++ = (short)(izi >> 16);
#    izi += izistep;
#    count--;
#  }

		beq-	.L164		# branch if (((long)pdest & 2) == 0)
		srawi	r10,r8,16	# r10 = izi >> 16
		addi	r4,r4,-1	# count--
		add	r8,r8,r5	# izi += izistep
		addi	r6,r6,2		# pdest++
		sthx	r10,r26,r0	# *pdest = r10
.L164:

#  if ((doublecount = count >> 1) > 0) {
#    do {
#      ltemp = izi >> 16;
#      izi += izistep;
#      ltemp |= izi & 0xFFFF0000;
#      izi += izistep;
#      *(int *)pdest = ltemp;
#      pdest += 2;
#    } while (--doublecount > 0);
#  }

		srawi.	r7,r4,1		# doublecount = count >> 1
		ble-	.L165
		mtctr	r7		# MCIU
		add	r10,r8,r5	# SCIU1     izi2 = izi + izistep
		slwi	r11,r5,1	# SCIU2     izistep2 = izistep << 1
.loop2:
		srawi	r9,r8,16	# SCIU1 1   ltemp = izi >> 16
		clrrwi	r0,r10,16	# SCIU2 1   r0 = izi2 & 0xffff0000
		or	r9,r9,r0	# SCIU1 2   ltemp |= r0
		add	r8,r8,r11	# SCIU2 2   izi += izistep2
		stw	r9,0(r6)	# LSU   3-5 *(int *)pdest = ltemp
		add	r10,r10,r11	# SCIU1 3   izi2 += izistep2
		addi	r6,r6,4		# SCIU2 3   pdest += 2
		bdnz+	.loop2		# BPU   3
.L165:

#  if (count & 1)
#    *pdest = (short)(izi >> 16);

		andi.	r0,r4,1		# (count & 1)
		beq-	.L163
		srawi	r0,r8,16	# r0 = izi >> 16
		sth	r0,0(r6)	# *pdest = r0
.L163:

#} while ((pspan = pspan->pnext) != NULL);

		lwz	r3,12(r3)	# pspan = pspan->next
		cmpwi	cr0,r3,0
		bne+	.L171

		lwz	r26,24(r1)
		lwz	r27,28(r1)
		lwz	r28,32(r1)
		lwz	r29,36(r1)
		lwz	r30,40(r1)
		lwz	r31,44(r1)
		la	r1,48(r1)
		blr
.Lfe5:
		.size	D_DrawZSpans,.Lfe5-D_DrawZSpans
