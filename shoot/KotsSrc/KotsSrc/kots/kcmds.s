	.file	"kcmds.cpp"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"This is not kots teamplay.\n"
	.align 2
.LC1:
	.string	"%s\n"
	.align 2
.LC2:
	.string	"You are on the %s Team\n"
	.align 2
.LC3:
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSCmd_Team
	.type	 KOTSCmd_Team,@function
KOTSCmd_Team:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L2
	lwz 9,84(31)
	lwz 0,3580(9)
	mr 10,9
	cmpwi 0,0,0
	bc 12,2,.L2
	lis 9,.LC3@ha
	lis 11,kots_teamplay@ha
	la 9,.LC3@l(9)
	lfs 13,0(9)
	lwz 9,kots_teamplay@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L5
	lis 9,gi+8@ha
	lis 5,.LC0@ha
	lwz 0,gi+8@l(9)
	la 5,.LC0@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L2
.L5:
	lis 9,game@ha
	li 30,0
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,30,0
	bc 4,0,.L7
	lis 9,gi@ha
	mr 26,11
	la 25,gi@l(9)
	lis 27,g_edicts@ha
	lis 28,.LC1@ha
	li 29,976
.L9:
	lwz 0,g_edicts@l(27)
	add 6,0,29
	lwz 9,88(6)
	cmpwi 0,9,0
	bc 12,2,.L8
	lwz 6,84(6)
	cmpwi 0,6,0
	bc 12,2,.L8
	lwz 0,3580(6)
	cmpwi 0,0,0
	bc 12,2,.L8
	lwz 9,84(31)
	lwz 11,3584(6)
	lwz 0,3584(9)
	cmpw 0,11,0
	bc 4,2,.L8
	lwz 9,8(25)
	addi 6,6,700
	mr 3,31
	li 4,1
	la 5,.LC1@l(28)
	mtlr 9
	crxor 6,6,6
	blrl
.L8:
	lwz 0,1544(26)
	addi 30,30,1
	addi 29,29,976
	lwz 10,84(31)
	cmpw 0,30,0
	bc 12,0,.L9
.L7:
	lwz 0,3584(10)
	cmpwi 0,0,0
	bc 4,2,.L15
	lis 9,kots_skin1@ha
	lwz 11,kots_skin1@l(9)
	b .L18
.L15:
	lis 9,kots_skin2@ha
	lwz 11,kots_skin2@l(9)
.L18:
	lwz 5,4(11)
	lis 9,gi+12@ha
	lis 4,.LC2@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC2@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L2:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 KOTSCmd_Team,.Lfe1-KOTSCmd_Team
	.section	".rodata"
	.align 2
.LC4:
	.string	"That team has too many people.\n"
	.align 2
.LC5:
	.string	"%s Switches to Team %s\n"
	.align 2
.LC6:
	.long 0x0
	.align 2
.LC7:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl KOTSCmd_ChangeTeams
	.type	 KOTSCmd_ChangeTeams,@function
KOTSCmd_ChangeTeams:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	li 4,0
	addi 3,1,8
	li 5,8
	mr 30,3
	bl memset
	lwz 9,84(31)
	lwz 0,3580(9)
	cmpwi 0,0,0
	bc 12,2,.L19
	lis 9,.LC6@ha
	lis 11,kots_teamplay@ha
	la 9,.LC6@l(9)
	lfs 13,0(9)
	lwz 9,kots_teamplay@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L21
	lis 9,gi+8@ha
	lis 5,.LC0@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC0@l(5)
	b .L39
.L21:
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpwi 0,0,0
	bc 4,1,.L23
	lis 9,g_edicts@ha
	mtctr 0
	mr 10,30
	lwz 11,g_edicts@l(9)
	addi 11,11,976
.L25:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L24
	lwz 9,84(11)
	cmpwi 0,9,0
	bc 12,2,.L24
	lwz 0,3580(9)
	cmpwi 0,0,0
	bc 12,2,.L24
	lwz 0,3584(9)
	slwi 0,0,2
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
.L24:
	addi 11,11,976
	bdnz .L25
.L23:
	lwz 9,84(31)
	lwz 11,3584(9)
	mr 10,9
	cmpwi 0,11,1
	bc 4,2,.L32
	lwz 9,4(30)
	lwz 0,8(1)
	cmpw 0,9,0
	bc 12,0,.L31
.L32:
	cmpwi 0,11,0
	bc 4,2,.L30
	lwz 9,8(1)
	lwz 0,4(30)
	cmpw 0,9,0
	bc 4,0,.L30
.L31:
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC4@l(5)
.L39:
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L19
.L30:
	lwz 0,3584(10)
	mr 3,31
	subfic 9,0,0
	adde 0,9,0
	stw 0,3584(10)
	bl KOTSAssignSkin
	lis 29,gi@ha
	lwz 5,84(31)
	mr 28,3
	lwz 9,gi@l(29)
	lis 4,.LC5@ha
	li 3,2
	la 4,.LC5@l(4)
	addi 5,5,700
	mtlr 9
	mr 6,28
	la 29,gi@l(29)
	crxor 6,6,6
	blrl
	lwz 0,12(29)
	lis 4,.LC2@ha
	mr 5,28
	la 4,.LC2@l(4)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
	li 8,0
	lwz 11,84(31)
	lis 9,.LC7@ha
	stw 8,916(31)
	la 9,.LC7@l(9)
	lis 10,level+4@ha
	stw 8,920(31)
	stw 8,924(31)
	stw 8,3560(11)
	lfs 12,0(9)
	lwz 9,84(31)
	stw 8,1860(9)
	lwz 11,84(31)
	stw 8,1864(11)
	lwz 9,84(31)
	stw 8,3948(9)
	lwz 11,84(31)
	stw 8,3952(11)
	lwz 9,84(31)
	lfs 0,level+4@l(10)
	lfs 13,3916(9)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L19
	lwz 0,3584(9)
	addic 9,0,-1
	subfe 9,9,9
	slwi 0,0,2
	rlwinm 9,9,0,29,29
	lwzx 11,30,0
	lwzx 0,9,30
	addi 11,11,1
	cmpw 0,11,0
	bc 4,0,.L34
	mr 3,31
	bl KOTSTeleport__FP7edict_s
	b .L19
.L34:
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L19
	lwz 0,264(31)
	mr 3,31
	lis 11,meansOfDeath@ha
	stw 8,480(31)
	li 9,23
	lis 6,0x1
	rlwinm 0,0,0,28,26
	lis 7,vec3_origin@ha
	stw 0,264(31)
	la 7,vec3_origin@l(7)
	mr 4,3
	stw 9,meansOfDeath@l(11)
	mr 5,3
	ori 6,6,34464
	bl player_die
.L19:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 KOTSCmd_ChangeTeams,.Lfe2-KOTSCmd_ChangeTeams
	.section	".rodata"
	.align 2
.LC8:
	.string	"you don't rate kicking!\n"
	.align 2
.LC9:
	.string	"you don't have a helmet!\n"
	.align 2
.LC10:
	.string	"you don't rate tballing!\n"
	.align 2
.LC11:
	.string	"KOTS No TBall: Deactivated\n"
	.align 2
.LC12:
	.string	"you don't rate no tball!\n"
	.align 2
.LC13:
	.string	"KOTS No TBall: Activated\n"
	.section	".text"
	.align 2
	.globl KOTSCmd_NoTBall
	.type	 KOTSCmd_NoTBall,@function
KOTSCmd_NoTBall:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr. 30,3
	bc 12,2,.L71
	lwz 11,84(30)
	cmpwi 0,11,0
	bc 12,2,.L71
	lwz 0,1816(11)
	cmpwi 0,0,0
	bc 12,2,.L71
	li 0,0
	lis 9,gi+8@ha
	stw 0,1816(11)
	lis 5,.LC11@ha
	mr 3,30
	lwz 0,gi+8@l(9)
	la 5,.LC11@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L70
.L71:
	lis 9,.LC12@ha
	mr 3,30
	la 28,.LC12@l(9)
	li 29,0
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	li 0,0
	bc 12,2,.L74
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L75
	lwz 9,84(30)
	lwz 0,3580(9)
	cmpwi 0,0,0
	bc 4,2,.L76
.L75:
	li 0,0
	b .L74
.L76:
	addi 31,3,8
	lwz 9,269(31)
	cmpwi 0,9,0
	bc 12,1,.L77
	lis 9,gi+8@ha
	mr 5,28
	lwz 0,gi+8@l(9)
	mr 3,30
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	stw 29,269(31)
	b .L78
.L77:
	addi 0,9,-1
	li 29,1
	stw 0,269(31)
.L78:
	mr 0,29
.L74:
	cmpwi 0,0,0
	bc 12,2,.L70
	lwz 9,84(30)
	li 0,1
	lis 11,gi+8@ha
	lis 5,.LC13@ha
	mr 3,30
	stw 0,1816(9)
	la 5,.LC13@l(5)
	li 4,1
	lwz 0,gi+8@l(11)
	mtlr 0
	crxor 6,6,6
	blrl
.L70:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 KOTSCmd_NoTBall,.Lfe3-KOTSCmd_NoTBall
	.section	".rodata"
	.align 2
.LC14:
	.string	"KOTS Stop TBall: Deactivated\n"
	.align 2
.LC15:
	.string	"you don't rate stop tball!\n"
	.align 2
.LC16:
	.string	"KOTS Stop TBall: Activated\n"
	.section	".text"
	.align 2
	.globl KOTSCmd_StopTBall
	.type	 KOTSCmd_StopTBall,@function
KOTSCmd_StopTBall:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr. 30,3
	bc 12,2,.L80
	lwz 11,84(30)
	cmpwi 0,11,0
	bc 12,2,.L80
	lwz 0,1820(11)
	cmpwi 0,0,0
	bc 12,2,.L80
	li 0,0
	lis 9,gi+8@ha
	stw 0,1820(11)
	lis 5,.LC14@ha
	mr 3,30
	lwz 0,gi+8@l(9)
	la 5,.LC14@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L79
.L80:
	lis 9,.LC15@ha
	mr 3,30
	la 28,.LC15@l(9)
	li 29,0
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	li 0,0
	bc 12,2,.L83
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L84
	lwz 9,84(30)
	lwz 0,3580(9)
	cmpwi 0,0,0
	bc 4,2,.L85
.L84:
	li 0,0
	b .L83
.L85:
	addi 31,3,12
	lwz 9,269(31)
	cmpwi 0,9,0
	bc 12,1,.L86
	lis 9,gi+8@ha
	mr 5,28
	lwz 0,gi+8@l(9)
	mr 3,30
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	stw 29,269(31)
	b .L87
.L86:
	addi 0,9,-1
	li 29,1
	stw 0,269(31)
.L87:
	mr 0,29
.L83:
	cmpwi 0,0,0
	bc 12,2,.L79
	lwz 9,84(30)
	li 0,1
	lis 11,gi+8@ha
	lis 5,.LC16@ha
	mr 3,30
	stw 0,1820(9)
	la 5,.LC16@l(5)
	li 4,1
	lwz 0,gi+8@l(11)
	mtlr 0
	crxor 6,6,6
	blrl
.L79:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 KOTSCmd_StopTBall,.Lfe4-KOTSCmd_StopTBall
	.section	".rodata"
	.align 2
.LC17:
	.string	"KOTS Help System Activated\n"
	.align 2
.LC18:
	.string	"KOTS Help System Deactivated\n"
	.align 2
.LC19:
	.string	"you don't rate cloaking!!!\n"
	.align 2
.LC20:
	.string	"Power Cube"
	.align 2
.LC21:
	.string	"You don't have enough power to cloak\n"
	.align 2
.LC22:
	.string	"%s cloaks\n"
	.align 2
.LC23:
	.string	"Cloaking Disabled\n"
	.section	".text"
	.align 2
	.globl KOTSCmd_Cloak
	.type	 KOTSCmd_Cloak,@function
KOTSCmd_Cloak:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L91
	lwz 28,492(31)
	cmpwi 0,28,0
	bc 4,2,.L91
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,12
	bc 12,1,.L94
	lis 9,gi+8@ha
	lis 5,.LC19@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC19@l(5)
	b .L98
.L94:
	lwz 29,84(31)
	lwz 0,1844(29)
	cmpwi 0,0,0
	bc 4,2,.L95
	lis 27,.LC20@ha
	lis 30,0x286b
	la 3,.LC20@l(27)
	ori 30,30,51739
	bl FindItem
	addi 11,29,740
	lis 9,itemlist@ha
	la 29,itemlist@l(9)
	subf 3,29,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,11,3
	cmpwi 0,0,0
	bc 12,1,.L96
	lis 9,gi+8@ha
	lis 5,.LC21@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC21@l(5)
.L98:
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L91
.L96:
	la 3,.LC20@l(27)
	bl FindItem
	subf 0,29,3
	lwz 11,84(31)
	lis 10,gi@ha
	mullw 0,0,30
	lis 4,.LC22@ha
	li 3,1
	addi 11,11,740
	la 4,.LC22@l(4)
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
	lwz 0,gi@l(10)
	lwz 5,84(31)
	mtlr 0
	addi 5,5,700
	crxor 6,6,6
	blrl
	lwz 0,184(31)
	li 10,1
	lwz 11,84(31)
	ori 0,0,1
	stw 0,184(31)
	stw 28,1848(11)
	lwz 9,84(31)
	stw 10,1844(9)
	b .L91
.L95:
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	la 5,.LC23@l(5)
	mr 3,31
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,184(31)
	lwz 9,84(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	stw 28,1844(9)
.L91:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 KOTSCmd_Cloak,.Lfe5-KOTSCmd_Cloak
	.section	".rodata"
	.align 2
.LC24:
	.string	"you don't rate low gravity!!!\n"
	.align 2
.LC25:
	.string	"You don't have enough power to fly\n"
	.align 2
.LC26:
	.string	"Low Gravity Enabled\n"
	.align 2
.LC27:
	.string	"Low Gravity Disabled\n"
	.section	".text"
	.align 2
	.globl KOTSCmd_Fly
	.type	 KOTSCmd_Fly,@function
KOTSCmd_Fly:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L99
	lwz 28,492(31)
	cmpwi 0,28,0
	bc 4,2,.L99
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,11
	bc 12,1,.L102
	lis 9,gi+8@ha
	lis 5,.LC24@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC24@l(5)
	b .L106
.L102:
	lwz 29,84(31)
	lwz 0,1852(29)
	cmpwi 0,0,0
	bc 4,2,.L103
	lis 27,.LC20@ha
	lis 30,0x286b
	la 3,.LC20@l(27)
	ori 30,30,51739
	bl FindItem
	addi 11,29,740
	lis 9,itemlist@ha
	la 29,itemlist@l(9)
	subf 3,29,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,11,3
	cmpwi 0,0,0
	bc 12,1,.L104
	lis 9,gi+8@ha
	lis 5,.LC25@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC25@l(5)
.L106:
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L99
.L104:
	la 3,.LC20@l(27)
	bl FindItem
	subf 0,29,3
	lwz 11,84(31)
	lis 10,gi+8@ha
	mullw 0,0,30
	lis 5,.LC26@ha
	mr 3,31
	addi 11,11,740
	la 5,.LC26@l(5)
	rlwinm 0,0,0,0,29
	li 4,1
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
	lwz 0,gi+8@l(10)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,1
	stw 28,1856(11)
	lwz 9,84(31)
	stw 0,1852(9)
	b .L99
.L103:
	lis 9,gi+8@ha
	lis 5,.LC27@ha
	lwz 0,gi+8@l(9)
	la 5,.LC27@l(5)
	mr 3,31
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	stw 28,1852(9)
.L99:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 KOTSCmd_Fly,.Lfe6-KOTSCmd_Fly
	.section	".rodata"
	.align 3
.LC28:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC29:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC30:
	.long 0x46000000
	.align 2
.LC31:
	.long 0x3f800000
	.align 2
.LC32:
	.long 0xc0800000
	.section	".text"
	.align 2
	.globl LaserSightThink__FP7edict_s
	.type	 LaserSightThink__FP7edict_s,@function
LaserSightThink__FP7edict_s:
	stwu 1,-288(1)
	mflr 0
	stmw 27,268(1)
	stw 0,292(1)
	mr 31,3
	lwz 29,256(31)
	lwz 0,492(29)
	cmpwi 0,0,0
	bc 4,2,.L110
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L110
	lwz 3,84(29)
	lwz 0,1836(3)
	cmpwi 0,0,0
	bc 4,2,.L109
.L110:
	mr 3,31
	bl G_FreeEdict
	lwz 9,84(29)
	li 0,0
	stw 0,1836(9)
	b .L108
.L109:
	addi 30,1,72
	addi 29,1,88
	addi 6,1,104
	addi 3,3,3760
	mr 4,30
	mr 5,29
	bl AngleVectors
	lwz 3,256(31)
	lis 9,0x40c0
	lis 0,0x41c0
	stw 9,60(1)
	addi 28,1,24
	lis 9,.LC29@ha
	stw 0,56(1)
	addi 27,1,184
	la 9,.LC29@l(9)
	lis 0,0x4330
	lfd 13,0(9)
	addi 7,1,8
	addi 4,1,56
	lwz 9,508(3)
	mr 6,29
	mr 5,30
	addi 3,3,4
	addi 9,9,-7
	xoris 9,9,0x8000
	stw 9,260(1)
	stw 0,256(1)
	lfd 0,256(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	bl G_ProjectSource
	lis 9,.LC30@ha
	addi 3,1,8
	la 9,.LC30@l(9)
	mr 4,30
	lfs 1,0(9)
	mr 5,28
	bl VectorMA
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 8,256(31)
	lwz 0,gi+48@l(11)
	addi 4,1,8
	ori 9,9,1
	mr 7,28
	mr 3,27
	li 5,0
	li 6,0
	mtlr 0
	blrl
	mr 4,27
	addi 3,1,120
	li 5,56
	crxor 6,6,6
	bl memcpy
	lis 9,.LC31@ha
	lfs 13,128(1)
	la 9,.LC31@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L111
	lis 11,.LC32@ha
	mr 4,30
	la 11,.LC32@l(11)
	addi 3,1,132
	lfs 1,0(11)
	addi 5,1,40
	bl VectorMA
	lfs 0,40(1)
	lfs 13,44(1)
	lfs 12,48(1)
	stfs 0,132(1)
	stfs 13,136(1)
	stfs 12,140(1)
.L111:
	lwz 9,172(1)
	lwz 0,184(9)
	andi. 11,0,4
	bc 4,2,.L113
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L112
.L113:
	lwz 0,512(9)
	cmpwi 0,0,0
	bc 12,2,.L115
	lwz 0,256(31)
	cmpw 0,9,0
	bc 12,2,.L115
	li 0,1
.L112:
	stw 0,60(31)
.L115:
	addi 3,1,144
	addi 4,31,16
	bl vectoangles
	lfs 0,136(1)
	lis 9,gi+72@ha
	mr 3,31
	lfs 13,140(1)
	lfs 12,132(1)
	stfs 0,8(31)
	stfs 13,12(31)
	stfs 12,4(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC28@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC28@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L108:
	lwz 0,292(1)
	mtlr 0
	lmw 27,268(1)
	la 1,288(1)
	blr
.Lfe7:
	.size	 LaserSightThink__FP7edict_s,.Lfe7-LaserSightThink__FP7edict_s
	.section	".rodata"
	.align 2
.LC33:
	.string	"you don't rate the lasersight!!!\n"
	.align 2
.LC34:
	.string	"lasersight off.\n"
	.align 2
.LC35:
	.string	"lasersight on.\n"
	.align 2
.LC36:
	.string	"lasersight"
	.align 2
.LC37:
	.string	"models/objects/flash/tris.md2"
	.align 3
.LC38:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl KOTSCmd_Laser
	.type	 KOTSCmd_Laser,@function
KOTSCmd_Laser:
	stwu 1,-96(1)
	mflr 0
	stmw 26,72(1)
	stw 0,100(1)
	mr 31,3
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L116
	lwz 29,492(31)
	cmpwi 0,29,0
	bc 4,2,.L116
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,9
	bc 12,1,.L119
	lis 9,gi+8@ha
	lis 5,.LC33@ha
	lwz 0,gi+8@l(9)
	la 5,.LC33@l(5)
	mr 3,31
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	stw 29,1836(9)
	b .L116
.L119:
	lwz 9,84(31)
	lwz 30,1836(9)
	cmpwi 0,30,0
	bc 12,2,.L120
	stw 29,1836(9)
	lis 5,.LC34@ha
	mr 3,31
	lis 9,gi+8@ha
	la 5,.LC34@l(5)
	lwz 0,gi+8@l(9)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L116
.L120:
	li 26,1
	lis 28,gi@ha
	la 28,gi@l(28)
	stw 26,1836(9)
	lis 5,.LC35@ha
	lwz 9,8(28)
	mr 3,31
	la 5,.LC35@l(5)
	li 4,1
	addi 29,1,24
	mtlr 9
	addi 27,1,40
	crxor 6,6,6
	blrl
	lwz 3,84(31)
	mr 4,29
	mr 5,27
	li 6,0
	addi 3,3,3760
	bl AngleVectors
	li 9,0
	lis 0,0x42c8
	mr 5,29
	stw 9,64(1)
	addi 7,1,8
	stw 0,56(1)
	mr 6,27
	addi 4,1,56
	stw 9,60(1)
	addi 3,31,4
	bl G_ProjectSource
	bl G_Spawn
	lis 9,.LC36@ha
	mr 29,3
	la 9,.LC36@l(9)
	stw 31,256(29)
	lis 3,.LC37@ha
	stw 9,280(29)
	la 3,.LC37@l(3)
	stw 26,260(29)
	stw 30,248(29)
	lwz 0,32(28)
	mtlr 0
	blrl
	lwz 0,68(29)
	lis 9,LaserSightThink__FP7edict_s@ha
	lis 10,level+4@ha
	la 9,LaserSightThink__FP7edict_s@l(9)
	stw 3,40(29)
	lis 11,.LC38@ha
	ori 0,0,1032
	stw 30,60(29)
	stw 0,68(29)
	stw 9,436(29)
	lfs 0,level+4@l(10)
	lfd 13,.LC38@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
.L116:
	lwz 0,100(1)
	mtlr 0
	lmw 26,72(1)
	la 1,96(1)
	blr
.Lfe8:
	.size	 KOTSCmd_Laser,.Lfe8-KOTSCmd_Laser
	.section	".rodata"
	.align 2
.LC39:
	.string	"you don't rate the hook!!!\n"
	.align 2
.LC40:
	.string	"action"
	.align 2
.LC41:
	.string	"you don't have enough power to fire the hook!\n"
	.align 2
.LC42:
	.string	"stop"
	.align 2
.LC43:
	.string	"grow"
	.align 2
.LC44:
	.string	"shrink"
	.section	".text"
	.align 2
	.globl KOTSCmd_Hook
	.type	 KOTSCmd_Hook,@function
KOTSCmd_Hook:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 30,3
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L121
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 4,2,.L121
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,3
	bc 12,1,.L124
	lis 9,gi+8@ha
	lis 5,.LC39@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC39@l(5)
	b .L132
.L124:
	lis 9,gi@ha
	li 3,1
	la 25,gi@l(9)
	lwz 9,160(25)
	mtlr 9
	blrl
	lwz 0,248(30)
	mr 29,3
	lwz 28,84(30)
	cmpwi 0,0,0
	addi 31,28,1832
	bc 12,2,.L125
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 4,2,.L125
	lwz 0,1832(28)
	xori 0,0,1
	andi. 9,0,1
	bc 12,2,.L125
	lis 4,.LC40@ha
	la 4,.LC40@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L125
	lis 26,.LC20@ha
	lwz 29,84(30)
	lis 31,0x286b
	la 3,.LC20@l(26)
	ori 31,31,51739
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 27,itemlist@l(9)
	subf 3,27,3
	mullw 3,3,31
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,4
	bc 12,1,.L126
	lwz 0,8(25)
	lis 5,.LC41@ha
	mr 3,30
	la 5,.LC41@l(5)
.L132:
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L121
.L126:
	la 3,.LC20@l(26)
	bl FindItem
	subf 0,27,3
	lwz 11,84(30)
	li 10,1
	mullw 0,0,31
	mr 3,30
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	addi 9,9,-5
	stwx 9,11,0
	stw 10,1832(28)
	bl FireHook
	b .L121
.L125:
	lwz 0,0(31)
	andi. 9,0,1
	bc 12,2,.L121
	lis 4,.LC40@ha
	mr 3,29
	la 4,.LC40@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L128
	stw 3,0(31)
	b .L121
.L128:
	lis 4,.LC42@ha
	mr 3,29
	la 4,.LC42@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L129
	lwz 0,0(31)
	rlwinm 9,0,0,28,29
	subf 0,9,0
	b .L133
.L129:
	lis 4,.LC43@ha
	mr 3,29
	la 4,.LC43@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L130
	lwz 0,0(31)
	ori 0,0,8
	rlwinm 0,0,0,30,28
	b .L133
.L130:
	lis 4,.LC44@ha
	mr 3,29
	la 4,.LC44@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L121
	lwz 0,0(31)
	ori 0,0,4
	rlwinm 0,0,0,29,27
.L133:
	stw 0,0(31)
.L121:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 KOTSCmd_Hook,.Lfe9-KOTSCmd_Hook
	.section	".rodata"
	.align 2
.LC45:
	.string	"you don't rate making mega health!!!\n"
	.align 2
.LC46:
	.string	"you don't rate bfgball!\n"
	.align 2
.LC47:
	.long 0x46fffe00
	.align 2
.LC48:
	.long 0xc0000000
	.align 3
.LC49:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC50:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC51:
	.long 0x40200000
	.long 0x0
	.align 2
.LC52:
	.long 0x447a0000
	.section	".text"
	.align 2
	.globl KOTSCmd_BFGBall
	.type	 KOTSCmd_BFGBall,@function
KOTSCmd_BFGBall:
	stwu 1,-128(1)
	mflr 0
	stmw 25,100(1)
	stw 0,132(1)
	lis 9,.LC46@ha
	mr 31,3
	la 27,.LC46@l(9)
	bl KOTSGetUser__FP7edict_s
	li 28,0
	mr. 3,3
	li 0,0
	bc 12,2,.L153
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L154
	lwz 9,84(31)
	lwz 0,3580(9)
	cmpwi 0,0,0
	bc 4,2,.L155
.L154:
	li 0,0
	b .L153
.L155:
	addi 29,3,16
	lwz 9,269(29)
	cmpwi 0,9,0
	bc 12,1,.L156
	lis 9,gi+8@ha
	mr 5,27
	lwz 0,gi+8@l(9)
	mr 3,31
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	stw 28,269(29)
	b .L157
.L156:
	addi 0,9,-1
	li 28,1
	stw 0,269(29)
.L157:
	mr 0,28
.L153:
	cmpwi 0,0,0
	bc 12,2,.L150
	addi 29,1,40
	mr 3,31
	bl KOTSStopCloak
	lwz 3,84(31)
	addi 27,1,56
	addi 28,1,24
	mr 5,27
	li 6,0
	mr 4,29
	addi 3,3,3760
	bl AngleVectors
	lis 9,.LC48@ha
	lwz 4,84(31)
	mr 3,29
	la 9,.LC48@l(9)
	lfs 1,0(9)
	addi 4,4,3708
	bl VectorScale
	lwz 9,84(31)
	lis 0,0xc220
	stw 0,3724(9)
	bl rand
	rlwinm 3,3,0,17,31
	lwz 25,84(31)
	xoris 3,3,0x8000
	lis 26,0x4330
	stw 3,92(1)
	lis 10,.LC49@ha
	lis 11,.LC47@ha
	stw 26,88(1)
	la 10,.LC49@l(10)
	lis 0,0x4100
	lfd 9,0(10)
	addi 5,1,8
	mr 8,28
	lfd 13,88(1)
	lis 10,.LC50@ha
	mr 7,27
	lfs 10,.LC47@l(11)
	la 10,.LC50@l(10)
	lis 9,.LC51@ha
	lfd 11,0(10)
	la 9,.LC51@l(9)
	addi 4,31,4
	fsub 13,13,9
	lfd 12,0(9)
	mr 6,29
	lis 9,level+4@ha
	frsp 13,13
	fdivs 13,13,10
	fmr 0,13
	fsub 0,0,11
	fadd 0,0,0
	fmul 0,0,12
	frsp 0,0
	stfs 0,3720(25)
	lfs 13,level+4@l(9)
	lwz 11,84(31)
	fadd 13,13,11
	frsp 13,13
	stfs 13,3728(11)
	lwz 9,508(31)
	lwz 3,84(31)
	addi 9,9,-8
	stw 0,12(1)
	xoris 9,9,0x8000
	stw 0,8(1)
	stw 9,92(1)
	stw 26,88(1)
	lfd 0,88(1)
	fsub 0,0,9
	frsp 0,0
	stfs 0,16(1)
	bl P_ProjectSource
	lis 9,.LC52@ha
	mr 5,29
	la 9,.LC52@l(9)
	mr 3,31
	lfs 1,0(9)
	mr 4,28
	li 6,500
	li 7,1000
	bl fire_bfgball
	mr 3,31
	mr 4,28
	li 5,1
	bl PlayerNoise
.L150:
	lwz 0,132(1)
	mtlr 0
	lmw 25,100(1)
	la 1,128(1)
	blr
.Lfe10:
	.size	 KOTSCmd_BFGBall,.Lfe10-KOTSCmd_BFGBall
	.section	".rodata"
	.align 2
.LC53:
	.string	"boomerang"
	.align 2
.LC54:
	.string	"you don't have boomerang\n"
	.align 2
.LC55:
	.long 0x46fffe00
	.align 2
.LC56:
	.long 0xc0000000
	.align 3
.LC57:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC58:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC59:
	.long 0x40200000
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSCmd_Boomerang
	.type	 KOTSCmd_Boomerang,@function
KOTSCmd_Boomerang:
	stwu 1,-128(1)
	mflr 0
	stmw 25,100(1)
	stw 0,132(1)
	mr 31,3
	bl KOTSGetUser__FP7edict_s
	cmpwi 0,3,0
	bc 12,2,.L158
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L158
	lwz 29,84(31)
	lwz 0,3580(29)
	cmpwi 0,0,0
	bc 12,2,.L158
	lis 28,.LC53@ha
	lis 27,0x286b
	la 3,.LC53@l(28)
	ori 27,27,51739
	bl FindItem
	lis 9,itemlist@ha
	addi 11,29,740
	la 26,itemlist@l(9)
	subf 3,26,3
	mullw 3,3,27
	rlwinm 3,3,0,0,29
	lwzx 0,11,3
	cmpwi 0,0,0
	bc 4,2,.L162
	lis 9,gi+8@ha
	lis 5,.LC54@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC54@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L158
.L162:
	addi 29,1,40
	la 3,.LC53@l(28)
	bl FindItem
	subf 0,26,3
	lwz 11,84(31)
	addi 28,1,24
	mullw 0,0,27
	addi 25,1,56
	mr 3,31
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
	bl KOTSStopCloak
	lwz 3,84(31)
	mr 5,25
	li 6,0
	mr 4,29
	addi 3,3,3760
	bl AngleVectors
	lis 9,.LC56@ha
	lwz 4,84(31)
	mr 3,29
	la 9,.LC56@l(9)
	lfs 1,0(9)
	addi 4,4,3708
	bl VectorScale
	lwz 9,84(31)
	lis 0,0xc220
	stw 0,3724(9)
	bl rand
	rlwinm 3,3,0,17,31
	lwz 26,84(31)
	xoris 3,3,0x8000
	lis 27,0x4330
	stw 3,92(1)
	lis 10,.LC57@ha
	lis 11,.LC55@ha
	stw 27,88(1)
	la 10,.LC57@l(10)
	lis 0,0x4100
	lfd 9,0(10)
	addi 5,1,8
	mr 8,28
	lfd 13,88(1)
	lis 10,.LC58@ha
	mr 7,25
	lfs 10,.LC55@l(11)
	la 10,.LC58@l(10)
	lis 9,.LC59@ha
	lfd 11,0(10)
	la 9,.LC59@l(9)
	addi 4,31,4
	fsub 13,13,9
	lfd 12,0(9)
	mr 6,29
	lis 9,level+4@ha
	frsp 13,13
	fdivs 13,13,10
	fmr 0,13
	fsub 0,0,11
	fadd 0,0,0
	fmul 0,0,12
	frsp 0,0
	stfs 0,3720(26)
	lfs 13,level+4@l(9)
	lwz 11,84(31)
	fadd 13,13,11
	frsp 13,13
	stfs 13,3728(11)
	lwz 9,508(31)
	lwz 3,84(31)
	addi 9,9,-8
	stw 0,12(1)
	xoris 9,9,0x8000
	stw 0,8(1)
	stw 9,92(1)
	stw 27,88(1)
	lfd 0,88(1)
	fsub 0,0,9
	frsp 0,0
	stfs 0,16(1)
	bl P_ProjectSource
	mr 5,29
	mr 3,31
	mr 4,28
	li 6,500
	li 7,900
	bl fire_boomerang
	mr 3,31
	mr 4,28
	li 5,1
	bl PlayerNoise
.L158:
	lwz 0,132(1)
	mtlr 0
	lmw 25,100(1)
	la 1,128(1)
	blr
.Lfe11:
	.size	 KOTSCmd_Boomerang,.Lfe11-KOTSCmd_Boomerang
	.section	".rodata"
	.align 2
.LC60:
	.string	"you don't rate flash grenades!\n"
	.align 2
.LC61:
	.long 0x46fffe00
	.align 2
.LC62:
	.long 0xc0000000
	.align 3
.LC63:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC64:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC65:
	.long 0x40200000
	.long 0x0
	.align 2
.LC66:
	.long 0x43200000
	.align 2
.LC67:
	.long 0x40200000
	.section	".text"
	.align 2
	.globl KOTSCmd_Flash
	.type	 KOTSCmd_Flash,@function
KOTSCmd_Flash:
	stwu 1,-112(1)
	mflr 0
	stmw 26,88(1)
	stw 0,116(1)
	lis 9,.LC60@ha
	mr 31,3
	la 27,.LC60@l(9)
	bl KOTSGetUser__FP7edict_s
	li 28,0
	mr. 3,3
	li 0,0
	bc 12,2,.L166
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L167
	lwz 9,84(31)
	lwz 0,3580(9)
	cmpwi 0,0,0
	bc 4,2,.L168
.L167:
	li 0,0
	b .L166
.L168:
	addi 29,3,20
	lwz 9,269(29)
	cmpwi 0,9,0
	bc 12,1,.L169
	lis 9,gi+8@ha
	mr 5,27
	lwz 0,gi+8@l(9)
	mr 3,31
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	stw 28,269(29)
	b .L170
.L169:
	addi 0,9,-1
	li 28,1
	stw 0,269(29)
.L170:
	mr 0,28
.L166:
	cmpwi 0,0,0
	bc 12,2,.L163
	addi 28,1,40
	mr 3,31
	bl KOTSStopCloak
	lwz 3,84(31)
	addi 29,1,56
	addi 27,1,24
	mr 5,29
	li 6,0
	mr 4,28
	addi 3,3,3760
	bl AngleVectors
	lis 9,.LC62@ha
	lwz 4,84(31)
	mr 3,28
	la 9,.LC62@l(9)
	lfs 1,0(9)
	addi 4,4,3708
	bl VectorScale
	lwz 9,84(31)
	lis 0,0xc220
	stw 0,3724(9)
	bl rand
	rlwinm 3,3,0,17,31
	lwz 26,84(31)
	mr 7,29
	xoris 3,3,0x8000
	stw 3,84(1)
	lis 29,0x4330
	lis 10,.LC63@ha
	stw 29,80(1)
	la 10,.LC63@l(10)
	lis 11,.LC61@ha
	lfd 9,0(10)
	lis 3,level+4@ha
	lis 0,0x4100
	lfd 13,80(1)
	lis 10,.LC64@ha
	addi 5,1,8
	lfs 12,.LC61@l(11)
	la 10,.LC64@l(10)
	mr 8,27
	lfd 11,0(10)
	addi 4,31,4
	mr 6,28
	fsub 13,13,9
	lis 10,.LC65@ha
	la 10,.LC65@l(10)
	lfd 10,0(10)
	frsp 13,13
	mr 10,9
	fdivs 13,13,12
	fmr 0,13
	fsub 0,0,11
	fadd 0,0,0
	fmul 0,0,10
	frsp 0,0
	stfs 0,3720(26)
	lfs 13,level+4@l(3)
	lwz 11,84(31)
	fadd 13,13,11
	frsp 13,13
	stfs 13,3728(11)
	lwz 9,508(31)
	lwz 3,84(31)
	addi 9,9,-8
	stw 0,12(1)
	xoris 9,9,0x8000
	stw 0,8(1)
	stw 9,84(1)
	stw 29,80(1)
	lfd 0,80(1)
	fsub 0,0,9
	frsp 0,0
	stfs 0,16(1)
	bl P_ProjectSource
	lis 9,.LC66@ha
	lis 10,.LC67@ha
	la 9,.LC66@l(9)
	la 10,.LC67@l(10)
	lfs 2,0(9)
	mr 5,28
	mr 3,31
	lfs 1,0(10)
	mr 4,27
	li 6,600
	bl fire_flash_grenade
	mr 3,31
	mr 4,27
	li 5,1
	bl PlayerNoise
.L163:
	lwz 0,116(1)
	mtlr 0
	lmw 26,88(1)
	la 1,112(1)
	blr
.Lfe12:
	.size	 KOTSCmd_Flash,.Lfe12-KOTSCmd_Flash
	.section	".rodata"
	.align 2
.LC69:
	.string	"you don't rate exploding packs!\n"
	.align 2
.LC70:
	.string	"KOTS ExPack"
	.align 3
.LC71:
	.long 0x40368000
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSCmd_EXPack
	.type	 KOTSCmd_EXPack,@function
KOTSCmd_EXPack:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	lis 9,.LC69@ha
	mr 30,3
	la 28,.LC69@l(9)
	bl KOTSGetUser__FP7edict_s
	li 29,0
	mr. 3,3
	li 0,0
	bc 12,2,.L182
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L183
	lwz 9,84(30)
	lwz 0,3580(9)
	cmpwi 0,0,0
	bc 4,2,.L184
.L183:
	li 0,0
	b .L182
.L184:
	addi 31,3,24
	lwz 9,269(31)
	cmpwi 0,9,0
	bc 12,1,.L185
	lis 9,gi+8@ha
	mr 5,28
	lwz 0,gi+8@l(9)
	mr 3,30
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	stw 29,269(31)
	b .L186
.L185:
	addi 0,9,-1
	li 29,1
	stw 0,269(31)
.L186:
	mr 0,29
.L182:
	cmpwi 0,0,0
	bc 12,2,.L179
	lis 3,.LC70@ha
	la 3,.LC70@l(3)
	bl FindItem
	mr. 3,3
	bc 12,2,.L179
	lwz 11,84(30)
	lis 9,.LC71@ha
	mr 4,3
	lfd 31,.LC71@l(9)
	mr 3,30
	lfs 0,3764(11)
	fadd 0,0,31
	frsp 0,0
	stfs 0,3764(11)
	bl Drop_Item
	lwz 11,84(30)
	lis 9,kotsexplode_make_touchable__FP7edict_s@ha
	la 9,kotsexplode_make_touchable__FP7edict_s@l(9)
	lfs 0,3764(11)
	fsub 0,0,31
	frsp 0,0
	stfs 0,3764(11)
	stw 30,256(3)
	stw 9,436(3)
.L179:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 KOTSCmd_EXPack,.Lfe13-KOTSCmd_EXPack
	.align 2
	.globl KOTSCmd_Kick
	.type	 KOTSCmd_Kick,@function
KOTSCmd_Kick:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,.LC8@ha
	mr 30,3
	la 28,.LC8@l(9)
	bl KOTSGetUser__FP7edict_s
	li 29,0
	mr. 31,3
	li 0,0
	bc 12,2,.L49
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L50
	lwz 9,84(30)
	lwz 0,3580(9)
	cmpwi 0,0,0
	bc 4,2,.L51
.L50:
	li 0,0
	b .L49
.L51:
	lwz 9,269(31)
	cmpwi 0,9,0
	bc 12,1,.L52
	lis 9,gi+8@ha
	mr 5,28
	lwz 0,gi+8@l(9)
	mr 3,30
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	stw 29,269(31)
	b .L53
.L52:
	addi 0,9,-1
	li 29,1
	stw 0,269(31)
.L53:
	mr 0,29
.L49:
	cmpwi 0,0,0
	bc 12,2,.L46
	mr 3,30
	bl KOTSSpawnKick
.L46:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 KOTSCmd_Kick,.Lfe14-KOTSCmd_Kick
	.align 2
	.globl KOTSCmd_Helmet
	.type	 KOTSCmd_Helmet,@function
KOTSCmd_Helmet:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,.LC9@ha
	mr 30,3
	la 28,.LC9@l(9)
	bl KOTSGetUser__FP7edict_s
	li 29,0
	mr. 3,3
	li 0,0
	bc 12,2,.L57
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L58
	lwz 9,84(30)
	lwz 0,3580(9)
	cmpwi 0,0,0
	bc 4,2,.L59
.L58:
	li 0,0
	b .L57
.L59:
	addi 31,3,28
	lwz 9,269(31)
	cmpwi 0,9,0
	bc 12,1,.L60
	lis 9,gi+8@ha
	mr 5,28
	lwz 0,gi+8@l(9)
	mr 3,30
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	stw 29,269(31)
	b .L61
.L60:
	addi 0,9,-1
	li 29,1
	stw 0,269(31)
.L61:
	mr 0,29
.L57:
	cmpwi 0,0,0
	bc 12,2,.L54
	lwz 9,84(30)
	li 0,1
	stw 0,1840(9)
.L54:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 KOTSCmd_Helmet,.Lfe15-KOTSCmd_Helmet
	.align 2
	.globl KOTSCmd_TBall
	.type	 KOTSCmd_TBall,@function
KOTSCmd_TBall:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,.LC10@ha
	mr 30,3
	la 28,.LC10@l(9)
	bl KOTSGetUser__FP7edict_s
	li 29,0
	mr. 3,3
	li 0,0
	bc 12,2,.L65
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L66
	lwz 9,84(30)
	lwz 0,3580(9)
	cmpwi 0,0,0
	bc 4,2,.L67
.L66:
	li 0,0
	b .L65
.L67:
	addi 31,3,4
	lwz 9,269(31)
	cmpwi 0,9,0
	bc 12,1,.L68
	lis 9,gi+8@ha
	mr 5,28
	lwz 0,gi+8@l(9)
	mr 3,30
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	stw 29,269(31)
	b .L69
.L68:
	addi 0,9,-1
	li 29,1
	stw 0,269(31)
.L69:
	mr 0,29
.L65:
	cmpwi 0,0,0
	bc 12,2,.L62
	mr 3,30
	bl KOTSRadiusTeleport
.L62:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 KOTSCmd_TBall,.Lfe16-KOTSCmd_TBall
	.align 2
	.globl KOTSCmd_Help
	.type	 KOTSCmd_Help,@function
KOTSCmd_Help:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,896(3)
	subfic 9,0,0
	adde 0,9,0
	cmpwi 0,0,0
	stw 0,896(3)
	bc 12,2,.L89
	lis 9,gi+8@ha
	lis 5,.LC17@ha
	lwz 0,gi+8@l(9)
	la 5,.LC17@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L90
.L89:
	lis 9,gi+8@ha
	lis 5,.LC18@ha
	lwz 0,gi+8@l(9)
	la 5,.LC18@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
.L90:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 KOTSCmd_Help,.Lfe17-KOTSCmd_Help
	.align 2
	.globl KOTSSVCmd_Status_f
	.type	 KOTSSVCmd_Status_f,@function
KOTSSVCmd_Status_f:
	blr
.Lfe18:
	.size	 KOTSSVCmd_Status_f,.Lfe18-KOTSSVCmd_Status_f
	.align 2
	.globl KOTSCmd_MakeMega
	.type	 KOTSCmd_MakeMega,@function
KOTSCmd_MakeMega:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L134
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L134
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,7
	bc 12,1,.L137
	lis 9,gi+8@ha
	lis 5,.LC45@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC45@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L134
.L137:
	mr 3,31
	bl KOTSMakeMega
.L134:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe19:
	.size	 KOTSCmd_MakeMega,.Lfe19-KOTSCmd_MakeMega
	.section	".rodata"
	.align 2
.LC72:
	.long 0x3f800000
	.align 2
.LC73:
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSSendAll__FbPc
	.type	 KOTSSendAll__FbPc,@function
KOTSSendAll__FbPc:
	stwu 1,-48(1)
	mflr 0
	mfcr 12
	stmw 25,20(1)
	stw 0,52(1)
	stw 12,16(1)
	lis 9,game@ha
	li 30,0
	la 11,game@l(9)
	mr 29,4
	lwz 0,1544(11)
	cmpw 0,30,0
	bc 4,0,.L140
	cmpwi 4,3,0
	lis 9,gi@ha
	la 27,gi@l(9)
	mr 25,11
	lis 26,g_edicts@ha
	li 28,976
.L142:
	lwz 0,g_edicts@l(26)
	add 31,0,28
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L141
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L141
	lwz 0,3580(9)
	cmpwi 0,0,0
	bc 12,2,.L141
	lwz 0,3576(9)
	cmpwi 0,0,0
	bc 4,2,.L141
	bc 12,18,.L147
	lwz 9,36(27)
	mr 3,29
	mtlr 9
	blrl
	lis 9,.LC72@ha
	lwz 11,16(27)
	mr 5,3
	la 9,.LC72@l(9)
	li 4,5
	lfs 1,0(9)
	mr 3,31
	mtlr 11
	lis 9,.LC72@ha
	la 9,.LC72@l(9)
	lfs 2,0(9)
	lis 9,.LC73@ha
	la 9,.LC73@l(9)
	lfs 3,0(9)
	blrl
	b .L141
.L147:
	lwz 9,12(27)
	mr 3,31
	mr 4,29
	mtlr 9
	crxor 6,6,6
	blrl
.L141:
	lwz 0,1544(25)
	addi 30,30,1
	addi 28,28,976
	cmpw 0,30,0
	bc 12,0,.L142
.L140:
	lwz 0,52(1)
	lwz 12,16(1)
	mtlr 0
	lmw 25,20(1)
	mtcrf 8,12
	la 1,48(1)
	blr
.Lfe20:
	.size	 KOTSSendAll__FbPc,.Lfe20-KOTSSendAll__FbPc
	.section	".rodata"
	.align 2
.LC74:
	.long 0x41f00000
	.section	".text"
	.align 2
	.type	 kotsexplode_make_touchable__FP7edict_s,@function
kotsexplode_make_touchable__FP7edict_s:
	lis 9,Touch_Item@ha
	lis 11,level+4@ha
	la 9,Touch_Item@l(9)
	stw 9,444(3)
	lis 9,.LC74@ha
	lfs 0,level+4@l(11)
	la 9,.LC74@l(9)
	lfs 13,0(9)
	lis 9,G_FreeEdict@ha
	la 9,G_FreeEdict@l(9)
	fadds 0,0,13
	stw 9,436(3)
	stfs 0,428(3)
	blr
.Lfe21:
	.size	 kotsexplode_make_touchable__FP7edict_s,.Lfe21-kotsexplode_make_touchable__FP7edict_s
	.section	".rodata"
	.align 2
.LC75:
	.long 0xbca3d70a
	.section	".text"
	.align 2
	.globl KOTSPickup_KOTSExPack
	.type	 KOTSPickup_KOTSExPack,@function
KOTSPickup_KOTSExPack:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lis 6,vec3_origin@ha
	lwz 0,256(31)
	mr 3,4
	la 6,vec3_origin@l(6)
	li 11,35
	addi 29,31,4
	mr 4,0
	mr 7,29
	stw 11,12(1)
	li 0,0
	li 9,300
	stw 0,8(1)
	mr 8,6
	mr 5,4
	li 10,500
	bl T_Damage
	lis 9,.LC75@ha
	mr 3,29
	lfs 1,.LC75@l(9)
	addi 4,31,376
	addi 5,1,16
	bl VectorMA
	lis 9,gi@ha
	li 3,3
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L173
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L174
	lwz 0,100(29)
	li 3,18
	b .L188
.L174:
	lwz 0,100(29)
	li 3,17
	b .L188
.L173:
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L177
	lwz 0,100(29)
	li 3,8
.L188:
	mtlr 0
	blrl
	b .L176
.L177:
	lwz 0,100(29)
	li 3,7
	mtlr 0
	blrl
.L176:
	lis 29,gi@ha
	addi 3,1,16
	la 29,gi@l(29)
	lwz 9,120(29)
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,31,4
	li 4,1
	mtlr 0
	blrl
	li 3,1
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe22:
	.size	 KOTSPickup_KOTSExPack,.Lfe22-KOTSPickup_KOTSExPack
	.section	".sbss","aw",@nobits
	.align 2
is_quad:
	.space	4
	.size	 is_quad,4
	.globl is_quad
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
