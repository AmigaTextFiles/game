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
## fconstPPC.s
##
## Includes some frequently used floating point constants for the
## r_#?PPC.s and d_#?PPC.s PowerPC assembler modules.
##

.ifdef	WOS
.macro  lab
	.globl	_\1
_\1:
.endm
	.tocd
.else
.macro  lab
	.globl	\1
\1:
.endm
	.data
.endif


lab c0
	.float	0.0
lab c0_5
	.float	0.5
lab c2
	.float	2.0
lab c65536
	.float	65536.0
lab INT2DBL_0
	.long	0x43300000,0x80000000


.ifdef	WOS
	.globl	@___ReciprocTable
@___ReciprocTable:
	.long	__ReciprocTable
	.data
.endif

lab _ReciprocTable
	.long	0,0,0,1431655765,0,858993459,715827883,613566757,536870912
	.long	477218588,429496729,390451572,357913941,330382100,306783378
	.long	286331153,268435456,252645135,238609294,226050910,214748365
	.long	204522252,195225786,186737709,178956971,171798692,165191050
	.long	159072863,153391689,148102321,143165577,138547332
