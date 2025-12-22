	.file	"p_trail.c"
gcc2_compiled.:
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
	.globl PlayerTrail_Add
	.type	 PlayerTrail_Add,@function
PlayerTrail_Add:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	lis 9,trail_active@ha
	mr 7,3
	lwz 0,trail_active@l(9)
	cmpwi 0,0,0
	bc 12,2,.L13
	lis 28,trail_head@ha
	lis 29,trail@ha
	lfs 0,0(7)
	lwz 10,trail_head@l(28)
	la 29,trail@l(29)
	lis 8,level+4@ha
	addi 3,1,8
	slwi 0,10,2
	lwzx 9,29,0
	addi 10,10,-1
	rlwinm 10,10,2,27,29
	stfs 0,4(9)
	lfs 0,4(7)
	lwzx 11,29,0
	stfs 0,8(11)
	lfs 0,8(7)
	lwzx 9,29,0
	stfs 0,12(9)
	lfs 0,level+4@l(8)
	lwzx 11,29,0
	stfs 0,288(11)
	lwzx 9,29,10
	lfs 13,0(7)
	lfs 0,4(9)
	lfs 12,4(7)
	lfs 11,8(7)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,16(1)
	bl vectoyaw
	lwz 9,trail_head@l(28)
	slwi 0,9,2
	lwzx 11,29,0
	addi 9,9,1
	rlwinm 9,9,0,29,31
	stfs 1,20(11)
	stw 9,trail_head@l(28)
.L13:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 PlayerTrail_Add,.Lfe1-PlayerTrail_Add
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
	bc 4,2,.L25
	li 3,0
	b .L35
.L25:
	lis 9,trail_head@ha
	li 0,8
	lfs 13,852(28)
	lwz 31,trail_head@l(9)
	lis 11,trail@ha
	mtctr 0
	la 11,trail@l(11)
.L36:
	slwi 0,31,2
	lwzx 9,11,0
	lfs 0,288(9)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L27
	addi 0,31,1
	rlwinm 31,0,0,29,31
	bdnz .L36
.L27:
	lis 9,trail@ha
	slwi 30,31,2
	la 29,trail@l(9)
	mr 3,28
	lwzx 4,29,30
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L37
	addi 0,31,-1
	mr 3,28
	rlwinm 31,0,2,27,29
	lwzx 4,29,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L34
.L37:
	lwzx 3,29,30
	b .L35
.L34:
	lwzx 3,29,31
.L35:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 PlayerTrail_PickFirst,.Lfe2-PlayerTrail_PickFirst
	.section	".rodata"
	.align 2
.LC1:
	.long 0x0
	.section	".text"
	.align 2
	.globl PlayerTrail_Init
	.type	 PlayerTrail_Init,@function
PlayerTrail_Init:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,.LC1@ha
	lis 11,deathmatch@ha
	la 9,.LC1@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L6
	lis 9,trail@ha
	lis 11,.LC0@ha
	la 31,trail@l(9)
	la 29,.LC0@l(11)
	addi 30,31,28
.L11:
	bl G_Spawn
	stw 3,0(31)
	addi 31,31,4
	stw 29,280(3)
	cmpw 0,31,30
	bc 4,1,.L11
	li 10,0
	lis 9,trail_head@ha
	lis 11,trail_active@ha
	li 0,1
	stw 10,trail_head@l(9)
	stw 0,trail_active@l(11)
.L6:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 PlayerTrail_Init,.Lfe3-PlayerTrail_Init
	.section	".rodata"
	.align 2
.LC2:
	.long 0x0
	.section	".text"
	.align 2
	.globl PlayerTrail_New
	.type	 PlayerTrail_New,@function
PlayerTrail_New:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,trail_active@ha
	mr 28,3
	lwz 0,trail_active@l(9)
	cmpwi 0,0,0
	bc 12,2,.L15
	lis 9,.LC2@ha
	lis 11,deathmatch@ha
	la 9,.LC2@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L18
	lis 9,trail@ha
	lis 11,.LC0@ha
	la 31,trail@l(9)
	la 29,.LC0@l(11)
	addi 30,31,28
.L21:
	bl G_Spawn
	stw 3,0(31)
	addi 31,31,4
	stw 29,280(3)
	cmpw 0,31,30
	bc 4,1,.L21
	li 10,0
	lis 9,trail_head@ha
	lis 11,trail_active@ha
	li 0,1
	stw 10,trail_head@l(9)
	stw 0,trail_active@l(11)
.L18:
	mr 3,28
	bl PlayerTrail_Add
.L15:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
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
	bc 4,2,.L39
	li 3,0
	blr
.L39:
	lis 9,trail_head@ha
	li 0,8
	lfs 13,852(3)
	lwz 10,trail_head@l(9)
	lis 11,trail@ha
	mtctr 0
	la 11,trail@l(11)
.L49:
	slwi 0,10,2
	lwzx 9,11,0
	lfs 0,288(9)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L41
	addi 0,10,1
	rlwinm 10,0,0,29,31
	bdnz .L49
.L41:
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
	rlwinm 9,9,2,27,29
	lwzx 3,11,9
	blr
.Lfe6:
	.size	 PlayerTrail_LastSpot,.Lfe6-PlayerTrail_LastSpot
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
	.comm	trail,32,4
	.comm	trail_head,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
