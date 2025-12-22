	.file	"g_vechile.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC2:
	.string	"%s at %s needs a target\n"
	.align 2
.LC3:
	.string	"Vechile base touched\n"
	.align 3
.LC6:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl basethink
	.type	 basethink,@function
basethink:
	lis 9,level+4@ha
	lis 11,.LC6@ha
	lfs 12,20(3)
	lfs 0,level+4@l(9)
	lfd 13,.LC6@l(11)
	lwz 9,256(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(3)
	lfs 13,20(9)
	fcmpu 0,13,12
	bc 4,0,.L7
	lis 0,0xc120
	stw 0,636(3)
.L7:
	lwz 9,256(3)
	lfs 13,20(3)
	lfs 0,20(9)
	fcmpu 0,0,13
	bclr 4,1
	lis 0,0x4120
	stw 0,636(3)
	blr
.Lfe1:
	.size	 basethink,.Lfe1-basethink
	.section	".rodata"
	.align 3
.LC7:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl seatthink
	.type	 seatthink,@function
seatthink:
	lis 9,level+4@ha
	lis 11,.LC7@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC7@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(3)
	blr
.Lfe2:
	.size	 seatthink,.Lfe2-seatthink
	.align 2
	.globl vechile_blocked
	.type	 vechile_blocked,@function
vechile_blocked:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lwz 0,788(4)
	mr 9,3
	cmpwi 0,0,0
	bc 12,2,.L11
	lwz 11,840(9)
	mr 3,4
	li 10,0
	mr 4,9
	lis 6,vec3_origin@ha
	lwz 5,256(11)
	la 6,vec3_origin@l(6)
	li 29,32
	lwz 9,792(11)
	addi 7,3,4
	mr 8,6
	addic 0,5,-1
	subfe 0,0,0
	stw 10,8(1)
	andc 5,5,0
	and 11,11,0
	stw 29,12(1)
	li 10,10
	or 5,11,5
	bl T_Damage
.L11:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 vechile_blocked,.Lfe3-vechile_blocked
	.align 2
	.globl vechile_seat_finish_init
	.type	 vechile_seat_finish_init,@function
vechile_seat_finish_init:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 3,532(31)
	cmpwi 0,3,0
	bc 4,2,.L15
	lis 29,gi@ha
	lwz 28,284(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L16
.L15:
	bl G_PickTarget
	stw 3,568(31)
	lfs 13,4(3)
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,968(31)
	lfs 0,8(3)
	fsubs 0,0,12
	stfs 0,972(31)
	lfs 13,12(3)
	fsubs 13,13,11
	stfs 13,976(31)
	stw 31,256(3)
	lwz 9,568(31)
	lwz 11,840(9)
	stw 31,256(11)
.L16:
	lis 9,seatthink@ha
	lwz 11,840(31)
	mr 3,31
	la 9,seatthink@l(9)
	lwz 0,792(31)
	mtlr 9
	stw 0,792(11)
	stw 9,680(31)
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 vechile_seat_finish_init,.Lfe4-vechile_seat_finish_init
	.align 2
	.globl vechile_seat_touch
	.type	 vechile_seat_touch,@function
vechile_seat_touch:
	stwu 1,-176(1)
	mflr 0
	stmw 30,168(1)
	stw 0,180(1)
	lis 9,gi@ha
	mr 30,4
	lwz 0,gi@l(9)
	mr 31,3
	lis 4,.LC3@ha
	la 4,.LC3@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lfs 13,20(31)
	lfs 0,20(30)
	fcmpu 0,13,0
	bc 12,2,.L19
	bc 4,0,.L19
	lis 0,0x4120
	stw 0,636(31)
.L19:
	lfs 13,20(30)
	lfs 0,20(31)
	fcmpu 0,0,13
	bc 4,1,.L21
	lis 0,0xc120
	stw 0,636(31)
.L21:
	lwz 9,256(31)
	cmpwi 0,9,0
	bc 12,2,.L22
	lfs 0,20(9)
	stfs 0,20(31)
.L22:
	li 0,1
	stw 0,912(31)
	lwz 0,180(1)
	mtlr 0
	lmw 30,168(1)
	la 1,176(1)
	blr
.Lfe5:
	.size	 vechile_seat_touch,.Lfe5-vechile_seat_touch
	.section	".rodata"
	.align 3
.LC8:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_vechile_base
	.type	 SP_vechile_base,@function
SP_vechile_base:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	li 0,3
	li 11,2
	lis 9,gi@ha
	stw 0,248(31)
	la 30,gi@l(9)
	stw 11,264(31)
	lwz 9,44(30)
	lwz 4,272(31)
	mtlr 9
	blrl
	lwz 0,792(31)
	lis 9,vechile_blocked@ha
	la 9,vechile_blocked@l(9)
	cmpwi 0,0,0
	stw 9,684(31)
	bc 4,2,.L24
	li 0,10
	stw 0,792(31)
.L24:
	lis 9,basethink@ha
	lis 10,level+4@ha
	la 9,basethink@l(9)
	lis 11,.LC8@ha
	stw 9,680(31)
	mr 3,31
	lfs 0,level+4@l(10)
	lfd 13,.LC8@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 SP_vechile_base,.Lfe6-SP_vechile_base
	.section	".rodata"
	.align 3
.LC9:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_vechile_seat
	.type	 SP_vechile_seat,@function
SP_vechile_seat:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 0,3
	li 9,2
	lis 28,gi@ha
	stw 0,248(29)
	la 28,gi@l(28)
	stw 9,264(29)
	lwz 9,44(28)
	lwz 4,272(29)
	mtlr 9
	blrl
	lis 9,vechile_blocked@ha
	lis 11,vechile_seat_finish_init@ha
	la 9,vechile_blocked@l(9)
	la 11,vechile_seat_finish_init@l(11)
	stw 9,684(29)
	lis 10,level+4@ha
	lis 8,.LC9@ha
	stw 11,680(29)
	lis 9,vechile_seat_touch@ha
	mr 3,29
	lfs 0,level+4@l(10)
	la 9,vechile_seat_touch@l(9)
	lfd 13,.LC9@l(8)
	stw 9,688(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,672(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 SP_vechile_seat,.Lfe7-SP_vechile_seat
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
