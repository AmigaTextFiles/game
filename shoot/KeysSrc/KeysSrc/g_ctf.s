	.file	"g_ctf.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.globl techspawn
	.section	".sdata","aw"
	.align 2
	.type	 techspawn,@object
	.size	 techspawn,4
techspawn:
	.long 0
	.globl flag1_ent
	.align 2
	.type	 flag1_ent,@object
	.size	 flag1_ent,4
flag1_ent:
	.long 0
	.globl flag2_ent
	.align 2
	.type	 flag2_ent,@object
	.size	 flag2_ent,4
flag2_ent:
	.long 0
	.globl ctf_statusbar
	.section	".rodata"
	.align 2
.LC0:
	.ascii	"yb\t-24 xv\t0 hnum xv\t50 pic 0 if 2 \txv\t100 \tanum \txv\t"
	.ascii	"150 \tpic 2 endif if 4 \txv\t200 \trnum \txv\t250 \tpic 4 en"
	.ascii	"dif if 6 \txv\t296 \tpic 6 endif yb\t-50 if 7 \txv\t0 \tpic "
	.ascii	"7 \txv\t26 \tyb\t-42 \tstat_string 8 \tyb\t-50 endif if 9 xv"
	.ascii	" 246 num 3 10 xv 296 pic 9 endif if 21 xv 222 pic 21 endif i"
	.ascii	"f 16 \txv 246 \tnum\t3 28 \txv\t296 \tpic\t16 endif if 11 xv"
	.ascii	" 148 pic 11 endif xr\t-50 yt 10 num 3 14 xr -42 yt 2 string2"
	.ascii	" \"Frags\" yb -129 if 26 xr -26 pic 26 endif if 29 \tyt 41 \t"
	.ascii	"xr -50 \tnum 3 29 \txr -74 \tyt 33 \tstring2 \"Time Left\" e"
	.ascii	"ndif if 30 \tyt 74 \txr -50 \tnum 3 30 \txr -74 \tyt 66"
	.string	" \tstring2 \"Caps Left\" endif yb -102 if 17 xr -26 pic 17 endif xr -62 num 2 18 if 22 yb -104 xr -28 pic 22 endif yb -75 if 19 xr -26 pic 19 endif xr -62 num 2 20 if 23 yb -77 xr -28 pic 23 endif if 27 xv 0 yb -58 string \"Viewing\" xv 64 stat_string 27 endif "
	.section	".sdata","aw"
	.align 2
	.type	 ctf_statusbar,@object
	.size	 ctf_statusbar,4
ctf_statusbar:
	.long .LC0
	.section	".data"
	.align 2
	.type	 tnames,@object
tnames:
	.long .LC1
	.long .LC2
	.long .LC3
	.long .LC4
	.long 0
	.section	".rodata"
	.align 2
.LC4:
	.string	"item_tech4"
	.align 2
.LC3:
	.string	"item_tech3"
	.align 2
.LC2:
	.string	"item_tech2"
	.align 2
.LC1:
	.string	"item_tech1"
	.size	 tnames,20
	.globl titems
	.section	".data"
	.align 2
	.type	 titems,@object
	.size	 titems,16
titems:
	.long 0
	.long 0
	.long 0
	.long 0
	.section	".rodata"
	.align 3
.LC5:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC6:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.type	 loc_CanSee,@function
loc_CanSee:
	stwu 1,-224(1)
	mflr 0
	stfd 31,216(1)
	stmw 26,192(1)
	stw 0,228(1)
	lwz 0,260(3)
	mr 30,4
	cmpwi 0,0,2
	bc 4,2,.L23
	b .L33
.L32:
	li 3,1
	b .L31
.L23:
	mr 10,3
	lfs 12,188(3)
	addi 11,3,188
	lfsu 9,4(10)
	addi 8,3,200
	lis 9,.LC5@ha
	lfs 7,200(3)
	la 9,.LC5@l(9)
	lfd 6,0(9)
	lis 6,0x4330
	addi 28,1,168
	fadds 8,9,12
	lis 9,gi@ha
	lis 27,vec3_origin@ha
	fadds 9,9,7
	la 26,gi@l(9)
	addi 31,1,72
	lis 9,.LC6@ha
	addi 29,1,156
	stfs 8,72(1)
	fsubs 12,8,12
	la 9,.LC6@l(9)
	lfs 0,4(11)
	fsubs 5,9,7
	lfs 11,4(10)
	fsubs 7,8,7
	lfd 31,0(9)
	fadds 11,11,0
	stfs 11,76(1)
	lfs 0,8(11)
	lfs 10,8(10)
	stfs 11,100(1)
	stfs 11,88(1)
	fadds 10,10,0
	stfs 12,84(1)
	stfs 8,96(1)
	stfs 10,80(1)
	stfs 10,92(1)
	stfs 10,104(1)
	lfs 13,4(11)
	stfs 11,112(1)
	stfs 10,116(1)
	fsubs 13,11,13
	stfs 12,108(1)
	stfs 13,100(1)
	lfs 0,4(11)
	stfs 9,120(1)
	fsubs 0,11,0
	stfs 0,112(1)
	lfs 0,4(8)
	lfs 13,4(10)
	fadds 13,13,0
	stfs 13,124(1)
	lfs 12,8(8)
	lfs 0,8(10)
	stfs 13,136(1)
	stfs 5,132(1)
	fadds 0,0,12
	stfs 0,140(1)
	stfs 0,128(1)
	stfs 8,144(1)
	lwz 0,508(30)
	stfs 11,148(1)
	xoris 0,0,0x8000
	stfs 10,152(1)
	stw 0,188(1)
	lfs 13,4(8)
	stw 6,184(1)
	lfd 0,184(1)
	fsubs 13,11,13
	stfs 11,160(1)
	stfs 10,164(1)
	stfs 7,156(1)
	fsub 0,0,6
	lfs 12,12(30)
	stfs 13,148(1)
	lfs 13,4(8)
	frsp 0,0
	lfs 9,4(30)
	lfs 10,8(30)
	fsubs 11,11,13
	fadds 12,12,0
	stfs 9,168(1)
	stfs 10,172(1)
	stfs 11,160(1)
	stfs 12,176(1)
.L28:
	lwz 11,48(26)
	la 5,vec3_origin@l(27)
	addi 3,1,8
	mr 4,28
	mr 6,5
	mr 7,31
	mr 8,30
	mtlr 11
	li 9,3
	blrl
	lfs 0,16(1)
	fcmpu 0,0,31
	bc 12,2,.L32
	addi 31,31,12
	cmpw 0,31,29
	bc 4,1,.L28
.L33:
	li 3,0
.L31:
	lwz 0,228(1)
	mtlr 0
	lmw 26,192(1)
	lfd 31,216(1)
	la 1,224(1)
	blr
.Lfe1:
	.size	 loc_CanSee,.Lfe1-loc_CanSee
	.section	".rodata"
	.align 2
.LC7:
	.string	"ctf"
	.align 2
.LC8:
	.string	"0"
	.align 2
.LC9:
	.string	"ctf_forcejoin"
	.align 2
.LC10:
	.string	""
	.align 2
.LC11:
	.string	"item_flag_team1"
	.align 2
.LC12:
	.string	"item_flag_team2"
	.section	".text"
	.align 2
	.globl CTFInit
	.type	 CTFInit,@function
CTFInit:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 29,gi@ha
	lis 3,.LC7@ha
	la 29,gi@l(29)
	lis 4,.LC8@ha
	lwz 9,144(29)
	la 4,.LC8@l(4)
	li 5,20
	la 3,.LC7@l(3)
	lis 31,flag1_item@ha
	mtlr 9
	blrl
	lwz 0,144(29)
	lis 9,ctf@ha
	lis 11,.LC9@ha
	stw 3,ctf@l(9)
	lis 4,.LC10@ha
	li 5,0
	mtlr 0
	la 3,.LC9@l(11)
	la 4,.LC10@l(4)
	blrl
	lwz 0,flag1_item@l(31)
	lis 9,ctf_forcejoin@ha
	stw 3,ctf_forcejoin@l(9)
	cmpwi 0,0,0
	bc 4,2,.L35
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	bl FindItemByClassname
	stw 3,flag1_item@l(31)
.L35:
	lis 29,flag2_item@ha
	lwz 0,flag2_item@l(29)
	cmpwi 0,0,0
	bc 4,2,.L36
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	bl FindItemByClassname
	stw 3,flag2_item@l(29)
.L36:
	lis 3,ctfgame@ha
	li 4,0
	li 5,24
	la 3,ctfgame@l(3)
	crxor 6,6,6
	bl memset
	li 0,0
	lis 9,techspawn@ha
	lis 3,.LC1@ha
	stw 0,techspawn@l(9)
	la 3,.LC1@l(3)
	bl FindItemByClassname
	lis 9,item_tech1@ha
	lis 11,.LC2@ha
	stw 3,item_tech1@l(9)
	la 3,.LC2@l(11)
	bl FindItemByClassname
	lis 9,item_tech2@ha
	lis 11,.LC3@ha
	stw 3,item_tech2@l(9)
	la 3,.LC3@l(11)
	bl FindItemByClassname
	lis 9,item_tech3@ha
	lis 11,.LC4@ha
	stw 3,item_tech3@l(9)
	la 3,.LC4@l(11)
	bl FindItemByClassname
	lis 9,item_tech4@ha
	stw 3,item_tech4@l(9)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 CTFInit,.Lfe2-CTFInit
	.section	".rodata"
	.align 2
.LC13:
	.string	"RED"
	.align 2
.LC14:
	.string	"BLUE"
	.align 2
.LC15:
	.string	"UNKNOWN"
	.align 2
.LC16:
	.string	"%s"
	.align 2
.LC17:
	.string	"male/"
	.align 2
.LC18:
	.string	"%s\\%s%s"
	.align 2
.LC19:
	.string	"ctf_r"
	.align 2
.LC20:
	.string	"ctf_b"
	.align 2
.LC21:
	.string	"%s\\%s"
	.align 2
.LC22:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFAssignSkin
	.type	 CTFAssignSkin,@function
CTFAssignSkin:
	stwu 1,-96(1)
	mflr 0
	stmw 29,84(1)
	stw 0,100(1)
	lis 9,ctf@ha
	lis 11,g_edicts@ha
	lwz 10,ctf@l(9)
	mr 29,3
	lis 0,0xfb74
	lwz 9,g_edicts@l(11)
	ori 0,0,41881
	mr 30,4
	lis 11,.LC22@ha
	lfs 0,20(10)
	la 11,.LC22@l(11)
	subf 9,9,29
	lfs 13,0(11)
	mullw 9,9,0
	srawi 9,9,3
	fcmpu 0,0,13
	addi 31,9,-1
	bc 12,2,.L55
	lis 5,.LC16@ha
	addi 3,1,8
	la 5,.LC16@l(5)
	li 4,64
	mr 6,30
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,8
	li 4,47
	bl strrchr
	mr. 3,3
	bc 12,2,.L57
	li 0,0
	stb 0,1(3)
	b .L58
.L57:
	lis 9,.LC17@ha
	la 11,.LC17@l(9)
	lwz 0,.LC17@l(9)
	lhz 10,4(11)
	stw 0,8(1)
	sth 10,12(1)
.L58:
	lwz 9,84(29)
	lwz 3,3468(9)
	mr 4,9
	cmpwi 0,3,1
	bc 12,2,.L60
	cmpwi 0,3,2
	bc 12,2,.L61
	b .L62
.L60:
	lis 29,gi@ha
	lis 3,.LC18@ha
	lis 6,.LC19@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC18@l(3)
	la 6,.LC19@l(6)
	b .L64
.L61:
	lis 29,gi@ha
	lis 3,.LC18@ha
	lis 6,.LC20@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC18@l(3)
	la 6,.LC20@l(6)
.L64:
	addi 5,1,8
	crxor 6,6,6
	bl va
	lwz 9,24(29)
	addi 0,31,1312
	mr 4,3
	mr 3,0
	mtlr 9
	blrl
	b .L55
.L62:
	lis 29,gi@ha
	lis 3,.LC21@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC21@l(3)
	mr 5,30
	crxor 6,6,6
	bl va
	lwz 9,24(29)
	addi 0,31,1312
	mr 4,3
	mr 3,0
	mtlr 9
	blrl
.L55:
	lwz 0,100(1)
	mtlr 0
	lmw 29,84(1)
	la 1,96(1)
	blr
.Lfe3:
	.size	 CTFAssignSkin,.Lfe3-CTFAssignSkin
	.section	".rodata"
	.align 2
.LC23:
	.long 0x0
	.align 2
.LC24:
	.long 0x3f800000
	.align 3
.LC25:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFAssignTeam
	.type	 CTFAssignTeam,@function
CTFAssignTeam:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 11,.LC23@ha
	lis 9,ctf@ha
	la 11,.LC23@l(11)
	mr 31,3
	lfs 13,0(11)
	li 8,0
	li 7,0
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L65
	cmpwi 0,4,0
	stw 8,3472(31)
	bc 4,2,.L67
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 0,11,2
	bc 4,2,.L67
	stw 8,3468(31)
	b .L65
.L67:
	lis 9,force_team@ha
	lwz 0,force_team@l(9)
	cmpwi 0,0,1
	bc 12,2,.L89
	cmpwi 0,0,2
	bc 12,2,.L89
	lis 11,.LC24@ha
	lis 9,maxclients@ha
	la 11,.LC24@l(11)
	li 10,1
	lfs 0,0(11)
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L72
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	addi 11,11,1352
	lfd 13,0(9)
.L74:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L73
	lwz 9,84(11)
	cmpw 0,9,31
	bc 12,2,.L73
	lwz 0,3468(9)
	cmpwi 0,0,1
	bc 12,2,.L78
	cmpwi 0,0,2
	bc 12,2,.L79
	b .L73
.L78:
	addi 8,8,1
	b .L73
.L79:
	addi 7,7,1
.L73:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,1352
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L74
.L72:
	cmpw 0,8,7
	bc 4,0,.L83
	li 0,1
	b .L89
.L83:
	cmpw 0,7,8
	bc 12,0,.L87
	bl rand
	andi. 0,3,1
	li 0,1
	bc 4,2,.L89
.L87:
	li 0,2
.L89:
	stw 0,3468(31)
.L65:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 CTFAssignTeam,.Lfe4-CTFAssignTeam
	.section	".rodata"
	.align 2
.LC26:
	.string	"info_player_team1"
	.align 2
.LC27:
	.string	"info_player_team2"
	.align 2
.LC28:
	.long 0x47c34f80
	.section	".text"
	.align 2
	.globl SelectCTFSpawnPoint
	.type	 SelectCTFSpawnPoint,@function
SelectCTFSpawnPoint:
	stwu 1,-64(1)
	mflr 0
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 27,28(1)
	stw 0,68(1)
	lwz 9,84(3)
	li 31,0
	lwz 0,3472(9)
	cmpwi 0,0,0
	bc 12,2,.L91
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,512
	bc 12,2,.L115
	bl SelectFarthestDeathmatchSpawnPoint
	b .L114
.L91:
	li 0,1
	stw 0,3472(9)
	lwz 9,84(3)
	lwz 3,3468(9)
	cmpwi 0,3,1
	bc 12,2,.L95
	cmpwi 0,3,2
	bc 12,2,.L96
	b .L115
.L95:
	lis 9,.LC26@ha
	la 27,.LC26@l(9)
	b .L94
.L96:
	lis 9,.LC27@ha
	la 27,.LC27@l(9)
.L94:
	lis 9,.LC28@ha
	li 30,0
	lfs 31,.LC28@l(9)
	li 28,0
	li 29,0
	fmr 30,31
	b .L99
.L101:
	mr 3,30
	addi 31,31,1
	bl PlayersRangeFromSpot
	fcmpu 0,1,30
	bc 4,0,.L102
	fmr 30,1
	mr 29,30
	b .L99
.L102:
	fcmpu 0,1,31
	bc 4,0,.L99
	fmr 31,1
	mr 28,30
.L99:
	mr 3,30
	li 4,280
	mr 5,27
	bl G_Find
	mr. 30,3
	bc 4,2,.L101
	cmpwi 0,31,0
	bc 4,2,.L106
.L115:
	bl SelectRandomDeathmatchSpawnPoint
	b .L114
.L106:
	cmpwi 0,31,2
	bc 12,1,.L107
	li 28,0
	li 29,0
	b .L108
.L107:
	addi 31,31,-2
.L108:
	bl rand
	li 30,0
	divw 0,3,31
	mullw 0,0,31
	subf 31,0,3
.L113:
	mr 3,30
	li 4,280
	mr 5,27
	bl G_Find
	mr 30,3
	addi 0,31,1
	xor 9,30,29
	subfic 10,9,0
	adde 9,10,9
	xor 11,30,28
	subfic 10,11,0
	adde 11,10,11
	or 9,9,11
	addic 9,9,-1
	subfe 9,9,9
	andc 0,0,9
	and 9,31,9
	or 31,9,0
	cmpwi 0,31,0
	addi 31,31,-1
	bc 4,2,.L113
.L114:
	lwz 0,68(1)
	mtlr 0
	lmw 27,28(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 SelectCTFSpawnPoint,.Lfe5-SelectCTFSpawnPoint
	.section	".rodata"
	.align 2
.LC29:
	.string	"BONUS: %d points for fragging enemy flag carrier.\n"
	.align 2
.LC30:
	.string	"FC Frag"
	.align 2
.LC31:
	.string	"%s defends %s's flag carrier against an agressive enemy\n"
	.align 2
.LC32:
	.string	"FC Def"
	.align 2
.LC33:
	.string	"%s defends the %s base.\n"
	.align 2
.LC34:
	.string	"%s defends the %s flag.\n"
	.align 2
.LC35:
	.string	"F Def"
	.align 2
.LC36:
	.string	"%s defends the %s's flag carrier.\n"
	.align 2
.LC37:
	.long 0x0
	.align 2
.LC38:
	.long 0x3f800000
	.align 3
.LC39:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC40:
	.long 0x41000000
	.align 2
.LC41:
	.long 0x43c80000
	.section	".text"
	.align 2
	.globl CTFFragBonuses
	.type	 CTFFragBonuses,@function
CTFFragBonuses:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 26,48(1)
	stw 0,84(1)
	lis 9,ctf@ha
	lis 10,.LC37@ha
	lwz 11,ctf@l(9)
	la 10,.LC37@l(10)
	mr 27,3
	lfs 13,0(10)
	mr 28,5
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L116
	lwz 0,84(27)
	cmpwi 0,0,0
	mr 8,0
	bc 12,2,.L116
	lwz 0,84(28)
	xor 9,27,28
	subfic 11,9,0
	adde 9,11,9
	mr 7,0
	subfic 10,0,0
	adde 0,10,0
	or. 11,0,9
	bc 4,2,.L116
	lwz 0,3468(8)
	cmpwi 0,0,1
	bc 12,2,.L120
	cmpwi 0,0,2
	bc 12,2,.L121
	b .L124
.L120:
	li 30,2
	b .L123
.L121:
	li 30,1
	b .L123
.L124:
	li 30,-1
.L123:
	cmpwi 0,30,0
	bc 12,0,.L116
	lwz 0,3468(8)
	cmpwi 0,0,1
	bc 4,2,.L126
	lis 9,flag1_item@ha
	lis 11,flag2_item@ha
	lwz 26,flag1_item@l(9)
	lwz 0,flag2_item@l(11)
	b .L127
.L126:
	lis 9,flag2_item@ha
	lis 11,flag1_item@ha
	lwz 26,flag2_item@l(9)
	lwz 0,flag1_item@l(11)
.L127:
	lis 9,itemlist@ha
	lis 10,0x286b
	la 6,itemlist@l(9)
	ori 10,10,51739
	subf 0,6,0
	addi 11,8,740
	mullw 0,0,10
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L128
	lis 9,level@ha
	lwz 10,84(28)
	la 31,level@l(9)
	lfs 0,4(31)
	stfs 0,3488(10)
	lwz 11,84(28)
	lwz 9,3464(11)
	addi 9,9,2
	stw 9,3464(11)
	lwz 0,968(28)
	cmpwi 0,0,0
	bc 4,2,.L129
	lis 5,.LC29@ha
	mr 3,28
	la 5,.LC29@l(5)
	li 4,1
	li 6,2
	crxor 6,6,6
	bl safe_cprintf
.L129:
	lwz 4,84(28)
	lis 3,gi@ha
	lis 6,.LC30@ha
	lfs 1,4(31)
	la 3,gi@l(3)
	la 6,.LC30@l(6)
	lwz 9,184(4)
	li 5,0
	li 7,0
	addi 4,4,700
	li 8,2
	bl sl_LogScore
	lis 9,maxclients@ha
	lis 10,.LC38@ha
	lwz 11,maxclients@l(9)
	la 10,.LC38@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	li 10,1
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L116
	lis 9,g_edicts@ha
	mr 8,11
	lwz 11,g_edicts@l(9)
	li 6,0
	lis 7,0x4330
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	addi 11,11,1352
	lfd 12,0(9)
.L133:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L132
	lwz 9,84(11)
	lwz 0,3468(9)
	cmpw 0,0,30
	bc 4,2,.L132
	stw 6,3476(9)
.L132:
	addi 10,10,1
	lfs 13,20(8)
	xoris 0,10,0x8000
	addi 11,11,1352
	stw 0,44(1)
	stw 7,40(1)
	lfd 0,40(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L133
	b .L116
.L128:
	lis 11,.LC37@ha
	lfs 12,3476(8)
	la 11,.LC37@l(11)
	lfs 0,0(11)
	fcmpu 0,12,0
	bc 12,2,.L136
	lis 9,level+4@ha
	lis 11,.LC40@ha
	lfs 0,level+4@l(9)
	la 11,.LC40@l(11)
	lfs 13,0(11)
	fsubs 0,0,12
	fcmpu 0,0,13
	bc 4,0,.L136
	subf 0,6,26
	addi 11,7,740
	mullw 0,0,10
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L136
	lwz 9,3464(7)
	addi 9,9,2
	stw 9,3464(7)
	lwz 11,84(28)
	lwz 0,3468(11)
	addi 5,11,700
	cmpwi 0,0,1
	bc 12,2,.L137
	cmpwi 0,0,2
	bc 12,2,.L138
	b .L141
.L137:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L140
.L138:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L140
.L141:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L140:
	lis 4,.LC31@ha
	li 3,1
	la 4,.LC31@l(4)
	crxor 6,6,6
	bl my_bprintf
	lwz 4,84(28)
	lis 9,level+4@ha
	lis 3,gi@ha
	lfs 1,level+4@l(9)
	lis 6,.LC32@ha
	la 3,gi@l(3)
	lwz 9,184(4)
	la 6,.LC32@l(6)
	li 5,0
	addi 4,4,700
	li 7,0
	li 8,2
	bl sl_LogScore
	b .L116
.L136:
	lwz 0,3468(7)
	cmpwi 0,0,1
	bc 12,2,.L143
	cmpwi 0,0,2
	bc 12,2,.L144
	b .L116
.L143:
	lis 9,.LC11@ha
	la 29,.LC11@l(9)
	b .L142
.L144:
	lis 9,.LC12@ha
	la 29,.LC12@l(9)
.L142:
	li 30,0
.L150:
	mr 3,30
	li 4,280
	mr 5,29
	bl G_Find
	mr. 30,3
	mcrf 7,0
	bc 12,30,.L116
	lwz 0,284(30)
	andis. 9,0,1
	bc 4,2,.L150
	bc 12,30,.L116
	lis 9,maxclients@ha
	lis 10,.LC38@ha
	lfs 11,4(27)
	lwz 11,maxclients@l(9)
	la 10,.LC38@l(10)
	lfs 0,0(10)
	lfs 13,20(11)
	li 10,1
	lfs 10,4(30)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L153
	lis 11,g_edicts@ha
	lis 9,itemlist@ha
	fmr 12,13
	lis 0,0x286b
	la 9,itemlist@l(9)
	lwz 7,g_edicts@l(11)
	ori 0,0,51739
	subf 9,9,26
	lis 11,.LC39@ha
	mullw 9,9,0
	lis 6,0x4330
	la 11,.LC39@l(11)
	lfd 13,0(11)
	rlwinm 8,9,0,0,29
	li 11,1352
.L155:
	add 31,7,11
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L156
	lwz 9,84(31)
	addi 9,9,740
	lwzx 0,9,8
	cmpwi 0,0,0
	bc 4,2,.L153
.L156:
	addi 10,10,1
	xoris 0,10,0x8000
	li 31,0
	stw 0,44(1)
	addi 11,11,1352
	stw 6,40(1)
	lfd 0,40(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L155
.L153:
	fsubs 10,11,10
	lfs 13,8(27)
	lis 9,.LC41@ha
	addi 3,1,8
	lfs 12,12(27)
	la 9,.LC41@l(9)
	lfs 11,4(28)
	stfs 10,8(1)
	lfs 0,8(30)
	lfs 10,8(28)
	lfs 9,12(28)
	fsubs 13,13,0
	lfs 31,0(9)
	stfs 13,12(1)
	lfs 0,12(30)
	fsubs 12,12,0
	stfs 12,16(1)
	lfs 0,4(30)
	fsubs 11,11,0
	stfs 11,24(1)
	lfs 0,8(30)
	fsubs 10,10,0
	stfs 10,28(1)
	lfs 0,12(30)
	fsubs 9,9,0
	stfs 9,32(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L159
	addi 29,1,24
	mr 3,29
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L159
	mr 3,30
	mr 4,27
	bl loc_CanSee
	cmpwi 0,3,0
	bc 4,2,.L159
	mr 3,30
	mr 4,28
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L158
.L159:
	lwz 9,84(28)
	lwz 11,3464(9)
	addi 11,11,1
	stw 11,3464(9)
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 4,2,.L160
	lwz 9,84(28)
	lwz 0,3468(9)
	addi 5,9,700
	cmpwi 0,0,1
	bc 12,2,.L161
	cmpwi 0,0,2
	bc 12,2,.L162
	b .L165
.L161:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L164
.L162:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L164
.L165:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L164:
	lis 4,.LC33@ha
	li 3,1
	la 4,.LC33@l(4)
	crxor 6,6,6
	bl my_bprintf
	b .L166
.L160:
	lwz 9,84(28)
	lwz 0,3468(9)
	addi 5,9,700
	cmpwi 0,0,1
	bc 12,2,.L167
	cmpwi 0,0,2
	bc 12,2,.L168
	b .L171
.L167:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L170
.L168:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L170
.L171:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L170:
	lis 4,.LC34@ha
	li 3,1
	la 4,.LC34@l(4)
	crxor 6,6,6
	bl my_bprintf
.L166:
	lwz 4,84(28)
	lis 9,level+4@ha
	lis 3,gi@ha
	lfs 1,level+4@l(9)
	lis 6,.LC35@ha
	la 3,gi@l(3)
	lwz 9,184(4)
	la 6,.LC35@l(6)
	li 5,0
	addi 4,4,700
	li 7,0
	li 8,1
	bl sl_LogScore
	b .L116
.L158:
	xor 0,31,28
	addic 9,31,-1
	subfe 11,9,31
	addic 10,0,-1
	subfe 9,10,0
	and. 0,11,9
	bc 12,2,.L116
	lfs 13,4(31)
	addi 3,1,8
	lfs 0,4(27)
	lfs 12,8(27)
	lfs 11,12(27)
	fsubs 0,0,13
	lfs 10,4(28)
	lfs 9,8(28)
	stfs 0,8(1)
	lfs 13,8(31)
	lfs 8,12(28)
	fsubs 12,12,13
	stfs 12,12(1)
	lfs 0,12(31)
	fsubs 11,11,0
	stfs 11,16(1)
	lfs 0,4(31)
	fsubs 10,10,0
	stfs 10,8(1)
	lfs 0,8(31)
	fsubs 9,9,0
	stfs 9,12(1)
	lfs 0,12(31)
	fsubs 8,8,0
	stfs 8,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L174
	mr 3,29
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L174
	mr 4,27
	mr 3,31
	bl loc_CanSee
	cmpwi 0,3,0
	bc 4,2,.L174
	mr 3,31
	mr 4,28
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L116
.L174:
	lwz 9,84(28)
	lwz 11,3464(9)
	addi 11,11,1
	stw 11,3464(9)
	lwz 10,84(28)
	lwz 0,3468(10)
	addi 5,10,700
	cmpwi 0,0,1
	bc 12,2,.L175
	cmpwi 0,0,2
	bc 12,2,.L176
	b .L179
.L175:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L178
.L176:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L178
.L179:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L178:
	lis 4,.LC36@ha
	li 3,1
	la 4,.LC36@l(4)
	crxor 6,6,6
	bl my_bprintf
	lwz 4,84(28)
	lis 9,level+4@ha
	lis 3,gi@ha
	lfs 1,level+4@l(9)
	lis 6,.LC32@ha
	la 3,gi@l(3)
	lwz 9,184(4)
	la 6,.LC32@l(6)
	li 5,0
	addi 4,4,700
	li 7,0
	li 8,1
	bl sl_LogScore
.L116:
	lwz 0,84(1)
	mtlr 0
	lmw 26,48(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe6:
	.size	 CTFFragBonuses,.Lfe6-CTFFragBonuses
	.align 2
	.globl CTFResetFlags
	.type	 CTFResetFlags,@function
CTFResetFlags:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,.LC11@ha
	li 31,0
	la 29,.LC11@l(9)
	b .L204
.L206:
	lwz 0,284(31)
	andis. 11,0,1
	bc 12,2,.L207
	mr 3,31
	bl RemoveFromItemList
	mr 3,31
	bl G_FreeEdict
	b .L204
.L207:
	lwz 0,184(31)
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	stw 30,80(31)
.L204:
	mr 3,31
	li 4,280
	mr 5,29
	li 30,1
	bl G_Find
	mr. 31,3
	lis 9,gi+72@ha
	mr 3,31
	bc 4,2,.L206
	lis 9,.LC12@ha
	lis 11,gi@ha
	la 28,.LC12@l(9)
	la 29,gi@l(11)
	li 31,0
	b .L215
.L217:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L218
	mr 3,31
	bl RemoveFromItemList
	mr 3,31
	bl G_FreeEdict
	b .L215
.L218:
	lwz 0,184(31)
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(29)
	mtlr 9
	blrl
	stw 30,80(31)
.L215:
	mr 3,31
	li 4,280
	mr 5,28
	bl G_Find
	mr. 31,3
	mr 3,31
	bc 4,2,.L217
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 CTFResetFlags,.Lfe7-CTFResetFlags
	.section	".rodata"
	.align 2
.LC42:
	.string	"Don't know what team the flag is on.\n"
	.align 2
.LC43:
	.string	"%s captured the %s flag!\n"
	.align 2
.LC44:
	.string	"F Capture"
	.align 2
.LC45:
	.string	"ctf/flagcap.wav"
	.align 2
.LC46:
	.string	"Team Score"
	.align 2
.LC47:
	.string	"%s gets an assist for returning the flag!\n"
	.align 2
.LC48:
	.string	"F Return Assist"
	.align 2
.LC49:
	.string	"%s gets an assist for fragging the flag carrier!\n"
	.align 2
.LC50:
	.string	"%s returned the %s flag!\n"
	.align 2
.LC51:
	.string	"F Return"
	.align 2
.LC52:
	.string	"ctf/flagret.wav"
	.align 2
.LC53:
	.string	"%s got the %s flag!\n"
	.align 2
.LC54:
	.string	"F Pickup"
	.align 2
.LC55:
	.long 0x3f800000
	.align 2
.LC56:
	.long 0x0
	.align 2
.LC57:
	.long 0x41200000
	.align 3
.LC58:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC59:
	.long 0x44fa0000
	.section	".text"
	.align 2
	.globl CTFPickup_Flag
	.type	 CTFPickup_Flag,@function
CTFPickup_Flag:
	stwu 1,-80(1)
	mflr 0
	mfcr 12
	stfd 31,72(1)
	stmw 22,32(1)
	stw 0,84(1)
	stw 12,28(1)
	mr 31,4
	mr 30,3
	lwz 3,280(30)
	lis 4,.LC11@ha
	la 4,.LC11@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L222
	li 26,1
	b .L223
.L222:
	lwz 3,280(30)
	lis 4,.LC12@ha
	la 4,.LC12@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L224
	lis 5,.LC42@ha
	mr 3,30
	la 5,.LC42@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L289:
	li 3,0
	b .L285
.L224:
	li 26,2
.L223:
	cmpwi 4,26,1
	bc 4,18,.L226
	lis 9,flag1_item@ha
	lis 11,flag2_item@ha
	lwz 27,flag1_item@l(9)
	lwz 28,flag2_item@l(11)
	b .L227
.L226:
	lis 9,flag2_item@ha
	lis 11,flag1_item@ha
	lwz 27,flag2_item@l(9)
	lwz 28,flag1_item@l(11)
.L227:
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L228
	lwz 0,416(31)
	cmpw 0,0,30
	bc 4,2,.L228
	li 0,0
	stw 0,416(31)
.L228:
	lwz 5,84(31)
	lwz 0,3468(5)
	cmpw 0,26,0
	bc 4,2,.L229
	lwz 0,284(30)
	andis. 9,0,1
	bc 4,2,.L230
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,28
	addi 11,5,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L289
	addi 5,5,700
	bc 12,18,.L232
	cmpwi 0,26,2
	bc 12,2,.L233
	b .L236
.L232:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L235
.L233:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L235
.L236:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L235:
	lis 4,.LC43@ha
	li 3,2
	la 4,.LC43@l(4)
	lis 24,level@ha
	crxor 6,6,6
	bl my_bprintf
	lis 25,gi@ha
	lis 29,level@ha
	lwz 4,84(31)
	lis 3,gi@ha
	la 29,level@l(29)
	lis 6,.LC44@ha
	lfs 1,4(29)
	li 7,0
	li 8,15
	lwz 9,184(4)
	la 3,gi@l(3)
	la 6,.LC44@l(6)
	addi 4,4,700
	li 5,0
	bl sl_LogScore
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,28
	addi 10,10,740
	mullw 9,9,0
	li 11,0
	lis 7,ctfgame@ha
	la 8,ctfgame@l(7)
	rlwinm 9,9,0,0,29
	stwx 11,10,9
	lfs 0,4(29)
	stw 26,20(8)
	stfs 0,16(8)
	bc 4,18,.L237
	lwz 9,ctfgame@l(7)
	addi 9,9,1
	stw 9,ctfgame@l(7)
	b .L238
.L237:
	lwz 9,4(8)
	addi 9,9,1
	stw 9,4(8)
.L238:
	lis 29,gi@ha
	lis 3,.LC45@ha
	la 29,gi@l(29)
	la 3,.LC45@l(3)
	lwz 9,36(29)
	li 27,1
	lis 22,maxclients@ha
	mtlr 9
	blrl
	lis 9,.LC55@ha
	lwz 0,16(29)
	lis 10,.LC56@ha
	la 9,.LC55@l(9)
	la 10,.LC56@l(10)
	lfs 1,0(9)
	mr 5,3
	li 4,26
	mtlr 0
	lis 9,.LC56@ha
	lfs 2,0(10)
	mr 3,30
	la 9,.LC56@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC55@ha
	lwz 10,84(31)
	lis 11,maxclients@ha
	la 9,.LC55@l(9)
	lwz 8,maxclients@l(11)
	lfs 13,0(9)
	lwz 9,3464(10)
	addi 9,9,15
	stw 9,3464(10)
	lfs 0,20(8)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L240
	lis 23,g_edicts@ha
	lis 26,0x4330
	li 30,1352
.L242:
	lwz 0,g_edicts@l(23)
	add 29,0,30
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L241
	lwz 0,968(29)
	cmpwi 0,0,0
	bc 12,2,.L244
	lwz 0,324(29)
	cmpw 0,0,31
	bc 4,2,.L244
	li 0,0
	stw 0,324(29)
.L244:
	lwz 10,84(29)
	lwz 9,84(31)
	lwz 11,3468(10)
	lwz 0,3468(9)
	cmpw 0,11,0
	bc 12,2,.L286
	lis 0,0xc0a0
	stw 0,3476(10)
	b .L241
.L286:
	cmpw 0,29,31
	bc 12,2,.L248
	lwz 9,3464(10)
	la 11,level@l(24)
	lis 6,.LC46@ha
	la 6,.LC46@l(6)
	la 3,gi@l(25)
	addi 9,9,10
	li 5,0
	stw 9,3464(10)
	li 7,0
	li 8,10
	lwz 4,84(29)
	lfs 1,4(11)
	lwz 9,184(4)
	addi 4,4,700
	bl sl_LogScore
.L248:
	lwz 5,84(29)
	lis 9,.LC57@ha
	la 28,level@l(24)
	la 9,.LC57@l(9)
	lfs 13,4(28)
	lfs 31,0(9)
	lfs 0,3480(5)
	fadds 0,0,31
	fcmpu 0,0,13
	bc 4,1,.L249
	lis 4,.LC47@ha
	addi 5,5,700
	la 4,.LC47@l(4)
	li 3,2
	crxor 6,6,6
	bl my_bprintf
	lwz 11,84(29)
	lis 6,.LC48@ha
	la 3,gi@l(25)
	la 6,.LC48@l(6)
	li 5,0
	lwz 9,3464(11)
	li 7,0
	li 8,1
	addi 9,9,1
	stw 9,3464(11)
	lwz 4,84(29)
	lfs 1,4(28)
	lwz 9,184(4)
	addi 4,4,700
	bl sl_LogScore
.L249:
	lwz 5,84(29)
	lfs 13,4(28)
	lfs 0,3488(5)
	fadds 0,0,31
	fcmpu 0,0,13
	bc 4,1,.L241
	lis 4,.LC49@ha
	addi 5,5,700
	la 4,.LC49@l(4)
	li 3,2
	crxor 6,6,6
	bl my_bprintf
	lwz 11,84(29)
	lwz 9,3464(11)
	addi 9,9,2
	stw 9,3464(11)
.L241:
	addi 27,27,1
	lwz 11,maxclients@l(22)
	xoris 0,27,0x8000
	lis 10,.LC58@ha
	stw 0,20(1)
	la 10,.LC58@l(10)
	addi 30,30,1352
	stw 26,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L242
.L240:
	bl CTFResetFlags
	b .L289
.L230:
	addi 5,5,700
	bc 12,18,.L252
	cmpwi 0,26,2
	bc 12,2,.L253
	b .L256
.L252:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L255
.L253:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L255
.L256:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L255:
	lis 4,.LC50@ha
	li 3,2
	la 4,.LC50@l(4)
	lis 28,gi@ha
	crxor 6,6,6
	bl my_bprintf
	la 27,gi@l(28)
	lis 29,level@ha
	lwz 11,84(31)
	lis 6,.LC51@ha
	la 29,level@l(29)
	li 5,0
	lfs 1,4(29)
	addi 4,11,700
	mr 3,27
	lwz 9,184(11)
	la 6,.LC51@l(6)
	li 7,0
	li 8,1
	bl sl_LogScore
	lwz 10,84(31)
	lis 3,.LC52@ha
	la 3,.LC52@l(3)
	lwz 9,3464(10)
	addi 9,9,1
	stw 9,3464(10)
	lfs 0,4(29)
	lwz 11,84(31)
	stfs 0,3480(11)
	lwz 9,36(27)
	mtlr 9
	blrl
	lis 9,.LC55@ha
	lwz 0,16(27)
	lis 10,.LC56@ha
	la 9,.LC55@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC56@l(10)
	li 4,26
	mtlr 0
	lis 9,.LC56@ha
	mr 3,30
	lfs 2,0(10)
	la 9,.LC56@l(9)
	lfs 3,0(9)
	blrl
	bc 12,18,.L257
	cmpwi 0,26,2
	bc 12,2,.L258
	b .L289
.L257:
	lis 9,.LC11@ha
	la 30,.LC11@l(9)
	b .L260
.L258:
	lis 9,.LC12@ha
	la 30,.LC12@l(9)
.L260:
	lis 9,gi@ha
	li 29,0
	la 28,gi@l(9)
	li 31,1
	b .L262
.L264:
	lwz 0,284(29)
	andis. 9,0,1
	bc 12,2,.L265
	mr 3,29
	bl RemoveFromItemList
	mr 3,29
	bl G_FreeEdict
	b .L262
.L265:
	lwz 0,184(29)
	mr 3,29
	stw 31,248(29)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	lwz 9,72(28)
	mtlr 9
	blrl
	stw 31,80(29)
.L262:
	mr 3,29
	li 4,280
	mr 5,30
	bl G_Find
	mr. 29,3
	bc 4,2,.L264
	b .L289
.L229:
	addi 5,5,700
	bc 12,18,.L268
	cmpwi 0,26,2
	bc 12,2,.L269
	b .L272
.L268:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L271
.L269:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L271
.L272:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L271:
	lis 4,.LC53@ha
	li 3,2
	la 4,.LC53@l(4)
	crxor 6,6,6
	bl my_bprintf
	lwz 9,84(31)
	lis 29,level@ha
	lis 3,gi@ha
	la 29,level@l(29)
	lis 6,.LC54@ha
	mr 4,9
	lfs 1,4(29)
	la 3,gi@l(3)
	lwz 9,184(4)
	la 6,.LC54@l(6)
	li 5,0
	li 7,0
	li 8,0
	addi 4,4,700
	bl sl_LogScore
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,27
	addi 11,11,740
	mullw 9,9,0
	li 10,1
	rlwinm 9,9,0,0,29
	stwx 10,11,9
	lfs 0,4(29)
	lwz 9,84(31)
	stfs 0,3484(9)
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L273
	lwz 9,84(31)
	lwz 0,3468(9)
	cmpwi 0,0,1
	bc 4,2,.L274
	lis 9,flag1_ent@ha
	lwz 0,flag1_ent@l(9)
	b .L288
.L274:
	lis 9,flag2_ent@ha
	lwz 0,flag2_ent@l(9)
.L288:
	stw 0,416(31)
	li 0,3
	stw 0,1032(31)
.L273:
	lwz 0,284(30)
	andis. 11,0,0x1
	bc 4,2,.L276
	lwz 0,264(30)
	lwz 9,184(30)
	oris 0,0,0x8000
	stw 11,248(30)
	ori 9,9,1
	stw 0,264(30)
	stw 9,184(30)
.L276:
	lis 9,num_players@ha
	li 27,0
	lwz 0,num_players@l(9)
	lis 25,num_players@ha
	cmpw 0,27,0
	bc 4,0,.L278
	lis 9,players@ha
	li 26,0
	la 28,players@l(9)
	li 29,0
	lis 9,.LC59@ha
	la 9,.LC59@l(9)
	lfs 31,0(9)
.L280:
	lwzx 8,29,28
	lwz 9,84(31)
	lwz 11,84(8)
	lwz 10,3468(9)
	lwz 0,3468(11)
	cmpw 0,0,10
	bc 4,2,.L279
	lwz 0,324(8)
	cmpw 0,0,30
	bc 4,2,.L282
	stw 26,324(8)
.L282:
	lwzx 3,29,28
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 12,2,.L279
	cmpw 0,3,31
	bc 12,2,.L279
	lwz 0,324(3)
	cmpwi 0,0,0
	bc 4,2,.L279
	mr 4,31
	bl entdist
	fcmpu 0,1,31
	bc 4,0,.L279
	lwzx 9,29,28
	stw 31,324(9)
.L279:
	lwz 0,num_players@l(25)
	addi 27,27,1
	addi 29,29,4
	cmpw 0,27,0
	bc 12,0,.L280
.L278:
	li 3,1
.L285:
	lwz 0,84(1)
	lwz 12,28(1)
	mtlr 0
	lmw 22,32(1)
	lfd 31,72(1)
	mtcrf 8,12
	la 1,80(1)
	blr
.Lfe8:
	.size	 CTFPickup_Flag,.Lfe8-CTFPickup_Flag
	.section	".rodata"
	.align 2
.LC60:
	.string	"The %s flag has returned!\n"
	.align 2
.LC61:
	.long 0x44bb8000
	.align 3
.LC62:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC63:
	.long 0x41f00000
	.section	".text"
	.align 2
	.type	 CTFDropFlagThink,@function
CTFDropFlagThink:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 26,16(1)
	stw 0,52(1)
	lis 11,.LC63@ha
	lis 9,level+4@ha
	la 11,.LC63@l(11)
	lfs 0,level+4@l(9)
	mr 29,3
	lfs 12,0(11)
	lfs 13,288(29)
	fsubs 0,0,12
	fcmpu 0,13,0
	bc 4,0,.L293
	lwz 3,280(29)
	lis 31,.LC11@ha
	la 4,.LC11@l(31)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L294
	la 30,.LC11@l(31)
	li 31,0
	b .L300
.L302:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L303
	mr 3,31
	bl RemoveFromItemList
	mr 3,31
	bl G_FreeEdict
	b .L300
.L303:
	lwz 0,184(31)
	li 29,1
	lis 9,gi+72@ha
	stw 29,248(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	stw 29,80(31)
.L300:
	mr 3,31
	li 4,280
	mr 5,30
	bl G_Find
	mr. 31,3
	bc 4,2,.L302
	lis 5,.LC13@ha
	lis 4,.LC60@ha
	la 4,.LC60@l(4)
	la 5,.LC13@l(5)
	b .L336
.L294:
	lwz 3,280(29)
	lis 31,.LC12@ha
	la 4,.LC12@l(31)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L329
	la 30,.LC12@l(31)
	li 31,0
	b .L318
.L320:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L321
	mr 3,31
	bl RemoveFromItemList
	mr 3,31
	bl G_FreeEdict
	b .L318
.L321:
	lwz 0,184(31)
	li 29,1
	lis 9,gi+72@ha
	stw 29,248(31)
	mr 3,31
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	stw 29,80(31)
.L318:
	mr 3,31
	li 4,280
	mr 5,30
	bl G_Find
	mr. 31,3
	bc 4,2,.L320
	lis 5,.LC14@ha
	lis 4,.LC60@ha
	la 4,.LC60@l(4)
	la 5,.LC14@l(5)
.L336:
	li 3,2
	crxor 6,6,6
	bl my_bprintf
	b .L329
.L293:
	lis 9,num_players@ha
	li 30,0
	lwz 0,num_players@l(9)
	lis 26,num_players@ha
	cmpw 0,30,0
	bc 4,0,.L331
	lis 9,.LC61@ha
	lis 11,players@ha
	lfs 31,.LC61@l(9)
	la 28,players@l(11)
	li 31,0
	lis 9,gi@ha
	la 27,gi@l(9)
.L333:
	lwzx 4,31,28
	mr 3,29
	bl entdist
	fcmpu 0,1,31
	bc 4,1,.L334
	lwzx 4,31,28
	addi 3,29,4
	lwz 9,56(27)
	addi 4,4,4
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,2,.L332
.L334:
	lwzx 9,31,28
	stw 29,416(9)
.L332:
	lwz 0,num_players@l(26)
	addi 30,30,1
	addi 31,31,4
	cmpw 0,30,0
	bc 12,0,.L333
.L331:
	lis 9,level+4@ha
	lis 11,.LC62@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC62@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
.L329:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 CTFDropFlagThink,.Lfe9-CTFDropFlagThink
	.section	".rodata"
	.align 2
.LC64:
	.string	"%s lost the %s flag!\n"
	.align 3
.LC65:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC66:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFDeadDropFlag
	.type	 CTFDeadDropFlag,@function
CTFDeadDropFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 11,.LC66@ha
	lis 9,ctf@ha
	la 11,.LC66@l(11)
	mr 30,3
	lfs 13,0(11)
	li 29,0
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L337
	lis 9,flag1_item@ha
	lwz 0,flag1_item@l(9)
	cmpwi 0,0,0
	bc 12,2,.L340
	lis 9,flag2_item@ha
	lwz 0,flag2_item@l(9)
	cmpwi 0,0,0
	bc 4,2,.L339
.L340:
	bl CTFInit
.L339:
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 10,84(30)
	lwz 4,flag1_item@l(9)
	la 28,itemlist@l(11)
	lis 31,0x286b
	ori 31,31,51739
	addi 10,10,740
	subf 0,28,4
	mullw 0,0,31
	rlwinm 0,0,0,0,29
	lwzx 26,10,0
	cmpwi 0,26,0
	bc 12,2,.L341
	mr 3,30
	bl Drop_Item
	lis 9,flag1_item@ha
	li 11,0
	lwz 0,flag1_item@l(9)
	mr 29,3
	lis 6,.LC13@ha
	lwz 9,84(30)
	lis 4,.LC64@ha
	la 6,.LC13@l(6)
	subf 0,28,0
	la 4,.LC64@l(4)
	mullw 0,0,31
	addi 9,9,740
	li 3,2
	rlwinm 0,0,0,0,29
	stwx 11,9,0
	lwz 5,84(30)
	addi 5,5,700
	crxor 6,6,6
	bl my_bprintf
	b .L347
.L341:
	lis 27,flag2_item@ha
	lwz 4,flag2_item@l(27)
	subf 0,28,4
	mullw 0,0,31
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L347
	mr 3,30
	bl Drop_Item
	lwz 0,flag2_item@l(27)
	mr 29,3
	lis 6,.LC14@ha
	lwz 9,84(30)
	lis 4,.LC64@ha
	la 6,.LC14@l(6)
	subf 0,28,0
	la 4,.LC64@l(4)
	mullw 0,0,31
	addi 9,9,740
	li 3,2
	rlwinm 0,0,0,0,29
	stwx 26,9,0
	lwz 5,84(30)
	addi 5,5,700
	crxor 6,6,6
	bl my_bprintf
.L347:
	cmpwi 0,29,0
	bc 12,2,.L337
	lis 9,CTFDropFlagThink@ha
	lis 11,level@ha
	la 9,CTFDropFlagThink@l(9)
	la 11,level@l(11)
	stw 9,436(29)
	lis 10,.LC65@ha
	mr 3,29
	lfs 12,4(11)
	lis 9,CTFDropFlagTouch@ha
	lfd 13,.LC65@l(10)
	la 9,CTFDropFlagTouch@l(9)
	stfs 12,288(29)
	lfs 0,4(11)
	stw 9,444(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	bl CalcItemPaths
.L337:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 CTFDeadDropFlag,.Lfe10-CTFDeadDropFlag
	.section	".rodata"
	.align 2
.LC67:
	.string	"Only lusers drop flags.\n"
	.align 2
.LC68:
	.string	"Winners don't drop flags.\n"
	.align 2
.LC73:
	.string	"Sending %s to defend flag\n"
	.align 2
.LC74:
	.string	"Releasing %s from flag defense.\n"
	.align 2
.LC76:
	.string	"%s: base under attack!\n"
	.align 2
.LC78:
	.string	"%s: base secured!\n"
	.align 2
.LC79:
	.string	"Sending %s to ATTACK flag\n"
	.align 2
.LC80:
	.string	"Releasing %s from attacking flag\n"
	.align 3
.LC69:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC70:
	.long 0x46fffe00
	.align 3
.LC71:
	.long 0x408c2000
	.long 0x0
	.align 2
.LC72:
	.long 0x497423f0
	.align 3
.LC75:
	.long 0x4082c000
	.long 0x0
	.align 2
.LC77:
	.long 0x44bb8000
	.align 2
.LC81:
	.long 0x0
	.align 2
.LC82:
	.long 0x3f800000
	.align 3
.LC83:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC84:
	.long 0x3fd00000
	.long 0x0
	.align 3
.LC85:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC86:
	.long 0x40800000
	.align 2
.LC87:
	.long 0x40e00000
	.align 2
.LC88:
	.long 0x44960000
	.align 2
.LC89:
	.long 0x44fa0000
	.section	".text"
	.align 2
	.globl CTFFlagThink
	.type	 CTFFlagThink,@function
CTFFlagThink:
	stwu 1,-128(1)
	mflr 0
	mfcr 12
	stfd 29,104(1)
	stfd 30,112(1)
	stfd 31,120(1)
	stmw 16,40(1)
	stw 0,132(1)
	stw 12,36(1)
	mr 28,3
	li 27,1
	lwz 0,248(28)
	li 23,1
	cmpwi 0,0,0
	bc 12,2,.L359
	lwz 9,56(28)
	addi 9,9,-172
	srawi 0,9,31
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	addi 9,9,173
	stw 9,56(28)
.L359:
	lis 7,.LC81@ha
	lis 29,team1_rushbase_time@ha
	la 7,.LC81@l(7)
	lfs 0,team1_rushbase_time@l(29)
	lfs 31,0(7)
	fcmpu 0,0,31
	bc 4,1,.L360
	lis 9,.LC69@ha
	lfd 13,.LC69@l(9)
	fsub 0,0,13
	frsp 0,0
	stfs 0,team1_rushbase_time@l(29)
.L360:
	lis 30,team2_rushbase_time@ha
	lfs 0,team2_rushbase_time@l(30)
	fcmpu 0,0,31
	bc 4,1,.L361
	lis 9,.LC69@ha
	lfd 13,.LC69@l(9)
	fsub 0,0,13
	frsp 0,0
	stfs 0,team2_rushbase_time@l(30)
.L361:
	lis 9,team1_defendbase_time@ha
	lfs 0,team1_defendbase_time@l(9)
	fcmpu 0,0,31
	bc 4,1,.L362
	lis 9,.LC69@ha
	lfd 13,.LC69@l(9)
	lis 9,team1_defendbase_time@ha
	fsub 0,0,13
	frsp 0,0
	stfs 0,team1_defendbase_time@l(9)
.L362:
	lis 9,team2_defendbase_time@ha
	lfs 0,team2_defendbase_time@l(9)
	fcmpu 0,0,31
	bc 4,1,.L363
	lis 9,.LC69@ha
	lfd 13,.LC69@l(9)
	lis 9,team2_defendbase_time@ha
	fsub 0,0,13
	frsp 0,0
	stfs 0,team2_defendbase_time@l(9)
.L363:
	lis 9,level@ha
	lis 10,.LC82@ha
	lfs 12,1096(28)
	la 10,.LC82@l(10)
	la 31,level@l(9)
	lfs 13,0(10)
	lfs 0,4(31)
	fsubs 0,0,13
	fcmpu 0,12,0
	bc 4,0,.L400
	bl rand
	li 25,0
	rlwinm 0,3,0,17,31
	lfs 11,4(31)
	xoris 0,0,0x8000
	lis 11,0x4330
	lwz 3,280(28)
	stw 0,28(1)
	lis 7,.LC83@ha
	lis 10,.LC70@ha
	la 7,.LC83@l(7)
	stw 11,24(1)
	lis 4,.LC11@ha
	lfd 12,0(7)
	la 4,.LC11@l(4)
	lfd 0,24(1)
	lfs 13,.LC70@l(10)
	fsub 0,0,12
	frsp 0,0
	fdivs 0,0,13
	fadds 11,11,0
	stfs 11,1096(28)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L365
	lfs 0,team1_rushbase_time@l(29)
	lis 9,flag2_ent@ha
	li 24,1
	lwz 30,flag2_ent@l(9)
	li 17,2
	fcmpu 0,0,31
	bc 4,1,.L366
	lwz 0,248(30)
	cmpwi 0,0,1
	bc 4,2,.L367
	lis 9,num_players@ha
	li 29,0
	lwz 0,num_players@l(9)
	lis 16,num_players@ha
	cmpw 0,29,0
	bc 4,0,.L367
	lis 9,players@ha
	li 26,99
	la 27,players@l(9)
.L371:
	lwz 31,0(27)
	addi 27,27,4
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L370
	lwz 9,84(31)
	lwz 0,3468(9)
	cmpwi 0,0,1
	bc 4,2,.L370
	mr 3,31
	bl CarryingFlag
	mr. 3,3
	bc 4,2,.L370
	stw 3,324(31)
	stw 26,1032(31)
	stw 30,416(31)
.L370:
	lwz 0,num_players@l(16)
	addi 29,29,1
	cmpw 0,29,0
	bc 12,0,.L371
.L367:
	li 27,0
.L366:
	lis 7,.LC81@ha
	lis 9,team2_defendbase_time@ha
	la 7,.LC81@l(7)
	lfs 0,team2_defendbase_time@l(9)
	cmpwi 4,27,0
	lfs 13,0(7)
	fcmpu 0,0,13
	bc 4,1,.L382
	lwz 0,248(30)
	cmpwi 0,0,1
	bc 4,2,.L392
	lis 9,num_players@ha
	li 29,0
	lwz 0,num_players@l(9)
	lis 16,num_players@ha
	cmpw 0,29,0
	bc 4,0,.L392
	lis 9,players@ha
	li 26,99
	la 27,players@l(9)
.L379:
	lwz 31,0(27)
	addi 27,27,4
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L378
	lwz 9,84(31)
	lwz 0,3468(9)
	cmpwi 0,0,2
	bc 4,2,.L378
	mr 3,31
	bl CarryingFlag
	cmpwi 0,3,0
	bc 4,2,.L378
	stw 26,1032(31)
	stw 30,324(31)
	stw 30,416(31)
.L378:
	lwz 0,num_players@l(16)
	addi 29,29,1
	cmpw 0,29,0
	bc 12,0,.L379
	b .L392
.L365:
	lfs 0,team2_rushbase_time@l(30)
	lis 9,flag1_ent@ha
	li 24,2
	lwz 30,flag1_ent@l(9)
	li 17,1
	fcmpu 0,0,31
	bc 4,1,.L383
	lwz 0,248(30)
	cmpwi 0,0,1
	bc 4,2,.L384
	lis 9,num_players@ha
	li 29,0
	lwz 0,num_players@l(9)
	lis 16,num_players@ha
	cmpw 0,29,0
	bc 4,0,.L384
	lis 9,players@ha
	li 26,99
	la 27,players@l(9)
.L388:
	lwz 31,0(27)
	addi 27,27,4
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L387
	lwz 9,84(31)
	lwz 0,3468(9)
	cmpwi 0,0,2
	bc 4,2,.L387
	mr 3,31
	bl CarryingFlag
	mr. 3,3
	bc 4,2,.L387
	stw 3,324(31)
	stw 26,1032(31)
	stw 30,416(31)
.L387:
	lwz 0,num_players@l(16)
	addi 29,29,1
	cmpw 0,29,0
	bc 12,0,.L388
.L384:
	li 27,0
.L383:
	lis 7,.LC81@ha
	lis 9,team1_defendbase_time@ha
	la 7,.LC81@l(7)
	lfs 0,team1_defendbase_time@l(9)
	cmpwi 4,27,0
	lfs 13,0(7)
	fcmpu 0,0,13
	bc 4,1,.L382
	lwz 0,248(30)
	cmpwi 0,0,1
	bc 4,2,.L392
	lis 9,num_players@ha
	li 29,0
	lwz 0,num_players@l(9)
	lis 16,num_players@ha
	cmpw 0,29,0
	bc 4,0,.L392
	lis 9,players@ha
	li 26,99
	la 27,players@l(9)
.L396:
	lwz 31,0(27)
	addi 27,27,4
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L395
	lwz 9,84(31)
	lwz 0,3468(9)
	cmpwi 0,0,1
	bc 4,2,.L395
	mr 3,31
	bl CarryingFlag
	cmpwi 0,3,0
	bc 4,2,.L395
	stw 26,1032(31)
	stw 30,324(31)
	stw 30,416(31)
.L395:
	lwz 0,num_players@l(16)
	addi 29,29,1
	cmpw 0,29,0
	bc 12,0,.L396
.L392:
	li 23,0
.L382:
	cmpwi 0,23,0
	mfcr 9
	rlwinm 9,9,19,1
	mcrf 3,0
	mfcr 0
	rlwinm 0,0,3,1
	and. 7,9,0
	bc 4,2,.L400
	lis 9,num_players@ha
	li 29,0
	lwz 0,num_players@l(9)
	li 22,0
	li 27,0
	li 23,0
	lis 16,num_players@ha
	cmpw 0,29,0
	bc 4,0,.L402
	lis 9,.LC71@ha
	lis 11,players@ha
	lfd 31,.LC71@l(9)
	la 26,players@l(11)
	li 30,0
.L404:
	lwzx 31,30,26
	lwz 9,84(31)
	lwz 11,3468(9)
	cmpw 0,11,24
	bc 4,2,.L405
	mr 3,31
	mr 4,28
	bl entdist
	addi 27,27,1
	lwz 0,324(31)
	cmpw 0,0,28
	bc 12,2,.L407
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L403
.L407:
	fmr 0,1
	fcmpu 0,0,31
	bc 4,0,.L403
	lwzx 23,30,26
	addi 25,25,1
	b .L403
.L405:
	xor 11,11,17
	addi 9,22,1
	srawi 7,11,31
	xor 0,7,11
	subf 0,0,7
	srawi 0,0,31
	andc 9,9,0
	and 0,22,0
	or 22,0,9
.L403:
	lwz 0,num_players@l(16)
	addi 29,29,1
	addi 30,30,4
	cmpw 0,29,0
	bc 12,0,.L404
.L402:
	lwz 0,248(28)
	cmpwi 0,0,1
	bc 12,2,.L412
	xoris 0,27,0x8000
	stw 0,28(1)
	lis 11,0x4330
	lis 10,.LC83@ha
	stw 11,24(1)
	la 10,.LC83@l(10)
	lfd 0,24(1)
	lis 11,.LC84@ha
	lfd 13,0(10)
	la 11,.LC84@l(11)
	lfd 12,0(11)
	b .L489
.L412:
	xoris 0,27,0x8000
	stw 0,28(1)
	lis 11,0x4330
	lis 7,.LC83@ha
	stw 11,24(1)
	la 7,.LC83@l(7)
	lis 10,.LC85@ha
	lfd 0,24(1)
	la 10,.LC85@l(10)
	lfd 13,0(7)
	lfd 12,0(10)
.L489:
	fsub 0,0,13
	frsp 0,0
	fmr 1,0
	fmul 1,1,12
	bl ceil
	fctiwz 0,1
	stfd 0,24(1)
	lwz 10,28(1)
	cmpwi 0,23,0
	mfcr 21
	bc 12,18,.L414
	cmpw 0,25,10
	bc 4,0,.L415
	lis 9,num_players@ha
	li 29,0
	lwz 0,num_players@l(9)
	lis 11,.LC72@ha
	li 27,0
	lfs 31,.LC72@l(11)
	cmpw 0,29,0
	bc 4,0,.L417
	lis 11,players@ha
	lis 9,botBlaster@ha
	la 26,botBlaster@l(9)
	la 30,players@l(11)
.L419:
	lwz 31,0(30)
	addi 30,30,4
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L418
	lwz 9,84(31)
	lwz 0,3468(9)
	cmpw 0,0,24
	bc 4,2,.L418
	lwz 0,324(31)
	cmpw 0,0,28
	bc 12,2,.L418
	lwz 0,980(31)
	cmpw 0,0,26
	bc 12,2,.L418
	mr 3,31
	mr 4,28
	bl entdist
	fcmpu 0,1,31
	bc 4,0,.L418
	fmr 31,1
	mr 27,31
.L418:
	lwz 0,num_players@l(16)
	addi 29,29,1
	cmpw 0,29,0
	bc 12,0,.L419
.L417:
	cmpwi 0,27,0
	bc 12,2,.L414
	li 0,3
	stw 28,324(27)
	stw 0,1032(27)
	stw 28,416(27)
	b .L414
.L415:
	bc 4,1,.L414
	lis 9,num_players@ha
	li 29,0
	lwz 0,num_players@l(9)
	cmpwi 0,0,0
	bc 4,1,.L414
	lis 9,players@ha
	mr 8,0
	la 11,players@l(9)
.L429:
	lwz 31,0(11)
	addi 11,11,4
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L428
	lwz 9,84(31)
	lwz 0,3468(9)
	cmpw 0,0,24
	bc 4,2,.L428
	lwz 0,324(31)
	cmpw 0,0,28
	bc 4,2,.L428
	lwz 0,416(31)
	li 9,0
	stw 9,324(31)
	cmpw 0,0,28
	bc 4,2,.L432
	stw 9,416(31)
.L432:
	addi 25,25,-1
.L428:
	addi 29,29,1
	cmpw 7,25,10
	cmpw 6,29,8
	mfcr 0
	rlwinm 9,0,30,1
	rlwinm 0,0,25,1
	and. 7,0,9
	bc 4,2,.L429
.L414:
	lis 9,num_players@ha
	li 29,0
	lwz 0,num_players@l(9)
	li 25,0
	cmpw 0,29,0
	bc 4,0,.L435
	lis 9,.LC75@ha
	lis 11,players@ha
	lfd 31,.LC75@l(9)
	la 31,players@l(11)
.L437:
	lwz 3,0(31)
	addi 31,31,4
	lwz 9,84(3)
	lwz 0,3468(9)
	cmpw 0,0,17
	bc 4,2,.L436
	lwz 0,416(3)
	cmpw 0,0,28
	bc 12,2,.L439
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 4,2,.L436
.L439:
	mr 4,28
	bl entdist
	addi 0,25,1
	fcmpu 0,1,31
	bc 4,0,.L436
	mr 25,0
.L436:
	lwz 0,num_players@l(16)
	addi 29,29,1
	cmpw 0,29,0
	bc 12,0,.L437
.L435:
	mtcrf 128,21
	bc 12,2,.L441
	lwz 0,248(28)
	cmpwi 0,0,1
	bc 4,2,.L441
	cmpwi 0,25,1
	bc 4,1,.L442
	lis 7,.LC86@ha
	lis 9,level+4@ha
	lfs 12,1120(28)
	la 7,.LC86@l(7)
	lfs 0,level+4@l(9)
	lfs 13,0(7)
	fsubs 0,0,13
	fcmpu 0,12,0
	bc 4,0,.L443
	lis 9,num_players@ha
	li 29,0
	lwz 0,num_players@l(9)
	cmpw 0,29,0
	bc 4,0,.L443
	lis 9,.LC77@ha
	lis 11,players@ha
	lfs 30,.LC77@l(9)
	la 18,players@l(11)
	lis 19,players@ha
	lis 9,.LC81@ha
	li 27,0
	la 9,.LC81@l(9)
	lis 20,bot_chat@ha
	lfs 31,0(9)
	lis 21,.LC76@ha
	li 26,3
.L447:
	lwzx 3,27,18
	mr 30,27
	lwz 9,84(3)
	lwz 0,3468(9)
	cmpw 0,0,24
	bc 4,2,.L446
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 4,2,.L449
	lwz 9,bot_chat@l(20)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L449
	lwz 6,84(23)
	li 4,3
	la 5,.LC76@l(21)
	addi 6,6,700
	crxor 6,6,6
	bl safe_cprintf
	b .L446
.L449:
	bc 12,18,.L446
	la 31,players@l(19)
	lwzx 3,31,27
	lwz 0,324(3)
	cmpw 0,0,28
	bc 12,2,.L446
	bl CarryingFlag
	cmpwi 0,3,0
	bc 4,2,.L446
	lwzx 3,31,30
	mr 4,28
	bl entdist
	fcmpu 0,1,30
	bc 4,0,.L446
	lwzx 9,31,30
	stw 28,324(9)
	lwzx 11,31,30
	stw 28,416(11)
	lwzx 9,31,30
	stw 26,1032(9)
.L446:
	lwz 0,num_players@l(16)
	addi 29,29,1
	addi 27,27,4
	cmpw 0,29,0
	bc 12,0,.L447
.L443:
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	stfs 0,1120(28)
	b .L441
.L442:
	cmpwi 0,25,0
	bc 4,2,.L441
	lis 7,.LC81@ha
	lfs 12,1120(28)
	la 7,.LC81@l(7)
	lfs 11,0(7)
	fcmpu 0,12,11
	bc 12,2,.L441
	lis 10,.LC87@ha
	lis 9,level+4@ha
	la 10,.LC87@l(10)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fsubs 0,0,13
	fcmpu 0,12,0
	bc 4,1,.L441
	lis 9,num_players@ha
	li 29,0
	stfs 11,1120(28)
	lwz 0,num_players@l(9)
	cmpw 0,29,0
	bc 4,0,.L441
	lis 11,.LC81@ha
	lis 9,players@ha
	la 11,.LC81@l(11)
	lis 27,bot_chat@ha
	lfs 31,0(11)
	la 31,players@l(9)
	lis 30,.LC78@ha
.L459:
	lwz 9,bot_chat@l(27)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L458
	lwz 3,0(31)
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 4,2,.L458
	lwz 9,84(3)
	lwz 0,3468(9)
	cmpw 0,0,24
	bc 4,2,.L458
	lwz 6,84(23)
	li 4,3
	la 5,.LC78@l(30)
	addi 6,6,700
	crxor 6,6,6
	bl safe_cprintf
.L458:
	lwz 0,num_players@l(16)
	addi 29,29,1
	addi 31,31,4
	cmpw 0,29,0
	bc 12,0,.L459
.L441:
	bc 12,14,.L400
	xoris 0,22,0x8000
	stw 0,28(1)
	lis 11,0x4330
	lis 7,.LC83@ha
	stw 11,24(1)
	la 7,.LC83@l(7)
	lis 10,.LC84@ha
	lfd 0,24(1)
	la 10,.LC84@l(10)
	lfd 13,0(7)
	lfd 12,0(10)
	fsub 0,0,13
	frsp 0,0
	fmr 1,0
	fmul 1,1,12
	bl ceil
	fctiwz 0,1
	stfd 0,24(1)
	lwz 9,28(1)
	cmpw 0,25,9
	bc 4,0,.L463
	lis 9,num_players@ha
	li 29,0
	lwz 0,num_players@l(9)
	cmpw 0,29,0
	bc 4,0,.L400
	lis 9,.LC77@ha
	lis 7,.LC88@ha
	lfs 29,.LC77@l(9)
	la 7,.LC88@l(7)
	lis 11,players@ha
	lis 9,botBlaster@ha
	lfs 30,0(7)
	la 30,players@l(11)
	la 26,botBlaster@l(9)
	li 31,0
	lis 9,.LC89@ha
	li 27,3
	la 9,.LC89@l(9)
	lfs 31,0(9)
.L467:
	lwzx 3,31,30
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 12,2,.L466
	lwz 9,84(3)
	lwz 0,3468(9)
	cmpw 0,0,17
	bc 4,2,.L466
	lwz 0,416(3)
	cmpw 0,0,28
	bc 12,2,.L466
	mr 4,28
	bl entdist
	fcmpu 0,1,30
	bc 4,1,.L471
	fcmpu 7,1,31
	lwzx 10,31,30
	lwz 0,324(10)
	addic 7,0,-1
	subfe 11,7,0
	mfcr 9
	rlwinm 9,9,30,1
	and. 0,11,9
	bc 4,2,.L466
	fcmpu 0,1,29
	bc 4,1,.L476
	lwz 0,980(10)
	cmpw 0,0,26
	bc 12,2,.L466
	b .L476
.L471:
	lwz 0,248(28)
	cmpwi 0,0,1
	bc 4,2,.L466
.L476:
	lwzx 9,31,30
	stw 28,416(9)
	lwzx 11,31,30
	stw 27,1032(11)
.L466:
	lwz 0,num_players@l(16)
	addi 29,29,1
	addi 31,31,4
	cmpw 0,29,0
	bc 12,0,.L467
	b .L400
.L463:
	lwz 0,248(28)
	cmpwi 0,0,1
	bc 12,2,.L400
	lis 9,num_players@ha
	li 29,0
	lwz 0,num_players@l(9)
	cmpw 0,29,0
	bc 4,0,.L400
	lis 9,players@ha
	mr 6,0
	la 8,players@l(9)
	li 7,0
	li 10,0
.L483:
	lwzx 11,10,8
	lwz 9,84(11)
	lwz 0,3468(9)
	cmpw 0,0,24
	bc 12,2,.L482
	lwz 0,324(11)
	cmpw 0,0,28
	bc 12,2,.L487
	lwz 0,416(11)
	cmpw 0,0,28
	bc 4,2,.L482
.L487:
	stw 7,324(11)
	lwzx 9,10,8
	stw 7,540(9)
	b .L400
.L482:
	addi 29,29,1
	addi 10,10,4
	cmpw 0,29,6
	bc 12,0,.L483
.L400:
	lis 9,level+4@ha
	lis 11,.LC69@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC69@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(28)
	lwz 0,132(1)
	lwz 12,36(1)
	mtlr 0
	lmw 16,40(1)
	lfd 29,104(1)
	lfd 30,112(1)
	lfd 31,120(1)
	mtcrf 24,12
	la 1,128(1)
	blr
.Lfe11:
	.size	 CTFFlagThink,.Lfe11-CTFFlagThink
	.section	".rodata"
	.align 2
.LC90:
	.string	"CTFFlagSetup: %s startsolid at %s\n"
	.align 3
.LC91:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC92:
	.long 0xc1700000
	.align 2
.LC93:
	.long 0x41700000
	.align 2
.LC94:
	.long 0x0
	.align 2
.LC95:
	.long 0xc3000000
	.section	".text"
	.align 2
	.globl CTFFlagSetup
	.type	 CTFFlagSetup,@function
CTFFlagSetup:
	stwu 1,-112(1)
	mflr 0
	stmw 28,96(1)
	stw 0,116(1)
	lis 9,.LC92@ha
	lis 11,.LC92@ha
	la 9,.LC92@l(9)
	la 11,.LC92@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC92@ha
	lfs 2,0(11)
	la 9,.LC92@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC93@ha
	lfs 13,0(11)
	la 9,.LC93@l(9)
	lfs 1,0(9)
	lis 9,.LC93@ha
	stfs 13,188(31)
	la 9,.LC93@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC93@ha
	stfs 0,192(31)
	la 9,.LC93@l(9)
	lfs 13,8(11)
	lfs 3,0(9)
	stfs 13,196(31)
	bl tv
	mr 11,3
	lwz 4,268(31)
	lfs 13,0(11)
	cmpwi 0,4,0
	stfs 13,200(31)
	lfs 0,4(11)
	stfs 0,204(31)
	lfs 13,8(11)
	stfs 13,208(31)
	bc 12,2,.L491
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L492
.L491:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L492:
	lis 9,Touch_Item@ha
	lis 11,.LC94@ha
	la 9,Touch_Item@l(9)
	la 11,.LC94@l(11)
	lfs 1,0(11)
	li 0,7
	li 28,1
	stw 9,444(31)
	lis 11,.LC94@ha
	addi 29,31,4
	lis 9,.LC95@ha
	la 11,.LC94@l(11)
	stw 0,260(31)
	la 9,.LC95@l(9)
	lfs 2,0(11)
	lfs 3,0(9)
	stw 28,248(31)
	bl tv
	mr 11,3
	lfs 11,4(31)
	lis 9,gi@ha
	lfs 0,0(11)
	la 30,gi@l(9)
	addi 3,1,8
	lfs 12,8(31)
	mr 4,29
	addi 5,31,188
	lfs 13,12(31)
	addi 6,31,200
	addi 7,1,72
	fadds 11,11,0
	lwz 10,48(30)
	mr 8,31
	li 9,3
	mtlr 10
	stfs 11,72(1)
	lfs 0,4(11)
	fadds 12,12,0
	stfs 12,76(1)
	lfs 0,8(11)
	fadds 13,13,0
	stfs 13,80(1)
	blrl
	lwz 0,12(1)
	cmpwi 0,0,0
	bc 12,2,.L493
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC90@ha
	la 3,.LC90@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L490
.L493:
	lfs 12,20(1)
	mr 3,31
	lfs 0,24(1)
	lfs 13,28(1)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	lwz 3,280(31)
	lis 4,.LC11@ha
	la 4,.LC11@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L494
	lis 9,flag1_ent@ha
	stw 31,flag1_ent@l(9)
	stw 28,532(31)
	b .L495
.L494:
	lis 9,flag2_ent@ha
	li 0,2
	stw 31,flag2_ent@l(9)
	stw 0,532(31)
.L495:
	mr 3,31
	bl CalcItemPaths
	lis 11,level+4@ha
	lis 10,.LC91@ha
	lfs 0,level+4@l(11)
	lis 9,CTFFlagThink@ha
	lfd 13,.LC91@l(10)
	la 9,CTFFlagThink@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L490:
	lwz 0,116(1)
	mtlr 0
	lmw 28,96(1)
	la 1,112(1)
	blr
.Lfe12:
	.size	 CTFFlagSetup,.Lfe12-CTFFlagSetup
	.section	".rodata"
	.align 2
.LC96:
	.string	"players/male/flag1.md2"
	.align 2
.LC97:
	.string	"players/male/flag2.md2"
	.section	".text"
	.align 2
	.globl CTFEffects
	.type	 CTFEffects,@function
CTFEffects:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,480(31)
	lwz 9,64(31)
	cmpwi 0,0,0
	rlwinm 8,9,0,14,11
	stw 8,64(31)
	bc 4,1,.L497
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 0,flag1_item@l(9)
	la 7,itemlist@l(11)
	lis 10,0x286b
	ori 10,10,51739
	lwz 11,84(31)
	subf 0,7,0
	mullw 0,0,10
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L498
	oris 0,8,0x4
	stw 0,64(31)
.L498:
	lis 9,flag2_item@ha
	lwz 11,84(31)
	lwz 0,flag2_item@l(9)
	addi 11,11,740
	subf 0,7,0
	mullw 0,0,10
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L497
	lwz 0,64(31)
	oris 0,0,0x8
	stw 0,64(31)
.L497:
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 10,84(31)
	lwz 0,flag1_item@l(9)
	la 8,itemlist@l(11)
	lis 11,0x286b
	addi 10,10,740
	ori 11,11,51739
	subf 0,8,0
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L500
	lis 9,gi+32@ha
	lis 3,.LC96@ha
	lwz 0,gi+32@l(9)
	la 3,.LC96@l(3)
	b .L504
.L500:
	lis 9,flag2_item@ha
	lwz 0,flag2_item@l(9)
	subf 0,8,0
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 10,10,0
	cmpwi 0,10,0
	bc 12,2,.L502
	lis 9,gi+32@ha
	lis 3,.LC97@ha
	lwz 0,gi+32@l(9)
	la 3,.LC97@l(3)
.L504:
	mtlr 0
	blrl
	stw 3,48(31)
	b .L501
.L502:
	stw 10,48(31)
.L501:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe13:
	.size	 CTFEffects,.Lfe13-CTFEffects
	.section	".rodata"
	.align 2
.LC98:
	.long 0x0
	.align 3
.LC99:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFCalcScores
	.type	 CTFCalcScores,@function
CTFCalcScores:
	stwu 1,-16(1)
	lis 9,ctfgame@ha
	lis 11,maxclients@ha
	la 8,ctfgame@l(9)
	lwz 7,maxclients@l(11)
	li 0,0
	lis 9,.LC98@ha
	stw 0,8(8)
	li 6,0
	la 9,.LC98@l(9)
	stw 0,12(8)
	lfs 13,0(9)
	lfs 0,20(7)
	fcmpu 0,13,0
	bc 4,0,.L507
	lis 9,g_edicts@ha
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	mr 5,7
	la 11,game@l(11)
	lis 9,.LC99@ha
	lis 4,0x4330
	la 9,.LC99@l(9)
	addi 10,10,1440
	lfd 12,0(9)
	li 7,0
.L509:
	lwz 0,0(10)
	addi 10,10,1352
	cmpwi 0,0,0
	bc 12,2,.L508
	lwz 0,1028(11)
	add 9,7,0
	lwz 0,3468(9)
	cmpwi 0,0,1
	bc 4,2,.L511
	lwz 9,3464(9)
	lwz 0,8(8)
	add 0,0,9
	stw 0,8(8)
	b .L508
.L511:
	cmpwi 0,0,2
	bc 4,2,.L508
	lwz 9,3464(9)
	lwz 0,12(8)
	add 0,0,9
	stw 0,12(8)
.L508:
	addi 6,6,1
	lfs 13,20(5)
	xoris 0,6,0x8000
	addi 7,7,4088
	stw 0,12(1)
	stw 4,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L509
.L507:
	la 1,16(1)
	blr
.Lfe14:
	.size	 CTFCalcScores,.Lfe14-CTFCalcScores
	.section	".rodata"
	.align 2
.LC100:
	.string	"Disabling player identication display.\n"
	.align 2
.LC101:
	.string	"Activating player identication display.\n"
	.align 3
.LC102:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 2
.LC103:
	.long 0x0
	.align 2
.LC104:
	.long 0x44800000
	.align 2
.LC105:
	.long 0x3f800000
	.align 3
.LC106:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFSetIDView
	.type	 CTFSetIDView,@function
CTFSetIDView:
	stwu 1,-176(1)
	mflr 0
	stfd 29,152(1)
	stfd 30,160(1)
	stfd 31,168(1)
	stmw 24,120(1)
	stw 0,180(1)
	mr 30,3
	li 0,0
	lwz 9,84(30)
	lis 11,.LC103@ha
	addi 4,1,8
	la 11,.LC103@l(11)
	li 5,0
	sth 0,174(9)
	li 6,0
	lwz 3,84(30)
	lfs 29,0(11)
	addi 3,3,3700
	bl AngleVectors
	lis 9,.LC104@ha
	addi 3,1,8
	la 9,.LC104@l(9)
	mr 4,3
	lfs 1,0(9)
	bl VectorScale
	lfs 12,4(30)
	lis 11,gi+48@ha
	li 9,3
	lfs 0,8(30)
	addi 3,1,40
	addi 4,30,4
	lfs 13,12(30)
	li 5,0
	li 6,0
	lfs 9,8(1)
	addi 7,1,8
	mr 8,30
	lfs 10,12(1)
	lfs 11,16(1)
	lwz 0,gi+48@l(11)
	fadds 12,12,9
	fadds 0,0,10
	fadds 13,13,11
	mtlr 0
	stfs 12,8(1)
	stfs 0,12(1)
	stfs 13,16(1)
	blrl
	lis 9,.LC105@ha
	lfs 13,48(1)
	la 9,.LC105@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L519
	lwz 9,92(1)
	cmpwi 0,9,0
	bc 12,2,.L519
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L519
	lis 11,g_edicts@ha
	lis 0,0xfb74
	lwz 10,84(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,41881
	subf 9,9,30
	b .L529
.L519:
	lwz 3,84(30)
	addi 4,1,8
	li 5,0
	li 6,0
	li 27,0
	addi 3,3,3700
	li 28,1
	bl AngleVectors
	lis 24,maxclients@ha
	lis 9,.LC105@ha
	lis 11,maxclients@ha
	la 9,.LC105@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L521
	lis 11,.LC106@ha
	lis 25,g_edicts@ha
	la 11,.LC106@l(11)
	lis 26,0x4330
	lfd 30,0(11)
	li 29,1352
.L523:
	lwz 0,g_edicts@l(25)
	add 31,0,29
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L522
	mr 3,31
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 4,2,.L522
	lfs 0,4(30)
	addi 3,1,24
	lfs 13,4(31)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,24(1)
	lfs 0,8(31)
	fsubs 0,0,12
	stfs 0,28(1)
	lfs 13,12(31)
	fsubs 13,13,11
	stfs 13,32(1)
	bl VectorNormalize
	lfs 0,28(1)
	lfs 12,12(1)
	lfs 13,8(1)
	lfs 11,24(1)
	fmuls 12,12,0
	lfs 10,16(1)
	lfs 0,32(1)
	fmadds 13,13,11,12
	fmadds 31,10,0,13
	fcmpu 0,31,29
	bc 4,1,.L522
	mr 3,30
	mr 4,31
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L522
	fmr 29,31
	mr 27,31
.L522:
	addi 28,28,1
	lwz 11,maxclients@l(24)
	xoris 0,28,0x8000
	addi 29,29,1352
	stw 0,116(1)
	stw 26,112(1)
	lfd 0,112(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L523
.L521:
	lis 9,.LC102@ha
	fmr 13,29
	lfd 0,.LC102@l(9)
	fcmpu 0,13,0
	bc 4,1,.L518
	lis 11,g_edicts@ha
	lis 0,0xfb74
	lwz 10,84(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,41881
	subf 9,9,27
.L529:
	mullw 9,9,0
	srawi 9,9,3
	addi 9,9,1311
	sth 9,174(10)
.L518:
	lwz 0,180(1)
	mtlr 0
	lmw 24,120(1)
	lfd 29,152(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe15:
	.size	 CTFSetIDView,.Lfe15-CTFSetIDView
	.section	".rodata"
	.align 2
.LC107:
	.string	"ctfsb1"
	.align 2
.LC108:
	.string	"ctfsb2"
	.align 2
.LC109:
	.string	"i_ctf1"
	.align 2
.LC110:
	.string	"i_ctf1d"
	.align 2
.LC111:
	.string	"i_ctf1t"
	.align 2
.LC112:
	.string	"i_ctf2"
	.align 2
.LC113:
	.string	"i_ctf2d"
	.align 2
.LC114:
	.string	"i_ctf2t"
	.align 2
.LC115:
	.string	"i_ctfj"
	.align 2
.LC116:
	.long 0x0
	.align 2
.LC117:
	.long 0x3f800000
	.align 3
.LC118:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC119:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl SetCTFStats
	.type	 SetCTFStats,@function
SetCTFStats:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 29,gi@ha
	mr 31,3
	la 29,gi@l(29)
	lis 3,.LC107@ha
	lwz 9,40(29)
	la 3,.LC107@l(3)
	lis 27,level@ha
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,.LC108@ha
	sth 3,168(9)
	lwz 0,40(29)
	la 3,.LC108@l(11)
	mtlr 0
	blrl
	lwz 9,84(31)
	lis 10,.LC116@ha
	lis 11,level+200@ha
	la 10,.LC116@l(10)
	sth 3,170(9)
	lfs 13,0(10)
	lfs 0,level+200@l(11)
	lis 10,ctfgame@ha
	fcmpu 0,0,13
	bc 12,2,.L531
	lwz 0,level@l(27)
	andi. 11,0,8
	bc 12,2,.L531
	la 11,ctfgame@l(10)
	lwz 9,ctfgame@l(10)
	lwz 0,4(11)
	cmpw 0,9,0
	bc 12,1,.L582
	cmpw 0,0,9
	bc 12,1,.L583
	lwz 9,12(11)
	lwz 0,8(11)
	cmpw 0,0,9
	bc 4,1,.L536
.L582:
	lwz 9,84(31)
	li 0,0
	sth 0,168(9)
	b .L531
.L536:
	cmpw 0,9,0
	bc 4,1,.L538
.L583:
	lwz 9,84(31)
	li 0,0
	sth 0,170(9)
	b .L531
.L579:
	lis 9,gi+40@ha
	lwz 3,36(3)
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,172(9)
	b .L541
.L538:
	lwz 9,84(31)
	li 0,0
	sth 0,168(9)
	lwz 11,84(31)
	sth 0,170(11)
.L531:
	lwz 10,84(31)
	li 11,0
	lis 9,tnames@ha
	la 3,tnames@l(9)
	sth 11,172(10)
	lwzx 0,3,11
	cmpwi 0,0,0
	bc 12,2,.L541
	lis 9,itemlist@ha
	lis 29,0x286b
	la 28,itemlist@l(9)
	mr 30,3
	ori 29,29,51739
.L542:
	lwz 3,0(30)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L543
	subf 0,28,3
	lwz 11,84(31)
	mullw 0,0,29
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L579
.L543:
	lwzu 0,4(30)
	cmpwi 0,0,0
	bc 4,2,.L542
.L541:
	lis 9,gi@ha
	lis 3,.LC109@ha
	la 30,gi@l(9)
	la 3,.LC109@l(3)
	lwz 9,40(30)
	mtlr 9
	blrl
	mr 28,3
	lis 5,.LC11@ha
	la 5,.LC11@l(5)
	li 3,0
	li 4,280
	bl G_Find
	mr. 3,3
	bc 12,2,.L545
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L546
	lwz 0,40(30)
	lis 3,.LC110@ha
	la 3,.LC110@l(3)
	mtlr 0
	blrl
	lis 9,maxclients@ha
	lis 10,.LC117@ha
	lwz 11,maxclients@l(9)
	la 10,.LC117@l(10)
	mr 28,3
	lfs 0,0(10)
	li 7,1
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L545
	lis 11,flag1_item@ha
	lis 9,itemlist@ha
	fmr 12,13
	lwz 10,flag1_item@l(11)
	la 9,itemlist@l(9)
	lis 0,0x286b
	lis 11,g_edicts@ha
	ori 0,0,51739
	subf 10,9,10
	lwz 8,g_edicts@l(11)
	lis 9,.LC118@ha
	mullw 10,10,0
	lis 11,0x4330
	la 9,.LC118@l(9)
	addi 8,8,1352
	lfd 13,0(9)
	rlwinm 10,10,0,0,29
.L550:
	lwz 0,88(8)
	cmpwi 0,0,0
	bc 12,2,.L549
	lwz 9,84(8)
	addi 9,9,740
	lwzx 0,9,10
	cmpwi 0,0,0
	bc 4,2,.L580
.L549:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,1352
	stw 0,20(1)
	stw 11,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L550
	b .L545
.L580:
	lis 9,gi+40@ha
	lis 3,.LC111@ha
	lwz 0,gi+40@l(9)
	la 3,.LC111@l(3)
	b .L584
.L546:
	lwz 0,284(3)
	andis. 9,0,1
	bc 12,2,.L545
	lwz 0,40(30)
	lis 3,.LC110@ha
	la 3,.LC110@l(3)
.L584:
	mtlr 0
	blrl
	mr 28,3
.L545:
	lis 9,gi@ha
	lis 3,.LC112@ha
	la 30,gi@l(9)
	la 3,.LC112@l(3)
	lwz 9,40(30)
	mtlr 9
	blrl
	mr 29,3
	lis 5,.LC12@ha
	la 5,.LC12@l(5)
	li 3,0
	li 4,280
	bl G_Find
	mr. 3,3
	bc 12,2,.L555
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L556
	lwz 0,40(30)
	lis 3,.LC113@ha
	la 3,.LC113@l(3)
	mtlr 0
	blrl
	lis 9,maxclients@ha
	lis 10,.LC117@ha
	lwz 11,maxclients@l(9)
	la 10,.LC117@l(10)
	mr 29,3
	lfs 0,0(10)
	li 7,1
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L555
	lis 11,flag2_item@ha
	lis 9,itemlist@ha
	fmr 12,13
	lwz 10,flag2_item@l(11)
	la 9,itemlist@l(9)
	lis 0,0x286b
	lis 11,g_edicts@ha
	ori 0,0,51739
	subf 10,9,10
	lwz 8,g_edicts@l(11)
	lis 9,.LC118@ha
	mullw 10,10,0
	lis 11,0x4330
	la 9,.LC118@l(9)
	addi 8,8,1352
	lfd 13,0(9)
	rlwinm 10,10,0,0,29
.L560:
	lwz 0,88(8)
	cmpwi 0,0,0
	bc 12,2,.L559
	lwz 9,84(8)
	addi 9,9,740
	lwzx 0,9,10
	cmpwi 0,0,0
	bc 4,2,.L581
.L559:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,1352
	stw 0,20(1)
	stw 11,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L560
	b .L555
.L581:
	lis 9,gi+40@ha
	lis 3,.LC114@ha
	lwz 0,gi+40@l(9)
	la 3,.LC114@l(3)
	b .L585
.L556:
	lwz 0,284(3)
	andis. 9,0,1
	bc 12,2,.L555
	lwz 0,40(30)
	lis 3,.LC113@ha
	la 3,.LC113@l(3)
.L585:
	mtlr 0
	blrl
	mr 29,3
.L555:
	lis 10,.LC116@ha
	lwz 11,84(31)
	lis 9,ctfgame@ha
	la 10,.LC116@l(10)
	lfs 0,0(10)
	sth 28,154(11)
	la 10,ctfgame@l(9)
	lwz 9,84(31)
	sth 29,158(9)
	lfs 12,16(10)
	fcmpu 0,12,0
	bc 12,2,.L565
	lis 9,level+4@ha
	lis 11,.LC119@ha
	lfs 0,level+4@l(9)
	la 11,.LC119@l(11)
	lfs 13,0(11)
	fsubs 0,0,12
	fcmpu 0,0,13
	bc 4,0,.L565
	lwz 0,20(10)
	cmpwi 0,0,1
	bc 4,2,.L566
	lwz 0,level@l(27)
	andi. 0,0,8
	bc 12,2,.L567
	lwz 9,84(31)
	sth 28,154(9)
	b .L565
.L567:
	lwz 9,84(31)
	sth 0,154(9)
	b .L565
.L566:
	lwz 0,level@l(27)
	andi. 0,0,8
	bc 12,2,.L570
	lwz 9,84(31)
	sth 29,158(9)
	b .L565
.L570:
	lwz 9,84(31)
	sth 0,158(9)
.L565:
	lis 11,ctfgame@ha
	lwz 9,84(31)
	li 8,0
	la 11,ctfgame@l(11)
	lhz 0,2(11)
	sth 0,156(9)
	lhz 10,6(11)
	lwz 9,84(31)
	sth 10,160(9)
	lwz 11,84(31)
	sth 8,162(11)
	lwz 10,84(31)
	lwz 0,3468(10)
	cmpwi 0,0,1
	bc 4,2,.L572
	lis 9,flag2_item@ha
	lis 11,itemlist@ha
	lwz 0,flag2_item@l(9)
	la 11,itemlist@l(11)
	addi 10,10,740
	lis 9,0x286b
	ori 9,9,51739
	subf 0,11,0
	mullw 0,0,9
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L572
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L572
	lis 9,gi+40@ha
	lis 3,.LC112@ha
	lwz 0,gi+40@l(9)
	la 3,.LC112@l(3)
	b .L586
.L572:
	lwz 10,84(31)
	lwz 0,3468(10)
	cmpwi 0,0,2
	bc 4,2,.L573
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 0,flag1_item@l(9)
	la 11,itemlist@l(11)
	addi 10,10,740
	lis 9,0x286b
	ori 9,9,51739
	subf 0,11,0
	mullw 0,0,9
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L573
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L573
	lis 9,gi+40@ha
	lis 3,.LC109@ha
	lwz 0,gi+40@l(9)
	la 3,.LC109@l(3)
.L586:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,162(9)
.L573:
	lwz 11,84(31)
	li 0,0
	sth 0,164(11)
	lwz 9,84(31)
	sth 0,166(9)
	lwz 11,84(31)
	lwz 0,3468(11)
	cmpwi 0,0,1
	bc 4,2,.L575
	lis 9,gi+40@ha
	lis 3,.LC115@ha
	lwz 0,gi+40@l(9)
	la 3,.LC115@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,164(9)
	b .L576
.L575:
	cmpwi 0,0,2
	bc 4,2,.L576
	lis 9,gi+40@ha
	lis 3,.LC115@ha
	lwz 0,gi+40@l(9)
	la 3,.LC115@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,166(9)
.L576:
	lwz 11,84(31)
	li 0,0
	sth 0,174(11)
	lwz 9,84(31)
	lwz 0,3492(9)
	cmpwi 0,0,0
	bc 12,2,.L578
	mr 3,31
	bl CTFSetIDView
.L578:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe16:
	.size	 SetCTFStats,.Lfe16-SetCTFStats
	.section	".rodata"
	.align 2
.LC120:
	.string	"grapple_sound_killer"
	.align 2
.LC121:
	.string	"weapons/grapple/grreset.wav"
	.align 2
.LC122:
	.long 0x3e4ccccd
	.align 2
.LC123:
	.long 0x3f800000
	.align 2
.LC124:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFResetGrapple
	.type	 CTFResetGrapple,@function
CTFResetGrapple:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	mr 31,3
	lwz 3,256(31)
	lwz 9,84(3)
	lwz 0,3944(9)
	cmpwi 0,0,0
	bc 12,2,.L604
	lwz 0,3796(9)
	lis 9,.LC123@ha
	cmpwi 0,0,0
	la 9,.LC123@l(9)
	lfs 31,0(9)
	bc 4,2,.L606
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L605
.L606:
	lis 9,.LC122@ha
	lfs 31,.LC122@l(9)
.L605:
	lwz 29,256(31)
	li 3,0
	lis 28,.LC120@ha
.L608:
	li 4,280
	la 5,.LC120@l(28)
	bl G_Find
	mr. 3,3
	bc 12,2,.L611
	lwz 0,256(3)
	cmpw 0,0,29
	bc 4,2,.L608
	bl G_FreeEdict
.L611:
	lis 29,gi@ha
	lis 3,.LC121@ha
	lwz 28,256(31)
	la 29,gi@l(29)
	la 3,.LC121@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC123@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC123@l(9)
	mr 3,28
	lfs 2,0(9)
	mtlr 0
	li 4,17
	lis 9,.LC124@ha
	la 9,.LC124@l(9)
	lfs 3,0(9)
	blrl
	lwz 11,256(31)
	li 8,0
	lis 10,level+4@ha
	mr 3,31
	lwz 9,84(11)
	stw 8,3944(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 8,3948(9)
	andi. 0,0,191
	stfs 0,3952(9)
	stb 0,16(9)
	bl G_FreeEdict
.L604:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 CTFResetGrapple,.Lfe17-CTFResetGrapple
	.section	".rodata"
	.align 2
.LC126:
	.string	"weapons/grapple/grpull.wav"
	.align 2
.LC127:
	.string	"weapons/grapple/grhit.wav"
	.align 2
.LC125:
	.long 0x3e4ccccd
	.align 2
.LC128:
	.long 0x3f800000
	.align 2
.LC129:
	.long 0x0
	.align 3
.LC130:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFGrappleTouch
	.type	 CTFGrappleTouch,@function
CTFGrappleTouch:
	stwu 1,-64(1)
	mflr 0
	mfcr 12
	stfd 31,56(1)
	stmw 26,32(1)
	stw 0,68(1)
	stw 12,28(1)
	mr 31,3
	mr 29,4
	lwz 9,256(31)
	lis 10,.LC128@ha
	mr 26,5
	la 10,.LC128@l(10)
	cmpw 0,29,9
	lfs 31,0(10)
	bc 12,2,.L612
	lwz 9,84(9)
	lwz 0,3948(9)
	cmpwi 0,0,0
	bc 4,2,.L612
	cmpwi 0,6,0
	bc 12,2,.L615
	lwz 0,16(6)
	andi. 11,0,4
	bc 12,2,.L615
	bl CTFResetGrapple
	b .L612
.L615:
	lis 9,vec3_origin@ha
	addi 4,31,4
	lwz 3,256(31)
	lfs 13,vec3_origin@l(9)
	mr 27,4
	li 5,2
	la 9,vec3_origin@l(9)
	stfs 13,376(31)
	lfs 0,4(9)
	stfs 0,380(31)
	lfs 13,8(9)
	stfs 13,384(31)
	bl PlayerNoise
	lwz 0,512(29)
	cmpwi 0,0,0
	bc 4,2,.L617
	lwz 8,84(29)
	cmpwi 0,8,0
	bc 12,2,.L616
.L617:
	lwz 5,256(31)
	li 0,0
	li 11,66
	lwz 9,516(31)
	mr 3,29
	mr 7,27
	stw 0,8(1)
	mr 8,26
	mr 4,31
	stw 11,12(1)
	addi 6,31,376
	li 10,1
	bl T_Damage
	mr 3,31
	bl CTFResetGrapple
	b .L612
.L616:
	lwz 11,256(31)
	li 0,1
	lis 10,level+4@ha
	lwz 9,84(11)
	stw 0,3948(9)
	stw 29,540(31)
	lwz 11,256(31)
	lfs 0,level+4@l(10)
	lwz 9,84(11)
	stfs 0,3956(9)
	lwz 3,256(31)
	stw 8,248(31)
	lwz 9,84(3)
	lwz 0,3796(9)
	cmpwi 0,0,0
	bc 4,2,.L619
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L618
.L619:
	lis 9,.LC125@ha
	lfs 31,.LC125@l(9)
.L618:
	lis 29,gi@ha
	lis 3,.LC126@ha
	lwz 28,256(31)
	la 29,gi@l(29)
	la 3,.LC126@l(3)
	lwz 9,36(29)
	cmpwi 4,26,0
	lis 30,.LC120@ha
	mtlr 9
	blrl
	lwz 11,16(29)
	lis 9,.LC128@ha
	lis 10,.LC129@ha
	fmr 1,31
	mr 5,3
	la 10,.LC129@l(10)
	la 9,.LC128@l(9)
	lfs 3,0(10)
	mtlr 11
	li 4,17
	lfs 2,0(9)
	mr 3,28
	blrl
	lwz 9,36(29)
	lis 3,.LC127@ha
	la 3,.LC127@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC128@ha
	lis 10,.LC129@ha
	fmr 1,31
	mr 5,3
	la 9,.LC128@l(9)
	la 10,.LC129@l(10)
	mr 3,31
	lfs 2,0(9)
	mtlr 0
	li 4,1
	lfs 3,0(10)
	blrl
	lwz 31,256(31)
	li 3,0
.L621:
	li 4,280
	la 5,.LC120@l(30)
	bl G_Find
	mr. 3,3
	bc 12,2,.L624
	lwz 0,256(3)
	cmpw 0,0,31
	bc 4,2,.L621
	bl G_FreeEdict
.L624:
	bl G_Spawn
	lis 9,KillGrappleSound@ha
	mr 11,3
	la 9,KillGrappleSound@l(9)
	la 0,.LC120@l(30)
	stw 31,256(11)
	stw 0,280(11)
	lis 8,level+4@ha
	lis 10,.LC130@ha
	stw 9,436(11)
	la 10,.LC130@l(10)
	li 3,3
	lfs 0,level+4@l(8)
	lfd 13,0(10)
	lis 10,gi@ha
	la 31,gi@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(11)
	lwz 9,100(31)
	mtlr 9
	blrl
	lwz 9,100(31)
	li 3,9
	mtlr 9
	blrl
	lwz 9,120(31)
	mr 3,27
	mtlr 9
	blrl
	bc 4,18,.L626
	lwz 0,124(31)
	lis 3,vec3_origin@ha
	la 3,vec3_origin@l(3)
	mtlr 0
	blrl
	b .L627
.L626:
	lwz 0,124(31)
	mr 3,26
	mtlr 0
	blrl
.L627:
	lis 9,gi+88@ha
	mr 3,27
	lwz 0,gi+88@l(9)
	li 4,2
	mtlr 0
	blrl
.L612:
	lwz 0,68(1)
	lwz 12,28(1)
	mtlr 0
	lmw 26,32(1)
	lfd 31,56(1)
	mtcrf 8,12
	la 1,64(1)
	blr
.Lfe18:
	.size	 CTFGrappleTouch,.Lfe18-CTFGrappleTouch
	.section	".rodata"
	.align 3
.LC131:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC132:
	.long 0x42800000
	.section	".text"
	.align 2
	.globl CTFGrappleDrawCable
	.type	 CTFGrappleDrawCable,@function
CTFGrappleDrawCable:
	stwu 1,-128(1)
	mflr 0
	stmw 28,112(1)
	stw 0,132(1)
	mr 31,3
	addi 28,1,56
	lwz 9,256(31)
	addi 29,1,72
	mr 4,28
	mr 5,29
	li 6,0
	lwz 3,84(9)
	addi 3,3,3700
	bl AngleVectors
	lis 9,.LC131@ha
	lwz 10,256(31)
	lis 0,0x4180
	la 9,.LC131@l(9)
	stw 0,12(1)
	lfd 13,0(9)
	lis 3,0x4330
	mr 7,29
	stw 0,8(1)
	addi 8,1,24
	addi 4,10,4
	lwz 9,508(10)
	mr 6,28
	addi 5,1,8
	addi 9,9,-8
	xoris 9,9,0x8000
	stw 9,108(1)
	stw 3,104(1)
	lfd 0,104(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,16(1)
	lwz 3,84(10)
	bl P_ProjectSource
	lwz 9,256(31)
	addi 3,1,88
	lfs 9,24(1)
	lfs 0,4(9)
	lfs 13,4(31)
	lfs 11,8(31)
	fsubs 0,9,0
	lfs 12,28(1)
	lfs 8,32(1)
	fsubs 9,9,13
	stfs 0,8(1)
	fsubs 11,12,11
	lfs 10,8(9)
	lfs 0,12(31)
	fsubs 12,12,10
	fsubs 0,8,0
	stfs 12,12(1)
	lfs 13,12(9)
	stfs 0,96(1)
	stfs 9,88(1)
	fsubs 8,8,13
	stfs 11,92(1)
	stfs 8,16(1)
	bl VectorLength
	lis 9,.LC132@ha
	la 9,.LC132@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L628
	lis 29,gi@ha
	lfs 12,4(31)
	li 3,3
	la 29,gi@l(29)
	lfs 13,8(31)
	lwz 9,100(29)
	lfs 0,12(31)
	mtlr 9
	stfs 12,40(1)
	stfs 13,44(1)
	stfs 0,48(1)
	blrl
	lwz 9,100(29)
	li 3,24
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lwz 3,256(31)
	lis 0,0xfb74
	lwz 11,g_edicts@l(9)
	ori 0,0,41881
	lwz 10,104(29)
	subf 3,11,3
	mullw 3,3,0
	mtlr 10
	srawi 3,3,3
	blrl
	lwz 9,120(29)
	lwz 3,256(31)
	mtlr 9
	addi 3,3,4
	blrl
	lwz 9,120(29)
	addi 3,1,40
	mtlr 9
	blrl
	lwz 9,120(29)
	addi 3,1,8
	mtlr 9
	blrl
	lwz 0,88(29)
	addi 3,31,4
	li 4,2
	mtlr 0
	blrl
.L628:
	lwz 0,132(1)
	mtlr 0
	lmw 28,112(1)
	la 1,128(1)
	blr
.Lfe19:
	.size	 CTFGrappleDrawCable,.Lfe19-CTFGrappleDrawCable
	.section	".rodata"
	.align 2
.LC133:
	.string	"weapon_grapple"
	.align 2
.LC135:
	.string	"weapons/grapple/grhang.wav"
	.align 2
.LC134:
	.long 0x3e4ccccd
	.align 2
.LC136:
	.long 0x44228000
	.align 2
.LC137:
	.long 0x3f000000
	.align 3
.LC138:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC139:
	.long 0x42800000
	.align 2
.LC140:
	.long 0x3f800000
	.align 2
.LC141:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFGrapplePull
	.type	 CTFGrapplePull,@function
CTFGrapplePull:
	stwu 1,-112(1)
	mflr 0
	stfd 31,104(1)
	stmw 28,88(1)
	stw 0,116(1)
	mr 31,3
	lwz 9,256(31)
	lwz 0,968(9)
	cmpwi 0,0,0
	bc 4,2,.L631
	lwz 9,84(9)
	lis 4,.LC133@ha
	la 4,.LC133@l(4)
	lwz 11,1788(9)
	lwz 3,0(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L631
	lwz 9,256(31)
	lwz 9,84(9)
	lwz 0,3596(9)
	cmpwi 0,0,0
	bc 4,2,.L631
	lwz 0,3632(9)
	cmpwi 0,0,3
	bc 12,2,.L631
	cmpwi 0,0,1
	bc 4,2,.L641
.L631:
	lwz 3,540(31)
	cmpwi 0,3,0
	bc 12,2,.L633
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 12,2,.L641
	cmpwi 0,0,2
	bc 4,2,.L635
	lis 8,.LC137@ha
	addi 3,3,236
	la 8,.LC137@l(8)
	addi 4,1,32
	lfs 1,0(8)
	bl VectorScale
	lwz 9,540(31)
	lis 11,gi+72@ha
	mr 3,31
	lfs 13,32(1)
	lfs 0,4(9)
	lfs 12,36(1)
	lfs 11,40(1)
	fadds 13,13,0
	stfs 13,32(1)
	lfs 0,8(9)
	fadds 12,12,0
	stfs 12,36(1)
	lfs 0,12(9)
	fadds 11,11,0
	stfs 11,40(1)
	lfs 0,188(9)
	fadds 13,13,0
	stfs 13,4(31)
	lfs 0,192(9)
	fadds 12,12,0
	stfs 12,8(31)
	lfs 0,196(9)
	fadds 11,11,0
	stfs 11,12(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	b .L636
.L635:
	lfs 0,376(3)
	stfs 0,376(31)
	lfs 13,380(3)
	stfs 13,380(31)
	lfs 0,384(3)
	stfs 0,384(31)
.L636:
	lwz 3,540(31)
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L637
	lwz 4,256(31)
	bl CheckTeamDamage
	mr. 29,3
	bc 4,2,.L637
	lwz 3,256(31)
	lwz 9,84(3)
	lwz 0,3796(9)
	cmpwi 0,0,0
	bc 4,2,.L638
	bl K2_IsStealth
.L638:
	lwz 3,540(31)
	mr 4,31
	li 0,66
	lwz 5,256(31)
	lis 8,vec3_origin@ha
	addi 6,4,376
	stw 29,8(1)
	la 8,vec3_origin@l(8)
	addi 7,4,4
	stw 0,12(1)
	li 9,1
	li 10,1
	bl T_Damage
	b .L630
.L637:
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L641
	lwz 0,492(9)
	cmpwi 0,0,0
	bc 12,2,.L633
.L641:
	mr 3,31
	bl CTFResetGrapple
	b .L630
.L633:
	mr 3,31
	bl CTFGrappleDrawCable
	lwz 9,256(31)
	lwz 3,84(9)
	lwz 0,3948(3)
	cmpwi 0,0,0
	bc 4,1,.L630
	addi 3,3,3700
	addi 4,1,48
	li 5,0
	addi 6,1,64
	bl AngleVectors
	lwz 9,256(31)
	lis 10,0x4330
	lfs 10,4(31)
	lis 8,.LC138@ha
	addi 3,1,16
	lfs 0,4(9)
	la 8,.LC138@l(8)
	lfs 11,8(31)
	lfd 8,0(8)
	stfs 0,32(1)
	fsubs 10,10,0
	lfs 13,8(9)
	lfs 9,12(31)
	stfs 13,36(1)
	fsubs 11,11,13
	lfs 12,12(9)
	stfs 12,40(1)
	lwz 0,508(9)
	stfs 10,16(1)
	xoris 0,0,0x8000
	stfs 11,20(1)
	stw 0,84(1)
	stw 10,80(1)
	lfd 0,80(1)
	fsub 0,0,8
	frsp 0,0
	fadds 12,12,0
	fsubs 9,9,12
	stfs 12,40(1)
	stfs 9,24(1)
	bl VectorLength
	lis 8,.LC139@ha
	lwz 3,256(31)
	la 8,.LC139@l(8)
	lfs 0,0(8)
	lwz 11,84(3)
	fcmpu 7,1,0
	lwz 0,3948(11)
	xori 0,0,1
	subfic 10,0,0
	adde 0,10,0
	mfcr 9
	rlwinm 9,9,29,1
	and. 8,0,9
	bc 12,2,.L643
	lwz 0,3796(11)
	lis 9,.LC140@ha
	la 9,.LC140@l(9)
	cmpwi 0,0,0
	lfs 31,0(9)
	bc 4,2,.L645
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L644
.L645:
	lis 9,.LC134@ha
	lfs 31,.LC134@l(9)
.L644:
	lwz 11,256(31)
	lis 29,gi@ha
	lis 3,.LC135@ha
	la 29,gi@l(29)
	la 3,.LC135@l(3)
	lwz 9,84(11)
	lbz 0,16(9)
	ori 0,0,64
	stb 0,16(9)
	lwz 9,36(29)
	lwz 28,256(31)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC140@ha
	lis 9,.LC141@ha
	fmr 1,31
	la 9,.LC141@l(9)
	mr 5,3
	la 8,.LC140@l(8)
	lfs 3,0(9)
	mtlr 0
	li 4,17
	mr 3,28
	lfs 2,0(8)
	blrl
	lwz 11,256(31)
	li 0,2
	lwz 9,84(11)
	stw 0,3948(9)
.L643:
	addi 3,1,16
	bl VectorNormalize
	lis 9,.LC136@ha
	addi 3,1,16
	lfs 1,.LC136@l(9)
	mr 4,3
	bl VectorScale
	lfs 0,16(1)
	lwz 9,256(31)
	stfs 0,376(9)
	lfs 0,20(1)
	lwz 11,256(31)
	stfs 0,380(11)
	lfs 0,24(1)
	lwz 9,256(31)
	stfs 0,384(9)
	lwz 3,256(31)
	bl SV_AddGravity
.L630:
	lwz 0,116(1)
	mtlr 0
	lmw 28,88(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe20:
	.size	 CTFGrapplePull,.Lfe20-CTFGrapplePull
	.section	".rodata"
	.align 3
.LC142:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC143:
	.long 0x3f800000
	.align 2
.LC144:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFGrappleThink
	.type	 CTFGrappleThink,@function
CTFGrappleThink:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	lwz 9,256(30)
	cmpwi 0,9,0
	bc 12,2,.L651
	lwz 31,84(9)
	cmpwi 0,31,0
	bc 12,2,.L651
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L650
	lwz 0,3944(31)
	cmpw 0,0,30
	bc 12,2,.L649
.L650:
	lwz 0,3944(31)
	cmpw 0,0,30
	bc 4,2,.L651
	lbz 0,16(31)
	li 3,0
	lis 28,.LC120@ha
	andi. 0,0,191
	stb 0,16(31)
	lwz 29,256(30)
.L653:
	li 4,280
	la 5,.LC120@l(28)
	bl G_Find
	mr. 3,3
	bc 12,2,.L656
	lwz 0,256(3)
	cmpw 0,0,29
	bc 4,2,.L653
	bl G_FreeEdict
.L656:
	lis 29,gi@ha
	lis 3,.LC121@ha
	lwz 28,256(30)
	la 29,gi@l(29)
	la 3,.LC121@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC143@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC143@l(9)
	li 4,17
	lfs 1,0(9)
	mtlr 0
	mr 3,28
	lis 9,.LC143@ha
	la 9,.LC143@l(9)
	lfs 2,0(9)
	lis 9,.LC144@ha
	la 9,.LC144@l(9)
	lfs 3,0(9)
	blrl
	li 0,0
	lis 9,level+4@ha
	stw 0,3944(31)
	lfs 0,level+4@l(9)
	stw 0,3948(31)
	stfs 0,3952(31)
.L651:
	mr 3,30
	bl G_FreeEdict
	b .L646
.L649:
	lis 9,level+4@ha
	lis 11,.LC142@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC142@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
.L646:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 CTFGrappleThink,.Lfe21-CTFGrappleThink
	.section	".rodata"
	.align 2
.LC145:
	.string	"models/weapons/grapple/hook/tris.md2"
	.align 3
.LC146:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC147:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC148:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC149:
	.long 0xc1200000
	.section	".text"
	.align 2
	.globl CTFFireGrapple
	.type	 CTFFireGrapple,@function
CTFFireGrapple:
	stwu 1,-112(1)
	mflr 0
	stmw 24,80(1)
	stw 0,116(1)
	mr 30,5
	mr 27,3
	mr 29,4
	mr 26,8
	mr 25,6
	mr 28,7
	mr 3,30
	bl VectorNormalize
	bl G_Spawn
	lfs 0,0(29)
	mr 31,3
	mr 3,30
	addi 4,31,16
	addi 24,31,4
	stfs 0,4(31)
	lfs 0,4(29)
	stfs 0,8(31)
	lfs 13,8(29)
	stfs 13,12(31)
	lfs 0,0(29)
	stfs 0,28(31)
	lfs 13,4(29)
	stfs 13,32(31)
	lfs 0,8(29)
	stfs 0,36(31)
	bl vectoangles
	xoris 28,28,0x8000
	stw 28,76(1)
	lis 0,0x4330
	lis 11,.LC147@ha
	stw 0,72(1)
	la 11,.LC147@l(11)
	addi 4,31,376
	lfd 1,72(1)
	mr 3,30
	lfd 0,0(11)
	fsub 1,1,0
	frsp 1,1
	bl VectorScale
	lwz 11,64(31)
	lis 0,0x600
	li 9,0
	ori 0,0,3
	li 10,8
	stw 9,200(31)
	or 11,11,26
	li 8,2
	stw 10,260(31)
	lis 29,gi@ha
	stw 0,252(31)
	lis 3,.LC145@ha
	la 29,gi@l(29)
	stw 8,248(31)
	la 3,.LC145@l(3)
	stw 11,64(31)
	stw 9,196(31)
	stw 9,192(31)
	stw 9,188(31)
	stw 9,208(31)
	stw 9,204(31)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,CTFGrappleTouch@ha
	stw 3,40(31)
	lis 10,level+4@ha
	la 9,CTFGrappleTouch@l(9)
	stw 27,256(31)
	lis 8,.LC146@ha
	stw 9,444(31)
	lis 11,CTFGrappleThink@ha
	li 0,0
	lfs 0,level+4@l(10)
	la 11,CTFGrappleThink@l(11)
	mr 3,31
	lfd 13,.LC146@l(8)
	stw 11,436(31)
	stw 25,516(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 9,84(27)
	stw 31,3944(9)
	lwz 11,84(27)
	stw 0,3948(11)
	lwz 9,72(29)
	mtlr 9
	blrl
	lwz 0,48(29)
	lis 9,0x600
	addi 4,27,4
	ori 9,9,3
	addi 3,1,8
	li 5,0
	li 6,0
	mtlr 0
	mr 7,24
	mr 8,31
	blrl
	lfs 0,16(1)
	lis 9,.LC148@ha
	la 9,.LC148@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L658
	lis 11,.LC149@ha
	mr 3,24
	la 11,.LC149@l(11)
	mr 5,3
	lfs 1,0(11)
	mr 4,30
	bl VectorMA
	lwz 0,444(31)
	mr 3,31
	li 5,0
	lwz 4,60(1)
	li 6,0
	mtlr 0
	blrl
.L658:
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe22:
	.size	 CTFFireGrapple,.Lfe22-CTFFireGrapple
	.section	".rodata"
	.align 2
.LC151:
	.string	"weapons/grapple/grfire.wav"
	.align 2
.LC150:
	.long 0x3e4ccccd
	.align 2
.LC152:
	.long 0x3f800000
	.align 3
.LC153:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC154:
	.long 0x41c00000
	.align 2
.LC155:
	.long 0x41000000
	.align 2
.LC156:
	.long 0xc0000000
	.align 2
.LC157:
	.long 0x40000000
	.align 2
.LC158:
	.long 0x0
	.align 3
.LC159:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFGrappleFire
	.type	 CTFGrappleFire,@function
CTFGrappleFire:
	stwu 1,-128(1)
	mflr 0
	stfd 31,120(1)
	stmw 25,92(1)
	stw 0,132(1)
	mr 31,3
	lis 8,.LC152@ha
	lwz 3,84(31)
	la 8,.LC152@l(8)
	mr 30,4
	mr 27,5
	mr 26,6
	lfs 31,0(8)
	lwz 0,3948(3)
	cmpwi 0,0,0
	bc 12,1,.L659
	addi 29,1,24
	addi 28,1,40
	addi 4,1,8
	addi 3,3,3700
	mr 5,29
	li 6,0
	bl AngleVectors
	mr 25,28
	lwz 9,508(31)
	lis 10,.LC154@ha
	la 10,.LC154@l(10)
	lfs 12,0(30)
	lis 0,0x4330
	lfs 0,0(10)
	addi 9,9,-6
	lis 8,.LC153@ha
	xoris 9,9,0x8000
	la 8,.LC153@l(8)
	lfs 9,8(30)
	stw 9,84(1)
	addi 4,31,4
	mr 7,29
	stw 0,80(1)
	fadds 12,12,0
	addi 5,1,56
	addi 6,1,8
	lfd 10,0(8)
	lfd 0,80(1)
	lis 8,.LC155@ha
	la 8,.LC155@l(8)
	lfs 13,4(30)
	lfs 11,0(8)
	fsub 0,0,10
	lwz 3,84(31)
	mr 8,28
	stfs 12,56(1)
	fadds 13,13,11
	frsp 0,0
	stfs 13,60(1)
	fadds 0,0,9
	stfs 0,64(1)
	bl P_ProjectSource
	lis 8,.LC156@ha
	lwz 4,84(31)
	addi 3,1,8
	la 8,.LC156@l(8)
	lfs 1,0(8)
	addi 4,4,3648
	bl VectorScale
	lwz 11,84(31)
	lis 0,0xbf80
	stw 0,3636(11)
	lwz 9,84(31)
	lwz 0,3796(9)
	cmpwi 0,0,0
	bc 4,2,.L662
	mr 3,31
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L661
.L662:
	lis 9,.LC150@ha
	lfs 31,.LC150@l(9)
.L661:
	lis 29,gi@ha
	lis 3,.LC151@ha
	la 29,gi@l(29)
	la 3,.LC151@l(3)
	lwz 9,36(29)
	lis 30,.LC120@ha
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC157@ha
	lis 9,.LC158@ha
	fmr 1,31
	la 8,.LC157@l(8)
	la 9,.LC158@l(9)
	mr 5,3
	lfs 2,0(8)
	li 4,17
	mtlr 0
	lfs 3,0(9)
	mr 3,31
	blrl
	mr 3,31
	mr 6,27
	mr 8,26
	mr 4,25
	addi 5,1,8
	li 7,650
	bl CTFFireGrapple
	li 3,0
.L664:
	li 4,280
	la 5,.LC120@l(30)
	bl G_Find
	mr. 3,3
	bc 12,2,.L667
	lwz 0,256(3)
	cmpw 0,0,31
	bc 4,2,.L664
	bl G_FreeEdict
.L667:
	bl G_Spawn
	lis 9,KillGrappleSound@ha
	mr 11,3
	la 0,.LC120@l(30)
	la 9,KillGrappleSound@l(9)
	stw 31,256(11)
	stw 0,280(11)
	lis 10,level+4@ha
	lis 8,.LC159@ha
	stw 9,436(11)
	la 8,.LC159@l(8)
	mr 4,25
	lfs 0,level+4@l(10)
	mr 3,31
	li 5,1
	lfd 13,0(8)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(11)
	bl PlayerNoise
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L659
	lfs 0,4(31)
	lfs 12,8(31)
	lfs 13,12(31)
	stfs 0,1016(31)
	stfs 12,1020(31)
	stfs 13,1024(31)
.L659:
	lwz 0,132(1)
	mtlr 0
	lmw 25,92(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe23:
	.size	 CTFGrappleFire,.Lfe23-CTFGrappleFire
	.section	".data"
	.align 2
	.type	 pause_frames.126,@object
pause_frames.126:
	.long 10
	.long 18
	.long 27
	.long 0
	.align 2
	.type	 fire_frames.127,@object
fire_frames.127:
	.long 6
	.long 0
	.section	".text"
	.align 2
	.globl CTFWeapon_Grapple
	.type	 CTFWeapon_Grapple,@function
CTFWeapon_Grapple:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3580(9)
	andi. 11,0,1
	bc 12,2,.L679
	lwz 0,3632(9)
	cmpwi 0,0,3
	bc 4,2,.L672
	lwz 0,3944(9)
	cmpwi 0,0,0
	bc 12,2,.L672
	li 0,9
	stw 0,92(9)
.L672:
	lwz 9,84(31)
	lwz 0,3580(9)
	andi. 9,0,1
	bc 4,2,.L673
.L679:
	lwz 9,84(31)
	lwz 3,3944(9)
	cmpwi 0,3,0
	bc 12,2,.L673
	bl CTFResetGrapple
	lwz 9,84(31)
	lwz 0,3632(9)
	cmpwi 0,0,3
	bc 4,2,.L673
	li 0,0
	stw 0,3632(9)
.L673:
	lwz 9,84(31)
	lwz 0,3596(9)
	cmpwi 0,0,0
	bc 12,2,.L675
	lwz 0,3948(9)
	cmpwi 0,0,0
	bc 4,1,.L675
	lwz 0,3632(9)
	cmpwi 0,0,3
	bc 4,2,.L675
	li 0,2
	li 11,32
	stw 0,3632(9)
	lwz 9,84(31)
	stw 11,92(9)
.L675:
	lwz 11,84(31)
	lis 8,pause_frames.126@ha
	lis 9,fire_frames.127@ha
	lis 10,CTFWeapon_Grapple_Fire@ha
	la 8,pause_frames.126@l(8)
	lwz 29,3632(11)
	la 9,fire_frames.127@l(9)
	la 10,CTFWeapon_Grapple_Fire@l(10)
	mr 3,31
	li 4,5
	li 5,9
	li 6,31
	li 7,36
	bl Weapon_Generic
	cmpwi 0,29,1
	bc 4,2,.L676
	lwz 9,84(31)
	lwz 0,3632(9)
	cmpwi 0,0,0
	bc 4,2,.L676
	lwz 0,3948(9)
	cmpwi 0,0,0
	bc 4,1,.L676
	lwz 0,3580(9)
	andi. 11,0,1
	li 0,5
	bc 4,2,.L677
	li 0,9
.L677:
	stw 0,92(9)
	lwz 9,84(31)
	li 0,3
	stw 0,3632(9)
.L676:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 CTFWeapon_Grapple,.Lfe24-CTFWeapon_Grapple
	.section	".rodata"
	.align 2
.LC160:
	.string	"You are in CAM mode. You must reconnect or restart the game to rejoin the action.\n"
	.align 2
.LC161:
	.string	"You are on the %s team.\n"
	.align 2
.LC162:
	.string	"red"
	.align 2
.LC163:
	.string	"blue"
	.align 2
.LC164:
	.string	"Unknown team %s.\n"
	.align 2
.LC165:
	.string	"You are already on the %s team.\n"
	.align 2
.LC166:
	.string	"skin"
	.align 2
.LC167:
	.string	"%s joined the %s team.\n"
	.align 2
.LC168:
	.string	"%s changed to the %s team.\n"
	.align 2
.LC169:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFTeam_f
	.type	 CTFTeam_f,@function
CTFTeam_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 11,.LC169@ha
	lis 9,ctf@ha
	la 11,.LC169@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L681
	lwz 9,280(31)
	lbz 0,0(9)
	cmpwi 0,0,99
	bc 4,2,.L683
	lis 5,.LC160@ha
	la 5,.LC160@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L681
.L683:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 4,2,.L684
	lwz 9,84(31)
	lwz 0,3468(9)
	cmpwi 0,0,1
	bc 12,2,.L685
	cmpwi 0,0,2
	bc 12,2,.L686
	b .L689
.L685:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L688
.L686:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L688
.L689:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L688:
	lis 5,.LC161@ha
	mr 3,31
	la 5,.LC161@l(5)
	b .L716
.L684:
	lis 4,.LC162@ha
	mr 3,29
	la 4,.LC162@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L690
	li 30,1
	b .L691
.L690:
	lis 4,.LC163@ha
	mr 3,29
	la 4,.LC163@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L692
	lis 5,.LC164@ha
	mr 3,31
	la 5,.LC164@l(5)
	mr 6,29
	b .L716
.L692:
	li 30,2
.L691:
	lwz 9,84(31)
	lwz 0,3468(9)
	cmpw 0,0,30
	bc 4,2,.L694
	cmpwi 0,30,1
	bc 12,2,.L695
	cmpwi 0,30,2
	bc 12,2,.L696
	b .L699
.L695:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L698
.L696:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L698
.L699:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L698:
	lis 5,.LC165@ha
	mr 3,31
	la 5,.LC165@l(5)
.L716:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L681
.L694:
	lwz 0,264(31)
	li 11,0
	lis 4,.LC166@ha
	stw 11,184(31)
	la 4,.LC166@l(4)
	rlwinm 0,0,0,28,26
	stw 0,264(31)
	stw 30,3468(9)
	lwz 9,84(31)
	stw 11,3472(9)
	lwz 3,84(31)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl CTFAssignSkin
	lwz 9,84(31)
	lwz 0,3468(9)
	addi 4,9,700
	cmpwi 0,0,1
	bc 12,2,.L700
	cmpwi 0,0,2
	bc 12,2,.L701
	b .L704
.L700:
	lis 9,.LC13@ha
	la 5,.LC13@l(9)
	b .L703
.L701:
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
	b .L703
.L704:
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
.L703:
	lis 9,level+4@ha
	lis 3,gi@ha
	lfs 1,level+4@l(9)
	la 3,gi@l(3)
	bl sl_LogPlayerTeamChange
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L705
	mr 3,31
	bl PutClientInServer
	lwz 8,84(31)
	li 0,6
	li 11,32
	stw 0,80(31)
	li 10,14
	cmpwi 0,30,1
	stb 11,16(8)
	lwz 9,84(31)
	stb 10,17(9)
	lwz 11,84(31)
	addi 5,11,700
	bc 12,2,.L706
	cmpwi 0,30,2
	bc 12,2,.L707
	b .L710
.L706:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L709
.L707:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L709
.L710:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L709:
	lis 4,.LC167@ha
	li 3,2
	la 4,.LC167@l(4)
	crxor 6,6,6
	bl my_bprintf
	b .L681
.L705:
	li 29,0
	lis 6,0x1
	lis 7,vec3_origin@ha
	mr 5,31
	stw 29,480(31)
	mr 3,31
	la 7,vec3_origin@l(7)
	mr 4,31
	ori 6,6,34464
	bl player_die
	li 0,2
	mr 3,31
	stw 0,492(31)
	bl respawn
	lwz 11,84(31)
	cmpwi 0,30,1
	stw 29,3464(11)
	lwz 9,84(31)
	addi 5,9,700
	bc 12,2,.L711
	cmpwi 0,30,2
	bc 12,2,.L712
	b .L715
.L711:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L714
.L712:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L714
.L715:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L714:
	lis 4,.LC168@ha
	li 3,2
	la 4,.LC168@l(4)
	crxor 6,6,6
	bl my_bprintf
.L681:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 CTFTeam_f,.Lfe25-CTFTeam_f
	.section	".rodata"
	.align 2
.LC170:
	.string	"if 24 xv 8 yv 8 pic 24 endif xv 40 yv 28 string \"%4d/%-3d\" xv 98 yv 12 num 2 18 if 25 xv 168 yv 8 pic 25 endif xv 200 yv 28 string \"%4d/%-3d\" xv 256 yv 12 num 2 20 "
	.align 2
.LC171:
	.string	"ctf 0 %d %d %d %d "
	.align 2
.LC172:
	.string	"xv 56 yv %d picn sbfctf2 "
	.align 2
.LC173:
	.string	"ctf 160 %d %d %d %d "
	.align 2
.LC174:
	.string	"xv 216 yv %d picn sbfctf1 "
	.align 2
.LC175:
	.string	"xv 0 yv %d string2 \"Spectators\" "
	.align 2
.LC176:
	.string	"ctf %d %d %d %d %d "
	.align 2
.LC177:
	.string	"xv 8 yv %d string \"..and %d more\" "
	.align 2
.LC178:
	.string	"xv 168 yv %d string \"..and %d more\" "
	.align 2
.LC179:
	.long 0x0
	.align 3
.LC180:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFScoreboardMessage
	.type	 CTFScoreboardMessage,@function
CTFScoreboardMessage:
	stwu 1,-6656(1)
	mflr 0
	mfcr 12
	stmw 14,6584(1)
	stw 0,6660(1)
	stw 12,6580(1)
	lis 9,game@ha
	li 0,0
	la 8,game@l(9)
	addi 11,1,6536
	lwz 10,1544(8)
	li 26,0
	li 24,0
	stw 0,4(11)
	li 25,0
	addi 9,1,6544
	stw 0,6536(1)
	cmpw 0,24,10
	mr 17,11
	stw 26,4(9)
	mr 14,9
	addi 21,1,1032
	stw 26,6544(1)
	bc 4,0,.L719
	lis 9,g_edicts@ha
	mr 20,8
	lwz 16,g_edicts@l(9)
	mr 12,17
	mr 19,14
	addi 18,1,4488
	mr 15,17
.L721:
	mulli 9,24,1352
	addi 22,24,1
	add 31,9,16
	lwz 0,1440(31)
	cmpwi 0,0,0
	bc 12,2,.L720
	mulli 9,24,4088
	lwz 0,1028(20)
	mr 8,9
	add 9,9,0
	lwz 0,3468(9)
	cmpwi 0,0,1
	bc 4,2,.L723
	li 10,0
	b .L724
.L723:
	cmpwi 0,0,2
	bc 4,2,.L720
	li 10,1
.L724:
	slwi 0,10,2
	lwz 9,1028(20)
	li 27,0
	lwzx 11,12,0
	mr 3,0
	slwi 7,10,10
	add 9,8,9
	addi 6,1,4488
	cmpw 0,27,11
	lwz 30,3464(9)
	addi 4,1,2440
	addi 22,24,1
	bc 4,0,.L728
	lwzx 0,18,7
	cmpw 0,30,0
	bc 12,1,.L728
	lwzx 11,3,15
	add 9,7,6
.L729:
	addi 27,27,1
	cmpw 0,27,11
	bc 4,0,.L728
	lwzu 0,4(9)
	cmpw 0,30,0
	bc 4,1,.L729
.L728:
	lwzx 28,3,12
	slwi 23,27,2
	cmpw 0,28,27
	bc 4,1,.L734
	addi 11,4,-4
	slwi 9,28,2
	add 11,7,11
	addi 0,6,-4
	add 0,7,0
	add 10,9,11
	mr 29,4
	add 8,9,0
	add 11,9,7
	mr 5,6
.L736:
	lwz 9,0(10)
	addi 28,28,-1
	cmpw 0,28,27
	addi 10,10,-4
	stwx 9,11,29
	lwz 0,0(8)
	addi 8,8,-4
	stwx 0,11,5
	addi 11,11,-4
	bc 12,1,.L736
.L734:
	add 0,23,7
	stwx 24,4,0
	stwx 30,6,0
	lwzx 9,3,19
	lwzx 11,3,12
	add 9,9,30
	addi 11,11,1
	stwx 9,3,19
	stwx 11,3,12
.L720:
	lwz 0,1544(20)
	mr 24,22
	cmpw 0,24,0
	bc 12,0,.L721
.L719:
	li 0,0
	lwz 7,4(14)
	lis 4,.LC170@ha
	lwz 8,4(17)
	la 4,.LC170@l(4)
	mr 3,21
	lwz 5,6544(1)
	li 24,0
	lwz 6,6536(1)
	stb 0,1032(1)
	crxor 6,6,6
	bl sprintf
	mr 3,21
	bl strlen
	lwz 0,6536(1)
	mr 22,3
	b .L771
.L743:
	lwz 9,6536(1)
	li 0,0
	stb 0,8(1)
	cmpw 0,24,9
	bc 4,0,.L744
	addi 29,1,2440
	slwi 28,24,2
	lwzx 0,29,28
	lis 9,game+1028@ha
	lis 10,g_edicts@ha
	lwz 8,game+1028@l(9)
	addi 3,1,8
	mulli 9,0,1352
	lwz 11,g_edicts@l(10)
	mr 23,3
	mulli 0,0,4088
	addi 9,9,1352
	add 30,8,0
	add 31,11,9
	bl strlen
	lwz 11,184(30)
	slwi 9,24,3
	lis 4,.LC171@ha
	addi 27,9,42
	lwzx 6,29,28
	la 4,.LC171@l(4)
	cmpwi 7,11,1000
	lwz 7,3464(30)
	add 3,23,3
	mr 5,27
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 8,0,0
	and 11,11,0
	andi. 8,8,999
	or 8,11,8
	crxor 6,6,6
	bl sprintf
	lis 9,flag2_item@ha
	lis 11,itemlist@ha
	lwz 10,84(31)
	lwz 0,flag2_item@l(9)
	la 11,itemlist@l(11)
	lis 9,0x286b
	addi 10,10,740
	ori 9,9,51739
	subf 0,11,0
	mullw 0,0,9
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L746
	mr 3,23
	bl strlen
	lis 4,.LC172@ha
	mr 5,27
	la 4,.LC172@l(4)
	add 3,23,3
	crxor 6,6,6
	bl sprintf
.L746:
	mr 3,23
	subfic 29,22,1000
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L744
	mr 4,23
	mr 3,21
	bl strcat
	mr 25,24
	mr 3,21
	bl strlen
	mr 22,3
.L744:
	lwz 0,4(17)
	cmpw 0,24,0
	bc 4,0,.L741
	addi 29,1,3464
	slwi 28,24,2
	lwzx 0,29,28
	lis 9,game+1028@ha
	lis 10,g_edicts@ha
	lwz 8,game+1028@l(9)
	addi 3,1,8
	mulli 9,0,1352
	lwz 11,g_edicts@l(10)
	mr 23,3
	mulli 0,0,4088
	addi 9,9,1352
	add 30,8,0
	add 31,11,9
	bl strlen
	lwz 11,184(30)
	slwi 9,24,3
	lis 4,.LC173@ha
	addi 27,9,42
	lwzx 6,29,28
	la 4,.LC173@l(4)
	cmpwi 7,11,1000
	lwz 7,3464(30)
	add 3,23,3
	mr 5,27
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 8,0,0
	and 11,11,0
	andi. 8,8,999
	or 8,11,8
	crxor 6,6,6
	bl sprintf
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 10,84(31)
	lwz 0,flag1_item@l(9)
	la 11,itemlist@l(11)
	lis 9,0x286b
	addi 10,10,740
	ori 9,9,51739
	subf 0,11,0
	mullw 0,0,9
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L750
	mr 3,23
	bl strlen
	lis 4,.LC174@ha
	mr 5,27
	la 4,.LC174@l(4)
	add 3,23,3
	crxor 6,6,6
	bl sprintf
.L750:
	mr 3,23
	subfic 29,22,1000
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L741
	mr 4,23
	mr 3,21
	bl strcat
	mr 26,24
	mr 3,21
	bl strlen
	mr 22,3
.L741:
	addi 24,24,1
	cmpwi 0,24,15
	bc 12,1,.L740
	lwz 0,6536(1)
.L771:
	cmpw 0,24,0
	bc 12,0,.L743
	lwz 0,4(17)
	cmpw 0,24,0
	bc 12,0,.L743
.L740:
	cmpw 7,25,26
	subfic 0,22,1000
	cmpwi 0,0,50
	li 18,0
	li 28,0
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 11,25,0
	and 0,26,0
	or 27,0,11
	slwi 9,27,3
	addi 27,9,58
	bc 4,1,.L755
	lis 9,maxclients@ha
	lis 10,.LC179@ha
	lwz 11,maxclients@l(9)
	la 10,.LC179@l(10)
	li 24,0
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L755
	lis 9,game@ha
	lis 14,g_edicts@ha
	la 15,game@l(9)
	mr 23,21
	lis 16,0x4330
	li 19,0
	li 20,1352
.L759:
	lwz 0,g_edicts@l(14)
	lwz 11,1028(15)
	add 31,0,20
	lwz 9,88(31)
	add 30,11,19
	cmpwi 0,9,0
	bc 12,2,.L758
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L758
	lwz 9,84(31)
	lwz 0,3468(9)
	cmpwi 0,0,0
	bc 4,2,.L758
	cmpwi 0,28,0
	bc 4,2,.L762
	lis 4,.LC175@ha
	mr 5,27
	addi 3,1,8
	la 4,.LC175@l(4)
	crxor 6,6,6
	bl sprintf
	li 28,1
	addi 27,27,8
	addi 4,1,8
	mr 3,23
	bl strcat
	mr 3,23
	bl strlen
	mr 22,3
.L762:
	addi 3,1,8
	subfic 29,22,1000
	mr 31,3
	bl strlen
	lwz 11,184(30)
	rlwinm 5,18,0,31,31
	lis 4,.LC176@ha
	cmpwi 4,5,0
	lwz 8,3464(30)
	la 4,.LC176@l(4)
	cmpwi 7,11,1000
	neg 5,5
	andi. 5,5,160
	mr 6,27
	mr 7,24
	add 3,31,3
	mfcr 0
	rlwinm 0,0,29,1
	neg 0,0
	nor 9,0,0
	and 11,11,0
	andi. 9,9,999
	or 9,11,9
	crxor 6,6,6
	bl sprintf
	mr 3,31
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L766
	mr 4,31
	mr 3,23
	bl strcat
	mr 3,23
	bl strlen
	mr 22,3
.L766:
	mfcr 0
	rlwinm 0,0,19,1
	addi 9,27,8
	neg 0,0
	addi 18,18,1
	andc 9,9,0
	and 0,27,0
	or 27,0,9
.L758:
	lis 10,maxclients@ha
	addi 24,24,1
	lwz 11,maxclients@l(10)
	xoris 0,24,0x8000
	lis 10,.LC180@ha
	stw 0,6572(1)
	addi 19,19,4088
	la 10,.LC180@l(10)
	stw 16,6568(1)
	addi 20,20,1352
	lfd 12,0(10)
	lfd 0,6568(1)
	lfs 13,20(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L759
.L755:
	lwz 0,6536(1)
	subf 0,25,0
	cmpwi 0,0,1
	bc 4,1,.L769
	mr 3,21
	bl strlen
	lwz 6,6536(1)
	slwi 5,25,3
	lis 4,.LC177@ha
	la 4,.LC177@l(4)
	addi 5,5,50
	subf 6,25,6
	add 3,21,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L769:
	lwz 0,4(17)
	subf 0,26,0
	cmpwi 0,0,1
	bc 4,1,.L770
	mr 3,21
	bl strlen
	lwz 6,4(17)
	slwi 5,26,3
	lis 4,.LC178@ha
	la 4,.LC178@l(4)
	addi 5,5,50
	subf 6,26,6
	add 3,21,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L770:
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
.Lfe26:
	.size	 CTFScoreboardMessage,.Lfe26-CTFScoreboardMessage
	.section	".rodata"
	.align 2
.LC181:
	.string	"You already have a TECH powerup."
	.align 2
.LC182:
	.long 0x40000000
	.align 2
.LC183:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl CTFPickup_Tech
	.type	 CTFPickup_Tech,@function
CTFPickup_Tech:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,item_tech1@ha
	lis 11,itemlist@ha
	lwz 0,item_tech1@l(9)
	la 6,itemlist@l(11)
	lis 8,0x286b
	mr 31,4
	ori 8,8,51739
	subf 0,6,0
	lwz 9,84(31)
	mr 30,3
	mullw 0,0,8
	addi 7,9,740
	rlwinm 0,0,0,0,29
	lwzx 9,7,0
	cmpwi 0,9,0
	bc 4,2,.L783
	lis 9,item_tech2@ha
	lwz 0,item_tech2@l(9)
	subf 0,6,0
	mullw 0,0,8
	rlwinm 0,0,0,0,29
	lwzx 9,7,0
	cmpwi 0,9,0
	bc 4,2,.L783
	lis 9,item_tech3@ha
	lwz 0,item_tech3@l(9)
	subf 0,6,0
	mullw 0,0,8
	rlwinm 0,0,0,0,29
	lwzx 9,7,0
	cmpwi 0,9,0
	bc 4,2,.L783
	lis 9,item_tech4@ha
	lwz 0,item_tech4@l(9)
	subf 0,6,0
	mullw 0,0,8
	rlwinm 0,0,0,0,29
	lwzx 9,7,0
	cmpwi 0,9,0
	bc 12,2,.L782
.L783:
	lis 9,level@ha
	lwz 11,84(31)
	lis 10,.LC182@ha
	la 29,level@l(9)
	la 10,.LC182@l(10)
	lfs 13,3968(11)
	lfs 0,4(29)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L786
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L785
	lis 4,.LC181@ha
	mr 3,31
	la 4,.LC181@l(4)
	crxor 6,6,6
	bl safe_centerprintf
.L785:
	lfs 0,4(29)
	lwz 9,84(31)
	stfs 0,3968(9)
.L786:
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L787
	lwz 0,416(31)
	cmpw 0,0,30
	bc 4,2,.L787
	li 0,0
	lis 10,.LC183@ha
	stw 0,416(31)
	lis 9,level+4@ha
	la 10,.LC183@l(10)
	stw 0,412(31)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,1296(30)
.L787:
	li 3,0
	b .L788
.L782:
	lwz 0,648(30)
	lis 11,level+4@ha
	li 10,1
	li 3,1
	subf 0,6,0
	mullw 0,0,8
	rlwinm 0,0,0,0,29
	lwzx 9,7,0
	addi 9,9,1
	stwx 9,7,0
	lfs 0,level+4@l(11)
	lwz 9,84(31)
	stfs 0,3960(9)
	lwz 11,84(31)
	stw 10,3932(11)
.L788:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 CTFPickup_Tech,.Lfe27-CTFPickup_Tech
	.section	".rodata"
	.align 2
.LC184:
	.string	"info_player_deathmatch"
	.align 2
.LC185:
	.long 0x0
	.align 3
.LC186:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC187:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl CTFDeadDropTech
	.type	 CTFDeadDropTech,@function
CTFDeadDropTech:
	stwu 1,-96(1)
	mflr 0
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 21,36(1)
	stw 0,100(1)
	lis 11,.LC185@ha
	lis 9,ctf@ha
	la 11,.LC185@l(11)
	mr 28,3
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L805
	lis 9,tnames@ha
	la 3,tnames@l(9)
	lwz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L805
	lis 9,itemlist@ha
	lis 11,level@ha
	la 21,itemlist@l(9)
	la 22,level@l(11)
	lis 9,TechThink@ha
	lis 11,.LC187@ha
	la 23,TechThink@l(9)
	la 11,.LC187@l(11)
	lis 9,.LC186@ha
	lfs 30,0(11)
	lis 30,0x1b4e
	la 9,.LC186@l(9)
	lis 27,0x286b
	lfd 31,0(9)
	mr 24,3
	ori 30,30,33205
	lis 25,0x4330
	li 26,0
	ori 27,27,51739
.L809:
	lwz 3,0(24)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L810
	subf 0,21,3
	lwz 11,84(28)
	mullw 0,0,27
	addi 11,11,740
	rlwinm 31,0,0,0,29
	lwzx 9,11,31
	cmpwi 0,9,0
	bc 12,2,.L810
	mr 4,3
	mr 3,28
	bl Drop_Item
	mr 29,3
	bl rand
	mulhw 0,3,30
	srawi 9,3,31
	srawi 0,0,6
	subf 0,9,0
	mulli 0,0,600
	subf 3,0,3
	addi 3,3,-300
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 25,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,376(29)
	bl rand
	mulhw 0,3,30
	srawi 9,3,31
	srawi 0,0,6
	subf 0,9,0
	mulli 0,0,600
	subf 3,0,3
	addi 3,3,-300
	xoris 3,3,0x8000
	stw 3,28(1)
	stw 25,24(1)
	lfd 0,24(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,380(29)
	lfs 13,4(22)
	stw 26,256(29)
	stw 23,436(29)
	fadds 13,13,30
	stfs 13,428(29)
	lwz 9,84(28)
	addi 9,9,740
	stwx 26,9,31
.L810:
	lwzu 0,4(24)
	cmpwi 0,0,0
	bc 4,2,.L809
.L805:
	lwz 0,100(1)
	mtlr 0
	lmw 21,36(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe28:
	.size	 CTFDeadDropTech,.Lfe28-CTFDeadDropTech
	.section	".rodata"
	.align 2
.LC188:
	.long 0x0
	.align 3
.LC189:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC190:
	.long 0x42c80000
	.align 2
.LC191:
	.long 0x41800000
	.align 2
.LC192:
	.long 0x42700000
	.section	".text"
	.align 2
	.type	 SpawnTech,@function
SpawnTech:
	stwu 1,-112(1)
	mflr 0
	stfd 31,104(1)
	stmw 27,84(1)
	stw 0,116(1)
	lis 9,ctf@ha
	lis 7,.LC188@ha
	lwz 11,ctf@l(9)
	la 7,.LC188@l(7)
	mr 30,3
	lfs 31,0(7)
	mr 31,4
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L812
	bl G_Spawn
	lis 27,bonus_head@ha
	lwz 10,0(30)
	mr 29,3
	lis 0,0x1
	stw 0,284(29)
	lis 11,0x4170
	lis 9,0xc170
	stw 10,280(29)
	li 8,512
	lis 28,gi@ha
	stw 30,648(29)
	la 28,gi@l(28)
	lwz 0,28(30)
	stw 8,68(29)
	stw 0,64(29)
	stw 11,208(29)
	stw 11,200(29)
	stw 11,204(29)
	stw 9,196(29)
	stw 9,188(29)
	stw 9,192(29)
	lwz 9,44(28)
	lwz 4,24(30)
	mtlr 9
	blrl
	lis 9,Touch_Item@ha
	li 11,1
	stw 29,256(29)
	la 9,Touch_Item@l(9)
	li 0,7
	stw 11,248(29)
	stw 0,260(29)
	stw 9,444(29)
	stfs 31,40(1)
	bl rand
	lis 0,0xb60b
	mr 9,3
	stfs 31,48(1)
	ori 0,0,24759
	srawi 10,9,31
	mulhw 0,9,0
	lis 8,0x4330
	lis 7,.LC189@ha
	addi 3,1,40
	add 0,0,9
	la 7,.LC189@l(7)
	srawi 0,0,8
	lfd 13,0(7)
	addi 4,1,8
	subf 0,10,0
	addi 5,1,24
	mulli 0,0,360
	li 6,0
	subf 9,0,9
	xoris 9,9,0x8000
	stw 9,76(1)
	stw 8,72(1)
	lfd 0,72(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,44(1)
	bl AngleVectors
	lfs 0,4(31)
	lis 9,.LC191@ha
	lis 7,.LC190@ha
	la 9,.LC191@l(9)
	la 7,.LC190@l(7)
	lfs 12,0(9)
	addi 3,1,8
	addi 4,29,376
	stfs 0,4(29)
	lfs 13,8(31)
	lfs 1,0(7)
	stfs 13,8(29)
	lfs 0,12(31)
	fadds 0,0,12
	stfs 0,12(29)
	bl VectorScale
	lis 0,0x4396
	lis 7,.LC192@ha
	lis 11,level+4@ha
	stw 0,384(29)
	la 7,.LC192@l(7)
	lfs 0,level+4@l(11)
	lis 9,TechThink@ha
	mr 3,29
	lfs 13,0(7)
	la 9,TechThink@l(9)
	stw 9,436(29)
	fadds 0,0,13
	stfs 0,428(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 4,bonus_head@l(27)
	mr 3,29
	bl AddToItemList
	lis 9,titems@ha
	li 11,0
	stw 3,bonus_head@l(27)
	la 9,titems@l(9)
	lwzx 0,9,11
	cmpwi 0,0,0
	bc 12,2,.L815
.L816:
	lwzu 0,4(9)
	addi 11,11,1
	cmpwi 0,0,0
	bc 4,2,.L816
.L815:
	cmpwi 0,11,2
	bc 12,1,.L812
	lis 9,titems@ha
	slwi 0,11,2
	la 9,titems@l(9)
	stwx 30,9,0
.L812:
	lwz 0,116(1)
	mtlr 0
	lmw 27,84(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe29:
	.size	 SpawnTech,.Lfe29-SpawnTech
	.section	".sdata","aw"
	.align 2
	.type	 tech.170,@object
	.size	 tech.170,4
tech.170:
	.long 0
	.section	".rodata"
	.align 2
.LC194:
	.string	"ctf/tech1.wav"
	.align 2
.LC193:
	.long 0x3e4ccccd
	.align 2
.LC195:
	.long 0x3f800000
	.align 2
.LC196:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFApplyResistance
	.type	 CTFApplyResistance,@function
CTFApplyResistance:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 29,12(1)
	stw 0,36(1)
	mr 31,3
	lis 11,.LC195@ha
	lwz 9,84(31)
	la 11,.LC195@l(11)
	mr 30,4
	lfs 31,0(11)
	cmpwi 0,9,0
	bc 12,2,.L843
	lwz 0,3796(9)
	cmpwi 0,0,0
	bc 4,2,.L844
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L843
.L844:
	lis 9,.LC193@ha
	lfs 31,.LC193@l(9)
.L843:
	lis 11,tech.170@ha
	lwz 0,tech.170@l(11)
	cmpwi 0,0,0
	bc 4,2,.L845
	lis 9,item_tech1@ha
	lwz 0,item_tech1@l(9)
	stw 0,tech.170@l(11)
.L845:
	cmpwi 0,30,0
	bc 12,2,.L846
	lwz 10,tech.170@l(11)
	cmpwi 0,10,0
	bc 12,2,.L846
	lwz 11,84(31)
	cmpwi 0,11,0
	bc 12,2,.L846
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L846
	lis 29,gi@ha
	lis 3,.LC194@ha
	la 29,gi@l(29)
	la 3,.LC194@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC195@ha
	lis 11,.LC196@ha
	fmr 1,31
	mr 5,3
	la 9,.LC195@l(9)
	la 11,.LC196@l(11)
	mr 3,31
	lfs 2,0(9)
	mtlr 0
	li 4,2
	lfs 3,0(11)
	blrl
	srwi 3,30,31
	add 3,30,3
	srawi 3,3,1
	b .L847
.L846:
	mr 3,30
.L847:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 CTFApplyResistance,.Lfe30-CTFApplyResistance
	.section	".sdata","aw"
	.align 2
	.type	 tech.174,@object
	.size	 tech.174,4
tech.174:
	.long 0
	.align 2
	.type	 tech.178,@object
	.size	 tech.178,4
tech.178:
	.long 0
	.section	".rodata"
	.align 2
.LC198:
	.string	"ctf/tech2x.wav"
	.align 2
.LC199:
	.string	"ctf/tech2.wav"
	.align 2
.LC197:
	.long 0x3e4ccccd
	.align 2
.LC200:
	.long 0x3f800000
	.align 3
.LC201:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC202:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFApplyStrengthSound
	.type	 CTFApplyStrengthSound,@function
CTFApplyStrengthSound:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 29,28(1)
	stw 0,52(1)
	mr 31,3
	lis 7,.LC200@ha
	lwz 9,84(31)
	la 7,.LC200@l(7)
	lfs 31,0(7)
	cmpwi 0,9,0
	bc 12,2,.L852
	lwz 0,3796(9)
	cmpwi 0,0,0
	bc 4,2,.L853
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L852
.L853:
	lis 9,.LC197@ha
	lfs 31,.LC197@l(9)
.L852:
	lis 11,tech.178@ha
	lwz 0,tech.178@l(11)
	cmpwi 0,0,0
	bc 4,2,.L860
	lis 9,item_tech2@ha
	lwz 0,item_tech2@l(9)
	cmpwi 0,0,0
	stw 0,tech.178@l(11)
	bc 12,2,.L855
.L860:
	lwz 8,84(31)
	cmpwi 0,8,0
	bc 12,2,.L855
	lwz 0,tech.178@l(11)
	lis 9,itemlist@ha
	addi 10,8,740
	la 9,itemlist@l(9)
	lis 11,0x286b
	subf 0,9,0
	ori 11,11,51739
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L855
	lis 11,level@ha
	lfs 0,3964(8)
	la 9,level@l(11)
	lfs 13,4(9)
	fcmpu 0,0,13
	bc 4,0,.L856
	lis 7,.LC200@ha
	la 7,.LC200@l(7)
	lis 10,0x4330
	lfs 0,0(7)
	lis 7,.LC201@ha
	la 7,.LC201@l(7)
	fadds 0,13,0
	lfd 12,0(7)
	stfs 0,3964(8)
	lwz 0,level@l(11)
	lwz 11,84(31)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	lfs 13,3772(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L857
	lis 29,gi@ha
	lis 3,.LC198@ha
	la 29,gi@l(29)
	la 3,.LC198@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC200@ha
	lis 9,.LC202@ha
	fmr 1,31
	mr 5,3
	la 7,.LC200@l(7)
	la 9,.LC202@l(9)
	li 4,2
	lfs 2,0(7)
	mtlr 0
	mr 3,31
	lfs 3,0(9)
	blrl
	b .L856
.L857:
	lis 29,gi@ha
	lis 3,.LC199@ha
	la 29,gi@l(29)
	la 3,.LC199@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC200@ha
	lis 9,.LC202@ha
	fmr 1,31
	mr 5,3
	la 7,.LC200@l(7)
	la 9,.LC202@l(9)
	li 4,2
	lfs 2,0(7)
	mtlr 0
	mr 3,31
	lfs 3,0(9)
	blrl
.L856:
	li 3,1
	b .L859
.L855:
	li 3,0
.L859:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe31:
	.size	 CTFApplyStrengthSound,.Lfe31-CTFApplyStrengthSound
	.section	".sdata","aw"
	.align 2
	.type	 tech.182,@object
	.size	 tech.182,4
tech.182:
	.long 0
	.align 2
	.type	 tech.186,@object
	.size	 tech.186,4
tech.186:
	.long 0
	.section	".rodata"
	.align 2
.LC204:
	.string	"ctf/tech3.wav"
	.align 2
.LC203:
	.long 0x3e4ccccd
	.align 2
.LC205:
	.long 0x3f800000
	.align 2
.LC206:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFApplyHasteSound
	.type	 CTFApplyHasteSound,@function
CTFApplyHasteSound:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 29,12(1)
	stw 0,36(1)
	lis 9,.LC205@ha
	mr 31,3
	la 9,.LC205@l(9)
	lfs 31,0(9)
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L866
	lwz 0,3796(9)
	cmpwi 0,0,0
	bc 4,2,.L867
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L866
.L867:
	lis 9,.LC203@ha
	lfs 31,.LC203@l(9)
.L866:
	lis 11,tech.186@ha
	lwz 0,tech.186@l(11)
	cmpwi 0,0,0
	bc 4,2,.L870
	lis 9,item_tech3@ha
	lwz 0,item_tech3@l(9)
	cmpwi 0,0,0
	stw 0,tech.186@l(11)
	bc 12,2,.L869
.L870:
	lwz 8,84(31)
	cmpwi 0,8,0
	bc 12,2,.L869
	lwz 0,tech.186@l(11)
	lis 9,itemlist@ha
	addi 10,8,740
	la 9,itemlist@l(9)
	lis 11,0x286b
	subf 0,9,0
	ori 11,11,51739
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L869
	lis 9,level+4@ha
	lfs 0,3964(8)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L869
	lis 9,.LC205@ha
	lis 29,gi@ha
	la 9,.LC205@l(9)
	la 29,gi@l(29)
	lfs 0,0(9)
	lis 3,.LC204@ha
	la 3,.LC204@l(3)
	fadds 0,13,0
	stfs 0,3964(8)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC205@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC205@l(9)
	li 4,2
	lfs 2,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC206@ha
	la 9,.LC206@l(9)
	lfs 3,0(9)
	blrl
.L869:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe32:
	.size	 CTFApplyHasteSound,.Lfe32-CTFApplyHasteSound
	.section	".sdata","aw"
	.align 2
	.type	 tech.190,@object
	.size	 tech.190,4
tech.190:
	.long 0
	.section	".rodata"
	.align 2
.LC208:
	.string	"ctf/tech4.wav"
	.align 2
.LC207:
	.long 0x3e4ccccd
	.align 2
.LC209:
	.long 0x3f800000
	.align 3
.LC210:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC211:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFApplyRegeneration
	.type	 CTFApplyRegeneration,@function
CTFApplyRegeneration:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	mr 31,3
	lis 9,.LC209@ha
	lwz 29,84(31)
	la 9,.LC209@l(9)
	li 28,0
	lfs 31,0(9)
	cmpwi 0,29,0
	bc 12,2,.L871
	lwz 0,3796(29)
	cmpwi 0,0,0
	bc 4,2,.L874
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L873
.L874:
	lis 9,.LC207@ha
	lfs 31,.LC207@l(9)
.L873:
	lis 11,tech.190@ha
	lwz 0,tech.190@l(11)
	cmpwi 0,0,0
	bc 4,2,.L883
	lis 9,item_tech4@ha
	lwz 0,item_tech4@l(9)
	cmpwi 0,0,0
	stw 0,tech.190@l(11)
	bc 12,2,.L871
.L883:
	lwz 0,tech.190@l(11)
	lis 9,itemlist@ha
	addi 10,29,740
	la 9,itemlist@l(9)
	lis 11,0x286b
	subf 0,9,0
	ori 11,11,51739
	mullw 0,0,11
	mr 30,10
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L871
	lis 9,level+4@ha
	lfs 0,3960(29)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L877
	stfs 13,3960(29)
	lwz 9,480(31)
	cmpwi 0,9,149
	bc 12,1,.L878
	addi 0,9,5
	cmpwi 0,0,150
	stw 0,480(31)
	bc 4,1,.L879
	li 0,150
	stw 0,480(31)
.L879:
	lfs 0,3960(29)
	lis 9,.LC210@ha
	li 28,1
	la 9,.LC210@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3960(29)
.L878:
	mr 3,31
	bl ArmorIndex
	mr. 3,3
	bc 12,2,.L877
	slwi 3,3,2
	lwzx 9,30,3
	cmpwi 0,9,149
	bc 12,1,.L877
	addi 0,9,5
	cmpwi 0,0,150
	stwx 0,30,3
	bc 4,1,.L881
	li 0,150
	stwx 0,30,3
.L881:
	lfs 0,3960(29)
	lis 9,.LC210@ha
	li 28,1
	la 9,.LC210@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3960(29)
.L877:
	cmpwi 0,28,0
	bc 12,2,.L871
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3964(11)
	fcmpu 0,0,13
	bc 4,0,.L871
	lis 9,.LC209@ha
	lis 29,gi@ha
	la 9,.LC209@l(9)
	la 29,gi@l(29)
	lfs 0,0(9)
	lis 3,.LC208@ha
	la 3,.LC208@l(3)
	fadds 0,13,0
	stfs 0,3964(11)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC209@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC209@l(9)
	li 4,2
	lfs 2,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC211@ha
	la 9,.LC211@l(9)
	lfs 3,0(9)
	blrl
.L871:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe33:
	.size	 CTFApplyRegeneration,.Lfe33-CTFApplyRegeneration
	.section	".sdata","aw"
	.align 2
	.type	 tech.194,@object
	.size	 tech.194,4
tech.194:
	.long 0
	.globl loc_names
	.section	".data"
	.align 2
	.type	 loc_names,@object
loc_names:
	.long .LC11
	.long 1
	.long .LC12
	.long 1
	.long .LC212
	.long 2
	.long .LC213
	.long 2
	.long .LC214
	.long 3
	.long .LC215
	.long 4
	.long .LC216
	.long 4
	.long .LC217
	.long 4
	.long .LC218
	.long 4
	.long .LC219
	.long 4
	.long .LC220
	.long 4
	.long .LC221
	.long 4
	.long .LC222
	.long 4
	.long .LC223
	.long 5
	.long .LC224
	.long 5
	.long .LC225
	.long 6
	.long .LC226
	.long 6
	.long .LC227
	.long 6
	.long .LC228
	.long 7
	.long .LC229
	.long 7
	.long .LC230
	.long 7
	.long .LC231
	.long 7
	.long .LC232
	.long 8
	.long .LC233
	.long 8
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC233:
	.string	"item_pack"
	.align 2
.LC232:
	.string	"item_bandolier"
	.align 2
.LC231:
	.string	"item_adrenaline"
	.align 2
.LC230:
	.string	"item_enviro"
	.align 2
.LC229:
	.string	"item_breather"
	.align 2
.LC228:
	.string	"item_silencer"
	.align 2
.LC227:
	.string	"item_armor_jacket"
	.align 2
.LC226:
	.string	"item_armor_combat"
	.align 2
.LC225:
	.string	"item_armor_body"
	.align 2
.LC224:
	.string	"item_power_shield"
	.align 2
.LC223:
	.string	"item_power_screen"
	.align 2
.LC222:
	.string	"weapon_shotgun"
	.align 2
.LC221:
	.string	"weapon_supershotgun"
	.align 2
.LC220:
	.string	"weapon_machinegun"
	.align 2
.LC219:
	.string	"weapon_grenadelauncher"
	.align 2
.LC218:
	.string	"weapon_chaingun"
	.align 2
.LC217:
	.string	"weapon_hyperblaster"
	.align 2
.LC216:
	.string	"weapon_rocketlauncher"
	.align 2
.LC215:
	.string	"weapon_railgun"
	.align 2
.LC214:
	.string	"weapon_bfg"
	.align 2
.LC213:
	.string	"item_invulnerability"
	.align 2
.LC212:
	.string	"item_quad"
	.size	 loc_names,200
	.align 2
.LC235:
	.string	"nowhere"
	.align 2
.LC236:
	.string	"in the water "
	.align 2
.LC237:
	.string	"above "
	.align 2
.LC238:
	.string	"below "
	.align 2
.LC239:
	.string	"near "
	.align 2
.LC240:
	.string	"the red "
	.align 2
.LC241:
	.string	"the blue "
	.align 2
.LC242:
	.string	"the "
	.align 2
.LC234:
	.long 0x497423f0
	.align 2
.LC243:
	.long 0x44800000
	.align 3
.LC244:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC245:
	.long 0x0
	.section	".text"
	.align 2
	.type	 CTFSay_Team_Location,@function
CTFSay_Team_Location:
	stwu 1,-128(1)
	mflr 0
	mfcr 12
	stfd 30,112(1)
	stfd 31,120(1)
	stmw 15,44(1)
	stw 0,132(1)
	stw 12,40(1)
	lis 9,loc_names+4@ha
	lis 11,.LC234@ha
	la 20,loc_names+4@l(9)
	lfs 31,.LC234@l(11)
	mr 27,3
	lis 9,.LC243@ha
	addi 17,20,-4
	la 9,.LC243@l(9)
	addi 18,27,4
	lfs 30,0(9)
	mr 25,4
	li 30,0
	li 26,0
	li 23,999
	li 16,-1
	li 22,0
	addi 19,1,24
	lis 21,g_edicts@ha
	lis 15,globals@ha
.L888:
	cmpwi 0,30,0
	bc 4,2,.L891
	lwz 31,g_edicts@l(21)
	b .L892
.L939:
	mr 30,31
	b .L904
.L891:
	addi 31,30,1352
.L892:
	la 11,globals@l(15)
	lwz 9,g_edicts@l(21)
	lwz 0,72(11)
	mulli 0,0,1352
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L905
	mr 24,11
	addi 28,31,188
	addi 30,31,200
	addi 29,31,4
.L895:
	lwz 0,-112(30)
	cmpwi 0,0,0
	bc 12,2,.L897
	li 0,3
	lis 9,.LC244@ha
	mtctr 0
	la 9,.LC244@l(9)
	mr 8,29
	lfd 10,0(9)
	mr 10,28
	mr 11,30
	li 9,0
.L941:
	lfsx 13,9,10
	lfsx 11,9,11
	lfsx 12,9,8
	lfsx 0,9,18
	fadds 13,13,11
	fmadd 13,13,10,12
	fsub 0,0,13
	frsp 0,0
	stfsx 0,9,19
	addi 9,9,4
	bdnz .L941
	addi 3,1,24
	bl VectorLength
	fcmpu 0,1,30
	bc 4,1,.L939
.L897:
	lwz 9,72(24)
	addi 31,31,1352
	addi 28,28,1352
	lwz 0,g_edicts@l(21)
	addi 30,30,1352
	addi 29,29,1352
	mulli 9,9,1352
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L895
.L905:
	li 30,0
.L904:
	cmpwi 0,30,0
	bc 12,2,.L889
	li 31,0
	b .L906
.L908:
	addi 31,31,1
.L906:
	slwi 28,31,3
	lwzx 4,17,28
	mr 29,28
	cmpwi 0,4,0
	bc 12,2,.L888
	lwz 3,280(30)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L908
	lwzx 0,17,29
	cmpwi 0,0,0
	bc 12,2,.L888
	mr 3,30
	mr 4,27
	bl loc_CanSee
	cmpwi 7,22,0
	addic 0,3,-1
	subfe 9,0,3
	mfcr 0
	rlwinm 0,0,31,1
	and. 11,9,0
	bc 12,2,.L913
	mr 26,30
	lfs 0,4(27)
	addi 3,1,8
	lfs 13,4(26)
	li 22,1
	lfs 12,8(27)
	lfs 11,12(27)
	fsubs 13,13,0
	lwzx 23,20,29
	stfs 13,8(1)
	lfs 0,8(26)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(26)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorLength
	fmr 31,1
	b .L888
.L913:
	cmpwi 4,3,0
	addic 0,22,-1
	subfe 9,0,22
	mfcr 0
	rlwinm 0,0,19,1
	and. 11,9,0
	bc 4,2,.L888
	bc 12,30,.L915
	lwzx 0,20,29
	cmpw 0,23,0
	bc 12,0,.L888
.L915:
	lfs 0,4(27)
	addi 3,1,8
	lfs 13,4(30)
	lfs 12,8(27)
	lfs 11,12(27)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(30)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(30)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L917
	bc 12,18,.L888
	lwzx 0,20,28
	cmpw 0,0,23
	bc 4,0,.L888
.L917:
	mr 26,30
	fmr 31,1
	mr 4,27
	mr 3,26
	mr 23,31
	bl loc_CanSee
	mr 22,3
	b .L888
.L889:
	cmpwi 0,26,0
	bc 4,2,.L918
	b .L942
.L940:
	li 16,1
	b .L920
.L918:
	li 30,0
	lis 31,.LC11@ha
	lis 29,.LC12@ha
	b .L919
.L921:
	cmpw 0,30,26
	bc 12,2,.L919
	la 5,.LC11@l(31)
	li 3,0
	li 4,280
	bl G_Find
	mr. 31,3
	bc 12,2,.L920
	la 5,.LC12@l(29)
	li 3,0
	li 4,280
	bl G_Find
	mr. 30,3
	bc 12,2,.L920
	lfs 0,4(31)
	addi 3,1,8
	lfs 13,4(26)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(31)
	lfs 0,8(26)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 13,12(31)
	lfs 0,12(26)
	fsubs 0,0,13
	stfs 0,16(1)
	bl VectorLength
	lfs 0,4(30)
	fmr 31,1
	addi 3,1,8
	lfs 13,4(26)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,8(30)
	lfs 0,8(26)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 13,12(30)
	lfs 0,12(26)
	fsubs 0,0,13
	stfs 0,16(1)
	bl VectorLength
	fcmpu 0,31,1
	bc 12,0,.L940
	bc 4,1,.L920
	li 16,2
	b .L920
.L919:
	lwz 5,280(26)
	mr 3,30
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L921
.L920:
	lwz 3,280(26)
	bl FindItemByClassname
	mr. 31,3
	bc 4,2,.L928
.L942:
	lis 9,.LC235@ha
	la 11,.LC235@l(9)
	lwz 0,.LC235@l(9)
	lwz 10,4(11)
	stw 0,0(25)
	stw 10,4(25)
	b .L887
.L928:
	lwz 0,612(27)
	cmpwi 0,0,0
	bc 12,2,.L929
	lis 11,.LC236@ha
	lwz 10,.LC236@l(11)
	la 9,.LC236@l(11)
	lhz 8,12(9)
	lwz 0,4(9)
	lwz 11,8(9)
	stw 10,0(25)
	stw 0,4(25)
	stw 11,8(25)
	sth 8,12(25)
	b .L930
.L929:
	stb 0,0(25)
.L930:
	lfs 13,4(26)
	lfs 0,4(27)
	lfs 12,8(27)
	lfs 11,12(27)
	fsubs 0,0,13
	stfs 0,8(1)
	lfs 13,8(26)
	fsubs 10,12,13
	fabs 0,0
	stfs 10,12(1)
	lfs 13,12(26)
	fsubs 11,11,13
	fmr 12,11
	stfs 11,16(1)
	fabs 12,12
	fcmpu 0,12,0
	bc 4,1,.L931
	fmr 0,10
	fabs 0,0
	fcmpu 0,12,0
	bc 4,1,.L931
	lis 9,.LC245@ha
	la 9,.LC245@l(9)
	lfs 0,0(9)
	fcmpu 0,11,0
	bc 4,1,.L932
	lis 4,.LC237@ha
	mr 3,25
	la 4,.LC237@l(4)
	bl strcat
	b .L934
.L932:
	lis 4,.LC238@ha
	mr 3,25
	la 4,.LC238@l(4)
	bl strcat
	b .L934
.L931:
	lis 4,.LC239@ha
	mr 3,25
	la 4,.LC239@l(4)
	bl strcat
.L934:
	cmpwi 0,16,1
	bc 4,2,.L935
	lis 4,.LC240@ha
	mr 3,25
	la 4,.LC240@l(4)
	bl strcat
	b .L936
.L935:
	cmpwi 0,16,2
	bc 4,2,.L937
	lis 4,.LC241@ha
	mr 3,25
	la 4,.LC241@l(4)
	bl strcat
	b .L936
.L937:
	lis 4,.LC242@ha
	mr 3,25
	la 4,.LC242@l(4)
	bl strcat
.L936:
	lwz 4,40(31)
	mr 3,25
	bl strcat
.L887:
	lwz 0,132(1)
	lwz 12,40(1)
	mtlr 0
	lmw 15,44(1)
	lfd 30,112(1)
	lfd 31,120(1)
	mtcrf 8,12
	la 1,128(1)
	blr
.Lfe34:
	.size	 CTFSay_Team_Location,.Lfe34-CTFSay_Team_Location
	.section	".rodata"
	.align 2
.LC246:
	.string	"cells"
	.align 2
.LC247:
	.string	"%s with %i cells "
	.align 2
.LC248:
	.string	"Power Screen"
	.align 2
.LC249:
	.string	"Power Shield"
	.align 2
.LC250:
	.string	"and "
	.align 2
.LC251:
	.string	"%i units of %s"
	.align 2
.LC252:
	.string	"no armor"
	.section	".text"
	.align 2
	.type	 CTFSay_Team_Armor,@function
CTFSay_Team_Armor:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,4
	li 0,0
	mr 30,3
	stb 0,0(31)
	bl PowerArmorType
	mr. 28,3
	bc 12,2,.L944
	lis 3,.LC246@ha
	lwz 29,84(30)
	la 3,.LC246@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 29,29,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 29,29,3
	cmpwi 0,29,0
	bc 12,2,.L944
	mr 3,31
	bl strlen
	cmpwi 0,28,1
	add 3,31,3
	bc 4,2,.L946
	lis 9,.LC248@ha
	la 5,.LC248@l(9)
	b .L947
.L946:
	lis 9,.LC249@ha
	la 5,.LC249@l(9)
.L947:
	lis 4,.LC247@ha
	mr 6,29
	la 4,.LC247@l(4)
	crxor 6,6,6
	bl sprintf
.L944:
	mr 3,30
	bl ArmorIndex
	mr. 29,3
	bc 12,2,.L948
	mr 3,29
	bl GetItemByIndex
	mr. 28,3
	bc 12,2,.L948
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L950
	lis 4,.LC250@ha
	mr 3,31
	la 4,.LC250@l(4)
	bl strcat
.L950:
	mr 3,31
	bl strlen
	lwz 9,84(30)
	slwi 0,29,2
	lis 4,.LC251@ha
	lwz 6,40(28)
	la 4,.LC251@l(4)
	add 3,31,3
	addi 9,9,740
	lwzx 5,9,0
	crxor 6,6,6
	bl sprintf
.L948:
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 4,2,.L951
	lis 9,.LC252@ha
	lwz 10,.LC252@l(9)
	la 11,.LC252@l(9)
	lbz 0,8(11)
	lwz 9,4(11)
	stb 0,8(31)
	stw 10,0(31)
	stw 9,4(31)
.L951:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 CTFSay_Team_Armor,.Lfe35-CTFSay_Team_Armor
	.section	".rodata"
	.align 2
.LC253:
	.string	"dead"
	.align 2
.LC254:
	.string	"%i health"
	.align 2
.LC255:
	.string	"the %s"
	.align 2
.LC256:
	.string	"no powerup"
	.align 2
.LC257:
	.string	"none"
	.align 2
.LC258:
	.string	", "
	.align 2
.LC259:
	.string	" and "
	.align 2
.LC260:
	.string	"no one"
	.align 2
.LC261:
	.long 0x3f800000
	.align 3
.LC262:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.type	 CTFSay_Team_Sight,@function
CTFSay_Team_Sight:
	stwu 1,-2144(1)
	mflr 0
	stfd 31,2136(1)
	stmw 19,2084(1)
	stw 0,2148(1)
	lis 9,maxclients@ha
	li 27,0
	lwz 11,maxclients@l(9)
	mr 26,3
	mr 23,4
	lis 9,.LC261@ha
	stb 27,1032(1)
	li 24,1
	la 9,.LC261@l(9)
	stb 27,8(1)
	lis 19,maxclients@ha
	lfs 13,0(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L966
	lis 11,.LC262@ha
	lis 20,g_edicts@ha
	la 11,.LC262@l(11)
	lis 21,.LC258@ha
	lfd 31,0(11)
	lis 22,0x4330
	li 25,1352
.L968:
	lwz 0,g_edicts@l(20)
	add 30,0,25
	lwz 9,88(30)
	xor 0,30,26
	subfic 11,0,0
	adde 0,11,0
	subfic 11,9,0
	adde 9,11,9
	or. 28,9,0
	bc 4,2,.L967
	mr 3,30
	mr 4,26
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L967
	lbz 0,1032(1)
	addi 31,1,1032
	cmpwi 0,0,0
	bc 12,2,.L971
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,3
	cmplwi 0,29,1023
	bc 12,1,.L972
	cmpwi 0,27,0
	bc 12,2,.L973
	addi 3,1,8
	la 4,.LC258@l(21)
	bl strcat
.L973:
	addi 3,1,8
	mr 4,31
	bl strcat
	stb 28,1032(1)
.L972:
	addi 27,27,1
.L971:
	lwz 4,84(30)
	mr 3,31
	addi 4,4,700
	bl strcpy
.L967:
	addi 24,24,1
	lwz 11,maxclients@l(19)
	xoris 0,24,0x8000
	addi 25,25,1352
	stw 0,2076(1)
	stw 22,2072(1)
	lfd 0,2072(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L968
.L966:
	lbz 0,1032(1)
	cmpwi 0,0,0
	bc 12,2,.L975
	addi 31,1,1032
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,6
	cmplwi 0,29,1023
	bc 12,1,.L976
	cmpwi 0,27,0
	bc 12,2,.L977
	lis 4,.LC259@ha
	addi 3,1,8
	la 4,.LC259@l(4)
	bl strcat
.L977:
	mr 4,31
	addi 3,1,8
	bl strcat
.L976:
	mr 3,23
	addi 4,1,8
	bl strcpy
	b .L978
.L975:
	lis 9,.LC260@ha
	lwz 10,.LC260@l(9)
	la 11,.LC260@l(9)
	lbz 0,6(11)
	lhz 9,4(11)
	stb 0,6(23)
	stw 10,0(23)
	sth 9,4(23)
.L978:
	lwz 0,2148(1)
	mtlr 0
	lmw 19,2084(1)
	lfd 31,2136(1)
	la 1,2144(1)
	blr
.Lfe36:
	.size	 CTFSay_Team_Sight,.Lfe36-CTFSay_Team_Sight
	.section	".rodata"
	.align 2
.LC263:
	.string	"(%s): %s\n"
	.align 2
.LC264:
	.long 0x0
	.align 3
.LC265:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFSay_Team
	.type	 CTFSay_Team,@function
CTFSay_Team:
	stwu 1,-2128(1)
	mflr 0
	stfd 31,2120(1)
	stmw 23,2084(1)
	stw 0,2132(1)
	li 31,0
	mr 30,4
	stb 31,8(1)
	mr 27,3
	lbz 0,0(30)
	cmpwi 0,0,34
	bc 4,2,.L980
	mr 3,30
	bl strlen
	add 3,3,30
	stb 31,-1(3)
	addi 30,30,1
.L980:
	lbz 9,0(30)
	addi 31,1,8
	lis 23,maxclients@ha
	mr 24,31
	cmpwi 0,9,0
	bc 12,2,.L982
.L984:
	cmpwi 0,9,37
	bc 4,2,.L986
	lbzu 9,1(30)
	addi 9,9,-65
	cmplwi 0,9,54
	bc 12,1,.L1012
	lis 11,.L1013@ha
	slwi 10,9,2
	la 11,.L1013@l(11)
	lis 9,.L1013@ha
	lwzx 0,10,11
	la 9,.L1013@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L1013:
	.long .L991-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L993-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L989-.L1013
	.long .L1012-.L1013
	.long .L1011-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L998-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1006-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L991-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L993-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L989-.L1013
	.long .L1012-.L1013
	.long .L1011-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L998-.L1013
	.long .L1012-.L1013
	.long .L1012-.L1013
	.long .L1006-.L1013
.L989:
	addi 29,1,1032
	mr 3,27
	mr 4,29
	addi 30,30,1
	bl CTFSay_Team_Location
	b .L1025
.L991:
	addi 29,1,1032
	mr 3,27
	mr 4,29
	addi 30,30,1
	bl CTFSay_Team_Armor
	b .L1025
.L993:
	lwz 5,480(27)
	cmpwi 0,5,0
	bc 12,1,.L994
	lis 9,.LC253@ha
	la 11,.LC253@l(9)
	lwz 0,.LC253@l(9)
	lbz 10,4(11)
	stw 0,1032(1)
	stb 10,1036(1)
	b .L996
.L994:
	lis 4,.LC254@ha
	addi 3,1,1032
	la 4,.LC254@l(4)
	crxor 6,6,6
	bl sprintf
.L996:
	addi 29,1,1032
	mr 3,31
	mr 4,29
	addi 30,30,1
	b .L1026
.L1024:
	lwz 5,40(3)
	lis 4,.LC255@ha
	addi 3,1,1032
	la 4,.LC255@l(4)
	crxor 6,6,6
	bl sprintf
	b .L1003
.L998:
	lis 9,tnames@ha
	addi 30,30,1
	la 3,tnames@l(9)
	addi 25,1,1032
	lwz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L1004
	lis 9,itemlist@ha
	lis 29,0x286b
	la 26,itemlist@l(9)
	mr 28,3
	ori 29,29,51739
.L1001:
	lwz 3,0(28)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L1002
	subf 0,26,3
	lwz 11,84(27)
	mullw 0,0,29
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L1024
.L1002:
	lwzu 0,4(28)
	cmpwi 0,0,0
	bc 4,2,.L1001
.L1004:
	lis 9,.LC256@ha
	la 11,.LC256@l(9)
	lwz 10,.LC256@l(9)
	lbz 8,10(11)
	lwz 0,4(11)
	lhz 9,8(11)
	stw 10,1032(1)
	stw 0,1036(1)
	sth 9,1040(1)
	stb 8,1042(1)
.L1003:
	mr 3,31
	mr 4,25
	bl strcpy
	mr 3,25
	b .L1027
.L1006:
	lwz 9,84(27)
	lwz 9,1788(9)
	cmpwi 0,9,0
	bc 12,2,.L1007
	lwz 4,40(9)
	addi 3,1,1032
	bl strcpy
	b .L1009
.L1007:
	lis 9,.LC257@ha
	la 11,.LC257@l(9)
	lwz 0,.LC257@l(9)
	lbz 10,4(11)
	stw 0,1032(1)
	stb 10,1036(1)
.L1009:
	addi 29,1,1032
	mr 3,31
	mr 4,29
	addi 30,30,1
	b .L1026
.L1011:
	addi 29,1,1032
	mr 3,27
	mr 4,29
	addi 30,30,1
	bl CTFSay_Team_Sight
.L1025:
	mr 3,31
	mr 4,29
.L1026:
	bl strcpy
	mr 3,29
.L1027:
	bl strlen
	add 31,31,3
	b .L983
.L1012:
	lbz 0,0(30)
	addi 30,30,1
	stb 0,0(31)
	b .L1028
.L986:
	stb 9,0(31)
	addi 30,30,1
.L1028:
	addi 31,31,1
.L983:
	lbz 9,0(30)
	cmpwi 0,9,0
	bc 12,2,.L982
	subf 0,24,31
	cmplwi 0,0,1022
	bc 4,1,.L984
.L982:
	lis 9,maxclients@ha
	li 0,0
	lwz 11,maxclients@l(9)
	li 30,0
	lis 9,.LC264@ha
	stb 0,0(31)
	la 9,.LC264@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,13,0
	bc 4,0,.L1017
	lis 9,.LC265@ha
	lis 26,g_edicts@ha
	la 9,.LC265@l(9)
	lis 28,.LC263@ha
	lfd 31,0(9)
	lis 29,0x4330
	li 31,1352
.L1019:
	lwz 0,g_edicts@l(26)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L1018
	lwz 9,84(3)
	lwz 6,84(27)
	lwz 11,3468(9)
	lwz 0,3468(6)
	cmpw 0,11,0
	bc 4,2,.L1018
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 4,2,.L1018
	addi 6,6,700
	li 4,3
	la 5,.LC263@l(28)
	addi 7,1,8
	crxor 6,6,6
	bl safe_cprintf
.L1018:
	addi 30,30,1
	lwz 11,maxclients@l(23)
	xoris 0,30,0x8000
	addi 31,31,1352
	stw 0,2076(1)
	stw 29,2072(1)
	lfd 0,2072(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L1019
.L1017:
	lwz 0,2132(1)
	mtlr 0
	lmw 23,2084(1)
	lfd 31,2120(1)
	la 1,2128(1)
	blr
.Lfe37:
	.size	 CTFSay_Team,.Lfe37-CTFSay_Team
	.section	".rodata"
	.align 2
.LC267:
	.string	"models/ctf/banner/tris.md2"
	.align 2
.LC269:
	.string	"models/ctf/banner/small.md2"
	.align 2
.LC271:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFJoinTeam
	.type	 CTFJoinTeam,@function
CTFJoinTeam:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 11,.LC271@ha
	lis 9,ctf@ha
	la 11,.LC271@l(11)
	mr 31,3
	lfs 13,0(11)
	mr 30,4
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L1034
	bl PMenu_Close
	lwz 0,184(31)
	li 10,0
	lis 4,.LC166@ha
	lwz 11,84(31)
	la 4,.LC166@l(4)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	stw 30,3468(11)
	lwz 9,84(31)
	stw 10,3472(9)
	lwz 3,84(31)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl CTFAssignSkin
	lwz 9,84(31)
	lwz 0,3468(9)
	addi 4,9,700
	cmpwi 0,0,1
	bc 12,2,.L1036
	cmpwi 0,0,2
	bc 12,2,.L1037
	b .L1040
.L1036:
	lis 9,.LC13@ha
	la 5,.LC13@l(9)
	b .L1039
.L1037:
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
	b .L1039
.L1040:
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
.L1039:
	lis 9,level+4@ha
	lis 3,gi@ha
	lfs 1,level+4@l(9)
	la 3,gi@l(3)
	bl sl_LogPlayerName
	mr 3,31
	bl PutClientInServer
	lwz 8,84(31)
	li 0,6
	li 11,32
	stw 0,80(31)
	li 10,14
	cmpwi 0,30,1
	stb 11,16(8)
	lwz 9,84(31)
	stb 10,17(9)
	lwz 11,84(31)
	addi 5,11,700
	bc 12,2,.L1041
	cmpwi 0,30,2
	bc 12,2,.L1042
	b .L1045
.L1041:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L1044
.L1042:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L1044
.L1045:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L1044:
	lis 4,.LC167@ha
	li 3,2
	la 4,.LC167@l(4)
	crxor 6,6,6
	bl my_bprintf
	lwz 9,84(31)
	li 0,1
	stw 0,3520(9)
.L1034:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe38:
	.size	 CTFJoinTeam,.Lfe38-CTFJoinTeam
	.globl creditsmenu
	.section	".data"
	.align 2
	.type	 creditsmenu,@object
creditsmenu:
	.long .LC272
	.long 1
	.long 0
	.long 0
	.long .LC273
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC274
	.long 1
	.long 0
	.long 0
	.long .LC275
	.long 1
	.long 0
	.long 0
	.long .LC276
	.long 1
	.long 0
	.long 0
	.long .LC277
	.long 1
	.long 0
	.long 0
	.long .LC278
	.long 1
	.long 0
	.long 0
	.long .LC275
	.long 1
	.long 0
	.long 0
	.long .LC279
	.long 1
	.long 0
	.long 0
	.long .LC280
	.long 1
	.long 0
	.long 0
	.long .LC281
	.long 1
	.long 0
	.long 0
	.long .LC282
	.long 1
	.long 0
	.long 0
	.long .LC283
	.long 1
	.long 0
	.long 0
	.long .LC284
	.long 1
	.long 0
	.long 0
	.long .LC285
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC286
	.long 0
	.long 0
	.long CTFReturnToMain
	.section	".rodata"
	.align 2
.LC286:
	.string	"Return to Main Menu"
	.align 2
.LC285:
	.string	"Brian 'Whaleboy' Cozzens"
	.align 2
.LC284:
	.string	"*Original CTF Art Design"
	.align 2
.LC283:
	.string	"Tom 'Bjorn' Klok"
	.align 2
.LC282:
	.string	"*Sound"
	.align 2
.LC281:
	.string	"Kevin Cloud"
	.align 2
.LC280:
	.string	"Adrian Carmack Paul Steed"
	.align 2
.LC279:
	.string	"*Art"
	.align 2
.LC278:
	.string	"Tim Willits"
	.align 2
.LC277:
	.string	"Christian Antkow"
	.align 2
.LC276:
	.string	"*Level Design"
	.align 2
.LC275:
	.string	"Dave 'Zoid' Kirsch"
	.align 2
.LC274:
	.string	"*Programming"
	.align 2
.LC273:
	.string	"*ThreeWave Capture the Flag"
	.align 2
.LC272:
	.string	"*Quake II"
	.size	 creditsmenu,288
	.globl joinmenu
	.section	".data"
	.align 2
	.type	 joinmenu,@object
joinmenu:
	.long .LC272
	.long 1
	.long 0
	.long 0
	.long .LC287
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC288
	.long 0
	.long 0
	.long CTFJoinTeam1
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC289
	.long 0
	.long 0
	.long CTFJoinTeam2
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC290
	.long 0
	.long 0
	.long CTFChaseCam
	.long .LC291
	.long 0
	.long 0
	.long CTFCredits
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC292
	.long 0
	.long 0
	.long 0
	.long .LC293
	.long 0
	.long 0
	.long 0
	.long .LC294
	.long 0
	.long 0
	.long 0
	.long .LC295
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC296
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC296:
	.string	"v1.02"
	.align 2
.LC295:
	.string	"(TAB to Return)"
	.align 2
.LC294:
	.string	"ESC to Exit Menu"
	.align 2
.LC293:
	.string	"ENTER to select"
	.align 2
.LC292:
	.string	"Use [ and ] to move cursor"
	.align 2
.LC291:
	.string	"Credits"
	.align 2
.LC290:
	.string	"Chase Camera"
	.align 2
.LC289:
	.string	"Join Blue Team"
	.align 2
.LC288:
	.string	"Join Red Team"
	.align 2
.LC287:
	.string	"*Keys2 - ThreeWave CTF"
	.size	 joinmenu,272
	.lcomm	levelname.246,32,4
	.lcomm	team1players.247,32,4
	.lcomm	team2players.248,32,4
	.align 2
.LC297:
	.string	"Leave Chase Camera"
	.align 2
.LC298:
	.string	"  (%d players)"
	.align 2
.LC299:
	.long 0x0
	.align 3
.LC300:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFUpdateJoinMenu
	.type	 CTFUpdateJoinMenu,@function
CTFUpdateJoinMenu:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,joinmenu@ha
	lis 11,.LC288@ha
	la 29,joinmenu@l(9)
	lis 10,CTFJoinTeam1@ha
	lis 9,.LC289@ha
	lis 8,CTFJoinTeam2@ha
	lis 30,ctf_forcejoin@ha
	la 11,.LC288@l(11)
	lwz 7,ctf_forcejoin@l(30)
	la 10,CTFJoinTeam1@l(10)
	la 9,.LC289@l(9)
	la 8,CTFJoinTeam2@l(8)
	stw 11,64(29)
	mr 31,3
	stw 10,76(29)
	stw 9,96(29)
	stw 8,108(29)
	lwz 3,4(7)
	cmpwi 0,3,0
	bc 12,2,.L1059
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L1059
	lis 4,.LC162@ha
	la 4,.LC162@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L1060
	stw 3,108(29)
	stw 3,96(29)
	b .L1059
.L1060:
	lwz 9,ctf_forcejoin@l(30)
	lis 4,.LC163@ha
	la 4,.LC163@l(4)
	lwz 3,4(9)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L1059
	stw 3,76(29)
	stw 3,64(29)
.L1059:
	lwz 9,84(31)
	lwz 0,3972(9)
	cmpwi 0,0,0
	bc 12,2,.L1063
	lis 9,.LC297@ha
	lis 11,joinmenu+128@ha
	la 9,.LC297@l(9)
	b .L1086
.L1063:
	lis 9,.LC290@ha
	lis 11,joinmenu+128@ha
	la 9,.LC290@l(9)
.L1086:
	stw 9,joinmenu+128@l(11)
	lis 9,g_edicts@ha
	lis 11,levelname.246@ha
	lwz 10,g_edicts@l(9)
	li 0,42
	la 3,levelname.246@l(11)
	stb 0,levelname.246@l(11)
	lwz 4,276(10)
	cmpwi 0,4,0
	bc 12,2,.L1065
	addi 3,3,1
	li 5,30
	bl strncpy
	b .L1066
.L1065:
	lis 4,level+72@ha
	addi 3,3,1
	la 4,level+72@l(4)
	li 5,30
	bl strncpy
.L1066:
	lis 9,maxclients@ha
	lis 11,levelname.246+31@ha
	lwz 10,maxclients@l(9)
	li 0,0
	lis 4,.LC299@ha
	la 4,.LC299@l(4)
	stb 0,levelname.246+31@l(11)
	li 31,0
	lfs 0,0(4)
	li 30,0
	li 7,0
	lfs 13,20(10)
	fcmpu 0,0,13
	bc 4,0,.L1068
	lis 9,g_edicts@ha
	fmr 12,13
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	la 5,game@l(11)
	lis 6,0x4330
	lis 9,.LC300@ha
	li 8,0
	la 9,.LC300@l(9)
	addi 10,10,1440
	lfd 13,0(9)
.L1070:
	lwz 0,0(10)
	addi 10,10,1352
	cmpwi 0,0,0
	bc 12,2,.L1069
	lwz 9,1028(5)
	add 9,8,9
	lwz 11,3468(9)
	cmpwi 0,11,1
	bc 4,2,.L1072
	addi 30,30,1
	b .L1069
.L1072:
	xori 11,11,2
	addi 9,31,1
	srawi 4,11,31
	xor 0,4,11
	subf 0,0,4
	srawi 0,0,31
	andc 9,9,0
	and 0,31,0
	or 31,0,9
.L1069:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,4088
	stw 0,28(1)
	stw 6,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L1070
.L1068:
	lis 29,.LC298@ha
	lis 3,team1players.247@ha
	la 4,.LC298@l(29)
	mr 5,30
	la 3,team1players.247@l(3)
	crxor 6,6,6
	bl sprintf
	lis 3,team2players.248@ha
	la 4,.LC298@l(29)
	la 3,team2players.248@l(3)
	mr 5,31
	crxor 6,6,6
	bl sprintf
	lis 11,joinmenu@ha
	lis 9,levelname.246@ha
	la 11,joinmenu@l(11)
	la 9,levelname.246@l(9)
	lwz 0,64(11)
	stw 9,32(11)
	cmpwi 0,0,0
	bc 12,2,.L1076
	lis 9,team1players.247@ha
	la 9,team1players.247@l(9)
	stw 9,80(11)
	b .L1077
.L1076:
	stw 0,80(11)
.L1077:
	lis 9,joinmenu@ha
	la 11,joinmenu@l(9)
	lwz 0,96(11)
	cmpwi 0,0,0
	bc 12,2,.L1078
	lis 9,team2players.248@ha
	la 9,team2players.248@l(9)
	stw 9,112(11)
	b .L1079
.L1078:
	stw 0,112(11)
.L1079:
	cmpw 0,30,31
	bc 12,1,.L1087
	cmpw 0,31,30
	bc 4,1,.L1081
.L1087:
	li 3,1
	b .L1085
.L1081:
	bl rand
	andi. 0,3,1
	mfcr 3
	rlwinm 3,3,3,1
	neg 3,3
	addi 0,3,1
	rlwinm 3,3,0,30,30
	or 3,3,0
.L1085:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe39:
	.size	 CTFUpdateJoinMenu,.Lfe39-CTFUpdateJoinMenu
	.section	".rodata"
	.align 2
.LC301:
	.string	"Capturelimit hit.\n"
	.align 2
.LC302:
	.long 0x0
	.align 3
.LC303:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFCheckRules
	.type	 CTFCheckRules,@function
CTFCheckRules:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC302@ha
	lis 9,capturelimit@ha
	la 11,.LC302@l(11)
	lfs 0,0(11)
	lwz 11,capturelimit@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L1099
	lis 9,ctfgame@ha
	lwz 0,ctfgame@l(9)
	la 8,ctfgame@l(9)
	lis 10,0x4330
	lis 9,.LC303@ha
	xoris 0,0,0x8000
	la 9,.LC303@l(9)
	stw 0,12(1)
	stw 10,8(1)
	lfd 12,0(9)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 12,3,.L1100
	lwz 0,4(8)
	mr 9,11
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 10,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L1099
.L1100:
	lis 4,.LC301@ha
	li 3,2
	la 4,.LC301@l(4)
	crxor 6,6,6
	bl my_bprintf
	li 3,1
	b .L1104
.L1099:
	lis 11,.LC302@ha
	lis 9,capturelimit@ha
	la 11,.LC302@l(11)
	lfs 0,0(11)
	lwz 11,capturelimit@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L1101
	lis 9,ctfgame@ha
	lwz 10,ctfgame@l(9)
	la 9,ctfgame@l(9)
	lwz 0,4(9)
	cmpw 0,10,0
	bc 12,0,.L1102
	lis 11,k2_capsleft@ha
	fctiwz 0,13
	stfd 0,8(1)
	lwz 9,12(1)
	subf 9,10,9
	b .L1105
.L1102:
	lis 11,k2_capsleft@ha
	fctiwz 0,13
	stfd 0,8(1)
	lwz 9,12(1)
	subf 9,0,9
.L1105:
	stw 9,k2_capsleft@l(11)
.L1101:
	li 3,0
.L1104:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe40:
	.size	 CTFCheckRules,.Lfe40-CTFCheckRules
	.section	".rodata"
	.align 2
.LC304:
	.string	"Couldn't find destination\n"
	.align 2
.LC305:
	.long 0x47800000
	.align 2
.LC306:
	.long 0x43b40000
	.align 2
.LC307:
	.long 0x43480000
	.section	".text"
	.align 2
	.type	 old_teleporter_touch,@function
old_teleporter_touch:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,4
	mr 29,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L1106
	lwz 5,296(29)
	li 3,0
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L1108
	lis 9,gi+4@ha
	lis 3,.LC304@ha
	lwz 0,gi+4@l(9)
	la 3,.LC304@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L1106
.L1108:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 12,2,.L1110
	lwz 3,3944(3)
	cmpwi 0,3,0
	bc 12,2,.L1110
	bl CTFResetGrapple
.L1110:
	lis 9,level@ha
	lwz 10,84(31)
	lwz 11,level@l(9)
	addi 11,11,1
	stw 11,4008(10)
	lwz 3,84(31)
	bl Is_Grappling
	cmpwi 0,3,0
	bc 12,2,.L1111
	lwz 9,84(31)
	lwz 3,3996(9)
	bl Release_Grapple
.L1111:
	lis 9,gi+76@ha
	mr 3,31
	lwz 0,gi+76@l(9)
	addi 28,31,376
	mtlr 0
	blrl
	lfs 0,4(30)
	lis 9,.LC305@ha
	lis 11,.LC306@ha
	la 9,.LC305@l(9)
	la 11,.LC306@l(11)
	lwz 8,84(31)
	li 0,0
	lfs 10,0(9)
	li 10,6
	stfs 0,4(31)
	li 9,20
	addi 5,30,16
	lfs 13,8(30)
	li 6,0
	li 7,0
	lfs 11,0(11)
	li 11,3
	stfs 13,8(31)
	mtctr 11
	lfs 0,12(30)
	stfs 0,12(31)
	lfs 13,4(30)
	stfs 13,28(31)
	lfs 0,8(30)
	stfs 0,32(31)
	lfs 13,12(30)
	stw 0,376(31)
	stw 0,384(31)
	stfs 13,36(31)
	stw 0,380(31)
	stb 9,17(8)
	lwz 11,84(31)
	lbz 0,16(11)
	ori 0,0,32
	stb 0,16(11)
	lwz 9,540(29)
	stw 10,80(9)
	stw 10,80(31)
.L1118:
	lwz 10,84(31)
	add 0,6,6
	lfsx 0,7,5
	addi 6,6,1
	addi 9,10,3496
	lfsx 13,9,7
	addi 10,10,20
	addi 7,7,4
	fsubs 0,0,13
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,24(1)
	lwz 11,28(1)
	sthx 11,10,0
	bdnz .L1118
	li 0,0
	lwz 11,84(31)
	addi 4,1,8
	stw 0,16(31)
	li 5,0
	li 6,0
	lfs 13,20(30)
	stw 0,24(31)
	stfs 13,20(31)
	lfs 0,16(30)
	stfs 0,28(11)
	lfs 0,20(30)
	lwz 9,84(31)
	stfs 0,32(9)
	lfs 0,24(30)
	lwz 11,84(31)
	stfs 0,36(11)
	lfs 0,16(30)
	lwz 9,84(31)
	stfs 0,3700(9)
	lfs 0,20(30)
	lwz 11,84(31)
	stfs 0,3704(11)
	lfs 13,24(30)
	lwz 9,84(31)
	stfs 13,3708(9)
	lwz 3,84(31)
	addi 3,3,3700
	bl AngleVectors
	lis 9,.LC307@ha
	addi 3,1,8
	la 9,.LC307@l(9)
	mr 4,28
	lfs 1,0(9)
	bl VectorScale
	mr 3,31
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L1106:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe41:
	.size	 old_teleporter_touch,.Lfe41-old_teleporter_touch
	.section	".rodata"
	.align 2
.LC308:
	.string	"teleporter without a target.\n"
	.align 2
.LC309:
	.string	"world/hum1.wav"
	.align 2
.LC310:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl SP_trigger_teleport
	.type	 SP_trigger_teleport,@function
SP_trigger_teleport:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L1120
	lis 9,gi+4@ha
	lis 3,.LC308@ha
	lwz 0,gi+4@l(9)
	la 3,.LC308@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L1119
.L1120:
	lwz 0,184(31)
	lis 9,old_teleporter_touch@ha
	li 11,1
	la 9,old_teleporter_touch@l(9)
	lis 29,gi@ha
	stw 11,248(31)
	ori 0,0,1
	la 29,gi@l(29)
	stw 9,444(31)
	stw 0,184(31)
	mr 3,31
	lwz 9,44(29)
	lwz 4,268(31)
	mtlr 9
	blrl
	lwz 0,72(29)
	mr 3,31
	mtlr 0
	blrl
	bl G_Spawn
	li 0,3
	lis 9,.LC310@ha
	mtctr 0
	la 9,.LC310@l(9)
	mr 30,3
	lfs 12,0(9)
	addi 8,31,200
	addi 10,31,188
	stw 30,540(31)
	addi 11,30,4
	li 9,0
.L1126:
	lfsx 13,9,10
	lfsx 0,9,8
	addi 9,9,4
	fsubs 0,0,13
	fmadds 0,0,12,13
	stfs 0,0(11)
	addi 11,11,4
	bdnz .L1126
	lis 29,gi@ha
	lis 3,.LC309@ha
	la 29,gi@l(29)
	la 3,.LC309@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,76(30)
	lwz 0,72(29)
	mr 3,30
	mtlr 0
	blrl
.L1119:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe42:
	.size	 SP_trigger_teleport,.Lfe42-SP_trigger_teleport
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.comm	last_trail_time,4,4
	.comm	bot_frametime,8,8
	.comm	max_bots,4,4
	.comm	last_bot_spawn,4,4
	.comm	bot_male_names_used,4,4
	.comm	bot_female_names_used,4,4
	.comm	bot_count,4,4
	.comm	bot_teams,256,4
	.comm	total_teams,4,4
	.comm	the_client,4,4
	.comm	num_players,4,4
	.comm	players,1024,4
	.comm	weapons_head,4,4
	.comm	health_head,4,4
	.comm	bonus_head,4,4
	.comm	ammo_head,4,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_supershotgun,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	botinfo_list,4,4
	.comm	total_bots,4,4
	.comm	teambot_list,4,4
	.comm	paused,4,4
	.comm	ctf,4,4
	.align 2
	.globl SP_info_player_team1
	.type	 SP_info_player_team1,@function
SP_info_player_team1:
	blr
.Lfe43:
	.size	 SP_info_player_team1,.Lfe43-SP_info_player_team1
	.align 2
	.globl SP_info_player_team2
	.type	 SP_info_player_team2,@function
SP_info_player_team2:
	blr
.Lfe44:
	.size	 SP_info_player_team2,.Lfe44-SP_info_player_team2
	.align 2
	.globl CTFTeamName
	.type	 CTFTeamName,@function
CTFTeamName:
	cmpwi 0,3,1
	bc 12,2,.L39
	cmpwi 0,3,2
	bc 12,2,.L40
	b .L38
.L39:
	lis 3,.LC13@ha
	la 3,.LC13@l(3)
	blr
.L40:
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	blr
.L38:
	lis 3,.LC15@ha
	la 3,.LC15@l(3)
	blr
.Lfe45:
	.size	 CTFTeamName,.Lfe45-CTFTeamName
	.align 2
	.globl CTFOtherTeamName
	.type	 CTFOtherTeamName,@function
CTFOtherTeamName:
	cmpwi 0,3,1
	bc 12,2,.L45
	cmpwi 0,3,2
	bc 12,2,.L46
	b .L44
.L45:
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	blr
.L46:
	lis 3,.LC13@ha
	la 3,.LC13@l(3)
	blr
.L44:
	lis 3,.LC15@ha
	la 3,.LC15@l(3)
	blr
.Lfe46:
	.size	 CTFOtherTeamName,.Lfe46-CTFOtherTeamName
	.align 2
	.globl CTFDrop_Flag
	.type	 CTFDrop_Flag,@function
CTFDrop_Flag:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl rand
	andi. 0,3,1
	bc 12,2,.L356
	lis 5,.LC67@ha
	mr 3,31
	la 5,.LC67@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L357
.L356:
	lis 5,.LC68@ha
	mr 3,31
	la 5,.LC68@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L357:
	li 3,0
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe47:
	.size	 CTFDrop_Flag,.Lfe47-CTFDrop_Flag
	.align 2
	.globl CTFID_f
	.type	 CTFID_f,@function
CTFID_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3492(9)
	cmpwi 0,0,0
	bc 12,2,.L516
	lis 5,.LC100@ha
	la 5,.LC100@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,0
	b .L1130
.L516:
	lis 5,.LC101@ha
	mr 3,31
	la 5,.LC101@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,1
.L1130:
	stw 0,3492(9)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe48:
	.size	 CTFID_f,.Lfe48-CTFID_f
	.align 2
	.globl CTFResetFlag
	.type	 CTFResetFlag,@function
CTFResetFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	cmpwi 0,3,1
	bc 12,2,.L188
	cmpwi 0,3,2
	bc 12,2,.L189
	b .L186
.L188:
	lis 9,.LC11@ha
	la 29,.LC11@l(9)
	b .L187
.L189:
	lis 9,.LC12@ha
	la 29,.LC12@l(9)
.L187:
	lis 9,gi@ha
	li 31,0
	la 28,gi@l(9)
	li 30,1
	b .L192
.L194:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L195
	mr 3,31
	bl RemoveFromItemList
	mr 3,31
	bl G_FreeEdict
	b .L192
.L195:
	lwz 0,184(31)
	mr 3,31
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(28)
	mtlr 9
	blrl
	stw 30,80(31)
.L192:
	mr 3,31
	li 4,280
	mr 5,29
	bl G_Find
	mr. 31,3
	bc 4,2,.L194
.L186:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe49:
	.size	 CTFResetFlag,.Lfe49-CTFResetFlag
	.align 2
	.globl CTFCheckHurtCarrier
	.type	 CTFCheckHurtCarrier,@function
CTFCheckHurtCarrier:
	lwz 9,84(3)
	cmpwi 0,9,0
	bclr 12,2
	lwz 0,84(4)
	cmpwi 0,0,0
	mr 8,0
	bclr 12,2
	lwz 0,3468(9)
	cmpwi 0,0,1
	bc 4,2,.L183
	lis 9,flag2_item@ha
	lwz 10,flag2_item@l(9)
	b .L184
.L183:
	lis 9,flag1_item@ha
	lwz 10,flag1_item@l(9)
.L184:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 3,84(3)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,10
	addi 11,3,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bclr 12,2
	lwz 9,3468(3)
	lwz 0,3468(8)
	cmpw 0,9,0
	bclr 12,2
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	stfs 0,3476(8)
	blr
.Lfe50:
	.size	 CTFCheckHurtCarrier,.Lfe50-CTFCheckHurtCarrier
	.align 2
	.globl CTFPlayerResetGrapple
	.type	 CTFPlayerResetGrapple,@function
CTFPlayerResetGrapple:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L590
	lwz 3,3944(3)
	cmpwi 0,3,0
	bc 12,2,.L590
	bl CTFResetGrapple
.L590:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe51:
	.size	 CTFPlayerResetGrapple,.Lfe51-CTFPlayerResetGrapple
	.align 2
	.globl CTFWhat_Tech
	.type	 CTFWhat_Tech,@function
CTFWhat_Tech:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,tnames@ha
	mr 29,3
	la 3,tnames@l(9)
	lwz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L777
	lis 9,itemlist@ha
	lis 31,0x286b
	la 28,itemlist@l(9)
	mr 30,3
	ori 31,31,51739
.L778:
	lwz 3,0(30)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L779
	subf 0,28,3
	lwz 11,84(29)
	mullw 0,0,31
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L1131
.L779:
	lwzu 0,4(30)
	cmpwi 0,0,0
	bc 4,2,.L778
.L777:
	li 3,0
.L1131:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe52:
	.size	 CTFWhat_Tech,.Lfe52-CTFWhat_Tech
	.section	".rodata"
	.align 2
.LC311:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl CTFDrop_Tech
	.type	 CTFDrop_Tech,@function
CTFDrop_Tech:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	mr 29,4
	bl Drop_Item
	lis 9,.LC311@ha
	lis 11,level+4@ha
	la 9,.LC311@l(9)
	lfs 0,level+4@l(11)
	lis 0,0x286b
	lfs 13,0(9)
	lis 11,itemlist@ha
	ori 0,0,51739
	lis 9,TechThink@ha
	la 11,itemlist@l(11)
	la 9,TechThink@l(9)
	subf 29,11,29
	fadds 0,0,13
	stw 9,436(3)
	mullw 29,29,0
	li 11,0
	rlwinm 29,29,0,0,29
	stfs 0,428(3)
	lwz 9,84(28)
	addi 9,9,740
	stwx 11,9,29
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe53:
	.size	 CTFDrop_Tech,.Lfe53-CTFDrop_Tech
	.section	".rodata"
	.align 2
.LC312:
	.long 0x0
	.align 2
.LC313:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl CTFSetupTechSpawn
	.type	 CTFSetupTechSpawn,@function
CTFSetupTechSpawn:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 9,.LC312@ha
	lis 11,ctf@ha
	la 9,.LC312@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L839
	lis 31,techspawn@ha
	lwz 0,techspawn@l(31)
	cmpwi 0,0,0
	bc 4,2,.L839
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 0,11,8
	bc 4,2,.L839
	bl G_Spawn
	lis 9,.LC313@ha
	lis 11,level+4@ha
	la 9,.LC313@l(9)
	lfs 0,level+4@l(11)
	li 0,1
	lfs 13,0(9)
	lis 9,SpawnTechs@ha
	la 9,SpawnTechs@l(9)
	fadds 0,0,13
	stw 9,436(3)
	stfs 0,428(3)
	stw 0,techspawn@l(31)
.L839:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe54:
	.size	 CTFSetupTechSpawn,.Lfe54-CTFSetupTechSpawn
	.align 2
	.globl CTFApplyStrength
	.type	 CTFApplyStrength,@function
CTFApplyStrength:
	lis 10,tech.174@ha
	lwz 0,tech.174@l(10)
	cmpwi 0,0,0
	bc 4,2,.L849
	lis 9,item_tech2@ha
	lwz 0,item_tech2@l(9)
	stw 0,tech.174@l(10)
.L849:
	cmpwi 0,4,0
	bc 12,2,.L850
	lwz 10,tech.174@l(10)
	cmpwi 0,10,0
	bc 12,2,.L850
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L850
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,10
	addi 11,3,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L850
	slwi 3,4,1
	blr
.L850:
	mr 3,4
	blr
.Lfe55:
	.size	 CTFApplyStrength,.Lfe55-CTFApplyStrength
	.section	".rodata"
	.align 2
.LC314:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFApplyHaste
	.type	 CTFApplyHaste,@function
CTFApplyHaste:
	lis 11,.LC314@ha
	lis 9,ctf@ha
	la 11,.LC314@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L862
	li 3,0
	blr
.L862:
	lis 11,tech.182@ha
	lwz 0,tech.182@l(11)
	cmpwi 0,0,0
	bc 4,2,.L1134
	lis 9,item_tech3@ha
	lwz 0,item_tech3@l(9)
	cmpwi 0,0,0
	stw 0,tech.182@l(11)
	bc 12,2,.L864
.L1134:
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L864
	lwz 0,tech.182@l(11)
	lis 9,itemlist@ha
	addi 10,3,740
	la 9,itemlist@l(9)
	lis 11,0x286b
	subf 0,9,0
	ori 11,11,51739
	mullw 0,0,11
	li 3,1
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bclr 4,2
.L864:
	li 3,0
	blr
.Lfe56:
	.size	 CTFApplyHaste,.Lfe56-CTFApplyHaste
	.align 2
	.globl CTFHasRegeneration
	.type	 CTFHasRegeneration,@function
CTFHasRegeneration:
	lis 11,tech.194@ha
	lwz 0,tech.194@l(11)
	cmpwi 0,0,0
	bc 4,2,.L1136
	lis 9,item_tech4@ha
	lwz 0,item_tech4@l(9)
	cmpwi 0,0,0
	stw 0,tech.194@l(11)
	bc 12,2,.L886
.L1136:
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L886
	lwz 0,tech.194@l(11)
	lis 9,itemlist@ha
	addi 10,3,740
	la 9,itemlist@l(9)
	lis 11,0x286b
	subf 0,9,0
	ori 11,11,51739
	mullw 0,0,11
	li 3,1
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bclr 4,2
.L886:
	li 3,0
	blr
.Lfe57:
	.size	 CTFHasRegeneration,.Lfe57-CTFHasRegeneration
	.align 2
	.globl CTFRespawnTech
	.type	 CTFRespawnTech,@function
CTFRespawnTech:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 30,0
	bl rand
	srawi 0,3,31
	srwi 0,0,28
	add 0,3,0
	rlwinm 0,0,0,0,27
	subf 31,0,3
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L836
	lis 28,.LC184@ha
.L835:
	mr 3,30
	li 4,280
	la 5,.LC184@l(28)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L835
.L836:
	cmpwi 0,30,0
	bc 4,2,.L1137
	lis 5,.LC184@ha
	li 3,0
	la 5,.LC184@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 12,2,.L832
.L1137:
	lwz 3,648(29)
	mr 4,30
	bl SpawnTech
.L832:
	mr 3,29
	bl RemoveFromItemList
	mr 3,29
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe58:
	.size	 CTFRespawnTech,.Lfe58-CTFRespawnTech
	.align 2
	.globl CTFOpenJoinMenu
	.type	 CTFOpenJoinMenu,@function
CTFOpenJoinMenu:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl CTFUpdateJoinMenu
	lwz 9,84(31)
	mr 5,3
	lwz 0,3972(9)
	cmpwi 0,0,0
	bc 12,2,.L1089
	li 5,8
	b .L1090
.L1089:
	xori 9,5,1
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	rlwinm 0,0,0,29,30
	ori 5,0,4
.L1090:
	lis 4,joinmenu@ha
	mr 3,31
	la 4,joinmenu@l(4)
	li 6,17
	bl PMenu_Open
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe59:
	.size	 CTFOpenJoinMenu,.Lfe59-CTFOpenJoinMenu
	.section	".rodata"
	.align 2
.LC315:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFStartClient
	.type	 CTFStartClient,@function
CTFStartClient:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 11,.LC315@ha
	lis 9,ctf@ha
	la 11,.LC315@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L1139
	lwz 8,84(31)
	lwz 0,3468(8)
	cmpwi 0,0,0
	bc 4,2,.L1139
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 10,11,0x2
	bc 12,2,.L1097
.L1139:
	li 3,0
	b .L1138
.L1097:
	lwz 0,184(31)
	li 9,1
	lis 11,gi+72@ha
	stw 9,260(31)
	mr 3,31
	ori 0,0,1
	stw 10,248(31)
	stw 0,184(31)
	stw 10,3468(8)
	lwz 9,84(31)
	stw 10,88(9)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	mr 3,31
	bl K2_OpenWelcomeMenu
	li 3,1
.L1138:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe60:
	.size	 CTFStartClient,.Lfe60-CTFStartClient
	.section	".rodata"
	.align 3
.LC316:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_ctf_banner
	.type	 SP_misc_ctf_banner,@function
SP_misc_ctf_banner:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	li 0,0
	lis 9,gi@ha
	stw 0,248(31)
	lis 3,.LC267@ha
	stw 0,260(31)
	la 30,gi@l(9)
	la 3,.LC267@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,284(31)
	stw 3,40(31)
	andi. 9,0,1
	bc 12,2,.L1031
	li 0,1
	stw 0,60(31)
.L1031:
	bl rand
	mr 9,3
	srawi 0,9,31
	mr 3,31
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	lis 9,misc_ctf_banner_think@ha
	lis 10,level+4@ha
	la 9,misc_ctf_banner_think@l(9)
	lis 11,.LC316@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC316@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe61:
	.size	 SP_misc_ctf_banner,.Lfe61-SP_misc_ctf_banner
	.section	".rodata"
	.align 3
.LC317:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_ctf_small_banner
	.type	 SP_misc_ctf_small_banner,@function
SP_misc_ctf_small_banner:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	li 0,0
	lis 9,gi@ha
	stw 0,248(31)
	lis 3,.LC269@ha
	stw 0,260(31)
	la 30,gi@l(9)
	la 3,.LC269@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,284(31)
	stw 3,40(31)
	andi. 9,0,1
	bc 12,2,.L1033
	li 0,1
	stw 0,60(31)
.L1033:
	bl rand
	mr 9,3
	srawi 0,9,31
	mr 3,31
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	lis 9,misc_ctf_banner_think@ha
	lis 10,level+4@ha
	la 9,misc_ctf_banner_think@l(9)
	lis 11,.LC317@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC317@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe62:
	.size	 SP_misc_ctf_small_banner,.Lfe62-SP_misc_ctf_small_banner
	.section	".rodata"
	.align 2
.LC318:
	.long 0x41800000
	.section	".text"
	.align 2
	.globl SP_info_teleport_destination
	.type	 SP_info_teleport_destination,@function
SP_info_teleport_destination:
	lis 9,.LC318@ha
	lfs 0,12(3)
	la 9,.LC318@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,12(3)
	blr
.Lfe63:
	.size	 SP_info_teleport_destination,.Lfe63-SP_info_teleport_destination
	.comm	PathToEnt_Node,4,4
	.comm	PathToEnt_TargetNode,4,4
	.comm	trail_head,4,4
	.comm	last_head,4,4
	.comm	dropped_trail,4,4
	.comm	last_optimize,4,4
	.comm	optimize_marker,4,4
	.comm	trail_portals,490000,4
	.comm	num_trail_portals,2500,4
	.comm	ctf_item_head,4,4
	.comm	spawn_bots,4,4
	.comm	roam_calls_this_frame,4,4
	.comm	bestdirection_callsthisframe,4,4
	.comm	bot_chat_text,2048,4
	.comm	bot_chat_count,32,4
	.comm	last_bot_chat,32,4
	.comm	num_view_weapons,4,4
	.comm	view_weapon_models,4096,1
	.comm	botdebug,4,4
	.comm	flag1_item,4,4
	.comm	flag2_item,4,4
	.comm	item_tech1,4,4
	.comm	item_tech2,4,4
	.comm	item_tech3,4,4
	.comm	item_tech4,4,4
	.comm	ctfgame,24,4
	.comm	ctf_forcejoin,4,4
	.align 2
	.globl CTFOtherTeam
	.type	 CTFOtherTeam,@function
CTFOtherTeam:
	cmpwi 0,3,1
	bc 12,2,.L51
	cmpwi 0,3,2
	bc 12,2,.L52
	b .L50
.L51:
	li 3,2
	blr
.L52:
	li 3,1
	blr
.L50:
	li 3,-1
	blr
.Lfe64:
	.size	 CTFOtherTeam,.Lfe64-CTFOtherTeam
	.section	".rodata"
	.align 2
.LC319:
	.long 0x41e00000
	.section	".text"
	.align 2
	.globl CTFDropFlagTouch
	.type	 CTFDropFlagTouch,@function
CTFDropFlagTouch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,256(3)
	cmpw 0,4,0
	bc 4,2,.L291
	lis 9,level+4@ha
	lfs 0,428(3)
	lis 11,.LC319@ha
	lfs 13,level+4@l(9)
	la 11,.LC319@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,1,.L290
.L291:
	bl Touch_Item
.L290:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe65:
	.size	 CTFDropFlagTouch,.Lfe65-CTFDropFlagTouch
	.comm	team1_rushbase_time,4,4
	.comm	team2_rushbase_time,4,4
	.comm	team1_defendbase_time,4,4
	.comm	team2_defendbase_time,4,4
	.align 2
	.globl KillGrappleSoundKiller
	.type	 KillGrappleSoundKiller,@function
KillGrappleSoundKiller:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lis 30,.LC120@ha
	li 3,0
.L595:
	li 4,280
	la 5,.LC120@l(30)
	bl G_Find
	mr. 3,3
	bc 12,2,.L593
	lwz 0,256(3)
	cmpw 0,0,31
	bc 4,2,.L595
	bl G_FreeEdict
.L593:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe66:
	.size	 KillGrappleSoundKiller,.Lfe66-KillGrappleSoundKiller
	.section	".rodata"
	.align 2
.LC320:
	.long 0x3f800000
	.align 2
.LC321:
	.long 0x0
	.section	".text"
	.align 2
	.globl KillGrappleSound
	.type	 KillGrappleSound,@function
KillGrappleSound:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 28,3
	la 29,gi@l(29)
	lis 3,.LC121@ha
	lwz 27,256(28)
	lwz 9,36(29)
	la 3,.LC121@l(3)
	mtlr 9
	blrl
	lis 9,.LC320@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC320@l(9)
	mr 3,27
	lfs 1,0(9)
	li 4,17
	mtlr 0
	lis 9,.LC320@ha
	la 9,.LC320@l(9)
	lfs 2,0(9)
	lis 9,.LC321@ha
	la 9,.LC321@l(9)
	lfs 3,0(9)
	blrl
	mr 3,28
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe67:
	.size	 KillGrappleSound,.Lfe67-KillGrappleSound
	.section	".rodata"
	.align 3
.LC322:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl SpawnGrappleSoundKiller
	.type	 SpawnGrappleSoundKiller,@function
SpawnGrappleSoundKiller:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lis 30,.LC120@ha
	li 3,0
.L599:
	li 4,280
	la 5,.LC120@l(30)
	bl G_Find
	mr. 3,3
	bc 12,2,.L602
	lwz 0,256(3)
	cmpw 0,0,31
	bc 4,2,.L599
	bl G_FreeEdict
.L602:
	bl G_Spawn
	lis 9,KillGrappleSound@ha
	la 0,.LC120@l(30)
	stw 31,256(3)
	la 9,KillGrappleSound@l(9)
	stw 0,280(3)
	lis 11,level+4@ha
	stw 9,436(3)
	lis 10,.LC322@ha
	lfs 0,level+4@l(11)
	la 10,.LC322@l(10)
	lfd 13,0(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe68:
	.size	 SpawnGrappleSoundKiller,.Lfe68-SpawnGrappleSoundKiller
	.align 2
	.globl CTFWeapon_Grapple_Fire
	.type	 CTFWeapon_Grapple_Fire,@function
CTFWeapon_Grapple_Fire:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 4,vec3_origin@ha
	la 4,vec3_origin@l(4)
	li 5,10
	li 6,0
	bl CTFGrappleFire
	lwz 11,84(29)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe69:
	.size	 CTFWeapon_Grapple_Fire,.Lfe69-CTFWeapon_Grapple_Fire
	.section	".rodata"
	.align 2
.LC323:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl CTFHasTech
	.type	 CTFHasTech,@function
CTFHasTech:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	lis 9,level@ha
	lwz 11,84(31)
	la 30,level@l(9)
	lfs 0,4(30)
	lis 9,.LC323@ha
	lfs 13,3968(11)
	la 9,.LC323@l(9)
	lfs 12,0(9)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L773
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L774
	lis 4,.LC181@ha
	la 4,.LC181@l(4)
	crxor 6,6,6
	bl safe_centerprintf
.L774:
	lfs 0,4(30)
	lwz 9,84(31)
	stfs 0,3968(9)
.L773:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe70:
	.size	 CTFHasTech,.Lfe70-CTFHasTech
	.section	".rodata"
	.align 2
.LC324:
	.long 0x42700000
	.section	".text"
	.align 2
	.type	 TechThink,@function
TechThink:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 30,0
	bl rand
	srawi 0,3,31
	srwi 0,0,28
	add 0,3,0
	rlwinm 0,0,0,0,27
	subf 31,0,3
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L800
	lis 28,.LC184@ha
.L799:
	mr 3,30
	li 4,280
	la 5,.LC184@l(28)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L799
.L800:
	cmpwi 0,30,0
	bc 4,2,.L1141
	lis 5,.LC184@ha
	li 3,0
	la 5,.LC184@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 12,2,.L796
.L1141:
	lwz 3,648(29)
	mr 4,30
	bl SpawnTech
	mr 3,29
	bl RemoveFromItemList
	mr 3,29
	bl G_FreeEdict
	b .L803
.L796:
	lis 9,.LC324@ha
	lis 11,level+4@ha
	la 9,.LC324@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,TechThink@ha
	la 9,TechThink@l(9)
	fadds 0,0,13
	stw 9,436(29)
	stfs 0,428(29)
.L803:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe71:
	.size	 TechThink,.Lfe71-TechThink
	.align 2
	.type	 SpawnTechs,@function
SpawnTechs:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 9,tnames@ha
	li 31,0
	la 9,tnames@l(9)
	lwzx 0,9,31
	cmpwi 0,0,0
	bc 12,2,.L821
	mr 26,9
	lis 25,.LC184@ha
.L822:
	slwi 0,31,2
	addi 27,31,1
	lwzx 3,26,0
	bl FindItemByClassname
	mr. 28,3
	bc 12,2,.L823
	bl rand
	li 30,0
	srawi 0,3,31
	srwi 0,0,28
	add 0,3,0
	rlwinm 0,0,0,0,27
	subf 31,0,3
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L827
	lis 29,.LC184@ha
.L826:
	mr 3,30
	li 4,280
	la 5,.LC184@l(29)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L826
.L827:
	cmpwi 0,30,0
	bc 4,2,.L1142
	li 3,0
	li 4,280
	la 5,.LC184@l(25)
	bl G_Find
	mr. 30,3
	bc 12,2,.L823
.L1142:
	mr 3,28
	mr 4,30
	bl SpawnTech
.L823:
	mr 31,27
	slwi 0,31,2
	lwzx 9,26,0
	cmpwi 0,9,0
	bc 4,2,.L822
.L821:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe72:
	.size	 SpawnTechs,.Lfe72-SpawnTechs
	.section	".rodata"
	.align 3
.LC325:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.type	 misc_ctf_banner_think,@function
misc_ctf_banner_think:
	lwz 9,56(3)
	lis 10,level+4@ha
	lis 11,.LC325@ha
	lfd 13,.LC325@l(11)
	addi 9,9,1
	srawi 0,9,31
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	stw 9,56(3)
	lfs 0,level+4@l(10)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe73:
	.size	 misc_ctf_banner_think,.Lfe73-misc_ctf_banner_think
	.align 2
	.globl CTFJoinTeam1
	.type	 CTFJoinTeam1,@function
CTFJoinTeam1:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,1
	bl CTFJoinTeam
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe74:
	.size	 CTFJoinTeam1,.Lfe74-CTFJoinTeam1
	.align 2
	.globl CTFJoinTeam2
	.type	 CTFJoinTeam2,@function
CTFJoinTeam2:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,2
	bl CTFJoinTeam
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe75:
	.size	 CTFJoinTeam2,.Lfe75-CTFJoinTeam2
	.section	".rodata"
	.align 2
.LC326:
	.long 0x3f800000
	.align 3
.LC327:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFChaseCam
	.type	 CTFChaseCam,@function
CTFChaseCam:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3972(9)
	cmpwi 0,0,0
	bc 12,2,.L1049
	li 0,0
	stw 0,3972(9)
	bl PMenu_Close
	b .L1048
.L1143:
	lwz 9,84(31)
	mr 3,31
	stw 11,3972(9)
	bl PMenu_Close
	lwz 9,84(31)
	li 0,1
	stw 0,3976(9)
	b .L1048
.L1049:
	lis 11,.LC326@ha
	lis 9,maxclients@ha
	la 11,.LC326@l(11)
	li 10,1
	lfs 0,0(11)
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L1048
	lis 9,g_edicts@ha
	fmr 12,13
	lis 8,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC327@ha
	la 9,.LC327@l(9)
	addi 11,11,1352
	lfd 13,0(9)
.L1053:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L1052
	lwz 0,248(11)
	cmpwi 0,0,0
	bc 12,2,.L1052
	lwz 0,968(11)
	cmpwi 0,0,0
	bc 12,2,.L1143
.L1052:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,1352
	stw 0,20(1)
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L1053
.L1048:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe76:
	.size	 CTFChaseCam,.Lfe76-CTFChaseCam
	.align 2
	.globl CTFReturnToMain
	.type	 CTFReturnToMain,@function
CTFReturnToMain:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	mr 3,29
	bl CTFOpenJoinMenu
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe77:
	.size	 CTFReturnToMain,.Lfe77-CTFReturnToMain
	.align 2
	.globl CTFCredits
	.type	 CTFCredits,@function
CTFCredits:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lis 4,creditsmenu@ha
	mr 3,29
	la 4,creditsmenu@l(4)
	li 5,-1
	li 6,18
	bl PMenu_Open
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe78:
	.size	 CTFCredits,.Lfe78-CTFCredits
	.align 2
	.globl CTFShowScores
	.type	 CTFShowScores,@function
CTFShowScores:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl PMenu_Close
	lwz 11,84(29)
	li 0,1
	li 10,0
	mr 3,29
	stw 0,3552(11)
	lwz 9,84(29)
	stw 10,3564(9)
	bl DeathmatchScoreboard
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe79:
	.size	 CTFShowScores,.Lfe79-CTFShowScores
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
