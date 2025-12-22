	.file	"g_helpers.c"
gcc2_compiled.:
	.section	".rodata"
	.align 3
.LC0:
	.long 0x40140000
	.long 0x0
	.section	".text"
	.align 2
	.globl G_ClientInGame
	.type	 G_ClientInGame,@function
G_ClientInGame:
	mr. 3,3
	li 9,0
	bc 12,2,.L26
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L26
	lwz 0,88(3)
	addic 8,0,-1
	subfe 9,8,0
.L26:
	cmpwi 0,9,0
	bc 4,2,.L25
	li 3,0
	blr
.L25:
	lwz 0,480(3)
	li 6,0
	lwz 8,84(3)
	lwz 10,492(3)
	srawi 11,0,31
	subf 11,0,11
	mr 7,8
	xori 10,10,2
	lwz 0,0(8)
	srwi 11,11,31
	addic 8,10,-1
	subfe 9,8,10
	or. 10,11,9
	xori 0,0,2
	addic 11,0,-1
	subfe 3,11,0
	bc 4,2,.L29
	cmpwi 0,3,0
	bc 12,2,.L30
.L29:
	li 6,1
.L30:
	cmpwi 0,6,0
	bc 12,2,.L28
	lfs 13,2232(7)
	lis 8,.LC0@ha
	lis 9,level+4@ha
	la 8,.LC0@l(8)
	lfs 0,level+4@l(9)
	lfd 12,0(8)
	fadd 13,13,12
	fcmpu 7,13,0
	mfcr 3
	rlwinm 3,3,29,1
	blr
.L28:
	li 3,0
	blr
.Lfe1:
	.size	 G_ClientInGame,.Lfe1-G_ClientInGame
	.align 2
	.globl G_Spawn_Models
	.type	 G_Spawn_Models,@function
G_Spawn_Models:
	stwu 1,-48(1)
	mflr 0
	stmw 23,12(1)
	stw 0,52(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	mr 28,4
	mr 26,5
	mr 25,6
	mr 24,7
	mtlr 9
	mr 23,8
	blrl
	lwz 9,100(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,104(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,25
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,24
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,23
	li 4,2
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 23,12(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 G_Spawn_Models,.Lfe2-G_Spawn_Models
	.align 2
	.globl G_Spawn_Splash
	.type	 G_Spawn_Splash,@function
G_Spawn_Splash:
	stwu 1,-48(1)
	mflr 0
	stmw 23,12(1)
	stw 0,52(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	mr 28,4
	mr 24,5
	mr 26,6
	mr 25,7
	mtlr 9
	mr 23,8
	blrl
	lwz 9,100(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,25
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,24
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,23
	li 4,2
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 23,12(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 G_Spawn_Splash,.Lfe3-G_Spawn_Splash
	.align 2
	.globl G_Spawn_Trails
	.type	 G_Spawn_Trails,@function
G_Spawn_Trails:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	mr 28,4
	mr 26,5
	mr 25,6
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,25
	li 4,2
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 G_Spawn_Trails,.Lfe4-G_Spawn_Trails
	.align 2
	.globl G_Spawn_Sparks
	.type	 G_Spawn_Sparks,@function
G_Spawn_Sparks:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	mr 28,4
	mr 26,5
	mr 25,6
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,124(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,25
	li 4,2
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 G_Spawn_Sparks,.Lfe5-G_Spawn_Sparks
	.align 2
	.globl G_Spawn_Explosion
	.type	 G_Spawn_Explosion,@function
G_Spawn_Explosion:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	mr 28,4
	mr 26,5
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,26
	li 4,1
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 G_Spawn_Explosion,.Lfe6-G_Spawn_Explosion
	.align 2
	.globl G_MuzzleFlash
	.type	 G_MuzzleFlash,@function
G_MuzzleFlash:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,1
	lwz 9,100(29)
	mr 26,4
	mr 28,5
	mtlr 9
	blrl
	lwz 9,104(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,26
	li 4,2
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 G_MuzzleFlash,.Lfe7-G_MuzzleFlash
	.align 2
	.globl G_MuzzleFlash2
	.type	 G_MuzzleFlash2,@function
G_MuzzleFlash2:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,2
	lwz 9,100(29)
	mr 26,4
	mr 28,5
	mtlr 9
	blrl
	lwz 9,104(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,26
	li 4,2
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 G_MuzzleFlash2,.Lfe8-G_MuzzleFlash2
	.align 2
	.globl Telefrag_All
	.type	 Telefrag_All,@function
Telefrag_All:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl KillBox
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 Telefrag_All,.Lfe9-Telefrag_All
	.align 2
	.globl P_ProjectSource_Reverse
	.type	 P_ProjectSource_Reverse,@function
P_ProjectSource_Reverse:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	lfs 12,4(5)
	mr 9,7
	lfs 13,8(5)
	mr 7,8
	lfs 0,0(5)
	stfs 12,12(1)
	stfs 13,16(1)
	stfs 0,8(1)
	lwz 0,716(3)
	cmpwi 0,0,0
	bc 4,2,.L36
	fneg 0,12
	stfs 0,12(1)
	b .L37
.L36:
	cmpwi 0,0,2
	bc 4,2,.L37
	li 0,0
	stw 0,12(1)
.L37:
	mr 3,4
	mr 5,6
	mr 6,9
	addi 4,1,8
	bl G_ProjectSource
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe10:
	.size	 P_ProjectSource_Reverse,.Lfe10-P_ProjectSource_Reverse
	.comm	lights,4,4
	.section	".rodata"
	.align 2
.LC1:
	.long 0x0
	.align 3
.LC2:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl G_GetFreeEdict
	.type	 G_GetFreeEdict,@function
G_GetFreeEdict:
	stwu 1,-16(1)
	lis 11,.LC1@ha
	lis 9,maxclients@ha
	la 11,.LC1@l(11)
	li 3,0
	lfs 0,0(11)
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	bc 4,0,.L43
	lis 9,g_edicts@ha
	fmr 12,13
	lis 10,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	addi 11,11,1064
	lfd 13,0(9)
.L45:
	lwz 0,0(11)
	addi 11,11,976
	cmpwi 0,0,0
	bc 12,2,.L51
	addi 3,3,1
	xoris 0,3,0x8000
	stw 0,12(1)
	stw 10,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L45
.L43:
	li 3,-1
.L51:
	la 1,16(1)
	blr
.Lfe11:
	.size	 G_GetFreeEdict,.Lfe11-G_GetFreeEdict
	.align 2
	.globl G_Distance
	.type	 G_Distance,@function
G_Distance:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	mr 9,3
	lfs 11,12(4)
	lfs 12,12(9)
	addi 3,1,8
	lfs 13,4(9)
	lfs 10,4(4)
	fsubs 12,12,11
	lfs 0,8(9)
	lfs 11,8(4)
	fsubs 13,13,10
	stfs 12,16(1)
	fsubs 0,0,11
	stfs 13,8(1)
	stfs 0,12(1)
	bl VectorLength
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe12:
	.size	 G_Distance,.Lfe12-G_Distance
	.section	".rodata"
	.align 3
.LC3:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl G_Within_Radius
	.type	 G_Within_Radius,@function
G_Within_Radius:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 29,44(1)
	stw 0,68(1)
	addi 29,1,8
	mr 30,3
	fmr 31,1
	mr 31,4
	mr 3,29
	li 4,0
	li 5,12
	crxor 6,6,6
	bl memset
	lis 7,.LC3@ha
	li 9,3
	la 7,.LC3@l(7)
	mtctr 9
	lis 8,0x4330
	lfd 11,0(7)
	li 10,0
.L52:
	lfsx 0,10,30
	lfsx 13,10,31
	mr 11,9
	fsubs 0,0,13
	fctiwz 12,0
	stfd 12,32(1)
	lwz 9,36(1)
	srawi 7,9,31
	xor 0,7,9
	subf 0,7,0
	xoris 0,0,0x8000
	stw 0,36(1)
	stw 8,32(1)
	lfd 0,32(1)
	fsub 0,0,11
	frsp 0,0
	stfsx 0,10,29
	addi 10,10,4
	bdnz .L52
	addi 3,1,8
	bl VectorLength
	fcmpu 7,1,31
	mfcr 3
	rlwinm 3,3,29,1
	lwz 0,68(1)
	mtlr 0
	lmw 29,44(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe13:
	.size	 G_Within_Radius,.Lfe13-G_Within_Radius
	.align 2
	.globl G_EntExists
	.type	 G_EntExists,@function
G_EntExists:
	mr. 3,3
	li 9,0
	bc 12,2,.L20
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L20
	lwz 0,88(3)
	addic 11,0,-1
	subfe 9,11,0
.L20:
	mr 3,9
	blr
.Lfe14:
	.size	 G_EntExists,.Lfe14-G_EntExists
	.align 2
	.globl G_ClientNotDead
	.type	 G_ClientNotDead,@function
G_ClientNotDead:
	lwz 9,480(3)
	li 7,0
	lwz 8,84(3)
	lwz 10,492(3)
	srawi 0,9,31
	lwz 11,0(8)
	subf 0,9,0
	xori 10,10,2
	srwi 0,0,31
	addic 8,10,-1
	subfe 9,8,10
	xori 11,11,2
	or. 10,0,9
	addic 8,11,-1
	subfe 0,8,11
	bc 4,2,.L23
	cmpwi 0,0,0
	bc 12,2,.L22
.L23:
	li 7,1
.L22:
	mr 3,7
	blr
.Lfe15:
	.size	 G_ClientNotDead,.Lfe15-G_ClientNotDead
	.align 2
	.globl G_Deduct_Item
	.type	 G_Deduct_Item,@function
G_Deduct_Item:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(3)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 4,9,4
	addi 11,11,744
	mullw 4,4,0
	rlwinm 4,4,0,0,29
	lwzx 0,11,4
	cmpw 0,0,5
	bc 4,0,.L34
	li 3,0
	blr
.L34:
	subf 0,5,0
	li 3,1
	stwx 0,11,4
	blr
.Lfe16:
	.size	 G_Deduct_Item,.Lfe16-G_Deduct_Item
	.align 2
	.globl G_IsMonster
	.type	 G_IsMonster,@function
G_IsMonster:
	lwz 0,184(3)
	li 9,0
	andi. 11,0,4
	bc 12,2,.L49
	lwz 0,492(3)
	cmpwi 0,0,2
	bc 12,2,.L49
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L49
	lwz 9,260(3)
	addi 9,9,-4
	subfic 9,9,2
	li 9,0
	adde 9,9,9
.L49:
	mr 3,9
	blr
.Lfe17:
	.size	 G_IsMonster,.Lfe17-G_IsMonster
	.section	".rodata"
	.align 3
.LC4:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl G_Clear_Path
	.type	 G_Clear_Path,@function
G_Clear_Path:
	stwu 1,-80(1)
	mflr 0
	stw 0,84(1)
	lis 9,gi+48@ha
	mr 7,4
	lwz 0,gi+48@l(9)
	mr 4,3
	li 5,0
	addi 3,1,8
	li 9,25
	li 6,0
	li 8,0
	mtlr 0
	blrl
	lfs 0,16(1)
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfd 13,0(9)
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,31,1
	lwz 0,84(1)
	mtlr 0
	la 1,80(1)
	blr
.Lfe18:
	.size	 G_Clear_Path,.Lfe18-G_Clear_Path
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
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
