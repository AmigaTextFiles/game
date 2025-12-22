	.file	"k2_feign.c"
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
	.align 2
.LC0:
	.string	"*jump1.wav"
	.align 2
.LC1:
	.long 0x3f800000
	.align 2
.LC2:
	.long 0x0
	.section	".text"
	.align 2
	.globl Client_EndFeign
	.type	 Client_EndFeign,@function
Client_EndFeign:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,pickuptime@ha
	lis 11,level+4@ha
	lwz 10,pickuptime@l(9)
	mr 31,3
	lfs 0,level+4@l(11)
	lfs 13,20(10)
	lwz 9,84(31)
	fadds 0,0,13
	stfs 0,4072(9)
	lwz 0,492(31)
	andi. 30,0,2
	bc 4,2,.L6
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L6
	lwz 9,84(31)
	li 10,22
	li 0,4
	lis 8,0x42b4
	lis 28,gi@ha
	stw 30,3760(9)
	la 28,gi@l(28)
	lwz 9,84(31)
	stw 30,0(9)
	lwz 11,84(31)
	stw 30,4012(11)
	lwz 9,264(31)
	lwz 29,84(31)
	rlwinm 9,9,0,21,19
	stw 10,508(31)
	stw 0,260(31)
	stw 9,264(31)
	lbz 0,16(29)
	lwz 9,1788(29)
	rlwinm 0,0,0,24,30
	stw 8,112(29)
	stb 0,16(29)
	lwz 3,32(9)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,88(29)
	li 0,255
	lwz 9,84(31)
	lis 3,.LC0@ha
	stw 0,44(31)
	la 3,.LC0@l(3)
	stw 30,64(31)
	stw 30,56(31)
	stw 30,3756(9)
	lfs 0,16(31)
	stfs 0,28(29)
	lfs 13,20(31)
	stfs 13,32(29)
	lfs 0,24(31)
	stfs 0,36(29)
	lfs 13,16(31)
	stfs 13,3700(29)
	lfs 0,20(31)
	stfs 0,3704(29)
	lfs 13,24(31)
	stfs 13,3708(29)
	lwz 9,36(28)
	mtlr 9
	blrl
	lis 9,.LC1@ha
	lwz 11,16(28)
	mr 5,3
	la 9,.LC1@l(9)
	mr 3,31
	lfs 1,0(9)
	mtlr 11
	li 4,4
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	lfs 2,0(9)
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,72(28)
	mr 3,31
	mtlr 0
	blrl
.L6:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Client_EndFeign,.Lfe1-Client_EndFeign
	.section	".sbss","aw",@nobits
	.align 2
i.9:
	.space	4
	.size	 i.9,4
	.section	".rodata"
	.align 2
.LC3:
	.string	"Blaster"
	.align 2
.LC4:
	.string	"*death%i.wav"
	.align 2
.LC5:
	.long 0x3f800000
	.align 2
.LC6:
	.long 0x0
	.section	".text"
	.align 2
	.globl Client_BeginFeign
	.type	 Client_BeginFeign,@function
Client_BeginFeign:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,492(31)
	andi. 29,0,2
	bc 4,2,.L9
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L9
	lwz 9,84(31)
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 12,2,.L12
	bl K2_RemoveKeyFromInventory
	lwz 9,84(31)
	mr 3,31
	li 5,2
	lwz 4,3988(9)
	bl K2_SpawnKey
	mr 3,31
	li 4,32
	bl SelectPrevItem
.L12:
	lwz 9,84(31)
	lwz 3,3996(9)
	cmpwi 0,3,0
	bc 12,2,.L13
	bl Release_Grapple
.L13:
	li 9,0
	lwz 8,84(31)
	li 0,7
	stw 9,24(31)
	lis 10,0xc100
	li 7,2
	stw 9,396(31)
	lis 30,.LC3@ha
	stw 9,392(31)
	la 4,.LC3@l(30)
	stw 9,388(31)
	stw 9,16(31)
	stw 0,260(31)
	stw 29,44(31)
	stw 29,76(31)
	stw 29,3800(8)
	lwz 11,84(31)
	stw 10,208(31)
	lbz 0,16(11)
	ori 0,0,1
	stb 0,16(11)
	lwz 9,84(31)
	stw 7,0(9)
	lwz 11,84(31)
	lwz 29,1788(11)
	lwz 3,40(29)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L14
	la 3,.LC3@l(30)
	bl FindItem
	lwz 9,84(31)
	stw 3,3596(9)
	mr 3,31
	bl ChangeWeapon
	lwz 0,12(29)
	mr 4,29
	mr 3,31
	mtlr 0
	blrl
.L14:
	lis 8,i.9@ha
	lis 9,0x5555
	lwz 6,84(31)
	lwz 10,i.9@l(8)
	ori 9,9,21846
	li 7,5
	addi 10,10,1
	mulhw 9,10,9
	srawi 11,10,31
	subf 9,11,9
	slwi 0,9,1
	add 0,0,9
	subf 10,0,10
	stw 10,i.9@l(8)
	stw 7,3760(6)
	lwz 11,84(31)
	lbz 0,16(11)
	andi. 9,0,1
	bc 12,2,.L15
	li 0,172
	li 9,176
	b .L24
.L15:
	cmpwi 0,10,1
	bc 12,2,.L19
	bc 12,1,.L23
	cmpwi 0,10,0
	bc 12,2,.L18
	b .L16
.L23:
	cmpwi 0,10,2
	bc 12,2,.L20
	b .L16
.L18:
	li 0,177
	li 9,182
	b .L24
.L19:
	li 0,183
	li 9,188
	b .L24
.L20:
	li 0,189
	li 9,196
.L24:
	stw 0,56(31)
	stw 9,3756(11)
.L16:
	lis 29,gi@ha
	la 29,gi@l(29)
	bl rand
	mr 4,3
	srawi 0,4,31
	lis 3,.LC4@ha
	srwi 0,0,30
	la 3,.LC4@l(3)
	add 0,4,0
	rlwinm 0,0,0,0,29
	subf 4,0,4
	addi 4,4,1
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC5@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC5@l(9)
	mr 3,31
	lfs 1,0(9)
	mtlr 11
	li 4,2
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 2,0(9)
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 3,0(9)
	blrl
	mr 3,31
	bl K2_ResetClientKeyVars
	lwz 9,84(31)
	li 0,1
	mr 3,31
	stw 0,4012(9)
	lwz 0,72(29)
	mtlr 0
	blrl
.L9:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Client_BeginFeign,.Lfe2-Client_BeginFeign
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
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
