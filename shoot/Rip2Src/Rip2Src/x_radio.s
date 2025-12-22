	.file	"x_radio.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Access to radio has been denided by team master\n"
	.align 2
.LC1:
	.string	"radio_power is %i\n"
	.align 2
.LC2:
	.string	"0"
	.align 2
.LC3:
	.string	"off"
	.align 2
.LC4:
	.string	"Radio ON\n"
	.align 2
.LC5:
	.string	"Radio OFF\n"
	.align 2
.LC6:
	.string	""
	.string	""
	.align 2
.LC7:
	.string	";"
	.align 2
.LC8:
	.string	"Name the file to play!\n"
	.align 2
.LC9:
	.string	"radio/%s.wav"
	.align 2
.LC10:
	.string	"TEAM"
	.align 2
.LC11:
	.string	"Incoming message from %s\n"
	.align 2
.LC12:
	.long 0x3f800000
	.align 2
.LC13:
	.long 0x0
	.align 3
.LC14:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl X_Radio_f
	.type	 X_Radio_f,@function
X_Radio_f:
	stwu 1,-96(1)
	mflr 0
	stmw 28,80(1)
	stw 0,100(1)
	mr 30,4
	mr 31,5
	mr 29,3
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	mr 3,31
	bl strstr
	mr. 3,3
	bc 12,2,.L15
	li 0,0
	stb 0,0(3)
.L15:
	lwz 0,928(29)
	andi. 9,0,6
	bc 12,2,.L16
	lis 9,gi+8@ha
	lis 5,.LC0@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC0@l(5)
	b .L30
.L16:
	mr 3,31
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L17
	lis 9,gi+8@ha
	lis 5,.LC8@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC8@l(5)
.L30:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L14
.L17:
	lis 4,.LC9@ha
	mr 5,31
	la 4,.LC9@l(4)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	lis 4,.LC10@ha
	mr 3,30
	la 4,.LC10@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L14
	li 28,1
	b .L19
.L24:
	lwz 10,84(31)
	lwz 9,84(29)
	lwz 11,1820(10)
	lwz 0,1820(9)
	cmpw 0,11,0
	bc 12,2,.L26
	lwz 0,892(31)
	cmpwi 0,0,3
	bc 4,2,.L21
.L26:
	lwz 0,1796(10)
	cmpwi 0,0,0
	bc 12,2,.L21
	lis 9,gi@ha
	addi 3,1,8
	la 30,gi@l(9)
	lwz 9,36(30)
	mtlr 9
	blrl
	lis 9,.LC12@ha
	lwz 11,16(30)
	mr 5,3
	la 9,.LC12@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 11
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 2,0(9)
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	lfs 3,0(9)
	blrl
	cmpw 0,31,29
	bc 12,2,.L21
	lwz 6,84(29)
	lis 5,.LC11@ha
	mr 3,31
	lwz 0,8(30)
	la 5,.LC11@l(5)
	li 4,2
	addi 6,6,700
	mtlr 0
	crxor 6,6,6
	blrl
.L21:
	addi 28,28,1
.L19:
	xoris 0,28,0x8000
	lis 9,0x4330
	stw 0,76(1)
	lis 11,.LC14@ha
	la 11,.LC14@l(11)
	stw 9,72(1)
	lfd 12,0(11)
	lfd 0,72(1)
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	fsub 0,0,12
	lfs 13,20(9)
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L14
	lis 11,g_edicts@ha
	mulli 9,28,1116
	lwz 0,g_edicts@l(11)
	add. 31,0,9
	bc 12,2,.L21
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L21
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 4,2,.L24
.L14:
	lwz 0,100(1)
	mtlr 0
	lmw 28,80(1)
	la 1,96(1)
	blr
.Lfe1:
	.size	 X_Radio_f,.Lfe1-X_Radio_f
	.section	".rodata"
	.align 2
.LC15:
	.string	"Name the .wav file to play!\n"
	.align 2
.LC16:
	.string	"%s is dead\n"
	.align 2
.LC17:
	.string	"%s's radio is off\n"
	.align 2
.LC18:
	.string	"%s is playing in another team!\n"
	.align 2
.LC19:
	.string	"No such player : %s\n"
	.align 2
.LC20:
	.long 0x3f800000
	.align 2
.LC21:
	.long 0x0
	.section	".text"
	.align 2
	.globl Radio_Player
	.type	 Radio_Player,@function
Radio_Player:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,5
	mr 28,3
	mr 31,4
	mr 3,29
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L32
	lis 9,gi+8@ha
	lis 5,.LC15@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC15@l(5)
	b .L41
.L32:
	lwz 0,928(28)
	andi. 9,0,6
	bc 12,2,.L33
	lis 9,gi+8@ha
	lis 5,.LC0@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC0@l(5)
.L41:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L31
.L33:
	cmpwi 0,31,0
	bc 12,2,.L34
	lwz 9,84(28)
	lwz 6,84(31)
	lwz 11,1820(9)
	lwz 0,1820(6)
	cmpw 0,11,0
	bc 4,2,.L35
	lwz 0,1796(6)
	cmpwi 0,0,0
	bc 12,2,.L36
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 4,2,.L37
	lis 9,gi+8@ha
	lis 5,.LC16@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC16@l(5)
	b .L42
.L37:
	lis 28,.LC6@ha
	lis 4,.LC9@ha
	la 28,.LC6@l(28)
	mr 5,29
	la 4,.LC9@l(4)
	mr 3,28
	crxor 6,6,6
	bl sprintf
	lis 29,gi@ha
	mr 3,28
	la 29,gi@l(29)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC20@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC20@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 2,0(9)
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 3,0(9)
	blrl
	b .L31
.L36:
	lis 9,gi+8@ha
	lis 5,.LC17@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC17@l(5)
	b .L42
.L35:
	lis 9,gi+8@ha
	lis 5,.LC18@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC18@l(5)
.L42:
	addi 6,6,700
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L31
.L34:
	lis 29,gi@ha
	li 3,1
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	lwz 0,8(29)
	mr 6,3
	lis 5,.LC19@ha
	mr 3,28
	la 5,.LC19@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L31:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Radio_Player,.Lfe2-Radio_Player
	.section	".rodata"
	.align 2
.LC22:
	.string	"Victim is not fully in the game\n"
	.align 2
.LC23:
	.string	"You are not a team master!\n"
	.align 2
.LC24:
	.string	"Name the player!\n"
	.align 2
.LC25:
	.string	"Your radio has been disabled by team master!\n"
	.align 2
.LC26:
	.string	"No such player: %s\n"
	.section	".text"
	.align 2
	.globl TeamMasterCanOffPlayersRadio
	.type	 TeamMasterCanOffPlayersRadio,@function
TeamMasterCanOffPlayersRadio:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,4
	mr 30,3
	mr 3,29
	bl ent_by_name
	mr 31,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L45
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 4,2,.L44
.L45:
	lis 9,gi+8@ha
	lis 5,.LC22@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC22@l(5)
	li 4,2
	b .L52
.L44:
	lwz 0,1112(30)
	cmpwi 0,0,0
	bc 4,2,.L46
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC23@l(5)
	li 4,2
	b .L52
.L46:
	mr 3,29
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L47
	lis 9,gi+8@ha
	lis 5,.LC24@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC24@l(5)
	li 4,2
	b .L52
.L47:
	cmpwi 0,31,0
	bc 12,2,.L48
	lwz 6,84(31)
	lwz 9,84(30)
	lwz 11,1820(6)
	lwz 0,1820(9)
	cmpw 0,11,0
	bc 4,2,.L49
	li 0,0
	lis 9,gi+8@ha
	stw 0,1796(6)
	lis 5,.LC25@ha
	mr 3,31
	lwz 0,928(31)
	la 5,.LC25@l(5)
	li 4,2
	ori 0,0,6
	stw 0,928(31)
	lwz 0,gi+8@l(9)
.L52:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L43
.L49:
	lis 9,gi+8@ha
	lis 5,.LC18@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC18@l(5)
	addi 6,6,700
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L43
.L48:
	lis 9,gi+8@ha
	lis 5,.LC26@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC26@l(5)
	mr 6,29
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L43:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 TeamMasterCanOffPlayersRadio,.Lfe3-TeamMasterCanOffPlayersRadio
	.section	".rodata"
	.align 2
.LC27:
	.string	"You can't kick yourself!\n"
	.align 2
.LC28:
	.string	"You have been kicked by teammaster\n"
	.align 2
.LC29:
	.string	"%s was kicked by team master\n"
	.align 2
.LC30:
	.string	"disconnect\n"
	.section	".text"
	.align 2
	.globl TeamMasterCanKickPlayer
	.type	 TeamMasterCanKickPlayer,@function
TeamMasterCanKickPlayer:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,4
	mr 29,3
	mr 3,30
	bl ent_by_name
	mr 31,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L55
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 4,2,.L54
.L55:
	lis 9,gi+8@ha
	lis 5,.LC22@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC22@l(5)
	b .L63
.L54:
	lwz 0,1112(29)
	cmpwi 0,0,0
	bc 4,2,.L56
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC23@l(5)
	b .L63
.L56:
	mr 3,30
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L57
	lis 9,gi+8@ha
	lis 5,.LC24@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC24@l(5)
	b .L63
.L57:
	cmpw 0,31,29
	bc 4,2,.L58
	lis 9,gi+8@ha
	lis 5,.LC27@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC27@l(5)
.L63:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L53
.L58:
	cmpwi 0,31,0
	bc 12,2,.L59
	lwz 6,84(31)
	lwz 9,84(29)
	lwz 11,1820(6)
	lwz 0,1820(9)
	cmpw 0,11,0
	bc 4,2,.L60
	lis 29,gi@ha
	lis 5,.LC28@ha
	la 9,gi@l(29)
	la 5,.LC28@l(5)
	lwz 0,8(9)
	li 4,2
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 5,84(31)
	lis 4,.LC29@ha
	li 3,2
	lwz 0,gi@l(29)
	la 4,.LC29@l(4)
	addi 5,5,700
	mtlr 0
	crxor 6,6,6
	blrl
	lis 4,.LC30@ha
	mr 3,31
	la 4,.LC30@l(4)
	bl stuffcmd
	b .L53
.L60:
	lis 9,gi+8@ha
	lis 5,.LC18@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC18@l(5)
	addi 6,6,700
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L53
.L59:
	lis 9,gi+8@ha
	lis 5,.LC26@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC26@l(5)
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L53:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 TeamMasterCanKickPlayer,.Lfe4-TeamMasterCanKickPlayer
	.section	".rodata"
	.align 2
.LC31:
	.string	"You can't talk now!\n"
	.section	".text"
	.align 2
	.globl TeamMasterCanShutUpPlayer
	.type	 TeamMasterCanShutUpPlayer,@function
TeamMasterCanShutUpPlayer:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,4
	mr 30,3
	mr 3,29
	bl ent_by_name
	mr 31,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L66
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 4,2,.L65
.L66:
	lis 9,gi+8@ha
	lis 5,.LC22@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC22@l(5)
	b .L73
.L65:
	lwz 0,1112(30)
	cmpwi 0,0,0
	bc 4,2,.L67
	lis 9,gi+8@ha
	lis 5,.LC23@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC23@l(5)
	b .L73
.L67:
	mr 3,29
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L68
	lis 9,gi+8@ha
	lis 5,.LC24@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC24@l(5)
.L73:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L64
.L68:
	cmpwi 0,31,0
	bc 12,2,.L69
	lwz 6,84(31)
	lwz 9,84(30)
	lwz 11,1820(6)
	lwz 0,1820(9)
	cmpw 0,11,0
	bc 4,2,.L70
	lis 9,gi+8@ha
	lis 5,.LC31@ha
	lwz 0,gi+8@l(9)
	la 5,.LC31@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,928(31)
	ori 0,0,8
	stw 0,928(31)
	b .L64
.L70:
	lis 9,gi+8@ha
	lis 5,.LC18@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC18@l(5)
	addi 6,6,700
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L64
.L69:
	lis 9,gi+8@ha
	lis 5,.LC26@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC26@l(5)
	mr 6,29
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L64:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 TeamMasterCanShutUpPlayer,.Lfe5-TeamMasterCanShutUpPlayer
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.align 2
	.globl X_Radio_Power_f
	.type	 X_Radio_Power_f,@function
X_Radio_Power_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lwz 0,928(31)
	andi. 9,0,6
	bc 12,2,.L7
	lis 9,gi+8@ha
	lis 5,.LC0@ha
	lwz 0,gi+8@l(9)
	la 5,.LC0@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L7:
	mr 3,30
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L8
	lis 11,gi+8@ha
	lwz 9,84(31)
	lis 5,.LC1@ha
	lwz 0,gi+8@l(11)
	mr 3,31
	la 5,.LC1@l(5)
	lwz 6,1796(9)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L8:
	lis 4,.LC2@ha
	mr 3,30
	la 4,.LC2@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L10
	lis 4,.LC3@ha
	mr 3,30
	la 4,.LC3@l(4)
	bl Q_stricmp
	mr. 30,3
	bc 12,2,.L9
.L10:
	lwz 9,84(31)
	lwz 0,1796(9)
	cmpwi 0,0,0
	bc 4,2,.L11
	lis 9,gi+8@ha
	lis 5,.LC4@ha
	lwz 0,gi+8@l(9)
	la 5,.LC4@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L11:
	lwz 9,84(31)
	li 0,1
	stw 0,1796(9)
	b .L6
.L9:
	lwz 9,84(31)
	lwz 0,1796(9)
	cmpwi 0,0,0
	bc 12,2,.L13
	lis 9,gi+8@ha
	lis 5,.LC5@ha
	lwz 0,gi+8@l(9)
	la 5,.LC5@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L13:
	lwz 9,84(31)
	stw 30,1796(9)
.L6:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 X_Radio_Power_f,.Lfe6-X_Radio_Power_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
