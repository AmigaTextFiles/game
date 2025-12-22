	.file	"g_misc.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC3:
	.string	"gib"
	.align 2
.LC6:
	.string	"misc/fhit3.wav"
	.align 2
.LC8:
	.long 0x46fffe00
	.align 2
.LC9:
	.long 0x3f333333
	.align 2
.LC10:
	.long 0x3f99999a
	.align 3
.LC11:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC12:
	.long 0x3f000000
	.align 3
.LC13:
	.long 0x3fe00000
	.long 0x0
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
	lis 10,.LC12@ha
	lis 9,.LC11@ha
	la 10,.LC12@l(10)
	mr 31,3
	lfs 1,0(10)
	la 9,.LC11@l(9)
	addi 4,1,40
	lfd 30,0(9)
	addi 3,30,236
	bl VectorScale
	lfs 11,40(1)
	lis 9,.LC13@ha
	lfs 13,212(30)
	la 9,.LC13@l(9)
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
	lis 11,.LC8@ha
	lfs 12,40(1)
	stw 3,84(1)
	stw 29,80(1)
	lfd 13,80(1)
	lfs 29,.LC8@l(11)
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
	lwz 10,64(31)
	lis 8,gib_die@ha
	cmpwi 0,27,0
	lwz 0,264(31)
	li 11,0
	li 9,0
	la 8,gib_die@l(8)
	ori 10,10,2
	stw 11,200(31)
	ori 0,0,2048
	stw 10,64(31)
	stw 0,264(31)
	stw 9,512(31)
	stw 8,456(31)
	stw 9,248(31)
	stw 9,444(31)
	stw 11,196(31)
	stw 11,192(31)
	stw 11,188(31)
	stw 11,208(31)
	stw 11,204(31)
	bc 4,2,.L39
	li 0,12
	lis 27,0x3f00
	b .L63
.L39:
	li 0,9
	lis 27,0x3f80
.L63:
	stw 0,260(31)
	bl rand
	lis 29,0x4330
	lis 9,.LC11@ha
	rlwinm 3,3,0,17,31
	la 9,.LC11@l(9)
	xoris 3,3,0x8000
	lfd 30,0(9)
	lis 11,.LC8@ha
	lis 10,.LC13@ha
	lfs 28,.LC8@l(11)
	la 10,.LC13@l(10)
	stw 3,84(1)
	addi 28,1,8
	stw 29,80(1)
	lfd 13,80(1)
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
	lis 10,.LC15@ha
	stw 3,84(1)
	la 10,.LC15@l(10)
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
	bc 12,1,.L41
	lis 9,.LC9@ha
	mr 3,28
	lfs 1,.LC9@l(9)
	mr 4,3
	bl VectorScale
	b .L43
.L41:
	lis 9,.LC10@ha
	mr 3,28
	lfs 1,.LC10@l(9)
	mr 4,3
	bl VectorScale
.L43:
	stw 27,56(1)
	addi 3,30,376
	addi 4,1,8
	lfs 0,56(1)
	addi 5,31,376
	fmr 1,0
	bl VectorMA
	lis 9,.LC16@ha
	lfs 0,376(31)
	la 9,.LC16@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L64
	lis 10,.LC17@ha
	la 10,.LC17@l(10)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 4,1,.L45
.L64:
	stfs 13,376(31)
.L45:
	lis 11,.LC16@ha
	lfs 0,380(31)
	la 11,.LC16@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,0,.L65
	lis 9,.LC17@ha
	la 9,.LC17@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L48
.L65:
	stfs 13,380(31)
.L48:
	lis 10,.LC18@ha
	lfs 0,384(31)
	la 10,.LC18@l(10)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,0,.L66
	lis 11,.LC19@ha
	la 11,.LC19@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L53
.L66:
	stfs 13,384(31)
.L53:
	bl rand
	lis 29,0x4330
	li 28,0
	lis 9,.LC11@ha
	rlwinm 3,3,0,17,31
	la 9,.LC11@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC8@ha
	lis 10,.LC20@ha
	lfs 29,.LC8@l(11)
	la 10,.LC20@l(10)
	stw 3,84(1)
	li 27,0
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
	lwz 0,68(31)
	xoris 3,3,0x8000
	lis 11,level@ha
	stw 3,84(1)
	lis 10,.LC21@ha
	la 11,level@l(11)
	stw 29,80(1)
	la 10,.LC21@l(10)
	ori 0,0,32768
	lfd 0,80(1)
	lis 8,gi+72@ha
	mr 3,31
	lfs 13,4(11)
	lfs 12,0(10)
	fsub 0,0,31
	li 10,50
	stw 0,68(31)
	stw 10,400(31)
	fadds 13,13,12
	frsp 0,0
	fdivs 0,0,29
	fmadds 0,0,12,13
	stfs 0,428(31)
	lfs 13,4(11)
	stfs 13,288(31)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	li 3,0
	b .L59
.L56:
	cmpwi 0,28,0
	addi 27,27,1
	bc 12,2,.L57
	lfs 13,288(3)
	lfs 0,288(28)
	fcmpu 0,13,0
	bc 4,0,.L59
.L57:
	mr 28,3
.L59:
	lis 5,.LC3@ha
	li 4,280
	la 5,.LC3@l(5)
	bl G_Find
	mr. 3,3
	bc 4,2,.L56
	cmpwi 7,27,25
	addic 0,28,-1
	subfe 9,0,28
	mfcr 0
	rlwinm 0,0,30,1
	and. 10,0,9
	bc 12,2,.L62
	mr 3,28
	bl G_FreeEdict
.L62:
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
.LC22:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC23:
	.long 0x46fffe00
	.align 2
.LC24:
	.long 0x3f333333
	.align 2
.LC25:
	.long 0x3f99999a
	.align 3
.LC26:
	.long 0x4082c000
	.long 0x0
	.align 3
.LC27:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC28:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC29:
	.long 0x40590000
	.long 0x0
	.align 3
.LC30:
	.long 0x40690000
	.long 0x0
	.align 2
.LC31:
	.long 0xc3960000
	.align 2
.LC32:
	.long 0x43960000
	.align 2
.LC33:
	.long 0x43480000
	.align 2
.LC34:
	.long 0x43fa0000
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
	lis 10,head_die@ha
	cmpwi 0,28,0
	lwz 11,264(31)
	la 10,head_die@l(10)
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
	stw 29,444(31)
	bc 4,2,.L75
	lis 9,gib_touch@ha
	li 0,7
	la 9,gib_touch@l(9)
	stw 0,260(31)
	lis 27,0x3f00
	stw 9,444(31)
	b .L76
.L75:
	li 0,9
	lis 27,0x3f80
	stw 0,260(31)
.L76:
	bl rand
	lis 29,0x4330
	lis 9,.LC27@ha
	rlwinm 3,3,0,17,31
	la 9,.LC27@l(9)
	xoris 3,3,0x8000
	lfd 30,0(9)
	lis 11,.LC23@ha
	lis 10,.LC28@ha
	lfs 28,.LC23@l(11)
	la 10,.LC28@l(10)
	stw 3,52(1)
	addi 28,1,8
	stw 29,48(1)
	lfd 13,48(1)
	lfd 29,0(10)
	lis 10,.LC29@ha
	fsub 13,13,30
	la 10,.LC29@l(10)
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
	lis 10,.LC30@ha
	stw 3,52(1)
	la 10,.LC30@l(10)
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
	bc 12,1,.L77
	lis 9,.LC24@ha
	mr 3,28
	lfs 1,.LC24@l(9)
	mr 4,3
	bl VectorScale
	b .L79
.L77:
	lis 9,.LC25@ha
	mr 3,28
	lfs 1,.LC25@l(9)
	mr 4,3
	bl VectorScale
.L79:
	stw 27,24(1)
	addi 3,31,376
	addi 4,1,8
	lfs 0,24(1)
	mr 5,3
	fmr 1,0
	bl VectorMA
	lis 9,.LC31@ha
	lfs 0,376(31)
	la 9,.LC31@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L91
	lis 10,.LC32@ha
	la 10,.LC32@l(10)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 4,1,.L81
.L91:
	stfs 13,376(31)
.L81:
	lis 11,.LC31@ha
	lfs 0,380(31)
	la 11,.LC31@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,0,.L92
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L84
.L92:
	stfs 13,380(31)
.L84:
	lis 10,.LC33@ha
	lfs 0,384(31)
	la 10,.LC33@l(10)
	lfs 13,0(10)
	fcmpu 0,0,13
	bc 12,0,.L93
	lis 11,.LC34@ha
	la 11,.LC34@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,1,.L89
.L93:
	stfs 13,384(31)
.L89:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 7,436(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,52(1)
	lis 9,.LC27@ha
	lis 8,.LC23@ha
	la 9,.LC27@l(9)
	stw 0,48(1)
	lis 10,.LC28@ha
	lfd 0,0(9)
	la 10,.LC28@l(10)
	lfd 13,48(1)
	lis 9,MonsterRespawn@ha
	lfs 10,.LC23@l(8)
	la 9,MonsterRespawn@l(9)
	lfd 11,0(10)
	cmpw 0,7,9
	fsub 13,13,0
	lis 10,.LC26@ha
	lfd 12,.LC26@l(10)
	frsp 13,13
	fdivs 13,13,10
	fmr 0,13
	fsub 0,0,11
	fadd 0,0,0
	fmul 0,0,12
	frsp 0,0
	stfs 0,392(31)
	bc 12,2,.L90
	mr 3,31
	bl SetMonsterRespawn
.L90:
	li 0,50
	lis 9,gi+72@ha
	stw 0,400(31)
	mr 3,31
	lwz 0,gi+72@l(9)
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
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC36:
	.string	"models/objects/gibs/skull/tris.md2"
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
	bc 12,2,.L95
	lis 9,.LC35@ha
	li 0,1
	la 4,.LC35@l(9)
	stw 0,60(31)
	b .L96
.L95:
	lis 9,.LC36@ha
	stw 3,60(31)
	la 4,.LC36@l(9)
.L96:
	lis 9,.LC40@ha
	lfs 0,12(31)
	lis 11,.LC41@ha
	la 9,.LC40@l(9)
	li 29,0
	lfs 13,0(9)
	la 11,.LC41@l(11)
	mr 3,31
	lfd 31,0(11)
	lis 9,gi+44@ha
	addi 30,1,8
	stw 29,56(31)
	lis 11,.LC42@ha
	lis 28,0x4330
	fadds 0,0,13
	la 11,.LC42@l(11)
	lfd 28,0(11)
	lis 11,.LC43@ha
	stfs 0,12(31)
	la 11,.LC43@l(11)
	lwz 0,gi+44@l(9)
	lfd 30,0(11)
	mtlr 0
	blrl
	lwz 0,264(31)
	lis 9,0x4180
	lis 7,0xc180
	li 10,2
	li 8,12
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
	lis 11,.LC44@ha
	stw 3,36(1)
	la 11,.LC44@l(11)
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
	bc 12,1,.L97
	lis 9,.LC38@ha
	mr 3,30
	lfs 1,.LC38@l(9)
	mr 4,3
	bl VectorScale
	b .L99
.L97:
	lis 9,.LC39@ha
	mr 3,30
	lfs 1,.LC39@l(9)
	mr 4,3
	bl VectorScale
.L99:
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
	bc 12,2,.L100
	li 0,5
	stw 0,3788(9)
	lwz 9,84(31)
	lwz 0,56(31)
	stw 0,3784(9)
	b .L101
.L100:
	li 0,0
	stw 9,436(31)
	stw 0,428(31)
.L101:
	li 0,50
	lis 9,gi+72@ha
	stw 0,400(31)
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
.LC46:
	.string	"debris"
	.align 2
.LC45:
	.long 0x46fffe00
	.align 3
.LC47:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC48:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC49:
	.long 0x40590000
	.long 0x0
	.align 2
.LC50:
	.long 0x44160000
	.align 2
.LC51:
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
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	lis 25,gi@ha
	lfd 31,0(9)
	la 25,gi@l(25)
	lis 11,.LC48@ha
	stfs 0,4(29)
	lis 9,.LC49@ha
	la 11,.LC48@l(11)
	lfs 13,4(28)
	la 9,.LC49@l(9)
	mr 4,27
	lfd 30,0(9)
	li 27,0
	lfd 29,0(11)
	stfs 13,8(29)
	lis 11,.LC50@ha
	lfs 0,8(28)
	la 11,.LC50@l(11)
	lfs 27,0(11)
	stfs 0,12(29)
	lwz 9,44(25)
	mtlr 9
	blrl
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC45@ha
	stw 3,28(1)
	stw 26,24(1)
	lfd 13,24(1)
	lfs 28,.LC45@l(11)
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
	lis 11,.LC51@ha
	stw 3,28(1)
	la 11,.LC51@l(11)
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
	lis 11,.LC46@ha
	stw 27,264(29)
	la 11,.LC46@l(11)
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
.LC52:
	.string	"item_flag_team1"
	.align 2
.LC53:
	.string	"The %s flag has returned!\n"
	.align 2
.LC54:
	.string	"item_flag_team2"
	.section	".text"
	.align 2
	.globl BecomeExplosion1
	.type	 BecomeExplosion1,@function
BecomeExplosion1:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lis 4,.LC52@ha
	lwz 3,280(31)
	la 4,.LC52@l(4)
	bl strcmp
	cmpwi 0,3,0
	li 3,1
	bc 12,2,.L108
	lwz 3,280(31)
	lis 4,.LC54@ha
	la 4,.LC54@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L106
	li 3,2
.L108:
	lis 29,gi@ha
	bl CTFResetFlag
	li 3,1
	bl CTFTeamName
	lwz 0,gi@l(29)
	mr 5,3
	lis 4,.LC53@ha
	la 4,.LC53@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L104
.L106:
	lwz 9,648(31)
	cmpwi 0,9,0
	bc 12,2,.L107
	lwz 0,56(9)
	andi. 9,0,64
	bc 12,2,.L107
	mr 3,31
	bl CTFRespawnTech
	b .L104
.L107:
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
.L104:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 BecomeExplosion1,.Lfe5-BecomeExplosion1
	.section	".rodata"
	.align 2
.LC55:
	.long 0x4cbebc20
	.align 2
.LC56:
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
	bc 4,2,.L110
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L110
	lwz 0,312(30)
	cmpwi 0,0,0
	bc 12,2,.L113
	lwz 29,296(30)
	stw 0,296(30)
	bl G_UseTargets
	stw 29,296(30)
.L113:
	lwz 3,296(30)
	cmpwi 0,3,0
	bc 12,2,.L114
	bl G_PickTarget
	mr 9,3
	b .L115
.L114:
	li 9,0
.L115:
	cmpwi 0,9,0
	bc 12,2,.L116
	lwz 0,284(9)
	andi. 11,0,1
	bc 12,2,.L116
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
.L116:
	lis 11,.LC56@ha
	stw 9,416(31)
	la 11,.LC56@l(11)
	stw 9,412(31)
	lfs 0,0(11)
	lfs 13,592(30)
	fcmpu 0,13,0
	bc 12,2,.L117
	lis 9,level+4@ha
	lwz 11,788(31)
	mr 3,31
	lfs 0,level+4@l(9)
	mtlr 11
	b .L120
.L117:
	cmpwi 0,9,0
	bc 4,2,.L118
	lis 9,level+4@ha
	lis 11,.LC55@ha
	lwz 10,788(31)
	lfs 0,level+4@l(9)
	mr 3,31
	lfs 13,.LC55@l(11)
	mtlr 10
.L120:
	fadds 0,0,13
	stfs 0,828(31)
	blrl
	b .L110
.L118:
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
.L110:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 path_corner_touch,.Lfe6-path_corner_touch
	.section	".rodata"
	.align 2
.LC57:
	.string	"path_corner with no targetname at %s\n"
	.align 2
.LC58:
	.string	"%s at %s target %s does not exist\n"
	.align 2
.LC59:
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
	bc 4,2,.L123
	lwz 0,296(30)
	cmpwi 0,0,0
	bc 12,2,.L125
	mr 3,0
	stw 0,296(31)
	bl G_PickTarget
	cmpwi 0,3,0
	stw 3,416(31)
	stw 3,412(31)
	bc 4,2,.L126
	lis 29,gi@ha
	lwz 28,280(30)
	addi 3,30,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC58@ha
	lwz 6,296(30)
	la 3,.LC58@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	stw 30,416(31)
.L126:
	li 0,0
	stw 0,296(30)
	b .L127
.L125:
	lwz 0,284(30)
	andi. 9,0,1
	bc 12,2,.L127
	lwz 0,264(31)
	andi. 9,0,3
	bc 4,2,.L127
	lis 11,.LC59@ha
	lis 9,level+4@ha
	lwz 0,776(31)
	lfs 0,level+4@l(9)
	mr 3,31
	lfs 13,.LC59@l(11)
	ori 0,0,1
	lwz 11,788(31)
	stw 0,776(31)
	fadds 0,0,13
	mtlr 11
	stfs 0,828(31)
	blrl
.L127:
	lwz 0,416(31)
	cmpw 0,0,30
	bc 4,2,.L129
	lwz 0,776(31)
	li 11,0
	lwz 9,540(31)
	rlwinm 0,0,0,20,18
	stw 11,416(31)
	stw 9,412(31)
	stw 0,776(31)
	stw 11,296(31)
.L129:
	lwz 0,312(30)
	cmpwi 0,0,0
	bc 12,2,.L123
	lwz 29,296(30)
	stw 0,296(30)
	lwz 4,540(31)
	cmpwi 0,4,0
	bc 12,2,.L131
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 4,2,.L137
.L131:
	lwz 4,544(31)
	cmpwi 0,4,0
	bc 12,2,.L133
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L133
.L137:
	mr 3,4
	b .L132
.L133:
	lwz 9,548(31)
	mr 3,31
	cmpwi 0,9,0
	bc 12,2,.L132
	lwz 0,84(9)
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,3,0
	or 3,0,9
.L132:
	mr 4,3
	mr 3,30
	bl G_UseTargets
	stw 29,296(30)
.L123:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 point_combat_touch,.Lfe7-point_combat_touch
	.section	".rodata"
	.align 2
.LC61:
	.string	"viewthing spawned\n"
	.align 2
.LC62:
	.string	"models/objects/banner/tris.md2"
	.align 2
.LC63:
	.string	"m"
	.align 2
.LC64:
	.string	"a"
	.align 2
.LC65:
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
	bc 12,2,.L158
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L158:
	lwz 0,284(31)
	andi. 9,0,16
	bc 12,2,.L159
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L159:
	lwz 0,284(31)
	andi. 9,0,7
	bc 4,2,.L160
	li 0,3
	mr 3,31
	stw 0,248(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	b .L157
.L160:
	andi. 9,0,1
	bc 4,2,.L161
	ori 0,0,1
	stw 0,284(31)
.L161:
	lwz 0,284(31)
	andi. 9,0,4
	bc 12,2,.L162
	andi. 9,0,2
	bc 4,2,.L162
	lwz 0,4(30)
	lis 3,.LC65@ha
	la 3,.LC65@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,284(31)
	ori 0,0,2
	stw 0,284(31)
.L162:
	lwz 0,284(31)
	lis 9,func_wall_use@ha
	la 9,func_wall_use@l(9)
	andi. 11,0,4
	stw 9,448(31)
	bc 12,2,.L164
	li 0,3
	stw 0,248(31)
	b .L165
.L164:
	lwz 0,184(31)
	stw 11,248(31)
	ori 0,0,1
	stw 0,184(31)
.L165:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L157:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 SP_func_wall,.Lfe8-SP_func_wall
	.section	".rodata"
	.align 3
.LC66:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC67:
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
	lis 9,.LC67@ha
	lfs 10,188(31)
	la 9,.LC67@l(9)
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
	bc 4,2,.L174
	li 0,100
	stw 0,516(31)
.L174:
	lwz 0,284(31)
	cmpwi 0,0,0
	bc 4,2,.L175
	li 11,3
	lis 9,func_object_release@ha
	stw 11,248(31)
	la 9,func_object_release@l(9)
	li 0,2
	stw 0,260(31)
	lis 11,level+4@ha
	lis 10,.LC66@ha
	stw 9,436(31)
	lfs 0,level+4@l(11)
	lfd 13,.LC66@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	b .L176
.L175:
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
.L176:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L177
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L177:
	lwz 0,284(31)
	andi. 9,0,4
	bc 12,2,.L178
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L178:
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
.LC69:
	.string	"models/objects/debris1/tris.md2"
	.align 2
.LC70:
	.string	"models/objects/debris2/tris.md2"
	.align 2
.LC68:
	.long 0x46fffe00
	.align 2
.LC71:
	.long 0x3f000000
	.align 3
.LC72:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC73:
	.long 0x43160000
	.align 3
.LC74:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC75:
	.long 0x3f800000
	.align 2
.LC76:
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
	lis 9,.LC71@ha
	mr 31,3
	la 9,.LC71@l(9)
	addi 28,1,40
	lfs 1,0(9)
	mr 30,4
	mr 26,5
	addi 3,31,236
	mr 4,28
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
	bc 12,2,.L180
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
	lis 9,.LC72@ha
	stw 0,60(1)
	li 5,0
	la 9,.LC72@l(9)
	stw 10,56(1)
	li 6,25
	lfd 0,0(9)
	lfd 2,56(1)
	fsub 1,1,0
	fsub 2,2,0
	frsp 1,1
	frsp 2,2
	bl T_RadiusDamage
.L180:
	lfs 0,4(30)
	addi 29,31,376
	lfs 13,4(31)
	mr 3,29
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,376(31)
	lfs 0,8(30)
	fsubs 12,12,0
	stfs 12,380(31)
	lfs 0,12(30)
	fsubs 11,11,0
	stfs 11,384(31)
	bl VectorNormalize
	lis 9,.LC73@ha
	mr 3,29
	la 9,.LC73@l(9)
	mr 4,3
	lfs 1,0(9)
	bl VectorScale
	lis 9,.LC71@ha
	mr 3,28
	la 9,.LC71@l(9)
	mr 4,3
	lfs 1,0(9)
	bl VectorScale
	lwz 30,400(31)
	srawi 9,30,31
	xor 0,9,30
	subf 0,0,9
	srawi 0,0,31
	nor 9,0,0
	andi. 9,9,75
	and 0,30,0
	or 30,0,9
	cmpwi 0,30,99
	bc 4,1,.L182
	lis 0,0x51eb
	srawi 9,30,31
	ori 0,0,34079
	mulhw 0,30,0
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
	bc 12,2,.L182
	lis 9,.LC68@ha
	lis 11,.LC74@ha
	lfs 29,.LC68@l(9)
	la 11,.LC74@l(11)
	lis 28,0x4330
	lis 9,.LC72@ha
	lfd 31,0(11)
	lis 27,.LC69@ha
	la 9,.LC72@l(9)
	lfd 30,0(9)
.L186:
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,8(1)
	xoris 3,3,0x8000
	lfs 12,40(1)
	stw 3,60(1)
	stw 28,56(1)
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
	stw 28,56(1)
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
	lis 11,.LC75@ha
	stw 0,60(1)
	la 11,.LC75@l(11)
	mr 3,31
	stw 28,56(1)
	la 4,.LC69@l(27)
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
	bc 4,2,.L186
.L182:
	lis 0,0x51eb
	srawi 9,30,31
	ori 0,0,34079
	mulhw 0,30,0
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
	bc 12,2,.L190
	lis 9,.LC68@ha
	lis 11,.LC74@ha
	lfs 29,.LC68@l(9)
	la 11,.LC74@l(11)
	lis 30,0x4330
	lis 9,.LC72@ha
	lfd 31,0(11)
	lis 28,.LC70@ha
	la 9,.LC72@l(9)
	lfd 30,0(9)
.L191:
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
	lis 11,.LC76@ha
	stw 0,60(1)
	la 11,.LC76@l(11)
	mr 3,31
	stw 30,56(1)
	la 4,.LC70@l(28)
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
	bc 4,2,.L191
.L190:
	mr 4,26
	mr 3,31
	bl G_UseTargets
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 12,2,.L193
	mr 3,31
	bl BecomeExplosion1
	b .L194
.L193:
	mr 3,31
	bl G_FreeEdict
.L194:
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
.LC77:
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
	lis 11,.LC77@ha
	lis 9,deathmatch@ha
	la 11,.LC77@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L198
	bl G_FreeEdict
	b .L197
.L198:
	li 0,2
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,260(31)
	lis 3,.LC69@ha
	lwz 9,32(29)
	la 3,.LC69@l(3)
	mtlr 9
	blrl
	lwz 9,32(29)
	lis 3,.LC70@ha
	la 3,.LC70@l(3)
	mtlr 9
	blrl
	lwz 0,44(29)
	mr 3,31
	lwz 4,268(31)
	mtlr 0
	blrl
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L199
	lwz 0,184(31)
	lis 9,func_explosive_spawn@ha
	li 11,0
	la 9,func_explosive_spawn@l(9)
	stw 11,248(31)
	ori 0,0,1
	stw 9,448(31)
	stw 0,184(31)
	b .L200
.L199:
	lwz 9,300(31)
	li 0,3
	stw 0,248(31)
	cmpwi 0,9,0
	bc 12,2,.L200
	lis 9,func_explosive_use@ha
	la 9,func_explosive_use@l(9)
	stw 9,448(31)
.L200:
	lwz 0,284(31)
	andi. 11,0,2
	bc 12,2,.L202
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L202:
	lwz 0,284(31)
	andi. 9,0,4
	bc 12,2,.L203
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L203:
	lwz 0,448(31)
	lis 9,func_explosive_use@ha
	la 9,func_explosive_use@l(9)
	cmpw 0,0,9
	bc 12,2,.L204
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,2,.L205
	li 0,100
	stw 0,480(31)
.L205:
	lis 9,func_explosive_explode@ha
	li 0,1
	la 9,func_explosive_explode@l(9)
	stw 0,512(31)
	stw 9,456(31)
.L204:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L197:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 SP_func_explosive,.Lfe11-SP_func_explosive
	.section	".rodata"
	.align 2
.LC80:
	.string	"models/objects/debris3/tris.md2"
	.align 2
.LC79:
	.long 0x46fffe00
	.align 3
.LC81:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC82:
	.long 0x40690000
	.long 0x0
	.align 3
.LC83:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC84:
	.long 0x3f000000
	.align 3
.LC85:
	.long 0x3ff80000
	.long 0x0
	.align 3
.LC86:
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
	lis 8,.LC81@ha
	lwz 4,548(31)
	li 6,26
	xoris 0,9,0x8000
	la 8,.LC81@l(8)
	stw 0,44(1)
	addi 9,9,40
	stw 29,40(1)
	xoris 9,9,0x8000
	li 5,0
	lfd 1,40(1)
	addi 30,31,4
	lis 26,.LC69@ha
	stw 9,44(1)
	lis 11,.LC82@ha
	lis 28,.LC80@ha
	stw 29,40(1)
	la 11,.LC82@l(11)
	lis 27,.LC70@ha
	lfd 2,40(1)
	lfd 31,0(8)
	lis 8,.LC83@ha
	lfd 28,0(11)
	la 8,.LC83@l(8)
	fsub 1,1,31
	lfd 30,0(8)
	fsub 2,2,31
	frsp 1,1
	frsp 2,2
	bl T_RadiusDamage
	lis 8,.LC84@ha
	lfs 12,4(31)
	addi 4,31,236
	lfs 13,8(31)
	la 8,.LC84@l(8)
	mr 5,30
	lfs 0,12(31)
	addi 3,31,212
	lfs 1,0(8)
	stfs 12,24(1)
	stfs 13,28(1)
	stfs 0,32(1)
	bl VectorMA
	lwz 0,516(31)
	lis 8,.LC85@ha
	la 8,.LC85@l(8)
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
	lis 11,.LC79@ha
	lfs 12,236(31)
	stw 3,44(1)
	stw 29,40(1)
	lfd 13,40(1)
	lfs 29,.LC79@l(11)
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
	la 4,.LC69@l(26)
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
	la 4,.LC69@l(26)
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
	lis 8,.LC86@ha
	lfs 0,220(31)
	la 8,.LC86@l(8)
	addi 5,1,8
	xoris 0,0,0x8000
	lfs 10,212(31)
	mr 3,31
	stw 0,44(1)
	la 4,.LC80@l(28)
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
	la 4,.LC80@l(28)
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
	la 4,.LC80@l(28)
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
	la 4,.LC80@l(28)
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
	la 4,.LC70@l(27)
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
	la 4,.LC70@l(27)
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
	la 4,.LC70@l(27)
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
	la 4,.LC70@l(27)
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
	la 4,.LC70@l(27)
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
	la 4,.LC70@l(27)
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
	la 4,.LC70@l(27)
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
	la 4,.LC70@l(27)
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
	bc 12,2,.L210
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
	b .L212
.L210:
	mr 3,31
	bl BecomeExplosion1
.L212:
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
.LC88:
	.string	"models/objects/barrels/tris.md2"
	.align 3
.LC89:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC90:
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
	lis 11,.LC90@ha
	lis 9,deathmatch@ha
	la 11,.LC90@l(11)
	mr 31,3
	lfs 31,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L215
	bl G_FreeEdict
	b .L214
.L215:
	lis 9,gi@ha
	lis 3,.LC69@ha
	la 30,gi@l(9)
	la 3,.LC69@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 9,32(30)
	lis 3,.LC70@ha
	la 3,.LC70@l(3)
	mtlr 9
	blrl
	lwz 9,32(30)
	lis 3,.LC80@ha
	la 3,.LC80@l(3)
	mtlr 9
	blrl
	lis 9,.LC88@ha
	li 11,2
	la 9,.LC88@l(9)
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
	bc 4,2,.L216
	li 0,400
	stw 0,400(31)
.L216:
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,2,.L217
	li 0,10
	stw 0,480(31)
.L217:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L218
	li 0,150
	stw 0,516(31)
.L218:
	lis 9,barrel_delay@ha
	lis 11,barrel_touch@ha
	la 9,barrel_delay@l(9)
	la 11,barrel_touch@l(11)
	stw 9,456(31)
	lis 10,M_droptofloor@ha
	li 0,0
	stw 11,444(31)
	li 9,4132
	la 10,M_droptofloor@l(10)
	li 8,1
	li 7,1024
	stw 9,1136(31)
	stw 0,488(31)
	lis 11,level+4@ha
	lis 9,.LC89@ha
	stw 8,512(31)
	mr 3,31
	stw 7,776(31)
	stw 10,436(31)
	lfs 0,level+4@l(11)
	lfd 13,.LC89@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,72(30)
	mtlr 0
	blrl
.L214:
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
.LC92:
	.string	"models/objects/black/tris.md2"
	.align 2
.LC95:
	.string	"models/monsters/tank/tris.md2"
	.align 2
.LC98:
	.string	"models/monsters/bitch/tris.md2"
	.align 2
.LC103:
	.string	"tank/thud.wav"
	.align 2
.LC105:
	.string	"tank/pain.wav"
	.align 2
.LC106:
	.string	"models/monsters/commandr/tris.md2"
	.align 2
.LC109:
	.string	"misc/udeath.wav"
	.align 2
.LC110:
	.string	"models/deadbods/dude/tris.md2"
	.align 2
.LC111:
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
	lis 11,.LC111@ha
	lis 9,deathmatch@ha
	la 11,.LC111@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L253
	bl G_FreeEdict
	b .L252
.L253:
	li 0,0
	li 29,2
	lis 9,gi+32@ha
	stw 0,260(31)
	lis 3,.LC110@ha
	stw 29,248(31)
	la 3,.LC110@l(3)
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
	lwz 0,284(31)
	stw 3,40(31)
	andi. 9,0,2
	bc 12,2,.L254
	li 0,1
	b .L262
.L254:
	andi. 11,0,4
	bc 12,2,.L256
	stw 29,56(31)
	b .L255
.L256:
	andi. 9,0,8
	bc 12,2,.L258
	li 0,3
	b .L262
.L258:
	andi. 11,0,16
	bc 12,2,.L260
	li 0,4
	b .L262
.L260:
	andi. 0,0,32
	bc 12,2,.L262
	li 0,5
.L262:
	stw 0,56(31)
.L255:
	lwz 11,184(31)
	li 0,0
	li 6,2
	lwz 9,776(31)
	lis 10,misc_deadsoldier_die@ha
	lis 7,0x4180
	stw 0,196(31)
	lis 29,0xc180
	la 10,misc_deadsoldier_die@l(10)
	li 0,200
	stw 6,492(31)
	ori 11,11,6
	ori 9,9,256
	li 8,1
	stw 29,192(31)
	li 4,-80
	li 5,4100
	stw 7,208(31)
	stw 8,512(31)
	lis 6,gi+72@ha
	mr 3,31
	stw 11,184(31)
	stw 10,456(31)
	stw 9,776(31)
	stw 4,488(31)
	stw 0,400(31)
	stw 5,1136(31)
	stw 29,188(31)
	stw 7,200(31)
	stw 7,204(31)
	lwz 0,gi+72@l(6)
	mtlr 0
	blrl
.L252:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 SP_misc_deadsoldier,.Lfe14-SP_misc_deadsoldier
	.section	".rodata"
	.align 2
.LC112:
	.string	"misc_viper without a target at %s\n"
	.align 2
.LC113:
	.string	"models/ships/viper/tris.md2"
	.align 3
.LC114:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC115:
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
	bc 4,2,.L266
	lis 29,gi@ha
	addi 3,31,212
	la 29,gi@l(29)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC112@ha
	la 3,.LC112@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L265
.L266:
	lis 9,.LC115@ha
	lfs 0,328(31)
	la 9,.LC115@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L267
	lis 0,0x4396
	stw 0,328(31)
.L267:
	li 0,2
	li 9,0
	lis 29,gi@ha
	stw 0,260(31)
	lis 3,.LC113@ha
	la 29,gi@l(29)
	stw 9,248(31)
	la 3,.LC113@l(3)
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
	lis 8,.LC114@ha
	lis 9,misc_viper_use@ha
	stw 10,204(31)
	la 9,misc_viper_use@l(9)
	mr 3,31
	stw 11,436(31)
	stw 7,188(31)
	stw 10,200(31)
	lfs 0,level+4@l(6)
	lfd 12,.LC114@l(8)
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
.L265:
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
.LC116:
	.string	"models/ships/bigviper/tris.md2"
	.align 2
.LC117:
	.string	"misc_viper"
	.align 2
.LC118:
	.string	"models/objects/bomb/tris.md2"
	.align 2
.LC119:
	.string	"%s without a target at %s\n"
	.align 2
.LC120:
	.string	"models/ships/strogg1/tris.md2"
	.align 3
.LC121:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC122:
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
	bc 4,2,.L278
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,212
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC119@ha
	la 3,.LC119@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L277
.L278:
	lis 9,.LC122@ha
	lfs 0,328(31)
	la 9,.LC122@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L279
	lis 0,0x4396
	stw 0,328(31)
.L279:
	li 0,2
	li 9,0
	lis 29,gi@ha
	stw 0,260(31)
	lis 3,.LC120@ha
	la 29,gi@l(29)
	stw 9,248(31)
	la 3,.LC120@l(3)
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
	lis 8,.LC121@ha
	lis 9,misc_strogg_ship_use@ha
	stw 10,204(31)
	la 9,misc_strogg_ship_use@l(9)
	mr 3,31
	stw 11,436(31)
	stw 7,188(31)
	stw 10,200(31)
	lfs 0,level+4@l(6)
	lfd 12,.LC121@l(8)
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
.L277:
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
.LC125:
	.string	"models/objects/satellite/tris.md2"
	.align 2
.LC126:
	.string	"models/objects/minelite/light1/tris.md2"
	.align 2
.LC127:
	.string	"models/objects/minelite/light2/tris.md2"
	.align 2
.LC128:
	.string	"models/objects/gibs/arm/tris.md2"
	.align 2
.LC129:
	.long 0x46fffe00
	.align 3
.LC130:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC131:
	.long 0x43480000
	.align 2
.LC132:
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
	lis 4,.LC128@ha
	lwz 11,44(27)
	la 4,.LC128@l(4)
	lis 8,.LC130@ha
	lis 9,.LC131@ha
	mtlr 11
	la 8,.LC130@l(8)
	la 9,.LC131@l(9)
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
	lis 11,.LC129@ha
	stw 3,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	lfs 30,.LC129@l(11)
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
	lis 8,.LC132@ha
	stw 28,24(1)
	lis 10,level+4@ha
	la 8,.LC132@l(8)
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
.LC133:
	.string	"models/objects/gibs/leg/tris.md2"
	.align 2
.LC134:
	.long 0x46fffe00
	.align 3
.LC135:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC136:
	.long 0x43480000
	.align 2
.LC137:
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
	lis 4,.LC133@ha
	lwz 11,44(27)
	la 4,.LC133@l(4)
	lis 8,.LC135@ha
	lis 9,.LC136@ha
	mtlr 11
	la 8,.LC135@l(8)
	la 9,.LC136@l(9)
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
	lis 11,.LC134@ha
	stw 3,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	lfs 30,.LC134@l(11)
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
	lis 8,.LC137@ha
	stw 28,24(1)
	lis 10,level+4@ha
	la 8,.LC137@l(8)
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
.LC138:
	.string	"models/objects/gibs/head/tris.md2"
	.align 2
.LC139:
	.long 0x46fffe00
	.align 3
.LC140:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC141:
	.long 0x43480000
	.align 2
.LC142:
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
	lis 4,.LC138@ha
	lwz 11,44(27)
	la 4,.LC138@l(4)
	lis 8,.LC140@ha
	lis 9,.LC141@ha
	mtlr 11
	la 8,.LC140@l(8)
	la 9,.LC141@l(9)
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
	lis 11,.LC139@ha
	stw 3,28(1)
	stw 28,24(1)
	lfd 0,24(1)
	lfs 30,.LC139@l(11)
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
	lis 8,.LC142@ha
	stw 28,24(1)
	lis 10,level+4@ha
	la 8,.LC142@l(8)
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
.LC143:
	.string	""
	.align 2
.LC144:
	.string	"%2i"
	.align 2
.LC145:
	.string	"%2i:%2i"
	.align 2
.LC146:
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
	bc 4,2,.L311
	lis 5,.LC144@ha
	lwz 6,480(31)
	li 4,16
	lwz 3,276(31)
	la 5,.LC144@l(5)
	crxor 6,6,6
	bl Com_sprintf
	b .L310
.L311:
	cmpwi 0,0,1
	bc 4,2,.L312
	lwz 0,480(31)
	lis 6,0x8888
	lis 5,.LC145@ha
	ori 6,6,34953
	lwz 3,276(31)
	la 5,.LC145@l(5)
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
	bc 4,2,.L310
	li 0,48
	stb 0,3(3)
	b .L310
.L312:
	cmpwi 0,0,2
	bc 4,2,.L310
	lwz 9,480(31)
	lis 6,0x91a2
	lis 7,0x8888
	ori 6,6,46021
	ori 7,7,34953
	lwz 3,276(31)
	mulhw 6,9,6
	srawi 11,9,31
	lis 5,.LC146@ha
	mulhw 8,9,7
	la 5,.LC146@l(5)
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
	bc 4,2,.L315
	li 0,48
	stb 0,3(9)
.L315:
	lwz 3,276(31)
	lbz 0,6(3)
	cmpwi 0,0,32
	bc 4,2,.L310
	li 0,48
	stb 0,6(3)
.L310:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe20:
	.size	 func_clock_format_countdown,.Lfe20-func_clock_format_countdown
	.section	".rodata"
	.align 3
.LC147:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC148:
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
	bc 4,2,.L318
	lwz 5,296(31)
	li 3,0
	li 4,300
	bl G_Find
	cmpwi 0,3,0
	stw 3,540(31)
	bc 12,2,.L317
.L318:
	lwz 0,284(31)
	andi. 8,0,1
	bc 12,2,.L320
	mr 3,31
	bl func_clock_format_countdown
	lwz 9,480(31)
	addi 9,9,1
	stw 9,480(31)
	b .L321
.L320:
	andi. 8,0,2
	bc 12,2,.L322
	mr 3,31
	bl func_clock_format_countdown
	lwz 9,480(31)
	addi 9,9,-1
	stw 9,480(31)
	b .L321
.L322:
	addi 29,1,8
	mr 3,29
	bl time
	mr 3,29
	bl localtime
	mr 9,3
	lis 5,.LC146@ha
	lwz 8,0(9)
	la 5,.LC146@l(5)
	li 4,16
	lwz 6,8(9)
	lwz 7,4(9)
	lwz 3,276(31)
	crxor 6,6,6
	bl Com_sprintf
	lwz 9,276(31)
	lbz 0,3(9)
	cmpwi 0,0,32
	bc 4,2,.L324
	li 0,48
	stb 0,3(9)
.L324:
	lwz 9,276(31)
	lbz 0,6(9)
	cmpwi 0,0,32
	bc 4,2,.L321
	li 0,48
	stb 0,6(9)
.L321:
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
	bc 12,2,.L328
	lwz 0,480(31)
	lis 11,0x4330
	lis 8,.LC147@ha
	lfs 12,592(31)
	xoris 0,0,0x8000
	la 8,.LC147@l(8)
	stw 0,28(1)
	stw 11,24(1)
	lfd 13,0(8)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,1,.L327
.L328:
	andi. 9,10,2
	bc 12,2,.L326
	lwz 0,480(31)
	lis 11,0x4330
	lis 10,.LC147@ha
	lfs 12,592(31)
	xoris 0,0,0x8000
	la 10,.LC147@l(10)
	stw 0,28(1)
	stw 11,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L326
.L327:
	lwz 9,312(31)
	cmpwi 0,9,0
	bc 12,2,.L329
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
.L329:
	lwz 0,284(31)
	andi. 8,0,8
	bc 12,2,.L317
	andi. 9,0,1
	li 10,0
	stw 10,548(31)
	bc 12,2,.L331
	lwz 0,532(31)
	lis 11,0x4330
	lis 8,.LC147@ha
	stw 10,480(31)
	xoris 0,0,0x8000
	la 8,.LC147@l(8)
	stw 0,28(1)
	stw 11,24(1)
	lfd 13,0(8)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,592(31)
	b .L334
.L331:
	andi. 9,0,2
	bc 12,2,.L334
	lwz 9,532(31)
	li 0,0
	stw 0,592(31)
	stw 9,480(31)
.L334:
	lwz 0,284(31)
	andi. 10,0,4
	bc 4,2,.L317
.L326:
	lis 11,.LC148@ha
	lis 9,level+4@ha
	la 11,.LC148@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,428(31)
.L317:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe21:
	.size	 func_clock_think,.Lfe21-func_clock_think
	.section	".rodata"
	.align 2
.LC149:
	.string	"%s with no target at %s\n"
	.align 2
.LC150:
	.string	"%s with no count at %s\n"
	.align 3
.LC151:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC152:
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
	bc 4,2,.L340
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC149@ha
	la 3,.LC149@l(3)
	b .L349
.L340:
	lwz 0,284(31)
	andi. 8,0,2
	mr 9,0
	bc 12,2,.L341
	lwz 0,532(31)
	cmpwi 0,0,0
	bc 4,2,.L341
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC150@ha
	la 3,.LC150@l(3)
.L349:
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L339
.L341:
	andi. 0,9,1
	bc 12,2,.L342
	lwz 0,532(31)
	cmpwi 0,0,0
	bc 4,2,.L342
	li 0,3600
	stw 0,532(31)
.L342:
	lwz 0,284(31)
	li 10,0
	stw 10,548(31)
	andi. 8,0,1
	bc 12,2,.L343
	lwz 0,532(31)
	lis 11,0x4330
	lis 8,.LC151@ha
	stw 10,480(31)
	xoris 0,0,0x8000
	la 8,.LC151@l(8)
	stw 0,12(1)
	stw 11,8(1)
	lfd 13,0(8)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,592(31)
	b .L346
.L343:
	andi. 9,0,2
	bc 12,2,.L346
	lwz 9,532(31)
	li 0,0
	stw 0,592(31)
	stw 9,480(31)
.L346:
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
	bc 12,2,.L347
	lis 9,func_clock_use@ha
	la 9,func_clock_use@l(9)
	stw 9,448(31)
	b .L339
.L347:
	lis 11,.LC152@ha
	lis 9,level+4@ha
	la 11,.LC152@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,428(31)
.L339:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 SP_func_clock,.Lfe22-SP_func_clock
	.section	".rodata"
	.align 2
.LC153:
	.string	"Couldn't find destination\n"
	.align 2
.LC154:
	.long 0x47800000
	.align 2
.LC155:
	.long 0x43b40000
	.align 2
.LC156:
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
	bc 12,2,.L350
	lwz 5,296(29)
	li 3,0
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L352
	lis 9,gi+4@ha
	lis 3,.LC153@ha
	lwz 0,gi+4@l(9)
	la 3,.LC153@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L350
.L352:
	mr 3,31
	bl CTFPlayerResetGrapple
	lis 9,gi+76@ha
	mr 3,31
	lwz 0,gi+76@l(9)
	mtlr 0
	blrl
	lfs 0,4(30)
	lis 9,.LC154@ha
	lis 11,.LC155@ha
	la 9,.LC154@l(9)
	la 11,.LC155@l(11)
	lwz 8,84(31)
	lfs 10,0(9)
	li 0,0
	li 10,6
	stfs 0,4(31)
	lis 9,.LC156@ha
	addi 5,30,16
	lfs 0,8(30)
	la 9,.LC156@l(9)
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
.L358:
	lwz 10,84(31)
	add 0,6,6
	lfsx 0,7,5
	addi 6,6,1
	addi 9,10,3484
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
	bdnz .L358
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
	stw 0,3728(9)
	stw 0,3736(9)
	stw 0,3732(9)
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L350:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe23:
	.size	 teleporter_touch,.Lfe23-teleporter_touch
	.section	".rodata"
	.align 2
.LC157:
	.string	"teleporter without a target.\n"
	.align 2
.LC158:
	.string	"models/objects/dmspot/tris.md2"
	.align 2
.LC159:
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
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L360
	lis 9,gi+4@ha
	lis 3,.LC157@ha
	lwz 0,gi+4@l(9)
	la 3,.LC157@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L359
.L360:
	lis 29,gi@ha
	lis 4,.LC158@ha
	la 29,gi@l(29)
	la 4,.LC158@l(4)
	lwz 9,44(29)
	mr 3,31
	li 28,1
	mtlr 9
	blrl
	lis 0,0x2
	stw 28,60(31)
	lis 3,.LC159@ha
	stw 0,64(31)
	la 3,.LC159@l(3)
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
.L359:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 SP_misc_teleporter,.Lfe24-SP_misc_teleporter
	.section	".rodata"
	.align 2
.LC161:
	.string	"models/fire/tris.md2"
	.align 2
.LC163:
	.string	"blood"
	.align 2
.LC160:
	.long 0x46fffe00
	.align 3
.LC162:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC164:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC165:
	.long 0x43fa0000
	.section	".text"
	.align 2
	.globl BloodTrail
	.type	 BloodTrail,@function
BloodTrail:
	stwu 1,-64(1)
	mflr 0
	stmw 27,44(1)
	stw 0,68(1)
	mr 28,3
	lfs 9,8(4)
	li 27,0
	lfs 11,0(28)
	addi 3,1,8
	lfs 10,4(28)
	lfs 12,8(28)
	lfs 13,0(4)
	lfs 0,4(4)
	fsubs 9,9,12
	fsubs 13,13,11
	fsubs 0,0,10
	stfs 9,16(1)
	stfs 13,8(1)
	stfs 0,12(1)
	bl VectorNormalize
	bl G_Spawn
	lfs 13,0(28)
	mr 29,3
	stfs 13,4(29)
	lfs 0,4(28)
	stfs 0,8(29)
	lfs 13,8(28)
	stfs 13,12(29)
	lfs 0,0(28)
	stfs 0,28(29)
	lfs 13,4(28)
	stfs 13,32(29)
	lfs 0,8(28)
	stfs 0,36(29)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,36(1)
	lis 10,.LC164@ha
	lis 11,.LC160@ha
	stw 0,32(1)
	la 10,.LC164@l(10)
	addi 3,1,8
	lfd 13,0(10)
	addi 4,29,376
	lfd 1,32(1)
	lis 10,.LC165@ha
	lfs 0,.LC160@l(11)
	la 10,.LC165@l(10)
	lfs 12,0(10)
	fsub 1,1,13
	frsp 1,1
	fdivs 1,1,0
	fmadds 1,1,12,12
	bl VectorScale
	lwz 11,64(29)
	li 9,0
	li 10,8
	lwz 0,68(29)
	lis 28,gi@ha
	lis 3,.LC161@ha
	ori 11,11,2
	la 28,gi@l(28)
	stw 10,260(29)
	ori 0,0,40
	stw 11,64(29)
	la 3,.LC161@l(3)
	stw 0,68(29)
	stw 9,200(29)
	stw 27,248(29)
	stw 9,196(29)
	stw 9,192(29)
	stw 9,188(29)
	stw 9,208(29)
	stw 9,204(29)
	stw 27,252(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 11,bloodtrail_touch@ha
	li 0,39
	stw 3,40(29)
	la 11,bloodtrail_touch@l(11)
	stw 0,56(29)
	lis 8,level+4@ha
	stw 27,60(29)
	lis 7,.LC162@ha
	lis 10,G_FreeEdict@ha
	stw 11,444(29)
	lis 9,.LC163@ha
	la 10,G_FreeEdict@l(10)
	lfs 0,level+4@l(8)
	la 9,.LC163@l(9)
	mr 3,29
	lfd 13,.LC162@l(7)
	stw 10,436(29)
	stw 9,280(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,68(1)
	mtlr 0
	lmw 27,44(1)
	la 1,64(1)
	blr
.Lfe25:
	.size	 BloodTrail,.Lfe25-BloodTrail
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
.Lfe26:
	.size	 Use_Areaportal,.Lfe26-Use_Areaportal
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
.Lfe27:
	.size	 SP_func_areaportal,.Lfe27-SP_func_areaportal
	.section	".rodata"
	.align 2
.LC168:
	.long 0x46fffe00
	.align 2
.LC169:
	.long 0x3f333333
	.align 2
.LC170:
	.long 0x3f99999a
	.align 3
.LC171:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC172:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC173:
	.long 0x40590000
	.long 0x0
	.align 3
.LC174:
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
	lis 9,.LC171@ha
	rlwinm 3,3,0,17,31
	la 9,.LC171@l(9)
	xoris 3,3,0x8000
	lfd 30,0(9)
	lis 11,.LC168@ha
	lis 10,.LC172@ha
	lfs 28,.LC168@l(11)
	la 10,.LC172@l(10)
	stw 3,12(1)
	stw 29,8(1)
	lfd 13,8(1)
	lfd 29,0(10)
	lis 10,.LC173@ha
	fsub 13,13,30
	la 10,.LC173@l(10)
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
	lis 10,.LC174@ha
	stw 3,12(1)
	la 10,.LC174@l(10)
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
	lis 9,.LC169@ha
	mr 3,31
	lfs 1,.LC169@l(9)
	mr 4,3
	bl VectorScale
	b .L10
.L9:
	lis 9,.LC170@ha
	mr 3,31
	lfs 1,.LC170@l(9)
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
.Lfe28:
	.size	 VelocityForDamage,.Lfe28-VelocityForDamage
	.section	".rodata"
	.align 2
.LC175:
	.long 0xc3960000
	.align 2
.LC176:
	.long 0x43960000
	.align 2
.LC177:
	.long 0x43480000
	.align 2
.LC178:
	.long 0x43fa0000
	.section	".text"
	.align 2
	.globl ClipGibVelocity
	.type	 ClipGibVelocity,@function
ClipGibVelocity:
	lis 9,.LC175@ha
	lfs 0,376(3)
	la 9,.LC175@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L366
	lis 9,.LC176@ha
	la 9,.LC176@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L13
.L366:
	stfs 13,376(3)
.L13:
	lis 9,.LC175@ha
	lfs 0,380(3)
	la 9,.LC175@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L367
	lis 9,.LC176@ha
	la 9,.LC176@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,1,.L16
.L367:
	stfs 13,380(3)
.L16:
	lis 9,.LC177@ha
	lfs 0,384(3)
	la 9,.LC177@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L18
	stfs 13,384(3)
	blr
.L18:
	lis 9,.LC178@ha
	la 9,.LC178@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bclr 4,1
	stfs 13,384(3)
	blr
.Lfe29:
	.size	 ClipGibVelocity,.Lfe29-ClipGibVelocity
	.align 2
	.globl removeOldestGib
	.type	 removeOldestGib,@function
removeOldestGib:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	li 31,0
	li 3,0
	li 30,0
	b .L24
.L25:
	cmpwi 0,31,0
	addi 30,30,1
	bc 12,2,.L27
	lfs 13,288(3)
	lfs 0,288(31)
	fcmpu 0,13,0
	bc 4,0,.L24
.L27:
	mr 31,3
.L24:
	lis 5,.LC3@ha
	li 4,280
	la 5,.LC3@l(5)
	bl G_Find
	mr. 3,3
	bc 4,2,.L25
	cmpwi 7,30,25
	addic 0,31,-1
	subfe 9,0,31
	mfcr 0
	rlwinm 0,0,30,1
	and. 11,0,9
	bc 12,2,.L29
	mr 3,31
	bl G_FreeEdict
.L29:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe30:
	.size	 removeOldestGib,.Lfe30-removeOldestGib
	.section	".rodata"
	.align 3
.LC179:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC180:
	.long 0x46fffe00
	.align 3
.LC181:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC182:
	.long 0x41000000
	.align 2
.LC183:
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
	lis 9,.LC179@ha
	lfd 13,.LC179@l(9)
	addi 11,11,1
	stw 11,56(31)
	cmpwi 0,11,10
	lfs 0,4(30)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 4,2,.L31
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	stw 9,436(31)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,4(30)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC181@ha
	lis 11,.LC180@ha
	la 10,.LC181@l(10)
	stw 0,16(1)
	lfd 10,0(10)
	lfd 0,16(1)
	lis 10,.LC182@ha
	lfs 12,.LC180@l(11)
	la 10,.LC182@l(10)
	lfs 13,0(10)
	fsub 0,0,10
	lis 10,.LC183@ha
	la 10,.LC183@l(10)
	lfs 9,0(10)
	fadds 11,11,13
	frsp 0,0
	fdivs 0,0,12
	fmadds 0,0,9,11
	stfs 0,428(31)
.L31:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe31:
	.size	 gib_think,.Lfe31-gib_think
	.section	".rodata"
	.align 3
.LC184:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC185:
	.long 0x3f800000
	.align 2
.LC186:
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
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L32
	cmpwi 0,30,0
	li 0,0
	stw 0,444(31)
	bc 12,2,.L32
	lis 29,gi@ha
	lis 3,.LC6@ha
	la 29,gi@l(29)
	la 3,.LC6@l(3)
	lwz 9,36(29)
	addi 28,1,24
	mtlr 9
	blrl
	lis 9,.LC185@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC185@l(9)
	mr 3,31
	lfs 1,0(9)
	mtlr 0
	li 4,2
	lis 9,.LC185@ha
	la 9,.LC185@l(9)
	lfs 2,0(9)
	lis 9,.LC186@ha
	la 9,.LC186@l(9)
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
	bc 4,2,.L32
	lwz 11,56(31)
	lis 9,gib_think@ha
	lis 8,level+4@ha
	la 9,gib_think@l(9)
	lis 10,.LC184@ha
	addi 11,11,1
	stw 9,436(31)
	stw 11,56(31)
	lfs 0,level+4@l(8)
	lfd 13,.LC184@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L32:
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
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,260(31)
	cmpwi 0,0,7
	bc 4,2,.L37
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	addi 28,31,4
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,124(29)
	lis 3,vec3_origin@ha
	la 3,vec3_origin@l(3)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
.L37:
	mr 3,31
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe33:
	.size	 gib_die,.Lfe33-gib_die
	.align 2
	.globl head_die
	.type	 head_die,@function
head_die:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	li 9,0
	lwz 0,184(31)
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 9,512(31)
	mr 30,6
	ori 0,0,1
	stw 9,248(31)
	addi 28,31,4
	stw 0,184(31)
	lis 27,.LC22@ha
	stw 9,456(31)
	lwz 9,76(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,1
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,124(29)
	lis 3,vec3_origin@ha
	la 3,vec3_origin@l(3)
	mtlr 9
	blrl
	lwz 9,88(29)
	mr 3,28
	li 4,2
	mtlr 9
	blrl
	lwz 0,32(29)
	lis 3,.LC22@ha
	la 3,.LC22@l(3)
	mtlr 0
	blrl
	lwz 0,40(31)
	cmpw 0,0,3
	bc 12,2,.L68
	li 29,2
.L72:
	mr 3,31
	la 4,.LC22@l(27)
	mr 5,30
	li 6,0
	bl ThrowGib
	addic. 29,29,-1
	bc 4,2,.L72
.L68:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 head_die,.Lfe34-head_die
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
.Lfe35:
	.size	 debris_die,.Lfe35-debris_die
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
.Lfe36:
	.size	 BecomeExplosion2,.Lfe36-BecomeExplosion2
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
	bc 4,2,.L122
	lis 29,gi@ha
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC57@ha
	la 3,.LC57@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L121
.L122:
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
.L121:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe37:
	.size	 SP_path_corner,.Lfe37-SP_path_corner
	.section	".rodata"
	.align 2
.LC187:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_point_combat
	.type	 SP_point_combat,@function
SP_point_combat:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC187@ha
	lis 9,deathmatch@ha
	la 11,.LC187@l(11)
	mr 6,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L139
	bl G_FreeEdict
	b .L138
.L139:
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
.L138:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe38:
	.size	 SP_point_combat,.Lfe38-SP_point_combat
	.section	".rodata"
	.align 3
.LC188:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl TH_viewthing
	.type	 TH_viewthing,@function
TH_viewthing:
	lwz 11,56(3)
	lis 9,0x9249
	lis 10,.LC188@ha
	ori 9,9,9363
	lfd 13,.LC188@l(10)
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
.Lfe39:
	.size	 TH_viewthing,.Lfe39-TH_viewthing
	.section	".rodata"
	.align 3
.LC189:
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
	lis 3,.LC61@ha
	lwz 9,4(28)
	la 3,.LC61@l(3)
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
	lis 3,.LC62@ha
	stw 10,196(29)
	la 3,.LC62@l(3)
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
	lis 9,.LC189@ha
	lfs 0,level+4@l(11)
	la 9,.LC189@l(9)
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
.Lfe40:
	.size	 SP_viewthing,.Lfe40-SP_viewthing
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
.Lfe41:
	.size	 SP_info_null,.Lfe41-SP_info_null
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
.Lfe42:
	.size	 SP_info_notnull,.Lfe42-SP_info_notnull
	.section	".rodata"
	.align 2
.LC190:
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
	bc 12,2,.L149
	lis 9,.LC190@ha
	lis 11,deathmatch@ha
	la 9,.LC190@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L148
.L149:
	bl G_FreeEdict
	b .L147
.L148:
	lwz 11,644(3)
	cmpwi 0,11,31
	bc 4,1,.L147
	lwz 0,284(3)
	lis 9,light_use@ha
	la 9,light_use@l(9)
	andi. 10,0,1
	stw 9,448(3)
	bc 12,2,.L151
	lis 9,gi+24@ha
	lis 4,.LC64@ha
	lwz 0,gi+24@l(9)
	addi 3,11,800
	la 4,.LC64@l(4)
	mtlr 0
	blrl
	b .L147
.L151:
	lis 9,gi+24@ha
	lis 4,.LC63@ha
	lwz 0,gi+24@l(9)
	addi 3,11,800
	la 4,.LC63@l(4)
	mtlr 0
	blrl
.L147:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe43:
	.size	 SP_light,.Lfe43-SP_light
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
	bc 4,2,.L154
	lwz 0,184(31)
	li 9,3
	stw 9,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	bl KillBox
	b .L155
.L154:
	lwz 0,184(31)
	li 9,0
	stw 9,248(31)
	ori 0,0,1
	stw 0,184(31)
.L155:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,284(31)
	andi. 0,0,2
	bc 4,2,.L156
	stw 0,448(31)
.L156:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe44:
	.size	 func_wall_use,.Lfe44-func_wall_use
	.section	".rodata"
	.align 3
.LC191:
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
	bc 12,2,.L166
	lfs 0,8(5)
	lis 9,.LC191@ha
	la 9,.LC191@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L166
	lwz 0,512(10)
	cmpwi 0,0,0
	bc 12,2,.L166
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
.L166:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe45:
	.size	 func_object_touch,.Lfe45-func_object_touch
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
.Lfe46:
	.size	 func_object_release,.Lfe46-func_object_release
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
.Lfe47:
	.size	 func_object_use,.Lfe47-func_object_use
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
.Lfe48:
	.size	 func_explosive_use,.Lfe48-func_explosive_use
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
.Lfe49:
	.size	 func_explosive_spawn,.Lfe49-func_explosive_spawn
	.section	".rodata"
	.align 3
.LC192:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC193:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC194:
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
	bc 12,2,.L206
	cmpw 0,0,31
	bc 12,2,.L206
	lwz 0,400(4)
	lis 8,0x4330
	lwz 9,400(31)
	mr 10,11
	lis 7,.LC193@ha
	xoris 0,0,0x8000
	la 7,.LC193@l(7)
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
	lis 7,.LC194@ha
	lis 9,.LC192@ha
	la 7,.LC194@l(7)
	lfd 0,.LC192@l(9)
	mr 3,31
	lfs 13,0(7)
	fmuls 31,31,13
	fmr 2,31
	fmul 2,2,0
	frsp 2,2
	bl M_walkmove
.L206:
	lwz 0,68(1)
	mtlr 0
	lwz 31,52(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe50:
	.size	 barrel_touch,.Lfe50-barrel_touch
	.section	".rodata"
	.align 3
.LC195:
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
	lis 10,.LC195@ha
	lis 9,barrel_explode@ha
	lfs 0,level+4@l(11)
	la 9,barrel_explode@l(9)
	lfd 13,.LC195@l(10)
	stw 5,548(3)
	stw 9,436(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe51:
	.size	 barrel_delay,.Lfe51-barrel_delay
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
.Lfe52:
	.size	 misc_blackhole_use,.Lfe52-misc_blackhole_use
	.section	".rodata"
	.align 3
.LC196:
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
	bc 12,1,.L221
	lis 9,level+4@ha
	lis 11,.LC196@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC196@l(11)
.L368:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.L221:
	li 0,0
	lis 11,level+4@ha
	stw 0,56(3)
	lis 9,.LC196@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC196@l(9)
	b .L368
.Lfe53:
	.size	 misc_blackhole_think,.Lfe53-misc_blackhole_think
	.section	".rodata"
	.align 3
.LC197:
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
	lis 3,.LC92@ha
	la 28,gi@l(28)
	stw 11,260(29)
	la 3,.LC92@l(3)
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
	lis 9,.LC197@ha
	mr 3,29
	stw 11,436(29)
	lfs 0,level+4@l(10)
	lfd 13,.LC197@l(9)
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
.Lfe54:
	.size	 SP_misc_blackhole,.Lfe54-SP_misc_blackhole
	.section	".rodata"
	.align 3
.LC198:
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
	bc 12,1,.L225
	lis 9,level+4@ha
	lis 11,.LC198@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC198@l(11)
.L369:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.L225:
	li 0,254
	lis 11,level+4@ha
	stw 0,56(3)
	lis 9,.LC198@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC198@l(9)
	b .L369
.Lfe55:
	.size	 misc_eastertank_think,.Lfe55-misc_eastertank_think
	.section	".rodata"
	.align 3
.LC199:
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
	lis 3,.LC95@ha
	la 28,gi@l(28)
	stw 0,200(29)
	la 3,.LC95@l(3)
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
	lis 11,.LC199@ha
	mr 3,29
	lfs 0,level+4@l(10)
	lfd 13,.LC199@l(11)
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
.Lfe56:
	.size	 SP_misc_eastertank,.Lfe56-SP_misc_eastertank
	.section	".rodata"
	.align 3
.LC200:
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
	bc 12,1,.L229
	lis 9,level+4@ha
	lis 11,.LC200@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC200@l(11)
.L370:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.L229:
	li 0,208
	lis 11,level+4@ha
	stw 0,56(3)
	lis 9,.LC200@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC200@l(9)
	b .L370
.Lfe57:
	.size	 misc_easterchick_think,.Lfe57-misc_easterchick_think
	.section	".rodata"
	.align 3
.LC201:
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
	lis 3,.LC98@ha
	la 28,gi@l(28)
	stw 0,200(29)
	la 3,.LC98@l(3)
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
	lis 11,.LC201@ha
	mr 3,29
	lfs 0,level+4@l(10)
	lfd 13,.LC201@l(11)
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
.Lfe58:
	.size	 SP_misc_easterchick,.Lfe58-SP_misc_easterchick
	.section	".rodata"
	.align 3
.LC202:
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
	bc 12,1,.L233
	lis 9,level+4@ha
	lis 11,.LC202@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC202@l(11)
.L371:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.L233:
	li 0,248
	lis 11,level+4@ha
	stw 0,56(3)
	lis 9,.LC202@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC202@l(9)
	b .L371
.Lfe59:
	.size	 misc_easterchick2_think,.Lfe59-misc_easterchick2_think
	.section	".rodata"
	.align 3
.LC203:
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
	lis 3,.LC98@ha
	la 28,gi@l(28)
	stw 0,200(29)
	la 3,.LC98@l(3)
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
	lis 11,.LC203@ha
	mr 3,29
	lfs 0,level+4@l(10)
	lfd 13,.LC203@l(11)
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
.Lfe60:
	.size	 SP_misc_easterchick2,.Lfe60-SP_misc_easterchick2
	.section	".rodata"
	.align 3
.LC204:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC205:
	.long 0x3f800000
	.align 2
.LC206:
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
	bc 12,1,.L237
	lis 9,level+4@ha
	lis 11,.LC204@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC204@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	b .L238
.L237:
	li 0,0
	stw 0,428(31)
.L238:
	lwz 0,56(31)
	cmpwi 0,0,22
	bc 4,2,.L239
	lis 29,gi@ha
	lis 3,.LC103@ha
	la 29,gi@l(29)
	la 3,.LC103@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC205@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC205@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC205@ha
	la 9,.LC205@l(9)
	lfs 2,0(9)
	lis 9,.LC206@ha
	la 9,.LC206@l(9)
	lfs 3,0(9)
	blrl
.L239:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe61:
	.size	 commander_body_think,.Lfe61-commander_body_think
	.section	".rodata"
	.align 3
.LC207:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC208:
	.long 0x3f800000
	.align 2
.LC209:
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
	stw 9,436(28)
	lis 10,.LC207@ha
	lis 29,gi@ha
	lfs 0,level+4@l(11)
	la 29,gi@l(29)
	lis 3,.LC105@ha
	lfd 13,.LC207@l(10)
	la 3,.LC105@l(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(28)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC208@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC208@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,28
	mtlr 0
	lis 9,.LC208@ha
	la 9,.LC208@l(9)
	lfs 2,0(9)
	lis 9,.LC209@ha
	la 9,.LC209@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe62:
	.size	 commander_body_use,.Lfe62-commander_body_use
	.section	".rodata"
	.align 2
.LC210:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl commander_body_drop
	.type	 commander_body_drop,@function
commander_body_drop:
	lis 9,.LC210@ha
	lfs 0,12(3)
	li 0,7
	la 9,.LC210@l(9)
	stw 0,260(3)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,12(3)
	blr
.Lfe63:
	.size	 commander_body_drop,.Lfe63-commander_body_drop
	.section	".rodata"
	.align 3
.LC211:
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
	lis 9,.LC106@ha
	mr 29,3
	la 9,.LC106@l(9)
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
	stw 7,512(29)
	stw 8,264(29)
	stw 5,188(29)
	stw 6,200(29)
	stw 3,40(29)
	stw 9,448(29)
	mr 3,29
	lwz 9,72(28)
	mtlr 9
	blrl
	lwz 9,36(28)
	lis 3,.LC103@ha
	la 3,.LC103@l(3)
	mtlr 9
	blrl
	lwz 0,36(28)
	lis 3,.LC105@ha
	la 3,.LC105@l(3)
	mtlr 0
	blrl
	lis 9,commander_body_drop@ha
	lis 11,level+4@ha
	la 9,commander_body_drop@l(9)
	lis 10,.LC211@ha
	stw 9,436(29)
	la 10,.LC211@l(10)
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
.Lfe64:
	.size	 SP_monster_commander_body,.Lfe64-SP_monster_commander_body
	.section	".rodata"
	.align 3
.LC212:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_banner_think
	.type	 misc_banner_think,@function
misc_banner_think:
	lwz 9,56(3)
	lis 10,level+4@ha
	lis 11,.LC212@ha
	lfd 13,.LC212@l(11)
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
.Lfe65:
	.size	 misc_banner_think,.Lfe65-misc_banner_think
	.section	".rodata"
	.align 3
.LC213:
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
	lis 3,.LC62@ha
	stw 0,260(29)
	la 28,gi@l(28)
	la 3,.LC62@l(3)
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
	lis 11,.LC213@ha
	stw 9,436(29)
	lfs 0,level+4@l(10)
	lfd 13,.LC213@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe66:
	.size	 SP_misc_banner,.Lfe66-SP_misc_banner
	.section	".rodata"
	.align 2
.LC214:
	.long 0x3f800000
	.align 2
.LC215:
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
	lwz 9,480(31)
	lwz 0,488(31)
	cmpw 0,9,0
	bc 12,1,.L245
	lis 29,gi@ha
	lis 3,.LC109@ha
	la 29,gi@l(29)
	la 3,.LC109@l(3)
	lwz 9,36(29)
	lis 27,.LC22@ha
	li 30,4
	mtlr 9
	blrl
	lis 9,.LC214@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC214@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC214@ha
	la 9,.LC214@l(9)
	lfs 2,0(9)
	lis 9,.LC215@ha
	la 9,.LC215@l(9)
	lfs 3,0(9)
	blrl
.L250:
	mr 3,31
	la 4,.LC22@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L250
	lis 4,.LC35@ha
	mr 3,31
	la 4,.LC35@l(4)
	mr 5,28
	li 6,0
	bl ThrowHead
.L245:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe67:
	.size	 misc_deadsoldier_die,.Lfe67-misc_deadsoldier_die
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
.Lfe68:
	.size	 misc_viper_use,.Lfe68-misc_viper_use
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
	lis 3,.LC116@ha
	stw 8,200(29)
	la 3,.LC116@l(3)
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
.Lfe69:
	.size	 SP_misc_bigviper,.Lfe69-SP_misc_bigviper
	.section	".rodata"
	.align 3
.LC216:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC217:
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
	lwz 4,548(28)
	addi 27,28,4
	bl G_UseTargets
	lwz 9,516(28)
	lis 8,0x4330
	mr 11,10
	lis 7,.LC216@ha
	lfs 12,220(28)
	xoris 0,9,0x8000
	la 7,.LC216@l(7)
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
	lis 7,.LC217@ha
	lfd 2,16(1)
	la 7,.LC217@l(7)
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
.Lfe70:
	.size	 misc_viper_bomb_touch,.Lfe70-misc_viper_bomb_touch
	.section	".rodata"
	.align 3
.LC218:
	.long 0xbff00000
	.long 0x0
	.align 2
.LC219:
	.long 0xbf800000
	.align 3
.LC220:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC221:
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
	lis 11,.LC218@ha
	lfs 12,level+4@l(9)
	la 11,.LC218@l(11)
	lfs 13,288(31)
	lfd 11,0(11)
	fsubs 31,13,12
	fmr 0,31
	fcmpu 0,0,11
	bc 4,0,.L272
	lis 9,.LC219@ha
	la 9,.LC219@l(9)
	lfs 31,0(9)
.L272:
	lis 11,.LC220@ha
	fmr 1,31
	addi 4,1,8
	la 11,.LC220@l(11)
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
	lis 9,.LC221@ha
	la 9,.LC221@l(9)
	lfs 0,0(9)
	fadds 0,31,0
	stfs 0,24(31)
	lwz 0,52(1)
	mtlr 0
	lwz 31,36(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe71:
	.size	 misc_viper_bomb_prethink,.Lfe71-misc_viper_bomb_prethink
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
	lis 5,.LC117@ha
	stw 9,64(29)
	li 4,280
	stw 0,184(29)
	la 5,.LC117@l(5)
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
.Lfe72:
	.size	 misc_viper_bomb_use,.Lfe72-misc_viper_bomb_use
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
	lis 3,.LC118@ha
	stw 0,192(31)
	la 30,gi@l(9)
	la 3,.LC118@l(3)
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
	bc 4,2,.L275
	li 0,1000
	stw 0,516(31)
.L275:
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
.Lfe73:
	.size	 SP_misc_viper_bomb,.Lfe73-SP_misc_viper_bomb
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
.Lfe74:
	.size	 misc_strogg_ship_use,.Lfe74-misc_strogg_ship_use
	.section	".rodata"
	.align 3
.LC222:
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
	lis 11,.LC222@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC222@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe75:
	.size	 misc_satellite_dish_think,.Lfe75-misc_satellite_dish_think
	.section	".rodata"
	.align 3
.LC223:
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
	lis 10,.LC223@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC223@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe76:
	.size	 misc_satellite_dish_use,.Lfe76-misc_satellite_dish_use
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
	lis 3,.LC125@ha
	stw 7,204(29)
	la 3,.LC125@l(3)
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
.Lfe77:
	.size	 SP_misc_satellite_dish,.Lfe77-SP_misc_satellite_dish
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
	lis 3,.LC126@ha
	lwz 9,32(29)
	la 3,.LC126@l(3)
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
.Lfe78:
	.size	 SP_light_mine1,.Lfe78-SP_light_mine1
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
	lis 3,.LC127@ha
	lwz 9,32(29)
	la 3,.LC127@l(3)
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
.Lfe79:
	.size	 SP_light_mine2,.Lfe79-SP_light_mine2
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
.Lfe80:
	.size	 SP_target_character,.Lfe80-SP_target_character
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
	bc 12,2,.L292
	li 8,12
	li 6,10
	li 7,11
.L294:
	lwz 9,532(10)
	cmpwi 0,9,0
	bc 12,2,.L293
	addi 11,9,-1
	cmpw 0,11,3
	bc 12,1,.L301
	lwz 9,276(31)
	lbzx 9,9,11
	addi 11,9,-48
	rlwinm 0,11,0,0xff
	cmplwi 0,0,9
	bc 12,1,.L297
	stw 11,56(10)
	b .L293
.L297:
	cmpwi 0,9,45
	bc 4,2,.L299
	stw 6,56(10)
	b .L293
.L299:
	cmpwi 0,9,58
	bc 4,2,.L301
	stw 7,56(10)
	b .L293
.L301:
	stw 8,56(10)
.L293:
	lwz 10,560(10)
	cmpwi 0,10,0
	bc 4,2,.L294
.L292:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe81:
	.size	 target_string_use,.Lfe81-target_string_use
	.align 2
	.globl SP_target_string
	.type	 SP_target_string,@function
SP_target_string:
	lwz 0,276(3)
	cmpwi 0,0,0
	bc 4,2,.L305
	lis 9,.LC143@ha
	la 9,.LC143@l(9)
	stw 9,276(3)
.L305:
	lis 9,target_string_use@ha
	la 9,target_string_use@l(9)
	stw 9,448(3)
	blr
.Lfe82:
	.size	 SP_target_string,.Lfe82-SP_target_string
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
	bc 4,2,.L337
	stw 0,448(9)
.L337:
	lwz 0,548(9)
	cmpwi 0,0,0
	bc 4,2,.L336
	lwz 11,436(9)
	mr 3,9
	stw 5,548(9)
	mtlr 11
	blrl
.L336:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe83:
	.size	 func_clock_use,.Lfe83-func_clock_use
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
	lis 4,.LC158@ha
	lwz 9,44(28)
	la 4,.LC158@l(4)
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
.Lfe84:
	.size	 SP_misc_teleporter_dest,.Lfe84-SP_misc_teleporter_dest
	.align 2
	.type	 bloodtrail_touch,@function
bloodtrail_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe85:
	.size	 bloodtrail_touch,.Lfe85-bloodtrail_touch
	.section	".rodata"
	.align 3
.LC224:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC225:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl bloodthink
	.type	 bloodthink,@function
bloodthink:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,.LC225@ha
	mr 29,3
	la 9,.LC225@l(9)
	lfs 0,12(29)
	addi 3,29,4
	lfs 11,0(9)
	addi 4,1,8
	lfs 13,8(29)
	lfs 12,4(29)
	fsubs 0,0,11
	stfs 13,12(1)
	stfs 12,8(1)
	stfs 0,16(1)
	bl BloodTrail
	lis 9,level+4@ha
	lis 11,.LC224@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC224@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe86:
	.size	 bloodthink,.Lfe86-bloodthink
	.section	".rodata"
	.align 3
.LC226:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_blood
	.type	 SP_misc_blood,@function
SP_misc_blood:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	li 11,2048
	lwz 0,64(9)
	lis 10,bloodthink@ha
	li 6,0
	stw 11,264(9)
	li 5,0
	la 10,bloodthink@l(10)
	ori 0,0,2
	lis 8,0x4348
	stw 6,260(9)
	stw 5,380(9)
	lis 11,level+4@ha
	lis 7,.LC226@ha
	stw 8,384(9)
	lis 4,gi+72@ha
	stw 0,64(9)
	stw 10,436(9)
	stw 6,248(9)
	stw 5,376(9)
	lfs 0,level+4@l(11)
	lfd 13,.LC226@l(7)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(9)
	lwz 0,gi+72@l(4)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe87:
	.size	 SP_misc_blood,.Lfe87-SP_misc_blood
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
	bc 12,2,.L145
	lis 9,gi+24@ha
	lwz 3,644(31)
	lis 4,.LC63@ha
	lwz 0,gi+24@l(9)
	la 4,.LC63@l(4)
	addi 3,3,800
	mtlr 0
	blrl
	lwz 0,284(31)
	rlwinm 0,0,0,0,30
	b .L372
.L145:
	lis 9,gi+24@ha
	lwz 3,644(31)
	lis 4,.LC64@ha
	lwz 0,gi+24@l(9)
	la 4,.LC64@l(4)
	addi 3,3,800
	mtlr 0
	blrl
	lwz 0,284(31)
	ori 0,0,1
.L372:
	stw 0,284(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe88:
	.size	 light_use,.Lfe88-light_use
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
