*
* Hero physics
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* loadHero()
* initHero()
* $updateHero()
* $updateLevDone()
* killHero()
* bounceAlignHero(d0.w=bounce_vy, d1.w=obj_top_y)
* d0=xpos, d1=ypos = getHeroPos()
* lookupStartPos()
* d0=startx, d1=starty = getStart()
*
* HeroColors
* HeroAnims
* Hero
* Hero_alive
* Hero_vy
*

	include	"display.i"
	include	"view.i"
	include	"map.i"
	include	"mob.i"
	include	"hero.i"
	include	"levelstats.i"
	include "sound.i"
	include	"files.i"
	include	"macros.i"


; from memory.asm
	xref	alloc_chipmem

; from trackdisk.asm
	xref	td_loadcr_chip

; from main.asm
	xref	loaderr
	xref	panic
	xref	Button
	xref	UpDown
	xref	LeftRight

; from game.asm
	xref	addScore
	xref	addLives
	xref	addGems
	xref	Status
	xref	SolidBlocks
	xref	BackgdBlocks
	xref	FgBlockTypes

; from levelstats.asm
	xref	StatAct

; from map.asm
	xref	MapRowOffTab
	xref	Map
	xref	FgMap
	xref	MapWidth
	xref	MapHeight
	xref	ScrWidth
	xref	ScrHeight

; from monster.asm
	xref	MultiKill

; from illuminate.asm
	xref	start_illumination
	xref	IllumTimer

; from bob.asm
	xref	newBOB

; from scroll.asm
	xref	moveView

; from tiles.asm
	xref	makeBlkTable
	xref	switchTiles
	xref	newSingleTileAnim
	xref	newTileAnimSeq

; from levelstat.asm
	xref	LevelDistance
	xref	LevelJumps

; from sound.asm
	xref	playSFX



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	loadHero
loadHero:
; load the hero animations into memory

	move.l	a2,-(sp)

	; load animations into Chip RAM
	moveq	#FIL_HERO22,d0
	bsr	td_loadcr_chip
	beq	loaderr
	move.l	d0,a2

	; make hero image pointer table
	lea	HeroImgTypes,a0
	lea	HeroAnims(a4),a1
	move.w	#MAXHEROSLOTS,d0
	move.w	#HEROSIZE,d1
	bsr	makeBlkTable

	; make sure hero's background color is black
	clr.w	HeroColors(a4)

	move.l	(sp)+,a2
	rts


;---------------------------------------------------------------------------
	xdef	initHero
initHero:
; Place hero onto the start position and initialize his status.

	;--------------------
	; Initialize the MOB
	;--------------------

	lea	Hero(a4),a0		; MOB

	; The start block in the map defines the position of the
	; hero's feet. So we have to take the hero's height into
	; account when translating the position into pixel coordinates.
	movem.w	StartX(a4),d0-d1
	lsl.w	#4,d0
	move.w	d0,(a0)+		; MOxpos
	lsl.w	#4,d1
	sub.w	#HEROH-16,d1
	move.w	d1,(a0)+		; MOypos
	move.w	#HEROH,(a0)+		; MOheight
	move.w	#1,(a0)+		; MOwidth
	move.l	HeroAnims+HERO_IDLE(a4),a1
	move.l	a1,(a0)+		; MOimage, initially idle
	lea	HEROSIZE(a1),a1
	move.l	a1,(a0)			; MOmask

	; create a new BOB for our hero
	lea	Hero(a4),a0
	bsr	newBOB
	beq	.nobob

	;----------------------------------
	; initialize hero status variables
	;----------------------------------

	; no horizontal movement, caused by the environment
	clr.w	Hero_vx(a4)

	; normal gravity
	move.w	#HEROGRAV_NORM,Hero_vy(a4)

	; reset bounce speed
	move.w	#HEROGRAV_BOUNCE,Hero_bouncevy(a4)

	; start in idle mode
	move.w	#HERO_IDLETIME,Hero_idleCnt(a4)

	; initial facing and animation phase
	move.l	#FACING_MID<<16|HERO_IDLE,Hero_facing(a4)
	clr.w	Hero_animCnt(a4)

	; is not yet alive, no dying animation
	clr.b	Hero_alive(a4)
	clr.w	Hero_dyingAnim(a4)

	; not standing on a bridge
	clr.l	Hero_bridge(a4)

	; clear movement
	clr.b	Hero_lastLeft(a4)
	clr.b	Hero_lastRight(a4)
	clr.b	Hero_lastJump(a4)
	clr.b	Hero_bounced(a4)
	clr.b	Hero_inflight(a4)
	clr.b	Hero_climb(a4)

	rts

.nobob:
	move.w	#$ff8,d0		; light yellow: out of BOBs
	bra	panic


;---------------------------------------------------------------------------
	xdef	updateHero
updateHero:
; Update hero movement and status. Check collisions.
; Registers, except a4 - a6, are not preserved!

	movem.l	a5-a6,-(sp)

	; Load pointers and constants.
	; a2 = Background tile map
	; a3 = Foreground block map
	; a5 = Block types (non-zero is a solid block)
	; d5.w = map width

	move.l	Map(a4),a2
	move.l	FgMap(a4),a3
	move.l	SolidBlocks(a4),a5
	move.w	MapWidth(a4),d5


	;---------------------------------------------------------
	; Load current xpos/ypos and translate it to a map offset.
	;---------------------------------------------------------

	movem.w	Hero+MOxpos(a4),d6-d7

	lea	MapRowOffTab(a4),a0
	moveq	#-16,d0
	and.w	d7,d0
	asr.w	#2,d0
	move.l	(a0,d0.w),a6
	move.w	d6,d0
	asr.w	#4,d0
	add.w	d0,a6			; a6 map offset for top-left edge

	moveq	#16,d4			; d4 mask for tile border check

	move.w	Hero_dyingAnim(a4),d0	; Hero is dying?
	bne	.dying

	move.b	Hero_climb(a4),d2
	beq	.noclimb

	;-----------------------------------------------------------
	; Hero is in climbing mode. Joystick-up will make him climb
	; up and down lets him climb down. Moving the joystick into
	; the opposite direction (e.g. right, when stairs are left)
	; will quit climbing mode.
	;-----------------------------------------------------------

	st	Hero_lastClimb(a4)
	clr.b	Hero_climb(a4)

	move.b	LeftRight(a4),d0
	add.b	d2,d0
	beq	.quitclimb

	move.w	Hero_animCnt(a4),d1

	move.b	UpDown(a4),d0
	beq	.setclimbanim
	bmi	.climbup

	;------------
	; Climb down.
	;------------

	; Check for a solid tile below.
	; As HEROH is greater than 16, this is always a row below on the map.
	; Check, if we have to skip another row.
	lea	(a6,d5.w),a0
	moveq	#HEROH,d0
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d4,d0
	bne	.chk_climbdown
	add.w	d5,a0

.chk_climbdown:
	move.b	(a2,a0.l),d0
	tst.b	(a5,d0.w)
	bne	.setclimbanim		; climb-path blocked

	; hero moves downwards with next animation phase
	move.w	d7,d0
	addq.w	#HEROCLIMBSPEED,d7
	eor.w	d7,d0
	and.w	d4,d0
	beq	.climb_downanim
	add.w	d5,a6			; one row down on the map

	; set next animation phase for climbing down
.climb_downanim:
	subq.w	#2,d1
	bpl	.setclimbanim
	moveq	#(.climbanimright-.climbanimleft)-2,d1
	bra	.setclimbanim

	;----------
	; Climb up.
	;----------

.climbup:
	; Check for a solid tile on top.
	move.l	a6,a0
	moveq	#15,d0
	and.w	d7,d0
	bne	.chk_climbup
	sub.w	d5,a0

.chk_climbup:
	move.b	(a2,a0.l),d0
	tst.b	(a5,d0.w)
	bne	.setclimbanim		; climb-path blocked

	; hero moves upwards with next animation phase
	move.w	d7,d0
	subq.w	#HEROCLIMBSPEED,d7
	eor.w	d7,d0
	and.w	d4,d0
	beq	.climb_upanim
	sub.w	d5,a6			; one row up on the map

	; set next animation phase for climbing up
.climb_upanim:
	addq.w	#2,d1
	cmp.w	#.climbanimright-.climbanimleft,d1
	blo	.setclimbanim
	moveq	#0,d1

.setclimbanim:
	clr.w	Hero_vx(a4)		; no environmental vx during climbing
	move.w	d1,Hero_animCnt(a4)
	moveq	#HEROGRAV_NORM,d4
	tst.b	d2			; climbing on left or right side?
	bmi	.setclimbleft
	moveq	#FACING_RIGHT,d3
	swap	d3
	move.w	.climbanimright(pc,d1.w),d3
	bra	.update
.setclimbleft:
	moveq	#FACING_LEFT,d3
	swap	d3
	move.w	.climbanimleft(pc,d1.w),d3
	bra	.update

.climbanimleft:
	dc.w	HERO_CLIMBLEFT,HERO_CLIMBLEFT,HERO_CLIMBLEFT
	dc.w	HERO_CLIMBLEFT+4,HERO_CLIMBLEFT+4,HERO_CLIMBLEFT+4
	dc.w	HERO_CLIMBLEFT+8,HERO_CLIMBLEFT+8,HERO_CLIMBLEFT+8
	dc.w	HERO_CLIMBLEFT+12,HERO_CLIMBLEFT+12,HERO_CLIMBLEFT+12
.climbanimright:
	dc.w	HERO_CLIMBRIGHT,HERO_CLIMBRIGHT,HERO_CLIMBRIGHT
	dc.w	HERO_CLIMBRIGHT+4,HERO_CLIMBRIGHT+4,HERO_CLIMBRIGHT+4
	dc.w	HERO_CLIMBRIGHT+8,HERO_CLIMBRIGHT+8,HERO_CLIMBRIGHT+8
	dc.w	HERO_CLIMBRIGHT+12,HERO_CLIMBRIGHT+12,HERO_CLIMBRIGHT+12

.noclimb:
	tst.b	Hero_lastClimb(a4)
	beq	.chk_leftright

.quitclimb:
	; Hero quits climbing by moving away or by reaching the end of
	; the stairs. Remember, whether he did this with a jump.
	moveq	#0,d0
	move.b	d0,Hero_lastJump(a4)
	tst.b	UpDown(a4)
	smi	Hero_climbJump(a4)

	; reset animation counter for normal movement
	move.b	d0,Hero_lastClimb(a4)
	move.w	d0,Hero_animCnt(a4)


	;-----------------------------------------------------------
	; Holding the stick left/right lets the hero walk into this
	; direction. When releasing the stick the hero still moves,
	; until it reaches an aligned position.
	;-----------------------------------------------------------

.chk_leftright:
	move.w	Hero_vx(a4),d2		; load and reset environmental vx
	clr.w	Hero_vx(a4)
	move.b	LeftRight(a4),d0
	beq	.do_align
	bmi	.walk_left
	bra	.walk_right


	;------------------------------------------
	; Execute selected type of dying animation.
	;------------------------------------------

.dying:
	move.w	.dyingtab-2(pc,d0.w),d0
	jmp	.dyingtab(pc,d0.w)

.dyingtab:
	dc.w	dying_freefall-.dyingtab
	dc.w	dying_drown-.dyingtab


	;----------------------------------------------------------
	; When there is no environmental vx, the hero slowly walks
	; until reaching an aligned position.
	;----------------------------------------------------------

.do_align:
	move.w	d2,d0			; environmental vx is the only vx
	beq	.walk_align
	bmi	.move_left_standing	; drift left by environment
	clr.w	Hero_lastLeft(a4)	; clear lastLeft and lastRight
	move.l	#FACING_RIGHT<<16|HERO_STANDRIGHT,d3
	bra	.move_right		; drift right by environment

.walk_align:
	; walk slowly to reach alignment
	tst.b	Hero_lastRight(a4)
	beq	.align_left

	;------------------------
	; Align right, then stop.
	;------------------------

	moveq	#1,d0			; move 1 px/frame when aligning
	moveq	#HERO_ALIGNMASK,d1
	and.w	d6,d1
	bne	.walk_right2

	; is aligned, stop moving
	clr.w	Hero_lastLeft(a4)	; clear lastLeft and lastRight
	move.l	#FACING_RIGHT<<16|HERO_STANDRIGHT,d3
	bra	.stopped_moving

	;-----------------------
	; Align left, then stop.
	;-----------------------

.align_left:
	tst.b	Hero_lastLeft(a4)
	beq	.not_moving

	moveq	#-1,d0			; move 1 px/frame when aligning
	moveq	#HERO_ALIGNMASK,d1
	and.w	d6,d1
	bne	.walk_left2

	; is aligned, stop moving
	clr.b	Hero_lastLeft(a4)
	move.l	#FACING_LEFT<<16|HERO_STANDLEFT,d3
	bra	.stopped_moving


	;----------------------
	; Walk right animation.
	;----------------------

.walk_right:
	st	Hero_lastRight(a4)
	moveq	#HEROSPEED,d0

.walk_right2:
	clr.b	Hero_lastLeft(a4)

	; set next animation phase for walking right
	move.w	Hero_animCnt(a4),d1
	addq.w	#2,d1
	cmp.w	#.rightanimend-.rightanim,d1
	blo	.setrightanim
	moveq	#0,d1
.setrightanim:
	move.w	d1,Hero_animCnt(a4)
	moveq	#FACING_RIGHT,d3
	swap	d3
	move.w	.rightanim(pc,d1.w),d3
	clr.w	Hero_idleCnt(a4)
	bra	.move

	;---------------------
	; Walk left animation.
	;---------------------

.walk_left:
	st	Hero_lastLeft(a4)
	moveq	#-HEROSPEED,d0
.walk_left2:
	clr.b	Hero_lastRight(a4)

	; set next animation phase for walking left
	move.w	Hero_animCnt(a4),d1
	addq.w	#2,d1
	cmp.w	#.leftanimend-.leftanim,d1
	blo	.setleftanim
	moveq	#0,d1
.setleftanim:
	move.w	d1,Hero_animCnt(a4)
	moveq	#FACING_LEFT,d3
	swap	d3
	move.w	.leftanim(pc,d1.w),d3
	clr.w	Hero_idleCnt(a4)
	bra	.move

	;---------------------------------------------
	; Animation images for walking right and left.
	;---------------------------------------------

.rightanim:
	dc.w	HERO_ANIMRIGHT,HERO_ANIMRIGHT,HERO_ANIMRIGHT,HERO_ANIMRIGHT
	dc.w	HERO_ANIMRIGHT+4,HERO_ANIMRIGHT+4,HERO_ANIMRIGHT+4,HERO_ANIMRIGHT+4
	dc.w	HERO_ANIMRIGHT+8,HERO_ANIMRIGHT+8,HERO_ANIMRIGHT+8,HERO_ANIMRIGHT+8
	dc.w	HERO_ANIMRIGHT+12,HERO_ANIMRIGHT+12,HERO_ANIMRIGHT+12,HERO_ANIMRIGHT+12
.rightanimend:

.leftanim:
	dc.w	HERO_ANIMLEFT,HERO_ANIMLEFT,HERO_ANIMLEFT,HERO_ANIMLEFT
	dc.w	HERO_ANIMLEFT+4,HERO_ANIMLEFT+4,HERO_ANIMLEFT+4,HERO_ANIMLEFT+4
	dc.w	HERO_ANIMLEFT+8,HERO_ANIMLEFT+8,HERO_ANIMLEFT+8,HERO_ANIMLEFT+8
	dc.w	HERO_ANIMLEFT+12,HERO_ANIMLEFT+12,HERO_ANIMLEFT+12,HERO_ANIMLEFT+12
.leftanimend:


	;--------------------------------------------------
	; Increment or decrement xpos and check if hero is
	; running into a solid block.
	;--------------------------------------------------

.move:
	; d0.w = vx from hero movement
	; d2.w = vx from environment
	add.w	d2,d0			; add environmental vx
	beq	.jumpcheck		; vx adds to zero - no coll. checks
	bmi	.move_left


	;------------------------------------------------
	; vx is positive: check solid block to the right
	;------------------------------------------------

.move_right:
	; d0.w = positive total vx
	move.w	d6,d1			; xpos old left edge
	move.w	d1,d2
	add.w	d0,d2			; left edge: xpos + vx
	eor.w	d2,d1
	and.w	d4,d1
	beq	.rsamecolumn

	; left edge moved one tile right on the map
	addq.l	#1,a6

.rsamecolumn:
	; Check if the right edge moved into a new tile.
	add.w	#HEROW-1,d6
	exg	d0,d6
	add.w	d0,d6			; right edge: xpos + HEROW-1 + vx
	eor.w	d6,d0
	and.w	d4,d0
	beq	.right_ok		; no need to check for solid blocks

	; d6.w = xpos+HEROW-1 (right edge)

	; cannot leave the map to the right
	cmp.w	ScrWidth(a4),d6
	bge	.blocked_right

	; Check for a solid block at the right edge.
	lea	1(a6),a0		; this is always one tile to the right
	moveq	#0,d2			; d2 collision flag

	; check whether the tile for xpos+HEROW-1 / ypos+1 is on the same row
	moveq	#1,d0
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d4,d0
	bne	.chk_rightbelow

	; check solidness of xpos+HEROW-1 / ypos+1
	move.b	(a2,a0.l),d1
	move.b	(a5,d1.w),d0
	beq	.chk_rightbelow

	addq.w	#1,d7
	bsr	solid_collision
	subq.w	#1,d7
	moveq	#1,d2
	moveq	#0,d1

	; check solidness of the next map row (xpos+HEROW-1 / ypos+16)
.chk_rightbelow:
	add.w	d5,a0
	move.b	(a2,a0.l),d1
	move.b	(a5,d1.w),d0
	beq	.chk_rightlowest

	add.w	d4,d7
	bsr	solid_collision
	sub.w	d4,d7
	moveq	#1,d2
	moveq	#0,d1

.chk_rightlowest:
	; As HEROH-HEROSPEED is assumed to always exceed the tile height
	; of 16, another row must be checked when ypos+HEROH-HEROSPEED
	; skips a whole tile.
	; @@@ should be HEROH-current_vx
	moveq	#HEROH-HEROSPEED,d0
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d4,d0
	bne	.chk_rightcoll

	; check solidness xpos+16 / ypos+HEROH-HEROSPEED
	add.w	d5,a0			; next row
	move.b	(a2,a0.l),d1
	move.b	(a5,d1.w),d0
	beq	.chk_rightcoll

	add.w	#HEROH-HEROSPEED,d7
	bsr	solid_collision
	sub.w	#HEROH-HEROSPEED,d7

.blocked_right:
	; Blocked by a solid tile. Align with the previous tile.
	sub.w	#HEROW-1,d6		; xpos back to left edge
	and.w	#$fff0,d6		; and align it to start of tile
	bra	.jumpcheck

.chk_rightcoll:
	tst.b	d2			; any collision detected?
	bne	.blocked_right
.right_ok:
	sub.w	#HEROW-1,d6		; xpos back to left edge
	bra	.jumpcheck


	;-----------------------------------------------
	; vx is negative: check solid block to the left
	;-----------------------------------------------

.move_left_standing:
	clr.w	Hero_lastLeft(a4)	; clear lastLeft and lastRight
	move.l	#FACING_LEFT<<16|HERO_STANDLEFT,d3

.move_left:
	; d0.w = negative total vx
	exg	d0,d6
	add.w	d0,d6			; xpos += vx
	eor.w	d6,d0
	and.w	d4,d0
	beq	.jumpcheck		; no need to check for solid blocks

	; left edge moved one tile left on the map
	subq.l	#1,a6

	tst.w	d6
	bmi	.blocked_left		; do not leave the map to the left

	; Check for a solid block at the left edge.
	move.l	a6,a0
	moveq	#0,d1
	moveq	#0,d2			; d2 collision flag

	; check whether the tile for xpos / ypos+1 is on the same row
	moveq	#1,d0
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d4,d0
	bne	.chk_leftbelow

	; check solidness of xpos / ypos+1
	move.b	(a2,a0.l),d1
	move.b	(a5,d1.w),d0
	beq	.chk_leftbelow

	addq.w	#1,d7
	bsr	solid_collision
	subq.w	#1,d7
	moveq	#1,d2
	moveq	#0,d1

	; check solidness of the next map row (xpos / ypos+16)
.chk_leftbelow:
	add.w	d5,a0
	move.b	(a2,a0.l),d1
	move.b	(a5,d1.w),d0
	beq	.chk_leftlowest

	add.w	d4,d7
	bsr	solid_collision
	sub.w	d4,d7
	moveq	#1,d2
	moveq	#0,d1

.chk_leftlowest:
	; As HEROH-HEROSPEED is assumed to always exceed the tile height
	; of 16, another row must be checked when ypos+HEROH-HEROSPEED
	; skips a whole tile.
	; @@@ should be HEROH-current_vx
	moveq	#HEROH-HEROSPEED,d0
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d4,d0
	bne	.chk_leftcoll

	; check solidness xpos-1 / ypos+HEROH-HEROSPEED
	add.w	d5,a0
	move.b	(a2,a0.l),d1
	move.b	(a5,d1.w),d0
	beq	.chk_leftcoll

	add.w	#HEROH-HEROSPEED,d7
	bsr	solid_collision
	sub.w	#HEROH-HEROSPEED,d7

.blocked_left:
	; Blocked by a solid tile. Align with the previous tile.
	add.w	#15,d6
	addq.l	#1,a6			; back to right tile
	and.w	#$fff0,d6		; aligned with its start pixel
	bra	.jumpcheck

.chk_leftcoll:
	tst.b	d2
	bne	.blocked_left
	bra	.jumpcheck


	;---------------------
	; Hero is not moving.
	;---------------------

.not_moving:
	; load last standing image and facing
	move.l	Hero_facing(a4),d3

.stopped_moving:
	; Hero is standing still. After HERO_IDLETIME frames it will
	; show the idle image (hero faces the player).
	addq.w	#1,Hero_idleCnt(a4)
	cmp.w	#HERO_IDLETIME,Hero_idleCnt(a4)
	blo	.jumpcheck

	; set idle image
	move.l	#FACING_MID<<16|HERO_IDLE,d3
	clr.w	Hero_animCnt(a4)


	;-----------------------------------------------------------
	; Handle jumping and falling (gravity).
	; The hero jumps when pressing the stick up and standing on
	; solid ground.
	;-----------------------------------------------------------

.jumpcheck:
	moveq	#0,d0
	tst.b	UpDown(a4)
	bpl	.clrlastjump

	tst.b	Hero_lastJump(a4)
	bne	.not_jumping

	; The tile below the hero's feet is always the next, or the
	; next but one row (as the hero's height exceeds the tile
	; height of 16).
	lea	(a6,d5.w),a0		; map row + 1
	moveq	#HEROH,d0
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d4,d0
	bne	.chkbottom
	add.w	d5,a0			; next row (map row + 2)

	; check whether hero's bottom right edge is on solid ground
.chkbottom:
	moveq	#15,d0
	and.w	d6,d0
	beq	.bottomleftchk		; hero is tile-aligned, don't check
	move.b	1(a2,a0.l),d0
	tst.b	(a5,d0.w)
	bne	.do_jump

	; check whether hero's bottom left edge is on solid ground
.bottomleftchk:
	move.b	(a2,a0.l),d0
	tst.b	(a5,d0.w)
	bne	.do_jump

	; hero can also jump when bouncing from monsters or when climbing
	move.b	Hero_bounced(a4),d0
	or.b	Hero_climbJump(a4),d0
	beq	.load_vy

.do_jump:
	moveq	#HEROGRAV_JUMP,d4
	st	Hero_lastJump(a4)
	moveq	#0,d0
	move.b	d0,Hero_bounced(a4)
	move.b	d0,Hero_climbJump(a4)
	addq.w	#1,LevelJumps(a4)	; count jumps for statistics
	bra	.vy_upwards

.clrlastjump:
	move.b	d0,Hero_lastJump(a4)	# clear lastJump

.not_jumping:
	tst.b	Hero_bounced(a4)
	beq	.load_vy

	; Hero is not jumping, but bounced after jumping onto a monster,
	; or is accelerated by a spring platform.
	move.b	d0,Hero_bounced(a4)	; clear bounced-flag
	move.w	Hero_bouncevy(a4),d4	; set bounce vy

	; reset to default value
	move.w	#HEROGRAV_BOUNCE,Hero_bouncevy(a4)
	bra	.vy_upwards

.load_vy:
	move.w	Hero_vy(a4),d4		; d4 current y-speed
	bpl	.vy_downwards

	; y-speed points upwards (negative). Hero is jumping and in flight.
.vy_upwards:
	move.w	d7,d0
	move.w	d4,d1
	addq.w	#3,d1			; fix for shifting negative value
	asr.w	#2,d1
	add.w	d1,d7			; ypos + vy / 4
	eor.w	d7,d0
	and.w	#16,d0
	beq	.upgravity
	sub.w	d5,a6			; one tile up on the map
.upgravity:
	addq.w	#1,d4			; apply gravity
	bra	.inflight

	; y-speed points downwards (positive). Normal gravity.
.vy_downwards:
	move.w	d7,d0
	move.w	d4,d1
	asr.w	#2,d1
	add.w	d1,d7			; ypos + vy / 4
	eor.w	d7,d0
	and.w	#16,d0
	beq	.downgravity
	add.w	d5,a6			; one tile down on the map
.downgravity:
	cmp.w	#HEROGRAV_MAX,d4
	bhs	.vy_ok
	addq.w	#1,d4			; apply gravity
.vy_ok:

	;-----------------------------------
	; Check if standing on solid ground.
	;-----------------------------------

	; The tile below the hero's feet is always the next, or the
	; next but one row (as the hero's height exceeds the tile
	; height of 16).
	moveq	#16,d1
	lea	(a6,d5.w),a1		; a1 map row + 1
	moveq	#HEROH,d0
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d1,d0
	bne	.chkground
	add.w	d5,a1			; a1 next row (map row + 2)

	; Check whether hero's bottom left edge is on solid ground.
	; Remember map offset of ground contact in a0 and xpos in d2.
.chkground:
	move.l	a1,a0
	move.w	d6,d2
	move.b	(a2,a1.l),d0
	tst.b	(a5,d0.w)
	bne	.landed

	; Check whether hero's bottom right edge is on solid ground.
	moveq	#15,d0
	add.w	d0,d2
	and.w	d6,d0
	beq	.inflight
	move.b	1(a2,a1.l),d0
	tst.b	(a5,d0.w)
	beq	.inflight
	addq.l	#1,a0

.landed:
	moveq	#HEROH,d4
	move.w	d6,d0
	addq.w	#8,d6
	eor.w	d6,d0
	and.w	d1,d0
	beq	.chkposanim
	addq.l	#1,a1			; a1 xpos+8,ypos+HEROH on map
.chkposanim:
	; trigger animations on new position
	bsr	position_animation

	; perform collision check at xpos+8,ypos+HEROH
	moveq	#0,d1
	move.b	(a2,a1.l),d1
	moveq	#0,d0
	move.b	(a5,d1.w),d0
	beq	.botedgecoll
	move.l	a1,a0
	add.w	d4,d7
	bsr	solid_collision
	sub.w	d4,d7
	bra	.groundalign

.botedgecoll:
	; No solid tile at xpos+8, ypos+HEROH. So do collision check
	; with the tile below the hero's corner instead (xpos or xpos+15).
	; Its xpos was saved in d2 and the map offset in a0.
	swap	d6
	move.w	d2,d6
	move.b	(a2,a0.l),d1
	move.b	(a5,d1.w),d0
	add.w	d4,d7
	bsr	solid_collision
	sub.w	d4,d7
	swap	d6

.groundalign:
	subq.w	#8,d6

	; The hero has solid ground under his feet, so we reduce
	; vy to HEROGRAV_NORM and align his feet with the solid tile.
	add.w	d4,d7
	and.w	#$fff0,d7
	sub.w	d4,d7
	moveq	#HEROGRAV_NORM,d4

	tst.b	Hero_inflight(a4)
	beq	.update

	; hero just landed, so select a standing animation phase
	clr.b	Hero_inflight(a4)
	clr.b	MultiKill(a4)		; no extra bonus after touching ground
	swap	d3
	move.w	d3,d0
	swap	d3
	move.w	.standanims(pc,d0.w),d3
	bra	.update

.standanims:
	dc.w	HERO_STANDLEFT,HERO_IDLE,HERO_STANDRIGHT
.jumpanims:
	dc.w	HERO_JUMPLEFT,HERO_IDLE,HERO_JUMPRIGHT

.inflight:
	; trigger animations on new position
	sub.l	a1,a1			; nothing below
	bsr	position_animation

	; hero is in flight, set jump animation
	st	Hero_inflight(a4)
	swap	d3
	move.w	d3,d0
	swap	d3
	move.w	.jumpanims(pc,d0.w),d3

	;-------------------------------------------------------------
	; Check if the top-left/right edge collides with a solid tile.
	;-------------------------------------------------------------

	; When the hero's top-left or top-right edge collides with a
	; solid map tile a jump is aborted and the position is re-aligned.
	; Remember edge collision's map offset in a1 and xpos in d2.
	move.l	a6,a1
	move.w	d6,d2
	move.b	(a2,a6.l),d0
	tst.b	(a5,d0.w)
	bne	.solidtop

	; also check the right edge
	moveq	#15,d0
	add.w	d0,d2
	and.w	d6,d0
	beq	.update			; ok, no solid tiles on top
	move.b	1(a2,a6.l),d0
	tst.b	(a5,d0.w)
	beq	.update			; ok, no solid tiles on top
	addq.l	#1,a1

.solidtop:
	; perform collision check at xpos+8,ypos
	moveq	#16,d1
	move.l	a6,a0
	move.w	d6,d0
	addq.w	#8,d6
	eor.w	d6,d0
	and.w	d1,d0
	beq	.topcollision
	addq.l	#1,a0
.topcollision:
	move.b	(a2,a0.l),d1
	move.b	(a5,d1.w),d0
	beq	.topedgecoll
	bsr	solid_collision
	bra	.stopjump

.topedgecoll:
	; No solid tile at xpos+8, ypos. So do collision check with the
	; tile in the hero's corner instead (xpos or xpos+15).
	; Its xpos was saved in d2 and the map offset in a1.
	swap	d6
	move.w	d2,d6
	move.l	a1,a0
	move.b	(a2,a0.l),d1
	move.b	(a5,d1.w),d0
	bsr	solid_collision
	swap	d6

.stopjump:
	subq.w	#8,d6

	; immediately stop the jump, set vy to NORM and align with lower tile
	moveq	#HEROGRAV_NORM,d4
	add.w	#15,d7
	and.w	#$fff0,d7
	add.w	d5,a6			; one tile down on the map


	;------------------------------
	; Update hero status in memory.
	;------------------------------

.update:
	move.w	d4,Hero_vy(a4)
	movem.w	Hero+MOxpos(a4),d0-d1
	movem.w	d6-d7,Hero+MOxpos(a4)

	; calculate distance covered in pixels (approximately) for statistics
	sub.w	d6,d0
	bpl	.upd1
	neg.w	d0
.upd1:	sub.w	d7,d1
	bpl	.upd2
	neg.w	d1
.upd2:	add.w	d1,d0
	add.l	d0,LevelDistance(a4)

	cmp.w	Hero_anim(a4),d3
	beq	.collcheck		; animation phase didn't change

	move.l	d3,Hero_facing(a4)
	lea	HeroAnims(a4),a0
	move.l	(a0,d3.w),a0
	move.l	a0,Hero+MOimage(a4)
	lea	HEROSIZE(a0),a0
	move.l	a0,Hero+MOmask(a4)


	;-------------------------------------------------------------
	; Check all four edges for collisions with special tiles.
	; For the check we use a safety margin of HCOLL_MARGIN inside
	; the hero's sprite, where no collision takes place.
	;-------------------------------------------------------------

.collcheck:
	moveq	#16,d2			; d2 mask for tile border check
	lea	(a6,d5.w),a1		; a1 bottom margin tile

	; is ypos+margin still in the same tile?
	move.w	d7,d0
	addq.w	#HCOLL_MARGIN,d7
	eor.w	d7,d0
	and.w	d2,d0
	beq	.botmargin
	add.w	d5,a6			; top margin is in the next row

.botmargin:
	; ypos+HEROH-1-margin always skips a row, maybe two?
	moveq	#HEROH-HCOLL_MARGIN-1,d0
	add.w	d7,d0
	swap	d7
	move.w	d0,d7			; store ypos+HEROH-margin in d7 MSW
	swap	d7
	eor.w	d7,d0
	and.w	d2,d0
	bne	.checkcollleft
	add.w	d5,a1			; bottom margin skips two rows

.checkcollleft:
	move.l	a6,d3			; d3 top map offset
	move.l	a1,d4			; d4 bottom map offset
	move.l	BackgdBlocks(a4),a5
	move.l	FgBlockTypes(a4),a6

	; xpos+margin still in the same tile?
	move.w	d6,d0
	addq.w	#HCOLL_MARGIN,d6
	eor.w	d6,d0
	and.w	d2,d0
	bne	.checkcollright		; left and right margin in same tile

	; top left edge collisions
	move.b	(a2,d3.l),d0
	move.b	(a5,d0.w),d1
	beq	.collleft1
	move.l	d3,a0
	bsr	backgd_collision
	bne	.hero_done

.collleft1:
	move.b	(a3,d3.l),d0
	move.b	(a6,d0.w),d1
	beq	.collleft2
	move.l	d3,a0
	bsr	foregd_collision

	; bottom left edge collisions
.collleft2:
	swap	d7
	move.b	(a2,d4.l),d0
	move.b	(a5,d0.w),d1
	beq	.collleft3
	move.l	d4,a0
	bsr	backgd_collision
	bne	.hero_done

.collleft3:
	move.b	(a3,d4.l),d0
	move.b	(a6,d0.w),d1
	beq	.collleft4
	move.l	d4,a0
	bsr	foregd_collision

.collleft4:
	; check if xpos+15-margin is in the next tile
	swap	d7
	moveq	#15-2*HCOLL_MARGIN,d0
	add.w	d6,d0
	eor.w	d6,d0
	and.w	#16,d0
	beq	.hero_done		; no, then we're done

	; check the top and bottom edge of the right tile
.checkcollright:
	add.w	#15-2*HCOLL_MARGIN,d6	; fix xpos for right margin
	addq.l	#1,d3			; top right tile offset
	addq.l	#1,d4			; bottom right tile offset

	; top right edge collsions
	move.b	(a2,d3.l),d0
	move.b	(a5,d0.w),d1
	beq	.collright1
	move.l	d3,a0
	bsr	backgd_collision
	bne	.hero_done

.collright1:
	move.b	(a3,d3.l),d0
	move.b	(a6,d0.w),d1
	beq	.collright2
	move.l	d3,a0
	bsr	foregd_collision

	; bottom right edge collisions
.collright2:
	swap	d7
	move.b	(a2,d4.l),d0
	move.b	(a5,d0.w),d1
	beq	.collright3
	move.l	d4,a0
	bsr	backgd_collision
	bne	.hero_done

.collright3:
	move.b	(a3,d4.l),d0
	move.b	(a6,d0.w),d1
	beq	.hero_done
	move.l	d4,a0
	bsr	foregd_collision

.hero_done:
	movem.l	(sp)+,a5-a6

	;---------------------------------------------------
	; Try to center the map view to the hero's position.
	;---------------------------------------------------
	movem.w	Hero+MOxpos(a4),d0-d1
	bra	moveView


;---------------------------------------------------------------------------
position_animation:
; Check if new position triggers an animation.
; a1 = xpos+8, ypos+HEROH on map
; Preserves a0 and a1!

	; check if leaving a bending bridge tile
	move.l	Hero_bridge(a4),d0
	beq	.1
	cmp.l	a1,d0
	beq	.1

	; Hero no longer stands on a bending bridge. Clear that animation.
	movem.l	d2/a0,-(sp)
	move.l	d0,a0
	movem.w	Hero_brCol(a4),d0-d2
	bsr	newSingleTileAnim
	clr.l	Hero_bridge(a4)
	movem.l	(sp)+,d2/a0

.1:	rts


;---------------------------------------------------------------------------
solid_collision:
; Hero is stopped by a solid block. Block types >= 2 may trigger special
; events.
; d0.b = solid block type
; d1.w = tile code
; d5.w = map width
; d6.w = xpos of collision
; d7.w = ypos of collision
; a0 = tile map offset
; a6 = hero (top left edge) map offset
; a0 and a1 are preserved! d2 is destroyed!

	subq.b	#SB_BRBEND,d0
	bmi	.noaction
	
	; Trigger the appropriate action for this solid block type.
	ext.w	d0
	move.w	.handlertab(pc,d0.w),d0
	jmp	.handlertab(pc,d0.w)

.noaction:
	rts

.handlertab:
	dc.w	.brbend-.handlertab	; SB_BRBEND
	dc.w	.brcrumb4-.handlertab	; SB_BRCRUMB4
	dc.w	.brcrumb5-.handlertab	; SB_BRCRUMB5
	dc.w	.stcrush4-.handlertab	; SB_STCRUSH4
	dc.w	.stcrush5-.handlertab	; SB_STCRUSH5
	dc.w	.spring-.handlertab	; SB_SPRING
	dc.w	.treadleft-.handlertab	; SB_TREADLEFT
	dc.w	.treadright-.handlertab	; SB_TREADRIGHT


.brbend:
; bridge tile is bending down, when standing on it
	moveq	#-1,d2			; allow retrigger
	move.b	d1,d2
	move.w	d6,d0
	move.w	d7,d1
	movem.w	d0-d2,Hero_brCol(a4)
	addq.b	#1,d2			; d2 new tile code
	move.l	a0,Hero_bridge(a4)
	bra	newSingleTileAnim


.brcrumb4:
; bridge starts to crumble, when walking over it
	moveq	#11,d2			; no retrigger | animation speed
	swap	d2
	move.b	d1,d2
	addq.b	#3,d2			; last animation tile
	lsl.w	#8,d2
	move.b	d1,d2			; first animation tile
	move.w	d6,d0
	move.w	d7,d1
	bra	newTileAnimSeq


.brcrumb5:
; bridge starts to crumble, when walking over it
	moveq	#11,d2			; no retrigger | animation speed
	swap	d2
	move.b	d1,d2
	addq.b	#4,d2			; last animation tile
	lsl.w	#8,d2
	move.b	d1,d2			; first animation tile
	move.w	d6,d0
	move.w	d7,d1
	bra	newTileAnimSeq


.stcrush4:
; stone block is crushed with a four-phase animation sequence
	moveq	#8,d2			; no retrigger | animation speed
	swap	d2
	move.b	d1,d2
	addq.b	#3,d2			; last animation tile
	lsl.w	#8,d2
	move.b	d1,d2			; first animation tile
	move.w	d6,d0
	move.w	d7,d1
	bsr	newTileAnimSeq
	beq	.return
	moveq	#SND_WALL,d0		; play sound when not retriggered
	bra	playSFX


.stcrush5:
; stone block is crushed with a five-phase animation sequence
	moveq	#8,d2			; no retrigger | animation speed
	swap	d2
	move.b	d1,d2
	addq.b	#4,d2			; last animation tile
	lsl.w	#8,d2
	move.b	d1,d2			; first animation tile
	move.w	d6,d0
	move.w	d7,d1
	bsr	newTileAnimSeq
	beq	.return
	moveq	#SND_WALL,d0		; play sound when not retriggered
	bra	playSFX

.spring:
; highest spring animation phase accelerates the hero upwards
	tst.b	Hero_inflight(a4)
	bne	.return			; hero in flight has no contact

	; The hero must be on top of the spring. This is always two
	; rows up on the map.
	move.l	a0,d2
	sub.w	d5,a0
	sub.w	d5,a0
	cmp.l	a0,a6
	move.l	d2,a0
	bhi	.return

	; Let the hero bounce with HEROGRAV_SPRING.
	moveq	#HEROGRAV_SPRING,d0
	bsr	bounceHero

	moveq	#SND_SPRING,d0		; play a spring sound
	bra	playSFX

.treadleft:
; treadmill moving left, adds to hero's speed
	moveq	#LEFTTREADSPEED,d0
	SKIPW

.treadright:
; treadmill moving right, adds to hero's speed
	moveq	#RIGHTTREADSPEED,d0

	tst.b	Hero_inflight(a4)
	bne	.return			; hero in flight has no contact

	; The hero must be on top of the treadmill. This is always two
	; rows up on the map.
	move.l	a0,d2
	sub.w	d5,a0
	sub.w	d5,a0
	cmp.l	a0,a6
	move.l	d2,a0
	bhi	.return

	move.w	d0,Hero_vx(a4)
.return:
	rts


;---------------------------------------------------------------------------
backgd_collision:
; d0.w = tile code
; d1.b = background block type
; a0 = tile map offset
; d6.w = xpos in collision tile
; d7.w = ypos in collision tile
; -> d0/Z = non-zero when no more collision checks are needed (lethal)

	ext.w	d1
	move.w	.handlertab-BB_SOLID(pc,d1.w),d1
	jmp	.handlertab(pc,d1.w)

.handlertab:
	dc.w	.noop-.handlertab		; BB_SOLID (-2)
	dc.w	.noop-.handlertab		; 0 (shouldn't happen)
	dc.w	deathFalling-.handlertab	; BB_STDDEATH
	dc.w	deathDrowning-.handlertab	; BB_DROWNING
	dc.w	.noop-.handlertab		; unused
	dc.w	.noop-.handlertab		; unused
	dc.w	.switch-.handlertab		; BB_SWITCH
	dc.w	.lstairs-.handlertab		; BB_STAIRSLEFT
	dc.w	.rstairs-.handlertab		; BB_STAIRSRIGHT
	dc.w	.noop-.handlertab		; BB_START
	dc.w	.exit-.handlertab		; BB_EXIT
	dc.w	.illuminate-.handlertab		; BB_ILLUMTORCH


.noop:
	; A solid block is harmless. This type is intended for monsters only.
	; When falling fast the hero might run into it.
	moveq	#0,d0
	rts


.switch:
	; Activated a switch by touching it. Set it to activated, so it
	; cannot be retriggered.
	move.l	d2,-(sp)
	moveq	#0,d2			; no retrigger
	move.b	d0,d2
	addq.b	#1,d2			; d2 new tile code: activated switch
	move.w	d6,d0
	move.w	d7,d1
	bsr	newSingleTileAnim

	; Then look for tiles to be replaced by this action.
	move.w	d2,d0
	subq.b	#2,d0
	bsr	switchTiles

	moveq	#SND_SWITCH,d0		; switch activation sound
	bsr	playSFX

	move.l	(sp)+,d2
	moveq	#0,d0
	rts


.lstairs:
	; Stairs on the left side. When Hero.xpos & 14 is 0 and the
        ; joystick is left, then attach to it.
	tst.b	Hero_lastClimb(a4)
	bne	.ls_cont

	move.b	LeftRight(a4),d0
	bpl	.ls_exit
	moveq	#14,d0
	and.w	Hero+MOxpos(a4),d0
	bne	.ls_exit

	clr.b	MultiKill(a4)		; no extra bonus after climbing

	; attach to stairs
	and.w	#$fff0,Hero+MOxpos(a4)
	clr.w	Hero_animCnt(a4)
.ls_cont:
	move.b	#CLIMB_LEFT,Hero_climb(a4)

.ls_exit:
	moveq	#0,d0
	rts


.rstairs:
	; Stairs on the right side. When Hero.xpos+1 & 14 is 0 and the
        ; joystick is right, then attach to it.
	tst.b	Hero_lastClimb(a4)
	bne	.rs_cont

	move.b	LeftRight(a4),d0
	subq.b	#1,d0
	bmi	.rs_exit
	move.w	Hero+MOxpos(a4),d0
	addq.w	#1,d0
	moveq	#14,d1
	and.w	d0,d1
	bne	.rs_exit

	clr.b	MultiKill(a4)		; no extra bonus after climbing

	; attach to stairs
	and.w	#$fff0,d0
	move.w	d0,Hero+MOxpos(a4)
	clr.w	Hero_animCnt(a4)
.rs_cont:
	move.b	#CLIMB_RIGHT,Hero_climb(a4)

.rs_exit:
	moveq	#0,d0
	rts


.exit:
	; Reached the exit point of this level. Exit the game loop
	; to start the level-done animation. Then proceed to the next.
	clr.b	Status(a4)		; GAME_STOPPED
	moveq	#0,d0
	rts


.illuminate:
	; Ignite a torch, which illuminates two colors in the map for
	; a period of time.
	bsr	start_illumination
	bne	.ill_exit		; illumination already active

	moveq	#SND_IGNITE,d0		; torch activation sound
	bsr	playSFX
.ill_exit:
	moveq	#0,d0
	rts


;---------------------------------------------------------------------------
foregd_collision:
; d0.w = tile code
; d1.b = foreground block type
; a0 = map offset
; d6.w = xpos in collision tile
; d7.w = ypos in collision tile
; -> d0 = 0

	ext.w	d1
	move.w	.handlertab-FB_CHECKPOINT(pc,d1.w),d1
	jmp	.handlertab(pc,d1.w)

.handlertab:
	dc.w	.ckpt-.handlertab	; FB_CHECKPOINT
	dc.w	.coin-.handlertab	; FB_COIN
	dc.w	.ruby-.handlertab	; FB_RUBY
	dc.w	.emerald-.handlertab	; FB_EMERALD
	dc.w	.diamond-.handlertab	; FB_DIAMOND
	dc.w	.xlife-.handlertab	; FB_EXTRALIFE


.ckpt:
	; Checkpoint: save this location as StartX/StartY
	move.w	d6,d0
	asr.w	#4,d0
	move.w	d7,d1
	asr.w	#4,d1
	movem.w	d0-d1,StartX(a4)

	; clear it
	add.l	FgMap(a4),a0
	clr.b	(a0)

	moveq	#SND_CHECKPOINT,d0
	bsr	playSFX

	moveq	#0,d0
	rts


	; collect a gem as bonus, increase score and gem-counter
.emerald:
	addq.w	#1,StatAct+Stat_Emeralds(a4)
	moveq	#EMERALDSCORE,d0
	bra	.addbonus

.diamond:
	addq.w	#1,StatAct+Stat_Diamonds(a4)
	moveq	#DIAMONDSCORE,d0
	bra	.addbonus

.ruby:
	addq.w	#1,StatAct+Stat_Rubys(a4)
	moveq	#RUBYSCORE,d0

.addbonus:
	bsr	addScore

	; remove it from the map
	add.l	FgMap(a4),a0
	clr.b	(a0)

	moveq	#SND_PLING,d0
	bsr	playSFX

	; increase gem-counter
	moveq	#1,d0
	bsr	addGems

	moveq	#0,d0
	rts


.coin:
	; collect a coin as bonus, increase score
	addq.w	#1,StatAct+Stat_Gold(a4)
	moveq	#COINSCORE,d0
	bsr	addScore

	; remove it from the map
	add.l	FgMap(a4),a0
	clr.b	(a0)

	moveq	#SND_PLING,d0
	bsr	playSFX

	moveq	#0,d0
	rts


.xlife:
	; collect an extra life
	addq.w	#1,StatAct+Stat_ExtraLives(a4)
	moveq	#1,d0
	bsr	addLives

	; remove it from the map
	add.l	FgMap(a4),a0
	clr.b	(a0)

	moveq	#SND_XLIFE,d0
	bsr	playSFX

	moveq	#0,d0
	rts


;---------------------------------------------------------------------------
dying_freefall:
; Let the hero fall out of the screen, while playing the DFALLING
; animation. Then quit the game loop.
; d6.w = xpos
; d7.w = ypos

	; falling
	move.w	Hero_vy(a4),d1
	move.w	d1,d0
	asr.w	#2,d0
	add.w	d0,d7
	movem.w	d6-d7,Hero+MOxpos(a4)

	; apply gravitation
	addq.w	#1,d1
	move.w	d1,Hero_vy(a4)

	; next animation frame
	move.w	Hero_animCnt(a4),d0
	addq.w	#2,d0
	cmp.w	#.fallanimend-.fallanim,d0
	blo	.2
	moveq	#0,d0
.2:	move.w	d0,Hero_animCnt(a4)

	move.w	.fallanim(pc,d0.w),d0
	lea	HeroAnims(a4),a0
	move.l	(a0,d0.w),a0
	move.l	a0,Hero+MOimage(a4)
	lea	HEROSIZE(a0),a0
	move.l	a0,Hero+MOmask(a4)

	; quit the game loop, when fallen out of the screen
	tst.b	Hero+MOvisible(a4)
	bne	.3
	clr.b	Status(a4)		; GAME_STOPPED

.3:	movem.l	(sp)+,a5-a6
	rts

.fallanim:
	dc.w	HERO_DFALLING,HERO_DFALLING,HERO_DFALLING
	dc.w	HERO_DFALLING,HERO_DFALLING,HERO_DFALLING
	dc.w	HERO_DFALLING+4,HERO_DFALLING+4,HERO_DFALLING+4
	dc.w	HERO_DFALLING+4,HERO_DFALLING+4,HERO_DFALLING+4
	dc.w	HERO_DFALLING+8,HERO_DFALLING+8,HERO_DFALLING+8
	dc.w	HERO_DFALLING+8,HERO_DFALLING+8,HERO_DFALLING+8
	dc.w	HERO_DFALLING+12,HERO_DFALLING+12,HERO_DFALLING+12
	dc.w	HERO_DFALLING+12,HERO_DFALLING+12,HERO_DFALLING+12
.fallanimend:


;---------------------------------------------------------------------------
dying_drown:
; Let the hero fall down until passing Hero_waterlevel. Then play the
; DDROWNING animation and quit the game loop when done.
; d6.w = xpos
; d7.w = ypos

	cmp.w	Hero_waterlevel(a4),d7
	bhi	.drowning

	; gliding into the water
	move.w	Hero_vy(a4),d1
	move.w	d1,d0
	asr.w	#3,d0			; effect of vy is smaller than in air
	add.w	d0,d7
	movem.w	d6-d7,Hero+MOxpos(a4)

	; gravitation
	addq.w	#1,d1
	move.w	d1,Hero_vy(a4)
	move.w	#HERO_DDROWNING,d0
	bra	.setanim

.drownanim:
	dc.w	HERO_DDROWNING+4,HERO_DDROWNING+4,HERO_DDROWNING+4
	dc.w	HERO_DDROWNING+4,HERO_DDROWNING+4,HERO_DDROWNING+4
	dc.w	HERO_DDROWNING+8,HERO_DDROWNING+8,HERO_DDROWNING+8
	dc.w	HERO_DDROWNING+8,HERO_DDROWNING+8,HERO_DDROWNING+8
	dc.w	HERO_DDROWNING+12,HERO_DDROWNING+12,HERO_DDROWNING+12
	dc.w	HERO_DDROWNING+12,HERO_DDROWNING+12,HERO_DDROWNING+12
	dc.w	HERO_DDROWNING+16,HERO_DDROWNING+16,HERO_DDROWNING+16
	dc.w	HERO_DDROWNING+16,HERO_DDROWNING+16,HERO_DDROWNING+16

.drowning:
	subq.w	#1,Hero_idleCnt(a4)
	bne	.1
	clr.b	Status(a4)		; GAME_STOPPED
	bra	.3

.1:	move.w	Hero_animCnt(a4),d0
	addq.w	#2,d0
	cmp.w	#.drowning-.drownanim,d0
	blo	.2
	moveq	#0,d0
.2:	move.w	d0,Hero_animCnt(a4)
	move.w	.drownanim(pc,d0.w),d0

.setanim:
	lea	HeroAnims(a4),a0
	move.l	(a0,d0.w),a0
	move.l	a0,Hero+MOimage(a4)
	lea	HEROSIZE(a0),a0
	move.l	a0,Hero+MOmask(a4)

.3:	movem.l	(sp)+,a5-a6
	rts


;---------------------------------------------------------------------------
	xdef	updateLevDone
updateLevDone:
; Update hero's level-done animation.
; Registers, except a4 - a6, are not preserved!

	move.l	Map(a4),a2
	move.l	SolidBlocks(a4),a3
	moveq	#16,d3
	move.w	MapWidth(a4),d5

	;---------------------------------------------------------
	; Load current xpos/ypos and translate it to a map offset.
	;---------------------------------------------------------

	movem.w	Hero+MOxpos(a4),d6-d7	; d6=xpos, d7=ypos
	lea	MapRowOffTab(a4),a0
	moveq	#-16,d0
	and.w	d7,d0
	asr.w	#2,d0
	add.l	(a0,d0.w),a2
	move.w	d6,d0
	asr.w	#4,d0
	add.w	d0,a2			; a2 map position (top-left edge)

	;-------------
	; Gravitation.
	;-------------

	move.w	Hero_vy(a4),d4		; d4 current y-speed
	bmi	.1

	; Stop any ascending movement when hero found the exit.
	moveq	#HEROGRAV_NORM,d4

.1:	move.w	d7,d0
	move.w	d4,d1
	asr.w	#2,d1
	add.w	d1,d7			; ypos + vy / 4
	eor.w	d7,d0
	and.w	d3,d0
	beq	.2
	add.w	d5,a2			; one tile down on the map

.2:	addq.w	#1,d4			; apply gravity

	;-------------------------------------------
	; Check if already standing on solid ground.
	;-------------------------------------------

	; The tile below the hero's feet is always the next, or the
	; next but one row (as the hero's height exceeds the tile
	; height of 16).
	add.w	d5,a2			; next map row
	moveq	#HEROH,d0
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d3,d0
	bne	.3
	add.w	d5,a2			; skip another row

	; check whether hero's bottom left edge is on solid ground
.3:	move.b	(a2)+,d0
	tst.b	(a3,d0.w)
	bne	.landed

	; check whether hero's bottom right edge is on solid ground
	moveq	#15,d0
	and.w	d6,d0
	beq	.4
	move.b	(a2),d0
	tst.b	(a3,d0.w)
	bne	.landed

	; set idle animation phase, while falling down
.4:	move.w	#HERO_IDLE,d0
	bra	.setanim

.landed:
	; The hero has solid ground under his feet, so we reduce
	; vy to HEROGRAV_NORM and align his feet with the solid tile.
	moveq	#HEROH,d4
	add.w	d4,d7
	and.w	#$fff0,d7
	sub.w	d4,d7
	moveq	#HEROGRAV_NORM,d4

	;-------------------------------------------------
	; Nodding animation when standing on solid ground.
	;-------------------------------------------------

	move.w	Hero_animCnt(a4),d0
	addq.w	#2,d0
	cmp.w	#.nodanimend-.nodanim,d0
	blo	.5
	moveq	#0,d0
.5:	move.w	d0,Hero_animCnt(a4)
	move.w	.nodanim(pc,d0.w),d0

	;--------------------------------
	; Set animation and update state.
	;--------------------------------

.setanim:
	lea	HeroAnims(a4),a0
	move.l	(a0,d0.w),a0
	move.l	a0,Hero+MOimage(a4)
	lea	HEROSIZE(a0),a0
	move.l	a0,Hero+MOmask(a4)

	move.w	d4,Hero_vy(a4)
	move.w	d7,Hero+MOypos(a4)
	rts

.nodanim:
	dc.w	HERO_DONE,HERO_DONE,HERO_DONE,HERO_DONE
	dc.w	HERO_DONE,HERO_DONE,HERO_DONE,HERO_DONE
	dc.w	HERO_DONE,HERO_DONE,HERO_DONE,HERO_DONE
	dc.w	HERO_DONE,HERO_DONE,HERO_DONE,HERO_DONE
	dc.w	HERO_DONE+4,HERO_DONE+4,HERO_DONE+4,HERO_DONE+4
	dc.w	HERO_DONE+4,HERO_DONE+4,HERO_DONE+4,HERO_DONE+4
	dc.w	HERO_DONE+4,HERO_DONE+4,HERO_DONE+4,HERO_DONE+4
	dc.w	HERO_DONE+4,HERO_DONE+4,HERO_DONE+4,HERO_DONE+4
.nodanimend:


;---------------------------------------------------------------------------
	xdef	killHero
killHero:
; Hero is killed by a monster or another external moving object.
; Start dying animation, when not already active.

	tst.w	Hero_dyingAnim(a4)
	beq	deathFalling		; standard death
	rts


;---------------------------------------------------------------------------
deathFalling:
; Standard death. Hero is falling out of the screen.
; -> d0 = 1, lethal for backgd_collision

	move.w	#DEATH_FALLING,Hero_dyingAnim(a4)
	clr.w	Hero_animCnt(a4)
	move.w	#HEROGRAV_BOUNCE,Hero_vy(a4)

	moveq	#SND_SCREAM,d0
	bsr	playSFX

	bra	hero_dying


;---------------------------------------------------------------------------
deathDrowning:
; Hero is drowning.
; -> d0 = 1, lethal for backgd_collision

	move.w	#DEATH_DROWNING,Hero_dyingAnim(a4)
	clr.w	Hero_animCnt(a4)
	move.w	d7,Hero_waterlevel(a4)
	move.w	#150,Hero_idleCnt(a4)	; show death for 150 frames (3sec)

	; vy back to normal, when hitting the surface
	move.w	#HEROGRAV_NORM,Hero_vy(a4)

	moveq	#SND_SPLASH,d0
	bsr	playSFX


;---------------------------------------------------------------------------
hero_dying:
; Clear the Hero_alive flag. Reset position animations.
; -> d0 = 1, lethal for backgd_collision

	sub.l	a1,a1
	bsr	position_animation

	clr.b	Hero_alive(a4)
	moveq	#1,d0
	rts


;---------------------------------------------------------------------------
	xdef	bounceAlignHero
bounceAlignHero:
; Put hero's feet above the given ypos. Then bounce with vy from object.
; d0.w = bounce vy
; d1.w = object's top ypos

	sub.w	#HEROH,d1
	move.w	d1,Hero+MOypos(a4)


;---------------------------------------------------------------------------
bounceHero:
; Make the hero bounce from any object.
; d0.w = bounce vy

	st	Hero_bounced(a4)
	move.w	d0,Hero_bouncevy(a4)
	rts


;---------------------------------------------------------------------------
	xdef	getHeroPos
getHeroPos:
; Return coordinates of the top-left edge.
; -> d0 = xpos
; -> d1 = ypos

	movem.w	Hero+MOxpos(a4),d0-d1
	rts


;---------------------------------------------------------------------------
	xdef	lookupStartPos
lookupStartPos:
; Find the start position for the hero in the current level.
; The start is marked in the BackgdBlocks table as BB_START. There must
; be only one of it in each map!

	move.l	Map(a4),a0
	move.l	BackgdBlocks(a4),a1
	moveq	#0,d0
	moveq	#0,d1

.1:	swap	d1
	clr.w	d1

.2:	move.b	(a0)+,d0
	cmp.b	#BB_START,(a1,d0.w)
	beq	.3
	addq.w	#1,d1
	cmp.w	MapWidth(a4),d1
	bne	.2
	swap	d1
	addq.w	#1,d1
	cmp.w	MapHeight(a4),d1
	bne	.1

	; panic, when no start tile has been found
	move.w	#$aaf,d0
	bra	panic

.3:	swap	d1			; MSW=xpos, LSW=ypos
	move.l	d1,StartX(a4)
	rts


;---------------------------------------------------------------------------
	xdef	getStart
getStart:
; -> d0 = StartX
; -> d1 = StartY

	movem.w	StartX(a4),d0-d1
	rts



	data


HeroImgTypes:
	incbin	"gfx/hero22types.bin"



	section	__MERGED,data


	; Hero color table (only a few colors are really used)
	xdef	HeroColors
HeroColors:
	incbin	"gfx/hero22.cmap"



	section	__MERGED,bss


	; Table of hero animations
	xdef	HeroAnims
HeroAnims:
	ds.l	MAXHEROSLOTS

	; Start position in current level, or last save position.
	; This is the position where the hero will start at the beginning
	; of a level or after losing a life.
StartX:
	ds.w	1
StartY:
	ds.w	1

	; The hero's MOB structure. Position and image information.
	xdef	Hero
Hero:
	ds.b	sizeof_MOB

	; Hero status.
	xdef	Hero_alive
Hero_alive:
	ds.b	1
Hero_bounced:
	ds.b	1
	even
Hero_vx:
	ds.w	1
	xdef	Hero_vy
Hero_vy:
	ds.w	1
Hero_bouncevy:
	ds.w	1
Hero_facing:
	ds.w	1
Hero_anim:
	ds.w	1
Hero_idleCnt:
	ds.w	1
Hero_animCnt:
	ds.w	1
Hero_lastLeft:
	ds.b	1
Hero_lastRight:
	ds.b	1
Hero_lastJump:
	ds.b	1
Hero_inflight:
	ds.b	1
Hero_climb:
	ds.b	1
Hero_lastClimb:
	ds.b	1
Hero_climbJump:
	ds.b	1
	even
Hero_dyingAnim:
	ds.w	1
Hero_bridge:
	ds.l	1
Hero_brCol:
	ds.w	1
Hero_brRow:
	ds.w	1
Hero_brTile:
	ds.w	1
Hero_waterlevel:
	ds.w	1
