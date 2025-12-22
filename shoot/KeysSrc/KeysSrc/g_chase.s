	.file	"g_chase.c"
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
	.long 0x0
	.align 3
.LC1:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC2:
	.long 0x42600000
	.align 2
.LC3:
	.long 0xc1f00000
	.align 2
.LC4:
	.long 0x41a00000
	.align 2
.LC5:
	.long 0x41800000
	.align 2
.LC6:
	.long 0x40c00000
	.align 2
.LC7:
	.long 0x3f800000
	.align 2
.LC8:
	.long 0x40000000
	.align 2
.LC9:
	.long 0x47800000
	.align 2
.LC10:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl UpdateChaseCam
	.type	 UpdateChaseCam,@function
UpdateChaseCam:
	stwu 1,-256(1)
	mflr 0
	stfd 30,240(1)
	stfd 31,248(1)
	stmw 25,212(1)
	stw 0,260(1)
	mr 30,3
	lwz 11,84(30)
	lwz 31,3972(11)
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L8
	lwz 9,84(31)
	lwz 0,3508(9)
	cmpwi 0,0,0
	bc 12,2,.L7
.L8:
	li 0,0
	lis 9,.LC0@ha
	stw 0,3972(11)
	la 9,.LC0@l(9)
	lis 10,ctf@ha
	lwz 11,84(30)
	lfs 13,0(9)
	lbz 0,16(11)
	andi. 0,0,191
	stb 0,16(11)
	lwz 9,ctf@l(10)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L9
	mr 3,30
	bl CTFOpenJoinMenu
	b .L6
.L9:
	mr 3,30
	bl K2_OpenJoinMenu
	b .L6
.L7:
	lfs 13,4(31)
	lis 11,0x4330
	lfs 10,4(30)
	lis 10,.LC1@ha
	la 10,.LC1@l(10)
	stfs 13,24(1)
	lfs 0,8(31)
	lfs 12,8(30)
	lfd 11,0(10)
	stfs 0,28(1)
	lis 10,.LC2@ha
	lfs 13,12(31)
	la 10,.LC2@l(10)
	lfs 0,12(30)
	stfs 10,152(1)
	stfs 13,32(1)
	stfs 0,160(1)
	stfs 12,156(1)
	lwz 0,508(31)
	lfs 9,0(10)
	xoris 0,0,0x8000
	stw 0,204(1)
	stw 11,200(1)
	lfd 0,200(1)
	fsub 0,0,11
	frsp 0,0
	fadds 13,13,0
	stfs 13,32(1)
	lwz 9,84(31)
	lfs 0,3700(9)
	stfs 0,168(1)
	fcmpu 0,0,9
	lwz 9,84(31)
	lfs 0,3704(9)
	stfs 0,172(1)
	lwz 9,84(31)
	lfs 0,3708(9)
	stfs 0,176(1)
	bc 4,1,.L11
	stfs 9,168(1)
.L11:
	addi 29,1,56
	addi 5,1,72
	addi 3,1,168
	addi 28,1,24
	mr 4,29
	li 6,0
	bl AngleVectors
	mr 3,29
	bl VectorNormalize
	lis 9,.LC3@ha
	mr 3,28
	la 9,.LC3@l(9)
	mr 4,29
	lfs 1,0(9)
	addi 5,1,8
	bl VectorMA
	lis 9,.LC4@ha
	lfs 0,12(31)
	la 9,.LC4@l(9)
	lfs 12,16(1)
	lfs 13,0(9)
	fadds 0,0,13
	fcmpu 0,12,0
	bc 4,0,.L12
	stfs 0,16(1)
.L12:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 4,2,.L13
	lis 10,.LC5@ha
	lfs 0,16(1)
	la 10,.LC5@l(10)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,16(1)
.L13:
	lis 9,gi@ha
	lis 25,vec3_origin@ha
	la 26,gi@l(9)
	lis 11,.LC6@ha
	lwz 10,48(26)
	addi 27,1,88
	la 5,vec3_origin@l(25)
	la 11,.LC6@l(11)
	mr 6,5
	addi 7,1,8
	li 9,3
	mtlr 10
	lfs 31,0(11)
	mr 4,28
	mr 8,31
	mr 3,27
	lis 11,.LC7@ha
	la 11,.LC7@l(11)
	addi 28,1,40
	lfs 30,0(11)
	blrl
	lis 9,.LC8@ha
	lfs 12,100(1)
	mr 4,29
	lfs 13,104(1)
	la 9,.LC8@l(9)
	mr 3,28
	lfs 0,108(1)
	mr 5,28
	lfs 1,0(9)
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
	bl VectorMA
	lfs 12,48(1)
	la 5,vec3_origin@l(25)
	mr 3,27
	lwz 11,48(26)
	mr 4,28
	mr 6,5
	lfs 0,44(1)
	addi 7,1,8
	mr 8,31
	fadds 12,12,31
	lfs 13,40(1)
	li 9,3
	mtlr 11
	stfs 0,12(1)
	stfs 13,8(1)
	stfs 12,16(1)
	blrl
	lfs 0,96(1)
	fcmpu 0,0,30
	bc 4,0,.L14
	lfs 0,108(1)
	lfs 12,100(1)
	lfs 13,104(1)
	fsubs 0,0,31
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
.L14:
	lfs 12,48(1)
	la 5,vec3_origin@l(25)
	mr 3,27
	lwz 0,48(26)
	mr 4,28
	mr 6,5
	lfs 0,44(1)
	addi 7,1,8
	mr 8,31
	fsubs 12,12,31
	lfs 13,40(1)
	li 9,3
	mtlr 0
	stfs 0,12(1)
	stfs 13,8(1)
	stfs 12,16(1)
	blrl
	lfs 0,96(1)
	fcmpu 0,0,30
	bc 4,0,.L15
	lfs 0,108(1)
	lfs 12,100(1)
	lfs 13,104(1)
	fadds 0,0,31
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
.L15:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L16
	lwz 9,84(30)
	li 0,2
	b .L26
.L16:
	lwz 9,84(30)
	li 0,4
.L26:
	stw 0,0(9)
	lis 9,.LC9@ha
	lis 10,.LC10@ha
	lfs 12,40(1)
	li 11,3
	lfs 13,44(1)
	la 9,.LC9@l(9)
	lfs 0,48(1)
	la 10,.LC10@l(10)
	mtctr 11
	li 6,0
	lfs 10,0(9)
	li 7,0
	lfs 11,0(10)
	stfs 12,4(30)
	stfs 13,8(30)
	stfs 0,12(30)
.L25:
	lwz 8,84(30)
	add 0,6,6
	lwz 9,84(31)
	addi 6,6,1
	addi 11,8,3496
	addi 9,9,3700
	lfsx 12,11,7
	addi 8,8,20
	lfsx 0,9,7
	addi 7,7,4
	fsubs 0,0,12
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 13,0
	stfd 13,200(1)
	lwz 10,204(1)
	sthx 10,8,0
	bdnz .L25
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L23
	lwz 11,84(30)
	lis 0,0x4220
	lis 10,0xc170
	stw 0,36(11)
	lwz 9,84(30)
	stw 10,28(9)
	lwz 11,84(31)
	lwz 9,84(30)
	lfs 0,3628(11)
	stfs 0,32(9)
	b .L24
.L23:
	lwz 9,84(31)
	lwz 11,84(30)
	lfs 0,3700(9)
	stfs 0,28(11)
	lwz 9,84(31)
	lwz 11,84(30)
	lfs 0,3704(9)
	stfs 0,32(11)
	lwz 9,84(31)
	lwz 11,84(30)
	lfs 0,3708(9)
	stfs 0,36(11)
	lwz 9,84(31)
	lwz 11,84(30)
	lfs 0,3700(9)
	stfs 0,3700(11)
	lwz 9,84(31)
	lwz 11,84(30)
	lfs 0,3704(9)
	stfs 0,3704(11)
	lwz 9,84(31)
	lwz 11,84(30)
	lfs 0,3708(9)
	stfs 0,3708(11)
.L24:
	lwz 9,84(30)
	li 0,0
	lis 11,gi+72@ha
	stw 0,508(30)
	mr 3,30
	lbz 0,16(9)
	ori 0,0,64
	stb 0,16(9)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L6:
	lwz 0,260(1)
	mtlr 0
	lmw 25,212(1)
	lfd 30,240(1)
	lfd 31,248(1)
	la 1,256(1)
	blr
.Lfe1:
	.size	 UpdateChaseCam,.Lfe1-UpdateChaseCam
	.section	".rodata"
	.align 2
.LC11:
	.string	"No other players to chase."
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.comm	last_trail_time,4,4
	.align 3
.LC12:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ChaseNext
	.type	 ChaseNext,@function
ChaseNext:
	stwu 1,-16(1)
	lwz 8,84(3)
	lwz 7,3972(8)
	cmpwi 0,7,0
	bc 12,2,.L27
	lis 9,g_edicts@ha
	lis 0,0xfb74
	lwz 11,g_edicts@l(9)
	ori 0,0,41881
	mr 5,8
	lis 9,maxclients@ha
	lis 4,0x4330
	mr 6,11
	lwz 10,maxclients@l(9)
	subf 11,11,7
	lis 9,.LC12@ha
	mullw 11,11,0
	la 9,.LC12@l(9)
	lfs 12,20(10)
	mr 7,5
	lfd 13,0(9)
	srawi 11,11,3
	mulli 0,11,1352
	add 8,0,6
.L36:
	addi 11,11,1
	xoris 0,11,0x8000
	addi 8,8,1352
	stw 0,12(1)
	stw 4,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,1,.L32
	addi 8,6,1352
	li 11,1
.L32:
	mr 10,8
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L31
	lwz 0,968(10)
	cmpwi 0,0,0
	bc 4,2,.L31
	lwz 9,84(10)
	lwz 0,3508(9)
	cmpwi 0,0,0
	bc 12,2,.L30
.L31:
	lwz 0,3972(7)
	cmpw 0,10,0
	bc 4,2,.L36
.L30:
	stw 10,3972(5)
	li 0,1
	lwz 9,84(3)
	stw 0,3976(9)
.L27:
	la 1,16(1)
	blr
.Lfe2:
	.size	 ChaseNext,.Lfe2-ChaseNext
	.align 2
	.globl ChasePrev
	.type	 ChasePrev,@function
ChasePrev:
	stwu 1,-16(1)
	lwz 10,84(3)
	lwz 8,3972(10)
	cmpwi 0,8,0
	bc 12,2,.L37
	lis 9,g_edicts@ha
	lis 11,0xfb74
	lwz 0,g_edicts@l(9)
	ori 11,11,41881
	mr 5,10
	lis 9,maxclients@ha
	mr 7,0
	lwz 6,maxclients@l(9)
	subf 0,0,8
	mullw 0,0,11
	mr 8,5
	srawi 10,0,3
.L46:
	addic. 10,10,-1
	bc 12,1,.L42
	lfs 0,20(6)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 10,12(1)
.L42:
	mulli 0,10,1352
	add 11,7,0
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L41
	lwz 0,968(11)
	cmpwi 0,0,0
	bc 4,2,.L41
	lwz 9,84(11)
	lwz 0,3508(9)
	cmpwi 0,0,0
	bc 12,2,.L40
.L41:
	lwz 0,3972(8)
	cmpw 0,11,0
	bc 4,2,.L46
.L40:
	stw 11,3972(5)
	li 0,1
	lwz 9,84(3)
	stw 0,3976(9)
.L37:
	la 1,16(1)
	blr
.Lfe3:
	.size	 ChasePrev,.Lfe3-ChasePrev
	.section	".rodata"
	.align 2
.LC13:
	.long 0x3f800000
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl GetChaseTarget
	.type	 GetChaseTarget,@function
GetChaseTarget:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC13@ha
	lis 9,maxclients@ha
	la 11,.LC13@l(11)
	mr 8,3
	lfs 13,0(11)
	li 6,1
	lis 3,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L49
	lis 9,.LC14@ha
	lis 4,g_edicts@ha
	la 9,.LC14@l(9)
	li 12,1
	lfd 12,0(9)
	lis 5,0x4330
	li 7,1352
.L51:
	lwz 0,g_edicts@l(4)
	add 10,0,7
	lwz 9,88(10)
	cmpwi 0,9,0
	bc 12,2,.L50
	lwz 9,84(10)
	lwz 0,3508(9)
	cmpwi 0,0,0
	bc 4,2,.L50
	lwz 0,968(10)
	cmpwi 0,0,0
	bc 4,2,.L50
	lwz 11,84(8)
	mr 3,8
	stw 10,3972(11)
	lwz 9,84(8)
	stw 12,3976(9)
	bl UpdateChaseCam
	b .L47
.L50:
	addi 6,6,1
	lwz 11,maxclients@l(3)
	xoris 0,6,0x8000
	addi 7,7,1352
	stw 0,12(1)
	stw 5,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L51
.L49:
	lis 9,gi+12@ha
	lis 4,.LC11@ha
	lwz 0,gi+12@l(9)
	mr 3,8
	la 4,.LC11@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L47:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 GetChaseTarget,.Lfe4-GetChaseTarget
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
