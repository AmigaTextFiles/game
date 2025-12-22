	.file	"m_boss3.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC1:
	.string	"models/monsters/boss3/rider/tris.md2"
	.align 2
.LC2:
	.string	"misc/bigtele.wav"
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
	.section	".text"
	.align 2
	.globl Use_Boss3
	.type	 Use_Boss3,@function
Use_Boss3:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	addi 4,29,4
	li 3,22
	mr 5,4
	bl G_Spawn_Explosion
	mr 3,29
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Use_Boss3,.Lfe1-Use_Boss3
	.section	".rodata"
	.align 3
.LC4:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl Think_Boss3Stand
	.type	 Think_Boss3Stand,@function
Think_Boss3Stand:
	lwz 9,56(3)
	cmpwi 0,9,473
	li 0,414
	bc 12,2,.L12
	addi 0,9,1
.L12:
	stw 0,56(3)
	lis 9,level+4@ha
	lis 11,.LC4@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC4@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe2:
	.size	 Think_Boss3Stand,.Lfe2-Think_Boss3Stand
	.section	".rodata"
	.align 3
.LC5:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_monster_boss3_stand
	.type	 SP_monster_boss3_stand,@function
SP_monster_boss3_stand:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	bl G_IsDeathmatch
	cmpwi 0,3,0
	bc 4,2,.L10
	lis 9,.LC1@ha
	li 11,2
	la 9,.LC1@l(9)
	li 0,5
	stw 11,248(31)
	lis 29,gi@ha
	stw 0,260(31)
	mr 3,9
	la 29,gi@l(29)
	stw 9,268(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	li 0,414
	stw 3,40(31)
	stw 0,56(31)
	lis 3,.LC2@ha
	lwz 9,36(29)
	la 3,.LC2@l(3)
	mtlr 9
	blrl
	lis 9,Use_Boss3@ha
	lis 11,Think_Boss3Stand@ha
	la 9,Use_Boss3@l(9)
	lis 7,0xc200
	stw 9,448(31)
	lis 6,0x4200
	li 0,0
	la 11,Think_Boss3Stand@l(11)
	lis 9,0x42b4
	stw 7,192(31)
	stw 0,196(31)
	lis 10,level+4@ha
	lis 8,.LC5@ha
	stw 6,204(31)
	mr 3,31
	stw 9,208(31)
	stw 11,436(31)
	stw 7,188(31)
	stw 6,200(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC5@l(8)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,72(29)
	mtlr 0
	blrl
.L10:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 SP_monster_boss3_stand,.Lfe3-SP_monster_boss3_stand
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
