	.file	"z_client.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"i_null"
	.align 2
.LC1:
	.long 0x0
	.section	".text"
	.align 2
	.globl z_InitClientPers
	.type	 z_InitClientPers,@function
z_InitClientPers:
	stwu 1,-96(1)
	mflr 0
	stmw 27,76(1)
	stw 0,100(1)
	mr 29,3
	li 4,0
	lwz 3,84(29)
	li 5,32
	addi 3,3,1816
	crxor 6,6,6
	bl memset
	lwz 3,84(29)
	li 4,0
	li 5,128
	addi 3,3,1848
	crxor 6,6,6
	bl memset
	lwz 3,84(29)
	li 4,0
	li 5,128
	addi 3,3,1976
	crxor 6,6,6
	bl memset
	lwz 3,84(29)
	li 4,0
	li 5,128
	addi 3,3,2104
	crxor 6,6,6
	bl memset
	lwz 11,84(29)
	li 0,1
	li 10,-1
	li 3,1
	stw 0,1816(11)
	lwz 9,84(29)
	stw 0,1832(9)
	lwz 11,84(29)
	stw 10,4900(11)
	lwz 9,84(29)
	stw 10,4904(9)
	bl GetItemByTag
	lis 11,.LC1@ha
	lwz 10,84(29)
	lis 9,sv_edit@ha
	la 11,.LC1@l(11)
	lfs 13,0(11)
	lwz 11,sv_edit@l(9)
	stw 3,1788(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L27
	mr 3,29
	li 4,14
	bl GiveItem
.L27:
	lis 9,sv_equipment@ha
	lwz 11,sv_equipment@l(9)
	lwz 30,4(11)
	cmpwi 0,30,0
	bc 12,2,.L30
	lbz 9,0(30)
	cmpwi 0,9,0
	bc 12,2,.L30
	li 27,0
	addi 28,1,8
.L33:
	rlwinm 9,9,0,0xff
	mr 4,30
	b .L42
.L36:
	lbzu 9,1(30)
.L42:
	xori 0,9,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L36
	subf 31,4,30
	addi 0,31,-5
	cmplwi 0,0,58
	bc 12,1,.L30
	mr 5,31
	addi 3,1,8
	crxor 6,6,6
	bl memcpy
	stbx 27,28,31
	mr 3,28
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L40
	lwz 4,20(3)
	mr 3,29
	bl GiveItem
.L40:
	lbz 0,0(30)
	addi 9,30,1
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,30,0
	or 30,0,9
	lbz 9,0(30)
	cmpwi 0,9,0
	bc 4,2,.L33
.L30:
	lwz 0,100(1)
	mtlr 0
	lmw 27,76(1)
	la 1,96(1)
	blr
.Lfe1:
	.size	 z_InitClientPers,.Lfe1-z_InitClientPers
	.align 2
	.globl z_PutClientInServer
	.type	 z_PutClientInServer,@function
z_PutClientInServer:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	li 0,-1
	lwz 11,84(31)
	lis 9,gi@ha
	lis 10,0xc120
	la 28,gi@l(9)
	li 30,16
	stw 0,4924(11)
	lis 29,.LC0@ha
	lwz 9,84(31)
	stw 10,4920(9)
	lwz 11,84(31)
	sth 0,166(11)
	lwz 9,84(31)
	stw 0,4900(9)
	lwz 11,84(31)
	stw 0,4904(11)
.L24:
	lwz 9,40(28)
	la 3,.LC0@l(29)
	mtlr 9
	blrl
	add 0,30,30
	lwz 9,84(31)
	addi 30,30,1
	cmpwi 0,30,23
	addi 9,9,120
	sthx 3,9,0
	bc 4,1,.L24
	mr 3,31
	bl SetupItemModels
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 z_PutClientInServer,.Lfe2-z_PutClientInServer
	.align 2
	.globl GiveDefaultEquipment
	.type	 GiveDefaultEquipment,@function
GiveDefaultEquipment:
	stwu 1,-96(1)
	mflr 0
	stmw 27,76(1)
	stw 0,100(1)
	lis 11,sv_equipment@ha
	mr 28,3
	lwz 9,sv_equipment@l(11)
	lwz 30,4(9)
	cmpwi 0,30,0
	bc 12,2,.L6
	lbz 9,0(30)
	cmpwi 0,9,0
	bc 12,2,.L6
	addi 29,1,8
	li 27,0
.L11:
	rlwinm 9,9,0,0xff
	mr 4,30
	b .L43
.L14:
	lbzu 9,1(30)
.L43:
	xori 0,9,32
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L14
	subf 31,4,30
	addi 0,31,-5
	cmplwi 0,0,58
	bc 12,1,.L6
	mr 5,31
	mr 3,29
	crxor 6,6,6
	bl memcpy
	stbx 27,29,31
	mr 3,29
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L17
	lwz 4,20(3)
	mr 3,28
	bl GiveItem
.L17:
	lbz 0,0(30)
	addi 9,30,1
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,30,0
	or 30,0,9
	lbz 9,0(30)
	cmpwi 0,9,0
	bc 4,2,.L11
.L6:
	lwz 0,100(1)
	mtlr 0
	lmw 27,76(1)
	la 1,96(1)
	blr
.Lfe3:
	.size	 GiveDefaultEquipment,.Lfe3-GiveDefaultEquipment
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
