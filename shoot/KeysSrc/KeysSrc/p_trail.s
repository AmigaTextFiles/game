	.file	"p_trail.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.globl trail_active
	.section	".sdata","aw"
	.align 2
	.type	 trail_active,@object
	.size	 trail_active,4
trail_active:
	.long 0
	.section	".rodata"
	.align 2
.LC0:
	.string	"player_trail"
	.section	".text"
	.align 2
	.globl PlayerTrail_PickFirst
	.type	 PlayerTrail_PickFirst,@function
PlayerTrail_PickFirst:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,trail_active@ha
	mr 28,3
	lwz 0,trail_active@l(9)
	cmpwi 0,0,0
	bc 4,2,.L14
	li 3,0
	b .L24
.L14:
	lis 9,trail_head@ha
	li 0,750
	lfs 13,852(28)
	lwz 31,trail_head@l(9)
	lis 11,trail@ha
	mtctr 0
	la 11,trail@l(11)
.L25:
	slwi 0,31,2
	lwzx 9,11,0
	lfs 0,288(9)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L16
	addi 0,31,1
	andi. 31,0,749
	bdnz .L25
.L16:
	lis 9,trail@ha
	slwi 30,31,2
	la 29,trail@l(9)
	mr 3,28
	lwzx 4,29,30
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L26
	addi 0,31,-1
	mr 3,28
	andi. 0,0,749
	slwi 31,0,2
	lwzx 4,29,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L23
.L26:
	lwzx 3,29,30
	b .L24
.L23:
	lwzx 3,29,31
.L24:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 PlayerTrail_PickFirst,.Lfe1-PlayerTrail_PickFirst
	.section	".rodata"
	.align 2
.LC1:
	.long 0x0
	.section	".text"
	.align 2
	.globl PlayerTrail_Init
	.type	 PlayerTrail_Init,@function
PlayerTrail_Init:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC1@ha
	lis 11,deathmatch@ha
	la 9,.LC1@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L6
	bl G_Spawn
	lis 11,trail@ha
	lis 9,.LC0@ha
	stw 3,trail@l(11)
	la 9,.LC0@l(9)
	li 8,0
	stw 9,280(3)
	lis 10,trail_head@ha
	lis 11,trail_active@ha
	li 0,1
	stw 8,trail_head@l(10)
	stw 0,trail_active@l(11)
.L6:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe2:
	.size	 PlayerTrail_Init,.Lfe2-PlayerTrail_Init
	.align 2
	.globl PlayerTrail_Add
	.type	 PlayerTrail_Add,@function
PlayerTrail_Add:
	blr
.Lfe3:
	.size	 PlayerTrail_Add,.Lfe3-PlayerTrail_Add
	.section	".rodata"
	.align 2
.LC2:
	.long 0x0
	.section	".text"
	.align 2
	.globl PlayerTrail_New
	.type	 PlayerTrail_New,@function
PlayerTrail_New:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 31,trail_active@ha
	lwz 0,trail_active@l(31)
	cmpwi 0,0,0
	bc 12,2,.L9
	lis 9,.LC2@ha
	lis 11,deathmatch@ha
	la 9,.LC2@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L9
	bl G_Spawn
	lis 11,trail@ha
	lis 9,.LC0@ha
	stw 3,trail@l(11)
	la 9,.LC0@l(9)
	li 8,0
	stw 9,280(3)
	lis 10,trail_head@ha
	li 0,1
	stw 8,trail_head@l(10)
	stw 0,trail_active@l(31)
.L9:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 PlayerTrail_New,.Lfe4-PlayerTrail_New
	.align 2
	.globl PlayerTrail_PickNext
	.type	 PlayerTrail_PickNext,@function
PlayerTrail_PickNext:
	lis 9,trail_active@ha
	lwz 0,trail_active@l(9)
	cmpwi 0,0,0
	bc 4,2,.L28
	li 3,0
	blr
.L28:
	lis 9,trail_head@ha
	li 0,750
	lfs 13,852(3)
	lwz 10,trail_head@l(9)
	lis 11,trail@ha
	mtctr 0
	la 11,trail@l(11)
.L38:
	slwi 0,10,2
	lwzx 9,11,0
	lfs 0,288(9)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L30
	addi 0,10,1
	andi. 10,0,749
	bdnz .L38
.L30:
	lis 9,trail@ha
	slwi 0,10,2
	la 9,trail@l(9)
	lwzx 3,9,0
	blr
.Lfe5:
	.size	 PlayerTrail_PickNext,.Lfe5-PlayerTrail_PickNext
	.align 2
	.globl PlayerTrail_LastSpot
	.type	 PlayerTrail_LastSpot,@function
PlayerTrail_LastSpot:
	lis 10,trail_head@ha
	lis 11,trail@ha
	lwz 9,trail_head@l(10)
	la 11,trail@l(11)
	addi 9,9,-1
	andi. 9,9,749
	slwi 9,9,2
	lwzx 3,11,9
	blr
.Lfe6:
	.size	 PlayerTrail_LastSpot,.Lfe6-PlayerTrail_LastSpot
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
	.comm	trail_head,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
