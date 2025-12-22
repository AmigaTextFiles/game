	.file	"g_func.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"MP5/10 Submachinegun"
	.align 2
.LC1:
	.string	"M4 Assault Rifle"
	.align 2
.LC2:
	.string	"M3 Super 90 Assault Shotgun"
	.align 2
.LC3:
	.string	"Handcannon"
	.align 2
.LC4:
	.string	"Sniper Rifle"
	.align 2
.LC5:
	.string	"Silencer"
	.align 2
.LC6:
	.string	"Stealth Slippers"
	.align 2
.LC7:
	.string	"Bandolier"
	.align 2
.LC8:
	.string	"Kevlar Vest"
	.align 2
.LC9:
	.string	"Lasersight"
	.section	".text"
	.align 2
	.globl Handle_Unique_Items
	.type	 Handle_Unique_Items,@function
Handle_Unique_Items:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,648(31)
	cmpwi 0,9,0
	bc 12,2,.L6
	lwz 3,40(9)
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lwz 9,648(31)
	lis 4,.LC1@ha
	la 4,.LC1@l(4)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lwz 9,648(31)
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lwz 9,648(31)
	lis 4,.LC3@ha
	la 4,.LC3@l(4)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L27
	lwz 9,648(31)
	lis 4,.LC4@ha
	la 4,.LC4@l(4)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L16
.L27:
	mr 3,31
	bl ThinkSpecWeap
	b .L6
.L16:
	lwz 9,648(31)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L28
	lwz 9,648(31)
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L28
	lwz 9,648(31)
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L28
	lwz 9,648(31)
	lis 4,.LC8@ha
	la 4,.LC8@l(4)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L24
.L28:
	mr 3,31
	bl RespawnSpec
	b .L6
.L24:
	lwz 9,648(31)
	lis 4,.LC9@ha
	la 4,.LC9@l(4)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L6
	mr 3,31
	bl RespawnSpec
.L6:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe1:
	.size	 Handle_Unique_Items,.Lfe1-Handle_Unique_Items
	.section	".rodata"
	.align 3
.LC11:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC12:
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
	lis 9,.LC11@ha
	lfs 13,716(31)
	lfs 12,760(31)
	lfd 31,.LC11@l(9)
	fmr 0,13
	fmr 1,12
	fmul 0,0,31
	fcmpu 0,0,1
	cror 3,2,1
	bc 4,3,.L34
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	lfs 0,0(9)
	fcmpu 0,12,0
	bc 4,2,.L35
	lwz 9,768(31)
	stfs 0,376(31)
	mtlr 9
	stfs 0,384(31)
	stfs 0,380(31)
	blrl
	b .L33
.L35:
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
	b .L33
.L34:
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
.L33:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Move_Begin,.Lfe2-Move_Begin
	.section	".rodata"
	.align 3
.LC15:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC16:
	.long 0x41200000
	.align 3
.LC17:
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
	bc 4,2,.L52
	lfs 11,16(31)
	lfs 13,688(31)
	lfs 12,692(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,696(31)
	b .L60
.L52:
	lfs 11,16(31)
	lfs 13,664(31)
	lfs 12,668(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,672(31)
.L60:
	lfs 11,24(31)
	fsubs 12,12,10
	stfs 13,8(1)
	fsubs 0,0,11
	stfs 12,12(1)
	stfs 0,16(1)
	addi 3,1,8
	bl VectorLength
	lfs 0,716(31)
	lis 9,.LC15@ha
	lfd 29,.LC15@l(9)
	fdivs 1,1,0
	fmr 30,1
	fcmpu 0,30,29
	bc 4,0,.L54
	lwz 0,732(31)
	cmpwi 0,0,2
	bc 4,2,.L55
	lfs 11,16(31)
	lfs 13,688(31)
	lfs 12,692(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,696(31)
	b .L61
.L55:
	lfs 11,16(31)
	lfs 13,664(31)
	lfs 12,668(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,672(31)
.L61:
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
	bc 12,2,.L57
	lwz 9,768(31)
	mr 3,31
	li 0,0
	stw 0,388(31)
	mtlr 9
	stw 0,396(31)
	stw 0,392(31)
	blrl
	b .L51
.L57:
	lis 9,.LC16@ha
	addi 3,1,24
	la 9,.LC16@l(9)
	addi 4,31,388
	lfs 1,0(9)
	bl VectorScale
	lis 9,AngleMove_Done@ha
	lis 10,level+4@ha
	la 9,AngleMove_Done@l(9)
	lis 11,.LC15@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC15@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	b .L51
.L54:
	fdiv 1,30,29
	bl floor
	lis 9,.LC17@ha
	frsp 31,1
	addi 3,1,8
	la 9,.LC17@l(9)
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
.L51:
	lwz 0,84(1)
	mtlr 0
	lwz 31,52(1)
	lfd 29,56(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe3:
	.size	 AngleMove_Begin,.Lfe3-AngleMove_Begin
	.section	".rodata"
	.align 2
.LC19:
	.long 0x0
	.align 3
.LC20:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC21:
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
	bc 4,3,.L71
	bclr 4,0
	lis 9,.LC19@ha
	lfs 0,104(3)
	la 9,.LC19@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L73
	stfs 13,104(3)
	stfs 0,96(3)
	blr
.L73:
	lfs 13,96(3)
	lfs 0,68(3)
	fcmpu 0,13,0
	bclr 4,1
	fsubs 0,13,0
	stfs 0,96(3)
	blr
.L71:
	lfs 0,96(3)
	lfs 9,100(3)
	fmr 12,0
	fcmpu 0,0,9
	bc 4,2,.L75
	fsubs 0,13,12
	fcmpu 0,0,10
	bc 4,0,.L75
	fsubs 10,13,10
	lis 9,.LC20@ha
	lfs 11,68(3)
	la 9,.LC20@l(9)
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
.L75:
	lfs 13,64(3)
	fcmpu 0,12,13
	bclr 4,0
	lfs 0,60(3)
	fadds 0,12,0
	fcmpu 0,0,13
	stfs 0,96(3)
	bc 4,1,.L78
	stfs 13,96(3)
.L78:
	lfs 13,108(3)
	lfs 0,96(3)
	lfs 9,112(3)
	fsubs 0,13,0
	fcmpu 0,0,9
	cror 3,2,1
	bclr 12,3
	lfs 10,100(3)
	lis 9,.LC21@ha
	fsubs 9,13,9
	la 9,.LC21@l(9)
	lfs 8,68(3)
	lfd 0,0(9)
	fadds 12,12,10
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
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
.LC22:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC23:
	.long 0x0
	.align 2
.LC24:
	.long 0x3f000000
	.align 2
.LC25:
	.long 0x3f800000
	.align 2
.LC26:
	.long 0x40800000
	.align 2
.LC27:
	.long 0xc0000000
	.align 3
.LC28:
	.long 0xc0000000
	.long 0x0
	.align 2
.LC29:
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
	lis 9,.LC23@ha
	mr 31,3
	la 9,.LC23@l(9)
	lfs 13,748(31)
	lfs 9,0(9)
	lfs 0,760(31)
	fcmpu 0,13,9
	fsubs 0,0,13
	stfs 0,760(31)
	bc 4,2,.L81
	addi 30,31,652
	lfs 10,108(30)
	lfs 11,60(30)
	lfs 12,64(30)
	fcmpu 0,10,11
	stfs 12,100(30)
	bc 4,0,.L82
	stfs 10,96(30)
	b .L81
.L82:
	fdivs 0,12,11
	lfs 31,68(30)
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfs 30,0(9)
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	lfs 29,0(9)
	fdivs 13,12,31
	fmadds 0,0,12,12
	fmadds 13,13,12,12
	fmuls 0,0,30
	fmuls 1,13,30
	fsubs 0,10,0
	fsubs 0,0,1
	fcmpu 0,0,9
	bc 4,0,.L84
	fmuls 12,11,31
	lis 9,.LC26@ha
	fadds 31,11,31
	la 9,.LC26@l(9)
	lfs 1,0(9)
	lis 9,.LC27@ha
	fdivs 31,31,12
	la 9,.LC27@l(9)
	lfs 13,0(9)
	fmuls 0,31,1
	fmuls 13,10,13
	fmuls 0,0,13
	fsubs 1,1,0
	bl sqrt
	lis 9,.LC28@ha
	fadds 31,31,31
	lfs 13,68(30)
	la 9,.LC28@l(9)
	lfd 0,0(9)
	fadd 1,1,0
	fdiv 1,1,31
	frsp 1,1
	fdivs 13,1,13
	stfs 1,100(30)
	fadds 13,13,29
	fmuls 1,1,13
	fmuls 1,1,30
.L84:
	stfs 1,112(30)
.L81:
	addi 3,31,652
	bl plat_Accelerate
	lfs 1,760(31)
	lfs 0,748(31)
	fcmpu 0,1,0
	cror 3,2,0
	bc 4,3,.L85
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,2,.L86
	lwz 9,768(31)
	mr 3,31
	stfs 0,376(31)
	mtlr 9
	stfs 0,384(31)
	stfs 0,380(31)
	blrl
	b .L80
.L86:
	lis 9,.LC22@ha
	addi 3,31,736
	lfd 31,.LC22@l(9)
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
	b .L89
.L85:
	lis 9,.LC29@ha
	addi 3,31,736
	la 9,.LC29@l(9)
	addi 4,31,376
	lfs 1,0(9)
	fmuls 1,0,1
	bl VectorScale
	lis 11,level+4@ha
	lis 10,.LC22@ha
	lfs 0,level+4@l(11)
	lis 9,Think_AccelMove@ha
	lfd 13,.LC22@l(10)
	la 9,Think_AccelMove@l(9)
	stw 9,436(31)
	fadd 0,0,13
.L89:
	frsp 0,0
	stfs 0,428(31)
.L80:
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
.LC30:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC31:
	.long 0x3f800000
	.align 2
.LC32:
	.long 0x40400000
	.align 2
.LC33:
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
	bc 4,2,.L97
	lwz 5,700(31)
	cmpwi 0,5,0
	bc 12,2,.L98
	lis 11,.LC31@ha
	lis 9,gi+16@ha
	la 11,.LC31@l(11)
	lwz 0,gi+16@l(9)
	lfs 1,0(11)
	lis 9,.LC32@ha
	li 4,10
	lis 11,.LC33@ha
	la 9,.LC32@l(9)
	mtlr 0
	la 11,.LC33@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L98:
	lwz 0,704(31)
	stw 0,76(31)
.L97:
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
	bc 4,2,.L99
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L99
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L100
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L101
	b .L102
.L100:
	cmpw 0,9,31
	bc 4,2,.L102
.L101:
	mr 3,31
	bl Move_Begin
	b .L105
.L102:
	lis 11,level+4@ha
	lis 10,.LC30@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC30@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L106
.L99:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC30@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC30@l(11)
.L106:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L105:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 plat_go_down,.Lfe6-plat_go_down
	.section	".rodata"
	.align 3
.LC34:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC35:
	.long 0x3f800000
	.align 2
.LC36:
	.long 0x40400000
	.align 2
.LC37:
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
	bc 4,2,.L108
	lwz 5,700(31)
	cmpwi 0,5,0
	bc 12,2,.L109
	lis 11,.LC35@ha
	lis 9,gi+16@ha
	la 11,.LC35@l(11)
	lwz 0,gi+16@l(9)
	lfs 1,0(11)
	lis 9,.LC36@ha
	li 4,10
	lis 11,.LC37@ha
	la 9,.LC36@l(9)
	mtlr 0
	la 11,.LC37@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L109:
	lwz 0,704(31)
	stw 0,76(31)
.L108:
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
	bc 4,2,.L110
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L110
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L111
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L112
	b .L113
.L111:
	cmpw 0,9,31
	bc 4,2,.L113
.L112:
	mr 3,31
	bl Move_Begin
	b .L116
.L113:
	lis 11,level+4@ha
	lis 10,.LC34@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC34@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L117
.L110:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC34@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC34@l(11)
.L117:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L116:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 plat_go_up,.Lfe7-plat_go_up
	.section	".rodata"
	.align 2
.LC38:
	.long 0x41000000
	.align 3
.LC39:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC40:
	.long 0x41c80000
	.align 2
.LC41:
	.long 0x0
	.align 3
.LC42:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC43:
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
	lis 9,.LC38@ha
	mr 7,3
	la 9,.LC38@l(9)
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
	lis 11,.LC39@ha
	stw 9,444(7)
	la 11,.LC39@l(11)
	lwz 0,st+24@l(10)
	lfd 10,0(11)
	xoris 0,0,0x8000
	lfs 13,372(31)
	lis 11,.LC40@ha
	stw 0,52(1)
	la 11,.LC40@l(11)
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
	bc 12,2,.L134
	fadds 0,0,6
	stfs 0,32(1)
.L134:
	lfs 0,24(1)
	lis 11,.LC41@ha
	lfs 13,8(1)
	la 11,.LC41@l(11)
	lfs 10,0(11)
	fsubs 0,0,13
	fcmpu 0,0,10
	cror 3,2,0
	bc 4,3,.L135
	lfs 0,188(31)
	lis 9,.LC42@ha
	lis 11,.LC43@ha
	lfs 13,200(31)
	la 9,.LC42@l(9)
	la 11,.LC43@l(11)
	lfd 11,0(9)
	lfs 12,0(11)
	fadds 0,0,13
	fmul 0,0,11
	frsp 0,0
	fadds 12,0,12
	stfs 0,8(1)
	stfs 12,24(1)
.L135:
	lfs 0,28(1)
	lfs 13,12(1)
	fsubs 0,0,13
	fcmpu 0,0,10
	cror 3,2,0
	bc 4,3,.L136
	lfs 11,204(31)
	lis 9,.LC42@ha
	lis 11,.LC43@ha
	lfs 0,192(31)
	la 9,.LC42@l(9)
	la 11,.LC43@l(11)
	lfd 12,0(9)
	lfs 13,0(11)
	fadds 0,0,11
	fmul 0,0,12
	frsp 0,0
	fadds 13,0,13
	stfs 0,12(1)
	stfs 13,28(1)
.L136:
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
.LC45:
	.string	"plats/pt1_strt.wav"
	.align 2
.LC46:
	.string	"plats/pt1_mid.wav"
	.align 2
.LC47:
	.string	"plats/pt1_end.wav"
	.align 3
.LC44:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC48:
	.long 0x0
	.align 3
.LC49:
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
	lis 9,.LC48@ha
	mr 31,3
	la 9,.LC48@l(9)
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
	bc 4,2,.L138
	lis 0,0x41a0
	stw 0,328(31)
	b .L139
.L138:
	lis 9,.LC44@ha
	lfd 13,.LC44@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,328(31)
.L139:
	lis 9,.LC48@ha
	lfs 13,332(31)
	la 9,.LC48@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L140
	lis 0,0x40a0
	stw 0,332(31)
	b .L141
.L140:
	fmr 0,13
	lis 9,.LC44@ha
	lfd 13,.LC44@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,332(31)
.L141:
	lis 10,.LC48@ha
	lfs 13,336(31)
	la 10,.LC48@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,2,.L142
	lis 0,0x40a0
	stw 0,336(31)
	b .L143
.L142:
	fmr 0,13
	lis 9,.LC44@ha
	lfd 13,.LC44@l(9)
	fmul 0,0,13
	frsp 0,0
	stfs 0,336(31)
.L143:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L144
	li 0,2
	stw 0,516(31)
.L144:
	lis 9,st@ha
	la 9,st@l(9)
	lwz 0,24(9)
	cmpwi 0,0,0
	bc 4,2,.L145
	li 0,8
	stw 0,24(9)
.L145:
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
	bc 12,2,.L146
	xoris 0,0,0x8000
	stw 0,20(1)
	lis 11,0x4330
	lis 10,.LC49@ha
	la 10,.LC49@l(10)
	stw 11,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fsubs 0,10,0
	stfs 0,372(31)
	b .L147
.L146:
	lwz 0,24(9)
	lis 11,0x4330
	lis 10,.LC49@ha
	la 10,.LC49@l(10)
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
.L147:
	lis 9,Use_Plat@ha
	mr 3,31
	la 9,Use_Plat@l(9)
	stw 9,448(31)
	bl plat_spawn_inside_trigger
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L148
	li 0,2
	b .L150
.L148:
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
.L150:
	stw 0,732(31)
	lfs 2,16(31)
	lis 29,gi@ha
	lis 3,.LC45@ha
	lfs 3,20(31)
	la 29,gi@l(29)
	la 3,.LC45@l(3)
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
	lis 3,.LC46@ha
	la 3,.LC46@l(3)
	mtlr 9
	blrl
	stw 3,704(31)
	lwz 0,36(29)
	lis 3,.LC47@ha
	la 3,.LC47@l(3)
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
.LC50:
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
	bc 12,2,.L160
	stw 9,260(31)
	b .L161
.L160:
	li 0,2
	stw 0,260(31)
.L161:
	lwz 9,284(31)
	li 0,0
	stw 0,340(31)
	andi. 11,9,4
	stw 0,348(31)
	stw 0,344(31)
	bc 12,2,.L162
	lis 0,0x3f80
	stw 0,348(31)
	b .L163
.L162:
	andi. 0,9,8
	bc 12,2,.L164
	lis 0,0x3f80
	stw 0,340(31)
	b .L163
.L164:
	lis 0,0x3f80
	stw 0,344(31)
.L163:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L166
	lfs 0,340(31)
	lfs 13,344(31)
	lfs 12,348(31)
	fneg 0,0
	fneg 13,13
	fneg 12,12
	stfs 0,340(31)
	stfs 13,344(31)
	stfs 12,348(31)
.L166:
	lis 11,.LC50@ha
	lfs 13,328(31)
	la 11,.LC50@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L167
	lis 0,0x42c8
	stw 0,328(31)
.L167:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L168
	li 0,2
	stw 0,516(31)
.L168:
	lwz 0,516(31)
	lis 9,rotating_use@ha
	la 9,rotating_use@l(9)
	cmpwi 0,0,0
	stw 9,448(31)
	bc 12,2,.L169
	lis 9,rotating_blocked@ha
	la 9,rotating_blocked@l(9)
	stw 9,440(31)
.L169:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L170
	lwz 9,448(31)
	mr 3,31
	li 4,0
	li 5,0
	mtlr 9
	blrl
.L170:
	lwz 0,284(31)
	andi. 9,0,64
	bc 12,2,.L171
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L171:
	lwz 0,284(31)
	andi. 11,0,128
	bc 12,2,.L172
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L172:
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
.LC51:
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
	lis 10,.LC51@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC51@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L183
.L175:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC51@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC51@l(11)
.L183:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L181:
	lwz 9,480(31)
	li 0,0
	stw 0,56(31)
	cmpwi 0,9,0
	bc 12,2,.L182
	li 0,1
	stw 0,512(31)
.L182:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 button_return,.Lfe11-button_return
	.section	".rodata"
	.align 3
.LC52:
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
	bc 4,2,.L186
	lwz 5,700(31)
	li 0,2
	stw 0,732(31)
	cmpwi 0,5,0
	bc 12,2,.L188
	lwz 0,264(31)
	andi. 9,0,1024
	bc 4,2,.L188
	lis 11,.LC53@ha
	lis 9,gi+16@ha
	la 11,.LC53@l(11)
	lwz 0,gi+16@l(9)
	lfs 1,0(11)
	lis 9,.LC54@ha
	li 4,10
	lis 11,.LC55@ha
	la 9,.LC54@l(9)
	mtlr 0
	la 11,.LC55@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L188:
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
	bc 4,2,.L189
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L189
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L190
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L191
	b .L192
.L190:
	cmpw 0,9,31
	bc 4,2,.L192
.L191:
	mr 3,31
	bl Move_Begin
	b .L186
.L192:
	lis 11,level+4@ha
	lis 10,.LC52@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC52@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L196
.L189:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC52@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC52@l(11)
.L196:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L186:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 button_fire,.Lfe12-button_fire
	.section	".rodata"
	.align 2
.LC56:
	.string	"switches/butn2.wav"
	.align 2
.LC57:
	.long 0x0
	.align 3
.LC58:
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
	lis 3,.LC56@ha
	la 3,.LC56@l(3)
	mtlr 0
	blrl
	stw 3,700(31)
.L203:
	lis 8,.LC57@ha
	lfs 0,328(31)
	la 8,.LC57@l(8)
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
	lis 8,.LC58@ha
	mr 4,29
	lfs 0,12(31)
	la 8,.LC58@l(8)
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
.LC59:
	.string	"func_areaportal"
	.align 2
.LC60:
	.string	"func_door"
	.align 2
.LC62:
	.string	"func_door_rotating"
	.align 3
.LC61:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC63:
	.long 0x3f800000
	.align 2
.LC64:
	.long 0x40400000
	.align 2
.LC65:
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
	lis 11,.LC64@ha
	lwz 0,gi+16@l(9)
	lis 8,.LC65@ha
	la 11,.LC64@l(11)
	lis 9,.LC63@ha
	la 8,.LC65@l(8)
	lfs 2,0(11)
	la 9,.LC63@l(9)
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
	lis 4,.LC60@ha
	stw 0,732(31)
	la 4,.LC60@l(4)
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
	lis 10,.LC61@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC61@l(10)
	la 9,Move_Begin@l(9)
	b .L253
.L239:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC61@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC61@l(11)
	b .L254
.L238:
	lwz 3,280(31)
	lis 4,.LC62@ha
	la 4,.LC62@l(4)
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
	lis 10,.LC61@ha
	lfs 0,level+4@l(11)
	lis 9,AngleMove_Begin@ha
	lfd 13,.LC61@l(10)
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
.LC66:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC67:
	.long 0x0
	.align 2
.LC68:
	.long 0x3f800000
	.align 2
.LC69:
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
	bc 12,2,.L255
	cmpwi 0,0,0
	bc 4,2,.L257
	lis 8,.LC67@ha
	lfs 13,728(31)
	la 8,.LC67@l(8)
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
	lis 11,.LC68@ha
	lwz 0,gi+16@l(9)
	lis 8,.LC69@ha
	la 11,.LC68@l(11)
	lis 9,.LC67@ha
	la 8,.LC69@l(8)
	lfs 1,0(11)
	la 9,.LC67@l(9)
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
	lis 4,.LC60@ha
	stw 0,732(31)
	la 4,.LC60@l(4)
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
	lis 10,.LC66@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC66@l(10)
	la 9,Move_Begin@l(9)
	b .L283
.L262:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC66@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC66@l(11)
	b .L284
.L261:
	lwz 3,280(31)
	lis 4,.LC62@ha
	la 4,.LC62@l(4)
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
	lis 10,.LC66@ha
	lfs 0,level+4@l(11)
	lis 9,AngleMove_Begin@ha
	lfd 13,.LC66@l(10)
	la 9,AngleMove_Begin@l(9)
.L283:
	stw 9,436(31)
.L284:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L269:
	mr 4,30
	mr 3,31
	bl G_UseTargets
	li 29,0
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L255
	lis 9,gi@ha
	lis 28,.LC59@ha
	la 30,gi@l(9)
	b .L278
.L280:
	lwz 3,280(29)
	la 4,.LC59@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L278
	lwz 9,64(30)
	li 4,1
	lwz 3,644(29)
	mtlr 9
	blrl
.L278:
	lwz 5,296(31)
	mr 3,29
	li 4,300
	bl G_Find
	mr. 29,3
	bc 4,2,.L280
.L255:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 door_go_up,.Lfe15-door_go_up
	.section	".rodata"
	.align 3
.LC70:
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
	lwz 9,84(29)
	cmpwi 0,9,0
	bc 12,2,.L300
	lwz 0,4396(9)
	cmpwi 0,0,0
	bc 12,2,.L300
	li 0,0
	stw 0,460(3)
.L300:
	lwz 0,480(29)
	cmpwi 0,0,0
	bc 4,1,.L299
	lwz 0,184(29)
	andi. 9,0,4
	mcrf 7,0
	bc 4,30,.L302
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L299
.L302:
	lwz 11,256(3)
	lwz 0,284(11)
	andi. 10,0,8
	bc 12,2,.L303
	bc 4,30,.L299
.L303:
	lis 9,level+4@ha
	lfs 0,460(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L299
	lis 9,.LC70@ha
	fmr 0,13
	la 9,.LC70@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,460(3)
	lwz 9,84(29)
	cmpwi 0,9,0
	bc 12,2,.L299
	lwz 0,4396(9)
	cmpwi 0,0,0
	bc 12,2,.L299
	lwz 0,264(11)
	andi. 10,0,1024
	bc 4,2,.L299
	lwz 0,284(11)
	andi. 9,0,32
	bc 12,2,.L310
	lwz 0,732(11)
	subfic 10,0,0
	adde 9,10,0
	xori 0,0,2
	subfic 10,0,0
	adde 0,10,0
	or. 10,0,9
	bc 12,2,.L310
	mr. 31,11
	bc 12,2,.L299
	li 30,0
.L314:
	stw 30,276(31)
	mr 3,31
	stw 30,444(31)
	bl door_go_down
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L314
	b .L299
.L310:
	mr. 31,11
	bc 12,2,.L299
	li 30,0
.L319:
	stw 30,276(31)
	mr 3,31
	mr 4,29
	stw 30,444(31)
	bl door_go_up
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L319
.L299:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 Touch_DoorTrigger,.Lfe16-Touch_DoorTrigger
	.section	".rodata"
	.align 2
.LC71:
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
	bc 4,2,.L339
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
	bc 12,2,.L342
	addi 30,1,24
.L344:
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
	bc 4,2,.L344
.L342:
	lis 9,.LC71@ha
	lfs 10,8(1)
	la 9,.LC71@l(9)
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
	bc 12,2,.L346
	lwz 0,296(29)
	li 31,0
	cmpwi 0,0,0
	bc 12,2,.L346
	mr 28,30
	lis 30,.LC59@ha
	b .L349
.L351:
	lwz 3,280(31)
	la 4,.LC59@l(30)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L349
	lwz 9,64(28)
	li 4,1
	lwz 3,644(31)
	mtlr 9
	blrl
.L349:
	lwz 5,296(29)
	mr 3,31
	li 4,300
	bl G_Find
	mr. 31,3
	bc 4,2,.L351
.L346:
	lwz 0,264(29)
	andi. 9,0,1024
	bc 4,2,.L339
	lwz 9,560(29)
	lfs 0,724(29)
	cmpwi 0,9,0
	lfs 12,716(29)
	fabs 13,0
	bc 12,2,.L361
.L358:
	lfs 0,724(9)
	fabs 0,0
	fcmpu 0,0,13
	bc 4,0,.L360
	fmr 13,0
.L360:
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L358
.L361:
	mr. 9,29
	fdivs 0,13,12
	bc 12,2,.L339
	fmr 9,0
.L364:
	lfs 0,724(9)
	lfs 13,716(9)
	lfs 11,712(9)
	fcmpu 0,11,13
	fabs 0,0
	fdiv 0,0,9
	frsp 12,0
	fdivs 10,12,13
	bc 4,2,.L365
	stfs 12,712(9)
	b .L366
.L365:
	fmuls 0,11,10
	stfs 0,712(9)
.L366:
	lfs 13,720(9)
	lfs 0,716(9)
	fcmpu 0,13,0
	bc 4,2,.L367
	stfs 12,720(9)
	b .L368
.L367:
	fmuls 0,13,10
	stfs 0,720(9)
.L368:
	stfs 12,716(9)
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L364
.L339:
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe17:
	.size	 Think_SpawnDoorTrigger,.Lfe17-Think_SpawnDoorTrigger
	.section	".rodata"
	.align 2
.LC72:
	.string	"%s"
	.align 2
.LC73:
	.string	"misc/talk1.wav"
	.align 2
.LC74:
	.string	"doors/dr1_strt.wav"
	.align 2
.LC75:
	.string	"doors/dr1_mid.wav"
	.align 2
.LC76:
	.string	"doors/dr1_end.wav"
	.align 2
.LC77:
	.string	"misc/talk.wav"
	.align 3
.LC78:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC79:
	.long 0x0
	.align 3
.LC80:
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
	bc 12,2,.L413
	lis 29,gi@ha
	lis 3,.LC74@ha
	la 29,gi@l(29)
	la 3,.LC74@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,700(31)
	lwz 9,36(29)
	lis 3,.LC75@ha
	la 3,.LC75@l(3)
	mtlr 9
	blrl
	stw 3,704(31)
	lwz 0,36(29)
	lis 3,.LC76@ha
	la 3,.LC76@l(3)
	mtlr 0
	blrl
	stw 3,708(31)
.L413:
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
	lis 8,.LC79@ha
	lfs 0,328(31)
	lis 9,door_blocked@ha
	la 8,.LC79@l(8)
	lis 11,door_use@ha
	lfs 13,0(8)
	la 9,door_blocked@l(9)
	la 11,door_use@l(11)
	stw 9,440(31)
	stw 11,448(31)
	fcmpu 0,0,13
	bc 4,2,.L414
	lis 0,0x42c8
	stw 0,328(31)
.L414:
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L415
	lfs 0,328(31)
	fadds 0,0,0
	stfs 0,328(31)
.L415:
	lfs 0,332(31)
	fcmpu 0,0,13
	bc 4,2,.L416
	lfs 0,328(31)
	stfs 0,332(31)
.L416:
	lfs 0,336(31)
	fcmpu 0,0,13
	bc 4,2,.L417
	lfs 0,328(31)
	stfs 0,336(31)
.L417:
	lfs 0,592(31)
	fcmpu 0,0,13
	bc 4,2,.L418
	lis 0,0x4040
	stw 0,592(31)
.L418:
	lis 9,st@ha
	la 10,st@l(9)
	lwz 0,24(10)
	cmpwi 0,0,0
	bc 4,2,.L419
	li 0,8
	stw 0,24(10)
.L419:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L420
	stw 30,516(31)
.L420:
	lfs 12,4(31)
	lis 11,0x4330
	lfs 13,8(31)
	lis 8,.LC80@ha
	mr 4,29
	lfs 0,12(31)
	la 8,.LC80@l(8)
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
	bc 12,2,.L421
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
.L421:
	lwz 0,480(31)
	li 11,1
	stw 11,732(31)
	cmpwi 0,0,0
	bc 12,2,.L422
	lis 9,door_killed@ha
	stw 11,512(31)
	la 9,door_killed@l(9)
	stw 0,484(31)
	stw 9,456(31)
	b .L423
.L422:
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L423
	lwz 0,276(31)
	cmpwi 0,0,0
	bc 12,2,.L423
	lwz 0,36(28)
	lis 3,.LC77@ha
	la 3,.LC77@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,444(31)
.L423:
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
	bc 12,2,.L425
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L425:
	lwz 0,284(31)
	andi. 9,0,64
	bc 12,2,.L426
	lwz 0,64(31)
	ori 0,0,8192
	stw 0,64(31)
.L426:
	lwz 0,308(31)
	cmpwi 0,0,0
	bc 4,2,.L427
	stw 31,564(31)
.L427:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC78@ha
	lwz 0,480(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC78@l(11)
	cmpwi 0,0,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 4,2,.L429
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L428
.L429:
	lis 9,Think_CalcMoveSpeed@ha
	la 9,Think_CalcMoveSpeed@l(9)
	b .L431
.L428:
	lis 9,Think_SpawnDoorTrigger@ha
	la 9,Think_SpawnDoorTrigger@l(9)
.L431:
	stw 9,436(31)
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe18:
	.size	 SP_func_door,.Lfe18-SP_func_door
	.section	".rodata"
	.align 2
.LC81:
	.string	"%s at %s with no distance set\n"
	.align 3
.LC82:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC83:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC84:
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
	bc 12,2,.L433
	lis 0,0x3f80
	stw 0,348(31)
	b .L434
.L433:
	andi. 0,9,128
	bc 12,2,.L435
	lis 0,0x3f80
	stw 0,340(31)
	b .L434
.L435:
	lis 0,0x3f80
	stw 0,344(31)
.L434:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L437
	lfs 0,340(31)
	lfs 13,344(31)
	lfs 12,348(31)
	fneg 0,0
	fneg 13,13
	fneg 12,12
	stfs 0,340(31)
	stfs 13,344(31)
	stfs 12,348(31)
.L437:
	lis 9,st@ha
	la 30,st@l(9)
	lwz 0,28(30)
	cmpwi 0,0,0
	bc 4,2,.L438
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC81@ha
	mtlr 0
	la 3,.LC81@l(3)
	crxor 6,6,6
	blrl
	li 0,90
	stw 0,28(30)
.L438:
	lfs 13,20(31)
	lis 29,0x4330
	lfs 12,16(31)
	lis 11,.LC83@ha
	addi 3,31,16
	lfs 0,24(31)
	la 11,.LC83@l(11)
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
	lis 9,.LC84@ha
	lfs 0,328(31)
	lis 11,door_use@ha
	la 9,.LC84@l(9)
	la 11,door_use@l(11)
	lfs 13,0(9)
	lis 9,door_blocked@ha
	stw 11,448(31)
	la 9,door_blocked@l(9)
	fcmpu 0,0,13
	stw 9,440(31)
	bc 4,2,.L439
	lis 0,0x42c8
	stw 0,328(31)
.L439:
	lfs 0,332(31)
	fcmpu 0,0,13
	bc 4,2,.L440
	lfs 0,328(31)
	stfs 0,332(31)
.L440:
	lfs 0,336(31)
	fcmpu 0,0,13
	bc 4,2,.L441
	lfs 0,328(31)
	stfs 0,336(31)
.L441:
	lfs 0,592(31)
	fcmpu 0,0,13
	bc 4,2,.L442
	lis 0,0x4040
	stw 0,592(31)
.L442:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L443
	stw 28,516(31)
.L443:
	lwz 0,528(31)
	cmpwi 0,0,1
	bc 12,2,.L444
	lwz 9,36(30)
	lis 3,.LC74@ha
	la 3,.LC74@l(3)
	mtlr 9
	blrl
	stw 3,700(31)
	lwz 9,36(30)
	lis 3,.LC75@ha
	la 3,.LC75@l(3)
	mtlr 9
	blrl
	stw 3,704(31)
	lwz 9,36(30)
	lis 3,.LC76@ha
	la 3,.LC76@l(3)
	mtlr 9
	blrl
	stw 3,708(31)
.L444:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L445
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
.L445:
	lwz 11,480(31)
	cmpwi 0,11,0
	bc 12,2,.L446
	lis 9,door_killed@ha
	li 0,1
	stw 11,484(31)
	la 9,door_killed@l(9)
	stw 0,512(31)
	stw 9,456(31)
.L446:
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L447
	lwz 0,276(31)
	cmpwi 0,0,0
	bc 12,2,.L447
	lwz 0,36(30)
	lis 3,.LC77@ha
	la 3,.LC77@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,444(31)
.L447:
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
	bc 12,2,.L448
	lwz 0,64(31)
	ori 0,0,4096
	stw 0,64(31)
.L448:
	lwz 0,308(31)
	cmpwi 0,0,0
	bc 4,2,.L449
	stw 31,564(31)
.L449:
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
	bc 4,2,.L451
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L450
.L451:
	lis 9,Think_CalcMoveSpeed@ha
	la 9,Think_CalcMoveSpeed@l(9)
	b .L453
.L450:
	lis 9,Think_SpawnDoorTrigger@ha
	la 9,Think_SpawnDoorTrigger@l(9)
.L453:
	stw 9,436(31)
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe19:
	.size	 SP_func_door_rotating,.Lfe19-SP_func_door_rotating
	.section	".rodata"
	.align 2
.LC85:
	.string	"world/mov_watr.wav"
	.align 2
.LC86:
	.string	"world/stp_watr.wav"
	.align 3
.LC87:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC88:
	.long 0x0
	.align 2
.LC89:
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
	bc 12,2,.L457
	cmpwi 0,0,2
	bc 4,2,.L455
.L457:
	lwz 9,36(30)
	lis 3,.LC85@ha
	la 3,.LC85@l(3)
	mtlr 9
	blrl
	stw 3,700(31)
	lwz 0,36(30)
	lis 3,.LC86@ha
	la 3,.LC86@l(3)
	mtlr 0
	blrl
	stw 3,708(31)
.L455:
	lfs 12,4(31)
	lis 11,st+24@ha
	lfs 13,8(31)
	lis 10,0x4330
	lis 8,.LC87@ha
	lfs 0,12(31)
	la 8,.LC87@l(8)
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
	bc 12,2,.L460
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
.L460:
	lis 9,.LC88@ha
	lfs 0,328(31)
	li 0,1
	la 9,.LC88@l(9)
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
	bc 4,2,.L461
	lis 0,0x41c8
	stw 0,328(31)
.L461:
	lfs 13,592(31)
	lfs 0,328(31)
	fcmpu 0,13,5
	stfs 0,712(31)
	stfs 0,716(31)
	stfs 0,720(31)
	bc 4,2,.L462
	lis 0,0xbf80
	stw 0,592(31)
.L462:
	lis 8,.LC89@ha
	lfs 13,592(31)
	lis 9,door_use@ha
	la 8,.LC89@l(8)
	la 9,door_use@l(9)
	lfs 0,0(8)
	stw 9,448(31)
	stfs 13,728(31)
	fcmpu 0,13,0
	bc 4,2,.L463
	lwz 0,284(31)
	ori 0,0,32
	stw 0,284(31)
.L463:
	lis 9,.LC60@ha
	lis 11,gi+72@ha
	la 9,.LC60@l(9)
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
.Lfe20:
	.size	 SP_func_water,.Lfe20-SP_func_water
	.section	".rodata"
	.align 2
.LC90:
	.long 0x0
	.align 2
.LC91:
	.long 0x3f800000
	.align 2
.LC92:
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
	bc 12,2,.L471
	lwz 29,296(30)
	mr 3,30
	stw 0,296(30)
	lwz 4,548(31)
	bl G_UseTargets
	stw 29,296(30)
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L470
.L471:
	lis 9,.LC90@ha
	lfs 13,728(31)
	la 9,.LC90@l(9)
	lfs 31,0(9)
	fcmpu 0,13,31
	bc 12,2,.L473
	bc 4,1,.L474
	lis 9,level+4@ha
	lis 11,train_next@ha
	lfs 0,level+4@l(9)
	la 11,train_next@l(11)
	stw 11,436(31)
	fadds 0,0,13
	stfs 0,428(31)
	b .L475
.L474:
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L475
	mr 3,31
	bl train_next
	lwz 0,284(31)
	stfs 31,428(31)
	rlwinm 0,0,0,0,30
	stfs 31,384(31)
	stw 0,284(31)
	stfs 31,380(31)
	stfs 31,376(31)
.L475:
	lwz 0,264(31)
	andi. 30,0,1024
	bc 4,2,.L470
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L478
	lis 9,gi+16@ha
	mr 3,31
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC91@ha
	la 9,.LC91@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC92@ha
	la 9,.LC92@l(9)
	lfs 2,0(9)
	lis 9,.LC90@ha
	la 9,.LC90@l(9)
	lfs 3,0(9)
	blrl
.L478:
	stw 30,76(31)
	b .L470
.L473:
	mr 3,31
	bl train_next
.L470:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 train_wait,.Lfe21-train_wait
	.section	".rodata"
	.align 2
.LC93:
	.string	"train_next: bad target %s\n"
	.align 2
.LC94:
	.string	"connected teleport path_corners, see %s at %s\n"
	.align 3
.LC95:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC96:
	.long 0x3f800000
	.align 2
.LC97:
	.long 0x40400000
	.align 2
.LC98:
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
.L481:
	lwz 3,296(28)
	cmpwi 0,3,0
	bc 12,2,.L480
	bl G_PickTarget
	mr. 31,3
	bc 4,2,.L483
	lis 9,gi+4@ha
	lis 3,.LC93@ha
	lwz 4,296(28)
	lwz 0,gi+4@l(9)
	la 3,.LC93@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L480
.L483:
	lwz 0,296(31)
	stw 0,296(28)
	lwz 9,284(31)
	andi. 0,9,1
	bc 12,2,.L484
	cmpwi 0,29,0
	bc 4,2,.L485
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC94@ha
	la 3,.LC94@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L480
.L485:
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
	b .L481
.L484:
	lwz 0,264(28)
	lfs 0,592(31)
	andi. 9,0,1024
	stw 31,324(28)
	stfs 0,728(28)
	bc 4,2,.L486
	lwz 5,700(28)
	cmpwi 0,5,0
	bc 12,2,.L487
	lis 11,.LC96@ha
	lis 9,gi+16@ha
	la 11,.LC96@l(11)
	lwz 0,gi+16@l(9)
	mr 3,28
	lfs 1,0(11)
	lis 9,.LC97@ha
	li 4,10
	lis 11,.LC98@ha
	la 9,.LC97@l(9)
	mtlr 0
	la 11,.LC98@l(11)
	lfs 2,0(9)
	lfs 3,0(11)
	blrl
.L487:
	lwz 0,704(28)
	stw 0,76(28)
.L486:
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
	bc 4,2,.L488
	lfs 0,720(28)
	fcmpu 0,13,0
	bc 4,2,.L488
	lwz 0,264(28)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L489
	lwz 0,564(28)
	cmpw 0,9,0
	bc 12,2,.L490
	b .L491
.L489:
	cmpw 0,9,28
	bc 4,2,.L491
.L490:
	mr 3,28
	bl Move_Begin
	b .L494
.L491:
	lis 11,level+4@ha
	lis 10,.LC95@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC95@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(28)
	b .L495
.L488:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(28)
	lis 10,level+4@ha
	stw 9,436(28)
	lis 11,.LC95@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC95@l(11)
.L495:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(28)
.L494:
	lwz 0,284(28)
	ori 0,0,1
	stw 0,284(28)
.L480:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe22:
	.size	 train_next,.Lfe22-train_next
	.section	".rodata"
	.align 3
.LC99:
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
	bc 4,2,.L497
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L497
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L498
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L499
	b .L500
.L498:
	cmpw 0,9,31
	bc 4,2,.L500
.L499:
	mr 3,31
	bl Move_Begin
	b .L503
.L500:
	lis 11,level+4@ha
	lis 10,.LC99@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC99@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L504
.L497:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC99@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC99@l(11)
.L504:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L503:
	lwz 0,284(31)
	ori 0,0,1
	stw 0,284(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe23:
	.size	 train_resume,.Lfe23-train_resume
	.section	".rodata"
	.align 2
.LC100:
	.string	"train_find: no target\n"
	.align 2
.LC101:
	.string	"train_find: target %s not found\n"
	.align 2
.LC104:
	.string	"func_train without a target at %s\n"
	.align 3
.LC103:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC105:
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
	bc 4,2,.L524
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L518
	li 0,100
.L524:
	stw 0,516(31)
.L518:
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
	bc 12,2,.L520
	lwz 9,36(30)
	mtlr 9
	blrl
	stw 3,704(31)
.L520:
	lis 8,.LC105@ha
	lfs 13,328(31)
	la 8,.LC105@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,2,.L521
	lis 0,0x42c8
	stw 0,328(31)
.L521:
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
	bc 12,2,.L522
	lis 11,level+4@ha
	lis 10,.LC103@ha
	lfs 0,level+4@l(11)
	lis 9,func_train_find@ha
	lfd 13,.LC103@l(10)
	la 9,func_train_find@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	b .L523
.L522:
	addi 3,31,212
	bl vtos
	mr 4,3
	lwz 0,4(30)
	lis 3,.LC104@ha
	la 3,.LC104@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L523:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe24:
	.size	 SP_func_train,.Lfe24-SP_func_train
	.section	".rodata"
	.align 2
.LC106:
	.string	"elevator used with no pathtarget\n"
	.align 2
.LC107:
	.string	"elevator used with bad pathtarget: %s\n"
	.align 2
.LC108:
	.string	"trigger_elevator has no target\n"
	.align 2
.LC109:
	.string	"trigger_elevator unable to find target %s\n"
	.align 2
.LC110:
	.string	"func_train"
	.align 2
.LC111:
	.string	"trigger_elevator target %s is not a train\n"
	.align 2
.LC116:
	.string	"func_timer at %s has random >= wait\n"
	.align 3
.LC115:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC117:
	.long 0x46fffe00
	.align 2
.LC118:
	.long 0x0
	.align 3
.LC119:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC120:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC121:
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
	lis 9,.LC118@ha
	mr 31,3
	la 9,.LC118@l(9)
	lfs 0,592(31)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L541
	lis 0,0x3f80
	stw 0,592(31)
.L541:
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
	bc 4,3,.L542
	fmr 0,13
	lis 9,.LC115@ha
	lis 29,gi@ha
	lfd 13,.LC115@l(9)
	la 29,gi@l(29)
	addi 3,31,4
	fsub 0,0,13
	frsp 0,0
	stfs 0,600(31)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC116@ha
	la 3,.LC116@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L542:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L543
	bl rand
	rlwinm 3,3,0,17,31
	lfs 8,596(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	lfs 9,592(31)
	stw 3,28(1)
	lis 11,.LC119@ha
	lis 8,.LC117@ha
	la 11,.LC119@l(11)
	stw 0,24(1)
	lis 10,st+40@ha
	lfd 10,0(11)
	lfd 12,24(1)
	lis 11,level+4@ha
	lfs 6,.LC117@l(8)
	lis 9,.LC120@ha
	lfs 13,level+4@l(11)
	la 9,.LC120@l(9)
	fsub 12,12,10
	lfd 0,0(9)
	lfs 11,st+40@l(10)
	lis 9,.LC121@ha
	la 9,.LC121@l(9)
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
.L543:
	li 0,1
	stw 0,184(31)
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe25:
	.size	 SP_func_timer,.Lfe25-SP_func_timer
	.section	".rodata"
	.align 3
.LC122:
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
	bc 12,2,.L551
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
	bc 4,2,.L553
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L553
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L554
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L555
	b .L556
.L554:
	cmpw 0,9,31
	bc 4,2,.L556
.L555:
	mr 3,31
	bl Move_Begin
	b .L559
.L556:
	lis 11,level+4@ha
	lis 10,.LC122@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC122@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L567
.L553:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC122@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC122@l(11)
.L567:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L559:
	lwz 0,296(31)
	li 29,0
	cmpwi 0,0,0
	bc 12,2,.L551
	lis 9,gi@ha
	lis 28,.LC59@ha
	la 30,gi@l(9)
	b .L562
.L564:
	lwz 3,280(29)
	la 4,.LC59@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L562
	lwz 9,64(30)
	li 4,1
	lwz 3,644(29)
	mtlr 9
	blrl
.L562:
	lwz 5,296(31)
	mr 3,29
	li 4,300
	bl G_Find
	mr. 29,3
	bc 4,2,.L564
.L551:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 door_secret_use,.Lfe26-door_secret_use
	.section	".rodata"
	.align 3
.LC123:
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
	bc 4,2,.L570
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L570
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L571
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L572
	b .L573
.L571:
	cmpw 0,9,31
	bc 4,2,.L573
.L572:
	mr 3,31
	bl Move_Begin
	b .L576
.L573:
	lis 11,level+4@ha
	lis 10,.LC123@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC123@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L577
.L570:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC123@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC123@l(11)
.L577:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L576:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 door_secret_move2,.Lfe27-door_secret_move2
	.section	".rodata"
	.align 3
.LC124:
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
	bc 4,2,.L581
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L581
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L582
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L583
	b .L584
.L582:
	cmpw 0,9,31
	bc 4,2,.L584
.L583:
	mr 3,31
	bl Move_Begin
	b .L587
.L584:
	lis 11,level+4@ha
	lis 10,.LC124@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC124@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L588
.L581:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC124@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC124@l(11)
.L588:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L587:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe28:
	.size	 door_secret_move4,.Lfe28-door_secret_move4
	.section	".rodata"
	.align 3
.LC125:
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
	bc 4,2,.L591
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L591
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L592
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L593
	b .L594
.L592:
	cmpw 0,9,31
	bc 4,2,.L594
.L593:
	mr 3,31
	bl Move_Begin
	b .L597
.L594:
	lis 11,level+4@ha
	lis 10,.LC125@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC125@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L598
.L591:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC125@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC125@l(11)
.L598:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L597:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 door_secret_move6,.Lfe29-door_secret_move6
	.section	".rodata"
	.align 2
.LC126:
	.long 0x0
	.align 3
.LC127:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC128:
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
	lis 3,.LC74@ha
	lwz 9,36(29)
	la 3,.LC74@l(3)
	mtlr 9
	blrl
	stw 3,700(31)
	lwz 9,36(29)
	lis 3,.LC75@ha
	la 3,.LC75@l(3)
	mtlr 9
	blrl
	stw 3,704(31)
	lwz 9,36(29)
	lis 3,.LC76@ha
	la 3,.LC76@l(3)
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
	bc 12,2,.L617
	lwz 0,284(31)
	andi. 7,0,1
	bc 12,2,.L616
.L617:
	lis 9,door_secret_die@ha
	li 11,0
	la 9,door_secret_die@l(9)
	li 0,1
	stw 11,480(31)
	stw 0,512(31)
	stw 9,456(31)
.L616:
	lwz 0,516(31)
	cmpwi 0,0,0
	bc 4,2,.L618
	li 0,2
	stw 0,516(31)
.L618:
	lis 9,.LC126@ha
	lfs 0,592(31)
	la 9,.LC126@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L619
	lis 0,0x40a0
	stw 0,592(31)
.L619:
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
	lis 7,.LC127@ha
	mr 8,29
	stfs 31,16(31)
	rlwinm 0,11,0,30,30
	la 7,.LC127@l(7)
	stfs 31,24(31)
	xoris 0,0,0x8000
	lfd 12,0(7)
	mr 4,28
	stw 0,68(1)
	lis 7,.LC128@ha
	stw 10,64(1)
	la 7,.LC128@l(7)
	andi. 0,11,4
	lfd 0,64(1)
	lfd 13,0(7)
	stfs 31,20(31)
	fsub 0,0,12
	fsub 13,13,0
	frsp 7,13
	bc 12,2,.L620
	lfs 0,240(31)
	lfs 12,44(1)
	lfs 10,236(31)
	lfs 13,40(1)
	fmr 8,0
	fmuls 12,12,0
	lfs 11,244(31)
	lfs 0,48(1)
	b .L627
.L620:
	lfs 0,240(31)
	lfs 12,28(1)
	lfs 10,236(31)
	lfs 13,24(1)
	fmr 8,0
	fmuls 12,12,0
	lfs 11,244(31)
	lfs 0,32(1)
.L627:
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
	bc 12,2,.L622
	fneg 1,1
	addi 29,31,352
	addi 3,31,4
	b .L628
.L622:
	fmuls 1,7,1
	addi 29,31,352
	addi 3,31,4
	mr 4,8
.L628:
	mr 5,29
	bl VectorMA
	mr 3,29
	fmr 1,31
	addi 4,1,8
	addi 5,31,364
	bl VectorMA
	lwz 11,480(31)
	cmpwi 0,11,0
	bc 12,2,.L624
	lis 9,door_killed@ha
	li 0,1
	stw 11,484(31)
	la 9,door_killed@l(9)
	stw 0,512(31)
	stw 9,456(31)
	b .L625
.L624:
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 12,2,.L625
	lwz 0,276(31)
	cmpwi 0,0,0
	bc 12,2,.L625
	lis 9,gi+36@ha
	lis 3,.LC77@ha
	lwz 0,gi+36@l(9)
	la 3,.LC77@l(3)
	mtlr 0
	blrl
	lis 9,door_touch@ha
	la 9,door_touch@l(9)
	stw 9,444(31)
.L625:
	lis 9,.LC60@ha
	lis 11,gi+72@ha
	la 9,.LC60@l(9)
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
.Lfe30:
	.size	 SP_func_door_secret,.Lfe30-SP_func_door_secret
	.align 2
	.globl Use_Plat
	.type	 Use_Plat,@function
Use_Plat:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,436(3)
	cmpwi 0,0,0
	bc 4,2,.L125
	bl plat_go_down
.L125:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 Use_Plat,.Lfe31-Use_Plat
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
.Lfe32:
	.size	 Move_Done,.Lfe32-Move_Done
	.section	".rodata"
	.align 3
.LC129:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC130:
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
	lis 9,.LC130@ha
	mr 31,3
	la 9,.LC130@l(9)
	lfs 1,760(31)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,2,.L31
	lwz 9,768(31)
	stfs 0,376(31)
	mtlr 9
	stfs 0,384(31)
	stfs 0,380(31)
	blrl
	b .L30
.L31:
	lis 9,.LC129@ha
	addi 3,31,736
	lfd 31,.LC129@l(9)
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
.L30:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe33:
	.size	 Move_Final,.Lfe33-Move_Final
	.section	".rodata"
	.align 3
.LC131:
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
	bc 4,2,.L39
	lfs 0,720(31)
	fcmpu 0,13,0
	bc 4,2,.L39
	lwz 0,264(31)
	lis 9,level+292@ha
	lwz 9,level+292@l(9)
	andi. 11,0,1024
	bc 12,2,.L41
	lwz 0,564(31)
	cmpw 0,9,0
	bc 12,2,.L42
	b .L40
.L41:
	cmpw 0,9,31
	bc 4,2,.L40
.L42:
	mr 3,31
	bl Move_Begin
	b .L44
.L40:
	lis 11,level+4@ha
	lis 10,.LC131@ha
	lfs 0,level+4@l(11)
	lis 9,Move_Begin@ha
	lfd 13,.LC131@l(10)
	la 9,Move_Begin@l(9)
	stw 9,436(31)
	b .L631
.L39:
	lis 9,Think_AccelMove@ha
	li 0,0
	la 9,Think_AccelMove@l(9)
	stw 0,748(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC131@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC131@l(11)
.L631:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L44:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 Move_Calc,.Lfe34-Move_Calc
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
.Lfe35:
	.size	 AngleMove_Done,.Lfe35-AngleMove_Done
	.section	".rodata"
	.align 3
.LC132:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC133:
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
	bc 4,2,.L47
	lfs 11,16(31)
	lfs 13,688(31)
	lfs 12,692(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,696(31)
	b .L632
.L47:
	lfs 11,16(31)
	lfs 13,664(31)
	lfs 12,668(31)
	lfs 10,20(31)
	fsubs 13,13,11
	lfs 0,672(31)
.L632:
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
	bc 12,2,.L49
	lwz 9,768(31)
	mr 3,31
	li 0,0
	stw 0,388(31)
	mtlr 9
	stw 0,396(31)
	stw 0,392(31)
	blrl
	b .L46
.L49:
	lis 9,.LC133@ha
	addi 3,1,8
	la 9,.LC133@l(9)
	addi 4,31,388
	lfs 1,0(9)
	bl VectorScale
	lis 9,AngleMove_Done@ha
	lis 10,level+4@ha
	la 9,AngleMove_Done@l(9)
	lis 11,.LC132@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC132@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L46:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 AngleMove_Final,.Lfe36-AngleMove_Final
	.section	".rodata"
	.align 3
.LC134:
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
	bc 12,2,.L64
	lwz 0,564(3)
	cmpw 0,9,0
	bc 12,2,.L65
	b .L63
.L64:
	cmpw 0,9,3
	bc 4,2,.L63
.L65:
	bl AngleMove_Begin
	b .L66
.L63:
	lis 11,level+4@ha
	lis 10,.LC134@ha
	lfs 0,level+4@l(11)
	lis 9,AngleMove_Begin@ha
	lfd 13,.LC134@l(10)
	la 9,AngleMove_Begin@l(9)
	stw 9,436(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
.L66:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 AngleMove_Calc,.Lfe37-AngleMove_Calc
	.section	".rodata"
	.align 2
.LC135:
	.long 0x3f000000
	.align 2
.LC136:
	.long 0x0
	.align 2
.LC137:
	.long 0x3f800000
	.align 2
.LC138:
	.long 0x40800000
	.align 2
.LC139:
	.long 0xc0000000
	.align 3
.LC140:
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
	bc 4,0,.L68
	stfs 9,96(31)
	b .L67
.L68:
	fdivs 0,11,10
	lfs 31,68(31)
	lis 9,.LC135@ha
	la 9,.LC135@l(9)
	lfs 30,0(9)
	lis 9,.LC136@ha
	la 9,.LC136@l(9)
	lfs 12,0(9)
	lis 9,.LC137@ha
	la 9,.LC137@l(9)
	lfs 29,0(9)
	fdivs 13,11,31
	fmadds 0,0,11,11
	fmadds 13,13,11,11
	fmuls 0,0,30
	fmuls 1,13,30
	fsubs 0,9,0
	fsubs 0,0,1
	fcmpu 0,0,12
	bc 4,0,.L69
	fmuls 12,10,31
	lis 9,.LC138@ha
	fadds 31,10,31
	la 9,.LC138@l(9)
	lfs 1,0(9)
	lis 9,.LC139@ha
	fdivs 31,31,12
	la 9,.LC139@l(9)
	lfs 13,0(9)
	fmuls 0,31,1
	fmuls 13,9,13
	fmuls 0,0,13
	fsubs 1,1,0
	bl sqrt
	lis 9,.LC140@ha
	fadds 31,31,31
	lfs 13,68(31)
	la 9,.LC140@l(9)
	lfd 0,0(9)
	fadd 1,1,0
	fdiv 1,1,31
	frsp 1,1
	fdivs 13,1,13
	stfs 1,100(31)
	fadds 13,13,29
	fmuls 1,1,13
	fmuls 1,1,30
.L69:
	stfs 1,112(31)
.L67:
	lwz 0,52(1)
	mtlr 0
	lwz 31,20(1)
	lfd 29,24(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe38:
	.size	 plat_CalcAcceleratedMove,.Lfe38-plat_CalcAcceleratedMove
	.section	".rodata"
	.align 2
.LC141:
	.long 0x3f800000
	.align 2
.LC142:
	.long 0x40400000
	.align 2
.LC143:
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
	bc 4,2,.L91
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L92
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC141@ha
	la 9,.LC141@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC142@ha
	la 9,.LC142@l(9)
	lfs 2,0(9)
	lis 9,.LC143@ha
	la 9,.LC143@l(9)
	lfs 3,0(9)
	blrl
.L92:
	stw 30,76(31)
.L91:
	lis 9,plat_go_down@ha
	li 0,0
	la 9,plat_go_down@l(9)
	stw 0,732(31)
	lis 11,level+4@ha
	stw 9,436(31)
	lis 9,.LC142@ha
	lfs 0,level+4@l(11)
	la 9,.LC142@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe39:
	.size	 plat_hit_top,.Lfe39-plat_hit_top
	.section	".rodata"
	.align 2
.LC144:
	.long 0x3f800000
	.align 2
.LC145:
	.long 0x40400000
	.align 2
.LC146:
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
	bc 4,2,.L94
	lwz 5,708(31)
	cmpwi 0,5,0
	bc 12,2,.L95
	lis 9,gi+16@ha
	lwz 0,gi+16@l(9)
	li 4,10
	lis 9,.LC144@ha
	la 9,.LC144@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC145@ha
	la 9,.LC145@l(9)
	lfs 2,0(9)
	lis 9,.LC146@ha
	la 9,.LC146@l(9)
	lfs 3,0(9)
	blrl
.L95:
	stw 30,76(31)
.L94:
	li 0,1
	stw 0,732(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe40:
	.size	 plat_hit_bottom,.Lfe40-plat_hit_bottom
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
	bc 4,2,.L119
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L119
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
	bc 12,2,.L118
	mr 3,31
	bl Handle_Unique_Items
	mr 3,31
	bl G_FreeEdict
	b .L118
.L119:
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
	bc 4,2,.L122
	mr 3,30
	bl plat_go_down
	b .L118
.L122:
	cmpwi 0,0,3
	bc 4,2,.L118
	mr 3,30
	bl plat_go_up
.L118:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe41:
	.size	 plat_blocked,.Lfe41-plat_blocked
	.section	".rodata"
	.align 2
.LC147:
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
	bc 12,2,.L127
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L127
	lwz 3,540(3)
	lwz 0,732(3)
	cmpwi 0,0,1
	bc 4,2,.L130
	bl plat_go_up
	b .L127
.L130:
	cmpwi 0,0,0
	bc 4,2,.L127
	lis 11,.LC147@ha
	lis 9,level+4@ha
	la 11,.LC147@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,428(3)
.L127:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe42:
	.size	 Touch_Plat_Center,.Lfe42-Touch_Plat_Center
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
.Lfe43:
	.size	 rotating_blocked,.Lfe43-rotating_blocked
	.section	".rodata"
	.align 2
.LC148:
	.long 0x0
	.section	".text"
	.align 2
	.globl rotating_touch
	.type	 rotating_touch,@function
rotating_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,.LC148@ha
	mr 11,3
	la 9,.LC148@l(9)
	lfs 0,388(11)
	mr 3,4
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L154
	lfs 0,392(11)
	fcmpu 0,0,13
	bc 4,2,.L154
	lfs 0,396(11)
	fcmpu 0,0,13
	bc 12,2,.L153
.L154:
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
.L153:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe44:
	.size	 rotating_touch,.Lfe44-rotating_touch
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
	bc 4,2,.L156
	li 0,0
	stw 3,444(31)
	stw 0,388(31)
	stw 3,76(31)
	stw 0,396(31)
	stw 0,392(31)
	b .L157
.L156:
	lwz 0,704(31)
	mr 4,30
	addi 3,31,340
	lfs 1,328(31)
	stw 0,76(31)
	bl VectorScale
	lwz 0,284(31)
	andi. 9,0,16
	bc 12,2,.L157
	lis 9,rotating_touch@ha
	la 9,rotating_touch@l(9)
	stw 9,444(31)
.L157:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe45:
	.size	 rotating_use,.Lfe45-rotating_use
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
.Lfe46:
	.size	 button_done,.Lfe46-button_done
	.section	".rodata"
	.align 2
.LC149:
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
	lis 9,.LC149@ha
	lfs 13,728(31)
	li 0,1
	la 9,.LC149@l(9)
	stw 0,56(31)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L185
	lis 9,level+4@ha
	lis 11,button_return@ha
	lfs 0,level+4@l(9)
	la 11,button_return@l(11)
	stw 11,436(31)
	fadds 0,0,13
	stfs 0,428(31)
.L185:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe47:
	.size	 button_wait,.Lfe47-button_wait
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
.Lfe48:
	.size	 button_use,.Lfe48-button_use
	.align 2
	.globl button_touch
	.type	 button_touch,@function
button_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L198
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L198
	stw 4,548(3)
	bl button_fire
.L198:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe49:
	.size	 button_touch,.Lfe49-button_touch
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
.Lfe50:
	.size	 button_killed,.Lfe50-button_killed
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
	lis 27,.LC59@ha
	la 28,gi@l(9)
	b .L214
.L216:
	lwz 3,280(31)
	la 4,.LC59@l(27)
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
.Lfe51:
	.size	 door_use_areaportals,.Lfe51-door_use_areaportals
	.section	".rodata"
	.align 2
.LC150:
	.long 0x3f800000
	.align 2
.LC151:
	.long 0x40400000
	.align 2
.LC152:
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
	lis 9,.LC150@ha
	la 9,.LC150@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC151@ha
	la 9,.LC151@l(9)
	lfs 2,0(9)
	lis 9,.LC152@ha
	la 9,.LC152@l(9)
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
	lis 9,.LC152@ha
	lfs 13,728(31)
	la 9,.LC152@l(9)
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
.Lfe52:
	.size	 door_hit_top,.Lfe52-door_hit_top
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
	lis 28,.LC59@ha
	la 29,gi@l(9)
	b .L229
.L231:
	lwz 3,280(30)
	la 4,.LC59@l(28)
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
.Lfe53:
	.size	 door_hit_bottom,.Lfe53-door_hit_bottom
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
	bc 4,2,.L285
	lwz 0,284(3)
	andi. 11,0,32
	bc 12,2,.L287
	lwz 0,732(3)
	subfic 11,0,0
	adde 9,11,0
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L287
	mr. 31,3
	bc 12,2,.L285
	li 30,0
.L292:
	stw 30,276(31)
	mr 3,31
	stw 30,444(31)
	bl door_go_down
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L292
	b .L285
.L287:
	mr. 31,3
	bc 12,2,.L285
	li 30,0
.L297:
	stw 30,276(31)
	mr 3,31
	mr 4,29
	stw 30,444(31)
	bl door_go_up
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L297
.L285:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe54:
	.size	 door_use,.Lfe54-door_use
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
	bc 12,2,.L325
.L327:
	lfs 0,724(9)
	fabs 0,0
	fcmpu 0,0,13
	bc 4,0,.L326
	fmr 13,0
.L326:
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L327
.L325:
	mr. 9,3
	fdivs 0,13,12
	bclr 12,2
	fmr 9,0
.L333:
	lfs 0,724(9)
	lfs 13,716(9)
	lfs 11,712(9)
	fcmpu 0,11,13
	fabs 0,0
	fdiv 0,0,9
	frsp 12,0
	fdivs 10,12,13
	bc 4,2,.L334
	stfs 12,712(9)
	b .L335
.L334:
	fmuls 0,11,10
	stfs 0,712(9)
.L335:
	lfs 13,720(9)
	lfs 0,716(9)
	fcmpu 0,13,0
	bc 4,2,.L336
	stfs 12,720(9)
	b .L337
.L336:
	fmuls 0,13,10
	stfs 0,720(9)
.L337:
	stfs 12,716(9)
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L333
	blr
.Lfe55:
	.size	 Think_CalcMoveSpeed,.Lfe55-Think_CalcMoveSpeed
	.section	".rodata"
	.align 2
.LC156:
	.long 0x0
	.section	".text"
	.align 2
	.globl door_blocked
	.type	 door_blocked,@function
door_blocked:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,4
	lwz 0,184(31)
	andi. 9,0,4
	bc 4,2,.L372
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L372
	stw 0,8(1)
	lis 6,vec3_origin@ha
	mr 4,3
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
	bc 12,2,.L371
	mr 3,31
	bl Handle_Unique_Items
	mr 3,31
	bl G_FreeEdict
	b .L371
.L372:
	lwz 0,284(3)
	andi. 9,0,4
	bc 4,2,.L371
	lis 9,.LC156@ha
	lfs 13,728(3)
	la 9,.LC156@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L371
	lwz 0,732(3)
	cmpwi 0,0,3
	bc 4,2,.L377
	lwz 31,564(3)
	cmpwi 0,31,0
	bc 12,2,.L371
.L381:
	lwz 4,548(31)
	mr 3,31
	bl door_go_up
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L381
	b .L371
.L377:
	lwz 31,564(3)
	cmpwi 0,31,0
	bc 12,2,.L371
.L387:
	mr 3,31
	bl door_go_down
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L387
.L371:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe56:
	.size	 door_blocked,.Lfe56-door_blocked
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
	bc 12,2,.L391
	li 11,0
.L393:
	lwz 0,484(9)
	stw 11,512(9)
	stw 0,480(9)
	lwz 9,560(9)
	cmpwi 0,9,0
	bc 4,2,.L393
.L391:
	lwz 3,564(3)
	lwz 0,264(3)
	andi. 9,0,1024
	bc 4,2,.L396
	lwz 0,284(3)
	andi. 11,0,32
	bc 12,2,.L397
	lwz 0,732(3)
	subfic 11,0,0
	adde 9,11,0
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L397
	mr. 31,3
	bc 12,2,.L396
	li 30,0
.L401:
	stw 30,276(31)
	mr 3,31
	stw 30,444(31)
	bl door_go_down
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L401
	b .L396
.L397:
	mr. 31,3
	bc 12,2,.L396
	li 30,0
.L406:
	stw 30,276(31)
	mr 3,31
	mr 4,29
	stw 30,444(31)
	bl door_go_up
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L406
.L396:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe57:
	.size	 door_killed,.Lfe57-door_killed
	.section	".rodata"
	.align 3
.LC157:
	.long 0x40140000
	.long 0x0
	.align 2
.LC158:
	.long 0x3f800000
	.align 2
.LC159:
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
	bc 12,2,.L409
	lis 9,level+4@ha
	lfs 0,460(11)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L409
	lis 9,.LC157@ha
	fmr 0,13
	lwz 5,276(11)
	lis 4,.LC72@ha
	la 9,.LC157@l(9)
	la 4,.LC72@l(4)
	lfd 13,0(9)
	mr 3,31
	fadd 0,0,13
	frsp 0,0
	stfs 0,460(11)
	crxor 6,6,6
	bl safe_centerprintf
	lis 29,gi@ha
	lis 3,.LC73@ha
	la 29,gi@l(29)
	la 3,.LC73@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC158@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC158@l(9)
	li 4,0
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC158@ha
	la 9,.LC158@l(9)
	lfs 2,0(9)
	lis 9,.LC159@ha
	la 9,.LC159@l(9)
	lfs 3,0(9)
	blrl
.L409:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe58:
	.size	 door_touch,.Lfe58-door_touch
	.section	".rodata"
	.align 3
.LC160:
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
	bc 4,2,.L465
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L465
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
	bc 12,2,.L464
	mr 3,31
	bl Handle_Unique_Items
	mr 3,31
	bl G_FreeEdict
	b .L464
.L465:
	lis 9,level+4@ha
	lfs 0,460(12)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L464
	lwz 9,516(12)
	cmpwi 0,9,0
	bc 12,2,.L464
	lis 11,.LC160@ha
	fmr 0,13
	lis 6,vec3_origin@ha
	la 11,.LC160@l(11)
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
.L464:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe59:
	.size	 train_blocked,.Lfe59-train_blocked
	.section	".rodata"
	.align 3
.LC161:
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
	bc 4,2,.L506
	lis 9,gi+4@ha
	lis 3,.LC100@ha
	lwz 0,gi+4@l(9)
	la 3,.LC100@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L505
.L506:
	bl G_PickTarget
	mr. 11,3
	bc 4,2,.L507
	lis 9,gi+4@ha
	lis 3,.LC101@ha
	lwz 4,296(31)
	lwz 0,gi+4@l(9)
	la 3,.LC101@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L505
.L507:
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
	bc 4,2,.L508
	lwz 0,284(31)
	ori 0,0,1
	stw 0,284(31)
.L508:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L505
	lis 11,level+4@ha
	lis 10,.LC161@ha
	lfs 0,level+4@l(11)
	lis 9,train_next@ha
	lfd 13,.LC161@l(10)
	la 9,train_next@l(9)
	stw 9,436(31)
	stw 31,548(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L505:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe60:
	.size	 func_train_find,.Lfe60-func_train_find
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
	bc 12,2,.L511
	andi. 0,9,2
	bc 12,2,.L510
	li 0,0
	rlwinm 9,9,0,0,30
	stw 0,428(3)
	stw 9,284(3)
	stw 0,384(3)
	stw 0,380(3)
	stw 0,376(3)
	b .L510
.L511:
	lwz 0,324(3)
	cmpwi 0,0,0
	bc 12,2,.L514
	bl train_resume
	b .L510
.L514:
	bl train_next
.L510:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe61:
	.size	 train_use,.Lfe61-train_use
	.section	".rodata"
	.align 2
.LC162:
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
	lis 9,.LC162@ha
	mr 31,3
	la 9,.LC162@l(9)
	mr 30,4
	lfs 13,0(9)
	lwz 9,416(31)
	lfs 0,428(9)
	fcmpu 0,0,13
	bc 4,2,.L525
	lwz 3,312(30)
	cmpwi 0,3,0
	bc 4,2,.L527
	lis 9,gi+4@ha
	lis 3,.LC106@ha
	lwz 0,gi+4@l(9)
	la 3,.LC106@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L525
.L527:
	bl G_PickTarget
	mr. 3,3
	bc 4,2,.L528
	lis 9,gi+4@ha
	lis 3,.LC107@ha
	lwz 4,312(30)
	lwz 0,gi+4@l(9)
	la 3,.LC107@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L525
.L528:
	lwz 9,416(31)
	stw 3,324(9)
	lwz 3,416(31)
	bl train_resume
.L525:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe62:
	.size	 trigger_elevator_use,.Lfe62-trigger_elevator_use
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
	bc 4,2,.L530
	lis 9,gi+4@ha
	lis 3,.LC108@ha
	lwz 0,gi+4@l(9)
	la 3,.LC108@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L529
.L530:
	bl G_PickTarget
	cmpwi 0,3,0
	stw 3,416(31)
	bc 4,2,.L531
	lis 9,gi+4@ha
	lis 3,.LC109@ha
	lwz 4,296(31)
	lwz 0,gi+4@l(9)
	la 3,.LC109@l(3)
	b .L633
.L531:
	lwz 3,280(3)
	lis 4,.LC110@ha
	la 4,.LC110@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L532
	lis 9,gi+4@ha
	lis 3,.LC111@ha
	lwz 4,296(31)
	lwz 0,gi+4@l(9)
	la 3,.LC111@l(3)
.L633:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L529
.L532:
	lis 9,trigger_elevator_use@ha
	li 0,1
	la 9,trigger_elevator_use@l(9)
	stw 0,184(31)
	stw 9,448(31)
.L529:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe63:
	.size	 trigger_elevator_init,.Lfe63-trigger_elevator_init
	.section	".rodata"
	.align 3
.LC163:
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
	lis 11,.LC163@ha
	stw 9,436(3)
	lfs 0,level+4@l(10)
	lfd 13,.LC163@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe64:
	.size	 SP_trigger_elevator,.Lfe64-SP_trigger_elevator
	.section	".rodata"
	.align 2
.LC164:
	.long 0x46fffe00
	.align 3
.LC165:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC166:
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
	lis 8,.LC165@ha
	lis 10,.LC164@ha
	la 8,.LC165@l(8)
	stw 0,24(1)
	lis 11,level+4@ha
	lfd 0,0(8)
	lfd 13,24(1)
	lis 8,.LC166@ha
	lfs 9,.LC164@l(10)
	la 8,.LC166@l(8)
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
.Lfe65:
	.size	 func_timer_think,.Lfe65-func_timer_think
	.section	".rodata"
	.align 2
.LC167:
	.long 0x46fffe00
	.align 2
.LC168:
	.long 0x0
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
	.globl func_timer_use
	.type	 func_timer_use,@function
func_timer_use:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 8,.LC168@ha
	mr 31,3
	la 8,.LC168@l(8)
	lfs 0,428(31)
	mr 4,5
	lfs 12,0(8)
	stw 4,548(31)
	fcmpu 0,0,12
	bc 12,2,.L536
	stfs 12,428(31)
	b .L535
.L536:
	lfs 13,596(31)
	fcmpu 0,13,12
	bc 12,2,.L537
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	fadds 0,0,13
	b .L634
.L537:
	mr 3,31
	bl G_UseTargets
	bl rand
	rlwinm 3,3,0,17,31
	lfs 8,592(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	lfs 11,600(31)
	stw 3,20(1)
	lis 8,.LC169@ha
	lis 10,.LC167@ha
	la 8,.LC169@l(8)
	stw 0,16(1)
	lis 11,level+4@ha
	lfd 0,0(8)
	lfd 13,16(1)
	lis 8,.LC170@ha
	lfs 9,.LC167@l(10)
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
.L634:
	stfs 0,428(31)
.L535:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe66:
	.size	 func_timer_use,.Lfe66-func_timer_use
	.section	".rodata"
	.align 3
.LC171:
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
	bc 12,2,.L545
	li 0,0
	rlwinm 9,11,0,0,30
	stw 0,328(3)
	stw 9,284(3)
	b .L546
.L545:
	lwz 0,532(3)
	lis 10,0x4330
	lis 8,.LC171@ha
	ori 11,11,1
	xoris 0,0,0x8000
	la 8,.LC171@l(8)
	stw 11,284(3)
	stw 0,12(1)
	stw 10,8(1)
	lfd 13,0(8)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,328(3)
.L546:
	lwz 0,284(3)
	andi. 0,0,2
	bc 4,2,.L547
	stw 0,532(3)
.L547:
	la 1,16(1)
	blr
.Lfe67:
	.size	 func_conveyor_use,.Lfe67-func_conveyor_use
	.section	".rodata"
	.align 2
.LC172:
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
	lis 9,.LC172@ha
	mr 31,3
	la 9,.LC172@l(9)
	lfs 0,328(31)
	lfs 12,0(9)
	fcmpu 0,0,12
	bc 4,2,.L549
	lis 0,0x42c8
	stw 0,328(31)
.L549:
	lwz 0,284(31)
	andi. 9,0,1
	bc 4,2,.L550
	lfs 0,328(31)
	stfs 12,328(31)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	stw 9,532(31)
.L550:
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
.Lfe68:
	.size	 SP_func_conveyor,.Lfe68-SP_func_conveyor
	.section	".rodata"
	.align 3
.LC173:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl door_secret_move1
	.type	 door_secret_move1,@function
door_secret_move1:
	lis 11,level+4@ha
	lis 9,.LC173@ha
	lfs 0,level+4@l(11)
	la 9,.LC173@l(9)
	lfd 13,0(9)
	lis 9,door_secret_move2@ha
	la 9,door_secret_move2@l(9)
	stw 9,436(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe69:
	.size	 door_secret_move1,.Lfe69-door_secret_move1
	.section	".rodata"
	.align 2
.LC174:
	.long 0xbf800000
	.section	".text"
	.align 2
	.globl door_secret_move3
	.type	 door_secret_move3,@function
door_secret_move3:
	lis 9,.LC174@ha
	lfs 13,592(3)
	la 9,.LC174@l(9)
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
.Lfe70:
	.size	 door_secret_move3,.Lfe70-door_secret_move3
	.section	".rodata"
	.align 3
.LC175:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl door_secret_move5
	.type	 door_secret_move5,@function
door_secret_move5:
	lis 11,level+4@ha
	lis 9,.LC175@ha
	lfs 0,level+4@l(11)
	la 9,.LC175@l(9)
	lfd 13,0(9)
	lis 9,door_secret_move6@ha
	la 9,door_secret_move6@l(9)
	stw 9,436(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe71:
	.size	 door_secret_move5,.Lfe71-door_secret_move5
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
	bc 12,2,.L601
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L600
.L601:
	li 0,0
	li 9,1
	stw 0,480(31)
	stw 9,512(31)
.L600:
	lwz 0,296(31)
	li 30,0
	cmpwi 0,0,0
	bc 12,2,.L603
	lis 9,gi@ha
	lis 28,.LC59@ha
	la 29,gi@l(9)
	b .L604
.L606:
	lwz 3,280(30)
	la 4,.LC59@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L604
	lwz 9,64(29)
	li 4,0
	lwz 3,644(30)
	mtlr 9
	blrl
.L604:
	lwz 5,296(31)
	mr 3,30
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L606
.L603:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe72:
	.size	 door_secret_done,.Lfe72-door_secret_done
	.section	".rodata"
	.align 3
.LC176:
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
	bc 4,2,.L610
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L610
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
	bc 12,2,.L609
	mr 3,31
	bl Handle_Unique_Items
	mr 3,31
	bl G_FreeEdict
	b .L609
.L610:
	lis 9,level+4@ha
	lfs 0,460(12)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L609
	lis 9,.LC176@ha
	fmr 0,13
	lis 6,vec3_origin@ha
	la 9,.LC176@l(9)
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
.L609:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe73:
	.size	 door_secret_blocked,.Lfe73-door_secret_blocked
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
.Lfe74:
	.size	 door_secret_die,.Lfe74-door_secret_die
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
.Lfe75:
	.size	 use_killbox,.Lfe75-use_killbox
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
.Lfe76:
	.size	 SP_func_killbox,.Lfe76-SP_func_killbox
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
