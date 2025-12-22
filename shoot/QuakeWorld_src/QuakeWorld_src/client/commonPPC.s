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
## commonPPC.s
##
## PPC assembler implementations of several functions in common.c
##

.ifdef	WOS
	.macro	funcdef
	.text
	.globl	_\1
	.align	3
_\1:
	.endm

.else
	.macro	funcdef
	.text
	.globl	\1
	.align	4
\1:
	.endm
.endif


# short ShortSwap (short l)
#       swap word (LE->BE)

	funcdef	ShortSwap

	extrwi	r0,r3,8,16
	insrwi	r0,r3,8,16
	extsh	r3,r0
	blr


# int LongSwap (int l)
#     swap longword (LE->BE)

	funcdef	LongSwap

	extrwi	r0,r3,8,0
	rlwimi	r0,r3,24,16,23
	rlwimi	r0,r3,8,8,15
	insrwi	r0,r3,8,0
	mr	r3,r0
	blr


# float FloatSwap (float f)
#       swap float (LE->BE)

	funcdef	FloatSwap

	stwu	r1,-32(r1)
	stfs	f1,24(r1)
	lwz	r3,24(r1)
	li	r0,24
	stwbrx	r3,r1,r0
	lfs	f1,24(r1)
	addi	r1,r1,32
	blr
