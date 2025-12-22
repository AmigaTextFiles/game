	.file	"g_misc.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC6:
	.long 0x46fffe00
	.align 2
.LC7:
	.long 0x3f333333
	.align 2
.LC8:
	.long 0x3f99999a
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC10:
	.long 0x3f000000
	.align 3
.LC11:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC12:
	.long 0x40590000
	.long 0x0
	.align 3
.LC13:
	.long 0x40690000
	.long 0x0
	.align 2
.LC14:
	.long 0xc3960000
	.align 2
.LC15:
	.long 0x43960000
	.align 2
.LC16:
	.long 0x43480000
	.align 2
.LC17:
	.long 0x43fa0000
	.align 2
.LC18:
	.long 0x44160000
	.align 2
.LC19:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl ThrowGib
	.type	 ThrowGib,@function
ThrowGib:
	stwu 1,-144(1)
	mflr 0
	stfd 28,112(1)
	stfd 29,120(1)
	stfd 30,128(1)
	stfd 31,136(1)
	stmw 26,88(1)
	stw 0,148(1)
	mr 27,6
	mr 26,5
	mr 30,3
	mr 28,4
	bl G_Spawn
	lis 29,0x4330
	lis 10,.LC10@ha
	lis 9,.LC9@ha
	la 10,.LC10@l(10)
	mr 31,3
	lfs 1,0(10)
	la 9,.LC9@l(9)
	addi 4,1,40
	lfd 30,0(9)
	addi 3,30,236
	bl VectorScale
	lfs 11,40(1)
	lis 9,.LC11@ha
	lfs 13,212(30)
	la 9,.LC11@l(9)
	lfs 12,216(30)
	lfs 10,44(1)
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
	lis 11,.LC6@ha
	lfs 12,40(1)
	stw 3,84(1)
	stw 29,80(1)
	lfd 13,80(1)
	lfs 29,.LC6@l(11)
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
	stw 3,84(1)
	stw 29,80(1)
	lfd 13,80(1)
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
	lis 11,gi+44@ha
	stw 3,84(1)
	mr 4,28
	stw 29,80(1)
	mr 3,31
	lfd 13,80(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,12(31)
	lwz 0,gi+44@l(11)
	mtlr 0
	blrl
	lwz 9,64(31)
	lis 11,gib_die@ha
	cmpwi 0,27,0
	lwz 0,264(31)
	la 11,gib_die@l(11)
	li 10,0
	ori 9,9,2
	li 8,1
	stw 10,248(31)
	ori 0,0,2048
	stw 9,64(31)
	stw 0,264(31)
	stw 8,512(31)
	stw 11,456(31)
	bc 4,2,.L29
	lis 9,gib_touch@ha
	li 0,7
	la 9,gib_touch@l(9)
	stw 0,260(31)
	lis 27,0x3f00
	stw 9,444(31)
	b .L30
.L29:
	li 0,9
	lis 27,0x3f80
	stw 0,260(31)
.L30:
	bl rand
	lis 29,0x4330
	lis 9,.LC9@ha
	rlwinm 3,3,0,17,31
	la 9,.LC9@l(9)
	xoris 3,3,0x8000
	lfd 30,0(9)
	lis 11,.LC6@ha
	lis 10,.LC11@ha
	lfs 28,.LC6@l(11)
	la 10,.LC11@l(10)
	stw 3,84(1)
	addi 28,1,8
	stw 29,80(1)
	lfd 13,80(1)
	lfd 29,0(10)
	lis 10,.LC12@ha
	fsub 13,13,30
	la 10,.LC12@l(10)
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
	stw 3,84(1)
	stw 29,80(1)
	lfd 13,80(1)
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
	lis 10,.LC13@ha
	stw 3,84(1)
	la 10,.LC13@l(10)
	cmpwi 0,26,49
	stw 29,80(1)
	lfd 0,80(1)
	lfd 12,0(10)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,28
	fmr 13,0
	fmadd 13,13,31,12
	frsp 13,13
	stfs 13,8(28)
	bc 12,1,.L31
	lis 9,.LC7@ha
	mr 3,28
	lfs 1,.LC7@l(9)
	mr 4,3
	bl VectorScale
	b .L33
.L31:
	lis 9,.LC8@ha
	mr 3,28
	lfs 1,.LC8@l(9)
	mr 4,3
	bl VectorScale
.L33:
	stw 27,56(1)
	addi 3,30,376
	addi 4,1,8
	lfs 0,56(1)
	addi 5,31,376
	fmr 1,0
	bl VectorMA
	lis 9,.LC14@ha
	lfs 0,376(31)
	la 9,.LC14@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L44
	lis 10,.LC15@ha
	la 10,.LC15@l(10)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 4,1,.L35
.L44:
	stfs 13,376(31)
.L35:
	lis 11,.LC14@ha
	lfs 0,380(31)
	la 11,.LC14@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,0,.L45
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L38
.L45:
	stfs 13,380(31)
.L38:
	lis 10,.LC16@ha
	lfs 0,384(31)
	la 10,.LC16@l(10)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,0,.L46
	lis 11,.LC17@ha
	la 11,.LC17@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L43
.L46:
	stfs 13,384(31)
.L43:
	bl rand
	lis 29,0x4330
	lis 9,.LC9@ha
	rlwinm 3,3,0,17,31
	la 9,.LC9@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC6@ha
	lis 10,.LC18@ha
	lfs 29,.LC6@l(11)
	la 10,.LC18@l(10)
	stw 3,84(1)
	stw 29,80(1)
	lfd 0,80(1)
	lfs 30,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmuls 0,0,30
	stfs 0,388(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,84(1)
	stw 29,80(1)
	lfd 0,80(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmuls 0,0,30
	stfs 0,392(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 9,G_FreeEdict@ha
	stw 3,84(1)
	la 9,G_FreeEdict@l(9)
	stw 29,80(1)
	lfd 0,80(1)
	stw 9,436(31)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmuls 0,0,30
	stfs 0,396(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC19@ha
	stw 3,84(1)
	la 10,.LC19@l(10)
	lis 11,level+4@ha
	stw 29,80(1)
	mr 3,31
	lfd 0,80(1)
	lfs 12,0(10)
	lfs 13,level+4@l(11)
	lis 10,gi+72@ha
	fsub 0,0,31
	fadds 13,13,12
	frsp 0,0
	fdivs 0,0,29
	fmadds 0,0,12,13
	stfs 0,428(31)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	lwz 0,148(1)
	mtlr 0
	lmw 26,88(1)
	lfd 28,112(1)
	lfd 29,120(1)
	lfd 30,128(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe1:
	.size	 ThrowGib,.Lfe1-ThrowGib
	.section	".rodata"
	.align 2
.LC20:
	.long 0x46fffe00
	.align 2
.LC21:
	.long 0x3f333333
	.align 2
.LC22:
	.long 0x3f99999a
	.align 3
.LC23:
	.long 0x4082c000
	.long 0x0
	.align 3
.LC24:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC25:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC26:
	.long 0x40590000
	.long 0x0
	.align 3
.LC27:
	.long 0x40690000
	.long 0x0
	.align 2
.LC28:
	.long 0xc3960000
	.align 2
.LC29:
	.long 0x43960000
	.align 2
.LC30:
	.long 0x43480000
	.align 2
.LC31:
	.long 0x43fa0000
	.align 2
.LC32:
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
	lwz 11,264(31)
	la 10,gib_die@l(10)
	li 8,1
	lwz 9,184(31)
	ori 0,0,2
	ori 11,11,2048
	rlwinm 0,0,0,18,16
	stw 29,76(31)
	rlwinm 9,9,0,30,28
	stw 0,64(31)
	stw 11,264(31)
	stw 9,184(31)
	stw 8,512(31)
	stw 10,456(31)
	stw 29,248(31)
	bc 4,2,.L48
	lis 9,gib_touch@ha
	li 0,7
	la 9,gib_touch@l(9)
	stw 0,260(31)
	lis 27,0x3f00
	stw 9,444(31)
	b .L49
.L48:
	li 0,9
	lis 27,0x3f80
	stw 0,260(31)
.L49:
	bl rand
	lis 29,0x4330
	lis 9,.LC24@ha
	rlwinm 3,3,0,17,31
	la 9,.LC24@l(9)
	xoris 3,3,0x8000
	lfd 30,0(9)
	lis 11,.LC20@ha
	lis 10,.LC25@ha
	lfs 28,.LC20@l(11)
	la 10,.LC25@l(10)
	stw 3,52(1)
	addi 28,1,8
	stw 29,48(1)
	lfd 13,48(1)
	lfd 29,0(10)
	lis 10,.LC26@ha
	fsub 13,13,30
	la 10,.LC26@l(10)
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
	lis 10,.LC27@ha
	stw 3,52(1)
	la 10,.LC27@l(10)
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
	lis 9,.LC21@ha
	mr 3,28
	lfs 1,.LC21@l(9)
	mr 4,3
	bl VectorScale
	b .L52
.L50:
	lis 9,.LC22@ha
	mr 3,28
	lfs 1,.LC22@l(9)
	mr 4,3
	bl VectorScale
.L52:
	stw 27,24(1)
	addi 3,31,376
	addi 4,1,8
	lfs 0,24(1)
	mr 5,3
	fmr 1,0
	bl VectorMA
	lis 9,.LC28@ha
	lfs 0,376(31)
	la 9,.LC28@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L63
	lis 10,.LC29@ha
	la 10,.LC29@l(10)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 4,1,.L54
.L63:
	stfs 13,376(31)
.L54:
	lis 11,.LC28@ha
	lfs 0,380(31)
	la 11,.LC28@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,0,.L64
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L57
.L64:
	stfs 13,380(31)
.L57:
	lis 10,.LC30@ha
	lfs 0,384(31)
	la 10,.LC30@l(10)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,0,.L65
	lis 11,.LC31@ha
	la 11,.LC31@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L62
.L65:
	stfs 13,384(31)
.L62:
	bl rand
	lis 29,0x4330
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 9,.LC24@ha
	stw 3,52(1)
	la 9,.LC24@l(9)
	lis 8,.LC20@ha
	stw 29,48(1)
	lis 10,.LC25@ha
	lfd 31,0(9)
	la 10,.LC25@l(10)
	lfd 13,48(1)
	lis 9,G_FreeEdict@ha
	lfs 30,.LC20@l(8)
	la 9,G_FreeEdict@l(9)
	lfd 11,0(10)
	fsub 13,13,31
	lis 10,.LC23@ha
	stw 9,436(31)
	lfd 12,.LC23@l(10)
	frsp 13,13
	fdivs 13,13,30
	fmr 0,13
	fsub 0,0,11
	fadd 0,0,0
	fmul 0,0,12
	frsp 0,0
	stfs 0,392(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC32@ha
	stw 3,52(1)
	la 10,.LC32@l(10)
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
	stfs 0,428(31)
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
.LC33:
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC34:
	.string	"models/objects/gibs/skull/tris.md2"
	.align 2
.LC35:
	.long 0x46fffe00
	.align 2
.LC36:
	.long 0x3f333333
	.align 2
.LC37:
	.long 0x3f99999a
	.align 2
.LC38:
	.long 0x42000000
	.align 3
.LC39:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC40:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC41:
	.long 0x40590000
	.long 0x0
	.align 3
.LC42:
	.long 0x40690000
	.long 0x0
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
	lis 9,.LC33@ha
	li 0,1
	la 4,.LC33@l(9)
	stw 0,60(31)
	b .L68
.L67:
	lis 9,.LC34@ha
	stw 3,60(31)
	la 4,.LC34@l(9)
.L68:
	lis 9,.LC38@ha
	lfs 0,12(31)
	lis 11,.LC39@ha
	la 9,.LC38@l(9)
	li 29,0
	lfs 13,0(9)
	la 11,.LC39@l(11)
	mr 3,31
	lfd 31,0(11)
	lis 9,gi+44@ha
	addi 30,1,8
	stw 29,56(31)
	lis 11,.LC40@ha
	lis 28,0x4330
	fadds 0,0,13
	la 11,.LC40@l(11)
	lfd 28,0(11)
	lis 11,.LC41@ha
	stfs 0,12(31)
	la 11,.LC41@l(11)
	lwz 0,gi+44@l(9)
	lfd 30,0(11)
	mtlr 0
	blrl
	lwz 0,264(31)
	lis 9,0x4180
	lis 7,0xc180
	li 10,2
	li 8,9
	stw 7,192(31)
	ori 0,0,2048
	li 11,0
	stw 10,64(31)
	stw 0,264(31)
	stw 8,260(31)
	stw 7,188(31)
	stw 11,196(31)
	stw 9,208(31)
	stw 9,200(31)
	stw 9,204(31)
	stw 29,76(31)
	stw 29,512(31)
	stw 29,248(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC35@ha
	stw 3,36(1)
	stw 28,32(1)
	lfd 13,32(1)
	lfs 29,.LC35@l(11)
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
	lis 11,.LC42@ha
	stw 3,36(1)
	la 11,.LC42@l(11)
	cmpwi 0,27,49
	stw 28,32(1)
	lfd 0,32(1)
	lfd 12,0(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fmadd 13,13,30,12
	frsp 13,13
	stfs 13,8(30)
	bc 12,1,.L69
	lis 9,.LC36@ha
	mr 3,30
	lfs 1,.LC36@l(9)
	mr 4,3
	bl VectorScale
	b .L71
.L69:
	lis 9,.LC37@ha
	mr 3,30
	lfs 1,.LC37@l(9)
	mr 4,3
	bl VectorScale
.L71:
	lfs 11,8(1)
	lfs 10,12(1)
	lfs 9,16(1)
	lfs 0,376(31)
	lfs 13,380(31)
	lfs 12,384(31)
	lwz 9,84(31)
	fadds 0,0,11
	fadds 13,13,10
	fadds 12,12,9
	cmpwi 0,9,0
	stfs 0,376(31)
	stfs 13,380(31)
	stfs 12,384(31)
	bc 12,2,.L72
	li 0,5
	stw 0,4312(9)
	lwz 9,84(31)
	lwz 0,56(31)
	stw 0,4308(9)
	b .L73
.L72:
	li 0,0
	stw 9,436(31)
	stw 0,428(31)
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
.LC44:
	.string	"debris"
	.align 2
.LC43:
	.long 0x46fffe00
	.align 3
.LC45:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC46:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC47:
	.long 0x40590000
	.long 0x0
	.align 2
.LC48:
	.long 0x44160000
	.align 2
.LC49:
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
	lis 9,.LC45@ha
	la 9,.LC45@l(9)
	lis 25,gi@ha
	lfd 31,0(9)
	la 25,gi@l(25)
	lis 11,.LC46@ha
	stfs 0,4(29)
	lis 9,.LC47@ha
	la 11,.LC46@l(11)
	lfs 13,4(28)
	la 9,.LC47@l(9)
	mr 4,27
	lfd 30,0(9)
	li 27,0
	lfd 29,0(11)
	stfs 13,8(29)
	lis 11,.LC48@ha
	lfs 0,8(28)
	la 11,.LC48@l(11)
	lfs 27,0(11)
	stfs 0,12(29)
	lwz 9,44(25)
	mtlr 9
	blrl
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC43@ha
	stw 3,28(1)
	stw 26,24(1)
	lfd 13,24(1)
	lfs 28,.LC43@l(11)
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
	addi 5,29,376
	stw 3,28(1)
	addi 4,1,8
	stw 26,24(1)
	addi 3,24,376
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
	stw 0,260(29)
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
	stfs 0,388(29)
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
	lis 9,G_FreeEdict@ha
	stw 3,28(1)
	la 9,G_FreeEdict@l(9)
	stw 26,24(1)
	lfd 0,24(1)
	stw 9,436(29)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,28
	fmuls 0,0,27
	stfs 0,396(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC49@ha
	stw 3,28(1)
	la 11,.LC49@l(11)
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
	lis 11,.LC44@ha
	stw 27,264(29)
	la 11,.LC44@l(11)
	stw 0,512(29)
	fadds 13,13,12
	stw 11,280(29)
	frsp 0,0
	stw 10,456(29)
	stw 27,56(29)
	fdivs 0,0,28
	fmadds 0,0,12,13
	stfs 0,428(29)
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
.LC50:
	.string	"item_flag_team1"
	.align 2
.LC51:
	.string	"The %s flag has returned!\n"
	.align 2
.LC52:
	.string	"item_flag_team2"
	.section	".text"
	.align 2
	.globl BecomeExplosion2
	.type	 BecomeExplosion2,@function
BecomeExplosion2:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lis 4,.LC50@ha
	lwz 3,280(31)
	la 4,.LC50@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,1
	bc 12,2,.L81
	lwz 3,280(31)
	lis 4,.LC52@ha
	la 4,.LC52@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L79
	li 3,2
.L81:
	bl CTFResetFlag
	li 3,1
	bl CTFTeamName
	mr 5,3
	lis 4,.LC51@ha
	la 4,.LC51@l(4)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
	b .L77
.L79:
	lwz 9,648(31)
	cmpwi 0,9,0
	bc 12,2,.L80
	lwz 0,56(9)
	andi. 9,0,64
	bc 12,2,.L80
	mr 3,31
	bl CTFRespawnTech
	b .L77
.L80:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	addi 28,31,4
	lwz 9,100(29)
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
	mr 3,31
	bl G_FreeEdict
.L77:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 BecomeExplosion2,.Lfe5-BecomeExplosion2
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
	lwz 0,416(31)
	cmpw 0,0,30
	bc 4,2,.L82
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L82
	lwz 0,312(30)
	cmpwi 0,0,0
	bc 12,2,.L85
	lwz 29,296(30)
	stw 0,296(30)
	bl G_UseTargets
	stw 29,296(30)
.L85:
	lwz 3,296(30)
	cmpwi 0,3,0
	bc 12,2,.L86
	bl G_PickTarget
	mr 9,3
	b .L87
.L86:
	li 9,0
.L87:
	cmpwi 0,9,0
	bc 12,2,.L88
	lwz 0,284(9)
	andi. 11,0,1
	bc 12,2,.L88
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
	lwz 3,296(9)
	bl G_PickTarget
	li 0,7
	mr 9,3
	stw 0,80(31)
.L88:
	lis 11,.LC54@ha
	stw 9,416(31)
	la 11,.LC54@l(11)
	stw 9,412(31)
	lfs 0,0(11)
	lfs 13,592(30)
	fcmpu 0,13,0
	bc 12,2,.L89
	lis 9,level+4@ha
	lwz 11,788(31)
	mr 3,31
	lfs 0,level+4@l(9)
	mtlr 11
	b .L92
.L89:
	cmpwi 0,9,0
	bc 4,2,.L90
	lis 9,level+4@ha
	lis 11,.LC53@ha
	lwz 10,788(31)
	lfs 0,level+4@l(9)
	mr 3,31
	lfs 13,.LC53@l(11)
	mtlr 10
.L92:
	fadds 0,0,13
	stfs 0,828(31)
	blrl
	b .L82
.L90:
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
	stfs 1,424(31)
.L82:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 path_corner_touch,.Lfe6-path_corner_touch
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
	lwz 0,416(31)
	cmpw 0,0,30
	bc 4,2,.L95
	lwz 0,296(30)
	cmpwi 0,0,0
	bc 12,2,.L97
	mr 3,0
	stw 0,296(31)
	bl G_PickTarget
	cmpwi 0,3,0
	stw 3,416(31)
	stw 3,412(31)
	bc 4,2,.L98
	lis 29,gi@ha
	lwz 28,280(30)
	addi 3,30,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC56@ha
	lwz 6,296(30)
	la 3,.LC56@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	stw 30,416(31)
.L98:
	li 0,0
	stw 0,296(30)
	b .L99
.L97:
	lwz 0,284(30)
	andi. 9,0,1
	bc 12,2,.L99
	lwz 0,264(31)
	andi. 9,0,3
	bc 4,2,.L99
	lis 11,.LC57@ha
	lis 9,level+4@ha
	lwz 0,776(31)
	lfs 0,level+4@l(9)
	mr 3,31
	lfs 13,.LC57@l(11)
	ori 0,0,1
	lwz 11,788(31)
	stw 0,776(31)
	fadds 0,0,13
	mtlr 11
	stfs 0,828(31)
	blrl
.L99:
	lwz 0,416(31)
	cmpw 0,0,30
	bc 4,2,.L101
	lwz 0,776(31)
	li 11,0
	lwz 9,540(31)
	rlwinm 0,0,0,20,18
	stw 11,416(31)
	stw 9,412(31)
	stw 0,776(31)
	stw 11,296(31)
.L101:
	lwz 0,312(30)
	cmpwi 0,0,0
	bc 12,2,.L95
	lwz 29,296(30)
	stw 0,296(30)
	lwz 4,540(31)
	cmpwi 0,4,0
	bc 12,2,.L103
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 4,2,.L109
.L103:
	lwz 4,544(31)
	cmpwi 0,4,0
	bc 12,2,.L105
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L105
.L109:
	mr 3,4
	b .L104
.L105:
	lwz 9,548(31)
	mr 3,31
	cmpwi 0,9,0
	bc 12,2,.L104
	lwz 0,84(9)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,3,0
	or 3,0,9
.L104:
	mr 4,3
	mr 3,30
	bl G_UseTargets
	stw 29,296(30)
.L95:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 point_combat_touch,.Lfe7-point_combat_touch
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
	stw 0,260(31)
	la 30,gi@l(9)
	lwz 4,268(31)
	lwz 9,44(30)
	mtlr 9
	blrl
	lwz 0,284(31)
	andi. 9,0,8
	bc 12,2,.L130
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L130:
	lwz 0,284(31)
	andi. 9,0,16
	bc 12,2,.L131
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L131:
	lwz 0,284(31)
	andi. 9,0,7
	bc 4,2,.L132
	li 0,3
	mr 3,31
	stw 0,248(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	b .L129
.L132:
	andi. 9,0,1
	bc 4,2,.L133
	ori 0,0,1
	stw 0,284(31)
.L133:
	lwz 0,284(31)
	andi. 9,0,4
	bc 12,2,.L134
	andi. 9,0,2
	bc 4,2,.L134
	lwz 0,4(30)
	lis 3,.LC63@ha
	la 3,.LC63@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,284(31)
	ori 0,0,2
	stw 0,284(31)
.L134:
	lwz 0,284(31)
	lis 9,func_wall_use@ha
	la 9,func_wall_use@l(9)
	andi. 11,0,4
	stw 9,448(31)
	bc 12,2,.L136
	li 0,3
	stw 0,248(31)
	b .L137
.L136:
	lwz 0,184(31)
	stw 11,248(31)
	ori 0,0,1
	stw 0,184(31)
.L137:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L129:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 SP_func_wall,.Lfe8-SP_func_wall
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
	lwz 4,268(31)
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
	lwz 0,516(31)
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
	bc 4,2,.L146
	li 0,100
	stw 0,516(31)
.L146:
	lwz 0,284(31)
	cmpwi 0,0,0
	bc 4,2,.L147
	li 11,3
	lis 9,func_object_release@ha
	stw 11,248(31)
	la 9,func_object_release@l(9)
	li 0,2
	stw 0,260(31)
	lis 11,level+4@ha
	lis 10,.LC64@ha
	stw 9,436(31)
	lfs 0,level+4@l(11)
	lfd 13,.LC64@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	b .L148
.L147:
	lwz 0,184(31)
	lis 9,func_object_use@ha
	li 11,0
	la 9,func_object_use@l(9)
	li 10,2
	stw 11,248(31)
	ori 0,0,1
	stw 10,260(31)
	stw 9,448(31)
	stw 0,184(31)
.L148:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L149
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L149:
	lwz 0,284(31)
	andi. 9,0,4
	bc 12,2,.L150
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L150:
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
.Lfe9:
	.size	 SP_func_object,.Lfe9-SP_func_object
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
	lwz 11,516(31)
	stfs 12,4(31)
	fadds 0,0,11
	stw 0,512(31)
	cmpwi 0,11,0
	stfs 13,8(31)
	stfs 12,8(1)
	stfs 0,12(31)
	stfs 13,12(1)
	stfs 0,16(1)
	bc 12,2,.L152
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
.L152:
	lfs 0,4(28)
	addi 29,31,376
	lfs 13,4(31)
	mr 3,29
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,376(31)
	lfs 0,8(28)
	fsubs 12,12,0
	stfs 12,380(31)
	lfs 0,12(28)
	fsubs 11,11,0
	stfs 11,384(31)
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
	lwz 28,400(31)
	srawi 9,28,31
	xor 0,9,28
	subf 0,0,9
	srawi 0,0,31
	nor 9,0,0
	andi. 9,9,75
	and 0,28,0
	or 28,0,9
	cmpwi 0,28,99
	bc 4,1,.L154
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
	bc 12,2,.L154
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
.L158:
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
	bc 4,2,.L158
.L154:
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
	bc 12,2,.L162
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
.L163:
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
	bc 4,2,.L163
.L162:
	mr 4,26
	mr 3,31
	bl G_UseTargets
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 12,2,.L165
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
	b .L167
.L165:
	mr 3,31
	bl G_FreeEdict
.L167:
	lwz 0,116(1)
	mtlr 0
	lmw 26,64(1)
	lfd 29,88(1)
	lfd 30,96(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe10:
	.size	 func_explosive_explode,.Lfe10-func_explosive_explode
	.section	".rodata"
	.align 2
.LC75:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_func_explosive
	.type	 SP_func_explosive,@function
SP_func_explosive:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 11,.LC75@ha
	lis 9,deathmatch@ha
	la 11,.LC75@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L171
	bl G_FreeEdict
	b .L170
.L171:
	li 0,2
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,260(31)
	lis 3,.LC67@ha
	lwz 9,32(29)
	la 3,.LC67@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC68@ha
	la 3,.LC68@l(3)
	mtlr 9
	blrl
	lwz 0,44(29)
	mr 3,31
	lwz 4,268(31)
	mtlr 0
	blrl
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L172
	lwz 0,184(31)
	lis 9,func_explosive_spawn@ha
	li 11,0
	la 9,func_explosive_spawn@l(9)
	stw 11,248(31)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
	b .L173
.L172:
	lwz 9,300(31)
	li 0,3
	stw 0,248(31)
	cmpwi 0,9,0
	bc 12,2,.L173
	lis 9,func_explosive_use@ha
	la 9,func_explosive_use@l(9)
	stw 9,448(31)
.L173:
	lwz 0,284(31)
	andi. 11,0,2
	bc 12,2,.L175
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L175:
	lwz 0,284(31)
	andi. 9,0,4
	bc 12,2,.L176
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L176:
	lwz 0,448(31)
	lis 9,func_explosive_use@ha
	la 9,func_explosive_use@l(9)
	cmpw 0,0,9
	bc 12,2,.L177
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,2,.L178
	li 0,100
	stw 0,480(31)
.L178:
	lis 9,func_explosive_explode@ha
	li 0,1
	la 9,func_explosive_explode@l(9)
	stw 0,512(31)
	stw 9,456(31)
.L177:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L170:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 SP_func_explosive,.Lfe11-SP_func_explosive
	.section	".rodata"
	.align 2
.LC78:
	.string	"models/objects/debris3/tris.md2"
	.align 2
.LC77:
	.long 0x46fffe00
	.align 3
.LC79:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC80:
	.long 0x40690000
	.long 0x0
	.align 3
.LC81:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC82:
	.long 0x3f000000
	.align 3
.LC83:
	.long 0x3ff80000
	.long 0x0
	.align 3
.LC84:
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
	lwz 9,516(31)
	lis 29,0x4330
	mr 10,11
	lis 8,.LC79@ha
	lwz 4,548(31)
	li 6,26
	xoris 0,9,0x8000
	la 8,.LC79@l(8)
	stw 0,44(1)
	addi 9,9,40
	stw 29,40(1)
	xoris 9,9,0x8000
	li 5,0
	lfd 1,40(1)
	addi 30,31,4
	lis 26,.LC67@ha
	stw 9,44(1)
	lis 11,.LC80@ha
	lis 28,.LC78@ha
	stw 29,40(1)
	la 11,.LC80@l(11)
	lis 27,.LC68@ha
	lfd 2,40(1)
	lfd 31,0(8)
	lis 8,.LC81@ha
	lfd 28,0(11)
	la 8,.LC81@l(8)
	fsub 1,1,31
	lfd 30,0(8)
	fsub 2,2,31
	frsp 1,1
	frsp 2,2
	bl T_RadiusDamage
	lis 8,.LC82@ha
	lfs 12,4(31)
	addi 4,31,236
	lfs 13,8(31)
	la 8,.LC82@l(8)
	mr 5,30
	lfs 0,12(31)
	addi 3,31,212
	lfs 1,0(8)
	stfs 12,24(1)
	stfs 13,28(1)
	stfs 0,32(1)
	bl VectorMA
	lwz 0,516(31)
	lis 8,.LC83@ha
	la 8,.LC83@l(8)
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
	lis 11,.LC77@ha
	lfs 12,236(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	lfs 29,.LC77@l(11)
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
	lwz 0,516(31)
	lis 8,.LC84@ha
	lfs 0,220(31)
	la 8,.LC84@l(8)
	addi 5,1,8
	xoris 0,0,0x8000
	lfs 10,212(31)
	mr 3,31
	stw 0,44(1)
	la 4,.LC78@l(28)
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
	la 4,.LC78@l(28)
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
	la 4,.LC78@l(28)
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
	la 4,.LC78@l(28)
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
	lwz 9,516(31)
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
	lwz 0,552(31)
	lfs 12,24(1)
	lfs 0,28(1)
	cmpwi 0,0,0
	lfs 13,32(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bc 12,2,.L183
	mr 3,31
	bl BecomeExplosion2
	b .L184
.L183:
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
.L184:
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
.Lfe12:
	.size	 barrel_explode,.Lfe12-barrel_explode
	.section	".rodata"
	.align 2
.LC86:
	.string	"models/objects/barrels/tris.md2"
	.align 3
.LC87:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC88:
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
	lis 11,.LC88@ha
	lis 9,deathmatch@ha
	la 11,.LC88@l(11)
	mr 31,3
	lfs 31,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L188
	bl G_FreeEdict
	b .L187
.L188:
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
	lis 3,.LC78@ha
	la 3,.LC78@l(3)
	mtlr 9
	blrl
	lis 9,.LC86@ha
	li 11,2
	la 9,.LC86@l(9)
	li 0,5
	stw 11,248(31)
	stw 0,260(31)
	mr 3,9
	stw 9,268(31)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,400(31)
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
	bc 4,2,.L189
	li 0,400
	stw 0,400(31)
.L189:
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,2,.L190
	li 0,10
	stw 0,480(31)
.L190:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L191
	li 0,150
	stw 0,516(31)
.L191:
	lis 9,barrel_delay@ha
	lis 11,barrel_touch@ha
	la 9,barrel_delay@l(9)
	la 11,barrel_touch@l(11)
	stw 9,456(31)
	lis 10,M_droptofloor@ha
	li 0,1
	stw 11,444(31)
	la 10,M_droptofloor@l(10)
	li 9,1024
	stw 0,512(31)
	lis 11,level+4@ha
	lis 8,.LC87@ha
	stw 9,776(31)
	mr 3,31
	stw 10,436(31)
	lfs 0,level+4@l(11)
	lfd 13,.LC87@l(8)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,72(30)
	mtlr 0
	blrl
.L187:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 SP_misc_explobox,.Lfe13-SP_misc_explobox
	.section	".rodata"
	.align 2
.LC90:
	.string	"models/objects/black/tris.md2"
	.align 2
.LC93:
	.string	"models/monsters/tank/tris.md2"
	.align 2
.LC96:
	.string	"models/monsters/bitch/tris.md2"
	.align 2
.LC102:
	.string	"models/monsters/commandr/tris.md2"
	.align 2
.LC105:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC106:
	.string	"models/deadbods/dude/tris.md2"
	.align 2
.LC107:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_misc_deadsoldier
	.type	 SP_misc_deadsoldier,@function
SP_misc_deadsoldier:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 11,.LC107@ha
	lis 9,deathmatch@ha
	la 11,.LC107@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L225
	bl G_FreeEdict
	b .L224
.L225:
	li 0,0
	li 30,2
	lis 9,gi+32@ha
	stw 0,260(31)
	lis 3,.LC106@ha
	stw 30,248(31)
	la 3,.LC106@l(3)
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
	lwz 0,284(31)
	stw 3,40(31)
	andi. 9,0,2
	bc 12,2,.L226
	li 0,1
	b .L234
.L226:
	andi. 11,0,4
	bc 12,2,.L228
	stw 30,56(31)
	b .L227
.L228:
	andi. 9,0,8
	bc 12,2,.L230
	li 0,3
	b .L234
.L230:
	andi. 11,0,16
	bc 12,2,.L232
	li 0,4
	b .L234
.L232:
	andi. 0,0,32
	bc 12,2,.L234
	li 0,5
.L234:
	stw 0,56(31)
.L227:
	lwz 11,184(31)
	lis 10,misc_deadsoldier_die@ha
	lis 6,0x4180
	lwz 9,776(31)
	lis 4,0xc180
	li 0,0
	la 10,misc_deadsoldier_die@l(10)
	ori 11,11,6
	stw 4,192(31)
	ori 9,9,256
	li 8,2
	stw 0,196(31)
	li 7,1
	stw 6,208(31)
	lis 5,gi+72@ha
	stw 8,492(31)
	mr 3,31
	stw 7,512(31)
	stw 11,184(31)
	stw 10,456(31)
	stw 9,776(31)
	stw 4,188(31)
	stw 6,200(31)
	stw 6,204(31)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
.L224:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 SP_misc_deadsoldier,.Lfe14-SP_misc_deadsoldier
	.section	".rodata"
	.align 2
.LC108:
	.string	"misc_viper without a target at %s\n"
	.align 2
.LC109:
	.string	"models/ships/viper/tris.md2"
	.align 3
.LC110:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC111:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_misc_viper
	.type	 SP_misc_viper,@function
SP_misc_viper:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 29,12(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L238
	lis 29,gi@ha
	addi 3,31,212
	la 29,gi@l(29)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC108@ha
	la 3,.LC108@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L237
.L238:
	lis 9,.LC111@ha
	lfs 0,328(31)
	la 9,.LC111@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L239
	lis 0,0x4396
	stw 0,328(31)
.L239:
	li 0,2
	li 9,0
	lis 29,gi@ha
	stw 0,260(31)
	lis 3,.LC109@ha
	la 29,gi@l(29)
	stw 9,248(31)
	la 3,.LC109@l(3)
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
	lis 8,.LC110@ha
	lis 9,misc_viper_use@ha
	stw 10,204(31)
	la 9,misc_viper_use@l(9)
	mr 3,31
	stw 11,436(31)
	stw 7,188(31)
	stw 10,200(31)
	lfs 0,level+4@l(6)
	lfd 12,.LC110@l(8)
	lfs 13,328(31)
	lwz 0,184(31)
	stw 9,448(31)
	ori 0,0,1
	stfs 13,712(31)
	fadd 0,0,12
	stw 0,184(31)
	stfs 13,716(31)
	stfs 13,720(31)
	frsp 0,0
	stfs 0,428(31)
	lwz 0,72(29)
	mtlr 0
	blrl
.L237:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 SP_misc_viper,.Lfe15-SP_misc_viper
	.section	".rodata"
	.align 2
.LC112:
	.string	"models/ships/bigviper/tris.md2"
	.align 2
.LC113:
	.string	"misc_viper"
	.align 2
.LC114:
	.string	"models/objects/bomb/tris.md2"
	.align 2
.LC115:
	.string	"%s without a target at %s\n"
	.align 2
.LC116:
	.string	"models/ships/strogg1/tris.md2"
	.align 3
.LC117:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC118:
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
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L249
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,212
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC115@ha
	la 3,.LC115@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L248
.L249:
	lis 9,.LC118@ha
	lfs 0,328(31)
	la 9,.LC118@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L250
	lis 0,0x4396
	stw 0,328(31)
.L250:
	li 0,2
	li 9,0
	lis 29,gi@ha
	stw 0,260(31)
	lis 3,.LC116@ha
	la 29,gi@l(29)
	stw 9,248(31)
	la 3,.LC116@l(3)
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
	lis 8,.LC117@ha
	lis 9,misc_strogg_ship_use@ha
	stw 10,204(31)
	la 9,misc_strogg_ship_use@l(9)
	mr 3,31
	stw 11,436(31)
	stw 7,188(31)
	stw 10,200(31)
	lfs 0,level+4@l(6)
	lfd 12,.LC117@l(8)
	lfs 13,328(31)
	lwz 0,184(31)
	stw 9,448(31)
	ori 0,0,1
	stfs 13,712(31)
	fadd 0,0,12
	stw 0,184(31)
	stfs 13,716(31)
	stfs 13,720(31)
	frsp 0,0
	stfs 0,428(31)
	lwz 0,72(29)
	mtlr 0
	blrl
.L248:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 SP_misc_strogg_ship,.Lfe16-SP_misc_strogg_ship
	.section	".rodata"
	.align 2
.LC121:
	.string	"models/objects/satellite/tris.md2"
	.align 2
.LC122:
	.string	"models/objects/minelite/light1/tris.md2"
	.align 2
.LC123:
	.string	"models/objects/minelite/light2/tris.md2"
	.align 2
.LC124:
	.string	"models/objects/gibs/arm/tris.md2"
	.align 2
.LC125:
	.long 0x46fffe00
	.align 3
.LC126:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC127:
	.long 0x43480000
	.align 2
.LC128:
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
	lis 4,.LC124@ha
	lwz 11,44(27)
	la 4,.LC124@l(4)
	lis 8,.LC126@ha
	lis 9,.LC127@ha
	mtlr 11
	la 8,.LC126@l(8)
	la 9,.LC127@l(9)
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
	stw 8,512(29)
	stw 10,492(29)
	stw 7,260(29)
	stw 9,456(29)
	stw 11,184(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC125@ha
	stw 3,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	lfs 30,.LC125@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,29
	stfs 0,388(29)
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
	stfs 0,392(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 9,G_FreeEdict@ha
	stw 3,28(1)
	la 9,G_FreeEdict@l(9)
	lis 8,.LC128@ha
	stw 28,24(1)
	lis 10,level+4@ha
	la 8,.LC128@l(8)
	lfd 0,24(1)
	mr 3,29
	stw 9,436(29)
	lfs 12,0(8)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,29
	stfs 0,396(29)
	lfs 13,level+4@l(10)
	fadds 13,13,12
	stfs 13,428(29)
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
	.size	 SP_misc_gib_arm,.Lfe17-SP_misc_gib_arm
	.section	".rodata"
	.align 2
.LC129:
	.string	"models/objects/gibs/leg/tris.md2"
	.align 2
.LC130:
	.long 0x46fffe00
	.align 3
.LC131:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC132:
	.long 0x43480000
	.align 2
.LC133:
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
	lis 4,.LC129@ha
	lwz 11,44(27)
	la 4,.LC129@l(4)
	lis 8,.LC131@ha
	lis 9,.LC132@ha
	mtlr 11
	la 8,.LC131@l(8)
	la 9,.LC132@l(9)
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
	stw 8,512(29)
	stw 10,492(29)
	stw 7,260(29)
	stw 9,456(29)
	stw 11,184(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC130@ha
	stw 3,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	lfs 30,.LC130@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,29
	stfs 0,388(29)
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
	stfs 0,392(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 9,G_FreeEdict@ha
	stw 3,28(1)
	la 9,G_FreeEdict@l(9)
	lis 8,.LC133@ha
	stw 28,24(1)
	lis 10,level+4@ha
	la 8,.LC133@l(8)
	lfd 0,24(1)
	mr 3,29
	stw 9,436(29)
	lfs 12,0(8)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,29
	stfs 0,396(29)
	lfs 13,level+4@l(10)
	fadds 13,13,12
	stfs 13,428(29)
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
	.size	 SP_misc_gib_leg,.Lfe18-SP_misc_gib_leg
	.section	".rodata"
	.align 2
.LC134:
	.string	"models/objects/gibs/head/tris.md2"
	.align 2
.LC135:
	.long 0x46fffe00
	.align 3
.LC136:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC137:
	.long 0x43480000
	.align 2
.LC138:
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
	lis 4,.LC134@ha
	lwz 11,44(27)
	la 4,.LC134@l(4)
	lis 8,.LC136@ha
	lis 9,.LC137@ha
	mtlr 11
	la 8,.LC136@l(8)
	la 9,.LC137@l(9)
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
	stw 8,512(29)
	stw 10,492(29)
	stw 7,260(29)
	stw 9,456(29)
	stw 11,184(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC135@ha
	stw 3,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	lfs 30,.LC135@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,29
	stfs 0,388(29)
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
	stfs 0,392(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 9,G_FreeEdict@ha
	stw 3,28(1)
	la 9,G_FreeEdict@l(9)
	lis 8,.LC138@ha
	stw 28,24(1)
	lis 10,level+4@ha
	la 8,.LC138@l(8)
	lfd 0,24(1)
	mr 3,29
	stw 9,436(29)
	lfs 12,0(8)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,29
	stfs 0,396(29)
	lfs 13,level+4@l(10)
	fadds 13,13,12
	stfs 13,428(29)
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
.Lfe19:
	.size	 SP_misc_gib_head,.Lfe19-SP_misc_gib_head
	.section	".rodata"
	.align 2
.LC139:
	.string	""
	.align 2
.LC140:
	.string	"%2i"
	.align 2
.LC141:
	.string	"%2i:%2i"
	.align 2
.LC142:
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
	lwz 0,644(31)
	cmpwi 0,0,0
	bc 4,2,.L282
	lis 5,.LC140@ha
	lwz 6,480(31)
	li 4,16
	lwz 3,276(31)
	la 5,.LC140@l(5)
	crxor 6,6,6
	bl Com_sprintf
	b .L281
.L282:
	cmpwi 0,0,1
	bc 4,2,.L283
	lwz 0,480(31)
	lis 6,0x8888
	lis 5,.LC141@ha
	ori 6,6,34953
	lwz 3,276(31)
	la 5,.LC141@l(5)
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
	lwz 3,276(31)
	lbz 0,3(3)
	cmpwi 0,0,32
	bc 4,2,.L281
	li 0,48
	stb 0,3(3)
	b .L281
.L283:
	cmpwi 0,0,2
	bc 4,2,.L281
	lwz 9,480(31)
	lis 6,0x91a2
	lis 7,0x8888
	ori 6,6,46021
	ori 7,7,34953
	lwz 3,276(31)
	mulhw 6,9,6
	srawi 11,9,31
	lis 5,.LC142@ha
	mulhw 8,9,7
	la 5,.LC142@l(5)
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
	lwz 9,276(31)
	lbz 0,3(9)
	cmpwi 0,0,32
	bc 4,2,.L286
	li 0,48
	stb 0,3(9)
.L286:
	lwz 3,276(31)
	lbz 0,6(3)
	cmpwi 0,0,32
	bc 4,2,.L281
	li 0,48
	stb 0,6(3)
.L281:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe20:
	.size	 func_clock_format_countdown,.Lfe20-func_clock_format_countdown
	.section	".rodata"
	.align 3
.LC143:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC144:
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
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L289
	lwz 5,296(31)
	li 3,0
	li 4,300
	bl G_Find
	cmpwi 0,3,0
	stw 3,540(31)
	bc 12,2,.L288
.L289:
	lwz 0,284(31)
	andi. 8,0,1
	bc 12,2,.L291
	mr 3,31
	bl func_clock_format_countdown
	lwz 9,480(31)
	addi 9,9,1
	stw 9,480(31)
	b .L292
.L291:
	andi. 8,0,2
	bc 12,2,.L293
	mr 3,31
	bl func_clock_format_countdown
	lwz 9,480(31)
	addi 9,9,-1
	stw 9,480(31)
	b .L292
.L293:
	addi 29,1,8
	mr 3,29
	bl time
	mr 3,29
	bl localtime
	mr 9,3
	lis 5,.LC142@ha
	lwz 8,0(9)
	la 5,.LC142@l(5)
	li 4,16
	lwz 6,8(9)
	lwz 7,4(9)
	lwz 3,276(31)
	crxor 6,6,6
	bl Com_sprintf
	lwz 9,276(31)
	lbz 0,3(9)
	cmpwi 0,0,32
	bc 4,2,.L295
	li 0,48
	stb 0,3(9)
.L295:
	lwz 9,276(31)
	lbz 0,6(9)
	cmpwi 0,0,32
	bc 4,2,.L292
	li 0,48
	stb 0,6(9)
.L292:
	lwz 0,276(31)
	mr 4,31
	mr 5,31
	lwz 9,540(31)
	stw 0,276(9)
	lwz 11,540(31)
	lwz 0,448(11)
	mr 3,11
	mtlr 0
	blrl
	lwz 10,284(31)
	andi. 0,10,1
	bc 12,2,.L299
	lwz 0,480(31)
	lis 11,0x4330
	lis 8,.LC143@ha
	lfs 12,592(31)
	xoris 0,0,0x8000
	la 8,.LC143@l(8)
	stw 0,28(1)
	stw 11,24(1)
	lfd 13,0(8)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,1,.L298
.L299:
	andi. 9,10,2
	bc 12,2,.L297
	lwz 0,480(31)
	lis 11,0x4330
	lis 10,.LC143@ha
	lfs 12,592(31)
	xoris 0,0,0x8000
	la 10,.LC143@l(10)
	stw 0,28(1)
	stw 11,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L297
.L298:
	lwz 9,312(31)
	cmpwi 0,9,0
	bc 12,2,.L300
	lwz 29,296(31)
	li 0,0
	mr 3,31
	lwz 28,276(31)
	lwz 4,548(31)
	stw 9,296(31)
	stw 0,276(31)
	bl G_UseTargets
	stw 29,296(31)
	stw 28,276(31)
.L300:
	lwz 0,284(31)
	andi. 8,0,8
	bc 12,2,.L288
	andi. 9,0,1
	li 10,0
	stw 10,548(31)
	bc 12,2,.L302
	lwz 0,532(31)
	lis 11,0x4330
	lis 8,.LC143@ha
	stw 10,480(31)
	xoris 0,0,0x8000
	la 8,.LC143@l(8)
	stw 0,28(1)
	stw 11,24(1)
	lfd 13,0(8)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,592(31)
	b .L305
.L302:
	andi. 9,0,2
	bc 12,2,.L305
	lwz 9,532(31)
	li 0,0
	stw 0,592(31)
	stw 9,480(31)
.L305:
	lwz 0,284(31)
	andi. 10,0,4
	bc 4,2,.L288
.L297:
	lis 11,.LC144@ha
	lis 9,level+4@ha
	la 11,.LC144@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,428(31)
.L288:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe21:
	.size	 func_clock_think,.Lfe21-func_clock_think
	.section	".rodata"
	.align 2
.LC145:
	.string	"%s with no target at %s\n"
	.align 2
.LC146:
	.string	"%s with no count at %s\n"
	.align 3
.LC147:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC148:
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
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L311
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC145@ha
	la 3,.LC145@l(3)
	b .L320
.L311:
	lwz 0,284(31)
	andi. 8,0,2
	mr 9,0
	bc 12,2,.L312
	lwz 0,532(31)
	cmpwi 0,0,0
	bc 4,2,.L312
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC146@ha
	la 3,.LC146@l(3)
.L320:
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L310
.L312:
	andi. 0,9,1
	bc 12,2,.L313
	lwz 0,532(31)
	cmpwi 0,0,0
	bc 4,2,.L313
	li 0,3600
	stw 0,532(31)
.L313:
	lwz 0,284(31)
	li 10,0
	stw 10,548(31)
	andi. 8,0,1
	bc 12,2,.L314
	lwz 0,532(31)
	lis 11,0x4330
	lis 8,.LC147@ha
	stw 10,480(31)
	xoris 0,0,0x8000
	la 8,.LC147@l(8)
	stw 0,12(1)
	stw 11,8(1)
	lfd 13,0(8)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,592(31)
	b .L317
.L314:
	andi. 9,0,2
	bc 12,2,.L317
	lwz 9,532(31)
	li 0,0
	stw 0,592(31)
	stw 9,480(31)
.L317:
	lis 9,gi+132@ha
	li 3,16
	lwz 0,gi+132@l(9)
	li 4,766
	mtlr 0
	blrl
	lwz 0,284(31)
	lis 9,func_clock_think@ha
	la 9,func_clock_think@l(9)
	stw 3,276(31)
	andi. 8,0,4
	stw 9,436(31)
	bc 12,2,.L318
	lis 9,func_clock_use@ha
	la 9,func_clock_use@l(9)
	stw 9,448(31)
	b .L310
.L318:
	lis 11,.LC148@ha
	lis 9,level+4@ha
	la 11,.LC148@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,428(31)
.L310:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 SP_func_clock,.Lfe22-SP_func_clock
	.section	".rodata"
	.align 2
.LC149:
	.string	"Couldn't find destination\n"
	.align 2
.LC150:
	.long 0x47800000
	.align 2
.LC151:
	.long 0x43b40000
	.align 2
.LC152:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl teleporter_touch
	.type	 teleporter_touch,@function
teleporter_touch:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,4
	mr 29,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L321
	lwz 5,296(29)
	li 3,0
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L323
	lis 9,gi+4@ha
	lis 3,.LC149@ha
	lwz 0,gi+4@l(9)
	la 3,.LC149@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L321
.L323:
	lis 9,gi+76@ha
	mr 3,31
	lwz 0,gi+76@l(9)
	mtlr 0
	blrl
	lfs 0,4(30)
	lis 9,.LC150@ha
	lis 11,.LC151@ha
	la 9,.LC150@l(9)
	la 11,.LC151@l(11)
	lwz 8,84(31)
	lfs 10,0(9)
	li 0,0
	li 10,6
	stfs 0,4(31)
	lis 9,.LC152@ha
	addi 5,30,16
	lfs 0,8(30)
	la 9,.LC152@l(9)
	li 6,0
	lfs 13,0(9)
	li 7,0
	lfs 11,0(11)
	li 9,20
	stfs 0,8(31)
	li 11,3
	lfs 12,12(30)
	mtctr 11
	stfs 12,12(31)
	lfs 0,4(30)
	fadds 12,12,13
	stfs 0,28(31)
	lfs 13,8(30)
	stfs 13,32(31)
	lfs 0,12(30)
	stfs 12,12(31)
	stw 0,376(31)
	stfs 0,36(31)
	stw 0,384(31)
	stw 0,380(31)
	stb 9,17(8)
	lwz 11,84(31)
	lbz 0,16(11)
	ori 0,0,32
	stb 0,16(11)
	lwz 9,256(29)
	stw 10,80(9)
	stw 10,80(31)
.L329:
	lwz 10,84(31)
	add 0,6,6
	lfsx 0,7,5
	addi 6,6,1
	addi 9,10,4036
	lfsx 13,9,7
	addi 10,10,20
	addi 7,7,4
	fsubs 0,0,13
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,24(1)
	lwz 11,28(1)
	sthx 11,10,0
	bdnz .L329
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
	stw 0,4252(9)
	stw 0,4260(9)
	stw 0,4256(9)
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L321:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe23:
	.size	 teleporter_touch,.Lfe23-teleporter_touch
	.section	".rodata"
	.align 2
.LC153:
	.string	"teleporter without a target.\n"
	.align 2
.LC154:
	.string	"models/objects/dmspot/tris.md2"
	.align 2
.LC155:
	.string	"world/amb_ionus_light_hum2_loop.wav"
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
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L331
	lis 9,gi+4@ha
	lis 3,.LC153@ha
	lwz 0,gi+4@l(9)
	la 3,.LC153@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L330
.L331:
	lis 29,gi@ha
	lis 4,.LC154@ha
	la 29,gi@l(29)
	la 4,.LC154@l(4)
	lwz 9,44(29)
	mr 3,31
	li 28,1
	mtlr 9
	blrl
	lis 0,0x2
	stw 28,60(31)
	lis 3,.LC155@ha
	stw 0,64(31)
	la 3,.LC155@l(3)
	lwz 9,36(29)
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
	stw 11,444(9)
	lis 8,0xc100
	lwz 0,296(31)
	lis 11,0x41c0
	stw 31,256(9)
	stw 0,296(9)
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
.L330:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 SP_misc_teleporter,.Lfe24-SP_misc_teleporter
	.section	".rodata"
	.align 2
.LC156:
	.long 0x46fffe00
	.align 3
.LC157:
	.long 0x3fee6666
	.long 0x66666666
	.align 3
.LC158:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC159:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 3
.LC160:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC161:
	.long 0x3feb3333
	.long 0x33333333
	.align 3
.LC162:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC163:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC164:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC165:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC166:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl misc_hologram_think
	.type	 misc_hologram_think,@function
misc_hologram_think:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	bl rand
	rlwinm 3,3,0,17,31
	lwz 10,952(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC164@ha
	cmpwi 0,10,1
	la 11,.LC164@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC156@ha
	lfs 12,.LC156@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 12,0,12
	bc 4,2,.L334
	lwz 0,68(31)
	li 9,0
	stw 9,952(31)
	ori 0,0,8
	stw 0,68(31)
	b .L335
.L334:
	cmpwi 0,10,2
	bc 4,2,.L336
	lfs 0,12(31)
	lis 9,.LC165@ha
	li 0,0
	la 9,.LC165@l(9)
	stw 0,952(31)
	lfd 13,0(9)
	fsub 0,0,13
	b .L349
.L336:
	cmpwi 0,10,4
	bc 4,2,.L338
	lis 11,.LC166@ha
	lfs 0,12(31)
	li 0,0
	la 11,.LC166@l(11)
	stw 0,952(31)
	lfs 13,0(11)
	fsubs 0,0,13
	b .L350
.L338:
	cmpwi 0,10,8
	bc 4,2,.L335
	lfs 0,12(31)
	lis 9,.LC165@ha
	li 0,0
	la 9,.LC165@l(9)
	stw 0,952(31)
	lfd 13,0(9)
	fadd 0,0,13
.L349:
	frsp 0,0
.L350:
	stfs 0,12(31)
.L335:
	lis 9,.LC157@ha
	fmr 13,12
	lfd 0,.LC157@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L341
	lwz 0,68(31)
	lis 10,level+4@ha
	lis 9,.LC158@ha
	lfd 13,.LC158@l(9)
	li 11,1
	rlwinm 0,0,0,29,27
	stw 0,68(31)
	lfs 0,level+4@l(10)
	stw 11,952(31)
	fadd 0,0,13
	b .L351
.L341:
	lis 9,.LC159@ha
	lfd 0,.LC159@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L343
	lfs 13,12(31)
	lis 11,.LC165@ha
	lis 9,.LC160@ha
	la 11,.LC165@l(11)
	lfd 12,.LC160@l(9)
	li 0,2
	lfd 0,0(11)
	lis 11,level+4@ha
	fadd 13,13,0
	frsp 13,13
	stfs 13,12(31)
	lfs 0,level+4@l(11)
	stw 0,952(31)
	fadd 0,0,12
	b .L351
.L343:
	lis 9,.LC161@ha
	lfd 0,.LC161@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L345
	lis 9,.LC166@ha
	lfs 13,12(31)
	lis 11,level+4@ha
	la 9,.LC166@l(9)
	li 0,4
	lfs 0,0(9)
	lis 9,.LC160@ha
	lfd 12,.LC160@l(9)
	fadds 13,13,0
	stfs 13,12(31)
	lfs 0,level+4@l(11)
	stw 0,952(31)
	fadd 0,0,12
	b .L351
.L345:
	lis 9,.LC162@ha
	lfd 0,.LC162@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L347
	lfs 13,12(31)
	lis 11,.LC165@ha
	lis 9,.LC160@ha
	la 11,.LC165@l(11)
	lfd 12,.LC160@l(9)
	li 0,8
	lfd 0,0(11)
	lis 11,level+4@ha
	fsub 13,13,0
	frsp 13,13
	stfs 13,12(31)
	lfs 0,level+4@l(11)
	stw 0,952(31)
	fadd 0,0,12
	b .L351
.L347:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC164@ha
	lis 10,.LC156@ha
	la 11,.LC164@l(11)
	stw 0,16(1)
	lis 8,.LC163@ha
	lfd 0,0(11)
	lfd 13,16(1)
	lis 11,level+4@ha
	lfs 10,.LC156@l(10)
	lfs 12,level+4@l(11)
	fsub 13,13,0
	lfd 11,.LC163@l(8)
	frsp 13,13
	fdivs 13,13,10
	fmr 0,13
	fmadd 0,0,11,12
.L351:
	frsp 0,0
	stfs 0,428(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 misc_hologram_think,.Lfe25-misc_hologram_think
	.section	".rodata"
	.align 2
.LC167:
	.string	"models/monsters/jawa/trader.md2"
	.align 2
.LC170:
	.string	"world/thunder1.wav"
	.align 2
.LC171:
	.long 0x46fffe00
	.align 2
.LC172:
	.long 0x0
	.align 2
.LC173:
	.long 0x3f800000
	.align 3
.LC174:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC175:
	.long 0x42000000
	.align 2
.LC176:
	.long 0x41800000
	.align 2
.LC177:
	.long 0x40a00000
	.align 2
.LC178:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl lightning_strike
	.type	 lightning_strike,@function
lightning_strike:
	stwu 1,-240(1)
	mflr 0
	stfd 27,200(1)
	stfd 28,208(1)
	stfd 29,216(1)
	stfd 30,224(1)
	stfd 31,232(1)
	stmw 22,160(1)
	stw 0,244(1)
	addi 29,1,32
	mr 30,3
	mr 31,4
	mr 27,5
	mr 4,27
	mr 5,29
	mr 3,31
	mr 24,29
	bl VectorMA
	lis 9,gi@ha
	lis 3,.LC170@ha
	la 28,gi@l(9)
	la 3,.LC170@l(3)
	lwz 9,36(28)
	mtlr 9
	blrl
	lis 9,.LC172@ha
	lwz 11,16(28)
	mr 5,3
	la 9,.LC172@l(9)
	li 4,0
	lfs 2,0(9)
	mtlr 11
	mr 3,30
	lis 9,.LC172@ha
	la 9,.LC172@l(9)
	lfs 3,0(9)
	lis 9,.LC173@ha
	la 9,.LC173@l(9)
	lfs 1,0(9)
	blrl
	lwz 11,48(28)
	addi 3,1,64
	mr 4,31
	li 5,0
	li 6,0
	mr 7,29
	mr 8,30
	mtlr 11
	li 9,1
	blrl
	lwz 3,116(1)
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L358
	li 9,0
	mr 4,30
	li 0,4
	stw 9,12(1)
	mr 5,4
	stw 0,8(1)
	li 6,0
	mr 7,24
	li 8,0
	li 9,10000
	li 10,1
	bl T_Damage
.L358:
	lfs 11,0(31)
	lis 9,.LC174@ha
	addi 3,1,48
	lfs 0,76(1)
	la 9,.LC174@l(9)
	addi 25,1,16
	lfs 13,4(31)
	addi 23,1,76
	addi 22,1,88
	lfs 12,84(1)
	li 26,0
	mr 30,24
	fsubs 11,11,0
	lfs 10,80(1)
	lis 29,0x4330
	lfs 0,8(31)
	lfd 31,0(9)
	lis 9,.LC175@ha
	fsubs 13,13,10
	stfs 11,48(1)
	la 9,.LC175@l(9)
	fsubs 0,0,12
	lfs 28,0(9)
	lis 9,.LC176@ha
	stfs 13,52(1)
	la 9,.LC176@l(9)
	stfs 0,56(1)
	lfs 29,0(9)
	bl VectorLength
	lis 9,.LC177@ha
	lfs 12,8(31)
	la 9,.LC177@l(9)
	lfs 13,4(31)
	lfs 0,0(9)
	lis 9,.LC171@ha
	lfs 30,.LC171@l(9)
	fdivs 27,1,0
	lfs 0,0(31)
	stfs 13,20(1)
	stfs 12,24(1)
	stfs 0,16(1)
.L362:
	fmr 1,27
	addi 3,1,16
	mr 5,30
	mr 4,27
	bl VectorMA
	bl rand
	rlwinm 3,3,0,17,31
	lfs 13,32(1)
	xoris 3,3,0x8000
	stw 3,156(1)
	stw 29,152(1)
	lfd 0,152(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmsubs 0,0,28,29
	fadds 13,13,0
	stfs 13,32(1)
	bl rand
	rlwinm 0,3,0,17,31
	lfs 13,36(1)
	xoris 0,0,0x8000
	mr 3,25
	stw 0,156(1)
	mr 4,30
	stw 29,152(1)
	lfd 0,152(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmsubs 0,0,28,29
	fadds 13,13,0
	stfs 13,36(1)
	bl spawn_templaser
	lis 9,.LC178@ha
	addi 5,1,128
	la 9,.LC178@l(9)
	mr 4,27
	lfs 1,0(9)
	mr 3,30
	fmuls 1,27,1
	bl VectorMA
	bl rand
	rlwinm 3,3,0,17,31
	lfs 13,128(1)
	xoris 3,3,0x8000
	stw 3,156(1)
	stw 29,152(1)
	lfd 0,152(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmsubs 0,0,28,29
	fadds 13,13,0
	stfs 13,128(1)
	bl rand
	rlwinm 0,3,0,17,31
	lfs 13,132(1)
	xoris 0,0,0x8000
	mr 3,30
	stw 0,156(1)
	addi 4,1,128
	stw 29,152(1)
	lfd 0,152(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmsubs 0,0,28,29
	fadds 13,13,0
	stfs 13,132(1)
	bl spawn_templaser
	lwz 9,52(28)
	mr 3,30
	mtlr 9
	blrl
	cmpwi 0,3,1
	bc 12,2,.L360
	addi 26,26,1
	lfs 0,32(1)
	lfs 12,36(1)
	cmpwi 0,26,3
	lfs 13,40(1)
	stfs 0,16(1)
	stfs 12,20(1)
	stfs 13,24(1)
	bc 4,1,.L362
.L360:
	addi 4,1,76
	mr 3,24
	bl spawn_templaser
	lwz 9,100(28)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(28)
	li 3,25
	mtlr 9
	blrl
	lwz 9,100(28)
	li 3,8
	mtlr 9
	blrl
	lwz 9,120(28)
	mr 3,23
	mtlr 9
	blrl
	lwz 9,124(28)
	mr 3,22
	mtlr 9
	blrl
	lwz 9,100(28)
	li 3,169
	mtlr 9
	blrl
	lwz 0,88(28)
	mr 3,23
	li 4,2
	mtlr 0
	blrl
	lwz 0,244(1)
	mtlr 0
	lmw 22,160(1)
	lfd 27,200(1)
	lfd 28,208(1)
	lfd 29,216(1)
	lfd 30,224(1)
	lfd 31,232(1)
	la 1,240(1)
	blr
.Lfe26:
	.size	 lightning_strike,.Lfe26-lightning_strike
	.section	".rodata"
	.align 2
.LC179:
	.string	"models/objects/rain/tris.md2"
	.align 2
.LC180:
	.string	"rain drop"
	.align 2
.LC181:
	.long 0x46fffe00
	.align 3
.LC182:
	.long 0x3fefae14
	.long 0x7ae147ae
	.align 3
.LC183:
	.long 0x3fd99999
	.long 0x9999999a
	.align 3
.LC184:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC185:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC186:
	.long 0x46000000
	.align 2
.LC187:
	.long 0x44000000
	.align 2
.LC188:
	.long 0x43800000
	.section	".text"
	.align 2
	.globl misc_rain_think
	.type	 misc_rain_think,@function
misc_rain_think:
	stwu 1,-256(1)
	mflr 0
	stfd 25,200(1)
	stfd 26,208(1)
	stfd 27,216(1)
	stfd 28,224(1)
	stfd 29,232(1)
	stfd 30,240(1)
	stfd 31,248(1)
	stmw 16,136(1)
	stw 0,260(1)
	mr 31,3
	addi 29,1,72
	bl rand
	addi 28,31,16
	mr 16,29
	rlwinm 3,3,0,17,31
	lwz 0,480(31)
	xoris 3,3,0x8000
	lis 8,0x4330
	stw 3,132(1)
	lis 10,.LC185@ha
	mr 11,9
	stw 8,128(1)
	la 10,.LC185@l(10)
	xoris 0,0,0x8000
	lfd 0,0(10)
	mr 6,9
	lis 7,0xbf80
	lfd 12,128(1)
	lis 10,.LC181@ha
	addi 3,31,4
	lfs 31,.LC181@l(10)
	li 9,0
	mr 4,28
	stw 0,132(1)
	lis 10,.LC186@ha
	mr 5,29
	fsub 12,12,0
	stw 8,128(1)
	la 10,.LC186@l(10)
	li 20,1
	lfd 13,128(1)
	lis 17,level@ha
	lfs 1,0(10)
	frsp 12,12
	stw 9,108(1)
	fsub 13,13,0
	stw 7,112(1)
	stw 9,104(1)
	fdivs 12,12,31
	frsp 13,13
	fmuls 12,12,13
	fmr 0,12
	fctiwz 11,0
	stfd 11,128(1)
	lwz 30,132(1)
	bl VectorMA
	cmpwi 0,30,0
	bc 4,1,.L373
	lis 9,.LC182@ha
	lis 10,drop_touch@ha
	fmr 28,31
	lfd 25,.LC182@l(9)
	la 18,drop_touch@l(10)
	lis 8,.LC183@ha
	lis 9,G_FreeEdict@ha
	lis 10,.LC187@ha
	lfd 26,.LC183@l(8)
	la 19,G_FreeEdict@l(9)
	la 10,.LC187@l(10)
	lis 9,.LC185@ha
	lfs 27,0(10)
	lis 11,gi@ha
	la 9,.LC185@l(9)
	la 27,gi@l(11)
	lfd 29,0(9)
	mr 22,28
	mr 23,30
	lis 21,0x4330
	addi 26,1,88
	li 25,0
	addi 24,1,20
.L375:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,132(1)
	stw 21,128(1)
	lfd 30,128(1)
	fsub 30,30,29
	frsp 30,30
	fdivs 30,30,28
	fmuls 30,30,27
	bl rand
	rlwinm 3,3,0,17,31
	lfs 13,4(31)
	xoris 3,3,0x8000
	lis 10,.LC188@ha
	lfs 12,8(31)
	stw 3,132(1)
	la 10,.LC188@l(10)
	addi 4,31,4
	stw 21,128(1)
	addi 3,1,8
	li 5,0
	lfd 31,128(1)
	li 6,0
	mr 7,26
	lfs 11,0(10)
	mr 8,31
	li 9,1
	lwz 11,48(27)
	fsub 31,31,29
	lfs 0,12(31)
	fsubs 30,30,11
	mtlr 11
	frsp 31,31
	stfs 0,96(1)
	fadds 13,13,30
	fdivs 31,31,28
	stfs 13,88(1)
	fmsubs 31,31,27,11
	fadds 12,12,31
	stfs 12,92(1)
	blrl
	lfs 10,72(1)
	addi 3,1,8
	mr 4,26
	lfs 11,76(1)
	li 5,0
	li 6,0
	lwz 11,48(27)
	mr 7,16
	mr 8,31
	fadds 10,10,30
	lfs 0,20(1)
	li 9,1
	fadds 11,11,31
	lfs 13,24(1)
	mtlr 11
	lfs 12,28(1)
	stfs 0,88(1)
	stfs 13,92(1)
	stfs 12,96(1)
	stfs 10,72(1)
	stfs 11,76(1)
	blrl
	cmpwi 0,20,0
	bc 12,2,.L376
	bl rand
	li 20,0
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,132(1)
	stw 21,128(1)
	lfd 0,128(1)
	fsub 0,0,29
	frsp 0,0
	fdivs 0,0,28
	fmr 13,0
	fcmpu 0,13,25
	bc 4,1,.L376
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L376
	lis 10,.LC186@ha
	mr 3,31
	la 10,.LC186@l(10)
	mr 4,26
	lfs 1,0(10)
	addi 5,1,104
	bl lightning_strike
.L376:
	lis 9,.LC186@ha
	lfs 0,16(1)
	la 9,.LC186@l(9)
	lfs 12,328(31)
	lfs 13,0(9)
	fmuls 0,0,13
	fdivs 30,0,12
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,132(1)
	stw 21,128(1)
	lfd 0,128(1)
	fsub 0,0,29
	frsp 0,0
	fdivs 0,0,28
	fmr 13,0
	fcmpu 0,13,26
	bc 4,1,.L378
	lwz 0,284(31)
	andi. 28,0,2
	bc 4,2,.L383
	addi 30,1,20
	lfs 31,328(31)
	bl G_Spawn
	lfs 13,88(1)
	mr 29,3
	fmr 1,31
	mr 3,22
	addi 4,29,376
	stfs 13,4(29)
	lfs 0,92(1)
	stfs 0,8(29)
	lfs 13,96(1)
	stfs 13,12(29)
	lfs 0,16(31)
	stfs 0,16(29)
	lfs 13,4(22)
	stfs 13,20(29)
	lfs 0,8(22)
	stfs 0,24(29)
	bl VectorScale
	lis 0,0x600
	li 9,8
	stw 28,248(29)
	ori 0,0,3
	stw 9,260(29)
	lis 3,.LC179@ha
	stw 0,252(29)
	la 3,.LC179@l(3)
	stw 25,196(29)
	stw 25,192(29)
	stw 25,188(29)
	stw 25,208(29)
	stw 25,204(29)
	stw 25,200(29)
	lwz 9,32(27)
	mtlr 9
	blrl
	stw 3,40(29)
	la 11,level@l(17)
	lis 9,.LC180@ha
	stw 31,256(29)
	la 9,.LC180@l(9)
	stw 18,444(29)
	lfs 0,4(11)
	stw 9,280(29)
	stw 19,436(29)
	fadds 0,0,30
	stfs 0,428(29)
	b .L380
.L378:
	lwz 0,284(31)
	addi 30,1,20
	andi. 9,0,2
	bc 12,2,.L380
.L383:
	lwz 9,100(27)
	li 3,3
	mr 30,24
	mtlr 9
	blrl
	lwz 9,100(27)
	li 3,11
	mtlr 9
	blrl
	lwz 9,120(27)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,120(27)
	mr 3,24
	mtlr 9
	blrl
	lwz 9,88(27)
	mr 3,24
	li 4,2
	mtlr 9
	blrl
.L380:
	lwz 9,100(27)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(27)
	li 3,10
	mtlr 9
	blrl
	lwz 9,100(27)
	li 3,8
	mtlr 9
	blrl
	lwz 9,120(27)
	mr 3,30
	mtlr 9
	blrl
	lwz 9,124(27)
	addi 3,1,32
	mtlr 9
	blrl
	lwz 9,100(27)
	li 3,2
	mtlr 9
	blrl
	lwz 9,88(27)
	mr 3,30
	li 4,2
	mtlr 9
	blrl
	addic. 23,23,-1
	bc 4,2,.L375
.L373:
	lis 9,level+4@ha
	lis 11,.LC184@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC184@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,260(1)
	mtlr 0
	lmw 16,136(1)
	lfd 25,200(1)
	lfd 26,208(1)
	lfd 27,216(1)
	lfd 28,224(1)
	lfd 29,232(1)
	lfd 30,240(1)
	lfd 31,248(1)
	la 1,256(1)
	blr
.Lfe27:
	.size	 misc_rain_think,.Lfe27-misc_rain_think
	.section	".rodata"
	.align 2
.LC189:
	.long 0x46fffe00
	.align 2
.LC190:
	.long 0x439d8000
	.align 3
.LC191:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC192:
	.long 0x0
	.align 2
.LC193:
	.long 0x42340000
	.align 2
.LC194:
	.long 0x42b40000
	.align 2
.LC195:
	.long 0x43070000
	.align 2
.LC196:
	.long 0x43340000
	.align 2
.LC197:
	.long 0x43610000
	.align 2
.LC198:
	.long 0x43870000
	.section	".text"
	.align 2
	.globl SP_misc_rain
	.type	 SP_misc_rain,@function
SP_misc_rain:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 9,misc_rain_think@ha
	mr 31,3
	li 0,0
	la 9,misc_rain_think@l(9)
	stw 0,248(31)
	stw 9,436(31)
	stw 0,260(31)
	bl rand
	rlwinm 3,3,0,17,31
	lwz 8,480(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC191@ha
	lis 10,.LC189@ha
	la 11,.LC191@l(11)
	stw 0,16(1)
	cmpwi 0,8,0
	lfd 12,0(11)
	lfd 0,16(1)
	lis 11,level+4@ha
	lfs 11,.LC189@l(10)
	lfs 13,level+4@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 0,0,11
	fadds 13,13,0
	stfs 13,428(31)
	bc 4,2,.L385
	li 0,12
	stw 0,480(31)
.L385:
	lis 9,.LC192@ha
	lfs 13,328(31)
	la 9,.LC192@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L386
	lis 0,0x43fa
	stw 0,328(31)
.L386:
	lis 11,.LC192@ha
	lfs 13,20(31)
	la 11,.LC192@l(11)
	lfs 12,0(11)
	fcmpu 0,13,12
	bc 12,0,.L403
	bc 4,2,.L389
	lis 0,0x3e80
	b .L405
.L389:
	lis 9,.LC193@ha
	la 9,.LC193@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L391
	lis 9,0x3e80
	b .L406
.L391:
	lis 11,.LC194@ha
	la 11,.LC194@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L393
	lis 0,0x3e80
	b .L407
.L393:
	lis 9,.LC195@ha
	la 9,.LC195@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L395
	lis 0,0xbe80
	lis 9,0x3e80
	b .L408
.L395:
	lis 11,.LC196@ha
	la 11,.LC196@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L397
	lis 0,0xbe80
.L405:
	lis 9,0xbf80
	stfs 12,20(31)
	stw 0,16(31)
	stw 9,24(31)
	b .L388
.L397:
	lis 9,.LC197@ha
	la 9,.LC197@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L399
	lis 9,0xbe80
.L406:
	lis 0,0xbf80
	stw 9,20(31)
	stw 0,24(31)
	stw 9,16(31)
	b .L388
.L399:
	lis 11,.LC198@ha
	la 11,.LC198@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L401
	lis 0,0xbe80
.L407:
	lis 9,0xbf80
	stfs 12,16(31)
	stw 0,20(31)
	stw 9,24(31)
	b .L388
.L401:
	lis 9,.LC190@ha
	lfs 0,.LC190@l(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L403
	lis 0,0x3e80
	lis 9,0xbe80
.L408:
	lis 11,0xbf80
	stw 0,16(31)
	stw 9,20(31)
	stw 11,24(31)
	b .L388
.L403:
	lis 0,0xbf80
	stfs 12,20(31)
	stw 0,24(31)
	stfs 12,16(31)
.L388:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe28:
	.size	 SP_misc_rain,.Lfe28-SP_misc_rain
	.section	".rodata"
	.align 2
.LC206:
	.string	"game"
	.align 2
.LC207:
	.string	"basedir"
	.align 2
.LC208:
	.string	"."
	.align 2
.LC209:
	.string	"baseq2"
	.align 2
.LC210:
	.string	"%s\\%s\\%sanim.txt"
	.align 2
.LC211:
	.string	"rt"
	.align 2
.LC212:
	.string	"ERROR %s not found"
	.align 2
.LC213:
	.string	"%i "
	.align 2
.LC214:
	.string	"%i\n "
	.align 2
.LC215:
	.string	"SCRIPT = %s %i %i %i\n"
	.section	".text"
	.align 2
	.globl misc_object_parse
	.type	 misc_object_parse,@function
misc_object_parse:
	stwu 1,-176(1)
	mflr 0
	stmw 27,156(1)
	stw 0,180(1)
	lis 9,gi@ha
	mr 30,3
	la 27,gi@l(9)
	lis 29,.LC139@ha
	lwz 9,144(27)
	lis 3,.LC206@ha
	la 4,.LC139@l(29)
	li 5,0
	la 3,.LC206@l(3)
	mtlr 9
	blrl
	mr 31,3
	lwz 9,144(27)
	lis 4,.LC208@ha
	lis 3,.LC207@ha
	la 4,.LC208@l(4)
	li 5,0
	mtlr 9
	la 3,.LC207@l(3)
	blrl
	mr 28,3
	la 4,.LC139@l(29)
	lwz 3,4(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L425
	lis 4,.LC209@ha
	lwz 3,4(31)
	la 4,.LC209@l(4)
	crxor 6,6,6
	bl sprintf
.L425:
	lwz 5,4(28)
	lis 4,.LC210@ha
	addi 3,1,8
	lwz 6,4(31)
	la 4,.LC210@l(4)
	lwz 7,276(30)
	crxor 6,6,6
	bl sprintf
	lis 4,.LC211@ha
	addi 3,1,8
	la 4,.LC211@l(4)
	bl fopen
	mr. 29,3
	bc 4,2,.L426
	lwz 0,4(27)
	lis 3,.LC212@ha
	addi 4,1,8
	la 3,.LC212@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L424
.L426:
	lwz 0,644(30)
	li 31,0
	addic. 9,0,1
	bc 4,1,.L428
	lis 28,.LC213@ha
	lis 27,.LC214@ha
.L430:
	addi 5,1,136
	la 4,.LC213@l(28)
	mr 3,29
	addi 31,31,1
	crxor 6,6,6
	bl fscanf
	addi 5,1,140
	la 4,.LC213@l(28)
	mr 3,29
	crxor 6,6,6
	bl fscanf
	mr 3,29
	la 4,.LC214@l(27)
	addi 5,1,144
	crxor 6,6,6
	bl fscanf
	lwz 9,644(30)
	addi 9,9,1
	cmpw 0,31,9
	bc 12,0,.L430
.L428:
	lis 9,gi+4@ha
	lis 3,.LC215@ha
	lwz 5,136(1)
	lwz 0,gi+4@l(9)
	la 3,.LC215@l(3)
	addi 4,1,8
	lwz 6,140(1)
	mtlr 0
	lwz 7,144(1)
	crxor 6,6,6
	blrl
	lwz 9,136(1)
	mr 3,29
	lwz 11,140(1)
	lwz 0,144(1)
	stw 9,968(30)
	stw 0,960(30)
	stw 11,964(30)
	bl fclose
.L424:
	lwz 0,180(1)
	mtlr 0
	lmw 27,156(1)
	la 1,176(1)
	blr
.Lfe29:
	.size	 misc_object_parse,.Lfe29-misc_object_parse
	.section	".rodata"
	.align 2
.LC216:
	.string	"%stris%i.md2"
	.align 2
.LC217:
	.string	"%stris.md2"
	.align 2
.LC218:
	.string	"%s %f %f %f\n"
	.align 3
.LC219:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC220:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_misc_object
	.type	 SP_misc_object,@function
SP_misc_object:
	stwu 1,-272(1)
	mflr 0
	stw 31,268(1)
	stw 0,276(1)
	mr 31,3
	li 9,0
	lwz 0,276(31)
	stw 9,56(31)
	cmpwi 0,0,0
	stw 9,260(31)
	bc 4,2,.L433
	bl G_FreeEdict
.L433:
	lwz 6,644(31)
	cmpwi 0,6,0
	bc 12,2,.L434
	lwz 5,276(31)
	lis 4,.LC216@ha
	addi 3,1,8
	la 4,.LC216@l(4)
	crxor 6,6,6
	bl sprintf
	b .L449
.L434:
	lwz 5,276(31)
	lis 4,.LC217@ha
	addi 3,1,8
	la 4,.LC217@l(4)
	crxor 6,6,6
	bl sprintf
.L449:
	lis 9,gi+32@ha
	addi 3,1,8
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
	stw 3,40(31)
	lfs 1,188(31)
	lis 9,gi+4@ha
	lis 3,.LC218@ha
	lfs 2,192(31)
	la 3,.LC218@l(3)
	addi 4,1,8
	lfs 3,196(31)
	lwz 0,gi+4@l(9)
	mtlr 0
	creqv 6,6,6
	blrl
	lwz 0,956(31)
	cmpwi 0,0,0
	bc 12,2,.L436
	li 0,2
.L436:
	stw 0,248(31)
	lwz 0,284(31)
	andi. 9,0,8
	bc 12,2,.L438
	mr 3,31
	bl misc_object_parse
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 12,2,.L438
	lis 9,misc_object_killed@ha
	lis 11,misc_object_pain@ha
	la 9,misc_object_killed@l(9)
	la 11,misc_object_pain@l(11)
	li 0,2
	stw 9,456(31)
	stw 0,512(31)
	stw 11,452(31)
.L438:
	lwz 0,284(31)
	andi. 9,0,16
	bc 12,2,.L440
	lwz 0,64(31)
	oris 0,0,0x1000
	stw 0,64(31)
.L440:
	lwz 0,284(31)
	andi. 9,0,32
	bc 12,2,.L441
	lis 11,level+4@ha
	lis 10,.LC219@ha
	lfs 0,level+4@l(11)
	lis 9,misc_object_think@ha
	lfd 13,.LC219@l(10)
	la 9,misc_object_think@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L441:
	lwz 0,400(31)
	cmpwi 0,0,0
	bc 4,2,.L442
	li 0,100
	stw 0,400(31)
.L442:
	lwz 0,284(31)
	andi. 9,0,64
	bc 12,2,.L443
	lis 9,misc_object_touch@ha
	li 0,5
	la 9,misc_object_touch@l(9)
	stw 0,260(31)
	stw 9,444(31)
.L443:
	lwz 0,284(31)
	andi. 9,0,128
	bc 12,2,.L444
	lwz 0,64(31)
	ori 0,0,1
	stw 0,64(31)
.L444:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L445
	lwz 0,64(31)
	oris 0,0,0x80
	stw 0,64(31)
.L445:
	lwz 0,284(31)
	andi. 0,0,66
	cmpwi 0,0,2
	bc 4,2,.L446
	li 0,10
	stw 0,260(31)
.L446:
	lis 9,.LC220@ha
	lfs 0,188(31)
	la 9,.LC220@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L447
	lfs 0,192(31)
	fcmpu 0,0,13
	bc 4,2,.L447
	lfs 0,196(31)
	fcmpu 0,0,13
	bc 4,2,.L447
	lis 9,0xc200
	lis 0,0xc180
	stw 9,192(31)
	stw 0,196(31)
	stw 9,188(31)
.L447:
	lis 9,.LC220@ha
	lfs 0,200(31)
	la 9,.LC220@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L448
	lfs 0,204(31)
	fcmpu 0,0,13
	bc 4,2,.L448
	lfs 0,208(31)
	fcmpu 0,0,13
	bc 4,2,.L448
	lis 0,0x4200
	stw 0,208(31)
	stw 0,200(31)
	stw 0,204(31)
.L448:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,276(1)
	mtlr 0
	lwz 31,268(1)
	la 1,272(1)
	blr
.Lfe30:
	.size	 SP_misc_object,.Lfe30-SP_misc_object
	.section	".rodata"
	.align 2
.LC222:
	.string	"models/objects/flame/tris.md2"
	.align 2
.LC224:
	.string	"misc_setlights has bad value (%s) at %s\n"
	.align 3
.LC225:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC226:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_misc_flyby
	.type	 SP_misc_flyby,@function
SP_misc_flyby:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L462
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,212
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC115@ha
	la 3,.LC115@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L461
.L462:
	lis 9,.LC226@ha
	lfs 13,328(31)
	la 9,.LC226@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L463
	lis 0,0x4396
	stw 0,328(31)
.L463:
	lwz 3,276(31)
	li 0,2
	stw 0,248(31)
	cmpwi 0,3,0
	stw 0,260(31)
	bc 4,2,.L464
	lis 9,gi+32@ha
	lis 3,.LC116@ha
	lwz 0,gi+32@l(9)
	la 3,.LC116@l(3)
	b .L466
.L464:
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
.L466:
	mtlr 0
	blrl
	stw 3,40(31)
	lis 11,func_train_find@ha
	lis 4,0xc180
	lfs 13,328(31)
	la 11,func_train_find@l(11)
	lis 7,0x4180
	stw 4,192(31)
	li 0,0
	lis 10,0x4200
	stw 11,436(31)
	stw 7,204(31)
	lis 6,level+4@ha
	lis 5,.LC225@ha
	stw 0,196(31)
	lis 9,misc_flyby_use@ha
	lis 11,gi+72@ha
	stw 10,208(31)
	la 9,misc_flyby_use@l(9)
	mr 3,31
	stw 4,188(31)
	stw 7,200(31)
	lfs 0,level+4@l(6)
	lfd 12,.LC225@l(5)
	lwz 8,184(31)
	stw 9,448(31)
	ori 8,8,1
	stfs 13,712(31)
	stw 8,184(31)
	fadd 0,0,12
	stfs 13,716(31)
	stfs 13,720(31)
	frsp 0,0
	stfs 0,428(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L461:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe31:
	.size	 SP_misc_flyby,.Lfe31-SP_misc_flyby
	.section	".rodata"
	.align 2
.LC227:
	.long 0x4cbebc20
	.align 2
.LC228:
	.long 0x42800000
	.align 2
.LC229:
	.long 0x0
	.section	".text"
	.align 2
	.globl misc_highlight_touch
	.type	 misc_highlight_touch,@function
misc_highlight_touch:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,4
	mr 30,3
	lwz 0,416(31)
	cmpw 0,0,30
	bc 4,2,.L467
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L467
	lfs 11,4(31)
	addi 3,1,8
	lfs 12,4(30)
	lfs 13,8(30)
	lfs 10,8(31)
	fsubs 12,12,11
	lfs 0,12(30)
	lfs 11,12(31)
	fsubs 13,13,10
	stfs 12,8(1)
	fsubs 0,0,11
	stfs 13,12(1)
	stfs 0,16(1)
	bl VectorLengthSquared
	lis 9,.LC228@ha
	la 9,.LC228@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,1,.L467
	lwz 9,312(30)
	lwz 0,284(30)
	cmpwi 0,9,0
	ori 0,0,128
	stw 0,284(30)
	bc 12,2,.L471
	lwz 29,296(30)
	mr 3,30
	mr 4,31
	stw 9,296(30)
	bl G_UseTargets
	stw 29,296(30)
.L471:
	lwz 3,296(30)
	cmpwi 0,3,0
	bc 12,2,.L472
	bl G_PickTarget
	b .L473
.L472:
	li 3,0
.L473:
	lwz 0,284(30)
	andi. 9,0,8
	bc 4,2,.L474
	stw 3,412(31)
	stw 3,416(31)
.L474:
	lwz 0,284(30)
	andi. 9,0,1
	bc 12,2,.L475
	lwz 0,284(31)
	rlwinm 0,0,0,29,27
	b .L485
.L475:
	andi. 9,0,2
	bc 12,2,.L477
	lwz 0,284(31)
	rlwinm 0,0,0,29,27
	b .L485
.L477:
	andi. 9,0,4
	bc 4,2,.L479
	andi. 9,0,8
	bc 12,2,.L476
	lwz 0,952(31)
	mr 3,31
	lwz 11,788(31)
	ori 0,0,8
	stw 0,952(31)
	mtlr 11
	lfs 0,16(30)
	stfs 0,16(31)
	lfs 13,20(30)
	stfs 13,20(31)
	lfs 0,24(30)
	stfs 0,24(31)
	blrl
	b .L467
.L479:
	lwz 0,284(31)
	ori 0,0,8
.L485:
	stw 0,284(31)
.L476:
	lis 9,.LC229@ha
	lfs 13,592(30)
	la 9,.LC229@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L482
	lfs 13,20(30)
	lis 9,level+4@ha
	mr 3,31
	lwz 11,788(31)
	stfs 13,20(31)
	mtlr 11
	lfs 0,4(30)
	stfs 0,4(31)
	lfs 13,8(30)
	stfs 13,8(31)
	lfs 0,level+4@l(9)
	lfs 13,592(30)
	b .L486
.L482:
	lwz 0,416(31)
	cmpwi 0,0,0
	bc 4,2,.L483
	lis 9,level+4@ha
	lis 11,.LC227@ha
	lwz 10,788(31)
	lfs 0,level+4@l(9)
	mr 3,31
	lfs 13,.LC227@l(11)
	mtlr 10
.L486:
	fadds 0,0,13
	stfs 0,828(31)
	blrl
	b .L467
.L483:
	lwz 9,412(31)
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
.L467:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe32:
	.size	 misc_highlight_touch,.Lfe32-misc_highlight_touch
	.section	".rodata"
	.align 2
.LC230:
	.string	"misc_highlight"
	.align 2
.LC231:
	.long 0x46fffe00
	.align 3
.LC232:
	.long 0x4062c000
	.long 0x0
	.align 3
.LC233:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC234:
	.long 0x3f800000
	.align 2
.LC235:
	.long 0x0
	.align 3
.LC236:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC237:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC238:
	.long 0x40590000
	.long 0x0
	.section	".text"
	.align 2
	.globl misc_bigbolt_earthquake_think
	.type	 misc_bigbolt_earthquake_think,@function
misc_bigbolt_earthquake_think:
	stwu 1,-80(1)
	mflr 0
	stfd 27,40(1)
	stfd 28,48(1)
	stfd 29,56(1)
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 26,16(1)
	stw 0,84(1)
	lis 9,level@ha
	mr 30,3
	la 31,level@l(9)
	lfs 13,476(30)
	lfs 0,4(31)
	fcmpu 0,13,0
	bc 4,0,.L500
	lis 9,gi+20@ha
	lwz 3,324(30)
	mr 4,30
	lwz 0,gi+20@l(9)
	li 5,0
	lis 9,.LC234@ha
	addi 3,3,4
	lwz 6,576(30)
	la 9,.LC234@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC235@ha
	la 9,.LC235@l(9)
	lfs 2,0(9)
	lis 9,.LC235@ha
	la 9,.LC235@l(9)
	lfs 3,0(9)
	blrl
	lfs 0,4(31)
	lis 9,.LC236@ha
	la 9,.LC236@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,476(30)
.L500:
	lis 9,globals@ha
	li 29,1
	la 10,globals@l(9)
	lis 11,g_edicts@ha
	lwz 0,72(10)
	lwz 9,g_edicts@l(11)
	cmpw 0,29,0
	addi 31,9,1076
	bc 4,0,.L502
	lis 9,.LC231@ha
	lis 11,.LC232@ha
	lfs 28,.LC231@l(9)
	mr 26,10
	li 27,0
	lis 9,.LC237@ha
	lfd 29,.LC232@l(11)
	lis 28,0x4330
	la 9,.LC237@l(9)
	lfd 31,0(9)
	lis 9,.LC236@ha
	la 9,.LC236@l(9)
	lfd 30,0(9)
	lis 9,.LC238@ha
	la 9,.LC238@l(9)
	lfd 27,0(9)
.L504:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L503
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L503
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L503
	stw 27,552(31)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,376(31)
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 28,8(1)
	lfd 13,8(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,29,12
	frsp 0,0
	stfs 0,376(31)
	bl rand
	rlwinm 3,3,0,17,31
	lwz 0,400(31)
	xoris 3,3,0x8000
	mr 11,9
	lfs 11,380(31)
	stw 3,12(1)
	xoris 0,0,0x8000
	stw 28,8(1)
	lfd 13,8(1)
	stw 0,12(1)
	stw 28,8(1)
	fsub 13,13,31
	lfd 12,8(1)
	frsp 13,13
	fsub 12,12,31
	fdivs 13,13,28
	fdiv 12,27,12
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,29,11
	frsp 0,0
	stfs 0,380(31)
	lfs 13,328(30)
	fmul 13,13,12
	frsp 13,13
	stfs 13,384(31)
.L503:
	lwz 0,72(26)
	addi 29,29,1
	addi 31,31,1076
	cmpw 0,29,0
	bc 12,0,.L504
.L502:
	lis 9,level+4@ha
	lfs 0,288(30)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L509
	fmr 0,13
	lis 9,.LC233@ha
	lfd 13,.LC233@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
.L509:
	lwz 0,84(1)
	mtlr 0
	lmw 26,16(1)
	lfd 27,40(1)
	lfd 28,48(1)
	lfd 29,56(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe33:
	.size	 misc_bigbolt_earthquake_think,.Lfe33-misc_bigbolt_earthquake_think
	.section	".rodata"
	.align 2
.LC239:
	.long 0x3f000000
	.align 2
.LC240:
	.long 0x45000000
	.align 3
.LC241:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl misc_bigbolt_laser_think
	.type	 misc_bigbolt_laser_think,@function
misc_bigbolt_laser_think:
	stwu 1,-176(1)
	mflr 0
	stmw 26,152(1)
	stw 0,180(1)
	mr 31,3
	lwz 9,284(31)
	lwz 3,540(31)
	cmpwi 7,9,0
	cmpwi 0,3,0
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	nor 9,0,0
	rlwinm 0,0,0,29,29
	rlwinm 9,9,0,28,28
	or 26,0,9
	bc 12,2,.L513
	lis 9,.LC239@ha
	lfs 12,340(31)
	addi 4,3,236
	lfs 13,344(31)
	la 9,.LC239@l(9)
	addi 5,1,112
	lfs 0,348(31)
	addi 3,3,212
	addi 29,31,340
	lfs 1,0(9)
	stfs 12,128(1)
	stfs 13,132(1)
	stfs 0,136(1)
	bl VectorMA
	lfs 12,112(1)
	mr 3,29
	lfs 11,4(31)
	lfs 13,116(1)
	lfs 0,120(1)
	fsubs 12,12,11
	lfs 10,8(31)
	lfs 11,12(31)
	fsubs 13,13,10
	stfs 12,340(31)
	fsubs 0,0,11
	stfs 13,344(31)
	stfs 0,348(31)
	bl VectorNormalize
	mr 3,29
	addi 4,1,128
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L513
	lwz 0,284(31)
	oris 0,0,0x8000
	stw 0,284(31)
.L513:
	lis 9,.LC240@ha
	lfs 12,4(31)
	addi 28,1,32
	lfs 13,8(31)
	la 9,.LC240@l(9)
	addi 29,31,340
	lfs 0,12(31)
	addi 3,1,16
	mr 4,29
	lfs 1,0(9)
	mr 5,28
	mr 30,31
	stfs 12,16(1)
	stfs 13,20(1)
	stfs 0,24(1)
	bl VectorMA
	mr 27,29
	addi 29,1,48
	b .L517
.L518:
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L519
	lwz 0,264(3)
	andi. 9,0,4
	bc 4,2,.L519
	lwz 5,548(31)
	li 0,4
	li 11,30
	lwz 9,516(31)
	lis 8,vec3_origin@ha
	mr 4,31
	stw 0,8(1)
	la 8,vec3_origin@l(8)
	mr 6,27
	stw 11,12(1)
	addi 7,1,60
	li 10,1
	bl T_Damage
.L519:
	lwz 9,100(1)
	lwz 0,184(9)
	mr 8,9
	andi. 9,0,4
	bc 4,2,.L520
	lwz 0,84(8)
	cmpwi 0,0,0
	bc 4,2,.L520
	lwz 0,284(31)
	cmpwi 0,0,0
	bc 4,0,.L516
	rlwinm 0,0,0,1,31
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,284(31)
	li 3,3
	lwz 9,100(29)
	addi 28,1,60
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,15
	mtlr 9
	blrl
	lwz 9,100(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,124(29)
	addi 3,1,72
	mtlr 9
	blrl
	lwz 9,100(29)
	lwz 3,60(31)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	b .L516
.L520:
	lfs 0,60(1)
	mr 30,8
	lfs 13,64(1)
	lfs 12,68(1)
	stfs 0,16(1)
	stfs 13,20(1)
	stfs 12,24(1)
.L517:
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	mr 3,29
	mr 8,30
	addi 4,1,16
	li 5,0
	li 6,0
	mr 7,28
	mtlr 0
	ori 9,9,1
	blrl
	lwz 3,100(1)
	cmpwi 0,3,0
	bc 4,2,.L518
.L516:
	lfs 0,64(1)
	lis 11,level+4@ha
	lis 9,.LC241@ha
	lfs 11,60(1)
	la 9,.LC241@l(9)
	lfs 13,68(1)
	stfs 0,32(31)
	stfs 11,28(31)
	stfs 13,36(31)
	lfs 0,level+4@l(11)
	lfd 12,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	stw 9,436(31)
	fadd 0,0,12
	frsp 0,0
	stfs 0,428(31)
	lwz 0,180(1)
	mtlr 0
	lmw 26,152(1)
	la 1,176(1)
	blr
.Lfe34:
	.size	 misc_bigbolt_laser_think,.Lfe34-misc_bigbolt_laser_think
	.section	".rodata"
	.align 3
.LC243:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC244:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl misc_bigbolt_use
	.type	 misc_bigbolt_use,@function
misc_bigbolt_use:
	stwu 1,-64(1)
	mflr 0
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 27,28(1)
	stw 0,68(1)
	mr 31,3
	lwz 0,532(31)
	lis 27,0x4330
	lis 11,.LC244@ha
	la 11,.LC244@l(11)
	lis 28,level@ha
	xoris 0,0,0x8000
	lfd 30,0(11)
	la 28,level@l(28)
	stw 0,20(1)
	lis 11,.LC243@ha
	stw 27,16(1)
	lfd 0,16(1)
	lfs 13,4(28)
	lfd 31,.LC243@l(11)
	fsub 0,0,30
	li 11,0
	frsp 0,0
	fadds 13,13,0
	stfs 13,288(31)
	lfs 0,4(28)
	stw 5,548(31)
	stw 11,476(31)
	fadd 0,0,31
	frsp 0,0
	stfs 0,428(31)
	bl G_Spawn
	lfs 0,4(31)
	mr 29,3
	lwz 9,284(29)
	stfs 0,4(29)
	ori 9,9,67
	lfs 13,8(31)
	stfs 13,8(29)
	lfs 0,12(31)
	stfs 0,12(29)
	lwz 0,296(31)
	stw 9,284(29)
	stw 0,296(29)
	bl target_laser_start
	lfs 0,4(28)
	lis 9,misc_bigbolt_laser_think@ha
	la 9,misc_bigbolt_laser_think@l(9)
	mr 5,31
	stw 9,436(29)
	li 6,0
	fadd 0,0,31
	frsp 0,0
	stfs 0,428(29)
	lwz 0,520(31)
	lwz 3,324(31)
	xoris 0,0,0x8000
	lfs 2,524(31)
	stw 0,20(1)
	mr 4,3
	stw 27,16(1)
	lfd 1,16(1)
	fsub 1,1,30
	frsp 1,1
	bl T_RadiusDamage
	lis 9,gi@ha
	li 3,3
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L526
	lwz 0,100(29)
	li 3,17
	mtlr 0
	blrl
	b .L527
.L526:
	lwz 0,100(29)
	li 3,7
	mtlr 0
	blrl
.L527:
	lis 29,gi@ha
	lwz 3,324(31)
	la 29,gi@l(29)
	lwz 9,120(29)
	addi 3,3,4
	mtlr 9
	blrl
	lwz 3,324(31)
	li 4,1
	lwz 0,88(29)
	addi 3,3,4
	mtlr 0
	blrl
	lwz 0,68(1)
	mtlr 0
	lmw 27,28(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe35:
	.size	 misc_bigbolt_use,.Lfe35-misc_bigbolt_use
	.section	".rodata"
	.align 2
.LC245:
	.string	"untargeted %s at %s\n"
	.align 2
.LC246:
	.string	"world/quake.wav"
	.align 2
.LC247:
	.long 0x0
	.align 3
.LC248:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SP_misc_bigbolt
	.type	 SP_misc_bigbolt,@function
SP_misc_bigbolt:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L529
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC245@ha
	la 3,.LC245@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
.L529:
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L530
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC145@ha
	la 3,.LC145@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
.L530:
	lwz 5,296(31)
	li 3,0
	li 4,300
	bl G_Find
	lwz 0,532(31)
	stw 3,324(31)
	cmpwi 0,0,0
	bc 4,2,.L531
	li 0,1
	stw 0,532(31)
.L531:
	lis 9,.LC247@ha
	lfs 13,328(31)
	la 9,.LC247@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L532
	lis 0,0x4348
	stw 0,328(31)
.L532:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L533
	li 0,200
	lis 9,0x4348
	stw 0,520(31)
	stw 9,524(31)
	b .L534
.L533:
	xoris 11,0,0x8000
	stw 0,520(31)
	stw 11,12(1)
	lis 0,0x4330
	lis 11,.LC248@ha
	stw 0,8(1)
	la 11,.LC248@l(11)
	lfd 0,8(1)
	lfd 13,0(11)
	fsub 0,0,13
	frsp 0,0
	stfs 0,524(31)
.L534:
	lwz 0,184(31)
	lis 9,misc_bigbolt_earthquake_think@ha
	lis 11,misc_bigbolt_use@ha
	la 9,misc_bigbolt_earthquake_think@l(9)
	la 11,misc_bigbolt_use@l(11)
	ori 0,0,1
	stw 9,436(31)
	lis 10,gi+36@ha
	stw 0,184(31)
	lis 3,.LC246@ha
	stw 11,448(31)
	la 3,.LC246@l(3)
	lwz 0,gi+36@l(10)
	mtlr 0
	blrl
	stw 3,576(31)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 SP_misc_bigbolt,.Lfe36-SP_misc_bigbolt
	.section	".rodata"
	.align 2
.LC249:
	.long 0x46fffe00
	.align 2
.LC250:
	.long 0x3f000000
	.align 3
.LC251:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC252:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC253:
	.long 0x0
	.align 2
.LC254:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl misc_rubble_use
	.type	 misc_rubble_use,@function
misc_rubble_use:
	stwu 1,-80(1)
	mflr 0
	stfd 29,56(1)
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 28,40(1)
	stw 0,84(1)
	lis 9,.LC250@ha
	mr 31,3
	la 9,.LC250@l(9)
	addi 3,31,212
	lfs 1,0(9)
	addi 4,31,236
	addi 5,31,4
	li 30,0
	bl VectorMA
	lwz 0,532(31)
	cmpw 0,30,0
	bc 4,0,.L537
	lis 9,.LC249@ha
	lis 11,.LC252@ha
	lfs 29,.LC249@l(9)
	la 11,.LC252@l(11)
	lis 29,0x4330
	lis 9,.LC251@ha
	lfd 31,0(11)
	lis 28,.LC67@ha
	la 9,.LC251@l(9)
	lfd 30,0(9)
.L539:
	bl rand
	addi 30,30,1
	rlwinm 3,3,0,17,31
	lfs 11,4(31)
	xoris 3,3,0x8000
	lfs 12,236(31)
	stw 3,36(1)
	stw 29,32(1)
	lfd 13,32(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,8(31)
	xoris 3,3,0x8000
	lfs 12,240(31)
	stw 3,36(1)
	stw 29,32(1)
	lfd 13,32(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,12(1)
	bl rand
	rlwinm 0,3,0,17,31
	lfs 11,12(31)
	xoris 0,0,0x8000
	lfs 12,244(31)
	lis 11,.LC253@ha
	stw 0,36(1)
	la 11,.LC253@l(11)
	mr 3,31
	stw 29,32(1)
	la 4,.LC67@l(28)
	addi 5,1,8
	lfd 13,32(1)
	lfs 1,0(11)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmadd 0,0,12,11
	frsp 0,0
	stfs 0,16(1)
	bl ThrowDebris
	lwz 0,532(31)
	cmpw 0,30,0
	bc 12,0,.L539
.L537:
	lis 9,gi+20@ha
	lis 11,.LC253@ha
	lwz 0,gi+20@l(9)
	mr 4,31
	la 11,.LC253@l(11)
	lis 9,.LC254@ha
	addi 3,31,4
	lwz 6,576(4)
	la 9,.LC254@l(9)
	li 5,0
	lfs 2,0(11)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC253@ha
	la 9,.LC253@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,84(1)
	mtlr 0
	lmw 28,40(1)
	lfd 29,56(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe37:
	.size	 misc_rubble_use,.Lfe37-misc_rubble_use
	.section	".rodata"
	.align 2
.LC255:
	.string	"world/rocks1.wav"
	.comm	node_count,2,2
	.comm	path_not_time_yet,4,4
	.comm	conversation_content,7760,4
	.comm	highlighted,4,4
	.comm	yeah_you,4,4
	.comm	its_me,4,4
	.comm	holdthephone,4,4
	.comm	NoTouch,4,4
	.comm	showingit,4,4
	.comm	path_time,4,4
	.comm	print_time,4,4
	.section	".text"
	.align 2
	.globl SP_func_areaportal
	.type	 SP_func_areaportal,@function
SP_func_areaportal:
	lis 9,Use_Areaportal@ha
	li 0,0
	la 9,Use_Areaportal@l(9)
	stw 0,532(3)
	stw 9,448(3)
	blr
.Lfe38:
	.size	 SP_func_areaportal,.Lfe38-SP_func_areaportal
	.section	".rodata"
	.align 2
.LC256:
	.long 0x46fffe00
	.align 2
.LC257:
	.long 0x3f333333
	.align 2
.LC258:
	.long 0x3f99999a
	.align 3
.LC259:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC260:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC261:
	.long 0x40590000
	.long 0x0
	.align 3
.LC262:
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
	lis 9,.LC259@ha
	rlwinm 3,3,0,17,31
	la 9,.LC259@l(9)
	xoris 3,3,0x8000
	lfd 30,0(9)
	lis 11,.LC256@ha
	lis 10,.LC260@ha
	lfs 28,.LC256@l(11)
	la 10,.LC260@l(10)
	stw 3,12(1)
	stw 29,8(1)
	lfd 13,8(1)
	lfd 29,0(10)
	lis 10,.LC261@ha
	fsub 13,13,30
	la 10,.LC261@l(10)
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
	lis 10,.LC262@ha
	stw 3,12(1)
	la 10,.LC262@l(10)
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
	lis 9,.LC257@ha
	mr 3,31
	lfs 1,.LC257@l(9)
	mr 4,3
	bl VectorScale
	b .L10
.L9:
	lis 9,.LC258@ha
	mr 3,31
	lfs 1,.LC258@l(9)
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
.Lfe39:
	.size	 VelocityForDamage,.Lfe39-VelocityForDamage
	.section	".rodata"
	.align 2
.LC263:
	.long 0xc3960000
	.align 2
.LC264:
	.long 0x43960000
	.align 2
.LC265:
	.long 0x43480000
	.align 2
.LC266:
	.long 0x43fa0000
	.section	".text"
	.align 2
	.globl ClipGibVelocity
	.type	 ClipGibVelocity,@function
ClipGibVelocity:
	lis 9,.LC263@ha
	lfs 0,376(3)
	la 9,.LC263@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L546
	lis 9,.LC264@ha
	la 9,.LC264@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L13
.L546:
	stfs 13,376(3)
.L13:
	lis 9,.LC263@ha
	lfs 0,380(3)
	la 9,.LC263@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L547
	lis 9,.LC264@ha
	la 9,.LC264@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L16
.L547:
	stfs 13,380(3)
.L16:
	lis 9,.LC265@ha
	lfs 0,384(3)
	la 9,.LC265@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L18
	stfs 13,384(3)
	blr
.L18:
	lis 9,.LC266@ha
	la 9,.LC266@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bclr 4,1
	stfs 13,384(3)
	blr
.Lfe40:
	.size	 ClipGibVelocity,.Lfe40-ClipGibVelocity
	.align 2
	.globl SP_path_corner
	.type	 SP_path_corner,@function
SP_path_corner:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L94
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
	b .L93
.L94:
	lwz 11,184(31)
	lis 9,path_corner_touch@ha
	lis 10,0xc100
	la 9,path_corner_touch@l(9)
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
.L93:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe41:
	.size	 SP_path_corner,.Lfe41-SP_path_corner
	.section	".rodata"
	.align 2
.LC267:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_point_combat
	.type	 SP_point_combat,@function
SP_point_combat:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC267@ha
	lis 9,deathmatch@ha
	la 11,.LC267@l(11)
	mr 6,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L111
	bl G_FreeEdict
	b .L110
.L111:
	lis 9,point_combat_touch@ha
	li 7,1
	la 9,point_combat_touch@l(9)
	lis 8,0xc100
	stw 7,184(6)
	lis 10,0x4100
	lis 0,0xc180
	stw 9,444(6)
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
.L110:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe42:
	.size	 SP_point_combat,.Lfe42-SP_point_combat
	.section	".rodata"
	.align 3
.LC268:
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
	stw 0,260(29)
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
	lis 9,.LC268@ha
	lfs 0,level+4@l(11)
	la 9,.LC268@l(9)
	lfd 13,0(9)
	lis 9,TH_viewthing@ha
	la 9,TH_viewthing@l(9)
	stw 9,436(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe43:
	.size	 SP_viewthing,.Lfe43-SP_viewthing
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
.Lfe44:
	.size	 SP_info_null,.Lfe44-SP_info_null
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
.Lfe45:
	.size	 SP_info_notnull,.Lfe45-SP_info_notnull
	.section	".rodata"
	.align 2
.LC269:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_light
	.type	 SP_light,@function
SP_light:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,300(3)
	cmpwi 0,0,0
	bc 12,2,.L121
	lis 9,.LC269@ha
	lis 11,deathmatch@ha
	la 9,.LC269@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L120
.L121:
	bl G_FreeEdict
	b .L119
.L120:
	lwz 11,644(3)
	cmpwi 0,11,31
	bc 4,1,.L119
	lwz 0,284(3)
	lis 9,light_use@ha
	la 9,light_use@l(9)
	andi. 10,0,1
	stw 9,448(3)
	bc 12,2,.L123
	lis 9,gi+24@ha
	lis 4,.LC62@ha
	lwz 0,gi+24@l(9)
	addi 3,11,800
	la 4,.LC62@l(4)
	mtlr 0
	blrl
	b .L119
.L123:
	lis 9,gi+24@ha
	lis 4,.LC61@ha
	lwz 0,gi+24@l(9)
	addi 3,11,800
	la 4,.LC61@l(4)
	mtlr 0
	blrl
.L119:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe46:
	.size	 SP_light,.Lfe46-SP_light
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
.Lfe47:
	.size	 BecomeExplosion1,.Lfe47-BecomeExplosion1
	.section	".rodata"
	.align 3
.LC270:
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
	lis 3,.LC90@ha
	la 28,gi@l(28)
	stw 11,260(29)
	la 3,.LC90@l(3)
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
	stw 9,448(29)
	lis 10,level+4@ha
	stw 0,68(29)
	lis 9,.LC270@ha
	mr 3,29
	stw 11,436(29)
	lfs 0,level+4@l(10)
	lfd 13,.LC270@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe48:
	.size	 SP_misc_blackhole,.Lfe48-SP_misc_blackhole
	.section	".rodata"
	.align 3
.LC271:
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
	lis 3,.LC93@ha
	la 28,gi@l(28)
	stw 0,200(29)
	la 3,.LC93@l(3)
	stw 0,204(29)
	stw 9,260(29)
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
	stw 9,436(29)
	lis 11,.LC271@ha
	mr 3,29
	lfs 0,level+4@l(10)
	lfd 13,.LC271@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe49:
	.size	 SP_misc_eastertank,.Lfe49-SP_misc_eastertank
	.section	".rodata"
	.align 3
.LC272:
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
	lis 3,.LC96@ha
	la 28,gi@l(28)
	stw 0,200(29)
	la 3,.LC96@l(3)
	stw 0,204(29)
	stw 9,260(29)
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
	stw 9,436(29)
	lis 11,.LC272@ha
	mr 3,29
	lfs 0,level+4@l(10)
	lfd 13,.LC272@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe50:
	.size	 SP_misc_easterchick,.Lfe50-SP_misc_easterchick
	.section	".rodata"
	.align 3
.LC273:
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
	lis 3,.LC96@ha
	la 28,gi@l(28)
	stw 0,200(29)
	la 3,.LC96@l(3)
	stw 0,204(29)
	stw 9,260(29)
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
	stw 9,436(29)
	lis 11,.LC273@ha
	mr 3,29
	lfs 0,level+4@l(10)
	lfd 13,.LC273@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe51:
	.size	 SP_misc_easterchick2,.Lfe51-SP_misc_easterchick2
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
	stw 0,260(28)
	la 29,gi@l(29)
	stw 9,248(28)
	lis 3,.LC122@ha
	lwz 9,32(29)
	la 3,.LC122@l(3)
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
.Lfe52:
	.size	 SP_light_mine1,.Lfe52-SP_light_mine1
	.section	".rodata"
	.align 3
.LC274:
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
	lis 9,.LC102@ha
	mr 29,3
	la 9,.LC102@l(9)
	li 0,0
	li 11,2
	lis 28,gi@ha
	stw 0,260(29)
	la 28,gi@l(28)
	stw 11,248(29)
	mr 3,9
	stw 9,268(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lwz 11,68(29)
	lis 9,commander_body_use@ha
	lis 5,0xc200
	la 9,commander_body_use@l(9)
	lis 6,0x4200
	stw 3,40(29)
	ori 11,11,64
	lis 10,0x4240
	stw 9,448(29)
	li 0,0
	li 7,1
	stw 10,208(29)
	li 8,16
	stw 11,68(29)
	mr 3,29
	stw 5,192(29)
	stw 0,196(29)
	stw 6,204(29)
	stw 7,512(29)
	stw 8,264(29)
	stw 5,188(29)
	stw 6,200(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lis 9,commander_body_drop@ha
	lis 11,level+4@ha
	la 9,commander_body_drop@l(9)
	lis 10,.LC274@ha
	stw 9,436(29)
	la 10,.LC274@l(10)
	lfs 0,level+4@l(11)
	lfd 13,0(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe53:
	.size	 SP_monster_commander_body,.Lfe53-SP_monster_commander_body
	.section	".rodata"
	.align 3
.LC275:
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
	stw 0,260(29)
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
	lis 11,.LC275@ha
	stw 9,436(29)
	lfs 0,level+4@l(10)
	lfd 13,.LC275@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe54:
	.size	 SP_misc_banner,.Lfe54-SP_misc_banner
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
	stw 0,260(29)
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
	lis 3,.LC112@ha
	stw 8,200(29)
	la 3,.LC112@l(3)
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
.Lfe55:
	.size	 SP_misc_bigviper,.Lfe55-SP_misc_bigviper
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
	lis 3,.LC114@ha
	stw 0,192(31)
	la 30,gi@l(9)
	la 3,.LC114@l(3)
	stw 10,248(31)
	stw 11,208(31)
	stw 10,260(31)
	stw 11,200(31)
	stw 11,204(31)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,516(31)
	stw 3,40(31)
	cmpwi 0,0,0
	bc 4,2,.L246
	li 0,1000
	stw 0,516(31)
.L246:
	lwz 0,184(31)
	lis 9,misc_viper_bomb_use@ha
	mr 3,31
	la 9,misc_viper_bomb_use@l(9)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe56:
	.size	 SP_misc_viper_bomb,.Lfe56-SP_misc_viper_bomb
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
	stw 0,260(29)
	lis 10,0x4300
	lis 28,gi@ha
	stw 9,248(29)
	la 28,gi@l(28)
	stw 11,196(29)
	lis 3,.LC121@ha
	stw 7,204(29)
	la 3,.LC121@l(3)
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
	stw 9,448(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe57:
	.size	 SP_misc_satellite_dish,.Lfe57-SP_misc_satellite_dish
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
	stw 0,260(28)
	la 29,gi@l(29)
	stw 9,248(28)
	lis 3,.LC123@ha
	lwz 9,32(29)
	la 3,.LC123@l(3)
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
.Lfe58:
	.size	 SP_light_mine2,.Lfe58-SP_light_mine2
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
	stw 0,260(29)
	la 28,gi@l(28)
	lwz 4,268(29)
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
.Lfe59:
	.size	 SP_target_character,.Lfe59-SP_target_character
	.align 2
	.globl SP_target_string
	.type	 SP_target_string,@function
SP_target_string:
	lwz 0,276(3)
	cmpwi 0,0,0
	bc 4,2,.L276
	lis 9,.LC139@ha
	la 9,.LC139@l(9)
	stw 9,276(3)
.L276:
	lis 9,target_string_use@ha
	la 9,target_string_use@l(9)
	stw 9,448(3)
	blr
.Lfe60:
	.size	 SP_target_string,.Lfe60-SP_target_string
	.align 2
	.globl SP_misc_teleporter_dest
	.type	 SP_misc_teleporter_dest,@function
SP_misc_teleporter_dest:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	li 11,512
	lis 8,0xc200
	lis 7,0x4200
	stw 11,68(9)
	lis 0,0xc1c0
	lis 10,0xc180
	stw 8,192(9)
	stw 0,196(9)
	lis 11,gi+72@ha
	stw 7,204(9)
	stw 10,208(9)
	stw 8,188(9)
	stw 7,200(9)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe61:
	.size	 SP_misc_teleporter_dest,.Lfe61-SP_misc_teleporter_dest
	.section	".rodata"
	.align 2
.LC276:
	.long 0x46fffe00
	.align 3
.LC277:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SP_misc_hologram
	.type	 SP_misc_hologram,@function
SP_misc_hologram:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	li 9,0
	lwz 0,276(31)
	stw 9,248(31)
	cmpwi 0,0,0
	stw 9,260(31)
	bc 4,2,.L353
	lis 9,gi@ha
	lis 3,.LC167@ha
	la 9,gi@l(9)
	la 3,.LC167@l(3)
	lwz 0,32(9)
	mtlr 0
	blrl
	stw 3,40(31)
.L353:
	lwz 11,64(31)
	lis 9,misc_hologram_think@ha
	lwz 0,68(31)
	la 9,misc_hologram_think@l(9)
	oris 11,11,0x1000
	stw 9,436(31)
	ori 0,0,8
	stw 11,64(31)
	stw 0,68(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC277@ha
	lis 10,.LC276@ha
	la 11,.LC277@l(11)
	stw 0,16(1)
	lis 8,gi+72@ha
	lfd 11,0(11)
	mr 3,31
	lfd 0,16(1)
	lis 11,level+4@ha
	lfs 12,.LC276@l(10)
	lfs 13,level+4@l(11)
	fsub 0,0,11
	frsp 0,0
	fdivs 0,0,12
	fadds 13,13,0
	stfs 13,428(31)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe62:
	.size	 SP_misc_hologram,.Lfe62-SP_misc_hologram
	.section	".rodata"
	.align 3
.LC278:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_flame
	.type	 SP_misc_flame,@function
SP_misc_flame:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 29,3
	li 27,0
	lis 28,gi@ha
	stw 27,260(29)
	lis 3,.LC222@ha
	la 28,gi@l(28)
	la 3,.LC222@l(3)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	lis 11,level+4@ha
	lis 10,.LC278@ha
	stw 27,248(29)
	lis 9,misc_flame_think@ha
	mr 3,29
	lfs 0,level+4@l(11)
	la 9,misc_flame_think@l(9)
	lfd 13,.LC278@l(10)
	stw 9,436(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe63:
	.size	 SP_misc_flame,.Lfe63-SP_misc_flame
	.section	".rodata"
	.align 2
.LC279:
	.long 0x0
	.align 3
.LC280:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SP_misc_setlights
	.type	 SP_misc_setlights,@function
SP_misc_setlights:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 3,276(31)
	cmpwi 0,3,0
	bc 12,2,.L458
	bl strlen
	cmpwi 0,3,1
	bc 4,2,.L458
	lwz 7,276(31)
	lbz 0,0(7)
	cmplwi 0,0,96
	bc 4,1,.L458
	cmplwi 0,0,122
	bc 4,1,.L457
.L458:
	lis 29,gi@ha
	lwz 28,276(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC224@ha
	la 3,.LC224@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L548
.L457:
	lis 9,.LC279@ha
	lis 11,deathmatch@ha
	la 9,.LC279@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L459
.L548:
	mr 3,31
	bl G_FreeEdict
	b .L456
.L459:
	lis 9,misc_setlights_use@ha
	lwz 0,184(31)
	lis 11,misc_setlights_think@ha
	la 9,misc_setlights_use@l(9)
	la 11,misc_setlights_think@l(11)
	stw 9,448(31)
	ori 0,0,1
	lis 9,.LC280@ha
	stw 0,184(31)
	lis 8,0x4330
	la 9,.LC280@l(9)
	stw 11,436(31)
	lfd 13,0(9)
	lbz 9,0(7)
	addi 9,9,-97
	xoris 9,9,0x8000
	stw 9,12(1)
	stw 8,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,340(31)
.L456:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe64:
	.size	 SP_misc_setlights,.Lfe64-SP_misc_setlights
	.section	".rodata"
	.align 2
.LC281:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_misc_highlight
	.type	 SP_misc_highlight,@function
SP_misc_highlight:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC281@ha
	lis 9,deathmatch@ha
	la 11,.LC281@l(11)
	mr 7,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L498
	bl G_FreeEdict
	b .L497
.L498:
	lwz 11,184(7)
	lis 9,misc_highlight_touch@ha
	lis 10,0xc100
	la 9,misc_highlight_touch@l(9)
	lis 8,0x4100
	stw 10,196(7)
	li 0,1
	stw 9,444(7)
	ori 11,11,1
	stw 0,248(7)
	lis 9,gi+72@ha
	mr 3,7
	stw 8,208(7)
	stw 11,184(7)
	stw 10,188(7)
	stw 10,192(7)
	stw 8,200(7)
	stw 8,204(7)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L497:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe65:
	.size	 SP_misc_highlight,.Lfe65-SP_misc_highlight
	.align 2
	.globl SP_misc_rubble
	.type	 SP_misc_rubble,@function
SP_misc_rubble:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L542
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC245@ha
	la 3,.LC245@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
.L542:
	lwz 0,532(31)
	cmpwi 0,0,0
	bc 4,2,.L543
	li 0,8
	stw 0,532(31)
.L543:
	lwz 3,276(31)
	cmpwi 0,3,0
	bc 4,2,.L544
	lis 9,gi+36@ha
	lis 3,.LC255@ha
	lwz 0,gi+36@l(9)
	la 3,.LC255@l(3)
	b .L549
.L544:
	lis 9,gi+36@ha
	lwz 0,gi+36@l(9)
.L549:
	mtlr 0
	blrl
	stw 3,576(31)
	lwz 0,184(31)
	lis 9,misc_rubble_use@ha
	la 9,misc_rubble_use@l(9)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe66:
	.size	 SP_misc_rubble,.Lfe66-SP_misc_rubble
	.section	".rodata"
	.align 3
.LC282:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl gib_touch
	.type	 gib_touch,@function
gib_touch:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	mr 31,3
	lwz 0,552(31)
	mr 3,5
	cmpwi 0,0,0
	bc 12,2,.L23
	cmpwi 0,3,0
	li 0,0
	stw 0,444(31)
	bc 12,2,.L23
	addi 4,1,8
	bl vectoangles
	addi 29,1,24
	addi 3,1,8
	mr 5,29
	li 6,0
	li 4,0
	bl AngleVectors
	mr 3,29
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
	lis 10,.LC282@ha
	addi 11,11,1
	stw 9,436(31)
	stw 11,56(31)
	lfs 0,level+4@l(8)
	lfd 13,.LC282@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L23:
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe67:
	.size	 gib_touch,.Lfe67-gib_touch
	.section	".rodata"
	.align 3
.LC283:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_object_think
	.type	 misc_object_think,@function
misc_object_think:
	lwz 9,56(3)
	lwz 11,968(3)
	addi 9,9,1
	addi 11,11,-1
	stw 9,56(3)
	cmpw 0,9,11
	bc 4,2,.L423
	li 0,0
	stw 0,56(3)
.L423:
	lis 9,level+4@ha
	lis 11,.LC283@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC283@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe68:
	.size	 misc_object_think,.Lfe68-misc_object_think
	.align 2
	.globl Use_Areaportal
	.type	 Use_Areaportal,@function
Use_Areaportal:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lis 11,gi+64@ha
	lwz 4,532(9)
	lwz 3,644(9)
	xori 4,4,1
	stw 4,532(9)
	lwz 0,gi+64@l(11)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe69:
	.size	 Use_Areaportal,.Lfe69-Use_Areaportal
	.section	".rodata"
	.align 3
.LC284:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC285:
	.long 0x46fffe00
	.align 3
.LC286:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC287:
	.long 0x41000000
	.align 2
.LC288:
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
	lis 9,.LC284@ha
	lfd 13,.LC284@l(9)
	addi 11,11,1
	stw 11,56(31)
	cmpwi 0,11,10
	lfs 0,4(30)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 4,2,.L22
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	stw 9,436(31)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,4(30)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC286@ha
	lis 11,.LC285@ha
	la 10,.LC286@l(10)
	stw 0,16(1)
	lfd 10,0(10)
	lfd 0,16(1)
	lis 10,.LC287@ha
	lfs 12,.LC285@l(11)
	la 10,.LC287@l(10)
	lfs 13,0(10)
	fsub 0,0,10
	lis 10,.LC288@ha
	la 10,.LC288@l(10)
	lfs 9,0(10)
	fadds 11,11,13
	frsp 0,0
	fdivs 0,0,12
	fmadds 0,0,9,11
	stfs 0,428(31)
.L22:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe70:
	.size	 gib_think,.Lfe70-gib_think
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
.Lfe71:
	.size	 gib_die,.Lfe71-gib_die
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
.Lfe72:
	.size	 debris_die,.Lfe72-debris_die
	.section	".rodata"
	.align 3
.LC289:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl TH_viewthing
	.type	 TH_viewthing,@function
TH_viewthing:
	lwz 11,56(3)
	lis 9,0x9249
	lis 10,.LC289@ha
	ori 9,9,9363
	lfd 13,.LC289@l(10)
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
	stfs 0,428(3)
	blr
.Lfe73:
	.size	 TH_viewthing,.Lfe73-TH_viewthing
	.align 2
	.type	 light_use,@function
light_use:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L117
	lis 9,gi+24@ha
	lwz 3,644(31)
	lis 4,.LC61@ha
	lwz 0,gi+24@l(9)
	la 4,.LC61@l(4)
	addi 3,3,800
	mtlr 0
	blrl
	lwz 0,284(31)
	rlwinm 0,0,0,0,30
	b .L550
.L117:
	lis 9,gi+24@ha
	lwz 3,644(31)
	lis 4,.LC62@ha
	lwz 0,gi+24@l(9)
	la 4,.LC62@l(4)
	addi 3,3,800
	mtlr 0
	blrl
	lwz 0,284(31)
	ori 0,0,1
.L550:
	stw 0,284(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe74:
	.size	 light_use,.Lfe74-light_use
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
	bc 4,2,.L126
	lwz 0,184(31)
	li 9,3
	stw 9,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl KillBox
	b .L127
.L126:
	lwz 0,184(31)
	li 9,0
	stw 9,248(31)
	ori 0,0,1
	stw 0,184(31)
.L127:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,284(31)
	andi. 0,0,2
	bc 4,2,.L128
	stw 0,448(31)
.L128:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe75:
	.size	 func_wall_use,.Lfe75-func_wall_use
	.section	".rodata"
	.align 3
.LC290:
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
	bc 12,2,.L138
	lfs 0,8(5)
	lis 9,.LC290@ha
	la 9,.LC290@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L138
	lwz 0,512(10)
	cmpwi 0,0,0
	bc 12,2,.L138
	lwz 9,516(3)
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
.L138:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe76:
	.size	 func_object_touch,.Lfe76-func_object_touch
	.align 2
	.globl func_object_release
	.type	 func_object_release,@function
func_object_release:
	lis 9,func_object_touch@ha
	li 0,7
	la 9,func_object_touch@l(9)
	stw 0,260(3)
	stw 9,444(3)
	blr
.Lfe77:
	.size	 func_object_release,.Lfe77-func_object_release
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
	stw 11,448(29)
	stw 0,184(29)
	bl KillBox
	lis 9,func_object_touch@ha
	li 0,7
	la 9,func_object_touch@l(9)
	stw 0,260(29)
	stw 9,444(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe78:
	.size	 func_object_use,.Lfe78-func_object_use
	.align 2
	.globl func_explosive_use
	.type	 func_explosive_use,@function
func_explosive_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 5,4
	lis 7,vec3_origin@ha
	lwz 6,480(3)
	la 7,vec3_origin@l(7)
	mr 4,3
	bl func_explosive_explode
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe79:
	.size	 func_explosive_use,.Lfe79-func_explosive_use
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
	stw 11,448(29)
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
.Lfe80:
	.size	 func_explosive_spawn,.Lfe80-func_explosive_spawn
	.section	".rodata"
	.align 3
.LC291:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC292:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC293:
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
	lwz 0,552(4)
	mr 31,3
	cmpwi 0,0,0
	bc 12,2,.L179
	cmpw 0,0,31
	bc 12,2,.L179
	lwz 0,400(4)
	lis 8,0x4330
	lwz 9,400(31)
	mr 10,11
	lis 7,.LC292@ha
	xoris 0,0,0x8000
	la 7,.LC292@l(7)
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
	lis 7,.LC293@ha
	lis 9,.LC291@ha
	la 7,.LC293@l(7)
	lfd 0,.LC291@l(9)
	mr 3,31
	lfs 13,0(7)
	fmuls 31,31,13
	fmr 2,31
	fmul 2,2,0
	frsp 2,2
	bl M_walkmove
.L179:
	lwz 0,68(1)
	mtlr 0
	lwz 31,52(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe81:
	.size	 barrel_touch,.Lfe81-barrel_touch
	.section	".rodata"
	.align 3
.LC294:
	.long 0x3fc99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl barrel_delay
	.type	 barrel_delay,@function
barrel_delay:
	li 0,0
	lis 11,level+4@ha
	stw 0,512(3)
	lis 10,.LC294@ha
	lis 9,barrel_explode@ha
	lfs 0,level+4@l(11)
	la 9,barrel_explode@l(9)
	lfd 13,.LC294@l(10)
	stw 5,548(3)
	stw 9,436(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe82:
	.size	 barrel_delay,.Lfe82-barrel_delay
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
.Lfe83:
	.size	 misc_blackhole_use,.Lfe83-misc_blackhole_use
	.section	".rodata"
	.align 3
.LC295:
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
	bc 12,1,.L194
	lis 9,level+4@ha
	lis 11,.LC295@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC295@l(11)
.L551:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.L194:
	li 0,0
	lis 11,level+4@ha
	stw 0,56(3)
	lis 9,.LC295@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC295@l(9)
	b .L551
.Lfe84:
	.size	 misc_blackhole_think,.Lfe84-misc_blackhole_think
	.section	".rodata"
	.align 3
.LC296:
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
	bc 12,1,.L198
	lis 9,level+4@ha
	lis 11,.LC296@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC296@l(11)
.L552:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.L198:
	li 0,254
	lis 11,level+4@ha
	stw 0,56(3)
	lis 9,.LC296@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC296@l(9)
	b .L552
.Lfe85:
	.size	 misc_eastertank_think,.Lfe85-misc_eastertank_think
	.section	".rodata"
	.align 3
.LC297:
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
	bc 12,1,.L202
	lis 9,level+4@ha
	lis 11,.LC297@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC297@l(11)
.L553:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.L202:
	li 0,208
	lis 11,level+4@ha
	stw 0,56(3)
	lis 9,.LC297@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC297@l(9)
	b .L553
.Lfe86:
	.size	 misc_easterchick_think,.Lfe86-misc_easterchick_think
	.section	".rodata"
	.align 3
.LC298:
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
	bc 12,1,.L206
	lis 9,level+4@ha
	lis 11,.LC298@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC298@l(11)
.L554:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.L206:
	li 0,248
	lis 11,level+4@ha
	stw 0,56(3)
	lis 9,.LC298@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC298@l(9)
	b .L554
.Lfe87:
	.size	 misc_easterchick2_think,.Lfe87-misc_easterchick2_think
	.section	".rodata"
	.align 3
.LC299:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl commander_body_think
	.type	 commander_body_think,@function
commander_body_think:
	lwz 9,56(3)
	addi 9,9,1
	cmpwi 0,9,23
	stw 9,56(3)
	bc 12,1,.L210
	lis 9,level+4@ha
	lis 11,.LC299@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC299@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.L210:
	li 0,0
	stw 0,428(3)
	blr
.Lfe88:
	.size	 commander_body_think,.Lfe88-commander_body_think
	.section	".rodata"
	.align 3
.LC300:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl commander_body_use
	.type	 commander_body_use,@function
commander_body_use:
	lis 9,commander_body_think@ha
	lis 10,level+4@ha
	la 9,commander_body_think@l(9)
	lis 11,.LC300@ha
	stw 9,436(3)
	lfs 0,level+4@l(10)
	lfd 13,.LC300@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe89:
	.size	 commander_body_use,.Lfe89-commander_body_use
	.section	".rodata"
	.align 2
.LC301:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl commander_body_drop
	.type	 commander_body_drop,@function
commander_body_drop:
	lis 9,.LC301@ha
	lfs 0,12(3)
	li 0,7
	la 9,.LC301@l(9)
	stw 0,260(3)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,12(3)
	blr
.Lfe90:
	.size	 commander_body_drop,.Lfe90-commander_body_drop
	.section	".rodata"
	.align 3
.LC302:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_banner_think
	.type	 misc_banner_think,@function
misc_banner_think:
	lwz 9,56(3)
	lis 10,level+4@ha
	lis 11,.LC302@ha
	lfd 13,.LC302@l(11)
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
	stfs 0,428(3)
	blr
.Lfe91:
	.size	 misc_banner_think,.Lfe91-misc_banner_think
	.align 2
	.globl misc_deadsoldier_die
	.type	 misc_deadsoldier_die,@function
misc_deadsoldier_die:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	mr 29,6
	lwz 0,480(30)
	cmpwi 0,0,-80
	bc 12,1,.L217
	lis 28,.LC105@ha
	li 31,4
.L222:
	mr 3,30
	la 4,.LC105@l(28)
	mr 5,29
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L222
	lis 4,.LC33@ha
	mr 3,30
	la 4,.LC33@l(4)
	mr 5,29
	li 6,0
	bl ThrowHead
.L217:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe92:
	.size	 misc_deadsoldier_die,.Lfe92-misc_deadsoldier_die
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
	stw 11,448(9)
	rlwinm 0,0,0,0,30
	stw 0,184(9)
	bl train_use
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe93:
	.size	 misc_viper_use,.Lfe93-misc_viper_use
	.section	".rodata"
	.align 3
.LC303:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC304:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl misc_viper_bomb_touch
	.type	 misc_viper_bomb_touch,@function
misc_viper_bomb_touch:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,3
	lwz 4,548(29)
	bl G_UseTargets
	lwz 9,516(29)
	lis 8,0x4330
	mr 11,10
	lis 7,.LC303@ha
	lfs 12,220(29)
	xoris 0,9,0x8000
	la 7,.LC303@l(7)
	stw 0,28(1)
	addi 9,9,40
	mr 3,29
	stw 8,24(1)
	xoris 9,9,0x8000
	li 5,0
	lfd 1,24(1)
	li 6,27
	mr 4,29
	stw 9,28(1)
	lfd 13,0(7)
	stw 8,24(1)
	lis 7,.LC304@ha
	lfd 2,24(1)
	la 7,.LC304@l(7)
	lfs 0,0(7)
	fsub 1,1,13
	fsub 2,2,13
	fadds 12,12,0
	frsp 1,1
	frsp 2,2
	stfs 12,12(29)
	bl T_RadiusDamage
	mr 3,29
	bl BecomeExplosion2
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe94:
	.size	 misc_viper_bomb_touch,.Lfe94-misc_viper_bomb_touch
	.section	".rodata"
	.align 3
.LC305:
	.long 0xbff00000
	.long 0x0
	.align 2
.LC306:
	.long 0xbf800000
	.align 3
.LC307:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC308:
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
	stw 0,552(31)
	lis 9,level+4@ha
	lis 11,.LC305@ha
	lfs 12,level+4@l(9)
	la 11,.LC305@l(11)
	lfs 13,288(31)
	lfd 11,0(11)
	fsubs 31,13,12
	fmr 0,31
	fcmpu 0,0,11
	bc 4,0,.L243
	lis 9,.LC306@ha
	la 9,.LC306@l(9)
	lfs 31,0(9)
.L243:
	lis 11,.LC307@ha
	fmr 1,31
	addi 4,1,8
	la 11,.LC307@l(11)
	addi 3,31,736
	lfd 0,0(11)
	fadd 1,1,0
	frsp 1,1
	bl VectorScale
	stfs 31,16(1)
	addi 3,1,8
	addi 4,31,16
	lfs 31,24(31)
	bl vectoangles
	lis 9,.LC308@ha
	la 9,.LC308@l(9)
	lfs 0,0(9)
	fadds 0,31,0
	stfs 0,24(31)
	lwz 0,52(1)
	mtlr 0
	lwz 31,36(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe95:
	.size	 misc_viper_bomb_prethink,.Lfe95-misc_viper_bomb_prethink
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
	la 10,misc_viper_bomb_prethink@l(10)
	lwz 9,64(29)
	la 11,misc_viper_bomb_touch@l(11)
	li 8,2
	stw 5,548(29)
	rlwinm 0,0,0,0,30
	li 6,0
	ori 9,9,16
	li 7,7
	stw 8,248(29)
	lis 5,.LC113@ha
	stw 9,64(29)
	li 4,280
	stw 0,184(29)
	la 5,.LC113@l(5)
	li 3,0
	stw 6,448(29)
	stw 7,260(29)
	stw 10,432(29)
	stw 11,444(29)
	bl G_Find
	mr 28,3
	addi 4,29,376
	lfs 1,716(28)
	addi 3,28,736
	bl VectorScale
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	stfs 0,288(29)
	lfs 13,736(28)
	stfs 13,736(29)
	lfs 0,740(28)
	stfs 0,740(29)
	lfs 13,744(28)
	stfs 13,744(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe96:
	.size	 misc_viper_bomb_use,.Lfe96-misc_viper_bomb_use
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
	stw 11,448(9)
	rlwinm 0,0,0,0,30
	stw 0,184(9)
	bl train_use
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe97:
	.size	 misc_strogg_ship_use,.Lfe97-misc_strogg_ship_use
	.section	".rodata"
	.align 3
.LC309:
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
	lis 11,.LC309@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC309@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe98:
	.size	 misc_satellite_dish_think,.Lfe98-misc_satellite_dish_think
	.section	".rodata"
	.align 3
.LC310:
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
	stw 9,436(3)
	lis 10,.LC310@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC310@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe99:
	.size	 misc_satellite_dish_use,.Lfe99-misc_satellite_dish_use
	.align 2
	.globl target_string_use
	.type	 target_string_use,@function
target_string_use:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 3,276(31)
	bl strlen
	lwz 10,564(31)
	cmpwi 0,10,0
	bc 12,2,.L263
	li 8,12
	li 6,10
	li 7,11
.L265:
	lwz 9,532(10)
	cmpwi 0,9,0
	bc 12,2,.L264
	addi 11,9,-1
	cmpw 0,11,3
	bc 12,1,.L272
	lwz 9,276(31)
	lbzx 9,9,11
	addi 11,9,-48
	rlwinm 0,11,0,0xff
	cmplwi 0,0,9
	bc 12,1,.L268
	stw 11,56(10)
	b .L264
.L268:
	cmpwi 0,9,45
	bc 4,2,.L270
	stw 6,56(10)
	b .L264
.L270:
	cmpwi 0,9,58
	bc 4,2,.L272
	stw 7,56(10)
	b .L264
.L272:
	stw 8,56(10)
.L264:
	lwz 10,560(10)
	cmpwi 0,10,0
	bc 4,2,.L265
.L263:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe100:
	.size	 target_string_use,.Lfe100-target_string_use
	.align 2
	.globl func_clock_use
	.type	 func_clock_use,@function
func_clock_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lwz 0,284(9)
	andi. 0,0,8
	bc 4,2,.L308
	stw 0,448(9)
.L308:
	lwz 0,548(9)
	cmpwi 0,0,0
	bc 4,2,.L307
	lwz 11,436(9)
	mr 3,9
	stw 5,548(9)
	mtlr 11
	blrl
.L307:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe101:
	.size	 func_clock_use,.Lfe101-func_clock_use
	.align 2
	.globl spawn_lightning
	.type	 spawn_lightning,@function
spawn_lightning:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 3,4
	mr 4,5
	bl spawn_templaser
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe102:
	.size	 spawn_lightning,.Lfe102-spawn_lightning
	.section	".rodata"
	.align 2
.LC311:
	.long 0x46fffe00
	.align 3
.LC312:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC313:
	.long 0x42000000
	.align 2
.LC314:
	.long 0x41800000
	.section	".text"
	.align 2
	.globl lightning_small_branch
	.type	 lightning_small_branch,@function
lightning_small_branch:
	stwu 1,-80(1)
	mflr 0
	stfd 28,48(1)
	stfd 29,56(1)
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 28,32(1)
	stw 0,84(1)
	mr 29,4
	lis 9,.LC312@ha
	mr 4,5
	la 9,.LC312@l(9)
	lfd 31,0(9)
	addi 5,1,8
	mr 3,29
	bl VectorMA
	lis 28,0x4330
	lis 9,.LC313@ha
	la 9,.LC313@l(9)
	lfs 28,0(9)
	lis 9,.LC314@ha
	la 9,.LC314@l(9)
	lfs 29,0(9)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 13,8(1)
	xoris 3,3,0x8000
	lis 11,.LC311@ha
	stw 3,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	lfs 30,.LC311@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmsubs 0,0,28,29
	fadds 13,13,0
	stfs 13,8(1)
	bl rand
	rlwinm 0,3,0,17,31
	lfs 13,12(1)
	xoris 0,0,0x8000
	mr 3,29
	stw 0,28(1)
	addi 4,1,8
	stw 28,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmsubs 0,0,28,29
	fadds 13,13,0
	stfs 13,12(1)
	bl spawn_templaser
	lwz 0,84(1)
	mtlr 0
	lmw 28,32(1)
	lfd 28,48(1)
	lfd 29,56(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe103:
	.size	 lightning_small_branch,.Lfe103-lightning_small_branch
	.align 2
	.globl drop_touch
	.type	 drop_touch,@function
drop_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe104:
	.size	 drop_touch,.Lfe104-drop_touch
	.align 2
	.globl spawn_rain_drop
	.type	 spawn_rain_drop,@function
spawn_rain_drop:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stmw 26,8(1)
	stw 0,52(1)
	mr 27,5
	mr 28,4
	fmr 30,2
	mr 26,3
	fmr 31,1
	bl G_Spawn
	lfs 13,0(28)
	mr 29,3
	fmr 1,31
	mr 3,27
	addi 4,29,376
	stfs 13,4(29)
	lfs 0,4(28)
	stfs 0,8(29)
	lfs 13,8(28)
	stfs 13,12(29)
	lfs 0,0(27)
	stfs 0,16(29)
	lfs 13,4(27)
	stfs 13,20(29)
	lfs 0,8(27)
	stfs 0,24(29)
	bl VectorScale
	lis 0,0x600
	li 9,0
	ori 0,0,3
	li 11,8
	stw 9,200(29)
	li 10,0
	stw 11,260(29)
	lis 8,gi+32@ha
	stw 10,248(29)
	lis 3,.LC179@ha
	stw 9,196(29)
	la 3,.LC179@l(3)
	stw 9,192(29)
	stw 9,188(29)
	stw 9,208(29)
	stw 9,204(29)
	stw 0,252(29)
	lwz 0,gi+32@l(8)
	mtlr 0
	blrl
	lis 11,drop_touch@ha
	stw 3,40(29)
	lis 8,level+4@ha
	la 11,drop_touch@l(11)
	stw 26,256(29)
	lis 10,G_FreeEdict@ha
	stw 11,444(29)
	lis 9,.LC180@ha
	la 10,G_FreeEdict@l(10)
	lfs 0,level+4@l(8)
	la 9,.LC180@l(9)
	stw 9,280(29)
	stw 10,436(29)
	fadds 0,0,30
	stfs 0,428(29)
	lwz 0,52(1)
	mtlr 0
	lmw 26,8(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe105:
	.size	 spawn_rain_drop,.Lfe105-spawn_rain_drop
	.section	".rodata"
	.align 3
.LC315:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC316:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC317:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl misc_object_touch
	.type	 misc_object_touch,@function
misc_object_touch:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stw 31,52(1)
	stw 0,68(1)
	lwz 0,552(4)
	mr 31,3
	cmpwi 0,0,0
	bc 12,2,.L409
	cmpw 0,0,31
	bc 12,2,.L409
	lwz 0,400(4)
	lis 8,0x4330
	lwz 9,400(31)
	mr 10,11
	lis 7,.LC316@ha
	xoris 0,0,0x8000
	la 7,.LC316@l(7)
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
	lis 7,.LC317@ha
	lis 9,.LC315@ha
	la 7,.LC317@l(7)
	lfd 0,.LC315@l(9)
	mr 3,31
	lfs 13,0(7)
	fmuls 31,31,13
	fmr 2,31
	fmul 2,2,0
	frsp 2,2
	bl M_walkmove
.L409:
	lwz 0,68(1)
	mtlr 0
	lwz 31,52(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe106:
	.size	 misc_object_touch,.Lfe106-misc_object_touch
	.section	".rodata"
	.align 2
.LC318:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl misc_object_vanish
	.type	 misc_object_vanish,@function
misc_object_vanish:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,64(3)
	andis. 9,0,4096
	bc 12,2,.L413
	bl G_FreeEdict
	b .L414
.L413:
	oris 0,0,0x1000
	lis 11,.LC318@ha
	lis 9,level+4@ha
	stw 0,64(3)
	la 11,.LC318@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,428(3)
.L414:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe107:
	.size	 misc_object_vanish,.Lfe107-misc_object_vanish
	.section	".rodata"
	.align 2
.LC319:
	.long 0x46fffe00
	.align 3
.LC320:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC321:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC322:
	.long 0x40a00000
	.align 2
.LC323:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl misc_object_think_die
	.type	 misc_object_think_die,@function
misc_object_think_die:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,56(31)
	lwz 0,960(31)
	cmpw 0,9,0
	bc 4,2,.L416
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC321@ha
	lis 10,.LC319@ha
	stw 0,16(1)
	la 11,.LC321@l(11)
	lfd 12,0(11)
	li 0,0
	lfd 0,16(1)
	lis 11,.LC322@ha
	lfs 11,.LC319@l(10)
	la 11,.LC322@l(11)
	lis 9,misc_object_vanish@ha
	lfs 9,0(11)
	la 9,misc_object_vanish@l(9)
	fsub 0,0,12
	lis 11,.LC323@ha
	la 11,.LC323@l(11)
	lfs 10,0(11)
	frsp 0,0
	lis 11,level+4@ha
	lfs 13,level+4@l(11)
	stw 0,248(31)
	fdivs 0,0,11
	stw 9,436(31)
	fmadds 0,0,9,10
	fadds 13,13,0
	stfs 13,428(31)
	b .L415
.L416:
	addi 0,9,1
	lis 11,level+4@ha
	stw 0,56(31)
	lis 9,.LC320@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC320@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L415:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe108:
	.size	 misc_object_think_die,.Lfe108-misc_object_think_die
	.section	".rodata"
	.align 3
.LC324:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_object_killed
	.type	 misc_object_killed,@function
misc_object_killed:
	lis 9,misc_object_think_die@ha
	lwz 8,964(3)
	li 0,0
	la 9,misc_object_think_die@l(9)
	stw 0,512(3)
	lis 11,level+4@ha
	stw 8,56(3)
	lis 10,.LC324@ha
	stw 9,436(3)
	lfs 0,level+4@l(11)
	lfd 13,.LC324@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe109:
	.size	 misc_object_killed,.Lfe109-misc_object_killed
	.section	".rodata"
	.align 3
.LC325:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_object_think_pain
	.type	 misc_object_think_pain,@function
misc_object_think_pain:
	lwz 9,964(3)
	lwz 11,56(3)
	addi 9,9,-1
	cmpw 0,11,9
	bc 4,2,.L419
	li 0,0
	lwz 9,284(3)
	stw 0,56(3)
	andi. 0,9,32
	bclr 12,2
	lis 11,level+4@ha
	lis 10,.LC325@ha
	lfs 0,level+4@l(11)
	lis 9,misc_object_think@ha
	lfd 13,.LC325@l(10)
	la 9,misc_object_think@l(9)
	stw 9,436(3)
.L555:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.L419:
	addi 0,11,1
	lis 9,.LC325@ha
	lis 11,level+4@ha
	stw 0,56(3)
	lfs 0,level+4@l(11)
	lfd 13,.LC325@l(9)
	b .L555
.Lfe110:
	.size	 misc_object_think_pain,.Lfe110-misc_object_think_pain
	.section	".rodata"
	.align 3
.LC326:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_object_pain
	.type	 misc_object_pain,@function
misc_object_pain:
	lis 9,misc_object_think_pain@ha
	lwz 0,968(3)
	lis 10,level+4@ha
	la 9,misc_object_think_pain@l(9)
	lis 11,.LC326@ha
	stw 9,436(3)
	stw 0,56(3)
	lfs 0,level+4@l(10)
	lfd 13,.LC326@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe111:
	.size	 misc_object_pain,.Lfe111-misc_object_pain
	.section	".rodata"
	.align 3
.LC327:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_flame_think
	.type	 misc_flame_think,@function
misc_flame_think:
	lwz 9,56(3)
	addi 9,9,1
	cmpwi 0,9,11
	stw 9,56(3)
	bc 4,2,.L451
	li 0,0
	stw 0,56(3)
.L451:
	lis 9,level+4@ha
	lis 11,.LC327@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC327@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe112:
	.size	 misc_flame_think,.Lfe112-misc_flame_think
	.section	".rodata"
	.align 2
.LC328:
	.long 0x42c20000
	.section	".text"
	.align 2
	.globl misc_setlights_think
	.type	 misc_setlights_think,@function
misc_setlights_think:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	lis 9,.LC328@ha
	lfs 0,340(3)
	lis 11,gi+24@ha
	la 9,.LC328@l(9)
	lwz 0,gi+24@l(11)
	li 3,800
	lfs 12,0(9)
	addi 4,1,8
	mtlr 0
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	slwi 9,9,8
	sth 9,8(1)
	blrl
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe113:
	.size	 misc_setlights_think,.Lfe113-misc_setlights_think
	.section	".rodata"
	.align 2
.LC329:
	.long 0x42c20000
	.section	".text"
	.align 2
	.globl misc_setlights_use
	.type	 misc_setlights_use,@function
misc_setlights_use:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	lis 9,.LC329@ha
	mr 8,3
	la 9,.LC329@l(9)
	lfs 0,340(8)
	lis 11,level+4@ha
	lfs 11,0(9)
	lis 10,gi+24@ha
	li 3,800
	lfs 12,level+4@l(11)
	addi 4,1,8
	fadds 0,0,11
	stfs 12,288(8)
	lwz 0,gi+24@l(10)
	mtlr 0
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	slwi 9,9,8
	sth 9,8(1)
	blrl
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe114:
	.size	 misc_setlights_use,.Lfe114-misc_setlights_use
	.align 2
	.globl misc_flyby_use
	.type	 misc_flyby_use,@function
misc_flyby_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lis 11,train_use@ha
	lwz 0,184(9)
	la 11,train_use@l(11)
	stw 11,448(9)
	rlwinm 0,0,0,0,30
	stw 0,184(9)
	bl train_use
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe115:
	.size	 misc_flyby_use,.Lfe115-misc_flyby_use
	.align 2
	.globl find_action_point
	.type	 find_action_point,@function
find_action_point:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	mr 28,5
	li 3,0
	lis 29,.LC230@ha
.L488:
	li 4,280
	la 5,.LC230@l(29)
	bl G_Find
	mr. 3,3
	bc 12,2,.L487
	lwz 0,284(3)
	and. 9,0,30
	bc 12,2,.L488
	andi. 9,0,512
	bc 4,2,.L488
	stw 3,412(31)
	stw 3,324(31)
	stw 3,416(31)
	lwz 0,284(3)
	ori 0,0,512
	stw 0,284(3)
	cmpwi 0,28,0
	bc 12,2,.L495
	lwz 0,804(31)
	mr 3,31
	mtlr 0
	blrl
	b .L487
.L495:
	lwz 0,800(31)
	mr 3,31
	mtlr 0
	blrl
.L487:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe116:
	.size	 find_action_point,.Lfe116-find_action_point
	.section	".rodata"
	.align 3
.LC330:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_bigbolt_laser
	.type	 misc_bigbolt_laser,@function
misc_bigbolt_laser:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	bl G_Spawn
	lfs 0,4(28)
	mr 29,3
	lwz 9,284(29)
	stfs 0,4(29)
	ori 9,9,67
	lfs 13,8(28)
	stfs 13,8(29)
	lfs 0,12(28)
	stfs 0,12(29)
	lwz 0,296(28)
	stw 9,284(29)
	stw 0,296(29)
	bl target_laser_start
	lis 11,level+4@ha
	lis 10,.LC330@ha
	lfs 0,level+4@l(11)
	lis 9,misc_bigbolt_laser_think@ha
	lfd 13,.LC330@l(10)
	la 9,misc_bigbolt_laser_think@l(9)
	stw 9,436(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe117:
	.size	 misc_bigbolt_laser,.Lfe117-misc_bigbolt_laser
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
