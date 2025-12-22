	.file	"g_ai.c"
gcc2_compiled.:
	.section	".text"
	.align 2
	.globl AI_SetSightClient
	.type	 AI_SetSightClient,@function
AI_SetSightClient:
	lis 9,level+256@ha
	lwz 10,level+256@l(9)
	cmpwi 0,10,0
	bc 4,2,.L7
	li 7,1
	b .L8
.L17:
	lis 9,level+256@ha
	stw 11,level+256@l(9)
	blr
.L7:
	lis 11,g_edicts@ha
	lis 9,0xbdef
	lwz 0,g_edicts@l(11)
	ori 9,9,31711
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
	mulli 0,8,992
	add 11,10,0
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L13
	lwz 0,576(11)
	cmpwi 0,0,0
	bc 4,1,.L13
	lwz 0,292(11)
	cmpwi 0,0,1
	bc 4,2,.L13
	lwz 0,264(11)
	andi. 9,0,32
	bc 12,2,.L17
.L13:
	lwz 0,384(11)
	cmpwi 0,0,0
	bc 12,2,.L14
	lwz 0,576(11)
	cmpwi 0,0,0
	bc 4,1,.L14
	lwz 0,320(11)
	cmpwi 0,0,0
	bc 12,1,.L17
.L14:
	cmpw 0,8,7
	bc 4,2,.L11
	stw 5,256(4)
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
	lwz 0,872(31)
	andi. 9,0,1
	bc 12,2,.L22
	lwz 9,636(31)
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
	stfs 1,520(31)
	fcmpu 0,0,1
	bc 12,2,.L24
	lwz 0,872(31)
	andi. 9,0,2
	bc 12,2,.L24
	lwz 11,900(31)
	mr 3,31
	rlwinm 0,0,0,0,29
	stw 0,872(31)
	mtlr 11
	blrl
.L24:
	mr 3,31
	bl M_ChangeYaw
	lis 9,.LC1@ha
	mr 3,31
	la 9,.LC1@l(9)
	lfs 1,0(9)
	bl ai_checkattack
	b .L20
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
	lfs 0,924(31)
	la 30,level@l(9)
	lfs 13,4(30)
	fcmpu 0,13,0
	bc 4,1,.L27
	lwz 0,896(31)
	mr 3,31
	mtlr 0
	blrl
	b .L20
.L27:
	lwz 0,284(31)
	andi. 9,0,1
	bc 4,2,.L20
	lwz 0,888(31)
	cmpwi 0,0,0
	bc 12,2,.L20
	lfs 0,972(31)
	fcmpu 0,13,0
	bc 4,1,.L20
	fcmpu 0,0,31
	bc 12,2,.L29
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
	b .L31
.L29:
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
.L31:
	stfs 0,972(31)
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
	lwz 9,636(31)
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L55
	lwz 0,level@l(11)
	la 9,level@l(11)
	li 11,128
	stw 31,260(9)
	stw 0,264(9)
	stw 11,736(31)
.L55:
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
	bc 12,3,.L56
	fctiwz 0,13
	stfd 0,24(1)
	lwz 0,28(1)
	b .L57
.L56:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	xoris 0,0,0x8000
.L57:
	lwz 11,636(31)
	lis 9,level+4@ha
	stw 0,592(31)
	lfs 0,4(11)
	lwz 3,416(31)
	stfs 0,952(31)
	cmpwi 0,3,0
	lfs 13,8(11)
	stfs 13,956(31)
	lfs 0,12(11)
	stfs 0,960(31)
	lfs 13,level+4@l(9)
	stfs 13,948(31)
	bc 4,2,.L58
	lwz 0,872(31)
	stw 11,508(31)
	andi. 11,0,1
	bc 12,2,.L59
	lwz 9,884(31)
	mr 3,31
	mtlr 9
	blrl
	b .L60
.L59:
	lwz 9,900(31)
	mr 3,31
	mtlr 9
	blrl
.L60:
	lwz 9,636(31)
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
	lwz 0,872(31)
	stfs 1,520(31)
	andi. 9,0,1
	bc 4,2,.L54
	lis 11,.LC7@ha
	mr 3,31
	la 11,.LC7@l(11)
	lfs 1,0(11)
	bl AttackFinished
	b .L54
.L58:
	bl G_PickTarget
	mr 10,3
	cmpwi 0,10,0
	stw 10,512(31)
	stw 10,508(31)
	bc 4,2,.L63
	lwz 0,872(31)
	lwz 9,636(31)
	andi. 11,0,1
	stw 9,508(31)
	stw 9,512(31)
	bc 12,2,.L64
	lwz 9,884(31)
	mr 3,31
	mtlr 9
	blrl
	b .L65
.L64:
	lwz 9,900(31)
	mr 3,31
	mtlr 9
	blrl
.L65:
	lwz 9,636(31)
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
	lwz 0,872(31)
	stfs 1,520(31)
	andi. 9,0,1
	bc 4,2,.L67
	lis 11,.LC7@ha
	mr 3,31
	la 11,.LC7@l(11)
	lfs 1,0(11)
	bl AttackFinished
.L67:
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC6@ha
	lwz 6,416(31)
	la 3,.LC6@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L54
.L63:
	lwz 0,872(31)
	li 9,0
	mr 3,31
	stw 9,416(31)
	li 11,0
	ori 0,0,4096
	stw 0,872(31)
	stw 9,396(10)
	lwz 9,900(31)
	stw 11,924(31)
	mtlr 9
	blrl
.L54:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 FoundTarget,.Lfe3-FoundTarget
	.section	".rodata"
	.align 2
.LC9:
	.string	"target_actor"
	.align 2
.LC11:
	.string	"player_noise"
	.align 3
.LC10:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC12:
	.long 0x42a00000
	.align 2
.LC13:
	.long 0x43fa0000
	.align 2
.LC14:
	.long 0x447a0000
	.align 3
.LC15:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC16:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC17:
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
	mr 30,3
	lwz 0,872(30)
	andi. 9,0,256
	bc 12,2,.L69
	lwz 3,508(30)
	cmpwi 0,3,0
	bc 12,2,.L135
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L135
	lwz 3,280(3)
	cmpwi 0,3,0
	bc 12,2,.L135
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,0
	bc 12,2,.L129
	b .L135
.L69:
	andi. 9,0,4096
	bc 4,2,.L135
	lis 9,level@ha
	li 10,0
	la 4,level@l(9)
	lwz 11,level@l(9)
	lwz 0,264(4)
	addi 11,11,-1
	cmpw 0,0,11
	bc 12,0,.L73
	lwz 0,284(30)
	andi. 11,0,1
	bc 4,2,.L73
	lwz 31,260(4)
	lwz 9,636(30)
	lwz 0,636(31)
	cmpw 0,0,9
	b .L131
.L73:
	lis 9,level@ha
	la 4,level@l(9)
	lwz 11,level@l(9)
	lwz 0,272(4)
	addi 11,11,-1
	cmpw 0,0,11
	bc 12,0,.L76
	lwz 31,268(4)
	li 10,1
	b .L75
.L76:
	lwz 0,636(30)
	cmpwi 0,0,0
	bc 4,2,.L78
	lwz 0,280(4)
	cmpw 0,0,11
	bc 12,0,.L78
	lwz 0,284(30)
	andi. 9,0,1
	bc 4,2,.L78
	lwz 31,276(4)
	li 10,1
	b .L75
.L78:
	lis 9,level+256@ha
	lwz 31,level+256@l(9)
	cmpwi 0,31,0
.L131:
	bc 12,2,.L135
.L75:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L135
	lwz 0,320(31)
	cmpwi 0,0,0
	bc 4,1,.L82
	lwz 0,384(31)
	cmpwi 0,0,0
	bc 12,2,.L135
.L82:
	lwz 0,84(31)
	cmpwi 0,0,0
	mr 9,0
	bc 12,2,.L83
	lwz 0,1812(9)
	cmpwi 0,0,1
	bc 12,2,.L135
.L83:
	lwz 0,636(30)
	cmpw 0,31,0
	bc 12,2,.L128
	cmpwi 0,9,0
	bc 12,2,.L86
	lwz 0,264(31)
	andi. 11,0,32
	b .L132
.L86:
	lwz 0,184(31)
	andi. 9,0,4
	bc 12,2,.L89
	lwz 9,636(31)
	cmpwi 0,9,0
	bc 12,2,.L135
	lwz 0,264(9)
	andi. 11,0,32
	b .L132
.L89:
	cmpwi 0,10,0
	bc 12,2,.L135
	lwz 9,256(31)
	lwz 0,264(9)
	andi. 9,0,32
.L132:
	bc 4,2,.L135
	cmpwi 0,10,0
	bc 4,2,.L96
	lfs 13,4(31)
	addi 3,1,8
	lfs 0,4(30)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 0,0,13
	stfs 0,8(1)
	lfs 13,8(31)
	fsubs 12,12,13
	stfs 12,12(1)
	lfs 0,12(31)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L97
	li 29,0
	b .L98
.L97:
	lis 11,.LC13@ha
	la 11,.LC13@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	bc 4,0,.L99
	li 29,1
	b .L98
.L99:
	lis 9,.LC14@ha
	li 29,3
	la 9,.LC14@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L98
	li 29,2
.L98:
	cmpwi 0,29,3
	bc 12,2,.L135
	lwz 0,736(31)
	cmpwi 0,0,5
	bc 4,1,.L135
	lwz 0,604(30)
	lis 28,0x4330
	lis 11,.LC15@ha
	lfs 12,12(30)
	lis 10,gi+48@ha
	xoris 0,0,0x8000
	la 11,.LC15@l(11)
	lfs 13,8(30)
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
	mr 8,30
	lfs 10,4(30)
	li 9,25
	stfs 13,28(1)
	fsub 0,0,11
	lwz 10,gi+48@l(10)
	stfs 10,24(1)
	mtlr 10
	frsp 0,0
	fadds 12,12,0
	stfs 12,32(1)
	lfs 0,4(31)
	stfs 0,40(1)
	lfs 13,8(31)
	stfs 13,44(1)
	lfs 12,12(31)
	stfs 12,48(1)
	lwz 0,604(31)
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
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L135
	cmpwi 0,29,1
	bc 4,2,.L106
	lwz 0,592(31)
	lis 11,.LC17@ha
	la 11,.LC17@l(11)
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
	b .L134
.L106:
	cmpwi 0,29,2
	bc 4,2,.L110
.L134:
	addi 3,30,16
	addi 4,1,24
	li 5,0
	li 6,0
	bl AngleVectors
	lfs 0,4(30)
	addi 3,1,8
	lfs 13,4(31)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(31)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(31)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorNormalize
	lfs 0,28(1)
	lis 9,.LC10@ha
	li 0,0
	lfs 11,12(1)
	lfs 12,8(1)
	lfs 10,24(1)
	fmuls 11,11,0
	lfs 9,32(1)
	lfs 0,16(1)
	lfd 13,.LC10@l(9)
	fmadds 12,12,10,11
	fmadds 0,0,9,12
	fcmpu 0,0,13
	bc 4,1,.L113
	li 0,1
.L113:
	cmpwi 0,0,0
	bc 12,2,.L135
.L110:
	stw 31,636(30)
	lis 4,.LC11@ha
	lwz 3,280(31)
	la 4,.LC11@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L118
	lwz 0,872(30)
	lwz 11,636(30)
	rlwinm 0,0,0,30,28
	stw 0,872(30)
	lwz 9,84(11)
	cmpwi 0,9,0
	bc 4,2,.L118
	lwz 9,636(11)
	stw 9,636(30)
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 4,2,.L118
	stw 0,636(30)
.L135:
	li 3,0
	b .L129
.L96:
	lwz 0,284(30)
	andi. 9,0,1
	bc 12,2,.L119
	lwz 0,604(30)
	lis 29,0x4330
	lis 11,.LC15@ha
	lfs 12,12(30)
	lis 10,gi+48@ha
	xoris 0,0,0x8000
	la 11,.LC15@l(11)
	lfs 13,8(30)
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
	mr 8,30
	lfs 10,4(30)
	li 9,25
	stfs 13,28(1)
	fsub 0,0,11
	lwz 10,gi+48@l(10)
	stfs 10,24(1)
	mtlr 10
	frsp 0,0
	fadds 12,12,0
	stfs 12,32(1)
	lfs 0,4(31)
	stfs 0,40(1)
	lfs 13,8(31)
	stfs 13,44(1)
	lfs 12,12(31)
	stfs 12,48(1)
	lwz 0,604(31)
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
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L123
	b .L135
.L119:
	lis 9,gi+60@ha
	addi 3,30,4
	lwz 0,gi+60@l(9)
	addi 4,31,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	bc 12,2,.L135
.L123:
	lfs 0,4(30)
	addi 3,1,8
	lfs 13,4(31)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(31)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(31)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorLength
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,1,.L135
	lwz 4,176(31)
	lwz 3,176(30)
	cmpw 0,4,3
	bc 12,2,.L126
	lis 9,gi+68@ha
	lwz 0,gi+68@l(9)
	mtlr 0
	blrl
	cmpwi 0,3,0
	li 3,0
	bc 12,2,.L129
.L126:
	addi 3,1,8
	bl vectoyaw
	stfs 1,520(30)
	mr 3,30
	bl M_ChangeYaw
	lwz 0,872(30)
	stw 31,636(30)
	ori 0,0,4
	stw 0,872(30)
.L118:
	mr 3,30
	bl FoundTarget
	lwz 0,872(30)
	andi. 9,0,4
	bc 4,2,.L128
	lwz 0,916(30)
	cmpwi 0,0,0
	bc 12,2,.L128
	mr 3,30
	mtlr 0
	lwz 4,636(3)
	blrl
.L128:
	li 3,1
.L129:
	lwz 0,148(1)
	mtlr 0
	lmw 28,128(1)
	la 1,144(1)
	blr
.Lfe4:
	.size	 FindTarget,.Lfe4-FindTarget
	.section	".rodata"
	.align 2
.LC19:
	.string	"gladiator"
	.align 2
.LC24:
	.string	"mutant"
	.align 2
.LC20:
	.long 0x3d4ccccd
	.align 2
.LC21:
	.long 0x3e99999a
	.align 2
.LC22:
	.long 0x3ecccccd
	.align 2
.LC23:
	.long 0x3e4ccccd
	.align 2
.LC25:
	.long 0x3f666666
	.align 2
.LC26:
	.long 0x3f4ccccd
	.align 2
.LC27:
	.long 0x3dcccccd
	.align 2
.LC28:
	.long 0x3f333333
	.align 2
.LC29:
	.long 0x46fffe00
	.align 3
.LC30:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC31:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC32:
	.long 0x0
	.align 3
.LC33:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC34:
	.long 0x40000000
	.align 2
.LC35:
	.long 0x40400000
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
	lwz 12,636(31)
	lwz 0,576(12)
	cmpwi 0,0,0
	bc 4,1,.L139
	lwz 0,604(31)
	lis 28,0x4330
	lis 9,.LC31@ha
	lfs 12,12(31)
	mr 10,11
	xoris 0,0,0x8000
	la 9,.LC31@l(9)
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
	lwz 0,604(12)
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
	lwz 0,636(31)
	cmpw 0,9,0
	bc 4,2,.L173
.L139:
	lwz 9,508(31)
	lwz 0,320(9)
	mr 11,9
	cmpwi 0,0,0
	bc 4,2,.L141
	lis 9,enemy_range@ha
	lwz 0,enemy_range@l(9)
	cmpwi 0,0,0
	bc 4,2,.L141
	lis 9,.LC32@ha
	lis 11,skill@ha
	la 9,.LC32@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L143
	bl rand
	andi. 0,3,3
	bc 4,2,.L173
.L143:
	lwz 0,912(31)
	cmpwi 0,0,0
	li 0,4
	bc 12,2,.L144
	li 0,3
.L144:
	stw 0,964(31)
	li 3,1
	b .L176
.L141:
	lwz 0,908(31)
	cmpwi 0,0,0
	bc 12,2,.L173
	lis 9,level+4@ha
	lfs 13,928(31)
	lfs 0,level+4@l(9)
	fcmpu 0,0,13
	bc 12,0,.L173
	lis 9,enemy_range@ha
	lwz 0,enemy_range@l(9)
	cmpwi 0,0,3
	bc 4,2,.L148
	lwz 3,280(31)
	lis 4,.LC19@ha
	la 4,.LC19@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L173
	lwz 11,508(31)
.L148:
	lwz 0,320(11)
	cmpwi 0,0,0
	bc 12,1,.L173
	lwz 0,872(31)
	andi. 9,0,1
	bc 12,2,.L152
	lwz 3,280(31)
	lis 4,.LC19@ha
	la 4,.LC19@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L153
	lis 9,.LC21@ha
	lfs 31,.LC21@l(9)
	b .L155
.L153:
	lis 9,.LC22@ha
	lfs 31,.LC22@l(9)
	b .L155
.L152:
	lis 9,enemy_range@ha
	lwz 0,enemy_range@l(9)
	cmpwi 0,0,0
	bc 4,2,.L156
	lis 9,.LC23@ha
	lwz 3,280(31)
	lis 4,.LC24@ha
	lfs 31,.LC23@l(9)
	la 4,.LC24@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L155
	lis 9,.LC25@ha
	lfs 31,.LC25@l(9)
	b .L155
.L156:
	cmpwi 0,0,1
	bc 4,2,.L159
	lis 9,.LC23@ha
	lwz 3,280(31)
	lis 4,.LC24@ha
	lfs 31,.LC23@l(9)
	la 4,.LC24@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L155
	lis 9,.LC26@ha
	lfs 31,.LC26@l(9)
	b .L155
.L159:
	cmpwi 0,0,2
	bc 4,2,.L173
	lwz 3,280(31)
	lis 4,.LC19@ha
	la 4,.LC19@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L163
	lis 9,.LC20@ha
	lfs 31,.LC20@l(9)
	b .L164
.L163:
	lis 9,.LC27@ha
	lfs 31,.LC27@l(9)
.L164:
	lwz 3,280(31)
	lis 4,.LC24@ha
	la 4,.LC24@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L155
	lis 9,.LC28@ha
	lfs 31,.LC28@l(9)
.L155:
	lis 11,.LC32@ha
	lis 9,skill@ha
	la 11,.LC32@l(11)
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L167
	lis 9,.LC33@ha
	fmr 0,31
	la 9,.LC33@l(9)
	lfd 13,0(9)
	fmul 0,0,13
	frsp 31,0
	b .L168
.L167:
	lis 11,.LC34@ha
	la 11,.LC34@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L168
	lwz 3,280(31)
	lis 4,.LC24@ha
	la 4,.LC24@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L170
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 0,0(9)
	fmuls 31,31,0
	b .L168
.L170:
	fadds 31,31,31
.L168:
	bl rand
	lis 29,0x4330
	lis 9,.LC31@ha
	rlwinm 3,3,0,17,31
	la 9,.LC31@l(9)
	xoris 3,3,0x8000
	lfd 30,0(9)
	lis 11,.LC29@ha
	lfs 29,.LC29@l(11)
	stw 3,116(1)
	stw 29,112(1)
	lfd 0,112(1)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,29
	fcmpu 0,0,31
	bc 4,0,.L172
	li 0,4
	stw 0,964(31)
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
	stfs 13,928(31)
	b .L176
.L172:
	lwz 0,264(31)
	andi. 9,0,1
	bc 12,2,.L173
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC30@ha
	stw 3,116(1)
	stw 29,112(1)
	lfd 0,112(1)
	lfd 12,.LC30@l(11)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fcmpu 0,13,12
	li 0,1
	bc 4,0,.L174
	li 0,2
.L174:
	stw 0,964(31)
.L173:
	li 3,0
.L176:
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
	.align 3
.LC38:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC39:
	.long 0x4cbebc20
	.align 3
.LC40:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC41:
	.long 0x439d8000
	.align 3
.LC42:
	.long 0x40140000
	.long 0x0
	.align 3
.LC43:
	.long 0x41e00000
	.long 0x0
	.align 2
.LC44:
	.long 0x3f800000
	.align 3
.LC45:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC46:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC47:
	.long 0x40a00000
	.align 2
.LC48:
	.long 0x42a00000
	.align 2
.LC49:
	.long 0x43fa0000
	.align 2
.LC50:
	.long 0x447a0000
	.align 2
.LC51:
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
	lwz 10,508(31)
	cmpwi 0,10,0
	bc 12,2,.L192
	lwz 0,872(31)
	andi. 8,0,4096
	bc 4,2,.L243
	andi. 9,0,4
	bc 12,2,.L192
	lwz 11,636(31)
	lis 9,level+4@ha
	lis 8,.LC42@ha
	lfs 12,level+4@l(9)
	la 8,.LC42@l(8)
	lfs 0,700(11)
	lfd 13,0(8)
	fsubs 0,12,0
	fcmpu 0,0,13
	bc 4,1,.L195
	cmpw 0,10,11
	bc 4,2,.L196
	lwz 0,512(31)
	cmpwi 0,0,0
	stw 0,508(31)
.L196:
	lwz 9,872(31)
	andi. 11,9,2
	rlwinm 0,9,0,30,28
	stw 0,872(31)
	bc 12,2,.L192
	rlwinm 0,9,0,0,28
	stw 0,872(31)
	b .L192
.L195:
	lis 9,.LC38@ha
	fmr 0,12
	lis 8,.LC43@ha
	lfd 13,.LC38@l(9)
	la 8,.LC43@l(8)
	lfd 12,0(8)
	fadd 13,0,13
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L201
	fctiwz 0,13
	stfd 0,136(1)
	lwz 0,140(1)
	b .L202
.L201:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,136(1)
	lwz 0,140(1)
	xoris 0,0,0x8000
.L202:
	stw 0,592(31)
	b .L243
.L192:
	lwz 10,636(31)
	lis 9,enemy_vis@ha
	li 0,0
	stw 0,enemy_vis@l(9)
	cmpwi 0,10,0
	li 9,0
	bc 12,2,.L204
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 4,2,.L203
.L204:
	li 9,1
	b .L205
.L203:
	lwz 11,872(31)
	andi. 0,11,8192
	bc 12,2,.L206
	lwz 0,576(10)
	cmpwi 0,0,0
	bc 4,1,.L205
	rlwinm 0,11,0,19,17
	li 9,1
	stw 0,872(31)
	b .L205
.L206:
	andi. 8,11,512
	bc 12,2,.L209
	lwz 0,576(10)
	cmpwi 7,0,-80
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	b .L205
.L209:
	lwz 0,576(10)
	srawi 9,0,31
	subf 9,0,9
	srawi 9,9,31
	addi 9,9,1
.L205:
	cmpwi 0,9,0
	bc 12,2,.L213
	lwz 9,640(31)
	li 11,0
	stw 11,636(31)
	cmpwi 0,9,0
	bc 12,2,.L214
	lwz 0,576(9)
	cmpwi 0,0,0
	bc 4,1,.L214
	lwz 0,872(31)
	stw 11,640(31)
	andi. 11,0,1
	stw 9,508(31)
	stw 9,636(31)
	bc 12,2,.L215
	lwz 9,884(31)
	mr 3,31
	mtlr 9
	blrl
	b .L216
.L215:
	lwz 9,900(31)
	mr 3,31
	mtlr 9
	blrl
.L216:
	lwz 9,636(31)
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
	lwz 0,872(31)
	stfs 1,520(31)
	andi. 8,0,1
	bc 4,2,.L213
	lis 9,.LC44@ha
	mr 3,31
	la 9,.LC44@l(9)
	lfs 1,0(9)
	bl AttackFinished
	b .L213
.L214:
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 12,2,.L220
	lwz 11,896(31)
	mr 3,31
	stw 0,508(31)
	mtlr 11
	blrl
	b .L242
.L220:
	lis 9,level+4@ha
	lis 11,.LC39@ha
	lwz 10,884(31)
	lfs 0,level+4@l(9)
	mr 3,31
	lfs 13,.LC39@l(11)
	mtlr 10
	fadds 0,0,13
	stfs 0,924(31)
	blrl
	b .L242
.L213:
	lis 8,.LC44@ha
	lis 9,level+4@ha
	la 8,.LC44@l(8)
	lfs 0,level+4@l(9)
	lfs 13,0(8)
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfd 12,0(9)
	fadds 0,0,13
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,1
	bc 12,3,.L222
	fctiwz 0,13
	stfd 0,136(1)
	lwz 12,140(1)
	b .L223
.L222:
	fsub 0,13,12
	fctiwz 13,0
	stfd 13,136(1)
	lwz 12,140(1)
	xoris 12,12,0x8000
.L223:
	lwz 0,604(31)
	lis 28,0x4330
	lis 11,.LC45@ha
	lfs 13,12(31)
	mr 10,9
	xoris 0,0,0x8000
	la 11,.LC45@l(11)
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
	stw 12,592(31)
	fsub 0,0,11
	lwz 11,636(31)
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
	lwz 0,604(11)
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
	lis 8,.LC46@ha
	lis 9,enemy_vis@ha
	la 8,.LC46@l(8)
	lfd 13,0(8)
	fcmpu 7,0,13
	mfcr 0
	rlwinm 0,0,31,1
	cmpwi 0,0,0
	stw 0,enemy_vis@l(9)
	bc 12,2,.L226
	lis 9,.LC47@ha
	lis 11,level+4@ha
	la 9,.LC47@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lwz 9,636(31)
	fadds 0,0,13
	stfs 0,944(31)
	lfs 13,4(9)
	stfs 13,952(31)
	lfs 0,8(9)
	stfs 0,956(31)
	lfs 13,12(9)
	stfs 13,960(31)
.L226:
	lwz 29,636(31)
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
	lis 9,.LC40@ha
	li 0,0
	lfs 11,28(1)
	lfs 12,24(1)
	lfs 10,40(1)
	fmuls 11,11,0
	lfs 9,48(1)
	lfs 0,32(1)
	lfd 13,.LC40@l(9)
	fmadds 12,12,10,11
	fmadds 0,0,9,12
	fcmpu 0,0,13
	bc 4,1,.L227
	li 0,1
.L227:
	lwz 9,636(31)
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
	lis 8,.LC48@ha
	la 8,.LC48@l(8)
	lfs 0,0(8)
	fcmpu 0,1,0
	bc 4,0,.L229
	li 0,0
	b .L230
.L229:
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L231
	li 0,1
	b .L230
.L231:
	lis 11,.LC50@ha
	li 0,3
	la 11,.LC50@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	bc 4,0,.L230
	li 0,2
.L230:
	lwz 9,636(31)
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
	lwz 0,964(31)
	lis 9,enemy_yaw@ha
	stfs 1,enemy_yaw@l(9)
	cmpwi 0,0,4
	bc 4,2,.L233
	stfs 1,520(31)
	mr 3,31
	bl M_ChangeYaw
	lfs 0,20(31)
	lfs 1,520(31)
	fsubs 1,0,1
	bl anglemod
	lis 8,.LC51@ha
	lis 9,.LC41@ha
	la 8,.LC51@l(8)
	lfs 0,.LC41@l(9)
	lfs 13,0(8)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 11,0,9
	bc 4,2,.L242
	lwz 9,908(31)
	b .L245
.L233:
	cmpwi 0,0,3
	bc 4,2,.L238
	stfs 1,520(31)
	mr 3,31
	bl M_ChangeYaw
	lfs 0,20(31)
	lfs 1,520(31)
	fsubs 1,0,1
	bl anglemod
	lis 8,.LC51@ha
	lis 9,.LC41@ha
	la 8,.LC51@l(8)
	lfs 0,.LC41@l(9)
	lfs 13,0(8)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 11,0,9
	bc 4,2,.L242
	lwz 9,912(31)
.L245:
	mr 3,31
	mtlr 9
	blrl
	li 0,1
	stw 0,964(31)
.L242:
	li 3,1
	b .L244
.L238:
	lis 9,enemy_vis@ha
	lwz 0,enemy_vis@l(9)
	cmpwi 0,0,0
	bc 12,2,.L243
	lwz 0,920(31)
	mr 3,31
	mtlr 0
	blrl
	b .L244
.L243:
	li 3,0
.L244:
	lwz 0,164(1)
	mtlr 0
	lmw 28,144(1)
	la 1,160(1)
	blr
.Lfe6:
	.size	 ai_checkattack,.Lfe6-ai_checkattack
	.section	".rodata"
	.align 2
.LC52:
	.long 0x42800000
	.align 2
.LC53:
	.long 0xc2b40000
	.align 2
.LC54:
	.long 0x42b40000
	.align 2
.LC55:
	.long 0x0
	.align 2
.LC56:
	.long 0x41a00000
	.align 3
.LC57:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC58:
	.long 0x40a00000
	.align 2
.LC59:
	.long 0x3f800000
	.align 2
.LC60:
	.long 0x3f000000
	.align 3
.LC61:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ai_run
	.type	 ai_run,@function
ai_run:
	stwu 1,-288(1)
	mflr 0
	stfd 26,240(1)
	stfd 27,248(1)
	stfd 28,256(1)
	stfd 29,264(1)
	stfd 30,272(1)
	stfd 31,280(1)
	stmw 17,180(1)
	stw 0,292(1)
	mr 31,3
	fmr 27,1
	lwz 9,508(31)
	cmpwi 0,9,0
	bc 12,2,.L247
	lwz 0,320(9)
	cmpwi 0,0,0
	bc 4,1,.L247
	lwz 30,384(9)
	cmpwi 0,30,0
	bc 4,2,.L247
	lwz 11,884(31)
	lwz 0,872(31)
	stw 30,508(31)
	mtlr 11
	ori 0,0,3
	stw 0,872(31)
	blrl
	stw 30,636(31)
	b .L246
.L247:
	lwz 0,872(31)
	andi. 9,0,4096
	bc 12,2,.L249
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
	b .L246
.L249:
	andi. 9,0,4
	bc 12,2,.L250
	lwz 9,636(31)
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
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L251
	lwz 11,884(31)
	mr 3,31
	lwz 0,872(31)
	mtlr 11
	ori 0,0,3
	stw 0,872(31)
	blrl
	b .L246
.L251:
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 12,2,.L246
.L250:
	fmr 1,27
	mr 3,31
	bl ai_checkattack
	cmpwi 0,3,0
	bc 4,2,.L246
	lwz 0,964(31)
	cmpwi 0,0,2
	bc 4,2,.L254
	lis 9,enemy_yaw@ha
	mr 3,31
	lfs 0,enemy_yaw@l(9)
	lis 9,.LC53@ha
	la 9,.LC53@l(9)
	lfs 31,0(9)
	stfs 0,520(31)
	bl M_ChangeYaw
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L255
	lis 9,.LC54@ha
	la 9,.LC54@l(9)
	lfs 31,0(9)
.L255:
	lfs 1,520(31)
	fmr 2,27
	mr 3,31
	fadds 1,1,31
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L246
	lfs 1,520(31)
	fmr 2,27
	mr 3,31
	lwz 0,968(31)
	fsubs 1,1,31
	subfic 0,0,1
	stw 0,968(31)
	bl M_walkmove
	b .L246
.L254:
	lis 9,enemy_vis@ha
	lwz 0,enemy_vis@l(9)
	cmpwi 0,0,0
	bc 12,2,.L259
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
	lwz 0,872(31)
	lis 11,level+4@ha
	lwz 9,636(31)
	rlwinm 0,0,0,29,27
	stw 0,872(31)
	lfs 0,4(9)
	stfs 0,952(31)
	lfs 13,8(9)
	stfs 13,956(31)
	lfs 0,12(9)
	stfs 0,960(31)
	lfs 13,level+4@l(11)
	stfs 13,948(31)
	b .L246
.L259:
	lis 9,coop@ha
	lis 10,.LC55@ha
	lwz 11,coop@l(9)
	la 10,.LC55@l(10)
	lfs 31,0(10)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L260
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 4,2,.L246
.L260:
	lfs 13,944(31)
	fcmpu 0,13,31
	bc 12,2,.L262
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 0,0(9)
	lis 9,level+4@ha
	fadds 0,13,0
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 4,1,.L262
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
	stfs 31,944(31)
	b .L246
.L262:
	lwz 17,508(31)
	li 30,0
	bl G_Spawn
	lwz 0,872(31)
	mr 18,3
	stw 18,508(31)
	andi. 9,0,8
	bc 4,2,.L263
	lwz 9,300(31)
	ori 0,0,24
	rlwinm 0,0,0,27,24
	cmpwi 0,9,0
	stw 0,872(31)
	bc 4,2,.L264
	lis 10,.LC56@ha
	lis 11,level+4@ha
	la 10,.LC56@l(10)
	lfs 0,level+4@l(11)
	lfs 12,0(10)
	li 0,1
	stw 0,300(31)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,168(1)
	lwz 9,172(1)
	stw 9,304(31)
.L264:
	lwz 0,300(31)
	cmpwi 0,0,1
	bc 4,2,.L265
	lwz 0,304(31)
	lis 10,0x4330
	lis 11,.LC57@ha
	xoris 0,0,0x8000
	la 11,.LC57@l(11)
	stw 0,172(1)
	stw 10,168(1)
	lfd 13,0(11)
	lfd 0,168(1)
	lis 11,level+4@ha
	lfs 12,level+4@l(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L265
	lwz 11,884(31)
	mr 3,31
	lwz 0,872(31)
	stw 30,508(31)
	mtlr 11
	ori 0,0,3
	stw 0,872(31)
	blrl
	stw 30,300(31)
	stw 30,636(31)
	b .L246
.L265:
	li 30,1
.L263:
	lwz 11,872(31)
	andi. 0,11,32
	bc 12,2,.L267
	rlwinm 0,11,0,27,25
	lis 10,.LC58@ha
	stw 0,872(31)
	lis 9,level+4@ha
	la 10,.LC58@l(10)
	lfs 0,level+4@l(9)
	andi. 0,11,64
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,944(31)
	bc 12,2,.L268
	lfs 12,932(31)
	rlwinm 0,11,0,27,24
	li 3,0
	lfs 13,936(31)
	li 30,1
	lfs 0,940(31)
	stw 0,872(31)
	stfs 12,952(31)
	stfs 13,956(31)
	stfs 0,960(31)
	b .L269
.L268:
	andi. 9,11,16
	bc 12,2,.L270
	rlwinm 0,11,0,28,25
	mr 3,31
	stw 0,872(31)
	bl PlayerTrail_PickFirst
	b .L269
.L270:
	mr 3,31
	bl PlayerTrail_PickNext
.L269:
	cmpwi 0,3,0
	bc 12,2,.L267
	lfs 13,4(3)
	li 30,1
	stfs 13,952(31)
	lfs 0,8(3)
	stfs 0,956(31)
	lfs 13,12(3)
	stfs 13,960(31)
	lfs 0,288(3)
	stfs 0,948(31)
	lfs 13,20(3)
	stfs 13,20(31)
	stfs 13,520(31)
.L267:
	lfs 11,952(31)
	addi 3,1,8
	lfs 12,4(31)
	lfs 13,8(31)
	lfs 10,956(31)
	fsubs 12,12,11
	lfs 0,12(31)
	lfs 11,960(31)
	fsubs 13,13,10
	stfs 12,8(1)
	fsubs 0,0,11
	stfs 13,12(1)
	stfs 0,16(1)
	bl VectorLength
	fmr 30,1
	fcmpu 0,30,27
	cror 3,2,0
	bc 4,3,.L273
	lwz 0,872(31)
	fmr 27,30
	ori 0,0,32
	stw 0,872(31)
.L273:
	lfs 0,952(31)
	cmpwi 0,30,0
	lwz 11,508(31)
	stfs 0,4(11)
	lfs 0,956(31)
	lwz 9,508(31)
	stfs 0,8(9)
	lfs 0,960(31)
	lwz 11,508(31)
	stfs 0,12(11)
	bc 12,2,.L274
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
	addi 7,31,952
	mr 8,31
	ori 9,9,3
	lis 11,.LC59@ha
	la 11,.LC59@l(11)
	lfs 26,0(11)
	blrl
	lfs 0,32(1)
	fcmpu 0,0,26
	bc 4,0,.L274
	lwz 9,508(31)
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
	lis 9,.LC60@ha
	fmr 30,1
	addi 3,1,8
	la 9,.LC60@l(9)
	lfs 13,0(9)
	fadds 0,29,26
	fmuls 0,0,13
	fmuls 28,30,0
	bl vectoyaw
	stfs 1,20(31)
	addi 3,31,16
	mr 4,29
	stfs 1,520(31)
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
	bc 12,2,.L276
	fcmpu 0,31,26
	bc 4,0,.L277
	fmuls 0,28,31
	lis 11,.LC61@ha
	stw 20,12(1)
	mr 3,30
	la 11,.LC61@l(11)
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
.L277:
	lfs 12,952(31)
	addi 3,1,8
	lfs 11,956(31)
	lfs 0,960(31)
	lwz 0,872(31)
	lfs 13,120(1)
	lwz 11,508(31)
	ori 0,0,64
	stfs 11,936(31)
	stfs 12,932(31)
	stfs 0,940(31)
	stw 0,872(31)
	stfs 13,4(11)
	lfs 0,124(1)
	lwz 9,508(31)
	stfs 0,8(9)
	lfs 0,128(1)
	lwz 11,508(31)
	stfs 0,12(11)
	lfs 13,120(1)
	lfs 0,124(1)
	lfs 12,128(1)
	b .L282
.L276:
	fcmpu 7,13,29
	fcmpu 6,13,31
	cror 31,30,29
	mfcr 0
	rlwinm 9,0,0,1
	rlwinm 0,0,26,1
	and. 10,9,0
	bc 12,2,.L274
	fcmpu 0,13,26
	bc 4,0,.L280
	fmuls 0,28,13
	lis 11,.LC61@ha
	stw 19,12(1)
	mr 3,30
	la 11,.LC61@l(11)
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
.L280:
	lfs 12,952(31)
	addi 3,1,8
	lfs 11,956(31)
	lfs 0,960(31)
	lwz 0,872(31)
	lfs 13,136(1)
	lwz 11,508(31)
	ori 0,0,64
	stfs 11,936(31)
	stfs 12,932(31)
	stfs 0,940(31)
	stw 0,872(31)
	stfs 13,4(11)
	lfs 0,140(1)
	lwz 9,508(31)
	stfs 0,8(9)
	lfs 0,144(1)
	lwz 11,508(31)
	stfs 0,12(11)
	lfs 13,136(1)
	lfs 0,140(1)
	lfs 12,144(1)
.L282:
	lwz 9,508(31)
	stfs 0,956(31)
	stfs 12,960(31)
	stfs 13,952(31)
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
	stfs 1,520(31)
.L274:
	fmr 1,27
	mr 3,31
	bl M_MoveToGoal
	mr 3,18
	bl G_FreeEdict
	cmpwi 0,31,0
	bc 12,2,.L246
	stw 17,508(31)
.L246:
	lwz 0,292(1)
	mtlr 0
	lmw 17,180(1)
	lfd 26,240(1)
	lfd 27,248(1)
	lfd 28,256(1)
	lfd 29,264(1)
	lfd 30,272(1)
	lfd 31,280(1)
	la 1,288(1)
	blr
.Lfe7:
	.size	 ai_run,.Lfe7-ai_run
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
.LC62:
	.long 0x46fffe00
	.align 2
.LC63:
	.long 0x0
	.align 3
.LC64:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC65:
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
	bc 4,2,.L32
	lwz 0,892(31)
	cmpwi 0,0,0
	bc 12,2,.L32
	lis 9,level@ha
	lfs 13,972(31)
	la 30,level@l(9)
	lfs 0,4(30)
	fcmpu 0,0,13
	bc 4,1,.L32
	lis 9,.LC63@ha
	la 9,.LC63@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L35
	mtlr 0
	mr 3,31
	blrl
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,4(30)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC64@ha
	lis 11,.LC62@ha
	la 10,.LC64@l(10)
	stw 0,16(1)
	lfd 11,0(10)
	lfd 0,16(1)
	lis 10,.LC65@ha
	lfs 13,.LC62@l(11)
	la 10,.LC65@l(10)
	lfs 10,0(10)
	fsub 0,0,11
	fadds 12,12,10
	frsp 0,0
	fdivs 0,0,13
	fmadds 0,0,10,12
	b .L283
.L35:
	bl rand
	rlwinm 3,3,0,17,31
	lfs 10,4(30)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC64@ha
	lis 11,.LC62@ha
	la 10,.LC64@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC65@ha
	lfs 12,.LC62@l(11)
	la 10,.LC65@l(10)
	lfs 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmadds 0,0,11,10
.L283:
	stfs 0,972(31)
.L32:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 ai_walk,.Lfe9-ai_walk
	.section	".rodata"
	.align 2
.LC66:
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
	lis 9,.LC66@ha
	mr 31,3
	la 9,.LC66@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,2,.L40
	fmr 2,1
	lfs 1,20(31)
	bl M_walkmove
.L40:
	mr 3,31
	bl FindTarget
	cmpwi 0,3,0
	bc 4,2,.L39
	mr 3,31
	bl M_ChangeYaw
.L39:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 ai_turn,.Lfe10-ai_turn
	.section	".rodata"
	.align 2
.LC67:
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
	lwz 9,636(31)
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
	stfs 1,520(31)
	mr 3,31
	bl M_ChangeYaw
	lis 9,.LC67@ha
	la 9,.LC67@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 12,2,.L38
	mr 3,31
	fmr 2,31
	lfs 1,20(3)
	bl M_walkmove
.L38:
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
.LC68:
	.long 0x42a00000
	.align 2
.LC69:
	.long 0x43fa0000
	.align 2
.LC70:
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
	lis 9,.LC68@ha
	la 9,.LC68@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L43
	li 3,0
	b .L284
.L43:
	lis 9,.LC69@ha
	la 9,.LC69@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L44
	lis 9,.LC70@ha
	la 9,.LC70@l(9)
	lfs 0,0(9)
	fcmpu 7,1,0
	mfcr 3
	rlwinm 3,3,29,1
	neg 3,3
	nor 0,3,3
	rlwinm 3,3,0,30,30
	rlwinm 0,0,0,30,31
	or 3,3,0
	b .L284
.L44:
	li 3,1
.L284:
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe12:
	.size	 range,.Lfe12-range
	.section	".rodata"
	.align 3
.LC71:
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
	lis 9,.LC71@ha
	lfs 11,12(1)
	lfs 12,8(1)
	lfs 10,24(1)
	fmuls 11,11,0
	lfs 9,32(1)
	lfs 0,16(1)
	lfd 13,.LC71@l(9)
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
.LC72:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC73:
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
	lwz 0,604(29)
	lis 27,0x4330
	lwz 11,604(28)
	mr 10,9
	lis 8,.LC72@ha
	xoris 0,0,0x8000
	la 8,.LC72@l(8)
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
	lis 8,.LC73@ha
	la 8,.LC73@l(8)
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
.LC74:
	.long 0x439d8000
	.align 2
.LC75:
	.long 0x42340000
	.section	".text"
	.align 2
	.globl FacingIdeal
	.type	 FacingIdeal,@function
FacingIdeal:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lfs 0,520(3)
	lfs 1,20(3)
	fsubs 1,1,0
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
	mfcr 3
	rlwinm 3,3,3,1
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe15:
	.size	 FacingIdeal,.Lfe15-FacingIdeal
	.comm	maplist,292,4
	.comm	enemy_vis,4,4
	.comm	enemy_infront,4,4
	.comm	enemy_range,4,4
	.comm	enemy_yaw,4,4
	.section	".rodata"
	.align 2
.LC76:
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
	lwz 0,872(31)
	lwz 9,636(31)
	andi. 11,0,1
	stw 9,508(31)
	bc 12,2,.L51
	lwz 9,884(31)
	mtlr 9
	blrl
	b .L52
.L51:
	lwz 9,900(31)
	mr 3,31
	mtlr 9
	blrl
.L52:
	lwz 9,636(31)
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
	lwz 0,872(31)
	stfs 1,520(31)
	andi. 9,0,1
	bc 4,2,.L53
	lis 11,.LC76@ha
	mr 3,31
	la 11,.LC76@l(11)
	lfs 1,0(11)
	bl AttackFinished
.L53:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 HuntTarget,.Lfe16-HuntTarget
	.section	".rodata"
	.align 2
.LC77:
	.long 0x439d8000
	.align 2
.LC78:
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
	stfs 0,520(31)
	bl M_ChangeYaw
	lfs 0,20(31)
	lfs 1,520(31)
	fsubs 1,0,1
	bl anglemod
	lis 11,.LC78@ha
	lis 9,.LC77@ha
	la 11,.LC78@l(11)
	lfs 0,.LC77@l(9)
	lfs 13,0(11)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 11,0,9
	bc 4,2,.L180
	lwz 9,912(31)
	mr 3,31
	mtlr 9
	blrl
	li 0,1
	stw 0,964(31)
.L180:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe17:
	.size	 ai_run_melee,.Lfe17-ai_run_melee
	.section	".rodata"
	.align 2
.LC79:
	.long 0x439d8000
	.align 2
.LC80:
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
	stfs 0,520(31)
	bl M_ChangeYaw
	lfs 0,20(31)
	lfs 1,520(31)
	fsubs 1,0,1
	bl anglemod
	lis 11,.LC80@ha
	lis 9,.LC79@ha
	la 11,.LC80@l(11)
	lfs 0,.LC79@l(9)
	lfs 13,0(11)
	fcmpu 7,1,0
	fcmpu 6,1,13
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,26,1
	and. 11,0,9
	bc 4,2,.L184
	lwz 9,908(31)
	mr 3,31
	mtlr 9
	blrl
	li 0,1
	stw 0,964(31)
.L184:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe18:
	.size	 ai_run_missile,.Lfe18-ai_run_missile
	.section	".rodata"
	.align 2
.LC81:
	.long 0xc2b40000
	.align 2
.LC82:
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
	lis 9,.LC81@ha
	la 9,.LC81@l(9)
	lfs 31,0(9)
	stfs 0,520(31)
	bl M_ChangeYaw
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L188
	lis 9,.LC82@ha
	la 9,.LC82@l(9)
	lfs 31,0(9)
.L188:
	lfs 1,520(31)
	fmr 2,30
	mr 3,31
	fadds 1,1,31
	bl M_walkmove
	cmpwi 0,3,0
	bc 4,2,.L187
	lfs 1,520(31)
	fmr 2,30
	mr 3,31
	lwz 0,968(31)
	fsubs 1,1,31
	subfic 0,0,1
	stw 0,968(31)
	bl M_walkmove
.L187:
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
