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
## d_miscPPC.s
##
## Define WOS for PowerOpen ABI, otherwise SVR4-ABI is used.
##

.set NOLR,1
.include        "macrosPPC.i"

#
# external references
#

	xrefa	vright
	xrefa	vup
	xrefa	vpn




###########################################################################
#
#       void TransformVector (vec3_t in, vec3_t out)
#
###########################################################################

	funcdef	TransformVector

	lxa     r5,vright
	lfs     f1,0(r3)
	lfs     f4,0(r5)
	fmuls   f0,f1,f4
	lfs     f2,4(r3)
	lfs     f5,4(r5)
	fmadds  f0,f2,f5,f0
	lfs     f3,8(r3)
	lfs     f6,8(r5)
	fmadds  f0,f3,f6,f0
	stfs    f0,0(r4)
	lxa     r5,vup
	lfs     f4,0(r5)
	fmuls   f0,f1,f4
	lfs     f5,4(r5)
	fmadds  f0,f2,f5,f0
	lfs     f6,8(r5)
	fmadds  f0,f3,f6,f0
	stfs    f0,4(r4)
	lxa     r5,vpn
	lfs     f4,0(r5)
	fmuls   f0,f1,f4
	lfs     f5,4(r5)
	fmadds  f0,f2,f5,f0
	lfs     f6,8(r5)
	fmadds  f0,f3,f6,f0
	stfs    f0,8(r4)
	blr

	funcend	TransformVector
