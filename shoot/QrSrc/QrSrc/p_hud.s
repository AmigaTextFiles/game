	.file	"p_hud.c"
gcc2_compiled.:
	.section	".text"
	.align 2
	.globl MoveClientToIntermission
	.type	 MoveClientToIntermission,@function
MoveClientToIntermission:
	blr
.Lfe1:
	.size	 MoveClientToIntermission,.Lfe1-MoveClientToIntermission
	.section	".rodata"
	.align 2
.LC0:
	.string	"*"
	.align 2
.LC1:
	.long 0x0
	.align 3
.LC2:
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
	lis 11,.LC1@ha
	lis 9,level+200@ha
	la 11,.LC1@l(11)
	lfs 0,level+200@l(9)
	mr 26,3
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 4,2,.L11
	lis 9,maxclients@ha
	lis 11,game+1560@ha
	lwz 10,maxclients@l(9)
	li 0,0
	li 31,0
	stw 0,game+1560@l(11)
	lis 27,maxclients@ha
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 4,0,.L14
	lis 9,.LC2@ha
	lis 28,g_edicts@ha
	la 9,.LC2@l(9)
	lis 29,0x4330
	lfd 31,0(9)
	li 30,948
.L16:
	lwz 0,g_edicts@l(28)
	add 3,0,30
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L15
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 12,1,.L15
	bl respawn
.L15:
	addi 31,31,1
	lwz 11,maxclients@l(27)
	xoris 0,31,0x8000
	addi 30,30,948
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
	lis 4,.LC0@ha
	la 9,level@l(9)
	la 4,.LC0@l(4)
	lfs 0,4(9)
	stfs 0,200(9)
	lwz 3,504(26)
	stw 3,204(9)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L34
	lis 11,.LC1@ha
	lis 9,coop@ha
	la 11,.LC1@l(11)
	lfs 13,0(11)
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L34
	lis 9,maxclients@ha
	li 31,0
	lwz 10,maxclients@l(9)
	lfs 0,20(10)
	fcmpu 0,13,0
	bc 4,0,.L34
	lis 9,g_edicts@ha
	lis 11,itemlist@ha
	lwz 4,g_edicts@l(9)
	la 11,itemlist@l(11)
	mr 5,10
	lis 9,.LC2@ha
	lis 30,0x4330
	la 9,.LC2@l(9)
	lfd 12,0(9)
.L25:
	mulli 9,31,948
	addi 7,31,1
	addi 9,9,948
	add 3,4,9
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L24
	li 0,256
	li 6,0
	mtctr 0
	li 8,0
	addi 10,11,56
.L35:
	lwz 0,0(10)
	addi 10,10,72
	andi. 9,0,16
	bc 12,2,.L29
	lwz 9,84(3)
	addi 9,9,740
	stwx 6,9,8
.L29:
	addi 8,8,4
	bdnz .L35
.L24:
	mr 31,7
	lfs 13,20(5)
	xoris 0,31,0x8000
	stw 0,12(1)
	stw 30,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L25
.L34:
	lis 9,level+208@ha
	li 0,0
	stw 0,level+208@l(9)
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
.LC3:
	.string	"i_fixme"
	.align 2
.LC4:
	.string	"tag1"
	.align 2
.LC5:
	.string	"tag2"
	.align 2
.LC6:
	.string	"xv %i yv %i picn %s "
	.align 2
.LC7:
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
	bc 4,0,.L38
	lis 9,g_edicts@ha
	mr 26,11
	lwz 24,g_edicts@l(9)
	addi 31,1,3472
.L40:
	mulli 9,28,948
	addi 27,28,1
	add 29,9,24
	lwz 0,1036(29)
	cmpwi 0,0,0
	bc 12,2,.L39
	lwz 0,1028(26)
	mulli 9,28,4084
	li 5,0
	addi 4,1,3472
	cmpw 0,5,25
	addi 3,1,2448
	add 9,9,0
	addi 30,25,1
	lwz 29,3424(9)
	bc 4,0,.L43
	lwz 0,0(31)
	cmpw 0,29,0
	bc 12,1,.L43
	mr 9,4
.L44:
	addi 5,5,1
	cmpw 0,5,25
	bc 4,0,.L43
	lwzu 0,4(9)
	cmpw 0,29,0
	bc 4,1,.L44
.L43:
	cmpw 0,25,5
	mr 7,25
	slwi 12,5,2
	bc 4,1,.L49
	slwi 9,25,2
	mr 6,3
	mr 10,9
	mr 8,4
	addi 11,9,-4
.L51:
	lwzx 9,11,6
	addi 7,7,-1
	cmpw 0,7,5
	stwx 9,10,6
	lwzx 0,11,8
	addi 11,11,-4
	stwx 0,10,8
	addi 10,10,-4
	bc 12,1,.L51
.L49:
	stwx 28,3,12
	mr 25,30
	stwx 29,4,12
.L39:
	lwz 0,1544(26)
	mr 28,27
	cmpw 0,28,0
	bc 12,0,.L40
.L38:
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
	bc 4,0,.L56
	lis 9,game@ha
	lis 18,g_edicts@ha
	la 19,game@l(9)
	addi 24,1,2448
	li 22,0
.L58:
	addi 9,1,2448
	la 11,gi@l(17)
	lwz 10,1028(19)
	lwzx 0,9,22
	lis 3,.LC3@ha
	lwz 8,40(11)
	la 3,.LC3@l(3)
	mulli 9,0,948
	lwz 11,g_edicts@l(18)
	mtlr 8
	mulli 0,0,4084
	addi 9,9,948
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
	bc 4,26,.L61
	lis 9,.LC4@ha
	la 8,.LC4@l(9)
	b .L62
.L61:
	cmpw 0,29,21
	bc 4,2,.L63
	lis 9,.LC5@ha
	la 8,.LC5@l(9)
	b .L62
.L63:
	li 8,0
.L62:
	cmpwi 0,8,0
	bc 12,2,.L65
	lis 5,.LC6@ha
	addi 3,1,16
	la 5,.LC6@l(5)
	li 4,1024
	addi 6,26,32
	mr 7,27
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,16
	bl strlen
	add 29,30,3
	cmpwi 0,29,1024
	bc 12,1,.L56
	add 3,23,30
	addi 4,1,16
	bl strcpy
	mr 30,29
.L65:
	lis 9,level@ha
	lwz 10,3420(31)
	lis 0,0x1b4e
	lwz 11,level@l(9)
	ori 0,0,33205
	lis 5,.LC7@ha
	lwz 8,0(24)
	addi 3,1,16
	la 5,.LC7@l(5)
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
	bc 12,1,.L56
	add 3,23,30
	addi 4,1,16
	bl strcpy
	addi 28,28,1
	mr 30,29
	cmpw 0,28,25
	addi 22,22,4
	bc 12,0,.L58
.L56:
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
.Lfe3:
	.size	 DeathmatchScoreboardMessage,.Lfe3-DeathmatchScoreboardMessage
	.section	".rodata"
	.align 2
.LC8:
	.string	"easy"
	.align 2
.LC9:
	.string	"medium"
	.align 2
.LC10:
	.string	"hard"
	.align 2
.LC11:
	.string	"hard+"
	.align 2
.LC12:
	.string	"xv 32 yv 8 picn help xv 202 yv 12 string2 \"%s\" xv 0 yv 24 cstring2 \"%s\" xv 0 yv 54 cstring2 \"%s\" xv 0 yv 110 cstring2 \"%s\" xv 50 yv 164 string2 \" kills     goals    secrets\" xv 50 yv 172 string2 \"%3i/%3i     %i/%i       %i/%i\" "
	.align 2
.LC13:
	.long 0x0
	.align 2
.LC14:
	.long 0x3f800000
	.align 2
.LC15:
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
	lis 11,.LC13@ha
	lis 9,skill@ha
	la 11,.LC13@l(11)
	mr 31,3
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 4,2,.L75
	lis 9,.LC8@ha
	la 6,.LC8@l(9)
	b .L76
.L75:
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L77
	lis 9,.LC9@ha
	la 6,.LC9@l(9)
	b .L76
.L77:
	lis 11,.LC15@ha
	la 11,.LC15@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L79
	lis 9,.LC10@ha
	la 6,.LC10@l(9)
	b .L76
.L79:
	lis 9,.LC11@ha
	la 6,.LC11@l(9)
.L76:
	lis 11,level@ha
	lis 8,game@ha
	la 11,level@l(11)
	la 8,game@l(8)
	lwz 0,272(11)
	lis 5,.LC12@ha
	addi 9,8,512
	lwz 29,268(11)
	li 4,1024
	addi 3,1,32
	lwz 26,284(11)
	addi 7,11,8
	la 5,.LC12@l(5)
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
.Lfe4:
	.size	 HelpComputer,.Lfe4-HelpComputer
	.section	".rodata"
	.align 2
.LC16:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Help_f
	.type	 Cmd_Help_f,@function
Cmd_Help_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,deathmatch@ha
	lis 11,.LC16@ha
	lwz 10,deathmatch@l(9)
	la 11,.LC16@l(11)
	mr 31,3
	lfs 13,0(11)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 12,2,.L82
	lwz 9,84(31)
	li 8,0
	stw 8,3480(9)
	lwz 11,84(31)
	stw 8,3484(11)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 4,2,.L83
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L81
.L83:
	lwz 9,84(31)
	lwz 0,3476(9)
	cmpwi 0,0,0
	bc 12,2,.L85
	stw 8,3476(9)
	b .L81
.L85:
	li 0,1
	mr 3,31
	stw 0,3476(9)
	lwz 4,540(31)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L81
.L82:
	lwz 9,84(31)
	li 8,0
	stw 8,3480(9)
	lwz 11,84(31)
	stw 8,3476(11)
	lwz 10,84(31)
	lwz 0,3484(10)
	cmpwi 0,0,0
	bc 12,2,.L87
	lis 9,game+1024@ha
	lwz 11,3440(10)
	lwz 0,game+1024@l(9)
	cmpw 0,11,0
	bc 4,2,.L87
	stw 8,3484(10)
	b .L81
.L87:
	lwz 11,84(31)
	li 0,1
	li 10,0
	mr 3,31
	stw 0,3484(11)
	lwz 9,84(31)
	stw 10,3444(9)
	bl HelpComputer
.L81:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Cmd_Help_f,.Lfe5-Cmd_Help_f
	.section	".rodata"
	.align 2
.LC17:
	.string	"cells"
	.align 2
.LC18:
	.string	"misc/power2.wav"
	.align 2
.LC19:
	.string	"i_powershield"
	.align 2
.LC20:
	.string	"p_quad"
	.align 2
.LC21:
	.string	"p_invulnerability"
	.align 2
.LC22:
	.string	"p_envirosuit"
	.align 2
.LC23:
	.string	"p_rebreather"
	.align 2
.LC24:
	.string	"i_help"
	.align 2
.LC25:
	.long 0x3f800000
	.align 2
.LC26:
	.long 0x0
	.align 3
.LC27:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC28:
	.long 0x41200000
	.align 2
.LC29:
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
	li 10,0
	lis 27,level@ha
	lwz 9,84(31)
	sth 0,120(9)
	lwz 11,84(31)
	sth 10,122(11)
	lwz 9,84(31)
	lwz 11,3492(9)
	cmpwi 0,11,0
	bc 4,2,.L89
	sth 11,124(9)
	lwz 9,84(31)
	sth 11,126(9)
	b .L90
.L89:
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
	lwz 9,3492(11)
	slwi 9,9,2
	add 9,11,9
	lhz 0,742(9)
	sth 0,126(11)
.L90:
	mr 3,31
	bl PowerArmorType
	mr. 30,3
	bc 12,2,.L91
	lis 3,.LC17@ha
	lwz 29,84(31)
	la 3,.LC17@l(3)
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
	lwzx 28,29,3
	cmpwi 0,28,0
	bc 4,2,.L91
	lwz 0,264(31)
	lis 29,gi@ha
	lis 3,.LC18@ha
	la 29,gi@l(29)
	la 3,.LC18@l(3)
	rlwinm 0,0,0,20,18
	li 30,0
	stw 0,264(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC25@ha
	lwz 0,16(29)
	lis 11,.LC25@ha
	la 9,.LC25@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC25@l(11)
	li 4,3
	mtlr 0
	lis 9,.LC26@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC26@l(9)
	lfs 3,0(9)
	blrl
.L91:
	mr 3,31
	bl ArmorIndex
	cmpwi 0,30,0
	mr 29,3
	bc 12,2,.L93
	cmpwi 0,29,0
	bc 12,2,.L94
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L93
.L94:
	lis 9,gi+40@ha
	lis 3,.LC19@ha
	lwz 0,gi+40@l(9)
	la 3,.LC19@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,128(9)
	lwz 11,84(31)
	sth 28,130(11)
	b .L95
.L93:
	cmpwi 0,29,0
	bc 12,2,.L96
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
	b .L95
.L96:
	lwz 9,84(31)
	sth 29,128(9)
	lwz 11,84(31)
	sth 29,130(11)
.L95:
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3720(11)
	fcmpu 0,13,0
	bc 4,1,.L98
	li 0,0
	sth 0,134(11)
	lwz 9,84(31)
	sth 0,136(9)
.L98:
	lwz 0,level@l(27)
	lis 30,0x4330
	lis 11,.LC27@ha
	xoris 0,0,0x8000
	la 11,.LC27@l(11)
	stw 0,28(1)
	stw 30,24(1)
	lfd 31,0(11)
	lfd 0,24(1)
	lwz 11,84(31)
	fsub 0,0,31
	lfs 13,3688(11)
	frsp 12,0
	fcmpu 0,13,12
	bc 4,1,.L99
	lis 9,gi+40@ha
	lis 3,.LC20@ha
	lwz 0,gi+40@l(9)
	la 3,.LC20@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC28@ha
	la 11,.LC28@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3688(10)
	b .L122
.L99:
	lfs 0,3692(11)
	fcmpu 0,0,12
	bc 4,1,.L101
	lis 9,gi+40@ha
	lis 3,.LC21@ha
	lwz 0,gi+40@l(9)
	la 3,.LC21@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC28@ha
	la 11,.LC28@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3692(10)
	b .L122
.L101:
	lfs 0,3700(11)
	fcmpu 0,0,12
	bc 4,1,.L103
	lis 9,gi+40@ha
	lis 3,.LC22@ha
	lwz 0,gi+40@l(9)
	la 3,.LC22@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC28@ha
	la 11,.LC28@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3700(10)
	b .L122
.L103:
	lfs 0,3696(11)
	fcmpu 0,0,12
	bc 4,1,.L105
	lis 9,gi+40@ha
	lis 3,.LC23@ha
	lwz 0,gi+40@l(9)
	la 3,.LC23@l(3)
	mtlr 0
	blrl
	lwz 10,84(31)
	lis 11,.LC28@ha
	la 11,.LC28@l(11)
	sth 3,138(10)
	lwz 0,level@l(27)
	lwz 10,84(31)
	xoris 0,0,0x8000
	lfs 11,0(11)
	stw 0,28(1)
	mr 11,9
	stw 30,24(1)
	lfd 13,24(1)
	lfs 0,3696(10)
.L122:
	fsub 13,13,31
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,24(1)
	lwz 11,28(1)
	sth 11,140(10)
	b .L100
.L105:
	li 0,0
	sth 0,138(11)
	lwz 9,84(31)
	sth 0,140(9)
.L100:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	li 0,0
	sth 0,132(9)
	lwz 11,84(31)
	lis 9,deathmatch@ha
	li 10,0
	lwz 8,deathmatch@l(9)
	lhz 0,738(11)
	lis 9,.LC26@ha
	la 9,.LC26@l(9)
	sth 0,144(11)
	lfs 13,0(9)
	lwz 9,84(31)
	sth 10,146(9)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L109
	lwz 11,84(31)
	lwz 0,724(11)
	cmpwi 0,0,0
	bc 4,1,.L111
	lis 9,level+200@ha
	lfs 0,level+200@l(9)
	fcmpu 0,0,13
	bc 4,2,.L111
	lwz 0,3476(11)
	cmpwi 0,0,0
	bc 12,2,.L114
.L111:
	lwz 9,84(31)
	b .L115
.L109:
	lwz 9,84(31)
	lwz 0,3476(9)
	cmpwi 0,0,0
	bc 4,2,.L115
	lwz 0,3484(9)
	cmpwi 0,0,0
	bc 12,2,.L114
.L115:
	lhz 0,146(9)
	ori 0,0,1
	sth 0,146(9)
.L114:
	lwz 9,84(31)
	lwz 0,3480(9)
	cmpwi 0,0,0
	bc 12,2,.L113
	lwz 0,724(9)
	cmpwi 0,0,0
	bc 4,1,.L113
	lhz 0,146(9)
	ori 0,0,2
	sth 0,146(9)
.L113:
	lwz 11,84(31)
	lhz 0,3426(11)
	sth 0,148(11)
	lwz 9,84(31)
	lwz 0,3444(9)
	cmpwi 0,0,0
	bc 12,2,.L117
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 11,0,8
	bc 12,2,.L117
	lis 9,gi+40@ha
	lis 3,.LC24@ha
	lwz 0,gi+40@l(9)
	la 3,.LC24@l(3)
	b .L123
.L117:
	lwz 9,84(31)
	lwz 0,716(9)
	mr 11,9
	cmpwi 0,0,2
	bc 12,2,.L120
	lis 9,.LC29@ha
	lfs 13,112(11)
	la 9,.LC29@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L119
.L120:
	lwz 10,1788(11)
	cmpwi 0,10,0
	bc 12,2,.L119
	lis 9,gi+40@ha
	lwz 3,36(10)
	lwz 0,gi+40@l(9)
.L123:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,142(9)
	b .L118
.L119:
	li 0,0
	sth 0,142(11)
.L118:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 G_SetStats,.Lfe6-G_SetStats
	.section	".rodata"
	.align 2
.LC30:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Score_f
	.type	 Cmd_Score_f,@function
Cmd_Score_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 10,.LC30@ha
	mr 31,3
	la 10,.LC30@l(10)
	lwz 11,84(31)
	lis 9,deathmatch@ha
	lfs 13,0(10)
	li 8,0
	lwz 10,deathmatch@l(9)
	stw 8,3480(11)
	lwz 9,84(31)
	stw 8,3484(9)
	lfs 0,20(10)
	fcmpu 0,0,13
	bc 4,2,.L71
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L70
.L71:
	lwz 9,84(31)
	lwz 0,3476(9)
	cmpwi 0,0,0
	bc 12,2,.L72
	stw 8,3476(9)
	b .L70
.L72:
	li 0,1
	mr 3,31
	stw 0,3476(9)
	lwz 4,540(31)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,31
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L70:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 Cmd_Score_f,.Lfe7-Cmd_Score_f
	.align 2
	.globl DeathmatchScoreboard
	.type	 DeathmatchScoreboard,@function
DeathmatchScoreboard:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lwz 4,540(29)
	bl DeathmatchScoreboardMessage
	lis 9,gi+92@ha
	mr 3,29
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 DeathmatchScoreboard,.Lfe8-DeathmatchScoreboard
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
