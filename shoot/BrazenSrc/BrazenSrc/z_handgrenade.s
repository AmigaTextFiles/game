	.file	"z_handgrenade.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0x46fffe00
	.align 3
.LC1:
	.long 0x40059999
	.long 0x9999999a
	.align 3
.LC2:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC3:
	.long 0x42700000
	.align 3
.LC4:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC5:
	.long 0x43250000
	.section	".text"
	.align 2
	.globl ThrowOffHandGrenade
	.type	 ThrowOffHandGrenade,@function
ThrowOffHandGrenade:
	stwu 1,-128(1)
	mflr 0
	stfd 31,120(1)
	stmw 27,100(1)
	stw 0,132(1)
	mr 31,3
	lwz 9,508(31)
	lis 28,0x4330
	lis 7,.LC2@ha
	la 7,.LC2@l(7)
	lwz 3,84(31)
	addi 30,1,24
	addi 9,9,-8
	lfd 31,0(7)
	addi 29,1,40
	xoris 9,9,0x8000
	lis 10,0xc100
	stw 9,92(1)
	lis 0,0x4100
	addi 27,1,56
	stw 28,88(1)
	addi 3,3,4732
	mr 4,30
	lfd 0,88(1)
	mr 5,29
	li 6,0
	stw 10,12(1)
	stw 0,8(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,16(1)
	bl AngleVectors
	lwz 3,84(31)
	mr 7,29
	mr 8,27
	addi 4,31,4
	addi 5,1,8
	mr 6,30
	bl P_ProjectSource
	bl rand
	rlwinm 3,3,0,17,31
	lwz 8,84(31)
	xoris 3,3,0x8000
	lis 11,.LC0@ha
	stw 3,92(1)
	lis 7,.LC3@ha
	lis 10,.LC1@ha
	stw 28,88(1)
	la 7,.LC3@l(7)
	lfd 13,88(1)
	lfs 10,.LC0@l(11)
	lfs 9,0(7)
	fsub 13,13,31
	lfs 0,4732(8)
	lis 7,.LC4@ha
	la 7,.LC4@l(7)
	lfd 12,.LC1@l(10)
	lfd 11,0(7)
	frsp 13,13
	li 7,800
	fcmpu 0,0,9
	fdivs 13,13,10
	fmr 0,13
	fmadd 0,0,11,12
	frsp 1,0
	bc 4,1,.L22
	li 7,128
.L22:
	lis 9,.LC5@ha
	lwz 8,2360(8)
	mr 4,27
	la 9,.LC5@l(9)
	mr 5,30
	lfs 2,0(9)
	mr 3,31
	li 6,125
	bl fire_grenade2
	li 4,0
	li 8,0
.L27:
	lwz 10,84(31)
	addi 9,10,1848
	lwz 11,2360(10)
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,2,.L26
	addi 10,10,1976
	lwzx 9,10,8
	addi 9,9,-1
	stwx 9,10,8
	lwz 11,84(31)
	addi 11,11,1976
	lwzx 0,11,8
	cmpwi 0,0,0
	bc 12,1,.L25
	mr 3,31
	bl RemoveItem
	b .L25
.L26:
	addi 4,4,1
	addi 8,8,4
	cmpwi 0,4,31
	bc 4,1,.L27
.L25:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L21
	lwz 0,40(31)
	cmpwi 0,0,255
	bc 4,2,.L21
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L21
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 7,0,1
	bc 12,2,.L34
	li 0,4
	li 10,159
	stw 0,4792(9)
	li 11,162
	b .L36
.L34:
	li 0,6
	li 10,119
	stw 0,4792(9)
	li 11,112
.L36:
	lwz 9,84(31)
	stw 10,56(31)
	stw 11,4788(9)
.L21:
	lwz 0,132(1)
	mtlr 0
	lmw 27,100(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe1:
	.size	 ThrowOffHandGrenade,.Lfe1-ThrowOffHandGrenade
	.section	".rodata"
	.align 3
.LC6:
	.long 0x3fd33333
	.long 0x33333333
	.align 2
.LC7:
	.long 0x3e99999a
	.align 3
.LC8:
	.long 0x4060aaaa
	.long 0xaaaaaaab
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC10:
	.long 0x42700000
	.align 3
.LC11:
	.long 0x40080000
	.long 0x0
	.align 3
.LC12:
	.long 0x40790000
	.long 0x0
	.align 2
.LC13:
	.long 0x43250000
	.section	".text"
	.align 2
	.globl ThrowHandGrenade
	.type	 ThrowHandGrenade,@function
ThrowHandGrenade:
	stwu 1,-112(1)
	mflr 0
	stmw 27,92(1)
	stw 0,116(1)
	mr 31,3
	lwz 9,508(31)
	lis 10,0x4330
	lis 8,.LC9@ha
	la 8,.LC9@l(8)
	lwz 3,84(31)
	addi 29,1,24
	addi 9,9,-8
	lfd 13,0(8)
	lis 0,0x4100
	xoris 9,9,0x8000
	addi 27,1,40
	stw 0,12(1)
	stw 9,84(1)
	addi 28,1,56
	addi 3,3,4732
	stw 10,80(1)
	mr 4,29
	mr 5,27
	lfd 0,80(1)
	li 6,0
	stw 0,8(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,16(1)
	bl AngleVectors
	lwz 3,84(31)
	addi 4,31,4
	addi 5,1,8
	mr 7,27
	mr 6,29
	mr 8,28
	bl P_ProjectSource
	lwz 10,84(31)
	lis 9,level+4@ha
	lis 11,.LC6@ha
	lfs 11,level+4@l(9)
	mr 5,29
	mr 4,28
	lfs 12,4824(10)
	lfd 13,.LC6@l(11)
	fsubs 1,12,11
	fmr 0,1
	fcmpu 0,0,13
	bc 4,0,.L38
	lis 9,.LC7@ha
	lfs 1,.LC7@l(9)
.L38:
	lis 8,.LC10@ha
	lfs 13,4732(10)
	la 8,.LC10@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,1,.L39
	li 7,128
	b .L40
.L39:
	lis 9,.LC11@ha
	fmr 10,1
	lis 11,.LC12@ha
	la 9,.LC11@l(9)
	la 11,.LC12@l(11)
	lfd 0,0(9)
	lis 9,.LC8@ha
	lfd 12,0(11)
	lfd 11,.LC8@l(9)
	fsub 0,0,10
	fmadd 0,0,11,12
	fctiwz 13,0
	stfd 13,80(1)
	lwz 7,84(1)
.L40:
	lwz 9,84(31)
	mr 3,31
	li 6,125
	lwz 8,1828(9)
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 2,0(9)
	bl fire_grenade2
	lwz 9,84(31)
	li 0,0
	li 7,1
	li 4,0
	li 8,0
	stw 0,1820(9)
.L44:
	lwz 10,84(31)
	addi 9,10,1848
	lwz 11,1828(10)
	lwzx 0,9,8
	cmpw 0,0,11
	bc 4,2,.L43
	stw 7,1820(10)
	lwz 10,84(31)
	addi 10,10,1976
	lwzx 9,10,8
	addi 9,9,-1
	stwx 9,10,8
	lwz 11,84(31)
	addi 11,11,1976
	lwzx 0,11,8
	cmpwi 0,0,0
	bc 12,1,.L42
	mr 3,31
	bl RemoveItem
	b .L42
.L43:
	addi 4,4,1
	addi 8,8,4
	cmpwi 0,4,31
	bc 4,1,.L44
.L42:
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L37
	lwz 0,40(31)
	cmpwi 0,0,255
	bc 4,2,.L37
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L37
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 8,0,1
	bc 12,2,.L51
	li 0,4
	li 10,159
	stw 0,4792(9)
	li 11,162
	b .L53
.L51:
	li 0,6
	li 10,119
	stw 0,4792(9)
	li 11,112
.L53:
	lwz 9,84(31)
	stw 10,56(31)
	stw 11,4788(9)
.L37:
	lwz 0,116(1)
	mtlr 0
	lmw 27,92(1)
	la 1,112(1)
	blr
.Lfe2:
	.size	 ThrowHandGrenade,.Lfe2-ThrowHandGrenade
	.section	".rodata"
	.align 3
.LC14:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC15:
	.long 0x46fffe00
	.align 2
.LC16:
	.long 0x41000000
	.align 3
.LC17:
	.long 0x40080000
	.long 0x0
	.align 3
.LC18:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC19:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Think_HandGrenade
	.type	 Think_HandGrenade,@function
Think_HandGrenade:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	li 0,32
	lwz 9,84(31)
	mtctr 0
	li 30,-1
	li 29,-1
	li 5,0
	lwz 11,1816(9)
	mr 8,9
	addi 9,8,1976
.L102:
	lwz 0,-128(9)
	cmpw 0,0,11
	bc 4,2,.L59
	lwz 0,0(9)
	add 5,5,0
.L59:
	addi 9,9,4
	bdnz .L102
	lwz 0,1820(8)
	addi 10,5,1
	lwz 7,4664(8)
	xori 0,0,1
	lwz 6,4620(8)
	srawi 11,0,31
	cmpwi 0,7,1
	xor 9,11,0
	subf 9,9,11
	srawi 9,9,31
	lwz 11,4612(8)
	andc 10,10,9
	or 11,6,11
	and 9,5,9
	rlwinm 3,11,0,30,30
	rlwinm 4,11,0,31,31
	or 5,9,10
	bc 12,2,.L75
	cmplwi 0,7,1
	bc 12,0,.L64
	cmpwi 0,7,2
	bc 12,2,.L81
	b .L63
.L64:
	lwz 0,4900(8)
	cmpwi 0,0,-1
	bc 12,1,.L103
	lwz 0,4904(8)
	cmpwi 0,0,-1
	bc 12,1,.L104
	srawi 0,5,31
	subf 0,5,0
	srwi 9,0,31
	and. 11,4,9
	bc 12,2,.L69
	rlwinm 0,6,0,0,30
	li 11,0
	stw 0,4620(8)
	li 30,7
	b .L105
.L69:
	neg 0,3
	srwi 0,0,31
	and. 10,0,9
	bc 12,2,.L71
	rlwinm 0,6,0,31,29
	li 30,8
	stw 0,4620(8)
.L105:
	lwz 9,84(31)
	stw 11,92(9)
	b .L63
.L71:
	lis 9,level+4@ha
	lfs 13,992(31)
	lis 11,.LC16@ha
	lfs 0,level+4@l(9)
	la 11,.LC16@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L73
	li 29,17
	li 30,1
	b .L63
.L73:
	li 29,16
	b .L63
.L75:
	lwz 0,4900(8)
	cmpwi 0,0,-1
	bc 4,1,.L76
.L103:
	li 0,16
	mr 3,31
	stw 0,92(8)
	bl ChangeRightWeapon
	b .L54
.L76:
	lwz 0,4904(8)
	cmpwi 0,0,-1
	bc 4,1,.L78
.L104:
	li 0,16
	mr 3,31
	stw 0,92(8)
	bl ChangeLeftWeapon
	b .L54
.L78:
	neg 0,3
	srwi 0,0,31
	or. 9,4,0
	bc 12,2,.L63
	li 0,0
	li 11,16
	stw 0,4664(8)
	mr 3,31
	lwz 9,84(31)
	stw 11,92(9)
	bl Think_HandGrenade
	b .L54
.L81:
	li 0,16
	li 30,0
	stw 0,92(8)
.L63:
	lwz 9,84(31)
	lwz 11,92(9)
	mr 8,9
	addi 10,11,-3
	cmplwi 0,10,45
	bc 12,1,.L96
	lis 11,.L98@ha
	slwi 10,10,2
	la 11,.L98@l(11)
	lis 9,.L98@ha
	lwzx 0,10,11
	la 9,.L98@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L98:
	.long .L85-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L86-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L88-.L98
	.long .L96-.L98
	.long .L89-.L98
	.long .L84-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L96-.L98
	.long .L93-.L98
.L85:
	li 0,9
	lis 11,level+4@ha
	stw 0,92(8)
	lis 9,.LC17@ha
	lfs 0,level+4@l(11)
	la 9,.LC17@l(9)
	lfd 12,0(9)
	lis 9,.LC14@ha
	lfd 13,.LC14@l(9)
	lwz 9,84(31)
	fadd 0,0,12
	fadd 0,0,13
	frsp 0,0
	stfs 0,4824(9)
	b .L84
.L86:
	neg 0,3
	srwi 0,0,31
	or. 10,4,0
	bc 4,2,.L54
	li 0,13
	stw 0,92(8)
	b .L84
.L88:
	mr 3,31
	bl ThrowHandGrenade
	lwz 11,84(31)
	b .L106
.L89:
	cmpwi 0,5,0
	bc 12,1,.L90
	li 0,1
	li 11,0
	stw 0,1816(8)
	mr 3,31
	lwz 9,84(31)
	stw 11,1824(9)
	bl SetupItemModels
	mr 3,31
	li 4,0
	li 5,0
	bl AutoSwitchWeapon
	b .L54
.L90:
	lis 9,level+4@ha
	lwz 11,84(31)
	li 30,0
	lfs 0,level+4@l(9)
	stfs 0,992(31)
.L106:
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L84
.L93:
	bl rand
	li 29,17
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC18@ha
	lis 11,.LC15@ha
	la 10,.LC18@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC19@ha
	lfs 12,.LC15@l(11)
	la 10,.LC19@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,0,.L84
	li 29,16
	li 30,0
	b .L84
.L96:
	cmpwi 0,29,-1
	bc 4,2,.L101
	lwz 9,92(8)
	addi 9,9,1
	stw 9,92(8)
.L84:
	cmpwi 0,29,-1
	bc 12,2,.L99
.L101:
	lwz 9,84(31)
	stw 29,92(9)
.L99:
	cmpwi 0,30,-1
	bc 12,2,.L54
	lwz 9,84(31)
	stw 30,4664(9)
.L54:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 Think_HandGrenade,.Lfe3-Think_HandGrenade
	.align 2
	.globl CountOffHandGrenades
	.type	 CountOffHandGrenades,@function
CountOffHandGrenades:
	li 0,32
	lwz 9,84(3)
	mtctr 0
	li 3,0
	addi 9,9,1976
.L107:
	lwz 0,-128(9)
	cmpw 0,0,4
	bc 4,2,.L9
	lwz 0,0(9)
	add 3,3,0
.L9:
	addi 9,9,4
	bdnz .L107
	blr
.Lfe4:
	.size	 CountOffHandGrenades,.Lfe4-CountOffHandGrenades
	.align 2
	.globl CountHandGrenades
	.type	 CountHandGrenades,@function
CountHandGrenades:
	li 0,32
	lwz 9,84(3)
	li 11,0
	mtctr 0
	mr 8,9
	lwz 10,1816(9)
	addi 9,8,1976
.L108:
	lwz 0,-128(9)
	cmpw 0,0,10
	bc 4,2,.L16
	lwz 0,0(9)
	add 11,11,0
.L16:
	addi 9,9,4
	bdnz .L108
	lwz 0,1820(8)
	addi 9,11,1
	xori 0,0,1
	srawi 10,0,31
	xor 3,10,0
	subf 3,3,10
	srawi 3,3,31
	andc 9,9,3
	and 3,11,3
	or 3,3,9
	blr
.Lfe5:
	.size	 CountHandGrenades,.Lfe5-CountHandGrenades
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
