	.file	"g_ai.c"
gcc2_compiled.:
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
.L7:
	lis 11,g_edicts@ha
	lis 9,0xa27a
	lwz 0,g_edicts@l(11)
	ori 9,9,52719
	subf 0,0,10
	mullw 0,0,9
	srawi 7,0,2
.L8:
	lis 10,g_edicts@ha
	lis 9,game+1544@ha
	lis 11,level@ha
	lwz 6,g_edicts@l(10)
	mr 8,7
	lwz 5,game+1544@l(9)
	la 10,level@l(11)
	li 4,0
.L11:
	addi 8,8,1
	cmpw 7,8,5
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	neg 9,9
	addi 11,9,1
	and 9,8,9
	or 8,9,11
	mulli 0,8,1084
	add 11,6,0
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L13
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L13
	lwz 0,264(11)
	andi. 9,0,32800
	bc 4,2,.L13
	lwz 0,260(11)
	cmpwi 0,0,1
	bc 4,2,.L14
	lwz 0,324(11)
	cmpwi 0,0,0
	bc 12,2,.L13
	stw 0,236(10)
	blr
.L14:
	stw 11,236(10)
	blr
.L13:
	cmpw 0,8,7
	bc 4,2,.L11
	stw 4,236(10)
	blr
.Lfe1:
	.size	 AI_SetSightClient,.Lfe1-AI_SetSightClient
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
	bc 12,2,.L21
	fmr 2,1
	lfs 1,20(31)
	bl M_walkmove
.L21:
	lwz 0,776(31)
	andi. 9,0,1
	bc 12,2,.L22
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L23
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
	bc 12,2,.L24
	lwz 0,776(31)
	andi. 9,0,2
	bc 12,2,.L24
	lwz 11,804(31)
	mr 3,31
	rlwinm 0,0,0,0,29
	stw 0,776(31)
	mtlr 11
	blrl
.L24:
	lwz 0,776(31)
	andis. 9,0,1
	bc 4,2,.L25
	mr 3,31
	bl M_ChangeYaw
.L25:
	lis 9,.LC1@ha
	mr 3,31
	la 9,.LC1@l(9)
	lfs 1,0(9)
	bl ai_checkattack
	lwz 4,540(31)
	mr 30,3
	cmpwi 0,4,0
	bc 12,2,.L26
	lwz 0,88(4)
	cmpwi 0,0,0
	bc 12,2,.L26
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L26
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
	b .L20
.L26:
	cmpwi 0,30,0
	bc 4,2,.L20
.L23:
	mr 3,31
	bl FindTarget
	b .L20
.L22:
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 4,2,.L20
	lis 9,level@ha
	lfs 0,828(31)
	la 30,level@l(9)
	lfs 13,4(30)
	fcmpu 0,13,0
	bc 4,1,.L31
	lwz 0,800(31)
	mr 3,31
	mtlr 0
	blrl
	b .L20
.L31:
	lwz 0,284(31)
	andi. 9,0,1
	bc 4,2,.L20
	lwz 0,792(31)
	cmpwi 0,0,0
	bc 12,2,.L20
	lfs 0,876(31)
	fcmpu 0,13,0
	bc 4,1,.L20
	fcmpu 0,0,31
	bc 12,2,.L33
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
	b .L35
.L33:
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
.L35:
	stfs 0,876(31)
.L20:
	lwz 0,52(1)
	mtlr 0
	lmw 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 ai_stand,.Lfe2-ai_stand
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
	bc 12,2,.L41
	lwz 0,88(4)
	cmpwi 0,0,0
	bc 12,2,.L41
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L44
	lwz 9,540(31)
	lfs 0,4(9)
	stfs 0,956(31)
	lfs 13,8(9)
	stfs 13,960(31)
	lfs 0,12(9)
	stfs 0,964(31)
.L44:
	lwz 0,776(31)
	andis. 9,0,1
	bc 4,2,.L45
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
.L45:
	mr 3,31
	bl M_ChangeYaw
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 0,0(9)
	fcmpu 0,30,0
	bc 12,2,.L41
	lwz 0,776(31)
	andis. 9,0,8
	bc 12,2,.L47
	fmr 1,30
	mr 3,31
	bl M_MoveToGoal
	b .L41
.L47:
	lwz 0,868(31)
	cmpwi 0,0,2
	bc 4,2,.L48
	lwz 3,540(31)
	cmpwi 0,3,0
	bc 12,2,.L49
	lwz 3,280(3)
	cmpwi 0,3,0
	bc 12,2,.L49
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L49
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	b .L55
.L49:
	lwz 0,872(31)
	lis 9,.LC7@ha
	la 9,.LC7@l(9)
	cmpwi 0,0,0
	lfs 31,0(9)
	bc 12,2,.L50
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
.L55:
	lfs 31,0(9)
.L50:
	lfs 1,424(31)
	fmr 2,30
	mr 3,31
	fadds 1,1,31
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L41
	lfs 1,424(31)
	fmr 2,30
	mr 3,31
	lwz 0,872(31)
	fsubs 1,1,31
	subfic 0,0,1
	stw 0,872(31)
	bl M_walkmove
	b .L41
.L48:
	mr 3,31
	fmr 2,30
	lfs 1,20(3)
	bl M_walkmove
.L41:
	lwz 0,52(1)
	mtlr 0
	lwz 31,28(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 ai_charge,.Lfe3-ai_charge
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
	.align 3
.LC13:
	.long 0x43300000
	.long 0x80000000
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
	lwz 9,540(31)
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 4,2,.L76
	lwz 0,1016(9)
	lis 8,level@ha
	cmpwi 0,0,0
	bc 12,2,.L75
.L76:
	lwz 0,264(9)
	andi. 8,0,32768
	bc 12,2,.L77
	rlwinm 0,0,0,17,15
	stw 0,264(9)
.L77:
	lis 9,level@ha
	li 11,128
	lwz 0,level@l(9)
	lis 8,level@ha
	la 9,level@l(9)
	stw 31,240(9)
	stw 0,244(9)
	stw 11,640(31)
.L75:
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
	bc 12,3,.L78
	fctiwz 0,13
	stfd 0,24(1)
	lwz 0,28(1)
	b .L79
.L78:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	xoris 0,0,0x8000
.L79:
	lwz 10,540(31)
	lis 9,level+4@ha
	li 28,0
	stw 0,496(31)
	lfs 0,4(10)
	lwz 29,304(31)
	stfs 0,856(31)
	cmpwi 0,29,0
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
	stw 28,952(31)
	stfs 0,964(31)
	bc 12,2,.L80
	lwz 0,284(31)
	andi. 11,0,1
	bc 12,2,.L81
	rlwinm 0,0,0,0,30
	mr 3,31
	stw 0,284(31)
	bl FindTarget
	b .L74
.L81:
	lwz 0,776(31)
	stw 10,412(31)
	andi. 8,0,1
	bc 4,2,.L98
	b .L89
.L80:
	lwz 3,320(31)
	cmpwi 0,3,0
	bc 4,2,.L87
	lwz 0,level@l(8)
	lis 11,0x4330
	lis 8,.LC13@ha
	lfs 12,1028(31)
	xoris 0,0,0x8000
	la 8,.LC13@l(8)
	stw 0,28(1)
	stw 11,24(1)
	lfd 13,0(8)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 12,1,.L74
	lwz 0,776(31)
	stw 10,412(31)
	andi. 9,0,1
	bc 12,2,.L89
.L98:
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	b .L90
.L89:
	lwz 9,804(31)
	mr 3,31
	mtlr 9
	blrl
.L90:
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
	andi. 8,0,1
	bc 4,2,.L74
	lis 9,.LC11@ha
	mr 3,31
	la 9,.LC11@l(9)
	lfs 1,0(9)
	bl AttackFinished
	b .L74
.L87:
	bl G_PickTarget
	mr 9,3
	cmpwi 0,9,0
	stw 9,416(31)
	stw 9,412(31)
	bc 4,2,.L93
	lwz 0,776(31)
	lwz 9,540(31)
	andi. 8,0,1
	stw 9,412(31)
	stw 9,416(31)
	bc 12,2,.L94
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	b .L95
.L94:
	lwz 9,804(31)
	mr 3,31
	mtlr 9
	blrl
.L95:
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
	andi. 8,0,1
	bc 4,2,.L97
	lis 9,.LC11@ha
	mr 3,31
	la 9,.LC11@l(9)
	lfs 1,0(9)
	bl AttackFinished
.L97:
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
	b .L74
.L93:
	lwz 0,776(31)
	mr 3,31
	stw 29,320(31)
	ori 0,0,4096
	stw 0,776(31)
	stw 29,300(9)
	lwz 0,804(31)
	stw 28,828(31)
	mtlr 0
	blrl
.L74:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 FoundTarget,.Lfe4-FoundTarget
	.section	".rodata"
	.align 2
.LC14:
	.string	"target_actor"
	.align 2
.LC15:
	.string	"misc_actor"
	.align 2
.LC17:
	.string	"player_noise"
	.align 3
.LC16:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC18:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC19:
	.long 0x0
	.align 2
.LC20:
	.long 0x42a00000
	.align 2
.LC21:
	.long 0x43fa0000
	.align 2
.LC22:
	.long 0x447a0000
	.align 3
.LC23:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC24:
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
	bc 12,2,.L101
	lwz 0,304(31)
	cmpwi 0,0,0
	bc 4,2,.L101
	lwz 3,412(31)
	cmpwi 0,3,0
	bc 12,2,.L102
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L102
	lwz 3,280(3)
	cmpwi 0,3,0
	bc 12,2,.L102
	lis 4,.LC14@ha
	la 4,.LC14@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,0
	bc 12,2,.L176
.L102:
	lwz 3,280(31)
	lis 4,.LC15@ha
	la 4,.LC15@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,0
	bc 4,2,.L176
	mr 3,31
	bl FindSomeMonster
	lwz 0,540(31)
	addic 9,0,-1
	subfe 3,9,0
	b .L176
.L101:
	lwz 0,776(31)
	andi. 11,0,4096
	mr 8,0
	bc 4,2,.L185
	lis 11,level@ha
	lfs 12,1028(31)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC18@ha
	xoris 0,0,0x8000
	la 11,.LC18@l(11)
	stw 0,124(1)
	stw 10,120(1)
	lfd 13,0(11)
	lfd 0,120(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	li 3,0
	bc 12,1,.L176
	lwz 3,304(31)
	cmpwi 0,3,0
	bc 12,2,.L108
	lwz 0,284(31)
	andi. 9,0,1
	bc 4,2,.L108
	bl G_PickTarget
	cmpwi 0,3,0
	stw 3,540(31)
	bc 12,2,.L109
	lwz 0,492(3)
	cmpwi 0,0,0
	bc 12,2,.L110
	lwz 0,776(31)
	ori 0,0,512
	stw 0,776(31)
.L110:
	lwz 0,820(31)
	cmpwi 0,0,0
	bc 12,2,.L111
	mr 3,31
	lwz 4,540(31)
	mtlr 0
	blrl
.L111:
	mr 3,31
	bl FoundTarget
	b .L175
.L109:
	stw 3,304(31)
.L185:
	li 3,0
	b .L176
.L108:
	lis 9,level@ha
	li 10,0
	la 4,level@l(9)
	lwz 11,level@l(9)
	lwz 0,244(4)
	addi 11,11,-1
	cmpw 0,0,11
	bc 12,0,.L112
	lwz 0,284(31)
	andi. 9,0,1
	bc 4,2,.L112
	lwz 30,240(4)
	lwz 9,540(31)
	lwz 0,540(30)
	cmpw 0,0,9
	b .L178
.L112:
	lis 9,level@ha
	la 4,level@l(9)
	lwz 11,level@l(9)
	lwz 0,252(4)
	addi 11,11,-1
	cmpw 0,0,11
	bc 12,0,.L115
	lwz 30,248(4)
	li 10,1
	b .L114
.L115:
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L117
	lwz 0,260(4)
	cmpw 0,0,11
	bc 12,0,.L117
	lwz 0,284(31)
	andi. 11,0,1
	bc 4,2,.L117
	lwz 30,256(4)
	li 10,1
	b .L114
.L117:
	lis 9,level+236@ha
	lwz 30,level+236@l(9)
	cmpwi 0,30,0
.L178:
	bc 12,2,.L185
.L114:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L185
	lwz 0,540(31)
	cmpw 0,30,0
	bc 12,2,.L175
	andis. 0,8,16
	bc 12,2,.L122
	lis 9,coop@ha
	lwz 9,coop@l(9)
	cmpwi 0,9,0
	bc 12,2,.L122
	lfs 13,20(9)
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfs 0,0(9)
	fcmpu 7,13,0
	mfcr 0
	rlwinm 0,0,31,1
	neg 0,0
	and 10,10,0
.L122:
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L123
	lwz 0,264(30)
	b .L179
.L123:
	lwz 0,1016(30)
	cmpwi 0,0,0
	bc 12,2,.L126
	lwz 9,324(30)
	cmpwi 0,9,0
	bc 12,2,.L126
	lwz 0,264(9)
	andi. 9,0,32
	b .L180
.L126:
	lwz 0,184(30)
	andi. 11,0,4
	bc 12,2,.L129
	lwz 9,540(30)
	cmpwi 0,9,0
	bc 12,2,.L185
	lwz 0,264(9)
	andi. 9,0,32
	b .L180
.L129:
	cmpwi 0,10,0
	bc 12,2,.L185
	lwz 9,256(30)
	cmpwi 0,9,0
	bc 12,2,.L125
	lwz 0,264(9)
.L179:
	andi. 11,0,32
.L180:
	bc 4,2,.L185
.L125:
	cmpwi 0,10,0
	bc 4,2,.L136
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
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L137
	li 28,0
	b .L138
.L137:
	lis 11,.LC21@ha
	la 11,.LC21@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	bc 4,0,.L139
	li 28,1
	b .L138
.L139:
	lis 9,.LC22@ha
	li 28,3
	la 9,.LC22@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L138
	li 28,2
.L138:
	cmpwi 0,28,3
	bc 12,2,.L185
	lwz 0,640(30)
	cmpwi 0,0,5
	bc 4,1,.L185
	lwz 0,260(30)
	cmpwi 0,0,1
	li 0,0
	bc 12,2,.L145
	lwz 0,508(31)
	lis 29,0x4330
	lis 11,.LC18@ha
	lfs 12,12(31)
	lis 10,gi+48@ha
	xoris 0,0,0x8000
	la 11,.LC18@l(11)
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
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L146
	lwz 0,108(1)
	cmpw 0,0,30
	bc 4,2,.L147
.L146:
	li 0,1
	b .L145
.L147:
	li 0,0
.L145:
	cmpwi 0,0,0
	bc 12,2,.L185
	cmpwi 0,28,1
	bc 4,2,.L148
	lwz 10,496(30)
	lis 0,0x4330
	lis 11,.LC24@ha
	stw 10,124(1)
	la 11,.LC24@l(11)
	stw 0,120(1)
	lfd 13,0(11)
	lfd 0,120(1)
	lis 11,level+4@ha
	lfs 12,level+4@l(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L152
	b .L183
.L148:
	cmpwi 0,28,2
	bc 4,2,.L152
.L183:
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
	lis 9,.LC16@ha
	li 0,0
	lfs 11,12(1)
	lfs 12,8(1)
	lfs 10,24(1)
	fmuls 11,11,0
	lfs 9,32(1)
	lfs 0,16(1)
	lfd 13,.LC16@l(9)
	fmadds 12,12,10,11
	fmadds 0,0,9,12
	fcmpu 0,0,13
	bc 4,1,.L155
	li 0,1
.L155:
	cmpwi 0,0,0
	bc 12,2,.L185
.L152:
	stw 30,540(31)
	lis 4,.LC17@ha
	lwz 3,280(30)
	la 4,.LC17@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L160
	lwz 0,776(31)
	lwz 11,540(31)
	rlwinm 0,0,0,30,28
	stw 0,776(31)
	lwz 9,84(11)
	cmpwi 0,9,0
	bc 4,2,.L160
	lwz 9,540(11)
	stw 9,540(31)
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 4,2,.L160
	stw 0,540(31)
	b .L185
.L136:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L161
	lwz 0,260(30)
	cmpwi 0,0,1
	li 0,0
	bc 12,2,.L164
	lwz 0,508(31)
	lis 29,0x4330
	lis 11,.LC18@ha
	lfs 12,12(31)
	lis 10,gi+48@ha
	xoris 0,0,0x8000
	la 11,.LC18@l(11)
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
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L165
	lwz 0,108(1)
	cmpw 0,0,30
	bc 4,2,.L166
.L165:
	li 0,1
	b .L164
.L166:
	li 0,0
.L164:
	cmpwi 0,0,0
	b .L181
.L161:
	lis 9,gi+60@ha
	addi 3,31,4
	lwz 0,gi+60@l(9)
	addi 4,30,4
	mtlr 0
	blrl
	cmpwi 0,3,0
.L181:
	bc 12,2,.L185
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
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,1,.L185
	lwz 4,176(30)
	lwz 3,176(31)
	cmpw 0,4,3
	bc 12,2,.L170
	lis 9,gi+68@ha
	lwz 0,gi+68@l(9)
	mtlr 0
	blrl
	cmpwi 0,3,0
	li 3,0
	bc 12,2,.L176
.L170:
	addi 3,1,8
	bl vectoyaw
	lwz 0,776(31)
	stfs 1,424(31)
	andis. 9,0,1
	bc 4,2,.L172
	mr 3,31
	bl M_ChangeYaw
.L172:
	lwz 0,776(31)
	stw 30,540(31)
	ori 0,0,4
	stw 0,776(31)
.L160:
	lwz 0,776(31)
	andis. 9,0,16
	bc 12,2,.L173
	mr 3,31
	bl hintpath_stop
	b .L174
.L173:
	mr 3,31
	bl FoundTarget
.L174:
	lwz 0,776(31)
	andi. 9,0,4
	bc 4,2,.L175
	lwz 0,820(31)
	cmpwi 0,0,0
	bc 12,2,.L175
	mr 3,31
	mtlr 0
	lwz 4,540(3)
	blrl
.L175:
	li 3,1
.L176:
	lwz 0,148(1)
	mtlr 0
	lmw 28,128(1)
	la 1,144(1)
	blr
.Lfe5:
	.size	 FindTarget,.Lfe5-FindTarget
	.section	".rodata"
	.align 2
.LC31:
	.string	"monster_daedalus"
	.align 2
.LC26:
	.long 0x3ecccccd
	.align 2
.LC27:
	.long 0x3e4ccccd
	.align 2
.LC28:
	.long 0x3dcccccd
	.align 2
.LC29:
	.long 0x3ca3d70a
	.align 2
.LC30:
	.long 0x46fffe00
	.align 2
.LC32:
	.long 0x3f4ccccd
	.align 2
.LC33:
	.long 0x3f19999a
	.align 3
.LC34:
	.long 0x3fd99999
	.long 0x9999999a
	.align 3
.LC35:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC36:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC37:
	.long 0x40340000
	.long 0x0
	.align 2
.LC38:
	.long 0x0
	.align 3
.LC39:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC40:
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
	bc 4,1,.L189
	lwz 0,508(31)
	lis 29,0x4330
	lis 9,.LC35@ha
	lfs 13,12(31)
	mr 10,11
	xoris 0,0,0x8000
	la 9,.LC35@l(9)
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
	bc 12,2,.L189
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 4,2,.L192
	lfs 0,48(1)
	lis 11,.LC36@ha
	la 11,.LC36@l(11)
	lfd 13,0(11)
	fcmpu 0,0,13
	bc 4,0,.L189
.L192:
	lwz 0,184(9)
	andi. 9,0,4
	bc 4,2,.L230
	lwz 0,260(30)
	cmpwi 0,0,1
	li 0,0
	bc 12,2,.L195
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
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L196
	lwz 0,188(1)
	cmpw 0,0,30
	bc 4,2,.L197
.L196:
	li 0,1
	b .L195
.L197:
	li 0,0
.L195:
	cmpwi 0,0,0
	bc 4,2,.L230
	lwz 0,948(31)
	cmpwi 0,0,0
	bc 12,2,.L230
	lfs 12,952(31)
	lis 11,.LC37@ha
	la 11,.LC37@l(11)
	lfd 13,0(11)
	fmr 0,12
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L230
	lis 9,level+4@ha
	lfs 0,832(31)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L230
	lfs 0,852(31)
	fadds 0,0,12
	fcmpu 0,13,0
	bc 12,0,.L230
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
	bc 4,2,.L230
	lwz 0,44(1)
	cmpwi 0,0,0
	bc 4,2,.L230
	lfs 0,48(1)
	lis 9,.LC36@ha
	la 9,.LC36@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L202
	lwz 9,92(1)
	lwz 0,540(31)
	cmpw 0,9,0
	bc 4,2,.L230
.L202:
	li 0,5
	li 3,1
	stw 0,868(31)
	b .L233
.L189:
	lis 9,enemy_range@ha
	lwz 11,enemy_range@l(9)
	cmpwi 7,11,0
	bc 4,30,.L204
	lis 9,.LC38@ha
	lis 11,skill@ha
	la 9,.LC38@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L205
	bl rand
	andi. 0,3,3
	bc 4,2,.L234
.L205:
	lwz 0,816(31)
	cmpwi 0,0,0
	li 0,4
	bc 12,2,.L206
	li 0,3
.L206:
	stw 0,868(31)
	li 3,1
	b .L233
.L204:
	lwz 0,812(31)
	cmpwi 0,0,0
	bc 4,2,.L208
.L234:
	li 0,1
	li 3,0
	stw 0,868(31)
	b .L233
.L208:
	lis 9,level+4@ha
	lfs 13,832(31)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	bc 12,0,.L230
	cmpwi 0,11,3
	bc 12,2,.L230
	lwz 0,776(31)
	andi. 9,0,1
	bc 12,2,.L211
	lis 9,.LC26@ha
	lfs 31,.LC26@l(9)
	b .L212
.L211:
	bc 4,30,.L213
	lis 9,.LC27@ha
	lfs 31,.LC27@l(9)
	b .L212
.L213:
	cmpwi 0,11,1
	bc 4,2,.L215
	lis 9,.LC28@ha
	lfs 31,.LC28@l(9)
	b .L212
.L215:
	cmpwi 0,11,2
	bc 4,2,.L230
	lis 9,.LC29@ha
	lfs 31,.LC29@l(9)
.L212:
	lis 11,.LC38@ha
	lis 9,skill@ha
	la 11,.LC38@l(11)
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L219
	lis 9,.LC39@ha
	fmr 0,31
	la 9,.LC39@l(9)
	lfd 13,0(9)
	fmul 0,0,13
	frsp 31,0
	b .L220
.L219:
	lis 11,.LC40@ha
	la 11,.LC40@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L220
	fadds 31,31,31
.L220:
	bl rand
	lis 30,0x4330
	lis 9,.LC35@ha
	rlwinm 3,3,0,17,31
	la 9,.LC35@l(9)
	xoris 3,3,0x8000
	lfd 30,0(9)
	lis 11,.LC30@ha
	lfs 29,.LC30@l(11)
	stw 3,220(1)
	stw 30,216(1)
	lfd 0,216(1)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,29
	fcmpu 0,0,31
	bc 12,0,.L223
	lwz 9,540(31)
	lwz 0,248(9)
	cmpwi 0,0,0
	bc 4,2,.L222
.L223:
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
	b .L233
.L222:
	lwz 0,264(31)
	andi. 9,0,1
	bc 12,2,.L224
	lwz 3,280(31)
	lis 4,.LC31@ha
	la 4,.LC31@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L225
	lis 9,.LC32@ha
	lfs 31,.LC32@l(9)
	b .L226
.L225:
	lis 9,.LC33@ha
	lfs 31,.LC33@l(9)
.L226:
	lwz 3,540(31)
	cmpwi 0,3,0
	bc 12,2,.L227
	lwz 3,280(3)
	cmpwi 0,3,0
	bc 12,2,.L227
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L227
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 31,0(9)
.L227:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,220(1)
	lis 11,.LC35@ha
	la 11,.LC35@l(11)
	stw 0,216(1)
	lfd 13,0(11)
	lfd 0,216(1)
	lis 11,.LC30@ha
	lfs 12,.LC30@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fcmpu 0,0,31
	b .L237
.L224:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC34@ha
	stw 3,220(1)
	stw 30,216(1)
	lfd 0,216(1)
	lfd 12,.LC34@l(11)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,12
.L237:
	li 0,2
	bc 12,0,.L236
	li 0,1
.L236:
	stw 0,868(31)
.L230:
	li 3,0
.L233:
	lwz 0,276(1)
	mtlr 0
	lmw 27,228(1)
	lfd 29,248(1)
	lfd 30,256(1)
	lfd 31,264(1)
	la 1,272(1)
	blr
.Lfe6:
	.size	 M_CheckAttack,.Lfe6-M_CheckAttack
	.section	".rodata"
	.align 2
.LC43:
	.long 0x4cbebc20
	.align 3
.LC44:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC45:
	.long 0x439d8000
	.align 3
.LC46:
	.long 0x40140000
	.long 0x0
	.align 2
.LC47:
	.long 0x3f800000
	.align 3
.LC48:
	.long 0x41e00000
	.long 0x0
	.align 3
.LC49:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC50:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC51:
	.long 0x40a00000
	.align 2
.LC52:
	.long 0x42a00000
	.align 2
.LC53:
	.long 0x43fa0000
	.align 2
.LC54:
	.long 0x447a0000
	.align 2
.LC55:
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
	bc 12,2,.L261
	lwz 0,776(31)
	andi. 8,0,4096
	bc 12,2,.L262
	li 3,0
	b .L336
.L262:
	andi. 9,0,4
	bc 12,2,.L261
	lwz 11,540(31)
	lis 9,level+4@ha
	lis 8,.LC46@ha
	lfs 11,level+4@l(9)
	la 8,.LC46@l(8)
	lfs 0,604(11)
	lfd 13,0(8)
	fsubs 0,11,0
	fcmpu 0,0,13
	bc 4,1,.L264
	cmpw 0,10,11
	bc 4,2,.L265
	lwz 0,416(31)
	cmpwi 0,0,0
	stw 0,412(31)
.L265:
	lwz 9,776(31)
	andi. 10,9,2
	rlwinm 0,9,0,30,28
	stw 0,776(31)
	bc 12,2,.L261
	rlwinm 0,9,0,0,28
	stw 0,776(31)
	b .L261
.L264:
	lis 11,.LC47@ha
	lis 8,.LC48@ha
	la 11,.LC47@l(11)
	la 8,.LC48@l(8)
	lfs 0,0(11)
	lfd 12,0(8)
	fadds 0,11,0
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L270
	fctiwz 0,13
	stfd 0,152(1)
	lwz 0,156(1)
	b .L271
.L270:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,152(1)
	lwz 0,156(1)
	xoris 0,0,0x8000
.L271:
	stw 0,496(31)
	li 3,0
	b .L336
.L261:
	lwz 11,540(31)
	lis 9,enemy_vis@ha
	li 0,0
	stw 0,enemy_vis@l(9)
	cmpwi 0,11,0
	bc 12,2,.L273
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 4,2,.L272
.L273:
	li 9,1
	b .L274
.L272:
	lwz 0,776(31)
	andi. 9,0,8192
	bc 12,2,.L275
	lwz 9,480(11)
	addi 0,9,-1
	or 9,9,0
	b .L337
.L275:
	andi. 10,0,512
	bc 12,2,.L279
	lwz 0,480(11)
	cmpwi 7,0,-80
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	b .L274
.L279:
	lwz 0,480(11)
	srawi 9,0,31
	subf 9,0,9
.L337:
	srawi 9,9,31
	addi 9,9,1
.L274:
	cmpwi 0,9,0
	bc 12,2,.L283
	lwz 0,304(31)
	cmpwi 0,0,0
	bc 12,2,.L284
	lwz 3,320(31)
	li 29,0
	stw 29,304(31)
	cmpwi 0,3,0
	stw 29,540(31)
	bc 12,2,.L284
	bl G_PickTarget
	mr 11,3
	cmpwi 0,11,0
	stw 11,416(31)
	stw 11,412(31)
	bc 12,2,.L286
	lwz 0,776(31)
	mr 3,31
	li 9,0
	stw 29,320(31)
	ori 0,0,4096
	stw 0,776(31)
	stw 29,300(11)
	lwz 11,804(31)
	stw 9,828(31)
.L341:
	mtlr 11
	blrl
.L338:
	li 3,1
	b .L336
.L286:
	stw 11,320(31)
	stw 11,412(31)
	stw 11,416(31)
.L284:
	lwz 9,544(31)
	li 10,0
	lwz 11,776(31)
	cmpwi 0,9,0
	stw 10,540(31)
	rlwinm 0,11,0,19,17
	stw 0,776(31)
	bc 12,2,.L287
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L287
	andi. 0,11,1
	stw 10,544(31)
	stw 9,412(31)
	stw 9,540(31)
	bc 4,2,.L339
	b .L294
.L287:
	lwz 11,944(31)
	cmpwi 0,11,0
	bc 12,2,.L293
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L293
	lwz 0,776(31)
	li 9,0
	stw 9,944(31)
	andi. 8,0,1
	stw 11,412(31)
	stw 11,540(31)
	stw 9,544(31)
	bc 12,2,.L294
.L339:
	lwz 9,788(31)
	mr 3,31
	mtlr 9
	blrl
	b .L295
.L294:
	lwz 9,804(31)
	mr 3,31
	mtlr 9
	blrl
.L295:
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
	bc 4,2,.L283
	lis 9,.LC47@ha
	mr 3,31
	la 9,.LC47@l(9)
	lfs 1,0(9)
	bl AttackFinished
	b .L283
.L293:
	lwz 0,416(31)
	cmpwi 0,0,0
	bc 12,2,.L299
	lwz 11,800(31)
	mr 3,31
	stw 0,412(31)
	b .L341
.L299:
	lis 9,level+4@ha
	lis 11,.LC43@ha
	lwz 10,788(31)
	lfs 0,level+4@l(9)
	mr 3,31
	lfs 13,.LC43@l(11)
	mtlr 10
	fadds 0,0,13
	stfs 0,828(31)
	blrl
	b .L338
.L283:
	lis 8,.LC47@ha
	lis 9,level+4@ha
	la 8,.LC47@l(8)
	lfs 0,level+4@l(9)
	lfs 13,0(8)
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfd 12,0(9)
	fadds 0,0,13
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L301
	fctiwz 0,13
	stfd 0,152(1)
	lwz 0,156(1)
	b .L302
.L301:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,152(1)
	lwz 0,156(1)
	xoris 0,0,0x8000
.L302:
	lwz 30,540(31)
	stw 0,496(31)
	lwz 0,260(30)
	cmpwi 0,0,1
	li 0,0
	bc 12,2,.L304
	lwz 0,508(31)
	lis 29,0x4330
	lis 10,.LC49@ha
	lfs 12,12(31)
	mr 11,9
	xoris 0,0,0x8000
	la 10,.LC49@l(10)
	lfs 13,8(31)
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
	stfs 13,44(1)
	fsub 0,0,11
	lwz 10,gi+48@l(10)
	stfs 10,40(1)
	mtlr 10
	frsp 0,0
	fadds 12,12,0
	stfs 12,48(1)
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
	lis 8,.LC50@ha
	la 8,.LC50@l(8)
	lfd 13,0(8)
	fcmpu 0,0,13
	bc 12,2,.L305
	lwz 0,124(1)
	cmpw 0,0,30
	bc 4,2,.L306
.L305:
	li 0,1
	b .L304
.L306:
	li 0,0
.L304:
	cmpwi 0,0,0
	lis 9,enemy_vis@ha
	stw 0,enemy_vis@l(9)
	bc 12,2,.L307
	lis 11,level@ha
	lis 9,.LC51@ha
	lwz 0,776(31)
	la 9,.LC51@l(9)
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
.L307:
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
	lis 9,.LC44@ha
	li 0,0
	lfs 11,28(1)
	lfs 12,24(1)
	lfs 10,40(1)
	fmuls 11,11,0
	lfs 9,48(1)
	lfs 0,32(1)
	lfd 13,.LC44@l(9)
	fmadds 12,12,10,11
	fmadds 0,0,9,12
	fcmpu 0,0,13
	bc 4,1,.L308
	li 0,1
.L308:
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
	lis 8,.LC52@ha
	la 8,.LC52@l(8)
	lfs 0,0(8)
	fcmpu 0,1,0
	bc 4,0,.L310
	li 0,0
	b .L311
.L310:
	lis 9,.LC53@ha
	la 9,.LC53@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L312
	li 0,1
	b .L311
.L312:
	lis 10,.LC54@ha
	li 0,3
	la 10,.LC54@l(10)
	lfs 0,0(10)
	fcmpu 0,1,0
	bc 4,0,.L311
	li 0,2
.L311:
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
	bc 12,2,.L314
	lwz 0,868(31)
	cmpwi 0,0,4
	bc 4,2,.L315
	lwz 0,776(31)
	lfs 0,enemy_yaw@l(30)
	andis. 8,0,1
	stfs 0,424(31)
	bc 4,2,.L316
	mr 3,31
	bl M_ChangeYaw
.L316:
	lfs 0,20(31)
	lfs 1,424(31)
	fsubs 1,0,1
	bl anglemod
	lis 8,.LC55@ha
	lis 9,.LC45@ha
	la 8,.LC55@l(8)
	lfs 0,.LC45@l(9)
	lfs 13,0(8)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 10,0,9
	bc 4,2,.L338
	lwz 9,812(31)
	mr 3,31
	mtlr 9
	blrl
	lwz 9,868(31)
	addi 9,9,-4
	cmplwi 0,9,1
	bc 12,1,.L338
	li 0,1
	stw 0,868(31)
	b .L338
.L315:
	cmpwi 0,0,3
	bc 4,2,.L322
	lwz 0,776(31)
	lfs 0,enemy_yaw@l(30)
	andis. 8,0,1
	stfs 0,424(31)
	bc 4,2,.L323
	mr 3,31
	bl M_ChangeYaw
.L323:
	lfs 0,20(31)
	lfs 1,424(31)
	fsubs 1,0,1
	bl anglemod
	lis 8,.LC55@ha
	lis 9,.LC45@ha
	la 8,.LC55@l(8)
	lfs 0,.LC45@l(9)
	lfs 13,0(8)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 10,0,9
	bc 4,2,.L338
	lwz 9,816(31)
	mr 3,31
	mtlr 9
	blrl
	li 0,1
	stw 0,868(31)
	b .L338
.L322:
	cmpwi 0,0,5
	bc 4,2,.L328
	lwz 0,776(31)
	lfs 0,enemy_yaw@l(30)
	andis. 8,0,1
	stfs 0,424(31)
	bc 4,2,.L329
	mr 3,31
	bl M_ChangeYaw
.L329:
	lfs 0,20(31)
	lfs 1,424(31)
	fsubs 1,0,1
	bl anglemod
	lis 8,.LC55@ha
	lis 9,.LC45@ha
	la 8,.LC55@l(8)
	lfs 0,.LC45@l(9)
	lfs 13,0(8)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 10,0,9
	bc 4,2,.L338
	lwz 9,812(31)
	mr 3,31
	mtlr 9
	blrl
	lwz 9,868(31)
	addi 9,9,-4
	cmplwi 0,9,1
	bc 12,1,.L338
	li 0,1
	stw 0,868(31)
	b .L338
.L328:
	lis 9,enemy_vis@ha
	li 3,0
	lwz 0,enemy_vis@l(9)
	cmpwi 0,0,0
	bc 12,2,.L336
.L314:
	mr 3,11
.L336:
	lwz 0,180(1)
	mtlr 0
	lmw 29,164(1)
	la 1,176(1)
	blr
.Lfe7:
	.size	 ai_checkattack,.Lfe7-ai_checkattack
	.section	".rodata"
	.align 2
.LC56:
	.long 0x0
	.align 3
.LC57:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC58:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC59:
	.long 0x42800000
	.align 2
.LC60:
	.long 0x42b40000
	.align 2
.LC61:
	.long 0xc2b40000
	.align 3
.LC62:
	.long 0x40200000
	.long 0x0
	.align 2
.LC63:
	.long 0x40a00000
	.align 2
.LC64:
	.long 0x41200000
	.align 2
.LC65:
	.long 0x41a00000
	.align 2
.LC66:
	.long 0x3f800000
	.align 2
.LC67:
	.long 0x3f000000
	.align 3
.LC68:
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
	bc 12,2,.L343
	bl M_MoveToGoal
	b .L342
.L343:
	andi. 9,0,2048
	bc 12,2,.L344
	rlwinm 0,0,0,21,19
	stw 0,776(31)
.L344:
	lfs 13,208(31)
	lfs 0,932(31)
	fcmpu 0,13,0
	bc 12,2,.L345
	mr 3,31
	bl monster_duck_up
.L345:
	lwz 0,776(31)
	andis. 9,0,16
	bc 12,2,.L346
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L342
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L426
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L349
	lwz 3,280(9)
	lis 4,.LC17@ha
	la 4,.LC17@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L350
	lwz 30,540(31)
	mr 11,30
	b .L355
.L350:
	lwz 9,540(31)
	lwz 0,256(9)
	mr 11,9
	cmpwi 0,0,0
	bc 12,2,.L352
	mr 30,0
	b .L355
.L352:
	stw 30,540(31)
	b .L426
.L349:
	stw 30,540(31)
	b .L426
.L355:
	lis 9,coop@ha
	lwz 9,coop@l(9)
	cmpwi 0,9,0
	bc 12,2,.L356
	lfs 13,20(9)
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L356
	cmpwi 0,11,0
	bc 12,2,.L357
	lwz 0,260(30)
	cmpwi 0,0,1
	li 0,0
	bc 12,2,.L359
	lwz 0,508(31)
	lis 29,0x4330
	lis 10,.LC57@ha
	lfs 12,12(31)
	mr 11,9
	xoris 0,0,0x8000
	la 10,.LC57@l(10)
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
	lis 9,.LC58@ha
	la 9,.LC58@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L360
	lwz 0,236(1)
	cmpw 0,0,30
	bc 4,2,.L361
.L360:
	li 0,1
	b .L359
.L361:
	li 0,0
.L359:
	cmpwi 0,0,0
	bc 12,2,.L357
	li 28,1
	b .L363
.L357:
	mr 3,31
	bl FindTarget
	b .L363
.L356:
	cmpwi 0,11,0
	bc 12,2,.L363
	lwz 0,260(30)
	cmpwi 0,0,1
	li 0,0
	bc 12,2,.L366
	lwz 0,508(31)
	lis 29,0x4330
	lis 10,.LC57@ha
	lfs 12,12(31)
	mr 11,9
	xoris 0,0,0x8000
	la 10,.LC57@l(10)
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
	lis 9,.LC58@ha
	la 9,.LC58@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L367
	lwz 0,236(1)
	cmpw 0,0,30
	bc 4,2,.L368
.L367:
	li 0,1
	b .L366
.L368:
	li 0,0
.L366:
	addic 9,0,-1
	subfe 9,9,9
	addi 0,9,1
	and 9,28,9
	or 28,9,0
.L363:
	cmpwi 0,28,0
	bc 12,2,.L342
.L426:
	mr 3,31
	bl hintpath_stop
	b .L342
.L346:
	andi. 9,0,4
	bc 12,2,.L370
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L373
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
	lis 9,.LC59@ha
	la 9,.LC59@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L372
.L373:
	lwz 11,788(31)
	mr 3,31
	lwz 0,776(31)
	mtlr 11
	ori 0,0,3
	stw 0,776(31)
	blrl
	b .L342
.L372:
	fmr 1,27
	mr 3,31
	li 30,1
	bl M_MoveToGoal
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L342
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 12,2,.L342
.L370:
	fmr 1,27
	mr 3,31
	bl ai_checkattack
	lis 9,enemy_vis@ha
	mr 29,3
	lwz 0,enemy_vis@l(9)
	cmpwi 0,0,0
	bc 4,2,.L376
	lwz 0,868(31)
	cmpwi 0,0,2
	bc 4,2,.L376
	li 0,1
	stw 0,868(31)
.L376:
	lwz 0,776(31)
	andis. 9,0,4
	bc 12,2,.L377
	li 0,2
	stw 0,868(31)
.L377:
	lwz 0,868(31)
	cmpwi 0,0,2
	bc 4,2,.L378
	cmpwi 0,30,0
	bc 4,2,.L379
	lwz 0,872(31)
	lis 9,enemy_yaw@ha
	lis 10,.LC60@ha
	fmr 31,27
	lfs 0,enemy_yaw@l(9)
	la 10,.LC60@l(10)
	cmpwi 0,0,0
	lfs 30,0(10)
	stfs 0,424(31)
	bc 4,2,.L381
	lis 11,.LC61@ha
	la 11,.LC61@l(11)
	lfs 30,0(11)
.L381:
	lwz 0,776(31)
	andis. 9,0,1
	bc 4,2,.L382
	mr 3,31
	bl M_ChangeYaw
.L382:
	lwz 0,264(31)
	cmpwi 0,0,0
	bc 4,2,.L383
	lis 9,.LC62@ha
	fmr 13,27
	lis 0,0x4100
	la 9,.LC62@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L384
	fmr 0,27
	stfs 0,248(1)
	lwz 0,248(1)
.L384:
	stw 0,248(1)
	lfs 0,248(1)
	fmr 31,0
.L383:
	lfs 1,424(31)
	fmr 2,31
	mr 3,31
	fadds 1,1,30
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L379
	lwz 0,776(31)
	andis. 9,0,4
	bc 12,2,.L388
	mr 3,31
	bl monster_done_dodge
	b .L390
.L388:
	lfs 1,424(31)
	fmr 2,31
	mr 3,31
	lwz 0,872(31)
	fsubs 1,1,30
	subfic 0,0,1
	stw 0,872(31)
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L379
	lwz 0,776(31)
	andis. 9,0,4
	bc 12,2,.L390
	mr 3,31
	bl monster_done_dodge
.L390:
	li 0,1
	stw 0,868(31)
.L379:
	cmpwi 0,29,0
	mfcr 29
	bc 4,2,.L425
	lwz 0,868(31)
	cmpwi 0,0,2
	bc 12,2,.L342
	b .L392
.L378:
	lwz 0,776(31)
	cmpwi 7,29,0
	andis. 9,0,8
	mfcr 29
	rlwinm 29,29,28,0xf0000000
	bc 12,2,.L392
	lis 9,enemy_yaw@ha
	andis. 10,0,1
	lfs 0,enemy_yaw@l(9)
	stfs 0,424(31)
	bc 4,2,.L392
	mr 3,31
	bl M_ChangeYaw
.L392:
	mtcrf 128,29
	bc 12,2,.L395
.L425:
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 0,0(9)
	xori 9,30,1
	fcmpu 7,27,0
	crnor 31,30,30
	mfcr 0
	rlwinm 0,0,0,1
	and. 10,0,9
	bc 12,2,.L396
	lwz 0,868(31)
	cmpwi 0,0,1
	bc 4,2,.L396
	lwz 0,776(31)
	andi. 11,0,1
	bc 4,2,.L396
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
.L396:
	lwz 10,540(31)
	cmpwi 0,10,0
	bc 12,2,.L342
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L342
	lis 9,enemy_vis@ha
	lwz 0,enemy_vis@l(9)
	cmpwi 0,0,0
	bc 12,2,.L342
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
	b .L342
.L395:
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L398
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L398
	lis 9,enemy_vis@ha
	lwz 0,enemy_vis@l(9)
	cmpwi 0,0,0
	bc 12,2,.L398
	cmpwi 0,30,0
	bc 4,2,.L399
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
.L399:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L342
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
	b .L342
.L398:
	lis 9,.LC63@ha
	lfs 0,852(31)
	la 9,.LC63@l(9)
	lfs 13,0(9)
	lis 9,level+4@ha
	lfs 12,level+4@l(9)
	fadds 0,0,13
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L401
	lis 10,.LC64@ha
	lfs 0,896(31)
	la 10,.LC64@l(10)
	lfs 13,0(10)
	fadds 0,0,13
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L401
	stfs 12,896(31)
	mr 3,31
	bl monsterlost_checkhint
	cmpwi 0,3,0
	bc 4,2,.L342
.L401:
	lis 9,coop@ha
	lis 10,.LC56@ha
	lwz 11,coop@l(9)
	la 10,.LC56@l(10)
	lfs 31,0(10)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L404
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 4,2,.L342
.L404:
	lfs 13,848(31)
	fcmpu 0,13,31
	bc 12,2,.L406
	lis 9,.LC65@ha
	la 9,.LC65@l(9)
	lfs 0,0(9)
	lis 9,level+4@ha
	fadds 0,13,0
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 4,1,.L406
	cmpwi 0,30,0
	bc 4,2,.L407
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
.L407:
	stfs 31,848(31)
	b .L342
.L406:
	lwz 17,412(31)
	li 30,0
	bl G_Spawn
	lwz 0,776(31)
	mr 18,3
	stw 18,412(31)
	andi. 9,0,8
	bc 4,2,.L408
	ori 0,0,24
	li 30,1
	rlwinm 0,0,0,27,24
	stw 0,776(31)
.L408:
	lwz 11,776(31)
	andi. 10,11,32
	bc 12,2,.L409
	rlwinm 0,11,0,27,25
	lis 10,.LC63@ha
	stw 0,776(31)
	lis 9,level+4@ha
	la 10,.LC63@l(10)
	lfs 0,level+4@l(9)
	andi. 0,11,64
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,848(31)
	bc 12,2,.L410
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
	b .L411
.L410:
	andi. 9,11,16
	bc 12,2,.L412
	rlwinm 0,11,0,28,25
	mr 3,31
	stw 0,776(31)
	bl PlayerTrail_PickFirst
	b .L411
.L412:
	mr 3,31
	bl PlayerTrail_PickNext
.L411:
	cmpwi 0,3,0
	bc 12,2,.L409
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
.L409:
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
	bc 4,3,.L415
	lwz 0,776(31)
	fmr 27,30
	ori 0,0,32
	stw 0,776(31)
.L415:
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
	bc 12,2,.L416
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
	lis 11,.LC66@ha
	la 11,.LC66@l(11)
	lfs 26,0(11)
	blrl
	lfs 0,32(1)
	fcmpu 0,0,26
	bc 4,0,.L416
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
	lis 9,.LC67@ha
	fmr 30,1
	addi 3,1,8
	la 9,.LC67@l(9)
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
	bc 12,2,.L418
	fcmpu 0,31,26
	bc 4,0,.L419
	fmuls 0,28,31
	lis 11,.LC68@ha
	stw 20,12(1)
	mr 3,30
	la 11,.LC68@l(11)
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
.L419:
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
	b .L427
.L418:
	fcmpu 7,13,29
	fcmpu 6,13,31
	cror 31,30,29
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,26,1
	and. 10,9,0
	bc 12,2,.L416
	fcmpu 0,13,26
	bc 4,0,.L422
	fmuls 0,28,13
	lis 11,.LC68@ha
	stw 19,12(1)
	mr 3,30
	la 11,.LC68@l(11)
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
.L422:
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
.L427:
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
.L416:
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L342
	mr 3,18
	bl G_FreeEdict
	cmpwi 0,31,0
	bc 12,2,.L342
	stw 17,412(31)
.L342:
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
.Lfe8:
	.size	 ai_run,.Lfe8-ai_run
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
.LC69:
	.long 0x46fffe00
	.align 2
.LC70:
	.long 0x0
	.align 3
.LC71:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC72:
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
	bc 4,2,.L36
	lwz 0,796(31)
	cmpwi 0,0,0
	bc 12,2,.L36
	lis 9,level@ha
	lfs 13,876(31)
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,0,13
	bc 4,1,.L36
	lis 9,.LC70@ha
	la 9,.LC70@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L39
	mtlr 0
	mr 3,31
	blrl
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,4(30)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC71@ha
	lis 11,.LC69@ha
	la 10,.LC71@l(10)
	stw 0,16(1)
	lfd 11,0(10)
	lfd 0,16(1)
	lis 10,.LC72@ha
	lfs 13,.LC69@l(11)
	la 10,.LC72@l(10)
	lfs 10,0(10)
	fsub 0,0,11
	fadds 12,12,10
	frsp 0,0
	fdivs 0,0,13
	fmadds 0,0,10,12
	b .L428
.L39:
	bl rand
	rlwinm 3,3,0,17,31
	lfs 10,4(30)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC71@ha
	lis 11,.LC69@ha
	la 10,.LC71@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC72@ha
	lfs 12,.LC69@l(11)
	la 10,.LC72@l(10)
	lfs 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmadds 0,0,11,10
.L428:
	stfs 0,876(31)
.L36:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 ai_walk,.Lfe10-ai_walk
	.section	".rodata"
	.align 2
.LC73:
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
	lis 9,.LC73@ha
	mr 31,3
	la 9,.LC73@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,2,.L57
	fmr 2,1
	lfs 1,20(31)
	bl M_walkmove
.L57:
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 4,2,.L56
	lwz 0,776(31)
	andis. 9,0,1
	bc 4,2,.L56
	mr 3,31
	bl M_ChangeYaw
.L56:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 ai_turn,.Lfe11-ai_turn
	.section	".rodata"
	.align 2
.LC74:
	.long 0x42a00000
	.align 2
.LC75:
	.long 0x43fa0000
	.align 2
.LC76:
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
	lis 9,.LC74@ha
	la 9,.LC74@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L61
	li 3,0
	b .L429
.L61:
	lis 9,.LC75@ha
	la 9,.LC75@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L62
	lis 9,.LC76@ha
	la 9,.LC76@l(9)
	lfs 0,0(9)
	fcmpu 7,1,0
	mfcr 3
	rlwinm 3,3,29,1
	neg 3,3
	nor 0,3,3
	rlwinm 3,3,0,30,30
	rlwinm 0,0,0,30,31
	or 3,3,0
	b .L429
.L62:
	li 3,1
.L429:
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe12:
	.size	 range,.Lfe12-range
	.section	".rodata"
	.align 3
.LC77:
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
	lis 9,.LC77@ha
	lfs 11,12(1)
	lfs 12,8(1)
	lfs 10,24(1)
	fmuls 11,11,0
	lfs 9,32(1)
	lfs 0,16(1)
	lfd 13,.LC77@l(9)
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
.LC78:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC79:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl visible
	.type	 visible,@function
visible:
	stwu 1,-128(1)
	mflr 0
	stmw 28,112(1)
	stw 0,132(1)
	mr 31,4
	mr 12,3
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L66
	lwz 0,508(12)
	lis 29,0x4330
	lwz 11,508(31)
	mr 10,9
	lis 8,.LC78@ha
	xoris 0,0,0x8000
	la 8,.LC78@l(8)
	lfs 7,12(12)
	stw 0,108(1)
	xoris 11,11,0x8000
	lis 28,gi+48@ha
	stw 29,104(1)
	lis 5,vec3_origin@ha
	addi 3,1,40
	lfd 13,104(1)
	la 5,vec3_origin@l(5)
	addi 4,1,8
	stw 11,108(1)
	mr 6,5
	addi 7,1,24
	stw 29,104(1)
	li 9,25
	lfd 11,0(8)
	lfd 0,104(1)
	mr 8,12
	lfs 12,12(31)
	fsub 13,13,11
	lwz 0,gi+48@l(28)
	fsub 0,0,11
	lfs 10,4(12)
	lfs 11,8(12)
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
	lis 8,.LC79@ha
	la 8,.LC79@l(8)
	lfd 13,0(8)
	fcmpu 0,0,13
	bc 12,2,.L67
	lwz 0,92(1)
	cmpw 0,0,31
	bc 4,2,.L66
.L67:
	li 3,1
	b .L431
.L66:
	li 3,0
.L431:
	lwz 0,132(1)
	mtlr 0
	lmw 28,112(1)
	la 1,128(1)
	blr
.Lfe14:
	.size	 visible,.Lfe14-visible
	.section	".rodata"
	.align 2
.LC80:
	.long 0x439d8000
	.align 2
.LC81:
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
	lis 11,.LC81@ha
	lis 9,.LC80@ha
	la 11,.LC81@l(11)
	lfs 0,.LC80@l(9)
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
.LC82:
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
	bc 12,2,.L71
	lwz 9,788(31)
	mtlr 9
	blrl
	b .L72
.L71:
	lwz 9,804(31)
	mr 3,31
	mtlr 9
	blrl
.L72:
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
	bc 4,2,.L73
	lis 11,.LC82@ha
	mr 3,31
	la 11,.LC82@l(11)
	lfs 1,0(11)
	bl AttackFinished
.L73:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 HuntTarget,.Lfe16-HuntTarget
	.section	".rodata"
	.align 2
.LC83:
	.long 0x439d8000
	.align 2
.LC84:
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
	bc 4,2,.L239
	bl M_ChangeYaw
.L239:
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
	bc 4,2,.L240
	lwz 9,816(31)
	mr 3,31
	mtlr 9
	blrl
	li 0,1
	stw 0,868(31)
.L240:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe17:
	.size	 ai_run_melee,.Lfe17-ai_run_melee
	.section	".rodata"
	.align 2
.LC85:
	.long 0x439d8000
	.align 2
.LC86:
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
	bc 4,2,.L244
	bl M_ChangeYaw
.L244:
	lfs 0,20(31)
	lfs 1,424(31)
	fsubs 1,0,1
	bl anglemod
	lis 11,.LC86@ha
	lis 9,.LC85@ha
	la 11,.LC86@l(11)
	lfs 0,.LC85@l(9)
	lfs 13,0(11)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 11,0,9
	bc 4,2,.L245
	lwz 9,812(31)
	mr 3,31
	mtlr 9
	blrl
	lwz 9,868(31)
	addi 9,9,-4
	cmplwi 0,9,1
	bc 12,1,.L245
	li 0,1
	stw 0,868(31)
.L245:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe18:
	.size	 ai_run_missile,.Lfe18-ai_run_missile
	.section	".rodata"
	.align 2
.LC87:
	.long 0x42b40000
	.align 2
.LC88:
	.long 0xc2b40000
	.align 3
.LC89:
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
	lis 11,.LC87@ha
	lfs 0,enemy_yaw@l(9)
	la 11,.LC87@l(11)
	cmpwi 0,0,0
	lfs 30,0(11)
	stfs 0,424(31)
	bc 4,2,.L251
	lis 9,.LC88@ha
	la 9,.LC88@l(9)
	lfs 30,0(9)
.L251:
	lwz 0,776(31)
	andis. 11,0,1
	bc 4,2,.L252
	mr 3,31
	bl M_ChangeYaw
.L252:
	lwz 0,264(31)
	cmpwi 0,0,0
	bc 4,2,.L253
	lis 9,.LC89@ha
	fmr 13,31
	lis 0,0x4100
	la 9,.LC89@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L254
	stfs 31,8(1)
	lwz 0,8(1)
.L254:
	stw 0,8(1)
	lfs 0,8(1)
	fmr 31,0
.L253:
	lfs 1,424(31)
	fmr 2,31
	mr 3,31
	fadds 1,1,30
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L249
	lwz 0,776(31)
	andis. 9,0,4
	bc 12,2,.L257
	mr 3,31
	bl monster_done_dodge
	b .L259
.L257:
	lfs 1,424(31)
	fmr 2,31
	mr 3,31
	lwz 0,872(31)
	fsubs 1,1,30
	subfic 0,0,1
	stw 0,872(31)
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L249
	lwz 0,776(31)
	andis. 9,0,4
	bc 12,2,.L259
	mr 3,31
	bl monster_done_dodge
.L259:
	li 0,1
	stw 0,868(31)
.L249:
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
