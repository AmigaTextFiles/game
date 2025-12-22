	.file	"trond_beretta.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"weapons/noammo.wav"
	.align 2
.LC1:
	.string	"slat/weapons/beretta_fire.wav"
	.align 2
.LC2:
	.long 0x46fffe00
	.align 2
.LC3:
	.long 0x3f800000
	.align 2
.LC4:
	.long 0x0
	.align 2
.LC5:
	.long 0xc0000000
	.align 3
.LC6:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC7:
	.long 0x3fd00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_Beretta_Fire
	.type	 Weapon_Beretta_Fire,@function
Weapon_Beretta_Fire:
	stwu 1,-128(1)
	mflr 0
	stfd 31,120(1)
	stmw 27,100(1)
	stw 0,132(1)
	mr 31,3
	lwz 10,84(31)
	lwz 9,92(10)
	addi 9,9,1
	stw 9,92(10)
	lwz 11,84(31)
	lwz 0,3640(11)
	addi 11,11,740
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,1,.L7
	lis 29,gi@ha
	lis 3,.LC0@ha
	la 29,gi@l(29)
	la 3,.LC0@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC3@ha
	lis 9,.LC3@ha
	lis 11,.LC4@ha
	la 8,.LC3@l(8)
	la 9,.LC3@l(9)
	mr 5,3
	lfs 1,0(8)
	mtlr 0
	la 11,.LC4@l(11)
	lfs 2,0(9)
	li 4,2
	mr 3,31
	lfs 3,0(11)
	blrl
	lis 8,.LC3@ha
	lis 9,level+4@ha
	la 8,.LC3@l(8)
	lfs 0,level+4@l(9)
	lfs 13,0(8)
	fadds 0,0,13
	stfs 0,464(31)
.L7:
	lis 29,gi@ha
	lis 3,.LC1@ha
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	lwz 11,36(29)
	lis 9,.LC4@ha
	addi 30,1,24
	la 9,.LC4@l(9)
	addi 27,1,40
	mtlr 11
	lfs 31,0(9)
	addi 28,31,4
	blrl
	lis 8,.LC3@ha
	lwz 11,16(29)
	lis 9,.LC4@ha
	la 8,.LC3@l(8)
	mr 5,3
	lfs 2,0(8)
	la 9,.LC4@l(9)
	mtlr 11
	li 4,1
	lis 8,.LC3@ha
	lfs 3,0(9)
	mr 3,31
	la 8,.LC3@l(8)
	lfs 1,0(8)
	blrl
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0x4f72
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,49717
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,5
	blrl
	lwz 9,100(29)
	li 3,128
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	mr 3,31
	mr 4,28
	li 5,1
	bl PlayerNoise
	lwz 11,84(31)
	mr 5,27
	li 6,0
	mr 4,30
	lwz 0,3640(11)
	addi 11,11,740
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
	lwz 3,84(31)
	addi 3,3,3764
	bl AngleVectors
	lis 8,.LC5@ha
	lwz 4,84(31)
	mr 3,30
	la 8,.LC5@l(8)
	lfs 1,0(8)
	addi 4,4,3712
	bl VectorScale
	lwz 9,84(31)
	lis 0,0xc040
	lis 10,0x4330
	lis 8,.LC6@ha
	stw 0,3700(9)
	la 8,.LC6@l(8)
	mr 4,28
	lwz 9,508(31)
	mr 7,27
	addi 5,1,56
	lfd 13,0(8)
	mr 6,30
	addi 9,9,-8
	lwz 3,84(31)
	addi 8,1,8
	xoris 9,9,0x8000
	stfs 31,56(1)
	stw 9,92(1)
	stw 10,88(1)
	lfd 0,88(1)
	stfs 31,60(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	bl P_ProjectSource
	lfs 0,376(31)
	fcmpu 0,0,31
	bc 4,2,.L9
	lfs 0,380(31)
	fcmpu 0,0,31
	bc 12,2,.L8
.L9:
	lwz 9,84(31)
	lwz 0,4044(9)
	cmpwi 0,0,0
	bc 12,2,.L10
	mr 5,30
	mr 3,31
	addi 4,1,8
	li 6,40
	li 7,175
	li 8,600
	li 9,1000
	b .L19
.L10:
	mr 5,30
	mr 3,31
	addi 4,1,8
	li 6,40
	li 7,175
	li 8,450
	li 9,750
	b .L19
.L8:
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 8,0,1
	bc 12,2,.L13
	mr 5,30
	mr 3,31
	addi 4,1,8
	li 6,40
	li 7,175
	li 8,80
	li 9,80
	b .L19
.L13:
	lwz 0,4044(9)
	cmpwi 0,0,0
	bc 12,2,.L15
	mr 5,30
	mr 3,31
	addi 4,1,8
	li 6,40
	li 7,175
	li 8,300
	li 9,500
.L19:
	li 10,35
	bl fire_bullet
	b .L12
.L15:
	mr 5,30
	mr 3,31
	addi 4,1,8
	li 6,40
	li 7,175
	li 8,150
	li 9,250
	li 10,35
	bl fire_bullet
.L12:
	lwz 11,84(31)
	li 0,4
	stw 0,3824(11)
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 8,0,1
	bc 12,2,.L17
	bl rand
	rlwinm 3,3,0,17,31
	lwz 8,84(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,92(1)
	lis 9,.LC6@ha
	lis 10,.LC2@ha
	stw 0,88(1)
	la 9,.LC6@l(9)
	lfd 13,0(9)
	li 0,168
	lfd 0,88(1)
	lis 9,.LC7@ha
	lfs 11,.LC2@l(10)
	la 9,.LC7@l(9)
	lfd 10,0(9)
	fsub 0,0,13
	mr 9,11
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fadd 13,13,10
	fctiwz 12,13
	stfd 12,88(1)
	lwz 9,92(1)
	subfic 9,9,160
	b .L20
.L17:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 8,84(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,92(1)
	lis 9,.LC6@ha
	lis 10,.LC2@ha
	stw 0,88(1)
	la 9,.LC6@l(9)
	lfd 13,0(9)
	li 0,53
	lfd 0,88(1)
	lis 9,.LC7@ha
	lfs 11,.LC2@l(10)
	la 9,.LC7@l(9)
	lfd 10,0(9)
	fsub 0,0,13
	mr 9,11
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fadd 13,13,10
	fctiwz 12,13
	stfd 12,88(1)
	lwz 9,92(1)
	subfic 9,9,46
.L20:
	stw 9,56(31)
	stw 0,3820(8)
	lwz 0,132(1)
	mtlr 0
	lmw 27,100(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe1:
	.size	 Weapon_Beretta_Fire,.Lfe1-Weapon_Beretta_Fire
	.section	".data"
	.align 2
	.type	 pause_frames.9,@object
pause_frames.9:
	.long 12
	.long 30
	.long 38
	.align 2
	.type	 fire_frames.10,@object
fire_frames.10:
	.long 10
	.section	".rodata"
	.align 2
.LC8:
	.string	"slat/weapons/beretta_reload2.wav"
	.align 2
.LC9:
	.string	"slat/weapons/beretta_reload1.wav"
	.align 2
.LC10:
	.string	"slat/weapons/beretta_reload3.wav"
	.align 2
.LC11:
	.long 0x3f800000
	.align 2
.LC12:
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_Beretta
	.type	 Weapon_Beretta,@function
Weapon_Beretta:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,2
	bc 4,2,.L22
	lis 29,gi@ha
	lis 3,.LC8@ha
	la 29,gi@l(29)
	la 3,.LC8@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC11@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC11@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 2,0(9)
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	lfs 3,0(9)
	blrl
.L22:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,45
	bc 4,2,.L23
	lis 29,gi@ha
	lis 3,.LC9@ha
	la 29,gi@l(29)
	la 3,.LC9@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC11@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC11@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 2,0(9)
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	lfs 3,0(9)
	blrl
.L23:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,58
	bc 4,2,.L24
	lis 29,gi@ha
	lis 3,.LC10@ha
	la 29,gi@l(29)
	la 3,.LC10@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC11@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC11@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 2,0(9)
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	lfs 3,0(9)
	blrl
.L24:
	lis 9,fire_frames.10@ha
	lis 11,Weapon_Beretta_Fire@ha
	la 9,fire_frames.10@l(9)
	la 11,Weapon_Beretta_Fire@l(11)
	lis 10,pause_frames.9@ha
	stw 9,8(1)
	mr 3,31
	stw 11,12(1)
	la 10,pause_frames.9@l(10)
	li 4,9
	li 5,11
	li 6,38
	li 7,40
	li 8,40
	li 9,60
	bl Weapon_Generic
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Weapon_Beretta,.Lfe2-Weapon_Beretta
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
