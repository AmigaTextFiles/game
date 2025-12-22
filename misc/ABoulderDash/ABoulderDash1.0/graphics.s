	opt	L+
	opt	O2+
	opt	OW-

*==========================================
*
* File:        graphics.s
* Version:     1
* Revision:    0
* Created:     12-VII-1993
* By:          FNC Slothouber
* Last Update: 22-Jan-1995
* By:          FNC Slothouber
*
*==========================================

	incdir	"include:"

	include graphics/graphics_lib.i
	include graphics/view.i
	include hardware/custom.i
*	include hardware/intbits.i
	include	execmacros.i
	include	boulderdash.i


	XREF	_GfxBase
	XDEF	Draw_Object_32
	XDEF	Draw_Object_48
	XDEF	Draw_Object
	XDEF	Draw_Object_Full_Down_32
	XDEF	Scroll_Up
	XDEF	Scroll_Down
	XDEF	Scroll_Left
	XDEF	Scroll_Right

*
* Draw_Object_32
*
* A0 - plane pointer         D2 - Offset into display bitmap
* A1 - plane pointer         D3 - Offset into graphics image bitmap
* A3 - display planes        
* A4 - image planes          
* A5 - Custom Base           d5 - depth count
*                            

Draw_Object_32 ; (display_planes,image_planes,offset_disp,offset_image)
*                 A3             A4           D2          D3

	GRAFCALL WaitBlit
	move.w	#GRAPHICS_width-2-2,bltamod(a5)
	move.w	#BM_width-2-2,bltdmod(a5)

	moveq	#4*(GRAPHICS_d-1),d5
.ll0	GRAFCALL WaitBlit
	move.l	(a3,d5.w),a0
	move.l	(a4,d5.w),a1
	add.l	d2,a0
	add.l	d3,a1
	move.l	a1,bltapt(a5)
	move.l	a0,bltdpt(a5)
	move.w	#64*(GRID_OBJECT_HEIGHT)+(2*(GRID_OBJECT_WIDTH/16)),bltsize(a5)
	subq.w	#4,d5
	bpl.s	.ll0
	rts

*
* Draw_Object_48
*
* A0 - plane pointer         D2 - Offset into display bitmap
* A1 - plane pointer         D3 - Offset into graphics image bitmap
* A3 - display planes        
* A4 - image planes          
* A5 - Custom Base           d5 - depth count
*                            

Draw_Object_48 ; (display_planes,image_planes,offset_disp,offset_image)
*                 A3             A4           D2          D3
	GRAFCALL WaitBlit
	move.w	#GRAPHICS_width-2-2-2,bltamod(a5)
	move.w	#BM_width-2-2-2,bltdmod(a5)

	moveq	#4*(GRAPHICS_d-1),d5
.ll0	GRAFCALL WaitBlit
	move.l	(a3,d5.w),a0
	move.l	(a4,d5.w),a1
	add.l	d2,a0
	add.l	d3,a1
	move.l	a1,bltapt(a5)
	move.l	a0,bltdpt(a5)
	move.w	#64*(GRID_OBJECT_HEIGHT)+(3*(GRID_OBJECT_WIDTH/16)),bltsize(a5)
	subq.w	#4,d5
	bpl.s	.ll0
	rts

*
* Draw_Object
*
* A0 - plane pointer         D2 - Offset into display bitmap
* A1 - plane pointer         D3 - Offset into graphics image bitmap
* A3 - display planes        
* A4 - image planes          
* A5 - Custom Base           d5 - depth count
*                            

Draw_Object ; (display_planes,image_planes,offset_disp,offset_image)
*              A3             A4           D2          D3

	GRAFCALL WaitBlit
	move.w	#GRAPHICS_width-2,bltamod(a5)
	move.w	#BM_width-2,bltdmod(a5)

	moveq	#4*(GRAPHICS_d-1),d5
.ll0	GRAFCALL WaitBlit
	move.l	(a3,d5.w),a0
	move.l	(a4,d5.w),a1
	add.l	d2,a0
	add.l	d3,a1
	move.l	a1,bltapt(a5)
	move.l	a0,bltdpt(a5)
	move.w	#64*(GRID_OBJECT_HEIGHT)+(GRID_OBJECT_WIDTH/16),bltsize(a5)
	subq.w	#4,d5
	bpl.s	.ll0
	rts

*
* Draw_Object_Full_Down_32
*
* A0 - plane pointer         D2 - Offset into display bitmap
* A1 - plane pointer         D3 - Offset into graphics image bitmap
* A3 - display planes        
* A4 - image planes          
* A5 - Custom Base           d5 - depth count
*                            

Draw_Object_Full_Down_32
*     ; (display_planes,image_planes,offset_disp,offset_image)
*        A3             A4           D2          D3

	GRAFCALL WaitBlit
	move.w	#GRAPHICS_width-2,bltamod(a5)
	move.w	#BM_width-2,bltdmod(a5)

	moveq	#4*(GRAPHICS_d-1),d5
.ll0	GRAFCALL WaitBlit
	move.l	(a3,d5.w),a0
	move.l	(a4,d5.w),a1
	add.l	d2,a0
	add.l	d3,a1
	move.l	a1,bltapt(a5)
	move.l	a0,bltdpt(a5)
	move.w	#64*2*(GRID_OBJECT_HEIGHT)+(GRID_OBJECT_WIDTH/16),bltsize(a5)
	subq.w	#4,d5
	bpl.s	.ll0
	rts

*
* Scroll_Left
* A3 - bitmap
* A4 - custom base
*
*
*

*==============
* Scroll_Left
*==============

Scroll_Left ; (Bitmap),a3

Scl_REGS	REG	a3/a4

	movem.l	Scl_REGS,-(sp)

	add.l	#bm_Planes,a3

	GRAFCALL OwnBlitter
	GRAFCALL WaitBlit

	move.l	#$dff000,a4		; Custom Chip base addr.
	move.w	#2,bltamod(a4)
	move.w	#2,bltdmod(a4)
	move.w	#$09f0,bltcon0(a4)	D=A   Use A , Use D
	move.w	#$0000,bltcon1(a4)
	move.w	#$ffff,bltafwm(a4)
	move.w	#$ffff,bltalwm(a4)

	move.w	#BM_d-1,d2
.loop1	GRAFCALL WaitBlit
	move.l	(a3)+,a0
	add.l	#GRID_OBJECT_HEIGHT*BM_width,a0
	move.l	a0,bltdpt(a4)		Destination  M
	addq.l	#2,a0
	move.l	a0,bltapt(a4)		Source   M+2
	move.w	#64*(BM_y-(2*GRID_OBJECT_HEIGHT))+(BM_width/2-1),bltsize(a4)

	dbra	d2,.loop1

	GRAFCALL DisownBlitter

	movem.l	(sp)+,Scl_REGS
	rts

*==============
* Scroll_Right
*==============

Scroll_Right ; (Bitmap),a3

Scr_REGS	REG	a3/a4

	movem.l	Scr_REGS,-(sp)

	add.l	#bm_Planes,a3

	GRAFCALL OwnBlitter
	GRAFCALL WaitBlit

	move.l	#$dff000,a4		; Custom Chip base addr.
	move.w	#2,bltamod(a4)
	move.w	#2,bltdmod(a4)
	move.w	#$09f0,bltcon0(a4)	; D=A   Use A , Use D
	move.w	#$0002,bltcon1(a4)	; desc mode
	move.w	#$ffff,bltafwm(a4)
	move.w	#$ffff,bltalwm(a4)

	move.w	#BM_d-1,d2
.loop1	GRAFCALL WaitBlit
	move.l	(a3)+,a0
	add.l	#BM_width*(BM_y-GRID_OBJECT_HEIGHT)-2,a0
	move.l	a0,bltdpt(a4)		Destination  MAX
	subq.l	#2,a0
	move.l	a0,bltapt(a4)		Source   MAX-2
	move.w	#64*(BM_y-(2*GRID_OBJECT_HEIGHT))+(BM_width/2-1),bltsize(a4)
	dbra	d2,.loop1

	GRAFCALL DisownBlitter

	movem.l	(sp)+,Scr_REGS
	rts

*==============
* Scroll_Up
*==============

Scroll_Up ; (Bitmap),a3

Scu_REGS	REG	a3/a4

	movem.l	Scu_REGS,-(sp)

	add.l	#bm_Planes,a3

	GRAFCALL OwnBlitter
	GRAFCALL WaitBlit

	move.l	#$dff000,a4		; Custom Chip base addr.
	move.w	#4,bltamod(a4)
	move.w	#4,bltdmod(a4)
	move.w	#$09f0,bltcon0(a4)	; D=A   Use A , Use D
	move.w	#$0000,bltcon1(a4)
	move.w	#$ffff,bltafwm(a4)
	move.w	#$ffff,bltalwm(a4)

	move.w	#BM_d-1,d2
.loop1	GRAFCALL WaitBlit
	move.l	(a3)+,a0
	add.l	#GRID_OBJECT_HEIGHT*BM_width+GRID_OBJECT_WIDTH/8,a0
	move.l	a0,bltdpt(a4)		Destination
	add.l	#BM_width*GRID_OBJECT_HEIGHT,a0
	move.l	a0,bltapt(a4)		Source
	move.w	#64*(BM_y-(3*GRID_OBJECT_HEIGHT))+(BM_width/2)-2,bltsize(a4)
	dbra	d2,.loop1

	GRAFCALL DisownBlitter

	movem.l	(sp)+,Scu_REGS
	rts


*==============
* Scroll_Down
*==============

Scroll_Down ; (Bitmap),a3

Scd_REGS	REG	a3/a4

	movem.l	Scd_REGS,-(sp)

	add.l	#bm_Planes,a3

	GRAFCALL OwnBlitter
	GRAFCALL WaitBlit

	move.l	#$dff000,a4		; Custom Chip base addr.
	move.w	#4,bltamod(a4)
	move.w	#4,bltdmod(a4)
	move.w	#$09f0,bltcon0(a4)	; D=A   Use A , Use D
	move.w	#$0002,bltcon1(a4)	; desc mode
	move.w	#$ffff,bltafwm(a4)
	move.w	#$ffff,bltalwm(a4)

	move.w	#BM_d-1,d2
.loop1	GRAFCALL WaitBlit
	move.l	(a3)+,a0
	add.l	#(BM_y-16)*BM_width-4,a0
	move.l	a0,bltdpt(a4)			Destination
	sub.l	#GRID_OBJECT_HEIGHT*BM_width,a0
	move.l	a0,bltapt(a4)			Source
	move.w	#64*(BM_y-(3*GRID_OBJECT_HEIGHT))+(BM_width/2)-2,bltsize(a4)
	dbra	d2,.loop1

	GRAFCALL DisownBlitter

	movem.l	(sp)+,Scd_REGS
	rts
