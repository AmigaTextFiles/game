	.file	"matrix_cam.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"You must run the server with '+set cheats 1' to enable this command.\n"
	.align 2
.LC1:
	.string	"camera ON\n"
	.align 2
.LC2:
	.string	"camera OFF\n"
	.align 2
.LC4:
	.string	"models/objects/grenade2/tris.md2"
	.align 2
.LC6:
	.string	"camera"
	.align 2
.LC3:
	.long 0x46fffe00
	.align 3
.LC5:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC7:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC8:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC9:
	.long 0x40240000
	.long 0x0
	.align 2
.LC10:
	.long 0x43fa0000
	.align 3
.LC11:
	.long 0x40690000
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_ThrowCam_f
	.type	 Cmd_ThrowCam_f,@function
Cmd_ThrowCam_f:
	stwu 1,-144(1)
	mflr 0
	stfd 28,112(1)
	stfd 29,120(1)
	stfd 30,128(1)
	stfd 31,136(1)
	stmw 24,80(1)
	stw 0,148(1)
	mr 31,3
	lwz 3,1044(31)
	cmpwi 0,3,0
	bc 12,2,.L14
	bl G_FreeEdict
.L14:
	lwz 3,84(31)
	addi 27,1,24
	addi 24,1,40
	addi 26,1,56
	mr 5,24
	mr 6,26
	mr 4,27
	addi 3,3,3668
	lis 25,0x4330
	bl AngleVectors
	lis 9,.LC7@ha
	lis 10,.LC8@ha
	la 9,.LC7@l(9)
	la 10,.LC8@l(10)
	lfd 30,0(9)
	lfd 29,0(10)
	bl G_Spawn
	lfs 0,4(31)
	mr 29,3
	lis 10,.LC10@ha
	la 10,.LC10@l(10)
	lis 9,.LC9@ha
	lfs 1,0(10)
	addi 28,29,376
	la 9,.LC9@l(9)
	stfs 0,4(29)
	mr 4,28
	mr 3,27
	lfs 0,8(31)
	lfd 28,0(9)
	stfs 0,8(29)
	lfs 13,12(31)
	stfs 13,12(29)
	bl VectorScale
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC3@ha
	stw 3,76(1)
	lis 10,.LC11@ha
	mr 5,28
	stw 25,72(1)
	la 10,.LC11@l(10)
	mr 4,26
	lfd 0,72(1)
	mr 3,28
	lfs 31,.LC3@l(11)
	lfd 13,0(10)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,31
	fmr 1,0
	fsub 1,1,29
	fadd 1,1,1
	fmadd 1,1,28,13
	frsp 1,1
	bl VectorMA
	bl rand
	rlwinm 0,3,0,17,31
	xoris 0,0,0x8000
	mr 3,28
	stw 0,76(1)
	mr 5,3
	mr 4,24
	stw 25,72(1)
	lfd 0,72(1)
	fsub 0,0,30
	frsp 0,0
	fdivs 0,0,31
	fmr 1,0
	fsub 1,1,29
	fadd 1,1,1
	fmul 1,1,28
	frsp 1,1
	bl VectorMA
	lis 0,0x600
	li 9,0
	ori 0,0,3
	li 11,9
	stw 9,200(29)
	li 10,2
	lis 28,gi@ha
	stw 11,260(29)
	la 28,gi@l(28)
	stw 0,252(29)
	lis 3,.LC4@ha
	stw 10,248(29)
	la 3,.LC4@l(3)
	stw 9,196(29)
	stw 9,192(29)
	stw 9,188(29)
	stw 9,208(29)
	stw 9,204(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 9,camera_touch@ha
	stw 3,40(29)
	lis 10,level+4@ha
	la 9,camera_touch@l(9)
	stw 31,256(29)
	lis 8,.LC5@ha
	stw 9,444(29)
	lis 11,camera_think@ha
	mr 3,29
	lfs 0,level+4@l(10)
	lis 9,.LC6@ha
	la 11,camera_think@l(11)
	lfd 13,.LC5@l(8)
	la 9,.LC6@l(9)
	stw 11,436(29)
	stw 9,280(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	stw 29,1044(31)
	lwz 0,148(1)
	mtlr 0
	lmw 24,80(1)
	lfd 28,112(1)
	lfd 29,120(1)
	lfd 30,128(1)
	lfd 31,136(1)
	la 1,144(1)
	blr
.Lfe1:
	.size	 Cmd_ThrowCam_f,.Lfe1-Cmd_ThrowCam_f
	.align 2
	.globl camera_touch
	.type	 camera_touch,@function
camera_touch:
	lfs 13,0(5)
	li 0,0
	li 9,0
	stfs 13,16(3)
	lfs 0,4(5)
	stfs 0,20(3)
	lfs 13,8(5)
	stw 9,260(3)
	stw 0,376(3)
	stfs 13,24(3)
	stw 0,384(3)
	stw 0,380(3)
	blr
.Lfe2:
	.size	 camera_touch,.Lfe2-camera_touch
	.align 2
	.globl camera_think
	.type	 camera_think,@function
camera_think:
	blr
.Lfe3:
	.size	 camera_think,.Lfe3-camera_think
	.section	".rodata"
	.align 2
.LC12:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_ViewCam_f
	.type	 Cmd_ViewCam_f,@function
Cmd_ViewCam_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 11,.LC12@ha
	lis 9,deathmatch@ha
	la 11,.LC12@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L9
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L9
	lis 9,gi+8@ha
	lis 5,.LC0@ha
	lwz 0,gi+8@l(9)
	la 5,.LC0@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L8
.L9:
	lwz 10,1048(31)
	cmpwi 0,10,0
	bc 4,2,.L10
	li 0,1
	lwz 11,84(31)
	lis 9,.LC1@ha
	stw 0,1048(31)
	la 29,.LC1@l(9)
	stw 10,88(11)
	b .L11
.L10:
	li 0,0
	lwz 10,84(31)
	lis 9,gi@ha
	lis 11,.LC2@ha
	stw 0,1048(31)
	la 30,gi@l(9)
	la 29,.LC2@l(11)
	lwz 9,1788(10)
	lwz 11,32(30)
	lwz 3,32(9)
	mtlr 11
	blrl
	lwz 9,84(31)
	stw 3,88(9)
	lwz 9,84(31)
	lwz 0,3912(9)
	cmpwi 0,0,0
	bc 12,2,.L11
	lwz 9,1788(9)
	lwz 0,32(30)
	lwz 3,76(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	stw 3,88(9)
.L11:
	lis 9,gi+8@ha
	mr 3,31
	lwz 0,gi+8@l(9)
	mr 5,29
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L8:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 Cmd_ViewCam_f,.Lfe4-Cmd_ViewCam_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
