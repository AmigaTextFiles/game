	.file	"p_classes.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Morphine"
	.align 2
.LC1:
	.string	"Helmet"
	.align 2
.LC2:
	.string	"Fists"
	.align 2
.LC3:
	.string	"Knife"
	.align 2
.LC4:
	.string	"WARNING: in Give_Class_Weapon %s spawned with no ammo for %s -> %s\n"
	.align 2
.LC5:
	.string	"mauser98k_mag"
	.align 2
.LC6:
	.string	"Mauser 98k"
	.align 2
.LC7:
	.string	"Mauser 98ks"
	.align 2
.LC8:
	.string	"flame_mag"
	.align 2
.LC9:
	.string	"weapon1 item not found!\n"
	.align 2
.LC10:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Give_Class_Weapon
	.type	 Give_Class_Weapon,@function
Give_Class_Weapon:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 31,3
	lwz 30,84(31)
	lwz 0,3464(30)
	cmpwi 0,0,8
	bc 4,2,.L7
	lis 9,.LC10@ha
	lis 11,invuln_medic@ha
	la 9,.LC10@l(9)
	lfs 13,0(9)
	lwz 9,invuln_medic@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L7
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0xc4ec
	la 9,itemlist@l(9)
	ori 0,0,20165
	subf 3,9,3
	addi 11,30,740
	mullw 3,3,0
	li 9,1
	mr 25,11
	srawi 3,3,3
	slwi 3,3,2
	stwx 9,11,3
	b .L8
.L7:
	lis 3,.LC1@ha
	lis 28,0xc4ec
	la 3,.LC1@l(3)
	ori 28,28,20165
	bl FindItem
	addi 27,30,740
	li 26,1
	lis 29,itemlist@ha
	lis 9,.LC2@ha
	la 29,itemlist@l(29)
	mr 25,27
	subf 0,29,3
	mullw 0,0,28
	la 3,.LC2@l(9)
	srawi 0,0,3
	slwi 0,0,2
	stwx 26,27,0
	bl FindItem
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC3@ha
	la 3,.LC3@l(3)
	srawi 0,0,3
	slwi 0,0,2
	stwx 26,27,0
	bl FindItem
	subf 3,29,3
	mullw 3,3,28
	srawi 3,3,3
	slwi 3,3,2
	stwx 26,27,3
.L8:
	lwz 11,3448(30)
	lwz 9,3464(30)
	lwz 10,96(11)
	slwi 9,9,2
	lwzx 11,9,10
	lwz 3,8(11)
	bl FindItem
	mr 28,3
	lwz 3,52(28)
	bl FindItem
	mr. 29,3
	bc 4,2,.L9
	lis 9,gi+4@ha
	lwz 4,84(31)
	lis 3,.LC4@ha
	lwz 0,gi+4@l(9)
	la 3,.LC4@l(3)
	addi 4,4,700
	lwz 6,52(28)
	lwz 5,40(28)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L9:
	lwz 3,52(28)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L10
	lwz 3,40(28)
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L55
.L10:
	lwz 3,52(28)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L12
	lwz 3,40(28)
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L56
.L12:
	lis 27,team_list@ha
	lwz 3,88(28)
	la 9,team_list@l(27)
	lwz 4,4(9)
	addi 4,4,100
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L14
	lwz 0,68(28)
	cmpwi 0,0,3
	bc 4,2,.L15
	lwz 0,48(29)
	lwz 9,84(31)
	stw 0,4448(9)
	b .L11
.L15:
	cmpwi 0,0,5
	bc 4,2,.L17
	lwz 0,48(29)
	lwz 9,84(31)
	stw 0,4456(9)
	b .L11
.L17:
	cmpwi 0,0,6
	bc 4,2,.L19
	lwz 0,48(29)
	lwz 9,84(31)
	stw 0,4480(9)
	b .L11
.L19:
	cmpwi 0,0,7
	bc 4,2,.L21
	lwz 0,48(29)
	lwz 9,84(31)
	stw 0,4488(9)
	b .L11
.L21:
	cmpwi 0,0,9
	bc 4,2,.L23
	lwz 0,48(29)
	lwz 9,84(31)
	stw 0,4492(9)
	b .L11
.L23:
	cmpwi 0,0,4
	bc 4,2,.L25
.L55:
	lwz 0,48(29)
	lwz 9,84(31)
	stw 0,4464(9)
	b .L11
.L25:
	cmpwi 0,0,10
	bc 4,2,.L11
.L56:
	lwz 0,48(29)
	lwz 9,84(31)
	stw 0,4472(9)
	b .L11
.L14:
	lwz 4,team_list@l(27)
	lwz 3,88(28)
	addi 4,4,100
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L29
	lwz 0,68(28)
	cmpwi 0,0,3
	bc 4,2,.L30
	lwz 0,48(29)
	lwz 9,84(31)
	stw 0,4400(9)
	b .L11
.L30:
	cmpwi 0,0,4
	bc 4,2,.L32
	lwz 0,48(29)
	lwz 9,84(31)
	stw 0,4416(9)
	b .L11
.L32:
	cmpwi 7,0,10
	bc 12,30,.L57
	cmpwi 0,0,5
	bc 4,2,.L36
	lwz 0,48(29)
	lwz 9,84(31)
	stw 0,4408(9)
	b .L11
.L36:
	cmpwi 0,0,6
	bc 4,2,.L38
	lwz 0,48(29)
	lwz 9,84(31)
	stw 0,4432(9)
	b .L11
.L38:
	cmpwi 0,0,7
	bc 4,2,.L40
	lwz 0,48(29)
	lwz 9,84(31)
	stw 0,4440(9)
	b .L11
.L40:
	cmpwi 0,0,9
	bc 4,2,.L42
	lwz 0,48(29)
	lwz 9,84(31)
	stw 0,4444(9)
	b .L11
.L42:
	bc 4,30,.L11
.L57:
	lwz 0,48(29)
	lwz 9,84(31)
	stw 0,4424(9)
	b .L11
.L29:
	lwz 3,52(28)
	lis 4,.LC8@ha
	la 4,.LC8@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L11
	lwz 0,48(29)
	lwz 9,84(31)
	stw 0,4504(9)
.L11:
	cmpwi 0,28,0
	bc 4,2,.L47
	lis 9,gi+8@ha
	lis 5,.LC9@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC9@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L47:
	lis 9,itemlist@ha
	lis 29,0xc4ec
	stw 28,4148(30)
	la 27,itemlist@l(9)
	ori 29,29,20165
	subf 0,27,28
	li 26,1
	mullw 0,0,29
	srawi 0,0,3
	stw 0,736(30)
	slwi 9,0,2
	stwx 26,25,9
	lwz 11,3448(30)
	lwz 9,3464(30)
	lwz 10,96(11)
	slwi 9,9,2
	lwzx 11,9,10
	lwz 3,16(11)
	bl FindItem
	mr. 28,3
	bc 12,2,.L49
	subf 0,27,28
	mullw 0,0,29
	srawi 0,0,3
	slwi 0,0,2
	stwx 26,25,0
	bc 12,2,.L49
	lwz 3,52(28)
	bl FindItem
	lis 9,team_list+4@ha
	mr 29,3
	lwz 4,team_list+4@l(9)
	lwz 3,88(28)
	addi 4,4,100
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L50
	lwz 0,68(28)
	cmpwi 0,0,3
	bc 4,2,.L50
	lwz 0,48(29)
	lwz 9,84(31)
	stw 0,4448(9)
	b .L49
.L50:
	lis 9,team_list@ha
	lwz 3,88(28)
	lwz 4,team_list@l(9)
	addi 4,4,100
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L49
	lwz 0,68(28)
	cmpwi 0,0,3
	bc 4,2,.L49
	lwz 0,48(29)
	lwz 9,84(31)
	stw 0,4400(9)
.L49:
	lwz 11,3448(30)
	lwz 9,3464(30)
	lwz 10,96(11)
	slwi 9,9,2
	lwzx 11,9,10
	lwz 3,24(11)
	bl FindItem
	mr. 28,3
	bc 12,2,.L53
	lwz 10,3448(30)
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,3464(30)
	la 9,itemlist@l(9)
	ori 0,0,20165
	lwz 8,96(10)
	subf 9,9,28
	slwi 11,11,2
	mullw 9,9,0
	lwzx 10,11,8
	srawi 9,9,3
	lwz 0,28(10)
	slwi 9,9,2
	stwx 0,25,9
.L53:
	lwz 11,3448(30)
	lwz 9,3464(30)
	lwz 10,96(11)
	slwi 9,9,2
	lwzx 11,9,10
	lwz 3,32(11)
	bl FindItem
	mr. 28,3
	bc 12,2,.L54
	lwz 10,3448(30)
	lis 9,itemlist@ha
	lis 0,0xc4ec
	lwz 11,3464(30)
	la 9,itemlist@l(9)
	ori 0,0,20165
	lwz 8,96(10)
	subf 9,9,28
	slwi 11,11,2
	mullw 9,9,0
	lwzx 10,11,8
	srawi 9,9,3
	lwz 0,36(10)
	slwi 9,9,2
	stwx 0,25,9
.L54:
	mr 3,31
	bl ChangeWeapon
.L6:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 Give_Class_Weapon,.Lfe1-Give_Class_Weapon
	.align 2
	.globl Give_Class_Ammo
	.type	 Give_Class_Ammo,@function
Give_Class_Ammo:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 11,84(31)
	lwz 10,3448(11)
	lwz 9,3464(11)
	lwz 8,96(10)
	slwi 9,9,2
	lwzx 9,9,8
	lwz 0,12(9)
	cmpwi 0,0,0
	bc 12,2,.L59
	lwz 3,8(9)
	bl FindItem
	lwz 3,52(3)
	bl FindItem
	lwz 8,84(31)
	mr 4,3
	mr 3,31
	lwz 11,3448(8)
	lwz 9,3464(8)
	lwz 10,96(11)
	slwi 9,9,2
	lwzx 11,9,10
	lwz 5,12(11)
	bl Add_Ammo
.L59:
	lwz 11,84(31)
	lwz 10,3448(11)
	lwz 9,3464(11)
	lwz 8,96(10)
	slwi 9,9,2
	lwzx 9,9,8
	lwz 0,20(9)
	cmpwi 0,0,0
	bc 12,2,.L60
	lwz 3,16(9)
	bl FindItem
	lwz 3,52(3)
	bl FindItem
	lwz 8,84(31)
	mr 4,3
	mr 3,31
	lwz 11,3448(8)
	lwz 9,3464(8)
	lwz 10,96(11)
	slwi 9,9,2
	lwzx 11,9,10
	lwz 5,20(11)
	bl Add_Ammo
.L60:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 Give_Class_Ammo,.Lfe2-Give_Class_Ammo
	.section	".rodata"
	.align 2
.LC11:
	.string	"Must be on a team to view the open class slots.\n"
	.align 2
.LC12:
	.string	"\nOpen class slots for %s: \n"
	.align 2
.LC13:
	.string	" %10s -- unlimited\n"
	.align 2
.LC14:
	.string	" %10s -- %i\n"
	.section	".text"
	.align 2
	.globl Show_Mos
	.type	 Show_Mos,@function
Show_Mos:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 6,3448(9)
	cmpwi 0,6,0
	bc 12,2,.L63
	lwz 0,3464(9)
	cmpwi 0,0,0
	bc 4,2,.L62
.L63:
	lis 9,gi+8@ha
	lis 5,.LC11@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC11@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L61
.L62:
	lis 9,gi@ha
	lis 5,.LC12@ha
	lwz 6,0(6)
	la 9,gi@l(9)
	la 5,.LC12@l(5)
	lwz 0,8(9)
	mr 3,31
	li 4,2
	mr 28,9
	lis 26,.LC13@ha
	mtlr 0
	lis 27,.LC14@ha
	li 29,4
	li 30,9
	crxor 6,6,6
	blrl
.L67:
	lwz 9,84(31)
	lwz 11,3448(9)
	lwz 10,96(11)
	lwzx 6,29,10
	lwz 7,44(6)
	cmpwi 0,7,99
	bc 4,2,.L68
	lwz 9,8(28)
	mr 3,31
	li 4,2
	lwz 6,0(6)
	la 5,.LC13@l(26)
	mtlr 9
	crxor 6,6,6
	blrl
	b .L66
.L68:
	lwz 9,8(28)
	mr 3,31
	li 4,2
	lwz 6,0(6)
	la 5,.LC14@l(27)
	mtlr 9
	crxor 6,6,6
	blrl
.L66:
	addic. 30,30,-1
	addi 29,29,4
	bc 4,2,.L67
.L61:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 Show_Mos,.Lfe3-Show_Mos
	.align 2
	.globl InitMOS_List
	.type	 InitMOS_List,@function
InitMOS_List:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 29,3
	la 9,gi@l(9)
	mr 26,4
	lwz 0,132(9)
	li 3,680
	li 4,766
	mr 27,9
	addi 30,26,68
	mtlr 0
	li 28,4
	blrl
	mr 31,3
	li 0,0
	stw 31,96(29)
	stw 0,0(31)
.L75:
	lwz 9,132(27)
	li 4,766
	li 3,68
	mtlr 9
	blrl
	stwx 3,28,31
	li 4,766
	lwz 9,132(27)
	li 3,15
	mtlr 9
	blrl
	lwzx 9,28,31
	li 4,766
	stw 3,0(9)
	lwz 9,132(27)
	li 3,15
	mtlr 9
	blrl
	lwzx 9,28,31
	li 4,766
	stw 3,8(9)
	lwz 9,132(27)
	li 3,15
	mtlr 9
	blrl
	lwzx 9,28,31
	li 4,766
	stw 3,16(9)
	lwz 9,132(27)
	li 3,15
	mtlr 9
	blrl
	lwzx 9,28,31
	li 4,766
	stw 3,24(9)
	lwz 9,132(27)
	li 3,15
	mtlr 9
	blrl
	lwzx 9,28,31
	li 4,766
	stw 3,32(9)
	lwz 9,132(27)
	li 3,4
	mtlr 9
	blrl
	lwzx 9,28,31
	stw 3,64(9)
	lwzx 11,28,31
	lwz 4,0(30)
	lwz 3,0(11)
	bl strcpy
	lwz 4,8(30)
	cmpwi 0,4,0
	bc 12,2,.L76
	lwzx 9,28,31
	lwz 3,8(9)
	bl strcpy
.L76:
	lwzx 9,28,31
	lwz 0,12(30)
	stw 0,12(9)
	lwz 4,16(30)
	cmpwi 0,4,0
	bc 12,2,.L77
	lwzx 9,28,31
	lwz 3,16(9)
	bl strcpy
.L77:
	lwzx 9,28,31
	lwz 0,20(30)
	stw 0,20(9)
	lwz 4,24(30)
	cmpwi 0,4,0
	bc 12,2,.L78
	lwzx 9,28,31
	lwz 3,24(9)
	bl strcpy
.L78:
	lwzx 9,28,31
	lwz 0,28(30)
	stw 0,28(9)
	lwz 4,32(30)
	cmpwi 0,4,0
	bc 12,2,.L79
	lwzx 9,28,31
	lwz 3,32(9)
	bl strcpy
.L79:
	lwzx 11,28,31
	addi 8,26,612
	lwz 0,36(30)
	stw 0,36(11)
	lwzx 9,28,31
	lwz 0,40(30)
	stw 0,40(9)
	lwzx 11,28,31
	lwz 0,44(30)
	stw 0,44(11)
	lfs 0,48(30)
	lwzx 9,28,31
	stfs 0,48(9)
	lfs 0,52(30)
	lwzx 11,28,31
	stfs 0,52(11)
	lfs 0,56(30)
	lwzx 9,28,31
	stfs 0,56(9)
	lwzx 11,28,31
	lwz 0,64(30)
	stw 0,64(11)
	lwz 10,4(30)
	addi 30,30,68
	lwzx 9,28,31
	cmpw 0,30,8
	addi 28,28,4
	stw 10,4(9)
	bc 4,1,.L75
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 InitMOS_List,.Lfe4-InitMOS_List
	.comm	is_silenced,1,1
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
