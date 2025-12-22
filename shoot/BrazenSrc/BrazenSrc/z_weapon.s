	.file	"z_weapon.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"player_noise"
	.align 2
.LC1:
	.long 0x0
	.section	".text"
	.align 2
	.globl PlayerNoise
	.type	 PlayerNoise,@function
PlayerNoise:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 25,5
	mr 31,3
	cmpwi 0,25,1
	mr 30,4
	bc 4,2,.L7
	lwz 11,84(31)
	lwz 9,4828(11)
	cmpwi 0,9,0
	bc 12,2,.L7
	addi 0,9,-1
	stw 0,4828(11)
	b .L6
.L7:
	lis 9,.LC1@ha
	lis 11,deathmatch@ha
	la 9,.LC1@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L6
	lwz 0,264(31)
	andi. 9,0,32
	bc 4,2,.L6
	lwz 0,568(31)
	cmpwi 0,0,0
	bc 4,2,.L11
	bl G_Spawn
	lis 28,0xc100
	lis 27,0x4100
	lis 29,.LC0@ha
	mr 10,3
	la 29,.LC0@l(29)
	li 26,1
	stw 28,188(10)
	stw 29,280(10)
	stw 28,192(10)
	stw 28,196(10)
	stw 27,200(10)
	stw 27,204(10)
	stw 27,208(10)
	stw 31,256(10)
	stw 26,184(10)
	stw 10,568(31)
	bl G_Spawn
	mr 10,3
	stw 29,280(10)
	stw 28,196(10)
	stw 27,208(10)
	stw 26,184(10)
	stw 28,188(10)
	stw 28,192(10)
	stw 27,200(10)
	stw 27,204(10)
	stw 31,256(10)
	stw 10,572(31)
.L11:
	cmplwi 0,25,1
	bc 12,1,.L12
	lis 9,level@ha
	lwz 10,568(31)
	lwz 0,level@l(9)
	la 9,level@l(9)
	stw 10,248(9)
	stw 0,252(9)
	b .L13
.L12:
	lis 9,level@ha
	lwz 10,572(31)
	lwz 0,level@l(9)
	la 9,level@l(9)
	stw 10,256(9)
	stw 0,260(9)
.L13:
	lfs 13,0(30)
	lis 9,level+4@ha
	lis 11,gi+72@ha
	lfs 10,200(10)
	mr 3,10
	lfs 12,204(10)
	stfs 13,4(10)
	lfs 0,4(30)
	lfs 11,208(10)
	stfs 0,8(10)
	lfs 13,8(30)
	stfs 13,12(10)
	lfs 0,0(30)
	fsubs 0,0,10
	stfs 0,212(10)
	lfs 13,4(30)
	fsubs 13,13,12
	stfs 13,216(10)
	lfs 0,8(30)
	fsubs 0,0,11
	stfs 0,220(10)
	lfs 13,0(30)
	fadds 13,13,10
	stfs 13,224(10)
	lfs 0,4(30)
	fadds 0,0,12
	stfs 0,228(10)
	lfs 13,8(30)
	fadds 13,13,11
	stfs 13,232(10)
	lfs 0,level+4@l(9)
	stfs 0,604(10)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L6:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 PlayerNoise,.Lfe1-PlayerNoise
	.section	".rodata"
	.align 2
.LC4:
	.string	"models/v_twin_pistols/tris.md2"
	.align 2
.LC5:
	.string	"models/v_twin_submach/tris.md2"
	.align 2
.LC6:
	.string	"models/v_twin_shotguns/tris.md2"
	.section	".text"
	.align 2
	.globl SetupItemModels
	.type	 SetupItemModels,@function
SetupItemModels:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	li 31,0
	lwz 9,84(29)
	lwz 3,1816(9)
	cmpwi 0,3,1
	bc 4,1,.L63
	bl GetItemByTag
	mr 31,3
.L63:
	lwz 9,84(29)
	li 10,0
	lwz 3,1832(9)
	cmpwi 0,3,1
	bc 4,1,.L64
	bl GetItemByTag
	mr 10,3
.L64:
	addic 0,31,-1
	subfe 9,0,31
	addic 11,10,-1
	subfe 0,11,10
	and. 11,9,0
	bc 12,2,.L65
	lwz 0,20(31)
	cmpwi 0,0,2
	mr 11,0
	bc 4,2,.L66
	lwz 0,20(10)
	cmpwi 0,0,2
	bc 4,2,.L66
	lis 9,.LC4@ha
	la 30,.LC4@l(9)
	b .L68
.L66:
	cmpwi 0,11,4
	bc 4,2,.L69
	lwz 0,20(10)
	cmpwi 0,0,4
	bc 4,2,.L69
	lis 9,.LC5@ha
	la 30,.LC5@l(9)
	b .L68
.L69:
	cmpwi 0,11,6
	bc 4,2,.L71
	lwz 0,20(10)
	cmpwi 0,0,6
	bc 4,2,.L71
	lis 9,.LC6@ha
	la 30,.LC6@l(9)
	b .L68
.L71:
	li 30,0
.L68:
	cmpwi 0,11,2
	bc 4,2,.L73
	lwz 0,20(10)
	cmpwi 0,0,2
	bc 4,2,.L73
	li 31,3
	b .L80
.L73:
	cmpwi 0,11,4
	bc 4,2,.L76
	lwz 0,20(10)
	cmpwi 0,0,4
	bc 4,2,.L76
	li 31,5
	b .L80
.L76:
	cmpwi 0,11,6
	li 31,0
	bc 4,2,.L80
	lwz 0,20(10)
	xori 0,0,6
	addic 0,0,-1
	subfe 0,0,0
	rlwinm 31,0,0,29,31
	b .L80
.L65:
	cmpwi 0,31,0
	bc 12,2,.L81
	lwz 0,8(31)
	cmpwi 0,0,0
	bc 12,2,.L82
	mr 30,0
	b .L83
.L82:
	lwz 9,4(31)
	addic 0,9,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,30,0
	or 30,0,9
.L83:
	lwz 31,20(31)
	b .L80
.L81:
	cmpwi 0,10,0
	bc 12,2,.L86
	lwz 0,8(10)
	cmpwi 0,0,0
	bc 12,2,.L87
	mr 30,0
	b .L88
.L87:
	lwz 9,4(10)
	addic 0,9,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,30,0
	or 30,0,9
.L88:
	lwz 31,20(10)
	b .L80
.L86:
	lwz 9,84(29)
	li 30,0
	li 31,-1
	stw 10,92(9)
.L80:
	lwz 9,84(29)
	cmpwi 0,30,0
	li 0,0
	addi 31,31,-1
	stw 0,4832(9)
	bc 12,2,.L91
	lis 9,gi+32@ha
	mr 3,30
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
	lwz 9,84(29)
	stw 3,88(9)
	b .L92
.L91:
	lwz 9,84(29)
	stw 30,88(9)
.L92:
	lwz 0,40(29)
	cmpwi 0,0,255
	bc 4,2,.L93
	cmpwi 0,31,0
	li 3,0
	bc 4,1,.L94
	rlwinm 3,31,8,16,23
.L94:
	lis 11,g_edicts@ha
	lis 0,0xa27a
	lwz 9,g_edicts@l(11)
	ori 0,0,52719
	subf 9,9,29
	mullw 9,9,0
	srawi 9,9,2
	addi 9,9,-1
	or 9,9,3
	stw 9,60(29)
.L93:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 SetupItemModels,.Lfe2-SetupItemModels
	.align 2
	.globl ChangeLeftWeapon
	.type	 ChangeLeftWeapon,@function
ChangeLeftWeapon:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,1832(9)
	cmpwi 0,0,1
	bc 4,1,.L97
	lwz 0,1816(9)
	stw 0,5204(9)
	lwz 9,84(31)
	lwz 3,1832(9)
	bl GetItemByTag
	mr 30,3
	mr 4,31
	bl GetFreeBodyArea
	mr. 0,3
	bc 12,0,.L97
	lwz 11,84(31)
	mr 4,30
	mr 5,0
	mr 3,31
	stw 0,5208(11)
	lwz 9,84(31)
	lwz 8,1844(9)
	lwz 6,1836(9)
	lwz 7,1840(9)
	bl StashItem
.L97:
	lwz 11,84(31)
	li 0,0
	li 10,1
	stw 0,92(11)
	lwz 9,84(31)
	stw 10,1832(9)
	lwz 11,84(31)
	stw 0,1836(11)
	lwz 9,84(31)
	stw 0,1840(9)
	lwz 11,84(31)
	stw 0,1844(11)
	lwz 11,84(31)
	lwz 0,4904(11)
	cmpwi 0,0,-1
	bc 12,2,.L99
	slwi 0,0,2
	addi 9,11,1848
	lwzx 0,9,0
	cmpwi 0,0,1
	bc 4,1,.L99
	stw 0,1832(11)
	li 7,3
	mr 3,31
	lwz 11,84(31)
	lwz 0,4904(11)
	addi 10,11,1976
	slwi 0,0,2
	lwzx 9,10,0
	stw 9,1836(11)
	lwz 10,84(31)
	lwz 0,4904(10)
	addi 11,10,2104
	slwi 0,0,2
	lwzx 9,11,0
	stw 9,1840(10)
	lwz 8,84(31)
	lwz 0,4904(8)
	addi 11,8,2232
	slwi 0,0,2
	lwzx 9,11,0
	stw 9,1844(8)
	lwz 11,84(31)
	stw 7,4664(11)
	lwz 9,84(31)
	lwz 4,4904(9)
	bl RemoveItem
	b .L100
.L99:
	lwz 9,84(31)
	li 0,0
	stw 0,4664(9)
.L100:
	lwz 11,84(31)
	li 0,-1
	mr 3,31
	stw 0,4904(11)
	lwz 9,84(31)
	stw 0,4900(9)
	bl SetupItemModels
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 ChangeLeftWeapon,.Lfe3-ChangeLeftWeapon
	.align 2
	.globl ChangeRightWeapon
	.type	 ChangeRightWeapon,@function
ChangeRightWeapon:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,1816(9)
	cmpwi 0,0,1
	bc 4,1,.L102
	stw 0,5196(9)
	lwz 9,84(31)
	lwz 3,1816(9)
	bl GetItemByTag
	mr 30,3
	mr 4,31
	bl GetFreeBodyArea
	mr. 0,3
	bc 12,0,.L102
	lwz 11,84(31)
	mr 4,30
	mr 5,0
	mr 3,31
	stw 0,5200(11)
	lwz 9,84(31)
	lwz 8,1828(9)
	lwz 6,1820(9)
	lwz 7,1824(9)
	bl StashItem
.L102:
	lwz 11,84(31)
	li 0,0
	li 10,1
	stw 0,92(11)
	lwz 9,84(31)
	stw 10,1816(9)
	lwz 11,84(31)
	stw 0,1820(11)
	lwz 9,84(31)
	stw 0,1824(9)
	lwz 11,84(31)
	stw 0,1828(11)
	lwz 11,84(31)
	lwz 0,4900(11)
	cmpwi 0,0,-1
	bc 12,2,.L104
	slwi 0,0,2
	addi 9,11,1848
	lwzx 0,9,0
	cmpwi 0,0,1
	bc 4,1,.L104
	stw 0,1816(11)
	li 7,2
	mr 3,31
	lwz 11,84(31)
	lwz 0,4900(11)
	addi 10,11,1976
	slwi 0,0,2
	lwzx 9,10,0
	stw 9,1820(11)
	lwz 10,84(31)
	lwz 0,4900(10)
	addi 11,10,2104
	slwi 0,0,2
	lwzx 9,11,0
	stw 9,1824(10)
	lwz 8,84(31)
	lwz 0,4900(8)
	addi 11,8,2232
	slwi 0,0,2
	lwzx 9,11,0
	stw 9,1828(8)
	lwz 11,84(31)
	stw 7,4664(11)
	lwz 9,84(31)
	lwz 4,4900(9)
	bl RemoveItem
	b .L105
.L104:
	lwz 9,84(31)
	li 0,0
	stw 0,4664(9)
.L105:
	lwz 9,84(31)
	lwz 30,1832(9)
	cmpwi 0,30,1
	bc 4,1,.L106
	lwz 3,1816(9)
	cmpwi 0,3,1
	bc 12,1,.L107
	stw 30,1816(9)
	li 8,0
	lwz 9,84(31)
	lwz 0,1836(9)
	stw 0,1820(9)
	lwz 11,84(31)
	lwz 0,1840(11)
	stw 0,1824(11)
	lwz 10,84(31)
	lwz 0,1844(10)
	stw 0,1828(10)
	lwz 9,84(31)
	stw 8,1832(9)
	lwz 11,84(31)
	stw 8,1836(11)
	lwz 9,84(31)
	stw 8,1840(9)
	lwz 11,84(31)
	stw 8,1844(11)
	b .L106
.L107:
	bl GetItemByTag
	mr 29,3
	mr 3,30
	bl GetItemByTag
	mr 9,3
	subfic 11,29,0
	adde 0,11,29
	subfic 11,9,0
	adde 3,11,9
	or. 11,0,3
	bc 12,2,.L112
	addic 9,29,-1
	subfe 0,9,29
	and 0,0,3
	b .L114
.L112:
	lwz 9,20(9)
	mr 11,9
	addi 9,9,-8
	cmplwi 0,9,1
	bc 12,1,.L115
	lwz 9,84(31)
	li 0,0
	stw 11,2360(9)
	b .L114
.L115:
	lwz 0,20(29)
	cmpwi 0,0,2
	mr 9,0
	bc 4,2,.L116
	cmpwi 0,11,2
	bc 4,2,.L116
	lis 9,.LC4@ha
	la 0,.LC4@l(9)
	b .L118
.L116:
	cmpwi 0,9,4
	bc 4,2,.L119
	cmpwi 0,11,4
	bc 4,2,.L119
	lis 9,.LC5@ha
	la 0,.LC5@l(9)
	b .L118
.L119:
	cmpwi 0,9,6
	bc 4,2,.L121
	cmpwi 0,11,6
	bc 4,2,.L121
	lis 9,.LC6@ha
	la 0,.LC6@l(9)
	b .L118
.L121:
	li 0,0
.L118:
	addic 9,0,-1
	subfe 11,9,0
	mr 0,11
.L114:
	cmpwi 0,0,0
	bc 4,2,.L106
	mr 3,31
	bl ChangeLeftWeapon
.L106:
	lwz 11,84(31)
	li 0,-1
	mr 3,31
	stw 0,4904(11)
	lwz 9,84(31)
	stw 0,4900(9)
	bl SetupItemModels
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 ChangeRightWeapon,.Lfe4-ChangeRightWeapon
	.align 2
	.globl AutoSwitchWeapon
	.type	 AutoSwitchWeapon,@function
AutoSwitchWeapon:
	stwu 1,-32(1)
	mflr 0
	mfcr 12
	stmw 28,16(1)
	stw 0,36(1)
	stw 12,12(1)
	subfic 0,4,0
	adde 9,0,4
	mr 31,3
	subfic 10,5,0
	adde 0,10,5
	li 7,-1
	and. 11,9,0
	li 30,-1
	bc 12,2,.L138
	lwz 8,84(31)
	lwz 7,5200(8)
	addi 10,8,1848
	lwz 11,5196(8)
	slwi 9,7,2
	lwz 29,5208(8)
	lwzx 0,10,9
	cmpw 0,0,11
	bc 4,2,.L139
	stw 7,4900(8)
	bl ChangeRightWeapon
.L139:
	lwz 8,84(31)
	slwi 10,29,2
	addi 9,8,1848
	lwz 11,5204(8)
	lwzx 0,9,10
	cmpw 0,0,11
	bc 4,2,.L140
	stw 29,4904(8)
	mr 3,31
	bl ChangeLeftWeapon
.L140:
	lwz 11,84(31)
	li 0,0
	stw 0,5200(11)
	lwz 9,84(31)
	stw 0,5208(9)
	lwz 11,84(31)
	stw 30,5196(11)
	lwz 9,84(31)
	stw 30,5204(9)
	lwz 11,84(31)
	lwz 0,1816(11)
	cmpwi 0,0,1
	bc 4,2,.L137
	li 8,0
	li 7,0
	b .L144
.L147:
	addi 7,7,4
	addi 8,8,1
.L144:
	cmpwi 0,8,31
	bc 12,1,.L137
	lwz 10,84(31)
	addi 11,10,1848
	lwzx 9,11,7
	addi 9,9,-2
	cmplwi 0,9,20
	bc 12,1,.L147
	b .L173
.L138:
	li 0,32
	cmpwi 7,4,1
	cmpwi 6,5,1
	mtctr 0
	li 8,0
	li 28,-1
	li 3,0
	li 6,0
	mfcr 29
	rlwinm 12,29,30,1
	rlwinm 29,29,26,1
.L172:
	subfic 0,7,-1
	subfic 9,0,0
	adde 0,9,0
	and. 10,12,0
	bc 12,2,.L154
	lwz 9,84(31)
	xor 0,8,30
	addic 10,0,-1
	subfe 11,10,0
	addi 9,9,1848
	lwzx 0,9,6
	xor 0,0,4
	subfic 9,0,0
	adde 0,9,0
	and 0,0,11
	addic 0,0,-1
	subfe 0,0,0
	andc 9,8,0
	and 0,7,0
	or 7,0,9
.L154:
	subfic 0,30,-1
	subfic 10,0,0
	adde 0,10,0
	and. 11,29,0
	bc 12,2,.L155
	lwz 9,84(31)
	xor 0,8,7
	addic 10,0,-1
	subfe 11,10,0
	addi 9,9,1848
	lwzx 0,9,3
	xor 0,0,5
	subfic 9,0,0
	adde 0,9,0
	and 0,0,11
	addic 0,0,-1
	subfe 0,0,0
	andc 9,8,0
	and 0,30,0
	or 30,0,9
.L155:
	nor 9,7,7
	nor 11,30,30
	addic 0,9,-1
	subfe 10,0,9
	addic 9,11,-1
	subfe 0,9,11
	and. 11,10,0
	bc 4,2,.L151
	addi 3,3,4
	addi 6,6,4
	addi 8,8,1
	bdnz .L172
.L151:
	cmpwi 7,7,-1
	cmpwi 4,30,-1
	mfcr 0
	rlwinm 9,0,31,1
	rlwinm 0,0,19,1
	and. 10,9,0
	bc 12,2,.L158
	lwz 8,84(31)
	lwz 7,5200(8)
	addi 10,8,1848
	lwz 11,5196(8)
	slwi 9,7,2
	lwz 30,5208(8)
	lwzx 0,10,9
	cmpw 0,0,11
	bc 4,2,.L159
	stw 7,4900(8)
	mr 3,31
	bl ChangeRightWeapon
.L159:
	lwz 8,84(31)
	slwi 10,30,2
	addi 9,8,1848
	lwz 11,5204(8)
	lwzx 0,9,10
	cmpw 0,0,11
	bc 4,2,.L160
	stw 30,4904(8)
	mr 3,31
	bl ChangeLeftWeapon
.L160:
	lwz 11,84(31)
	li 0,0
	stw 0,5200(11)
	lwz 9,84(31)
	stw 0,5208(9)
	lwz 11,84(31)
	stw 28,5196(11)
	lwz 9,84(31)
	stw 28,5204(9)
	lwz 11,84(31)
	lwz 0,1816(11)
	cmpwi 0,0,1
	bc 4,2,.L137
	li 8,0
	li 7,0
	b .L164
.L167:
	addi 7,7,4
	addi 8,8,1
.L164:
	cmpwi 0,8,31
	bc 12,1,.L137
	lwz 10,84(31)
	addi 11,10,1848
	lwzx 9,11,7
	addi 9,9,-2
	cmplwi 0,9,20
	bc 12,1,.L167
.L173:
	stw 8,4900(10)
	mr 3,31
	bl ChangeRightWeapon
	b .L137
.L158:
	bc 12,30,.L170
	lwz 9,84(31)
	mr 3,31
	stw 7,4900(9)
	bl ChangeRightWeapon
.L170:
	bc 12,18,.L137
	lwz 9,84(31)
	mr 3,31
	stw 30,4904(9)
	bl ChangeLeftWeapon
.L137:
	lwz 0,36(1)
	lwz 12,12(1)
	mtlr 0
	lmw 28,16(1)
	mtcrf 8,12
	la 1,32(1)
	blr
.Lfe5:
	.size	 AutoSwitchWeapon,.Lfe5-AutoSwitchWeapon
	.section	".rodata"
	.align 2
.LC7:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Think_Weapon
	.type	 Think_Weapon,@function
Think_Weapon:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L174
	lwz 30,84(31)
	cmpwi 0,30,0
	mr 8,30
	bc 12,2,.L174
	lwz 0,4892(30)
	cmpwi 0,0,0
	bc 4,2,.L174
	lis 9,level+4@ha
	lfs 13,4920(30)
	lis 11,.LC7@ha
	lfs 0,level+4@l(9)
	la 11,.LC7@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L178
	lwz 0,4620(30)
	andi. 9,0,1
	bc 12,2,.L179
	rlwinm 0,0,0,0,29
	stw 0,4620(30)
	lwz 11,84(31)
	lwz 0,4612(11)
	rlwinm 0,0,0,0,29
	stw 0,4612(11)
	lwz 9,84(31)
	lwz 3,1816(9)
	cmpwi 0,3,1
	bc 4,1,.L180
	bl GetItemByTag
	mr. 3,3
	bc 12,2,.L180
	lwz 9,84(31)
	lwz 10,20(3)
	lwz 0,4924(9)
	addi 11,9,4928
	mr 8,9
	cmpwi 0,10,6
	slwi 0,0,2
	lwzx 0,11,0
	bc 12,2,.L183
	bc 12,1,.L184
	cmpwi 0,10,4
	bc 12,2,.L185
	b .L191
.L184:
	cmpwi 0,10,11
	bc 12,2,.L187
	b .L191
.L185:
	cmpwi 0,0,25
	bc 12,2,.L303
	cmpwi 0,0,35
	b .L302
.L183:
	cmpwi 0,0,26
	bc 12,2,.L303
	cmpwi 0,0,31
	bc 12,2,.L303
	cmpwi 0,0,32
.L302:
	bc 4,2,.L191
.L303:
	li 0,1
	b .L189
.L187:
	cmpwi 0,0,28
	bc 12,2,.L303
	cmpwi 0,0,33
	bc 12,2,.L303
	cmpwi 0,0,34
	li 0,1
	bc 12,2,.L189
.L191:
	li 0,0
.L189:
	cmpwi 0,0,0
	bc 12,2,.L182
	li 0,9
	lis 10,0xc120
	stw 0,4664(8)
	lwz 9,84(31)
	stw 10,4920(9)
	lwz 11,84(31)
	lwz 0,4924(11)
	addi 10,11,4928
	slwi 0,0,2
	lwzx 9,10,0
	stw 9,4908(11)
	b .L174
.L182:
	mr 4,31
	bl GetFreeBodyArea
	cmpwi 0,3,-1
	bc 4,2,.L180
	mr 3,31
	li 4,50
	bl ThrowRightHandItem
.L180:
	lwz 9,84(31)
	lis 0,0xc120
	stw 0,4920(9)
	lwz 11,84(31)
	lwz 0,4924(11)
	addi 10,11,5056
	slwi 0,0,2
	lwzx 9,10,0
	stw 9,4900(11)
	b .L174
.L179:
	andi. 9,0,2
	bc 12,2,.L201
	lwz 9,4924(30)
	addi 11,30,5056
	addi 10,30,1848
	lwz 3,1816(30)
	li 28,0
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,3,1
	slwi 0,0,2
	lwzx 29,10,0
	bc 4,1,.L202
	bl GetItemByTag
	mr 28,3
.L202:
	cmpwi 0,29,1
	li 9,0
	bc 4,1,.L203
	mr 3,29
	bl GetItemByTag
	mr 9,3
.L203:
	subfic 11,28,0
	adde 0,11,28
	subfic 11,9,0
	adde 3,11,9
	or. 11,0,3
	bc 12,2,.L204
	addic 9,28,-1
	subfe 0,9,28
	and 0,0,3
	b .L206
.L204:
	lwz 9,20(9)
	mr 11,9
	addi 9,9,-8
	cmplwi 0,9,1
	bc 12,1,.L207
	lwz 9,84(31)
	li 0,0
	stw 11,2360(9)
	b .L206
.L207:
	lwz 0,20(28)
	cmpwi 0,0,2
	mr 9,0
	bc 4,2,.L208
	cmpwi 0,11,2
	bc 4,2,.L208
	lis 9,.LC4@ha
	la 0,.LC4@l(9)
	b .L210
.L208:
	cmpwi 0,9,4
	bc 4,2,.L211
	cmpwi 0,11,4
	bc 4,2,.L211
	lis 9,.LC5@ha
	la 0,.LC5@l(9)
	b .L210
.L211:
	cmpwi 0,9,6
	bc 4,2,.L213
	cmpwi 0,11,6
	bc 4,2,.L213
	lis 9,.LC6@ha
	la 0,.LC6@l(9)
	b .L210
.L213:
	li 0,0
.L210:
	addic 9,0,-1
	subfe 11,9,0
	mr 0,11
.L206:
	cmpwi 0,0,0
	lwz 8,84(31)
	bc 12,2,.L201
	lwz 0,4620(8)
	rlwinm 0,0,0,0,29
	stw 0,4620(8)
	lwz 11,84(31)
	lwz 0,4612(11)
	rlwinm 0,0,0,0,29
	stw 0,4612(11)
	lwz 9,84(31)
	lwz 3,1832(9)
	cmpwi 0,3,1
	bc 4,1,.L215
	bl GetItemByTag
	mr. 3,3
	bc 12,2,.L215
	lwz 9,84(31)
	lwz 10,20(3)
	lwz 0,4924(9)
	addi 11,9,4928
	mr 8,9
	cmpwi 0,10,6
	slwi 0,0,2
	lwzx 0,11,0
	bc 12,2,.L218
	bc 12,1,.L219
	cmpwi 0,10,4
	bc 12,2,.L220
	b .L226
.L219:
	cmpwi 0,10,11
	bc 12,2,.L222
	b .L226
.L220:
	cmpwi 0,0,25
	bc 12,2,.L306
	cmpwi 0,0,35
	b .L305
.L218:
	cmpwi 0,0,26
	bc 12,2,.L306
	cmpwi 0,0,31
	bc 12,2,.L306
	cmpwi 0,0,32
.L305:
	bc 4,2,.L226
.L306:
	li 0,1
	b .L224
.L222:
	cmpwi 0,0,28
	bc 12,2,.L306
	cmpwi 0,0,33
	bc 12,2,.L306
	cmpwi 0,0,34
	li 0,1
	bc 12,2,.L224
.L226:
	li 0,0
.L224:
	cmpwi 0,0,0
	bc 12,2,.L217
	li 0,9
	lis 10,0xc120
	stw 0,4664(8)
	lwz 9,84(31)
	stw 10,4920(9)
	lwz 11,84(31)
	lwz 0,4924(11)
	addi 10,11,4928
	slwi 0,0,2
	lwzx 9,10,0
	stw 9,4912(11)
	b .L174
.L217:
	mr 4,31
	bl GetFreeBodyArea
	cmpwi 0,3,-1
	bc 4,2,.L215
	mr 3,31
	li 4,50
	bl ThrowLeftHandItem
.L215:
	lwz 9,84(31)
	lis 0,0xc120
	stw 0,4920(9)
	lwz 11,84(31)
	lwz 0,4924(11)
	addi 10,11,5056
	slwi 0,0,2
	lwzx 9,10,0
	stw 9,4904(11)
	b .L174
.L201:
	lwz 0,4916(8)
	cmpwi 0,0,0
	bc 12,2,.L178
	lis 0,0xc120
	stw 0,4920(8)
.L178:
	lwz 9,1816(30)
	addi 9,9,-1
	cmplwi 0,9,50
	bc 12,1,.L299
	lis 11,.L300@ha
	slwi 10,9,2
	la 11,.L300@l(11)
	lis 9,.L300@ha
	lwzx 0,10,11
	la 9,.L300@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L300:
	.long .L299-.L300
	.long .L238-.L300
	.long .L299-.L300
	.long .L244-.L300
	.long .L299-.L300
	.long .L250-.L300
	.long .L299-.L300
	.long .L257-.L300
	.long .L257-.L300
	.long .L262-.L300
	.long .L267-.L300
	.long .L272-.L300
	.long .L277-.L300
	.long .L284-.L300
	.long .L292-.L300
	.long .L292-.L300
	.long .L292-.L300
	.long .L295-.L300
	.long .L294-.L300
	.long .L297-.L300
	.long .L293-.L300
	.long .L296-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L282-.L300
	.long .L283-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L299-.L300
	.long .L289-.L300
	.long .L289-.L300
	.long .L289-.L300
	.long .L289-.L300
	.long .L289-.L300
.L238:
	lwz 10,1832(30)
	cmpwi 0,10,1
	bc 12,2,.L242
	cmpwi 0,10,2
	bc 4,2,.L242
	mr 3,31
	bl Think_TwinPistol
	b .L174
.L242:
	mr 3,31
	bl Think_Pistol
	b .L174
.L244:
	lwz 10,1832(30)
	cmpwi 0,10,1
	bc 12,2,.L248
	cmpwi 0,10,4
	bc 4,2,.L248
	mr 3,31
	bl Think_TwinSubMach
	b .L174
.L248:
	mr 3,31
	bl Think_SubMach
	b .L174
.L250:
	lwz 10,1832(30)
	cmpwi 0,10,1
	bc 12,2,.L254
	cmpwi 0,10,6
	bc 4,2,.L254
	mr 3,31
	bl Think_TwinShotgun
	b .L174
.L254:
	mr 3,31
	bl Think_Shotgun
	b .L174
.L257:
	mr 3,31
	bl Think_HandGrenade
	b .L174
.L262:
	mr 3,31
	bl Think_Chaingun
	b .L174
.L267:
	mr 3,31
	bl Think_GrenadeLauncher
	b .L174
.L272:
	mr 3,31
	bl Think_AssaultRifle
	b .L174
.L277:
	mr 3,31
	bl Think_Railgun
	b .L174
.L282:
	mr 3,31
	bl Think_Health
	b .L174
.L283:
	mr 3,31
	bl Think_HealthLarge
	b .L174
.L284:
	mr 3,31
	bl Think_WEdit
	b .L174
.L289:
	mr 3,31
	bl Think_Armor
	b .L174
.L292:
	mr 3,31
	bl Think_StroggSoldierWeapon
	b .L174
.L293:
	mr 3,31
	bl Think_BitchWeapon
	b .L174
.L294:
	mr 3,31
	bl Think_GunnerWeapon
	b .L174
.L295:
	mr 3,31
	bl Think_InfWeapon
	b .L174
.L296:
	mr 3,31
	bl Think_TankWeapon
	b .L174
.L297:
	mr 3,31
	bl Think_MedicWeapon
	b .L174
.L299:
	mr 3,31
	bl Think_Hands
.L174:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 Think_Weapon,.Lfe6-Think_Weapon
	.section	".rodata"
	.align 3
.LC8:
	.long 0x40768000
	.long 0x0
	.align 3
.LC9:
	.long 0x40668000
	.long 0x0
	.align 2
.LC10:
	.long 0x43340000
	.align 2
.LC11:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl Calc_Arc
	.type	 Calc_Arc,@function
Calc_Arc:
	stwu 1,-64(1)
	mflr 0
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 28,32(1)
	stw 0,68(1)
	lis 9,.LC10@ha
	mr 29,3
	la 9,.LC10@l(9)
	addi 4,1,8
	lfs 30,0(9)
	addi 3,29,376
	lis 28,.LC8@ha
	bl vectoangles
	lfs 13,16(29)
	lfs 0,8(1)
	lfs 10,24(29)
	lfs 11,12(1)
	fsubs 0,0,13
	lfs 12,16(1)
	lfs 13,20(29)
	lfd 2,.LC8@l(28)
	fadds 1,0,30
	stfs 0,8(1)
	fsubs 11,11,13
	fsubs 12,12,10
	stfs 11,12(1)
	stfs 12,16(1)
	bl fmod
	lis 9,.LC9@ha
	lfs 13,12(1)
	lfd 31,.LC9@l(9)
	lfd 2,.LC8@l(28)
	fadds 13,13,30
	fsub 0,1,31
	fmr 1,13
	frsp 0,0
	stfs 0,8(1)
	bl fmod
	lfs 13,16(1)
	fsub 0,1,31
	lfd 2,.LC8@l(28)
	fadds 13,13,30
	frsp 0,0
	fmr 1,13
	stfs 0,12(1)
	bl fmod
	fsub 0,1,31
	lis 9,.LC11@ha
	addi 4,29,388
	la 9,.LC11@l(9)
	addi 3,1,8
	lfs 1,0(9)
	frsp 0,0
	stfs 0,16(1)
	bl VectorScale
	lwz 0,68(1)
	mtlr 0
	lmw 28,32(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe7:
	.size	 Calc_Arc,.Lfe7-Calc_Arc
	.align 2
	.globl P_ProjectSource
	.type	 P_ProjectSource,@function
P_ProjectSource:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	lfs 12,4(5)
	mr 9,7
	lfs 13,8(5)
	mr 7,8
	lfs 0,0(5)
	stfs 12,12(1)
	stfs 13,16(1)
	stfs 0,8(1)
	lwz 0,716(3)
	cmpwi 0,0,1
	bc 4,2,.L16
	fneg 0,12
	stfs 0,12(1)
	b .L17
.L16:
	cmpwi 0,0,2
	bc 4,2,.L17
	li 0,0
	stw 0,12(1)
.L17:
	mr 3,4
	mr 5,6
	mr 6,9
	addi 4,1,8
	bl G_ProjectSource
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe8:
	.size	 P_ProjectSource,.Lfe8-P_ProjectSource
	.align 2
	.globl CheckAltAmmo
	.type	 CheckAltAmmo,@function
CheckAltAmmo:
	lwz 0,20(4)
	cmpwi 0,0,6
	bc 12,2,.L24
	bc 12,1,.L34
	cmpwi 0,0,4
	bc 12,2,.L21
	b .L20
.L34:
	cmpwi 0,0,11
	bc 12,2,.L28
	b .L20
.L21:
	cmpwi 0,5,25
	bc 12,2,.L308
	cmpwi 0,5,35
.L309:
	bc 4,2,.L20
.L308:
	li 3,1
	blr
.L24:
	cmpwi 0,5,26
	bc 12,2,.L308
	cmpwi 0,5,31
	bc 12,2,.L308
	cmpwi 0,5,32
	b .L309
.L28:
	cmpwi 0,5,28
	bc 12,2,.L308
	cmpwi 0,5,33
	bc 12,2,.L308
	cmpwi 0,5,34
	li 3,1
	bclr 12,2
.L20:
	li 3,0
	blr
.Lfe9:
	.size	 CheckAltAmmo,.Lfe9-CheckAltAmmo
	.align 2
	.globl GetTwoWeaponViewModel
	.type	 GetTwoWeaponViewModel,@function
GetTwoWeaponViewModel:
	lwz 0,20(3)
	cmpwi 0,0,2
	bc 4,2,.L36
	lwz 0,20(4)
	cmpwi 0,0,2
	bc 4,2,.L36
	lis 3,.LC4@ha
	la 3,.LC4@l(3)
	blr
.L36:
	lwz 0,20(3)
	cmpwi 0,0,4
	mr 9,0
	bc 4,2,.L38
	lwz 0,20(4)
	cmpwi 0,0,4
	bc 4,2,.L38
	lis 3,.LC5@ha
	la 3,.LC5@l(3)
	blr
.L38:
	cmpwi 0,9,6
	bc 4,2,.L40
	lwz 0,20(4)
	cmpwi 0,0,6
	bc 4,2,.L40
	lis 3,.LC6@ha
	la 3,.LC6@l(3)
	blr
.L40:
	li 3,0
	blr
.Lfe10:
	.size	 GetTwoWeaponViewModel,.Lfe10-GetTwoWeaponViewModel
	.align 2
	.globl GetTwoWeaponModelIndex2Tag
	.type	 GetTwoWeaponModelIndex2Tag,@function
GetTwoWeaponModelIndex2Tag:
	lwz 0,20(3)
	cmpwi 0,0,2
	bc 4,2,.L43
	lwz 0,20(4)
	cmpwi 0,0,2
	bc 4,2,.L43
	li 3,3
	blr
.L43:
	lwz 0,20(3)
	cmpwi 0,0,4
	mr 9,0
	bc 4,2,.L45
	lwz 0,20(4)
	cmpwi 0,0,4
	bc 4,2,.L45
	li 3,5
	blr
.L45:
	cmpwi 0,9,6
	bc 4,2,.L47
	lwz 0,20(4)
	li 3,7
	cmpwi 0,0,6
	bclr 12,2
.L47:
	li 3,0
	blr
.Lfe11:
	.size	 GetTwoWeaponModelIndex2Tag,.Lfe11-GetTwoWeaponModelIndex2Tag
	.align 2
	.globl TwoWeaponComboOk
	.type	 TwoWeaponComboOk,@function
TwoWeaponComboOk:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	cmpwi 0,4,1
	mr 29,3
	mr 31,5
	li 30,0
	bc 4,1,.L50
	mr 3,4
	bl GetItemByTag
	mr 30,3
.L50:
	cmpwi 0,31,1
	li 3,0
	bc 4,1,.L51
	mr 3,31
	bl GetItemByTag
.L51:
	subfic 9,30,0
	adde 0,9,30
	subfic 11,3,0
	adde 9,11,3
	or. 11,0,9
	bc 12,2,.L52
	addic 0,30,-1
	subfe 3,0,30
	and 3,3,9
	b .L312
.L52:
	lwz 9,20(3)
	mr 11,9
	addi 9,9,-8
	cmplwi 0,9,1
	bc 12,1,.L54
	lwz 9,84(29)
	li 3,0
	stw 11,2360(9)
	b .L312
.L54:
	lwz 0,20(30)
	cmpwi 0,0,2
	mr 9,0
	bc 4,2,.L55
	cmpwi 0,11,2
	bc 4,2,.L55
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	b .L57
.L55:
	cmpwi 0,9,4
	bc 4,2,.L58
	cmpwi 0,11,4
	bc 4,2,.L58
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	b .L57
.L58:
	cmpwi 0,9,6
	bc 4,2,.L60
	cmpwi 0,11,6
	bc 4,2,.L60
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	b .L57
.L60:
	li 9,0
.L57:
	addic 11,9,-1
	subfe 3,11,9
.L312:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 TwoWeaponComboOk,.Lfe12-TwoWeaponComboOk
	.align 2
	.globl AutoSwitchOld
	.type	 AutoSwitchOld,@function
AutoSwitchOld:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 8,84(31)
	lwz 7,5200(8)
	addi 10,8,1848
	lwz 11,5196(8)
	slwi 9,7,2
	lwz 30,5208(8)
	lwzx 0,10,9
	cmpw 0,0,11
	bc 4,2,.L124
	stw 7,4900(8)
	bl ChangeRightWeapon
.L124:
	lwz 8,84(31)
	slwi 10,30,2
	addi 9,8,1848
	lwz 11,5204(8)
	lwzx 0,9,10
	cmpw 0,0,11
	bc 4,2,.L125
	stw 30,4904(8)
	mr 3,31
	bl ChangeLeftWeapon
.L125:
	lwz 11,84(31)
	li 0,0
	li 10,-1
	stw 0,5200(11)
	lwz 9,84(31)
	stw 0,5208(9)
	lwz 11,84(31)
	stw 10,5196(11)
	lwz 9,84(31)
	stw 10,5204(9)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe13:
	.size	 AutoSwitchOld,.Lfe13-AutoSwitchOld
	.align 2
	.globl AutoSwitchAnything
	.type	 AutoSwitchAnything,@function
AutoSwitchAnything:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 8,84(31)
	lwz 7,5200(8)
	addi 10,8,1848
	lwz 11,5196(8)
	slwi 9,7,2
	lwz 30,5208(8)
	lwzx 0,10,9
	cmpw 0,0,11
	bc 4,2,.L127
	stw 7,4900(8)
	bl ChangeRightWeapon
.L127:
	lwz 8,84(31)
	slwi 10,30,2
	addi 9,8,1848
	lwz 11,5204(8)
	lwzx 0,9,10
	cmpw 0,0,11
	bc 4,2,.L128
	stw 30,4904(8)
	mr 3,31
	bl ChangeLeftWeapon
.L128:
	lwz 11,84(31)
	li 0,0
	li 10,-1
	stw 0,5200(11)
	lwz 9,84(31)
	stw 0,5208(9)
	lwz 11,84(31)
	stw 10,5196(11)
	lwz 9,84(31)
	stw 10,5204(9)
	lwz 11,84(31)
	lwz 0,1816(11)
	cmpwi 0,0,1
	bc 4,2,.L126
	li 8,0
	li 7,0
	b .L131
.L133:
	addi 7,7,4
	addi 8,8,1
.L131:
	cmpwi 0,8,31
	bc 12,1,.L126
	lwz 10,84(31)
	addi 11,10,1848
	lwzx 9,11,7
	addi 9,9,-2
	cmplwi 0,9,20
	bc 12,1,.L133
	stw 8,4900(10)
	mr 3,31
	bl ChangeRightWeapon
.L126:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 AutoSwitchAnything,.Lfe14-AutoSwitchAnything
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
