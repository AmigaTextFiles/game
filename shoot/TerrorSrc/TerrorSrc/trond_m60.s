	.file	"trond_m60.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"weapons/noammo.wav"
	.align 2
.LC1:
	.string	"slat/weapons/m60_fire.wav"
	.align 2
.LC2:
	.long 0x46fffe00
	.align 3
.LC3:
	.long 0x400acccc
	.long 0xcccccccd
	.align 2
.LC4:
	.long 0x3f800000
	.align 2
.LC5:
	.long 0x0
	.align 3
.LC6:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC7:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC8:
	.long 0x40040000
	.long 0x0
	.align 3
.LC9:
	.long 0x3fd00000
	.long 0x0
	.section	".text"
	.align 2
	.globl M60_Fire
	.type	 M60_Fire,@function
M60_Fire:
	stwu 1,-192(1)
	mflr 0
	stfd 27,152(1)
	stfd 28,160(1)
	stfd 29,168(1)
	stfd 30,176(1)
	stfd 31,184(1)
	stmw 21,108(1)
	stw 0,196(1)
	mr 31,3
	lwz 11,84(31)
	lwz 0,3644(11)
	andi. 8,0,1
	bc 4,2,.L7
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L6
.L7:
	lwz 0,92(11)
	cmpwi 0,0,10
	li 0,10
	bc 4,2,.L8
	li 0,9
.L8:
	stw 0,92(11)
	lwz 9,84(31)
	lwz 0,3640(9)
	addi 9,9,740
	slwi 0,0,2
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 12,1,.L10
	lis 9,level@ha
	lfs 13,464(31)
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L6
	lis 29,gi@ha
	lis 3,.LC0@ha
	la 29,gi@l(29)
	la 3,.LC0@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC4@ha
	lis 9,.LC4@ha
	lis 11,.LC5@ha
	la 8,.LC4@l(8)
	mr 5,3
	la 9,.LC4@l(9)
	lfs 1,0(8)
	mtlr 0
	la 11,.LC5@l(11)
	li 4,2
	lfs 2,0(9)
	mr 3,31
	lfs 3,0(11)
	blrl
	lis 8,.LC4@ha
	lfs 0,4(30)
	la 8,.LC4@l(8)
	lfs 13,0(8)
	fadds 0,0,13
	stfs 0,464(31)
	b .L6
.L10:
	lis 29,gi@ha
	lis 3,.LC1@ha
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	lwz 11,36(29)
	lis 9,.LC6@ha
	addi 23,1,56
	la 9,.LC6@l(9)
	addi 27,1,24
	mtlr 11
	addi 24,1,40
	addi 22,1,72
	lfd 30,0(9)
	addi 28,31,4
	lis 25,0x4330
	mr 21,28
	li 30,4
	li 26,2
	blrl
	lis 8,.LC7@ha
	lis 9,.LC8@ha
	lis 11,.LC4@ha
	la 8,.LC7@l(8)
	la 9,.LC8@l(9)
	la 11,.LC4@l(11)
	lfd 31,0(8)
	lfs 1,0(11)
	lis 8,.LC4@ha
	mr 5,3
	lfd 27,0(9)
	la 8,.LC4@l(8)
	li 4,1
	lwz 11,16(29)
	lis 9,.LC5@ha
	mr 3,31
	la 9,.LC5@l(9)
	lfs 2,0(8)
	mtlr 11
	lfs 3,0(9)
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
	lis 9,.LC2@ha
	lis 10,.LC3@ha
	lfs 29,.LC2@l(9)
	lwz 0,3640(11)
	addi 11,11,740
	lfd 28,.LC3@l(10)
	slwi 0,0,2
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
.L15:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 11,84(31)
	xoris 3,3,0x8000
	stw 3,100(1)
	addi 11,11,3712
	stw 25,96(1)
	lfd 13,96(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmul 0,0,28
	frsp 0,0
	stfsx 0,11,30
	bl rand
	rlwinm 3,3,0,17,31
	lwz 11,84(31)
	xoris 3,3,0x8000
	addic. 26,26,-1
	stw 3,100(1)
	addi 11,11,3700
	stw 25,96(1)
	lfd 13,96(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmul 0,0,27
	frsp 0,0
	stfsx 0,11,30
	addi 30,30,4
	bc 4,2,.L15
	lwz 9,84(31)
	lis 8,.LC5@ha
	mr 3,23
	la 8,.LC5@l(8)
	mr 4,27
	lfs 0,3700(9)
	mr 5,24
	li 6,0
	lfs 13,3764(9)
	lfs 31,0(8)
	fadds 13,13,0
	stfs 13,56(1)
	lfs 13,3704(9)
	lfs 0,3768(9)
	fadds 0,0,13
	stfs 0,60(1)
	lfs 13,3708(9)
	lfs 0,3772(9)
	fadds 0,0,13
	stfs 0,64(1)
	bl AngleVectors
	lwz 9,508(31)
	lis 10,0x4330
	lis 8,.LC6@ha
	lwz 3,84(31)
	lis 0,0x4100
	addi 9,9,-8
	la 8,.LC6@l(8)
	stw 0,76(1)
	xoris 9,9,0x8000
	lfd 13,0(8)
	mr 4,21
	stw 9,100(1)
	mr 5,22
	mr 7,24
	stw 10,96(1)
	mr 6,27
	addi 8,1,8
	lfd 0,96(1)
	stfs 31,72(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,80(1)
	bl P_ProjectSource
	lfs 0,376(31)
	fcmpu 0,0,31
	bc 4,2,.L18
	lfs 0,380(31)
	fcmpu 0,0,31
	bc 12,2,.L17
.L18:
	lwz 9,84(31)
	lwz 0,4044(9)
	cmpwi 0,0,0
	bc 12,2,.L19
	mr 5,27
	mr 3,31
	addi 4,1,8
	li 6,100
	li 7,250
	li 8,1200
	li 9,2000
	b .L29
.L19:
	mr 5,27
	mr 3,31
	addi 4,1,8
	li 6,100
	li 7,250
	li 8,900
	li 9,1500
	b .L29
.L17:
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 8,0,1
	bc 12,2,.L22
	mr 5,27
	mr 3,31
	addi 4,1,8
	li 6,100
	li 7,250
	li 8,480
	li 9,800
	b .L29
.L22:
	lwz 0,4044(9)
	cmpwi 0,0,0
	bc 12,2,.L24
	mr 5,27
	mr 3,31
	addi 4,1,8
	li 6,100
	li 7,250
	li 8,750
	li 9,1250
.L29:
	li 10,4
	bl fire_bullet
	b .L21
.L24:
	mr 5,27
	mr 3,31
	addi 4,1,8
	li 6,100
	li 7,250
	li 8,660
	li 9,1100
	li 10,4
	bl fire_bullet
.L21:
	lwz 11,84(31)
	li 0,4
	stw 0,3824(11)
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 8,0,1
	bc 12,2,.L26
	bl rand
	rlwinm 3,3,0,17,31
	lwz 8,84(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,100(1)
	lis 9,.LC6@ha
	lis 10,.LC2@ha
	stw 0,96(1)
	la 9,.LC6@l(9)
	lfd 13,0(9)
	li 0,168
	lfd 0,96(1)
	lis 9,.LC9@ha
	lfs 11,.LC2@l(10)
	la 9,.LC9@l(9)
	lfd 10,0(9)
	fsub 0,0,13
	mr 9,11
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fadd 13,13,10
	fctiwz 12,13
	stfd 12,96(1)
	lwz 9,100(1)
	subfic 9,9,160
	b .L30
.L26:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 8,84(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,100(1)
	lis 9,.LC6@ha
	lis 10,.LC2@ha
	stw 0,96(1)
	la 9,.LC6@l(9)
	lfd 13,0(9)
	li 0,53
	lfd 0,96(1)
	lis 9,.LC9@ha
	lfs 11,.LC2@l(10)
	la 9,.LC9@l(9)
	lfd 10,0(9)
	fsub 0,0,13
	mr 9,11
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fadd 13,13,10
	fctiwz 12,13
	stfd 12,96(1)
	lwz 9,100(1)
	subfic 9,9,46
.L30:
	stw 9,56(31)
	stw 0,3820(8)
.L6:
	lwz 0,196(1)
	mtlr 0
	lmw 21,108(1)
	lfd 27,152(1)
	lfd 28,160(1)
	lfd 29,168(1)
	lfd 30,176(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe1:
	.size	 M60_Fire,.Lfe1-M60_Fire
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
	.long 10
	.section	".rodata"
	.align 2
.LC10:
	.string	"slat/weapons/m60_reload1.wav"
	.align 2
.LC11:
	.string	"slat/weapons/m60_reload2.wav"
	.align 2
.LC12:
	.string	"slat/weapons/m60_reload3.wav"
	.align 2
.LC13:
	.string	"slat/weapons/m60_reload4.wav"
	.align 2
.LC14:
	.string	"slat/weapons/m60_reload5.wav"
	.align 2
.LC15:
	.string	"slat/weapons/m60_reload6.wav"
	.align 2
.LC16:
	.long 0x3f800000
	.align 2
.LC17:
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_M60
	.type	 Weapon_M60,@function
Weapon_M60:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,45
	bc 4,2,.L32
	lis 29,gi@ha
	lis 3,.LC10@ha
	la 29,gi@l(29)
	la 3,.LC10@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC16@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC16@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 2,0(9)
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 3,0(9)
	blrl
.L32:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,55
	bc 4,2,.L33
	lis 29,gi@ha
	lis 3,.LC11@ha
	la 29,gi@l(29)
	la 3,.LC11@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC16@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC16@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 2,0(9)
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 3,0(9)
	blrl
.L33:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,61
	bc 4,2,.L34
	lis 29,gi@ha
	lis 3,.LC12@ha
	la 29,gi@l(29)
	la 3,.LC12@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC16@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC16@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 2,0(9)
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 3,0(9)
	blrl
.L34:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,68
	bc 4,2,.L35
	lis 29,gi@ha
	lis 3,.LC13@ha
	la 29,gi@l(29)
	la 3,.LC13@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC16@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC16@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 2,0(9)
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 3,0(9)
	blrl
.L35:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,73
	bc 4,2,.L36
	lis 29,gi@ha
	lis 3,.LC14@ha
	la 29,gi@l(29)
	la 3,.LC14@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC16@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC16@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 2,0(9)
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 3,0(9)
	blrl
.L36:
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,79
	bc 4,2,.L37
	lis 29,gi@ha
	lis 3,.LC15@ha
	la 29,gi@l(29)
	la 3,.LC15@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC16@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC16@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 2,0(9)
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 3,0(9)
	blrl
.L37:
	lis 9,fire_frames.10@ha
	lis 11,M60_Fire@ha
	la 9,fire_frames.10@l(9)
	la 11,M60_Fire@l(11)
	lis 10,pause_frames.9@ha
	stw 9,8(1)
	mr 3,31
	stw 11,12(1)
	la 10,pause_frames.9@l(10)
	li 4,8
	li 5,13
	li 6,32
	li 7,41
	li 8,0
	li 9,0
	bl Weapon_Generic
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Weapon_M60,.Lfe2-Weapon_M60
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
