# 
# Copyright (C) 1996-1997 Id Software, Inc. 
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
# 

##
## Quake for AMIGA
##
## macrosPPC.i
##
## Macros used in all PPC assembler sources of Quake.
## Define WOS for WarpOS/PowerOpen ABI, otherwise code for
## PowerUp/SVR4 will be generated.
##
## Define NOLR, if the init/exit macros must not save/restore the LR.
##

# ABI-specific macros

.ifdef	WOS
# WarpOS/PowerOpen

.macro	xrefv	# cross reference to an elementary data type
	.extern	_\1
.endm

.macro	xrefa	# cross reference to an object's address
	.extern	@__\1
.endm

.macro	funcdef	# global function definition
	.text
	.globl	_\1
	.globl	_\1__r
_\1:
_\1__r:
.endm
 
.macro	lab	# label definition
_\1:
.endm

.macro	init	# init stack frame: nParams,localSize,nGPR,nFPR
.set	param,	24
.set	local,	24+(\1*4)
.set	gb,	(local+\2+3)&~3
.set	fb,	(gb+\3*4+7)&~7
.set	sfsize,	(fb+\4*8+15)&~15
.ifndef	NOLR
	mflr	r0
	stw	r0,8(r1)
.endif
	stwu	r1,-sfsize(r1)
.endm

.macro	exit	# free stack frame and return
	addi	r1,r1,sfsize
.ifndef	NOLR
	lwz	r0,8(r1)
	mtlr	r0
.endif
	blr
.endm

.macro	funcend	# set function type and size
        .type   _\1,@function
        .size   _\1,$-_\1
.endm

.ifndef	NOLR
.macro	call	# call sub routine
	bl	_\1
.endm

.macro	mcall	# call math subroutine
.ifdef	__STORM__
	bl	_\1__r
.else
	bl	_\1
.endif
.endm
.endif

.macro	lxa	# load external object's address
	lwz	\1,@__\2(r2)
.endm

.macro	lla	# load local object's address
	la	\1,_\2(r2)
.endm

.macro	lw	# load word
	lwz	\1,_\2(r2)
.endm

.macro	sw	# store word
	stw	\1,_\2(r2)
.endm

.macro	lf	# load double float
	lfd	\1,_\2(r2)
.endm

.macro	ls	# load single float
	lfs	\1,_\2(r2)
.endm

.macro	ss	# store single float
	stfs	\1,_\2(r2)
.endm


.else
# SVR4/ELF (PowerUp)

.macro	xrefv	# cross reference to an elementary data type
	.extern	\1
.endm

.macro	xrefa	# cross reference to an object's address
	.extern	\1
.endm

.macro	funcdef	# global function definition
	.text
	.globl	\1
\1:
.endm

.macro	lab	# label definition
\1:
.endm

.macro	init	# init stack frame: nParams,localSize,nGPR,nFPR
.set	param,	8
.set	local,	8+(\1*4)
.set	save14,	(local+\2+3)&~3
.set	gb,	save14+4
.set	fb,	(gb+\3*4+7)&~7
.set	sfsize,	(fb+\4*8+15)&~15
.ifndef	NOLR
	mflr	r0
	stw	r0,4(r1)
.endif
	stwu	r1,-sfsize(r1)
	stw	r14,save14(r1)
.endm

.macro	exit	# free stack frame and return
	lwz	r14,save14(r1)
	addi	r1,r1,sfsize
.ifndef	NOLR
	lwz	r0,4(r1)
	mtlr	r0
.endif
	blr
.endm

.macro	funcend	# set function type and size
        .type   \1,@function
        .size   \1,$-\1
.endm

.ifndef	NOLR
.macro	call	# call sub routine
	bl	\1
.endm

.macro	mcall	# call math subroutine
	bl	\1
.endm
.endif

.macro	lxa	# load external object's address
	lis	\1,\2@ha
	addi	\1,\1,\2@l
.endm

.macro	lla	# load local object's address
	lis	\1,\2@ha
	addi	\1,\1,\2@l
.endm

.macro	lw	# load word
	lis	r14,\2@ha
	lwz	\1,\2@l(r14)
.endm

.macro	sw	# store word
	lis	r14,\2@ha
	stw	\1,\2@l(r14)
.endm

.macro	lf	# load double float
	lis	r14,\2@ha
	lfd	\1,\2@l(r14)
.endm

.macro	ls	# load single float
	lis	r14,\2@ha
	lfs	\1,\2@l(r14)
.endm

.macro	ss	# store single float
	lis	r14,\2@ha
	stfs	\1,\2@l(r14)
.endm

.endif


#
# ABI-independant macros
#

# int2dbl: Convert Signed Integer to Double Precision Floating Point
.macro	int2dbl	# destFPR,srcGPR,trash,
		# StkFrameOffs=0x4330000000000000,FPR=0x4330000080000000
	xoris	\3,\2,0x8000
	stw	\3,\4+4(r1)
	lfd	\1,\4(r1)
	fsub	\1,\1,\5
.endm
