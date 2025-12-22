	.file	"g_arty.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"You're not an officer, soldier!\n"
	.align 2
.LC1:
	.string	"You are dead!\n"
	.align 2
.LC2:
	.string	"weapon_binoculars"
	.align 2
.LC3:
	.string	"What the hell are you aiming at? Use your binoculars!\n"
	.align 2
.LC4:
	.string	"Aim at the location, sir.\n"
	.align 2
.LC5:
	.string	"Artillery has already been fired, sir!\n"
	.align 2
.LC6:
	.string	"Holding fire sir!\n"
	.align 2
.LC7:
	.string	"Can not fire for another %i minutes, sir!\n"
	.align 2
.LC8:
	.string	"Can not fire for another %i seconds, sir!\n"
	.align 2
.LC9:
	.string	"Sir! Artillery must be fired in open areas at stationary grounds.\n"
	.align 2
.LC10:
	.string	"Ok, give us %d seconds to position the guns!\n"
	.align 2
.LC11:
	.string	"%s/arty/target%i.wav"
	.align 2
.LC12:
	.long 0x42700000
	.align 3
.LC13:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC14:
	.long 0x46000000
	.align 2
.LC15:
	.long 0x3f800000
	.align 2
.LC16:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Arty_f
	.type	 Cmd_Arty_f,@function
Cmd_Arty_f:
	stwu 1,-160(1)
	mflr 0
	stmw 28,144(1)
	stw 0,164(1)
	lis 9,IsValidPlayer@ha
	mr 31,3
	la 9,IsValidPlayer@l(9)
	cmpwi 0,9,0
	bc 12,2,.L6
	lwz 9,84(31)
	lwz 0,3464(9)
	cmpwi 0,0,2
	bc 12,2,.L8
	lis 9,gi+8@ha
	lis 5,.LC0@ha
	lwz 0,gi+8@l(9)
	la 5,.LC0@l(5)
	b .L24
.L8:
	lwz 0,496(31)
	cmpwi 0,0,0
	bc 4,2,.L10
	lwz 0,4396(9)
	cmpwi 0,0,0
	bc 12,2,.L9
.L10:
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC1@l(5)
	b .L24
.L9:
	lwz 9,1796(9)
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	lwz 3,0(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L11
	lis 9,gi+8@ha
	lis 5,.LC3@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC3@l(5)
	b .L24
.L11:
	lwz 8,84(31)
	lwz 0,4132(8)
	andi. 9,0,1
	bc 4,2,.L12
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC4@l(5)
	b .L24
.L12:
	lwz 0,4612(8)
	cmpwi 0,0,0
	bc 12,2,.L14
	lwz 29,4616(8)
	cmpwi 0,29,0
	bc 12,2,.L15
	lis 9,gi+8@ha
	lis 5,.LC5@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC5@l(5)
	b .L24
.L15:
	lis 9,gi+8@ha
	lis 5,.LC6@ha
	lwz 0,gi+8@l(9)
	la 5,.LC6@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	stw 29,4612(9)
	lwz 11,84(31)
	lwz 9,4624(11)
	addi 9,9,-1
	stw 9,4624(11)
	b .L6
.L14:
	lis 9,level+4@ha
	lfs 11,4664(8)
	lfs 12,level+4@l(9)
	fcmpu 0,11,12
	bc 4,1,.L17
	lis 10,arty_max@ha
	lwz 0,4624(8)
	lwz 9,arty_max@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,136(1)
	lwz 11,140(1)
	cmpw 0,0,11
	bc 12,0,.L17
	lis 9,.LC12@ha
	fsubs 13,11,12
	la 9,.LC12@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L18
	lis 6,0x8888
	ori 6,6,34953
	lis 11,gi+8@ha
	lwz 11,gi+8@l(11)
	lis 5,.LC7@ha
	mr 3,31
	fctiwz 0,13
	la 5,.LC7@l(5)
	li 4,2
	mtlr 11
	stfd 0,136(1)
	lwz 9,140(1)
	mulhw 6,9,6
	srawi 0,9,31
	add 6,6,9
	srawi 6,6,5
	subf 6,0,6
	crxor 6,6,6
	blrl
	b .L6
.L18:
	lis 9,gi+8@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC8@ha
	mr 3,31
	la 5,.LC8@l(5)
	li 4,2
	fctiwz 0,13
	mtlr 0
	stfd 0,136(1)
	lwz 6,140(1)
	crxor 6,6,6
	blrl
	b .L6
.L17:
	lwz 8,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,4664(8)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L20
	lis 10,arty_max@ha
	lwz 0,4624(8)
	lwz 9,arty_max@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,136(1)
	lwz 11,140(1)
	cmpw 0,0,11
	bc 12,0,.L20
	li 0,0
	stw 0,4624(8)
.L20:
	lwz 0,512(31)
	lis 11,0x4330
	lis 10,.LC13@ha
	lfs 13,12(31)
	addi 29,1,24
	xoris 0,0,0x8000
	la 10,.LC13@l(10)
	lfs 10,4(31)
	stw 0,140(1)
	addi 30,1,40
	addi 28,1,72
	stw 11,136(1)
	li 6,0
	mr 4,29
	lfd 0,136(1)
	li 5,0
	lfd 11,0(10)
	lfs 12,8(31)
	lwz 3,84(31)
	fsub 0,0,11
	stfs 10,8(1)
	stfs 12,12(1)
	addi 3,3,4264
	frsp 0,0
	fadds 13,13,0
	stfs 13,16(1)
	bl AngleVectors
	lis 9,.LC14@ha
	mr 4,29
	la 9,.LC14@l(9)
	addi 3,1,8
	lfs 1,0(9)
	mr 5,30
	bl VectorMA
	lis 11,gi@ha
	lis 9,0x600
	la 29,gi@l(11)
	ori 9,9,27
	lwz 11,48(29)
	mr 3,28
	addi 4,1,8
	li 5,0
	li 6,0
	mr 7,30
	mr 8,31
	mtlr 11
	blrl
	lwz 9,116(1)
	cmpwi 0,9,0
	bc 12,2,.L21
	lwz 0,16(9)
	andi. 9,0,4
	bc 4,2,.L21
	lfs 0,84(1)
	lis 9,.LC14@ha
	li 0,0
	lwz 11,84(31)
	la 9,.LC14@l(9)
	lis 10,0x3f80
	lfs 1,0(9)
	addi 4,1,56
	addi 3,1,8
	stfs 0,4644(11)
	mr 5,30
	lfs 0,88(1)
	lwz 9,84(31)
	stfs 0,4648(9)
	lfs 0,92(1)
	lwz 11,84(31)
	stfs 0,4652(11)
	stw 0,60(1)
	stw 10,64(1)
	stw 0,56(1)
	bl VectorMA
	lwz 4,84(31)
	lis 9,0x600
	mr 3,28
	lwz 11,48(29)
	ori 9,9,27
	mr 7,30
	li 5,0
	addi 4,4,4644
	li 6,0
	mr 8,31
	mtlr 11
	blrl
	lwz 9,116(1)
	cmpwi 0,9,0
	bc 12,2,.L21
	lwz 0,16(9)
	andi. 9,0,4
	bc 4,2,.L21
	lwz 0,8(29)
	lis 5,.LC9@ha
	mr 3,31
	la 5,.LC9@l(5)
.L24:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L21:
	lfs 0,84(1)
	li 30,1
	cmpwi 0,31,0
	lwz 11,84(31)
	li 0,0
	stfs 0,4632(11)
	lfs 0,88(1)
	lwz 9,84(31)
	stfs 0,4636(9)
	lfs 0,92(1)
	lwz 11,84(31)
	stfs 0,4640(11)
	lwz 9,84(31)
	stw 30,4612(9)
	lwz 11,84(31)
	stw 0,4616(11)
	bc 12,2,.L23
	lis 9,arty_delay@ha
	lwz 11,arty_delay@l(9)
	lis 5,.LC10@ha
	mr 3,31
	lis 9,gi+8@ha
	la 5,.LC10@l(5)
	lfs 0,20(11)
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	fctiwz 13,0
	stfd 13,136(1)
	lwz 6,140(1)
	crxor 6,6,6
	blrl
.L23:
	lwz 11,84(31)
	lis 9,arty_delay@ha
	lis 10,level+4@ha
	lwz 8,arty_delay@l(9)
	lis 29,gi@ha
	lis 3,.LC11@ha
	lwz 9,4624(11)
	la 29,gi@l(29)
	la 3,.LC11@l(3)
	addi 9,9,1
	stw 9,4624(11)
	lfs 0,level+4@l(10)
	lfs 13,20(8)
	lwz 11,84(31)
	fadds 0,0,13
	stfs 0,4660(11)
	lwz 9,84(31)
	stw 30,4628(9)
	lwz 11,84(31)
	lwz 4,3448(11)
	lwz 5,4628(11)
	addi 4,4,100
	crxor 6,6,6
	bl va
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC15@ha
	lwz 0,16(29)
	lis 10,.LC15@ha
	la 9,.LC15@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC15@l(10)
	li 4,3
	mtlr 0
	lis 9,.LC16@ha
	mr 3,31
	lfs 2,0(10)
	la 9,.LC16@l(9)
	lfs 3,0(9)
	blrl
.L6:
	lwz 0,164(1)
	mtlr 0
	lmw 28,144(1)
	la 1,160(1)
	blr
.Lfe1:
	.size	 Cmd_Arty_f,.Lfe1-Cmd_Arty_f
	.section	".rodata"
	.align 2
.LC17:
	.string	"Artillery fire was unsuccessful, sir!\n"
	.align 2
.LC18:
	.string	"%s/arty/hit%i.wav"
	.align 2
.LC19:
	.string	"Artillery fire confirmed, sir!\n"
	.align 3
.LC20:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC21:
	.long 0x46000000
	.align 3
.LC22:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC23:
	.long 0x0
	.align 2
.LC24:
	.long 0x3f800000
	.align 2
.LC25:
	.long 0x43960000
	.align 2
.LC26:
	.long 0x41000000
	.align 2
.LC27:
	.long 0x43480000
	.align 2
.LC28:
	.long 0x41800000
	.align 2
.LC29:
	.long 0x43c80000
	.align 2
.LC30:
	.long 0x41c00000
	.align 2
.LC31:
	.long 0x437a0000
	.align 2
.LC32:
	.long 0x42000000
	.align 2
.LC33:
	.long 0x42200000
	.align 2
.LC34:
	.long 0x43a00000
	.section	".text"
	.align 2
	.globl Think_Arty
	.type	 Think_Arty,@function
Think_Arty:
	stwu 1,-272(1)
	mflr 0
	stfd 31,264(1)
	stmw 27,244(1)
	stw 0,276(1)
	mr 31,3
	lwz 0,512(31)
	lis 11,0x4330
	lis 10,.LC20@ha
	la 10,.LC20@l(10)
	lfs 13,12(31)
	addi 29,1,24
	xoris 0,0,0x8000
	lfd 11,0(10)
	addi 28,1,40
	stw 0,236(1)
	addi 30,1,56
	li 6,0
	stw 11,232(1)
	mr 4,29
	li 5,0
	lfd 0,232(1)
	lfs 10,4(31)
	lfs 12,8(31)
	fsub 0,0,11
	lwz 3,84(31)
	stfs 10,8(1)
	stfs 12,12(1)
	addi 3,3,4264
	frsp 0,0
	fadds 13,13,0
	stfs 13,16(1)
	bl AngleVectors
	lis 9,.LC21@ha
	addi 3,1,8
	la 9,.LC21@l(9)
	mr 4,29
	lfs 1,0(9)
	mr 5,28
	bl VectorMA
	lis 11,gi@ha
	lis 9,0x600
	la 27,gi@l(11)
	addi 4,1,8
	lwz 11,48(27)
	addi 3,1,88
	ori 9,9,27
	mr 7,28
	li 5,0
	mtlr 11
	li 6,0
	mr 8,31
	blrl
	lwz 9,84(31)
	mr 3,30
	lfs 13,4632(9)
	lfs 0,4644(9)
	fsubs 0,0,13
	stfs 0,56(1)
	lfs 0,4636(9)
	lfs 13,4648(9)
	fsubs 13,13,0
	stfs 13,60(1)
	lfs 12,4640(9)
	lfs 0,4652(9)
	fsubs 0,0,12
	stfs 0,64(1)
	bl VectorNormalize
	lwz 11,84(31)
	lis 9,0x600
	addi 3,1,152
	lfs 0,56(1)
	ori 9,9,27
	addi 4,1,8
	lfs 13,4632(11)
	li 5,0
	addi 7,11,4644
	lfs 11,60(1)
	li 6,0
	mr 8,31
	lfs 12,64(1)
	fadds 13,13,0
	lwz 10,48(27)
	mtlr 10
	stfs 13,8(1)
	lfs 0,4636(11)
	fadds 0,0,11
	stfs 0,12(1)
	lfs 13,4640(11)
	fadds 13,13,12
	stfs 13,16(1)
	blrl
	lwz 9,52(27)
	addi 3,1,8
	mtlr 9
	blrl
	cmpwi 0,3,1
	bc 12,2,.L27
	lfs 0,160(1)
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L26
.L27:
	lwz 0,8(27)
	lis 5,.LC17@ha
	mr 3,31
	la 5,.LC17@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L25
.L26:
	lwz 9,84(31)
	lis 10,.LC23@ha
	lis 3,.LC18@ha
	la 10,.LC23@l(10)
	addi 29,1,72
	lwz 4,3448(9)
	la 3,.LC18@l(3)
	lwz 5,4628(9)
	lfs 31,0(10)
	addi 4,4,100
	crxor 6,6,6
	bl va
	lwz 9,36(27)
	mtlr 9
	blrl
	lis 9,.LC24@ha
	lwz 11,16(27)
	lis 10,.LC23@ha
	la 9,.LC24@l(9)
	la 10,.LC23@l(10)
	lfs 2,0(9)
	mr 5,3
	mtlr 11
	li 4,0
	lis 9,.LC24@ha
	lfs 3,0(10)
	mr 3,31
	la 9,.LC24@l(9)
	lfs 1,0(9)
	blrl
	lis 9,.LC25@ha
	addi 4,1,8
	la 9,.LC25@l(9)
	mr 3,31
	lfs 1,0(9)
	mr 5,30
	li 6,700
	li 7,250
	li 8,450
	bl fire_rocket
	lis 9,.LC26@ha
	lfs 12,8(1)
	lis 10,.LC27@ha
	la 9,.LC26@l(9)
	lfs 13,12(1)
	la 10,.LC27@l(10)
	lfs 0,16(1)
	mr 3,31
	mr 4,29
	lfs 11,0(9)
	mr 5,30
	li 6,600
	lfs 1,0(10)
	li 7,450
	li 8,430
	fadds 0,0,31
	fadds 12,12,11
	fadds 13,13,11
	stfs 0,80(1)
	stfs 12,72(1)
	stfs 13,76(1)
	bl fire_rocket
	lis 9,.LC28@ha
	lfs 12,8(1)
	lis 10,.LC29@ha
	la 9,.LC28@l(9)
	lfs 13,12(1)
	la 10,.LC29@l(10)
	lfs 0,16(1)
	mr 3,31
	mr 4,29
	lfs 11,0(9)
	mr 5,30
	li 6,400
	lfs 1,0(10)
	li 7,150
	li 8,500
	fadds 0,0,31
	fadds 12,12,11
	fadds 13,13,11
	stfs 0,80(1)
	stfs 12,72(1)
	stfs 13,76(1)
	bl fire_rocket
	lis 9,.LC30@ha
	lfs 12,8(1)
	lis 10,.LC31@ha
	la 9,.LC30@l(9)
	lfs 13,12(1)
	la 10,.LC31@l(10)
	lfs 11,0(9)
	mr 3,31
	mr 4,29
	lfs 0,16(1)
	mr 5,30
	li 6,600
	lfs 1,0(10)
	li 7,210
	li 8,500
	fadds 12,12,11
	fadds 13,13,11
	fadds 0,0,31
	stfs 12,72(1)
	stfs 13,76(1)
	stfs 0,80(1)
	bl fire_rocket
	lis 9,.LC32@ha
	lfs 12,8(1)
	lis 10,.LC27@ha
	la 9,.LC32@l(9)
	lfs 13,12(1)
	la 10,.LC27@l(10)
	lfs 11,0(9)
	mr 3,31
	mr 4,29
	lfs 0,16(1)
	mr 5,30
	li 6,300
	lfs 1,0(10)
	li 7,430
	li 8,450
	fadds 12,12,11
	fadds 13,13,11
	fadds 0,0,31
	stfs 12,72(1)
	stfs 13,76(1)
	stfs 0,80(1)
	bl fire_rocket
	lis 9,.LC33@ha
	lfs 12,8(1)
	lis 10,.LC34@ha
	la 9,.LC33@l(9)
	lfs 13,12(1)
	la 10,.LC34@l(10)
	lfs 11,0(9)
	mr 5,30
	li 8,480
	lfs 0,16(1)
	mr 4,29
	mr 3,31
	lfs 1,0(10)
	li 6,600
	li 7,240
	fadds 13,13,11
	fadds 0,0,31
	fadds 12,12,11
	stfs 13,76(1)
	stfs 0,80(1)
	stfs 12,72(1)
	bl fire_rocket
	lwz 0,8(27)
	lis 5,.LC19@ha
	mr 3,31
	la 5,.LC19@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lis 11,arty_time@ha
	lis 10,level+4@ha
	lwz 8,84(31)
	lwz 9,arty_time@l(11)
	lfs 0,level+4@l(10)
	lfs 13,20(9)
	fadds 0,0,13
	stfs 0,4664(8)
.L25:
	lwz 0,276(1)
	mtlr 0
	lmw 27,244(1)
	lfd 31,264(1)
	la 1,272(1)
	blr
.Lfe2:
	.size	 Think_Arty,.Lfe2-Think_Arty
	.comm	is_silenced,1,1
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
