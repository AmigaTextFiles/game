	.file	"p_medic.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"items/m_health.wav"
	.align 2
.LC1:
	.string	"items/n_health.wav"
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
.LC2:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl Set_Heal_Health
	.type	 Set_Heal_Health,@function
Set_Heal_Health:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(4)
	lwz 9,532(3)
	lwz 0,728(11)
	add 0,0,9
	stw 0,728(11)
	lwz 9,284(3)
	andis. 0,9,1
	bc 4,2,.L7
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	lfs 1,0(9)
	bl SetRespawn
.L7:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe1:
	.size	 Set_Heal_Health,.Lfe1-Set_Heal_Health
	.section	".rodata"
	.align 2
.LC3:
	.long 0x3f800000
	.align 2
.LC4:
	.long 0x0
	.section	".text"
	.align 2
	.globl Player_Heal
	.type	 Player_Heal,@function
Player_Heal:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lwz 11,480(4)
	mr 30,3
	lwz 0,484(4)
	subf. 10,11,0
	bc 4,1,.L8
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L8
	lwz 9,84(30)
	lwz 31,728(9)
	cmpwi 0,31,0
	bc 4,1,.L8
	cmpw 0,31,10
	bc 12,0,.L12
	add 0,11,10
	lis 29,gi@ha
	stw 0,480(4)
	la 29,gi@l(29)
	lis 3,.LC0@ha
	lwz 9,36(29)
	la 3,.LC0@l(3)
	subf 31,10,31
	mtlr 9
	blrl
	lis 9,.LC3@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC3@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 2,0(9)
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfs 3,0(9)
	blrl
	b .L13
.L12:
	add 0,11,31
	lis 29,gi@ha
	stw 0,480(4)
	la 29,gi@l(29)
	lis 3,.LC1@ha
	lwz 9,36(29)
	la 3,.LC1@l(3)
	li 31,0
	mtlr 9
	blrl
	lis 9,.LC3@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC3@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 2,0(9)
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfs 3,0(9)
	blrl
.L13:
	lwz 9,84(30)
	stw 31,728(9)
.L8:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Player_Heal,.Lfe2-Player_Heal
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
