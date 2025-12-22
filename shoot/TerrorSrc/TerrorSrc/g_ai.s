	.file	"g_ai.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0x46fffe00
	.align 2
.LC1:
	.long 0x0
	.align 3
.LC2:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC3:
	.long 0x41700000
	.section	".text"
	.align 2
	.globl ai_stand
	.type	 ai_stand,@function
ai_stand:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 30,32(1)
	stw 0,52(1)
	lis 9,.LC1@ha
	mr 31,3
	la 9,.LC1@l(9)
	lfs 31,0(9)
	fcmpu 0,1,31
	bc 12,2,.L18
	fmr 2,1
	lfs 1,20(31)
	bl M_walkmove
.L18:
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 12,2,.L19
	lis 9,.LC1@ha
	mr 3,31
	la 9,.LC1@l(9)
	lfs 1,0(9)
	bl ai_checkattack
.L19:
	lwz 0,776(31)
	andi. 9,0,1
	bc 12,2,.L20
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L21
	lfs 0,4(31)
	addi 3,1,8
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,16(1)
	bl vectoyaw
	lfs 0,20(31)
	stfs 1,424(31)
	fcmpu 0,0,1
	bc 12,2,.L22
	lwz 0,776(31)
	andi. 9,0,2
	bc 12,2,.L22
	lwz 11,804(31)
	mr 3,31
	rlwinm 0,0,0,0,29
	stw 0,776(31)
	mtlr 11
	blrl
.L22:
	mr 3,31
	bl M_ChangeYaw
	lis 9,.LC1@ha
	mr 3,31
	la 9,.LC1@l(9)
	lfs 1,0(9)
	bl ai_checkattack
	b .L17
.L21:
	mr 3,31
	bl FindTarget
	b .L17
.L20:
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 4,2,.L17
	lis 9,level@ha
	lfs 0,828(31)
	la 30,level@l(9)
	lfs 13,4(30)
	fcmpu 0,13,0
	bc 4,1,.L25
	lwz 0,800(31)
	mr 3,31
	mtlr 0
	blrl
	b .L17
.L25:
	lwz 0,284(31)
	andi. 9,0,1
	bc 4,2,.L17
	lwz 0,792(31)
	cmpwi 0,0,0
	bc 12,2,.L17
	lfs 0,876(31)
	fcmpu 0,13,0
	bc 4,1,.L17
	fcmpu 0,0,31
	bc 12,2,.L27
	mtlr 0
	mr 3,31
	blrl
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,4(30)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC2@ha
	lis 11,.LC0@ha
	la 10,.LC2@l(10)
	stw 0,24(1)
	lfd 11,0(10)
	lfd 0,24(1)
	lis 10,.LC3@ha
	lfs 13,.LC0@l(11)
	la 10,.LC3@l(10)
	lfs 10,0(10)
	fsub 0,0,11
	fadds 12,12,10
	frsp 0,0
	fdivs 0,0,13
	fmadds 0,0,10,12
	b .L29
.L27:
	bl rand
	rlwinm 3,3,0,17,31
	lfs 10,4(30)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC2@ha
	lis 11,.LC0@ha
	la 10,.LC2@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC3@ha
	lfs 12,.LC0@l(11)
	la 10,.LC3@l(10)
	lfs 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmadds 0,0,11,10
.L29:
	stfs 0,876(31)
.L17:
	lwz 0,52(1)
	mtlr 0
	lmw 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 ai_stand,.Lfe1-ai_stand
	.section	".rodata"
	.align 2
.LC6:
	.string	"%s at %s, combattarget %s not found\n"
	.align 2
.LC7:
	.long 0x3f800000
	.align 3
.LC8:
	.long 0x41e00000
	.long 0x0
	.section	".text"
	.align 2
	.globl FoundTarget
	.type	 FoundTarget,@function
FoundTarget:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	lis 11,level@ha
	lwz 9,540(31)
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L56
	lwz 0,level@l(11)
	la 9,level@l(11)
	li 11,128
	stw 31,240(9)
	stw 0,244(9)
	stw 11,640(31)
.L56:
	lis 11,.LC7@ha
	lis 9,level+4@ha
	la 11,.LC7@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	lfd 12,0(9)
	fadds 0,0,13
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L57
	fctiwz 0,13
	stfd 0,24(1)
	lwz 0,28(1)
	b .L58
.L57:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	xoris 0,0,0x8000
.L58:
	lwz 11,540(31)
	lis 9,level+4@ha
	stw 0,496(31)
	lfs 0,4(11)
	lwz 3,320(31)
	stfs 0,856(31)
	cmpwi 0,3,0
	lfs 13,8(11)
	stfs 13,860(31)
	lfs 0,12(11)
	stfs 0,864(31)
	lfs 13,level+4@l(9)
	stfs 13,852(31)
	bc 4,2,.L59
	lwz 0,776(31)
	stw 11,412(31)
	andi. 11,0,1
	bc 12,2,.L60
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	b .L61
.L60:
	lwz 9,804(31)
	mr 3,31
	mtlr 9
	blrl
.L61:
	lwz 9,540(31)
	addi 3,1,8
	lfs 0,4(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,16(1)
	bl vectoyaw
	lis 9,.LC7@ha
	stfs 1,424(31)
	mr 3,31
	la 9,.LC7@l(9)
	lfs 1,0(9)
	bl AttackFinished
	b .L55
.L59:
	bl G_PickTarget
	mr 10,3
	cmpwi 0,10,0
	stw 10,416(31)
	stw 10,412(31)
	bc 4,2,.L63
	lwz 0,776(31)
	lwz 9,540(31)
	andi. 11,0,1
	stw 9,412(31)
	stw 9,416(31)
	bc 12,2,.L64
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	b .L65
.L64:
	lwz 9,804(31)
	mr 3,31
	mtlr 9
	blrl
.L65:
	lwz 9,540(31)
	addi 3,1,8
	lfs 0,4(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,16(1)
	bl vectoyaw
	lis 9,.LC7@ha
	stfs 1,424(31)
	mr 3,31
	la 9,.LC7@l(9)
	lfs 1,0(9)
	bl AttackFinished
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC6@ha
	lwz 6,320(31)
	la 3,.LC6@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L55
.L63:
	lwz 0,776(31)
	li 9,0
	mr 3,31
	stw 9,320(31)
	li 11,0
	ori 0,0,4096
	stw 0,776(31)
	stw 9,300(10)
	lwz 9,804(31)
	stw 11,828(31)
	mtlr 9
	blrl
.L55:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 FoundTarget,.Lfe2-FoundTarget
	.section	".rodata"
	.align 2
.LC9:
	.string	"target_actor"
	.align 2
.LC11:
	.string	"player_noise"
	.align 3
.LC10:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC12:
	.long 0x0
	.align 2
.LC13:
	.long 0x42a00000
	.align 2
.LC14:
	.long 0x447a0000
	.align 2
.LC15:
	.long 0x43fa0000
	.align 3
.LC16:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC17:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC18:
	.long 0x43300000
	.long 0x0
	.section	".text"
	.align 2
	.globl FindTarget
	.type	 FindTarget,@function
FindTarget:
	stwu 1,-144(1)
	mflr 0
	stmw 28,128(1)
	stw 0,148(1)
	mr 31,3
	lwz 0,776(31)
	andi. 9,0,256
	bc 12,2,.L68
	lwz 3,412(31)
	cmpwi 0,3,0
	bc 12,2,.L139
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L139
	lwz 3,280(3)
	cmpwi 0,3,0
	bc 12,2,.L139
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,0
	bc 12,2,.L130
	b .L139
.L68:
	andi. 9,0,4096
	bc 4,2,.L139
	lis 9,level@ha
	li 10,0
	la 4,level@l(9)
	lwz 11,level@l(9)
	lwz 0,244(4)
	addi 11,11,-1
	cmpw 0,0,11
	bc 12,0,.L72
	lwz 0,284(31)
	andi. 11,0,1
	bc 4,2,.L72
	lwz 30,240(4)
	lwz 9,540(31)
	lwz 0,540(30)
	cmpw 0,0,9
	b .L132
.L72:
	lis 9,level@ha
	la 4,level@l(9)
	lwz 11,level@l(9)
	lwz 0,252(4)
	addi 11,11,-1
	cmpw 0,0,11
	bc 12,0,.L75
	lwz 30,248(4)
	li 10,1
	b .L74
.L75:
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L77
	lwz 0,260(4)
	cmpw 0,0,11
	bc 12,0,.L77
	lwz 0,284(31)
	andi. 9,0,1
	bc 4,2,.L77
	lwz 30,256(4)
	li 10,1
	b .L74
.L77:
	lis 9,level+236@ha
	lwz 30,level+236@l(9)
	cmpwi 0,30,0
.L132:
	bc 12,2,.L139
.L74:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L139
	lwz 0,540(31)
	cmpw 0,30,0
	bc 12,2,.L129
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L82
	lwz 0,264(30)
	andi. 11,0,32
	b .L133
.L82:
	lwz 0,184(30)
	andi. 9,0,4
	bc 12,2,.L85
	lwz 9,540(30)
	cmpwi 0,9,0
	bc 12,2,.L139
	lwz 0,264(9)
	andi. 11,0,32
	b .L133
.L85:
	cmpwi 0,10,0
	bc 12,2,.L139
	lwz 9,256(30)
	lwz 0,264(9)
	andi. 9,0,32
.L133:
	bc 4,2,.L139
	cmpwi 0,10,0
	bc 4,2,.L92
	lfs 13,4(30)
	addi 3,1,8
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 0,0,13
	stfs 0,8(1)
	lfs 13,8(30)
	fsubs 12,12,13
	stfs 12,12(1)
	lfs 0,12(30)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	lis 9,.LC12@ha
	lis 11,deathmatch@ha
	la 9,.LC12@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L93
	lis 11,.LC13@ha
	la 11,.LC13@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	bc 12,0,.L134
	lis 9,.LC14@ha
	li 29,2
	la 9,.LC14@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L95
.L135:
	li 29,1
	b .L95
.L93:
	lis 11,.LC13@ha
	la 11,.LC13@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	bc 4,0,.L97
.L134:
	li 29,0
	b .L95
.L97:
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L135
	lis 11,.LC14@ha
	li 29,3
	la 11,.LC14@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	bc 4,0,.L95
	li 29,2
.L95:
	cmpwi 0,29,3
	bc 12,2,.L139
	lwz 0,640(30)
	cmpwi 0,0,5
	bc 4,1,.L139
	lwz 0,508(31)
	lis 28,0x4330
	lis 11,.LC16@ha
	lfs 12,12(31)
	lis 10,gi+48@ha
	xoris 0,0,0x8000
	la 11,.LC16@l(11)
	lfs 13,8(31)
	stw 0,124(1)
	lis 5,vec3_origin@ha
	addi 3,1,56
	stw 28,120(1)
	la 5,vec3_origin@l(5)
	addi 4,1,24
	lfd 11,0(11)
	mr 6,5
	addi 7,1,40
	lfd 0,120(1)
	mr 11,9
	mr 8,31
	lfs 10,4(31)
	li 9,25
	stfs 13,28(1)
	fsub 0,0,11
	lwz 10,gi+48@l(10)
	stfs 10,24(1)
	mtlr 10
	frsp 0,0
	fadds 12,12,0
	stfs 12,32(1)
	lfs 0,4(30)
	stfs 0,40(1)
	lfs 13,8(30)
	stfs 13,44(1)
	lfs 12,12(30)
	stfs 12,48(1)
	lwz 0,508(30)
	xoris 0,0,0x8000
	stw 0,124(1)
	stw 28,120(1)
	lfd 0,120(1)
	fsub 0,0,11
	frsp 0,0
	fadds 12,12,0
	stfs 12,48(1)
	blrl
	lfs 0,64(1)
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L139
	cmpwi 0,29,1
	bc 4,2,.L105
	lwz 0,496(30)
	lis 11,.LC18@ha
	la 11,.LC18@l(11)
	stw 0,124(1)
	stw 28,120(1)
	lfd 13,0(11)
	lfd 0,120(1)
	lis 11,level+4@ha
	lfs 12,level+4@l(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L110
	b .L140
.L105:
	cmpwi 0,29,2
	bc 4,2,.L110
.L140:
	addi 3,31,16
	addi 4,1,24
	li 5,0
	li 6,0
	bl AngleVectors
	lfs 0,4(31)
	addi 3,1,8
	lfs 13,4(30)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(30)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(30)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorNormalize
	lis 9,.LC12@ha
	lis 11,deathmatch@ha
	lfs 0,28(1)
	la 9,.LC12@l(9)
	lfs 12,12(1)
	lfs 8,0(9)
	lwz 9,deathmatch@l(11)
	fmuls 12,12,0
	lfs 13,8(1)
	lfs 9,20(9)
	lfs 11,24(1)
	lfs 10,16(1)
	fcmpu 0,9,8
	lfs 0,32(1)
	fmadds 13,13,11,12
	fmadds 0,10,0,13
	bc 4,2,.L137
	lis 9,.LC10@ha
	li 0,0
	lfd 13,.LC10@l(9)
	fcmpu 0,0,13
	bc 4,1,.L114
.L137:
	li 0,1
.L114:
	cmpwi 0,0,0
	bc 12,2,.L139
.L110:
	stw 30,540(31)
	lis 4,.LC11@ha
	lwz 3,280(30)
	la 4,.LC11@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L119
	lwz 0,776(31)
	lwz 11,540(31)
	rlwinm 0,0,0,30,28
	stw 0,776(31)
	lwz 9,84(11)
	cmpwi 0,9,0
	bc 4,2,.L119
	lwz 9,540(11)
	stw 9,540(31)
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 4,2,.L119
	stw 0,540(31)
.L139:
	li 3,0
	b .L130
.L92:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L120
	lwz 0,508(31)
	lis 29,0x4330
	lis 11,.LC16@ha
	lfs 12,12(31)
	lis 10,gi+48@ha
	xoris 0,0,0x8000
	la 11,.LC16@l(11)
	lfs 13,8(31)
	stw 0,124(1)
	lis 5,vec3_origin@ha
	addi 3,1,56
	stw 29,120(1)
	la 5,vec3_origin@l(5)
	addi 4,1,24
	lfd 11,0(11)
	mr 6,5
	addi 7,1,40
	lfd 0,120(1)
	mr 11,9
	mr 8,31
	lfs 10,4(31)
	li 9,25
	stfs 13,28(1)
	fsub 0,0,11
	lwz 10,gi+48@l(10)
	stfs 10,24(1)
	mtlr 10
	frsp 0,0
	fadds 12,12,0
	stfs 12,32(1)
	lfs 0,4(30)
	stfs 0,40(1)
	lfs 13,8(30)
	stfs 13,44(1)
	lfs 12,12(30)
	stfs 12,48(1)
	lwz 0,508(30)
	xoris 0,0,0x8000
	stw 0,124(1)
	stw 29,120(1)
	lfd 0,120(1)
	fsub 0,0,11
	frsp 0,0
	fadds 12,12,0
	stfs 12,48(1)
	blrl
	lfs 0,64(1)
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L124
	b .L139
.L120:
	lis 9,gi+60@ha
	addi 3,31,4
	lwz 0,gi+60@l(9)
	addi 4,30,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	bc 12,2,.L139
.L124:
	lfs 0,4(31)
	addi 3,1,8
	lfs 13,4(30)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(30)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(30)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorLength
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,1,.L139
	lwz 4,176(30)
	lwz 3,176(31)
	cmpw 0,4,3
	bc 12,2,.L127
	lis 9,gi+68@ha
	lwz 0,gi+68@l(9)
	mtlr 0
	blrl
	cmpwi 0,3,0
	li 3,0
	bc 12,2,.L130
.L127:
	addi 3,1,8
	bl vectoyaw
	stfs 1,424(31)
	mr 3,31
	bl M_ChangeYaw
	lwz 0,776(31)
	stw 30,540(31)
	ori 0,0,4
	stw 0,776(31)
.L119:
	mr 3,31
	bl FoundTarget
	lwz 0,776(31)
	andi. 9,0,4
	bc 4,2,.L129
	lwz 0,820(31)
	cmpwi 0,0,0
	bc 12,2,.L129
	mr 3,31
	mtlr 0
	lwz 4,540(3)
	blrl
.L129:
	li 3,1
.L130:
	lwz 0,148(1)
	mtlr 0
	lmw 28,128(1)
	la 1,144(1)
	blr
.Lfe3:
	.size	 FindTarget,.Lfe3-FindTarget
	.section	".rodata"
	.align 2
.LC20:
	.long 0x3ecccccd
	.align 2
.LC21:
	.long 0x3e4ccccd
	.align 2
.LC22:
	.long 0x3dcccccd
	.align 2
.LC23:
	.long 0x3ca3d70a
	.align 2
.LC24:
	.long 0x46fffe00
	.align 3
.LC25:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC26:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC27:
	.long 0x0
	.align 3
.LC28:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC29:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl M_CheckAttack
	.type	 M_CheckAttack,@function
M_CheckAttack:
	stwu 1,-160(1)
	mflr 0
	stfd 29,136(1)
	stfd 30,144(1)
	stfd 31,152(1)
	stmw 28,120(1)
	stw 0,164(1)
	mr 31,3
	lwz 12,540(31)
	lwz 0,480(12)
	cmpwi 0,0,0
	bc 4,1,.L144
	lwz 0,508(31)
	lis 28,0x4330
	lis 9,.LC26@ha
	lfs 12,12(31)
	mr 10,11
	xoris 0,0,0x8000
	la 9,.LC26@l(9)
	lfs 13,8(31)
	stw 0,116(1)
	lis 29,gi+48@ha
	addi 3,1,40
	stw 28,112(1)
	addi 4,1,8
	li 5,0
	lfd 11,0(9)
	li 6,0
	addi 7,1,24
	lfd 0,112(1)
	lis 9,0x200
	mr 8,31
	lfs 10,4(31)
	ori 9,9,27
	stfs 13,12(1)
	fsub 0,0,11
	lwz 11,gi+48@l(29)
	stfs 10,8(1)
	mtlr 11
	frsp 0,0
	fadds 12,12,0
	stfs 12,16(1)
	lfs 0,4(12)
	stfs 0,24(1)
	lfs 13,8(12)
	stfs 13,28(1)
	lfs 12,12(12)
	stfs 12,32(1)
	lwz 0,508(12)
	xoris 0,0,0x8000
	stw 0,116(1)
	stw 28,112(1)
	lfd 0,112(1)
	fsub 0,0,11
	frsp 0,0
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	lwz 9,92(1)
	lwz 0,540(31)
	cmpw 0,9,0
	bc 4,2,.L165
.L144:
	lis 9,enemy_range@ha
	lwz 11,enemy_range@l(9)
	cmpwi 7,11,0
	bc 4,30,.L146
	lis 9,.LC27@ha
	lis 11,skill@ha
	la 9,.LC27@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L147
	bl rand
	andi. 0,3,3
	bc 4,2,.L165
.L147:
	lwz 0,816(31)
	cmpwi 0,0,0
	li 0,4
	bc 12,2,.L148
	li 0,3
.L148:
	stw 0,868(31)
	li 3,1
	b .L168
.L146:
	lwz 0,812(31)
	cmpwi 0,0,0
	bc 12,2,.L165
	lis 9,level+4@ha
	lfs 13,832(31)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	bc 12,0,.L165
	cmpwi 0,11,3
	bc 12,2,.L165
	lwz 0,776(31)
	andi. 9,0,1
	bc 12,2,.L153
	lis 9,.LC20@ha
	lfs 31,.LC20@l(9)
	b .L154
.L153:
	bc 4,30,.L155
	lis 9,.LC21@ha
	lfs 31,.LC21@l(9)
	b .L154
.L155:
	cmpwi 0,11,1
	bc 4,2,.L157
	lis 9,.LC22@ha
	lfs 31,.LC22@l(9)
	b .L154
.L157:
	cmpwi 0,11,2
	bc 4,2,.L165
	lis 9,.LC23@ha
	lfs 31,.LC23@l(9)
.L154:
	lis 11,.LC27@ha
	lis 9,skill@ha
	la 11,.LC27@l(11)
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L161
	lis 9,.LC28@ha
	fmr 0,31
	la 9,.LC28@l(9)
	lfd 13,0(9)
	fmul 0,0,13
	frsp 31,0
	b .L162
.L161:
	lis 11,.LC29@ha
	la 11,.LC29@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L162
	fadds 31,31,31
.L162:
	bl rand
	lis 29,0x4330
	lis 9,.LC26@ha
	rlwinm 3,3,0,17,31
	la 9,.LC26@l(9)
	xoris 3,3,0x8000
	lfd 30,0(9)
	lis 11,.LC24@ha
	lfs 29,.LC24@l(11)
	stw 3,116(1)
	stw 29,112(1)
	lfd 0,112(1)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,29
	fcmpu 0,0,31
	bc 4,0,.L164
	li 0,4
	stw 0,868(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,level+4@ha
	stw 3,116(1)
	stw 29,112(1)
	li 3,1
	lfd 0,112(1)
	lfs 13,level+4@l(11)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,29
	fadds 0,0,0
	fadds 13,13,0
	stfs 13,832(31)
	b .L168
.L164:
	lwz 0,264(31)
	andi. 9,0,1
	bc 12,2,.L165
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC25@ha
	stw 3,116(1)
	stw 29,112(1)
	lfd 0,112(1)
	lfd 12,.LC25@l(11)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,12
	li 0,1
	bc 4,0,.L166
	li 0,2
.L166:
	stw 0,868(31)
.L165:
	li 3,0
.L168:
	lwz 0,164(1)
	mtlr 0
	lmw 28,120(1)
	lfd 29,136(1)
	lfd 30,144(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe4:
	.size	 M_CheckAttack,.Lfe4-M_CheckAttack
	.section	".rodata"
	.align 2
.LC32:
	.long 0x4cbebc20
	.align 3
.LC33:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC34:
	.long 0x439d8000
	.align 3
.LC35:
	.long 0x40140000
	.long 0x0
	.align 2
.LC36:
	.long 0x3f800000
	.align 3
.LC37:
	.long 0x41e00000
	.long 0x0
	.align 3
.LC38:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC39:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC40:
	.long 0x40a00000
	.align 2
.LC41:
	.long 0x0
	.align 2
.LC42:
	.long 0x42a00000
	.align 2
.LC43:
	.long 0x447a0000
	.align 2
.LC44:
	.long 0x43fa0000
	.align 2
.LC45:
	.long 0x42340000
	.section	".text"
	.align 2
	.globl ai_checkattack
	.type	 ai_checkattack,@function
ai_checkattack:
	stwu 1,-160(1)
	mflr 0
	stmw 28,144(1)
	stw 0,164(1)
	mr 31,3
	lwz 10,412(31)
	cmpwi 0,10,0
	bc 12,2,.L184
	lwz 0,776(31)
	andi. 8,0,4096
	bc 4,2,.L238
	andi. 9,0,4
	bc 12,2,.L184
	lwz 11,540(31)
	lis 9,level+4@ha
	lis 8,.LC35@ha
	lfs 11,level+4@l(9)
	la 8,.LC35@l(8)
	lfs 0,604(11)
	lfd 13,0(8)
	fsubs 0,11,0
	fcmpu 0,0,13
	bc 4,1,.L187
	cmpw 0,10,11
	bc 4,2,.L188
	lwz 0,416(31)
	cmpwi 0,0,0
	stw 0,412(31)
.L188:
	lwz 9,776(31)
	andi. 11,9,2
	rlwinm 0,9,0,30,28
	stw 0,776(31)
	bc 12,2,.L184
	rlwinm 0,9,0,0,28
	stw 0,776(31)
	b .L184
.L187:
	lis 8,.LC36@ha
	lis 9,.LC37@ha
	la 8,.LC36@l(8)
	la 9,.LC37@l(9)
	lfs 0,0(8)
	lfd 12,0(9)
	fadds 0,11,0
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L193
	fctiwz 0,13
	stfd 0,136(1)
	lwz 0,140(1)
	b .L194
.L193:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,136(1)
	lwz 0,140(1)
	xoris 0,0,0x8000
.L194:
	stw 0,496(31)
	b .L238
.L184:
	lwz 10,540(31)
	lis 9,enemy_vis@ha
	li 0,0
	stw 0,enemy_vis@l(9)
	cmpwi 0,10,0
	li 9,0
	bc 12,2,.L196
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 4,2,.L195
.L196:
	li 9,1
	b .L197
.L195:
	lwz 11,776(31)
	andi. 0,11,8192
	bc 12,2,.L198
	lwz 0,480(10)
	cmpwi 0,0,0
	bc 4,1,.L197
	rlwinm 0,11,0,19,17
	li 9,1
	stw 0,776(31)
	b .L197
.L198:
	andi. 8,11,512
	bc 12,2,.L201
	lwz 0,480(10)
	cmpwi 7,0,-80
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	b .L197
.L201:
	lwz 0,480(10)
	srawi 9,0,31
	subf 9,0,9
	srawi 9,9,31
	addi 9,9,1
.L197:
	cmpwi 0,9,0
	bc 12,2,.L205
	lwz 9,544(31)
	li 11,0
	stw 11,540(31)
	cmpwi 0,9,0
	bc 12,2,.L206
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L206
	lwz 0,776(31)
	stw 11,544(31)
	andi. 11,0,1
	stw 9,412(31)
	stw 9,540(31)
	bc 12,2,.L207
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	b .L208
.L207:
	lwz 9,804(31)
	mr 3,31
	mtlr 9
	blrl
.L208:
	lwz 9,540(31)
	addi 3,1,24
	lfs 0,4(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,24(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,28(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,32(1)
	bl vectoyaw
	lis 8,.LC36@ha
	stfs 1,424(31)
	mr 3,31
	la 8,.LC36@l(8)
	lfs 1,0(8)
	bl AttackFinished
	b .L205
.L206:
	lwz 0,416(31)
	cmpwi 0,0,0
	bc 12,2,.L211
	lwz 11,800(31)
	mr 3,31
	stw 0,412(31)
	mtlr 11
	blrl
	b .L237
.L211:
	lis 9,level+4@ha
	lis 11,.LC32@ha
	lwz 10,788(31)
	lfs 0,level+4@l(9)
	mr 3,31
	lfs 13,.LC32@l(11)
	mtlr 10
	fadds 0,0,13
	stfs 0,828(31)
	blrl
	b .L237
.L205:
	lis 8,.LC36@ha
	lis 9,level+4@ha
	la 8,.LC36@l(8)
	lfs 0,level+4@l(9)
	lfs 13,0(8)
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfd 12,0(9)
	fadds 0,0,13
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L213
	fctiwz 0,13
	stfd 0,136(1)
	lwz 12,140(1)
	b .L214
.L213:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,136(1)
	lwz 12,140(1)
	xoris 12,12,0x8000
.L214:
	lwz 0,508(31)
	lis 28,0x4330
	lis 11,.LC38@ha
	lfs 13,12(31)
	mr 10,9
	xoris 0,0,0x8000
	la 11,.LC38@l(11)
	lfs 12,8(31)
	stw 0,140(1)
	lis 29,gi+48@ha
	lis 5,vec3_origin@ha
	stw 28,136(1)
	la 5,vec3_origin@l(5)
	mr 8,31
	lfd 11,0(11)
	addi 3,1,72
	addi 4,1,40
	lfd 0,136(1)
	mr 6,5
	addi 7,1,56
	lfs 10,4(31)
	li 9,25
	stw 12,496(31)
	fsub 0,0,11
	lwz 11,540(31)
	stfs 10,40(1)
	stfs 12,44(1)
	frsp 0,0
	lwz 29,gi+48@l(29)
	mtlr 29
	fadds 13,13,0
	stfs 13,48(1)
	lfs 0,4(11)
	stfs 0,56(1)
	lfs 13,8(11)
	stfs 13,60(1)
	lfs 12,12(11)
	stfs 12,64(1)
	lwz 0,508(11)
	xoris 0,0,0x8000
	stw 0,140(1)
	stw 28,136(1)
	lfd 0,136(1)
	fsub 0,0,11
	frsp 0,0
	fadds 12,12,0
	stfs 12,64(1)
	blrl
	lfs 0,80(1)
	lis 8,.LC39@ha
	lis 9,enemy_vis@ha
	la 8,.LC39@l(8)
	lfd 13,0(8)
	fcmpu 7,0,13
	mfcr 0
	rlwinm 0,0,31,1
	cmpwi 0,0,0
	stw 0,enemy_vis@l(9)
	bc 12,2,.L217
	lis 9,.LC40@ha
	lis 11,level+4@ha
	la 9,.LC40@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lwz 9,540(31)
	fadds 0,0,13
	stfs 0,848(31)
	lfs 13,4(9)
	stfs 13,856(31)
	lfs 0,8(9)
	stfs 0,860(31)
	lfs 13,12(9)
	stfs 13,864(31)
.L217:
	lwz 29,540(31)
	addi 3,31,16
	addi 4,1,40
	li 5,0
	li 6,0
	bl AngleVectors
	lfs 0,4(31)
	addi 3,1,24
	lfs 13,4(29)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,24(1)
	lfs 0,8(29)
	fsubs 0,0,12
	stfs 0,28(1)
	lfs 13,12(29)
	fsubs 13,13,11
	stfs 13,32(1)
	bl VectorNormalize
	lis 11,deathmatch@ha
	lfs 0,44(1)
	lis 8,.LC41@ha
	lfs 12,28(1)
	la 8,.LC41@l(8)
	lwz 9,deathmatch@l(11)
	lfs 8,0(8)
	lfs 9,20(9)
	fmuls 12,12,0
	lfs 13,24(1)
	lfs 11,40(1)
	fcmpu 0,9,8
	lfs 10,32(1)
	lfs 0,48(1)
	fmadds 13,13,11,12
	fmadds 0,10,0,13
	bc 4,2,.L240
	lis 9,.LC33@ha
	li 0,0
	lfd 13,.LC33@l(9)
	fcmpu 0,0,13
	bc 4,1,.L219
.L240:
	li 0,1
.L219:
	lwz 9,540(31)
	lis 11,enemy_infront@ha
	addi 3,1,24
	lfs 13,4(31)
	lfs 0,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stw 0,enemy_infront@l(11)
	stfs 13,24(1)
	lfs 0,8(9)
	fsubs 12,12,0
	stfs 12,28(1)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,32(1)
	bl VectorLength
	lis 11,deathmatch@ha
	lis 8,.LC41@ha
	lwz 9,deathmatch@l(11)
	la 8,.LC41@l(8)
	lfs 13,0(8)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L221
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L241
	lis 11,.LC43@ha
	li 0,2
	la 11,.LC43@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	bc 4,0,.L223
.L242:
	li 0,1
	b .L223
.L221:
	lis 8,.LC42@ha
	la 8,.LC42@l(8)
	lfs 0,0(8)
	fcmpu 0,1,0
	bc 4,0,.L225
.L241:
	li 0,0
	b .L223
.L225:
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L242
	lis 11,.LC43@ha
	li 0,3
	la 11,.LC43@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	bc 4,0,.L223
	li 0,2
.L223:
	lwz 9,540(31)
	lis 11,enemy_range@ha
	addi 3,1,8
	lfs 0,4(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stw 0,enemy_range@l(11)
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,16(1)
	bl vectoyaw
	lwz 0,868(31)
	lis 9,enemy_yaw@ha
	stfs 1,enemy_yaw@l(9)
	cmpwi 0,0,4
	bc 4,2,.L228
	stfs 1,424(31)
	mr 3,31
	bl M_ChangeYaw
	lfs 0,20(31)
	lfs 1,424(31)
	fsubs 1,0,1
	bl anglemod
	lis 8,.LC45@ha
	lis 9,.LC34@ha
	la 8,.LC45@l(8)
	lfs 0,.LC34@l(9)
	lfs 13,0(8)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 11,0,9
	bc 4,2,.L237
	lwz 9,812(31)
	b .L243
.L228:
	cmpwi 0,0,3
	bc 4,2,.L233
	stfs 1,424(31)
	mr 3,31
	bl M_ChangeYaw
	lfs 0,20(31)
	lfs 1,424(31)
	fsubs 1,0,1
	bl anglemod
	lis 8,.LC45@ha
	lis 9,.LC34@ha
	la 8,.LC45@l(8)
	lfs 0,.LC34@l(9)
	lfs 13,0(8)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 11,0,9
	bc 4,2,.L237
	lwz 9,816(31)
.L243:
	mr 3,31
	mtlr 9
	blrl
	li 0,1
	stw 0,868(31)
.L237:
	li 3,1
	b .L239
.L233:
	lis 9,enemy_vis@ha
	lwz 0,enemy_vis@l(9)
	cmpwi 0,0,0
	bc 12,2,.L238
	lwz 0,824(31)
	mr 3,31
	mtlr 0
	blrl
	b .L239
.L238:
	li 3,0
.L239:
	lwz 0,164(1)
	mtlr 0
	lmw 28,144(1)
	la 1,160(1)
	blr
.Lfe5:
	.size	 ai_checkattack,.Lfe5-ai_checkattack
	.section	".rodata"
	.align 2
.LC46:
	.long 0x42800000
	.align 2
.LC47:
	.long 0xc2b40000
	.align 2
.LC48:
	.long 0x42b40000
	.align 2
.LC49:
	.long 0x0
	.align 2
.LC50:
	.long 0x41a00000
	.align 2
.LC51:
	.long 0x40a00000
	.align 2
.LC52:
	.long 0x3f800000
	.align 2
.LC53:
	.long 0x3f000000
	.align 3
.LC54:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ai_run
	.type	 ai_run,@function
ai_run:
	stwu 1,-272(1)
	mflr 0
	stfd 26,224(1)
	stfd 27,232(1)
	stfd 28,240(1)
	stfd 29,248(1)
	stfd 30,256(1)
	stfd 31,264(1)
	stmw 17,164(1)
	stw 0,276(1)
	mr 31,3
	fmr 27,1
	lwz 0,776(31)
	andi. 9,0,4096
	bc 12,2,.L245
	bl M_MoveToGoal
	b .L244
.L245:
	andi. 9,0,4
	bc 12,2,.L246
	lwz 9,540(31)
	addi 3,1,8
	lfs 13,4(31)
	lfs 0,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L247
	lwz 11,788(31)
	mr 3,31
	lwz 0,776(31)
	mtlr 11
	ori 0,0,3
	stw 0,776(31)
	blrl
	b .L244
.L247:
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 12,2,.L244
.L246:
	fmr 1,27
	mr 3,31
	bl ai_checkattack
	cmpwi 0,3,0
	bc 4,2,.L244
	lwz 0,868(31)
	cmpwi 0,0,2
	bc 4,2,.L250
	lis 9,enemy_yaw@ha
	mr 3,31
	lfs 0,enemy_yaw@l(9)
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	lfs 31,0(9)
	stfs 0,424(31)
	bl M_ChangeYaw
	lwz 0,872(31)
	cmpwi 0,0,0
	bc 12,2,.L251
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfs 31,0(9)
.L251:
	lfs 1,424(31)
	fmr 2,27
	mr 3,31
	fadds 1,1,31
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L244
	lfs 1,424(31)
	fmr 2,27
	mr 3,31
	lwz 0,872(31)
	fsubs 1,1,31
	subfic 0,0,1
	stw 0,872(31)
	bl M_walkmove
	b .L244
.L250:
	lis 9,enemy_vis@ha
	lwz 0,enemy_vis@l(9)
	cmpwi 0,0,0
	bc 12,2,.L255
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
	lwz 0,776(31)
	lis 11,level+4@ha
	lwz 9,540(31)
	rlwinm 0,0,0,29,27
	stw 0,776(31)
	lfs 0,4(9)
	stfs 0,856(31)
	lfs 13,8(9)
	stfs 13,860(31)
	lfs 0,12(9)
	stfs 0,864(31)
	lfs 13,level+4@l(11)
	stfs 13,852(31)
	b .L244
.L255:
	lis 9,coop@ha
	lis 10,.LC49@ha
	lwz 11,coop@l(9)
	la 10,.LC49@l(10)
	lfs 31,0(10)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L256
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 4,2,.L244
.L256:
	lfs 13,848(31)
	fcmpu 0,13,31
	bc 12,2,.L258
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 0,0(9)
	lis 9,level+4@ha
	fadds 0,13,0
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 4,1,.L258
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
	stfs 31,848(31)
	b .L244
.L258:
	lwz 17,412(31)
	li 30,0
	bl G_Spawn
	lwz 0,776(31)
	mr 18,3
	stw 18,412(31)
	andi. 9,0,8
	bc 4,2,.L259
	ori 0,0,24
	li 30,1
	rlwinm 0,0,0,27,24
	stw 0,776(31)
.L259:
	lwz 11,776(31)
	andi. 10,11,32
	bc 12,2,.L260
	rlwinm 0,11,0,27,25
	lis 10,.LC51@ha
	stw 0,776(31)
	lis 9,level+4@ha
	la 10,.LC51@l(10)
	lfs 0,level+4@l(9)
	andi. 0,11,64
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,848(31)
	bc 12,2,.L261
	lfs 12,836(31)
	rlwinm 0,11,0,27,24
	li 3,0
	lfs 13,840(31)
	li 30,1
	lfs 0,844(31)
	stw 0,776(31)
	stfs 12,856(31)
	stfs 13,860(31)
	stfs 0,864(31)
	b .L262
.L261:
	andi. 9,11,16
	bc 12,2,.L263
	rlwinm 0,11,0,28,25
	mr 3,31
	stw 0,776(31)
	bl PlayerTrail_PickFirst
	b .L262
.L263:
	mr 3,31
	bl PlayerTrail_PickNext
.L262:
	cmpwi 0,3,0
	bc 12,2,.L260
	lfs 13,4(3)
	li 30,1
	stfs 13,856(31)
	lfs 0,8(3)
	stfs 0,860(31)
	lfs 13,12(3)
	stfs 13,864(31)
	lfs 0,288(3)
	stfs 0,852(31)
	lfs 13,20(3)
	stfs 13,20(31)
	stfs 13,424(31)
.L260:
	lfs 11,856(31)
	addi 3,1,8
	lfs 12,4(31)
	lfs 13,8(31)
	lfs 10,860(31)
	fsubs 12,12,11
	lfs 0,12(31)
	lfs 11,864(31)
	fsubs 13,13,10
	stfs 12,8(1)
	fsubs 0,0,11
	stfs 13,12(1)
	stfs 0,16(1)
	bl VectorLength
	fmr 30,1
	fcmpu 0,30,27
	cror 3,2,0
	bc 4,3,.L266
	lwz 0,776(31)
	fmr 27,30
	ori 0,0,32
	stw 0,776(31)
.L266:
	lfs 0,856(31)
	cmpwi 0,30,0
	lwz 11,412(31)
	stfs 0,4(11)
	lfs 0,860(31)
	lwz 9,412(31)
	stfs 0,8(9)
	lfs 0,864(31)
	lwz 11,412(31)
	stfs 0,12(11)
	bc 12,2,.L267
	lis 9,gi@ha
	addi 25,1,24
	la 21,gi@l(9)
	addi 30,31,4
	lwz 10,48(21)
	addi 27,31,188
	addi 26,31,200
	lis 9,0x201
	mr 3,25
	mr 4,30
	mr 5,27
	mtlr 10
	mr 6,26
	addi 7,31,856
	mr 8,31
	ori 9,9,3
	lis 11,.LC52@ha
	la 11,.LC52@l(11)
	lfs 26,0(11)
	blrl
	lfs 0,32(1)
	fcmpu 0,0,26
	bc 4,0,.L267
	lwz 9,412(31)
	addi 29,1,88
	addi 28,1,104
	lfs 0,4(31)
	addi 24,1,120
	addi 23,1,136
	lfs 13,4(9)
	addi 3,1,8
	li 22,0
	lfs 11,8(31)
	lis 20,0xc180
	lis 19,0x4180
	lfs 12,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,12
	stfs 13,16(1)
	bl VectorLength
	lfs 29,32(1)
	lis 9,.LC53@ha
	fmr 30,1
	addi 3,1,8
	la 9,.LC53@l(9)
	lfs 13,0(9)
	fadds 0,29,26
	fmuls 0,0,13
	fmuls 28,30,0
	bl vectoyaw
	stfs 1,20(31)
	addi 3,31,16
	mr 4,29
	stfs 1,424(31)
	mr 5,28
	li 6,0
	bl AngleVectors
	addi 4,1,8
	stfs 28,8(1)
	mr 3,30
	stw 20,12(1)
	mr 5,29
	mr 6,28
	stw 22,16(1)
	mr 7,24
	bl G_ProjectSource
	lwz 11,48(21)
	lis 9,0x201
	mr 8,31
	ori 9,9,3
	mr 3,25
	mtlr 11
	mr 4,30
	mr 5,27
	mr 6,26
	mr 7,24
	blrl
	lfs 31,32(1)
	addi 4,1,8
	mr 3,30
	mr 5,29
	mr 6,28
	stfs 28,8(1)
	mr 7,23
	stw 19,12(1)
	stw 22,16(1)
	bl G_ProjectSource
	lwz 0,48(21)
	lis 9,0x201
	mr 3,25
	ori 9,9,3
	mr 5,27
	mtlr 0
	mr 6,26
	mr 4,30
	mr 7,23
	mr 8,31
	blrl
	fmuls 0,30,29
	lfs 13,32(1)
	fdivs 29,0,28
	fcmpu 6,31,13
	fcmpu 7,31,29
	cror 31,30,29
	mfcr 0
	rlwinm 9,0,26,1
	rlwinm 0,0,0,1
	and. 10,0,9
	bc 12,2,.L269
	fcmpu 0,31,26
	bc 4,0,.L270
	fmuls 0,28,31
	lis 11,.LC54@ha
	stw 20,12(1)
	mr 3,30
	la 11,.LC54@l(11)
	stw 22,16(1)
	mr 5,29
	lfd 13,0(11)
	mr 6,28
	mr 7,24
	addi 4,1,8
	fmul 0,0,13
	frsp 0,0
	stfs 0,8(1)
	bl G_ProjectSource
.L270:
	lfs 12,856(31)
	addi 3,1,8
	lfs 11,860(31)
	lfs 0,864(31)
	lwz 0,776(31)
	lfs 13,120(1)
	lwz 11,412(31)
	ori 0,0,64
	stfs 11,840(31)
	stfs 12,836(31)
	stfs 0,844(31)
	stw 0,776(31)
	stfs 13,4(11)
	lfs 0,124(1)
	lwz 9,412(31)
	stfs 0,8(9)
	lfs 0,128(1)
	lwz 11,412(31)
	stfs 0,12(11)
	lfs 13,120(1)
	lfs 0,124(1)
	lfs 12,128(1)
	b .L275
.L269:
	fcmpu 7,13,29
	fcmpu 6,13,31
	cror 31,30,29
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,26,1
	and. 10,9,0
	bc 12,2,.L267
	fcmpu 0,13,26
	bc 4,0,.L273
	fmuls 0,28,13
	lis 11,.LC54@ha
	stw 19,12(1)
	mr 3,30
	la 11,.LC54@l(11)
	stw 22,16(1)
	mr 5,29
	lfd 13,0(11)
	mr 6,28
	mr 7,23
	addi 4,1,8
	fmul 0,0,13
	frsp 0,0
	stfs 0,8(1)
	bl G_ProjectSource
.L273:
	lfs 12,856(31)
	addi 3,1,8
	lfs 11,860(31)
	lfs 0,864(31)
	lwz 0,776(31)
	lfs 13,136(1)
	lwz 11,412(31)
	ori 0,0,64
	stfs 11,840(31)
	stfs 12,836(31)
	stfs 0,844(31)
	stw 0,776(31)
	stfs 13,4(11)
	lfs 0,140(1)
	lwz 9,412(31)
	stfs 0,8(9)
	lfs 0,144(1)
	lwz 11,412(31)
	stfs 0,12(11)
	lfs 13,136(1)
	lfs 0,140(1)
	lfs 12,144(1)
.L275:
	lwz 9,412(31)
	stfs 0,860(31)
	stfs 12,864(31)
	stfs 13,856(31)
	lfs 0,4(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,16(1)
	bl vectoyaw
	stfs 1,20(31)
	stfs 1,424(31)
.L267:
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
	mr 3,18
	bl G_FreeEdict
	cmpwi 0,31,0
	bc 12,2,.L244
	stw 17,412(31)
.L244:
	lwz 0,276(1)
	mtlr 0
	lmw 17,164(1)
	lfd 26,224(1)
	lfd 27,232(1)
	lfd 28,240(1)
	lfd 29,248(1)
	lfd 30,256(1)
	lfd 31,264(1)
	la 1,272(1)
	blr
.Lfe6:
	.size	 ai_run,.Lfe6-ai_run
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_UZIclip,4,4
	.comm	item_9mm,4,4
	.comm	item_1911rounds,4,4
	.comm	item_50cal,4,4
	.comm	item_MARINERrounds,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_sshotgun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.align 2
	.globl AI_SetSightClient
	.type	 AI_SetSightClient,@function
AI_SetSightClient:
	lis 9,level+236@ha
	lwz 10,level+236@l(9)
	cmpwi 0,10,0
	bc 4,2,.L7
	li 7,1
	b .L8
.L276:
	lis 9,level+236@ha
	stw 11,level+236@l(9)
	blr
.L7:
	lis 11,g_edicts@ha
	lis 9,0x4f72
	lwz 0,g_edicts@l(11)
	ori 9,9,49717
	subf 0,0,10
	mullw 0,0,9
	srawi 7,0,5
.L8:
	lis 9,game+1544@ha
	lis 10,g_edicts@ha
	lis 11,level@ha
	lwz 6,game+1544@l(9)
	mr 8,7
	lwz 10,g_edicts@l(10)
	la 4,level@l(11)
	li 5,0
.L11:
	addi 8,8,1
	cmpw 7,8,6
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	neg 9,9
	addi 11,9,1
	and 9,8,9
	or 8,9,11
	mulli 0,8,928
	add 11,10,0
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L13
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L13
	lwz 0,264(11)
	andi. 9,0,32
	bc 12,2,.L276
.L13:
	cmpw 0,8,7
	bc 4,2,.L11
	stw 5,236(4)
	blr
.Lfe7:
	.size	 AI_SetSightClient,.Lfe7-AI_SetSightClient
	.align 2
	.globl ai_move
	.type	 ai_move,@function
ai_move:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	fmr 2,1
	lfs 1,20(3)
	bl M_walkmove
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 ai_move,.Lfe8-ai_move
	.section	".rodata"
	.align 2
.LC55:
	.long 0x46fffe00
	.align 2
.LC56:
	.long 0x0
	.align 3
.LC57:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC58:
	.long 0x41700000
	.section	".text"
	.align 2
	.globl ai_walk
	.type	 ai_walk,@function
ai_walk:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	bl M_MoveToGoal
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 4,2,.L30
	lwz 0,796(31)
	cmpwi 0,0,0
	bc 12,2,.L30
	lis 9,level@ha
	lfs 13,876(31)
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,0,13
	bc 4,1,.L30
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L33
	mtlr 0
	mr 3,31
	blrl
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,4(30)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC57@ha
	lis 11,.LC55@ha
	la 10,.LC57@l(10)
	stw 0,16(1)
	lfd 11,0(10)
	lfd 0,16(1)
	lis 10,.LC58@ha
	lfs 13,.LC55@l(11)
	la 10,.LC58@l(10)
	lfs 10,0(10)
	fsub 0,0,11
	fadds 12,12,10
	frsp 0,0
	fdivs 0,0,13
	fmadds 0,0,10,12
	b .L277
.L33:
	bl rand
	rlwinm 3,3,0,17,31
	lfs 10,4(30)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC57@ha
	lis 11,.LC55@ha
	la 10,.LC57@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC58@ha
	lfs 12,.LC55@l(11)
	la 10,.LC58@l(10)
	lfs 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmadds 0,0,11,10
.L277:
	stfs 0,876(31)
.L30:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 ai_walk,.Lfe9-ai_walk
	.section	".rodata"
	.align 2
.LC59:
	.long 0x0
	.section	".text"
	.align 2
	.globl ai_turn
	.type	 ai_turn,@function
ai_turn:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,.LC59@ha
	mr 31,3
	la 9,.LC59@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,2,.L38
	fmr 2,1
	lfs 1,20(31)
	bl M_walkmove
.L38:
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 4,2,.L37
	mr 3,31
	bl M_ChangeYaw
.L37:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 ai_turn,.Lfe10-ai_turn
	.section	".rodata"
	.align 2
.LC60:
	.long 0x0
	.section	".text"
	.align 2
	.globl ai_charge
	.type	 ai_charge,@function
ai_charge:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stw 31,36(1)
	stw 0,52(1)
	mr 31,3
	fmr 31,1
	lwz 9,540(31)
	addi 3,1,8
	lfs 0,4(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,16(1)
	bl vectoyaw
	stfs 1,424(31)
	mr 3,31
	bl M_ChangeYaw
	lis 9,.LC60@ha
	la 9,.LC60@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 12,2,.L36
	mr 3,31
	fmr 2,31
	lfs 1,20(3)
	bl M_walkmove
.L36:
	lwz 0,52(1)
	mtlr 0
	lwz 31,36(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe11:
	.size	 ai_charge,.Lfe11-ai_charge
	.section	".rodata"
	.align 2
.LC61:
	.long 0x0
	.align 2
.LC62:
	.long 0x42a00000
	.align 2
.LC63:
	.long 0x447a0000
	.align 2
.LC64:
	.long 0x43fa0000
	.section	".text"
	.align 2
	.globl range
	.type	 range,@function
range:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	mr 9,3
	lfs 11,12(4)
	lfs 12,12(9)
	addi 3,1,8
	lfs 13,4(9)
	lfs 0,8(9)
	fsubs 12,12,11
	lfs 10,4(4)
	lfs 11,8(4)
	fsubs 13,13,10
	stfs 12,16(1)
	fsubs 0,0,11
	stfs 13,8(1)
	stfs 0,12(1)
	bl VectorLength
	lis 9,.LC61@ha
	lis 11,deathmatch@ha
	la 9,.LC61@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L41
	lis 9,.LC62@ha
	la 9,.LC62@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L279
	lis 9,.LC63@ha
	la 9,.LC63@l(9)
	lfs 0,0(9)
	fcmpu 7,1,0
	mfcr 3
	rlwinm 3,3,29,1
	neg 3,3
	nor 0,3,3
	rlwinm 3,3,0,31,31
	rlwinm 0,0,0,30,30
	or 3,3,0
	b .L278
.L41:
	lis 9,.LC62@ha
	la 9,.LC62@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L44
.L279:
	li 3,0
	b .L278
.L44:
	lis 9,.LC64@ha
	la 9,.LC64@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L45
	lis 9,.LC63@ha
	la 9,.LC63@l(9)
	lfs 0,0(9)
	fcmpu 7,1,0
	mfcr 3
	rlwinm 3,3,29,1
	neg 3,3
	nor 0,3,3
	rlwinm 3,3,0,30,30
	rlwinm 0,0,0,30,31
	or 3,3,0
	b .L278
.L45:
	li 3,1
.L278:
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe12:
	.size	 range,.Lfe12-range
	.section	".rodata"
	.align 3
.LC65:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC66:
	.long 0x0
	.section	".text"
	.align 2
	.globl infront
	.type	 infront,@function
infront:
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
	lis 9,.LC66@ha
	lis 11,deathmatch@ha
	lfs 0,28(1)
	la 9,.LC66@l(9)
	lfs 12,12(1)
	lfs 8,0(9)
	lwz 9,deathmatch@l(11)
	fmuls 12,12,0
	lfs 13,8(1)
	lfs 9,20(9)
	lfs 11,24(1)
	lfs 10,16(1)
	fcmpu 0,9,8
	lfs 0,32(1)
	fmadds 13,13,11,12
	fmadds 13,10,0,13
	bc 4,2,.L50
	lis 9,.LC65@ha
	lfd 0,.LC65@l(9)
	fcmpu 7,13,0
	mfcr 3
	rlwinm 3,3,30,1
	b .L280
.L50:
	li 3,1
.L280:
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe13:
	.size	 infront,.Lfe13-infront
	.section	".rodata"
	.align 3
.LC67:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC68:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl visible
	.type	 visible,@function
visible:
	stwu 1,-144(1)
	mflr 0
	stmw 26,120(1)
	stw 0,148(1)
	mr 29,3
	mr 28,4
	lwz 0,508(29)
	lis 27,0x4330
	lwz 11,508(28)
	mr 10,9
	lis 8,.LC67@ha
	xoris 0,0,0x8000
	la 8,.LC67@l(8)
	lfs 7,12(29)
	stw 0,116(1)
	xoris 11,11,0x8000
	lis 26,gi+48@ha
	stw 27,112(1)
	lis 5,vec3_origin@ha
	addi 3,1,40
	lfd 13,112(1)
	la 5,vec3_origin@l(5)
	addi 4,1,8
	stw 11,116(1)
	mr 6,5
	addi 7,1,24
	stw 27,112(1)
	li 9,25
	lfd 11,0(8)
	lfd 0,112(1)
	mr 8,29
	lfs 12,12(28)
	fsub 13,13,11
	lwz 0,gi+48@l(26)
	fsub 0,0,11
	lfs 10,4(29)
	lfs 11,8(29)
	mtlr 0
	frsp 13,13
	lfs 9,4(28)
	frsp 0,0
	lfs 8,8(28)
	stfs 10,8(1)
	fadds 7,7,13
	stfs 11,12(1)
	fadds 12,12,0
	stfs 9,24(1)
	stfs 8,28(1)
	stfs 7,16(1)
	stfs 12,32(1)
	blrl
	lfs 0,48(1)
	lis 8,.LC68@ha
	la 8,.LC68@l(8)
	lfd 13,0(8)
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,31,1
	lwz 0,148(1)
	mtlr 0
	lmw 26,120(1)
	la 1,144(1)
	blr
.Lfe14:
	.size	 visible,.Lfe14-visible
	.section	".rodata"
	.align 2
.LC69:
	.long 0x439d8000
	.align 2
.LC70:
	.long 0x42340000
	.section	".text"
	.align 2
	.globl FacingIdeal
	.type	 FacingIdeal,@function
FacingIdeal:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lfs 0,424(3)
	lfs 1,20(3)
	fsubs 1,1,0
	bl anglemod
	lis 11,.LC70@ha
	lis 9,.LC69@ha
	la 11,.LC70@l(11)
	lfs 0,.LC69@l(9)
	lfs 13,0(11)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 11,0,9
	mfcr 3
	rlwinm 3,3,3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 FacingIdeal,.Lfe15-FacingIdeal
	.comm	ctfgame,24,4
	.comm	enemies,4,4
	.comm	spawned,4,4
	.comm	lms_round,4,4
	.comm	terror_l,4,4
	.comm	swat_l,4,4
	.comm	lms_delay,4,4
	.comm	lms_delay2,4,4
	.comm	lms_players,4,4
	.comm	lms_dead_players,4,4
	.comm	lms_alive_players,4,4
	.comm	lms_round_over,4,4
	.comm	enemy_vis,4,4
	.comm	enemy_infront,4,4
	.comm	enemy_range,4,4
	.comm	enemy_yaw,4,4
	.section	".rodata"
	.align 2
.LC71:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl HuntTarget
	.type	 HuntTarget,@function
HuntTarget:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,776(31)
	lwz 9,540(31)
	andi. 11,0,1
	stw 9,412(31)
	bc 12,2,.L53
	lwz 9,788(31)
	mtlr 9
	blrl
	b .L54
.L53:
	lwz 9,804(31)
	mr 3,31
	mtlr 9
	blrl
.L54:
	lwz 9,540(31)
	addi 3,1,8
	lfs 0,4(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,16(1)
	bl vectoyaw
	lis 9,.LC71@ha
	stfs 1,424(31)
	mr 3,31
	la 9,.LC71@l(9)
	lfs 1,0(9)
	bl AttackFinished
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 HuntTarget,.Lfe16-HuntTarget
	.section	".rodata"
	.align 2
.LC72:
	.long 0x439d8000
	.align 2
.LC73:
	.long 0x42340000
	.section	".text"
	.align 2
	.globl ai_run_melee
	.type	 ai_run_melee,@function
ai_run_melee:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,enemy_yaw@ha
	mr 31,3
	lfs 0,enemy_yaw@l(9)
	stfs 0,424(31)
	bl M_ChangeYaw
	lfs 0,20(31)
	lfs 1,424(31)
	fsubs 1,0,1
	bl anglemod
	lis 11,.LC73@ha
	lis 9,.LC72@ha
	la 11,.LC73@l(11)
	lfs 0,.LC72@l(9)
	lfs 13,0(11)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 11,0,9
	bc 4,2,.L172
	lwz 9,816(31)
	mr 3,31
	mtlr 9
	blrl
	li 0,1
	stw 0,868(31)
.L172:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe17:
	.size	 ai_run_melee,.Lfe17-ai_run_melee
	.section	".rodata"
	.align 2
.LC74:
	.long 0x439d8000
	.align 2
.LC75:
	.long 0x42340000
	.section	".text"
	.align 2
	.globl ai_run_missile
	.type	 ai_run_missile,@function
ai_run_missile:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,enemy_yaw@ha
	mr 31,3
	lfs 0,enemy_yaw@l(9)
	stfs 0,424(31)
	bl M_ChangeYaw
	lfs 0,20(31)
	lfs 1,424(31)
	fsubs 1,0,1
	bl anglemod
	lis 11,.LC75@ha
	lis 9,.LC74@ha
	la 11,.LC75@l(11)
	lfs 0,.LC74@l(9)
	lfs 13,0(11)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 11,0,9
	bc 4,2,.L176
	lwz 9,812(31)
	mr 3,31
	mtlr 9
	blrl
	li 0,1
	stw 0,868(31)
.L176:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe18:
	.size	 ai_run_missile,.Lfe18-ai_run_missile
	.section	".rodata"
	.align 2
.LC76:
	.long 0xc2b40000
	.align 2
.LC77:
	.long 0x42b40000
	.section	".text"
	.align 2
	.globl ai_run_slide
	.type	 ai_run_slide,@function
ai_run_slide:
	stwu 1,-32(1)
	mflr 0
	stfd 30,16(1)
	stfd 31,24(1)
	stw 31,12(1)
	stw 0,36(1)
	lis 9,enemy_yaw@ha
	mr 31,3
	fmr 30,1
	lfs 0,enemy_yaw@l(9)
	lis 9,.LC76@ha
	la 9,.LC76@l(9)
	lfs 31,0(9)
	stfs 0,424(31)
	bl M_ChangeYaw
	lwz 0,872(31)
	cmpwi 0,0,0
	bc 12,2,.L180
	lis 9,.LC77@ha
	la 9,.LC77@l(9)
	lfs 31,0(9)
.L180:
	lfs 1,424(31)
	fmr 2,30
	mr 3,31
	fadds 1,1,31
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L179
	lfs 1,424(31)
	fmr 2,30
	mr 3,31
	lwz 0,872(31)
	fsubs 1,1,31
	subfic 0,0,1
	stw 0,872(31)
	bl M_walkmove
.L179:
	lwz 0,36(1)
	mtlr 0
	lwz 31,12(1)
	lfd 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 ai_run_slide,.Lfe19-ai_run_slide
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
