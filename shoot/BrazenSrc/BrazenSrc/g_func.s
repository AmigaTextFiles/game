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
	lfs 12,716(31)
	lfs 13,328(31)
	fcmpu 0,12,13
	bc 4,0,.L29
	lfs 0,332(31)
	fadds 0,12,0
	fcmpu 0,0,13
	stfs 0,716(31)
	bc 4,1,.L29
	stfs 13,716(31)
.L29:
	lwz 0,732(31)
	cmpwi 0,0,2
	bc 4,2,.L31
	lfs 11,16(31)
	lfs 13,688(31)
	lfs 12,692(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,696(31)
	b .L41
.L31:
	lfs 11,16(31)
	lfs 13,664(31)
	lfs 12,668(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,672(31)
.L41:
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
	lfd 30,.LC5@l(9)
	fdivs 1,1,0
	fmr 31,1
	fcmpu 0,31,30
	bc 4,0,.L33
	lwz 0,732(31)
	cmpwi 0,0,2
	bc 4,2,.L34
	lfs 11,16(31)
	lfs 13,688(31)
	lfs 12,692(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,696(31)
	b .L42
.L34:
	lfs 11,16(31)
	lfs 13,664(31)
	lfs 12,668(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,672(31)
.L42:
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
	bc 12,2,.L36
	lwz 9,768(31)
	mr 3,31
	li 0,0
	stw 0,388(31)
	mtlr 9
	stw 0,396(31)
	stw 0,392(31)
	blrl
	b .L28
.L36:
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
	b .L43
.L33:
	fdiv 1,31,30
	bl floor
	lis 9,.LC7@ha
	frsp 29,1
	addi 3,1,8
	la 9,.LC7@l(9)
	addi 4,31,388
	lfd 1,0(9)
	fdiv 1,1,31
	frsp 1,1
	bl VectorScale
	lfs 13,716(31)
	lfs 0,328(31)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L39
	lis 11,level+4@ha
	fmr 13,29
	lis 9,AngleMove_Final@ha
	lfs 0,level+4@l(11)
	la 9,AngleMove_Final@l(9)
	stw 9,436(31)
	fmadd 13,13,30,0
	frsp 13,13
	stfs 13,428(31)
	b .L28
.L39:
	lis 11,level+4@ha
	lis 9,AngleMove_Begin@ha
	lfs 0,level+4@l(11)
	la 9,AngleMove_Begin@l(9)
	stw 9,436(31)
	fadd 0,0,30
.L43:
	frsp 0,0
	stfs 0,428(31)
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
	bc 4,3,.L54
	bclr 4,0
	lis 9,.LC9@ha
	lfs 0,104(3)
	la 9,.LC9@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L56
	stfs 13,104(3)
	stfs 0,96(3)
	blr
.L56:
	lfs 13,96(3)
	lfs 0,68(3)
	fcmpu 0,13,0
	bclr 4,1
	fsubs 0,13,0
	stfs 0,96(3)
	blr
.L54:
	lfs 0,96(3)
	lfs 9,100(3)
	fmr 12,0
	fcmpu 0,0,9
	bc 4,2,.L58
	fsubs 0,13,12
	fcmpu 0,0,10
	bc 4,0,.L58
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
.L58:
	lfs 13,64(3)
	fcmpu 0,12,13
	bclr 4,0
	lfs 0,60(3)
	fadds 0,12,0
	fcmpu 0,0,13
	stfs 0,96(3)
	bc 4,1,.L61
	stfs 13,96(3)
.L61:
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
	.long 0x3f000000
	.align 2
.LC14:
	.long 0x0
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
	mr 31,3
	lfs 0,760(31)
	addi 30,31,652
	lfs 13,748(31)
	fsubs 0,0,13
	stfs 0,760(31)
	lfs 9,108(30)
	lfs 10,60(30)
	lfs 11,64(30)
	fcmpu 0,9,10
	stfs 11,100(30)
	bc 4,0,.L64
	stfs 9,96(30)
	b .L65
.L64:
	fdivs 0,11,10
	lfs 31,68(30)
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 30,0(9)
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 12,0(9)
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 29,0(9)
	fdivs 13,11,31
	fmadds 0,0,11,11
	fmadds 13,13,11,11
	fmuls 0,0,30
	fmuls 1,13,30
	fsubs 0,9,0
	fsubs 0,0,1
	fcmpu 0,0,12
	bc 4,0,.L66
	fmuls 12,10,31
	lis 9,.LC16@ha
	fadds 31,10,31
	la 9,.LC16@l(9)
	lfs 1,0(9)
	lis 9,.LC17@ha
	fdivs 31,31,12
	la 9,.LC17@l(9)
	lfs 13,0(9)
	fmuls 0,31,1
	fmuls 13,9,13
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
.L66:
	stfs 1,112(30)
.L65:
	addi 3,31,652
	bl plat_Accelerate
	lfs 1,760(31)
	lfs 0,748(31)
	fcmpu 0,1,0
	cror 3,2,0
	bc 4,3,.L67
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,2,.L68
	lwz 9,768(31)
	mr 3,31
	stfs 0,376(31)
	mtlr 9
	stfs 0,384(31)
	stfs 0,380(31)
	blrl
	b .L63
.L68:
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
	b .L71
.L67:
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
.L71:
	frsp 0,0
	stfs 0,428(31)
.L63:
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
	bc 4,2,.L79
	lwz 5,700(31)
	cmpwi 0,5,0
	bc 12,2,.L80
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
.L80:
	lwz 0,704(31)
	stw 0,76(31)
.L79:
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
	bc 4,2,.L81
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L81
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L82
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L83
	b .L84
.L82:
	cmpw 0,9,31
	bc 4,2,.L84
.L83:
	mr 3,31
	bl Move_Begin
	b .L87
.L84:
	lis 11,level+4@ha
	lis 10,.LC20@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC20@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L88
.L81:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC20@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC20@l(11)
.L88:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L87:
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
	bc 4,2,.L90
	lwz 5,700(31)
	cmpwi 0,5,0
	bc 12,2,.L91
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
.L91:
	lwz 0,704(31)
	stw 0,76(31)
.L90:
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
	bc 4,2,.L92
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L92
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L93
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L94
	b .L95
.L93:
	cmpw 0,9,31
	bc 4,2,.L95
.L94:
	mr 3,31
	bl Move_Begin
	b .L98
.L95:
	lis 11,level+4@ha
	lis 10,.LC24@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC24@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L99
.L92:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC24@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC24@l(11)
.L99:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L98:
	mr 3,31
	bl plat2_spawn_danger_area
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
	stmw 30,56(1)
	stw 0,68(1)
	mr 31,3
	bl G_Spawn
	lis 9,.LC28@ha
	mr 30,3
	la 9,.LC28@l(9)
	li 0,0
	stw 31,540(30)
	lfs 6,0(9)
	li 11,1
	lis 10,st+24@ha
	lis 9,Touch_Plat_Center@ha
	stw 11,248(30)
	lis 8,0x4330
	la 9,Touch_Plat_Center@l(9)
	stw 0,260(30)
	lis 11,.LC29@ha
	stw 9,444(30)
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
	bc 12,2,.L120
	fadds 0,0,6
	stfs 0,32(1)
.L120:
	lfs 0,24(1)
	lis 11,.LC31@ha
	lfs 13,8(1)
	la 11,.LC31@l(11)
	lfs 10,0(11)
	fsubs 0,0,13
	fcmpu 0,0,10
	cror 3,2,0
	bc 4,3,.L121
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
.L121:
	lfs 0,28(1)
	lfs 13,12(1)
	fsubs 0,0,13
	fcmpu 0,0,10
	cror 3,2,0
	bc 4,3,.L122
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
.L122:
	lfs 13,8(1)
	lis 9,gi+72@ha
	mr 3,30
	stfs 13,188(30)
	lfs 0,12(1)
	stfs 0,192(30)
	lfs 13,16(1)
	stfs 13,196(30)
	lfs 0,24(1)
	stfs 0,200(30)
	lfs 13,28(1)
	stfs 13,204(30)
	lfs 0,32(1)
	stfs 0,208(30)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	mr 3,30
	lwz 0,68(1)
	mtlr 0
	lmw 30,56(1)
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
	bc 4,2,.L124
	lis 0,0x41a0
	stw 0,328(31)
	b .L125
.L124:
	lis 9,.LC34@ha
	lfd 13,.LC34@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,328(31)
.L125:
	lis 9,.LC38@ha
	lfs 13,332(31)
	la 9,.LC38@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L126
	lis 0,0x40a0
	stw 0,332(31)
	b .L127
.L126:
	fmr 0,13
	lis 9,.LC34@ha
	lfd 13,.LC34@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,332(31)
.L127:
	lis 10,.LC38@ha
	lfs 13,336(31)
	la 10,.LC38@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,2,.L128
	lis 0,0x40a0
	stw 0,336(31)
	b .L129
.L128:
	fmr 0,13
	lis 9,.LC34@ha
	lfd 13,.LC34@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,336(31)
.L129:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L130
	li 0,2
	stw 0,516(31)
.L130:
	lis 9,st@ha
	la 9,st@l(9)
	lwz 0,24(9)
	cmpwi 0,0,0
	bc 4,2,.L131
	li 0,8
	stw 0,24(9)
.L131:
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
	bc 12,2,.L132
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
	b .L133
.L132:
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
.L133:
	lis 9,Use_Plat@ha
	mr 3,31
	la 9,Use_Plat@l(9)
	stw 9,448(31)
	bl plat_spawn_inside_trigger
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L134
	li 0,2
	b .L136
.L134:
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
.L136:
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
	.string	"bad_area"
	.align 2
.LC41:
	.long 0x3f800000
	.align 2
.LC42:
	.long 0x40400000
	.align 2
.LC43:
	.long 0x0
	.align 3
.LC44:
	.long 0x40140000
	.long 0x0
	.align 3
.LC45:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC46:
	.long 0x40000000
	.long 0x0
	.section	".text"
	.align 2
	.globl plat2_hit_top
	.type	 plat2_hit_top,@function
plat2_hit_top:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,264(31)
	andi. 30,0,1024
	bc 4,2,.L145
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L146
	lis 9,gi+16@ha
	lis 10,.LC42@ha
	lwz 0,gi+16@l(9)
	lis 11,.LC43@ha
	la 10,.LC42@l(10)
	lis 9,.LC41@ha
	la 11,.LC43@l(11)
	lfs 2,0(10)
	la 9,.LC41@l(9)
	lfs 3,0(11)
	mtlr 0
	li 4,10
	lfs 1,0(9)
	blrl
.L146:
	stw 30,76(31)
.L145:
	lwz 9,1032(31)
	li 0,0
	stw 0,732(31)
	andi. 10,9,1
	bc 12,2,.L147
	li 0,4
	lwz 9,284(31)
	stw 0,1032(31)
	andi. 0,9,2
	bc 4,2,.L148
	lis 9,plat2_go_down@ha
	lis 11,level@ha
	la 9,plat2_go_down@l(9)
	la 11,level@l(11)
	stw 9,436(31)
	lis 10,.LC44@ha
	lfs 0,4(11)
	la 10,.LC44@l(10)
	lfd 13,0(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L148:
	lis 9,.LC43@ha
	lis 11,deathmatch@ha
	la 9,.LC43@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L149
	lis 9,level+4@ha
	lis 10,.LC45@ha
	lfs 0,level+4@l(9)
	la 10,.LC45@l(10)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	b .L154
.L149:
	lis 9,level+4@ha
	lis 11,.LC46@ha
	lfs 0,level+4@l(9)
	la 11,.LC46@l(11)
	lfd 13,0(11)
	fsub 0,0,13
	frsp 0,0
	b .L154
.L147:
	lwz 0,284(31)
	andi. 9,0,6
	bc 4,2,.L152
	lis 9,plat2_go_down@ha
	lis 11,level@ha
	stw 10,1032(31)
	la 9,plat2_go_down@l(9)
	la 11,level@l(11)
	stw 9,436(31)
	lis 10,.LC46@ha
	lfs 0,4(11)
	la 10,.LC46@l(10)
	lfd 13,0(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lfs 13,4(11)
	stfs 13,476(31)
	b .L151
.L152:
	stw 10,1032(31)
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
.L154:
	stfs 0,476(31)
.L151:
	mr 3,31
	mr 4,3
	bl G_UseTargets
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe9:
	.size	 plat2_hit_top,.Lfe9-plat2_hit_top
	.section	".rodata"
	.align 2
.LC47:
	.long 0x3f800000
	.align 2
.LC48:
	.long 0x40400000
	.align 2
.LC49:
	.long 0x0
	.align 3
.LC50:
	.long 0x40140000
	.long 0x0
	.align 3
.LC51:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC52:
	.long 0x40000000
	.long 0x0
	.section	".text"
	.align 2
	.globl plat2_hit_bottom
	.type	 plat2_hit_bottom,@function
plat2_hit_bottom:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,3
	lwz 0,264(30)
	andi. 31,0,1024
	bc 4,2,.L156
	lwz 5,708(30)
	cmpwi 0,5,0
	bc 12,2,.L157
	lis 9,gi+16@ha
	lis 10,.LC48@ha
	lwz 0,gi+16@l(9)
	lis 11,.LC49@ha
	la 10,.LC48@l(10)
	lis 9,.LC47@ha
	la 11,.LC49@l(11)
	lfs 2,0(10)
	la 9,.LC47@l(9)
	lfs 3,0(11)
	mtlr 0
	li 4,10
	lfs 1,0(9)
	blrl
.L157:
	stw 31,76(30)
.L156:
	lwz 9,1032(30)
	li 0,1
	stw 0,732(30)
	andi. 10,9,1
	bc 12,2,.L158
	li 0,4
	lwz 9,284(30)
	stw 0,1032(30)
	andi. 0,9,2
	bc 4,2,.L159
	lis 9,plat2_go_up@ha
	lis 11,level@ha
	la 9,plat2_go_up@l(9)
	la 11,level@l(11)
	stw 9,436(30)
	lis 10,.LC50@ha
	lfs 0,4(11)
	la 10,.LC50@l(10)
	lfd 13,0(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
.L159:
	lis 9,.LC49@ha
	lis 11,deathmatch@ha
	la 9,.LC49@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L160
	lis 9,level+4@ha
	lis 10,.LC51@ha
	lfs 0,level+4@l(9)
	la 10,.LC51@l(10)
	lfd 13,0(10)
	fsub 0,0,13
	frsp 0,0
	b .L171
.L160:
	lis 9,level+4@ha
	lis 11,.LC52@ha
	lfs 0,level+4@l(9)
	la 11,.LC52@l(11)
	lfd 13,0(11)
	fsub 0,0,13
	frsp 0,0
	b .L171
.L158:
	lwz 0,284(30)
	rlwinm 0,0,0,29,30
	cmpwi 0,0,4
	bc 4,2,.L163
	lis 9,plat2_go_up@ha
	lis 11,level@ha
	stw 10,1032(30)
	la 9,plat2_go_up@l(9)
	la 11,level@l(11)
	stw 9,436(30)
	lfs 0,4(11)
	lis 9,.LC52@ha
	la 9,.LC52@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
	lfs 13,4(11)
	stfs 13,476(30)
	b .L162
.L163:
	stw 10,1032(30)
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
.L171:
	stfs 0,476(30)
.L162:
	li 31,0
	b .L165
.L167:
	lwz 0,256(31)
	cmpw 0,0,30
	bc 4,2,.L165
	mr 3,31
	bl G_FreeEdict
.L165:
	lis 5,.LC40@ha
	mr 3,31
	la 5,.LC40@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L167
	mr 3,30
	mr 4,3
	bl G_UseTargets
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 plat2_hit_bottom,.Lfe10-plat2_hit_bottom
	.section	".rodata"
	.align 3
.LC53:
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
	.globl plat2_go_down
	.type	 plat2_go_down,@function
plat2_go_down:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,264(31)
	andi. 9,0,1024
	bc 4,2,.L173
	lwz 5,700(31)
	cmpwi 0,5,0
	bc 12,2,.L174
	lis 11,.LC54@ha
	lis 9,gi+16@ha
	la 11,.LC54@l(11)
	lwz 0,gi+16@l(9)
	lfs 1,0(11)
	lis 9,.LC55@ha
	li 4,10
	lis 11,.LC56@ha
	la 9,.LC55@l(9)
	mtlr 0
	la 11,.LC56@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L174:
	lwz 0,704(31)
	stw 0,76(31)
.L173:
	lfs 13,4(31)
	li 9,0
	li 11,3
	lfs 0,676(31)
	addi 10,31,676
	lis 29,plat2_hit_bottom@ha
	lwz 0,1032(31)
	la 29,plat2_hit_bottom@l(29)
	addi 3,31,736
	stw 11,732(31)
	fsubs 0,0,13
	ori 0,0,2
	stw 9,376(31)
	stw 0,1032(31)
	stw 9,384(31)
	stfs 0,736(31)
	stw 9,380(31)
	lfs 13,4(10)
	lfs 0,8(31)
	lfs 12,12(31)
	fsubs 13,13,0
	stfs 13,740(31)
	lfs 0,8(10)
	fsubs 0,0,12
	stfs 0,744(31)
	bl VectorNormalize
	lfs 13,716(31)
	lfs 0,712(31)
	stfs 1,760(31)
	stw 29,768(31)
	fcmpu 0,13,0
	bc 4,2,.L175
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L175
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L176
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L177
	b .L178
.L176:
	cmpw 0,9,31
	bc 4,2,.L178
.L177:
	mr 3,31
	bl Move_Begin
	b .L181
.L178:
	lis 11,level+4@ha
	lis 10,.LC53@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC53@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L182
.L175:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC53@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC53@l(11)
.L182:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L181:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 plat2_go_down,.Lfe11-plat2_go_down
	.section	".rodata"
	.align 3
.LC57:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC58:
	.long 0x3f800000
	.align 2
.LC59:
	.long 0x40400000
	.align 2
.LC60:
	.long 0x0
	.align 2
.LC61:
	.long 0x42800000
	.section	".text"
	.align 2
	.globl plat2_go_up
	.type	 plat2_go_up,@function
plat2_go_up:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	mr 31,3
	lwz 0,264(31)
	andi. 9,0,1024
	bc 4,2,.L184
	lwz 5,700(31)
	cmpwi 0,5,0
	bc 12,2,.L185
	lis 11,.LC58@ha
	lis 9,gi+16@ha
	la 11,.LC58@l(11)
	lwz 0,gi+16@l(9)
	lfs 1,0(11)
	lis 9,.LC59@ha
	li 4,10
	lis 11,.LC60@ha
	la 9,.LC59@l(9)
	mtlr 0
	la 11,.LC60@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L185:
	lwz 0,704(31)
	stw 0,76(31)
.L184:
	lis 9,.LC61@ha
	lfs 9,196(31)
	lis 11,.LC60@ha
	la 9,.LC61@l(9)
	lwz 0,1032(31)
	la 11,.LC60@l(11)
	lfs 0,0(9)
	addi 4,1,24
	mr 5,31
	lfs 10,188(31)
	li 9,2
	ori 0,0,2
	lfs 11,192(31)
	addi 3,1,8
	lfs 13,200(31)
	fadds 0,9,0
	lfs 12,204(31)
	lfs 1,0(11)
	stw 9,732(31)
	stw 0,1032(31)
	stfs 11,12(1)
	stfs 13,24(1)
	stfs 12,28(1)
	stfs 0,32(1)
	stfs 10,8(1)
	stfs 9,16(1)
	bl SpawnBadArea
	lfs 13,4(31)
	li 0,0
	addi 9,31,652
	lfs 0,652(31)
	lis 29,plat2_hit_top@ha
	addi 3,31,736
	stw 0,376(31)
	la 29,plat2_hit_top@l(29)
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
	bc 4,2,.L187
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L187
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L188
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L189
	b .L190
.L188:
	cmpw 0,9,31
	bc 4,2,.L190
.L189:
	mr 3,31
	bl Move_Begin
	b .L193
.L190:
	lis 11,level+4@ha
	lis 10,.LC57@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC57@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L194
.L187:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC57@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC57@l(11)
.L194:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L193:
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe12:
	.size	 plat2_go_up,.Lfe12-plat2_go_up
	.section	".rodata"
	.align 2
.LC62:
	.long 0x3e99999a
	.align 2
.LC63:
	.long 0x3dcccccd
	.align 2
.LC64:
	.long 0x40000000
	.align 2
.LC65:
	.long 0x3f000000
	.align 2
.LC66:
	.long 0x0
	.section	".text"
	.align 2
	.globl plat2_operate
	.type	 plat2_operate,@function
plat2_operate:
	mr 11,3
	lwz 3,540(3)
	lwz 0,1032(3)
	andi. 9,0,2
	bclr 4,2
	lis 9,.LC64@ha
	lfs 0,476(3)
	la 9,.LC64@l(9)
	lfs 12,0(9)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	fadds 0,0,12
	fcmpu 0,0,13
	bclr 12,1
	lfs 12,232(11)
	lis 9,.LC65@ha
	lfs 13,220(11)
	la 9,.LC65@l(9)
	lwz 0,732(3)
	lfs 0,0(9)
	fadds 13,13,12
	cmpwi 0,0,0
	fmuls 13,13,0
	bc 4,2,.L198
	lwz 0,284(3)
	li 10,0
	andi. 9,0,32
	bc 12,2,.L199
	lfs 0,12(4)
	fcmpu 0,13,0
	b .L210
.L199:
	lfs 0,12(4)
	fcmpu 0,12,0
.L210:
	bc 4,1,.L203
	li 10,1
	b .L203
.L198:
	lfs 0,12(4)
	li 10,1
	fcmpu 0,0,13
	bc 4,1,.L203
	li 10,0
.L203:
	lis 9,deathmatch@ha
	li 0,2
	lwz 11,deathmatch@l(9)
	lis 9,.LC66@ha
	stw 0,1032(3)
	la 9,.LC66@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L205
	lis 9,.LC62@ha
	lfs 13,.LC62@l(9)
	b .L206
.L205:
	lis 9,.LC65@ha
	la 9,.LC65@l(9)
	lfs 13,0(9)
.L206:
	lwz 0,732(3)
	cmpw 0,0,10
	bc 12,2,.L207
	lwz 0,1032(3)
	lis 9,.LC63@ha
	lfs 13,.LC63@l(9)
	ori 0,0,1
	stw 0,1032(3)
.L207:
	lis 9,level@ha
	lwz 0,732(3)
	la 11,level@l(9)
	lfs 0,4(11)
	cmpwi 0,0,1
	stfs 0,476(3)
	bc 4,2,.L208
	lis 9,plat2_go_up@ha
	la 9,plat2_go_up@l(9)
.L211:
	stw 9,436(3)
	lfs 0,4(11)
	fadds 0,0,13
	stfs 0,428(3)
	blr
.L208:
	lis 9,plat2_go_down@ha
	la 9,plat2_go_down@l(9)
	b .L211
.Lfe13:
	.size	 plat2_operate,.Lfe13-plat2_operate
	.section	".rodata"
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
	.align 2
.LC70:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl SP_func_plat2
	.type	 SP_func_plat2,@function
SP_func_plat2:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	lis 8,.LC68@ha
	mr 31,3
	la 8,.LC68@l(8)
	li 9,2
	lwz 4,268(31)
	lfs 31,0(8)
	li 0,3
	lis 11,gi+44@ha
	stw 9,260(31)
	stw 0,248(31)
	stfs 31,24(31)
	stfs 31,20(31)
	stfs 31,16(31)
	lwz 0,gi+44@l(11)
	mtlr 0
	blrl
	lfs 0,328(31)
	lis 9,plat2_blocked@ha
	la 9,plat2_blocked@l(9)
	stw 9,440(31)
	fcmpu 0,0,31
	bc 4,2,.L235
	lis 0,0x41a0
	stw 0,328(31)
	b .L236
.L235:
	lis 9,.LC67@ha
	lfd 13,.LC67@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,328(31)
.L236:
	lis 8,.LC68@ha
	lfs 13,332(31)
	la 8,.LC68@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,2,.L237
	lis 0,0x40a0
	stw 0,332(31)
	b .L238
.L237:
	fmr 0,13
	lis 9,.LC67@ha
	lfd 13,.LC67@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,332(31)
.L238:
	lis 9,.LC68@ha
	lfs 13,336(31)
	la 9,.LC68@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L239
	lis 0,0x40a0
	stw 0,336(31)
	b .L240
.L239:
	fmr 0,13
	lis 9,.LC67@ha
	lfd 13,.LC67@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,336(31)
.L240:
	lis 11,deathmatch@ha
	lis 10,.LC68@ha
	lwz 9,deathmatch@l(11)
	la 10,.LC68@l(10)
	lfs 13,0(10)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L241
	lfs 0,328(31)
	lfs 13,332(31)
	lfs 12,336(31)
	fadds 0,0,0
	fadds 13,13,13
	fadds 12,12,12
	stfs 0,328(31)
	stfs 13,332(31)
	stfs 12,336(31)
.L241:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L242
	li 0,2
	stw 0,516(31)
.L242:
	lfs 0,4(31)
	lis 9,st@ha
	lfs 13,8(31)
	la 9,st@l(9)
	lfs 10,12(31)
	stfs 0,364(31)
	stfs 13,368(31)
	stfs 0,352(31)
	stfs 13,356(31)
	stfs 10,360(31)
	stfs 10,372(31)
	lwz 10,32(9)
	cmpwi 0,10,0
	bc 12,2,.L243
	lwz 0,24(9)
	lis 11,0x4330
	lis 8,.LC69@ha
	la 8,.LC69@l(8)
	subf 0,0,10
	lfd 13,0(8)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 11,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fsubs 0,10,0
	stfs 0,372(31)
	b .L244
.L243:
	lwz 0,24(9)
	lis 11,0x4330
	lis 10,.LC69@ha
	la 10,.LC69@l(10)
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
.L244:
	lwz 9,300(31)
	li 0,0
	stw 0,732(31)
	cmpwi 0,9,0
	bc 12,2,.L245
	lis 9,plat2_activate@ha
	la 9,plat2_activate@l(9)
	stw 9,448(31)
	b .L246
.L245:
	lis 9,Use_Plat2@ha
	mr 3,31
	la 9,Use_Plat2@l(9)
	stw 9,448(31)
	bl plat_spawn_inside_trigger
	lis 8,.LC70@ha
	mr 29,3
	la 8,.LC70@l(8)
	lfs 10,200(29)
	lis 9,gi+72@ha
	lfs 13,0(8)
	lfs 12,204(29)
	lfs 11,188(29)
	lfs 0,192(29)
	fadds 10,10,13
	fadds 12,12,13
	fsubs 11,11,13
	fsubs 0,0,13
	stfs 10,200(29)
	stfs 12,204(29)
	stfs 11,188(29)
	stfs 0,192(29)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,Touch_Plat_Center2@ha
	la 9,Touch_Plat_Center2@l(9)
	stw 9,444(29)
	lwz 0,284(31)
	andi. 8,0,4
	bc 4,2,.L246
	lfs 12,364(31)
	li 0,1
	lfs 0,368(31)
	lfs 13,372(31)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	stw 0,732(31)
.L246:
	lis 29,gi@ha
	mr 3,31
	la 29,gi@l(29)
	lwz 9,72(29)
	mtlr 9
	blrl
	lfs 2,16(31)
	lis 3,.LC35@ha
	lfs 3,20(31)
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
.Lfe14:
	.size	 SP_func_plat2,.Lfe14-SP_func_plat2
	.section	".rodata"
	.align 3
.LC73:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl rotating_use
	.type	 rotating_use,@function
rotating_use:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lis 4,vec3_origin@ha
	addi 30,31,388
	la 4,vec3_origin@l(4)
	mr 3,30
	bl VectorCompare
	mr. 28,3
	bc 4,2,.L259
	lwz 0,284(31)
	stw 28,76(31)
	andi. 29,0,8192
	bc 12,2,.L260
	mr 3,30
	bl VectorLength
	lfs 0,336(31)
	fcmpu 0,1,0
	cror 3,2,0
	bc 4,3,.L261
	li 0,0
	mr 3,31
	stw 0,388(31)
	mr 4,31
	stw 0,396(31)
	stw 0,392(31)
	bl G_UseTargets
	stw 28,444(31)
	b .L265
.L261:
	fsubs 1,1,0
	mr 4,30
	addi 3,31,340
	bl VectorScale
	lis 9,rotating_decel@ha
	lis 10,level+4@ha
	la 9,rotating_decel@l(9)
	lis 11,.LC73@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC73@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	b .L265
.L260:
	li 0,0
	mr 3,31
	stw 0,388(31)
	mr 4,31
	stw 0,396(31)
	stw 0,392(31)
	bl G_UseTargets
	stw 29,444(31)
	b .L265
.L259:
	lwz 0,284(31)
	lwz 9,704(31)
	andi. 11,0,8192
	stw 9,76(31)
	bc 12,2,.L266
	mr 3,30
	bl VectorLength
	lfs 12,328(31)
	lfs 13,332(31)
	fsubs 0,12,13
	fcmpu 0,1,0
	cror 3,2,1
	bc 4,3,.L267
	fmr 1,12
	mr 4,30
	addi 3,31,340
	bl VectorScale
	mr 3,31
	mr 4,31
	bl G_UseTargets
	b .L270
.L267:
	fadds 1,1,13
	mr 4,30
	addi 3,31,340
	bl VectorScale
	lis 9,rotating_accel@ha
	lis 10,level+4@ha
	la 9,rotating_accel@l(9)
	lis 11,.LC73@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC73@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	b .L270
.L266:
	lfs 1,328(31)
	mr 4,30
	addi 3,31,340
	bl VectorScale
	mr 3,31
	mr 4,31
	bl G_UseTargets
.L270:
	lwz 0,284(31)
	andi. 9,0,16
	bc 12,2,.L265
	lis 9,rotating_touch@ha
	la 9,rotating_touch@l(9)
	stw 9,444(31)
.L265:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 rotating_use,.Lfe15-rotating_use
	.section	".rodata"
	.align 2
.LC74:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_func_rotating
	.type	 SP_func_rotating,@function
SP_func_rotating:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 29,12(1)
	stw 0,36(1)
	mr 31,3
	li 9,3
	lwz 0,284(31)
	stw 9,248(31)
	andi. 11,0,32
	bc 12,2,.L273
	stw 9,260(31)
	b .L274
.L273:
	li 0,2
	stw 0,260(31)
.L274:
	lwz 9,284(31)
	li 0,0
	stw 0,340(31)
	andi. 11,9,4
	stw 0,348(31)
	stw 0,344(31)
	bc 12,2,.L275
	lis 0,0x3f80
	stw 0,348(31)
	b .L276
.L275:
	andi. 0,9,8
	bc 12,2,.L277
	lis 0,0x3f80
	stw 0,340(31)
	b .L276
.L277:
	lis 0,0x3f80
	stw 0,344(31)
.L276:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L279
	lfs 0,340(31)
	lfs 13,344(31)
	lfs 12,348(31)
	fneg 0,0
	fneg 13,13
	fneg 12,12
	stfs 0,340(31)
	stfs 13,344(31)
	stfs 12,348(31)
.L279:
	lis 11,.LC74@ha
	lfs 0,328(31)
	la 11,.LC74@l(11)
	lfs 31,0(11)
	fcmpu 0,0,31
	bc 4,2,.L280
	lis 0,0x42c8
	stw 0,328(31)
.L280:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L281
	li 0,2
	stw 0,516(31)
.L281:
	lwz 0,516(31)
	lis 9,rotating_use@ha
	la 9,rotating_use@l(9)
	cmpwi 0,0,0
	stw 9,448(31)
	bc 12,2,.L282
	lis 9,rotating_blocked@ha
	la 9,rotating_blocked@l(9)
	stw 9,440(31)
.L282:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L283
	lwz 9,448(31)
	mr 3,31
	li 4,0
	li 5,0
	mtlr 9
	blrl
.L283:
	lwz 0,284(31)
	andi. 9,0,64
	bc 12,2,.L284
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L284:
	lwz 0,284(31)
	andi. 11,0,128
	bc 12,2,.L285
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L285:
	lwz 0,284(31)
	andi. 9,0,8192
	bc 12,2,.L286
	lfs 13,332(31)
	fcmpu 0,13,31
	bc 4,2,.L287
	lis 0,0x3f80
	stw 0,332(31)
	b .L288
.L287:
	lfs 0,328(31)
	fcmpu 0,13,0
	bc 4,1,.L288
	stfs 0,332(31)
.L288:
	lis 11,.LC74@ha
	lfs 13,336(31)
	la 11,.LC74@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L290
	lis 0,0x3f80
	stw 0,336(31)
	b .L286
.L290:
	lfs 0,328(31)
	fcmpu 0,13,0
	bc 4,1,.L286
	stfs 0,336(31)
.L286:
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
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 SP_func_rotating,.Lfe16-SP_func_rotating
	.section	".rodata"
	.align 3
.LC75:
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
	bc 4,2,.L295
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L295
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L296
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L297
	b .L298
.L296:
	cmpw 0,9,31
	bc 4,2,.L298
.L297:
	mr 3,31
	bl Move_Begin
	b .L301
.L298:
	lis 11,level+4@ha
	lis 10,.LC75@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC75@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L303
.L295:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC75@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC75@l(11)
.L303:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L301:
	lwz 9,480(31)
	li 0,0
	stw 0,56(31)
	cmpwi 0,9,0
	bc 12,2,.L302
	li 0,1
	stw 0,512(31)
.L302:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 button_return,.Lfe17-button_return
	.section	".rodata"
	.align 3
.LC76:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC77:
	.long 0x3f800000
	.align 2
.LC78:
	.long 0x40400000
	.align 2
.LC79:
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
	bc 4,2,.L306
	lwz 5,700(31)
	li 0,2
	stw 0,732(31)
	cmpwi 0,5,0
	bc 12,2,.L308
	lwz 0,264(31)
	andi. 9,0,1024
	bc 4,2,.L308
	lis 11,.LC77@ha
	lis 9,gi+16@ha
	la 11,.LC77@l(11)
	lwz 0,gi+16@l(9)
	lfs 1,0(11)
	lis 9,.LC78@ha
	li 4,10
	lis 11,.LC79@ha
	la 9,.LC78@l(9)
	mtlr 0
	la 11,.LC79@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L308:
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
	bc 4,2,.L309
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L309
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L310
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L311
	b .L312
.L310:
	cmpw 0,9,31
	bc 4,2,.L312
.L311:
	mr 3,31
	bl Move_Begin
	b .L306
.L312:
	lis 11,level+4@ha
	lis 10,.LC76@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC76@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L316
.L309:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC76@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC76@l(11)
.L316:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L306:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 button_fire,.Lfe18-button_fire
	.section	".rodata"
	.align 2
.LC80:
	.string	"switches/butn2.wav"
	.align 2
.LC81:
	.long 0x0
	.align 3
.LC82:
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
	bc 12,2,.L323
	lwz 0,36(30)
	lis 3,.LC80@ha
	la 3,.LC80@l(3)
	mtlr 0
	blrl
	stw 3,700(31)
.L323:
	lis 8,.LC81@ha
	lfs 0,328(31)
	la 8,.LC81@l(8)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,2,.L324
	lis 0,0x4220
	stw 0,328(31)
.L324:
	lfs 0,332(31)
	fcmpu 0,0,13
	bc 4,2,.L325
	lfs 0,328(31)
	stfs 0,332(31)
.L325:
	lfs 0,336(31)
	fcmpu 0,0,13
	bc 4,2,.L326
	lfs 0,328(31)
	stfs 0,336(31)
.L326:
	lfs 0,592(31)
	fcmpu 0,0,13
	bc 4,2,.L327
	lis 0,0x4040
	stw 0,592(31)
.L327:
	lis 9,st@ha
	la 10,st@l(9)
	lwz 0,24(10)
	cmpwi 0,0,0
	bc 4,2,.L328
	li 0,4
	stw 0,24(10)
.L328:
	lfs 12,4(31)
	lis 11,0x4330
	lfs 13,8(31)
	lis 8,.LC82@ha
	mr 4,29
	lfs 0,12(31)
	la 8,.LC82@l(8)
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
	bc 12,2,.L329
	lis 9,button_killed@ha
	li 0,1
	stw 11,484(31)
	la 9,button_killed@l(9)
	stw 0,512(31)
	stw 9,456(31)
	b .L330
.L329:
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L330
	lis 9,button_touch@ha
	la 9,button_touch@l(9)
	stw 9,444(31)
.L330:
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
.Lfe19:
	.size	 SP_func_button,.Lfe19-SP_func_button
	.section	".rodata"
	.align 2
.LC83:
	.string	"func_areaportal"
	.align 2
.LC84:
	.string	"func_door"
	.align 2
.LC86:
	.string	"func_door_rotating"
	.align 3
.LC85:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC87:
	.long 0x3f800000
	.align 2
.LC88:
	.long 0x40400000
	.align 2
.LC89:
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
	andi. 9,0,1024
	bc 4,2,.L355
	lwz 5,700(31)
	cmpwi 0,5,0
	bc 12,2,.L356
	lis 11,.LC87@ha
	lis 9,gi+16@ha
	la 11,.LC87@l(11)
	lwz 0,gi+16@l(9)
	lfs 1,0(11)
	lis 9,.LC88@ha
	li 4,10
	lis 11,.LC89@ha
	la 9,.LC88@l(9)
	mtlr 0
	la 11,.LC89@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L356:
	lwz 0,704(31)
	stw 0,76(31)
.L355:
	lwz 9,484(31)
	cmpwi 0,9,0
	bc 12,2,.L357
	li 0,1
	stw 9,480(31)
	stw 0,512(31)
.L357:
	li 0,3
	lwz 3,280(31)
	lis 4,.LC84@ha
	stw 0,732(31)
	la 4,.LC84@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L358
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
	bc 4,2,.L359
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L359
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L360
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L361
	b .L362
.L360:
	cmpw 0,9,31
	bc 4,2,.L362
.L361:
	mr 3,31
	bl Move_Begin
	b .L366
.L362:
	lis 11,level+4@ha
	lis 10,.LC85@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC85@l(10)
	la 9,Move_Begin@l(9)
	b .L374
.L359:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC85@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC85@l(11)
	b .L375
.L358:
	lwz 3,280(31)
	lis 4,.LC86@ha
	la 4,.LC86@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L366
	lfs 0,332(31)
	lis 9,door_hit_bottom@ha
	li 0,0
	lfs 13,328(31)
	la 9,door_hit_bottom@l(9)
	stw 9,768(31)
	stw 0,396(31)
	fcmpu 0,0,13
	stw 0,392(31)
	stw 0,388(31)
	bc 12,2,.L368
	stw 0,716(31)
.L368:
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L369
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L370
	b .L371
.L369:
	cmpw 0,9,31
	bc 4,2,.L371
.L370:
	mr 3,31
	bl AngleMove_Begin
	b .L366
.L371:
	lis 11,level+4@ha
	lis 10,.LC85@ha
	lfs 0,level+4@l(11)
	lis 9,AngleMove_Begin@ha
	lfd 13,.LC85@l(10)
	la 9,AngleMove_Begin@l(9)
.L374:
	stw 9,436(31)
.L375:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L366:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 door_go_down,.Lfe20-door_go_down
	.section	".rodata"
	.align 3
.LC90:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC91:
	.long 0x0
	.align 2
.LC92:
	.long 0x3f800000
	.align 2
.LC93:
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
	bc 12,2,.L376
	cmpwi 0,0,0
	bc 4,2,.L378
	lis 9,.LC91@ha
	lfs 13,728(31)
	la 9,.LC91@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L376
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,13
	stfs 0,428(31)
	b .L376
.L378:
	lwz 0,264(31)
	andi. 11,0,1024
	bc 4,2,.L380
	lwz 5,700(31)
	cmpwi 0,5,0
	bc 12,2,.L381
	lis 9,gi+16@ha
	lis 11,.LC93@ha
	lwz 0,gi+16@l(9)
	la 11,.LC93@l(11)
	mr 3,31
	lis 9,.LC92@ha
	li 4,10
	lfs 2,0(11)
	la 9,.LC92@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC91@ha
	la 9,.LC91@l(9)
	lfs 3,0(9)
	blrl
.L381:
	lwz 0,704(31)
	stw 0,76(31)
.L380:
	li 0,2
	lwz 3,280(31)
	lis 4,.LC84@ha
	stw 0,732(31)
	la 4,.LC84@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L382
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
	bc 4,2,.L383
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L383
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L384
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L385
	b .L386
.L384:
	cmpw 0,9,31
	bc 4,2,.L386
.L385:
	mr 3,31
	bl Move_Begin
	b .L390
.L386:
	lis 11,level+4@ha
	lis 10,.LC90@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC90@l(10)
	la 9,Move_Begin@l(9)
	b .L405
.L383:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC90@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC90@l(11)
	b .L406
.L382:
	lwz 3,280(31)
	lis 4,.LC86@ha
	la 4,.LC86@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L390
	lfs 0,332(31)
	lis 9,door_hit_top@ha
	li 0,0
	lfs 13,328(31)
	la 9,door_hit_top@l(9)
	stw 9,768(31)
	stw 0,396(31)
	fcmpu 0,0,13
	stw 0,392(31)
	stw 0,388(31)
	bc 12,2,.L392
	stw 0,716(31)
.L392:
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L393
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L394
	b .L395
.L393:
	cmpw 0,9,31
	bc 4,2,.L395
.L394:
	mr 3,31
	bl AngleMove_Begin
	b .L390
.L395:
	lis 11,level+4@ha
	lis 10,.LC90@ha
	lfs 0,level+4@l(11)
	lis 9,AngleMove_Begin@ha
	lfd 13,.LC90@l(10)
	la 9,AngleMove_Begin@l(9)
.L405:
	stw 9,436(31)
.L406:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L390:
	mr 4,30
	mr 3,31
	bl G_UseTargets
	li 29,0
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L376
	lis 9,gi@ha
	lis 28,.LC83@ha
	la 30,gi@l(9)
	b .L400
.L402:
	lwz 3,280(29)
	la 4,.LC83@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L400
	lwz 9,64(30)
	li 4,1
	lwz 3,644(29)
	mtlr 9
	blrl
.L400:
	lwz 5,296(31)
	mr 3,29
	li 4,300
	bl G_Find
	mr. 29,3
	bc 4,2,.L402
.L376:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 door_go_up,.Lfe21-door_go_up
	.section	".rodata"
	.align 2
.LC94:
	.long 0x497423f0
	.align 3
.LC95:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC96:
	.long 0x0
	.align 3
.LC97:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC98:
	.long 0x3f800000
	.align 2
.LC99:
	.long 0x40400000
	.align 2
.LC100:
	.long 0x42c80000
	.align 2
.LC101:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl smart_water_go_up
	.type	 smart_water_go_up,@function
smart_water_go_up:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,732(31)
	cmpwi 0,0,0
	bc 4,2,.L408
	lis 9,.LC96@ha
	lfs 13,728(31)
	la 9,.LC96@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L407
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,13
	b .L435
.L408:
	lwz 11,480(31)
	cmpwi 0,11,0
	bc 12,2,.L410
	xoris 11,11,0x8000
	lfs 12,232(31)
	stw 11,12(1)
	lis 0,0x4330
	lis 11,.LC97@ha
	stw 0,8(1)
	la 11,.LC97@l(11)
	lfd 0,8(1)
	lfd 13,0(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	cror 3,2,1
	bc 4,3,.L410
	li 9,0
	li 0,0
	stw 0,732(31)
	stw 9,428(31)
	stw 9,384(31)
	stw 9,380(31)
	stw 9,376(31)
	b .L407
.L410:
	lwz 0,264(31)
	andi. 9,0,1024
	bc 4,2,.L412
	lwz 5,700(31)
	cmpwi 0,5,0
	bc 12,2,.L413
	lis 11,.LC98@ha
	lis 9,gi+16@ha
	la 11,.LC98@l(11)
	lwz 0,gi+16@l(9)
	mr 3,31
	lfs 1,0(11)
	lis 9,.LC99@ha
	li 4,10
	lis 11,.LC96@ha
	la 9,.LC99@l(9)
	mtlr 0
	la 11,.LC96@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L413:
	lwz 0,704(31)
	stw 0,76(31)
.L412:
	lis 11,game+1544@ha
	li 30,0
	lwz 0,game+1544@l(11)
	lis 9,.LC94@ha
	lfs 12,.LC94@l(9)
	cmpw 0,30,0
	bc 4,0,.L415
	lis 11,g_edicts@ha
	mtctr 0
	lwz 9,g_edicts@l(11)
	addi 9,9,1084
.L417:
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L416
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L416
	lfs 0,220(9)
	fcmpu 0,0,12
	bc 4,0,.L416
	fmr 12,0
	mr 30,9
.L416:
	addi 9,9,1084
	bdnz .L417
.L415:
	cmpwi 0,30,0
	bc 12,2,.L407
	lfs 0,232(31)
	lfs 13,332(31)
	fsubs 31,12,0
	fcmpu 0,31,13
	bc 4,0,.L422
	lis 9,.LC100@ha
	lis 0,0x40a0
	la 9,.LC100@l(9)
	stw 0,716(31)
	lfs 31,0(9)
	b .L423
.L422:
	fdivs 0,31,13
	stfs 0,716(31)
.L423:
	lis 11,.LC101@ha
	lfs 13,716(31)
	la 11,.LC101@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 12,0,.L436
	lfs 0,328(31)
	fcmpu 0,13,0
	bc 4,1,.L425
.L436:
	stfs 0,716(31)
.L425:
	lfs 1,716(31)
	li 0,0
	lis 9,0x3f80
	stw 0,740(31)
	addi 3,31,736
	addi 4,31,376
	stw 0,736(31)
	stw 9,744(31)
	bl VectorScale
	lwz 0,732(31)
	stfs 31,760(31)
	cmpwi 0,0,2
	bc 12,2,.L427
	mr 4,30
	mr 3,31
	bl G_UseTargets
	li 30,0
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L429
	b .L430
.L432:
	lwz 3,280(30)
	lis 4,.LC83@ha
	la 4,.LC83@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L430
	lis 9,gi+64@ha
	lwz 3,644(30)
	li 4,1
	lwz 0,gi+64@l(9)
	mtlr 0
	blrl
.L430:
	lwz 5,296(31)
	mr 3,30
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L432
.L429:
	li 0,2
	stw 0,732(31)
.L427:
	lis 9,smart_water_go_up@ha
	lis 10,level+4@ha
	la 9,smart_water_go_up@l(9)
	lis 11,.LC95@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC95@l(11)
	fadd 0,0,13
	frsp 0,0
.L435:
	stfs 0,428(31)
.L407:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 smart_water_go_up,.Lfe22-smart_water_go_up
	.section	".rodata"
	.align 3
.LC102:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC103:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl Touch_DoorTrigger
	.type	 Touch_DoorTrigger,@function
Touch_DoorTrigger:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,4
	lwz 0,480(29)
	cmpwi 0,0,0
	bc 4,1,.L452
	lwz 0,184(29)
	andi. 9,0,4
	mcrf 7,0
	bc 4,30,.L454
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L452
.L454:
	lwz 31,256(3)
	lwz 0,284(31)
	andi. 11,0,8
	bc 12,2,.L455
	bc 4,30,.L452
.L455:
	lis 9,level+4@ha
	lfs 0,460(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L452
	lis 9,.LC102@ha
	fmr 0,13
	la 9,.LC102@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,460(3)
	lwz 0,264(31)
	andi. 11,0,1024
	bc 4,2,.L452
	lwz 0,284(31)
	andi. 9,0,32
	bc 12,2,.L459
	lwz 0,732(31)
	subfic 11,0,0
	adde 9,11,0
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L459
	mr. 31,31
	bc 12,2,.L452
	li 30,0
.L463:
	stw 30,276(31)
	mr 3,31
	stw 30,444(31)
	bl door_go_down
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L463
	b .L452
.L459:
	lfs 0,200(31)
	lis 9,.LC103@ha
	addi 3,1,8
	lfs 13,188(31)
	la 9,.LC103@l(9)
	mr 4,3
	lfs 1,0(9)
	fadds 13,13,0
	stfs 13,8(1)
	lfs 13,204(31)
	lfs 0,192(31)
	fadds 0,0,13
	stfs 0,12(1)
	lfs 0,208(31)
	lfs 13,196(31)
	fadds 13,13,0
	stfs 13,16(1)
	bl VectorScale
	lis 9,gi+52@ha
	addi 3,1,8
	lwz 0,gi+52@l(9)
	mtlr 0
	blrl
	andi. 0,3,56
	bc 12,2,.L466
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L466
	li 0,0
	stw 29,540(31)
	mr 3,31
	stw 0,444(31)
	stw 0,276(31)
	bl smart_water_go_up
	b .L452
.L466:
	mr. 31,31
	bc 12,2,.L452
	li 30,0
.L469:
	stw 30,276(31)
	mr 3,31
	mr 4,29
	stw 30,444(31)
	bl door_go_up
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L469
.L452:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe23:
	.size	 Touch_DoorTrigger,.Lfe23-Touch_DoorTrigger
	.section	".rodata"
	.align 2
.LC104:
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
	bc 4,2,.L489
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
	bc 12,2,.L492
	addi 30,1,24
.L494:
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
	bc 4,2,.L494
.L492:
	lis 9,.LC104@ha
	lfs 10,8(1)
	la 9,.LC104@l(9)
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
	bc 12,2,.L496
	lwz 0,296(29)
	li 31,0
	cmpwi 0,0,0
	bc 12,2,.L496
	mr 28,30
	lis 30,.LC83@ha
	b .L499
.L501:
	lwz 3,280(31)
	la 4,.LC83@l(30)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L499
	lwz 9,64(28)
	li 4,1
	lwz 3,644(31)
	mtlr 9
	blrl
.L499:
	lwz 5,296(29)
	mr 3,31
	li 4,300
	bl G_Find
	mr. 31,3
	bc 4,2,.L501
.L496:
	lwz 0,264(29)
	andi. 9,0,1024
	bc 4,2,.L489
	lwz 9,560(29)
	lfs 0,724(29)
	cmpwi 0,9,0
	lfs 12,716(29)
	fabs 13,0
	bc 12,2,.L511
.L508:
	lfs 0,724(9)
	fabs 0,0
	fcmpu 0,0,13
	bc 4,0,.L510
	fmr 13,0
.L510:
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L508
.L511:
	mr. 9,29
	fdivs 0,13,12
	bc 12,2,.L489
	fmr 9,0
.L514:
	lfs 0,724(9)
	lfs 13,716(9)
	lfs 11,712(9)
	fcmpu 0,11,13
	fabs 0,0
	fdiv 0,0,9
	frsp 12,0
	fdivs 10,12,13
	bc 4,2,.L515
	stfs 12,712(9)
	b .L516
.L515:
	fmuls 0,11,10
	stfs 0,712(9)
.L516:
	lfs 13,720(9)
	lfs 0,716(9)
	fcmpu 0,13,0
	bc 4,2,.L517
	stfs 12,720(9)
	b .L518
.L517:
	fmuls 0,13,10
	stfs 0,720(9)
.L518:
	stfs 12,716(9)
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L514
.L489:
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe24:
	.size	 Think_SpawnDoorTrigger,.Lfe24-Think_SpawnDoorTrigger
	.section	".rodata"
	.align 2
.LC105:
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
	bc 4,2,.L522
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L522
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
	bc 12,2,.L521
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L521
	mr 3,31
	bl BecomeExplosion1
	b .L521
.L522:
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
	bc 4,2,.L521
	lis 9,.LC105@ha
	lfs 13,728(30)
	la 9,.LC105@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L521
	lwz 0,732(30)
	cmpwi 0,0,3
	bc 4,2,.L526
	lwz 31,564(30)
	cmpwi 0,31,0
	bc 12,2,.L521
.L530:
	lwz 4,548(31)
	mr 3,31
	bl door_go_up
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L530
	b .L521
.L526:
	lwz 31,564(30)
	cmpwi 0,31,0
	bc 12,2,.L521
.L536:
	mr 3,31
	bl door_go_down
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L536
.L521:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 door_blocked,.Lfe25-door_blocked
	.section	".rodata"
	.align 2
.LC106:
	.string	"%s"
	.align 2
.LC107:
	.string	"misc/talk1.wav"
	.align 2
.LC108:
	.string	"doors/dr1_strt.wav"
	.align 2
.LC109:
	.string	"doors/dr1_mid.wav"
	.align 2
.LC110:
	.string	"doors/dr1_end.wav"
	.align 2
.LC111:
	.string	"misc/talk.wav"
	.align 3
.LC112:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC113:
	.long 0x0
	.align 3
.LC114:
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
	bc 12,2,.L563
	lis 29,gi@ha
	lis 3,.LC108@ha
	la 29,gi@l(29)
	la 3,.LC108@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,700(31)
	lwz 9,36(29)
	lis 3,.LC109@ha
	la 3,.LC109@l(3)
	mtlr 9
	blrl
	stw 3,704(31)
	lwz 0,36(29)
	lis 3,.LC110@ha
	la 3,.LC110@l(3)
	mtlr 0
	blrl
	stw 3,708(31)
.L563:
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
	lis 8,.LC113@ha
	lfs 0,328(31)
	lis 9,door_blocked@ha
	la 8,.LC113@l(8)
	lis 11,door_use@ha
	lfs 13,0(8)
	la 9,door_blocked@l(9)
	la 11,door_use@l(11)
	stw 9,440(31)
	stw 11,448(31)
	fcmpu 0,0,13
	bc 4,2,.L564
	lis 0,0x42c8
	stw 0,328(31)
.L564:
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L565
	lfs 0,328(31)
	fadds 0,0,0
	stfs 0,328(31)
.L565:
	lfs 0,332(31)
	fcmpu 0,0,13
	bc 4,2,.L566
	lfs 0,328(31)
	stfs 0,332(31)
.L566:
	lfs 0,336(31)
	fcmpu 0,0,13
	bc 4,2,.L567
	lfs 0,328(31)
	stfs 0,336(31)
.L567:
	lfs 0,592(31)
	fcmpu 0,0,13
	bc 4,2,.L568
	lis 0,0x4040
	stw 0,592(31)
.L568:
	lis 9,st@ha
	la 10,st@l(9)
	lwz 0,24(10)
	cmpwi 0,0,0
	bc 4,2,.L569
	li 0,8
	stw 0,24(10)
.L569:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L570
	stw 30,516(31)
.L570:
	lfs 12,4(31)
	lis 11,0x4330
	lfs 13,8(31)
	lis 8,.LC114@ha
	mr 4,29
	lfs 0,12(31)
	la 8,.LC114@l(8)
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
	bc 12,2,.L571
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
.L571:
	lwz 0,480(31)
	li 11,1
	stw 11,732(31)
	cmpwi 0,0,0
	bc 12,2,.L572
	lis 9,door_killed@ha
	stw 11,512(31)
	la 9,door_killed@l(9)
	stw 0,484(31)
	stw 9,456(31)
	b .L573
.L572:
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L573
	lwz 0,276(31)
	cmpwi 0,0,0
	bc 12,2,.L573
	lwz 0,36(28)
	lis 3,.LC111@ha
	la 3,.LC111@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,444(31)
.L573:
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
	bc 12,2,.L575
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L575:
	lwz 0,284(31)
	andi. 9,0,64
	bc 12,2,.L576
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L576:
	lwz 0,308(31)
	cmpwi 0,0,0
	bc 4,2,.L577
	stw 31,564(31)
.L577:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC112@ha
	lwz 0,480(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC112@l(11)
	cmpwi 0,0,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 4,2,.L579
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L578
.L579:
	lis 9,Think_CalcMoveSpeed@ha
	la 9,Think_CalcMoveSpeed@l(9)
	b .L581
.L578:
	lis 9,Think_SpawnDoorTrigger@ha
	la 9,Think_SpawnDoorTrigger@l(9)
.L581:
	stw 9,436(31)
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe26:
	.size	 SP_func_door,.Lfe26-SP_func_door
	.section	".rodata"
	.align 2
.LC116:
	.string	"%s at %s with no distance set\n"
	.align 3
.LC117:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC118:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC119:
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
	bc 12,2,.L587
	lis 0,0x3f80
	stw 0,348(31)
	b .L588
.L587:
	andi. 0,9,128
	bc 12,2,.L589
	lis 0,0x3f80
	stw 0,340(31)
	b .L588
.L589:
	lis 0,0x3f80
	stw 0,344(31)
.L588:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L591
	lfs 0,340(31)
	lfs 13,344(31)
	lfs 12,348(31)
	fneg 0,0
	fneg 13,13
	fneg 12,12
	stfs 0,340(31)
	stfs 13,344(31)
	stfs 12,348(31)
.L591:
	lis 9,st@ha
	la 30,st@l(9)
	lwz 0,28(30)
	cmpwi 0,0,0
	bc 4,2,.L592
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC116@ha
	mtlr 0
	la 3,.LC116@l(3)
	crxor 6,6,6
	blrl
	li 0,90
	stw 0,28(30)
.L592:
	lfs 13,20(31)
	lis 29,0x4330
	lfs 12,16(31)
	lis 11,.LC118@ha
	addi 3,31,16
	lfs 0,24(31)
	la 11,.LC118@l(11)
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
	lis 9,.LC119@ha
	lfs 0,328(31)
	lis 11,door_use@ha
	la 9,.LC119@l(9)
	la 11,door_use@l(11)
	lfs 13,0(9)
	lis 9,door_blocked@ha
	stw 11,448(31)
	la 9,door_blocked@l(9)
	fcmpu 0,0,13
	stw 9,440(31)
	bc 4,2,.L593
	lis 0,0x42c8
	stw 0,328(31)
.L593:
	lfs 0,332(31)
	fcmpu 0,0,13
	bc 4,2,.L594
	lfs 0,328(31)
	stfs 0,332(31)
.L594:
	lfs 0,336(31)
	fcmpu 0,0,13
	bc 4,2,.L595
	lfs 0,328(31)
	stfs 0,336(31)
.L595:
	lfs 0,592(31)
	fcmpu 0,0,13
	bc 4,2,.L596
	lis 0,0x4040
	stw 0,592(31)
.L596:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L597
	stw 28,516(31)
.L597:
	lwz 0,528(31)
	cmpwi 0,0,1
	bc 12,2,.L598
	lwz 9,36(30)
	lis 3,.LC108@ha
	la 3,.LC108@l(3)
	mtlr 9
	blrl
	stw 3,700(31)
	lwz 9,36(30)
	lis 3,.LC109@ha
	la 3,.LC109@l(3)
	mtlr 9
	blrl
	stw 3,704(31)
	lwz 9,36(30)
	lis 3,.LC110@ha
	la 3,.LC110@l(3)
	mtlr 9
	blrl
	stw 3,708(31)
.L598:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L599
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
.L599:
	lwz 11,480(31)
	cmpwi 0,11,0
	bc 12,2,.L600
	lis 9,door_killed@ha
	li 0,1
	stw 11,484(31)
	la 9,door_killed@l(9)
	stw 0,512(31)
	stw 9,456(31)
.L600:
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L601
	lwz 0,276(31)
	cmpwi 0,0,0
	bc 12,2,.L601
	lwz 0,36(30)
	lis 3,.LC111@ha
	la 3,.LC111@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,444(31)
.L601:
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
	bc 12,2,.L602
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L602:
	lwz 0,308(31)
	cmpwi 0,0,0
	bc 4,2,.L603
	stw 31,564(31)
.L603:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC117@ha
	lwz 0,480(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC117@l(11)
	cmpwi 0,0,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 4,2,.L605
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L604
.L605:
	lis 9,Think_CalcMoveSpeed@ha
	la 9,Think_CalcMoveSpeed@l(9)
	b .L608
.L604:
	lis 9,Think_SpawnDoorTrigger@ha
	la 9,Think_SpawnDoorTrigger@l(9)
.L608:
	stw 9,436(31)
	lwz 0,284(31)
	andi. 9,0,8192
	bc 12,2,.L607
	lis 9,Door_Activate@ha
	li 0,0
	la 9,Door_Activate@l(9)
	li 11,0
	stw 0,436(31)
	stw 9,448(31)
	stw 11,428(31)
	stw 0,512(31)
	stw 0,456(31)
.L607:
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
.LC120:
	.string	"world/mov_watr.wav"
	.align 2
.LC121:
	.string	"world/stp_watr.wav"
	.align 3
.LC122:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC123:
	.long 0x0
	.align 2
.LC124:
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
	bc 12,2,.L615
	cmpwi 0,0,2
	bc 4,2,.L613
.L615:
	lwz 9,36(30)
	lis 3,.LC120@ha
	la 3,.LC120@l(3)
	mtlr 9
	blrl
	stw 3,700(31)
	lwz 0,36(30)
	lis 3,.LC121@ha
	la 3,.LC121@l(3)
	mtlr 0
	blrl
	stw 3,708(31)
.L613:
	lfs 12,4(31)
	lis 11,st+24@ha
	lfs 13,8(31)
	lis 10,0x4330
	lis 8,.LC122@ha
	lfs 0,12(31)
	la 8,.LC122@l(8)
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
	bc 12,2,.L618
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
.L618:
	lis 9,.LC123@ha
	lfs 0,328(31)
	li 0,1
	la 9,.LC123@l(9)
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
	bc 4,2,.L619
	lis 0,0x41c8
	stw 0,328(31)
.L619:
	lwz 0,284(31)
	lfs 0,328(31)
	andi. 8,0,2
	stfs 0,712(31)
	stfs 0,716(31)
	stfs 0,720(31)
	bc 12,2,.L620
	lfs 0,332(31)
	fcmpu 0,0,5
	bc 4,2,.L621
	lis 0,0x41a0
	stw 0,332(31)
.L621:
	lis 9,smart_water_blocked@ha
	la 9,smart_water_blocked@l(9)
	stw 9,440(31)
.L620:
	lis 9,.LC123@ha
	lfs 13,592(31)
	la 9,.LC123@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L622
	lis 0,0xbf80
	stw 0,592(31)
.L622:
	lis 8,.LC124@ha
	lfs 13,592(31)
	lis 9,door_use@ha
	la 8,.LC124@l(8)
	la 9,door_use@l(9)
	lfs 0,0(8)
	stw 9,448(31)
	stfs 13,728(31)
	fcmpu 0,13,0
	bc 4,2,.L623
	lwz 0,284(31)
	ori 0,0,32
	stw 0,284(31)
.L623:
	lis 9,.LC84@ha
	lis 11,gi+72@ha
	la 9,.LC84@l(9)
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
.Lfe28:
	.size	 SP_func_water,.Lfe28-SP_func_water
	.section	".rodata"
	.align 2
.LC125:
	.long 0x0
	.align 2
.LC126:
	.long 0x3f800000
	.align 2
.LC127:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl train_wait
	.type	 train_wait,@function
train_wait:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 30,324(31)
	lwz 0,312(30)
	cmpwi 0,0,0
	bc 12,2,.L630
	lwz 29,296(30)
	mr 3,30
	stw 0,296(30)
	lwz 4,548(31)
	bl G_UseTargets
	stw 29,296(30)
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L629
.L630:
	lis 9,.LC125@ha
	lfs 13,728(31)
	la 9,.LC125@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L632
	bc 4,1,.L633
	lis 9,level+4@ha
	lis 11,train_next@ha
	lfs 0,level+4@l(9)
	la 11,train_next@l(11)
	stw 11,436(31)
	fadds 0,0,13
	stfs 0,428(31)
	b .L634
.L633:
	lwz 9,284(31)
	andi. 0,9,2
	bc 12,2,.L634
	li 0,0
	rlwinm 9,9,0,0,30
	stfs 0,428(31)
	stw 0,324(31)
	stw 9,284(31)
	stfs 0,384(31)
	stfs 0,380(31)
	stfs 0,376(31)
.L634:
	lwz 0,264(31)
	andi. 30,0,1024
	bc 4,2,.L629
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L637
	lis 9,gi+16@ha
	mr 3,31
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC126@ha
	la 9,.LC126@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC127@ha
	la 9,.LC127@l(9)
	lfs 2,0(9)
	lis 9,.LC125@ha
	la 9,.LC125@l(9)
	lfs 3,0(9)
	blrl
.L637:
	stw 30,76(31)
	b .L629
.L632:
	mr 3,31
	bl train_next
.L629:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 train_wait,.Lfe29-train_wait
	.section	".rodata"
	.align 2
.LC128:
	.string	"train_next: bad target %s\n"
	.align 2
.LC129:
	.string	"connected teleport path_corners, see %s at %s\n"
	.align 3
.LC130:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC131:
	.long 0x0
	.align 2
.LC132:
	.long 0x3f800000
	.align 2
.LC133:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl train_next
	.type	 train_next,@function
train_next:
	stwu 1,-96(1)
	mflr 0
	stfd 31,88(1)
	stmw 25,60(1)
	stw 0,100(1)
	mr 28,3
	li 30,1
.L641:
	lwz 3,296(28)
	cmpwi 0,3,0
	bc 12,2,.L640
	bl G_PickTarget
	mr. 31,3
	bc 4,2,.L643
	lis 9,gi+4@ha
	lis 3,.LC128@ha
	lwz 4,296(28)
	lwz 0,gi+4@l(9)
	la 3,.LC128@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L640
.L643:
	lwz 0,296(31)
	stw 0,296(28)
	lwz 9,284(31)
	andi. 0,9,1
	bc 12,2,.L644
	cmpwi 0,30,0
	bc 4,2,.L645
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC129@ha
	la 3,.LC129@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L640
.L645:
	lfs 12,4(31)
	li 0,7
	lis 9,gi+72@ha
	lfs 0,188(28)
	mr 3,28
	li 30,0
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
	b .L641
.L644:
	lis 9,.LC131@ha
	lfs 0,328(31)
	la 9,.LC131@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L646
	stfs 0,328(28)
	lfs 0,328(31)
	stfs 0,716(28)
	lfs 0,332(31)
	fcmpu 0,0,13
	bc 4,2,.L673
	lfs 0,328(31)
.L673:
	stfs 0,712(28)
	lis 11,.LC131@ha
	lfs 13,336(31)
	la 11,.LC131@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 12,2,.L649
	stfs 13,720(28)
	b .L650
.L649:
	lfs 0,328(31)
	stfs 0,720(28)
.L650:
	li 0,0
	stw 0,748(28)
.L646:
	lwz 0,264(28)
	lfs 0,592(31)
	andi. 9,0,1024
	stw 31,324(28)
	stfs 0,728(28)
	bc 4,2,.L651
	lwz 5,700(28)
	cmpwi 0,5,0
	bc 12,2,.L652
	lis 11,.LC132@ha
	lis 9,gi+16@ha
	la 11,.LC132@l(11)
	lwz 0,gi+16@l(9)
	mr 3,28
	lfs 1,0(11)
	lis 9,.LC133@ha
	li 4,10
	lis 11,.LC131@ha
	la 9,.LC133@l(9)
	mtlr 0
	la 11,.LC131@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L652:
	lwz 0,704(28)
	stw 0,76(28)
.L651:
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
	bc 4,2,.L653
	lfs 0,720(28)
	fcmpu 0,13,0
	bc 4,2,.L653
	lwz 0,264(28)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L654
	lwz 0,564(28)
	cmpw 0,9,0
	bc 12,2,.L655
	b .L656
.L654:
	cmpw 0,9,28
	bc 4,2,.L656
.L655:
	mr 3,28
	bl Move_Begin
	b .L659
.L656:
	lis 11,level+4@ha
	lis 10,.LC130@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC130@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(28)
	b .L674
.L653:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(28)
	lis 10,level+4@ha
	stw 9,436(28)
	lis 11,.LC130@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC130@l(11)
.L674:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(28)
.L659:
	lwz 9,308(28)
	lwz 0,284(28)
	cmpwi 0,9,0
	ori 0,0,1
	stw 0,284(28)
	bc 12,2,.L640
	lfs 11,4(28)
	lfs 13,8(1)
	lfs 10,8(28)
	lfs 12,12(1)
	fsubs 13,13,11
	lfs 0,16(1)
	lfs 11,12(28)
	lwz 29,560(28)
	fsubs 12,12,10
	stfs 13,24(1)
	fsubs 0,0,11
	cmpwi 0,29,0
	stfs 12,28(1)
	stfs 0,32(1)
	bc 12,2,.L640
	lis 9,.LC130@ha
	lis 11,train_piece_wait@ha
	lfd 31,.LC130@l(9)
	la 25,train_piece_wait@l(11)
	li 31,0
	lis 9,level@ha
	lis 11,Move_Begin@ha
	la 30,level@l(9)
	la 26,Move_Begin@l(11)
	lis 9,Think_AccelMove@ha
	la 27,Think_AccelMove@l(9)
.L664:
	lfs 11,24(1)
	li 0,0
	li 9,2
	lfs 0,4(29)
	addi 3,29,736
	lfs 13,28(1)
	lfs 12,32(1)
	fadds 11,11,0
	stfs 11,40(1)
	lfs 0,8(29)
	fadds 13,13,0
	stfs 13,44(1)
	lfs 0,12(29)
	fadds 12,12,0
	stfs 12,48(1)
	lfs 11,4(29)
	lfs 10,8(29)
	lfs 9,12(29)
	stfs 11,652(29)
	stfs 10,656(29)
	stfs 9,660(29)
	lfs 0,40(1)
	stfs 0,676(29)
	lfs 13,44(1)
	stfs 13,680(29)
	lfs 12,48(1)
	stw 0,732(29)
	stfs 12,684(29)
	lfs 0,328(28)
	stfs 0,328(29)
	lfs 13,716(28)
	stfs 13,716(29)
	lfs 0,712(28)
	stfs 0,712(29)
	lfs 13,720(28)
	stw 9,260(29)
	stw 31,384(29)
	stfs 13,720(29)
	stw 31,380(29)
	stw 31,376(29)
	lfs 0,40(1)
	fsubs 0,0,11
	stfs 0,736(29)
	lfs 13,44(1)
	fsubs 13,13,10
	stfs 13,740(29)
	lfs 0,48(1)
	fsubs 0,0,9
	stfs 0,744(29)
	bl VectorNormalize
	lfs 13,716(29)
	lfs 0,712(29)
	stfs 1,760(29)
	stw 25,768(29)
	fcmpu 0,13,0
	bc 4,2,.L665
	lfs 0,720(29)
	fcmpu 0,13,0
	bc 4,2,.L665
	lwz 0,264(29)
	lwz 9,292(30)
	andi. 11,0,1024
	bc 12,2,.L666
	lwz 0,564(29)
	cmpw 0,9,0
	bc 12,2,.L667
	b .L668
.L666:
	cmpw 0,9,29
	bc 4,2,.L668
.L667:
	mr 3,29
	bl Move_Begin
	b .L663
.L668:
	lfs 0,4(30)
	stw 26,436(29)
	b .L675
.L665:
	stw 31,748(29)
	stw 27,436(29)
	lfs 0,4(30)
.L675:
	fadd 0,0,31
	frsp 0,0
	stfs 0,428(29)
.L663:
	lwz 29,560(29)
	cmpwi 0,29,0
	bc 4,2,.L664
.L640:
	lwz 0,100(1)
	mtlr 0
	lmw 25,60(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe30:
	.size	 train_next,.Lfe30-train_next
	.section	".rodata"
	.align 3
.LC134:
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
	bc 4,2,.L677
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L677
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L678
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L679
	b .L680
.L678:
	cmpw 0,9,31
	bc 4,2,.L680
.L679:
	mr 3,31
	bl Move_Begin
	b .L683
.L680:
	lis 11,level+4@ha
	lis 10,.LC134@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC134@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L684
.L677:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC134@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC134@l(11)
.L684:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L683:
	lwz 0,284(31)
	ori 0,0,1
	stw 0,284(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe31:
	.size	 train_resume,.Lfe31-train_resume
	.section	".rodata"
	.align 2
.LC135:
	.string	"train_find: no target\n"
	.align 2
.LC136:
	.string	"train_find: target %s not found\n"
	.align 2
.LC139:
	.string	"func_train without a target at %s\n"
	.align 3
.LC138:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC140:
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
	bc 4,2,.L704
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L698
	li 0,100
.L704:
	stw 0,516(31)
.L698:
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
	bc 12,2,.L700
	lwz 9,36(30)
	mtlr 9
	blrl
	stw 3,704(31)
.L700:
	lis 8,.LC140@ha
	lfs 13,328(31)
	la 8,.LC140@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,2,.L701
	lis 0,0x42c8
	stw 0,328(31)
.L701:
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
	bc 12,2,.L702
	lis 11,level+4@ha
	lis 10,.LC138@ha
	lfs 0,level+4@l(11)
	lis 9,func_train_find@ha
	lfd 13,.LC138@l(10)
	la 9,func_train_find@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	b .L703
.L702:
	addi 3,31,212
	bl vtos
	mr 4,3
	lwz 0,4(30)
	lis 3,.LC139@ha
	la 3,.LC139@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L703:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe32:
	.size	 SP_func_train,.Lfe32-SP_func_train
	.section	".rodata"
	.align 2
.LC141:
	.string	"elevator used with no pathtarget\n"
	.align 2
.LC142:
	.string	"elevator used with bad pathtarget: %s\n"
	.align 2
.LC143:
	.string	"trigger_elevator has no target\n"
	.align 2
.LC144:
	.string	"trigger_elevator unable to find target %s\n"
	.align 2
.LC145:
	.string	"func_train"
	.align 2
.LC146:
	.string	"trigger_elevator target %s is not a train\n"
	.align 2
.LC151:
	.string	"func_timer at %s has random >= wait\n"
	.align 3
.LC150:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC152:
	.long 0x46fffe00
	.align 2
.LC153:
	.long 0x0
	.align 3
.LC154:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC155:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC156:
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
	lis 9,.LC153@ha
	mr 31,3
	la 9,.LC153@l(9)
	lfs 0,592(31)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L721
	lis 0,0x3f80
	stw 0,592(31)
.L721:
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
	bc 4,3,.L722
	fmr 0,13
	lis 9,.LC150@ha
	lis 29,gi@ha
	lfd 13,.LC150@l(9)
	la 29,gi@l(29)
	addi 3,31,4
	fsub 0,0,13
	frsp 0,0
	stfs 0,600(31)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC151@ha
	la 3,.LC151@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L722:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L723
	bl rand
	rlwinm 3,3,0,17,31
	lfs 8,596(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	lfs 9,592(31)
	stw 3,28(1)
	lis 11,.LC154@ha
	lis 8,.LC152@ha
	la 11,.LC154@l(11)
	stw 0,24(1)
	lis 10,st+40@ha
	lfd 10,0(11)
	lfd 12,24(1)
	lis 11,level+4@ha
	lfs 6,.LC152@l(8)
	lis 9,.LC155@ha
	lfs 13,level+4@l(11)
	la 9,.LC155@l(9)
	fsub 12,12,10
	lfd 0,0(9)
	lfs 11,st+40@l(10)
	lis 9,.LC156@ha
	la 9,.LC156@l(9)
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
.L723:
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
.LC157:
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
	bc 12,2,.L731
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
	bc 4,2,.L733
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L733
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L734
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L735
	b .L736
.L734:
	cmpw 0,9,31
	bc 4,2,.L736
.L735:
	mr 3,31
	bl Move_Begin
	b .L739
.L736:
	lis 11,level+4@ha
	lis 10,.LC157@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC157@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L747
.L733:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC157@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC157@l(11)
.L747:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L739:
	lwz 0,296(31)
	li 29,0
	cmpwi 0,0,0
	bc 12,2,.L731
	lis 9,gi@ha
	lis 28,.LC83@ha
	la 30,gi@l(9)
	b .L742
.L744:
	lwz 3,280(29)
	la 4,.LC83@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L742
	lwz 9,64(30)
	li 4,1
	lwz 3,644(29)
	mtlr 9
	blrl
.L742:
	lwz 5,296(31)
	mr 3,29
	li 4,300
	bl G_Find
	mr. 29,3
	bc 4,2,.L744
.L731:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 door_secret_use,.Lfe34-door_secret_use
	.section	".rodata"
	.align 3
.LC158:
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
	bc 4,2,.L750
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L750
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L751
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L752
	b .L753
.L751:
	cmpw 0,9,31
	bc 4,2,.L753
.L752:
	mr 3,31
	bl Move_Begin
	b .L756
.L753:
	lis 11,level+4@ha
	lis 10,.LC158@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC158@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L757
.L750:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC158@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC158@l(11)
.L757:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L756:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 door_secret_move2,.Lfe35-door_secret_move2
	.section	".rodata"
	.align 3
.LC159:
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
	bc 4,2,.L761
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L761
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L762
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L763
	b .L764
.L762:
	cmpw 0,9,31
	bc 4,2,.L764
.L763:
	mr 3,31
	bl Move_Begin
	b .L767
.L764:
	lis 11,level+4@ha
	lis 10,.LC159@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC159@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L768
.L761:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC159@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC159@l(11)
.L768:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L767:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 door_secret_move4,.Lfe36-door_secret_move4
	.section	".rodata"
	.align 3
.LC160:
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
	bc 4,2,.L771
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L771
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L772
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L773
	b .L774
.L772:
	cmpw 0,9,31
	bc 4,2,.L774
.L773:
	mr 3,31
	bl Move_Begin
	b .L777
.L774:
	lis 11,level+4@ha
	lis 10,.LC160@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC160@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L778
.L771:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC160@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC160@l(11)
.L778:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L777:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe37:
	.size	 door_secret_move6,.Lfe37-door_secret_move6
	.section	".rodata"
	.align 2
.LC161:
	.long 0x0
	.align 3
.LC162:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC163:
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
	lis 3,.LC108@ha
	lwz 9,36(29)
	la 3,.LC108@l(3)
	mtlr 9
	blrl
	stw 3,700(31)
	lwz 9,36(29)
	lis 3,.LC109@ha
	la 3,.LC109@l(3)
	mtlr 9
	blrl
	stw 3,704(31)
	lwz 9,36(29)
	lis 3,.LC110@ha
	la 3,.LC110@l(3)
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
	bc 12,2,.L796
	lwz 0,284(31)
	andi. 7,0,1
	bc 12,2,.L795
.L796:
	lis 9,door_secret_die@ha
	li 11,0
	la 9,door_secret_die@l(9)
	li 0,1
	stw 11,480(31)
	stw 0,512(31)
	stw 9,456(31)
.L795:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L797
	li 0,2
	stw 0,516(31)
.L797:
	lis 9,.LC161@ha
	lfs 0,592(31)
	la 9,.LC161@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L798
	lis 0,0x40a0
	stw 0,592(31)
.L798:
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
	lis 7,.LC162@ha
	mr 8,29
	stfs 31,16(31)
	rlwinm 0,11,0,30,30
	la 7,.LC162@l(7)
	stfs 31,24(31)
	xoris 0,0,0x8000
	lfd 12,0(7)
	mr 4,28
	stw 0,68(1)
	lis 7,.LC163@ha
	stw 10,64(1)
	la 7,.LC163@l(7)
	andi. 0,11,4
	lfd 0,64(1)
	lfd 13,0(7)
	stfs 31,20(31)
	fsub 0,0,12
	fsub 13,13,0
	frsp 7,13
	bc 12,2,.L799
	lfs 0,240(31)
	lfs 12,44(1)
	lfs 10,236(31)
	lfs 13,40(1)
	fmr 8,0
	fmuls 12,12,0
	lfs 11,244(31)
	lfs 0,48(1)
	b .L806
.L799:
	lfs 0,240(31)
	lfs 12,28(1)
	lfs 10,236(31)
	lfs 13,24(1)
	fmr 8,0
	fmuls 12,12,0
	lfs 11,244(31)
	lfs 0,32(1)
.L806:
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
	bc 12,2,.L801
	fneg 1,1
	addi 29,31,352
	addi 3,31,4
	b .L807
.L801:
	fmuls 1,7,1
	addi 29,31,352
	addi 3,31,4
	mr 4,8
.L807:
	mr 5,29
	bl VectorMA
	mr 3,29
	fmr 1,31
	addi 4,1,8
	addi 5,31,364
	bl VectorMA
	lwz 11,480(31)
	cmpwi 0,11,0
	bc 12,2,.L803
	lis 9,door_killed@ha
	li 0,1
	stw 11,484(31)
	la 9,door_killed@l(9)
	stw 0,512(31)
	stw 9,456(31)
	b .L804
.L803:
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L804
	lwz 0,276(31)
	cmpwi 0,0,0
	bc 12,2,.L804
	lis 9,gi+36@ha
	lis 3,.LC111@ha
	lwz 0,gi+36@l(9)
	la 3,.LC111@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,444(31)
.L804:
	lis 9,.LC84@ha
	lis 11,gi+72@ha
	la 9,.LC84@l(9)
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
.Lfe38:
	.size	 SP_func_door_secret,.Lfe38-SP_func_door_secret
	.section	".rodata"
	.align 2
.LC164:
	.long 0x42800000
	.align 2
.LC165:
	.long 0x0
	.section	".text"
	.align 2
	.globl plat2_spawn_danger_area
	.type	 plat2_spawn_danger_area,@function
plat2_spawn_danger_area:
	stwu 1,-48(1)
	mflr 0
	stw 0,52(1)
	lis 11,.LC164@ha
	mr 9,3
	la 11,.LC164@l(11)
	lfs 9,196(9)
	mr 5,9
	lfs 0,0(11)
	addi 3,1,8
	addi 4,1,24
	lis 11,.LC165@ha
	lfs 10,188(9)
	lfs 13,192(9)
	la 11,.LC165@l(11)
	lfs 12,200(9)
	fadds 0,9,0
	lfs 11,204(9)
	lfs 1,0(11)
	stfs 10,8(1)
	stfs 13,12(1)
	stfs 12,24(1)
	stfs 11,28(1)
	stfs 0,32(1)
	stfs 9,16(1)
	bl SpawnBadArea
	lwz 0,52(1)
	mtlr 0
	la 1,48(1)
	blr
.Lfe39:
	.size	 plat2_spawn_danger_area,.Lfe39-plat2_spawn_danger_area
	.align 2
	.globl plat2_kill_danger_area
	.type	 plat2_kill_danger_area,@function
plat2_kill_danger_area:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,3
	li 31,0
	b .L139
.L141:
	lwz 0,256(31)
	cmpw 0,0,30
	bc 4,2,.L139
	bl G_FreeEdict
.L139:
	lis 5,.LC40@ha
	mr 3,31
	la 5,.LC40@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	mr 3,31
	bc 4,2,.L141
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe40:
	.size	 plat2_kill_danger_area,.Lfe40-plat2_kill_danger_area
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
.Lfe41:
	.size	 Move_Done,.Lfe41-Move_Done
	.section	".rodata"
	.align 3
.LC166:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC167:
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
	lis 9,.LC167@ha
	mr 31,3
	la 9,.LC167@l(9)
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
	lis 9,.LC166@ha
	addi 3,31,736
	lfd 31,.LC166@l(9)
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
.Lfe42:
	.size	 Move_Final,.Lfe42-Move_Final
	.section	".rodata"
	.align 3
.LC168:
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
	lis 10,.LC168@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC168@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L810
.L16:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC168@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC168@l(11)
.L810:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L21:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe43:
	.size	 Move_Calc,.Lfe43-Move_Calc
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
.Lfe44:
	.size	 AngleMove_Done,.Lfe44-AngleMove_Done
	.section	".rodata"
	.align 3
.LC169:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC170:
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
	b .L811
.L24:
	lfs 11,16(31)
	lfs 13,664(31)
	lfs 12,668(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,672(31)
.L811:
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
	lis 9,.LC170@ha
	addi 3,1,8
	la 9,.LC170@l(9)
	addi 4,31,388
	lfs 1,0(9)
	bl VectorScale
	lis 9,AngleMove_Done@ha
	lis 10,level+4@ha
	la 9,AngleMove_Done@l(9)
	lis 11,.LC169@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC169@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L23:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe45:
	.size	 AngleMove_Final,.Lfe45-AngleMove_Final
	.section	".rodata"
	.align 3
.LC171:
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
	lfs 13,332(3)
	li 0,0
	lfs 0,328(3)
	stw 4,768(3)
	stw 0,396(3)
	fcmpu 0,13,0
	stw 0,392(3)
	stw 0,388(3)
	bc 12,2,.L45
	stw 0,716(3)
.L45:
	lwz 0,264(3)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L47
	lwz 0,564(3)
	cmpw 0,9,0
	bc 12,2,.L48
	b .L46
.L47:
	cmpw 0,9,3
	bc 4,2,.L46
.L48:
	bl AngleMove_Begin
	b .L49
.L46:
	lis 11,level+4@ha
	lis 10,.LC171@ha
	lfs 0,level+4@l(11)
	lis 9,AngleMove_Begin@ha
	lfd 13,.LC171@l(10)
	la 9,AngleMove_Begin@l(9)
	stw 9,436(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
.L49:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe46:
	.size	 AngleMove_Calc,.Lfe46-AngleMove_Calc
	.section	".rodata"
	.align 2
.LC172:
	.long 0x3f000000
	.align 2
.LC173:
	.long 0x0
	.align 2
.LC174:
	.long 0x3f800000
	.align 2
.LC175:
	.long 0x40800000
	.align 2
.LC176:
	.long 0xc0000000
	.align 3
.LC177:
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
	bc 4,0,.L51
	stfs 9,96(31)
	b .L50
.L51:
	fdivs 0,11,10
	lfs 31,68(31)
	lis 9,.LC172@ha
	la 9,.LC172@l(9)
	lfs 30,0(9)
	lis 9,.LC173@ha
	la 9,.LC173@l(9)
	lfs 12,0(9)
	lis 9,.LC174@ha
	la 9,.LC174@l(9)
	lfs 29,0(9)
	fdivs 13,11,31
	fmadds 0,0,11,11
	fmadds 13,13,11,11
	fmuls 0,0,30
	fmuls 1,13,30
	fsubs 0,9,0
	fsubs 0,0,1
	fcmpu 0,0,12
	bc 4,0,.L52
	fmuls 12,10,31
	lis 9,.LC175@ha
	fadds 31,10,31
	la 9,.LC175@l(9)
	lfs 1,0(9)
	lis 9,.LC176@ha
	fdivs 31,31,12
	la 9,.LC176@l(9)
	lfs 13,0(9)
	fmuls 0,31,1
	fmuls 13,9,13
	fmuls 0,0,13
	fsubs 1,1,0
	bl sqrt
	lis 9,.LC177@ha
	fadds 31,31,31
	lfs 13,68(31)
	la 9,.LC177@l(9)
	lfd 0,0(9)
	fadd 1,1,0
	fdiv 1,1,31
	frsp 1,1
	fdivs 13,1,13
	stfs 1,100(31)
	fadds 13,13,29
	fmuls 1,1,13
	fmuls 1,1,30
.L52:
	stfs 1,112(31)
.L50:
	lwz 0,52(1)
	mtlr 0
	lwz 31,20(1)
	lfd 29,24(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe47:
	.size	 plat_CalcAcceleratedMove,.Lfe47-plat_CalcAcceleratedMove
	.section	".rodata"
	.align 2
.LC178:
	.long 0x3f800000
	.align 2
.LC179:
	.long 0x40400000
	.align 2
.LC180:
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
	bc 4,2,.L73
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L74
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC178@ha
	la 9,.LC178@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC179@ha
	la 9,.LC179@l(9)
	lfs 2,0(9)
	lis 9,.LC180@ha
	la 9,.LC180@l(9)
	lfs 3,0(9)
	blrl
.L74:
	stw 30,76(31)
.L73:
	lis 9,plat_go_down@ha
	li 0,0
	la 9,plat_go_down@l(9)
	stw 0,732(31)
	lis 11,level+4@ha
	stw 9,436(31)
	lis 9,.LC179@ha
	lfs 0,level+4@l(11)
	la 9,.LC179@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe48:
	.size	 plat_hit_top,.Lfe48-plat_hit_top
	.section	".rodata"
	.align 2
.LC181:
	.long 0x3f800000
	.align 2
.LC182:
	.long 0x40400000
	.align 2
.LC183:
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
	bc 4,2,.L76
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L77
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC181@ha
	la 9,.LC181@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC182@ha
	la 9,.LC182@l(9)
	lfs 2,0(9)
	lis 9,.LC183@ha
	la 9,.LC183@l(9)
	lfs 3,0(9)
	blrl
.L77:
	stw 30,76(31)
.L76:
	li 0,1
	mr 3,31
	stw 0,732(31)
	bl plat2_kill_danger_area
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe49:
	.size	 plat_hit_bottom,.Lfe49-plat_hit_bottom
	.align 2
	.globl plat_blocked
	.type	 plat_blocked,@function
plat_blocked:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,4
	mr 30,3
	lwz 0,184(31)
	andi. 9,0,4
	bc 4,2,.L101
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L101
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
	bc 12,2,.L100
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L100
	mr 3,31
	bl BecomeExplosion1
	b .L100
.L101:
	lwz 0,480(31)
	addi 29,31,4
	cmpwi 0,0,0
	bc 12,1,.L103
	li 9,20
	lis 6,vec3_origin@ha
	la 6,vec3_origin@l(6)
	li 0,0
	stw 9,12(1)
	stw 0,8(1)
	mr 3,31
	mr 4,30
	mr 5,30
	mr 7,29
	mr 8,6
	li 9,100
	li 10,1
	bl T_Damage
.L103:
	lis 6,vec3_origin@ha
	lwz 9,516(30)
	li 0,20
	li 11,0
	la 6,vec3_origin@l(6)
	stw 0,12(1)
	stw 11,8(1)
	mr 3,31
	mr 7,29
	mr 4,30
	mr 5,30
	mr 8,6
	li 10,1
	bl T_Damage
	lwz 0,732(30)
	cmpwi 0,0,2
	bc 4,2,.L104
	mr 3,30
	bl plat_go_down
	b .L100
.L104:
	cmpwi 0,0,3
	bc 4,2,.L100
	mr 3,30
	bl plat_go_up
.L100:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe50:
	.size	 plat_blocked,.Lfe50-plat_blocked
	.align 2
	.globl Use_Plat
	.type	 Use_Plat,@function
Use_Plat:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,184(4)
	andi. 9,0,4
	bc 12,2,.L108
	lwz 0,732(3)
	cmpwi 0,0,0
	bc 4,2,.L109
	bl plat_go_down
	b .L107
.L109:
	cmpwi 0,0,1
	bc 4,2,.L107
	bl plat_go_up
	b .L107
.L108:
	lwz 0,436(3)
	cmpwi 0,0,0
	bc 4,2,.L107
	bl plat_go_down
.L107:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe51:
	.size	 Use_Plat,.Lfe51-Use_Plat
	.section	".rodata"
	.align 2
.LC184:
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
	bc 12,2,.L113
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L113
	lwz 3,540(3)
	lwz 0,732(3)
	cmpwi 0,0,1
	bc 4,2,.L116
	bl plat_go_up
	b .L113
.L116:
	cmpwi 0,0,0
	bc 4,2,.L113
	lis 11,.LC184@ha
	lis 9,level+4@ha
	la 11,.LC184@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,428(3)
.L113:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe52:
	.size	 Touch_Plat_Center,.Lfe52-Touch_Plat_Center
	.align 2
	.globl Touch_Plat_Center2
	.type	 Touch_Plat_Center2,@function
Touch_Plat_Center2:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L212
	lwz 0,184(4)
	andi. 9,0,4
	bc 4,2,.L214
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L212
.L214:
	bl plat2_operate
.L212:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe53:
	.size	 Touch_Plat_Center2,.Lfe53-Touch_Plat_Center2
	.align 2
	.globl plat2_blocked
	.type	 plat2_blocked,@function
plat2_blocked:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,4
	mr 30,3
	lwz 0,184(31)
	andi. 9,0,4
	bc 4,2,.L216
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L216
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
	bc 12,2,.L215
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L215
	mr 3,31
	bl BecomeExplosion1
	b .L215
.L216:
	lwz 0,480(31)
	addi 29,31,4
	cmpwi 0,0,0
	bc 12,1,.L218
	li 9,20
	lis 6,vec3_origin@ha
	la 6,vec3_origin@l(6)
	li 0,0
	stw 9,12(1)
	stw 0,8(1)
	mr 3,31
	mr 4,30
	mr 5,30
	mr 7,29
	mr 8,6
	li 9,100
	li 10,1
	bl T_Damage
.L218:
	lis 6,vec3_origin@ha
	lwz 9,516(30)
	li 0,20
	li 11,0
	la 6,vec3_origin@l(6)
	stw 0,12(1)
	stw 11,8(1)
	mr 3,31
	mr 7,29
	mr 4,30
	mr 5,30
	mr 8,6
	li 10,1
	bl T_Damage
	lwz 0,732(30)
	cmpwi 0,0,2
	bc 4,2,.L219
	mr 3,30
	bl plat2_go_down
	b .L215
.L219:
	cmpwi 0,0,3
	bc 4,2,.L215
	mr 3,30
	bl plat2_go_up
.L215:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe54:
	.size	 plat2_blocked,.Lfe54-plat2_blocked
	.section	".rodata"
	.align 2
.LC185:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl Use_Plat2
	.type	 Use_Plat2,@function
Use_Plat2:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 8,3
	mr 4,5
	lwz 0,732(8)
	cmpwi 0,0,1
	bc 12,1,.L222
	lis 9,.LC185@ha
	lfs 0,476(8)
	la 9,.LC185@l(9)
	lfs 12,0(9)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	fadds 0,0,12
	fcmpu 0,0,13
	bc 12,1,.L222
	lis 9,globals@ha
	li 10,1
	la 7,globals@l(9)
	lis 11,g_edicts@ha
	lwz 0,72(7)
	lwz 9,g_edicts@l(11)
	cmpw 0,10,0
	addi 3,9,1084
	bc 4,0,.L222
	lis 9,Touch_Plat_Center2@ha
	mr 11,7
	la 9,Touch_Plat_Center2@l(9)
.L228:
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L227
	lwz 0,444(3)
	cmpw 0,0,9
	bc 4,2,.L227
	lwz 0,540(3)
	cmpw 0,0,8
	bc 4,2,.L227
	bl plat2_operate
	b .L222
.L227:
	lwz 0,72(11)
	addi 10,10,1
	addi 3,3,1084
	cmpw 0,10,0
	bc 12,0,.L228
.L222:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe55:
	.size	 Use_Plat2,.Lfe55-Use_Plat2
	.section	".rodata"
	.align 2
.LC186:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl plat2_activate
	.type	 plat2_activate,@function
plat2_activate:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,Use_Plat2@ha
	mr 28,3
	la 9,Use_Plat2@l(9)
	stw 9,448(28)
	bl plat_spawn_inside_trigger
	lis 9,.LC186@ha
	mr 29,3
	la 9,.LC186@l(9)
	lfs 10,200(29)
	lfs 13,0(9)
	lfs 12,204(29)
	lis 9,gi+72@ha
	lfs 11,188(29)
	lfs 0,192(29)
	fadds 10,10,13
	fadds 12,12,13
	fsubs 11,11,13
	fsubs 0,0,13
	stfs 10,200(29)
	stfs 12,204(29)
	stfs 11,188(29)
	stfs 0,192(29)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,Touch_Plat_Center2@ha
	mr 3,28
	la 9,Touch_Plat_Center2@l(9)
	stw 9,444(29)
	bl plat2_go_down
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe56:
	.size	 plat2_activate,.Lfe56-plat2_activate
	.section	".rodata"
	.align 3
.LC187:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl rotating_accel
	.type	 rotating_accel,@function
rotating_accel:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	addi 30,31,388
	mr 3,30
	bl VectorLength
	lfs 12,328(31)
	lfs 13,332(31)
	fsubs 0,12,13
	fcmpu 0,1,0
	cror 3,2,1
	bc 4,3,.L249
	fmr 1,12
	mr 4,30
	addi 3,31,340
	bl VectorScale
	mr 3,31
	mr 4,3
	bl G_UseTargets
	b .L250
.L249:
	fadds 1,1,13
	mr 4,30
	addi 3,31,340
	bl VectorScale
	lis 9,rotating_accel@ha
	lis 10,level+4@ha
	la 9,rotating_accel@l(9)
	lis 11,.LC187@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC187@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L250:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe57:
	.size	 rotating_accel,.Lfe57-rotating_accel
	.section	".rodata"
	.align 3
.LC188:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl rotating_decel
	.type	 rotating_decel,@function
rotating_decel:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	addi 30,31,388
	mr 3,30
	bl VectorLength
	lfs 0,336(31)
	fcmpu 0,1,0
	cror 3,2,0
	bc 4,3,.L252
	li 0,0
	mr 3,31
	stw 0,388(31)
	mr 4,31
	stw 0,396(31)
	stw 0,392(31)
	bl G_UseTargets
	li 0,0
	stw 0,444(31)
	b .L253
.L252:
	fsubs 1,1,0
	mr 4,30
	addi 3,31,340
	bl VectorScale
	lis 9,rotating_decel@ha
	lis 10,level+4@ha
	la 9,rotating_decel@l(9)
	lis 11,.LC188@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC188@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L253:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe58:
	.size	 rotating_decel,.Lfe58-rotating_decel
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
.Lfe59:
	.size	 rotating_blocked,.Lfe59-rotating_blocked
	.section	".rodata"
	.align 2
.LC189:
	.long 0x0
	.section	".text"
	.align 2
	.globl rotating_touch
	.type	 rotating_touch,@function
rotating_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC189@ha
	mr 11,3
	la 9,.LC189@l(9)
	lfs 0,388(11)
	mr 3,4
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L257
	lfs 0,392(11)
	fcmpu 0,0,13
	bc 4,2,.L257
	lfs 0,396(11)
	fcmpu 0,0,13
	bc 12,2,.L256
.L257:
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
.L256:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe60:
	.size	 rotating_touch,.Lfe60-rotating_touch
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
.Lfe61:
	.size	 button_done,.Lfe61-button_done
	.section	".rodata"
	.align 2
.LC190:
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
	lis 9,.LC190@ha
	lfs 13,728(31)
	li 0,1
	la 9,.LC190@l(9)
	stw 0,56(31)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L305
	lis 9,level+4@ha
	lis 11,button_return@ha
	lfs 0,level+4@l(9)
	la 11,button_return@l(11)
	stw 11,436(31)
	fadds 0,0,13
	stfs 0,428(31)
.L305:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe62:
	.size	 button_wait,.Lfe62-button_wait
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
.Lfe63:
	.size	 button_use,.Lfe63-button_use
	.align 2
	.globl button_touch
	.type	 button_touch,@function
button_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L318
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L318
	stw 4,548(3)
	bl button_fire
.L318:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe64:
	.size	 button_touch,.Lfe64-button_touch
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
.Lfe65:
	.size	 button_killed,.Lfe65-button_killed
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
	bc 12,2,.L332
	lis 9,gi@ha
	lis 27,.LC83@ha
	la 28,gi@l(9)
	b .L334
.L336:
	lwz 3,280(31)
	la 4,.LC83@l(27)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L334
	lwz 9,64(28)
	mr 4,29
	lwz 3,644(31)
	mtlr 9
	blrl
.L334:
	lwz 5,296(30)
	mr 3,31
	li 4,300
	bl G_Find
	mr. 31,3
	bc 4,2,.L336
.L332:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe66:
	.size	 door_use_areaportals,.Lfe66-door_use_areaportals
	.section	".rodata"
	.align 2
.LC191:
	.long 0x3f800000
	.align 2
.LC192:
	.long 0x40400000
	.align 2
.LC193:
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
	bc 4,2,.L340
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L341
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC191@ha
	la 9,.LC191@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC192@ha
	la 9,.LC192@l(9)
	lfs 2,0(9)
	lis 9,.LC193@ha
	la 9,.LC193@l(9)
	lfs 3,0(9)
	blrl
.L341:
	stw 30,76(31)
.L340:
	li 0,0
	lwz 9,284(31)
	stw 0,732(31)
	andi. 0,9,32
	bc 4,2,.L339
	lis 9,.LC193@ha
	lfs 13,728(31)
	la 9,.LC193@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L339
	lis 9,door_go_down@ha
	lis 11,level+4@ha
	la 9,door_go_down@l(9)
	stw 9,436(31)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	stfs 0,428(31)
.L339:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe67:
	.size	 door_hit_top,.Lfe67-door_hit_top
	.section	".rodata"
	.align 2
.LC194:
	.long 0x3f800000
	.align 2
.LC195:
	.long 0x40400000
	.align 2
.LC196:
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
	bc 4,2,.L345
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L346
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC194@ha
	la 9,.LC194@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC195@ha
	la 9,.LC195@l(9)
	lfs 2,0(9)
	lis 9,.LC196@ha
	la 9,.LC196@l(9)
	lfs 3,0(9)
	blrl
.L346:
	stw 30,76(31)
.L345:
	lwz 9,296(31)
	li 0,1
	li 30,0
	stw 0,732(31)
	cmpwi 0,9,0
	bc 12,2,.L348
	lis 9,gi@ha
	lis 28,.LC83@ha
	la 29,gi@l(9)
	b .L349
.L351:
	lwz 3,280(30)
	la 4,.LC83@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L349
	lwz 9,64(29)
	li 4,0
	lwz 3,644(30)
	mtlr 9
	blrl
.L349:
	lwz 5,296(31)
	mr 3,30
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L351
.L348:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe68:
	.size	 door_hit_bottom,.Lfe68-door_hit_bottom
	.section	".rodata"
	.align 2
.LC197:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl door_use
	.type	 door_use,@function
door_use:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	mr 29,5
	lwz 0,264(31)
	andi. 9,0,1024
	bc 4,2,.L437
	lwz 0,284(31)
	andi. 11,0,32
	bc 12,2,.L439
	lwz 0,732(31)
	subfic 11,0,0
	adde 9,11,0
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L439
	mr. 31,31
	bc 12,2,.L437
	li 30,0
.L444:
	stw 30,276(31)
	mr 3,31
	stw 30,444(31)
	bl door_go_down
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L444
	b .L437
.L439:
	lfs 11,200(31)
	lis 9,.LC197@ha
	addi 3,1,8
	lfs 12,188(31)
	la 9,.LC197@l(9)
	mr 4,3
	lfs 10,204(31)
	lfs 13,192(31)
	fadds 12,12,11
	lfs 0,196(31)
	lfs 11,208(31)
	fadds 13,13,10
	lfs 1,0(9)
	stfs 12,8(1)
	fadds 0,0,11
	stfs 13,12(1)
	stfs 0,16(1)
	bl VectorScale
	lis 9,gi+52@ha
	addi 3,1,8
	lwz 0,gi+52@l(9)
	mtlr 0
	blrl
	andi. 0,3,56
	bc 12,2,.L446
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L446
	li 0,0
	stw 29,540(31)
	mr 3,31
	stw 0,444(31)
	stw 0,276(31)
	bl smart_water_go_up
	b .L437
.L446:
	mr. 31,31
	bc 12,2,.L437
	li 30,0
.L450:
	stw 30,276(31)
	mr 3,31
	mr 4,29
	stw 30,444(31)
	bl door_go_up
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L450
.L437:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe69:
	.size	 door_use,.Lfe69-door_use
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
	bc 12,2,.L475
.L477:
	lfs 0,724(9)
	fabs 0,0
	fcmpu 0,0,13
	bc 4,0,.L476
	fmr 13,0
.L476:
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L477
.L475:
	mr. 9,3
	fdivs 0,13,12
	bclr 12,2
	fmr 9,0
.L483:
	lfs 0,724(9)
	lfs 13,716(9)
	lfs 11,712(9)
	fcmpu 0,11,13
	fabs 0,0
	fdiv 0,0,9
	frsp 12,0
	fdivs 10,12,13
	bc 4,2,.L484
	stfs 12,712(9)
	b .L485
.L484:
	fmuls 0,11,10
	stfs 0,712(9)
.L485:
	lfs 13,720(9)
	lfs 0,716(9)
	fcmpu 0,13,0
	bc 4,2,.L486
	stfs 12,720(9)
	b .L487
.L486:
	fmuls 0,13,10
	stfs 0,720(9)
.L487:
	stfs 12,716(9)
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L483
	blr
.Lfe70:
	.size	 Think_CalcMoveSpeed,.Lfe70-Think_CalcMoveSpeed
	.section	".rodata"
	.align 2
.LC198:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl door_killed
	.type	 door_killed,@function
door_killed:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lwz 9,564(3)
	mr 29,5
	cmpwi 0,9,0
	bc 12,2,.L540
	li 11,0
.L542:
	lwz 0,484(9)
	stw 11,512(9)
	stw 0,480(9)
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L542
.L540:
	lwz 31,564(3)
	lwz 0,264(31)
	andi. 9,0,1024
	bc 4,2,.L545
	lwz 0,284(31)
	andi. 11,0,32
	bc 12,2,.L546
	lwz 0,732(31)
	subfic 11,0,0
	adde 9,11,0
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L546
	mr. 31,31
	bc 12,2,.L545
	li 30,0
.L550:
	stw 30,276(31)
	mr 3,31
	stw 30,444(31)
	bl door_go_down
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L550
	b .L545
.L546:
	lfs 0,200(31)
	lis 9,.LC198@ha
	addi 3,1,8
	lfs 13,188(31)
	la 9,.LC198@l(9)
	mr 4,3
	lfs 1,0(9)
	fadds 13,13,0
	stfs 13,8(1)
	lfs 13,204(31)
	lfs 0,192(31)
	fadds 0,0,13
	stfs 0,12(1)
	lfs 0,208(31)
	lfs 13,196(31)
	fadds 13,13,0
	stfs 13,16(1)
	bl VectorScale
	lis 9,gi+52@ha
	addi 3,1,8
	lwz 0,gi+52@l(9)
	mtlr 0
	blrl
	andi. 0,3,56
	bc 12,2,.L553
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L553
	li 0,0
	stw 29,540(31)
	mr 3,31
	stw 0,444(31)
	stw 0,276(31)
	bl smart_water_go_up
	b .L545
.L553:
	mr. 31,31
	bc 12,2,.L545
	li 30,0
.L556:
	stw 30,276(31)
	mr 3,31
	mr 4,29
	stw 30,444(31)
	bl door_go_up
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L556
.L545:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe71:
	.size	 door_killed,.Lfe71-door_killed
	.section	".rodata"
	.align 3
.LC199:
	.long 0x40140000
	.long 0x0
	.align 2
.LC200:
	.long 0x3f800000
	.align 2
.LC201:
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
	bc 12,2,.L559
	lis 9,level+4@ha
	lfs 0,460(11)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L559
	lis 9,.LC199@ha
	fmr 0,13
	lis 29,gi@ha
	lwz 5,276(11)
	la 9,.LC199@l(9)
	la 29,gi@l(29)
	lfd 13,0(9)
	lis 4,.LC106@ha
	mr 3,31
	la 4,.LC106@l(4)
	fadd 0,0,13
	frsp 0,0
	stfs 0,460(11)
	lwz 9,12(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,36(29)
	lis 3,.LC107@ha
	la 3,.LC107@l(3)
	mtlr 9
	blrl
	lis 9,.LC200@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC200@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC200@ha
	la 9,.LC200@l(9)
	lfs 2,0(9)
	lis 9,.LC201@ha
	la 9,.LC201@l(9)
	lfs 3,0(9)
	blrl
.L559:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe72:
	.size	 door_touch,.Lfe72-door_touch
	.section	".rodata"
	.align 3
.LC202:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl Door_Activate
	.type	 Door_Activate,@function
Door_Activate:
	lwz 10,480(3)
	li 0,0
	stw 0,448(3)
	cmpwi 0,10,0
	bc 12,2,.L584
	lis 9,door_killed@ha
	lis 11,Think_CalcMoveSpeed@ha
	stw 10,484(3)
	la 9,door_killed@l(9)
	la 11,Think_CalcMoveSpeed@l(11)
	li 0,1
	stw 9,456(3)
	stw 0,512(3)
	stw 11,436(3)
	b .L585
.L584:
	lis 9,Think_SpawnDoorTrigger@ha
	la 9,Think_SpawnDoorTrigger@l(9)
	stw 9,436(3)
.L585:
	lis 9,level+4@ha
	lis 11,.LC202@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC202@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe73:
	.size	 Door_Activate,.Lfe73-Door_Activate
	.align 2
	.globl smart_water_blocked
	.type	 smart_water_blocked,@function
smart_water_blocked:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,4
	lwz 0,184(31)
	mr 4,3
	andi. 9,0,4
	bc 4,2,.L610
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L610
	stw 0,8(1)
	lis 6,vec3_origin@ha
	lis 9,0x1
	la 6,vec3_origin@l(6)
	li 0,19
	stw 0,12(1)
	mr 3,31
	mr 5,4
	addi 7,31,4
	mr 8,6
	ori 9,9,34464
	li 10,1
	bl T_Damage
	cmpwi 0,31,0
	bc 12,2,.L609
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L609
	mr 3,31
	bl BecomeExplosion1
	b .L609
.L610:
	li 9,19
	lis 6,vec3_origin@ha
	mr 3,31
	la 6,vec3_origin@l(6)
	stw 9,12(1)
	li 0,0
	mr 5,4
	stw 0,8(1)
	addi 7,3,4
	mr 8,6
	li 9,100
	li 10,1
	bl T_Damage
.L609:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe74:
	.size	 smart_water_blocked,.Lfe74-smart_water_blocked
	.section	".rodata"
	.align 3
.LC203:
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
	bc 4,2,.L625
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L625
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
	bc 12,2,.L624
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L624
	mr 3,31
	bl BecomeExplosion1
	b .L624
.L625:
	lis 9,level+4@ha
	lfs 0,460(12)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L624
	lwz 9,516(12)
	cmpwi 0,9,0
	bc 12,2,.L624
	lis 11,.LC203@ha
	fmr 0,13
	lis 6,vec3_origin@ha
	la 11,.LC203@l(11)
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
.L624:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe75:
	.size	 train_blocked,.Lfe75-train_blocked
	.align 2
	.globl train_piece_wait
	.type	 train_piece_wait,@function
train_piece_wait:
	blr
.Lfe76:
	.size	 train_piece_wait,.Lfe76-train_piece_wait
	.section	".rodata"
	.align 3
.LC204:
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
	bc 4,2,.L686
	lis 9,gi+4@ha
	lis 3,.LC135@ha
	lwz 0,gi+4@l(9)
	la 3,.LC135@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L685
.L686:
	bl G_PickTarget
	mr. 11,3
	bc 4,2,.L687
	lis 9,gi+4@ha
	lis 3,.LC136@ha
	lwz 4,296(31)
	lwz 0,gi+4@l(9)
	la 3,.LC136@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L685
.L687:
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
	bc 4,2,.L688
	lwz 0,284(31)
	ori 0,0,1
	stw 0,284(31)
.L688:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L685
	lis 11,level+4@ha
	lis 10,.LC204@ha
	lfs 0,level+4@l(11)
	lis 9,train_next@ha
	lfd 13,.LC204@l(10)
	la 9,train_next@l(9)
	stw 9,436(31)
	stw 31,548(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L685:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe77:
	.size	 func_train_find,.Lfe77-func_train_find
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
	bc 12,2,.L691
	andi. 0,9,2
	bc 12,2,.L690
	li 0,0
	rlwinm 9,9,0,0,30
	stw 0,428(3)
	stw 9,284(3)
	stw 0,384(3)
	stw 0,380(3)
	stw 0,376(3)
	b .L690
.L691:
	lwz 0,324(3)
	cmpwi 0,0,0
	bc 12,2,.L694
	bl train_resume
	b .L690
.L694:
	bl train_next
.L690:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe78:
	.size	 train_use,.Lfe78-train_use
	.section	".rodata"
	.align 2
.LC205:
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
	lis 9,.LC205@ha
	mr 31,3
	la 9,.LC205@l(9)
	mr 30,4
	lfs 13,0(9)
	lwz 9,416(31)
	lfs 0,428(9)
	fcmpu 0,0,13
	bc 4,2,.L705
	lwz 3,312(30)
	cmpwi 0,3,0
	bc 4,2,.L707
	lis 9,gi+4@ha
	lis 3,.LC141@ha
	lwz 0,gi+4@l(9)
	la 3,.LC141@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L705
.L707:
	bl G_PickTarget
	mr. 3,3
	bc 4,2,.L708
	lis 9,gi+4@ha
	lis 3,.LC142@ha
	lwz 4,312(30)
	lwz 0,gi+4@l(9)
	la 3,.LC142@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L705
.L708:
	lwz 9,416(31)
	stw 3,324(9)
	lwz 3,416(31)
	bl train_resume
.L705:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe79:
	.size	 trigger_elevator_use,.Lfe79-trigger_elevator_use
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
	bc 4,2,.L710
	lis 9,gi+4@ha
	lis 3,.LC143@ha
	lwz 0,gi+4@l(9)
	la 3,.LC143@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L709
.L710:
	bl G_PickTarget
	cmpwi 0,3,0
	stw 3,416(31)
	bc 4,2,.L711
	lis 9,gi+4@ha
	lis 3,.LC144@ha
	lwz 4,296(31)
	lwz 0,gi+4@l(9)
	la 3,.LC144@l(3)
	b .L812
.L711:
	lwz 3,280(3)
	lis 4,.LC145@ha
	la 4,.LC145@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L712
	lis 9,gi+4@ha
	lis 3,.LC146@ha
	lwz 4,296(31)
	lwz 0,gi+4@l(9)
	la 3,.LC146@l(3)
.L812:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L709
.L712:
	lis 9,trigger_elevator_use@ha
	li 0,1
	la 9,trigger_elevator_use@l(9)
	stw 0,184(31)
	stw 9,448(31)
.L709:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe80:
	.size	 trigger_elevator_init,.Lfe80-trigger_elevator_init
	.section	".rodata"
	.align 3
.LC206:
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
	lis 11,.LC206@ha
	stw 9,436(3)
	lfs 0,level+4@l(10)
	lfd 13,.LC206@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe81:
	.size	 SP_trigger_elevator,.Lfe81-SP_trigger_elevator
	.section	".rodata"
	.align 2
.LC207:
	.long 0x46fffe00
	.align 3
.LC208:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC209:
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
	lis 8,.LC208@ha
	lis 10,.LC207@ha
	la 8,.LC208@l(8)
	stw 0,24(1)
	lis 11,level+4@ha
	lfd 0,0(8)
	lfd 13,24(1)
	lis 8,.LC209@ha
	lfs 9,.LC207@l(10)
	la 8,.LC209@l(8)
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
.Lfe82:
	.size	 func_timer_think,.Lfe82-func_timer_think
	.section	".rodata"
	.align 2
.LC210:
	.long 0x46fffe00
	.align 2
.LC211:
	.long 0x0
	.align 3
.LC212:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC213:
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
	lis 8,.LC211@ha
	mr 31,3
	la 8,.LC211@l(8)
	lfs 0,428(31)
	mr 4,5
	lfs 12,0(8)
	stw 4,548(31)
	fcmpu 0,0,12
	bc 12,2,.L716
	stfs 12,428(31)
	b .L715
.L716:
	lfs 13,596(31)
	fcmpu 0,13,12
	bc 12,2,.L717
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,13
	b .L813
.L717:
	mr 3,31
	bl G_UseTargets
	bl rand
	rlwinm 3,3,0,17,31
	lfs 8,592(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	lfs 11,600(31)
	stw 3,20(1)
	lis 8,.LC212@ha
	lis 10,.LC210@ha
	la 8,.LC212@l(8)
	stw 0,16(1)
	lis 11,level+4@ha
	lfd 0,0(8)
	lfd 13,16(1)
	lis 8,.LC213@ha
	lfs 9,.LC210@l(10)
	la 8,.LC213@l(8)
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
.L813:
	stfs 0,428(31)
.L715:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe83:
	.size	 func_timer_use,.Lfe83-func_timer_use
	.section	".rodata"
	.align 3
.LC214:
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
	bc 12,2,.L725
	li 0,0
	rlwinm 9,11,0,0,30
	stw 0,328(3)
	stw 9,284(3)
	b .L726
.L725:
	lwz 0,532(3)
	lis 10,0x4330
	lis 8,.LC214@ha
	ori 11,11,1
	xoris 0,0,0x8000
	la 8,.LC214@l(8)
	stw 11,284(3)
	stw 0,12(1)
	stw 10,8(1)
	lfd 13,0(8)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,328(3)
.L726:
	lwz 0,284(3)
	andi. 0,0,2
	bc 4,2,.L727
	stw 0,532(3)
.L727:
	la 1,16(1)
	blr
.Lfe84:
	.size	 func_conveyor_use,.Lfe84-func_conveyor_use
	.section	".rodata"
	.align 2
.LC215:
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
	lis 9,.LC215@ha
	mr 31,3
	la 9,.LC215@l(9)
	lfs 0,328(31)
	lfs 12,0(9)
	fcmpu 0,0,12
	bc 4,2,.L729
	lis 0,0x42c8
	stw 0,328(31)
.L729:
	lwz 0,284(31)
	andi. 9,0,1
	bc 4,2,.L730
	lfs 0,328(31)
	stfs 12,328(31)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	stw 9,532(31)
.L730:
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
.Lfe85:
	.size	 SP_func_conveyor,.Lfe85-SP_func_conveyor
	.section	".rodata"
	.align 3
.LC216:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl door_secret_move1
	.type	 door_secret_move1,@function
door_secret_move1:
	lis 11,level+4@ha
	lis 9,.LC216@ha
	lfs 0,level+4@l(11)
	la 9,.LC216@l(9)
	lfd 13,0(9)
	lis 9,door_secret_move2@ha
	la 9,door_secret_move2@l(9)
	stw 9,436(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe86:
	.size	 door_secret_move1,.Lfe86-door_secret_move1
	.section	".rodata"
	.align 2
.LC217:
	.long 0xbf800000
	.section	".text"
	.align 2
	.globl door_secret_move3
	.type	 door_secret_move3,@function
door_secret_move3:
	lis 9,.LC217@ha
	lfs 13,592(3)
	la 9,.LC217@l(9)
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
.Lfe87:
	.size	 door_secret_move3,.Lfe87-door_secret_move3
	.section	".rodata"
	.align 3
.LC218:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl door_secret_move5
	.type	 door_secret_move5,@function
door_secret_move5:
	lis 11,level+4@ha
	lis 9,.LC218@ha
	lfs 0,level+4@l(11)
	la 9,.LC218@l(9)
	lfd 13,0(9)
	lis 9,door_secret_move6@ha
	la 9,door_secret_move6@l(9)
	stw 9,436(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe88:
	.size	 door_secret_move5,.Lfe88-door_secret_move5
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
	bc 12,2,.L781
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L780
.L781:
	li 0,0
	li 9,1
	stw 0,480(31)
	stw 9,512(31)
.L780:
	lwz 0,296(31)
	li 30,0
	cmpwi 0,0,0
	bc 12,2,.L783
	lis 9,gi@ha
	lis 28,.LC83@ha
	la 29,gi@l(9)
	b .L784
.L786:
	lwz 3,280(30)
	la 4,.LC83@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L784
	lwz 9,64(29)
	li 4,0
	lwz 3,644(30)
	mtlr 9
	blrl
.L784:
	lwz 5,296(31)
	mr 3,30
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L786
.L783:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe89:
	.size	 door_secret_done,.Lfe89-door_secret_done
	.section	".rodata"
	.align 3
.LC219:
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
	bc 4,2,.L790
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L790
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
	bc 12,2,.L789
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L789
	mr 3,31
	bl BecomeExplosion1
	b .L789
.L790:
	lis 9,level+4@ha
	lfs 0,460(12)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L789
	lis 9,.LC219@ha
	fmr 0,13
	lis 6,vec3_origin@ha
	la 9,.LC219@l(9)
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
.L789:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe90:
	.size	 door_secret_blocked,.Lfe90-door_secret_blocked
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
.Lfe91:
	.size	 door_secret_die,.Lfe91-door_secret_die
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
.Lfe92:
	.size	 use_killbox,.Lfe92-use_killbox
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
.Lfe93:
	.size	 SP_func_killbox,.Lfe93-SP_func_killbox
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
