	.file	"g_svcmds.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Enforced Teamplay not enabled\n"
	.align 2
.LC1:
	.string	"switch: Usage: switch [playernum] [team]\n"
	.align 2
.LC2:
	.string	"switch: invalid player number: %d\n"
	.align 2
.LC3:
	.string	"switch: player %d is not active\n"
	.align 2
.LC4:
	.string	"switch: player %d is not assigned to a team\n"
	.align 2
.LC5:
	.string	"switch: %s is neither a valid team name nor team number\n"
	.align 2
.LC6:
	.string	"switch: player %s is already on team %d\n"
	.align 2
.LC7:
	.string	"switch: player %d switched to team %d\n"
	.align 2
.LC8:
	.string	"%s was switched to team %s\n"
	.section	".text"
	.align 2
	.globl Svcmd_Switch_f
	.type	 Svcmd_Switch_f,@function
Svcmd_Switch_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,256
	bc 4,2,.L7
	lis 9,gi+8@ha
	lis 5,.LC0@ha
	lwz 0,gi+8@l(9)
	la 5,.LC0@l(5)
	li 3,0
	b .L17
.L7:
	lis 9,gi@ha
	la 28,gi@l(9)
	lwz 9,156(28)
	mtlr 9
	blrl
	cmpwi 0,3,4
	bc 12,2,.L8
	lwz 0,8(28)
	lis 5,.LC1@ha
	li 3,0
	la 5,.LC1@l(5)
.L17:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L8:
	lwz 9,160(28)
	li 3,2
	mtlr 9
	blrl
	bl atoi
	mr. 30,3
	bc 12,0,.L10
	lis 10,maxclients@ha
	lwz 9,maxclients@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	addi 11,11,-1
	cmpw 0,30,11
	bc 4,1,.L9
.L10:
	lwz 0,8(28)
	lis 5,.LC2@ha
	mr 6,30
	la 5,.LC2@l(5)
	b .L18
.L9:
	lis 11,g_edicts@ha
	mulli 9,30,916
	lwz 10,g_edicts@l(11)
	addi 9,9,916
	add 29,10,9
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 4,2,.L11
	lwz 0,8(28)
	lis 5,.LC3@ha
	mr 6,30
	la 5,.LC3@l(5)
	b .L18
.L11:
	mr 3,29
	bl playerIsOnATeam
	cmpwi 0,3,0
	bc 4,2,.L12
	lwz 0,8(28)
	lis 5,.LC4@ha
	mr 6,30
	la 5,.LC4@l(5)
	b .L18
.L12:
	lwz 9,160(28)
	li 3,3
	mtlr 9
	blrl
	bl teamForName
	mr 31,3
	cmpwi 0,31,-1
	bc 4,2,.L13
	lwz 9,160(28)
	li 3,3
	mtlr 9
	blrl
	bl atoi
	mr. 31,3
	bc 12,0,.L15
	lis 10,sv_numteams@ha
	lwz 9,sv_numteams@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	addi 11,11,-1
	cmpw 0,31,11
	bc 4,1,.L13
.L15:
	lwz 9,160(28)
	li 3,3
	mtlr 9
	blrl
	lwz 0,8(28)
	mr 6,3
	lis 5,.LC5@ha
	la 5,.LC5@l(5)
.L18:
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L13:
	lwz 6,84(29)
	lwz 0,3476(6)
	cmpw 0,0,31
	bc 4,2,.L16
	lis 9,gi+8@ha
	lis 5,.LC6@ha
	lwz 0,gi+8@l(9)
	la 5,.LC6@l(5)
	addi 6,6,700
	mr 7,31
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L16:
	mr 3,29
	mr 4,31
	bl killAndSwitchTeam
	lis 28,gi@ha
	la 9,gi@l(28)
	lis 5,.LC7@ha
	lwz 0,8(9)
	li 4,2
	la 5,.LC7@l(5)
	mr 6,30
	li 3,0
	mtlr 0
	mr 7,31
	crxor 6,6,6
	blrl
	lwz 29,84(29)
	mr 3,31
	addi 29,29,700
	bl nameForTeam
	lwz 0,gi@l(28)
	mr 6,3
	lis 4,.LC8@ha
	la 4,.LC8@l(4)
	mr 5,29
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L6:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Svcmd_Switch_f,.Lfe1-Svcmd_Switch_f
	.section	".rodata"
	.align 2
.LC9:
	.string	"clearprops: Usage: clearprops\n"
	.align 2
.LC10:
	.string	"All properties cleared\n"
	.align 2
.LC11:
	.string	"prop: Usage: prop [property] [value]\n"
	.align 2
.LC12:
	.string	"Properties defined:\n"
	.align 2
.LC13:
	.string	"\"%s\" is %s\n"
	.align 2
.LC14:
	.string	""
	.align 2
.LC15:
	.string	"Removed property \"%s\"\n"
	.align 2
.LC16:
	.string	"Property \"%s\" is now \"%s\"\n"
	.section	".text"
	.align 2
	.globl Svcmd_Prop_f
	.type	 Svcmd_Prop_f,@function
Svcmd_Prop_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,4
	bc 12,1,.L24
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,1
	bc 12,1,.L23
.L24:
	lwz 0,8(31)
	lis 5,.LC11@ha
	li 3,0
	la 5,.LC11@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L22
.L23:
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,2
	bc 4,2,.L25
	lwz 0,8(31)
	lis 5,.LC12@ha
	li 3,0
	la 5,.LC12@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,gProperties@ha
	lwz 3,gProperties@l(9)
	bl printProps
	b .L22
.L25:
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L27
	lwz 11,160(31)
	li 3,2
	lis 9,gProperties@ha
	lwz 29,gProperties@l(9)
	mtlr 11
	blrl
	mr 4,3
	mr 3,29
	bl getProp
	lwz 9,160(31)
	mr 29,3
	li 3,2
	mtlr 9
	blrl
	lwz 0,8(31)
	mr 6,3
	lis 5,.LC13@ha
	la 5,.LC13@l(5)
	mr 7,29
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L22
.L27:
	lwz 9,160(31)
	li 3,3
	mtlr 9
	blrl
	mr 4,3
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L29
	lwz 11,160(31)
	li 3,2
	lis 9,gProperties@ha
	lwz 29,gProperties@l(9)
	mtlr 11
	blrl
	mr 4,3
	mr 3,29
	bl removeProp
	lwz 9,160(31)
	li 3,2
	mtlr 9
	blrl
	lwz 0,8(31)
	mr 6,3
	lis 5,.LC15@ha
	la 5,.LC15@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L22
.L29:
	lwz 11,160(31)
	li 3,2
	lis 9,gProperties@ha
	lwz 28,gProperties@l(9)
	mtlr 11
	blrl
	lwz 9,160(31)
	mr 29,3
	li 3,3
	mtlr 9
	blrl
	mr 5,3
	mr 4,29
	mr 3,28
	bl addProp
	lwz 9,160(31)
	li 3,2
	mtlr 9
	blrl
	lwz 9,160(31)
	mr 29,3
	li 3,3
	mtlr 9
	blrl
	lwz 0,8(31)
	mr 7,3
	lis 5,.LC16@ha
	la 5,.LC16@l(5)
	mr 6,29
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L22:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Svcmd_Prop_f,.Lfe2-Svcmd_Prop_f
	.section	".rodata"
	.align 2
.LC17:
	.string	"stuffall: Usage: stuffall \"command text\"\n"
	.align 2
.LC18:
	.string	"Stuffing \"%s\" to all players\n"
	.align 2
.LC19:
	.string	"\n"
	.align 2
.LC20:
	.long 0x3f800000
	.align 3
.LC21:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Svcmd_StuffAll_f
	.type	 Svcmd_StuffAll_f,@function
Svcmd_StuffAll_f:
	stwu 1,-2096(1)
	mflr 0
	stfd 31,2088(1)
	stmw 28,2072(1)
	stw 0,2100(1)
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 12,2,.L32
	lwz 0,8(31)
	lis 5,.LC17@ha
	li 3,0
	la 5,.LC17@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L31
.L32:
	lwz 9,160(31)
	li 3,2
	li 30,1
	lis 28,maxclients@ha
	mtlr 9
	blrl
	lwz 9,8(31)
	mr 6,3
	lis 5,.LC18@ha
	la 5,.LC18@l(5)
	li 4,2
	mtlr 9
	li 3,0
	crxor 6,6,6
	blrl
	lwz 9,160(31)
	li 3,2
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lwz 0,160(31)
	li 3,2
	mtlr 0
	blrl
	bl strlen
	addi 0,1,8
	lis 4,.LC19@ha
	add 3,0,3
	la 4,.LC19@l(4)
	bl strcat
	lis 11,maxclients@ha
	lis 9,.LC20@ha
	lwz 10,maxclients@l(11)
	la 9,.LC20@l(9)
	lfs 13,0(9)
	lfs 0,20(10)
	lis 9,g_edicts@ha
	lwz 11,g_edicts@l(9)
	fcmpu 0,13,0
	addi 31,11,916
	cror 3,2,0
	bc 4,3,.L31
	lis 9,.LC21@ha
	lis 29,0x4330
	la 9,.LC21@l(9)
	lfd 31,0(9)
.L36:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L37
	mr 3,31
	addi 4,1,8
	bl StuffCmd
.L37:
	addi 30,30,1
	lwz 11,maxclients@l(28)
	xoris 0,30,0x8000
	addi 31,31,916
	stw 0,2068(1)
	stw 29,2064(1)
	lfd 0,2064(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L36
.L31:
	lwz 0,2100(1)
	mtlr 0
	lmw 28,2072(1)
	lfd 31,2088(1)
	la 1,2096(1)
	blr
.Lfe3:
	.size	 Svcmd_StuffAll_f,.Lfe3-Svcmd_StuffAll_f
	.section	".rodata"
	.align 2
.LC22:
	.string	"stuff: Usage: stuff [playernum] \"command text\"\n"
	.align 2
.LC23:
	.string	"stuff: invalid player number: %d\n"
	.align 2
.LC24:
	.string	"stuff: player %d is not active\n"
	.align 2
.LC25:
	.string	"Stuffing \"%s\" to player %s\n"
	.section	".text"
	.align 2
	.globl Svcmd_Stuff_f
	.type	 Svcmd_Stuff_f,@function
Svcmd_Stuff_f:
	stwu 1,-2096(1)
	mflr 0
	stmw 29,2084(1)
	stw 0,2100(1)
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,4
	bc 12,2,.L40
	lwz 0,8(31)
	lis 5,.LC22@ha
	li 3,0
	la 5,.LC22@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L39
.L40:
	lwz 9,160(31)
	li 3,2
	mtlr 9
	blrl
	bl atoi
	mr. 3,3
	bc 12,0,.L42
	lis 10,maxclients@ha
	lwz 9,maxclients@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,2072(1)
	lwz 11,2076(1)
	addi 11,11,-1
	cmpw 0,3,11
	bc 4,1,.L41
.L42:
	lwz 0,8(31)
	lis 5,.LC23@ha
	mr 6,3
	la 5,.LC23@l(5)
	b .L44
.L41:
	lis 11,g_edicts@ha
	mulli 9,3,916
	lwz 10,g_edicts@l(11)
	addi 9,9,916
	add 30,10,9
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 4,2,.L43
	lwz 0,8(31)
	lis 5,.LC24@ha
	mr 6,3
	la 5,.LC24@l(5)
.L44:
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L39
.L43:
	lwz 9,160(31)
	li 3,3
	addi 29,1,8
	mtlr 9
	blrl
	lwz 9,8(31)
	mr 6,3
	lis 5,.LC25@ha
	lwz 7,84(30)
	la 5,.LC25@l(5)
	li 4,2
	mtlr 9
	li 3,0
	addi 7,7,700
	crxor 6,6,6
	blrl
	lwz 9,160(31)
	li 3,3
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lwz 0,160(31)
	li 3,3
	mtlr 0
	blrl
	bl strlen
	lis 4,.LC19@ha
	add 3,29,3
	la 4,.LC19@l(4)
	bl strcat
	mr 3,30
	mr 4,29
	bl StuffCmd
.L39:
	lwz 0,2100(1)
	mtlr 0
	lmw 29,2084(1)
	la 1,2096(1)
	blr
.Lfe4:
	.size	 Svcmd_Stuff_f,.Lfe4-Svcmd_Stuff_f
	.section	".rodata"
	.align 2
.LC26:
	.string	"set: Usage: set \"flagname\" [off|on]\n"
	.align 2
.LC27:
	.string	"Unrecognized setting \"%s\"\n"
	.align 2
.LC28:
	.string	"expflags"
	.align 2
.LC29:
	.string	"%d"
	.align 2
.LC30:
	.string	"Setting \"%s\" is now enabled\n"
	.align 2
.LC31:
	.string	"off"
	.align 2
.LC32:
	.string	"Setting \"%s\" is now disabled\n"
	.align 2
.LC33:
	.string	"on"
	.section	".text"
	.align 2
	.globl Svcmd_ExpflagsSet_f
	.type	 Svcmd_ExpflagsSet_f,@function
Svcmd_ExpflagsSet_f:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,2
	bc 4,1,.L47
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,4
	bc 4,1,.L46
.L47:
	lwz 0,8(31)
	lis 5,.LC26@ha
	li 3,0
	la 5,.LC26@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L45
.L46:
	lwz 9,160(31)
	li 3,2
	mtlr 9
	blrl
	mr 29,3
	bl getSettingBit
	mr. 30,3
	bc 12,1,.L48
	lwz 0,8(31)
	lis 5,.LC27@ha
	mr 6,29
	la 5,.LC27@l(5)
	b .L55
.L48:
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 12,2,.L56
	lwz 9,160(31)
	li 3,3
	mtlr 9
	blrl
	mr 4,3
	lis 3,.LC31@ha
	la 3,.LC31@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L51
	lis 9,sv_expflags@ha
	lwz 11,sv_expflags@l(9)
	lis 3,.LC29@ha
	la 3,.LC29@l(3)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 4,28(1)
	andc 4,4,30
	crxor 6,6,6
	bl va
	mr 4,3
	lwz 9,148(31)
	lis 3,.LC28@ha
	mtlr 9
	la 3,.LC28@l(3)
	blrl
	lwz 0,8(31)
	lis 5,.LC32@ha
	mr 6,29
	la 5,.LC32@l(5)
	b .L55
.L51:
	lwz 9,160(31)
	li 3,3
	mtlr 9
	blrl
	mr 4,3
	lis 3,.LC33@ha
	la 3,.LC33@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L53
.L56:
	lis 9,sv_expflags@ha
	lwz 11,sv_expflags@l(9)
	lis 3,.LC29@ha
	la 3,.LC29@l(3)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 4,28(1)
	or 4,4,30
	crxor 6,6,6
	bl va
	mr 4,3
	lwz 9,148(31)
	lis 3,.LC28@ha
	mtlr 9
	la 3,.LC28@l(3)
	blrl
	lwz 0,8(31)
	lis 5,.LC30@ha
	mr 6,29
	la 5,.LC30@l(5)
.L55:
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L45
.L53:
	lwz 0,8(31)
	lis 5,.LC26@ha
	li 3,0
	la 5,.LC26@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L45:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 Svcmd_ExpflagsSet_f,.Lfe5-Svcmd_ExpflagsSet_f
	.section	".rodata"
	.align 2
.LC34:
	.string	"Can't pause in an intermission.\n"
	.align 2
.LC35:
	.string	"Game paused by console\n"
	.align 2
.LC36:
	.string	"Game unpaused\n"
	.align 2
.LC37:
	.string	"password \"\""
	.align 2
.LC38:
	.string	"Bad filter address: %s\n"
	.section	".text"
	.align 2
	.type	 StringToFilter,@function
StringToFilter:
	stwu 1,-192(1)
	mflr 0
	stmw 23,156(1)
	stw 0,196(1)
	li 10,4
	addi 28,1,136
	mtctr 10
	addi 29,1,140
	mr 11,28
	mr 9,29
	mr 31,3
	mr 27,4
	li 30,0
	li 0,0
.L81:
	stbx 0,30,11
	stbx 0,30,9
	addi 30,30,1
	bdnz .L81
	lis 9,gi@ha
	li 30,0
	la 24,gi@l(9)
	lis 23,.LC38@ha
	li 25,0
	li 26,255
.L71:
	lbz 9,0(31)
	addi 9,9,-48
	cmplwi 0,9,9
	bc 4,1,.L72
	lwz 0,8(24)
	li 3,0
	la 5,.LC38@l(23)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L80
.L72:
	addi 3,1,8
	li 11,0
	mr 10,3
.L75:
	lbz 0,0(31)
	lbzu 9,1(31)
	stbx 0,10,11
	addi 9,9,-48
	addi 11,11,1
	cmplwi 0,9,9
	bc 4,1,.L75
	stbx 25,3,11
	bl atoi
	rlwinm 0,3,0,0xff
	stbx 3,30,28
	cmpwi 0,0,0
	bc 12,2,.L77
	stbx 26,30,29
.L77:
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L69
	addi 30,30,1
	addi 31,31,1
	cmpwi 0,30,3
	bc 4,1,.L71
.L69:
	lwz 9,140(1)
	li 3,1
	lwz 0,136(1)
	stw 9,0(27)
	stw 0,4(27)
.L80:
	lwz 0,196(1)
	mtlr 0
	lmw 23,156(1)
	la 1,192(1)
	blr
.Lfe6:
	.size	 StringToFilter,.Lfe6-StringToFilter
	.section	".rodata"
	.align 2
.LC39:
	.long 0x0
	.section	".text"
	.align 2
	.globl SV_FilterPacket
	.type	 SV_FilterPacket,@function
SV_FilterPacket:
	stwu 1,-32(1)
	lbz 0,0(3)
	li 8,0
	cmpwi 0,0,0
	bc 12,2,.L84
	addi 6,1,8
	li 5,0
.L85:
	stbx 5,8,6
	lbz 10,0(3)
	addi 0,10,-48
	cmplwi 0,0,9
	bc 12,1,.L87
	mr 7,6
	mr 9,5
.L88:
	rlwinm 9,9,0,0xff
	mulli 9,9,10
	addi 9,9,208
	add 11,10,9
	lbzu 10,1(3)
	mr 9,11
	addi 0,10,-48
	cmplwi 0,0,9
	bc 4,1,.L88
	stbx 11,8,7
.L87:
	lbz 0,0(3)
	xori 9,0,58
	subfic 11,9,0
	adde 9,11,9
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L84
	addi 8,8,1
	lbzu 0,1(3)
	cmpwi 7,8,3
	neg 0,0
	srwi 0,0,31
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	and. 11,0,9
	bc 4,2,.L85
.L84:
	lis 9,numipfilters@ha
	li 8,0
	lwz 6,8(1)
	lwz 0,numipfilters@l(9)
	cmpw 0,8,0
	bc 4,0,.L93
	lis 9,filterban@ha
	lis 11,ipfilters@ha
	lwz 7,filterban@l(9)
	mr 10,0
	la 11,ipfilters@l(11)
.L95:
	lwz 0,0(11)
	lwz 9,4(11)
	and 0,6,0
	cmpw 0,0,9
	bc 4,2,.L94
	lfs 0,20(7)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 3,28(1)
	b .L98
.L94:
	addi 8,8,1
	addi 11,11,8
	cmpw 0,8,10
	bc 12,0,.L95
.L93:
	lis 9,.LC39@ha
	lis 11,filterban@ha
	la 9,.LC39@l(9)
	lfs 13,0(9)
	lwz 9,filterban@l(11)
	lfs 0,20(9)
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,31,1
.L98:
	la 1,32(1)
	blr
.Lfe7:
	.size	 SV_FilterPacket,.Lfe7-SV_FilterPacket
	.section	".rodata"
	.align 2
.LC40:
	.string	"Usage:  addip <ip-mask>\n"
	.align 2
.LC41:
	.string	"IP filter list is full\n"
	.section	".text"
	.align 2
	.globl SVCmd_AddIP_f
	.type	 SVCmd_AddIP_f,@function
SVCmd_AddIP_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,2
	bc 12,1,.L101
	lwz 0,8(31)
	lis 5,.LC40@ha
	li 3,0
	la 5,.LC40@l(5)
	b .L111
.L101:
	lis 9,numipfilters@ha
	li 31,0
	lwz 11,numipfilters@l(9)
	cmpw 0,31,11
	bc 4,0,.L103
	lis 9,ipfilters@ha
	la 9,ipfilters@l(9)
	lwz 0,4(9)
	addi 10,9,4
	cmpwi 0,0,-1
	bc 12,2,.L103
	mr 9,10
.L104:
	addi 31,31,1
	cmpw 0,31,11
	bc 4,0,.L103
	lwzu 0,8(9)
	cmpwi 0,0,-1
	bc 4,2,.L104
.L103:
	lis 9,numipfilters@ha
	lwz 0,numipfilters@l(9)
	cmpw 0,31,0
	bc 4,2,.L108
	cmpwi 0,31,1024
	bc 4,2,.L109
	lis 9,gi+8@ha
	lis 5,.LC41@ha
	lwz 0,gi+8@l(9)
	la 5,.LC41@l(5)
	li 3,0
.L111:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L100
.L109:
	addi 0,31,1
	lis 9,numipfilters@ha
	stw 0,numipfilters@l(9)
.L108:
	lis 9,gi+160@ha
	li 3,2
	lwz 0,gi+160@l(9)
	slwi 31,31,3
	mtlr 0
	blrl
	lis 9,ipfilters@ha
	la 30,ipfilters@l(9)
	add 4,31,30
	bl StringToFilter
	cmpwi 0,3,0
	bc 4,2,.L100
	addi 9,30,4
	li 0,-1
	stwx 0,9,31
.L100:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 SVCmd_AddIP_f,.Lfe8-SVCmd_AddIP_f
	.section	".rodata"
	.align 2
.LC42:
	.string	"Usage:  sv removeip <ip-mask>\n"
	.align 2
.LC43:
	.string	"Removed.\n"
	.align 2
.LC44:
	.string	"Didn't find %s.\n"
	.section	".text"
	.align 2
	.globl SVCmd_RemoveIP_f
	.type	 SVCmd_RemoveIP_f,@function
SVCmd_RemoveIP_f:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,gi@ha
	la 31,gi@l(9)
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,2
	bc 12,1,.L113
	lwz 0,8(31)
	lis 5,.LC42@ha
	li 3,0
	la 5,.LC42@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L112
.L113:
	lwz 9,160(31)
	li 3,2
	addi 29,1,8
	mtlr 9
	blrl
	mr 4,29
	bl StringToFilter
	cmpwi 0,3,0
	bc 12,2,.L112
	lis 9,numipfilters@ha
	li 10,0
	lwz 0,numipfilters@l(9)
	lis 8,numipfilters@ha
	cmpw 0,10,0
	bc 4,0,.L116
	lis 9,ipfilters@ha
	mr 3,31
	la 11,ipfilters@l(9)
	lis 7,numipfilters@ha
	mr 4,11
	lis 6,numipfilters@ha
.L118:
	lwz 9,0(11)
	lwz 0,8(1)
	cmpw 0,9,0
	bc 4,2,.L117
	lwz 9,4(11)
	lwz 0,4(29)
	cmpw 0,9,0
	bc 4,2,.L117
	lwz 0,numipfilters@l(8)
	addi 10,10,1
	lis 5,.LC43@ha
	mtctr 10
	cmpw 0,10,0
	bc 4,0,.L121
	slwi 0,10,3
	lwz 9,numipfilters@l(6)
	add 11,0,4
	mfctr 0
	subf 0,0,9
	mtctr 0
.L123:
	lfd 0,0(11)
	stfd 0,-8(11)
	addi 11,11,8
	bdnz .L123
.L121:
	lwz 0,8(3)
	la 5,.LC43@l(5)
	li 4,2
	lwz 9,numipfilters@l(7)
	li 3,0
	mtlr 0
	addi 9,9,-1
	stw 9,numipfilters@l(7)
	crxor 6,6,6
	blrl
	b .L112
.L117:
	lwz 0,numipfilters@l(8)
	addi 10,10,1
	addi 11,11,8
	cmpw 0,10,0
	bc 12,0,.L118
.L116:
	lis 29,gi@ha
	li 3,2
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	lwz 0,8(29)
	mr 6,3
	lis 5,.LC44@ha
	la 5,.LC44@l(5)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L112:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 SVCmd_RemoveIP_f,.Lfe9-SVCmd_RemoveIP_f
	.section	".rodata"
	.align 2
.LC45:
	.string	"Filter list:\n"
	.align 2
.LC46:
	.string	"%3i.%3i.%3i.%3i\n"
	.align 2
.LC47:
	.string	"game"
	.align 2
.LC48:
	.string	"%s/listip.cfg"
	.align 2
.LC49:
	.string	"expert"
	.align 2
.LC50:
	.string	"Writing %s.\n"
	.align 2
.LC51:
	.string	"wb"
	.align 2
.LC52:
	.string	"Couldn't open %s\n"
	.align 2
.LC53:
	.string	"set filterban %d\n"
	.align 2
.LC54:
	.string	"sv addip %i.%i.%i.%i\n"
	.section	".text"
	.align 2
	.globl SVCmd_WriteIP_f
	.type	 SVCmd_WriteIP_f,@function
SVCmd_WriteIP_f:
	stwu 1,-192(1)
	mflr 0
	stmw 26,168(1)
	stw 0,196(1)
	lis 9,gi+144@ha
	lis 3,.LC47@ha
	lwz 0,gi+144@l(9)
	lis 4,.LC14@ha
	li 5,0
	la 3,.LC47@l(3)
	la 4,.LC14@l(4)
	mtlr 0
	blrl
	lwz 5,4(3)
	lbz 0,0(5)
	cmpwi 0,0,0
	bc 4,2,.L133
	lis 4,.LC48@ha
	lis 5,.LC49@ha
	la 4,.LC48@l(4)
	la 5,.LC49@l(5)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L134
.L133:
	lis 4,.LC48@ha
	addi 3,1,8
	la 4,.LC48@l(4)
	crxor 6,6,6
	bl sprintf
.L134:
	lis 9,gi@ha
	lis 5,.LC50@ha
	la 31,gi@l(9)
	li 4,2
	lwz 9,8(31)
	la 5,.LC50@l(5)
	li 3,0
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
	lis 4,.LC51@ha
	addi 3,1,8
	la 4,.LC51@l(4)
	bl fopen
	mr. 28,3
	bc 4,2,.L135
	lwz 0,8(31)
	lis 5,.LC52@ha
	li 3,0
	la 5,.LC52@l(5)
	li 4,2
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
	b .L132
.L135:
	lis 9,filterban@ha
	lwz 11,filterban@l(9)
	lis 4,.LC53@ha
	mr 3,28
	la 4,.LC53@l(4)
	li 29,0
	lfs 0,20(11)
	lis 26,numipfilters@ha
	fctiwz 13,0
	stfd 13,160(1)
	lwz 5,164(1)
	crxor 6,6,6
	bl fprintf
	lis 9,numipfilters@ha
	lwz 0,numipfilters@l(9)
	cmpw 0,29,0
	bc 4,0,.L137
	lis 9,ipfilters@ha
	addi 31,1,136
	la 9,ipfilters@l(9)
	lis 27,.LC54@ha
	addi 30,9,4
.L139:
	lwz 5,0(30)
	mr 3,28
	la 4,.LC54@l(27)
	addi 29,29,1
	addi 30,30,8
	stw 5,136(1)
	lbz 6,1(31)
	srwi 5,5,24
	lbz 7,2(31)
	lbz 8,3(31)
	crxor 6,6,6
	bl fprintf
	lwz 0,numipfilters@l(26)
	cmpw 0,29,0
	bc 12,0,.L139
.L137:
	mr 3,28
	bl fclose
.L132:
	lwz 0,196(1)
	mtlr 0
	lmw 26,168(1)
	la 1,192(1)
	blr
.Lfe10:
	.size	 SVCmd_WriteIP_f,.Lfe10-SVCmd_WriteIP_f
	.section	".rodata"
	.align 2
.LC55:
	.string	"prop"
	.align 2
.LC56:
	.string	"clearprops"
	.align 2
.LC57:
	.string	"switch"
	.align 2
.LC58:
	.string	"stuff"
	.align 2
.LC59:
	.string	"stuffall"
	.align 2
.LC60:
	.string	"set"
	.align 2
.LC61:
	.string	"clearpass"
	.align 2
.LC62:
	.string	"pause"
	.align 2
.LC63:
	.string	"addip"
	.align 2
.LC64:
	.string	"removeip"
	.align 2
.LC65:
	.string	"listip"
	.align 2
.LC66:
	.string	"writeip"
	.align 2
.LC67:
	.string	"Unknown server command \"%s\"\n"
	.align 2
.LC68:
	.long 0x0
	.section	".text"
	.align 2
	.globl ServerCommand
	.type	 ServerCommand,@function
ServerCommand:
	stwu 1,-64(1)
	mflr 0
	stmw 26,40(1)
	stw 0,68(1)
	lis 9,gi@ha
	li 3,1
	la 31,gi@l(9)
	lwz 9,160(31)
	mtlr 9
	blrl
	mr 29,3
	lis 4,.LC55@ha
	la 4,.LC55@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L142
	bl Svcmd_Prop_f
	b .L143
.L142:
	lis 4,.LC56@ha
	mr 3,29
	la 4,.LC56@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L144
	lwz 9,156(31)
	mtlr 9
	blrl
	cmpwi 0,3,2
	bc 12,2,.L145
	lwz 0,8(31)
	lis 5,.LC9@ha
	li 3,0
	la 5,.LC9@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L143
.L145:
	lwz 0,8(31)
	lis 5,.LC10@ha
	li 4,2
	la 5,.LC10@l(5)
	li 3,0
	mtlr 0
	lis 29,gProperties@ha
	crxor 6,6,6
	blrl
	lwz 3,gProperties@l(29)
	bl freeProps
	bl newProps
	stw 3,gProperties@l(29)
	b .L143
.L144:
	lis 4,.LC57@ha
	mr 3,29
	la 4,.LC57@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L149
	bl Svcmd_Switch_f
	b .L143
.L149:
	lis 4,.LC58@ha
	mr 3,29
	la 4,.LC58@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L151
	bl Svcmd_Stuff_f
	b .L143
.L151:
	lis 4,.LC59@ha
	mr 3,29
	la 4,.LC59@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L153
	bl Svcmd_StuffAll_f
	b .L143
.L153:
	lis 4,.LC60@ha
	mr 3,29
	la 4,.LC60@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L155
	bl Svcmd_ExpflagsSet_f
	b .L143
.L155:
	lis 4,.LC61@ha
	mr 3,29
	la 4,.LC61@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L157
	lwz 0,168(31)
	lis 3,.LC37@ha
	la 3,.LC37@l(3)
	mtlr 0
	blrl
	b .L143
.L157:
	lis 4,.LC62@ha
	mr 3,29
	la 4,.LC62@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L160
	lis 30,sv_paused@ha
	lwz 11,sv_paused@l(30)
	lfs 13,20(11)
	fctiwz 0,13
	stfd 0,32(1)
	lwz 9,36(1)
	cmpwi 0,9,0
	bc 4,2,.L161
	lis 11,.LC68@ha
	lis 9,level+200@ha
	la 11,.LC68@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,2,.L162
	lwz 0,8(31)
	lis 5,.LC34@ha
	li 3,0
	la 5,.LC34@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L162:
	lwz 9,sv_paused@l(30)
	lis 0,0x3f80
	lis 11,gi@ha
	lis 4,.LC35@ha
	li 3,2
	stw 0,20(9)
	la 4,.LC35@l(4)
	lwz 0,gi@l(11)
	b .L180
.L161:
	li 0,0
	lis 9,gi@ha
	stw 0,20(11)
	lis 4,.LC36@ha
	li 3,2
	lwz 0,gi@l(9)
	la 4,.LC36@l(4)
.L180:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L143
.L160:
	lis 4,.LC63@ha
	mr 3,29
	la 4,.LC63@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L166
	bl SVCmd_AddIP_f
	b .L143
.L166:
	lis 4,.LC64@ha
	mr 3,29
	la 4,.LC64@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L168
	bl SVCmd_RemoveIP_f
	b .L143
.L168:
	lis 4,.LC65@ha
	mr 3,29
	la 4,.LC65@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L170
	lis 9,gi@ha
	lis 5,.LC45@ha
	la 30,gi@l(9)
	la 5,.LC45@l(5)
	lwz 9,8(30)
	li 3,0
	li 4,2
	li 31,0
	lis 26,numipfilters@ha
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,numipfilters@ha
	lwz 0,numipfilters@l(9)
	cmpw 0,31,0
	bc 4,0,.L143
	lis 9,ipfilters@ha
	mr 27,30
	la 9,ipfilters@l(9)
	addi 29,1,8
	addi 30,9,4
	lis 28,.LC46@ha
.L173:
	lwz 6,0(30)
	li 3,0
	li 4,2
	lwz 11,8(27)
	la 5,.LC46@l(28)
	addi 31,31,1
	stw 6,8(1)
	addi 30,30,8
	srwi 6,6,24
	lbz 7,1(29)
	mtlr 11
	lbz 8,2(29)
	lbz 9,3(29)
	crxor 6,6,6
	blrl
	lwz 0,numipfilters@l(26)
	cmpw 0,31,0
	bc 12,0,.L173
	b .L143
.L170:
	lis 4,.LC66@ha
	mr 3,29
	la 4,.LC66@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L178
	bl SVCmd_WriteIP_f
	b .L143
.L178:
	lis 9,gi+8@ha
	lis 5,.LC67@ha
	lwz 0,gi+8@l(9)
	la 5,.LC67@l(5)
	mr 6,29
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L143:
	lwz 0,68(1)
	mtlr 0
	lmw 26,40(1)
	la 1,64(1)
	blr
.Lfe11:
	.size	 ServerCommand,.Lfe11-ServerCommand
	.comm	gametype,4,4
	.comm	flags,4,4
	.comm	gCauseTable,4,4
	.align 2
	.globl Svcmd_ClearProps_f
	.type	 Svcmd_ClearProps_f,@function
Svcmd_ClearProps_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,2
	bc 12,2,.L20
	lwz 0,8(29)
	lis 5,.LC9@ha
	li 3,0
	la 5,.LC9@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L21
.L20:
	lwz 0,8(29)
	lis 5,.LC10@ha
	li 4,2
	la 5,.LC10@l(5)
	li 3,0
	mtlr 0
	lis 29,gProperties@ha
	crxor 6,6,6
	blrl
	lwz 3,gProperties@l(29)
	bl freeProps
	bl newProps
	stw 3,gProperties@l(29)
.L21:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 Svcmd_ClearProps_f,.Lfe12-Svcmd_ClearProps_f
	.section	".rodata"
	.align 2
.LC69:
	.long 0x0
	.section	".text"
	.align 2
	.globl Svcmd_Pause_f
	.type	 Svcmd_Pause_f,@function
Svcmd_Pause_f:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 31,sv_paused@ha
	lwz 11,sv_paused@l(31)
	lfs 13,20(11)
	fctiwz 0,13
	stfd 0,16(1)
	lwz 9,20(1)
	cmpwi 0,9,0
	bc 4,2,.L58
	lis 11,.LC69@ha
	lis 9,level+200@ha
	la 11,.LC69@l(11)
	lfs 0,level+200@l(9)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,2,.L59
	lis 9,gi@ha
	lis 5,.LC34@ha
	la 9,gi@l(9)
	la 5,.LC34@l(5)
	lwz 0,8(9)
	li 3,0
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L59:
	lwz 9,sv_paused@l(31)
	lis 0,0x3f80
	lis 11,gi@ha
	lis 4,.LC35@ha
	li 3,2
	stw 0,20(9)
	la 4,.LC35@l(4)
	lwz 0,gi@l(11)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L60
.L58:
	li 0,0
	lis 9,gi@ha
	stw 0,20(11)
	lis 4,.LC36@ha
	li 3,2
	lwz 0,gi@l(9)
	la 4,.LC36@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L60:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 Svcmd_Pause_f,.Lfe13-Svcmd_Pause_f
	.align 2
	.globl Svcmd_ClearPass_f
	.type	 Svcmd_ClearPass_f,@function
Svcmd_ClearPass_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+168@ha
	lis 3,.LC37@ha
	lwz 0,gi+168@l(9)
	la 3,.LC37@l(3)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 Svcmd_ClearPass_f,.Lfe14-Svcmd_ClearPass_f
	.comm	ipfilters,8192,4
	.comm	numipfilters,4,4
	.align 2
	.globl SVCmd_ListIP_f
	.type	 SVCmd_ListIP_f,@function
SVCmd_ListIP_f:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 9,gi@ha
	lis 5,.LC45@ha
	la 31,gi@l(9)
	la 5,.LC45@l(5)
	lwz 9,8(31)
	li 3,0
	li 4,2
	li 30,0
	lis 26,numipfilters@ha
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,numipfilters@ha
	lwz 0,numipfilters@l(9)
	cmpw 0,30,0
	bc 4,0,.L128
	lis 9,ipfilters@ha
	mr 27,31
	la 9,ipfilters@l(9)
	addi 31,1,8
	addi 29,9,4
	lis 28,.LC46@ha
.L130:
	lwz 6,0(29)
	li 3,0
	li 4,2
	lwz 11,8(27)
	la 5,.LC46@l(28)
	addi 30,30,1
	stw 6,8(1)
	addi 29,29,8
	srwi 6,6,24
	lbz 7,1(31)
	mtlr 11
	lbz 8,2(31)
	lbz 9,3(31)
	crxor 6,6,6
	blrl
	lwz 0,numipfilters@l(26)
	cmpw 0,30,0
	bc 12,0,.L130
.L128:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 SVCmd_ListIP_f,.Lfe15-SVCmd_ListIP_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
