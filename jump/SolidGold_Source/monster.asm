*
* Monsters. Movement strategies and collisions.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*
* load_monster16(d0.w=fileID, a0=imagetypes)
* load_monster20(d0.w=fileID, a0=imagetypes)
* load_monsterchar(d0.w=fileID)
* d0=img = getMonster16Image()
* init_monsters(a0=monsterRecords, d0.w=numMonsters)
* add_monster_bobs()
* d0.w=cnt = count_monsters()
* $update_monsters()
*
* MultiKill
*

	include	"display.i"
	include	"map.i"
	include	"mob.i"
	include	"monster.i"
	include	"hero.i"
	include	"levelstats.i"
	include	"sound.i"
	include	"macros.i"


; Monster structure
		rsreset
Malive		rs.w	1		; 0 not alive, <0 active, >0 inactive
Mdying		rs.w	1		; play dying animation
Mjmpaction	rs.w	1		; action when jumping onto monster
Mharmless	rs.b	1		; true, when monster is harmless
Mreserved	rs.b	1
Mvx		rs.w	1		; current x movement delta
Mvy		rs.w	1		; current y movement delta
Manimcnt	rs.w	1		; animation phase
Manimoff	rs.w	1		; animation table offset
Mxbase		rs.w	1		; base x position
Mybase		rs.w	1		; base y position
Myoffcnt	rs.w	1		; y-offset table index
Mdelay		rs.w	1		; delay counter
Mrand		rs.w	1		; 16-bit random value
Msize		rs.w	1		; image size (offset to mask)
Mtype		rs.l	1		; pointer to MonsterTypes entry
Mlink		rs.l	1		; pointer to a companion monster
Mmob		rs.b	sizeof_MOB	; MOB structure (position, image)
sizeof_Monster	rs.b	0

; Mjmpaction definitions
MJMP_HEROKILLED	equ	0		; m. is invulnerable, hero gets killed
MJMP_BOUNCED	equ	2		; m. killed, hero bounces
MJMP_TMPBOUNCE	equ	4		; m. survives, temporary spring-board


; from memory.asm
	xref	alloc_chipmem

; from trackdisk.asm
	xref	td_loadcr
	xref	td_loadcr_chip

; from main.asm
	xref	rand
	xref	loaderr
	xref	ovflowerr
	xref	panic

; from game.asm
	xref	addScore
	xref	FrameRand

; from levelstats.asm
	xref	StatAct

; from bob.asm
	xref	newBOB
	xref	unlinkBOB

; from tiles.asm
	xref	makeBlkTable

; from map.asm
	xref	MapRowOffTab
	xref	Map
	xref	MapWidth
	xref	ScrWidth
	xref	BackgdBlocks

; from hero.asm
	xref	killHero
	xref	bounceAlignHero
	xref	Hero
	xref	Hero_alive
	xref	Hero_vy

; from sound.asm
	xref	playSFX



	near	a4

	code


;---------------------------------------------------------------------------
	xdef	load_monster16
load_monster16
; d0 = file ID
; a0 = image types table (256 entries)

	move.l	a2,-(sp)
	move.l	a0,a2

	; load monster16 images
	bsr	td_loadcr_chip
	beq	loaderr

	; make monster image pointer table
	move.l	a2,a0
	move.l	d0,a2
	move.l	MonsterImages(a4),a1
	move.w	#256,d0
	move.w	#MONST16SIZE,d1
	bsr	makeBlkTable

	move.l	(sp)+,a2
	rts


;---------------------------------------------------------------------------
	xdef	load_monster20
load_monster20
; d0 = file ID
; a0 = image types table (256 entries)

	move.l	a2,-(sp)
	move.l	a0,a2

	; load monster20 images
	bsr	td_loadcr_chip
	beq	loaderr

	; make monster image pointer table
	move.l	a2,a0
	move.l	d0,a2
	move.l	MonsterImages(a4),a1
	lea	256*4(a1),a1
	move.w	#256,d0
	move.w	#MONST20SIZE,d1
	bsr	makeBlkTable

	move.l	(sp)+,a2
	rts


;---------------------------------------------------------------------------
	xdef	load_monsterchar
load_monsterchar:
; Load an array which describes all MAXMONSTERTYPES monster types
; (animation images, behaviour, etc.).
; d0 = file ID

	; load monster type characteristics
	move.l	MonsterTypes(a4),a0
	bsr	td_loadcr
	beq	loaderr
	cmp.l	#MAXMONSTERTYPES*sizeof_MT,d0
	bhi	ovflowerr
	rts


;---------------------------------------------------------------------------
	xdef	getMonster16Image
getMonster16Image:
; Find first monster type with height 16 and return the image of its
; first animation block to the left.
; -> d0 = image pointer, or NULL when no such monster exists

	move.l	MonsterTypes(a4),a0
	lea	-sizeof_MT(a0),a0
	moveq	#9-1,d0

.1:	lea	sizeof_MT(a0),a0
	cmp.w	#16,MTheight(a0)
	dbeq	d0,.1
	bne	.error

	; calculate pointer to the first left-animation frame
	move.w	MTleftanim(a0),d0
	move.l	MonsterImages(a4),a0
	move.l	(a0,d0.w),d0
	rts

.error:
	moveq	#0,d0
	rts


;---------------------------------------------------------------------------
	xdef	init_monsters
init_monsters:
; a0 = pointer to array of monster description records
; d0.w = number of monsters in this array

	movem.l	d2-d5/a5-a6,-(sp)

	move.l	Monsters(a4),a5
	move.l	a0,a6
	moveq	#MAXMONSTERS,d4
	move.w	d0,d5
	bra	.3

	; initialize a Monster slot for each monster description record
.1:	movem.w	(a6)+,d0-d3		; MDtype, MDir, MDcol, MDrow

	; fix direction
	tst.w	d1
	bmi	.2
	addq.w	#1,d1			; MDir 0 -> 1

.2:	bsr	init_monster

	; set initial position
	lsl.w	#4,d2			; xpos = MDcol*16
	move.w	d2,Mmob+MOxpos(a5)
	move.w	d2,Mxbase(a5)

	; row on the map is based on the monster's feet, so adjust
	move.w	Mmob+MOheight(a5),d0
	sub.w	#16,d0
	lsl.w	#4,d3
	sub.w	d0,d3
	move.w	d3,Mmob+MOypos(a5)	; ypos = MDrow*16-(MOheight-16)
	move.w	d3,Mybase(a5)

	lea	sizeof_Monster(a5),a5
	subq.w	#1,d4
.3:	dbmi	d5,.1

	bpl	.5
	bra	outofmonsters

	; clear remaining monster slots
.4:	clr.w	Malive(a5)
	st	Mdying(a5)		; mark monster as no longer used
	lea	sizeof_Monster(a5),a5
.5:	dbf	d4,.4

	movem.l	(sp)+,d2-d5/a5-a6
	rts


;---------------------------------------------------------------------------
get_monster:
; Allocate an unused monster status slot.
; -> a0 = monster status

	move.l	Monsters(a4),a0
	moveq	#MAXMONSTERS-1,d0

	; Only monsters which have Malive=0 and Mdying!=0 are available.
.1:	tst.w	Malive(a0)
	bne	.2
	tst.w	Mdying(a0)
	bne	got_monster
.2:	lea	sizeof_Monster(a0),a0
	dbf	d0,.1

outofmonsters:
	move.w	#$f6e,d0		; pink: no more monster slots
	bra	panic

got_monster:
	rts


;---------------------------------------------------------------------------
init_monster:
; Initialize a monster slot according to the given type and facing direction.
; d0.w = type (1..)
; d1.w = dir (-1, 1)
; a5 = monster status

	; get type description structure
	move.w	d0,Malive(a5)		; monster is alive now, but inactive
	clr.w	Mdying(a5)
	clr.b	Mharmless(a5)		; no monster is harmless by default
	subq.w	#1,d0
	mulu	#sizeof_MT,d0
	move.l	MonsterTypes(a4),a0
	lea	(a0,d0.w),a1		; a1 monster type pointer
	move.l	a1,Mtype(a5)

	; Set monster's vulnerability and the function to call when
	; the hero jumps on top of it (Mjmpaction).
	cmp.w	#MSTRAT_COV,MTstrat(a1)
	bne	.1

	; Monster type MSTRAT_COV protects itself with a shield, which works
	; like a spring-board.
	moveq	#MJMP_TMPBOUNCE,d0
	bra	.3

	; When there are no points for this monster type, then it is
	; invulnerable.
.1:	tst.w	MTpoints(a1)
	bne	.2
	moveq	#MJMP_HEROKILLED,d0
	SKIPW
.2:	moveq	#MJMP_BOUNCED,d0

.3:	move.w	d0,Mjmpaction(a5)

	; set width and height, image size
	move.w	#MONSTW>>4,Mmob+MOwidth(a5)
	move.w	MTheight(a1),d0
	move.w	d0,Mmob+MOheight(a5)	; MOB height
	mulu	#PLANES*(MONSTW>>3),d0
	move.w	d0,Msize(a5)		; d0 image size

	; set initial movement direction and speed
	move.w	#MONSTGRAV_NORM,Mvy(a5)
	muls	MTspeed(a1),d1
	move.w	d1,Mvx(a5)
	bmi	.4

	; set initial animation
	move.w	MTrightanim(a1),d1
	bra	.5
.4:	move.w	MTleftanim(a1),d1
.5:	move.l	MonsterImages(a4),a0
	move.l	(a0,d1.w),a0
	move.l	a0,Mmob+MOimage(a5)
	add.w	d0,a0			; add image size
	move.l	a0,Mmob+MOmask(a5)
	clr.w	Manimcnt(a5)
	st	Manimoff(a5)		; invalidate

	; init type specific variables
	clr.w	Myoffcnt(a5)
	clr.w	Mdelay(a5)
	clr.l	Mlink(a5)

	; set a random value for each monster
	bsr	rand
	move.w	d0,Mrand(a5)
	rts


;---------------------------------------------------------------------------
	xdef	count_monsters
count_monsters:
; Count all monsters which are killable for the player.
; -> d0 = count

	move.l	Monsters(a4),a0
	moveq	#MAXMONSTERS-1,d1
	moveq	#0,d0

.1:	tst.w	Malive(a0)
	beq	.2

	; monster is alive, make sure it can be killed
	cmp.w	#MJMP_HEROKILLED,Mjmpaction(a0)
	beq	.2
	addq.w	#1,d0			; count killable monster

.2:	lea	sizeof_Monster(a0),a0
	dbf	d1,.1

	rts


;---------------------------------------------------------------------------
	xdef	add_monster_bobs
add_monster_bobs:
; Create BOBs for all monsters which are alive.

	movem.l	d2/a2,-(sp)

	move.l	Monsters(a4),a2
	moveq	#MAXMONSTERS-1,d2

.1:	tst.w	Malive(a2)
	beq	.2

	; create a new BOB for this monster
	lea	Mmob(a2),a0
	bsr	newBOB
	beq	outofbobs

.2:	lea	sizeof_Monster(a2),a2
	dbf	d2,.1

	movem.l	(sp)+,d2/a2
	rts

outofbobs:
	move.w	#$ff8,d0		; light yellow: out of BOBs
	bra	panic


;---------------------------------------------------------------------------
	xdef	update_monsters
update_monsters:
; Move monsters according to their type's movement strategy.
; Check collisions with hero.
; Registers, except a4 - a6, are not preserved!

	movem.l	a5-a6,-(sp)

	tst.b	Hero_alive(a4)
	bne	.1

	; make collision checks fail, when hero is not alive
	move.w	#$8000,d3
	swap	d3
	move.l	d3,d4
	bra	.2

	; load Hero's current position
.1:	movem.w	Hero+MOxpos(a4),d3-d4
	addq.w	#LETHALX0,d3
	swap	d3			; d3-MSW heroX+LETHALX0
	addq.w	#LETHALY0,d4
	swap	d4			; d4-MSW heroY+LETHALY0

	; load other constants
.2:	move.l	Map(a4),a2
	move.l	BackgdBlocks(a4),a3
	move.w	MapWidth(a4),d3		; d3-LSW map width in bytes
	moveq	#16,d2			; d2 mask for tile border check
	swap	d2

	; monster loop
	move.l	Monsters(a4),a5
	move.w	#MAXMONSTERS-1,d2

mloop:
	move.w	Malive(a5),d0
	beq	mnext
	bmi	.active

	; Monster is still inactive. Check whether it has become visible,
	; which would activate it for the rest of its life.
	tst.b	Mmob+MOvisible(a5)
	beq	mnext
	st	Malive(a5)		; activate!

.active:
	; monster is active, because it was visible at some point
	swap	d2			; d2.w is $10 mask now

	move.l	Mtype(a5),a1		; a1 monster type description
	move.w	Mmob+MOheight(a5),d4	; d4-LSW monster height

	;-----------------------------------------------------------
	; Load monster's xpos/ypos and translate it to a map offset.
	;-----------------------------------------------------------

	movem.w	Mmob+MOxpos(a5),d6-d7

	lea	MapRowOffTab(a4),a0
	moveq	#-16,d0
	and.w	d7,d0
	asr.w	#2,d0
	move.l	(a0,d0.w),a6
	move.w	d6,d0
	asr.w	#4,d0
	add.w	d0,a6			; a6 map offset for top-left edge

	move.w	Mdying(a5),d0
	bne	mdying

	;-------------------------------------
	; Execute monster's movement strategy.
	;-------------------------------------
mstrat:
	move.w	MTstrat(a1),d0
	move.w	.strattab(pc,d0.w),d0
	jmp	.strattab(pc,d0.w)

.strattab:
	dc.w	mnone-.strattab		; no movement
	dc.w	strat_lr-.strattab
	dc.w	strat_lrp-.strattab
	dc.w	strat_lrf-.strattab
	dc.w	strat_jmp-.strattab
	dc.w	strat_udblk-.strattab
	dc.w	strat_fall-.strattab
	dc.w	strat_drop-.strattab
	dc.w	strat_lrprnm-.strattab
	dc.w	strat_lrfrd-.strattab
	dc.w	strat_sht-.strattab
	dc.w	strat_leap-.strattab
	dc.w	strat_cov-.strattab
	dc.w	strat_ud-.strattab
	dc.w	strat_lrpynm-.strattab
	dc.w	strat_arch-.strattab
	dc.w	strat_mis-.strattab
	dc.w	strat_hor-.strattab
	dc.w	strat_wiz-.strattab


	;-----------------------------------
	; Execute monster's dying animation.
	;-----------------------------------
mdying:
	move.w	.dyingtab-2(pc,d0.w),d0
	jmp	.dyingtab(pc,d0.w)

.dyingtab:
	dc.w	mkill_dead-.dyingtab
	dc.w	mkill_dropinit-.dyingtab
	dc.w	mkill_drop-.dyingtab
	dc.w	mkill_fallinit-.dyingtab
	dc.w	mkill_fall-.dyingtab
	dc.w	mkill_vanish-.dyingtab
	dc.w	mkill_rvanish-.dyingtab


	;--------------------------------------------------
	; No movement. Mvx selects left or right animation.
	;--------------------------------------------------
mnone:
	tst.w	Mvx(a5)
	bmi	.animleft
	lea	MTrightanim(a1),a0
	move.w	MTrightframes(a1),d1
	bra	mnextanim
.animleft:
	lea	MTleftanim(a1),a0
	move.w	MTleftframes(a1),d1


	;--------------------------
	; Set next animation phase.
	;--------------------------

mnextanim:
; a0 = animation table pointer to use (MTleftanim or MTrightanim)
; d1 = number of animation frames (MTleftframes/MTrightframes)
; a5 = monster status

	move.w	Manimcnt(a5),d0
	addq.w	#2,d0
	cmp.w	d1,d0
	blo	msetanim
	moveq	#0,d0			; reset to first animation frame

msetanim:
; d0 = new Manimcnt
; a0 = animation table pointer to use (MTleftanim or MTrightanim)
; a5 = monster status

	move.w	d0,Manimcnt(a5)
	move.w	(a0,d0.w),d0
	cmp.w	Manimoff(a5),d0
	beq	mcoll

mnewimage:
; d0 = new monster image table offset
; a5 = monster status

	move.w	d0,Manimoff(a5)
	move.l	MonsterImages(a4),a0
	move.l	(a0,d0.w),a0
	move.l	a0,Mmob+MOimage(a5)
	add.w	Msize(a5),a0
	move.l	a0,Mmob+MOmask(a5)


	;---------------------------
	; Collision check with hero.
	;---------------------------

mcoll:
	; get heroX+LETHALX0 and heroY+LETHALY0 into d3/d4
	swap	d3
	swap	d4

	move.w	MTcollx1(a1),d0
	add.w	d6,d0
	cmp.w	d0,d3
	bgt	mcoll_done		; heroX0 > monsterX1

	move.w	MTcollx0(a1),d0
	add.w	d6,d0
	moveq	#LETHALX1-LETHALX0,d1
	add.w	d3,d1
	cmp.w	d0,d1
	blt	mcoll_done		; heroX1 < monsterX0

	move.w	MTcolly1(a1),d0
	add.w	d7,d0
	cmp.w	d0,d4
	bgt	mcoll_done		; heroY0 > monsterY1

	move.w	MTcolly0(a1),d0
	add.w	d7,d0
	moveq	#LETHALY1-LETHALY0,d1
	add.w	d4,d1
	cmp.w	d0,d1
	blt	mcoll_done		; heroY1 < monsterY0

	; Collision rectangles of hero and monster are overlapping
	; at this point. Now find out whether the hero jumped onto
	; that monster, which is the case when the hero is falling,
	; while his feet are higher (minus an offset) than that of
	; the monster (which must be vulnerable).

	move.w	MTheight(a1),d0
	add.w	d7,d0
	moveq	#HEROH+JMPKILLMINH,d1
	add.w	d4,d1
	cmp.w	d0,d1
	bge	.killed			; hero killed, when heroY >= monstY
	move.w	Hero_vy(a4),d1
	subq.w	#HEROGRAV_NORM,d1
	ble	.killed			; or when hero is not falling

	; Hero jumped successfully onto the monster. Execute action.
	move.w	Mjmpaction(a5),d0
	move.w	.jmptab(pc,d0.w),d0
	jmp	.jmptab(pc,d0.w)
.jmptab:
	dc.w	.killed-.jmptab		; MJMP_HEROKILLED
	dc.w	.bounce_monst-.jmptab	; MJMP_BOUNCED
	dc.w	.tmpbounce-.jmptab	; MJMP_TMPBOUNCE

.killed:
	tst.b	Mharmless(a5)
	bne	mcoll_done		; monster is currently harmless
	bsr	killHero		; hero loses a life
	bra	mcoll_done

.tmpbounce:
	; Neither the hero nor the monster is killed. Stop the monster for
	; TMPBOUNCE_TIME frames and let the hero use it as a spring-board.
	move.w	#TMPBOUNCE_TIME,Mdelay(a5)
	moveq	#HEROGRAV_BOUNCE,d0
	move.w	d7,d1
	bsr	bounceAlignHero
	bra	mcoll_done

.bounce_monst:
	; hero kills the monster and bounces from it
	move.w	MTksound(a1),d0		; monster's kill sound
	move.w	MTpoints(a1),d1		; points for killing that monster

	bset	#0,MultiKill(a4)
	beq	.score

	; second kill in a row, without touching the ground: double bonus!
	add.w	d1,d1
	moveq	#SND_BONUS,d0		; play bonus sound instead
.score:
	bsr	playSFX
	move.w	d1,d0
	bsr	addScore		; get score

	addq.w	#1,StatAct+Stat_Killed(a4)

	moveq	#HEROGRAV_BOUNCE,d0
	move.w	d7,d1
	bsr	bounceAlignHero

	; start monster's dying animation
	move.w	MTktype(a1),Mdying(a5)
	clr.w	Manimcnt(a5)
	st	Manimoff(a5)		; invalidate

mcoll_done:
	; swap hero coordinates back into MSW
	swap	d3
	swap	d4

	;---------------------------------
	; Update monster status in memory.
	;---------------------------------

mupdate:
	movem.w	d6-d7,Mmob+MOxpos(a5)
	swap	d2

	; next monster
mnext:
	lea	sizeof_Monster(a5),a5
	dbf	d2,mloop

	movem.l	(sp)+,a5-a6
	rts


;---------------------------------------------------------------------------
strat_lr:
; Monster movement strategy: LR
; Move left and right until touching a solid block. Fall from platforms.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	; Calculate map-offset below the monster's feet. This is
	; always at least one row down to the current offset.
	; Even more when the monster is higher than 16 pixels.
	lea	(a6,d3.w),a0
	move.w	d4,d0
	sub.w	d2,d0
	bls	.1
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d2,d0
	beq	.1
	add.w	d3,a0
.1:	move.l	a0,d5			; d5 map offset to monster's feet

	; do horizontal movement
	bsr	move_horiz
	beq	lr_turn

	; set next animation phase
	move.w	Manimcnt(a5),d0
	addq.w	#2,d0
	cmp.w	d1,d0
	blo	lr_setanim
	moveq	#0,d0
	bra	lr_setanim

lr_turn:
	; turn around, when running into an obstacle
	neg.w	d1
	move.w	d1,Mvx(a5)
	bra	lr_gravity


;---------------------------------------------------------------------------
strat_wiz:
; Monster movement strategy: WIZ
; Move left and right until touching a solid block or platform ends (LRP).
; When hero comes too near (horizontally and vertically) then cast a
; protection spell and play the animation from MTlkillanim, making the
; monster invulnerable. Cast that spell MONSTWIZ_SPELLS time in a row,
; before returning to vulnerable state, where he is exhausted for
; MONSTWIZ_VULN frame to cast any more spells.
; Note: Because of some hardcoded animations this monster type cannot be
; used for anything else than the wizard from world 4.
; Also note that some monster status variables, like Mxbase and Mdelay,
; are abused here with a completely different meaning.
; Yes, this is an ugly monster type implementation, but it was the last
; one, and I wanted to make it fit without changing anything. ;)
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	tst.w	Mvx(a5)
	beq	.protection_spell

	; Monster is walking left/right using LRP strategy, until the
	; hero comes too near.

	move.w	Mdelay(a5),d0
	beq	.check_hero

	; Monster is still exhausted from the last protection spell.
	subq.w	#1,d0
	move.w	d0,Mdelay(a5)
	bra	strat_lrp

	; check for hero in vicinity
.check_hero:
	moveq	#MONSTWIZ_DISTX,d0
	moveq	#MONSTWIZ_DISTY,d1
	bsr	hero_vicinity
	beq	strat_lrp

	; stop and prepare a protection spell
	move.w	Mvx(a5),Mxbase(a5)	; remember old Mvx
	clr.w	Mvx(a5)			; stop!
	move.w	#WIZANIM_START-4,Manimoff(a5)
	move.w	#1,Manimcnt(a5)
	clr.w	Mdelay(a5)		; indicates preparation phase

.protection_spell:
	tst.w	Mdelay(a5)
	bne	.spell_effective

	; spell preparation phase, monster is still vulnerable
	subq.w	#1,Manimcnt(a5)
	bne	mcoll

	; next spell preparation animation phase
	move.w	#WIZANIM_FRAMES,Manimcnt(a5)
	move.w	Manimoff(a5),d0
	addq.w	#4,d0
	cmp.w	#WIZANIM_END,d0
	bls	mnewimage

	; protection spell has come into effect now
	move.w	#MJMP_HEROKILLED,Mjmpaction(a5)
	clr.w	Manimcnt(a5)
	st	Manimoff(a5)
	move.w	#MONSTWIZ_SPELLS,Mdelay(a5)

.spell_effective:
	lea	MTlkillanim(a1),a0
	move.w	Manimcnt(a5),d0
	addq.w	#2,d0
	cmp.w	MTlkillframes(a1),d0
	blo	msetanim

	; repeat the spell animation sequence MONSTWIZ_SPELLS times
	moveq	#0,d0
	subq.w	#1,Mdelay(a5)
	bne	msetanim

	; finished with using magic, return to normal LRP strategy
	move.w	Mxbase(a5),Mvx(a5)	; restore Mvx
	move.w	#MONSTWIZ_VULN,Mdelay(a5)
	move.w	#MJMP_BOUNCED,Mjmpaction(a5)

	; show first LRP animation frame
	clr.w	Manimcnt(a5)
	st	Manimoff(a5)
	bra	mnone


;---------------------------------------------------------------------------
strat_lrprnm:
; Monster movement strategy: LRPRNM
; Move left and right until touching a solid block or platform ends (LRP).
; Randomly switch to the next monster type.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	; When the lowest 8 bits of the monster's Mrand match the current
	; frame's random value, switch to next monster type structure.
	; This should be the case approx. once every 5 seconds.
	move.w	FrameRand(a4),d0
	cmp.b	Mrand+1(a5),d0
	bne	strat_lrp

	; transform monster to the following type and reexecute strategy
	lea	sizeof_MT(a1),a1
	addq.w	#1,Malive(a5)
	bsr	resetMonsterStatus
	bra	mstrat


;---------------------------------------------------------------------------
strat_lrpynm:
; Monster movement strategy: LRPYNM
; Move left and right until touching a solid block or platform ends (LRP).
; Switch to next monster type when facing into the hero's direction and
; hero is on the same height.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	; check if monster can see the hero, execute LRP strategy when not
	bsr	detect_hero
	beq	strat_lrp

	; transform monster to the following type and reexecute strategy
	lea	sizeof_MT(a1),a1
	addq.w	#1,Malive(a5)
	bsr	resetMonsterStatus
	bra	mstrat


;---------------------------------------------------------------------------
strat_cov:
; Monster movement strategy: COV
; Move left and right until touching a solid block or platform ends (LRP).
; When the hero jumps onto that monster it stops and changes into protection
; mode for MONSTCOV_TIME frames, while it can be used as a spring-board.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status

	move.w	Mdelay(a5),d0
	beq	strat_lrp		; monster is in normal LRP mode

	subq.w	#1,d0
	move.w	d0,Mdelay(a5)

	; play protective animation while Mdelay > 0
	tst.w	Mvx(a5)
	bmi	.covleft
	lea	MTrkillanim(a1),a0
	move.w	MTrkillframes(a1),d1
	bra	mnextanim
.covleft:
	lea	MTlkillanim(a1),a0
	move.w	MTlkillframes(a1),d1
	bra	mnextanim


;---------------------------------------------------------------------------
strat_lrp:
; Monster movement strategy: LRP
; Move left and right until touching a solid block or platform ends.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	; Calculate map-offset below the monster's feet. This is
	; always at least one row down to the current offset.
	; Even more when the monster is higher than 16 pixels.
	lea	(a6,d3.w),a0
	move.w	d4,d0
	sub.w	d2,d0
	bls	.1
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d2,d0
	beq	.1
	add.w	d3,a0
.1:	move.l	a0,d5			; d5 map offset to ground tile

	move.w	Mvx(a5),d1		; d1 horizontal movement speed
	bmi	.left

	;-------------------
	; Try to move right.
	;-------------------

	; always move right, as long as we are not aligned to a map tile
	moveq	#15,d0
	and.w	d6,d0
	bne	.moveright

	; turn around at the right end of the map
	moveq	#16,d0
	add.w	d6,d0
	cmp.w	ScrWidth(a4),d0
	bge	lr_turn

	; check for obstacle at xpos+16 / ypos+1
	lea	1(a6),a0
	moveq	#1,d0
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d2,d0
	beq	.ckright1
	add.w	d3,a0
.ckright1:
	move.b	(a2,a0.l),d0
	tst.b	(a3,d0.w)
	bne	lr_turn

	; check for obstacle at xpos+16 / ypos+height-abs(speed)
	lea	1(a6),a0
	move.w	d4,d0
	sub.w	d1,d0
	cmp.w	d2,d0
	blo	.ckright2
	add.w	d3,a0			; skip row, when height-speed >= 16
	sub.w	d2,d0
.ckright2:
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d2,d0
	beq	.ckright3
	add.w	d3,a0
.ckright3:
	move.b	(a2,a0.l),d0
	tst.b	(a3,d0.w)
	bne	lr_turn

	; When the platform, the monster is walking on, ends here,
	; then turn around. Check xpos+16 / ypos+height.
	move.b	1(a2,d5.l),d0
	move.b	(a3,d0.w),d0
	bmi	.moveright

	; Check if monster is on solid ground to turn around.
	; Otherwise it is probably falling. So it cannot control direction.
	move.b	(a2,d5.l),d0
	tst.b	(a3,d0.w)
	bne	lr_turn

.moveright:
	; increase xpos by movement speed
	move.w	d6,d0
	add.w	d1,d6
	eor.w	d6,d0
	and.w	d2,d0
	beq	.rightanim
	addq.l	#1,a6			; one tile right on the map

.rightanim:
	; set next animation phase for walking right
	lea	MTrightanim(a1),a0
	move.w	Manimcnt(a5),d0
	addq.w	#2,d0
	cmp.w	MTrightframes(a1),d0
	blo	lr_setanim
	moveq	#0,d0
	bra	lr_setanim

	;------------------
	; Try to move left.
	;------------------

.left:
	; always move left, as long as we are not aligned to a map tile
	moveq	#15,d0
	and.w	d6,d0
	bne	.moveleft

	; turn around at the left end of the map
	tst.w	d6
	beq	lr_turn

	; check for obstacle at xpos-1 / ypos+1
	lea	-1(a6),a0
	moveq	#1,d0
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d2,d0
	beq	.ckleft1
	add.w	d3,a0
.ckleft1:
	move.b	(a2,a0.l),d0
	tst.b	(a3,d0.w)
	bne	lr_turn

	; check for obstacle at xpos-1 / ypos+height-abs(speed)
	lea	-1(a6),a0
	move.w	d4,d0
	add.w	d1,d0
	cmp.w	d2,d0
	blo	.ckleft2
	add.w	d3,a0			; skip row, when height-speed >= 16
	sub.w	d2,d0
.ckleft2:
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d2,d0
	beq	.ckleft3
	add.w	d3,a0
.ckleft3:
	move.b	(a2,a0.l),d0
	tst.b	(a3,d0.w)
	bne	lr_turn

	; When the platform, the monster is walking on, ends here,
	; then turn around. Check xpos-1 / ypos+height.
	move.b	-1(a2,d5.l),d0
	move.b	(a3,d0.w),d0
	bmi	.moveleft

	; Check if monster is on solid ground to turn around.
	; Otherwise it is probably falling. So it cannot control direction.
	move.b	(a2,d5.l),d0
	tst.b	(a3,d0.w)
	bne	lr_turn

.moveleft:
	; decrease xpos by movement speed
	move.w	d6,d0
	add.w	d1,d6
	eor.w	d6,d0
	and.w	d2,d0
	beq	.leftanim
	subq.l	#1,a6			; one tile left on the map

.leftanim:
	; set next animation phase for walking left
	lea	MTleftanim(a1),a0
	move.w	Manimcnt(a5),d0
	addq.w	#2,d0
	cmp.w	MTleftframes(a1),d0
	blo	lr_setanim
	moveq	#0,d0


	;---------------
	; set animation
	;---------------

lr_setanim:
; a5 = monster status
; a0 = animation table
; d0 = image table offset

	move.w	d0,Manimcnt(a5)
	move.w	(a0,d0.w),d0
	cmp.w	Manimoff(a5),d0
	beq	lr_gravity

	; change image
	move.w	d0,Manimoff(a5)
	move.l	MonsterImages(a4),a0
	move.l	(a0,d0.w),a0
	move.l	a0,Mmob+MOimage(a5)
	add.w	Msize(a5),a0
	move.l	a0,Mmob+MOmask(a5)


	;-----------------------
	; Gravitational effects.
	;-----------------------

lr_gravity:
; a2 = map
; a3 = background block types
; a5 = monster status
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d5.l = map offset for ground tile
; d6.w = xpos
; d7.w = ypos

	move.l	d5,a0			; a0 map offset for ground tile
	add.w	d4,d7			; d7 ypos+height (ground pos)
	move.w	Mvy(a5),d5		; d5 vertical movement speed

	move.w	d5,d1
	asr.w	#2,d1
	move.w	d7,d0
	add.w	d1,d7			; ypos+height += vy / 4
	eor.w	d7,d0
	and.w	d2,d0
	beq	.1
	add.w	d3,a0			; monster ground is one field down

	; apply gravity
.1:	addq.w	#1,d5

	; check whether monster's bottom left edge is on solid ground
	move.b	(a2,a0.l),d0
	tst.b	(a3,d0.w)
	bmi	.landed

	; check whether monster's bottom right edge is on solid ground
	moveq	#15,d0
	and.w	d6,d0
	beq	.update
	move.b	1(a2,a0.l),d0
	tst.b	(a3,d0.w)
	bpl	.update

.landed:
	; The monster has solid ground under its feet, so we reduce
	; vy to MONSTERGRAV_NORM and align its feet with the solid tile.
	and.w	#$fff0,d7
	moveq	#MONSTGRAV_NORM,d5

.update:
	move.w	d5,Mvy(a5)
	sub.w	d4,d7			; subtract height: d7 is ypos again
	bra	mcoll


;---------------------------------------------------------------------------
strat_lrfrd:
; Monster movement strategy: LRFRD
; Fly left and right until touching a solid block. Change altitude on
; a sinus wave, but don't climb or fall into a solid block.
; When just switched from a walking strategy ascend up to MONSTFRD_HEIGHT
; above Mybase (previous base line on ground). Then follow the normal
; LRF strategy, but randomly start to descend again and switch to
; the previous monster type when landed.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	tst.w	Manimoff(a5)
	bpl	.1

	; Just started flying mode. Ascend up to MONSTFRD_HEIGHT from here.
	move.w	Mybase(a5),d0
	moveq	#-1,d5
	move.w	d5,Mvy(a5)		; Mvy=-1 means ascending
	and.w	#$fffe,d6		; xpos should be even
	bra	lrfrd_ascend

	; Enter descending mode when the lowest 8 bits of the monster's
	; Mrand match the current frame's random value.
	; This should be the case once every 5 seconds on average.
.1:	move.w	FrameRand(a4),d0
	cmp.b	Mrand+1(a5),d0
	bne	.2
	moveq	#1,d5
	move.w	d5,Mvy(a5)		; Mvy=1 means descending
	bra	lrfrd_descend

.2:	move.w	Mvy(a5),d5
	beq	strat_lrf		; normal LRF strategy flight
	bpl	lrfrd_descend

	;--------------------------------------------
	; Ascend MONSTFRD_HEIGHT pixels above Mybase.
	;--------------------------------------------
lrfrd_ascend:
	; fly left/right and turn at obstacles
	bsr	move_horiz
	bne	.1

	; turn around
	neg.w	d1
	move.w	d1,Mvx(a5)
	moveq	#0,d1			; no animation

	; ascend with Mvy
.1:	add.w	d7,d5			; d5 is new ypos

	; determine map tile at top edge
	move.w	d5,d0
	eor.w	d7,d0
	and.w	d2,d0
	beq	.2
	sub.w	d3,a6			; look one map row higher
.2:	move.b	(a2,a6.l),d0
	tst.b	(a3,d0.w)
	bne	.3			; we would hit an obstance on top

	; set new ypos, check if MONSTFRD_HEIGHT is reached
	move.w	d5,d7
	moveq	#-MONSTFRD_HEIGHT,d0
	add.w	Mybase(a5),d0
	cmp.w	d0,d7
	bgt	.4

	; Quit ascending mode, either when MONSTFRD_HEIGHT is reached
	; or when hitting an obstacle.
.3:	clr.w	Mvy(a5)
	move.w	d7,Mybase(a5)		; new ybase for sinus flight

.4:	tst.w	d1
	beq	mcoll
	bra	mnextanim

	;-------------------------
	; Descend to solid ground.
	;-------------------------
lrfrd_descend:
	; fly left/right and turn at obstacles
	bsr	move_horiz
	bne	.1

	; turn around
	neg.w	d1
	move.w	d1,Mvx(a5)
	moveq	#0,d1			; no animation

	; determine map tile at bottom edge, take monster height into account
.1:	add.w	d3,a6			; always at least one row down
	move.w	d4,d0
	sub.w	d2,d0
	bls	.2
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d2,d0
	beq	.2
	add.w	d3,a6			; add another row

	; descend with Mvy
.2:	add.w	d4,d7			; calculate with ground ypos
	move.w	d7,d0
	add.w	d5,d7			; ypos += Mvy
	eor.w	d7,d0
	and.w	d2,d0
	beq	.3
	add.w	d3,a6			; monster ground is one row down
.3:	move.b	(a2,a6.l),d0
	tst.b	(a3,d0.w)
	beq	.4			; no solid ground, keep descending
	bmi	.5

	; Dangerous grounds below. Set Mybase to this ground and ascend
	; to MONSTFRD_HEIGHT from there.
	move.w	#-1,Mvy(a5)
	moveq	#-16,d0
	and.w	d7,d0			; aligned to top of ground
	sub.w	d4,d0
	move.w	d0,Mybase(a5)

.4:	sub.w	d4,d7			; d7 is real ypos (top edge) again
	tst.w	d1
	beq	mcoll
	bra	mnextanim

	; Solid ground detected. Transform monster to the previous type
	; (usually with a platform walking strategy).
.5:	lea	-sizeof_MT(a1),a1
	subq.w	#1,Malive(a5)
	bsr	resetMonsterStatus

	; align ypos with the ground tile and set it as the new Mybase
	and.w	#$fff0,d7
	sub.w	d4,d7			; d7 is real ypos (top edge) again
	move.w	d7,Mybase(a5)

	tst.w	d1
	beq	mcoll
	bra	mnextanim


;---------------------------------------------------------------------------
strat_lrf:
; Monster movement strategy: LRF
; Fly left and right until touching a solid block. Change altitude on
; a sinus wave, but don't climb or fall into a solid block.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	; fly left/right and turn at obstacles
	bsr	move_horiz
	bne	.saveanim
	neg.w	d1			; turn around
	move.w	d1,Mvx(a5)
	moveq	#0,d1			; no animation

.saveanim:
	movem.l	d1/a0,-(sp)

	; Modify flying height on a sinus wave, but do not collide with the
	; ground or ceiling.
	move.w	Myoffcnt(a5),d5
	addq.w	#1,d5
	cmp.w	#.yofftable_end-.yofftable,d5
	bne	.newypos
	moveq	#0,d5

.newypos:
	move.b	.yofftable(pc,d5.w),d0
	ext.w	d0
	add.w	Mybase(a5),d0
	swap	d5
	move.w	d0,d5			; d5 new ypos

	cmp.w	d7,d5			; higher or lower than current ypos?
	bgt	.flydown

	; flying upwards, determine map tile at top edge
	eor.w	d7,d0
	and.w	d2,d0
	beq	.heightcoll
	sub.w	d3,a6			; look one map row higher
	bra	.heightcoll

.yofftable:
	; amplitude -16 to 16, 64 entries
	include	"sin_16_64.asm"
.yofftable_end:

.flydown:
	; flying downwards, determine map tile at bottom edge
	add.w	d4,d0
	subq.w	#1,d0			; ybottom
	move.w	d0,d1
	sub.w	d7,d1			; ydelta

	cmp.w	d2,d1
	blo	.flydn_noskip
	add.w	d3,a6			; skip row, when ydelta >= 16
	sub.w	d2,d0

.flydn_noskip:
	eor.w	d7,d0
	and.w	d2,d0
	beq	.heightcoll
	add.w	d3,a6			; skip another row

.heightcoll:
	move.b	(a2,a6.l),d0
	tst.b	(a3,d0.w)
	bne	.anim			; we would hit a block, keep height

	; set new ypos, increment yofftable-index
	move.w	d5,d7
	swap	d5
	move.w	d5,Myoffcnt(a5)

.anim:
	movem.l	(sp)+,d1/a0
	tst.w	d1
	beq	mcoll
	bra	mnextanim


;---------------------------------------------------------------------------
strat_jmp:
; Monster movement strategy: JMP
; Jump with MTspeed from base position. Stop falling at base position
; and jump again, after a short delay.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	move.w	Mdelay(a5),d0
	beq	.jumping

	;---------------------------
	; monster prepares the jump
	;---------------------------

	subq.w	#1,d0
	move.w	d0,Mdelay(a5)
	bne	mcoll

	; leaping off
	move.w	MTspeed(a1),Mvy(a5)
	bra	mcoll

.jumping:
	move.w	Mvy(a5),d5		; d5 vertical movement speed
	bpl	.falling

	;--------------------
	; monster is jumping
	;--------------------

	move.w	d7,d0
	move.w	d5,d1
	addq.w	#3,d1			; fix for shifting negative value
	asr.w	#2,d1
	add.w	d1,d7			; ypos + vy / 4

	; calculate new map position
	eor.w	d7,d0
	and.w	d2,d0
	beq	.upgravity
	sub.w	d3,a6			; monster is now one map tile up

.upgravity:
	addq.w	#1,d5			; apply gravity

	; check if monster hits the ceiling
	move.b	(a2,a6.l),d0
	move.b	(a3,d0.w),d0
	beq	.animate
	subq.b	#BB_DROWNING,d0		; water is ok
	beq	.animate

	; stop the jump, set vy to MONSTGRAV_NORM and align with lower tile
	moveq	#MONSTGRAV_NORM,d5
	add.w	#15,d7
	and.w	#$fff0,d7
	bra	.animate

	;--------------------
	; monster is falling
	;--------------------

.falling:
	; Calculate map-offset below the monster's feet. This is
	; always at least one row down to the current offset.
	; Even more when the monster is higher than 16 pixels.
	add.w	d3,a6
	move.w	d4,d0
	sub.w	d2,d0
	bls	.addvy
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d2,d0
	beq	.addvy
	add.w	d3,a6

.addvy:
	add.w	d4,d7			; d7 ypos+height

	move.w	d5,d1
	asr.w	#2,d1
	move.w	d7,d0
	add.w	d1,d7			; ypos+height += vy / 4
	eor.w	d7,d0
	and.w	d2,d0
	beq	.downgravity
	add.w	d3,a6			; monster ground is one field down

.downgravity:
	addq.w	#1,d5			; apply gravity

	; check if monster hits solid ground
	move.b	(a2,a6.l),d0
	move.b	(a3,d0.w),d0
	beq	.freefall

	; hits the water surface?
	subq.b	#BB_DROWNING,d0
	beq	.water

	; solid ground below, so stop falling and align with it
	moveq	#MONSTGRAV_NORM,d5
	moveq	#-16,d0
	and.w	d7,d0
	sub.w	d4,d0			; subtract height for top edge ypos

.basereached:
	; Monster returned to its start position.
	; After a short delay it will jump again.
	move.w	#MONSTJMP_DELAY,Mdelay(a5)
	move.w	d0,d7			; d7 ypos is start
	moveq	#-1,d5			; look up
	moveq	#0,d0			; and set first animation phase
	bra	.updatevy

.water:
	; restrict vy to MONSTGRAV_NORM in water
	moveq	#MONSTGRAV_NORM,d5

.freefall:
	sub.w	d4,d7			; d7 is real ypos (top edge) again

	; check if monster has fallen back to its base row
	move.w	Mybase(a5),d0
	cmp.w	d0,d7
	bge	.basereached

	;---------------
	; set animation
	;---------------

.animate:
	move.w	Manimcnt(a5),d0
	addq.w	#2,d0
.updatevy:
	move.w	d5,Mvy(a5)

	; left animations are used for jumping, right for falling
	bpl	.fallanim

	; jump animation
	lea	MTleftanim(a1),a0
	cmp.w	MTleftframes(a1),d0
	blo	msetanim
	moveq	#0,d0
	bra	msetanim

.fallanim:
	; fall animation
	lea	MTrightanim(a1),a0
	cmp.w	MTrightframes(a1),d0
	blo	msetanim
	moveq	#0,d0
	bra	msetanim


;---------------------------------------------------------------------------
strat_leap:
; Monster movement strategy: LEAP
; Do nothing for a random period, then leap forward.
; Leap with MONSTGRAV_LEAP while accelerating to Mvx.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	move.w	Mdelay(a5),d0
	bne	waitfornextleap

	move.w	Mvy(a5),d5
	bpl	leap_descend

	;----------------------------
	; Ascending part of the leap.
	;----------------------------

	move.w	d7,d0
	move.w	d5,d1
	addq.w	#3,d1			; fix for shifting negative value
	asr.w	#2,d1
	add.w	d1,d7			; ypos += vy / 4

	; calculate new map position
	eor.w	d7,d0
	and.w	d2,d0
	beq	.1
	sub.w	d3,a6			; monster is now one map tile up

.1:	addq.w	#1,d5			; apply gravity

	; check if monster hits the ceiling
	move.b	(a2,a6.l),d0
	move.b	(a3,d0.w),d0
	bpl	.2

	; stop the jump, set vy to MONSTGRAV_NORM and align with lower tile
	moveq	#MONSTGRAV_NORM,d5
	add.w	#15,d7
	and.w	#$fff0,d7
	add.w	d3,a6

.2:	move.w	d5,Mvy(a5)

	bsr	move_horiz		; horizontal leap movement
	beq	leap_turn

	; animate the whole sequence once
	move.w	Manimcnt(a5),d0
	addq.w	#2,d0
	cmp.w	d1,d0
	bhs	mcoll
	bra	msetanim

	;-----------------------------
	; Descending part of the leap.
	;-----------------------------

leap_descend:
	; Calculate map-offset below the monster's feet. This is
	; always at least one row down to the current offset.
	; Even more when the monster is higher than 16 pixels.
	lea	(a6,d3.w),a0
	move.w	d4,d0
	sub.w	d2,d0
	bls	.1
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d2,d0
	beq	.1
	add.w	d3,a0			; a0 map offset to ground tile

.1:	move.w	d7,d1			; d1 old ypos
	add.w	d4,d7			; d7 ypos monster ground

	; add vy and check for solid ground
	move.w	d7,d0
	asr.w	#2,d5
	add.w	d5,d7			; monster ground += vy / 4
	eor.w	d7,d0
	and.w	d2,d0
	beq	.2
	add.w	d3,a0			; monster ground is one row down
.2:	move.b	(a2,a0.l),d0
	move.b	(a3,d0.w),d0
	bmi	leap_solidground
	subq.b	#BB_DROWNING,d0		; water is also solid for frog-likes
	beq	leap_solidground

	; continue falling, apply gravity
	addq.w	#1,Mvy(a5)

	; set new ypos and calculate new map offset
	sub.w	d4,d7			; d7 is real ypos (top edge) again
	eor.w	d7,d1
	and.w	d2,d1
	beq	.3
	add.w	d3,a6			; monster is now one map tile down

.3:	bsr	move_horiz		; horizontal leap movement
	bne	mcoll			; don't animate

leap_turn:
	; turn around when leaping against an obstacle, don't animate
	neg.w	d1
	move.w	d1,Mvx(a5)
	bra	mcoll

leap_solidground:
	; Align to solid ground. No horizontal movement anymore.
	and.w	#$fff0,d7
	sub.w	d4,d7			; d7 is real ypos (top edge) again
	move.w	#MONSTGRAV_NORM,Mvy(a5)

	; play landing animation, until Manimcnt is back to zero
	tst.w	Mvx(a5)
	bmi	.1
	lea	MTrightanim(a1),a0
	bra	.2
.1:	lea	MTleftanim(a1),a0
.2:	move.w	Manimcnt(a5),d0
	beq	.3
	subq.w	#2,d0
	bra	msetanim

	; landed and animation is back to start, set random delay
.3:	moveq	#127,d1
	and.w	FrameRand(a4),d1
	move.w	d1,Mdelay(a5)
	bra	mcoll

	;-----------------------------------
	; Random delay before the next leap.
	;-----------------------------------

waitfornextleap:
	subq.w	#1,d0
	move.w	d0,Mdelay(a5)
	bne	mcoll

	; start a new leap with vy = MONSTGRAV_LEAP
	move.w	#MONSTGRAV_LEAP,Mvy(a5)
	clr.w	Manimcnt(a5)		; start with leaping animation
	bra	mcoll


;---------------------------------------------------------------------------
strat_fall:
; Monster movement strategy: FALL
; After MONSTFALL_DELAY frames, fall until hitting the ground (animate
; MTrightanim). Play an impact animation from MTlkillanim, while
; waiting for MONSTRET_DELAY frames. Then move back to base position
; using MTspeed (animate MTleftanim).
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	move.w	Mdelay(a5),d0
	beq	.active

	;-----------------------------------------
	; monster waiting at base or after impact
	;-----------------------------------------

	subq.w	#1,d0
	move.w	d0,Mdelay(a5)

	tst.w	Mvy(a5)
	bpl	mcoll			; wait at base

	; play imact animation once
	lea	MTlkillanim(a1),a0
	move.w	Manimcnt(a5),d0
	addq.w	#2,d0
	cmp.w	MTlkillframes(a1),d0
	blo	msetanim
	bra	mcoll

.active:
	move.w	Mvy(a5),d5		; d5 vertical movement speed
	bpl	.falling

	;-----------------------------------------
	; monster is moving back to base position
	;-----------------------------------------

	add.w	d5,d7			; move upwards  with constant speed
	cmp.w	Mybase(a5),d7
	bgt	.animate

	; Base position reached.
	; Fall with normal gravity after a short delay.
	move.w	Mybase(a5),d7
	moveq	#MONSTGRAV_NORM,d5
	move.w	#MONSTFALL_DELAY,Mdelay(a5)
	clr.b	Mharmless(a5)		; monster in lethal mode
	bra	.animate

	;--------------------
	; monster is falling
	;--------------------

.falling:
	; Calculate map-offset below the monster's feet. This is
	; always at least one row down to the current offset.
	; Even more when the monster is higher than 16 pixels.
	add.w	d3,a6
	move.w	d4,d0
	sub.w	d2,d0
	bls	.addvy
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d2,d0
	beq	.addvy
	add.w	d3,a6

.addvy:
	add.w	d4,d7			; d7 ypos+height

	; Falling with vy/4
	move.w	d5,d1
	asr.w	#2,d1
	move.w	d7,d0
	add.w	d1,d7			; ypos+height += vy / 4
	eor.w	d7,d0
	and.w	d2,d0
	beq	.downgravity
	add.w	d3,a6			; monster ground is one map row down

.downgravity:
	addq.w	#1,d5			; apply gravity

	; check if monster hits solid ground
	move.b	(a2,a6.l),d0
	move.b	(a3,d0.w),d0
	beq	.fixypos

	; hits the water surface?
	subq.b	#BB_DROWNING,d0
	beq	.water

	; solid ground below, so stop falling and align with it
	and.w	#$fff0,d7
	move.w	MTspeed(a1),d5		; move back with vy = MTspeed
	clr.w	Manimcnt(a5)		; start impact animation

	; return to base after a short delay
	move.w	#MONSTRET_DELAY,Mdelay(a5)
;	st	Mharmless(a5)		; harmless while returning to base
	SKIPW

.water:
	; restrict vy to MONSTGRAV_NORM in water
	moveq	#MONSTGRAV_NORM,d5

.fixypos:
	sub.w	d4,d7			; d7 is real ypos (top edge) again

	;---------------
	; set animation
	;---------------

.animate:
	move.w	Manimcnt(a5),d0
	addq.w	#2,d0
.updatevy:
	move.w	d5,Mvy(a5)

	; right animations are used for falling, left for moving back
	bpl	.fallanim

	; move-upwards animation
	lea	MTleftanim(a1),a0
	cmp.w	MTleftframes(a1),d0
	blo	msetanim
	moveq	#0,d0
	bra	msetanim

.fallanim:
	; fall animation
	lea	MTrightanim(a1),a0
	cmp.w	MTrightframes(a1),d0
	blo	msetanim
	moveq	#0,d0
	bra	msetanim


;---------------------------------------------------------------------------
strat_drop:
; Monster movement strategy: DROP
; Animate MTleftanim in base position. Then fall down until hitting any
; surface (MTrightanim). Animate MTlkillanim on the ground. Then restart.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	move.w	Mvy(a5),d5
	beq	.landed
	bmi	.ceiling

	;--------------------
	; monster is falling
	;--------------------

	; Calculate map-offset below the monster's feet. This is
	; always at least one row down to the current offset.
	; Even more when the monster is higher than 16 pixels.
	add.w	d3,a6
	move.w	d4,d0
	sub.w	d2,d0
	bls	.addvy
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d2,d0
	beq	.addvy
	add.w	d3,a6

.addvy:
	add.w	d4,d7			; d7 ypos+height

	; Falling with vy/4
	move.w	d5,d1
	asr.w	#2,d1
	move.w	d7,d0
	add.w	d1,d7			; ypos+height += vy / 4
	eor.w	d7,d0
	and.w	d2,d0
	beq	.downgravity
	add.w	d3,a6			; monster ground is one map row down

.downgravity:
	addq.w	#1,d5			; apply gravity

	; check if monster hits solid ground
	move.b	(a2,a6.l),d0
	tst.b	(a3,d0.w)
	beq	.fixypos

	; solid ground below, so stop falling and align with it
	and.w	#$fff0,d7
	sub.w	d4,d7			; d7 is real ypos (top edge) again
	moveq	#0,d5			; vy = 0 indicates ground contact
	lea	MTlkillanim(a1),a0	; set first ground animation
	moveq	#0,d0
	bra	.update

.fixypos:
	sub.w	d4,d7			; d7 is real ypos (top edge) again

	;---------
	; animate
	;---------

	; fall animation
	move.w	Manimcnt(a5),d0
	addq.w	#2,d0
	lea	MTrightanim(a1),a0
	cmp.w	MTrightframes(a1),d0
	blo	.update
	moveq	#0,d0
	bra	.update

.landed:
	move.w	Manimcnt(a5),d0
	addq.w	#2,d0
	lea	MTlkillanim(a1),a0
	cmp.w	MTlkillframes(a1),d0
	blo	.update

	; ground animation done, return to base
	lea	MTleftanim(a1),a0
	moveq	#0,d0
	move.w	Mybase(a5),d7
	moveq	#-1,d5
	bra	.update

.ceiling:
	move.w	Manimcnt(a5),d0
	addq.w	#2,d0
	lea	MTleftanim(a1),a0
	cmp.w	MTleftframes(a1),d0
	blo	.update

	; ceiling animation done, start falling
	lea	MTrightanim(a1),a0
	moveq	#0,d0
	moveq	#MONSTGRAV_NORM,d5

.update:
	move.w	d5,Mvy(a5)
	bra	msetanim


;---------------------------------------------------------------------------
strat_ud:
; Monster movement strategy: UD
; Move or fly up and down with Mvx (as vy) and turn around at a solid block.
; MTleftanim is used for moving upwards and MTrightanim for downwards.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	move.w	Mvx(a5),d5
	bmi	.upwards

	;----------------
	; move downwards
	;----------------

	; Calculate map-offset below the monster's feet. This is
	; always at least one row down to the current offset.
	; Even more when the monster is higher than 16 pixels.
	add.w	d3,a6
	move.w	d4,d0
	sub.w	d2,d0
	bls	.addvy
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d2,d0
	beq	.addvy
	add.w	d3,a6

.addvy:
	add.w	d4,d7			; d7 is ypos below monster's feet

	move.w	d7,d0
	add.w	d5,d7			; d7 ypos+height+vy
	eor.w	d7,d0
	and.w	d2,d0
	beq	.checkdown
	add.w	d3,a6			; monster ground is one map row down

.checkdown:
	; check if monster hits solid ground
	move.b	(a2,a6.l),d0
	move.b	(a3,d0.w),d0
	beq	.fixypos

	; solid ground below, so stop moving, align with it and turn around
	and.w	#$fff0,d7
	neg.w	d5
	move.w	d5,Mvx(a5)

.fixypos:
	sub.w	d4,d7			; d7 is real ypos (top edge) again

	; downwards animation
	lea	MTrightanim(a1),a0
	move.w	MTrightframes(a1),d1
	bra	mnextanim

	;----------------
	; move upwards
	;----------------
.upwards:
	move.w	d7,d0
	add.w	d5,d7			; d7 ypos+vy
	eor.w	d7,d0
	and.w	d2,d0
	beq	.checkup
	sub.w	d3,a6			; monster top is one map row up

.checkup:
	; check if monster hits the ceiling
	move.b	(a2,a6.l),d0
	move.b	(a3,d0.w),d0
	beq	.anim

	; hit solid ceiling, so stop moving, align with it and turn around
	add.w	#15,d7
	and.w	#$fff0,d7
	neg.w	d5
	move.w	d5,Mvx(a5)

	; upwards animation
.anim:
	lea	MTleftanim(a1),a0
	move.w	MTleftframes(a1),d1
	bra	mnextanim


;---------------------------------------------------------------------------
strat_udblk:
; Monster movement strategy: UDBLK
; Move the monster up and down within block limits, controlled by
; the current animation phase.
; It is expected that the lowest numbered animation phase is stored
; in the first entry of MTleftanim.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	lea	.animyoffs(pc),a6

	move.w	Manimcnt(a5),d0
	addq.w	#2,d0
	cmp.w	MTleftframes(a1),d0
	blo	.1
	moveq	#0,d0
.1:	move.w	d0,Manimcnt(a5)

	; get current animation
	move.w	MTleftanim(a1,d0.w),d0
	cmp.w	Manimoff(a5),d0
	beq	.2

	; change image
	move.w	d0,Manimoff(a5)
	move.l	MonsterImages(a4),a0
	move.l	(a0,d0.w),a0
	move.l	a0,Mmob+MOimage(a5)
	add.w	Msize(a5),a0
	move.l	a0,Mmob+MOmask(a5)

	; change position according to displayed animation phase
	sub.w	MTleftanim(a1),d0	; offset to first animation phase
	lsr.w	#1,d0
	move.w	Mybase(a5),d7
	add.w	(a6,d0.w),d7

.2:	bra	mcoll

	; ypos offsets for spear animation (4 phases)
.animyoffs:
	dc.w	0,4,7,10


;---------------------------------------------------------------------------
strat_arch:
; Monster movement strategy: ARCH
; Continuously shoot at the hero using a missile, which is described by
; the following monster type.
; When the hero is no longer in the facing direction and on the same
; height as the monster, then continue shooting for a while until
; switching back to the previous monster type.
; hero is on the same height.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	move.l	Mlink(a5),d5
	beq	.create_missile

	; reset the timer when monster can see the hero
.detect:
	bsr	detect_hero
	beq	.decrtimer
	move.w	#MONSTARCH_WAIT,Mdelay(a5)
	bra	.action

	; decrement the Mdelay timer when hero is invisible
.decrtimer:
	subq.w	#1,Mdelay(a5)
	bne	.action

	; waited long enough: fall back to previous monster type
	lea	-sizeof_MT(a1),a1
	subq.w	#1,Malive(a5)
	bsr	resetMonsterStatus
	bra	mupdate

.action:
	move.l	d5,a6
	tst.w	Malive(a6)
	bne	.animate

	; Prepare a new missile. Set the missile flying direction according
	; to the monster's facing and set the start position to the
	; monster's current location (top-left edge).
	move.w	Mvx(a5),Mvx(a6)
	moveq	#-2,d0
	and.w	d6,d0			; make sure missile xpos is even
	movem.w	d0/d7,Mmob+MOxpos(a6)

	; attach a new BOB to the missile monster, activating it
	lea	Mmob(a6),a0
	move.l	a1,d5
	bsr	newBOB
	move.l	d5,a1

	; make it alive and reset archer animation
	st	Malive(a6)
	clr.w	Mdying(a6)
	clr.w	Manimcnt(a5)
	bra	mnone

.animate:
	; Missile is still in flight. Play animation once.
	tst.w	Manimcnt(a5)
	bne	mnone
	bra	mcoll

.create_missile:
	; Missile monster doesn't exist yet. Create it first.
	bsr	get_monster
	move.l	a0,Mlink(a5)

	move.w	Malive(a5),d0
	ext.w	d0			; type is stored in LSB of Malive
	addq.w	#1,d0			; next monster type is missile
	move.w	Mvx(a5),d1
	move.l	a5,d5
	move.l	a0,a5
	bsr	init_monster
	clr.w	Malive(a5)		; initially disable the missile
	move.l	d5,a5

	move.w	#-2,Manimcnt(a5)
	bra	mnone			; show first animation


;---------------------------------------------------------------------------
strat_mis:
; Monster movement strategy: MIS
; Fly once left or right until hitting an obstacle. Then disappear (killed).
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	; missile flies in direction of Mvx
	bsr	move_horiz
	bne	mnextanim

	; hit an obstacle: disappear
	bra	mkill_dead


;---------------------------------------------------------------------------
strat_sht:
; Monster movement strategy: SHT
; Fly left or right until hitting an obstacle. Then restart from Mxbase.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	; shot flies in direction of Mvx
	bsr	move_horiz
	bne	mnextanim

	; hit an obstacle, restart shot
	move.w	Mxbase(a5),d6
	bra	mcoll


;---------------------------------------------------------------------------
strat_hor:
; Monster movement strategy: HOR
; Fly horizontally left and right, turn on obstacles.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	; fly left/right and turn at obstacles
	bsr	move_horiz
	bne	mnextanim

	; turn around, no animation
	neg.w	d1
	move.w	d1,Mvx(a5)
	bra	mcoll


;---------------------------------------------------------------------------
move_horiz:
; Move horizontally with vx.
; Stop at obstacles. Doesn't stop in front of water or deadly tiles!
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset
; -> d0/Z = stopped at obstacle, no new xpos set
; -> d1 = current vx, when d0 indicates an obstacle
; -> d1 = max animation frames (MTleftframes/MTrightframes) when no obstacle
; -> a0 = animation table pointer (MTleftanim or MTrightanim)
; -> a6 = map offset for top leftmost pixel, when moving left,
;         or top rightmost pixel, when moving right, of the monster

	move.w	Mvx(a5),d1		; d1 horizontal movement speed
	bmi	.left

	;-------------------
	; Try to move right.
	;-------------------

	; always move right, as long as we are not aligned to a map tile
	moveq	#15,d0
	and.w	d6,d0
	bne	.moveright

	; turn around at the right end of the map
	moveq	#16,d0
	add.w	d6,d0
	cmp.w	ScrWidth(a4),d0
	bge	.obstacle

	; check for obstacle at xpos+16 / ypos+height-1
	lea	1(a6),a0
	move.w	d4,d0
	subq.w	#1,d0
	cmp.w	d2,d0
	blo	.ckright2
	add.w	d3,a0			; skip row, when height-1 >= 16
	sub.w	d2,d0
.ckright2:
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d2,d0
	beq	.ckright3
	add.w	d3,a0
.ckright3:
	move.b	(a2,a0.l),d0
	tst.b	(a3,d0.w)
	bmi	.obstacle

	; check for obstacle at xpos+16 / ypos
	move.b	1(a2,a6.l),d0
	tst.b	(a3,d0.w)
	bmi	.obstacle

.moveright:
	; increase xpos by movement speed and calc map offset for xpos+15/ypos
	addq.l	#1,a6			; xpos+15+speed is always one right
	move.w	d6,d0
	add.w	d1,d6
	moveq	#15,d1
	add.w	d6,d1
	eor.w	d1,d0
	and.w	d2,d0
	bne	.rightanim
	addq.l	#1,a6			; another tile right on the map

.rightanim:
	; prepare right animation
	lea	MTrightanim(a1),a0
	move.w	MTrightframes(a1),d1
	moveq	#1,d0
	rts

.obstacle:
	moveq	#0,d0			; Z-flag indicates obstacle
	rts

	;------------------
	; Try to move left.
	;------------------

.left:
	; always move left, as long as we are not aligned to a map tile
	moveq	#15,d0
	and.w	d6,d0
	bne	.moveleft

	; turn around at the left end of the map
	tst.w	d6
	beq	.obstacle

	; check for obstacle at xpos-1 / ypos+height-1
	lea	-1(a6),a0
	move.w	d4,d0
	subq.w	#1,d0
	cmp.w	d2,d0
	blo	.ckleft2
	add.w	d3,a0			; skip row, when height-1 >= 16
	sub.w	d2,d0
.ckleft2:
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d2,d0
	beq	.ckleft3
	add.w	d3,a0
.ckleft3:
	move.b	(a2,a0.l),d0
	tst.b	(a3,d0.w)
	bmi	.obstacle

	; check for obstacle at xpos-1 / ypos
	move.b	-1(a2,a6.l),d0
	tst.b	(a3,d0.w)
	bmi	.obstacle

.moveleft:
	; decrease xpos by movement speed and get map tile for xpos/ypos
	move.w	d6,d0
	add.w	d1,d6
	eor.w	d6,d0
	and.w	d2,d0
	beq	.leftanim
	subq.l	#1,a6			; one tile left on the map

.leftanim:
	; prepare left animation
	lea	MTleftanim(a1),a0
	move.w	MTleftframes(a1),d1
	moveq	#1,d0
	rts


;---------------------------------------------------------------------------
mkill_dropinit:
; Monster dying animation: DROP
; Fall, until a solid ground is hit. Play the dying animation once,
; before removing the monster.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	move.w	#MONSTGRAV_NORM,Mvy(a5)	; start with normal gravity
	addq.w	#2,Mdying(a5)		; call mkill_drop next time

mkill_drop:
	tst.b	Mmob+MOvisible(a5)
	beq	mkill_dead

	; Calculate map-offset below the monster's feet. This is
	; always at least one row down to the current offset.
	; Even more when the monster is higher than 16 pixels.
	lea	(a6,d3.w),a0
	move.w	d4,d0
	sub.w	d2,d0
	bls	.1
	add.w	d7,d0
	eor.w	d7,d0
	and.w	d2,d0
	beq	.1
	add.w	d3,a0			; a0 map offset for ground tile

.1:	add.w	d4,d7			; d7 ypos+height (ground pos)
	move.w	Mvy(a5),d5		; d5 vertical movement speed

	move.w	d5,d1
	asr.w	#2,d1
	move.w	d7,d0
	add.w	d1,d7			; ypos+height += vy / 4
	eor.w	d7,d0
	and.w	d2,d0
	beq	.2
	add.w	d3,a0			; monster ground is one field down

	; apply gravity
.2:	addq.w	#1,d5

	; check whether monster's bottom left edge is on solid ground
	move.b	(a2,a0.l),d0
	tst.b	(a3,d0.w)
	bmi	.landed

	; check whether monster's bottom right edge is on solid ground
	moveq	#15,d0
	and.w	d6,d0
	beq	.update
	move.b	1(a2,a0.l),d0
	tst.b	(a3,d0.w)
	bpl	.update

.landed:
	; The monster has solid ground under its feet, so we reduce
	; vy to MONSTERGRAV_NORM and align its feet with the solid tile.
	and.w	#$fff0,d7
	moveq	#MONSTGRAV_NORM,d5

.update:
	move.w	d5,Mvy(a5)
	sub.w	d4,d7			; subtract height: d7 is ypos again


;---------------------------------------------------------------------------
mkill_vanish:
; Monster dying animation: VANISH
; Don't move, just play the dying animation once.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	moveq	#1,d5
	bra	mkill_anim		; play animation once


;---------------------------------------------------------------------------
mkill_rvanish:
; Monster dying animation: RVANISH
; Don't move, just play the right dying animation once.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	clr.w	Mvx(a5)			; force MTrkillanim
	moveq	#1,d5
	bra	mkill_anim		; play animation once


;---------------------------------------------------------------------------
mkill_fallinit:
; Monster dying animation: FALL
; Make a small leap and then fall down until leaving the screen.
; d2.w = 16, used for map tile border checks
; d3.w = map width
; d4.w = monster height
; d6.w = xpos
; d7.w = ypos
; a1 = monster type description
; a2 = map
; a3 = background block types
; a5 = monster status
; a6 = map offset

	move.w	#-MONSTGRAV_NORM,Mvy(a5)
	addq.w	#2,Mdying(a5)		; call mkill_fall next time

mkill_fall:
	; declare dead, when fallen out of the screen
	tst.b	Mmob+MOvisible(a5)
	beq	mkill_dead

	; falling
	move.w	Mvy(a5),d1
	move.w	d1,d0
	asr.w	#2,d0
	add.w	d0,d7

	; apply gravity
	addq.w	#1,d1
	move.w	d1,Mvy(a5)

	; show next falling animation phase
	moveq	#0,d5


;---------------------------------------------------------------------------
mkill_anim:
; Set next animation phase and return to main loop.
; d5 = true: remove monster, when animation sequence restarts
; a1 = monster type description
; a5 = monster status

	move.w	Manimcnt(a5),d0
	addq.w	#2,d0
	tst.w	Mvx(a5)
	bpl	.rightanim

	lea	MTlkillanim(a1),a0
	cmp.w	MTlkillframes(a1),d0
	blo	.setanim
	bra	.resetanim

.rightanim:
	lea	MTrkillanim(a1),a0
	cmp.w	MTrkillframes(a1),d0
	blo	.setanim
.resetanim:
	tst.b	d5
	bne	mkill_dead		; declare monster as dead
	moveq	#0,d0

.setanim:
	move.w	d0,Manimcnt(a5)
	move.w	(a0,d0.w),d0
	cmp.w	Manimoff(a5),d0
	beq	mupdate

	; change image
	move.w	d0,Manimoff(a5)
	move.l	MonsterImages(a4),a0
	move.l	(a0,d0.w),a0
	move.l	a0,Mmob+MOimage(a5)
	add.w	Msize(a5),a0
	move.l	a0,Mmob+MOmask(a5)

	bra	mupdate


;---------------------------------------------------------------------------
mkill_dead:
; Declare the monster as dead and unlink all BOBs.
; a5 = monster status

	clr.w	Malive(a5)

	lea	Mmob(a5),a0
	bsr	unlinkBOB

	bra	mupdate


;---------------------------------------------------------------------------
detect_hero:
; Check if monster can see the hero, which is the case when it is facing
; the hero and their heights do overlap at some point.
; d3.w = MSW heroX+LETHALX0
; d4.w = MSW heroY+LEHTALY0 | LSW monster height
; d6.w = xpos
; d7.w = ypos
; a5 = monster status
; -> d0/Z = not detected

	; monster never sees the hero when it is not on the screen
	tst.b	Mmob+MOvisible(a5)
	beq	not_detected

	; check whether monster is facing the hero
	swap	d3
	cmp.w	d6,d3
	slt	d0			; true, when hero is left of monster
	swap	d3
	tst.w	Mvx(a5)
	smi	d1			; true, when monster is facing left
	cmp.b	d0,d1
	bne	not_detected

	; Monster is facing the hero. Now check whether the hero is on
	; the same height as the monster, which is the case when their
	; full height overlaps at some point.
	move.w	d4,d0
	add.w	d7,d0			; ypos+height

	swap	d4			; heroY+LETHALY0
	cmp.w	d0,d4
	bgt	.1			; hero is below the monster

	moveq	#LETHALY1-LETHALY0,d1
	add.w	d4,d1			; heroY+LEHTALY1
	swap	d4
	cmp.w	d7,d1
	blt	not_detected		; hero is above the monster

	; monster detects the hero
	moveq	#-1,d0
	rts

.1:	swap	d4

not_detected:
	moveq	#0,d0			; not detected
	rts


;---------------------------------------------------------------------------
hero_vicinity:
; Check if the hero is in the given vicinity of the monster.
; d0.w = maximum absolute horizontal distance
; d1.w = maximum absolute vertical distance
; d3.w = MSW heroX+LETHALX0
; d4.w = MSW heroY+LEHTALY0
; d6.w = xpos
; d7.w = ypos
; a5 = monster status
; -> d0/Z = not in vicinity

	; monster never sees the hero when it is not on the screen
	tst.b	Mmob+MOvisible(a5)
	beq	not_detected

	movem.l	d6-d7,-(sp)

	; calculate absolute x-distance
	swap	d3
	sub.w	d3,d6
	swap	d3
	addq.w	#LETHALX0,d6
	bpl	.1
	neg.w	d6

	; calculate absolute y-distance
.1:	swap	d4
	sub.w	d4,d7
	swap	d4
	addq.w	#LETHALY0,d7
	bpl	.2
	neg.w	d7

	; compare horizontal and vertical distance
.2:	cmp.w	d0,d6
	bhi	.3
	cmp.w	d1,d7
	bhi	.3

	; hero is in vicinity
	moveq	#1,d0
	SKIPW

	; hero is not in vicinity
.3:	moveq	#0,d0

.4:	movem.l	(sp)+,d6-d7
.5:	rts


;---------------------------------------------------------------------------
resetMonsterStatus:
; Reset some monster status fields after switching to a new monster type.
; a1 = mew monster type description
; a5 = monster status
; All registers, except d0, are preserved!

	; set new monster type
	move.l	a1,Mtype(a5)

	; recalculate height and size using new MTheight
	move.w	MTheight(a1),d0
	move.w	d0,Mmob+MOheight(a5)	; MOB height
	mulu	#PLANES*(MONSTW>>3),d0
	move.w	d0,Msize(a5)

	; set normal Mvy and set Mvx according to new MTspeed
	move.w	#MONSTGRAV_NORM,Mvy(a5)
	move.w	MTspeed(a1),d0
	tst.w	Mvx(a5)
	bpl	.1
	neg.w	d0
.1:	move.w	d0,Mvx(a5)

	; reset animation and other variables for the new type
	moveq	#0,d0
	move.w	d0,Manimcnt(a5)
	st	Manimoff(a5)		; invalidate
	move.w	d0,Myoffcnt(a5)
	move.w	d0,Mdelay(a5)

	rts



	section	__MERGED,data


	; Pointer to a table of monster image pointers.
MonsterImages:
	dc.l	MonsterImageTable

	; Pointer to an array to describe all monster types in this world.
MonsterTypes:
	dc.l	MonsterTypesBuffer

	; Pointer to the current status of all monsters.
Monsters:
	dc.l	MonsterStatusTable



	section	__MERGED,bss


	; set to 1 after killing a monster, cleared when touching the ground
	xdef	MultiKill
MultiKill:
	ds.b	1
	even



	bss


	; Table of monster image pointers.
	; First 256 monster16 pointers, then 256 monster20 pointers.
MonsterImageTable:
	ds.l	512

	; Description structure (animations, movement strategies, points)
	; for up to MAXMONSTERTYPES different monster types in a world.
MonsterTypesBuffer:
	ds.b	MAXMONSTERTYPES*sizeof_MT

	; Status for up to MAXMONSTERS on the map.
MonsterStatusTable:
	ds.b	MAXMONSTERS*sizeof_Monster
