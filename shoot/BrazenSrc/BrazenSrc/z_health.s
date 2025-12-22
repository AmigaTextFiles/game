	.file	"z_health.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"items/n_health.wav"
	.align 2
.LC1:
	.string	"items/l_health.wav"
	.align 2
.LC2:
	.long 0x3f800000
	.align 2
.LC3:
	.long 0x0
	.section	".text"
	.align 2
	.globl UseHealth
	.type	 UseHealth,@function
UseHealth:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	lwz 9,480(31)
	lwz 0,484(31)
	cmpw 0,9,0
	bc 4,0,.L15
	cmpwi 0,30,36
	bc 12,2,.L18
	cmpwi 0,30,37
	bc 12,2,.L19
	b .L17
.L18:
	addi 0,9,10
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,480(31)
	lis 3,.LC0@ha
	lwz 9,36(29)
	la 3,.LC0@l(3)
	mtlr 9
	blrl
	lis 9,.LC2@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC2@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	lfs 2,0(9)
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 3,0(9)
	blrl
	b .L17
.L19:
	addi 0,9,30
	lis 29,gi@ha
	la 29,gi@l(29)
	stw 0,480(31)
	lis 3,.LC1@ha
	lwz 9,36(29)
	la 3,.LC1@l(3)
	mtlr 9
	blrl
	lis 9,.LC2@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC2@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	lfs 2,0(9)
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 3,0(9)
	blrl
.L17:
	lwz 0,480(31)
	lwz 9,484(31)
	cmpw 0,0,9
	bc 4,1,.L22
	stw 9,480(31)
.L22:
	lwz 9,84(31)
	li 0,0
	li 4,0
	li 29,1
	li 11,0
	stw 0,1820(9)
	b .L23
.L25:
	addi 11,11,4
	addi 4,4,1
.L23:
	cmpwi 0,4,31
	bc 12,1,.L15
	lwz 9,84(31)
	addi 9,9,1848
	lwzx 0,9,11
	cmpw 0,0,30
	bc 4,2,.L25
	mr 3,31
	bl RemoveItem
	lwz 9,84(31)
	stw 29,1820(9)
.L15:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 UseHealth,.Lfe1-UseHealth
	.align 2
	.globl Think_Health
	.type	 Think_Health,@function
Think_Health:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	li 0,32
	mr 30,3
	mtctr 0
	lwz 8,84(30)
	li 29,-1
	li 28,-1
	li 31,0
	addi 10,8,1848
.L55:
	lwz 0,0(10)
	addi 11,31,1
	addi 10,10,4
	xori 0,0,36
	srawi 7,0,31
	xor 9,7,0
	subf 9,9,7
	srawi 9,9,31
	andc 11,11,9
	and 9,31,9
	or 31,9,11
	bdnz .L55
	lwz 0,1816(8)
	cmpwi 0,0,36
	bc 4,2,.L36
	lwz 9,1820(8)
	addi 11,31,1
	addi 0,9,-1
	or 9,9,0
	srawi 9,9,31
	andc 11,11,9
	and 9,31,9
	or 31,9,11
.L36:
	lwz 0,1832(8)
	cmpwi 0,0,36
	bc 4,2,.L37
	lwz 9,1836(8)
	addi 11,31,1
	addi 0,9,-1
	or 9,9,0
	srawi 9,9,31
	andc 11,11,9
	and 9,31,9
	or 31,9,11
.L37:
	lwz 0,4664(8)
	lwz 9,4620(8)
	cmpwi 0,0,0
	bc 4,2,.L47
	lwz 0,4900(8)
	cmpwi 0,0,-1
	bc 4,1,.L41
	cmpwi 0,31,0
	mr 3,30
	mfcr 31
	bl ChangeRightWeapon
	b .L42
.L41:
	lwz 0,4904(8)
	cmpwi 0,0,-1
	bc 4,1,.L43
	cmpwi 0,31,0
	mr 3,30
	mfcr 31
	bl ChangeLeftWeapon
	b .L42
.L43:
	cmpwi 0,31,0
	mfcr 31
	bc 4,1,.L54
	andi. 0,9,1
	bc 12,2,.L42
	rlwinm 0,9,0,0,30
	mr 3,30
	stw 0,4620(8)
	li 4,36
	bl UseHealth
.L42:
	mtcrf 128,31
	bc 12,1,.L49
.L54:
	lwz 11,84(30)
	li 0,1
	li 10,0
	mr 3,30
	stw 0,1816(11)
	lwz 9,84(30)
	stw 10,1824(9)
	bl SetupItemModels
	mr 3,30
	li 4,0
	li 5,0
	bl AutoSwitchWeapon
	b .L29
.L47:
	li 29,0
.L49:
	cmpwi 0,28,-1
	bc 12,2,.L52
	lwz 9,84(30)
	stw 28,92(9)
.L52:
	cmpwi 0,29,-1
	bc 12,2,.L29
	lwz 9,84(30)
	stw 29,4664(9)
.L29:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Think_Health,.Lfe2-Think_Health
	.align 2
	.globl Think_HealthLarge
	.type	 Think_HealthLarge,@function
Think_HealthLarge:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	li 0,32
	mr 30,3
	mtctr 0
	lwz 8,84(30)
	li 29,-1
	li 28,-1
	li 31,0
	addi 10,8,1848
.L82:
	lwz 0,0(10)
	addi 11,31,1
	addi 10,10,4
	xori 0,0,37
	srawi 7,0,31
	xor 9,7,0
	subf 9,9,7
	srawi 9,9,31
	andc 11,11,9
	and 9,31,9
	or 31,9,11
	bdnz .L82
	lwz 0,1816(8)
	cmpwi 0,0,37
	bc 4,2,.L63
	lwz 9,1820(8)
	addi 11,31,1
	addi 0,9,-1
	or 9,9,0
	srawi 9,9,31
	andc 11,11,9
	and 9,31,9
	or 31,9,11
.L63:
	lwz 0,1832(8)
	cmpwi 0,0,37
	bc 4,2,.L64
	lwz 9,1836(8)
	addi 11,31,1
	addi 0,9,-1
	or 9,9,0
	srawi 9,9,31
	andc 11,11,9
	and 9,31,9
	or 31,9,11
.L64:
	lwz 0,4664(8)
	lwz 9,4620(8)
	cmpwi 0,0,0
	bc 4,2,.L74
	lwz 0,4900(8)
	cmpwi 0,0,-1
	bc 4,1,.L68
	cmpwi 0,31,0
	mr 3,30
	mfcr 31
	bl ChangeRightWeapon
	b .L69
.L68:
	lwz 0,4904(8)
	cmpwi 0,0,-1
	bc 4,1,.L70
	cmpwi 0,31,0
	mr 3,30
	mfcr 31
	bl ChangeLeftWeapon
	b .L69
.L70:
	cmpwi 0,31,0
	mfcr 31
	bc 4,1,.L81
	andi. 0,9,1
	bc 12,2,.L69
	rlwinm 0,9,0,0,30
	mr 3,30
	stw 0,4620(8)
	li 4,37
	bl UseHealth
.L69:
	mtcrf 128,31
	bc 12,1,.L76
.L81:
	lwz 11,84(30)
	li 0,1
	li 10,0
	mr 3,30
	stw 0,1816(11)
	lwz 9,84(30)
	stw 10,1824(9)
	bl SetupItemModels
	mr 3,30
	li 4,0
	li 5,0
	bl AutoSwitchWeapon
	b .L56
.L74:
	li 29,0
.L76:
	cmpwi 0,28,-1
	bc 12,2,.L79
	lwz 9,84(30)
	stw 28,92(9)
.L79:
	cmpwi 0,29,-1
	bc 12,2,.L56
	lwz 9,84(30)
	stw 29,4664(9)
.L56:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 Think_HealthLarge,.Lfe3-Think_HealthLarge
	.align 2
	.globl CountHealthItems
	.type	 CountHealthItems,@function
CountHealthItems:
	li 0,32
	lwz 8,84(3)
	mtctr 0
	li 3,0
	addi 10,8,1848
.L83:
	lwz 0,0(10)
	addi 11,3,1
	addi 10,10,4
	xor 0,0,4
	srawi 7,0,31
	xor 9,7,0
	subf 9,9,7
	srawi 9,9,31
	andc 11,11,9
	and 9,3,9
	or 3,9,11
	bdnz .L83
	lwz 0,1816(8)
	cmpw 0,0,4
	bc 4,2,.L13
	lwz 9,1820(8)
	addi 11,3,1
	addi 0,9,-1
	or 9,9,0
	srawi 9,9,31
	andc 11,11,9
	and 9,3,9
	or 3,9,11
.L13:
	lwz 0,1832(8)
	cmpw 0,0,4
	bclr 4,2
	lwz 9,1836(8)
	addi 11,3,1
	addi 0,9,-1
	or 9,9,0
	srawi 9,9,31
	andc 11,11,9
	and 9,3,9
	or 3,9,11
	blr
.Lfe4:
	.size	 CountHealthItems,.Lfe4-CountHealthItems
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
