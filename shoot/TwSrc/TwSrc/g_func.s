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
	stfd 30,16(1)
	stfd 31,24(1)
	stw 31,12(1)
	stw 0,36(1)
	mr 31,3
	lis 9,.LC1@ha
	lfs 13,1068(31)
	lfs 12,1112(31)
	lfd 30,.LC1@l(9)
	fmr 0,13
	fmr 1,12
	fmul 0,0,30
	fcmpu 0,0,1
	cror 3,2,1
	bc 4,3,.L19
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	lfs 31,0(9)
	fcmpu 0,12,31
	bc 4,2,.L20
	lwz 0,1120(31)
	b .L27
.L20:
	fdiv 1,1,30
	addi 3,31,1088
	addi 4,31,620
	frsp 1,1
	bl VectorScale
	lwz 0,292(31)
	cmpwi 0,0,1
	bc 4,2,.L23
	lwz 11,296(31)
	lis 9,st+28@ha
	li 10,2
	mr 3,31
	stw 11,st+28@l(9)
	lwz 0,320(31)
	stw 10,292(31)
	stw 0,536(31)
	crxor 6,6,6
	bl Rplat_dr
	lwz 0,1120(31)
	mr 3,31
.L27:
	stfs 31,620(31)
	stfs 31,628(31)
	mtlr 0
	stfs 31,624(31)
	blrl
	b .L18
.L23:
	lis 9,Move_Done@ha
	lis 11,level+4@ha
	la 9,Move_Done@l(9)
	stw 9,680(31)
	lfs 0,level+4@l(11)
	fadd 0,0,30
	frsp 0,0
	stfs 0,672(31)
	b .L18
.L19:
	fmr 1,13
	addi 3,31,1088
	addi 4,31,620
	bl VectorScale
	lfs 0,1068(31)
	lfs 1,1112(31)
	fdivs 1,1,0
	fdiv 1,1,30
	bl floor
	frsp 1,1
	lfs 13,1068(31)
	lis 11,level+4@ha
	lis 9,Move_Final@ha
	lfs 0,1112(31)
	la 9,Move_Final@l(9)
	fmuls 13,1,13
	fmul 13,13,30
	fsub 0,0,13
	frsp 0,0
	stfs 0,1112(31)
	lfs 13,level+4@l(11)
	stw 9,680(31)
	fmadd 1,1,30,13
	frsp 1,1
	stfs 1,672(31)
.L18:
	lwz 0,36(1)
	mtlr 0
	lwz 31,12(1)
	lfd 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Move_Begin,.Lfe1-Move_Begin
	.section	".rodata"
	.align 3
.LC4:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC5:
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
	lwz 0,1084(31)
	cmpwi 0,0,2
	bc 4,2,.L37
	lfs 11,16(31)
	lfs 13,1040(31)
	lfs 12,1044(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,1048(31)
	b .L45
.L37:
	lfs 11,16(31)
	lfs 13,1016(31)
	lfs 12,1020(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,1024(31)
.L45:
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
	bc 4,2,.L46
	lis 9,.LC5@ha
	addi 3,1,8
	la 9,.LC5@l(9)
	addi 4,31,632
	lfs 1,0(9)
	bl VectorScale
	lwz 0,292(31)
	cmpwi 0,0,2
	bc 4,2,.L41
	li 0,3
	mr 3,31
	stw 0,292(31)
	crxor 6,6,6
	bl Rplat_Rot
.L46:
	lwz 9,1120(31)
	mr 3,31
	li 0,0
	stw 0,632(31)
	mtlr 9
	stw 0,640(31)
	stw 0,636(31)
	blrl
	b .L36
.L41:
	lis 9,AngleMove_Done@ha
	lis 10,level+4@ha
	la 9,AngleMove_Done@l(9)
	lis 11,.LC4@ha
	stw 9,680(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC4@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L36:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 AngleMove_Final,.Lfe2-AngleMove_Final
	.section	".rodata"
	.align 3
.LC6:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC7:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl AngleMove_Begin
	.type	 AngleMove_Begin,@function
AngleMove_Begin:
	stwu 1,-64(1)
	mflr 0
	stfd 29,40(1)
	stfd 30,48(1)
	stfd 31,56(1)
	stw 31,36(1)
	stw 0,68(1)
	mr 31,3
	lwz 0,1084(31)
	cmpwi 0,0,2
	bc 4,2,.L48
	lfs 11,16(31)
	lfs 13,1040(31)
	lfs 12,1044(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,1048(31)
	b .L51
.L48:
	lfs 11,16(31)
	lfs 13,1016(31)
	lfs 12,1020(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,1024(31)
.L51:
	lfs 11,24(31)
	fsubs 12,12,10
	stfs 13,8(1)
	fsubs 0,0,11
	stfs 12,12(1)
	stfs 0,16(1)
	addi 3,1,8
	bl VectorLength
	lfs 0,1068(31)
	lis 9,.LC6@ha
	lfd 29,.LC6@l(9)
	fdivs 1,1,0
	fmr 30,1
	fcmpu 0,30,29
	bc 4,0,.L50
	mr 3,31
	bl AngleMove_Final
	b .L47
.L50:
	fdiv 1,30,29
	bl floor
	lis 9,.LC7@ha
	frsp 31,1
	addi 3,1,8
	la 9,.LC7@l(9)
	addi 4,31,632
	lfd 0,0(9)
	fdiv 0,0,30
	frsp 1,0
	bl VectorScale
	lis 11,level+4@ha
	lis 9,AngleMove_Final@ha
	lfs 0,level+4@l(11)
	la 9,AngleMove_Final@l(9)
	stw 9,680(31)
	fmadd 31,31,29,0
	frsp 31,31
	stfs 31,672(31)
.L47:
	lwz 0,68(1)
	mtlr 0
	lwz 31,36(1)
	lfd 29,40(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 AngleMove_Begin,.Lfe3-AngleMove_Begin
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
	bc 4,3,.L61
	bclr 4,0
	lis 9,.LC9@ha
	lfs 0,104(3)
	la 9,.LC9@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L63
	stfs 13,104(3)
	stfs 0,96(3)
	blr
.L63:
	lfs 13,96(3)
	lfs 0,68(3)
	fcmpu 0,13,0
	bclr 4,1
	fsubs 0,13,0
	stfs 0,96(3)
	blr
.L61:
	lfs 0,96(3)
	lfs 9,100(3)
	fmr 12,0
	fcmpu 0,0,9
	bc 4,2,.L65
	fsubs 0,13,12
	fcmpu 0,0,10
	bc 4,0,.L65
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
.L65:
	lfs 13,64(3)
	fcmpu 0,12,13
	bclr 4,0
	lfs 0,60(3)
	fadds 0,12,0
	fcmpu 0,0,13
	stfs 0,96(3)
	bc 4,1,.L68
	stfs 13,96(3)
.L68:
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
.Lfe4:
	.size	 plat_Accelerate,.Lfe4-plat_Accelerate
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
	lfs 13,1100(31)
	lfs 9,0(9)
	lfs 0,1112(31)
	fcmpu 0,13,9
	fsubs 0,0,13
	stfs 0,1112(31)
	bc 4,2,.L71
	addi 30,31,1004
	lfs 10,108(30)
	lfs 11,60(30)
	lfs 12,64(30)
	fcmpu 0,10,11
	stfs 12,100(30)
	bc 4,0,.L72
	stfs 10,96(30)
	b .L71
.L72:
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
	bc 4,0,.L74
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
.L74:
	stfs 1,112(30)
.L71:
	addi 3,31,1004
	bl plat_Accelerate
	lfs 1,1112(31)
	lfs 0,1100(31)
	fcmpu 0,1,0
	cror 3,2,0
	bc 4,3,.L75
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 31,0(9)
	fcmpu 0,1,31
	bc 12,2,.L83
	lis 9,.LC12@ha
	addi 3,31,1088
	lfd 30,.LC12@l(9)
	addi 4,31,620
	fdiv 1,1,30
	frsp 1,1
	bl VectorScale
	lwz 0,292(31)
	cmpwi 0,0,1
	bc 4,2,.L79
	lwz 11,296(31)
	lis 9,st+28@ha
	li 10,2
	mr 3,31
	stw 11,st+28@l(9)
	lwz 0,320(31)
	stw 10,292(31)
	stw 0,536(31)
	crxor 6,6,6
	bl Rplat_dr
.L83:
	lwz 0,1120(31)
	mr 3,31
	stfs 31,620(31)
	stfs 31,628(31)
	mtlr 0
	stfs 31,624(31)
	blrl
	b .L70
.L79:
	lis 9,Move_Done@ha
	lis 11,level+4@ha
	la 9,Move_Done@l(9)
	stw 9,680(31)
	lfs 0,level+4@l(11)
	fadd 0,0,30
	b .L84
.L75:
	lis 9,.LC19@ha
	addi 3,31,1088
	la 9,.LC19@l(9)
	addi 4,31,620
	lfs 1,0(9)
	fmuls 1,0,1
	bl VectorScale
	lis 11,level+4@ha
	lis 10,.LC12@ha
	lfs 0,level+4@l(11)
	lis 9,Think_AccelMove@ha
	lfd 13,.LC12@l(10)
	la 9,Think_AccelMove@l(9)
	stw 9,680(31)
	fadd 0,0,13
.L84:
	frsp 0,0
	stfs 0,672(31)
.L70:
	lwz 0,52(1)
	mtlr 0
	lmw 30,16(1)
	lfd 29,24(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 Think_AccelMove,.Lfe5-Think_AccelMove
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
	lwz 0,268(31)
	andi. 9,0,1024
	bc 4,2,.L92
	lwz 5,1052(31)
	cmpwi 0,5,0
	bc 12,2,.L93
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
.L93:
	lwz 0,1056(31)
	stw 0,76(31)
.L92:
	lfs 13,4(31)
	li 0,0
	li 9,3
	lfs 0,1028(31)
	addi 11,31,1028
	lis 29,plat_hit_bottom@ha
	stw 9,1084(31)
	la 29,plat_hit_bottom@l(29)
	addi 3,31,1088
	stw 0,620(31)
	fsubs 0,0,13
	stw 0,628(31)
	stw 0,624(31)
	lfs 12,12(31)
	stfs 0,1088(31)
	lfs 13,4(11)
	lfs 0,8(31)
	fsubs 13,13,0
	stfs 13,1092(31)
	lfs 0,8(11)
	fsubs 0,0,12
	stfs 0,1096(31)
	bl VectorNormalize
	lfs 13,1068(31)
	lfs 0,1064(31)
	stfs 1,1112(31)
	stw 29,1120(31)
	fcmpu 0,13,0
	bc 4,2,.L94
	lfs 0,1072(31)
	fcmpu 0,13,0
	bc 4,2,.L94
	lwz 0,268(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L95
	lwz 0,840(31)
	cmpw 0,9,0
	bc 12,2,.L96
	b .L97
.L95:
	cmpw 0,9,31
	bc 4,2,.L97
.L96:
	mr 3,31
	bl Move_Begin
	b .L100
.L97:
	lis 11,level+4@ha
	lis 10,.LC20@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC20@l(10)
	la 9,Move_Begin@l(9)
	stw 9,680(31)
	b .L101
.L94:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,1100(31)
	lis 10,level+4@ha
	stw 9,680(31)
	lis 11,.LC20@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC20@l(11)
.L101:
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L100:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 plat_go_down,.Lfe6-plat_go_down
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
	lwz 0,268(31)
	andi. 9,0,1024
	bc 4,2,.L103
	lwz 5,1052(31)
	cmpwi 0,5,0
	bc 12,2,.L104
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
.L104:
	lwz 0,1056(31)
	stw 0,76(31)
.L103:
	lfs 13,4(31)
	li 0,0
	li 9,2
	lfs 0,1004(31)
	addi 11,31,1004
	lis 29,plat_hit_top@ha
	stw 9,1084(31)
	la 29,plat_hit_top@l(29)
	addi 3,31,1088
	stw 0,620(31)
	fsubs 0,0,13
	stw 0,628(31)
	stw 0,624(31)
	lfs 12,12(31)
	stfs 0,1088(31)
	lfs 13,4(11)
	lfs 0,8(31)
	fsubs 13,13,0
	stfs 13,1092(31)
	lfs 0,8(11)
	fsubs 0,0,12
	stfs 0,1096(31)
	bl VectorNormalize
	lfs 13,1068(31)
	lfs 0,1064(31)
	stfs 1,1112(31)
	stw 29,1120(31)
	fcmpu 0,13,0
	bc 4,2,.L105
	lfs 0,1072(31)
	fcmpu 0,13,0
	bc 4,2,.L105
	lwz 0,268(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L106
	lwz 0,840(31)
	cmpw 0,9,0
	bc 12,2,.L107
	b .L108
.L106:
	cmpw 0,9,31
	bc 4,2,.L108
.L107:
	mr 3,31
	bl Move_Begin
	b .L111
.L108:
	lis 11,level+4@ha
	lis 10,.LC24@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC24@l(10)
	la 9,Move_Begin@l(9)
	stw 9,680(31)
	b .L112
.L105:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,1100(31)
	lis 10,level+4@ha
	stw 9,680(31)
	lis 11,.LC24@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC24@l(11)
.L112:
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L111:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 plat_go_up,.Lfe7-plat_go_up
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
	stw 31,816(7)
	lfs 6,0(9)
	li 11,1
	lis 10,st+24@ha
	lis 9,Touch_Plat_Center@ha
	stw 11,248(7)
	lis 8,0x4330
	la 9,Touch_Plat_Center@l(9)
	stw 0,264(7)
	lis 11,.LC29@ha
	stw 9,688(7)
	la 11,.LC29@l(11)
	lwz 0,st+24@l(10)
	lfd 10,0(11)
	xoris 0,0,0x8000
	lfs 13,616(31)
	lis 11,.LC30@ha
	stw 0,52(1)
	la 11,.LC30@l(11)
	stw 8,48(1)
	lfd 0,48(1)
	lfs 8,604(31)
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
	lwz 0,288(31)
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
	bc 12,2,.L142
	fadds 0,0,6
	stfs 0,32(1)
.L142:
	lfs 0,24(1)
	lis 11,.LC31@ha
	lfs 13,8(1)
	la 11,.LC31@l(11)
	lfs 10,0(11)
	fsubs 0,0,13
	fcmpu 0,0,10
	cror 3,2,0
	bc 4,3,.L143
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
.L143:
	lfs 0,28(1)
	lfs 13,12(1)
	fsubs 0,0,13
	fcmpu 0,0,10
	cror 3,2,0
	bc 4,3,.L144
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
.L144:
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
.Lfe8:
	.size	 plat_spawn_inside_trigger,.Lfe8-plat_spawn_inside_trigger
	.section	".rodata"
	.align 2
.LC34:
	.long 0x41000000
	.align 3
.LC35:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC36:
	.long 0x41c80000
	.align 2
.LC37:
	.long 0x0
	.align 3
.LC38:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC39:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl red_plat_spawn_inside_trigger
	.type	 red_plat_spawn_inside_trigger,@function
red_plat_spawn_inside_trigger:
	stwu 1,-64(1)
	mflr 0
	stw 31,60(1)
	stw 0,68(1)
	mr 31,3
	bl G_Spawn
	lis 9,.LC34@ha
	mr 7,3
	la 9,.LC34@l(9)
	li 0,0
	stw 31,816(7)
	lfs 6,0(9)
	li 11,1
	lis 10,st+24@ha
	lis 9,Red_Touch_Plat_Center@ha
	stw 11,248(7)
	lis 8,0x4330
	la 9,Red_Touch_Plat_Center@l(9)
	stw 0,264(7)
	lis 11,.LC35@ha
	stw 9,688(7)
	la 11,.LC35@l(11)
	lwz 0,st+24@l(10)
	lfd 10,0(11)
	xoris 0,0,0x8000
	lfs 13,616(31)
	lis 11,.LC36@ha
	stw 0,52(1)
	la 11,.LC36@l(11)
	stw 8,48(1)
	lfd 0,48(1)
	lfs 8,604(31)
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
	lwz 0,288(31)
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
	bc 12,2,.L146
	fadds 0,0,6
	stfs 0,32(1)
.L146:
	lfs 0,24(1)
	lis 11,.LC37@ha
	lfs 13,8(1)
	la 11,.LC37@l(11)
	lfs 10,0(11)
	fsubs 0,0,13
	fcmpu 0,0,10
	cror 3,2,0
	bc 4,3,.L147
	lfs 0,188(31)
	lis 9,.LC38@ha
	lis 11,.LC39@ha
	lfs 13,200(31)
	la 9,.LC38@l(9)
	la 11,.LC39@l(11)
	lfd 11,0(9)
	lfs 12,0(11)
	fadds 0,0,13
	fmul 0,0,11
	frsp 0,0
	fadds 12,0,12
	stfs 0,8(1)
	stfs 12,24(1)
.L147:
	lfs 0,28(1)
	lfs 13,12(1)
	fsubs 0,0,13
	fcmpu 0,0,10
	cror 3,2,0
	bc 4,3,.L148
	lfs 11,204(31)
	lis 9,.LC38@ha
	lis 11,.LC39@ha
	lfs 0,192(31)
	la 9,.LC38@l(9)
	la 11,.LC39@l(11)
	lfd 12,0(9)
	lfs 13,0(11)
	fadds 0,0,11
	fmul 0,0,12
	frsp 0,0
	fadds 13,0,13
	stfs 0,12(1)
	stfs 13,28(1)
.L148:
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
.Lfe9:
	.size	 red_plat_spawn_inside_trigger,.Lfe9-red_plat_spawn_inside_trigger
	.section	".rodata"
	.align 2
.LC40:
	.long 0x41000000
	.align 3
.LC41:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC42:
	.long 0x41c80000
	.align 2
.LC43:
	.long 0x0
	.align 3
.LC44:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC45:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl blue_plat_spawn_inside_trigger
	.type	 blue_plat_spawn_inside_trigger,@function
blue_plat_spawn_inside_trigger:
	stwu 1,-64(1)
	mflr 0
	stw 31,60(1)
	stw 0,68(1)
	mr 31,3
	bl G_Spawn
	lis 9,.LC40@ha
	mr 7,3
	la 9,.LC40@l(9)
	li 0,0
	stw 31,816(7)
	lfs 6,0(9)
	li 11,1
	lis 10,st+24@ha
	lis 9,Blue_Touch_Plat_Center@ha
	stw 11,248(7)
	lis 8,0x4330
	la 9,Blue_Touch_Plat_Center@l(9)
	stw 0,264(7)
	lis 11,.LC41@ha
	stw 9,688(7)
	la 11,.LC41@l(11)
	lwz 0,st+24@l(10)
	lfd 10,0(11)
	xoris 0,0,0x8000
	lfs 13,616(31)
	lis 11,.LC42@ha
	stw 0,52(1)
	la 11,.LC42@l(11)
	stw 8,48(1)
	lfd 0,48(1)
	lfs 8,604(31)
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
	lwz 0,288(31)
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
	bc 12,2,.L150
	fadds 0,0,6
	stfs 0,32(1)
.L150:
	lfs 0,24(1)
	lis 11,.LC43@ha
	lfs 13,8(1)
	la 11,.LC43@l(11)
	lfs 10,0(11)
	fsubs 0,0,13
	fcmpu 0,0,10
	cror 3,2,0
	bc 4,3,.L151
	lfs 0,188(31)
	lis 9,.LC44@ha
	lis 11,.LC45@ha
	lfs 13,200(31)
	la 9,.LC44@l(9)
	la 11,.LC45@l(11)
	lfd 11,0(9)
	lfs 12,0(11)
	fadds 0,0,13
	fmul 0,0,11
	frsp 0,0
	fadds 12,0,12
	stfs 0,8(1)
	stfs 12,24(1)
.L151:
	lfs 0,28(1)
	lfs 13,12(1)
	fsubs 0,0,13
	fcmpu 0,0,10
	cror 3,2,0
	bc 4,3,.L152
	lfs 11,204(31)
	lis 9,.LC44@ha
	lis 11,.LC45@ha
	lfs 0,192(31)
	la 9,.LC44@l(9)
	la 11,.LC45@l(11)
	lfd 12,0(9)
	lfs 13,0(11)
	fadds 0,0,11
	fmul 0,0,12
	frsp 0,0
	fadds 13,0,13
	stfs 0,12(1)
	stfs 13,28(1)
.L152:
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
.Lfe10:
	.size	 blue_plat_spawn_inside_trigger,.Lfe10-blue_plat_spawn_inside_trigger
	.section	".rodata"
	.align 2
.LC47:
	.string	"plats/pt1_strt.wav"
	.align 2
.LC48:
	.string	"plats/pt1_mid.wav"
	.align 2
.LC49:
	.string	"plats/pt1_end.wav"
	.align 3
.LC46:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC50:
	.long 0x0
	.align 3
.LC51:
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
	lis 9,.LC50@ha
	mr 31,3
	la 9,.LC50@l(9)
	li 0,3
	lwz 4,272(31)
	lfs 31,0(9)
	lis 11,gi+44@ha
	li 9,2
	stw 0,248(31)
	stw 9,264(31)
	stfs 31,24(31)
	stfs 31,20(31)
	stfs 31,16(31)
	lwz 0,gi+44@l(11)
	mtlr 0
	blrl
	lfs 0,572(31)
	lis 9,plat_blocked@ha
	la 9,plat_blocked@l(9)
	stw 9,684(31)
	fcmpu 0,0,31
	bc 4,2,.L154
	lis 0,0x41a0
	stw 0,572(31)
	b .L155
.L154:
	lis 9,.LC46@ha
	lfd 13,.LC46@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,572(31)
.L155:
	lis 9,.LC50@ha
	lfs 13,576(31)
	la 9,.LC50@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L156
	lis 0,0x40a0
	stw 0,576(31)
	b .L157
.L156:
	fmr 0,13
	lis 9,.LC46@ha
	lfd 13,.LC46@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,576(31)
.L157:
	lis 10,.LC50@ha
	lfs 13,580(31)
	la 10,.LC50@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,2,.L158
	lis 0,0x40a0
	stw 0,580(31)
	b .L159
.L158:
	fmr 0,13
	lis 9,.LC46@ha
	lfd 13,.LC46@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,580(31)
.L159:
	lwz 0,792(31)
	cmpwi 0,0,0
	bc 4,2,.L160
	li 0,2
	stw 0,792(31)
.L160:
	lis 9,st@ha
	la 9,st@l(9)
	lwz 0,24(9)
	cmpwi 0,0,0
	bc 4,2,.L161
	li 0,8
	stw 0,24(9)
.L161:
	lfs 0,4(31)
	lfs 13,8(31)
	lfs 10,12(31)
	stfs 0,608(31)
	stfs 13,612(31)
	stfs 0,596(31)
	stfs 13,600(31)
	stfs 10,604(31)
	stfs 10,616(31)
	lwz 0,32(9)
	cmpwi 0,0,0
	bc 12,2,.L162
	xoris 0,0,0x8000
	stw 0,20(1)
	lis 11,0x4330
	lis 10,.LC51@ha
	la 10,.LC51@l(10)
	stw 11,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fsubs 0,10,0
	stfs 0,616(31)
	b .L163
.L162:
	lwz 0,24(9)
	lis 11,0x4330
	lis 10,.LC51@ha
	la 10,.LC51@l(10)
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
	stfs 13,616(31)
.L163:
	lis 9,Use_Plat@ha
	mr 3,31
	la 9,Use_Plat@l(9)
	stw 9,692(31)
	bl plat_spawn_inside_trigger
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 12,2,.L164
	li 0,2
	b .L166
.L164:
	lfs 12,608(31)
	lis 9,gi+72@ha
	mr 3,31
	lfs 0,612(31)
	lfs 13,616(31)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	li 0,1
.L166:
	stw 0,1084(31)
	lfs 2,16(31)
	lis 29,gi@ha
	lis 3,.LC47@ha
	lfs 3,20(31)
	la 29,gi@l(29)
	la 3,.LC47@l(3)
	lfs 4,24(31)
	lfs 0,572(31)
	lfs 13,576(31)
	lfs 12,580(31)
	lfs 11,884(31)
	lfs 10,596(31)
	lfs 9,600(31)
	lfs 8,604(31)
	lfs 7,608(31)
	lfs 6,612(31)
	lfs 5,616(31)
	stfs 0,1068(31)
	stfs 13,1064(31)
	stfs 12,1072(31)
	stfs 11,1080(31)
	stfs 10,1004(31)
	stfs 9,1008(31)
	stfs 8,1012(31)
	stfs 7,1028(31)
	stfs 6,1032(31)
	stfs 5,1036(31)
	stfs 2,1040(31)
	stfs 3,1044(31)
	stfs 4,1048(31)
	stfs 2,1016(31)
	stfs 3,1020(31)
	stfs 4,1024(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,1052(31)
	lwz 9,36(29)
	lis 3,.LC48@ha
	la 3,.LC48@l(3)
	mtlr 9
	blrl
	stw 3,1056(31)
	lwz 0,36(29)
	lis 3,.LC49@ha
	la 3,.LC49@l(3)
	mtlr 0
	blrl
	stw 3,1060(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe11:
	.size	 SP_func_plat,.Lfe11-SP_func_plat
	.section	".rodata"
	.align 3
.LC52:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC53:
	.long 0x0
	.align 3
.LC54:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SP_red_plat
	.type	 SP_red_plat,@function
SP_red_plat:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	lis 9,.LC53@ha
	mr 31,3
	la 9,.LC53@l(9)
	li 0,3
	lwz 4,272(31)
	lfs 31,0(9)
	lis 11,gi+44@ha
	li 9,2
	stw 0,248(31)
	stw 9,264(31)
	stfs 31,24(31)
	stfs 31,20(31)
	stfs 31,16(31)
	lwz 0,gi+44@l(11)
	mtlr 0
	blrl
	lfs 0,572(31)
	lis 9,plat_blocked@ha
	la 9,plat_blocked@l(9)
	stw 9,684(31)
	fcmpu 0,0,31
	bc 4,2,.L168
	lis 0,0x41a0
	stw 0,572(31)
	b .L169
.L168:
	lis 9,.LC52@ha
	lfd 13,.LC52@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,572(31)
.L169:
	lis 9,.LC53@ha
	lfs 13,576(31)
	la 9,.LC53@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L170
	lis 0,0x40a0
	stw 0,576(31)
	b .L171
.L170:
	fmr 0,13
	lis 9,.LC52@ha
	lfd 13,.LC52@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,576(31)
.L171:
	lis 10,.LC53@ha
	lfs 13,580(31)
	la 10,.LC53@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,2,.L172
	lis 0,0x40a0
	stw 0,580(31)
	b .L173
.L172:
	fmr 0,13
	lis 9,.LC52@ha
	lfd 13,.LC52@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,580(31)
.L173:
	lwz 0,792(31)
	cmpwi 0,0,0
	bc 4,2,.L174
	li 0,2
	stw 0,792(31)
.L174:
	lis 9,st@ha
	la 9,st@l(9)
	lwz 0,24(9)
	cmpwi 0,0,0
	bc 4,2,.L175
	li 0,8
	stw 0,24(9)
.L175:
	lfs 0,4(31)
	lfs 13,8(31)
	lfs 10,12(31)
	stfs 0,608(31)
	stfs 13,612(31)
	stfs 0,596(31)
	stfs 13,600(31)
	stfs 10,604(31)
	stfs 10,616(31)
	lwz 0,32(9)
	cmpwi 0,0,0
	bc 12,2,.L176
	xoris 0,0,0x8000
	stw 0,20(1)
	lis 11,0x4330
	lis 10,.LC54@ha
	la 10,.LC54@l(10)
	stw 11,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fsubs 0,10,0
	stfs 0,616(31)
	b .L177
.L176:
	lwz 0,24(9)
	lis 11,0x4330
	lis 10,.LC54@ha
	la 10,.LC54@l(10)
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
	stfs 13,616(31)
.L177:
	lis 9,Use_Plat@ha
	mr 3,31
	la 9,Use_Plat@l(9)
	stw 9,692(31)
	bl red_plat_spawn_inside_trigger
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 12,2,.L178
	li 0,2
	b .L180
.L178:
	lfs 12,608(31)
	lis 9,gi+72@ha
	mr 3,31
	lfs 0,612(31)
	lfs 13,616(31)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	li 0,1
.L180:
	stw 0,1084(31)
	lfs 2,16(31)
	lis 29,gi@ha
	lis 3,.LC47@ha
	lfs 3,20(31)
	la 29,gi@l(29)
	la 3,.LC47@l(3)
	lfs 4,24(31)
	lfs 0,572(31)
	lfs 13,576(31)
	lfs 12,580(31)
	lfs 11,884(31)
	lfs 10,596(31)
	lfs 9,600(31)
	lfs 8,604(31)
	lfs 7,608(31)
	lfs 6,612(31)
	lfs 5,616(31)
	stfs 0,1068(31)
	stfs 13,1064(31)
	stfs 12,1072(31)
	stfs 11,1080(31)
	stfs 10,1004(31)
	stfs 9,1008(31)
	stfs 8,1012(31)
	stfs 7,1028(31)
	stfs 6,1032(31)
	stfs 5,1036(31)
	stfs 2,1040(31)
	stfs 3,1044(31)
	stfs 4,1048(31)
	stfs 2,1016(31)
	stfs 3,1020(31)
	stfs 4,1024(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,1052(31)
	lwz 9,36(29)
	lis 3,.LC48@ha
	la 3,.LC48@l(3)
	mtlr 9
	blrl
	stw 3,1056(31)
	lwz 0,36(29)
	lis 3,.LC49@ha
	la 3,.LC49@l(3)
	mtlr 0
	blrl
	stw 3,1060(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 SP_red_plat,.Lfe12-SP_red_plat
	.section	".rodata"
	.align 3
.LC55:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC56:
	.long 0x0
	.align 3
.LC57:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SP_blue_plat
	.type	 SP_blue_plat,@function
SP_blue_plat:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	lis 9,.LC56@ha
	mr 31,3
	la 9,.LC56@l(9)
	li 0,3
	lwz 4,272(31)
	lfs 31,0(9)
	lis 11,gi+44@ha
	li 9,2
	stw 0,248(31)
	stw 9,264(31)
	stfs 31,24(31)
	stfs 31,20(31)
	stfs 31,16(31)
	lwz 0,gi+44@l(11)
	mtlr 0
	blrl
	lfs 0,572(31)
	lis 9,plat_blocked@ha
	la 9,plat_blocked@l(9)
	stw 9,684(31)
	fcmpu 0,0,31
	bc 4,2,.L182
	lis 0,0x41a0
	stw 0,572(31)
	b .L183
.L182:
	lis 9,.LC55@ha
	lfd 13,.LC55@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,572(31)
.L183:
	lis 9,.LC56@ha
	lfs 13,576(31)
	la 9,.LC56@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L184
	lis 0,0x40a0
	stw 0,576(31)
	b .L185
.L184:
	fmr 0,13
	lis 9,.LC55@ha
	lfd 13,.LC55@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,576(31)
.L185:
	lis 10,.LC56@ha
	lfs 13,580(31)
	la 10,.LC56@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,2,.L186
	lis 0,0x40a0
	stw 0,580(31)
	b .L187
.L186:
	fmr 0,13
	lis 9,.LC55@ha
	lfd 13,.LC55@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,580(31)
.L187:
	lwz 0,792(31)
	cmpwi 0,0,0
	bc 4,2,.L188
	li 0,2
	stw 0,792(31)
.L188:
	lis 9,st@ha
	la 9,st@l(9)
	lwz 0,24(9)
	cmpwi 0,0,0
	bc 4,2,.L189
	li 0,8
	stw 0,24(9)
.L189:
	lfs 0,4(31)
	lfs 13,8(31)
	lfs 10,12(31)
	stfs 0,608(31)
	stfs 13,612(31)
	stfs 0,596(31)
	stfs 13,600(31)
	stfs 10,604(31)
	stfs 10,616(31)
	lwz 0,32(9)
	cmpwi 0,0,0
	bc 12,2,.L190
	xoris 0,0,0x8000
	stw 0,20(1)
	lis 11,0x4330
	lis 10,.LC57@ha
	la 10,.LC57@l(10)
	stw 11,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fsubs 0,10,0
	stfs 0,616(31)
	b .L191
.L190:
	lwz 0,24(9)
	lis 11,0x4330
	lis 10,.LC57@ha
	la 10,.LC57@l(10)
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
	stfs 13,616(31)
.L191:
	lis 9,Use_Plat@ha
	mr 3,31
	la 9,Use_Plat@l(9)
	stw 9,692(31)
	bl blue_plat_spawn_inside_trigger
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 12,2,.L192
	li 0,2
	b .L194
.L192:
	lfs 12,608(31)
	lis 9,gi+72@ha
	mr 3,31
	lfs 0,612(31)
	lfs 13,616(31)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	li 0,1
.L194:
	stw 0,1084(31)
	lfs 2,16(31)
	lis 29,gi@ha
	lis 3,.LC47@ha
	lfs 3,20(31)
	la 29,gi@l(29)
	la 3,.LC47@l(3)
	lfs 4,24(31)
	lfs 0,572(31)
	lfs 13,576(31)
	lfs 12,580(31)
	lfs 11,884(31)
	lfs 10,596(31)
	lfs 9,600(31)
	lfs 8,604(31)
	lfs 7,608(31)
	lfs 6,612(31)
	lfs 5,616(31)
	stfs 0,1068(31)
	stfs 13,1064(31)
	stfs 12,1072(31)
	stfs 11,1080(31)
	stfs 10,1004(31)
	stfs 9,1008(31)
	stfs 8,1012(31)
	stfs 7,1028(31)
	stfs 6,1032(31)
	stfs 5,1036(31)
	stfs 2,1040(31)
	stfs 3,1044(31)
	stfs 4,1048(31)
	stfs 2,1016(31)
	stfs 3,1020(31)
	stfs 4,1024(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,1052(31)
	lwz 9,36(29)
	lis 3,.LC48@ha
	la 3,.LC48@l(3)
	mtlr 9
	blrl
	stw 3,1056(31)
	lwz 0,36(29)
	lis 3,.LC49@ha
	la 3,.LC49@l(3)
	mtlr 0
	blrl
	stw 3,1060(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 SP_blue_plat,.Lfe13-SP_blue_plat
	.section	".rodata"
	.align 2
.LC58:
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
	lwz 0,288(31)
	stw 9,248(31)
	andi. 11,0,32
	bc 12,2,.L204
	stw 9,264(31)
	b .L205
.L204:
	li 0,2
	stw 0,264(31)
.L205:
	lwz 9,288(31)
	li 0,0
	stw 0,584(31)
	andi. 11,9,4
	stw 0,592(31)
	stw 0,588(31)
	bc 12,2,.L206
	lis 0,0x3f80
	stw 0,592(31)
	b .L207
.L206:
	andi. 0,9,8
	bc 12,2,.L208
	lis 0,0x3f80
	stw 0,584(31)
	b .L207
.L208:
	lis 0,0x3f80
	stw 0,588(31)
.L207:
	lwz 0,288(31)
	andi. 9,0,2
	bc 12,2,.L210
	lfs 0,584(31)
	lfs 13,588(31)
	lfs 12,592(31)
	fneg 0,0
	fneg 13,13
	fneg 12,12
	stfs 0,584(31)
	stfs 13,588(31)
	stfs 12,592(31)
.L210:
	lis 11,.LC58@ha
	lfs 13,572(31)
	la 11,.LC58@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L211
	lis 0,0x42c8
	stw 0,572(31)
.L211:
	lwz 0,792(31)
	cmpwi 0,0,0
	bc 4,2,.L212
	li 0,2
	stw 0,792(31)
.L212:
	lwz 0,792(31)
	lis 9,rotating_use@ha
	la 9,rotating_use@l(9)
	cmpwi 0,0,0
	stw 9,692(31)
	bc 12,2,.L213
	lis 9,rotating_blocked@ha
	la 9,rotating_blocked@l(9)
	stw 9,684(31)
.L213:
	lwz 0,288(31)
	andi. 9,0,1
	bc 12,2,.L214
	lwz 9,692(31)
	mr 3,31
	li 4,0
	li 5,0
	mtlr 9
	blrl
.L214:
	lwz 0,288(31)
	andi. 9,0,64
	bc 12,2,.L215
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L215:
	lwz 0,288(31)
	andi. 11,0,128
	bc 12,2,.L216
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L216:
	lis 29,gi@ha
	mr 3,31
	lwz 4,272(31)
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
.Lfe14:
	.size	 SP_func_rotating,.Lfe14-SP_func_rotating
	.section	".rodata"
	.align 3
.LC59:
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
	addi 11,31,1004
	lfs 0,1004(31)
	lis 29,button_done@ha
	addi 3,31,1088
	stw 9,1084(31)
	la 29,button_done@l(29)
	stw 0,620(31)
	fsubs 0,0,13
	stw 0,628(31)
	stw 0,624(31)
	lfs 12,12(31)
	stfs 0,1088(31)
	lfs 13,4(11)
	lfs 0,8(31)
	fsubs 13,13,0
	stfs 13,1092(31)
	lfs 0,8(11)
	fsubs 0,0,12
	stfs 0,1096(31)
	bl VectorNormalize
	lfs 13,1068(31)
	lfs 0,1064(31)
	stfs 1,1112(31)
	stw 29,1120(31)
	fcmpu 0,13,0
	bc 4,2,.L219
	lfs 0,1072(31)
	fcmpu 0,13,0
	bc 4,2,.L219
	lwz 0,268(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L220
	lwz 0,840(31)
	cmpw 0,9,0
	bc 12,2,.L221
	b .L222
.L220:
	cmpw 0,9,31
	bc 4,2,.L222
.L221:
	mr 3,31
	bl Move_Begin
	b .L225
.L222:
	lis 11,level+4@ha
	lis 10,.LC59@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC59@l(10)
	la 9,Move_Begin@l(9)
	stw 9,680(31)
	b .L227
.L219:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,1100(31)
	lis 10,level+4@ha
	stw 9,680(31)
	lis 11,.LC59@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC59@l(11)
.L227:
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L225:
	lwz 9,728(31)
	li 0,0
	stw 0,56(31)
	cmpwi 0,9,0
	bc 12,2,.L226
	li 0,1
	stw 0,788(31)
.L226:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 button_return,.Lfe15-button_return
	.section	".rodata"
	.align 3
.LC60:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC61:
	.long 0x3f800000
	.align 2
.LC62:
	.long 0x40400000
	.align 2
.LC63:
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
	lwz 0,1084(31)
	subfic 11,0,0
	adde 9,11,0
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L230
	lwz 5,1052(31)
	li 0,2
	stw 0,1084(31)
	cmpwi 0,5,0
	bc 12,2,.L232
	lwz 0,268(31)
	andi. 9,0,1024
	bc 4,2,.L232
	lis 11,.LC61@ha
	lis 9,gi+16@ha
	la 11,.LC61@l(11)
	lwz 0,gi+16@l(9)
	lfs 1,0(11)
	lis 9,.LC62@ha
	li 4,10
	lis 11,.LC63@ha
	la 9,.LC62@l(9)
	mtlr 0
	la 11,.LC63@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L232:
	lfs 13,4(31)
	li 0,0
	addi 9,31,1028
	lfs 0,1028(31)
	lis 29,button_wait@ha
	addi 3,31,1088
	stw 0,620(31)
	la 29,button_wait@l(29)
	stw 0,628(31)
	fsubs 0,0,13
	stw 0,624(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,1088(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,1092(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,1096(31)
	bl VectorNormalize
	lfs 13,1068(31)
	lfs 0,1064(31)
	stfs 1,1112(31)
	stw 29,1120(31)
	fcmpu 0,13,0
	bc 4,2,.L233
	lfs 0,1072(31)
	fcmpu 0,13,0
	bc 4,2,.L233
	lwz 0,268(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L234
	lwz 0,840(31)
	cmpw 0,9,0
	bc 12,2,.L235
	b .L236
.L234:
	cmpw 0,9,31
	bc 4,2,.L236
.L235:
	mr 3,31
	bl Move_Begin
	b .L230
.L236:
	lis 11,level+4@ha
	lis 10,.LC60@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC60@l(10)
	la 9,Move_Begin@l(9)
	stw 9,680(31)
	b .L240
.L233:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,1100(31)
	lis 10,level+4@ha
	stw 9,680(31)
	lis 11,.LC60@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC60@l(11)
.L240:
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L230:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 button_fire,.Lfe16-button_fire
	.section	".rodata"
	.align 2
.LC64:
	.string	"EndLevel button triggered.\n"
	.align 2
.LC65:
	.string	"Result:DRAW!!\n"
	.align 2
.LC66:
	.string	"Result:Red Wins!\n"
	.align 2
.LC67:
	.string	"Result:Blue Wins!\n"
	.section	".text"
	.align 2
	.globl button_touch
	.type	 button_touch,@function
button_touch:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lwz 8,84(4)
	mr 11,3
	cmpwi 0,8,0
	bc 12,2,.L242
	lwz 0,728(4)
	cmpwi 0,0,0
	bc 4,1,.L242
	lwz 9,908(11)
	cmpwi 0,9,0
	bc 12,2,.L245
	lwz 0,908(4)
	cmpw 0,0,9
	bc 4,2,.L242
.L245:
	lis 9,level@ha
	lfs 13,936(11)
	la 10,level@l(9)
	lfs 0,4(10)
	fcmpu 0,13,0
	bc 4,0,.L247
	lwz 9,872(11)
	cmpwi 0,9,0
	bc 12,2,.L248
	lwz 0,3560(8)
	add 0,0,9
	stw 0,3560(8)
.L248:
	lwz 9,876(11)
	cmpwi 0,9,0
	bc 12,2,.L247
	lwz 0,316(10)
	cmpwi 0,0,0
	bc 4,2,.L251
	lfs 0,4(10)
	lfs 13,884(11)
	fadds 0,0,13
	stfs 0,936(11)
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L247
	lwz 0,908(4)
	cmpwi 0,0,1
	bc 4,2,.L253
	lwz 0,304(10)
	add 0,0,9
	stw 0,304(10)
	b .L247
.L253:
	lwz 0,308(10)
	add 0,0,9
	stw 0,308(10)
	b .L247
.L251:
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L247
	lwz 0,908(4)
	cmpwi 0,0,1
	bc 4,2,.L257
	lwz 0,304(10)
	add 0,0,9
	stw 0,304(10)
.L257:
	lwz 0,908(4)
	cmpwi 0,0,2
	bc 4,2,.L258
	lwz 0,308(10)
	lwz 9,876(11)
	add 0,0,9
	stw 0,308(10)
.L258:
	lwz 0,908(4)
	cmpwi 0,0,3
	bc 4,2,.L247
	lwz 0,312(10)
	lwz 9,876(11)
	add 0,0,9
	stw 0,312(10)
.L247:
	lwz 0,916(11)
	cmpwi 0,0,1
	bc 4,2,.L260
	lis 30,gi@ha
	lis 4,.LC64@ha
	lwz 9,gi@l(30)
	la 4,.LC64@l(4)
	li 3,2
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,level@ha
	la 31,level@l(9)
	lwz 11,304(31)
	lwz 0,308(31)
	cmpw 0,11,0
	bc 4,2,.L261
	lwz 9,gi@l(30)
	lis 4,.LC65@ha
	li 3,2
	la 4,.LC65@l(4)
	mtlr 9
	crxor 6,6,6
	blrl
.L261:
	lwz 9,304(31)
	lwz 0,308(31)
	cmpw 0,9,0
	bc 4,0,.L262
	lwz 9,gi@l(30)
	lis 4,.LC66@ha
	li 3,2
	la 4,.LC66@l(4)
	mtlr 9
	crxor 6,6,6
	blrl
.L262:
	lwz 9,308(31)
	lwz 0,304(31)
	cmpw 0,0,9
	bc 4,1,.L263
	lwz 0,gi@l(30)
	lis 4,.LC67@ha
	li 3,2
	la 4,.LC67@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L263:
	bl endsound_all
	bl EndDMLevel
	b .L242
.L260:
	lis 9,level+4@ha
	lfs 13,884(11)
	mr 3,11
	lfs 0,level+4@l(9)
	stw 4,824(11)
	fadds 0,0,13
	stfs 0,936(11)
	bl button_fire
.L242:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe17:
	.size	 button_touch,.Lfe17-button_touch
	.section	".rodata"
	.align 2
.LC68:
	.string	"switches/butn2.wav"
	.align 2
.LC69:
	.long 0x0
	.align 3
.LC70:
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
	addi 29,31,584
	addi 3,31,16
	mr 4,29
	bl G_SetMovedir
	li 0,3
	lis 9,gi@ha
	lwz 4,272(31)
	stw 0,248(31)
	la 30,gi@l(9)
	mr 3,31
	stw 0,264(31)
	lwz 9,44(30)
	mtlr 9
	blrl
	lwz 0,804(31)
	cmpwi 0,0,1
	bc 12,2,.L279
	lwz 0,36(30)
	lis 3,.LC68@ha
	la 3,.LC68@l(3)
	mtlr 0
	blrl
	stw 3,1052(31)
.L279:
	lis 8,.LC69@ha
	lfs 0,572(31)
	la 8,.LC69@l(8)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,2,.L280
	lis 0,0x4220
	stw 0,572(31)
.L280:
	lfs 0,576(31)
	fcmpu 0,0,13
	bc 4,2,.L281
	lfs 0,572(31)
	stfs 0,576(31)
.L281:
	lfs 0,580(31)
	fcmpu 0,0,13
	bc 4,2,.L282
	lfs 0,572(31)
	stfs 0,580(31)
.L282:
	lfs 0,884(31)
	fcmpu 0,0,13
	bc 4,2,.L283
	lis 0,0x4040
	stw 0,884(31)
.L283:
	lis 9,st@ha
	la 10,st@l(9)
	lwz 0,24(10)
	cmpwi 0,0,0
	bc 4,2,.L284
	li 0,4
	stw 0,24(10)
.L284:
	lfs 12,4(31)
	lis 11,0x4330
	lfs 13,8(31)
	lis 8,.LC70@ha
	mr 4,29
	lfs 0,12(31)
	la 8,.LC70@l(8)
	addi 3,31,596
	stfs 12,596(31)
	addi 5,31,608
	stfs 13,600(31)
	stfs 0,604(31)
	lfs 10,588(31)
	lwz 0,24(10)
	lfs 11,584(31)
	lfs 12,240(31)
	xoris 0,0,0x8000
	fabs 10,10
	stw 0,44(1)
	lfs 0,592(31)
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
	lwz 11,728(31)
	lis 9,button_use@ha
	lwz 0,64(31)
	la 9,button_use@l(9)
	cmpwi 0,11,0
	stw 9,692(31)
	ori 0,0,1024
	stw 0,64(31)
	bc 12,2,.L285
	lis 9,button_killed@ha
	li 0,1
	stw 11,756(31)
	la 9,button_killed@l(9)
	stw 0,788(31)
	stw 9,700(31)
	b .L286
.L285:
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 4,2,.L286
	lis 9,button_touch@ha
	la 9,button_touch@l(9)
	stw 9,688(31)
.L286:
	lfs 2,16(31)
	li 0,1
	lis 9,gi+72@ha
	lfs 3,20(31)
	mr 3,31
	lfs 4,24(31)
	lfs 0,572(31)
	lfs 13,576(31)
	lfs 12,580(31)
	lfs 11,884(31)
	lfs 10,596(31)
	lfs 9,600(31)
	lfs 8,604(31)
	lfs 7,608(31)
	lfs 6,612(31)
	lfs 5,616(31)
	stw 0,1084(31)
	stfs 0,1068(31)
	stfs 13,1064(31)
	stfs 12,1072(31)
	stfs 11,1080(31)
	stfs 10,1004(31)
	stfs 9,1008(31)
	stfs 8,1012(31)
	stfs 7,1028(31)
	stfs 6,1032(31)
	stfs 5,1036(31)
	stfs 2,1040(31)
	stfs 3,1044(31)
	stfs 4,1048(31)
	stfs 2,1016(31)
	stfs 3,1020(31)
	stfs 4,1024(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe18:
	.size	 SP_func_button,.Lfe18-SP_func_button
	.section	".rodata"
	.align 2
.LC71:
	.string	"func_areaportal"
	.align 2
.LC72:
	.string	"func_door"
	.align 2
.LC74:
	.string	"red_door"
	.align 2
.LC75:
	.string	"blue_door"
	.align 2
.LC76:
	.string	"func_door_rotating"
	.align 2
.LC77:
	.string	"func_rplat"
	.align 3
.LC73:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC78:
	.long 0x3f800000
	.align 2
.LC79:
	.long 0x40400000
	.align 2
.LC80:
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
	lwz 0,268(31)
	andi. 8,0,1024
	bc 4,2,.L311
	lwz 5,1052(31)
	cmpwi 0,5,0
	bc 12,2,.L312
	lis 9,gi+16@ha
	lis 11,.LC79@ha
	lwz 0,gi+16@l(9)
	lis 8,.LC80@ha
	la 11,.LC79@l(11)
	lis 9,.LC78@ha
	la 8,.LC80@l(8)
	lfs 2,0(11)
	la 9,.LC78@l(9)
	lfs 3,0(8)
	mtlr 0
	li 4,10
	lfs 1,0(9)
	blrl
.L312:
	lwz 0,1056(31)
	stw 0,76(31)
.L311:
	lwz 9,756(31)
	cmpwi 0,9,0
	bc 12,2,.L313
	li 0,1
	stw 9,728(31)
	stw 0,788(31)
.L313:
	li 0,3
	lwz 3,284(31)
	lis 4,.LC72@ha
	stw 0,1084(31)
	la 4,.LC72@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L314
	lfs 13,4(31)
	li 0,0
	addi 9,31,1004
	lfs 0,1004(31)
	lis 29,door_hit_bottom@ha
	addi 3,31,1088
	stw 0,620(31)
	la 29,door_hit_bottom@l(29)
	stw 0,628(31)
	fsubs 0,0,13
	stw 0,624(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,1088(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,1092(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,1096(31)
	bl VectorNormalize
	lfs 13,1068(31)
	lfs 0,1064(31)
	stfs 1,1112(31)
	stw 29,1120(31)
	fcmpu 0,13,0
	bc 4,2,.L315
	lfs 0,1072(31)
	fcmpu 0,13,0
	bc 4,2,.L315
	lwz 0,268(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 8,0,1024
	bc 12,2,.L316
	lwz 0,840(31)
	cmpw 0,9,0
	bc 12,2,.L317
	b .L318
.L316:
	cmpw 0,9,31
	bc 4,2,.L318
.L317:
	mr 3,31
	bl Move_Begin
	b .L314
.L318:
	lis 11,level+4@ha
	lis 10,.LC73@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC73@l(10)
	la 9,Move_Begin@l(9)
	stw 9,680(31)
	b .L352
.L315:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,1100(31)
	lis 10,level+4@ha
	stw 9,680(31)
	lis 11,.LC73@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC73@l(11)
.L352:
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L314:
	lwz 3,284(31)
	lis 4,.LC74@ha
	la 4,.LC74@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L322
	lfs 13,4(31)
	li 0,0
	addi 9,31,1004
	lfs 0,1004(31)
	lis 29,door_hit_bottom@ha
	addi 3,31,1088
	stw 0,620(31)
	la 29,door_hit_bottom@l(29)
	stw 0,628(31)
	fsubs 0,0,13
	stw 0,624(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,1088(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,1092(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,1096(31)
	bl VectorNormalize
	lfs 13,1068(31)
	lfs 0,1064(31)
	stfs 1,1112(31)
	stw 29,1120(31)
	fcmpu 0,13,0
	bc 4,2,.L323
	lfs 0,1072(31)
	fcmpu 0,13,0
	bc 4,2,.L323
	lwz 0,268(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 8,0,1024
	bc 12,2,.L324
	lwz 0,840(31)
	cmpw 0,9,0
	bc 12,2,.L325
	b .L326
.L324:
	cmpw 0,9,31
	bc 4,2,.L326
.L325:
	mr 3,31
	bl Move_Begin
	b .L322
.L326:
	lis 11,level+4@ha
	lis 10,.LC73@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC73@l(10)
	la 9,Move_Begin@l(9)
	stw 9,680(31)
	b .L353
.L323:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,1100(31)
	lis 10,level+4@ha
	stw 9,680(31)
	lis 11,.LC73@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC73@l(11)
.L353:
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L322:
	lwz 3,284(31)
	lis 4,.LC75@ha
	la 4,.LC75@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L330
	lfs 13,4(31)
	li 0,0
	addi 9,31,1004
	lfs 0,1004(31)
	lis 29,door_hit_bottom@ha
	addi 3,31,1088
	stw 0,620(31)
	la 29,door_hit_bottom@l(29)
	stw 0,628(31)
	fsubs 0,0,13
	stw 0,624(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,1088(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,1092(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,1096(31)
	bl VectorNormalize
	lfs 13,1068(31)
	lfs 0,1064(31)
	stfs 1,1112(31)
	stw 29,1120(31)
	fcmpu 0,13,0
	bc 4,2,.L331
	lfs 0,1072(31)
	fcmpu 0,13,0
	bc 4,2,.L331
	lwz 0,268(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 8,0,1024
	bc 12,2,.L332
	lwz 0,840(31)
	cmpw 0,9,0
	bc 12,2,.L333
	b .L334
.L332:
	cmpw 0,9,31
	bc 4,2,.L334
.L333:
	mr 3,31
	bl Move_Begin
	b .L338
.L334:
	lis 11,level+4@ha
	lis 10,.LC73@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC73@l(10)
	la 9,Move_Begin@l(9)
	b .L354
.L331:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,1100(31)
	lis 10,level+4@ha
	stw 9,680(31)
	lis 11,.LC73@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC73@l(11)
	b .L355
.L330:
	lwz 3,284(31)
	lis 4,.LC76@ha
	la 4,.LC76@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L339
	lwz 10,268(31)
	lis 9,door_hit_bottom@ha
	li 0,0
	la 9,door_hit_bottom@l(9)
	stw 0,632(31)
	lis 11,level+292@ha
	andi. 8,10,1024
	stw 9,1120(31)
	stw 0,640(31)
	stw 0,636(31)
	lwz 9,level+292@l(11)
	bc 4,2,.L356
	cmpw 0,9,31
	bc 12,2,.L348
	b .L349
.L339:
	lwz 3,284(31)
	lis 4,.LC77@ha
	la 4,.LC77@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L338
	lwz 10,268(31)
	lis 9,door_hit_bottom@ha
	li 0,0
	la 9,door_hit_bottom@l(9)
	stw 0,632(31)
	lis 11,level+292@ha
	andi. 8,10,1024
	stw 9,1120(31)
	stw 0,640(31)
	stw 0,636(31)
	lwz 9,level+292@l(11)
	bc 12,2,.L347
.L356:
	lwz 0,840(31)
	cmpw 0,9,0
	bc 12,2,.L348
	b .L349
.L347:
	cmpw 0,9,31
	bc 4,2,.L349
.L348:
	mr 3,31
	bl AngleMove_Begin
	b .L338
.L349:
	lis 11,level+4@ha
	lis 10,.LC73@ha
	lfs 0,level+4@l(11)
	lis 9,AngleMove_Begin@ha
	lfd 13,.LC73@l(10)
	la 9,AngleMove_Begin@l(9)
.L354:
	stw 9,680(31)
.L355:
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L338:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 door_go_down,.Lfe19-door_go_down
	.section	".rodata"
	.align 3
.LC81:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC82:
	.long 0x0
	.align 2
.LC83:
	.long 0x3f800000
	.align 2
.LC84:
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
	lwz 0,1084(31)
	cmpwi 0,0,2
	bc 12,2,.L357
	cmpwi 0,0,0
	bc 4,2,.L359
	lis 8,.LC82@ha
	lfs 13,1080(31)
	la 8,.LC82@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L357
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,13
	stfs 0,672(31)
	b .L357
.L359:
	lwz 0,268(31)
	andi. 9,0,1024
	bc 4,2,.L361
	lwz 5,1052(31)
	cmpwi 0,5,0
	bc 12,2,.L362
	lis 9,gi+16@ha
	lis 11,.LC83@ha
	lwz 0,gi+16@l(9)
	lis 8,.LC84@ha
	la 11,.LC83@l(11)
	lis 9,.LC82@ha
	la 8,.LC84@l(8)
	lfs 1,0(11)
	la 9,.LC82@l(9)
	mr 3,31
	lfs 2,0(8)
	mtlr 0
	li 4,10
	lfs 3,0(9)
	blrl
.L362:
	lwz 0,1056(31)
	stw 0,76(31)
.L361:
	li 0,2
	lwz 3,284(31)
	lis 4,.LC72@ha
	stw 0,1084(31)
	la 4,.LC72@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L363
	lfs 13,4(31)
	li 0,0
	addi 9,31,1028
	lfs 0,1028(31)
	lis 29,door_hit_top@ha
	addi 3,31,1088
	stw 0,620(31)
	la 29,door_hit_top@l(29)
	stw 0,628(31)
	fsubs 0,0,13
	stw 0,624(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,1088(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,1092(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,1096(31)
	bl VectorNormalize
	lfs 13,1068(31)
	lfs 0,1064(31)
	stfs 1,1112(31)
	stw 29,1120(31)
	fcmpu 0,13,0
	bc 4,2,.L364
	lfs 0,1072(31)
	fcmpu 0,13,0
	bc 4,2,.L364
	lwz 0,268(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 8,0,1024
	bc 12,2,.L365
	lwz 0,840(31)
	cmpw 0,9,0
	b .L413
.L365:
	cmpw 0,9,31
.L413:
	bc 12,2,.L384
	lis 11,level+4@ha
	lis 10,.LC81@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC81@l(10)
	la 9,Move_Begin@l(9)
	b .L410
.L364:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,1100(31)
	lis 10,level+4@ha
	stw 9,680(31)
	lis 11,.LC81@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC81@l(11)
	b .L411
.L363:
	lwz 3,284(31)
	lis 4,.LC74@ha
	la 4,.LC74@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L372
	lfs 13,4(31)
	li 0,0
	addi 9,31,1028
	lfs 0,1028(31)
	lis 29,door_hit_top@ha
	addi 3,31,1088
	stw 0,620(31)
	la 29,door_hit_top@l(29)
	stw 0,628(31)
	fsubs 0,0,13
	stw 0,624(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,1088(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,1092(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,1096(31)
	bl VectorNormalize
	lfs 13,1068(31)
	lfs 0,1064(31)
	stfs 1,1112(31)
	stw 29,1120(31)
	fcmpu 0,13,0
	bc 4,2,.L373
	lfs 0,1072(31)
	fcmpu 0,13,0
	bc 4,2,.L373
	lwz 0,268(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 8,0,1024
	bc 12,2,.L374
	lwz 0,840(31)
	cmpw 0,9,0
	b .L414
.L374:
	cmpw 0,9,31
.L414:
	bc 12,2,.L384
	lis 11,level+4@ha
	lis 10,.LC81@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC81@l(10)
	la 9,Move_Begin@l(9)
	b .L410
.L373:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,1100(31)
	lis 10,level+4@ha
	stw 9,680(31)
	lis 11,.LC81@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC81@l(11)
	b .L411
.L372:
	lwz 3,284(31)
	lis 4,.LC75@ha
	la 4,.LC75@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L381
	lfs 13,4(31)
	li 0,0
	addi 9,31,1028
	lfs 0,1028(31)
	lis 29,door_hit_top@ha
	addi 3,31,1088
	stw 0,620(31)
	la 29,door_hit_top@l(29)
	stw 0,628(31)
	fsubs 0,0,13
	stw 0,624(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,1088(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,1092(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,1096(31)
	bl VectorNormalize
	lfs 13,1068(31)
	lfs 0,1064(31)
	stfs 1,1112(31)
	stw 29,1120(31)
	fcmpu 0,13,0
	bc 4,2,.L382
	lfs 0,1072(31)
	fcmpu 0,13,0
	bc 4,2,.L382
	lwz 0,268(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 8,0,1024
	bc 12,2,.L383
	lwz 0,840(31)
	cmpw 0,9,0
	bc 12,2,.L384
	b .L385
.L383:
	cmpw 0,9,31
	bc 4,2,.L385
.L384:
	mr 3,31
	bl Move_Begin
	b .L371
.L385:
	lis 11,level+4@ha
	lis 10,.LC81@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC81@l(10)
	la 9,Move_Begin@l(9)
	b .L410
.L382:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,1100(31)
	lis 10,level+4@ha
	stw 9,680(31)
	lis 11,.LC81@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC81@l(11)
	b .L411
.L381:
	lwz 3,284(31)
	lis 4,.LC76@ha
	la 4,.LC76@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L390
	lwz 10,268(31)
	lis 9,door_hit_top@ha
	li 0,0
	la 9,door_hit_top@l(9)
	stw 0,632(31)
	lis 11,level+292@ha
	andi. 8,10,1024
	stw 9,1120(31)
	stw 0,640(31)
	stw 0,636(31)
	lwz 9,level+292@l(11)
	bc 4,2,.L412
	cmpw 0,9,31
	bc 12,2,.L399
	b .L400
.L390:
	lwz 3,284(31)
	lis 4,.LC77@ha
	la 4,.LC77@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L371
	lwz 10,268(31)
	lis 9,door_hit_top@ha
	li 0,0
	la 9,door_hit_top@l(9)
	stw 0,632(31)
	lis 11,level+292@ha
	andi. 8,10,1024
	stw 9,1120(31)
	stw 0,640(31)
	stw 0,636(31)
	lwz 9,level+292@l(11)
	bc 12,2,.L398
.L412:
	lwz 0,840(31)
	cmpw 0,9,0
	bc 12,2,.L399
	b .L400
.L398:
	cmpw 0,9,31
	bc 4,2,.L400
.L399:
	mr 3,31
	bl AngleMove_Begin
	b .L371
.L400:
	lis 11,level+4@ha
	lis 10,.LC81@ha
	lfs 0,level+4@l(11)
	lis 9,AngleMove_Begin@ha
	lfd 13,.LC81@l(10)
	la 9,AngleMove_Begin@l(9)
.L410:
	stw 9,680(31)
.L411:
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L371:
	mr 4,30
	mr 3,31
	bl G_UseTargets
	li 29,0
	lwz 0,532(31)
	cmpwi 0,0,0
	bc 12,2,.L357
	lis 9,gi@ha
	lis 28,.LC71@ha
	la 30,gi@l(9)
	b .L405
.L407:
	lwz 3,284(29)
	la 4,.LC71@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L405
	lwz 9,64(30)
	li 4,1
	lwz 3,996(29)
	mtlr 9
	blrl
.L405:
	lwz 5,532(31)
	mr 3,29
	li 4,536
	bl G_Find
	mr. 29,3
	bc 4,2,.L407
.L357:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 door_go_up,.Lfe20-door_go_up
	.section	".rodata"
	.align 2
.LC85:
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
	lwz 0,268(29)
	andi. 9,0,1024
	bc 4,2,.L505
	lwz 31,836(29)
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
	bc 12,2,.L508
	addi 30,1,24
.L510:
	addi 3,31,212
	addi 4,1,8
	mr 5,30
	bl AddPointToBounds
	addi 3,31,224
	addi 4,1,8
	mr 5,30
	bl AddPointToBounds
	lwz 31,836(31)
	cmpwi 0,31,0
	bc 4,2,.L510
.L508:
	lis 9,.LC85@ha
	lfs 10,8(1)
	la 9,.LC85@l(9)
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
	stw 10,264(31)
	stfs 13,208(31)
	stw 11,688(31)
	stw 29,256(31)
	lwz 9,72(30)
	mtlr 9
	blrl
	lwz 0,288(29)
	andi. 9,0,1
	bc 12,2,.L512
	lwz 0,532(29)
	li 31,0
	cmpwi 0,0,0
	bc 12,2,.L512
	mr 28,30
	lis 30,.LC71@ha
	b .L515
.L517:
	lwz 3,284(31)
	la 4,.LC71@l(30)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L515
	lwz 9,64(28)
	li 4,1
	lwz 3,996(31)
	mtlr 9
	blrl
.L515:
	lwz 5,532(29)
	mr 3,31
	li 4,536
	bl G_Find
	mr. 31,3
	bc 4,2,.L517
.L512:
	lwz 0,268(29)
	andi. 9,0,1024
	bc 4,2,.L505
	lwz 9,836(29)
	lfs 0,1076(29)
	cmpwi 0,9,0
	lfs 12,1068(29)
	fabs 13,0
	bc 12,2,.L527
.L524:
	lfs 0,1076(9)
	fabs 0,0
	fcmpu 0,0,13
	bc 4,0,.L526
	fmr 13,0
.L526:
	lwz 9,836(9)
	cmpwi 0,9,0
	bc 4,2,.L524
.L527:
	mr. 9,29
	fdivs 0,13,12
	bc 12,2,.L505
	fmr 9,0
.L530:
	lfs 0,1076(9)
	lfs 13,1068(9)
	lfs 11,1064(9)
	fcmpu 0,11,13
	fabs 0,0
	fdiv 0,0,9
	frsp 12,0
	fdivs 10,12,13
	bc 4,2,.L531
	stfs 12,1064(9)
	b .L532
.L531:
	fmuls 0,11,10
	stfs 0,1064(9)
.L532:
	lfs 13,1072(9)
	lfs 0,1068(9)
	fcmpu 0,13,0
	bc 4,2,.L533
	stfs 12,1072(9)
	b .L534
.L533:
	fmuls 0,13,10
	stfs 0,1072(9)
.L534:
	stfs 12,1068(9)
	lwz 9,836(9)
	cmpwi 0,9,0
	bc 4,2,.L530
.L505:
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe21:
	.size	 Think_SpawnDoorTrigger,.Lfe21-Think_SpawnDoorTrigger
	.section	".rodata"
	.align 2
.LC86:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl Think_Red_SpawnDoorTrigger
	.type	 Think_Red_SpawnDoorTrigger,@function
Think_Red_SpawnDoorTrigger:
	stwu 1,-64(1)
	mflr 0
	stmw 28,48(1)
	stw 0,68(1)
	mr 29,3
	lwz 0,268(29)
	andi. 9,0,1024
	bc 4,2,.L537
	lwz 31,836(29)
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
	bc 12,2,.L540
	addi 30,1,24
.L542:
	addi 3,31,212
	addi 4,1,8
	mr 5,30
	bl AddPointToBounds
	addi 3,31,224
	addi 4,1,8
	mr 5,30
	bl AddPointToBounds
	lwz 31,836(31)
	cmpwi 0,31,0
	bc 4,2,.L542
.L540:
	lis 9,.LC86@ha
	lfs 10,8(1)
	la 9,.LC86@l(9)
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
	lis 11,Touch_Red_DoorTrigger@ha
	li 0,1
	la 11,Touch_Red_DoorTrigger@l(11)
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
	stw 10,264(31)
	stfs 13,208(31)
	stw 11,688(31)
	stw 29,256(31)
	lwz 9,72(30)
	mtlr 9
	blrl
	lwz 0,288(29)
	andi. 9,0,1
	bc 12,2,.L544
	lwz 0,532(29)
	li 31,0
	cmpwi 0,0,0
	bc 12,2,.L544
	mr 28,30
	lis 30,.LC71@ha
	b .L547
.L549:
	lwz 3,284(31)
	la 4,.LC71@l(30)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L547
	lwz 9,64(28)
	li 4,1
	lwz 3,996(31)
	mtlr 9
	blrl
.L547:
	lwz 5,532(29)
	mr 3,31
	li 4,536
	bl G_Find
	mr. 31,3
	bc 4,2,.L549
.L544:
	lwz 0,268(29)
	andi. 9,0,1024
	bc 4,2,.L537
	lwz 9,836(29)
	lfs 0,1076(29)
	cmpwi 0,9,0
	lfs 12,1068(29)
	fabs 13,0
	bc 12,2,.L559
.L556:
	lfs 0,1076(9)
	fabs 0,0
	fcmpu 0,0,13
	bc 4,0,.L558
	fmr 13,0
.L558:
	lwz 9,836(9)
	cmpwi 0,9,0
	bc 4,2,.L556
.L559:
	mr. 9,29
	fdivs 0,13,12
	bc 12,2,.L537
	fmr 9,0
.L562:
	lfs 0,1076(9)
	lfs 13,1068(9)
	lfs 11,1064(9)
	fcmpu 0,11,13
	fabs 0,0
	fdiv 0,0,9
	frsp 12,0
	fdivs 10,12,13
	bc 4,2,.L563
	stfs 12,1064(9)
	b .L564
.L563:
	fmuls 0,11,10
	stfs 0,1064(9)
.L564:
	lfs 13,1072(9)
	lfs 0,1068(9)
	fcmpu 0,13,0
	bc 4,2,.L565
	stfs 12,1072(9)
	b .L566
.L565:
	fmuls 0,13,10
	stfs 0,1072(9)
.L566:
	stfs 12,1068(9)
	lwz 9,836(9)
	cmpwi 0,9,0
	bc 4,2,.L562
.L537:
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe22:
	.size	 Think_Red_SpawnDoorTrigger,.Lfe22-Think_Red_SpawnDoorTrigger
	.section	".rodata"
	.align 2
.LC87:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl Think_Blue_SpawnDoorTrigger
	.type	 Think_Blue_SpawnDoorTrigger,@function
Think_Blue_SpawnDoorTrigger:
	stwu 1,-64(1)
	mflr 0
	stmw 28,48(1)
	stw 0,68(1)
	mr 29,3
	lwz 0,268(29)
	andi. 9,0,1024
	bc 4,2,.L569
	lwz 31,836(29)
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
	bc 12,2,.L572
	addi 30,1,24
.L574:
	addi 3,31,212
	addi 4,1,8
	mr 5,30
	bl AddPointToBounds
	addi 3,31,224
	addi 4,1,8
	mr 5,30
	bl AddPointToBounds
	lwz 31,836(31)
	cmpwi 0,31,0
	bc 4,2,.L574
.L572:
	lis 9,.LC87@ha
	lfs 10,8(1)
	la 9,.LC87@l(9)
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
	lis 11,Touch_Blue_DoorTrigger@ha
	li 0,1
	la 11,Touch_Blue_DoorTrigger@l(11)
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
	stw 10,264(31)
	stfs 13,208(31)
	stw 11,688(31)
	stw 29,256(31)
	lwz 9,72(30)
	mtlr 9
	blrl
	lwz 0,288(29)
	andi. 9,0,1
	bc 12,2,.L576
	lwz 0,532(29)
	li 31,0
	cmpwi 0,0,0
	bc 12,2,.L576
	mr 28,30
	lis 30,.LC71@ha
	b .L579
.L581:
	lwz 3,284(31)
	la 4,.LC71@l(30)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L579
	lwz 9,64(28)
	li 4,1
	lwz 3,996(31)
	mtlr 9
	blrl
.L579:
	lwz 5,532(29)
	mr 3,31
	li 4,536
	bl G_Find
	mr. 31,3
	bc 4,2,.L581
.L576:
	lwz 0,268(29)
	andi. 9,0,1024
	bc 4,2,.L569
	lwz 9,836(29)
	lfs 0,1076(29)
	cmpwi 0,9,0
	lfs 12,1068(29)
	fabs 13,0
	bc 12,2,.L591
.L588:
	lfs 0,1076(9)
	fabs 0,0
	fcmpu 0,0,13
	bc 4,0,.L590
	fmr 13,0
.L590:
	lwz 9,836(9)
	cmpwi 0,9,0
	bc 4,2,.L588
.L591:
	mr. 9,29
	fdivs 0,13,12
	bc 12,2,.L569
	fmr 9,0
.L594:
	lfs 0,1076(9)
	lfs 13,1068(9)
	lfs 11,1064(9)
	fcmpu 0,11,13
	fabs 0,0
	fdiv 0,0,9
	frsp 12,0
	fdivs 10,12,13
	bc 4,2,.L595
	stfs 12,1064(9)
	b .L596
.L595:
	fmuls 0,11,10
	stfs 0,1064(9)
.L596:
	lfs 13,1072(9)
	lfs 0,1068(9)
	fcmpu 0,13,0
	bc 4,2,.L597
	stfs 12,1072(9)
	b .L598
.L597:
	fmuls 0,13,10
	stfs 0,1072(9)
.L598:
	stfs 12,1068(9)
	lwz 9,836(9)
	cmpwi 0,9,0
	bc 4,2,.L594
.L569:
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe23:
	.size	 Think_Blue_SpawnDoorTrigger,.Lfe23-Think_Blue_SpawnDoorTrigger
	.section	".rodata"
	.align 2
.LC88:
	.string	"%s"
	.align 2
.LC89:
	.string	"misc/talk1.wav"
	.align 2
.LC90:
	.string	"doors/dr1_strt.wav"
	.align 2
.LC91:
	.string	"doors/dr1_mid.wav"
	.align 2
.LC92:
	.string	"doors/dr1_end.wav"
	.align 2
.LC93:
	.string	"misc/talk.wav"
	.align 3
.LC94:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC95:
	.long 0x0
	.align 3
.LC96:
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
	lwz 0,804(31)
	cmpwi 0,0,1
	bc 12,2,.L642
	lis 29,gi@ha
	lis 3,.LC90@ha
	la 29,gi@l(29)
	la 3,.LC90@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,1052(31)
	lwz 9,36(29)
	lis 3,.LC91@ha
	la 3,.LC91@l(3)
	mtlr 9
	blrl
	stw 3,1056(31)
	lwz 0,36(29)
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	mtlr 0
	blrl
	stw 3,1060(31)
.L642:
	addi 29,31,584
	addi 3,31,16
	mr 4,29
	li 30,2
	bl G_SetMovedir
	li 0,3
	lis 9,gi@ha
	stw 30,264(31)
	la 28,gi@l(9)
	stw 0,248(31)
	mr 3,31
	lwz 9,44(28)
	lwz 4,272(31)
	mtlr 9
	blrl
	lis 8,.LC95@ha
	lfs 0,572(31)
	lis 9,door_blocked@ha
	la 8,.LC95@l(8)
	lis 11,door_use@ha
	lfs 13,0(8)
	la 9,door_blocked@l(9)
	la 11,door_use@l(11)
	stw 9,684(31)
	stw 11,692(31)
	fcmpu 0,0,13
	bc 4,2,.L643
	lis 0,0x42c8
	stw 0,572(31)
.L643:
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L644
	lfs 0,572(31)
	fadds 0,0,0
	stfs 0,572(31)
.L644:
	lfs 0,576(31)
	fcmpu 0,0,13
	bc 4,2,.L645
	lfs 0,572(31)
	stfs 0,576(31)
.L645:
	lfs 0,580(31)
	fcmpu 0,0,13
	bc 4,2,.L646
	lfs 0,572(31)
	stfs 0,580(31)
.L646:
	lfs 0,884(31)
	fcmpu 0,0,13
	bc 4,2,.L647
	lis 0,0x4040
	stw 0,884(31)
.L647:
	lis 9,st@ha
	la 10,st@l(9)
	lwz 0,24(10)
	cmpwi 0,0,0
	bc 4,2,.L648
	li 0,8
	stw 0,24(10)
.L648:
	lwz 0,792(31)
	cmpwi 0,0,0
	bc 4,2,.L649
	stw 30,792(31)
.L649:
	lfs 12,4(31)
	lis 11,0x4330
	lfs 13,8(31)
	lis 8,.LC96@ha
	mr 4,29
	lfs 0,12(31)
	la 8,.LC96@l(8)
	addi 3,31,596
	stfs 12,596(31)
	addi 5,31,608
	stfs 13,600(31)
	stfs 0,604(31)
	lfs 9,588(31)
	lwz 0,24(10)
	lfs 10,584(31)
	lfs 11,240(31)
	xoris 0,0,0x8000
	fabs 9,9
	stw 0,28(1)
	lfs 0,592(31)
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
	stfs 0,1076(31)
	bl VectorMA
	lwz 0,288(31)
	andi. 8,0,1
	bc 12,2,.L650
	lfs 11,608(31)
	lfs 10,612(31)
	lfs 9,616(31)
	lfs 0,596(31)
	lfs 13,600(31)
	lfs 12,604(31)
	stfs 0,608(31)
	stfs 13,612(31)
	stfs 12,616(31)
	stfs 11,596(31)
	stfs 10,600(31)
	stfs 9,604(31)
	stfs 11,4(31)
	stfs 10,8(31)
	stfs 9,12(31)
.L650:
	lwz 0,728(31)
	li 11,1
	stw 11,1084(31)
	cmpwi 0,0,0
	bc 12,2,.L651
	lis 9,door_killed@ha
	stw 11,788(31)
	la 9,door_killed@l(9)
	stw 0,756(31)
	stw 9,700(31)
	b .L652
.L651:
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 12,2,.L652
	lwz 0,280(31)
	cmpwi 0,0,0
	bc 12,2,.L652
	lwz 0,36(28)
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,688(31)
.L652:
	lwz 0,288(31)
	lfs 3,16(31)
	lfs 2,20(31)
	andi. 8,0,16
	lfs 4,24(31)
	lfs 0,572(31)
	lfs 13,576(31)
	lfs 12,580(31)
	lfs 11,884(31)
	lfs 10,596(31)
	lfs 9,600(31)
	lfs 8,604(31)
	lfs 7,608(31)
	lfs 6,612(31)
	lfs 5,616(31)
	stfs 0,1068(31)
	stfs 13,1064(31)
	stfs 12,1072(31)
	stfs 11,1080(31)
	stfs 10,1004(31)
	stfs 9,1008(31)
	stfs 8,1012(31)
	stfs 7,1028(31)
	stfs 6,1032(31)
	stfs 5,1036(31)
	stfs 3,1040(31)
	stfs 2,1044(31)
	stfs 4,1048(31)
	stfs 3,1016(31)
	stfs 2,1020(31)
	stfs 4,1024(31)
	bc 12,2,.L654
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L654:
	lwz 0,288(31)
	andi. 9,0,64
	bc 12,2,.L655
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L655:
	lwz 0,544(31)
	cmpwi 0,0,0
	bc 4,2,.L656
	stw 31,840(31)
.L656:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC94@ha
	lwz 0,728(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC94@l(11)
	cmpwi 0,0,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
	bc 4,2,.L658
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 12,2,.L657
.L658:
	lis 9,Think_CalcMoveSpeed@ha
	la 9,Think_CalcMoveSpeed@l(9)
	b .L660
.L657:
	lis 9,Think_SpawnDoorTrigger@ha
	la 9,Think_SpawnDoorTrigger@l(9)
.L660:
	stw 9,680(31)
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe24:
	.size	 SP_func_door,.Lfe24-SP_func_door
	.section	".rodata"
	.align 3
.LC97:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC98:
	.long 0x0
	.align 3
.LC99:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SP_red_door
	.type	 SP_red_door,@function
SP_red_door:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,804(31)
	cmpwi 0,0,1
	bc 12,2,.L662
	lis 29,gi@ha
	lis 3,.LC90@ha
	la 29,gi@l(29)
	la 3,.LC90@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,1052(31)
	lwz 9,36(29)
	lis 3,.LC91@ha
	la 3,.LC91@l(3)
	mtlr 9
	blrl
	stw 3,1056(31)
	lwz 0,36(29)
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	mtlr 0
	blrl
	stw 3,1060(31)
.L662:
	addi 29,31,584
	addi 3,31,16
	mr 4,29
	li 30,2
	bl G_SetMovedir
	li 0,3
	lis 9,gi@ha
	stw 30,264(31)
	la 28,gi@l(9)
	stw 0,248(31)
	mr 3,31
	lwz 9,44(28)
	lwz 4,272(31)
	mtlr 9
	blrl
	lis 8,.LC98@ha
	lfs 0,572(31)
	lis 9,door_blocked@ha
	la 8,.LC98@l(8)
	lis 11,door_use@ha
	lfs 13,0(8)
	la 9,door_blocked@l(9)
	la 11,door_use@l(11)
	stw 9,684(31)
	stw 11,692(31)
	fcmpu 0,0,13
	bc 4,2,.L663
	lis 0,0x42c8
	stw 0,572(31)
.L663:
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L664
	lfs 0,572(31)
	fadds 0,0,0
	stfs 0,572(31)
.L664:
	lfs 0,576(31)
	fcmpu 0,0,13
	bc 4,2,.L665
	lfs 0,572(31)
	stfs 0,576(31)
.L665:
	lfs 0,580(31)
	fcmpu 0,0,13
	bc 4,2,.L666
	lfs 0,572(31)
	stfs 0,580(31)
.L666:
	lfs 0,884(31)
	fcmpu 0,0,13
	bc 4,2,.L667
	lis 0,0x4040
	stw 0,884(31)
.L667:
	lis 9,st@ha
	la 10,st@l(9)
	lwz 0,24(10)
	cmpwi 0,0,0
	bc 4,2,.L668
	li 0,8
	stw 0,24(10)
.L668:
	lwz 0,792(31)
	cmpwi 0,0,0
	bc 4,2,.L669
	stw 30,792(31)
.L669:
	lfs 12,4(31)
	lis 11,0x4330
	lfs 13,8(31)
	lis 8,.LC99@ha
	mr 4,29
	lfs 0,12(31)
	la 8,.LC99@l(8)
	addi 3,31,596
	stfs 12,596(31)
	addi 5,31,608
	stfs 13,600(31)
	stfs 0,604(31)
	lfs 9,588(31)
	lwz 0,24(10)
	lfs 10,584(31)
	lfs 11,240(31)
	xoris 0,0,0x8000
	fabs 9,9
	stw 0,28(1)
	lfs 0,592(31)
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
	stfs 0,1076(31)
	bl VectorMA
	lwz 0,288(31)
	andi. 8,0,1
	bc 12,2,.L670
	lfs 11,608(31)
	lfs 10,612(31)
	lfs 9,616(31)
	lfs 0,596(31)
	lfs 13,600(31)
	lfs 12,604(31)
	stfs 0,608(31)
	stfs 13,612(31)
	stfs 12,616(31)
	stfs 11,596(31)
	stfs 10,600(31)
	stfs 9,604(31)
	stfs 11,4(31)
	stfs 10,8(31)
	stfs 9,12(31)
.L670:
	lwz 0,728(31)
	li 11,1
	stw 11,1084(31)
	cmpwi 0,0,0
	bc 12,2,.L671
	lis 9,door_killed@ha
	stw 11,788(31)
	la 9,door_killed@l(9)
	stw 0,756(31)
	stw 9,700(31)
	b .L672
.L671:
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 12,2,.L672
	lwz 0,280(31)
	cmpwi 0,0,0
	bc 12,2,.L672
	lwz 0,36(28)
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,688(31)
.L672:
	lwz 0,288(31)
	lfs 3,16(31)
	lfs 2,20(31)
	andi. 8,0,16
	lfs 4,24(31)
	lfs 0,572(31)
	lfs 13,576(31)
	lfs 12,580(31)
	lfs 11,884(31)
	lfs 10,596(31)
	lfs 9,600(31)
	lfs 8,604(31)
	lfs 7,608(31)
	lfs 6,612(31)
	lfs 5,616(31)
	stfs 0,1068(31)
	stfs 13,1064(31)
	stfs 12,1072(31)
	stfs 11,1080(31)
	stfs 10,1004(31)
	stfs 9,1008(31)
	stfs 8,1012(31)
	stfs 7,1028(31)
	stfs 6,1032(31)
	stfs 5,1036(31)
	stfs 3,1040(31)
	stfs 2,1044(31)
	stfs 4,1048(31)
	stfs 3,1016(31)
	stfs 2,1020(31)
	stfs 4,1024(31)
	bc 12,2,.L674
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L674:
	lwz 0,288(31)
	andi. 9,0,64
	bc 12,2,.L675
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L675:
	lwz 0,544(31)
	cmpwi 0,0,0
	bc 4,2,.L676
	stw 31,840(31)
.L676:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC97@ha
	lwz 0,728(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC97@l(11)
	cmpwi 0,0,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
	bc 4,2,.L678
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 12,2,.L677
.L678:
	lis 9,Think_CalcMoveSpeed@ha
	la 9,Think_CalcMoveSpeed@l(9)
	b .L680
.L677:
	lis 9,Think_Red_SpawnDoorTrigger@ha
	la 9,Think_Red_SpawnDoorTrigger@l(9)
.L680:
	stw 9,680(31)
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe25:
	.size	 SP_red_door,.Lfe25-SP_red_door
	.section	".rodata"
	.align 3
.LC100:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC101:
	.long 0x0
	.align 3
.LC102:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SP_blue_door
	.type	 SP_blue_door,@function
SP_blue_door:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,804(31)
	cmpwi 0,0,1
	bc 12,2,.L682
	lis 29,gi@ha
	lis 3,.LC90@ha
	la 29,gi@l(29)
	la 3,.LC90@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,1052(31)
	lwz 9,36(29)
	lis 3,.LC91@ha
	la 3,.LC91@l(3)
	mtlr 9
	blrl
	stw 3,1056(31)
	lwz 0,36(29)
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	mtlr 0
	blrl
	stw 3,1060(31)
.L682:
	addi 29,31,584
	addi 3,31,16
	mr 4,29
	li 30,2
	bl G_SetMovedir
	li 0,3
	lis 9,gi@ha
	stw 30,264(31)
	la 28,gi@l(9)
	stw 0,248(31)
	mr 3,31
	lwz 9,44(28)
	lwz 4,272(31)
	mtlr 9
	blrl
	lis 8,.LC101@ha
	lfs 0,572(31)
	lis 9,door_blocked@ha
	la 8,.LC101@l(8)
	lis 11,door_use@ha
	lfs 13,0(8)
	la 9,door_blocked@l(9)
	la 11,door_use@l(11)
	stw 9,684(31)
	stw 11,692(31)
	fcmpu 0,0,13
	bc 4,2,.L683
	lis 0,0x42c8
	stw 0,572(31)
.L683:
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L684
	lfs 0,572(31)
	fadds 0,0,0
	stfs 0,572(31)
.L684:
	lfs 0,576(31)
	fcmpu 0,0,13
	bc 4,2,.L685
	lfs 0,572(31)
	stfs 0,576(31)
.L685:
	lfs 0,580(31)
	fcmpu 0,0,13
	bc 4,2,.L686
	lfs 0,572(31)
	stfs 0,580(31)
.L686:
	lfs 0,884(31)
	fcmpu 0,0,13
	bc 4,2,.L687
	lis 0,0x4040
	stw 0,884(31)
.L687:
	lis 9,st@ha
	la 10,st@l(9)
	lwz 0,24(10)
	cmpwi 0,0,0
	bc 4,2,.L688
	li 0,8
	stw 0,24(10)
.L688:
	lwz 0,792(31)
	cmpwi 0,0,0
	bc 4,2,.L689
	stw 30,792(31)
.L689:
	lfs 12,4(31)
	lis 11,0x4330
	lfs 13,8(31)
	lis 8,.LC102@ha
	mr 4,29
	lfs 0,12(31)
	la 8,.LC102@l(8)
	addi 3,31,596
	stfs 12,596(31)
	addi 5,31,608
	stfs 13,600(31)
	stfs 0,604(31)
	lfs 9,588(31)
	lwz 0,24(10)
	lfs 10,584(31)
	lfs 11,240(31)
	xoris 0,0,0x8000
	fabs 9,9
	stw 0,28(1)
	lfs 0,592(31)
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
	stfs 0,1076(31)
	bl VectorMA
	lwz 0,288(31)
	andi. 8,0,1
	bc 12,2,.L690
	lfs 11,608(31)
	lfs 10,612(31)
	lfs 9,616(31)
	lfs 0,596(31)
	lfs 13,600(31)
	lfs 12,604(31)
	stfs 0,608(31)
	stfs 13,612(31)
	stfs 12,616(31)
	stfs 11,596(31)
	stfs 10,600(31)
	stfs 9,604(31)
	stfs 11,4(31)
	stfs 10,8(31)
	stfs 9,12(31)
.L690:
	lwz 0,728(31)
	li 11,1
	stw 11,1084(31)
	cmpwi 0,0,0
	bc 12,2,.L691
	lis 9,door_killed@ha
	stw 11,788(31)
	la 9,door_killed@l(9)
	stw 0,756(31)
	stw 9,700(31)
	b .L692
.L691:
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 12,2,.L692
	lwz 0,280(31)
	cmpwi 0,0,0
	bc 12,2,.L692
	lwz 0,36(28)
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,688(31)
.L692:
	lwz 0,288(31)
	lfs 3,16(31)
	lfs 2,20(31)
	andi. 8,0,16
	lfs 4,24(31)
	lfs 0,572(31)
	lfs 13,576(31)
	lfs 12,580(31)
	lfs 11,884(31)
	lfs 10,596(31)
	lfs 9,600(31)
	lfs 8,604(31)
	lfs 7,608(31)
	lfs 6,612(31)
	lfs 5,616(31)
	stfs 0,1068(31)
	stfs 13,1064(31)
	stfs 12,1072(31)
	stfs 11,1080(31)
	stfs 10,1004(31)
	stfs 9,1008(31)
	stfs 8,1012(31)
	stfs 7,1028(31)
	stfs 6,1032(31)
	stfs 5,1036(31)
	stfs 3,1040(31)
	stfs 2,1044(31)
	stfs 4,1048(31)
	stfs 3,1016(31)
	stfs 2,1020(31)
	stfs 4,1024(31)
	bc 12,2,.L694
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L694:
	lwz 0,288(31)
	andi. 9,0,64
	bc 12,2,.L695
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L695:
	lwz 0,544(31)
	cmpwi 0,0,0
	bc 4,2,.L696
	stw 31,840(31)
.L696:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC100@ha
	lwz 0,728(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC100@l(11)
	cmpwi 0,0,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
	bc 4,2,.L698
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 12,2,.L697
.L698:
	lis 9,Think_CalcMoveSpeed@ha
	la 9,Think_CalcMoveSpeed@l(9)
	b .L700
.L697:
	lis 9,Think_Blue_SpawnDoorTrigger@ha
	la 9,Think_Blue_SpawnDoorTrigger@l(9)
.L700:
	stw 9,680(31)
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe26:
	.size	 SP_blue_door,.Lfe26-SP_blue_door
	.section	".rodata"
	.align 2
.LC103:
	.string	"%s at %s with no distance set\n"
	.align 3
.LC104:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC105:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC106:
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
	lwz 9,288(31)
	stw 0,584(31)
	andi. 11,9,64
	stw 0,24(31)
	stw 0,20(31)
	stw 0,16(31)
	stw 0,592(31)
	stw 0,588(31)
	bc 12,2,.L702
	lis 0,0x3f80
	stw 0,592(31)
	b .L703
.L702:
	andi. 0,9,128
	bc 12,2,.L704
	lis 0,0x3f80
	stw 0,584(31)
	b .L703
.L704:
	lis 0,0x3f80
	stw 0,588(31)
.L703:
	lwz 0,288(31)
	andi. 9,0,2
	bc 12,2,.L706
	lfs 0,584(31)
	lfs 13,588(31)
	lfs 12,592(31)
	fneg 0,0
	fneg 13,13
	fneg 12,12
	stfs 0,584(31)
	stfs 13,588(31)
	stfs 12,592(31)
.L706:
	lis 9,st@ha
	la 30,st@l(9)
	lwz 0,28(30)
	cmpwi 0,0,0
	bc 4,2,.L707
	lis 29,gi@ha
	lwz 28,284(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC103@ha
	mtlr 0
	la 3,.LC103@l(3)
	crxor 6,6,6
	blrl
	li 0,90
	stw 0,28(30)
.L707:
	lfs 13,20(31)
	lis 29,0x4330
	lfs 12,16(31)
	lis 11,.LC105@ha
	addi 3,31,16
	lfs 0,24(31)
	la 11,.LC105@l(11)
	addi 4,31,584
	stfs 13,600(31)
	addi 5,31,608
	li 28,2
	stfs 12,596(31)
	stfs 0,604(31)
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
	stw 28,264(31)
	stw 9,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	lwz 4,272(31)
	fsub 0,0,31
	frsp 0,0
	stfs 0,1076(31)
	lwz 9,44(30)
	mtlr 9
	blrl
	lis 9,.LC106@ha
	lfs 0,572(31)
	lis 11,door_use@ha
	la 9,.LC106@l(9)
	la 11,door_use@l(11)
	lfs 13,0(9)
	lis 9,door_blocked@ha
	stw 11,692(31)
	la 9,door_blocked@l(9)
	fcmpu 0,0,13
	stw 9,684(31)
	bc 4,2,.L708
	lis 0,0x42c8
	stw 0,572(31)
.L708:
	lfs 0,576(31)
	fcmpu 0,0,13
	bc 4,2,.L709
	lfs 0,572(31)
	stfs 0,576(31)
.L709:
	lfs 0,580(31)
	fcmpu 0,0,13
	bc 4,2,.L710
	lfs 0,572(31)
	stfs 0,580(31)
.L710:
	lfs 0,884(31)
	fcmpu 0,0,13
	bc 4,2,.L711
	lis 0,0x4040
	stw 0,884(31)
.L711:
	lwz 0,792(31)
	cmpwi 0,0,0
	bc 4,2,.L712
	stw 28,792(31)
.L712:
	lwz 0,804(31)
	cmpwi 0,0,1
	bc 12,2,.L713
	lwz 9,36(30)
	lis 3,.LC90@ha
	la 3,.LC90@l(3)
	mtlr 9
	blrl
	stw 3,1052(31)
	lwz 9,36(30)
	lis 3,.LC91@ha
	la 3,.LC91@l(3)
	mtlr 9
	blrl
	stw 3,1056(31)
	lwz 9,36(30)
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	mtlr 9
	blrl
	stw 3,1060(31)
.L713:
	lwz 0,288(31)
	andi. 9,0,1
	bc 12,2,.L714
	lfs 11,584(31)
	lfs 10,588(31)
	lfs 9,592(31)
	lfs 6,608(31)
	fneg 11,11
	lfs 8,612(31)
	fneg 10,10
	lfs 7,616(31)
	fneg 9,9
	lfs 0,596(31)
	lfs 13,600(31)
	lfs 12,604(31)
	stfs 0,608(31)
	stfs 13,612(31)
	stfs 12,616(31)
	stfs 6,596(31)
	stfs 8,600(31)
	stfs 7,604(31)
	stfs 11,584(31)
	stfs 10,588(31)
	stfs 9,592(31)
	stfs 6,16(31)
	stfs 8,20(31)
	stfs 7,24(31)
.L714:
	lwz 11,728(31)
	cmpwi 0,11,0
	bc 12,2,.L715
	lis 9,door_killed@ha
	li 0,1
	stw 11,756(31)
	la 9,door_killed@l(9)
	stw 0,788(31)
	stw 9,700(31)
.L715:
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 12,2,.L716
	lwz 0,280(31)
	cmpwi 0,0,0
	bc 12,2,.L716
	lwz 0,36(30)
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,688(31)
.L716:
	lwz 0,288(31)
	li 9,1
	lfs 3,4(31)
	lfs 2,8(31)
	andi. 11,0,16
	lfs 4,12(31)
	lfs 0,572(31)
	lfs 13,576(31)
	lfs 12,580(31)
	lfs 11,884(31)
	lfs 10,596(31)
	lfs 9,600(31)
	lfs 8,604(31)
	lfs 7,608(31)
	lfs 6,612(31)
	lfs 5,616(31)
	stw 9,1084(31)
	stfs 0,1068(31)
	stfs 13,1064(31)
	stfs 12,1072(31)
	stfs 11,1080(31)
	stfs 10,1016(31)
	stfs 9,1020(31)
	stfs 8,1024(31)
	stfs 3,1028(31)
	stfs 2,1032(31)
	stfs 4,1036(31)
	stfs 7,1040(31)
	stfs 6,1044(31)
	stfs 5,1048(31)
	stfs 3,1004(31)
	stfs 2,1008(31)
	stfs 4,1012(31)
	bc 12,2,.L717
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L717:
	lwz 0,544(31)
	cmpwi 0,0,0
	bc 4,2,.L718
	stw 31,840(31)
.L718:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC104@ha
	lwz 0,728(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC104@l(11)
	cmpwi 0,0,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
	bc 4,2,.L720
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 12,2,.L719
.L720:
	lis 9,Think_CalcMoveSpeed@ha
	la 9,Think_CalcMoveSpeed@l(9)
	b .L722
.L719:
	lis 9,Think_SpawnDoorTrigger@ha
	la 9,Think_SpawnDoorTrigger@l(9)
.L722:
	stw 9,680(31)
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe27:
	.size	 SP_func_door_rotating,.Lfe27-SP_func_door_rotating
	.section	".rodata"
	.align 2
.LC107:
	.string	"world/mov_watr.wav"
	.align 2
.LC108:
	.string	"world/stp_watr.wav"
	.align 3
.LC109:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC110:
	.long 0x0
	.align 2
.LC111:
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
	addi 4,31,584
	bl G_SetMovedir
	li 0,2
	li 11,3
	lwz 4,272(31)
	lis 9,gi@ha
	stw 0,264(31)
	mr 3,31
	la 30,gi@l(9)
	stw 11,248(31)
	lwz 9,44(30)
	mtlr 9
	blrl
	lwz 0,804(31)
	cmpwi 0,0,1
	bc 12,2,.L726
	cmpwi 0,0,2
	bc 4,2,.L724
.L726:
	lwz 9,36(30)
	lis 3,.LC107@ha
	la 3,.LC107@l(3)
	mtlr 9
	blrl
	stw 3,1052(31)
	lwz 0,36(30)
	lis 3,.LC108@ha
	la 3,.LC108@l(3)
	mtlr 0
	blrl
	stw 3,1060(31)
.L724:
	lfs 12,4(31)
	lis 11,st+24@ha
	lfs 13,8(31)
	lis 10,0x4330
	lis 8,.LC109@ha
	lfs 0,12(31)
	la 8,.LC109@l(8)
	addi 3,31,596
	stfs 12,596(31)
	addi 4,31,584
	addi 5,31,608
	stfs 13,600(31)
	stfs 0,604(31)
	lfs 9,588(31)
	lwz 0,st+24@l(11)
	lfs 10,584(31)
	lfs 11,240(31)
	xoris 0,0,0x8000
	fabs 9,9
	stw 0,36(1)
	lfs 0,592(31)
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
	stfs 0,1076(31)
	bl VectorMA
	lwz 0,288(31)
	andi. 8,0,1
	bc 12,2,.L729
	lfs 11,608(31)
	lfs 10,612(31)
	lfs 9,616(31)
	lfs 0,596(31)
	lfs 13,600(31)
	lfs 12,604(31)
	stfs 0,608(31)
	stfs 13,612(31)
	stfs 12,616(31)
	stfs 11,596(31)
	stfs 10,600(31)
	stfs 9,604(31)
	stfs 11,4(31)
	stfs 10,8(31)
	stfs 9,12(31)
.L729:
	lis 9,.LC110@ha
	lfs 0,572(31)
	li 0,1
	la 9,.LC110@l(9)
	lfs 6,16(31)
	lfs 5,0(9)
	lfs 8,20(31)
	lfs 7,24(31)
	fcmpu 0,0,5
	lfs 13,600(31)
	lfs 0,596(31)
	lfs 12,604(31)
	lfs 11,608(31)
	lfs 10,612(31)
	lfs 9,616(31)
	stfs 0,1004(31)
	stfs 13,1008(31)
	stfs 12,1012(31)
	stfs 11,1028(31)
	stfs 10,1032(31)
	stfs 9,1036(31)
	stfs 6,1040(31)
	stfs 8,1044(31)
	stfs 7,1048(31)
	stw 0,1084(31)
	stfs 6,1016(31)
	stfs 8,1020(31)
	stfs 7,1024(31)
	bc 4,2,.L730
	lis 0,0x41c8
	stw 0,572(31)
.L730:
	lfs 13,884(31)
	lfs 0,572(31)
	fcmpu 0,13,5
	stfs 0,1064(31)
	stfs 0,1068(31)
	stfs 0,1072(31)
	bc 4,2,.L731
	lis 0,0xbf80
	stw 0,884(31)
.L731:
	lis 8,.LC111@ha
	lfs 13,884(31)
	lis 9,door_use@ha
	la 8,.LC111@l(8)
	la 9,door_use@l(9)
	lfs 0,0(8)
	stw 9,692(31)
	stfs 13,1080(31)
	fcmpu 0,13,0
	bc 4,2,.L732
	lwz 0,288(31)
	ori 0,0,32
	stw 0,288(31)
.L732:
	lis 9,.LC72@ha
	lis 11,gi+72@ha
	la 9,.LC72@l(9)
	mr 3,31
	stw 9,284(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 30,40(1)
	la 1,48(1)
	blr
.Lfe28:
	.size	 SP_func_water,.Lfe28-SP_func_water
	.section	".rodata"
	.align 2
.LC112:
	.long 0x0
	.align 2
.LC113:
	.long 0x3f800000
	.align 2
.LC114:
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
	lwz 30,568(31)
	lwz 0,548(30)
	cmpwi 0,0,0
	bc 12,2,.L739
	lwz 29,532(30)
	mr 3,30
	stw 0,532(30)
	lwz 4,824(31)
	bl G_UseTargets
	stw 29,532(30)
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L738
.L739:
	lis 9,.LC112@ha
	lfs 13,1080(31)
	la 9,.LC112@l(9)
	lfs 31,0(9)
	fcmpu 0,13,31
	bc 12,2,.L741
	bc 4,1,.L742
	lis 9,level+4@ha
	lis 11,train_next@ha
	lfs 0,level+4@l(9)
	la 11,train_next@l(11)
	stw 11,680(31)
	fadds 0,0,13
	stfs 0,672(31)
	b .L743
.L742:
	lwz 0,288(31)
	andi. 9,0,2
	bc 12,2,.L743
	mr 3,31
	bl train_next
	lwz 0,288(31)
	stfs 31,672(31)
	rlwinm 0,0,0,0,30
	stfs 31,628(31)
	stw 0,288(31)
	stfs 31,624(31)
	stfs 31,620(31)
.L743:
	lwz 0,268(31)
	andi. 30,0,1024
	bc 4,2,.L738
	lwz 5,1060(31)
	cmpwi 0,5,0
	bc 12,2,.L746
	lis 9,gi+16@ha
	mr 3,31
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC113@ha
	la 9,.LC113@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC114@ha
	la 9,.LC114@l(9)
	lfs 2,0(9)
	lis 9,.LC112@ha
	la 9,.LC112@l(9)
	lfs 3,0(9)
	blrl
.L746:
	stw 30,76(31)
	b .L738
.L741:
	mr 3,31
	bl train_next
.L738:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 train_wait,.Lfe29-train_wait
	.section	".rodata"
	.align 2
.LC115:
	.string	"train_next: bad target %s\n"
	.align 2
.LC116:
	.string	"connected teleport path_corners, see %s at %s\n"
	.align 3
.LC117:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC118:
	.long 0x3f800000
	.align 2
.LC119:
	.long 0x40400000
	.align 2
.LC120:
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
.L749:
	lwz 3,532(28)
	cmpwi 0,3,0
	bc 12,2,.L748
	bl G_PickTarget
	mr. 31,3
	bc 4,2,.L751
	lis 9,gi+4@ha
	lis 3,.LC115@ha
	lwz 4,532(28)
	lwz 0,gi+4@l(9)
	la 3,.LC115@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L748
.L751:
	lwz 0,532(31)
	stw 0,532(28)
	lwz 9,288(31)
	andi. 0,9,1
	bc 12,2,.L752
	cmpwi 0,29,0
	bc 4,2,.L753
	lis 29,gi@ha
	lwz 28,284(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC116@ha
	la 3,.LC116@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L748
.L753:
	lfs 12,4(31)
	lis 9,gi+72@ha
	mr 3,28
	lfs 0,188(28)
	li 29,0
	lfs 11,192(28)
	lfs 10,196(28)
	fsubs 12,12,0
	stfs 12,4(28)
	lfs 13,8(31)
	fsubs 13,13,11
	stfs 13,8(28)
	lfs 0,12(31)
	stfs 12,28(28)
	stfs 13,32(28)
	fsubs 0,0,10
	stfs 0,36(28)
	stfs 0,12(28)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	b .L749
.L752:
	lwz 0,268(28)
	lfs 0,884(31)
	andi. 9,0,1024
	stw 31,568(28)
	stfs 0,1080(28)
	bc 4,2,.L754
	lwz 5,1052(28)
	cmpwi 0,5,0
	bc 12,2,.L755
	lis 11,.LC118@ha
	lis 9,gi+16@ha
	la 11,.LC118@l(11)
	lwz 0,gi+16@l(9)
	mr 3,28
	lfs 1,0(11)
	lis 9,.LC119@ha
	li 4,10
	lis 11,.LC120@ha
	la 9,.LC119@l(9)
	mtlr 0
	la 11,.LC120@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L755:
	lwz 0,1056(28)
	stw 0,76(28)
.L754:
	lfs 11,4(31)
	li 0,0
	li 9,0
	lfs 0,188(28)
	addi 11,1,8
	lis 29,train_wait@ha
	lfs 12,192(28)
	la 29,train_wait@l(29)
	addi 3,28,1088
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
	stw 9,1084(28)
	stfs 0,1032(28)
	fsubs 12,12,10
	stw 0,620(28)
	stfs 13,1088(28)
	stfs 12,16(1)
	lfs 0,8(11)
	lfs 13,4(11)
	stfs 12,1036(28)
	fsubs 0,0,9
	stfs 8,1004(28)
	fsubs 13,13,7
	stfs 7,1008(28)
	stfs 9,1012(28)
	stfs 0,1096(28)
	stfs 13,1092(28)
	stfs 11,1028(28)
	stw 0,628(28)
	stw 0,624(28)
	bl VectorNormalize
	lfs 13,1068(28)
	lfs 0,1064(28)
	stfs 1,1112(28)
	stw 29,1120(28)
	fcmpu 0,13,0
	bc 4,2,.L756
	lfs 0,1072(28)
	fcmpu 0,13,0
	bc 4,2,.L756
	lwz 0,268(28)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L757
	lwz 0,840(28)
	cmpw 0,9,0
	bc 12,2,.L758
	b .L759
.L757:
	cmpw 0,9,28
	bc 4,2,.L759
.L758:
	mr 3,28
	bl Move_Begin
	b .L762
.L759:
	lis 11,level+4@ha
	lis 10,.LC117@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC117@l(10)
	la 9,Move_Begin@l(9)
	stw 9,680(28)
	b .L763
.L756:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,1100(28)
	lis 10,level+4@ha
	stw 9,680(28)
	lis 11,.LC117@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC117@l(11)
.L763:
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(28)
.L762:
	lwz 0,288(28)
	ori 0,0,1
	stw 0,288(28)
.L748:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe30:
	.size	 train_next,.Lfe30-train_next
	.section	".rodata"
	.align 3
.LC121:
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
	lwz 9,568(31)
	li 11,0
	addi 10,1,8
	lfs 0,188(31)
	lis 29,train_wait@ha
	addi 3,31,1088
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
	stw 11,1084(31)
	stfs 0,1032(31)
	fsubs 12,12,9
	stw 0,620(31)
	stfs 10,1088(31)
	stfs 12,16(1)
	lfs 0,8(10)
	lfs 13,4(10)
	stfs 12,1036(31)
	fsubs 0,0,8
	stfs 7,1004(31)
	fsubs 13,13,6
	stfs 6,1008(31)
	stfs 8,1012(31)
	stfs 0,1096(31)
	stfs 13,1092(31)
	stfs 11,1028(31)
	stw 0,628(31)
	stw 0,624(31)
	bl VectorNormalize
	lfs 13,1068(31)
	lfs 0,1064(31)
	stfs 1,1112(31)
	stw 29,1120(31)
	fcmpu 0,13,0
	bc 4,2,.L765
	lfs 0,1072(31)
	fcmpu 0,13,0
	bc 4,2,.L765
	lwz 0,268(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L766
	lwz 0,840(31)
	cmpw 0,9,0
	bc 12,2,.L767
	b .L768
.L766:
	cmpw 0,9,31
	bc 4,2,.L768
.L767:
	mr 3,31
	bl Move_Begin
	b .L771
.L768:
	lis 11,level+4@ha
	lis 10,.LC121@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC121@l(10)
	la 9,Move_Begin@l(9)
	stw 9,680(31)
	b .L772
.L765:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,1100(31)
	lis 10,level+4@ha
	stw 9,680(31)
	lis 11,.LC121@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC121@l(11)
.L772:
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L771:
	lwz 0,288(31)
	ori 0,0,1
	stw 0,288(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe31:
	.size	 train_resume,.Lfe31-train_resume
	.section	".rodata"
	.align 2
.LC122:
	.string	"train_find: no target\n"
	.align 2
.LC123:
	.string	"train_find: target %s not found\n"
	.align 2
.LC126:
	.string	"func_train without a target at %s\n"
	.align 3
.LC125:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC127:
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
	lwz 10,288(31)
	li 0,0
	la 9,train_blocked@l(9)
	li 11,2
	stw 0,16(31)
	andi. 8,10,4
	stw 11,264(31)
	stw 9,684(31)
	stw 0,24(31)
	stw 0,20(31)
	bc 4,2,.L792
	lwz 0,792(31)
	cmpwi 0,0,0
	bc 4,2,.L786
	li 0,100
.L792:
	stw 0,792(31)
.L786:
	li 0,3
	lis 9,gi@ha
	lwz 4,272(31)
	la 30,gi@l(9)
	stw 0,248(31)
	mr 3,31
	lwz 9,44(30)
	mtlr 9
	blrl
	lis 9,st+36@ha
	lwz 3,st+36@l(9)
	cmpwi 0,3,0
	bc 12,2,.L788
	lwz 9,36(30)
	mtlr 9
	blrl
	stw 3,1056(31)
.L788:
	lis 8,.LC127@ha
	lfs 13,572(31)
	la 8,.LC127@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,2,.L789
	lis 0,0x42c8
	stw 0,572(31)
.L789:
	lfs 0,572(31)
	lis 9,train_use@ha
	mr 3,31
	la 9,train_use@l(9)
	stw 9,692(31)
	stfs 0,1064(31)
	stfs 0,1068(31)
	stfs 0,1072(31)
	lwz 9,72(30)
	mtlr 9
	blrl
	lwz 0,532(31)
	cmpwi 0,0,0
	bc 12,2,.L790
	lis 11,level+4@ha
	lis 10,.LC125@ha
	lfs 0,level+4@l(11)
	lis 9,func_train_find@ha
	lfd 13,.LC125@l(10)
	la 9,func_train_find@l(9)
	stw 9,680(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
	b .L791
.L790:
	addi 3,31,212
	bl vtos
	mr 4,3
	lwz 0,4(30)
	lis 3,.LC126@ha
	la 3,.LC126@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L791:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe32:
	.size	 SP_func_train,.Lfe32-SP_func_train
	.section	".rodata"
	.align 2
.LC128:
	.string	"elevator used with no pathtarget\n"
	.align 2
.LC129:
	.string	"elevator used with bad pathtarget: %s\n"
	.align 2
.LC130:
	.string	"trigger_elevator has no target\n"
	.align 2
.LC131:
	.string	"trigger_elevator unable to find target %s\n"
	.align 2
.LC132:
	.string	"func_train"
	.align 2
.LC133:
	.string	"trigger_elevator target %s is not a train\n"
	.align 2
.LC138:
	.string	"func_timer at %s has random >= wait\n"
	.align 3
.LC137:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC139:
	.long 0x46fffe00
	.align 2
.LC140:
	.long 0x0
	.align 3
.LC141:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC142:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC143:
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
	lis 9,.LC140@ha
	mr 31,3
	la 9,.LC140@l(9)
	lfs 0,884(31)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L809
	lis 0,0x3f80
	stw 0,884(31)
.L809:
	lfs 0,892(31)
	lis 9,func_timer_use@ha
	lis 11,func_timer_think@ha
	lfs 13,884(31)
	la 9,func_timer_use@l(9)
	la 11,func_timer_think@l(11)
	stw 9,692(31)
	stw 11,680(31)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L810
	fmr 0,13
	lis 9,.LC137@ha
	lis 29,gi@ha
	lfd 13,.LC137@l(9)
	la 29,gi@l(29)
	addi 3,31,4
	fsub 0,0,13
	frsp 0,0
	stfs 0,892(31)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC138@ha
	la 3,.LC138@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L810:
	lwz 0,288(31)
	andi. 9,0,1
	bc 12,2,.L811
	bl rand
	rlwinm 3,3,0,17,31
	lfs 8,888(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	lfs 9,884(31)
	stw 3,28(1)
	lis 11,.LC141@ha
	lis 8,.LC139@ha
	la 11,.LC141@l(11)
	stw 0,24(1)
	lis 10,st+40@ha
	lfd 10,0(11)
	lfd 12,24(1)
	lis 11,level+4@ha
	lfs 6,.LC139@l(8)
	lis 9,.LC142@ha
	lfs 13,level+4@l(11)
	la 9,.LC142@l(9)
	fsub 12,12,10
	lfd 0,0(9)
	lfs 11,st+40@l(10)
	lis 9,.LC143@ha
	la 9,.LC143@l(9)
	lfs 10,892(31)
	frsp 12,12
	lfd 7,0(9)
	stw 31,824(31)
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
	stfs 0,672(31)
.L811:
	li 0,1
	stw 0,184(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe33:
	.size	 SP_func_timer,.Lfe33-SP_func_timer
	.section	".rodata"
	.align 3
.LC144:
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
	bc 12,2,.L819
	lfs 13,4(31)
	li 0,0
	addi 9,31,596
	lfs 0,596(31)
	lis 29,door_secret_move1@ha
	addi 3,31,1088
	stw 0,620(31)
	la 29,door_secret_move1@l(29)
	stw 0,628(31)
	fsubs 0,0,13
	stw 0,624(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,1088(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,1092(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,1096(31)
	bl VectorNormalize
	lfs 13,1068(31)
	lfs 0,1064(31)
	stfs 1,1112(31)
	stw 29,1120(31)
	fcmpu 0,13,0
	bc 4,2,.L821
	lfs 0,1072(31)
	fcmpu 0,13,0
	bc 4,2,.L821
	lwz 0,268(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L822
	lwz 0,840(31)
	cmpw 0,9,0
	bc 12,2,.L823
	b .L824
.L822:
	cmpw 0,9,31
	bc 4,2,.L824
.L823:
	mr 3,31
	bl Move_Begin
	b .L827
.L824:
	lis 11,level+4@ha
	lis 10,.LC144@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC144@l(10)
	la 9,Move_Begin@l(9)
	stw 9,680(31)
	b .L835
.L821:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,1100(31)
	lis 10,level+4@ha
	stw 9,680(31)
	lis 11,.LC144@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC144@l(11)
.L835:
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L827:
	lwz 0,532(31)
	li 29,0
	cmpwi 0,0,0
	bc 12,2,.L819
	lis 9,gi@ha
	lis 28,.LC71@ha
	la 30,gi@l(9)
	b .L830
.L832:
	lwz 3,284(29)
	la 4,.LC71@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L830
	lwz 9,64(30)
	li 4,1
	lwz 3,996(29)
	mtlr 9
	blrl
.L830:
	lwz 5,532(31)
	mr 3,29
	li 4,536
	bl G_Find
	mr. 29,3
	bc 4,2,.L832
.L819:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 door_secret_use,.Lfe34-door_secret_use
	.section	".rodata"
	.align 3
.LC145:
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
	addi 9,31,608
	lis 29,door_secret_move3@ha
	lfs 0,608(31)
	la 29,door_secret_move3@l(29)
	addi 3,31,1088
	stw 0,620(31)
	stw 0,628(31)
	fsubs 0,0,13
	stw 0,624(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,1088(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,1092(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,1096(31)
	bl VectorNormalize
	lfs 13,1068(31)
	lfs 0,1064(31)
	stfs 1,1112(31)
	stw 29,1120(31)
	fcmpu 0,13,0
	bc 4,2,.L838
	lfs 0,1072(31)
	fcmpu 0,13,0
	bc 4,2,.L838
	lwz 0,268(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L839
	lwz 0,840(31)
	cmpw 0,9,0
	bc 12,2,.L840
	b .L841
.L839:
	cmpw 0,9,31
	bc 4,2,.L841
.L840:
	mr 3,31
	bl Move_Begin
	b .L844
.L841:
	lis 11,level+4@ha
	lis 10,.LC145@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC145@l(10)
	la 9,Move_Begin@l(9)
	stw 9,680(31)
	b .L845
.L838:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,1100(31)
	lis 10,level+4@ha
	stw 9,680(31)
	lis 11,.LC145@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC145@l(11)
.L845:
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L844:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 door_secret_move2,.Lfe35-door_secret_move2
	.section	".rodata"
	.align 3
.LC146:
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
	addi 9,31,596
	lis 29,door_secret_move5@ha
	lfs 0,596(31)
	la 29,door_secret_move5@l(29)
	addi 3,31,1088
	stw 0,620(31)
	stw 0,628(31)
	fsubs 0,0,13
	stw 0,624(31)
	lfs 12,8(31)
	lfs 11,12(31)
	stfs 0,1088(31)
	lfs 13,4(9)
	fsubs 13,13,12
	stfs 13,1092(31)
	lfs 0,8(9)
	fsubs 0,0,11
	stfs 0,1096(31)
	bl VectorNormalize
	lfs 13,1068(31)
	lfs 0,1064(31)
	stfs 1,1112(31)
	stw 29,1120(31)
	fcmpu 0,13,0
	bc 4,2,.L849
	lfs 0,1072(31)
	fcmpu 0,13,0
	bc 4,2,.L849
	lwz 0,268(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L850
	lwz 0,840(31)
	cmpw 0,9,0
	bc 12,2,.L851
	b .L852
.L850:
	cmpw 0,9,31
	bc 4,2,.L852
.L851:
	mr 3,31
	bl Move_Begin
	b .L855
.L852:
	lis 11,level+4@ha
	lis 10,.LC146@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC146@l(10)
	la 9,Move_Begin@l(9)
	stw 9,680(31)
	b .L856
.L849:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,1100(31)
	lis 10,level+4@ha
	stw 9,680(31)
	lis 11,.LC146@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC146@l(11)
.L856:
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L855:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 door_secret_move4,.Lfe36-door_secret_move4
	.section	".rodata"
	.align 3
.LC147:
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
	stw 0,620(31)
	lis 9,vec3_origin@ha
	lis 29,door_secret_done@ha
	stw 0,628(31)
	la 11,vec3_origin@l(9)
	la 29,door_secret_done@l(29)
	stw 0,624(31)
	addi 3,31,1088
	lfs 13,vec3_origin@l(9)
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,1088(31)
	lfs 0,4(11)
	fsubs 0,0,12
	stfs 0,1092(31)
	lfs 13,8(11)
	fsubs 13,13,11
	stfs 13,1096(31)
	bl VectorNormalize
	lfs 13,1068(31)
	lfs 0,1064(31)
	stfs 1,1112(31)
	stw 29,1120(31)
	fcmpu 0,13,0
	bc 4,2,.L859
	lfs 0,1072(31)
	fcmpu 0,13,0
	bc 4,2,.L859
	lwz 0,268(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L860
	lwz 0,840(31)
	cmpw 0,9,0
	bc 12,2,.L861
	b .L862
.L860:
	cmpw 0,9,31
	bc 4,2,.L862
.L861:
	mr 3,31
	bl Move_Begin
	b .L865
.L862:
	lis 11,level+4@ha
	lis 10,.LC147@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC147@l(10)
	la 9,Move_Begin@l(9)
	stw 9,680(31)
	b .L866
.L859:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,1100(31)
	lis 10,level+4@ha
	stw 9,680(31)
	lis 11,.LC147@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC147@l(11)
.L866:
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L865:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe37:
	.size	 door_secret_move6,.Lfe37-door_secret_move6
	.section	".rodata"
	.align 2
.LC148:
	.long 0x0
	.align 3
.LC149:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC150:
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
	lis 3,.LC90@ha
	lwz 9,36(29)
	la 3,.LC90@l(3)
	mtlr 9
	blrl
	stw 3,1052(31)
	lwz 9,36(29)
	lis 3,.LC91@ha
	la 3,.LC91@l(3)
	mtlr 9
	blrl
	stw 3,1056(31)
	lwz 9,36(29)
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	mtlr 9
	blrl
	li 9,3
	li 0,2
	stw 3,1060(31)
	stw 9,248(31)
	mr 3,31
	stw 0,264(31)
	lwz 0,44(29)
	lwz 4,272(31)
	mtlr 0
	blrl
	lwz 0,536(31)
	lis 9,door_secret_blocked@ha
	lis 11,door_secret_use@ha
	la 9,door_secret_blocked@l(9)
	la 11,door_secret_use@l(11)
	cmpwi 0,0,0
	stw 9,684(31)
	stw 11,692(31)
	bc 12,2,.L884
	lwz 0,288(31)
	andi. 7,0,1
	bc 12,2,.L883
.L884:
	lis 9,door_secret_die@ha
	li 11,0
	la 9,door_secret_die@l(9)
	li 0,1
	stw 11,728(31)
	stw 0,788(31)
	stw 9,700(31)
.L883:
	lwz 0,792(31)
	cmpwi 0,0,0
	bc 4,2,.L885
	li 0,2
	stw 0,792(31)
.L885:
	lis 9,.LC148@ha
	lfs 0,884(31)
	la 9,.LC148@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L886
	lis 0,0x40a0
	stw 0,884(31)
.L886:
	lis 0,0x4248
	addi 29,1,24
	addi 28,1,40
	stw 0,1064(31)
	addi 4,1,8
	stw 0,1068(31)
	addi 3,31,16
	mr 5,29
	stw 0,1072(31)
	mr 6,28
	bl AngleVectors
	lwz 11,288(31)
	lis 10,0x4330
	lis 7,.LC149@ha
	mr 8,29
	stfs 31,16(31)
	rlwinm 0,11,0,30,30
	la 7,.LC149@l(7)
	stfs 31,24(31)
	xoris 0,0,0x8000
	lfd 12,0(7)
	mr 4,28
	stw 0,68(1)
	lis 7,.LC150@ha
	stw 10,64(1)
	la 7,.LC150@l(7)
	andi. 0,11,4
	lfd 0,64(1)
	lfd 13,0(7)
	stfs 31,20(31)
	fsub 0,0,12
	fsub 13,13,0
	frsp 7,13
	bc 12,2,.L887
	lfs 0,240(31)
	lfs 12,44(1)
	lfs 10,236(31)
	lfs 13,40(1)
	fmr 8,0
	fmuls 12,12,0
	lfs 11,244(31)
	lfs 0,48(1)
	b .L894
.L887:
	lfs 0,240(31)
	lfs 12,28(1)
	lfs 10,236(31)
	lfs 13,24(1)
	fmr 8,0
	fmuls 12,12,0
	lfs 11,244(31)
	lfs 0,32(1)
.L894:
	fmr 9,10
	fmadds 13,13,10,12
	fmr 10,11
	fmadds 0,0,11,13
	fabs 1,0
	lfs 0,12(1)
	lfs 12,8(1)
	lfs 13,16(1)
	fmuls 0,0,8
	lwz 0,288(31)
	andi. 7,0,4
	fmadds 12,12,9,0
	fmadds 13,13,10,12
	fabs 31,13
	bc 12,2,.L889
	fneg 1,1
	addi 29,31,596
	addi 3,31,4
	b .L895
.L889:
	fmuls 1,7,1
	addi 29,31,596
	addi 3,31,4
	mr 4,8
.L895:
	mr 5,29
	bl VectorMA
	mr 3,29
	fmr 1,31
	addi 4,1,8
	addi 5,31,608
	bl VectorMA
	lwz 11,728(31)
	cmpwi 0,11,0
	bc 12,2,.L891
	lis 9,door_killed@ha
	li 0,1
	stw 11,756(31)
	la 9,door_killed@l(9)
	stw 0,788(31)
	stw 9,700(31)
	b .L892
.L891:
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 12,2,.L892
	lwz 0,280(31)
	cmpwi 0,0,0
	bc 12,2,.L892
	lis 9,gi+36@ha
	lis 3,.LC93@ha
	lwz 0,gi+36@l(9)
	la 3,.LC93@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,688(31)
.L892:
	lis 9,.LC72@ha
	lis 11,gi+72@ha
	la 9,.LC72@l(9)
	mr 3,31
	stw 9,284(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 0,100(1)
	mtlr 0
	lmw 28,72(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe38:
	.size	 SP_func_door_secret,.Lfe38-SP_func_door_secret
	.section	".rodata"
	.align 2
.LC151:
	.long 0x0
	.section	".text"
	.align 2
	.globl Rplat_Rot
	.type	 Rplat_Rot,@function
Rplat_Rot:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	li 9,3
	lwz 0,328(31)
	stw 9,248(31)
	andi. 11,0,32
	bc 12,2,.L903
	stw 9,264(31)
	b .L904
.L903:
	li 0,2
	stw 0,264(31)
.L904:
	lwz 9,328(31)
	li 0,0
	stw 0,584(31)
	andi. 11,9,4
	stw 0,592(31)
	stw 0,588(31)
	bc 12,2,.L905
	lis 0,0x3f80
	stw 0,592(31)
	b .L906
.L905:
	andi. 0,9,8
	bc 12,2,.L907
	lis 0,0x3f80
	stw 0,584(31)
	b .L906
.L907:
	lis 0,0x3f80
	stw 0,588(31)
.L906:
	lwz 0,328(31)
	andi. 9,0,2
	bc 12,2,.L909
	lfs 0,584(31)
	lfs 13,588(31)
	lfs 12,592(31)
	fneg 0,0
	fneg 13,13
	fneg 12,12
	stfs 0,584(31)
	stfs 13,588(31)
	stfs 12,592(31)
.L909:
	lis 11,.LC151@ha
	lfs 13,572(31)
	la 11,.LC151@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L910
	lis 0,0x42c8
	stw 0,572(31)
.L910:
	lwz 0,792(31)
	cmpwi 0,0,0
	bc 4,2,.L911
	li 0,2
	stw 0,792(31)
.L911:
	lwz 0,792(31)
	lis 9,Rplat_rot_use@ha
	la 9,Rplat_rot_use@l(9)
	cmpwi 0,0,0
	stw 9,692(31)
	bc 12,2,.L912
	lis 9,rotating_blocked@ha
	la 9,rotating_blocked@l(9)
	stw 9,684(31)
.L912:
	lwz 0,328(31)
	andi. 9,0,1
	bc 12,2,.L913
	lwz 9,692(31)
	mr 3,31
	li 4,0
	li 5,0
	mtlr 9
	blrl
.L913:
	lwz 0,328(31)
	andi. 9,0,64
	bc 12,2,.L914
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L914:
	lwz 0,328(31)
	andi. 11,0,128
	bc 12,2,.L915
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L915:
	lis 29,gi@ha
	mr 3,31
	lwz 4,272(31)
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
.Lfe39:
	.size	 Rplat_Rot,.Lfe39-Rplat_Rot
	.section	".rodata"
	.align 3
.LC152:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC153:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC154:
	.long 0x0
	.section	".text"
	.align 2
	.globl Rplat_dr
	.type	 Rplat_dr,@function
Rplat_dr:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	mr 31,3
	li 0,0
	lwz 9,324(31)
	stw 0,584(31)
	andi. 10,9,64
	stw 0,24(31)
	stw 0,20(31)
	stw 0,16(31)
	stw 0,592(31)
	stw 0,588(31)
	bc 12,2,.L931
	lis 0,0x3f80
	stw 0,592(31)
	b .L932
.L931:
	andi. 11,9,128
	bc 12,2,.L933
	lis 0,0x3f80
	stw 0,584(31)
	b .L932
.L933:
	lis 0,0x3f80
	stw 0,588(31)
.L932:
	lwz 0,324(31)
	andi. 9,0,2
	bc 12,2,.L935
	lfs 0,584(31)
	lfs 13,588(31)
	lfs 12,592(31)
	fneg 0,0
	fneg 13,13
	fneg 12,12
	stfs 0,584(31)
	stfs 13,588(31)
	stfs 12,592(31)
.L935:
	lis 9,st@ha
	la 30,st@l(9)
	lwz 0,28(30)
	cmpwi 0,0,0
	bc 4,2,.L936
	lis 29,gi@ha
	lwz 28,284(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC103@ha
	mtlr 0
	la 3,.LC103@l(3)
	crxor 6,6,6
	blrl
	li 0,90
	stw 0,28(30)
.L936:
	lfs 13,20(31)
	lis 29,0x4330
	lfs 12,16(31)
	lis 10,.LC153@ha
	addi 3,31,16
	lfs 0,24(31)
	la 10,.LC153@l(10)
	addi 4,31,584
	stfs 13,600(31)
	addi 5,31,608
	li 28,2
	stfs 12,596(31)
	stfs 0,604(31)
	lwz 0,28(30)
	lfd 31,0(10)
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
	stw 28,264(31)
	stw 9,20(1)
	stw 29,16(1)
	lfd 0,16(1)
	lwz 4,272(31)
	fsub 0,0,31
	frsp 0,0
	stfs 0,1076(31)
	lwz 9,44(30)
	mtlr 9
	blrl
	lis 9,.LC154@ha
	lfs 0,572(31)
	lis 11,Rdoor_use@ha
	la 9,.LC154@l(9)
	la 11,Rdoor_use@l(11)
	lfs 13,0(9)
	lis 9,door_blocked@ha
	stw 11,692(31)
	la 9,door_blocked@l(9)
	fcmpu 0,0,13
	stw 9,684(31)
	bc 4,2,.L937
	lis 0,0x42c8
	stw 0,572(31)
.L937:
	lfs 0,576(31)
	fcmpu 0,0,13
	bc 4,2,.L938
	lfs 0,572(31)
	stfs 0,576(31)
.L938:
	lfs 0,580(31)
	fcmpu 0,0,13
	bc 4,2,.L939
	lfs 0,572(31)
	stfs 0,580(31)
.L939:
	lfs 0,884(31)
	fcmpu 0,0,13
	bc 4,2,.L940
	lis 0,0x4040
	stw 0,884(31)
.L940:
	lwz 0,792(31)
	cmpwi 0,0,0
	bc 4,2,.L941
	stw 28,792(31)
.L941:
	lwz 0,804(31)
	cmpwi 0,0,1
	bc 12,2,.L942
	lwz 9,36(30)
	lis 3,.LC90@ha
	la 3,.LC90@l(3)
	mtlr 9
	blrl
	stw 3,1052(31)
	lwz 9,36(30)
	lis 3,.LC91@ha
	la 3,.LC91@l(3)
	mtlr 9
	blrl
	stw 3,1056(31)
	lwz 9,36(30)
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	mtlr 9
	blrl
	stw 3,1060(31)
.L942:
	lwz 0,324(31)
	andi. 9,0,1
	bc 12,2,.L943
	lfs 11,584(31)
	lfs 10,588(31)
	lfs 9,592(31)
	lfs 6,608(31)
	fneg 11,11
	lfs 8,612(31)
	fneg 10,10
	lfs 7,616(31)
	fneg 9,9
	lfs 0,596(31)
	lfs 13,600(31)
	lfs 12,604(31)
	stfs 0,608(31)
	stfs 13,612(31)
	stfs 12,616(31)
	stfs 6,596(31)
	stfs 8,600(31)
	stfs 7,604(31)
	stfs 11,584(31)
	stfs 10,588(31)
	stfs 9,592(31)
	stfs 6,16(31)
	stfs 8,20(31)
	stfs 7,24(31)
.L943:
	lwz 11,728(31)
	cmpwi 0,11,0
	bc 12,2,.L944
	lis 9,door_killed@ha
	li 0,1
	stw 11,756(31)
	la 9,door_killed@l(9)
	stw 0,788(31)
	stw 9,700(31)
.L944:
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 12,2,.L945
	lwz 0,280(31)
	cmpwi 0,0,0
	bc 12,2,.L945
	lwz 0,36(30)
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,688(31)
.L945:
	lwz 0,324(31)
	li 9,1
	lfs 3,4(31)
	lfs 2,8(31)
	andi. 10,0,16
	lfs 4,12(31)
	lfs 0,572(31)
	lfs 13,576(31)
	lfs 12,580(31)
	lfs 11,884(31)
	lfs 10,596(31)
	lfs 9,600(31)
	lfs 8,604(31)
	lfs 7,608(31)
	lfs 6,612(31)
	lfs 5,616(31)
	stw 9,1084(31)
	stfs 0,1068(31)
	stfs 13,1064(31)
	stfs 12,1072(31)
	stfs 11,1080(31)
	stfs 10,1016(31)
	stfs 9,1020(31)
	stfs 8,1024(31)
	stfs 3,1028(31)
	stfs 2,1032(31)
	stfs 4,1036(31)
	stfs 7,1040(31)
	stfs 6,1044(31)
	stfs 5,1048(31)
	stfs 3,1004(31)
	stfs 2,1008(31)
	stfs 4,1012(31)
	bc 12,2,.L946
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L946:
	lwz 0,316(31)
	cmpwi 0,0,16
	bc 4,2,.L947
	lwz 0,308(31)
	b .L953
.L947:
	cmpwi 0,0,17
	bc 4,2,.L948
	lwz 0,312(31)
.L953:
	lis 11,0x4330
	lis 10,.LC153@ha
	mr 3,31
	xoris 0,0,0x8000
	la 10,.LC153@l(10)
	stw 0,20(1)
	mr 4,31
	stw 11,16(1)
	lfd 0,16(1)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	stfs 0,888(31)
	bl G_UseTargets
	lwz 9,316(31)
	addi 9,9,1
	stw 9,316(31)
.L948:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC152@ha
	lwz 0,728(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC152@l(11)
	cmpwi 0,0,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
	bc 4,2,.L951
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 12,2,.L950
.L951:
	lis 9,Think_CalcMoveSpeed@ha
	la 9,Think_CalcMoveSpeed@l(9)
	b .L954
.L950:
	lis 9,Think_SpawnDoorTrigger@ha
	la 9,Think_SpawnDoorTrigger@l(9)
.L954:
	stw 9,680(31)
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe40:
	.size	 Rplat_dr,.Lfe40-Rplat_dr
	.section	".rodata"
	.align 3
.LC155:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC156:
	.long 0x0
	.align 3
.LC157:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Rplat_Plat
	.type	 Rplat_Plat,@function
Rplat_Plat:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	lis 9,.LC156@ha
	mr 31,3
	la 9,.LC156@l(9)
	li 0,3
	lwz 4,272(31)
	lfs 31,0(9)
	lis 11,gi+44@ha
	li 9,2
	stw 0,248(31)
	stw 9,264(31)
	stfs 31,24(31)
	stfs 31,20(31)
	stfs 31,16(31)
	lwz 0,gi+44@l(11)
	mtlr 0
	blrl
	lfs 0,572(31)
	lis 9,plat_blocked@ha
	la 9,plat_blocked@l(9)
	stw 9,684(31)
	fcmpu 0,0,31
	bc 4,2,.L958
	lis 0,0x41a0
	stw 0,572(31)
	b .L959
.L958:
	lis 9,.LC155@ha
	lfd 13,.LC155@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,572(31)
.L959:
	lis 9,.LC156@ha
	lfs 13,576(31)
	la 9,.LC156@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L960
	lis 0,0x40a0
	stw 0,576(31)
	b .L961
.L960:
	fmr 0,13
	lis 9,.LC155@ha
	lfd 13,.LC155@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,576(31)
.L961:
	lis 10,.LC156@ha
	lfs 13,580(31)
	la 10,.LC156@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,2,.L962
	lis 0,0x40a0
	stw 0,580(31)
	b .L963
.L962:
	fmr 0,13
	lis 9,.LC155@ha
	lfd 13,.LC155@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,580(31)
.L963:
	lwz 0,792(31)
	cmpwi 0,0,0
	bc 4,2,.L964
	li 0,1
	stw 0,792(31)
.L964:
	lis 9,st@ha
	la 9,st@l(9)
	lwz 0,24(9)
	cmpwi 0,0,0
	bc 4,2,.L965
	li 0,8
	stw 0,24(9)
.L965:
	lfs 0,4(31)
	lfs 13,8(31)
	lfs 10,12(31)
	stfs 0,608(31)
	stfs 13,612(31)
	stfs 0,596(31)
	stfs 13,600(31)
	stfs 10,604(31)
	stfs 10,616(31)
	lwz 0,32(9)
	cmpwi 0,0,0
	bc 12,2,.L966
	xoris 0,0,0x8000
	stw 0,20(1)
	lis 11,0x4330
	lis 10,.LC157@ha
	la 10,.LC157@l(10)
	stw 11,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fsubs 0,10,0
	stfs 0,616(31)
	b .L967
.L966:
	lwz 0,24(9)
	lis 11,0x4330
	lis 10,.LC157@ha
	la 10,.LC157@l(10)
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
	stfs 13,616(31)
.L967:
	lis 9,Use_RPlat@ha
	mr 3,31
	la 9,Use_RPlat@l(9)
	stw 9,692(31)
	bl plat_spawn_inside_trigger
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 12,2,.L968
	li 0,2
	b .L970
.L968:
	lfs 12,608(31)
	lis 9,gi+72@ha
	mr 3,31
	lfs 0,612(31)
	lfs 13,616(31)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	li 0,1
.L970:
	stw 0,1084(31)
	lfs 2,16(31)
	lis 29,gi@ha
	lis 3,.LC47@ha
	lfs 3,20(31)
	la 29,gi@l(29)
	la 3,.LC47@l(3)
	lfs 4,24(31)
	lfs 0,572(31)
	lfs 13,576(31)
	lfs 12,580(31)
	lfs 11,884(31)
	lfs 10,596(31)
	lfs 9,600(31)
	lfs 8,604(31)
	lfs 7,608(31)
	lfs 6,612(31)
	lfs 5,616(31)
	stfs 0,1068(31)
	stfs 13,1064(31)
	stfs 12,1072(31)
	stfs 11,1080(31)
	stfs 10,1004(31)
	stfs 9,1008(31)
	stfs 8,1012(31)
	stfs 7,1028(31)
	stfs 6,1032(31)
	stfs 5,1036(31)
	stfs 2,1040(31)
	stfs 3,1044(31)
	stfs 4,1048(31)
	stfs 2,1016(31)
	stfs 3,1020(31)
	stfs 4,1024(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,1052(31)
	lwz 9,36(29)
	lis 3,.LC48@ha
	la 3,.LC48@l(3)
	mtlr 9
	blrl
	stw 3,1056(31)
	lwz 0,36(29)
	lis 3,.LC49@ha
	la 3,.LC49@l(3)
	mtlr 0
	blrl
	stw 3,1060(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe41:
	.size	 Rplat_Plat,.Lfe41-Rplat_Plat
	.align 2
	.globl RplatAngleMove_Done
	.type	 RplatAngleMove_Done,@function
RplatAngleMove_Done:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,292(31)
	cmpwi 0,0,2
	bc 4,2,.L7
	li 0,3
	stw 0,292(31)
	crxor 6,6,6
	bl Rplat_Rot
.L7:
	lwz 9,1120(31)
	mr 3,31
	li 0,0
	stw 0,632(31)
	mtlr 9
	stw 0,640(31)
	stw 0,636(31)
	blrl
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe42:
	.size	 RplatAngleMove_Done,.Lfe42-RplatAngleMove_Done
	.align 2
	.globl RplatMove_Done
	.type	 RplatMove_Done,@function
RplatMove_Done:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,292(31)
	cmpwi 0,0,1
	bc 4,2,.L9
	lwz 11,296(31)
	lis 9,st+28@ha
	li 10,2
	stw 11,st+28@l(9)
	lwz 0,320(31)
	stw 10,292(31)
	stw 0,536(31)
	crxor 6,6,6
	bl Rplat_dr
.L9:
	lwz 9,1120(31)
	mr 3,31
	li 0,0
	stw 0,620(31)
	mtlr 9
	stw 0,628(31)
	stw 0,624(31)
	blrl
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe43:
	.size	 RplatMove_Done,.Lfe43-RplatMove_Done
	.align 2
	.globl Move_Done
	.type	 Move_Done,@function
Move_Done:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	li 0,0
	lwz 10,1120(9)
	stw 0,620(9)
	mtlr 10
	stw 0,628(9)
	stw 0,624(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe44:
	.size	 Move_Done,.Lfe44-Move_Done
	.section	".rodata"
	.align 3
.LC158:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC159:
	.long 0x0
	.section	".text"
	.align 2
	.globl Move_Final
	.type	 Move_Final,@function
Move_Final:
	stwu 1,-32(1)
	mflr 0
	stfd 30,16(1)
	stfd 31,24(1)
	stw 31,12(1)
	stw 0,36(1)
	lis 9,.LC159@ha
	mr 31,3
	la 9,.LC159@l(9)
	lfs 1,1112(31)
	lfs 31,0(9)
	fcmpu 0,1,31
	bc 4,2,.L12
	lwz 0,1120(31)
	b .L978
.L12:
	lis 9,.LC158@ha
	addi 3,31,1088
	lfd 30,.LC158@l(9)
	addi 4,31,620
	fdiv 1,1,30
	frsp 1,1
	bl VectorScale
	lwz 0,292(31)
	cmpwi 0,0,1
	bc 4,2,.L14
	lwz 11,296(31)
	lis 9,st+28@ha
	li 10,2
	mr 3,31
	stw 11,st+28@l(9)
	lwz 0,320(31)
	stw 10,292(31)
	stw 0,536(31)
	crxor 6,6,6
	bl Rplat_dr
	lwz 0,1120(31)
	mr 3,31
.L978:
	stfs 31,620(31)
	stfs 31,628(31)
	mtlr 0
	stfs 31,624(31)
	blrl
	b .L11
.L14:
	lis 9,Move_Done@ha
	lis 11,level+4@ha
	la 9,Move_Done@l(9)
	stw 9,680(31)
	lfs 0,level+4@l(11)
	fadd 0,0,30
	frsp 0,0
	stfs 0,672(31)
.L11:
	lwz 0,36(1)
	mtlr 0
	lwz 31,12(1)
	lfd 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe45:
	.size	 Move_Final,.Lfe45-Move_Final
	.section	".rodata"
	.align 3
.LC160:
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
	stw 0,620(31)
	mr 29,5
	addi 3,31,1088
	stw 0,628(31)
	stw 0,624(31)
	lfs 13,0(4)
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,1088(31)
	lfs 0,4(4)
	fsubs 0,0,12
	stfs 0,1092(31)
	lfs 13,8(4)
	fsubs 13,13,11
	stfs 13,1096(31)
	bl VectorNormalize
	lfs 13,1068(31)
	lfs 0,1064(31)
	stfs 1,1112(31)
	stw 29,1120(31)
	fcmpu 0,13,0
	bc 4,2,.L29
	lfs 0,1072(31)
	fcmpu 0,13,0
	bc 4,2,.L29
	lwz 0,268(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L31
	lwz 0,840(31)
	cmpw 0,9,0
	bc 12,2,.L32
	b .L30
.L31:
	cmpw 0,9,31
	bc 4,2,.L30
.L32:
	mr 3,31
	bl Move_Begin
	b .L34
.L30:
	lis 11,level+4@ha
	lis 10,.LC160@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC160@l(10)
	la 9,Move_Begin@l(9)
	stw 9,680(31)
	b .L979
.L29:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,1100(31)
	lis 10,level+4@ha
	stw 9,680(31)
	lis 11,.LC160@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC160@l(11)
.L979:
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L34:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe46:
	.size	 Move_Calc,.Lfe46-Move_Calc
	.align 2
	.globl AngleMove_Done
	.type	 AngleMove_Done,@function
AngleMove_Done:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	li 0,0
	lwz 10,1120(9)
	stw 0,632(9)
	mtlr 10
	stw 0,640(9)
	stw 0,636(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe47:
	.size	 AngleMove_Done,.Lfe47-AngleMove_Done
	.section	".rodata"
	.align 3
.LC161:
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
	lwz 9,268(3)
	li 0,0
	lis 11,level+292@ha
	stw 0,632(3)
	andi. 10,9,1024
	stw 4,1120(3)
	stw 0,640(3)
	stw 0,636(3)
	lwz 9,level+292@l(11)
	bc 12,2,.L54
	lwz 0,840(3)
	cmpw 0,9,0
	bc 12,2,.L55
	b .L53
.L54:
	cmpw 0,9,3
	bc 4,2,.L53
.L55:
	bl AngleMove_Begin
	b .L56
.L53:
	lis 11,level+4@ha
	lis 10,.LC161@ha
	lfs 0,level+4@l(11)
	lis 9,AngleMove_Begin@ha
	lfd 13,.LC161@l(10)
	la 9,AngleMove_Begin@l(9)
	stw 9,680(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(3)
.L56:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe48:
	.size	 AngleMove_Calc,.Lfe48-AngleMove_Calc
	.section	".rodata"
	.align 2
.LC162:
	.long 0x3f000000
	.align 2
.LC163:
	.long 0x0
	.align 2
.LC164:
	.long 0x3f800000
	.align 2
.LC165:
	.long 0x40800000
	.align 2
.LC166:
	.long 0xc0000000
	.align 3
.LC167:
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
	bc 4,0,.L58
	stfs 9,96(31)
	b .L57
.L58:
	fdivs 0,11,10
	lfs 31,68(31)
	lis 9,.LC162@ha
	la 9,.LC162@l(9)
	lfs 30,0(9)
	lis 9,.LC163@ha
	la 9,.LC163@l(9)
	lfs 12,0(9)
	lis 9,.LC164@ha
	la 9,.LC164@l(9)
	lfs 29,0(9)
	fdivs 13,11,31
	fmadds 0,0,11,11
	fmadds 13,13,11,11
	fmuls 0,0,30
	fmuls 1,13,30
	fsubs 0,9,0
	fsubs 0,0,1
	fcmpu 0,0,12
	bc 4,0,.L59
	fmuls 12,10,31
	lis 9,.LC165@ha
	fadds 31,10,31
	la 9,.LC165@l(9)
	lfs 1,0(9)
	lis 9,.LC166@ha
	fdivs 31,31,12
	la 9,.LC166@l(9)
	lfs 13,0(9)
	fmuls 0,31,1
	fmuls 13,9,13
	fmuls 0,0,13
	fsubs 1,1,0
	bl sqrt
	lis 9,.LC167@ha
	fadds 31,31,31
	lfs 13,68(31)
	la 9,.LC167@l(9)
	lfd 0,0(9)
	fadd 1,1,0
	fdiv 1,1,31
	frsp 1,1
	fdivs 13,1,13
	stfs 1,100(31)
	fadds 13,13,29
	fmuls 1,1,13
	fmuls 1,1,30
.L59:
	stfs 1,112(31)
.L57:
	lwz 0,52(1)
	mtlr 0
	lwz 31,20(1)
	lfd 29,24(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe49:
	.size	 plat_CalcAcceleratedMove,.Lfe49-plat_CalcAcceleratedMove
	.section	".rodata"
	.align 2
.LC168:
	.long 0x3f800000
	.align 2
.LC169:
	.long 0x40400000
	.align 2
.LC170:
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
	lwz 0,268(31)
	andi. 30,0,1024
	bc 4,2,.L86
	lwz 5,1060(31)
	cmpwi 0,5,0
	bc 12,2,.L87
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC168@ha
	la 9,.LC168@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC169@ha
	la 9,.LC169@l(9)
	lfs 2,0(9)
	lis 9,.LC170@ha
	la 9,.LC170@l(9)
	lfs 3,0(9)
	blrl
.L87:
	stw 30,76(31)
.L86:
	lis 9,plat_go_down@ha
	li 0,0
	la 9,plat_go_down@l(9)
	stw 0,1084(31)
	lis 11,level+4@ha
	stw 9,680(31)
	lis 9,.LC169@ha
	lfs 0,level+4@l(11)
	la 9,.LC169@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,672(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe50:
	.size	 plat_hit_top,.Lfe50-plat_hit_top
	.section	".rodata"
	.align 2
.LC171:
	.long 0x3f800000
	.align 2
.LC172:
	.long 0x40400000
	.align 2
.LC173:
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
	lwz 0,268(31)
	andi. 30,0,1024
	bc 4,2,.L89
	lwz 5,1060(31)
	cmpwi 0,5,0
	bc 12,2,.L90
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC171@ha
	la 9,.LC171@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC172@ha
	la 9,.LC172@l(9)
	lfs 2,0(9)
	lis 9,.LC173@ha
	la 9,.LC173@l(9)
	lfs 3,0(9)
	blrl
.L90:
	stw 30,76(31)
.L89:
	li 0,1
	stw 0,1084(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe51:
	.size	 plat_hit_bottom,.Lfe51-plat_hit_bottom
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
	bc 4,2,.L114
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L114
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
	bc 12,2,.L113
	mr 3,31
	bl BecomeExplosion1
	b .L113
.L114:
	lis 6,vec3_origin@ha
	lwz 9,792(30)
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
	lwz 0,1084(30)
	cmpwi 0,0,2
	bc 4,2,.L116
	mr 3,30
	bl plat_go_down
	b .L113
.L116:
	cmpwi 0,0,3
	bc 4,2,.L113
	mr 3,30
	bl plat_go_up
.L113:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe52:
	.size	 plat_blocked,.Lfe52-plat_blocked
	.align 2
	.globl Use_Plat
	.type	 Use_Plat,@function
Use_Plat:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,680(3)
	cmpwi 0,0,0
	bc 4,2,.L119
	bl plat_go_down
.L119:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe53:
	.size	 Use_Plat,.Lfe53-Use_Plat
	.section	".rodata"
	.align 2
.LC174:
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
	bc 12,2,.L121
	lwz 0,728(4)
	cmpwi 0,0,0
	bc 4,1,.L121
	lwz 3,816(3)
	lwz 0,1084(3)
	cmpwi 0,0,1
	bc 4,2,.L124
	bl plat_go_up
	b .L121
.L124:
	cmpwi 0,0,0
	bc 4,2,.L121
	lis 11,.LC174@ha
	lis 9,level+4@ha
	la 11,.LC174@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,672(3)
.L121:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe54:
	.size	 Touch_Plat_Center,.Lfe54-Touch_Plat_Center
	.section	".rodata"
	.align 2
.LC175:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Blue_Touch_Plat_Center
	.type	 Blue_Touch_Plat_Center,@function
Blue_Touch_Plat_Center:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L127
	lwz 0,728(4)
	cmpwi 0,0,0
	bc 4,1,.L127
	lwz 0,908(4)
	cmpwi 0,0,2
	bc 12,2,.L127
	lwz 3,816(3)
	lwz 0,1084(3)
	cmpwi 0,0,1
	bc 4,2,.L131
	bl plat_go_up
	b .L127
.L131:
	cmpwi 0,0,0
	bc 4,2,.L127
	lis 11,.LC175@ha
	lis 9,level+4@ha
	la 11,.LC175@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,672(3)
.L127:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe55:
	.size	 Blue_Touch_Plat_Center,.Lfe55-Blue_Touch_Plat_Center
	.section	".rodata"
	.align 2
.LC176:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Red_Touch_Plat_Center
	.type	 Red_Touch_Plat_Center,@function
Red_Touch_Plat_Center:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L134
	lwz 0,728(4)
	cmpwi 0,0,0
	bc 4,1,.L134
	lwz 0,908(4)
	cmpwi 0,0,1
	bc 12,2,.L134
	lwz 3,816(3)
	lwz 0,1084(3)
	cmpwi 0,0,1
	bc 4,2,.L138
	bl plat_go_up
	b .L134
.L138:
	cmpwi 0,0,0
	bc 4,2,.L134
	lis 11,.LC176@ha
	lis 9,level+4@ha
	la 11,.LC176@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,672(3)
.L134:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe56:
	.size	 Red_Touch_Plat_Center,.Lfe56-Red_Touch_Plat_Center
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
	lwz 9,792(11)
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
.Lfe57:
	.size	 rotating_blocked,.Lfe57-rotating_blocked
	.section	".rodata"
	.align 2
.LC177:
	.long 0x0
	.section	".text"
	.align 2
	.globl rotating_touch
	.type	 rotating_touch,@function
rotating_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC177@ha
	mr 11,3
	la 9,.LC177@l(9)
	lfs 0,632(11)
	mr 3,4
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L198
	lfs 0,636(11)
	fcmpu 0,0,13
	bc 4,2,.L198
	lfs 0,640(11)
	fcmpu 0,0,13
	bc 12,2,.L197
.L198:
	lwz 9,792(11)
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
.L197:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe58:
	.size	 rotating_touch,.Lfe58-rotating_touch
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
	addi 30,31,632
	la 4,vec3_origin@l(4)
	mr 3,30
	bl VectorCompare
	mr. 3,3
	bc 4,2,.L200
	li 0,0
	stw 3,688(31)
	stw 0,632(31)
	stw 3,76(31)
	stw 0,640(31)
	stw 0,636(31)
	b .L201
.L200:
	lwz 0,1056(31)
	mr 4,30
	addi 3,31,584
	lfs 1,572(31)
	stw 0,76(31)
	bl VectorScale
	lwz 0,288(31)
	andi. 9,0,16
	bc 12,2,.L201
	lis 9,rotating_touch@ha
	la 9,rotating_touch@l(9)
	stw 9,688(31)
.L201:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe59:
	.size	 rotating_use,.Lfe59-rotating_use
	.align 2
	.globl button_done
	.type	 button_done,@function
button_done:
	lwz 0,64(3)
	li 9,1
	stw 9,1084(3)
	rlwinm 0,0,0,21,19
	ori 0,0,1024
	stw 0,64(3)
	blr
.Lfe60:
	.size	 button_done,.Lfe60-button_done
	.section	".rodata"
	.align 2
.LC178:
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
	lwz 4,824(31)
	rlwinm 0,0,0,22,20
	stw 9,1084(31)
	ori 0,0,2048
	stw 0,64(31)
	bl G_UseTargets
	lis 9,.LC178@ha
	lfs 13,1080(31)
	li 0,1
	la 9,.LC178@l(9)
	stw 0,56(31)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L229
	lis 9,level+4@ha
	lis 11,button_return@ha
	lfs 0,level+4@l(9)
	la 11,button_return@l(11)
	stw 11,680(31)
	fadds 0,0,13
	stfs 0,672(31)
.L229:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe61:
	.size	 button_wait,.Lfe61-button_wait
	.align 2
	.globl button_use
	.type	 button_use,@function
button_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	stw 5,824(3)
	bl button_fire
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe62:
	.size	 button_use,.Lfe62-button_use
	.align 2
	.globl button_killed
	.type	 button_killed,@function
button_killed:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 11,3
	lwz 9,908(11)
	cmpwi 0,9,0
	bc 12,2,.L265
	lwz 0,908(5)
	cmpw 0,0,9
	bc 4,2,.L264
	lwz 10,872(11)
	cmpwi 0,10,0
	bc 12,2,.L267
	lwz 9,84(5)
	lwz 0,3560(9)
	add 0,0,10
	stw 0,3560(9)
.L267:
	lwz 8,876(11)
	cmpwi 0,8,0
	bc 12,2,.L265
	lis 9,level@ha
	la 10,level@l(9)
	lwz 0,316(10)
	cmpwi 0,0,1
	bc 4,2,.L269
	lwz 0,84(5)
	cmpwi 0,0,0
	bc 12,2,.L270
	lwz 0,908(5)
	cmpwi 0,0,1
	bc 4,2,.L271
	lwz 0,304(10)
	add 0,0,8
	stw 0,304(10)
	b .L270
.L271:
	lwz 0,308(10)
	add 0,0,8
	stw 0,308(10)
.L270:
	lis 9,level+4@ha
	lfs 13,884(11)
	lfs 0,level+4@l(9)
	fadds 0,0,13
	stfs 0,936(11)
	b .L265
.L269:
	lwz 0,84(5)
	cmpwi 0,0,0
	bc 12,2,.L265
	lwz 0,908(5)
	cmpwi 0,0,1
	bc 4,2,.L275
	lwz 0,304(10)
	add 0,0,8
	stw 0,304(10)
.L275:
	lwz 0,908(5)
	cmpwi 0,0,2
	bc 4,2,.L276
	lwz 0,308(10)
	lwz 9,876(11)
	add 0,0,9
	stw 0,308(10)
.L276:
	lwz 0,908(5)
	cmpwi 0,0,3
	bc 4,2,.L265
	lwz 0,312(10)
	lwz 9,876(11)
	add 0,0,9
	stw 0,312(10)
.L265:
	lwz 0,756(11)
	li 9,0
	mr 3,11
	stw 5,824(11)
	stw 0,728(11)
	stw 9,788(11)
	bl button_fire
.L264:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe63:
	.size	 button_killed,.Lfe63-button_killed
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
	lwz 0,532(30)
	li 31,0
	cmpwi 0,0,0
	bc 12,2,.L288
	lis 9,gi@ha
	lis 27,.LC71@ha
	la 28,gi@l(9)
	b .L290
.L292:
	lwz 3,284(31)
	la 4,.LC71@l(27)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L290
	lwz 9,64(28)
	mr 4,29
	lwz 3,996(31)
	mtlr 9
	blrl
.L290:
	lwz 5,532(30)
	mr 3,31
	li 4,536
	bl G_Find
	mr. 31,3
	bc 4,2,.L292
.L288:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe64:
	.size	 door_use_areaportals,.Lfe64-door_use_areaportals
	.section	".rodata"
	.align 2
.LC179:
	.long 0x3f800000
	.align 2
.LC180:
	.long 0x40400000
	.align 2
.LC181:
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
	lwz 0,268(31)
	andi. 30,0,1024
	bc 4,2,.L296
	lwz 5,1060(31)
	cmpwi 0,5,0
	bc 12,2,.L297
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC179@ha
	la 9,.LC179@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC180@ha
	la 9,.LC180@l(9)
	lfs 2,0(9)
	lis 9,.LC181@ha
	la 9,.LC181@l(9)
	lfs 3,0(9)
	blrl
.L297:
	stw 30,76(31)
.L296:
	li 0,0
	lwz 9,288(31)
	stw 0,1084(31)
	andi. 0,9,32
	bc 4,2,.L295
	lis 9,.LC181@ha
	lfs 13,1080(31)
	la 9,.LC181@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L295
	lis 9,door_go_down@ha
	lis 11,level+4@ha
	la 9,door_go_down@l(9)
	stw 9,680(31)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	stfs 0,672(31)
.L295:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe65:
	.size	 door_hit_top,.Lfe65-door_hit_top
	.section	".rodata"
	.align 2
.LC182:
	.long 0x3f800000
	.align 2
.LC183:
	.long 0x40400000
	.align 2
.LC184:
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
	lwz 0,268(31)
	andi. 30,0,1024
	bc 4,2,.L301
	lwz 5,1060(31)
	cmpwi 0,5,0
	bc 12,2,.L302
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC182@ha
	la 9,.LC182@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC183@ha
	la 9,.LC183@l(9)
	lfs 2,0(9)
	lis 9,.LC184@ha
	la 9,.LC184@l(9)
	lfs 3,0(9)
	blrl
.L302:
	stw 30,76(31)
.L301:
	lwz 9,532(31)
	li 0,1
	li 30,0
	stw 0,1084(31)
	cmpwi 0,9,0
	bc 12,2,.L304
	lis 9,gi@ha
	lis 28,.LC71@ha
	la 29,gi@l(9)
	b .L305
.L307:
	lwz 3,284(30)
	la 4,.LC71@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L305
	lwz 9,64(29)
	li 4,0
	lwz 3,996(30)
	mtlr 9
	blrl
.L305:
	lwz 5,532(31)
	mr 3,30
	li 4,536
	bl G_Find
	mr. 30,3
	bc 4,2,.L307
.L304:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe66:
	.size	 door_hit_bottom,.Lfe66-door_hit_bottom
	.align 2
	.globl door_use
	.type	 door_use,@function
door_use:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lwz 0,268(3)
	mr 29,5
	andi. 9,0,1024
	bc 4,2,.L415
	lwz 0,288(3)
	andi. 11,0,32
	bc 12,2,.L417
	lwz 0,1084(3)
	subfic 11,0,0
	adde 9,11,0
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L417
	mr. 31,3
	bc 12,2,.L415
	li 30,0
.L422:
	stw 30,280(31)
	mr 3,31
	stw 30,688(31)
	bl door_go_down
	lwz 31,836(31)
	cmpwi 0,31,0
	bc 4,2,.L422
	b .L415
.L417:
	mr. 31,3
	bc 12,2,.L415
	li 30,0
.L427:
	stw 30,280(31)
	mr 3,31
	mr 4,29
	stw 30,688(31)
	bl door_go_up
	lwz 31,836(31)
	cmpwi 0,31,0
	bc 4,2,.L427
.L415:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe67:
	.size	 door_use,.Lfe67-door_use
	.section	".rodata"
	.align 3
.LC185:
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
	lwz 0,728(29)
	cmpwi 0,0,0
	bc 4,1,.L429
	lwz 0,184(29)
	andi. 9,0,4
	mcrf 7,0
	bc 4,30,.L431
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L429
.L431:
	lwz 11,256(3)
	lwz 0,288(11)
	andi. 10,0,8
	bc 12,2,.L432
	bc 4,30,.L429
.L432:
	lis 9,level+4@ha
	lfs 0,704(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L429
	lis 9,.LC185@ha
	fmr 0,13
	la 9,.LC185@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,704(3)
	lwz 0,268(11)
	andi. 10,0,1024
	bc 4,2,.L429
	lwz 0,288(11)
	andi. 9,0,32
	bc 12,2,.L436
	lwz 0,1084(11)
	subfic 10,0,0
	adde 9,10,0
	xori 0,0,2
	subfic 10,0,0
	adde 0,10,0
	or. 10,0,9
	bc 12,2,.L436
	mr. 31,11
	bc 12,2,.L429
	li 30,0
.L440:
	stw 30,280(31)
	mr 3,31
	stw 30,688(31)
	bl door_go_down
	lwz 31,836(31)
	cmpwi 0,31,0
	bc 4,2,.L440
	b .L429
.L436:
	mr. 31,11
	bc 12,2,.L429
	li 30,0
.L445:
	stw 30,280(31)
	mr 3,31
	mr 4,29
	stw 30,688(31)
	bl door_go_up
	lwz 31,836(31)
	cmpwi 0,31,0
	bc 4,2,.L445
.L429:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe68:
	.size	 Touch_DoorTrigger,.Lfe68-Touch_DoorTrigger
	.section	".rodata"
	.align 3
.LC186:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Touch_Red_DoorTrigger
	.type	 Touch_Red_DoorTrigger,@function
Touch_Red_DoorTrigger:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,4
	lwz 0,728(29)
	cmpwi 0,0,0
	bc 4,1,.L448
	lwz 0,908(29)
	cmpwi 0,0,1
	bc 12,2,.L448
	lwz 0,184(29)
	andi. 9,0,4
	mcrf 7,0
	bc 4,30,.L451
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L448
.L451:
	lwz 11,256(3)
	lwz 0,288(11)
	andi. 10,0,8
	bc 12,2,.L452
	bc 4,30,.L448
.L452:
	lis 9,level+4@ha
	lfs 0,704(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L448
	lis 9,.LC186@ha
	fmr 0,13
	la 9,.LC186@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,704(3)
	lwz 0,268(11)
	andi. 10,0,1024
	bc 4,2,.L448
	lwz 0,288(11)
	andi. 9,0,32
	bc 12,2,.L456
	lwz 0,1084(11)
	subfic 10,0,0
	adde 9,10,0
	xori 0,0,2
	subfic 10,0,0
	adde 0,10,0
	or. 10,0,9
	bc 12,2,.L456
	mr. 31,11
	bc 12,2,.L448
	li 30,0
.L460:
	stw 30,280(31)
	mr 3,31
	stw 30,688(31)
	bl door_go_down
	lwz 31,836(31)
	cmpwi 0,31,0
	bc 4,2,.L460
	b .L448
.L456:
	mr. 31,11
	bc 12,2,.L448
	li 30,0
.L465:
	stw 30,280(31)
	mr 3,31
	mr 4,29
	stw 30,688(31)
	bl door_go_up
	lwz 31,836(31)
	cmpwi 0,31,0
	bc 4,2,.L465
.L448:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe69:
	.size	 Touch_Red_DoorTrigger,.Lfe69-Touch_Red_DoorTrigger
	.section	".rodata"
	.align 3
.LC187:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Touch_Blue_DoorTrigger
	.type	 Touch_Blue_DoorTrigger,@function
Touch_Blue_DoorTrigger:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,4
	lwz 0,728(29)
	cmpwi 0,0,0
	bc 4,1,.L468
	lwz 0,908(29)
	cmpwi 0,0,2
	bc 12,2,.L468
	lwz 0,184(29)
	andi. 9,0,4
	mcrf 7,0
	bc 4,30,.L471
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L468
.L471:
	lwz 11,256(3)
	lwz 0,288(11)
	andi. 10,0,8
	bc 12,2,.L472
	bc 4,30,.L468
.L472:
	lis 9,level+4@ha
	lfs 0,704(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L468
	lis 9,.LC187@ha
	fmr 0,13
	la 9,.LC187@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,704(3)
	lwz 0,268(11)
	andi. 10,0,1024
	bc 4,2,.L468
	lwz 0,288(11)
	andi. 9,0,32
	bc 12,2,.L476
	lwz 0,1084(11)
	subfic 10,0,0
	adde 9,10,0
	xori 0,0,2
	subfic 10,0,0
	adde 0,10,0
	or. 10,0,9
	bc 12,2,.L476
	mr. 31,11
	bc 12,2,.L468
	li 30,0
.L480:
	stw 30,280(31)
	mr 3,31
	stw 30,688(31)
	bl door_go_down
	lwz 31,836(31)
	cmpwi 0,31,0
	bc 4,2,.L480
	b .L468
.L476:
	mr. 31,11
	bc 12,2,.L468
	li 30,0
.L485:
	stw 30,280(31)
	mr 3,31
	mr 4,29
	stw 30,688(31)
	bl door_go_up
	lwz 31,836(31)
	cmpwi 0,31,0
	bc 4,2,.L485
.L468:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe70:
	.size	 Touch_Blue_DoorTrigger,.Lfe70-Touch_Blue_DoorTrigger
	.align 2
	.globl Think_CalcMoveSpeed
	.type	 Think_CalcMoveSpeed,@function
Think_CalcMoveSpeed:
	lwz 0,268(3)
	andi. 9,0,1024
	bclr 4,2
	lwz 9,836(3)
	lfs 0,1076(3)
	cmpwi 0,9,0
	lfs 12,1068(3)
	fabs 13,0
	bc 12,2,.L491
.L493:
	lfs 0,1076(9)
	fabs 0,0
	fcmpu 0,0,13
	bc 4,0,.L492
	fmr 13,0
.L492:
	lwz 9,836(9)
	cmpwi 0,9,0
	bc 4,2,.L493
.L491:
	mr. 9,3
	fdivs 0,13,12
	bclr 12,2
	fmr 9,0
.L499:
	lfs 0,1076(9)
	lfs 13,1068(9)
	lfs 11,1064(9)
	fcmpu 0,11,13
	fabs 0,0
	fdiv 0,0,9
	frsp 12,0
	fdivs 10,12,13
	bc 4,2,.L500
	stfs 12,1064(9)
	b .L501
.L500:
	fmuls 0,11,10
	stfs 0,1064(9)
.L501:
	lfs 13,1072(9)
	lfs 0,1068(9)
	fcmpu 0,13,0
	bc 4,2,.L502
	stfs 12,1072(9)
	b .L503
.L502:
	fmuls 0,13,10
	stfs 0,1072(9)
.L503:
	stfs 12,1068(9)
	lwz 9,836(9)
	cmpwi 0,9,0
	bc 4,2,.L499
	blr
.Lfe71:
	.size	 Think_CalcMoveSpeed,.Lfe71-Think_CalcMoveSpeed
	.section	".rodata"
	.align 2
.LC188:
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
	bc 4,2,.L602
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L602
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
	bc 12,2,.L601
	mr 3,31
	bl BecomeExplosion1
	b .L601
.L602:
	lis 6,vec3_origin@ha
	lwz 9,792(30)
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
	lwz 0,288(30)
	andi. 9,0,4
	bc 4,2,.L601
	lis 9,.LC188@ha
	lfs 13,1080(30)
	la 9,.LC188@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L601
	lwz 0,1084(30)
	cmpwi 0,0,3
	bc 4,2,.L606
	lwz 31,840(30)
	cmpwi 0,31,0
	bc 12,2,.L601
.L610:
	lwz 4,824(31)
	mr 3,31
	bl door_go_up
	lwz 31,836(31)
	cmpwi 0,31,0
	bc 4,2,.L610
	b .L601
.L606:
	lwz 31,840(30)
	cmpwi 0,31,0
	bc 12,2,.L601
.L616:
	mr 3,31
	bl door_go_down
	lwz 31,836(31)
	cmpwi 0,31,0
	bc 4,2,.L616
.L601:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe72:
	.size	 door_blocked,.Lfe72-door_blocked
	.align 2
	.globl door_killed
	.type	 door_killed,@function
door_killed:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lwz 9,840(3)
	mr 29,5
	cmpwi 0,9,0
	bc 12,2,.L620
	li 11,0
.L622:
	lwz 0,756(9)
	stw 11,788(9)
	stw 0,728(9)
	lwz 9,836(9)
	cmpwi 0,9,0
	bc 4,2,.L622
.L620:
	lwz 3,840(3)
	lwz 0,268(3)
	andi. 9,0,1024
	bc 4,2,.L625
	lwz 0,288(3)
	andi. 11,0,32
	bc 12,2,.L626
	lwz 0,1084(3)
	subfic 11,0,0
	adde 9,11,0
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L626
	mr. 31,3
	bc 12,2,.L625
	li 30,0
.L630:
	stw 30,280(31)
	mr 3,31
	stw 30,688(31)
	bl door_go_down
	lwz 31,836(31)
	cmpwi 0,31,0
	bc 4,2,.L630
	b .L625
.L626:
	mr. 31,3
	bc 12,2,.L625
	li 30,0
.L635:
	stw 30,280(31)
	mr 3,31
	mr 4,29
	stw 30,688(31)
	bl door_go_up
	lwz 31,836(31)
	cmpwi 0,31,0
	bc 4,2,.L635
.L625:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe73:
	.size	 door_killed,.Lfe73-door_killed
	.section	".rodata"
	.align 3
.LC189:
	.long 0x40140000
	.long 0x0
	.align 2
.LC190:
	.long 0x3f800000
	.align 2
.LC191:
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
	bc 12,2,.L638
	lis 9,level+4@ha
	lfs 0,704(11)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L638
	lis 9,.LC189@ha
	fmr 0,13
	lis 29,gi@ha
	lwz 5,280(11)
	la 9,.LC189@l(9)
	la 29,gi@l(29)
	lfd 13,0(9)
	lis 4,.LC88@ha
	mr 3,31
	la 4,.LC88@l(4)
	fadd 0,0,13
	frsp 0,0
	stfs 0,704(11)
	lwz 9,12(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC89@ha
	la 3,.LC89@l(3)
	mtlr 9
	blrl
	lis 9,.LC190@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC190@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC190@ha
	la 9,.LC190@l(9)
	lfs 2,0(9)
	lis 9,.LC191@ha
	la 9,.LC191@l(9)
	lfs 3,0(9)
	blrl
.L638:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe74:
	.size	 door_touch,.Lfe74-door_touch
	.section	".rodata"
	.align 3
.LC192:
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
	bc 4,2,.L734
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L734
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
	bc 12,2,.L733
	mr 3,31
	bl BecomeExplosion1
	b .L733
.L734:
	lis 9,level+4@ha
	lfs 0,704(12)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L733
	lwz 9,792(12)
	cmpwi 0,9,0
	bc 12,2,.L733
	lis 11,.LC192@ha
	fmr 0,13
	lis 6,vec3_origin@ha
	la 11,.LC192@l(11)
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
	stfs 0,704(12)
	bl T_Damage
.L733:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe75:
	.size	 train_blocked,.Lfe75-train_blocked
	.section	".rodata"
	.align 3
.LC193:
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
	lwz 3,532(31)
	cmpwi 0,3,0
	bc 4,2,.L774
	lis 9,gi+4@ha
	lis 3,.LC122@ha
	lwz 0,gi+4@l(9)
	la 3,.LC122@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L773
.L774:
	bl G_PickTarget
	mr. 11,3
	bc 4,2,.L775
	lis 9,gi+4@ha
	lis 3,.LC123@ha
	lwz 4,532(31)
	lwz 0,gi+4@l(9)
	la 3,.LC123@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L773
.L775:
	lwz 0,532(11)
	lis 9,gi+72@ha
	mr 3,31
	lfs 0,188(31)
	stw 0,532(31)
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
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 4,2,.L776
	lwz 0,288(31)
	ori 0,0,1
	stw 0,288(31)
.L776:
	lwz 0,288(31)
	andi. 9,0,1
	bc 12,2,.L773
	lis 11,level+4@ha
	lis 10,.LC193@ha
	lfs 0,level+4@l(11)
	lis 9,train_next@ha
	lfd 13,.LC193@l(10)
	la 9,train_next@l(9)
	stw 9,680(31)
	stw 31,824(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
.L773:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe76:
	.size	 func_train_find,.Lfe76-func_train_find
	.align 2
	.globl train_use
	.type	 train_use,@function
train_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,288(3)
	stw 5,824(3)
	andi. 0,9,1
	bc 12,2,.L779
	andi. 0,9,2
	bc 12,2,.L778
	li 0,0
	rlwinm 9,9,0,0,30
	stw 0,672(3)
	stw 9,288(3)
	stw 0,628(3)
	stw 0,624(3)
	stw 0,620(3)
	b .L778
.L779:
	lwz 0,568(3)
	cmpwi 0,0,0
	bc 12,2,.L782
	bl train_resume
	b .L778
.L782:
	bl train_next
.L778:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe77:
	.size	 train_use,.Lfe77-train_use
	.section	".rodata"
	.align 2
.LC194:
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
	lis 9,.LC194@ha
	mr 31,3
	la 9,.LC194@l(9)
	mr 30,4
	lfs 13,0(9)
	lwz 9,660(31)
	lfs 0,672(9)
	fcmpu 0,0,13
	bc 4,2,.L793
	lwz 3,548(30)
	cmpwi 0,3,0
	bc 4,2,.L795
	lis 9,gi+4@ha
	lis 3,.LC128@ha
	lwz 0,gi+4@l(9)
	la 3,.LC128@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L793
.L795:
	bl G_PickTarget
	mr. 3,3
	bc 4,2,.L796
	lis 9,gi+4@ha
	lis 3,.LC129@ha
	lwz 4,548(30)
	lwz 0,gi+4@l(9)
	la 3,.LC129@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L793
.L796:
	lwz 9,660(31)
	stw 3,568(9)
	lwz 3,660(31)
	bl train_resume
.L793:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe78:
	.size	 trigger_elevator_use,.Lfe78-trigger_elevator_use
	.align 2
	.globl trigger_elevator_init
	.type	 trigger_elevator_init,@function
trigger_elevator_init:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 3,532(31)
	cmpwi 0,3,0
	bc 4,2,.L798
	lis 9,gi+4@ha
	lis 3,.LC130@ha
	lwz 0,gi+4@l(9)
	la 3,.LC130@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L797
.L798:
	bl G_PickTarget
	cmpwi 0,3,0
	stw 3,660(31)
	bc 4,2,.L799
	lis 9,gi+4@ha
	lis 3,.LC131@ha
	lwz 4,532(31)
	lwz 0,gi+4@l(9)
	la 3,.LC131@l(3)
	b .L980
.L799:
	lwz 3,284(3)
	lis 4,.LC132@ha
	la 4,.LC132@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L800
	lis 9,gi+4@ha
	lis 3,.LC133@ha
	lwz 4,532(31)
	lwz 0,gi+4@l(9)
	la 3,.LC133@l(3)
.L980:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L797
.L800:
	lis 9,trigger_elevator_use@ha
	li 0,1
	la 9,trigger_elevator_use@l(9)
	stw 0,184(31)
	stw 9,692(31)
.L797:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe79:
	.size	 trigger_elevator_init,.Lfe79-trigger_elevator_init
	.section	".rodata"
	.align 3
.LC195:
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
	lis 11,.LC195@ha
	stw 9,680(3)
	lfs 0,level+4@l(10)
	lfd 13,.LC195@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(3)
	blr
.Lfe80:
	.size	 SP_trigger_elevator,.Lfe80-SP_trigger_elevator
	.section	".rodata"
	.align 2
.LC196:
	.long 0x46fffe00
	.align 3
.LC197:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC198:
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
	lwz 4,824(29)
	bl G_UseTargets
	bl rand
	rlwinm 3,3,0,17,31
	lfs 8,884(29)
	xoris 3,3,0x8000
	lis 0,0x4330
	lfs 11,892(29)
	stw 3,28(1)
	lis 8,.LC197@ha
	lis 10,.LC196@ha
	la 8,.LC197@l(8)
	stw 0,24(1)
	lis 11,level+4@ha
	lfd 0,0(8)
	lfd 13,24(1)
	lis 8,.LC198@ha
	lfs 9,.LC196@l(10)
	la 8,.LC198@l(8)
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
	stfs 0,672(29)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe81:
	.size	 func_timer_think,.Lfe81-func_timer_think
	.section	".rodata"
	.align 2
.LC199:
	.long 0x46fffe00
	.align 2
.LC200:
	.long 0x0
	.align 3
.LC201:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC202:
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
	lis 8,.LC200@ha
	mr 31,3
	la 8,.LC200@l(8)
	lfs 0,672(31)
	mr 4,5
	lfs 12,0(8)
	stw 4,824(31)
	fcmpu 0,0,12
	bc 12,2,.L804
	stfs 12,672(31)
	b .L803
.L804:
	lfs 13,888(31)
	fcmpu 0,13,12
	bc 12,2,.L805
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,13
	b .L981
.L805:
	mr 3,31
	bl G_UseTargets
	bl rand
	rlwinm 3,3,0,17,31
	lfs 8,884(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	lfs 11,892(31)
	stw 3,20(1)
	lis 8,.LC201@ha
	lis 10,.LC199@ha
	la 8,.LC201@l(8)
	stw 0,16(1)
	lis 11,level+4@ha
	lfd 0,0(8)
	lfd 13,16(1)
	lis 8,.LC202@ha
	lfs 9,.LC199@l(10)
	la 8,.LC202@l(8)
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
.L981:
	stfs 0,672(31)
.L803:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe82:
	.size	 func_timer_use,.Lfe82-func_timer_use
	.section	".rodata"
	.align 3
.LC203:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl func_conveyor_use
	.type	 func_conveyor_use,@function
func_conveyor_use:
	stwu 1,-16(1)
	lwz 11,288(3)
	andi. 0,11,1
	bc 12,2,.L813
	li 0,0
	rlwinm 9,11,0,0,30
	stw 0,572(3)
	stw 9,288(3)
	b .L814
.L813:
	lwz 0,808(3)
	lis 10,0x4330
	lis 8,.LC203@ha
	ori 11,11,1
	xoris 0,0,0x8000
	la 8,.LC203@l(8)
	stw 11,288(3)
	stw 0,12(1)
	stw 10,8(1)
	lfd 13,0(8)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,572(3)
.L814:
	lwz 0,288(3)
	andi. 0,0,2
	bc 4,2,.L815
	stw 0,808(3)
.L815:
	la 1,16(1)
	blr
.Lfe83:
	.size	 func_conveyor_use,.Lfe83-func_conveyor_use
	.section	".rodata"
	.align 2
.LC204:
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
	lis 9,.LC204@ha
	mr 31,3
	la 9,.LC204@l(9)
	lfs 0,572(31)
	lfs 12,0(9)
	fcmpu 0,0,12
	bc 4,2,.L817
	lis 0,0x42c8
	stw 0,572(31)
.L817:
	lwz 0,288(31)
	andi. 9,0,1
	bc 4,2,.L818
	lfs 0,572(31)
	stfs 12,572(31)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	stw 9,808(31)
.L818:
	lis 9,func_conveyor_use@ha
	lis 29,gi@ha
	lwz 4,272(31)
	la 9,func_conveyor_use@l(9)
	la 29,gi@l(29)
	stw 9,692(31)
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
.Lfe84:
	.size	 SP_func_conveyor,.Lfe84-SP_func_conveyor
	.section	".rodata"
	.align 3
.LC205:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl door_secret_move1
	.type	 door_secret_move1,@function
door_secret_move1:
	lis 11,level+4@ha
	lis 9,.LC205@ha
	lfs 0,level+4@l(11)
	la 9,.LC205@l(9)
	lfd 13,0(9)
	lis 9,door_secret_move2@ha
	la 9,door_secret_move2@l(9)
	stw 9,680(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(3)
	blr
.Lfe85:
	.size	 door_secret_move1,.Lfe85-door_secret_move1
	.section	".rodata"
	.align 2
.LC206:
	.long 0xbf800000
	.section	".text"
	.align 2
	.globl door_secret_move3
	.type	 door_secret_move3,@function
door_secret_move3:
	lis 9,.LC206@ha
	lfs 13,884(3)
	la 9,.LC206@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bclr 12,2
	lis 9,level+4@ha
	lis 11,door_secret_move4@ha
	lfs 0,level+4@l(9)
	la 11,door_secret_move4@l(11)
	stw 11,680(3)
	fadds 0,0,13
	stfs 0,672(3)
	blr
.Lfe86:
	.size	 door_secret_move3,.Lfe86-door_secret_move3
	.section	".rodata"
	.align 3
.LC207:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl door_secret_move5
	.type	 door_secret_move5,@function
door_secret_move5:
	lis 11,level+4@ha
	lis 9,.LC207@ha
	lfs 0,level+4@l(11)
	la 9,.LC207@l(9)
	lfd 13,0(9)
	lis 9,door_secret_move6@ha
	la 9,door_secret_move6@l(9)
	stw 9,680(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(3)
	blr
.Lfe87:
	.size	 door_secret_move5,.Lfe87-door_secret_move5
	.align 2
	.globl door_secret_done
	.type	 door_secret_done,@function
door_secret_done:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 12,2,.L869
	lwz 0,288(31)
	andi. 9,0,1
	bc 12,2,.L868
.L869:
	li 0,0
	li 9,1
	stw 0,728(31)
	stw 9,788(31)
.L868:
	lwz 0,532(31)
	li 30,0
	cmpwi 0,0,0
	bc 12,2,.L871
	lis 9,gi@ha
	lis 28,.LC71@ha
	la 29,gi@l(9)
	b .L872
.L874:
	lwz 3,284(30)
	la 4,.LC71@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L872
	lwz 9,64(29)
	li 4,0
	lwz 3,996(30)
	mtlr 9
	blrl
.L872:
	lwz 5,532(31)
	mr 3,30
	li 4,536
	bl G_Find
	mr. 30,3
	bc 4,2,.L874
.L871:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe88:
	.size	 door_secret_done,.Lfe88-door_secret_done
	.section	".rodata"
	.align 3
.LC208:
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
	bc 4,2,.L878
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L878
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
	bc 12,2,.L877
	mr 3,31
	bl BecomeExplosion1
	b .L877
.L878:
	lis 9,level+4@ha
	lfs 0,704(12)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L877
	lis 9,.LC208@ha
	fmr 0,13
	lis 6,vec3_origin@ha
	la 9,.LC208@l(9)
	li 0,0
	lfd 13,0(9)
	li 11,20
	mr 3,31
	lwz 9,792(12)
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
	stfs 0,704(12)
	bl T_Damage
.L877:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe89:
	.size	 door_secret_blocked,.Lfe89-door_secret_blocked
	.align 2
	.globl door_secret_die
	.type	 door_secret_die,@function
door_secret_die:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 4,5
	li 0,0
	stw 0,788(3)
	bl door_secret_use
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe90:
	.size	 door_secret_die,.Lfe90-door_secret_die
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
.Lfe91:
	.size	 use_killbox,.Lfe91-use_killbox
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
	lwz 4,272(29)
	mtlr 0
	blrl
	lis 9,use_killbox@ha
	li 0,1
	la 9,use_killbox@l(9)
	stw 0,184(29)
	stw 9,692(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe92:
	.size	 SP_func_killbox,.Lfe92-SP_func_killbox
	.section	".rodata"
	.align 3
.LC209:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Rplat_rot_use
	.type	 Rplat_rot_use,@function
Rplat_rot_use:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,304(31)
	lis 11,0x4330
	lis 10,.LC209@ha
	la 10,.LC209@l(10)
	lfs 13,572(31)
	addi 30,31,632
	xoris 0,0,0x8000
	lfd 12,0(10)
	lis 4,vec3_origin@ha
	stw 0,20(1)
	la 4,vec3_origin@l(4)
	mr 3,30
	stw 11,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fmuls 13,13,0
	stfs 13,1068(31)
	stfs 13,572(31)
	bl VectorCompare
	mr. 3,3
	bc 4,2,.L899
	li 0,0
	stw 3,688(31)
	stw 0,632(31)
	stw 3,76(31)
	stw 0,640(31)
	stw 0,636(31)
	b .L900
.L899:
	lwz 0,1056(31)
	mr 4,30
	addi 3,31,584
	lfs 1,572(31)
	stw 0,76(31)
	bl VectorScale
	lwz 0,288(31)
	andi. 9,0,16
	bc 12,2,.L900
	lis 9,rotating_touch@ha
	la 9,rotating_touch@l(9)
	stw 9,688(31)
.L900:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe93:
	.size	 Rplat_rot_use,.Lfe93-Rplat_rot_use
	.section	".rodata"
	.align 3
.LC210:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Rdoor_use
	.type	 Rdoor_use,@function
Rdoor_use:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lwz 0,300(3)
	lis 10,0x4330
	lis 11,.LC210@ha
	lfs 13,1068(3)
	mr 29,5
	xoris 0,0,0x8000
	la 11,.LC210@l(11)
	stw 0,28(1)
	stw 10,24(1)
	lfd 12,0(11)
	lfd 0,24(1)
	lwz 11,268(3)
	fsub 0,0,12
	andi. 0,11,1024
	frsp 0,0
	fmuls 13,13,0
	stfs 13,1068(3)
	bc 4,2,.L916
	lwz 0,324(3)
	andi. 9,0,32
	bc 12,2,.L918
	lwz 0,1084(3)
	subfic 11,0,0
	adde 9,11,0
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L918
	mr. 31,3
	bc 12,2,.L916
	li 30,0
.L923:
	stw 30,280(31)
	mr 3,31
	stw 30,688(31)
	bl door_go_down
	lwz 31,836(31)
	cmpwi 0,31,0
	bc 4,2,.L923
	b .L916
.L918:
	mr. 31,3
	bc 12,2,.L916
	li 30,0
.L928:
	stw 30,280(31)
	mr 3,31
	mr 4,29
	stw 30,688(31)
	bl door_go_up
	lwz 31,836(31)
	cmpwi 0,31,0
	bc 4,2,.L928
.L916:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe94:
	.size	 Rdoor_use,.Lfe94-Rdoor_use
	.align 2
	.globl Use_RPlat
	.type	 Use_RPlat,@function
Use_RPlat:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,680(3)
	cmpwi 0,0,0
	bc 4,2,.L955
	bl plat_go_down
.L955:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe95:
	.size	 Use_RPlat,.Lfe95-Use_RPlat
	.align 2
	.globl SP_func_drplat
	.type	 SP_func_drplat,@function
SP_func_drplat:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 0,16
	lwz 10,312(3)
	lis 9,st+28@ha
	stw 0,316(3)
	lwz 11,st+28@l(9)
	cmpwi 0,10,0
	lwz 0,536(3)
	stw 11,296(3)
	stw 0,320(3)
	bc 4,2,.L972
	li 0,3
	stw 0,312(3)
.L972:
	lwz 0,308(3)
	cmpwi 0,0,0
	bc 4,2,.L973
	li 0,3
	stw 0,308(3)
.L973:
	lwz 0,300(3)
	cmpwi 0,0,0
	bc 4,2,.L974
	li 0,10
	stw 0,300(3)
.L974:
	lwz 0,304(3)
	cmpwi 0,0,0
	bc 4,2,.L975
	li 0,10
	stw 0,304(3)
.L975:
	lwz 0,296(3)
	cmpwi 0,0,0
	bc 4,2,.L976
	li 0,90
	stw 0,296(3)
.L976:
	lwz 0,292(3)
	cmpwi 0,0,0
	bc 4,2,.L977
	li 0,1
	stw 0,292(3)
.L977:
	bl Rplat_Plat
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe96:
	.size	 SP_func_drplat,.Lfe96-SP_func_drplat
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
