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
## d_surfPPC.s
##
## Define WOS for PowerOpen ABI, otherwise SVR4-ABI is used.
##

.include        "macrosPPC.i"

#
# external references
#

	xrefa	r_drawsurf
	xrefa	d_lightstylevalue
	xrefv	r_framecount
	xrefv	surfscale
	xrefv	c_surf

	xrefv	R_TextureAnimation
	xrefv	R_DrawSurface
	xrefv	D_SCAlloc


#
# defines
#

.set	MSURFACE_VISFRAME   ,0
.set	MSURFACE_DLIGHTFRAME,4
.set	MSURFACE_DLIGHTBITS ,8
.set	MSURFACE_PLANE      ,12
.set	MSURFACE_FLAGS      ,16
.set	MSURFACE_FIRSTEDGE  ,20
.set	MSURFACE_NUMEDGES   ,24
.set	MSURFACE_CACHESPOTS ,28
.set	MSURFACE_TEXTUREMINS,44
.set	MSURFACE_EXTENTS    ,48
.set	MSURFACE_TEXINFO    ,52
.set	MSURFACE_STYLES     ,56
.set	MSURFACE_SAMPLES    ,60
.set	MSURFACE_SIZEOF_EXP ,6
.set	MSURFACE_SIZEOF     ,(1<<MSURFACE_SIZEOF_EXP)

.set	DRAWSURF_SURFDAT    ,0
.set	DRAWSURF_ROWBYTES   ,4
.set	DRAWSURF_SURF       ,8
.set	DRAWSURF_LIGHTADJ   ,12
.set	DRAWSURF_TEXTURE    ,28
.set	DRAWSURF_SURFMIP    ,32
.set	DRAWSURF_SURFWIDTH  ,36
.set	DRAWSURF_SURFHEIGHT ,40
.set	DRAWSURF_SIZEOF     ,44

.set	SURF_NEXT           ,0
.set	SURF_PREV           ,4
.set	SURF_SPANS          ,8
.set	SURF_KEY            ,12
.set	SURF_LAST_U         ,16
.set	SURF_SPANSTATE      ,20
.set	SURF_FLAGS          ,24
.set	SURF_DATA           ,28
.set	SURF_ENTITY         ,32
.set	SURF_NEARZI         ,36
.set	SURF_INSUBMODEL     ,40
.set	SURF_D_ZIORIGIN     ,44
.set	SURF_D_ZISTEPU      ,48
.set	SURF_D_ZISTEPV      ,52
.set	SURF_SIZEOF_EXP     ,6
.set	SURF_SIZEOF         ,(1<<SURF_SIZEOF_EXP)

.set	MTEXINFO_VECS       ,0
.set	MTEXINFO_MIPADJUST  ,32
.set	MTEXINFO_TEXTURE    ,36
.set	MTEXINFO_FLAGS      ,40
.set	MTEXINFO_SIZEOF     ,44

.set	SURFCACHE_NEXT      ,0
.set	SURFCACHE_OWNER     ,4
.set	SURFCACHE_LIGHTADJ  ,8
.set	SURFCACHE_DLIGHT    ,24
.set	SURFCACHE_SIZE      ,28
.set	SURFCACHE_WIDTH     ,32
.set	SURFCACHE_HEIGHT    ,36
.set	SURFCACHE_MIPSCALE  ,40
.set	SURFCACHE_TEXTURE   ,44
.set	SURFCACHE_DATA      ,48
.set	SURFCACHE_SIZEOF    ,52





###########################################################################
#
#       surfcache_t *D_CacheSurface (msurface_t *surface, int miplevel)
#
###########################################################################

	funcdef	D_CacheSurface

	init	0,4,4,1
	stmw	r28,gb(r1)
	stfd	f14,fb(r1)

	mr      r31,r3
	mr      r30,r4
	lwz     r3,MSURFACE_TEXINFO(r31)
	lwz     r3,MTEXINFO_TEXTURE(r3)
	call	R_TextureAnimation
	lxa     r29,r_drawsurf
	stw     r3,DRAWSURF_TEXTURE(r29)
	mr      r9,r3
	lxa     r3,d_lightstylevalue
	lbz     r4,MSURFACE_STYLES(r31)
	slwi    r4,r4,2
	lwzx    r5,r3,r4
	stw     r5,DRAWSURF_LIGHTADJ(r29)
	lbz     r4,MSURFACE_STYLES+1(r31)
	slwi    r4,r4,2
	lwzx    r6,r3,r4
	stw     r6,DRAWSURF_LIGHTADJ+1*4(r29)
	lbz     r4,MSURFACE_STYLES+2(r31)
	slwi    r4,r4,2
	lwzx    r7,r3,r4
	stw     r7,DRAWSURF_LIGHTADJ+2*4(r29)
	lbz     r4,MSURFACE_STYLES+3(r31)
	slwi    r4,r4,2
	lwzx    r8,r3,r4
	stw     r8,DRAWSURF_LIGHTADJ+3*4(r29)
	slwi    r0,r30,2
	la      r4,MSURFACE_CACHESPOTS(r31)
	lwzx    r3,r4,r0                #r3 = cache
	mr.     r3,r3
	lw      r28,r_framecount
	beq     .cont2
	lwz     r10,SURFCACHE_DLIGHT(r3)
	cmpwi   cr1,r10,0
	lwz     r12,MSURFACE_DLIGHTFRAME(r31)
	cmpw    cr2,r28,r12
	lwz     r4,SURFCACHE_TEXTURE(r3)
	crandc  eq,4*cr1+eq,4*cr2+eq
	cmpw    cr3,r4,r9
	lwz     r11,SURFCACHE_LIGHTADJ(r3)
	crand   eq,eq,4*cr3+eq
	cmpw    cr4,r11,r5
	lwz     r4,SURFCACHE_LIGHTADJ+1*4(r3)
	crand   eq,eq,4*cr4+eq
	cmpw    cr5,r4,r6
	lwz     r11,SURFCACHE_LIGHTADJ+2*4(r3)
	crand   eq,eq,4*cr5+eq
	cmpw    cr6,r11,r7
	lwz     r4,SURFCACHE_LIGHTADJ+3*4(r3)
	crand   eq,eq,4*cr6+eq
	cmpw    cr7,r4,r8
	crand   eq,eq,4*cr7+eq
	beq     .exit
.cont2:
	mr.     r3,r3
	slwi    r0,r30,23
	lis     r11,0x3f800000@h
	ori     r11,r11,0x3f800000@l
	subf    r0,r0,r11
	stw     r0,local(r1)
	lfs     f14,local(r1)		#f14 = surfscale
	stw     r30,DRAWSURF_SURFMIP(r29)
	lha     r4,MSURFACE_EXTENTS(r31)
	sraw    r4,r4,r30
	stw     r4,DRAWSURF_SURFWIDTH(r29)
	stw     r4,DRAWSURF_ROWBYTES(r29)
	lha     r11,MSURFACE_EXTENTS+1*2(r31)
	sraw    r11,r11,r30
	stw     r11,DRAWSURF_SURFHEIGHT(r29)
	bne     .nocache
	mr      r3,r4
	mullw   r4,r4,r11
	call	D_SCAlloc
	slwi    r4,r30,2
	addi    r0,r4,MSURFACE_CACHESPOTS
	add     r4,r31,r0
	stw     r3,0(r4)
	stw     r4,SURFCACHE_OWNER(r3)
	stfs    f14,SURFCACHE_MIPSCALE(r3)
.nocache:
	lwz     r4,MSURFACE_DLIGHTFRAME(r31)
	cmpw    r4,r28
	bne     .else
	li	r0,1
	stw	r0,SURFCACHE_DLIGHT(r3)
	b       .cont
.else:
	li	r0,0
	stw	r0,SURFCACHE_DLIGHT(r3)
.cont:
	la      r4,SURFCACHE_DATA(r3)
	stw     r4,DRAWSURF_SURFDAT(r29)
	stw     r9,SURFCACHE_TEXTURE(r3)
	stw     r5,SURFCACHE_LIGHTADJ(r3)
	stw     r6,SURFCACHE_LIGHTADJ+1*4(r3)
	stw     r7,SURFCACHE_LIGHTADJ+2*4(r3)
	stw     r8,SURFCACHE_LIGHTADJ+3*4(r3)
	stw     r31,DRAWSURF_SURF(r29)
	lw      r5,c_surf
	mr      r31,r3
	addi    r5,r5,1
	sw      r5,c_surf
	call	R_DrawSurface
	mr      r3,r31

.exit:
	lfd	f14,fb(r1)
	lmw	r28,gb(r1)
	exit

	funcend	D_CacheSurface
