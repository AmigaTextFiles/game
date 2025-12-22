	opt	L+
	opt	O2+
	opt	OW-

*==========================================
*
* File:        main.s
* Version:     1
* Revision:    0
* Created:     3-VII-1993
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

	include	exec/exec_lib.i
	include	intuition/intuition.i

	include	ExtGfx.i

	include execmacros.i
	include	boulderdash.i

	XDEF	Play
	XDEF	ted_bitmap_x
	XDEF	ted_grid_field_x
	XDEF	animate_offset_x
	XDEF	ted_bitmap_y
	XDEF	ted_grid_field_y
	XDEF	animate_offset_y
	XDEF	flag_scroll_left
	XDEF	flag_scroll_right
	XDEF	flag_scroll_up
	XDEF	flag_scroll_down
	XDEF	left_row_update
	XDEF	right_row_update
	XDEF	upper_row_update
	XDEF	lower_row_update
	XDEF	flag_view_scroll_left
	XDEF	flag_view_scroll_right
	XDEF	flag_view_scroll_up
	XDEF	flag_view_scroll_down
	XDEF	Editor_Animate
	XDEF	Editor_Draw_One_Object
	XDEF	Update_Score
	XDEF	time_flag
	XDEF	ted_wins_flag
	XDEF	ted_reach_limit
	XDEF	integer_time
	XDEF	integer_score
	XDEF	integer_target

	XREF	Calculate
	XREF	Transition
	XREF	grid_field
	XREF	_ExtGfxBase
	XREF	_GfxBase
	XREF	bitmap1
	XREF	bitmap2
	XREF	st_bitmap1
	XREF	st_bitmap2
	XREF	bitmapg
	XREF	display
	XREF	list1
	XREF	list2
	XREF	test_field
	XREF	test_field2
	XREF	list2_right4
	XREF	list2_right12
	XREF	list1_right8
	XREF	list2_left4
	XREF	list2_left12
	XREF	list1_left8
	XREF	list2_up4
	XREF	list2_up12
	XREF	list1_up8
	XREF	list2_down4
	XREF	list2_down12
	XREF	list1_down8

	XREF	Draw_Object_32
	XREF	Draw_Object_48
	XREF	Draw_Object
	XREF	Draw_Object_Full_Down_32
	XREF	Scroll_Up
	XREF	Scroll_Down
	XREF	Scroll_Left
	XREF	Scroll_Right

	XREF	BD_window

	XREF	test_fungis
	XREF	fungis_timer

	XREF	AllocRasters
	XREF	FreeRasters
	XREF	EG_AllocBitMap
	XREF	EG_FreeBitMap
	XREF	GetPicture
	XREF	ClearBitMap
	XREF	GetDisplay
	XREF	FreeDisplay
	XREF	CreatePort
	XREF	DeletePort
	XREF	CreateStdIO
	XREF	CreateExtIO
	XREF	DeleteStdIO
	XREF	DeleteExtIO


CALLEXT		macro
		jsr	\1
		endm


***************************************
***************************************

DELAY	equ	0

Play ; (Game Time, Game Target, Ted_Dx, Ted_Dy),d0,d1,d2,d3

* Copy For Go_To_Ted
	move.w	d2,-(sp)
	move.w	d3,-(sp)

* Initialize
	move.w	#0,fungis_timer
	move.w	#TRUE,test_fungis

* Make Copy of Game Time and Game Target
	move.w	d0,integer_time
	move.w	d1,integer_target
	move.w	#0,integer_score

* Set Flags
	move.w	#TIMELEFT,time_flag
	move.w	#FALSE,ted_wins_flag
	move.w	#FALSE,ted_reach_limit

* Convert Game Time To BCD
	lea	time,a0
	divu	#10,d0
	move.l	d0,d2
	swap	d2
	move.b	d2,3(a0)
	and.l	#$ffff,d0
	divu	#10,d0
	move.l	d0,d2
	swap	d2
	move.b	d2,2(a0)
	and.l	#$ffff,d0
	divu	#10,d0
	move.l	d0,d2
	swap	d2
	move.b	d2,1(a0)
	and.l	#$ffff,d0
	divu	#10,d0
	move.l	d0,d2
	swap	d2
	move.b	d2,0(a0)

* Convert Game Target To BCD
	lea	target,a0
	divu	#10,d1
	move.l	d1,d2
	swap	d2
	move.b	d2,2(a0)
	and.l	#$ffff,d1
	divu	#10,d1
	move.l	d1,d2
	swap	d2
	move.b	d2,1(a0)
	and.l	#$ffff,d1
	divu	#10,d1
	move.l	d1,d2
	swap	d2
	move.b	d2,0(a0)

* Clear All bitmaps
	move.l	bitmap1,a0
	CALLEXT ClearBitMap

	move.l	bitmap2,a0
	CALLEXT ClearBitMap

	move.l	st_bitmap1,a0
	CALLEXT ClearBitMap

	move.l	st_bitmap2,a0
	CALLEXT ClearBitMap

	move.l	#3*grid_sizeof,ted_grid_field_x
	move.l	#3*grid_sizeof,ted_bitmap_x
	move.l	#3*grid_sizeof*GRIDF_WIDTH,ted_grid_field_y
	move.l	#3*grid_sizeof*GRIDF_WIDTH,ted_bitmap_y

	move.l	grid_field,a2
	sub.l	#grid_sizeof,a2
	move.l	a2,left_row_update

	move.l	grid_field,a2
	sub.l	#grid_sizeof*GRIDF_WIDTH,a2
	move.l	a2,upper_row_update

	move.l	grid_field,a2
	add.l	#GRIDF_VISIBLE_WIDTH*grid_sizeof,a2
	move.l	a2,right_row_update

	move.l	grid_field,a2
	add.l	#GRIDF_VISIBLE_HEIGHT*GRIDF_WIDTH*grid_sizeof,a2
	move.l	a2,lower_row_update

	moveq	#0,d0
	move.l	d0,animate_offset_x
	move.l	d0,animate_offset_y
	move.w	d0,flag_scroll_left
	move.w	d0,flag_scroll_right
	move.w	d0,flag_scroll_up
	move.w	d0,flag_scroll_down
	move.w	d0,flag_view_scroll_left
	move.w	d0,flag_view_scroll_right
	move.w	d0,flag_view_scroll_up
	move.w	d0,flag_view_scroll_down

	move.w	(sp)+,d3
	move.w	(sp)+,d2
	bsr	Go_To_Ted

* Reset Score
	lea	score,a0
	move.b	#0,(a0)+
	move.b	#0,(a0)+
	move.b	#0,(a0)+
	move.w	#1,score_dirty

* Display Target Score
	move.l	st_bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	bsr	Show_Target
	move.l	st_bitmap2,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	bsr	Show_Target

* Start Game

.wait	move.l	display,a2
	move.l	dsp_View(a2),a1
	move.l	list2,v_LOFCprList(a1)

	move.w	flag_view_scroll_right,d0
	beq	.viewr0
	move.l	list2_right12,v_LOFCprList(a1)
	move.w	#NO_SCROLL,flag_view_scroll_right
.viewr0
	move.w	flag_view_scroll_left,d0
	beq	.viewl0
	move.l	list2_left12,v_LOFCprList(a1)
	move.w	#NO_SCROLL,flag_view_scroll_left
.viewl0
	move.w	flag_view_scroll_up,d0
	beq	.viewu0
	move.l	list2_up12,v_LOFCprList(a1)
	move.w	#NO_SCROLL,flag_view_scroll_up
.viewu0
	move.w	flag_view_scroll_down,d0
	beq	.viewd0
	move.l	list2_down12,v_LOFCprList(a1)
	move.w	#NO_SCROLL,flag_view_scroll_down
.viewd0
	GRAFCALL LoadView
	move.w	#DELAY,d2
.del0	GRAFCALL WaitTOF
	dbra	d2,.del0

*--------------------------------------
* Animate Phase 0
*--------------------------------------

	move.l	grid_field,a2
	jsr	Calculate

	move.w	flag_scroll_left,d0
	beq	.no_scroll1
	move.l	bitmap1,a3
	bsr	Scroll_Left
	move.l	left_row_update,a2
	bsr	Update_Row
.no_scroll1

	move.w	flag_scroll_right,d0
	beq	.no_scroll1r
	move.l	bitmap1,a3
	bsr	Scroll_Right
	move.l	right_row_update,a2
	bsr	Update_Row
.no_scroll1r

	move.w	flag_scroll_up,d0
	beq	.no_scroll1u
	move.l	bitmap1,a3
	bsr	Scroll_Up
	move.l	upper_row_update,a2
	bsr	Update_Row2
.no_scroll1u

	move.w	flag_scroll_down,d0
	beq	.no_scroll1d
	move.l	bitmap1,a3
	bsr	Scroll_Down
	move.l	lower_row_update,a2
	bsr	Update_Row2
.no_scroll1d

	move.l	grid_field,a2
	add.l	animate_offset_x,a2
	add.l	animate_offset_y,a2
	move.l	bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4

	GRAFCALL WaitBlit
	bsr	Animate

	GRAFCALL WaitBlit

	move.l	st_bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	bsr	Show_Time

	move.w	score_dirty,d0
	beq	.no_score
	move.l	st_bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	bsr	Show_Score
.no_score

	move.l	display,a2
	move.l	dsp_View(a2),a1
	move.l	list1,v_LOFCprList(a1)
	GRAFCALL LoadView
	move.w	#DELAY,d2
.del1	GRAFCALL WaitTOF
	dbra	d2,.del1

*-------------------------------------
* Animate Phase 4
*-------------------------------------

	move.w	flag_scroll_left,d0
	beq	.no_scroll2
	move.l	bitmap2,a3
	bsr	Scroll_Left
	move.w	#NO_SCROLL,flag_scroll_left
.no_scroll2

	move.w	flag_scroll_right,d0
	beq	.no_scroll2r
	move.l	bitmap2,a3
	bsr	Scroll_Right
	move.w	#NO_SCROLL,flag_scroll_right
.no_scroll2r

	move.w	flag_scroll_up,d0
	beq	.no_scroll2u
	move.l	bitmap2,a3
	bsr	Scroll_Up
	move.w	#NO_SCROLL,flag_scroll_up
.no_scroll2u

	move.w	flag_scroll_down,d0
	beq	.no_scroll2d
	move.l	bitmap2,a3
	bsr	Scroll_Down
	move.w	#NO_SCROLL,flag_scroll_down
.no_scroll2d

	move.l	grid_field,a2
	add.l	animate_offset_x,a2
	add.l	animate_offset_y,a2
	move.l	bitmap2,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4

	GRAFCALL WaitBlit
	bsr	Animate

	GRAFCALL WaitBlit
	move.l	st_bitmap2,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	bsr	Show_Time

	move.w	score_dirty,d0
	beq	.no_score2
	move.l	st_bitmap2,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	bsr	Show_Score
	move.w	#0,score_dirty
.no_score2

	move.l	display,a2
	move.l	dsp_View(a2),a1
	move.l	list2,v_LOFCprList(a1)
	move.w	flag_view_scroll_right,d0
	beq	.viewr2
	move.l	list2_right4,v_LOFCprList(a1)
.viewr2
	move.w	flag_view_scroll_left,d0
	beq	.viewl2
	move.l	list2_left4,v_LOFCprList(a1)
.viewl2
	move.w	flag_view_scroll_up,d0
	beq	.viewu2
	move.l	list2_up4,v_LOFCprList(a1)
.viewu2
	move.w	flag_view_scroll_down,d0
	beq	.viewd2
	move.l	list2_down4,v_LOFCprList(a1)
.viewd2
	GRAFCALL LoadView
	move.w	#DELAY,d2
.del2	GRAFCALL WaitTOF
	dbra	d2,.del2

*-------------------------------------
* Animate Phase 8
*-------------------------------------

	move.l	grid_field,a2
	add.l	animate_offset_x,a2
	add.l	animate_offset_y,a2
	move.l	bitmap1,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	bsr	Animate

	move.l	display,a2
	move.l	dsp_View(a2),a1
	move.l	list1,v_LOFCprList(a1)
	move.w	flag_view_scroll_right,d0
	beq	.viewr3
	move.l	list1_right8,v_LOFCprList(a1)
.viewr3
	move.w	flag_view_scroll_left,d0
	beq	.viewl3
	move.l	list1_left8,v_LOFCprList(a1)
.viewl3
	move.w	flag_view_scroll_up,d0
	beq	.viewu3
	move.l	list1_up8,v_LOFCprList(a1)
.viewu3
	move.w	flag_view_scroll_down,d0
	beq	.viewd3
	move.l	list1_down8,v_LOFCprList(a1)
.viewd3
	GRAFCALL LoadView
	move.w	#DELAY,d2
.del3	GRAFCALL WaitTOF
	dbra	d2,.del3

*-------------------------------------
* Animate Phase 12
*-------------------------------------

	move.l	grid_field,a2
	add.l	animate_offset_x,a2
	add.l	animate_offset_y,a2
	move.l	bitmap2,a3
	move.l	bitmapg,a4
	add.l	#bm_Planes,a3
	add.l	#bm_Planes,a4
	bsr	Animate

	move.l	grid_field,a2
	jsr	Transition
	bsr	Update_Time

	move.w	ted_wins_flag,d0
	bne	.ted_wins

	move.l	BD_window,a0
	move.l	wd_UserPort(a0),a0
	EXECCALL GetMsg
	move.l	d0,d1
	beq	.wait
	move.l	d0,a1

	move.l	im_Class(a1),d0
	cmp.l	#RAWKEY,d0
	beq.s	.test2
	EXECCALL ReplyMsg
	bra	.wait
.test2	cmp.w	#$45,im_Code(a1)
	beq.s	.exits
	EXECCALL ReplyMsg
	bra	.wait
.exits	EXECCALL ReplyMsg
	bra	.exit

*
* ** Ted Wins the game **
*
.ted_wins

.exit	rts


*
* Move Screen to Begin Pos Ted 
*

Go_To_Ted ; (Dx,Dy),d2,d3

	subq.w	#1,d2
	bmi	.next

.loopx	move.l	ted_bitmap_x,d0
	addq.l	#grid_sizeof,d0
	move.l	animate_offset_x,d1
	cmp.l	#SCROLL_LEFT_MAX,d1
	bhs.s	.noscroll
	cmp.l	#SCROLL_LEFT,d0
	bls.s	.noscroll

* Move Right Scroll Left
	move.l	animate_offset_x,d0
	addq.l	#grid_sizeof,d0
	move.l	d0,animate_offset_x
	move.l	left_row_update,d0
	addq.l	#grid_sizeof,d0
	move.l	d0,left_row_update
	move.l	right_row_update,d0
	addq.l	#grid_sizeof,d0
	move.l	d0,right_row_update
	bra	.cont
.noscroll
* Move Right
	move.l	ted_bitmap_x,d0
	addq.l	#grid_sizeof,d0
	move.l	d0,ted_bitmap_x

.cont	move.l	ted_grid_field_x,d0
	add.l	#grid_sizeof,d0
	move.l	d0,ted_grid_field_x

	dbra	d2,.loopx
.next

	subq.w	#1,d3
	bmi	.exit

.loopy	move.l	ted_bitmap_y,d0
	add.l	#grid_sizeof*GRIDF_WIDTH,d0
	move.l	animate_offset_y,d1
	cmp.l	#SCROLL_UP_MAX,d1
	bhs.s	.noscroll2
	cmp.l	#SCROLL_UP,d0
	bls.s	.noscroll2
* Scroll Up Move Down
	move.l	animate_offset_y,d0
	add.l	#grid_sizeof*GRIDF_WIDTH,d0
	move.l	d0,animate_offset_y
	move.l	upper_row_update,d0
	add.l	#grid_sizeof*GRIDF_WIDTH,d0
	move.l	d0,upper_row_update
	move.l	lower_row_update,d0
	add.l	#grid_sizeof*GRIDF_WIDTH,d0
	move.l	d0,lower_row_update
	bra	.cont2
.noscroll2
* Move Down
	move.l	ted_bitmap_y,d0
	add.l	#grid_sizeof*GRIDF_WIDTH,d0
	move.l	d0,ted_bitmap_y

.cont2	move.l	ted_grid_field_y,d0
	add.l	#grid_sizeof*GRIDF_WIDTH,d0
	move.l	d0,ted_grid_field_y

	dbra	d3,.loopy
.exit	rts

*
* Update_Row
*

Update_Row ; (grid_field),a2

Ulr_REGS	REG	D2

	movem.l	Ulr_REGS,-(sp)

	move.w	#GRIDF_HEIGHT-1,d0
	moveq	#2,d1
	move.l	#GRIDF_WIDTH*grid_sizeof,d2
.loop
	move.b	d1,grid_dirty(a2)
	add.l	d2,a2
	dbra	d0,.loop

	movem.l	(sp)+,Ulr_REGS
	rts

*
* Update_Row2
*

Update_Row2 ; (grid_field),a2

	move.w	#GRIDF_WIDTH-1,d0
	moveq	#2,d1
.loop
	move.b	d1,grid_dirty(a2)
	addq	#grid_sizeof,a2
	dbra	d0,.loop

	rts

*
* Animate
*
*   A0                           D0
*   A1                           D1
*   A2 - grid field              D2 - offset_disp
*   A3 - display planes          D3 - offset_image
*   A4 - image planes            D4 - offset into bitplane
*   A5 - Custom Base             D5 - depth count
*                                D6 - grid_x
*                                D7 - grid_y

Animate ; (Grid_Field,Display_Planes,Image_Planes),a2,a3,a4

* Initialize blitter
	move.l	#$dff000,a5
	GRAFCALL OwnBlitter
	GRAFCALL WaitBlit
	move.w	#$09f0,bltcon0(a5)		; D=A  Use A, Use D
	move.w	#$0000,bltcon1(a5)
	move.w	#$ffff,bltafwm(a5)
	move.w	#$ffff,bltalwm(a5)

; 16 pixels animation buffer for horizontal animation
; 16 pixels animation buffer for vertical animation
	move.l	#BM_width*GRID_OBJECT_HEIGHT+(GRID_OBJECT_WIDTH/8),d4

	move.w	#GRIDF_VISIBLE_HEIGHT-1,d7
.ll0	move.w	#GRIDF_VISIBLE_WIDTH-1,d6

* test if the grid needs to be drawn
.ll1	move.b	grid_dirty(a2),d0
	beq	.next
	subq.b	#1,d0
	move.b	d0,grid_dirty(a2)

* draw the grid
	move.l	d4,d2
	moveq	#0,d1
	move.w	grid_draw(a2),d1
	beq	.next
	pea	.next
	jmp	animate_table_entry

* next grid
.next	addq.l	#grid_sizeof,a2
	add.l	#GRID_OBJECT_WIDTH/8,d4
	dbra	d6,.ll1
	add.l	#grid_sizeof*(GRIDF_WIDTH-GRIDF_VISIBLE_WIDTH),a2
	add.l	#BM_width*(GRID_OBJECT_HEIGHT-1)+(BM_width-(2*GRIDF_VISIBLE_WIDTH)),d4
	dbra	d7,.ll0

	GRAFCALL DisownBlitter
	rts


*
* Editor_Animate
*
*   A0                           D0
*   A1                           D1
*   A2 - grid field              D2 - offset_disp
*   A3 - display planes          D3 - offset_image
*   A4 - image planes            D4 - offset into bitplane
*   A5 - Custom Base             D5 - depth count
*                                D6 - grid_x
*                                D7 - grid_y

Editor_Animate ; (Grid_Field,Display_Planes,Image_Planes),a2,a3,a4

* Initialize blitter
	move.l	#$dff000,a5
	GRAFCALL OwnBlitter
	GRAFCALL WaitBlit
	move.w	#$09f0,bltcon0(a5)		; D=A  Use A, Use D
	move.w	#$0000,bltcon1(a5)
	move.w	#$ffff,bltafwm(a5)
	move.w	#$ffff,bltalwm(a5)

; 32+16 pixels buffer for gadgets and screen title bar
	move.l	#BM_width*(32+16),d4

	move.w	#BD_EDIT_FIELD_HEIGHT-1,d7
.ll0	move.w	#BD_EDIT_FIELD_WIDTH-1,d6

* test if the grid needs to be drawn
.ll1	move.b	grid_dirty(a2),d0
	beq	.next
*	subq.b	#1,d0
*	move.b	d0,grid_dirty(a2)

* draw the grid
	move.l	d4,d2
	moveq	#0,d1
	move.w	grid_draw(a2),d1
	beq	.next
	pea	.next
	jmp	animate_table_entry

* next grid
.next	addq.l	#grid_sizeof,a2
	add.l	#GRID_OBJECT_WIDTH/8,d4
	dbra	d6,.ll1
	add.l	#grid_sizeof*(GRIDF_WIDTH-BD_EDIT_FIELD_WIDTH),a2
	add.l	#BM_width*(GRID_OBJECT_HEIGHT-1)+(BM_width-(2*BD_EDIT_FIELD_WIDTH)),d4
	dbra	d7,.ll0

	GRAFCALL DisownBlitter
	rts


*
* Editor_Draw_One_Object
*
*   A0                           D0
*   A1                           D1
*   A2                           D2 
*   A3 - display planes          D3 
*   A4 - image planes            D4 - offset into bitplane
*   A5 - Custom Base             D5 
*                                D6 
*                                D7 

Editor_Draw_One_Object ; (Display_Planes,Image_Planes),a3,a4

* Initialize blitter
	move.l	#$dff000,a5
	GRAFCALL OwnBlitter
	GRAFCALL WaitBlit
	move.w	#$09f0,bltcon0(a5)		; D=A  Use A, Use D
	move.w	#$0000,bltcon1(a5)
	move.w	#$ffff,bltafwm(a5)
	move.w	#$ffff,bltalwm(a5)

	pea	.next
	jmp	animate_table_entry

.next	GRAFCALL DisownBlitter
	rts


****************************

animate_table_entry
	jmp	animate_tabel(pc,d1)
animate_tabel
	jmp	dummy
	jmp	Draw_Border
	jmp	Draw_Empty
	jmp	Draw_Dirt
	jmp	Draw_Rock
	jmp	Draw_Diamond
	jmp	Draw_Butterfly
	jmp	Draw_Brick
	jmp	Draw_Fungis
	jmp	Draw_Mover
	jmp	Draw_Exit
	jmp	Draw_Rock_Down0
	jmp	Draw_Rock_Down4
	jmp	Draw_Rock_Down8
	jmp	Draw_Rock_Down12
	jmp	Draw_Mover_Down0
	jmp	Draw_Mover_Down4
	jmp	Draw_Mover_Down8
	jmp	Draw_Mover_Down12
	jmp	Draw_Butterfly_Down0
	jmp	Draw_Butterfly_Down4
	jmp	Draw_Butterfly_Down8
	jmp	Draw_Butterfly_Down12
	jmp	Draw_Diamond_Down0
	jmp	Draw_Diamond_Down4
	jmp	Draw_Diamond_Down8
	jmp	Draw_Diamond_Down12
	jmp	Draw_Mover_Up0
	jmp	Draw_Mover_Up4
	jmp	Draw_Mover_Up8
	jmp	Draw_Mover_Up12
	jmp	Draw_Butterfly_Up0
	jmp	Draw_Butterfly_Up4
	jmp	Draw_Butterfly_Up8
	jmp	Draw_Butterfly_Up12
	jmp	Draw_Mover_Right0
	jmp	Draw_Mover_Right4
	jmp	Draw_Mover_Right8
	jmp	Draw_Mover_Right12
	jmp	Draw_Mover_Left0
	jmp	Draw_Mover_Left4
	jmp	Draw_Mover_Left8
	jmp	Draw_Mover_Left12
	jmp	Draw_Butterfly_Right0
	jmp	Draw_Butterfly_Right4
	jmp	Draw_Butterfly_Right8
	jmp	Draw_Butterfly_Right12
	jmp	Draw_Butterfly_Left0
	jmp	Draw_Butterfly_Left4
	jmp	Draw_Butterfly_Left8
	jmp	Draw_Butterfly_Left12
	jmp	Draw_Rock_Right0
	jmp	Draw_Rock_Right4
	jmp	Draw_Rock_Right8
	jmp	Draw_Rock_Right12
	jmp	Draw_Rock_Left0
	jmp	Draw_Rock_Left4
	jmp	Draw_Rock_Left8
	jmp	Draw_Rock_Left12
	jmp	Draw_Diamond_Right0
	jmp	Draw_Diamond_Right4
	jmp	Draw_Diamond_Right8
	jmp	Draw_Diamond_Right12
	jmp	Draw_Diamond_Left0
	jmp	Draw_Diamond_Left4
	jmp	Draw_Diamond_Left8
	jmp	Draw_Diamond_Left12
	jmp	Draw_Ted
	jmp	Draw_Ted_Down0
	jmp	Draw_Ted_Down4
	jmp	Draw_Ted_Down8
	jmp	Draw_Ted_Down12
	jmp	Draw_Ted_Up0
	jmp	Draw_Ted_Up4
	jmp	Draw_Ted_Up8
	jmp	Draw_Ted_Up12
	jmp	Draw_Ted_Left0
	jmp	Draw_Ted_Left4
	jmp	Draw_Ted_Left8
	jmp	Draw_Ted_Left12
	jmp	Draw_Ted_Right0
	jmp	Draw_Ted_Right4
	jmp	Draw_Ted_Right8
	jmp	Draw_Ted_Right12
	jmp	Draw_Ted_Dirt_Left0
	jmp	Draw_Ted_Dirt_Left4
	jmp	Draw_Ted_Dirt_Left8
	jmp	Draw_Ted_Dirt_Left12
	jmp	Draw_Ted_Dirt_Right0
	jmp	Draw_Ted_Dirt_Right4
	jmp	Draw_Ted_Dirt_Right8
	jmp	Draw_Ted_Dirt_Right12
	jmp	Draw_Ted_Rock_Left0
	jmp	Draw_Ted_Rock_Left4
	jmp	Draw_Ted_Rock_Left8
	jmp	Draw_Ted_Rock_Left12
	jmp	Draw_Ted_Rock_Right0
	jmp	Draw_Ted_Rock_Right4
	jmp	Draw_Ted_Rock_Right8
	jmp	Draw_Ted_Rock_Right12
	jmp	Draw_Ted_Dirt_Down0
	jmp	Draw_Ted_Dirt_Down4
	jmp	Draw_Ted_Dirt_Down8
	jmp	Draw_Ted_Dirt_Down12
	jmp	Draw_Ted_Dirt_Up0
	jmp	Draw_Ted_Dirt_Up4
	jmp	Draw_Ted_Dirt_Up8
	jmp	Draw_Ted_Dirt_Up12
	jmp	Draw_Fungis_Right0
	jmp	Draw_Fungis_Right4
	jmp	Draw_Fungis_Right8
	jmp	Draw_Fungis_Left0
	jmp	Draw_Fungis_Left4
	jmp	Draw_Fungis_Left8
	jmp	Draw_Fungis_Up0
	jmp	Draw_Fungis_Up4
	jmp	Draw_Fungis_Up8
	jmp	Draw_Fungis_Down0
	jmp	Draw_Fungis_Down4
	jmp	Draw_Fungis_Down8
	jmp	dummy
	jmp	dummy
	jmp	dummy
	jmp	dummy
	jmp	dummy
	jmp	dummy


**********************
** Drawing Routines **
**********************

dummy	rts

DRAW_SIMPLE	macro
		move.l	#\1,d3
		bra	Draw_Object
		endm

Draw_Ted
	DRAW_SIMPLE	IM_TED
Draw_Fungis
	DRAW_SIMPLE	IM_FUNGIS
Draw_Border
	DRAW_SIMPLE	IM_BORDER
Draw_Empty
	DRAW_SIMPLE	IM_EMPTY
Draw_Dirt
	DRAW_SIMPLE	IM_DIRT
Draw_Rock
	DRAW_SIMPLE	IM_ROCK0
Draw_Brick
	DRAW_SIMPLE	IM_BRICK
Draw_Diamond
	DRAW_SIMPLE	IM_DIAMOND0
Draw_Mover
	DRAW_SIMPLE	IM_MOVER0
Draw_Butterfly
	DRAW_SIMPLE	IM_BUTTERFLY0
Draw_Exit
	DRAW_SIMPLE	IM_EXIT


DRAW_SIM_TRANS	macro
		move.l	#\1,d3
		move.w	#\2,grid_draw(a2)
		bra	Draw_Object
		endm

Draw_Fungis_Right0
	DRAW_SIM_TRANS	IM_FUNGIS_RIGHT0,DRAW_FUNGIS_RIGHT4
Draw_Fungis_Right4
	DRAW_SIM_TRANS	IM_FUNGIS_RIGHT4,DRAW_FUNGIS_RIGHT8
Draw_Fungis_Right8
	DRAW_SIM_TRANS	IM_FUNGIS_RIGHT8,DRAW_FUNGIS
Draw_Fungis_Left0
	DRAW_SIM_TRANS	IM_FUNGIS_LEFT0,DRAW_FUNGIS_LEFT4
Draw_Fungis_Left4
	DRAW_SIM_TRANS	IM_FUNGIS_LEFT4,DRAW_FUNGIS_LEFT8
Draw_Fungis_Left8
	DRAW_SIM_TRANS	IM_FUNGIS_LEFT8,DRAW_FUNGIS
Draw_Fungis_Up0
	DRAW_SIM_TRANS	IM_FUNGIS_UP0,DRAW_FUNGIS_UP4
Draw_Fungis_Up4
	DRAW_SIM_TRANS	IM_FUNGIS_UP4,DRAW_FUNGIS_UP8
Draw_Fungis_Up8
	DRAW_SIM_TRANS	IM_FUNGIS_UP8,DRAW_FUNGIS
Draw_Fungis_Down0
	DRAW_SIM_TRANS	IM_FUNGIS_DOWN0,DRAW_FUNGIS_DOWN4
Draw_Fungis_Down4
	DRAW_SIM_TRANS	IM_FUNGIS_DOWN4,DRAW_FUNGIS_DOWN8
Draw_Fungis_Down8
	DRAW_SIM_TRANS	IM_FUNGIS_DOWN8,DRAW_FUNGIS


DRAW_COMP_TRANS	macro
		move.l	#\1,d3
		move.w	#\2,grid_draw(a2)
		bra	\3
		endm

Draw_Mover_Right0
	DRAW_COMP_TRANS	IM_MOVER0,DRAW_MOVER_RIGHT4,Draw_Object_32
Draw_Mover_Right4
	DRAW_COMP_TRANS	IM_MOVER4,DRAW_MOVER_RIGHT8,Draw_Object_32
Draw_Mover_Right8
	DRAW_COMP_TRANS	IM_MOVER8,DRAW_MOVER_RIGHT12,Draw_Object_32
Draw_Mover_Right12
	DRAW_COMP_TRANS	IM_MOVER12,DRAW_MOVER,Draw_Object_32

Draw_Mover_Left0
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_MOVER16,DRAW_MOVER_LEFT4,Draw_Object_32
Draw_Mover_Left4
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_MOVER12,DRAW_MOVER_LEFT8,Draw_Object_32
Draw_Mover_Left8
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_MOVER8,DRAW_MOVER_LEFT12,Draw_Object_32
Draw_Mover_Left12
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_MOVER4,DRAW_MOVER,Draw_Object_32

Draw_Butterfly_Right0
	DRAW_COMP_TRANS	IM_BUTTERFLY0,DRAW_BUTTERFLY_RIGHT4,Draw_Object_32
Draw_Butterfly_Right4
	DRAW_COMP_TRANS	IM_BUTTERFLY4,DRAW_BUTTERFLY_RIGHT8,Draw_Object_32
Draw_Butterfly_Right8
	DRAW_COMP_TRANS	IM_BUTTERFLY8,DRAW_BUTTERFLY_RIGHT12,Draw_Object_32
Draw_Butterfly_Right12
	DRAW_COMP_TRANS	IM_BUTTERFLY12,DRAW_BUTTERFLY,Draw_Object_32

Draw_Butterfly_Left0
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_BUTTERFLY16,DRAW_BUTTERFLY_LEFT4,Draw_Object_32
Draw_Butterfly_Left4
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_BUTTERFLY12,DRAW_BUTTERFLY_LEFT8,Draw_Object_32
Draw_Butterfly_Left8
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_BUTTERFLY8,DRAW_BUTTERFLY_LEFT12,Draw_Object_32
Draw_Butterfly_Left12
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_BUTTERFLY4,DRAW_BUTTERFLY,Draw_Object_32

Draw_Rock_Right0
	DRAW_COMP_TRANS	IM_ROCK0,DRAW_ROCK_RIGHT4,Draw_Object_32
Draw_Rock_Right4
	DRAW_COMP_TRANS	IM_ROCK4,DRAW_ROCK_RIGHT8,Draw_Object_32
Draw_Rock_Right8
	DRAW_COMP_TRANS	IM_ROCK8,DRAW_ROCK_RIGHT12,Draw_Object_32
Draw_Rock_Right12
	DRAW_COMP_TRANS	IM_ROCK12,DRAW_ROCK,Draw_Object_32


Draw_Rock_Left0
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_ROCK16,DRAW_ROCK_LEFT4,Draw_Object_32
Draw_Rock_Left4
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_ROCK12,DRAW_ROCK_LEFT8,Draw_Object_32
Draw_Rock_Left8
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_ROCK8,DRAW_ROCK_LEFT12,Draw_Object_32
Draw_Rock_Left12
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_ROCK4,DRAW_ROCK,Draw_Object_32

Draw_Diamond_Right0
	DRAW_COMP_TRANS	IM_DIAMOND0,DRAW_DIAMOND_RIGHT4,Draw_Object_32
Draw_Diamond_Right4
	DRAW_COMP_TRANS	IM_DIAMOND4,DRAW_DIAMOND_RIGHT8,Draw_Object_32
Draw_Diamond_Right8
	DRAW_COMP_TRANS	IM_DIAMOND8,DRAW_DIAMOND_RIGHT12,Draw_Object_32
Draw_Diamond_Right12
	DRAW_COMP_TRANS	IM_DIAMOND12,DRAW_DIAMOND,Draw_Object_32


Draw_Diamond_Left0
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_DIAMOND16,DRAW_DIAMOND_LEFT4,Draw_Object_32
Draw_Diamond_Left4
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_DIAMOND12,DRAW_DIAMOND_LEFT8,Draw_Object_32
Draw_Diamond_Left8
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_DIAMOND8,DRAW_DIAMOND_LEFT12,Draw_Object_32
Draw_Diamond_Left12
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_DIAMOND4,DRAW_DIAMOND,Draw_Object_32

Draw_Ted_Left0
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_TED_LEFT0,DRAW_TED_LEFT4,Draw_Object_32
Draw_Ted_Left4
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_TED_LEFT4,DRAW_TED_LEFT8,Draw_Object_32
Draw_Ted_Left8
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_TED_LEFT8,DRAW_TED_LEFT12,Draw_Object_32
Draw_Ted_Left12
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_TED_LEFT12,DRAW_TED,Draw_Object_32

Draw_Ted_Right0
	DRAW_COMP_TRANS	IM_TED_RIGHT0,DRAW_TED_RIGHT4,Draw_Object_32
Draw_Ted_Right4
	DRAW_COMP_TRANS	IM_TED_RIGHT4,DRAW_TED_RIGHT8,Draw_Object_32
Draw_Ted_Right8
	DRAW_COMP_TRANS	IM_TED_RIGHT8,DRAW_TED_RIGHT12,Draw_Object_32
Draw_Ted_Right12
	DRAW_COMP_TRANS	IM_TED_RIGHT12,DRAW_TED,Draw_Object_32

Draw_Ted_Dirt_Left0
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_TED_DIRT_LEFT0,DRAW_TED_DIRT_LEFT4,Draw_Object_32
Draw_Ted_Dirt_Left4
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_TED_DIRT_LEFT4,DRAW_TED_DIRT_LEFT8,Draw_Object_32
Draw_Ted_Dirt_Left8
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_TED_DIRT_LEFT8,DRAW_TED_DIRT_LEFT12,Draw_Object_32
Draw_Ted_Dirt_Left12
	subq.l	#2,d2
	DRAW_COMP_TRANS	IM_TED_DIRT_LEFT12,DRAW_TED,Draw_Object_32

Draw_Ted_Dirt_Right0
	DRAW_COMP_TRANS	IM_TED_DIRT_RIGHT0,DRAW_TED_DIRT_RIGHT4,Draw_Object_32
Draw_Ted_Dirt_Right4
	DRAW_COMP_TRANS	IM_TED_DIRT_RIGHT4,DRAW_TED_DIRT_RIGHT8,Draw_Object_32
Draw_Ted_Dirt_Right8
	DRAW_COMP_TRANS	IM_TED_DIRT_RIGHT8,DRAW_TED_DIRT_RIGHT12,Draw_Object_32
Draw_Ted_Dirt_Right12
	DRAW_COMP_TRANS	IM_TED_DIRT_RIGHT12,DRAW_TED,Draw_Object_32

Draw_Ted_Rock_Left0
	subq.l	#4,d2
	DRAW_COMP_TRANS	IM_TED_ROCK_LEFT0,DRAW_TED_ROCK_LEFT4,Draw_Object_48
Draw_Ted_Rock_Left4
	subq.l	#4,d2
	DRAW_COMP_TRANS	IM_TED_ROCK_LEFT4,DRAW_TED_ROCK_LEFT8,Draw_Object_48
Draw_Ted_Rock_Left8
	subq.l	#4,d2
	DRAW_COMP_TRANS	IM_TED_ROCK_LEFT8,DRAW_TED_ROCK_LEFT12,Draw_Object_48
Draw_Ted_Rock_Left12
	subq.l	#4,d2
	DRAW_COMP_TRANS	IM_TED_ROCK_LEFT12,DRAW_TED,Draw_Object_48

Draw_Ted_Rock_Right0
	DRAW_COMP_TRANS	IM_TED_ROCK_RIGHT0,DRAW_TED_ROCK_RIGHT4,Draw_Object_48
Draw_Ted_Rock_Right4
	DRAW_COMP_TRANS	IM_TED_ROCK_RIGHT4,DRAW_TED_ROCK_RIGHT8,Draw_Object_48
Draw_Ted_Rock_Right8
	DRAW_COMP_TRANS	IM_TED_ROCK_RIGHT8,DRAW_TED_ROCK_RIGHT12,Draw_Object_48
Draw_Ted_Rock_Right12
	DRAW_COMP_TRANS	IM_TED_ROCK_RIGHT12,DRAW_TED,Draw_Object_48

Draw_Ted_Down0
	DRAW_COMP_TRANS	IM_TED_DOWN0,DRAW_TED_DOWN4,Draw_Object_Full_Down_32
Draw_Ted_Down4
	DRAW_COMP_TRANS	IM_TED_DOWN4,DRAW_TED_DOWN8,Draw_Object_Full_Down_32
Draw_Ted_Down8
	DRAW_COMP_TRANS	IM_TED_DOWN8,DRAW_TED_DOWN12,Draw_Object_Full_Down_32
Draw_Ted_Down12
	DRAW_COMP_TRANS	IM_TED_DOWN12,DRAW_TED,Draw_Object_Full_Down_32

Draw_Ted_Up0
	sub.l	#GRID_OBJECT_HEIGHT*BM_width,d2
	DRAW_COMP_TRANS	IM_TED_UP0,DRAW_TED_UP4,Draw_Object_Full_Down_32
Draw_Ted_Up4
	sub.l	#GRID_OBJECT_HEIGHT*BM_width,d2
	DRAW_COMP_TRANS	IM_TED_UP4,DRAW_TED_UP8,Draw_Object_Full_Down_32
Draw_Ted_Up8
	sub.l	#GRID_OBJECT_HEIGHT*BM_width,d2
	DRAW_COMP_TRANS	IM_TED_UP8,DRAW_TED_UP12,Draw_Object_Full_Down_32
Draw_Ted_Up12
	sub.l	#GRID_OBJECT_HEIGHT*BM_width,d2
	DRAW_COMP_TRANS	IM_TED_UP12,DRAW_TED,Draw_Object_Full_Down_32

Draw_Rock_Down0
	DRAW_COMP_TRANS	IM_ROCK_DOWN0,DRAW_ROCK_DOWN4,Draw_Object_Full_Down_32
Draw_Rock_Down4
	DRAW_COMP_TRANS	IM_ROCK_DOWN4,DRAW_ROCK_DOWN8,Draw_Object_Full_Down_32
Draw_Rock_Down8
	DRAW_COMP_TRANS	IM_ROCK_DOWN8,DRAW_ROCK_DOWN12,Draw_Object_Full_Down_32
Draw_Rock_Down12
	DRAW_COMP_TRANS	IM_ROCK_DOWN12,DRAW_ROCK,Draw_Object_Full_Down_32

Draw_Mover_Down0
	DRAW_COMP_TRANS	IM_MOVER_DOWN0,DRAW_MOVER_DOWN4,Draw_Object_Full_Down_32
Draw_Mover_Down4
	DRAW_COMP_TRANS	IM_MOVER_DOWN4,DRAW_MOVER_DOWN8,Draw_Object_Full_Down_32
Draw_Mover_Down8
	DRAW_COMP_TRANS	IM_MOVER_DOWN8,DRAW_MOVER_DOWN12,Draw_Object_Full_Down_32
Draw_Mover_Down12
	DRAW_COMP_TRANS	IM_MOVER_DOWN12,DRAW_MOVER,Draw_Object_Full_Down_32

Draw_Butterfly_Down0
	DRAW_COMP_TRANS	IM_BUTTERFLY_DOWN0,DRAW_BUTTERFLY_DOWN4,Draw_Object_Full_Down_32
Draw_Butterfly_Down4
	DRAW_COMP_TRANS	IM_BUTTERFLY_DOWN4,DRAW_BUTTERFLY_DOWN8,Draw_Object_Full_Down_32
Draw_Butterfly_Down8
	DRAW_COMP_TRANS	IM_BUTTERFLY_DOWN8,DRAW_BUTTERFLY_DOWN12,Draw_Object_Full_Down_32
Draw_Butterfly_Down12
	DRAW_COMP_TRANS	IM_BUTTERFLY_DOWN12,DRAW_BUTTERFLY,Draw_Object_Full_Down_32

Draw_Diamond_Down0
	DRAW_COMP_TRANS	IM_DIAMOND_DOWN0,DRAW_DIAMOND_DOWN4,Draw_Object_Full_Down_32
Draw_Diamond_Down4
	DRAW_COMP_TRANS	IM_DIAMOND_DOWN4,DRAW_DIAMOND_DOWN8,Draw_Object_Full_Down_32
Draw_Diamond_Down8
	DRAW_COMP_TRANS	IM_DIAMOND_DOWN8,DRAW_DIAMOND_DOWN12,Draw_Object_Full_Down_32
Draw_Diamond_Down12
	DRAW_COMP_TRANS	IM_DIAMOND_DOWN12,DRAW_DIAMOND,Draw_Object_Full_Down_32

Draw_Mover_Up0
	sub.l	#GRID_OBJECT_HEIGHT*BM_width,d2
	DRAW_COMP_TRANS	IM_MOVER_UP0,DRAW_MOVER_UP4,Draw_Object_Full_Down_32
Draw_Mover_Up4
	sub.l	#GRID_OBJECT_HEIGHT*BM_width,d2
	DRAW_COMP_TRANS	IM_MOVER_UP4,DRAW_MOVER_UP8,Draw_Object_Full_Down_32
Draw_Mover_Up8
	sub.l	#GRID_OBJECT_HEIGHT*BM_width,d2
	DRAW_COMP_TRANS	IM_MOVER_UP8,DRAW_MOVER_UP12,Draw_Object_Full_Down_32
Draw_Mover_Up12
	sub.l	#GRID_OBJECT_HEIGHT*BM_width,d2
	DRAW_COMP_TRANS	IM_MOVER_UP12,DRAW_MOVER,Draw_Object_Full_Down_32

Draw_Butterfly_Up0
	sub.l	#GRID_OBJECT_HEIGHT*BM_width,d2
	DRAW_COMP_TRANS	IM_BUTTERFLY_UP0,DRAW_BUTTERFLY_UP4,Draw_Object_Full_Down_32
Draw_Butterfly_Up4
	sub.l	#GRID_OBJECT_HEIGHT*BM_width,d2
	DRAW_COMP_TRANS	IM_BUTTERFLY_UP4,DRAW_BUTTERFLY_UP8,Draw_Object_Full_Down_32
Draw_Butterfly_Up8
	sub.l	#GRID_OBJECT_HEIGHT*BM_width,d2
	DRAW_COMP_TRANS	IM_BUTTERFLY_UP8,DRAW_BUTTERFLY_UP12,Draw_Object_Full_Down_32
Draw_Butterfly_Up12
	sub.l	#GRID_OBJECT_HEIGHT*BM_width,d2
	DRAW_COMP_TRANS	IM_BUTTERFLY_UP12,DRAW_BUTTERFLY,Draw_Object_Full_Down_32

Draw_Ted_Dirt_Down0
	DRAW_COMP_TRANS	IM_TED_DIRT_DOWN0,DRAW_TED_DIRT_DOWN4,Draw_Object_Full_Down_32
Draw_Ted_Dirt_Down4
	DRAW_COMP_TRANS	IM_TED_DIRT_DOWN4,DRAW_TED_DIRT_DOWN8,Draw_Object_Full_Down_32
Draw_Ted_Dirt_Down8
	DRAW_COMP_TRANS	IM_TED_DIRT_DOWN8,DRAW_TED_DIRT_DOWN12,Draw_Object_Full_Down_32
Draw_Ted_Dirt_Down12
	DRAW_COMP_TRANS	IM_TED_DIRT_DOWN12,DRAW_TED,Draw_Object_Full_Down_32

Draw_Ted_Dirt_Up0
	sub.l	#GRID_OBJECT_HEIGHT*BM_width,d2
	DRAW_COMP_TRANS	IM_TED_DIRT_UP0,DRAW_TED_DIRT_UP4,Draw_Object_Full_Down_32
Draw_Ted_Dirt_Up4
	sub.l	#GRID_OBJECT_HEIGHT*BM_width,d2
	DRAW_COMP_TRANS	IM_TED_DIRT_UP4,DRAW_TED_DIRT_UP8,Draw_Object_Full_Down_32
Draw_Ted_Dirt_Up8
	sub.l	#GRID_OBJECT_HEIGHT*BM_width,d2
	DRAW_COMP_TRANS	IM_TED_DIRT_UP8,DRAW_TED_DIRT_UP12,Draw_Object_Full_Down_32
Draw_Ted_Dirt_Up12
	sub.l	#GRID_OBJECT_HEIGHT*BM_width,d2
	DRAW_COMP_TRANS	IM_TED_DIRT_UP12,DRAW_TED,Draw_Object_Full_Down_32

*********************************************

*
* Show_Time -
*

Show_Time ; (status_planes,image_planes),a3,a4

ShT_REGS	REG	D5/D6/A5

	movem.l	ShT_REGS,-(sp)

* Display Time Left
	lea	time,a5
	move.w	#4-1,d6
	moveq	#0,d5
.ll0
	moveq	#0,d1
* Get Digit
	move.b	(a5)+,d1
* Calc Digit Graph Image Address
	lsl.l	#1,d1
	add.l	#IM_DIGITS,d1
	move.l	d5,d0
* Draw Digit
	bsr	Draw_ST_Object
	addq.l	#2,d5
	dbra	d6,.ll0

.exit	movem.l	(sp)+,ShT_REGS
	rts

*
* Update_Time - 
*

Update_Time
	move.w	time_flag,d0
	cmp.w	#TIMESUP,d0
	beq	.exit

	move.w	integer_time,d0
	subq.w	#1,d0
	move.w	d0,integer_time

	lea	time,a0
* Cijfer 1
	move.b	3(a0),d0
	subq.b	#1,d0
	bpl	.ll1
	move.b	#9,3(a0)
* Cijfer 2
	move.b	2(a0),d0
	subq.b	#1,d0
	bpl.s	.ll2
	move.b	#9,2(a0)
* Cijfer 3
	move.b	1(a0),d0
	subq.b	#1,d0
	bpl.s	.ll3
	move.b	#9,1(a0)
* Cijfer 4
	move.b	(a0),d0
	subq.b	#1,d0
	bpl.s	.ll4
	move.w	#0,integer_time
	move.w	#TIMESUP,time_flag
	move.b	#10,(a0)
	move.b	#11,1(a0)
	move.b	#12,2(a0)
	move.b	#13,3(a0)
	rts
.ll4	move.b	d0,(a0)
	rts
.ll3	move.b	d0,1(a0)
	rts
.ll2	move.b	d0,2(a0)
	rts
.ll1	move.b	d0,3(a0)
.exit	rts

*
* Update_Score -
*

Update_Score ; 
	move.w	#1,score_dirty

	move.w	integer_score,d0
	addq.w	#1,d0
	move.w	d0,integer_score

* Dit Ted reach the game target.
	cmp.w	integer_target,d0
	blo	.more_to_go
	move.w	#TRUE,ted_reach_limit
.more_to_go

	lea	score,a0
* Cijfer 1
	move.b	2(a0),d0
	addq.b	#1,d0
	cmp.b	#10,d0
	bne.s	.ll1
	move.b	#0,2(a0)
* Cijfer 2
	move.b	1(a0),d0
	addq.b	#1,d0
	cmp.b	#10,d0
	bne.s	.ll2
	move.b	#0,1(a0)
* Cijfer 3
	move.b	(a0),d0
	addq.b	#1,d0
	cmp.b	#10,d0
	bne.s	.ll3
	move.b	#0,0(a0)
	rts
.ll3	move.b	d0,(a0)
	rts
.ll2	move.b	d0,1(a0)
	rts
.ll1	move.b	d0,2(a0)
	rts

*
* Show_Score -
*

Show_Score ; (status_planes,image_planes),a3,a4

ShS_REGS	REG	D5/D6/A5

	movem.l	ShS_REGS,-(sp)
	lea	score,a5
	move.w	#3-1,d6
	move.l	#14,d5
.ll0	moveq	#0,d1
* Get Digit
	move.b	(a5)+,d1
* Calc Digit Graph Image Address
	lsl.l	#1,d1
	add.l	#IM_DIGITS,d1
	move.l	d5,d0
* Draw Digit
	bsr	Draw_ST_Object
	addq.l	#2,d5
	dbra	d6,.ll0
	movem.l	(sp)+,ShS_REGS
	rts

*
* Show_Target - Show The Target Score in status display
*

Show_Target ; (status_planes,image_planes),a3,a4

ShTS_REGS	REG	D5/D6/A5

	movem.l	ShTS_REGS,-(sp)
	lea	target,a5
	move.w	#3-1,d6
	move.l	#24,d5
.ll0	moveq	#0,d1
* Get Digit
	move.b	(a5)+,d1
* Calc Digit Graph Image Address
	lsl.l	#1,d1
	add.l	#IM_DIGITS,d1
	move.l	d5,d0
* Draw Digit
	bsr	Draw_ST_Object
	addq.l	#2,d5
	dbra	d6,.ll0
	movem.l	(sp)+,ShTS_REGS
	rts


*
* Draw_ST_Object
*
* A0 - plane pointer         D0 - Offset into display bitmap
* A1 - plane pointer         D1 - Offset into graphics image bitmap
* A3 - display planes        D2 - y_count
* A4 - image planes          D3 - BM_width
*                            D4 - depth count
*                            D5 - GRAPHICS_width
*

Draw_ST_Object ; (display_planes,image_planes,offset_disp,offset_image)
*                 A3             A4           D0          D1

Drtst_REGS	REG	D2/D3/D4/D5

	movem.l	Drtst_REGS,-(sp)

	moveq	#GRAPHICS_width,d5
	moveq	#ST_BM_x/8,d3
	moveq	#4*(GRAPHICS_d-1),d4
.ll0	moveq	#GRID_OBJECT_HEIGHT-1,d2
	move.l	(a3,d4.w),a0
	move.l	(a4,d4.w),a1
	add.l	d0,a0
	add.l	d1,a1
.ll1	move.w	(a1),(a0)
	add.l	d3,a0
	add.l	d5,a1
	dbra	d2,.ll1
	subq.w	#4,d4
	bpl.s	.ll0

	movem.l	(sp)+,Drtst_REGS
	rts


*********************************************
**  Scroll Data  Scroll Data  Scroll Data  **
*********************************************

ted_bitmap_x		dc.l	0	grids
ted_bitmap_y		dc.l	0	grids
ted_grid_field_x	dc.l	0	grids
ted_grid_field_y	dc.l	0	grids
animate_offset_x	dc.l	0	grids
animate_offset_y	dc.l	0	grids

flag_scroll_left	dc.w	0
flag_scroll_right	dc.w	0
flag_scroll_up		dc.w	0
flag_scroll_down	dc.w	0

left_row_update		dc.l	0	grid_field row that will disapear
right_row_update	dc.l	0	grid_field row that will disapear
upper_row_update	dc.l	0	grid_field row that will disapear
lower_row_update	dc.l	0	grid_field row that will disapear

flag_view_scroll_left	dc.w	0
flag_view_scroll_right	dc.w	0
flag_view_scroll_up	dc.w	0
flag_view_scroll_down	dc.w	0

************************************************

time		dc.b	5,0,0,0
score		dc.b	0,0,0
target		dc.b	6,7,0
		even
score_dirty	dc.w	0
integer_time	dc.w	0
integer_target	dc.w	0
integer_score	dc.w	0
time_flag	dc.w	0
ted_wins_flag	dc.w	0
ted_reach_limit	dc.w	0
