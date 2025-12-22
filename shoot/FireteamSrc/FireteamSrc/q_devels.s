	.file	"q_devels.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"player"
	.align 2
.LC1:
	.string	"ERROR: tried to select a random player when none are available.\n"
	.align 2
.LC2:
	.long 0x3f800000
	.align 3
.LC3:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl random_player
	.type	 random_player,@function
random_player:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 11,.LC2@ha
	lis 9,maxclients@ha
	la 11,.LC2@l(11)
	mr 30,3
	lfs 0,0(11)
	li 31,0
	li 10,1
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L21
	lis 9,g_edicts@ha
	fmr 12,13
	lis 8,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	addi 11,11,976
	lfd 13,0(9)
.L23:
	mr. 9,11
	bc 12,2,.L22
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L22
	xor 9,9,30
	addic 9,9,-1
	subfe 9,9,9
	addi 0,31,1
	andc 0,0,9
	and 9,31,9
	or 31,9,0
.L22:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,976
	stw 0,20(1)
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L23
.L21:
	cmpwi 0,31,0
	bc 4,2,.L27
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L37
.L27:
	bl rand
	divw 0,3,31
	lis 9,maxclients@ha
	li 10,1
	lwz 11,maxclients@l(9)
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	lfs 13,20(11)
	lfs 0,0(9)
	fcmpu 0,0,13
	mullw 0,0,31
	li 31,0
	subf 8,0,3
	cror 3,2,0
	bc 4,3,.L29
	lis 9,g_edicts@ha
	fmr 12,13
	lis 7,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	addi 3,11,976
	lfd 13,0(9)
.L31:
	cmpwi 0,3,0
	bc 12,2,.L30
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L30
	cmpw 0,3,30
	bc 12,2,.L30
	cmpw 0,31,8
	bc 12,2,.L37
	addi 31,31,1
.L30:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 3,3,976
	stw 0,20(1)
	stw 7,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L31
.L29:
	li 3,0
.L37:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 random_player,.Lfe1-random_player
	.comm	lights,4,4
	.comm	saved_client,780,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_blaster,4,4
	.comm	item_shotgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_supershotgun,4,4
	.comm	item_chaingun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_railgun,4,4
	.comm	item_bfg,4,4
	.comm	item_jacketarmor,4,4
	.comm	item_combatarmor,4,4
	.comm	item_bodyarmor,4,4
	.comm	item_armorshard,4,4
	.comm	item_powerscreen,4,4
	.comm	item_powershield,4,4
	.comm	item_adrenaline,4,4
	.comm	item_health,4,4
	.comm	item_stimpak,4,4
	.comm	item_health_large,4,4
	.comm	item_health_mega,4,4
	.comm	item_quad,4,4
	.comm	item_invulnerability,4,4
	.comm	item_silencer,4,4
	.comm	item_breather,4,4
	.comm	item_enviro,4,4
	.comm	item_pack,4,4
	.comm	item_bandolier,4,4
	.comm	item_ancient_head,4,4
	.comm	key_data_cd,4,4
	.comm	key_power_cube,4,4
	.comm	key_pyramid,4,4
	.comm	key_data_spinner,4,4
	.comm	key_pass,4,4
	.comm	key_blue_key,4,4
	.comm	key_red_key,4,4
	.comm	key_commander_head,4,4
	.comm	key_airstrike_target,4,4
	.align 2
	.globl ent_by_name
	.type	 ent_by_name,@function
ent_by_name:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,globals@ha
	mr 29,3
	la 27,globals@l(9)
	li 31,0
	li 30,0
	lis 28,.LC0@ha
.L7:
	lwz 0,72(27)
	li 3,0
	cmpw 0,30,0
	bc 12,1,.L39
	mr 3,31
	li 4,280
	la 5,.LC0@l(28)
	bl G_Find
	mr 31,3
	mr 4,29
	lwz 3,84(31)
	addi 3,3,700
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L9
	addi 30,30,1
	b .L7
.L9:
	mr 3,31
.L39:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 ent_by_name,.Lfe2-ent_by_name
	.section	".rodata"
	.align 2
.LC4:
	.long 0x3f800000
	.align 3
.LC5:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl centerprint_all
	.type	 centerprint_all,@function
centerprint_all:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 25,28(1)
	stw 0,68(1)
	lis 11,.LC4@ha
	lis 9,maxclients@ha
	la 11,.LC4@l(11)
	mr 29,3
	lfs 13,0(11)
	li 30,1
	lis 25,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L14
	lis 9,gi@ha
	lis 26,g_edicts@ha
	la 27,gi@l(9)
	lis 28,0x4330
	lis 9,.LC5@ha
	li 31,976
	la 9,.LC5@l(9)
	lfd 31,0(9)
.L16:
	lwz 0,g_edicts@l(26)
	add. 3,0,31
	bc 12,2,.L15
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L15
	lwz 9,12(27)
	mr 4,29
	mtlr 9
	crxor 6,6,6
	blrl
.L15:
	addi 30,30,1
	lwz 11,maxclients@l(25)
	xoris 0,30,0x8000
	addi 31,31,976
	stw 0,20(1)
	stw 28,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L16
.L14:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 centerprint_all,.Lfe3-centerprint_all
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
