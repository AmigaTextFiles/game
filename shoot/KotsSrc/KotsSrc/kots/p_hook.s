	.file	"p_hook.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"medic/medatck3.wav"
	.align 2
.LC1:
	.long 0x41b00000
	.align 3
.LC2:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC3:
	.long 0x41200000
	.align 2
.LC4:
	.long 0xc1a00000
	.section	".text"
	.align 2
	.globl MaintainLinks
	.type	 MaintainLinks,@function
MaintainLinks:
	stwu 1,-208(1)
	mflr 0
	stfd 31,200(1)
	stmw 27,180(1)
	stw 0,212(1)
	mr 31,3
	addi 28,1,24
	addi 29,31,376
	mr 3,29
	bl VectorLength
	lis 9,.LC1@ha
	mr 3,29
	la 9,.LC1@l(9)
	mr 4,28
	lfs 0,0(9)
	fdivs 31,1,0
	bl VectorNormalize2
	addi 3,31,4
	addi 5,1,8
	mr 4,28
	fmr 1,31
	bl VectorMA
	lwz 9,256(31)
	addi 4,1,72
	addi 5,1,88
	li 6,0
	lwz 3,84(9)
	addi 3,3,3760
	bl AngleVectors
	lis 9,.LC2@ha
	lwz 10,256(31)
	lis 0,0x4100
	la 9,.LC2@l(9)
	stw 0,40(1)
	stw 0,44(1)
	lis 8,0x4330
	addi 7,1,136
	lfd 13,0(9)
	addi 3,10,4
	lwz 9,508(10)
	addi 9,9,-8
	xoris 9,9,0x8000
	stw 9,172(1)
	stw 8,168(1)
	lfd 0,168(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,48(1)
	lwz 9,84(10)
	stw 0,140(1)
	stfs 0,144(1)
	stw 0,136(1)
	lwz 0,716(9)
	cmpwi 0,0,0
	bc 4,2,.L12
	lis 0,0xc100
	stw 0,140(1)
	b .L13
.L12:
	cmpwi 0,0,2
	bc 4,2,.L13
	li 0,0
	stw 0,4(7)
.L13:
	addi 7,1,56
	addi 4,1,136
	mr 27,7
	addi 5,1,72
	addi 6,1,88
	bl G_ProjectSource
	addi 28,1,104
	addi 29,1,120
	addi 3,1,8
	mr 5,28
	mr 4,27
	bl _VectorSubtract
	mr 4,29
	mr 3,28
	bl VectorNormalize2
	lis 9,.LC3@ha
	mr 4,29
	la 9,.LC3@l(9)
	mr 3,27
	lfs 1,0(9)
	mr 5,27
	bl VectorMA
	lis 9,.LC4@ha
	addi 3,1,8
	la 9,.LC4@l(9)
	mr 4,29
	lfs 1,0(9)
	mr 5,3
	bl VectorMA
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,19
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xc10c
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,38677
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,4
	blrl
	lwz 9,120(29)
	addi 3,1,8
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
	lwz 0,212(1)
	mtlr 0
	lmw 27,180(1)
	lfd 31,200(1)
	la 1,208(1)
	blr
.Lfe1:
	.size	 MaintainLinks,.Lfe1-MaintainLinks
	.section	".rodata"
	.align 3
.LC5:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC6:
	.long 0x40000000
	.align 2
.LC7:
	.long 0x0
	.align 2
.LC8:
	.long 0x3f800000
	.align 2
.LC9:
	.long 0x447a0000
	.align 2
.LC10:
	.long 0x42200000
	.align 3
.LC11:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC12:
	.long 0x40a00000
	.align 2
.LC13:
	.long 0x41c80000
	.section	".text"
	.align 2
	.globl HookBehavior
	.type	 HookBehavior,@function
HookBehavior:
	stwu 1,-160(1)
	mflr 0
	stfd 30,144(1)
	stfd 31,152(1)
	stmw 28,128(1)
	stw 0,164(1)
	mr 31,3
	lwz 11,256(31)
	lwz 9,84(11)
	lwz 0,1832(9)
	andi. 9,0,1
	bc 12,2,.L18
	lwz 9,540(31)
	lwz 0,248(9)
	cmpwi 0,0,0
	bc 12,2,.L18
	lwz 0,492(11)
	cmpwi 0,0,0
	bc 4,2,.L18
	lwz 0,80(11)
	cmpwi 0,0,6
	bc 4,2,.L17
.L18:
	lwz 9,256(31)
	li 10,0
	lis 29,gi@ha
	la 29,gi@l(29)
	lis 3,.LC0@ha
	lwz 11,84(9)
	la 3,.LC0@l(3)
	lbz 0,16(11)
	andi. 0,0,191
	stb 0,16(11)
	lwz 9,256(31)
	lwz 11,84(9)
	stw 10,1832(11)
	lwz 9,36(29)
	lwz 28,256(31)
	mtlr 9
	blrl
	lis 9,.LC6@ha
	lwz 0,16(29)
	lis 11,.LC7@ha
	la 9,.LC6@l(9)
	la 11,.LC7@l(11)
	lfs 2,0(9)
	mr 5,3
	li 4,5
	mtlr 0
	lis 9,.LC8@ha
	mr 3,28
	lfs 3,0(11)
	la 9,.LC8@l(9)
	lfs 1,0(9)
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L16
.L17:
	lfs 0,376(9)
	stfs 0,376(31)
	lfs 13,380(9)
	stfs 13,380(31)
	lfs 0,384(9)
	stfs 0,384(31)
	lwz 9,84(11)
	lwz 0,1832(9)
	andi. 9,0,8
	bc 12,2,.L20
	lis 11,.LC9@ha
	lfs 13,292(31)
	la 11,.LC9@l(11)
	lfs 12,0(11)
	fcmpu 0,13,12
	bc 4,0,.L20
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	fcmpu 0,0,12
	stfs 0,292(31)
	bc 4,1,.L20
	stfs 12,292(31)
.L20:
	lwz 9,256(31)
	lwz 11,84(9)
	lwz 0,1832(11)
	andi. 11,0,4
	bc 12,2,.L22
	lis 9,.LC10@ha
	lfs 0,292(31)
	la 9,.LC10@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L22
	fsubs 0,0,13
	fcmpu 0,0,13
	stfs 0,292(31)
	bc 4,0,.L22
	stfs 13,292(31)
.L22:
	lwz 9,256(31)
	li 6,0
	addi 4,1,40
	addi 5,1,56
	lwz 3,84(9)
	addi 3,3,3760
	bl AngleVectors
	lis 9,.LC11@ha
	lwz 10,256(31)
	lis 0,0x4100
	la 9,.LC11@l(9)
	stw 0,8(1)
	stw 0,12(1)
	lis 7,0x4330
	addi 8,1,8
	lfd 13,0(9)
	addi 6,1,104
	addi 3,10,4
	lwz 9,508(10)
	addi 9,9,-8
	xoris 9,9,0x8000
	stw 9,124(1)
	stw 7,120(1)
	lfd 0,120(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,16(1)
	lwz 9,84(10)
	stw 0,104(1)
	lfs 13,4(8)
	stfs 13,108(1)
	lfs 0,8(8)
	stfs 0,112(1)
	lwz 0,716(9)
	cmpwi 0,0,0
	bc 4,2,.L24
	fneg 0,13
	stfs 0,108(1)
	b .L25
.L24:
	cmpwi 0,0,2
	bc 4,2,.L25
	li 0,0
	stw 0,4(6)
.L25:
	addi 29,1,72
	addi 4,1,104
	addi 5,1,40
	addi 6,1,56
	addi 7,1,24
	mr 28,29
	bl G_ProjectSource
	addi 3,31,4
	addi 4,1,24
	mr 5,29
	bl _VectorSubtract
	mr 3,29
	bl VectorLength
	fmr 30,1
	lfs 0,292(31)
	fcmpu 0,30,0
	bc 4,1,.L28
	lwz 3,256(31)
	addi 29,1,88
	mr 4,28
	addi 3,3,376
	bl _DotProduct
	fmr 31,1
	mr 3,28
	mr 4,28
	bl _DotProduct
	mr 3,28
	mr 4,29
	fdivs 1,31,1
	bl VectorScale
	lfs 0,292(31)
	lis 9,.LC12@ha
	mr 4,28
	la 9,.LC12@l(9)
	lwz 3,256(31)
	lfs 13,0(9)
	fsubs 0,30,0
	addi 3,3,376
	fmuls 31,0,13
	bl _DotProduct
	lis 9,.LC7@ha
	la 9,.LC7@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L29
	lis 11,.LC13@ha
	lfs 0,292(31)
	la 11,.LC13@l(11)
	lfs 13,0(11)
	fadds 0,0,13
	fcmpu 0,30,0
	bc 4,1,.L34
	lwz 3,256(31)
	mr 4,29
	addi 3,3,376
	mr 5,3
	bl _VectorSubtract
	b .L34
.L29:
	mr 3,29
	bl VectorLength
	fcmpu 0,1,31
	bc 4,0,.L32
	mr 3,29
	bl VectorLength
	fsubs 31,31,1
	b .L34
.L32:
	lis 9,.LC7@ha
	la 9,.LC7@l(9)
	lfs 31,0(9)
	b .L34
.L28:
	lis 11,.LC7@ha
	la 11,.LC7@l(11)
	lfs 31,0(11)
.L34:
	lwz 9,256(31)
	lwz 9,84(9)
	lbz 0,16(9)
	andi. 11,0,4
	bc 12,2,.L37
	andi. 0,0,191
	stb 0,16(9)
.L37:
	mr 3,28
	bl VectorNormalize
	lwz 3,256(31)
	fmr 1,31
	mr 4,28
	addi 3,3,376
	mr 5,3
	bl VectorMA
	mr 3,31
	bl MaintainLinks
	lis 9,level+4@ha
	lis 11,.LC5@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC5@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L16:
	lwz 0,164(1)
	mtlr 0
	lmw 28,128(1)
	lfd 30,144(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe2:
	.size	 HookBehavior,.Lfe2-HookBehavior
	.section	".rodata"
	.align 2
.LC14:
	.string	"chick/chkfall1.wav"
	.align 2
.LC15:
	.string	"makron/step2.wav"
	.align 2
.LC16:
	.string	"Hook touched a SOLID_TRIGGER\n"
	.align 3
.LC17:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC18:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC19:
	.long 0x3f800000
	.align 2
.LC20:
	.long 0x40000000
	.align 2
.LC21:
	.long 0x0
	.section	".text"
	.align 2
	.globl HookTouch
	.type	 HookTouch,@function
HookTouch:
	stwu 1,-160(1)
	mflr 0
	stmw 25,132(1)
	stw 0,164(1)
	mr 31,3
	mr 30,4
	lwz 9,256(31)
	mr 26,5
	mr 25,6
	li 6,0
	addi 4,1,48
	lwz 3,84(9)
	addi 5,1,64
	addi 3,3,3760
	bl AngleVectors
	lis 9,.LC18@ha
	lwz 10,256(31)
	lis 0,0x4100
	la 9,.LC18@l(9)
	stw 0,16(1)
	stw 0,20(1)
	lis 7,0x4330
	addi 8,1,16
	lfd 13,0(9)
	addi 6,1,96
	addi 3,10,4
	lwz 9,508(10)
	addi 9,9,-8
	xoris 9,9,0x8000
	stw 9,124(1)
	stw 7,120(1)
	lfd 0,120(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,24(1)
	lwz 9,84(10)
	stw 0,96(1)
	lfs 13,4(8)
	stfs 13,100(1)
	lfs 0,8(8)
	stfs 0,104(1)
	lwz 0,716(9)
	cmpwi 0,0,0
	bc 4,2,.L39
	fneg 0,13
	stfs 0,100(1)
	b .L40
.L39:
	cmpwi 0,0,2
	bc 4,2,.L40
	li 0,0
	stw 0,4(6)
.L40:
	addi 4,1,96
	addi 5,1,48
	addi 6,1,64
	addi 7,1,32
	bl G_ProjectSource
	addi 29,31,4
	addi 28,1,80
	mr 3,29
	addi 4,1,32
	mr 5,28
	bl _VectorSubtract
	mr 27,29
	mr 3,28
	bl VectorLength
	cmpwi 0,25,0
	stfs 1,292(31)
	bc 12,2,.L43
	lwz 0,16(25)
	andi. 9,0,4
	bc 4,2,.L47
.L43:
	lwz 0,512(30)
	cmpwi 0,0,0
	bc 12,2,.L45
	lwz 5,256(31)
	li 0,0
	li 11,32
	lwz 9,516(31)
	mr 3,30
	mr 4,31
	stw 0,8(1)
	addi 6,31,376
	mr 7,27
	stw 11,12(1)
	mr 8,26
	li 10,100
	bl T_Damage
.L45:
	lwz 0,248(30)
	cmpwi 0,0,2
	bc 4,2,.L46
	lwz 0,184(30)
	andi. 9,0,4
	bc 4,2,.L48
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L47
.L48:
	lis 29,gi@ha
	lis 3,.LC14@ha
	la 29,gi@l(29)
	la 3,.LC14@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC19@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC19@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 2,0(9)
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 3,0(9)
	blrl
.L47:
	lwz 9,256(31)
	li 10,0
	lis 29,gi@ha
	la 29,gi@l(29)
	lis 3,.LC0@ha
	lwz 11,84(9)
	la 3,.LC0@l(3)
	lbz 0,16(11)
	andi. 0,0,191
	stb 0,16(11)
	lwz 9,256(31)
	lwz 11,84(9)
	stw 10,1832(11)
	lwz 9,36(29)
	lwz 28,256(31)
	mtlr 9
	blrl
	lis 9,.LC19@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC19@l(9)
	mr 3,28
	lfs 1,0(9)
	li 4,5
	mtlr 0
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 2,0(9)
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 3,0(9)
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L38
.L46:
	cmpwi 0,0,3
	bc 4,2,.L50
	lis 9,gi@ha
	li 3,3
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,4
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	cmpwi 0,26,0
	bc 4,2,.L51
	lwz 0,124(29)
	lis 3,vec3_origin@ha
	la 3,vec3_origin@l(3)
	mtlr 0
	blrl
	b .L52
.L51:
	lwz 0,124(29)
	mr 3,26
	mtlr 0
	blrl
.L52:
	lis 29,gi@ha
	mr 3,27
	la 29,gi@l(29)
	li 4,2
	lwz 9,88(29)
	mtlr 9
	blrl
	lwz 9,36(29)
	lis 3,.LC15@ha
	la 3,.LC15@l(3)
	mtlr 9
	blrl
	lis 9,.LC19@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC19@l(9)
	li 4,2
	lfs 1,0(9)
	mtlr 0
	mr 3,31
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	lfs 2,0(9)
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 3,0(9)
	blrl
	li 0,0
	stw 0,388(31)
	stw 0,396(31)
	stw 0,392(31)
	b .L53
.L50:
	cmpwi 0,0,1
	bc 4,2,.L53
	lis 9,gi+8@ha
	lis 5,.LC16@ha
	lwz 3,256(31)
	lwz 0,gi+8@l(9)
	la 5,.LC16@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L53:
	lfs 0,376(30)
	lis 9,.LC17@ha
	lis 11,HookBehavior@ha
	lwz 10,256(31)
	li 7,0
	la 11,HookBehavior@l(11)
	lfd 12,.LC17@l(9)
	lis 8,level+4@ha
	stfs 0,376(31)
	lfs 13,380(30)
	stfs 13,380(31)
	lfs 0,384(30)
	stfs 0,384(31)
	lwz 9,84(10)
	lwz 0,1832(9)
	ori 0,0,2
	stw 0,1832(9)
	stw 30,540(31)
	stw 7,444(31)
	stw 11,436(31)
	lfs 0,level+4@l(8)
	fadd 0,0,12
	frsp 0,0
	stfs 0,428(31)
.L38:
	lwz 0,164(1)
	mtlr 0
	lmw 25,132(1)
	la 1,160(1)
	blr
.Lfe3:
	.size	 HookTouch,.Lfe3-HookTouch
	.section	".rodata"
	.align 2
.LC23:
	.string	"models/monsters/parasite/tip/tris.md2"
	.align 2
.LC24:
	.string	"medic/medatck2.wav"
	.align 3
.LC25:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC26:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC27:
	.long 0x447a0000
	.align 2
.LC28:
	.long 0x40000000
	.align 2
.LC29:
	.long 0x0
	.align 2
.LC30:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl FireHook
	.type	 FireHook,@function
FireHook:
	stwu 1,-128(1)
	mflr 0
	stfd 31,120(1)
	stmw 28,104(1)
	stw 0,132(1)
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 29,0x4330
	mr 31,3
	lis 9,.LC26@ha
	lwz 3,84(31)
	li 30,10
	xoris 0,0,0x8000
	la 9,.LC26@l(9)
	stw 0,100(1)
	stw 29,96(1)
	lfd 31,0(9)
	lfd 0,96(1)
	lfs 13,3832(3)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L59
	li 30,40
.L59:
	addi 4,1,40
	addi 3,3,3760
	mr 28,4
	addi 5,1,56
	li 6,0
	bl AngleVectors
	lwz 9,508(31)
	lis 0,0x4100
	lwz 8,84(31)
	addi 10,1,8
	addi 7,1,72
	addi 9,9,-8
	stw 0,72(1)
	addi 3,31,4
	xoris 9,9,0x8000
	stw 0,8(1)
	stw 9,100(1)
	stw 29,96(1)
	lfd 0,96(1)
	stw 0,12(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,16(1)
	lfs 13,4(10)
	stfs 13,76(1)
	lfs 0,8(10)
	stfs 0,80(1)
	lwz 0,716(8)
	cmpwi 0,0,0
	bc 4,2,.L60
	fneg 0,13
	stfs 0,76(1)
	b .L61
.L60:
	cmpwi 0,0,2
	bc 4,2,.L61
	li 0,0
	stw 0,4(7)
.L61:
	addi 5,1,40
	addi 4,1,72
	addi 6,1,56
	addi 7,1,24
	bl G_ProjectSource
	bl G_Spawn
	lfs 13,24(1)
	mr 29,3
	mr 3,28
	addi 4,29,16
	stfs 13,4(29)
	lfs 0,28(1)
	stfs 0,8(29)
	lfs 13,32(1)
	stfs 13,12(29)
	lfs 0,40(1)
	stfs 0,340(29)
	lfs 13,44(1)
	stfs 13,344(29)
	lfs 0,48(1)
	stfs 0,348(29)
	bl vectoangles
	lis 9,.LC27@ha
	mr 3,28
	la 9,.LC27@l(9)
	addi 4,29,376
	lfs 1,0(9)
	bl VectorScale
	lis 9,0x600
	li 0,0
	li 10,8
	lis 11,0xc448
	stw 0,200(29)
	li 8,2
	ori 9,9,3
	stw 10,260(29)
	lis 28,gi@ha
	stw 11,396(29)
	lis 3,.LC23@ha
	la 28,gi@l(28)
	stw 8,248(29)
	la 3,.LC23@l(3)
	stw 0,388(29)
	stw 0,392(29)
	stw 0,196(29)
	stw 0,192(29)
	stw 0,188(29)
	stw 0,208(29)
	stw 0,204(29)
	stw 9,252(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	li 0,0
	stw 3,40(29)
	stw 0,528(29)
	lis 3,.LC24@ha
	stw 30,516(29)
	la 3,.LC24@l(3)
	stw 31,256(29)
	lwz 9,36(28)
	mtlr 9
	blrl
	lis 9,.LC28@ha
	lwz 11,16(28)
	mr 5,3
	la 9,.LC28@l(9)
	mr 3,31
	lfs 2,0(9)
	mtlr 11
	li 4,5
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	lfs 3,0(9)
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfs 1,0(9)
	blrl
	lis 9,HookTouch@ha
	lis 11,HookAirborne@ha
	la 9,HookTouch@l(9)
	la 11,HookAirborne@l(11)
	stw 9,444(29)
	lis 10,level+4@ha
	mr 3,29
	stw 11,436(29)
	lis 9,.LC25@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC25@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,132(1)
	mtlr 0
	lmw 28,104(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe4:
	.size	 FireHook,.Lfe4-FireHook
	.align 2
	.globl P_ProjectSource_Reverse
	.type	 P_ProjectSource_Reverse,@function
P_ProjectSource_Reverse:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	lfs 12,4(5)
	mr 9,7
	lfs 13,8(5)
	mr 7,8
	lfs 0,0(5)
	stfs 12,12(1)
	stfs 13,16(1)
	stfs 0,8(1)
	lwz 0,716(3)
	cmpwi 0,0,0
	bc 4,2,.L7
	fneg 0,12
	stfs 0,12(1)
	b .L8
.L7:
	cmpwi 0,0,2
	bc 4,2,.L8
	li 0,0
	stw 0,12(1)
.L8:
	mr 3,4
	mr 5,6
	mr 6,9
	addi 4,1,8
	bl G_ProjectSource
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe5:
	.size	 P_ProjectSource_Reverse,.Lfe5-P_ProjectSource_Reverse
	.section	".rodata"
	.align 2
.LC31:
	.long 0x3f800000
	.align 2
.LC32:
	.long 0x40000000
	.align 2
.LC33:
	.long 0x0
	.section	".text"
	.align 2
	.globl DropHook
	.type	 DropHook,@function
DropHook:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 28,3
	li 10,0
	lwz 9,256(28)
	lis 29,gi@ha
	lis 3,.LC0@ha
	la 29,gi@l(29)
	la 3,.LC0@l(3)
	lwz 11,84(9)
	lbz 0,16(11)
	andi. 0,0,191
	stb 0,16(11)
	lwz 9,256(28)
	lwz 11,84(9)
	stw 10,1832(11)
	lwz 9,36(29)
	lwz 27,256(28)
	mtlr 9
	blrl
	lis 9,.LC31@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC31@l(9)
	mr 3,27
	lfs 1,0(9)
	li 4,5
	mtlr 0
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 2,0(9)
	lis 9,.LC33@ha
	la 9,.LC33@l(9)
	lfs 3,0(9)
	blrl
	mr 3,28
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 DropHook,.Lfe6-DropHook
	.section	".rodata"
	.align 3
.LC34:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC35:
	.long 0x447a0000
	.align 2
.LC36:
	.long 0x40000000
	.align 2
.LC37:
	.long 0x0
	.align 2
.LC38:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl HookAirborne
	.type	 HookAirborne,@function
HookAirborne:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	addi 5,1,8
	lwz 4,256(31)
	addi 3,31,4
	addi 4,4,4
	bl _VectorSubtract
	addi 3,1,8
	bl VectorLength
	lis 10,.LC35@ha
	lwz 9,256(31)
	la 10,.LC35@l(10)
	lfs 0,0(10)
	lwz 11,84(9)
	fcmpu 7,1,0
	lwz 0,1832(11)
	xori 0,0,1
	rlwinm 0,0,0,31,31
	mfcr 9
	rlwinm 9,9,30,1
	or. 10,0,9
	bc 12,2,.L56
	lbz 0,16(11)
	li 10,0
	lis 29,gi@ha
	la 29,gi@l(29)
	lis 3,.LC0@ha
	andi. 0,0,191
	la 3,.LC0@l(3)
	stb 0,16(11)
	lwz 9,256(31)
	lwz 11,84(9)
	stw 10,1832(11)
	lwz 9,36(29)
	lwz 28,256(31)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC36@ha
	lis 10,.LC37@ha
	lis 11,.LC38@ha
	la 9,.LC36@l(9)
	la 10,.LC37@l(10)
	mr 5,3
	lfs 2,0(9)
	mtlr 0
	la 11,.LC38@l(11)
	mr 3,28
	lfs 3,0(10)
	li 4,5
	lfs 1,0(11)
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L55
.L56:
	mr 3,31
	bl MaintainLinks
	lis 9,level+4@ha
	lis 11,.LC34@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC34@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L55:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 HookAirborne,.Lfe7-HookAirborne
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
