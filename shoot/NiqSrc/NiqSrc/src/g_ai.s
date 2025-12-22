	.file	"g_ai.c"
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
	lwz 0,776(31)
	andi. 9,0,1
	bc 12,2,.L19
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L20
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
	bc 12,2,.L21
	lwz 0,776(31)
	andi. 9,0,2
	bc 12,2,.L21
	lwz 11,804(31)
	mr 3,31
	rlwinm 0,0,0,0,29
	stw 0,776(31)
	mtlr 11
	blrl
.L21:
	mr 3,31
	bl M_ChangeYaw
	lis 9,.LC1@ha
	mr 3,31
	la 9,.LC1@l(9)
	lfs 1,0(9)
	bl ai_checkattack
	b .L17
.L20:
	mr 3,31
	bl FindTarget
	b .L17
.L19:
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 4,2,.L17
	lis 9,level@ha
	lfs 0,828(31)
	la 30,level@l(9)
	lfs 13,4(30)
	fcmpu 0,13,0
	bc 4,1,.L24
	lwz 0,800(31)
	mr 3,31
	mtlr 0
	blrl
	b .L17
.L24:
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
	bc 12,2,.L26
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
	b .L28
.L26:
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
.L28:
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
.LC5:
	.long 0x41800000
	.align 3
.LC6:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC7:
	.long 0x3f800000
	.align 2
.LC8:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl visible_box
	.type	 visible_box,@function
visible_box:
	stwu 1,-128(1)
	mflr 0
	stmw 27,108(1)
	stw 0,132(1)
	lis 9,gi@ha
	mr 31,3
	la 27,gi@l(9)
	mr 30,4
	lwz 9,56(27)
	addi 29,31,4
	addi 28,30,4
	mr 3,29
	mr 4,28
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 4,2,.L46
	li 3,0
	b .L51
.L46:
	lis 9,.LC5@ha
	lfs 13,196(31)
	mr 4,29
	la 9,.LC5@l(9)
	lwz 0,48(27)
	mr 7,28
	lfs 0,0(9)
	mr 8,31
	addi 3,1,24
	lfs 12,188(31)
	mtlr 0
	addi 5,1,8
	addi 6,31,200
	li 9,3
	fadds 13,13,0
	lfs 0,192(31)
	stfs 12,8(1)
	stfs 13,16(1)
	stfs 0,12(1)
	blrl
	lwz 0,648(30)
	cmpwi 0,0,0
	bc 4,2,.L47
	lfs 0,32(1)
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfd 13,0(9)
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,31,1
	b .L51
.L47:
	lis 9,.LC7@ha
	lfs 13,32(1)
	la 9,.LC7@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L49
	lfs 11,12(30)
	addi 3,1,88
	lfs 13,4(30)
	lfs 0,8(30)
	lfs 10,36(1)
	lfs 9,40(1)
	lfs 12,44(1)
	fsubs 13,13,10
	fsubs 0,0,9
	fsubs 11,11,12
	stfs 13,88(1)
	stfs 0,92(1)
	stfs 11,96(1)
	bl VectorLength
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	lfs 0,0(9)
	fcmpu 7,1,0
	mfcr 3
	rlwinm 3,3,29,1
	b .L51
.L49:
	li 3,1
.L51:
	lwz 0,132(1)
	mtlr 0
	lmw 27,108(1)
	la 1,128(1)
	blr
.Lfe2:
	.size	 visible_box,.Lfe2-visible_box
	.section	".rodata"
	.align 2
.LC9:
	.string	"player"
	.align 2
.LC10:
	.string	"%s at %s, combattarget %s not found\n"
	.align 2
.LC11:
	.long 0x3f800000
	.align 3
.LC12:
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
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 12,2,.L65
	lwz 3,504(31)
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L65
	lwz 9,540(31)
	lis 11,level@ha
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L68
	lwz 0,level@l(11)
	la 9,level@l(11)
	li 11,128
	stw 31,240(9)
	stw 0,244(9)
	stw 11,640(31)
.L68:
	lis 11,.LC11@ha
	lis 9,level+4@ha
	la 11,.LC11@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	lfd 12,0(9)
	fadds 0,0,13
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L69
	fctiwz 0,13
	stfd 0,24(1)
	lwz 0,28(1)
	b .L70
.L69:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	xoris 0,0,0x8000
.L70:
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
	bc 4,2,.L71
	cmpwi 0,11,0
	bc 12,2,.L65
	lwz 3,504(31)
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L65
	lwz 0,776(31)
	lwz 9,540(31)
	andi. 11,0,1
	stw 9,412(31)
	bc 12,2,.L75
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	b .L76
.L75:
	lwz 9,804(31)
	mr 3,31
	mtlr 9
	blrl
.L76:
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L65
	lfs 13,4(9)
	addi 3,1,8
	lfs 0,4(31)
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
	lwz 0,776(31)
	stfs 1,424(31)
	andi. 9,0,1
	bc 4,2,.L65
	lis 11,.LC11@ha
	mr 3,31
	la 11,.LC11@l(11)
	lfs 1,0(11)
	bl AttackFinished
	b .L65
.L71:
	bl G_PickTarget
	mr 10,3
	cmpwi 0,10,0
	stw 10,416(31)
	stw 10,412(31)
	bc 4,2,.L79
	lwz 0,540(31)
	cmpwi 0,0,0
	stw 0,416(31)
	stw 0,412(31)
	bc 12,2,.L81
	lwz 3,504(31)
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L81
	lwz 0,776(31)
	lwz 9,540(31)
	andi. 11,0,1
	stw 9,412(31)
	bc 12,2,.L83
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	b .L84
.L83:
	lwz 9,804(31)
	mr 3,31
	mtlr 9
	blrl
.L84:
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L81
	lfs 13,4(9)
	addi 3,1,8
	lfs 0,4(31)
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
	lwz 0,776(31)
	stfs 1,424(31)
	andi. 9,0,1
	bc 4,2,.L81
	lis 11,.LC11@ha
	mr 3,31
	la 11,.LC11@l(11)
	lfs 1,0(11)
	bl AttackFinished
.L81:
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC10@ha
	lwz 6,320(31)
	la 3,.LC10@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L65
.L79:
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
.L65:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 FoundTarget,.Lfe3-FoundTarget
	.section	".rodata"
	.align 2
.LC13:
	.string	"target_actor"
	.align 2
.LC14:
	.string	"player_noise"
	.align 2
.LC15:
	.long 0x42a00000
	.align 2
.LC16:
	.long 0x43fa0000
	.align 2
.LC17:
	.long 0x447a0000
	.align 3
.LC18:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC19:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC20:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC21:
	.long 0x43300000
	.long 0x0
	.align 2
.LC22:
	.long 0x41200000
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
	lis 4,.LC9@ha
	lwz 3,504(31)
	la 4,.LC9@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L156
	lwz 0,776(31)
	andi. 8,0,256
	bc 12,2,.L89
	lwz 3,412(31)
	cmpwi 0,3,0
	bc 12,2,.L156
	lwz 3,280(3)
	lis 4,.LC13@ha
	la 4,.LC13@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,0
	bc 12,2,.L150
	b .L156
.L89:
	andi. 8,0,4096
	bc 4,2,.L156
	lis 9,level@ha
	li 10,0
	la 4,level@l(9)
	lwz 11,level@l(9)
	lwz 0,244(4)
	addi 11,11,-1
	cmpw 0,0,11
	bc 12,0,.L93
	lwz 0,284(31)
	andi. 9,0,1
	bc 4,2,.L93
	lwz 30,240(4)
	lwz 9,540(31)
	lwz 0,540(30)
	cmpw 0,0,9
	b .L152
.L93:
	lis 9,level@ha
	la 4,level@l(9)
	lwz 11,level@l(9)
	lwz 0,252(4)
	addi 11,11,-1
	cmpw 0,0,11
	bc 12,0,.L96
	lwz 30,248(4)
	li 10,1
	b .L95
.L96:
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L98
	lwz 0,260(4)
	cmpw 0,0,11
	bc 12,0,.L98
	lwz 0,284(31)
	andi. 11,0,1
	bc 4,2,.L98
	lwz 30,256(4)
	li 10,1
	b .L95
.L98:
	lis 9,level+236@ha
	lwz 30,level+236@l(9)
	cmpwi 0,30,0
.L152:
	bc 12,2,.L156
.L95:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L156
	lwz 0,540(31)
	cmpw 0,30,0
	bc 12,2,.L149
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L103
	lwz 0,264(30)
	b .L153
.L103:
	lwz 0,184(30)
	andi. 9,0,4
	bc 12,2,.L106
	lwz 9,540(30)
	cmpwi 0,9,0
	bc 12,2,.L156
	lwz 0,264(9)
	andi. 11,0,32
	b .L154
.L106:
	cmpwi 0,10,0
	bc 12,2,.L156
	lwz 9,256(30)
	lwz 0,264(9)
.L153:
	andi. 8,0,32
.L154:
	bc 4,2,.L156
	cmpwi 0,10,0
	bc 4,2,.L113
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
	lis 8,.LC15@ha
	la 8,.LC15@l(8)
	lfs 0,0(8)
	fcmpu 0,1,0
	bc 4,0,.L114
	li 29,0
	b .L115
.L114:
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L116
	li 29,1
	b .L115
.L116:
	lis 10,.LC17@ha
	li 29,3
	la 10,.LC17@l(10)
	lfs 0,0(10)
	fcmpu 0,1,0
	bc 4,0,.L115
	li 29,2
.L115:
	cmpwi 0,29,3
	bc 12,2,.L156
	lwz 0,640(30)
	cmpwi 0,0,5
	bc 4,1,.L156
	lwz 0,508(31)
	lis 28,0x4330
	lis 11,.LC18@ha
	lfs 13,12(31)
	lis 8,.LC19@ha
	xoris 0,0,0x8000
	la 11,.LC18@l(11)
	lfs 9,4(31)
	stw 0,124(1)
	la 8,.LC19@l(8)
	lis 10,gi+48@ha
	stw 28,120(1)
	lis 5,vec3_origin@ha
	addi 3,1,56
	lfd 11,0(11)
	la 5,vec3_origin@l(5)
	addi 4,1,24
	lfd 0,120(1)
	mr 11,9
	mr 6,5
	lfd 10,0(8)
	addi 7,1,40
	li 9,3
	lfs 12,8(31)
	mr 8,31
	fsub 0,0,11
	stfs 9,24(1)
	lwz 10,gi+48@l(10)
	stfs 12,28(1)
	fmadd 0,0,10,13
	mtlr 10
	frsp 0,0
	stfs 0,32(1)
	lfs 13,4(30)
	stfs 13,40(1)
	lfs 0,8(30)
	stfs 0,44(1)
	lfs 13,12(30)
	stfs 13,48(1)
	lwz 0,508(30)
	xoris 0,0,0x8000
	stw 0,124(1)
	stw 28,120(1)
	lfd 0,120(1)
	fsub 0,0,11
	fmadd 0,0,10,13
	frsp 0,0
	stfs 0,48(1)
	blrl
	lfs 0,64(1)
	lis 8,.LC20@ha
	la 8,.LC20@l(8)
	lfd 13,0(8)
	fcmpu 0,0,13
	bc 4,2,.L156
	cmpwi 0,29,1
	bc 4,2,.L123
	lwz 0,496(30)
	lis 10,.LC21@ha
	la 10,.LC21@l(10)
	lis 11,level+4@ha
	stw 0,124(1)
	stw 28,120(1)
	lfd 13,0(10)
	lfd 0,120(1)
	lfs 12,level+4@l(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L129
	b .L157
.L123:
	cmpwi 0,29,2
	bc 4,2,.L129
.L157:
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
	lfs 0,28(1)
	li 11,0
	lfs 13,12(1)
	lfs 12,8(1)
	lfs 11,24(1)
	fmuls 13,13,0
	lfs 10,32(1)
	lfs 0,16(1)
	lwz 0,540(31)
	fmadds 12,12,11,13
	cmpw 0,30,0
	fmadds 0,0,10,12
	fmr 9,0
	bc 12,2,.L132
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L133
.L132:
	li 11,1
.L133:
	lis 9,skill@ha
	lis 8,.LC22@ha
	lwz 10,skill@l(9)
	la 8,.LC22@l(8)
	xoris 0,11,0x8000
	lfs 10,0(8)
	lis 11,0x4330
	lfs 11,20(10)
	lis 8,.LC18@ha
	stw 0,124(1)
	la 8,.LC18@l(8)
	lis 10,.LC19@ha
	stw 11,120(1)
	la 10,.LC19@l(10)
	li 0,0
	fdivs 11,11,10
	lfd 13,0(8)
	lfd 0,120(1)
	lfd 12,0(10)
	fsub 0,0,13
	frsp 0,0
	fmuls 0,0,11
	fmr 13,0
	fsub 12,12,13
	fcmpu 0,9,12
	bc 4,1,.L134
	li 0,1
.L134:
	cmpwi 0,0,0
	bc 12,2,.L156
.L129:
	stw 30,540(31)
	lis 4,.LC14@ha
	lwz 3,280(30)
	la 4,.LC14@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L139
	lwz 0,776(31)
	lwz 11,540(31)
	rlwinm 0,0,0,30,28
	stw 0,776(31)
	lwz 9,84(11)
	cmpwi 0,9,0
	bc 4,2,.L139
	lwz 9,540(11)
	stw 9,540(31)
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 4,2,.L139
	stw 0,540(31)
.L156:
	li 3,0
	b .L150
.L113:
	lwz 0,284(31)
	andi. 8,0,1
	bc 12,2,.L140
	lwz 0,508(31)
	lis 29,0x4330
	lis 10,.LC18@ha
	lfs 13,12(31)
	lis 11,.LC19@ha
	xoris 0,0,0x8000
	la 10,.LC18@l(10)
	lfs 9,4(31)
	stw 0,124(1)
	la 11,.LC19@l(11)
	lis 5,vec3_origin@ha
	stw 29,120(1)
	la 5,vec3_origin@l(5)
	mr 8,31
	lfd 11,0(10)
	addi 3,1,56
	addi 4,1,24
	lfd 0,120(1)
	lis 10,gi+48@ha
	mr 6,5
	lfd 10,0(11)
	addi 7,1,40
	lfs 12,8(31)
	mr 11,9
	fsub 0,0,11
	stfs 9,24(1)
	li 9,3
	lwz 10,gi+48@l(10)
	stfs 12,28(1)
	fmadd 0,0,10,13
	mtlr 10
	frsp 0,0
	stfs 0,32(1)
	lfs 13,4(30)
	stfs 13,40(1)
	lfs 0,8(30)
	stfs 0,44(1)
	lfs 13,12(30)
	stfs 13,48(1)
	lwz 0,508(30)
	xoris 0,0,0x8000
	stw 0,124(1)
	stw 29,120(1)
	lfd 0,120(1)
	fsub 0,0,11
	fmadd 0,0,10,13
	frsp 0,0
	stfs 0,48(1)
	blrl
	lfs 0,64(1)
	lis 8,.LC20@ha
	la 8,.LC20@l(8)
	lfd 13,0(8)
	fcmpu 0,0,13
	bc 12,2,.L144
	b .L156
.L140:
	lis 9,gi+60@ha
	addi 3,31,4
	lwz 0,gi+60@l(9)
	addi 4,30,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	bc 12,2,.L156
.L144:
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
	lis 8,.LC17@ha
	la 8,.LC17@l(8)
	lfs 0,0(8)
	fcmpu 0,1,0
	bc 12,1,.L156
	lwz 4,176(30)
	lwz 3,176(31)
	cmpw 0,4,3
	bc 12,2,.L147
	lis 9,gi+68@ha
	lwz 0,gi+68@l(9)
	mtlr 0
	blrl
	cmpwi 0,3,0
	li 3,0
	bc 12,2,.L150
.L147:
	addi 3,1,8
	bl vectoyaw
	stfs 1,424(31)
	mr 3,31
	bl M_ChangeYaw
	lwz 0,776(31)
	stw 30,540(31)
	ori 0,0,4
	stw 0,776(31)
.L139:
	mr 3,31
	bl FoundTarget
	lwz 0,776(31)
	andi. 8,0,4
	bc 4,2,.L149
	lwz 0,820(31)
	cmpwi 0,0,0
	bc 12,2,.L149
	mr 3,31
	mtlr 0
	lwz 4,540(3)
	blrl
.L149:
	li 3,1
.L150:
	lwz 0,148(1)
	mtlr 0
	lmw 28,128(1)
	la 1,144(1)
	blr
.Lfe4:
	.size	 FindTarget,.Lfe4-FindTarget
	.section	".rodata"
	.align 2
.LC24:
	.long 0x3ecccccd
	.align 2
.LC25:
	.long 0x3e4ccccd
	.align 2
.LC26:
	.long 0x3dcccccd
	.align 2
.LC27:
	.long 0x3ca3d70a
	.align 2
.LC28:
	.long 0x46fffe00
	.align 3
.LC29:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC30:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC31:
	.long 0x0
	.align 3
.LC32:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC33:
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
	bc 4,1,.L161
	lwz 0,508(31)
	lis 28,0x4330
	lis 9,.LC30@ha
	lfs 12,12(31)
	mr 10,11
	xoris 0,0,0x8000
	la 9,.LC30@l(9)
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
	ori 9,9,25
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
	bc 4,2,.L182
.L161:
	lis 9,enemy_range@ha
	lwz 11,enemy_range@l(9)
	cmpwi 7,11,0
	bc 4,30,.L163
	lis 9,.LC31@ha
	lis 11,skill@ha
	la 9,.LC31@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L164
	bl rand
	andi. 0,3,3
	bc 4,2,.L182
.L164:
	lwz 0,816(31)
	cmpwi 0,0,0
	li 0,4
	bc 12,2,.L165
	li 0,3
.L165:
	stw 0,868(31)
	li 3,1
	b .L185
.L163:
	lwz 0,812(31)
	cmpwi 0,0,0
	bc 12,2,.L182
	lis 9,level+4@ha
	lfs 13,832(31)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	bc 12,0,.L182
	cmpwi 0,11,3
	bc 12,2,.L182
	lwz 0,776(31)
	andi. 9,0,1
	bc 12,2,.L170
	lis 9,.LC24@ha
	lfs 31,.LC24@l(9)
	b .L171
.L170:
	bc 4,30,.L172
	lis 9,.LC25@ha
	lfs 31,.LC25@l(9)
	b .L171
.L172:
	cmpwi 0,11,1
	bc 4,2,.L174
	lis 9,.LC26@ha
	lfs 31,.LC26@l(9)
	b .L171
.L174:
	cmpwi 0,11,2
	bc 4,2,.L182
	lis 9,.LC27@ha
	lfs 31,.LC27@l(9)
.L171:
	lis 11,.LC31@ha
	lis 9,skill@ha
	la 11,.LC31@l(11)
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L178
	lis 9,.LC32@ha
	fmr 0,31
	la 9,.LC32@l(9)
	lfd 13,0(9)
	fmul 0,0,13
	frsp 31,0
	b .L179
.L178:
	lis 11,.LC33@ha
	la 11,.LC33@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L179
	fadds 31,31,31
.L179:
	bl rand
	lis 29,0x4330
	lis 9,.LC30@ha
	rlwinm 3,3,0,17,31
	la 9,.LC30@l(9)
	xoris 3,3,0x8000
	lfd 30,0(9)
	lis 11,.LC28@ha
	lfs 29,.LC28@l(11)
	stw 3,116(1)
	stw 29,112(1)
	lfd 0,112(1)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,29
	fcmpu 0,0,31
	bc 4,0,.L181
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
	b .L185
.L181:
	lwz 0,264(31)
	andi. 9,0,1
	bc 12,2,.L182
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC29@ha
	stw 3,116(1)
	stw 29,112(1)
	lfd 0,112(1)
	lfd 12,.LC29@l(11)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,12
	li 0,1
	bc 4,0,.L183
	li 0,2
.L183:
	stw 0,868(31)
.L182:
	li 3,0
.L185:
	lwz 0,164(1)
	mtlr 0
	lmw 28,120(1)
	lfd 29,136(1)
	lfd 30,144(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe5:
	.size	 M_CheckAttack,.Lfe5-M_CheckAttack
	.section	".rodata"
	.align 2
.LC36:
	.long 0x4cbebc20
	.align 2
.LC37:
	.long 0x439d8000
	.align 3
.LC38:
	.long 0x40140000
	.long 0x0
	.align 2
.LC39:
	.long 0x3f800000
	.align 3
.LC40:
	.long 0x41e00000
	.long 0x0
	.align 3
.LC41:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC42:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC43:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC44:
	.long 0x40a00000
	.align 2
.LC45:
	.long 0x41200000
	.align 2
.LC46:
	.long 0x42a00000
	.align 2
.LC47:
	.long 0x43fa0000
	.align 2
.LC48:
	.long 0x447a0000
	.align 2
.LC49:
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
	bc 12,2,.L201
	lwz 0,776(31)
	andi. 8,0,4096
	bc 4,2,.L257
	andi. 9,0,4
	bc 12,2,.L201
	lwz 11,540(31)
	lis 9,level+4@ha
	lis 8,.LC38@ha
	lfs 11,level+4@l(9)
	la 8,.LC38@l(8)
	lfs 0,604(11)
	lfd 13,0(8)
	fsubs 0,11,0
	fcmpu 0,0,13
	bc 4,1,.L204
	cmpw 0,10,11
	bc 4,2,.L205
	lwz 0,416(31)
	cmpwi 0,0,0
	stw 0,412(31)
.L205:
	lwz 9,776(31)
	andi. 10,9,2
	rlwinm 0,9,0,30,28
	stw 0,776(31)
	bc 12,2,.L201
	rlwinm 0,9,0,0,28
	stw 0,776(31)
	b .L201
.L204:
	lis 11,.LC39@ha
	lis 8,.LC40@ha
	la 11,.LC39@l(11)
	la 8,.LC40@l(8)
	lfs 0,0(11)
	lfd 12,0(8)
	fadds 0,11,0
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L210
	fctiwz 0,13
	stfd 0,136(1)
	lwz 0,140(1)
	b .L211
.L210:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,136(1)
	lwz 0,140(1)
	xoris 0,0,0x8000
.L211:
	stw 0,496(31)
	b .L257
.L201:
	lwz 10,540(31)
	lis 9,enemy_vis@ha
	li 0,0
	stw 0,enemy_vis@l(9)
	cmpwi 0,10,0
	li 9,0
	bc 12,2,.L213
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 4,2,.L212
.L213:
	li 9,1
	b .L214
.L212:
	lwz 11,776(31)
	andi. 0,11,8192
	bc 12,2,.L215
	lwz 0,480(10)
	cmpwi 0,0,0
	bc 4,1,.L214
	rlwinm 0,11,0,19,17
	li 9,1
	stw 0,776(31)
	b .L214
.L215:
	andi. 8,11,512
	bc 12,2,.L218
	lwz 0,480(10)
	cmpwi 7,0,-80
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	b .L214
.L218:
	lwz 0,480(10)
	srawi 9,0,31
	subf 9,0,9
	srawi 9,9,31
	addi 9,9,1
.L214:
	cmpwi 0,9,0
	bc 12,2,.L222
	lwz 9,544(31)
	li 11,0
	stw 11,540(31)
	cmpwi 0,9,0
	bc 12,2,.L223
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L223
	lwz 3,504(31)
	lis 4,.LC9@ha
	stw 9,540(31)
	la 4,.LC9@l(4)
	stw 11,544(31)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L222
	lwz 0,776(31)
	lwz 9,540(31)
	andi. 8,0,1
	stw 9,412(31)
	bc 12,2,.L227
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	b .L228
.L227:
	lwz 9,804(31)
	mr 3,31
	mtlr 9
	blrl
.L228:
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L222
	lfs 0,4(31)
	addi 3,1,24
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
	lwz 0,776(31)
	stfs 1,424(31)
	andi. 8,0,1
	bc 4,2,.L222
	lis 9,.LC39@ha
	mr 3,31
	la 9,.LC39@l(9)
	lfs 1,0(9)
	bl AttackFinished
	b .L222
.L223:
	lwz 0,416(31)
	cmpwi 0,0,0
	bc 12,2,.L232
	lwz 11,800(31)
	mr 3,31
	stw 0,412(31)
	mtlr 11
	blrl
	b .L256
.L232:
	lis 9,level+4@ha
	lis 11,.LC36@ha
	lwz 10,788(31)
	lfs 0,level+4@l(9)
	mr 3,31
	lfs 13,.LC36@l(11)
	mtlr 10
	fadds 0,0,13
	stfs 0,828(31)
	blrl
	b .L256
.L222:
	lis 8,.LC39@ha
	lis 9,level+4@ha
	la 8,.LC39@l(8)
	lfs 0,level+4@l(9)
	lfs 13,0(8)
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfd 12,0(9)
	fadds 0,0,13
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L234
	fctiwz 0,13
	stfd 0,136(1)
	lwz 12,140(1)
	b .L235
.L234:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,136(1)
	lwz 12,140(1)
	xoris 12,12,0x8000
.L235:
	lwz 0,508(31)
	lis 28,0x4330
	lis 10,.LC41@ha
	lfs 13,12(31)
	lis 11,.LC42@ha
	xoris 0,0,0x8000
	la 10,.LC41@l(10)
	lfs 9,4(31)
	stw 0,140(1)
	la 11,.LC42@l(11)
	lis 29,gi+48@ha
	stw 28,136(1)
	lis 5,vec3_origin@ha
	mr 8,31
	lfd 11,0(10)
	la 5,vec3_origin@l(5)
	addi 3,1,72
	lfd 0,136(1)
	mr 10,9
	addi 4,1,40
	lfd 10,0(11)
	li 9,3
	mr 6,5
	lfs 12,8(31)
	addi 7,1,56
	fsub 0,0,11
	stw 12,496(31)
	lwz 11,540(31)
	stfs 9,40(1)
	fmadd 0,0,10,13
	stfs 12,44(1)
	lwz 29,gi+48@l(29)
	frsp 0,0
	mtlr 29
	stfs 0,48(1)
	lfs 13,4(11)
	stfs 13,56(1)
	lfs 0,8(11)
	stfs 0,60(1)
	lfs 13,12(11)
	stfs 13,64(1)
	lwz 0,508(11)
	xoris 0,0,0x8000
	stw 0,140(1)
	stw 28,136(1)
	lfd 0,136(1)
	fsub 0,0,11
	fmadd 0,0,10,13
	frsp 0,0
	stfs 0,64(1)
	blrl
	lfs 0,80(1)
	lis 8,.LC43@ha
	lis 9,enemy_vis@ha
	la 8,.LC43@l(8)
	lfd 13,0(8)
	fcmpu 7,0,13
	mfcr 0
	rlwinm 0,0,31,1
	cmpwi 0,0,0
	stw 0,enemy_vis@l(9)
	bc 12,2,.L238
	lis 9,.LC44@ha
	lis 11,level+4@ha
	la 9,.LC44@l(9)
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
.L238:
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
	lfs 0,44(1)
	li 11,0
	lfs 13,28(1)
	lfs 12,24(1)
	lfs 11,40(1)
	fmuls 13,13,0
	lfs 10,48(1)
	lfs 0,32(1)
	lwz 0,540(31)
	fmadds 12,12,11,13
	cmpw 0,29,0
	fmadds 0,0,10,12
	fmr 9,0
	bc 12,2,.L239
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L240
.L239:
	li 11,1
.L240:
	lis 9,skill@ha
	lis 8,.LC45@ha
	lwz 10,skill@l(9)
	la 8,.LC45@l(8)
	xoris 0,11,0x8000
	lfs 10,0(8)
	lis 11,0x4330
	lfs 11,20(10)
	lis 8,.LC41@ha
	stw 0,140(1)
	la 8,.LC41@l(8)
	lis 10,.LC42@ha
	stw 11,136(1)
	la 10,.LC42@l(10)
	li 0,0
	fdivs 11,11,10
	lfd 13,0(8)
	lfd 0,136(1)
	lfd 12,0(10)
	fsub 0,0,13
	frsp 0,0
	fmuls 0,0,11
	fmr 13,0
	fsub 12,12,13
	fcmpu 0,9,12
	bc 4,1,.L241
	li 0,1
.L241:
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
	lis 8,.LC46@ha
	la 8,.LC46@l(8)
	lfs 0,0(8)
	fcmpu 0,1,0
	bc 4,0,.L243
	li 0,0
	b .L244
.L243:
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L245
	li 0,1
	b .L244
.L245:
	lis 10,.LC48@ha
	li 0,3
	la 10,.LC48@l(10)
	lfs 0,0(10)
	fcmpu 0,1,0
	bc 4,0,.L244
	li 0,2
.L244:
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
	bc 4,2,.L247
	stfs 1,424(31)
	mr 3,31
	bl M_ChangeYaw
	lfs 0,20(31)
	lfs 1,424(31)
	fsubs 1,0,1
	bl anglemod
	lis 8,.LC49@ha
	lis 9,.LC37@ha
	la 8,.LC49@l(8)
	lfs 0,.LC37@l(9)
	lfs 13,0(8)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 10,0,9
	bc 4,2,.L256
	lwz 9,812(31)
	b .L259
.L247:
	cmpwi 0,0,3
	bc 4,2,.L252
	stfs 1,424(31)
	mr 3,31
	bl M_ChangeYaw
	lfs 0,20(31)
	lfs 1,424(31)
	fsubs 1,0,1
	bl anglemod
	lis 8,.LC49@ha
	lis 9,.LC37@ha
	la 8,.LC49@l(8)
	lfs 0,.LC37@l(9)
	lfs 13,0(8)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 10,0,9
	bc 4,2,.L256
	lwz 9,816(31)
.L259:
	mr 3,31
	mtlr 9
	blrl
	li 0,1
	stw 0,868(31)
.L256:
	li 3,1
	b .L258
.L252:
	lis 9,enemy_vis@ha
	lwz 0,enemy_vis@l(9)
	cmpwi 0,0,0
	bc 12,2,.L257
	lwz 0,824(31)
	mr 3,31
	mtlr 0
	blrl
	b .L258
.L257:
	li 3,0
.L258:
	lwz 0,164(1)
	mtlr 0
	lmw 28,144(1)
	la 1,160(1)
	blr
.Lfe6:
	.size	 ai_checkattack,.Lfe6-ai_checkattack
	.section	".rodata"
	.align 2
.LC50:
	.string	"NIQ: call to ai_run with no bots?\n"
	.section	".text"
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
.L261:
	lis 9,level+236@ha
	stw 11,level+236@l(9)
	blr
.L7:
	lis 11,g_edicts@ha
	lis 9,0xf3b3
	lwz 0,g_edicts@l(11)
	ori 9,9,8069
	subf 0,0,10
	mullw 0,0,9
	srawi 7,0,2
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
	mfcr 9
	rlwinm 9,9,29,1
	neg 9,9
	addi 11,9,1
	and 9,8,9
	or 8,9,11
	mulli 0,8,1332
	add 11,10,0
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L13
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L13
	lwz 0,264(11)
	andi. 9,0,32
	bc 12,2,.L261
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
.LC51:
	.long 0x46fffe00
	.align 2
.LC52:
	.long 0x0
	.align 3
.LC53:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC54:
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
	bc 4,2,.L29
	lwz 0,796(31)
	cmpwi 0,0,0
	bc 12,2,.L29
	lis 9,level@ha
	lfs 13,876(31)
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,0,13
	bc 4,1,.L29
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L32
	mtlr 0
	mr 3,31
	blrl
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,4(30)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC53@ha
	lis 11,.LC51@ha
	la 10,.LC53@l(10)
	stw 0,16(1)
	lfd 11,0(10)
	lfd 0,16(1)
	lis 10,.LC54@ha
	lfs 13,.LC51@l(11)
	la 10,.LC54@l(10)
	lfs 10,0(10)
	fsub 0,0,11
	fadds 12,12,10
	frsp 0,0
	fdivs 0,0,13
	fmadds 0,0,10,12
	b .L262
.L32:
	bl rand
	rlwinm 3,3,0,17,31
	lfs 10,4(30)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC53@ha
	lis 11,.LC51@ha
	la 10,.LC53@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC54@ha
	lfs 12,.LC51@l(11)
	la 10,.LC54@l(10)
	lfs 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmadds 0,0,11,10
.L262:
	stfs 0,876(31)
.L29:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 ai_walk,.Lfe9-ai_walk
	.section	".rodata"
	.align 2
.LC55:
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
	lis 9,.LC55@ha
	mr 31,3
	la 9,.LC55@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,2,.L37
	fmr 2,1
	lfs 1,20(31)
	bl M_walkmove
.L37:
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 4,2,.L36
	mr 3,31
	bl M_ChangeYaw
.L36:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 ai_turn,.Lfe10-ai_turn
	.align 2
	.globl ai_run
	.type	 ai_run,@function
ai_run:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+4@ha
	lis 3,.LC50@ha
	lwz 0,gi+4@l(9)
	la 3,.LC50@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 ai_run,.Lfe11-ai_run
	.section	".rodata"
	.align 2
.LC56:
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
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 12,2,.L35
	mr 3,31
	fmr 2,31
	lfs 1,20(3)
	bl M_walkmove
.L35:
	lwz 0,52(1)
	mtlr 0
	lwz 31,36(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 ai_charge,.Lfe12-ai_charge
	.section	".rodata"
	.align 2
.LC57:
	.long 0x42a00000
	.align 2
.LC58:
	.long 0x43fa0000
	.align 2
.LC59:
	.long 0x447a0000
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
	lis 9,.LC57@ha
	la 9,.LC57@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L40
	li 3,0
	b .L263
.L40:
	lis 9,.LC58@ha
	la 9,.LC58@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L41
	lis 9,.LC59@ha
	la 9,.LC59@l(9)
	lfs 0,0(9)
	fcmpu 7,1,0
	mfcr 3
	rlwinm 3,3,29,1
	neg 3,3
	nor 0,3,3
	rlwinm 3,3,0,30,30
	rlwinm 0,0,0,30,31
	or 3,3,0
	b .L263
.L41:
	li 3,1
.L263:
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe13:
	.size	 range,.Lfe13-range
	.section	".rodata"
	.align 2
.LC60:
	.long 0x41200000
	.align 3
.LC61:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC62:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl infront
	.type	 infront,@function
infront:
	stwu 1,-80(1)
	mflr 0
	stmw 29,68(1)
	stw 0,84(1)
	mr 31,3
	mr 29,4
	addi 4,1,24
	addi 3,31,16
	li 5,0
	li 6,0
	bl AngleVectors
	lfs 11,4(31)
	addi 3,1,8
	lfs 12,4(29)
	lfs 10,8(31)
	lfs 13,8(29)
	fsubs 12,12,11
	lfs 0,12(29)
	lfs 11,12(31)
	fsubs 13,13,10
	stfs 12,8(1)
	fsubs 0,0,11
	stfs 13,12(1)
	stfs 0,16(1)
	bl VectorNormalize
	lfs 0,28(1)
	li 11,0
	lfs 13,12(1)
	lfs 12,8(1)
	lfs 11,24(1)
	fmuls 13,13,0
	lfs 10,32(1)
	lfs 0,16(1)
	lwz 0,540(31)
	fmadds 12,12,11,13
	cmpw 0,29,0
	fmadds 0,0,10,12
	fmr 9,0
	bc 12,2,.L57
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L56
.L57:
	li 11,1
.L56:
	lis 9,skill@ha
	lis 8,.LC60@ha
	lwz 10,skill@l(9)
	la 8,.LC60@l(8)
	xoris 0,11,0x8000
	lfs 10,0(8)
	lis 11,0x4330
	lfs 11,20(10)
	lis 8,.LC61@ha
	stw 0,60(1)
	la 8,.LC61@l(8)
	lis 10,.LC62@ha
	stw 11,56(1)
	la 10,.LC62@l(10)
	fdivs 11,11,10
	lfd 13,0(8)
	lfd 0,56(1)
	lfd 12,0(10)
	fsub 0,0,13
	frsp 0,0
	fmuls 0,0,11
	fmr 13,0
	fsub 12,12,13
	fcmpu 7,9,12
	mfcr 3
	rlwinm 3,3,30,1
	lwz 0,84(1)
	mtlr 0
	lmw 29,68(1)
	la 1,80(1)
	blr
.Lfe14:
	.size	 infront,.Lfe14-infront
	.section	".rodata"
	.align 3
.LC63:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC64:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC65:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl visible
	.type	 visible,@function
visible:
	stwu 1,-144(1)
	mflr 0
	stmw 27,124(1)
	stw 0,148(1)
	mr 29,3
	mr 28,4
	lwz 0,508(29)
	lis 7,0x4330
	lwz 11,508(28)
	mr 10,9
	lis 8,.LC63@ha
	xoris 0,0,0x8000
	la 8,.LC63@l(8)
	lfs 11,12(29)
	stw 0,116(1)
	xoris 11,11,0x8000
	lis 27,gi+48@ha
	stw 7,112(1)
	lis 5,vec3_origin@ha
	addi 3,1,40
	lfd 13,112(1)
	la 5,vec3_origin@l(5)
	addi 4,1,8
	stw 11,116(1)
	mr 6,5
	li 9,3
	stw 7,112(1)
	lfs 12,12(28)
	addi 7,1,24
	lfd 10,0(8)
	lfd 0,112(1)
	lis 8,.LC64@ha
	la 8,.LC64@l(8)
	lwz 0,gi+48@l(27)
	lfd 7,0(8)
	fsub 13,13,10
	fsub 0,0,10
	lfs 9,4(29)
	mr 8,29
	mtlr 0
	lfs 8,8(29)
	fmadd 13,13,7,11
	lfs 10,4(28)
	fmadd 0,0,7,12
	lfs 11,8(28)
	stfs 9,8(1)
	frsp 13,13
	stfs 8,12(1)
	frsp 0,0
	stfs 10,24(1)
	stfs 11,28(1)
	stfs 13,16(1)
	stfs 0,32(1)
	blrl
	lfs 0,48(1)
	lis 8,.LC65@ha
	la 8,.LC65@l(8)
	lfd 13,0(8)
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,31,1
	lwz 0,148(1)
	mtlr 0
	lmw 27,124(1)
	la 1,144(1)
	blr
.Lfe15:
	.size	 visible,.Lfe15-visible
	.section	".rodata"
	.align 2
.LC66:
	.long 0x439d8000
	.align 2
.LC67:
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
	lis 11,.LC67@ha
	lis 9,.LC66@ha
	la 11,.LC67@l(11)
	lfs 0,.LC66@l(9)
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
.Lfe16:
	.size	 FacingIdeal,.Lfe16-FacingIdeal
	.section	".rodata"
	.align 3
.LC68:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl visible_fullbox
	.type	 visible_fullbox,@function
visible_fullbox:
	stwu 1,-144(1)
	mflr 0
	stw 0,148(1)
	lis 9,gi+48@ha
	mr 11,3
	lwz 0,gi+48@l(9)
	mr 10,4
	addi 3,1,72
	lfs 0,204(11)
	li 9,3
	mr 8,11
	lfs 13,208(11)
	addi 4,1,8
	addi 5,1,40
	mtlr 0
	lfs 3,12(10)
	addi 6,1,56
	addi 7,1,24
	lfs 4,200(11)
	lfs 12,188(11)
	lfs 11,192(11)
	lfs 10,196(11)
	lfs 9,4(11)
	lfs 8,8(11)
	lfs 7,12(11)
	lfs 6,4(10)
	lfs 5,8(10)
	stfs 0,60(1)
	stfs 13,64(1)
	stfs 4,56(1)
	stfs 12,40(1)
	stfs 11,44(1)
	stfs 10,48(1)
	stfs 9,8(1)
	stfs 8,12(1)
	stfs 7,16(1)
	stfs 6,24(1)
	stfs 5,28(1)
	stfs 3,32(1)
	blrl
	lfs 0,80(1)
	lis 9,.LC68@ha
	la 9,.LC68@l(9)
	lfd 13,0(9)
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,31,1
	lwz 0,148(1)
	mtlr 0
	la 1,144(1)
	blr
.Lfe17:
	.size	 visible_fullbox,.Lfe17-visible_fullbox
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
	.comm	enemy_vis,4,4
	.comm	enemy_infront,4,4
	.comm	enemy_range,4,4
	.comm	enemy_yaw,4,4
	.section	".rodata"
	.align 2
.LC69:
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
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 12,2,.L58
	lwz 3,504(31)
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L58
	lwz 0,776(31)
	lwz 9,540(31)
	andi. 11,0,1
	stw 9,412(31)
	bc 12,2,.L61
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	b .L62
.L61:
	lwz 9,804(31)
	mr 3,31
	mtlr 9
	blrl
.L62:
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L58
	lfs 13,4(9)
	addi 3,1,8
	lfs 0,4(31)
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
	lwz 0,776(31)
	stfs 1,424(31)
	andi. 9,0,1
	bc 4,2,.L58
	lis 11,.LC69@ha
	mr 3,31
	la 11,.LC69@l(11)
	lfs 1,0(11)
	bl AttackFinished
.L58:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 HuntTarget,.Lfe18-HuntTarget
	.section	".rodata"
	.align 2
.LC70:
	.long 0x439d8000
	.align 2
.LC71:
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
	lis 11,.LC71@ha
	lis 9,.LC70@ha
	la 11,.LC71@l(11)
	lfs 0,.LC70@l(9)
	lfs 13,0(11)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 11,0,9
	bc 4,2,.L189
	lwz 9,816(31)
	mr 3,31
	mtlr 9
	blrl
	li 0,1
	stw 0,868(31)
.L189:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe19:
	.size	 ai_run_melee,.Lfe19-ai_run_melee
	.section	".rodata"
	.align 2
.LC72:
	.long 0x439d8000
	.align 2
.LC73:
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
	bc 4,2,.L193
	lwz 9,812(31)
	mr 3,31
	mtlr 9
	blrl
	li 0,1
	stw 0,868(31)
.L193:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe20:
	.size	 ai_run_missile,.Lfe20-ai_run_missile
	.section	".rodata"
	.align 2
.LC74:
	.long 0xc2b40000
	.align 2
.LC75:
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
	lis 9,.LC74@ha
	la 9,.LC74@l(9)
	lfs 31,0(9)
	stfs 0,424(31)
	bl M_ChangeYaw
	lwz 0,872(31)
	cmpwi 0,0,0
	bc 12,2,.L197
	lis 9,.LC75@ha
	la 9,.LC75@l(9)
	lfs 31,0(9)
.L197:
	lfs 1,424(31)
	fmr 2,30
	mr 3,31
	fadds 1,1,31
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L196
	lfs 1,424(31)
	fmr 2,30
	mr 3,31
	lwz 0,872(31)
	fsubs 1,1,31
	subfic 0,0,1
	stw 0,872(31)
	bl M_walkmove
.L196:
	lwz 0,36(1)
	mtlr 0
	lwz 31,12(1)
	lfd 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 ai_run_slide,.Lfe21-ai_run_slide
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
