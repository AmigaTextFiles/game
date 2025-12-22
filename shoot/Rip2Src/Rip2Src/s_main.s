	.file	"s_main.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long -791555373
	.long -218959632
	.long -202116623
	.long -589439265
	.long -522067229
	.align 2
.LC1:
	.string	"Laser attached.\n"
	.align 2
.LC2:
	.string	"world/laser.wav"
	.align 2
.LC3:
	.string	"laser_yaya"
	.align 2
.LC4:
	.long 0x41a00000
	.align 2
.LC5:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl PlaceLaser
	.type	 PlaceLaser,@function
PlaceLaser:
	stwu 1,-80(1)
	mflr 0
	stmw 24,48(1)
	stw 0,84(1)
	lis 9,.LC0@ha
	mr 31,3
	lwz 8,.LC0@l(9)
	addi 30,1,8
	mr 24,4
	la 9,.LC0@l(9)
	stw 8,8(1)
	lwz 7,16(9)
	lwz 0,4(9)
	lwz 11,8(9)
	lwz 10,12(9)
	lwz 3,256(31)
	stw 0,4(30)
	stw 11,8(30)
	stw 10,12(30)
	stw 7,16(30)
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L7
	lwz 3,256(31)
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L7
	lis 27,gi@ha
	lis 5,.LC1@ha
	la 27,gi@l(27)
	la 5,.LC1@l(5)
	lwz 9,8(27)
	li 4,2
	li 26,2
	mtlr 9
	crxor 6,6,6
	blrl
	bl G_Spawn
	mr 29,3
	li 0,0
	li 11,1
	li 9,160
	stw 0,260(29)
	stw 11,40(29)
	lis 3,.LC2@ha
	addi 25,29,16
	stw 9,68(29)
	la 3,.LC2@l(3)
	stw 26,248(29)
	lwz 9,36(27)
	mtlr 9
	blrl
	lis 9,.LC3@ha
	stw 3,76(29)
	lis 10,pre_target_laser_think@ha
	la 9,.LC3@l(9)
	la 10,pre_target_laser_think@l(10)
	stw 9,280(29)
	li 7,100
	lis 28,level@ha
	lwz 0,256(31)
	lis 9,.LC4@ha
	la 28,level@l(28)
	stw 26,56(29)
	la 9,.LC4@l(9)
	li 8,-3
	stw 0,548(29)
	mr 3,24
	mr 4,25
	lwz 11,256(31)
	lfs 13,0(9)
	stw 11,256(29)
	lwz 9,84(11)
	lwz 0,1820(9)
	slwi 0,0,2
	lwzx 9,30,0
	stw 7,516(29)
	stw 10,436(29)
	stw 9,60(29)
	lfs 0,4(28)
	stw 8,264(29)
	fadds 0,0,13
	stfs 0,596(29)
	lwz 9,256(31)
	lwz 11,84(9)
	lwz 0,1820(11)
	stw 0,908(29)
	lfs 0,4(31)
	stfs 0,4(29)
	lfs 13,8(31)
	stfs 13,8(29)
	lfs 0,12(31)
	stfs 0,12(29)
	bl vectoangles
	addi 4,29,340
	mr 3,25
	bl G_SetMovedir
	lis 9,0x4100
	lis 0,0xc100
	stw 9,208(29)
	mr 3,29
	stw 9,200(29)
	stw 9,204(29)
	stw 0,196(29)
	stw 0,188(29)
	stw 0,192(29)
	lwz 0,72(27)
	mtlr 0
	blrl
	mr 3,29
	bl target_laser_off
	lis 9,.LC5@ha
	lfs 0,4(28)
	la 9,.LC5@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,428(29)
.L7:
	lwz 0,84(1)
	mtlr 0
	lmw 24,48(1)
	la 1,80(1)
	blr
.Lfe1:
	.size	 PlaceLaser,.Lfe1-PlaceLaser
	.section	".rodata"
	.align 2
.LC6:
	.long -522067229
	.long -218959632
	.long -202116623
	.long -791555373
	.long -589439265
	.align 2
.LC7:
	.string	"off"
	.align 2
.LC8:
	.string	"on"
	.align 2
.LC9:
	.string	"lasersight"
	.align 2
.LC10:
	.string	"models/objects/spots/spotr.md2"
	.align 2
.LC11:
	.string	"models/objects/spots/spotb.md2"
	.section	".text"
	.align 2
	.globl SP_LaserSight
	.type	 SP_LaserSight,@function
SP_LaserSight:
	stwu 1,-96(1)
	mflr 0
	stmw 28,80(1)
	stw 0,100(1)
	mr 31,3
	mr 29,4
	lwz 0,892(31)
	cmpwi 0,0,4
	bc 12,2,.L15
	lwz 9,84(31)
	lwz 0,1872(9)
	cmpwi 0,0,4
	bc 4,2,.L14
.L15:
	lis 4,.LC7@ha
	mr 3,29
	la 4,.LC7@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L16
	lwz 3,1096(31)
	bl G_FreeEdict
	b .L14
.L16:
	lis 4,.LC8@ha
	mr 3,29
	la 4,.LC8@l(4)
	bl Q_stricmp
	mr. 30,3
	bc 4,2,.L14
	lwz 3,84(31)
	addi 29,1,24
	addi 28,1,40
	mr 4,29
	mr 5,28
	addi 3,3,2124
	li 6,0
	bl AngleVectors
	li 9,0
	lis 0,0x42c8
	stw 9,64(1)
	addi 7,1,8
	mr 5,29
	stw 0,56(1)
	mr 6,28
	addi 3,31,4
	stw 9,60(1)
	addi 4,1,56
	bl G_ProjectSource
	bl G_Spawn
	stw 3,1096(31)
	li 0,1
	lis 10,.LC9@ha
	stw 31,256(3)
	la 10,.LC9@l(10)
	lwz 9,1096(31)
	stw 0,260(9)
	lwz 11,1096(31)
	stw 30,248(11)
	lwz 9,1096(31)
	stw 10,280(9)
	lwz 11,1096(31)
	stw 31,256(11)
	lwz 9,84(31)
	lwz 0,1820(9)
	cmpwi 0,0,1
	bc 4,2,.L19
	lis 9,gi+32@ha
	lis 3,.LC10@ha
	lwz 0,gi+32@l(9)
	la 3,.LC10@l(3)
	b .L21
.L19:
	lis 9,gi+32@ha
	lis 3,.LC11@ha
	lwz 0,gi+32@l(9)
	la 3,.LC11@l(3)
.L21:
	mtlr 0
	blrl
	lwz 9,1096(31)
	stw 3,40(9)
	lwz 11,1096(31)
	lis 9,LaserSightThink@ha
	la 9,LaserSightThink@l(9)
	stw 9,432(11)
.L14:
	lwz 0,100(1)
	mtlr 0
	lmw 28,80(1)
	la 1,96(1)
	blr
.Lfe2:
	.size	 SP_LaserSight,.Lfe2-SP_LaserSight
	.section	".rodata"
	.align 3
.LC12:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC13:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC14:
	.long 0x46000000
	.align 2
.LC15:
	.long 0x3f800000
	.align 2
.LC16:
	.long 0xc0800000
	.section	".text"
	.align 2
	.globl LaserSightThink
	.type	 LaserSightThink,@function
LaserSightThink:
	stwu 1,-208(1)
	mflr 0
	stmw 28,192(1)
	stw 0,212(1)
	mr 31,3
	addi 30,1,72
	lwz 9,256(31)
	addi 29,1,88
	addi 28,1,24
	addi 6,1,104
	mr 5,29
	lwz 3,84(9)
	mr 4,30
	addi 3,3,2124
	bl AngleVectors
	lwz 3,256(31)
	lis 9,0x40c0
	lis 0,0x41c0
	stw 9,60(1)
	mr 6,29
	lis 9,.LC13@ha
	stw 0,56(1)
	addi 7,1,8
	la 9,.LC13@l(9)
	lis 0,0x4330
	lfd 13,0(9)
	addi 4,1,56
	mr 5,30
	lwz 9,508(3)
	addi 3,3,4
	addi 9,9,-7
	xoris 9,9,0x8000
	stw 9,188(1)
	stw 0,184(1)
	lfd 0,184(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	bl G_ProjectSource
	lis 9,.LC14@ha
	addi 3,1,8
	la 9,.LC14@l(9)
	mr 4,30
	lfs 1,0(9)
	mr 5,28
	bl VectorMA
	lis 11,gi@ha
	lis 9,0x600
	lwz 8,256(31)
	la 29,gi@l(11)
	ori 9,9,3
	lwz 11,48(29)
	mr 7,28
	addi 3,1,120
	addi 4,1,8
	li 5,0
	li 6,0
	mtlr 11
	blrl
	lis 9,.LC15@ha
	lfs 13,128(1)
	la 9,.LC15@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L23
	lis 9,.LC16@ha
	mr 4,30
	la 9,.LC16@l(9)
	addi 3,1,132
	lfs 1,0(9)
	addi 5,1,40
	bl VectorMA
	lfs 0,40(1)
	lfs 13,44(1)
	lfs 12,48(1)
	stfs 0,132(1)
	stfs 13,136(1)
	stfs 12,140(1)
.L23:
	addi 3,1,144
	addi 4,31,16
	bl vectoangles
	lfs 0,136(1)
	mr 3,31
	lfs 13,140(1)
	lfs 12,132(1)
	stfs 0,8(31)
	stfs 13,12(31)
	stfs 12,4(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lis 9,level+4@ha
	lis 11,.LC12@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC12@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,212(1)
	mtlr 0
	lmw 28,192(1)
	la 1,208(1)
	blr
.Lfe3:
	.size	 LaserSightThink,.Lfe3-LaserSightThink
	.section	".rodata"
	.align 2
.LC17:
	.string	"Not enough %s\n"
	.align 2
.LC18:
	.string	"info_player_team1"
	.align 2
.LC19:
	.string	"info_player_team2"
	.align 2
.LC21:
	.string	"Couldn't find destination\n"
	.align 2
.LC22:
	.long 0x41100000
	.align 2
.LC23:
	.long 0x47800000
	.align 2
.LC24:
	.long 0x43b40000
	.section	".text"
	.align 2
	.globl teleporter_touch2
	.type	 teleporter_touch2,@function
teleporter_touch2:
	stwu 1,-80(1)
	mflr 0
	mfcr 12
	stmw 28,64(1)
	stw 0,84(1)
	stw 12,60(1)
	mr 31,4
	mr 29,3
	lwz 0,84(31)
	li 28,1
	cmpwi 0,0,0
	bc 4,2,.L42
	cmpwi 0,31,-376
	li 28,0
	bc 12,2,.L40
.L42:
	lwz 5,296(29)
	li 3,0
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L44
	lis 9,gi+4@ha
	lis 3,.LC21@ha
	lwz 0,gi+4@l(9)
	la 3,.LC21@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L40
.L44:
	lwz 11,908(29)
	cmpwi 0,11,0
	bc 12,2,.L45
	lwz 9,84(31)
	lwz 0,1820(9)
	cmpw 0,0,11
	bc 4,2,.L40
.L45:
	lis 9,gi+76@ha
	mr 3,31
	lwz 0,gi+76@l(9)
	cmpwi 4,28,0
	mtlr 0
	blrl
	lfs 0,4(30)
	lis 9,.LC22@ha
	la 9,.LC22@l(9)
	lfs 12,0(9)
	stfs 0,4(31)
	lfs 13,8(30)
	stfs 13,8(31)
	lfs 0,12(30)
	fadds 0,0,12
	stfs 0,12(31)
	bc 12,18,.L46
	li 0,0
	lis 9,0x4248
	stw 0,376(31)
	stw 9,604(31)
	stw 0,384(31)
	stw 0,380(31)
.L46:
	li 0,6
	stw 0,80(31)
	bc 12,18,.L47
	lis 9,.LC23@ha
	li 0,3
	la 9,.LC23@l(9)
	mtctr 0
	addi 3,30,16
	lfs 10,0(9)
	li 7,0
	li 8,0
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfs 11,0(9)
.L56:
	lwz 10,84(31)
	add 0,7,7
	lfsx 0,8,3
	addi 7,7,1
	addi 9,10,1824
	lfsx 13,9,8
	addi 10,10,20
	addi 8,8,4
	fsubs 0,0,13
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,48(1)
	lwz 11,52(1)
	sthx 11,10,0
	bdnz .L56
	li 0,0
	lwz 11,84(31)
	stw 0,16(31)
	lfs 13,20(29)
	stw 0,24(31)
	stfs 13,20(31)
	lfs 0,16(29)
	stfs 0,28(11)
	lfs 0,20(29)
	lwz 9,84(31)
	stfs 0,32(9)
	lfs 0,24(29)
	lwz 11,84(31)
	stfs 0,36(11)
	lfs 0,16(29)
	lwz 9,84(31)
	stfs 0,2124(9)
	lfs 0,20(29)
	lwz 11,84(31)
	stfs 0,2128(11)
	lfs 13,24(29)
	lwz 9,84(31)
	stfs 13,2132(9)
	b .L53
.L47:
	lfs 13,16(30)
	addi 4,1,8
	addi 3,1,24
	addi 29,31,376
	stfs 13,24(1)
	lfs 0,20(30)
	stfs 0,28(1)
	lfs 13,24(30)
	stfs 13,32(1)
	bl G_SetMovedir
	mr 3,29
	bl VectorLength
	mr 4,29
	addi 3,1,8
	bl VectorScale
.L53:
	bc 12,18,.L54
	mr 3,31
	bl KillBox
.L54:
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L40:
	lwz 0,84(1)
	lwz 12,60(1)
	mtlr 0
	lmw 28,64(1)
	mtcrf 8,12
	la 1,80(1)
	blr
.Lfe4:
	.size	 teleporter_touch2,.Lfe4-teleporter_touch2
	.section	".rodata"
	.align 2
.LC25:
	.string	"ctd3"
	.align 2
.LC26:
	.string	"trigger_teleport without a target.\n"
	.align 2
.LC28:
	.string	"trigger_teleport"
	.align 2
.LC29:
	.string	"func_wall"
	.align 2
.LC30:
	.string	"misc_teleporter"
	.section	".text"
	.align 2
	.globl remove_teleporter_pads
	.type	 remove_teleporter_pads,@function
remove_teleporter_pads:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 9,globals@ha
	lis 11,g_edicts@ha
	la 9,globals@l(9)
	lwz 31,g_edicts@l(11)
	mr 29,3
	lwz 0,72(9)
	lis 27,g_edicts@ha
	mulli 0,0,1116
	add 0,31,0
	cmplw 0,31,0
	bc 4,0,.L67
	mr 26,9
	lis 28,.LC28@ha
	lis 30,.LC29@ha
.L69:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L68
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L68
	lwz 3,280(31)
	la 4,.LC28@l(28)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L67
	lwz 3,280(31)
	la 4,.LC29@l(30)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L68
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L67
.L68:
	lwz 9,72(26)
	addi 31,31,1116
	lwz 0,g_edicts@l(27)
	mulli 9,9,1116
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L69
.L67:
	lis 9,globals@ha
	lis 11,g_edicts@ha
	la 10,globals@l(9)
	lwz 0,72(10)
	lwz 9,g_edicts@l(11)
	mulli 0,0,1116
	add 0,9,0
	cmpw 0,31,0
	bc 12,2,.L65
	mr 31,9
	cmplw 0,31,0
	bc 4,0,.L65
	lis 9,teleporter_touch@ha
	mr 26,10
	la 25,teleporter_touch@l(9)
	lis 24,.LC30@ha
.L79:
	lwz 0,88(31)
	addi 28,31,1116
	cmpwi 0,0,0
	bc 12,2,.L78
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 12,2,.L78
	lwz 0,284(31)
	andi. 9,0,1
	bc 4,2,.L78
	lwz 3,280(31)
	la 4,.LC30@l(24)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L78
	lwz 5,296(31)
	li 3,0
	li 4,300
	bl G_Find
	mr 30,3
	lwz 3,g_edicts@l(27)
	b .L83
.L85:
	addi 3,3,1116
.L83:
	lwz 0,72(26)
	lwz 9,g_edicts@l(27)
	mulli 0,0,1116
	add 9,9,0
	cmplw 0,3,9
	bc 4,0,.L84
	lwz 0,444(3)
	cmpw 0,0,25
	bc 4,2,.L85
	lwz 9,296(3)
	lwz 0,296(31)
	cmpw 0,9,0
	bc 4,2,.L85
	bl G_FreeEdict
	lwz 9,0(29)
	addi 9,9,1
	stw 9,0(29)
.L84:
	mr 3,30
	bl G_FreeEdict
	mr 3,31
	bl G_FreeEdict
	lwz 9,0(29)
	addi 9,9,2
	stw 9,0(29)
.L78:
	lwz 9,72(26)
	mr 31,28
	lwz 0,g_edicts@l(27)
	mulli 9,9,1116
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L79
.L65:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 remove_teleporter_pads,.Lfe5-remove_teleporter_pads
	.section	".sbss","aw",@nobits
	.align 2
num.60:
	.space	4
	.size	 num.60,4
	.align 2
i.61:
	.space	4
	.size	 i.61,4
	.section	".rodata"
	.align 2
.LC31:
	.string	"%s joined %s team\n"
	.align 2
.LC32:
	.string	"%s joined %s team as a team master!\n"
	.align 2
.LC33:
	.long 0x0
	.align 3
.LC34:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl JoinTeam
	.type	 JoinTeam,@function
JoinTeam:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 23,36(1)
	stw 0,84(1)
	mr 31,3
	mr 27,4
	lwz 9,84(31)
	lwz 0,1820(9)
	cmpwi 0,0,0
	bc 12,1,.L90
	lis 9,maxclients@ha
	lis 11,.LC33@ha
	lwz 10,maxclients@l(9)
	la 11,.LC33@l(11)
	li 0,0
	lfs 13,0(11)
	lis 9,num.60@ha
	lis 23,i.61@ha
	lfs 0,20(10)
	lis 11,i.61@ha
	lis 24,maxclients@ha
	stw 0,num.60@l(9)
	stw 0,i.61@l(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L93
	lis 9,.LC34@ha
	lis 25,g_edicts@ha
	la 9,.LC34@l(9)
	lis 30,num.60@ha
	lfd 31,0(9)
	lis 28,i.61@ha
	lis 26,0x4330
.L95:
	lwz 0,i.61@l(23)
	lwz 9,g_edicts@l(25)
	mulli 0,0,1116
	add 29,9,0
	mr 3,29
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L94
	lwz 9,84(29)
	lwz 0,1820(9)
	cmpw 0,0,27
	bc 4,2,.L94
	lwz 9,num.60@l(30)
	addi 9,9,1
	stw 9,num.60@l(30)
.L94:
	lwz 11,i.61@l(28)
	lwz 10,maxclients@l(24)
	addi 11,11,1
	xoris 0,11,0x8000
	lfs 13,20(10)
	stw 0,28(1)
	stw 26,24(1)
	lfd 0,24(1)
	stw 11,i.61@l(28)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L95
.L93:
	lis 9,num.60@ha
	lwz 0,num.60@l(9)
	cmpwi 0,0,0
	bc 4,2,.L99
	lis 10,ripflags@ha
	lwz 9,ripflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 9,11,16
	bc 12,2,.L100
	lwz 29,84(31)
	mr 3,27
	lis 28,gi@ha
	stw 0,1112(31)
	addi 29,29,700
	bl CTFTeamName
	lwz 0,gi@l(28)
	mr 6,3
	lis 4,.LC31@ha
	la 4,.LC31@l(4)
	mr 5,29
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L102
.L100:
	lwz 29,84(31)
	mr 3,27
	lis 28,gi@ha
	addi 29,29,700
	bl CTFTeamName
	lwz 0,gi@l(28)
	mr 6,3
	lis 4,.LC32@ha
	la 4,.LC32@l(4)
	mr 5,29
	mtlr 0
	li 3,1
	crxor 6,6,6
	blrl
	li 0,1
	b .L103
.L99:
	li 0,0
.L103:
	stw 0,1112(31)
.L102:
	lwz 9,84(31)
	stw 27,1820(9)
.L90:
	lwz 0,84(1)
	mtlr 0
	lmw 23,36(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe6:
	.size	 JoinTeam,.Lfe6-JoinTeam
	.section	".rodata"
	.align 2
.LC35:
	.string	"You're at %s, %s.\n"
	.align 2
.LC36:
	.string	"%s's class is %s\n"
	.align 2
.LC37:
	.string	"There is nobody on your team\n"
	.align 2
.LC38:
	.long 0x0
	.align 3
.LC39:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl PrintOtherClass
	.type	 PrintOtherClass,@function
PrintOtherClass:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 23,36(1)
	stw 0,84(1)
	lis 11,.LC38@ha
	lis 9,maxclients@ha
	la 11,.LC38@l(11)
	mr 31,3
	lfs 13,0(11)
	li 30,0
	li 28,0
	lwz 11,maxclients@l(9)
	lis 23,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L107
	lis 9,gi@ha
	lis 24,g_edicts@ha
	la 25,gi@l(9)
	lis 26,.LC36@ha
	lis 9,.LC39@ha
	lis 27,0x4330
	la 9,.LC39@l(9)
	li 29,0
	lfd 31,0(9)
.L109:
	lwz 0,g_edicts@l(24)
	add 7,0,29
	lwz 6,84(7)
	cmpwi 0,6,0
	bc 12,2,.L108
	lwz 0,88(7)
	cmpwi 0,0,0
	bc 12,2,.L108
	xor 9,31,7
	lwz 10,84(31)
	addic 0,9,-1
	subfe 11,0,9
	lwz 8,1820(6)
	lwz 0,1820(10)
	xor 0,8,0
	subfic 9,0,0
	adde 0,9,0
	and. 9,0,11
	bc 12,2,.L108
	cmpwi 0,8,0
	bc 12,2,.L108
	lwz 0,892(7)
	cmpwi 0,0,0
	bc 12,2,.L108
	srawi 0,30,31
	lwz 11,8(25)
	addi 6,6,700
	xor 9,0,30
	lwz 7,1084(7)
	mr 3,31
	subf 9,9,0
	li 4,2
	mtlr 11
	srawi 9,9,31
	la 5,.LC36@l(26)
	addi 0,9,1
	and 9,30,9
	or 30,9,0
	crxor 6,6,6
	blrl
.L108:
	addi 28,28,1
	lwz 11,maxclients@l(23)
	xoris 0,28,0x8000
	addi 29,29,1116
	stw 0,28(1)
	stw 27,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L109
.L107:
	cmpwi 0,30,0
	bc 4,2,.L116
	lis 9,gi+8@ha
	lis 5,.LC37@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC37@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L116:
	lwz 0,84(1)
	mtlr 0
	lmw 23,36(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe7:
	.size	 PrintOtherClass,.Lfe7-PrintOtherClass
	.section	".rodata"
	.align 2
.LC40:
	.string	"Your team needs defenders!\n"
	.align 2
.LC41:
	.string	"Your team needs attackers!\n"
	.align 2
.LC42:
	.long 0x3f800000
	.align 3
.LC43:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl PrintTeamState
	.type	 PrintTeamState,@function
PrintTeamState:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,maxclients@ha
	lis 10,.LC42@ha
	lwz 11,maxclients@l(9)
	la 10,.LC42@l(10)
	li 7,0
	lfs 0,0(10)
	li 5,0
	li 6,1
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L119
	lis 9,g_edicts@ha
	fmr 12,13
	lis 4,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	addi 8,11,1116
	lfd 13,0(9)
.L121:
	cmpwi 0,8,0
	bc 12,2,.L120
	lwz 0,88(8)
	cmpwi 0,0,0
	bc 12,2,.L120
	lwz 9,84(8)
	lwz 11,84(3)
	lwz 10,1820(9)
	lwz 0,1820(11)
	cmpw 0,10,0
	bc 4,2,.L120
	lwz 11,928(8)
	cmpwi 0,11,1
	bc 4,2,.L124
	addi 5,5,1
	b .L120
.L124:
	xori 11,11,2
	addi 9,7,1
	srawi 10,11,31
	xor 0,10,11
	subf 0,0,10
	srawi 0,0,31
	andc 9,9,0
	and 0,7,0
	or 7,0,9
.L120:
	addi 6,6,1
	xoris 0,6,0x8000
	addi 8,8,1116
	stw 0,12(1)
	stw 4,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L121
.L119:
	cmpw 0,5,7
	bc 4,1,.L128
	lis 9,gi+8@ha
	lis 5,.LC40@ha
	lwz 0,gi+8@l(9)
	la 5,.LC40@l(5)
	b .L133
.L128:
	bc 4,0,.L130
	lis 9,gi+8@ha
	lis 5,.LC41@ha
	lwz 0,gi+8@l(9)
	la 5,.LC41@l(5)
.L133:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L129
.L130:
	bc 4,2,.L129
	lis 9,gi+8@ha
	lis 5,.LC41@ha
	lwz 0,gi+8@l(9)
	la 5,.LC41@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L129:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 PrintTeamState,.Lfe8-PrintTeamState
	.lcomm	st.74,100,4
	.section	".rodata"
	.align 2
.LC44:
	.string	"%s"
	.align 2
.LC45:
	.long 0x3f800000
	.align 3
.LC46:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl eprintf
	.type	 eprintf,@function
eprintf:
	stwu 1,-208(1)
	mflr 0
	mfcr 12
	stfd 31,200(1)
	stmw 21,156(1)
	stw 0,212(1)
	stw 12,152(1)
	lis 30,0x500
	addi 0,1,216
	stw 8,28(1)
	addi 11,1,8
	stw 0,132(1)
	mr 24,3
	stw 11,136(1)
	mr 25,4
	mr 31,5
	mr 26,6
	stw 9,32(1)
	stw 10,36(1)
	stw 30,128(1)
	bc 4,6,.L135
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L135:
	addi 11,1,128
	addi 9,1,112
	lwz 10,8(11)
	lis 3,st.74@ha
	mr 5,9
	lwz 0,4(11)
	mr 4,7
	la 3,st.74@l(3)
	stw 30,112(1)
	lis 27,st.74@ha
	lis 21,maxclients@ha
	stw 0,4(9)
	li 30,1
	stw 10,8(9)
	bl vsprintf
	lis 9,.LC45@ha
	lis 11,maxclients@ha
	la 9,.LC45@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L137
	lis 9,gi@ha
	cmpwi 3,31,2
	la 28,gi@l(9)
	cmpwi 4,31,1
	lis 9,.LC46@ha
	lis 22,g_edicts@ha
	la 9,.LC46@l(9)
	lis 29,.LC44@ha
	lfd 31,0(9)
	lis 23,0x4330
	li 31,1116
.L139:
	lwz 0,g_edicts@l(22)
	add. 3,0,31
	bc 12,2,.L138
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L138
	lwz 9,84(3)
	lwz 11,84(24)
	lwz 10,1820(9)
	lwz 0,1820(11)
	cmpw 0,10,0
	bc 12,2,.L138
	cmpw 0,3,25
	bc 12,2,.L138
	bc 4,18,.L143
	lwz 9,8(28)
	mr 4,26
	la 5,.LC44@l(29)
	la 6,st.74@l(27)
	mtlr 9
	crxor 6,6,6
	blrl
	b .L138
.L143:
	bc 4,14,.L138
	lwz 9,12(28)
	la 4,.LC44@l(29)
	la 5,st.74@l(27)
	mtlr 9
	crxor 6,6,6
	blrl
.L138:
	addi 30,30,1
	lwz 11,maxclients@l(21)
	xoris 0,30,0x8000
	addi 31,31,1116
	stw 0,148(1)
	stw 23,144(1)
	lfd 0,144(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L139
.L137:
	lwz 0,212(1)
	lwz 12,152(1)
	mtlr 0
	lmw 21,156(1)
	lfd 31,200(1)
	mtcrf 24,12
	la 1,208(1)
	blr
.Lfe9:
	.size	 eprintf,.Lfe9-eprintf
	.lcomm	st.78,100,4
	.section	".rodata"
	.align 2
.LC47:
	.long 0x3f800000
	.align 3
.LC48:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl centerprint_all
	.type	 centerprint_all,@function
centerprint_all:
	stwu 1,-192(1)
	mflr 0
	stfd 31,184(1)
	stmw 24,152(1)
	stw 0,196(1)
	lis 31,0x100
	addi 11,1,200
	stw 4,12(1)
	addi 0,1,8
	stw 11,132(1)
	stw 0,136(1)
	stw 5,16(1)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	stw 31,128(1)
	bc 4,6,.L148
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L148:
	addi 11,1,128
	mr 4,3
	lwz 10,8(11)
	addi 9,1,112
	lis 3,st.78@ha
	lwz 0,4(11)
	mr 5,9
	la 3,st.78@l(3)
	stw 31,112(1)
	li 30,1
	lis 24,st.78@ha
	stw 0,4(9)
	lis 25,maxclients@ha
	stw 10,8(9)
	bl vsprintf
	lis 9,.LC47@ha
	lis 11,maxclients@ha
	la 9,.LC47@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L150
	lis 9,gi@ha
	lis 26,g_edicts@ha
	la 27,gi@l(9)
	lis 28,.LC44@ha
	lis 9,.LC48@ha
	lis 29,0x4330
	la 9,.LC48@l(9)
	li 31,1116
	lfd 31,0(9)
.L152:
	lwz 0,g_edicts@l(26)
	add. 3,0,31
	bc 12,2,.L151
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L151
	lwz 9,12(27)
	la 4,.LC44@l(28)
	la 5,st.78@l(24)
	mtlr 9
	crxor 6,6,6
	blrl
.L151:
	addi 30,30,1
	lwz 11,maxclients@l(25)
	xoris 0,30,0x8000
	addi 31,31,1116
	stw 0,148(1)
	stw 29,144(1)
	lfd 0,144(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L152
.L150:
	lwz 0,196(1)
	mtlr 0
	lmw 24,152(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe10:
	.size	 centerprint_all,.Lfe10-centerprint_all
	.lcomm	st.82,100,4
	.section	".rodata"
	.align 2
.LC49:
	.long 0x0
	.align 3
.LC50:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl tprintf
	.type	 tprintf,@function
tprintf:
	stwu 1,-224(1)
	mflr 0
	mfcr 12
	stfd 31,216(1)
	stmw 20,168(1)
	stw 0,228(1)
	stw 12,164(1)
	lis 30,0x500
	addi 0,1,232
	stw 8,28(1)
	addi 11,1,8
	stw 0,132(1)
	mr 23,3
	stw 11,136(1)
	mr 24,4
	mr 31,5
	mr 25,6
	stw 9,32(1)
	stw 10,36(1)
	stw 30,128(1)
	bc 4,6,.L156
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L156:
	addi 11,1,128
	addi 9,1,112
	lwz 10,8(11)
	lis 3,st.82@ha
	mr 5,9
	lwz 0,4(11)
	mr 4,7
	la 3,st.82@l(3)
	stw 30,112(1)
	li 29,0
	lis 26,st.82@ha
	stw 0,4(9)
	lis 20,maxclients@ha
	stw 10,8(9)
	bl vsprintf
	lis 9,.LC49@ha
	lis 11,maxclients@ha
	la 9,.LC49@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L158
	lis 9,gi@ha
	cmpwi 3,31,2
	la 27,gi@l(9)
	cmpwi 4,31,1
	lis 9,.LC50@ha
	lis 21,g_edicts@ha
	la 9,.LC50@l(9)
	lis 28,.LC44@ha
	lfd 31,0(9)
	lis 22,0x4330
	li 30,0
.L160:
	lwz 0,g_edicts@l(21)
	add 31,0,30
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L159
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L159
	mr 3,31
	mr 4,23
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L159
	cmpw 0,31,24
	bc 12,2,.L159
	bc 4,18,.L165
	lwz 9,8(27)
	mr 3,31
	mr 4,25
	la 5,.LC44@l(28)
	la 6,st.82@l(26)
	mtlr 9
	crxor 6,6,6
	blrl
	b .L159
.L165:
	bc 4,14,.L159
	lwz 9,12(27)
	mr 3,31
	la 4,.LC44@l(28)
	la 5,st.82@l(26)
	mtlr 9
	crxor 6,6,6
	blrl
.L159:
	addi 29,29,1
	lwz 11,maxclients@l(20)
	xoris 0,29,0x8000
	addi 30,30,1116
	stw 0,156(1)
	stw 22,152(1)
	lfd 0,152(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L160
.L158:
	lwz 0,228(1)
	lwz 12,164(1)
	mtlr 0
	lmw 20,168(1)
	lfd 31,216(1)
	mtcrf 24,12
	la 1,224(1)
	blr
.Lfe11:
	.size	 tprintf,.Lfe11-tprintf
	.section	".rodata"
	.align 2
.LC51:
	.long 0x3f800000
	.align 3
.LC52:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl target_kill
	.type	 target_kill,@function
target_kill:
	stwu 1,-96(1)
	mflr 0
	stfd 31,88(1)
	stmw 23,52(1)
	stw 0,100(1)
	lis 9,maxclients@ha
	li 0,0
	lwz 11,maxclients@l(9)
	mr 31,3
	li 29,1
	lis 9,.LC51@ha
	stw 0,24(1)
	lis 23,maxclients@ha
	la 9,.LC51@l(9)
	stw 0,16(1)
	stw 0,20(1)
	lfs 13,0(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L171
	lis 9,.LC52@ha
	lis 24,g_edicts@ha
	la 9,.LC52@l(9)
	li 25,0
	lfd 31,0(9)
	li 27,39
	lis 28,vec3_origin@ha
	lis 26,0x4330
	li 30,1116
.L173:
	lwz 0,g_edicts@l(24)
	add. 3,0,30
	bc 12,2,.L172
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L172
	lwz 11,908(31)
	cmpwi 0,11,0
	bc 12,2,.L175
	lwz 9,84(3)
	lwz 0,1820(9)
	cmpw 0,0,11
	bc 4,2,.L172
	stw 25,8(1)
	mr 4,31
	mr 5,31
	stw 27,12(1)
	addi 6,1,16
	addi 7,3,4
	la 8,vec3_origin@l(28)
	li 9,10000
	li 10,10000
	bl T_Damage
	b .L172
.L175:
	stw 11,8(1)
	mr 4,31
	mr 5,31
	stw 27,12(1)
	addi 6,1,16
	addi 7,3,4
	la 8,vec3_origin@l(28)
	li 9,10000
	li 10,10000
	bl T_Damage
.L172:
	addi 29,29,1
	lwz 11,maxclients@l(23)
	xoris 0,29,0x8000
	addi 30,30,1116
	stw 0,44(1)
	stw 26,40(1)
	lfd 0,40(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L173
.L171:
	li 0,0
	stw 0,328(31)
	lwz 0,100(1)
	mtlr 0
	lmw 23,52(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe12:
	.size	 target_kill,.Lfe12-target_kill
	.section	".rodata"
	.align 2
.LC53:
	.string	"%s %s\n"
	.align 2
.LC54:
	.string	"%s got the enemy's flag!\n"
	.align 2
.LC55:
	.string	"%s got your flag!\n"
	.align 2
.LC56:
	.string	"world/x_alarm.wav"
	.align 2
.LC57:
	.long 0x3f800000
	.align 2
.LC58:
	.long 0x0
	.section	".text"
	.align 2
	.globl Pickup_Flag
	.type	 Pickup_Flag,@function
Pickup_Flag:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,level+496@ha
	mr 30,3
	la 9,level+496@l(9)
	mr 31,4
	cmpwi 0,9,0
	bc 12,2,.L183
	lwz 8,84(31)
	lis 7,.LC53@ha
	mr 3,31
	la 7,.LC53@l(7)
	li 4,0
	addi 8,8,700
	li 5,2
	li 6,0
	crxor 6,6,6
	bl tprintf
	b .L184
.L183:
	lwz 8,84(31)
	lis 7,.LC54@ha
	mr 3,31
	la 7,.LC54@l(7)
	li 4,0
	addi 8,8,700
	li 5,2
	li 6,0
	crxor 6,6,6
	bl tprintf
.L184:
	lis 9,level+432@ha
	la 9,level+432@l(9)
	cmpwi 0,9,0
	bc 12,2,.L185
	lwz 8,84(31)
	lis 7,.LC53@ha
	mr 3,31
	la 7,.LC53@l(7)
	li 4,0
	addi 8,8,700
	li 5,2
	li 6,0
	crxor 6,6,6
	bl eprintf
	b .L186
.L185:
	lwz 8,84(31)
	lis 7,.LC55@ha
	mr 3,31
	la 7,.LC55@l(7)
	li 4,0
	addi 8,8,700
	li 5,2
	li 6,0
	crxor 6,6,6
	bl eprintf
.L186:
	lis 29,gi@ha
	lis 3,.LC56@ha
	la 29,gi@l(29)
	la 3,.LC56@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC57@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC57@l(9)
	li 4,26
	lfs 1,0(9)
	mtlr 0
	mr 3,30
	lis 9,.LC58@ha
	la 9,.LC58@l(9)
	lfs 2,0(9)
	lis 9,.LC58@ha
	la 9,.LC58@l(9)
	lfs 3,0(9)
	blrl
	lwz 10,84(31)
	lis 11,level@ha
	li 8,1
	la 11,level@l(11)
	lwz 9,952(11)
	lwz 0,1816(10)
	add 0,0,9
	stw 0,1816(10)
	stw 8,932(31)
	lfs 0,4(11)
	lwz 9,84(31)
	stfs 0,1856(9)
	lwz 0,284(30)
	andis. 11,0,0x1
	bc 4,2,.L187
	lwz 0,264(30)
	lwz 9,184(30)
	oris 0,0,0x8000
	stw 11,248(30)
	ori 9,9,1
	stw 0,264(30)
	stw 9,184(30)
.L187:
	li 3,1
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 Pickup_Flag,.Lfe13-Pickup_Flag
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.section	".rodata"
	.align 3
.LC59:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl LessHealth
	.type	 LessHealth,@function
LessHealth:
	stwu 1,-16(1)
	lwz 0,480(3)
	lis 11,0x4330
	lis 10,.LC59@ha
	xoris 0,0,0x8000
	la 10,.LC59@l(10)
	stw 0,12(1)
	stw 11,8(1)
	lfd 13,0(10)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,1,0
	bc 12,1,.L27
	fsubs 0,0,1
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	stw 9,480(3)
.L27:
	la 1,16(1)
	blr
.Lfe14:
	.size	 LessHealth,.Lfe14-LessHealth
	.section	".rodata"
	.align 3
.LC60:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl LessAmmo
	.type	 LessAmmo,@function
LessAmmo:
	stwu 1,-64(1)
	mflr 0
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 26,24(1)
	stw 0,68(1)
	lis 10,dmflags@ha
	fmr 30,1
	lwz 11,dmflags@l(10)
	mr 28,3
	mr 30,4
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 0,9,8192
	bc 4,2,.L24
	lwz 29,84(28)
	mr 3,30
	lis 31,0x286b
	bl FindItem
	ori 31,31,51739
	lis 26,0x4330
	lis 9,itemlist@ha
	addi 29,29,740
	la 27,itemlist@l(9)
	subf 3,27,3
	lis 9,.LC60@ha
	mullw 3,3,31
	la 9,.LC60@l(9)
	lfd 31,0(9)
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 26,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,30,0
	bc 12,1,.L24
	mr 3,30
	bl FindItem
	subf 3,27,3
	lwz 10,84(28)
	mullw 3,3,31
	mr 11,9
	addi 10,10,740
	rlwinm 3,3,0,0,29
	lwzx 0,10,3
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 26,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fsubs 0,0,30
	fmr 13,0
	fctiwz 12,13
	stfd 12,16(1)
	lwz 11,20(1)
	stwx 11,10,3
.L24:
	lwz 0,68(1)
	mtlr 0
	lmw 26,24(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe15:
	.size	 LessAmmo,.Lfe15-LessAmmo
	.section	".rodata"
	.align 3
.LC61:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CheckX
	.type	 CheckX,@function
CheckX:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	mr 31,3
	mr 30,4
	fmr 31,1
	lwz 29,84(31)
	mr 3,30
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	lis 11,0x4330
	lis 10,.LC61@ha
	rlwinm 3,3,0,0,29
	la 10,.LC61@l(10)
	lwzx 0,29,3
	lfd 13,0(10)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 11,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,31
	bc 4,0,.L30
	lis 9,gi+8@ha
	lis 5,.LC17@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC17@l(5)
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L30:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe16:
	.size	 CheckX,.Lfe16-CheckX
	.align 2
	.globl pre_target_laser_think
	.type	 pre_target_laser_think,@function
pre_target_laser_think:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl target_laser_on
	lis 9,target_laser_think@ha
	la 9,target_laser_think@l(9)
	stw 9,436(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 pre_target_laser_think,.Lfe17-pre_target_laser_think
	.align 2
	.globl Grenade_Die
	.type	 Grenade_Die,@function
Grenade_Die:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 Grenade_Die,.Lfe18-Grenade_Die
	.section	".rodata"
	.align 2
.LC62:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl SP_trigger_laser
	.type	 SP_trigger_laser,@function
SP_trigger_laser:
	stwu 1,-64(1)
	mflr 0
	stmw 28,48(1)
	stw 0,68(1)
	mr 31,3
	li 29,2
	li 0,0
	li 10,160
	stw 29,248(31)
	li 8,1
	lis 9,gi@ha
	stw 0,260(31)
	stw 10,68(31)
	la 28,gi@l(9)
	lis 11,.LC6@ha
	stw 8,40(31)
	lis 3,.LC2@ha
	la 9,.LC6@l(11)
	lwz 6,36(28)
	la 3,.LC2@l(3)
	addi 30,1,8
	lwz 8,.LC6@l(11)
	mtlr 6
	lwz 0,4(9)
	lwz 7,16(9)
	lwz 11,8(9)
	lwz 10,12(9)
	stw 8,8(1)
	stw 0,4(30)
	stw 11,8(30)
	stw 10,12(30)
	stw 7,16(30)
	blrl
	lwz 9,84(31)
	stw 3,76(31)
	stw 29,56(31)
	stw 31,256(31)
	lwz 0,1820(9)
	cmpwi 0,0,0
	bc 4,2,.L12
	stw 0,908(31)
.L12:
	lwz 0,60(31)
	cmpwi 0,0,0
	bc 4,2,.L13
	lwz 0,908(31)
	slwi 0,0,2
	lwzx 9,30,0
	stw 9,60(31)
.L13:
	lis 9,pre_target_laser_think@ha
	li 0,100
	la 9,pre_target_laser_think@l(9)
	stw 0,516(31)
	lis 11,level+4@ha
	stw 9,436(31)
	li 0,-3
	mr 3,31
	lis 9,.LC62@ha
	lfs 0,level+4@l(11)
	la 9,.LC62@l(9)
	stw 0,264(31)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,596(31)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe19:
	.size	 SP_trigger_laser,.Lfe19-SP_trigger_laser
	.align 2
	.globl info_player_team1
	.type	 info_player_team1,@function
info_player_team1:
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	stw 9,280(3)
	blr
.Lfe20:
	.size	 info_player_team1,.Lfe20-info_player_team1
	.align 2
	.globl info_player_team2
	.type	 info_player_team2,@function
info_player_team2:
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	stw 9,280(3)
	blr
.Lfe21:
	.size	 info_player_team2,.Lfe21-info_player_team2
	.section	".rodata"
	.align 3
.LC63:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC64:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl Spawn_TeamPoint
	.type	 Spawn_TeamPoint,@function
Spawn_TeamPoint:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,3
	bl G_Spawn
	mr 31,3
	addi 4,1,8
	stw 29,256(31)
	li 6,0
	li 5,0
	lwz 3,84(29)
	addi 3,3,2124
	bl AngleVectors
	lis 9,.LC64@ha
	addi 3,29,4
	la 9,.LC64@l(9)
	addi 4,1,8
	lfs 1,0(9)
	addi 5,31,4
	bl VectorMA
	lwz 9,84(29)
	lwz 0,1820(9)
	cmpwi 0,0,2
	bc 4,2,.L34
	lis 9,.LC19@ha
	la 9,.LC19@l(9)
	b .L188
.L34:
	cmpwi 0,0,1
	bc 4,2,.L33
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
.L188:
	stw 9,280(31)
	li 0,30
	li 10,-30
	stw 0,480(31)
	lis 11,M_droptofloor@ha
	li 9,1
	stw 10,488(31)
	la 11,M_droptofloor@l(11)
	li 0,1024
	stw 9,512(31)
	lis 10,level+4@ha
	mr 3,31
	stw 0,776(31)
	lis 9,.LC63@ha
	stw 11,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC63@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bl SP_misc_teleporter_dest
.L33:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe22:
	.size	 Spawn_TeamPoint,.Lfe22-Spawn_TeamPoint
	.align 2
	.globl SP_func_wall2
	.type	 SP_func_wall2,@function
SP_func_wall2:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 12,2,.L58
	bl InitTrigger
	lis 9,teleporter_touch2@ha
	lis 11,gi+72@ha
	la 9,teleporter_touch2@l(9)
	mr 3,31
	stw 9,444(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	b .L57
.L58:
	lwz 9,284(31)
	andi. 0,9,129
	cmpwi 0,0,129
	bc 4,2,.L59
	rlwinm 0,9,0,0,30
	stw 0,284(31)
.L59:
	mr 3,31
	bl SP_func_wall
.L57:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe23:
	.size	 SP_func_wall2,.Lfe23-SP_func_wall2
	.section	".rodata"
	.align 2
.LC65:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl tr_think
	.type	 tr_think,@function
tr_think:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 4,.LC25@ha
	lis 3,level+72@ha
	la 4,.LC25@l(4)
	la 3,level+72@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L61
	lis 9,.LC65@ha
	lfs 0,12(31)
	la 9,.LC65@l(9)
	lfs 13,0(9)
	fsubs 0,0,13
	stfs 0,12(31)
.L61:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe24:
	.size	 tr_think,.Lfe24-tr_think
	.section	".rodata"
	.align 3
.LC66:
	.long 0x3fc99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_trigger_teleport
	.type	 SP_trigger_teleport,@function
SP_trigger_teleport:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L63
	lis 9,gi+4@ha
	lis 3,.LC26@ha
	lwz 0,gi+4@l(9)
	la 3,.LC26@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L62
.L63:
	mr 3,31
	bl InitTrigger
	lis 9,teleporter_touch2@ha
	lis 11,gi+72@ha
	la 9,teleporter_touch2@l(9)
	mr 3,31
	stw 9,444(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lis 9,tr_think@ha
	lis 10,level+4@ha
	la 9,tr_think@l(9)
	lis 11,.LC66@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC66@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L62:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 SP_trigger_teleport,.Lfe25-SP_trigger_teleport
	.align 2
	.globl SP_info_teleport_destination
	.type	 SP_info_teleport_destination,@function
SP_info_teleport_destination:
	blr
.Lfe26:
	.size	 SP_info_teleport_destination,.Lfe26-SP_info_teleport_destination
	.align 2
	.globl Self_Origin
	.type	 Self_Origin,@function
Self_Origin:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 28,3
	lis 29,gi@ha
	la 29,gi@l(29)
	addi 3,28,4
	bl vtos
	mr 27,3
	addi 3,28,16
	bl vtos
	lwz 0,8(29)
	mr 7,3
	lis 5,.LC35@ha
	mr 3,28
	la 5,.LC35@l(5)
	mr 6,27
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 Self_Origin,.Lfe27-Self_Origin
	.section	".rodata"
	.align 2
.LC67:
	.long 0x0
	.section	".text"
	.align 2
	.globl kill_think
	.type	 kill_think,@function
kill_think:
	lis 9,.LC67@ha
	lfs 0,328(3)
	la 9,.LC67@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bclr 12,2
	lis 9,target_kill@ha
	lis 11,level+4@ha
	lfs 13,596(3)
	la 9,target_kill@l(9)
	li 0,0
	stw 9,436(3)
	lfs 0,level+4@l(11)
	stw 0,432(3)
	fadds 0,0,13
	stfs 0,428(3)
	blr
.Lfe28:
	.size	 kill_think,.Lfe28-kill_think
	.align 2
	.globl trigger_kill
	.type	 trigger_kill,@function
trigger_kill:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,kill_think@ha
	mr 11,3
	li 0,0
	la 9,kill_think@l(9)
	stw 9,432(11)
	lis 10,gi+72@ha
	stw 0,328(11)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 trigger_kill,.Lfe29-trigger_kill
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
