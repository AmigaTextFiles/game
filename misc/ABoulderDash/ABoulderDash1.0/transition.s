	opt	L+
	opt	O2+
	opt	OW-

*==========================================
*
* File:        Transition.s
* Version:     1
* Revision:    0
* Created:     6-VII-1993
* By:          FNC Slothouber
* Last Update: 22-Jan-1995
* By:          FNC Slothouber
*
*==========================================

	incdir	"include:"

	include	boulderdash.i

	XDEF	Transition

	XREF	ted_bitmap_x
	XREF	ted_grid_field_x
	XREF	animate_offset_x
	XREF	flag_scroll_left
	XREF	flag_scroll_right
	XREF	left_row_update
	XREF	right_row_update
	XREF	ted_bitmap_y
	XREF	ted_grid_field_y
	XREF	animate_offset_y
	XREF	flag_scroll_up
	XREF	flag_scroll_down
	XREF	upper_row_update
	XREF	lower_row_update


Execute_Trans	macro
	move.l	a3,a2
	move.w	grid_trans(a2),d0
	beq	.ret\@
	pea	.ret\@
	jmp	tabel_access
.ret\@
		endm

**----------------------------------------------------

*
* Transition
*
* A0                        D0
* A1                        D1
* A2 - grid field           D2 - grid_x
* A3 -                      D3 - grid_y
* A4 -                      D4
* A5 -                      D5
* A6                        D6
*                           D7

Transition

	move.w	#GRIDF_HEIGHT-1-6,d3
	add.l	#3*GRIDF_WIDTH*grid_sizeof+(3*grid_sizeof),a2
.ll0	move.w	#GRIDF_WIDTH-1-6,d2
.ll1	move.w	grid_trans(a2),d0
	beq	.next
	pea	.next
	jmp	tabel(pc,d0)
* next grid
.next	addq.l	#grid_sizeof,a2
	dbra	d2,.ll1
	add.l	#6*grid_sizeof,a2
	dbra	d3,.ll0
	rts


******************
*** Jump Table ***
******************
tabel_access
	jmp	tabel(pc,d0)
tabel	jmp	dummy			TRANS_NONE
	jmp	Trans_Down
	jmp	Trans_Left
	jmp	Trans_Ted_Right
	jmp	Trans_Up
	jmp	Trans_Kill_Mover
	jmp	Trans_Kill_Butterfly
	jmp	Trans_Kill_Butterfly2
	jmp	Trans_Kill_Butterfly3
	jmp	Trans_Kill_Butterfly4

	jmp	Trans_To_Empty
	jmp	Trans_To_Fungis
	jmp	Trans_Ted_Right
	jmp	Trans_Rock_Right
	jmp	Trans_Diamond_Right
	jmp	Trans_Mover_Right
	jmp	Trans_Butterfly_Right

	jmp	Trans_Ted_Left
	jmp	Trans_Rock_Left
	jmp	Trans_Diamond_Left
	jmp	Trans_Mover_Left
	jmp	Trans_Butterfly_Left

	jmp	Trans_Ted_Up
	jmp	Trans_Rock_Up
	jmp	Trans_Diamond_Up
	jmp	Trans_Mover_Up
	jmp	Trans_Butterfly_Up

	jmp	Trans_Ted_Down
	jmp	Trans_Rock_Down
	jmp	Trans_Diamond_Down
	jmp	Trans_Mover_Down
	jmp	Trans_Butterfly_Down

	jmp	Trans_Right_Scroll_Left
	jmp	Trans_Left_Scroll_Right
	jmp	Trans_Down_Scroll_Up
	jmp	Trans_Up_Scroll_Down

	jmp	Trans_Ted_Moves_Rock_Left
	jmp	Trans_Ted_Moves_Rock_Right
	jmp	Trans_Ted_Scroll_Moves_Rock_Left
	jmp	Trans_Ted_Scroll_Moves_Rock_Right

	jmp	Trans_Kill_Ted
	jmp	dummy
	jmp	dummy
	jmp	dummy
	jmp	dummy
	jmp	dummy



*************************
** Transition Routines **
*************************

dummy
	rts

*---------------------------------------
*
* Trans_Kill_Butterfly - Replace butterfly by six diamonds
*

Put_Diamond	macro
	move.w	grid_type(a3),d1
	cmp.w	#G_BORDER,d1
	beq.s	.ne\@
	move.w	#DRAW_DIAMOND,grid_draw(a3)
	move.w	#TRANS_NONE,grid_trans(a3)
	move.w	#G_DIAMOND,grid_type(a3)
	move.b	#2,grid_dirty(a3)
	move.b	#0,grid_data(a3)
.ne\@
		endm

*   *       0*0
*   X       000
*           000

Trans_Kill_Butterfly

trkb_REGS	REG	A2/A3

	movem.l	trkb_REGS,-(sp)
	move.l	a2,a3
	Put_Diamond
	add.l	#ONE_LEFT,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_DOWN,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_DOWN,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_RIGHT,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_RIGHT,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_UP,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_LEFT,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_UP+ONE_RIGHT,a3
	Execute_Trans
	Put_Diamond
	movem.l	(sp)+,trkb_REGS
	rts

*           000
*   X*      00*
*           000

Trans_Kill_Butterfly2

	movem.l	trkb_REGS,-(sp)
	move.l	a2,a3
	Put_Diamond
	add.l	#ONE_DOWN,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_LEFT,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_LEFT,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_UP,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_UP,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_RIGHT,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_DOWN,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_UP+ONE_RIGHT,a3
	Execute_Trans
	Put_Diamond
	movem.l	(sp)+,trkb_REGS
	rts

*           000
*   X       000
*   *       0*0

Trans_Kill_Butterfly3

	movem.l	trkb_REGS,-(sp)
	move.l	a2,a3
	Put_Diamond
	add.l	#ONE_LEFT,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_UP,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_UP,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_RIGHT,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_RIGHT,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_DOWN,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_LEFT,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_DOWN+ONE_RIGHT,a3
	Execute_Trans
	Put_Diamond
	movem.l	(sp)+,trkb_REGS
	rts

*           000
*  *X       *00
*           000

Trans_Kill_Butterfly4

	movem.l	trkb_REGS,-(sp)
	move.l	a2,a3
	Put_Diamond
	add.l	#ONE_UP,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_RIGHT,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_RIGHT,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_DOWN,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_DOWN,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_LEFT,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_UP,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_DOWN+ONE_LEFT,a3
	Execute_Trans
	Put_Diamond
	movem.l	(sp)+,trkb_REGS
	rts


*-------------------------------------------------
*
* Trans_Kill_Ted - Replace Ted by six diamonds
*

*           000
*   X       0x0
*           000

Trans_Kill_Ted

trkt_REGS	REG	A2/A3

	movem.l	trkt_REGS,-(sp)
	move.l	a2,a3
	Put_Diamond
	add.l	#ONE_LEFT,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_DOWN,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_RIGHT,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_RIGHT,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_UP,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_UP,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_LEFT,a3
	Execute_Trans
	Put_Diamond
	add.l	#ONE_LEFT,a3
	Execute_Trans
	Put_Diamond
	movem.l	(sp)+,trkt_REGS
	rts

*-------------------------------------------------
*
* Trans_Kill_Mover - Replace mover by six empty grids
*

Put_Empty	macro
	move.w	grid_type(a3),d1
	cmp.w	#G_BORDER,d1
	beq.s	.ne\@
	move.w	#DRAW_EMPTY,grid_draw(a3)
	move.w	#TRANS_NONE,grid_trans(a3)
	move.w	#G_EMPTY,grid_type(a3)
	move.b	#2,grid_dirty(a3)
	move.b	#EMPTY_REAL_EMPTY,grid_data(a3)
.ne\@
		endm

Trans_Kill_Mover

trkm_REGS	REG	A2/A3

	movem.l	trkm_REGS,-(sp)
	move.l	a2,a3
	Put_Empty
	add.l	#ONE_LEFT,a3
	Execute_Trans
	Put_Empty
	add.l	#ONE_DOWN,a3
	Execute_Trans
	Put_Empty
	add.l	#ONE_DOWN,a3
	Execute_Trans
	Put_Empty
	add.l	#ONE_RIGHT,a3
	Execute_Trans
	Put_Empty
	add.l	#ONE_RIGHT,a3
	Execute_Trans
	Put_Empty
	add.l	#ONE_UP,a3
	Execute_Trans
	Put_Empty
	add.l	#ONE_LEFT,a3
	Execute_Trans
	Put_Empty
	add.l	#ONE_UP+ONE_RIGHT,a3
	Execute_Trans
	Put_Empty
	movem.l	(sp)+,trkm_REGS
	rts

*---------------------------------------
*
* Trans_Ted_Scroll_Moves_Rock_Right -
* Move Ted and rock one grid to the Right
*

Trans_Ted_Scroll_Moves_Rock_Right
	move.l	a2,a0
	add.l	#2*ONE_RIGHT,a0
	move.w	#DRAW_ROCK,grid_draw(a0)
	move.w	#TRANS_NONE,grid_trans(a0)
	move.w	#G_ROCK,grid_type(a0)
	move.b	#2,grid_dirty(a0)
	move.b	#0,grid_data(a0)

*---------------------------------------
*
* Trans_Right_Scroll_Left - Move Ted to the right scroll display to the left
*

Trans_Right_Scroll_Left

	move.l	ted_bitmap_x,d0
	subq.l	#grid_sizeof,d0
	move.l	d0,ted_bitmap_x

	move.l	animate_offset_x,d0
	addq.l	#grid_sizeof,d0
	move.l	d0,animate_offset_x

	move.l	left_row_update,d0
	addq.l	#grid_sizeof,d0
	move.l	d0,left_row_update

	move.l	right_row_update,d0
	addq.l	#grid_sizeof,d0
	move.l	d0,right_row_update

	move.w	#DO_SCROLL,flag_scroll_left

	move.w	#DRAW_TED,d0
	bra	Trans_Right


*---------------------------------------
*
* Trans_Ted_Scroll_Moves_Rock_Left -
* Move Ted and rock one grid to the left
*

Trans_Ted_Scroll_Moves_Rock_Left
	move.l	a2,a0
	add.l	#2*ONE_LEFT,a0
	move.w	#DRAW_ROCK,grid_draw(a0)
	move.w	#TRANS_NONE,grid_trans(a0)
	move.w	#G_ROCK,grid_type(a0)
	move.b	#2,grid_dirty(a0)
	move.b	#0,grid_data(a0)

*---------------------------------------
*
* Trans_Left_Scroll_Right - Move Ted to the left scroll display to the right
*

Trans_Left_Scroll_Right

	move.l	ted_bitmap_x,d0
	addq.l	#grid_sizeof,d0
	move.l	d0,ted_bitmap_x

	move.l	animate_offset_x,d0
	subq.l	#grid_sizeof,d0
	move.l	d0,animate_offset_x

	move.l	left_row_update,d0
	subq.l	#grid_sizeof,d0
	move.l	d0,left_row_update

	move.l	right_row_update,d0
	subq.l	#grid_sizeof,d0
	move.l	d0,right_row_update

	move.w	#DO_SCROLL,flag_scroll_right

	move.w	#DRAW_TED,d0
	bra	Trans_Left

*---------------------------------------
*
* Trans_Down_Scroll_Up - Move Ted Downwards scroll display Upwards
*

Trans_Down_Scroll_Up

	move.l	#grid_sizeof*GRIDF_WIDTH,d1

	move.l	ted_bitmap_y,d0
	sub.l	d1,d0
	move.l	d0,ted_bitmap_y

	move.l	animate_offset_y,d0
	add.l	d1,d0
	move.l	d0,animate_offset_y

	move.l	upper_row_update,d0
	add.l	d1,d0
	move.l	d0,upper_row_update

	move.l	lower_row_update,d0
	add.l	d1,d0
	move.l	d0,lower_row_update

	move.w	#DO_SCROLL,flag_scroll_up

	move.w	#DRAW_TED,d0
	bra	Trans_Down

*---------------------------------------
*
* Trans_Up_Scroll_Down - Move Ted Upwards scroll display downwards
*

Trans_Up_Scroll_Down

	move.l	#grid_sizeof*GRIDF_WIDTH,d1

	move.l	ted_bitmap_y,d0
	add.l	d1,d0
	move.l	d0,ted_bitmap_y

	move.l	animate_offset_y,d0
	sub.l	d1,d0
	move.l	d0,animate_offset_y

	move.l	upper_row_update,d0
	sub.l	d1,d0
	move.l	d0,upper_row_update

	move.l	lower_row_update,d0
	sub.l	d1,d0
	move.l	d0,lower_row_update

	move.w	#DO_SCROLL,flag_scroll_down

	move.w	#DRAW_TED,d0
	bra	Trans_Up

*---------------------------------------
*
* Trans_Ted_Moves_Rock_Left -
* Move Ted and rock one grid to the left
*

Trans_Ted_Moves_Rock_Left
	move.l	a2,a0
	add.l	#ONE_LEFT,a0
	move.w	#DRAW_TED,grid_draw(a0)
	move.w	#TRANS_NONE,grid_trans(a0)
	move.w	#G_TED,grid_type(a0)
	move.b	#2,grid_dirty(a0)
	move.b	grid_data(a2),grid_data(a0)

	add.l	#ONE_LEFT,a0
	move.w	#DRAW_ROCK,grid_draw(a0)
	move.w	#TRANS_NONE,grid_trans(a0)
	move.w	#G_ROCK,grid_type(a0)
	move.b	#2,grid_dirty(a0)
	move.b	#0,grid_data(a0)

	move.w	#DRAW_EMPTY,grid_draw(a2)
	move.w	#TRANS_NONE,grid_trans(a2)
	move.w	#G_EMPTY,grid_type(a2)
	move.b	#2,grid_dirty(a2)
	move.b	#EMPTY_REAL_EMPTY,grid_data(a2)
	rts

*---------------------------------------
*
* Trans_Ted_Moves_Rock_Right -
* Move Ted and rock one grid to the right
*

Trans_Ted_Moves_Rock_Right

	move.l	a2,a0
	add.l	#ONE_RIGHT,a0
	move.w	#DRAW_TED,grid_draw(a0)
	move.w	#TRANS_NONE,grid_trans(a0)
	move.w	#G_TED,grid_type(a0)
	move.b	#2,grid_dirty(a0)
	move.b	grid_data(a2),grid_data(a0)

	add.l	#ONE_RIGHT,a0
	move.w	#DRAW_ROCK,grid_draw(a0)
	move.w	#TRANS_NONE,grid_trans(a0)
	move.w	#G_ROCK,grid_type(a0)
	move.b	#2,grid_dirty(a0)
	move.b	#0,grid_data(a0)

	move.w	#DRAW_EMPTY,grid_draw(a2)
	move.w	#TRANS_NONE,grid_trans(a2)
	move.w	#G_EMPTY,grid_type(a2)
	move.b	#2,grid_dirty(a2)
	move.b	#EMPTY_REAL_EMPTY,grid_data(a2)
	rts

*---------------------------------------
*
* Trans_To_Empty - Change type of object to Empty
*

Trans_To_Empty
	move.w	#G_EMPTY,grid_type(a2)
	move.w	#TRANS_NONE,grid_trans(a2)
	move.w	#DRAW_EMPTY,grid_draw(a2)
	move.b	#2,grid_dirty(a2)
	move.b	#EMPTY_REAL_EMPTY,grid_data(a2)
	rts

*---------------------------------------
*
* Trans_To_Fungis - Change type of object to Fungis
*

Trans_To_Fungis
	move.w	#G_FUNGIS,grid_type(a2)
	move.w	#TRANS_NONE,grid_trans(a2)
	move.w	#DRAW_FUNGIS,grid_draw(a2)
	move.b	#2,grid_dirty(a2)
	rts

*---------------------------------------
*
* Trans_Down - Move Object one grid down
*

Trans_Ted_Down
	move.w	#DRAW_TED,d0
	bra	Trans_Down
Trans_Rock_Down
	move.w	#DRAW_ROCK,d0
	bra	Trans_Down
Trans_Diamond_Down
	move.w	#DRAW_DIAMOND,d0
	bra	Trans_Down
Trans_Mover_Down
	move.w	#DRAW_MOVER,d0
	bra	Trans_Down
Trans_Butterfly_Down
	move.w	#DRAW_BUTTERFLY,d0
	bra	Trans_Down

Trans_Down
	move.l	a2,a0
	add.l	#ONE_DOWN,a0
	move.w	d0,grid_draw(a0)
	move.w	#TRANS_NONE,grid_trans(a0)
	move.w	grid_type(a2),grid_type(a0)
	move.b	#2,grid_dirty(a0)
	move.b	grid_data(a2),grid_data(a0)

	move.w	#DRAW_EMPTY,grid_draw(a2)
	move.w	#TRANS_NONE,grid_trans(a2)
	move.w	#G_EMPTY,grid_type(a2)
	move.b	#2,grid_dirty(a2)
	move.b	#EMPTY_REAL_EMPTY,grid_data(a2)
	rts

* Trans_Left - Move Object one grid to the left

Trans_Ted_Left
	move.w	#DRAW_TED,d0
	bra	Trans_Left
Trans_Rock_Left
	move.w	#DRAW_ROCK,d0
	bra	Trans_Left
Trans_Diamond_Left
	move.w	#DRAW_DIAMOND,d0
	bra	Trans_Left
Trans_Mover_Left
	move.w	#DRAW_MOVER,d0
	bra	Trans_Left
Trans_Butterfly_Left
	move.w	#DRAW_BUTTERFLY,d0
	bra	Trans_Left

Trans_Left
	move.l	a2,a0
	add.l	#ONE_LEFT,a0
	move.w	d0,grid_draw(a0)
	move.w	#TRANS_NONE,grid_trans(a0)
	move.w	grid_type(a2),grid_type(a0)
	move.b	#2,grid_dirty(a0)
	move.b	grid_data(a2),grid_data(a0)

	move.w	#DRAW_EMPTY,grid_draw(a2)
	move.w	#TRANS_NONE,grid_trans(a2)
	move.w	#G_EMPTY,grid_type(a2)
	move.b	#2,grid_dirty(a2)
	move.b	#EMPTY_REAL_EMPTY,grid_data(a2)
	rts

* Trans_Right - Move Object one grid to the right

Trans_Ted_Right
	move.w	#DRAW_TED,d0
	bra	Trans_Right
Trans_Rock_Right
	move.w	#DRAW_ROCK,d0
	bra	Trans_Right
Trans_Diamond_Right
	move.w	#DRAW_DIAMOND,d0
	bra	Trans_Right
Trans_Mover_Right
	move.w	#DRAW_MOVER,d0
	bra	Trans_Right
Trans_Butterfly_Right
	move.w	#DRAW_BUTTERFLY,d0
	bra	Trans_Right

Trans_Right
	move.l	a2,a0
	add.l	#ONE_RIGHT,a0
	move.w	d0,grid_draw(a0)
	move.w	#TRANS_NONE,grid_trans(a0)
	move.w	grid_type(a2),grid_type(a0)
	move.b	#2,grid_dirty(a0)
	move.b	grid_data(a2),grid_data(a0)

	move.w	#DRAW_EMPTY,grid_draw(a2)
	move.w	#TRANS_NONE,grid_trans(a2)
	move.w	#G_EMPTY,grid_type(a2)
	move.b	#2,grid_dirty(a2)
	move.b	#EMPTY_REAL_EMPTY,grid_data(a2)
	rts

* Trans_Up - Move Object one grid up

Trans_Ted_Up
	move.w	#DRAW_TED,d0
	bra	Trans_Up
Trans_Rock_Up
	move.w	#DRAW_ROCK,d0
	bra	Trans_Up
Trans_Diamond_Up
	move.w	#DRAW_DIAMOND,d0
	bra	Trans_Up
Trans_Mover_Up
	move.w	#DRAW_MOVER,d0
	bra	Trans_Up
Trans_Butterfly_Up
	move.w	#DRAW_BUTTERFLY,d0
	bra	Trans_Up

Trans_Up
	move.l	a2,a0
	add.l	#ONE_UP,a0
	move.w	d0,grid_draw(a0)
	move.w	#TRANS_NONE,grid_trans(a0)
	move.w	grid_type(a2),grid_type(a0)
	move.b	#2,grid_dirty(a0)
	move.b	grid_data(a2),grid_data(a0)

	move.w	#DRAW_EMPTY,grid_draw(a2)
	move.w	#TRANS_NONE,grid_trans(a2)
	move.w	#G_EMPTY,grid_type(a2)
	move.b	#2,grid_dirty(a2)
	move.b	#EMPTY_REAL_EMPTY,grid_data(a2)
	rts

