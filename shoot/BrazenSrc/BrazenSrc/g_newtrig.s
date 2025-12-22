	.file	"g_newtrig.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Teleport Destination not found!\n"
	.align 2
.LC1:
	.long 0x0
	.align 2
.LC2:
	.long 0x41200000
	.align 2
.LC3:
	.long 0x47800000
	.align 2
.LC4:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl trigger_teleport_touch
	.type	 trigger_teleport_touch,@function
trigger_teleport_touch:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	mr 31,4
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L7
	lis 9,.LC1@ha
	lfs 0,596(3)
	la 9,.LC1@l(9)
	lfs 31,0(9)
	fcmpu 0,0,31
	bc 4,2,.L7
	lwz 5,296(3)
	li 4,300
	li 3,0
	bl G_Find
	mr. 30,3
	bc 4,2,.L10
	lis 9,gi+4@ha
	lis 3,.LC0@ha
	lwz 0,gi+4@l(9)
	la 3,.LC0@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L7
.L10:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	addi 28,31,4
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,48
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,88(29)
	mr 3,28
	li 4,2
	mtlr 9
	blrl
	lwz 0,76(29)
	mr 3,31
	mtlr 0
	blrl
	lfs 13,4(30)
	lis 10,.LC2@ha
	la 10,.LC2@l(10)
	lwz 9,84(31)
	lfs 11,0(10)
	stfs 13,4(31)
	cmpwi 0,9,0
	lfs 0,8(30)
	stfs 0,8(31)
	lfs 12,12(30)
	stfs 12,12(31)
	lfs 0,4(30)
	fadds 12,12,11
	stfs 0,28(31)
	lfs 13,8(30)
	stfs 13,32(31)
	lfs 0,12(30)
	stfs 12,12(31)
	stfs 31,376(31)
	stfs 0,36(31)
	stfs 31,384(31)
	stfs 31,380(31)
	bc 12,2,.L11
	li 0,20
	lis 10,.LC3@ha
	stb 0,17(9)
	la 10,.LC3@l(10)
	li 11,6
	lwz 9,84(31)
	li 0,3
	addi 3,30,16
	lfs 10,0(10)
	mtctr 0
	li 7,0
	li 8,0
	lbz 0,16(9)
	lis 10,.LC4@ha
	la 10,.LC4@l(10)
	ori 0,0,32
	lfs 11,0(10)
	stb 0,16(9)
	stw 11,80(31)
.L17:
	lwz 10,84(31)
	add 0,7,7
	lfsx 0,8,3
	addi 7,7,1
	addi 9,10,4548
	lfsx 13,9,8
	addi 10,10,20
	addi 8,8,4
	fsubs 0,0,13
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,16(1)
	lwz 11,20(1)
	sthx 11,10,0
	bdnz .L17
	lwz 9,84(31)
	li 0,0
	stw 0,28(9)
	stw 0,36(9)
	stw 0,32(9)
	lwz 11,84(31)
	stw 0,4732(11)
	stw 0,4740(11)
	stw 0,4736(11)
.L11:
	li 0,0
	mr 3,31
	stw 0,16(31)
	stw 0,24(31)
	stw 0,20(31)
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L7:
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 trigger_teleport_touch,.Lfe1-trigger_teleport_touch
	.align 2
	.globl SP_info_teleport_destination
	.type	 SP_info_teleport_destination,@function
SP_info_teleport_destination:
	blr
.Lfe2:
	.size	 SP_info_teleport_destination,.Lfe2-SP_info_teleport_destination
	.section	".rodata"
	.align 2
.LC6:
	.long 0x0
	.section	".text"
	.align 2
	.globl trigger_teleport_use
	.type	 trigger_teleport_use,@function
trigger_teleport_use:
	lis 9,.LC6@ha
	lfs 0,596(3)
	la 9,.LC6@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L19
	stfs 13,596(3)
	blr
.L19:
	lis 0,0x3f80
	stw 0,596(3)
	blr
.Lfe3:
	.size	 trigger_teleport_use,.Lfe3-trigger_teleport_use
	.section	".rodata"
	.align 2
.LC7:
	.long 0x3e4ccccd
	.align 2
.LC8:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_trigger_teleport
	.type	 SP_trigger_teleport,@function
SP_trigger_teleport:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,.LC8@ha
	mr 31,3
	la 9,.LC8@l(9)
	lfs 0,592(31)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L22
	lis 9,.LC7@ha
	lfs 0,.LC7@l(9)
	stfs 0,592(31)
.L22:
	lwz 0,300(31)
	stfs 13,596(31)
	cmpwi 0,0,0
	bc 12,2,.L23
	lwz 0,284(31)
	lis 9,trigger_teleport_use@ha
	la 9,trigger_teleport_use@l(9)
	andi. 11,0,8
	stw 9,448(31)
	bc 4,2,.L23
	lis 0,0x3f80
	stw 0,596(31)
.L23:
	lis 9,trigger_teleport_touch@ha
	li 0,1
	la 9,trigger_teleport_touch@l(9)
	li 11,0
	stw 0,248(31)
	addi 29,31,16
	lis 4,vec3_origin@ha
	stw 9,444(31)
	stw 11,260(31)
	la 4,vec3_origin@l(4)
	mr 3,29
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L25
	mr 3,29
	addi 4,31,340
	bl G_SetMovedir
.L25:
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
.Lfe4:
	.size	 SP_trigger_teleport,.Lfe4-SP_trigger_teleport
	.align 2
	.globl trigger_disguise_touch
	.type	 trigger_disguise_touch,@function
trigger_disguise_touch:
	lwz 0,84(4)
	cmpwi 0,0,0
	bclr 12,2
	lwz 0,284(3)
	andi. 9,0,4
	bc 12,2,.L28
	lwz 0,264(4)
	rlwinm 0,0,0,17,15
	stw 0,264(4)
	blr
.L28:
	lwz 0,264(4)
	ori 0,0,32768
	stw 0,264(4)
	blr
.Lfe5:
	.size	 trigger_disguise_touch,.Lfe5-trigger_disguise_touch
	.align 2
	.globl trigger_disguise_use
	.type	 trigger_disguise_use,@function
trigger_disguise_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,248(3)
	cmpwi 0,0,0
	li 0,0
	bc 4,2,.L31
	li 0,1
.L31:
	stw 0,248(3)
	lis 9,gi+72@ha
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 trigger_disguise_use,.Lfe6-trigger_disguise_use
	.align 2
	.globl SP_trigger_disguise
	.type	 SP_trigger_disguise,@function
SP_trigger_disguise:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,284(31)
	andi. 0,0,2
	bc 12,2,.L34
	li 0,1
.L34:
	stw 0,248(31)
	lis 9,trigger_disguise_touch@ha
	lis 11,trigger_disguise_use@ha
	lwz 4,268(31)
	la 9,trigger_disguise_touch@l(9)
	li 0,0
	la 11,trigger_disguise_use@l(11)
	li 10,1
	stw 0,260(31)
	lis 29,gi@ha
	stw 9,444(31)
	mr 3,31
	la 29,gi@l(29)
	stw 11,448(31)
	stw 10,184(31)
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
.Lfe7:
	.size	 SP_trigger_disguise,.Lfe7-SP_trigger_disguise
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
