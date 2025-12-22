	.file	"k2_botutils.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.section	".rodata"
	.align 3
.LC0:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC1:
	.long 0x41200000
	.align 2
.LC2:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl K2_botCheckKeyTimer
	.type	 K2_botCheckKeyTimer,@function
K2_botCheckKeyTimer:
	stwu 1,-16(1)
	lwz 10,84(3)
	li 9,0
	lwz 0,3988(10)
	cmpwi 0,0,8
	bc 12,2,.L14
	bc 12,1,.L21
	cmpwi 0,0,2
	bc 12,2,.L12
	bc 12,1,.L22
	cmpwi 0,0,1
	bc 12,2,.L11
	b .L10
.L22:
	cmpwi 0,0,4
	bc 12,2,.L13
	b .L10
.L21:
	cmpwi 0,0,32
	bc 12,2,.L16
	bc 12,1,.L23
	cmpwi 0,0,16
	bc 12,2,.L15
	b .L10
.L23:
	cmpwi 0,0,64
	bc 12,2,.L17
	cmpwi 0,0,128
	bc 12,2,.L18
	b .L10
.L11:
	lis 9,level@ha
	lfs 11,3984(10)
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 9,.LC0@ha
	xoris 0,0,0x8000
	la 9,.LC0@l(9)
	stw 0,12(1)
	stw 8,8(1)
	lfd 10,0(9)
	lfd 0,8(1)
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	lfs 8,0(9)
	fsub 0,0,10
	lis 9,antitime@ha
	lwz 10,antitime@l(9)
	b .L26
.L12:
	lis 9,level@ha
	lfs 11,3984(10)
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 9,.LC0@ha
	xoris 0,0,0x8000
	la 9,.LC0@l(9)
	stw 0,12(1)
	stw 8,8(1)
	lfd 10,0(9)
	lfd 0,8(1)
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	lfs 8,0(9)
	fsub 0,0,10
	lis 9,regentime@ha
	lwz 10,regentime@l(9)
	b .L26
.L13:
	lis 9,level@ha
	lfs 11,3984(10)
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 9,.LC0@ha
	xoris 0,0,0x8000
	la 9,.LC0@l(9)
	stw 0,12(1)
	stw 8,8(1)
	lfd 10,0(9)
	lfd 0,8(1)
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	lfs 8,0(9)
	fsub 0,0,10
	lis 9,futilitytime@ha
	lwz 10,futilitytime@l(9)
	b .L26
.L14:
	lis 9,level@ha
	lfs 11,3984(10)
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 9,.LC0@ha
	xoris 0,0,0x8000
	la 9,.LC0@l(9)
	stw 0,12(1)
	stw 8,8(1)
	lfd 10,0(9)
	lfd 0,8(1)
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	lfs 8,0(9)
	fsub 0,0,10
	lis 9,inflictiontime@ha
	lwz 10,inflictiontime@l(9)
	b .L26
.L15:
	lis 9,level@ha
	lfs 11,3984(10)
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 9,.LC0@ha
	xoris 0,0,0x8000
	la 9,.LC0@l(9)
	stw 0,12(1)
	stw 8,8(1)
	lfd 10,0(9)
	lfd 0,8(1)
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	lfs 8,0(9)
	fsub 0,0,10
	lis 9,hastetime@ha
	lwz 10,hastetime@l(9)
	b .L26
.L16:
	lis 9,level@ha
	lfs 11,3984(10)
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 9,.LC0@ha
	xoris 0,0,0x8000
	la 9,.LC0@l(9)
	stw 0,12(1)
	stw 8,8(1)
	lfd 10,0(9)
	lfd 0,8(1)
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	lfs 8,0(9)
	fsub 0,0,10
	lis 9,stealthtime@ha
	lwz 10,stealthtime@l(9)
	b .L26
.L17:
	lis 9,level@ha
	lfs 11,3984(10)
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 9,.LC0@ha
	xoris 0,0,0x8000
	la 9,.LC0@l(9)
	stw 0,12(1)
	stw 8,8(1)
	lfd 10,0(9)
	lfd 0,8(1)
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	lfs 8,0(9)
	fsub 0,0,10
	lis 9,homingtime@ha
	lwz 10,homingtime@l(9)
	b .L26
.L18:
	lis 9,level@ha
	lfs 11,3984(10)
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 9,.LC0@ha
	xoris 0,0,0x8000
	la 9,.LC0@l(9)
	stw 0,12(1)
	stw 8,8(1)
	lfd 10,0(9)
	lfd 0,8(1)
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	lfs 8,0(9)
	fsub 0,0,10
	lis 9,bfktime@ha
	lwz 10,bfktime@l(9)
.L26:
	lis 9,.LC2@ha
	frsp 0,0
	la 9,.LC2@l(9)
	lfs 13,20(10)
	lfs 9,0(9)
	mr 9,11
	fsubs 11,11,0
	fdivs 11,11,8
	fmsubs 13,13,9,11
	fctiwz 12,13
	stfd 12,8(1)
	lwz 9,12(1)
.L10:
	srawi 3,9,31
	subf 3,9,3
	srwi 3,3,31
	la 1,16(1)
	blr
.Lfe1:
	.size	 K2_botCheckKeyTimer,.Lfe1-K2_botCheckKeyTimer
	.section	".rodata"
	.align 3
.LC3:
	.long 0x4072c000
	.long 0x0
	.align 2
.LC4:
	.long 0x3e800000
	.align 2
.LC5:
	.long 0x40800000
	.align 2
.LC6:
	.long 0x42960000
	.section	".text"
	.align 2
	.globl K2_HomingInformDanger
	.type	 K2_HomingInformDanger,@function
K2_HomingInformDanger:
	stwu 1,-96(1)
	mflr 0
	stfd 29,72(1)
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 26,48(1)
	stw 0,100(1)
	lis 9,.LC4@ha
	mr 30,3
	la 9,.LC4@l(9)
	addi 3,30,4
	lfs 1,0(9)
	addi 4,30,376
	addi 5,1,8
	li 29,0
	lis 26,num_players@ha
	bl VectorMA
	lis 9,num_players@ha
	lwz 0,num_players@l(9)
	cmpw 0,29,0
	bc 4,0,.L29
	lis 9,players@ha
	lis 11,.LC5@ha
	la 28,players@l(9)
	la 11,.LC5@l(11)
	lis 9,.LC6@ha
	lfs 29,0(11)
	lis 27,.LC3@ha
	la 9,.LC6@l(9)
	lfs 30,0(9)
.L31:
	lwz 31,0(28)
	addi 28,28,4
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L32
	lwz 9,1068(31)
	lfs 0,12(9)
	fcmpu 0,0,29
	bc 12,0,.L30
.L32:
	lfs 11,4(31)
	lfs 0,4(30)
	lfd 12,.LC3@l(27)
	fsubs 0,11,0
	fabs 0,0
	fcmpu 0,0,12
	bc 12,1,.L30
	lfs 0,8(31)
	lfs 13,8(30)
	fsubs 0,0,13
	fabs 0,0
	fcmpu 0,0,12
	bc 12,1,.L30
	lfs 13,8(1)
	mr 3,31
	mr 4,30
	lfs 12,12(1)
	fsubs 13,13,11
	lfs 11,16(1)
	stfs 13,24(1)
	lfs 0,8(31)
	fsubs 12,12,0
	stfs 12,28(1)
	lfs 0,12(31)
	fsubs 11,11,0
	stfs 11,32(1)
	bl entdist
	fmr 31,1
	addi 3,1,24
	bl VectorLength
	fsubs 31,31,1
	fcmpu 0,31,30
	bc 4,1,.L30
	stw 30,1036(31)
.L30:
	lwz 0,num_players@l(26)
	addi 29,29,1
	cmpw 0,29,0
	bc 12,0,.L31
.L29:
	lwz 0,100(1)
	mtlr 0
	lmw 26,48(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe2:
	.size	 K2_HomingInformDanger,.Lfe2-K2_HomingInformDanger
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.comm	last_trail_time,4,4
	.comm	bot_frametime,8,8
	.comm	max_bots,4,4
	.comm	last_bot_spawn,4,4
	.comm	bot_male_names_used,4,4
	.comm	bot_female_names_used,4,4
	.comm	bot_count,4,4
	.comm	bot_teams,256,4
	.comm	total_teams,4,4
	.comm	the_client,4,4
	.comm	num_players,4,4
	.comm	players,1024,4
	.comm	weapons_head,4,4
	.comm	health_head,4,4
	.comm	bonus_head,4,4
	.comm	ammo_head,4,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_supershotgun,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	botinfo_list,4,4
	.comm	total_bots,4,4
	.comm	teambot_list,4,4
	.comm	paused,4,4
	.align 2
	.globl K2_botCompareKey
	.type	 K2_botCompareKey,@function
K2_botCompareKey:
	lwz 9,84(3)
	lwz 0,3988(9)
	cmpw 7,4,0
	mfcr 3
	rlwinm 3,3,30,1
	neg 3,3
	and 3,4,3
	blr
.Lfe3:
	.size	 K2_botCompareKey,.Lfe3-K2_botCompareKey
	.section	".rodata"
	.align 2
.LC7:
	.long 0x40800000
	.section	".text"
	.align 2
	.globl K2_botBFKInformDanger
	.type	 K2_botBFKInformDanger,@function
K2_botBFKInformDanger:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 27,20(1)
	stw 0,52(1)
	mr 28,3
	bl K2_IsBFK
	cmpwi 0,3,0
	bc 12,2,.L37
	lis 9,num_players@ha
	li 30,0
	lwz 0,num_players@l(9)
	lis 27,num_players@ha
	cmpw 0,30,0
	bc 4,0,.L37
	lis 11,.LC7@ha
	lis 9,players@ha
	la 11,.LC7@l(11)
	la 29,players@l(9)
	lfs 31,0(11)
.L42:
	lwz 31,0(29)
	addi 29,29,4
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L43
	lwz 9,1068(31)
	lfs 0,12(9)
	fcmpu 0,0,31
	bc 12,0,.L41
.L43:
	mr 3,31
	bl K2_IsBFK
	cmpwi 0,3,0
	bc 4,2,.L41
	stw 28,1036(31)
.L41:
	lwz 0,num_players@l(27)
	addi 30,30,1
	cmpw 0,30,0
	bc 12,0,.L42
.L37:
	lwz 0,52(1)
	mtlr 0
	lmw 27,20(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 K2_botBFKInformDanger,.Lfe4-K2_botBFKInformDanger
	.align 2
	.globl K2_botCanSeeStealth
	.type	 K2_botCanSeeStealth,@function
K2_botCanSeeStealth:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L47
	lwz 9,84(31)
	lwz 3,3760(9)
	addi 3,3,-3
	subfic 3,3,1
	li 3,0
	adde 3,3,3
	b .L50
.L47:
	li 3,1
.L50:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 K2_botCanSeeStealth,.Lfe5-K2_botCanSeeStealth
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
