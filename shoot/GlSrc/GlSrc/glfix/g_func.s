	.file	"g_func.c"
gcc2_compiled.:
	.section	".rodata"
	.align 3
.LC1:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC2:
	.long 0x0
	.section	".text"
	.align 2
	.globl Move_Begin
	.type	 Move_Begin,@function
Move_Begin:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stw 31,20(1)
	stw 0,36(1)
	mr 31,3
	lis 9,.LC1@ha
	lfs 13,812(31)
	lfs 12,856(31)
	lfd 31,.LC1@l(9)
	fmr 0,13
	fmr 1,12
	fmul 0,0,31
	fcmpu 0,0,1
	cror 3,2,1
	bc 4,3,.L11
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	lfs 0,0(9)
	fcmpu 0,12,0
	bc 4,2,.L12
	lwz 9,864(31)
	stfs 0,472(31)
	mtlr 9
	stfs 0,480(31)
	stfs 0,476(31)
	blrl
	b .L10
.L12:
	fdiv 1,1,31
	addi 3,31,832
	addi 4,31,472
	frsp 1,1
	bl VectorScale
	lis 9,Move_Done@ha
	lis 11,level+4@ha
	la 9,Move_Done@l(9)
	stw 9,532(31)
	lfs 0,level+4@l(11)
	fadd 0,0,31
	frsp 0,0
	stfs 0,524(31)
	b .L10
.L11:
	fmr 1,13
	addi 3,31,832
	addi 4,31,472
	bl VectorScale
	lfs 0,812(31)
	lfs 1,856(31)
	fdivs 1,1,0
	fdiv 1,1,31
	bl floor
	frsp 1,1
	lfs 13,812(31)
	lis 11,level+4@ha
	lis 9,Move_Final@ha
	lfs 0,856(31)
	la 9,Move_Final@l(9)
	fmuls 13,1,13
	fmul 13,13,31
	fsub 0,0,13
	frsp 0,0
	stfs 0,856(31)
	lfs 13,level+4@l(11)
	stw 9,532(31)
	fmadd 1,1,31,13
	frsp 1,1
	stfs 1,524(31)
.L10:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Move_Begin,.Lfe1-Move_Begin
	.section	".rodata"
	.align 3
.LC5:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC6:
	.long 0x41200000
	.align 3
.LC7:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl AngleMove_Begin
	.type	 AngleMove_Begin,@function
AngleMove_Begin:
	stwu 1,-80(1)
	mflr 0
	stfd 29,56(1)
	stfd 30,64(1)
	stfd 31,72(1)
	stw 31,52(1)
	stw 0,84(1)
	mr 31,3
	lwz 0,828(31)
	cmpwi 0,0,2
	bc 4,2,.L29
	lfs 11,16(31)
	lfs 13,784(31)
	lfs 12,788(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,792(31)
	b .L37
.L29:
	lfs 11,16(31)
	lfs 13,760(31)
	lfs 12,764(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,768(31)
.L37:
	lfs 11,24(31)
	fsubs 12,12,10
	stfs 13,8(1)
	fsubs 0,0,11
	stfs 12,12(1)
	stfs 0,16(1)
	addi 3,1,8
	bl VectorLength
	lfs 0,812(31)
	lis 9,.LC5@ha
	lfd 29,.LC5@l(9)
	fdivs 1,1,0
	fmr 30,1
	fcmpu 0,30,29
	bc 4,0,.L31
	lwz 0,828(31)
	cmpwi 0,0,2
	bc 4,2,.L32
	lfs 11,16(31)
	lfs 13,784(31)
	lfs 12,788(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,792(31)
	b .L38
.L32:
	lfs 11,16(31)
	lfs 13,760(31)
	lfs 12,764(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,768(31)
.L38:
	lfs 11,24(31)
	fsubs 12,12,10
	stfs 13,24(1)
	fsubs 0,0,11
	stfs 12,28(1)
	stfs 0,32(1)
	lis 4,vec3_origin@ha
	addi 3,1,24
	la 4,vec3_origin@l(4)
	bl VectorCompare
	cmpwi 0,3,0
	bc 12,2,.L34
	lwz 9,864(31)
	mr 3,31
	li 0,0
	stw 0,484(31)
	mtlr 9
	stw 0,492(31)
	stw 0,488(31)
	blrl
	b .L28
.L34:
	lis 9,.LC6@ha
	addi 3,1,24
	la 9,.LC6@l(9)
	addi 4,31,484
	lfs 1,0(9)
	bl VectorScale
	lis 9,AngleMove_Done@ha
	lis 10,level+4@ha
	la 9,AngleMove_Done@l(9)
	lis 11,.LC5@ha
	stw 9,532(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC5@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
	b .L28
.L31:
	fdiv 1,30,29
	bl floor
	lis 9,.LC7@ha
	frsp 31,1
	addi 3,1,8
	la 9,.LC7@l(9)
	addi 4,31,484
	lfd 0,0(9)
	fdiv 0,0,30
	frsp 1,0
	bl VectorScale
	lis 11,level+4@ha
	lis 9,AngleMove_Final@ha
	lfs 0,level+4@l(11)
	la 9,AngleMove_Final@l(9)
	stw 9,532(31)
	fmadd 31,31,29,0
	frsp 31,31
	stfs 31,524(31)
.L28:
	lwz 0,84(1)
	mtlr 0
	lwz 31,52(1)
	lfd 29,56(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe2:
	.size	 AngleMove_Begin,.Lfe2-AngleMove_Begin
	.section	".rodata"
	.align 2
.LC9:
	.long 0x0
	.align 3
.LC10:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC11:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl plat_Accelerate
	.type	 plat_Accelerate,@function
plat_Accelerate:
	lfs 13,108(3)
	lfs 10,112(3)
	fcmpu 0,13,10
	cror 3,2,0
	bc 4,3,.L48
	bclr 4,0
	lis 9,.LC9@ha
	lfs 0,104(3)
	la 9,.LC9@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L50
	stfs 13,104(3)
	stfs 0,96(3)
	blr
.L50:
	lfs 13,96(3)
	lfs 0,68(3)
	fcmpu 0,13,0
	bclr 4,1
	fsubs 0,13,0
	stfs 0,96(3)
	blr
.L48:
	lfs 0,96(3)
	lfs 9,100(3)
	fmr 12,0
	fcmpu 0,0,9
	bc 4,2,.L52
	fsubs 0,13,12
	fcmpu 0,0,10
	bc 4,0,.L52
	fsubs 10,13,10
	lis 9,.LC10@ha
	lfs 11,68(3)
	la 9,.LC10@l(9)
	fmr 13,9
	stfs 9,96(3)
	lfd 12,0(9)
	fdivs 0,10,9
	fsub 12,12,0
	fmul 13,13,12
	frsp 13,13
	fadds 10,10,13
	fdivs 13,13,10
	fmuls 11,11,13
	fsubs 11,9,11
	stfs 11,104(3)
	blr
.L52:
	lfs 13,64(3)
	fcmpu 0,12,13
	bclr 4,0
	lfs 0,60(3)
	fadds 0,12,0
	fcmpu 0,0,13
	stfs 0,96(3)
	bc 4,1,.L55
	stfs 13,96(3)
.L55:
	lfs 13,108(3)
	lfs 0,96(3)
	lfs 9,112(3)
	fsubs 0,13,0
	fcmpu 0,0,9
	cror 3,2,1
	bclr 12,3
	lfs 10,100(3)
	lis 9,.LC11@ha
	fsubs 9,13,9
	la 9,.LC11@l(9)
	lfs 8,68(3)
	lfd 0,0(9)
	fadds 12,12,10
	lis 9,.LC10@ha
	la 9,.LC10@l(9)
	fmr 13,10
	lfd 11,0(9)
	fmul 12,12,0
	frsp 12,12
	fdivs 0,9,12
	fsub 11,11,0
	fmul 13,13,11
	frsp 13,13
	fadds 0,9,13
	fdivs 13,13,0
	fdivs 9,9,0
	fmuls 8,8,13
	fmuls 13,10,13
	fsubs 10,10,8
	fmadds 12,12,9,13
	stfs 10,104(3)
	stfs 12,96(3)
	blr
.Lfe3:
	.size	 plat_Accelerate,.Lfe3-plat_Accelerate
	.section	".rodata"
	.align 3
.LC12:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC13:
	.long 0x0
	.align 2
.LC14:
	.long 0x3f000000
	.align 2
.LC15:
	.long 0x3f800000
	.align 2
.LC16:
	.long 0x40800000
	.align 2
.LC17:
	.long 0xc0000000
	.align 3
.LC18:
	.long 0xc0000000
	.long 0x0
	.align 2
.LC19:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl Think_AccelMove
	.type	 Think_AccelMove,@function
Think_AccelMove:
	stwu 1,-48(1)
	mflr 0
	stfd 29,24(1)
	stfd 30,32(1)
	stfd 31,40(1)
	stmw 30,16(1)
	stw 0,52(1)
	lis 9,.LC13@ha
	mr 31,3
	la 9,.LC13@l(9)
	lfs 13,844(31)
	lfs 9,0(9)
	lfs 0,856(31)
	fcmpu 0,13,9
	fsubs 0,0,13
	stfs 0,856(31)
	bc 4,2,.L58
	addi 30,31,748
	lfs 10,108(30)
	lfs 11,60(30)
	lfs 12,64(30)
	fcmpu 0,10,11
	stfs 12,100(30)
	bc 4,0,.L59
	stfs 10,96(30)
	b .L58
.L59:
	fdivs 0,12,11
	lfs 31,68(30)
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 30,0(9)
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 29,0(9)
	fdivs 13,12,31
	fmadds 0,0,12,12
	fmadds 13,13,12,12
	fmuls 0,0,30
	fmuls 1,13,30
	fsubs 0,10,0
	fsubs 0,0,1
	fcmpu 0,0,9
	bc 4,0,.L61
	fmuls 12,11,31
	lis 9,.LC16@ha
	fadds 31,11,31
	la 9,.LC16@l(9)
	lfs 1,0(9)
	lis 9,.LC17@ha
	fdivs 31,31,12
	la 9,.LC17@l(9)
	lfs 13,0(9)
	fmuls 0,31,1
	fmuls 13,10,13
	fmuls 0,0,13
	fsubs 1,1,0
	bl sqrt
	lis 9,.LC18@ha
	fadds 31,31,31
	lfs 13,68(30)
	la 9,.LC18@l(9)
	lfd 0,0(9)
	fadd 1,1,0
	fdiv 1,1,31
	frsp 1,1
	fdivs 13,1,13
	stfs 1,100(30)
	fadds 13,13,29
	fmuls 1,1,13
	fmuls 1,1,30
.L61:
	stfs 1,112(30)
.L58:
	addi 3,31,748
	bl plat_Accelerate
	lfs 1,856(31)
	lfs 0,844(31)
	fcmpu 0,1,0
	cror 3,2,0
	bc 4,3,.L62
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,2,.L63
	lwz 9,864(31)
	mr 3,31
	stfs 0,472(31)
	mtlr 9
	stfs 0,480(31)
	stfs 0,476(31)
	blrl
	b .L57
.L63:
	lis 9,.LC12@ha
	addi 3,31,832
	lfd 31,.LC12@l(9)
	addi 4,31,472
	fdiv 1,1,31
	frsp 1,1
	bl VectorScale
	lis 9,Move_Done@ha
	lis 11,level+4@ha
	la 9,Move_Done@l(9)
	stw 9,532(31)
	lfs 0,level+4@l(11)
	fadd 0,0,31
	b .L66
.L62:
	lis 9,.LC19@ha
	addi 3,31,832
	la 9,.LC19@l(9)
	addi 4,31,472
	lfs 1,0(9)
	fmuls 1,0,1
	bl VectorScale
	lis 11,level+4@ha
	lis 10,.LC12@ha
	lfs 0,level+4@l(11)
	lis 9,Think_AccelMove@ha
	lfd 13,.LC12@l(10)
	la 9,Think_AccelMove@l(9)
	stw 9,532(31)
	fadd 0,0,13
.L66:
	frsp 0,0
	stfs 0,524(31)
.L57:
	lwz 0,52(1)
	mtlr 0
	lmw 30,16(1)
	lfd 29,24(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 Think_AccelMove,.Lfe4-Think_AccelMove
	.section	".rodata"
	.align 3
.LC20:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC21:
	.long 0x3f800000
	.align 2
.LC22:
	.long 0x40400000
	.align 2
.LC23:
	.long 0x0
	.section	".text"
	.align 2
	.globl plat_go_down
	.type	 plat_go_down,@function
plat_go_down:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,264(31)
	andi. 9,0,1024
	bc 4,2,.L74
	lwz 5,796(31)
	cmpwi 0,5,0
	bc 12,2,.L75
	lis 11,.LC21@ha
	lis 9,gi+16@ha
	la 11,.LC21@l(11)
	lwz 0,gi+16@l(9)
	lfs 1,0(11)
	lis 9,.LC22@ha
	li 4,10
	lis 11,.LC23@ha
	la 9,.LC22@l(9)
	mtlr 0
	la 11,.LC23@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L75:
	lwz 0,800(31)
	stw 0,76(31)
.L74:
	lfs 13,4(31)
	li 0,0
	li 9,3
	lfs 0,772(31)
	addi 11,31,772
	lis 29,plat_hit_bottom@ha
	stw 9,828(31)
	la 29,plat_hit_bottom@l(29)
	addi 3,31,832
	stw 0,472(31)
	fsubs 0,0,13
	stw 0,480(31)
	stw 0,476(31)
	lfs 12,12(31)
	stfs 0,832(31)
	lfs 13,4(11)
	lfs 0,8(31)
	fsubs 13,13,0
	stfs 13,836(31)
	lfs 0,8(11)
	fsubs 0,0,12
	stfs 0,840(31)
	bl VectorNormalize
	lfs 13,812(31)
	lfs 0,808(31)
	stfs 1,856(31)
	stw 29,864(31)
	fcmpu 0,13,0
	bc 4,2,.L76
	lfs 0,816(31)
	fcmpu 0,13,0
	bc 4,2,.L76
	lwz 0,264(31)
	lis 9,level+312@ha
	lwz 9,level+312@l(9)
	andi. 11,0,1024
	bc 12,2,.L77
	lwz 0,660(31)
	cmpw 0,9,0
	bc 12,2,.L78
	b .L79
.L77:
	cmpw 0,9,31
	bc 4,2,.L79
.L78:
	mr 3,31
	bl Move_Begin
	b .L82
.L79:
	lis 11,level+4@ha
	lis 10,.LC20@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC20@l(10)
	la 9,Move_Begin@l(9)
	stw 9,532(31)
	b .L83
.L76:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,844(31)
	lis 10,level+4@ha
	stw 9,532(31)
	lis 11,.LC20@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC20@l(11)
.L83:
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
.L82:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 plat_go_down,.Lfe5-plat_go_down
	.section	".rodata"
	.align 3
.LC24:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC25:
	.long 0x3f800000
	.align 2
.LC26:
	.long 0x40400000
	.align 2
.LC27:
	.long 0x0
	.section	".text"
	.align 2
	.globl plat_go_up
	.type	 plat_go_up,@function
plat_go_up:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,264(31)
	andi. 9,0,1024
	bc 4,2,.L85
	lwz 5,796(31)
	cmpwi 0,5,0
	bc 12,2,.L86
	lis 11,.LC25@ha
	lis 9,gi+16@ha
	la 11,.LC25@l(11)
	lwz 0,gi+16@l(9)
	lfs 1,0(11)
	lis 9,.LC26@ha
	li 4,10
	lis 11,.LC27@ha
	la 9,.LC26@l(9)
	mtlr 0
	la 11,.LC27@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L86:
	lwz 0,800(31)
	stw 0,76(31)
.L85:
	lfs 13,4(31)
	li 0,0
	li 9,2
	lfs 0,748(31)
	addi 11,31,748
	lis 29,plat_hit_top@ha
	stw 9,828(31)
	la 29,plat_hit_top@l(29)
	addi 3,31,832
	stw 0,472(31)
	fsubs 0,0,13
	stw 0,480(31)
	stw 0,476(31)
	lfs 12,12(31)
	stfs 0,832(31)
	lfs 13,4(11)
	lfs 0,8(31)
	fsubs 13,13,0
	stfs 13,836(31)
	lfs 0,8(11)
	fsubs 0,0,12
	stfs 0,840(31)
	bl VectorNormalize
	lfs 13,812(31)
	lfs 0,808(31)
	stfs 1,856(31)
	stw 29,864(31)
	fcmpu 0,13,0
	bc 4,2,.L87
	lfs 0,816(31)
	fcmpu 0,13,0
	bc 4,2,.L87
	lwz 0,264(31)
	lis 9,level+312@ha
	lwz 9,level+312@l(9)
	andi. 11,0,1024
	bc 12,2,.L88
	lwz 0,660(31)
	cmpw 0,9,0
	bc 12,2,.L89
	b .L90
.L88:
	cmpw 0,9,31
	bc 4,2,.L90
.L89:
	mr 3,31
	bl Move_Begin
	b .L93
.L90:
	lis 11,level+4@ha
	lis 10,.LC24@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC24@l(10)
	la 9,Move_Begin@l(9)
	stw 9,532(31)
	b .L94
.L87:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,844(31)
	lis 10,level+4@ha
	stw 9,532(31)
	lis 11,.LC24@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC24@l(11)
.L94:
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
.L93:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 plat_go_up,.Lfe6-plat_go_up
	.section	".rodata"
	.align 2
.LC28:
	.long 0x41000000
	.align 3
.LC29:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC30:
	.long 0x41c80000
	.align 2
.LC31:
	.long 0x0
	.align 3
.LC32:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC33:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl plat_spawn_inside_trigger
	.type	 plat_spawn_inside_trigger,@function
plat_spawn_inside_trigger:
	stwu 1,-64(1)
	mflr 0
	stw 31,60(1)
	stw 0,68(1)
	mr 31,3
	bl G_Spawn
	lis 9,.LC28@ha
	mr 7,3
	la 9,.LC28@l(9)
	li 0,0
	stw 31,636(7)
	lfs 6,0(9)
	li 11,1
	lis 10,st+24@ha
	lis 9,Touch_Plat_Center@ha
	stw 11,248(7)
	lis 8,0x4330
	la 9,Touch_Plat_Center@l(9)
	stw 0,260(7)
	lis 11,.LC29@ha
	stw 9,540(7)
	la 11,.LC29@l(11)
	lwz 0,st+24@l(10)
	lfd 10,0(11)
	xoris 0,0,0x8000
	lfs 13,468(31)
	lis 11,.LC30@ha
	stw 0,52(1)
	la 11,.LC30@l(11)
	stw 8,48(1)
	lfd 0,48(1)
	lfs 8,456(31)
	lfs 9,208(31)
	fsub 0,0,10
	lfs 12,188(31)
	fsubs 8,8,13
	lfs 11,192(31)
	lfs 10,200(31)
	fadds 9,9,6
	frsp 0,0
	lfs 13,204(31)
	lfs 7,0(11)
	lwz 0,284(31)
	fadds 8,8,0
	stfs 9,32(1)
	fadds 12,12,7
	andi. 9,0,1
	fsubs 13,13,7
	fadds 11,11,7
	fsubs 10,10,7
	stfs 12,8(1)
	fsubs 0,9,8
	stfs 13,28(1)
	stfs 11,12(1)
	stfs 10,24(1)
	stfs 0,16(1)
	bc 12,2,.L110
	fadds 0,0,6
	stfs 0,32(1)
.L110:
	lfs 0,24(1)
	lis 11,.LC31@ha
	lfs 13,8(1)
	la 11,.LC31@l(11)
	lfs 10,0(11)
	fsubs 0,0,13
	fcmpu 0,0,10
	cror 3,2,0
	bc 4,3,.L111
	lfs 0,188(31)
	lis 9,.LC32@ha
	lis 11,.LC33@ha
	lfs 13,200(31)
	la 9,.LC32@l(9)
	la 11,.LC33@l(11)
	lfd 11,0(9)
	lfs 12,0(11)
	fadds 0,0,13
	fmul 0,0,11
	frsp 0,0
	fadds 12,0,12
	stfs 0,8(1)
	stfs 12,24(1)
.L111:
	lfs 0,28(1)
	lfs 13,12(1)
	fsubs 0,0,13
	fcmpu 0,0,10
	cror 3,2,0
	bc 4,3,.L112
	lfs 11,204(31)
	lis 9,.LC32@ha
	lis 11,.LC33@ha
	lfs 0,192(31)
	la 9,.LC32@l(9)
	la 11,.LC33@l(11)
	lfd 12,0(9)
	lfs 13,0(11)
	fadds 0,0,11
	fmul 0,0,12
	frsp 0,0
	fadds 13,0,13
	stfs 0,12(1)
	stfs 13,28(1)
.L112:
	lfs 13,8(1)
	lis 9,gi+72@ha
	mr 3,7
	stfs 13,188(7)
	lfs 0,12(1)
	stfs 0,192(7)
	lfs 13,16(1)
	stfs 13,196(7)
	lfs 0,24(1)
	stfs 0,200(7)
	lfs 13,28(1)
	stfs 13,204(7)
	lfs 0,32(1)
	stfs 0,208(7)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,68(1)
	mtlr 0
	lwz 31,60(1)
	la 1,64(1)
	blr
.Lfe7:
	.size	 plat_spawn_inside_trigger,.Lfe7-plat_spawn_inside_trigger
	.section	".rodata"
	.align 2
.LC35:
	.string	"plats/pt1_strt.wav"
	.align 2
.LC36:
	.string	"plats/pt1_mid.wav"
	.align 2
.LC37:
	.string	"plats/pt1_end.wav"
	.align 3
.LC34:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC38:
	.long 0x0
	.align 3
.LC39:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SP_func_plat
	.type	 SP_func_plat,@function
SP_func_plat:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	lis 9,.LC38@ha
	mr 31,3
	la 9,.LC38@l(9)
	li 0,3
	lwz 4,268(31)
	lfs 31,0(9)
	lis 11,gi+44@ha
	li 9,2
	stw 0,248(31)
	stw 9,260(31)
	stfs 31,24(31)
	stfs 31,20(31)
	stfs 31,16(31)
	lwz 0,gi+44@l(11)
	mtlr 0
	blrl
	lfs 0,424(31)
	lis 9,plat_blocked@ha
	la 9,plat_blocked@l(9)
	stw 9,536(31)
	fcmpu 0,0,31
	bc 4,2,.L114
	lis 0,0x41a0
	stw 0,424(31)
	b .L115
.L114:
	lis 9,.LC34@ha
	lfd 13,.LC34@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,424(31)
.L115:
	lis 9,.LC38@ha
	lfs 13,428(31)
	la 9,.LC38@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L116
	lis 0,0x40a0
	stw 0,428(31)
	b .L117
.L116:
	fmr 0,13
	lis 9,.LC34@ha
	lfd 13,.LC34@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L117:
	lis 10,.LC38@ha
	lfs 13,432(31)
	la 10,.LC38@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,2,.L118
	lis 0,0x40a0
	stw 0,432(31)
	b .L119
.L118:
	fmr 0,13
	lis 9,.LC34@ha
	lfd 13,.LC34@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,432(31)
.L119:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L120
	li 0,2
	stw 0,612(31)
.L120:
	lis 9,st@ha
	la 9,st@l(9)
	lwz 0,24(9)
	cmpwi 0,0,0
	bc 4,2,.L121
	li 0,8
	stw 0,24(9)
.L121:
	lfs 0,4(31)
	lfs 13,8(31)
	lfs 10,12(31)
	stfs 0,460(31)
	stfs 13,464(31)
	stfs 0,448(31)
	stfs 13,452(31)
	stfs 10,456(31)
	stfs 10,468(31)
	lwz 0,32(9)
	cmpwi 0,0,0
	bc 12,2,.L122
	xoris 0,0,0x8000
	stw 0,20(1)
	lis 11,0x4330
	lis 10,.LC39@ha
	la 10,.LC39@l(10)
	stw 11,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fsubs 0,10,0
	stfs 0,468(31)
	b .L123
.L122:
	lwz 0,24(9)
	lis 11,0x4330
	lis 10,.LC39@ha
	la 10,.LC39@l(10)
	lfs 13,208(31)
	xoris 0,0,0x8000
	lfd 11,0(10)
	stw 0,20(1)
	stw 11,16(1)
	lfd 0,16(1)
	lfs 12,196(31)
	fsub 0,0,11
	fsubs 13,13,12
	frsp 0,0
	fsubs 13,13,0
	fsubs 13,10,13
	stfs 13,468(31)
.L123:
	lis 9,Use_Plat@ha
	mr 3,31
	la 9,Use_Plat@l(9)
	stw 9,544(31)
	bl plat_spawn_inside_trigger
	lwz 0,396(31)
	cmpwi 0,0,0
	bc 12,2,.L124
	li 0,2
	b .L126
.L124:
	lfs 12,460(31)
	lis 9,gi+72@ha
	mr 3,31
	lfs 0,464(31)
	lfs 13,468(31)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	li 0,1
.L126:
	stw 0,828(31)
	lfs 2,16(31)
	lis 29,gi@ha
	lis 3,.LC35@ha
	lfs 3,20(31)
	la 29,gi@l(29)
	la 3,.LC35@l(3)
	lfs 4,24(31)
	lfs 0,424(31)
	lfs 13,428(31)
	lfs 12,432(31)
	lfs 11,688(31)
	lfs 10,448(31)
	lfs 9,452(31)
	lfs 8,456(31)
	lfs 7,460(31)
	lfs 6,464(31)
	lfs 5,468(31)
	stfs 0,812(31)
	stfs 13,808(31)
	stfs 12,816(31)
	stfs 11,824(31)
	stfs 10,748(31)
	stfs 9,752(31)
	stfs 8,756(31)
	stfs 7,772(31)
	stfs 6,776(31)
	stfs 5,780(31)
	stfs 2,784(31)
	stfs 3,788(31)
	stfs 4,792(31)
	stfs 2,760(31)
	stfs 3,764(31)
	stfs 4,768(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,796(31)
	lwz 9,36(29)
	lis 3,.LC36@ha
	la 3,.LC36@l(3)
	mtlr 9
	blrl
	stw 3,800(31)
	lwz 0,36(29)
	lis 3,.LC37@ha
	la 3,.LC37@l(3)
	mtlr 0
	blrl
	stw 3,804(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 SP_func_plat,.Lfe8-SP_func_plat
	.section	".rodata"
	.align 2
.LC40:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_func_rotating
	.type	 SP_func_rotating,@function
SP_func_rotating:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	li 9,3
	lwz 0,284(31)
	stw 9,248(31)
	andi. 11,0,32
	bc 12,2,.L136
	stw 9,260(31)
	b .L137
.L136:
	li 0,2
	stw 0,260(31)
.L137:
	lwz 9,284(31)
	li 0,0
	stw 0,436(31)
	andi. 11,9,4
	stw 0,444(31)
	stw 0,440(31)
	bc 12,2,.L138
	lis 0,0x3f80
	stw 0,444(31)
	b .L139
.L138:
	andi. 0,9,8
	bc 12,2,.L140
	lis 0,0x3f80
	stw 0,436(31)
	b .L139
.L140:
	lis 0,0x3f80
	stw 0,440(31)
.L139:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L142
	lfs 0,436(31)
	lfs 13,440(31)
	lfs 12,444(31)
	fneg 0,0
	fneg 13,13
	fneg 12,12
	stfs 0,436(31)
	stfs 13,440(31)
	stfs 12,444(31)
.L142:
	lis 11,.LC40@ha
	lfs 13,424(31)
	la 11,.LC40@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L143
	lis 0,0x42c8
	stw 0,424(31)
.L143:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L144
	li 0,2
	stw 0,612(31)
.L144:
	lwz 0,612(31)
	lis 9,rotating_use@ha
	la 9,rotating_use@l(9)
	cmpwi 0,0,0
	stw 9,544(31)
	bc 12,2,.L145
	lis 9,rotating_blocked@ha
	la 9,rotating_blocked@l(9)
	stw 9,536(31)
.L145:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L146
	lwz 9,544(31)
	mr 3,31
	li 4,0
	li 5,0
	mtlr 9
	blrl
.L146:
	lwz 0,284(31)
	andi. 9,0,64
	bc 12,2,.L147
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L147:
	lwz 0,284(31)
	andi. 11,0,128
	bc 12,2,.L148
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L148:
	lis 29,gi@ha
	mr 3,31
	lwz 4,268(31)
	la 29,gi@l(29)
	lwz 9,44(29)
	mtlr 9
	blrl
	lwz 0,72(29)
	mr 3,31
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 SP_func_rotating,.Lfe9-SP_func_rotating
	.section	".rodata"
	.align 3
.LC41:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl button_return
	.type	 button_return,@function
button_return:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	li 0,0
	lfs 13,4(31)
	li 9,3
	addi 11,31,748
	lfs 0,748(31)
	lis 29,button_done@ha
	addi 3,31,832
	stw 9,828(31)
	la 29,button_done@l(29)
	stw 0,472(31)
	fsubs 0,0,13
	stw 0,480(31)
	stw 0,476(31)
	lfs 12,12(31)
	stfs 0,832(31)
	lfs 13,4(11)
	lfs 0,8(31)
	fsubs 13,13,0
	stfs 13,836(31)
	lfs 0,8(11)
	fsubs 0,0,12
	stfs 0,840(31)
	bl VectorNormalize
	lfs 13,812(31)
	lfs 0,808(31)
	stfs 1,856(31)
	stw 29,864(31)
	fcmpu 0,13,0
	bc 4,2,.L151
	lfs 0,816(31)
	fcmpu 0,13,0
	bc 4,2,.L151
	lwz 0,264(31)
	lis 9,level+312@ha
	lwz 9,level+312@l(9)
	andi. 11,0,1024
	bc 12,2,.L152
	lwz 0,660(31)
	cmpw 0,9,0
	bc 12,2,.L153
	b .L154
.L152:
	cmpw 0,9,31
	bc 4,2,.L154
.L153:
	mr 3,31
	bl Move_Begin
	b .L157
.L154:
	lis 11,level+4@ha
	lis 10,.LC41@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC41@l(10)
	la 9,Move_Begin@l(9)
	stw 9,532(31)
	b .L159
.L151:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,844(31)
	lis 10,level+4@ha
	stw 9,532(31)
	lis 11,.LC41@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC41@l(11)
.L159:
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
.L157:
	lwz 9,576(31)
	li 0,0
	stw 0,56(31)
	cmpwi 0,9,0
	bc 12,2,.L158
	li 0,1
	stw 0,608(31)
.L158:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 button_return,.Lfe10-button_return
	.section	".rodata"
	.align 3
.LC42:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC43:
	.long 0x3f800000
	.align 2
.LC44:
	.long 0x40400000
	.align 2
.LC45:
	.long 0x0
	.section	".text"
	.align 2
	.globl button_fire
	.type	 button_fire,@function
button_fire:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,828(31)
	subfic 11,0,0
	adde 9,11,0
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L162
	lwz 5,796(31)
	li 0,2
	stw 0,828(31)
	cmpwi 0,5,0
	bc 12,2,.L164
	lwz 0,264(31)
	andi. 9,0,1024
	bc 4,2,.L164
	lis 11,.LC43@ha
	lis 9,gi+16@ha
	la 11,.LC43@l(11)
	lwz 0,gi+16@l(9)
	lfs 1,0(11)
	lis 9,.LC44@ha
	li 4,10
	lis 11,.LC45@ha
	la 9,.LC44@l(9)
	mtlr 0
	la 11,.LC45@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L164:
	lfs 13,4(31)
	li 0,0
	addi 9,31,772
	lfs 0,772(31)
	lis 29,button_wait@ha
	addi 3,31,832
	stw 0,472(31)
	la 29,button_wait@l(29)
	stw 0,480(31)
	fsubs 0,0,13
	stw 0,476(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,832(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,836(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,840(31)
	bl VectorNormalize
	lfs 13,812(31)
	lfs 0,808(31)
	stfs 1,856(31)
	stw 29,864(31)
	fcmpu 0,13,0
	bc 4,2,.L165
	lfs 0,816(31)
	fcmpu 0,13,0
	bc 4,2,.L165
	lwz 0,264(31)
	lis 9,level+312@ha
	lwz 9,level+312@l(9)
	andi. 11,0,1024
	bc 12,2,.L166
	lwz 0,660(31)
	cmpw 0,9,0
	bc 12,2,.L167
	b .L168
.L166:
	cmpw 0,9,31
	bc 4,2,.L168
.L167:
	mr 3,31
	bl Move_Begin
	b .L162
.L168:
	lis 11,level+4@ha
	lis 10,.LC42@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC42@l(10)
	la 9,Move_Begin@l(9)
	stw 9,532(31)
	b .L172
.L165:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,844(31)
	lis 10,level+4@ha
	stw 9,532(31)
	lis 11,.LC42@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC42@l(11)
.L172:
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
.L162:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 button_fire,.Lfe11-button_fire
	.section	".rodata"
	.align 2
.LC46:
	.string	"Demon has been Defeated!"
	.align 2
.LC47:
	.string	"switches/butn2.wav"
	.align 2
.LC48:
	.long 0x0
	.align 3
.LC49:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SP_func_button
	.type	 SP_func_button,@function
SP_func_button:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	mr 31,3
	addi 29,31,436
	addi 3,31,16
	mr 4,29
	bl G_SetMovedir
	li 0,3
	lis 9,gi@ha
	lwz 4,268(31)
	stw 0,248(31)
	la 30,gi@l(9)
	mr 3,31
	stw 0,260(31)
	lwz 9,44(30)
	mtlr 9
	blrl
	lwz 0,624(31)
	cmpwi 0,0,1
	bc 12,2,.L183
	lwz 0,36(30)
	lis 3,.LC47@ha
	la 3,.LC47@l(3)
	mtlr 0
	blrl
	stw 3,796(31)
.L183:
	lis 8,.LC48@ha
	lfs 0,424(31)
	la 8,.LC48@l(8)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,2,.L184
	lis 0,0x4220
	stw 0,424(31)
.L184:
	lfs 0,428(31)
	fcmpu 0,0,13
	bc 4,2,.L185
	lfs 0,424(31)
	stfs 0,428(31)
.L185:
	lfs 0,432(31)
	fcmpu 0,0,13
	bc 4,2,.L186
	lfs 0,424(31)
	stfs 0,432(31)
.L186:
	lfs 0,688(31)
	fcmpu 0,0,13
	bc 4,2,.L187
	lis 0,0x4040
	stw 0,688(31)
.L187:
	lis 9,st@ha
	la 10,st@l(9)
	lwz 0,24(10)
	cmpwi 0,0,0
	bc 4,2,.L188
	li 0,4
	stw 0,24(10)
.L188:
	lfs 12,4(31)
	lis 11,0x4330
	lfs 13,8(31)
	lis 8,.LC49@ha
	mr 4,29
	lfs 0,12(31)
	la 8,.LC49@l(8)
	addi 3,31,448
	stfs 12,448(31)
	addi 5,31,460
	stfs 13,452(31)
	stfs 0,456(31)
	lfs 10,440(31)
	lwz 0,24(10)
	lfs 11,436(31)
	lfs 12,240(31)
	xoris 0,0,0x8000
	fabs 10,10
	stw 0,44(1)
	lfs 0,444(31)
	fabs 11,11
	stw 11,40(1)
	fmuls 12,10,12
	lfs 13,236(31)
	lfd 1,40(1)
	fabs 0,0
	lfd 8,0(8)
	lfs 9,244(31)
	fmadds 13,11,13,12
	stfs 0,16(1)
	fsub 1,1,8
	stfs 11,8(1)
	fmadds 0,0,9,13
	stfs 10,12(1)
	frsp 1,1
	fsubs 1,0,1
	bl VectorMA
	lwz 11,576(31)
	lis 9,button_use@ha
	lwz 0,64(31)
	la 9,button_use@l(9)
	cmpwi 0,11,0
	stw 9,544(31)
	ori 0,0,1024
	stw 0,64(31)
	bc 12,2,.L189
	lis 9,button_killed@ha
	li 0,1
	stw 11,580(31)
	la 9,button_killed@l(9)
	stw 0,608(31)
	stw 9,552(31)
	b .L190
.L189:
	lwz 0,396(31)
	cmpwi 0,0,0
	bc 4,2,.L190
	lis 9,button_touch@ha
	la 9,button_touch@l(9)
	stw 9,540(31)
.L190:
	lfs 2,16(31)
	li 0,1
	lis 9,gi+72@ha
	lfs 3,20(31)
	mr 3,31
	lfs 4,24(31)
	lfs 0,424(31)
	lfs 13,428(31)
	lfs 12,432(31)
	lfs 11,688(31)
	lfs 10,448(31)
	lfs 9,452(31)
	lfs 8,456(31)
	lfs 7,460(31)
	lfs 6,464(31)
	lfs 5,468(31)
	stw 0,828(31)
	stfs 0,812(31)
	stfs 13,808(31)
	stfs 12,816(31)
	stfs 11,824(31)
	stfs 10,748(31)
	stfs 9,752(31)
	stfs 8,756(31)
	stfs 7,772(31)
	stfs 6,776(31)
	stfs 5,780(31)
	stfs 2,784(31)
	stfs 3,788(31)
	stfs 4,792(31)
	stfs 2,760(31)
	stfs 3,764(31)
	stfs 4,768(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe12:
	.size	 SP_func_button,.Lfe12-SP_func_button
	.section	".rodata"
	.align 2
.LC50:
	.string	"func_areaportal"
	.align 2
.LC51:
	.string	"func_door"
	.align 2
.LC53:
	.string	"func_door_rotating"
	.align 3
.LC52:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC54:
	.long 0x3f800000
	.align 2
.LC55:
	.long 0x40400000
	.align 2
.LC56:
	.long 0x0
	.section	".text"
	.align 2
	.globl door_go_down
	.type	 door_go_down,@function
door_go_down:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,264(31)
	andi. 8,0,1024
	bc 4,2,.L215
	lwz 5,796(31)
	cmpwi 0,5,0
	bc 12,2,.L216
	lis 9,gi+16@ha
	lis 11,.LC55@ha
	lwz 0,gi+16@l(9)
	lis 8,.LC56@ha
	la 11,.LC55@l(11)
	lis 9,.LC54@ha
	la 8,.LC56@l(8)
	lfs 2,0(11)
	la 9,.LC54@l(9)
	lfs 3,0(8)
	mtlr 0
	li 4,10
	lfs 1,0(9)
	blrl
.L216:
	lwz 0,800(31)
	stw 0,76(31)
.L215:
	lwz 9,580(31)
	cmpwi 0,9,0
	bc 12,2,.L217
	li 0,1
	stw 9,576(31)
	stw 0,608(31)
.L217:
	li 0,3
	lwz 3,280(31)
	lis 4,.LC51@ha
	stw 0,828(31)
	la 4,.LC51@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L218
	lfs 13,4(31)
	li 0,0
	addi 9,31,748
	lfs 0,748(31)
	lis 29,door_hit_bottom@ha
	addi 3,31,832
	stw 0,472(31)
	la 29,door_hit_bottom@l(29)
	stw 0,480(31)
	fsubs 0,0,13
	stw 0,476(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,832(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,836(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,840(31)
	bl VectorNormalize
	lfs 13,812(31)
	lfs 0,808(31)
	stfs 1,856(31)
	stw 29,864(31)
	fcmpu 0,13,0
	bc 4,2,.L219
	lfs 0,816(31)
	fcmpu 0,13,0
	bc 4,2,.L219
	lwz 0,264(31)
	lis 9,level+312@ha
	lwz 9,level+312@l(9)
	andi. 8,0,1024
	bc 12,2,.L220
	lwz 0,660(31)
	cmpw 0,9,0
	bc 12,2,.L221
	b .L222
.L220:
	cmpw 0,9,31
	bc 4,2,.L222
.L221:
	mr 3,31
	bl Move_Begin
	b .L226
.L222:
	lis 11,level+4@ha
	lis 10,.LC52@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC52@l(10)
	la 9,Move_Begin@l(9)
	b .L233
.L219:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,844(31)
	lis 10,level+4@ha
	stw 9,532(31)
	lis 11,.LC52@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC52@l(11)
	b .L234
.L218:
	lwz 3,280(31)
	lis 4,.LC53@ha
	la 4,.LC53@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L226
	lwz 10,264(31)
	lis 9,door_hit_bottom@ha
	li 0,0
	la 9,door_hit_bottom@l(9)
	stw 0,484(31)
	lis 11,level+312@ha
	andi. 8,10,1024
	stw 9,864(31)
	stw 0,492(31)
	stw 0,488(31)
	lwz 9,level+312@l(11)
	bc 12,2,.L228
	lwz 0,660(31)
	cmpw 0,9,0
	bc 12,2,.L229
	b .L230
.L228:
	cmpw 0,9,31
	bc 4,2,.L230
.L229:
	mr 3,31
	bl AngleMove_Begin
	b .L226
.L230:
	lis 11,level+4@ha
	lis 10,.LC52@ha
	lfs 0,level+4@l(11)
	lis 9,AngleMove_Begin@ha
	lfd 13,.LC52@l(10)
	la 9,AngleMove_Begin@l(9)
.L233:
	stw 9,532(31)
.L234:
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
.L226:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 door_go_down,.Lfe13-door_go_down
	.section	".rodata"
	.align 3
.LC57:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC58:
	.long 0x0
	.align 2
.LC59:
	.long 0x3f800000
	.align 2
.LC60:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl door_go_up
	.type	 door_go_up,@function
door_go_up:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	lwz 0,828(31)
	cmpwi 0,0,2
	bc 12,2,.L235
	cmpwi 0,0,0
	bc 4,2,.L237
	lis 8,.LC58@ha
	lfs 13,824(31)
	la 8,.LC58@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L235
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,13
	stfs 0,524(31)
	b .L235
.L237:
	lwz 0,264(31)
	andi. 9,0,1024
	bc 4,2,.L239
	lwz 5,796(31)
	cmpwi 0,5,0
	bc 12,2,.L240
	lis 9,gi+16@ha
	lis 11,.LC59@ha
	lwz 0,gi+16@l(9)
	lis 8,.LC60@ha
	la 11,.LC59@l(11)
	lis 9,.LC58@ha
	la 8,.LC60@l(8)
	lfs 1,0(11)
	la 9,.LC58@l(9)
	mr 3,31
	lfs 2,0(8)
	mtlr 0
	li 4,10
	lfs 3,0(9)
	blrl
.L240:
	lwz 0,800(31)
	stw 0,76(31)
.L239:
	li 0,2
	lwz 3,280(31)
	lis 4,.LC51@ha
	stw 0,828(31)
	la 4,.LC51@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L241
	lfs 13,4(31)
	li 0,0
	addi 9,31,772
	lfs 0,772(31)
	lis 29,door_hit_top@ha
	addi 3,31,832
	stw 0,472(31)
	la 29,door_hit_top@l(29)
	stw 0,480(31)
	fsubs 0,0,13
	stw 0,476(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,832(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,836(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,840(31)
	bl VectorNormalize
	lfs 13,812(31)
	lfs 0,808(31)
	stfs 1,856(31)
	stw 29,864(31)
	fcmpu 0,13,0
	bc 4,2,.L242
	lfs 0,816(31)
	fcmpu 0,13,0
	bc 4,2,.L242
	lwz 0,264(31)
	lis 9,level+312@ha
	lwz 9,level+312@l(9)
	andi. 8,0,1024
	bc 12,2,.L243
	lwz 0,660(31)
	cmpw 0,9,0
	bc 12,2,.L244
	b .L245
.L243:
	cmpw 0,9,31
	bc 4,2,.L245
.L244:
	mr 3,31
	bl Move_Begin
	b .L249
.L245:
	lis 11,level+4@ha
	lis 10,.LC57@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC57@l(10)
	la 9,Move_Begin@l(9)
	b .L263
.L242:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,844(31)
	lis 10,level+4@ha
	stw 9,532(31)
	lis 11,.LC57@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC57@l(11)
	b .L264
.L241:
	lwz 3,280(31)
	lis 4,.LC53@ha
	la 4,.LC53@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L249
	lwz 10,264(31)
	lis 9,door_hit_top@ha
	li 0,0
	la 9,door_hit_top@l(9)
	stw 0,484(31)
	lis 11,level+312@ha
	andi. 8,10,1024
	stw 9,864(31)
	stw 0,492(31)
	stw 0,488(31)
	lwz 9,level+312@l(11)
	bc 12,2,.L251
	lwz 0,660(31)
	cmpw 0,9,0
	bc 12,2,.L252
	b .L253
.L251:
	cmpw 0,9,31
	bc 4,2,.L253
.L252:
	mr 3,31
	bl AngleMove_Begin
	b .L249
.L253:
	lis 11,level+4@ha
	lis 10,.LC57@ha
	lfs 0,level+4@l(11)
	lis 9,AngleMove_Begin@ha
	lfd 13,.LC57@l(10)
	la 9,AngleMove_Begin@l(9)
.L263:
	stw 9,532(31)
.L264:
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
.L249:
	mr 4,30
	mr 3,31
	bl G_UseTargets
	li 29,0
	lwz 0,392(31)
	cmpwi 0,0,0
	bc 12,2,.L235
	lis 9,gi@ha
	lis 28,.LC50@ha
	la 30,gi@l(9)
	b .L258
.L260:
	lwz 3,280(29)
	la 4,.LC50@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L258
	lwz 9,64(30)
	li 4,1
	lwz 3,740(29)
	mtlr 9
	blrl
.L258:
	lwz 5,392(31)
	mr 3,29
	li 4,396
	bl G_Find
	mr. 29,3
	bc 4,2,.L260
.L235:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 door_go_up,.Lfe14-door_go_up
	.section	".rodata"
	.align 2
.LC61:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl Think_SpawnDoorTrigger
	.type	 Think_SpawnDoorTrigger,@function
Think_SpawnDoorTrigger:
	stwu 1,-64(1)
	mflr 0
	stmw 28,48(1)
	stw 0,68(1)
	mr 29,3
	lwz 0,264(29)
	andi. 9,0,1024
	bc 4,2,.L315
	lwz 31,656(29)
	lfs 10,212(29)
	lfs 9,216(29)
	cmpwi 0,31,0
	lfs 0,220(29)
	lfs 13,224(29)
	lfs 12,228(29)
	lfs 11,232(29)
	stfs 10,8(1)
	stfs 9,12(1)
	stfs 0,16(1)
	stfs 13,24(1)
	stfs 12,28(1)
	stfs 11,32(1)
	bc 12,2,.L318
	addi 30,1,24
.L320:
	addi 3,31,212
	addi 4,1,8
	mr 5,30
	bl AddPointToBounds
	addi 3,31,224
	addi 4,1,8
	mr 5,30
	bl AddPointToBounds
	lwz 31,656(31)
	cmpwi 0,31,0
	bc 4,2,.L320
.L318:
	lis 9,.LC61@ha
	lfs 10,8(1)
	la 9,.LC61@l(9)
	lfs 12,12(1)
	lfs 0,0(9)
	lfs 11,24(1)
	lfs 13,28(1)
	fsubs 10,10,0
	fsubs 12,12,0
	fadds 11,11,0
	fadds 13,13,0
	stfs 10,8(1)
	stfs 12,12(1)
	stfs 11,24(1)
	stfs 13,28(1)
	bl G_Spawn
	lfs 0,8(1)
	mr 31,3
	lis 11,Touch_DoorTrigger@ha
	li 0,1
	la 11,Touch_DoorTrigger@l(11)
	li 10,0
	lis 9,gi@ha
	stfs 0,188(31)
	la 30,gi@l(9)
	lfs 13,12(1)
	stfs 13,192(31)
	lfs 0,16(1)
	stfs 0,196(31)
	lfs 13,24(1)
	stfs 13,200(31)
	lfs 0,28(1)
	stfs 0,204(31)
	lfs 13,32(1)
	stw 0,248(31)
	stw 10,260(31)
	stfs 13,208(31)
	stw 11,540(31)
	stw 29,256(31)
	lwz 9,72(30)
	mtlr 9
	blrl
	lwz 0,284(29)
	andi. 9,0,1
	bc 12,2,.L322
	lwz 0,392(29)
	li 31,0
	cmpwi 0,0,0
	bc 12,2,.L322
	mr 28,30
	lis 30,.LC50@ha
	b .L325
.L327:
	lwz 3,280(31)
	la 4,.LC50@l(30)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L325
	lwz 9,64(28)
	li 4,1
	lwz 3,740(31)
	mtlr 9
	blrl
.L325:
	lwz 5,392(29)
	mr 3,31
	li 4,396
	bl G_Find
	mr. 31,3
	bc 4,2,.L327
.L322:
	lwz 0,264(29)
	andi. 9,0,1024
	bc 4,2,.L315
	lwz 9,656(29)
	lfs 0,820(29)
	cmpwi 0,9,0
	lfs 12,812(29)
	fabs 13,0
	bc 12,2,.L337
.L334:
	lfs 0,820(9)
	fabs 0,0
	fcmpu 0,0,13
	bc 4,0,.L336
	fmr 13,0
.L336:
	lwz 9,656(9)
	cmpwi 0,9,0
	bc 4,2,.L334
.L337:
	mr. 9,29
	fdivs 0,13,12
	bc 12,2,.L315
	fmr 9,0
.L340:
	lfs 0,820(9)
	lfs 13,812(9)
	lfs 11,808(9)
	fcmpu 0,11,13
	fabs 0,0
	fdiv 0,0,9
	frsp 12,0
	fdivs 10,12,13
	bc 4,2,.L341
	stfs 12,808(9)
	b .L342
.L341:
	fmuls 0,11,10
	stfs 0,808(9)
.L342:
	lfs 13,816(9)
	lfs 0,812(9)
	fcmpu 0,13,0
	bc 4,2,.L343
	stfs 12,816(9)
	b .L344
.L343:
	fmuls 0,13,10
	stfs 0,816(9)
.L344:
	stfs 12,812(9)
	lwz 9,656(9)
	cmpwi 0,9,0
	bc 4,2,.L340
.L315:
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe15:
	.size	 Think_SpawnDoorTrigger,.Lfe15-Think_SpawnDoorTrigger
	.section	".rodata"
	.align 2
.LC62:
	.string	"%s"
	.align 2
.LC63:
	.string	"misc/talk1.wav"
	.align 2
.LC64:
	.string	"doors/dr1_strt.wav"
	.align 2
.LC65:
	.string	"doors/dr1_mid.wav"
	.align 2
.LC66:
	.string	"doors/dr1_end.wav"
	.align 2
.LC67:
	.string	"misc/talk.wav"
	.align 3
.LC68:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC69:
	.long 0x0
	.align 3
.LC70:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SP_func_door
	.type	 SP_func_door,@function
SP_func_door:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,624(31)
	cmpwi 0,0,1
	bc 12,2,.L388
	lis 29,gi@ha
	lis 3,.LC64@ha
	la 29,gi@l(29)
	la 3,.LC64@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,796(31)
	lwz 9,36(29)
	lis 3,.LC65@ha
	la 3,.LC65@l(3)
	mtlr 9
	blrl
	stw 3,800(31)
	lwz 0,36(29)
	lis 3,.LC66@ha
	la 3,.LC66@l(3)
	mtlr 0
	blrl
	stw 3,804(31)
.L388:
	addi 29,31,436
	addi 3,31,16
	mr 4,29
	li 30,2
	bl G_SetMovedir
	li 0,3
	lis 9,gi@ha
	stw 30,260(31)
	la 28,gi@l(9)
	stw 0,248(31)
	mr 3,31
	lwz 9,44(28)
	lwz 4,268(31)
	mtlr 9
	blrl
	lis 8,.LC69@ha
	lfs 0,424(31)
	lis 9,door_blocked@ha
	la 8,.LC69@l(8)
	lis 11,door_use@ha
	lfs 13,0(8)
	la 9,door_blocked@l(9)
	la 11,door_use@l(11)
	stw 9,536(31)
	stw 11,544(31)
	fcmpu 0,0,13
	bc 4,2,.L389
	lis 0,0x42c8
	stw 0,424(31)
.L389:
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L390
	lfs 0,424(31)
	fadds 0,0,0
	stfs 0,424(31)
.L390:
	lfs 0,428(31)
	fcmpu 0,0,13
	bc 4,2,.L391
	lfs 0,424(31)
	stfs 0,428(31)
.L391:
	lfs 0,432(31)
	fcmpu 0,0,13
	bc 4,2,.L392
	lfs 0,424(31)
	stfs 0,432(31)
.L392:
	lfs 0,688(31)
	fcmpu 0,0,13
	bc 4,2,.L393
	lis 0,0x4040
	stw 0,688(31)
.L393:
	lis 9,st@ha
	la 10,st@l(9)
	lwz 0,24(10)
	cmpwi 0,0,0
	bc 4,2,.L394
	li 0,8
	stw 0,24(10)
.L394:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L395
	stw 30,612(31)
.L395:
	lfs 12,4(31)
	lis 11,0x4330
	lfs 13,8(31)
	lis 8,.LC70@ha
	mr 4,29
	lfs 0,12(31)
	la 8,.LC70@l(8)
	addi 3,31,448
	stfs 12,448(31)
	addi 5,31,460
	stfs 13,452(31)
	stfs 0,456(31)
	lfs 9,440(31)
	lwz 0,24(10)
	lfs 10,436(31)
	lfs 11,240(31)
	xoris 0,0,0x8000
	fabs 9,9
	stw 0,28(1)
	lfs 0,444(31)
	fabs 10,10
	stw 11,24(1)
	fmuls 11,9,11
	lfs 12,236(31)
	lfd 7,0(8)
	fabs 0,0
	lfd 13,24(1)
	lfs 8,244(31)
	fmadds 12,10,12,11
	stfs 0,16(1)
	fsub 13,13,7
	stfs 10,8(1)
	fmadds 0,0,8,12
	stfs 9,12(1)
	frsp 13,13
	fsubs 0,0,13
	fmr 1,0
	stfs 0,820(31)
	bl VectorMA
	lwz 0,284(31)
	andi. 8,0,1
	bc 12,2,.L396
	lfs 11,460(31)
	lfs 10,464(31)
	lfs 9,468(31)
	lfs 0,448(31)
	lfs 13,452(31)
	lfs 12,456(31)
	stfs 0,460(31)
	stfs 13,464(31)
	stfs 12,468(31)
	stfs 11,448(31)
	stfs 10,452(31)
	stfs 9,456(31)
	stfs 11,4(31)
	stfs 10,8(31)
	stfs 9,12(31)
.L396:
	lwz 0,576(31)
	li 11,1
	stw 11,828(31)
	cmpwi 0,0,0
	bc 12,2,.L397
	lis 9,door_killed@ha
	stw 11,608(31)
	la 9,door_killed@l(9)
	stw 0,580(31)
	stw 9,552(31)
	b .L398
.L397:
	lwz 0,396(31)
	cmpwi 0,0,0
	bc 12,2,.L398
	lwz 0,276(31)
	cmpwi 0,0,0
	bc 12,2,.L398
	lwz 0,36(28)
	lis 3,.LC67@ha
	la 3,.LC67@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,540(31)
.L398:
	lwz 0,284(31)
	lfs 3,16(31)
	lfs 2,20(31)
	andi. 8,0,16
	lfs 4,24(31)
	lfs 0,424(31)
	lfs 13,428(31)
	lfs 12,432(31)
	lfs 11,688(31)
	lfs 10,448(31)
	lfs 9,452(31)
	lfs 8,456(31)
	lfs 7,460(31)
	lfs 6,464(31)
	lfs 5,468(31)
	stfs 0,812(31)
	stfs 13,808(31)
	stfs 12,816(31)
	stfs 11,824(31)
	stfs 10,748(31)
	stfs 9,752(31)
	stfs 8,756(31)
	stfs 7,772(31)
	stfs 6,776(31)
	stfs 5,780(31)
	stfs 3,784(31)
	stfs 2,788(31)
	stfs 4,792(31)
	stfs 3,760(31)
	stfs 2,764(31)
	stfs 4,768(31)
	bc 12,2,.L400
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L400:
	lwz 0,284(31)
	andi. 9,0,64
	bc 12,2,.L401
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L401:
	lwz 0,404(31)
	cmpwi 0,0,0
	bc 4,2,.L402
	stw 31,660(31)
.L402:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC68@ha
	lwz 0,576(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC68@l(11)
	cmpwi 0,0,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
	bc 4,2,.L404
	lwz 0,396(31)
	cmpwi 0,0,0
	bc 12,2,.L403
.L404:
	lis 9,Think_CalcMoveSpeed@ha
	la 9,Think_CalcMoveSpeed@l(9)
	b .L406
.L403:
	lis 9,Think_SpawnDoorTrigger@ha
	la 9,Think_SpawnDoorTrigger@l(9)
.L406:
	stw 9,532(31)
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe16:
	.size	 SP_func_door,.Lfe16-SP_func_door
	.section	".rodata"
	.align 2
.LC71:
	.string	"%s at %s with no distance set\n"
	.align 3
.LC72:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC73:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC74:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_func_door_rotating
	.type	 SP_func_door_rotating,@function
SP_func_door_rotating:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	mr 31,3
	li 0,0
	lwz 9,284(31)
	stw 0,436(31)
	andi. 11,9,64
	stw 0,24(31)
	stw 0,20(31)
	stw 0,16(31)
	stw 0,444(31)
	stw 0,440(31)
	bc 12,2,.L408
	lis 0,0x3f80
	stw 0,444(31)
	b .L409
.L408:
	andi. 0,9,128
	bc 12,2,.L410
	lis 0,0x3f80
	stw 0,436(31)
	b .L409
.L410:
	lis 0,0x3f80
	stw 0,440(31)
.L409:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L412
	lfs 0,436(31)
	lfs 13,440(31)
	lfs 12,444(31)
	fneg 0,0
	fneg 13,13
	fneg 12,12
	stfs 0,436(31)
	stfs 13,440(31)
	stfs 12,444(31)
.L412:
	lis 9,st@ha
	la 30,st@l(9)
	lwz 0,28(30)
	cmpwi 0,0,0
	bc 4,2,.L413
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC71@ha
	mtlr 0
	la 3,.LC71@l(3)
	crxor 6,6,6
	blrl
	li 0,90
	stw 0,28(30)
.L413:
	lfs 13,20(31)
	lis 29,0x4330
	lfs 12,16(31)
	lis 11,.LC73@ha
	addi 3,31,16
	lfs 0,24(31)
	la 11,.LC73@l(11)
	addi 4,31,436
	stfs 13,452(31)
	addi 5,31,460
	li 28,2
	stfs 12,448(31)
	stfs 0,456(31)
	lwz 0,28(30)
	lfd 31,0(11)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 29,16(1)
	lfd 1,16(1)
	fsub 1,1,31
	frsp 1,1
	bl VectorMA
	lwz 9,28(30)
	li 0,3
	lis 10,gi@ha
	stw 0,248(31)
	mr 3,31
	xoris 9,9,0x8000
	la 30,gi@l(10)
	stw 28,260(31)
	stw 9,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	lwz 4,268(31)
	fsub 0,0,31
	frsp 0,0
	stfs 0,820(31)
	lwz 9,44(30)
	mtlr 9
	blrl
	lis 9,.LC74@ha
	lfs 0,424(31)
	lis 11,door_use@ha
	la 9,.LC74@l(9)
	la 11,door_use@l(11)
	lfs 13,0(9)
	lis 9,door_blocked@ha
	stw 11,544(31)
	la 9,door_blocked@l(9)
	fcmpu 0,0,13
	stw 9,536(31)
	bc 4,2,.L414
	lis 0,0x42c8
	stw 0,424(31)
.L414:
	lfs 0,428(31)
	fcmpu 0,0,13
	bc 4,2,.L415
	lfs 0,424(31)
	stfs 0,428(31)
.L415:
	lfs 0,432(31)
	fcmpu 0,0,13
	bc 4,2,.L416
	lfs 0,424(31)
	stfs 0,432(31)
.L416:
	lfs 0,688(31)
	fcmpu 0,0,13
	bc 4,2,.L417
	lis 0,0x4040
	stw 0,688(31)
.L417:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L418
	stw 28,612(31)
.L418:
	lwz 0,624(31)
	cmpwi 0,0,1
	bc 12,2,.L419
	lwz 9,36(30)
	lis 3,.LC64@ha
	la 3,.LC64@l(3)
	mtlr 9
	blrl
	stw 3,796(31)
	lwz 9,36(30)
	lis 3,.LC65@ha
	la 3,.LC65@l(3)
	mtlr 9
	blrl
	stw 3,800(31)
	lwz 9,36(30)
	lis 3,.LC66@ha
	la 3,.LC66@l(3)
	mtlr 9
	blrl
	stw 3,804(31)
.L419:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L420
	lfs 11,436(31)
	lfs 10,440(31)
	lfs 9,444(31)
	lfs 6,460(31)
	fneg 11,11
	lfs 8,464(31)
	fneg 10,10
	lfs 7,468(31)
	fneg 9,9
	lfs 0,448(31)
	lfs 13,452(31)
	lfs 12,456(31)
	stfs 0,460(31)
	stfs 13,464(31)
	stfs 12,468(31)
	stfs 6,448(31)
	stfs 8,452(31)
	stfs 7,456(31)
	stfs 11,436(31)
	stfs 10,440(31)
	stfs 9,444(31)
	stfs 6,16(31)
	stfs 8,20(31)
	stfs 7,24(31)
.L420:
	lwz 11,576(31)
	cmpwi 0,11,0
	bc 12,2,.L421
	lis 9,door_killed@ha
	li 0,1
	stw 11,580(31)
	la 9,door_killed@l(9)
	stw 0,608(31)
	stw 9,552(31)
.L421:
	lwz 0,396(31)
	cmpwi 0,0,0
	bc 12,2,.L422
	lwz 0,276(31)
	cmpwi 0,0,0
	bc 12,2,.L422
	lwz 0,36(30)
	lis 3,.LC67@ha
	la 3,.LC67@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,540(31)
.L422:
	lwz 0,284(31)
	li 9,1
	lfs 3,4(31)
	lfs 2,8(31)
	andi. 11,0,16
	lfs 4,12(31)
	lfs 0,424(31)
	lfs 13,428(31)
	lfs 12,432(31)
	lfs 11,688(31)
	lfs 10,448(31)
	lfs 9,452(31)
	lfs 8,456(31)
	lfs 7,460(31)
	lfs 6,464(31)
	lfs 5,468(31)
	stw 9,828(31)
	stfs 0,812(31)
	stfs 13,808(31)
	stfs 12,816(31)
	stfs 11,824(31)
	stfs 10,760(31)
	stfs 9,764(31)
	stfs 8,768(31)
	stfs 3,772(31)
	stfs 2,776(31)
	stfs 4,780(31)
	stfs 7,784(31)
	stfs 6,788(31)
	stfs 5,792(31)
	stfs 3,748(31)
	stfs 2,752(31)
	stfs 4,756(31)
	bc 12,2,.L423
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L423:
	lwz 0,404(31)
	cmpwi 0,0,0
	bc 4,2,.L424
	stw 31,660(31)
.L424:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC72@ha
	lwz 0,576(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC72@l(11)
	cmpwi 0,0,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
	bc 4,2,.L426
	lwz 0,396(31)
	cmpwi 0,0,0
	bc 12,2,.L425
.L426:
	lis 9,Think_CalcMoveSpeed@ha
	la 9,Think_CalcMoveSpeed@l(9)
	b .L428
.L425:
	lis 9,Think_SpawnDoorTrigger@ha
	la 9,Think_SpawnDoorTrigger@l(9)
.L428:
	stw 9,532(31)
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 SP_func_door_rotating,.Lfe17-SP_func_door_rotating
	.section	".rodata"
	.align 2
.LC75:
	.string	"world/mov_watr.wav"
	.align 2
.LC76:
	.string	"world/stp_watr.wav"
	.align 3
.LC77:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC78:
	.long 0x0
	.align 2
.LC79:
	.long 0xbf800000
	.section	".text"
	.align 2
	.globl SP_func_water
	.type	 SP_func_water,@function
SP_func_water:
	stwu 1,-48(1)
	mflr 0
	stmw 30,40(1)
	stw 0,52(1)
	mr 31,3
	addi 3,31,16
	addi 4,31,436
	bl G_SetMovedir
	li 0,2
	li 11,3
	lwz 4,268(31)
	lis 9,gi@ha
	stw 0,260(31)
	mr 3,31
	la 30,gi@l(9)
	stw 11,248(31)
	lwz 9,44(30)
	mtlr 9
	blrl
	lwz 0,624(31)
	cmpwi 0,0,1
	bc 12,2,.L432
	cmpwi 0,0,2
	bc 4,2,.L430
.L432:
	lwz 9,36(30)
	lis 3,.LC75@ha
	la 3,.LC75@l(3)
	mtlr 9
	blrl
	stw 3,796(31)
	lwz 0,36(30)
	lis 3,.LC76@ha
	la 3,.LC76@l(3)
	mtlr 0
	blrl
	stw 3,804(31)
.L430:
	lfs 12,4(31)
	lis 11,st+24@ha
	lfs 13,8(31)
	lis 10,0x4330
	lis 8,.LC77@ha
	lfs 0,12(31)
	la 8,.LC77@l(8)
	addi 3,31,448
	stfs 12,448(31)
	addi 4,31,436
	addi 5,31,460
	stfs 13,452(31)
	stfs 0,456(31)
	lfs 9,440(31)
	lwz 0,st+24@l(11)
	lfs 10,436(31)
	lfs 11,240(31)
	xoris 0,0,0x8000
	fabs 9,9
	stw 0,36(1)
	lfs 0,444(31)
	fabs 10,10
	stw 10,32(1)
	fmuls 11,9,11
	lfs 12,236(31)
	lfd 7,0(8)
	fabs 0,0
	lfd 13,32(1)
	lfs 8,244(31)
	fmadds 12,10,12,11
	stfs 0,16(1)
	fsub 13,13,7
	stfs 10,8(1)
	fmadds 0,0,8,12
	stfs 9,12(1)
	frsp 13,13
	fsubs 0,0,13
	fmr 1,0
	stfs 0,820(31)
	bl VectorMA
	lwz 0,284(31)
	andi. 8,0,1
	bc 12,2,.L435
	lfs 11,460(31)
	lfs 10,464(31)
	lfs 9,468(31)
	lfs 0,448(31)
	lfs 13,452(31)
	lfs 12,456(31)
	stfs 0,460(31)
	stfs 13,464(31)
	stfs 12,468(31)
	stfs 11,448(31)
	stfs 10,452(31)
	stfs 9,456(31)
	stfs 11,4(31)
	stfs 10,8(31)
	stfs 9,12(31)
.L435:
	lis 9,.LC78@ha
	lfs 0,424(31)
	li 0,1
	la 9,.LC78@l(9)
	lfs 6,16(31)
	lfs 5,0(9)
	lfs 8,20(31)
	lfs 7,24(31)
	fcmpu 0,0,5
	lfs 13,452(31)
	lfs 0,448(31)
	lfs 12,456(31)
	lfs 11,460(31)
	lfs 10,464(31)
	lfs 9,468(31)
	stfs 0,748(31)
	stfs 13,752(31)
	stfs 12,756(31)
	stfs 11,772(31)
	stfs 10,776(31)
	stfs 9,780(31)
	stfs 6,784(31)
	stfs 8,788(31)
	stfs 7,792(31)
	stw 0,828(31)
	stfs 6,760(31)
	stfs 8,764(31)
	stfs 7,768(31)
	bc 4,2,.L436
	lis 0,0x41c8
	stw 0,424(31)
.L436:
	lfs 13,688(31)
	lfs 0,424(31)
	fcmpu 0,13,5
	stfs 0,808(31)
	stfs 0,812(31)
	stfs 0,816(31)
	bc 4,2,.L437
	lis 0,0xbf80
	stw 0,688(31)
.L437:
	lis 8,.LC79@ha
	lfs 13,688(31)
	lis 9,door_use@ha
	la 8,.LC79@l(8)
	la 9,door_use@l(9)
	lfs 0,0(8)
	stw 9,544(31)
	stfs 13,824(31)
	fcmpu 0,13,0
	bc 4,2,.L438
	lwz 0,284(31)
	ori 0,0,32
	stw 0,284(31)
.L438:
	lis 9,.LC51@ha
	lis 11,gi+72@ha
	la 9,.LC51@l(9)
	mr 3,31
	stw 9,280(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 30,40(1)
	la 1,48(1)
	blr
.Lfe18:
	.size	 SP_func_water,.Lfe18-SP_func_water
	.section	".rodata"
	.align 2
.LC80:
	.long 0x0
	.align 2
.LC81:
	.long 0x3f800000
	.align 2
.LC82:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl train_wait
	.type	 train_wait,@function
train_wait:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 29,12(1)
	stw 0,36(1)
	mr 31,3
	lwz 30,420(31)
	lwz 0,408(30)
	cmpwi 0,0,0
	bc 12,2,.L445
	lwz 29,392(30)
	mr 3,30
	stw 0,392(30)
	lwz 4,644(31)
	bl G_UseTargets
	stw 29,392(30)
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L444
.L445:
	lis 9,.LC80@ha
	lfs 13,824(31)
	la 9,.LC80@l(9)
	lfs 31,0(9)
	fcmpu 0,13,31
	bc 12,2,.L447
	bc 4,1,.L448
	lis 9,level+4@ha
	lis 11,train_next@ha
	lfs 0,level+4@l(9)
	la 11,train_next@l(11)
	stw 11,532(31)
	fadds 0,0,13
	stfs 0,524(31)
	b .L449
.L448:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L449
	mr 3,31
	bl train_next
	lwz 0,284(31)
	stfs 31,524(31)
	rlwinm 0,0,0,0,30
	stfs 31,480(31)
	stw 0,284(31)
	stfs 31,476(31)
	stfs 31,472(31)
.L449:
	lwz 0,264(31)
	andi. 30,0,1024
	bc 4,2,.L444
	lwz 5,804(31)
	cmpwi 0,5,0
	bc 12,2,.L452
	lis 9,gi+16@ha
	mr 3,31
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC81@ha
	la 9,.LC81@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC82@ha
	la 9,.LC82@l(9)
	lfs 2,0(9)
	lis 9,.LC80@ha
	la 9,.LC80@l(9)
	lfs 3,0(9)
	blrl
.L452:
	stw 30,76(31)
	b .L444
.L447:
	mr 3,31
	bl train_next
.L444:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 train_wait,.Lfe19-train_wait
	.section	".rodata"
	.align 2
.LC83:
	.string	"train_next: bad target %s\n"
	.align 2
.LC84:
	.string	"connected teleport path_corners, see %s at %s\n"
	.align 3
.LC85:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC86:
	.long 0x3f800000
	.align 2
.LC87:
	.long 0x40400000
	.align 2
.LC88:
	.long 0x0
	.section	".text"
	.align 2
	.globl train_next
	.type	 train_next,@function
train_next:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 28,3
	li 29,1
.L455:
	lwz 3,392(28)
	cmpwi 0,3,0
	bc 12,2,.L454
	bl G_PickTarget
	mr. 31,3
	bc 4,2,.L457
	lis 9,gi+4@ha
	lis 3,.LC83@ha
	lwz 4,392(28)
	lwz 0,gi+4@l(9)
	la 3,.LC83@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L454
.L457:
	lwz 0,392(31)
	stw 0,392(28)
	lwz 9,284(31)
	andi. 0,9,1
	bc 12,2,.L458
	cmpwi 0,29,0
	bc 4,2,.L459
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC84@ha
	la 3,.LC84@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L454
.L459:
	lfs 12,4(31)
	li 0,7
	lis 9,gi+72@ha
	lfs 0,188(28)
	mr 3,28
	li 29,0
	lfs 13,192(28)
	lfs 11,196(28)
	fsubs 12,12,0
	stfs 12,4(28)
	lfs 0,8(31)
	fsubs 0,0,13
	stfs 0,8(28)
	lfs 13,12(31)
	stfs 12,28(28)
	stfs 0,32(28)
	fsubs 13,13,11
	stw 0,80(28)
	stfs 13,36(28)
	stfs 13,12(28)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	b .L455
.L458:
	lwz 0,264(28)
	lfs 0,688(31)
	andi. 9,0,1024
	stw 31,420(28)
	stfs 0,824(28)
	bc 4,2,.L460
	lwz 5,796(28)
	cmpwi 0,5,0
	bc 12,2,.L461
	lis 11,.LC86@ha
	lis 9,gi+16@ha
	la 11,.LC86@l(11)
	lwz 0,gi+16@l(9)
	mr 3,28
	lfs 1,0(11)
	lis 9,.LC87@ha
	li 4,10
	lis 11,.LC88@ha
	la 9,.LC87@l(9)
	mtlr 0
	la 11,.LC88@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L461:
	lwz 0,800(28)
	stw 0,76(28)
.L460:
	lfs 11,4(31)
	li 0,0
	li 9,0
	lfs 0,188(28)
	addi 11,1,8
	lis 29,train_wait@ha
	lfs 12,192(28)
	la 29,train_wait@l(29)
	addi 3,28,832
	lfs 8,4(28)
	fsubs 11,11,0
	lfs 7,8(28)
	lfs 10,196(28)
	stfs 11,8(1)
	fsubs 13,11,8
	lfs 0,8(31)
	lfs 9,12(28)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 12,12(31)
	stw 9,828(28)
	stfs 0,776(28)
	fsubs 12,12,10
	stw 0,472(28)
	stfs 13,832(28)
	stfs 12,16(1)
	lfs 0,8(11)
	lfs 13,4(11)
	stfs 12,780(28)
	fsubs 0,0,9
	stfs 8,748(28)
	fsubs 13,13,7
	stfs 7,752(28)
	stfs 9,756(28)
	stfs 0,840(28)
	stfs 13,836(28)
	stfs 11,772(28)
	stw 0,480(28)
	stw 0,476(28)
	bl VectorNormalize
	lfs 13,812(28)
	lfs 0,808(28)
	stfs 1,856(28)
	stw 29,864(28)
	fcmpu 0,13,0
	bc 4,2,.L462
	lfs 0,816(28)
	fcmpu 0,13,0
	bc 4,2,.L462
	lwz 0,264(28)
	lis 9,level+312@ha
	lwz 9,level+312@l(9)
	andi. 11,0,1024
	bc 12,2,.L463
	lwz 0,660(28)
	cmpw 0,9,0
	bc 12,2,.L464
	b .L465
.L463:
	cmpw 0,9,28
	bc 4,2,.L465
.L464:
	mr 3,28
	bl Move_Begin
	b .L468
.L465:
	lis 11,level+4@ha
	lis 10,.LC85@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC85@l(10)
	la 9,Move_Begin@l(9)
	stw 9,532(28)
	b .L469
.L462:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,844(28)
	lis 10,level+4@ha
	stw 9,532(28)
	lis 11,.LC85@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC85@l(11)
.L469:
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(28)
.L468:
	lwz 0,284(28)
	ori 0,0,1
	stw 0,284(28)
.L454:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe20:
	.size	 train_next,.Lfe20-train_next
	.section	".rodata"
	.align 3
.LC89:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl train_resume
	.type	 train_resume,@function
train_resume:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	li 0,0
	lwz 9,420(31)
	li 11,0
	addi 10,1,8
	lfs 0,188(31)
	lis 29,train_wait@ha
	addi 3,31,832
	lfs 11,4(9)
	la 29,train_wait@l(29)
	lfs 13,192(31)
	lfs 7,4(31)
	fsubs 11,11,0
	lfs 6,8(31)
	lfs 9,196(31)
	stfs 11,8(1)
	fsubs 10,11,7
	lfs 0,8(9)
	lfs 8,12(31)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 12,12(9)
	stw 11,828(31)
	stfs 0,776(31)
	fsubs 12,12,9
	stw 0,472(31)
	stfs 10,832(31)
	stfs 12,16(1)
	lfs 0,8(10)
	lfs 13,4(10)
	stfs 12,780(31)
	fsubs 0,0,8
	stfs 7,748(31)
	fsubs 13,13,6
	stfs 6,752(31)
	stfs 8,756(31)
	stfs 0,840(31)
	stfs 13,836(31)
	stfs 11,772(31)
	stw 0,480(31)
	stw 0,476(31)
	bl VectorNormalize
	lfs 13,812(31)
	lfs 0,808(31)
	stfs 1,856(31)
	stw 29,864(31)
	fcmpu 0,13,0
	bc 4,2,.L471
	lfs 0,816(31)
	fcmpu 0,13,0
	bc 4,2,.L471
	lwz 0,264(31)
	lis 9,level+312@ha
	lwz 9,level+312@l(9)
	andi. 11,0,1024
	bc 12,2,.L472
	lwz 0,660(31)
	cmpw 0,9,0
	bc 12,2,.L473
	b .L474
.L472:
	cmpw 0,9,31
	bc 4,2,.L474
.L473:
	mr 3,31
	bl Move_Begin
	b .L477
.L474:
	lis 11,level+4@ha
	lis 10,.LC89@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC89@l(10)
	la 9,Move_Begin@l(9)
	stw 9,532(31)
	b .L478
.L471:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,844(31)
	lis 10,level+4@ha
	stw 9,532(31)
	lis 11,.LC89@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC89@l(11)
.L478:
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
.L477:
	lwz 0,284(31)
	ori 0,0,1
	stw 0,284(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe21:
	.size	 train_resume,.Lfe21-train_resume
	.section	".rodata"
	.align 2
.LC90:
	.string	"train_find: no target\n"
	.align 2
.LC91:
	.string	"train_find: target %s not found\n"
	.align 2
.LC94:
	.string	"func_train without a target at %s\n"
	.align 3
.LC93:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC95:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_func_train
	.type	 SP_func_train,@function
SP_func_train:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lis 9,train_blocked@ha
	lwz 10,284(31)
	li 0,0
	la 9,train_blocked@l(9)
	li 11,2
	stw 0,16(31)
	andi. 8,10,4
	stw 11,260(31)
	stw 9,536(31)
	stw 0,24(31)
	stw 0,20(31)
	bc 4,2,.L498
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L492
	li 0,100
.L498:
	stw 0,612(31)
.L492:
	li 0,3
	lis 9,gi@ha
	lwz 4,268(31)
	la 30,gi@l(9)
	stw 0,248(31)
	mr 3,31
	lwz 9,44(30)
	mtlr 9
	blrl
	lis 9,st+36@ha
	lwz 3,st+36@l(9)
	cmpwi 0,3,0
	bc 12,2,.L494
	lwz 9,36(30)
	mtlr 9
	blrl
	stw 3,800(31)
.L494:
	lis 8,.LC95@ha
	lfs 13,424(31)
	la 8,.LC95@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,2,.L495
	lis 0,0x42c8
	stw 0,424(31)
.L495:
	lfs 0,424(31)
	lis 9,train_use@ha
	mr 3,31
	la 9,train_use@l(9)
	stw 9,544(31)
	stfs 0,808(31)
	stfs 0,812(31)
	stfs 0,816(31)
	lwz 9,72(30)
	mtlr 9
	blrl
	lwz 0,392(31)
	cmpwi 0,0,0
	bc 12,2,.L496
	lis 11,level+4@ha
	lis 10,.LC93@ha
	lfs 0,level+4@l(11)
	lis 9,func_train_find@ha
	lfd 13,.LC93@l(10)
	la 9,func_train_find@l(9)
	stw 9,532(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
	b .L497
.L496:
	addi 3,31,212
	bl vtos
	mr 4,3
	lwz 0,4(30)
	lis 3,.LC94@ha
	la 3,.LC94@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L497:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe22:
	.size	 SP_func_train,.Lfe22-SP_func_train
	.section	".rodata"
	.align 2
.LC96:
	.string	"elevator used with no pathtarget\n"
	.align 2
.LC97:
	.string	"elevator used with bad pathtarget: %s\n"
	.align 2
.LC98:
	.string	"trigger_elevator has no target\n"
	.align 2
.LC99:
	.string	"trigger_elevator unable to find target %s\n"
	.align 2
.LC100:
	.string	"func_train"
	.align 2
.LC101:
	.string	"trigger_elevator target %s is not a train\n"
	.align 2
.LC106:
	.string	"func_timer at %s has random >= wait\n"
	.align 3
.LC105:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC107:
	.long 0x46fffe00
	.align 2
.LC108:
	.long 0x0
	.align 3
.LC109:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC110:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC111:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_func_timer
	.type	 SP_func_timer,@function
SP_func_timer:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,.LC108@ha
	mr 31,3
	la 9,.LC108@l(9)
	lfs 0,688(31)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L515
	lis 0,0x3f80
	stw 0,688(31)
.L515:
	lfs 0,696(31)
	lis 9,func_timer_use@ha
	lis 11,func_timer_think@ha
	lfs 13,688(31)
	la 9,func_timer_use@l(9)
	la 11,func_timer_think@l(11)
	stw 9,544(31)
	stw 11,532(31)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L516
	fmr 0,13
	lis 9,.LC105@ha
	lis 29,gi@ha
	lfd 13,.LC105@l(9)
	la 29,gi@l(29)
	addi 3,31,4
	fsub 0,0,13
	frsp 0,0
	stfs 0,696(31)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC106@ha
	la 3,.LC106@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L516:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L517
	bl rand
	rlwinm 3,3,0,17,31
	lfs 8,692(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	lfs 9,688(31)
	stw 3,28(1)
	lis 11,.LC109@ha
	lis 8,.LC107@ha
	la 11,.LC109@l(11)
	stw 0,24(1)
	lis 10,st+40@ha
	lfd 10,0(11)
	lfd 12,24(1)
	lis 11,level+4@ha
	lfs 6,.LC107@l(8)
	lis 9,.LC110@ha
	lfs 13,level+4@l(11)
	la 9,.LC110@l(9)
	fsub 12,12,10
	lfd 0,0(9)
	lfs 11,st+40@l(10)
	lis 9,.LC111@ha
	la 9,.LC111@l(9)
	lfs 10,696(31)
	frsp 12,12
	lfd 7,0(9)
	stw 31,644(31)
	fadd 13,13,0
	fdivs 12,12,6
	fadd 13,13,11
	fmr 0,12
	fadd 13,13,8
	fsub 0,0,7
	fadd 13,13,9
	fadd 0,0,0
	fmadd 0,0,10,13
	frsp 0,0
	stfs 0,524(31)
.L517:
	li 0,1
	stw 0,184(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe23:
	.size	 SP_func_timer,.Lfe23-SP_func_timer
	.section	".rodata"
	.align 3
.LC112:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl door_secret_use
	.type	 door_secret_use,@function
door_secret_use:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lis 4,vec3_origin@ha
	la 4,vec3_origin@l(4)
	addi 3,31,4
	bl VectorCompare
	cmpwi 0,3,0
	bc 12,2,.L525
	lfs 13,4(31)
	li 0,0
	addi 9,31,448
	lfs 0,448(31)
	lis 29,door_secret_move1@ha
	addi 3,31,832
	stw 0,472(31)
	la 29,door_secret_move1@l(29)
	stw 0,480(31)
	fsubs 0,0,13
	stw 0,476(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,832(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,836(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,840(31)
	bl VectorNormalize
	lfs 13,812(31)
	lfs 0,808(31)
	stfs 1,856(31)
	stw 29,864(31)
	fcmpu 0,13,0
	bc 4,2,.L527
	lfs 0,816(31)
	fcmpu 0,13,0
	bc 4,2,.L527
	lwz 0,264(31)
	lis 9,level+312@ha
	lwz 9,level+312@l(9)
	andi. 11,0,1024
	bc 12,2,.L528
	lwz 0,660(31)
	cmpw 0,9,0
	bc 12,2,.L529
	b .L530
.L528:
	cmpw 0,9,31
	bc 4,2,.L530
.L529:
	mr 3,31
	bl Move_Begin
	b .L533
.L530:
	lis 11,level+4@ha
	lis 10,.LC112@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC112@l(10)
	la 9,Move_Begin@l(9)
	stw 9,532(31)
	b .L541
.L527:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,844(31)
	lis 10,level+4@ha
	stw 9,532(31)
	lis 11,.LC112@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC112@l(11)
.L541:
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
.L533:
	lwz 0,392(31)
	li 29,0
	cmpwi 0,0,0
	bc 12,2,.L525
	lis 9,gi@ha
	lis 28,.LC50@ha
	la 30,gi@l(9)
	b .L536
.L538:
	lwz 3,280(29)
	la 4,.LC50@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L536
	lwz 9,64(30)
	li 4,1
	lwz 3,740(29)
	mtlr 9
	blrl
.L536:
	lwz 5,392(31)
	mr 3,29
	li 4,396
	bl G_Find
	mr. 29,3
	bc 4,2,.L538
.L525:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 door_secret_use,.Lfe24-door_secret_use
	.section	".rodata"
	.align 3
.LC113:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl door_secret_move2
	.type	 door_secret_move2,@function
door_secret_move2:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	li 0,0
	lfs 13,4(31)
	addi 9,31,460
	lis 29,door_secret_move3@ha
	lfs 0,460(31)
	la 29,door_secret_move3@l(29)
	addi 3,31,832
	stw 0,472(31)
	stw 0,480(31)
	fsubs 0,0,13
	stw 0,476(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,832(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,836(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,840(31)
	bl VectorNormalize
	lfs 13,812(31)
	lfs 0,808(31)
	stfs 1,856(31)
	stw 29,864(31)
	fcmpu 0,13,0
	bc 4,2,.L544
	lfs 0,816(31)
	fcmpu 0,13,0
	bc 4,2,.L544
	lwz 0,264(31)
	lis 9,level+312@ha
	lwz 9,level+312@l(9)
	andi. 11,0,1024
	bc 12,2,.L545
	lwz 0,660(31)
	cmpw 0,9,0
	bc 12,2,.L546
	b .L547
.L545:
	cmpw 0,9,31
	bc 4,2,.L547
.L546:
	mr 3,31
	bl Move_Begin
	b .L550
.L547:
	lis 11,level+4@ha
	lis 10,.LC113@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC113@l(10)
	la 9,Move_Begin@l(9)
	stw 9,532(31)
	b .L551
.L544:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,844(31)
	lis 10,level+4@ha
	stw 9,532(31)
	lis 11,.LC113@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC113@l(11)
.L551:
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
.L550:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 door_secret_move2,.Lfe25-door_secret_move2
	.section	".rodata"
	.align 3
.LC114:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl door_secret_move4
	.type	 door_secret_move4,@function
door_secret_move4:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	li 0,0
	lfs 13,4(31)
	addi 9,31,448
	lis 29,door_secret_move5@ha
	lfs 0,448(31)
	la 29,door_secret_move5@l(29)
	addi 3,31,832
	stw 0,472(31)
	stw 0,480(31)
	fsubs 0,0,13
	stw 0,476(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,832(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,836(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,840(31)
	bl VectorNormalize
	lfs 13,812(31)
	lfs 0,808(31)
	stfs 1,856(31)
	stw 29,864(31)
	fcmpu 0,13,0
	bc 4,2,.L555
	lfs 0,816(31)
	fcmpu 0,13,0
	bc 4,2,.L555
	lwz 0,264(31)
	lis 9,level+312@ha
	lwz 9,level+312@l(9)
	andi. 11,0,1024
	bc 12,2,.L556
	lwz 0,660(31)
	cmpw 0,9,0
	bc 12,2,.L557
	b .L558
.L556:
	cmpw 0,9,31
	bc 4,2,.L558
.L557:
	mr 3,31
	bl Move_Begin
	b .L561
.L558:
	lis 11,level+4@ha
	lis 10,.LC114@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC114@l(10)
	la 9,Move_Begin@l(9)
	stw 9,532(31)
	b .L562
.L555:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,844(31)
	lis 10,level+4@ha
	stw 9,532(31)
	lis 11,.LC114@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC114@l(11)
.L562:
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
.L561:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 door_secret_move4,.Lfe26-door_secret_move4
	.section	".rodata"
	.align 3
.LC115:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl door_secret_move6
	.type	 door_secret_move6,@function
door_secret_move6:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	li 0,0
	stw 0,472(31)
	lis 9,vec3_origin@ha
	lis 29,door_secret_done@ha
	stw 0,480(31)
	la 11,vec3_origin@l(9)
	la 29,door_secret_done@l(29)
	stw 0,476(31)
	addi 3,31,832
	lfs 13,vec3_origin@l(9)
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,832(31)
	lfs 0,4(11)
	fsubs 0,0,12
	stfs 0,836(31)
	lfs 13,8(11)
	fsubs 13,13,11
	stfs 13,840(31)
	bl VectorNormalize
	lfs 13,812(31)
	lfs 0,808(31)
	stfs 1,856(31)
	stw 29,864(31)
	fcmpu 0,13,0
	bc 4,2,.L565
	lfs 0,816(31)
	fcmpu 0,13,0
	bc 4,2,.L565
	lwz 0,264(31)
	lis 9,level+312@ha
	lwz 9,level+312@l(9)
	andi. 11,0,1024
	bc 12,2,.L566
	lwz 0,660(31)
	cmpw 0,9,0
	bc 12,2,.L567
	b .L568
.L566:
	cmpw 0,9,31
	bc 4,2,.L568
.L567:
	mr 3,31
	bl Move_Begin
	b .L571
.L568:
	lis 11,level+4@ha
	lis 10,.LC115@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC115@l(10)
	la 9,Move_Begin@l(9)
	stw 9,532(31)
	b .L572
.L565:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,844(31)
	lis 10,level+4@ha
	stw 9,532(31)
	lis 11,.LC115@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC115@l(11)
.L572:
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
.L571:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 door_secret_move6,.Lfe27-door_secret_move6
	.section	".rodata"
	.align 2
.LC116:
	.long 0x0
	.align 3
.LC117:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC118:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_func_door_secret
	.type	 SP_func_door_secret,@function
SP_func_door_secret:
	stwu 1,-96(1)
	mflr 0
	stfd 31,88(1)
	stmw 28,72(1)
	stw 0,100(1)
	lis 29,gi@ha
	mr 31,3
	la 29,gi@l(29)
	lis 3,.LC64@ha
	lwz 9,36(29)
	la 3,.LC64@l(3)
	mtlr 9
	blrl
	stw 3,796(31)
	lwz 9,36(29)
	lis 3,.LC65@ha
	la 3,.LC65@l(3)
	mtlr 9
	blrl
	stw 3,800(31)
	lwz 9,36(29)
	lis 3,.LC66@ha
	la 3,.LC66@l(3)
	mtlr 9
	blrl
	li 9,3
	li 0,2
	stw 3,804(31)
	stw 9,248(31)
	mr 3,31
	stw 0,260(31)
	lwz 0,44(29)
	lwz 4,268(31)
	mtlr 0
	blrl
	lwz 0,396(31)
	lis 9,door_secret_blocked@ha
	lis 11,door_secret_use@ha
	la 9,door_secret_blocked@l(9)
	la 11,door_secret_use@l(11)
	cmpwi 0,0,0
	stw 9,536(31)
	stw 11,544(31)
	bc 12,2,.L590
	lwz 0,284(31)
	andi. 7,0,1
	bc 12,2,.L589
.L590:
	lis 9,door_secret_die@ha
	li 11,0
	la 9,door_secret_die@l(9)
	li 0,1
	stw 11,576(31)
	stw 0,608(31)
	stw 9,552(31)
.L589:
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 4,2,.L591
	li 0,2
	stw 0,612(31)
.L591:
	lis 9,.LC116@ha
	lfs 0,688(31)
	la 9,.LC116@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L592
	lis 0,0x40a0
	stw 0,688(31)
.L592:
	lis 0,0x4248
	addi 29,1,24
	addi 28,1,40
	stw 0,808(31)
	addi 4,1,8
	stw 0,812(31)
	addi 3,31,16
	mr 5,29
	stw 0,816(31)
	mr 6,28
	bl AngleVectors
	lwz 11,284(31)
	lis 10,0x4330
	lis 7,.LC117@ha
	mr 8,29
	stfs 31,16(31)
	rlwinm 0,11,0,30,30
	la 7,.LC117@l(7)
	stfs 31,24(31)
	xoris 0,0,0x8000
	lfd 12,0(7)
	mr 4,28
	stw 0,68(1)
	lis 7,.LC118@ha
	stw 10,64(1)
	la 7,.LC118@l(7)
	andi. 0,11,4
	lfd 0,64(1)
	lfd 13,0(7)
	stfs 31,20(31)
	fsub 0,0,12
	fsub 13,13,0
	frsp 7,13
	bc 12,2,.L593
	lfs 0,240(31)
	lfs 12,44(1)
	lfs 10,236(31)
	lfs 13,40(1)
	fmr 8,0
	fmuls 12,12,0
	lfs 11,244(31)
	lfs 0,48(1)
	b .L600
.L593:
	lfs 0,240(31)
	lfs 12,28(1)
	lfs 10,236(31)
	lfs 13,24(1)
	fmr 8,0
	fmuls 12,12,0
	lfs 11,244(31)
	lfs 0,32(1)
.L600:
	fmr 9,10
	fmadds 13,13,10,12
	fmr 10,11
	fmadds 0,0,11,13
	fabs 1,0
	lfs 0,12(1)
	lfs 12,8(1)
	lfs 13,16(1)
	fmuls 0,0,8
	lwz 0,284(31)
	andi. 7,0,4
	fmadds 12,12,9,0
	fmadds 13,13,10,12
	fabs 31,13
	bc 12,2,.L595
	fneg 1,1
	addi 29,31,448
	addi 3,31,4
	b .L601
.L595:
	fmuls 1,7,1
	addi 29,31,448
	addi 3,31,4
	mr 4,8
.L601:
	mr 5,29
	bl VectorMA
	mr 3,29
	fmr 1,31
	addi 4,1,8
	addi 5,31,460
	bl VectorMA
	lwz 11,576(31)
	cmpwi 0,11,0
	bc 12,2,.L597
	lis 9,door_killed@ha
	li 0,1
	stw 11,580(31)
	la 9,door_killed@l(9)
	stw 0,608(31)
	stw 9,552(31)
	b .L598
.L597:
	lwz 0,396(31)
	cmpwi 0,0,0
	bc 12,2,.L598
	lwz 0,276(31)
	cmpwi 0,0,0
	bc 12,2,.L598
	lis 9,gi+36@ha
	lis 3,.LC67@ha
	lwz 0,gi+36@l(9)
	la 3,.LC67@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,540(31)
.L598:
	lis 9,.LC51@ha
	lis 11,gi+72@ha
	la 9,.LC51@l(9)
	mr 3,31
	stw 9,280(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 0,100(1)
	mtlr 0
	lmw 28,72(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe28:
	.size	 SP_func_door_secret,.Lfe28-SP_func_door_secret
	.comm	maplist,292,4
	.align 2
	.globl Move_Done
	.type	 Move_Done,@function
Move_Done:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	li 0,0
	lwz 10,864(9)
	stw 0,472(9)
	mtlr 10
	stw 0,480(9)
	stw 0,476(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 Move_Done,.Lfe29-Move_Done
	.section	".rodata"
	.align 3
.LC119:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC120:
	.long 0x0
	.section	".text"
	.align 2
	.globl Move_Final
	.type	 Move_Final,@function
Move_Final:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stw 31,20(1)
	stw 0,36(1)
	lis 9,.LC120@ha
	mr 31,3
	la 9,.LC120@l(9)
	lfs 1,856(31)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,2,.L8
	lwz 9,864(31)
	stfs 0,472(31)
	mtlr 9
	stfs 0,480(31)
	stfs 0,476(31)
	blrl
	b .L7
.L8:
	lis 9,.LC119@ha
	addi 3,31,832
	lfd 31,.LC119@l(9)
	addi 4,31,472
	fdiv 1,1,31
	frsp 1,1
	bl VectorScale
	lis 9,Move_Done@ha
	lis 11,level+4@ha
	la 9,Move_Done@l(9)
	stw 9,532(31)
	lfs 0,level+4@l(11)
	fadd 0,0,31
	frsp 0,0
	stfs 0,524(31)
.L7:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 Move_Final,.Lfe30-Move_Final
	.section	".rodata"
	.align 3
.LC121:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl Move_Calc
	.type	 Move_Calc,@function
Move_Calc:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	li 0,0
	stw 0,472(31)
	mr 29,5
	addi 3,31,832
	stw 0,480(31)
	stw 0,476(31)
	lfs 13,0(4)
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,832(31)
	lfs 0,4(4)
	fsubs 0,0,12
	stfs 0,836(31)
	lfs 13,8(4)
	fsubs 13,13,11
	stfs 13,840(31)
	bl VectorNormalize
	lfs 13,812(31)
	lfs 0,808(31)
	stfs 1,856(31)
	stw 29,864(31)
	fcmpu 0,13,0
	bc 4,2,.L16
	lfs 0,816(31)
	fcmpu 0,13,0
	bc 4,2,.L16
	lwz 0,264(31)
	lis 9,level+312@ha
	lwz 9,level+312@l(9)
	andi. 11,0,1024
	bc 12,2,.L18
	lwz 0,660(31)
	cmpw 0,9,0
	bc 12,2,.L19
	b .L17
.L18:
	cmpw 0,9,31
	bc 4,2,.L17
.L19:
	mr 3,31
	bl Move_Begin
	b .L21
.L17:
	lis 11,level+4@ha
	lis 10,.LC121@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC121@l(10)
	la 9,Move_Begin@l(9)
	stw 9,532(31)
	b .L604
.L16:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,844(31)
	lis 10,level+4@ha
	stw 9,532(31)
	lis 11,.LC121@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC121@l(11)
.L604:
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
.L21:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe31:
	.size	 Move_Calc,.Lfe31-Move_Calc
	.align 2
	.globl AngleMove_Done
	.type	 AngleMove_Done,@function
AngleMove_Done:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	li 0,0
	lwz 10,864(9)
	stw 0,484(9)
	mtlr 10
	stw 0,492(9)
	stw 0,488(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe32:
	.size	 AngleMove_Done,.Lfe32-AngleMove_Done
	.section	".rodata"
	.align 3
.LC122:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC123:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl AngleMove_Final
	.type	 AngleMove_Final,@function
AngleMove_Final:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,828(31)
	cmpwi 0,0,2
	bc 4,2,.L24
	lfs 11,16(31)
	lfs 13,784(31)
	lfs 12,788(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,792(31)
	b .L605
.L24:
	lfs 11,16(31)
	lfs 13,760(31)
	lfs 12,764(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,768(31)
.L605:
	lfs 11,24(31)
	fsubs 12,12,10
	stfs 13,8(1)
	fsubs 0,0,11
	stfs 12,12(1)
	stfs 0,16(1)
	lis 4,vec3_origin@ha
	addi 3,1,8
	la 4,vec3_origin@l(4)
	bl VectorCompare
	cmpwi 0,3,0
	bc 12,2,.L26
	lwz 9,864(31)
	mr 3,31
	li 0,0
	stw 0,484(31)
	mtlr 9
	stw 0,492(31)
	stw 0,488(31)
	blrl
	b .L23
.L26:
	lis 9,.LC123@ha
	addi 3,1,8
	la 9,.LC123@l(9)
	addi 4,31,484
	lfs 1,0(9)
	bl VectorScale
	lis 9,AngleMove_Done@ha
	lis 10,level+4@ha
	la 9,AngleMove_Done@l(9)
	lis 11,.LC122@ha
	stw 9,532(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC122@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
.L23:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe33:
	.size	 AngleMove_Final,.Lfe33-AngleMove_Final
	.section	".rodata"
	.align 3
.LC124:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl AngleMove_Calc
	.type	 AngleMove_Calc,@function
AngleMove_Calc:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,264(3)
	li 0,0
	lis 11,level+312@ha
	stw 0,484(3)
	andi. 10,9,1024
	stw 4,864(3)
	stw 0,492(3)
	stw 0,488(3)
	lwz 9,level+312@l(11)
	bc 12,2,.L41
	lwz 0,660(3)
	cmpw 0,9,0
	bc 12,2,.L42
	b .L40
.L41:
	cmpw 0,9,3
	bc 4,2,.L40
.L42:
	bl AngleMove_Begin
	b .L43
.L40:
	lis 11,level+4@ha
	lis 10,.LC124@ha
	lfs 0,level+4@l(11)
	lis 9,AngleMove_Begin@ha
	lfd 13,.LC124@l(10)
	la 9,AngleMove_Begin@l(9)
	stw 9,532(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(3)
.L43:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe34:
	.size	 AngleMove_Calc,.Lfe34-AngleMove_Calc
	.section	".rodata"
	.align 2
.LC125:
	.long 0x3f000000
	.align 2
.LC126:
	.long 0x0
	.align 2
.LC127:
	.long 0x3f800000
	.align 2
.LC128:
	.long 0x40800000
	.align 2
.LC129:
	.long 0xc0000000
	.align 3
.LC130:
	.long 0xc0000000
	.long 0x0
	.section	".text"
	.align 2
	.globl plat_CalcAcceleratedMove
	.type	 plat_CalcAcceleratedMove,@function
plat_CalcAcceleratedMove:
	stwu 1,-48(1)
	mflr 0
	stfd 29,24(1)
	stfd 30,32(1)
	stfd 31,40(1)
	stw 31,20(1)
	stw 0,52(1)
	mr 31,3
	lfs 9,108(31)
	lfs 10,60(31)
	lfs 11,64(31)
	fcmpu 0,9,10
	stfs 11,100(31)
	bc 4,0,.L45
	stfs 9,96(31)
	b .L44
.L45:
	fdivs 0,11,10
	lfs 31,68(31)
	lis 9,.LC125@ha
	la 9,.LC125@l(9)
	lfs 30,0(9)
	lis 9,.LC126@ha
	la 9,.LC126@l(9)
	lfs 12,0(9)
	lis 9,.LC127@ha
	la 9,.LC127@l(9)
	lfs 29,0(9)
	fdivs 13,11,31
	fmadds 0,0,11,11
	fmadds 13,13,11,11
	fmuls 0,0,30
	fmuls 1,13,30
	fsubs 0,9,0
	fsubs 0,0,1
	fcmpu 0,0,12
	bc 4,0,.L46
	fmuls 12,10,31
	lis 9,.LC128@ha
	fadds 31,10,31
	la 9,.LC128@l(9)
	lfs 1,0(9)
	lis 9,.LC129@ha
	fdivs 31,31,12
	la 9,.LC129@l(9)
	lfs 13,0(9)
	fmuls 0,31,1
	fmuls 13,9,13
	fmuls 0,0,13
	fsubs 1,1,0
	bl sqrt
	lis 9,.LC130@ha
	fadds 31,31,31
	lfs 13,68(31)
	la 9,.LC130@l(9)
	lfd 0,0(9)
	fadd 1,1,0
	fdiv 1,1,31
	frsp 1,1
	fdivs 13,1,13
	stfs 1,100(31)
	fadds 13,13,29
	fmuls 1,1,13
	fmuls 1,1,30
.L46:
	stfs 1,112(31)
.L44:
	lwz 0,52(1)
	mtlr 0
	lwz 31,20(1)
	lfd 29,24(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe35:
	.size	 plat_CalcAcceleratedMove,.Lfe35-plat_CalcAcceleratedMove
	.section	".rodata"
	.align 2
.LC131:
	.long 0x3f800000
	.align 2
.LC132:
	.long 0x40400000
	.align 2
.LC133:
	.long 0x0
	.section	".text"
	.align 2
	.globl plat_hit_top
	.type	 plat_hit_top,@function
plat_hit_top:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,264(31)
	andi. 30,0,1024
	bc 4,2,.L68
	lwz 5,804(31)
	cmpwi 0,5,0
	bc 12,2,.L69
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC131@ha
	la 9,.LC131@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC132@ha
	la 9,.LC132@l(9)
	lfs 2,0(9)
	lis 9,.LC133@ha
	la 9,.LC133@l(9)
	lfs 3,0(9)
	blrl
.L69:
	stw 30,76(31)
.L68:
	lis 9,plat_go_down@ha
	li 0,0
	la 9,plat_go_down@l(9)
	stw 0,828(31)
	lis 11,level+4@ha
	stw 9,532(31)
	lis 9,.LC132@ha
	lfs 0,level+4@l(11)
	la 9,.LC132@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,524(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe36:
	.size	 plat_hit_top,.Lfe36-plat_hit_top
	.section	".rodata"
	.align 2
.LC134:
	.long 0x3f800000
	.align 2
.LC135:
	.long 0x40400000
	.align 2
.LC136:
	.long 0x0
	.section	".text"
	.align 2
	.globl plat_hit_bottom
	.type	 plat_hit_bottom,@function
plat_hit_bottom:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,264(31)
	andi. 30,0,1024
	bc 4,2,.L71
	lwz 5,804(31)
	cmpwi 0,5,0
	bc 12,2,.L72
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC134@ha
	la 9,.LC134@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC135@ha
	la 9,.LC135@l(9)
	lfs 2,0(9)
	lis 9,.LC136@ha
	la 9,.LC136@l(9)
	lfs 3,0(9)
	blrl
.L72:
	stw 30,76(31)
.L71:
	li 0,1
	stw 0,828(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe37:
	.size	 plat_hit_bottom,.Lfe37-plat_hit_bottom
	.align 2
	.globl plat_blocked
	.type	 plat_blocked,@function
plat_blocked:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,4
	mr 30,3
	lwz 0,184(31)
	andi. 9,0,4
	bc 4,2,.L96
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L96
	stw 0,8(1)
	lis 6,vec3_origin@ha
	mr 4,30
	la 6,vec3_origin@l(6)
	li 0,20
	lis 9,0x1
	stw 0,12(1)
	mr 3,31
	mr 5,4
	addi 7,31,4
	mr 8,6
	ori 9,9,34464
	li 10,1
	bl T_Damage
	cmpwi 0,31,0
	bc 12,2,.L95
	mr 3,31
	bl BecomeExplosion1
	b .L95
.L96:
	lis 6,vec3_origin@ha
	lwz 9,612(30)
	li 0,0
	mr 3,31
	la 6,vec3_origin@l(6)
	stw 0,8(1)
	li 11,20
	mr 4,30
	stw 11,12(1)
	mr 5,30
	addi 7,3,4
	mr 8,6
	li 10,1
	bl T_Damage
	lwz 0,828(30)
	cmpwi 0,0,2
	bc 4,2,.L98
	mr 3,30
	bl plat_go_down
	b .L95
.L98:
	cmpwi 0,0,3
	bc 4,2,.L95
	mr 3,30
	bl plat_go_up
.L95:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe38:
	.size	 plat_blocked,.Lfe38-plat_blocked
	.align 2
	.globl Use_Plat
	.type	 Use_Plat,@function
Use_Plat:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,532(3)
	cmpwi 0,0,0
	bc 4,2,.L101
	bl plat_go_down
.L101:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe39:
	.size	 Use_Plat,.Lfe39-Use_Plat
	.align 2
	.globl Touch_Plat_Center
	.type	 Touch_Plat_Center,@function
Touch_Plat_Center:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,184(4)
	lwz 9,84(4)
	xori 0,0,4
	rlwinm 0,0,30,31,31
	subfic 11,9,0
	adde 9,11,9
	and. 11,9,0
	bc 4,2,.L103
	lwz 0,576(4)
	cmpwi 0,0,0
	bc 4,1,.L103
	lwz 3,636(3)
	lwz 0,828(3)
	cmpwi 0,0,1
	bc 4,2,.L103
	bl plat_go_up
.L103:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe40:
	.size	 Touch_Plat_Center,.Lfe40-Touch_Plat_Center
	.align 2
	.globl rotating_blocked
	.type	 rotating_blocked,@function
rotating_blocked:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 11,3
	lis 6,vec3_origin@ha
	mr 3,4
	lwz 9,612(11)
	la 6,vec3_origin@l(6)
	mr 4,11
	li 0,0
	li 11,20
	stw 0,8(1)
	mr 5,4
	stw 11,12(1)
	addi 7,3,4
	mr 8,6
	li 10,1
	bl T_Damage
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe41:
	.size	 rotating_blocked,.Lfe41-rotating_blocked
	.section	".rodata"
	.align 2
.LC137:
	.long 0x0
	.section	".text"
	.align 2
	.globl rotating_touch
	.type	 rotating_touch,@function
rotating_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC137@ha
	mr 11,3
	la 9,.LC137@l(9)
	lfs 0,484(11)
	mr 3,4
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L130
	lfs 0,488(11)
	fcmpu 0,0,13
	bc 4,2,.L130
	lfs 0,492(11)
	fcmpu 0,0,13
	bc 12,2,.L129
.L130:
	lwz 9,612(11)
	mr 4,11
	lis 6,vec3_origin@ha
	la 6,vec3_origin@l(6)
	li 0,0
	li 11,20
	stw 0,8(1)
	mr 5,4
	stw 11,12(1)
	addi 7,3,4
	mr 8,6
	li 10,1
	bl T_Damage
.L129:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe42:
	.size	 rotating_touch,.Lfe42-rotating_touch
	.align 2
	.globl rotating_use
	.type	 rotating_use,@function
rotating_use:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lis 4,vec3_origin@ha
	addi 30,31,484
	la 4,vec3_origin@l(4)
	mr 3,30
	bl VectorCompare
	mr. 3,3
	bc 4,2,.L132
	li 0,0
	stw 3,540(31)
	stw 0,484(31)
	stw 3,76(31)
	stw 0,492(31)
	stw 0,488(31)
	b .L133
.L132:
	lwz 0,800(31)
	mr 4,30
	addi 3,31,436
	lfs 1,424(31)
	stw 0,76(31)
	bl VectorScale
	lwz 0,284(31)
	andi. 9,0,16
	bc 12,2,.L133
	lis 9,rotating_touch@ha
	la 9,rotating_touch@l(9)
	stw 9,540(31)
.L133:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe43:
	.size	 rotating_use,.Lfe43-rotating_use
	.align 2
	.globl button_done
	.type	 button_done,@function
button_done:
	lwz 0,64(3)
	li 9,1
	stw 9,828(3)
	rlwinm 0,0,0,21,19
	ori 0,0,1024
	stw 0,64(3)
	blr
.Lfe44:
	.size	 button_done,.Lfe44-button_done
	.section	".rodata"
	.align 2
.LC138:
	.long 0x0
	.section	".text"
	.align 2
	.globl button_wait
	.type	 button_wait,@function
button_wait:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	li 9,0
	lwz 0,64(31)
	lwz 4,644(31)
	rlwinm 0,0,0,22,20
	stw 9,828(31)
	ori 0,0,2048
	stw 0,64(31)
	bl G_UseTargets
	lis 9,.LC138@ha
	lfs 13,824(31)
	li 0,1
	la 9,.LC138@l(9)
	stw 0,56(31)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L161
	lis 9,level+4@ha
	lis 11,button_return@ha
	lfs 0,level+4@l(9)
	la 11,button_return@l(11)
	stw 11,532(31)
	fadds 0,0,13
	stfs 0,524(31)
.L161:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe45:
	.size	 button_wait,.Lfe45-button_wait
	.align 2
	.globl button_use
	.type	 button_use,@function
button_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	stw 5,644(3)
	bl button_fire
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe46:
	.size	 button_use,.Lfe46-button_use
	.align 2
	.globl button_touch
	.type	 button_touch,@function
button_touch:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,4
	mr 30,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L174
	lwz 0,576(31)
	cmpwi 0,0,0
	bc 4,1,.L174
	lwz 0,316(30)
	cmpwi 0,0,0
	bc 12,2,.L177
	lis 3,.LC46@ha
	la 3,.LC46@l(3)
	bl centerprint_all
	lwz 4,84(31)
	cmpwi 0,4,0
	bc 12,2,.L178
	lwz 9,316(30)
	lwz 0,3448(4)
	add 0,0,9
	stw 0,3448(4)
.L178:
	bl EndDMLevel
	b .L174
.L177:
	stw 31,644(30)
	mr 3,30
	bl button_fire
.L174:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe47:
	.size	 button_touch,.Lfe47-button_touch
	.align 2
	.globl button_killed
	.type	 button_killed,@function
button_killed:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,5
	lwz 0,316(31)
	li 9,0
	lwz 11,580(31)
	cmpwi 0,0,0
	stw 9,608(31)
	stw 11,576(31)
	stw 30,644(31)
	bc 12,2,.L180
	lis 3,.LC46@ha
	la 3,.LC46@l(3)
	bl centerprint_all
	lwz 5,84(30)
	cmpwi 0,5,0
	bc 12,2,.L181
	lwz 9,316(31)
	lwz 0,3448(5)
	add 0,0,9
	stw 0,3448(5)
.L181:
	bl EndDMLevel
	b .L179
.L180:
	mr 3,31
	bl button_fire
.L179:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe48:
	.size	 button_killed,.Lfe48-button_killed
	.align 2
	.globl door_use_areaportals
	.type	 door_use_areaportals,@function
door_use_areaportals:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 30,3
	mr 29,4
	lwz 0,392(30)
	li 31,0
	cmpwi 0,0,0
	bc 12,2,.L192
	lis 9,gi@ha
	lis 27,.LC50@ha
	la 28,gi@l(9)
	b .L194
.L196:
	lwz 3,280(31)
	la 4,.LC50@l(27)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L194
	lwz 9,64(28)
	mr 4,29
	lwz 3,740(31)
	mtlr 9
	blrl
.L194:
	lwz 5,392(30)
	mr 3,31
	li 4,396
	bl G_Find
	mr. 31,3
	bc 4,2,.L196
.L192:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe49:
	.size	 door_use_areaportals,.Lfe49-door_use_areaportals
	.section	".rodata"
	.align 2
.LC139:
	.long 0x3f800000
	.align 2
.LC140:
	.long 0x40400000
	.align 2
.LC141:
	.long 0x0
	.section	".text"
	.align 2
	.globl door_hit_top
	.type	 door_hit_top,@function
door_hit_top:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,264(31)
	andi. 30,0,1024
	bc 4,2,.L200
	lwz 5,804(31)
	cmpwi 0,5,0
	bc 12,2,.L201
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC139@ha
	la 9,.LC139@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC140@ha
	la 9,.LC140@l(9)
	lfs 2,0(9)
	lis 9,.LC141@ha
	la 9,.LC141@l(9)
	lfs 3,0(9)
	blrl
.L201:
	stw 30,76(31)
.L200:
	li 0,0
	lwz 9,284(31)
	stw 0,828(31)
	andi. 0,9,32
	bc 4,2,.L199
	lis 9,.LC141@ha
	lfs 13,824(31)
	la 9,.LC141@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L199
	lis 9,door_go_down@ha
	lis 11,level+4@ha
	la 9,door_go_down@l(9)
	stw 9,532(31)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	stfs 0,524(31)
.L199:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe50:
	.size	 door_hit_top,.Lfe50-door_hit_top
	.section	".rodata"
	.align 2
.LC142:
	.long 0x3f800000
	.align 2
.LC143:
	.long 0x40400000
	.align 2
.LC144:
	.long 0x0
	.section	".text"
	.align 2
	.globl door_hit_bottom
	.type	 door_hit_bottom,@function
door_hit_bottom:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,264(31)
	andi. 30,0,1024
	bc 4,2,.L205
	lwz 5,804(31)
	cmpwi 0,5,0
	bc 12,2,.L206
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC142@ha
	la 9,.LC142@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC143@ha
	la 9,.LC143@l(9)
	lfs 2,0(9)
	lis 9,.LC144@ha
	la 9,.LC144@l(9)
	lfs 3,0(9)
	blrl
.L206:
	stw 30,76(31)
.L205:
	lwz 9,392(31)
	li 0,1
	li 30,0
	stw 0,828(31)
	cmpwi 0,9,0
	bc 12,2,.L208
	lis 9,gi@ha
	lis 28,.LC50@ha
	la 29,gi@l(9)
	b .L209
.L211:
	lwz 3,280(30)
	la 4,.LC50@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L209
	lwz 9,64(29)
	li 4,0
	lwz 3,740(30)
	mtlr 9
	blrl
.L209:
	lwz 5,392(31)
	mr 3,30
	li 4,396
	bl G_Find
	mr. 30,3
	bc 4,2,.L211
.L208:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe51:
	.size	 door_hit_bottom,.Lfe51-door_hit_bottom
	.align 2
	.globl door_use
	.type	 door_use,@function
door_use:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lwz 0,264(3)
	mr 29,5
	andi. 9,0,1024
	bc 4,2,.L265
	lwz 0,284(3)
	andi. 11,0,32
	bc 12,2,.L267
	lwz 0,828(3)
	subfic 11,0,0
	adde 9,11,0
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L267
	mr. 31,3
	bc 12,2,.L265
	li 30,0
.L272:
	stw 30,276(31)
	mr 3,31
	stw 30,540(31)
	bl door_go_down
	lwz 31,656(31)
	cmpwi 0,31,0
	bc 4,2,.L272
	b .L265
.L267:
	mr. 31,3
	bc 12,2,.L265
	li 30,0
.L277:
	stw 30,276(31)
	mr 3,31
	mr 4,29
	stw 30,540(31)
	bl door_go_up
	lwz 31,656(31)
	cmpwi 0,31,0
	bc 4,2,.L277
.L265:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe52:
	.size	 door_use,.Lfe52-door_use
	.section	".rodata"
	.align 3
.LC145:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Touch_DoorTrigger
	.type	 Touch_DoorTrigger,@function
Touch_DoorTrigger:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,4
	lwz 0,576(29)
	cmpwi 0,0,0
	bc 4,1,.L279
	lwz 0,184(29)
	andi. 9,0,4
	mcrf 7,0
	bc 4,30,.L281
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L279
.L281:
	lwz 11,256(3)
	lwz 0,284(11)
	andi. 10,0,8
	bc 12,2,.L282
	bc 4,30,.L279
.L282:
	lis 9,level+4@ha
	lfs 0,556(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L279
	lis 9,.LC145@ha
	fmr 0,13
	la 9,.LC145@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,556(3)
	lwz 0,264(11)
	andi. 10,0,1024
	bc 4,2,.L279
	lwz 0,284(11)
	andi. 9,0,32
	bc 12,2,.L286
	lwz 0,828(11)
	subfic 10,0,0
	adde 9,10,0
	xori 0,0,2
	subfic 10,0,0
	adde 0,10,0
	or. 10,0,9
	bc 12,2,.L286
	mr. 31,11
	bc 12,2,.L279
	li 30,0
.L290:
	stw 30,276(31)
	mr 3,31
	stw 30,540(31)
	bl door_go_down
	lwz 31,656(31)
	cmpwi 0,31,0
	bc 4,2,.L290
	b .L279
.L286:
	mr. 31,11
	bc 12,2,.L279
	li 30,0
.L295:
	stw 30,276(31)
	mr 3,31
	mr 4,29
	stw 30,540(31)
	bl door_go_up
	lwz 31,656(31)
	cmpwi 0,31,0
	bc 4,2,.L295
.L279:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe53:
	.size	 Touch_DoorTrigger,.Lfe53-Touch_DoorTrigger
	.align 2
	.globl Think_CalcMoveSpeed
	.type	 Think_CalcMoveSpeed,@function
Think_CalcMoveSpeed:
	lwz 0,264(3)
	andi. 9,0,1024
	bclr 4,2
	lwz 9,656(3)
	lfs 0,820(3)
	cmpwi 0,9,0
	lfs 12,812(3)
	fabs 13,0
	bc 12,2,.L301
.L303:
	lfs 0,820(9)
	fabs 0,0
	fcmpu 0,0,13
	bc 4,0,.L302
	fmr 13,0
.L302:
	lwz 9,656(9)
	cmpwi 0,9,0
	bc 4,2,.L303
.L301:
	mr. 9,3
	fdivs 0,13,12
	bclr 12,2
	fmr 9,0
.L309:
	lfs 0,820(9)
	lfs 13,812(9)
	lfs 11,808(9)
	fcmpu 0,11,13
	fabs 0,0
	fdiv 0,0,9
	frsp 12,0
	fdivs 10,12,13
	bc 4,2,.L310
	stfs 12,808(9)
	b .L311
.L310:
	fmuls 0,11,10
	stfs 0,808(9)
.L311:
	lfs 13,816(9)
	lfs 0,812(9)
	fcmpu 0,13,0
	bc 4,2,.L312
	stfs 12,816(9)
	b .L313
.L312:
	fmuls 0,13,10
	stfs 0,816(9)
.L313:
	stfs 12,812(9)
	lwz 9,656(9)
	cmpwi 0,9,0
	bc 4,2,.L309
	blr
.Lfe54:
	.size	 Think_CalcMoveSpeed,.Lfe54-Think_CalcMoveSpeed
	.section	".rodata"
	.align 2
.LC146:
	.long 0x0
	.section	".text"
	.align 2
	.globl door_blocked
	.type	 door_blocked,@function
door_blocked:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,4
	mr 30,3
	lwz 0,184(31)
	andi. 9,0,4
	bc 4,2,.L348
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L348
	stw 0,8(1)
	lis 6,vec3_origin@ha
	mr 4,30
	la 6,vec3_origin@l(6)
	li 0,20
	lis 9,0x1
	stw 0,12(1)
	mr 3,31
	mr 5,4
	addi 7,31,4
	mr 8,6
	ori 9,9,34464
	li 10,1
	bl T_Damage
	cmpwi 0,31,0
	bc 12,2,.L347
	mr 3,31
	bl BecomeExplosion1
	b .L347
.L348:
	lis 6,vec3_origin@ha
	lwz 9,612(30)
	li 0,0
	mr 3,31
	la 6,vec3_origin@l(6)
	stw 0,8(1)
	li 11,20
	mr 4,30
	stw 11,12(1)
	mr 5,30
	addi 7,3,4
	mr 8,6
	li 10,1
	bl T_Damage
	lwz 0,284(30)
	andi. 9,0,4
	bc 4,2,.L347
	lis 9,.LC146@ha
	lfs 13,824(30)
	la 9,.LC146@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L347
	lwz 0,828(30)
	cmpwi 0,0,3
	bc 4,2,.L352
	lwz 31,660(30)
	cmpwi 0,31,0
	bc 12,2,.L347
.L356:
	lwz 4,644(31)
	mr 3,31
	bl door_go_up
	lwz 31,656(31)
	cmpwi 0,31,0
	bc 4,2,.L356
	b .L347
.L352:
	lwz 31,660(30)
	cmpwi 0,31,0
	bc 12,2,.L347
.L362:
	mr 3,31
	bl door_go_down
	lwz 31,656(31)
	cmpwi 0,31,0
	bc 4,2,.L362
.L347:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe55:
	.size	 door_blocked,.Lfe55-door_blocked
	.align 2
	.globl door_killed
	.type	 door_killed,@function
door_killed:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lwz 9,660(3)
	mr 29,5
	cmpwi 0,9,0
	bc 12,2,.L366
	li 11,0
.L368:
	lwz 0,580(9)
	stw 11,608(9)
	stw 0,576(9)
	lwz 9,656(9)
	cmpwi 0,9,0
	bc 4,2,.L368
.L366:
	lwz 3,660(3)
	lwz 0,264(3)
	andi. 9,0,1024
	bc 4,2,.L371
	lwz 0,284(3)
	andi. 11,0,32
	bc 12,2,.L372
	lwz 0,828(3)
	subfic 11,0,0
	adde 9,11,0
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L372
	mr. 31,3
	bc 12,2,.L371
	li 30,0
.L376:
	stw 30,276(31)
	mr 3,31
	stw 30,540(31)
	bl door_go_down
	lwz 31,656(31)
	cmpwi 0,31,0
	bc 4,2,.L376
	b .L371
.L372:
	mr. 31,3
	bc 12,2,.L371
	li 30,0
.L381:
	stw 30,276(31)
	mr 3,31
	mr 4,29
	stw 30,540(31)
	bl door_go_up
	lwz 31,656(31)
	cmpwi 0,31,0
	bc 4,2,.L381
.L371:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe56:
	.size	 door_killed,.Lfe56-door_killed
	.section	".rodata"
	.align 3
.LC147:
	.long 0x40140000
	.long 0x0
	.align 2
.LC148:
	.long 0x3f800000
	.align 2
.LC149:
	.long 0x0
	.section	".text"
	.align 2
	.globl door_touch
	.type	 door_touch,@function
door_touch:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,4
	mr 11,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L384
	lis 9,level+4@ha
	lfs 0,556(11)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L384
	lis 9,.LC147@ha
	fmr 0,13
	lis 29,gi@ha
	lwz 5,276(11)
	la 9,.LC147@l(9)
	la 29,gi@l(29)
	lfd 13,0(9)
	lis 4,.LC62@ha
	mr 3,31
	la 4,.LC62@l(4)
	fadd 0,0,13
	frsp 0,0
	stfs 0,556(11)
	lwz 9,12(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC63@ha
	la 3,.LC63@l(3)
	mtlr 9
	blrl
	lis 9,.LC148@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC148@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC148@ha
	la 9,.LC148@l(9)
	lfs 2,0(9)
	lis 9,.LC149@ha
	la 9,.LC149@l(9)
	lfs 3,0(9)
	blrl
.L384:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe57:
	.size	 door_touch,.Lfe57-door_touch
	.section	".rodata"
	.align 3
.LC150:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl train_blocked
	.type	 train_blocked,@function
train_blocked:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,4
	mr 12,3
	lwz 0,184(31)
	andi. 9,0,4
	bc 4,2,.L440
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L440
	stw 0,8(1)
	lis 6,vec3_origin@ha
	mr 4,12
	la 6,vec3_origin@l(6)
	li 0,20
	lis 9,0x1
	stw 0,12(1)
	mr 3,31
	mr 5,4
	addi 7,31,4
	mr 8,6
	ori 9,9,34464
	li 10,1
	bl T_Damage
	cmpwi 0,31,0
	bc 12,2,.L439
	mr 3,31
	bl BecomeExplosion1
	b .L439
.L440:
	lis 9,level+4@ha
	lfs 0,556(12)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L439
	lwz 9,612(12)
	cmpwi 0,9,0
	bc 12,2,.L439
	lis 11,.LC150@ha
	fmr 0,13
	lis 6,vec3_origin@ha
	la 11,.LC150@l(11)
	li 0,0
	lfd 13,0(11)
	mr 3,31
	mr 4,12
	li 11,20
	la 6,vec3_origin@l(6)
	stw 0,8(1)
	stw 11,12(1)
	mr 5,4
	addi 7,3,4
	fadd 0,0,13
	mr 8,6
	li 10,1
	frsp 0,0
	stfs 0,556(12)
	bl T_Damage
.L439:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe58:
	.size	 train_blocked,.Lfe58-train_blocked
	.section	".rodata"
	.align 3
.LC151:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl func_train_find
	.type	 func_train_find,@function
func_train_find:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 3,392(31)
	cmpwi 0,3,0
	bc 4,2,.L480
	lis 9,gi+4@ha
	lis 3,.LC90@ha
	lwz 0,gi+4@l(9)
	la 3,.LC90@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L479
.L480:
	bl G_PickTarget
	mr. 11,3
	bc 4,2,.L481
	lis 9,gi+4@ha
	lis 3,.LC91@ha
	lwz 4,392(31)
	lwz 0,gi+4@l(9)
	la 3,.LC91@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L479
.L481:
	lwz 0,392(11)
	lis 9,gi+72@ha
	mr 3,31
	lfs 0,188(31)
	stw 0,392(31)
	lfs 13,4(11)
	lfs 12,192(31)
	lfs 11,196(31)
	fsubs 13,13,0
	stfs 13,4(31)
	lfs 0,8(11)
	fsubs 0,0,12
	stfs 0,8(31)
	lfs 13,12(11)
	fsubs 13,13,11
	stfs 13,12(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,396(31)
	cmpwi 0,0,0
	bc 4,2,.L482
	lwz 0,284(31)
	ori 0,0,1
	stw 0,284(31)
.L482:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L479
	lis 11,level+4@ha
	lis 10,.LC151@ha
	lfs 0,level+4@l(11)
	lis 9,train_next@ha
	lfd 13,.LC151@l(10)
	la 9,train_next@l(9)
	stw 9,532(31)
	stw 31,644(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(31)
.L479:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe59:
	.size	 func_train_find,.Lfe59-func_train_find
	.align 2
	.globl train_use
	.type	 train_use,@function
train_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,284(3)
	stw 5,644(3)
	andi. 0,9,1
	bc 12,2,.L485
	andi. 0,9,2
	bc 12,2,.L484
	li 0,0
	rlwinm 9,9,0,0,30
	stw 0,524(3)
	stw 9,284(3)
	stw 0,480(3)
	stw 0,476(3)
	stw 0,472(3)
	b .L484
.L485:
	lwz 0,420(3)
	cmpwi 0,0,0
	bc 12,2,.L488
	bl train_resume
	b .L484
.L488:
	bl train_next
.L484:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe60:
	.size	 train_use,.Lfe60-train_use
	.section	".rodata"
	.align 2
.LC152:
	.long 0x0
	.section	".text"
	.align 2
	.globl trigger_elevator_use
	.type	 trigger_elevator_use,@function
trigger_elevator_use:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,.LC152@ha
	mr 31,3
	la 9,.LC152@l(9)
	mr 30,4
	lfs 13,0(9)
	lwz 9,512(31)
	lfs 0,524(9)
	fcmpu 0,0,13
	bc 4,2,.L499
	lwz 3,408(30)
	cmpwi 0,3,0
	bc 4,2,.L501
	lis 9,gi+4@ha
	lis 3,.LC96@ha
	lwz 0,gi+4@l(9)
	la 3,.LC96@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L499
.L501:
	bl G_PickTarget
	mr. 3,3
	bc 4,2,.L502
	lis 9,gi+4@ha
	lis 3,.LC97@ha
	lwz 4,408(30)
	lwz 0,gi+4@l(9)
	la 3,.LC97@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L499
.L502:
	lwz 9,512(31)
	stw 3,420(9)
	lwz 3,512(31)
	bl train_resume
.L499:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe61:
	.size	 trigger_elevator_use,.Lfe61-trigger_elevator_use
	.align 2
	.globl trigger_elevator_init
	.type	 trigger_elevator_init,@function
trigger_elevator_init:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 3,392(31)
	cmpwi 0,3,0
	bc 4,2,.L504
	lis 9,gi+4@ha
	lis 3,.LC98@ha
	lwz 0,gi+4@l(9)
	la 3,.LC98@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L503
.L504:
	bl G_PickTarget
	cmpwi 0,3,0
	stw 3,512(31)
	bc 4,2,.L505
	lis 9,gi+4@ha
	lis 3,.LC99@ha
	lwz 4,392(31)
	lwz 0,gi+4@l(9)
	la 3,.LC99@l(3)
	b .L606
.L505:
	lwz 3,280(3)
	lis 4,.LC100@ha
	la 4,.LC100@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L506
	lis 9,gi+4@ha
	lis 3,.LC101@ha
	lwz 4,392(31)
	lwz 0,gi+4@l(9)
	la 3,.LC101@l(3)
.L606:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L503
.L506:
	lis 9,trigger_elevator_use@ha
	li 0,1
	la 9,trigger_elevator_use@l(9)
	stw 0,184(31)
	stw 9,544(31)
.L503:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe62:
	.size	 trigger_elevator_init,.Lfe62-trigger_elevator_init
	.section	".rodata"
	.align 3
.LC153:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_trigger_elevator
	.type	 SP_trigger_elevator,@function
SP_trigger_elevator:
	lis 9,trigger_elevator_init@ha
	lis 10,level+4@ha
	la 9,trigger_elevator_init@l(9)
	lis 11,.LC153@ha
	stw 9,532(3)
	lfs 0,level+4@l(10)
	lfd 13,.LC153@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(3)
	blr
.Lfe63:
	.size	 SP_trigger_elevator,.Lfe63-SP_trigger_elevator
	.section	".rodata"
	.align 2
.LC154:
	.long 0x46fffe00
	.align 3
.LC155:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC156:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl func_timer_think
	.type	 func_timer_think,@function
func_timer_think:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,3
	lwz 4,644(29)
	bl G_UseTargets
	bl rand
	rlwinm 3,3,0,17,31
	lfs 8,688(29)
	xoris 3,3,0x8000
	lis 0,0x4330
	lfs 11,696(29)
	stw 3,28(1)
	lis 8,.LC155@ha
	lis 10,.LC154@ha
	la 8,.LC155@l(8)
	stw 0,24(1)
	lis 11,level+4@ha
	lfd 0,0(8)
	lfd 13,24(1)
	lis 8,.LC156@ha
	lfs 9,.LC154@l(10)
	la 8,.LC156@l(8)
	lfs 12,level+4@l(11)
	fsub 13,13,0
	lfd 10,0(8)
	fadds 12,12,8
	frsp 13,13
	fdivs 13,13,9
	fmr 0,13
	fsub 0,0,10
	fadd 0,0,0
	fmadd 0,0,11,12
	frsp 0,0
	stfs 0,524(29)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe64:
	.size	 func_timer_think,.Lfe64-func_timer_think
	.section	".rodata"
	.align 2
.LC157:
	.long 0x46fffe00
	.align 2
.LC158:
	.long 0x0
	.align 3
.LC159:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC160:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl func_timer_use
	.type	 func_timer_use,@function
func_timer_use:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 8,.LC158@ha
	mr 31,3
	la 8,.LC158@l(8)
	lfs 0,524(31)
	mr 4,5
	lfs 12,0(8)
	stw 4,644(31)
	fcmpu 0,0,12
	bc 12,2,.L510
	stfs 12,524(31)
	b .L509
.L510:
	lfs 13,692(31)
	fcmpu 0,13,12
	bc 12,2,.L511
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,13
	b .L607
.L511:
	mr 3,31
	bl G_UseTargets
	bl rand
	rlwinm 3,3,0,17,31
	lfs 8,688(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	lfs 11,696(31)
	stw 3,20(1)
	lis 8,.LC159@ha
	lis 10,.LC157@ha
	la 8,.LC159@l(8)
	stw 0,16(1)
	lis 11,level+4@ha
	lfd 0,0(8)
	lfd 13,16(1)
	lis 8,.LC160@ha
	lfs 9,.LC157@l(10)
	la 8,.LC160@l(8)
	lfs 12,level+4@l(11)
	fsub 13,13,0
	lfd 10,0(8)
	fadds 12,12,8
	frsp 13,13
	fdivs 13,13,9
	fmr 0,13
	fsub 0,0,10
	fadd 0,0,0
	fmadd 0,0,11,12
	frsp 0,0
.L607:
	stfs 0,524(31)
.L509:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe65:
	.size	 func_timer_use,.Lfe65-func_timer_use
	.section	".rodata"
	.align 3
.LC161:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl func_conveyor_use
	.type	 func_conveyor_use,@function
func_conveyor_use:
	stwu 1,-16(1)
	lwz 11,284(3)
	andi. 0,11,1
	bc 12,2,.L519
	li 0,0
	rlwinm 9,11,0,0,30
	stw 0,424(3)
	stw 9,284(3)
	b .L520
.L519:
	lwz 0,628(3)
	lis 10,0x4330
	lis 8,.LC161@ha
	ori 11,11,1
	xoris 0,0,0x8000
	la 8,.LC161@l(8)
	stw 11,284(3)
	stw 0,12(1)
	stw 10,8(1)
	lfd 13,0(8)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,424(3)
.L520:
	lwz 0,284(3)
	andi. 0,0,2
	bc 4,2,.L521
	stw 0,628(3)
.L521:
	la 1,16(1)
	blr
.Lfe66:
	.size	 func_conveyor_use,.Lfe66-func_conveyor_use
	.section	".rodata"
	.align 2
.LC162:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_func_conveyor
	.type	 SP_func_conveyor,@function
SP_func_conveyor:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,.LC162@ha
	mr 31,3
	la 9,.LC162@l(9)
	lfs 0,424(31)
	lfs 12,0(9)
	fcmpu 0,0,12
	bc 4,2,.L523
	lis 0,0x42c8
	stw 0,424(31)
.L523:
	lwz 0,284(31)
	andi. 9,0,1
	bc 4,2,.L524
	lfs 0,424(31)
	stfs 12,424(31)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	stw 9,628(31)
.L524:
	lis 9,func_conveyor_use@ha
	lis 29,gi@ha
	lwz 4,268(31)
	la 9,func_conveyor_use@l(9)
	la 29,gi@l(29)
	stw 9,544(31)
	mr 3,31
	lwz 9,44(29)
	mtlr 9
	blrl
	li 0,3
	mr 3,31
	stw 0,248(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe67:
	.size	 SP_func_conveyor,.Lfe67-SP_func_conveyor
	.section	".rodata"
	.align 3
.LC163:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl door_secret_move1
	.type	 door_secret_move1,@function
door_secret_move1:
	lis 11,level+4@ha
	lis 9,.LC163@ha
	lfs 0,level+4@l(11)
	la 9,.LC163@l(9)
	lfd 13,0(9)
	lis 9,door_secret_move2@ha
	la 9,door_secret_move2@l(9)
	stw 9,532(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(3)
	blr
.Lfe68:
	.size	 door_secret_move1,.Lfe68-door_secret_move1
	.section	".rodata"
	.align 2
.LC164:
	.long 0xbf800000
	.section	".text"
	.align 2
	.globl door_secret_move3
	.type	 door_secret_move3,@function
door_secret_move3:
	lis 9,.LC164@ha
	lfs 13,688(3)
	la 9,.LC164@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bclr 12,2
	lis 9,level+4@ha
	lis 11,door_secret_move4@ha
	lfs 0,level+4@l(9)
	la 11,door_secret_move4@l(11)
	stw 11,532(3)
	fadds 0,0,13
	stfs 0,524(3)
	blr
.Lfe69:
	.size	 door_secret_move3,.Lfe69-door_secret_move3
	.section	".rodata"
	.align 3
.LC165:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl door_secret_move5
	.type	 door_secret_move5,@function
door_secret_move5:
	lis 11,level+4@ha
	lis 9,.LC165@ha
	lfs 0,level+4@l(11)
	la 9,.LC165@l(9)
	lfd 13,0(9)
	lis 9,door_secret_move6@ha
	la 9,door_secret_move6@l(9)
	stw 9,532(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(3)
	blr
.Lfe70:
	.size	 door_secret_move5,.Lfe70-door_secret_move5
	.align 2
	.globl door_secret_done
	.type	 door_secret_done,@function
door_secret_done:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,396(31)
	cmpwi 0,0,0
	bc 12,2,.L575
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L574
.L575:
	li 0,0
	li 9,1
	stw 0,576(31)
	stw 9,608(31)
.L574:
	lwz 0,392(31)
	li 30,0
	cmpwi 0,0,0
	bc 12,2,.L577
	lis 9,gi@ha
	lis 28,.LC50@ha
	la 29,gi@l(9)
	b .L578
.L580:
	lwz 3,280(30)
	la 4,.LC50@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L578
	lwz 9,64(29)
	li 4,0
	lwz 3,740(30)
	mtlr 9
	blrl
.L578:
	lwz 5,392(31)
	mr 3,30
	li 4,396
	bl G_Find
	mr. 30,3
	bc 4,2,.L580
.L577:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe71:
	.size	 door_secret_done,.Lfe71-door_secret_done
	.section	".rodata"
	.align 3
.LC166:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl door_secret_blocked
	.type	 door_secret_blocked,@function
door_secret_blocked:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,4
	mr 12,3
	lwz 0,184(31)
	andi. 9,0,4
	bc 4,2,.L584
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L584
	stw 0,8(1)
	lis 6,vec3_origin@ha
	mr 4,12
	la 6,vec3_origin@l(6)
	li 0,20
	lis 9,0x1
	stw 0,12(1)
	mr 3,31
	mr 5,4
	addi 7,31,4
	mr 8,6
	ori 9,9,34464
	li 10,1
	bl T_Damage
	cmpwi 0,31,0
	bc 12,2,.L583
	mr 3,31
	bl BecomeExplosion1
	b .L583
.L584:
	lis 9,level+4@ha
	lfs 0,556(12)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L583
	lis 9,.LC166@ha
	fmr 0,13
	lis 6,vec3_origin@ha
	la 9,.LC166@l(9)
	li 0,0
	lfd 13,0(9)
	li 11,20
	mr 3,31
	lwz 9,612(12)
	mr 4,12
	la 6,vec3_origin@l(6)
	stw 0,8(1)
	mr 5,4
	addi 7,3,4
	fadd 0,0,13
	stw 11,12(1)
	mr 8,6
	li 10,1
	frsp 0,0
	stfs 0,556(12)
	bl T_Damage
.L583:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe72:
	.size	 door_secret_blocked,.Lfe72-door_secret_blocked
	.align 2
	.globl door_secret_die
	.type	 door_secret_die,@function
door_secret_die:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 4,5
	li 0,0
	stw 0,608(3)
	bl door_secret_use
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe73:
	.size	 door_secret_die,.Lfe73-door_secret_die
	.align 2
	.globl use_killbox
	.type	 use_killbox,@function
use_killbox:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl KillBox
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe74:
	.size	 use_killbox,.Lfe74-use_killbox
	.align 2
	.globl SP_func_killbox
	.type	 SP_func_killbox,@function
SP_func_killbox:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi+44@ha
	mr 29,3
	lwz 0,gi+44@l(9)
	lwz 4,268(29)
	mtlr 0
	blrl
	lis 9,use_killbox@ha
	li 0,1
	la 9,use_killbox@l(9)
	stw 0,184(29)
	stw 9,544(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe75:
	.size	 SP_func_killbox,.Lfe75-SP_func_killbox
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
