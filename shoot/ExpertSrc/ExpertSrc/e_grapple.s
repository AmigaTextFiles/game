	.file	"e_grapple.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"world/land.wav"
	.align 2
.LC1:
	.long 0x3f800000
	.align 2
.LC2:
	.long 0x0
	.align 2
.LC3:
	.long 0x40800000
	.section	".text"
	.align 2
	.globl Grapple_Touch
	.type	 Grapple_Touch,@function
Grapple_Touch:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	mr 30,4
	lwz 0,256(31)
	mr 28,5
	cmpw 0,30,0
	bc 12,2,.L15
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,8192
	bc 4,2,.L17
	cmpwi 0,6,0
	bc 12,2,.L17
	lwz 0,16(6)
	andi. 8,0,4
	bc 12,2,.L17
	bl Release_Grapple
	b .L15
.L17:
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,30,0
	bc 12,2,.L19
	lwz 9,252(30)
	lis 0,0x600
	ori 0,0,3
	cmpw 0,9,0
	bc 12,2,.L15
.L19:
	lis 29,gi@ha
	lis 3,.LC0@ha
	la 29,gi@l(29)
	la 3,.LC0@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 8,.LC1@ha
	lwz 0,16(29)
	lis 9,.LC1@ha
	la 8,.LC1@l(8)
	mr 5,3
	lfs 1,0(8)
	la 9,.LC1@l(9)
	li 4,3
	mtlr 0
	lis 8,.LC2@ha
	mr 3,31
	lfs 2,0(9)
	la 8,.LC2@l(8)
	lfs 3,0(8)
	blrl
	cmpwi 0,30,0
	bc 12,2,.L20
	lwz 5,256(31)
	li 9,34
	li 0,0
	stw 9,12(1)
	mr 8,28
	mr 3,30
	stw 0,8(1)
	mr 4,31
	addi 6,31,376
	addi 7,31,4
	li 9,3
	li 10,0
	bl T_Damage
.L20:
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,30,0
	bc 12,2,.L22
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 12,2,.L21
	lwz 0,248(30)
	cmpwi 0,0,2
	bc 4,2,.L21
	lwz 3,256(31)
	bl Pull_Grapple
	mr 3,31
	bl Release_Grapple
	b .L15
.L21:
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,30,0
	bc 12,2,.L22
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L22
	lwz 9,260(30)
	addi 9,9,-2
	cmplwi 0,9,1
	bc 12,1,.L22
	stw 31,572(30)
	li 10,0
	lwz 9,256(31)
	lwz 11,84(9)
	stw 30,4024(11)
	lwz 0,264(31)
	stw 30,540(31)
	ori 0,0,1024
	stw 10,552(31)
	stw 0,264(31)
.L22:
	li 0,0
	li 10,0
	lwz 11,256(31)
	lis 8,.LC3@ha
	stw 0,388(31)
	lis 9,level+4@ha
	stw 0,384(31)
	la 8,.LC3@l(8)
	stw 0,380(31)
	stw 0,376(31)
	stw 0,396(31)
	stw 0,392(31)
	stw 10,248(31)
	stw 10,444(31)
	stw 10,260(31)
	lfs 0,level+4@l(9)
	lfs 13,0(8)
	li 8,1
	fadds 0,0,13
	stfs 0,596(31)
	lwz 9,84(11)
	stw 8,4028(9)
	lwz 11,256(31)
	stw 10,552(11)
	lwz 3,256(31)
	bl Pull_Grapple
.L15:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 Grapple_Touch,.Lfe1-Grapple_Touch
	.section	".rodata"
	.align 3
.LC4:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC5:
	.long 0x442f0000
	.section	".text"
	.align 2
	.globl Think_Grapple
	.type	 Think_Grapple,@function
Think_Grapple:
	stwu 1,-64(1)
	mflr 0
	stw 31,60(1)
	stw 0,68(1)
	mr 31,3
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,596(31)
	fcmpu 0,13,0
	bc 4,1,.L24
	lis 9,Release_Grapple@ha
	la 9,Release_Grapple@l(9)
	stw 9,432(31)
	b .L23
.L24:
	lwz 5,256(31)
	lwz 8,84(5)
	lwz 3,4024(8)
	cmpwi 0,3,0
	bc 12,2,.L26
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,3,0
	bc 12,2,.L33
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L33
	lwz 0,492(3)
	cmpwi 0,0,2
	bc 4,2,.L29
.L33:
	mr 3,31
	bl Release_Grapple
	b .L23
.L29:
	li 9,34
	li 0,0
	lis 8,vec3_origin@ha
	stw 9,12(1)
	mr 4,31
	stw 0,8(1)
	la 8,vec3_origin@l(8)
	addi 6,31,376
	addi 7,31,4
	li 9,3
	li 10,0
	bl T_Damage
	b .L30
.L26:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,48(1)
	lwz 11,52(1)
	andis. 0,11,4
	bc 12,2,.L30
	lfs 11,4032(8)
	addi 3,1,16
	lfs 0,4(31)
	lfs 13,8(31)
	lfs 12,12(31)
	fsubs 0,0,11
	stfs 0,16(1)
	lwz 9,84(5)
	lfs 0,4036(9)
	fsubs 13,13,0
	stfs 13,20(1)
	lwz 9,84(5)
	lfs 0,4040(9)
	fsubs 12,12,0
	stfs 12,24(1)
	bl VectorLength
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,1,.L30
	mr 3,31
	bl Release_Grapple
.L30:
	lfs 0,428(31)
	lis 9,.LC4@ha
	lfd 13,.LC4@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L23:
	lwz 0,68(1)
	mtlr 0
	lwz 31,60(1)
	la 1,64(1)
	blr
.Lfe2:
	.size	 Think_Grapple,.Lfe2-Think_Grapple
	.section	".rodata"
	.align 2
.LC8:
	.string	"hook"
	.align 2
.LC9:
	.string	"models/weapons/grapple/hook/tris.md2"
	.align 2
.LC10:
	.string	"models/objects/grenade2/tris.md2"
	.align 2
.LC6:
	.long 0x44098000
	.align 2
.LC7:
	.long 0x44ed8000
	.align 2
.LC11:
	.long 0xc0000000
	.align 3
.LC12:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC13:
	.long 0x0
	.align 2
.LC14:
	.long 0x40800000
	.section	".text"
	.align 2
	.globl Make_Hook
	.type	 Make_Hook,@function
Make_Hook:
	stwu 1,-112(1)
	mflr 0
	stmw 29,100(1)
	stw 0,116(1)
	mr 30,3
	addi 29,1,24
	bl G_Spawn
	mr 31,3
	addi 4,1,8
	lwz 3,84(30)
	mr 5,29
	li 6,0
	addi 3,3,3876
	bl AngleVectors
	lis 9,.LC11@ha
	lwz 4,84(30)
	addi 3,1,8
	la 9,.LC11@l(9)
	lfs 1,0(9)
	addi 4,4,3824
	bl VectorScale
	lwz 9,84(30)
	lis 0,0xbf80
	lis 10,0x4330
	addi 8,1,40
	stw 0,3812(9)
	mr 7,29
	addi 4,30,4
	lis 9,.LC12@ha
	lis 0,0x4100
	lwz 3,84(30)
	la 9,.LC12@l(9)
	addi 5,1,56
	lfd 13,0(9)
	addi 6,1,8
	lwz 9,508(30)
	stw 0,60(1)
	addi 9,9,-8
	stw 0,56(1)
	xoris 9,9,0x8000
	stw 9,92(1)
	stw 10,88(1)
	lfd 0,88(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	bl P_ProjectSource
	lfs 13,40(1)
	addi 3,1,8
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
	lfs 0,4(30)
	lis 9,sv_expflags@ha
	lwz 11,84(30)
	lwz 8,sv_expflags@l(9)
	stfs 0,4032(11)
	lfs 0,8(30)
	lwz 9,84(30)
	stfs 0,4036(9)
	lfs 13,12(30)
	lwz 11,84(30)
	stfs 13,4040(11)
	lfs 0,20(8)
	fctiwz 12,0
	stfd 12,88(1)
	lwz 10,92(1)
	andi. 0,10,4096
	bc 12,2,.L35
	lis 9,.LC6@ha
	addi 3,1,8
	lfs 1,.LC6@l(9)
	addi 4,31,376
	bl VectorScale
	b .L36
.L35:
	lis 9,.LC7@ha
	addi 3,1,8
	lfs 1,.LC7@l(9)
	addi 4,31,376
	bl VectorScale
.L36:
	lis 11,ctf@ha
	lis 9,.LC8@ha
	lwz 8,184(31)
	lwz 6,ctf@l(11)
	la 9,.LC8@l(9)
	lis 0,0x600
	lis 11,.LC13@ha
	stw 9,280(31)
	li 7,8
	la 11,.LC13@l(11)
	ori 8,8,2
	stw 7,68(31)
	lfs 13,0(11)
	ori 0,0,3
	li 9,2
	lis 11,0x43fa
	li 10,32
	stw 0,252(31)
	stw 11,396(31)
	stw 9,248(31)
	stw 8,184(31)
	stw 10,64(31)
	stfs 13,388(31)
	stfs 13,392(31)
	stw 7,260(31)
	stfs 13,196(31)
	stfs 13,192(31)
	stfs 13,188(31)
	stfs 13,208(31)
	stfs 13,204(31)
	stfs 13,200(31)
	lfs 0,20(6)
	fcmpu 0,0,13
	bc 12,2,.L37
	lis 9,gi+32@ha
	lis 3,.LC9@ha
	lwz 0,gi+32@l(9)
	la 3,.LC9@l(3)
	b .L39
.L37:
	lis 9,gi+32@ha
	lis 3,.LC10@ha
	lwz 0,gi+32@l(9)
	la 3,.LC10@l(3)
.L39:
	mtlr 0
	blrl
	stw 3,40(31)
	lis 9,Grapple_Touch@ha
	lis 11,level@ha
	stw 30,256(31)
	la 9,Grapple_Touch@l(9)
	la 11,level@l(11)
	stw 9,444(31)
	li 0,4
	lis 10,gi+72@ha
	lis 9,.LC14@ha
	lfs 0,4(11)
	mr 3,31
	la 9,.LC14@l(9)
	lfs 13,0(9)
	lis 9,Think_Grapple@ha
	la 9,Think_Grapple@l(9)
	fadds 0,0,13
	stfs 0,596(31)
	lfs 13,4(11)
	stw 9,436(31)
	stw 0,184(31)
	stfs 13,428(31)
	lwz 9,84(30)
	stw 31,4020(9)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe3:
	.size	 Make_Hook,.Lfe3-Make_Hook
	.section	".rodata"
	.align 2
.LC15:
	.string	"weapons/xpld_wat.wav"
	.align 2
.LC16:
	.string	"plats/pt1_mid.wav"
	.align 2
.LC17:
	.long 0x43fa0000
	.align 2
.LC18:
	.long 0x43480000
	.align 2
.LC19:
	.long 0x0
	.align 2
.LC20:
	.long 0x3f800000
	.align 2
.LC21:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl Throw_Grapple
	.type	 Throw_Grapple,@function
Throw_Grapple:
	stwu 1,-160(1)
	mflr 0
	stfd 31,152(1)
	stmw 28,136(1)
	stw 0,164(1)
	lis 10,sv_expflags@ha
	lwz 11,sv_expflags@l(10)
	mr 31,3
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,128(1)
	lwz 9,132(1)
	andi. 0,9,2048
	bc 12,2,.L41
	lwz 3,84(31)
	lis 9,level@ha
	lwz 11,level@l(9)
	lwz 0,4048(3)
	cmpw 0,0,11
	bc 12,1,.L40
	addi 28,1,24
	addi 4,1,8
	mr 6,28
	addi 3,3,3876
	li 5,0
	addi 29,31,376
	bl AngleVectors
	lis 9,.LC17@ha
	addi 4,1,8
	la 9,.LC17@l(9)
	mr 3,29
	lfs 1,0(9)
	mr 5,29
	bl VectorMA
	lis 9,.LC18@ha
	mr 3,29
	la 9,.LC18@l(9)
	mr 4,28
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	lis 9,.LC19@ha
	lfs 13,384(31)
	lis 8,gi@ha
	la 9,.LC19@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L45
	lis 10,sv_paused@ha
	lwz 11,sv_paused@l(10)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,128(1)
	lwz 9,132(1)
	cmpwi 0,9,1
	bc 12,2,.L45
	lis 9,.LC20@ha
	lfs 13,12(31)
	la 11,gi@l(8)
	la 9,.LC20@l(9)
	lwz 0,48(11)
	addi 4,1,40
	lfs 31,0(9)
	addi 3,1,56
	addi 5,31,188
	lis 9,0x201
	lfs 12,4(31)
	mtlr 0
	addi 6,31,200
	lfs 0,8(31)
	mr 7,4
	mr 8,31
	fadds 13,13,31
	ori 9,9,3
	stfs 12,40(1)
	stfs 0,44(1)
	stfs 13,48(1)
	blrl
	lwz 0,60(1)
	cmpwi 0,0,0
	bc 4,2,.L45
	lfs 0,12(31)
	fadds 0,0,31
	stfs 0,12(31)
.L45:
	lis 29,gi@ha
	lis 3,.LC15@ha
	la 29,gi@l(29)
	la 3,.LC15@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC20@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC20@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 2,0(9)
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfs 3,0(9)
	blrl
	lis 11,level@ha
	lwz 10,84(31)
	lwz 9,level@l(11)
	addi 9,9,9
	stw 9,4048(10)
	b .L40
.L41:
	lwz 9,84(31)
	lwz 28,4020(9)
	cmpwi 0,28,0
	bc 4,2,.L40
	lis 29,gi@ha
	lis 3,.LC16@ha
	la 29,gi@l(29)
	la 3,.LC16@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC21@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC21@l(9)
	mr 3,31
	lfs 1,0(9)
	li 4,3
	mtlr 0
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 2,0(9)
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,84(31)
	mr 3,31
	stw 28,4024(9)
	bl Make_Hook
.L40:
	lwz 0,164(1)
	mtlr 0
	lmw 28,136(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe4:
	.size	 Throw_Grapple,.Lfe4-Throw_Grapple
	.section	".rodata"
	.align 2
.LC22:
	.string	"misc/menu3.wav"
	.align 2
.LC23:
	.long 0x43d20000
	.align 2
.LC24:
	.long 0x0
	.align 2
.LC25:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Pull_Grapple
	.type	 Pull_Grapple,@function
Pull_Grapple:
	stwu 1,-144(1)
	mflr 0
	stfd 31,136(1)
	stw 31,132(1)
	stw 0,148(1)
	mr 31,3
	lwz 11,84(31)
	addi 3,1,8
	lfs 13,4(31)
	lwz 9,4020(11)
	lfs 12,8(31)
	lfs 0,4(9)
	lfs 11,12(31)
	fsubs 0,0,13
	stfs 0,8(1)
	lwz 9,4020(11)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lwz 9,4020(11)
	lfs 0,12(9)
	fsubs 0,0,11
	stfs 0,16(1)
	bl VectorNormalize
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,120(1)
	lwz 11,124(1)
	andi. 0,11,4096
	bc 12,2,.L51
	lis 9,.LC23@ha
	addi 3,1,8
	la 9,.LC23@l(9)
	addi 4,31,376
	lfs 1,0(9)
	bl VectorScale
	b .L52
.L51:
	lis 9,.LC23@ha
	addi 3,1,8
	la 9,.LC23@l(9)
	addi 4,31,376
	lfs 1,0(9)
	bl VectorScale
.L52:
	lis 9,.LC24@ha
	lfs 13,384(31)
	la 9,.LC24@l(9)
	lfs 11,8(1)
	lfs 0,0(9)
	lfs 12,12(1)
	fcmpu 0,13,0
	lfs 0,16(1)
	stfs 11,340(31)
	stfs 12,344(31)
	stfs 0,348(31)
	bc 4,1,.L55
	lis 10,sv_paused@ha
	lwz 9,sv_paused@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,120(1)
	lwz 11,124(1)
	cmpwi 0,11,1
	bc 12,2,.L55
	lis 9,.LC25@ha
	lfs 13,12(31)
	lis 11,gi+48@ha
	la 9,.LC25@l(9)
	lwz 0,gi+48@l(11)
	addi 4,1,24
	lfs 31,0(9)
	addi 3,1,40
	addi 5,31,188
	lis 9,0x201
	lfs 12,4(31)
	mtlr 0
	addi 6,31,200
	lfs 0,8(31)
	mr 7,4
	mr 8,31
	fadds 13,13,31
	ori 9,9,3
	stfs 12,24(1)
	stfs 0,28(1)
	stfs 13,32(1)
	blrl
	lwz 0,44(1)
	cmpwi 0,0,0
	bc 4,2,.L55
	lfs 0,12(31)
	fadds 0,0,31
	stfs 0,12(31)
.L55:
	lwz 0,148(1)
	mtlr 0
	lwz 31,132(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe5:
	.size	 Pull_Grapple,.Lfe5-Pull_Grapple
	.comm	gametype,4,4
	.comm	flags,4,4
	.comm	gCauseTable,4,4
	.align 2
	.globl Grapple_Is_Pulling
	.type	 Grapple_Is_Pulling,@function
Grapple_Is_Pulling:
	lwz 0,4020(3)
	cmpwi 0,0,0
	bc 12,2,.L13
	lwz 3,4028(3)
	blr
.L13:
	li 3,0
	blr
.Lfe6:
	.size	 Grapple_Is_Pulling,.Lfe6-Grapple_Is_Pulling
	.align 2
	.globl Ended_Grappling
	.type	 Ended_Grappling,@function
Ended_Grappling:
	lwz 0,3756(3)
	li 9,0
	andi. 11,0,2
	bc 4,2,.L10
	lwz 0,3760(3)
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
	lwz 0,4020(3)
	addic 9,0,-1
	subfe 3,9,0
	blr
.Lfe8:
	.size	 Is_Grappling,.Lfe8-Is_Grappling
	.section	".rodata"
	.align 2
.LC26:
	.long 0x3f800000
	.align 2
.LC27:
	.long 0x0
	.section	".text"
	.align 2
	.globl Release_Grapple
	.type	 Release_Grapple,@function
Release_Grapple:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 30,3
	li 28,0
	lwz 27,256(30)
	lwz 31,84(27)
	lwz 0,4020(31)
	stw 28,4028(31)
	cmpwi 0,0,0
	stw 28,4024(31)
	bc 12,2,.L48
	lis 29,gi@ha
	stw 28,4020(31)
	lis 3,.LC22@ha
	la 29,gi@l(29)
	la 3,.LC22@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC26@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC26@l(9)
	li 4,3
	lfs 1,0(9)
	mtlr 0
	mr 3,27
	lis 9,.LC26@ha
	la 9,.LC26@l(9)
	lfs 2,0(9)
	lis 9,.LC27@ha
	la 9,.LC27@l(9)
	lfs 3,0(9)
	blrl
	li 0,0
	stw 0,3904(31)
	stw 0,3912(31)
	stw 0,3908(31)
	lwz 9,540(30)
	stw 28,436(30)
	cmpwi 0,9,0
	bc 12,2,.L49
	stw 28,572(9)
.L49:
	mr 3,30
	bl G_FreeEdict
.L48:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 Release_Grapple,.Lfe9-Release_Grapple
	.section	".rodata"
	.align 2
.LC28:
	.long 0x0
	.align 2
.LC29:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl hackLift
	.type	 hackLift,@function
hackLift:
	stwu 1,-128(1)
	mflr 0
	stfd 31,120(1)
	stw 31,116(1)
	stw 0,132(1)
	lis 9,.LC28@ha
	mr 31,3
	la 9,.LC28@l(9)
	lfs 0,384(31)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L7
	lis 10,sv_paused@ha
	lwz 9,sv_paused@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,104(1)
	lwz 11,108(1)
	cmpwi 0,11,1
	bc 12,2,.L7
	lis 9,.LC29@ha
	lfs 13,12(31)
	lis 11,gi+48@ha
	la 9,.LC29@l(9)
	lwz 0,gi+48@l(11)
	addi 4,1,8
	lfs 31,0(9)
	addi 3,1,24
	addi 5,31,188
	lis 9,0x201
	lfs 12,4(31)
	mtlr 0
	addi 6,31,200
	lfs 0,8(31)
	mr 7,4
	mr 8,31
	fadds 13,13,31
	ori 9,9,3
	stfs 12,8(1)
	stfs 0,12(1)
	stfs 13,16(1)
	blrl
	lwz 0,28(1)
	cmpwi 0,0,0
	bc 4,2,.L7
	lfs 0,12(31)
	fadds 0,0,31
	stfs 0,12(31)
.L7:
	lwz 0,132(1)
	mtlr 0
	lwz 31,116(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe10:
	.size	 hackLift,.Lfe10-hackLift
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
