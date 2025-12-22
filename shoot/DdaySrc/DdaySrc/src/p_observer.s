	.file	"p_observer.c"
gcc2_compiled.:
	.globl menu_teams
	.section	".data"
	.align 2
	.type	 menu_teams,@object
menu_teams:
	.long .LC0
	.long 1
	.long 0
	.long 0
	.long .LC1
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC2
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long M_Team_Join
	.long 0
	.long 0
	.long 0
	.long M_Team_Join
	.long 0
	.long 2
	.long 0
	.long 0
	.long .LC3
	.long 0
	.long 0
	.long M_Team_Join
	.long 0
	.long 2
	.long 0
	.long 0
	.long .LC4
	.long 2
	.long 0
	.long M_Main_Menu
	.section	".rodata"
	.align 2
.LC4:
	.string	"Main Menu"
	.align 2
.LC3:
	.string	"Auto Select"
	.align 2
.LC2:
	.string	"*Choose Team"
	.align 2
.LC1:
	.string	"*by Vipersoft"
	.align 2
.LC0:
	.string	"*D-DAY: NORMANDY"
	.size	 menu_teams,176
	.globl menu_classes
	.section	".data"
	.align 2
	.type	 menu_classes,@object
menu_classes:
	.long .LC0
	.long 1
	.long 0
	.long 0
	.long .LC1
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC5
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long M_MOS_Join
	.long 0
	.long 0
	.long 0
	.long M_MOS_Join
	.long 0
	.long 0
	.long 0
	.long M_MOS_Join
	.long 0
	.long 0
	.long 0
	.long M_MOS_Join
	.long 0
	.long 0
	.long 0
	.long M_MOS_Join
	.long 0
	.long 0
	.long 0
	.long M_MOS_Join
	.long 0
	.long 0
	.long 0
	.long M_MOS_Join
	.long 0
	.long 0
	.long 0
	.long M_MOS_Join
	.long 0
	.long 0
	.long 0
	.long M_MOS_Join
	.long 0
	.long 2
	.long 0
	.long 0
	.long .LC4
	.long 2
	.long 0
	.long M_Main_Menu
	.section	".rodata"
	.align 2
.LC5:
	.string	"Choose A Class"
	.size	 menu_classes,256
	.globl menu_credits
	.section	".data"
	.align 2
	.type	 menu_credits,@object
menu_credits:
	.long .LC0
	.long 1
	.long 0
	.long 0
	.long .LC1
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC6
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC7
	.long 1
	.long 0
	.long 0
	.long .LC8
	.long 1
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC9
	.long 1
	.long 0
	.long 0
	.long .LC10
	.long 1
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC11
	.long 1
	.long 0
	.long 0
	.long .LC12
	.long 1
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC13
	.long 1
	.long 0
	.long 0
	.long .LC14
	.long 1
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC15
	.long 1
	.long 0
	.long 0
	.long .LC16
	.long 1
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC4
	.long 1
	.long 0
	.long M_Main_Menu
	.section	".rodata"
	.align 2
.LC16:
	.string	"*Oliver 'JumperDude' Snavely"
	.align 2
.LC15:
	.string	"Sound Engineer"
	.align 2
.LC14:
	.string	"*Darwin Allen"
	.align 2
.LC13:
	.string	"Visual Artist"
	.align 2
.LC12:
	.string	"*Peter 'Castrator' Lipman"
	.align 2
.LC11:
	.string	"Level Design"
	.align 2
.LC10:
	.string	"*Phil Bowens"
	.align 2
.LC9:
	.string	"Programming"
	.align 2
.LC8:
	.string	"*Jason 'Abaris' Mohr"
	.align 2
.LC7:
	.string	"Project Leader"
	.align 2
.LC6:
	.string	"*Development Credits"
	.size	 menu_credits,352
	.align 2
.LC17:
	.string	"You must join a team first!\n"
	.align 2
.LC18:
	.long 0x41000000
	.align 2
.LC19:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl EndObserverMode
	.type	 EndObserverMode,@function
EndObserverMode:
	stwu 1,-64(1)
	mflr 0
	stmw 28,48(1)
	stw 0,68(1)
	mr 31,3
	lwz 11,84(31)
	lwz 0,4396(11)
	cmpwi 0,0,0
	bc 12,2,.L9
	lis 9,team_list@ha
	lwz 0,team_list@l(9)
	cmpwi 0,0,0
	bc 12,2,.L12
	lwz 0,3448(11)
	cmpwi 0,0,0
	bc 4,2,.L11
.L12:
	lis 9,gi+8@ha
	lis 5,.LC17@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC17@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L9
.L11:
	lwz 0,184(31)
	andi. 7,0,1
	bc 12,2,.L9
	mr 3,31
	li 28,0
	bl DoEndOM
	li 30,1
	addi 4,1,8
	addi 5,1,24
	mr 3,31
	bl Find_Mission_Start_Point
	lis 29,gi@ha
	mr 3,31
	la 29,gi@l(29)
	lwz 9,76(29)
	mtlr 9
	blrl
	lis 7,.LC18@ha
	lfs 0,8(1)
	la 7,.LC18@l(7)
	mr 11,9
	lwz 8,84(31)
	lfs 10,0(7)
	mr 10,9
	li 0,0
	lis 7,.LC19@ha
	mr 3,31
	la 7,.LC19@l(7)
	fmuls 0,0,10
	lfs 9,0(7)
	li 7,20
	fctiwz 13,0
	stfd 13,40(1)
	lwz 9,44(1)
	sth 9,4(8)
	lfs 0,12(1)
	lwz 9,84(31)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,40(1)
	lwz 11,44(1)
	sth 11,6(9)
	lfs 0,16(1)
	lwz 9,84(31)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,40(1)
	lwz 10,44(1)
	sth 10,8(9)
	lfs 0,16(1)
	lfs 12,8(1)
	lfs 13,12(1)
	fadds 0,0,9
	lwz 9,84(31)
	stfs 12,28(31)
	stfs 13,32(31)
	stfs 0,36(31)
	stfs 0,12(31)
	stfs 12,4(31)
	stfs 13,8(31)
	stw 0,380(31)
	stw 0,388(31)
	stw 0,384(31)
	stb 7,17(9)
	lwz 11,84(31)
	lbz 0,16(11)
	ori 0,0,16
	stb 0,16(11)
	lwz 9,84(31)
	stw 28,4396(9)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 9,84(31)
	mr 3,31
	stw 30,3472(9)
	bl WeighPlayer
	lis 9,level+4@ha
	lwz 11,84(31)
	lfs 0,level+4@l(9)
	stfs 0,4544(11)
	lwz 3,84(31)
	lwz 0,3464(3)
	cmpwi 0,0,6
	bc 4,2,.L14
	stw 28,4716(3)
	b .L9
.L14:
	stw 30,4716(3)
.L9:
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe1:
	.size	 EndObserverMode,.Lfe1-EndObserverMode
	.section	".rodata"
	.align 2
.LC20:
	.long 0x0
	.section	".text"
	.align 2
	.globl OpenSpot
	.type	 OpenSpot,@function
OpenSpot:
	lis 9,class_limits@ha
	lis 11,.LC20@ha
	lwz 10,class_limits@l(9)
	la 11,.LC20@l(11)
	lfs 13,0(11)
	lfs 0,20(10)
	lwz 11,84(3)
	fcmpu 0,0,13
	lwz 6,3448(11)
	bc 4,2,.L17
	lwz 10,96(6)
	slwi 11,4,2
	li 0,99
	li 3,1
	lwzx 9,11,10
	stw 0,44(9)
	blr
.L17:
	li 0,16
	li 7,0
	mtctr 0
	slwi 5,4,2
	addi 10,4,-1
	addi 8,6,8
.L40:
	lwz 9,0(8)
	addi 8,8,4
	cmpwi 0,9,0
	bc 12,2,.L20
	lwz 9,84(9)
	addi 11,7,1
	lwz 0,3464(9)
	xor 0,0,4
	srawi 3,0,31
	xor 9,3,0
	subf 9,9,3
	srawi 9,9,31
	andc 11,11,9
	and 9,7,9
	or 7,9,11
.L20:
	bdnz .L40
	cmplwi 0,10,8
	bc 12,1,.L35
	lis 11,.L36@ha
	slwi 10,10,2
	la 11,.L36@l(11)
	lis 9,.L36@ha
	lwzx 0,10,11
	la 9,.L36@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L36:
	.long .L26-.L36
	.long .L27-.L36
	.long .L28-.L36
	.long .L29-.L36
	.long .L30-.L36
	.long .L31-.L36
	.long .L32-.L36
	.long .L33-.L36
	.long .L34-.L36
.L26:
	lwz 9,96(6)
	subfic 0,7,99
	lwz 11,4(9)
	b .L41
.L27:
	lwz 9,96(6)
	subfic 0,7,1
	lwz 11,8(9)
	b .L41
.L28:
	lwz 9,96(6)
	subfic 0,7,2
	lwz 11,12(9)
	b .L41
.L29:
	lwz 9,96(6)
	subfic 0,7,2
	lwz 11,16(9)
	b .L41
.L30:
	lwz 9,96(6)
	subfic 0,7,2
	lwz 11,20(9)
	b .L41
.L31:
	lwz 9,96(6)
	subfic 0,7,1
	lwz 11,24(9)
	b .L41
.L32:
	lwz 9,96(6)
	subfic 0,7,1
	lwz 11,28(9)
	b .L41
.L33:
	lwz 9,96(6)
	subfic 0,7,4
	lwz 11,32(9)
	b .L41
.L34:
	lwz 9,96(6)
	subfic 0,7,1
	lwz 11,36(9)
	b .L41
.L35:
	lwz 9,96(6)
	li 0,0
	lwzx 11,5,9
.L41:
	stw 0,44(11)
	lwz 9,96(6)
	lwzx 11,5,9
	lwz 0,44(11)
	srawi 3,0,31
	subf 3,0,3
	srwi 3,3,31
	blr
.Lfe2:
	.size	 OpenSpot,.Lfe2-OpenSpot
	.section	".rodata"
	.align 2
.LC21:
	.string	"You aren't assigned to any team!\n"
	.align 2
.LC22:
	.string	"Request for class denied: Infantry\n"
	.align 2
.LC23:
	.string	"Your new selected class already\nhas enough players. Retain your\nassignment.\n"
	.align 2
.LC24:
	.string	"Your class is %s.\n"
	.align 2
.LC25:
	.long 0x41400000
	.section	".text"
	.align 2
	.globl DoEndOM
	.type	 DoEndOM,@function
DoEndOM:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3448(9)
	cmpwi 0,0,0
	bc 4,2,.L43
	lis 9,gi+8@ha
	lis 5,.LC21@ha
	lwz 0,gi+8@l(9)
	la 5,.LC21@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L42
.L43:
	lwz 4,3468(9)
	cmpwi 0,4,0
	bc 12,2,.L44
	lwz 0,3464(9)
	cmpwi 0,0,0
	bc 12,2,.L46
	cmpw 0,0,4
	bc 12,2,.L44
.L46:
	mr 3,31
	bl OpenSpot
	cmpwi 0,3,0
	bc 12,2,.L47
	lwz 9,84(31)
	lwz 0,3468(9)
	stw 0,3464(9)
	lwz 10,84(31)
	lwz 9,3448(10)
	lwz 11,3464(10)
	lwz 8,96(9)
	slwi 11,11,2
	lwzx 10,11,8
	lwz 9,44(10)
	addi 9,9,-1
	stw 9,44(10)
	b .L48
.L47:
	lwz 9,84(31)
	lwz 0,3464(9)
	cmpwi 0,0,0
	bc 4,2,.L49
	lis 9,gi+12@ha
	lis 4,.LC22@ha
	lwz 0,gi+12@l(9)
	la 4,.LC22@l(4)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 0,1
	stw 0,3464(9)
	b .L48
.L49:
	lis 9,gi+12@ha
	lis 4,.LC23@ha
	lwz 0,gi+12@l(9)
	la 4,.LC23@l(4)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
.L48:
	lwz 9,84(31)
	li 0,0
	stw 0,3468(9)
.L44:
	li 4,1
	mr 3,31
	bl SyncUserInfo
	li 29,0
	li 9,4
	li 11,1
	stw 29,496(31)
	stw 9,264(31)
	li 10,200
	li 0,22
	lis 9,.LC25@ha
	lis 8,level+4@ha
	stw 10,404(31)
	stw 11,248(31)
	la 9,.LC25@l(9)
	mr 3,31
	stw 11,516(31)
	stw 11,88(31)
	stw 0,512(31)
	lfs 0,level+4@l(8)
	lfs 13,0(9)
	lwz 0,184(31)
	lis 9,0x201
	ori 9,9,3
	stw 29,688(31)
	fadds 0,0,13
	rlwinm 0,0,0,0,30
	stw 9,252(31)
	stw 0,184(31)
	stfs 0,408(31)
	bl Give_Class_Weapon
	mr 3,31
	bl Give_Class_Ammo
	lwz 8,84(31)
	lis 9,gi+8@ha
	lis 5,.LC24@ha
	lwz 0,gi+8@l(9)
	la 5,.LC24@l(5)
	mr 3,31
	lwz 11,3448(8)
	li 4,2
	lwz 9,3464(8)
	mtlr 0
	lwz 10,96(11)
	slwi 9,9,2
	lwzx 11,9,10
	lwz 6,0(11)
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	stw 29,4396(9)
	lwz 11,84(31)
	stw 29,3484(11)
.L42:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 DoEndOM,.Lfe3-DoEndOM
	.section	".rodata"
	.align 2
.LC26:
	.string	"You've already been assigned the %s class!\n"
	.align 2
.LC27:
	.string	"Requesting %s class assignment your next operation.\n"
	.align 2
.LC28:
	.string	"%12s [%i/%i]"
	.align 2
.LC29:
	.string	"*Use [ and ] to select"
	.align 2
.LC30:
	.long 0x0
	.section	".text"
	.align 2
	.globl M_ChooseMOS
	.type	 M_ChooseMOS,@function
M_ChooseMOS:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 31,3
	li 30,0
	bl PMenu_Close
	lwz 11,84(31)
	lis 9,.LC0@ha
	li 6,1
	la 9,.LC0@l(9)
	lis 8,.LC1@ha
	stw 9,3552(11)
	la 8,.LC1@l(8)
	li 28,16
	lwz 9,84(31)
	li 0,32
	lis 7,.LC5@ha
	la 7,.LC5@l(7)
	li 27,48
	stw 6,3556(9)
	li 5,64
	li 4,240
	lwz 9,84(31)
	li 26,2
	lis 3,.LC4@ha
	la 3,.LC4@l(3)
	li 25,256
	addi 9,9,3560
	lis 29,M_Main_Menu@ha
	stwx 30,9,30
	la 29,M_Main_Menu@l(29)
	lwz 9,84(31)
	addi 9,9,3564
	stwx 30,9,30
	lwz 11,84(31)
	stw 8,3568(11)
	lwz 10,84(31)
	stw 6,3572(10)
	lwz 9,84(31)
	addi 9,9,3560
	stwx 30,9,28
	lwz 11,84(31)
	addi 11,11,3564
	stwx 30,11,28
	lwz 9,84(31)
	addi 9,9,3552
	stwx 30,9,0
	lwz 11,84(31)
	addi 11,11,3556
	stwx 6,11,0
	lwz 9,84(31)
	addi 9,9,3560
	stwx 30,9,0
	lwz 11,84(31)
	addi 11,11,3564
	stwx 30,11,0
	lwz 9,84(31)
	stw 7,3600(9)
	lwz 11,84(31)
	stw 6,3604(11)
	lwz 9,84(31)
	addi 9,9,3560
	stwx 30,9,27
	lwz 11,84(31)
	addi 11,11,3564
	stwx 30,11,27
	lwz 9,84(31)
	addi 9,9,3552
	stwx 30,9,5
	lwz 11,84(31)
	addi 11,11,3556
	stwx 6,11,5
	lwz 9,84(31)
	addi 9,9,3560
	stwx 30,9,5
	lwz 11,84(31)
	addi 11,11,3564
	stwx 30,11,5
	lwz 9,84(31)
	addi 9,9,3552
	stwx 30,9,4
	lwz 11,84(31)
	addi 11,11,3556
	stwx 26,11,4
	lwz 9,84(31)
	addi 9,9,3560
	stwx 30,9,4
	lwz 11,84(31)
	addi 11,11,3564
	stwx 30,11,4
	lwz 9,84(31)
	stw 3,3808(9)
	lwz 11,84(31)
	stw 26,3812(11)
	lwz 9,84(31)
	addi 9,9,3560
	stwx 30,9,25
	lwz 11,84(31)
	addi 11,11,3564
	stwx 29,11,25
	lwz 9,84(31)
	lwz 0,4396(9)
	cmpwi 0,0,0
	bc 12,2,.L66
	lwz 0,3472(9)
	cmpwi 0,0,0
	bc 4,2,.L66
	lwz 9,3448(9)
	cmpwi 0,9,0
	bc 12,2,.L58
	lwz 0,0(9)
	cmpwi 0,0,0
	bc 12,2,.L58
.L66:
	li 8,1
.L71:
	lwz 5,84(31)
	li 0,16
	slwi 29,8,2
	mtctr 0
	addi 25,8,1
	mr 4,29
	lwz 6,3448(5)
	li 27,0
	addi 26,8,4
	addi 7,6,8
.L98:
	lwz 11,0(7)
	addi 7,7,4
	cmpwi 0,11,0
	bc 12,2,.L74
	lwz 9,96(6)
	lwz 8,84(11)
	lwzx 11,4,9
	lwz 10,3464(8)
	lwz 0,40(11)
	cmpw 0,10,0
	bc 4,2,.L74
	lwz 9,184(8)
	addi 11,27,1
	cmpwi 7,9,998
	mfcr 0
	rlwinm 0,0,30,1
	neg 0,0
	andc 11,11,0
	and 0,27,0
	or 27,0,11
.L74:
	bdnz .L98
	lwz 9,3448(5)
	lwz 11,96(9)
	lwzx 11,29,11
	lwz 9,40(11)
	addi 9,9,-1
	cmplwi 0,9,8
	bc 12,1,.L89
	lis 11,.L90@ha
	slwi 10,9,2
	la 11,.L90@l(11)
	lis 9,.L90@ha
	lwzx 0,10,11
	la 9,.L90@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L90:
	.long .L80-.L90
	.long .L88-.L90
	.long .L82-.L90
	.long .L83-.L90
	.long .L84-.L90
	.long .L88-.L90
	.long .L88-.L90
	.long .L87-.L90
	.long .L88-.L90
.L80:
	lwz 10,84(31)
	subfic 0,27,99
	li 28,99
	b .L99
.L82:
	lwz 10,84(31)
	subfic 0,27,2
	li 28,2
	b .L99
.L83:
	lwz 10,84(31)
	subfic 0,27,2
	li 28,2
	b .L99
.L84:
	lwz 10,84(31)
	subfic 0,27,2
	li 28,2
	b .L99
.L87:
	lwz 10,84(31)
	subfic 0,27,4
	li 28,4
	b .L99
.L88:
	lwz 10,84(31)
	subfic 0,27,1
	li 28,1
.L99:
	lwz 9,3448(10)
	lwz 11,96(9)
	lwzx 10,29,11
	stw 0,44(10)
	b .L79
.L89:
	li 28,0
	stw 28,44(11)
.L79:
	lis 9,gi+132@ha
	li 4,765
	lwz 0,gi+132@l(9)
	li 3,21
	mtlr 0
	blrl
	lwz 9,84(31)
	mr 30,3
	mr 5,27
	lis 3,.LC28@ha
	mr 6,28
	lwz 10,3448(9)
	la 3,.LC28@l(3)
	lwz 9,96(10)
	lwzx 11,29,9
	lwz 4,0(11)
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,30
	bl strcpy
	lis 9,class_limits@ha
	lwz 10,84(31)
	slwi 0,26,4
	lwz 11,class_limits@l(9)
	lis 9,.LC30@ha
	addi 8,10,3552
	la 9,.LC30@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L91
	lwz 9,3448(10)
	lwz 11,96(9)
	lwzx 10,29,11
	lwz 3,0(10)
	b .L92
.L91:
	mr 3,30
.L92:
	stwx 3,8,0
	li 7,0
	lis 10,M_MOS_Join@ha
	lwz 11,84(31)
	slwi 0,26,4
	mr 8,25
	cmpwi 0,8,9
	la 10,M_MOS_Join@l(10)
	addi 11,11,3556
	stwx 7,11,0
	lwz 9,84(31)
	addi 9,9,3560
	stwx 7,9,0
	lwz 11,84(31)
	addi 11,11,3564
	stwx 10,11,0
	bc 4,1,.L71
	lwz 11,84(31)
	lwz 0,3472(11)
	cmpwi 0,0,0
	bc 4,2,.L95
	lwz 0,3484(11)
	cmpwi 0,0,0
	bc 4,2,.L94
.L95:
	lis 9,.LC4@ha
	li 0,2
	la 9,.LC4@l(9)
	li 8,256
	stw 9,3808(11)
	lis 10,M_Main_Menu@ha
	lwz 11,84(31)
	la 10,M_Main_Menu@l(10)
	stw 0,3812(11)
	lwz 9,84(31)
	addi 9,9,3560
	stwx 7,9,8
	lwz 11,84(31)
	addi 11,11,3564
	stwx 10,11,8
.L94:
	lwz 11,84(31)
	lis 9,.LC29@ha
	li 8,1
	la 9,.LC29@l(9)
	li 10,0
	stw 9,3952(11)
	li 0,400
	mr 3,31
	lwz 11,84(31)
	li 5,5
	li 6,36
	stw 8,3956(11)
	lwz 9,84(31)
	addi 9,9,3560
	stwx 10,9,0
	lwz 11,84(31)
	addi 11,11,3564
	stwx 10,11,0
	lwz 4,84(31)
	addi 4,4,3552
	bl PMenu_Open
.L58:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 M_ChooseMOS,.Lfe4-M_ChooseMOS
	.section	".rodata"
	.align 2
.LC32:
	.string	"Already on team %s!\n"
	.align 2
.LC33:
	.string	"No room left on the team. "
	.align 2
.LC34:
	.string	"%s has switched to team %s.\n"
	.align 2
.LC35:
	.string	"%s has joined team %s.\n"
	.align 2
.LC36:
	.string	"warning: %s got to end of M_Team_Join().\n"
	.align 2
.LC31:
	.long 0x46fffe00
	.align 3
.LC37:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC38:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC39:
	.long 0x40080000
	.long 0x0
	.align 3
.LC40:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl M_Team_Join
	.type	 M_Team_Join,@function
M_Team_Join:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 30,3
	mr 31,5
	li 29,0
	bl PMenu_Close
	cmpwi 0,31,8
	lis 11,team_list@ha
	addi 31,31,-5
	bc 4,2,.L101
	li 0,17
	lwz 10,team_list@l(11)
	la 9,team_list@l(11)
	mtctr 0
	lwz 11,4(9)
	li 6,0
	li 4,0
	addi 7,10,8
	addi 8,11,8
.L130:
	lwz 9,0(7)
	addi 11,4,1
	addi 10,6,1
	lwz 0,0(8)
	addi 7,7,4
	addic 9,9,-1
	subfe 9,9,9
	addi 8,8,4
	addic 0,0,-1
	subfe 0,0,0
	andc 11,11,9
	andc 10,10,0
	and 9,4,9
	and 0,6,0
	or 4,9,11
	or 6,0,10
	bdnz .L130
	cmpw 0,4,6
	bc 4,1,.L109
	li 31,1
	b .L101
.L109:
	bc 12,0,.L131
	bl rand
	li 31,1
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC37@ha
	lis 11,.LC31@ha
	la 10,.LC37@l(10)
	stw 0,24(1)
	lfd 0,0(10)
	lfd 13,24(1)
	lis 10,.LC38@ha
	lfs 12,.LC31@l(11)
	la 10,.LC38@l(10)
	lis 9,.LC40@ha
	lfd 11,0(10)
	la 9,.LC40@l(9)
	fsub 13,13,0
	lis 10,.LC39@ha
	lfd 10,0(9)
	la 10,.LC39@l(10)
	lfd 9,0(10)
	frsp 13,13
	fdivs 13,13,12
	fmr 0,13
	fsub 0,0,11
	fadd 0,0,0
	fmul 0,0,9
	fcmpu 0,0,10
	bc 4,1,.L101
.L131:
	li 31,0
.L101:
	lwz 11,84(30)
	slwi 5,31,2
	lwz 0,3472(11)
	cmpwi 0,0,0
	bc 12,2,.L115
	lis 9,team_list@ha
	lwz 10,3448(11)
	la 9,team_list@l(9)
	lwzx 6,5,9
	lwz 11,84(10)
	lwz 0,84(6)
	cmpw 0,11,0
	bc 4,2,.L115
	lis 9,gi+8@ha
	lis 5,.LC32@ha
	lwz 6,0(6)
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC32@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,30
	bl PMenu_Close
	b .L100
.L115:
	lis 9,team_list@ha
	li 4,0
	la 7,team_list@l(9)
	mr 0,5
	li 9,16
	li 6,0
	mtctr 9
.L129:
	lwzx 9,7,0
	cmpwi 0,9,0
	bc 12,2,.L119
	addi 9,9,8
	lwzx 8,9,6
	cmpwi 0,8,0
	bc 4,2,.L119
	lwz 9,84(30)
	lwz 9,3448(9)
	cmpwi 0,9,0
	bc 12,2,.L123
	lwz 0,84(9)
	slwi 0,0,2
	lwzx 10,7,0
	lwz 9,80(10)
	addi 9,9,-1
	stw 9,80(10)
	lwz 11,84(30)
	lwz 9,3448(11)
	lwz 10,3452(11)
	lwz 0,84(9)
	slwi 10,10,2
	slwi 0,0,2
	lwzx 9,7,0
	addi 9,9,8
	stwx 8,9,10
	lwz 11,84(30)
	stw 4,3452(11)
.L123:
	lwz 9,84(30)
	li 29,1
	lwzx 0,5,7
	stw 0,3448(9)
	lwzx 10,5,7
	lwz 9,80(10)
	addi 9,9,1
	stw 9,80(10)
	lwzx 11,5,7
	addi 11,11,8
	stwx 30,11,6
	lwz 9,84(30)
	stw 8,3464(9)
	b .L118
.L119:
	addi 6,6,4
	addi 4,4,1
	bdnz .L129
.L118:
	cmpwi 0,29,0
	bc 4,2,.L125
	lis 9,gi+8@ha
	lis 5,.LC33@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC33@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,30
	bl ChooseTeam
	b .L100
.L125:
	lwz 5,84(30)
	lwz 0,3472(5)
	cmpwi 0,0,0
	bc 12,2,.L127
	lis 9,g_edicts@ha
	lis 6,vec3_origin@ha
	lwz 4,g_edicts@l(9)
	la 6,vec3_origin@l(6)
	li 0,0
	li 9,38
	mr 8,6
	stw 0,8(1)
	stw 9,12(1)
	mr 5,4
	mr 3,30
	li 9,999
	addi 7,30,4
	li 10,0
	bl T_Damage
	lwz 9,84(30)
	li 0,1
	lis 11,gi@ha
	lis 4,.LC34@ha
	li 3,2
	stw 0,3464(9)
	la 4,.LC34@l(4)
	lwz 9,84(30)
	stw 0,3484(9)
	lwz 5,84(30)
	lwz 0,gi@l(11)
	lwz 9,3448(5)
	addi 5,5,700
	mtlr 0
	lwz 6,0(9)
	crxor 6,6,6
	blrl
	b .L128
.L127:
	lis 11,gi@ha
	lwz 9,3448(5)
	lis 4,.LC35@ha
	lwz 0,gi@l(11)
	la 4,.LC35@l(4)
	addi 5,5,700
	lwz 6,0(9)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L128:
	mr 3,30
	bl M_ChooseMOS
.L100:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 M_Team_Join,.Lfe5-M_Team_Join
	.section	".rodata"
	.align 2
.LC41:
	.string	"You have already changed teams once!\nYou must wait for your next assignment\n"
	.align 2
.LC42:
	.string	"You must wait for your next assignment\nto change teams!"
	.section	".text"
	.align 2
	.globl ChooseTeam
	.type	 ChooseTeam,@function
ChooseTeam:
	stwu 1,-64(1)
	mflr 0
	stmw 22,24(1)
	stw 0,68(1)
	mr 31,3
	bl PMenu_Close
	lwz 7,84(31)
	lwz 0,3484(7)
	cmpwi 0,0,1
	bc 4,2,.L133
	lis 9,gi+12@ha
	lis 4,.LC41@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC41@l(4)
	b .L155
.L133:
	lis 10,level_wait@ha
	lwz 8,level_wait@l(10)
	lis 9,level@ha
	lwz 0,level@l(9)
	lfs 0,20(8)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	mulli 11,11,10
	cmpw 0,0,11
	bc 12,0,.L132
	lwz 0,4396(7)
	cmpwi 0,0,0
	bc 4,2,.L136
	lwz 0,496(31)
	cmpwi 0,0,0
	bc 12,2,.L135
.L136:
	lwz 0,3448(7)
	cmpwi 0,0,0
	bc 12,2,.L135
	lis 9,gi+12@ha
	lis 4,.LC42@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC42@l(4)
.L155:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L132
.L135:
	lwz 11,84(31)
	lis 9,.LC0@ha
	li 6,1
	la 9,.LC0@l(9)
	li 0,0
	stw 9,3552(11)
	lis 8,.LC1@ha
	lis 10,M_Team_Join@ha
	lwz 11,84(31)
	lis 9,team_list@ha
	la 8,.LC1@l(8)
	la 30,team_list@l(9)
	la 22,M_Team_Join@l(10)
	stw 6,3556(11)
	li 5,16
	lis 7,.LC2@ha
	lwz 11,84(31)
	la 7,.LC2@l(7)
	li 4,48
	mr 23,30
	li 3,0
	addi 11,11,3560
	li 24,0
	stwx 0,11,0
	lwz 9,84(31)
	addi 9,9,3564
	stwx 0,9,0
	lwz 11,84(31)
	stw 8,3568(11)
	lwz 10,84(31)
	stw 6,3572(10)
	lwz 9,84(31)
	addi 9,9,3560
	stwx 0,9,5
	lwz 11,84(31)
	addi 11,11,3564
	stwx 0,11,5
	lwz 9,84(31)
	stw 7,3600(9)
	lwz 11,84(31)
	stw 6,3604(11)
	lwz 9,84(31)
	addi 9,9,3560
	stwx 0,9,4
	lwz 11,84(31)
	addi 11,11,3564
	stwx 0,11,4
.L143:
	slwi 0,3,2
	addi 25,3,1
	lwzx 9,30,0
	mr 28,0
	cmpwi 0,9,0
	bc 12,2,.L142
	lwz 0,8(9)
	addi 27,3,5
	lis 10,gi@ha
	lis 11,maxclients@ha
	lis 26,.LC28@ha
	cmpwi 0,0,0
	bc 12,2,.L146
	lwzx 9,28,23
	addi 9,9,8
.L147:
	lwzu 0,4(9)
	cmpwi 0,0,0
	bc 4,2,.L147
.L146:
	lwz 11,maxclients@l(11)
	la 9,gi@l(10)
	li 4,765
	lwz 0,132(9)
	li 3,21
	lfs 0,20(11)
	mtlr 0
	fctiwz 13,0
	stfd 13,16(1)
	lwz 29,20(1)
	blrl
	lwzx 9,28,30
	mr 6,29
	mr 28,3
	lwz 4,0(9)
	la 3,.LC28@l(26)
	lwz 5,80(9)
	crxor 6,6,6
	bl va
	mr 4,3
	mr 3,28
	bl strcat
	lwz 11,84(31)
	slwi 0,27,4
	addi 11,11,3552
	stwx 28,11,0
	lwz 9,84(31)
	addi 9,9,3556
	stwx 24,9,0
	lwz 11,84(31)
	addi 11,11,3560
	stwx 24,11,0
	lwz 9,84(31)
	addi 9,9,3564
	stwx 22,9,0
.L142:
	mr 3,25
	cmpwi 0,3,1
	bc 4,1,.L143
	lwz 11,84(31)
	lis 9,.LC3@ha
	li 29,0
	la 9,.LC3@l(9)
	li 0,128
	stw 9,3680(11)
	lis 10,M_Team_Join@ha
	lis 8,.LC4@ha
	lwz 9,84(31)
	la 10,M_Team_Join@l(10)
	la 8,.LC4@l(8)
	li 26,2
	li 28,160
	addi 9,9,3556
	lis 4,M_Main_Menu@ha
	stwx 29,9,0
	la 4,M_Main_Menu@l(4)
	lis 7,.LC29@ha
	lwz 9,84(31)
	la 7,.LC29@l(7)
	li 25,1
	li 27,400
	mr 3,31
	addi 9,9,3560
	li 5,5
	stwx 29,9,0
	li 6,36
	lwz 9,84(31)
	addi 9,9,3564
	stwx 10,9,0
	lwz 11,84(31)
	stw 8,3712(11)
	lwz 10,84(31)
	stw 26,3716(10)
	lwz 9,84(31)
	addi 9,9,3560
	stwx 29,9,28
	lwz 11,84(31)
	addi 11,11,3564
	stwx 4,11,28
	lwz 9,84(31)
	stw 7,3952(9)
	lwz 11,84(31)
	stw 25,3956(11)
	lwz 9,84(31)
	addi 9,9,3560
	stwx 29,9,27
	lwz 11,84(31)
	addi 11,11,3564
	stwx 29,11,27
	lwz 4,84(31)
	addi 4,4,3552
	bl PMenu_Open
.L132:
	lwz 0,68(1)
	mtlr 0
	lmw 22,24(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 ChooseTeam,.Lfe6-ChooseTeam
	.section	".rodata"
	.align 2
.LC43:
	.string	"*Main Menu"
	.align 2
.LC44:
	.string	"Choose a Team"
	.align 2
.LC45:
	.string	"View Credits"
	.section	".text"
	.align 2
	.globl MainMenu
	.type	 MainMenu,@function
MainMenu:
	stwu 1,-64(1)
	mflr 0
	stmw 20,16(1)
	stw 0,68(1)
	mr 29,3
	bl PMenu_Close
	lwz 11,84(29)
	lis 9,.LC0@ha
	li 23,1
	la 9,.LC0@l(9)
	li 0,0
	stw 9,3552(11)
	lis 10,.LC1@ha
	li 22,16
	lwz 9,84(29)
	la 10,.LC1@l(10)
	lis 8,.LC43@ha
	la 8,.LC43@l(8)
	li 21,48
	stw 23,3556(9)
	lis 7,.LC44@ha
	li 27,80
	lwz 9,84(29)
	la 7,.LC44@l(7)
	lis 4,M_Team_Choose@ha
	la 4,M_Team_Choose@l(4)
	lis 28,.LC45@ha
	addi 9,9,3560
	la 28,.LC45@l(28)
	stwx 0,9,0
	li 24,96
	lis 25,M_View_Credits@ha
	lwz 9,84(29)
	la 25,M_View_Credits@l(25)
	lis 26,.LC29@ha
	la 26,.LC29@l(26)
	li 20,400
	addi 9,9,3564
	mr 3,29
	stwx 0,9,0
	li 5,5
	li 6,36
	lwz 9,84(29)
	stw 10,3568(9)
	lwz 11,84(29)
	stw 23,3572(11)
	lwz 9,84(29)
	addi 9,9,3560
	stwx 0,9,22
	lwz 11,84(29)
	addi 11,11,3564
	stwx 0,11,22
	lwz 9,84(29)
	stw 8,3600(9)
	lwz 11,84(29)
	stw 23,3604(11)
	lwz 9,84(29)
	addi 9,9,3560
	stwx 0,9,21
	lwz 11,84(29)
	addi 11,11,3564
	stwx 0,11,21
	lwz 10,84(29)
	stw 7,3632(10)
	lwz 9,84(29)
	addi 9,9,3556
	stwx 0,9,27
	lwz 11,84(29)
	addi 11,11,3560
	stwx 0,11,27
	lwz 9,84(29)
	addi 9,9,3564
	stwx 4,9,27
	lwz 11,84(29)
	stw 28,3648(11)
	lwz 9,84(29)
	addi 9,9,3556
	stwx 0,9,24
	lwz 11,84(29)
	addi 11,11,3560
	stwx 0,11,24
	lwz 9,84(29)
	addi 9,9,3564
	stwx 25,9,24
	lwz 11,84(29)
	stw 26,3952(11)
	lwz 10,84(29)
	stw 23,3956(10)
	lwz 9,84(29)
	addi 9,9,3560
	stwx 0,9,20
	lwz 11,84(29)
	addi 11,11,3564
	stwx 0,11,20
	lwz 4,84(29)
	addi 4,4,3552
	bl PMenu_Open
	lwz 0,68(1)
	mtlr 0
	lmw 20,16(1)
	la 1,64(1)
	blr
.Lfe7:
	.size	 MainMenu,.Lfe7-MainMenu
	.section	".rodata"
	.align 2
.LC46:
	.string	"*Species"
	.align 2
.LC47:
	.string	"*Adam 'RezMoth' Sherburne"
	.align 2
.LC48:
	.string	"Webmistress"
	.align 2
.LC49:
	.string	"*Wheaty"
	.section	".text"
	.align 2
	.globl M_View_Credits
	.type	 M_View_Credits,@function
M_View_Credits:
	stwu 1,-80(1)
	mflr 0
	stmw 14,8(1)
	stw 0,84(1)
	mr 29,3
	bl PMenu_Close
	lwz 11,84(29)
	lis 9,.LC0@ha
	li 10,1
	la 9,.LC0@l(9)
	li 0,0
	stw 9,3552(11)
	lis 8,.LC1@ha
	lis 7,.LC6@ha
	lwz 9,84(29)
	la 8,.LC1@l(8)
	li 11,16
	la 7,.LC6@l(7)
	li 15,48
	stw 10,3556(9)
	lis 4,.LC7@ha
	li 14,80
	lwz 9,84(29)
	la 4,.LC7@l(4)
	lis 28,.LC8@ha
	la 28,.LC8@l(28)
	li 12,96
	addi 9,9,3560
	lis 27,.LC9@ha
	stwx 0,9,0
	la 27,.LC9@l(27)
	lis 26,.LC10@ha
	li 9,128
	la 26,.LC10@l(26)
	mtlr 9
	li 31,144
	lis 25,.LC46@ha
	lwz 9,84(29)
	la 25,.LC46@l(25)
	li 30,160
	lis 24,.LC47@ha
	li 16,176
	addi 9,9,3564
	la 24,.LC47@l(24)
	stwx 0,9,0
	li 17,208
	li 18,224
	lwz 9,84(29)
	li 19,256
	li 20,272
	li 21,320
	li 22,336
	stw 8,3568(9)
	li 23,400
	mr 3,29
	lwz 9,84(29)
	lis 8,.LC11@ha
	li 5,-1
	la 8,.LC11@l(8)
	li 6,36
	stw 10,3572(9)
	mtctr 8
	lwz 9,84(29)
	li 8,304
	addi 9,9,3560
	stwx 0,9,11
	lwz 9,84(29)
	addi 9,9,3564
	stwx 0,9,11
	lwz 9,84(29)
	stw 7,3600(9)
	lwz 11,84(29)
	mflr 7
	stw 10,3604(11)
	lwz 9,84(29)
	addi 9,9,3560
	stwx 0,9,15
	lwz 11,84(29)
	addi 11,11,3564
	stwx 0,11,15
	lwz 9,84(29)
	stw 4,3632(9)
	lwz 11,84(29)
	stw 10,3636(11)
	lwz 9,84(29)
	addi 9,9,3560
	stwx 0,9,14
	lwz 11,84(29)
	addi 11,11,3564
	stwx 0,11,14
	lwz 9,84(29)
	stw 28,3648(9)
	lwz 11,84(29)
	stw 10,3652(11)
	lwz 9,84(29)
	addi 9,9,3560
	stwx 0,9,12
	lwz 11,84(29)
	addi 11,11,3564
	stwx 0,11,12
	lwz 9,84(29)
	stw 27,3680(9)
	lwz 11,84(29)
	stw 10,3684(11)
	lwz 9,84(29)
	mflr 11
	addi 9,9,3560
	stwx 0,9,11
	lwz 11,84(29)
	addi 11,11,3564
	stwx 0,11,7
	lwz 9,84(29)
	lis 7,.LC12@ha
	la 7,.LC12@l(7)
	stw 26,3696(9)
	lwz 11,84(29)
	stw 10,3700(11)
	lwz 9,84(29)
	addi 9,9,3560
	stwx 0,9,31
	lwz 11,84(29)
	addi 11,11,3564
	stwx 0,11,31
	lwz 9,84(29)
	stw 25,3712(9)
	lwz 11,84(29)
	stw 10,3716(11)
	lwz 9,84(29)
	addi 9,9,3560
	stwx 0,9,30
	lwz 11,84(29)
	addi 11,11,3564
	stwx 0,11,30
	lwz 9,84(29)
	stw 24,3728(9)
	lwz 11,84(29)
	stw 10,3732(11)
	lwz 9,84(29)
	addi 9,9,3560
	stwx 0,9,16
	lwz 11,84(29)
	addi 11,11,3564
	stwx 0,11,16
	lwz 9,84(29)
	mfctr 11
	stw 11,3760(9)
	lwz 11,84(29)
	stw 10,3764(11)
	lwz 9,84(29)
	addi 9,9,3560
	stwx 0,9,17
	lwz 11,84(29)
	addi 11,11,3564
	stwx 0,11,17
	lwz 9,84(29)
	stw 7,3776(9)
	lwz 11,84(29)
	lis 7,.LC14@ha
	la 7,.LC14@l(7)
	stw 10,3780(11)
	lwz 9,84(29)
	addi 9,9,3560
	stwx 0,9,18
	lwz 11,84(29)
	addi 11,11,3564
	stwx 0,11,18
	lwz 9,84(29)
	lis 11,.LC13@ha
	la 11,.LC13@l(11)
	stw 11,3808(9)
	lwz 11,84(29)
	stw 10,3812(11)
	lwz 9,84(29)
	addi 9,9,3560
	stwx 0,9,19
	lwz 11,84(29)
	addi 11,11,3564
	stwx 0,11,19
	lwz 9,84(29)
	stw 7,3824(9)
	lwz 11,84(29)
	lis 7,.LC4@ha
	la 7,.LC4@l(7)
	stw 10,3828(11)
	lwz 9,84(29)
	addi 9,9,3560
	stwx 0,9,20
	lwz 11,84(29)
	addi 11,11,3564
	stwx 0,11,20
	lwz 9,84(29)
	addi 9,9,3552
	stwx 0,9,8
	lwz 11,84(29)
	addi 11,11,3556
	stwx 0,11,8
	lwz 9,84(29)
	addi 9,9,3560
	stwx 0,9,8
	lwz 11,84(29)
	addi 11,11,3564
	stwx 0,11,8
	lwz 9,84(29)
	lis 8,.LC48@ha
	la 8,.LC48@l(8)
	stw 8,3872(9)
	lwz 11,84(29)
	lis 8,M_Main_Menu@ha
	la 8,M_Main_Menu@l(8)
	stw 10,3876(11)
	lwz 9,84(29)
	addi 9,9,3560
	stwx 0,9,21
	lwz 11,84(29)
	addi 11,11,3564
	stwx 0,11,21
	lwz 9,84(29)
	lis 11,.LC49@ha
	la 11,.LC49@l(11)
	stw 11,3888(9)
	lwz 11,84(29)
	stw 10,3892(11)
	lwz 9,84(29)
	addi 9,9,3560
	stwx 0,9,22
	lwz 11,84(29)
	addi 11,11,3564
	stwx 0,11,22
	lwz 9,84(29)
	stw 7,3952(9)
	lwz 11,84(29)
	stw 10,3956(11)
	lwz 9,84(29)
	addi 9,9,3560
	stwx 0,9,23
	lwz 11,84(29)
	addi 11,11,3564
	stwx 8,11,23
	lwz 4,84(29)
	addi 4,4,3552
	bl PMenu_Open
	lwz 0,84(1)
	mtlr 0
	lmw 14,8(1)
	la 1,80(1)
	blr
.Lfe8:
	.size	 M_View_Credits,.Lfe8-M_View_Credits
	.comm	is_silenced,1,1
	.comm	maplist,1060,4
	.align 2
	.globl M_MOS_Join
	.type	 M_MOS_Join,@function
M_MOS_Join:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	addi 30,5,-4
	bl PMenu_Close
	lwz 9,84(31)
	stw 30,3468(9)
	lwz 9,84(31)
	lwz 0,3472(9)
	cmpwi 0,0,0
	bc 12,2,.L52
	lwz 0,3484(9)
	cmpwi 0,0,0
	bc 4,2,.L183
	lwz 0,3464(9)
	cmpw 0,30,0
	bc 4,2,.L53
	lwz 10,3448(9)
	slwi 8,30,2
	lis 5,.LC26@ha
	lis 9,gi+8@ha
	mr 3,31
	lwz 11,96(10)
	la 5,.LC26@l(5)
	b .L184
.L53:
	lwz 10,3448(9)
	slwi 8,30,2
	lis 5,.LC27@ha
	lis 9,gi+8@ha
	mr 3,31
	lwz 11,96(10)
	la 5,.LC27@l(5)
.L184:
	li 4,2
	lwz 0,gi+8@l(9)
	lwzx 9,8,11
	mtlr 0
	lwz 6,0(9)
	crxor 6,6,6
	blrl
	b .L51
.L52:
	lwz 0,3484(9)
	cmpwi 0,0,0
	bc 12,2,.L55
.L183:
	lwz 9,84(31)
	li 0,1
	mr 3,31
	stw 0,3464(9)
	bl respawn
	b .L51
.L55:
	mr 3,31
	bl EndObserverMode
.L51:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe9:
	.size	 M_MOS_Join,.Lfe9-M_MOS_Join
	.align 2
	.globl M_Main_Menu
	.type	 M_Main_Menu,@function
M_Main_Menu:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl MainMenu
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 M_Main_Menu,.Lfe10-M_Main_Menu
	.align 2
	.globl M_Team_Choose
	.type	 M_Team_Choose,@function
M_Team_Choose:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	mr 3,29
	bl ChooseTeam
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 M_Team_Choose,.Lfe11-M_Team_Choose
	.comm	team_list,8,4
	.align 2
	.globl SwitchToObserver
	.type	 SwitchToObserver,@function
SwitchToObserver:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	li 9,0
	lwz 0,184(31)
	li 29,1
	lis 10,gi+72@ha
	lwz 11,84(31)
	ori 0,0,1
	stw 9,248(31)
	stw 29,264(31)
	stw 0,184(31)
	stw 9,88(11)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	lwz 9,84(31)
	stw 29,4396(9)
	lwz 11,84(31)
	lwz 0,4524(11)
	cmpwi 0,0,0
	bc 4,2,.L7
	lis 9,team_list@ha
	lwz 0,team_list@l(9)
	cmpwi 0,0,0
	bc 12,2,.L7
	mr 3,31
	bl MainMenu
.L7:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 SwitchToObserver,.Lfe12-SwitchToObserver
	.align 2
	.globl client_menu
	.type	 client_menu,@function
client_menu:
	lwz 9,84(3)
	slwi 4,4,4
	addi 9,9,3552
	stwx 5,9,4
	lwz 11,84(3)
	addi 11,11,3556
	stwx 6,11,4
	lwz 9,84(3)
	addi 9,9,3560
	stwx 7,9,4
	lwz 11,84(3)
	addi 11,11,3564
	stwx 8,11,4
	blr
.Lfe13:
	.size	 client_menu,.Lfe13-client_menu
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
