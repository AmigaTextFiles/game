	.file	"k2_hook.c"
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
.LC1:
	.string	"world/fusein.wav"
	.align 2
.LC0:
	.long 0x3e4ccccd
	.align 2
.LC2:
	.long 0x3f800000
	.align 2
.LC3:
	.long 0x0
	.section	".text"
	.align 2
	.globl Grapple_Touch
	.type	 Grapple_Touch,@function
Grapple_Touch:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	mr 31,3
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	lwz 3,256(31)
	mr 30,4
	mr 27,5
	lfs 31,0(9)
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L13
	lis 9,.LC0@ha
	lfs 31,.LC0@l(9)
.L13:
	lwz 9,256(31)
	cmpw 0,30,9
	bc 12,2,.L12
	lwz 9,84(9)
	lwz 0,3996(9)
	cmpwi 0,0,0
	bc 4,2,.L15
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 12,2,.L12
.L15:
	lis 9,g_edicts@ha
	li 28,0
	lwz 0,g_edicts@l(9)
	stw 28,480(31)
	cmpw 0,30,0
	bc 12,2,.L17
	lwz 9,252(30)
	lis 0,0x600
	ori 0,0,3
	cmpw 0,9,0
	bc 12,2,.L12
.L17:
	lis 29,gi@ha
	lis 3,.LC1@ha
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC2@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC2@l(9)
	li 4,3
	lfs 2,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 3,0(9)
	blrl
	cmpwi 0,30,0
	bc 12,2,.L18
	lis 11,hook_damage@ha
	lwz 5,256(31)
	lwz 10,hook_damage@l(11)
	mr 8,27
	mr 3,30
	mr 4,31
	addi 6,31,376
	lfs 0,20(10)
	addi 7,31,4
	stw 28,12(1)
	li 10,0
	stw 28,8(1)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	bl T_Damage
.L18:
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,30,0
	bc 12,2,.L20
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 12,2,.L19
	lwz 0,248(30)
	cmpwi 0,0,2
	bc 4,2,.L19
	mr 3,31
	bl Release_Grapple
	b .L12
.L19:
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,30,0
	bc 12,2,.L20
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L20
	lwz 9,260(30)
	addi 9,9,-2
	cmplwi 0,9,1
	bc 12,1,.L20
	stw 31,572(30)
	li 10,0
	lwz 9,256(31)
	lwz 11,84(9)
	stw 30,4000(11)
	lwz 0,264(31)
	stw 30,540(31)
	ori 0,0,1024
	stw 10,552(31)
	stw 0,264(31)
.L20:
	lis 9,hook_time@ha
	li 0,0
	lwz 7,256(31)
	lwz 11,hook_time@l(9)
	li 10,0
	li 8,1
	stw 0,388(31)
	lis 9,level+4@ha
	stw 0,384(31)
	stw 0,380(31)
	stw 0,376(31)
	stw 0,396(31)
	stw 0,392(31)
	stw 10,248(31)
	stw 10,444(31)
	stw 10,260(31)
	lfs 0,level+4@l(9)
	lfs 13,20(11)
	fadds 0,0,13
	stfs 0,596(31)
	lwz 9,84(7)
	stw 8,4004(9)
	lwz 11,256(31)
	stw 10,552(11)
.L12:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe1:
	.size	 Grapple_Touch,.Lfe1-Grapple_Touch
	.section	".rodata"
	.align 3
.LC4:
	.long 0x3fd33333
	.long 0x33333333
	.section	".text"
	.align 2
	.globl Think_Grapple
	.type	 Think_Grapple,@function
Think_Grapple:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,596(31)
	fcmpu 0,13,0
	bc 4,1,.L22
	lis 9,Release_Grapple@ha
	la 9,Release_Grapple@l(9)
	stw 9,432(31)
	b .L21
.L22:
	lwz 5,256(31)
	lwz 9,84(5)
	lwz 3,4000(9)
	cmpwi 0,3,0
	bc 12,2,.L24
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,3,0
	bc 12,2,.L28
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L28
	lwz 0,492(3)
	cmpwi 0,0,2
	bc 4,2,.L27
.L28:
	mr 3,31
	bl Release_Grapple
	b .L21
.L27:
	lis 11,hook_damage@ha
	lwz 10,hook_damage@l(11)
	li 0,0
	lis 8,vec3_origin@ha
	la 8,vec3_origin@l(8)
	mr 4,31
	lfs 0,20(10)
	addi 6,31,376
	addi 7,31,4
	stw 0,12(1)
	li 10,0
	stw 0,8(1)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	bl T_Damage
.L24:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,11
	mtlr 9
	blrl
	lwz 9,120(29)
	lwz 3,256(31)
	mtlr 9
	addi 3,3,4
	blrl
	lwz 9,120(29)
	addi 3,31,4
	mtlr 9
	blrl
	lwz 3,256(31)
	li 4,2
	lwz 0,88(29)
	addi 3,3,4
	mtlr 0
	blrl
	lfs 0,428(31)
	lis 9,.LC4@ha
	lfd 13,.LC4@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L21:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Think_Grapple,.Lfe2-Think_Grapple
	.section	".rodata"
	.align 2
.LC5:
	.string	"hook"
	.align 2
.LC6:
	.string	"models/objects/rocket/tris.md2"
	.align 3
.LC7:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC8:
	.long 0xc0000000
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Make_Hook
	.type	 Make_Hook,@function
Make_Hook:
	stwu 1,-112(1)
	mflr 0
	stmw 28,96(1)
	stw 0,116(1)
	mr 30,3
	addi 29,1,24
	bl G_Spawn
	mr 31,3
	addi 28,1,8
	lwz 3,84(30)
	mr 4,28
	mr 5,29
	li 6,0
	addi 3,3,3700
	bl AngleVectors
	lis 9,.LC8@ha
	lwz 4,84(30)
	addi 3,1,8
	la 9,.LC8@l(9)
	lfs 1,0(9)
	addi 4,4,3648
	bl VectorScale
	lwz 9,84(30)
	lis 0,0xbf80
	lis 10,0x4330
	addi 3,30,4
	stw 0,3636(9)
	lis 9,.LC9@ha
	lwz 8,84(30)
	lis 0,0x4100
	la 9,.LC9@l(9)
	lfd 13,0(9)
	lwz 9,508(30)
	stw 0,76(1)
	addi 9,9,-8
	stw 0,56(1)
	xoris 9,9,0x8000
	stw 0,60(1)
	stw 9,92(1)
	stw 10,88(1)
	lfd 0,88(1)
	stw 0,72(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,80(1)
	stfs 0,64(1)
	lwz 0,716(8)
	xori 9,0,2
	subfic 11,9,0
	adde 9,11,9
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L30
	lis 0,0xc100
	stw 0,76(1)
.L30:
	mr 6,29
	addi 7,1,40
	addi 4,1,72
	mr 5,28
	bl G_ProjectSource
	lfs 13,40(1)
	mr 3,28
	addi 4,31,16
	stfs 13,4(31)
	lfs 0,44(1)
	stfs 0,8(31)
	lfs 13,48(1)
	stfs 13,12(31)
	lfs 0,8(1)
	stfs 0,340(31)
	lfs 13,12(1)
	stfs 13,344(31)
	lfs 0,16(1)
	stfs 0,348(31)
	bl vectoangles
	lis 9,hook_speed@ha
	mr 3,28
	lwz 11,hook_speed@l(9)
	addi 4,31,376
	lfs 1,20(11)
	bl VectorScale
	lis 9,.LC5@ha
	lis 11,0x600
	la 9,.LC5@l(9)
	li 0,0
	stw 9,280(31)
	ori 11,11,3
	lis 10,0x4448
	li 8,8
	li 9,2
	stw 10,396(31)
	lis 29,gi@ha
	stw 8,260(31)
	lis 3,.LC6@ha
	la 29,gi@l(29)
	stw 11,252(31)
	la 3,.LC6@l(3)
	stw 0,200(31)
	stw 0,388(31)
	stw 0,392(31)
	stw 0,196(31)
	stw 0,192(31)
	stw 0,188(31)
	stw 0,208(31)
	stw 0,204(31)
	stw 9,248(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 11,hook_time@ha
	lis 9,Grapple_Touch@ha
	stw 3,40(31)
	lwz 10,hook_time@l(11)
	la 9,Grapple_Touch@l(9)
	lis 8,.LC7@ha
	lis 11,level@ha
	stw 9,444(31)
	li 0,4
	stw 30,256(31)
	la 11,level@l(11)
	lis 9,Think_Grapple@ha
	lfs 0,20(10)
	la 9,Think_Grapple@l(9)
	li 7,100
	lfs 13,4(11)
	mr 3,31
	lfd 12,.LC7@l(8)
	fadds 13,13,0
	stfs 13,596(31)
	lfs 0,4(11)
	stw 9,436(31)
	stw 7,480(31)
	stw 0,184(31)
	fadd 0,0,12
	frsp 0,0
	stfs 0,428(31)
	lwz 9,84(30)
	stw 31,3996(9)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 0,116(1)
	mtlr 0
	lmw 28,96(1)
	la 1,112(1)
	blr
.Lfe3:
	.size	 Make_Hook,.Lfe3-Make_Hook
	.section	".rodata"
	.align 2
.LC11:
	.string	"weapons/noammo.wav"
	.align 2
.LC12:
	.string	"medic/medatck2.wav"
	.align 2
.LC10:
	.long 0x3e4ccccd
	.align 2
.LC13:
	.long 0x3f800000
	.align 2
.LC14:
	.long 0x0
	.align 2
.LC15:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl Throw_Grapple
	.type	 Throw_Grapple,@function
Throw_Grapple:
	stwu 1,-144(1)
	mflr 0
	stfd 31,136(1)
	stmw 28,120(1)
	stw 0,148(1)
	lis 9,.LC13@ha
	mr 31,3
	la 9,.LC13@l(9)
	lfs 31,0(9)
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L33
	lis 9,.LC10@ha
	lfs 31,.LC10@l(9)
.L33:
	lwz 11,84(31)
	lis 9,skyhook@ha
	li 10,0
	lwz 8,skyhook@l(9)
	lwz 0,3588(11)
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	xori 0,0,2
	lfs 13,0(9)
	stw 0,3588(11)
	lwz 9,84(31)
	stw 10,4000(9)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 4,2,.L34
	lwz 3,84(31)
	addi 28,1,40
	addi 4,1,8
	addi 5,1,24
	li 6,0
	addi 3,3,3700
	addi 29,31,4
	bl AngleVectors
	lis 9,gi@ha
	addi 4,1,8
	la 30,gi@l(9)
	mr 3,29
	lis 9,.LC15@ha
	mr 5,28
	la 9,.LC15@l(9)
	lfs 1,0(9)
	bl VectorMA
	lwz 11,48(30)
	lis 9,0x600
	mr 4,29
	ori 9,9,3
	mr 7,28
	addi 3,1,56
	li 5,0
	mtlr 11
	li 6,0
	mr 8,31
	blrl
	lwz 9,100(1)
	lwz 0,16(9)
	andi. 9,0,4
	bc 12,2,.L34
	lwz 9,36(30)
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	mtlr 9
	blrl
	lis 9,.LC13@ha
	lwz 0,16(30)
	mr 5,3
	fmr 1,31
	la 9,.LC13@l(9)
	li 4,3
	lfs 2,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 3,0(9)
	blrl
	b .L32
.L34:
	mr 3,31
	bl Make_Hook
	lis 29,gi@ha
	lis 3,.LC12@ha
	la 29,gi@l(29)
	la 3,.LC12@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC13@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC13@l(9)
	li 4,0
	lfs 2,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 3,0(9)
	blrl
.L32:
	lwz 0,148(1)
	mtlr 0
	lmw 28,120(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe4:
	.size	 Throw_Grapple,.Lfe4-Throw_Grapple
	.section	".rodata"
	.align 2
.LC17:
	.string	"medic/medatck5.wav"
	.align 2
.LC18:
	.long 0x0
	.align 2
.LC19:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Pull_Grapple
	.type	 Pull_Grapple,@function
Pull_Grapple:
	stwu 1,-128(1)
	mflr 0
	stfd 31,120(1)
	stw 31,116(1)
	stw 0,132(1)
	mr 31,3
	lwz 11,84(31)
	addi 3,1,8
	lfs 13,4(31)
	lwz 9,3996(11)
	lfs 12,8(31)
	lfs 0,4(9)
	lfs 11,12(31)
	fsubs 0,0,13
	stfs 0,8(1)
	lwz 9,3996(11)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lwz 9,3996(11)
	lfs 0,12(9)
	fsubs 0,0,11
	stfs 0,16(1)
	bl VectorNormalize
	lis 9,pull_speed@ha
	addi 3,1,8
	lwz 11,pull_speed@l(9)
	addi 4,31,376
	lfs 1,20(11)
	bl VectorScale
	lis 9,.LC18@ha
	lfs 13,384(31)
	la 9,.LC18@l(9)
	lfs 11,8(1)
	lfs 0,0(9)
	lfs 12,12(1)
	fcmpu 0,13,0
	lfs 0,16(1)
	stfs 11,340(31)
	stfs 12,344(31)
	stfs 0,348(31)
	bc 4,1,.L42
	lis 9,.LC19@ha
	lfs 0,12(31)
	lis 11,gi+48@ha
	la 9,.LC19@l(9)
	lwz 0,gi+48@l(11)
	addi 4,1,24
	lfs 31,0(9)
	addi 3,1,40
	addi 5,31,188
	lis 9,0x201
	lfs 12,4(31)
	mtlr 0
	addi 6,31,200
	lfs 13,8(31)
	mr 7,4
	mr 8,31
	fadds 0,0,31
	ori 9,9,3
	stfs 12,24(1)
	stfs 13,28(1)
	stfs 0,32(1)
	blrl
	lwz 0,44(1)
	cmpwi 0,0,0
	bc 4,2,.L42
	lfs 0,12(31)
	fadds 0,0,31
	stfs 0,12(31)
.L42:
	lwz 0,132(1)
	mtlr 0
	lwz 31,116(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe5:
	.size	 Pull_Grapple,.Lfe5-Pull_Grapple
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
	.globl Started_Grappling
	.type	 Started_Grappling,@function
Started_Grappling:
	lwz 3,3588(3)
	rlwinm 3,3,0,30,30
	blr
.Lfe6:
	.size	 Started_Grappling,.Lfe6-Started_Grappling
	.align 2
	.globl Ended_Grappling
	.type	 Ended_Grappling,@function
Ended_Grappling:
	lwz 0,3580(3)
	li 9,0
	andi. 11,0,2
	bc 4,2,.L10
	lwz 0,3584(3)
	rlwinm 9,0,31,31,31
.L10:
	mr 3,9
	blr
.Lfe7:
	.size	 Ended_Grappling,.Lfe7-Ended_Grappling
	.align 2
	.globl Is_Grappling
	.type	 Is_Grappling,@function
Is_Grappling:
	lwz 0,3996(3)
	addic 9,0,-1
	subfe 3,9,0
	blr
.Lfe8:
	.size	 Is_Grappling,.Lfe8-Is_Grappling
	.section	".rodata"
	.align 2
.LC20:
	.long 0x3e4ccccd
	.align 2
.LC21:
	.long 0x3f800000
	.align 2
.LC22:
	.long 0x0
	.section	".text"
	.align 2
	.globl Release_Grapple
	.type	 Release_Grapple,@function
Release_Grapple:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 27,20(1)
	stw 0,52(1)
	mr 28,3
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lwz 3,256(28)
	lfs 31,0(9)
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L37
	lis 9,.LC20@ha
	lfs 31,.LC20@l(9)
.L37:
	lwz 30,256(28)
	li 27,0
	lwz 31,84(30)
	lwz 0,3996(31)
	stw 27,4004(31)
	cmpwi 0,0,0
	stw 27,4000(31)
	bc 12,2,.L38
	lis 29,gi@ha
	stw 27,3996(31)
	lis 3,.LC17@ha
	la 29,gi@l(29)
	la 3,.LC17@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC21@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC21@l(9)
	li 4,3
	lfs 2,0(9)
	mtlr 0
	mr 3,30
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 3,0(9)
	blrl
	li 9,0
	stw 9,3728(31)
	stw 9,3736(31)
	stw 9,3732(31)
	lwz 0,552(30)
	cmpwi 0,0,0
	bc 12,2,.L39
	stw 9,376(30)
	stw 9,384(30)
	stw 9,380(30)
.L39:
	lwz 11,540(28)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	cmpwi 0,11,0
	stw 9,436(28)
	bc 12,2,.L40
	stw 27,572(11)
.L40:
	mr 3,28
	bl G_FreeEdict
.L38:
	lwz 0,52(1)
	mtlr 0
	lmw 27,20(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 Release_Grapple,.Lfe9-Release_Grapple
	.align 2
	.globl P_ProjectHookSource
	.type	 P_ProjectHookSource,@function
P_ProjectHookSource:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	lfs 12,4(5)
	mr 11,7
	lfs 13,8(5)
	mr 7,8
	lfs 0,0(5)
	stfs 12,12(1)
	stfs 13,16(1)
	stfs 0,8(1)
	lwz 0,716(3)
	xori 9,0,2
	subfic 10,9,0
	adde 9,10,9
	subfic 10,0,0
	adde 0,10,0
	or. 10,0,9
	bc 12,2,.L7
	fneg 0,12
	stfs 0,12(1)
.L7:
	mr 3,4
	mr 5,6
	mr 6,11
	addi 4,1,8
	bl G_ProjectSource
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe10:
	.size	 P_ProjectHookSource,.Lfe10-P_ProjectHookSource
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
