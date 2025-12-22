	.file	"acebot_ai.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0x46fffe00
	.align 3
.LC1:
	.long 0x4052c000
	.long 0x0
	.align 3
.LC2:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC3:
	.long 0x42140000
	.align 3
.LC4:
	.long 0x40240000
	.long 0x0
	.align 3
.LC5:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC6:
	.long 0x41c80000
	.align 3
.LC7:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC8:
	.long 0x47800000
	.align 2
.LC9:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl ACEAI_Think
	.type	 ACEAI_Think,@function
ACEAI_Think:
	stwu 1,-48(1)
	mflr 0
	stw 31,44(1)
	stw 0,52(1)
	mr 31,3
	li 0,0
	lwz 11,84(31)
	addi 3,1,8
	li 4,0
	li 5,16
	lfs 0,28(11)
	stfs 0,16(31)
	lfs 13,32(11)
	stfs 13,20(31)
	lfs 0,36(11)
	stfs 0,24(31)
	sth 0,20(11)
	lwz 9,84(31)
	sth 0,22(9)
	lwz 11,84(31)
	sth 0,24(11)
	crxor 6,6,6
	bl memset
	lwz 0,492(31)
	li 11,0
	stw 11,540(31)
	cmpwi 0,0,0
	stw 11,416(31)
	bc 12,2,.L7
	lwz 9,84(31)
	li 0,1
	stw 11,3552(9)
	stb 0,9(1)
.L7:
	lwz 0,948(31)
	cmpwi 0,0,3
	bc 4,2,.L8
	lis 9,level@ha
	lfs 13,916(31)
	la 9,level@l(9)
	lfs 0,4(9)
	fcmpu 0,13,0
	bc 4,0,.L8
	mr 3,31
	bl ACEAI_PickLongRangeGoal
.L8:
	addi 3,31,376
	bl VectorLength
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,1,.L9
	lis 9,level+4@ha
	lis 10,.LC4@ha
	lfs 0,level+4@l(9)
	la 10,.LC4@l(10)
	lfd 13,0(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,920(31)
.L9:
	lis 9,level+4@ha
	lfs 13,920(31)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L10
	li 0,0
	lis 6,0x1
	lis 7,vec3_origin@ha
	stw 0,480(31)
	mr 3,31
	la 7,vec3_origin@l(7)
	mr 4,31
	mr 5,31
	ori 6,6,34464
	bl player_die
.L10:
	mr 3,31
	bl ACEAI_PickShortRangeGoal
	mr 3,31
	bl ACEAI_FindEnemy
	cmpwi 0,3,0
	bc 12,2,.L11
	mr 3,31
	bl ACEAI_ChooseWeapon
	mr 3,31
	addi 4,1,8
	bl ACEMV_Attack
	b .L12
.L11:
	lwz 0,948(31)
	cmpwi 0,0,3
	bc 4,2,.L13
	mr 3,31
	addi 4,1,8
	bl ACEMV_Wander
	b .L12
.L13:
	cmpwi 0,0,1
	bc 4,2,.L12
	mr 3,31
	addi 4,1,8
	bl ACEMV_Move
.L12:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,36(1)
	lis 10,.LC5@ha
	lis 11,.LC0@ha
	stw 0,32(1)
	la 10,.LC5@l(10)
	lfd 13,0(10)
	lfd 0,32(1)
	lis 10,.LC6@ha
	lfs 12,.LC0@l(11)
	la 10,.LC6@l(10)
	lfs 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmuls 0,0,11
	fmr 1,0
	bl floor
	lis 11,.LC1@ha
	lis 9,.LC7@ha
	lwz 7,84(31)
	lfd 13,.LC1@l(11)
	la 9,.LC7@l(9)
	lis 10,.LC8@ha
	lfd 12,0(9)
	lis 11,.LC9@ha
	la 10,.LC8@l(10)
	la 11,.LC9@l(11)
	lfs 8,0(10)
	fadd 1,1,13
	lfs 7,0(11)
	mr 8,9
	mr 10,9
	mr 11,9
	mr 3,31
	addi 4,1,8
	fadd 1,1,12
	fctiwz 0,1
	stfd 0,32(1)
	lwz 9,36(1)
	stb 9,8(1)
	rlwinm 0,9,0,0xff
	stw 0,184(7)
	lfs 13,16(31)
	lfs 12,20(31)
	lfs 0,24(31)
	fmuls 13,13,8
	fmuls 12,12,8
	fmuls 0,0,8
	fdivs 13,13,7
	fdivs 12,12,7
	fdivs 0,0,7
	fctiwz 11,13
	fctiwz 10,12
	fctiwz 9,0
	stfd 11,32(1)
	lwz 8,36(1)
	stfd 10,32(1)
	lwz 11,36(1)
	stfd 9,32(1)
	lwz 10,36(1)
	sth 11,12(1)
	sth 8,10(1)
	sth 10,14(1)
	bl ClientThink
	lis 9,level+4@ha
	lis 11,.LC2@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC2@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,52(1)
	mtlr 0
	lwz 31,44(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 ACEAI_Think,.Lfe1-ACEAI_Think
	.section	".rodata"
	.align 2
.LC12:
	.string	"%s did not find a LR goal, wandering.\n"
	.align 2
.LC13:
	.string	"%s selected a %s at node %d for LR goal.\n"
	.align 2
.LC10:
	.long 0x46fffe00
	.align 2
.LC11:
	.long 0x3e99999a
	.align 2
.LC14:
	.long 0x0
	.align 3
.LC15:
	.long 0x3ff00000
	.long 0x0
	.align 3
.LC16:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC17:
	.long 0xbf800000
	.align 2
.LC18:
	.long 0x40000000
	.align 2
.LC19:
	.long 0x41200000
	.align 2
.LC20:
	.long 0x40400000
	.align 3
.LC21:
	.long 0x0
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEAI_PickLongRangeGoal
	.type	 ACEAI_PickLongRangeGoal,@function
ACEAI_PickLongRangeGoal:
	stwu 1,-128(1)
	mflr 0
	stfd 24,64(1)
	stfd 25,72(1)
	stfd 26,80(1)
	stfd 27,88(1)
	stfd 28,96(1)
	stfd 29,104(1)
	stfd 30,112(1)
	stfd 31,120(1)
	stmw 20,16(1)
	stw 0,132(1)
	mr 30,3
	li 4,128
	li 5,99
	bl ACEND_FindClosestReachableNode
	mr 27,3
	lis 9,.LC14@ha
	cmpwi 0,27,-1
	la 9,.LC14@l(9)
	stw 27,924(30)
	lfs 28,0(9)
	bc 4,2,.L17
	li 0,3
	lis 9,level+4@ha
	stw 0,948(30)
	lis 11,.LC15@ha
	lfs 0,level+4@l(9)
	la 11,.LC15@l(11)
	lfd 13,0(11)
	stw 27,928(30)
	fadd 0,0,13
	frsp 0,0
	stfs 0,916(30)
	b .L16
.L17:
	lis 9,num_items@ha
	li 28,0
	lwz 0,num_items@l(9)
	lis 26,num_items@ha
	lis 20,num_players@ha
	cmpw 0,28,0
	bc 4,0,.L19
	lis 9,.LC10@ha
	lis 11,item_table@ha
	lfs 26,.LC10@l(9)
	la 31,item_table@l(11)
	lis 29,0x4330
	lis 9,.LC16@ha
	lis 11,.LC17@ha
	la 9,.LC16@l(9)
	la 11,.LC17@l(11)
	lfd 29,0(9)
	lfs 27,0(11)
.L21:
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L20
	lwz 0,248(9)
	cmpwi 0,0,0
	bc 12,2,.L20
	lwz 4,12(31)
	mr 3,27
	bl ACEND_FindCost
	xoris 3,3,0x8000
	stw 3,12(1)
	lis 11,.LC18@ha
	stw 29,8(1)
	la 11,.LC18@l(11)
	lfd 0,8(1)
	lfs 13,0(11)
	fsub 0,0,29
	frsp 30,0
	fcmpu 7,30,13
	fcmpu 6,30,27
	mfcr 0
	rlwinm 9,0,29,1
	rlwinm 0,0,27,1
	or. 11,0,9
	bc 4,2,.L20
	lwz 4,0(31)
	mr 3,30
	bl ACEIT_ItemNeed
	lis 9,.LC14@ha
	lis 11,ctf@ha
	fmr 31,1
	la 9,.LC14@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L25
	lwz 9,0(31)
	addi 9,9,-43
	cmplwi 0,9,1
	bc 12,1,.L25
	lwz 9,84(30)
	lwz 11,3452(9)
	cmpwi 0,11,1
	bc 4,2,.L27
	lwz 0,916(9)
	cmpwi 0,0,0
	bc 4,2,.L26
.L27:
	cmpwi 0,11,2
	bc 4,2,.L25
	lwz 0,912(9)
	cmpwi 0,0,0
	bc 12,2,.L25
.L26:
	lis 11,.LC19@ha
	la 11,.LC19@l(11)
	lfs 31,0(11)
.L25:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	fsub 0,0,29
	frsp 0,0
	fdivs 0,0,26
	fmuls 31,31,0
	fdivs 31,31,30
	fcmpu 0,31,28
	bc 4,1,.L20
	fmr 28,31
	lwz 24,12(31)
	lwz 23,8(31)
.L20:
	lwz 0,num_items@l(26)
	addi 28,28,1
	addi 31,31,16
	cmpw 0,28,0
	bc 12,0,.L21
.L19:
	lis 9,num_players@ha
	li 28,0
	lwz 0,num_players@l(9)
	cmpw 0,28,0
	bc 4,0,.L31
	lis 9,.LC10@ha
	lis 11,players@ha
	lfs 24,.LC10@l(9)
	la 26,players@l(11)
	lis 25,0x4330
	lis 9,.LC16@ha
	lis 11,.LC17@ha
	la 9,.LC16@l(9)
	la 11,.LC17@l(11)
	lfd 29,0(9)
	li 31,0
	lis 21,ctf@ha
	lfs 25,0(11)
	lis 9,.LC20@ha
	lis 22,.LC11@ha
	lis 11,.LC14@ha
	la 9,.LC20@l(9)
	la 11,.LC14@l(11)
	lfs 26,0(9)
	lfs 27,0(11)
.L33:
	lwzx 3,31,26
	cmpw 0,3,30
	bc 12,2,.L32
	li 4,128
	li 5,99
	bl ACEND_FindClosestReachableNode
	mr 29,3
	mr 3,27
	mr 4,29
	bl ACEND_FindCost
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 25,8(1)
	lfd 0,8(1)
	fsub 0,0,29
	frsp 30,0
	fcmpu 7,30,25
	fcmpu 6,30,26
	mfcr 0
	rlwinm 9,0,31,1
	rlwinm 0,0,25,1
	or. 11,9,0
	bc 4,2,.L32
	lwz 9,ctf@l(21)
	lfs 0,20(9)
	fcmpu 0,0,27
	bc 12,2,.L36
	lwzx 9,31,26
	lwz 9,84(9)
	lwz 0,916(9)
	cmpwi 0,0,0
	bc 4,2,.L37
	lwz 0,912(9)
	cmpwi 0,0,0
	bc 12,2,.L36
.L37:
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	lfs 31,0(9)
	b .L38
.L36:
	lfs 31,.LC11@l(22)
.L38:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 25,8(1)
	lfd 0,8(1)
	fsub 0,0,29
	frsp 0,0
	fdivs 0,0,24
	fmuls 31,31,0
	fdivs 31,31,30
	fcmpu 0,31,28
	bc 4,1,.L32
	fmr 28,31
	lwzx 23,31,26
	mr 24,29
.L32:
	lwz 0,num_players@l(20)
	addi 28,28,1
	addi 31,31,4
	cmpw 0,28,0
	bc 12,0,.L33
.L31:
	lis 9,.LC21@ha
	fmr 13,28
	la 9,.LC21@l(9)
	lfd 0,0(9)
	subfic 9,24,-1
	subfic 11,9,0
	adde 9,11,9
	fcmpu 7,13,0
	mfcr 0
	rlwinm 0,0,31,1
	or. 9,0,9
	bc 12,2,.L41
	li 9,3
	li 0,-1
	stw 0,928(30)
	lis 11,level+4@ha
	stw 9,948(30)
	lfs 0,level+4@l(11)
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfd 13,0(9)
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	fadd 0,0,13
	cmpwi 0,0,0
	frsp 0,0
	stfs 0,916(30)
	bc 12,2,.L16
	lwz 4,84(30)
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	addi 4,4,700
	crxor 6,6,6
	bl debug_printf
	b .L16
.L41:
	cmpwi 0,23,0
	li 0,1
	stw 9,944(30)
	stw 0,948(30)
	bc 12,2,.L43
	lis 9,debug_mode@ha
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L43
	lwz 4,84(30)
	lis 3,.LC13@ha
	mr 6,24
	lwz 5,280(23)
	la 3,.LC13@l(3)
	addi 4,4,700
	crxor 6,6,6
	bl debug_printf
.L43:
	mr 3,30
	mr 4,24
	bl ACEND_SetGoal
.L16:
	lwz 0,132(1)
	mtlr 0
	lmw 20,16(1)
	lfd 24,64(1)
	lfd 25,72(1)
	lfd 26,80(1)
	lfd 27,88(1)
	lfd 28,96(1)
	lfd 29,104(1)
	lfd 30,112(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe2:
	.size	 ACEAI_PickLongRangeGoal,.Lfe2-ACEAI_PickLongRangeGoal
	.section	".rodata"
	.align 2
.LC22:
	.string	"rocket"
	.align 2
.LC23:
	.string	"grenade"
	.align 2
.LC24:
	.string	"ROCKET ALERT!\n"
	.align 2
.LC25:
	.string	"%s selected a %s for SR goal.\n"
	.align 2
.LC26:
	.long 0x43480000
	.align 2
.LC27:
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEAI_PickShortRangeGoal
	.type	 ACEAI_PickShortRangeGoal,@function
ACEAI_PickShortRangeGoal:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 25,12(1)
	stw 0,52(1)
	lis 9,.LC26@ha
	mr 30,3
	la 9,.LC26@l(9)
	li 3,0
	lfs 1,0(9)
	addi 4,30,4
	bl findradius
	lis 9,.LC27@ha
	mr. 31,3
	la 9,.LC27@l(9)
	lfs 31,0(9)
	bc 12,2,.L46
	lis 26,.LC22@ha
	lis 28,.LC23@ha
	lis 27,debug_mode@ha
	lis 25,.LC24@ha
.L47:
	lwz 3,280(31)
	cmpwi 0,3,0
	bc 12,2,.L44
	la 4,.LC22@l(26)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L50
	lwz 3,280(31)
	la 4,.LC23@l(28)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L49
.L50:
	lwz 0,debug_mode@l(27)
	cmpwi 0,0,0
	bc 12,2,.L51
	la 3,.LC24@l(25)
	crxor 6,6,6
	bl debug_printf
.L51:
	stw 31,416(30)
	b .L44
.L49:
	mr 3,30
	addi 4,31,4
	bl ACEIT_IsReachable
	cmpwi 0,3,0
	bc 12,2,.L52
	mr 3,30
	mr 4,31
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L52
	lwz 3,280(31)
	bl ACEIT_ClassnameToIndex
	mr 4,3
	mr 3,30
	bl ACEIT_ItemNeed
	fcmpu 0,1,31
	bc 4,1,.L52
	fmr 31,1
	mr 29,31
.L52:
	lis 9,.LC26@ha
	mr 3,31
	la 9,.LC26@l(9)
	addi 4,30,4
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	bc 4,2,.L47
.L46:
	lis 9,.LC27@ha
	la 9,.LC27@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 12,2,.L44
	lis 9,debug_mode@ha
	stw 29,416(30)
	lwz 0,debug_mode@l(9)
	cmpwi 0,0,0
	bc 12,2,.L57
	lwz 0,412(30)
	cmpw 0,0,29
	bc 12,2,.L57
	lwz 4,84(30)
	lis 3,.LC25@ha
	lwz 5,280(29)
	la 3,.LC25@l(3)
	addi 4,4,700
	crxor 6,6,6
	bl debug_printf
.L57:
	stw 29,412(30)
.L44:
	lwz 0,52(1)
	mtlr 0
	lmw 25,12(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 ACEAI_PickShortRangeGoal,.Lfe3-ACEAI_PickShortRangeGoal
	.section	".rodata"
	.align 2
.LC28:
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEAI_FindEnemy
	.type	 ACEAI_FindEnemy,@function
ACEAI_FindEnemy:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 25,12(1)
	stw 0,52(1)
	lis 9,num_players@ha
	li 29,0
	lwz 0,num_players@l(9)
	mr 31,3
	lis 25,num_players@ha
	cmpw 0,29,0
	bc 12,1,.L60
	lis 9,players@ha
	lis 11,gi@ha
	la 28,players@l(9)
	la 26,gi@l(11)
	lis 9,.LC28@ha
	lis 27,ctf@ha
	la 9,.LC28@l(9)
	li 30,0
	lfs 31,0(9)
.L62:
	lwzx 4,30,28
	cmpwi 0,4,0
	bc 12,2,.L61
	cmpw 0,4,31
	bc 12,2,.L61
	lwz 0,248(4)
	cmpwi 0,0,0
	bc 12,2,.L61
	lwz 9,ctf@l(27)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L65
	lwz 9,84(31)
	lwz 11,84(4)
	lwz 10,3452(9)
	lwz 0,3452(11)
	cmpw 0,10,0
	bc 12,2,.L61
.L65:
	lwz 0,492(4)
	cmpwi 0,0,0
	bc 4,2,.L61
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L61
	lwzx 4,30,28
	addi 3,31,4
	lwz 9,56(26)
	addi 4,4,4
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,2,.L61
	lwzx 0,30,28
	li 3,1
	stw 0,540(31)
	b .L68
.L61:
	lwz 0,num_players@l(25)
	addi 29,29,1
	addi 30,30,4
	cmpw 0,29,0
	bc 4,1,.L62
.L60:
	li 3,0
.L68:
	lwz 0,52(1)
	mtlr 0
	lmw 25,12(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe4:
	.size	 ACEAI_FindEnemy,.Lfe4-ACEAI_FindEnemy
	.section	".rodata"
	.align 2
.LC29:
	.string	"railgun"
	.align 2
.LC30:
	.string	"bfg10k"
	.align 2
.LC31:
	.string	"rocket launcher"
	.align 2
.LC32:
	.string	"grenade launcher"
	.align 2
.LC33:
	.string	"hyperblaster"
	.align 2
.LC34:
	.string	"chaingun"
	.align 2
.LC35:
	.string	"machinegun"
	.align 2
.LC36:
	.string	"super shotgun"
	.align 2
.LC37:
	.string	"shotgun"
	.align 2
.LC38:
	.string	"blaster"
	.align 2
.LC39:
	.long 0x43960000
	.align 2
.LC40:
	.long 0xc1000000
	.align 2
.LC41:
	.long 0x41000000
	.align 3
.LC42:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC43:
	.long 0x42c80000
	.align 2
.LC44:
	.long 0x43fa0000
	.align 2
.LC45:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl ACEAI_ChooseWeapon
	.type	 ACEAI_ChooseWeapon,@function
ACEAI_ChooseWeapon:
	stwu 1,-112(1)
	mflr 0
	stfd 31,104(1)
	stmw 28,88(1)
	stw 0,116(1)
	mr 31,3
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 12,2,.L71
	lis 3,.LC29@ha
	la 3,.LC29@l(3)
	bl FindItem
	mr 4,3
	mr 3,31
	bl ACEIT_ChangeWeapon
	cmpwi 0,3,0
	bc 4,2,.L71
	lwz 9,540(31)
	addi 3,1,8
	lfs 13,4(31)
	lfs 0,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	lis 9,.LC39@ha
	fmr 31,1
	la 9,.LC39@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 4,1,.L74
	lwz 9,84(31)
	addi 30,31,4
	lwz 0,824(9)
	cmpwi 0,0,50
	bc 4,1,.L75
	lis 11,.LC40@ha
	lis 9,.LC40@ha
	la 11,.LC40@l(11)
	la 9,.LC40@l(9)
	lfs 1,0(11)
	lis 29,gi@ha
	lis 11,.LC40@ha
	lfs 2,0(9)
	la 29,gi@l(29)
	la 11,.LC40@l(11)
	lfs 3,0(11)
	bl tv
	lis 9,.LC41@ha
	lis 11,.LC41@ha
	la 9,.LC41@l(9)
	la 11,.LC41@l(11)
	lfs 1,0(9)
	mr 28,3
	lis 9,.LC41@ha
	lfs 2,0(11)
	la 9,.LC41@l(9)
	lfs 3,0(9)
	bl tv
	lwz 7,540(31)
	mr 6,3
	li 9,25
	lwz 0,48(29)
	mr 5,28
	addi 3,1,24
	addi 7,7,4
	mr 4,30
	mr 8,31
	mtlr 0
	blrl
	lfs 0,32(1)
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L75
	lis 3,.LC30@ha
	la 3,.LC30@l(3)
	bl FindItem
	mr 4,3
	mr 3,31
	bl ACEIT_ChangeWeapon
	cmpwi 0,3,0
	bc 4,2,.L71
.L75:
	lis 9,.LC40@ha
	lis 11,.LC40@ha
	la 9,.LC40@l(9)
	la 11,.LC40@l(11)
	lfs 1,0(9)
	lis 29,gi@ha
	lis 9,.LC40@ha
	lfs 2,0(11)
	la 29,gi@l(29)
	la 9,.LC40@l(9)
	lfs 3,0(9)
	bl tv
	lis 9,.LC41@ha
	lis 11,.LC41@ha
	la 9,.LC41@l(9)
	la 11,.LC41@l(11)
	lfs 1,0(9)
	mr 28,3
	lis 9,.LC41@ha
	lfs 2,0(11)
	la 9,.LC41@l(9)
	lfs 3,0(9)
	bl tv
	lwz 7,540(31)
	mr 6,3
	li 9,25
	lwz 0,48(29)
	mr 4,30
	mr 5,28
	addi 7,7,4
	addi 3,1,24
	mr 8,31
	mtlr 0
	blrl
	lfs 0,32(1)
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L74
	lis 3,.LC31@ha
	la 3,.LC31@l(3)
	bl FindItem
	mr 4,3
	mr 3,31
	bl ACEIT_ChangeWeapon
	cmpwi 0,3,0
	bc 4,2,.L71
.L74:
	lis 9,.LC43@ha
	lis 11,.LC44@ha
	la 9,.LC43@l(9)
	la 11,.LC44@l(11)
	lfs 13,0(9)
	lfs 0,0(11)
	fcmpu 6,31,13
	fcmpu 7,31,0
	mfcr 9
	rlwinm 0,9,26,1
	rlwinm 9,9,29,1
	and. 11,0,9
	bc 12,2,.L82
	lwz 9,540(31)
	lis 11,.LC45@ha
	la 11,.LC45@l(11)
	lfs 12,12(31)
	lfs 13,0(11)
	lfs 0,12(9)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,0,.L82
	lis 3,.LC32@ha
	la 3,.LC32@l(3)
	bl FindItem
	mr 4,3
	mr 3,31
	bl ACEIT_ChangeWeapon
	cmpwi 0,3,0
	bc 4,2,.L71
.L82:
	lis 3,.LC33@ha
	la 3,.LC33@l(3)
	bl FindItem
	mr 4,3
	mr 3,31
	bl ACEIT_ChangeWeapon
	cmpwi 0,3,0
	bc 4,2,.L71
	lwz 9,84(31)
	lwz 0,820(9)
	cmpwi 0,0,49
	bc 4,1,.L85
	lis 3,.LC34@ha
	la 3,.LC34@l(3)
	bl FindItem
	mr 4,3
	mr 3,31
	bl ACEIT_ChangeWeapon
	cmpwi 0,3,0
	bc 4,2,.L71
.L85:
	lis 3,.LC35@ha
	la 3,.LC35@l(3)
	bl FindItem
	mr 4,3
	mr 3,31
	bl ACEIT_ChangeWeapon
	cmpwi 0,3,0
	bc 4,2,.L71
	lis 3,.LC36@ha
	la 3,.LC36@l(3)
	bl FindItem
	mr 4,3
	mr 3,31
	bl ACEIT_ChangeWeapon
	cmpwi 0,3,0
	bc 4,2,.L71
	lis 3,.LC37@ha
	la 3,.LC37@l(3)
	bl FindItem
	mr 4,3
	mr 3,31
	bl ACEIT_ChangeWeapon
	cmpwi 0,3,0
	bc 4,2,.L71
	lis 3,.LC38@ha
	la 3,.LC38@l(3)
	bl FindItem
	mr 4,3
	mr 3,31
	bl ACEIT_ChangeWeapon
.L71:
	lwz 0,116(1)
	mtlr 0
	lmw 28,88(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe5:
	.size	 ACEAI_ChooseWeapon,.Lfe5-ACEAI_ChooseWeapon
	.section	".rodata"
	.align 2
.LC46:
	.long 0xc1000000
	.align 2
.LC47:
	.long 0x41000000
	.align 3
.LC48:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ACEAI_CheckShot
	.type	 ACEAI_CheckShot,@function
ACEAI_CheckShot:
	stwu 1,-96(1)
	mflr 0
	stmw 26,72(1)
	stw 0,100(1)
	lis 9,.LC46@ha
	lis 29,gi@ha
	la 9,.LC46@l(9)
	mr 28,3
	lfs 1,0(9)
	la 29,gi@l(29)
	addi 27,28,4
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 2,0(9)
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 3,0(9)
	bl tv
	lis 9,.LC47@ha
	mr 26,3
	la 9,.LC47@l(9)
	lfs 1,0(9)
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	lfs 2,0(9)
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	lfs 3,0(9)
	bl tv
	lwz 7,540(28)
	mr 6,3
	li 9,25
	lwz 0,48(29)
	addi 3,1,8
	mr 4,27
	mr 5,26
	addi 7,7,4
	mr 8,28
	mtlr 0
	blrl
	lfs 0,16(1)
	lis 9,.LC48@ha
	la 9,.LC48@l(9)
	lfd 13,0(9)
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,31,1
	lwz 0,100(1)
	mtlr 0
	lmw 26,72(1)
	la 1,96(1)
	blr
.Lfe6:
	.size	 ACEAI_CheckShot,.Lfe6-ACEAI_CheckShot
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
