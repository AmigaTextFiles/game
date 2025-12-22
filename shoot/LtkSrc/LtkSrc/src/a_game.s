	.file	"a_game.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"ininame"
	.align 2
.LC1:
	.string	"action.ini"
	.align 2
.LC2:
	.string	"%s/%s"
	.align 2
.LC3:
	.string	"action"
	.align 2
.LC4:
	.string	"r"
	.align 2
.LC5:
	.string	"Unable to read %s\n"
	.align 2
.LC6:
	.string	"team1"
	.align 2
.LC7:
	.string	"team2"
	.align 2
.LC8:
	.string	"maplist"
	.align 2
.LC9:
	.string	"../players/%s_i"
	.section	".text"
	.align 2
	.globl ReadConfigFile
	.type	 ReadConfigFile,@function
ReadConfigFile:
	stwu 1,-3056(1)
	mflr 0
	stmw 28,3040(1)
	stw 0,3060(1)
	lis 9,gi+144@ha
	lis 3,.LC0@ha
	lwz 0,gi+144@l(9)
	lis 4,.LC1@ha
	la 3,.LC0@l(3)
	la 4,.LC1@l(4)
	li 5,0
	mtlr 0
	li 31,-1
	blrl
	lwz 6,4(3)
	cmpwi 0,6,0
	bc 12,2,.L7
	lbz 0,0(6)
	cmpwi 0,0,0
	bc 12,2,.L7
	addi 0,1,2024
	lis 4,.LC2@ha
	lis 5,.LC3@ha
	la 4,.LC2@l(4)
	la 5,.LC3@l(5)
	mr 3,0
	mr 29,0
	crxor 6,6,6
	bl sprintf
	b .L8
.L7:
	addi 29,1,2024
	lis 4,.LC2@ha
	lis 5,.LC3@ha
	lis 6,.LC1@ha
	la 4,.LC2@l(4)
	la 5,.LC3@l(5)
	la 6,.LC1@l(6)
	mr 3,29
	crxor 6,6,6
	bl sprintf
.L8:
	lis 4,.LC4@ha
	mr 3,29
	la 4,.LC4@l(4)
	bl fopen
	mr. 30,3
	bc 4,2,.L10
	lis 9,gi+4@ha
	lis 3,.LC5@ha
	lwz 0,gi+4@l(9)
	la 3,.LC5@l(3)
	mr 4,29
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L12:
	addi 3,1,8
	bl strlen
	addi 3,3,-1
	addi 10,1,8
	lbzx 0,10,3
	xori 9,0,10
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,13
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L14
	li 8,0
.L15:
	stbx 8,10,3
	mr 9,10
	addi 3,3,-1
	lbzx 0,9,3
	xori 11,0,10
	subfic 9,11,0
	adde 11,9,11
	xori 0,0,13
	subfic 9,0,0
	adde 0,9,0
	or. 9,0,11
	bc 4,2,.L15
.L14:
	lbz 9,8(1)
	cmpwi 0,9,47
	bc 4,2,.L19
	lbz 0,9(1)
	cmpwi 0,0,47
	bc 12,2,.L10
.L19:
	cmpwi 0,9,0
	bc 12,2,.L10
	cmpwi 0,9,91
	bc 4,2,.L20
	addi 3,1,8
	li 4,93
	bl strchr
	mr. 9,3
	bc 12,2,.L10
	li 0,0
	addi 3,1,1016
	stb 0,0(9)
	addi 4,1,9
	li 31,0
	bl strcpy
	b .L10
.L20:
	cmpwi 0,9,35
	bc 4,2,.L22
	lbz 0,9(1)
	cmpwi 0,0,35
	bc 4,2,.L22
	lbz 0,10(1)
	cmpwi 0,0,35
	bc 4,2,.L22
	li 31,-1
	b .L10
.L22:
	cmpwi 0,31,-1
	bc 4,1,.L10
	addi 29,1,1016
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	mr 3,29
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L24
	cmpwi 0,31,0
	bc 4,2,.L25
	lis 3,team1_name@ha
	addi 4,1,8
	la 3,team1_name@l(3)
	bl strcpy
	b .L28
.L25:
	cmpwi 0,31,1
	bc 4,2,.L28
	lis 3,team1_skin@ha
	addi 4,1,8
	la 3,team1_skin@l(3)
	bl strcpy
	b .L28
.L24:
	lis 4,.LC7@ha
	mr 3,29
	la 4,.LC7@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L29
	cmpwi 0,31,0
	bc 4,2,.L30
	lis 3,team2_name@ha
	addi 4,1,8
	la 3,team2_name@l(3)
	bl strcpy
	b .L28
.L30:
	cmpwi 0,31,1
	bc 4,2,.L28
	lis 3,team2_skin@ha
	addi 4,1,8
	la 3,team2_skin@l(3)
	bl strcpy
	b .L28
.L29:
	lis 4,.LC8@ha
	mr 3,29
	la 4,.LC8@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L28
	lis 29,gi@ha
	addi 3,1,8
	la 29,gi@l(29)
	lis 28,num_maps@ha
	bl strlen
	lwz 0,132(29)
	li 4,765
	addi 3,3,1
	mtlr 0
	blrl
	lwz 0,num_maps@l(28)
	lis 9,map_rotation@ha
	mr 11,3
	la 9,map_rotation@l(9)
	slwi 0,0,2
	addi 4,1,8
	stwx 11,9,0
	bl strcpy
	lwz 9,num_maps@l(28)
	addi 9,9,1
	stw 9,num_maps@l(28)
.L28:
	addi 31,31,1
.L10:
	addi 3,1,8
	li 4,990
	mr 5,30
	bl fgets
	mr. 28,3
	bc 4,2,.L12
	lis 29,.LC9@ha
	lis 3,team1_skin_index@ha
	lis 5,team1_skin@ha
	la 4,.LC9@l(29)
	la 5,team1_skin@l(5)
	la 3,team1_skin_index@l(3)
	crxor 6,6,6
	bl sprintf
	lis 3,team2_skin_index@ha
	lis 5,team2_skin@ha
	la 3,team2_skin_index@l(3)
	la 4,.LC9@l(29)
	la 5,team2_skin@l(5)
	crxor 6,6,6
	bl sprintf
	lis 9,cur_map@ha
	mr 3,30
	stw 28,cur_map@l(9)
	bl fclose
.L6:
	lwz 0,3060(1)
	mtlr 0
	lmw 28,3040(1)
	la 1,3056(1)
	blr
.Lfe1:
	.size	 ReadConfigFile,.Lfe1-ReadConfigFile
	.section	".rodata"
	.align 2
.LC10:
	.string	"action/motd.txt"
	.section	".text"
	.align 2
	.globl ReadMOTDFile
	.type	 ReadMOTDFile,@function
ReadMOTDFile:
	stwu 1,-1040(1)
	mflr 0
	stmw 27,1020(1)
	stw 0,1044(1)
	lis 3,.LC10@ha
	lis 4,.LC4@ha
	la 3,.LC10@l(3)
	la 4,.LC4@l(4)
	bl fopen
	mr. 30,3
	bc 12,2,.L36
	lis 9,motd_num_lines@ha
	li 0,0
	lis 11,motd_lines@ha
	stw 0,motd_num_lines@l(9)
	addi 27,1,8
	la 28,motd_lines@l(11)
	li 29,0
	lis 31,motd_num_lines@ha
.L46:
	addi 3,1,8
	li 4,900
	mr 5,30
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L39
	addi 3,1,8
	bl strlen
	mr 8,27
	addi 10,3,-1
	lbzx 0,8,10
	xori 9,0,10
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,13
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L42
	li 7,0
.L43:
	stbx 7,8,10
	mr 3,10
	mr 9,8
	addi 10,3,-1
	lbzx 0,9,10
	xori 11,0,10
	subfic 9,11,0
	adde 11,9,11
	xori 0,0,13
	subfic 9,0,0
	adde 0,9,0
	or. 9,0,11
	bc 4,2,.L43
.L42:
	cmpwi 0,3,40
	bc 4,1,.L45
	stb 29,48(1)
.L45:
	lwz 3,motd_num_lines@l(31)
	addi 4,1,8
	mulli 3,3,70
	add 3,3,28
	bl strcpy
	lwz 9,motd_num_lines@l(31)
	addi 9,9,1
	cmpwi 0,9,29
	stw 9,motd_num_lines@l(31)
	bc 4,1,.L46
.L39:
	mr 3,30
	bl fclose
.L36:
	lwz 0,1044(1)
	mtlr 0
	lmw 27,1020(1)
	la 1,1040(1)
	blr
.Lfe2:
	.size	 ReadMOTDFile,.Lfe2-ReadMOTDFile
	.section	".rodata"
	.align 2
.LC11:
	.string	"Welcome to Action Quake v1.52\nhttp://aq2.action-web.net/\n\n"
	.align 2
.LC12:
	.string	"unnamed"
	.align 2
.LC13:
	.string	"\n"
	.align 2
.LC14:
	.string	"teamplay"
	.align 2
.LC15:
	.string	"deathmatch (teams by model)"
	.align 2
.LC16:
	.string	"deathmatch (teams by skin)"
	.align 2
.LC17:
	.string	"deathmatch (no teams)"
	.align 2
.LC18:
	.string	"Game type: %s\n"
	.align 2
.LC19:
	.string	"Frag limit: %d"
	.align 2
.LC20:
	.string	"Frag limit: none"
	.align 2
.LC21:
	.string	" Time limit: %d\n"
	.align 2
.LC22:
	.string	" Time limit: none\n"
	.align 2
.LC23:
	.string	"Round limit: %d"
	.align 2
.LC24:
	.string	"Round limit: none"
	.align 2
.LC25:
	.string	" Round time limit: %d\n"
	.align 2
.LC26:
	.string	" Round time limit: none\n"
	.align 2
.LC27:
	.string	"Max carry of special weaps: %d items: %d\n"
	.align 2
.LC28:
	.string	"%d grenade%s"
	.align 2
.LC29:
	.string	""
	.align 2
.LC30:
	.string	"s"
	.align 2
.LC31:
	.string	"Bandolier w/ %s%s%s\n"
	.align 2
.LC32:
	.string	"no IR"
	.align 2
.LC33:
	.string	" & "
	.align 2
.LC34:
	.string	"Players receive %s%s%s\n"
	.align 2
.LC35:
	.string	"all weapons"
	.align 2
.LC36:
	.string	"all items"
	.align 2
.LC37:
	.string	"Chase cam disallowed\n"
	.align 2
.LC38:
	.string	"Chase cam restricted\n"
	.align 2
.LC39:
	.string	"Friendly fire enabled\n"
	.align 2
.LC40:
	.string	"\nHit tab to open the team selection menu\n"
	.align 2
.LC41:
	.string	"\nRunning the following maps in order:\n"
	.align 2
.LC42:
	.string	", "
	.align 2
.LC43:
	.long 0x0
	.section	".text"
	.align 2
	.globl PrintMOTD
	.type	 PrintMOTD,@function
PrintMOTD:
	stwu 1,-16480(1)
	mflr 0
	stfd 31,16472(1)
	stmw 25,16444(1)
	stw 0,16484(1)
	mr 25,3
	lis 4,.LC11@ha
	addi 3,1,8
	la 4,.LC11@l(4)
	mr 29,3
	li 5,59
	crxor 6,6,6
	bl memcpy
	li 27,3
	lis 26,motd_num_lines@ha
	lis 9,.LC43@ha
	lis 11,skipmotd@ha
	la 9,.LC43@l(9)
	lfs 13,0(9)
	lwz 9,skipmotd@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L48
	lis 31,hostname@ha
	lwz 9,hostname@l(31)
	lwz 3,4(9)
	cmpwi 0,3,0
	bc 12,2,.L49
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L49
	lwz 9,hostname@l(31)
	lis 4,.LC12@ha
	la 4,.LC12@l(4)
	lwz 3,4(9)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L49
	lwz 9,hostname@l(31)
	mr 3,29
	li 27,4
	lwz 4,4(9)
	bl strcat
	lis 4,.LC13@ha
	mr 3,29
	la 4,.LC13@l(4)
	bl strcat
.L49:
	lis 9,.LC43@ha
	lis 11,teamplay@ha
	la 9,.LC43@l(9)
	lfs 13,0(9)
	lwz 9,teamplay@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L50
	lis 9,.LC14@ha
	la 31,.LC14@l(9)
	b .L51
.L50:
	lis 11,dmflags@ha
	lwz 9,dmflags@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16432(1)
	lwz 0,16436(1)
	andi. 11,0,128
	bc 12,2,.L52
	lis 9,.LC15@ha
	la 31,.LC15@l(9)
	b .L51
.L52:
	andi. 9,0,64
	bc 12,2,.L54
	lis 9,.LC16@ha
	la 31,.LC16@l(9)
	b .L51
.L54:
	lis 9,.LC17@ha
	la 31,.LC17@l(9)
.L51:
	addi 3,1,8
	lis 30,fraglimit@ha
	bl strlen
	addi 27,27,1
	lis 4,.LC18@ha
	mr 5,31
	la 4,.LC18@l(4)
	add 3,29,3
	crxor 6,6,6
	bl sprintf
	lwz 11,fraglimit@l(30)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16432(1)
	lwz 9,16436(1)
	cmpwi 0,9,0
	bc 12,2,.L56
	mr 3,29
	bl strlen
	lwz 9,fraglimit@l(30)
	lis 4,.LC19@ha
	la 4,.LC19@l(4)
	add 3,29,3
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16432(1)
	lwz 5,16436(1)
	crxor 6,6,6
	bl sprintf
	b .L57
.L56:
	lis 4,.LC20@ha
	mr 3,29
	la 4,.LC20@l(4)
	bl strcat
.L57:
	lis 31,timelimit@ha
	lwz 9,timelimit@l(31)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16432(1)
	lwz 11,16436(1)
	cmpwi 0,11,0
	bc 12,2,.L58
	addi 3,1,8
	bl strlen
	lwz 9,timelimit@l(31)
	lis 4,.LC21@ha
	la 4,.LC21@l(4)
	add 3,29,3
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16432(1)
	lwz 5,16436(1)
	crxor 6,6,6
	bl sprintf
	b .L59
.L58:
	lis 4,.LC22@ha
	addi 3,1,8
	la 4,.LC22@l(4)
	bl strcat
.L59:
	lis 11,.LC43@ha
	lis 9,teamplay@ha
	la 11,.LC43@l(11)
	addi 27,27,1
	lfs 13,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L60
	lis 31,roundlimit@ha
	lwz 9,roundlimit@l(31)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16432(1)
	lwz 11,16436(1)
	cmpwi 0,11,0
	bc 12,2,.L61
	addi 3,1,8
	bl strlen
	lwz 9,roundlimit@l(31)
	lis 4,.LC23@ha
	la 4,.LC23@l(4)
	add 3,29,3
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16432(1)
	lwz 5,16436(1)
	crxor 6,6,6
	bl sprintf
	b .L62
.L61:
	lis 4,.LC24@ha
	addi 3,1,8
	la 4,.LC24@l(4)
	bl strcat
.L62:
	lis 31,roundtimelimit@ha
	lwz 9,roundtimelimit@l(31)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16432(1)
	lwz 11,16436(1)
	cmpwi 0,11,0
	bc 12,2,.L63
	addi 3,1,8
	bl strlen
	lwz 9,roundtimelimit@l(31)
	lis 4,.LC25@ha
	la 4,.LC25@l(4)
	add 3,29,3
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16432(1)
	lwz 5,16436(1)
	crxor 6,6,6
	bl sprintf
	b .L64
.L63:
	lis 4,.LC26@ha
	addi 3,1,8
	la 4,.LC26@l(4)
	bl strcat
.L64:
	addi 27,27,1
.L60:
	lis 31,unique_weapons@ha
	lwz 9,unique_weapons@l(31)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16432(1)
	lwz 11,16436(1)
	cmpwi 0,11,1
	bc 4,2,.L66
	lis 9,unique_items@ha
	lwz 11,unique_items@l(9)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16432(1)
	lwz 9,16436(1)
	cmpwi 0,9,1
	bc 12,2,.L65
.L66:
	addi 3,1,8
	addi 27,27,1
	bl strlen
	lwz 10,unique_weapons@l(31)
	lis 9,unique_items@ha
	lwz 11,unique_items@l(9)
	mr 6,5
	lis 4,.LC27@ha
	lfs 13,20(10)
	add 3,29,3
	la 4,.LC27@l(4)
	lfs 0,20(11)
	fctiwz 12,13
	fctiwz 11,0
	stfd 12,16432(1)
	lwz 5,16436(1)
	stfd 11,16432(1)
	lwz 6,16436(1)
	crxor 6,6,6
	bl sprintf
.L65:
	lis 9,.LC43@ha
	lis 11,tgren@ha
	la 9,.LC43@l(9)
	lfs 12,0(9)
	lwz 9,tgren@l(11)
	lfs 13,20(9)
	fcmpu 7,13,12
	bc 12,29,.L68
	lis 9,ir@ha
	lwz 11,ir@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 4,2,.L67
.L68:
	bc 4,29,.L69
	fmr 0,13
	addi 3,1,16392
	fctiwz 13,0
	stfd 13,16432(1)
	lwz 5,16436(1)
	cmpwi 0,5,1
	bc 4,2,.L70
	lis 9,.LC29@ha
	la 6,.LC29@l(9)
	b .L71
.L70:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
.L71:
	lis 4,.LC28@ha
	la 4,.LC28@l(4)
	crxor 6,6,6
	bl sprintf
.L69:
	addi 3,1,8
	bl strlen
	lis 9,ir@ha
	add 3,29,3
	lwz 11,ir@l(9)
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L72
	lis 9,.LC32@ha
	la 5,.LC32@l(9)
	b .L73
.L72:
	lis 9,.LC29@ha
	la 5,.LC29@l(9)
.L73:
	lis 11,.LC43@ha
	lis 9,tgren@ha
	la 11,.LC43@l(11)
	lfs 13,0(11)
	lwz 11,tgren@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,1,.L74
	lis 9,ir@ha
	lwz 11,ir@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L74
	lis 9,.LC33@ha
	la 6,.LC33@l(9)
	b .L75
.L74:
	lis 9,.LC29@ha
	la 6,.LC29@l(9)
.L75:
	lis 9,.LC43@ha
	lis 11,tgren@ha
	la 9,.LC43@l(9)
	lfs 13,0(9)
	lwz 9,tgren@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,1,.L76
	addi 7,1,16392
	b .L77
.L76:
	lis 9,.LC29@ha
	la 7,.LC29@l(9)
.L77:
	lis 4,.LC31@ha
	addi 27,27,1
	la 4,.LC31@l(4)
	crxor 6,6,6
	bl sprintf
.L67:
	lis 11,.LC43@ha
	lis 9,allitem@ha
	la 11,.LC43@l(11)
	lfs 31,0(11)
	lwz 11,allitem@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L79
	lis 9,allweapon@ha
	lwz 11,allweapon@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L78
.L79:
	addi 3,1,8
	bl strlen
	lis 9,allweapon@ha
	add 3,29,3
	lwz 11,allweapon@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L80
	lis 9,.LC35@ha
	la 5,.LC35@l(9)
	b .L81
.L80:
	lis 9,.LC29@ha
	la 5,.LC29@l(9)
.L81:
	lis 11,.LC43@ha
	lis 9,allweapon@ha
	la 11,.LC43@l(11)
	lfs 13,0(11)
	lwz 11,allweapon@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L82
	lis 9,allitem@ha
	lwz 11,allitem@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L82
	lis 9,.LC33@ha
	la 6,.LC33@l(9)
	b .L83
.L82:
	lis 9,.LC29@ha
	la 6,.LC29@l(9)
.L83:
	lis 9,.LC43@ha
	lis 11,allitem@ha
	la 9,.LC43@l(9)
	lfs 13,0(9)
	lwz 9,allitem@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L84
	lis 9,.LC36@ha
	la 7,.LC36@l(9)
	b .L85
.L84:
	lis 9,.LC29@ha
	la 7,.LC29@l(9)
.L85:
	lis 4,.LC34@ha
	addi 27,27,1
	la 4,.LC34@l(4)
	crxor 6,6,6
	bl sprintf
.L78:
	lis 11,.LC43@ha
	lis 9,limchasecam@ha
	la 11,.LC43@l(11)
	lfs 0,0(11)
	lwz 11,limchasecam@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L86
	fmr 0,13
	fctiwz 13,0
	stfd 13,16432(1)
	lwz 9,16436(1)
	cmpwi 0,9,2
	bc 4,2,.L87
	addi 3,1,8
	bl strlen
	lis 4,.LC37@ha
	add 3,29,3
	la 4,.LC37@l(4)
	crxor 6,6,6
	bl sprintf
	b .L88
.L87:
	addi 3,1,8
	bl strlen
	lis 4,.LC38@ha
	add 3,29,3
	la 4,.LC38@l(4)
	crxor 6,6,6
	bl sprintf
.L88:
	addi 27,27,1
.L86:
	lis 9,.LC43@ha
	lis 11,teamplay@ha
	la 9,.LC43@l(9)
	lfs 13,0(9)
	lwz 9,teamplay@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L89
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16432(1)
	lwz 11,16436(1)
	andi. 0,11,256
	bc 4,2,.L89
	addi 3,1,8
	addi 27,27,1
	bl strlen
	lis 4,.LC39@ha
	add 3,29,3
	la 4,.LC39@l(4)
	crxor 6,6,6
	bl sprintf
.L89:
	lis 11,.LC43@ha
	lis 9,teamplay@ha
	la 11,.LC43@l(11)
	lfs 31,0(11)
	lwz 11,teamplay@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L90
	lis 4,.LC40@ha
	addi 3,1,8
	la 4,.LC40@l(4)
	addi 27,27,2
	bl strcat
.L90:
	lis 9,actionmaps@ha
	lis 26,motd_num_lines@ha
	lwz 11,actionmaps@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L91
	lis 9,num_maps@ha
	lwz 0,num_maps@l(9)
	cmpwi 0,0,0
	bc 4,1,.L91
	lis 4,.LC41@ha
	addi 3,1,8
	la 4,.LC41@l(4)
	addi 27,27,2
	bl strcat
	li 28,0
	li 30,0
	b .L92
.L97:
	li 28,0
.L96:
	lis 9,map_rotation@ha
	addi 3,1,8
	la 9,map_rotation@l(9)
	add 28,28,31
	lwzx 4,29,9
	bl strcat
	lis 11,num_maps@ha
	lwz 9,num_maps@l(11)
	addi 9,9,-1
	cmpw 0,30,9
	bc 4,0,.L94
	lis 4,.LC42@ha
	addi 3,1,8
	la 4,.LC42@l(4)
	addi 28,28,2
	bl strcat
.L94:
	addi 30,30,1
.L92:
	lis 9,num_maps@ha
	lwz 0,num_maps@l(9)
	cmpw 0,30,0
	bc 4,0,.L93
	lis 9,map_rotation@ha
	slwi 0,30,2
	la 9,map_rotation@l(9)
	mr 29,0
	lwzx 3,9,0
	bl strlen
	mr 31,3
	add 9,28,31
	addi 9,9,2
	cmpwi 0,9,39
	bc 4,1,.L96
	lis 4,.LC13@ha
	addi 3,1,8
	la 4,.LC13@l(4)
	addi 27,27,1
	bl strcat
	cmpwi 0,27,30
	bc 12,0,.L97
.L93:
	cmpwi 0,27,30
	bc 4,0,.L91
	lis 4,.LC13@ha
	addi 3,1,8
	la 4,.LC13@l(4)
	addi 27,27,1
	bl strcat
.L91:
	lis 9,motd_num_lines@ha
	cmpwi 7,27,30
	lwz 11,motd_num_lines@l(9)
	mfcr 10
	rlwinm 10,10,29,1
	addic 9,11,-1
	subfe 0,9,11
	and. 11,0,10
	bc 12,2,.L48
	lis 4,.LC13@ha
	addi 3,1,8
	la 4,.LC13@l(4)
	addi 27,27,1
	bl strcat
.L48:
	lis 9,motd_num_lines@ha
	lwz 0,motd_num_lines@l(9)
	cmpwi 0,0,0
	bc 12,2,.L102
	cmpwi 0,27,30
	bc 4,0,.L102
	lis 9,motd_lines@ha
	li 30,0
	la 31,motd_lines@l(9)
	lis 29,.LC13@ha
	b .L104
.L106:
	addi 31,31,70
	addi 30,30,1
.L104:
	lwz 0,motd_num_lines@l(26)
	cmpw 0,30,0
	bc 4,0,.L102
	mr 4,31
	addi 3,1,8
	bl strcat
	addi 27,27,1
	addi 3,1,8
	la 4,.LC13@l(29)
	bl strcat
	cmpwi 0,27,30
	bc 12,0,.L106
.L102:
	mr 3,25
	addi 4,1,8
	crxor 6,6,6
	bl safe_centerprintf
	lwz 0,16484(1)
	mtlr 0
	lmw 25,16444(1)
	lfd 31,16472(1)
	la 1,16480(1)
	blr
.Lfe3:
	.size	 PrintMOTD,.Lfe3-PrintMOTD
	.section	".rodata"
	.align 2
.LC44:
	.string	"bot"
	.globl decals
	.section	".sdata","aw"
	.align 2
	.type	 decals,@object
	.size	 decals,4
decals:
	.long 0
	.globl shells
	.align 2
	.type	 shells,@object
	.size	 shells,4
shells:
	.long 0
	.globl splats
	.align 2
	.type	 splats,@object
	.size	 splats,4
splats:
	.long 0
	.section	".rodata"
	.align 2
.LC45:
	.string	"sprites/null.sp2"
	.align 2
.LC47:
	.string	"blooder"
	.align 2
.LC48:
	.string	"weapons/shellhit1.wav"
	.align 2
.LC50:
	.string	"weapons/tink1.wav"
	.align 2
.LC51:
	.string	"weapons/tink2.wav"
	.align 2
.LC112:
	.string	"models/weapons/shell/tris2.md2"
	.align 2
.LC113:
	.string	"models/weapons/shell/tris3.md2"
	.align 2
.LC114:
	.string	"models/weapons/shell/tris.md2"
	.align 2
.LC120:
	.string	"shell"
	.align 2
.LC52:
	.long 0x3ecccccd
	.align 3
.LC53:
	.long 0xbfefae14
	.long 0x7ae147ae
	.align 3
.LC54:
	.long 0xbfef5c28
	.long 0xf5c28f5c
	.align 2
.LC55:
	.long 0xbdcccccd
	.align 3
.LC56:
	.long 0xbfef0a3d
	.long 0x70a3d70a
	.align 2
.LC57:
	.long 0x40a33333
	.align 2
.LC58:
	.long 0x3e99999a
	.align 3
.LC59:
	.long 0xbfeeb851
	.long 0xeb851eb8
	.align 2
.LC60:
	.long 0x40a66666
	.align 2
.LC61:
	.long 0x3f333333
	.align 3
.LC62:
	.long 0xbfee6666
	.long 0x66666666
	.align 2
.LC63:
	.long 0x3f8ccccd
	.align 3
.LC64:
	.long 0xbfee147a
	.long 0xe147ae14
	.align 2
.LC65:
	.long 0x40a9999a
	.align 3
.LC66:
	.long 0xbfedc28f
	.long 0x5c28f5c3
	.align 2
.LC67:
	.long 0x40accccd
	.align 2
.LC68:
	.long 0x3ff33333
	.align 3
.LC69:
	.long 0xbfed70a3
	.long 0xd70a3d71
	.align 2
.LC70:
	.long 0x40133333
	.align 3
.LC71:
	.long 0xbfed1eb8
	.long 0x51eb851f
	.align 2
.LC72:
	.long 0x40b33333
	.align 2
.LC73:
	.long 0x402ccccd
	.align 3
.LC74:
	.long 0xbfeccccc
	.long 0xcccccccd
	.align 2
.LC75:
	.long 0x40b66666
	.align 2
.LC76:
	.long 0x40466666
	.align 3
.LC77:
	.long 0xbfeb3333
	.long 0x33333333
	.align 2
.LC78:
	.long 0x40b9999a
	.align 3
.LC79:
	.long 0xbfe99999
	.long 0x9999999a
	.align 3
.LC80:
	.long 0xbfe33333
	.long 0x33333333
	.align 3
.LC81:
	.long 0xbfd99999
	.long 0x9999999a
	.align 3
.LC82:
	.long 0xbfc99999
	.long 0x9999999a
	.align 3
.LC83:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC84:
	.long 0x3fd99999
	.long 0x9999999a
	.align 3
.LC85:
	.long 0x3fe33333
	.long 0x33333333
	.align 3
.LC86:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC87:
	.long 0x3feb3333
	.long 0x33333333
	.align 3
.LC88:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 3
.LC89:
	.long 0x3fed1eb8
	.long 0x51eb851f
	.align 2
.LC90:
	.long 0x4191999a
	.align 2
.LC91:
	.long 0x400ccccd
	.align 3
.LC92:
	.long 0x3fed70a3
	.long 0xd70a3d71
	.align 2
.LC93:
	.long 0x41933333
	.align 3
.LC94:
	.long 0x3fedc28f
	.long 0x5c28f5c3
	.align 2
.LC95:
	.long 0x4194cccd
	.align 2
.LC96:
	.long 0x3fcccccd
	.align 3
.LC97:
	.long 0x3fee147a
	.long 0xe147ae14
	.align 2
.LC98:
	.long 0x41966666
	.align 2
.LC99:
	.long 0x3fa66666
	.align 3
.LC100:
	.long 0x3fee6666
	.long 0x66666666
	.align 3
.LC101:
	.long 0x3feeb851
	.long 0xeb851eb8
	.align 2
.LC102:
	.long 0x4199999a
	.align 3
.LC103:
	.long 0x3fef0a3d
	.long 0x70a3d70a
	.align 2
.LC104:
	.long 0x419b3333
	.align 3
.LC105:
	.long 0x3fef5c28
	.long 0xf5c28f5c
	.align 2
.LC106:
	.long 0x419ccccd
	.align 2
.LC107:
	.long 0xbe4ccccd
	.align 3
.LC108:
	.long 0x3fefae14
	.long 0x7ae147ae
	.align 2
.LC109:
	.long 0x419e6666
	.align 2
.LC110:
	.long 0xbf19999a
	.align 2
.LC111:
	.long 0x46fffe00
	.align 3
.LC115:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC116:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC117:
	.long 0x3fe66666
	.long 0x66666666
	.align 3
.LC118:
	.long 0x3ff33333
	.long 0x33333333
	.align 3
.LC119:
	.long 0x3fa99999
	.long 0x9999999a
	.align 2
.LC121:
	.long 0x0
	.align 2
.LC122:
	.long 0x3f800000
	.align 2
.LC123:
	.long 0xbf800000
	.align 2
.LC124:
	.long 0xc0e00000
	.align 2
.LC125:
	.long 0x41300000
	.align 2
.LC126:
	.long 0x40000000
	.align 2
.LC127:
	.long 0xc1300000
	.align 2
.LC128:
	.long 0x40800000
	.align 2
.LC129:
	.long 0x40c00000
	.align 2
.LC130:
	.long 0xc1100000
	.align 2
.LC131:
	.long 0x40a00000
	.align 2
.LC132:
	.long 0xbf000000
	.align 2
.LC133:
	.long 0x3fc00000
	.align 2
.LC134:
	.long 0x40b00000
	.align 2
.LC135:
	.long 0x40600000
	.align 2
.LC136:
	.long 0x40d00000
	.align 2
.LC137:
	.long 0x40900000
	.align 2
.LC138:
	.long 0x41000000
	.align 2
.LC139:
	.long 0x41180000
	.align 2
.LC140:
	.long 0x41400000
	.align 2
.LC141:
	.long 0x40e00000
	.align 2
.LC142:
	.long 0x41600000
	.align 2
.LC143:
	.long 0x41800000
	.align 2
.LC144:
	.long 0x41900000
	.align 2
.LC145:
	.long 0x40200000
	.align 2
.LC146:
	.long 0x41980000
	.align 2
.LC147:
	.long 0x41a00000
	.align 3
.LC148:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC149:
	.long 0xc2700000
	.align 2
.LC150:
	.long 0xc20c0000
	.align 2
.LC151:
	.long 0x42700000
	.align 2
.LC152:
	.long 0x420c0000
	.align 2
.LC153:
	.long 0x43fa0000
	.align 2
.LC154:
	.long 0x42c80000
	.align 2
.LC155:
	.long 0x42b40000
	.align 3
.LC156:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl EjectShell
	.type	 EjectShell,@function
EjectShell:
	stwu 1,-128(1)
	mflr 0
	mfcr 12
	stfd 31,120(1)
	stmw 25,92(1)
	stw 0,132(1)
	stw 12,88(1)
	lis 9,sv_shelloff@ha
	lis 8,.LC121@ha
	lwz 11,sv_shelloff@l(9)
	la 8,.LC121@l(8)
	mr 27,3
	lfs 13,0(8)
	lis 9,.LC122@ha
	mr 31,4
	lfs 0,20(11)
	la 9,.LC122@l(9)
	mr 25,5
	lfs 31,0(9)
	li 30,0
	fcmpu 0,0,13
	bc 4,2,.L121
	bl G_Spawn
	lis 11,shells@ha
	mr 28,3
	lwz 9,shells@l(11)
	addi 5,1,24
	addi 6,1,40
	lwz 3,84(27)
	mr 26,5
	mr 29,6
	addi 9,9,1
	addi 4,1,8
	stw 9,shells@l(11)
	addi 3,3,4060
	bl AngleVectors
	lwz 9,84(27)
	lwz 0,716(9)
	cmpwi 0,0,1
	bc 4,2,.L123
	lis 8,.LC123@ha
	li 30,1
	la 8,.LC123@l(8)
	lfs 31,0(8)
	b .L124
.L123:
	cmpwi 0,0,2
	bc 4,2,.L124
	lis 9,.LC121@ha
	la 9,.LC121@l(9)
	lfs 31,0(9)
.L124:
	lwz 9,84(27)
	lwz 0,4284(9)
	cmpwi 0,0,0
	bc 4,2,.L126
	cmpwi 4,30,0
	bc 12,18,.L127
	lis 10,.LC124@ha
	la 10,.LC124@l(10)
	lfs 1,0(10)
	b .L128
.L127:
	lis 9,.LC52@ha
	lfs 1,.LC52@l(9)
.L128:
	mr 3,31
	mr 4,26
	mr 5,31
	bl VectorMA
	lis 0,0x4000
	bc 12,18,.L129
	lis 0,0x40a0
.L129:
	stw 0,56(1)
	mr 3,31
	addi 4,1,8
	lfs 0,56(1)
	mr 5,31
	fmr 1,0
	bl VectorMA
	lis 0,0xc100
	bc 12,18,.L147
	lis 0,0xc120
	b .L147
.L126:
	cmpwi 0,0,2
	bc 4,2,.L134
	cmpwi 4,30,0
	lis 0,0x40a0
	bc 12,18,.L135
	lis 0,0xc120
.L135:
	stw 0,56(1)
	mr 3,31
	mr 4,26
	lfs 0,56(1)
	mr 5,31
	fmr 1,0
	bl VectorMA
	lis 0,0x4140
	bc 12,18,.L137
	lis 0,0x40c0
.L137:
	stw 0,56(1)
	mr 3,31
	addi 4,1,8
	lfs 0,56(1)
	mr 5,31
	fmr 1,0
	bl VectorMA
	lis 0,0xc130
	b .L262
.L134:
	cmpwi 0,0,1
	bc 4,2,.L142
	cmpwi 4,30,0
	lis 0,0x40c0
	bc 12,18,.L143
	lis 0,0xc120
.L143:
	stw 0,56(1)
	mr 3,31
	mr 4,26
	lfs 0,56(1)
	mr 5,31
	fmr 1,0
	bl VectorMA
	lis 0,0x4100
	bc 12,18,.L145
	lis 0,0x40c0
.L145:
	stw 0,56(1)
	mr 3,31
	addi 4,1,8
	lfs 0,56(1)
	mr 5,31
	fmr 1,0
	bl VectorMA
	lis 0,0xc120
.L262:
	bc 12,18,.L147
	lis 0,0xc110
.L147:
	stw 0,56(1)
	mr 3,31
	mr 4,29
	lfs 0,56(1)
	mr 5,31
	fmr 1,0
	bl VectorMA
	b .L133
.L142:
	cmpwi 0,0,5
	bc 4,2,.L150
	lis 8,.LC125@ha
	mr 3,31
	la 8,.LC125@l(8)
	mr 4,26
	lfs 1,0(8)
	mr 5,31
	fmuls 1,31,1
	bl VectorMA
	lis 8,.LC126@ha
	mr 3,31
	la 8,.LC126@l(8)
	addi 4,1,8
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
	lis 8,.LC127@ha
	mr 3,31
	la 8,.LC127@l(8)
	b .L257
.L150:
	cmpwi 0,0,3
	bc 4,2,.L152
	cmpwi 0,30,0
	lis 0,0x4040
	bc 12,2,.L153
	lis 0,0xc110
.L153:
	stw 0,56(1)
	mr 3,31
	mr 4,26
	lfs 0,56(1)
	mr 5,31
	fmr 1,0
	bl VectorMA
	lis 8,.LC128@ha
	mr 3,31
	la 8,.LC128@l(8)
	addi 4,1,8
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
	lis 8,.LC123@ha
	mr 3,31
	la 8,.LC123@l(8)
.L257:
	mr 4,29
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
	b .L133
.L152:
	cmpwi 0,0,6
	bc 4,2,.L133
	lwz 0,716(9)
	cmpwi 0,0,1
	bc 4,2,.L157
	cmpwi 0,25,1
	lis 0,0xc100
	bc 4,2,.L158
	lis 0,0x4100
.L158:
	stw 0,56(1)
	mr 3,31
	mr 4,26
	lfs 0,56(1)
	mr 5,31
	fmr 1,0
	bl VectorMA
	b .L160
.L157:
	cmpwi 0,25,1
	lis 0,0x4080
	bc 4,2,.L161
	lis 0,0xc080
.L161:
	stw 0,56(1)
	mr 3,31
	mr 4,26
	lfs 0,56(1)
	mr 5,31
	fmr 1,0
	bl VectorMA
.L160:
	lis 8,.LC129@ha
	mr 3,31
	la 8,.LC129@l(8)
	addi 4,1,8
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
	lis 8,.LC130@ha
	mr 3,31
	la 8,.LC130@l(8)
	mr 4,29
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
.L133:
	lis 8,.LC123@ha
	lfs 0,16(1)
	la 8,.LC123@l(8)
	lfs 13,0(8)
	fmr 12,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L163
	lis 9,.LC53@ha
	fmr 13,12
	lfd 0,.LC53@l(9)
	fcmpu 0,13,0
	bc 4,0,.L163
	lis 9,.LC131@ha
	mr 3,31
	la 9,.LC131@l(9)
	addi 4,1,8
	lfs 1,0(9)
	mr 5,31
	bl VectorMA
	lis 8,.LC132@ha
	mr 3,31
	la 8,.LC132@l(8)
	mr 4,29
	lfs 1,0(8)
	b .L258
.L163:
	lis 9,.LC53@ha
	fmr 13,12
	lfd 0,.LC53@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L165
	lis 9,.LC54@ha
	lfd 0,.LC54@l(9)
	fcmpu 0,13,0
	bc 4,0,.L165
	lis 8,.LC131@ha
	mr 3,31
	la 8,.LC131@l(8)
	addi 4,1,8
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
	lis 9,.LC55@ha
	mr 3,31
	lfs 1,.LC55@l(9)
	b .L259
.L165:
	lis 9,.LC54@ha
	fmr 13,12
	lfd 0,.LC54@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L167
	lis 9,.LC56@ha
	lfd 0,.LC56@l(9)
	fcmpu 0,13,0
	bc 4,0,.L167
	lis 9,.LC57@ha
	mr 3,31
	lfs 1,.LC57@l(9)
	addi 4,1,8
	mr 5,31
	bl VectorMA
	lis 9,.LC58@ha
	mr 3,31
	lfs 1,.LC58@l(9)
	b .L259
.L167:
	lis 9,.LC56@ha
	fmr 13,12
	lfd 0,.LC56@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L169
	lis 9,.LC59@ha
	lfd 0,.LC59@l(9)
	fcmpu 0,13,0
	bc 4,0,.L169
	lis 9,.LC60@ha
	mr 3,31
	lfs 1,.LC60@l(9)
	addi 4,1,8
	mr 5,31
	bl VectorMA
	lis 9,.LC61@ha
	mr 3,31
	lfs 1,.LC61@l(9)
	b .L259
.L169:
	lis 9,.LC59@ha
	fmr 13,12
	lfd 0,.LC59@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L171
	lis 9,.LC62@ha
	lfd 0,.LC62@l(9)
	fcmpu 0,13,0
	bc 4,0,.L171
	lis 9,.LC60@ha
	mr 3,31
	lfs 1,.LC60@l(9)
	addi 4,1,8
	mr 5,31
	bl VectorMA
	lis 9,.LC63@ha
	mr 3,31
	lfs 1,.LC63@l(9)
	b .L259
.L171:
	lis 9,.LC62@ha
	fmr 13,12
	lfd 0,.LC62@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L173
	lis 9,.LC64@ha
	lfd 0,.LC64@l(9)
	fcmpu 0,13,0
	bc 4,0,.L173
	lis 9,.LC65@ha
	mr 3,31
	lfs 1,.LC65@l(9)
	addi 4,1,8
	mr 5,31
	bl VectorMA
	lis 8,.LC133@ha
	mr 3,31
	la 8,.LC133@l(8)
	mr 4,29
	lfs 1,0(8)
	b .L258
.L173:
	lis 9,.LC64@ha
	fmr 13,12
	lfd 0,.LC64@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L175
	lis 9,.LC66@ha
	lfd 0,.LC66@l(9)
	fcmpu 0,13,0
	bc 4,0,.L175
	lis 9,.LC67@ha
	mr 3,31
	lfs 1,.LC67@l(9)
	addi 4,1,8
	mr 5,31
	bl VectorMA
	lis 9,.LC68@ha
	mr 3,31
	lfs 1,.LC68@l(9)
	b .L259
.L175:
	lis 9,.LC66@ha
	fmr 13,12
	lfd 0,.LC66@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L177
	lis 9,.LC69@ha
	lfd 0,.LC69@l(9)
	fcmpu 0,13,0
	bc 4,0,.L177
	lis 8,.LC134@ha
	mr 3,31
	la 8,.LC134@l(8)
	addi 4,1,8
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
	lis 9,.LC70@ha
	mr 3,31
	lfs 1,.LC70@l(9)
	b .L259
.L177:
	lis 9,.LC69@ha
	fmr 13,12
	lfd 0,.LC69@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L179
	lis 9,.LC71@ha
	lfd 0,.LC71@l(9)
	fcmpu 0,13,0
	bc 4,0,.L179
	lis 9,.LC72@ha
	mr 3,31
	lfs 1,.LC72@l(9)
	addi 4,1,8
	mr 5,31
	bl VectorMA
	lis 9,.LC73@ha
	mr 3,31
	lfs 1,.LC73@l(9)
	b .L259
.L179:
	lis 9,.LC71@ha
	fmr 13,12
	lfd 0,.LC71@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L181
	lis 9,.LC74@ha
	lfd 0,.LC74@l(9)
	fcmpu 0,13,0
	bc 4,0,.L181
	lis 9,.LC75@ha
	mr 3,31
	lfs 1,.LC75@l(9)
	addi 4,1,8
	mr 5,31
	bl VectorMA
	lis 9,.LC76@ha
	mr 3,31
	lfs 1,.LC76@l(9)
	b .L259
.L181:
	lis 9,.LC74@ha
	fmr 13,12
	lfd 0,.LC74@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L183
	lis 9,.LC77@ha
	lfd 0,.LC77@l(9)
	fcmpu 0,13,0
	bc 4,0,.L183
	lis 9,.LC78@ha
	mr 3,31
	lfs 1,.LC78@l(9)
	addi 4,1,8
	mr 5,31
	bl VectorMA
	lis 8,.LC135@ha
	mr 3,31
	la 8,.LC135@l(8)
	mr 4,29
	lfs 1,0(8)
	b .L258
.L183:
	lis 9,.LC77@ha
	fmr 13,12
	lfd 0,.LC77@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L185
	lis 9,.LC79@ha
	lfd 0,.LC79@l(9)
	fcmpu 0,13,0
	bc 4,0,.L185
	lis 8,.LC129@ha
	mr 3,31
	la 8,.LC129@l(8)
	addi 4,1,8
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
	lis 8,.LC128@ha
	mr 3,31
	la 8,.LC128@l(8)
	mr 4,29
	lfs 1,0(8)
	b .L258
.L185:
	lis 9,.LC79@ha
	fmr 13,12
	lfd 0,.LC79@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L187
	lis 9,.LC80@ha
	lfd 0,.LC80@l(9)
	fcmpu 0,13,0
	bc 4,0,.L187
	lis 8,.LC136@ha
	mr 3,31
	la 8,.LC136@l(8)
	addi 4,1,8
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
	lis 8,.LC137@ha
	mr 3,31
	la 8,.LC137@l(8)
	mr 4,29
	lfs 1,0(8)
	b .L258
.L187:
	lis 9,.LC80@ha
	fmr 13,12
	lfd 0,.LC80@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L189
	lis 9,.LC81@ha
	lfd 0,.LC81@l(9)
	fcmpu 0,13,0
	bc 4,0,.L189
	lis 8,.LC138@ha
	mr 3,31
	la 8,.LC138@l(8)
	addi 4,1,8
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
	lis 8,.LC134@ha
	mr 3,31
	la 8,.LC134@l(8)
	mr 4,29
	lfs 1,0(8)
	b .L258
.L189:
	lis 9,.LC81@ha
	fmr 13,12
	lfd 0,.LC81@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L191
	lis 9,.LC82@ha
	lfd 0,.LC82@l(9)
	fcmpu 0,13,0
	bc 4,0,.L191
	lis 8,.LC139@ha
	mr 3,31
	la 8,.LC139@l(8)
	addi 4,1,8
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
	lis 8,.LC129@ha
	mr 3,31
	la 8,.LC129@l(8)
	mr 4,29
	lfs 1,0(8)
	b .L258
.L191:
	lis 9,.LC82@ha
	fmr 13,12
	lfd 0,.LC82@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L193
	lis 8,.LC121@ha
	la 8,.LC121@l(8)
	lfs 0,0(8)
	fcmpu 0,12,0
	bc 4,0,.L193
	lis 9,.LC125@ha
	mr 3,31
	la 9,.LC125@l(9)
	addi 4,1,8
	lfs 1,0(9)
	mr 5,31
	bl VectorMA
	lis 8,.LC136@ha
	mr 3,31
	la 8,.LC136@l(8)
	mr 4,29
	lfs 1,0(8)
	b .L258
.L193:
	lis 8,.LC121@ha
	la 8,.LC121@l(8)
	lfs 0,0(8)
	fcmpu 0,12,0
	cror 3,2,1
	bc 4,3,.L195
	lis 9,.LC83@ha
	fmr 13,12
	lfd 0,.LC83@l(9)
	fcmpu 0,13,0
	bc 4,0,.L195
	lis 9,.LC140@ha
	mr 3,31
	la 9,.LC140@l(9)
	addi 4,1,8
	lfs 1,0(9)
	mr 5,31
	bl VectorMA
	lis 8,.LC141@ha
	mr 3,31
	la 8,.LC141@l(8)
	mr 4,29
	lfs 1,0(8)
	b .L258
.L195:
	lis 9,.LC83@ha
	fmr 13,12
	lfd 0,.LC83@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L197
	lis 9,.LC84@ha
	lfd 0,.LC84@l(9)
	fcmpu 0,13,0
	bc 4,0,.L197
	lis 8,.LC142@ha
	mr 3,31
	la 8,.LC142@l(8)
	addi 4,1,8
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
	lis 8,.LC136@ha
	mr 3,31
	la 8,.LC136@l(8)
	mr 4,29
	lfs 1,0(8)
	b .L258
.L197:
	lis 9,.LC84@ha
	fmr 13,12
	lfd 0,.LC84@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L199
	lis 9,.LC85@ha
	lfd 0,.LC85@l(9)
	fcmpu 0,13,0
	bc 4,0,.L199
	lis 8,.LC143@ha
	mr 3,31
	la 8,.LC143@l(8)
	addi 4,1,8
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
	lis 8,.LC129@ha
	mr 3,31
	la 8,.LC129@l(8)
	mr 4,29
	lfs 1,0(8)
	b .L258
.L199:
	lis 9,.LC85@ha
	fmr 13,12
	lfd 0,.LC85@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L201
	lis 9,.LC86@ha
	lfd 0,.LC86@l(9)
	fcmpu 0,13,0
	bc 4,0,.L201
	lis 8,.LC144@ha
	mr 3,31
	la 8,.LC144@l(8)
	addi 4,1,8
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
	lis 8,.LC131@ha
	mr 3,31
	la 8,.LC131@l(8)
	mr 4,29
	lfs 1,0(8)
	b .L258
.L201:
	lis 9,.LC86@ha
	fmr 13,12
	lfd 0,.LC86@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L203
	lis 9,.LC87@ha
	lfd 0,.LC87@l(9)
	fcmpu 0,13,0
	bc 4,0,.L203
	lis 8,.LC144@ha
	mr 3,31
	la 8,.LC144@l(8)
	addi 4,1,8
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
	lis 8,.LC128@ha
	mr 3,31
	la 8,.LC128@l(8)
	mr 4,29
	lfs 1,0(8)
	b .L258
.L203:
	lis 9,.LC87@ha
	fmr 13,12
	lfd 0,.LC87@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L205
	lis 9,.LC88@ha
	lfd 0,.LC88@l(9)
	fcmpu 0,13,0
	bc 4,0,.L205
	lis 8,.LC144@ha
	mr 3,31
	la 8,.LC144@l(8)
	addi 4,1,8
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
	lis 8,.LC145@ha
	mr 3,31
	la 8,.LC145@l(8)
	mr 4,29
	lfs 1,0(8)
	b .L258
.L205:
	lis 9,.LC88@ha
	fmr 13,12
	lfd 0,.LC88@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L207
	lis 9,.LC89@ha
	lfd 0,.LC89@l(9)
	fcmpu 0,13,0
	bc 4,0,.L207
	lis 9,.LC90@ha
	mr 3,31
	lfs 1,.LC90@l(9)
	addi 4,1,8
	mr 5,31
	bl VectorMA
	lis 9,.LC91@ha
	mr 3,31
	lfs 1,.LC91@l(9)
	b .L259
.L207:
	lis 9,.LC89@ha
	fmr 13,12
	lfd 0,.LC89@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L209
	lis 9,.LC92@ha
	lfd 0,.LC92@l(9)
	fcmpu 0,13,0
	bc 4,0,.L209
	lis 9,.LC93@ha
	mr 3,31
	lfs 1,.LC93@l(9)
	addi 4,1,8
	mr 5,31
	bl VectorMA
	lis 9,.LC68@ha
	mr 3,31
	lfs 1,.LC68@l(9)
	b .L259
.L209:
	lis 9,.LC92@ha
	fmr 13,12
	lfd 0,.LC92@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L211
	lis 9,.LC94@ha
	lfd 0,.LC94@l(9)
	fcmpu 0,13,0
	bc 4,0,.L211
	lis 9,.LC95@ha
	mr 3,31
	lfs 1,.LC95@l(9)
	addi 4,1,8
	mr 5,31
	bl VectorMA
	lis 9,.LC96@ha
	mr 3,31
	lfs 1,.LC96@l(9)
	b .L259
.L211:
	lis 9,.LC94@ha
	fmr 13,12
	lfd 0,.LC94@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L213
	lis 9,.LC97@ha
	lfd 0,.LC97@l(9)
	fcmpu 0,13,0
	bc 4,0,.L213
	lis 9,.LC98@ha
	mr 3,31
	lfs 1,.LC98@l(9)
	addi 4,1,8
	mr 5,31
	bl VectorMA
	lis 9,.LC99@ha
	mr 3,31
	lfs 1,.LC99@l(9)
	b .L259
.L213:
	lis 9,.LC97@ha
	fmr 13,12
	lfd 0,.LC97@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L215
	lis 9,.LC100@ha
	lfd 0,.LC100@l(9)
	fcmpu 0,13,0
	bc 4,0,.L215
	lis 8,.LC146@ha
	mr 3,31
	la 8,.LC146@l(8)
	addi 4,1,8
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
	lis 8,.LC122@ha
	mr 3,31
	la 8,.LC122@l(8)
	mr 4,29
	lfs 1,0(8)
	b .L258
.L215:
	lis 9,.LC100@ha
	fmr 13,12
	lfd 0,.LC100@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L217
	lis 9,.LC101@ha
	lfd 0,.LC101@l(9)
	fcmpu 0,13,0
	bc 4,0,.L217
	lis 9,.LC102@ha
	mr 3,31
	lfs 1,.LC102@l(9)
	addi 4,1,8
	mr 5,31
	bl VectorMA
	lis 9,.LC61@ha
	mr 3,31
	lfs 1,.LC61@l(9)
	b .L259
.L217:
	lis 9,.LC101@ha
	fmr 13,12
	lfd 0,.LC101@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L219
	lis 9,.LC103@ha
	lfd 0,.LC103@l(9)
	fcmpu 0,13,0
	bc 4,0,.L219
	lis 9,.LC104@ha
	mr 3,31
	lfs 1,.LC104@l(9)
	addi 4,1,8
	mr 5,31
	bl VectorMA
	lis 9,.LC52@ha
	mr 3,31
	lfs 1,.LC52@l(9)
	b .L259
.L219:
	lis 9,.LC103@ha
	fmr 13,12
	lfd 0,.LC103@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L221
	lis 9,.LC105@ha
	lfd 0,.LC105@l(9)
	fcmpu 0,13,0
	bc 4,0,.L221
	lis 9,.LC106@ha
	mr 3,31
	lfs 1,.LC106@l(9)
	addi 4,1,8
	mr 5,31
	bl VectorMA
	lis 9,.LC107@ha
	mr 3,31
	lfs 1,.LC107@l(9)
	b .L259
.L221:
	lis 9,.LC105@ha
	fmr 13,12
	lfd 0,.LC105@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L223
	lis 9,.LC108@ha
	lfd 0,.LC108@l(9)
	fcmpu 0,13,0
	bc 4,0,.L223
	lis 9,.LC109@ha
	mr 3,31
	lfs 1,.LC109@l(9)
	addi 4,1,8
	mr 5,31
	bl VectorMA
	lis 9,.LC110@ha
	mr 3,31
	lfs 1,.LC110@l(9)
.L259:
	mr 4,29
.L258:
	mr 5,31
	bl VectorMA
	b .L164
.L223:
	lis 9,.LC108@ha
	fmr 13,12
	lfd 0,.LC108@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L164
	lis 8,.LC122@ha
	la 8,.LC122@l(8)
	lfs 0,0(8)
	fcmpu 0,12,0
	cror 3,2,0
	bc 4,3,.L164
	lis 9,.LC147@ha
	mr 3,31
	la 9,.LC147@l(9)
	addi 4,1,8
	lfs 1,0(9)
	mr 5,31
	bl VectorMA
	lis 8,.LC123@ha
	mr 3,31
	la 8,.LC123@l(8)
	mr 4,29
	lfs 1,0(8)
	mr 5,31
	bl VectorMA
.L164:
	lfs 12,0(31)
	lis 8,.LC121@ha
	lis 9,.LC122@ha
	la 8,.LC121@l(8)
	la 9,.LC122@l(9)
	lfs 13,0(8)
	stfs 12,4(28)
	lfs 0,4(31)
	lfs 11,0(9)
	fsubs 13,31,13
	stfs 0,8(28)
	lfs 0,8(31)
	fsel 31,13,31,11
	fneg 13,13
	stfs 0,12(28)
	lwz 9,84(27)
	fsel 31,13,11,31
	lwz 0,4284(9)
	cmpwi 0,0,5
	bc 4,2,.L227
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,0x4330
	stw 3,84(1)
	lis 8,.LC148@ha
	lis 10,.LC111@ha
	stw 11,80(1)
	la 8,.LC148@l(8)
	addi 0,28,376
	lfd 13,0(8)
	lis 11,.LC149@ha
	mr 3,0
	lfd 1,80(1)
	lis 8,.LC150@ha
	la 11,.LC149@l(11)
	lfs 0,.LC111@l(10)
	la 8,.LC150@l(8)
	mr 4,26
	lfs 11,0(11)
	mr 5,0
	mr 31,0
	fsub 1,1,13
	lfs 12,0(8)
	frsp 1,1
	fdivs 1,1,0
	fmadds 1,1,11,12
	fmuls 1,31,1
	bl VectorMA
	b .L228
.L227:
	cmpwi 0,0,6
	bc 4,2,.L229
	lwz 0,716(9)
	cmpwi 0,0,1
	bc 4,2,.L230
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,84(1)
	lis 8,.LC148@ha
	lis 11,.LC111@ha
	la 8,.LC148@l(8)
	stw 0,80(1)
	cmpwi 0,25,1
	lfd 12,0(8)
	addi 10,28,376
	lfd 0,80(1)
	lis 8,.LC151@ha
	mr 31,10
	lfs 13,.LC111@l(11)
	lis 9,.LC152@ha
	la 8,.LC151@l(8)
	la 9,.LC152@l(9)
	lfs 10,0(8)
	fsub 0,0,12
	lfs 11,0(9)
	frsp 0,0
	fdivs 0,0,13
	fmadds 1,0,10,11
	bc 12,2,.L233
	b .L263
.L230:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,84(1)
	lis 8,.LC148@ha
	lis 11,.LC111@ha
	la 8,.LC148@l(8)
	stw 0,80(1)
	cmpwi 0,25,1
	lfd 12,0(8)
	addi 10,28,376
	lfd 0,80(1)
	lis 8,.LC151@ha
	mr 31,10
	lfs 13,.LC111@l(11)
	lis 9,.LC152@ha
	la 8,.LC151@l(8)
	la 9,.LC152@l(9)
	lfs 10,0(8)
	fsub 0,0,12
	lfs 11,0(9)
	frsp 0,0
	fdivs 0,0,13
	fmadds 1,0,10,11
	bc 4,2,.L233
.L263:
	fneg 1,1
.L233:
	mr 3,31
	mr 4,26
	mr 5,31
	bl VectorMA
	b .L228
.L229:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,84(1)
	lis 8,.LC148@ha
	lis 10,.LC111@ha
	la 8,.LC148@l(8)
	stw 0,80(1)
	addi 11,28,376
	lfd 13,0(8)
	mr 3,11
	mr 4,26
	lfd 1,80(1)
	lis 8,.LC151@ha
	mr 5,11
	lfs 0,.LC111@l(10)
	la 8,.LC151@l(8)
	mr 31,11
	lfs 11,0(8)
	fsub 1,1,13
	lis 8,.LC152@ha
	la 8,.LC152@l(8)
	lfs 12,0(8)
	frsp 1,1
	fdivs 1,1,0
	fmadds 1,1,11,12
	fmuls 1,31,1
	bl VectorMA
.L228:
	lis 8,.LC153@ha
	addi 3,28,388
	la 8,.LC153@l(8)
	mr 4,26
	lfs 1,0(8)
	mr 5,3
	bl VectorMA
	lwz 9,84(27)
	lwz 0,4284(9)
	cmpwi 0,0,5
	bc 4,2,.L235
	lis 8,.LC154@ha
	mr 3,31
	la 8,.LC154@l(8)
	mr 4,29
	lfs 1,0(8)
	mr 5,3
	bl VectorMA
	b .L236
.L235:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,84(1)
	lis 8,.LC148@ha
	lis 11,.LC111@ha
	la 8,.LC148@l(8)
	stw 0,80(1)
	lis 10,.LC155@ha
	lfd 13,0(8)
	la 10,.LC155@l(10)
	mr 3,31
	lfd 1,80(1)
	lis 8,.LC151@ha
	mr 4,29
	lfs 0,.LC111@l(11)
	la 8,.LC151@l(8)
	mr 5,3
	lfs 11,0(10)
	fsub 1,1,13
	lfs 12,0(8)
	frsp 1,1
	fdivs 1,1,0
	fmadds 1,1,11,12
	bl VectorMA
.L236:
	li 0,9
	li 11,2
	stw 0,260(28)
	stw 11,248(28)
	lwz 9,84(27)
	lwz 0,4284(9)
	cmpwi 0,0,3
	bc 4,2,.L237
	lis 9,gi+32@ha
	lis 3,.LC112@ha
	lwz 0,gi+32@l(9)
	la 3,.LC112@l(3)
	b .L260
.L237:
	cmpwi 0,0,5
	bc 4,2,.L239
	lis 9,gi+32@ha
	lis 3,.LC113@ha
	lwz 0,gi+32@l(9)
	la 3,.LC113@l(3)
	b .L260
.L239:
	lis 9,gi+32@ha
	lis 3,.LC114@ha
	lwz 0,gi+32@l(9)
	la 3,.LC114@l(3)
.L260:
	mtlr 0
	blrl
	stw 3,40(28)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,84(1)
	lis 8,.LC148@ha
	lis 10,.LC111@ha
	la 8,.LC148@l(8)
	stw 0,80(1)
	lis 11,.LC115@ha
	lfd 12,0(8)
	lfd 0,80(1)
	lfs 11,.LC111@l(10)
	lfd 13,.LC115@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 0,0,11
	fmr 12,0
	fcmpu 0,12,13
	bc 4,0,.L241
	li 0,0
	b .L261
.L241:
	lis 9,.LC83@ha
	lfd 0,.LC83@l(9)
	fcmpu 0,12,0
	bc 4,0,.L243
	li 0,1
	b .L261
.L243:
	lis 9,.LC116@ha
	lfd 0,.LC116@l(9)
	fcmpu 0,12,0
	bc 4,0,.L245
	li 0,2
	b .L261
.L245:
	lis 9,.LC156@ha
	la 9,.LC156@l(9)
	lfd 0,0(9)
	fcmpu 0,12,0
	bc 4,0,.L247
	li 0,3
	b .L261
.L247:
	lis 9,.LC85@ha
	lfd 0,.LC85@l(9)
	fcmpu 0,12,0
	bc 4,0,.L249
	li 0,4
	b .L261
.L249:
	lis 9,.LC117@ha
	lfd 0,.LC117@l(9)
	fcmpu 0,12,0
	bc 4,0,.L251
	li 0,5
	b .L261
.L251:
	lis 9,.LC86@ha
	lfd 0,.LC86@l(9)
	fcmpu 0,12,0
	bc 4,0,.L253
	li 0,6
	b .L261
.L253:
	lis 9,.LC88@ha
	lfd 0,.LC88@l(9)
	fcmpu 0,12,0
	li 0,8
	bc 4,0,.L255
	li 0,7
.L255:
.L261:
	stw 0,56(28)
	lis 11,shells@ha
	stw 27,256(28)
	lwz 0,shells@l(11)
	lis 9,ShellTouch@ha
	lis 8,.LC148@ha
	lis 11,0x4330
	la 9,ShellTouch@l(9)
	xoris 0,0,0x8000
	stw 9,444(28)
	la 8,.LC148@l(8)
	stw 0,84(1)
	lis 6,level+4@ha
	lis 7,.LC119@ha
	stw 11,80(1)
	lis 9,ShellDie@ha
	mr 3,28
	lfs 0,level+4@l(6)
	lis 11,.LC120@ha
	la 9,ShellDie@l(9)
	lfd 10,0(8)
	la 11,.LC120@l(11)
	lfd 13,80(1)
	lis 8,.LC118@ha
	lfd 11,.LC118@l(8)
	lis 10,gi+72@ha
	lfd 12,.LC119@l(7)
	fsub 13,13,10
	stw 9,436(28)
	fadd 0,0,11
	stw 11,280(28)
	fmul 13,13,12
	fsub 0,0,13
	frsp 0,0
	stfs 0,428(28)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
.L121:
	lwz 0,132(1)
	lwz 12,88(1)
	mtlr 0
	lmw 25,92(1)
	lfd 31,120(1)
	mtcrf 8,12
	la 1,128(1)
	blr
.Lfe4:
	.size	 EjectShell,.Lfe4-EjectShell
	.section	".rodata"
	.align 2
.LC157:
	.string	"decal"
	.align 2
.LC159:
	.string	"models/objects/holes/hole1/hole.md2"
	.align 2
.LC160:
	.string	"func_explosive"
	.align 3
.LC158:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC161:
	.long 0x3f800000
	.align 3
.LC162:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC163:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl AddDecal
	.type	 AddDecal,@function
AddDecal:
	stwu 1,-64(1)
	mflr 0
	stmw 20,16(1)
	stw 0,68(1)
	lis 30,bholelimit@ha
	lis 5,.LC161@ha
	lwz 9,bholelimit@l(30)
	la 5,.LC161@l(5)
	mr 20,3
	lfs 13,0(5)
	mr 27,4
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,0,.L275
	bl G_Spawn
	lis 10,decals@ha
	lwz 8,bholelimit@l(30)
	lwz 9,decals@l(10)
	lis 7,0x4330
	lis 5,.LC162@ha
	la 5,.LC162@l(5)
	lfs 12,20(8)
	mr 31,3
	addi 9,9,1
	lfd 13,0(5)
	lis 6,decals@ha
	xoris 0,9,0x8000
	stw 9,decals@l(10)
	stw 0,12(1)
	stw 7,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,1,.L277
	li 0,1
	stw 0,decals@l(6)
.L277:
	lis 9,globals@ha
	li 28,0
	lwz 26,decals@l(6)
	la 9,globals@l(9)
	lis 11,.LC157@ha
	lwz 0,72(9)
	la 23,.LC157@l(11)
	addi 21,27,24
	addi 22,31,16
	cmpw 0,28,0
	bc 4,0,.L287
	mr 24,9
	lis 25,g_edicts@ha
	li 30,0
.L280:
	lwz 0,g_edicts@l(25)
	add 29,0,30
	lwz 3,280(29)
	cmpwi 0,3,0
	bc 12,2,.L282
	lwz 0,900(29)
	cmpwi 0,0,0
	bc 12,2,.L282
	mr 4,23
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L282
	lwz 0,900(29)
	cmpw 0,0,26
	bc 4,2,.L282
	mr 10,29
	b .L286
.L282:
	lwz 0,72(24)
	addi 28,28,1
	addi 30,30,996
	cmpw 0,28,0
	bc 12,0,.L280
.L287:
	li 10,0
.L286:
	cmpwi 0,10,0
	bc 12,2,.L288
	lis 9,level+4@ha
	lis 11,.LC158@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC158@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(10)
.L288:
	li 29,0
	lis 28,gi@ha
	la 28,gi@l(28)
	stw 29,248(31)
	lis 3,.LC159@ha
	stw 29,260(31)
	la 3,.LC159@l(3)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(31)
	mr 4,22
	lfs 13,12(27)
	mr 3,21
	stfs 13,4(31)
	lfs 0,16(27)
	stfs 0,8(31)
	lfs 13,20(27)
	stfs 13,12(31)
	bl vectoangles
	lis 9,decals@ha
	lis 5,.LC163@ha
	stw 20,256(31)
	lwz 0,decals@l(9)
	lis 10,level+4@ha
	la 5,.LC163@l(5)
	stw 29,444(31)
	lis 9,DecalDie@ha
	lis 11,.LC157@ha
	stw 0,900(31)
	la 9,DecalDie@l(9)
	la 11,.LC157@l(11)
	lfs 0,level+4@l(10)
	mr 3,31
	lfs 13,0(5)
	stw 9,436(31)
	stw 11,280(31)
	fadds 0,0,13
	stfs 0,428(31)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 9,52(27)
	cmpwi 0,9,0
	bc 12,2,.L275
	lwz 4,280(9)
	lis 3,.LC160@ha
	la 3,.LC160@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L275
	lwz 3,52(27)
	mr 4,31
	bl CGF_SFX_AttachDecalToGlass
.L275:
	lwz 0,68(1)
	mtlr 0
	lmw 20,16(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 AddDecal,.Lfe5-AddDecal
	.section	".rodata"
	.align 2
.LC164:
	.string	"splat"
	.align 2
.LC168:
	.string	"models/objects/splats/splat1/splat.md2"
	.align 2
.LC170:
	.string	"models/objects/splats/splat2/splat.md2"
	.align 2
.LC171:
	.string	"models/objects/splats/splat3/splat.md2"
	.align 3
.LC165:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC166:
	.long 0x46fffe00
	.align 3
.LC167:
	.long 0x3fe570a3
	.long 0xd70a3d71
	.align 3
.LC169:
	.long 0x3fd51eb8
	.long 0x51eb851f
	.align 2
.LC172:
	.long 0x3f800000
	.align 3
.LC173:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC174:
	.long 0x41c80000
	.section	".text"
	.align 2
	.globl AddSplat
	.type	 AddSplat,@function
AddSplat:
	stwu 1,-80(1)
	mflr 0
	stmw 19,28(1)
	stw 0,84(1)
	lis 9,.LC172@ha
	lis 31,splatlimit@ha
	la 9,.LC172@l(9)
	mr 19,3
	lfs 13,0(9)
	mr 25,4
	mr 22,5
	lwz 9,splatlimit@l(31)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,0,.L291
	bl G_Spawn
	lis 10,splats@ha
	lwz 8,splatlimit@l(31)
	lwz 9,splats@l(10)
	lis 7,0x4330
	lis 5,.LC173@ha
	la 5,.LC173@l(5)
	lfs 12,20(8)
	mr 30,3
	addi 9,9,1
	lfd 13,0(5)
	lis 6,splats@ha
	xoris 0,9,0x8000
	stw 9,splats@l(10)
	stw 0,20(1)
	stw 7,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,1,.L293
	li 0,1
	stw 0,splats@l(6)
.L293:
	lis 9,globals@ha
	li 29,0
	lwz 27,splats@l(6)
	la 9,globals@l(9)
	lis 11,.LC164@ha
	lwz 0,72(9)
	la 23,.LC164@l(11)
	addi 20,22,24
	addi 21,30,16
	cmpw 0,29,0
	bc 4,0,.L303
	mr 24,9
	lis 26,g_edicts@ha
	li 28,0
.L296:
	lwz 0,g_edicts@l(26)
	add 31,0,28
	lwz 3,280(31)
	cmpwi 0,3,0
	bc 12,2,.L298
	lwz 0,900(31)
	cmpwi 0,0,0
	bc 12,2,.L298
	mr 4,23
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L298
	lwz 0,900(31)
	cmpw 0,0,27
	bc 12,2,.L310
.L298:
	lwz 0,72(24)
	addi 29,29,1
	addi 28,28,996
	cmpw 0,29,0
	bc 12,0,.L296
.L303:
	li 10,0
.L302:
	cmpwi 0,10,0
	bc 12,2,.L304
	lis 9,level+4@ha
	lis 11,.LC165@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC165@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(10)
.L304:
	li 0,0
	stw 0,260(30)
	stw 0,248(30)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 5,.LC173@ha
	lis 10,.LC166@ha
	la 5,.LC173@l(5)
	stw 0,16(1)
	lis 11,.LC167@ha
	lfd 12,0(5)
	lfd 0,16(1)
	lfs 11,.LC166@l(10)
	lfd 13,.LC167@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 0,0,11
	fmr 12,0
	fcmpu 0,12,13
	bc 4,1,.L305
	lis 9,gi+32@ha
	lis 3,.LC168@ha
	lwz 0,gi+32@l(9)
	la 3,.LC168@l(3)
	b .L311
.L310:
	mr 10,31
	b .L302
.L305:
	lis 9,.LC169@ha
	lfd 0,.LC169@l(9)
	fcmpu 0,12,0
	bc 4,1,.L307
	lis 9,gi+32@ha
	lis 3,.LC170@ha
	lwz 0,gi+32@l(9)
	la 3,.LC170@l(3)
	b .L311
.L307:
	lis 9,gi+32@ha
	lis 3,.LC171@ha
	lwz 0,gi+32@l(9)
	la 3,.LC171@l(3)
.L311:
	mtlr 0
	blrl
	stw 3,40(30)
	lfs 13,0(25)
	mr 3,20
	mr 4,21
	stfs 13,4(30)
	lfs 0,4(25)
	stfs 0,8(30)
	lfs 13,8(25)
	stfs 13,12(30)
	bl vectoangles
	li 0,0
	lis 5,.LC174@ha
	stw 19,256(30)
	stw 0,444(30)
	lis 11,level+4@ha
	la 5,.LC174@l(5)
	lfs 0,level+4@l(11)
	lis 10,splats@ha
	lis 9,SplatDie@ha
	lfs 13,0(5)
	lis 11,.LC164@ha
	la 9,SplatDie@l(9)
	lwz 0,splats@l(10)
	la 11,.LC164@l(11)
	mr 3,30
	stw 9,436(30)
	lis 10,gi+72@ha
	fadds 0,0,13
	stw 11,280(30)
	stw 0,900(30)
	stfs 0,428(30)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	lwz 9,52(22)
	cmpwi 0,9,0
	bc 12,2,.L291
	lwz 4,280(9)
	lis 3,.LC160@ha
	la 3,.LC160@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L291
	lwz 3,52(22)
	mr 4,30
	bl CGF_SFX_AttachDecalToGlass
.L291:
	lwz 0,84(1)
	mtlr 0
	lmw 19,28(1)
	la 1,80(1)
	blr
.Lfe6:
	.size	 AddSplat,.Lfe6-AddSplat
	.section	".rodata"
	.align 2
.LC175:
	.string	"No Weapon"
	.align 2
.LC176:
	.string	"No Item"
	.align 2
.LC177:
	.string	"%d"
	.align 2
.LC178:
	.string	"%d rounds (%d extra clips)"
	.align 2
.LC179:
	.string	"%d shells (%d extra shells)"
	.align 2
.LC180:
	.string	"%d rounds (%d extra rounds)"
	.align 2
.LC181:
	.string	"Combat Knife"
	.align 2
.LC182:
	.string	"%d kni%s"
	.align 2
.LC183:
	.string	"fe"
	.align 2
.LC184:
	.string	"ves"
	.align 2
.LC185:
	.string	"M26 Fragmentation Grenade"
	.align 2
.LC186:
	.string	"no ammo"
	.section	".text"
	.align 2
	.globl GetAmmo
	.type	 GetAmmo,@function
GetAmmo:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 8,3
	mr 31,4
	lwz 10,84(8)
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L322
	lwz 10,4284(10)
	cmplwi 0,10,8
	bc 12,1,.L322
	lis 11,.L337@ha
	slwi 10,10,2
	la 11,.L337@l(11)
	lis 9,.L337@ha
	lwzx 0,10,11
	la 9,.L337@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L337:
	.long .L324-.L337
	.long .L325-.L337
	.long .L326-.L337
	.long .L327-.L337
	.long .L328-.L337
	.long .L329-.L337
	.long .L330-.L337
	.long .L331-.L337
	.long .L334-.L337
.L324:
	lwz 9,84(8)
	lis 4,.LC178@ha
	mr 3,31
	la 4,.LC178@l(4)
	lwz 0,3936(9)
	addi 11,9,740
	lwz 5,4224(9)
	b .L339
.L325:
	lwz 9,84(8)
	lis 4,.LC178@ha
	mr 3,31
	la 4,.LC178@l(4)
	lwz 0,3936(9)
	addi 11,9,740
	lwz 5,4256(9)
	b .L339
.L326:
	lwz 9,84(8)
	lis 4,.LC178@ha
	mr 3,31
	la 4,.LC178@l(4)
	lwz 0,3936(9)
	addi 11,9,740
	lwz 5,4264(9)
	b .L339
.L327:
	lwz 9,84(8)
	lis 4,.LC179@ha
	mr 3,31
	la 4,.LC179@l(4)
	lwz 0,3936(9)
	addi 11,9,740
	lwz 5,4240(9)
	b .L339
.L328:
	lwz 9,84(8)
	lis 4,.LC179@ha
	mr 3,31
	la 4,.LC179@l(4)
	lwz 0,3936(9)
	addi 11,9,740
	lwz 5,4272(9)
	b .L339
.L329:
	lwz 9,84(8)
	lis 4,.LC180@ha
	mr 3,31
	la 4,.LC180@l(4)
	lwz 0,3936(9)
	addi 11,9,740
	lwz 5,4248(9)
	b .L339
.L330:
	lwz 9,84(8)
	lis 4,.LC178@ha
	mr 3,31
	la 4,.LC178@l(4)
	lwz 0,3936(9)
	addi 11,9,740
	lwz 5,4232(9)
.L339:
	slwi 0,0,2
	lwzx 6,11,0
	crxor 6,6,6
	bl sprintf
	b .L321
.L331:
	lis 3,.LC181@ha
	lwz 29,84(8)
	la 3,.LC181@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	lwzx 5,29,3
	cmpwi 0,5,1
	bc 4,2,.L332
	lis 9,.LC183@ha
	la 6,.LC183@l(9)
	b .L333
.L332:
	lis 9,.LC184@ha
	la 6,.LC184@l(9)
.L333:
	lis 4,.LC182@ha
	mr 3,31
	la 4,.LC182@l(4)
	crxor 6,6,6
	bl sprintf
	b .L321
.L334:
	lis 3,.LC185@ha
	lwz 29,84(8)
	la 3,.LC185@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	lwzx 5,29,3
	cmpwi 0,5,1
	bc 4,2,.L335
	lis 9,.LC29@ha
	la 6,.LC29@l(9)
	b .L336
.L335:
	lis 9,.LC30@ha
	la 6,.LC30@l(9)
.L336:
	lis 4,.LC28@ha
	mr 3,31
	la 4,.LC28@l(4)
	crxor 6,6,6
	bl sprintf
	b .L321
.L322:
	lis 9,.LC186@ha
	la 11,.LC186@l(9)
	lwz 0,.LC186@l(9)
	lwz 10,4(11)
	stw 0,0(31)
	stw 10,4(31)
.L321:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 GetAmmo,.Lfe7-GetAmmo
	.section	".rodata"
	.align 2
.LC188:
	.string	"nobody"
	.align 2
.LC189:
	.string	" and "
	.align 2
.LC190:
	.string	", and "
	.align 2
.LC187:
	.long 0x44bb8000
	.section	".text"
	.align 2
	.globl GetNearbyTeammates
	.type	 GetNearbyTeammates,@function
GetNearbyTeammates:
	stwu 1,-224(1)
	mflr 0
	mfcr 12
	stmw 22,184(1)
	stw 0,228(1)
	stw 12,180(1)
	mr 30,3
	mr 31,4
	li 29,0
	li 26,0
	lis 24,.LC187@ha
	li 25,0
	addi 27,1,23
	addi 28,1,8
.L346:
	lfs 1,.LC187@l(24)
	mr 3,29
	addi 4,30,4
	bl findradius
	mr. 29,3
	bc 12,2,.L342
	cmpw 0,29,30
	bc 12,2,.L346
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L346
	mr 3,29
	mr 4,30
	bl CanDamage
	cmpwi 0,3,0
	bc 12,2,.L346
	mr 3,29
	mr 4,30
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L346
	lwz 4,84(29)
	mr 3,28
	li 5,15
	addi 26,26,1
	addi 28,28,16
	addi 4,4,700
	bl strncpy
	cmpwi 0,26,9
	stb 25,0(27)
	addi 27,27,16
	bc 4,1,.L346
.L342:
	cmpwi 0,26,0
	bc 4,2,.L347
	lis 9,.LC188@ha
	lwz 10,.LC188@l(9)
	la 11,.LC188@l(9)
	lbz 0,6(11)
	lhz 9,4(11)
	stb 0,6(31)
	stw 10,0(31)
	sth 9,4(31)
	b .L340
.L347:
	li 29,0
	cmpw 0,29,26
	bc 4,0,.L340
	cmpwi 4,26,2
	addi 30,1,8
	lis 22,.LC189@ha
	addi 25,26,-1
	lis 23,.LC190@ha
	lis 24,.LC42@ha
	mr 27,30
	mr 28,30
.L351:
	cmpwi 0,29,0
	bc 4,2,.L352
	mr 3,31
	addi 4,1,8
	bl strcpy
	b .L350
.L352:
	bc 4,18,.L354
	la 4,.LC189@l(22)
	mr 3,31
	bl strcat
	mr 3,31
	mr 4,28
	bl strcat
	b .L350
.L354:
	cmpw 0,29,25
	bc 4,2,.L356
	la 4,.LC190@l(23)
	mr 3,31
	bl strcat
	mr 3,31
	mr 4,30
	bl strcat
	b .L350
.L356:
	la 4,.LC42@l(24)
	mr 3,31
	bl strcat
	mr 3,31
	mr 4,27
	bl strcat
.L350:
	addi 29,29,1
	addi 27,27,16
	cmpw 0,29,26
	addi 30,30,16
	addi 28,28,16
	bc 12,0,.L351
.L340:
	lwz 0,228(1)
	lwz 12,180(1)
	mtlr 0
	lmw 22,184(1)
	mtcrf 8,12
	la 1,224(1)
	blr
.Lfe8:
	.size	 GetNearbyTeammates,.Lfe8-GetNearbyTeammates
	.lcomm	buf.69,10240,4
	.lcomm	infobuf.70,10240,4
	.align 2
	.globl ParseSayText
	.type	 ParseSayText,@function
ParseSayText:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 9,buf.69@ha
	li 0,0
	mr 24,4
	stb 0,buf.69@l(9)
	mr 25,3
	lbz 0,0(24)
	mr 31,24
	la 28,buf.69@l(9)
	cmpwi 0,0,0
	bc 12,2,.L366
.L368:
	lbz 0,0(31)
	cmpwi 0,0,37
	bc 4,2,.L369
	lbz 9,1(31)
	addi 9,9,-65
	cmplwi 0,9,22
	bc 12,1,.L369
	lis 11,.L410@ha
	slwi 10,9,2
	la 11,.L410@l(11)
	lis 9,.L410@ha
	lwzx 0,10,11
	la 9,.L410@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L410:
	.long .L378-.L410
	.long .L369-.L410
	.long .L369-.L410
	.long .L369-.L410
	.long .L369-.L410
	.long .L369-.L410
	.long .L369-.L410
	.long .L371-.L410
	.long .L392-.L410
	.long .L369-.L410
	.long .L369-.L410
	.long .L369-.L410
	.long .L369-.L410
	.long .L369-.L410
	.long .L369-.L410
	.long .L369-.L410
	.long .L369-.L410
	.long .L369-.L410
	.long .L369-.L410
	.long .L404-.L410
	.long .L369-.L410
	.long .L369-.L410
	.long .L384-.L410
.L371:
	lis 29,infobuf.70@ha
	lwz 5,480(25)
	lis 4,.LC177@ha
	la 29,infobuf.70@l(29)
	la 4,.LC177@l(4)
	mr 3,29
	addi 30,31,2
	crxor 6,6,6
	bl sprintf
	mr 4,29
	mr 3,28
	bl strcpy
	mr 3,28
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L408
.L375:
	lbzu 0,1(3)
	cmpwi 0,0,0
	bc 4,2,.L375
	b .L408
.L378:
	lis 29,infobuf.70@ha
	mr 3,25
	la 4,infobuf.70@l(29)
	addi 30,31,2
	bl GetAmmo
	la 4,infobuf.70@l(29)
	mr 3,28
	bl strcpy
	mr 3,28
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L408
.L381:
	lbzu 0,1(3)
	cmpwi 0,0,0
	bc 4,2,.L381
	b .L408
.L384:
	lis 9,infobuf.70@ha
	lwz 11,84(25)
	lis 8,infobuf.70@ha
	la 3,infobuf.70@l(9)
	lwz 9,1788(11)
	cmpwi 0,9,0
	bc 12,2,.L385
	lwz 4,40(9)
	bl strcpy
	b .L386
.L385:
	lis 9,.LC175@ha
	lwz 0,.LC175@l(9)
	la 11,.LC175@l(9)
	lhz 10,8(11)
	lwz 9,4(11)
	stw 0,infobuf.70@l(8)
	sth 10,8(3)
	stw 9,4(3)
.L386:
	lis 4,infobuf.70@ha
	mr 3,28
	la 4,infobuf.70@l(4)
	addi 30,31,2
	bl strcpy
	mr 3,28
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L408
.L389:
	lbzu 0,1(3)
	cmpwi 0,0,0
	bc 4,2,.L389
	b .L408
.L413:
	lwz 4,40(3)
	mr 3,27
	bl strcpy
	b .L397
.L392:
	lis 9,tnames@ha
	lis 11,infobuf.70@ha
	la 3,tnames@l(9)
	la 27,infobuf.70@l(11)
	lwz 0,0(3)
	addi 30,31,2
	cmpwi 0,0,0
	bc 12,2,.L398
	lis 9,itemlist@ha
	lis 31,0x38e3
	la 26,itemlist@l(9)
	mr 29,3
	ori 31,31,36409
.L395:
	lwz 3,0(29)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L396
	subf 0,26,3
	lwz 11,84(25)
	mullw 0,0,31
	addi 11,11,740
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L413
.L396:
	lwzu 0,4(29)
	cmpwi 0,0,0
	bc 4,2,.L395
.L398:
	lis 9,.LC176@ha
	la 11,.LC176@l(9)
	lwz 0,.LC176@l(9)
	lwz 10,4(11)
	stw 0,0(27)
	stw 10,4(27)
.L397:
	lis 4,infobuf.70@ha
	mr 3,28
	la 4,infobuf.70@l(4)
	bl strcpy
	mr 3,28
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L408
.L401:
	lbzu 0,1(3)
	cmpwi 0,0,0
	bc 4,2,.L401
	b .L408
.L404:
	lis 29,infobuf.70@ha
	mr 3,25
	la 4,infobuf.70@l(29)
	addi 30,31,2
	bl GetNearbyTeammates
	la 4,infobuf.70@l(29)
	mr 3,28
	bl strcpy
	mr 3,28
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L408
.L407:
	lbzu 0,1(3)
	cmpwi 0,0,0
	bc 4,2,.L407
.L408:
	mr 28,3
	mr 31,30
	b .L365
.L369:
	lbz 0,0(31)
	addi 31,31,1
	stb 0,0(28)
	addi 28,28,1
.L365:
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L366
	lis 9,buf.69@ha
	la 9,buf.69@l(9)
	subf 9,9,28
	cmpwi 0,9,300
	bc 4,1,.L368
.L366:
	li 29,0
	lis 4,buf.69@ha
	stb 29,0(28)
	la 4,buf.69@l(4)
	mr 3,24
	li 5,300
	bl strncpy
	stb 29,300(24)
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 ParseSayText,.Lfe9-ParseSayText
	.comm	team1_name,1000,4
	.comm	team2_name,1000,4
	.comm	team1_skin,1000,4
	.comm	team2_skin,1000,4
	.comm	team1_skin_index,1030,4
	.comm	team2_skin_index,1030,4
	.comm	map_rotation,4000,4
	.comm	num_maps,4,4
	.comm	cur_map,4,4
	.align 2
	.globl stuffcmd
	.type	 stuffcmd,@function
stuffcmd:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,4
	mr 31,3
	lwz 3,280(31)
	lis 4,.LC44@ha
	la 4,.LC44@l(4)
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L110
	lis 29,gi@ha
	li 3,11
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	mr 3,30
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
.L110:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 stuffcmd,.Lfe10-stuffcmd
	.align 2
	.globl FindEdictByClassnum
	.type	 FindEdictByClassnum,@function
FindEdictByClassnum:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 9,globals@ha
	li 30,0
	la 9,globals@l(9)
	mr 27,3
	lwz 0,72(9)
	mr 28,4
	cmpw 0,30,0
	bc 4,0,.L266
	mr 25,9
	lis 26,g_edicts@ha
	li 29,0
.L268:
	lwz 0,g_edicts@l(26)
	add 31,0,29
	lwz 3,280(31)
	cmpwi 0,3,0
	bc 12,2,.L267
	lwz 0,900(31)
	cmpwi 0,0,0
	bc 12,2,.L267
	mr 4,27
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L267
	lwz 0,900(31)
	cmpw 0,0,28
	bc 4,2,.L267
	mr 3,31
	b .L414
.L267:
	lwz 0,72(25)
	addi 30,30,1
	addi 29,29,996
	cmpw 0,30,0
	bc 12,0,.L268
.L266:
	li 3,0
.L414:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe11:
	.size	 FindEdictByClassnum,.Lfe11-FindEdictByClassnum
	.section	".rodata"
	.align 3
.LC191:
	.long 0x40099999
	.long 0x9999999a
	.align 2
.LC192:
	.long 0x0
	.section	".text"
	.align 2
	.globl EjectBlooder
	.type	 EjectBlooder,@function
EjectBlooder:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	mr 28,5
	mr 27,4
	mr 25,3
	li 26,0
	bl G_Spawn
	lfs 11,8(28)
	mr 29,3
	lis 9,.LC192@ha
	lfs 12,0(28)
	la 9,.LC192@l(9)
	addi 3,1,8
	lfs 0,4(28)
	addi 4,29,376
	lfs 13,0(27)
	stfs 12,8(1)
	stfs 0,12(1)
	stfs 11,16(1)
	stfs 13,4(29)
	lfs 0,4(27)
	lfs 1,0(9)
	stfs 0,8(29)
	lfs 13,8(27)
	stfs 13,12(29)
	bl VectorScale
	li 0,7
	lis 28,gi@ha
	stw 26,248(29)
	la 28,gi@l(28)
	stw 0,260(29)
	lis 3,.LC45@ha
	lwz 9,32(28)
	la 3,.LC45@l(3)
	mtlr 9
	blrl
	lwz 0,64(29)
	lis 10,BlooderTouch@ha
	lis 7,level+4@ha
	la 10,BlooderTouch@l(10)
	stw 3,40(29)
	lis 8,.LC191@ha
	ori 0,0,2
	stw 25,256(29)
	lis 11,BlooderDie@ha
	stw 0,64(29)
	lis 9,.LC47@ha
	la 11,BlooderDie@l(11)
	stw 10,444(29)
	la 9,.LC47@l(9)
	mr 3,29
	lfs 0,level+4@l(7)
	lfd 13,.LC191@l(8)
	stw 11,436(29)
	stw 9,280(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe12:
	.size	 EjectBlooder,.Lfe12-EjectBlooder
	.comm	motd_lines,2100,1
	.comm	motd_num_lines,4,4
	.align 2
	.globl BlooderDie
	.type	 BlooderDie,@function
BlooderDie:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 BlooderDie,.Lfe13-BlooderDie
	.align 2
	.globl BlooderTouch
	.type	 BlooderTouch,@function
BlooderTouch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 BlooderTouch,.Lfe14-BlooderTouch
	.section	".rodata"
	.align 2
.LC193:
	.long 0x46fffe00
	.align 2
.LC194:
	.long 0x3f800000
	.align 2
.LC195:
	.long 0x40400000
	.align 2
.LC196:
	.long 0x0
	.align 3
.LC197:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC198:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl ShellTouch
	.type	 ShellTouch,@function
ShellTouch:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lwz 9,256(31)
	lwz 11,84(9)
	lwz 0,4284(11)
	cmpwi 0,0,3
	bc 4,2,.L116
	lis 29,gi@ha
	lis 3,.LC48@ha
	la 29,gi@l(29)
	la 3,.LC48@l(3)
	b .L415
.L116:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC197@ha
	lis 11,.LC193@ha
	la 10,.LC197@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC198@ha
	lfs 12,.LC193@l(11)
	la 10,.LC198@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L118
	lis 29,gi@ha
	lis 3,.LC50@ha
	la 29,gi@l(29)
	la 3,.LC50@l(3)
.L415:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC194@ha
	lis 10,.LC195@ha
	lis 11,.LC196@ha
	mr 5,3
	la 9,.LC194@l(9)
	la 10,.LC195@l(10)
	mtlr 0
	la 11,.LC196@l(11)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L117
.L118:
	lis 29,gi@ha
	lis 3,.LC51@ha
	la 29,gi@l(29)
	la 3,.LC51@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC194@ha
	lis 10,.LC195@ha
	lis 11,.LC196@ha
	mr 5,3
	la 9,.LC194@l(9)
	la 10,.LC195@l(10)
	mtlr 0
	la 11,.LC196@l(11)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L117:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 ShellTouch,.Lfe15-ShellTouch
	.align 2
	.globl ShellDie
	.type	 ShellDie,@function
ShellDie:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lis 11,shells@ha
	lwz 9,shells@l(11)
	addi 9,9,-1
	stw 9,shells@l(11)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 ShellDie,.Lfe16-ShellDie
	.align 2
	.globl DecalDie
	.type	 DecalDie,@function
DecalDie:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 DecalDie,.Lfe17-DecalDie
	.align 2
	.globl SplatDie
	.type	 SplatDie,@function
SplatDie:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 SplatDie,.Lfe18-SplatDie
	.align 2
	.globl GetWeaponName
	.type	 GetWeaponName,@function
GetWeaponName:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	mr 3,4
	lwz 9,1788(9)
	cmpwi 0,9,0
	bc 12,2,.L313
	lwz 4,40(9)
	bl strcpy
	b .L312
.L313:
	lis 9,.LC175@ha
	lwz 10,.LC175@l(9)
	la 11,.LC175@l(9)
	lhz 0,8(11)
	lwz 9,4(11)
	sth 0,8(3)
	stw 10,0(3)
	stw 9,4(3)
.L312:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe19:
	.size	 GetWeaponName,.Lfe19-GetWeaponName
	.align 2
	.globl GetItemName
	.type	 GetItemName,@function
GetItemName:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,tnames@ha
	mr 28,3
	la 3,tnames@l(9)
	mr 30,4
	lwz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L316
	lis 9,itemlist@ha
	lis 31,0x38e3
	la 27,itemlist@l(9)
	mr 29,3
	ori 31,31,36409
.L317:
	lwz 3,0(29)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L318
	subf 0,27,3
	lwz 11,84(28)
	mullw 0,0,31
	addi 11,11,740
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L318
	lwz 4,40(3)
	mr 3,30
	bl strcpy
	b .L314
.L318:
	lwzu 0,4(29)
	cmpwi 0,0,0
	bc 4,2,.L317
.L316:
	lis 9,.LC176@ha
	la 11,.LC176@l(9)
	lwz 0,.LC176@l(9)
	lwz 10,4(11)
	stw 0,0(30)
	stw 10,4(30)
.L314:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 GetItemName,.Lfe20-GetItemName
	.align 2
	.globl GetHealth
	.type	 GetHealth,@function
GetHealth:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 5,480(3)
	lis 9,.LC177@ha
	mr 3,4
	la 4,.LC177@l(9)
	crxor 6,6,6
	bl sprintf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 GetHealth,.Lfe21-GetHealth
	.align 2
	.globl SeekBufEnd
	.type	 SeekBufEnd,@function
SeekBufEnd:
	lbz 0,0(3)
	cmpwi 0,0,0
	bclr 12,2
.L362:
	lbzu 0,1(3)
	cmpwi 0,0,0
	bc 4,2,.L362
	blr
.Lfe22:
	.size	 SeekBufEnd,.Lfe22-SeekBufEnd
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
