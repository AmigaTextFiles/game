	.file	"s_scanner.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"cells"
	.align 2
.LC1:
	.string	"No cells for Scanner.\n"
	.align 2
.LC2:
	.string	"misc/comp_up.wav"
	.align 2
.LC3:
	.long 0x0
	.align 2
.LC4:
	.long 0x3f800000
	.align 2
.LC5:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl Toggle_Scanner
	.type	 Toggle_Scanner,@function
Toggle_Scanner:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L7
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L7
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L7
	lwz 29,1820(9)
	cmpwi 0,29,0
	bc 4,2,.L10
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 3,9,3
	addi 11,10,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,11,3
	cmpwi 0,0,0
	bc 4,2,.L11
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L7
.L11:
	stw 29,1828(10)
.L10:
	lwz 10,84(31)
	lwz 0,1820(10)
	andi. 9,0,1
	bc 12,2,.L12
	lwz 0,1824(10)
	cmpwi 7,0,1
	bc 12,29,.L12
	cmpwi 0,0,0
	bc 4,2,.L13
	li 0,1
	stw 0,1824(10)
	b .L7
.L13:
	lis 9,.LC3@ha
	lis 11,ctf@ha
	la 9,.LC3@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L12
	bc 4,30,.L12
	li 0,2
	stw 0,1824(10)
	b .L7
.L12:
	lwz 9,84(31)
	lwz 0,1820(9)
	xori 0,0,1
	andi. 11,0,1
	stw 0,1820(9)
	bc 12,2,.L16
	lwz 11,84(31)
	li 0,0
	stw 0,3588(11)
	lwz 9,84(31)
	stw 0,3576(9)
	lwz 11,84(31)
	stw 0,3592(11)
.L16:
	lwz 11,84(31)
	li 10,0
	lis 29,gi@ha
	la 29,gi@l(29)
	lis 3,.LC2@ha
	lwz 0,1820(11)
	la 3,.LC2@l(3)
	ori 0,0,2
	stw 0,1820(11)
	lwz 9,84(31)
	stw 10,1824(9)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC4@ha
	lwz 0,16(29)
	lis 11,.LC5@ha
	la 9,.LC4@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC5@l(11)
	li 4,0
	mtlr 0
	lis 9,.LC3@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC3@l(9)
	lfs 3,0(9)
	blrl
.L7:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Toggle_Scanner,.Lfe1-Toggle_Scanner
	.section	".rodata"
	.align 2
.LC6:
	.string	"xv 80 yv 40 picn %s "
	.align 2
.LC7:
	.string	"s"
	.align 2
.LC8:
	.string	"xv 122 yv 30 string2 TYPE: xv 160 string %s "
	.align 2
.LC9:
	.string	"Items"
	.align 2
.LC10:
	.string	"Ctf"
	.align 2
.LC11:
	.string	"Life"
	.align 2
.LC12:
	.long 0x0
	.long 0x0
	.long 0xbf800000
	.align 2
.LC13:
	.string	"a"
	.align 2
.LC14:
	.string	""
	.align 2
.LC15:
	.string	"g"
	.align 2
.LC16:
	.string	"d"
	.align 2
.LC17:
	.string	"y"
	.align 2
.LC18:
	.string	"z"
	.align 2
.LC19:
	.string	"m"
	.align 2
.LC20:
	.string	"j"
	.align 2
.LC21:
	.string	"item_flag_team1"
	.align 2
.LC22:
	.string	"xv %i yv %i picn %s "
	.align 2
.LC23:
	.string	"c"
	.align 2
.LC24:
	.string	"i"
	.align 2
.LC25:
	.string	"f"
	.align 2
.LC26:
	.string	"l"
	.align 2
.LC27:
	.string	"o"
	.align 2
.LC28:
	.string	"b"
	.align 2
.LC29:
	.string	"h"
	.align 2
.LC30:
	.string	"e"
	.align 2
.LC31:
	.string	"k"
	.align 2
.LC32:
	.string	"n"
	.align 2
.LC33:
	.long 0x3d000000
	.align 2
.LC34:
	.long 0x40000000
	.align 2
.LC35:
	.long 0x41c00000
	.align 2
.LC36:
	.long 0x42a00000
	.align 2
.LC37:
	.long 0x43200000
	.align 2
.LC38:
	.long 0x42f00000
	.align 3
.LC39:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ShowScanner
	.type	 ShowScanner,@function
ShowScanner:
	stwu 1,-256(1)
	mflr 0
	stfd 28,224(1)
	stfd 29,232(1)
	stfd 30,240(1)
	stfd 31,248(1)
	stmw 14,152(1)
	stw 0,260(1)
	mr 28,3
	mr 24,4
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x3cf3
	lwz 11,84(28)
	la 9,itemlist@l(9)
	ori 0,0,53053
	subf 3,9,3
	addi 10,11,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 9,10,3
	cmpwi 0,9,0
	bc 4,2,.L18
	lwz 0,1828(11)
	cmpwi 0,0,0
	bc 4,2,.L20
	stw 9,1824(11)
	stw 9,1820(11)
	b .L17
.L18:
	lwz 0,1828(11)
	cmpwi 0,0,0
	bc 4,2,.L20
	addi 0,9,-1
	li 11,8
	stwx 0,10,3
	lwz 9,84(28)
	stw 11,1828(9)
.L20:
	lwz 11,84(28)
	lis 5,.LC6@ha
	lis 6,.LC7@ha
	addi 3,1,8
	la 5,.LC6@l(5)
	lwz 9,1828(11)
	la 6,.LC7@l(6)
	li 4,64
	addi 9,9,-1
	stw 9,1828(11)
	crxor 6,6,6
	bl Com_sprintf
	mr 3,24
	bl strlen
	mr 29,3
	addi 3,1,8
	bl strlen
	add 29,29,3
	cmplwi 0,29,1199
	bc 12,1,.L21
	mr 3,24
	addi 4,1,8
	bl strcat
.L21:
	lwz 9,84(28)
	lwz 0,1824(9)
	cmpwi 0,0,0
	bc 12,2,.L22
	cmpwi 0,0,1
	bc 4,2,.L24
	lis 9,.LC9@ha
	la 6,.LC9@l(9)
	b .L23
.L24:
	lis 9,.LC10@ha
	la 6,.LC10@l(9)
	b .L23
.L22:
	lis 9,.LC11@ha
	la 6,.LC11@l(9)
.L23:
	lis 5,.LC8@ha
	addi 3,1,8
	la 5,.LC8@l(5)
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	mr 3,24
	bl strlen
	mr 29,3
	addi 3,1,8
	bl strlen
	add 29,29,3
	cmplwi 0,29,1199
	bc 12,1,.L26
	mr 3,24
	addi 4,1,8
	bl strcat
.L26:
	lis 9,globals+72@ha
	lis 11,g_edicts@ha
	lwz 0,globals+72@l(9)
	lwz 30,g_edicts@l(11)
	mulli 0,0,1160
	add 0,30,0
	cmplw 0,30,0
	bc 4,0,.L17
	lis 10,.LC12@ha
	lis 9,Touch_Item@ha
	lwz 10,.LC12@l(10)
	la 16,Touch_Item@l(9)
	lis 20,.LC15@ha
	lis 9,.LC33@ha
	lis 11,.LC19@ha
	stw 10,120(1)
	la 9,.LC33@l(9)
	lis 22,.LC16@ha
	lis 10,.LC34@ha
	lfs 28,0(9)
	la 14,.LC15@l(20)
	la 10,.LC34@l(10)
	la 15,.LC19@l(11)
	lfs 29,0(10)
	addi 18,1,104
	addi 19,1,88
.L30:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L29
	lwz 11,260(30)
	cmpwi 0,11,1
	bc 12,2,.L29
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 12,2,.L29
	lwz 9,84(28)
	lwz 0,1824(9)
	cmpwi 0,0,0
	bc 4,2,.L34
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 4,2,.L37
	lwz 0,184(30)
	andi. 9,0,4
	bc 12,2,.L29
	cmpwi 0,11,5
	bc 4,2,.L29
.L37:
	cmpw 0,30,28
	bc 12,2,.L29
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L29
	b .L38
.L34:
	cmpwi 0,0,1
	bc 4,2,.L39
	lwz 0,444(30)
	cmpw 0,0,16
	bc 4,2,.L29
	lwz 0,648(30)
	cmpwi 0,0,0
	bc 12,2,.L29
	b .L38
.L39:
	cmpwi 0,0,2
	bc 4,2,.L38
	lwz 0,444(30)
	li 8,1
	cmpw 0,0,16
	bc 4,2,.L44
	lwz 9,648(30)
	lwz 11,4(9)
	lis 9,CTFPickup_Flag@ha
	la 9,CTFPickup_Flag@l(9)
	xor 10,11,9
	lis 9,CTFPickup_Tech@ha
	la 9,CTFPickup_Tech@l(9)
	xor 11,11,9
	srawi 9,10,31
	xor 0,9,10
	subf 0,0,9
	addic 10,11,-1
	subfe 8,10,11
	srawi 0,0,31
	and 8,8,0
.L44:
	lwz 10,84(30)
	xor 0,30,28
	addic 9,0,-1
	subfe 11,9,0
	addic 0,10,-1
	subfe 9,0,10
	and. 10,9,11
	bc 12,2,.L47
	lwz 9,480(30)
	addi 0,9,-1
	or 9,9,0
	srawi 9,9,31
	and 8,8,9
.L47:
	cmpwi 0,8,0
	bc 4,2,.L29
.L38:
	lfs 13,4(30)
	lis 11,.LC35@ha
	lfs 12,4(28)
	li 0,0
	addi 31,1,72
	lfs 11,8(28)
	la 11,.LC35@l(11)
	mr 3,31
	lfs 0,12(28)
	fsubs 12,12,13
	lfs 30,0(11)
	stfs 12,72(1)
	lfs 13,8(30)
	fsubs 11,11,13
	stfs 11,76(1)
	lfs 13,12(30)
	stw 0,80(1)
	fsubs 0,0,13
	fmuls 0,0,28
	fctiwz 10,0
	stfd 10,144(1)
	lwz 21,148(1)
	bl VectorLength
	fmuls 31,1,28
	fcmpu 0,31,30
	cror 3,2,0
	bc 4,3,.L29
	lis 9,.LC12@ha
	lwz 10,120(1)
	mr 3,31
	la 11,.LC12@l(9)
	lis 17,.LC13@ha
	lwz 9,8(11)
	lwz 0,4(11)
	stw 10,104(1)
	stw 9,8(18)
	stw 0,4(18)
	bl VectorNormalize
	lfs 1,20(28)
	mr 5,31
	mr 3,19
	mr 4,18
	bl RotatePointAroundVector
	lis 9,.LC36@ha
	mr 3,19
	la 9,.LC36@l(9)
	mr 4,19
	lfs 1,0(9)
	fmuls 1,31,1
	fdivs 1,1,30
	bl VectorScale
	lis 9,.LC37@ha
	lis 10,.LC38@ha
	lfs 13,92(1)
	la 9,.LC37@l(9)
	la 10,.LC38@l(10)
	lfs 0,88(1)
	lfs 10,0(9)
	lis 11,.LC14@ha
	lfs 9,0(10)
	lis 9,.LC13@ha
	la 27,.LC14@l(11)
	lwz 7,84(30)
	la 31,.LC13@l(9)
	fadds 13,13,10
	mr 8,10
	fadds 0,0,9
	cmpwi 0,7,0
	fsubs 13,13,29
	fsubs 0,0,29
	fctiwz 12,13
	fctiwz 11,0
	stfd 12,144(1)
	lwz 23,148(1)
	stfd 11,144(1)
	lwz 26,148(1)
	bc 12,2,.L50
	lwz 9,84(28)
	lwz 0,1824(9)
	cmpwi 0,0,0
	bc 4,2,.L51
	lis 11,level@ha
	mr 9,10
	lfs 12,3800(7)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC39@ha
	xoris 0,0,0x8000
	la 11,.LC39@l(11)
	stw 0,148(1)
	stw 10,144(1)
	lfd 13,0(11)
	lfd 0,144(1)
	fsub 0,0,13
	frsp 13,0
	fcmpu 0,12,13
	bc 4,1,.L52
	la 31,.LC15@l(20)
.L52:
	lfs 0,3804(7)
	fcmpu 0,0,13
	bc 4,1,.L50
.L103:
	la 31,.LC16@l(22)
	b .L50
.L51:
	cmpwi 0,0,2
	bc 4,2,.L50
	lis 9,flag1_item@ha
	lis 29,flag1_item@ha
	lwz 0,flag1_item@l(9)
	cmpwi 0,0,0
	bc 12,2,.L57
	lis 9,flag2_item@ha
	lwz 0,flag2_item@l(9)
	cmpwi 0,0,0
	bc 4,2,.L56
.L57:
	bl CTFInit
.L56:
	lwz 8,84(30)
	lwz 0,3500(8)
	cmpwi 0,0,1
	bc 12,2,.L59
	cmpwi 0,0,2
	bc 12,2,.L61
	b .L50
.L59:
	lis 11,flag2_item@ha
	lis 9,itemlist@ha
	la 10,itemlist@l(9)
	lwz 0,flag2_item@l(11)
	lis 9,0x3cf3
	addi 11,8,740
	ori 9,9,53053
	subf 0,10,0
	mullw 0,0,9
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L103
	lis 9,.LC17@ha
	la 27,.LC17@l(9)
	b .L103
.L61:
	lis 10,itemlist@ha
	lwz 0,flag1_item@l(29)
	lis 9,0x3cf3
	la 11,itemlist@l(10)
	ori 9,9,53053
	subf 0,11,0
	addi 10,8,740
	mullw 0,0,9
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L62
	lis 9,.LC18@ha
	la 27,.LC18@l(9)
.L62:
	la 31,.LC15@l(20)
.L50:
	lwz 0,444(30)
	cmpw 0,0,16
	bc 4,2,.L65
	lwz 11,648(30)
	cmpwi 0,11,0
	bc 12,2,.L65
	lwz 0,8(11)
	lis 9,Use_Quad@ha
	la 9,Use_Quad@l(9)
	cmpw 0,0,9
	bc 4,2,.L66
	la 31,.LC15@l(20)
	b .L65
.L66:
	lis 9,Use_Invulnerability@ha
	la 9,Use_Invulnerability@l(9)
	cmpw 0,0,9
	bc 4,2,.L68
	la 31,.LC16@l(22)
	b .L65
.L68:
	lis 9,Use_MediPak@ha
	la 9,Use_MediPak@l(9)
	cmpw 0,0,9
	bc 12,2,.L71
	lwz 0,4(11)
	lis 9,Pickup_Health@ha
	la 9,Pickup_Health@l(9)
	cmpw 0,0,9
	bc 12,2,.L71
	lis 9,Pickup_Adrenaline@ha
	la 9,Pickup_Adrenaline@l(9)
	cmpw 0,0,9
	bc 4,2,.L70
.L71:
	lis 11,.LC19@ha
	la 31,.LC19@l(11)
	b .L65
.L70:
	lis 9,CTFPickup_Tech@ha
	la 9,CTFPickup_Tech@l(9)
	cmpw 0,0,9
	bc 4,2,.L73
	lis 10,.LC20@ha
	la 31,.LC20@l(10)
	b .L65
.L73:
	lis 11,CTFPickup_Flag@ha
	la 11,CTFPickup_Flag@l(11)
	cmpw 0,0,11
	bc 4,2,.L65
	lwz 3,280(30)
	lis 4,.LC21@ha
	la 4,.LC21@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L76
	lis 9,.LC18@ha
	la 31,.LC16@l(22)
	la 27,.LC18@l(9)
	b .L65
.L76:
	lis 9,.LC17@ha
	la 31,.LC15@l(20)
	la 27,.LC17@l(9)
.L65:
	lbz 0,0(27)
	lis 25,.LC22@ha
	cmpwi 0,0,0
	bc 12,2,.L78
	addi 3,1,8
	mr 8,27
	la 5,.LC22@l(25)
	li 4,64
	addi 6,23,-2
	addi 7,26,-2
	crxor 6,6,6
	bl Com_sprintf
	mr 3,24
	bl strlen
	mr 29,3
	addi 3,1,8
	bl strlen
	add 29,29,3
	cmplwi 0,29,1199
	bc 12,1,.L78
	mr 3,24
	addi 4,1,8
	bl strcat
.L78:
	cmpwi 0,21,0
	bc 4,0,.L80
	la 0,.LC13@l(17)
	addi 26,26,-5
	cmpw 0,31,0
	bc 4,2,.L81
	lis 9,.LC23@ha
	la 31,.LC23@l(9)
	b .L90
.L81:
	cmpw 0,31,14
	bc 4,2,.L83
	lis 9,.LC24@ha
	la 31,.LC24@l(9)
	b .L90
.L83:
	lis 9,.LC16@ha
	la 9,.LC16@l(9)
	cmpw 0,31,9
	bc 4,2,.L85
	lis 9,.LC25@ha
	la 31,.LC25@l(9)
	b .L90
.L85:
	lis 10,.LC20@ha
	la 10,.LC20@l(10)
	cmpw 0,31,10
	bc 4,2,.L87
	lis 9,.LC26@ha
	la 31,.LC26@l(9)
	b .L90
.L87:
	cmpw 0,31,15
	bc 4,2,.L90
	lis 9,.LC27@ha
	la 31,.LC27@l(9)
	b .L90
.L80:
	bc 4,1,.L90
	la 0,.LC13@l(17)
	cmpw 0,31,0
	bc 4,2,.L92
	lis 9,.LC28@ha
	la 31,.LC28@l(9)
	b .L90
.L92:
	cmpw 0,31,14
	bc 4,2,.L94
	lis 9,.LC29@ha
	la 31,.LC29@l(9)
	b .L90
.L94:
	lis 11,.LC16@ha
	la 11,.LC16@l(11)
	cmpw 0,31,11
	bc 4,2,.L96
	lis 9,.LC30@ha
	la 31,.LC30@l(9)
	b .L90
.L96:
	lis 9,.LC20@ha
	la 9,.LC20@l(9)
	cmpw 0,31,9
	bc 4,2,.L98
	lis 9,.LC31@ha
	la 31,.LC31@l(9)
	b .L90
.L98:
	cmpw 0,31,15
	bc 4,2,.L90
	lis 9,.LC32@ha
	la 31,.LC32@l(9)
.L90:
	addi 3,1,8
	la 5,.LC22@l(25)
	mr 6,23
	mr 7,26
	mr 8,31
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	mr 3,24
	bl strlen
	mr 29,3
	addi 3,1,8
	bl strlen
	add 29,29,3
	cmplwi 0,29,1199
	bc 12,1,.L29
	mr 3,24
	addi 4,1,8
	bl strcat
.L29:
	lis 9,globals@ha
	lis 10,g_edicts@ha
	la 11,globals@l(9)
	addi 30,30,1160
	lwz 0,72(11)
	lwz 9,g_edicts@l(10)
	mulli 0,0,1160
	add 9,9,0
	cmplw 0,30,9
	bc 12,0,.L30
.L17:
	lwz 0,260(1)
	mtlr 0
	lmw 14,152(1)
	lfd 28,224(1)
	lfd 29,232(1)
	lfd 30,240(1)
	lfd 31,248(1)
	la 1,256(1)
	blr
.Lfe2:
	.size	 ShowScanner,.Lfe2-ShowScanner
	.align 2
	.globl ClearScanner
	.type	 ClearScanner,@function
ClearScanner:
	li 0,0
	stw 0,1824(3)
	stw 0,1820(3)
	blr
.Lfe3:
	.size	 ClearScanner,.Lfe3-ClearScanner
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
