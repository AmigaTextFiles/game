	.file	"g_func.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
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
	.globl plat_ent
	.section	".sdata","aw"
	.align 2
	.type	 plat_ent,@object
	.size	 plat_ent,4
plat_ent:
	.long 0
	.section	".rodata"
	.align 2
.LC20:
	.string	"Dropping PLAT nodes\n"
	.align 2
.LC21:
	.string	"Connecting PLAT nodes\n"
	.align 2
.LC22:
	.string	"Plat start node has %i visible nodes\n"
	.align 2
.LC23:
	.long 0x0
	.align 2
.LC24:
	.long 0x3f800000
	.align 2
.LC25:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl plat_hit_top
	.type	 plat_hit_top,@function
plat_hit_top:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 11,.LC23@ha
	lis 9,bot_calc_nodes@ha
	la 11,.LC23@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,bot_calc_nodes@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L68
	lwz 11,416(31)
	cmpwi 0,11,0
	bc 12,2,.L78
	lwz 0,1300(31)
	cmpwi 0,0,1
	bc 12,2,.L68
	lis 9,plat_ent@ha
	lis 30,plat_ent@ha
	lwz 0,plat_ent@l(9)
	cmpwi 0,0,0
	bc 12,2,.L68
	lwz 0,552(11)
	cmpw 0,0,31
	bc 4,2,.L68
	lis 3,.LC20@ha
	la 3,.LC20@l(3)
	crxor 6,6,6
	bl NodeDebug
	lfs 9,940(31)
	lis 29,gi@ha
	mr 3,31
	lfs 13,944(31)
	la 29,gi@l(29)
	lfs 0,948(31)
	lfs 11,8(31)
	lfs 10,12(31)
	lfs 12,4(31)
	stfs 9,4(31)
	stfs 13,8(31)
	stfs 0,12(31)
	lwz 9,72(29)
	stfs 12,8(1)
	mtlr 9
	stfs 11,12(1)
	stfs 10,16(1)
	blrl
	lwz 9,416(31)
	li 5,0
	li 6,0
	lwz 11,plat_ent@l(30)
	li 7,0
	li 8,1
	lfs 0,4(9)
	mr 3,11
	addi 4,3,4
	stfs 0,4(11)
	lwz 9,416(31)
	lfs 0,8(9)
	stfs 0,8(11)
	bl PlayerTrail_Add
	lwz 11,plat_ent@l(30)
	lis 10,start_trail@ha
	mr 3,31
	lwz 9,1292(11)
	stw 9,start_trail@l(10)
	stw 31,324(9)
	lfs 0,8(1)
	lfs 13,12(1)
	lfs 12,16(1)
	stfs 0,4(31)
	stfs 13,8(31)
	stfs 12,12(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 3,416(31)
	li 5,0
	li 6,0
	li 7,0
	li 8,0
	addi 4,3,4
	bl PlayerTrail_Add
	lis 3,.LC21@ha
	la 3,.LC21@l(3)
	crxor 6,6,6
	bl NodeDebug
	li 4,0
	b .L69
.L71:
	addi 4,4,1
.L69:
	cmpwi 0,4,23
	bc 4,1,.L83
	lwz 10,416(31)
	lis 9,start_trail@ha
	lwz 8,start_trail@l(9)
	lwz 11,1292(10)
	lwz 0,1276(11)
	stw 0,1176(8)
	b .L77
.L83:
	lis 11,start_trail@ha
	slwi 7,4,2
	lwz 9,start_trail@l(11)
	addi 8,9,1176
	lwzx 10,8,7
	cmpwi 0,10,-1
	bc 12,2,.L76
	lwz 9,416(31)
	lwz 11,1292(9)
	lwz 0,1276(11)
	cmpw 0,10,0
	bc 4,2,.L71
.L76:
	lwz 9,416(31)
	lwz 11,1292(9)
	lwz 0,1276(11)
	stwx 0,8,7
.L77:
	lis 3,.LC22@ha
	la 3,.LC22@l(3)
	crxor 6,6,6
	bl NodeDebug
	lis 9,start_trail@ha
	lwz 11,start_trail@l(9)
	lwz 3,1276(11)
	bl CalcRoutes
	lwz 9,416(31)
	lwz 11,1292(9)
	lwz 3,1276(11)
	bl CalcRoutes
	lis 9,plat_ent@ha
	lwz 3,plat_ent@l(9)
	bl G_FreeEdict
	li 0,1
	stw 0,1300(31)
.L68:
	lwz 3,416(31)
	cmpwi 0,3,0
	bc 12,2,.L78
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 4,2,.L79
	lis 9,.LC23@ha
	lis 11,bot_calc_nodes@ha
	la 9,.LC23@l(9)
	lfs 13,0(9)
	lwz 9,bot_calc_nodes@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L79
	li 4,0
	li 5,1
	bl ClosestNodeToEnt
	mr. 3,3
	bc 12,0,.L79
	lis 9,trail@ha
	slwi 11,3,2
	lwz 10,416(31)
	la 9,trail@l(9)
	lwzx 0,9,11
	stw 0,1292(10)
.L79:
	lwz 9,416(31)
	li 11,0
	lwz 0,264(9)
	rlwinm 0,0,0,22,20
	stw 0,264(9)
	stw 11,416(31)
.L78:
	lwz 0,264(31)
	andi. 29,0,1024
	bc 4,2,.L81
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L82
	lis 9,gi+16@ha
	lis 11,.LC25@ha
	lwz 0,gi+16@l(9)
	la 11,.LC25@l(11)
	mr 3,31
	lis 9,.LC24@ha
	li 4,10
	lfs 2,0(11)
	la 9,.LC24@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 3,0(9)
	blrl
.L82:
	stw 29,76(31)
.L81:
	lis 9,plat_go_down@ha
	li 0,0
	la 9,plat_go_down@l(9)
	stw 0,732(31)
	lis 11,level+4@ha
	stw 9,436(31)
	lis 9,.LC25@ha
	lfs 0,level+4@l(11)
	la 9,.LC25@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,428(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 plat_hit_top,.Lfe5-plat_hit_top
	.section	".rodata"
	.align 3
.LC26:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC27:
	.long 0x3f800000
	.align 2
.LC28:
	.long 0x40400000
	.align 2
.LC29:
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
	bc 4,2,.L88
	lwz 5,700(31)
	cmpwi 0,5,0
	bc 12,2,.L89
	lis 11,.LC27@ha
	lis 9,gi+16@ha
	la 11,.LC27@l(11)
	lwz 0,gi+16@l(9)
	lfs 1,0(11)
	lis 9,.LC28@ha
	li 4,10
	lis 11,.LC29@ha
	la 9,.LC28@l(9)
	mtlr 0
	la 11,.LC29@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L89:
	lwz 0,704(31)
	stw 0,76(31)
.L88:
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
	bc 4,2,.L90
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L90
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L91
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L92
	b .L93
.L91:
	cmpw 0,9,31
	bc 4,2,.L93
.L92:
	mr 3,31
	bl Move_Begin
	b .L96
.L93:
	lis 11,level+4@ha
	lis 10,.LC26@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC26@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L97
.L90:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC26@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC26@l(11)
.L97:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L96:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 plat_go_down,.Lfe6-plat_go_down
	.section	".rodata"
	.align 2
.LC30:
	.string	"Setting plat_ent\n"
	.align 2
.LC31:
	.string	"plat_ent"
	.align 3
.LC32:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC33:
	.long 0x0
	.align 2
.LC34:
	.long 0x41400000
	.align 2
.LC35:
	.long 0x42000000
	.align 2
.LC36:
	.long 0xc1800000
	.align 2
.LC37:
	.long 0xc1c00000
	.align 2
.LC38:
	.long 0x41800000
	.align 2
.LC39:
	.long 0x3f800000
	.align 2
.LC40:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl plat_go_up
	.type	 plat_go_up,@function
plat_go_up:
	stwu 1,-144(1)
	mflr 0
	stmw 29,132(1)
	stw 0,148(1)
	lis 9,bot_calc_nodes@ha
	lis 10,.LC33@ha
	lwz 11,bot_calc_nodes@l(9)
	la 10,.LC33@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L101
	lwz 3,416(31)
	cmpwi 0,3,0
	bc 12,2,.L101
	addi 29,1,40
	li 6,0
	addi 3,3,16
	mr 4,29
	li 5,0
	lis 30,VEC_ORIGIN@ha
	bl AngleVectors
	lis 9,.LC34@ha
	lwz 3,416(31)
	addi 5,1,8
	la 9,.LC34@l(9)
	mr 4,29
	lfs 1,0(9)
	addi 3,3,4
	bl VectorMA
	lis 9,.LC33@ha
	lis 10,.LC33@ha
	lis 11,.LC35@ha
	la 9,.LC33@l(9)
	la 10,.LC33@l(10)
	la 11,.LC35@l(11)
	lfs 1,0(9)
	lfs 2,0(10)
	lfs 3,0(11)
	bl tv
	lfs 13,0(3)
	lis 9,.LC33@ha
	lis 10,.LC33@ha
	lfs 0,8(1)
	lis 11,.LC35@ha
	la 9,.LC33@l(9)
	la 10,.LC33@l(10)
	la 11,.LC35@l(11)
	lfs 1,0(9)
	lfs 2,0(10)
	fsubs 0,0,13
	lfs 3,0(11)
	stfs 0,24(1)
	bl tv
	lfs 13,4(3)
	lis 9,.LC33@ha
	lis 10,.LC33@ha
	lfs 0,12(1)
	lis 11,.LC35@ha
	la 9,.LC33@l(9)
	la 10,.LC33@l(10)
	la 11,.LC35@l(11)
	lfs 1,0(9)
	lfs 2,0(10)
	fsubs 0,0,13
	lfs 3,0(11)
	stfs 0,28(1)
	bl tv
	lfs 13,8(3)
	lis 9,gi+48@ha
	la 5,VEC_ORIGIN@l(30)
	lfs 0,16(1)
	addi 3,1,56
	addi 4,1,8
	lwz 0,gi+48@l(9)
	mr 6,5
	addi 7,1,24
	lwz 8,416(31)
	li 9,3
	fsubs 0,0,13
	mtlr 0
	stfs 0,32(1)
	blrl
	lwz 0,108(1)
	cmpw 0,0,31
	bc 4,2,.L101
	lwz 9,416(31)
	lwz 0,264(9)
	ori 0,0,1024
	stw 0,264(9)
	lwz 11,1300(31)
	cmpwi 0,11,1
	bc 12,2,.L101
	lis 3,.LC30@ha
	lis 29,plat_ent@ha
	la 3,.LC30@l(3)
	crxor 6,6,6
	bl NodeDebug
	lwz 0,plat_ent@l(29)
	cmpwi 0,0,0
	bc 4,2,.L103
	bl G_Spawn
	stw 3,plat_ent@l(29)
.L103:
	lwz 11,plat_ent@l(29)
	lis 9,.LC31@ha
	lis 10,.LC36@ha
	la 9,.LC31@l(9)
	la 10,.LC36@l(10)
	lfs 1,0(10)
	stw 9,280(11)
	lis 10,.LC36@ha
	lis 11,.LC37@ha
	la 10,.LC36@l(10)
	la 11,.LC37@l(11)
	lfs 2,0(10)
	lfs 3,0(11)
	bl tv
	lis 9,.LC36@ha
	lis 10,.LC36@ha
	lfs 0,0(3)
	la 9,.LC36@l(9)
	lis 11,.LC37@ha
	lfs 1,0(9)
	la 10,.LC36@l(10)
	la 11,.LC37@l(11)
	lfs 2,0(10)
	lwz 9,plat_ent@l(29)
	lfs 3,0(11)
	stfs 0,188(9)
	bl tv
	lis 9,.LC36@ha
	lis 10,.LC36@ha
	lfs 0,4(3)
	la 9,.LC36@l(9)
	lis 11,.LC37@ha
	lfs 1,0(9)
	la 10,.LC36@l(10)
	la 11,.LC37@l(11)
	lfs 2,0(10)
	lwz 9,plat_ent@l(29)
	lfs 3,0(11)
	stfs 0,192(9)
	bl tv
	lis 9,.LC38@ha
	lis 10,.LC38@ha
	lfs 0,8(3)
	la 9,.LC38@l(9)
	lis 11,.LC35@ha
	lfs 1,0(9)
	la 10,.LC38@l(10)
	la 11,.LC35@l(11)
	lfs 2,0(10)
	lwz 9,plat_ent@l(29)
	lfs 3,0(11)
	stfs 0,196(9)
	bl tv
	lis 9,.LC38@ha
	lis 10,.LC38@ha
	lfs 0,0(3)
	la 9,.LC38@l(9)
	lis 11,.LC35@ha
	lfs 1,0(9)
	la 10,.LC38@l(10)
	la 11,.LC35@l(11)
	lfs 2,0(10)
	lwz 9,plat_ent@l(29)
	lfs 3,0(11)
	stfs 0,200(9)
	bl tv
	lis 9,.LC38@ha
	lis 10,.LC38@ha
	lfs 0,4(3)
	la 9,.LC38@l(9)
	lis 11,.LC35@ha
	la 11,.LC35@l(11)
	lfs 1,0(9)
	la 10,.LC38@l(10)
	lwz 9,plat_ent@l(29)
	lfs 3,0(11)
	lfs 2,0(10)
	stfs 0,204(9)
	bl tv
	lfs 0,8(3)
	la 9,VEC_ORIGIN@l(30)
	lwz 11,plat_ent@l(29)
	stfs 0,208(11)
	lfs 13,VEC_ORIGIN@l(30)
	stfs 13,376(11)
	lfs 0,4(9)
	stfs 0,380(11)
	lfs 13,8(9)
	stfs 13,384(11)
	lwz 9,416(31)
	lfs 0,4(9)
	stfs 0,4(11)
	lwz 9,416(31)
	lfs 0,8(9)
	stfs 0,8(11)
	lwz 9,416(31)
	lfs 0,12(9)
	stfs 0,12(11)
	lfs 13,4(31)
	lfs 0,8(31)
	lfs 12,12(31)
	lwz 9,416(31)
	stfs 13,940(31)
	stfs 0,944(31)
	stfs 12,948(31)
	lwz 0,264(9)
	ori 0,0,1024
	stw 0,264(9)
.L101:
	lwz 0,264(31)
	andi. 9,0,1024
	bc 4,2,.L104
	lwz 5,700(31)
	cmpwi 0,5,0
	bc 12,2,.L105
	lis 9,gi+16@ha
	lis 10,.LC39@ha
	lwz 0,gi+16@l(9)
	lis 11,.LC40@ha
	la 10,.LC39@l(10)
	lis 9,.LC33@ha
	la 11,.LC40@l(11)
	lfs 1,0(10)
	la 9,.LC33@l(9)
	mr 3,31
	lfs 2,0(11)
	mtlr 0
	li 4,10
	lfs 3,0(9)
	blrl
.L105:
	lwz 0,704(31)
	stw 0,76(31)
.L104:
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
	bc 4,2,.L106
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L106
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 10,0,1024
	bc 12,2,.L107
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L108
	b .L109
.L107:
	cmpw 0,9,31
	bc 4,2,.L109
.L108:
	mr 3,31
	bl Move_Begin
	b .L112
.L109:
	lis 11,level+4@ha
	lis 10,.LC32@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC32@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L113
.L106:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC32@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC32@l(11)
.L113:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L112:
	lwz 0,148(1)
	mtlr 0
	lmw 29,132(1)
	la 1,144(1)
	blr
.Lfe7:
	.size	 plat_go_up,.Lfe7-plat_go_up
	.section	".rodata"
	.align 2
.LC41:
	.long 0x41000000
	.align 3
.LC42:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC43:
	.long 0x41c80000
	.align 2
.LC44:
	.long 0x0
	.align 3
.LC45:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC46:
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
	lis 9,.LC41@ha
	mr 7,3
	la 9,.LC41@l(9)
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
	lis 11,.LC42@ha
	stw 9,444(7)
	la 11,.LC42@l(11)
	lwz 0,st+24@l(10)
	lfd 10,0(11)
	xoris 0,0,0x8000
	lfs 13,372(31)
	lis 11,.LC43@ha
	stw 0,52(1)
	la 11,.LC43@l(11)
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
	bc 12,2,.L131
	fadds 0,0,6
	stfs 0,32(1)
.L131:
	lfs 0,24(1)
	lis 11,.LC44@ha
	lfs 13,8(1)
	la 11,.LC44@l(11)
	lfs 10,0(11)
	fsubs 0,0,13
	fcmpu 0,0,10
	cror 3,2,0
	bc 4,3,.L132
	lfs 0,188(31)
	lis 9,.LC45@ha
	lis 11,.LC46@ha
	lfs 13,200(31)
	la 9,.LC45@l(9)
	la 11,.LC46@l(11)
	lfd 11,0(9)
	lfs 12,0(11)
	fadds 0,0,13
	fmul 0,0,11
	frsp 0,0
	fadds 12,0,12
	stfs 0,8(1)
	stfs 12,24(1)
.L132:
	lfs 0,28(1)
	lfs 13,12(1)
	fsubs 0,0,13
	fcmpu 0,0,10
	cror 3,2,0
	bc 4,3,.L133
	lfs 11,204(31)
	lis 9,.LC45@ha
	lis 11,.LC46@ha
	lfs 0,192(31)
	la 9,.LC45@l(9)
	la 11,.LC46@l(11)
	lfd 12,0(9)
	lfs 13,0(11)
	fadds 0,0,11
	fmul 0,0,12
	frsp 0,0
	fadds 13,0,13
	stfs 0,12(1)
	stfs 13,28(1)
.L133:
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
.LC48:
	.string	"plats/pt1_strt.wav"
	.align 2
.LC49:
	.string	"plats/pt1_mid.wav"
	.align 2
.LC50:
	.string	"plats/pt1_end.wav"
	.align 3
.LC47:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC51:
	.long 0x0
	.align 3
.LC52:
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
	lis 9,.LC51@ha
	mr 31,3
	la 9,.LC51@l(9)
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
	bc 4,2,.L135
	lis 0,0x41a0
	stw 0,328(31)
	b .L136
.L135:
	lis 9,.LC47@ha
	lfd 13,.LC47@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,328(31)
.L136:
	lis 9,.LC51@ha
	lfs 13,332(31)
	la 9,.LC51@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L137
	lis 0,0x40a0
	stw 0,332(31)
	b .L138
.L137:
	fmr 0,13
	lis 9,.LC47@ha
	lfd 13,.LC47@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,332(31)
.L138:
	lis 10,.LC51@ha
	lfs 13,336(31)
	la 10,.LC51@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,2,.L139
	lis 0,0x40a0
	stw 0,336(31)
	b .L140
.L139:
	fmr 0,13
	lis 9,.LC47@ha
	lfd 13,.LC47@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,336(31)
.L140:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L141
	li 0,2
	stw 0,516(31)
.L141:
	lis 9,st@ha
	la 9,st@l(9)
	lwz 0,24(9)
	cmpwi 0,0,0
	bc 4,2,.L142
	li 0,8
	stw 0,24(9)
.L142:
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
	bc 12,2,.L143
	xoris 0,0,0x8000
	stw 0,20(1)
	lis 11,0x4330
	lis 10,.LC52@ha
	la 10,.LC52@l(10)
	stw 11,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fsubs 0,10,0
	stfs 0,372(31)
	b .L144
.L143:
	lwz 0,24(9)
	lis 11,0x4330
	lis 10,.LC52@ha
	la 10,.LC52@l(10)
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
.L144:
	lis 9,Use_Plat@ha
	mr 3,31
	la 9,Use_Plat@l(9)
	stw 9,448(31)
	bl plat_spawn_inside_trigger
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L145
	li 0,2
	b .L147
.L145:
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
.L147:
	stw 0,732(31)
	lfs 2,16(31)
	lis 29,gi@ha
	lis 3,.LC48@ha
	lfs 3,20(31)
	la 29,gi@l(29)
	la 3,.LC48@l(3)
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
	lis 3,.LC49@ha
	la 3,.LC49@l(3)
	mtlr 9
	blrl
	stw 3,704(31)
	lwz 0,36(29)
	lis 3,.LC50@ha
	la 3,.LC50@l(3)
	mtlr 0
	blrl
	stw 3,708(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 SP_func_plat,.Lfe9-SP_func_plat
	.section	".rodata"
	.align 2
.LC53:
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
	bc 12,2,.L157
	stw 9,260(31)
	b .L158
.L157:
	li 0,2
	stw 0,260(31)
.L158:
	lwz 9,284(31)
	li 0,0
	stw 0,340(31)
	andi. 11,9,4
	stw 0,348(31)
	stw 0,344(31)
	bc 12,2,.L159
	lis 0,0x3f80
	stw 0,348(31)
	b .L160
.L159:
	andi. 0,9,8
	bc 12,2,.L161
	lis 0,0x3f80
	stw 0,340(31)
	b .L160
.L161:
	lis 0,0x3f80
	stw 0,344(31)
.L160:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L163
	lfs 0,340(31)
	lfs 13,344(31)
	lfs 12,348(31)
	fneg 0,0
	fneg 13,13
	fneg 12,12
	stfs 0,340(31)
	stfs 13,344(31)
	stfs 12,348(31)
.L163:
	lis 11,.LC53@ha
	lfs 13,328(31)
	la 11,.LC53@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L164
	lis 0,0x42c8
	stw 0,328(31)
.L164:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L165
	li 0,2
	stw 0,516(31)
.L165:
	lwz 0,516(31)
	lis 9,rotating_use@ha
	la 9,rotating_use@l(9)
	cmpwi 0,0,0
	stw 9,448(31)
	bc 12,2,.L166
	lis 9,rotating_blocked@ha
	la 9,rotating_blocked@l(9)
	stw 9,440(31)
.L166:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L167
	lwz 9,448(31)
	mr 3,31
	li 4,0
	li 5,0
	mtlr 9
	blrl
.L167:
	lwz 0,284(31)
	andi. 9,0,64
	bc 12,2,.L168
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L168:
	lwz 0,284(31)
	andi. 11,0,128
	bc 12,2,.L169
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L169:
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
.Lfe10:
	.size	 SP_func_rotating,.Lfe10-SP_func_rotating
	.section	".rodata"
	.align 3
.LC54:
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
	bc 4,2,.L172
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L172
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L173
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L174
	b .L175
.L173:
	cmpw 0,9,31
	bc 4,2,.L175
.L174:
	mr 3,31
	bl Move_Begin
	b .L178
.L175:
	lis 11,level+4@ha
	lis 10,.LC54@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC54@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L180
.L172:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC54@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC54@l(11)
.L180:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L178:
	lwz 9,480(31)
	li 0,0
	stw 0,56(31)
	cmpwi 0,9,0
	bc 12,2,.L179
	li 0,1
	stw 0,512(31)
.L179:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 button_return,.Lfe11-button_return
	.section	".rodata"
	.align 3
.LC55:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC56:
	.long 0x3f800000
	.align 2
.LC57:
	.long 0x40400000
	.align 2
.LC58:
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
	bc 4,2,.L183
	lwz 5,700(31)
	li 0,2
	stw 0,732(31)
	cmpwi 0,5,0
	bc 12,2,.L185
	lwz 0,264(31)
	andi. 9,0,1024
	bc 4,2,.L185
	lis 11,.LC56@ha
	lis 9,gi+16@ha
	la 11,.LC56@l(11)
	lwz 0,gi+16@l(9)
	lfs 1,0(11)
	lis 9,.LC57@ha
	li 4,10
	lis 11,.LC58@ha
	la 9,.LC57@l(9)
	mtlr 0
	la 11,.LC58@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L185:
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
	bc 4,2,.L186
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L186
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L187
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L188
	b .L189
.L187:
	cmpw 0,9,31
	bc 4,2,.L189
.L188:
	mr 3,31
	bl Move_Begin
	b .L183
.L189:
	lis 11,level+4@ha
	lis 10,.LC55@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC55@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L193
.L186:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC55@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC55@l(11)
.L193:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L183:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 button_fire,.Lfe12-button_fire
	.section	".rodata"
	.align 2
.LC59:
	.string	"switches/butn2.wav"
	.align 2
.LC60:
	.long 0x0
	.align 3
.LC61:
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
	bc 12,2,.L203
	lwz 0,36(30)
	lis 3,.LC59@ha
	la 3,.LC59@l(3)
	mtlr 0
	blrl
	stw 3,700(31)
.L203:
	lis 8,.LC60@ha
	lfs 0,328(31)
	la 8,.LC60@l(8)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,2,.L204
	lis 0,0x4220
	stw 0,328(31)
.L204:
	lfs 0,332(31)
	fcmpu 0,0,13
	bc 4,2,.L205
	lfs 0,328(31)
	stfs 0,332(31)
.L205:
	lfs 0,336(31)
	fcmpu 0,0,13
	bc 4,2,.L206
	lfs 0,328(31)
	stfs 0,336(31)
.L206:
	lfs 0,592(31)
	fcmpu 0,0,13
	bc 4,2,.L207
	lis 0,0x4040
	stw 0,592(31)
.L207:
	lis 9,st@ha
	la 10,st@l(9)
	lwz 0,24(10)
	cmpwi 0,0,0
	bc 4,2,.L208
	li 0,4
	stw 0,24(10)
.L208:
	lfs 12,4(31)
	lis 11,0x4330
	lfs 13,8(31)
	lis 8,.LC61@ha
	mr 4,29
	lfs 0,12(31)
	la 8,.LC61@l(8)
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
	bc 12,2,.L209
	lis 9,button_killed@ha
	li 0,1
	stw 11,484(31)
	la 9,button_killed@l(9)
	stw 0,512(31)
	stw 9,456(31)
	b .L210
.L209:
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L210
	lis 9,button_touch@ha
	la 9,button_touch@l(9)
	stw 9,444(31)
.L210:
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
.Lfe13:
	.size	 SP_func_button,.Lfe13-SP_func_button
	.section	".rodata"
	.align 2
.LC62:
	.string	"func_areaportal"
	.align 2
.LC63:
	.string	"func_door"
	.align 2
.LC65:
	.string	"func_door_rotating"
	.align 3
.LC64:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC66:
	.long 0x3f800000
	.align 2
.LC67:
	.long 0x40400000
	.align 2
.LC68:
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
	bc 4,2,.L235
	lwz 5,700(31)
	cmpwi 0,5,0
	bc 12,2,.L236
	lis 9,gi+16@ha
	lis 11,.LC67@ha
	lwz 0,gi+16@l(9)
	lis 8,.LC68@ha
	la 11,.LC67@l(11)
	lis 9,.LC66@ha
	la 8,.LC68@l(8)
	lfs 2,0(11)
	la 9,.LC66@l(9)
	lfs 3,0(8)
	mtlr 0
	li 4,10
	lfs 1,0(9)
	blrl
.L236:
	lwz 0,704(31)
	stw 0,76(31)
.L235:
	lwz 9,484(31)
	cmpwi 0,9,0
	bc 12,2,.L237
	li 0,1
	stw 9,480(31)
	stw 0,512(31)
.L237:
	li 0,3
	lwz 3,280(31)
	lis 4,.LC63@ha
	stw 0,732(31)
	la 4,.LC63@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L238
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
	bc 4,2,.L239
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L239
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 8,0,1024
	bc 12,2,.L240
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L241
	b .L242
.L240:
	cmpw 0,9,31
	bc 4,2,.L242
.L241:
	mr 3,31
	bl Move_Begin
	b .L246
.L242:
	lis 11,level+4@ha
	lis 10,.LC64@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC64@l(10)
	la 9,Move_Begin@l(9)
	b .L253
.L239:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC64@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC64@l(11)
	b .L254
.L238:
	lwz 3,280(31)
	lis 4,.LC65@ha
	la 4,.LC65@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L246
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
	bc 12,2,.L248
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L249
	b .L250
.L248:
	cmpw 0,9,31
	bc 4,2,.L250
.L249:
	mr 3,31
	bl AngleMove_Begin
	b .L246
.L250:
	lis 11,level+4@ha
	lis 10,.LC64@ha
	lfs 0,level+4@l(11)
	lis 9,AngleMove_Begin@ha
	lfd 13,.LC64@l(10)
	la 9,AngleMove_Begin@l(9)
.L253:
	stw 9,436(31)
.L254:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L246:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 door_go_down,.Lfe14-door_go_down
	.section	".rodata"
	.align 3
.LC69:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC70:
	.long 0x3fe99999
	.long 0x9999999a
	.align 2
.LC71:
	.long 0x0
	.align 2
.LC72:
	.long 0x3f800000
	.align 2
.LC73:
	.long 0x40400000
	.align 3
.LC74:
	.long 0x3ff80000
	.long 0x0
	.section	".text"
	.align 2
	.globl door_go_up
	.type	 door_go_up,@function
door_go_up:
	stwu 1,-32(1)
	mflr 0
	mfcr 12
	stmw 29,20(1)
	stw 0,36(1)
	stw 12,16(1)
	mr 31,3
	mr 30,4
	lwz 0,732(31)
	cmpwi 0,0,2
	bc 12,2,.L255
	cmpwi 0,0,0
	bc 4,2,.L257
	lis 8,.LC71@ha
	lfs 13,728(31)
	la 8,.LC71@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L255
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,13
	stfs 0,428(31)
	b .L255
.L257:
	lwz 0,264(31)
	andi. 9,0,1024
	bc 4,2,.L259
	lwz 5,700(31)
	cmpwi 0,5,0
	bc 12,2,.L260
	lis 9,gi+16@ha
	lis 11,.LC72@ha
	lwz 0,gi+16@l(9)
	lis 8,.LC73@ha
	la 11,.LC72@l(11)
	lis 9,.LC71@ha
	la 8,.LC73@l(8)
	lfs 1,0(11)
	la 9,.LC71@l(9)
	mr 3,31
	lfs 2,0(8)
	mtlr 0
	li 4,10
	lfs 3,0(9)
	blrl
.L260:
	lwz 0,704(31)
	stw 0,76(31)
.L259:
	li 0,2
	lwz 3,280(31)
	lis 4,.LC63@ha
	stw 0,732(31)
	la 4,.LC63@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L261
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
	bc 4,2,.L262
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L262
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 8,0,1024
	bc 12,2,.L263
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L264
	b .L265
.L263:
	cmpw 0,9,31
	bc 4,2,.L265
.L264:
	mr 3,31
	bl Move_Begin
	b .L269
.L265:
	lis 11,level+4@ha
	lis 10,.LC69@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC69@l(10)
	la 9,Move_Begin@l(9)
	b .L284
.L262:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC69@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC69@l(11)
	b .L285
.L261:
	lwz 3,280(31)
	lis 4,.LC65@ha
	la 4,.LC65@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L269
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
	bc 12,2,.L271
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L272
	b .L273
.L271:
	cmpw 0,9,31
	bc 4,2,.L273
.L272:
	mr 3,31
	bl AngleMove_Begin
	b .L269
.L273:
	lis 11,level+4@ha
	lis 10,.LC69@ha
	lfs 0,level+4@l(11)
	lis 9,AngleMove_Begin@ha
	lfd 13,.LC69@l(10)
	la 9,AngleMove_Begin@l(9)
.L284:
	stw 9,436(31)
.L285:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L269:
	mr 3,31
	mr 4,30
	bl G_UseTargets
	li 29,0
	cmpwi 4,30,0
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L277
	b .L278
.L280:
	lwz 3,280(29)
	lis 4,.LC62@ha
	la 4,.LC62@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L278
	lis 9,gi+64@ha
	lwz 3,644(29)
	li 4,1
	lwz 0,gi+64@l(9)
	mtlr 0
	blrl
.L278:
	lwz 5,296(31)
	mr 3,29
	li 4,300
	bl G_Find
	mr. 29,3
	bc 4,2,.L280
.L277:
	bc 12,18,.L255
	lwz 0,968(30)
	cmpwi 0,0,0
	bc 12,2,.L255
	lis 9,level@ha
	lis 11,.LC70@ha
	la 9,level@l(9)
	lfd 13,.LC70@l(11)
	lis 8,.LC74@ha
	lfs 0,4(9)
	la 8,.LC74@l(8)
	lfd 12,0(8)
	fadd 0,0,13
	frsp 0,0
	stfs 0,988(30)
	lfs 13,4(9)
	fadd 13,13,12
	frsp 13,13
	stfs 13,964(30)
.L255:
	lwz 0,36(1)
	lwz 12,16(1)
	mtlr 0
	lmw 29,20(1)
	mtcrf 8,12
	la 1,32(1)
	blr
.Lfe15:
	.size	 door_go_up,.Lfe15-door_go_up
	.section	".rodata"
	.align 2
.LC75:
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
	bc 4,2,.L335
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
	bc 12,2,.L338
	addi 30,1,24
.L340:
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
	bc 4,2,.L340
.L338:
	lis 9,.LC75@ha
	lfs 10,8(1)
	la 9,.LC75@l(9)
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
	bc 12,2,.L342
	lwz 0,296(29)
	li 31,0
	cmpwi 0,0,0
	bc 12,2,.L342
	mr 28,30
	lis 30,.LC62@ha
	b .L345
.L347:
	lwz 3,280(31)
	la 4,.LC62@l(30)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L345
	lwz 9,64(28)
	li 4,1
	lwz 3,644(31)
	mtlr 9
	blrl
.L345:
	lwz 5,296(29)
	mr 3,31
	li 4,300
	bl G_Find
	mr. 31,3
	bc 4,2,.L347
.L342:
	lwz 0,264(29)
	andi. 9,0,1024
	bc 4,2,.L335
	lwz 9,560(29)
	lfs 0,724(29)
	cmpwi 0,9,0
	lfs 12,716(29)
	fabs 13,0
	bc 12,2,.L357
.L354:
	lfs 0,724(9)
	fabs 0,0
	fcmpu 0,0,13
	bc 4,0,.L356
	fmr 13,0
.L356:
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L354
.L357:
	mr. 9,29
	fdivs 0,13,12
	bc 12,2,.L335
	fmr 9,0
.L360:
	lfs 0,724(9)
	lfs 13,716(9)
	lfs 11,712(9)
	fcmpu 0,11,13
	fabs 0,0
	fdiv 0,0,9
	frsp 12,0
	fdivs 10,12,13
	bc 4,2,.L361
	stfs 12,712(9)
	b .L362
.L361:
	fmuls 0,11,10
	stfs 0,712(9)
.L362:
	lfs 13,720(9)
	lfs 0,716(9)
	fcmpu 0,13,0
	bc 4,2,.L363
	stfs 12,720(9)
	b .L364
.L363:
	fmuls 0,13,10
	stfs 0,720(9)
.L364:
	stfs 12,716(9)
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L360
.L335:
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe16:
	.size	 Think_SpawnDoorTrigger,.Lfe16-Think_SpawnDoorTrigger
	.section	".rodata"
	.align 2
.LC76:
	.string	"%s"
	.align 2
.LC77:
	.string	"misc/talk1.wav"
	.align 2
.LC78:
	.string	"doors/dr1_strt.wav"
	.align 2
.LC79:
	.string	"doors/dr1_mid.wav"
	.align 2
.LC80:
	.string	"doors/dr1_end.wav"
	.align 2
.LC81:
	.string	"misc/talk.wav"
	.align 3
.LC82:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC83:
	.long 0x0
	.align 3
.LC84:
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
	bc 12,2,.L409
	lis 29,gi@ha
	lis 3,.LC78@ha
	la 29,gi@l(29)
	la 3,.LC78@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,700(31)
	lwz 9,36(29)
	lis 3,.LC79@ha
	la 3,.LC79@l(3)
	mtlr 9
	blrl
	stw 3,704(31)
	lwz 0,36(29)
	lis 3,.LC80@ha
	la 3,.LC80@l(3)
	mtlr 0
	blrl
	stw 3,708(31)
.L409:
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
	lis 8,.LC83@ha
	lfs 0,328(31)
	lis 9,door_blocked@ha
	la 8,.LC83@l(8)
	lis 11,door_use@ha
	lfs 13,0(8)
	la 9,door_blocked@l(9)
	la 11,door_use@l(11)
	stw 9,440(31)
	stw 11,448(31)
	fcmpu 0,0,13
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
	lis 9,st@ha
	la 10,st@l(9)
	lwz 0,24(10)
	cmpwi 0,0,0
	bc 4,2,.L414
	li 0,8
	stw 0,24(10)
.L414:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L415
	stw 30,516(31)
.L415:
	lfs 12,4(31)
	lis 11,0x4330
	lfs 13,8(31)
	lis 8,.LC84@ha
	mr 4,29
	lfs 0,12(31)
	la 8,.LC84@l(8)
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
	bc 12,2,.L416
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
.L416:
	lwz 0,480(31)
	li 11,1
	stw 11,732(31)
	cmpwi 0,0,0
	bc 12,2,.L417
	lis 9,door_killed@ha
	stw 11,512(31)
	la 9,door_killed@l(9)
	stw 0,484(31)
	stw 9,456(31)
	b .L418
.L417:
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L418
	lwz 0,276(31)
	cmpwi 0,0,0
	bc 12,2,.L418
	lwz 0,36(28)
	lis 3,.LC81@ha
	la 3,.LC81@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,444(31)
.L418:
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
	bc 12,2,.L420
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L420:
	lwz 0,284(31)
	andi. 9,0,64
	bc 12,2,.L421
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L421:
	lwz 0,308(31)
	cmpwi 0,0,0
	bc 4,2,.L422
	stw 31,564(31)
.L422:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC82@ha
	lwz 0,480(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC82@l(11)
	cmpwi 0,0,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 4,2,.L424
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L423
.L424:
	lis 9,Think_CalcMoveSpeed@ha
	la 9,Think_CalcMoveSpeed@l(9)
	b .L426
.L423:
	lis 9,Think_SpawnDoorTrigger@ha
	la 9,Think_SpawnDoorTrigger@l(9)
.L426:
	stw 9,436(31)
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 SP_func_door,.Lfe17-SP_func_door
	.section	".rodata"
	.align 2
.LC85:
	.string	"%s at %s with no distance set\n"
	.align 3
.LC86:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC87:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC88:
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
	bc 12,2,.L428
	lis 0,0x3f80
	stw 0,348(31)
	b .L429
.L428:
	andi. 0,9,128
	bc 12,2,.L430
	lis 0,0x3f80
	stw 0,340(31)
	b .L429
.L430:
	lis 0,0x3f80
	stw 0,344(31)
.L429:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L432
	lfs 0,340(31)
	lfs 13,344(31)
	lfs 12,348(31)
	fneg 0,0
	fneg 13,13
	fneg 12,12
	stfs 0,340(31)
	stfs 13,344(31)
	stfs 12,348(31)
.L432:
	lis 9,st@ha
	la 30,st@l(9)
	lwz 0,28(30)
	cmpwi 0,0,0
	bc 4,2,.L433
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC85@ha
	mtlr 0
	la 3,.LC85@l(3)
	crxor 6,6,6
	blrl
	li 0,90
	stw 0,28(30)
.L433:
	lfs 13,20(31)
	lis 29,0x4330
	lfs 12,16(31)
	lis 11,.LC87@ha
	addi 3,31,16
	lfs 0,24(31)
	la 11,.LC87@l(11)
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
	lis 9,.LC88@ha
	lfs 0,328(31)
	lis 11,door_use@ha
	la 9,.LC88@l(9)
	la 11,door_use@l(11)
	lfs 13,0(9)
	lis 9,door_blocked@ha
	stw 11,448(31)
	la 9,door_blocked@l(9)
	fcmpu 0,0,13
	stw 9,440(31)
	bc 4,2,.L434
	lis 0,0x42c8
	stw 0,328(31)
.L434:
	lfs 0,332(31)
	fcmpu 0,0,13
	bc 4,2,.L435
	lfs 0,328(31)
	stfs 0,332(31)
.L435:
	lfs 0,336(31)
	fcmpu 0,0,13
	bc 4,2,.L436
	lfs 0,328(31)
	stfs 0,336(31)
.L436:
	lfs 0,592(31)
	fcmpu 0,0,13
	bc 4,2,.L437
	lis 0,0x4040
	stw 0,592(31)
.L437:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L438
	stw 28,516(31)
.L438:
	lwz 0,528(31)
	cmpwi 0,0,1
	bc 12,2,.L439
	lwz 9,36(30)
	lis 3,.LC78@ha
	la 3,.LC78@l(3)
	mtlr 9
	blrl
	stw 3,700(31)
	lwz 9,36(30)
	lis 3,.LC79@ha
	la 3,.LC79@l(3)
	mtlr 9
	blrl
	stw 3,704(31)
	lwz 9,36(30)
	lis 3,.LC80@ha
	la 3,.LC80@l(3)
	mtlr 9
	blrl
	stw 3,708(31)
.L439:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L440
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
.L440:
	lwz 11,480(31)
	cmpwi 0,11,0
	bc 12,2,.L441
	lis 9,door_killed@ha
	li 0,1
	stw 11,484(31)
	la 9,door_killed@l(9)
	stw 0,512(31)
	stw 9,456(31)
.L441:
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L442
	lwz 0,276(31)
	cmpwi 0,0,0
	bc 12,2,.L442
	lwz 0,36(30)
	lis 3,.LC81@ha
	la 3,.LC81@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,444(31)
.L442:
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
	bc 12,2,.L443
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L443:
	lwz 0,308(31)
	cmpwi 0,0,0
	bc 4,2,.L444
	stw 31,564(31)
.L444:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC86@ha
	lwz 0,480(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC86@l(11)
	cmpwi 0,0,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 4,2,.L446
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L445
.L446:
	lis 9,Think_CalcMoveSpeed@ha
	la 9,Think_CalcMoveSpeed@l(9)
	b .L448
.L445:
	lis 9,Think_SpawnDoorTrigger@ha
	la 9,Think_SpawnDoorTrigger@l(9)
.L448:
	stw 9,436(31)
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe18:
	.size	 SP_func_door_rotating,.Lfe18-SP_func_door_rotating
	.section	".rodata"
	.align 2
.LC89:
	.string	"world/mov_watr.wav"
	.align 2
.LC90:
	.string	"world/stp_watr.wav"
	.align 3
.LC91:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC92:
	.long 0x0
	.align 2
.LC93:
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
	bc 12,2,.L452
	cmpwi 0,0,2
	bc 4,2,.L450
.L452:
	lwz 9,36(30)
	lis 3,.LC89@ha
	la 3,.LC89@l(3)
	mtlr 9
	blrl
	stw 3,700(31)
	lwz 0,36(30)
	lis 3,.LC90@ha
	la 3,.LC90@l(3)
	mtlr 0
	blrl
	stw 3,708(31)
.L450:
	lfs 12,4(31)
	lis 11,st+24@ha
	lfs 13,8(31)
	lis 10,0x4330
	lis 8,.LC91@ha
	lfs 0,12(31)
	la 8,.LC91@l(8)
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
	bc 12,2,.L455
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
.L455:
	lis 9,.LC92@ha
	lfs 0,328(31)
	li 0,1
	la 9,.LC92@l(9)
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
	bc 4,2,.L456
	lis 0,0x41c8
	stw 0,328(31)
.L456:
	lfs 13,592(31)
	lfs 0,328(31)
	fcmpu 0,13,5
	stfs 0,712(31)
	stfs 0,716(31)
	stfs 0,720(31)
	bc 4,2,.L457
	lis 0,0xbf80
	stw 0,592(31)
.L457:
	lis 8,.LC93@ha
	lfs 13,592(31)
	lis 9,door_use@ha
	la 8,.LC93@l(8)
	la 9,door_use@l(9)
	lfs 0,0(8)
	stw 9,448(31)
	stfs 13,728(31)
	fcmpu 0,13,0
	bc 4,2,.L458
	lwz 0,284(31)
	ori 0,0,32
	stw 0,284(31)
.L458:
	lis 9,.LC63@ha
	lis 11,gi+72@ha
	la 9,.LC63@l(9)
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
.Lfe19:
	.size	 SP_func_water,.Lfe19-SP_func_water
	.section	".rodata"
	.align 2
.LC94:
	.long 0x0
	.align 2
.LC95:
	.long 0x3f800000
	.align 2
.LC96:
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
	bc 12,2,.L465
	lwz 29,296(30)
	mr 3,30
	stw 0,296(30)
	lwz 4,548(31)
	bl G_UseTargets
	stw 29,296(30)
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L464
.L465:
	lis 9,.LC94@ha
	lfs 13,728(31)
	la 9,.LC94@l(9)
	lfs 31,0(9)
	fcmpu 0,13,31
	bc 12,2,.L467
	bc 4,1,.L468
	lis 9,level+4@ha
	lis 11,train_next@ha
	lfs 0,level+4@l(9)
	la 11,train_next@l(11)
	stw 11,436(31)
	fadds 0,0,13
	stfs 0,428(31)
	b .L469
.L468:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L469
	mr 3,31
	bl train_next
	lwz 0,284(31)
	stfs 31,428(31)
	rlwinm 0,0,0,0,30
	stfs 31,384(31)
	stw 0,284(31)
	stfs 31,380(31)
	stfs 31,376(31)
.L469:
	lwz 0,264(31)
	andi. 30,0,1024
	bc 4,2,.L464
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L472
	lis 9,gi+16@ha
	mr 3,31
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC95@ha
	la 9,.LC95@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC96@ha
	la 9,.LC96@l(9)
	lfs 2,0(9)
	lis 9,.LC94@ha
	la 9,.LC94@l(9)
	lfs 3,0(9)
	blrl
.L472:
	stw 30,76(31)
	b .L464
.L467:
	mr 3,31
	bl train_next
.L464:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 train_wait,.Lfe20-train_wait
	.section	".rodata"
	.align 2
.LC97:
	.string	"train_next: bad target %s\n"
	.align 2
.LC98:
	.string	"connected teleport path_corners, see %s at %s\n"
	.align 3
.LC99:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC100:
	.long 0x3f800000
	.align 2
.LC101:
	.long 0x40400000
	.align 2
.LC102:
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
.L475:
	lwz 3,296(28)
	cmpwi 0,3,0
	bc 12,2,.L474
	bl G_PickTarget
	mr. 31,3
	bc 4,2,.L477
	lis 9,gi+4@ha
	lis 3,.LC97@ha
	lwz 4,296(28)
	lwz 0,gi+4@l(9)
	la 3,.LC97@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L474
.L477:
	lwz 0,296(31)
	stw 0,296(28)
	lwz 9,284(31)
	andi. 0,9,1
	bc 12,2,.L478
	cmpwi 0,29,0
	bc 4,2,.L479
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC98@ha
	la 3,.LC98@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L474
.L479:
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
	b .L475
.L478:
	lwz 0,264(28)
	lfs 0,592(31)
	andi. 9,0,1024
	stw 31,324(28)
	stfs 0,728(28)
	bc 4,2,.L480
	lwz 5,700(28)
	cmpwi 0,5,0
	bc 12,2,.L481
	lis 11,.LC100@ha
	lis 9,gi+16@ha
	la 11,.LC100@l(11)
	lwz 0,gi+16@l(9)
	mr 3,28
	lfs 1,0(11)
	lis 9,.LC101@ha
	li 4,10
	lis 11,.LC102@ha
	la 9,.LC101@l(9)
	mtlr 0
	la 11,.LC102@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L481:
	lwz 0,704(28)
	stw 0,76(28)
.L480:
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
	bc 4,2,.L482
	lfs 0,720(28)
	fcmpu 0,13,0
	bc 4,2,.L482
	lwz 0,264(28)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L483
	lwz 0,564(28)
	cmpw 0,9,0
	bc 12,2,.L484
	b .L485
.L483:
	cmpw 0,9,28
	bc 4,2,.L485
.L484:
	mr 3,28
	bl Move_Begin
	b .L488
.L485:
	lis 11,level+4@ha
	lis 10,.LC99@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC99@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(28)
	b .L489
.L482:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(28)
	lis 10,level+4@ha
	stw 9,436(28)
	lis 11,.LC99@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC99@l(11)
.L489:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(28)
.L488:
	lwz 0,284(28)
	ori 0,0,1
	stw 0,284(28)
.L474:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe21:
	.size	 train_next,.Lfe21-train_next
	.section	".rodata"
	.align 3
.LC103:
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
	bc 4,2,.L491
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L491
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L492
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L493
	b .L494
.L492:
	cmpw 0,9,31
	bc 4,2,.L494
.L493:
	mr 3,31
	bl Move_Begin
	b .L497
.L494:
	lis 11,level+4@ha
	lis 10,.LC103@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC103@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L498
.L491:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC103@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC103@l(11)
.L498:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L497:
	lwz 0,284(31)
	ori 0,0,1
	stw 0,284(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe22:
	.size	 train_resume,.Lfe22-train_resume
	.section	".rodata"
	.align 2
.LC104:
	.string	"train_find: no target\n"
	.align 2
.LC105:
	.string	"train_find: target %s not found\n"
	.align 2
.LC108:
	.string	"func_train without a target at %s\n"
	.align 3
.LC107:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC109:
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
	bc 4,2,.L518
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L512
	li 0,100
.L518:
	stw 0,516(31)
.L512:
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
	bc 12,2,.L514
	lwz 9,36(30)
	mtlr 9
	blrl
	stw 3,704(31)
.L514:
	lis 8,.LC109@ha
	lfs 13,328(31)
	la 8,.LC109@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,2,.L515
	lis 0,0x42c8
	stw 0,328(31)
.L515:
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
	bc 12,2,.L516
	lis 11,level+4@ha
	lis 10,.LC107@ha
	lfs 0,level+4@l(11)
	lis 9,func_train_find@ha
	lfd 13,.LC107@l(10)
	la 9,func_train_find@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	b .L517
.L516:
	addi 3,31,212
	bl vtos
	mr 4,3
	lwz 0,4(30)
	lis 3,.LC108@ha
	la 3,.LC108@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L517:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe23:
	.size	 SP_func_train,.Lfe23-SP_func_train
	.section	".rodata"
	.align 2
.LC110:
	.string	"elevator used with no pathtarget\n"
	.align 2
.LC111:
	.string	"elevator used with bad pathtarget: %s\n"
	.align 2
.LC112:
	.string	"trigger_elevator has no target\n"
	.align 2
.LC113:
	.string	"trigger_elevator unable to find target %s\n"
	.align 2
.LC114:
	.string	"func_train"
	.align 2
.LC115:
	.string	"trigger_elevator target %s is not a train\n"
	.align 2
.LC120:
	.string	"func_timer at %s has random >= wait\n"
	.align 3
.LC119:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC121:
	.long 0x46fffe00
	.align 2
.LC122:
	.long 0x0
	.align 3
.LC123:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC124:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC125:
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
	lis 9,.LC122@ha
	mr 31,3
	la 9,.LC122@l(9)
	lfs 0,592(31)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L535
	lis 0,0x3f80
	stw 0,592(31)
.L535:
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
	bc 4,3,.L536
	fmr 0,13
	lis 9,.LC119@ha
	lis 29,gi@ha
	lfd 13,.LC119@l(9)
	la 29,gi@l(29)
	addi 3,31,4
	fsub 0,0,13
	frsp 0,0
	stfs 0,600(31)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC120@ha
	la 3,.LC120@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L536:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L537
	bl rand
	rlwinm 3,3,0,17,31
	lfs 8,596(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	lfs 9,592(31)
	stw 3,28(1)
	lis 11,.LC123@ha
	lis 8,.LC121@ha
	la 11,.LC123@l(11)
	stw 0,24(1)
	lis 10,st+40@ha
	lfd 10,0(11)
	lfd 12,24(1)
	lis 11,level+4@ha
	lfs 6,.LC121@l(8)
	lis 9,.LC124@ha
	lfs 13,level+4@l(11)
	la 9,.LC124@l(9)
	fsub 12,12,10
	lfd 0,0(9)
	lfs 11,st+40@l(10)
	lis 9,.LC125@ha
	la 9,.LC125@l(9)
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
.L537:
	li 0,1
	stw 0,184(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe24:
	.size	 SP_func_timer,.Lfe24-SP_func_timer
	.section	".rodata"
	.align 3
.LC126:
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
	bc 12,2,.L545
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
	bc 4,2,.L547
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L547
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L548
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L549
	b .L550
.L548:
	cmpw 0,9,31
	bc 4,2,.L550
.L549:
	mr 3,31
	bl Move_Begin
	b .L553
.L550:
	lis 11,level+4@ha
	lis 10,.LC126@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC126@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L561
.L547:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC126@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC126@l(11)
.L561:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L553:
	lwz 0,296(31)
	li 29,0
	cmpwi 0,0,0
	bc 12,2,.L545
	lis 9,gi@ha
	lis 28,.LC62@ha
	la 30,gi@l(9)
	b .L556
.L558:
	lwz 3,280(29)
	la 4,.LC62@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L556
	lwz 9,64(30)
	li 4,1
	lwz 3,644(29)
	mtlr 9
	blrl
.L556:
	lwz 5,296(31)
	mr 3,29
	li 4,300
	bl G_Find
	mr. 29,3
	bc 4,2,.L558
.L545:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 door_secret_use,.Lfe25-door_secret_use
	.section	".rodata"
	.align 3
.LC127:
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
	bc 4,2,.L564
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L564
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L565
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L566
	b .L567
.L565:
	cmpw 0,9,31
	bc 4,2,.L567
.L566:
	mr 3,31
	bl Move_Begin
	b .L570
.L567:
	lis 11,level+4@ha
	lis 10,.LC127@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC127@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L571
.L564:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC127@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC127@l(11)
.L571:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L570:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 door_secret_move2,.Lfe26-door_secret_move2
	.section	".rodata"
	.align 3
.LC128:
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
	bc 4,2,.L575
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L575
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L576
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L577
	b .L578
.L576:
	cmpw 0,9,31
	bc 4,2,.L578
.L577:
	mr 3,31
	bl Move_Begin
	b .L581
.L578:
	lis 11,level+4@ha
	lis 10,.LC128@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC128@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L582
.L575:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC128@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC128@l(11)
.L582:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L581:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 door_secret_move4,.Lfe27-door_secret_move4
	.section	".rodata"
	.align 3
.LC129:
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
	bc 4,2,.L585
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L585
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L586
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L587
	b .L588
.L586:
	cmpw 0,9,31
	bc 4,2,.L588
.L587:
	mr 3,31
	bl Move_Begin
	b .L591
.L588:
	lis 11,level+4@ha
	lis 10,.LC129@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC129@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L592
.L585:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC129@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC129@l(11)
.L592:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L591:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe28:
	.size	 door_secret_move6,.Lfe28-door_secret_move6
	.section	".rodata"
	.align 2
.LC130:
	.long 0x0
	.align 3
.LC131:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC132:
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
	lis 3,.LC78@ha
	lwz 9,36(29)
	la 3,.LC78@l(3)
	mtlr 9
	blrl
	stw 3,700(31)
	lwz 9,36(29)
	lis 3,.LC79@ha
	la 3,.LC79@l(3)
	mtlr 9
	blrl
	stw 3,704(31)
	lwz 9,36(29)
	lis 3,.LC80@ha
	la 3,.LC80@l(3)
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
	bc 12,2,.L610
	lwz 0,284(31)
	andi. 7,0,1
	bc 12,2,.L609
.L610:
	lis 9,door_secret_die@ha
	li 11,0
	la 9,door_secret_die@l(9)
	li 0,1
	stw 11,480(31)
	stw 0,512(31)
	stw 9,456(31)
.L609:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L611
	li 0,2
	stw 0,516(31)
.L611:
	lis 9,.LC130@ha
	lfs 0,592(31)
	la 9,.LC130@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L612
	lis 0,0x40a0
	stw 0,592(31)
.L612:
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
	lis 7,.LC131@ha
	mr 8,29
	stfs 31,16(31)
	rlwinm 0,11,0,30,30
	la 7,.LC131@l(7)
	stfs 31,24(31)
	xoris 0,0,0x8000
	lfd 12,0(7)
	mr 4,28
	stw 0,68(1)
	lis 7,.LC132@ha
	stw 10,64(1)
	la 7,.LC132@l(7)
	andi. 0,11,4
	lfd 0,64(1)
	lfd 13,0(7)
	stfs 31,20(31)
	fsub 0,0,12
	fsub 13,13,0
	frsp 7,13
	bc 12,2,.L613
	lfs 0,240(31)
	lfs 12,44(1)
	lfs 10,236(31)
	lfs 13,40(1)
	fmr 8,0
	fmuls 12,12,0
	lfs 11,244(31)
	lfs 0,48(1)
	b .L620
.L613:
	lfs 0,240(31)
	lfs 12,28(1)
	lfs 10,236(31)
	lfs 13,24(1)
	fmr 8,0
	fmuls 12,12,0
	lfs 11,244(31)
	lfs 0,32(1)
.L620:
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
	bc 12,2,.L615
	fneg 1,1
	addi 29,31,352
	addi 3,31,4
	b .L621
.L615:
	fmuls 1,7,1
	addi 29,31,352
	addi 3,31,4
	mr 4,8
.L621:
	mr 5,29
	bl VectorMA
	mr 3,29
	fmr 1,31
	addi 4,1,8
	addi 5,31,364
	bl VectorMA
	lwz 11,480(31)
	cmpwi 0,11,0
	bc 12,2,.L617
	lis 9,door_killed@ha
	li 0,1
	stw 11,484(31)
	la 9,door_killed@l(9)
	stw 0,512(31)
	stw 9,456(31)
	b .L618
.L617:
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L618
	lwz 0,276(31)
	cmpwi 0,0,0
	bc 12,2,.L618
	lis 9,gi+36@ha
	lis 3,.LC81@ha
	lwz 0,gi+36@l(9)
	la 3,.LC81@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,444(31)
.L618:
	lis 9,.LC63@ha
	lis 11,gi+72@ha
	la 9,.LC63@l(9)
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
.Lfe29:
	.size	 SP_func_door_secret,.Lfe29-SP_func_door_secret
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.comm	last_trail_time,4,4
	.comm	bot_frametime,8,8
	.comm	max_bots,4,4
	.comm	last_bot_spawn,4,4
	.comm	bot_male_names_used,4,4
	.comm	bot_female_names_used,4,4
	.comm	bot_count,4,4
	.comm	bot_teams,256,4
	.comm	total_teams,4,4
	.comm	the_client,4,4
	.comm	num_players,4,4
	.comm	players,1024,4
	.comm	weapons_head,4,4
	.comm	health_head,4,4
	.comm	bonus_head,4,4
	.comm	ammo_head,4,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_supershotgun,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	botinfo_list,4,4
	.comm	total_bots,4,4
	.comm	teambot_list,4,4
	.comm	paused,4,4
	.comm	PathToEnt_Node,4,4
	.comm	PathToEnt_TargetNode,4,4
	.comm	trail_head,4,4
	.comm	last_head,4,4
	.comm	dropped_trail,4,4
	.comm	last_optimize,4,4
	.comm	optimize_marker,4,4
	.comm	trail_portals,490000,4
	.comm	num_trail_portals,2500,4
	.comm	ctf_item_head,4,4
	.comm	spawn_bots,4,4
	.comm	roam_calls_this_frame,4,4
	.comm	bestdirection_callsthisframe,4,4
	.comm	bot_chat_text,2048,4
	.comm	bot_chat_count,32,4
	.comm	last_bot_chat,32,4
	.comm	num_view_weapons,4,4
	.comm	view_weapon_models,4096,1
	.comm	botdebug,4,4
	.align 2
	.globl Use_Plat
	.type	 Use_Plat,@function
Use_Plat:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,436(3)
	cmpwi 0,0,0
	bc 4,2,.L120
	bl plat_go_down
.L120:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 Use_Plat,.Lfe30-Use_Plat
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
.Lfe31:
	.size	 Move_Done,.Lfe31-Move_Done
	.section	".rodata"
	.align 3
.LC133:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC134:
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
	lis 9,.LC134@ha
	mr 31,3
	la 9,.LC134@l(9)
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
	lis 9,.LC133@ha
	addi 3,31,736
	lfd 31,.LC133@l(9)
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
.Lfe32:
	.size	 Move_Final,.Lfe32-Move_Final
	.section	".rodata"
	.align 3
.LC135:
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
	lis 10,.LC135@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC135@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L624
.L16:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC135@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC135@l(11)
.L624:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L21:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe33:
	.size	 Move_Calc,.Lfe33-Move_Calc
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
.Lfe34:
	.size	 AngleMove_Done,.Lfe34-AngleMove_Done
	.section	".rodata"
	.align 3
.LC136:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC137:
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
	b .L625
.L24:
	lfs 11,16(31)
	lfs 13,664(31)
	lfs 12,668(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,672(31)
.L625:
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
	lis 9,.LC137@ha
	addi 3,1,8
	la 9,.LC137@l(9)
	addi 4,31,388
	lfs 1,0(9)
	bl VectorScale
	lis 9,AngleMove_Done@ha
	lis 10,level+4@ha
	la 9,AngleMove_Done@l(9)
	lis 11,.LC136@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC136@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L23:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 AngleMove_Final,.Lfe35-AngleMove_Final
	.section	".rodata"
	.align 3
.LC138:
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
	lis 10,.LC138@ha
	lfs 0,level+4@l(11)
	lis 9,AngleMove_Begin@ha
	lfd 13,.LC138@l(10)
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
.Lfe36:
	.size	 AngleMove_Calc,.Lfe36-AngleMove_Calc
	.section	".rodata"
	.align 2
.LC139:
	.long 0x3f000000
	.align 2
.LC140:
	.long 0x0
	.align 2
.LC141:
	.long 0x3f800000
	.align 2
.LC142:
	.long 0x40800000
	.align 2
.LC143:
	.long 0xc0000000
	.align 3
.LC144:
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
	lis 9,.LC139@ha
	la 9,.LC139@l(9)
	lfs 30,0(9)
	lis 9,.LC140@ha
	la 9,.LC140@l(9)
	lfs 12,0(9)
	lis 9,.LC141@ha
	la 9,.LC141@l(9)
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
	lis 9,.LC142@ha
	fadds 31,10,31
	la 9,.LC142@l(9)
	lfs 1,0(9)
	lis 9,.LC143@ha
	fdivs 31,31,12
	la 9,.LC143@l(9)
	lfs 13,0(9)
	fmuls 0,31,1
	fmuls 13,9,13
	fmuls 0,0,13
	fsubs 1,1,0
	bl sqrt
	lis 9,.LC144@ha
	fadds 31,31,31
	lfs 13,68(31)
	la 9,.LC144@l(9)
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
.Lfe37:
	.size	 plat_CalcAcceleratedMove,.Lfe37-plat_CalcAcceleratedMove
	.comm	start_trail,4,4
	.section	".rodata"
	.align 2
.LC145:
	.long 0x3f800000
	.align 2
.LC146:
	.long 0x40400000
	.align 2
.LC147:
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
	bc 4,2,.L85
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L86
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC145@ha
	la 9,.LC145@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC146@ha
	la 9,.LC146@l(9)
	lfs 2,0(9)
	lis 9,.LC147@ha
	la 9,.LC147@l(9)
	lfs 3,0(9)
	blrl
.L86:
	stw 30,76(31)
.L85:
	li 0,1
	stw 0,732(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe38:
	.size	 plat_hit_bottom,.Lfe38-plat_hit_bottom
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
	bc 4,2,.L115
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L115
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
	bc 12,2,.L114
	mr 3,31
	bl BecomeExplosion1
	b .L114
.L115:
	lwz 10,968(31)
	lis 6,vec3_origin@ha
	li 0,0
	lwz 9,516(30)
	mr 3,31
	la 6,vec3_origin@l(6)
	mulli 10,10,60
	li 11,20
	stw 0,8(1)
	mr 4,30
	stw 11,12(1)
	mr 5,30
	addi 7,3,4
	ori 10,10,1
	mr 8,6
	bl T_Damage
	lwz 0,732(30)
	cmpwi 0,0,2
	bc 4,2,.L117
	mr 3,30
	bl plat_go_down
	b .L114
.L117:
	cmpwi 0,0,3
	bc 4,2,.L114
	mr 3,30
	bl plat_go_up
.L114:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe39:
	.size	 plat_blocked,.Lfe39-plat_blocked
	.section	".rodata"
	.align 2
.LC148:
	.long 0x42400000
	.align 2
.LC149:
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
	bc 12,2,.L122
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L122
	lwz 0,968(4)
	cmpwi 0,0,0
	bc 12,2,.L125
	lwz 9,412(4)
	cmpwi 0,9,0
	bc 12,2,.L122
	lfs 0,12(9)
	lis 9,.LC148@ha
	lfs 12,12(4)
	la 9,.LC148@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L122
.L125:
	lwz 3,540(3)
	lwz 0,732(3)
	stw 4,416(3)
	cmpwi 0,0,1
	bc 4,2,.L127
	bl plat_go_up
	b .L122
.L127:
	cmpwi 0,0,0
	bc 4,2,.L122
	lis 11,.LC149@ha
	lis 9,level+4@ha
	la 11,.LC149@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,428(3)
.L122:
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
.LC150:
	.long 0x0
	.section	".text"
	.align 2
	.globl rotating_touch
	.type	 rotating_touch,@function
rotating_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC150@ha
	mr 11,3
	la 9,.LC150@l(9)
	lfs 0,388(11)
	mr 3,4
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L151
	lfs 0,392(11)
	fcmpu 0,0,13
	bc 4,2,.L151
	lfs 0,396(11)
	fcmpu 0,0,13
	bc 12,2,.L150
.L151:
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
.L150:
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
	bc 4,2,.L153
	li 0,0
	stw 3,444(31)
	stw 0,388(31)
	stw 3,76(31)
	stw 0,396(31)
	stw 0,392(31)
	b .L154
.L153:
	lwz 0,704(31)
	mr 4,30
	addi 3,31,340
	lfs 1,328(31)
	stw 0,76(31)
	bl VectorScale
	lwz 0,284(31)
	andi. 9,0,16
	bc 12,2,.L154
	lis 9,rotating_touch@ha
	la 9,rotating_touch@l(9)
	stw 9,444(31)
.L154:
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
.LC151:
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
	lis 9,.LC151@ha
	lfs 13,728(31)
	li 0,1
	la 9,.LC151@l(9)
	stw 0,56(31)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L182
	lis 9,level+4@ha
	lis 11,button_return@ha
	lfs 0,level+4@l(9)
	la 11,button_return@l(11)
	stw 11,436(31)
	fadds 0,0,13
	stfs 0,428(31)
.L182:
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
	.section	".rodata"
	.align 2
.LC152:
	.long 0x41000000
	.section	".text"
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
	bc 12,2,.L195
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L195
	lwz 0,1300(30)
	cmpwi 0,0,0
	bc 12,1,.L198
	li 0,1
	mr 3,31
	stw 0,1300(30)
	addi 4,31,4
	li 5,0
	li 6,0
	li 7,1
	li 8,3
	bl PlayerTrail_Add
	b .L199
.L198:
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L199
	li 0,0
	lis 11,.LC152@ha
	lis 9,level+4@ha
	stw 0,548(31)
	la 11,.LC152@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,1172(31)
.L199:
	stw 31,548(30)
	mr 3,30
	bl button_fire
.L195:
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
	bc 12,2,.L212
	lis 9,gi@ha
	lis 27,.LC62@ha
	la 28,gi@l(9)
	b .L214
.L216:
	lwz 3,280(31)
	la 4,.LC62@l(27)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L214
	lwz 9,64(28)
	mr 4,29
	lwz 3,644(31)
	mtlr 9
	blrl
.L214:
	lwz 5,296(30)
	mr 3,31
	li 4,300
	bl G_Find
	mr. 31,3
	bc 4,2,.L216
.L212:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe49:
	.size	 door_use_areaportals,.Lfe49-door_use_areaportals
	.section	".rodata"
	.align 2
.LC153:
	.long 0x3f800000
	.align 2
.LC154:
	.long 0x40400000
	.align 2
.LC155:
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
	bc 4,2,.L220
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L221
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC153@ha
	la 9,.LC153@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC154@ha
	la 9,.LC154@l(9)
	lfs 2,0(9)
	lis 9,.LC155@ha
	la 9,.LC155@l(9)
	lfs 3,0(9)
	blrl
.L221:
	stw 30,76(31)
.L220:
	li 0,0
	lwz 9,284(31)
	stw 0,732(31)
	andi. 0,9,32
	bc 4,2,.L219
	lis 9,.LC155@ha
	lfs 13,728(31)
	la 9,.LC155@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L219
	lis 9,door_go_down@ha
	lis 11,level+4@ha
	la 9,door_go_down@l(9)
	stw 9,436(31)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	stfs 0,428(31)
.L219:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe50:
	.size	 door_hit_top,.Lfe50-door_hit_top
	.section	".rodata"
	.align 2
.LC156:
	.long 0x3f800000
	.align 2
.LC157:
	.long 0x40400000
	.align 2
.LC158:
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
	bc 4,2,.L225
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L226
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC156@ha
	la 9,.LC156@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC157@ha
	la 9,.LC157@l(9)
	lfs 2,0(9)
	lis 9,.LC158@ha
	la 9,.LC158@l(9)
	lfs 3,0(9)
	blrl
.L226:
	stw 30,76(31)
.L225:
	lwz 9,296(31)
	li 0,1
	li 30,0
	stw 0,732(31)
	cmpwi 0,9,0
	bc 12,2,.L228
	lis 9,gi@ha
	lis 28,.LC62@ha
	la 29,gi@l(9)
	b .L229
.L231:
	lwz 3,280(30)
	la 4,.LC62@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L229
	lwz 9,64(29)
	li 4,0
	lwz 3,644(30)
	mtlr 9
	blrl
.L229:
	lwz 5,296(31)
	mr 3,30
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L231
.L228:
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
	bc 4,2,.L286
	lwz 0,284(3)
	andi. 11,0,32
	bc 12,2,.L288
	lwz 0,732(3)
	subfic 11,0,0
	adde 9,11,0
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L288
	mr. 31,3
	bc 12,2,.L286
	li 30,0
.L293:
	stw 30,276(31)
	mr 3,31
	stw 30,444(31)
	bl door_go_down
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L293
	b .L286
.L288:
	mr. 31,3
	bc 12,2,.L286
	li 30,0
.L298:
	stw 30,276(31)
	mr 3,31
	mr 4,29
	stw 30,444(31)
	bl door_go_up
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L298
.L286:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe52:
	.size	 door_use,.Lfe52-door_use
	.section	".rodata"
	.align 3
.LC159:
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
	bc 4,1,.L300
	lwz 0,184(29)
	andi. 9,0,4
	bc 4,2,.L302
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L300
.L302:
	lis 9,level+4@ha
	lfs 0,460(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L300
	lis 10,.LC159@ha
	fmr 0,13
	lwz 11,256(3)
	la 10,.LC159@l(10)
	lfd 13,0(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,460(3)
	lwz 0,264(11)
	andi. 9,0,1024
	bc 4,2,.L300
	lwz 0,284(11)
	andi. 10,0,32
	bc 12,2,.L306
	lwz 0,732(11)
	subfic 10,0,0
	adde 9,10,0
	xori 0,0,2
	subfic 10,0,0
	adde 0,10,0
	or. 10,0,9
	bc 12,2,.L306
	mr. 31,11
	bc 12,2,.L300
	li 30,0
.L310:
	stw 30,276(31)
	mr 3,31
	stw 30,444(31)
	bl door_go_down
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L310
	b .L300
.L306:
	mr. 31,11
	bc 12,2,.L300
	li 30,0
.L315:
	stw 30,276(31)
	mr 3,31
	mr 4,29
	stw 30,444(31)
	bl door_go_up
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L315
.L300:
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
	bc 12,2,.L321
.L323:
	lfs 0,724(9)
	fabs 0,0
	fcmpu 0,0,13
	bc 4,0,.L322
	fmr 13,0
.L322:
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L323
.L321:
	mr. 9,3
	fdivs 0,13,12
	bclr 12,2
	fmr 9,0
.L329:
	lfs 0,724(9)
	lfs 13,716(9)
	lfs 11,712(9)
	fcmpu 0,11,13
	fabs 0,0
	fdiv 0,0,9
	frsp 12,0
	fdivs 10,12,13
	bc 4,2,.L330
	stfs 12,712(9)
	b .L331
.L330:
	fmuls 0,11,10
	stfs 0,712(9)
.L331:
	lfs 13,720(9)
	lfs 0,716(9)
	fcmpu 0,13,0
	bc 4,2,.L332
	stfs 12,720(9)
	b .L333
.L332:
	fmuls 0,13,10
	stfs 0,720(9)
.L333:
	stfs 12,716(9)
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L329
	blr
.Lfe54:
	.size	 Think_CalcMoveSpeed,.Lfe54-Think_CalcMoveSpeed
	.section	".rodata"
	.align 2
.LC160:
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
	bc 4,2,.L368
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L368
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
	bc 12,2,.L367
	mr 3,31
	bl BecomeExplosion1
	b .L367
.L368:
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
	bc 4,2,.L367
	lis 9,.LC160@ha
	lfs 13,728(30)
	la 9,.LC160@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L367
	lwz 0,732(30)
	cmpwi 0,0,3
	bc 4,2,.L372
	lwz 31,564(30)
	cmpwi 0,31,0
	bc 12,2,.L367
.L376:
	lwz 4,548(31)
	mr 3,31
	bl door_go_up
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L376
	b .L367
.L372:
	lwz 31,564(30)
	cmpwi 0,31,0
	bc 12,2,.L367
.L382:
	mr 3,31
	bl door_go_down
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L382
.L367:
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
	bc 12,2,.L386
	li 11,0
.L388:
	lwz 0,484(9)
	stw 11,512(9)
	stw 0,480(9)
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L388
.L386:
	lwz 3,564(3)
	lwz 0,264(3)
	andi. 9,0,1024
	bc 4,2,.L391
	lwz 0,284(3)
	andi. 11,0,32
	bc 12,2,.L392
	lwz 0,732(3)
	subfic 11,0,0
	adde 9,11,0
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L392
	mr. 31,3
	bc 12,2,.L391
	li 30,0
.L396:
	stw 30,276(31)
	mr 3,31
	stw 30,444(31)
	bl door_go_down
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L396
	b .L391
.L392:
	mr. 31,3
	bc 12,2,.L391
	li 30,0
.L401:
	stw 30,276(31)
	mr 3,31
	mr 4,29
	stw 30,444(31)
	bl door_go_up
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L401
.L391:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe56:
	.size	 door_killed,.Lfe56-door_killed
	.section	".rodata"
	.align 3
.LC161:
	.long 0x40140000
	.long 0x0
	.align 2
.LC162:
	.long 0x3f800000
	.align 2
.LC163:
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
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L404
	lis 9,level+4@ha
	lfs 0,460(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L404
	lis 9,.LC161@ha
	fmr 0,13
	la 9,.LC161@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,460(3)
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L404
	lwz 5,276(3)
	lis 4,.LC76@ha
	mr 3,31
	la 4,.LC76@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	lis 29,gi@ha
	lis 3,.LC77@ha
	la 29,gi@l(29)
	la 3,.LC77@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC162@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC162@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC162@ha
	la 9,.LC162@l(9)
	lfs 2,0(9)
	lis 9,.LC163@ha
	la 9,.LC163@l(9)
	lfs 3,0(9)
	blrl
.L404:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe57:
	.size	 door_touch,.Lfe57-door_touch
	.section	".rodata"
	.align 3
.LC164:
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
	bc 4,2,.L460
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L460
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
	bc 12,2,.L459
	mr 3,31
	bl BecomeExplosion1
	b .L459
.L460:
	lis 9,level+4@ha
	lfs 0,460(12)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L459
	lwz 9,516(12)
	cmpwi 0,9,0
	bc 12,2,.L459
	lis 11,.LC164@ha
	fmr 0,13
	lis 6,vec3_origin@ha
	la 11,.LC164@l(11)
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
.L459:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe58:
	.size	 train_blocked,.Lfe58-train_blocked
	.section	".rodata"
	.align 3
.LC165:
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
	bc 4,2,.L500
	lis 9,gi+4@ha
	lis 3,.LC104@ha
	lwz 0,gi+4@l(9)
	la 3,.LC104@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L499
.L500:
	bl G_PickTarget
	mr. 11,3
	bc 4,2,.L501
	lis 9,gi+4@ha
	lis 3,.LC105@ha
	lwz 4,296(31)
	lwz 0,gi+4@l(9)
	la 3,.LC105@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L499
.L501:
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
	bc 4,2,.L502
	lwz 0,284(31)
	ori 0,0,1
	stw 0,284(31)
.L502:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L499
	lis 11,level+4@ha
	lis 10,.LC165@ha
	lfs 0,level+4@l(11)
	lis 9,train_next@ha
	lfd 13,.LC165@l(10)
	la 9,train_next@l(9)
	stw 9,436(31)
	stw 31,548(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L499:
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
	bc 12,2,.L505
	andi. 0,9,2
	bc 12,2,.L504
	li 0,0
	rlwinm 9,9,0,0,30
	stw 0,428(3)
	stw 9,284(3)
	stw 0,384(3)
	stw 0,380(3)
	stw 0,376(3)
	b .L504
.L505:
	lwz 0,324(3)
	cmpwi 0,0,0
	bc 12,2,.L508
	bl train_resume
	b .L504
.L508:
	bl train_next
.L504:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe60:
	.size	 train_use,.Lfe60-train_use
	.section	".rodata"
	.align 2
.LC166:
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
	lis 9,.LC166@ha
	mr 31,3
	la 9,.LC166@l(9)
	mr 30,4
	lfs 13,0(9)
	lwz 9,416(31)
	lfs 0,428(9)
	fcmpu 0,0,13
	bc 4,2,.L519
	lwz 3,312(30)
	cmpwi 0,3,0
	bc 4,2,.L521
	lis 9,gi+4@ha
	lis 3,.LC110@ha
	lwz 0,gi+4@l(9)
	la 3,.LC110@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L519
.L521:
	bl G_PickTarget
	mr. 3,3
	bc 4,2,.L522
	lis 9,gi+4@ha
	lis 3,.LC111@ha
	lwz 4,312(30)
	lwz 0,gi+4@l(9)
	la 3,.LC111@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L519
.L522:
	lwz 9,416(31)
	stw 3,324(9)
	lwz 3,416(31)
	bl train_resume
.L519:
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
	bc 4,2,.L524
	lis 9,gi+4@ha
	lis 3,.LC112@ha
	lwz 0,gi+4@l(9)
	la 3,.LC112@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L523
.L524:
	bl G_PickTarget
	cmpwi 0,3,0
	stw 3,416(31)
	bc 4,2,.L525
	lis 9,gi+4@ha
	lis 3,.LC113@ha
	lwz 4,296(31)
	lwz 0,gi+4@l(9)
	la 3,.LC113@l(3)
	b .L626
.L525:
	lwz 3,280(3)
	lis 4,.LC114@ha
	la 4,.LC114@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L526
	lis 9,gi+4@ha
	lis 3,.LC115@ha
	lwz 4,296(31)
	lwz 0,gi+4@l(9)
	la 3,.LC115@l(3)
.L626:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L523
.L526:
	lis 9,trigger_elevator_use@ha
	li 0,1
	la 9,trigger_elevator_use@l(9)
	stw 0,184(31)
	stw 9,448(31)
.L523:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe62:
	.size	 trigger_elevator_init,.Lfe62-trigger_elevator_init
	.section	".rodata"
	.align 3
.LC167:
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
	lis 11,.LC167@ha
	stw 9,436(3)
	lfs 0,level+4@l(10)
	lfd 13,.LC167@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe63:
	.size	 SP_trigger_elevator,.Lfe63-SP_trigger_elevator
	.section	".rodata"
	.align 2
.LC168:
	.long 0x46fffe00
	.align 3
.LC169:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC170:
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
	lis 8,.LC169@ha
	lis 10,.LC168@ha
	la 8,.LC169@l(8)
	stw 0,24(1)
	lis 11,level+4@ha
	lfd 0,0(8)
	lfd 13,24(1)
	lis 8,.LC170@ha
	lfs 9,.LC168@l(10)
	la 8,.LC170@l(8)
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
.LC171:
	.long 0x46fffe00
	.align 2
.LC172:
	.long 0x0
	.align 3
.LC173:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC174:
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
	lis 8,.LC172@ha
	mr 31,3
	la 8,.LC172@l(8)
	lfs 0,428(31)
	mr 4,5
	lfs 12,0(8)
	stw 4,548(31)
	fcmpu 0,0,12
	bc 12,2,.L530
	stfs 12,428(31)
	b .L529
.L530:
	lfs 13,596(31)
	fcmpu 0,13,12
	bc 12,2,.L531
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,13
	b .L627
.L531:
	mr 3,31
	bl G_UseTargets
	bl rand
	rlwinm 3,3,0,17,31
	lfs 8,592(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	lfs 11,600(31)
	stw 3,20(1)
	lis 8,.LC173@ha
	lis 10,.LC171@ha
	la 8,.LC173@l(8)
	stw 0,16(1)
	lis 11,level+4@ha
	lfd 0,0(8)
	lfd 13,16(1)
	lis 8,.LC174@ha
	lfs 9,.LC171@l(10)
	la 8,.LC174@l(8)
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
.L627:
	stfs 0,428(31)
.L529:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe65:
	.size	 func_timer_use,.Lfe65-func_timer_use
	.section	".rodata"
	.align 3
.LC175:
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
	bc 12,2,.L539
	li 0,0
	rlwinm 9,11,0,0,30
	stw 0,328(3)
	stw 9,284(3)
	b .L540
.L539:
	lwz 0,532(3)
	lis 10,0x4330
	lis 8,.LC175@ha
	ori 11,11,1
	xoris 0,0,0x8000
	la 8,.LC175@l(8)
	stw 11,284(3)
	stw 0,12(1)
	stw 10,8(1)
	lfd 13,0(8)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,328(3)
.L540:
	lwz 0,284(3)
	andi. 0,0,2
	bc 4,2,.L541
	stw 0,532(3)
.L541:
	la 1,16(1)
	blr
.Lfe66:
	.size	 func_conveyor_use,.Lfe66-func_conveyor_use
	.section	".rodata"
	.align 2
.LC176:
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
	lis 9,.LC176@ha
	mr 31,3
	la 9,.LC176@l(9)
	lfs 0,328(31)
	lfs 12,0(9)
	fcmpu 0,0,12
	bc 4,2,.L543
	lis 0,0x42c8
	stw 0,328(31)
.L543:
	lwz 0,284(31)
	andi. 9,0,1
	bc 4,2,.L544
	lfs 0,328(31)
	stfs 12,328(31)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	stw 9,532(31)
.L544:
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
.LC177:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl door_secret_move1
	.type	 door_secret_move1,@function
door_secret_move1:
	lis 11,level+4@ha
	lis 9,.LC177@ha
	lfs 0,level+4@l(11)
	la 9,.LC177@l(9)
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
.LC178:
	.long 0xbf800000
	.section	".text"
	.align 2
	.globl door_secret_move3
	.type	 door_secret_move3,@function
door_secret_move3:
	lis 9,.LC178@ha
	lfs 13,592(3)
	la 9,.LC178@l(9)
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
.LC179:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl door_secret_move5
	.type	 door_secret_move5,@function
door_secret_move5:
	lis 11,level+4@ha
	lis 9,.LC179@ha
	lfs 0,level+4@l(11)
	la 9,.LC179@l(9)
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
	bc 12,2,.L595
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L594
.L595:
	li 0,0
	li 9,1
	stw 0,480(31)
	stw 9,512(31)
.L594:
	lwz 0,296(31)
	li 30,0
	cmpwi 0,0,0
	bc 12,2,.L597
	lis 9,gi@ha
	lis 28,.LC62@ha
	la 29,gi@l(9)
	b .L598
.L600:
	lwz 3,280(30)
	la 4,.LC62@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L598
	lwz 9,64(29)
	li 4,0
	lwz 3,644(30)
	mtlr 9
	blrl
.L598:
	lwz 5,296(31)
	mr 3,30
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L600
.L597:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe71:
	.size	 door_secret_done,.Lfe71-door_secret_done
	.section	".rodata"
	.align 3
.LC180:
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
	bc 4,2,.L604
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L604
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
	bc 12,2,.L603
	mr 3,31
	bl BecomeExplosion1
	b .L603
.L604:
	lis 9,level+4@ha
	lfs 0,460(12)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L603
	lis 9,.LC180@ha
	fmr 0,13
	lis 6,vec3_origin@ha
	la 9,.LC180@l(9)
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
.L603:
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
