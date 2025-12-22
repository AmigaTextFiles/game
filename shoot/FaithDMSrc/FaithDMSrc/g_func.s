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
	lfs 13,716(31)
	lfs 12,760(31)
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
	lwz 9,768(31)
	stfs 0,376(31)
	mtlr 9
	stfs 0,384(31)
	stfs 0,380(31)
	blrl
	b .L10
.L12:
	fdiv 1,1,31
	addi 3,31,736
	addi 4,31,376
	frsp 1,1
	bl VectorScale
	lis 9,Move_Done@ha
	lis 11,level+4@ha
	la 9,Move_Done@l(9)
	stw 9,436(31)
	lfs 0,level+4@l(11)
	fadd 0,0,31
	frsp 0,0
	stfs 0,428(31)
	b .L10
.L11:
	fmr 1,13
	addi 3,31,736
	addi 4,31,376
	bl VectorScale
	lfs 0,716(31)
	lfs 1,760(31)
	fdivs 1,1,0
	fdiv 1,1,31
	bl floor
	frsp 1,1
	lfs 13,716(31)
	lis 11,level+4@ha
	lis 9,Move_Final@ha
	lfs 0,760(31)
	la 9,Move_Final@l(9)
	fmuls 13,1,13
	fmul 13,13,31
	fsub 0,0,13
	frsp 0,0
	stfs 0,760(31)
	lfs 13,level+4@l(11)
	stw 9,436(31)
	fmadd 1,1,31,13
	frsp 1,1
	stfs 1,428(31)
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
	lwz 0,732(31)
	cmpwi 0,0,2
	bc 4,2,.L29
	lfs 11,16(31)
	lfs 13,688(31)
	lfs 12,692(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,696(31)
	b .L37
.L29:
	lfs 11,16(31)
	lfs 13,664(31)
	lfs 12,668(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,672(31)
.L37:
	lfs 11,24(31)
	fsubs 12,12,10
	stfs 13,8(1)
	fsubs 0,0,11
	stfs 12,12(1)
	stfs 0,16(1)
	addi 3,1,8
	bl VectorLength
	lfs 0,716(31)
	lis 9,.LC5@ha
	lfd 29,.LC5@l(9)
	fdivs 1,1,0
	fmr 30,1
	fcmpu 0,30,29
	bc 4,0,.L31
	lwz 0,732(31)
	cmpwi 0,0,2
	bc 4,2,.L32
	lfs 11,16(31)
	lfs 13,688(31)
	lfs 12,692(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,696(31)
	b .L38
.L32:
	lfs 11,16(31)
	lfs 13,664(31)
	lfs 12,668(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,672(31)
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
	lwz 9,768(31)
	mr 3,31
	li 0,0
	stw 0,388(31)
	mtlr 9
	stw 0,396(31)
	stw 0,392(31)
	blrl
	b .L28
.L34:
	lis 9,.LC6@ha
	addi 3,1,24
	la 9,.LC6@l(9)
	addi 4,31,388
	lfs 1,0(9)
	bl VectorScale
	lis 9,AngleMove_Done@ha
	lis 10,level+4@ha
	la 9,AngleMove_Done@l(9)
	lis 11,.LC5@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC5@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	b .L28
.L31:
	fdiv 1,30,29
	bl floor
	lis 9,.LC7@ha
	frsp 31,1
	addi 3,1,8
	la 9,.LC7@l(9)
	addi 4,31,388
	lfd 0,0(9)
	fdiv 0,0,30
	frsp 1,0
	bl VectorScale
	lis 11,level+4@ha
	lis 9,AngleMove_Final@ha
	lfs 0,level+4@l(11)
	la 9,AngleMove_Final@l(9)
	stw 9,436(31)
	fmadd 31,31,29,0
	frsp 31,31
	stfs 31,428(31)
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
	lfs 13,748(31)
	lfs 9,0(9)
	lfs 0,760(31)
	fcmpu 0,13,9
	fsubs 0,0,13
	stfs 0,760(31)
	bc 4,2,.L58
	addi 30,31,652
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
	addi 3,31,652
	bl plat_Accelerate
	lfs 1,760(31)
	lfs 0,748(31)
	fcmpu 0,1,0
	cror 3,2,0
	bc 4,3,.L62
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,2,.L63
	lwz 9,768(31)
	mr 3,31
	stfs 0,376(31)
	mtlr 9
	stfs 0,384(31)
	stfs 0,380(31)
	blrl
	b .L57
.L63:
	lis 9,.LC12@ha
	addi 3,31,736
	lfd 31,.LC12@l(9)
	addi 4,31,376
	fdiv 1,1,31
	frsp 1,1
	bl VectorScale
	lis 9,Move_Done@ha
	lis 11,level+4@ha
	la 9,Move_Done@l(9)
	stw 9,436(31)
	lfs 0,level+4@l(11)
	fadd 0,0,31
	b .L66
.L62:
	lis 9,.LC19@ha
	addi 3,31,736
	la 9,.LC19@l(9)
	addi 4,31,376
	lfs 1,0(9)
	fmuls 1,0,1
	bl VectorScale
	lis 11,level+4@ha
	lis 10,.LC12@ha
	lfs 0,level+4@l(11)
	lis 9,Think_AccelMove@ha
	lfd 13,.LC12@l(10)
	la 9,Think_AccelMove@l(9)
	stw 9,436(31)
	fadd 0,0,13
.L66:
	frsp 0,0
	stfs 0,428(31)
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
	lwz 5,700(31)
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
	lwz 0,704(31)
	stw 0,76(31)
.L74:
	lfs 13,4(31)
	li 0,0
	li 9,3
	lfs 0,676(31)
	addi 11,31,676
	lis 29,plat_hit_bottom@ha
	stw 9,732(31)
	la 29,plat_hit_bottom@l(29)
	addi 3,31,736
	stw 0,376(31)
	fsubs 0,0,13
	stw 0,384(31)
	stw 0,380(31)
	lfs 12,12(31)
	stfs 0,736(31)
	lfs 13,4(11)
	lfs 0,8(31)
	fsubs 13,13,0
	stfs 13,740(31)
	lfs 0,8(11)
	fsubs 0,0,12
	stfs 0,744(31)
	bl VectorNormalize
	lfs 13,716(31)
	lfs 0,712(31)
	stfs 1,760(31)
	stw 29,768(31)
	fcmpu 0,13,0
	bc 4,2,.L76
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L76
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L77
	lwz 0,564(31)
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
	stw 9,436(31)
	b .L83
.L76:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC20@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC20@l(11)
.L83:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
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
	lwz 5,700(31)
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
	lwz 0,704(31)
	stw 0,76(31)
.L85:
	lfs 13,4(31)
	li 0,0
	li 9,2
	lfs 0,652(31)
	addi 11,31,652
	lis 29,plat_hit_top@ha
	stw 9,732(31)
	la 29,plat_hit_top@l(29)
	addi 3,31,736
	stw 0,376(31)
	fsubs 0,0,13
	stw 0,384(31)
	stw 0,380(31)
	lfs 12,12(31)
	stfs 0,736(31)
	lfs 13,4(11)
	lfs 0,8(31)
	fsubs 13,13,0
	stfs 13,740(31)
	lfs 0,8(11)
	fsubs 0,0,12
	stfs 0,744(31)
	bl VectorNormalize
	lfs 13,716(31)
	lfs 0,712(31)
	stfs 1,760(31)
	stw 29,768(31)
	fcmpu 0,13,0
	bc 4,2,.L87
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L87
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L88
	lwz 0,564(31)
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
	stw 9,436(31)
	b .L94
.L87:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC24@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC24@l(11)
.L94:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
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
	stw 31,540(7)
	lfs 6,0(9)
	li 11,1
	lis 10,st+24@ha
	lis 9,Touch_Plat_Center@ha
	stw 11,248(7)
	lis 8,0x4330
	la 9,Touch_Plat_Center@l(9)
	stw 0,260(7)
	lis 11,.LC29@ha
	stw 9,444(7)
	la 11,.LC29@l(11)
	lwz 0,st+24@l(10)
	lfd 10,0(11)
	xoris 0,0,0x8000
	lfs 13,372(31)
	lis 11,.LC30@ha
	stw 0,52(1)
	la 11,.LC30@l(11)
	stw 8,48(1)
	lfd 0,48(1)
	lfs 8,360(31)
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
	lfs 0,328(31)
	lis 9,plat_blocked@ha
	la 9,plat_blocked@l(9)
	stw 9,440(31)
	fcmpu 0,0,31
	bc 4,2,.L114
	lis 0,0x41a0
	stw 0,328(31)
	b .L115
.L114:
	lis 9,.LC34@ha
	lfd 13,.LC34@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,328(31)
.L115:
	lis 9,.LC38@ha
	lfs 13,332(31)
	la 9,.LC38@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L116
	lis 0,0x40a0
	stw 0,332(31)
	b .L117
.L116:
	fmr 0,13
	lis 9,.LC34@ha
	lfd 13,.LC34@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,332(31)
.L117:
	lis 10,.LC38@ha
	lfs 13,336(31)
	la 10,.LC38@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,2,.L118
	lis 0,0x40a0
	stw 0,336(31)
	b .L119
.L118:
	fmr 0,13
	lis 9,.LC34@ha
	lfd 13,.LC34@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,336(31)
.L119:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L120
	li 0,2
	stw 0,516(31)
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
	stfs 0,364(31)
	stfs 13,368(31)
	stfs 0,352(31)
	stfs 13,356(31)
	stfs 10,360(31)
	stfs 10,372(31)
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
	stfs 0,372(31)
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
	stfs 13,372(31)
.L123:
	lis 9,Use_Plat@ha
	mr 3,31
	la 9,Use_Plat@l(9)
	stw 9,448(31)
	bl plat_spawn_inside_trigger
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L124
	li 0,2
	b .L126
.L124:
	lfs 12,364(31)
	lis 9,gi+72@ha
	mr 3,31
	lfs 0,368(31)
	lfs 13,372(31)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	li 0,1
.L126:
	stw 0,732(31)
	lfs 2,16(31)
	lis 29,gi@ha
	lis 3,.LC35@ha
	lfs 3,20(31)
	la 29,gi@l(29)
	la 3,.LC35@l(3)
	lfs 4,24(31)
	lfs 0,328(31)
	lfs 13,332(31)
	lfs 12,336(31)
	lfs 11,592(31)
	lfs 10,352(31)
	lfs 9,356(31)
	lfs 8,360(31)
	lfs 7,364(31)
	lfs 6,368(31)
	lfs 5,372(31)
	stfs 0,716(31)
	stfs 13,712(31)
	stfs 12,720(31)
	stfs 11,728(31)
	stfs 10,652(31)
	stfs 9,656(31)
	stfs 8,660(31)
	stfs 7,676(31)
	stfs 6,680(31)
	stfs 5,684(31)
	stfs 2,688(31)
	stfs 3,692(31)
	stfs 4,696(31)
	stfs 2,664(31)
	stfs 3,668(31)
	stfs 4,672(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,700(31)
	lwz 9,36(29)
	lis 3,.LC36@ha
	la 3,.LC36@l(3)
	mtlr 9
	blrl
	stw 3,704(31)
	lwz 0,36(29)
	lis 3,.LC37@ha
	la 3,.LC37@l(3)
	mtlr 0
	blrl
	stw 3,708(31)
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
	stw 0,340(31)
	andi. 11,9,4
	stw 0,348(31)
	stw 0,344(31)
	bc 12,2,.L138
	lis 0,0x3f80
	stw 0,348(31)
	b .L139
.L138:
	andi. 0,9,8
	bc 12,2,.L140
	lis 0,0x3f80
	stw 0,340(31)
	b .L139
.L140:
	lis 0,0x3f80
	stw 0,344(31)
.L139:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L142
	lfs 0,340(31)
	lfs 13,344(31)
	lfs 12,348(31)
	fneg 0,0
	fneg 13,13
	fneg 12,12
	stfs 0,340(31)
	stfs 13,344(31)
	stfs 12,348(31)
.L142:
	lis 11,.LC40@ha
	lfs 13,328(31)
	la 11,.LC40@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L143
	lis 0,0x42c8
	stw 0,328(31)
.L143:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L144
	li 0,2
	stw 0,516(31)
.L144:
	lwz 0,516(31)
	lis 9,rotating_use@ha
	la 9,rotating_use@l(9)
	cmpwi 0,0,0
	stw 9,448(31)
	bc 12,2,.L145
	lis 9,rotating_blocked@ha
	la 9,rotating_blocked@l(9)
	stw 9,440(31)
.L145:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L146
	lwz 9,448(31)
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
	addi 11,31,652
	lfs 0,652(31)
	lis 29,button_done@ha
	addi 3,31,736
	stw 9,732(31)
	la 29,button_done@l(29)
	stw 0,376(31)
	fsubs 0,0,13
	stw 0,384(31)
	stw 0,380(31)
	lfs 12,12(31)
	stfs 0,736(31)
	lfs 13,4(11)
	lfs 0,8(31)
	fsubs 13,13,0
	stfs 13,740(31)
	lfs 0,8(11)
	fsubs 0,0,12
	stfs 0,744(31)
	bl VectorNormalize
	lfs 13,716(31)
	lfs 0,712(31)
	stfs 1,760(31)
	stw 29,768(31)
	fcmpu 0,13,0
	bc 4,2,.L151
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L151
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L152
	lwz 0,564(31)
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
	stw 9,436(31)
	b .L159
.L151:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC41@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC41@l(11)
.L159:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L157:
	lwz 9,480(31)
	li 0,0
	stw 0,56(31)
	cmpwi 0,9,0
	bc 12,2,.L158
	li 0,1
	stw 0,512(31)
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
	lwz 0,732(31)
	subfic 11,0,0
	adde 9,11,0
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L162
	lwz 5,700(31)
	li 0,2
	stw 0,732(31)
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
	addi 9,31,676
	lfs 0,676(31)
	lis 29,button_wait@ha
	addi 3,31,736
	stw 0,376(31)
	la 29,button_wait@l(29)
	stw 0,384(31)
	fsubs 0,0,13
	stw 0,380(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,736(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,740(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,744(31)
	bl VectorNormalize
	lfs 13,716(31)
	lfs 0,712(31)
	stfs 1,760(31)
	stw 29,768(31)
	fcmpu 0,13,0
	bc 4,2,.L165
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L165
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L166
	lwz 0,564(31)
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
	stw 9,436(31)
	b .L172
.L165:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC42@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC42@l(11)
.L172:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
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
	.string	"switches/butn2.wav"
	.align 2
.LC47:
	.long 0x0
	.align 3
.LC48:
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
	addi 29,31,340
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
	lwz 0,528(31)
	cmpwi 0,0,1
	bc 12,2,.L179
	lwz 0,36(30)
	lis 3,.LC46@ha
	la 3,.LC46@l(3)
	mtlr 0
	blrl
	stw 3,700(31)
.L179:
	lis 8,.LC47@ha
	lfs 0,328(31)
	la 8,.LC47@l(8)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,2,.L180
	lis 0,0x4220
	stw 0,328(31)
.L180:
	lfs 0,332(31)
	fcmpu 0,0,13
	bc 4,2,.L181
	lfs 0,328(31)
	stfs 0,332(31)
.L181:
	lfs 0,336(31)
	fcmpu 0,0,13
	bc 4,2,.L182
	lfs 0,328(31)
	stfs 0,336(31)
.L182:
	lfs 0,592(31)
	fcmpu 0,0,13
	bc 4,2,.L183
	lis 0,0x4040
	stw 0,592(31)
.L183:
	lis 9,st@ha
	la 10,st@l(9)
	lwz 0,24(10)
	cmpwi 0,0,0
	bc 4,2,.L184
	li 0,4
	stw 0,24(10)
.L184:
	lfs 12,4(31)
	lis 11,0x4330
	lfs 13,8(31)
	lis 8,.LC48@ha
	mr 4,29
	lfs 0,12(31)
	la 8,.LC48@l(8)
	addi 3,31,352
	stfs 12,352(31)
	addi 5,31,364
	stfs 13,356(31)
	stfs 0,360(31)
	lfs 10,344(31)
	lwz 0,24(10)
	lfs 11,340(31)
	lfs 12,240(31)
	xoris 0,0,0x8000
	fabs 10,10
	stw 0,44(1)
	lfs 0,348(31)
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
	lwz 11,480(31)
	lis 9,button_use@ha
	lwz 0,64(31)
	la 9,button_use@l(9)
	cmpwi 0,11,0
	stw 9,448(31)
	ori 0,0,1024
	stw 0,64(31)
	bc 12,2,.L185
	lis 9,button_killed@ha
	li 0,1
	stw 11,484(31)
	la 9,button_killed@l(9)
	stw 0,512(31)
	stw 9,456(31)
	b .L186
.L185:
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L186
	lis 9,button_touch@ha
	la 9,button_touch@l(9)
	stw 9,444(31)
.L186:
	lfs 2,16(31)
	li 0,1
	lis 9,gi+72@ha
	lfs 3,20(31)
	mr 3,31
	lfs 4,24(31)
	lfs 0,328(31)
	lfs 13,332(31)
	lfs 12,336(31)
	lfs 11,592(31)
	lfs 10,352(31)
	lfs 9,356(31)
	lfs 8,360(31)
	lfs 7,364(31)
	lfs 6,368(31)
	lfs 5,372(31)
	stw 0,732(31)
	stfs 0,716(31)
	stfs 13,712(31)
	stfs 12,720(31)
	stfs 11,728(31)
	stfs 10,652(31)
	stfs 9,656(31)
	stfs 8,660(31)
	stfs 7,676(31)
	stfs 6,680(31)
	stfs 5,684(31)
	stfs 2,688(31)
	stfs 3,692(31)
	stfs 4,696(31)
	stfs 2,664(31)
	stfs 3,668(31)
	stfs 4,672(31)
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
.LC49:
	.string	"func_areaportal"
	.align 2
.LC50:
	.string	"func_door"
	.align 2
.LC52:
	.string	"func_door_rotating"
	.align 3
.LC51:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC53:
	.long 0x3f800000
	.align 2
.LC54:
	.long 0x40400000
	.align 2
.LC55:
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
	bc 4,2,.L211
	lwz 5,700(31)
	cmpwi 0,5,0
	bc 12,2,.L212
	lis 9,gi+16@ha
	lis 11,.LC54@ha
	lwz 0,gi+16@l(9)
	lis 8,.LC55@ha
	la 11,.LC54@l(11)
	lis 9,.LC53@ha
	la 8,.LC55@l(8)
	lfs 2,0(11)
	la 9,.LC53@l(9)
	lfs 3,0(8)
	mtlr 0
	li 4,10
	lfs 1,0(9)
	blrl
.L212:
	lwz 0,704(31)
	stw 0,76(31)
.L211:
	lwz 9,484(31)
	cmpwi 0,9,0
	bc 12,2,.L213
	li 0,1
	stw 9,480(31)
	stw 0,512(31)
.L213:
	li 0,3
	lwz 3,280(31)
	lis 4,.LC50@ha
	stw 0,732(31)
	la 4,.LC50@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L214
	lfs 13,4(31)
	li 0,0
	addi 9,31,652
	lfs 0,652(31)
	lis 29,door_hit_bottom@ha
	addi 3,31,736
	stw 0,376(31)
	la 29,door_hit_bottom@l(29)
	stw 0,384(31)
	fsubs 0,0,13
	stw 0,380(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,736(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,740(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,744(31)
	bl VectorNormalize
	lfs 13,716(31)
	lfs 0,712(31)
	stfs 1,760(31)
	stw 29,768(31)
	fcmpu 0,13,0
	bc 4,2,.L215
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L215
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 8,0,1024
	bc 12,2,.L216
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L217
	b .L218
.L216:
	cmpw 0,9,31
	bc 4,2,.L218
.L217:
	mr 3,31
	bl Move_Begin
	b .L222
.L218:
	lis 11,level+4@ha
	lis 10,.LC51@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC51@l(10)
	la 9,Move_Begin@l(9)
	b .L229
.L215:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC51@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC51@l(11)
	b .L230
.L214:
	lwz 3,280(31)
	lis 4,.LC52@ha
	la 4,.LC52@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L222
	lwz 10,264(31)
	lis 9,door_hit_bottom@ha
	li 0,0
	la 9,door_hit_bottom@l(9)
	stw 0,388(31)
	lis 11,level+292@ha
	andi. 8,10,1024
	stw 9,768(31)
	stw 0,396(31)
	stw 0,392(31)
	lwz 9,level+292@l(11)
	bc 12,2,.L224
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L225
	b .L226
.L224:
	cmpw 0,9,31
	bc 4,2,.L226
.L225:
	mr 3,31
	bl AngleMove_Begin
	b .L222
.L226:
	lis 11,level+4@ha
	lis 10,.LC51@ha
	lfs 0,level+4@l(11)
	lis 9,AngleMove_Begin@ha
	lfd 13,.LC51@l(10)
	la 9,AngleMove_Begin@l(9)
.L229:
	stw 9,436(31)
.L230:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L222:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 door_go_down,.Lfe13-door_go_down
	.section	".rodata"
	.align 3
.LC56:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC57:
	.long 0x0
	.align 2
.LC58:
	.long 0x3f800000
	.align 2
.LC59:
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
	lwz 0,732(31)
	cmpwi 0,0,2
	bc 12,2,.L231
	cmpwi 0,0,0
	bc 4,2,.L233
	lis 8,.LC57@ha
	lfs 13,728(31)
	la 8,.LC57@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L231
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,13
	stfs 0,428(31)
	b .L231
.L233:
	lwz 0,264(31)
	andi. 9,0,1024
	bc 4,2,.L235
	lwz 5,700(31)
	cmpwi 0,5,0
	bc 12,2,.L236
	lis 9,gi+16@ha
	lis 11,.LC58@ha
	lwz 0,gi+16@l(9)
	lis 8,.LC59@ha
	la 11,.LC58@l(11)
	lis 9,.LC57@ha
	la 8,.LC59@l(8)
	lfs 1,0(11)
	la 9,.LC57@l(9)
	mr 3,31
	lfs 2,0(8)
	mtlr 0
	li 4,10
	lfs 3,0(9)
	blrl
.L236:
	lwz 0,704(31)
	stw 0,76(31)
.L235:
	li 0,2
	lwz 3,280(31)
	lis 4,.LC50@ha
	stw 0,732(31)
	la 4,.LC50@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L237
	lfs 13,4(31)
	li 0,0
	addi 9,31,676
	lfs 0,676(31)
	lis 29,door_hit_top@ha
	addi 3,31,736
	stw 0,376(31)
	la 29,door_hit_top@l(29)
	stw 0,384(31)
	fsubs 0,0,13
	stw 0,380(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,736(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,740(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,744(31)
	bl VectorNormalize
	lfs 13,716(31)
	lfs 0,712(31)
	stfs 1,760(31)
	stw 29,768(31)
	fcmpu 0,13,0
	bc 4,2,.L238
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L238
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 8,0,1024
	bc 12,2,.L239
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L240
	b .L241
.L239:
	cmpw 0,9,31
	bc 4,2,.L241
.L240:
	mr 3,31
	bl Move_Begin
	b .L245
.L241:
	lis 11,level+4@ha
	lis 10,.LC56@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC56@l(10)
	la 9,Move_Begin@l(9)
	b .L259
.L238:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC56@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC56@l(11)
	b .L260
.L237:
	lwz 3,280(31)
	lis 4,.LC52@ha
	la 4,.LC52@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L245
	lwz 10,264(31)
	lis 9,door_hit_top@ha
	li 0,0
	la 9,door_hit_top@l(9)
	stw 0,388(31)
	lis 11,level+292@ha
	andi. 8,10,1024
	stw 9,768(31)
	stw 0,396(31)
	stw 0,392(31)
	lwz 9,level+292@l(11)
	bc 12,2,.L247
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L248
	b .L249
.L247:
	cmpw 0,9,31
	bc 4,2,.L249
.L248:
	mr 3,31
	bl AngleMove_Begin
	b .L245
.L249:
	lis 11,level+4@ha
	lis 10,.LC56@ha
	lfs 0,level+4@l(11)
	lis 9,AngleMove_Begin@ha
	lfd 13,.LC56@l(10)
	la 9,AngleMove_Begin@l(9)
.L259:
	stw 9,436(31)
.L260:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L245:
	mr 4,30
	mr 3,31
	bl G_UseTargets
	li 29,0
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L231
	lis 9,gi@ha
	lis 28,.LC49@ha
	la 30,gi@l(9)
	b .L254
.L256:
	lwz 3,280(29)
	la 4,.LC49@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L254
	lwz 9,64(30)
	li 4,1
	lwz 3,644(29)
	mtlr 9
	blrl
.L254:
	lwz 5,296(31)
	mr 3,29
	li 4,300
	bl G_Find
	mr. 29,3
	bc 4,2,.L256
.L231:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 door_go_up,.Lfe14-door_go_up
	.section	".rodata"
	.align 2
.LC60:
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
	bc 4,2,.L311
	lwz 31,560(29)
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
	bc 12,2,.L314
	addi 30,1,24
.L316:
	addi 3,31,212
	addi 4,1,8
	mr 5,30
	bl AddPointToBounds
	addi 3,31,224
	addi 4,1,8
	mr 5,30
	bl AddPointToBounds
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L316
.L314:
	lis 9,.LC60@ha
	lfs 10,8(1)
	la 9,.LC60@l(9)
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
	stw 11,444(31)
	stw 29,256(31)
	lwz 9,72(30)
	mtlr 9
	blrl
	lwz 0,284(29)
	andi. 9,0,1
	bc 12,2,.L318
	lwz 0,296(29)
	li 31,0
	cmpwi 0,0,0
	bc 12,2,.L318
	mr 28,30
	lis 30,.LC49@ha
	b .L321
.L323:
	lwz 3,280(31)
	la 4,.LC49@l(30)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L321
	lwz 9,64(28)
	li 4,1
	lwz 3,644(31)
	mtlr 9
	blrl
.L321:
	lwz 5,296(29)
	mr 3,31
	li 4,300
	bl G_Find
	mr. 31,3
	bc 4,2,.L323
.L318:
	lwz 0,264(29)
	andi. 9,0,1024
	bc 4,2,.L311
	lwz 9,560(29)
	lfs 0,724(29)
	cmpwi 0,9,0
	lfs 12,716(29)
	fabs 13,0
	bc 12,2,.L333
.L330:
	lfs 0,724(9)
	fabs 0,0
	fcmpu 0,0,13
	bc 4,0,.L332
	fmr 13,0
.L332:
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L330
.L333:
	mr. 9,29
	fdivs 0,13,12
	bc 12,2,.L311
	fmr 9,0
.L336:
	lfs 0,724(9)
	lfs 13,716(9)
	lfs 11,712(9)
	fcmpu 0,11,13
	fabs 0,0
	fdiv 0,0,9
	frsp 12,0
	fdivs 10,12,13
	bc 4,2,.L337
	stfs 12,712(9)
	b .L338
.L337:
	fmuls 0,11,10
	stfs 0,712(9)
.L338:
	lfs 13,720(9)
	lfs 0,716(9)
	fcmpu 0,13,0
	bc 4,2,.L339
	stfs 12,720(9)
	b .L340
.L339:
	fmuls 0,13,10
	stfs 0,720(9)
.L340:
	stfs 12,716(9)
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L336
.L311:
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe15:
	.size	 Think_SpawnDoorTrigger,.Lfe15-Think_SpawnDoorTrigger
	.section	".rodata"
	.align 2
.LC61:
	.string	"%s"
	.align 2
.LC62:
	.string	"misc/talk1.wav"
	.align 2
.LC63:
	.string	"doors/dr1_strt.wav"
	.align 2
.LC64:
	.string	"doors/dr1_mid.wav"
	.align 2
.LC65:
	.string	"doors/dr1_end.wav"
	.align 2
.LC66:
	.string	"misc/talk.wav"
	.align 3
.LC67:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC68:
	.long 0x0
	.align 3
.LC69:
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
	lwz 0,528(31)
	cmpwi 0,0,1
	bc 12,2,.L384
	lis 29,gi@ha
	lis 3,.LC63@ha
	la 29,gi@l(29)
	la 3,.LC63@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,700(31)
	lwz 9,36(29)
	lis 3,.LC64@ha
	la 3,.LC64@l(3)
	mtlr 9
	blrl
	stw 3,704(31)
	lwz 0,36(29)
	lis 3,.LC65@ha
	la 3,.LC65@l(3)
	mtlr 0
	blrl
	stw 3,708(31)
.L384:
	addi 29,31,340
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
	lis 8,.LC68@ha
	lfs 0,328(31)
	lis 9,door_blocked@ha
	la 8,.LC68@l(8)
	lis 11,door_use@ha
	lfs 13,0(8)
	la 9,door_blocked@l(9)
	la 11,door_use@l(11)
	stw 9,440(31)
	stw 11,448(31)
	fcmpu 0,0,13
	bc 4,2,.L385
	lis 0,0x42c8
	stw 0,328(31)
.L385:
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L386
	lfs 0,328(31)
	fadds 0,0,0
	stfs 0,328(31)
.L386:
	lfs 0,332(31)
	fcmpu 0,0,13
	bc 4,2,.L387
	lfs 0,328(31)
	stfs 0,332(31)
.L387:
	lfs 0,336(31)
	fcmpu 0,0,13
	bc 4,2,.L388
	lfs 0,328(31)
	stfs 0,336(31)
.L388:
	lfs 0,592(31)
	fcmpu 0,0,13
	bc 4,2,.L389
	lis 0,0x4040
	stw 0,592(31)
.L389:
	lis 9,st@ha
	la 10,st@l(9)
	lwz 0,24(10)
	cmpwi 0,0,0
	bc 4,2,.L390
	li 0,8
	stw 0,24(10)
.L390:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L391
	stw 30,516(31)
.L391:
	lfs 12,4(31)
	lis 11,0x4330
	lfs 13,8(31)
	lis 8,.LC69@ha
	mr 4,29
	lfs 0,12(31)
	la 8,.LC69@l(8)
	addi 3,31,352
	stfs 12,352(31)
	addi 5,31,364
	stfs 13,356(31)
	stfs 0,360(31)
	lfs 9,344(31)
	lwz 0,24(10)
	lfs 10,340(31)
	lfs 11,240(31)
	xoris 0,0,0x8000
	fabs 9,9
	stw 0,28(1)
	lfs 0,348(31)
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
	stfs 0,724(31)
	bl VectorMA
	lwz 0,284(31)
	andi. 8,0,1
	bc 12,2,.L392
	lfs 11,364(31)
	lfs 10,368(31)
	lfs 9,372(31)
	lfs 0,352(31)
	lfs 13,356(31)
	lfs 12,360(31)
	stfs 0,364(31)
	stfs 13,368(31)
	stfs 12,372(31)
	stfs 11,352(31)
	stfs 10,356(31)
	stfs 9,360(31)
	stfs 11,4(31)
	stfs 10,8(31)
	stfs 9,12(31)
.L392:
	lwz 0,480(31)
	li 11,1
	stw 11,732(31)
	cmpwi 0,0,0
	bc 12,2,.L393
	lis 9,door_killed@ha
	stw 11,512(31)
	la 9,door_killed@l(9)
	stw 0,484(31)
	stw 9,456(31)
	b .L394
.L393:
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L394
	lwz 0,276(31)
	cmpwi 0,0,0
	bc 12,2,.L394
	lwz 0,36(28)
	lis 3,.LC66@ha
	la 3,.LC66@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,444(31)
.L394:
	lwz 0,284(31)
	lfs 3,16(31)
	lfs 2,20(31)
	andi. 8,0,16
	lfs 4,24(31)
	lfs 0,328(31)
	lfs 13,332(31)
	lfs 12,336(31)
	lfs 11,592(31)
	lfs 10,352(31)
	lfs 9,356(31)
	lfs 8,360(31)
	lfs 7,364(31)
	lfs 6,368(31)
	lfs 5,372(31)
	stfs 0,716(31)
	stfs 13,712(31)
	stfs 12,720(31)
	stfs 11,728(31)
	stfs 10,652(31)
	stfs 9,656(31)
	stfs 8,660(31)
	stfs 7,676(31)
	stfs 6,680(31)
	stfs 5,684(31)
	stfs 3,688(31)
	stfs 2,692(31)
	stfs 4,696(31)
	stfs 3,664(31)
	stfs 2,668(31)
	stfs 4,672(31)
	bc 12,2,.L396
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L396:
	lwz 0,284(31)
	andi. 9,0,64
	bc 12,2,.L397
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L397:
	lwz 0,308(31)
	cmpwi 0,0,0
	bc 4,2,.L398
	stw 31,564(31)
.L398:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC67@ha
	lwz 0,480(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC67@l(11)
	cmpwi 0,0,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 4,2,.L400
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L399
.L400:
	lis 9,Think_CalcMoveSpeed@ha
	la 9,Think_CalcMoveSpeed@l(9)
	b .L402
.L399:
	lis 9,Think_SpawnDoorTrigger@ha
	la 9,Think_SpawnDoorTrigger@l(9)
.L402:
	stw 9,436(31)
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe16:
	.size	 SP_func_door,.Lfe16-SP_func_door
	.section	".rodata"
	.align 2
.LC70:
	.string	"%s at %s with no distance set\n"
	.align 3
.LC71:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC72:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC73:
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
	stw 0,340(31)
	andi. 11,9,64
	stw 0,24(31)
	stw 0,20(31)
	stw 0,16(31)
	stw 0,348(31)
	stw 0,344(31)
	bc 12,2,.L404
	lis 0,0x3f80
	stw 0,348(31)
	b .L405
.L404:
	andi. 0,9,128
	bc 12,2,.L406
	lis 0,0x3f80
	stw 0,340(31)
	b .L405
.L406:
	lis 0,0x3f80
	stw 0,344(31)
.L405:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L408
	lfs 0,340(31)
	lfs 13,344(31)
	lfs 12,348(31)
	fneg 0,0
	fneg 13,13
	fneg 12,12
	stfs 0,340(31)
	stfs 13,344(31)
	stfs 12,348(31)
.L408:
	lis 9,st@ha
	la 30,st@l(9)
	lwz 0,28(30)
	cmpwi 0,0,0
	bc 4,2,.L409
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC70@ha
	mtlr 0
	la 3,.LC70@l(3)
	crxor 6,6,6
	blrl
	li 0,90
	stw 0,28(30)
.L409:
	lfs 13,20(31)
	lis 29,0x4330
	lfs 12,16(31)
	lis 11,.LC72@ha
	addi 3,31,16
	lfs 0,24(31)
	la 11,.LC72@l(11)
	addi 4,31,340
	stfs 13,356(31)
	addi 5,31,364
	li 28,2
	stfs 12,352(31)
	stfs 0,360(31)
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
	stfs 0,724(31)
	lwz 9,44(30)
	mtlr 9
	blrl
	lis 9,.LC73@ha
	lfs 0,328(31)
	lis 11,door_use@ha
	la 9,.LC73@l(9)
	la 11,door_use@l(11)
	lfs 13,0(9)
	lis 9,door_blocked@ha
	stw 11,448(31)
	la 9,door_blocked@l(9)
	fcmpu 0,0,13
	stw 9,440(31)
	bc 4,2,.L410
	lis 0,0x42c8
	stw 0,328(31)
.L410:
	lfs 0,332(31)
	fcmpu 0,0,13
	bc 4,2,.L411
	lfs 0,328(31)
	stfs 0,332(31)
.L411:
	lfs 0,336(31)
	fcmpu 0,0,13
	bc 4,2,.L412
	lfs 0,328(31)
	stfs 0,336(31)
.L412:
	lfs 0,592(31)
	fcmpu 0,0,13
	bc 4,2,.L413
	lis 0,0x4040
	stw 0,592(31)
.L413:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L414
	stw 28,516(31)
.L414:
	lwz 0,528(31)
	cmpwi 0,0,1
	bc 12,2,.L415
	lwz 9,36(30)
	lis 3,.LC63@ha
	la 3,.LC63@l(3)
	mtlr 9
	blrl
	stw 3,700(31)
	lwz 9,36(30)
	lis 3,.LC64@ha
	la 3,.LC64@l(3)
	mtlr 9
	blrl
	stw 3,704(31)
	lwz 9,36(30)
	lis 3,.LC65@ha
	la 3,.LC65@l(3)
	mtlr 9
	blrl
	stw 3,708(31)
.L415:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L416
	lfs 11,340(31)
	lfs 10,344(31)
	lfs 9,348(31)
	lfs 6,364(31)
	fneg 11,11
	lfs 8,368(31)
	fneg 10,10
	lfs 7,372(31)
	fneg 9,9
	lfs 0,352(31)
	lfs 13,356(31)
	lfs 12,360(31)
	stfs 0,364(31)
	stfs 13,368(31)
	stfs 12,372(31)
	stfs 6,352(31)
	stfs 8,356(31)
	stfs 7,360(31)
	stfs 11,340(31)
	stfs 10,344(31)
	stfs 9,348(31)
	stfs 6,16(31)
	stfs 8,20(31)
	stfs 7,24(31)
.L416:
	lwz 11,480(31)
	cmpwi 0,11,0
	bc 12,2,.L417
	lis 9,door_killed@ha
	li 0,1
	stw 11,484(31)
	la 9,door_killed@l(9)
	stw 0,512(31)
	stw 9,456(31)
.L417:
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L418
	lwz 0,276(31)
	cmpwi 0,0,0
	bc 12,2,.L418
	lwz 0,36(30)
	lis 3,.LC66@ha
	la 3,.LC66@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,444(31)
.L418:
	lwz 0,284(31)
	li 9,1
	lfs 3,4(31)
	lfs 2,8(31)
	andi. 11,0,16
	lfs 4,12(31)
	lfs 0,328(31)
	lfs 13,332(31)
	lfs 12,336(31)
	lfs 11,592(31)
	lfs 10,352(31)
	lfs 9,356(31)
	lfs 8,360(31)
	lfs 7,364(31)
	lfs 6,368(31)
	lfs 5,372(31)
	stw 9,732(31)
	stfs 0,716(31)
	stfs 13,712(31)
	stfs 12,720(31)
	stfs 11,728(31)
	stfs 10,664(31)
	stfs 9,668(31)
	stfs 8,672(31)
	stfs 3,676(31)
	stfs 2,680(31)
	stfs 4,684(31)
	stfs 7,688(31)
	stfs 6,692(31)
	stfs 5,696(31)
	stfs 3,652(31)
	stfs 2,656(31)
	stfs 4,660(31)
	bc 12,2,.L419
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L419:
	lwz 0,308(31)
	cmpwi 0,0,0
	bc 4,2,.L420
	stw 31,564(31)
.L420:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC71@ha
	lwz 0,480(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC71@l(11)
	cmpwi 0,0,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 4,2,.L422
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L421
.L422:
	lis 9,Think_CalcMoveSpeed@ha
	la 9,Think_CalcMoveSpeed@l(9)
	b .L424
.L421:
	lis 9,Think_SpawnDoorTrigger@ha
	la 9,Think_SpawnDoorTrigger@l(9)
.L424:
	stw 9,436(31)
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
.LC74:
	.string	"world/mov_watr.wav"
	.align 2
.LC75:
	.string	"world/stp_watr.wav"
	.align 3
.LC76:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC77:
	.long 0x0
	.align 2
.LC78:
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
	addi 4,31,340
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
	lwz 0,528(31)
	cmpwi 0,0,1
	bc 12,2,.L428
	cmpwi 0,0,2
	bc 4,2,.L426
.L428:
	lwz 9,36(30)
	lis 3,.LC74@ha
	la 3,.LC74@l(3)
	mtlr 9
	blrl
	stw 3,700(31)
	lwz 0,36(30)
	lis 3,.LC75@ha
	la 3,.LC75@l(3)
	mtlr 0
	blrl
	stw 3,708(31)
.L426:
	lfs 12,4(31)
	lis 11,st+24@ha
	lfs 13,8(31)
	lis 10,0x4330
	lis 8,.LC76@ha
	lfs 0,12(31)
	la 8,.LC76@l(8)
	addi 3,31,352
	stfs 12,352(31)
	addi 4,31,340
	addi 5,31,364
	stfs 13,356(31)
	stfs 0,360(31)
	lfs 9,344(31)
	lwz 0,st+24@l(11)
	lfs 10,340(31)
	lfs 11,240(31)
	xoris 0,0,0x8000
	fabs 9,9
	stw 0,36(1)
	lfs 0,348(31)
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
	stfs 0,724(31)
	bl VectorMA
	lwz 0,284(31)
	andi. 8,0,1
	bc 12,2,.L431
	lfs 11,364(31)
	lfs 10,368(31)
	lfs 9,372(31)
	lfs 0,352(31)
	lfs 13,356(31)
	lfs 12,360(31)
	stfs 0,364(31)
	stfs 13,368(31)
	stfs 12,372(31)
	stfs 11,352(31)
	stfs 10,356(31)
	stfs 9,360(31)
	stfs 11,4(31)
	stfs 10,8(31)
	stfs 9,12(31)
.L431:
	lis 9,.LC77@ha
	lfs 0,328(31)
	li 0,1
	la 9,.LC77@l(9)
	lfs 6,16(31)
	lfs 5,0(9)
	lfs 8,20(31)
	lfs 7,24(31)
	fcmpu 0,0,5
	lfs 13,356(31)
	lfs 0,352(31)
	lfs 12,360(31)
	lfs 11,364(31)
	lfs 10,368(31)
	lfs 9,372(31)
	stfs 0,652(31)
	stfs 13,656(31)
	stfs 12,660(31)
	stfs 11,676(31)
	stfs 10,680(31)
	stfs 9,684(31)
	stfs 6,688(31)
	stfs 8,692(31)
	stfs 7,696(31)
	stw 0,732(31)
	stfs 6,664(31)
	stfs 8,668(31)
	stfs 7,672(31)
	bc 4,2,.L432
	lis 0,0x41c8
	stw 0,328(31)
.L432:
	lfs 13,592(31)
	lfs 0,328(31)
	fcmpu 0,13,5
	stfs 0,712(31)
	stfs 0,716(31)
	stfs 0,720(31)
	bc 4,2,.L433
	lis 0,0xbf80
	stw 0,592(31)
.L433:
	lis 8,.LC78@ha
	lfs 13,592(31)
	lis 9,door_use@ha
	la 8,.LC78@l(8)
	la 9,door_use@l(9)
	lfs 0,0(8)
	stw 9,448(31)
	stfs 13,728(31)
	fcmpu 0,13,0
	bc 4,2,.L434
	lwz 0,284(31)
	ori 0,0,32
	stw 0,284(31)
.L434:
	lis 9,.LC50@ha
	lis 11,gi+72@ha
	la 9,.LC50@l(9)
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
.LC79:
	.long 0x0
	.align 2
.LC80:
	.long 0x3f800000
	.align 2
.LC81:
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
	lwz 30,324(31)
	lwz 0,312(30)
	cmpwi 0,0,0
	bc 12,2,.L441
	lwz 29,296(30)
	mr 3,30
	stw 0,296(30)
	lwz 4,548(31)
	bl G_UseTargets
	stw 29,296(30)
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L440
.L441:
	lis 9,.LC79@ha
	lfs 13,728(31)
	la 9,.LC79@l(9)
	lfs 31,0(9)
	fcmpu 0,13,31
	bc 12,2,.L443
	bc 4,1,.L444
	lis 9,level+4@ha
	lis 11,train_next@ha
	lfs 0,level+4@l(9)
	la 11,train_next@l(11)
	stw 11,436(31)
	fadds 0,0,13
	stfs 0,428(31)
	b .L445
.L444:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L445
	mr 3,31
	bl train_next
	lwz 0,284(31)
	stfs 31,428(31)
	rlwinm 0,0,0,0,30
	stfs 31,384(31)
	stw 0,284(31)
	stfs 31,380(31)
	stfs 31,376(31)
.L445:
	lwz 0,264(31)
	andi. 30,0,1024
	bc 4,2,.L440
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L448
	lis 9,gi+16@ha
	mr 3,31
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC80@ha
	la 9,.LC80@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC81@ha
	la 9,.LC81@l(9)
	lfs 2,0(9)
	lis 9,.LC79@ha
	la 9,.LC79@l(9)
	lfs 3,0(9)
	blrl
.L448:
	stw 30,76(31)
	b .L440
.L443:
	mr 3,31
	bl train_next
.L440:
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
.LC82:
	.string	"train_next: bad target %s\n"
	.align 2
.LC83:
	.string	"connected teleport path_corners, see %s at %s\n"
	.align 3
.LC84:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC85:
	.long 0x3f800000
	.align 2
.LC86:
	.long 0x40400000
	.align 2
.LC87:
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
.L451:
	lwz 3,296(28)
	cmpwi 0,3,0
	bc 12,2,.L450
	bl G_PickTarget
	mr. 31,3
	bc 4,2,.L453
	lis 9,gi+4@ha
	lis 3,.LC82@ha
	lwz 4,296(28)
	lwz 0,gi+4@l(9)
	la 3,.LC82@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L450
.L453:
	lwz 0,296(31)
	stw 0,296(28)
	lwz 9,284(31)
	andi. 0,9,1
	bc 12,2,.L454
	cmpwi 0,29,0
	bc 4,2,.L455
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC83@ha
	la 3,.LC83@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L450
.L455:
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
	b .L451
.L454:
	lwz 0,264(28)
	lfs 0,592(31)
	andi. 9,0,1024
	stw 31,324(28)
	stfs 0,728(28)
	bc 4,2,.L456
	lwz 5,700(28)
	cmpwi 0,5,0
	bc 12,2,.L457
	lis 11,.LC85@ha
	lis 9,gi+16@ha
	la 11,.LC85@l(11)
	lwz 0,gi+16@l(9)
	mr 3,28
	lfs 1,0(11)
	lis 9,.LC86@ha
	li 4,10
	lis 11,.LC87@ha
	la 9,.LC86@l(9)
	mtlr 0
	la 11,.LC87@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L457:
	lwz 0,704(28)
	stw 0,76(28)
.L456:
	lfs 11,4(31)
	li 0,0
	li 9,0
	lfs 0,188(28)
	addi 11,1,8
	lis 29,train_wait@ha
	lfs 12,192(28)
	la 29,train_wait@l(29)
	addi 3,28,736
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
	stw 9,732(28)
	stfs 0,680(28)
	fsubs 12,12,10
	stw 0,376(28)
	stfs 13,736(28)
	stfs 12,16(1)
	lfs 0,8(11)
	lfs 13,4(11)
	stfs 12,684(28)
	fsubs 0,0,9
	stfs 8,652(28)
	fsubs 13,13,7
	stfs 7,656(28)
	stfs 9,660(28)
	stfs 0,744(28)
	stfs 13,740(28)
	stfs 11,676(28)
	stw 0,384(28)
	stw 0,380(28)
	bl VectorNormalize
	lfs 13,716(28)
	lfs 0,712(28)
	stfs 1,760(28)
	stw 29,768(28)
	fcmpu 0,13,0
	bc 4,2,.L458
	lfs 0,720(28)
	fcmpu 0,13,0
	bc 4,2,.L458
	lwz 0,264(28)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L459
	lwz 0,564(28)
	cmpw 0,9,0
	bc 12,2,.L460
	b .L461
.L459:
	cmpw 0,9,28
	bc 4,2,.L461
.L460:
	mr 3,28
	bl Move_Begin
	b .L464
.L461:
	lis 11,level+4@ha
	lis 10,.LC84@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC84@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(28)
	b .L465
.L458:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(28)
	lis 10,level+4@ha
	stw 9,436(28)
	lis 11,.LC84@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC84@l(11)
.L465:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(28)
.L464:
	lwz 0,284(28)
	ori 0,0,1
	stw 0,284(28)
.L450:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe20:
	.size	 train_next,.Lfe20-train_next
	.section	".rodata"
	.align 3
.LC88:
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
	lwz 9,324(31)
	li 11,0
	addi 10,1,8
	lfs 0,188(31)
	lis 29,train_wait@ha
	addi 3,31,736
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
	stw 11,732(31)
	stfs 0,680(31)
	fsubs 12,12,9
	stw 0,376(31)
	stfs 10,736(31)
	stfs 12,16(1)
	lfs 0,8(10)
	lfs 13,4(10)
	stfs 12,684(31)
	fsubs 0,0,8
	stfs 7,652(31)
	fsubs 13,13,6
	stfs 6,656(31)
	stfs 8,660(31)
	stfs 0,744(31)
	stfs 13,740(31)
	stfs 11,676(31)
	stw 0,384(31)
	stw 0,380(31)
	bl VectorNormalize
	lfs 13,716(31)
	lfs 0,712(31)
	stfs 1,760(31)
	stw 29,768(31)
	fcmpu 0,13,0
	bc 4,2,.L467
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L467
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L468
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L469
	b .L470
.L468:
	cmpw 0,9,31
	bc 4,2,.L470
.L469:
	mr 3,31
	bl Move_Begin
	b .L473
.L470:
	lis 11,level+4@ha
	lis 10,.LC88@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC88@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L474
.L467:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC88@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC88@l(11)
.L474:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L473:
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
.LC89:
	.string	"train_find: no target\n"
	.align 2
.LC90:
	.string	"train_find: target %s not found\n"
	.align 2
.LC93:
	.string	"func_train without a target at %s\n"
	.align 3
.LC92:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC94:
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
	stw 9,440(31)
	stw 0,24(31)
	stw 0,20(31)
	bc 4,2,.L494
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L488
	li 0,100
.L494:
	stw 0,516(31)
.L488:
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
	bc 12,2,.L490
	lwz 9,36(30)
	mtlr 9
	blrl
	stw 3,704(31)
.L490:
	lis 8,.LC94@ha
	lfs 13,328(31)
	la 8,.LC94@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,2,.L491
	lis 0,0x42c8
	stw 0,328(31)
.L491:
	lfs 0,328(31)
	lis 9,train_use@ha
	mr 3,31
	la 9,train_use@l(9)
	stw 9,448(31)
	stfs 0,712(31)
	stfs 0,716(31)
	stfs 0,720(31)
	lwz 9,72(30)
	mtlr 9
	blrl
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L492
	lis 11,level+4@ha
	lis 10,.LC92@ha
	lfs 0,level+4@l(11)
	lis 9,func_train_find@ha
	lfd 13,.LC92@l(10)
	la 9,func_train_find@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	b .L493
.L492:
	addi 3,31,212
	bl vtos
	mr 4,3
	lwz 0,4(30)
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L493:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe22:
	.size	 SP_func_train,.Lfe22-SP_func_train
	.section	".rodata"
	.align 2
.LC95:
	.string	"elevator used with no pathtarget\n"
	.align 2
.LC96:
	.string	"elevator used with bad pathtarget: %s\n"
	.align 2
.LC97:
	.string	"trigger_elevator has no target\n"
	.align 2
.LC98:
	.string	"trigger_elevator unable to find target %s\n"
	.align 2
.LC99:
	.string	"func_train"
	.align 2
.LC100:
	.string	"trigger_elevator target %s is not a train\n"
	.align 2
.LC105:
	.string	"func_timer at %s has random >= wait\n"
	.align 3
.LC104:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC106:
	.long 0x46fffe00
	.align 2
.LC107:
	.long 0x0
	.align 3
.LC108:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC109:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC110:
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
	lis 9,.LC107@ha
	mr 31,3
	la 9,.LC107@l(9)
	lfs 0,592(31)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L511
	lis 0,0x3f80
	stw 0,592(31)
.L511:
	lfs 0,600(31)
	lis 9,func_timer_use@ha
	lis 11,func_timer_think@ha
	lfs 13,592(31)
	la 9,func_timer_use@l(9)
	la 11,func_timer_think@l(11)
	stw 9,448(31)
	stw 11,436(31)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L512
	fmr 0,13
	lis 9,.LC104@ha
	lis 29,gi@ha
	lfd 13,.LC104@l(9)
	la 29,gi@l(29)
	addi 3,31,4
	fsub 0,0,13
	frsp 0,0
	stfs 0,600(31)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC105@ha
	la 3,.LC105@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L512:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L513
	bl rand
	rlwinm 3,3,0,17,31
	lfs 8,596(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	lfs 9,592(31)
	stw 3,28(1)
	lis 11,.LC108@ha
	lis 8,.LC106@ha
	la 11,.LC108@l(11)
	stw 0,24(1)
	lis 10,st+40@ha
	lfd 10,0(11)
	lfd 12,24(1)
	lis 11,level+4@ha
	lfs 6,.LC106@l(8)
	lis 9,.LC109@ha
	lfs 13,level+4@l(11)
	la 9,.LC109@l(9)
	fsub 12,12,10
	lfd 0,0(9)
	lfs 11,st+40@l(10)
	lis 9,.LC110@ha
	la 9,.LC110@l(9)
	lfs 10,600(31)
	frsp 12,12
	lfd 7,0(9)
	stw 31,548(31)
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
	stfs 0,428(31)
.L513:
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
.LC111:
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
	bc 12,2,.L521
	lfs 13,4(31)
	li 0,0
	addi 9,31,352
	lfs 0,352(31)
	lis 29,door_secret_move1@ha
	addi 3,31,736
	stw 0,376(31)
	la 29,door_secret_move1@l(29)
	stw 0,384(31)
	fsubs 0,0,13
	stw 0,380(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,736(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,740(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,744(31)
	bl VectorNormalize
	lfs 13,716(31)
	lfs 0,712(31)
	stfs 1,760(31)
	stw 29,768(31)
	fcmpu 0,13,0
	bc 4,2,.L523
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L523
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L524
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L525
	b .L526
.L524:
	cmpw 0,9,31
	bc 4,2,.L526
.L525:
	mr 3,31
	bl Move_Begin
	b .L529
.L526:
	lis 11,level+4@ha
	lis 10,.LC111@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC111@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L537
.L523:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC111@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC111@l(11)
.L537:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L529:
	lwz 0,296(31)
	li 29,0
	cmpwi 0,0,0
	bc 12,2,.L521
	lis 9,gi@ha
	lis 28,.LC49@ha
	la 30,gi@l(9)
	b .L532
.L534:
	lwz 3,280(29)
	la 4,.LC49@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L532
	lwz 9,64(30)
	li 4,1
	lwz 3,644(29)
	mtlr 9
	blrl
.L532:
	lwz 5,296(31)
	mr 3,29
	li 4,300
	bl G_Find
	mr. 29,3
	bc 4,2,.L534
.L521:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 door_secret_use,.Lfe24-door_secret_use
	.section	".rodata"
	.align 3
.LC112:
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
	addi 9,31,364
	lis 29,door_secret_move3@ha
	lfs 0,364(31)
	la 29,door_secret_move3@l(29)
	addi 3,31,736
	stw 0,376(31)
	stw 0,384(31)
	fsubs 0,0,13
	stw 0,380(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,736(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,740(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,744(31)
	bl VectorNormalize
	lfs 13,716(31)
	lfs 0,712(31)
	stfs 1,760(31)
	stw 29,768(31)
	fcmpu 0,13,0
	bc 4,2,.L540
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L540
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L541
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L542
	b .L543
.L541:
	cmpw 0,9,31
	bc 4,2,.L543
.L542:
	mr 3,31
	bl Move_Begin
	b .L546
.L543:
	lis 11,level+4@ha
	lis 10,.LC112@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC112@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L547
.L540:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC112@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC112@l(11)
.L547:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L546:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 door_secret_move2,.Lfe25-door_secret_move2
	.section	".rodata"
	.align 3
.LC113:
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
	addi 9,31,352
	lis 29,door_secret_move5@ha
	lfs 0,352(31)
	la 29,door_secret_move5@l(29)
	addi 3,31,736
	stw 0,376(31)
	stw 0,384(31)
	fsubs 0,0,13
	stw 0,380(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,736(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,740(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,744(31)
	bl VectorNormalize
	lfs 13,716(31)
	lfs 0,712(31)
	stfs 1,760(31)
	stw 29,768(31)
	fcmpu 0,13,0
	bc 4,2,.L551
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L551
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L552
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L553
	b .L554
.L552:
	cmpw 0,9,31
	bc 4,2,.L554
.L553:
	mr 3,31
	bl Move_Begin
	b .L557
.L554:
	lis 11,level+4@ha
	lis 10,.LC113@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC113@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L558
.L551:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC113@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC113@l(11)
.L558:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L557:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 door_secret_move4,.Lfe26-door_secret_move4
	.section	".rodata"
	.align 3
.LC114:
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
	stw 0,376(31)
	lis 9,vec3_origin@ha
	lis 29,door_secret_done@ha
	stw 0,384(31)
	la 11,vec3_origin@l(9)
	la 29,door_secret_done@l(29)
	stw 0,380(31)
	addi 3,31,736
	lfs 13,vec3_origin@l(9)
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,736(31)
	lfs 0,4(11)
	fsubs 0,0,12
	stfs 0,740(31)
	lfs 13,8(11)
	fsubs 13,13,11
	stfs 13,744(31)
	bl VectorNormalize
	lfs 13,716(31)
	lfs 0,712(31)
	stfs 1,760(31)
	stw 29,768(31)
	fcmpu 0,13,0
	bc 4,2,.L561
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L561
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L562
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L563
	b .L564
.L562:
	cmpw 0,9,31
	bc 4,2,.L564
.L563:
	mr 3,31
	bl Move_Begin
	b .L567
.L564:
	lis 11,level+4@ha
	lis 10,.LC114@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC114@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L568
.L561:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC114@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC114@l(11)
.L568:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L567:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 door_secret_move6,.Lfe27-door_secret_move6
	.section	".rodata"
	.align 2
.LC115:
	.long 0x0
	.align 3
.LC116:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC117:
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
	lis 3,.LC63@ha
	lwz 9,36(29)
	la 3,.LC63@l(3)
	mtlr 9
	blrl
	stw 3,700(31)
	lwz 9,36(29)
	lis 3,.LC64@ha
	la 3,.LC64@l(3)
	mtlr 9
	blrl
	stw 3,704(31)
	lwz 9,36(29)
	lis 3,.LC65@ha
	la 3,.LC65@l(3)
	mtlr 9
	blrl
	li 9,3
	li 0,2
	stw 3,708(31)
	stw 9,248(31)
	mr 3,31
	stw 0,260(31)
	lwz 0,44(29)
	lwz 4,268(31)
	mtlr 0
	blrl
	lwz 0,300(31)
	lis 9,door_secret_blocked@ha
	lis 11,door_secret_use@ha
	la 9,door_secret_blocked@l(9)
	la 11,door_secret_use@l(11)
	cmpwi 0,0,0
	stw 9,440(31)
	stw 11,448(31)
	bc 12,2,.L586
	lwz 0,284(31)
	andi. 7,0,1
	bc 12,2,.L585
.L586:
	lis 9,door_secret_die@ha
	li 11,0
	la 9,door_secret_die@l(9)
	li 0,1
	stw 11,480(31)
	stw 0,512(31)
	stw 9,456(31)
.L585:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L587
	li 0,2
	stw 0,516(31)
.L587:
	lis 9,.LC115@ha
	lfs 0,592(31)
	la 9,.LC115@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L588
	lis 0,0x40a0
	stw 0,592(31)
.L588:
	lis 0,0x4248
	addi 29,1,24
	addi 28,1,40
	stw 0,712(31)
	addi 4,1,8
	stw 0,716(31)
	addi 3,31,16
	mr 5,29
	stw 0,720(31)
	mr 6,28
	bl AngleVectors
	lwz 11,284(31)
	lis 10,0x4330
	lis 7,.LC116@ha
	mr 8,29
	stfs 31,16(31)
	rlwinm 0,11,0,30,30
	la 7,.LC116@l(7)
	stfs 31,24(31)
	xoris 0,0,0x8000
	lfd 12,0(7)
	mr 4,28
	stw 0,68(1)
	lis 7,.LC117@ha
	stw 10,64(1)
	la 7,.LC117@l(7)
	andi. 0,11,4
	lfd 0,64(1)
	lfd 13,0(7)
	stfs 31,20(31)
	fsub 0,0,12
	fsub 13,13,0
	frsp 7,13
	bc 12,2,.L589
	lfs 0,240(31)
	lfs 12,44(1)
	lfs 10,236(31)
	lfs 13,40(1)
	fmr 8,0
	fmuls 12,12,0
	lfs 11,244(31)
	lfs 0,48(1)
	b .L596
.L589:
	lfs 0,240(31)
	lfs 12,28(1)
	lfs 10,236(31)
	lfs 13,24(1)
	fmr 8,0
	fmuls 12,12,0
	lfs 11,244(31)
	lfs 0,32(1)
.L596:
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
	bc 12,2,.L591
	fneg 1,1
	addi 29,31,352
	addi 3,31,4
	b .L597
.L591:
	fmuls 1,7,1
	addi 29,31,352
	addi 3,31,4
	mr 4,8
.L597:
	mr 5,29
	bl VectorMA
	mr 3,29
	fmr 1,31
	addi 4,1,8
	addi 5,31,364
	bl VectorMA
	lwz 11,480(31)
	cmpwi 0,11,0
	bc 12,2,.L593
	lis 9,door_killed@ha
	li 0,1
	stw 11,484(31)
	la 9,door_killed@l(9)
	stw 0,512(31)
	stw 9,456(31)
	b .L594
.L593:
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L594
	lwz 0,276(31)
	cmpwi 0,0,0
	bc 12,2,.L594
	lis 9,gi+36@ha
	lis 3,.LC66@ha
	lwz 0,gi+36@l(9)
	la 3,.LC66@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,444(31)
.L594:
	lis 9,.LC50@ha
	lis 11,gi+72@ha
	la 9,.LC50@l(9)
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
	.align 2
	.globl Move_Done
	.type	 Move_Done,@function
Move_Done:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	li 0,0
	lwz 10,768(9)
	stw 0,376(9)
	mtlr 10
	stw 0,384(9)
	stw 0,380(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 Move_Done,.Lfe29-Move_Done
	.section	".rodata"
	.align 3
.LC118:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC119:
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
	lis 9,.LC119@ha
	mr 31,3
	la 9,.LC119@l(9)
	lfs 1,760(31)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,2,.L8
	lwz 9,768(31)
	stfs 0,376(31)
	mtlr 9
	stfs 0,384(31)
	stfs 0,380(31)
	blrl
	b .L7
.L8:
	lis 9,.LC118@ha
	addi 3,31,736
	lfd 31,.LC118@l(9)
	addi 4,31,376
	fdiv 1,1,31
	frsp 1,1
	bl VectorScale
	lis 9,Move_Done@ha
	lis 11,level+4@ha
	la 9,Move_Done@l(9)
	stw 9,436(31)
	lfs 0,level+4@l(11)
	fadd 0,0,31
	frsp 0,0
	stfs 0,428(31)
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
.LC120:
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
	stw 0,376(31)
	mr 29,5
	addi 3,31,736
	stw 0,384(31)
	stw 0,380(31)
	lfs 13,0(4)
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,736(31)
	lfs 0,4(4)
	fsubs 0,0,12
	stfs 0,740(31)
	lfs 13,8(4)
	fsubs 13,13,11
	stfs 13,744(31)
	bl VectorNormalize
	lfs 13,716(31)
	lfs 0,712(31)
	stfs 1,760(31)
	stw 29,768(31)
	fcmpu 0,13,0
	bc 4,2,.L16
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L16
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L18
	lwz 0,564(31)
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
	lis 10,.LC120@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC120@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L600
.L16:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC120@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC120@l(11)
.L600:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
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
	lwz 10,768(9)
	stw 0,388(9)
	mtlr 10
	stw 0,396(9)
	stw 0,392(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe32:
	.size	 AngleMove_Done,.Lfe32-AngleMove_Done
	.section	".rodata"
	.align 3
.LC121:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC122:
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
	lwz 0,732(31)
	cmpwi 0,0,2
	bc 4,2,.L24
	lfs 11,16(31)
	lfs 13,688(31)
	lfs 12,692(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,696(31)
	b .L601
.L24:
	lfs 11,16(31)
	lfs 13,664(31)
	lfs 12,668(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,672(31)
.L601:
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
	lwz 9,768(31)
	mr 3,31
	li 0,0
	stw 0,388(31)
	mtlr 9
	stw 0,396(31)
	stw 0,392(31)
	blrl
	b .L23
.L26:
	lis 9,.LC122@ha
	addi 3,1,8
	la 9,.LC122@l(9)
	addi 4,31,388
	lfs 1,0(9)
	bl VectorScale
	lis 9,AngleMove_Done@ha
	lis 10,level+4@ha
	la 9,AngleMove_Done@l(9)
	lis 11,.LC121@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC121@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
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
.LC123:
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
	lis 11,level+292@ha
	stw 0,388(3)
	andi. 10,9,1024
	stw 4,768(3)
	stw 0,396(3)
	stw 0,392(3)
	lwz 9,level+292@l(11)
	bc 12,2,.L41
	lwz 0,564(3)
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
	lis 10,.LC123@ha
	lfs 0,level+4@l(11)
	lis 9,AngleMove_Begin@ha
	lfd 13,.LC123@l(10)
	la 9,AngleMove_Begin@l(9)
	stw 9,436(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
.L43:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe34:
	.size	 AngleMove_Calc,.Lfe34-AngleMove_Calc
	.section	".rodata"
	.align 2
.LC124:
	.long 0x3f000000
	.align 2
.LC125:
	.long 0x0
	.align 2
.LC126:
	.long 0x3f800000
	.align 2
.LC127:
	.long 0x40800000
	.align 2
.LC128:
	.long 0xc0000000
	.align 3
.LC129:
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
	lis 9,.LC124@ha
	la 9,.LC124@l(9)
	lfs 30,0(9)
	lis 9,.LC125@ha
	la 9,.LC125@l(9)
	lfs 12,0(9)
	lis 9,.LC126@ha
	la 9,.LC126@l(9)
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
	lis 9,.LC127@ha
	fadds 31,10,31
	la 9,.LC127@l(9)
	lfs 1,0(9)
	lis 9,.LC128@ha
	fdivs 31,31,12
	la 9,.LC128@l(9)
	lfs 13,0(9)
	fmuls 0,31,1
	fmuls 13,9,13
	fmuls 0,0,13
	fsubs 1,1,0
	bl sqrt
	lis 9,.LC129@ha
	fadds 31,31,31
	lfs 13,68(31)
	la 9,.LC129@l(9)
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
.LC130:
	.long 0x3f800000
	.align 2
.LC131:
	.long 0x40400000
	.align 2
.LC132:
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
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L69
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC130@ha
	la 9,.LC130@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC131@ha
	la 9,.LC131@l(9)
	lfs 2,0(9)
	lis 9,.LC132@ha
	la 9,.LC132@l(9)
	lfs 3,0(9)
	blrl
.L69:
	stw 30,76(31)
.L68:
	lis 9,plat_go_down@ha
	li 0,0
	la 9,plat_go_down@l(9)
	stw 0,732(31)
	lis 11,level+4@ha
	stw 9,436(31)
	lis 9,.LC131@ha
	lfs 0,level+4@l(11)
	la 9,.LC131@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe36:
	.size	 plat_hit_top,.Lfe36-plat_hit_top
	.section	".rodata"
	.align 2
.LC133:
	.long 0x3f800000
	.align 2
.LC134:
	.long 0x40400000
	.align 2
.LC135:
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
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L72
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC133@ha
	la 9,.LC133@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC134@ha
	la 9,.LC134@l(9)
	lfs 2,0(9)
	lis 9,.LC135@ha
	la 9,.LC135@l(9)
	lfs 3,0(9)
	blrl
.L72:
	stw 30,76(31)
.L71:
	li 0,1
	stw 0,732(31)
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
	lwz 9,516(30)
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
	lwz 0,732(30)
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
	lwz 0,436(3)
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
	.section	".rodata"
	.align 2
.LC136:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Touch_Plat_Center
	.type	 Touch_Plat_Center,@function
Touch_Plat_Center:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L103
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L103
	lwz 3,540(3)
	lwz 0,732(3)
	cmpwi 0,0,1
	bc 4,2,.L106
	bl plat_go_up
	b .L103
.L106:
	cmpwi 0,0,0
	bc 4,2,.L103
	lis 11,.LC136@ha
	lis 9,level+4@ha
	la 11,.LC136@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,428(3)
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
	lwz 9,516(11)
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
	lfs 0,388(11)
	mr 3,4
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L130
	lfs 0,392(11)
	fcmpu 0,0,13
	bc 4,2,.L130
	lfs 0,396(11)
	fcmpu 0,0,13
	bc 12,2,.L129
.L130:
	lwz 9,516(11)
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
	addi 30,31,388
	la 4,vec3_origin@l(4)
	mr 3,30
	bl VectorCompare
	mr. 3,3
	bc 4,2,.L132
	li 0,0
	stw 3,444(31)
	stw 0,388(31)
	stw 3,76(31)
	stw 0,396(31)
	stw 0,392(31)
	b .L133
.L132:
	lwz 0,704(31)
	mr 4,30
	addi 3,31,340
	lfs 1,328(31)
	stw 0,76(31)
	bl VectorScale
	lwz 0,284(31)
	andi. 9,0,16
	bc 12,2,.L133
	lis 9,rotating_touch@ha
	la 9,rotating_touch@l(9)
	stw 9,444(31)
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
	stw 9,732(3)
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
	lwz 4,548(31)
	rlwinm 0,0,0,22,20
	stw 9,732(31)
	ori 0,0,2048
	stw 0,64(31)
	bl G_UseTargets
	lis 9,.LC138@ha
	lfs 13,728(31)
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
	stw 11,436(31)
	fadds 0,0,13
	stfs 0,428(31)
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
	stw 5,548(3)
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
	stw 0,20(1)
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L174
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L174
	stw 4,548(3)
	bl button_fire
.L174:
	lwz 0,20(1)
	mtlr 0
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
	stw 0,20(1)
	mr 9,3
	li 11,0
	lwz 0,484(9)
	stw 5,548(9)
	stw 0,480(9)
	stw 11,512(9)
	bl button_fire
	lwz 0,20(1)
	mtlr 0
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
	lwz 0,296(30)
	li 31,0
	cmpwi 0,0,0
	bc 12,2,.L188
	lis 9,gi@ha
	lis 27,.LC49@ha
	la 28,gi@l(9)
	b .L190
.L192:
	lwz 3,280(31)
	la 4,.LC49@l(27)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L190
	lwz 9,64(28)
	mr 4,29
	lwz 3,644(31)
	mtlr 9
	blrl
.L190:
	lwz 5,296(30)
	mr 3,31
	li 4,300
	bl G_Find
	mr. 31,3
	bc 4,2,.L192
.L188:
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
	bc 4,2,.L196
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L197
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
.L197:
	stw 30,76(31)
.L196:
	li 0,0
	lwz 9,284(31)
	stw 0,732(31)
	andi. 0,9,32
	bc 4,2,.L195
	lis 9,.LC141@ha
	lfs 13,728(31)
	la 9,.LC141@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L195
	lis 9,door_go_down@ha
	lis 11,level+4@ha
	la 9,door_go_down@l(9)
	stw 9,436(31)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	stfs 0,428(31)
.L195:
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
	bc 4,2,.L201
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L202
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
.L202:
	stw 30,76(31)
.L201:
	lwz 9,296(31)
	li 0,1
	li 30,0
	stw 0,732(31)
	cmpwi 0,9,0
	bc 12,2,.L204
	lis 9,gi@ha
	lis 28,.LC49@ha
	la 29,gi@l(9)
	b .L205
.L207:
	lwz 3,280(30)
	la 4,.LC49@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L205
	lwz 9,64(29)
	li 4,0
	lwz 3,644(30)
	mtlr 9
	blrl
.L205:
	lwz 5,296(31)
	mr 3,30
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L207
.L204:
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
	bc 4,2,.L261
	lwz 0,284(3)
	andi. 11,0,32
	bc 12,2,.L263
	lwz 0,732(3)
	subfic 11,0,0
	adde 9,11,0
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L263
	mr. 31,3
	bc 12,2,.L261
	li 30,0
.L268:
	stw 30,276(31)
	mr 3,31
	stw 30,444(31)
	bl door_go_down
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L268
	b .L261
.L263:
	mr. 31,3
	bc 12,2,.L261
	li 30,0
.L273:
	stw 30,276(31)
	mr 3,31
	mr 4,29
	stw 30,444(31)
	bl door_go_up
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L273
.L261:
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
	lwz 0,480(29)
	cmpwi 0,0,0
	bc 4,1,.L275
	lwz 0,184(29)
	andi. 9,0,4
	mcrf 7,0
	bc 4,30,.L277
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L275
.L277:
	lwz 11,256(3)
	lwz 0,284(11)
	andi. 10,0,8
	bc 12,2,.L278
	bc 4,30,.L275
.L278:
	lis 9,level+4@ha
	lfs 0,460(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L275
	lis 9,.LC145@ha
	fmr 0,13
	la 9,.LC145@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,460(3)
	lwz 0,264(11)
	andi. 10,0,1024
	bc 4,2,.L275
	lwz 0,284(11)
	andi. 9,0,32
	bc 12,2,.L282
	lwz 0,732(11)
	subfic 10,0,0
	adde 9,10,0
	xori 0,0,2
	subfic 10,0,0
	adde 0,10,0
	or. 10,0,9
	bc 12,2,.L282
	mr. 31,11
	bc 12,2,.L275
	li 30,0
.L286:
	stw 30,276(31)
	mr 3,31
	stw 30,444(31)
	bl door_go_down
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L286
	b .L275
.L282:
	mr. 31,11
	bc 12,2,.L275
	li 30,0
.L291:
	stw 30,276(31)
	mr 3,31
	mr 4,29
	stw 30,444(31)
	bl door_go_up
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L291
.L275:
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
	lwz 9,560(3)
	lfs 0,724(3)
	cmpwi 0,9,0
	lfs 12,716(3)
	fabs 13,0
	bc 12,2,.L297
.L299:
	lfs 0,724(9)
	fabs 0,0
	fcmpu 0,0,13
	bc 4,0,.L298
	fmr 13,0
.L298:
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L299
.L297:
	mr. 9,3
	fdivs 0,13,12
	bclr 12,2
	fmr 9,0
.L305:
	lfs 0,724(9)
	lfs 13,716(9)
	lfs 11,712(9)
	fcmpu 0,11,13
	fabs 0,0
	fdiv 0,0,9
	frsp 12,0
	fdivs 10,12,13
	bc 4,2,.L306
	stfs 12,712(9)
	b .L307
.L306:
	fmuls 0,11,10
	stfs 0,712(9)
.L307:
	lfs 13,720(9)
	lfs 0,716(9)
	fcmpu 0,13,0
	bc 4,2,.L308
	stfs 12,720(9)
	b .L309
.L308:
	fmuls 0,13,10
	stfs 0,720(9)
.L309:
	stfs 12,716(9)
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L305
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
	bc 4,2,.L344
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L344
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
	bc 12,2,.L343
	mr 3,31
	bl BecomeExplosion1
	b .L343
.L344:
	lis 6,vec3_origin@ha
	lwz 9,516(30)
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
	bc 4,2,.L343
	lis 9,.LC146@ha
	lfs 13,728(30)
	la 9,.LC146@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L343
	lwz 0,732(30)
	cmpwi 0,0,3
	bc 4,2,.L348
	lwz 31,564(30)
	cmpwi 0,31,0
	bc 12,2,.L343
.L352:
	lwz 4,548(31)
	mr 3,31
	bl door_go_up
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L352
	b .L343
.L348:
	lwz 31,564(30)
	cmpwi 0,31,0
	bc 12,2,.L343
.L358:
	mr 3,31
	bl door_go_down
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L358
.L343:
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
	lwz 9,564(3)
	mr 29,5
	cmpwi 0,9,0
	bc 12,2,.L362
	li 11,0
.L364:
	lwz 0,484(9)
	stw 11,512(9)
	stw 0,480(9)
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L364
.L362:
	lwz 3,564(3)
	lwz 0,264(3)
	andi. 9,0,1024
	bc 4,2,.L367
	lwz 0,284(3)
	andi. 11,0,32
	bc 12,2,.L368
	lwz 0,732(3)
	subfic 11,0,0
	adde 9,11,0
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L368
	mr. 31,3
	bc 12,2,.L367
	li 30,0
.L372:
	stw 30,276(31)
	mr 3,31
	stw 30,444(31)
	bl door_go_down
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L372
	b .L367
.L368:
	mr. 31,3
	bc 12,2,.L367
	li 30,0
.L377:
	stw 30,276(31)
	mr 3,31
	mr 4,29
	stw 30,444(31)
	bl door_go_up
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L377
.L367:
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
	bc 12,2,.L380
	lis 9,level+4@ha
	lfs 0,460(11)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L380
	lis 9,.LC147@ha
	fmr 0,13
	lis 29,gi@ha
	lwz 5,276(11)
	la 9,.LC147@l(9)
	la 29,gi@l(29)
	lfd 13,0(9)
	lis 4,.LC61@ha
	mr 3,31
	la 4,.LC61@l(4)
	fadd 0,0,13
	frsp 0,0
	stfs 0,460(11)
	lwz 9,12(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC62@ha
	la 3,.LC62@l(3)
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
.L380:
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
	bc 4,2,.L436
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L436
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
	bc 12,2,.L435
	mr 3,31
	bl BecomeExplosion1
	b .L435
.L436:
	lis 9,level+4@ha
	lfs 0,460(12)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L435
	lwz 9,516(12)
	cmpwi 0,9,0
	bc 12,2,.L435
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
	stfs 0,460(12)
	bl T_Damage
.L435:
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
	lwz 3,296(31)
	cmpwi 0,3,0
	bc 4,2,.L476
	lis 9,gi+4@ha
	lis 3,.LC89@ha
	lwz 0,gi+4@l(9)
	la 3,.LC89@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L475
.L476:
	bl G_PickTarget
	mr. 11,3
	bc 4,2,.L477
	lis 9,gi+4@ha
	lis 3,.LC90@ha
	lwz 4,296(31)
	lwz 0,gi+4@l(9)
	la 3,.LC90@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L475
.L477:
	lwz 0,296(11)
	lis 9,gi+72@ha
	mr 3,31
	lfs 0,188(31)
	stw 0,296(31)
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
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L478
	lwz 0,284(31)
	ori 0,0,1
	stw 0,284(31)
.L478:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L475
	lis 11,level+4@ha
	lis 10,.LC151@ha
	lfs 0,level+4@l(11)
	lis 9,train_next@ha
	lfd 13,.LC151@l(10)
	la 9,train_next@l(9)
	stw 9,436(31)
	stw 31,548(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L475:
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
	stw 5,548(3)
	andi. 0,9,1
	bc 12,2,.L481
	andi. 0,9,2
	bc 12,2,.L480
	li 0,0
	rlwinm 9,9,0,0,30
	stw 0,428(3)
	stw 9,284(3)
	stw 0,384(3)
	stw 0,380(3)
	stw 0,376(3)
	b .L480
.L481:
	lwz 0,324(3)
	cmpwi 0,0,0
	bc 12,2,.L484
	bl train_resume
	b .L480
.L484:
	bl train_next
.L480:
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
	lwz 9,416(31)
	lfs 0,428(9)
	fcmpu 0,0,13
	bc 4,2,.L495
	lwz 3,312(30)
	cmpwi 0,3,0
	bc 4,2,.L497
	lis 9,gi+4@ha
	lis 3,.LC95@ha
	lwz 0,gi+4@l(9)
	la 3,.LC95@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L495
.L497:
	bl G_PickTarget
	mr. 3,3
	bc 4,2,.L498
	lis 9,gi+4@ha
	lis 3,.LC96@ha
	lwz 4,312(30)
	lwz 0,gi+4@l(9)
	la 3,.LC96@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L495
.L498:
	lwz 9,416(31)
	stw 3,324(9)
	lwz 3,416(31)
	bl train_resume
.L495:
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
	lwz 3,296(31)
	cmpwi 0,3,0
	bc 4,2,.L500
	lis 9,gi+4@ha
	lis 3,.LC97@ha
	lwz 0,gi+4@l(9)
	la 3,.LC97@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L499
.L500:
	bl G_PickTarget
	cmpwi 0,3,0
	stw 3,416(31)
	bc 4,2,.L501
	lis 9,gi+4@ha
	lis 3,.LC98@ha
	lwz 4,296(31)
	lwz 0,gi+4@l(9)
	la 3,.LC98@l(3)
	b .L602
.L501:
	lwz 3,280(3)
	lis 4,.LC99@ha
	la 4,.LC99@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L502
	lis 9,gi+4@ha
	lis 3,.LC100@ha
	lwz 4,296(31)
	lwz 0,gi+4@l(9)
	la 3,.LC100@l(3)
.L602:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L499
.L502:
	lis 9,trigger_elevator_use@ha
	li 0,1
	la 9,trigger_elevator_use@l(9)
	stw 0,184(31)
	stw 9,448(31)
.L499:
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
	stw 9,436(3)
	lfs 0,level+4@l(10)
	lfd 13,.LC153@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
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
	lwz 4,548(29)
	bl G_UseTargets
	bl rand
	rlwinm 3,3,0,17,31
	lfs 8,592(29)
	xoris 3,3,0x8000
	lis 0,0x4330
	lfs 11,600(29)
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
	stfs 0,428(29)
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
	lfs 0,428(31)
	mr 4,5
	lfs 12,0(8)
	stw 4,548(31)
	fcmpu 0,0,12
	bc 12,2,.L506
	stfs 12,428(31)
	b .L505
.L506:
	lfs 13,596(31)
	fcmpu 0,13,12
	bc 12,2,.L507
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,13
	b .L603
.L507:
	mr 3,31
	bl G_UseTargets
	bl rand
	rlwinm 3,3,0,17,31
	lfs 8,592(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	lfs 11,600(31)
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
.L603:
	stfs 0,428(31)
.L505:
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
	bc 12,2,.L515
	li 0,0
	rlwinm 9,11,0,0,30
	stw 0,328(3)
	stw 9,284(3)
	b .L516
.L515:
	lwz 0,532(3)
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
	stfs 0,328(3)
.L516:
	lwz 0,284(3)
	andi. 0,0,2
	bc 4,2,.L517
	stw 0,532(3)
.L517:
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
	lfs 0,328(31)
	lfs 12,0(9)
	fcmpu 0,0,12
	bc 4,2,.L519
	lis 0,0x42c8
	stw 0,328(31)
.L519:
	lwz 0,284(31)
	andi. 9,0,1
	bc 4,2,.L520
	lfs 0,328(31)
	stfs 12,328(31)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	stw 9,532(31)
.L520:
	lis 9,func_conveyor_use@ha
	lis 29,gi@ha
	lwz 4,268(31)
	la 9,func_conveyor_use@l(9)
	la 29,gi@l(29)
	stw 9,448(31)
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
	stw 9,436(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
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
	lfs 13,592(3)
	la 9,.LC164@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bclr 12,2
	lis 9,level+4@ha
	lis 11,door_secret_move4@ha
	lfs 0,level+4@l(9)
	la 11,door_secret_move4@l(11)
	stw 11,436(3)
	fadds 0,0,13
	stfs 0,428(3)
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
	stw 9,436(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
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
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L571
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L570
.L571:
	li 0,0
	li 9,1
	stw 0,480(31)
	stw 9,512(31)
.L570:
	lwz 0,296(31)
	li 30,0
	cmpwi 0,0,0
	bc 12,2,.L573
	lis 9,gi@ha
	lis 28,.LC49@ha
	la 29,gi@l(9)
	b .L574
.L576:
	lwz 3,280(30)
	la 4,.LC49@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L574
	lwz 9,64(29)
	li 4,0
	lwz 3,644(30)
	mtlr 9
	blrl
.L574:
	lwz 5,296(31)
	mr 3,30
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L576
.L573:
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
	bc 4,2,.L580
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L580
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
	bc 12,2,.L579
	mr 3,31
	bl BecomeExplosion1
	b .L579
.L580:
	lis 9,level+4@ha
	lfs 0,460(12)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L579
	lis 9,.LC166@ha
	fmr 0,13
	lis 6,vec3_origin@ha
	la 9,.LC166@l(9)
	li 0,0
	lfd 13,0(9)
	li 11,20
	mr 3,31
	lwz 9,516(12)
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
	stfs 0,460(12)
	bl T_Damage
.L579:
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
	stw 0,512(3)
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
	stw 9,448(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe75:
	.size	 SP_func_killbox,.Lfe75-SP_func_killbox
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
