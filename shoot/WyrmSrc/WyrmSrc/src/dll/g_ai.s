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
	lwz 0,776(31)
	andis. 9,0,1
	bc 4,2,.L22
	mr 3,31
	bl M_ChangeYaw
.L22:
	lis 9,.LC1@ha
	mr 3,31
	la 9,.LC1@l(9)
	lfs 1,0(9)
	bl ai_checkattack
	lwz 4,540(31)
	mr 30,3
	cmpwi 0,4,0
	bc 12,2,.L23
	lwz 0,88(4)
	cmpwi 0,0,0
	bc 12,2,.L23
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L23
	lwz 0,776(31)
	lis 11,level+4@ha
	li 10,0
	lwz 9,540(31)
	rlwinm 0,0,0,29,27
	stw 0,776(31)
	lfs 0,4(9)
	stfs 0,856(31)
	lfs 13,8(9)
	stfs 13,860(31)
	lfs 0,12(9)
	stfs 0,864(31)
	lfs 13,4(9)
	stfs 13,956(31)
	lfs 0,8(9)
	stfs 0,960(31)
	lfs 13,12(9)
	stfs 13,964(31)
	lfs 0,level+4@l(11)
	stw 10,952(31)
	stfs 0,852(31)
	b .L17
.L23:
	cmpwi 0,30,0
	bc 4,2,.L17
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
	bc 4,1,.L28
	lwz 0,800(31)
	mr 3,31
	mtlr 0
	blrl
	b .L17
.L28:
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
	bc 12,2,.L30
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
	b .L32
.L30:
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
.L32:
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
	.string	"tesla"
	.align 2
.LC6:
	.long 0x0
	.align 2
.LC7:
	.long 0xc2b40000
	.align 2
.LC8:
	.long 0x42b40000
	.section	".text"
	.align 2
	.globl ai_charge
	.type	 ai_charge,@function
ai_charge:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stw 31,28(1)
	stw 0,52(1)
	mr 31,3
	fmr 30,1
	lwz 4,540(31)
	cmpwi 0,4,0
	bc 12,2,.L38
	lwz 0,88(4)
	cmpwi 0,0,0
	bc 12,2,.L38
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L41
	lwz 9,540(31)
	lfs 0,4(9)
	stfs 0,956(31)
	lfs 13,8(9)
	stfs 13,960(31)
	lfs 0,12(9)
	stfs 0,964(31)
.L41:
	lwz 0,776(31)
	andis. 9,0,1
	bc 4,2,.L42
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
.L42:
	mr 3,31
	bl M_ChangeYaw
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 0,0(9)
	fcmpu 0,30,0
	bc 12,2,.L38
	lwz 0,776(31)
	andis. 9,0,8
	bc 12,2,.L44
	fmr 1,30
	mr 3,31
	bl M_MoveToGoal
	b .L38
.L44:
	lwz 0,868(31)
	cmpwi 0,0,2
	bc 4,2,.L45
	lwz 3,540(31)
	cmpwi 0,3,0
	bc 12,2,.L46
	lwz 3,280(3)
	cmpwi 0,3,0
	bc 12,2,.L46
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L46
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	b .L52
.L46:
	lwz 0,872(31)
	lis 9,.LC7@ha
	la 9,.LC7@l(9)
	cmpwi 0,0,0
	lfs 31,0(9)
	bc 12,2,.L47
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
.L52:
	lfs 31,0(9)
.L47:
	lfs 1,424(31)
	fmr 2,30
	mr 3,31
	fadds 1,1,31
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L38
	lfs 1,424(31)
	fmr 2,30
	mr 3,31
	lwz 0,872(31)
	fsubs 1,1,31
	subfic 0,0,1
	stw 0,872(31)
	bl M_walkmove
	b .L38
.L45:
	mr 3,31
	fmr 2,30
	lfs 1,20(3)
	bl M_walkmove
.L38:
	lwz 0,52(1)
	mtlr 0
	lwz 31,28(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 ai_charge,.Lfe2-ai_charge
	.section	".rodata"
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
	lis 11,level@ha
	lwz 9,540(31)
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L71
	lwz 0,level@l(11)
	la 9,level@l(11)
	li 11,128
	stw 31,240(9)
	stw 0,244(9)
	stw 11,640(31)
.L71:
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
	bc 12,3,.L72
	fctiwz 0,13
	stfd 0,24(1)
	lwz 0,28(1)
	b .L73
.L72:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	xoris 0,0,0x8000
.L73:
	lwz 11,540(31)
	lis 9,level+4@ha
	li 29,0
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
	lfs 0,4(11)
	stfs 0,956(31)
	lfs 13,8(11)
	stfs 13,960(31)
	lfs 0,12(11)
	stw 29,952(31)
	stfs 0,964(31)
	bc 4,2,.L74
	lwz 0,776(31)
	stw 11,412(31)
	andi. 11,0,1
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
	lwz 0,776(31)
	stfs 1,424(31)
	andi. 9,0,1
	bc 4,2,.L70
	lis 11,.LC11@ha
	mr 3,31
	la 11,.LC11@l(11)
	lfs 1,0(11)
	bl AttackFinished
	b .L70
.L74:
	bl G_PickTarget
	mr 11,3
	cmpwi 0,11,0
	stw 11,416(31)
	stw 11,412(31)
	bc 4,2,.L79
	lwz 0,776(31)
	lwz 9,540(31)
	andi. 11,0,1
	stw 9,412(31)
	stw 9,416(31)
	bc 12,2,.L80
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	b .L81
.L80:
	lwz 9,804(31)
	mr 3,31
	mtlr 9
	blrl
.L81:
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
	lwz 0,776(31)
	stfs 1,424(31)
	andi. 9,0,1
	bc 4,2,.L83
	lis 11,.LC11@ha
	mr 3,31
	la 11,.LC11@l(11)
	lfs 1,0(11)
	bl AttackFinished
.L83:
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
	b .L70
.L79:
	lwz 0,776(31)
	li 9,0
	mr 3,31
	stw 9,320(31)
	ori 0,0,4096
	stw 0,776(31)
	stw 9,300(11)
	lwz 0,804(31)
	stw 29,828(31)
	mtlr 0
	blrl
.L70:
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
.LC15:
	.string	"player_noise"
	.align 3
.LC14:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC16:
	.long 0x0
	.align 2
.LC17:
	.long 0x42a00000
	.align 2
.LC18:
	.long 0x43fa0000
	.align 2
.LC19:
	.long 0x447a0000
	.align 3
.LC20:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC21:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC22:
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
	bc 12,2,.L85
	lwz 3,412(31)
	cmpwi 0,3,0
	bc 12,2,.L156
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L156
	lwz 3,280(3)
	cmpwi 0,3,0
	bc 12,2,.L156
	lis 4,.LC13@ha
	la 4,.LC13@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,0
	bc 12,2,.L150
	b .L156
.L85:
	andi. 9,0,4096
	bc 4,2,.L156
	lis 9,level@ha
	li 10,0
	la 4,level@l(9)
	lwz 11,level@l(9)
	lwz 0,244(4)
	addi 11,11,-1
	cmpw 0,0,11
	bc 12,0,.L89
	lwz 0,284(31)
	andi. 11,0,1
	bc 4,2,.L89
	lwz 30,240(4)
	lwz 9,540(31)
	lwz 0,540(30)
	cmpw 0,0,9
	b .L152
.L89:
	lis 9,level@ha
	la 4,level@l(9)
	lwz 11,level@l(9)
	lwz 0,252(4)
	addi 11,11,-1
	cmpw 0,0,11
	bc 12,0,.L92
	lwz 30,248(4)
	li 10,1
	b .L91
.L92:
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L94
	lwz 0,260(4)
	cmpw 0,0,11
	bc 12,0,.L94
	lwz 0,284(31)
	andi. 9,0,1
	bc 4,2,.L94
	lwz 30,256(4)
	li 10,1
	b .L91
.L94:
	lis 9,level+236@ha
	lwz 30,level+236@l(9)
	cmpwi 0,30,0
.L152:
	bc 12,2,.L156
.L91:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L156
	lwz 0,540(31)
	cmpw 0,30,0
	bc 12,2,.L149
	lwz 0,776(31)
	andis. 11,0,16
	bc 12,2,.L99
	lis 9,coop@ha
	lwz 9,coop@l(9)
	cmpwi 0,9,0
	bc 12,2,.L99
	lfs 13,20(9)
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfs 0,0(9)
	fcmpu 7,13,0
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	and 10,10,0
.L99:
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L100
	lwz 0,264(30)
	andi. 11,0,32
	bc 4,2,.L156
	lwz 0,184(30)
	b .L153
.L100:
	lwz 0,184(30)
	andi. 11,0,4
	bc 12,2,.L104
	lwz 9,540(30)
	cmpwi 0,9,0
	bc 12,2,.L156
	lwz 0,264(9)
	andi. 11,0,32
	bc 4,2,.L156
	lwz 0,184(9)
.L153:
	andi. 9,0,1
	bc 12,2,.L103
.L156:
	li 3,0
	b .L150
.L104:
	cmpwi 0,10,0
	bc 12,2,.L156
	lwz 9,256(30)
	cmpwi 0,9,0
	bc 12,2,.L103
	lwz 0,264(9)
	andi. 11,0,32
	bc 12,2,.L103
	lwz 0,184(9)
	andi. 9,0,1
	bc 12,2,.L156
.L103:
	cmpwi 0,10,0
	bc 4,2,.L112
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
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L113
	li 28,0
	b .L114
.L113:
	lis 11,.LC18@ha
	la 11,.LC18@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	bc 4,0,.L115
	li 28,1
	b .L114
.L115:
	lis 9,.LC19@ha
	li 28,3
	la 9,.LC19@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L114
	li 28,2
.L114:
	cmpwi 0,28,3
	bc 12,2,.L156
	lwz 0,640(30)
	cmpwi 0,0,5
	bc 4,1,.L156
	lwz 0,508(31)
	lis 29,0x4330
	lis 11,.LC20@ha
	lfs 12,12(31)
	lis 10,gi+48@ha
	xoris 0,0,0x8000
	la 11,.LC20@l(11)
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
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L120
	lwz 0,108(1)
	cmpw 0,0,30
	bc 4,2,.L121
.L120:
	li 0,1
	b .L122
.L121:
	li 0,0
.L122:
	cmpwi 0,0,0
	bc 12,2,.L156
	cmpwi 0,28,1
	bc 4,2,.L123
	lwz 10,496(30)
	lis 0,0x4330
	lis 11,.LC22@ha
	stw 10,124(1)
	la 11,.LC22@l(11)
	stw 0,120(1)
	lfd 13,0(11)
	lfd 0,120(1)
	lis 11,level+4@ha
	lfs 12,level+4@l(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L127
	b .L157
.L123:
	cmpwi 0,28,2
	bc 4,2,.L127
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
	lis 9,.LC14@ha
	li 0,0
	lfs 11,12(1)
	lfs 12,8(1)
	lfs 10,24(1)
	fmuls 11,11,0
	lfs 9,32(1)
	lfs 0,16(1)
	lfd 13,.LC14@l(9)
	fmadds 12,12,10,11
	fmadds 0,0,9,12
	fcmpu 0,0,13
	bc 4,1,.L130
	li 0,1
.L130:
	cmpwi 0,0,0
	bc 12,2,.L156
.L127:
	stw 30,540(31)
	lis 4,.LC15@ha
	lwz 3,280(30)
	la 4,.LC15@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L135
	lwz 0,776(31)
	lwz 11,540(31)
	rlwinm 0,0,0,30,28
	stw 0,776(31)
	lwz 9,84(11)
	cmpwi 0,9,0
	bc 4,2,.L135
	lwz 9,540(11)
	stw 9,540(31)
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 4,2,.L135
	stw 0,540(31)
	b .L156
.L112:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L136
	lwz 0,508(31)
	lis 29,0x4330
	lis 11,.LC20@ha
	lfs 12,12(31)
	lis 10,gi+48@ha
	xoris 0,0,0x8000
	la 11,.LC20@l(11)
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
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L138
	lwz 0,108(1)
	cmpw 0,0,30
	bc 4,2,.L139
.L138:
	li 0,1
	b .L140
.L139:
	li 0,0
.L140:
	cmpwi 0,0,0
	b .L154
.L136:
	lis 9,gi+60@ha
	addi 3,31,4
	lwz 0,gi+60@l(9)
	addi 4,30,4
	mtlr 0
	blrl
	cmpwi 0,3,0
.L154:
	bc 12,2,.L156
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
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,1,.L156
	lwz 4,176(30)
	lwz 3,176(31)
	cmpw 0,4,3
	bc 12,2,.L144
	lis 9,gi+68@ha
	lwz 0,gi+68@l(9)
	mtlr 0
	blrl
	cmpwi 0,3,0
	li 3,0
	bc 12,2,.L150
.L144:
	addi 3,1,8
	bl vectoyaw
	lwz 0,776(31)
	stfs 1,424(31)
	andis. 9,0,1
	bc 4,2,.L146
	mr 3,31
	bl M_ChangeYaw
.L146:
	lwz 0,776(31)
	stw 30,540(31)
	ori 0,0,4
	stw 0,776(31)
.L135:
	lwz 0,776(31)
	andis. 9,0,16
	bc 12,2,.L147
	mr 3,31
	bl hintpath_stop
	b .L148
.L147:
	mr 3,31
	bl FoundTarget
.L148:
	lwz 0,776(31)
	andi. 9,0,4
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
.LC29:
	.string	"monster_daedalus"
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
	.align 2
.LC30:
	.long 0x3f4ccccd
	.align 2
.LC31:
	.long 0x3f19999a
	.align 3
.LC32:
	.long 0x3fd99999
	.long 0x9999999a
	.align 3
.LC33:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC34:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC35:
	.long 0x40340000
	.long 0x0
	.align 2
.LC36:
	.long 0x0
	.align 3
.LC37:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC38:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl M_CheckAttack
	.type	 M_CheckAttack,@function
M_CheckAttack:
	stwu 1,-272(1)
	mflr 0
	stfd 29,248(1)
	stfd 30,256(1)
	stfd 31,264(1)
	stmw 27,228(1)
	stw 0,276(1)
	mr 31,3
	lwz 30,540(31)
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L161
	lwz 0,508(31)
	lis 29,0x4330
	lis 9,.LC33@ha
	lfs 13,12(31)
	mr 10,11
	xoris 0,0,0x8000
	la 9,.LC33@l(9)
	lfs 12,8(31)
	stw 0,220(1)
	addi 3,1,40
	addi 4,1,8
	stw 29,216(1)
	li 5,0
	li 6,0
	lfd 31,0(9)
	addi 7,1,24
	mr 8,31
	lfd 0,216(1)
	lis 9,gi@ha
	mr 27,3
	lfs 11,4(31)
	la 28,gi@l(9)
	stfs 12,12(1)
	lis 9,0x200
	fsub 0,0,31
	lwz 11,48(28)
	ori 9,9,27
	stfs 11,8(1)
	mtlr 11
	frsp 0,0
	fadds 13,13,0
	stfs 13,16(1)
	lfs 0,4(30)
	stfs 0,24(1)
	lfs 13,8(30)
	stfs 13,28(1)
	lfs 12,12(30)
	stfs 12,32(1)
	lwz 0,508(30)
	xoris 0,0,0x8000
	stw 0,220(1)
	stw 29,216(1)
	lfd 0,216(1)
	fsub 0,0,31
	frsp 0,0
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	lwz 9,92(1)
	lwz 30,540(31)
	cmpw 0,9,30
	bc 12,2,.L161
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 4,2,.L164
	lfs 0,48(1)
	lis 11,.LC34@ha
	la 11,.LC34@l(11)
	lfd 13,0(11)
	fcmpu 0,0,13
	bc 4,0,.L161
.L164:
	lwz 0,184(9)
	andi. 9,0,4
	bc 4,2,.L201
	lwz 0,508(31)
	lis 5,vec3_origin@ha
	lfs 12,12(31)
	mr 11,9
	la 5,vec3_origin@l(5)
	xoris 0,0,0x8000
	lfs 13,8(31)
	addi 3,1,136
	stw 0,220(1)
	addi 4,1,104
	mr 6,5
	stw 29,216(1)
	addi 7,1,120
	mr 8,31
	lfd 0,216(1)
	lfs 11,4(31)
	li 9,25
	stfs 13,108(1)
	fsub 0,0,31
	lwz 10,48(28)
	stfs 11,104(1)
	mtlr 10
	frsp 0,0
	fadds 12,12,0
	stfs 12,112(1)
	lfs 0,4(30)
	stfs 0,120(1)
	lfs 13,8(30)
	stfs 13,124(1)
	lfs 12,12(30)
	stfs 12,128(1)
	lwz 0,508(30)
	xoris 0,0,0x8000
	stw 0,220(1)
	stw 29,216(1)
	lfd 0,216(1)
	fsub 0,0,31
	frsp 0,0
	fadds 12,12,0
	stfs 12,128(1)
	blrl
	lfs 0,144(1)
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L166
	lwz 0,188(1)
	cmpw 0,0,30
	bc 4,2,.L167
.L166:
	li 0,1
	b .L168
.L167:
	li 0,0
.L168:
	cmpwi 0,0,0
	bc 4,2,.L201
	lwz 0,948(31)
	cmpwi 0,0,0
	bc 12,2,.L201
	lfs 12,952(31)
	lis 11,.LC35@ha
	la 11,.LC35@l(11)
	lfd 13,0(11)
	fmr 0,12
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L201
	lis 9,level+4@ha
	lfs 0,832(31)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L201
	lfs 0,852(31)
	fadds 0,0,12
	fcmpu 0,13,0
	bc 12,0,.L201
	lis 9,gi+48@ha
	mr 3,27
	lwz 0,gi+48@l(9)
	addi 4,1,8
	li 5,0
	li 6,0
	addi 7,31,956
	mtlr 0
	mr 8,31
	lis 9,0x200
	blrl
	lwz 0,40(1)
	cmpwi 0,0,0
	bc 4,2,.L201
	lwz 0,44(1)
	cmpwi 0,0,0
	bc 4,2,.L201
	lfs 0,48(1)
	lis 9,.LC34@ha
	la 9,.LC34@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L173
	lwz 9,92(1)
	lwz 0,540(31)
	cmpw 0,9,0
	bc 4,2,.L201
.L173:
	li 0,5
	li 3,1
	stw 0,868(31)
	b .L204
.L161:
	lis 9,enemy_range@ha
	lwz 11,enemy_range@l(9)
	cmpwi 7,11,0
	bc 4,30,.L175
	lis 9,.LC36@ha
	lis 11,skill@ha
	la 9,.LC36@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L176
	bl rand
	andi. 0,3,3
	bc 4,2,.L205
.L176:
	lwz 0,816(31)
	cmpwi 0,0,0
	li 0,4
	bc 12,2,.L177
	li 0,3
.L177:
	stw 0,868(31)
	li 3,1
	b .L204
.L175:
	lwz 0,812(31)
	cmpwi 0,0,0
	bc 4,2,.L179
.L205:
	li 0,1
	li 3,0
	stw 0,868(31)
	b .L204
.L179:
	lis 9,level+4@ha
	lfs 13,832(31)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	bc 12,0,.L201
	cmpwi 0,11,3
	bc 12,2,.L201
	lwz 0,776(31)
	andi. 9,0,1
	bc 12,2,.L182
	lis 9,.LC24@ha
	lfs 31,.LC24@l(9)
	b .L183
.L182:
	bc 4,30,.L184
	lis 9,.LC25@ha
	lfs 31,.LC25@l(9)
	b .L183
.L184:
	cmpwi 0,11,1
	bc 4,2,.L186
	lis 9,.LC26@ha
	lfs 31,.LC26@l(9)
	b .L183
.L186:
	cmpwi 0,11,2
	bc 4,2,.L201
	lis 9,.LC27@ha
	lfs 31,.LC27@l(9)
.L183:
	lis 11,.LC36@ha
	lis 9,skill@ha
	la 11,.LC36@l(11)
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L190
	lis 9,.LC37@ha
	fmr 0,31
	la 9,.LC37@l(9)
	lfd 13,0(9)
	fmul 0,0,13
	frsp 31,0
	b .L191
.L190:
	lis 11,.LC38@ha
	la 11,.LC38@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L191
	fadds 31,31,31
.L191:
	bl rand
	lis 30,0x4330
	lis 9,.LC33@ha
	rlwinm 3,3,0,17,31
	la 9,.LC33@l(9)
	xoris 3,3,0x8000
	lfd 30,0(9)
	lis 11,.LC28@ha
	lfs 29,.LC28@l(11)
	stw 3,220(1)
	stw 30,216(1)
	lfd 0,216(1)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,29
	fcmpu 0,0,31
	bc 12,0,.L194
	lwz 9,540(31)
	lwz 0,248(9)
	cmpwi 0,0,0
	bc 4,2,.L193
.L194:
	li 0,4
	stw 0,868(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,level+4@ha
	stw 3,220(1)
	stw 30,216(1)
	li 3,1
	lfd 0,216(1)
	lfs 13,level+4@l(11)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,29
	fadds 0,0,0
	fadds 13,13,0
	stfs 13,832(31)
	b .L204
.L193:
	lwz 0,264(31)
	andi. 9,0,1
	bc 12,2,.L195
	lwz 3,280(31)
	lis 4,.LC29@ha
	la 4,.LC29@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L196
	lis 9,.LC30@ha
	lfs 31,.LC30@l(9)
	b .L197
.L196:
	lis 9,.LC31@ha
	lfs 31,.LC31@l(9)
.L197:
	lwz 3,540(31)
	cmpwi 0,3,0
	bc 12,2,.L198
	lwz 3,280(3)
	cmpwi 0,3,0
	bc 12,2,.L198
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L198
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfs 31,0(9)
.L198:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,220(1)
	lis 11,.LC33@ha
	la 11,.LC33@l(11)
	stw 0,216(1)
	lfd 13,0(11)
	lfd 0,216(1)
	lis 11,.LC28@ha
	lfs 12,.LC28@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fcmpu 0,0,31
	b .L208
.L195:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC32@ha
	stw 3,220(1)
	stw 30,216(1)
	lfd 0,216(1)
	lfd 12,.LC32@l(11)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,12
.L208:
	li 0,2
	bc 12,0,.L207
	li 0,1
.L207:
	stw 0,868(31)
.L201:
	li 3,0
.L204:
	lwz 0,276(1)
	mtlr 0
	lmw 27,228(1)
	lfd 29,248(1)
	lfd 30,256(1)
	lfd 31,264(1)
	la 1,272(1)
	blr
.Lfe5:
	.size	 M_CheckAttack,.Lfe5-M_CheckAttack
	.section	".rodata"
	.align 2
.LC41:
	.long 0x4cbebc20
	.align 3
.LC42:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC43:
	.long 0x439d8000
	.align 3
.LC44:
	.long 0x40140000
	.long 0x0
	.align 2
.LC45:
	.long 0x3f800000
	.align 3
.LC46:
	.long 0x41e00000
	.long 0x0
	.align 3
.LC47:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC48:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC49:
	.long 0x40a00000
	.align 2
.LC50:
	.long 0x42a00000
	.align 2
.LC51:
	.long 0x43fa0000
	.align 2
.LC52:
	.long 0x447a0000
	.align 2
.LC53:
	.long 0x42340000
	.section	".text"
	.align 2
	.globl ai_checkattack
	.type	 ai_checkattack,@function
ai_checkattack:
	stwu 1,-176(1)
	mflr 0
	stmw 29,164(1)
	stw 0,180(1)
	mr 31,3
	lwz 10,412(31)
	cmpwi 0,10,0
	bc 12,2,.L232
	lwz 0,776(31)
	andi. 8,0,4096
	bc 12,2,.L233
	li 3,0
	b .L303
.L233:
	andi. 9,0,4
	bc 12,2,.L232
	lwz 11,540(31)
	lis 9,level+4@ha
	lis 8,.LC44@ha
	lfs 11,level+4@l(9)
	la 8,.LC44@l(8)
	lfs 0,604(11)
	lfd 13,0(8)
	fsubs 0,11,0
	fcmpu 0,0,13
	bc 4,1,.L235
	cmpw 0,10,11
	bc 4,2,.L236
	lwz 0,416(31)
	cmpwi 0,0,0
	stw 0,412(31)
.L236:
	lwz 9,776(31)
	andi. 10,9,2
	rlwinm 0,9,0,30,28
	stw 0,776(31)
	bc 12,2,.L232
	rlwinm 0,9,0,0,28
	stw 0,776(31)
	b .L232
.L235:
	lis 11,.LC45@ha
	lis 8,.LC46@ha
	la 11,.LC45@l(11)
	la 8,.LC46@l(8)
	lfs 0,0(11)
	lfd 12,0(8)
	fadds 0,11,0
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L241
	fctiwz 0,13
	stfd 0,152(1)
	lwz 0,156(1)
	b .L242
.L241:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,152(1)
	lwz 0,156(1)
	xoris 0,0,0x8000
.L242:
	stw 0,496(31)
	li 3,0
	b .L303
.L232:
	lwz 11,540(31)
	lis 9,enemy_vis@ha
	li 0,0
	stw 0,enemy_vis@l(9)
	cmpwi 0,11,0
	bc 12,2,.L244
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 4,2,.L243
.L244:
	li 9,1
	b .L245
.L243:
	lwz 0,776(31)
	andi. 9,0,8192
	bc 12,2,.L246
	lwz 9,480(11)
	addi 0,9,-1
	or 9,9,0
	b .L304
.L246:
	andi. 10,0,512
	bc 12,2,.L250
	lwz 0,480(11)
	cmpwi 7,0,-80
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	b .L245
.L250:
	lwz 0,480(11)
	srawi 9,0,31
	subf 9,0,9
.L304:
	srawi 9,9,31
	addi 9,9,1
.L245:
	cmpwi 0,9,0
	bc 12,2,.L254
	lwz 9,544(31)
	li 10,0
	lwz 11,776(31)
	cmpwi 0,9,0
	stw 10,540(31)
	rlwinm 0,11,0,19,17
	stw 0,776(31)
	bc 12,2,.L255
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L255
	andi. 0,11,1
	stw 10,544(31)
	stw 9,412(31)
	stw 9,540(31)
	bc 4,2,.L305
	b .L262
.L255:
	lwz 11,944(31)
	cmpwi 0,11,0
	bc 12,2,.L261
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L261
	lwz 0,776(31)
	li 9,0
	stw 9,944(31)
	andi. 8,0,1
	stw 11,412(31)
	stw 11,540(31)
	stw 9,544(31)
	bc 12,2,.L262
.L305:
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	b .L263
.L262:
	lwz 9,804(31)
	mr 3,31
	mtlr 9
	blrl
.L263:
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
	lwz 0,776(31)
	stfs 1,424(31)
	andi. 8,0,1
	bc 4,2,.L254
	lis 9,.LC45@ha
	mr 3,31
	la 9,.LC45@l(9)
	lfs 1,0(9)
	bl AttackFinished
	b .L254
.L261:
	lwz 0,416(31)
	cmpwi 0,0,0
	bc 12,2,.L267
	lwz 11,800(31)
	mr 3,31
	stw 0,412(31)
	mtlr 11
	blrl
	b .L301
.L267:
	lis 9,level+4@ha
	lis 11,.LC41@ha
	lwz 10,788(31)
	lfs 0,level+4@l(9)
	mr 3,31
	lfs 13,.LC41@l(11)
	mtlr 10
	fadds 0,0,13
	stfs 0,828(31)
	blrl
	b .L301
.L254:
	lis 8,.LC45@ha
	lis 9,level+4@ha
	la 8,.LC45@l(8)
	lfs 0,level+4@l(9)
	lfs 13,0(8)
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfd 12,0(9)
	fadds 0,0,13
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L269
	fctiwz 0,13
	stfd 0,152(1)
	lwz 12,156(1)
	b .L270
.L269:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,152(1)
	lwz 12,156(1)
	xoris 12,12,0x8000
.L270:
	lwz 0,508(31)
	lis 29,0x4330
	lis 10,.LC47@ha
	lfs 13,12(31)
	mr 11,9
	xoris 0,0,0x8000
	la 10,.LC47@l(10)
	lfs 12,8(31)
	stw 0,156(1)
	lis 5,vec3_origin@ha
	mr 8,31
	stw 29,152(1)
	la 5,vec3_origin@l(5)
	addi 3,1,72
	lfd 11,0(10)
	addi 4,1,40
	mr 6,5
	lfd 0,152(1)
	lis 10,gi+48@ha
	addi 7,1,56
	lfs 10,4(31)
	li 9,25
	stw 12,496(31)
	fsub 0,0,11
	lwz 30,540(31)
	stfs 10,40(1)
	stfs 12,44(1)
	frsp 0,0
	lwz 10,gi+48@l(10)
	mtlr 10
	fadds 13,13,0
	stfs 13,48(1)
	lfs 0,4(30)
	stfs 0,56(1)
	lfs 13,8(30)
	stfs 13,60(1)
	lfs 12,12(30)
	stfs 12,64(1)
	lwz 0,508(30)
	xoris 0,0,0x8000
	stw 0,156(1)
	stw 29,152(1)
	lfd 0,152(1)
	fsub 0,0,11
	frsp 0,0
	fadds 12,12,0
	stfs 12,64(1)
	blrl
	lfs 0,80(1)
	lis 8,.LC48@ha
	la 8,.LC48@l(8)
	lfd 13,0(8)
	fcmpu 0,0,13
	bc 12,2,.L271
	lwz 0,124(1)
	cmpw 0,0,30
	bc 4,2,.L272
.L271:
	li 0,1
	b .L273
.L272:
	li 0,0
.L273:
	cmpwi 0,0,0
	lis 9,enemy_vis@ha
	stw 0,enemy_vis@l(9)
	bc 12,2,.L274
	lis 11,level@ha
	lis 9,.LC49@ha
	lwz 0,776(31)
	la 9,.LC49@l(9)
	la 11,level@l(11)
	lfs 0,4(11)
	rlwinm 0,0,0,29,27
	li 10,0
	lfs 13,0(9)
	lwz 9,540(31)
	fadds 0,0,13
	stfs 0,848(31)
	lfs 13,4(9)
	stfs 13,856(31)
	lfs 0,8(9)
	stfs 0,860(31)
	lfs 13,12(9)
	stw 0,776(31)
	stfs 13,864(31)
	lfs 0,4(11)
	stfs 0,852(31)
	lfs 13,4(9)
	stfs 13,956(31)
	lfs 0,8(9)
	stfs 0,960(31)
	lfs 13,12(9)
	stw 10,952(31)
	stfs 13,964(31)
.L274:
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
	lis 9,.LC42@ha
	li 0,0
	lfs 11,28(1)
	lfs 12,24(1)
	lfs 10,40(1)
	fmuls 11,11,0
	lfs 9,48(1)
	lfs 0,32(1)
	lfd 13,.LC42@l(9)
	fmadds 12,12,10,11
	fmadds 0,0,9,12
	fcmpu 0,0,13
	bc 4,1,.L275
	li 0,1
.L275:
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
	lis 8,.LC50@ha
	la 8,.LC50@l(8)
	lfs 0,0(8)
	fcmpu 0,1,0
	bc 4,0,.L277
	li 0,0
	b .L278
.L277:
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L279
	li 0,1
	b .L278
.L279:
	lis 10,.LC52@ha
	li 0,3
	la 10,.LC52@l(10)
	lfs 0,0(10)
	fcmpu 0,1,0
	bc 4,0,.L278
	li 0,2
.L278:
	lwz 9,540(31)
	lis 11,enemy_range@ha
	addi 3,1,8
	lfs 0,4(31)
	lis 30,enemy_yaw@ha
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
	lwz 9,824(31)
	mr 3,31
	stfs 1,enemy_yaw@l(30)
	mtlr 9
	blrl
	mr. 11,3
	bc 12,2,.L281
	lwz 0,868(31)
	cmpwi 0,0,4
	bc 12,2,.L309
	cmpwi 0,0,3
	bc 4,2,.L289
	lwz 0,776(31)
	lfs 0,enemy_yaw@l(30)
	andis. 8,0,1
	stfs 0,424(31)
	bc 4,2,.L290
	mr 3,31
	bl M_ChangeYaw
.L290:
	lfs 0,20(31)
	lfs 1,424(31)
	fsubs 1,0,1
	bl anglemod
	lis 8,.LC53@ha
	lis 9,.LC43@ha
	la 8,.LC53@l(8)
	lfs 0,.LC43@l(9)
	lfs 13,0(8)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 10,0,9
	bc 4,2,.L301
	lwz 9,816(31)
	mr 3,31
	mtlr 9
	blrl
	b .L307
.L289:
	cmpwi 0,0,5
	bc 4,2,.L295
.L309:
	lwz 0,776(31)
	lfs 0,enemy_yaw@l(30)
	andis. 8,0,1
	stfs 0,424(31)
	bc 4,2,.L296
	mr 3,31
	bl M_ChangeYaw
.L296:
	lfs 0,20(31)
	lfs 1,424(31)
	fsubs 1,0,1
	bl anglemod
	lis 8,.LC53@ha
	lis 9,.LC43@ha
	la 8,.LC53@l(8)
	lfs 0,.LC43@l(9)
	lfs 13,0(8)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 10,0,9
	bc 4,2,.L301
	lwz 9,812(31)
	mr 3,31
	mtlr 9
	blrl
	lwz 9,868(31)
	addi 9,9,-4
	cmplwi 0,9,1
	bc 12,1,.L301
.L307:
	li 0,1
	stw 0,868(31)
.L301:
	li 3,1
	b .L303
.L295:
	lis 9,enemy_vis@ha
	li 3,0
	lwz 0,enemy_vis@l(9)
	cmpwi 0,0,0
	bc 12,2,.L303
.L281:
	mr 3,11
.L303:
	lwz 0,180(1)
	mtlr 0
	lmw 29,164(1)
	la 1,176(1)
	blr
.Lfe6:
	.size	 ai_checkattack,.Lfe6-ai_checkattack
	.section	".rodata"
	.align 2
.LC54:
	.long 0x0
	.align 3
.LC55:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC56:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC57:
	.long 0x42800000
	.align 2
.LC58:
	.long 0x42b40000
	.align 2
.LC59:
	.long 0xc2b40000
	.align 3
.LC60:
	.long 0x40200000
	.long 0x0
	.align 2
.LC61:
	.long 0x40a00000
	.align 2
.LC62:
	.long 0x41200000
	.align 2
.LC63:
	.long 0x41a00000
	.align 2
.LC64:
	.long 0x3f800000
	.align 2
.LC65:
	.long 0x3f000000
	.align 3
.LC66:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ai_run
	.type	 ai_run,@function
ai_run:
	stwu 1,-400(1)
	mflr 0
	stfd 26,352(1)
	stfd 27,360(1)
	stfd 28,368(1)
	stfd 29,376(1)
	stfd 30,384(1)
	stfd 31,392(1)
	stmw 17,292(1)
	stw 0,404(1)
	mr 31,3
	fmr 27,1
	li 30,0
	lwz 0,776(31)
	li 28,0
	andi. 9,0,4096
	bc 12,2,.L311
	bl M_MoveToGoal
	b .L310
.L311:
	andi. 9,0,2048
	bc 12,2,.L312
	rlwinm 0,0,0,21,19
	stw 0,776(31)
.L312:
	lfs 13,208(31)
	lfs 0,932(31)
	fcmpu 0,13,0
	bc 12,2,.L313
	mr 3,31
	bl monster_duck_up
.L313:
	lwz 0,776(31)
	andis. 9,0,16
	bc 12,2,.L314
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L310
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L392
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L317
	lwz 3,280(9)
	lis 4,.LC15@ha
	la 4,.LC15@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L318
	lwz 30,540(31)
	mr 11,30
	b .L323
.L318:
	lwz 9,540(31)
	lwz 0,256(9)
	mr 11,9
	cmpwi 0,0,0
	bc 12,2,.L320
	mr 30,0
	b .L323
.L320:
	stw 30,540(31)
	b .L392
.L317:
	stw 30,540(31)
	b .L392
.L323:
	lis 9,coop@ha
	lwz 9,coop@l(9)
	cmpwi 0,9,0
	bc 12,2,.L324
	lfs 13,20(9)
	lis 9,.LC54@ha
	la 9,.LC54@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L324
	cmpwi 0,11,0
	bc 12,2,.L325
	lwz 0,508(31)
	lis 29,0x4330
	lis 10,.LC55@ha
	lfs 12,12(31)
	mr 11,9
	xoris 0,0,0x8000
	la 10,.LC55@l(10)
	lfs 13,8(31)
	stw 0,284(1)
	lis 5,vec3_origin@ha
	addi 3,1,184
	stw 29,280(1)
	la 5,vec3_origin@l(5)
	addi 4,1,152
	lfd 11,0(10)
	mr 6,5
	addi 7,1,168
	lfd 0,280(1)
	lis 10,gi+48@ha
	mr 8,31
	lfs 10,4(31)
	li 9,25
	stfs 13,156(1)
	fsub 0,0,11
	lwz 10,gi+48@l(10)
	stfs 10,152(1)
	mtlr 10
	frsp 0,0
	fadds 12,12,0
	stfs 12,160(1)
	lfs 0,4(30)
	stfs 0,168(1)
	lfs 13,8(30)
	stfs 13,172(1)
	lfs 12,12(30)
	stfs 12,176(1)
	lwz 0,508(30)
	xoris 0,0,0x8000
	stw 0,284(1)
	stw 29,280(1)
	lfd 0,280(1)
	fsub 0,0,11
	frsp 0,0
	fadds 12,12,0
	stfs 12,176(1)
	blrl
	lfs 0,192(1)
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L326
	lwz 0,236(1)
	cmpw 0,0,30
	bc 4,2,.L327
.L326:
	li 0,1
	b .L328
.L327:
	li 0,0
.L328:
	cmpwi 0,0,0
	bc 12,2,.L325
	li 28,1
	b .L330
.L325:
	mr 3,31
	bl FindTarget
	b .L330
.L324:
	cmpwi 0,11,0
	bc 12,2,.L330
	lwz 0,508(31)
	lis 29,0x4330
	lis 10,.LC55@ha
	lfs 12,12(31)
	mr 11,9
	xoris 0,0,0x8000
	la 10,.LC55@l(10)
	lfs 13,8(31)
	stw 0,284(1)
	lis 5,vec3_origin@ha
	addi 3,1,184
	stw 29,280(1)
	la 5,vec3_origin@l(5)
	addi 4,1,152
	lfd 11,0(10)
	mr 6,5
	addi 7,1,168
	lfd 0,280(1)
	lis 10,gi+48@ha
	mr 8,31
	lfs 10,4(31)
	li 9,25
	stfs 13,156(1)
	fsub 0,0,11
	lwz 10,gi+48@l(10)
	stfs 10,152(1)
	mtlr 10
	frsp 0,0
	fadds 12,12,0
	stfs 12,160(1)
	lfs 0,4(30)
	stfs 0,168(1)
	lfs 13,8(30)
	stfs 13,172(1)
	lfs 12,12(30)
	stfs 12,176(1)
	lwz 0,508(30)
	xoris 0,0,0x8000
	stw 0,284(1)
	stw 29,280(1)
	lfd 0,280(1)
	fsub 0,0,11
	frsp 0,0
	fadds 12,12,0
	stfs 12,176(1)
	blrl
	lfs 0,192(1)
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L332
	lwz 0,236(1)
	cmpw 0,0,30
	bc 4,2,.L333
.L332:
	li 0,1
	b .L334
.L333:
	li 0,0
.L334:
	addic 9,0,-1
	subfe 9,9,9
	addi 0,9,1
	and 9,28,9
	or 28,9,0
.L330:
	cmpwi 0,28,0
	bc 12,2,.L310
.L392:
	mr 3,31
	bl hintpath_stop
	b .L310
.L314:
	andi. 9,0,4
	bc 12,2,.L336
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L339
	lfs 13,4(9)
	addi 3,1,8
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 0,0,13
	stfs 0,8(1)
	lfs 13,8(9)
	fsubs 12,12,13
	stfs 12,12(1)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	lis 9,.LC57@ha
	la 9,.LC57@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L338
.L339:
	lwz 11,788(31)
	mr 3,31
	lwz 0,776(31)
	mtlr 11
	ori 0,0,3
	stw 0,776(31)
	blrl
	b .L310
.L338:
	fmr 1,27
	mr 3,31
	li 30,1
	bl M_MoveToGoal
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L310
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 12,2,.L310
.L336:
	fmr 1,27
	mr 3,31
	bl ai_checkattack
	lis 9,enemy_vis@ha
	mr 29,3
	lwz 0,enemy_vis@l(9)
	cmpwi 0,0,0
	bc 4,2,.L342
	lwz 0,868(31)
	cmpwi 0,0,2
	bc 4,2,.L342
	li 0,1
	stw 0,868(31)
.L342:
	lwz 0,776(31)
	andis. 9,0,4
	bc 12,2,.L343
	li 0,2
	stw 0,868(31)
.L343:
	lwz 0,868(31)
	cmpwi 0,0,2
	bc 4,2,.L344
	cmpwi 0,30,0
	bc 4,2,.L345
	lwz 0,872(31)
	lis 9,enemy_yaw@ha
	lis 10,.LC58@ha
	fmr 31,27
	lfs 0,enemy_yaw@l(9)
	la 10,.LC58@l(10)
	cmpwi 0,0,0
	lfs 30,0(10)
	stfs 0,424(31)
	bc 4,2,.L347
	lis 11,.LC59@ha
	la 11,.LC59@l(11)
	lfs 30,0(11)
.L347:
	lwz 0,776(31)
	andis. 9,0,1
	bc 4,2,.L348
	mr 3,31
	bl M_ChangeYaw
.L348:
	lwz 0,264(31)
	cmpwi 0,0,0
	bc 4,2,.L349
	lis 9,.LC60@ha
	fmr 13,27
	lis 0,0x4100
	la 9,.LC60@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L350
	fmr 0,27
	stfs 0,248(1)
	lwz 0,248(1)
.L350:
	stw 0,248(1)
	lfs 0,248(1)
	fmr 31,0
.L349:
	lfs 1,424(31)
	fmr 2,31
	mr 3,31
	fadds 1,1,30
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L345
	lwz 0,776(31)
	andis. 9,0,4
	bc 12,2,.L354
	mr 3,31
	bl monster_done_dodge
	b .L356
.L354:
	lfs 1,424(31)
	fmr 2,31
	mr 3,31
	lwz 0,872(31)
	fsubs 1,1,30
	subfic 0,0,1
	stw 0,872(31)
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L345
	lwz 0,776(31)
	andis. 9,0,4
	bc 12,2,.L356
	mr 3,31
	bl monster_done_dodge
.L356:
	li 0,1
	stw 0,868(31)
.L345:
	cmpwi 0,29,0
	mfcr 29
	bc 4,2,.L391
	lwz 0,868(31)
	cmpwi 0,0,2
	bc 12,2,.L310
	b .L358
.L344:
	lwz 0,776(31)
	cmpwi 7,29,0
	andis. 9,0,8
	mfcr 29
	rlwinm 29,29,28,0xf0000000
	bc 12,2,.L358
	lis 9,enemy_yaw@ha
	andis. 10,0,1
	lfs 0,enemy_yaw@l(9)
	stfs 0,424(31)
	bc 4,2,.L358
	mr 3,31
	bl M_ChangeYaw
.L358:
	mtcrf 128,29
	bc 12,2,.L361
.L391:
	lis 9,.LC54@ha
	la 9,.LC54@l(9)
	lfs 0,0(9)
	xori 9,30,1
	fcmpu 7,27,0
	crnor 31,30,30
	mfcr 0
	rlwinm 0,0,0,1
	and. 10,0,9
	bc 12,2,.L362
	lwz 0,868(31)
	cmpwi 0,0,1
	bc 4,2,.L362
	lwz 0,776(31)
	andi. 11,0,1
	bc 4,2,.L362
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
.L362:
	lwz 10,540(31)
	cmpwi 0,10,0
	bc 12,2,.L310
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L310
	lis 9,enemy_vis@ha
	lwz 0,enemy_vis@l(9)
	cmpwi 0,0,0
	bc 12,2,.L310
	lwz 0,776(31)
	lis 9,level+4@ha
	li 11,0
	rlwinm 0,0,0,29,27
	stw 0,776(31)
	lfs 0,4(10)
	stfs 0,856(31)
	lfs 13,8(10)
	stfs 13,860(31)
	lfs 0,12(10)
	stfs 0,864(31)
	lfs 13,level+4@l(9)
	stfs 13,852(31)
	lfs 0,4(10)
	stfs 0,956(31)
	lfs 13,8(10)
	stfs 13,960(31)
	lfs 0,12(10)
	stw 11,952(31)
	stfs 0,964(31)
	b .L310
.L361:
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L364
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L364
	lis 9,enemy_vis@ha
	lwz 0,enemy_vis@l(9)
	cmpwi 0,0,0
	bc 12,2,.L364
	cmpwi 0,30,0
	bc 4,2,.L365
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
.L365:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L310
	lwz 0,776(31)
	lis 11,level+4@ha
	li 10,0
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
	lfs 0,4(9)
	stfs 0,956(31)
	lfs 13,8(9)
	stfs 13,960(31)
	lfs 0,12(9)
	stw 10,952(31)
	stfs 0,964(31)
	b .L310
.L364:
	lis 9,.LC61@ha
	lfs 0,852(31)
	la 9,.LC61@l(9)
	lfs 13,0(9)
	lis 9,level+4@ha
	lfs 12,level+4@l(9)
	fadds 0,0,13
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L367
	lis 10,.LC62@ha
	lfs 0,896(31)
	la 10,.LC62@l(10)
	lfs 13,0(10)
	fadds 0,0,13
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L367
	stfs 12,896(31)
	mr 3,31
	bl monsterlost_checkhint
	cmpwi 0,3,0
	bc 4,2,.L310
.L367:
	lis 9,coop@ha
	lis 10,.LC54@ha
	lwz 11,coop@l(9)
	la 10,.LC54@l(10)
	lfs 31,0(10)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L370
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 4,2,.L310
.L370:
	lfs 13,848(31)
	fcmpu 0,13,31
	bc 12,2,.L372
	lis 9,.LC63@ha
	la 9,.LC63@l(9)
	lfs 0,0(9)
	lis 9,level+4@ha
	fadds 0,13,0
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 4,1,.L372
	cmpwi 0,30,0
	bc 4,2,.L373
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
.L373:
	stfs 31,848(31)
	b .L310
.L372:
	lwz 17,412(31)
	li 30,0
	bl G_Spawn
	lwz 0,776(31)
	mr 18,3
	stw 18,412(31)
	andi. 9,0,8
	bc 4,2,.L374
	ori 0,0,24
	li 30,1
	rlwinm 0,0,0,27,24
	stw 0,776(31)
.L374:
	lwz 11,776(31)
	andi. 10,11,32
	bc 12,2,.L375
	rlwinm 0,11,0,27,25
	lis 10,.LC61@ha
	stw 0,776(31)
	lis 9,level+4@ha
	la 10,.LC61@l(10)
	lfs 0,level+4@l(9)
	andi. 0,11,64
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,848(31)
	bc 12,2,.L376
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
	b .L377
.L376:
	andi. 9,11,16
	bc 12,2,.L378
	rlwinm 0,11,0,28,25
	mr 3,31
	stw 0,776(31)
	bl PlayerTrail_PickFirst
	b .L377
.L378:
	mr 3,31
	bl PlayerTrail_PickNext
.L377:
	cmpwi 0,3,0
	bc 12,2,.L375
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
.L375:
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
	bc 4,3,.L381
	lwz 0,776(31)
	fmr 27,30
	ori 0,0,32
	stw 0,776(31)
.L381:
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
	bc 12,2,.L382
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
	lis 11,.LC64@ha
	la 11,.LC64@l(11)
	lfs 26,0(11)
	blrl
	lfs 0,32(1)
	fcmpu 0,0,26
	bc 4,0,.L382
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
	lis 9,.LC65@ha
	fmr 30,1
	addi 3,1,8
	la 9,.LC65@l(9)
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
	bc 12,2,.L384
	fcmpu 0,31,26
	bc 4,0,.L385
	fmuls 0,28,31
	lis 11,.LC66@ha
	stw 20,12(1)
	mr 3,30
	la 11,.LC66@l(11)
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
.L385:
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
	b .L393
.L384:
	fcmpu 7,13,29
	fcmpu 6,13,31
	cror 31,30,29
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,26,1
	and. 10,9,0
	bc 12,2,.L382
	fcmpu 0,13,26
	bc 4,0,.L388
	fmuls 0,28,13
	lis 11,.LC66@ha
	stw 19,12(1)
	mr 3,30
	la 11,.LC66@l(11)
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
.L388:
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
.L393:
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
.L382:
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L310
	mr 3,18
	bl G_FreeEdict
	cmpwi 0,31,0
	bc 12,2,.L310
	stw 17,412(31)
.L310:
	lwz 0,404(1)
	mtlr 0
	lmw 17,292(1)
	lfd 26,352(1)
	lfd 27,360(1)
	lfd 28,368(1)
	lfd 29,376(1)
	lfd 30,384(1)
	lfd 31,392(1)
	la 1,400(1)
	blr
.Lfe7:
	.size	 ai_run,.Lfe7-ai_run
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
.L394:
	lis 9,level+236@ha
	stw 11,level+236@l(9)
	blr
.L7:
	lis 11,g_edicts@ha
	lis 9,0xfe3
	lwz 0,g_edicts@l(11)
	ori 9,9,49265
	subf 0,0,10
	mullw 0,0,9
	srawi 7,0,3
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
	mulli 0,8,1160
	add 11,10,0
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L13
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L13
	lwz 0,264(11)
	andi. 9,0,32
	bc 4,2,.L13
	lwz 0,184(11)
	andi. 9,0,1
	bc 12,2,.L394
.L13:
	cmpw 0,8,7
	bc 4,2,.L11
	stw 5,236(4)
	blr
.Lfe8:
	.size	 AI_SetSightClient,.Lfe8-AI_SetSightClient
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
.Lfe9:
	.size	 ai_move,.Lfe9-ai_move
	.section	".rodata"
	.align 2
.LC67:
	.long 0x46fffe00
	.align 2
.LC68:
	.long 0x0
	.align 3
.LC69:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC70:
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
	bc 4,2,.L33
	lwz 0,796(31)
	cmpwi 0,0,0
	bc 12,2,.L33
	lis 9,level@ha
	lfs 13,876(31)
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,0,13
	bc 4,1,.L33
	lis 9,.LC68@ha
	la 9,.LC68@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L36
	mtlr 0
	mr 3,31
	blrl
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,4(30)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC69@ha
	lis 11,.LC67@ha
	la 10,.LC69@l(10)
	stw 0,16(1)
	lfd 11,0(10)
	lfd 0,16(1)
	lis 10,.LC70@ha
	lfs 13,.LC67@l(11)
	la 10,.LC70@l(10)
	lfs 10,0(10)
	fsub 0,0,11
	fadds 12,12,10
	frsp 0,0
	fdivs 0,0,13
	fmadds 0,0,10,12
	b .L395
.L36:
	bl rand
	rlwinm 3,3,0,17,31
	lfs 10,4(30)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC69@ha
	lis 11,.LC67@ha
	la 10,.LC69@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC70@ha
	lfs 12,.LC67@l(11)
	la 10,.LC70@l(10)
	lfs 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmadds 0,0,11,10
.L395:
	stfs 0,876(31)
.L33:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 ai_walk,.Lfe10-ai_walk
	.section	".rodata"
	.align 2
.LC71:
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
	lis 9,.LC71@ha
	mr 31,3
	la 9,.LC71@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,2,.L54
	fmr 2,1
	lfs 1,20(31)
	bl M_walkmove
.L54:
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 4,2,.L53
	lwz 0,776(31)
	andis. 9,0,1
	bc 4,2,.L53
	mr 3,31
	bl M_ChangeYaw
.L53:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 ai_turn,.Lfe11-ai_turn
	.section	".rodata"
	.align 2
.LC72:
	.long 0x42a00000
	.align 2
.LC73:
	.long 0x43fa0000
	.align 2
.LC74:
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
	lis 9,.LC72@ha
	la 9,.LC72@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L58
	li 3,0
	b .L396
.L58:
	lis 9,.LC73@ha
	la 9,.LC73@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L59
	lis 9,.LC74@ha
	la 9,.LC74@l(9)
	lfs 0,0(9)
	fcmpu 7,1,0
	mfcr 3
	rlwinm 3,3,29,1
	neg 3,3
	nor 0,3,3
	rlwinm 3,3,0,30,30
	rlwinm 0,0,0,30,31
	or 3,3,0
	b .L396
.L59:
	li 3,1
.L396:
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe12:
	.size	 range,.Lfe12-range
	.section	".rodata"
	.align 3
.LC75:
	.long 0x3fd33333
	.long 0x33333333
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
	lfs 0,28(1)
	lis 9,.LC75@ha
	lfs 11,12(1)
	lfs 12,8(1)
	lfs 10,24(1)
	fmuls 11,11,0
	lfs 9,32(1)
	lfs 0,16(1)
	lfd 13,.LC75@l(9)
	fmadds 12,12,10,11
	fmadds 0,0,9,12
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,30,1
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe13:
	.size	 infront,.Lfe13-infront
	.section	".rodata"
	.align 3
.LC76:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC77:
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
	mr 31,4
	lwz 0,508(29)
	lis 28,0x4330
	lwz 11,508(31)
	mr 10,9
	lis 8,.LC76@ha
	xoris 0,0,0x8000
	la 8,.LC76@l(8)
	lfs 7,12(29)
	stw 0,116(1)
	xoris 11,11,0x8000
	lis 27,gi+48@ha
	stw 28,112(1)
	lis 5,vec3_origin@ha
	addi 3,1,40
	lfd 13,112(1)
	la 5,vec3_origin@l(5)
	addi 4,1,8
	stw 11,116(1)
	mr 6,5
	addi 7,1,24
	stw 28,112(1)
	li 9,25
	lfd 11,0(8)
	lfd 0,112(1)
	mr 8,29
	lfs 12,12(31)
	fsub 13,13,11
	lwz 0,gi+48@l(27)
	fsub 0,0,11
	lfs 10,4(29)
	lfs 11,8(29)
	mtlr 0
	frsp 13,13
	lfs 9,4(31)
	frsp 0,0
	lfs 8,8(31)
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
	lis 8,.LC77@ha
	la 8,.LC77@l(8)
	lfd 13,0(8)
	fcmpu 0,0,13
	bc 12,2,.L63
	lwz 0,92(1)
	cmpw 0,0,31
	bc 4,2,.L62
.L63:
	li 3,1
	b .L398
.L62:
	li 3,0
.L398:
	lwz 0,148(1)
	mtlr 0
	lmw 27,124(1)
	la 1,144(1)
	blr
.Lfe14:
	.size	 visible,.Lfe14-visible
	.section	".rodata"
	.align 2
.LC78:
	.long 0x439d8000
	.align 2
.LC79:
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
	lis 11,.LC79@ha
	lis 9,.LC78@ha
	la 11,.LC79@l(11)
	lfs 0,.LC78@l(9)
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
	.comm	enemy_vis,4,4
	.comm	enemy_infront,4,4
	.comm	enemy_range,4,4
	.comm	enemy_yaw,4,4
	.section	".rodata"
	.align 2
.LC80:
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
	bc 12,2,.L67
	lwz 9,788(31)
	mtlr 9
	blrl
	b .L68
.L67:
	lwz 9,804(31)
	mr 3,31
	mtlr 9
	blrl
.L68:
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
	lwz 0,776(31)
	stfs 1,424(31)
	andi. 9,0,1
	bc 4,2,.L69
	lis 11,.LC80@ha
	mr 3,31
	la 11,.LC80@l(11)
	lfs 1,0(11)
	bl AttackFinished
.L69:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 HuntTarget,.Lfe16-HuntTarget
	.section	".rodata"
	.align 2
.LC81:
	.long 0x439d8000
	.align 2
.LC82:
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
	mr 31,3
	lis 9,enemy_yaw@ha
	lwz 0,776(31)
	lfs 0,enemy_yaw@l(9)
	andis. 9,0,1
	stfs 0,424(31)
	bc 4,2,.L210
	bl M_ChangeYaw
.L210:
	lfs 0,20(31)
	lfs 1,424(31)
	fsubs 1,0,1
	bl anglemod
	lis 11,.LC82@ha
	lis 9,.LC81@ha
	la 11,.LC82@l(11)
	lfs 0,.LC81@l(9)
	lfs 13,0(11)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 11,0,9
	bc 4,2,.L211
	lwz 9,816(31)
	mr 3,31
	mtlr 9
	blrl
	li 0,1
	stw 0,868(31)
.L211:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe17:
	.size	 ai_run_melee,.Lfe17-ai_run_melee
	.section	".rodata"
	.align 2
.LC83:
	.long 0x439d8000
	.align 2
.LC84:
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
	mr 31,3
	lis 9,enemy_yaw@ha
	lwz 0,776(31)
	lfs 0,enemy_yaw@l(9)
	andis. 9,0,1
	stfs 0,424(31)
	bc 4,2,.L215
	bl M_ChangeYaw
.L215:
	lfs 0,20(31)
	lfs 1,424(31)
	fsubs 1,0,1
	bl anglemod
	lis 11,.LC84@ha
	lis 9,.LC83@ha
	la 11,.LC84@l(11)
	lfs 0,.LC83@l(9)
	lfs 13,0(11)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 11,0,9
	bc 4,2,.L216
	lwz 9,812(31)
	mr 3,31
	mtlr 9
	blrl
	lwz 9,868(31)
	addi 9,9,-4
	cmplwi 0,9,1
	bc 12,1,.L216
	li 0,1
	stw 0,868(31)
.L216:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe18:
	.size	 ai_run_missile,.Lfe18-ai_run_missile
	.section	".rodata"
	.align 2
.LC85:
	.long 0x42b40000
	.align 2
.LC86:
	.long 0xc2b40000
	.align 3
.LC87:
	.long 0x40200000
	.long 0x0
	.section	".text"
	.align 2
	.globl ai_run_slide
	.type	 ai_run_slide,@function
ai_run_slide:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stw 31,28(1)
	stw 0,52(1)
	mr 31,3
	lis 9,enemy_yaw@ha
	fmr 31,1
	lwz 0,872(31)
	lis 11,.LC85@ha
	lfs 0,enemy_yaw@l(9)
	la 11,.LC85@l(11)
	cmpwi 0,0,0
	lfs 30,0(11)
	stfs 0,424(31)
	bc 4,2,.L222
	lis 9,.LC86@ha
	la 9,.LC86@l(9)
	lfs 30,0(9)
.L222:
	lwz 0,776(31)
	andis. 11,0,1
	bc 4,2,.L223
	mr 3,31
	bl M_ChangeYaw
.L223:
	lwz 0,264(31)
	cmpwi 0,0,0
	bc 4,2,.L224
	lis 9,.LC87@ha
	fmr 13,31
	lis 0,0x4100
	la 9,.LC87@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L225
	stfs 31,8(1)
	lwz 0,8(1)
.L225:
	stw 0,8(1)
	lfs 0,8(1)
	fmr 31,0
.L224:
	lfs 1,424(31)
	fmr 2,31
	mr 3,31
	fadds 1,1,30
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L220
	lwz 0,776(31)
	andis. 9,0,4
	bc 12,2,.L228
	mr 3,31
	bl monster_done_dodge
	b .L230
.L228:
	lfs 1,424(31)
	fmr 2,31
	mr 3,31
	lwz 0,872(31)
	fsubs 1,1,30
	subfic 0,0,1
	stw 0,872(31)
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L220
	lwz 0,776(31)
	andis. 9,0,4
	bc 12,2,.L230
	mr 3,31
	bl monster_done_dodge
.L230:
	li 0,1
	stw 0,868(31)
.L220:
	lwz 0,52(1)
	mtlr 0
	lwz 31,28(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe19:
	.size	 ai_run_slide,.Lfe19-ai_run_slide
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
