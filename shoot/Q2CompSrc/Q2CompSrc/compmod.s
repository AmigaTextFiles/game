	.file	"compmod.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	""
	.align 2
.LC1:
	.string	"\nYou are not an Admin.\n"
	.align 2
.LC2:
	.string	"To become an Admin, use the command:\n"
	.align 2
.LC3:
	.string	"'admin <code>' - where <code> is the Admin code.\n"
	.align 2
.LC4:
	.string	"\n%s is now an Admin.\n"
	.align 2
.LC5:
	.string	"The Admin code '%s' is incorrect.\n"
	.align 2
.LC6:
	.string	"Too many invalid Admin tries, %s. You are gone.\n"
	.align 2
.LC7:
	.string	"disconnect\n"
	.align 2
.LC8:
	.string	"Something is whacked - adminflag is %i\n"
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_Admin_f
	.type	 Cmd_Admin_f,@function
Cmd_Admin_f:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 4,2,.L6
	lis 29,gi@ha
	li 3,1
	la 30,gi@l(29)
	lwz 9,160(30)
	mtlr 9
	blrl
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L10
	lwz 9,8(30)
	lis 5,.LC1@ha
	mr 3,31
	la 5,.LC1@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC2@ha
	mr 3,31
	la 5,.LC2@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(30)
	lis 5,.LC3@ha
	mr 3,31
	la 5,.LC3@l(5)
	li 4,2
	b .L16
.L10:
	lwz 9,160(30)
	li 3,1
	mtlr 9
	blrl
	lis 11,admincode@ha
	lwz 9,admincode@l(11)
	lwz 4,4(9)
	bl Q_stricmp
	mr. 10,3
	bc 4,2,.L12
	lwz 11,84(31)
	li 0,2
	lis 4,.LC4@ha
	la 4,.LC4@l(4)
	li 3,2
	stw 0,3456(11)
	lwz 9,84(31)
	stw 10,3460(9)
	lwz 5,84(31)
	lwz 0,gi@l(29)
	addi 5,5,700
.L16:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L12:
	lwz 9,160(30)
	li 3,1
	mtlr 9
	blrl
	lwz 0,8(30)
	mr 6,3
	lis 5,.LC5@ha
	la 5,.LC5@l(5)
	mr 3,31
	mtlr 0
	li 4,2
	crxor 6,6,6
	blrl
	lis 9,.LC9@ha
	lwz 7,84(31)
	lis 11,adminkick@ha
	la 9,.LC9@l(9)
	lwz 8,adminkick@l(11)
	lfd 13,0(9)
	lis 6,0x4330
	lwz 9,3460(7)
	addi 9,9,1
	stw 9,3460(7)
	lwz 5,84(31)
	lfs 12,20(8)
	lwz 0,3460(5)
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 6,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L6
	lwz 0,gi@l(29)
	lis 4,.LC6@ha
	li 3,1
	la 4,.LC6@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 4,.LC7@ha
	mr 3,31
	la 4,.LC7@l(4)
	bl StuffCommand
.L6:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 Cmd_Admin_f,.Lfe1-Cmd_Admin_f
	.section	".rodata"
	.align 2
.LC10:
	.string	""
	.globl memset
	.align 2
.LC11:
	.string	"\n"
	.align 2
.LC12:
	.string	"clan"
	.align 2
.LC13:
	.string	"usedclan"
	.align 2
.LC14:
	.string	"Used\n"
	.align 2
.LC15:
	.string	"Team List\n"
	.align 2
.LC16:
	.string	"---------\n"
	.align 2
.LC17:
	.string	"%s - %i\n"
	.section	".text"
	.align 2
	.globl Cmd_ClanList_f
	.type	 Cmd_ClanList_f,@function
Cmd_ClanList_f:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 9,.LC10@ha
	mr 30,3
	lbz 0,.LC10@l(9)
	mr 29,4
	addi 3,1,9
	li 5,8
	li 4,0
	stb 0,8(1)
	li 31,0
	crxor 6,6,6
	bl memset
	lis 9,gi@ha
	lis 5,.LC11@ha
	la 28,gi@l(9)
	la 5,.LC11@l(5)
	lwz 9,8(28)
	mr 3,30
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	cmpwi 0,29,0
	bc 4,2,.L24
	lis 9,.LC12@ha
	la 11,.LC12@l(9)
	lwz 0,.LC12@l(9)
	lbz 10,4(11)
	stw 0,8(1)
	stb 10,12(1)
	b .L25
.L24:
	lwz 7,8(28)
	lis 9,.LC13@ha
	lis 5,.LC14@ha
	lwz 8,.LC13@l(9)
	la 5,.LC14@l(5)
	mr 3,30
	la 9,.LC13@l(9)
	li 4,2
	mtlr 7
	lbz 0,8(9)
	addi 11,1,8
	lwz 10,4(9)
	stw 8,8(1)
	stb 0,8(11)
	stw 10,4(11)
	crxor 6,6,6
	blrl
.L25:
	lis 29,gi@ha
	lis 5,.LC15@ha
	la 29,gi@l(29)
	la 5,.LC15@l(5)
	lwz 9,8(29)
	mr 3,30
	li 4,2
	mr 27,29
	lis 28,.LC17@ha
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC16@ha
	mr 3,30
	la 5,.LC16@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,team@ha
	la 29,team@l(9)
	b .L26
.L28:
	lwz 6,264(31)
	lwz 9,8(27)
	mulli 6,6,13
	lwz 7,400(31)
	mtlr 9
	add 6,6,29
	crxor 6,6,6
	blrl
.L26:
	mr 3,31
	li 4,280
	addi 5,1,8
	bl G_Find
	mr. 31,3
	li 4,2
	la 5,.LC17@l(28)
	mr 3,30
	bc 4,2,.L28
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Cmd_ClanList_f,.Lfe2-Cmd_ClanList_f
	.section	".rodata"
	.align 2
.LC18:
	.string	"\nYour server admin is %s and can be contacted at %s\n"
	.align 2
.LC19:
	.string	"'disable' not finished yet\n"
	.align 2
.LC20:
	.string	"\nServer mode  :"
	.align 2
.LC21:
	.string	"FFA\n"
	.align 2
.LC22:
	.string	"Match\n"
	.align 2
.LC23:
	.string	"Rally\n"
	.align 2
.LC24:
	.string	"counting down to Match\n"
	.align 2
.LC25:
	.string	"Powerups     :"
	.align 2
.LC26:
	.string	"Enabled\n"
	.align 2
.LC27:
	.string	"Disabled\n"
	.align 2
.LC28:
	.string	"Inv off, Quad on\n"
	.align 2
.LC29:
	.string	"Quad off, Inv on\n"
	.align 2
.LC30:
	.string	"Time limit   :%i\n"
	.align 2
.LC31:
	.string	"Frag limit   :%i\n"
	.align 2
.LC32:
	.string	"Drop Quad    :"
	.align 2
.LC33:
	.string	"ON\n"
	.align 2
.LC34:
	.string	"OFF\n"
	.align 2
.LC35:
	.string	"Friendly Fire:"
	.align 2
.LC36:
	.string	"OFF (can't hurt teammates)\n"
	.align 2
.LC37:
	.string	"ON (can hurt teammates)\n"
	.align 2
.LC38:
	.string	"Fast Weap    :"
	.align 2
.LC39:
	.string	"Lockdown     :"
	.align 2
.LC40:
	.string	"ScoreCast    :"
	.align 2
.LC41:
	.string	"Shutup mode  :"
	.align 2
.LC42:
	.string	"Off - all can talk\n"
	.align 2
.LC43:
	.string	"Specs - Spectators are silenced\n"
	.align 2
.LC44:
	.string	"All - only Admins can talk\n"
	.align 2
.LC45:
	.string	"Respawn Prot.:%i secs.\n"
	.align 2
.LC46:
	.string	"FullWeapRally:"
	.align 2
.LC47:
	.string	"\nYou are a Spectator.\n"
	.align 2
.LC48:
	.string	"\nYou are "
	.align 2
.LC49:
	.string	"NOT "
	.align 2
.LC50:
	.string	"an Admin.\n"
	.align 2
.LC51:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_DisplayModMode_f
	.type	 Cmd_DisplayModMode_f,@function
Cmd_DisplayModMode_f:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 31,3
	la 30,gi@l(9)
	lis 5,.LC20@ha
	lwz 9,8(30)
	la 5,.LC20@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,compmod+4@ha
	lwz 0,compmod+4@l(9)
	cmpwi 0,0,0
	bc 4,2,.L33
	lwz 0,8(30)
	lis 5,.LC21@ha
	mr 3,31
	la 5,.LC21@l(5)
	b .L72
.L33:
	cmpwi 0,0,2
	bc 4,2,.L35
	lwz 0,8(30)
	lis 5,.LC22@ha
	mr 3,31
	la 5,.LC22@l(5)
	b .L72
.L35:
	cmpwi 0,0,1
	bc 4,2,.L37
	lwz 0,8(30)
	lis 5,.LC23@ha
	mr 3,31
	la 5,.LC23@l(5)
.L72:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L34
.L37:
	cmpwi 0,0,3
	bc 4,2,.L34
	lwz 0,8(30)
	lis 5,.LC24@ha
	mr 3,31
	la 5,.LC24@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L34:
	lis 9,gi@ha
	lis 5,.LC25@ha
	la 30,gi@l(9)
	la 5,.LC25@l(5)
	lwz 9,8(30)
	mr 3,31
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,compmod@ha
	lwz 0,compmod@l(9)
	cmpwi 0,0,0
	bc 4,2,.L40
	lwz 0,8(30)
	lis 5,.LC26@ha
	mr 3,31
	la 5,.LC26@l(5)
	b .L73
.L40:
	cmpwi 0,0,3
	bc 4,2,.L42
	lwz 0,8(30)
	lis 5,.LC27@ha
	mr 3,31
	la 5,.LC27@l(5)
	b .L73
.L42:
	cmpwi 0,0,2
	bc 4,2,.L44
	lwz 0,8(30)
	lis 5,.LC28@ha
	mr 3,31
	la 5,.LC28@l(5)
.L73:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L41
.L44:
	cmpwi 0,0,1
	bc 4,2,.L41
	lwz 0,8(30)
	lis 5,.LC29@ha
	mr 3,31
	la 5,.LC29@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L41:
	lis 9,compmod@ha
	la 6,compmod@l(9)
	lwz 0,4(6)
	cmpwi 0,0,0
	bc 4,2,.L47
	lis 11,timelimit@ha
	lwz 9,timelimit@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 6,20(1)
	b .L48
.L47:
	lwz 6,16(6)
.L48:
	lis 9,gi+8@ha
	lis 5,.LC30@ha
	lwz 0,gi+8@l(9)
	la 5,.LC30@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,compmod@ha
	la 6,compmod@l(9)
	lwz 0,4(6)
	cmpwi 0,0,0
	bc 4,2,.L49
	lis 11,fraglimit@ha
	lwz 9,fraglimit@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 6,20(1)
	b .L50
.L49:
	lwz 6,20(6)
.L50:
	lis 9,gi@ha
	lis 5,.LC31@ha
	la 30,gi@l(9)
	la 5,.LC31@l(5)
	lwz 9,8(30)
	mr 3,31
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC32@ha
	mr 3,31
	la 5,.LC32@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,16384
	bc 12,2,.L51
	lwz 0,8(30)
	lis 5,.LC33@ha
	mr 3,31
	la 5,.LC33@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L52
.L51:
	lwz 0,8(30)
	lis 5,.LC34@ha
	mr 3,31
	la 5,.LC34@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L52:
	lis 9,gi@ha
	lis 5,.LC35@ha
	la 30,gi@l(9)
	la 5,.LC35@l(5)
	lwz 9,8(30)
	mr 3,31
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,256
	bc 12,2,.L53
	lwz 0,8(30)
	lis 5,.LC36@ha
	mr 3,31
	la 5,.LC36@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L54
.L53:
	lwz 0,8(30)
	lis 5,.LC37@ha
	mr 3,31
	la 5,.LC37@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L54:
	lis 9,gi@ha
	lis 5,.LC38@ha
	la 30,gi@l(9)
	la 5,.LC38@l(5)
	lwz 9,8(30)
	mr 3,31
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,.LC51@ha
	lis 11,fastweap@ha
	la 9,.LC51@l(9)
	lfs 13,0(9)
	lwz 9,fastweap@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L55
	lwz 0,8(30)
	lis 5,.LC33@ha
	mr 3,31
	la 5,.LC33@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L56
.L55:
	lwz 0,8(30)
	lis 5,.LC34@ha
	mr 3,31
	la 5,.LC34@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L56:
	lis 9,gi@ha
	lis 5,.LC39@ha
	la 30,gi@l(9)
	la 5,.LC39@l(5)
	lwz 9,8(30)
	mr 3,31
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,compmod+12@ha
	lwz 0,compmod+12@l(9)
	cmpwi 0,0,0
	bc 12,2,.L57
	lwz 0,8(30)
	lis 5,.LC33@ha
	mr 3,31
	la 5,.LC33@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L58
.L57:
	lwz 0,8(30)
	lis 5,.LC34@ha
	mr 3,31
	la 5,.LC34@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L58:
	lis 9,gi@ha
	lis 5,.LC40@ha
	la 30,gi@l(9)
	la 5,.LC40@l(5)
	lwz 9,8(30)
	mr 3,31
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,.LC51@ha
	lis 11,scorecast@ha
	la 9,.LC51@l(9)
	lfs 13,0(9)
	lwz 9,scorecast@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L59
	lwz 0,8(30)
	lis 5,.LC33@ha
	mr 3,31
	la 5,.LC33@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L60
.L59:
	lwz 0,8(30)
	lis 5,.LC34@ha
	mr 3,31
	la 5,.LC34@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L60:
	lis 9,gi@ha
	lis 5,.LC41@ha
	la 30,gi@l(9)
	la 5,.LC41@l(5)
	lwz 9,8(30)
	mr 3,31
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,compmod+8@ha
	lwz 0,compmod+8@l(9)
	cmpwi 0,0,0
	bc 4,2,.L61
	lwz 0,8(30)
	lis 5,.LC42@ha
	mr 3,31
	la 5,.LC42@l(5)
	b .L74
.L61:
	cmpwi 0,0,1
	bc 4,2,.L63
	lwz 0,8(30)
	lis 5,.LC43@ha
	mr 3,31
	la 5,.LC43@l(5)
.L74:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L62
.L63:
	cmpwi 0,0,2
	bc 4,2,.L62
	lwz 0,8(30)
	lis 5,.LC44@ha
	mr 3,31
	la 5,.LC44@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L62:
	lis 11,protect@ha
	lis 9,gi@ha
	lwz 10,protect@l(11)
	la 30,gi@l(9)
	lwz 9,8(30)
	lis 5,.LC45@ha
	mr 3,31
	lfs 0,20(10)
	la 5,.LC45@l(5)
	li 4,2
	mtlr 9
	fctiwz 13,0
	stfd 13,16(1)
	lwz 6,20(1)
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC46@ha
	mr 3,31
	la 5,.LC46@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,.LC51@ha
	lis 11,fullweaprally@ha
	la 9,.LC51@l(9)
	lfs 13,0(9)
	lwz 9,fullweaprally@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L66
	lwz 0,8(30)
	lis 5,.LC33@ha
	mr 3,31
	la 5,.LC33@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L67
.L66:
	lwz 0,8(30)
	lis 5,.LC34@ha
	mr 3,31
	la 5,.LC34@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L67:
	cmpwi 0,31,0
	bc 12,2,.L70
	lwz 9,84(31)
	lwz 0,3472(9)
	cmpwi 0,0,-1
	bc 4,2,.L68
	lis 9,gi+8@ha
	lis 5,.LC47@ha
	lwz 0,gi+8@l(9)
	la 5,.LC47@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L68:
	lis 9,gi@ha
	lis 5,.LC48@ha
	la 30,gi@l(9)
	la 5,.LC48@l(5)
	lwz 9,8(30)
	mr 3,31
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 4,2,.L71
	lwz 9,8(30)
	lis 5,.LC49@ha
	mr 3,31
	la 5,.LC49@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L71:
	lwz 0,8(30)
	lis 5,.LC50@ha
	mr 3,31
	la 5,.LC50@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L70:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 Cmd_DisplayModMode_f,.Lfe3-Cmd_DisplayModMode_f
	.section	".rodata"
	.align 2
.LC52:
	.string	"Server running Quake 2\n"
	.align 2
.LC53:
	.string	"Competition Mod (Q2Comp) 0.30 beta\n"
	.align 2
.LC54:
	.string	"Author: CrushBug\n"
	.align 2
.LC55:
	.string	"E-mail: crushbug@telefragged.com\n\n"
	.align 2
.LC56:
	.string	"on"
	.align 2
.LC57:
	.string	"dmflags"
	.align 2
.LC58:
	.string	"%i"
	.align 2
.LC59:
	.string	"off"
	.align 2
.LC60:
	.string	"\nTo change Drop Quad, use the command:\n"
	.align 2
.LC61:
	.string	"'dropquad <opt>'\n"
	.align 2
.LC62:
	.string	"<opt> = 'on'      - Drop Quad on\n"
	.align 2
.LC63:
	.string	"        'off'     - Drop Quad off\n"
	.align 2
.LC64:
	.string	"\nDrop Quad is "
	.section	".text"
	.align 2
	.globl Cmd_DropQuad_f
	.type	 Cmd_DropQuad_f,@function
Cmd_DropQuad_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	bl MatchInProgress
	cmpwi 0,3,0
	bc 4,2,.L78
	mr 3,31
	bl NotAnAdmin
	cmpwi 0,3,0
	bc 4,2,.L78
	lis 11,dmflags@ha
	lis 9,gi@ha
	lwz 10,dmflags@l(11)
	la 30,gi@l(9)
	li 3,1
	lwz 11,160(30)
	lis 28,gi@ha
	lfs 0,20(10)
	mtlr 11
	fctiwz 13,0
	stfd 13,8(1)
	lwz 29,12(1)
	blrl
	lis 4,.LC56@ha
	la 4,.LC56@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L81
	lis 3,.LC58@ha
	ori 4,29,16384
	la 3,.LC58@l(3)
	crxor 6,6,6
	bl va
	mr 4,3
	lwz 0,148(30)
	lis 3,.LC57@ha
	la 3,.LC57@l(3)
	mtlr 0
	blrl
	b .L82
.L81:
	lwz 9,160(30)
	li 3,1
	mtlr 9
	blrl
	lis 4,.LC59@ha
	la 4,.LC59@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L83
	lwz 9,8(30)
	lis 5,.LC60@ha
	mr 3,31
	la 5,.LC60@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC61@ha
	mr 3,31
	la 5,.LC61@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC62@ha
	mr 3,31
	la 5,.LC62@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(30)
	lis 5,.LC63@ha
	mr 3,31
	la 5,.LC63@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L78
.L83:
	lis 3,.LC58@ha
	rlwinm 4,29,0,18,16
	la 3,.LC58@l(3)
	crxor 6,6,6
	bl va
	mr 4,3
	lwz 0,148(30)
	lis 3,.LC57@ha
	la 3,.LC57@l(3)
	mtlr 0
	blrl
.L82:
	lis 9,gi@ha
	lis 4,.LC64@ha
	lwz 0,gi@l(9)
	la 4,.LC64@l(4)
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,16384
	bc 12,2,.L85
	lwz 0,gi@l(28)
	lis 4,.LC33@ha
	li 3,1
	la 4,.LC33@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L78
.L85:
	lwz 0,gi@l(28)
	lis 4,.LC34@ha
	li 3,1
	la 4,.LC34@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L78:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 Cmd_DropQuad_f,.Lfe4-Cmd_DropQuad_f
	.section	".rodata"
	.align 2
.LC65:
	.string	"\nElections have been disabled by the server administrator.\n"
	.align 2
.LC66:
	.string	"%s is now an Admin.\n"
	.align 2
.LC67:
	.string	"\nVote already in progress.\n"
	.align 2
.LC68:
	.string	"vote"
	.align 2
.LC69:
	.long 0x0
	.align 2
.LC70:
	.long 0x41700000
	.section	".text"
	.align 2
	.globl Cmd_Elect_f
	.type	 Cmd_Elect_f,@function
Cmd_Elect_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 4,2,.L87
	lis 9,.LC69@ha
	lis 11,noelect@ha
	la 9,.LC69@l(9)
	lfs 13,0(9)
	lwz 9,noelect@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L89
	lis 9,gi+8@ha
	lis 5,.LC65@ha
	lwz 0,gi+8@l(9)
	la 5,.LC65@l(5)
	b .L92
.L89:
	li 3,0
	bl PlayerCount
	mr 0,3
	cmpwi 0,0,1
	bc 4,2,.L90
	lwz 9,84(31)
	lis 11,gi@ha
	lis 4,.LC66@ha
	la 4,.LC66@l(4)
	li 3,2
	stw 0,3456(9)
	lwz 5,84(31)
	lwz 0,gi@l(11)
	addi 5,5,700
	b .L93
.L90:
	bl FindVote
	mr. 30,3
	bc 12,2,.L91
	lis 9,gi+8@ha
	lis 5,.LC67@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC67@l(5)
.L92:
	li 4,2
.L93:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L87
.L91:
	bl G_Spawn
	lis 9,.LC68@ha
	mr 11,3
	la 9,.LC68@l(9)
	li 0,2
	stw 30,480(11)
	stw 9,280(11)
	lis 8,level+4@ha
	lis 10,VoteThink@ha
	lis 9,.LC70@ha
	stw 0,264(11)
	la 10,VoteThink@l(10)
	la 9,.LC70@l(9)
	stw 30,400(11)
	mr 3,31
	lfs 13,0(9)
	li 4,1
	lwz 9,84(31)
	addi 9,9,700
	stw 9,296(11)
	lfs 0,level+4@l(8)
	stw 10,436(11)
	fadds 0,0,13
	stfs 0,428(11)
	bl Cmd_Vote_f
.L87:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_Elect_f,.Lfe5-Cmd_Elect_f
	.section	".rodata"
	.align 2
.LC71:
	.string	"\nTo change Friendly Fire, use the command:\n"
	.align 2
.LC72:
	.string	"'ff <opt>'\n"
	.align 2
.LC73:
	.string	"<opt> = 'on'  - Friendly Fire on\n"
	.align 2
.LC74:
	.string	"        'off' - Friendly Fire off\n"
	.align 2
.LC75:
	.string	"\nFriendly Fire is "
	.section	".text"
	.align 2
	.globl Cmd_FriendlyFire_f
	.type	 Cmd_FriendlyFire_f,@function
Cmd_FriendlyFire_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	bl MatchInProgress
	cmpwi 0,3,0
	bc 4,2,.L99
	mr 3,31
	bl NotAnAdmin
	cmpwi 0,3,0
	bc 4,2,.L99
	lis 11,dmflags@ha
	lis 9,gi@ha
	lwz 10,dmflags@l(11)
	la 30,gi@l(9)
	li 3,1
	lwz 11,160(30)
	lis 28,gi@ha
	lfs 0,20(10)
	mtlr 11
	fctiwz 13,0
	stfd 13,8(1)
	lwz 29,12(1)
	blrl
	lis 4,.LC59@ha
	la 4,.LC59@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L102
	lis 3,.LC58@ha
	ori 4,29,256
	la 3,.LC58@l(3)
	crxor 6,6,6
	bl va
	mr 4,3
	lwz 0,148(30)
	lis 3,.LC57@ha
	la 3,.LC57@l(3)
	mtlr 0
	blrl
	b .L103
.L102:
	lwz 9,160(30)
	li 3,1
	mtlr 9
	blrl
	lis 4,.LC56@ha
	la 4,.LC56@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L104
	lwz 9,8(30)
	lis 5,.LC71@ha
	mr 3,31
	la 5,.LC71@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC72@ha
	mr 3,31
	la 5,.LC72@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC73@ha
	mr 3,31
	la 5,.LC73@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(30)
	lis 5,.LC74@ha
	mr 3,31
	la 5,.LC74@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L99
.L104:
	lis 3,.LC58@ha
	rlwinm 4,29,0,24,22
	la 3,.LC58@l(3)
	crxor 6,6,6
	bl va
	mr 4,3
	lwz 0,148(30)
	lis 3,.LC57@ha
	la 3,.LC57@l(3)
	mtlr 0
	blrl
.L103:
	lis 9,gi@ha
	lis 4,.LC75@ha
	lwz 0,gi@l(9)
	la 4,.LC75@l(4)
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 0,11,256
	bc 12,2,.L106
	lwz 0,gi@l(28)
	lis 4,.LC36@ha
	li 3,1
	la 4,.LC36@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L99
.L106:
	lwz 0,gi@l(28)
	lis 4,.LC37@ha
	li 3,1
	la 4,.LC37@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L99:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 Cmd_FriendlyFire_f,.Lfe6-Cmd_FriendlyFire_f
	.section	".rodata"
	.align 2
.LC76:
	.string	"\nLockdown has been disabled by the server administrator.\n"
	.align 2
.LC77:
	.string	"\nTo change the server Lockdown, use the command:\n"
	.align 2
.LC78:
	.string	"'"
	.align 2
.LC79:
	.string	"sv "
	.align 2
.LC80:
	.string	"'lockdown <opt>'\n"
	.align 2
.LC81:
	.string	"<opt> = 'on'      - Lockdown ON\n"
	.align 2
.LC82:
	.string	"        'off'     - Lockdown OFF\n"
	.align 2
.LC83:
	.string	"\nServer Lockdown is:"
	.align 2
.LC84:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Lockdown_f
	.type	 Cmd_Lockdown_f,@function
Cmd_Lockdown_f:
	stwu 1,-32(1)
	mflr 0
	mfcr 12
	stmw 29,20(1)
	stw 0,36(1)
	stw 12,16(1)
	mr 31,3
	bl MatchInProgress
	cmpwi 0,3,0
	bc 4,2,.L108
	mr 3,31
	bl NotAnAdmin
	cmpwi 0,3,0
	bc 4,2,.L108
	lis 9,.LC84@ha
	lis 11,nolockdown@ha
	la 9,.LC84@l(9)
	lfs 13,0(9)
	lwz 9,nolockdown@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L111
	lis 9,gi+8@ha
	lis 5,.LC76@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC76@l(5)
	b .L120
.L111:
	srawi 0,31,31
	lis 11,gi@ha
	xor 9,0,31
	la 29,gi@l(11)
	subf 9,9,0
	lwz 10,160(29)
	cmpwi 4,31,0
	srawi 9,9,31
	nor 0,9,9
	mtlr 10
	rlwinm 9,9,0,31,31
	rlwinm 0,0,0,30,30
	or 30,9,0
	mr 3,30
	blrl
	lis 4,.LC56@ha
	la 4,.LC56@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L113
	lis 9,compmod+12@ha
	li 0,1
	stw 0,compmod+12@l(9)
	b .L114
.L113:
	lwz 9,160(29)
	mr 3,30
	mtlr 9
	blrl
	lis 4,.LC59@ha
	la 4,.LC59@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L115
	lis 9,compmod+12@ha
	stw 3,compmod+12@l(9)
	b .L114
.L115:
	lwz 9,8(29)
	lis 5,.LC77@ha
	mr 3,31
	la 5,.LC77@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC78@ha
	mr 3,31
	la 5,.LC78@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	bc 4,18,.L117
	lwz 9,8(29)
	lis 5,.LC79@ha
	li 3,0
	la 5,.LC79@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L117:
	lwz 9,8(29)
	lis 5,.LC80@ha
	mr 3,31
	la 5,.LC80@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC81@ha
	mr 3,31
	la 5,.LC81@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC82@ha
	mr 3,31
	la 5,.LC82@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L114:
	lis 9,gi@ha
	lis 5,.LC83@ha
	la 30,gi@l(9)
	la 5,.LC83@l(5)
	lwz 9,8(30)
	mr 3,31
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,compmod+12@ha
	lwz 0,compmod+12@l(9)
	cmpwi 0,0,0
	bc 4,2,.L118
	lwz 0,8(30)
	lis 5,.LC34@ha
	mr 3,31
	la 5,.LC34@l(5)
.L120:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L108
.L118:
	lwz 0,8(30)
	lis 5,.LC33@ha
	mr 3,31
	la 5,.LC33@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L108:
	lwz 0,36(1)
	lwz 12,16(1)
	mtlr 0
	lmw 29,20(1)
	mtcrf 8,12
	la 1,32(1)
	blr
.Lfe7:
	.size	 Cmd_Lockdown_f,.Lfe7-Cmd_Lockdown_f
	.section	".rodata"
	.align 2
.LC85:
	.string	"\nMatch fraglimit setting is only valid in Match mode.\n"
	.align 2
.LC86:
	.string	"\nTo set the Match Fraglimit, use:\n"
	.align 2
.LC87:
	.string	"matchfragset <n>' - where <n> is the Fraglimit.\n"
	.align 2
.LC88:
	.string	"0 means no Fraglimit.\n"
	.align 2
.LC89:
	.string	"\nMatch lower Fraglimit is 0 - no Fraglimit.\n"
	.align 2
.LC90:
	.string	"\nMatch upper Fraglimit is 200.\n"
	.align 2
.LC91:
	.string	"\nMatch Fraglimit is %i\n"
	.section	".text"
	.align 2
	.globl Cmd_MatchFragSet_f
	.type	 Cmd_MatchFragSet_f,@function
Cmd_MatchFragSet_f:
	stwu 1,-32(1)
	mflr 0
	mfcr 12
	stmw 27,12(1)
	stw 0,36(1)
	stw 12,8(1)
	lis 9,compmod@ha
	mr 31,3
	la 28,compmod@l(9)
	lwz 0,4(28)
	cmpwi 0,0,0
	bc 4,2,.L122
	lis 9,gi+8@ha
	lis 5,.LC85@ha
	lwz 0,gi+8@l(9)
	la 5,.LC85@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L121
.L122:
	mr 3,31
	bl MatchInProgress
	cmpwi 0,3,0
	bc 4,2,.L121
	mr 3,31
	bl NotAnAdmin
	mr. 27,3
	bc 4,2,.L121
	srawi 0,31,31
	lis 11,gi@ha
	xor 9,0,31
	la 29,gi@l(11)
	subf 9,9,0
	lwz 10,160(29)
	cmpwi 4,31,0
	srawi 9,9,31
	nor 0,9,9
	mtlr 10
	rlwinm 9,9,0,31,31
	rlwinm 0,0,0,30,30
	or 30,9,0
	mr 3,30
	blrl
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L126
	lwz 9,8(29)
	lis 5,.LC86@ha
	mr 3,31
	la 5,.LC86@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC78@ha
	mr 3,31
	la 5,.LC78@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	bc 4,18,.L127
	lwz 9,8(29)
	lis 5,.LC79@ha
	li 3,0
	la 5,.LC79@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
.L127:
	lwz 9,8(29)
	lis 5,.LC87@ha
	mr 3,31
	la 5,.LC87@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC88@ha
	mr 3,31
	la 5,.LC88@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L128
.L126:
	lwz 9,160(29)
	mr 3,30
	mtlr 9
	blrl
	bl atoi
	cmpwi 0,3,0
	stw 3,20(28)
	bc 4,0,.L129
	lwz 9,8(29)
	lis 5,.LC89@ha
	mr 3,31
	stw 27,20(28)
	la 5,.LC89@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
.L129:
	lwz 0,20(28)
	cmpwi 0,0,200
	bc 4,1,.L128
	lwz 9,8(29)
	lis 5,.LC90@ha
	mr 3,31
	la 5,.LC90@l(5)
	li 4,1
	mtlr 9
	li 0,200
	stw 0,20(28)
	crxor 6,6,6
	blrl
.L128:
	lis 9,gi@ha
	lis 11,compmod+20@ha
	lwz 0,gi@l(9)
	lis 4,.LC91@ha
	li 3,1
	la 4,.LC91@l(4)
	lwz 5,compmod+20@l(11)
	mtlr 0
	crxor 6,6,6
	blrl
.L121:
	lwz 0,36(1)
	lwz 12,8(1)
	mtlr 0
	lmw 27,12(1)
	mtcrf 8,12
	la 1,32(1)
	blr
.Lfe8:
	.size	 Cmd_MatchFragSet_f,.Lfe8-Cmd_MatchFragSet_f
	.section	".rodata"
	.align 2
.LC92:
	.string	"\nMatch time setting is only valid in Match mode.\n"
	.align 2
.LC93:
	.string	"\nTo set the Match Timelimit, use:\n"
	.align 2
.LC94:
	.string	"matchtime <time>' - where <time> is the time in minutes.\n"
	.align 2
.LC95:
	.string	"\nMatch lower limit is 2 minutes.\n"
	.align 2
.LC96:
	.string	"\nMatch upper limit is 60 minutes.\n"
	.align 2
.LC97:
	.string	"\nMatch Timelimit is %i minutes.\n"
	.section	".text"
	.align 2
	.globl Cmd_MatchTimeSet_f
	.type	 Cmd_MatchTimeSet_f,@function
Cmd_MatchTimeSet_f:
	stwu 1,-32(1)
	mflr 0
	mfcr 12
	stmw 28,16(1)
	stw 0,36(1)
	stw 12,12(1)
	lis 9,compmod@ha
	mr 31,3
	la 28,compmod@l(9)
	lwz 0,4(28)
	cmpwi 0,0,0
	bc 4,2,.L132
	lis 9,gi+8@ha
	lis 5,.LC92@ha
	lwz 0,gi+8@l(9)
	la 5,.LC92@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L131
.L132:
	mr 3,31
	bl MatchInProgress
	cmpwi 0,3,0
	bc 4,2,.L131
	mr 3,31
	bl NotAnAdmin
	cmpwi 0,3,0
	bc 4,2,.L131
	srawi 0,31,31
	lis 11,gi@ha
	xor 9,0,31
	la 29,gi@l(11)
	subf 9,9,0
	lwz 10,160(29)
	cmpwi 4,31,0
	srawi 9,9,31
	nor 0,9,9
	mtlr 10
	rlwinm 9,9,0,31,31
	rlwinm 0,0,0,30,30
	or 30,9,0
	mr 3,30
	blrl
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L136
	lwz 9,8(29)
	lis 5,.LC93@ha
	mr 3,31
	la 5,.LC93@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC78@ha
	mr 3,31
	la 5,.LC78@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	bc 4,18,.L137
	lwz 9,8(29)
	lis 5,.LC79@ha
	li 3,0
	la 5,.LC79@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
.L137:
	lwz 0,8(29)
	lis 5,.LC94@ha
	mr 3,31
	la 5,.LC94@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L138
.L136:
	lwz 9,160(29)
	mr 3,30
	mtlr 9
	blrl
	bl atoi
	cmpwi 0,3,1
	stw 3,16(28)
	bc 12,1,.L139
	lwz 9,8(29)
	lis 5,.LC95@ha
	li 0,2
	stw 0,16(28)
	mr 3,31
	la 5,.LC95@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
.L139:
	lwz 0,16(28)
	cmpwi 0,0,60
	bc 4,1,.L138
	lwz 9,8(29)
	lis 5,.LC96@ha
	mr 3,31
	la 5,.LC96@l(5)
	li 4,1
	mtlr 9
	li 0,60
	stw 0,16(28)
	crxor 6,6,6
	blrl
.L138:
	lis 9,gi@ha
	lis 11,compmod+16@ha
	lwz 0,gi@l(9)
	lis 4,.LC97@ha
	li 3,1
	la 4,.LC97@l(4)
	lwz 5,compmod+16@l(11)
	mtlr 0
	crxor 6,6,6
	blrl
.L131:
	lwz 0,36(1)
	lwz 12,12(1)
	mtlr 0
	lmw 28,16(1)
	mtcrf 8,12
	la 1,32(1)
	blr
.Lfe9:
	.size	 Cmd_MatchTimeSet_f,.Lfe9-Cmd_MatchTimeSet_f
	.section	".rodata"
	.align 2
.LC98:
	.string	"\nSomething is wacked - Q2Comp Mode is not 0-3, its %i\n"
	.align 2
.LC99:
	.string	"\n%s is no longer an Admin.\n"
	.align 2
.LC100:
	.string	"\nToo late! Match in Progress.\n"
	.align 2
.LC101:
	.string	"\n'notready' is only valid in Match mode.\n"
	.align 2
.LC102:
	.string	"\nYou are a Spectator, you cannot change your status.\n"
	.align 2
.LC103:
	.string	"\n%s's status is Not Ready.\n"
	.lcomm	skin.60,512,4
	.align 2
.LC104:
	.string	"\n'playerlist' command is only valid in Match mode.\n"
	.align 2
.LC105:
	.string	"\nPlayer           Status    Team       Skin\n"
	.align 2
.LC106:
	.string	"=====================================================\n"
	.align 2
.LC107:
	.string	"player"
	.align 2
.LC108:
	.string	"%-16s "
	.align 2
.LC109:
	.string	"Ready     "
	.align 2
.LC110:
	.string	"Not Ready "
	.align 2
.LC111:
	.string	"SPECTATOR  "
	.align 2
.LC112:
	.string	"%-10s "
	.align 2
.LC113:
	.string	"skin"
	.align 2
.LC114:
	.string	"%-15s\n"
	.section	".text"
	.align 2
	.globl Cmd_PlayerList_f
	.type	 Cmd_PlayerList_f,@function
Cmd_PlayerList_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,compmod+4@ha
	mr 31,3
	lwz 0,compmod+4@l(9)
	li 30,0
	cmpwi 0,0,0
	bc 4,2,.L158
	lis 9,gi+8@ha
	lis 5,.LC104@ha
	lwz 0,gi+8@l(9)
	la 5,.LC104@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L157
.L158:
	lis 29,gi@ha
	lis 5,.LC105@ha
	la 29,gi@l(29)
	la 5,.LC105@l(5)
	lwz 9,8(29)
	mr 3,31
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC106@ha
	mr 3,31
	la 5,.LC106@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L159
.L161:
	lis 9,gi@ha
	lwz 6,84(30)
	lis 5,.LC108@ha
	la 29,gi@l(9)
	la 5,.LC108@l(5)
	lwz 9,8(29)
	addi 6,6,700
	mr 3,31
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(30)
	lwz 0,3464(9)
	cmpwi 0,0,0
	bc 12,2,.L162
	lwz 0,8(29)
	lis 5,.LC109@ha
	mr 3,31
	la 5,.LC109@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L163
.L162:
	lwz 0,8(29)
	lis 5,.LC110@ha
	mr 3,31
	la 5,.LC110@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
.L163:
	lwz 9,84(30)
	lwz 0,3472(9)
	cmpwi 0,0,-1
	bc 4,2,.L164
	lis 9,gi+8@ha
	lis 5,.LC111@ha
	lwz 0,gi+8@l(9)
	la 5,.LC111@l(5)
	mr 3,31
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L165
.L164:
	lis 9,gi+8@ha
	mulli 0,0,13
	lis 6,team@ha
	lwz 9,gi+8@l(9)
	la 6,team@l(6)
	lis 5,.LC112@ha
	add 6,0,6
	la 5,.LC112@l(5)
	mr 3,31
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
.L165:
	lwz 3,84(30)
	lis 4,.LC113@ha
	lis 29,skin.60@ha
	la 4,.LC113@l(4)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	la 3,skin.60@l(29)
	bl strcpy
	lis 9,gi+8@ha
	lis 5,.LC114@ha
	lwz 0,gi+8@l(9)
	la 5,.LC114@l(5)
	la 6,skin.60@l(29)
	mr 3,31
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
.L159:
	lis 5,.LC107@ha
	mr 3,30
	la 5,.LC107@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L161
.L157:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 Cmd_PlayerList_f,.Lfe10-Cmd_PlayerList_f
	.section	".rodata"
	.align 2
.LC115:
	.string	"Powerups are now enabled.\n"
	.align 2
.LC116:
	.string	"Powerups are now disabled.\n"
	.align 2
.LC117:
	.string	"invoff"
	.align 2
.LC118:
	.string	"Powerups - Invunerability is now disabled.\n"
	.align 2
.LC119:
	.string	"quadoff"
	.align 2
.LC120:
	.string	"Powerups - Quad is now disabled.\n"
	.align 2
.LC121:
	.string	"\nTo change the powerups, use the command:\n"
	.align 2
.LC122:
	.string	"powerups <opt>'\n"
	.align 2
.LC123:
	.string	"<opt> = 'on'      - all on\n"
	.align 2
.LC124:
	.string	"        'off'     - all off\n"
	.align 2
.LC125:
	.string	"        'invoff'  - no Invulnerability\n"
	.align 2
.LC126:
	.string	"        'quadoff' - no Quad\n"
	.align 2
.LC127:
	.string	"Restart level to take effect.\n"
	.section	".text"
	.align 2
	.globl Cmd_Powerups_f
	.type	 Cmd_Powerups_f,@function
Cmd_Powerups_f:
	stwu 1,-32(1)
	mflr 0
	mfcr 12
	stmw 28,16(1)
	stw 0,36(1)
	stw 12,12(1)
	mr 31,3
	bl MatchInProgress
	cmpwi 0,3,0
	bc 4,2,.L167
	mr 3,31
	bl NotAnAdmin
	cmpwi 0,3,0
	bc 4,2,.L167
	srawi 0,31,31
	lis 11,gi@ha
	xor 9,0,31
	la 30,gi@l(11)
	subf 9,9,0
	lwz 10,160(30)
	cmpwi 4,31,0
	srawi 9,9,31
	nor 0,9,9
	mtlr 10
	rlwinm 9,9,0,31,31
	rlwinm 0,0,0,30,30
	or 29,9,0
	mr 3,29
	blrl
	lis 4,.LC56@ha
	la 4,.LC56@l(4)
	bl Q_stricmp
	mr. 28,3
	bc 4,2,.L171
	lwz 0,8(30)
	lis 5,.LC115@ha
	mr 3,31
	li 4,2
	la 5,.LC115@l(5)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,compmod@ha
	li 3,1
	stw 28,compmod@l(9)
	b .L180
.L171:
	lwz 9,160(30)
	mr 3,29
	mtlr 9
	blrl
	lis 4,.LC59@ha
	la 4,.LC59@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L173
	lwz 0,8(30)
	lis 5,.LC116@ha
	mr 3,31
	li 4,2
	la 5,.LC116@l(5)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,compmod@ha
	li 0,3
	stw 0,compmod@l(9)
	li 3,0
.L180:
	li 4,3
	bl DisableFlagSet
	b .L172
.L173:
	lwz 9,160(30)
	mr 3,29
	mtlr 9
	blrl
	lis 4,.LC117@ha
	la 4,.LC117@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L175
	lwz 0,8(30)
	lis 5,.LC118@ha
	mr 3,31
	li 4,2
	la 5,.LC118@l(5)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,compmod@ha
	li 0,2
	li 3,0
	stw 0,compmod@l(9)
	li 4,2
	bl DisableFlagSet
	b .L172
.L175:
	lwz 9,160(30)
	mr 3,29
	mtlr 9
	blrl
	lis 4,.LC119@ha
	la 4,.LC119@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L177
	lwz 0,8(30)
	lis 5,.LC120@ha
	mr 3,31
	li 4,2
	la 5,.LC120@l(5)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,compmod@ha
	li 0,1
	stw 0,compmod@l(9)
	li 3,0
	li 4,1
	bl DisableFlagSet
	b .L172
.L177:
	lwz 9,8(30)
	lis 5,.LC121@ha
	mr 3,31
	la 5,.LC121@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC78@ha
	mr 3,31
	la 5,.LC78@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	bc 4,18,.L179
	lwz 9,8(30)
	lis 5,.LC79@ha
	li 3,0
	la 5,.LC79@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L179:
	lwz 9,8(30)
	lis 5,.LC122@ha
	mr 3,31
	la 5,.LC122@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC123@ha
	mr 3,31
	la 5,.LC123@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC124@ha
	mr 3,31
	la 5,.LC124@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC125@ha
	mr 3,31
	la 5,.LC125@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(30)
	lis 5,.LC126@ha
	mr 3,31
	la 5,.LC126@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L167
.L172:
	lis 9,gi+8@ha
	lis 5,.LC127@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC127@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L167:
	lwz 0,36(1)
	lwz 12,12(1)
	mtlr 0
	lmw 28,16(1)
	mtcrf 8,12
	la 1,32(1)
	blr
.Lfe11:
	.size	 Cmd_Powerups_f,.Lfe11-Cmd_Powerups_f
	.section	".rodata"
	.align 2
.LC128:
	.string	"'ready' is only valid in Match mode.\n"
	.align 2
.LC129:
	.string	"\nYou are already 'ready'.\nType 'notready' at the console to change your status.\n"
	.align 2
.LC130:
	.string	"\nYou have not selected a team.\nSelect a team using 'team <name>'\n"
	.align 2
.LC131:
	.string	"\nClan '%s' created.\n"
	.align 2
.LC132:
	.string	"\n%s set to Clan '%s'\n"
	.section	".text"
	.align 2
	.globl Cmd_Ready_f
	.type	 Cmd_Ready_f,@function
Cmd_Ready_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,3
	bl MatchInProgress
	cmpwi 0,3,0
	bc 4,2,.L181
	lis 9,compmod+4@ha
	lwz 0,compmod+4@l(9)
	cmpwi 0,0,0
	bc 4,2,.L183
	lis 9,gi+8@ha
	lis 5,.LC128@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC128@l(5)
	b .L190
.L183:
	lwz 9,84(30)
	lwz 11,3472(9)
	cmpwi 0,11,-1
	bc 4,2,.L184
	lis 9,gi+8@ha
	lis 5,.LC102@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC102@l(5)
	b .L190
.L184:
	lwz 0,3464(9)
	cmpwi 0,0,1
	bc 4,2,.L185
	lis 9,gi+8@ha
	lis 5,.LC129@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC129@l(5)
	b .L190
.L185:
	cmpwi 0,11,0
	bc 4,2,.L187
	lis 9,gi+8@ha
	lis 5,.LC130@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC130@l(5)
.L190:
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L181
.L187:
	li 0,1
	stw 0,3464(9)
	lwz 9,84(30)
	lwz 3,3472(9)
	bl FindClan
	mr. 31,3
	bc 4,2,.L189
	lwz 9,84(30)
	lwz 3,3472(9)
	bl MakeClan
	mr 31,3
	lis 9,gi@ha
	lwz 5,264(31)
	lis 11,team@ha
	lis 4,.LC131@ha
	lwz 0,gi@l(9)
	la 11,team@l(11)
	li 3,2
	mulli 5,5,13
	la 4,.LC131@l(4)
	mtlr 0
	add 5,5,11
	crxor 6,6,6
	blrl
.L189:
	lwz 9,400(31)
	lis 10,gi@ha
	lis 11,team@ha
	lwz 6,264(31)
	la 11,team@l(11)
	lis 4,.LC132@ha
	addi 9,9,1
	la 4,.LC132@l(4)
	stw 9,400(31)
	mulli 6,6,13
	li 3,2
	lwz 5,84(30)
	lwz 0,gi@l(10)
	add 6,6,11
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L181:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 Cmd_Ready_f,.Lfe12-Cmd_Ready_f
	.section	".rodata"
	.align 2
.LC133:
	.string	"all"
	.align 2
.LC134:
	.string	"All but Admins are silenced.\n"
	.align 2
.LC135:
	.string	"specs"
	.align 2
.LC136:
	.string	"Spectators are silenced.\n"
	.align 2
.LC137:
	.string	"All are allowed to talk.\n"
	.align 2
.LC138:
	.string	"\nTo disable spectator or player talking, use the command:\n"
	.align 2
.LC139:
	.string	"shutup <opt>'\n"
	.align 2
.LC140:
	.string	"<opt> = 'all'   - all but Admins are silenced\n"
	.align 2
.LC141:
	.string	"        'specs' - Spectators are silenced\n"
	.align 2
.LC142:
	.string	"        'off'   - all can talk\n"
	.section	".text"
	.align 2
	.globl Cmd_ShutUp_f
	.type	 Cmd_ShutUp_f,@function
Cmd_ShutUp_f:
	stwu 1,-32(1)
	mflr 0
	mfcr 12
	stmw 29,20(1)
	stw 0,36(1)
	stw 12,16(1)
	mr 31,3
	bl MatchInProgress
	cmpwi 0,3,0
	bc 4,2,.L194
	mr 3,31
	bl NotAnAdmin
	cmpwi 0,3,0
	bc 4,2,.L194
	srawi 0,31,31
	lis 11,gi@ha
	xor 9,0,31
	la 29,gi@l(11)
	subf 9,9,0
	lwz 10,160(29)
	cmpwi 4,31,0
	srawi 9,9,31
	nor 0,9,9
	mtlr 10
	rlwinm 9,9,0,31,31
	rlwinm 0,0,0,30,30
	or 30,9,0
	mr 3,30
	blrl
	lis 4,.LC133@ha
	la 4,.LC133@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L198
	lwz 0,8(29)
	lis 5,.LC134@ha
	mr 3,31
	la 5,.LC134@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,compmod+8@ha
	li 0,2
	stw 0,compmod+8@l(9)
	b .L194
.L198:
	lwz 9,160(29)
	mr 3,30
	mtlr 9
	blrl
	lis 4,.LC135@ha
	la 4,.LC135@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L200
	lwz 0,8(29)
	lis 5,.LC136@ha
	mr 3,31
	la 5,.LC136@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,compmod+8@ha
	li 0,1
	stw 0,compmod+8@l(9)
	b .L194
.L200:
	lwz 9,160(29)
	mr 3,30
	mtlr 9
	blrl
	lis 4,.LC59@ha
	la 4,.LC59@l(4)
	bl Q_stricmp
	mr. 30,3
	bc 4,2,.L202
	lwz 0,8(29)
	lis 5,.LC137@ha
	mr 3,31
	la 5,.LC137@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,compmod+8@ha
	stw 30,compmod+8@l(9)
	b .L194
.L202:
	lwz 9,8(29)
	lis 5,.LC138@ha
	mr 3,31
	la 5,.LC138@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC78@ha
	mr 3,31
	la 5,.LC78@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	bc 4,18,.L204
	lwz 9,8(29)
	lis 5,.LC79@ha
	li 3,0
	la 5,.LC79@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L204:
	lwz 9,8(29)
	lis 5,.LC139@ha
	mr 3,31
	la 5,.LC139@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC140@ha
	mr 3,31
	la 5,.LC140@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC141@ha
	mr 3,31
	la 5,.LC141@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC142@ha
	mr 3,31
	la 5,.LC142@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L194:
	lwz 0,36(1)
	lwz 12,16(1)
	mtlr 0
	lmw 29,20(1)
	mtcrf 8,12
	la 1,32(1)
	blr
.Lfe13:
	.size	 Cmd_ShutUp_f,.Lfe13-Cmd_ShutUp_f
	.section	".rodata"
	.align 2
.LC143:
	.string	"\nTeam setting is only valid in Match mode.\n"
	.align 2
.LC144:
	.string	"\nYou are a Spectator, you cannot set a team.\n"
	.align 2
.LC145:
	.string	"\nYour Team is "
	.align 2
.LC146:
	.string	"'<SPECTATOR>'\n"
	.align 2
.LC147:
	.string	"'%s'\n"
	.align 2
.LC148:
	.string	"\nYour cannot change teams once you are 'ready'.\nUse 'notready' first, then set your team.\n"
	.section	".text"
	.align 2
	.globl Cmd_Team_f
	.type	 Cmd_Team_f,@function
Cmd_Team_f:
	stwu 1,-288(1)
	mflr 0
	stmw 29,276(1)
	stw 0,292(1)
	lis 9,compmod+4@ha
	mr 31,3
	lwz 0,compmod+4@l(9)
	cmpwi 0,0,0
	bc 4,2,.L206
	lis 9,gi+8@ha
	lis 5,.LC143@ha
	lwz 0,gi+8@l(9)
	la 5,.LC143@l(5)
	b .L216
.L206:
	lwz 9,84(31)
	lwz 0,3472(9)
	cmpwi 0,0,-1
	bc 4,2,.L207
	lis 9,gi+8@ha
	lis 5,.LC144@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC144@l(5)
	b .L216
.L207:
	lis 9,gi@ha
	li 3,1
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L208
	lwz 9,8(30)
	lis 5,.LC145@ha
	mr 3,31
	la 5,.LC145@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lwz 6,3472(9)
	cmpwi 0,6,-1
	bc 12,2,.L217
	mulli 6,6,13
	lis 9,team@ha
	lwz 0,8(30)
	lis 5,.LC147@ha
	la 9,team@l(9)
	mr 3,31
	add 6,6,9
	la 5,.LC147@l(5)
	mtlr 0
	li 4,1
	crxor 6,6,6
	blrl
	b .L205
.L208:
	mr 3,31
	bl MatchInProgress
	mr. 29,3
	bc 4,2,.L205
	lwz 9,84(31)
	lwz 0,3464(9)
	cmpwi 0,0,1
	bc 4,2,.L213
	lwz 0,8(30)
	lis 5,.LC148@ha
	mr 3,31
	la 5,.LC148@l(5)
	b .L216
.L213:
	lwz 9,160(30)
	li 3,1
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcpy
	stb 29,20(1)
	addi 3,1,8
	bl AssignTeam
	lwz 9,84(31)
	lis 5,.LC145@ha
	li 4,1
	la 5,.LC145@l(5)
	stw 3,3472(9)
	lwz 9,8(30)
	mr 3,31
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lwz 6,3472(9)
	cmpwi 0,6,-1
	bc 4,2,.L214
.L217:
	lwz 0,8(30)
	lis 5,.LC146@ha
	mr 3,31
	la 5,.LC146@l(5)
.L216:
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L205
.L214:
	mulli 6,6,13
	lis 9,team@ha
	lwz 0,8(30)
	lis 5,.LC147@ha
	la 9,team@l(9)
	mr 3,31
	add 6,6,9
	la 5,.LC147@l(5)
	mtlr 0
	li 4,1
	crxor 6,6,6
	blrl
.L205:
	lwz 0,292(1)
	mtlr 0
	lmw 29,276(1)
	la 1,288(1)
	blr
.Lfe14:
	.size	 Cmd_Team_f,.Lfe14-Cmd_Team_f
	.section	".rodata"
	.align 2
.LC149:
	.string	"\nTimer setting is only valid in Match mode.\n"
	.align 2
.LC150:
	.string	"\nTo set the Rally Timer, use:\n"
	.align 2
.LC151:
	.string	"timerset <time>' - where <time> is the time in minutes.\n"
	.align 2
.LC152:
	.string	"\nRally Timer lower limit is 5 minutes.\n"
	.align 2
.LC153:
	.string	"\nRally Timer upper limit is 20 minutes.\n"
	.align 2
.LC154:
	.string	"\nRally Timelimit is %i minutes.\n"
	.align 3
.LC155:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_TimerSet_f
	.type	 Cmd_TimerSet_f,@function
Cmd_TimerSet_f:
	stwu 1,-48(1)
	mflr 0
	mfcr 12
	stmw 28,32(1)
	stw 0,52(1)
	stw 12,28(1)
	lis 9,compmod@ha
	mr 31,3
	la 28,compmod@l(9)
	lwz 0,4(28)
	cmpwi 0,0,0
	bc 4,2,.L219
	lis 9,gi+8@ha
	lis 5,.LC149@ha
	lwz 0,gi+8@l(9)
	la 5,.LC149@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L218
.L219:
	mr 3,31
	bl MatchInProgress
	cmpwi 0,3,0
	bc 4,2,.L218
	mr 3,31
	bl NotAnAdmin
	cmpwi 0,3,0
	bc 4,2,.L218
	srawi 0,31,31
	lis 11,gi@ha
	xor 9,0,31
	la 29,gi@l(11)
	subf 9,9,0
	lwz 10,160(29)
	cmpwi 4,31,0
	srawi 9,9,31
	nor 0,9,9
	mtlr 10
	rlwinm 9,9,0,31,31
	rlwinm 0,0,0,30,30
	or 30,9,0
	mr 3,30
	blrl
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L223
	lwz 9,8(29)
	lis 5,.LC150@ha
	mr 3,31
	la 5,.LC150@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC78@ha
	mr 3,31
	la 5,.LC78@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	bc 4,18,.L224
	lwz 9,8(29)
	lis 5,.LC79@ha
	li 3,0
	la 5,.LC79@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
.L224:
	lwz 0,8(29)
	lis 5,.LC151@ha
	mr 3,31
	la 5,.LC151@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L225
.L223:
	lwz 9,160(29)
	mr 3,30
	mtlr 9
	blrl
	bl atoi
	cmpwi 0,3,4
	stw 3,24(28)
	bc 12,1,.L226
	lwz 9,8(29)
	lis 5,.LC152@ha
	mr 3,31
	la 5,.LC152@l(5)
	li 4,1
	mtlr 9
	li 0,5
	stw 0,24(28)
	crxor 6,6,6
	blrl
.L226:
	lwz 0,24(28)
	cmpwi 0,0,20
	bc 4,1,.L227
	lwz 9,8(29)
	lis 5,.LC153@ha
	mr 3,31
	la 5,.LC153@l(5)
	li 4,1
	mtlr 9
	li 0,20
	stw 0,24(28)
	crxor 6,6,6
	blrl
.L227:
	bl FindTimer
	mr. 3,3
	bc 12,2,.L225
	lwz 0,24(28)
	lis 10,0x4330
	lis 9,.LC155@ha
	mulli 0,0,60
	la 9,.LC155@l(9)
	lfd 12,0(9)
	xoris 0,0,0x8000
	lis 9,level+4@ha
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	lfs 13,level+4@l(9)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,288(3)
.L225:
	lis 9,gi@ha
	lis 11,compmod+24@ha
	lwz 0,gi@l(9)
	lis 4,.LC154@ha
	li 3,1
	la 4,.LC154@l(4)
	lwz 5,compmod+24@l(11)
	mtlr 0
	crxor 6,6,6
	blrl
.L218:
	lwz 0,52(1)
	lwz 12,28(1)
	mtlr 0
	lmw 28,32(1)
	mtcrf 8,12
	la 1,48(1)
	blr
.Lfe15:
	.size	 Cmd_TimerSet_f,.Lfe15-Cmd_TimerSet_f
	.section	".rodata"
	.align 2
.LC156:
	.string	"\nNo Vote in progress.\n"
	.align 2
.LC157:
	.string	"\nYou have already voted.\n"
	.align 2
.LC158:
	.string	"DEBUG - Cmd_Vote_f was passed %i\n."
	.align 2
.LC159:
	.string	"\nWarp has been disabled by the server administrator.\n"
	.align 2
.LC160:
	.string	"\nTo change the current map, use the command:\n"
	.align 2
.LC161:
	.string	"'warp <map> [trust]'\n"
	.align 2
.LC162:
	.string	"<map>   = the file name of the map to change to\n"
	.align 2
.LC163:
	.string	"[trust] = don't check for a valid map name\n"
	.align 2
.LC164:
	.string	"trust"
	.align 2
.LC165:
	.string	"base1"
	.align 2
.LC166:
	.string	"base2"
	.align 2
.LC167:
	.string	"base3"
	.align 2
.LC168:
	.string	"biggun"
	.align 2
.LC169:
	.string	"boss1"
	.align 2
.LC170:
	.string	"boss2"
	.align 2
.LC171:
	.string	"bunk1"
	.align 2
.LC172:
	.string	"city1"
	.align 2
.LC173:
	.string	"city2"
	.align 2
.LC174:
	.string	"city3"
	.align 2
.LC175:
	.string	"command"
	.align 2
.LC176:
	.string	"cool1"
	.align 2
.LC177:
	.string	"fact1"
	.align 2
.LC178:
	.string	"fact2"
	.align 2
.LC179:
	.string	"fact3"
	.align 2
.LC180:
	.string	"hangar1"
	.align 2
.LC181:
	.string	"hangar2"
	.align 2
.LC182:
	.string	"jail1"
	.align 2
.LC183:
	.string	"jail2"
	.align 2
.LC184:
	.string	"jail3"
	.align 2
.LC185:
	.string	"jail4"
	.align 2
.LC186:
	.string	"jail5"
	.align 2
.LC187:
	.string	"lab"
	.align 2
.LC188:
	.string	"match1"
	.align 2
.LC189:
	.string	"mine1"
	.align 2
.LC190:
	.string	"mine2"
	.align 2
.LC191:
	.string	"mine3"
	.align 2
.LC192:
	.string	"mine4"
	.align 2
.LC193:
	.string	"mintro"
	.align 2
.LC194:
	.string	"power1"
	.align 2
.LC195:
	.string	"power2"
	.align 2
.LC196:
	.string	"q2dm1"
	.align 2
.LC197:
	.string	"q2dm2"
	.align 2
.LC198:
	.string	"q2dm3"
	.align 2
.LC199:
	.string	"q2dm4"
	.align 2
.LC200:
	.string	"q2dm5"
	.align 2
.LC201:
	.string	"q2dm6"
	.align 2
.LC202:
	.string	"q2dm7"
	.align 2
.LC203:
	.string	"q2dm8"
	.align 2
.LC204:
	.string	"security"
	.align 2
.LC205:
	.string	"space"
	.align 2
.LC206:
	.string	"strike"
	.align 2
.LC207:
	.string	"train"
	.align 2
.LC208:
	.string	"ware1"
	.align 2
.LC209:
	.string	"ware2"
	.align 2
.LC210:
	.string	"waste1"
	.align 2
.LC211:
	.string	"waste2"
	.align 2
.LC212:
	.string	"waste3"
	.align 2
.LC213:
	.string	"\n'%s' is not a valid map to warp to.\n"
	.align 2
.LC214:
	.string	"gamemap \"%s\"\n"
	.align 2
.LC215:
	.long 0x0
	.align 2
.LC216:
	.long 0x41700000
	.section	".text"
	.align 2
	.globl Cmd_Warp_f
	.type	 Cmd_Warp_f,@function
Cmd_Warp_f:
	stwu 1,-544(1)
	mflr 0
	stmw 28,528(1)
	stw 0,548(1)
	mr 28,3
	bl MatchInProgress
	cmpwi 0,3,0
	bc 4,2,.L236
	lis 9,.LC215@ha
	lis 11,nowarp@ha
	la 9,.LC215@l(9)
	lfs 13,0(9)
	lwz 9,nowarp@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L238
	lwz 9,84(28)
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 4,2,.L238
	lis 9,gi+8@ha
	lis 5,.LC159@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC159@l(5)
	b .L255
.L238:
	lis 9,gi@ha
	li 3,1
	la 30,gi@l(9)
	lwz 9,160(30)
	mtlr 9
	blrl
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L239
	lwz 9,8(30)
	lis 5,.LC160@ha
	mr 3,28
	la 5,.LC160@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC161@ha
	mr 3,28
	la 5,.LC161@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC162@ha
	mr 3,28
	la 5,.LC162@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(30)
	lis 5,.LC163@ha
	mr 3,28
	la 5,.LC163@l(5)
	b .L255
.L239:
	lwz 9,160(30)
	li 3,1
	addi 29,1,264
	mr 31,29
	mtlr 9
	blrl
	mr 4,3
	mr 3,29
	bl strcpy
	lwz 0,160(30)
	li 3,2
	mtlr 0
	blrl
	lis 4,.LC164@ha
	la 4,.LC164@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L240
	lwz 9,84(28)
	lwz 0,3456(9)
	cmpwi 0,0,2
	bc 4,2,.L240
	li 11,1
	b .L241
.L240:
	lis 4,.LC165@ha
	mr 3,31
	la 4,.LC165@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC166@ha
	mr 3,31
	la 4,.LC166@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC167@ha
	mr 3,31
	la 4,.LC167@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC168@ha
	mr 3,31
	la 4,.LC168@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC169@ha
	mr 3,31
	la 4,.LC169@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC170@ha
	mr 3,31
	la 4,.LC170@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC171@ha
	mr 3,31
	la 4,.LC171@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC172@ha
	mr 3,31
	la 4,.LC172@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC173@ha
	mr 3,31
	la 4,.LC173@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC174@ha
	mr 3,31
	la 4,.LC174@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC175@ha
	mr 3,31
	la 4,.LC175@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC176@ha
	mr 3,31
	la 4,.LC176@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC177@ha
	mr 3,31
	la 4,.LC177@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC178@ha
	mr 3,31
	la 4,.LC178@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC179@ha
	mr 3,31
	la 4,.LC179@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC180@ha
	mr 3,31
	la 4,.LC180@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC181@ha
	mr 3,31
	la 4,.LC181@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC182@ha
	mr 3,31
	la 4,.LC182@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC183@ha
	mr 3,31
	la 4,.LC183@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC184@ha
	mr 3,31
	la 4,.LC184@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC185@ha
	mr 3,31
	la 4,.LC185@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC186@ha
	mr 3,31
	la 4,.LC186@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC187@ha
	mr 3,31
	la 4,.LC187@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC188@ha
	mr 3,31
	la 4,.LC188@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC189@ha
	mr 3,31
	la 4,.LC189@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC190@ha
	mr 3,31
	la 4,.LC190@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC191@ha
	mr 3,31
	la 4,.LC191@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC192@ha
	mr 3,31
	la 4,.LC192@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC193@ha
	mr 3,31
	la 4,.LC193@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC194@ha
	mr 3,31
	la 4,.LC194@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC195@ha
	mr 3,31
	la 4,.LC195@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC196@ha
	mr 3,31
	la 4,.LC196@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC197@ha
	mr 3,31
	la 4,.LC197@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC198@ha
	mr 3,31
	la 4,.LC198@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC199@ha
	mr 3,31
	la 4,.LC199@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC200@ha
	mr 3,31
	la 4,.LC200@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC201@ha
	mr 3,31
	la 4,.LC201@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC202@ha
	mr 3,31
	la 4,.LC202@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC203@ha
	mr 3,31
	la 4,.LC203@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC204@ha
	mr 3,31
	la 4,.LC204@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC205@ha
	mr 3,31
	la 4,.LC205@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC206@ha
	mr 3,31
	la 4,.LC206@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC207@ha
	mr 3,31
	la 4,.LC207@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC208@ha
	mr 3,31
	la 4,.LC208@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC209@ha
	mr 3,31
	la 4,.LC209@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC210@ha
	mr 3,31
	la 4,.LC210@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC211@ha
	mr 3,31
	la 4,.LC211@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L243
	lis 4,.LC212@ha
	mr 3,31
	la 4,.LC212@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L242
.L243:
	li 11,1
	lwz 9,84(28)
	b .L241
.L242:
	lis 9,gi+8@ha
	lis 5,.LC213@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC213@l(5)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L236
.L241:
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 12,2,.L245
	lis 5,.LC214@ha
	addi 3,1,8
	mr 6,31
	la 5,.LC214@l(5)
	li 4,256
	crxor 6,6,6
	bl Com_sprintf
	lis 9,gi+168@ha
	addi 3,1,8
	lwz 0,gi+168@l(9)
	mtlr 0
	blrl
	b .L236
.L245:
	cmpwi 0,11,0
	bc 12,2,.L236
	bl FindVote
	mr. 30,3
	bc 12,2,.L247
	lis 9,gi+8@ha
	lis 5,.LC67@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC67@l(5)
	b .L255
.L247:
	bl G_Spawn
	lis 9,.LC68@ha
	mr 29,3
	la 9,.LC68@l(9)
	li 0,1
	stw 30,480(29)
	stw 0,264(29)
	lis 3,compmod+28@ha
	mr 4,31
	stw 9,280(29)
	la 3,compmod+28@l(3)
	stw 30,400(29)
	lwz 9,84(28)
	addi 9,9,700
	stw 9,296(29)
	bl strcpy
	lis 9,.LC216@ha
	lis 11,level+4@ha
	la 9,.LC216@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,VoteThink@ha
	la 9,VoteThink@l(9)
	fadds 0,0,13
	stw 9,436(29)
	stfs 0,428(29)
	bl FindVote
	mr. 11,3
	bc 4,2,.L248
	lis 9,gi+8@ha
	lis 5,.LC156@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC156@l(5)
	b .L255
.L248:
	lwz 9,84(28)
	lwz 0,3468(9)
	cmpwi 0,0,0
	bc 12,2,.L250
	lis 9,gi+8@ha
	lis 5,.LC157@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC157@l(5)
.L255:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L236
.L250:
	li 0,2
	mr 3,11
	stw 0,3468(9)
	lwz 9,400(11)
	addi 9,9,1
	stw 9,400(11)
	bl EvaluateVote
.L236:
	lwz 0,548(1)
	mtlr 0
	lmw 28,528(1)
	la 1,544(1)
	blr
.Lfe16:
	.size	 Cmd_Warp_f,.Lfe16-Cmd_Warp_f
	.section	".rodata"
	.align 2
.LC217:
	.string	"\nCommands\n"
	.align 2
.LC218:
	.string	"================\n"
	.align 2
.LC219:
	.string	"admin <code>\n"
	.align 2
.LC220:
	.string	"commands\n"
	.align 2
.LC221:
	.string	"contact\n"
	.align 2
.LC222:
	.string	"credits\n"
	.align 2
.LC223:
	.string	"dropquad <opt>\n"
	.align 2
.LC224:
	.string	"elect\n"
	.align 2
.LC225:
	.string	"endmatch\n"
	.align 2
.LC226:
	.string	"ff <opt>\n"
	.align 2
.LC227:
	.string	"lockdown <opt>\n"
	.align 2
.LC228:
	.string	"matchfragset <n>\n"
	.align 2
.LC229:
	.string	"matchtimeset <n>\n"
	.align 2
.LC230:
	.string	"modeset\n"
	.align 2
.LC231:
	.string	"modstatus\n"
	.align 2
.LC232:
	.string	"motd\n"
	.align 2
.LC233:
	.string	"myscore\n"
	.align 2
.LC234:
	.string	"no\n"
	.align 2
.LC235:
	.string	"normal\n"
	.align 2
.LC236:
	.string	"notready\n"
	.align 2
.LC237:
	.string	"player\n"
	.align 2
.LC238:
	.string	"playerlist\n"
	.align 2
.LC239:
	.string	"powerups <cmd>\n"
	.align 2
.LC240:
	.string	"ready\n"
	.align 2
.LC241:
	.string	"restart\n"
	.align 2
.LC242:
	.string	"spectator\n"
	.align 2
.LC243:
	.string	"team <name>\n"
	.align 2
.LC244:
	.string	"teamlist\n"
	.align 2
.LC245:
	.string	"timerset <n>\n"
	.align 2
.LC246:
	.string	"warp <map>\n"
	.align 2
.LC247:
	.string	"yes\n"
	.section	".text"
	.align 2
	.globl Cmd_Commands_f
	.type	 Cmd_Commands_f,@function
Cmd_Commands_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 31,3
	la 29,gi@l(9)
	lis 5,.LC217@ha
	lwz 9,8(29)
	la 5,.LC217@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC218@ha
	mr 3,31
	la 5,.LC218@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 4,2,.L257
	lwz 9,8(29)
	lis 5,.LC219@ha
	mr 3,31
	la 5,.LC219@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L257:
	lwz 9,8(29)
	lis 5,.LC220@ha
	mr 3,31
	la 5,.LC220@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC221@ha
	mr 3,31
	la 5,.LC221@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC222@ha
	mr 3,31
	la 5,.LC222@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 12,2,.L265
	lwz 9,8(29)
	lis 5,.LC223@ha
	mr 3,31
	la 5,.LC223@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 4,2,.L266
.L265:
	lwz 0,8(29)
	lis 5,.LC224@ha
	mr 3,31
	la 5,.LC224@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 12,2,.L260
.L266:
	lis 29,gi@ha
	lis 5,.LC225@ha
	la 29,gi@l(29)
	la 5,.LC225@l(5)
	lwz 9,8(29)
	mr 3,31
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC226@ha
	mr 3,31
	la 5,.LC226@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC227@ha
	mr 3,31
	la 5,.LC227@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC228@ha
	mr 3,31
	la 5,.LC228@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC229@ha
	mr 3,31
	la 5,.LC229@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC230@ha
	mr 3,31
	la 5,.LC230@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L260:
	lis 9,gi@ha
	lis 5,.LC231@ha
	la 29,gi@l(9)
	la 5,.LC231@l(5)
	lwz 9,8(29)
	mr 3,31
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC232@ha
	mr 3,31
	la 5,.LC232@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC233@ha
	mr 3,31
	la 5,.LC233@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC234@ha
	mr 3,31
	la 5,.LC234@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 12,2,.L261
	lwz 9,8(29)
	lis 5,.LC235@ha
	mr 3,31
	la 5,.LC235@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L261:
	lwz 9,8(29)
	lis 5,.LC236@ha
	mr 3,31
	la 5,.LC236@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC237@ha
	mr 3,31
	la 5,.LC237@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC238@ha
	mr 3,31
	la 5,.LC238@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 12,2,.L262
	lwz 9,8(29)
	lis 5,.LC239@ha
	mr 3,31
	la 5,.LC239@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L262:
	lwz 9,8(29)
	lis 5,.LC240@ha
	mr 3,31
	la 5,.LC240@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 12,2,.L263
	lwz 9,8(29)
	lis 5,.LC241@ha
	mr 3,31
	la 5,.LC241@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L263:
	lwz 9,8(29)
	lis 5,.LC242@ha
	mr 3,31
	la 5,.LC242@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC243@ha
	mr 3,31
	la 5,.LC243@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC244@ha
	mr 3,31
	la 5,.LC244@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 12,2,.L264
	lwz 9,8(29)
	lis 5,.LC245@ha
	mr 3,31
	la 5,.LC245@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC246@ha
	mr 3,31
	la 5,.LC246@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L264:
	lwz 9,8(29)
	lis 5,.LC247@ha
	mr 3,31
	la 5,.LC247@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC218@ha
	mr 3,31
	la 5,.LC218@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 Cmd_Commands_f,.Lfe17-Cmd_Commands_f
	.section	".rodata"
	.align 2
.LC248:
	.string	"\nCredits (alphabetical)\n"
	.align 2
.LC249:
	.string	"=================\n"
	.align 2
.LC250:
	.string	"Avalon          - My wife, my life\n"
	.align 2
.LC251:
	.string	"Inside 3D       - for the site\n"
	.align 2
.LC252:
	.string	"Mike-D          - for the Linux version\n"
	.align 2
.LC253:
	.string	"QDeveLS         - for the site\n"
	.align 2
.LC254:
	.string	"StraT           - for the encouragement\n"
	.align 2
.LC255:
	.string	"TeleFragged     - THE Quake site\n"
	.align 2
.LC256:
	.string	"Zoran           - for the Solaris version\n"
	.section	".text"
	.align 2
	.globl Cmd_Credits_f
	.type	 Cmd_Credits_f,@function
Cmd_Credits_f:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 28,3
	la 29,gi@l(29)
	lis 5,.LC248@ha
	lwz 9,8(29)
	la 5,.LC248@l(5)
	li 4,2
	lis 27,.LC249@ha
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	la 5,.LC249@l(27)
	mr 3,28
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC250@ha
	mr 3,28
	la 5,.LC250@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC251@ha
	mr 3,28
	la 5,.LC251@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC252@ha
	mr 3,28
	la 5,.LC252@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC253@ha
	mr 3,28
	la 5,.LC253@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC254@ha
	mr 3,28
	la 5,.LC254@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC255@ha
	mr 3,28
	la 5,.LC255@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC256@ha
	mr 3,28
	la 5,.LC256@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	mr 3,28
	la 5,.LC249@l(27)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 Cmd_Credits_f,.Lfe18-Cmd_Credits_f
	.section	".rodata"
	.align 2
.LC257:
	.string	"\nCannot change. Match in Progress.\n"
	.align 2
.LC258:
	.string	"timer"
	.align 2
.LC259:
	.string	"\nMatch begins in 30 seconds. Good Luck.\n"
	.align 2
.LC260:
	.string	"\nServer is restarting.\n"
	.align 2
.LC261:
	.string	"\nServer is switching to Free-For-All mode.\n"
	.align 2
.LC262:
	.string	"Server will reset in %d minute%c\n"
	.align 2
.LC263:
	.string	"Server will reset in %d second%c\n"
	.align 2
.LC264:
	.string	"\nThe match is over.\n"
	.align 2
.LC265:
	.string	"\nServer will reset in %i minutes\n"
	.align 2
.LC266:
	.string	"\nMatch ends in %d minute%c\n"
	.align 2
.LC267:
	.string	"Clan %s: %i frag%c\n"
	.align 2
.LC268:
	.string	"Match ends in %d second%c\n"
	.align 2
.LC269:
	.string	"\nFraglimit hit.\n"
	.align 2
.LC271:
	.string	"\nServer is now in Match mode.\n"
	.align 2
.LC272:
	.string	"\nGame on!\n"
	.align 2
.LC273:
	.string	"Match ends in %d minutes\n"
	.align 2
.LC274:
	.string	"Match starts in %d second%c\n"
	.align 3
.LC270:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC275:
	.long 0x3f800000
	.align 2
.LC276:
	.long 0x41f00000
	.align 2
.LC277:
	.long 0x0
	.align 3
.LC278:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC279:
	.long 0x402e0000
	.long 0x0
	.section	".text"
	.align 2
	.globl TimerThink
	.type	 TimerThink,@function
TimerThink:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 25,28(1)
	stw 0,68(1)
	lis 9,level@ha
	lis 10,.LC275@ha
	la 26,level@l(9)
	la 10,.LC275@l(10)
	lfs 13,4(26)
	mr 27,3
	lis 9,compmod@ha
	lfs 11,0(10)
	la 28,compmod@l(9)
	lfs 0,288(27)
	li 29,115
	li 30,0
	fadds 13,13,11
	stfs 13,428(27)
	lfs 13,4(26)
	lwz 0,4(28)
	fsubs 0,0,13
	cmpwi 0,0,0
	fctiwz 12,0
	stfd 12,16(1)
	lwz 31,20(1)
	bc 12,2,.L289
	cmpwi 0,0,1
	bc 4,2,.L292
	bl AllReady
	cmpwi 0,3,0
	bc 12,2,.L293
	li 3,1
	bl PlayerCount
	cmpwi 0,3,0
	bc 12,2,.L293
	lis 9,gi@ha
	lis 4,.LC259@ha
	lwz 0,gi@l(9)
	la 4,.LC259@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,.LC276@ha
	lfs 0,4(26)
	li 0,3
	la 9,.LC276@l(9)
	stw 0,4(28)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,288(27)
	b .L289
.L293:
	cmpwi 0,31,0
	bc 12,1,.L294
	lis 9,lockcurrmode@ha
	lis 10,.LC277@ha
	lwz 11,lockcurrmode@l(9)
	la 10,.LC277@l(10)
	lfs 31,0(10)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L295
	lis 9,gi@ha
	lis 4,.LC260@ha
	lwz 0,gi@l(9)
	la 4,.LC260@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L296
.L295:
	lis 9,gi@ha
	lis 4,.LC261@ha
	lwz 0,gi@l(9)
	la 4,.LC261@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,compmod+4@ha
	li 0,0
	stw 0,compmod+4@l(9)
	stfs 31,288(27)
.L296:
	bl RestartServer
	b .L289
.L294:
	lis 0,0x8888
	srawi 11,31,31
	ori 0,0,34953
	mulhw 0,31,0
	add 0,0,31
	srawi 0,0,5
	subf 5,11,0
	mulli 9,5,60
	cmpw 0,31,9
	bc 4,2,.L298
	lis 9,gi@ha
	xori 11,5,1
	lwz 10,gi@l(9)
	lis 4,.LC262@ha
	li 3,1
	srawi 9,11,31
	la 4,.LC262@l(4)
	xor 0,9,11
	mtlr 10
	subf 0,0,9
	srawi 0,0,31
	nor 6,0,0
	b .L332
.L298:
	xoris 0,31,0x8000
	lis 11,0x4330
	stw 0,20(1)
	lis 10,.LC278@ha
	stw 11,16(1)
	la 10,.LC278@l(10)
	lfd 12,0(10)
	lis 11,.LC279@ha
	lfd 0,16(1)
	la 11,.LC279@l(11)
	lfd 13,0(11)
	fsub 0,0,12
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L289
	xori 9,31,1
	lis 11,gi@ha
	srawi 10,9,31
	lis 4,.LC263@ha
	xor 0,10,9
	la 4,.LC263@l(4)
	subf 0,0,10
	lwz 9,gi@l(11)
	mr 5,31
	srawi 0,0,31
	li 3,1
	nor 6,0,0
	mtlr 9
.L332:
	and 0,29,0
	rlwinm 6,6,0,26,26
	or 6,0,6
	crxor 6,6,6
	blrl
	b .L289
.L292:
	cmpwi 0,0,2
	bc 4,2,.L304
	cmpwi 0,31,0
	bc 12,1,.L305
	lis 29,gi@ha
	lis 4,.LC264@ha
	lwz 9,gi@l(29)
	la 4,.LC264@l(4)
	li 3,2
	srawi 25,31,31
	mtlr 9
	crxor 6,6,6
	blrl
	li 3,1
	li 4,0
	li 5,0
	bl ApplyToAllPlayers
	li 4,0
	li 3,3
	li 5,0
	bl ApplyToAllPlayers
	bl DeclareWinner
	bl MakeClansUsed
	lwz 0,24(28)
	lis 10,0x4330
	lis 9,.LC278@ha
	lfs 13,4(26)
	lis 4,.LC265@ha
	mulli 0,0,60
	la 9,.LC278@l(9)
	li 3,2
	lfd 12,0(9)
	la 4,.LC265@l(4)
	xoris 0,0,0x8000
	li 9,1
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	stw 9,4(28)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,288(27)
	lwz 0,gi@l(29)
	lwz 5,24(28)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L306
.L305:
	lis 0,0x8888
	srawi 11,31,31
	ori 0,0,34953
	mr 25,11
	mulhw 0,31,0
	add 0,0,31
	srawi 0,0,5
	subf 5,11,0
	mulli 9,5,60
	cmpw 0,31,9
	bc 4,2,.L307
	lis 9,gi@ha
	xori 11,5,1
	lwz 10,gi@l(9)
	lis 4,.LC266@ha
	li 3,1
	srawi 9,11,31
	la 4,.LC266@l(4)
	xor 0,9,11
	mtlr 10
	subf 0,0,9
	srawi 0,0,31
	nor 6,0,0
	andi. 0,0,115
	rlwinm 6,6,0,26,26
	or 6,0,6
	crxor 6,6,6
	blrl
	lis 9,.LC277@ha
	lis 11,scorecast@ha
	la 9,.LC277@l(9)
	lfs 13,0(9)
	lwz 9,scorecast@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L306
	b .L310
.L312:
	lwz 6,480(30)
	lis 11,gi@ha
	lis 9,team@ha
	lwz 10,gi@l(11)
	la 9,team@l(9)
	lis 4,.LC267@ha
	xori 0,6,1
	lwz 5,264(30)
	la 4,.LC267@l(4)
	srawi 11,0,31
	li 3,2
	mtlr 10
	xor 7,11,0
	mulli 5,5,13
	subf 7,7,11
	srawi 7,7,31
	add 5,5,9
	andi. 7,7,115
	ori 7,7,32
	crxor 6,6,6
	blrl
.L310:
	lis 5,.LC12@ha
	mr 3,30
	la 5,.LC12@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L312
	b .L306
.L307:
	xoris 0,31,0x8000
	lis 11,0x4330
	stw 0,20(1)
	lis 10,.LC278@ha
	stw 11,16(1)
	la 10,.LC278@l(10)
	lfd 12,0(10)
	lis 11,.LC279@ha
	lfd 0,16(1)
	la 11,.LC279@l(11)
	lfd 13,0(11)
	fsub 0,0,12
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L306
	xori 9,31,1
	lis 11,gi@ha
	srawi 10,9,31
	lis 4,.LC268@ha
	xor 0,10,9
	la 4,.LC268@l(4)
	subf 0,0,10
	lwz 9,gi@l(11)
	li 3,1
	srawi 0,0,31
	mr 5,31
	nor 6,0,0
	mtlr 9
	andi. 0,0,115
	rlwinm 6,6,0,26,26
	or 6,0,6
	crxor 6,6,6
	blrl
.L306:
	lis 9,compmod+20@ha
	subf 0,31,25
	lwz 11,compmod+20@l(9)
	srwi 0,0,31
	addic 10,11,-1
	subfe 9,10,11
	and. 11,9,0
	bc 12,2,.L289
	b .L320
.L322:
	lis 9,compmod+20@ha
	lwz 11,480(30)
	lwz 0,compmod+20@l(9)
	cmpw 0,11,0
	bc 12,0,.L320
	lis 9,gi@ha
	lis 4,.LC269@ha
	lwz 0,gi@l(9)
	la 4,.LC269@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,level@ha
	lis 11,.LC270@ha
	la 9,level@l(9)
	lfd 12,.LC270@l(11)
	lfs 13,4(9)
	stfs 13,288(27)
	lfs 0,4(9)
	fadd 0,0,12
	frsp 0,0
	stfs 0,428(27)
.L320:
	lis 5,.LC12@ha
	mr 3,30
	la 5,.LC12@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L322
	b .L289
.L304:
	cmpwi 0,0,3
	bc 4,2,.L289
	bl AllReady
	cmpwi 0,3,0
	bc 4,2,.L327
	lis 9,gi@ha
	lis 4,.LC271@ha
	lwz 0,gi@l(9)
	la 4,.LC271@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,24(28)
	lis 10,0x4330
	lis 9,.LC278@ha
	lfs 13,4(26)
	mulli 0,0,60
	la 9,.LC278@l(9)
	lfd 12,0(9)
	xoris 0,0,0x8000
	li 9,1
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	stw 9,4(28)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,288(27)
	b .L289
.L327:
	cmpwi 0,31,0
	bc 12,1,.L328
	lis 29,gi@ha
	lis 4,.LC272@ha
	lwz 9,gi@l(29)
	la 4,.LC272@l(4)
	li 3,2
	mtlr 9
	crxor 6,6,6
	blrl
	li 3,0
	li 4,0
	li 5,0
	bl ApplyToAllPlayers
	li 3,2
	li 4,0
	li 5,0
	bl ApplyToAllPlayers
	li 4,0
	li 5,0
	li 3,1
	bl ApplyToAllPlayers
	li 3,0
	bl ApplyToAllClans
	li 3,1
	bl ApplyToAllClans
	li 3,2
	bl ApplyToAllClans
	lwz 9,16(28)
	lis 8,0x4330
	lis 10,.LC278@ha
	lfs 13,4(26)
	li 0,2
	mulli 9,9,60
	la 10,.LC278@l(10)
	stw 0,4(28)
	lis 5,0x8888
	lfd 11,0(10)
	ori 5,5,34953
	lis 4,.LC273@ha
	xoris 9,9,0x8000
	stw 30,12(28)
	mr 10,11
	stw 9,20(1)
	la 4,.LC273@l(4)
	li 3,1
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,11
	frsp 0,0
	fadds 13,13,0
	stfs 13,288(27)
	lfs 0,4(26)
	lwz 9,gi@l(29)
	fsubs 13,13,0
	mtlr 9
	fctiwz 12,13
	stfd 12,16(1)
	lwz 31,20(1)
	mulhw 5,31,5
	srawi 0,31,31
	add 5,5,31
	srawi 5,5,5
	subf 5,0,5
	crxor 6,6,6
	blrl
	b .L289
.L328:
	xoris 0,31,0x8000
	lis 11,0x4330
	stw 0,20(1)
	lis 10,.LC278@ha
	stw 11,16(1)
	la 10,.LC278@l(10)
	lfd 12,0(10)
	lis 11,.LC279@ha
	lfd 0,16(1)
	la 11,.LC279@l(11)
	lfd 13,0(11)
	fsub 0,0,12
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L289
	xori 9,31,1
	lis 11,gi@ha
	srawi 10,9,31
	lis 4,.LC274@ha
	xor 0,10,9
	la 4,.LC274@l(4)
	subf 0,0,10
	lwz 9,gi@l(11)
	mr 5,31
	srawi 0,0,31
	li 3,1
	nor 6,0,0
	mtlr 9
	andi. 0,0,115
	rlwinm 6,6,0,26,26
	or 6,0,6
	crxor 6,6,6
	blrl
.L289:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe19:
	.size	 TimerThink,.Lfe19-TimerThink
	.section	".rodata"
	.align 2
.LC280:
	.string	"Clan '%s' is the WINNER\nwith %i frag%c!"
	.section	".text"
	.align 2
	.globl ApplyToAllPlayers
	.type	 ApplyToAllPlayers,@function
ApplyToAllPlayers:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 30,3
	mr 27,4
	mr 29,5
	li 28,115
	li 31,0
	b .L342
.L344:
	cmpwi 0,30,0
	bc 4,2,.L345
	lwz 9,84(31)
	lwz 0,3472(9)
	cmpwi 0,0,-1
	bc 12,2,.L345
	stw 30,3464(9)
	b .L342
.L345:
	cmpwi 0,30,1
	bc 4,2,.L347
	lwz 9,84(31)
	lwz 0,3472(9)
	cmpwi 0,0,-1
	bc 12,2,.L347
	lis 9,g_edicts@ha
	lis 6,vec3_origin@ha
	lwz 4,g_edicts@l(9)
	la 6,vec3_origin@l(6)
	li 0,32
	li 11,34
	lis 9,0x1
	stw 0,8(1)
	stw 11,12(1)
	mr 3,31
	mr 5,4
	addi 7,31,4
	mr 8,6
	ori 9,9,34464
	li 10,1
	bl T_Damage
	b .L342
.L347:
	cmpwi 0,30,2
	bc 4,2,.L349
	lwz 9,84(31)
	lwz 0,3472(9)
	cmpwi 0,0,-1
	bc 12,2,.L349
	li 0,0
	stw 0,3432(9)
	lwz 9,84(31)
	stw 0,3476(9)
	lwz 11,84(31)
	stw 0,3480(11)
	lwz 9,84(31)
	stw 0,3484(9)
	lwz 11,84(31)
	stw 0,3488(11)
	b .L342
.L349:
	cmpwi 0,30,3
	bc 4,2,.L351
	lwz 9,84(31)
	lwz 0,3472(9)
	cmpwi 0,0,-1
	bc 12,2,.L351
	mr 3,31
	bl DumpPlayerScore
	b .L342
.L351:
	cmpwi 0,30,4
	bc 4,2,.L353
	xori 0,29,1
	mulli 10,27,13
	lis 5,team@ha
	srawi 11,0,31
	la 5,team@l(5)
	xor 9,11,0
	lis 4,.LC280@ha
	subf 9,9,11
	add 5,10,5
	srawi 9,9,31
	lis 11,gi+12@ha
	nor 0,9,9
	lwz 11,gi+12@l(11)
	la 4,.LC280@l(4)
	and 9,28,9
	rlwinm 0,0,0,26,26
	or 28,9,0
	mr 3,31
	mtlr 11
	mr 6,29
	mr 7,28
	crxor 6,6,6
	blrl
	b .L342
.L353:
	cmpwi 0,30,5
	bc 4,2,.L342
	lwz 9,84(31)
	lwz 0,3472(9)
	cmpwi 0,0,-1
	bc 12,2,.L342
	li 0,0
	stw 0,3468(9)
.L342:
	lis 5,.LC107@ha
	mr 3,31
	la 5,.LC107@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L344
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe20:
	.size	 ApplyToAllPlayers,.Lfe20-ApplyToAllPlayers
	.section	".rodata"
	.align 2
.LC281:
	.string	"\nYour Clan does not exist!\n"
	.align 2
.LC282:
	.string	"\nYour Score\n"
	.align 2
.LC283:
	.string	"Frags|Enemies|Friends|Deaths\n"
	.align 2
.LC284:
	.string	"%5i|%7i|%7i|%6i\n"
	.align 2
.LC285:
	.string	"\n%12s Clan score\n"
	.align 2
.LC286:
	.string	"\nClan does not exist.\n"
	.section	".text"
	.align 2
	.globl DumpClanScore
	.type	 DumpClanScore,@function
DumpClanScore:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,compmod+4@ha
	mr 30,3
	lwz 0,compmod+4@l(9)
	cmpwi 0,0,0
	bc 12,2,.L371
	lwz 9,84(30)
	li 3,0
	lwz 31,3472(9)
	b .L373
.L375:
	lwz 0,264(3)
	cmpw 0,0,31
	bc 12,2,.L381
.L373:
	lis 5,.LC12@ha
	li 4,280
	la 5,.LC12@l(5)
	bl G_Find
	mr. 3,3
	bc 4,2,.L375
	li 31,0
.L377:
	cmpwi 0,31,0
	bc 12,2,.L379
	lwz 0,264(31)
	lis 29,gi@ha
	lis 6,team@ha
	la 29,gi@l(29)
	la 6,team@l(6)
	mulli 0,0,13
	lwz 11,8(29)
	lis 5,.LC285@ha
	mr 3,30
	la 5,.LC285@l(5)
	li 4,2
	add 6,0,6
	mtlr 11
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC283@ha
	mr 3,30
	la 5,.LC283@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC284@ha
	mr 3,30
	la 5,.LC284@l(5)
	lwz 9,492(31)
	li 4,2
	lwz 6,480(31)
	mtlr 0
	lwz 7,484(31)
	lwz 8,488(31)
	crxor 6,6,6
	blrl
	b .L371
.L381:
	mr 31,3
	b .L377
.L379:
	lis 9,gi+8@ha
	lis 5,.LC286@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC286@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L371:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 DumpClanScore,.Lfe21-DumpClanScore
	.section	".rodata"
	.align 3
.LC288:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl ApplyToAllClans
	.type	 ApplyToAllClans,@function
ApplyToAllClans:
	stwu 1,-48(1)
	mflr 0
	mfcr 12
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	stw 12,24(1)
	mr 31,3
	cmpwi 0,31,2
	li 3,0
	bc 4,2,.L388
	lis 9,.LC13@ha
	addi 8,1,8
	lwz 10,.LC13@l(9)
	la 9,.LC13@l(9)
	lbz 0,8(9)
	lwz 11,4(9)
	stw 10,8(1)
	stb 0,8(8)
	stw 11,4(8)
	b .L389
.L388:
	lis 9,.LC12@ha
	la 11,.LC12@l(9)
	lwz 0,.LC12@l(9)
	lbz 10,4(11)
	stw 0,8(1)
	stb 10,12(1)
.L389:
	lis 9,.LC288@ha
	cmpwi 2,31,0
	lfd 31,.LC288@l(9)
	cmpwi 3,31,1
	lis 11,level@ha
	cmpwi 4,31,2
	lis 9,G_FreeEdict@ha
	la 29,level@l(11)
	la 30,G_FreeEdict@l(9)
	b .L390
.L392:
	bc 4,10,.L393
	stw 31,480(3)
	stw 31,484(3)
	stw 31,488(3)
	stw 31,492(3)
	b .L390
.L393:
	bc 4,14,.L395
	lwz 0,400(3)
	cmpwi 0,0,0
	bc 12,1,.L390
	b .L400
.L395:
	bc 4,18,.L390
.L400:
	lfs 0,4(29)
	stw 30,436(3)
	fadd 0,0,31
	frsp 0,0
	stfs 0,428(3)
.L390:
	li 4,280
	addi 5,1,8
	bl G_Find
	mr. 3,3
	bc 4,2,.L392
	lwz 0,52(1)
	lwz 12,24(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	mtcrf 56,12
	la 1,48(1)
	blr
.Lfe22:
	.size	 ApplyToAllClans,.Lfe22-ApplyToAllClans
	.section	".rodata"
	.align 2
.LC289:
	.string	"\nFINAL SCORES\n"
	.align 2
.LC290:
	.string	"DEBUG - No clans found in DeclareWinner"
	.align 2
.LC291:
	.string	"\nWe have a TIE with %i frag%c!\nHere are the Clans:\n"
	.align 2
.LC292:
	.string	"Clan %s\n"
	.section	".text"
	.align 2
	.globl DeclareWinner
	.type	 DeclareWinner,@function
DeclareWinner:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 9,gi@ha
	lis 4,.LC289@ha
	lwz 0,gi@l(9)
	la 4,.LC289@l(4)
	li 3,2
	li 28,115
	li 31,0
	mtlr 0
	li 26,0
	li 30,0
	li 29,-10000
	crxor 6,6,6
	blrl
	lis 25,gi@ha
	lis 27,.LC12@ha
	b .L402
.L404:
	lwz 6,480(31)
	lis 9,gi@ha
	lis 11,team@ha
	lwz 8,gi@l(9)
	la 11,team@l(11)
	lis 4,.LC267@ha
	xori 0,6,1
	lwz 5,264(31)
	la 4,.LC267@l(4)
	srawi 10,0,31
	li 3,2
	mtlr 8
	xor 9,10,0
	mulli 5,5,13
	subf 9,9,10
	srawi 9,9,31
	add 5,5,11
	nor 0,9,9
	rlwinm 0,0,0,26,26
	and 9,28,9
	or 28,9,0
	mr 7,28
	crxor 6,6,6
	blrl
	lwz 0,480(31)
	cmpw 0,0,29
	bc 4,1,.L402
	lwz 26,264(31)
	mr 29,0
.L402:
	lis 5,.LC12@ha
	mr 3,31
	la 5,.LC12@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L404
	cmpwi 0,29,-10000
	li 28,115
	bc 4,2,.L410
	lis 9,gi+4@ha
	lis 3,.LC290@ha
	lwz 0,gi+4@l(9)
	la 3,.LC290@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L409
.L412:
	lwz 0,480(31)
	addi 11,30,1
	xor 0,0,29
	srawi 10,0,31
	xor 9,10,0
	subf 9,9,10
	srawi 9,9,31
	andc 11,11,9
	and 9,30,9
	or 30,9,11
.L410:
	mr 3,31
	li 4,280
	la 5,.LC12@l(27)
	bl G_Find
	mr. 31,3
	bc 4,2,.L412
	cmpwi 0,30,1
	bc 4,1,.L415
	xori 9,29,1
	lis 11,gi@ha
	srawi 10,9,31
	lis 4,.LC291@ha
	xor 0,10,9
	la 4,.LC291@l(4)
	subf 0,0,10
	lwz 9,gi@l(11)
	li 3,2
	srawi 0,0,31
	mr 5,29
	nor 6,0,0
	mtlr 9
	and 0,28,0
	rlwinm 6,6,0,26,26
	or 6,0,6
	lis 28,.LC292@ha
	crxor 6,6,6
	blrl
	lis 9,team@ha
	la 30,team@l(9)
	b .L417
.L419:
	lwz 0,480(31)
	cmpw 0,0,29
	bc 4,2,.L417
	lwz 5,264(31)
	li 3,2
	la 4,.LC292@l(28)
	lwz 9,gi@l(25)
	mulli 5,5,13
	mtlr 9
	add 5,5,30
	crxor 6,6,6
	blrl
.L417:
	mr 3,31
	li 4,280
	la 5,.LC12@l(27)
	bl G_Find
	mr. 31,3
	bc 4,2,.L419
	b .L409
.L415:
	mr 4,26
	mr 5,29
	li 3,4
	bl ApplyToAllPlayers
.L409:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe23:
	.size	 DeclareWinner,.Lfe23-DeclareWinner
	.section	".rodata"
	.align 2
.LC293:
	.string	"Attempted connection was refused.\n"
	.align 2
.LC294:
	.string	"DEBUG - ApplyToAllAdmins - invalid code %i"
	.align 2
.LC296:
	.string	"\nServer will reset in 10 minutes.\n"
	.align 3
.LC295:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC297:
	.long 0x44160000
	.section	".text"
	.align 2
	.globl EndMatch
	.type	 EndMatch,@function
EndMatch:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	li 3,1
	bl PlayerCount
	cmpwi 0,3,0
	bc 12,2,.L440
	li 3,1
	li 4,0
	li 5,0
	bl ApplyToAllPlayers
	li 3,3
	li 4,0
	li 5,0
	bl ApplyToAllPlayers
.L440:
	li 31,0
	b .L441
.L443:
	bl G_Spawn
	lis 9,.LC13@ha
	lis 8,level+4@ha
	la 9,.LC13@l(9)
	lis 10,.LC295@ha
	stw 9,280(3)
	lis 11,G_FreeEdict@ha
	lwz 9,264(31)
	la 11,G_FreeEdict@l(11)
	stw 9,264(3)
	lwz 0,400(31)
	stw 0,400(3)
	lwz 9,480(31)
	stw 9,480(3)
	lwz 0,484(31)
	stw 0,484(3)
	lwz 9,488(31)
	stw 9,488(3)
	lwz 0,492(31)
	stw 0,492(3)
	lfs 0,level+4@l(8)
	lfd 13,.LC295@l(10)
	stw 11,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L441:
	lis 5,.LC12@ha
	mr 3,31
	la 5,.LC12@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L443
	lis 9,compmod+4@ha
	li 0,1
	lis 5,.LC258@ha
	stw 0,compmod+4@l(9)
	li 3,0
	la 5,.LC258@l(5)
	li 4,280
	bl G_Find
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and. 3,3,0
	bc 12,2,.L449
	lis 11,.LC297@ha
	lis 9,level+4@ha
	la 11,.LC297@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	fadds 0,0,13
	stfs 0,288(3)
.L449:
	lis 9,gi@ha
	lis 4,.LC296@ha
	lwz 0,gi@l(9)
	la 4,.LC296@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe24:
	.size	 EndMatch,.Lfe24-EndMatch
	.section	".rodata"
	.align 2
.LC298:
	.string	"\nThe vote has passed.\n"
	.align 2
.LC299:
	.string	"\nThe vote has been defeated.\n"
	.align 2
.LC300:
	.string	"\nThe vote is a TIE, so it is cancelled.\n"
	.align 2
.LC301:
	.string	"\n%s has requested "
	.align 2
.LC302:
	.string	"Admin status.\n"
	.align 2
.LC303:
	.string	"a level change to '%s'.\n"
	.align 2
.LC304:
	.string	"to end the match.\n"
	.align 2
.LC305:
	.string	"Votes YES:%i\n"
	.align 2
.LC306:
	.string	"Votes  NO:%i\n"
	.align 2
.LC307:
	.string	"Enter 'yes' or 'no' at the console.\n"
	.align 3
.LC308:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC309:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl EvaluateVote
	.type	 EvaluateVote,@function
EvaluateVote:
	stwu 1,-304(1)
	mflr 0
	stmw 27,284(1)
	stw 0,308(1)
	mr 31,3
	li 30,0
	li 3,0
	li 29,0
	lis 28,.LC107@ha
	b .L473
.L475:
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 12,2,.L473
	lwz 0,3472(9)
	addi 9,29,1
	subfic 0,0,-1
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,29,0
	or 29,0,9
.L473:
	lis 5,.LC107@ha
	li 4,280
	la 5,.LC107@l(5)
	bl G_Find
	mr. 3,3
	bc 4,2,.L475
	xoris 0,29,0x8000
	lwz 8,400(31)
	stw 0,276(1)
	lis 10,0x4330
	mr 11,9
	stw 10,272(1)
	xoris 0,8,0x8000
	lis 7,.LC308@ha
	lfd 13,272(1)
	la 7,.LC308@l(7)
	stw 0,276(1)
	lis 9,.LC309@ha
	stw 10,272(1)
	la 9,.LC309@l(9)
	lfd 12,0(7)
	lfd 0,272(1)
	lfd 10,0(9)
	fsub 13,13,12
	fsub 0,0,12
	frsp 11,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 7,13,10
	bc 4,29,.L484
	lwz 29,264(31)
	mr 3,31
	bl KillVote
	lis 9,gi@ha
	lis 4,.LC298@ha
	lwz 0,gi@l(9)
	la 4,.LC298@l(4)
	li 3,2
	la 27,gi@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
	cmpwi 0,29,2
	bc 4,2,.L485
	b .L489
.L488:
	lwz 3,84(30)
	lwz 4,296(31)
	addi 3,3,700
	bl Q_stricmp
	mr. 10,3
	bc 12,2,.L505
.L489:
	mr 3,30
	li 4,280
	la 5,.LC107@l(28)
	bl G_Find
	mr. 30,3
	bc 4,2,.L488
	b .L472
.L485:
	cmpwi 0,29,1
	bc 4,2,.L492
	lis 5,.LC214@ha
	lis 6,compmod+28@ha
	addi 3,1,8
	la 6,compmod+28@l(6)
	la 5,.LC214@l(5)
	li 4,256
	crxor 6,6,6
	bl Com_sprintf
	lwz 0,168(27)
	addi 3,1,8
	mtlr 0
	blrl
	b .L472
.L492:
	cmpwi 0,29,3
	bc 4,2,.L472
	bl EndMatch
	b .L472
.L484:
	lwz 11,480(31)
	xoris 0,11,0x8000
	stw 0,276(1)
	stw 10,272(1)
	lfd 0,272(1)
	fsub 0,0,12
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,10
	bc 4,1,.L496
	mr 3,31
	bl KillVote
	lis 9,gi@ha
	lis 4,.LC299@ha
	lwz 0,gi@l(9)
	la 4,.LC299@l(4)
	b .L506
.L496:
	bc 4,30,.L495
	add 0,8,11
	xoris 0,0,0x8000
	stw 0,276(1)
	stw 10,272(1)
	lfd 0,272(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,11
	bc 4,2,.L495
	mr 3,31
	bl KillVote
	lis 9,gi@ha
	lis 4,.LC300@ha
	lwz 0,gi@l(9)
	la 4,.LC300@l(4)
.L506:
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L472
.L495:
	lwz 0,264(31)
	cmpwi 0,0,0
	bc 4,2,.L499
	mr 3,31
	bl KillVote
	b .L472
.L499:
	lis 9,gi@ha
	lis 4,.LC301@ha
	lwz 5,296(31)
	lwz 0,gi@l(9)
	la 4,.LC301@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,264(31)
	lis 9,gi@ha
	cmpwi 0,0,2
	bc 4,2,.L500
	lwz 0,gi@l(9)
	lis 4,.LC302@ha
	li 3,2
	la 4,.LC302@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L501
.L500:
	cmpwi 0,0,1
	bc 4,2,.L502
	lwz 0,gi@l(9)
	lis 4,.LC303@ha
	lis 5,compmod+28@ha
	la 4,.LC303@l(4)
	la 5,compmod+28@l(5)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L501
.L505:
	lwz 9,84(30)
	li 0,1
	lis 11,gi@ha
	lis 4,.LC66@ha
	li 3,2
	stw 0,3456(9)
	la 4,.LC66@l(4)
	lwz 9,84(30)
	stw 10,3460(9)
	lwz 0,gi@l(11)
	lwz 5,296(31)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L472
.L502:
	cmpwi 0,0,3
	bc 4,2,.L501
	lwz 0,gi@l(9)
	lis 4,.LC304@ha
	li 3,2
	la 4,.LC304@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L501:
	lis 29,gi@ha
	lis 4,.LC305@ha
	lwz 5,400(31)
	lwz 9,gi@l(29)
	la 4,.LC305@l(4)
	li 3,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,gi@l(29)
	lis 4,.LC306@ha
	li 3,2
	la 4,.LC306@l(4)
	lwz 5,480(31)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,gi@l(29)
	lis 4,.LC307@ha
	li 3,2
	la 4,.LC307@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L472:
	lwz 0,308(1)
	mtlr 0
	lmw 27,284(1)
	la 1,304(1)
	blr
.Lfe25:
	.size	 EvaluateVote,.Lfe25-EvaluateVote
	.section	".rodata"
	.align 2
.LC311:
	.string	"ffadisable"
	.align 2
.LC312:
	.string	"matchdisable"
	.align 2
.LC313:
	.string	"item_quad"
	.align 2
.LC314:
	.string	"item_invulnerability"
	.align 2
.LC315:
	.string	"weapon_bfg"
	.align 2
.LC316:
	.string	"weapon_railgun"
	.align 2
.LC317:
	.string	"weapon_hyperblaster"
	.align 2
.LC318:
	.string	"weapon_rocketlauncher"
	.align 2
.LC319:
	.string	"weapon_grenadelauncher"
	.align 2
.LC320:
	.string	"ammo_grenades"
	.align 2
.LC321:
	.string	"weapon_chaingun"
	.align 2
.LC322:
	.string	"weapon_machinegun"
	.align 2
.LC323:
	.string	"weapon_supershotgun"
	.align 2
.LC324:
	.string	"weapon_shotgun"
	.section	".text"
	.align 2
	.globl IsItDisabled
	.type	 IsItDisabled,@function
IsItDisabled:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 9,compmod+4@ha
	mr 30,3
	lwz 0,compmod+4@l(9)
	cmpwi 0,0,0
	bc 4,2,.L522
	lis 11,ffadisable@ha
	lwz 9,ffadisable@l(11)
	b .L539
.L522:
	lis 11,matchdisable@ha
	lwz 9,matchdisable@l(11)
.L539:
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 31,20(1)
	lwz 3,280(30)
	lis 4,.LC313@ha
	la 4,.LC313@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L526
	andi. 0,31,1
	bc 4,2,.L525
.L526:
	lwz 3,280(30)
	lis 4,.LC314@ha
	la 4,.LC314@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L527
	andi. 0,31,2
	bc 4,2,.L525
.L527:
	lwz 3,280(30)
	lis 4,.LC315@ha
	la 4,.LC315@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L528
	andi. 0,31,4
	bc 4,2,.L525
.L528:
	lwz 3,280(30)
	lis 4,.LC316@ha
	la 4,.LC316@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L529
	andi. 0,31,8
	bc 4,2,.L525
.L529:
	lwz 3,280(30)
	lis 4,.LC317@ha
	la 4,.LC317@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L530
	andi. 0,31,16
	bc 4,2,.L525
.L530:
	lwz 3,280(30)
	lis 4,.LC318@ha
	la 4,.LC318@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L531
	andi. 0,31,32
	bc 4,2,.L525
.L531:
	lwz 3,280(30)
	lis 4,.LC319@ha
	la 4,.LC319@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L532
	andi. 0,31,64
	bc 4,2,.L525
.L532:
	lwz 3,280(30)
	lis 4,.LC320@ha
	la 4,.LC320@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L533
	andi. 0,31,128
	bc 4,2,.L525
.L533:
	lwz 3,280(30)
	lis 4,.LC321@ha
	la 4,.LC321@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L534
	andi. 0,31,256
	bc 4,2,.L525
.L534:
	lwz 3,280(30)
	lis 4,.LC322@ha
	la 4,.LC322@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L535
	andi. 0,31,512
	bc 4,2,.L525
.L535:
	lwz 3,280(30)
	lis 4,.LC323@ha
	la 4,.LC323@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L536
	andi. 0,31,1024
	bc 4,2,.L525
.L536:
	lwz 3,280(30)
	lis 4,.LC324@ha
	la 4,.LC324@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L524
	andi. 0,31,2048
	bc 12,2,.L524
.L525:
	li 3,1
	b .L538
.L524:
	li 3,0
.L538:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 IsItDisabled,.Lfe26-IsItDisabled
	.comm	compmod,284,4
	.comm	team,221,1
	.align 2
	.globl Cmd_BecomePlayer_f
	.type	 Cmd_BecomePlayer_f,@function
Cmd_BecomePlayer_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl MatchInProgress
	mr. 10,3
	bc 4,2,.L17
	lwz 9,84(31)
	lwz 0,3472(9)
	cmpwi 0,0,-1
	bc 4,2,.L17
	stw 10,3464(9)
	mr 3,31
	lwz 9,84(31)
	stw 10,3472(9)
	lwz 11,84(31)
	stw 10,1788(11)
	bl respawn
.L17:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe27:
	.size	 Cmd_BecomePlayer_f,.Lfe27-Cmd_BecomePlayer_f
	.align 2
	.globl Cmd_BecomeSpectator_f
	.type	 Cmd_BecomeSpectator_f,@function
Cmd_BecomeSpectator_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	bl MatchInProgress
	mr. 30,3
	bc 4,2,.L20
	lwz 9,84(31)
	lwz 0,3472(9)
	cmpwi 0,0,-1
	bc 12,2,.L20
	stw 30,3432(9)
	mr 3,31
	li 29,1
	lwz 9,84(31)
	stw 30,1792(9)
	bl ChangeWeapon
	lis 4,.LC0@ha
	lis 9,gi+44@ha
	stw 30,248(31)
	la 4,.LC0@l(4)
	stw 29,260(31)
	mr 3,31
	stw 4,268(31)
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	li 0,-1
	stw 29,1788(9)
	lwz 11,84(31)
	stw 29,3464(11)
	lwz 10,84(31)
	stw 0,3472(10)
	lwz 9,84(31)
	stw 30,3476(9)
	lwz 11,84(31)
	stw 30,3480(11)
	lwz 9,84(31)
	stw 30,3484(9)
	lwz 11,84(31)
	stw 30,3488(11)
.L20:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe28:
	.size	 Cmd_BecomeSpectator_f,.Lfe28-Cmd_BecomeSpectator_f
	.align 2
	.globl Cmd_Contact_f
	.type	 Cmd_Contact_f,@function
Cmd_Contact_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,adminname@ha
	lis 11,email@ha
	lwz 8,adminname@l(9)
	lis 10,gi+8@ha
	lis 5,.LC18@ha
	lwz 9,email@l(11)
	la 5,.LC18@l(5)
	li 4,1
	lwz 0,gi+8@l(10)
	lwz 6,4(8)
	lwz 7,4(9)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe29:
	.size	 Cmd_Contact_f,.Lfe29-Cmd_Contact_f
	.align 2
	.globl Cmd_Disable_f
	.type	 Cmd_Disable_f,@function
Cmd_Disable_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+8@ha
	lis 5,.LC19@ha
	lwz 0,gi+8@l(9)
	la 5,.LC19@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe30:
	.size	 Cmd_Disable_f,.Lfe30-Cmd_Disable_f
	.align 2
	.globl DisplayMOTD
	.type	 DisplayMOTD,@function
DisplayMOTD:
	stwu 1,-640(1)
	mflr 0
	stmw 28,624(1)
	stw 0,644(1)
	lis 9,motd1@ha
	lis 11,motd2@ha
	lwz 10,motd1@l(9)
	lis 6,.LC52@ha
	addi 31,1,8
	lwz 8,motd2@l(11)
	la 9,.LC52@l(6)
	mr 28,3
	lwz 30,4(10)
	lis 4,.LC53@ha
	mr 3,31
	lwz 7,.LC52@l(6)
	la 4,.LC53@l(4)
	lwz 29,4(8)
	lwz 5,20(9)
	lwz 0,4(9)
	lwz 11,8(9)
	lwz 10,12(9)
	lwz 8,16(9)
	stw 7,8(1)
	stw 0,4(31)
	stw 11,8(31)
	stw 10,12(31)
	stw 8,16(31)
	stw 5,20(31)
	bl strcat
	lis 4,.LC54@ha
	mr 3,31
	la 4,.LC54@l(4)
	bl strcat
	lis 4,.LC55@ha
	mr 3,31
	la 4,.LC55@l(4)
	bl strcat
	cmpwi 0,30,0
	bc 12,2,.L76
	mr 4,30
	mr 3,31
	bl strcat
.L76:
	cmpwi 0,29,0
	bc 12,2,.L77
	lis 4,.LC11@ha
	mr 3,31
	la 4,.LC11@l(4)
	bl strcat
	mr 4,29
	mr 3,31
	bl strcat
.L77:
	lis 9,gi+12@ha
	mr 3,28
	lwz 0,gi+12@l(9)
	mr 4,31
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,644(1)
	mtlr 0
	lmw 28,624(1)
	la 1,640(1)
	blr
.Lfe31:
	.size	 DisplayMOTD,.Lfe31-DisplayMOTD
	.section	".rodata"
	.align 2
.LC325:
	.long 0x41700000
	.section	".text"
	.align 2
	.globl Cmd_Endmatch_f
	.type	 Cmd_Endmatch_f,@function
Cmd_Endmatch_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,compmod+4@ha
	mr 31,3
	lwz 0,compmod+4@l(9)
	cmpwi 0,0,2
	bc 4,2,.L94
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 12,2,.L96
	bl EndMatch
	b .L94
.L96:
	bl FindVote
	mr. 30,3
	bc 12,2,.L98
	lis 9,gi+8@ha
	lis 5,.LC67@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC67@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L94
.L98:
	bl G_Spawn
	lis 9,.LC68@ha
	mr 11,3
	la 9,.LC68@l(9)
	li 0,3
	stw 30,480(11)
	stw 9,280(11)
	lis 8,level+4@ha
	lis 10,VoteThink@ha
	lis 9,.LC325@ha
	stw 0,264(11)
	la 10,VoteThink@l(10)
	la 9,.LC325@l(9)
	stw 30,400(11)
	mr 3,31
	lfs 13,0(9)
	li 4,1
	lwz 9,84(31)
	addi 9,9,700
	stw 9,296(11)
	lfs 0,level+4@l(8)
	stw 10,436(11)
	fadds 0,0,13
	stfs 0,428(11)
	bl Cmd_Vote_f
.L94:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe32:
	.size	 Cmd_Endmatch_f,.Lfe32-Cmd_Endmatch_f
	.align 2
	.globl Cmd_ModeSet_f
	.type	 Cmd_ModeSet_f,@function
Cmd_ModeSet_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl MatchInProgress
	cmpwi 0,3,0
	bc 4,2,.L141
	mr 3,31
	bl NotAnAdmin
	mr. 3,3
	bc 4,2,.L141
	lis 9,compmod@ha
	la 9,compmod@l(9)
	lwz 6,4(9)
	cmpwi 0,6,0
	bc 4,2,.L144
	li 0,1
	stw 0,4(9)
	bl RestartServer
	b .L141
.L144:
	cmpwi 0,6,1
	bc 4,2,.L146
	stw 3,4(9)
	bl RestartServer
	b .L141
.L146:
	lis 9,gi+8@ha
	lis 5,.LC98@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC98@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L141:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe33:
	.size	 Cmd_ModeSet_f,.Lfe33-Cmd_ModeSet_f
	.align 2
	.globl Cmd_Normal_f
	.type	 Cmd_Normal_f,@function
Cmd_Normal_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	lwz 9,84(10)
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 12,2,.L148
	li 0,0
	lis 11,gi@ha
	stw 0,3456(9)
	lis 4,.LC99@ha
	li 3,1
	lwz 9,84(10)
	la 4,.LC99@l(4)
	stw 0,3460(9)
	lwz 5,84(10)
	lwz 0,gi@l(11)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
.L148:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe34:
	.size	 Cmd_Normal_f,.Lfe34-Cmd_Normal_f
	.align 2
	.globl Cmd_NotReady_f
	.type	 Cmd_NotReady_f,@function
Cmd_NotReady_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,compmod+4@ha
	mr 31,3
	lwz 0,compmod+4@l(9)
	li 3,0
	cmpwi 0,0,2
	bc 4,2,.L152
	lis 9,gi+8@ha
	lis 5,.LC100@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC100@l(5)
	b .L540
.L152:
	cmpwi 0,0,0
	bc 4,2,.L153
	lis 9,gi+8@ha
	lis 5,.LC101@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC101@l(5)
	b .L540
.L153:
	lwz 9,84(31)
	lwz 0,3472(9)
	cmpwi 0,0,-1
	bc 4,2,.L154
	lis 9,gi+8@ha
	lis 5,.LC102@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC102@l(5)
.L540:
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L151
.L154:
	lwz 0,3464(9)
	cmpwi 0,0,1
	bc 4,2,.L151
	stw 3,3464(9)
	lis 4,.LC103@ha
	lis 9,gi@ha
	lwz 5,84(31)
	la 4,.LC103@l(4)
	lwz 0,gi@l(9)
	li 3,1
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	lwz 3,3472(9)
	bl FindClan
	mr. 3,3
	bc 12,2,.L151
	lwz 9,400(3)
	addi 9,9,-1
	stw 9,400(3)
.L151:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe35:
	.size	 Cmd_NotReady_f,.Lfe35-Cmd_NotReady_f
	.align 2
	.globl Cmd_Restart_f
	.type	 Cmd_Restart_f,@function
Cmd_Restart_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl MatchInProgress
	cmpwi 0,3,0
	bc 4,2,.L191
	mr 3,31
	bl NotAnAdmin
	cmpwi 0,3,0
	bc 4,2,.L191
	bl RestartServer
.L191:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe36:
	.size	 Cmd_Restart_f,.Lfe36-Cmd_Restart_f
	.align 2
	.globl Cmd_Vote_f
	.type	 Cmd_Vote_f,@function
Cmd_Vote_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	bl FindVote
	mr. 3,3
	bc 4,2,.L230
	lis 9,gi+8@ha
	lis 5,.LC156@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC156@l(5)
	b .L541
.L230:
	lwz 9,84(31)
	lwz 0,3468(9)
	cmpwi 0,0,0
	bc 12,2,.L231
	lis 9,gi+8@ha
	lis 5,.LC157@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC157@l(5)
.L541:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L229
.L231:
	cmpwi 0,30,1
	bc 4,2,.L232
	li 0,2
	stw 0,3468(9)
	lwz 9,400(3)
	addi 9,9,1
	stw 9,400(3)
	b .L233
.L232:
	cmpwi 0,30,0
	bc 12,2,.L234
	lis 9,gi+4@ha
	lis 3,.LC158@ha
	lwz 0,gi+4@l(9)
	la 3,.LC158@l(3)
	mr 4,30
	mtlr 0
	crxor 6,6,6
	blrl
	b .L229
.L234:
	li 0,1
	stw 0,3468(9)
	lwz 9,480(3)
	addi 9,9,1
	stw 9,480(3)
.L233:
	bl EvaluateVote
.L229:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe37:
	.size	 Cmd_Vote_f,.Lfe37-Cmd_Vote_f
	.align 2
	.globl StuffCommand
	.type	 StuffCommand,@function
StuffCommand:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,11
	lwz 9,100(29)
	mr 28,4
	mtlr 9
	blrl
	lwz 9,116(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,27
	li 4,1
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe38:
	.size	 StuffCommand,.Lfe38-StuffCommand
	.align 2
	.globl MatchInProgress
	.type	 MatchInProgress,@function
MatchInProgress:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,compmod+4@ha
	lwz 9,compmod+4@l(11)
	addi 9,9,-2
	cmplwi 0,9,1
	bc 4,1,.L270
	li 3,0
	b .L542
.L270:
	lis 9,gi+8@ha
	lis 5,.LC257@ha
	lwz 0,gi+8@l(9)
	la 5,.LC257@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,1
.L542:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe39:
	.size	 MatchInProgress,.Lfe39-MatchInProgress
	.align 2
	.globl NotAnAdmin
	.type	 NotAnAdmin,@function
NotAnAdmin:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr. 31,3
	bc 12,2,.L273
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 4,2,.L274
	lis 29,gi@ha
	lis 5,.LC1@ha
	la 29,gi@l(29)
	la 5,.LC1@l(5)
	lwz 9,8(29)
	mr 3,31
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC2@ha
	mr 3,31
	la 5,.LC2@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC3@ha
	mr 3,31
	la 5,.LC3@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,1
	b .L543
.L274:
.L273:
	li 3,0
.L543:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe40:
	.size	 NotAnAdmin,.Lfe40-NotAnAdmin
	.align 2
	.globl MakeClan
	.type	 MakeClan,@function
MakeClan:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl G_Spawn
	lis 11,.LC12@ha
	mr 9,3
	li 0,0
	la 11,.LC12@l(11)
	stw 29,264(9)
	stw 11,280(9)
	stw 0,492(9)
	stw 0,400(9)
	stw 0,480(9)
	stw 0,484(9)
	stw 0,488(9)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe41:
	.size	 MakeClan,.Lfe41-MakeClan
	.align 2
	.globl FindClan
	.type	 FindClan,@function
FindClan:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	li 9,0
	b .L279
.L281:
	lwz 0,264(9)
	mr 3,9
	cmpw 0,0,31
	bc 12,2,.L544
.L279:
	lis 5,.LC12@ha
	mr 3,9
	la 5,.LC12@l(5)
	li 4,280
	bl G_Find
	mr. 9,3
	bc 4,2,.L281
	li 3,0
.L544:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe42:
	.size	 FindClan,.Lfe42-FindClan
	.section	".rodata"
	.align 2
.LC326:
	.long 0x44160000
	.align 2
.LC327:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl SpawnTimer
	.type	 SpawnTimer,@function
SpawnTimer:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl FindTimer
	cmpwi 0,3,0
	bc 4,2,.L284
	bl G_Spawn
	lis 9,.LC258@ha
	lis 11,level@ha
	la 9,.LC258@l(9)
	la 11,level@l(11)
	stw 9,280(3)
	lis 9,.LC326@ha
	lfs 13,4(11)
	la 9,.LC326@l(9)
	lfs 0,0(9)
	lis 9,.LC327@ha
	la 9,.LC327@l(9)
	fadds 13,13,0
	lfs 12,0(9)
	lis 9,TimerThink@ha
	la 9,TimerThink@l(9)
	stfs 13,288(3)
	lfs 0,4(11)
	stw 9,436(3)
	fadds 0,0,12
	stfs 0,428(3)
.L284:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe43:
	.size	 SpawnTimer,.Lfe43-SpawnTimer
	.align 2
	.globl FindTimer
	.type	 FindTimer,@function
FindTimer:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 5,.LC258@ha
	li 3,0
	la 5,.LC258@l(5)
	li 4,280
	bl G_Find
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and 3,3,0
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe44:
	.size	 FindTimer,.Lfe44-FindTimer
	.align 2
	.globl AllReady
	.type	 AllReady,@function
AllReady:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	li 3,0
	li 31,0
	lis 30,.LC107@ha
.L337:
	li 4,280
	la 5,.LC107@l(30)
	bl G_Find
	mr. 3,3
	bc 12,2,.L335
	lwz 9,84(3)
	lwz 0,3464(9)
	cmpwi 0,0,0
	bc 4,2,.L337
	li 31,1
.L335:
	cmpwi 0,31,0
	bc 4,2,.L339
	li 3,0
	bl PlayerCount
	cmpwi 0,3,0
	bc 4,2,.L338
.L339:
	li 3,0
	b .L546
.L338:
	li 3,1
.L546:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe45:
	.size	 AllReady,.Lfe45-AllReady
	.align 2
	.globl RestartServer
	.type	 RestartServer,@function
RestartServer:
	stwu 1,-272(1)
	mflr 0
	stw 0,276(1)
	lis 5,.LC214@ha
	lis 6,level+72@ha
	addi 3,1,8
	la 5,.LC214@l(5)
	la 6,level+72@l(6)
	li 4,256
	crxor 6,6,6
	bl Com_sprintf
	lis 9,gi+168@ha
	addi 3,1,8
	lwz 0,gi+168@l(9)
	mtlr 0
	blrl
	lwz 0,276(1)
	mtlr 0
	la 1,272(1)
	blr
.Lfe46:
	.size	 RestartServer,.Lfe46-RestartServer
	.align 2
	.globl UpdatePlayerStats
	.type	 UpdatePlayerStats,@function
UpdatePlayerStats:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 31,3
	mr 29,4
	lwz 11,84(31)
	mr 28,5
	mr 27,6
	mr 26,7
	lis 8,compmod+4@ha
	lwz 0,3476(11)
	add 0,0,29
	stw 0,3476(11)
	lwz 9,84(31)
	lwz 0,3480(9)
	add 0,0,28
	stw 0,3480(9)
	lwz 11,84(31)
	lwz 0,3484(11)
	add 0,0,27
	stw 0,3484(11)
	lwz 10,84(31)
	lwz 0,3488(10)
	add 0,0,26
	stw 0,3488(10)
	lwz 9,compmod+4@l(8)
	cmpwi 0,9,2
	bc 4,2,.L360
	lwz 9,84(31)
	li 3,0
	lwz 30,3472(9)
	b .L361
.L363:
	lwz 0,264(3)
	cmpw 0,0,30
	bc 12,2,.L365
.L361:
	lis 5,.LC12@ha
	li 4,280
	la 5,.LC12@l(5)
	bl G_Find
	mr. 3,3
	bc 4,2,.L363
	li 3,0
.L365:
	cmpwi 0,3,0
	bc 12,2,.L367
	lwz 9,480(3)
	lwz 11,484(3)
	lwz 10,488(3)
	add 9,9,29
	lwz 0,492(3)
	add 11,11,28
	add 10,10,27
	stw 9,480(3)
	add 0,0,26
	stw 11,484(3)
	stw 0,492(3)
	stw 10,488(3)
	b .L360
.L367:
	lis 9,gi+8@ha
	lis 5,.LC281@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC281@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L360:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe47:
	.size	 UpdatePlayerStats,.Lfe47-UpdatePlayerStats
	.align 2
	.globl DumpPlayerScore
	.type	 DumpPlayerScore,@function
DumpPlayerScore:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,compmod+4@ha
	mr 31,3
	lwz 0,compmod+4@l(9)
	cmpwi 0,0,0
	bc 12,2,.L369
	lis 29,gi@ha
	lis 5,.LC282@ha
	la 29,gi@l(29)
	la 5,.LC282@l(5)
	lwz 9,8(29)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC283@ha
	mr 3,31
	la 5,.LC283@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	lis 5,.LC284@ha
	mr 3,31
	lwz 0,8(29)
	la 5,.LC284@l(5)
	li 4,2
	lwz 9,3488(11)
	lwz 6,3476(11)
	mtlr 0
	lwz 7,3480(11)
	lwz 8,3484(11)
	crxor 6,6,6
	blrl
.L369:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe48:
	.size	 DumpPlayerScore,.Lfe48-DumpPlayerScore
	.section	".rodata"
	.align 3
.LC328:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl MakeClansUsed
	.type	 MakeClansUsed,@function
MakeClansUsed:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	li 31,0
	b .L383
.L385:
	bl G_Spawn
	lis 9,.LC13@ha
	lis 8,level+4@ha
	la 9,.LC13@l(9)
	lis 11,.LC328@ha
	stw 9,280(3)
	lis 10,G_FreeEdict@ha
	lwz 0,264(31)
	la 10,G_FreeEdict@l(10)
	lfd 13,.LC328@l(11)
	stw 0,264(3)
	lwz 9,400(31)
	stw 9,400(3)
	lwz 0,480(31)
	stw 0,480(3)
	lwz 9,484(31)
	stw 9,484(3)
	lwz 0,488(31)
	stw 0,488(3)
	lwz 9,492(31)
	stw 9,492(3)
	lfs 0,level+4@l(8)
	stw 10,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L383:
	lis 5,.LC12@ha
	mr 3,31
	la 5,.LC12@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L385
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe49:
	.size	 MakeClansUsed,.Lfe49-MakeClansUsed
	.align 2
	.globl AssignTeam
	.type	 AssignTeam,@function
AssignTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 9,team@ha
	mr 29,3
	la 9,team@l(9)
	li 28,0
	addi 30,9,13
	li 27,0
	li 31,1
	lis 26,.LC0@ha
.L427:
	mr 3,30
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L428
	mr 3,31
	b .L548
.L428:
	cmpwi 0,28,0
	bc 4,2,.L426
	mr 3,30
	la 4,.LC0@l(26)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L426
	li 28,1
	mr 27,31
.L426:
	addi 31,31,1
	addi 30,30,13
	cmpwi 0,31,16
	bc 4,1,.L427
	mulli 0,27,13
	lis 3,team@ha
	mr 4,29
	la 3,team@l(3)
	add 3,0,3
	bl strcpy
	mr 3,27
.L548:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe50:
	.size	 AssignTeam,.Lfe50-AssignTeam
	.align 2
	.globl ApplyToAllAdmins
	.type	 ApplyToAllAdmins,@function
ApplyToAllAdmins:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,3
	li 31,0
	b .L432
.L434:
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 12,2,.L432
	lis 9,gi+8@ha
	lis 5,.LC293@ha
	bc 4,30,.L436
	lwz 0,gi+8@l(9)
	la 5,.LC293@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L432
.L436:
	lis 9,gi+4@ha
	lis 3,.LC294@ha
	lwz 0,gi+4@l(9)
	mr 4,30
	la 3,.LC294@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L432:
	lis 5,.LC107@ha
	mr 3,31
	la 5,.LC107@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	cmpwi 7,30,0
	bc 4,2,.L434
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe51:
	.size	 ApplyToAllAdmins,.Lfe51-ApplyToAllAdmins
	.align 2
	.globl PlayerCount
	.type	 PlayerCount,@function
PlayerCount:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,3
	li 31,0
	li 3,0
	b .L451
.L453:
	lwz 9,84(3)
	cmpwi 0,9,0
	mr 11,9
	bc 12,2,.L451
	cmpwi 0,30,1
	bc 4,2,.L455
	lwz 0,3472(9)
	cmpwi 0,0,-1
	bc 4,2,.L549
.L455:
	cmpwi 0,30,2
	bc 4,2,.L457
	lwz 0,3472(11)
	cmpwi 0,0,-1
	bc 4,2,.L457
.L549:
	addi 31,31,1
	b .L451
.L457:
	srawi 9,30,31
	xor 0,9,30
	subf 0,0,9
	addi 9,31,1
	srawi 0,0,31
	andc 9,9,0
	and 0,31,0
	or 31,0,9
.L451:
	lis 5,.LC107@ha
	li 4,280
	la 5,.LC107@l(5)
	bl G_Find
	mr. 3,3
	bc 4,2,.L453
	mr 3,31
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe52:
	.size	 PlayerCount,.Lfe52-PlayerCount
	.section	".rodata"
	.align 2
.LC329:
	.long 0x3f800000
	.align 3
.LC330:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl TestPlayerCount
	.type	 TestPlayerCount,@function
TestPlayerCount:
	stwu 1,-16(1)
	lis 11,.LC329@ha
	lis 9,maxclients@ha
	la 11,.LC329@l(11)
	li 3,0
	lfs 0,0(11)
	li 10,1
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L463
	lis 9,g_edicts@ha
	fmr 12,13
	lis 8,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC330@ha
	la 9,.LC330@l(9)
	addi 11,11,892
	lfd 13,0(9)
.L465:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L464
	lwz 0,84(11)
	addi 9,3,1
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,3,0
	or 3,0,9
.L464:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,892
	stw 0,12(1)
	stw 8,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L465
.L463:
	la 1,16(1)
	blr
.Lfe53:
	.size	 TestPlayerCount,.Lfe53-TestPlayerCount
	.align 2
	.globl FindVote
	.type	 FindVote,@function
FindVote:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 5,.LC68@ha
	li 3,0
	la 5,.LC68@l(5)
	li 4,280
	bl G_Find
	srawi 9,3,31
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	and 3,3,0
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe54:
	.size	 FindVote,.Lfe54-FindVote
	.section	".rodata"
	.align 2
.LC331:
	.long 0x41700000
	.section	".text"
	.align 2
	.globl VoteThink
	.type	 VoteThink,@function
VoteThink:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC331@ha
	lis 9,level+4@ha
	la 11,.LC331@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	mr 11,3
	fadds 0,0,13
	stfs 0,428(11)
	bl EvaluateVote
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe55:
	.size	 VoteThink,.Lfe55-VoteThink
	.section	".rodata"
	.align 3
.LC332:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl KillVote
	.type	 KillVote,@function
KillVote:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	li 0,0
	stw 0,264(10)
	lis 11,level+4@ha
	lis 8,.LC332@ha
	lfs 0,level+4@l(11)
	lis 9,G_FreeEdict@ha
	li 3,5
	lfd 13,.LC332@l(8)
	la 9,G_FreeEdict@l(9)
	li 4,0
	stw 9,436(10)
	li 5,0
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(10)
	bl ApplyToAllPlayers
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe56:
	.size	 KillVote,.Lfe56-KillVote
	.align 2
	.globl CountClans
	.type	 CountClans,@function
CountClans:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	li 3,0
	li 31,0
	b .L509
.L511:
	lwz 0,400(3)
	addi 9,31,1
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,31,0
	or 31,0,9
.L509:
	lis 5,.LC12@ha
	li 4,280
	la 5,.LC12@l(5)
	bl G_Find
	mr. 3,3
	bc 4,2,.L511
	mr 3,31
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe57:
	.size	 CountClans,.Lfe57-CountClans
	.align 2
	.globl DisableFlagSet
	.type	 DisableFlagSet,@function
DisableFlagSet:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,compmod+4@ha
	mr 8,4
	lwz 0,compmod+4@l(9)
	cmpwi 0,0,0
	bc 4,2,.L515
	lis 11,ffadisable@ha
	lwz 9,ffadisable@l(11)
	b .L551
.L515:
	lis 11,matchdisable@ha
	lwz 9,matchdisable@l(11)
.L551:
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 4,28(1)
	cmpwi 0,3,0
	bc 4,2,.L517
	or 4,4,8
	b .L518
.L517:
	andc 4,4,8
.L518:
	lis 9,compmod+4@ha
	lwz 0,compmod+4@l(9)
	cmpwi 0,0,0
	bc 4,2,.L519
	lis 29,gi@ha
	lis 3,.LC58@ha
	la 29,gi@l(29)
	la 3,.LC58@l(3)
	crxor 6,6,6
	bl va
	mr 4,3
	lwz 0,148(29)
	lis 3,.LC311@ha
	la 3,.LC311@l(3)
	mtlr 0
	blrl
	b .L520
.L519:
	lis 29,gi@ha
	lis 3,.LC58@ha
	la 29,gi@l(29)
	la 3,.LC58@l(3)
	crxor 6,6,6
	bl va
	mr 4,3
	lwz 0,148(29)
	lis 3,.LC312@ha
	la 3,.LC312@l(3)
	mtlr 0
	blrl
.L520:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe58:
	.size	 DisableFlagSet,.Lfe58-DisableFlagSet
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
