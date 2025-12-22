*
* Sprite related functions
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* init_gamesprites()
* load_gamesprites()
* activate_gamesprites()
* update_gamesprites(d0=score|lives.b, d1.b=gems)
* d0=flag = move_infosprite_right()
* d0=flag = move_infosprite_left()
* draw_infosprite_text(a0=text)
*

	include	"display.i"
	include	"font.i"
	include	"sprite.i"
	include	"files.i"


; from memory.asm
	xref	alloc_chipmem
	xref	save_chipmem
	xref	restore_chipmem

; from trackdisk.asm
	xref	td_loadcr_chip

; from main.asm
	xref	loaderr

; from display.asm
	xref	init_sprite
	xref	set_asprite

; from font.asm
	xref	gfont8_spriteprint



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	init_gamesprites
init_gamesprites:
; Allocate memory for sprite display lists and move all sprites to
; their initial positions on the screen.

	movem.l	d2-d3,-(sp)

	; attached sprite 0/1: score, info, gem-icon, hero-icon
	move.l	#SPR01_LWORDS,d0
	bsr	alloc_attached_sprites

	movem.l	a0-a1,ScoreSpr0(a4)
	moveq	#SCORE_SPRX,d0
	moveq	#SCORE_SPRY,d1
	moveq	#SCORE_SPRH,d2
	bsr	set_attached_sprites	; score sprites, left digits

	movem.l	a0-a1,GemsSpr0(a4)
	move.w	#GEMS_SPRX,d0
	move.w	#GEMS_SPRY,d1
	moveq	#GEMSICON_SPRH,d2
	bsr	set_attached_sprites	; gem icon (gem image)

	movem.l	a0-a1,InfoSpr0(a4)
	moveq	#-32,d0
	moveq	#INFO_SPRY,d1
	moveq	#INFO_SPRH,d2
	bsr	set_attached_sprites	; info sprites, left part

	movem.l	a0-a1,LivesSpr0(a4)
	move.w	#LIVES_SPRX,d0
	move.w	#LIVES_SPRY,d1
	moveq	#LIVESICON_SPRH,d2
	bsr	set_attached_sprites	; lives icon (hero's head)

	clr.l	(a0)			; end of sprite display lists
	clr.l	(a1)

	; attached sprite 2/3: score, info, gem-counter, hero-lives
	move.l	#SPR23_LWORDS,d0
	bsr	alloc_attached_sprites

	movem.l	a0-a1,ScoreSpr2(a4)
	moveq	#SCORE_SPRX+16,d0
	moveq	#SCORE_SPRY,d1
	moveq	#SCORE_SPRH,d2
	bsr	set_attached_sprites	; score sprites, mid digits

	movem.l	a0-a1,GemsSpr2(a4)
	move.w	#GEMS_SPRX+16,d0
	move.w	#GEMS_SPRY+(GEMSICON_SPRH-GEMSNUM_SPRH)/2,d1
	moveq	#GEMSNUM_SPRH,d2
	bsr	set_attached_sprites	; number of gems collected

	movem.l	a0-a1,InfoSpr2(a4)
	moveq	#-32,d0
	moveq	#INFO_SPRY,d1
	moveq	#INFO_SPRH,d2
	bsr	set_attached_sprites	; info sprites, middle part

	movem.l	a0-a1,LivesSpr2(a4)
	move.w	#LIVES_SPRX+16,d0
	move.w	#LIVES_SPRY+(LIVESICON_SPRH-LIVESNUM_SPRH)/2,d1
	moveq	#LIVESNUM_SPRH,d2
	bsr	set_attached_sprites	; number of lives

	clr.l	(a0)			; end of sprite display lists
	clr.l	(a1)

	; attached sprite 4/5: score, info
	move.l	#SPR45_LWORDS,d0
	bsr	alloc_attached_sprites

	movem.l	a0-a1,ScoreSpr4(a4)
	moveq	#SCORE_SPRX+32,d0
	moveq	#SCORE_SPRY,d1
	moveq	#SCORE_SPRH,d2
	bsr	set_attached_sprites	; score sprites, right digits

	movem.l	a0-a1,InfoSpr4(a4)
	moveq	#-32,d0
	moveq	#INFO_SPRY,d1
	moveq	#INFO_SPRH,d2
	bsr	set_attached_sprites	; info sprites, right part

	clr.l	(a0)			; end of sprite display lists
	clr.l	(a1)

	movem.l	(sp)+,d2-d3
	rts


set_attached_sprites:
; a0 = pointer to sprite control words (even sprite)
; a1 = pointer to sprite control words (odd sprite)
; d0.w = xpos
; d1.w = ypos
; d2.w = height
; -> a0 = pointer to next control words in the even sprite's display list
; -> a1 = pointer to next control words in the odd sprite's display list
; d2/d3 are destroyed!

	move.w	d2,d3
	addq.w	#1,d3
	lsl.w	#2,d3
	bsr	set_asprite
	add.w	d3,a0
	add.w	d3,a1
	rts


alloc_attached_sprites:
; d0 = height of all sprites in the display list, control words included
; -> a0 = even sprite display list
; -> a1 = odd sprite display list

	lsl.l	#2,d0
	move.l	d0,-(sp)
	add.l	d0,d0
	bsr	alloc_chipmem		; two display lists
	move.l	d0,a0
	move.l	a0,a1
	add.l	(sp)+,a1
	rts


;---------------------------------------------------------------------------
	xdef	load_gamesprites
load_gamesprites:
; Load sprite images into a temporary buffer. Then copy the images into
; the sprite display lists, which were initialized during init_gamesprites.

	move.l	a2,-(sp)

	; allocate temporary Chip RAM
	bsr	save_chipmem
	move.l	d0,-(sp)

	; Load sprites. The file has the following contents:
	; - Hero head Sprite A, Hero head Sprite B
	; - Gem Sprite A, Gem Sprite B
	moveq	#FIL_GAMESPRITES,d0
	bsr	td_loadcr_chip
	beq	loaderr
	move.l	d0,a2

	; copy hero's head into two attached sprites
	move.l	LivesSpr0(a4),a0
	moveq	#LIVESICON_SPRH,d0
	bsr	copy_sprite_image
	move.l	LivesSpr1(a4),a0
	moveq	#LIVESICON_SPRH,d0
	bsr	copy_sprite_image

	; copy gem image into two attached sprites
	move.l	GemsSpr0(a4),a0
	moveq	#GEMSICON_SPRH,d0
	bsr	copy_sprite_image
	move.l	GemsSpr1(a4),a0
	moveq	#GEMSICON_SPRH,d0
	bsr	copy_sprite_image

	; deallocate temporary Chip RAM buffer
	move.l	(sp)+,a0
	bsr	restore_chipmem

	; clear the info sprites
	lea	InfoSpr0(a4),a1
	moveq	#5,d1
.1:	move.l	(a1)+,a0
	addq.l	#4,a0
	moveq	#INFO_SPRH-1,d0
.2:	clr.l	(a0)+
	dbf	d0,.2
	dbf	d1,.1

	move.l	(sp)+,a2
	rts


copy_sprite_image:
; a2 = image to copy
; a0 = destination pointer to sprite's control words
; d0 = height of that sprite
; -> a2 = next image

	addq.l	#4,a0
	subq.w	#1,d0
.1:	move.l	(a2)+,(a0)+
	dbf	d0,.1
	rts


;---------------------------------------------------------------------------
	xdef	activate_gamesprites
activate_gamesprites:
; Initialize our game sprites, to display the score and other information
; on the screen, and enter them into both copper lists.
; Make sure the info-sprites are moved out of the visible display.
; The other sprites have a fixed position during the whole game.

	movem.l	d2/a2,-(sp)

	; Our six sprite display lists start at ScoreSpr0..5. Load them.
	lea	ScoreSpr0(a4),a2
	moveq	#5,d2
.1:	move.l	(a2)+,a0
	moveq	#5,d0
	sub.w	d2,d0
	bsr	init_sprite
	dbf	d2,.1

	; Move the info sprites to an invisible region, left of the display.
	clr.w	OldInfoXpos(a4)
	moveq	#-64,d0
	move.w	d0,InfoXpos(a4)
	bsr	update_info_sprites

	; Invalidate score, gems and lives, to make them redraw next time.
	moveq	#-1,d0
	move.l	d0,Score(a4)
	move.b	d0,Gems(a4)

	movem.l	(sp)+,d2/a2
	rts


;---------------------------------------------------------------------------
draw_digits:
; Draw two digits using the 8-pixel game font into the sprite.
; d2.b = two BCD digits
; d3 = '0'
; a2 = even sprite
; a3 = odd sprite
; Destroys d2.b, a2, a3!

	lea	5(a2),a0
	lea	5(a3),a1
	moveq	#15,d0
	and.b	d2,d0
	add.b	d3,d0
	bsr	gfont8_spriteprint

	lea	4(a2),a0
	lea	4(a3),a1
	moveq	#15,d0
	lsr.b	#4,d2
	and.b	d2,d0
	add.b	d3,d0
	bra	gfont8_spriteprint


;---------------------------------------------------------------------------
	xdef	update_gamesprites
update_gamesprites:
; Update changed digits in the score and number-of-lives sprites.
; d0 = BCD-score in bits 31-8, BCD-lives in bits 7-0
; d1.b = BCD gems collected

	cmp.l	Score(a4),d0
	bne	.update
	cmp.b	Gems(a4),d1
	beq	update_info_sprites	; score/gems/lives didn't change

.update:
	movem.l	d0/d2-d3/a2-a3/a5,-(sp)
	move.b	d1,d2			; gems
	moveq	#'0',d3
	lea	Gems+1(a4),a5

	; gems collected
	cmp.b	-(a5),d2
	beq	.1
	move.b	d2,(a5)			; update gem counter
	movem.l	GemsSpr2(a4),a2-a3
	bsr	draw_digits

	; number of lives
.1:	move.l	(sp)+,d2		; restore score and number of lives
	cmp.b	-(a5),d2
	beq	.2
	move.b	d2,(a5)			; update number of lives
	movem.l	LivesSpr2(a4),a2-a3
	bsr	draw_digits

	; last two score digits
.2:	lsr.l	#8,d2
	cmp.b	-(a5),d2
	beq	.3
	move.b	d2,(a5)			; update last two score digits
	movem.l	ScoreSpr4(a4),a2-a3
	bsr	draw_digits

	; middle two score digits
.3:	lsr.l	#8,d2
	cmp.b	-(a5),d2
	beq	.4
	move.b	d2,(a5)			; update middle two score digits
	movem.l	ScoreSpr2(a4),a2-a3
	bsr	draw_digits

	; first two score digits
.4:	lsr.l	#8,d2
	cmp.b	-(a5),d2
	beq	.5
	move.b	d2,(a5)			; update first two score digits
	movem.l	ScoreSpr0(a4),a2-a3
	bsr	draw_digits

.5:	movem.l	(sp)+,d2-d3/a2-a3/a5


;---------------------------------------------------------------------------
update_info_sprites:
; Move the three info sprites to the horizontal position from InfoXpos.

	move.w	InfoXpos(a4),d0
	cmp.w	OldInfoXpos(a4),d0
	beq	.2

	movem.l	d2-d4/a2,-(sp)

	move.w	d0,OldInfoXpos(a4)
	lea	InfoSpr0(a4),a2
	move.w	d0,d3
	moveq	#2,d4

.1:	movem.l	(a2)+,a0-a1
	move.w	d3,d0
	moveq	#INFO_SPRY,d1
	moveq	#INFO_SPRH,d2
	bsr	set_asprite
	add.w	#16,d3
	dbf	d4,.1

	movem.l	(sp)+,d2-d4/a2
.2:	rts


;---------------------------------------------------------------------------
	xdef	move_infosprite_right
move_infosprite_right:
; Move the info sprites right, until centered on the display.
; -> d0 = true, when center is reached

	moveq	#0,d0
	moveq	#INFO_VXRIGHT,d1
	add.w	InfoXpos(a4),d1
	cmp.w	#(DISPW-3*16)/2,d1
	blt	.1

	; center reached
	move.w	#(DISPW-3*16)/2,d1
	moveq	#1,d0

.1:	move.w	d1,InfoXpos(a4)
	rts


;---------------------------------------------------------------------------
	xdef	move_infosprite_left
move_infosprite_left:
; Move the info sprites left, until they are no longer visible.
; -> d0 = true, when the last sprite left the visible display

	moveq	#0,d0
	moveq	#-INFO_VXLEFT,d1
	add.w	InfoXpos(a4),d1
	cmp.w	#-64,d1
	bgt	.1

	; left the display
	moveq	#-64,d1
	moveq	#1,d0

.1:	move.w	d1,InfoXpos(a4)
	rts


;---------------------------------------------------------------------------
	xdef	draw_infosprite_text
draw_infosprite_text:
; Draw two lines of 6 characters using the 8x8 game font into the
; three attached info sprite pairs.
; a0 = 12 characters of ASCII text

	movem.l	a2-a3/a5,-(sp)
	move.l	a0,a5
	movem.l	InfoSpr0(a4),a2-a3
	bsr	draw_info_chars
	movem.l	InfoSpr2(a4),a2-a3
	bsr	draw_info_chars
	movem.l	InfoSpr4(a4),a2-a3
	bsr	draw_info_chars
	movem.l	(sp)+,a2-a3/a5
	rts


draw_info_chars:
; Draw four characters into a sprite-pair. Two in ROW1 and two in ROW2.
; a2 = even sprite
; a3 = odd sprite
; a5 = character pointer
; -> a5 = new character pointer (two positions right)
	lea	INFO_SPR_ROW2(a2),a0
	lea	INFO_SPR_ROW2(a3),a1
	move.b	6(a5),d0
	bsr	gfont8_spriteprint

	lea	INFO_SPR_ROW1(a2),a0
	lea	INFO_SPR_ROW1(a3),a1
	move.b	(a5)+,d0
	bsr	gfont8_spriteprint

	lea	INFO_SPR_ROW2+1(a2),a0
	lea	INFO_SPR_ROW2+1(a3),a1
	move.b	6(a5),d0
	bsr	gfont8_spriteprint

	lea	INFO_SPR_ROW1+1(a2),a0
	lea	INFO_SPR_ROW1+1(a3),a1
	move.b	(a5)+,d0
	bra	gfont8_spriteprint



	section	__MERGED,bss


	; Pointers to game sprite control words.
	; We use three attached sprites (six sprite channels) to display
	; the score, three attached sprites to display information
	; texts in the middle of screen, two attached sprites for the
	; number of gems collected and two attached sprites for the number
	; of lives left, in the bottom right edge.
	; The sprite display lists start with the score sprite, which is
	; in the upper left corner.
ScoreSpr0:
	ds.l	1
ScoreSpr1:
	ds.l	1
ScoreSpr2:
	ds.l	1
ScoreSpr3:
	ds.l	1
ScoreSpr4:
	ds.l	1
ScoreSpr5:
	ds.l	1
InfoSpr0:
	ds.l	1
InfoSpr1:
	ds.l	1
InfoSpr2:
	ds.l	1
InfoSpr3:
	ds.l	1
InfoSpr4:
	ds.l	1
InfoSpr5:
	ds.l	1
GemsSpr0:
	ds.l	1
GemsSpr1:
	ds.l	1
GemsSpr2:
	ds.l	1
GemsSpr3:
	ds.l	1
LivesSpr0:
	ds.l	1
LivesSpr1:
	ds.l	1
LivesSpr2:
	ds.l	1
LivesSpr3:
	ds.l	1

	; X position of leftmost info sprite
InfoXpos:
	ds.w	1
OldInfoXpos:
	ds.w	1

	; Copy of score, gems and number of lives, which is currently shown
	; in the ScoreSpr, GemsSpr and LivesSpr.
Score:
	ds.b	3
Lives:
	ds.b	1
Gems:
	ds.b	1
	even
