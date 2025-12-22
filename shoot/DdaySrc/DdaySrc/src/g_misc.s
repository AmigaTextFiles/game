	.file	"g_misc.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC5:
	.string	"misc/fhit3.wav"
	.align 2
.LC7:
	.long 0x46fffe00
	.align 2
.LC8:
	.long 0x3f333333
	.align 2
.LC9:
	.long 0x3f99999a
	.align 3
.LC10:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC11:
	.long 0x3f000000
	.align 3
.LC12:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC13:
	.long 0x42000000
	.align 3
.LC14:
	.long 0x40590000
	.long 0x0
	.align 3
.LC15:
	.long 0x40690000
	.long 0x0
	.align 2
.LC16:
	.long 0xc3960000
	.align 2
.LC17:
	.long 0x43960000
	.align 2
.LC18:
	.long 0x43480000
	.align 2
.LC19:
	.long 0x43fa0000
	.align 2
.LC20:
	.long 0x44160000
	.align 2
.LC21:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl ThrowGib
	.type	 ThrowGib,@function
ThrowGib:
	stwu 1,-160(1)
	mflr 0
	stfd 28,128(1)
	stfd 29,136(1)
	stfd 30,144(1)
	stfd 31,152(1)
	stmw 25,100(1)
	stw 0,164(1)
	mr 26,6
	mr 25,5
	mr 30,3
	mr 27,4
	bl G_Spawn
	lis 29,0x4330
	li 28,0
	lis 10,.LC11@ha
	lis 9,.LC10@ha
	la 10,.LC11@l(10)
	mr 31,3
	lfs 1,0(10)
	la 9,.LC10@l(9)
	addi 4,1,40
	lfd 30,0(9)
	addi 3,30,236
	bl VectorScale
	lfs 11,40(1)
	lis 9,.LC12@ha
	lfs 13,212(30)
	la 9,.LC12@l(9)
	lfs 10,44(1)
	lfs 12,216(30)
	fadds 13,13,11
	lfs 0,220(30)
	lfs 11,48(1)
	fadds 12,12,10
	lfd 31,0(9)
	stfs 13,24(1)
	fadds 0,0,11
	stfs 12,28(1)
	stfs 0,32(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,24(1)
	xoris 3,3,0x8000
	lis 11,.LC7@ha
	lfs 12,40(1)
	stw 3,92(1)
	stw 29,88(1)
	lfd 13,88(1)
	lfs 29,.LC7@l(11)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,4(31)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,28(1)
	xoris 3,3,0x8000
	lfs 12,44(1)
	stw 3,92(1)
	stw 29,88(1)
	lfd 13,88(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,8(31)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,32(1)
	xoris 3,3,0x8000
	lfs 12,48(1)
	lis 10,.LC13@ha
	stw 3,92(1)
	la 10,.LC13@l(10)
	lis 11,gi+44@ha
	stw 29,88(1)
	mr 4,27
	mr 3,31
	lfd 13,88(1)
	lfs 10,0(10)
	stw 28,56(31)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	fadds 0,0,10
	stfs 0,12(31)
	lwz 0,gi+44@l(11)
	mtlr 0
	blrl
	lwz 9,64(31)
	lis 11,gib_die@ha
	cmpwi 0,26,0
	lwz 0,268(31)
	la 11,gib_die@l(11)
	li 10,1
	ori 9,9,2
	stw 28,248(31)
	ori 0,0,2048
	stw 9,64(31)
	stw 0,268(31)
	stw 10,516(31)
	stw 11,460(31)
	bc 4,2,.L29
	lis 9,gib_touch@ha
	li 0,7
	la 9,gib_touch@l(9)
	stw 0,264(31)
	lis 27,0x3f00
	stw 9,448(31)
	b .L30
.L29:
	li 0,9
	lis 27,0x3f80
	stw 0,264(31)
.L30:
	bl rand
	lis 29,0x4330
	lis 9,.LC10@ha
	rlwinm 3,3,0,17,31
	la 9,.LC10@l(9)
	xoris 3,3,0x8000
	lfd 30,0(9)
	lis 11,.LC7@ha
	lis 10,.LC12@ha
	lfs 28,.LC7@l(11)
	la 10,.LC12@l(10)
	stw 3,92(1)
	addi 28,1,8
	stw 29,88(1)
	lfd 13,88(1)
	lfd 29,0(10)
	lis 10,.LC14@ha
	fsub 13,13,30
	la 10,.LC14@l(10)
	lfd 31,0(10)
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,29
	fadd 0,0,0
	fmul 0,0,31
	frsp 0,0
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,92(1)
	stw 29,88(1)
	lfd 13,88(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,29
	fadd 0,0,0
	fmul 0,0,31
	frsp 0,0
	stfs 0,4(28)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC15@ha
	stw 3,92(1)
	la 10,.LC15@l(10)
	cmpwi 0,25,49
	stw 29,88(1)
	lfd 0,88(1)
	lfd 12,0(10)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,28
	fmr 13,0
	fmadd 13,13,31,12
	frsp 13,13
	stfs 13,8(28)
	bc 12,1,.L31
	lis 9,.LC8@ha
	mr 3,28
	lfs 1,.LC8@l(9)
	mr 4,3
	bl VectorScale
	b .L33
.L31:
	lis 9,.LC9@ha
	mr 3,28
	lfs 1,.LC9@l(9)
	mr 4,3
	bl VectorScale
.L33:
	stw 27,56(1)
	addi 3,30,380
	addi 4,1,8
	lfs 0,56(1)
	addi 5,31,380
	fmr 1,0
	bl VectorMA
	lis 9,.LC16@ha
	lfs 0,380(31)
	la 9,.LC16@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L44
	lis 10,.LC17@ha
	la 10,.LC17@l(10)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 4,1,.L35
.L44:
	stfs 13,380(31)
.L35:
	lis 11,.LC16@ha
	lfs 0,384(31)
	la 11,.LC16@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,0,.L45
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L38
.L45:
	stfs 13,384(31)
.L38:
	lis 10,.LC18@ha
	lfs 0,388(31)
	la 10,.LC18@l(10)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,0,.L46
	lis 11,.LC19@ha
	la 11,.LC19@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L43
.L46:
	stfs 13,388(31)
.L43:
	bl rand
	lis 29,0x4330
	lis 9,.LC10@ha
	rlwinm 3,3,0,17,31
	la 9,.LC10@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC7@ha
	lis 10,.LC20@ha
	lfs 29,.LC7@l(11)
	la 10,.LC20@l(10)
	stw 3,92(1)
	stw 29,88(1)
	lfd 0,88(1)
	lfs 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmuls 0,0,30
	stfs 0,392(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,92(1)
	stw 29,88(1)
	lfd 0,88(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmuls 0,0,30
	stfs 0,396(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 9,G_FreeEdict@ha
	stw 3,92(1)
	la 9,G_FreeEdict@l(9)
	stw 29,88(1)
	lfd 0,88(1)
	stw 9,440(31)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmuls 0,0,30
	stfs 0,400(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC21@ha
	stw 3,92(1)
	la 10,.LC21@l(10)
	lis 11,level+4@ha
	stw 29,88(1)
	mr 3,31
	lfd 0,88(1)
	lfs 12,0(10)
	lfs 13,level+4@l(11)
	lis 10,gi+72@ha
	fsub 0,0,31
	fadds 13,13,12
	frsp 0,0
	fdivs 0,0,29
	fmadds 0,0,12,13
	stfs 0,432(31)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	lwz 0,164(1)
	mtlr 0
	lmw 25,100(1)
	lfd 28,128(1)
	lfd 29,136(1)
	lfd 30,144(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe1:
	.size	 ThrowGib,.Lfe1-ThrowGib
	.section	".rodata"
	.align 2
.LC22:
	.long 0x46fffe00
	.align 2
.LC23:
	.long 0x3f333333
	.align 2
.LC24:
	.long 0x3f99999a
	.align 3
.LC25:
	.long 0x4082c000
	.long 0x0
	.align 3
.LC26:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC27:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC28:
	.long 0x40590000
	.long 0x0
	.align 3
.LC29:
	.long 0x40690000
	.long 0x0
	.align 2
.LC30:
	.long 0xc3960000
	.align 2
.LC31:
	.long 0x43960000
	.align 2
.LC32:
	.long 0x43480000
	.align 2
.LC33:
	.long 0x43fa0000
	.align 2
.LC34:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl ThrowHead
	.type	 ThrowHead,@function
ThrowHead:
	stwu 1,-112(1)
	mflr 0
	stfd 28,80(1)
	stfd 29,88(1)
	stfd 30,96(1)
	stfd 31,104(1)
	stmw 27,60(1)
	stw 0,116(1)
	mr 31,3
	li 0,0
	li 29,0
	lis 9,gi+44@ha
	stw 0,200(31)
	stw 29,60(31)
	mr 28,6
	stw 29,56(31)
	mr 30,5
	stw 0,196(31)
	stw 0,192(31)
	stw 0,188(31)
	stw 0,208(31)
	stw 0,204(31)
	stw 29,44(31)
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	lwz 0,64(31)
	lis 10,gib_die@ha
	cmpwi 0,28,0
	lwz 11,268(31)
	la 10,gib_die@l(10)
	li 8,1
	lwz 9,184(31)
	ori 0,0,2
	ori 11,11,2048
	rlwinm 0,0,0,18,16
	stw 29,76(31)
	rlwinm 9,9,0,30,28
	stw 0,64(31)
	stw 11,268(31)
	stw 9,184(31)
	stw 8,516(31)
	stw 10,460(31)
	stw 29,248(31)
	bc 4,2,.L48
	lis 9,gib_touch@ha
	li 0,7
	la 9,gib_touch@l(9)
	stw 0,264(31)
	lis 27,0x3f00
	stw 9,448(31)
	b .L49
.L48:
	li 0,9
	lis 27,0x3f80
	stw 0,264(31)
.L49:
	bl rand
	lis 29,0x4330
	lis 9,.LC26@ha
	rlwinm 3,3,0,17,31
	la 9,.LC26@l(9)
	xoris 3,3,0x8000
	lfd 30,0(9)
	lis 11,.LC22@ha
	lis 10,.LC27@ha
	lfs 28,.LC22@l(11)
	la 10,.LC27@l(10)
	stw 3,52(1)
	addi 28,1,8
	stw 29,48(1)
	lfd 13,48(1)
	lfd 29,0(10)
	lis 10,.LC28@ha
	fsub 13,13,30
	la 10,.LC28@l(10)
	lfd 31,0(10)
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,29
	fadd 0,0,0
	fmul 0,0,31
	frsp 0,0
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,52(1)
	stw 29,48(1)
	lfd 13,48(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,29
	fadd 0,0,0
	fmul 0,0,31
	frsp 0,0
	stfs 0,4(28)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC29@ha
	stw 3,52(1)
	la 10,.LC29@l(10)
	cmpwi 0,30,49
	stw 29,48(1)
	lfd 0,48(1)
	lfd 12,0(10)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,28
	fmr 13,0
	fmadd 13,13,31,12
	frsp 13,13
	stfs 13,8(28)
	bc 12,1,.L50
	lis 9,.LC23@ha
	mr 3,28
	lfs 1,.LC23@l(9)
	mr 4,3
	bl VectorScale
	b .L52
.L50:
	lis 9,.LC24@ha
	mr 3,28
	lfs 1,.LC24@l(9)
	mr 4,3
	bl VectorScale
.L52:
	stw 27,24(1)
	addi 3,31,380
	addi 4,1,8
	lfs 0,24(1)
	mr 5,3
	fmr 1,0
	bl VectorMA
	lis 9,.LC30@ha
	lfs 0,380(31)
	la 9,.LC30@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L63
	lis 10,.LC31@ha
	la 10,.LC31@l(10)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 4,1,.L54
.L63:
	stfs 13,380(31)
.L54:
	lis 11,.LC30@ha
	lfs 0,384(31)
	la 11,.LC30@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,0,.L64
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L57
.L64:
	stfs 13,384(31)
.L57:
	lis 10,.LC32@ha
	lfs 0,388(31)
	la 10,.LC32@l(10)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,0,.L65
	lis 11,.LC33@ha
	la 11,.LC33@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L62
.L65:
	stfs 13,388(31)
.L62:
	bl rand
	lis 29,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 9,.LC26@ha
	stw 3,52(1)
	la 9,.LC26@l(9)
	lis 8,.LC22@ha
	stw 29,48(1)
	lis 10,.LC27@ha
	lfd 31,0(9)
	la 10,.LC27@l(10)
	lfd 13,48(1)
	lis 9,G_FreeEdict@ha
	lfs 30,.LC22@l(8)
	la 9,G_FreeEdict@l(9)
	lfd 11,0(10)
	fsub 13,13,31
	lis 10,.LC25@ha
	stw 9,440(31)
	lfd 12,.LC25@l(10)
	frsp 13,13
	fdivs 13,13,30
	fmr 0,13
	fsub 0,0,11
	fadd 0,0,0
	fmul 0,0,12
	frsp 0,0
	stfs 0,396(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC34@ha
	stw 3,52(1)
	la 10,.LC34@l(10)
	lis 11,level+4@ha
	stw 29,48(1)
	mr 3,31
	lfd 0,48(1)
	lfs 12,0(10)
	lfs 13,level+4@l(11)
	lis 10,gi+72@ha
	fsub 0,0,31
	fadds 13,13,12
	frsp 0,0
	fdivs 0,0,30
	fmadds 0,0,12,13
	stfs 0,432(31)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	lwz 0,116(1)
	mtlr 0
	lmw 27,60(1)
	lfd 28,80(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe2:
	.size	 ThrowHead,.Lfe2-ThrowHead
	.section	".rodata"
	.align 2
.LC35:
	.string	"models/objects/gibs/skull/tris.md2"
	.align 2
.LC36:
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC37:
	.long 0x46fffe00
	.align 2
.LC38:
	.long 0x3f333333
	.align 2
.LC39:
	.long 0x3f99999a
	.align 2
.LC40:
	.long 0x42000000
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
	.long 0x40590000
	.long 0x0
	.align 3
.LC44:
	.long 0x40690000
	.long 0x0
	.align 2
.LC45:
	.long 0x42340000
	.section	".text"
	.align 2
	.globl ThrowClientHead
	.type	 ThrowClientHead,@function
ThrowClientHead:
	stwu 1,-96(1)
	mflr 0
	stfd 28,64(1)
	stfd 29,72(1)
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 27,44(1)
	stw 0,100(1)
	mr 31,3
	mr 27,4
	bl rand
	andi. 3,3,1
	bc 12,2,.L67
	lis 9,.LC35@ha
	li 0,1
	la 4,.LC35@l(9)
	stw 0,60(31)
	b .L68
.L67:
	lis 9,.LC36@ha
	stw 3,60(31)
	la 4,.LC36@l(9)
.L68:
	lis 9,.LC40@ha
	lfs 0,12(31)
	li 29,0
	la 9,.LC40@l(9)
	stw 29,56(31)
	lis 10,.LC41@ha
	lfs 13,0(9)
	la 10,.LC41@l(10)
	mr 3,31
	lis 9,gi+44@ha
	lfd 31,0(10)
	lis 11,.LC42@ha
	lis 10,.LC43@ha
	la 11,.LC42@l(11)
	fadds 0,0,13
	la 10,.LC43@l(10)
	addi 30,1,8
	lfd 28,0(11)
	lfd 30,0(10)
	lis 28,0x4330
	stfs 0,12(31)
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	lwz 0,268(31)
	lis 9,0x4180
	lis 7,0xc180
	li 10,2
	li 8,9
	stw 7,192(31)
	ori 0,0,2048
	li 11,0
	stw 10,64(31)
	stw 0,268(31)
	stw 8,264(31)
	stw 7,188(31)
	stw 11,196(31)
	stw 9,208(31)
	stw 9,200(31)
	stw 9,204(31)
	stw 29,76(31)
	stw 29,516(31)
	stw 29,248(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC37@ha
	stw 3,36(1)
	stw 28,32(1)
	lfd 13,32(1)
	lfs 29,.LC37@l(11)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,28
	fadd 0,0,0
	fmul 0,0,30
	frsp 0,0
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,36(1)
	stw 28,32(1)
	lfd 13,32(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,28
	fadd 0,0,0
	fmul 0,0,30
	frsp 0,0
	stfs 0,4(30)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC44@ha
	stw 3,36(1)
	la 10,.LC44@l(10)
	cmpwi 0,27,49
	stw 28,32(1)
	lfd 0,32(1)
	lfd 12,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fmadd 13,13,30,12
	frsp 13,13
	stfs 13,8(30)
	bc 12,1,.L69
	lis 9,.LC38@ha
	mr 3,30
	lfs 1,.LC38@l(9)
	mr 4,3
	bl VectorScale
	b .L71
.L69:
	lis 9,.LC39@ha
	mr 3,30
	lfs 1,.LC39@l(9)
	mr 4,3
	bl VectorScale
.L71:
	lfs 11,8(1)
	lfs 10,12(1)
	lfs 9,16(1)
	lfs 0,380(31)
	lfs 13,384(31)
	lfs 12,388(31)
	lwz 9,84(31)
	fadds 0,0,11
	fadds 13,13,10
	fadds 12,12,9
	cmpwi 0,9,0
	stfs 0,380(31)
	stfs 13,384(31)
	stfs 12,388(31)
	bc 12,2,.L72
	li 0,5
	stw 0,4328(9)
	lwz 9,84(31)
	lwz 0,56(31)
	stw 0,4324(9)
	b .L73
.L72:
	lis 9,G_FreeEdict@ha
	lis 10,.LC45@ha
	la 9,G_FreeEdict@l(9)
	lis 11,level+4@ha
	la 10,.LC45@l(10)
	stw 9,440(31)
	lfs 0,level+4@l(11)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,432(31)
.L73:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,100(1)
	mtlr 0
	lmw 27,44(1)
	lfd 28,64(1)
	lfd 29,72(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe3:
	.size	 ThrowClientHead,.Lfe3-ThrowClientHead
	.section	".rodata"
	.align 2
.LC47:
	.string	"debris"
	.align 2
.LC46:
	.long 0x46fffe00
	.align 3
.LC48:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC49:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC50:
	.long 0x40590000
	.long 0x0
	.align 2
.LC51:
	.long 0x44160000
	.align 2
.LC52:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl ThrowDebris
	.type	 ThrowDebris,@function
ThrowDebris:
	stwu 1,-112(1)
	mflr 0
	stfd 26,64(1)
	stfd 27,72(1)
	stfd 28,80(1)
	stfd 29,88(1)
	stfd 30,96(1)
	stfd 31,104(1)
	stmw 24,32(1)
	stw 0,116(1)
	mr 28,5
	fmr 26,1
	mr 27,4
	mr 24,3
	lis 26,0x4330
	bl G_Spawn
	lfs 0,0(28)
	mr 29,3
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lis 25,gi@ha
	lfd 31,0(9)
	la 25,gi@l(25)
	lis 11,.LC49@ha
	stfs 0,4(29)
	lis 9,.LC50@ha
	la 11,.LC49@l(11)
	lfs 13,4(28)
	la 9,.LC50@l(9)
	mr 4,27
	lfd 30,0(9)
	li 27,0
	lfd 29,0(11)
	stfs 13,8(29)
	lis 11,.LC51@ha
	lfs 0,8(28)
	la 11,.LC51@l(11)
	lfs 27,0(11)
	stfs 0,12(29)
	lwz 9,44(25)
	mtlr 9
	blrl
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC46@ha
	stw 3,28(1)
	stw 26,24(1)
	lfd 13,24(1)
	lfs 28,.LC46@l(11)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,29
	fadd 0,0,0
	fmul 0,0,30
	frsp 0,0
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 26,24(1)
	lfd 13,24(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,29
	fadd 0,0,0
	fmul 0,0,30
	frsp 0,0
	stfs 0,12(1)
	bl rand
	rlwinm 3,3,0,17,31
	fmr 1,26
	xoris 3,3,0x8000
	addi 5,29,380
	stw 3,28(1)
	addi 4,1,8
	stw 26,24(1)
	addi 3,24,380
	lfd 13,24(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,29
	fadd 0,0,0
	fmadd 0,0,30,30
	frsp 0,0
	stfs 0,16(1)
	bl VectorMA
	li 0,9
	stw 27,248(29)
	stw 0,264(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 26,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,28
	fmuls 0,0,27
	stfs 0,392(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 26,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,28
	fmuls 0,0,27
	stfs 0,396(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 9,G_FreeEdict@ha
	stw 3,28(1)
	la 9,G_FreeEdict@l(9)
	stw 26,24(1)
	lfd 0,24(1)
	stw 9,440(29)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,28
	fmuls 0,0,27
	stfs 0,400(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC52@ha
	stw 3,28(1)
	la 11,.LC52@l(11)
	lis 8,level+4@ha
	stw 26,24(1)
	lis 10,debris_die@ha
	li 0,1
	lfd 0,24(1)
	la 10,debris_die@l(10)
	mr 3,29
	lfs 13,level+4@l(8)
	lfs 12,0(11)
	fsub 0,0,31
	lis 11,.LC47@ha
	stw 27,268(29)
	la 11,.LC47@l(11)
	stw 0,516(29)
	fadds 13,13,12
	stw 11,284(29)
	frsp 0,0
	stw 10,460(29)
	stw 27,56(29)
	fdivs 0,0,28
	fmadds 0,0,12,13
	stfs 0,432(29)
	lwz 0,72(25)
	mtlr 0
	blrl
	lwz 0,116(1)
	mtlr 0
	lmw 24,32(1)
	lfd 26,64(1)
	lfd 27,72(1)
	lfd 28,80(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe4:
	.size	 ThrowDebris,.Lfe4-ThrowDebris
	.section	".rodata"
	.align 2
.LC53:
	.long 0x4cbebc20
	.align 2
.LC54:
	.long 0x0
	.section	".text"
	.align 2
	.globl path_corner_touch
	.type	 path_corner_touch,@function
path_corner_touch:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,4
	mr 30,3
	lwz 0,420(31)
	cmpw 0,0,30
	bc 4,2,.L78
	lwz 0,548(31)
	cmpwi 0,0,0
	bc 4,2,.L78
	lwz 0,316(30)
	cmpwi 0,0,0
	bc 12,2,.L81
	lwz 29,300(30)
	stw 0,300(30)
	bl G_UseTargets
	stw 29,300(30)
.L81:
	lwz 3,300(30)
	cmpwi 0,3,0
	bc 12,2,.L82
	bl G_PickTarget
	mr 9,3
	b .L83
.L82:
	li 9,0
.L83:
	cmpwi 0,9,0
	bc 12,2,.L84
	lwz 0,288(9)
	andi. 11,0,1
	bc 12,2,.L84
	lfs 11,4(9)
	lfs 10,196(31)
	stfs 11,8(1)
	lfs 12,8(9)
	stfs 12,12(1)
	lfs 0,12(9)
	stfs 0,16(1)
	lfs 13,196(9)
	stfs 11,4(31)
	stfs 12,8(31)
	fadds 0,0,13
	fsubs 0,0,10
	stfs 0,12(31)
	stfs 0,16(1)
	lwz 3,300(9)
	bl G_PickTarget
	mr 9,3
.L84:
	lis 11,.LC54@ha
	stw 9,420(31)
	la 11,.LC54@l(11)
	stw 9,416(31)
	lfs 0,0(11)
	lfs 13,600(30)
	fcmpu 0,13,0
	bc 12,2,.L85
	lis 9,level+4@ha
	lwz 11,832(31)
	mr 3,31
	lfs 0,level+4@l(9)
	mtlr 11
	b .L88
.L85:
	cmpwi 0,9,0
	bc 4,2,.L86
	lis 9,level+4@ha
	lis 11,.LC53@ha
	lwz 10,832(31)
	lfs 0,level+4@l(9)
	mr 3,31
	lfs 13,.LC53@l(11)
	mtlr 10
.L88:
	fadds 0,0,13
	stfs 0,872(31)
	blrl
	b .L78
.L86:
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
	stfs 1,428(31)
.L78:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 path_corner_touch,.Lfe5-path_corner_touch
	.section	".rodata"
	.align 2
.LC55:
	.string	"path_corner with no targetname at %s\n"
	.align 2
.LC56:
	.string	"%s at %s target %s does not exist\n"
	.align 2
.LC57:
	.long 0x4cbebc20
	.section	".text"
	.align 2
	.globl point_combat_touch
	.type	 point_combat_touch,@function
point_combat_touch:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,4
	mr 30,3
	lwz 0,420(31)
	cmpw 0,0,30
	bc 4,2,.L91
	lwz 0,300(30)
	cmpwi 0,0,0
	bc 12,2,.L93
	mr 3,0
	stw 0,300(31)
	bl G_PickTarget
	cmpwi 0,3,0
	stw 3,420(31)
	stw 3,416(31)
	bc 4,2,.L94
	lis 29,gi@ha
	lwz 28,284(30)
	addi 3,30,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC56@ha
	lwz 6,300(30)
	la 3,.LC56@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	stw 30,420(31)
.L94:
	li 0,0
	stw 0,300(30)
	b .L95
.L93:
	lwz 0,288(30)
	andi. 9,0,1
	bc 12,2,.L95
	lwz 0,268(31)
	andi. 9,0,3
	bc 4,2,.L95
	lis 11,.LC57@ha
	lis 9,level+4@ha
	lwz 0,820(31)
	lfs 0,level+4@l(9)
	mr 3,31
	lfs 13,.LC57@l(11)
	ori 0,0,1
	lwz 11,832(31)
	stw 0,820(31)
	fadds 0,0,13
	mtlr 11
	stfs 0,872(31)
	blrl
.L95:
	lwz 0,420(31)
	cmpw 0,0,30
	bc 4,2,.L97
	lwz 0,820(31)
	li 11,0
	lwz 9,548(31)
	rlwinm 0,0,0,20,18
	stw 11,420(31)
	stw 9,416(31)
	stw 0,820(31)
	stw 11,300(31)
.L97:
	lwz 0,316(30)
	cmpwi 0,0,0
	bc 12,2,.L91
	lwz 29,300(30)
	stw 0,300(30)
	lwz 4,548(31)
	cmpwi 0,4,0
	bc 12,2,.L99
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 4,2,.L105
.L99:
	lwz 4,552(31)
	cmpwi 0,4,0
	bc 12,2,.L101
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L101
.L105:
	mr 3,4
	b .L100
.L101:
	lwz 9,556(31)
	mr 3,31
	cmpwi 0,9,0
	bc 12,2,.L100
	lwz 0,84(9)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,3,0
	or 3,0,9
.L100:
	mr 4,3
	mr 3,30
	bl G_UseTargets
	stw 29,300(30)
.L91:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 point_combat_touch,.Lfe6-point_combat_touch
	.section	".rodata"
	.align 2
.LC59:
	.string	"viewthing spawned\n"
	.align 2
.LC60:
	.string	"models/objects/banner/tris.md2"
	.align 2
.LC61:
	.string	"m"
	.align 2
.LC62:
	.string	"a"
	.align 2
.LC63:
	.string	"func_wall START_ON without TOGGLE\n"
	.section	".text"
	.align 2
	.globl SP_func_wall
	.type	 SP_func_wall,@function
SP_func_wall:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	li 0,2
	lis 9,gi@ha
	stw 0,264(31)
	la 30,gi@l(9)
	lwz 4,272(31)
	lwz 9,44(30)
	mtlr 9
	blrl
	lwz 0,288(31)
	andi. 9,0,8
	bc 12,2,.L126
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L126:
	lwz 0,288(31)
	andi. 9,0,16
	bc 12,2,.L127
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L127:
	lwz 0,288(31)
	andi. 9,0,7
	bc 4,2,.L128
	li 0,3
	mr 3,31
	stw 0,248(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	b .L125
.L128:
	andi. 9,0,1
	bc 4,2,.L129
	ori 0,0,1
	stw 0,288(31)
.L129:
	lwz 0,288(31)
	andi. 9,0,4
	bc 12,2,.L130
	andi. 9,0,2
	bc 4,2,.L130
	lwz 0,4(30)
	lis 3,.LC63@ha
	la 3,.LC63@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,288(31)
	ori 0,0,2
	stw 0,288(31)
.L130:
	lwz 0,288(31)
	lis 9,func_wall_use@ha
	la 9,func_wall_use@l(9)
	andi. 11,0,4
	stw 9,452(31)
	bc 12,2,.L132
	li 0,3
	stw 0,248(31)
	b .L133
.L132:
	lwz 0,184(31)
	stw 11,248(31)
	ori 0,0,1
	stw 0,184(31)
.L133:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L125:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 SP_func_wall,.Lfe7-SP_func_wall
	.section	".rodata"
	.align 3
.LC64:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC65:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl SP_func_object
	.type	 SP_func_object,@function
SP_func_object:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,gi+44@ha
	mr 31,3
	lwz 0,gi+44@l(9)
	lwz 4,272(31)
	mtlr 0
	blrl
	lis 9,.LC65@ha
	lfs 10,188(31)
	la 9,.LC65@l(9)
	lfs 9,192(31)
	lfs 0,0(9)
	lfs 8,196(31)
	lfs 11,200(31)
	lfs 12,204(31)
	fadds 10,10,0
	lfs 13,208(31)
	fadds 9,9,0
	lwz 0,520(31)
	fadds 8,8,0
	fsubs 11,11,0
	stfs 10,188(31)
	fsubs 12,12,0
	cmpwi 0,0,0
	stfs 9,192(31)
	fsubs 13,13,0
	stfs 8,196(31)
	stfs 11,200(31)
	stfs 12,204(31)
	stfs 13,208(31)
	bc 4,2,.L142
	li 0,100
	stw 0,520(31)
.L142:
	lwz 0,288(31)
	cmpwi 0,0,0
	bc 4,2,.L143
	li 11,3
	lis 9,func_object_release@ha
	stw 11,248(31)
	la 9,func_object_release@l(9)
	li 0,2
	stw 0,264(31)
	lis 11,level+4@ha
	lis 10,.LC64@ha
	stw 9,440(31)
	lfs 0,level+4@l(11)
	lfd 13,.LC64@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(31)
	b .L144
.L143:
	lwz 0,184(31)
	lis 9,func_object_use@ha
	li 11,0
	la 9,func_object_use@l(9)
	li 10,2
	stw 11,248(31)
	ori 0,0,1
	stw 10,264(31)
	stw 9,452(31)
	stw 0,184(31)
.L144:
	lwz 0,288(31)
	andi. 9,0,2
	bc 12,2,.L145
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L145:
	lwz 0,288(31)
	andi. 9,0,4
	bc 12,2,.L146
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L146:
	lis 0,0x202
	lis 9,gi+72@ha
	ori 0,0,3
	mr 3,31
	stw 0,252(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 SP_func_object,.Lfe8-SP_func_object
	.section	".rodata"
	.align 2
.LC67:
	.string	"models/objects/debris1/tris.md2"
	.align 2
.LC68:
	.string	"models/objects/debris2/tris.md2"
	.align 2
.LC66:
	.long 0x46fffe00
	.align 2
.LC69:
	.long 0x3f000000
	.align 3
.LC70:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC71:
	.long 0x43160000
	.align 3
.LC72:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC73:
	.long 0x3f800000
	.align 2
.LC74:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl func_explosive_explode
	.type	 func_explosive_explode,@function
func_explosive_explode:
	stwu 1,-112(1)
	mflr 0
	stfd 29,88(1)
	stfd 30,96(1)
	stfd 31,104(1)
	stmw 26,64(1)
	stw 0,116(1)
	lis 9,.LC69@ha
	mr 31,3
	la 9,.LC69@l(9)
	addi 30,1,40
	lfs 1,0(9)
	mr 28,4
	mr 26,5
	addi 3,31,236
	mr 4,30
	bl VectorScale
	lfs 11,40(1)
	li 0,0
	lfs 12,212(31)
	lfs 10,44(1)
	lfs 13,216(31)
	fadds 12,12,11
	lfs 0,220(31)
	lfs 11,48(1)
	fadds 13,13,10
	lwz 11,520(31)
	stfs 12,4(31)
	fadds 0,0,11
	stw 0,516(31)
	cmpwi 0,11,0
	stfs 13,8(31)
	stfs 12,8(1)
	stfs 0,12(31)
	stfs 13,12(1)
	stfs 0,16(1)
	bc 12,2,.L148
	xoris 0,11,0x8000
	stw 0,60(1)
	lis 10,0x4330
	mr 3,31
	stw 10,56(1)
	addi 0,11,40
	mr 4,26
	mr 11,9
	lfd 1,56(1)
	xoris 0,0,0x8000
	lis 9,.LC70@ha
	stw 0,60(1)
	li 5,0
	la 9,.LC70@l(9)
	stw 10,56(1)
	li 6,25
	lfd 0,0(9)
	lfd 2,56(1)
	fsub 1,1,0
	fsub 2,2,0
	frsp 1,1
	frsp 2,2
	bl T_RadiusDamage
.L148:
	lfs 0,4(28)
	addi 29,31,380
	lfs 13,4(31)
	mr 3,29
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,380(31)
	lfs 0,8(28)
	fsubs 12,12,0
	stfs 12,384(31)
	lfs 0,12(28)
	fsubs 11,11,0
	stfs 11,388(31)
	bl VectorNormalize
	lis 9,.LC71@ha
	mr 3,29
	la 9,.LC71@l(9)
	mr 4,3
	lfs 1,0(9)
	bl VectorScale
	lis 9,.LC69@ha
	mr 3,30
	la 9,.LC69@l(9)
	mr 4,3
	lfs 1,0(9)
	bl VectorScale
	lwz 28,404(31)
	srawi 9,28,31
	xor 0,9,28
	subf 0,0,9
	srawi 0,0,31
	nor 9,0,0
	andi. 9,9,75
	and 0,28,0
	or 28,0,9
	cmpwi 0,28,99
	bc 4,1,.L150
	lis 0,0x51eb
	srawi 9,28,31
	ori 0,0,34079
	mulhw 0,28,0
	srawi 0,0,5
	subf 29,9,0
	cmpwi 7,29,9
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,29,0
	rlwinm 9,9,0,28,28
	or 29,0,9
	cmpwi 0,29,0
	addi 29,29,-1
	bc 12,2,.L150
	lis 9,.LC66@ha
	lis 11,.LC72@ha
	lfs 29,.LC66@l(9)
	la 11,.LC72@l(11)
	lis 30,0x4330
	lis 9,.LC70@ha
	lfd 31,0(11)
	lis 27,.LC67@ha
	la 9,.LC70@l(9)
	lfd 30,0(9)
.L154:
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,8(1)
	xoris 3,3,0x8000
	lfs 12,40(1)
	stw 3,60(1)
	stw 30,56(1)
	lfd 13,56(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,24(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,12(1)
	xoris 3,3,0x8000
	lfs 12,44(1)
	stw 3,60(1)
	stw 30,56(1)
	lfd 13,56(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,28(1)
	bl rand
	rlwinm 0,3,0,17,31
	lfs 11,16(1)
	xoris 0,0,0x8000
	lfs 12,48(1)
	lis 11,.LC73@ha
	stw 0,60(1)
	la 11,.LC73@l(11)
	mr 3,31
	stw 30,56(1)
	la 4,.LC67@l(27)
	addi 5,1,24
	lfd 13,56(1)
	lfs 1,0(11)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,32(1)
	bl ThrowDebris
	cmpwi 0,29,0
	addi 29,29,-1
	bc 4,2,.L154
.L150:
	lis 0,0x51eb
	srawi 9,28,31
	ori 0,0,34079
	mulhw 0,28,0
	srawi 0,0,3
	subf 29,9,0
	cmpwi 7,29,17
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,29,0
	rlwinm 9,9,0,27,27
	or 29,0,9
	cmpwi 0,29,0
	addi 29,29,-1
	bc 12,2,.L158
	lis 9,.LC66@ha
	lis 11,.LC72@ha
	lfs 29,.LC66@l(9)
	la 11,.LC72@l(11)
	lis 30,0x4330
	lis 9,.LC70@ha
	lfd 31,0(11)
	lis 28,.LC68@ha
	la 9,.LC70@l(9)
	lfd 30,0(9)
.L159:
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,8(1)
	xoris 3,3,0x8000
	lfs 12,40(1)
	stw 3,60(1)
	stw 30,56(1)
	lfd 13,56(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,24(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,12(1)
	xoris 3,3,0x8000
	lfs 12,44(1)
	stw 3,60(1)
	stw 30,56(1)
	lfd 13,56(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,28(1)
	bl rand
	rlwinm 0,3,0,17,31
	lfs 11,16(1)
	xoris 0,0,0x8000
	lfs 12,48(1)
	lis 11,.LC74@ha
	stw 0,60(1)
	la 11,.LC74@l(11)
	mr 3,31
	stw 30,56(1)
	la 4,.LC68@l(28)
	addi 5,1,24
	lfd 13,56(1)
	lfs 1,0(11)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,32(1)
	bl ThrowDebris
	cmpwi 0,29,0
	addi 29,29,-1
	bc 4,2,.L159
.L158:
	mr 4,26
	mr 3,31
	bl G_UseTargets
	lwz 0,520(31)
	cmpwi 0,0,0
	bc 12,2,.L161
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	addi 28,31,4
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,5
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L163
.L161:
	mr 3,31
	bl G_FreeEdict
.L163:
	lwz 0,116(1)
	mtlr 0
	lmw 26,64(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe9:
	.size	 func_explosive_explode,.Lfe9-func_explosive_explode
	.align 2
	.globl SP_func_explosive
	.type	 SP_func_explosive,@function
SP_func_explosive:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	li 0,2
	lis 29,gi@ha
	stw 0,264(31)
	lis 3,.LC67@ha
	la 29,gi@l(29)
	la 3,.LC67@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC68@ha
	la 3,.LC68@l(3)
	mtlr 9
	blrl
	lwz 0,44(29)
	mr 3,31
	lwz 4,272(31)
	mtlr 0
	blrl
	lwz 0,288(31)
	andi. 9,0,1
	bc 12,2,.L167
	lwz 0,184(31)
	lis 9,func_explosive_spawn@ha
	li 11,0
	la 9,func_explosive_spawn@l(9)
	stw 11,248(31)
	ori 0,0,1
	stw 9,452(31)
	stw 0,184(31)
	b .L168
.L167:
	lwz 9,304(31)
	li 0,3
	stw 0,248(31)
	cmpwi 0,9,0
	bc 12,2,.L168
	lis 9,func_explosive_use@ha
	la 9,func_explosive_use@l(9)
	stw 9,452(31)
.L168:
	lwz 0,288(31)
	andi. 9,0,2
	bc 12,2,.L170
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L170:
	lwz 0,288(31)
	andi. 9,0,4
	bc 12,2,.L171
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L171:
	lwz 0,452(31)
	lis 9,func_explosive_use@ha
	la 9,func_explosive_use@l(9)
	cmpw 0,0,9
	bc 12,2,.L172
	lwz 0,484(31)
	cmpwi 0,0,0
	bc 4,2,.L173
	li 0,100
	stw 0,484(31)
.L173:
	lis 9,func_explosive_explode@ha
	li 0,1
	la 9,func_explosive_explode@l(9)
	stw 0,516(31)
	stw 9,460(31)
.L172:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 SP_func_explosive,.Lfe10-SP_func_explosive
	.section	".rodata"
	.align 2
.LC77:
	.string	"models/objects/debris3/tris.md2"
	.align 2
.LC76:
	.long 0x46fffe00
	.align 3
.LC78:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC79:
	.long 0x40690000
	.long 0x0
	.align 3
.LC80:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC81:
	.long 0x3f000000
	.align 3
.LC82:
	.long 0x3ff80000
	.long 0x0
	.align 3
.LC83:
	.long 0x3ffc0000
	.long 0x0
	.section	".text"
	.align 2
	.globl barrel_explode
	.type	 barrel_explode,@function
barrel_explode:
	stwu 1,-112(1)
	mflr 0
	stfd 27,72(1)
	stfd 28,80(1)
	stfd 29,88(1)
	stfd 30,96(1)
	stfd 31,104(1)
	stmw 26,48(1)
	stw 0,116(1)
	mr 31,3
	lwz 9,520(31)
	lis 29,0x4330
	mr 10,11
	lis 8,.LC78@ha
	lwz 4,556(31)
	li 6,26
	xoris 0,9,0x8000
	la 8,.LC78@l(8)
	stw 0,44(1)
	addi 9,9,40
	stw 29,40(1)
	xoris 9,9,0x8000
	li 5,0
	lfd 1,40(1)
	addi 30,31,4
	lis 26,.LC67@ha
	stw 9,44(1)
	lis 11,.LC79@ha
	lis 28,.LC77@ha
	stw 29,40(1)
	la 11,.LC79@l(11)
	lis 27,.LC68@ha
	lfd 2,40(1)
	lfd 31,0(8)
	lis 8,.LC80@ha
	lfd 28,0(11)
	la 8,.LC80@l(8)
	fsub 1,1,31
	lfd 30,0(8)
	fsub 2,2,31
	frsp 1,1
	frsp 2,2
	bl T_RadiusDamage
	lis 8,.LC81@ha
	lfs 12,4(31)
	addi 4,31,236
	lfs 13,8(31)
	la 8,.LC81@l(8)
	mr 5,30
	lfs 0,12(31)
	addi 3,31,212
	lfs 1,0(8)
	stfs 12,24(1)
	stfs 13,28(1)
	stfs 0,32(1)
	bl VectorMA
	lwz 0,520(31)
	lis 8,.LC82@ha
	la 8,.LC82@l(8)
	xoris 0,0,0x8000
	lfd 12,0(8)
	stw 0,44(1)
	stw 29,40(1)
	lfd 0,40(1)
	fsub 0,0,31
	frsp 0,0
	fmr 13,0
	fmul 13,13,12
	fdiv 13,13,28
	frsp 27,13
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,4(31)
	xoris 3,3,0x8000
	lis 11,.LC76@ha
	lfs 12,236(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	lfs 29,.LC76@l(11)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,8(31)
	xoris 3,3,0x8000
	lfs 12,240(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,12(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,12(31)
	fmr 1,27
	xoris 3,3,0x8000
	lfs 12,244(31)
	addi 5,1,8
	stw 3,44(1)
	la 4,.LC67@l(26)
	stw 29,40(1)
	mr 3,31
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,16(1)
	bl ThrowDebris
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,4(31)
	xoris 3,3,0x8000
	lfs 12,236(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,8(31)
	xoris 3,3,0x8000
	lfs 12,240(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,12(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,12(31)
	fmr 1,27
	xoris 3,3,0x8000
	lfs 12,244(31)
	addi 5,1,8
	stw 3,44(1)
	la 4,.LC67@l(26)
	stw 29,40(1)
	mr 3,31
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,16(1)
	bl ThrowDebris
	lwz 0,520(31)
	lis 8,.LC83@ha
	lfs 0,220(31)
	la 8,.LC83@l(8)
	addi 5,1,8
	xoris 0,0,0x8000
	lfs 10,212(31)
	mr 3,31
	stw 0,44(1)
	la 4,.LC77@l(28)
	stw 29,40(1)
	lfd 13,40(1)
	lfs 12,216(31)
	stfs 0,16(1)
	fsub 13,13,31
	lfd 11,0(8)
	stfs 10,8(1)
	stfs 12,12(1)
	frsp 13,13
	fmr 0,13
	fmul 0,0,11
	fdiv 0,0,28
	frsp 27,0
	fmr 1,27
	bl ThrowDebris
	lfs 12,236(31)
	fmr 1,27
	addi 5,1,8
	mr 3,31
	lfs 13,212(31)
	la 4,.LC77@l(28)
	lfs 11,216(31)
	lfs 0,220(31)
	fadds 13,13,12
	stfs 11,12(1)
	stfs 0,16(1)
	stfs 13,8(1)
	bl ThrowDebris
	lfs 12,240(31)
	fmr 1,27
	addi 5,1,8
	mr 3,31
	lfs 13,216(31)
	la 4,.LC77@l(28)
	lfs 11,212(31)
	lfs 0,220(31)
	fadds 13,13,12
	stfs 11,8(1)
	stfs 0,16(1)
	stfs 13,12(1)
	bl ThrowDebris
	lfs 10,240(31)
	fmr 1,27
	addi 5,1,8
	la 4,.LC77@l(28)
	lfs 0,236(31)
	mr 3,31
	lfs 11,212(31)
	lfs 12,216(31)
	lfs 13,220(31)
	fadds 11,11,0
	fadds 12,12,10
	stfs 13,16(1)
	stfs 11,8(1)
	stfs 12,12(1)
	bl ThrowDebris
	lwz 9,520(31)
	lis 0,0x51eb
	ori 0,0,34079
	mulhw 0,9,0
	srawi 9,9,31
	srawi 0,0,5
	subf 0,9,0
	xoris 0,0,0x8000
	stw 0,44(1)
	stw 29,40(1)
	lfd 0,40(1)
	fsub 0,0,31
	frsp 27,0
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,4(31)
	xoris 3,3,0x8000
	lfs 12,236(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,8(31)
	xoris 3,3,0x8000
	lfs 12,240(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,12(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,12(31)
	fmr 1,27
	xoris 3,3,0x8000
	lfs 12,244(31)
	addi 5,1,8
	stw 3,44(1)
	la 4,.LC68@l(27)
	stw 29,40(1)
	mr 3,31
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,16(1)
	bl ThrowDebris
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,4(31)
	xoris 3,3,0x8000
	lfs 12,236(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,8(31)
	xoris 3,3,0x8000
	lfs 12,240(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,12(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,12(31)
	fmr 1,27
	xoris 3,3,0x8000
	lfs 12,244(31)
	addi 5,1,8
	stw 3,44(1)
	la 4,.LC68@l(27)
	stw 29,40(1)
	mr 3,31
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,16(1)
	bl ThrowDebris
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,4(31)
	xoris 3,3,0x8000
	lfs 12,236(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,8(31)
	xoris 3,3,0x8000
	lfs 12,240(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,12(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,12(31)
	fmr 1,27
	xoris 3,3,0x8000
	lfs 12,244(31)
	addi 5,1,8
	stw 3,44(1)
	la 4,.LC68@l(27)
	stw 29,40(1)
	mr 3,31
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,16(1)
	bl ThrowDebris
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,4(31)
	xoris 3,3,0x8000
	lfs 12,236(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,8(31)
	xoris 3,3,0x8000
	lfs 12,240(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,12(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,12(31)
	fmr 1,27
	xoris 3,3,0x8000
	lfs 12,244(31)
	addi 5,1,8
	stw 3,44(1)
	la 4,.LC68@l(27)
	stw 29,40(1)
	mr 3,31
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,16(1)
	bl ThrowDebris
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,4(31)
	xoris 3,3,0x8000
	lfs 12,236(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,8(31)
	xoris 3,3,0x8000
	lfs 12,240(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,12(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,12(31)
	fmr 1,27
	xoris 3,3,0x8000
	lfs 12,244(31)
	addi 5,1,8
	stw 3,44(1)
	la 4,.LC68@l(27)
	stw 29,40(1)
	mr 3,31
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,16(1)
	bl ThrowDebris
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,4(31)
	xoris 3,3,0x8000
	lfs 12,236(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,8(31)
	xoris 3,3,0x8000
	lfs 12,240(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,12(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,12(31)
	fmr 1,27
	xoris 3,3,0x8000
	lfs 12,244(31)
	addi 5,1,8
	stw 3,44(1)
	la 4,.LC68@l(27)
	stw 29,40(1)
	mr 3,31
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,16(1)
	bl ThrowDebris
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,4(31)
	xoris 3,3,0x8000
	lfs 12,236(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,8(31)
	xoris 3,3,0x8000
	lfs 12,240(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,12(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,12(31)
	fmr 1,27
	xoris 3,3,0x8000
	lfs 12,244(31)
	addi 5,1,8
	stw 3,44(1)
	la 4,.LC68@l(27)
	stw 29,40(1)
	mr 3,31
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,16(1)
	bl ThrowDebris
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,4(31)
	xoris 3,3,0x8000
	lfs 12,236(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,8(31)
	xoris 3,3,0x8000
	lfs 12,240(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,12(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,12(31)
	fmr 1,27
	xoris 3,3,0x8000
	lfs 12,244(31)
	la 4,.LC68@l(27)
	stw 3,44(1)
	addi 5,1,8
	stw 29,40(1)
	mr 3,31
	lfd 13,40(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,16(1)
	bl ThrowDebris
	lwz 0,560(31)
	lfs 12,24(1)
	lfs 0,28(1)
	cmpwi 0,0,0
	lfs 13,32(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 12,2,.L178
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,6
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,30
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,30
	li 4,2
	mtlr 0
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L180
.L178:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,5
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,30
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,30
	li 4,2
	mtlr 0
	blrl
	mr 3,31
	bl G_FreeEdict
.L180:
	lwz 0,116(1)
	mtlr 0
	lmw 26,48(1)
	lfd 27,72(1)
	lfd 28,80(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe11:
	.size	 barrel_explode,.Lfe11-barrel_explode
	.section	".rodata"
	.align 2
.LC85:
	.string	"models/objects/barrels/tris.md2"
	.align 3
.LC86:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC87:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_misc_explobox
	.type	 SP_misc_explobox,@function
SP_misc_explobox:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	lis 11,.LC87@ha
	lis 9,deathmatch@ha
	la 11,.LC87@l(11)
	mr 31,3
	lfs 31,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L184
	bl G_FreeEdict
	b .L183
.L184:
	lis 9,gi@ha
	lis 3,.LC67@ha
	la 30,gi@l(9)
	la 3,.LC67@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 9,32(30)
	lis 3,.LC68@ha
	la 3,.LC68@l(3)
	mtlr 9
	blrl
	lwz 9,32(30)
	lis 3,.LC77@ha
	la 3,.LC77@l(3)
	mtlr 9
	blrl
	lis 9,.LC85@ha
	li 11,2
	la 9,.LC85@l(9)
	li 0,5
	stw 11,248(31)
	stw 0,264(31)
	mr 3,9
	stw 9,272(31)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,404(31)
	lis 9,0xc180
	lis 11,0x4180
	lis 10,0x4220
	stw 3,40(31)
	cmpwi 0,0,0
	stw 9,192(31)
	stfs 31,196(31)
	stw 11,204(31)
	stw 10,208(31)
	stw 9,188(31)
	stw 11,200(31)
	bc 4,2,.L185
	li 0,400
	stw 0,404(31)
.L185:
	lwz 0,484(31)
	cmpwi 0,0,0
	bc 4,2,.L186
	li 0,10
	stw 0,484(31)
.L186:
	lwz 0,520(31)
	cmpwi 0,0,0
	bc 4,2,.L187
	li 0,150
	stw 0,520(31)
.L187:
	lis 9,barrel_delay@ha
	lis 11,barrel_touch@ha
	la 9,barrel_delay@l(9)
	la 11,barrel_touch@l(11)
	stw 9,460(31)
	lis 10,M_droptofloor@ha
	li 0,0
	stw 11,448(31)
	li 9,4132
	la 10,M_droptofloor@l(10)
	li 8,1
	li 7,1024
	stw 9,984(31)
	stw 0,492(31)
	lis 11,level+4@ha
	lis 9,.LC86@ha
	stw 8,516(31)
	mr 3,31
	stw 7,820(31)
	stw 10,440(31)
	lfs 0,level+4@l(11)
	lfd 13,.LC86@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(31)
	lwz 0,72(30)
	mtlr 0
	blrl
.L183:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 SP_misc_explobox,.Lfe12-SP_misc_explobox
	.section	".rodata"
	.align 2
.LC89:
	.string	"models/objects/black/tris.md2"
	.align 2
.LC92:
	.string	"models/monsters/tank/tris.md2"
	.align 2
.LC95:
	.string	"models/monsters/bitch/tris.md2"
	.align 2
.LC100:
	.string	"tank/thud.wav"
	.align 2
.LC102:
	.string	"tank/pain.wav"
	.align 2
.LC103:
	.string	"models/monsters/commandr/tris.md2"
	.align 2
.LC108:
	.string	"models/objects/bannerx/tris.md2"
	.align 2
.LC110:
	.string	"models/objects/banner1/tris.md2"
	.align 2
.LC112:
	.string	"models/objects/banner2/tris.md2"
	.align 2
.LC114:
	.string	"models/objects/banner3/tris.md2"
	.align 2
.LC116:
	.string	"models/objects/banner4/tris.md2"
	.align 2
.LC120:
	.string	"models/deadbods/dude/tris.md2"
	.align 2
.LC125:
	.string	"misc/udeath.wav"
	.align 2
.LC126:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC127:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_misc_deadsoldier
	.type	 SP_misc_deadsoldier,@function
SP_misc_deadsoldier:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 11,.LC127@ha
	lis 9,deathmatch@ha
	la 11,.LC127@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L235
	bl G_FreeEdict
	b .L234
.L235:
	li 0,0
	li 29,2
	lis 9,gi+32@ha
	stw 0,264(31)
	lis 3,.LC120@ha
	stw 29,248(31)
	la 3,.LC120@l(3)
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
	lwz 0,288(31)
	stw 3,40(31)
	andi. 9,0,2
	bc 12,2,.L236
	li 0,1
	b .L244
.L236:
	andi. 11,0,4
	bc 12,2,.L238
	stw 29,56(31)
	b .L237
.L238:
	andi. 9,0,8
	bc 12,2,.L240
	li 0,3
	b .L244
.L240:
	andi. 11,0,16
	bc 12,2,.L242
	li 0,4
	b .L244
.L242:
	andi. 0,0,32
	bc 12,2,.L244
	li 0,5
.L244:
	stw 0,56(31)
.L237:
	lwz 11,184(31)
	li 0,0
	li 6,2
	lwz 9,820(31)
	lis 10,misc_deadsoldier_die@ha
	lis 7,0x4180
	stw 0,196(31)
	lis 29,0xc180
	la 10,misc_deadsoldier_die@l(10)
	li 0,200
	stw 6,496(31)
	ori 11,11,6
	ori 9,9,256
	li 8,1
	stw 29,192(31)
	li 4,-80
	li 5,4100
	stw 7,208(31)
	stw 8,516(31)
	lis 6,gi+72@ha
	mr 3,31
	stw 11,184(31)
	stw 10,460(31)
	stw 9,820(31)
	stw 4,492(31)
	stw 0,404(31)
	stw 5,984(31)
	stw 29,188(31)
	stw 7,200(31)
	stw 7,204(31)
	lwz 0,gi+72@l(6)
	mtlr 0
	blrl
.L234:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 SP_misc_deadsoldier,.Lfe13-SP_misc_deadsoldier
	.section	".rodata"
	.align 2
.LC128:
	.string	"misc_viper without a target at %s\n"
	.align 2
.LC129:
	.string	"models/ships/viper/tris.md2"
	.align 3
.LC130:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_viper
	.type	 SP_misc_viper,@function
SP_misc_viper:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L248
	lis 29,gi@ha
	addi 3,31,212
	la 29,gi@l(29)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC128@ha
	la 3,.LC128@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L247
.L248:
	lis 0,0x4396
	li 11,0
	li 9,2
	lis 29,gi@ha
	stw 0,332(31)
	la 29,gi@l(29)
	stw 11,248(31)
	lis 3,.LC129@ha
	stw 9,264(31)
	la 3,.LC129@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 11,func_train_find@ha
	lis 5,0xc180
	stw 3,40(31)
	lis 6,0x4180
	li 0,0
	stw 5,192(31)
	la 11,func_train_find@l(11)
	lis 10,0x4200
	stw 0,196(31)
	stw 6,204(31)
	lis 8,level+4@ha
	lis 7,.LC130@ha
	stw 10,208(31)
	lis 9,misc_viper_use@ha
	mr 3,31
	stw 11,440(31)
	la 9,misc_viper_use@l(9)
	stw 5,188(31)
	stw 6,200(31)
	lfs 0,level+4@l(8)
	lfd 12,.LC130@l(7)
	lfs 13,332(31)
	lwz 0,184(31)
	stw 9,452(31)
	ori 0,0,1
	stfs 13,756(31)
	fadd 0,0,12
	stw 0,184(31)
	stfs 13,760(31)
	stfs 13,764(31)
	frsp 0,0
	stfs 0,432(31)
	lwz 0,72(29)
	mtlr 0
	blrl
.L247:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 SP_misc_viper,.Lfe14-SP_misc_viper
	.section	".rodata"
	.align 2
.LC131:
	.string	"models/ships/bigviper/tris.md2"
	.align 2
.LC132:
	.string	"misc_viper"
	.align 2
.LC133:
	.string	"models/objects/bomb/tris.md2"
	.align 2
.LC134:
	.string	"%s without a target at %s\n"
	.align 2
.LC135:
	.string	"models/ships/strogg1/tris.md2"
	.align 3
.LC136:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC137:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_misc_strogg_ship
	.type	 SP_misc_strogg_ship,@function
SP_misc_strogg_ship:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L259
	lis 29,gi@ha
	lwz 28,284(31)
	addi 3,31,212
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC134@ha
	la 3,.LC134@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L258
.L259:
	lis 9,.LC137@ha
	lfs 0,332(31)
	la 9,.LC137@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L260
	lis 0,0x4396
	stw 0,332(31)
.L260:
	li 0,2
	li 9,0
	lis 29,gi@ha
	stw 0,264(31)
	lis 3,.LC135@ha
	la 29,gi@l(29)
	stw 9,248(31)
	la 3,.LC135@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 11,func_train_find@ha
	lis 7,0xc180
	stw 3,40(31)
	lis 10,0x4180
	lis 0,0x4200
	stw 7,192(31)
	la 11,func_train_find@l(11)
	stw 0,208(31)
	lis 6,level+4@ha
	stfs 31,196(31)
	lis 8,.LC136@ha
	lis 9,misc_strogg_ship_use@ha
	stw 10,204(31)
	la 9,misc_strogg_ship_use@l(9)
	mr 3,31
	stw 11,440(31)
	stw 7,188(31)
	stw 10,200(31)
	lfs 0,level+4@l(6)
	lfd 12,.LC136@l(8)
	lfs 13,332(31)
	lwz 0,184(31)
	stw 9,452(31)
	ori 0,0,1
	stfs 13,756(31)
	fadd 0,0,12
	stw 0,184(31)
	stfs 13,760(31)
	stfs 13,764(31)
	frsp 0,0
	stfs 0,432(31)
	lwz 0,72(29)
	mtlr 0
	blrl
.L258:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 SP_misc_strogg_ship,.Lfe15-SP_misc_strogg_ship
	.section	".rodata"
	.align 2
.LC140:
	.string	"models/objects/satellite/tris.md2"
	.align 2
.LC141:
	.string	"models/objects/minelite/light1/tris.md2"
	.align 2
.LC142:
	.string	"models/objects/minelite/light2/tris.md2"
	.align 2
.LC143:
	.string	"models/objects/gibs/arm/tris.md2"
	.align 2
.LC144:
	.long 0x46fffe00
	.align 3
.LC145:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC146:
	.long 0x43480000
	.align 2
.LC147:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl SP_misc_gib_arm
	.type	 SP_misc_gib_arm,@function
SP_misc_gib_arm:
	stwu 1,-80(1)
	mflr 0
	stfd 29,56(1)
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 27,36(1)
	stw 0,84(1)
	lis 27,gi@ha
	mr 29,3
	la 27,gi@l(27)
	lis 4,.LC143@ha
	lwz 11,44(27)
	la 4,.LC143@l(4)
	lis 8,.LC145@ha
	lis 9,.LC146@ha
	mtlr 11
	la 8,.LC145@l(8)
	la 9,.LC146@l(9)
	lfd 31,0(8)
	lis 28,0x4330
	lfs 29,0(9)
	blrl
	lwz 0,64(29)
	li 10,0
	lis 9,gib_die@ha
	lwz 11,184(29)
	li 8,1
	li 7,7
	stw 10,248(29)
	ori 0,0,2
	la 9,gib_die@l(9)
	li 10,2
	ori 11,11,4
	stw 0,64(29)
	stw 8,516(29)
	stw 10,496(29)
	stw 7,264(29)
	stw 9,460(29)
	stw 11,184(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC144@ha
	stw 3,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	lfs 30,.LC144@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,29
	stfs 0,392(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,29
	stfs 0,396(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 9,G_FreeEdict@ha
	stw 3,28(1)
	la 9,G_FreeEdict@l(9)
	lis 8,.LC147@ha
	stw 28,24(1)
	lis 10,level+4@ha
	la 8,.LC147@l(8)
	lfd 0,24(1)
	mr 3,29
	stw 9,440(29)
	lfs 12,0(8)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,29
	stfs 0,400(29)
	lfs 13,level+4@l(10)
	fadds 13,13,12
	stfs 13,432(29)
	lwz 0,72(27)
	mtlr 0
	blrl
	lwz 0,84(1)
	mtlr 0
	lmw 27,36(1)
	lfd 29,56(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe16:
	.size	 SP_misc_gib_arm,.Lfe16-SP_misc_gib_arm
	.section	".rodata"
	.align 2
.LC148:
	.string	"models/objects/gibs/leg/tris.md2"
	.align 2
.LC149:
	.long 0x46fffe00
	.align 3
.LC150:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC151:
	.long 0x43480000
	.align 2
.LC152:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl SP_misc_gib_leg
	.type	 SP_misc_gib_leg,@function
SP_misc_gib_leg:
	stwu 1,-80(1)
	mflr 0
	stfd 29,56(1)
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 27,36(1)
	stw 0,84(1)
	lis 27,gi@ha
	mr 29,3
	la 27,gi@l(27)
	lis 4,.LC148@ha
	lwz 11,44(27)
	la 4,.LC148@l(4)
	lis 8,.LC150@ha
	lis 9,.LC151@ha
	mtlr 11
	la 8,.LC150@l(8)
	la 9,.LC151@l(9)
	lfd 31,0(8)
	lis 28,0x4330
	lfs 29,0(9)
	blrl
	lwz 0,64(29)
	li 10,0
	lis 9,gib_die@ha
	lwz 11,184(29)
	li 8,1
	li 7,7
	stw 10,248(29)
	ori 0,0,2
	la 9,gib_die@l(9)
	li 10,2
	ori 11,11,4
	stw 0,64(29)
	stw 8,516(29)
	stw 10,496(29)
	stw 7,264(29)
	stw 9,460(29)
	stw 11,184(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC149@ha
	stw 3,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	lfs 30,.LC149@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,29
	stfs 0,392(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,29
	stfs 0,396(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 9,G_FreeEdict@ha
	stw 3,28(1)
	la 9,G_FreeEdict@l(9)
	lis 8,.LC152@ha
	stw 28,24(1)
	lis 10,level+4@ha
	la 8,.LC152@l(8)
	lfd 0,24(1)
	mr 3,29
	stw 9,440(29)
	lfs 12,0(8)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,29
	stfs 0,400(29)
	lfs 13,level+4@l(10)
	fadds 13,13,12
	stfs 13,432(29)
	lwz 0,72(27)
	mtlr 0
	blrl
	lwz 0,84(1)
	mtlr 0
	lmw 27,36(1)
	lfd 29,56(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe17:
	.size	 SP_misc_gib_leg,.Lfe17-SP_misc_gib_leg
	.section	".rodata"
	.align 2
.LC153:
	.string	"models/objects/gibs/head/tris.md2"
	.align 2
.LC154:
	.long 0x46fffe00
	.align 3
.LC155:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC156:
	.long 0x43480000
	.align 2
.LC157:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl SP_misc_gib_head
	.type	 SP_misc_gib_head,@function
SP_misc_gib_head:
	stwu 1,-80(1)
	mflr 0
	stfd 29,56(1)
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 27,36(1)
	stw 0,84(1)
	lis 27,gi@ha
	mr 29,3
	la 27,gi@l(27)
	lis 4,.LC153@ha
	lwz 11,44(27)
	la 4,.LC153@l(4)
	lis 8,.LC155@ha
	lis 9,.LC156@ha
	mtlr 11
	la 8,.LC155@l(8)
	la 9,.LC156@l(9)
	lfd 31,0(8)
	lis 28,0x4330
	lfs 29,0(9)
	blrl
	lwz 0,64(29)
	li 10,0
	lis 9,gib_die@ha
	lwz 11,184(29)
	li 8,1
	li 7,7
	stw 10,248(29)
	ori 0,0,2
	la 9,gib_die@l(9)
	li 10,2
	ori 11,11,4
	stw 0,64(29)
	stw 8,516(29)
	stw 10,496(29)
	stw 7,264(29)
	stw 9,460(29)
	stw 11,184(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC154@ha
	stw 3,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	lfs 30,.LC154@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,29
	stfs 0,392(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,29
	stfs 0,396(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 9,G_FreeEdict@ha
	stw 3,28(1)
	la 9,G_FreeEdict@l(9)
	lis 8,.LC157@ha
	stw 28,24(1)
	lis 10,level+4@ha
	la 8,.LC157@l(8)
	lfd 0,24(1)
	mr 3,29
	stw 9,440(29)
	lfs 12,0(8)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,29
	stfs 0,400(29)
	lfs 13,level+4@l(10)
	fadds 13,13,12
	stfs 13,432(29)
	lwz 0,72(27)
	mtlr 0
	blrl
	lwz 0,84(1)
	mtlr 0
	lmw 27,36(1)
	lfd 29,56(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe18:
	.size	 SP_misc_gib_head,.Lfe18-SP_misc_gib_head
	.section	".rodata"
	.align 2
.LC158:
	.string	""
	.align 2
.LC159:
	.string	"%2i"
	.align 2
.LC160:
	.string	"%2i:%2i"
	.align 2
.LC161:
	.string	"%2i:%2i:%2i"
	.section	".text"
	.align 2
	.type	 func_clock_format_countdown,@function
func_clock_format_countdown:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,660(31)
	cmpwi 0,0,0
	bc 4,2,.L292
	lis 5,.LC159@ha
	lwz 6,484(31)
	li 4,16
	lwz 3,280(31)
	la 5,.LC159@l(5)
	crxor 6,6,6
	bl Com_sprintf
	b .L291
.L292:
	cmpwi 0,0,1
	bc 4,2,.L293
	lwz 0,484(31)
	lis 6,0x8888
	lis 5,.LC160@ha
	ori 6,6,34953
	lwz 3,280(31)
	la 5,.LC160@l(5)
	mulhw 6,0,6
	srawi 9,0,31
	li 4,16
	add 6,6,0
	srawi 6,6,5
	subf 6,9,6
	mulli 7,6,60
	subf 7,7,0
	crxor 6,6,6
	bl Com_sprintf
	lwz 3,280(31)
	lbz 0,3(3)
	cmpwi 0,0,32
	bc 4,2,.L291
	li 0,48
	stb 0,3(3)
	b .L291
.L293:
	cmpwi 0,0,2
	bc 4,2,.L291
	lwz 9,484(31)
	lis 6,0x91a2
	lis 7,0x8888
	ori 6,6,46021
	ori 7,7,34953
	lwz 3,280(31)
	mulhw 6,9,6
	srawi 11,9,31
	lis 5,.LC161@ha
	mulhw 8,9,7
	la 5,.LC161@l(5)
	li 4,16
	add 6,6,9
	srawi 6,6,11
	add 8,8,9
	subf 6,11,6
	srawi 8,8,5
	mulli 0,6,3600
	subf 8,11,8
	mulli 8,8,60
	subf 0,0,9
	mulhw 7,0,7
	srawi 11,0,31
	subf 8,8,9
	add 7,7,0
	srawi 7,7,5
	subf 7,11,7
	crxor 6,6,6
	bl Com_sprintf
	lwz 9,280(31)
	lbz 0,3(9)
	cmpwi 0,0,32
	bc 4,2,.L296
	li 0,48
	stb 0,3(9)
.L296:
	lwz 3,280(31)
	lbz 0,6(3)
	cmpwi 0,0,32
	bc 4,2,.L291
	li 0,48
	stb 0,6(3)
.L291:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe19:
	.size	 func_clock_format_countdown,.Lfe19-func_clock_format_countdown
	.section	".rodata"
	.align 3
.LC162:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC163:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl func_clock_think
	.type	 func_clock_think,@function
func_clock_think:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,548(31)
	cmpwi 0,0,0
	bc 4,2,.L299
	lwz 5,300(31)
	li 3,0
	li 4,304
	bl G_Find
	cmpwi 0,3,0
	stw 3,548(31)
	bc 12,2,.L298
.L299:
	lwz 0,288(31)
	andi. 8,0,1
	bc 12,2,.L301
	mr 3,31
	bl func_clock_format_countdown
	lwz 9,484(31)
	addi 9,9,1
	stw 9,484(31)
	b .L302
.L301:
	andi. 8,0,2
	bc 12,2,.L303
	mr 3,31
	bl func_clock_format_countdown
	lwz 9,484(31)
	addi 9,9,-1
	stw 9,484(31)
	b .L302
.L303:
	addi 29,1,8
	mr 3,29
	bl time
	mr 3,29
	bl localtime
	mr 9,3
	lis 5,.LC161@ha
	lwz 8,0(9)
	la 5,.LC161@l(5)
	li 4,16
	lwz 6,8(9)
	lwz 7,4(9)
	lwz 3,280(31)
	crxor 6,6,6
	bl Com_sprintf
	lwz 9,280(31)
	lbz 0,3(9)
	cmpwi 0,0,32
	bc 4,2,.L305
	li 0,48
	stb 0,3(9)
.L305:
	lwz 9,280(31)
	lbz 0,6(9)
	cmpwi 0,0,32
	bc 4,2,.L302
	li 0,48
	stb 0,6(9)
.L302:
	lwz 0,280(31)
	mr 4,31
	mr 5,31
	lwz 9,548(31)
	stw 0,280(9)
	lwz 11,548(31)
	lwz 0,452(11)
	mr 3,11
	mtlr 0
	blrl
	lwz 10,288(31)
	andi. 0,10,1
	bc 12,2,.L309
	lwz 0,484(31)
	lis 11,0x4330
	lis 8,.LC162@ha
	lfs 12,600(31)
	xoris 0,0,0x8000
	la 8,.LC162@l(8)
	stw 0,28(1)
	stw 11,24(1)
	lfd 13,0(8)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,1,.L308
.L309:
	andi. 9,10,2
	bc 12,2,.L307
	lwz 0,484(31)
	lis 11,0x4330
	lis 10,.LC162@ha
	lfs 12,600(31)
	xoris 0,0,0x8000
	la 10,.LC162@l(10)
	stw 0,28(1)
	stw 11,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L307
.L308:
	lwz 9,316(31)
	cmpwi 0,9,0
	bc 12,2,.L310
	lwz 29,300(31)
	li 0,0
	mr 3,31
	lwz 28,280(31)
	lwz 4,556(31)
	stw 9,300(31)
	stw 0,280(31)
	bl G_UseTargets
	stw 29,300(31)
	stw 28,280(31)
.L310:
	lwz 0,288(31)
	andi. 8,0,8
	bc 12,2,.L298
	andi. 9,0,1
	li 10,0
	stw 10,556(31)
	bc 12,2,.L312
	lwz 0,536(31)
	lis 11,0x4330
	lis 8,.LC162@ha
	stw 10,484(31)
	xoris 0,0,0x8000
	la 8,.LC162@l(8)
	stw 0,28(1)
	stw 11,24(1)
	lfd 13,0(8)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,600(31)
	b .L315
.L312:
	andi. 9,0,2
	bc 12,2,.L315
	lwz 9,536(31)
	li 0,0
	stw 0,600(31)
	stw 9,484(31)
.L315:
	lwz 0,288(31)
	andi. 10,0,4
	bc 4,2,.L298
.L307:
	lis 11,.LC163@ha
	lis 9,level+4@ha
	la 11,.LC163@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,432(31)
.L298:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe20:
	.size	 func_clock_think,.Lfe20-func_clock_think
	.section	".rodata"
	.align 2
.LC164:
	.string	"%s with no target at %s\n"
	.align 2
.LC165:
	.string	"%s with no count at %s\n"
	.align 3
.LC166:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC167:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl SP_func_clock
	.type	 SP_func_clock,@function
SP_func_clock:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L321
	lis 29,gi@ha
	lwz 28,284(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC164@ha
	la 3,.LC164@l(3)
	b .L330
.L321:
	lwz 0,288(31)
	andi. 8,0,2
	mr 9,0
	bc 12,2,.L322
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 4,2,.L322
	lis 29,gi@ha
	lwz 28,284(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC165@ha
	la 3,.LC165@l(3)
.L330:
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L320
.L322:
	andi. 0,9,1
	bc 12,2,.L323
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 4,2,.L323
	li 0,3600
	stw 0,536(31)
.L323:
	lwz 0,288(31)
	li 10,0
	stw 10,556(31)
	andi. 8,0,1
	bc 12,2,.L324
	lwz 0,536(31)
	lis 11,0x4330
	lis 8,.LC166@ha
	stw 10,484(31)
	xoris 0,0,0x8000
	la 8,.LC166@l(8)
	stw 0,12(1)
	stw 11,8(1)
	lfd 13,0(8)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,600(31)
	b .L327
.L324:
	andi. 9,0,2
	bc 12,2,.L327
	lwz 9,536(31)
	li 0,0
	stw 0,600(31)
	stw 9,484(31)
.L327:
	lis 9,gi+132@ha
	li 3,16
	lwz 0,gi+132@l(9)
	li 4,766
	mtlr 0
	blrl
	lwz 0,288(31)
	lis 9,func_clock_think@ha
	la 9,func_clock_think@l(9)
	stw 3,280(31)
	andi. 8,0,4
	stw 9,440(31)
	bc 12,2,.L328
	lis 9,func_clock_use@ha
	la 9,func_clock_use@l(9)
	stw 9,452(31)
	b .L320
.L328:
	lis 11,.LC167@ha
	lis 9,level+4@ha
	la 11,.LC167@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,432(31)
.L320:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 SP_func_clock,.Lfe21-SP_func_clock
	.section	".rodata"
	.align 2
.LC168:
	.string	"Couldn't find destination\n"
	.align 2
.LC169:
	.long 0x47800000
	.align 2
.LC170:
	.long 0x43b40000
	.align 2
.LC171:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl teleporter_touch
	.type	 teleporter_touch,@function
teleporter_touch:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,4
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L331
	lwz 5,300(3)
	li 4,304
	li 3,0
	bl G_Find
	mr. 30,3
	bc 4,2,.L333
	lis 9,gi+4@ha
	lis 3,.LC168@ha
	lwz 0,gi+4@l(9)
	la 3,.LC168@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L331
.L333:
	lis 9,gi+76@ha
	mr 3,31
	lwz 0,gi+76@l(9)
	mtlr 0
	blrl
	lfs 0,4(30)
	lis 9,.LC169@ha
	li 0,0
	la 9,.LC169@l(9)
	lwz 10,84(31)
	li 11,20
	lfs 10,0(9)
	addi 6,30,16
	li 7,0
	stfs 0,4(31)
	lis 9,.LC170@ha
	li 8,0
	lfs 0,8(30)
	la 9,.LC170@l(9)
	lfs 11,0(9)
	lis 9,.LC171@ha
	stfs 0,8(31)
	la 9,.LC171@l(9)
	lfs 12,12(30)
	lfs 13,0(9)
	li 9,3
	stfs 12,12(31)
	mtctr 9
	lfs 0,4(30)
	fadds 12,12,13
	stfs 0,28(31)
	lfs 13,8(30)
	stfs 13,32(31)
	lfs 0,12(30)
	stfs 12,12(31)
	stw 0,380(31)
	stfs 0,36(31)
	stw 0,388(31)
	stw 0,384(31)
	stb 11,17(10)
	lwz 9,84(31)
	lbz 0,16(9)
	ori 0,0,32
	stb 0,16(9)
.L339:
	lwz 10,84(31)
	add 0,7,7
	lfsx 0,8,6
	addi 7,7,1
	addi 9,10,3428
	lfsx 13,9,8
	addi 10,10,20
	addi 8,8,4
	fsubs 0,0,13
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,16(1)
	lwz 11,20(1)
	sthx 11,10,0
	bdnz .L339
	li 0,0
	lwz 11,84(31)
	mr 3,31
	stw 0,24(31)
	stw 0,20(31)
	stw 0,16(31)
	stw 0,28(11)
	stw 0,36(11)
	stw 0,32(11)
	lwz 9,84(31)
	stw 0,4264(9)
	stw 0,4272(9)
	stw 0,4268(9)
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L331:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 teleporter_touch,.Lfe22-teleporter_touch
	.section	".rodata"
	.align 2
.LC172:
	.string	"teleporter without a target.\n"
	.align 2
.LC173:
	.string	"models/objects/dmspot/tris.md2"
	.align 2
.LC174:
	.string	"world/amb10.wav"
	.section	".text"
	.align 2
	.globl SP_misc_teleporter
	.type	 SP_misc_teleporter,@function
SP_misc_teleporter:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L341
	lis 9,gi+4@ha
	lis 3,.LC172@ha
	lwz 0,gi+4@l(9)
	la 3,.LC172@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L340
.L341:
	lis 29,gi@ha
	lis 4,.LC173@ha
	la 29,gi@l(29)
	la 4,.LC173@l(4)
	lwz 9,44(29)
	mr 3,31
	li 28,1
	mtlr 9
	blrl
	stw 28,60(31)
	lis 3,.LC174@ha
	lwz 9,36(29)
	la 3,.LC174@l(3)
	mtlr 9
	blrl
	lis 10,0xc200
	lis 8,0x4200
	stw 3,76(31)
	li 0,2
	lis 11,0xc180
	stw 10,192(31)
	lis 9,0xc1c0
	stw 0,248(31)
	mr 3,31
	stw 8,204(31)
	stw 11,208(31)
	stw 10,188(31)
	stw 8,200(31)
	stw 9,196(31)
	lwz 9,72(29)
	mtlr 9
	blrl
	bl G_Spawn
	lis 11,teleporter_touch@ha
	mr 9,3
	la 11,teleporter_touch@l(11)
	stw 28,248(9)
	lis 10,0x4100
	stw 11,448(9)
	lis 8,0xc100
	lwz 0,300(31)
	lis 11,0x41c0
	stw 31,256(9)
	stw 0,300(9)
	lfs 0,4(31)
	stfs 0,4(9)
	lfs 13,8(31)
	stfs 13,8(9)
	lfs 0,12(31)
	stw 8,192(9)
	stw 10,204(9)
	stfs 0,12(9)
	stw 11,208(9)
	stw 8,188(9)
	stw 10,196(9)
	stw 10,200(9)
	lwz 0,72(29)
	mtlr 0
	blrl
.L340:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 SP_misc_teleporter,.Lfe23-SP_misc_teleporter
	.section	".rodata"
	.align 2
.LC175:
	.long 0x3f800000
	.long 0x0
	.long 0x40400000
	.align 2
.LC176:
	.string	"models/objects/gibs/brain/tris.md2"
	.align 2
.LC178:
	.string	"%s%c"
	.align 2
.LC179:
	.string	"grass"
	.align 2
.LC180:
	.string	"ground1"
	.align 2
.LC181:
	.string	"hedge"
	.align 2
.LC182:
	.string	"redcarp"
	.align 2
.LC183:
	.string	"carpet"
	.align 2
.LC184:
	.string	"rug"
	.align 2
.LC185:
	.string	"wood"
	.align 2
.LC186:
	.string	"wdfence"
	.align 2
.LC187:
	.string	"k_roof01"
	.align 2
.LC188:
	.string	"roof1"
	.align 2
.LC189:
	.string	"floor3"
	.align 2
.LC190:
	.string	"mr_floor10"
	.align 2
.LC191:
	.string	"a3"
	.align 2
.LC192:
	.string	"wdv256c"
	.align 2
.LC193:
	.string	"base_bkend"
	.align 2
.LC194:
	.string	"sandyrockboard"
	.align 2
.LC195:
	.string	"rf_sr_mw1"
	.align 2
.LC196:
	.string	"crate"
	.align 2
.LC197:
	.string	"ladder"
	.align 2
.LC198:
	.string	"metal"
	.align 2
.LC199:
	.string	"hedgehog"
	.align 2
.LC200:
	.string	"pantheriv"
	.align 2
.LC201:
	.string	"base_bkup"
	.align 2
.LC202:
	.string	"trk_bed"
	.align 2
.LC203:
	.string	"air_duct"
	.align 2
.LC204:
	.string	"barrel"
	.align 2
.LC205:
	.string	"sand"
	.align 2
.LC206:
	.string	"cf_m_asphalt1"
	.align 2
.LC207:
	.string	"mr_rock3"
	.align 2
.LC208:
	.string	"rubble"
	.align 2
.LC209:
	.string	"dirt"
	.align 2
.LC210:
	.string	"mud"
	.align 2
.LC211:
	.string	"white"
	.align 2
.LC212:
	.string	"snow"
	.section	".text"
	.align 2
	.globl Surface
	.type	 Surface,@function
Surface:
	stwu 1,-160(1)
	mflr 0
	stmw 23,124(1)
	stw 0,164(1)
	cmpwi 0,4,2
	mr 30,3
	bc 12,2,.L358
	bc 12,1,.L806
	cmpwi 0,4,1
	bc 12,2,.L699
	b .L357
.L806:
	cmpwi 0,4,3
	bc 12,2,.L437
	cmpwi 0,4,4
	bc 12,2,.L607
	b .L357
.L808:
	li 0,1
	b .L369
.L358:
	lis 9,.LC179@ha
	mr 3,30
	la 25,.LC179@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L371
	li 23,0
.L362:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L367
	lis 27,.LC178@ha
.L365:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L365
.L367:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L808
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L362
.L371:
	li 0,0
.L369:
	cmpwi 0,0,0
	bc 12,2,.L359
.L870:
	li 3,1
	b .L807
.L809:
	li 0,1
	b .L382
.L359:
	lis 9,.LC180@ha
	mr 3,30
	la 25,.LC180@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L384
	li 23,0
.L375:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L380
	lis 27,.LC178@ha
.L378:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L378
.L380:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L809
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L375
.L384:
	li 0,0
.L382:
	cmpwi 0,0,0
	bc 12,2,.L372
	b .L870
.L810:
	li 0,1
	b .L395
.L372:
	lis 9,.LC181@ha
	mr 3,30
	la 25,.LC181@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L397
	li 23,0
.L388:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L393
	lis 27,.LC178@ha
.L391:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L391
.L393:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L810
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L388
.L397:
	li 0,0
.L395:
	cmpwi 0,0,0
	bc 12,2,.L385
	b .L870
.L811:
	li 0,1
	b .L408
.L385:
	lis 9,.LC182@ha
	mr 3,30
	la 25,.LC182@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L410
	li 23,0
.L401:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L406
	lis 27,.LC178@ha
.L404:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L404
.L406:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L811
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L401
.L410:
	li 0,0
.L408:
	cmpwi 0,0,0
	bc 12,2,.L398
	b .L870
.L812:
	li 0,1
	b .L421
.L398:
	lis 9,.LC183@ha
	mr 3,30
	la 25,.LC183@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L423
	li 23,0
.L414:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L419
	lis 27,.LC178@ha
.L417:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L417
.L419:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L812
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L414
.L423:
	li 0,0
.L421:
	cmpwi 0,0,0
	bc 4,2,.L870
	lis 9,.LC184@ha
	mr 3,30
	la 25,.LC184@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L698
	li 23,0
.L427:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L432
	lis 27,.LC178@ha
.L430:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L430
.L432:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L833
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L427
	b .L698
.L814:
	li 0,1
	b .L448
.L437:
	lis 9,.LC185@ha
	mr 3,30
	la 25,.LC185@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L450
	li 23,0
.L441:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L446
	lis 27,.LC178@ha
.L444:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L444
.L446:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L814
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L441
.L450:
	li 0,0
.L448:
	cmpwi 0,0,0
	bc 12,2,.L438
	b .L870
.L815:
	li 0,1
	b .L461
.L438:
	lis 9,.LC186@ha
	mr 3,30
	la 25,.LC186@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L463
	li 23,0
.L454:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L459
	lis 27,.LC178@ha
.L457:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L457
.L459:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L815
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L454
.L463:
	li 0,0
.L461:
	cmpwi 0,0,0
	bc 12,2,.L451
	b .L870
.L816:
	li 0,1
	b .L474
.L451:
	lis 9,.LC187@ha
	mr 3,30
	la 25,.LC187@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L476
	li 23,0
.L467:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L472
	lis 27,.LC178@ha
.L470:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L470
.L472:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L816
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L467
.L476:
	li 0,0
.L474:
	cmpwi 0,0,0
	bc 12,2,.L464
	b .L870
.L817:
	li 0,1
	b .L487
.L464:
	lis 9,.LC188@ha
	mr 3,30
	la 25,.LC188@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L489
	li 23,0
.L480:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L485
	lis 27,.LC178@ha
.L483:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L483
.L485:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L817
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L480
.L489:
	li 0,0
.L487:
	cmpwi 0,0,0
	bc 12,2,.L477
	b .L870
.L818:
	li 0,1
	b .L500
.L477:
	lis 9,.LC189@ha
	mr 3,30
	la 25,.LC189@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L502
	li 23,0
.L493:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L498
	lis 27,.LC178@ha
.L496:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L496
.L498:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L818
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L493
.L502:
	li 0,0
.L500:
	cmpwi 0,0,0
	bc 12,2,.L490
	b .L870
.L819:
	li 0,1
	b .L513
.L490:
	lis 9,.LC190@ha
	mr 3,30
	la 25,.LC190@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L515
	li 23,0
.L506:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L511
	lis 27,.LC178@ha
.L509:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L509
.L511:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L819
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L506
.L515:
	li 0,0
.L513:
	cmpwi 0,0,0
	bc 12,2,.L503
	b .L870
.L820:
	li 0,1
	b .L526
.L503:
	lis 9,.LC191@ha
	mr 3,30
	la 25,.LC191@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L528
	li 23,0
.L519:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L524
	lis 27,.LC178@ha
.L522:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L522
.L524:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L820
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L519
.L528:
	li 0,0
.L526:
	cmpwi 0,0,0
	bc 12,2,.L516
	b .L870
.L821:
	li 0,1
	b .L539
.L516:
	lis 9,.LC192@ha
	mr 3,30
	la 25,.LC192@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L541
	li 23,0
.L532:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L537
	lis 27,.LC178@ha
.L535:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L535
.L537:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L821
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L532
.L541:
	li 0,0
.L539:
	cmpwi 0,0,0
	bc 12,2,.L529
	b .L870
.L822:
	li 0,1
	b .L552
.L529:
	lis 9,.LC193@ha
	mr 3,30
	la 25,.LC193@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L554
	li 23,0
.L545:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L550
	lis 27,.LC178@ha
.L548:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L548
.L550:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L822
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L545
.L554:
	li 0,0
.L552:
	cmpwi 0,0,0
	bc 12,2,.L542
	b .L870
.L823:
	li 0,1
	b .L565
.L542:
	lis 9,.LC194@ha
	mr 3,30
	la 25,.LC194@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L567
	li 23,0
.L558:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L563
	lis 27,.LC178@ha
.L561:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L561
.L563:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L823
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L558
.L567:
	li 0,0
.L565:
	cmpwi 0,0,0
	bc 12,2,.L555
	b .L870
.L824:
	li 0,1
	b .L578
.L555:
	lis 9,.LC195@ha
	mr 3,30
	la 25,.LC195@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L580
	li 23,0
.L571:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L576
	lis 27,.LC178@ha
.L574:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L574
.L576:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L824
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L571
.L580:
	li 0,0
.L578:
	cmpwi 0,0,0
	bc 12,2,.L568
	b .L870
.L825:
	li 0,1
	b .L591
.L568:
	lis 9,.LC196@ha
	mr 3,30
	la 25,.LC196@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L593
	li 23,0
.L584:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L589
	lis 27,.LC178@ha
.L587:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L587
.L589:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L825
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L584
.L593:
	li 0,0
.L591:
	cmpwi 0,0,0
	bc 4,2,.L870
	lis 9,.LC197@ha
	mr 3,30
	la 25,.LC197@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L698
	li 23,0
.L597:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L602
	lis 27,.LC178@ha
.L600:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L600
.L602:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L833
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L597
	b .L698
.L827:
	li 0,1
	b .L618
.L607:
	lis 9,.LC198@ha
	mr 3,30
	la 25,.LC198@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L620
	li 23,0
.L611:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L616
	lis 27,.LC178@ha
.L614:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L614
.L616:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L827
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L611
.L620:
	li 0,0
.L618:
	cmpwi 0,0,0
	bc 12,2,.L608
	b .L870
.L828:
	li 0,1
	b .L631
.L608:
	lis 9,.LC199@ha
	mr 3,30
	la 25,.LC199@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L633
	li 23,0
.L624:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L629
	lis 27,.LC178@ha
.L627:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L627
.L629:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L828
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L624
.L633:
	li 0,0
.L631:
	cmpwi 0,0,0
	bc 12,2,.L621
	b .L870
.L829:
	li 0,1
	b .L644
.L621:
	lis 9,.LC200@ha
	mr 3,30
	la 25,.LC200@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L646
	li 23,0
.L637:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L642
	lis 27,.LC178@ha
.L640:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L640
.L642:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L829
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L637
.L646:
	li 0,0
.L644:
	cmpwi 0,0,0
	bc 12,2,.L634
	b .L870
.L830:
	li 0,1
	b .L657
.L634:
	lis 9,.LC201@ha
	mr 3,30
	la 25,.LC201@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L659
	li 23,0
.L650:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L655
	lis 27,.LC178@ha
.L653:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L653
.L655:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L830
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L650
.L659:
	li 0,0
.L657:
	cmpwi 0,0,0
	bc 12,2,.L647
	b .L870
.L831:
	li 0,1
	b .L670
.L647:
	lis 9,.LC202@ha
	mr 3,30
	la 25,.LC202@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L672
	li 23,0
.L663:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L668
	lis 27,.LC178@ha
.L666:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L666
.L668:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L831
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L663
.L672:
	li 0,0
.L670:
	cmpwi 0,0,0
	bc 12,2,.L660
	b .L870
.L832:
	li 0,1
	b .L683
.L660:
	lis 9,.LC203@ha
	mr 3,30
	la 25,.LC203@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L685
	li 23,0
.L676:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L681
	lis 27,.LC178@ha
.L679:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L679
.L681:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L832
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L676
.L685:
	li 0,0
.L683:
	cmpwi 0,0,0
	bc 12,2,.L673
	b .L870
.L833:
	li 0,1
	b .L696
.L673:
	lis 9,.LC204@ha
	mr 3,30
	la 25,.LC204@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L698
	li 23,0
.L689:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L694
	lis 27,.LC178@ha
.L692:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L692
.L694:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L833
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L689
.L698:
	li 0,0
.L696:
	cmpwi 0,0,0
	bc 12,2,.L357
	b .L870
.L834:
	li 0,1
	b .L710
.L699:
	lis 9,.LC205@ha
	mr 3,30
	la 25,.LC205@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L712
	li 23,0
.L703:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L708
	lis 27,.LC178@ha
.L706:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L706
.L708:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L834
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L703
.L712:
	li 0,0
.L710:
	cmpwi 0,0,0
	bc 12,2,.L700
	b .L870
.L835:
	li 0,1
	b .L723
.L700:
	lis 9,.LC206@ha
	mr 3,30
	la 25,.LC206@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L725
	li 23,0
.L716:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L721
	lis 27,.LC178@ha
.L719:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L719
.L721:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L835
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L716
.L725:
	li 0,0
.L723:
	cmpwi 0,0,0
	bc 12,2,.L713
	b .L870
.L836:
	li 0,1
	b .L736
.L713:
	lis 9,.LC207@ha
	mr 3,30
	la 25,.LC207@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L738
	li 23,0
.L729:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L734
	lis 27,.LC178@ha
.L732:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L732
.L734:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L836
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L729
.L738:
	li 0,0
.L736:
	cmpwi 0,0,0
	bc 12,2,.L726
	b .L870
.L837:
	li 0,1
	b .L749
.L726:
	lis 9,.LC208@ha
	mr 3,30
	la 25,.LC208@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L751
	li 23,0
.L742:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L747
	lis 27,.LC178@ha
.L745:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L745
.L747:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L837
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L742
.L751:
	li 0,0
.L749:
	cmpwi 0,0,0
	bc 12,2,.L739
	b .L870
.L838:
	li 0,1
	b .L762
.L739:
	lis 9,.LC209@ha
	mr 3,30
	la 25,.LC209@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L764
	li 23,0
.L755:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L760
	lis 27,.LC178@ha
.L758:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L758
.L760:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L838
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L755
.L764:
	li 0,0
.L762:
	cmpwi 0,0,0
	bc 12,2,.L752
	b .L870
.L839:
	li 0,1
	b .L775
.L752:
	lis 9,.LC210@ha
	mr 3,30
	la 25,.LC210@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L777
	li 23,0
.L768:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L773
	lis 27,.LC178@ha
.L771:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L771
.L773:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L839
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L768
.L777:
	li 0,0
.L775:
	cmpwi 0,0,0
	bc 12,2,.L765
	b .L870
.L840:
	li 0,1
	b .L788
.L765:
	lis 9,.LC211@ha
	mr 3,30
	la 25,.LC211@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L790
	li 23,0
.L781:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L786
	lis 27,.LC178@ha
.L784:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L784
.L786:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L840
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L781
.L790:
	li 0,0
.L788:
	cmpwi 0,0,0
	bc 12,2,.L778
	b .L870
.L841:
	li 0,1
	b .L801
.L778:
	lis 9,.LC212@ha
	mr 3,30
	la 25,.LC212@l(9)
	li 28,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,28,26
	mr 24,3
	bc 4,0,.L803
	li 23,0
.L794:
	add 0,24,28
	stb 23,8(1)
	mr 31,28
	cmpw 0,28,0
	mr 29,0
	bc 4,0,.L799
	lis 27,.LC178@ha
.L797:
	lbzx 3,30,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(27)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,29
	bc 12,0,.L797
.L799:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L841
	addi 28,28,1
	cmpw 0,28,26
	bc 12,0,.L794
.L803:
	li 0,0
.L801:
	cmpwi 0,0,0
	li 3,1
	bc 4,2,.L807
.L357:
	li 3,0
.L807:
	lwz 0,164(1)
	mtlr 0
	lmw 23,124(1)
	la 1,160(1)
	blr
.Lfe24:
	.size	 Surface,.Lfe24-Surface
	.comm	is_silenced,1,1
	.align 2
	.globl BecomeExplosion1
	.type	 BecomeExplosion1,@function
BecomeExplosion1:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	addi 28,27,4
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,5
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	mr 3,27
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 BecomeExplosion1,.Lfe25-BecomeExplosion1
	.section	".rodata"
	.align 3
.LC213:
	.long 0x40468000
	.long 0x0
	.align 2
.LC214:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl HeadShotGib
	.type	 HeadShotGib,@function
HeadShotGib:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 9,.LC175@ha
	addi 28,1,8
	lwz 10,.LC175@l(9)
	mr 26,4
	la 9,.LC175@l(9)
	lwz 11,8(9)
	lwz 0,4(9)
	stw 10,8(1)
	stw 0,4(28)
	stw 11,8(28)
	bl G_Spawn
	lis 27,gi@ha
	mr 29,3
	la 27,gi@l(27)
	lis 4,.LC176@ha
	lwz 9,44(27)
	la 4,.LC176@l(4)
	mtlr 9
	blrl
	mr 3,28
	bl VectorNormalize
	lis 9,gib_die@ha
	lwz 11,64(29)
	lis 8,gib_touch@ha
	lwz 0,268(29)
	la 9,gib_die@l(9)
	li 10,0
	stw 9,460(29)
	ori 11,11,2
	la 8,gib_touch@l(8)
	ori 0,0,2048
	li 9,9
	stw 10,248(29)
	li 7,1
	stw 11,64(29)
	mr 3,28
	stw 0,268(29)
	lis 11,.LC214@ha
	addi 4,29,380
	stw 9,264(29)
	la 11,.LC214@l(11)
	stw 7,516(29)
	stw 8,448(29)
	lfs 0,0(26)
	lfs 1,0(11)
	stfs 0,4(29)
	lfs 13,4(26)
	stfs 13,8(29)
	lfs 0,8(26)
	stfs 0,12(29)
	bl VectorScale
	lis 9,G_FreeEdict@ha
	lis 10,level+4@ha
	la 9,G_FreeEdict@l(9)
	lis 11,.LC213@ha
	stw 9,440(29)
	mr 3,29
	lfs 0,level+4@l(10)
	lfd 13,.LC213@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(29)
	lwz 0,72(27)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe26:
	.size	 HeadShotGib,.Lfe26-HeadShotGib
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.align 2
	.globl Use_Areaportal
	.type	 Use_Areaportal,@function
Use_Areaportal:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lis 11,gi+64@ha
	lwz 4,536(9)
	lwz 3,660(9)
	xori 4,4,1
	stw 4,536(9)
	lwz 0,gi+64@l(11)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe27:
	.size	 Use_Areaportal,.Lfe27-Use_Areaportal
	.align 2
	.globl SP_func_areaportal
	.type	 SP_func_areaportal,@function
SP_func_areaportal:
	lis 9,Use_Areaportal@ha
	li 0,0
	la 9,Use_Areaportal@l(9)
	stw 0,536(3)
	stw 9,452(3)
	blr
.Lfe28:
	.size	 SP_func_areaportal,.Lfe28-SP_func_areaportal
	.section	".rodata"
	.align 2
.LC215:
	.long 0x46fffe00
	.align 2
.LC216:
	.long 0x3f333333
	.align 2
.LC217:
	.long 0x3f99999a
	.align 3
.LC218:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC219:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC220:
	.long 0x40590000
	.long 0x0
	.align 3
.LC221:
	.long 0x40690000
	.long 0x0
	.section	".text"
	.align 2
	.globl VelocityForDamage
	.type	 VelocityForDamage,@function
VelocityForDamage:
	stwu 1,-64(1)
	mflr 0
	stfd 28,32(1)
	stfd 29,40(1)
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 28,16(1)
	stw 0,68(1)
	mr 31,4
	mr 28,3
	bl rand
	lis 29,0x4330
	lis 9,.LC218@ha
	rlwinm 3,3,0,17,31
	la 9,.LC218@l(9)
	xoris 3,3,0x8000
	lfd 30,0(9)
	lis 11,.LC215@ha
	lis 10,.LC219@ha
	lfs 28,.LC215@l(11)
	la 10,.LC219@l(10)
	stw 3,12(1)
	stw 29,8(1)
	lfd 13,8(1)
	lfd 29,0(10)
	lis 10,.LC220@ha
	fsub 13,13,30
	la 10,.LC220@l(10)
	lfd 31,0(10)
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,29
	fadd 0,0,0
	fmul 0,0,31
	frsp 0,0
	stfs 0,0(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 29,8(1)
	lfd 13,8(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,29
	fadd 0,0,0
	fmul 0,0,31
	frsp 0,0
	stfs 0,4(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC221@ha
	stw 3,12(1)
	la 10,.LC221@l(10)
	cmpwi 0,28,49
	stw 29,8(1)
	lfd 0,8(1)
	lfd 12,0(10)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,28
	fmr 13,0
	fmadd 13,13,31,12
	frsp 13,13
	stfs 13,8(31)
	bc 12,1,.L9
	lis 9,.LC216@ha
	mr 3,31
	lfs 1,.LC216@l(9)
	mr 4,3
	bl VectorScale
	b .L10
.L9:
	lis 9,.LC217@ha
	mr 3,31
	lfs 1,.LC217@l(9)
	mr 4,3
	bl VectorScale
.L10:
	lwz 0,68(1)
	mtlr 0
	lmw 28,16(1)
	lfd 28,32(1)
	lfd 29,40(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe29:
	.size	 VelocityForDamage,.Lfe29-VelocityForDamage
	.section	".rodata"
	.align 2
.LC222:
	.long 0xc3960000
	.align 2
.LC223:
	.long 0x43960000
	.align 2
.LC224:
	.long 0x43480000
	.align 2
.LC225:
	.long 0x43fa0000
	.section	".text"
	.align 2
	.globl ClipGibVelocity
	.type	 ClipGibVelocity,@function
ClipGibVelocity:
	lis 9,.LC222@ha
	lfs 0,380(3)
	la 9,.LC222@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L871
	lis 9,.LC223@ha
	la 9,.LC223@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L13
.L871:
	stfs 13,380(3)
.L13:
	lis 9,.LC222@ha
	lfs 0,384(3)
	la 9,.LC222@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L872
	lis 9,.LC223@ha
	la 9,.LC223@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L16
.L872:
	stfs 13,384(3)
.L16:
	lis 9,.LC224@ha
	lfs 0,388(3)
	la 9,.LC224@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L18
	stfs 13,388(3)
	blr
.L18:
	lis 9,.LC225@ha
	la 9,.LC225@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bclr 4,1
	stfs 13,388(3)
	blr
.Lfe30:
	.size	 ClipGibVelocity,.Lfe30-ClipGibVelocity
	.section	".rodata"
	.align 3
.LC226:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC227:
	.long 0x46fffe00
	.align 3
.LC228:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC229:
	.long 0x41000000
	.align 2
.LC230:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl gib_think
	.type	 gib_think,@function
gib_think:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	lis 10,level@ha
	lwz 11,56(31)
	la 30,level@l(10)
	lis 9,.LC226@ha
	lfd 13,.LC226@l(9)
	addi 11,11,1
	stw 11,56(31)
	cmpwi 0,11,10
	lfs 0,4(30)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(31)
	bc 4,2,.L22
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	stw 9,440(31)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,4(30)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC228@ha
	lis 11,.LC227@ha
	la 10,.LC228@l(10)
	stw 0,16(1)
	lfd 10,0(10)
	lfd 0,16(1)
	lis 10,.LC229@ha
	lfs 12,.LC227@l(11)
	la 10,.LC229@l(10)
	lfs 13,0(10)
	fsub 0,0,10
	lis 10,.LC230@ha
	la 10,.LC230@l(10)
	lfs 9,0(10)
	fadds 11,11,13
	frsp 0,0
	fdivs 0,0,12
	fmadds 0,0,9,11
	stfs 0,432(31)
.L22:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe31:
	.size	 gib_think,.Lfe31-gib_think
	.section	".rodata"
	.align 3
.LC231:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC232:
	.long 0x3f800000
	.align 2
.LC233:
	.long 0x0
	.section	".text"
	.align 2
	.globl gib_touch
	.type	 gib_touch,@function
gib_touch:
	stwu 1,-64(1)
	mflr 0
	stmw 28,48(1)
	stw 0,68(1)
	mr 31,3
	mr 30,5
	lwz 0,560(31)
	cmpwi 0,0,0
	bc 12,2,.L23
	cmpwi 0,30,0
	li 0,0
	stw 0,448(31)
	bc 12,2,.L23
	lis 29,gi@ha
	lis 3,.LC5@ha
	la 29,gi@l(29)
	la 3,.LC5@l(3)
	lwz 9,36(29)
	addi 28,1,24
	mtlr 9
	blrl
	lis 9,.LC232@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC232@l(9)
	mr 3,31
	lfs 1,0(9)
	mtlr 0
	li 4,2
	lis 9,.LC232@ha
	la 9,.LC232@l(9)
	lfs 2,0(9)
	lis 9,.LC233@ha
	la 9,.LC233@l(9)
	lfs 3,0(9)
	blrl
	addi 4,1,8
	mr 3,30
	bl vectoangles
	addi 3,1,8
	li 6,0
	li 4,0
	mr 5,28
	bl AngleVectors
	mr 3,28
	addi 4,31,16
	bl vectoangles
	lis 9,sm_meat_index@ha
	lwz 11,40(31)
	lwz 0,sm_meat_index@l(9)
	cmpw 0,11,0
	bc 4,2,.L23
	lwz 11,56(31)
	lis 9,gib_think@ha
	lis 8,level+4@ha
	la 9,gib_think@l(9)
	lis 10,.LC231@ha
	addi 11,11,1
	stw 9,440(31)
	stw 11,56(31)
	lfs 0,level+4@l(8)
	lfd 13,.LC231@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(31)
.L23:
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe32:
	.size	 gib_touch,.Lfe32-gib_touch
	.align 2
	.globl gib_die
	.type	 gib_die,@function
gib_die:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe33:
	.size	 gib_die,.Lfe33-gib_die
	.align 2
	.globl debris_die
	.type	 debris_die,@function
debris_die:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe34:
	.size	 debris_die,.Lfe34-debris_die
	.align 2
	.globl BecomeExplosion2
	.type	 BecomeExplosion2,@function
BecomeExplosion2:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	addi 28,27,4
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,6
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	mr 3,27
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 BecomeExplosion2,.Lfe35-BecomeExplosion2
	.align 2
	.globl SP_path_corner
	.type	 SP_path_corner,@function
SP_path_corner:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,304(31)
	cmpwi 0,0,0
	bc 4,2,.L90
	lis 29,gi@ha
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC55@ha
	la 3,.LC55@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L89
.L90:
	lwz 11,184(31)
	lis 9,path_corner_touch@ha
	lis 10,0xc100
	la 9,path_corner_touch@l(9)
	lis 8,0x4100
	stw 10,196(31)
	li 0,1
	stw 9,448(31)
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
.L89:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 SP_path_corner,.Lfe36-SP_path_corner
	.section	".rodata"
	.align 2
.LC234:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_point_combat
	.type	 SP_point_combat,@function
SP_point_combat:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC234@ha
	lis 9,deathmatch@ha
	la 11,.LC234@l(11)
	mr 6,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L107
	bl G_FreeEdict
	b .L106
.L107:
	lis 9,point_combat_touch@ha
	li 7,1
	la 9,point_combat_touch@l(9)
	lis 8,0xc100
	stw 7,184(6)
	lis 10,0x4100
	lis 0,0xc180
	stw 9,448(6)
	lis 11,0x4180
	stw 8,192(6)
	lis 9,gi+72@ha
	stw 0,196(6)
	mr 3,6
	stw 10,204(6)
	stw 11,208(6)
	stw 7,248(6)
	stw 8,188(6)
	stw 10,200(6)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L106:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 SP_point_combat,.Lfe37-SP_point_combat
	.section	".rodata"
	.align 3
.LC235:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl TH_viewthing
	.type	 TH_viewthing,@function
TH_viewthing:
	lwz 11,56(3)
	lis 9,0x9249
	lis 10,.LC235@ha
	ori 9,9,9363
	lfd 13,.LC235@l(10)
	lis 8,level+4@ha
	addi 11,11,1
	mulhw 9,11,9
	srawi 10,11,31
	add 9,9,11
	srawi 9,9,2
	subf 9,10,9
	slwi 0,9,3
	subf 0,9,0
	subf 11,0,11
	stw 11,56(3)
	lfs 0,level+4@l(8)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(3)
	blr
.Lfe38:
	.size	 TH_viewthing,.Lfe38-TH_viewthing
	.section	".rodata"
	.align 3
.LC236:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_viewthing
	.type	 SP_viewthing,@function
SP_viewthing:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 28,gi@ha
	mr 29,3
	la 28,gi@l(28)
	lis 3,.LC59@ha
	lwz 9,4(28)
	la 3,.LC59@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	lis 7,0xc180
	lis 6,0x4180
	li 11,64
	li 0,0
	stw 7,192(29)
	lis 10,0xc1c0
	lis 8,0x4200
	stw 11,68(29)
	li 9,2
	stw 0,264(29)
	lis 3,.LC60@ha
	stw 10,196(29)
	la 3,.LC60@l(3)
	stw 6,204(29)
	stw 8,208(29)
	stw 7,188(29)
	stw 6,200(29)
	stw 9,248(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	lwz 0,72(28)
	mr 3,29
	mtlr 0
	blrl
	lis 11,level+4@ha
	lis 9,.LC236@ha
	lfs 0,level+4@l(11)
	la 9,.LC236@l(9)
	lfd 13,0(9)
	lis 9,TH_viewthing@ha
	la 9,TH_viewthing@l(9)
	stw 9,440(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe39:
	.size	 SP_viewthing,.Lfe39-SP_viewthing
	.align 2
	.globl SP_info_null
	.type	 SP_info_null,@function
SP_info_null:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe40:
	.size	 SP_info_null,.Lfe40-SP_info_null
	.align 2
	.globl SP_info_notnull
	.type	 SP_info_notnull,@function
SP_info_notnull:
	lfs 0,4(3)
	lfs 13,8(3)
	lfs 12,12(3)
	stfs 0,224(3)
	stfs 13,228(3)
	stfs 12,232(3)
	stfs 0,212(3)
	stfs 13,216(3)
	stfs 12,220(3)
	blr
.Lfe41:
	.size	 SP_info_notnull,.Lfe41-SP_info_notnull
	.section	".rodata"
	.align 2
.LC237:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_light
	.type	 SP_light,@function
SP_light:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,304(3)
	cmpwi 0,0,0
	bc 12,2,.L117
	lis 9,.LC237@ha
	lis 11,deathmatch@ha
	la 9,.LC237@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L116
.L117:
	bl G_FreeEdict
	b .L115
.L116:
	lwz 11,660(3)
	cmpwi 0,11,31
	bc 4,1,.L115
	lwz 0,288(3)
	lis 9,light_use@ha
	la 9,light_use@l(9)
	andi. 10,0,1
	stw 9,452(3)
	bc 12,2,.L119
	lis 9,gi+24@ha
	lis 4,.LC62@ha
	lwz 0,gi+24@l(9)
	addi 3,11,800
	la 4,.LC62@l(4)
	mtlr 0
	blrl
	b .L115
.L119:
	lis 9,gi+24@ha
	lis 4,.LC61@ha
	lwz 0,gi+24@l(9)
	addi 3,11,800
	la 4,.LC61@l(4)
	mtlr 0
	blrl
.L115:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe42:
	.size	 SP_light,.Lfe42-SP_light
	.align 2
	.globl func_wall_use
	.type	 func_wall_use,@function
func_wall_use:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L122
	lwz 0,184(31)
	li 9,3
	stw 9,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl KillBox
	b .L123
.L122:
	lwz 0,184(31)
	li 9,0
	stw 9,248(31)
	ori 0,0,1
	stw 0,184(31)
.L123:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,288(31)
	andi. 0,0,2
	bc 4,2,.L124
	stw 0,452(31)
.L124:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe43:
	.size	 func_wall_use,.Lfe43-func_wall_use
	.section	".rodata"
	.align 3
.LC238:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl func_object_touch
	.type	 func_object_touch,@function
func_object_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr. 5,5
	mr 10,4
	bc 12,2,.L134
	lfs 0,8(5)
	lis 9,.LC238@ha
	la 9,.LC238@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L134
	lwz 0,516(10)
	cmpwi 0,0,0
	bc 12,2,.L134
	lwz 9,520(3)
	mr 4,3
	lis 6,vec3_origin@ha
	la 6,vec3_origin@l(6)
	li 0,0
	li 11,20
	mr 3,10
	stw 0,8(1)
	stw 11,12(1)
	mr 5,4
	addi 7,4,4
	mr 8,6
	li 10,1
	bl T_Damage
.L134:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe44:
	.size	 func_object_touch,.Lfe44-func_object_touch
	.align 2
	.globl func_object_release
	.type	 func_object_release,@function
func_object_release:
	lis 9,func_object_touch@ha
	li 0,7
	la 9,func_object_touch@l(9)
	stw 0,264(3)
	stw 9,448(3)
	blr
.Lfe45:
	.size	 func_object_release,.Lfe45-func_object_release
	.align 2
	.globl func_object_use
	.type	 func_object_use,@function
func_object_use:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	li 9,3
	lwz 0,184(29)
	li 11,0
	stw 9,248(29)
	rlwinm 0,0,0,0,30
	stw 11,452(29)
	stw 0,184(29)
	bl KillBox
	lis 9,func_object_touch@ha
	li 0,7
	la 9,func_object_touch@l(9)
	stw 0,264(29)
	stw 9,448(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe46:
	.size	 func_object_use,.Lfe46-func_object_use
	.align 2
	.globl func_explosive_use
	.type	 func_explosive_use,@function
func_explosive_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 5,4
	lis 7,vec3_origin@ha
	lwz 6,484(3)
	la 7,vec3_origin@l(7)
	mr 4,3
	bl func_explosive_explode
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe47:
	.size	 func_explosive_use,.Lfe47-func_explosive_use
	.align 2
	.globl func_explosive_spawn
	.type	 func_explosive_spawn,@function
func_explosive_spawn:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	li 9,3
	lwz 0,184(29)
	li 11,0
	stw 9,248(29)
	rlwinm 0,0,0,0,30
	stw 11,452(29)
	stw 0,184(29)
	bl KillBox
	lis 9,gi+72@ha
	mr 3,29
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe48:
	.size	 func_explosive_spawn,.Lfe48-func_explosive_spawn
	.section	".rodata"
	.align 3
.LC239:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC240:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC241:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl barrel_touch
	.type	 barrel_touch,@function
barrel_touch:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stw 31,52(1)
	stw 0,68(1)
	lwz 0,560(4)
	mr 31,3
	cmpwi 0,0,0
	bc 12,2,.L174
	cmpw 0,0,31
	bc 12,2,.L174
	lwz 0,404(4)
	lis 8,0x4330
	lwz 9,404(31)
	mr 10,11
	lis 7,.LC240@ha
	xoris 0,0,0x8000
	la 7,.LC240@l(7)
	lfs 8,12(4)
	stw 0,44(1)
	xoris 9,9,0x8000
	addi 3,1,8
	stw 8,40(1)
	lfd 31,40(1)
	stw 9,44(1)
	stw 8,40(1)
	lfd 13,0(7)
	lfd 0,40(1)
	lfs 11,4(31)
	fsub 31,31,13
	lfs 9,4(4)
	fsub 0,0,13
	lfs 12,8(31)
	lfs 10,8(4)
	frsp 31,31
	lfs 13,12(31)
	frsp 0,0
	fsubs 11,11,9
	fsubs 13,13,8
	fdivs 31,31,0
	stfs 11,8(1)
	stfs 13,16(1)
	fsubs 12,12,10
	stfs 12,12(1)
	bl vectoyaw
	lis 7,.LC241@ha
	lis 9,.LC239@ha
	la 7,.LC241@l(7)
	lfd 0,.LC239@l(9)
	mr 3,31
	lfs 13,0(7)
	fmuls 31,31,13
	fmr 2,31
	fmul 2,2,0
	frsp 2,2
	bl M_walkmove
.L174:
	lwz 0,68(1)
	mtlr 0
	lwz 31,52(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe49:
	.size	 barrel_touch,.Lfe49-barrel_touch
	.section	".rodata"
	.align 3
.LC242:
	.long 0x3fc99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl barrel_delay
	.type	 barrel_delay,@function
barrel_delay:
	li 0,0
	lis 11,level+4@ha
	stw 0,516(3)
	lis 10,.LC242@ha
	lis 9,barrel_explode@ha
	lfs 0,level+4@l(11)
	la 9,barrel_explode@l(9)
	lfd 13,.LC242@l(10)
	stw 5,556(3)
	stw 9,440(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(3)
	blr
.Lfe50:
	.size	 barrel_delay,.Lfe50-barrel_delay
	.align 2
	.globl misc_blackhole_use
	.type	 misc_blackhole_use,@function
misc_blackhole_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe51:
	.size	 misc_blackhole_use,.Lfe51-misc_blackhole_use
	.section	".rodata"
	.align 3
.LC243:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_blackhole_think
	.type	 misc_blackhole_think,@function
misc_blackhole_think:
	lwz 9,56(3)
	addi 9,9,1
	cmpwi 0,9,18
	stw 9,56(3)
	bc 12,1,.L190
	lis 9,level+4@ha
	lis 11,.LC243@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC243@l(11)
.L873:
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(3)
	blr
.L190:
	li 0,0
	lis 11,level+4@ha
	stw 0,56(3)
	lis 9,.LC243@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC243@l(9)
	b .L873
.Lfe52:
	.size	 misc_blackhole_think,.Lfe52-misc_blackhole_think
	.section	".rodata"
	.align 3
.LC244:
	.long 0x3fc99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_blackhole
	.type	 SP_misc_blackhole,@function
SP_misc_blackhole:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 11,0
	lis 10,0xc280
	lis 8,0x4280
	stw 11,248(29)
	li 0,0
	lis 9,0x4100
	stw 10,192(29)
	lis 28,gi@ha
	stw 0,196(29)
	lis 3,.LC89@ha
	la 28,gi@l(28)
	stw 11,264(29)
	la 3,.LC89@l(3)
	stw 10,188(29)
	stw 8,204(29)
	stw 9,208(29)
	stw 8,200(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 9,misc_blackhole_use@ha
	lis 11,misc_blackhole_think@ha
	stw 3,40(29)
	la 9,misc_blackhole_use@l(9)
	li 0,32
	la 11,misc_blackhole_think@l(11)
	stw 9,452(29)
	lis 10,level+4@ha
	stw 0,68(29)
	lis 9,.LC244@ha
	mr 3,29
	stw 11,440(29)
	lfs 0,level+4@l(10)
	lfd 13,.LC244@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe53:
	.size	 SP_misc_blackhole,.Lfe53-SP_misc_blackhole
	.section	".rodata"
	.align 3
.LC245:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_eastertank_think
	.type	 misc_eastertank_think,@function
misc_eastertank_think:
	lwz 9,56(3)
	addi 9,9,1
	cmpwi 0,9,292
	stw 9,56(3)
	bc 12,1,.L194
	lis 9,level+4@ha
	lis 11,.LC245@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC245@l(11)
.L874:
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(3)
	blr
.L194:
	li 0,254
	lis 11,level+4@ha
	stw 0,56(3)
	lis 9,.LC245@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC245@l(9)
	b .L874
.Lfe54:
	.size	 misc_eastertank_think,.Lfe54-misc_eastertank_think
	.section	".rodata"
	.align 3
.LC246:
	.long 0x3fc99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_eastertank
	.type	 SP_misc_eastertank,@function
SP_misc_eastertank:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	lis 0,0x4200
	lis 8,0xc200
	li 11,2
	stw 0,208(29)
	lis 10,0xc180
	li 9,0
	stw 11,248(29)
	lis 28,gi@ha
	stw 10,196(29)
	lis 3,.LC92@ha
	la 28,gi@l(28)
	stw 0,200(29)
	la 3,.LC92@l(3)
	stw 0,204(29)
	stw 9,264(29)
	stw 8,192(29)
	stw 8,188(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 9,misc_eastertank_think@ha
	li 0,254
	stw 3,40(29)
	la 9,misc_eastertank_think@l(9)
	stw 0,56(29)
	lis 10,level+4@ha
	stw 9,440(29)
	lis 11,.LC246@ha
	mr 3,29
	lfs 0,level+4@l(10)
	lfd 13,.LC246@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe55:
	.size	 SP_misc_eastertank,.Lfe55-SP_misc_eastertank
	.section	".rodata"
	.align 3
.LC247:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_easterchick_think
	.type	 misc_easterchick_think,@function
misc_easterchick_think:
	lwz 9,56(3)
	addi 9,9,1
	cmpwi 0,9,246
	stw 9,56(3)
	bc 12,1,.L198
	lis 9,level+4@ha
	lis 11,.LC247@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC247@l(11)
.L875:
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(3)
	blr
.L198:
	li 0,208
	lis 11,level+4@ha
	stw 0,56(3)
	lis 9,.LC247@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC247@l(9)
	b .L875
.Lfe56:
	.size	 misc_easterchick_think,.Lfe56-misc_easterchick_think
	.section	".rodata"
	.align 3
.LC248:
	.long 0x3fc99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_easterchick
	.type	 SP_misc_easterchick,@function
SP_misc_easterchick:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	lis 0,0x4200
	lis 8,0xc200
	li 11,2
	stw 0,208(29)
	li 10,0
	li 9,0
	stw 11,248(29)
	lis 28,gi@ha
	stw 10,196(29)
	lis 3,.LC95@ha
	la 28,gi@l(28)
	stw 0,200(29)
	la 3,.LC95@l(3)
	stw 0,204(29)
	stw 9,264(29)
	stw 8,192(29)
	stw 8,188(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 9,misc_easterchick_think@ha
	li 0,208
	stw 3,40(29)
	la 9,misc_easterchick_think@l(9)
	stw 0,56(29)
	lis 10,level+4@ha
	stw 9,440(29)
	lis 11,.LC248@ha
	mr 3,29
	lfs 0,level+4@l(10)
	lfd 13,.LC248@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe57:
	.size	 SP_misc_easterchick,.Lfe57-SP_misc_easterchick
	.section	".rodata"
	.align 3
.LC249:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_easterchick2_think
	.type	 misc_easterchick2_think,@function
misc_easterchick2_think:
	lwz 9,56(3)
	addi 9,9,1
	cmpwi 0,9,286
	stw 9,56(3)
	bc 12,1,.L202
	lis 9,level+4@ha
	lis 11,.LC249@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC249@l(11)
.L876:
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(3)
	blr
.L202:
	li 0,248
	lis 11,level+4@ha
	stw 0,56(3)
	lis 9,.LC249@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC249@l(9)
	b .L876
.Lfe58:
	.size	 misc_easterchick2_think,.Lfe58-misc_easterchick2_think
	.section	".rodata"
	.align 3
.LC250:
	.long 0x3fc99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_easterchick2
	.type	 SP_misc_easterchick2,@function
SP_misc_easterchick2:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	lis 0,0x4200
	lis 8,0xc200
	li 11,2
	stw 0,208(29)
	li 10,0
	li 9,0
	stw 11,248(29)
	lis 28,gi@ha
	stw 10,196(29)
	lis 3,.LC95@ha
	la 28,gi@l(28)
	stw 0,200(29)
	la 3,.LC95@l(3)
	stw 0,204(29)
	stw 9,264(29)
	stw 8,192(29)
	stw 8,188(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 9,misc_easterchick2_think@ha
	li 0,248
	stw 3,40(29)
	la 9,misc_easterchick2_think@l(9)
	stw 0,56(29)
	lis 10,level+4@ha
	stw 9,440(29)
	lis 11,.LC250@ha
	mr 3,29
	lfs 0,level+4@l(10)
	lfd 13,.LC250@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe59:
	.size	 SP_misc_easterchick2,.Lfe59-SP_misc_easterchick2
	.section	".rodata"
	.align 3
.LC251:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC252:
	.long 0x3f800000
	.align 2
.LC253:
	.long 0x0
	.section	".text"
	.align 2
	.globl commander_body_think
	.type	 commander_body_think,@function
commander_body_think:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,56(31)
	addi 9,9,1
	cmpwi 0,9,23
	stw 9,56(31)
	bc 12,1,.L206
	lis 9,level+4@ha
	lis 11,.LC251@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC251@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(31)
	b .L207
.L206:
	li 0,0
	stw 0,432(31)
.L207:
	lwz 0,56(31)
	cmpwi 0,0,22
	bc 4,2,.L208
	lis 29,gi@ha
	lis 3,.LC100@ha
	la 29,gi@l(29)
	la 3,.LC100@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC252@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC252@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC252@ha
	la 9,.LC252@l(9)
	lfs 2,0(9)
	lis 9,.LC253@ha
	la 9,.LC253@l(9)
	lfs 3,0(9)
	blrl
.L208:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe60:
	.size	 commander_body_think,.Lfe60-commander_body_think
	.section	".rodata"
	.align 3
.LC254:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC255:
	.long 0x3f800000
	.align 2
.LC256:
	.long 0x0
	.section	".text"
	.align 2
	.globl commander_body_use
	.type	 commander_body_use,@function
commander_body_use:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,commander_body_think@ha
	mr 28,3
	la 9,commander_body_think@l(9)
	lis 11,level+4@ha
	stw 9,440(28)
	lis 10,.LC254@ha
	lis 29,gi@ha
	lfs 0,level+4@l(11)
	la 29,gi@l(29)
	lis 3,.LC102@ha
	lfd 13,.LC254@l(10)
	la 3,.LC102@l(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(28)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC255@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC255@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,28
	mtlr 0
	lis 9,.LC255@ha
	la 9,.LC255@l(9)
	lfs 2,0(9)
	lis 9,.LC256@ha
	la 9,.LC256@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe61:
	.size	 commander_body_use,.Lfe61-commander_body_use
	.section	".rodata"
	.align 2
.LC257:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl commander_body_drop
	.type	 commander_body_drop,@function
commander_body_drop:
	lis 9,.LC257@ha
	lfs 0,12(3)
	li 0,7
	la 9,.LC257@l(9)
	stw 0,264(3)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,12(3)
	blr
.Lfe62:
	.size	 commander_body_drop,.Lfe62-commander_body_drop
	.section	".rodata"
	.align 3
.LC258:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_monster_commander_body
	.type	 SP_monster_commander_body,@function
SP_monster_commander_body:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,.LC103@ha
	mr 29,3
	la 9,.LC103@l(9)
	li 0,0
	li 11,2
	lis 28,gi@ha
	stw 0,264(29)
	la 28,gi@l(28)
	stw 11,248(29)
	mr 3,9
	stw 9,272(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lwz 11,68(29)
	lis 9,commander_body_use@ha
	lis 5,0xc200
	lis 6,0x4200
	lis 10,0x4240
	stw 5,192(29)
	ori 11,11,64
	li 0,0
	stw 10,208(29)
	li 7,1
	li 8,16
	stw 11,68(29)
	la 9,commander_body_use@l(9)
	stw 0,196(29)
	stw 6,204(29)
	stw 7,516(29)
	stw 8,268(29)
	stw 5,188(29)
	stw 6,200(29)
	stw 3,40(29)
	stw 9,452(29)
	mr 3,29
	lwz 9,72(28)
	mtlr 9
	blrl
	lwz 9,36(28)
	lis 3,.LC100@ha
	la 3,.LC100@l(3)
	mtlr 9
	blrl
	lwz 0,36(28)
	lis 3,.LC102@ha
	la 3,.LC102@l(3)
	mtlr 0
	blrl
	lis 9,commander_body_drop@ha
	lis 11,level+4@ha
	la 9,commander_body_drop@l(9)
	lis 10,.LC258@ha
	stw 9,440(29)
	la 10,.LC258@l(10)
	lfs 0,level+4@l(11)
	lfd 13,0(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe63:
	.size	 SP_monster_commander_body,.Lfe63-SP_monster_commander_body
	.section	".rodata"
	.align 3
.LC259:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_banner_think
	.type	 misc_banner_think,@function
misc_banner_think:
	lwz 9,56(3)
	lis 10,level+4@ha
	lis 11,.LC259@ha
	lfd 13,.LC259@l(11)
	addi 9,9,1
	srawi 0,9,31
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(3)
	lfs 0,level+4@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(3)
	blr
.Lfe64:
	.size	 misc_banner_think,.Lfe64-misc_banner_think
	.section	".rodata"
	.align 3
.LC260:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_banner
	.type	 SP_misc_banner,@function
SP_misc_banner:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 0,0
	lis 28,gi@ha
	stw 0,248(29)
	lis 3,.LC60@ha
	stw 0,264(29)
	la 28,gi@l(28)
	la 3,.LC60@l(3)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	bl rand
	mr 9,3
	srawi 0,9,31
	mr 3,29
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lis 9,misc_banner_think@ha
	lis 10,level+4@ha
	la 9,misc_banner_think@l(9)
	lis 11,.LC260@ha
	stw 9,440(29)
	lfs 0,level+4@l(10)
	lfd 13,.LC260@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe65:
	.size	 SP_misc_banner,.Lfe65-SP_misc_banner
	.section	".rodata"
	.align 3
.LC261:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_banner_generic
	.type	 SP_misc_banner_generic,@function
SP_misc_banner_generic:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 0,0
	lis 28,gi@ha
	stw 0,248(29)
	mr 3,4
	stw 0,264(29)
	la 28,gi@l(28)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	bl rand
	mr 9,3
	srawi 0,9,31
	mr 3,29
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lis 9,misc_banner_think@ha
	lis 10,level+4@ha
	la 9,misc_banner_think@l(9)
	lis 11,.LC261@ha
	stw 9,440(29)
	lfs 0,level+4@l(10)
	lfd 13,.LC261@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe66:
	.size	 SP_misc_banner_generic,.Lfe66-SP_misc_banner_generic
	.section	".rodata"
	.align 3
.LC262:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_banner_x_think
	.type	 misc_banner_x_think,@function
misc_banner_x_think:
	lwz 9,56(3)
	lis 10,level+4@ha
	lis 11,.LC262@ha
	lfd 13,.LC262@l(11)
	addi 9,9,1
	srawi 0,9,31
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(3)
	lfs 0,level+4@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(3)
	blr
.Lfe67:
	.size	 misc_banner_x_think,.Lfe67-misc_banner_x_think
	.section	".rodata"
	.align 3
.LC263:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_banner_x
	.type	 SP_misc_banner_x,@function
SP_misc_banner_x:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 0,0
	lis 28,gi@ha
	stw 0,248(29)
	lis 3,.LC108@ha
	stw 0,264(29)
	la 28,gi@l(28)
	la 3,.LC108@l(3)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	bl rand
	mr 9,3
	srawi 0,9,31
	mr 3,29
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lis 9,misc_banner_x_think@ha
	lis 10,level+4@ha
	la 9,misc_banner_x_think@l(9)
	lis 11,.LC263@ha
	stw 9,440(29)
	lfs 0,level+4@l(10)
	lfd 13,.LC263@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe68:
	.size	 SP_misc_banner_x,.Lfe68-SP_misc_banner_x
	.section	".rodata"
	.align 3
.LC264:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_banner_1
	.type	 SP_misc_banner_1,@function
SP_misc_banner_1:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 0,0
	lis 28,gi@ha
	stw 0,248(29)
	lis 3,.LC110@ha
	stw 0,264(29)
	la 28,gi@l(28)
	la 3,.LC110@l(3)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	bl rand
	mr 9,3
	srawi 0,9,31
	mr 3,29
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lis 9,misc_banner_think@ha
	lis 10,level+4@ha
	la 9,misc_banner_think@l(9)
	lis 11,.LC264@ha
	stw 9,440(29)
	lfs 0,level+4@l(10)
	lfd 13,.LC264@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe69:
	.size	 SP_misc_banner_1,.Lfe69-SP_misc_banner_1
	.section	".rodata"
	.align 3
.LC265:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_banner_2
	.type	 SP_misc_banner_2,@function
SP_misc_banner_2:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 0,0
	lis 28,gi@ha
	stw 0,248(29)
	lis 3,.LC112@ha
	stw 0,264(29)
	la 28,gi@l(28)
	la 3,.LC112@l(3)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	bl rand
	mr 9,3
	srawi 0,9,31
	mr 3,29
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lis 9,misc_banner_think@ha
	lis 10,level+4@ha
	la 9,misc_banner_think@l(9)
	lis 11,.LC265@ha
	stw 9,440(29)
	lfs 0,level+4@l(10)
	lfd 13,.LC265@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe70:
	.size	 SP_misc_banner_2,.Lfe70-SP_misc_banner_2
	.section	".rodata"
	.align 3
.LC266:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_banner_3
	.type	 SP_misc_banner_3,@function
SP_misc_banner_3:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 0,0
	lis 28,gi@ha
	stw 0,248(29)
	lis 3,.LC114@ha
	stw 0,264(29)
	la 28,gi@l(28)
	la 3,.LC114@l(3)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	bl rand
	mr 9,3
	srawi 0,9,31
	mr 3,29
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lis 9,misc_banner_think@ha
	lis 10,level+4@ha
	la 9,misc_banner_think@l(9)
	lis 11,.LC266@ha
	stw 9,440(29)
	lfs 0,level+4@l(10)
	lfd 13,.LC266@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe71:
	.size	 SP_misc_banner_3,.Lfe71-SP_misc_banner_3
	.section	".rodata"
	.align 3
.LC267:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_banner_4
	.type	 SP_misc_banner_4,@function
SP_misc_banner_4:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 0,0
	lis 28,gi@ha
	stw 0,248(29)
	lis 3,.LC116@ha
	stw 0,264(29)
	la 28,gi@l(28)
	la 3,.LC116@l(3)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	bl rand
	mr 9,3
	srawi 0,9,31
	mr 3,29
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lis 9,misc_banner_think@ha
	lis 10,level+4@ha
	la 9,misc_banner_think@l(9)
	lis 11,.LC267@ha
	stw 9,440(29)
	lfs 0,level+4@l(10)
	lfd 13,.LC267@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe72:
	.size	 SP_misc_banner_4,.Lfe72-SP_misc_banner_4
	.section	".rodata"
	.align 3
.LC268:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_banner_x_generic
	.type	 SP_misc_banner_x_generic,@function
SP_misc_banner_x_generic:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 0,0
	lis 28,gi@ha
	stw 0,248(29)
	mr 3,4
	stw 0,264(29)
	la 28,gi@l(28)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	bl rand
	mr 9,3
	srawi 0,9,31
	mr 3,29
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lis 9,misc_banner_x_think@ha
	lis 10,level+4@ha
	la 9,misc_banner_x_think@l(9)
	lis 11,.LC268@ha
	stw 9,440(29)
	lfs 0,level+4@l(10)
	lfd 13,.LC268@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe73:
	.size	 SP_misc_banner_x_generic,.Lfe73-SP_misc_banner_x_generic
	.section	".rodata"
	.align 3
.LC269:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_skeleton_think
	.type	 misc_skeleton_think,@function
misc_skeleton_think:
	lis 9,level+4@ha
	lis 11,.LC269@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC269@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(3)
	blr
.Lfe74:
	.size	 misc_skeleton_think,.Lfe74-misc_skeleton_think
	.section	".rodata"
	.align 3
.LC270:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_skeleton
	.type	 SP_misc_skeleton,@function
SP_misc_skeleton:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	li 0,0
	lis 29,gi@ha
	stw 0,248(28)
	lis 3,.LC120@ha
	la 29,gi@l(29)
	stw 0,264(28)
	la 3,.LC120@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	stw 3,40(28)
	lwz 0,72(29)
	mr 3,28
	mtlr 0
	blrl
	lis 9,misc_skeleton_think@ha
	lis 10,level+4@ha
	la 9,misc_skeleton_think@l(9)
	lis 11,.LC270@ha
	stw 9,440(28)
	lfs 0,level+4@l(10)
	lfd 13,.LC270@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(28)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe75:
	.size	 SP_misc_skeleton,.Lfe75-SP_misc_skeleton
	.section	".rodata"
	.align 3
.LC271:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_md2_think
	.type	 misc_md2_think,@function
misc_md2_think:
	lis 9,level+4@ha
	lis 11,.LC271@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC271@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(3)
	blr
.Lfe76:
	.size	 misc_md2_think,.Lfe76-misc_md2_think
	.section	".rodata"
	.align 3
.LC272:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_md2
	.type	 SP_misc_md2,@function
SP_misc_md2:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	li 0,0
	lis 29,gi@ha
	stw 0,248(28)
	la 29,gi@l(29)
	stw 0,264(28)
	lwz 9,32(29)
	lwz 3,272(28)
	mtlr 9
	blrl
	stw 3,40(28)
	lwz 0,72(29)
	mr 3,28
	mtlr 0
	blrl
	lis 9,misc_md2_think@ha
	lis 10,level+4@ha
	la 9,misc_md2_think@l(9)
	lis 11,.LC272@ha
	stw 9,440(28)
	lfs 0,level+4@l(10)
	lfd 13,.LC272@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(28)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe77:
	.size	 SP_misc_md2,.Lfe77-SP_misc_md2
	.section	".rodata"
	.align 3
.LC273:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_skeleton_generic
	.type	 SP_misc_skeleton_generic,@function
SP_misc_skeleton_generic:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 0,0
	lis 28,gi@ha
	stw 0,248(29)
	mr 3,4
	stw 0,264(29)
	la 28,gi@l(28)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	bl rand
	mr 9,3
	srawi 0,9,31
	mr 3,29
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lis 9,misc_skeleton_think@ha
	lis 10,level+4@ha
	la 9,misc_skeleton_think@l(9)
	lis 11,.LC273@ha
	stw 9,440(29)
	lfs 0,level+4@l(10)
	lfd 13,.LC273@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe78:
	.size	 SP_misc_skeleton_generic,.Lfe78-SP_misc_skeleton_generic
	.section	".rodata"
	.align 2
.LC274:
	.long 0x3f800000
	.align 2
.LC275:
	.long 0x0
	.section	".text"
	.align 2
	.globl misc_deadsoldier_die
	.type	 misc_deadsoldier_die,@function
misc_deadsoldier_die:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	mr 28,6
	lwz 9,484(31)
	lwz 0,492(31)
	cmpw 0,9,0
	bc 12,1,.L227
	lis 29,gi@ha
	lis 3,.LC125@ha
	la 29,gi@l(29)
	la 3,.LC125@l(3)
	lwz 9,36(29)
	lis 27,.LC126@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC274@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC274@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC274@ha
	la 9,.LC274@l(9)
	lfs 2,0(9)
	lis 9,.LC275@ha
	la 9,.LC275@l(9)
	lfs 3,0(9)
	blrl
.L232:
	mr 3,31
	la 4,.LC126@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L232
	lis 4,.LC36@ha
	mr 3,31
	la 4,.LC36@l(4)
	mr 5,28
	li 6,0
	bl ThrowHead
.L227:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe79:
	.size	 misc_deadsoldier_die,.Lfe79-misc_deadsoldier_die
	.align 2
	.globl misc_viper_use
	.type	 misc_viper_use,@function
misc_viper_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lis 11,train_use@ha
	lwz 0,184(9)
	la 11,train_use@l(11)
	stw 11,452(9)
	rlwinm 0,0,0,0,30
	stw 0,184(9)
	bl train_use
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe80:
	.size	 misc_viper_use,.Lfe80-misc_viper_use
	.align 2
	.globl SP_misc_bigviper
	.type	 SP_misc_bigviper,@function
SP_misc_bigviper:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 0,0
	li 9,2
	stw 0,264(29)
	lis 11,0xc330
	stw 9,248(29)
	lis 0,0xc1c0
	lis 10,0xc2f0
	lis 8,0x4330
	lis 7,0x42f0
	stw 0,196(29)
	lis 9,0x4290
	lis 28,gi@ha
	stw 11,188(29)
	la 28,gi@l(28)
	stw 10,192(29)
	lis 3,.LC131@ha
	stw 8,200(29)
	la 3,.LC131@l(3)
	stw 7,204(29)
	stw 9,208(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	lwz 0,72(28)
	mr 3,29
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe81:
	.size	 SP_misc_bigviper,.Lfe81-SP_misc_bigviper
	.section	".rodata"
	.align 3
.LC276:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC277:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl misc_viper_bomb_touch
	.type	 misc_viper_bomb_touch,@function
misc_viper_bomb_touch:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 28,3
	lwz 4,556(28)
	addi 27,28,4
	bl G_UseTargets
	lwz 9,520(28)
	lis 8,0x4330
	mr 11,10
	lis 7,.LC276@ha
	lfs 12,220(28)
	xoris 0,9,0x8000
	la 7,.LC276@l(7)
	stw 0,20(1)
	addi 9,9,40
	li 5,0
	stw 8,16(1)
	xoris 9,9,0x8000
	li 6,27
	lfd 1,16(1)
	mr 4,28
	mr 3,28
	stw 9,20(1)
	lfd 13,0(7)
	stw 8,16(1)
	lis 7,.LC277@ha
	lfd 2,16(1)
	la 7,.LC277@l(7)
	lfs 0,0(7)
	fsub 1,1,13
	fsub 2,2,13
	fadds 12,12,0
	frsp 1,1
	frsp 2,2
	stfs 12,12(28)
	bl T_RadiusDamage
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,6
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	mr 3,28
	bl G_FreeEdict
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe82:
	.size	 misc_viper_bomb_touch,.Lfe82-misc_viper_bomb_touch
	.section	".rodata"
	.align 3
.LC278:
	.long 0xbff00000
	.long 0x0
	.align 2
.LC279:
	.long 0xbf800000
	.align 3
.LC280:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC281:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl misc_viper_bomb_prethink
	.type	 misc_viper_bomb_prethink,@function
misc_viper_bomb_prethink:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stw 31,36(1)
	stw 0,52(1)
	mr 31,3
	li 0,0
	stw 0,560(31)
	lis 9,level+4@ha
	lis 11,.LC278@ha
	lfs 12,level+4@l(9)
	la 11,.LC278@l(11)
	lfs 13,292(31)
	lfd 11,0(11)
	fsubs 31,13,12
	fmr 0,31
	fcmpu 0,0,11
	bc 4,0,.L253
	lis 9,.LC279@ha
	la 9,.LC279@l(9)
	lfs 31,0(9)
.L253:
	lis 11,.LC280@ha
	fmr 1,31
	addi 4,1,8
	la 11,.LC280@l(11)
	addi 3,31,780
	lfd 0,0(11)
	fadd 1,1,0
	frsp 1,1
	bl VectorScale
	stfs 31,16(1)
	addi 3,1,8
	addi 4,31,16
	lfs 31,24(31)
	bl vectoangles
	lis 9,.LC281@ha
	la 9,.LC281@l(9)
	lfs 0,0(9)
	fadds 0,31,0
	stfs 0,24(31)
	lwz 0,52(1)
	mtlr 0
	lwz 31,36(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe83:
	.size	 misc_viper_bomb_prethink,.Lfe83-misc_viper_bomb_prethink
	.align 2
	.globl misc_viper_bomb_use
	.type	 misc_viper_bomb_use,@function
misc_viper_bomb_use:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	lis 10,misc_viper_bomb_prethink@ha
	lwz 0,184(29)
	lis 11,misc_viper_bomb_touch@ha
	li 9,2
	stw 5,556(29)
	la 10,misc_viper_bomb_prethink@l(10)
	la 11,misc_viper_bomb_touch@l(11)
	rlwinm 0,0,0,0,30
	li 8,0
	stw 9,248(29)
	li 7,7
	lis 5,.LC132@ha
	stw 0,184(29)
	la 5,.LC132@l(5)
	stw 8,452(29)
	li 4,284
	stw 7,264(29)
	li 3,0
	stw 10,436(29)
	stw 11,448(29)
	bl G_Find
	mr 28,3
	addi 4,29,380
	lfs 1,760(28)
	addi 3,28,780
	bl VectorScale
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	stfs 0,292(29)
	lfs 13,780(28)
	stfs 13,780(29)
	lfs 0,784(28)
	stfs 0,784(29)
	lfs 13,788(28)
	stfs 13,788(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe84:
	.size	 misc_viper_bomb_use,.Lfe84-misc_viper_bomb_use
	.align 2
	.globl SP_misc_viper_bomb
	.type	 SP_misc_viper_bomb,@function
SP_misc_viper_bomb:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lis 0,0xc100
	lis 11,0x4100
	li 10,0
	stw 0,196(31)
	lis 9,gi@ha
	stw 0,188(31)
	lis 3,.LC133@ha
	stw 0,192(31)
	la 30,gi@l(9)
	la 3,.LC133@l(3)
	stw 10,248(31)
	stw 11,208(31)
	stw 10,264(31)
	stw 11,200(31)
	stw 11,204(31)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,520(31)
	stw 3,40(31)
	cmpwi 0,0,0
	bc 4,2,.L256
	li 0,1000
	stw 0,520(31)
.L256:
	lwz 0,184(31)
	lis 9,misc_viper_bomb_use@ha
	mr 3,31
	la 9,misc_viper_bomb_use@l(9)
	ori 0,0,1
	stw 9,452(31)
	stw 0,184(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe85:
	.size	 SP_misc_viper_bomb,.Lfe85-SP_misc_viper_bomb
	.align 2
	.globl misc_strogg_ship_use
	.type	 misc_strogg_ship_use,@function
misc_strogg_ship_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lis 11,train_use@ha
	lwz 0,184(9)
	la 11,train_use@l(11)
	stw 11,452(9)
	rlwinm 0,0,0,0,30
	stw 0,184(9)
	bl train_use
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe86:
	.size	 misc_strogg_ship_use,.Lfe86-misc_strogg_ship_use
	.section	".rodata"
	.align 3
.LC282:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_satellite_dish_think
	.type	 misc_satellite_dish_think,@function
misc_satellite_dish_think:
	lwz 9,56(3)
	addi 9,9,1
	cmpwi 0,9,37
	stw 9,56(3)
	bclr 12,1
	lis 9,level+4@ha
	lis 11,.LC282@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC282@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(3)
	blr
.Lfe87:
	.size	 misc_satellite_dish_think,.Lfe87-misc_satellite_dish_think
	.section	".rodata"
	.align 3
.LC283:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_satellite_dish_use
	.type	 misc_satellite_dish_use,@function
misc_satellite_dish_use:
	lis 9,misc_satellite_dish_think@ha
	li 0,0
	la 9,misc_satellite_dish_think@l(9)
	stw 0,56(3)
	lis 11,level+4@ha
	stw 9,440(3)
	lis 10,.LC283@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC283@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,432(3)
	blr
.Lfe88:
	.size	 misc_satellite_dish_use,.Lfe88-misc_satellite_dish_use
	.align 2
	.globl SP_misc_satellite_dish
	.type	 SP_misc_satellite_dish,@function
SP_misc_satellite_dish:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	lis 8,0xc280
	lis 7,0x4280
	li 0,0
	stw 8,192(29)
	li 9,2
	li 11,0
	stw 0,264(29)
	lis 10,0x4300
	lis 28,gi@ha
	stw 9,248(29)
	la 28,gi@l(28)
	stw 11,196(29)
	lis 3,.LC140@ha
	stw 7,204(29)
	la 3,.LC140@l(3)
	stw 10,208(29)
	stw 8,188(29)
	stw 7,200(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 9,misc_satellite_dish_use@ha
	stw 3,40(29)
	la 9,misc_satellite_dish_use@l(9)
	mr 3,29
	stw 9,452(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe89:
	.size	 SP_misc_satellite_dish,.Lfe89-SP_misc_satellite_dish
	.align 2
	.globl SP_light_mine1
	.type	 SP_light_mine1,@function
SP_light_mine1:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	li 0,0
	li 9,2
	lis 29,gi@ha
	stw 0,264(28)
	la 29,gi@l(29)
	stw 9,248(28)
	lis 3,.LC141@ha
	lwz 9,32(29)
	la 3,.LC141@l(3)
	mtlr 9
	blrl
	stw 3,40(28)
	lwz 0,72(29)
	mr 3,28
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe90:
	.size	 SP_light_mine1,.Lfe90-SP_light_mine1
	.align 2
	.globl SP_light_mine2
	.type	 SP_light_mine2,@function
SP_light_mine2:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	li 0,0
	li 9,2
	lis 29,gi@ha
	stw 0,264(28)
	la 29,gi@l(29)
	stw 9,248(28)
	lis 3,.LC142@ha
	lwz 9,32(29)
	la 3,.LC142@l(3)
	mtlr 9
	blrl
	stw 3,40(28)
	lwz 0,72(29)
	mr 3,28
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe91:
	.size	 SP_light_mine2,.Lfe91-SP_light_mine2
	.align 2
	.globl SP_target_character
	.type	 SP_target_character,@function
SP_target_character:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 0,2
	lis 28,gi@ha
	stw 0,264(29)
	la 28,gi@l(28)
	lwz 4,272(29)
	lwz 9,44(28)
	mtlr 9
	blrl
	li 0,3
	li 9,12
	stw 0,248(29)
	mr 3,29
	stw 9,56(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe92:
	.size	 SP_target_character,.Lfe92-SP_target_character
	.align 2
	.globl target_string_use
	.type	 target_string_use,@function
target_string_use:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 3,280(31)
	bl strlen
	lwz 10,572(31)
	cmpwi 0,10,0
	bc 12,2,.L273
	li 8,12
	li 6,10
	li 7,11
.L275:
	lwz 9,536(10)
	cmpwi 0,9,0
	bc 12,2,.L274
	addi 11,9,-1
	cmpw 0,11,3
	bc 12,1,.L282
	lwz 9,280(31)
	lbzx 9,9,11
	addi 11,9,-48
	rlwinm 0,11,0,0xff
	cmplwi 0,0,9
	bc 12,1,.L278
	stw 11,56(10)
	b .L274
.L278:
	cmpwi 0,9,45
	bc 4,2,.L280
	stw 6,56(10)
	b .L274
.L280:
	cmpwi 0,9,58
	bc 4,2,.L282
	stw 7,56(10)
	b .L274
.L282:
	stw 8,56(10)
.L274:
	lwz 10,568(10)
	cmpwi 0,10,0
	bc 4,2,.L275
.L273:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe93:
	.size	 target_string_use,.Lfe93-target_string_use
	.align 2
	.globl SP_target_string
	.type	 SP_target_string,@function
SP_target_string:
	lwz 0,280(3)
	cmpwi 0,0,0
	bc 4,2,.L286
	lis 9,.LC158@ha
	la 9,.LC158@l(9)
	stw 9,280(3)
.L286:
	lis 9,target_string_use@ha
	la 9,target_string_use@l(9)
	stw 9,452(3)
	blr
.Lfe94:
	.size	 SP_target_string,.Lfe94-SP_target_string
	.align 2
	.globl func_clock_use
	.type	 func_clock_use,@function
func_clock_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lwz 0,288(9)
	andi. 0,0,8
	bc 4,2,.L318
	stw 0,452(9)
.L318:
	lwz 0,556(9)
	cmpwi 0,0,0
	bc 4,2,.L317
	lwz 11,440(9)
	mr 3,9
	stw 5,556(9)
	mtlr 11
	blrl
.L317:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe95:
	.size	 func_clock_use,.Lfe95-func_clock_use
	.align 2
	.globl SP_misc_teleporter_dest
	.type	 SP_misc_teleporter_dest,@function
SP_misc_teleporter_dest:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 28,gi@ha
	mr 29,3
	la 28,gi@l(28)
	lis 4,.LC173@ha
	lwz 9,44(28)
	la 4,.LC173@l(4)
	mtlr 9
	blrl
	lis 8,0xc200
	lis 7,0x4200
	li 0,0
	li 9,2
	stw 8,192(29)
	lis 11,0xc1c0
	lis 10,0xc180
	stw 0,60(29)
	stw 9,248(29)
	mr 3,29
	stw 11,196(29)
	stw 7,204(29)
	stw 10,208(29)
	stw 8,188(29)
	stw 7,200(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe96:
	.size	 SP_misc_teleporter_dest,.Lfe96-SP_misc_teleporter_dest
	.align 2
	.globl strcmpwld
	.type	 strcmpwld,@function
strcmpwld:
	stwu 1,-160(1)
	mflr 0
	stmw 23,124(1)
	stw 0,164(1)
	mr 27,3
	mr 25,4
	li 29,0
	bl strlen
	mr 26,3
	mr 3,25
	bl strlen
	cmpw 0,29,26
	mr 24,3
	bc 4,0,.L346
	li 23,0
.L348:
	add 0,24,29
	stb 23,8(1)
	mr 31,29
	cmpw 0,29,0
	mr 30,0
	bc 4,0,.L350
	lis 28,.LC178@ha
.L352:
	lbzx 3,27,31
	addi 31,31,1
	crxor 6,6,6
	bl tolower
	mr 7,3
	li 4,100
	addi 3,1,8
	la 5,.LC178@l(28)
	mr 6,3
	crxor 6,6,6
	bl Com_sprintf
	cmpw 0,31,30
	bc 12,0,.L352
.L350:
	mr 3,25
	addi 4,1,8
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L347
	li 3,1
	b .L877
.L347:
	addi 29,29,1
	cmpw 0,29,26
	bc 12,0,.L348
.L346:
	li 3,0
.L877:
	lwz 0,164(1)
	mtlr 0
	lmw 23,124(1)
	la 1,160(1)
	blr
.Lfe97:
	.size	 strcmpwld,.Lfe97-strcmpwld
	.align 2
	.type	 light_use,@function
light_use:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,288(31)
	andi. 9,0,1
	bc 12,2,.L113
	lis 9,gi+24@ha
	lwz 3,660(31)
	lis 4,.LC61@ha
	lwz 0,gi+24@l(9)
	la 4,.LC61@l(4)
	addi 3,3,800
	mtlr 0
	blrl
	lwz 0,288(31)
	rlwinm 0,0,0,0,30
	b .L878
.L113:
	lis 9,gi+24@ha
	lwz 3,660(31)
	lis 4,.LC62@ha
	lwz 0,gi+24@l(9)
	la 4,.LC62@l(4)
	addi 3,3,800
	mtlr 0
	blrl
	lwz 0,288(31)
	ori 0,0,1
.L878:
	stw 0,288(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe98:
	.size	 light_use,.Lfe98-light_use
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
