	.file	"trond_msg90.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"slat/weapons/msg90_fire.wav"
	.align 2
.LC1:
	.long 0x0
	.align 2
.LC2:
	.long 0x40400000
	.align 2
.LC3:
	.long 0x3f800000
	.align 2
.LC4:
	.long 0xc0400000
	.align 3
.LC5:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl MSG90_Fire
	.type	 MSG90_Fire,@function
MSG90_Fire:
	stwu 1,-112(1)
	mflr 0
	stfd 31,104(1)
	stmw 28,88(1)
	stw 0,116(1)
	lis 29,gi@ha
	mr 31,3
	la 29,gi@l(29)
	lis 3,.LC0@ha
	lwz 11,36(29)
	la 3,.LC0@l(3)
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	addi 30,1,24
	mtlr 11
	addi 28,1,40
	lfs 31,0(9)
	blrl
	lwz 0,16(29)
	lis 9,.LC2@ha
	lis 10,.LC1@ha
	lis 11,.LC3@ha
	la 9,.LC2@l(9)
	la 10,.LC1@l(10)
	mr 5,3
	lfs 2,0(9)
	mtlr 0
	la 11,.LC3@l(11)
	lfs 3,0(10)
	mr 3,31
	lfs 1,0(11)
	li 4,1
	blrl
	lwz 10,84(31)
	mr 5,28
	li 6,0
	mr 4,30
	lwz 9,92(10)
	addi 9,9,1
	stw 9,92(10)
	lwz 11,84(31)
	lwz 0,3640(11)
	addi 11,11,740
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
	lwz 3,84(31)
	addi 3,3,3764
	bl AngleVectors
	lis 9,.LC4@ha
	lwz 4,84(31)
	mr 3,30
	la 9,.LC4@l(9)
	lfs 1,0(9)
	addi 4,4,3712
	bl VectorScale
	lwz 9,84(31)
	lis 0,0xc0a0
	lis 29,0x4330
	lis 10,.LC5@ha
	stw 0,3700(9)
	la 10,.LC5@l(10)
	mr 7,28
	lwz 9,508(31)
	addi 4,31,4
	addi 5,1,56
	lfd 13,0(10)
	mr 6,30
	addi 8,1,8
	addi 9,9,-8
	lwz 3,84(31)
	lis 10,0x40e0
	xoris 9,9,0x8000
	stw 10,60(1)
	stw 9,84(1)
	stw 29,80(1)
	lfd 0,80(1)
	stfs 31,56(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	bl P_ProjectSource
	lwz 9,84(31)
	lwz 0,4036(9)
	cmpwi 0,0,0
	bc 4,1,.L7
	mr 3,31
	mr 5,30
	addi 4,1,8
	li 6,100
	li 7,250
	bl fire_msg90
	b .L8
.L7:
	lfs 0,376(31)
	fcmpu 0,0,31
	bc 4,2,.L10
	lfs 0,380(31)
	fcmpu 0,0,31
	bc 12,2,.L9
.L10:
	lwz 0,4044(9)
	cmpwi 0,0,0
	bc 12,2,.L11
	mr 3,31
	mr 5,30
	addi 4,1,8
	li 6,100
	li 7,250
	li 8,750
	li 9,1250
	b .L18
.L11:
	mr 3,31
	mr 5,30
	addi 4,1,8
	li 6,100
	li 7,250
	li 8,600
	li 9,1000
	b .L18
.L9:
	lbz 0,16(9)
	andi. 10,0,1
	bc 12,2,.L14
	mr 3,31
	mr 5,30
	addi 4,1,8
	li 6,100
	li 7,250
	li 8,150
	li 9,250
	b .L18
.L14:
	lwz 0,4044(9)
	cmpwi 0,0,0
	bc 12,2,.L16
	mr 3,31
	mr 5,30
	addi 4,1,8
	li 6,100
	li 7,250
	li 8,450
	li 9,750
.L18:
	li 10,11
	bl fire_bullet
	b .L8
.L16:
	mr 3,31
	mr 5,30
	addi 4,1,8
	li 6,100
	li 7,250
	li 8,300
	li 9,500
	li 10,11
	bl fire_bullet
.L8:
	lwz 0,116(1)
	mtlr 0
	lmw 28,88(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe1:
	.size	 MSG90_Fire,.Lfe1-MSG90_Fire
	.section	".data"
	.align 2
	.type	 pause_frames.9,@object
pause_frames.9:
	.long 11
	.long 31
	.long 48
	.align 2
	.type	 fire_frames.10,@object
fire_frames.10:
	.long 9
	.section	".rodata"
	.align 2
.LC6:
	.string	"slat/weapons/msg90_reload1.wav"
	.align 2
.LC7:
	.string	"slat/weapons/msg90_reload2.wav"
	.align 2
.LC8:
	.string	"slat/weapons/msg90_reload3.wav"
	.align 2
.LC9:
	.string	"slat/weapons/msg90_reload4.wav"
	.align 2
.LC10:
	.long 0x3f800000
	.align 2
.LC11:
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_MSG90
	.type	 Weapon_MSG90,@function
Weapon_MSG90:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,3
	bc 4,2,.L20
	lis 29,gi@ha
	lis 3,.LC6@ha
	la 29,gi@l(29)
	la 3,.LC6@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC10@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC10@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfs 2,0(9)
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 3,0(9)
	blrl
.L20:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,52
	bc 4,2,.L21
	lis 29,gi@ha
	lis 3,.LC7@ha
	la 29,gi@l(29)
	la 3,.LC7@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC10@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC10@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfs 2,0(9)
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 3,0(9)
	blrl
.L21:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,57
	bc 4,2,.L22
	lis 29,gi@ha
	lis 3,.LC8@ha
	la 29,gi@l(29)
	la 3,.LC8@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC10@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC10@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfs 2,0(9)
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 3,0(9)
	blrl
.L22:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,62
	bc 4,2,.L23
	lis 29,gi@ha
	lis 3,.LC9@ha
	la 29,gi@l(29)
	la 3,.LC9@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC10@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC10@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfs 2,0(9)
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 3,0(9)
	blrl
.L23:
	lwz 8,84(31)
	lwz 9,3696(8)
	xori 11,9,3
	addic 0,9,-1
	subfe 10,0,9
	addic 9,11,-1
	subfe 0,9,11
	and. 9,10,0
	bc 12,2,.L24
	lwz 0,4036(8)
	cmpwi 0,0,0
	bc 12,2,.L24
	lis 0,0x42b4
	li 29,0
	stw 0,112(8)
	lis 10,gi+32@ha
	lwz 9,84(31)
	stw 29,4036(9)
	lwz 11,84(31)
	lwz 0,gi+32@l(10)
	lwz 9,1824(11)
	mtlr 0
	lwz 3,32(9)
	blrl
	lwz 9,84(31)
	stw 3,88(9)
	lwz 11,84(31)
	stw 29,4028(11)
	lwz 9,84(31)
	lwz 0,116(9)
	rlwinm 0,0,0,30,28
	stw 0,116(9)
.L24:
	lis 9,fire_frames.10@ha
	lis 11,MSG90_Fire@ha
	la 9,fire_frames.10@l(9)
	la 11,MSG90_Fire@l(11)
	lis 10,pause_frames.9@ha
	stw 9,8(1)
	mr 3,31
	stw 11,12(1)
	la 10,pause_frames.9@l(10)
	li 4,8
	li 5,13
	li 6,40
	li 7,44
	li 8,0
	li 9,0
	bl Weapon_Generic
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Weapon_MSG90,.Lfe2-Weapon_MSG90
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_UZIclip,4,4
	.comm	item_9mm,4,4
	.comm	item_1911rounds,4,4
	.comm	item_50cal,4,4
	.comm	item_MARINERrounds,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_sshotgun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	ctfgame,24,4
	.comm	enemies,4,4
	.comm	spawned,4,4
	.comm	lms_round,4,4
	.comm	terror_l,4,4
	.comm	swat_l,4,4
	.comm	lms_delay,4,4
	.comm	lms_delay2,4,4
	.comm	lms_players,4,4
	.comm	lms_dead_players,4,4
	.comm	lms_alive_players,4,4
	.comm	lms_round_over,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
