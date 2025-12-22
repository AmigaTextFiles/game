	.file	"g_newfnc.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"doors/dr1_strt.wav"
	.align 2
.LC1:
	.string	"doors/dr1_mid.wav"
	.align 2
.LC2:
	.string	"doors/dr1_end.wav"
	.align 2
.LC3:
	.string	"Secret door not at 0,90,180,270!\n"
	.align 2
.LC4:
	.long 0x0
	.align 2
.LC5:
	.long 0x43340000
	.align 2
.LC6:
	.long 0x42b40000
	.align 2
.LC7:
	.long 0x43870000
	.section	".text"
	.align 2
	.globl SP_func_door_secret2
	.type	 SP_func_door_secret2,@function
SP_func_door_secret2:
	stwu 1,-96(1)
	mflr 0
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 28,64(1)
	stw 0,100(1)
	lis 9,gi@ha
	mr 31,3
	la 30,gi@l(9)
	lis 3,.LC0@ha
	lwz 9,36(30)
	la 3,.LC0@l(3)
	mtlr 9
	blrl
	stw 3,700(31)
	lwz 9,36(30)
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	mtlr 9
	blrl
	stw 3,704(31)
	lwz 9,36(30)
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	mtlr 9
	blrl
	lwz 0,516(31)
	stw 3,708(31)
	cmpwi 0,0,0
	bc 4,2,.L41
	li 0,2
	stw 0,516(31)
.L41:
	addi 5,1,24
	addi 29,31,16
	addi 4,1,8
	mr 28,5
	addi 6,1,40
	mr 3,29
	bl AngleVectors
	lfs 0,8(31)
	mr 3,29
	addi 4,31,340
	lfs 13,12(31)
	lfs 9,4(31)
	lfs 12,16(31)
	lfs 11,20(31)
	lfs 10,24(31)
	stfs 0,620(31)
	stfs 13,624(31)
	stfs 9,616(31)
	stfs 12,628(31)
	stfs 11,632(31)
	stfs 10,636(31)
	bl G_SetMovedir
	li 0,2
	li 9,3
	lwz 4,268(31)
	stw 0,260(31)
	mr 3,31
	stw 9,248(31)
	lwz 9,44(30)
	mtlr 9
	blrl
	lis 9,.LC4@ha
	lfs 13,632(31)
	la 9,.LC4@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L43
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L42
.L43:
	lfs 30,240(31)
	lfs 31,236(31)
	b .L44
.L42:
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L46
	lis 9,.LC7@ha
	la 9,.LC7@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L45
.L46:
	lfs 30,236(31)
	lfs 31,240(31)
	b .L44
.L45:
	lwz 0,4(30)
	lis 3,.LC3@ha
	la 3,.LC3@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L44:
	lwz 0,284(31)
	andi. 9,0,64
	bc 12,2,.L48
	fmr 1,31
	addi 3,1,8
	mr 4,3
	bl VectorScale
	b .L49
.L48:
	fneg 1,31
	addi 3,1,8
	mr 4,3
	bl VectorScale
.L49:
	lwz 0,284(31)
	andi. 9,0,32
	bc 12,2,.L50
	fmr 1,30
	mr 3,28
	mr 4,3
	bl VectorScale
	b .L51
.L50:
	fneg 1,30
	mr 3,28
	mr 4,3
	bl VectorScale
.L51:
	lwz 0,284(31)
	andi. 9,0,4
	bc 12,2,.L52
	lfs 0,8(1)
	lfs 13,16(1)
	lfs 11,4(31)
	lfs 9,12(31)
	lfs 8,12(1)
	lfs 10,8(31)
	fadds 11,11,0
	fadds 9,9,13
	lfs 12,24(1)
	lfs 0,28(1)
	lfs 13,32(1)
	b .L57
.L52:
	lfs 0,24(1)
	lfs 13,32(1)
	lfs 11,4(31)
	lfs 9,12(31)
	lfs 8,28(1)
	lfs 10,8(31)
	fadds 11,11,0
	fadds 9,9,13
	lfs 12,8(1)
	lfs 0,12(1)
	lfs 13,16(1)
.L57:
	fadds 10,10,8
	fadds 12,11,12
	stfs 11,652(31)
	stfs 9,660(31)
	fadds 0,10,0
	stfs 10,656(31)
	fadds 13,9,13
	stfs 12,676(31)
	stfs 0,680(31)
	stfs 13,684(31)
	lwz 0,300(31)
	lis 9,secret_touch@ha
	lis 11,secret_blocked@ha
	lis 10,fd_secret_use@ha
	la 9,secret_touch@l(9)
	cmpwi 0,0,0
	la 11,secret_blocked@l(11)
	stw 9,444(31)
	lis 0,0x4248
	la 10,fd_secret_use@l(10)
	stw 11,440(31)
	stw 10,448(31)
	stw 0,720(31)
	stw 0,716(31)
	stw 0,712(31)
	bc 12,2,.L55
	lwz 0,284(31)
	andi. 9,0,16
	bc 12,2,.L54
.L55:
	lis 9,fd_secret_killed@ha
	li 0,1
	la 9,fd_secret_killed@l(9)
	stw 0,512(31)
	stw 9,456(31)
	stw 0,480(31)
	stw 0,484(31)
.L54:
	lis 9,.LC4@ha
	lfs 13,592(31)
	la 9,.LC4@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L56
	lis 0,0x40a0
	stw 0,592(31)
.L56:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,100(1)
	mtlr 0
	lmw 28,64(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe1:
	.size	 SP_func_door_secret2,.Lfe1-SP_func_door_secret2
	.section	".rodata"
	.align 3
.LC10:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC11:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl SP_func_force_wall
	.type	 SP_func_force_wall,@function
SP_func_force_wall:
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
	lfs 4,224(31)
	lis 9,.LC11@ha
	lfs 6,212(31)
	la 9,.LC11@l(9)
	lfs 11,0(9)
	lfs 13,232(31)
	fadds 12,4,6
	lfs 5,228(31)
	lfs 7,216(31)
	lfs 0,220(31)
	fmuls 8,12,11
	lfs 9,236(31)
	lfs 12,240(31)
	fadds 10,5,7
	fadds 0,13,0
	stfs 13,372(31)
	stfs 8,1036(31)
	fcmpu 0,9,12
	stfs 13,360(31)
	fmuls 10,10,11
	fmuls 0,0,11
	stfs 10,1040(31)
	stfs 0,1044(31)
	bc 4,1,.L64
	stfs 6,352(31)
	stfs 4,364(31)
	stfs 10,368(31)
	stfs 10,356(31)
	b .L65
.L64:
	stfs 8,364(31)
	stfs 7,356(31)
	stfs 5,368(31)
	stfs 8,352(31)
.L65:
	lwz 0,644(31)
	cmpwi 0,0,0
	bc 4,2,.L66
	li 0,208
	stw 0,644(31)
.L66:
	lwz 0,284(31)
	li 9,0
	lis 11,0x3f80
	stw 9,260(31)
	andi. 0,0,1
	stw 11,592(31)
	bc 12,2,.L67
	lis 9,force_wall_think@ha
	li 0,3
	la 9,force_wall_think@l(9)
	stw 0,248(31)
	lis 10,level+4@ha
	stw 9,436(31)
	lis 11,.LC10@ha
	lfs 0,level+4@l(10)
	lfd 13,.LC10@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	b .L68
.L67:
	stw 0,248(31)
.L68:
	lis 9,force_wall_use@ha
	li 0,1
	la 9,force_wall_use@l(9)
	stw 0,184(31)
	lis 11,gi+72@ha
	stw 9,448(31)
	mr 3,31
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 SP_func_force_wall,.Lfe2-SP_func_force_wall
	.section	".rodata"
	.align 3
.LC12:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl fd_secret_move1
	.type	 fd_secret_move1,@function
fd_secret_move1:
	lis 11,level+4@ha
	lis 9,.LC12@ha
	lfs 0,level+4@l(11)
	la 9,.LC12@l(9)
	lfd 13,0(9)
	lis 9,fd_secret_move2@ha
	la 9,fd_secret_move2@l(9)
	stw 9,436(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe3:
	.size	 fd_secret_move1,.Lfe3-fd_secret_move1
	.align 2
	.globl fd_secret_move2
	.type	 fd_secret_move2,@function
fd_secret_move2:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 5,fd_secret_move3@ha
	addi 4,3,676
	la 5,fd_secret_move3@l(5)
	bl Move_Calc
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 fd_secret_move2,.Lfe4-fd_secret_move2
	.align 2
	.globl fd_secret_move3
	.type	 fd_secret_move3,@function
fd_secret_move3:
	lwz 0,284(3)
	andi. 9,0,1
	bclr 4,2
	lis 11,level+4@ha
	lfs 13,592(3)
	lis 9,fd_secret_move4@ha
	lfs 0,level+4@l(11)
	la 9,fd_secret_move4@l(9)
	stw 9,436(3)
	fadds 0,0,13
	stfs 0,428(3)
	blr
.Lfe5:
	.size	 fd_secret_move3,.Lfe5-fd_secret_move3
	.align 2
	.globl fd_secret_move4
	.type	 fd_secret_move4,@function
fd_secret_move4:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 5,fd_secret_move5@ha
	addi 4,3,652
	la 5,fd_secret_move5@l(5)
	bl Move_Calc
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 fd_secret_move4,.Lfe6-fd_secret_move4
	.section	".rodata"
	.align 3
.LC13:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl fd_secret_move5
	.type	 fd_secret_move5,@function
fd_secret_move5:
	lis 11,level+4@ha
	lis 9,.LC13@ha
	lfs 0,level+4@l(11)
	la 9,.LC13@l(9)
	lfd 13,0(9)
	lis 9,fd_secret_move6@ha
	la 9,fd_secret_move6@l(9)
	stw 9,436(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe7:
	.size	 fd_secret_move5,.Lfe7-fd_secret_move5
	.align 2
	.globl fd_secret_move6
	.type	 fd_secret_move6,@function
fd_secret_move6:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 5,fd_secret_done@ha
	addi 4,3,616
	la 5,fd_secret_done@l(5)
	bl Move_Calc
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 fd_secret_move6,.Lfe8-fd_secret_move6
	.align 2
	.globl fd_secret_done
	.type	 fd_secret_done,@function
fd_secret_done:
	lwz 0,300(3)
	cmpwi 0,0,0
	bc 12,2,.L32
	lwz 0,284(3)
	andi. 9,0,16
	bclr 12,2
.L32:
	lis 9,fd_secret_killed@ha
	li 0,1
	la 9,fd_secret_killed@l(9)
	stw 0,512(3)
	stw 9,456(3)
	stw 0,480(3)
	blr
.Lfe9:
	.size	 fd_secret_done,.Lfe9-fd_secret_done
	.align 2
	.globl fd_secret_use
	.type	 fd_secret_use,@function
fd_secret_use:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lwz 0,264(3)
	andi. 9,0,1024
	bc 4,2,.L6
	mr. 31,3
	bc 12,2,.L6
	lis 30,fd_secret_move1@ha
.L11:
	mr 3,31
	addi 4,31,652
	la 5,fd_secret_move1@l(30)
	bl Move_Calc
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L11
.L6:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 fd_secret_use,.Lfe10-fd_secret_use
	.align 2
	.globl fd_secret_killed
	.type	 fd_secret_killed,@function
fd_secret_killed:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lwz 9,264(3)
	li 11,0
	lwz 0,484(3)
	andi. 10,9,1024
	stw 11,512(3)
	stw 0,480(3)
	bc 12,2,.L69
	lwz 9,564(3)
	cmpwi 0,9,0
	bc 12,2,.L14
	lwz 0,512(9)
	cmpwi 0,0,0
	bc 12,2,.L14
	mr 3,9
	bl fd_secret_killed
	b .L15
.L14:
	lwz 0,264(3)
	andi. 9,0,1024
	bc 4,2,.L15
.L69:
	mr. 31,3
	bc 12,2,.L15
	lis 30,fd_secret_move1@ha
.L20:
	mr 3,31
	addi 4,31,652
	la 5,fd_secret_move1@l(30)
	bl Move_Calc
	lwz 31,560(31)
	cmpwi 0,31,0
	bc 4,2,.L20
.L15:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 fd_secret_killed,.Lfe11-fd_secret_killed
	.align 2
	.globl secret_blocked
	.type	 secret_blocked,@function
secret_blocked:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 11,3
	lwz 0,264(11)
	mr 3,4
	andi. 0,0,1024
	bc 4,2,.L34
	lwz 9,516(11)
	lis 6,vec3_origin@ha
	mr 4,11
	stw 0,8(1)
	la 6,vec3_origin@l(6)
	mr 5,4
	li 0,20
	addi 7,3,4
	stw 0,12(1)
	mr 8,6
	li 10,0
	bl T_Damage
.L34:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe12:
	.size	 secret_blocked,.Lfe12-secret_blocked
	.section	".rodata"
	.align 2
.LC14:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl secret_touch
	.type	 secret_touch,@function
secret_touch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L35
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L35
	lis 9,level+4@ha
	lfs 0,832(3)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 12,1,.L35
	lis 9,.LC14@ha
	lwz 0,276(3)
	la 9,.LC14@l(9)
	lfs 0,0(9)
	cmpwi 0,0,0
	fadds 0,13,0
	stfs 0,832(3)
	bc 12,2,.L35
	lis 9,gi+12@ha
	mr 3,4
	lwz 9,gi+12@l(9)
	mr 4,0
	mtlr 9
	crxor 6,6,6
	blrl
.L35:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 secret_touch,.Lfe13-secret_touch
	.section	".rodata"
	.align 3
.LC15:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC16:
	.long 0x0
	.section	".text"
	.align 2
	.globl force_wall_think
	.type	 force_wall_think,@function
force_wall_think:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,.LC16@ha
	mr 31,3
	la 9,.LC16@l(9)
	lfs 0,592(31)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L59
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,37
	mtlr 9
	blrl
	lwz 9,120(29)
	addi 3,31,352
	mtlr 9
	blrl
	lwz 9,120(29)
	addi 3,31,364
	mtlr 9
	blrl
	lwz 9,100(29)
	lwz 3,644(31)
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,31,1036
	li 4,2
	mtlr 0
	blrl
.L59:
	lis 9,force_wall_think@ha
	lis 10,level+4@ha
	la 9,force_wall_think@l(9)
	lis 11,.LC15@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC15@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 force_wall_think,.Lfe14-force_wall_think
	.section	".rodata"
	.align 3
.LC17:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC18:
	.long 0x0
	.section	".text"
	.align 2
	.globl force_wall_use
	.type	 force_wall_use,@function
force_wall_use:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,.LC18@ha
	mr 31,3
	la 9,.LC18@l(9)
	lfs 0,592(31)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L61
	li 0,0
	lis 9,0x3f80
	stfs 13,428(31)
	stw 9,592(31)
	lis 11,gi+72@ha
	stw 0,248(31)
	stw 0,436(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	b .L62
.L61:
	lis 9,force_wall_think@ha
	stfs 13,592(31)
	lis 10,level+4@ha
	la 9,force_wall_think@l(9)
	lis 11,.LC17@ha
	stw 9,436(31)
	li 0,3
	mr 3,31
	lfs 0,level+4@l(10)
	lfd 13,.LC17@l(11)
	stw 0,248(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L62:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe15:
	.size	 force_wall_use,.Lfe15-force_wall_use
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
