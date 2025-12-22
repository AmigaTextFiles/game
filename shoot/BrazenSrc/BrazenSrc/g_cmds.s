	.file	"g_cmds.c"
gcc2_compiled.:
	.lcomm	value.6,512,4
	.section	".rodata"
	.align 2
.LC0:
	.string	"skin"
	.section	".text"
	.align 2
	.globl OnSameTeam
	.type	 OnSameTeam,@function
OnSameTeam:
	stwu 1,-1072(1)
	mflr 0
	stmw 27,1052(1)
	stw 0,1076(1)
	lis 11,dmflags@ha
	lwz 10,dmflags@l(11)
	mr 28,4
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 9,1044(1)
	andi. 0,9,192
	bc 4,2,.L11
	li 3,0
	b .L21
.L11:
	lis 9,value.6@ha
	li 30,0
	stb 30,value.6@l(9)
	la 31,value.6@l(9)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L23
	lis 4,.LC0@ha
	addi 3,3,188
	la 4,.LC0@l(4)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl strcpy
	mr 3,31
	li 4,47
	bl strchr
	mr. 3,3
	bc 12,2,.L23
	lis 9,dmflags@ha
	lwz 11,dmflags@l(9)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 9,1044(1)
	andi. 0,9,128
	bc 12,2,.L15
	stb 30,0(3)
.L23:
	mr 3,31
	b .L13
.L15:
	addi 3,3,1
.L13:
	mr 4,3
	li 29,0
	addi 3,1,8
	bl strcpy
	lis 9,value.6@ha
	addi 30,1,520
	stb 29,value.6@l(9)
	mr 27,30
	la 31,value.6@l(9)
	lwz 3,84(28)
	cmpwi 0,3,0
	bc 12,2,.L25
	lis 4,.LC0@ha
	addi 3,3,188
	la 4,.LC0@l(4)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl strcpy
	mr 3,31
	li 4,47
	bl strchr
	mr. 3,3
	bc 12,2,.L25
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 11,1044(1)
	andi. 0,11,128
	bc 12,2,.L19
	stb 29,0(3)
.L25:
	mr 3,31
	b .L17
.L19:
	addi 3,3,1
.L17:
	mr 4,3
	mr 3,30
	bl strcpy
	mr 4,27
	addi 3,1,8
	bl strcmp
	subfic 0,3,0
	adde 3,0,3
.L21:
	lwz 0,1076(1)
	mtlr 0
	lmw 27,1052(1)
	la 1,1072(1)
	blr
.Lfe1:
	.size	 OnSameTeam,.Lfe1-OnSameTeam
	.section	".rodata"
	.align 2
.LC1:
	.string	"You must run the server with '+set cheats 1' to enable this command.\n"
	.align 2
.LC2:
	.string	"godmode OFF\n"
	.align 2
.LC3:
	.string	"godmode ON\n"
	.align 2
.LC4:
	.string	"notarget OFF\n"
	.align 2
.LC5:
	.string	"notarget ON\n"
	.align 2
.LC6:
	.string	"noclip OFF\n"
	.align 2
.LC7:
	.string	"noclip ON\n"
	.align 2
.LC8:
	.string	"%3i %s\n"
	.align 2
.LC9:
	.string	"...\n"
	.align 2
.LC10:
	.string	"%s\n%i players\n"
	.align 2
.LC11:
	.long 0x0
	.align 3
.LC12:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_Players_f
	.type	 Cmd_Players_f,@function
Cmd_Players_f:
	stwu 1,-2432(1)
	mflr 0
	stmw 23,2396(1)
	stw 0,2436(1)
	lis 11,.LC11@ha
	lis 9,maxclients@ha
	la 11,.LC11@l(11)
	mr 23,3
	lfs 13,0(11)
	li 27,0
	li 31,0
	lwz 11,maxclients@l(9)
	addi 29,1,1352
	addi 30,1,72
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L68
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,29
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L70:
	lwz 0,0(11)
	addi 11,11,5216
	cmpwi 0,0,0
	bc 12,2,.L69
	stw 31,0(10)
	addi 27,27,1
	addi 10,10,4
.L69:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L70
.L68:
	lis 6,PlayerSort@ha
	mr 3,29
	la 6,PlayerSort@l(6)
	mr 4,27
	li 5,4
	li 31,0
	bl qsort
	cmpw 0,31,27
	li 0,0
	stb 0,72(1)
	bc 4,0,.L74
	lis 9,game@ha
	mr 28,29
	la 24,game@l(9)
	lis 26,.LC8@ha
	lis 25,.LC9@ha
.L76:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC8@l(26)
	addi 28,28,4
	mulli 7,7,5216
	add 7,7,0
	lha 6,124(7)
	addi 7,7,700
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,30
	bl strlen
	add 29,29,3
	cmplwi 0,29,1180
	bc 4,1,.L77
	la 4,.LC9@l(25)
	mr 3,30
	bl strcat
	b .L74
.L77:
	mr 3,30
	addi 4,1,8
	bl strcat
	addi 31,31,1
	cmpw 0,31,27
	bc 12,0,.L76
.L74:
	lis 9,gi+8@ha
	lis 5,.LC10@ha
	lwz 0,gi+8@l(9)
	mr 3,23
	la 5,.LC10@l(5)
	mr 6,30
	mr 7,27
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,2436(1)
	mtlr 0
	lmw 23,2396(1)
	la 1,2432(1)
	blr
.Lfe2:
	.size	 Cmd_Players_f,.Lfe2-Cmd_Players_f
	.section	".rodata"
	.align 2
.LC13:
	.string	"flipoff\n"
	.align 2
.LC14:
	.string	"salute\n"
	.align 2
.LC15:
	.string	"taunt\n"
	.align 2
.LC16:
	.string	"wave\n"
	.align 2
.LC17:
	.string	"point\n"
	.section	".text"
	.align 2
	.globl Cmd_Wave_f
	.type	 Cmd_Wave_f,@function
Cmd_Wave_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,gi+160@ha
	mr 31,3
	lwz 0,gi+160@l(9)
	li 3,1
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 11,0,1
	bc 4,2,.L79
	lwz 0,4792(9)
	cmpwi 0,0,1
	bc 12,1,.L79
	cmplwi 0,3,4
	li 0,1
	stw 0,4792(9)
	bc 12,1,.L88
	lis 11,.L89@ha
	slwi 10,3,2
	la 11,.L89@l(11)
	lis 9,.L89@ha
	lwzx 0,10,11
	la 9,.L89@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L89:
	.long .L83-.L89
	.long .L84-.L89
	.long .L85-.L89
	.long .L86-.L89
	.long .L88-.L89
.L83:
	lis 9,gi+8@ha
	lis 5,.LC13@ha
	lwz 0,gi+8@l(9)
	la 5,.LC13@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,71
	li 9,83
	b .L90
.L84:
	lis 9,gi+8@ha
	lis 5,.LC14@ha
	lwz 0,gi+8@l(9)
	la 5,.LC14@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,83
	li 9,94
	b .L90
.L85:
	lis 9,gi+8@ha
	lis 5,.LC15@ha
	lwz 0,gi+8@l(9)
	la 5,.LC15@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,94
	li 9,111
	b .L90
.L86:
	lis 9,gi+8@ha
	lis 5,.LC16@ha
	lwz 0,gi+8@l(9)
	la 5,.LC16@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,111
	li 9,122
	b .L90
.L88:
	lis 9,gi+8@ha
	lis 5,.LC17@ha
	lwz 0,gi+8@l(9)
	la 5,.LC17@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,122
	li 9,134
.L90:
	stw 0,56(31)
	stw 9,4788(11)
.L79:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 Cmd_Wave_f,.Lfe3-Cmd_Wave_f
	.section	".rodata"
	.align 2
.LC18:
	.string	"(%s): "
	.align 2
.LC19:
	.string	"%s: "
	.align 2
.LC20:
	.string	" "
	.align 2
.LC21:
	.string	"\n"
	.align 2
.LC22:
	.string	"You can't talk for %d more seconds\n"
	.align 2
.LC23:
	.string	"Flood protection:  You can't talk for %d seconds.\n"
	.align 2
.LC24:
	.string	"%s"
	.align 2
.LC25:
	.long 0x0
	.align 3
.LC26:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC27:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Cmd_Say_f
	.type	 Cmd_Say_f,@function
Cmd_Say_f:
	stwu 1,-2112(1)
	mflr 0
	mfcr 12
	stmw 24,2080(1)
	stw 0,2116(1)
	stw 12,2076(1)
	lis 9,gi+156@ha
	mr 28,3
	lwz 0,gi+156@l(9)
	mr 30,4
	mr 31,5
	mtlr 0
	blrl
	cmpwi 0,3,1
	bc 12,1,.L92
	cmpwi 0,31,0
	bc 12,2,.L91
.L92:
	lis 10,dmflags@ha
	lwz 11,dmflags@l(10)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,2064(1)
	lwz 9,2068(1)
	rlwinm 9,9,0,24,25
	neg 9,9
	srawi 9,9,31
	and. 30,30,9
	bc 12,2,.L94
	lwz 6,84(28)
	lis 5,.LC18@ha
	addi 3,1,8
	la 5,.LC18@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	b .L95
.L94:
	lwz 6,84(28)
	lis 5,.LC19@ha
	addi 3,1,8
	la 5,.LC19@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
.L95:
	cmpwi 0,31,0
	bc 12,2,.L96
	lis 29,gi@ha
	li 3,0
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC20@ha
	addi 3,1,8
	la 4,.LC20@l(4)
	bl strcat
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	b .L97
.L96:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L98
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	stb 31,-1(3)
.L98:
	mr 4,29
	addi 3,1,8
	bl strcat
.L97:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L99
	li 0,0
	stb 0,158(1)
.L99:
	lis 4,.LC21@ha
	addi 3,1,8
	la 4,.LC21@l(4)
	bl strcat
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	lfs 8,0(9)
	lis 9,flood_msgs@ha
	lwz 11,flood_msgs@l(9)
	lfs 9,20(11)
	fcmpu 0,9,8
	bc 12,2,.L100
	lwz 7,84(28)
	lis 9,level+4@ha
	lfs 10,level+4@l(9)
	lfs 0,4840(7)
	fcmpu 0,10,0
	bc 4,0,.L101
	fsubs 0,0,10
	lis 9,gi+8@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC22@ha
	mr 3,28
	la 5,.LC22@l(5)
	li 4,2
	mtlr 0
	fctiwz 13,0
	stfd 13,2064(1)
	b .L114
.L101:
	lwz 0,4884(7)
	lis 10,0x4330
	lis 11,.LC26@ha
	addi 8,7,4844
	mr 6,0
	la 11,.LC26@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,2068(1)
	lis 11,.LC27@ha
	stw 10,2064(1)
	la 11,.LC27@l(11)
	lfd 0,2064(1)
	mr 10,8
	lfs 11,0(11)
	mr 11,9
	fsub 0,0,13
	frsp 0,0
	fsubs 0,0,9
	fadds 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,2064(1)
	lwz 11,2068(1)
	nor 0,11,11
	addi 9,11,10
	srawi 0,0,31
	andc 9,9,0
	and 11,11,0
	or 11,11,9
	slwi 11,11,2
	lfsx 0,8,11
	fcmpu 0,0,8
	bc 12,2,.L103
	lis 11,flood_persecond@ha
	fsubs 13,10,0
	lwz 9,flood_persecond@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L103
	lis 9,flood_waitdelay@ha
	lis 10,gi+8@ha
	lwz 11,flood_waitdelay@l(9)
	lis 5,.LC23@ha
	mr 3,28
	la 5,.LC23@l(5)
	lfs 13,20(11)
	li 4,3
	fadds 13,10,13
	stfs 13,4840(7)
	lfs 0,20(11)
	lwz 0,gi+8@l(10)
	mtlr 0
	fctiwz 12,0
	stfd 12,2064(1)
.L114:
	lwz 6,2068(1)
	crxor 6,6,6
	blrl
	b .L91
.L103:
	lis 0,0xcccc
	addi 9,6,1
	ori 0,0,52429
	lis 11,level+4@ha
	mulhwu 0,9,0
	srwi 0,0,3
	mulli 0,0,10
	subf 9,0,9
	stw 9,4884(7)
	lfs 0,level+4@l(11)
	slwi 9,9,2
	stfsx 0,10,9
.L100:
	lis 9,.LC25@ha
	lis 11,dedicated@ha
	la 9,.LC25@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L104
	lis 9,gi+8@ha
	lis 5,.LC24@ha
	lwz 0,gi+8@l(9)
	la 5,.LC24@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L104:
	lis 9,game@ha
	li 31,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,31,0
	bc 12,1,.L91
	cmpwi 4,30,0
	lis 9,gi@ha
	la 24,gi@l(9)
	mr 25,11
	lis 26,g_edicts@ha
	lis 27,.LC24@ha
	li 30,1084
.L108:
	lwz 0,g_edicts@l(26)
	add 29,0,30
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L107
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L107
	bc 12,18,.L111
	mr 3,28
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L107
.L111:
	lwz 9,8(24)
	mr 3,29
	li 4,3
	la 5,.LC24@l(27)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L107:
	lwz 0,1544(25)
	addi 31,31,1
	addi 30,30,1084
	cmpw 0,31,0
	bc 4,1,.L108
.L91:
	lwz 0,2116(1)
	lwz 12,2076(1)
	mtlr 0
	lmw 24,2080(1)
	mtcrf 8,12
	la 1,2112(1)
	blr
.Lfe4:
	.size	 Cmd_Say_f,.Lfe4-Cmd_Say_f
	.section	".rodata"
	.align 2
.LC28:
	.string	"%02d:%02d %4d %3d %s%s\n"
	.align 2
.LC29:
	.string	" (spectator)"
	.align 2
.LC30:
	.string	""
	.align 2
.LC31:
	.string	"And more...\n"
	.align 2
.LC32:
	.long 0x0
	.align 3
.LC33:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_PlayerList_f
	.type	 Cmd_PlayerList_f,@function
Cmd_PlayerList_f:
	stwu 1,-1568(1)
	mflr 0
	stmw 20,1520(1)
	stw 0,1572(1)
	lis 9,maxclients@ha
	li 0,0
	lwz 11,maxclients@l(9)
	lis 10,g_edicts@ha
	mr 27,3
	lis 9,.LC32@ha
	stb 0,96(1)
	li 28,0
	la 9,.LC32@l(9)
	lfs 0,20(11)
	lis 22,maxclients@ha
	lfs 13,0(9)
	addi 31,1,96
	lis 21,gi@ha
	lwz 9,g_edicts@l(10)
	lis 20,.LC24@ha
	fcmpu 0,13,0
	addi 30,9,1084
	bc 4,0,.L117
	lis 9,.LC29@ha
	lis 11,.LC30@ha
	la 23,.LC29@l(9)
	la 24,.LC30@l(11)
	lis 25,level@ha
	lis 26,0x4330
.L119:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L118
	lwz 10,84(30)
	lis 11,0x1b4e
	lis 8,0x6666
	lwz 9,level@l(25)
	ori 11,11,33205
	ori 8,8,26215
	lwz 0,4540(10)
	addi 29,10,700
	lwz 7,4560(10)
	subf 9,0,9
	lwz 3,184(10)
	mulhw 11,9,11
	lwz 4,4544(10)
	cmpwi 0,7,0
	srawi 10,9,31
	srawi 11,11,6
	subf 6,10,11
	mulli 0,6,600
	subf 9,0,9
	mulhw 8,9,8
	srawi 9,9,31
	srawi 8,8,2
	subf 7,9,8
	bc 12,2,.L121
	stw 23,8(1)
	b .L122
.L121:
	stw 24,8(1)
.L122:
	mr 8,3
	mr 9,4
	lis 5,.LC28@ha
	mr 10,29
	addi 3,1,16
	la 5,.LC28@l(5)
	li 4,80
	crxor 6,6,6
	bl Com_sprintf
	mr 3,31
	bl strlen
	mr 29,3
	addi 3,1,16
	bl strlen
	add 29,29,3
	cmplwi 0,29,1350
	bc 4,1,.L123
	mr 3,31
	bl strlen
	lis 4,.LC31@ha
	add 3,31,3
	la 4,.LC31@l(4)
	crxor 6,6,6
	bl sprintf
	la 9,gi@l(21)
	mr 3,27
	lwz 0,8(9)
	la 5,.LC24@l(20)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L115
.L123:
	mr 3,31
	addi 4,1,16
	bl strcat
.L118:
	addi 28,28,1
	lwz 11,maxclients@l(22)
	xoris 0,28,0x8000
	lis 10,.LC33@ha
	stw 0,1516(1)
	la 10,.LC33@l(10)
	addi 30,30,1084
	stw 26,1512(1)
	lfd 13,0(10)
	lfd 0,1512(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L119
.L117:
	lis 9,gi+8@ha
	lis 5,.LC24@ha
	lwz 0,gi+8@l(9)
	mr 3,27
	la 5,.LC24@l(5)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L115:
	lwz 0,1572(1)
	mtlr 0
	lmw 20,1520(1)
	la 1,1568(1)
	blr
.Lfe5:
	.size	 Cmd_PlayerList_f,.Lfe5-Cmd_PlayerList_f
	.section	".rodata"
	.align 2
.LC34:
	.string	"players"
	.align 2
.LC35:
	.string	"say"
	.align 2
.LC36:
	.string	"say_team"
	.align 2
.LC37:
	.string	"score"
	.align 2
.LC38:
	.string	"help"
	.align 2
.LC39:
	.string	"use"
	.align 2
.LC40:
	.string	"god"
	.align 2
.LC41:
	.string	"notarget"
	.align 2
.LC42:
	.string	"noclip"
	.align 2
.LC43:
	.string	"inven"
	.align 2
.LC44:
	.string	"invnext"
	.align 2
.LC45:
	.string	"invprev"
	.align 2
.LC46:
	.string	"invnextw"
	.align 2
.LC47:
	.string	"invprevw"
	.align 2
.LC48:
	.string	"invnextp"
	.align 2
.LC49:
	.string	"invprevp"
	.align 2
.LC50:
	.string	"invuse"
	.align 2
.LC51:
	.string	"invdrop"
	.align 2
.LC52:
	.string	"weaplast"
	.align 2
.LC53:
	.string	"kill"
	.align 2
.LC54:
	.string	"putaway"
	.align 2
.LC55:
	.string	"wave"
	.align 2
.LC56:
	.string	"playerlist"
	.align 2
.LC57:
	.long 0x0
	.align 2
.LC58:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl ClientCommand
	.type	 ClientCommand,@function
ClientCommand:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	mr 30,3
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L125
	lis 9,gi@ha
	li 3,0
	la 29,gi@l(9)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC34@ha
	la 4,.LC34@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L127
	mr 3,30
	bl Cmd_Players_f
	b .L125
.L127:
	lis 4,.LC35@ha
	mr 3,31
	la 4,.LC35@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L128
	mr 3,30
	li 4,0
	b .L205
.L128:
	lis 4,.LC36@ha
	mr 3,31
	la 4,.LC36@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L129
	mr 3,30
	li 4,1
.L205:
	li 5,0
	bl Cmd_Say_f
	b .L125
.L129:
	lis 4,.LC37@ha
	mr 3,31
	la 4,.LC37@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L130
	mr 3,30
	bl Cmd_Score_f
	b .L125
.L130:
	lis 4,.LC38@ha
	mr 3,31
	la 4,.LC38@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L131
	mr 3,30
	bl Cmd_Help_f
	b .L125
.L131:
	lis 9,level@ha
	lis 11,.LC57@ha
	la 11,.LC57@l(11)
	la 28,level@l(9)
	lfs 31,0(11)
	lfs 0,200(28)
	fcmpu 0,0,31
	bc 4,2,.L125
	lis 4,.LC39@ha
	mr 3,31
	la 4,.LC39@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L125
	lis 4,.LC40@ha
	mr 3,31
	la 4,.LC40@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L136
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L137
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L137
	lwz 0,8(29)
	lis 5,.LC1@ha
	mr 3,30
	la 5,.LC1@l(5)
	b .L206
.L137:
	lwz 0,264(30)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(30)
	bc 4,2,.L139
	lis 9,.LC2@ha
	la 5,.LC2@l(9)
	b .L152
.L139:
	lis 9,.LC3@ha
	la 5,.LC3@l(9)
	b .L152
.L136:
	lis 4,.LC41@ha
	mr 3,31
	la 4,.LC41@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L142
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L143
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L143
	lwz 0,8(29)
	lis 5,.LC1@ha
	mr 3,30
	la 5,.LC1@l(5)
	b .L206
.L143:
	lwz 0,264(30)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(30)
	bc 4,2,.L145
	lis 9,.LC4@ha
	la 5,.LC4@l(9)
	b .L152
.L145:
	lis 9,.LC5@ha
	la 5,.LC5@l(9)
	b .L152
.L142:
	lis 4,.LC42@ha
	mr 3,31
	la 4,.LC42@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L148
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L149
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L149
	lwz 0,8(29)
	lis 5,.LC1@ha
	mr 3,30
	la 5,.LC1@l(5)
	b .L206
.L149:
	lwz 0,260(30)
	cmpwi 0,0,1
	bc 4,2,.L151
	li 0,4
	lis 9,.LC6@ha
	stw 0,260(30)
	la 5,.LC6@l(9)
	b .L152
.L151:
	li 0,1
	lis 9,.LC7@ha
	stw 0,260(30)
	la 5,.LC7@l(9)
.L152:
	lis 9,gi+8@ha
	mr 3,30
	lwz 0,gi+8@l(9)
.L206:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L125
.L148:
	lis 4,.LC43@ha
	mr 3,31
	la 4,.LC43@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L154
	lwz 11,84(30)
	lwz 0,4596(11)
	stw 3,4592(11)
	cmpwi 0,0,0
	stw 3,4600(11)
	bc 12,2,.L155
	stw 3,4596(11)
	b .L125
.L155:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,4596(11)
	li 3,5
	lwz 0,100(9)
	mr 29,9
	li 31,0
	mtlr 0
	blrl
.L159:
	mr 3,31
	bl GetItemByIndex
	mr. 3,3
	bc 12,2,.L160
	lwz 4,20(3)
	cmpwi 0,4,0
	bc 12,2,.L160
	mr 3,30
	bl CountItemByTag
	lwz 9,104(29)
	mtlr 9
	blrl
	b .L162
.L160:
	lwz 9,104(29)
	li 3,0
	mtlr 9
	blrl
.L162:
	addi 31,31,1
	cmpwi 0,31,255
	bc 4,1,.L159
	lis 9,gi+92@ha
	mr 3,30
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L125
.L154:
	lis 4,.LC44@ha
	mr 3,31
	la 4,.LC44@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L125
	lis 4,.LC45@ha
	mr 3,31
	la 4,.LC45@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L125
	lis 4,.LC46@ha
	mr 3,31
	la 4,.LC46@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L125
	lis 4,.LC47@ha
	mr 3,31
	la 4,.LC47@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L125
	lis 4,.LC48@ha
	mr 3,31
	la 4,.LC48@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L125
	lis 4,.LC49@ha
	mr 3,31
	la 4,.LC49@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L125
	lis 4,.LC50@ha
	mr 3,31
	la 4,.LC50@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L125
	lis 4,.LC51@ha
	mr 3,31
	la 4,.LC51@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L125
	lis 4,.LC52@ha
	mr 3,31
	la 4,.LC52@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L125
	lis 4,.LC53@ha
	mr 3,31
	la 4,.LC53@l(4)
	bl Q_stricmp
	mr. 10,3
	bc 4,2,.L192
	lwz 9,84(30)
	lis 11,.LC58@ha
	lfs 0,4(28)
	la 11,.LC58@l(11)
	lfs 13,4888(9)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L125
	lwz 0,264(30)
	mr 3,30
	lis 11,meansOfDeath@ha
	stw 10,480(30)
	li 9,23
	lis 6,0x1
	rlwinm 0,0,0,28,26
	lis 7,vec3_origin@ha
	stw 0,264(30)
	la 7,vec3_origin@l(7)
	mr 4,3
	stw 9,meansOfDeath@l(11)
	mr 5,3
	ori 6,6,34464
	bl player_die
	b .L125
.L192:
	lis 4,.LC54@ha
	mr 3,31
	la 4,.LC54@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L196
	lwz 9,84(30)
	stw 3,4592(9)
	lwz 11,84(30)
	stw 3,4600(11)
	lwz 9,84(30)
	stw 3,4596(9)
	b .L125
.L196:
	lis 4,.LC55@ha
	mr 3,31
	la 4,.LC55@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L199
	mr 3,30
	bl Cmd_Wave_f
	b .L125
.L199:
	lis 4,.LC56@ha
	mr 3,31
	la 4,.LC56@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L201
	mr 3,30
	bl Cmd_PlayerList_f
	b .L125
.L201:
	mr 3,30
	bl z_ClientCommand
	cmpwi 0,3,0
	bc 4,2,.L125
	mr 3,30
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L125:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 ClientCommand,.Lfe6-ClientCommand
	.align 2
	.globl ValidateSelectedItem
	.type	 ValidateSelectedItem,@function
ValidateSelectedItem:
	blr
.Lfe7:
	.size	 ValidateSelectedItem,.Lfe7-ValidateSelectedItem
	.align 2
	.globl ClientTeam
	.type	 ClientTeam,@function
ClientTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 9,value.6@ha
	li 30,0
	stb 30,value.6@l(9)
	la 31,value.6@l(9)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L208
	lis 4,.LC0@ha
	addi 3,3,188
	la 4,.LC0@l(4)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl strcpy
	mr 3,31
	li 4,47
	bl strchr
	mr. 3,3
	bc 12,2,.L208
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,128
	bc 4,2,.L9
	addi 3,3,1
	b .L207
.L9:
	stb 30,0(3)
.L208:
	mr 3,31
.L207:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 ClientTeam,.Lfe8-ClientTeam
	.align 2
	.globl SelectNextItem
	.type	 SelectNextItem,@function
SelectNextItem:
	blr
.Lfe9:
	.size	 SelectNextItem,.Lfe9-SelectNextItem
	.align 2
	.globl SelectPrevItem
	.type	 SelectPrevItem,@function
SelectPrevItem:
	blr
.Lfe10:
	.size	 SelectPrevItem,.Lfe10-SelectPrevItem
	.align 2
	.globl Cmd_Give_f
	.type	 Cmd_Give_f,@function
Cmd_Give_f:
	blr
.Lfe11:
	.size	 Cmd_Give_f,.Lfe11-Cmd_Give_f
	.section	".rodata"
	.align 2
.LC59:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC59@ha
	lis 9,deathmatch@ha
	la 11,.LC59@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L33
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L33
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L32
.L33:
	lwz 0,264(3)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(3)
	bc 4,2,.L34
	lis 9,.LC2@ha
	la 5,.LC2@l(9)
	b .L35
.L34:
	lis 9,.LC3@ha
	la 5,.LC3@l(9)
.L35:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L32:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe12:
	.size	 Cmd_God_f,.Lfe12-Cmd_God_f
	.section	".rodata"
	.align 2
.LC60:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC60@ha
	lis 9,deathmatch@ha
	la 11,.LC60@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L37
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L37
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L36
.L37:
	lwz 0,264(3)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(3)
	bc 4,2,.L38
	lis 9,.LC4@ha
	la 5,.LC4@l(9)
	b .L39
.L38:
	lis 9,.LC5@ha
	la 5,.LC5@l(9)
.L39:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L36:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 Cmd_Notarget_f,.Lfe13-Cmd_Notarget_f
	.section	".rodata"
	.align 2
.LC61:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC61@ha
	lis 9,deathmatch@ha
	la 11,.LC61@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L41
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L41
	lis 9,gi+8@ha
	lis 5,.LC1@ha
	lwz 0,gi+8@l(9)
	la 5,.LC1@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L40
.L41:
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 4,2,.L42
	li 0,4
	lis 9,.LC6@ha
	stw 0,260(3)
	la 5,.LC6@l(9)
	b .L43
.L42:
	li 0,1
	lis 9,.LC7@ha
	stw 0,260(3)
	la 5,.LC7@l(9)
.L43:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L40:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 Cmd_Noclip_f,.Lfe14-Cmd_Noclip_f
	.align 2
	.globl Cmd_Use_f
	.type	 Cmd_Use_f,@function
Cmd_Use_f:
	blr
.Lfe15:
	.size	 Cmd_Use_f,.Lfe15-Cmd_Use_f
	.align 2
	.globl Cmd_Drop_f
	.type	 Cmd_Drop_f,@function
Cmd_Drop_f:
	blr
.Lfe16:
	.size	 Cmd_Drop_f,.Lfe16-Cmd_Drop_f
	.align 2
	.globl Cmd_Inven_f
	.type	 Cmd_Inven_f,@function
Cmd_Inven_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,3
	li 9,0
	lwz 11,84(30)
	lwz 0,4596(11)
	stw 9,4592(11)
	cmpwi 0,0,0
	stw 9,4600(11)
	bc 12,2,.L47
	stw 9,4596(11)
	b .L46
.L47:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,4596(11)
	li 3,5
	lwz 0,100(9)
	mr 29,9
	li 31,0
	mtlr 0
	blrl
.L51:
	mr 3,31
	bl GetItemByIndex
	mr. 3,3
	bc 12,2,.L52
	lwz 4,20(3)
	cmpwi 0,4,0
	bc 12,2,.L52
	mr 3,30
	bl CountItemByTag
	lwz 9,104(29)
	mtlr 9
	blrl
	b .L50
.L52:
	lwz 9,104(29)
	li 3,0
	mtlr 9
	blrl
.L50:
	addi 31,31,1
	cmpwi 0,31,255
	bc 4,1,.L51
	lis 9,gi+92@ha
	mr 3,30
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L46:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 Cmd_Inven_f,.Lfe17-Cmd_Inven_f
	.align 2
	.globl Cmd_InvUse_f
	.type	 Cmd_InvUse_f,@function
Cmd_InvUse_f:
	blr
.Lfe18:
	.size	 Cmd_InvUse_f,.Lfe18-Cmd_InvUse_f
	.align 2
	.globl Cmd_WeapPrev_f
	.type	 Cmd_WeapPrev_f,@function
Cmd_WeapPrev_f:
	blr
.Lfe19:
	.size	 Cmd_WeapPrev_f,.Lfe19-Cmd_WeapPrev_f
	.align 2
	.globl Cmd_WeapNext_f
	.type	 Cmd_WeapNext_f,@function
Cmd_WeapNext_f:
	blr
.Lfe20:
	.size	 Cmd_WeapNext_f,.Lfe20-Cmd_WeapNext_f
	.align 2
	.globl Cmd_WeapLast_f
	.type	 Cmd_WeapLast_f,@function
Cmd_WeapLast_f:
	blr
.Lfe21:
	.size	 Cmd_WeapLast_f,.Lfe21-Cmd_WeapLast_f
	.align 2
	.globl Cmd_InvDrop_f
	.type	 Cmd_InvDrop_f,@function
Cmd_InvDrop_f:
	blr
.Lfe22:
	.size	 Cmd_InvDrop_f,.Lfe22-Cmd_InvDrop_f
	.section	".rodata"
	.align 2
.LC62:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Cmd_Kill_f
	.type	 Cmd_Kill_f,@function
Cmd_Kill_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	lis 9,level+4@ha
	lwz 11,84(10)
	lis 8,.LC62@ha
	lfs 0,level+4@l(9)
	la 8,.LC62@l(8)
	lfs 13,4888(11)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L60
	lwz 0,264(10)
	li 9,0
	stw 9,480(10)
	lis 11,meansOfDeath@ha
	lis 6,0x1
	rlwinm 0,0,0,28,26
	li 9,23
	stw 0,264(10)
	lis 7,vec3_origin@ha
	mr 4,3
	stw 9,meansOfDeath@l(11)
	la 7,vec3_origin@l(7)
	mr 5,3
	ori 6,6,34464
	bl player_die
.L60:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe23:
	.size	 Cmd_Kill_f,.Lfe23-Cmd_Kill_f
	.align 2
	.globl Cmd_PutAway_f
	.type	 Cmd_PutAway_f,@function
Cmd_PutAway_f:
	lwz 9,84(3)
	li 0,0
	stw 0,4592(9)
	lwz 11,84(3)
	stw 0,4600(11)
	lwz 9,84(3)
	stw 0,4596(9)
	blr
.Lfe24:
	.size	 Cmd_PutAway_f,.Lfe24-Cmd_PutAway_f
	.align 2
	.globl PlayerSort
	.type	 PlayerSort,@function
PlayerSort:
	lwz 9,0(3)
	lis 11,game+1028@ha
	lwz 3,0(4)
	lwz 0,game+1028@l(11)
	mulli 9,9,5216
	mulli 11,3,5216
	add 9,9,0
	add 11,11,0
	lha 9,124(9)
	lha 3,124(11)
	cmpw 0,9,3
	li 3,-1
	bclr 12,0
	mfcr 3
	rlwinm 3,3,2,1
	blr
.Lfe25:
	.size	 PlayerSort,.Lfe25-PlayerSort
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
