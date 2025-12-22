	.file	"g_newai.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC1:
	.string	"monster_parasite"
	.align 2
.LC2:
	.string	"tesla"
	.align 2
.LC0:
	.long 0x46fffe00
	.align 3
.LC3:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC4:
	.long 0x41000000
	.section	".text"
	.align 2
	.globl blocked_checkshot
	.type	 blocked_checkshot,@function
blocked_checkshot:
	stwu 1,-208(1)
	mflr 0
	stfd 31,200(1)
	stmw 27,180(1)
	stw 0,212(1)
	mr 31,3
	fmr 31,1
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L16
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 4,2,.L8
	lwz 0,1016(9)
	cmpwi 0,0,0
	bc 12,2,.L16
.L8:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,172(1)
	lis 11,.LC3@ha
	la 11,.LC3@l(11)
	stw 0,168(1)
	lfd 13,0(11)
	lfd 0,168(1)
	lis 11,.LC0@ha
	lfs 12,.LC0@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fcmpu 0,0,31
	li 3,0
	bc 12,0,.L19
	lwz 3,280(31)
	lis 4,.LC1@ha
	la 4,.LC1@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L10
	addi 28,1,24
	addi 29,1,56
	addi 4,1,8
	mr 5,28
	addi 3,31,16
	li 6,0
	bl AngleVectors
	mr 30,29
	lis 0,0x41c0
	li 9,0
	lis 11,0x40c0
	addi 27,1,72
	stw 9,44(1)
	mr 6,28
	addi 4,1,40
	stw 0,40(1)
	addi 3,31,4
	stw 11,48(1)
	addi 5,1,8
	mr 7,29
	mr 28,27
	bl G_ProjectSource
	lwz 9,540(31)
	mr 3,29
	mr 4,27
	lfs 0,4(9)
	stfs 0,72(1)
	lfs 13,8(9)
	stfs 13,76(1)
	lfs 0,12(9)
	stfs 0,80(1)
	bl parasite_drain_attack_ok
	cmpwi 0,3,0
	bc 4,2,.L11
	lwz 9,540(31)
	lis 11,.LC4@ha
	mr 3,30
	la 11,.LC4@l(11)
	mr 4,28
	lfs 13,208(9)
	lfs 0,12(9)
	lfs 31,0(11)
	fadds 0,0,13
	fsubs 0,0,31
	stfs 0,80(1)
	bl parasite_drain_attack_ok
	cmpwi 0,3,0
	bc 4,2,.L11
	lwz 9,540(31)
	mr 3,30
	mr 4,28
	lfs 13,196(9)
	lfs 0,12(9)
	fadds 0,0,13
	fadds 0,0,31
	stfs 0,80(1)
	bl parasite_drain_attack_ok
	cmpwi 0,3,0
	bc 12,2,.L16
.L11:
	lwz 10,540(31)
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	ori 9,9,3
	mr 4,30
	lfs 0,4(10)
	mr 7,28
	addi 3,1,88
	mtlr 0
	li 5,0
	li 6,0
	mr 8,31
	stfs 0,72(1)
	lfs 0,8(10)
	stfs 0,76(1)
	lfs 13,12(10)
	stfs 13,80(1)
	blrl
	lwz 9,140(1)
	lwz 0,540(31)
	cmpw 0,9,0
	bc 4,2,.L21
.L10:
	lwz 4,540(31)
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L16
	lwz 9,540(31)
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	lwz 3,280(9)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L16
.L21:
	lwz 9,812(31)
	lwz 0,776(31)
	cmpwi 0,9,0
	oris 0,0,0x400
	stw 0,776(31)
	bc 12,2,.L18
	mr 3,31
	mtlr 9
	blrl
.L18:
	lwz 0,776(31)
	li 3,1
	rlwinm 0,0,0,6,4
	stw 0,776(31)
	b .L19
.L16:
	li 3,0
.L19:
	lwz 0,212(1)
	mtlr 0
	lmw 27,180(1)
	lfd 31,200(1)
	la 1,208(1)
	blr
.Lfe1:
	.size	 blocked_checkshot,.Lfe1-blocked_checkshot
	.section	".rodata"
	.align 2
.LC5:
	.string	"func_plat"
	.align 2
.LC6:
	.long 0x43c00000
	.align 2
.LC7:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl blocked_checkplat
	.type	 blocked_checkplat,@function
blocked_checkplat:
	stwu 1,-160(1)
	mflr 0
	stfd 31,152(1)
	stmw 27,132(1)
	stw 0,164(1)
	mr 31,3
	fmr 31,1
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L34
	lfs 13,220(9)
	lfs 0,232(31)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L24
	li 27,1
	b .L25
.L24:
	lfs 13,232(9)
	li 27,0
	lfs 0,220(31)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L25
	li 27,-1
.L25:
	cmpwi 0,27,0
	bc 12,2,.L34
	lwz 11,552(31)
	li 30,0
	cmpwi 0,11,0
	bc 12,2,.L29
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,11,0
	bc 12,2,.L29
	lwz 3,280(11)
	lis 4,.LC5@ha
	li 5,8
	la 4,.LC5@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 4,2,.L29
	lwz 30,552(31)
.L29:
	cmpwi 0,30,0
	bc 4,2,.L45
	addi 29,1,104
	addi 28,1,72
	li 6,0
	addi 3,31,16
	mr 4,29
	li 5,0
	bl AngleVectors
	fmr 1,31
	mr 5,28
	mr 4,29
	addi 3,31,4
	bl VectorMA
	lis 9,.LC6@ha
	lfs 0,80(1)
	lis 11,gi+48@ha
	la 9,.LC6@l(9)
	lwz 0,gi+48@l(11)
	lis 5,vec3_origin@ha
	lfs 13,0(9)
	la 5,vec3_origin@l(5)
	mr 4,28
	lis 9,0x202
	lfs 12,72(1)
	addi 3,1,8
	mtlr 0
	ori 9,9,3
	mr 6,5
	fsubs 0,0,13
	addi 7,1,88
	mr 8,31
	lfs 13,76(1)
	stfs 12,88(1)
	stfs 0,96(1)
	stfs 13,92(1)
	blrl
	lis 9,.LC7@ha
	lfs 13,16(1)
	la 9,.LC7@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L31
	lwz 0,8(1)
	cmpwi 0,0,0
	bc 4,2,.L31
	lwz 0,12(1)
	cmpwi 0,0,0
	bc 4,2,.L31
	lwz 9,60(1)
	lis 4,.LC5@ha
	li 5,8
	la 4,.LC5@l(4)
	lwz 3,280(9)
	bl strncmp
	lwz 0,60(1)
	addic 3,3,-1
	subfe 3,3,3
	and 30,3,0
.L31:
	cmpwi 0,30,0
	bc 12,2,.L34
.L45:
	lwz 0,448(30)
	cmpwi 0,0,0
	mr 9,0
	bc 12,2,.L34
	cmpwi 0,27,1
	bc 4,2,.L35
	lwz 0,552(31)
	cmpw 0,0,30
	bc 4,2,.L46
	lwz 0,732(30)
	cmpwi 0,0,1
	bc 12,2,.L42
	b .L34
.L46:
	lwz 0,732(30)
	cmpwi 0,0,0
	b .L48
.L35:
	cmpwi 0,27,-1
	bc 4,2,.L34
	lwz 0,552(31)
	cmpw 0,0,30
	bc 4,2,.L47
	lwz 0,732(30)
	cmpwi 0,0,0
	bc 12,2,.L42
	b .L34
.L47:
	lwz 0,732(30)
	cmpwi 0,0,1
.L48:
	bc 4,2,.L34
.L42:
	mr 4,31
	mr 3,30
	mtlr 9
	mr 5,4
	blrl
	li 3,1
	b .L44
.L34:
	li 3,0
.L44:
	lwz 0,164(1)
	mtlr 0
	lmw 27,132(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe2:
	.size	 blocked_checkplat,.Lfe2-blocked_checkplat
	.section	".rodata"
	.align 3
.LC8:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 2
.LC9:
	.long 0x41800000
	.align 2
.LC10:
	.long 0x0
	.align 2
.LC11:
	.long 0x42400000
	.align 2
.LC12:
	.long 0x3f800000
	.align 2
.LC13:
	.long 0x41c00000
	.align 2
.LC14:
	.long 0x42000000
	.section	".text"
	.align 2
	.globl blocked_checkjump
	.type	 blocked_checkjump,@function
blocked_checkjump:
	stwu 1,-176(1)
	mflr 0
	stfd 30,160(1)
	stfd 31,168(1)
	stmw 28,144(1)
	stw 0,180(1)
	mr 31,3
	fmr 30,2
	lwz 0,540(31)
	fmr 31,3
	cmpwi 0,0,0
	bc 12,2,.L61
	addi 29,1,104
	addi 3,31,16
	mr 4,29
	li 5,0
	addi 6,1,120
	bl AngleVectors
	lis 9,.LC9@ha
	lfs 12,220(31)
	mr 4,29
	la 9,.LC9@l(9)
	lfs 11,0(9)
	lwz 9,540(31)
	fadds 0,12,11
	lfs 13,220(9)
	fcmpu 0,13,0
	bc 4,1,.L51
	li 11,1
	b .L52
.L51:
	fsubs 0,12,11
	li 11,0
	fcmpu 0,13,0
	bc 4,0,.L52
	li 11,-1
.L52:
	lis 10,.LC10@ha
	subfic 0,11,-1
	subfic 9,0,0
	adde 0,9,0
	la 10,.LC10@l(10)
	lfs 0,0(10)
	fcmpu 7,30,0
	crnor 31,30,30
	mfcr 9
	rlwinm 9,9,0,1
	and. 10,0,9
	bc 12,2,.L55
	lis 11,.LC11@ha
	addi 30,1,72
	la 11,.LC11@l(11)
	addi 29,31,4
	lfs 1,0(11)
	mr 3,29
	mr 5,30
	bl VectorMA
	lis 11,gi@ha
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	la 28,gi@l(11)
	lfs 31,0(9)
	mr 4,29
	addi 3,1,8
	lwz 11,48(28)
	lis 9,0x202
	addi 5,31,188
	addi 6,31,200
	mr 7,30
	mr 8,31
	ori 9,9,3
	mtlr 11
	blrl
	lfs 0,16(1)
	fcmpu 0,0,31
	bc 12,0,.L61
	lfs 0,196(31)
	lis 5,vec3_origin@ha
	lis 9,0x202
	lwz 0,48(28)
	la 5,vec3_origin@l(5)
	mr 4,30
	lfs 12,72(1)
	addi 3,1,8
	mr 6,5
	fsubs 0,0,30
	lfs 13,76(1)
	addi 7,1,88
	mr 8,31
	ori 9,9,59
	mtlr 0
	stfs 12,88(1)
	fsubs 0,0,31
	stfs 13,92(1)
	stfs 0,96(1)
	blrl
	lfs 0,16(1)
	fcmpu 0,0,31
	bc 4,0,.L61
	lwz 0,8(1)
	cmpwi 0,0,0
	bc 4,2,.L61
	lwz 0,12(1)
	cmpwi 0,0,0
	bc 4,2,.L61
	lfs 0,220(31)
	lis 9,.LC13@ha
	lfs 12,28(1)
	la 9,.LC13@l(9)
	lfs 13,0(9)
	fsubs 0,0,12
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L61
	lwz 0,56(1)
	andi. 10,0,3
	bc 12,2,.L61
	lwz 9,540(31)
	lis 11,.LC14@ha
	la 11,.LC14@l(11)
	lfs 0,220(9)
	lfs 13,0(11)
	fsubs 0,0,12
	fcmpu 0,0,13
	bc 12,1,.L61
	lfs 0,40(1)
	lis 9,.LC8@ha
	lfd 13,.LC8@l(9)
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,29,1
	xori 3,3,1
	b .L65
.L55:
	fcmpu 7,31,0
	xori 9,11,1
	subfic 0,9,0
	adde 9,0,9
	crnor 31,30,30
	mfcr 0
	rlwinm 0,0,0,1
	and. 10,9,0
	bc 12,2,.L61
	lis 11,.LC11@ha
	addi 29,1,72
	la 11,.LC11@l(11)
	mr 5,29
	lfs 1,0(11)
	addi 3,31,4
	bl VectorMA
	lfs 12,232(31)
	lis 11,gi+48@ha
	lis 5,vec3_origin@ha
	lwz 0,gi+48@l(11)
	la 5,vec3_origin@l(5)
	lis 9,0x202
	lfs 11,80(1)
	ori 9,9,59
	mr 4,29
	lfs 13,72(1)
	fadds 12,12,31
	addi 3,1,8
	mr 6,5
	lfs 0,76(1)
	addi 7,1,88
	mr 8,31
	mtlr 0
	stfs 11,96(1)
	stfs 13,88(1)
	stfs 0,92(1)
	stfs 12,80(1)
	blrl
	lis 9,.LC12@ha
	lfs 13,16(1)
	la 9,.LC12@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L61
	lwz 0,8(1)
	cmpwi 0,0,0
	bc 4,2,.L61
	lwz 0,12(1)
	cmpwi 0,0,0
	bc 4,2,.L61
	lfs 0,28(1)
	lfs 13,220(31)
	fsubs 0,0,13
	fcmpu 0,0,31
	cror 3,2,0
	bc 4,3,.L61
	lwz 0,56(1)
	andi. 10,0,3
	bc 12,2,.L61
	mr 3,31
	bl face_wall
	li 3,1
	b .L65
.L61:
	li 3,0
.L65:
	lwz 0,180(1)
	mtlr 0
	lmw 28,144(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe3:
	.size	 blocked_checkjump,.Lfe3-blocked_checkjump
	.align 2
	.globl hintpath_findstart
	.type	 hintpath_findstart,@function
hintpath_findstart:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lwz 5,296(3)
	cmpwi 0,5,0
	bc 12,2,.L68
	lis 9,g_edicts@ha
	li 3,0
	lwz 31,g_edicts@l(9)
	li 4,300
	bl G_Find
	mr. 3,3
	bc 12,2,.L74
	mr 31,3
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L74
.L72:
	lwz 5,296(3)
	li 4,300
	li 3,0
	bl G_Find
	mr. 3,3
	bc 12,2,.L74
	mr 31,3
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L72
	b .L74
.L68:
	lwz 5,300(3)
	lis 9,g_edicts@ha
	li 4,296
	li 3,0
	lwz 31,g_edicts@l(9)
	b .L84
.L78:
	lwz 5,300(3)
	li 4,296
	li 3,0
.L84:
	bl G_Find
	mr. 3,3
	bc 12,2,.L74
	mr 31,3
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L78
.L74:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L80
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	xor 0,31,0
	srawi 9,0,31
	xor 3,9,0
	subf 3,3,9
	srawi 3,3,31
	and 3,31,3
	b .L82
.L80:
	li 3,0
.L82:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 hintpath_findstart,.Lfe4-hintpath_findstart
	.align 2
	.globl hintpath_other_end
	.type	 hintpath_other_end,@function
hintpath_other_end:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lwz 5,296(3)
	cmpwi 0,5,0
	bc 12,2,.L86
	lis 9,g_edicts@ha
	li 3,0
	lwz 31,g_edicts@l(9)
	li 4,300
	bl G_Find
	mr. 3,3
	bc 12,2,.L92
	mr 31,3
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L92
.L90:
	lwz 5,296(3)
	li 4,300
	li 3,0
	bl G_Find
	mr. 3,3
	bc 12,2,.L92
	mr 31,3
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L90
	b .L92
.L86:
	lwz 5,300(3)
	lis 9,g_edicts@ha
	li 4,296
	li 3,0
	lwz 31,g_edicts@l(9)
	b .L102
.L96:
	lwz 5,300(3)
	li 4,296
	li 3,0
.L102:
	bl G_Find
	mr. 3,3
	bc 12,2,.L92
	mr 31,3
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L96
.L92:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L98
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	xor 0,31,0
	srawi 9,0,31
	xor 3,9,0
	subf 3,3,9
	srawi 3,3,31
	and 3,31,3
	b .L100
.L98:
	li 3,0
.L100:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 hintpath_other_end,.Lfe5-hintpath_other_end
	.section	".rodata"
	.align 2
.LC17:
	.string	"monster_turret"
	.align 2
.LC16:
	.long 0x49742400
	.align 2
.LC18:
	.long 0x4b189680
	.align 2
.LC19:
	.long 0x44000000
	.section	".text"
	.align 2
	.globl monsterlost_checkhint
	.type	 monsterlost_checkhint,@function
monsterlost_checkhint:
	stwu 1,-496(1)
	mflr 0
	stfd 30,480(1)
	stfd 31,488(1)
	stmw 25,452(1)
	stw 0,500(1)
	lis 9,hint_paths_present@ha
	lis 11,.LC16@ha
	lwz 0,hint_paths_present@l(9)
	mr 29,3
	li 25,0
	lfs 30,.LC16@l(11)
	cmpwi 0,0,0
	bc 12,2,.L193
	lwz 0,540(29)
	cmpwi 0,0,0
	bc 12,2,.L193
	lwz 0,776(29)
	andi. 9,0,1
	li 3,0
	bc 4,2,.L195
	lwz 3,280(29)
	lis 4,.LC17@ha
	la 4,.LC17@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L193
	lis 9,num_hint_paths@ha
	li 28,0
	lwz 0,num_hint_paths@l(9)
	li 11,0
	cmpw 0,28,0
	bc 4,0,.L113
	lis 9,hint_path_start@ha
	mr 8,0
	la 9,hint_path_start@l(9)
.L115:
	slwi 0,11,2
	lwzx 31,9,0
	addi 11,11,1
	cmpwi 0,31,0
	bc 12,2,.L114
	li 10,0
.L118:
	lwz 0,1068(31)
	cmpwi 0,0,0
	bc 12,2,.L119
	stw 10,1068(31)
.L119:
	cmpwi 0,28,0
	bc 12,2,.L120
	stw 31,1068(30)
	b .L196
.L120:
	mr 28,31
.L196:
	mr 30,31
	lwz 31,1064(31)
	cmpwi 0,31,0
	bc 4,2,.L118
.L114:
	cmpw 0,11,8
	bc 12,0,.L115
.L113:
	mr. 31,28
	li 30,0
	bc 12,2,.L125
	lis 9,.LC19@ha
	li 27,0
	la 9,.LC19@l(9)
	lfs 31,0(9)
.L126:
	mr 3,29
	mr 4,31
	bl realrange
	fcmpu 0,1,31
	bc 4,1,.L127
	cmpwi 0,30,0
	bc 12,2,.L128
	lwz 0,1068(31)
	stw 0,1068(30)
	stw 27,1068(31)
	lwz 31,1068(30)
	b .L124
.L128:
	mr 30,31
	lwz 31,1068(31)
	stw 27,1068(30)
	b .L197
.L127:
	mr 3,29
	mr 4,31
	bl visible
	mr. 3,3
	bc 4,2,.L130
	cmpwi 0,30,0
	bc 12,2,.L131
	lwz 0,1068(31)
	stw 0,1068(30)
	stw 3,1068(31)
	lwz 31,1068(30)
	b .L124
.L131:
	mr 30,31
	lwz 31,1068(31)
	stw 3,1068(30)
.L197:
	li 30,0
	mr 28,31
	b .L124
.L130:
	mr 30,31
	addi 25,25,1
	lwz 31,1068(31)
.L124:
	cmpwi 0,31,0
	bc 4,2,.L126
.L125:
	cmpwi 0,25,0
	bc 12,2,.L193
	lis 9,num_hint_paths@ha
	lwz 0,num_hint_paths@l(9)
	cmpwi 0,0,0
	bc 4,1,.L136
	mr 11,0
	addi 9,1,8
	li 0,0
.L138:
	addic. 11,11,-1
	stw 0,0(9)
	addi 9,9,4
	bc 4,2,.L138
.L136:
	mr. 31,28
	bc 12,2,.L141
	lis 9,num_hint_paths@ha
	li 10,1
	lwz 11,num_hint_paths@l(9)
	addi 9,1,8
.L142:
	lwz 0,1076(31)
	cmpwi 0,0,0
	bc 12,0,.L193
	cmpw 0,0,11
	bc 12,1,.L193
	slwi 0,0,2
	stwx 10,9,0
	lwz 31,1068(31)
	cmpwi 0,31,0
	bc 4,2,.L142
.L141:
	lis 9,num_hint_paths@ha
	li 27,0
	lwz 0,num_hint_paths@l(9)
	li 25,0
	li 30,0
	li 11,0
	cmpw 0,27,0
	bc 4,0,.L147
	lis 9,hint_path_start@ha
	mr 8,0
	la 9,hint_path_start@l(9)
	addi 10,1,8
.L149:
	slwi 4,11,2
	lwzx 0,10,4
	addi 11,11,1
	cmpwi 0,0,0
	bc 12,2,.L148
	lwzx 31,9,4
	cmpwi 0,31,0
	bc 12,2,.L148
.L153:
	cmpwi 0,27,0
	bc 12,2,.L154
	stw 31,1072(30)
	b .L198
.L154:
	mr 27,31
.L198:
	mr 30,31
	lwz 31,1064(31)
	cmpwi 0,31,0
	bc 4,2,.L153
.L148:
	cmpw 0,11,8
	bc 12,0,.L149
.L147:
	mr. 31,27
	li 30,0
	bc 12,2,.L159
	lis 9,.LC19@ha
	li 26,0
	la 9,.LC19@l(9)
	lfs 31,0(9)
.L160:
	lwz 3,540(29)
	mr 4,31
	bl realrange
	fcmpu 0,1,31
	bc 4,1,.L161
	cmpwi 0,30,0
	bc 12,2,.L162
	lwz 0,1072(31)
	stw 0,1072(30)
	stw 26,1072(31)
	lwz 31,1072(30)
	b .L158
.L162:
	mr 30,31
	lwz 31,1072(31)
	stw 26,1072(30)
	b .L199
.L161:
	lwz 3,540(29)
	mr 4,31
	bl visible
	mr. 3,3
	bc 4,2,.L164
	cmpwi 0,30,0
	bc 12,2,.L165
	lwz 0,1072(31)
	stw 0,1072(30)
	stw 3,1072(31)
	lwz 31,1072(30)
	b .L158
.L165:
	mr 30,31
	lwz 31,1072(31)
	stw 3,1072(30)
.L199:
	li 30,0
	mr 27,31
	b .L158
.L164:
	mr 30,31
	addi 25,25,1
	lwz 31,1072(31)
.L158:
	cmpwi 0,31,0
	bc 4,2,.L160
.L159:
	cmpwi 0,25,0
	bc 12,2,.L193
	lis 9,num_hint_paths@ha
	lwz 0,num_hint_paths@l(9)
	cmpwi 0,0,0
	bc 4,1,.L170
	mr 11,0
	addi 9,1,8
	li 0,0
.L172:
	addic. 11,11,-1
	stw 0,0(9)
	addi 9,9,4
	bc 4,2,.L172
.L170:
	mr. 31,27
	bc 12,2,.L175
	lis 9,num_hint_paths@ha
	li 10,1
	lwz 11,num_hint_paths@l(9)
	addi 9,1,8
.L176:
	lwz 0,1076(31)
	cmpwi 0,0,0
	bc 12,0,.L193
	cmpw 0,0,11
	bc 12,1,.L193
	slwi 0,0,2
	stwx 10,9,0
	lwz 31,1072(31)
	cmpwi 0,31,0
	bc 4,2,.L176
.L175:
	mr. 31,28
	li 28,0
	bc 12,2,.L181
	addi 26,1,8
.L182:
	lwz 0,1076(31)
	slwi 0,0,2
	lwzx 0,26,0
	cmpwi 0,0,0
	bc 4,2,.L183
	lwz 30,1068(31)
	stw 0,1068(31)
	mr 31,30
	b .L180
.L183:
	mr 3,29
	mr 4,31
	bl realrange
	fcmpu 0,1,30
	bc 4,0,.L184
	mr 28,31
.L184:
	lwz 31,1068(31)
.L180:
	cmpwi 0,31,0
	bc 4,2,.L182
.L181:
	cmpwi 0,28,0
	bc 12,2,.L193
	mr. 31,27
	mr 30,28
	lis 9,.LC18@ha
	li 28,0
	lfs 30,.LC18@l(9)
	bc 12,2,.L188
.L189:
	lwz 9,1076(30)
	lwz 0,1076(31)
	cmpw 0,9,0
	bc 4,2,.L190
	mr 3,29
	mr 4,31
	bl realrange
	fcmpu 0,1,30
	bc 4,0,.L190
	mr 28,31
.L190:
	lwz 31,1072(31)
	cmpwi 0,31,0
	bc 4,2,.L189
.L188:
	cmpwi 0,28,0
	bc 12,2,.L193
	stw 28,900(29)
	addi 3,1,408
	addi 4,1,424
	lfs 0,4(29)
	lfs 13,4(30)
	lfs 12,8(29)
	lfs 11,12(29)
	fsubs 13,13,0
	stfs 13,408(1)
	lfs 0,8(30)
	fsubs 0,0,12
	stfs 0,412(1)
	lfs 13,12(30)
	fsubs 13,13,11
	stfs 13,416(1)
	bl vectoangles2
	lwz 0,776(29)
	li 9,-117
	li 11,0
	lfs 0,428(1)
	lis 10,level+4@ha
	mr 3,29
	oris 0,0,0x10
	stw 30,412(29)
	and 0,0,9
	stw 11,828(29)
	lwz 9,804(29)
	stfs 0,424(29)
	stw 0,776(29)
	mtlr 9
	stw 30,416(29)
	lfs 0,level+4@l(10)
	stfs 0,848(29)
	blrl
	li 3,1
	b .L195
.L193:
	li 3,0
.L195:
	lwz 0,500(1)
	mtlr 0
	lmw 25,452(1)
	lfd 30,480(1)
	lfd 31,488(1)
	la 1,496(1)
	blr
.Lfe6:
	.size	 monsterlost_checkhint,.Lfe6-monsterlost_checkhint
	.section	".rodata"
	.align 2
.LC20:
	.long 0x4cbebc20
	.align 2
.LC21:
	.long 0x0
	.section	".text"
	.align 2
	.globl hint_path_touch
	.type	 hint_path_touch,@function
hint_path_touch:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 28,40(1)
	stw 0,68(1)
	mr 31,4
	mr 29,3
	lwz 0,416(31)
	li 28,0
	cmpw 0,0,29
	bc 4,2,.L200
	lwz 6,900(31)
	cmpw 0,6,29
	bc 4,2,.L202
	lis 9,level@ha
	stw 28,412(31)
	mr 3,31
	la 30,level@l(9)
	stw 28,416(31)
	lfs 0,4(30)
	lwz 0,776(31)
	stw 28,900(31)
	rlwinm 0,0,0,12,10
	stfs 0,896(31)
	stw 0,776(31)
	bl has_valid_enemy
	cmpwi 0,3,0
	bc 12,2,.L203
	lwz 4,540(31)
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L221
	b .L216
.L203:
	stw 28,540(31)
	lis 9,.LC20@ha
	mr 3,31
	lfs 13,.LC20@l(9)
	lfs 0,4(30)
	b .L222
.L220:
	lwz 30,1064(29)
	b .L206
.L202:
	lwz 0,1076(29)
	lis 9,hint_path_start@ha
	la 9,hint_path_start@l(9)
	slwi 0,0,2
	lwzx 8,9,0
	b .L207
.L212:
	mr 8,7
.L207:
	cmpwi 0,8,0
	bc 12,2,.L206
	cmpw 0,8,29
	bc 12,2,.L220
	xor 0,8,6
	lwz 7,1064(8)
	srawi 11,0,31
	xor 9,11,0
	subf 9,9,11
	xor 10,7,29
	subfic 0,10,0
	adde 10,0,10
	srawi 9,9,31
	addi 11,9,1
	and 9,28,9
	or 28,9,11
	addic 9,28,-1
	subfe 0,9,28
	and. 11,10,0
	bc 12,2,.L212
	mr 30,8
.L206:
	cmpwi 0,30,0
	bc 4,2,.L214
	lis 9,level@ha
	stw 30,412(31)
	mr 3,31
	la 29,level@l(9)
	stw 30,416(31)
	lfs 0,4(29)
	lwz 0,776(31)
	stw 30,900(31)
	rlwinm 0,0,0,12,10
	stfs 0,896(31)
	stw 0,776(31)
	bl has_valid_enemy
	cmpwi 0,3,0
	bc 12,2,.L215
	lwz 4,540(31)
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L216
.L221:
	mr 3,31
	bl FoundTarget
	b .L200
.L216:
	mr 3,31
	bl HuntTarget
	b .L200
.L215:
	stw 30,540(31)
	lis 9,.LC20@ha
	mr 3,31
	lfs 13,.LC20@l(9)
	lfs 0,4(29)
.L222:
	lwz 9,788(31)
	fadds 0,0,13
	mtlr 9
	stfs 0,828(31)
	blrl
	b .L200
.L214:
	lfs 0,4(31)
	lis 9,.LC21@ha
	addi 3,1,8
	lfs 13,4(30)
	la 9,.LC21@l(9)
	addi 4,1,24
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	lfs 31,0(9)
	stfs 13,8(1)
	lfs 0,8(30)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(30)
	fsubs 13,13,11
	stfs 13,16(1)
	bl vectoangles2
	lwz 0,776(31)
	lis 9,level@ha
	li 11,-117
	lfs 0,28(1)
	la 28,level@l(9)
	mr 3,31
	oris 0,0,0x10
	lwz 9,804(31)
	and 0,0,11
	stw 30,412(31)
	stfs 0,424(31)
	mtlr 9
	stw 0,776(31)
	stw 30,416(31)
	stfs 31,828(31)
	lfs 0,4(28)
	stfs 0,848(31)
	blrl
	lfs 13,592(29)
	fcmpu 0,13,31
	bc 12,2,.L200
	lfs 0,4(28)
	fadds 0,0,13
	stfs 0,428(31)
.L200:
	lwz 0,68(1)
	mtlr 0
	lmw 28,40(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe7:
	.size	 hint_path_touch,.Lfe7-hint_path_touch
	.section	".rodata"
	.align 2
.LC22:
	.string	"unlinked hint_path at %s\n"
	.align 2
.LC23:
	.string	"hint_path"
	.align 2
.LC24:
	.string	"Hint path at %s marked as endpoint with both target (%s) and targetname (%s)\n"
	.align 2
.LC25:
	.string	"\nForked hint path at %s detected for chain %d, target %s\n"
	.align 2
.LC26:
	.string	"\nCircular hint path at %s detected for chain %d, targetname %s\n"
	.section	".text"
	.align 2
	.globl InitHintPaths
	.type	 InitHintPaths,@function
InitHintPaths:
	stwu 1,-64(1)
	mflr 0
	stmw 21,20(1)
	stw 0,68(1)
	li 29,0
	lis 30,hint_paths_present@ha
	lis 5,.LC23@ha
	stw 29,hint_paths_present@l(30)
	li 3,0
	la 5,.LC23@l(5)
	li 4,280
	bl G_Find
	lis 26,.LC23@ha
	mr. 31,3
	bc 12,2,.L226
	lis 3,hint_path_start@ha
	li 0,1
	la 3,hint_path_start@l(3)
	stw 0,hint_paths_present@l(30)
	li 4,0
	mr 27,3
	li 5,400
	crxor 6,6,6
	bl memset
	lis 24,num_hint_paths@ha
	lis 28,.LC24@ha
	lis 11,num_hint_paths@ha
	lis 9,gi@ha
	la 30,gi@l(9)
	stw 29,num_hint_paths@l(11)
.L231:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L232
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L232
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L234
	addi 3,31,4
	bl vtos
	lwz 9,4(30)
	mr 4,3
	la 3,.LC24@l(28)
	lwz 5,296(31)
	lwz 6,300(31)
	mtlr 9
	crxor 6,6,6
	blrl
	b .L232
.L234:
	lwz 11,num_hint_paths@l(24)
	cmpwi 0,11,99
	bc 12,1,.L230
	slwi 0,11,2
	addi 9,11,1
	stwx 31,27,0
	stw 9,num_hint_paths@l(24)
.L232:
	mr 3,31
	li 4,280
	la 5,.LC23@l(26)
	bl G_Find
	mr. 31,3
	bc 4,2,.L231
.L230:
	lis 9,num_hint_paths@ha
	li 28,0
	lwz 0,num_hint_paths@l(9)
	cmpw 0,28,0
	bc 4,0,.L226
	lis 9,hint_path_start@ha
	lis 11,gi@ha
	la 25,hint_path_start@l(9)
	la 23,gi@l(11)
	lis 21,.LC25@ha
	li 22,0
.L241:
	slwi 0,28,2
	li 4,300
	lwzx 30,25,0
	mr 27,0
	li 3,0
	lwz 5,296(30)
	stw 28,1076(30)
	bl G_Find
	mr 31,3
	lwz 5,296(30)
	li 4,300
	bl G_Find
	cmpwi 0,3,0
	bc 12,2,.L242
	addi 3,30,4
	addi 26,28,1
	bl vtos
	lwz 9,4(23)
	mr 4,3
	lwz 6,296(30)
	la 3,.LC25@l(21)
	mtlr 9
	b .L253
.L251:
	addi 3,31,4
	bl vtos
	mr 4,3
	lwz 9,4(23)
	lis 3,.LC26@ha
	lwz 6,300(31)
	mtlr 9
	la 3,.LC26@l(3)
.L253:
	lwz 5,num_hint_paths@l(24)
	crxor 6,6,6
	blrl
	lwzx 9,25,27
	stw 22,1064(9)
	b .L240
.L252:
	addi 3,30,4
	bl vtos
	lwz 9,4(23)
	mr 4,3
	lwz 6,296(30)
	la 3,.LC25@l(21)
	mtlr 9
	lwz 5,num_hint_paths@l(24)
	crxor 6,6,6
	blrl
	lwzx 9,25,27
	stw 29,1064(9)
	b .L240
.L242:
	cmpwi 0,31,0
	addi 26,28,1
	bc 12,2,.L240
.L245:
	lwz 29,1064(31)
	cmpwi 0,29,0
	bc 4,2,.L251
	stw 31,1064(30)
	mr 30,31
	lwz 5,296(30)
	stw 28,1076(30)
	cmpwi 0,5,0
	bc 12,2,.L240
	li 4,300
	li 3,0
	bl G_Find
	mr 31,3
	lwz 5,296(30)
	li 4,300
	bl G_Find
	cmpwi 0,3,0
	bc 4,2,.L252
	cmpwi 0,31,0
	bc 4,2,.L245
.L240:
	lwz 0,num_hint_paths@l(24)
	mr 28,26
	cmpw 0,28,0
	bc 12,0,.L241
.L226:
	lwz 0,68(1)
	mtlr 0
	lmw 21,20(1)
	la 1,64(1)
	blr
.Lfe8:
	.size	 InitHintPaths,.Lfe8-InitHintPaths
	.section	".rodata"
	.align 2
.LC28:
	.string	"bad_area"
	.align 2
.LC29:
	.long 0x0
	.align 2
.LC30:
	.long 0x3f000000
	.align 2
.LC31:
	.long 0x43000000
	.align 2
.LC32:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl MarkTeslaArea
	.type	 MarkTeslaArea,@function
MarkTeslaArea:
	stwu 1,-96(1)
	mflr 0
	mfcr 12
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 28,64(1)
	stw 0,100(1)
	stw 12,60(1)
	subfic 0,3,0
	adde 3,0,3
	mr 30,4
	subfic 9,30,0
	adde 0,9,30
	or. 11,0,3
	bc 12,2,.L273
.L295:
	li 3,0
	b .L293
.L273:
	lwz 29,560(30)
	mr 28,30
	lis 31,.LC28@ha
	cmpwi 0,29,0
	bc 12,2,.L275
.L276:
	lwz 3,280(29)
	la 4,.LC28@l(31)
	lwz 28,560(28)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L295
	lwz 29,560(29)
	cmpwi 0,29,0
	bc 4,2,.L276
.L275:
	lwz 9,560(30)
	cmpwi 0,9,0
	bc 12,2,.L279
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L279
	lfs 12,212(9)
	lis 11,.LC29@ha
	la 11,.LC29@l(11)
	lfs 30,0(11)
	stfs 12,8(1)
	lfs 0,216(9)
	stfs 0,12(1)
	lfs 13,220(9)
	stfs 13,16(1)
	lfs 13,224(9)
	stfs 13,24(1)
	lfs 11,228(9)
	stfs 11,28(1)
	lfs 10,232(9)
	stfs 10,32(1)
	lfs 31,404(30)
	fcmpu 4,31,30
	bc 12,18,.L280
	fadds 13,12,13
	addi 29,1,8
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	addi 3,1,40
	lfs 1,0(9)
	mr 4,3
	stfs 13,40(1)
	lfs 0,4(29)
	fadds 0,0,11
	stfs 0,44(1)
	lfs 13,8(29)
	fadds 13,13,10
	stfs 13,48(1)
	bl VectorScale
	lfs 12,24(1)
	lfs 9,40(1)
	lfs 11,28(1)
	lfs 8,44(1)
	lfs 13,32(1)
	fsubs 12,12,9
	lfs 0,8(1)
	lfs 10,48(1)
	fsubs 11,11,8
	stfs 12,24(1)
	fsubs 0,0,9
	fsubs 13,13,10
	stfs 11,28(1)
	stfs 0,8(1)
	stfs 13,32(1)
	lfs 0,4(29)
	lfs 12,8(29)
	fsubs 0,0,8
	stfs 0,4(29)
	lfs 13,48(1)
	fsubs 12,12,13
	stfs 12,8(29)
	bl G_Spawn
	lfs 0,40(1)
	mr 31,3
	lis 9,badarea_touch@ha
	lis 11,.LC28@ha
	li 0,1
	la 9,badarea_touch@l(9)
	la 11,.LC28@l(11)
	stfs 0,4(31)
	li 10,0
	lis 8,gi+72@ha
	lfs 13,44(1)
	stfs 13,8(31)
	lfs 0,48(1)
	stfs 0,12(31)
	lfs 13,24(1)
	stfs 13,200(31)
	lfs 0,28(1)
	stfs 0,204(31)
	lfs 13,32(1)
	stfs 13,208(31)
	lfs 0,8(1)
	stfs 0,188(31)
	lfs 13,4(29)
	stfs 13,192(31)
	lfs 0,8(29)
	stw 9,444(31)
	stw 10,260(31)
	stfs 0,196(31)
	stw 0,248(31)
	stw 11,280(31)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	bc 12,18,.L281
	lis 9,G_FreeEdict@ha
	lis 11,level+4@ha
	la 9,G_FreeEdict@l(9)
	stw 9,436(31)
	lfs 0,level+4@l(11)
	fadds 0,0,31
	stfs 0,428(31)
.L281:
	cmpwi 0,30,0
	b .L296
.L280:
	fadds 13,12,13
	lfs 31,428(30)
	addi 29,1,8
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	addi 3,1,40
	lfs 1,0(9)
	mr 4,3
	stfs 13,40(1)
	lfs 0,4(29)
	fadds 0,0,11
	stfs 0,44(1)
	lfs 13,8(29)
	fadds 13,13,10
	stfs 13,48(1)
	bl VectorScale
	lfs 12,24(1)
	lfs 9,40(1)
	lfs 11,28(1)
	lfs 8,44(1)
	lfs 13,32(1)
	fsubs 12,12,9
	lfs 0,8(1)
	lfs 10,48(1)
	fsubs 11,11,8
	stfs 12,24(1)
	fsubs 0,0,9
	fsubs 13,13,10
	stfs 11,28(1)
	stfs 0,8(1)
	stfs 13,32(1)
	lfs 0,4(29)
	lfs 12,8(29)
	fsubs 0,0,8
	stfs 0,4(29)
	lfs 13,48(1)
	fsubs 12,12,13
	stfs 12,8(29)
	bl G_Spawn
	lfs 0,40(1)
	mr 31,3
	lis 9,badarea_touch@ha
	lis 11,.LC28@ha
	la 9,badarea_touch@l(9)
	la 11,.LC28@l(11)
	li 10,0
	stfs 0,4(31)
	li 0,1
	lis 8,gi+72@ha
	lfs 13,44(1)
	stfs 13,8(31)
	lfs 0,48(1)
	stfs 0,12(31)
	lfs 13,24(1)
	stfs 13,200(31)
	lfs 0,28(1)
	stfs 0,204(31)
	lfs 13,32(1)
	stfs 13,208(31)
	lfs 0,8(1)
	stfs 0,188(31)
	lfs 13,4(29)
	stfs 13,192(31)
	lfs 0,8(29)
	stw 9,444(31)
	stw 10,260(31)
	stfs 0,196(31)
	stw 0,248(31)
	stw 11,280(31)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	fcmpu 0,31,30
	bc 12,2,.L285
	lis 9,G_FreeEdict@ha
	lis 11,level+4@ha
	la 9,G_FreeEdict@l(9)
	stw 9,436(31)
	lfs 0,level+4@l(11)
	fadds 0,0,31
	stfs 0,428(31)
.L285:
	cmpwi 0,30,0
	b .L296
.L279:
	lis 0,0xc300
	lis 9,.LC31@ha
	stw 0,12(1)
	la 9,.LC31@l(9)
	addi 29,1,8
	stw 0,8(1)
	lis 11,.LC30@ha
	addi 3,1,40
	lfs 0,196(30)
	la 11,.LC30@l(11)
	mr 4,3
	lfs 12,0(9)
	li 9,0
	lfs 1,0(11)
	stw 9,40(1)
	lis 11,.LC32@ha
	stfs 12,24(1)
	la 11,.LC32@l(11)
	stfs 12,28(1)
	stfs 12,32(1)
	stfs 0,16(1)
	lfs 0,4(29)
	lfs 31,0(11)
	fadds 0,0,12
	stfs 0,44(1)
	lfs 13,8(29)
	fadds 13,13,12
	stfs 13,48(1)
	bl VectorScale
	lfs 12,24(1)
	lfs 9,40(1)
	lfs 11,28(1)
	lfs 8,44(1)
	lfs 13,32(1)
	fsubs 12,12,9
	lfs 0,8(1)
	lfs 10,48(1)
	fsubs 11,11,8
	stfs 12,24(1)
	fsubs 0,0,9
	fsubs 13,13,10
	stfs 11,28(1)
	stfs 0,8(1)
	stfs 13,32(1)
	lfs 0,4(29)
	lfs 12,8(29)
	fsubs 0,0,8
	stfs 0,4(29)
	lfs 13,48(1)
	fsubs 12,12,13
	stfs 12,8(29)
	bl G_Spawn
	lfs 0,40(1)
	mr 31,3
	lis 9,badarea_touch@ha
	lis 11,.LC28@ha
	la 9,badarea_touch@l(9)
	la 11,.LC28@l(11)
	li 10,0
	stfs 0,4(31)
	li 0,1
	lis 8,gi+72@ha
	lfs 13,44(1)
	stfs 13,8(31)
	lfs 0,48(1)
	stfs 0,12(31)
	lfs 13,24(1)
	stfs 13,200(31)
	lfs 0,28(1)
	stfs 0,204(31)
	lfs 13,32(1)
	stfs 13,208(31)
	lfs 0,8(1)
	stfs 0,188(31)
	lfs 13,4(29)
	stfs 13,192(31)
	lfs 0,8(29)
	stw 9,444(31)
	stw 11,280(31)
	stfs 0,196(31)
	stw 10,260(31)
	stw 0,248(31)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	lis 9,G_FreeEdict@ha
	lis 11,level+4@ha
	la 9,G_FreeEdict@l(9)
	cmpwi 0,30,0
	stw 9,436(31)
	lfs 0,level+4@l(11)
	fadds 0,0,31
	stfs 0,428(31)
.L296:
	bc 12,2,.L290
	stw 30,256(31)
.L290:
	mr 3,31
	cmpwi 0,3,0
	bc 12,2,.L292
	stw 3,560(28)
.L292:
	li 3,1
.L293:
	lwz 0,100(1)
	lwz 12,60(1)
	mtlr 0
	lmw 28,64(1)
	lfd 30,80(1)
	lfd 31,88(1)
	mtcrf 8,12
	la 1,96(1)
	blr
.Lfe9:
	.size	 MarkTeslaArea,.Lfe9-MarkTeslaArea
	.section	".rodata"
	.align 2
.LC34:
	.long 1
	.long 2
	.long 4
	.long 1
	.long 2
	.long 7
	.long 1
	.long 4
	.long 5
	.long 2
	.long 4
	.long 7
	.align 2
.LC35:
	.long 0
	.long 3
	.long 5
	.long 6
	.align 2
.LC36:
	.long 0x42480000
	.section	".text"
	.align 2
	.globl drawbbox
	.type	 drawbbox,@function
drawbbox:
	stwu 1,-352(1)
	mflr 0
	stmw 17,292(1)
	stw 0,356(1)
	mr 29,3
	lis 4,.LC34@ha
	addi 3,1,8
	la 4,.LC34@l(4)
	li 5,48
	mr 17,3
	addi 22,1,264
	addi 24,29,4
	crxor 6,6,6
	bl memcpy
	addi 18,29,16
	lis 9,.LC35@ha
	lfs 9,212(29)
	addi 11,1,56
	lwz 8,.LC35@l(9)
	addi 3,1,72
	addi 21,1,216
	lfs 10,216(29)
	la 9,.LC35@l(9)
	addi 20,1,232
	lfs 11,220(29)
	addi 31,1,76
	mr 27,3
	lfs 12,224(29)
	addi 25,1,172
	addi 4,1,80
	stw 8,56(1)
	addi 30,1,176
	addi 26,1,180
	lfs 0,228(29)
	mr 12,11
	li 5,0
	lfs 13,232(29)
	addi 19,1,248
	addi 23,1,200
	lwz 7,12(9)
	addi 6,1,168
	lwz 10,4(9)
	lwz 0,8(9)
	stw 10,4(11)
	stw 0,8(11)
	stw 7,12(11)
	stfs 9,168(1)
	stfs 10,172(1)
	stfs 11,176(1)
	stfs 12,180(1)
	stfs 0,184(1)
	stfs 13,188(1)
.L310:
	li 28,0
	mr 8,25
	slwi 7,5,2
.L314:
	mulli 9,7,12
	li 10,0
	mr 11,30
.L318:
	lfs 0,0(6)
	addi 10,10,1
	cmpwi 0,10,1
	stfsx 0,9,27
	lfs 13,0(8)
	stfsx 13,9,31
	lfs 0,0(11)
	addi 11,11,12
	stfsx 0,9,4
	addi 9,9,12
	bc 4,1,.L318
	addi 28,28,1
	addi 8,8,12
	cmpwi 0,28,1
	addi 7,7,2
	bc 4,1,.L314
	addi 6,6,12
	addi 5,5,1
	cmpw 0,6,26
	bc 4,1,.L310
	lis 9,gi@ha
	mr 27,3
	la 31,gi@l(9)
	mr 26,12
	li 5,0
.L325:
	mulli 0,5,12
	slwi 30,5,2
	addi 25,5,1
	li 28,3
	add 29,0,17
.L329:
	lwz 9,100(31)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(31)
	li 3,34
	mtlr 9
	blrl
	lwzx 3,26,30
	lwz 9,120(31)
	mulli 3,3,12
	mtlr 9
	add 3,27,3
	blrl
	lwz 3,0(29)
	lwz 9,120(31)
	addi 29,29,4
	mulli 3,3,12
	mtlr 9
	add 3,27,3
	blrl
	lwzx 3,26,30
	li 4,0
	lwz 9,88(31)
	mulli 3,3,12
	mtlr 9
	add 3,27,3
	blrl
	addic. 28,28,-1
	bc 4,2,.L329
	mr 5,25
	cmpwi 0,5,3
	bc 4,1,.L325
	mr 3,18
	mr 4,22
	bl vectoangles2
	li 28,0
	mr 6,19
	mr 3,22
	mr 4,21
	mr 5,20
	bl AngleVectors
	lis 9,.LC36@ha
	mr 5,23
	la 9,.LC36@l(9)
	mr 4,21
	lfs 1,0(9)
	mr 3,24
	bl VectorMA
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,34
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,24
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,23
	mtlr 9
	blrl
	lwz 9,88(29)
	mr 3,24
	li 4,2
	mtlr 9
	blrl
	lis 9,.LC36@ha
	stw 28,208(1)
	mr 5,23
	la 9,.LC36@l(9)
	stw 28,204(1)
	mr 4,20
	lfs 1,0(9)
	mr 3,24
	stw 28,200(1)
	bl VectorMA
	lwz 9,100(29)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,34
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,24
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,23
	mtlr 9
	blrl
	lwz 9,88(29)
	mr 3,24
	li 4,2
	mtlr 9
	blrl
	lis 9,.LC36@ha
	mr 4,19
	stw 28,208(1)
	la 9,.LC36@l(9)
	mr 5,23
	stw 28,204(1)
	lfs 1,0(9)
	mr 3,24
	stw 28,200(1)
	bl VectorMA
	lwz 9,100(29)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,34
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,24
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,23
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,24
	li 4,2
	mtlr 0
	blrl
	stw 28,200(1)
	stw 28,208(1)
	stw 28,204(1)
	lwz 0,356(1)
	mtlr 0
	lmw 17,292(1)
	la 1,352(1)
	blr
.Lfe10:
	.size	 drawbbox,.Lfe10-drawbbox
	.section	".rodata"
	.align 2
.LC37:
	.long 0x46fffe00
	.align 3
.LC38:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC39:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC40:
	.long 0x40a00000
	.align 2
.LC41:
	.long 0x3f800000
	.align 3
.LC42:
	.long 0x3fd00000
	.long 0x0
	.align 2
.LC43:
	.long 0x42000000
	.align 2
.LC44:
	.long 0x0
	.section	".text"
	.align 2
	.globl M_MonsterDodge
	.type	 M_MonsterDodge,@function
M_MonsterDodge:
	stwu 1,-80(1)
	mflr 0
	mfcr 12
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 29,52(1)
	stw 0,84(1)
	stw 12,48(1)
	mr 31,3
	mr 29,4
	fmr 31,1
	mr 30,5
	bl rand
	rlwinm 3,3,0,17,31
	lwz 10,480(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,44(1)
	lis 11,.LC39@ha
	cmpwi 0,10,0
	la 11,.LC39@l(11)
	stw 0,40(1)
	li 10,0
	lfd 12,0(11)
	lfd 0,40(1)
	lis 11,.LC37@ha
	lfs 13,.LC37@l(11)
	li 9,0
	fsub 0,0,12
	frsp 0,0
	fdivs 30,0,13
	bc 4,1,.L332
	lwz 0,920(31)
	cmpwi 0,0,0
	bc 12,2,.L334
	lwz 0,924(31)
	addic 11,0,-1
	subfe 10,11,0
.L334:
	lwz 0,928(31)
	cmpwi 0,0,0
	bc 12,2,.L335
	lwz 0,776(31)
	rlwinm 0,0,0,31,31
	xori 9,0,1
.L335:
	cmpwi 0,10,0
	cmpwi 7,9,0
	mcrf 4,0
	mfcr 0
	rlwinm 9,0,3,1
	rlwinm 0,0,31,1
	mcrf 3,7
	and. 11,9,0
	bc 4,2,.L332
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L337
	stw 29,540(31)
	mr 3,31
	bl FoundTarget
.L337:
	lis 11,.LC40@ha
	lis 9,.LC38@ha
	fmr 12,31
	la 11,.LC40@l(11)
	lfd 0,.LC38@l(9)
	lfs 13,0(11)
	fcmpu 6,12,0
	fcmpu 7,31,13
	mfcr 9
	rlwinm 0,9,25,1
	rlwinm 9,9,30,1
	or. 11,0,9
	bc 4,2,.L332
	lis 9,.LC41@ha
	lis 11,skill@ha
	fmr 12,30
	la 9,.LC41@l(9)
	lfs 11,0(9)
	lwz 9,skill@l(11)
	lis 11,.LC42@ha
	lfs 0,20(9)
	la 11,.LC42@l(11)
	lfd 13,0(11)
	fadds 0,0,11
	fmul 0,0,13
	fcmpu 0,12,0
	bc 12,1,.L332
	bc 12,18,.L340
	lis 9,.LC43@ha
	lfs 0,232(31)
	la 9,.LC43@l(9)
	lfs 13,0(9)
	fsubs 0,0,13
	fsubs 13,0,11
	bc 4,14,.L353
	lfs 0,20(30)
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L332
	lwz 0,776(31)
	andi. 11,0,2048
	bc 4,2,.L332
	b .L343
.L340:
	lfs 13,232(31)
.L343:
	bc 12,14,.L344
.L353:
	lwz 0,776(31)
	andis. 29,0,0x4
	bc 4,2,.L332
	lfs 0,20(30)
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L347
	andi. 9,0,2048
	bc 12,2,.L344
.L347:
	addi 3,31,16
	li 4,0
	addi 5,1,8
	li 6,0
	bl AngleVectors
	lfs 0,8(31)
	lis 9,.LC44@ha
	lfs 8,16(30)
	la 9,.LC44@l(9)
	lfs 13,4(31)
	lfs 9,12(30)
	fsubs 8,8,0
	lfs 12,12(1)
	lfs 11,20(30)
	fsubs 9,9,13
	lfs 10,12(31)
	fmuls 12,12,8
	lfs 13,8(1)
	lfs 0,16(1)
	fsubs 11,11,10
	lfs 7,0(9)
	fmadds 13,13,9,12
	stfs 9,24(1)
	stfs 8,28(1)
	stfs 11,32(1)
	fmadds 0,0,11,13
	fcmpu 0,0,7
	bc 4,0,.L348
	stw 29,872(31)
	b .L349
.L348:
	li 0,1
	stw 0,872(31)
.L349:
	bc 12,18,.L350
	lwz 0,776(31)
	andi. 11,0,2048
	bc 12,2,.L350
	lwz 9,924(31)
	mr 3,31
	mtlr 9
	blrl
.L350:
	lwz 10,928(31)
	mr 3,31
	li 9,2
	lwz 0,776(31)
	mtlr 10
	stw 9,868(31)
	oris 0,0,0x4
	stw 0,776(31)
	blrl
	b .L332
.L344:
	bc 12,18,.L332
	lis 9,level+4@ha
	lfs 13,936(31)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 12,1,.L332
	mr 3,31
	bl monster_done_dodge
	lwz 11,920(31)
	mr 3,31
	fmr 1,31
	lwz 0,776(31)
	mtlr 11
	ori 0,0,2048
	stw 0,776(31)
	blrl
.L332:
	lwz 0,84(1)
	lwz 12,48(1)
	mtlr 0
	lmw 29,52(1)
	lfd 30,64(1)
	lfd 31,72(1)
	mtcrf 24,12
	la 1,80(1)
	blr
.Lfe11:
	.size	 M_MonsterDodge,.Lfe11-M_MonsterDodge
	.section	".rodata"
	.align 2
.LC45:
	.long 0x46fffe00
	.align 2
.LC46:
	.long 0x0
	.align 3
.LC47:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl PickCoopTarget
	.type	 PickCoopTarget,@function
PickCoopTarget:
	stwu 1,-80(1)
	mflr 0
	stmw 23,44(1)
	stw 0,84(1)
	lis 9,coop@ha
	mr 26,3
	lwz 9,coop@l(9)
	li 28,0
	cmpwi 0,9,0
	bc 12,2,.L388
	lis 8,.LC46@ha
	lfs 13,20(9)
	la 8,.LC46@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 12,2,.L388
	addi 3,1,8
	li 4,0
	mr 23,3
	li 5,16
	crxor 6,6,6
	bl memset
	li 29,1
	lis 9,game@ha
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,29,0
	bc 12,1,.L378
	mr 24,9
	lis 25,g_edicts@ha
	li 27,1084
	mr 30,23
.L380:
	lwz 0,g_edicts@l(25)
	add 31,0,27
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L379
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L379
	mr 3,26
	mr 4,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L391
	lwz 4,324(31)
	cmpwi 0,4,0
	bc 12,2,.L379
	mr 3,26
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L379
.L391:
	stw 31,0(30)
	addi 28,28,1
	addi 30,30,4
.L379:
	lwz 0,1544(24)
	addi 29,29,1
	addi 27,27,1084
	cmpw 0,29,0
	bc 4,1,.L380
.L378:
	cmpwi 0,28,0
	bc 12,2,.L388
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 7,0x4330
	stw 3,36(1)
	lis 8,.LC47@ha
	mr 11,10
	stw 7,32(1)
	la 8,.LC47@l(8)
	xoris 0,28,0x8000
	lfd 12,0(8)
	mr 9,10
	lfd 0,32(1)
	lis 8,.LC45@ha
	lfs 10,.LC45@l(8)
	stw 0,36(1)
	fsub 0,0,12
	stw 7,32(1)
	lfd 13,32(1)
	frsp 0,0
	fsub 13,13,12
	fdivs 0,0,10
	frsp 13,13
	fmuls 0,0,13
	fmr 12,0
	fctiwz 11,12
	stfd 11,32(1)
	lwz 9,36(1)
	xor 10,9,28
	addi 11,9,-1
	srawi 8,10,31
	xor 0,8,10
	subf 0,0,8
	srawi 0,0,31
	andc 11,11,0
	and 9,9,0
	or 9,9,11
	slwi 9,9,2
	lwzx 3,23,9
	b .L390
.L388:
	li 3,0
.L390:
	lwz 0,84(1)
	mtlr 0
	lmw 23,44(1)
	la 1,80(1)
	blr
.Lfe12:
	.size	 PickCoopTarget,.Lfe12-PickCoopTarget
	.align 2
	.globl blocked_checknewenemy
	.type	 blocked_checknewenemy,@function
blocked_checknewenemy:
	li 3,0
	blr
.Lfe13:
	.size	 blocked_checknewenemy,.Lfe13-blocked_checknewenemy
	.section	".rodata"
	.align 3
.LC48:
	.long 0xbfd33333
	.long 0x33333333
	.section	".text"
	.align 2
	.globl inback
	.type	 inback,@function
inback:
	stwu 1,-64(1)
	mflr 0
	stmw 28,48(1)
	stw 0,68(1)
	mr 29,3
	mr 28,4
	addi 4,1,24
	addi 3,29,16
	li 5,0
	li 6,0
	bl AngleVectors
	lfs 11,12(29)
	addi 3,1,8
	lfs 12,12(28)
	lfs 10,4(29)
	lfs 13,4(28)
	fsubs 12,12,11
	lfs 0,8(28)
	lfs 11,8(29)
	fsubs 13,13,10
	stfs 12,16(1)
	fsubs 0,0,11
	stfs 13,8(1)
	stfs 0,12(1)
	bl VectorNormalize
	lfs 0,28(1)
	lis 9,.LC48@ha
	lfs 11,12(1)
	lfs 12,8(1)
	lfs 10,24(1)
	fmuls 11,11,0
	lfs 9,32(1)
	lfs 0,16(1)
	lfd 13,.LC48@l(9)
	fmadds 12,12,10,11
	fmadds 0,0,9,12
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,29,1
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe14:
	.size	 inback,.Lfe14-inback
	.align 2
	.globl realrange
	.type	 realrange,@function
realrange:
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
.Lfe15:
	.size	 realrange,.Lfe15-realrange
	.section	".rodata"
	.align 2
.LC49:
	.long 0x3f000000
	.align 2
.LC50:
	.long 0x0
	.section	".text"
	.align 2
	.globl SpawnBadArea
	.type	 SpawnBadArea,@function
SpawnBadArea:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	mr 28,3
	mr 29,4
	fmr 31,1
	lfs 11,0(29)
	lis 9,.LC49@ha
	addi 3,1,8
	lfs 12,0(28)
	la 9,.LC49@l(9)
	mr 4,3
	lfs 10,4(29)
	mr 30,5
	lfs 13,4(28)
	fadds 12,12,11
	lfs 0,8(28)
	lfs 11,8(29)
	fadds 13,13,10
	lfs 1,0(9)
	stfs 12,8(1)
	fadds 0,0,11
	stfs 13,12(1)
	stfs 0,16(1)
	bl VectorScale
	lfs 11,8(1)
	lfs 10,12(1)
	lfs 9,16(1)
	lfs 0,0(29)
	lfs 13,4(29)
	lfs 12,8(29)
	fsubs 0,0,11
	fsubs 13,13,10
	fsubs 12,12,9
	stfs 0,0(29)
	stfs 13,4(29)
	stfs 12,8(29)
	lfs 0,0(28)
	lfs 13,4(28)
	lfs 12,8(28)
	fsubs 0,0,11
	fsubs 13,13,10
	fsubs 12,12,9
	stfs 0,0(28)
	stfs 13,4(28)
	stfs 12,8(28)
	bl G_Spawn
	lfs 0,8(1)
	mr 31,3
	lis 9,badarea_touch@ha
	lis 11,.LC28@ha
	la 9,badarea_touch@l(9)
	la 11,.LC28@l(11)
	li 10,0
	stfs 0,4(31)
	li 0,1
	lis 8,gi+72@ha
	lfs 13,12(1)
	stfs 13,8(31)
	lfs 0,16(1)
	stfs 0,12(31)
	lfs 13,0(29)
	stfs 13,200(31)
	lfs 0,4(29)
	stfs 0,204(31)
	lfs 13,8(29)
	stfs 13,208(31)
	lfs 0,0(28)
	stfs 0,188(31)
	lfs 13,4(28)
	stfs 13,192(31)
	lfs 0,8(28)
	stw 9,444(31)
	stw 10,260(31)
	stfs 0,196(31)
	stw 0,248(31)
	stw 11,280(31)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 12,2,.L262
	lis 9,G_FreeEdict@ha
	lis 11,level+4@ha
	la 9,G_FreeEdict@l(9)
	stw 9,436(31)
	lfs 0,level+4@l(11)
	fadds 0,0,31
	stfs 0,428(31)
.L262:
	cmpwi 0,30,0
	bc 12,2,.L263
	stw 30,256(31)
.L263:
	mr 3,31
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe16:
	.size	 SpawnBadArea,.Lfe16-SpawnBadArea
	.align 2
	.globl CheckForBadArea
	.type	 CheckForBadArea,@function
CheckForBadArea:
	stwu 1,-4144(1)
	mflr 0
	stw 0,4148(1)
	mr 9,3
	lis 11,gi+80@ha
	lfs 8,4(9)
	addi 3,1,4104
	addi 4,1,4120
	lfs 11,8(9)
	addi 5,1,8
	li 6,1024
	lfs 0,12(9)
	li 7,2
	lfs 6,208(9)
	lfs 13,188(9)
	lfs 12,192(9)
	lfs 7,196(9)
	fadds 6,0,6
	lfs 10,200(9)
	fadds 13,8,13
	lfs 9,204(9)
	fadds 12,11,12
	lwz 0,gi+80@l(11)
	fadds 0,0,7
	fadds 8,8,10
	stfs 13,4104(1)
	fadds 11,11,9
	mtlr 0
	stfs 12,4108(1)
	stfs 0,4112(1)
	stfs 8,4120(1)
	stfs 11,4124(1)
	stfs 6,4128(1)
	blrl
	mr 8,3
	li 11,0
	cmpw 0,11,8
	bc 4,0,.L266
	lis 9,badarea_touch@ha
	addi 10,1,8
	la 9,badarea_touch@l(9)
.L268:
	lwz 3,0(10)
	addi 10,10,4
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L267
	lwz 0,444(3)
	cmpw 0,0,9
	bc 12,2,.L406
.L267:
	addi 11,11,1
	cmpw 0,11,8
	bc 12,0,.L268
.L266:
	li 3,0
.L406:
	lwz 0,4148(1)
	mtlr 0
	la 1,4144(1)
	blr
.Lfe17:
	.size	 CheckForBadArea,.Lfe17-CheckForBadArea
	.section	".rodata"
	.align 3
.LC51:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl PredictAim
	.type	 PredictAim,@function
PredictAim:
	stwu 1,-96(1)
	mflr 0
	mfcr 12
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 28,64(1)
	stw 0,100(1)
	stw 12,60(1)
	mr. 31,3
	mr 29,4
	fmr 31,1
	fmr 30,2
	mr 30,6
	mr 28,7
	bc 12,2,.L299
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 4,2,.L298
.L299:
	lis 9,vec3_origin@ha
	lfs 13,vec3_origin@l(9)
	la 9,vec3_origin@l(9)
	stfs 13,0(30)
	lfs 0,4(9)
	stfs 0,4(30)
	lfs 13,8(9)
	stfs 13,8(30)
	b .L297
.L298:
	lfs 0,0(29)
	cmpwi 4,5,0
	lfs 13,4(31)
	lfs 12,4(29)
	lfs 11,8(29)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(31)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(31)
	fsubs 12,13,11
	stfs 12,16(1)
	bc 12,18,.L300
	lwz 0,508(31)
	lis 11,0x4330
	lis 10,.LC51@ha
	xoris 0,0,0x8000
	la 10,.LC51@l(10)
	stw 0,52(1)
	stw 11,48(1)
	lfd 13,0(10)
	lfd 0,48(1)
	fsub 0,0,13
	frsp 0,0
	fadds 0,12,0
	stfs 0,16(1)
.L300:
	addi 3,1,8
	bl VectorLength
	fdivs 1,1,31
	addi 3,31,4
	addi 4,31,376
	addi 5,1,24
	fsubs 1,1,30
	bl VectorMA
	bc 12,18,.L301
	lwz 0,508(31)
	lis 11,0x4330
	lis 10,.LC51@ha
	lfs 13,32(1)
	xoris 0,0,0x8000
	la 10,.LC51@l(10)
	stw 0,52(1)
	stw 11,48(1)
	lfd 12,0(10)
	lfd 0,48(1)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,32(1)
.L301:
	cmpwi 0,30,0
	bc 12,2,.L302
	lfs 13,0(29)
	mr 3,30
	lfs 0,24(1)
	lfs 12,28(1)
	lfs 11,32(1)
	fsubs 0,0,13
	stfs 0,0(30)
	lfs 13,4(29)
	fsubs 12,12,13
	stfs 12,4(30)
	lfs 0,8(29)
	fsubs 11,11,0
	stfs 11,8(30)
	bl VectorNormalize
.L302:
	cmpwi 0,28,0
	bc 12,2,.L297
	lfs 0,24(1)
	lfs 12,28(1)
	lfs 13,32(1)
	stfs 0,0(28)
	stfs 12,4(28)
	stfs 13,8(28)
.L297:
	lwz 0,100(1)
	lwz 12,60(1)
	mtlr 0
	lmw 28,64(1)
	lfd 30,80(1)
	lfd 31,88(1)
	mtcrf 8,12
	la 1,96(1)
	blr
.Lfe18:
	.size	 PredictAim,.Lfe18-PredictAim
	.section	".rodata"
	.align 3
.LC52:
	.long 0x3fee6666
	.long 0x66666666
	.align 2
.LC53:
	.long 0x0
	.section	".text"
	.align 2
	.globl below
	.type	 below,@function
below:
	stwu 1,-48(1)
	mflr 0
	stw 0,52(1)
	mr 9,3
	lfs 12,12(4)
	lfs 11,12(9)
	addi 3,1,8
	lfs 10,4(9)
	lfs 13,4(4)
	fsubs 12,12,11
	lfs 0,8(4)
	lfs 11,8(9)
	fsubs 13,13,10
	stfs 12,16(1)
	fsubs 0,0,11
	stfs 13,8(1)
	stfs 0,12(1)
	bl VectorNormalize
	lis 9,.LC53@ha
	lfs 11,12(1)
	lis 0,0xbf80
	la 9,.LC53@l(9)
	lfs 0,8(1)
	lfs 12,0(9)
	lfs 13,16(1)
	lis 9,.LC52@ha
	lfd 10,.LC52@l(9)
	fmuls 11,11,12
	stw 0,32(1)
	fneg 13,13
	stfs 12,24(1)
	stfs 12,28(1)
	fmadds 0,0,12,11
	fadds 0,0,13
	fcmpu 7,0,10
	mfcr 3
	rlwinm 3,3,30,1
	lwz 0,52(1)
	mtlr 0
	la 1,48(1)
	blr
.Lfe19:
	.size	 below,.Lfe19-below
	.section	".rodata"
	.align 2
.LC54:
	.long 0x42000000
	.align 2
.LC55:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl monster_duck_down
	.type	 monster_duck_down,@function
monster_duck_down:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC54@ha
	lfs 0,932(3)
	lis 11,level+4@ha
	la 9,.LC54@l(9)
	lwz 0,776(3)
	lfs 13,0(9)
	li 9,1
	ori 0,0,2048
	stw 9,512(3)
	fsubs 0,0,13
	stw 0,776(3)
	lfs 13,940(3)
	stfs 0,208(3)
	lfs 12,level+4@l(11)
	fcmpu 0,13,12
	bc 4,0,.L355
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 0,0(9)
	fadds 0,12,0
	stfs 0,940(3)
.L355:
	lis 9,gi+72@ha
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe20:
	.size	 monster_duck_down,.Lfe20-monster_duck_down
	.align 2
	.globl monster_duck_hold
	.type	 monster_duck_hold,@function
monster_duck_hold:
	lis 9,level+4@ha
	lfs 0,940(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L357
	lwz 0,776(3)
	rlwinm 0,0,0,25,23
	stw 0,776(3)
	blr
.L357:
	lwz 0,776(3)
	ori 0,0,128
	stw 0,776(3)
	blr
.Lfe21:
	.size	 monster_duck_hold,.Lfe21-monster_duck_hold
	.section	".rodata"
	.align 3
.LC56:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl monster_duck_up
	.type	 monster_duck_up,@function
monster_duck_up:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	li 11,2
	lwz 0,776(9)
	lis 10,level+4@ha
	lis 8,.LC56@ha
	lfs 12,932(9)
	la 8,.LC56@l(8)
	rlwinm 0,0,0,21,19
	stw 11,512(9)
	stw 0,776(9)
	stfs 12,208(9)
	lfs 0,level+4@l(10)
	lfd 13,0(8)
	lis 8,gi+72@ha
	fadd 0,0,13
	frsp 0,0
	stfs 0,936(9)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe22:
	.size	 monster_duck_up,.Lfe22-monster_duck_up
	.align 2
	.globl has_valid_enemy
	.type	 has_valid_enemy,@function
has_valid_enemy:
	lwz 9,540(3)
	cmpwi 0,9,0
	bc 4,2,.L361
	li 3,0
	blr
.L361:
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L362
	lwz 0,480(9)
	srawi 3,0,31
	subf 3,0,3
	srwi 3,3,31
	blr
.L362:
	li 3,0
	blr
.Lfe23:
	.size	 has_valid_enemy,.Lfe23-has_valid_enemy
	.align 2
	.globl TargetTesla
	.type	 TargetTesla,@function
TargetTesla:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	subfic 0,31,0
	adde 9,0,31
	subfic 11,30,0
	adde 0,11,30
	or. 11,9,0
	bc 4,2,.L364
	lwz 0,776(31)
	andi. 9,0,8192
	bc 12,2,.L366
	lwz 3,540(31)
	cmpwi 0,3,0
	bc 12,2,.L367
	bl cleanupHealTarget
.L367:
	lwz 0,776(31)
	rlwinm 0,0,0,19,17
	stw 0,776(31)
.L366:
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L368
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 4,2,.L369
	lwz 0,1016(9)
	cmpwi 0,0,0
	bc 12,2,.L368
.L369:
	stw 9,944(31)
.L368:
	lwz 0,540(31)
	cmpw 0,0,30
	bc 12,2,.L364
	lwz 9,812(31)
	stw 0,544(31)
	cmpwi 0,9,0
	stw 30,540(31)
	bc 12,2,.L371
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L364
	mr 3,31
	mtlr 9
	blrl
	b .L364
.L371:
	mr 3,31
	bl FoundTarget
.L364:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe24:
	.size	 TargetTesla,.Lfe24-TargetTesla
	.section	".rodata"
	.align 2
.LC57:
	.long 0x4cbebc20
	.section	".text"
	.align 2
	.globl hintpath_stop
	.type	 hintpath_stop,@function
hintpath_stop:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	li 0,0
	lis 11,level@ha
	stw 0,412(31)
	la 30,level@l(11)
	stw 0,416(31)
	lfs 0,4(30)
	lwz 9,776(31)
	stw 0,900(31)
	rlwinm 9,9,0,12,10
	stfs 0,896(31)
	stw 9,776(31)
	bl has_valid_enemy
	mr. 3,3
	bc 12,2,.L105
	lwz 4,540(31)
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L106
	mr 3,31
	bl FoundTarget
	b .L104
.L106:
	mr 3,31
	bl HuntTarget
	b .L104
.L105:
	stw 3,540(31)
	lis 9,.LC57@ha
	lfs 0,4(30)
	mr 3,31
	lfs 13,.LC57@l(9)
	lwz 9,788(31)
	fadds 0,0,13
	mtlr 9
	stfs 0,828(31)
	blrl
.L104:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 hintpath_stop,.Lfe25-hintpath_stop
	.section	".rodata"
	.align 2
.LC58:
	.long 0x0
	.section	".text"
	.align 2
	.globl CountPlayers
	.type	 CountPlayers,@function
CountPlayers:
	lis 9,coop@ha
	li 3,0
	lwz 9,coop@l(9)
	cmpwi 0,9,0
	bc 12,2,.L394
	lfs 13,20(9)
	lis 9,.LC58@ha
	la 9,.LC58@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L393
.L394:
	li 3,1
	blr
.L393:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,0
	bclr 4,1
	lis 11,g_edicts@ha
	mtctr 0
	lwz 9,g_edicts@l(11)
	addi 11,9,1084
.L398:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L397
	lwz 0,84(11)
	addi 9,3,1
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,3,0
	or 3,0,9
.L397:
	addi 11,11,1084
	bdnz .L398
	blr
.Lfe26:
	.size	 CountPlayers,.Lfe26-CountPlayers
	.align 2
	.globl monster_jump_start
	.type	 monster_jump_start,@function
monster_jump_start:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	stfs 0,288(3)
	blr
.Lfe27:
	.size	 monster_jump_start,.Lfe27-monster_jump_start
	.section	".rodata"
	.align 2
.LC59:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl monster_jump_finished
	.type	 monster_jump_finished,@function
monster_jump_finished:
	lis 9,level+4@ha
	lfs 13,288(3)
	lis 11,.LC59@ha
	lfs 0,level+4@l(9)
	la 11,.LC59@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 7,0,12
	mfcr 3
	rlwinm 3,3,30,1
	blr
.Lfe28:
	.size	 monster_jump_finished,.Lfe28-monster_jump_finished
	.section	".rodata"
	.align 2
.LC60:
	.long 0x42800000
	.align 2
.LC61:
	.long 0x3f800000
	.align 2
.LC62:
	.long 0x43b40000
	.align 2
.LC63:
	.long 0x43340000
	.section	".text"
	.align 2
	.globl face_wall
	.type	 face_wall,@function
face_wall:
	stwu 1,-144(1)
	mflr 0
	stmw 28,128(1)
	stw 0,148(1)
	addi 29,1,24
	mr 31,3
	li 6,0
	addi 3,31,16
	mr 4,29
	li 5,0
	bl AngleVectors
	addi 28,31,4
	lis 9,.LC60@ha
	addi 5,1,8
	la 9,.LC60@l(9)
	mr 4,29
	lfs 1,0(9)
	mr 3,28
	bl VectorMA
	lis 11,gi+48@ha
	lis 5,vec3_origin@ha
	lwz 0,gi+48@l(11)
	la 5,vec3_origin@l(5)
	lis 9,0x202
	ori 9,9,3
	mr 4,28
	addi 3,1,56
	mr 6,5
	mtlr 0
	addi 7,1,8
	mr 8,31
	blrl
	lis 9,.LC61@ha
	lfs 13,64(1)
	la 9,.LC61@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L258
	lwz 0,56(1)
	cmpwi 0,0,0
	bc 4,2,.L258
	lwz 0,60(1)
	cmpwi 0,0,0
	bc 4,2,.L258
	addi 3,1,80
	addi 4,1,40
	bl vectoangles2
	lis 9,.LC62@ha
	lfs 13,44(1)
	la 9,.LC62@l(9)
	lfs 12,0(9)
	lis 9,.LC63@ha
	la 9,.LC63@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	fcmpu 0,0,12
	stfs 0,424(31)
	bc 4,1,.L259
	fsubs 0,0,12
	stfs 0,424(31)
.L259:
	mr 3,31
	bl M_ChangeYaw
	li 3,1
	b .L411
.L258:
	li 3,0
.L411:
	lwz 0,148(1)
	mtlr 0
	lmw 28,128(1)
	la 1,144(1)
	blr
.Lfe29:
	.size	 face_wall,.Lfe29-face_wall
	.comm	hint_paths_present,4,4
	.comm	hint_path_start,400,4
	.comm	num_hint_paths,4,4
	.align 2
	.globl hintpath_go
	.type	 hintpath_go,@function
hintpath_go:
	stwu 1,-64(1)
	mflr 0
	stmw 28,48(1)
	stw 0,68(1)
	mr 29,3
	mr 28,4
	lfs 11,4(29)
	addi 3,1,8
	addi 4,1,24
	lfs 12,4(28)
	lfs 13,8(28)
	lfs 10,8(29)
	fsubs 12,12,11
	lfs 0,12(28)
	lfs 11,12(29)
	fsubs 13,13,10
	stfs 12,8(1)
	fsubs 0,0,11
	stfs 13,12(1)
	stfs 0,16(1)
	bl vectoangles2
	lwz 0,776(29)
	li 9,-117
	li 11,0
	lfs 0,28(1)
	lis 10,level+4@ha
	mr 3,29
	oris 0,0,0x10
	stw 28,412(29)
	and 0,0,9
	stw 11,828(29)
	lwz 9,804(29)
	stfs 0,424(29)
	stw 0,776(29)
	mtlr 9
	stw 28,416(29)
	lfs 0,level+4@l(10)
	stfs 0,848(29)
	blrl
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe30:
	.size	 hintpath_go,.Lfe30-hintpath_go
	.section	".rodata"
	.align 2
.LC64:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_hint_path
	.type	 SP_hint_path,@function
SP_hint_path:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 11,.LC64@ha
	lis 9,deathmatch@ha
	la 11,.LC64@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L224
	bl G_FreeEdict
	b .L223
.L224:
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L225
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L225
	lis 29,gi@ha
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC22@ha
	la 3,.LC22@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L223
.L225:
	lwz 11,184(31)
	lis 9,hint_path_touch@ha
	lis 10,0xc100
	la 9,hint_path_touch@l(9)
	lis 8,0x4100
	stw 10,196(31)
	li 0,1
	stw 9,444(31)
	ori 11,11,1
	stw 0,248(31)
	lis 9,gi+72@ha
	mr 3,31
	stw 8,208(31)
	stw 11,184(31)
	stw 10,188(31)
	stw 10,192(31)
	stw 8,200(31)
	stw 8,204(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L223:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe31:
	.size	 SP_hint_path,.Lfe31-SP_hint_path
	.align 2
	.globl badarea_touch
	.type	 badarea_touch,@function
badarea_touch:
	blr
.Lfe32:
	.size	 badarea_touch,.Lfe32-badarea_touch
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
