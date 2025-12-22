	.file	"matrix_team.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"DEBUG: Create equipment selection Menu(s)\n"
	.align 2
.LC1:
	.string	"%s"
	.align 2
.LC2:
	.string	"male/"
	.align 2
.LC3:
	.string	"%s\\%s%s"
	.align 2
.LC4:
	.string	"%s\\%s"
	.section	".text"
	.align 2
	.globl AssignSkin
	.type	 AssignSkin,@function
AssignSkin:
	stwu 1,-96(1)
	mflr 0
	stmw 28,80(1)
	stw 0,100(1)
	lis 11,g_edicts@ha
	mr 29,3
	lwz 9,g_edicts@l(11)
	lis 0,0xbfc5
	mr 31,4
	ori 0,0,18087
	lis 5,.LC1@ha
	subf 9,9,29
	addi 3,1,8
	mullw 9,9,0
	la 5,.LC1@l(5)
	li 4,64
	mr 6,31
	srawi 9,9,2
	addi 28,9,-1
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,8
	li 4,47
	bl strrchr
	mr. 3,3
	bc 12,2,.L8
	li 0,0
	stb 0,1(3)
	b .L9
.L8:
	lis 9,.LC2@ha
	la 11,.LC2@l(9)
	lwz 0,.LC2@l(9)
	lhz 10,4(11)
	stw 0,8(1)
	sth 10,12(1)
.L9:
	lwz 9,84(29)
	lwz 3,3484(9)
	mr 4,9
	cmpwi 0,3,1
	bc 12,2,.L11
	bc 4,1,.L14
	cmpwi 0,3,2
	bc 12,2,.L12
	b .L14
.L11:
	lis 9,redteamskin@ha
	lis 29,gi@ha
	lwz 11,redteamskin@l(9)
	b .L17
.L12:
	lis 9,blueteamskin@ha
	lis 29,gi@ha
	lwz 11,blueteamskin@l(9)
.L17:
	lis 3,.LC3@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC3@l(3)
	lwz 6,4(11)
	addi 5,1,8
	addi 28,28,1312
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	b .L10
.L14:
	lis 29,gi@ha
	lis 3,.LC4@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC4@l(3)
	mr 5,31
	crxor 6,6,6
	bl va
	lwz 9,24(29)
	addi 0,28,1312
	mr 4,3
	mr 3,0
	mtlr 9
	blrl
.L10:
	lwz 0,100(1)
	mtlr 0
	lmw 28,80(1)
	la 1,96(1)
	blr
.Lfe1:
	.size	 AssignSkin,.Lfe1-AssignSkin
	.section	".rodata"
	.align 2
.LC5:
	.string	"unknown"
	.align 2
.LC6:
	.string	"already on the %s team\n"
	.align 2
.LC7:
	.string	"skin"
	.align 2
.LC8:
	.string	"%s joined the %s team.\n"
	.align 2
.LC9:
	.string	"Type Ready in the console to begin tank play\n"
	.align 2
.LC10:
	.string	"%s changed to the %s team.\n"
	.align 2
.LC11:
	.long 0x0
	.section	".text"
	.align 2
	.globl JoinTeam
	.type	 JoinTeam,@function
JoinTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	lwz 3,84(31)
	lwz 0,3484(3)
	cmpw 0,30,0
	bc 4,2,.L25
	cmpwi 0,30,1
	lis 9,gi@ha
	la 10,gi@l(9)
	bc 12,2,.L26
	cmpwi 0,30,2
	bc 12,2,.L27
	b .L28
.L26:
	lis 9,redteamname@ha
	lwz 11,redteamname@l(9)
	lwz 6,4(11)
	b .L29
.L27:
	lis 9,blueteamname@ha
	lwz 11,blueteamname@l(9)
	lwz 6,4(11)
	b .L29
.L28:
	lis 9,.LC5@ha
	la 6,.LC5@l(9)
.L29:
	lwz 0,8(10)
	lis 5,.LC6@ha
	mr 3,31
	la 5,.LC6@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L24
.L25:
	lwz 0,264(31)
	li 29,0
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	addi 3,3,188
	stw 29,184(31)
	rlwinm 0,0,0,28,26
	stw 0,264(31)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl AssignSkin
	lwz 9,84(31)
	stw 29,3480(9)
	lwz 11,84(31)
	stw 30,3484(11)
	lwz 9,84(31)
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 12,2,.L31
	stw 29,1812(9)
	mr 3,31
	crxor 6,6,6
	bl spectator_respawn
	mr 3,31
	bl PutClientInServer
	lwz 10,84(31)
	li 0,6
	li 11,32
	stw 0,80(31)
	cmpwi 0,30,3
	stb 11,16(10)
	li 0,14
	lwz 9,84(31)
	stb 0,17(9)
	bc 12,2,.L32
	lwz 11,84(31)
	lis 9,gi@ha
	la 10,gi@l(9)
	lwz 0,3484(11)
	addi 5,11,700
	cmpwi 0,0,1
	bc 12,2,.L33
	cmpwi 0,0,2
	bc 12,2,.L34
	b .L35
.L33:
	lis 9,redteamname@ha
	lwz 11,redteamname@l(9)
	lwz 6,4(11)
	b .L36
.L34:
	lis 9,blueteamname@ha
	lwz 11,blueteamname@l(9)
	lwz 6,4(11)
	b .L36
.L35:
	lis 9,.LC5@ha
	la 6,.LC5@l(9)
.L36:
	lwz 0,0(10)
	lis 4,.LC8@ha
	li 3,2
	la 4,.LC8@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L32:
	lis 9,matrix+4@ha
	lwz 0,matrix+4@l(9)
	cmpwi 0,0,0
	bc 4,2,.L24
	lis 9,.LC11@ha
	lis 11,tankmode@ha
	la 9,.LC11@l(9)
	lfs 13,0(9)
	lwz 9,tankmode@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L24
	lis 9,gi+12@ha
	lis 4,.LC9@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC9@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L24
.L31:
	cmpwi 0,9,0
	stw 0,480(31)
	bc 12,2,.L39
	mr 3,31
	mr 4,31
	bl MatrixRespawn
	b .L40
.L39:
	lis 6,0x1
	lis 7,vec3_origin@ha
	la 7,vec3_origin@l(7)
	mr 3,31
	mr 4,31
	mr 5,31
	ori 6,6,34464
	bl player_die
.L40:
	li 0,2
	mr 3,31
	stw 0,492(31)
	bl respawn
	lwz 9,84(31)
	cmpwi 0,30,3
	li 0,0
	stw 0,3464(9)
	bc 12,2,.L24
	lwz 11,84(31)
	lis 9,gi@ha
	la 10,gi@l(9)
	lwz 0,3484(11)
	addi 5,11,700
	cmpwi 0,0,1
	bc 12,2,.L42
	cmpwi 0,0,2
	bc 12,2,.L43
	b .L44
.L42:
	lis 9,redteamname@ha
	lwz 11,redteamname@l(9)
	lwz 6,4(11)
	b .L45
.L43:
	lis 9,blueteamname@ha
	lwz 11,blueteamname@l(9)
	lwz 6,4(11)
	b .L45
.L44:
	lis 9,.LC5@ha
	la 6,.LC5@l(9)
.L45:
	lwz 0,0(10)
	lis 4,.LC10@ha
	li 3,2
	la 4,.LC10@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L24:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 JoinTeam,.Lfe2-JoinTeam
	.globl joinmenu
	.section	".data"
	.align 2
	.type	 joinmenu,@object
joinmenu:
	.long .LC12
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC13
	.long 0
	.long 0
	.long JoinTeam1
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC14
	.long 0
	.long 0
	.long JoinTeam2
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC15
	.long 0
	.long 0
	.long 0
	.long .LC16
	.long 0
	.long 0
	.long 0
	.long .LC17
	.long 0
	.long 0
	.long 0
	.long .LC18
	.long 0
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC18:
	.string	"(TAB to Return)"
	.align 2
.LC17:
	.string	"ESC to Exit Menu"
	.align 2
.LC16:
	.string	"ENTER to select"
	.align 2
.LC15:
	.string	"Use [ and ] to move cursor"
	.align 2
.LC14:
	.string	"Join Blue Team"
	.align 2
.LC13:
	.string	"Join Red Team"
	.align 2
.LC12:
	.string	"*The Matrix Q2 1.2"
	.size	 joinmenu,272
	.lcomm	team1players.27,32,4
	.lcomm	team2players.28,32,4
	.lcomm	team1name.29,32,4
	.lcomm	team2name.30,32,4
	.align 2
.LC19:
	.string	"  (%i players)"
	.align 2
.LC20:
	.string	"Join %s Team"
	.align 2
.LC21:
	.string	"Join the Game"
	.align 2
.LC22:
	.long 0x0
	.align 3
.LC23:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl UpdateJoinMenu
	.type	 UpdateJoinMenu,@function
UpdateJoinMenu:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	lis 9,teamplay@ha
	lis 3,.LC22@ha
	lwz 11,teamplay@l(9)
	la 3,.LC22@l(3)
	li 5,0
	lfs 13,0(3)
	li 26,0
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L51
	lis 11,maxclients@ha
	li 6,0
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L53
	lis 9,g_edicts@ha
	fmr 12,0
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	la 4,game@l(11)
	lis 7,0x4330
	lis 9,.LC23@ha
	li 8,0
	la 9,.LC23@l(9)
	addi 10,10,1204
	lfd 13,0(9)
.L55:
	lwz 0,0(10)
	addi 10,10,1116
	cmpwi 0,0,0
	bc 12,2,.L54
	lwz 9,1028(4)
	add 9,8,9
	lwz 11,3484(9)
	cmpwi 0,11,1
	bc 4,2,.L57
	addi 5,5,1
	b .L54
.L57:
	xori 11,11,2
	addi 9,26,1
	srawi 3,11,31
	xor 0,3,11
	subf 0,0,3
	srawi 0,0,31
	andc 9,9,0
	and 0,26,0
	or 26,0,9
.L54:
	addi 6,6,1
	xoris 0,6,0x8000
	addi 8,8,3916
	stw 0,12(1)
	stw 7,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L55
.L53:
	lis 29,.LC19@ha
	lis 27,team1players.27@ha
	la 4,.LC19@l(29)
	la 3,team1players.27@l(27)
	crxor 6,6,6
	bl sprintf
	lis 28,team2players.28@ha
	lis 25,team1name.29@ha
	la 4,.LC19@l(29)
	mr 5,26
	la 3,team2players.28@l(28)
	lis 24,.LC20@ha
	crxor 6,6,6
	bl sprintf
	lis 26,team2name.30@ha
	lis 9,redteamname@ha
	lis 29,joinmenu@ha
	la 29,joinmenu@l(29)
	lwz 11,redteamname@l(9)
	la 27,team1players.27@l(27)
	la 28,team2players.28@l(28)
	stw 27,48(29)
	la 4,.LC20@l(24)
	stw 28,80(29)
	la 3,team1name.29@l(25)
	lwz 5,4(11)
	crxor 6,6,6
	bl sprintf
	lis 9,blueteamname@ha
	la 3,team2name.30@l(26)
	lwz 11,blueteamname@l(9)
	la 4,.LC20@l(24)
	lwz 5,4(11)
	crxor 6,6,6
	bl sprintf
	lis 11,JoinTeam2@ha
	lis 9,JoinTeam1@ha
	la 25,team1name.29@l(25)
	la 26,team2name.30@l(26)
	la 11,JoinTeam2@l(11)
	la 9,JoinTeam1@l(9)
	stw 25,32(29)
	stw 9,44(29)
	stw 26,64(29)
	stw 11,76(29)
	b .L61
.L51:
	lis 9,joinmenu@ha
	lis 11,.LC21@ha
	lis 10,FreeTeam@ha
	lis 8,maxclients@ha
	lwz 7,maxclients@l(8)
	la 9,joinmenu@l(9)
	la 11,.LC21@l(11)
	la 10,FreeTeam@l(10)
	stw 11,32(9)
	li 6,0
	stw 10,44(9)
	stw 5,108(9)
	stw 5,48(9)
	stw 5,60(9)
	stw 5,64(9)
	stw 5,76(9)
	stw 5,80(9)
	stw 5,92(9)
	stw 5,96(9)
	lfs 0,20(7)
	fcmpu 0,13,0
	bc 4,0,.L63
	lis 3,.LC23@ha
	lis 9,g_edicts@ha
	fmr 12,0
	la 3,.LC23@l(3)
	lwz 10,g_edicts@l(9)
	lis 11,game@ha
	lfd 13,0(3)
	la 4,game@l(11)
	lis 7,0x4330
	addi 10,10,1204
	li 8,0
.L65:
	lwz 0,0(10)
	addi 10,10,1116
	cmpwi 0,0,0
	bc 12,2,.L64
	lwz 9,1028(4)
	addi 11,5,1
	add 9,8,9
	lwz 0,3484(9)
	xori 0,0,3
	srawi 3,0,31
	xor 9,3,0
	subf 9,9,3
	srawi 9,9,31
	andc 11,11,9
	and 9,5,9
	or 5,9,11
.L64:
	addi 6,6,1
	xoris 0,6,0x8000
	addi 8,8,3916
	stw 0,12(1)
	stw 7,8(1)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L65
.L63:
	lis 29,team1players.27@ha
	lis 4,.LC19@ha
	la 3,team1players.27@l(29)
	la 4,.LC19@l(4)
	crxor 6,6,6
	bl sprintf
	la 29,team1players.27@l(29)
	lis 9,joinmenu+48@ha
	stw 29,joinmenu+48@l(9)
.L61:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 UpdateJoinMenu,.Lfe3-UpdateJoinMenu
	.section	".rodata"
	.align 2
.LC24:
	.string	"xv 8 yv 8 picn tag1 xv 40 yv 28 string \"%4d/%-3d\" xv 98 yv 12 num 2 29 xv 168 yv 8 picn tag2 xv 200 yv 28 string \"%4d/%-3d\" xv 256 yv 12 num 2 30 "
	.align 2
.LC25:
	.string	"ctf 0 %d %d %d %d "
	.align 2
.LC26:
	.string	"ctf 160 %d %d %d %d "
	.align 2
.LC27:
	.string	"xv 0 yv %d string2 \"Spectators\" "
	.align 2
.LC28:
	.string	"ctf %d %d %d %d %d "
	.align 2
.LC29:
	.string	"xv 8 yv %d string \"..and %d more\" "
	.align 2
.LC30:
	.string	"xv 168 yv %d string \"..and %d more\" "
	.align 2
.LC31:
	.long 0x0
	.align 3
.LC32:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl TeamplayScoreboardMessage
	.type	 TeamplayScoreboardMessage,@function
TeamplayScoreboardMessage:
	stwu 1,-6656(1)
	mflr 0
	mfcr 12
	stmw 14,6584(1)
	stw 0,6660(1)
	stw 12,6580(1)
	lis 9,game@ha
	addi 11,1,6536
	la 10,game@l(9)
	li 0,0
	lwz 9,1544(10)
	li 26,0
	mr 17,11
	stw 0,4(11)
	li 24,0
	li 25,0
	stw 0,6536(1)
	addi 11,1,6544
	cmpw 0,24,9
	stw 26,4(11)
	mr 16,3
	addi 21,1,1032
	stw 26,6544(1)
	bc 4,0,.L72
	lis 9,g_edicts@ha
	mr 31,10
	lwz 18,g_edicts@l(9)
	mr 20,11
	mr 12,17
	addi 19,1,4488
	mr 15,17
.L74:
	mulli 9,24,1116
	addi 22,24,1
	add 10,9,18
	lwz 0,1204(10)
	cmpwi 0,0,0
	bc 12,2,.L73
	mulli 9,24,3916
	lwz 0,1028(31)
	mr 8,9
	add 9,9,0
	lwz 0,3484(9)
	cmpwi 0,0,1
	bc 4,2,.L76
	li 10,0
	b .L77
.L76:
	cmpwi 0,0,2
	bc 4,2,.L73
	li 10,1
.L77:
	slwi 0,10,2
	lwz 9,1028(31)
	li 30,0
	lwzx 11,12,0
	mr 3,0
	slwi 6,10,10
	add 9,8,9
	addi 7,1,4488
	cmpw 0,30,11
	lwz 29,3464(9)
	addi 4,1,2440
	addi 22,24,1
	bc 4,0,.L81
	lwzx 0,19,6
	cmpw 0,29,0
	bc 12,1,.L81
	lwzx 11,3,15
	add 9,6,7
.L82:
	addi 30,30,1
	cmpw 0,30,11
	bc 4,0,.L81
	lwzu 0,4(9)
	cmpw 0,29,0
	bc 4,1,.L82
.L81:
	lwzx 27,3,12
	slwi 23,30,2
	cmpw 0,27,30
	bc 4,1,.L87
	addi 11,4,-4
	slwi 9,27,2
	add 11,6,11
	addi 0,7,-4
	add 0,6,0
	add 10,9,11
	mr 28,4
	add 8,9,0
	add 11,9,6
	mr 5,7
.L89:
	lwz 9,0(10)
	addi 27,27,-1
	cmpw 0,27,30
	addi 10,10,-4
	stwx 9,11,28
	lwz 0,0(8)
	addi 8,8,-4
	stwx 0,11,5
	addi 11,11,-4
	bc 12,1,.L89
.L87:
	add 0,23,6
	stwx 24,4,0
	stwx 29,7,0
	lwzx 9,3,20
	lwzx 11,3,12
	add 9,9,29
	addi 11,11,1
	stwx 9,3,20
	stwx 11,3,12
.L73:
	lwz 0,1544(31)
	mr 24,22
	cmpw 0,24,0
	bc 12,0,.L74
.L72:
	lwz 10,84(16)
	li 0,0
	lis 11,matrix@ha
	stb 0,1032(1)
	la 11,matrix@l(11)
	lis 4,.LC24@ha
	lhz 0,18(11)
	la 4,.LC24@l(4)
	mr 3,21
	li 24,0
	sth 0,178(10)
	lhz 0,22(11)
	lwz 9,84(16)
	sth 0,180(9)
	lwz 8,4(17)
	lwz 7,20(11)
	lwz 5,16(11)
	lwz 6,6536(1)
	crxor 6,6,6
	bl sprintf
	mr 3,21
	bl strlen
	lwz 0,6536(1)
	mr 23,3
	b .L122
.L96:
	lwz 9,6536(1)
	li 0,0
	stb 0,8(1)
	cmpw 0,24,9
	bc 4,0,.L97
	addi 29,1,2440
	slwi 28,24,2
	lwzx 0,29,28
	lis 9,game+1028@ha
	addi 3,1,8
	lwz 11,game+1028@l(9)
	mr 30,3
	subfic 27,23,1000
	mulli 0,0,3916
	add 31,11,0
	bl strlen
	lwz 9,184(31)
	slwi 5,24,3
	lis 4,.LC25@ha
	lwzx 6,29,28
	la 4,.LC25@l(4)
	addi 5,5,42
	cmpwi 7,9,1000
	lwz 7,3464(31)
	add 3,30,3
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 8,0,0
	and 9,9,0
	andi. 8,8,999
	or 8,9,8
	crxor 6,6,6
	bl sprintf
	mr 3,30
	bl strlen
	cmplw 0,27,3
	bc 4,1,.L97
	mr 4,30
	mr 3,21
	bl strcat
	mr 25,24
	mr 3,21
	bl strlen
	mr 23,3
.L97:
	lwz 0,4(17)
	cmpw 0,24,0
	bc 4,0,.L94
	addi 29,1,3464
	slwi 28,24,2
	lwzx 0,29,28
	lis 9,game+1028@ha
	addi 3,1,8
	lwz 11,game+1028@l(9)
	mr 30,3
	subfic 27,23,1000
	mulli 0,0,3916
	add 31,11,0
	bl strlen
	lwz 9,184(31)
	slwi 5,24,3
	lis 4,.LC26@ha
	lwzx 6,29,28
	la 4,.LC26@l(4)
	addi 5,5,42
	cmpwi 7,9,1000
	lwz 7,3464(31)
	add 3,30,3
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 8,0,0
	and 9,9,0
	andi. 8,8,999
	or 8,9,8
	crxor 6,6,6
	bl sprintf
	mr 3,30
	bl strlen
	cmplw 0,27,3
	bc 4,1,.L94
	mr 4,30
	mr 3,21
	bl strcat
	mr 26,24
	mr 3,21
	bl strlen
	mr 23,3
.L94:
	addi 24,24,1
	cmpwi 0,24,15
	bc 12,1,.L93
	lwz 0,6536(1)
.L122:
	cmpw 0,24,0
	bc 12,0,.L96
	lwz 0,4(17)
	cmpw 0,24,0
	bc 12,0,.L96
.L93:
	cmpw 7,25,26
	subfic 0,23,1000
	cmpwi 0,0,50
	li 18,0
	li 27,0
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 11,25,0
	and 0,26,0
	or 30,0,11
	slwi 9,30,3
	addi 30,9,58
	bc 4,1,.L106
	lis 9,maxclients@ha
	lis 10,.LC31@ha
	lwz 11,maxclients@l(9)
	la 10,.LC31@l(10)
	li 24,0
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L106
	lis 9,game@ha
	lis 14,g_edicts@ha
	la 15,game@l(9)
	mr 22,21
	lis 16,0x4330
	li 19,0
	li 20,1116
.L110:
	lwz 0,g_edicts@l(14)
	lwz 11,1028(15)
	add 10,0,20
	lwz 9,88(10)
	add 31,11,19
	cmpwi 0,9,0
	bc 12,2,.L109
	lwz 9,84(10)
	lwz 0,3480(9)
	cmpwi 0,0,0
	bc 4,2,.L109
	lwz 0,3488(9)
	cmpwi 0,0,0
	bc 4,2,.L109
	lwz 0,3484(9)
	cmpwi 0,0,3
	bc 4,2,.L109
	cmpwi 0,27,0
	bc 4,2,.L113
	lis 4,.LC27@ha
	mr 5,30
	addi 3,1,8
	la 4,.LC27@l(4)
	crxor 6,6,6
	bl sprintf
	li 27,1
	addi 30,30,8
	addi 4,1,8
	mr 3,22
	bl strcat
	mr 3,22
	bl strlen
	mr 23,3
.L113:
	addi 3,1,8
	subfic 29,23,1000
	mr 28,3
	bl strlen
	lwz 11,184(31)
	rlwinm 5,18,0,31,31
	lis 4,.LC28@ha
	cmpwi 4,5,0
	lwz 8,3464(31)
	la 4,.LC28@l(4)
	cmpwi 7,11,1000
	neg 5,5
	andi. 5,5,160
	mr 6,30
	mr 7,24
	add 3,28,3
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 11,11,0
	andi. 9,9,999
	or 9,11,9
	crxor 6,6,6
	bl sprintf
	mr 3,28
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L117
	mr 4,28
	mr 3,22
	bl strcat
	mr 3,22
	bl strlen
	mr 23,3
.L117:
	mfcr 0
	rlwinm 0,0,19,1
	addi 9,30,8
	neg 0,0
	addi 18,18,1
	andc 9,9,0
	and 0,30,0
	or 30,0,9
.L109:
	lis 10,maxclients@ha
	addi 24,24,1
	lwz 11,maxclients@l(10)
	xoris 0,24,0x8000
	lis 10,.LC32@ha
	stw 0,6572(1)
	addi 19,19,3916
	la 10,.LC32@l(10)
	stw 16,6568(1)
	addi 20,20,1116
	lfd 12,0(10)
	lfd 0,6568(1)
	lfs 13,20(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L110
.L106:
	lwz 0,6536(1)
	subf 0,25,0
	cmpwi 0,0,1
	bc 4,1,.L120
	mr 3,21
	bl strlen
	lwz 6,6536(1)
	slwi 5,25,3
	lis 4,.LC29@ha
	la 4,.LC29@l(4)
	addi 5,5,50
	subf 6,25,6
	add 3,21,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L120:
	lwz 0,4(17)
	subf 0,26,0
	cmpwi 0,0,1
	bc 4,1,.L121
	mr 3,21
	bl strlen
	lwz 6,4(17)
	slwi 5,26,3
	lis 4,.LC30@ha
	la 4,.LC30@l(4)
	addi 5,5,50
	subf 6,26,6
	add 3,21,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L121:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,116(29)
	mr 3,21
	mtlr 0
	blrl
	lwz 0,6660(1)
	lwz 12,6580(1)
	mtlr 0
	lmw 14,6584(1)
	mtcrf 8,12
	la 1,6656(1)
	blr
.Lfe4:
	.size	 TeamplayScoreboardMessage,.Lfe4-TeamplayScoreboardMessage
	.align 2
	.globl Cmd_ChooseMenu_f
	.type	 Cmd_ChooseMenu_f,@function
Cmd_ChooseMenu_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+4@ha
	lis 3,.LC0@ha
	lwz 0,gi+4@l(9)
	la 3,.LC0@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_ChooseMenu_f,.Lfe5-Cmd_ChooseMenu_f
	.align 2
	.globl TeamName
	.type	 TeamName,@function
TeamName:
	cmpwi 0,3,1
	bc 12,2,.L20
	cmpwi 0,3,2
	bc 12,2,.L21
	b .L22
.L20:
	lis 9,redteamname@ha
	lwz 11,redteamname@l(9)
	lwz 3,4(11)
	blr
.L21:
	lis 9,blueteamname@ha
	lwz 11,blueteamname@l(9)
	lwz 3,4(11)
	blr
.L22:
	lis 3,.LC5@ha
	la 3,.LC5@l(3)
	blr
.Lfe6:
	.size	 TeamName,.Lfe6-TeamName
	.align 2
	.globl JoinTeam1
	.type	 JoinTeam1,@function
JoinTeam1:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	mr 3,29
	li 4,1
	bl JoinTeam
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 JoinTeam1,.Lfe7-JoinTeam1
	.align 2
	.globl JoinTeam2
	.type	 JoinTeam2,@function
JoinTeam2:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	mr 3,29
	li 4,2
	bl JoinTeam
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 JoinTeam2,.Lfe8-JoinTeam2
	.align 2
	.globl FreeTeam
	.type	 FreeTeam,@function
FreeTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	mr 3,29
	li 4,3
	bl JoinTeam
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 FreeTeam,.Lfe9-FreeTeam
	.align 2
	.globl Cmd_JoinMenu_f
	.type	 Cmd_JoinMenu_f,@function
Cmd_JoinMenu_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl UpdateJoinMenu
	lis 4,joinmenu@ha
	mr 3,29
	la 4,joinmenu@l(4)
	li 5,3
	li 6,17
	bl PMenu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 Cmd_JoinMenu_f,.Lfe10-Cmd_JoinMenu_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
