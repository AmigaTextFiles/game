	.file	"g_cmds.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Airstrike Marker"
	.align 2
.LC1:
	.string	"blue key"
	.align 2
.LC2:
	.string	"Commander's Head"
	.align 2
.LC3:
	.string	"Red Key"
	.align 2
.LC4:
	.string	"Security Pass"
	.align 2
.LC5:
	.string	"Data Spinner"
	.align 2
.LC6:
	.string	"Pyramid Key"
	.align 2
.LC7:
	.string	"Power Cube"
	.align 2
.LC8:
	.string	"Data CD"
	.align 2
.LC9:
	.string	"No key to drop\n"
	.section	".text"
	.align 2
	.globl Cmd_Drop_Key_f
	.type	 Cmd_Drop_Key_f,@function
Cmd_Drop_Key_f:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 31,3
	lis 27,.LC0@ha
	lwz 29,84(31)
	la 3,.LC0@l(27)
	lis 30,0x286b
	bl FindItem
	ori 30,30,51739
	lis 9,itemlist@ha
	addi 29,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 28,29,3
	cmpwi 0,28,0
	bc 12,2,.L7
	lwz 9,84(31)
	li 0,0
	la 3,.LC0@l(27)
	stw 0,4032(9)
	b .L25
.L7:
	lis 25,.LC1@ha
	lwz 29,84(31)
	la 3,.LC1@l(25)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 27,29,3
	cmpwi 0,27,0
	bc 12,2,.L9
	lwz 9,84(31)
	la 3,.LC1@l(25)
	stw 28,4032(9)
	b .L25
.L9:
	lis 25,.LC2@ha
	lwz 29,84(31)
	la 3,.LC2@l(25)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 28,29,3
	cmpwi 0,28,0
	bc 12,2,.L11
	lwz 9,84(31)
	la 3,.LC2@l(25)
	b .L26
.L11:
	lis 25,.LC3@ha
	lwz 29,84(31)
	la 3,.LC3@l(25)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 27,29,3
	cmpwi 0,27,0
	bc 12,2,.L13
	lwz 9,84(31)
	la 3,.LC3@l(25)
	stw 28,4032(9)
	b .L25
.L13:
	lis 25,.LC4@ha
	lwz 29,84(31)
	la 3,.LC4@l(25)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 28,29,3
	cmpwi 0,28,0
	bc 12,2,.L15
	lwz 9,84(31)
	la 3,.LC4@l(25)
	b .L26
.L15:
	lis 25,.LC5@ha
	lwz 29,84(31)
	la 3,.LC5@l(25)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 27,29,3
	cmpwi 0,27,0
	bc 12,2,.L17
	lwz 9,84(31)
	la 3,.LC5@l(25)
	stw 28,4032(9)
	b .L25
.L17:
	lis 25,.LC6@ha
	lwz 29,84(31)
	la 3,.LC6@l(25)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 28,29,3
	cmpwi 0,28,0
	bc 12,2,.L19
	lwz 9,84(31)
	la 3,.LC6@l(25)
	b .L26
.L19:
	lis 25,.LC7@ha
	lwz 29,84(31)
	la 3,.LC7@l(25)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 27,29,3
	cmpwi 0,27,0
	bc 12,2,.L21
	lwz 9,84(31)
	la 3,.LC7@l(25)
	stw 28,4032(9)
	b .L25
.L21:
	lis 28,.LC8@ha
	lwz 29,84(31)
	la 3,.LC8@l(28)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 30,29,3
	cmpwi 0,30,0
	bc 12,2,.L23
	lwz 9,84(31)
	la 3,.LC8@l(28)
.L26:
	stw 27,4032(9)
.L25:
	bl FindItem
	mr 4,3
	mr 3,31
	bl Drop_General
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,2
	stw 9,4008(11)
	b .L8
.L23:
	lis 9,gi+8@ha
	lis 5,.LC9@ha
	lwz 0,gi+8@l(9)
	la 5,.LC9@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	stw 30,4032(9)
.L8:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 Cmd_Drop_Key_f,.Lfe1-Cmd_Drop_Key_f
	.section	".rodata"
	.align 2
.LC10:
	.string	"UZI"
	.align 2
.LC11:
	.string	"MARINER"
	.align 2
.LC12:
	.string	"mariner"
	.align 2
.LC13:
	.string	"AK 47"
	.align 2
.LC14:
	.string	"ak 47"
	.align 2
.LC15:
	.string	"BARRETT"
	.align 2
.LC16:
	.string	"barrett"
	.align 2
.LC17:
	.string	"glock"
	.align 2
.LC18:
	.string	"casull"
	.align 2
.LC19:
	.string	"beretta"
	.section	".text"
	.align 2
	.type	 Cmd_UseSpecial_f,@function
Cmd_UseSpecial_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lis 30,.LC10@ha
	lwz 29,84(31)
	la 3,.LC10@l(30)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L28
	lwz 29,84(31)
	la 3,.LC10@l(30)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 12,2,.L28
	la 3,.LC10@l(30)
	b .L41
.L28:
	lis 30,.LC11@ha
	lwz 29,84(31)
	la 3,.LC11@l(30)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L30
	lis 3,.LC12@ha
	lwz 29,84(31)
	la 3,.LC12@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 12,2,.L30
	la 3,.LC11@l(30)
	b .L41
.L30:
	lis 30,.LC13@ha
	lwz 29,84(31)
	la 3,.LC13@l(30)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L32
	lis 3,.LC14@ha
	lwz 29,84(31)
	la 3,.LC14@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 12,2,.L32
	la 3,.LC13@l(30)
	b .L41
.L32:
	lis 30,.LC15@ha
	lwz 29,84(31)
	la 3,.LC15@l(30)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L34
	lis 3,.LC16@ha
	lwz 29,84(31)
	la 3,.LC16@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 12,2,.L34
	la 3,.LC15@l(30)
	b .L41
.L34:
	lis 30,.LC17@ha
	lwz 29,84(31)
	la 3,.LC17@l(30)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L36
	lwz 29,84(31)
	la 3,.LC17@l(30)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 12,2,.L36
	la 3,.LC17@l(30)
	b .L41
.L36:
	lis 30,.LC18@ha
	lwz 29,84(31)
	la 3,.LC18@l(30)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L38
	lwz 29,84(31)
	la 3,.LC18@l(30)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 12,2,.L38
	la 3,.LC18@l(30)
	b .L41
.L38:
	lis 30,.LC19@ha
	lwz 29,84(31)
	la 3,.LC19@l(30)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L29
	lwz 29,84(31)
	la 3,.LC19@l(30)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 12,2,.L29
	la 3,.LC19@l(30)
.L41:
	bl FindItem
	lwz 9,84(31)
	stw 3,3660(9)
.L29:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Cmd_UseSpecial_f,.Lfe2-Cmd_UseSpecial_f
	.section	".rodata"
	.align 2
.LC20:
	.string	"Can`t place C4 here\n"
	.align 2
.LC21:
	.string	"C4 placed\n"
	.align 2
.LC22:
	.string	"models/slat/world_c4/world_c4.md2"
	.align 2
.LC23:
	.string	"c4"
	.align 2
.LC24:
	.long 0x42480000
	.align 3
.LC25:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC26:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl Cmd_PlaceC4_f
	.type	 Cmd_PlaceC4_f,@function
Cmd_PlaceC4_f:
	stwu 1,-128(1)
	mflr 0
	stmw 29,116(1)
	stw 0,132(1)
	mr 29,3
	addi 4,1,24
	lfs 12,4(29)
	li 5,0
	li 6,0
	lfs 0,8(29)
	lfs 13,12(29)
	lwz 3,84(29)
	stfs 12,8(1)
	stfs 0,12(1)
	addi 3,3,3764
	stfs 13,16(1)
	bl AngleVectors
	lis 11,.LC24@ha
	mr 4,29
	lfs 10,24(1)
	la 11,.LC24@l(11)
	lfsu 0,4(4)
	lis 9,gi@ha
	lfs 11,0(11)
	la 31,gi@l(9)
	addi 3,1,40
	lfs 13,12(29)
	li 9,3
	li 5,0
	lfs 9,8(29)
	li 6,0
	addi 7,1,8
	fmadds 10,10,11,0
	lfs 12,28(1)
	mr 8,29
	lfs 0,32(1)
	lwz 11,48(31)
	fmadds 12,12,11,9
	stfs 10,8(1)
	fmadds 0,0,11,13
	mtlr 11
	stfs 12,12(1)
	stfs 0,16(1)
	blrl
	lfs 0,48(1)
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L43
	lwz 0,8(31)
	lis 5,.LC20@ha
	mr 3,29
	la 5,.LC20@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L42
.L43:
	lwz 9,8(31)
	lis 5,.LC21@ha
	mr 3,29
	la 5,.LC21@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	bl G_Spawn
	lfs 13,52(1)
	mr 29,3
	addi 3,1,64
	addi 4,29,16
	stfs 13,4(29)
	lfs 0,56(1)
	stfs 0,8(29)
	lfs 13,60(1)
	stfs 13,12(29)
	bl vectoangles
	lwz 9,32(31)
	lis 3,.LC22@ha
	la 3,.LC22@l(3)
	mtlr 9
	blrl
	lis 9,.LC26@ha
	stw 3,40(29)
	lis 11,level+4@ha
	la 9,.LC26@l(9)
	lfs 0,level+4@l(11)
	mr 3,29
	lfs 13,0(9)
	lis 11,.LC23@ha
	lis 9,G_FreeEdict@ha
	la 11,.LC23@l(11)
	la 9,G_FreeEdict@l(9)
	stw 11,280(29)
	fadds 0,0,13
	stw 9,436(29)
	stfs 0,428(29)
	lwz 0,72(31)
	mtlr 0
	blrl
.L42:
	lwz 0,132(1)
	mtlr 0
	lmw 29,116(1)
	la 1,128(1)
	blr
.Lfe3:
	.size	 Cmd_PlaceC4_f,.Lfe3-Cmd_PlaceC4_f
	.section	".rodata"
	.align 2
.LC27:
	.string	"IR Goggles"
	.align 2
.LC28:
	.string	"IR goggles"
	.align 2
.LC29:
	.string	"Helmet"
	.align 2
.LC30:
	.string	"Bullet Proof Vest"
	.align 2
.LC31:
	.string	"MedKit"
	.align 2
.LC32:
	.string	"Scuba Gear"
	.align 2
.LC33:
	.string	"Head Light"
	.align 2
.LC34:
	.string	"No special item to drop\n"
	.section	".text"
	.align 2
	.globl Cmd_Drop_Item_f
	.type	 Cmd_Drop_Item_f,@function
Cmd_Drop_Item_f:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L44
	lis 3,.LC27@ha
	lwz 29,84(31)
	lis 30,0x286b
	la 3,.LC27@l(3)
	ori 30,30,51739
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 28,29,3
	cmpwi 0,28,0
	bc 12,2,.L46
	lwz 9,84(31)
	li 0,0
	lis 3,.LC28@ha
	la 3,.LC28@l(3)
	stw 0,4032(9)
	b .L58
.L46:
	lis 25,.LC29@ha
	lwz 29,84(31)
	la 3,.LC29@l(25)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 27,29,3
	cmpwi 0,27,0
	bc 12,2,.L48
	lwz 9,84(31)
	la 3,.LC29@l(25)
	b .L59
.L48:
	lis 25,.LC30@ha
	lwz 29,84(31)
	la 3,.LC30@l(25)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 28,29,3
	cmpwi 0,28,0
	bc 12,2,.L50
	lwz 9,84(31)
	la 3,.LC30@l(25)
	stw 27,4032(9)
	b .L58
.L50:
	lis 25,.LC31@ha
	lwz 29,84(31)
	la 3,.LC31@l(25)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 27,29,3
	cmpwi 0,27,0
	bc 12,2,.L52
	lwz 9,84(31)
	la 3,.LC31@l(25)
	b .L59
.L52:
	lis 25,.LC32@ha
	lwz 29,84(31)
	la 3,.LC32@l(25)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 28,29,3
	cmpwi 0,28,0
	bc 12,2,.L54
	lwz 9,84(31)
	la 3,.LC32@l(25)
	stw 27,4032(9)
	b .L58
.L54:
	lis 27,.LC33@ha
	lwz 29,84(31)
	la 3,.LC33@l(27)
	bl FindItem
	subf 3,26,3
	addi 29,29,740
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 30,29,3
	cmpwi 0,30,0
	bc 12,2,.L56
	lwz 9,84(31)
	la 3,.LC33@l(27)
.L59:
	stw 28,4032(9)
.L58:
	bl FindItem
	mr 4,3
	mr 3,31
	bl Drop_SpecialItem
	b .L44
.L56:
	lis 9,gi+8@ha
	lis 5,.LC34@ha
	lwz 0,gi+8@l(9)
	la 5,.LC34@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	stw 30,4032(9)
.L44:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 Cmd_Drop_Item_f,.Lfe4-Cmd_Drop_Item_f
	.section	".rodata"
	.align 2
.LC35:
	.string	"Bandaging...\n"
	.align 2
.LC36:
	.string	"msg90"
	.section	".text"
	.align 2
	.type	 Cmd_Bandage_f,@function
Cmd_Bandage_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L61
	lwz 9,84(31)
	lwz 29,4040(9)
	cmpwi 0,29,0
	bc 4,2,.L61
	lwz 0,4044(9)
	cmpwi 0,0,1
	bc 12,2,.L65
	lwz 0,4020(9)
	cmpwi 0,0,1
	bc 4,2,.L64
.L65:
	lis 9,gi+8@ha
	lis 5,.LC35@ha
	lwz 0,gi+8@l(9)
	la 5,.LC35@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,6
	li 10,1
	lis 8,0x42b4
	stw 0,3696(11)
	lwz 9,84(31)
	stw 10,4040(9)
	lwz 11,84(31)
	stw 8,112(11)
	lwz 30,84(31)
	lwz 0,4036(30)
	cmpwi 0,0,0
	bc 12,2,.L66
	lis 3,.LC36@ha
	la 3,.LC36@l(3)
	bl FindItem
	lwz 0,1824(30)
	cmpw 0,0,3
	bc 4,2,.L66
	lwz 9,84(31)
	lwz 0,116(9)
	rlwinm 0,0,0,30,28
	stw 0,116(9)
	lwz 11,84(31)
	stw 29,4028(11)
.L66:
	lwz 9,84(31)
	li 0,0
	lis 10,gi+32@ha
	stw 0,4036(9)
	lwz 11,84(31)
	lwz 0,gi+32@l(10)
	lwz 9,1824(11)
	mtlr 0
	lwz 3,32(9)
	blrl
	lwz 9,84(31)
	stw 3,88(9)
	b .L61
.L64:
	stw 29,4040(9)
.L61:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 Cmd_Bandage_f,.Lfe5-Cmd_Bandage_f
	.section	".rodata"
	.align 2
.LC37:
	.string	"grenades"
	.align 2
.LC38:
	.string	"Throw grenade short range\n"
	.align 2
.LC39:
	.string	"Throw grenade long range\n"
	.align 2
.LC40:
	.string	"Throw grenade medium range\n"
	.align 2
.LC41:
	.string	"slat/weapons/barrett_scope.wav"
	.align 2
.LC42:
	.long 0x3f800000
	.align 2
.LC43:
	.long 0x0
	.section	".text"
	.align 2
	.type	 Cmd_Zoom_f,@function
Cmd_Zoom_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 29,84(31)
	cmpwi 0,29,0
	bc 12,2,.L68
	lis 3,.LC15@ha
	la 3,.LC15@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L70
	lwz 9,84(31)
	lwz 8,4040(9)
	cmpwi 0,8,0
	bc 4,2,.L70
	lwz 0,4036(9)
	cmpwi 0,0,4
	bc 4,2,.L71
	stw 8,4036(9)
	lis 0,0x42b4
	lis 10,gi+32@ha
	lwz 9,84(31)
	stw 0,112(9)
	lwz 11,84(31)
	lwz 0,gi+32@l(10)
	lwz 9,1824(11)
	mtlr 0
	lwz 3,32(9)
	blrl
	lwz 9,84(31)
	stw 3,88(9)
	b .L70
.L71:
	cmpwi 0,0,3
	bc 4,2,.L73
	li 0,4
	lis 10,0x40e0
	b .L94
.L73:
	cmpwi 0,0,2
	bc 4,2,.L75
	li 0,3
	lis 10,0x4170
	b .L94
.L75:
	cmpwi 0,0,1
	bc 4,2,.L77
	li 0,2
	lis 10,0x41f0
	b .L94
.L77:
	li 0,1
	lis 10,0x4270
.L94:
	stw 0,4036(9)
	lwz 9,84(31)
	stw 10,112(9)
	lwz 11,84(31)
	stw 8,88(11)
.L70:
	lis 3,.LC17@ha
	lwz 29,84(31)
	la 3,.LC17@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L79
	lwz 9,84(31)
	lwz 30,4040(9)
	cmpwi 0,30,0
	bc 4,2,.L79
	lwz 0,4052(9)
	cmpwi 0,0,0
	bc 4,2,.L80
	mr 3,31
	bl SP_LaserSight
	lwz 9,84(31)
	li 0,1
	stw 0,4052(9)
	b .L79
.L80:
	cmpwi 0,0,1
	bc 4,2,.L79
	mr 3,31
	bl SP_LaserSight
	lwz 9,84(31)
	stw 30,4052(9)
.L79:
	lis 3,.LC37@ha
	lwz 29,84(31)
	la 3,.LC37@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L83
	lwz 9,84(31)
	lwz 30,4040(9)
	cmpwi 0,30,0
	bc 4,2,.L83
	lwz 0,4004(9)
	cmpwi 0,0,2
	bc 4,2,.L84
	lis 9,gi+8@ha
	lis 5,.LC38@ha
	lwz 0,gi+8@l(9)
	la 5,.LC38@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	stw 30,4004(9)
	b .L83
.L84:
	cmpwi 0,0,1
	bc 4,2,.L86
	lis 9,gi+8@ha
	lis 5,.LC39@ha
	lwz 0,gi+8@l(9)
	la 5,.LC39@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,2
	b .L95
.L86:
	cmpwi 0,0,0
	bc 4,2,.L83
	lis 9,gi+8@ha
	lis 5,.LC40@ha
	lwz 0,gi+8@l(9)
	la 5,.LC40@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,1
.L95:
	stw 0,4004(9)
.L83:
	lis 3,.LC36@ha
	lwz 29,84(31)
	la 3,.LC36@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L68
	lwz 9,84(31)
	lwz 28,4040(9)
	cmpwi 0,28,0
	bc 4,2,.L68
	lwz 30,4036(9)
	cmpwi 0,30,1
	bc 4,2,.L90
	stw 28,4036(9)
	lis 0,0x42b4
	lis 29,gi@ha
	lwz 9,84(31)
	la 29,gi@l(29)
	lis 3,.LC41@ha
	la 3,.LC41@l(3)
	stw 0,112(9)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC42@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC42@l(9)
	li 4,1
	lfs 1,0(9)
	mtlr 11
	mr 3,31
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 2,0(9)
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 3,0(9)
	blrl
	lwz 11,84(31)
	lwz 0,32(29)
	lwz 9,1824(11)
	mtlr 0
	lwz 3,32(9)
	blrl
	lwz 9,84(31)
	stw 3,88(9)
	lwz 11,84(31)
	stw 28,4028(11)
	lwz 9,84(31)
	lwz 0,116(9)
	rlwinm 0,0,0,30,28
	b .L96
.L90:
	cmpwi 0,30,0
	bc 4,2,.L68
	li 28,1
	lis 0,0x420c
	stw 28,4036(9)
	lis 29,gi@ha
	lis 3,.LC41@ha
	lwz 9,84(31)
	la 29,gi@l(29)
	la 3,.LC41@l(3)
	stw 0,112(9)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC42@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC42@l(9)
	li 4,1
	lfs 1,0(9)
	mtlr 0
	mr 3,31
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 2,0(9)
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,84(31)
	stw 30,88(9)
	lwz 11,84(31)
	stw 28,4028(11)
	lwz 9,84(31)
	lwz 0,116(9)
	ori 0,0,4
.L96:
	stw 0,116(9)
.L68:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 Cmd_Zoom_f,.Lfe6-Cmd_Zoom_f
	.align 2
	.type	 Cmd_InfraRed_f,@function
Cmd_InfraRed_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 29,84(31)
	lwz 0,4028(29)
	cmpwi 0,0,0
	bc 12,2,.L98
	lis 3,.LC28@ha
	la 3,.LC28@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	mullw 3,3,0
	addi 9,29,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	cmpwi 0,0,0
	bc 12,2,.L98
	lis 3,.LC36@ha
	lwz 29,84(31)
	la 3,.LC36@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L99
	lwz 9,84(31)
	lwz 0,4036(9)
	cmpwi 0,0,0
	bc 4,2,.L97
.L99:
	lwz 9,84(31)
	li 0,0
	stw 0,4028(9)
	lwz 11,84(31)
	lwz 0,116(11)
	rlwinm 0,0,0,30,28
	b .L106
.L98:
	lis 3,.LC28@ha
	lwz 29,84(31)
	la 3,.LC28@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L100
	lis 3,.LC36@ha
	lwz 29,84(31)
	la 3,.LC36@l(3)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L102
	lwz 9,84(31)
	lwz 0,4036(9)
	cmpwi 0,0,0
	bc 4,2,.L97
.L102:
	lwz 9,84(31)
	li 0,1
	stw 0,4028(9)
	lwz 11,84(31)
	lwz 0,116(11)
	ori 0,0,4
.L106:
	stw 0,116(11)
.L100:
	lwz 29,84(31)
	lwz 0,4048(29)
	cmpwi 0,0,0
	bc 4,2,.L103
	lis 3,.LC33@ha
	la 3,.LC33@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,11,3
	cmpwi 0,0,0
	bc 12,2,.L103
	mr 3,31
	bl SP_FlashLight
	lwz 9,84(31)
	li 0,1
	b .L107
.L103:
	lwz 9,84(31)
	lwz 0,4048(9)
	cmpwi 0,0,1
	bc 4,2,.L97
	mr 3,31
	bl SP_FlashLight
	lwz 9,84(31)
	li 0,0
.L107:
	stw 0,4048(9)
.L97:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 Cmd_InfraRed_f,.Lfe7-Cmd_InfraRed_f
	.section	".rodata"
	.align 2
.LC44:
	.string	"grenade"
	.align 2
.LC45:
	.string	"weapons/grenlb1b.wav"
	.lcomm	value.36,512,4
	.align 2
.LC47:
	.string	"skin"
	.section	".text"
	.align 2
	.globl OnSameTeam
	.type	 OnSameTeam,@function
OnSameTeam:
	stwu 1,-1072(1)
	mflr 0
	stmw 27,1052(1)
	stw 0,1076(1)
	lis 11,dmflags@ha
	lwz 10,dmflags@l(11)
	mr 28,4
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 9,1044(1)
	andi. 0,9,192
	bc 4,2,.L120
	li 3,0
	b .L130
.L120:
	lis 9,value.36@ha
	li 30,0
	stb 30,value.36@l(9)
	la 31,value.36@l(9)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L132
	lis 4,.LC47@ha
	addi 3,3,188
	la 4,.LC47@l(4)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl strcpy
	mr 3,31
	li 4,47
	bl strchr
	mr. 3,3
	bc 12,2,.L132
	lis 9,dmflags@ha
	lwz 11,dmflags@l(9)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 9,1044(1)
	andi. 0,9,128
	bc 12,2,.L124
	stb 30,0(3)
.L132:
	mr 3,31
	b .L122
.L124:
	addi 3,3,1
.L122:
	mr 4,3
	li 29,0
	addi 3,1,8
	bl strcpy
	lis 9,value.36@ha
	addi 30,1,520
	stb 29,value.36@l(9)
	mr 27,30
	la 31,value.36@l(9)
	lwz 3,84(28)
	cmpwi 0,3,0
	bc 12,2,.L134
	lis 4,.LC47@ha
	addi 3,3,188
	la 4,.LC47@l(4)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl strcpy
	mr 3,31
	li 4,47
	bl strchr
	mr. 3,3
	bc 12,2,.L134
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 11,1044(1)
	andi. 0,11,128
	bc 12,2,.L128
	stb 29,0(3)
.L134:
	mr 3,31
	b .L126
.L128:
	addi 3,3,1
.L126:
	mr 4,3
	mr 3,30
	bl strcpy
	mr 4,27
	addi 3,1,8
	bl strcmp
	subfic 0,3,0
	adde 3,0,3
.L130:
	lwz 0,1076(1)
	mtlr 0
	lmw 27,1052(1)
	la 1,1072(1)
	blr
.Lfe8:
	.size	 OnSameTeam,.Lfe8-OnSameTeam
	.section	".rodata"
	.align 2
.LC48:
	.string	"m60ammo"
	.align 2
.LC49:
	.string	"You must run the server with '+set cheats 1' to enable this command.\n"
	.align 2
.LC50:
	.string	"all"
	.align 2
.LC51:
	.string	"health"
	.align 2
.LC52:
	.string	"weapons"
	.align 2
.LC53:
	.string	"ammo"
	.align 2
.LC54:
	.string	"armor"
	.align 2
.LC55:
	.string	"Jacket Armor"
	.align 2
.LC56:
	.string	"Combat Armor"
	.align 2
.LC57:
	.string	"Body Armor"
	.align 2
.LC58:
	.string	"Power Shield"
	.align 2
.LC59:
	.string	"unknown item\n"
	.align 2
.LC60:
	.string	"non-pickup item\n"
	.align 2
.LC61:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Give_f
	.type	 Cmd_Give_f,@function
Cmd_Give_f:
	stwu 1,-48(1)
	mflr 0
	mfcr 12
	stmw 26,24(1)
	stw 0,52(1)
	stw 12,20(1)
	lis 9,deathmatch@ha
	lis 10,.LC61@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC61@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L187
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L187
	lis 9,gi+8@ha
	lis 5,.LC49@ha
	lwz 0,gi+8@l(9)
	la 5,.LC49@l(5)
	b .L238
.L187:
	lis 9,gi@ha
	la 28,gi@l(9)
	lwz 9,164(28)
	mtlr 9
	blrl
	mr 30,3
	lis 4,.LC50@ha
	la 4,.LC50@l(4)
	bl Q_stricmp
	subfic 0,3,0
	adde. 27,0,3
	mfcr 29
	bc 4,2,.L191
	lwz 9,160(28)
	li 3,1
	rlwinm 29,29,16,0xffffffff
	mtcrf 8,29
	rlwinm 29,29,16,0xffffffff
	mtlr 9
	blrl
	lis 4,.LC51@ha
	la 4,.LC51@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L190
.L191:
	lwz 9,156(28)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L192
	lwz 0,160(28)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	stw 3,480(31)
	b .L193
.L192:
	lwz 0,484(31)
	stw 0,480(31)
.L193:
	cmpwi 4,27,0
	bc 12,18,.L186
.L190:
	bc 4,18,.L196
	lis 4,.LC52@ha
	mr 3,30
	la 4,.LC52@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L195
.L196:
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L198
	lis 9,itemlist@ha
	mr 7,11
	la 8,itemlist@l(9)
	li 10,0
.L200:
	mr 27,8
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L199
	lwz 0,56(27)
	andi. 9,0,1
	bc 12,2,.L199
	lwz 11,84(31)
	addi 11,11,740
	lwzx 9,11,10
	addi 9,9,1
	stwx 9,11,10
.L199:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 8,8,76
	cmpw 0,29,0
	bc 12,0,.L200
.L198:
	bc 12,18,.L186
.L195:
	bc 4,18,.L206
	lis 4,.LC53@ha
	mr 3,30
	la 4,.LC53@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L205
.L206:
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L208
	lis 9,itemlist@ha
	mr 26,11
	la 28,itemlist@l(9)
.L210:
	mr 27,28
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L209
	lwz 0,56(27)
	andi. 9,0,2
	bc 12,2,.L209
	mr 4,27
	mr 3,31
	li 5,1000
	bl Add_Ammo
.L209:
	lwz 0,1556(26)
	addi 29,29,1
	addi 28,28,76
	cmpw 0,29,0
	bc 12,0,.L210
.L208:
	bc 12,18,.L186
.L205:
	bc 4,18,.L216
	lis 4,.LC54@ha
	mr 3,30
	la 4,.LC54@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L215
.L216:
	lis 3,.LC55@ha
	lis 28,0x286b
	la 3,.LC55@l(3)
	ori 28,28,51739
	bl FindItem
	li 27,0
	lis 29,itemlist@ha
	lwz 9,84(31)
	lis 11,.LC56@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	addi 9,9,740
	mullw 0,0,28
	la 3,.LC56@l(11)
	rlwinm 0,0,0,0,29
	stwx 27,9,0
	bl FindItem
	subf 0,29,3
	lwz 9,84(31)
	mullw 0,0,28
	lis 3,.LC57@ha
	addi 9,9,740
	la 3,.LC57@l(3)
	rlwinm 0,0,0,0,29
	stwx 27,9,0
	bl FindItem
	mr 27,3
	lwz 9,84(31)
	lwz 11,64(27)
	subf 29,29,27
	mullw 29,29,28
	addi 9,9,740
	lwz 0,4(11)
	rlwinm 29,29,0,0,29
	stwx 0,9,29
	bc 12,18,.L186
.L215:
	bc 4,18,.L219
	lis 4,.LC58@ha
	mr 3,30
	la 4,.LC58@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L218
.L219:
	lis 3,.LC58@ha
	la 3,.LC58@l(3)
	bl FindItem
	mr 27,3
	bl G_Spawn
	lwz 0,0(27)
	mr 29,3
	mr 4,27
	stw 0,280(29)
	bl SpawnItem
	mr 3,29
	mr 4,31
	li 5,0
	li 6,0
	bl Touch_Item
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L220
	mr 3,29
	bl G_FreeEdict
.L220:
	bc 12,18,.L186
.L218:
	bc 12,18,.L222
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L186
	lis 9,itemlist@ha
	mr 7,11
	la 11,itemlist@l(9)
	li 8,1
	li 10,0
.L226:
	lwz 0,4(11)
	cmpwi 0,0,0
	bc 12,2,.L225
	lwz 0,56(11)
	andi. 9,0,7
	bc 4,2,.L225
	lwz 9,84(31)
	addi 9,9,740
	stwx 8,9,10
.L225:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 11,11,76
	cmpw 0,29,0
	bc 12,0,.L226
	b .L186
.L222:
	mr 3,30
	bl FindItem
	mr. 27,3
	bc 4,2,.L230
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,160(29)
	mtlr 9
	blrl
	bl FindItem
	mr. 27,3
	bc 4,2,.L230
	lwz 0,8(29)
	lis 5,.LC59@ha
	mr 3,31
	la 5,.LC59@l(5)
	b .L238
.L230:
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 4,2,.L232
	lis 9,gi+8@ha
	lis 5,.LC60@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC60@l(5)
.L238:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L186
.L232:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,56(27)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,27
	andi. 10,11,2
	mullw 9,9,0
	srawi 28,9,2
	bc 12,2,.L233
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L234
	lwz 0,160(29)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(31)
	slwi 0,28,2
	addi 9,9,740
	stwx 3,9,0
	b .L186
.L234:
	lwz 9,84(31)
	slwi 10,28,2
	lwz 11,48(27)
	addi 9,9,740
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
	b .L186
.L233:
	bl G_Spawn
	lwz 0,0(27)
	mr 29,3
	mr 4,27
	stw 0,280(29)
	bl SpawnItem
	mr 4,31
	mr 3,29
	li 5,0
	li 6,0
	bl Touch_Item
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L186
	mr 3,29
	bl G_FreeEdict
.L186:
	lwz 0,52(1)
	lwz 12,20(1)
	mtlr 0
	lmw 26,24(1)
	mtcrf 8,12
	la 1,48(1)
	blr
.Lfe9:
	.size	 Cmd_Give_f,.Lfe9-Cmd_Give_f
	.section	".rodata"
	.align 2
.LC62:
	.string	"godmode OFF\n"
	.align 2
.LC63:
	.string	"godmode ON\n"
	.align 2
.LC64:
	.string	"notarget OFF\n"
	.align 2
.LC65:
	.string	"notarget ON\n"
	.align 2
.LC66:
	.string	"noclip OFF\n"
	.align 2
.LC67:
	.string	"noclip ON\n"
	.align 2
.LC68:
	.string	"special"
	.align 2
.LC69:
	.string	"unknown item: %s\n"
	.align 2
.LC70:
	.string	"Item is not usable.\n"
	.align 2
.LC71:
	.string	"Out of item: %s\n"
	.section	".text"
	.align 2
	.globl Cmd_Use_f
	.type	 Cmd_Use_f,@function
Cmd_Use_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 30,3
	la 28,gi@l(9)
	lwz 9,164(28)
	mtlr 9
	blrl
	mr 29,3
	bl FindItem
	lwz 9,164(28)
	mr 31,3
	mtlr 9
	blrl
	lis 4,.LC68@ha
	la 4,.LC68@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L252
	lwz 8,84(30)
	lwz 0,3696(8)
	cmpwi 0,0,0
	bc 4,2,.L251
	lwz 0,3624(8)
	cmpwi 0,0,0
	bc 12,2,.L254
	mr 3,30
	bl PMenu_Next
	b .L255
.L254:
	lwz 0,3924(8)
	cmpwi 0,0,0
	bc 12,2,.L256
	mr 3,30
	bl ChaseNext
	b .L255
.L268:
	stw 11,736(8)
	b .L255
.L256:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	lis 11,Pickup_Weapon@ha
	la 3,itemlist@l(9)
	la 4,Pickup_Weapon@l(11)
	li 7,1
	addi 6,8,740
.L269:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L261
	mulli 0,11,76
	add 10,0,3
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L261
	lwz 0,4(10)
	cmpw 0,0,4
	bc 12,2,.L268
.L261:
	addi 7,7,1
	bdnz .L269
	li 0,-1
	stw 0,736(8)
.L255:
	mr 3,30
	bl Cmd_InvUse_f
	b .L251
.L252:
	cmpwi 0,31,0
	bc 4,2,.L265
	lwz 0,8(28)
	lis 5,.LC69@ha
	mr 3,30
	la 5,.LC69@l(5)
	b .L270
.L265:
	lwz 10,8(31)
	cmpwi 0,10,0
	bc 4,2,.L266
	lwz 0,8(28)
	lis 5,.LC70@ha
	mr 3,30
	la 5,.LC70@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L251
.L266:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,31
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L267
	lwz 0,8(28)
	lis 5,.LC71@ha
	mr 3,30
	la 5,.LC71@l(5)
.L270:
	mr 6,29
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L251
.L267:
	mr 3,30
	mr 4,31
	mtlr 10
	blrl
.L251:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 Cmd_Use_f,.Lfe10-Cmd_Use_f
	.section	".rodata"
	.align 2
.LC72:
	.string	"tech"
	.align 2
.LC73:
	.string	"weapon"
	.align 2
.LC74:
	.string	"item"
	.align 2
.LC75:
	.string	"key"
	.align 2
.LC76:
	.string	"c4 detpack"
	.align 2
.LC77:
	.string	"mine"
	.align 2
.LC78:
	.string	"uziclip"
	.align 2
.LC79:
	.string	"barrettclip"
	.align 2
.LC80:
	.string	"1911clip"
	.align 2
.LC81:
	.string	"ak47 clip"
	.align 2
.LC82:
	.string	"marinershells"
	.align 2
.LC83:
	.string	"glockclip"
	.align 2
.LC84:
	.string	"casullbullets"
	.align 2
.LC85:
	.string	"mp5clip"
	.align 2
.LC86:
	.string	"berettaclip"
	.align 2
.LC87:
	.string	"msg90clip"
	.align 2
.LC88:
	.string	"Item is not dropable.\n"
	.section	".text"
	.align 2
	.globl Cmd_Drop_f
	.type	 Cmd_Drop_f,@function
Cmd_Drop_f:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L271
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	lis 4,.LC72@ha
	la 4,.LC72@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L273
	mr 3,31
	bl CTFWhat_Tech
	mr. 28,3
	bc 12,2,.L273
	lwz 0,12(28)
	mr 3,31
	mr 4,28
	mtlr 0
	blrl
	b .L271
.L273:
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 27,3
	bl FindItem
	lwz 9,164(29)
	mr 28,3
	mtlr 9
	blrl
	lis 4,.LC73@ha
	la 4,.LC73@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L274
	mr 3,31
	bl Cmd_Drop_Weapon_f
	b .L271
.L274:
	lwz 9,164(29)
	mtlr 9
	blrl
	lis 4,.LC74@ha
	la 4,.LC74@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L275
	mr 3,31
	bl Cmd_Drop_Item_f
	b .L271
.L275:
	lwz 9,164(29)
	mtlr 9
	blrl
	lis 4,.LC75@ha
	la 4,.LC75@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L276
	mr 3,31
	bl Cmd_Drop_Key_f
	b .L271
.L276:
	lwz 9,164(29)
	mtlr 9
	blrl
	lis 4,.LC37@ha
	la 4,.LC37@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L271
	lwz 9,164(29)
	mtlr 9
	blrl
	lis 4,.LC76@ha
	la 4,.LC76@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L271
	lwz 9,164(29)
	mtlr 9
	blrl
	lis 4,.LC77@ha
	la 4,.LC77@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L271
	lwz 9,164(29)
	mtlr 9
	blrl
	lis 4,.LC78@ha
	la 4,.LC78@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L280
	lwz 9,164(29)
	mtlr 9
	blrl
	lis 4,.LC79@ha
	la 4,.LC79@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L280
	lwz 9,164(29)
	mtlr 9
	blrl
	lis 4,.LC80@ha
	la 4,.LC80@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L280
	lwz 9,164(29)
	mtlr 9
	blrl
	lis 4,.LC81@ha
	la 4,.LC81@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L280
	lwz 9,164(29)
	mtlr 9
	blrl
	lis 4,.LC82@ha
	la 4,.LC82@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L280
	lwz 9,164(29)
	mtlr 9
	blrl
	lis 4,.LC83@ha
	la 4,.LC83@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L280
	lwz 9,164(29)
	mtlr 9
	blrl
	lis 4,.LC84@ha
	la 4,.LC84@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L280
	lwz 9,164(29)
	mtlr 9
	blrl
	lis 4,.LC85@ha
	la 4,.LC85@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L280
	lwz 9,164(29)
	mtlr 9
	blrl
	lis 4,.LC86@ha
	la 4,.LC86@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L280
	lwz 9,164(29)
	mtlr 9
	blrl
	lis 4,.LC48@ha
	la 4,.LC48@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L280
	lwz 0,164(29)
	mtlr 0
	blrl
	lis 4,.LC87@ha
	la 4,.LC87@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L271
.L280:
	lwz 29,84(31)
	mr 3,27
	lis 30,0x286b
	bl FindItem
	ori 30,30,51739
	lis 9,itemlist@ha
	addi 29,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L271
	lwz 10,84(31)
	lis 11,gi@ha
	la 29,gi@l(11)
	lwz 9,4008(10)
	addi 9,9,2
	stw 9,4008(10)
	lwz 9,164(29)
	mtlr 9
	blrl
	lis 4,.LC48@ha
	la 4,.LC48@l(4)
	bl Q_stricmp
	mr. 0,3
	bc 4,2,.L283
	lwz 9,84(31)
	mr 3,31
	stw 0,3992(9)
	bl ShowTorso
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,8
	stw 9,4008(11)
.L283:
	cmpwi 0,28,0
	bc 4,2,.L284
	lwz 0,8(29)
	lis 5,.LC69@ha
	mr 3,31
	la 5,.LC69@l(5)
	b .L287
.L284:
	lwz 10,12(28)
	cmpwi 0,10,0
	bc 4,2,.L285
	lwz 0,8(29)
	lis 5,.LC88@ha
	mr 3,31
	la 5,.LC88@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L271
.L285:
	subf 0,26,28
	lwz 9,84(31)
	mullw 0,0,30
	addi 9,9,740
	rlwinm 0,0,0,0,29
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 4,2,.L286
	lwz 0,8(29)
	lis 5,.LC71@ha
	mr 3,31
	la 5,.LC71@l(5)
.L287:
	mr 6,27
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L271
.L286:
	mr 3,31
	mr 4,28
	mtlr 10
	blrl
.L271:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 Cmd_Drop_f,.Lfe11-Cmd_Drop_f
	.section	".rodata"
	.align 2
.LC89:
	.string	"bush knife"
	.align 2
.LC90:
	.string	"ARE YOU NUTS? Then you`ll have NOTHING to defend yourself with!\n"
	.align 2
.LC91:
	.string	"1911"
	.align 2
.LC92:
	.string	"1911rounds"
	.align 2
.LC93:
	.string	"MARINERrounds"
	.align 2
.LC94:
	.string	"UZIrounds"
	.align 2
.LC95:
	.string	"m60"
	.align 2
.LC96:
	.string	"m60rounds"
	.align 2
.LC97:
	.string	"50cal"
	.align 2
.LC98:
	.string	"C4 detpack"
	.align 2
.LC99:
	.string	"detonator"
	.align 2
.LC100:
	.string	"ak47rounds"
	.align 2
.LC101:
	.string	"glockrounds"
	.align 2
.LC102:
	.string	"casullrounds"
	.align 2
.LC103:
	.string	"berettarounds"
	.align 2
.LC104:
	.string	"mp5"
	.align 2
.LC105:
	.string	"mp5rounds"
	.align 2
.LC106:
	.string	"msg90rounds"
	.section	".text"
	.align 2
	.globl Cmd_Drop_Weapon_f
	.type	 Cmd_Drop_Weapon_f,@function
Cmd_Drop_Weapon_f:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L288
	lwz 30,84(31)
	lwz 0,3696(30)
	cmpwi 0,0,0
	bc 4,2,.L288
	lis 3,.LC89@ha
	la 3,.LC89@l(3)
	bl FindItem
	lwz 0,1824(30)
	cmpw 0,0,3
	bc 4,2,.L291
	lis 9,gi+8@ha
	lis 5,.LC90@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC90@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L288
.L291:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	lis 4,.LC72@ha
	la 4,.LC72@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L292
	mr 3,31
	bl CTFWhat_Tech
	mr. 10,3
	bc 12,2,.L292
	lwz 0,12(10)
	mr 3,31
	mr 4,10
	mtlr 0
	blrl
	b .L288
.L292:
	lis 9,gi+164@ha
	lis 30,.LC91@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	lwz 29,84(31)
	la 3,.LC91@l(30)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L293
	lwz 29,84(31)
	la 3,.LC91@l(30)
	lis 27,0x286b
	bl FindItem
	ori 27,27,51739
	lis 9,itemlist@ha
	addi 29,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L293
	la 3,.LC91@l(30)
	li 29,0
	bl FindItem
	lis 28,.LC92@ha
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	mr 3,31
	addi 11,11,740
	rlwinm 0,0,0,0,29
	stwx 29,11,0
	lwz 9,84(31)
	stw 29,88(9)
	bl NoAmmoWeaponChange
	la 3,.LC91@l(30)
	bl FindItem
	mr 10,3
	mr 4,10
	mr 3,31
	bl Drop_Item
	mr 30,3
	la 3,.LC92@l(28)
	bl FindItem
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	la 3,.LC92@l(28)
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	stw 9,924(30)
	bl FindItem
	subf 3,26,3
	lwz 9,84(31)
	mullw 3,3,27
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 29,9,3
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,3
	stw 9,4008(11)
	lwz 0,924(30)
	cmpwi 0,0,0
	bc 4,2,.L288
	li 0,1
	stw 0,56(30)
	b .L288
.L293:
	lis 30,.LC11@ha
	lwz 29,84(31)
	la 3,.LC11@l(30)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L296
	lwz 29,84(31)
	la 3,.LC11@l(30)
	lis 27,0x286b
	bl FindItem
	ori 27,27,51739
	lis 9,itemlist@ha
	addi 29,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L296
	la 3,.LC11@l(30)
	li 29,0
	bl FindItem
	lis 28,.LC93@ha
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	mr 3,31
	addi 11,11,740
	rlwinm 0,0,0,0,29
	stwx 29,11,0
	lwz 9,84(31)
	stw 29,88(9)
	bl NoAmmoWeaponChange
	la 3,.LC11@l(30)
	bl FindItem
	mr 10,3
	mr 4,10
	mr 3,31
	bl Drop_Item
	mr 30,3
	la 3,.LC93@l(28)
	bl FindItem
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	la 3,.LC93@l(28)
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	stw 9,924(30)
	bl FindItem
	subf 3,26,3
	lwz 9,84(31)
	mullw 3,3,27
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 29,9,3
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,9
	b .L330
.L296:
	lis 30,.LC10@ha
	lwz 29,84(31)
	la 3,.LC10@l(30)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L298
	lwz 29,84(31)
	la 3,.LC10@l(30)
	lis 27,0x286b
	bl FindItem
	ori 27,27,51739
	lis 9,itemlist@ha
	addi 29,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L298
	la 3,.LC10@l(30)
	li 29,0
	bl FindItem
	lis 28,.LC94@ha
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	mr 3,31
	addi 11,11,740
	rlwinm 0,0,0,0,29
	stwx 29,11,0
	lwz 9,84(31)
	stw 29,88(9)
	bl NoAmmoWeaponChange
	la 3,.LC10@l(30)
	bl FindItem
	mr 10,3
	mr 4,10
	mr 3,31
	bl Drop_Item
	mr 30,3
	la 3,.LC94@l(28)
	bl FindItem
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	la 3,.LC94@l(28)
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	stw 9,924(30)
	bl FindItem
	subf 3,26,3
	lwz 9,84(31)
	mullw 3,3,27
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 29,9,3
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,8
	b .L330
.L298:
	lis 30,.LC95@ha
	lwz 29,84(31)
	la 3,.LC95@l(30)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L300
	lwz 29,84(31)
	la 3,.LC95@l(30)
	lis 27,0x286b
	bl FindItem
	ori 27,27,51739
	lis 9,itemlist@ha
	addi 29,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L300
	lwz 9,84(31)
	li 29,0
	mr 3,31
	lis 28,.LC96@ha
	stw 29,3992(9)
	bl ShowTorso
	la 3,.LC95@l(30)
	bl FindItem
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	mr 3,31
	addi 11,11,740
	rlwinm 0,0,0,0,29
	stwx 29,11,0
	lwz 9,84(31)
	stw 29,88(9)
	bl NoAmmoWeaponChange
	la 3,.LC95@l(30)
	bl FindItem
	lwz 9,84(31)
	mr 10,3
	mr 4,10
	mr 3,31
	stw 29,4036(9)
	bl Drop_Item
	mr 30,3
	la 3,.LC96@l(28)
	bl FindItem
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	la 3,.LC96@l(28)
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	stw 9,924(30)
	bl FindItem
	subf 3,26,3
	lwz 9,84(31)
	mullw 3,3,27
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 29,9,3
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,22
	b .L330
.L300:
	lis 30,.LC15@ha
	lwz 29,84(31)
	la 3,.LC15@l(30)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L302
	lwz 29,84(31)
	la 3,.LC15@l(30)
	lis 27,0x286b
	bl FindItem
	ori 27,27,51739
	lis 9,itemlist@ha
	addi 29,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L302
	la 3,.LC15@l(30)
	li 29,0
	bl FindItem
	lis 28,.LC97@ha
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	mr 3,31
	addi 11,11,740
	rlwinm 0,0,0,0,29
	stwx 29,11,0
	lwz 9,84(31)
	stw 29,88(9)
	bl NoAmmoWeaponChange
	la 3,.LC15@l(30)
	bl FindItem
	lwz 11,84(31)
	mr 10,3
	lis 0,0x42b4
	mr 4,10
	mr 3,31
	stw 29,4036(11)
	lwz 9,84(31)
	stw 0,112(9)
	bl Drop_Item
	mr 30,3
	la 3,.LC97@l(28)
	bl FindItem
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	la 3,.LC97@l(28)
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	stw 9,924(30)
	bl FindItem
	subf 3,26,3
	lwz 9,84(31)
	mullw 3,3,27
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 29,9,3
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,17
	b .L330
.L302:
	lis 27,.LC98@ha
	lwz 29,84(31)
	la 3,.LC98@l(27)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L304
	lwz 29,84(31)
	la 3,.LC98@l(27)
	lis 30,0x286b
	bl FindItem
	ori 30,30,51739
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L304
	la 3,.LC98@l(27)
	bl FindItem
	subf 0,28,3
	lwz 10,84(31)
	li 8,0
	mullw 0,0,30
	mr 3,31
	addi 10,10,740
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	addi 9,9,-1
	stwx 9,10,0
	lwz 11,84(31)
	stw 8,88(11)
	bl NoAmmoWeaponChange
	la 3,.LC98@l(27)
	b .L331
.L304:
	lis 28,.LC99@ha
	lwz 29,84(31)
	la 3,.LC99@l(28)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L306
	lwz 29,84(31)
	la 3,.LC99@l(28)
	lis 30,0x286b
	bl FindItem
	ori 30,30,51739
	lis 9,itemlist@ha
	addi 29,29,740
	la 27,itemlist@l(9)
	subf 3,27,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L306
	la 3,.LC99@l(28)
	bl FindItem
	mr 10,3
	mr 4,10
	mr 3,31
	bl Drop_Item
	la 3,.LC99@l(28)
	bl FindItem
	subf 0,27,3
	lwz 11,84(31)
	li 10,0
	mullw 0,0,30
	mr 3,31
	addi 11,11,740
	rlwinm 0,0,0,0,29
	stwx 10,11,0
	lwz 9,84(31)
	stw 10,88(9)
	bl NoAmmoWeaponChange
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,2
	b .L330
.L306:
	lis 27,.LC77@ha
	lwz 29,84(31)
	la 3,.LC77@l(27)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L308
	lwz 29,84(31)
	la 3,.LC77@l(27)
	lis 30,0x286b
	bl FindItem
	ori 30,30,51739
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L308
	la 3,.LC77@l(27)
	bl FindItem
	subf 0,28,3
	lwz 10,84(31)
	li 8,0
	mullw 0,0,30
	mr 3,31
	addi 10,10,740
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	addi 9,9,-1
	stwx 9,10,0
	lwz 11,84(31)
	stw 8,88(11)
	bl NoAmmoWeaponChange
	la 3,.LC77@l(27)
	b .L331
.L308:
	lis 30,.LC14@ha
	lwz 29,84(31)
	la 3,.LC14@l(30)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L310
	lwz 29,84(31)
	la 3,.LC14@l(30)
	lis 27,0x286b
	bl FindItem
	ori 27,27,51739
	lis 9,itemlist@ha
	addi 29,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L310
	la 3,.LC14@l(30)
	li 29,0
	bl FindItem
	lis 28,.LC100@ha
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	mr 3,31
	addi 11,11,740
	rlwinm 0,0,0,0,29
	stwx 29,11,0
	lwz 9,84(31)
	stw 29,88(9)
	bl NoAmmoWeaponChange
	la 3,.LC14@l(30)
	bl FindItem
	mr 10,3
	mr 4,10
	mr 3,31
	bl Drop_Item
	mr 30,3
	la 3,.LC100@l(28)
	bl FindItem
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	la 3,.LC100@l(28)
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	stw 9,924(30)
	bl FindItem
	subf 3,26,3
	lwz 9,84(31)
	mullw 3,3,27
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 29,9,3
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,11
	b .L330
.L310:
	lis 30,.LC17@ha
	lwz 29,84(31)
	la 3,.LC17@l(30)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L312
	lwz 29,84(31)
	la 3,.LC17@l(30)
	lis 27,0x286b
	bl FindItem
	ori 27,27,51739
	lis 9,itemlist@ha
	addi 29,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L312
	lwz 9,84(31)
	lwz 0,4052(9)
	cmpwi 0,0,1
	bc 4,2,.L313
	li 0,0
	mr 3,31
	stw 0,4052(9)
	bl SP_LaserSight
.L313:
	la 3,.LC17@l(30)
	li 29,0
	bl FindItem
	lis 28,.LC101@ha
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	mr 3,31
	addi 11,11,740
	rlwinm 0,0,0,0,29
	stwx 29,11,0
	lwz 9,84(31)
	stw 29,88(9)
	bl NoAmmoWeaponChange
	la 3,.LC17@l(30)
	bl FindItem
	mr 10,3
	mr 4,10
	mr 3,31
	bl Drop_Item
	mr 30,3
	la 3,.LC101@l(28)
	bl FindItem
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	la 3,.LC101@l(28)
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	stw 9,924(30)
	bl FindItem
	subf 3,26,3
	lwz 9,84(31)
	mullw 3,3,27
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 29,9,3
	lwz 0,924(30)
	cmpwi 0,0,0
	bc 4,2,.L332
	li 0,1
	stw 0,56(30)
	b .L332
.L312:
	lis 30,.LC18@ha
	lwz 29,84(31)
	la 3,.LC18@l(30)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L316
	lwz 29,84(31)
	la 3,.LC18@l(30)
	lis 27,0x286b
	bl FindItem
	ori 27,27,51739
	lis 9,itemlist@ha
	addi 29,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L316
	la 3,.LC18@l(30)
	li 29,0
	bl FindItem
	lis 28,.LC102@ha
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	mr 3,31
	addi 11,11,740
	rlwinm 0,0,0,0,29
	stwx 29,11,0
	lwz 9,84(31)
	stw 29,88(9)
	bl NoAmmoWeaponChange
	la 3,.LC18@l(30)
	bl FindItem
	mr 10,3
	mr 4,10
	mr 3,31
	bl Drop_Item
	mr 30,3
	la 3,.LC102@l(28)
	bl FindItem
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	la 3,.LC102@l(28)
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	stw 9,924(30)
	bl FindItem
	subf 3,26,3
	lwz 9,84(31)
	mullw 3,3,27
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 29,9,3
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,6
	b .L330
.L316:
	lis 30,.LC19@ha
	lwz 29,84(31)
	la 3,.LC19@l(30)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L318
	lwz 29,84(31)
	la 3,.LC19@l(30)
	lis 27,0x286b
	bl FindItem
	ori 27,27,51739
	lis 9,itemlist@ha
	addi 29,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L318
	la 3,.LC19@l(30)
	li 29,0
	bl FindItem
	lis 28,.LC103@ha
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	mr 3,31
	addi 11,11,740
	rlwinm 0,0,0,0,29
	stwx 29,11,0
	lwz 9,84(31)
	stw 29,88(9)
	bl NoAmmoWeaponChange
	la 3,.LC19@l(30)
	bl FindItem
	mr 10,3
	mr 4,10
	mr 3,31
	bl Drop_Item
	mr 30,3
	la 3,.LC103@l(28)
	bl FindItem
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	la 3,.LC103@l(28)
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	stw 9,924(30)
	bl FindItem
	subf 3,26,3
	lwz 9,84(31)
	mullw 3,3,27
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 29,9,3
	lwz 0,924(30)
	cmpwi 0,0,0
	bc 4,2,.L319
	li 0,1
	stw 0,56(30)
.L319:
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,4
	b .L330
.L318:
	lis 30,.LC104@ha
	lwz 29,84(31)
	la 3,.LC104@l(30)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L321
	lwz 29,84(31)
	la 3,.LC104@l(30)
	lis 27,0x286b
	bl FindItem
	ori 27,27,51739
	lis 9,itemlist@ha
	addi 29,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L321
	la 3,.LC104@l(30)
	li 29,0
	bl FindItem
	lis 28,.LC105@ha
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	mr 3,31
	addi 11,11,740
	rlwinm 0,0,0,0,29
	stwx 29,11,0
	lwz 9,84(31)
	stw 29,88(9)
	bl NoAmmoWeaponChange
	la 3,.LC104@l(30)
	bl FindItem
	mr 10,3
	mr 4,10
	mr 3,31
	bl Drop_Item
	mr 30,3
	la 3,.LC105@l(28)
	bl FindItem
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	la 3,.LC105@l(28)
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	stw 9,924(30)
	bl FindItem
	subf 3,26,3
	lwz 9,84(31)
	mullw 3,3,27
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 29,9,3
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,8
	b .L330
.L321:
	lis 30,.LC36@ha
	lwz 29,84(31)
	la 3,.LC36@l(30)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L323
	lwz 29,84(31)
	la 3,.LC36@l(30)
	lis 27,0x286b
	bl FindItem
	ori 27,27,51739
	lis 9,itemlist@ha
	addi 29,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L323
	la 3,.LC36@l(30)
	li 29,0
	bl FindItem
	lis 28,.LC106@ha
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	mr 3,31
	addi 11,11,740
	rlwinm 0,0,0,0,29
	stwx 29,11,0
	lwz 9,84(31)
	stw 29,88(9)
	bl NoAmmoWeaponChange
	lwz 11,84(31)
	lis 0,0x42b4
	la 3,.LC36@l(30)
	stw 29,4036(11)
	lwz 9,84(31)
	stw 0,112(9)
	lwz 11,84(31)
	lwz 0,116(11)
	rlwinm 0,0,0,30,28
	stw 0,116(11)
	lwz 9,84(31)
	stw 29,4028(9)
	bl FindItem
	mr 10,3
	mr 4,10
	mr 3,31
	bl Drop_Item
	mr 30,3
	la 3,.LC106@l(28)
	bl FindItem
	subf 0,26,3
	lwz 11,84(31)
	mullw 0,0,27
	la 3,.LC106@l(28)
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	stw 9,924(30)
	bl FindItem
	subf 3,26,3
	lwz 9,84(31)
	mullw 3,3,27
	addi 9,9,740
	rlwinm 3,3,0,0,29
	stwx 29,9,3
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,10
	b .L330
.L323:
	lis 27,.LC37@ha
	lwz 29,84(31)
	la 3,.LC37@l(27)
	bl FindItem
	lwz 0,1824(29)
	cmpw 0,0,3
	bc 4,2,.L288
	lwz 29,84(31)
	la 3,.LC37@l(27)
	lis 30,0x286b
	bl FindItem
	ori 30,30,51739
	lis 9,itemlist@ha
	addi 29,29,740
	la 28,itemlist@l(9)
	subf 3,28,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,0
	bc 12,2,.L288
	la 3,.LC37@l(27)
	bl FindItem
	subf 0,28,3
	lwz 10,84(31)
	li 8,0
	mullw 0,0,30
	mr 3,31
	addi 10,10,740
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	addi 9,9,-1
	stwx 9,10,0
	lwz 11,84(31)
	stw 8,88(11)
	bl NoAmmoWeaponChange
	la 3,.LC37@l(27)
.L331:
	bl FindItem
	mr 10,3
	mr 4,10
	mr 3,31
	bl Drop_Item
.L332:
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,5
.L330:
	stw 9,4008(11)
.L288:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 Cmd_Drop_Weapon_f,.Lfe12-Cmd_Drop_Weapon_f
	.section	".rodata"
	.align 2
.LC107:
	.string	"No item to use.\n"
	.align 2
.LC108:
	.string	"ir goggles"
	.align 2
.LC109:
	.string	"head light"
	.align 2
.LC110:
	.string	"helmet"
	.align 2
.LC111:
	.string	"bullet proof vest"
	.align 2
.LC112:
	.string	"scuba gear"
	.align 2
.LC113:
	.string	"medkit"
	.section	".text"
	.align 2
	.globl Cmd_InvUse_f
	.type	 Cmd_InvUse_f,@function
Cmd_InvUse_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 8,84(31)
	lwz 0,3624(8)
	cmpwi 0,0,0
	bc 12,2,.L343
	bl PMenu_Select
	b .L342
.L343:
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L342
	lwz 11,736(8)
	addi 10,8,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L346
	lwz 0,3924(8)
	cmpwi 0,0,0
	bc 12,2,.L349
	mr 3,31
	bl ChaseNext
	b .L346
.L434:
	stw 11,736(8)
	b .L346
.L349:
	li 0,256
	mr 7,10
	mtctr 0
	mr 6,11
	li 10,1
.L449:
	add 11,6,10
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 4,2,.L434
	addi 10,10,1
	bdnz .L449
	li 0,-1
	stw 0,736(8)
.L346:
	lwz 8,84(31)
	lwz 11,736(8)
	cmpwi 0,11,-1
	bc 4,2,.L356
	lis 9,gi+8@ha
	lis 5,.LC107@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC107@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L342
.L356:
	mulli 0,11,76
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 29,0,9
	lwz 30,8(29)
	cmpwi 0,30,0
	bc 4,2,.L357
	lis 0,0x286b
	subf 9,9,29
	ori 0,0,51739
	addi 10,8,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,10,9
	cmpwi 0,0,0
	bc 4,2,.L358
	lwz 0,3624(8)
	cmpwi 0,0,0
	bc 12,2,.L359
	mr 3,31
	bl PMenu_Next
	b .L342
.L359:
	lwz 0,3924(8)
	cmpwi 0,0,0
	bc 12,2,.L361
	mr 3,31
	bl ChaseNext
	b .L342
.L361:
	li 0,256
	mr 7,10
	mtctr 0
	mr 6,11
	li 10,1
.L448:
	add 11,6,10
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 4,2,.L435
	addi 10,10,1
	bdnz .L448
	li 0,-1
	stw 0,736(8)
	b .L342
.L358:
	lwz 11,12(29)
	cmpwi 0,11,0
	bc 12,2,.L342
	lwz 0,4(29)
	lis 9,Pickup_Ammo@ha
	la 9,Pickup_Ammo@l(9)
	cmpw 0,0,9
	bc 12,2,.L370
	lis 9,Pickup_Key@ha
	la 9,Pickup_Key@l(9)
	cmpw 0,0,9
	bc 4,2,.L369
.L370:
	mr 3,31
	mr 4,29
	mtlr 11
	blrl
	lwz 10,84(31)
	lwz 0,3624(10)
	cmpwi 0,0,0
	bc 12,2,.L371
	mr 3,31
	bl PMenu_Next
	b .L372
.L371:
	lwz 0,3924(10)
	cmpwi 0,0,0
	bc 12,2,.L373
	mr 3,31
	bl ChaseNext
	b .L372
.L436:
	stw 11,736(10)
	b .L372
.L373:
	li 0,256
	lwz 6,736(10)
	li 8,1
	mtctr 0
	addi 7,10,740
.L447:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 4,2,.L436
	addi 8,8,1
	bdnz .L447
	li 0,-1
	stw 0,736(10)
.L372:
	lwz 11,84(31)
	lis 3,.LC48@ha
	la 3,.LC48@l(3)
	lwz 9,4008(11)
	addi 9,9,2
	stw 9,4008(11)
	bl FindItem
	cmpw 0,29,3
	bc 4,2,.L342
	lwz 9,84(31)
	li 0,0
	mr 3,31
	stw 0,3992(9)
	bl ShowTorso
	lwz 11,84(31)
	lwz 9,4008(11)
	addi 9,9,8
	stw 9,4008(11)
	b .L342
.L369:
	lis 9,Pickup_Item@ha
	la 9,Pickup_Item@l(9)
	cmpw 0,0,9
	bc 4,2,.L342
	lis 3,.LC108@ha
	la 3,.LC108@l(3)
	bl FindItem
	cmpw 0,29,3
	bc 4,2,.L382
	lwz 11,84(31)
	mr 3,31
	mr 4,29
	lwz 0,116(11)
	rlwinm 0,0,0,30,28
	stw 0,116(11)
	lwz 9,84(31)
	stw 30,4028(9)
	lwz 11,84(31)
	stw 30,3988(11)
	bl Drop_Item
	lwz 10,84(31)
	lwz 0,3624(10)
	cmpwi 0,0,0
	bc 12,2,.L383
	mr 3,31
	bl PMenu_Next
	b .L384
.L383:
	lwz 0,3924(10)
	cmpwi 0,0,0
	bc 12,2,.L385
	mr 3,31
	bl ChaseNext
	b .L384
.L437:
	stw 11,736(10)
	b .L384
.L385:
	li 0,256
	lwz 6,736(10)
	li 8,1
	mtctr 0
	addi 7,10,740
.L446:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 4,2,.L437
	addi 8,8,1
	bdnz .L446
	li 0,-1
	stw 0,736(10)
.L384:
	lwz 10,84(31)
	lis 11,itemlist@ha
	lis 0,0x286b
	la 11,itemlist@l(11)
	ori 0,0,51739
	lwz 9,4008(10)
	subf 11,11,29
	li 8,0
	mullw 11,11,0
	mr 3,31
	addi 9,9,3
	b .L450
.L382:
	lis 3,.LC109@ha
	la 3,.LC109@l(3)
	bl FindItem
	cmpw 0,29,3
	bc 12,2,.L393
	lis 3,.LC110@ha
	la 3,.LC110@l(3)
	bl FindItem
	cmpw 0,29,3
	bc 4,2,.L392
.L393:
	lwz 9,84(31)
	lwz 0,4048(9)
	cmpwi 0,0,1
	bc 4,2,.L394
	mr 3,31
	bl SP_FlashLight
.L394:
	lwz 9,84(31)
	mr 3,31
	mr 4,29
	stw 30,4048(9)
	lwz 11,84(31)
	stw 30,3988(11)
	bl Drop_Item
	lwz 10,84(31)
	lwz 0,3624(10)
	cmpwi 0,0,0
	bc 4,2,.L451
	lwz 0,3924(10)
	cmpwi 0,0,0
	bc 4,2,.L452
	li 0,256
	lwz 6,736(10)
	li 8,1
	mtctr 0
	addi 7,10,740
.L445:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 4,2,.L441
	addi 8,8,1
	bdnz .L445
	b .L453
.L392:
	lis 3,.LC111@ha
	la 3,.LC111@l(3)
	bl FindItem
	cmpw 0,29,3
	bc 4,2,.L404
	lwz 9,84(31)
	mr 3,31
	mr 4,29
	stw 30,3992(9)
	bl Drop_Item
	lwz 10,84(31)
	lwz 0,3624(10)
	cmpwi 0,0,0
	bc 12,2,.L405
	mr 3,31
	bl PMenu_Next
	b .L406
.L405:
	lwz 0,3924(10)
	cmpwi 0,0,0
	bc 12,2,.L407
	mr 3,31
	bl ChaseNext
	b .L406
.L439:
	stw 11,736(10)
	b .L406
.L407:
	li 0,256
	lwz 6,736(10)
	li 8,1
	mtctr 0
	addi 7,10,740
.L444:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 4,2,.L439
	addi 8,8,1
	bdnz .L444
	li 0,-1
	stw 0,736(10)
.L406:
	lwz 10,84(31)
	lis 11,itemlist@ha
	lis 0,0x286b
	la 11,itemlist@l(11)
	ori 0,0,51739
	lwz 9,4008(10)
	subf 11,11,29
	li 8,0
	mullw 11,11,0
	mr 3,31
	addi 9,9,4
	b .L450
.L404:
	lis 3,.LC112@ha
	la 3,.LC112@l(3)
	bl FindItem
	cmpw 0,29,3
	bc 4,2,.L414
	lwz 9,84(31)
	mr 3,31
	mr 4,29
	stw 30,3992(9)
	bl Drop_Item
	lwz 10,84(31)
	lwz 0,3624(10)
	cmpwi 0,0,0
	bc 12,2,.L415
	mr 3,31
	bl PMenu_Next
	b .L416
.L415:
	lwz 0,3924(10)
	cmpwi 0,0,0
	bc 12,2,.L417
	mr 3,31
	bl ChaseNext
	b .L416
.L440:
	stw 11,736(10)
	b .L416
.L417:
	li 0,256
	lwz 6,736(10)
	li 8,1
	mtctr 0
	addi 7,10,740
.L443:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 4,2,.L440
	addi 8,8,1
	bdnz .L443
	li 0,-1
	stw 0,736(10)
.L416:
	lwz 10,84(31)
	lis 11,itemlist@ha
	lis 0,0x286b
	la 11,itemlist@l(11)
	ori 0,0,51739
	lwz 9,4008(10)
	subf 11,11,29
	li 8,0
	mullw 11,11,0
	mr 3,31
	addi 9,9,5
	b .L450
.L414:
	lis 3,.LC113@ha
	la 3,.LC113@l(3)
	bl FindItem
	cmpw 0,29,3
	bc 4,2,.L342
	lwz 9,84(31)
	mr 3,31
	mr 4,29
	stw 30,3992(9)
	bl Drop_Item
	lwz 10,84(31)
	lwz 0,3624(10)
	cmpwi 0,0,0
	bc 12,2,.L425
.L451:
	mr 3,31
	bl PMenu_Next
	b .L426
.L425:
	lwz 0,3924(10)
	cmpwi 0,0,0
	bc 12,2,.L427
.L452:
	mr 3,31
	bl ChaseNext
	b .L426
.L441:
	stw 11,736(10)
	b .L426
.L427:
	li 0,256
	lwz 6,736(10)
	li 8,1
	mtctr 0
	addi 7,10,740
.L442:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 4,2,.L441
	addi 8,8,1
	bdnz .L442
.L453:
	li 0,-1
	stw 0,736(10)
.L426:
	lwz 10,84(31)
	lis 11,itemlist@ha
	lis 0,0x286b
	la 11,itemlist@l(11)
	ori 0,0,51739
	lwz 9,4008(10)
	subf 11,11,29
	li 8,0
	mullw 11,11,0
	mr 3,31
	addi 9,9,2
.L450:
	stw 9,4008(10)
	rlwinm 11,11,0,0,29
	lwz 9,84(31)
	addi 9,9,740
	stwx 8,9,11
	bl ShowItem
	mr 3,31
	bl ShowTorso
	b .L342
.L435:
	stw 11,736(8)
	b .L342
.L357:
	mr 3,31
	mr 4,29
	mtlr 30
	blrl
.L342:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 Cmd_InvUse_f,.Lfe13-Cmd_InvUse_f
	.section	".rodata"
	.align 2
.LC114:
	.string	"No item to drop.\n"
	.section	".text"
	.align 2
	.globl Cmd_InvDrop_f
	.type	 Cmd_InvDrop_f,@function
Cmd_InvDrop_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L482
	lwz 8,84(31)
	lwz 11,736(8)
	addi 10,8,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L485
	lwz 0,3624(8)
	cmpwi 0,0,0
	bc 12,2,.L486
	bl PMenu_Next
	b .L485
.L486:
	lwz 0,3924(8)
	cmpwi 0,0,0
	bc 12,2,.L488
	mr 3,31
	bl ChaseNext
	b .L485
.L497:
	stw 11,736(8)
	b .L485
.L488:
	li 0,256
	mr 7,10
	mtctr 0
	mr 6,11
	li 10,1
.L498:
	add 11,6,10
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 4,2,.L497
	addi 10,10,1
	bdnz .L498
	li 0,-1
	stw 0,736(8)
.L485:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L495
	lis 9,gi+8@ha
	lis 5,.LC114@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC114@l(5)
	b .L499
.L495:
	mulli 0,0,76
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L496
	lis 9,gi+8@ha
	lis 5,.LC88@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC88@l(5)
.L499:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L482
.L496:
	mr 3,31
	mtlr 0
	blrl
.L482:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 Cmd_InvDrop_f,.Lfe14-Cmd_InvDrop_f
	.section	".rodata"
	.align 2
.LC115:
	.string	"%3i %s\n"
	.align 2
.LC116:
	.string	"...\n"
	.align 2
.LC117:
	.string	"%s\n%i players\n"
	.align 2
.LC118:
	.long 0x0
	.align 3
.LC119:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_Players_f
	.type	 Cmd_Players_f,@function
Cmd_Players_f:
	stwu 1,-2432(1)
	mflr 0
	stmw 23,2396(1)
	stw 0,2436(1)
	lis 11,.LC118@ha
	lis 9,maxclients@ha
	la 11,.LC118@l(11)
	mr 23,3
	lfs 13,0(11)
	li 27,0
	li 31,0
	lwz 11,maxclients@l(9)
	addi 29,1,1352
	addi 30,1,72
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L510
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,29
	lis 9,.LC119@ha
	la 9,.LC119@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L512:
	lwz 0,0(11)
	addi 11,11,4080
	cmpwi 0,0,0
	bc 12,2,.L511
	stw 31,0(10)
	addi 27,27,1
	addi 10,10,4
.L511:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L512
.L510:
	lis 6,PlayerSort@ha
	mr 3,29
	la 6,PlayerSort@l(6)
	mr 4,27
	li 5,4
	li 31,0
	bl qsort
	cmpw 0,31,27
	li 0,0
	stb 0,72(1)
	bc 4,0,.L516
	lis 9,game@ha
	mr 28,29
	la 24,game@l(9)
	lis 26,.LC115@ha
	lis 25,.LC116@ha
.L518:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC115@l(26)
	addi 28,28,4
	mulli 7,7,4080
	add 7,7,0
	lha 6,148(7)
	addi 7,7,700
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,30
	bl strlen
	add 29,29,3
	cmplwi 0,29,1180
	bc 4,1,.L519
	la 4,.LC116@l(25)
	mr 3,30
	bl strcat
	b .L516
.L519:
	mr 3,30
	addi 4,1,8
	bl strcat
	addi 31,31,1
	cmpw 0,31,27
	bc 12,0,.L518
.L516:
	lis 9,gi+8@ha
	lis 5,.LC117@ha
	lwz 0,gi+8@l(9)
	mr 3,23
	la 5,.LC117@l(5)
	mr 6,30
	mr 7,27
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,2436(1)
	mtlr 0
	lmw 23,2396(1)
	la 1,2432(1)
	blr
.Lfe15:
	.size	 Cmd_Players_f,.Lfe15-Cmd_Players_f
	.section	".rodata"
	.align 2
.LC120:
	.string	"flipoff\n"
	.align 2
.LC121:
	.string	"salute\n"
	.align 2
.LC122:
	.string	"taunt\n"
	.align 2
.LC123:
	.string	"wave\n"
	.align 2
.LC124:
	.string	"point\n"
	.section	".text"
	.align 2
	.globl Cmd_Wave_f
	.type	 Cmd_Wave_f,@function
Cmd_Wave_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,gi+160@ha
	mr 31,3
	lwz 0,gi+160@l(9)
	li 3,1
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 11,0,1
	bc 4,2,.L521
	lwz 0,3824(9)
	cmpwi 0,0,1
	bc 12,1,.L521
	cmplwi 0,3,4
	li 0,1
	stw 0,3824(9)
	bc 12,1,.L530
	lis 11,.L531@ha
	slwi 10,3,2
	la 11,.L531@l(11)
	lis 9,.L531@ha
	lwzx 0,10,11
	la 9,.L531@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L531:
	.long .L525-.L531
	.long .L526-.L531
	.long .L527-.L531
	.long .L528-.L531
	.long .L530-.L531
.L525:
	lis 9,gi+8@ha
	lis 5,.LC120@ha
	lwz 0,gi+8@l(9)
	la 5,.LC120@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,71
	li 9,83
	b .L532
.L526:
	lis 9,gi+8@ha
	lis 5,.LC121@ha
	lwz 0,gi+8@l(9)
	la 5,.LC121@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,83
	li 9,94
	b .L532
.L527:
	lis 9,gi+8@ha
	lis 5,.LC122@ha
	lwz 0,gi+8@l(9)
	la 5,.LC122@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,94
	li 9,111
	b .L532
.L528:
	lis 9,gi+8@ha
	lis 5,.LC123@ha
	lwz 0,gi+8@l(9)
	la 5,.LC123@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,111
	li 9,122
	b .L532
.L530:
	lis 9,gi+8@ha
	lis 5,.LC124@ha
	lwz 0,gi+8@l(9)
	la 5,.LC124@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,122
	li 9,134
.L532:
	stw 0,56(31)
	stw 9,3820(11)
.L521:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe16:
	.size	 Cmd_Wave_f,.Lfe16-Cmd_Wave_f
	.section	".rodata"
	.align 2
.LC125:
	.string	"(%s): "
	.align 2
.LC126:
	.string	"%s: "
	.align 2
.LC127:
	.string	" "
	.align 2
.LC128:
	.string	"\n"
	.align 2
.LC129:
	.string	"You can't talk for %d more seconds\n"
	.align 2
.LC130:
	.string	"Flood protection:  You can't talk for %d seconds.\n"
	.align 2
.LC131:
	.string	"%s"
	.align 2
.LC132:
	.long 0x0
	.align 3
.LC133:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC134:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Cmd_Say_f
	.type	 Cmd_Say_f,@function
Cmd_Say_f:
	stwu 1,-2112(1)
	mflr 0
	mfcr 12
	stmw 24,2080(1)
	stw 0,2116(1)
	stw 12,2076(1)
	lis 9,gi+156@ha
	mr 28,3
	lwz 0,gi+156@l(9)
	mr 30,4
	mr 31,5
	mtlr 0
	blrl
	cmpwi 0,3,1
	bc 12,1,.L534
	cmpwi 0,31,0
	bc 12,2,.L533
.L534:
	lis 10,dmflags@ha
	lwz 11,dmflags@l(10)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,2064(1)
	lwz 9,2068(1)
	rlwinm 9,9,0,24,25
	neg 9,9
	srawi 9,9,31
	and. 30,30,9
	bc 12,2,.L536
	lwz 6,84(28)
	lis 5,.LC125@ha
	addi 3,1,8
	la 5,.LC125@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	b .L537
.L536:
	lwz 6,84(28)
	lis 5,.LC126@ha
	addi 3,1,8
	la 5,.LC126@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
.L537:
	cmpwi 0,31,0
	bc 12,2,.L538
	lis 29,gi@ha
	li 3,0
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC127@ha
	addi 3,1,8
	la 4,.LC127@l(4)
	bl strcat
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	b .L539
.L538:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L540
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	stb 31,-1(3)
.L540:
	mr 4,29
	addi 3,1,8
	bl strcat
.L539:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L541
	li 0,0
	stb 0,158(1)
.L541:
	lis 4,.LC128@ha
	addi 3,1,8
	la 4,.LC128@l(4)
	bl strcat
	lis 9,.LC132@ha
	la 9,.LC132@l(9)
	lfs 8,0(9)
	lis 9,flood_msgs@ha
	lwz 11,flood_msgs@l(9)
	lfs 9,20(11)
	fcmpu 0,9,8
	bc 12,2,.L542
	lwz 7,84(28)
	lis 9,level+4@ha
	lfs 10,level+4@l(9)
	lfs 0,3872(7)
	fcmpu 0,10,0
	bc 4,0,.L543
	fsubs 0,0,10
	lis 9,gi+8@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC129@ha
	mr 3,28
	la 5,.LC129@l(5)
	li 4,2
	mtlr 0
	fctiwz 13,0
	stfd 13,2064(1)
	b .L556
.L543:
	lwz 0,3916(7)
	lis 10,0x4330
	lis 11,.LC133@ha
	addi 8,7,3876
	mr 6,0
	la 11,.LC133@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,2068(1)
	lis 11,.LC134@ha
	stw 10,2064(1)
	la 11,.LC134@l(11)
	lfd 0,2064(1)
	mr 10,8
	lfs 11,0(11)
	mr 11,9
	fsub 0,0,13
	frsp 0,0
	fsubs 0,0,9
	fadds 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,2064(1)
	lwz 11,2068(1)
	nor 0,11,11
	addi 9,11,10
	srawi 0,0,31
	andc 9,9,0
	and 11,11,0
	or 11,11,9
	slwi 11,11,2
	lfsx 0,8,11
	fcmpu 0,0,8
	bc 12,2,.L545
	lis 11,flood_persecond@ha
	fsubs 13,10,0
	lwz 9,flood_persecond@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L545
	lis 9,flood_waitdelay@ha
	lis 10,gi+8@ha
	lwz 11,flood_waitdelay@l(9)
	lis 5,.LC130@ha
	mr 3,28
	la 5,.LC130@l(5)
	lfs 13,20(11)
	li 4,3
	fadds 13,10,13
	stfs 13,3872(7)
	lfs 0,20(11)
	lwz 0,gi+8@l(10)
	mtlr 0
	fctiwz 12,0
	stfd 12,2064(1)
.L556:
	lwz 6,2068(1)
	crxor 6,6,6
	blrl
	b .L533
.L545:
	lis 0,0xcccc
	addi 9,6,1
	ori 0,0,52429
	lis 11,level+4@ha
	mulhwu 0,9,0
	srwi 0,0,3
	mulli 0,0,10
	subf 9,0,9
	stw 9,3916(7)
	lfs 0,level+4@l(11)
	slwi 9,9,2
	stfsx 0,10,9
.L542:
	lis 9,.LC132@ha
	lis 11,dedicated@ha
	la 9,.LC132@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L546
	lis 9,gi+8@ha
	lis 5,.LC131@ha
	lwz 0,gi+8@l(9)
	la 5,.LC131@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L546:
	lis 9,game@ha
	li 31,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,31,0
	bc 12,1,.L533
	cmpwi 4,30,0
	lis 9,gi@ha
	la 24,gi@l(9)
	mr 25,11
	lis 26,g_edicts@ha
	lis 27,.LC131@ha
	li 30,928
.L550:
	lwz 0,g_edicts@l(26)
	add 29,0,30
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L549
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L549
	bc 12,18,.L553
	mr 3,28
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L549
.L553:
	lwz 9,8(24)
	mr 3,29
	li 4,3
	la 5,.LC131@l(27)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L549:
	lwz 0,1544(25)
	addi 31,31,1
	addi 30,30,928
	cmpw 0,31,0
	bc 4,1,.L550
.L533:
	lwz 0,2116(1)
	lwz 12,2076(1)
	mtlr 0
	lmw 24,2080(1)
	mtcrf 8,12
	la 1,2112(1)
	blr
.Lfe17:
	.size	 Cmd_Say_f,.Lfe17-Cmd_Say_f
	.section	".rodata"
	.align 2
.LC135:
	.string	"**LEADER (%s)**: "
	.align 2
.LC136:
	.string	"**Teammate (%s)**: "
	.align 2
.LC137:
	.long 0x0
	.align 3
.LC138:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC139:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Cmd_Say_Team_f
	.type	 Cmd_Say_Team_f,@function
Cmd_Say_Team_f:
	stwu 1,-2112(1)
	mflr 0
	stmw 25,2084(1)
	stw 0,2116(1)
	lis 9,gi+156@ha
	mr 30,3
	lwz 0,gi+156@l(9)
	mr 31,5
	mtlr 0
	blrl
	cmpwi 0,3,1
	bc 12,1,.L558
	cmpwi 0,31,0
	bc 12,2,.L557
.L558:
	lis 9,.LC137@ha
	lis 11,leader@ha
	lwz 6,84(30)
	la 9,.LC137@l(9)
	lfs 13,0(9)
	lwz 9,leader@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L560
	lwz 0,4060(6)
	cmpwi 0,0,1
	bc 12,2,.L561
	lwz 0,4064(6)
	cmpwi 0,0,1
	bc 4,2,.L560
.L561:
	lis 5,.LC135@ha
	addi 6,6,700
	la 5,.LC135@l(5)
	addi 3,1,8
	li 4,2048
	crxor 6,6,6
	bl Com_sprintf
	b .L562
.L560:
	lis 5,.LC136@ha
	addi 6,6,700
	la 5,.LC136@l(5)
	addi 3,1,8
	li 4,2048
	crxor 6,6,6
	bl Com_sprintf
.L562:
	cmpwi 0,31,0
	bc 12,2,.L563
	lis 29,gi@ha
	li 3,0
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC127@ha
	addi 3,1,8
	la 4,.LC127@l(4)
	bl strcat
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	b .L564
.L563:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L565
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	stb 31,-1(3)
.L565:
	mr 4,29
	addi 3,1,8
	bl strcat
.L564:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L566
	li 0,0
	stb 0,158(1)
.L566:
	lis 4,.LC128@ha
	addi 3,1,8
	la 4,.LC128@l(4)
	bl strcat
	lis 9,.LC137@ha
	la 9,.LC137@l(9)
	lfs 8,0(9)
	lis 9,flood_msgs@ha
	lwz 11,flood_msgs@l(9)
	lfs 9,20(11)
	fcmpu 0,9,8
	bc 12,2,.L567
	lwz 7,84(30)
	lis 9,level+4@ha
	lfs 10,level+4@l(9)
	lfs 0,3872(7)
	fcmpu 0,10,0
	bc 4,0,.L568
	fsubs 0,0,10
	lis 9,gi+8@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC129@ha
	mr 3,30
	la 5,.LC129@l(5)
	li 4,2
	mtlr 0
	fctiwz 13,0
	stfd 13,2072(1)
	b .L580
.L568:
	lwz 0,3916(7)
	lis 10,0x4330
	lis 11,.LC138@ha
	addi 8,7,3876
	mr 6,0
	la 11,.LC138@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,2076(1)
	lis 11,.LC139@ha
	stw 10,2072(1)
	la 11,.LC139@l(11)
	lfd 0,2072(1)
	mr 10,8
	lfs 11,0(11)
	mr 11,9
	fsub 0,0,13
	frsp 0,0
	fsubs 0,0,9
	fadds 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,2072(1)
	lwz 11,2076(1)
	nor 0,11,11
	addi 9,11,10
	srawi 0,0,31
	andc 9,9,0
	and 11,11,0
	or 11,11,9
	slwi 11,11,2
	lfsx 0,8,11
	fcmpu 0,0,8
	bc 12,2,.L570
	lis 11,flood_persecond@ha
	fsubs 13,10,0
	lwz 9,flood_persecond@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L570
	lis 9,flood_waitdelay@ha
	lis 10,gi+8@ha
	lwz 11,flood_waitdelay@l(9)
	lis 5,.LC130@ha
	mr 3,30
	la 5,.LC130@l(5)
	lfs 13,20(11)
	li 4,3
	fadds 13,10,13
	stfs 13,3872(7)
	lfs 0,20(11)
	lwz 0,gi+8@l(10)
	mtlr 0
	fctiwz 12,0
	stfd 12,2072(1)
.L580:
	lwz 6,2076(1)
	crxor 6,6,6
	blrl
	b .L557
.L570:
	lis 0,0xcccc
	addi 9,6,1
	ori 0,0,52429
	lis 11,level+4@ha
	mulhwu 0,9,0
	srwi 0,0,3
	mulli 0,0,10
	subf 9,0,9
	stw 9,3916(7)
	lfs 0,level+4@l(11)
	slwi 9,9,2
	stfsx 0,10,9
.L567:
	lis 9,.LC137@ha
	lis 11,dedicated@ha
	la 9,.LC137@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L571
	lis 9,gi+8@ha
	lis 5,.LC131@ha
	lwz 0,gi+8@l(9)
	la 5,.LC131@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L571:
	lis 9,game@ha
	li 29,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,29,0
	bc 12,1,.L557
	lis 9,gi@ha
	mr 25,11
	la 26,gi@l(9)
	lis 27,g_edicts@ha
	lis 28,.LC131@ha
	li 31,928
.L575:
	lwz 0,g_edicts@l(27)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L574
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 12,2,.L574
	lwz 9,84(30)
	lwz 11,3532(11)
	lwz 0,3532(9)
	cmpw 0,0,11
	bc 4,2,.L574
	lwz 9,8(26)
	li 4,3
	la 5,.LC131@l(28)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L574:
	lwz 0,1544(25)
	addi 29,29,1
	addi 31,31,928
	cmpw 0,29,0
	bc 4,1,.L575
.L557:
	lwz 0,2116(1)
	mtlr 0
	lmw 25,2084(1)
	la 1,2112(1)
	blr
.Lfe18:
	.size	 Cmd_Say_Team_f,.Lfe18-Cmd_Say_Team_f
	.section	".rodata"
	.align 2
.LC140:
	.string	"%02d:%02d %4d %3d %s%s\n"
	.align 2
.LC141:
	.string	" (spectator)"
	.align 2
.LC142:
	.string	""
	.align 2
.LC143:
	.string	"And more...\n"
	.align 2
.LC144:
	.long 0x0
	.align 3
.LC145:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_PlayerList_f
	.type	 Cmd_PlayerList_f,@function
Cmd_PlayerList_f:
	stwu 1,-1568(1)
	mflr 0
	stmw 20,1520(1)
	stw 0,1572(1)
	lis 9,maxclients@ha
	li 0,0
	lwz 11,maxclients@l(9)
	lis 10,g_edicts@ha
	mr 27,3
	lis 9,.LC144@ha
	stb 0,96(1)
	li 28,0
	la 9,.LC144@l(9)
	lfs 0,20(11)
	lis 22,maxclients@ha
	lfs 13,0(9)
	addi 31,1,96
	lis 21,gi@ha
	lwz 9,g_edicts@l(10)
	lis 20,.LC131@ha
	fcmpu 0,13,0
	addi 30,9,928
	bc 4,0,.L583
	lis 9,.LC141@ha
	lis 11,.LC142@ha
	la 23,.LC141@l(9)
	la 24,.LC142@l(11)
	lis 25,level@ha
	lis 26,0x4330
.L585:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L584
	lwz 10,84(30)
	lis 11,0x1b4e
	lis 8,0x6666
	lwz 9,level@l(25)
	ori 11,11,33205
	ori 8,8,26215
	lwz 0,3524(10)
	addi 29,10,700
	lwz 7,3572(10)
	subf 9,0,9
	lwz 3,184(10)
	mulhw 11,9,11
	lwz 4,3528(10)
	cmpwi 0,7,0
	srawi 10,9,31
	srawi 11,11,6
	subf 6,10,11
	mulli 0,6,600
	subf 9,0,9
	mulhw 8,9,8
	srawi 9,9,31
	srawi 8,8,2
	subf 7,9,8
	bc 12,2,.L587
	stw 23,8(1)
	b .L588
.L587:
	stw 24,8(1)
.L588:
	mr 8,3
	mr 9,4
	lis 5,.LC140@ha
	mr 10,29
	addi 3,1,16
	la 5,.LC140@l(5)
	li 4,80
	crxor 6,6,6
	bl Com_sprintf
	mr 3,31
	bl strlen
	mr 29,3
	addi 3,1,16
	bl strlen
	add 29,29,3
	cmplwi 0,29,1350
	bc 4,1,.L589
	mr 3,31
	bl strlen
	lis 4,.LC143@ha
	add 3,31,3
	la 4,.LC143@l(4)
	crxor 6,6,6
	bl sprintf
	la 9,gi@l(21)
	mr 3,27
	lwz 0,8(9)
	la 5,.LC131@l(20)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L581
.L589:
	mr 3,31
	addi 4,1,16
	bl strcat
.L584:
	addi 28,28,1
	lwz 11,maxclients@l(22)
	xoris 0,28,0x8000
	lis 10,.LC145@ha
	stw 0,1516(1)
	la 10,.LC145@l(10)
	addi 30,30,928
	stw 26,1512(1)
	lfd 13,0(10)
	lfd 0,1512(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L585
.L583:
	lis 9,gi+8@ha
	lis 5,.LC131@ha
	lwz 0,gi+8@l(9)
	mr 3,27
	la 5,.LC131@l(5)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L581:
	lwz 0,1572(1)
	mtlr 0
	lmw 20,1520(1)
	la 1,1568(1)
	blr
.Lfe19:
	.size	 Cmd_PlayerList_f,.Lfe19-Cmd_PlayerList_f
	.section	".rodata"
	.align 2
.LC146:
	.string	"players"
	.align 2
.LC147:
	.string	"say"
	.align 2
.LC148:
	.string	"say_team"
	.align 2
.LC149:
	.string	"score"
	.align 2
.LC150:
	.string	"help"
	.align 2
.LC151:
	.string	"use"
	.align 2
.LC152:
	.string	"drop"
	.align 2
.LC153:
	.string	"give"
	.align 2
.LC154:
	.string	"Hehe, no cheating around here, I can assure you that :^)\n"
	.align 2
.LC155:
	.string	"god"
	.align 2
.LC156:
	.string	"notarget"
	.align 2
.LC157:
	.string	"noclip"
	.align 2
.LC158:
	.string	"inven"
	.align 2
.LC159:
	.string	"invnext"
	.align 2
.LC160:
	.string	"invprev"
	.align 2
.LC161:
	.string	"invnextw"
	.align 2
.LC162:
	.string	"invprevw"
	.align 2
.LC163:
	.string	"invnextp"
	.align 2
.LC164:
	.string	"invprevp"
	.align 2
.LC165:
	.string	"invuse"
	.align 2
.LC166:
	.string	"weapprev"
	.align 2
.LC167:
	.string	"weapnext"
	.align 2
.LC168:
	.string	"weaplast"
	.align 2
.LC169:
	.string	"kill"
	.align 2
.LC170:
	.string	"putaway"
	.align 2
.LC171:
	.string	"wave"
	.align 2
.LC172:
	.string	"reload"
	.align 2
.LC173:
	.string	"opendoor"
	.align 2
.LC174:
	.string	"tq_version"
	.align 2
.LC175:
	.string	"Terror Quake 2\nV. 1.0\n13. May 1999\n"
	.align 2
.LC176:
	.string	"detpack"
	.align 2
.LC178:
	.string	"weapondrop"
	.align 2
.LC179:
	.string	"itemdrop"
	.align 2
.LC180:
	.string	"bandage"
	.align 2
.LC181:
	.string	"specialitem"
	.align 2
.LC182:
	.string	"playerlist"
	.align 3
.LC177:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC183:
	.long 0x0
	.align 2
.LC184:
	.long 0x40a00000
	.align 2
.LC185:
	.long 0x3f800000
	.align 2
.LC186:
	.long 0x447a0000
	.section	".text"
	.align 2
	.globl ClientCommand
	.type	 ClientCommand,@function
ClientCommand:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 24,8(1)
	stw 0,52(1)
	mr 30,3
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L591
	lis 9,gi@ha
	li 3,0
	la 29,gi@l(9)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC146@ha
	la 4,.LC146@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L593
	mr 3,30
	bl Cmd_Players_f
	b .L591
.L593:
	lis 4,.LC147@ha
	mr 3,31
	la 4,.LC147@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L594
	mr 3,30
	li 4,0
	li 5,0
	bl Cmd_Say_f
	b .L591
.L594:
	lis 4,.LC148@ha
	mr 3,31
	la 4,.LC148@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L595
	mr 3,30
	li 4,1
	li 5,0
	bl Cmd_Say_Team_f
	b .L591
.L595:
	lis 4,.LC149@ha
	mr 3,31
	la 4,.LC149@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L596
	mr 3,30
	bl Cmd_Score_f
	b .L591
.L596:
	lis 4,.LC150@ha
	mr 3,31
	la 4,.LC150@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L597
	mr 3,30
	bl Cmd_Help_f
	b .L591
.L597:
	lis 8,.LC183@ha
	lis 9,level+200@ha
	la 8,.LC183@l(8)
	lfs 0,level+200@l(9)
	lfs 31,0(8)
	fcmpu 0,0,31
	bc 4,2,.L591
	lis 4,.LC151@ha
	mr 3,31
	la 4,.LC151@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L599
	mr 3,30
	bl Cmd_Use_f
	b .L591
.L599:
	lis 4,.LC152@ha
	mr 3,31
	la 4,.LC152@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L601
	mr 3,30
	bl Cmd_Drop_f
	b .L591
.L601:
	lis 4,.LC153@ha
	mr 3,31
	la 4,.LC153@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L603
	lwz 0,8(29)
	lis 5,.LC154@ha
	mr 3,30
	la 5,.LC154@l(5)
	b .L818
.L603:
	lis 4,.LC155@ha
	mr 3,31
	la 4,.LC155@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L605
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L606
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L606
	lwz 0,8(29)
	lis 5,.LC49@ha
	mr 3,30
	la 5,.LC49@l(5)
	b .L818
.L606:
	lwz 0,264(30)
	xori 0,0,16
	andi. 8,0,16
	stw 0,264(30)
	bc 4,2,.L608
	lis 9,.LC62@ha
	la 5,.LC62@l(9)
	b .L621
.L608:
	lis 9,.LC63@ha
	la 5,.LC63@l(9)
	b .L621
.L605:
	lis 4,.LC156@ha
	mr 3,31
	la 4,.LC156@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L611
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L612
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L612
	lwz 0,8(29)
	lis 5,.LC49@ha
	mr 3,30
	la 5,.LC49@l(5)
	b .L818
.L612:
	lwz 0,264(30)
	xori 0,0,32
	andi. 8,0,32
	stw 0,264(30)
	bc 4,2,.L614
	lis 9,.LC64@ha
	la 5,.LC64@l(9)
	b .L621
.L614:
	lis 9,.LC65@ha
	la 5,.LC65@l(9)
	b .L621
.L611:
	lis 4,.LC157@ha
	mr 3,31
	la 4,.LC157@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L617
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L618
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L618
	lis 9,gi+8@ha
	lis 5,.LC49@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC49@l(5)
	b .L818
.L618:
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 4,2,.L620
	li 0,4
	lis 9,.LC66@ha
	stw 0,260(30)
	la 5,.LC66@l(9)
	b .L621
.L620:
	li 0,1
	lis 9,.LC67@ha
	stw 0,260(30)
	la 5,.LC67@l(9)
.L621:
	lis 9,gi+8@ha
	mr 3,30
	lwz 0,gi+8@l(9)
.L818:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L591
.L617:
	lis 4,.LC158@ha
	mr 3,31
	la 4,.LC158@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L623
	lwz 31,84(30)
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	stw 3,3632(31)
	stw 3,3616(31)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L624
	lwz 0,3532(31)
	cmpwi 0,0,0
	bc 4,2,.L624
	mr 3,30
	bl CTFOpenJoinMenu
	b .L591
.L624:
	lwz 9,84(30)
	lwz 9,3624(9)
	cmpwi 0,9,0
	bc 12,2,.L626
	mr 3,30
	bl PMenu_Close
	b .L742
.L626:
	lwz 0,3628(31)
	cmpwi 0,0,0
	bc 12,2,.L627
	stw 9,3628(31)
	b .L591
.L627:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3628(31)
	li 3,5
	lwz 0,100(9)
	mr 27,9
	addi 28,31,1760
	addi 29,31,740
	mtlr 0
	blrl
.L630:
	lwz 9,104(27)
	lwz 3,0(29)
	mtlr 9
	addi 29,29,4
	blrl
	cmpw 0,29,28
	bc 4,1,.L630
	lis 9,gi+92@ha
	mr 3,30
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L591
.L623:
	lis 4,.LC159@ha
	mr 3,31
	la 4,.LC159@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L634
	lwz 10,84(30)
	lwz 0,3624(10)
	cmpwi 0,0,0
	bc 4,2,.L819
	lwz 0,3924(10)
	cmpwi 0,0,0
	bc 4,2,.L820
	li 0,256
	lwz 6,736(10)
	li 8,1
	mtctr 0
	addi 7,10,740
.L817:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 4,2,.L808
	addi 8,8,1
	bdnz .L817
	b .L821
.L634:
	lis 4,.LC160@ha
	mr 3,31
	la 4,.LC160@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L645
	lwz 8,84(30)
	lwz 0,3624(8)
	cmpwi 0,0,0
	bc 4,2,.L822
	lwz 0,3924(8)
	cmpwi 0,0,0
	bc 4,2,.L823
	li 0,256
	lwz 9,736(8)
	addi 7,8,740
	mtctr 0
	addi 11,9,255
.L816:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 10,0,11
	slwi 9,10,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 4,2,.L809
	addi 11,11,-1
	bdnz .L816
	b .L824
.L645:
	lis 4,.LC161@ha
	mr 3,31
	la 4,.LC161@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L656
	lwz 10,84(30)
	lwz 0,3624(10)
	cmpwi 0,0,0
	bc 4,2,.L819
	lwz 0,3924(10)
	cmpwi 0,0,0
	bc 4,2,.L820
	li 0,256
	lwz 6,736(10)
	li 8,1
	mtctr 0
	addi 7,10,740
.L815:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 4,2,.L808
	addi 8,8,1
	bdnz .L815
	b .L821
.L656:
	lis 4,.LC162@ha
	mr 3,31
	la 4,.LC162@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L667
	lwz 8,84(30)
	lwz 0,3624(8)
	cmpwi 0,0,0
	bc 4,2,.L822
	lwz 0,3924(8)
	cmpwi 0,0,0
	bc 4,2,.L823
	li 0,256
	lwz 9,736(8)
	addi 7,8,740
	mtctr 0
	addi 11,9,255
.L814:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 10,0,11
	slwi 9,10,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 4,2,.L809
	addi 11,11,-1
	bdnz .L814
	b .L824
.L667:
	lis 4,.LC163@ha
	mr 3,31
	la 4,.LC163@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L678
	lwz 10,84(30)
	lwz 0,3624(10)
	cmpwi 0,0,0
	bc 4,2,.L819
	lwz 0,3924(10)
	cmpwi 0,0,0
	bc 4,2,.L820
	li 0,256
	lwz 6,736(10)
	li 8,1
	mtctr 0
	addi 7,10,740
.L813:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 4,2,.L808
	addi 8,8,1
	bdnz .L813
.L821:
	li 0,-1
	stw 0,736(10)
	b .L591
.L678:
	lis 4,.LC164@ha
	mr 3,31
	la 4,.LC164@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L689
	lwz 8,84(30)
	lwz 0,3624(8)
	cmpwi 0,0,0
	bc 12,2,.L690
.L822:
	mr 3,30
	bl PMenu_Prev
	b .L591
.L690:
	lwz 0,3924(8)
	cmpwi 0,0,0
	bc 12,2,.L692
.L823:
	mr 3,30
	bl ChasePrev
	b .L591
.L692:
	li 0,256
	lwz 9,736(8)
	addi 7,8,740
	mtctr 0
	addi 11,9,255
.L812:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 10,0,11
	slwi 9,10,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 4,2,.L809
	addi 11,11,-1
	bdnz .L812
.L824:
	li 0,-1
	stw 0,736(8)
	b .L591
.L689:
	lis 4,.LC165@ha
	mr 3,31
	la 4,.LC165@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L778
	lis 4,.LC166@ha
	mr 3,31
	la 4,.LC166@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L702
	lwz 28,84(30)
	lwz 11,1824(28)
	cmpwi 0,11,0
	bc 12,2,.L591
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 31,1
	subf 9,9,11
	addi 26,28,740
	mullw 9,9,0
	srawi 27,9,2
.L707:
	add 11,27,31
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L709
	mulli 0,11,76
	add 29,0,25
	lwz 9,8(29)
	cmpwi 0,9,0
	bc 12,2,.L709
	lwz 0,56(29)
	andi. 8,0,1
	bc 12,2,.L709
	mr 3,30
	mr 4,29
	mtlr 9
	blrl
	lwz 0,1824(28)
	cmpw 0,0,29
	bc 12,2,.L591
.L709:
	addi 31,31,1
	cmpwi 0,31,256
	bc 4,1,.L707
	b .L591
.L702:
	lis 4,.LC167@ha
	mr 3,31
	la 4,.LC167@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L715
	lwz 28,84(30)
	lwz 11,1824(28)
	cmpwi 0,11,0
	bc 12,2,.L591
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 27,1
	subf 9,9,11
	addi 26,28,740
	mullw 9,9,0
	srawi 9,9,2
	addi 31,9,255
.L720:
	srawi 0,31,31
	srwi 0,0,24
	add 0,31,0
	rlwinm 0,0,0,0,23
	subf 11,0,31
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L722
	mulli 0,11,76
	add 29,0,25
	lwz 9,8(29)
	cmpwi 0,9,0
	bc 12,2,.L722
	lwz 0,56(29)
	andi. 8,0,1
	bc 12,2,.L722
	mr 3,30
	mr 4,29
	mtlr 9
	blrl
	lwz 0,1824(28)
	cmpw 0,0,29
	bc 12,2,.L591
.L722:
	addi 27,27,1
	addi 31,31,-1
	cmpwi 0,27,256
	bc 4,1,.L720
	b .L591
.L715:
	lis 4,.LC168@ha
	mr 3,31
	la 4,.LC168@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L728
	lwz 10,84(30)
	lwz 0,1824(10)
	cmpwi 0,0,0
	bc 12,2,.L591
	lwz 0,1828(10)
	cmpwi 0,0,0
	bc 12,2,.L591
	lis 11,itemlist@ha
	lis 9,0x286b
	la 4,itemlist@l(11)
	ori 9,9,51739
	subf 0,4,0
	addi 11,10,740
	mullw 0,0,9
	srawi 10,0,2
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L591
	mulli 0,10,76
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L591
	lwz 0,56(4)
	andi. 8,0,1
	bc 12,2,.L591
	mr 3,30
	mtlr 9
	blrl
	b .L591
.L728:
	lis 4,.LC169@ha
	mr 3,31
	la 4,.LC169@l(4)
	bl Q_stricmp
	mr. 10,3
	bc 4,2,.L736
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 12,2,.L591
	lwz 11,84(30)
	lis 9,level+4@ha
	lis 8,.LC184@ha
	lfs 0,level+4@l(9)
	la 8,.LC184@l(8)
	lfs 13,3920(11)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L591
	lwz 0,264(30)
	mr 3,30
	lis 11,meansOfDeath@ha
	stw 10,480(30)
	li 9,23
	lis 6,0x1
	rlwinm 0,0,0,28,26
	lis 7,vec3_origin@ha
	stw 0,264(30)
	la 7,vec3_origin@l(7)
	mr 4,3
	stw 9,meansOfDeath@l(11)
	mr 5,3
	ori 6,6,34464
	bl player_die
	b .L591
.L736:
	lis 4,.LC170@ha
	mr 3,31
	la 4,.LC170@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L741
	lwz 9,84(30)
	stw 3,3616(9)
	lwz 11,84(30)
	stw 3,3632(11)
	lwz 9,84(30)
	stw 3,3628(9)
	lwz 11,84(30)
	lwz 0,3624(11)
	cmpwi 0,0,0
	bc 12,2,.L742
	mr 3,30
	bl PMenu_Close
.L742:
	lwz 9,84(30)
	li 0,1
	stw 0,3928(9)
	b .L591
.L741:
	lis 4,.LC171@ha
	mr 3,31
	la 4,.LC171@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L745
	mr 3,30
	bl Cmd_Wave_f
	b .L591
.L745:
	lis 4,.LC172@ha
	mr 3,31
	la 4,.LC172@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L747
	mr 3,30
	bl Cmd_Reload_f
	b .L591
.L747:
	lis 4,.LC173@ha
	mr 3,31
	la 4,.LC173@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L749
	lwz 9,84(30)
	li 0,1
	stw 0,3956(9)
	b .L591
.L749:
	lis 4,.LC174@ha
	mr 3,31
	la 4,.LC174@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L752
	lis 9,gi+12@ha
	lis 4,.LC175@ha
	lwz 0,gi+12@l(9)
	mr 3,30
	la 4,.LC175@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L591
.L752:
	lis 4,.LC176@ha
	mr 3,31
	la 4,.LC176@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L754
	li 31,0
	addi 28,30,4
	b .L755
.L757:
	lwz 3,280(31)
	lis 4,.LC44@ha
	la 4,.LC44@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L755
	lwz 0,256(31)
	cmpw 0,0,30
	bc 4,2,.L755
	lis 29,gi@ha
	lis 3,.LC45@ha
	la 29,gi@l(29)
	la 3,.LC45@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC185@ha
	lis 9,.LC185@ha
	lis 11,.LC183@ha
	la 9,.LC185@l(9)
	la 11,.LC183@l(11)
	mr 5,3
	lfs 2,0(9)
	mtlr 0
	la 8,.LC185@l(8)
	lfs 3,0(11)
	li 4,2
	mr 3,30
	lfs 1,0(8)
	blrl
	lis 9,Grenade_Explode@ha
	lis 10,level+4@ha
	la 9,Grenade_Explode@l(9)
	lis 11,.LC177@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC177@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L755:
	lis 8,.LC186@ha
	mr 3,31
	la 8,.LC186@l(8)
	mr 4,28
	lfs 1,0(8)
	bl findradius
	mr. 31,3
	bc 4,2,.L757
	b .L591
.L754:
	lis 4,.LC74@ha
	mr 3,31
	la 4,.LC74@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L762
	mr 3,30
	bl Cmd_InfraRed_f
	b .L591
.L762:
	lis 4,.LC178@ha
	mr 3,31
	la 4,.LC178@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L764
	lwz 9,84(30)
	lwz 0,3696(9)
	cmpwi 0,0,0
	bc 4,2,.L591
	mr 3,30
	bl Cmd_Drop_Weapon_f
	b .L591
.L764:
	lis 4,.LC179@ha
	mr 3,31
	la 4,.LC179@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L767
	mr 3,30
	bl Cmd_Drop_Item_f
	b .L591
.L767:
	lis 4,.LC180@ha
	mr 3,31
	la 4,.LC180@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L769
	mr 3,30
	bl Cmd_Bandage_f
	b .L591
.L769:
	lis 4,.LC73@ha
	mr 3,31
	la 4,.LC73@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L771
	lwz 31,84(30)
	lwz 0,3696(31)
	cmpwi 0,0,0
	bc 12,2,.L773
	cmpwi 0,0,3
	bc 4,2,.L591
	lis 3,.LC37@ha
	la 3,.LC37@l(3)
	bl FindItem
	lwz 0,1824(31)
	cmpw 0,0,3
	bc 4,2,.L591
.L773:
	mr 3,30
	bl Cmd_Zoom_f
	b .L591
.L771:
	lis 4,.LC68@ha
	mr 3,31
	la 4,.LC68@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L775
	lwz 8,84(30)
	lwz 0,3696(8)
	cmpwi 0,0,0
	bc 4,2,.L591
	lwz 0,3624(8)
	cmpwi 0,0,0
	bc 12,2,.L777
	mr 3,30
	bl PMenu_Next
	b .L778
.L777:
	lwz 0,3924(8)
	cmpwi 0,0,0
	bc 12,2,.L779
	mr 3,30
	bl ChaseNext
	b .L778
.L810:
	stw 11,736(8)
	b .L778
.L779:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	lis 11,Pickup_Weapon@ha
	la 3,itemlist@l(9)
	la 4,Pickup_Weapon@l(11)
	li 7,1
	addi 6,8,740
.L811:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L784
	mulli 0,11,76
	add 10,0,3
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L784
	lwz 0,4(10)
	cmpw 0,0,4
	bc 12,2,.L810
.L784:
	addi 7,7,1
	bdnz .L811
	li 0,-1
	stw 0,736(8)
.L778:
	mr 3,30
	bl Cmd_InvUse_f
	b .L591
.L775:
	lis 4,.LC181@ha
	mr 3,31
	la 4,.LC181@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L789
	lwz 28,84(30)
	lwz 0,3624(28)
	cmpwi 0,0,0
	bc 12,2,.L790
.L819:
	mr 3,30
	bl PMenu_Next
	b .L591
.L790:
	lwz 0,3924(28)
	cmpwi 0,0,0
	bc 12,2,.L792
.L820:
	mr 3,30
	bl ChaseNext
	b .L591
.L792:
	lis 9,itemlist@ha
	lis 11,Drop_SpecialItem@ha
	la 24,itemlist@l(9)
	la 25,Drop_SpecialItem@l(11)
	li 30,1
	addi 27,28,740
	lis 26,.LC48@ha
.L795:
	lwz 11,736(28)
	add 11,11,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 31,0,11
	slwi 9,31,2
	lwzx 0,27,9
	cmpwi 0,0,0
	bc 12,2,.L797
	mulli 0,31,76
	la 3,.LC48@l(26)
	add 29,0,24
	bl FindItem
	cmpw 0,29,3
	bc 12,2,.L798
	lwz 0,12(29)
	cmpw 0,0,25
	bc 4,2,.L797
.L798:
	stw 31,736(28)
	b .L591
.L797:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L795
	li 0,-1
	stw 0,736(28)
	b .L591
.L789:
	lis 4,.LC182@ha
	mr 3,31
	la 4,.LC182@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L802
	mr 3,30
	bl Cmd_PlayerList_f
	b .L591
.L808:
	stw 11,736(10)
	b .L591
.L809:
	stw 10,736(8)
	b .L591
.L802:
	mr 3,30
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L591:
	lwz 0,52(1)
	mtlr 0
	lmw 24,8(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe20:
	.size	 ClientCommand,.Lfe20-ClientCommand
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_UZIclip,4,4
	.comm	item_9mm,4,4
	.comm	item_1911rounds,4,4
	.comm	item_50cal,4,4
	.comm	item_MARINERrounds,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_sshotgun,4,4
	.comm	item_handgrenade,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.align 2
	.globl ValidateSelectedItem
	.type	 ValidateSelectedItem,@function
ValidateSelectedItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 8,84(3)
	lwz 11,736(8)
	addi 10,8,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L175
	lwz 0,3624(8)
	cmpwi 0,0,0
	bc 12,2,.L177
	bl PMenu_Next
	b .L175
.L177:
	lwz 0,3924(8)
	cmpwi 0,0,0
	bc 12,2,.L179
	bl ChaseNext
	b .L175
.L825:
	stw 11,736(8)
	b .L175
.L179:
	li 0,256
	mr 7,10
	mtctr 0
	mr 6,11
	li 10,1
.L826:
	add 11,6,10
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 4,2,.L825
	addi 10,10,1
	bdnz .L826
	li 0,-1
	stw 0,736(8)
.L175:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 ValidateSelectedItem,.Lfe21-ValidateSelectedItem
	.comm	ctfgame,24,4
	.comm	enemies,4,4
	.comm	spawned,4,4
	.comm	lms_round,4,4
	.comm	terror_l,4,4
	.comm	swat_l,4,4
	.comm	lms_delay,4,4
	.comm	lms_delay2,4,4
	.comm	lms_players,4,4
	.comm	lms_dead_players,4,4
	.comm	lms_alive_players,4,4
	.comm	lms_round_over,4,4
	.section	".rodata"
	.align 3
.LC187:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC188:
	.long 0x3f800000
	.align 2
.LC189:
	.long 0x0
	.align 2
.LC190:
	.long 0x447a0000
	.section	".text"
	.align 2
	.globl Cmd_Detpack_f
	.type	 Cmd_Detpack_f,@function
Cmd_Detpack_f:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 25,12(1)
	stw 0,52(1)
	lis 9,.LC187@ha
	lis 11,gi@ha
	lfd 31,.LC187@l(9)
	la 29,gi@l(11)
	mr 30,3
	lis 9,Grenade_Explode@ha
	lis 11,level@ha
	la 25,Grenade_Explode@l(9)
	la 26,level@l(11)
	li 31,0
	lis 27,.LC44@ha
	lis 28,.LC45@ha
	b .L109
.L111:
	lwz 3,280(31)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L109
	lwz 0,256(31)
	la 3,.LC45@l(28)
	cmpw 0,0,30
	bc 4,2,.L109
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC188@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC188@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,30
	mtlr 11
	lis 9,.LC188@ha
	la 9,.LC188@l(9)
	lfs 2,0(9)
	lis 9,.LC189@ha
	la 9,.LC189@l(9)
	lfs 3,0(9)
	blrl
	stw 25,436(31)
	lfs 0,4(26)
	fadd 0,0,31
	frsp 0,0
	stfs 0,428(31)
.L109:
	lis 9,.LC190@ha
	mr 3,31
	la 9,.LC190@l(9)
	addi 4,30,4
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	la 4,.LC44@l(27)
	bc 4,2,.L111
	lwz 0,52(1)
	mtlr 0
	lmw 25,12(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe22:
	.size	 Cmd_Detpack_f,.Lfe22-Cmd_Detpack_f
	.align 2
	.globl ClientTeam
	.type	 ClientTeam,@function
ClientTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 9,value.36@ha
	li 30,0
	stb 30,value.36@l(9)
	la 31,value.36@l(9)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L828
	lis 4,.LC47@ha
	addi 3,3,188
	la 4,.LC47@l(4)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl strcpy
	mr 3,31
	li 4,47
	bl strchr
	mr. 3,3
	bc 12,2,.L828
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,128
	bc 4,2,.L118
	addi 3,3,1
	b .L827
.L118:
	stb 30,0(3)
.L828:
	mr 3,31
.L827:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 ClientTeam,.Lfe23-ClientTeam
	.align 2
	.globl SelectNextSpecial
	.type	 SelectNextSpecial,@function
SelectNextSpecial:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 8,84(3)
	lwz 0,3624(8)
	cmpwi 0,0,0
	bc 12,2,.L136
	bl PMenu_Next
	b .L135
.L136:
	lwz 0,3924(8)
	cmpwi 0,0,0
	bc 12,2,.L137
	bl ChaseNext
	b .L135
.L829:
	stw 11,736(8)
	b .L135
.L137:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	lis 11,Pickup_Weapon@ha
	la 3,itemlist@l(9)
	la 4,Pickup_Weapon@l(11)
	li 7,1
	addi 6,8,740
.L830:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L140
	mulli 0,11,76
	add 10,0,3
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L140
	lwz 0,4(10)
	cmpw 0,0,4
	bc 12,2,.L829
.L140:
	addi 7,7,1
	bdnz .L830
	li 0,-1
	stw 0,736(8)
.L135:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe24:
	.size	 SelectNextSpecial,.Lfe24-SelectNextSpecial
	.align 2
	.globl SelectNextSpecialItem
	.type	 SelectNextSpecialItem,@function
SelectNextSpecialItem:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lwz 29,84(3)
	lwz 0,3624(29)
	cmpwi 0,0,0
	bc 12,2,.L147
	bl PMenu_Next
	b .L146
.L147:
	lwz 0,3924(29)
	cmpwi 0,0,0
	bc 12,2,.L148
	bl ChaseNext
	b .L146
.L148:
	lis 9,itemlist@ha
	lis 11,Drop_SpecialItem@ha
	la 24,itemlist@l(9)
	la 25,Drop_SpecialItem@l(11)
	li 28,1
	addi 27,29,740
	lis 26,.LC48@ha
.L152:
	lwz 11,736(29)
	add 11,11,28
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 30,0,11
	slwi 9,30,2
	lwzx 0,27,9
	cmpwi 0,0,0
	bc 12,2,.L151
	mulli 0,30,76
	la 3,.LC48@l(26)
	add 31,0,24
	bl FindItem
	cmpw 0,31,3
	bc 12,2,.L154
	lwz 0,12(31)
	cmpw 0,0,25
	bc 4,2,.L151
.L154:
	stw 30,736(29)
	b .L146
.L151:
	addi 28,28,1
	cmpwi 0,28,256
	bc 4,1,.L152
	li 0,-1
	stw 0,736(29)
.L146:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe25:
	.size	 SelectNextSpecialItem,.Lfe25-SelectNextSpecialItem
	.align 2
	.globl SelectNextItem
	.type	 SelectNextItem,@function
SelectNextItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 10,84(3)
	lwz 0,3624(10)
	cmpwi 0,0,0
	bc 12,2,.L158
	bl PMenu_Next
	b .L157
.L158:
	lwz 0,3924(10)
	cmpwi 0,0,0
	bc 12,2,.L159
	bl ChaseNext
	b .L157
.L831:
	stw 11,736(10)
	b .L157
.L159:
	li 0,256
	lwz 6,736(10)
	li 8,1
	mtctr 0
	addi 7,10,740
.L832:
	add 11,6,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 4,2,.L831
	addi 8,8,1
	bdnz .L832
	li 0,-1
	stw 0,736(10)
.L157:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe26:
	.size	 SelectNextItem,.Lfe26-SelectNextItem
	.align 2
	.globl SelectPrevItem
	.type	 SelectPrevItem,@function
SelectPrevItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 8,84(3)
	lwz 0,3624(8)
	cmpwi 0,0,0
	bc 12,2,.L167
	bl PMenu_Prev
	b .L166
.L167:
	lwz 0,3924(8)
	cmpwi 0,0,0
	bc 12,2,.L168
	bl ChasePrev
	b .L166
.L833:
	stw 10,736(8)
	b .L166
.L168:
	li 0,256
	lwz 9,736(8)
	addi 7,8,740
	mtctr 0
	addi 11,9,255
.L834:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 10,0,11
	slwi 9,10,2
	lwzx 0,7,9
	cmpwi 0,0,0
	bc 4,2,.L833
	addi 11,11,-1
	bdnz .L834
	li 0,-1
	stw 0,736(8)
.L166:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe27:
	.size	 SelectPrevItem,.Lfe27-SelectPrevItem
	.section	".rodata"
	.align 2
.LC191:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC191@ha
	lis 9,deathmatch@ha
	la 11,.LC191@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L240
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L240
	lis 9,gi+8@ha
	lis 5,.LC49@ha
	lwz 0,gi+8@l(9)
	la 5,.LC49@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L239
.L240:
	lwz 0,264(3)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(3)
	bc 4,2,.L241
	lis 9,.LC62@ha
	la 5,.LC62@l(9)
	b .L242
.L241:
	lis 9,.LC63@ha
	la 5,.LC63@l(9)
.L242:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L239:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 Cmd_God_f,.Lfe28-Cmd_God_f
	.section	".rodata"
	.align 2
.LC192:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC192@ha
	lis 9,deathmatch@ha
	la 11,.LC192@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L244
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L244
	lis 9,gi+8@ha
	lis 5,.LC49@ha
	lwz 0,gi+8@l(9)
	la 5,.LC49@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L243
.L244:
	lwz 0,264(3)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(3)
	bc 4,2,.L245
	lis 9,.LC64@ha
	la 5,.LC64@l(9)
	b .L246
.L245:
	lis 9,.LC65@ha
	la 5,.LC65@l(9)
.L246:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L243:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 Cmd_Notarget_f,.Lfe29-Cmd_Notarget_f
	.section	".rodata"
	.align 2
.LC193:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC193@ha
	lis 9,deathmatch@ha
	la 11,.LC193@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L248
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L248
	lis 9,gi+8@ha
	lis 5,.LC49@ha
	lwz 0,gi+8@l(9)
	la 5,.LC49@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L247
.L248:
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 4,2,.L249
	li 0,4
	lis 9,.LC66@ha
	stw 0,260(3)
	la 5,.LC66@l(9)
	b .L250
.L249:
	li 0,1
	lis 9,.LC67@ha
	stw 0,260(3)
	la 5,.LC67@l(9)
.L250:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L247:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 Cmd_Noclip_f,.Lfe30-Cmd_Noclip_f
	.section	".rodata"
	.align 2
.LC194:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Inven_f
	.type	 Cmd_Inven_f,@function
Cmd_Inven_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,.LC194@ha
	mr 30,3
	la 9,.LC194@l(9)
	lwz 31,84(30)
	lis 11,ctf@ha
	lfs 13,0(9)
	li 0,0
	lwz 9,ctf@l(11)
	stw 0,3632(31)
	stw 0,3616(31)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L334
	lwz 0,3532(31)
	cmpwi 0,0,0
	bc 4,2,.L334
	bl CTFOpenJoinMenu
	b .L333
.L334:
	lwz 9,84(30)
	lwz 9,3624(9)
	cmpwi 0,9,0
	bc 12,2,.L335
	mr 3,30
	bl PMenu_Close
	lwz 9,84(30)
	li 0,1
	stw 0,3928(9)
	b .L333
.L335:
	lwz 0,3628(31)
	cmpwi 0,0,0
	bc 12,2,.L336
	stw 9,3628(31)
	b .L333
.L336:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3628(31)
	li 3,5
	lwz 0,100(9)
	addi 29,31,1760
	mr 28,9
	addi 31,31,740
	mtlr 0
	blrl
.L340:
	lwz 9,104(28)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,29
	bc 4,1,.L340
	lis 9,gi+92@ha
	mr 3,30
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L333:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe31:
	.size	 Cmd_Inven_f,.Lfe31-Cmd_Inven_f
	.align 2
	.globl Cmd_WeapPrev_f
	.type	 Cmd_WeapPrev_f,@function
Cmd_WeapPrev_f:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 28,3
	lwz 29,84(28)
	lwz 11,1824(29)
	cmpwi 0,11,0
	bc 12,2,.L454
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,29,740
	mullw 9,9,0
	srawi 27,9,2
.L459:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L458
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L458
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L458
	mr 3,28
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1824(29)
	cmpw 0,0,31
	bc 12,2,.L454
.L458:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L459
.L454:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe32:
	.size	 Cmd_WeapPrev_f,.Lfe32-Cmd_WeapPrev_f
	.align 2
	.globl Cmd_WeapNext_f
	.type	 Cmd_WeapNext_f,@function
Cmd_WeapNext_f:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 27,3
	lwz 29,84(27)
	lwz 11,1824(29)
	cmpwi 0,11,0
	bc 12,2,.L465
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 28,1
	subf 9,9,11
	addi 26,29,740
	mullw 9,9,0
	srawi 9,9,2
	addi 30,9,255
.L470:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L469
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L469
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L469
	mr 3,27
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1824(29)
	cmpw 0,0,31
	bc 12,2,.L465
.L469:
	addi 28,28,1
	addi 30,30,-1
	cmpwi 0,28,256
	bc 4,1,.L470
.L465:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe33:
	.size	 Cmd_WeapNext_f,.Lfe33-Cmd_WeapNext_f
	.align 2
	.globl Cmd_WeapLast_f
	.type	 Cmd_WeapLast_f,@function
Cmd_WeapLast_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 10,84(3)
	lwz 0,1824(10)
	cmpwi 0,0,0
	bc 12,2,.L476
	lwz 0,1828(10)
	cmpwi 0,0,0
	bc 12,2,.L476
	lis 11,itemlist@ha
	lis 9,0x286b
	la 4,itemlist@l(11)
	ori 9,9,51739
	subf 0,4,0
	addi 11,10,740
	mullw 0,0,9
	srawi 10,0,2
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L476
	mulli 0,10,76
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L476
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L476
	mtlr 9
	blrl
.L476:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe34:
	.size	 Cmd_WeapLast_f,.Lfe34-Cmd_WeapLast_f
	.section	".rodata"
	.align 2
.LC195:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Cmd_Kill_f
	.type	 Cmd_Kill_f,@function
Cmd_Kill_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	lwz 0,248(10)
	cmpwi 0,0,0
	bc 12,2,.L500
	lwz 11,84(10)
	lis 9,level+4@ha
	lis 8,.LC195@ha
	lfs 0,level+4@l(9)
	la 8,.LC195@l(8)
	lfs 13,3920(11)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L500
	lwz 0,264(10)
	li 9,0
	stw 9,480(10)
	lis 11,meansOfDeath@ha
	lis 6,0x1
	rlwinm 0,0,0,28,26
	li 9,23
	stw 0,264(10)
	lis 7,vec3_origin@ha
	mr 4,3
	stw 9,meansOfDeath@l(11)
	la 7,vec3_origin@l(7)
	mr 5,3
	ori 6,6,34464
	bl player_die
.L500:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe35:
	.size	 Cmd_Kill_f,.Lfe35-Cmd_Kill_f
	.align 2
	.globl Cmd_PutAway_f
	.type	 Cmd_PutAway_f,@function
Cmd_PutAway_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	li 0,0
	lwz 9,84(31)
	stw 0,3616(9)
	lwz 11,84(31)
	stw 0,3632(11)
	lwz 9,84(31)
	stw 0,3628(9)
	lwz 11,84(31)
	lwz 0,3624(11)
	cmpwi 0,0,0
	bc 12,2,.L504
	bl PMenu_Close
.L504:
	lwz 9,84(31)
	li 0,1
	stw 0,3928(9)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe36:
	.size	 Cmd_PutAway_f,.Lfe36-Cmd_PutAway_f
	.align 2
	.globl PlayerSort
	.type	 PlayerSort,@function
PlayerSort:
	lwz 9,0(3)
	lis 11,game+1028@ha
	lwz 3,0(4)
	lwz 0,game+1028@l(11)
	mulli 9,9,4080
	mulli 11,3,4080
	add 9,9,0
	add 11,11,0
	lha 9,148(9)
	lha 3,148(11)
	cmpw 0,9,3
	li 3,-1
	bclr 12,0
	mfcr 3
	rlwinm 3,3,2,1
	blr
.Lfe37:
	.size	 PlayerSort,.Lfe37-PlayerSort
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
