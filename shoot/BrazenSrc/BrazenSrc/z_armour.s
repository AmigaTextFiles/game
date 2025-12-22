	.file	"z_armour.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC1:
	.string	"misc/ar1_pkup.wav"
	.align 2
.LC2:
	.string	"items/pkup.wav"
	.align 3
.LC3:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC4:
	.long 0x3f800000
	.align 2
.LC5:
	.long 0x0
	.section	".text"
	.align 2
	.globl UseArmour
	.type	 UseArmour,@function
UseArmour:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	mr 31,3
	li 30,-1
	lwz 11,84(31)
	li 8,1
	lwz 9,1816(11)
	addi 9,9,-47
	cmplwi 0,9,4
	bc 12,1,.L13
	lis 11,.L20@ha
	slwi 10,9,2
	la 11,.L20@l(11)
	lis 9,.L20@ha
	lwzx 0,10,11
	la 9,.L20@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L20:
	.long .L16-.L20
	.long .L15-.L20
	.long .L16-.L20
	.long .L17-.L20
	.long .L18-.L20
.L15:
.L16:
	li 30,1
	b .L13
.L17:
	li 30,15
	b .L33
.L18:
	li 30,14
.L33:
	li 8,0
.L13:
	cmpwi 0,30,-1
	bc 12,2,.L34
	lwz 9,84(31)
	slwi 11,30,2
	addi 9,9,1976
	lwzx 0,9,11
	cmpwi 0,0,0
	bc 4,1,.L22
.L34:
	li 3,0
	b .L32
.L22:
	cmpwi 0,8,0
	bc 12,2,.L23
	lis 29,gi@ha
	lis 3,.LC1@ha
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC4@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC4@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfs 2,0(9)
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 3,0(9)
	blrl
	b .L24
.L23:
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC4@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC4@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfs 2,0(9)
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 3,0(9)
	blrl
.L24:
	lwz 9,84(31)
	lwz 3,1816(9)
	bl GetItemByTag
	lwz 9,84(31)
	mr 4,3
	mr 5,30
	mr 3,31
	lwz 8,1828(9)
	lwz 6,1820(9)
	lwz 7,1824(9)
	bl StashItem
	lwz 11,84(31)
	li 9,1
	li 10,0
	addi 0,30,-14
	stw 9,1816(11)
	cmplwi 0,0,1
	lwz 9,84(31)
	stw 10,1820(9)
	lwz 11,84(31)
	stw 10,1824(11)
	lwz 9,84(31)
	stw 10,1828(9)
	bc 12,1,.L25
	lwz 9,1020(31)
	cmpwi 0,9,0
	bc 12,2,.L25
	lwz 29,548(9)
	cmpwi 0,29,0
	bc 12,2,.L31
	lis 9,.LC3@ha
	lis 11,DroppedThink@ha
	lfd 31,.LC3@l(9)
	la 28,DroppedThink@l(11)
	lis 9,level@ha
	la 30,level@l(9)
.L30:
	lfs 0,992(29)
	mr 3,31
	lwz 4,648(29)
	lwz 5,996(29)
	lwz 6,532(29)
	lwz 7,508(29)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 8,20(1)
	bl StashItem
	stw 28,436(29)
	lfs 0,4(30)
	fadd 0,0,31
	frsp 0,0
	stfs 0,428(29)
	lwz 29,548(29)
	cmpwi 0,29,0
	bc 4,2,.L30
.L31:
	lwz 10,1020(31)
	lis 9,DroppedThink@ha
	lis 8,level+4@ha
	la 9,DroppedThink@l(9)
	lis 11,.LC3@ha
	stw 9,436(10)
	li 0,0
	lfs 0,level+4@l(8)
	lfd 13,.LC3@l(11)
	lwz 9,1020(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(9)
	stw 0,1020(31)
.L25:
	li 3,1
.L32:
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 UseArmour,.Lfe1-UseArmour
	.section	".rodata"
	.align 3
.LC6:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl PutOnStorageItem
	.type	 PutOnStorageItem,@function
PutOnStorageItem:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	mr 30,3
	lwz 9,1020(30)
	cmpwi 0,9,0
	bc 12,2,.L6
	lwz 31,548(9)
	cmpwi 0,31,0
	bc 12,2,.L9
	lis 9,.LC6@ha
	lis 11,DroppedThink@ha
	lfd 31,.LC6@l(9)
	la 28,DroppedThink@l(11)
	lis 9,level@ha
	la 29,level@l(9)
.L10:
	lfs 0,992(31)
	mr 3,30
	lwz 4,648(31)
	lwz 5,996(31)
	lwz 6,532(31)
	lwz 7,508(31)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 8,20(1)
	bl StashItem
	stw 28,436(31)
	lfs 0,4(29)
	fadd 0,0,31
	frsp 0,0
	stfs 0,428(31)
	lwz 31,548(31)
	cmpwi 0,31,0
	bc 4,2,.L10
.L9:
	lwz 10,1020(30)
	lis 9,DroppedThink@ha
	lis 8,level+4@ha
	la 9,DroppedThink@l(9)
	lis 11,.LC6@ha
	stw 9,436(10)
	li 0,0
	lfs 0,level+4@l(8)
	lfd 13,.LC6@l(11)
	lwz 9,1020(30)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(9)
	stw 0,1020(30)
.L6:
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 PutOnStorageItem,.Lfe2-PutOnStorageItem
	.align 2
	.globl Think_Armor
	.type	 Think_Armor,@function
Think_Armor:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	li 30,-1
	lwz 9,84(31)
	li 29,-1
	lwz 0,4664(9)
	lwz 11,4620(9)
	cmpwi 0,0,0
	bc 4,2,.L44
	lwz 0,4900(9)
	cmpwi 0,0,-1
	bc 4,1,.L38
	bl ChangeRightWeapon
	b .L46
.L38:
	lwz 0,4904(9)
	cmpwi 0,0,-1
	bc 4,1,.L40
	mr 3,31
	bl ChangeLeftWeapon
	b .L46
.L40:
	andi. 0,11,1
	bc 12,2,.L46
	rlwinm 0,11,0,0,30
	mr 3,31
	stw 0,4620(9)
	bl UseArmour
	cmpwi 0,3,0
	bc 12,2,.L46
	mr 3,31
	bl ChangeRightWeapon
	b .L35
.L44:
	li 30,0
.L46:
	cmpwi 0,29,-1
	bc 12,2,.L49
	lwz 9,84(31)
	stw 29,92(9)
.L49:
	cmpwi 0,30,-1
	bc 12,2,.L35
	lwz 9,84(31)
	stw 30,4664(9)
.L35:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 Think_Armor,.Lfe3-Think_Armor
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
