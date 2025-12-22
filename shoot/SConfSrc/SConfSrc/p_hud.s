	.file	"p_hud.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0x0
	.align 2
.LC1:
	.long 0x41000000
	.section	".text"
	.align 2
	.globl MoveClientToIntermission
	.type	 MoveClientToIntermission,@function
MoveClientToIntermission:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 9,deathmatch@ha
	lis 5,.LC0@ha
	lwz 11,deathmatch@l(9)
	la 5,.LC0@l(5)
	mr 31,3
	lfs 13,0(5)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L8
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L7
.L8:
	lwz 9,84(31)
	li 0,1
	stw 0,3508(9)
.L7:
	lis 10,level@ha
	lis 9,.LC1@ha
	lwz 6,84(31)
	la 10,level@l(10)
	la 9,.LC1@l(9)
	lfs 0,212(10)
	li 0,4
	lis 5,.LC0@ha
	lfs 9,0(9)
	li 8,0
	la 5,.LC0@l(5)
	lfs 8,0(5)
	stfs 0,4(31)
	mr 11,9
	mr 7,9
	lfs 0,216(10)
	lis 5,deathmatch@ha
	stfs 0,8(31)
	lfs 13,220(10)
	stfs 13,12(31)
	lfs 0,212(10)
	fmuls 0,0,9
	fctiwz 12,0
	stfd 12,16(1)
	lwz 9,20(1)
	sth 9,4(6)
	lfs 0,216(10)
	lwz 9,84(31)
	fmuls 0,0,9
	fctiwz 11,0
	stfd 11,16(1)
	lwz 11,20(1)
	sth 11,6(9)
	lfs 0,220(10)
	lwz 11,84(31)
	fmuls 0,0,9
	fctiwz 10,0
	stfd 10,16(1)
	lwz 7,20(1)
	sth 7,8(11)
	lfs 0,224(10)
	lwz 9,84(31)
	stfs 0,28(9)
	lfs 0,228(10)
	lwz 11,84(31)
	stfs 0,32(11)
	lfs 13,232(10)
	lwz 9,84(31)
	stfs 13,36(9)
	lwz 11,84(31)
	stw 0,0(11)
	lwz 9,84(31)
	stw 8,88(9)
	lwz 11,84(31)
	stfs 8,108(11)
	lwz 10,84(31)
	lwz 0,116(10)
	rlwinm 0,0,0,0,30
	stw 0,116(10)
	lwz 9,84(31)
	stfs 8,3728(9)
	lwz 11,84(31)
	lwz 10,deathmatch@l(5)
	stfs 8,3732(11)
	lwz 9,84(31)
	stfs 8,3736(9)
	lwz 11,84(31)
	stfs 8,3740(11)
	lwz 9,84(31)
	stw 8,3744(9)
	lwz 11,84(31)
	stfs 8,3748(11)
	stw 8,248(31)
	stw 8,508(31)
	stw 8,44(31)
	stw 8,48(31)
	stw 8,40(31)
	stw 8,64(31)
	stw 8,76(31)
	lfs 0,20(10)
	fcmpu 0,0,8
	bc 4,2,.L10
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,8
	bc 12,2,.L9
.L10:
	mr 3,31
	li 4,0
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L9:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 MoveClientToIntermission,.Lfe1-MoveClientToIntermission
	.section	".rodata"
	.align 2
.LC2:
	.string	"*"
	.align 2
.LC3:
	.string	"info_player_intermission"
	.align 2
.LC4:
	.string	"info_player_start"
	.align 2
.LC5:
	.string	"info_player_deathmatch"
	.align 2
.LC6:
	.long 0x0
	.align 3
.LC7:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl BeginIntermission
	.type	 BeginIntermission,@function
BeginIntermission:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 26,16(1)
	stw 0,52(1)
	lis 11,.LC6@ha
	lis 9,level+200@ha
	la 11,.LC6@l(11)
	lfs 0,level+200@l(9)
	mr 27,3
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L11
	lis 9,maxclients@ha
	lis 11,game+1560@ha
	lwz 10,maxclients@l(9)
	li 0,0
	li 30,0
	stw 0,game+1560@l(11)
	lis 26,maxclients@ha
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 4,0,.L14
	lis 9,.LC7@ha
	lis 28,g_edicts@ha
	la 9,.LC7@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,892
.L16:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L15
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 12,1,.L15
	bl respawn
.L15:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,892
	stw 0,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L16
.L14:
	lis 9,level@ha
	lis 4,.LC2@ha
	la 31,level@l(9)
	la 4,.LC2@l(4)
	lfs 0,4(31)
	stfs 0,200(31)
	lwz 0,504(27)
	mr 3,0
	stw 0,204(31)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L20
	lis 11,.LC6@ha
	lis 9,coop@ha
	la 11,.LC6@l(11)
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L34
	lis 9,maxclients@ha
	li 30,0
	lwz 10,maxclients@l(9)
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 4,0,.L34
	lis 9,g_edicts@ha
	lis 11,itemlist@ha
	lwz 4,g_edicts@l(9)
	la 11,itemlist@l(11)
	mr 5,10
	lis 9,.LC7@ha
	lis 31,0x4330
	la 9,.LC7@l(9)
	lfd 12,0(9)
.L25:
	mulli 9,30,892
	addi 7,30,1
	addi 9,9,892
	add 3,4,9
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L24
	li 0,256
	li 6,0
	mtctr 0
	li 8,0
	addi 10,11,56
.L50:
	lwz 0,0(10)
	addi 10,10,72
	andi. 9,0,16
	bc 12,2,.L29
	lwz 9,84(3)
	addi 9,9,740
	stwx 6,9,8
.L29:
	addi 8,8,4
	bdnz .L50
.L24:
	mr 30,7
	lfs 13,20(5)
	xoris 0,30,0x8000
	stw 0,12(1)
	stw 31,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L25
	b .L34
.L20:
	lis 9,.LC6@ha
	lis 11,deathmatch@ha
	la 9,.LC6@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L34
	li 0,1
	stw 0,208(31)
	b .L11
.L34:
	lis 9,level+208@ha
	li 0,0
	lis 5,.LC3@ha
	stw 0,level+208@l(9)
	li 3,0
	la 5,.LC3@l(5)
	li 4,280
	bl G_Find
	lis 29,.LC3@ha
	mr. 31,3
	bc 4,2,.L36
	lis 5,.LC4@ha
	li 3,0
	la 5,.LC4@l(5)
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L38
	lis 5,.LC5@ha
	li 3,0
	la 5,.LC5@l(5)
	li 4,280
	bl G_Find
	mr 31,3
	b .L38
.L36:
	bl rand
	rlwinm 30,3,0,30,31
	b .L39
.L41:
	mr 3,31
	li 4,280
	la 5,.LC3@l(29)
	bl G_Find
	mr. 31,3
	bc 4,2,.L39
	li 3,0
	li 4,280
	la 5,.LC3@l(29)
	bl G_Find
	mr 31,3
.L39:
	cmpwi 0,30,0
	addi 30,30,-1
	bc 4,2,.L41
.L38:
	lfs 0,4(31)
	lis 11,maxclients@ha
	lis 9,level@ha
	lwz 10,maxclients@l(11)
	la 9,level@l(9)
	li 30,0
	lis 11,.LC6@ha
	stfs 0,212(9)
	la 11,.LC6@l(11)
	lfs 0,8(31)
	lfs 12,0(11)
	stfs 0,216(9)
	lfs 13,12(31)
	stfs 13,220(9)
	lfs 0,16(31)
	stfs 0,224(9)
	lfs 13,20(31)
	stfs 13,228(9)
	lfs 0,24(31)
	stfs 0,232(9)
	lfs 13,20(10)
	fcmpu 0,12,13
	bc 4,0,.L11
	lis 9,.LC7@ha
	lis 28,g_edicts@ha
	la 9,.LC7@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 31,892
.L47:
	lwz 0,g_edicts@l(28)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L46
	bl MoveClientToIntermission
.L46:
	addi 30,30,1
	lwz 11,maxclients@l(26)
	xoris 0,30,0x8000
	addi 31,31,892
	stw 0,12(1)
	stw 29,8(1)
	lfd 0,8(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L47
.L11:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 BeginIntermission,.Lfe2-BeginIntermission
	.section	".rodata"
	.align 2
.LC8:
	.string	".txt"
	.align 2
.LC9:
	.string	"r"
	.align 2
.LC10:
	.string	"Generating High Score file for %s\n"
	.align 2
.LC11:
	.string	"SCORE "
	.align 2
.LC12:
	.string	"PLAYER="
	.align 2
.LC13:
	.string	"SCORE="
	.align 2
.LC14:
	.string	"DATE="
	.align 2
.LC15:
	.string	"Jan"
	.align 2
.LC16:
	.string	"01/"
	.align 2
.LC17:
	.string	"Feb"
	.align 2
.LC18:
	.string	"02/"
	.align 2
.LC19:
	.string	"Mar"
	.align 2
.LC20:
	.string	"03/"
	.align 2
.LC21:
	.string	"Apr"
	.align 2
.LC22:
	.string	"04/"
	.align 2
.LC23:
	.string	"May"
	.align 2
.LC24:
	.string	"05/"
	.align 2
.LC25:
	.string	"Jun"
	.align 2
.LC26:
	.string	"06/"
	.align 2
.LC27:
	.string	"Jul"
	.align 2
.LC28:
	.string	"07/"
	.align 2
.LC29:
	.string	"Aug"
	.align 2
.LC30:
	.string	"08/"
	.align 2
.LC31:
	.string	"Sep"
	.align 2
.LC32:
	.string	"09/"
	.align 2
.LC33:
	.string	"Oct"
	.align 2
.LC34:
	.string	"10/"
	.align 2
.LC35:
	.string	"Nov"
	.align 2
.LC36:
	.string	"11/"
	.align 2
.LC37:
	.string	"Dec"
	.align 2
.LC38:
	.string	"12/"
	.align 2
.LC39:
	.string	"/"
	.align 2
.LC40:
	.string	"<EMPTY>"
	.align 2
.LC41:
	.string	"01/01/98"
	.align 2
.LC42:
	.string	"98/01/01"
	.align 2
.LC43:
	.string	"w+"
	.align 2
.LC44:
	.string	"**** ERROR WRITING TO HIGH SCORE DIRECTORY ***\n1) Check your 'HighScoreDir' value in your CONFIG.TXT file\n2) Check to make sure you have the directory specified!\n**** NO SCORES SAVED OUT TO FILE ****\n"
	.align 2
.LC45:
	.string	"SCORE %i ----------------------\n"
	.align 2
.LC46:
	.string	"PLAYER=%s\n"
	.align 2
.LC47:
	.string	"SCORE=%i\n"
	.align 2
.LC48:
	.string	"TEAM=1\n"
	.align 2
.LC49:
	.string	"RED=0\n"
	.align 2
.LC50:
	.string	"BLUE=0\n"
	.align 2
.LC51:
	.string	"DATE=%s\n"
	.align 2
.LC52:
	.string	"PLAYER=<EMPTY>\n"
	.align 2
.LC53:
	.string	"SCORE=1\n"
	.align 2
.LC54:
	.string	"DATE=98/01/01\n"
	.align 2
.LC55:
	.long highscore
	.section	".text"
	.align 2
	.globl HighScoreMessage
	.type	 HighScoreMessage,@function
HighScoreMessage:
	stwu 1,-2656(1)
	mflr 0
	mfcr 12
	stmw 14,2584(1)
	stw 0,2660(1)
	stw 12,2580(1)
	addi 11,1,424
	li 9,0
	stw 11,2548(1)
	addi 10,1,2520
	addi 0,1,408
	li 11,80
	stw 9,2528(1)
	li 19,0
	stw 9,2532(1)
	mtctr 11
	li 18,0
	li 21,0
	addi 9,1,376
	stw 10,2556(1)
	li 17,-1
	stw 0,2544(1)
	addi 10,1,392
	addi 22,1,2524
	stw 9,2536(1)
	li 0,0
	stw 10,2540(1)
	addi 9,1,87
.L208:
	stb 0,0(9)
	addi 9,9,-1
	bdnz .L208
	lis 9,highscore@ha
	lis 11,gamescore@ha
	la 9,highscore@l(9)
	la 11,gamescore@l(11)
	addi 28,9,16
	addi 3,9,68
	addi 4,11,16
	li 30,0
	li 0,0
	li 5,0
.L60:
	li 10,15
	mulli 6,30,36
	addi 29,30,1
	mulli 7,30,72
	mtctr 10
	add 8,6,11
	add 10,7,9
.L207:
	stb 0,0(10)
	stb 0,0(8)
	stb 0,20(10)
	stb 0,35(10)
	stb 0,20(8)
	stb 0,50(10)
	addi 8,8,1
	addi 10,10,1
	bdnz .L207
	mr 30,29
	stwx 5,3,7
	cmpwi 0,30,14
	stwx 5,4,6
	stwx 5,28,7
	bc 4,1,.L60
	lis 9,game@ha
	li 30,0
	la 11,game@l(9)
	li 10,0
	lwz 0,1544(11)
	cmpw 0,30,0
	bc 4,0,.L68
	lis 9,g_edicts@ha
	mr 25,11
	lwz 24,g_edicts@l(9)
	addi 31,1,1496
.L70:
	mulli 9,30,892
	addi 29,30,1
	add 9,9,24
	lwz 0,980(9)
	cmpwi 0,0,0
	bc 12,2,.L69
	lwz 0,1028(25)
	mulli 9,30,3888
	li 5,0
	addi 4,1,1496
	cmpw 0,5,10
	addi 3,1,472
	add 9,9,0
	addi 26,10,1
	lwz 28,3424(9)
	bc 4,0,.L73
	lwz 0,0(31)
	cmpw 0,28,0
	bc 12,1,.L73
	mr 9,4
.L74:
	addi 5,5,1
	cmpw 0,5,10
	bc 4,0,.L73
	lwzu 0,4(9)
	cmpw 0,28,0
	bc 4,1,.L74
.L73:
	cmpw 0,10,5
	mr 7,10
	slwi 27,5,2
	bc 4,1,.L79
	slwi 9,10,2
	mr 6,3
	mr 10,9
	mr 8,4
	addi 11,9,-4
.L81:
	lwzx 9,11,6
	addi 7,7,-1
	cmpw 0,7,5
	stwx 9,10,6
	lwzx 0,11,8
	addi 11,11,-4
	stwx 0,10,8
	addi 10,10,-4
	bc 12,1,.L81
.L79:
	stwx 30,3,27
	mr 10,26
	stwx 28,4,27
.L69:
	lwz 0,1544(25)
	mr 30,29
	cmpw 0,30,0
	bc 12,0,.L70
.L68:
	cmpwi 7,10,16
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,10,0
	rlwinm 9,9,0,28,31
	or. 10,0,9
	bc 4,1,.L86
	lis 9,gamescore@ha
	lis 11,game@ha
	la 9,gamescore@l(9)
	la 26,game@l(11)
	mr 27,9
	mr 30,10
	addi 28,9,16
	addi 31,1,472
.L88:
	lwz 11,2528(1)
	mr 3,27
	lwz 0,0(31)
	addi 27,27,36
	addi 11,11,1
	addi 31,31,4
	stw 11,2528(1)
	mulli 0,0,3888
	lwz 29,1028(26)
	add 29,29,0
	addi 4,29,700
	bl strcpy
	lwz 0,3424(29)
	addic. 30,30,-1
	stw 0,0(28)
	addi 28,28,36
	bc 4,2,.L88
.L86:
	lis 4,HIGHSCORE_DIR@ha
	addi 3,1,8
	la 4,HIGHSCORE_DIR@l(4)
	bl strcpy
	lis 4,level+72@ha
	addi 3,1,8
	la 4,level+72@l(4)
	bl strcat
	lis 4,.LC8@ha
	addi 3,1,8
	la 4,.LC8@l(4)
	bl strcat
	lis 4,.LC9@ha
	addi 3,1,8
	la 4,.LC9@l(4)
	bl fopen
	mr. 15,3
	bc 4,2,.L90
	lis 9,gi+4@ha
	lis 3,.LC10@ha
	lwz 0,gi+4@l(9)
	lis 4,level+72@ha
	la 3,.LC10@l(3)
	la 4,level+72@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	li 0,0
	b .L91
.L90:
	li 0,1
.L91:
	cmpwi 0,0,1
	cmpwi 4,0,0
	bc 4,2,.L92
	addi 27,1,88
	b .L93
.L95:
	li 10,80
	addi 25,1,296
	mtctr 10
	li 0,0
	addi 9,1,375
.L206:
	stb 0,0(9)
	addi 9,9,-1
	bdnz .L206
	mr 3,27
	li 30,0
	bl strlen
	mr 28,3
	cmpw 0,30,28
	bc 4,0,.L93
	lis 9,highscore@ha
	addi 24,1,280
	la 20,highscore@l(9)
	lis 14,.LC14@ha
	li 26,0
	mr 23,25
	li 16,47
.L104:
	li 0,15
	addi 29,30,1
	mtctr 0
	addi 9,24,14
.L205:
	stb 26,0(9)
	addi 9,9,-1
	bdnz .L205
	lbzx 0,27,30
	lis 9,.LC11@ha
	mr 3,23
	la 4,.LC11@l(9)
	stbx 0,23,30
	bl strcmp
	mr. 3,3
	bc 4,2,.L110
	stb 3,296(1)
	addi 17,17,1
.L110:
	lis 9,.LC12@ha
	mr 3,25
	la 4,.LC12@l(9)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L111
	cmpw 0,29,28
	mr 9,29
	mulli 30,17,72
	addi 4,1,168
	bc 4,0,.L113
	mr 10,4
	mr 11,27
.L115:
	lbzx 0,11,9
	addi 9,9,1
	cmpw 0,9,28
	stbx 0,10,19
	addi 19,19,1
	bc 12,0,.L115
.L113:
	addi 0,19,-1
	add 3,30,20
	stbx 26,4,0
	stb 26,183(1)
	bl strcpy
	li 10,80
	li 0,0
	mtctr 10
	addi 9,1,247
.L204:
	stb 0,0(9)
	addi 9,9,-1
	bdnz .L204
	li 19,0
	stw 19,2532(1)
.L111:
	lis 11,.LC13@ha
	mr 3,25
	la 4,.LC13@l(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L122
	cmpw 0,29,28
	mr 9,29
	mulli 30,17,72
	addi 11,1,248
	bc 4,0,.L124
	mr 8,11
	mr 10,27
.L126:
	lbzx 0,10,9
	addi 9,9,1
	cmpw 0,9,28
	stbx 0,8,18
	addi 18,18,1
	bc 12,0,.L126
.L124:
	addi 0,18,-1
	mr 3,11
	stbx 26,11,0
	bl atoi
	li 11,15
	lis 9,highscore+16@ha
	mtctr 11
	la 9,highscore+16@l(9)
	li 0,0
	mr 10,9
	stwx 3,10,30
	addi 9,1,262
.L203:
	stb 0,0(9)
	addi 9,9,-1
	bdnz .L203
	li 18,0
.L122:
	mr 3,25
	la 4,.LC14@l(14)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L103
	cmpw 0,29,28
	mr 9,29
	mulli 30,17,72
	addi 31,1,264
	bc 4,0,.L135
	mr 10,31
	mr 11,27
.L137:
	lbzx 0,11,9
	addi 9,9,1
	cmpw 0,9,28
	stbx 0,10,21
	addi 21,21,1
	bc 12,0,.L137
.L135:
	lis 9,highscore+35@ha
	addi 0,21,-1
	la 9,highscore+35@l(9)
	stbx 26,31,0
	mr 4,24
	add 3,30,9
	lbz 0,267(1)
	lbz 9,268(1)
	lbz 11,270(1)
	lbz 10,271(1)
	lbz 8,264(1)
	lbz 7,265(1)
	stb 0,280(1)
	stb 9,281(1)
	stb 11,283(1)
	stb 10,284(1)
	stb 8,286(1)
	stb 7,287(1)
	stb 16,282(1)
	stb 16,285(1)
	stb 26,288(1)
	bl strcpy
	lis 9,highscore+20@ha
	mr 4,31
	la 9,highscore+20@l(9)
	add 3,30,9
	bl strcpy
	li 10,15
	mr 4,31
	mtctr 10
	li 0,0
	mr 11,24
	li 9,0
.L202:
	stbx 0,4,9
	stbx 0,11,9
	addi 9,9,1
	bdnz .L202
	lis 11,highscore+68@ha
	li 21,0
	la 11,highscore+68@l(11)
	mr 0,11
	stwx 21,30,0
.L103:
	mr 30,29
	cmpw 0,30,28
	bc 12,0,.L104
.L93:
	mr 3,27
	li 4,80
	mr 5,15
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L95
	mr 3,15
	bl fclose
.L92:
	lwz 3,2556(1)
	bl time
	lwz 3,2556(1)
	bl ctime
	mr 4,3
	lwz 3,2548(1)
	bl strcpy
	lbz 0,428(1)
	li 11,0
	lis 4,.LC15@ha
	lbz 9,429(1)
	la 4,.LC15@l(4)
	mr 3,22
	stb 0,2524(1)
	stb 9,1(22)
	lbz 0,430(1)
	stb 11,3(22)
	stb 0,2(22)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L147
	lis 9,.LC16@ha
	lwz 0,.LC16@l(9)
	b .L209
.L147:
	lis 4,.LC17@ha
	mr 3,22
	la 4,.LC17@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L149
	lis 9,.LC18@ha
	lwz 0,.LC18@l(9)
	b .L209
.L149:
	lis 4,.LC19@ha
	mr 3,22
	la 4,.LC19@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L151
	lis 9,.LC20@ha
	lwz 0,.LC20@l(9)
	b .L209
.L151:
	lis 4,.LC21@ha
	mr 3,22
	la 4,.LC21@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L153
	lis 9,.LC22@ha
	lwz 0,.LC22@l(9)
	b .L209
.L153:
	lis 4,.LC23@ha
	mr 3,22
	la 4,.LC23@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L155
	lis 9,.LC24@ha
	lwz 0,.LC24@l(9)
	b .L209
.L155:
	lis 4,.LC25@ha
	mr 3,22
	la 4,.LC25@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L157
	lis 9,.LC26@ha
	lwz 0,.LC26@l(9)
	b .L209
.L157:
	lis 4,.LC27@ha
	mr 3,22
	la 4,.LC27@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L159
	lis 9,.LC28@ha
	lwz 0,.LC28@l(9)
	b .L209
.L159:
	lis 4,.LC29@ha
	mr 3,22
	la 4,.LC29@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L161
	lis 9,.LC30@ha
	lwz 0,.LC30@l(9)
	b .L209
.L161:
	lis 4,.LC31@ha
	mr 3,22
	la 4,.LC31@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L163
	lis 9,.LC32@ha
	lwz 0,.LC32@l(9)
	b .L209
.L163:
	lis 4,.LC33@ha
	mr 3,22
	la 4,.LC33@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L165
	lis 9,.LC34@ha
	lwz 0,.LC34@l(9)
	b .L209
.L165:
	lis 4,.LC35@ha
	mr 3,22
	la 4,.LC35@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L167
	lis 9,.LC36@ha
	lwz 0,.LC36@l(9)
	b .L209
.L167:
	lis 4,.LC37@ha
	mr 3,22
	la 4,.LC37@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L148
	lis 9,.LC38@ha
	lwz 0,.LC38@l(9)
.L209:
	stw 0,408(1)
.L148:
	lbz 9,432(1)
	li 29,0
	lbz 0,433(1)
	lwz 4,2536(1)
	lwz 3,2544(1)
	stb 9,376(1)
	stb 0,377(1)
	stb 29,378(1)
	bl strcat
	lwz 3,2544(1)
	lis 4,.LC39@ha
	la 4,.LC39@l(4)
	bl strcat
	lbz 9,446(1)
	lbz 0,447(1)
	lwz 4,2540(1)
	lwz 3,2544(1)
	stb 9,392(1)
	stb 0,393(1)
	stb 29,394(1)
	bl strcat
	lbz 10,392(1)
	li 6,47
	lbz 0,393(1)
	lbz 9,408(1)
	lbz 11,409(1)
	lbz 8,376(1)
	lbz 7,377(1)
	stb 10,456(1)
	stb 0,457(1)
	stb 9,459(1)
	stb 11,460(1)
	stb 6,461(1)
	stb 8,462(1)
	stb 7,463(1)
	stb 29,464(1)
	stb 29,416(1)
	stb 6,458(1)
	bc 4,18,.L170
	lis 11,.LC40@ha
	lis 9,.LC41@ha
	lwz 30,.LC40@l(11)
	lis 10,.LC42@ha
	la 7,.LC41@l(9)
	la 11,.LC40@l(11)
	li 0,15
	lwz 3,.LC41@l(9)
	la 8,.LC42@l(10)
	lis 9,highscore@ha
	lwz 4,.LC42@l(10)
	mtctr 0
	lwz 5,4(11)
	la 9,highscore@l(9)
	li 29,1
	lbz 6,8(7)
	addi 9,9,20
	lbz 10,8(8)
	lwz 11,4(7)
	lwz 0,4(8)
.L201:
	stw 29,-4(9)
	stw 30,-20(9)
	stw 5,-16(9)
	stw 3,30(9)
	stw 11,34(9)
	stb 6,38(9)
	stw 4,0(9)
	stw 0,4(9)
	stb 10,8(9)
	addi 9,9,72
	bdnz .L201
.L170:
	lwz 9,2528(1)
	li 10,0
	cmpw 0,10,9
	bc 4,0,.L177
	lis 11,.LC55@ha
	la 11,.LC55@l(11)
	lwz 20,0(11)
.L179:
	lwz 9,2532(1)
	addi 10,10,1
	li 19,0
	stw 10,2552(1)
	li 16,0
	mulli 11,9,36
	lis 10,highscore@ha
	lis 9,.LC55@ha
	la 10,highscore@l(10)
	la 9,.LC55@l(9)
	addi 21,10,68
	lwz 18,0(9)
	mr 17,11
.L183:
	lis 10,gamescore+16@ha
	lwz 0,-52(21)
	la 10,gamescore+16@l(10)
	lwzx 9,10,11
	cmpw 0,9,0
	bc 4,1,.L182
	li 22,14
	lwz 11,2532(1)
	addi 14,1,456
	cmpw 0,22,19
	addi 15,11,1
	bc 4,1,.L186
	addi 29,20,1076
	addi 23,20,986
	addi 24,20,1058
	addi 25,20,956
	addi 26,20,1028
	addi 27,20,971
	addi 28,20,1043
	addi 30,20,936
	addi 31,20,1008
.L188:
	mr 4,30
	mr 3,31
	bl strcpy
	addi 30,30,-72
	addi 31,31,-72
	lwz 9,-124(29)
	addi 0,22,-1
	mr 4,27
	mr 22,0
	mr 3,28
	stw 9,-52(29)
	addi 27,27,-72
	addi 28,28,-72
	bl strcpy
	mr 4,25
	mr 3,26
	bl strcpy
	addi 25,25,-72
	addi 26,26,-72
	mr 3,24
	mr 4,23
	bl strcpy
	addi 23,23,-72
	addi 24,24,-72
	li 0,0
	cmpw 0,22,19
	stw 0,0(29)
	addi 29,29,-72
	bc 12,1,.L188
.L186:
	lis 9,gamescore@ha
	mr 3,18
	la 9,gamescore@l(9)
	add 4,17,9
	bl strcpy
	lis 9,gamescore+16@ha
	stw 15,2532(1)
	lis 10,highscore@ha
	la 9,gamescore+16@l(9)
	la 10,highscore@l(10)
	lwz 4,2544(1)
	lwzx 0,9,17
	addi 3,10,50
	add 3,16,3
	stw 0,-52(21)
	bl strcpy
	lis 9,highscore@ha
	mr 4,14
	la 9,highscore@l(9)
	addi 3,9,20
	add 3,16,3
	bl strcpy
	li 0,1
	stw 0,0(21)
	b .L178
.L182:
	addi 19,19,1
	addi 21,21,72
	cmpwi 0,19,14
	addi 18,18,72
	addi 16,16,72
	bc 4,1,.L183
.L178:
	lwz 10,2552(1)
	lwz 9,2528(1)
	cmpw 0,10,9
	bc 12,0,.L179
.L177:
	lis 4,.LC43@ha
	addi 3,1,8
	la 4,.LC43@l(4)
	bl fopen
	mr. 31,3
	bc 4,2,.L192
	lis 9,gi+4@ha
	lis 3,.LC44@ha
	lwz 0,gi+4@l(9)
	la 3,.LC44@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L193
.L192:
	lis 9,highscore@ha
	li 22,0
	la 24,highscore@l(9)
	lis 19,.LC45@ha
	addi 20,24,20
	addi 21,24,16
	lis 25,.LC48@ha
	lis 26,.LC49@ha
	lis 27,.LC50@ha
	lis 23,.LC46@ha
.L197:
	addi 5,22,1
	mulli 30,22,72
	la 4,.LC45@l(19)
	mr 28,5
	mr 3,31
	crxor 6,6,6
	bl fprintf
	add 29,30,24
	mr 3,29
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L198
	la 4,.LC46@l(23)
	mr 5,29
	mr 3,31
	crxor 6,6,6
	bl fprintf
	lwzx 5,21,30
	lis 4,.LC47@ha
	mr 3,31
	la 4,.LC47@l(4)
	crxor 6,6,6
	bl fprintf
	la 4,.LC48@l(25)
	mr 3,31
	crxor 6,6,6
	bl fprintf
	la 4,.LC49@l(26)
	mr 3,31
	crxor 6,6,6
	bl fprintf
	la 4,.LC50@l(27)
	mr 3,31
	crxor 6,6,6
	bl fprintf
	lis 4,.LC51@ha
	add 5,30,20
	la 4,.LC51@l(4)
	mr 3,31
	crxor 6,6,6
	bl fprintf
	b .L196
.L198:
	lis 4,.LC52@ha
	mr 3,31
	la 4,.LC52@l(4)
	crxor 6,6,6
	bl fprintf
	lis 4,.LC53@ha
	mr 3,31
	la 4,.LC53@l(4)
	crxor 6,6,6
	bl fprintf
	la 4,.LC48@l(25)
	mr 3,31
	crxor 6,6,6
	bl fprintf
	la 4,.LC49@l(26)
	mr 3,31
	crxor 6,6,6
	bl fprintf
	la 4,.LC50@l(27)
	mr 3,31
	crxor 6,6,6
	bl fprintf
	lis 4,.LC54@ha
	mr 3,31
	la 4,.LC54@l(4)
	crxor 6,6,6
	bl fprintf
.L196:
	mr 22,28
	cmpwi 0,22,14
	bc 4,1,.L197
	mr 3,31
	bl fclose
.L193:
	lwz 0,2660(1)
	lwz 12,2580(1)
	mtlr 0
	lmw 14,2584(1)
	mtcrf 8,12
	la 1,2656(1)
	blr
.Lfe3:
	.size	 HighScoreMessage,.Lfe3-HighScoreMessage
	.section	".rodata"
	.align 2
.LC56:
	.string	"xv %i yv 1 string2 \"High Scores for %s\" xv 10 yv 16 string \"Rank\" xv 50 string \"Player\" xv 194 string \"Frags Date\" xv 10 yv 24 string \"---- ---------------   ----- --------\" "
	.align 2
.LC57:
	.string	"xv 18 yv %i string \"%2i  %s\" xv 200 string \"%3i  %s\""
	.align 2
.LC58:
	.string	"xv 18 yv %i string2 \"%2i  %s\" xv 200 string2 \"%3i  %s\""
	.align 2
.LC59:
	.string	"xv 18 yv %i string2 \"%2i  %s\" xv\t200 string2 \"%3i  %s\""
	.align 2
.LC60:
	.string	"misc/pc_up.wav"
	.align 2
.LC61:
	.long 0x3f800000
	.align 2
.LC62:
	.long 0x40400000
	.align 2
.LC63:
	.long 0x0
	.section	".text"
	.align 2
	.globl endLevelshowTop10
	.type	 endLevelshowTop10,@function
endLevelshowTop10:
	stwu 1,-4544(1)
	mflr 0
	stmw 19,4492(1)
	stw 0,4548(1)
	li 11,1400
	mr 19,3
	mtctr 11
	li 20,0
	addi 23,1,3080
	addi 24,1,2056
	li 0,0
	addi 9,1,4479
.L251:
	stb 0,0(9)
	addi 9,9,-1
	bdnz .L251
	lis 9,game@ha
	li 11,0
	la 10,game@l(9)
	li 30,0
	lwz 0,1544(10)
	cmpw 0,11,0
	bc 4,0,.L217
	lis 9,g_edicts@ha
	mr 25,10
	lwz 22,g_edicts@l(9)
	addi 31,1,1032
.L219:
	mulli 9,30,892
	addi 26,30,1
	add 9,9,22
	lwz 0,980(9)
	cmpwi 0,0,0
	bc 12,2,.L218
	lwz 0,1028(25)
	mulli 9,30,3888
	li 29,0
	addi 5,1,1032
	cmpw 0,29,11
	addi 4,1,8
	add 9,9,0
	addi 27,11,1
	lwz 3,3424(9)
	bc 4,0,.L222
	lwz 0,0(31)
	cmpw 0,3,0
	bc 12,1,.L222
	mr 9,5
.L223:
	addi 29,29,1
	cmpw 0,29,11
	bc 4,0,.L222
	lwzu 0,4(9)
	cmpw 0,3,0
	bc 4,1,.L223
.L222:
	cmpw 0,11,29
	mr 7,11
	slwi 28,29,2
	bc 4,1,.L228
	slwi 9,11,2
	mr 6,4
	mr 10,9
	mr 8,5
	addi 11,9,-4
.L230:
	lwzx 9,11,6
	addi 7,7,-1
	cmpw 0,7,29
	stwx 9,10,6
	lwzx 0,11,8
	addi 11,11,-4
	stwx 0,10,8
	addi 10,10,-4
	bc 12,1,.L230
.L228:
	stwx 30,4,28
	mr 11,27
	stwx 3,5,28
.L218:
	lwz 0,1544(25)
	mr 30,26
	cmpw 0,30,0
	bc 12,0,.L219
.L217:
	cmpwi 0,11,0
	bc 4,1,.L234
	mr 30,11
.L236:
	addic. 30,30,-1
	bc 4,2,.L236
.L234:
	lis 29,level+8@ha
	li 27,0
	la 3,level+8@l(29)
	mr 25,24
	bl strlen
	slwi 6,3,3
	lis 5,.LC56@ha
	subfic 6,6,172
	la 7,level+8@l(29)
	la 5,.LC56@l(5)
	srawi 6,6,1
	li 4,1024
	mr 3,24
	crxor 6,6,6
	bl Com_sprintf
	mr 3,24
	bl strlen
	mr 29,3
	mr 4,24
	mr 3,23
	mr 28,29
	bl strcpy
	lis 9,highscore@ha
	la 26,highscore@l(9)
	addi 22,26,16
	addi 21,26,35
.L241:
	mulli 29,27,72
	addi 9,26,68
	slwi 11,27,3
	addi 30,11,32
	lwzx 0,9,29
	cmpwi 0,0,0
	bc 4,2,.L242
	addi 0,27,1
	lwzx 9,22,29
	mr 6,30
	lis 5,.LC57@ha
	add 10,29,21
	add 8,29,26
	la 5,.LC57@l(5)
	b .L252
.L242:
	addi 0,26,50
	add 31,29,0
	mr 3,31
	bl strlen
	cmpwi 0,3,8
	bc 4,2,.L245
	addi 0,27,1
	lwzx 9,22,29
	mr 6,30
	lis 5,.LC58@ha
	add 8,29,26
	la 5,.LC58@l(5)
	mr 10,31
	mr 3,25
	li 4,1024
	mr 7,0
	mr 30,0
	crxor 6,6,6
	bl Com_sprintf
	li 20,1
	b .L253
.L245:
	addi 0,27,1
	lwzx 9,22,29
	mr 6,30
	lis 5,.LC59@ha
	add 10,29,21
	add 8,29,26
	la 5,.LC59@l(5)
.L252:
	mr 3,25
	li 4,1024
	mr 7,0
	mr 30,0
	crxor 6,6,6
	bl Com_sprintf
.L253:
	mr 3,25
	bl strlen
	add 29,28,3
	cmpwi 0,29,1024
	bc 12,1,.L239
	add 3,23,28
	mr 4,24
	bl strcpy
	mr 28,29
	mr 27,30
	cmpwi 0,27,9
	bc 4,1,.L241
.L239:
	cmpwi 0,20,1
	bc 4,2,.L250
	lis 29,gi@ha
	lis 3,.LC60@ha
	la 29,gi@l(29)
	la 3,.LC60@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC61@ha
	lwz 0,16(29)
	lis 11,.LC62@ha
	la 9,.LC61@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC62@l(11)
	li 4,2
	mtlr 0
	lis 9,.LC63@ha
	mr 3,19
	lfs 2,0(11)
	la 9,.LC63@l(9)
	lfs 3,0(9)
	blrl
.L250:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	mr 3,23
	mtlr 0
	blrl
	lwz 0,4548(1)
	mtlr 0
	lmw 19,4492(1)
	la 1,4544(1)
	blr
.Lfe4:
	.size	 endLevelshowTop10,.Lfe4-endLevelshowTop10
	.section	".rodata"
	.align 2
.LC64:
	.string	"i_fixme"
	.align 2
.LC65:
	.string	"tag1"
	.align 2
.LC66:
	.string	"tag2"
	.align 2
.LC67:
	.string	"xv %i yv %i picn %s "
	.align 2
.LC68:
	.string	"client %i %i %i %i %i %i "
	.section	".text"
	.align 2
	.globl DeathmatchScoreboardMessage
	.type	 DeathmatchScoreboardMessage,@function
DeathmatchScoreboardMessage:
	stwu 1,-4560(1)
	mflr 0
	stmw 17,4500(1)
	stw 0,4564(1)
	lis 9,game@ha
	li 25,0
	la 11,game@l(9)
	mr 20,3
	lwz 0,1544(11)
	mr 21,4
	li 28,0
	addi 23,1,1040
	lis 17,gi@ha
	cmpw 0,25,0
	bc 4,0,.L256
	lis 9,g_edicts@ha
	mr 26,11
	lwz 24,g_edicts@l(9)
	addi 31,1,3472
.L258:
	mulli 9,28,892
	addi 27,28,1
	add 29,9,24
	lwz 0,980(29)
	cmpwi 0,0,0
	bc 12,2,.L257
	lwz 0,1028(26)
	mulli 9,28,3888
	li 5,0
	addi 4,1,3472
	cmpw 0,5,25
	addi 3,1,2448
	add 9,9,0
	addi 30,25,1
	lwz 29,3424(9)
	bc 4,0,.L261
	lwz 0,0(31)
	cmpw 0,29,0
	bc 12,1,.L261
	mr 9,4
.L262:
	addi 5,5,1
	cmpw 0,5,25
	bc 4,0,.L261
	lwzu 0,4(9)
	cmpw 0,29,0
	bc 4,1,.L262
.L261:
	cmpw 0,25,5
	mr 7,25
	slwi 12,5,2
	bc 4,1,.L267
	slwi 9,25,2
	mr 6,3
	mr 10,9
	mr 8,4
	addi 11,9,-4
.L269:
	lwzx 9,11,6
	addi 7,7,-1
	cmpw 0,7,5
	stwx 9,10,6
	lwzx 0,11,8
	addi 11,11,-4
	stwx 0,10,8
	addi 10,10,-4
	bc 12,1,.L269
.L267:
	stwx 28,3,12
	mr 25,30
	stwx 29,4,12
.L257:
	lwz 0,1544(26)
	mr 28,27
	cmpw 0,28,0
	bc 12,0,.L258
.L256:
	li 0,0
	mr 3,23
	stb 0,1040(1)
	li 28,0
	bl strlen
	cmpwi 7,25,13
	mr 30,3
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 0,25,0
	rlwinm 9,9,0,28,29
	or 25,0,9
	cmpw 0,28,25
	bc 4,0,.L274
	lis 9,game@ha
	lis 18,g_edicts@ha
	la 19,game@l(9)
	addi 24,1,2448
	li 22,0
.L276:
	addi 9,1,2448
	la 11,gi@l(17)
	lwz 10,1028(19)
	lwzx 0,9,22
	lis 3,.LC64@ha
	lwz 8,40(11)
	la 3,.LC64@l(3)
	mulli 9,0,892
	lwz 11,g_edicts@l(18)
	mtlr 8
	mulli 0,0,3888
	addi 9,9,892
	add 29,11,9
	add 31,10,0
	blrl
	lis 9,0x2aaa
	srawi 11,28,31
	ori 9,9,43691
	cmpwi 7,28,6
	mulhw 9,28,9
	cmpw 6,29,20
	subf 9,11,9
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	mulli 9,9,6
	neg 0,0
	andi. 26,0,160
	subf 9,9,28
	slwi 9,9,5
	addi 27,9,32
	bc 4,26,.L279
	lis 9,.LC65@ha
	la 8,.LC65@l(9)
	b .L280
.L279:
	cmpw 0,29,21
	bc 4,2,.L281
	lis 9,.LC66@ha
	la 8,.LC66@l(9)
	b .L280
.L281:
	li 8,0
.L280:
	cmpwi 0,8,0
	bc 12,2,.L283
	lis 5,.LC67@ha
	addi 3,1,16
	la 5,.LC67@l(5)
	li 4,1024
	addi 6,26,32
	mr 7,27
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 29,30,3
	cmpwi 0,29,1024
	bc 12,1,.L274
	add 3,23,30
	addi 4,1,16
	bl strcpy
	mr 30,29
.L283:
	lis 9,level@ha
	lwz 10,3420(31)
	lis 0,0x1b4e
	lwz 11,level@l(9)
	ori 0,0,33205
	lis 5,.LC68@ha
	lwz 8,0(24)
	addi 3,1,16
	la 5,.LC68@l(5)
	subf 11,10,11
	lwz 9,3424(31)
	mr 6,26
	mulhw 0,11,0
	lwz 10,184(31)
	mr 7,27
	li 4,1024
	srawi 11,11,31
	addi 24,24,4
	srawi 0,0,6
	subf 0,11,0
	stw 0,8(1)
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 29,30,3
	cmpwi 0,29,1024
	bc 12,1,.L274
	add 3,23,30
	addi 4,1,16
	bl strcpy
	addi 28,28,1
	mr 30,29
	cmpw 0,28,25
	addi 22,22,4
	bc 12,0,.L276
.L274:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	mr 3,23
	mtlr 0
	blrl
	lwz 0,4564(1)
	mtlr 0
	lmw 17,4500(1)
	la 1,4560(1)
	blr
.Lfe5:
	.size	 DeathmatchScoreboardMessage,.Lfe5-DeathmatchScoreboardMessage
	.section	".rodata"
	.align 2
.LC69:
	.string	"xv 24 yv 16 string2 \"Rank\" xv 64 yv 16 string2 \"Player\" xv 232 yv 16 string2 \"Frags\" xv 280 yv 16 string2 \"Ping\" xv 320 yv 16 string2 \"Time\" xv 24 yv 24 string2 \"-----------------------------------------\" "
	.align 2
.LC70:
	.string	"xv 40 yv %i string \"%2i\" "
	.align 2
.LC71:
	.string	"xv 64 yv %i string2 \"%s\" xv 232 yv %i string \"  %3i  %3i  %3i\" "
	.section	".text"
	.align 2
	.globl DeathmatchScoreboardMessage2
	.type	 DeathmatchScoreboardMessage2,@function
DeathmatchScoreboardMessage2:
	stwu 1,-4544(1)
	mflr 0
	stmw 22,4504(1)
	stw 0,4548(1)
	lis 9,game@ha
	li 27,0
	la 11,game@l(9)
	li 28,0
	lwz 0,1544(11)
	addi 25,1,1040
	lis 22,gi@ha
	cmpw 0,27,0
	bc 4,0,.L289
	lis 9,g_edicts@ha
	mr 31,11
	lwz 23,g_edicts@l(9)
	addi 24,1,3472
.L291:
	mulli 9,28,892
	addi 26,28,1
	add 9,9,23
	lwz 0,980(9)
	cmpwi 0,0,0
	bc 12,2,.L290
	lwz 0,1028(31)
	mulli 9,28,3888
	li 5,0
	addi 4,1,3472
	cmpw 0,5,27
	addi 3,1,2448
	add 9,9,0
	addi 12,27,1
	lwz 29,3424(9)
	bc 4,0,.L294
	lwz 0,0(24)
	cmpw 0,29,0
	bc 12,1,.L294
	mr 9,4
.L295:
	addi 5,5,1
	cmpw 0,5,27
	bc 4,0,.L294
	lwzu 0,4(9)
	cmpw 0,29,0
	bc 4,1,.L295
.L294:
	cmpw 0,27,5
	mr 7,27
	slwi 30,5,2
	bc 4,1,.L300
	slwi 9,27,2
	mr 6,3
	mr 10,9
	mr 8,4
	addi 11,9,-4
.L302:
	lwzx 9,11,6
	addi 7,7,-1
	cmpw 0,7,5
	stwx 9,10,6
	lwzx 0,11,8
	addi 11,11,-4
	stwx 0,10,8
	addi 10,10,-4
	bc 12,1,.L302
.L300:
	stwx 28,3,30
	mr 27,12
	stwx 29,4,30
.L290:
	lwz 0,1544(31)
	mr 28,26
	cmpw 0,28,0
	bc 12,0,.L291
.L289:
	li 0,0
	mr 3,25
	stb 0,1040(1)
	bl strlen
	mr 30,3
	lis 5,.LC69@ha
	addi 3,1,16
	la 5,.LC69@l(5)
	li 4,1024
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 29,30,3
	cmpwi 0,29,1023
	bc 12,1,.L305
	add 3,25,30
	addi 4,1,16
	bl strcpy
	mr 30,29
.L305:
	cmpwi 7,27,26
	li 28,0
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	andi. 9,9,25
	and 0,27,0
	or 27,0,9
	cmpw 0,28,27
	bc 4,0,.L308
	lis 9,game@ha
	la 24,game@l(9)
.L310:
	slwi 10,28,2
	addi 9,1,2448
	lwz 8,1028(24)
	lwzx 0,9,10
	la 11,gi@l(22)
	lis 3,.LC64@ha
	lwz 9,40(11)
	la 3,.LC64@l(3)
	addi 26,28,1
	mulli 0,0,3888
	mtlr 9
	add 31,8,0
	blrl
	slwi 9,28,3
	lis 5,.LC70@ha
	addi 28,9,32
	addi 3,1,16
	la 5,.LC70@l(5)
	li 4,1024
	mr 6,28
	mr 7,26
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 29,30,3
	cmpwi 0,29,1024
	bc 12,1,.L308
	addi 4,1,16
	add 3,25,30
	bl strcpy
	mr 30,29
	lis 9,level@ha
	lwz 10,3420(31)
	lis 0,0x1b4e
	lwz 11,level@l(9)
	ori 0,0,33205
	mr 6,28
	lwz 9,3424(31)
	lis 5,.LC71@ha
	addi 3,1,16
	subf 11,10,11
	mr 8,6
	mulhw 0,11,0
	lwz 10,184(31)
	la 5,.LC71@l(5)
	addi 7,31,700
	srawi 11,11,31
	li 4,1024
	srawi 0,0,6
	subf 0,11,0
	stw 0,8(1)
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 29,30,3
	cmpwi 0,29,1024
	bc 12,1,.L308
	add 3,25,30
	addi 4,1,16
	bl strcpy
	mr 28,26
	mr 30,29
	cmpw 0,28,27
	bc 12,0,.L310
.L308:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	mr 3,25
	mtlr 0
	blrl
	lwz 0,4548(1)
	mtlr 0
	lmw 22,4504(1)
	la 1,4544(1)
	blr
.Lfe6:
	.size	 DeathmatchScoreboardMessage2,.Lfe6-DeathmatchScoreboardMessage2
	.section	".rodata"
	.align 2
.LC72:
	.string	"Rankings"
	.string	""
	.align 2
.LC73:
	.string	"xv %i yv %i picn %s xv %i yv %i string \"%10s\" "
	.align 2
.LC74:
	.string	"ctf 80 %d %d %d %d "
	.align 2
.LC75:
	.string	"ctf 0 %d %d %d %d "
	.align 2
.LC76:
	.string	"ctf 160 %d %d %d %d "
	.align 2
.LC77:
	.string	"xv 0 yv %d string2 \"Spectators\" "
	.align 2
.LC78:
	.string	"ctf %d %d %d %d %d "
	.align 2
.LC79:
	.string	"xv 8 yv %d string \"..and %d more\" "
	.align 2
.LC80:
	.string	"xv 168 yv %d string \"..and %d more\" "
	.align 2
.LC81:
	.long 0x0
	.align 3
.LC82:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl DeathmatchScoreboardMessage3
	.type	 DeathmatchScoreboardMessage3,@function
DeathmatchScoreboardMessage3:
	stwu 1,-6672(1)
	mflr 0
	mfcr 12
	stmw 14,6600(1)
	stw 0,6676(1)
	stw 12,6596(1)
	lis 9,.LC72@ha
	lis 11,game@ha
	lwz 10,.LC72@l(9)
	la 6,game@l(11)
	li 8,0
	la 9,.LC72@l(9)
	addi 11,1,6544
	lwz 0,4(9)
	li 26,0
	mr 16,11
	lbz 7,8(9)
	li 24,0
	li 25,0
	stw 10,6544(1)
	addi 9,1,6560
	addi 22,1,1040
	stw 0,4(11)
	stb 7,8(11)
	lwz 0,1544(6)
	addi 11,1,6568
	stw 8,4(9)
	stw 8,6560(1)
	cmpw 0,24,0
	stw 26,4(11)
	stw 26,6568(1)
	bc 4,0,.L316
	lis 9,g_edicts@ha
	addi 31,1,6560
	lwz 18,g_edicts@l(9)
	mr 20,6
	mr 21,11
	addi 19,1,4496
	mr 17,31
.L318:
	mulli 9,24,892
	addi 23,24,1
	add 10,9,18
	lwz 0,980(10)
	cmpwi 0,0,0
	bc 12,2,.L317
	lwz 0,1028(20)
	mulli 9,24,3888
	add 9,9,0
	lwz 11,3428(9)
	cmpwi 0,11,1
	bc 4,2,.L317
	lwz 0,6560(1)
	li 28,0
	li 11,0
	lwz 12,3424(9)
	addi 3,1,4496
	addi 4,1,2448
	cmpw 0,28,0
	bc 4,0,.L323
	lwz 0,0(19)
	cmpw 0,12,0
	bc 12,1,.L323
	lwzx 10,28,17
	mr 9,3
.L324:
	addi 28,28,1
	cmpw 0,28,10
	bc 4,0,.L323
	lwzu 0,4(9)
	cmpw 0,12,0
	bc 4,1,.L324
.L323:
	slwi 0,11,2
	slwi 7,11,10
	lwzx 30,31,0
	mr 5,0
	slwi 27,28,2
	cmpw 0,30,28
	bc 4,1,.L329
	addi 11,4,-4
	slwi 9,30,2
	add 11,7,11
	addi 0,3,-4
	add 0,7,0
	add 10,9,11
	mr 29,4
	add 8,9,0
	add 11,9,7
	mr 6,3
.L331:
	lwz 9,0(10)
	addi 30,30,-1
	cmpw 0,30,28
	addi 10,10,-4
	stwx 9,11,29
	lwz 0,0(8)
	addi 8,8,-4
	stwx 0,11,6
	addi 11,11,-4
	bc 12,1,.L331
.L329:
	add 0,27,7
	stwx 24,4,0
	stwx 12,3,0
	lwzx 9,5,21
	lwzx 11,5,31
	add 9,9,12
	addi 11,11,1
	stwx 9,5,21
	stwx 11,5,31
.L317:
	lwz 0,1544(20)
	mr 24,23
	cmpw 0,24,0
	bc 12,0,.L318
.L316:
	li 0,0
	mr 3,22
	stb 0,1040(1)
	li 14,100
	li 20,900
	bl strlen
	lis 9,gi+40@ha
	mr 29,3
	lwz 0,gi+40@l(9)
	lis 3,.LC64@ha
	la 3,.LC64@l(3)
	mtlr 0
	blrl
	cmpwi 7,24,6
	lis 8,.LC66@ha
	stw 16,8(1)
	lis 5,.LC73@ha
	addi 3,1,16
	li 10,18
	la 5,.LC73@l(5)
	cror 31,30,29
	mfcr 6
	rlwinm 6,6,0,1
	la 8,.LC66@l(8)
	neg 6,6
	li 7,5
	andi. 6,6,160
	li 4,1024
	addi 9,6,-55
	li 24,0
	addi 6,6,-58
	crxor 6,6,6
	bl Com_sprintf
	addi 4,1,16
	mr 3,22
	bl strcat
	addi 3,1,16
	bl strlen
	add 3,22,29
	addi 4,1,16
	bl strcpy
	lwz 0,6560(1)
	cmpw 0,24,0
	bc 4,0,.L337
	lis 9,game@ha
	addi 21,1,16
	la 19,game@l(9)
	li 23,42
	li 27,42
	li 28,42
	li 30,0
.L340:
	lwz 9,6560(1)
	li 0,0
	stb 0,16(1)
	cmpw 0,24,9
	bc 4,0,.L338
	addi 29,1,2448
	cmpwi 0,9,11
	lwzx 0,29,30
	lwz 9,1028(19)
	mulli 0,0,3888
	add 31,9,0
	bc 12,1,.L342
	addi 3,1,16
	bl strlen
	lwz 9,184(31)
	lis 4,.LC74@ha
	add 3,21,3
	lwzx 6,29,30
	la 4,.LC74@l(4)
	mr 5,28
	b .L368
.L342:
	cmpwi 0,24,11
	bc 12,1,.L345
	addi 3,1,16
	bl strlen
	lwz 9,184(31)
	lis 4,.LC75@ha
	add 3,21,3
	lwzx 6,29,30
	la 4,.LC75@l(4)
	mr 5,27
.L368:
	cmpwi 7,9,1000
	lwz 7,3424(31)
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 8,0,0
	and 9,9,0
	andi. 8,8,999
	or 8,9,8
	crxor 6,6,6
	bl sprintf
	b .L344
.L345:
	addi 0,24,-12
	cmplwi 0,0,11
	bc 12,1,.L344
	addi 3,1,16
	bl strlen
	lwz 9,184(31)
	lis 4,.LC76@ha
	add 3,21,3
	lwzx 6,29,30
	la 4,.LC76@l(4)
	mr 5,23
	cmpwi 7,9,1000
	lwz 7,3424(31)
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 8,0,0
	and 9,9,0
	andi. 8,8,999
	or 8,9,8
	crxor 6,6,6
	bl sprintf
.L344:
	addi 3,1,16
	bl strlen
	cmplw 0,20,3
	bc 4,1,.L338
	mr 3,22
	addi 4,1,16
	bl strcat
	li 14,100
	mr 25,24
.L338:
	addi 24,24,1
	addi 23,23,8
	cmpwi 0,24,31
	addi 27,27,8
	addi 28,28,8
	addi 30,30,4
	bc 12,1,.L337
	lwz 0,6560(1)
	cmpw 0,24,0
	bc 12,0,.L340
.L337:
	cmpwi 0,20,50
	slwi 9,25,3
	addi 28,9,58
	li 19,0
	li 30,0
	bc 4,1,.L352
	lis 9,maxclients@ha
	lis 10,.LC81@ha
	lwz 11,maxclients@l(9)
	la 10,.LC81@l(10)
	li 24,0
	lfs 13,0(10)
	lis 15,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L352
	lis 9,game@ha
	lis 16,g_edicts@ha
	la 17,game@l(9)
	mr 23,22
	lis 18,0x4330
	li 20,0
	li 21,892
.L356:
	lwz 0,g_edicts@l(16)
	lwz 11,1028(17)
	add 10,0,21
	lwz 9,88(10)
	add 31,11,20
	cmpwi 0,9,0
	bc 12,2,.L355
	lwz 0,248(10)
	cmpwi 0,0,0
	bc 4,2,.L355
	lwz 9,84(10)
	lwz 0,3428(9)
	cmpwi 0,0,0
	bc 4,2,.L355
	cmpwi 0,30,0
	bc 4,2,.L359
	lis 4,.LC77@ha
	mr 5,28
	la 4,.LC77@l(4)
	addi 3,1,16
	crxor 6,6,6
	bl sprintf
	li 30,1
	li 14,100
	mr 3,22
	addi 4,1,16
	bl strcat
	addi 28,28,8
.L359:
	addi 3,1,16
	subfic 29,14,1000
	mr 27,3
	bl strlen
	lwz 11,184(31)
	rlwinm 5,19,0,31,31
	lis 4,.LC78@ha
	cmpwi 4,5,0
	lwz 8,3424(31)
	la 4,.LC78@l(4)
	cmpwi 7,11,1000
	neg 5,5
	andi. 5,5,160
	mr 6,28
	mr 7,24
	add 3,27,3
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 11,11,0
	andi. 9,9,999
	or 9,11,9
	crxor 6,6,6
	bl sprintf
	mr 3,27
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L363
	mr 4,27
	mr 3,23
	bl strcat
	mr 3,23
	bl strlen
	mr 14,3
.L363:
	mfcr 0
	rlwinm 0,0,19,1
	addi 9,28,8
	neg 0,0
	addi 19,19,1
	andc 9,9,0
	and 0,28,0
	or 28,0,9
.L355:
	addi 24,24,1
	lwz 11,maxclients@l(15)
	xoris 0,24,0x8000
	lis 10,.LC82@ha
	stw 0,6588(1)
	la 10,.LC82@l(10)
	addi 20,20,3888
	stw 18,6584(1)
	addi 21,21,892
	lfd 12,0(10)
	lfd 0,6584(1)
	lfs 13,20(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L356
.L352:
	lwz 0,6560(1)
	subf 0,25,0
	cmpwi 0,0,1
	bc 4,1,.L366
	mr 3,22
	bl strlen
	lwz 6,6560(1)
	slwi 5,25,3
	lis 4,.LC79@ha
	la 4,.LC79@l(4)
	addi 5,5,50
	subf 6,25,6
	add 3,22,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L366:
	lwz 0,6564(1)
	subf 0,26,0
	cmpwi 0,0,1
	bc 4,1,.L367
	mr 3,22
	bl strlen
	lwz 6,6564(1)
	slwi 5,26,3
	lis 4,.LC80@ha
	la 4,.LC80@l(4)
	addi 5,5,50
	subf 6,26,6
	add 3,22,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L367:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	mr 3,22
	mtlr 0
	blrl
	lwz 0,6676(1)
	lwz 12,6596(1)
	mtlr 0
	lmw 14,6600(1)
	mtcrf 8,12
	la 1,6672(1)
	blr
.Lfe7:
	.size	 DeathmatchScoreboardMessage3,.Lfe7-DeathmatchScoreboardMessage3
	.section	".rodata"
	.align 2
.LC83:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Score_f
	.type	 Cmd_Score_f,@function
Cmd_Score_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	li 30,0
	lwz 9,84(31)
	stw 30,3520(9)
	lwz 11,84(31)
	stw 30,3524(11)
	lwz 9,84(31)
	lwz 0,3516(9)
	cmpwi 0,0,0
	bc 12,2,.L377
	bl PMenu_Close
.L377:
	lis 11,.LC83@ha
	lis 9,deathmatch@ha
	la 11,.LC83@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L378
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L376
.L378:
	lwz 11,84(31)
	lwz 0,3508(11)
	cmpwi 0,0,0
	bc 12,2,.L379
	stw 30,3508(11)
	b .L376
.L379:
	lis 9,scoreboard@ha
	li 0,1
	lwz 9,scoreboard@l(9)
	stw 0,3508(11)
	cmpwi 0,9,0
	bc 4,2,.L380
	lwz 4,540(31)
	mr 3,31
	bl DeathmatchScoreboardMessage
	b .L381
.L380:
	cmpwi 0,9,1
	bc 4,2,.L382
	lwz 4,540(31)
	mr 3,31
	bl DeathmatchScoreboardMessage2
	b .L381
.L382:
	cmpwi 0,9,2
	bc 4,2,.L384
	lwz 4,540(31)
	mr 3,31
	bl DeathmatchScoreboardMessage3
	b .L381
.L384:
	lwz 4,540(31)
	mr 3,31
	bl DeathmatchScoreboardMessage
.L381:
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L376:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 Cmd_Score_f,.Lfe8-Cmd_Score_f
	.section	".rodata"
	.align 2
.LC84:
	.string	"easy"
	.align 2
.LC85:
	.string	"medium"
	.align 2
.LC86:
	.string	"hard"
	.align 2
.LC87:
	.string	"hard+"
	.align 2
.LC88:
	.string	"xv 32 yv 8 picn help xv 202 yv 12 string2 \"%s\" xv 0 yv 24 cstring2 \"%s\" xv 0 yv 54 cstring2 \"%s\" xv 0 yv 110 cstring2 \"%s\" xv 50 yv 164 string2 \" kills     goals    secrets\" xv 50 yv 172 string2 \"%3i/%3i     %i/%i       %i/%i\" "
	.align 2
.LC89:
	.long 0x0
	.align 2
.LC90:
	.long 0x3f800000
	.align 2
.LC91:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl HelpComputer
	.type	 HelpComputer,@function
HelpComputer:
	stwu 1,-1088(1)
	mflr 0
	stmw 26,1064(1)
	stw 0,1092(1)
	lis 11,.LC89@ha
	lis 9,skill@ha
	la 11,.LC89@l(11)
	mr 31,3
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L388
	lis 9,.LC84@ha
	la 6,.LC84@l(9)
	b .L389
.L388:
	lis 9,.LC90@ha
	la 9,.LC90@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L390
	lis 9,.LC85@ha
	la 6,.LC85@l(9)
	b .L389
.L390:
	lis 11,.LC91@ha
	la 11,.LC91@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L392
	lis 9,.LC86@ha
	la 6,.LC86@l(9)
	b .L389
.L392:
	lis 9,.LC87@ha
	la 6,.LC87@l(9)
.L389:
	lis 11,level@ha
	lis 8,game@ha
	la 11,level@l(11)
	la 8,game@l(8)
	lwz 0,272(11)
	lis 5,.LC88@ha
	addi 9,8,512
	lwz 29,268(11)
	li 4,1024
	addi 3,1,32
	lwz 26,284(11)
	addi 7,11,8
	la 5,.LC88@l(5)
	lwz 27,280(11)
	lwz 28,276(11)
	lwz 10,288(11)
	stw 0,20(1)
	stw 29,24(1)
	stw 26,8(1)
	stw 27,12(1)
	stw 28,16(1)
	crxor 6,6,6
	bl Com_sprintf
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	addi 3,1,32
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,31
	li 4,1
	mtlr 0
	blrl
	lwz 0,1092(1)
	mtlr 0
	lmw 26,1064(1)
	la 1,1088(1)
	blr
.Lfe9:
	.size	 HelpComputer,.Lfe9-HelpComputer
	.section	".rodata"
	.align 2
.LC92:
	.string	"cells"
	.align 2
.LC93:
	.string	"misc/power2.wav"
	.align 2
.LC94:
	.string	"i_powershield"
	.align 2
.LC95:
	.string	"p_quad"
	.align 2
.LC96:
	.string	"p_invulnerability"
	.align 2
.LC97:
	.string	"p_envirosuit"
	.align 2
.LC98:
	.string	"p_rebreather"
	.align 2
.LC99:
	.string	"world/10_0.wav"
	.align 2
.LC100:
	.string	"i_help"
	.align 2
.LC101:
	.long 0x3f800000
	.align 2
.LC102:
	.long 0x0
	.align 3
.LC103:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC104:
	.long 0x41200000
	.align 2
.LC105:
	.long 0x42700000
	.align 2
.LC106:
	.long 0x41300000
	.align 2
.LC107:
	.long 0x42b60000
	.section	".text"
	.align 2
	.globl G_SetStats
	.type	 G_SetStats,@function
G_SetStats:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	lis 9,level+266@ha
	mr 31,3
	lhz 0,level+266@l(9)
	lis 27,level@ha
	lwz 9,84(31)
	sth 0,120(9)
	lwz 11,84(31)
	lhz 0,482(31)
	sth 0,122(11)
	lwz 9,84(31)
	lwz 11,3532(9)
	cmpwi 0,11,0
	bc 4,2,.L398
	sth 11,124(9)
	lwz 9,84(31)
	sth 11,126(9)
	b .L399
.L398:
	mulli 11,11,72
	lis 10,gi+40@ha
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	lwz 0,gi+40@l(10)
	add 11,11,9
	lwz 3,36(11)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,124(9)
	lwz 11,84(31)
	lwz 9,3532(11)
	slwi 9,9,2
	add 9,11,9
	lhz 0,742(9)
	sth 0,126(11)
.L399:
	mr 3,31
	bl PowerArmorType
	mr. 28,3
	bc 12,2,.L400
	lis 3,.LC92@ha
	lwz 29,84(31)
	la 3,.LC92@l(3)
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
	lwzx 30,29,3
	cmpwi 0,30,0
	bc 4,2,.L400
	lwz 0,264(31)
	lis 29,gi@ha
	lis 3,.LC93@ha
	la 29,gi@l(29)
	la 3,.LC93@l(3)
	rlwinm 0,0,0,20,18
	li 28,0
	stw 0,264(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC101@ha
	lwz 0,16(29)
	lis 11,.LC101@ha
	la 9,.LC101@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC101@l(11)
	li 4,3
	mtlr 0
	lis 9,.LC102@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC102@l(9)
	lfs 3,0(9)
	blrl
.L400:
	mr 3,31
	bl ArmorIndex
	cmpwi 0,28,0
	mr 29,3
	bc 12,2,.L402
	cmpwi 0,29,0
	bc 12,2,.L403
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L402
.L403:
	lis 9,gi+40@ha
	lis 3,.LC94@ha
	lwz 0,gi+40@l(9)
	la 3,.LC94@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,128(9)
	lwz 11,84(31)
	sth 30,130(11)
	b .L404
.L402:
	cmpwi 0,29,0
	bc 12,2,.L405
	mr 3,29
	bl GetItemByIndex
	lis 9,gi+40@ha
	lwz 3,36(3)
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
	lwz 11,84(31)
	slwi 9,29,2
	sth 3,128(11)
	lwz 10,84(31)
	add 9,10,9
	lhz 0,742(9)
	sth 0,130(10)
	b .L404
.L405:
	lwz 9,84(31)
	sth 29,128(9)
	lwz 11,84(31)
	sth 29,130(11)
.L404:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3760(11)
	fcmpu 0,13,0
	bc 4,1,.L407
	li 0,0
	sth 0,134(11)
	lwz 9,84(31)
	sth 0,136(9)
.L407:
	lwz 0,level@l(27)
	lis 30,0x4330
	lis 11,.LC103@ha
	xoris 0,0,0x8000
	la 11,.LC103@l(11)
	stw 0,28(1)
	stw 30,24(1)
	lfd 31,0(11)
	lfd 0,24(1)
	lwz 11,84(31)
	fsub 0,0,31
	lfs 13,3728(11)
	frsp 12,0
	fcmpu 0,13,12
	bc 4,1,.L408
	lis 9,gi+40@ha
	lis 3,.LC95@ha
	lwz 0,gi+40@l(9)
	la 3,.LC95@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC104@ha
	la 11,.LC104@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3728(10)
	b .L461
.L408:
	lfs 0,3732(11)
	fcmpu 0,0,12
	bc 4,1,.L410
	lis 9,gi+40@ha
	lis 3,.LC96@ha
	lwz 0,gi+40@l(9)
	la 3,.LC96@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC104@ha
	la 11,.LC104@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3732(10)
	b .L461
.L410:
	lfs 0,3740(11)
	fcmpu 0,0,12
	bc 4,1,.L412
	lis 9,gi+40@ha
	lis 3,.LC97@ha
	lwz 0,gi+40@l(9)
	la 3,.LC97@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC104@ha
	la 11,.LC104@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3740(10)
	b .L461
.L412:
	lfs 0,3736(11)
	fcmpu 0,0,12
	bc 4,1,.L414
	lis 9,gi+40@ha
	lis 3,.LC98@ha
	lwz 0,gi+40@l(9)
	la 3,.LC98@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC104@ha
	la 11,.LC104@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3736(10)
.L461:
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,24(1)
	lwz 11,28(1)
	sth 11,140(10)
	b .L409
.L414:
	li 0,0
	sth 0,138(11)
	lwz 9,84(31)
	sth 0,140(9)
.L409:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L416
	li 0,0
	sth 0,132(9)
	b .L417
.L416:
	lis 9,itemlist@ha
	lis 11,gi+40@ha
	mulli 0,0,72
	la 9,itemlist@l(9)
	lwz 11,gi+40@l(11)
	addi 9,9,36
	lwzx 3,9,0
	mtlr 11
	blrl
	lwz 9,84(31)
	sth 3,132(9)
.L417:
	lwz 11,84(31)
	lis 9,deathmatch@ha
	li 10,0
	lwz 8,deathmatch@l(9)
	lhz 0,738(11)
	lis 9,.LC102@ha
	la 9,.LC102@l(9)
	sth 0,144(11)
	lfs 13,0(9)
	lwz 9,84(31)
	sth 10,146(9)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L418
	lwz 11,84(31)
	lwz 0,724(11)
	cmpwi 0,0,0
	bc 4,1,.L420
	lis 9,level+200@ha
	lfs 0,level+200@l(9)
	fcmpu 0,0,13
	bc 4,2,.L420
	lwz 0,3508(11)
	cmpwi 0,0,0
	bc 12,2,.L423
.L420:
	lwz 9,84(31)
	b .L424
.L418:
	lwz 9,84(31)
	lwz 0,3508(9)
	cmpwi 0,0,0
	bc 4,2,.L424
	lwz 0,3524(9)
	cmpwi 0,0,0
	bc 12,2,.L423
.L424:
	lhz 0,146(9)
	ori 0,0,1
	sth 0,146(9)
.L423:
	lwz 9,84(31)
	lwz 0,3520(9)
	cmpwi 0,0,0
	bc 12,2,.L422
	lwz 0,724(9)
	cmpwi 0,0,0
	bc 4,1,.L422
	lhz 0,146(9)
	ori 0,0,2
	sth 0,146(9)
.L422:
	lis 9,timehud@ha
	lwz 11,84(31)
	lwz 10,timehud@l(9)
	lhz 0,3426(11)
	cmpwi 0,10,0
	sth 0,148(11)
	bc 4,2,.L426
	lwz 9,84(31)
	sth 10,152(9)
	b .L427
.L426:
	lis 28,timelimit@ha
	lis 11,.LC102@ha
	lwz 9,timelimit@l(28)
	la 11,.LC102@l(11)
	lfs 13,0(11)
	lfs 10,20(9)
	fcmpu 0,10,13
	bc 12,2,.L427
	lis 9,level@ha
	la 30,level@l(9)
	lfs 0,200(30)
	fcmpu 0,0,13
	bc 4,2,.L427
	lis 9,.LC105@ha
	lfs 12,4(30)
	lis 11,.LC101@ha
	la 9,.LC105@l(9)
	la 11,.LC101@l(11)
	lfs 31,0(9)
	lfs 11,0(11)
	fmsubs 12,10,31,12
	fdivs 0,12,31
	fadds 0,0,11
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	cmpwi 0,0,1
	bc 4,1,.L429
	lwz 9,84(31)
	b .L462
.L429:
	cmpwi 0,0,0
	bc 4,1,.L431
	lis 9,.LC106@ha
	la 9,.LC106@l(9)
	lfs 0,0(9)
	fcmpu 0,12,0
	bc 4,2,.L432
	lis 29,gi@ha
	lis 3,.LC99@ha
	la 29,gi@l(29)
	la 3,.LC99@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC101@ha
	lwz 0,16(29)
	lis 11,.LC102@ha
	la 9,.LC101@l(9)
	la 11,.LC102@l(11)
	lfs 1,0(9)
	mr 5,3
	li 4,8
	mtlr 0
	lis 9,.LC102@ha
	lfs 2,0(11)
	mr 3,31
	la 9,.LC102@l(9)
	lfs 3,0(9)
	blrl
	lwz 11,timelimit@l(28)
	lfs 12,4(30)
	lfs 0,20(11)
	lwz 10,84(31)
	fmsubs 0,0,31,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	sth 9,152(10)
	b .L427
.L432:
	fmr 13,12
	lwz 11,84(31)
	fctiwz 0,13
	stfd 0,24(1)
	lwz 9,28(1)
	sth 9,152(11)
	b .L427
.L431:
	lwz 9,84(31)
	li 0,0
.L462:
	sth 0,152(9)
.L427:
	lis 9,rankhud@ha
	lwz 0,rankhud@l(9)
	cmpwi 0,0,0
	bc 4,2,.L435
	lwz 9,84(31)
	sth 0,156(9)
	b .L436
.L435:
	lis 9,game@ha
	lwz 11,84(31)
	li 8,1
	la 10,game@l(9)
	lwz 0,1544(10)
	lwz 7,3424(11)
	cmpwi 0,0,0
	bc 4,1,.L438
	lis 9,g_edicts@ha
	mtctr 0
	mr 6,10
	lwz 11,g_edicts@l(9)
	li 10,0
	addi 11,11,980
.L440:
	lwz 0,0(11)
	addi 11,11,892
	cmpwi 0,0,0
	bc 12,2,.L439
	lwz 9,1028(6)
	add 9,10,9
	lwz 0,3424(9)
	cmpw 0,0,7
	bc 4,1,.L439
	addi 0,8,1
	extsh 8,0
.L439:
	addi 10,10,3888
	bdnz .L440
.L438:
	lwz 9,84(31)
	sth 8,156(9)
.L436:
	lis 9,playershud@ha
	lwz 0,playershud@l(9)
	cmpwi 0,0,0
	bc 4,2,.L444
	lwz 9,84(31)
	sth 0,158(9)
	b .L445
.L444:
	lis 9,game+1544@ha
	li 10,0
	lwz 0,game+1544@l(9)
	cmpw 0,10,0
	bc 4,0,.L447
	lis 11,g_edicts@ha
	mtctr 0
	lwz 9,g_edicts@l(11)
	addi 11,9,980
.L449:
	lwz 0,0(11)
	addi 9,10,1
	addi 11,11,892
	addic 0,0,-1
	subfe 0,0,0
	andc 9,9,0
	and 0,10,0
	or 10,0,9
	bdnz .L449
.L447:
	lwz 9,84(31)
	sth 10,158(9)
.L445:
	lwz 30,84(31)
	lwz 0,3848(30)
	cmpwi 0,0,0
	bc 12,2,.L452
	lwz 0,260(31)
	cmpwi 0,0,1
	bc 12,2,.L452
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 3,9,3
	addi 11,30,740
	mullw 3,3,0
	srawi 3,3,3
	slwi 3,3,2
	lwzx 30,11,3
	cmpwi 0,30,0
	bc 12,2,.L453
	lwz 9,84(31)
	li 0,1
	sth 0,162(9)
	lwz 11,84(31)
	sth 30,164(11)
	b .L455
.L453:
	lwz 9,84(31)
	sth 30,164(9)
	lwz 11,84(31)
	sth 30,162(11)
	lwz 9,84(31)
	stw 30,3848(9)
	b .L455
.L452:
	lwz 9,84(31)
	li 0,0
	sth 0,162(9)
.L455:
	lwz 9,84(31)
	lwz 0,3448(9)
	mr 10,9
	cmpwi 0,0,0
	bc 12,2,.L456
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L456
	lis 9,gi+40@ha
	lis 3,.LC100@ha
	lwz 0,gi+40@l(9)
	la 3,.LC100@l(3)
	b .L463
.L456:
	lwz 0,716(10)
	cmpwi 0,0,2
	bc 12,2,.L459
	lis 9,.LC107@ha
	lfs 13,112(10)
	la 9,.LC107@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L458
.L459:
	lwz 11,1788(10)
	cmpwi 0,11,0
	bc 12,2,.L458
	lis 9,gi+40@ha
	lwz 3,36(11)
	lwz 0,gi+40@l(9)
.L463:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,142(9)
	b .L457
.L458:
	li 0,0
	sth 0,142(10)
.L457:
	mr 3,31
	bl HelpHud
	mr 3,31
	bl SetCTFStats
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe10:
	.size	 G_SetStats,.Lfe10-G_SetStats
	.comm	highscore,1080,4
	.comm	gamescore,540,4
	.section	".rodata"
	.align 2
.LC108:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Help_f
	.type	 Cmd_Help_f,@function
Cmd_Help_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC108@ha
	lis 9,deathmatch@ha
	la 11,.LC108@l(11)
	mr 8,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L395
	bl Cmd_Score_f
	b .L394
.L395:
	lwz 9,84(8)
	li 7,0
	stw 7,3520(9)
	lwz 11,84(8)
	stw 7,3508(11)
	lwz 10,84(8)
	lwz 0,3524(10)
	cmpwi 0,0,0
	bc 12,2,.L396
	lis 9,game+1024@ha
	lwz 11,3444(10)
	lwz 0,game+1024@l(9)
	cmpw 0,11,0
	bc 4,2,.L396
	stw 7,3524(10)
	b .L394
.L396:
	lwz 11,84(8)
	li 0,1
	li 10,0
	mr 3,8
	stw 0,3524(11)
	lwz 9,84(8)
	stw 10,3448(9)
	bl HelpComputer
.L394:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 Cmd_Help_f,.Lfe11-Cmd_Help_f
	.comm	configloc,50,4
	.comm	cycleloc,50,4
	.comm	scoreboard,4,4
	.comm	GlobalFragLimit,5,4
	.comm	GlobalTimeLimit,5,4
	.comm	GlobalGravity,5,4
	.comm	QWLOG,4,4
	.comm	directory,40,4
	.comm	recordLOG,2,4
	.comm	ModelGenDir,50,4
	.comm	obitsDir,50,4
	.comm	HIGHSCORE_DIR,50,4
	.comm	PLAYERS_LOGFILE,50,4
	.comm	MAX_CLIENT_RATE_STRING,10,4
	.comm	MAX_CLIENT_RATE,4,4
	.comm	clientlog,4,4
	.comm	showed,4,4
	.comm	rankhud,4,4
	.comm	playershud,4,4
	.comm	timehud,4,4
	.comm	cloakgrapple,4,4
	.comm	hookcolor,4,4
	.comm	allowgrapple,4,4
	.comm	HOOK_TIME,4,4
	.comm	HOOK_SPEED,4,4
	.comm	EXPERT_SKY_SOLID,4,4
	.comm	HOOK_DAMAGE,4,4
	.comm	PULL_SPEED,4,4
	.comm	LoseQ,4,4
	.comm	LoseQ_Fragee,4,4
	.comm	ConfigRD,4,4
	.comm	CRD,4,4
	.comm	rocketSpeed,4,4
	.comm	Q_Killer,4,4
	.comm	Q_Killee,4,4
	.comm	CF_StartHealth,4,4
	.comm	CF_MaxHealth,4,4
	.comm	MA_Bullets,4,4
	.comm	MA_Shells,4,4
	.comm	MA_Cells,4,4
	.comm	MA_Grenades,4,4
	.comm	MA_Rockets,4,4
	.comm	MA_Slugs,4,4
	.comm	SA_Bullets,4,4
	.comm	SA_Shells,4,4
	.comm	SA_Cells,4,4
	.comm	SA_Grenades,4,4
	.comm	SA_Rockets,4,4
	.comm	SA_Slugs,4,4
	.comm	SI_QuadDamage,4,4
	.comm	SI_Invulnerability,4,4
	.comm	SI_Silencer,4,4
	.comm	SI_Rebreather,4,4
	.comm	SI_EnvironmentSuit,4,4
	.comm	SI_PowerScreen,4,4
	.comm	SI_PowerShield,4,4
	.comm	QuadDamageTime,4,4
	.comm	RebreatherTime,4,4
	.comm	EnvironmentSuitTime,4,4
	.comm	InvulnerabilityTime,4,4
	.comm	SilencerShots,4,4
	.comm	RegenInvulnerability,4,4
	.comm	RegenInvulnerabilityTime,4,4
	.comm	AutoUseQuad,4,4
	.comm	AutoUseInvulnerability,4,4
	.comm	SW_Blaster,4,4
	.comm	SW_ShotGun,4,4
	.comm	SW_SuperShotGun,4,4
	.comm	SW_MachineGun,4,4
	.comm	SW_ChainGun,4,4
	.comm	SW_GrenadeLauncher,4,4
	.comm	SW_RocketLauncher,4,4
	.comm	SW_HyperBlaster,4,4
	.comm	SW_RailGun,4,4
	.comm	SW_BFG10K,4,4
	.comm	rocketspeed,4,4
	.comm	RadiusDamage,4,4
	.comm	DamageRadius,4,4
	.comm	GLauncherTimer,4,4
	.comm	GLauncherFireDistance,4,4
	.comm	GLauncherDamage,4,4
	.comm	GLauncherRadius,4,4
	.comm	GRENADE_TIMER,4,4
	.comm	GRENADE_MINSPEED,4,4
	.comm	GRENADE_MAXSPEED,4,4
	.comm	GrenadeTimer,4,4
	.comm	GrenadeMinSpeed,4,4
	.comm	GrenadeMaxSpeed,4,4
	.comm	GrenadeDamage,4,4
	.comm	GrenadeRadius,4,4
	.comm	HyperBlasterDamage,4,4
	.comm	BlasterProjectileSpeed,4,4
	.comm	BlasterDamage,4,4
	.comm	MachinegunDamage,4,4
	.comm	MachinegunKick,4,4
	.comm	ChaingunDamage,4,4
	.comm	ChaingunKick,4,4
	.comm	ShotgunDamage,4,4
	.comm	ShotgunKick,4,4
	.comm	SuperShotgunDamage,4,4
	.comm	SuperShotgunKick,4,4
	.comm	RailgunDamage,4,4
	.comm	RailgunKick,4,4
	.comm	BFGDamage,4,4
	.comm	BFGDamageRadius,4,4
	.comm	BFGProjectileSpeed,4,4
	.comm	namebanning,4,4
	.comm	bandirectory,50,4
	.comm	ingamenamebanningstate,4,4
	.comm	wasbot,4,4
	.comm	ban_BFG,4,4
	.comm	ban_hyperblaster,4,4
	.comm	ban_rocketlauncher,4,4
	.comm	ban_railgun,4,4
	.comm	ban_chaingun,4,4
	.comm	ban_machinegun,4,4
	.comm	ban_shotgun,4,4
	.comm	ban_supershotgun,4,4
	.comm	ban_grenadelauncher,4,4
	.comm	matchfullnamevalue,4,4
	.comm	fullnamevalue,4,4
	.comm	fastrailgun,4,4
	.comm	fastrocketfire,4,4
	.comm	cloaking,4,4
	.comm	CLOAK_DRAIN,4,4
	.comm	chasekeepscore,4,4
	.comm	fastchange,4,4
	.comm	fraghit,4,4
	.comm	somevar0,30,4
	.comm	somevar1,30,4
	.comm	somevar2,30,4
	.comm	somevar3,30,4
	.comm	somevar4,30,4
	.comm	somevar5,30,4
	.comm	somevar6,30,4
	.comm	somevar7,30,4
	.comm	somevar8,30,4
	.comm	somevar9,30,4
	.comm	somevar10,30,4
	.comm	somevar11,30,4
	.comm	somevar12,30,4
	.comm	somevar13,30,4
	.comm	somevar14,30,4
	.comm	totalrank,4,4
	.comm	hi_head1,60,4
	.comm	hi_head2,60,4
	.comm	hi_line1,60,4
	.comm	hi_line2,60,4
	.comm	hi_line3,60,4
	.comm	hi_line4,60,4
	.comm	hi_line5,60,4
	.comm	hi_line6,60,4
	.comm	hi_line7,60,4
	.comm	hi_line8,60,4
	.comm	hi_line9,60,4
	.comm	hi_line10,60,4
	.comm	hi_line11,60,4
	.comm	hi_line12,60,4
	.comm	hi_line13,60,4
	.comm	hi_line14,60,4
	.comm	hi_line15,60,4
	.align 2
	.globl DeathmatchScoreboard
	.type	 DeathmatchScoreboard,@function
DeathmatchScoreboard:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,scoreboard@ha
	mr 31,3
	lwz 0,scoreboard@l(9)
	cmpwi 0,0,0
	bc 4,2,.L370
	lwz 4,540(31)
	bl DeathmatchScoreboardMessage
	b .L371
.L370:
	cmpwi 0,0,1
	bc 4,2,.L372
	lwz 4,540(31)
	mr 3,31
	bl DeathmatchScoreboardMessage2
	b .L371
.L372:
	cmpwi 0,0,2
	bc 4,2,.L374
	lwz 4,540(31)
	mr 3,31
	bl DeathmatchScoreboardMessage3
	b .L371
.L374:
	lwz 4,540(31)
	mr 3,31
	bl DeathmatchScoreboardMessage
.L371:
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 DeathmatchScoreboard,.Lfe12-DeathmatchScoreboard
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
