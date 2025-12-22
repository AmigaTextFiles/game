	.file	"g_ctf.c"
gcc2_compiled.:
	.globl techspawn
	.section	".sdata","aw"
	.align 2
	.type	 techspawn,@object
	.size	 techspawn,4
techspawn:
	.long 0
	.globl ctf_statusbar
	.section	".rodata"
	.align 2
.LC0:
	.ascii	"yb\t-24 xv\t0 hnum xv\t50 pic 0 if 2 \txv\t100 \tanum \txv\t"
	.ascii	"150 \tpic 2 endif if 4 \txv\t200 \trnum \txv\t250 \tpic 4 en"
	.ascii	"dif if 6 \txv\t296 \tpic 6 endif yb\t-50 if 7 \txv\t0 \tpic "
	.ascii	"7 \txv\t26 \tyb\t-42 \tstat_string 8 \tyb\t-50 endif if 9 xv"
	.ascii	" 246 num 2 10 xv 296 pic 9 endif if 11 xv 148 pic 11 endif x"
	.ascii	"r\t-50 yt 2 num 3 14 yb -129 if 26 xr -26 pic 26 endif yb -"
	.string	"102 if 17 xr -26 pic 17 endif xr -62 num 2 18 if 22 yb -104 xr -28 pic 22 endif yb -75 if 19 xr -26 pic 19 endif xr -62 num 2 20 if 23 yb -77 xr -28 pic 23 endif if 21 yt 26 xr -24 pic 21 endif if 27 xv 0 yb -58 string \"Viewing\" xv 64 stat_string 27 endif "
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
	bc 4,2,.L24
	b .L34
.L33:
	li 3,1
	b .L32
.L24:
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
.L29:
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
	bc 12,2,.L33
	addi 31,31,12
	cmpw 0,31,29
	bc 4,1,.L29
.L34:
	li 3,0
.L32:
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
	.string	"1"
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
	.align 2
.LC13:
	.string	"RED"
	.align 2
.LC14:
	.string	"BLUE"
	.align 2
.LC15:
	.string	"UKNOWN"
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
	.section	".text"
	.align 2
	.globl CTFAssignSkin
	.type	 CTFAssignSkin,@function
CTFAssignSkin:
	stwu 1,-96(1)
	mflr 0
	stmw 29,84(1)
	stw 0,100(1)
	lis 11,g_edicts@ha
	mr 29,3
	lwz 9,g_edicts@l(11)
	lis 0,0x46fd
	mr 30,4
	ori 0,0,55623
	lis 5,.LC16@ha
	subf 9,9,29
	addi 3,1,8
	mullw 9,9,0
	la 5,.LC16@l(5)
	li 4,64
	mr 6,30
	srawi 9,9,3
	addi 31,9,-1
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
	lwz 3,3452(9)
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
	b .L59
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
.L59:
	lwz 0,100(1)
	mtlr 0
	lmw 29,84(1)
	la 1,96(1)
	blr
.Lfe2:
	.size	 CTFAssignSkin,.Lfe2-CTFAssignSkin
	.section	".rodata"
	.align 2
.LC22:
	.long 0x3f800000
	.align 3
.LC23:
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
	lis 9,dmflags@ha
	mr 31,3
	lwz 11,dmflags@l(9)
	li 7,0
	li 8,0
	stw 7,3456(31)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andis. 0,9,2
	bc 4,2,.L66
	stw 8,3452(31)
	b .L65
.L66:
	lis 11,.LC22@ha
	lis 9,maxclients@ha
	la 11,.LC22@l(11)
	li 10,1
	lfs 0,0(11)
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L79
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC23@ha
	la 9,.LC23@l(9)
	addi 11,11,952
	lfd 13,0(9)
.L70:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L69
	lwz 9,84(11)
	cmpw 0,9,31
	bc 12,2,.L69
	lwz 0,3452(9)
	cmpwi 0,0,1
	bc 12,2,.L74
	cmpwi 0,0,2
	bc 12,2,.L75
	b .L69
.L74:
	addi 7,7,1
	b .L69
.L75:
	addi 8,8,1
.L69:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,952
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L70
.L79:
	cmpw 0,8,7
	bc 12,0,.L83
	bl rand
	andi. 0,3,1
	li 0,1
	bc 4,2,.L85
.L83:
	li 0,2
.L85:
	stw 0,3452(31)
.L65:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 CTFAssignTeam,.Lfe3-CTFAssignTeam
	.section	".rodata"
	.align 2
.LC24:
	.string	"info_player_team1"
	.align 2
.LC25:
	.string	"info_player_team2"
	.align 2
.LC26:
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
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 12,2,.L87
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,512
	bc 12,2,.L111
	bl SelectFarthestDeathmatchSpawnPoint
	b .L110
.L87:
	li 0,1
	stw 0,3456(9)
	lwz 9,84(3)
	lwz 3,3452(9)
	cmpwi 0,3,1
	bc 12,2,.L91
	cmpwi 0,3,2
	bc 12,2,.L92
	b .L111
.L91:
	lis 9,.LC24@ha
	la 27,.LC24@l(9)
	b .L90
.L92:
	lis 9,.LC25@ha
	la 27,.LC25@l(9)
.L90:
	lis 9,.LC26@ha
	li 30,0
	lfs 31,.LC26@l(9)
	li 28,0
	li 29,0
	fmr 30,31
	b .L95
.L97:
	mr 3,30
	addi 31,31,1
	bl PlayersRangeFromSpot
	fcmpu 0,1,30
	bc 4,0,.L98
	fmr 30,1
	mr 29,30
	b .L95
.L98:
	fcmpu 0,1,31
	bc 4,0,.L95
	fmr 31,1
	mr 28,30
.L95:
	mr 3,30
	li 4,280
	mr 5,27
	bl G_Find
	mr. 30,3
	bc 4,2,.L97
	cmpwi 0,31,0
	bc 4,2,.L102
.L111:
	bl SelectRandomDeathmatchSpawnPoint
	b .L110
.L102:
	cmpwi 0,31,2
	bc 12,1,.L103
	li 28,0
	li 29,0
	b .L104
.L103:
	addi 31,31,-2
.L104:
	bl rand
	li 30,0
	divw 0,3,31
	mullw 0,0,31
	subf 31,0,3
.L109:
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
	bc 4,2,.L109
.L110:
	lwz 0,68(1)
	mtlr 0
	lmw 27,28(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 SelectCTFSpawnPoint,.Lfe4-SelectCTFSpawnPoint
	.section	".rodata"
	.align 2
.LC27:
	.string	"BONUS: %d points for fragging enemy flag carrier.\n"
	.align 2
.LC28:
	.string	"%s defends %s's flag carrier against an agressive enemy\n"
	.align 2
.LC29:
	.string	"%s defends the %s base.\n"
	.align 2
.LC30:
	.string	"%s defends the %s flag.\n"
	.align 2
.LC31:
	.string	"%s defends the %s's flag carrier.\n"
	.align 2
.LC32:
	.long 0x3f800000
	.align 3
.LC33:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC34:
	.long 0x0
	.align 2
.LC35:
	.long 0x41000000
	.align 2
.LC36:
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
	mr 27,3
	mr 30,5
	lwz 11,84(27)
	cmpwi 0,11,0
	bc 12,2,.L112
	lwz 0,84(30)
	xor 9,27,30
	subfic 10,9,0
	adde 9,10,9
	mr 8,0
	subfic 10,0,0
	adde 0,10,0
	or. 10,0,9
	bc 4,2,.L112
	lwz 0,3452(11)
	cmpwi 0,0,1
	bc 12,2,.L115
	cmpwi 0,0,2
	bc 12,2,.L116
	b .L119
.L115:
	li 29,2
	b .L118
.L116:
	li 29,1
	b .L118
.L119:
	li 29,-1
.L118:
	cmpwi 0,29,0
	bc 12,0,.L112
	lwz 9,84(27)
	lwz 0,3452(9)
	mr 7,9
	cmpwi 0,0,1
	bc 4,2,.L121
	lis 9,flag1_item@ha
	lis 11,flag2_item@ha
	lwz 26,flag1_item@l(9)
	lwz 0,flag2_item@l(11)
	b .L122
.L121:
	lis 9,flag2_item@ha
	lis 11,flag1_item@ha
	lwz 26,flag2_item@l(9)
	lwz 0,flag1_item@l(11)
.L122:
	lis 9,itemlist@ha
	lis 10,0x286b
	la 6,itemlist@l(9)
	ori 10,10,51739
	subf 0,6,0
	addi 11,7,740
	mullw 0,0,10
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L123
	lis 9,level+4@ha
	lis 5,.LC27@ha
	lfs 0,level+4@l(9)
	mr 3,30
	la 5,.LC27@l(5)
	li 4,1
	li 6,2
	stfs 0,3472(8)
	lwz 11,84(30)
	lwz 9,3448(11)
	addi 9,9,2
	stw 9,3448(11)
	crxor 6,6,6
	bl safe_cprintf
	lis 9,maxclients@ha
	lis 10,.LC32@ha
	lwz 11,maxclients@l(9)
	la 10,.LC32@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	li 10,1
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L112
	lis 9,g_edicts@ha
	mr 8,11
	lwz 11,g_edicts@l(9)
	li 6,0
	lis 7,0x4330
	lis 9,.LC33@ha
	la 9,.LC33@l(9)
	addi 11,11,952
	lfd 12,0(9)
.L127:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L126
	lwz 9,84(11)
	lwz 0,3452(9)
	cmpw 0,0,29
	bc 4,2,.L126
	stw 6,3460(9)
.L126:
	addi 10,10,1
	lfs 13,20(8)
	xoris 0,10,0x8000
	addi 11,11,952
	stw 0,44(1)
	stw 7,40(1)
	lfd 0,40(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L127
	b .L112
.L123:
	lis 11,.LC34@ha
	lfs 12,3460(7)
	la 11,.LC34@l(11)
	lfs 0,0(11)
	fcmpu 0,12,0
	bc 12,2,.L130
	lis 9,level+4@ha
	lis 11,.LC35@ha
	lfs 0,level+4@l(9)
	la 11,.LC35@l(11)
	lfs 13,0(11)
	fsubs 0,0,12
	fcmpu 0,0,13
	bc 4,0,.L130
	subf 0,6,26
	addi 11,8,740
	mullw 0,0,10
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L130
	lwz 9,3448(8)
	addi 9,9,2
	stw 9,3448(8)
	lwz 11,84(30)
	lwz 0,3452(11)
	addi 5,11,700
	cmpwi 0,0,1
	bc 12,2,.L131
	cmpwi 0,0,2
	bc 12,2,.L132
	b .L135
.L131:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L134
.L132:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L134
.L135:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L134:
	lis 4,.LC28@ha
	li 3,1
	la 4,.LC28@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L112
.L130:
	lwz 0,3452(8)
	cmpwi 0,0,1
	bc 12,2,.L137
	cmpwi 0,0,2
	bc 12,2,.L138
	b .L112
.L137:
	lis 9,.LC11@ha
	la 28,.LC11@l(9)
	b .L136
.L138:
	lis 9,.LC12@ha
	la 28,.LC12@l(9)
.L136:
	li 29,0
.L144:
	mr 3,29
	li 4,280
	mr 5,28
	bl G_Find
	mr. 29,3
	mcrf 7,0
	bc 12,30,.L112
	lwz 0,284(29)
	andis. 9,0,1
	bc 4,2,.L144
	bc 12,30,.L112
	lis 9,maxclients@ha
	lis 10,.LC32@ha
	lfs 11,4(27)
	lwz 11,maxclients@l(9)
	la 10,.LC32@l(10)
	lfs 0,0(10)
	lfs 13,20(11)
	li 10,1
	lfs 10,4(29)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L147
	lis 11,g_edicts@ha
	lis 9,itemlist@ha
	fmr 12,13
	lis 0,0x286b
	la 9,itemlist@l(9)
	lwz 7,g_edicts@l(11)
	ori 0,0,51739
	subf 9,9,26
	lis 11,.LC33@ha
	mullw 9,9,0
	lis 6,0x4330
	la 11,.LC33@l(11)
	lfd 13,0(11)
	rlwinm 8,9,0,0,29
	li 11,952
.L149:
	add 31,7,11
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L150
	lwz 9,84(31)
	addi 9,9,740
	lwzx 0,9,8
	cmpwi 0,0,0
	bc 4,2,.L147
.L150:
	addi 10,10,1
	xoris 0,10,0x8000
	li 31,0
	stw 0,44(1)
	addi 11,11,952
	stw 6,40(1)
	lfd 0,40(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L149
.L147:
	fsubs 10,11,10
	lfs 13,8(27)
	lis 9,.LC36@ha
	addi 3,1,8
	lfs 12,12(27)
	la 9,.LC36@l(9)
	lfs 11,4(30)
	stfs 10,8(1)
	lfs 0,8(29)
	lfs 10,8(30)
	lfs 9,12(30)
	fsubs 13,13,0
	lfs 31,0(9)
	stfs 13,12(1)
	lfs 0,12(29)
	fsubs 12,12,0
	stfs 12,16(1)
	lfs 0,4(29)
	fsubs 11,11,0
	stfs 11,24(1)
	lfs 0,8(29)
	fsubs 10,10,0
	stfs 10,28(1)
	lfs 0,12(29)
	fsubs 9,9,0
	stfs 9,32(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L153
	addi 28,1,24
	mr 3,28
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L153
	mr 3,29
	mr 4,27
	bl loc_CanSee
	cmpwi 0,3,0
	bc 4,2,.L153
	mr 3,29
	mr 4,30
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L152
.L153:
	lwz 9,84(30)
	lwz 11,3448(9)
	addi 11,11,1
	stw 11,3448(9)
	lwz 0,248(29)
	cmpwi 0,0,0
	bc 4,2,.L154
	lwz 9,84(30)
	lwz 0,3452(9)
	addi 5,9,700
	cmpwi 0,0,1
	bc 12,2,.L155
	cmpwi 0,0,2
	bc 12,2,.L156
	b .L159
.L155:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L158
.L156:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L158
.L159:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L158:
	lis 4,.LC29@ha
	li 3,1
	la 4,.LC29@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L112
.L154:
	lwz 9,84(30)
	lwz 0,3452(9)
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
	lis 4,.LC30@ha
	li 3,1
	la 4,.LC30@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L112
.L152:
	xor 0,31,30
	addic 9,31,-1
	subfe 11,9,31
	addic 10,0,-1
	subfe 9,10,0
	and. 0,11,9
	bc 12,2,.L112
	lfs 13,4(31)
	addi 3,1,8
	lfs 0,4(27)
	lfs 12,8(27)
	lfs 11,12(27)
	fsubs 0,0,13
	lfs 10,4(30)
	lfs 9,8(30)
	stfs 0,8(1)
	lfs 13,8(31)
	lfs 8,12(30)
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
	bc 12,0,.L168
	mr 3,28
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L168
	mr 4,27
	mr 3,31
	bl loc_CanSee
	cmpwi 0,3,0
	bc 4,2,.L168
	mr 3,31
	mr 4,30
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L112
.L168:
	lwz 9,84(30)
	lwz 11,3448(9)
	addi 11,11,1
	stw 11,3448(9)
	lwz 10,84(30)
	lwz 0,3452(10)
	addi 5,10,700
	cmpwi 0,0,1
	bc 12,2,.L169
	cmpwi 0,0,2
	bc 12,2,.L170
	b .L173
.L169:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L172
.L170:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L172
.L173:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L172:
	lis 4,.LC31@ha
	li 3,1
	la 4,.LC31@l(4)
	crxor 6,6,6
	bl safe_bprintf
.L112:
	lwz 0,84(1)
	mtlr 0
	lmw 26,48(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe5:
	.size	 CTFFragBonuses,.Lfe5-CTFFragBonuses
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
	b .L198
.L200:
	lwz 0,284(31)
	andis. 11,0,1
	bc 12,2,.L201
	mr 3,31
	bl G_FreeEdict
	b .L198
.L201:
	lwz 0,184(31)
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	stw 30,80(31)
.L198:
	mr 3,31
	li 4,280
	mr 5,29
	li 30,1
	bl G_Find
	mr. 31,3
	lis 9,gi+72@ha
	mr 3,31
	bc 4,2,.L200
	lis 9,.LC12@ha
	lis 11,gi@ha
	la 28,.LC12@l(9)
	la 29,gi@l(11)
	li 31,0
	b .L209
.L211:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L212
	mr 3,31
	bl G_FreeEdict
	b .L209
.L212:
	lwz 0,184(31)
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(29)
	mtlr 9
	blrl
	stw 30,80(31)
.L209:
	mr 3,31
	li 4,280
	mr 5,28
	bl G_Find
	mr. 31,3
	mr 3,31
	bc 4,2,.L211
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 CTFResetFlags,.Lfe6-CTFResetFlags
	.section	".rodata"
	.align 2
.LC37:
	.string	"Don't know what team the flag is on.\n"
	.align 2
.LC38:
	.string	"%s captured the %s flag!\n"
	.align 2
.LC39:
	.string	"ctf/flagcap.wav"
	.align 2
.LC40:
	.string	"%s gets an assist for returning the flag!\n"
	.align 2
.LC41:
	.string	"%s gets an assist for fragging the flag carrier!\n"
	.align 2
.LC42:
	.string	"%s returned the %s flag!\n"
	.align 2
.LC43:
	.string	"ctf/flagret.wav"
	.align 2
.LC44:
	.string	"%s got the %s flag!\n"
	.align 2
.LC45:
	.long 0x3f800000
	.align 2
.LC46:
	.long 0x0
	.align 3
.LC47:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC48:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl CTFPickup_Flag
	.type	 CTFPickup_Flag,@function
CTFPickup_Flag:
	stwu 1,-96(1)
	mflr 0
	mfcr 12
	stfd 30,80(1)
	stfd 31,88(1)
	stmw 20,32(1)
	stw 0,100(1)
	stw 12,28(1)
	mr 30,4
	mr 31,3
	lwz 3,280(31)
	lis 4,.LC11@ha
	la 4,.LC11@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L216
	li 28,1
	b .L217
.L216:
	lwz 3,280(31)
	lis 4,.LC12@ha
	la 4,.LC12@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L218
	lis 5,.LC37@ha
	mr 3,31
	la 5,.LC37@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L269:
	li 3,0
	b .L266
.L218:
	li 28,2
.L217:
	cmpwi 4,28,1
	bc 4,18,.L220
	lis 9,flag1_item@ha
	lis 11,flag2_item@ha
	lwz 27,flag1_item@l(9)
	lwz 29,flag2_item@l(11)
	b .L221
.L220:
	lis 9,flag2_item@ha
	lis 11,flag1_item@ha
	lwz 27,flag2_item@l(9)
	lwz 29,flag1_item@l(11)
.L221:
	lwz 5,84(30)
	lwz 0,3452(5)
	cmpw 0,28,0
	bc 4,2,.L222
	lwz 0,284(31)
	andis. 9,0,1
	bc 4,2,.L223
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,29
	addi 11,5,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L269
	addi 5,5,700
	bc 12,18,.L225
	cmpwi 0,28,2
	bc 12,2,.L226
	b .L229
.L225:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L228
.L226:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L228
.L229:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L228:
	lis 4,.LC38@ha
	li 3,2
	la 4,.LC38@l(4)
	lis 20,level@ha
	crxor 6,6,6
	bl safe_bprintf
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,29
	addi 11,11,740
	mullw 9,9,0
	li 10,0
	lis 8,level+4@ha
	lis 6,ctfgame@ha
	rlwinm 9,9,0,0,29
	la 7,ctfgame@l(6)
	stwx 10,11,9
	lfs 0,level+4@l(8)
	stw 28,20(7)
	stfs 0,16(7)
	bc 4,18,.L230
	lwz 9,ctfgame@l(6)
	addi 9,9,1
	stw 9,ctfgame@l(6)
	b .L231
.L230:
	lwz 9,4(7)
	addi 9,9,1
	stw 9,4(7)
.L231:
	lis 29,gi@ha
	lis 3,.LC39@ha
	la 29,gi@l(29)
	la 3,.LC39@l(3)
	lwz 9,36(29)
	li 27,1
	lis 21,maxclients@ha
	mtlr 9
	blrl
	lis 9,.LC45@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC45@l(9)
	li 4,26
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 2,0(9)
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 3,0(9)
	blrl
	lis 9,.LC45@ha
	lwz 10,84(30)
	lis 11,maxclients@ha
	la 9,.LC45@l(9)
	lwz 8,maxclients@l(11)
	lfs 13,0(9)
	lwz 9,3448(10)
	addi 9,9,15
	stw 9,3448(10)
	lfs 0,20(8)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L233
	lis 9,.LC47@ha
	lis 22,g_edicts@ha
	la 9,.LC47@l(9)
	lis 23,0xc0a0
	lfd 30,0(9)
	lis 24,0x4330
	li 28,952
	lis 25,.LC40@ha
	lis 26,.LC41@ha
.L235:
	lwz 0,g_edicts@l(22)
	add 29,0,28
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L234
	lwz 10,84(29)
	lwz 9,84(30)
	lwz 11,3452(10)
	lwz 0,3452(9)
	cmpw 0,11,0
	bc 12,2,.L267
	stw 23,3460(10)
	b .L234
.L267:
	cmpw 0,29,30
	bc 12,2,.L240
	lwz 9,3448(10)
	addi 9,9,10
	stw 9,3448(10)
.L240:
	lwz 5,84(29)
	lis 9,.LC48@ha
	la 31,level@l(20)
	la 9,.LC48@l(9)
	lfs 13,4(31)
	lfs 31,0(9)
	lfs 0,3464(5)
	fadds 0,0,31
	fcmpu 0,0,13
	bc 4,1,.L241
	addi 5,5,700
	li 3,2
	la 4,.LC40@l(25)
	crxor 6,6,6
	bl safe_bprintf
	lwz 11,84(29)
	lwz 9,3448(11)
	addi 9,9,1
	stw 9,3448(11)
.L241:
	lwz 5,84(29)
	lfs 13,4(31)
	lfs 0,3472(5)
	fadds 0,0,31
	fcmpu 0,0,13
	bc 4,1,.L234
	addi 5,5,700
	li 3,2
	la 4,.LC41@l(26)
	crxor 6,6,6
	bl safe_bprintf
	lwz 11,84(29)
	lwz 9,3448(11)
	addi 9,9,2
	stw 9,3448(11)
.L234:
	addi 27,27,1
	lwz 11,maxclients@l(21)
	xoris 0,27,0x8000
	addi 28,28,952
	stw 0,20(1)
	stw 24,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L235
.L233:
	bl CTFResetFlags
	b .L269
.L223:
	addi 5,5,700
	bc 12,18,.L244
	cmpwi 0,28,2
	bc 12,2,.L245
	b .L248
.L244:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L247
.L245:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L247
.L248:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L247:
	lis 4,.LC42@ha
	li 3,2
	la 4,.LC42@l(4)
	crxor 6,6,6
	bl safe_bprintf
	lwz 10,84(30)
	lis 8,level+4@ha
	lis 29,gi@ha
	la 29,gi@l(29)
	lis 3,.LC43@ha
	lwz 9,3448(10)
	la 3,.LC43@l(3)
	addi 9,9,1
	stw 9,3448(10)
	lfs 0,level+4@l(8)
	lwz 11,84(30)
	stfs 0,3464(11)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC45@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC45@l(9)
	li 4,26
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 2,0(9)
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfs 3,0(9)
	blrl
	bc 12,18,.L249
	cmpwi 0,28,2
	bc 12,2,.L250
	b .L269
.L249:
	lis 9,.LC11@ha
	la 30,.LC11@l(9)
	b .L252
.L250:
	lis 9,.LC12@ha
	la 30,.LC12@l(9)
.L252:
	lis 9,gi@ha
	li 29,0
	la 28,gi@l(9)
	li 31,1
	b .L254
.L256:
	lwz 0,284(29)
	andis. 9,0,1
	bc 12,2,.L257
	mr 3,29
	bl G_FreeEdict
	b .L254
.L257:
	lwz 0,184(29)
	mr 3,29
	stw 31,248(29)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	lwz 9,72(28)
	mtlr 9
	blrl
	stw 31,80(29)
.L254:
	mr 3,29
	li 4,280
	mr 5,30
	bl G_Find
	mr. 29,3
	bc 4,2,.L256
	b .L269
.L222:
	addi 5,5,700
	bc 12,18,.L260
	cmpwi 0,28,2
	bc 12,2,.L261
	b .L264
.L260:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L263
.L261:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L263
.L264:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L263:
	lis 4,.LC44@ha
	li 3,2
	la 4,.LC44@l(4)
	crxor 6,6,6
	bl safe_bprintf
	lis 11,itemlist@ha
	lis 0,0x286b
	lwz 8,84(30)
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 11,11,27
	mr 9,8
	mullw 11,11,0
	li 7,1
	addi 9,9,740
	lis 6,level+4@ha
	rlwinm 11,11,0,0,29
	stwx 7,9,11
	lfs 0,level+4@l(6)
	lwz 10,84(30)
	stfs 0,3468(10)
	lwz 0,284(31)
	andis. 11,0,0x1
	bc 4,2,.L265
	lwz 0,264(31)
	lwz 9,184(31)
	oris 0,0,0x8000
	stw 11,248(31)
	ori 9,9,1
	stw 0,264(31)
	stw 9,184(31)
.L265:
	li 3,1
.L266:
	lwz 0,100(1)
	lwz 12,28(1)
	mtlr 0
	lmw 20,32(1)
	lfd 30,80(1)
	lfd 31,88(1)
	mtcrf 8,12
	la 1,96(1)
	blr
.Lfe7:
	.size	 CTFPickup_Flag,.Lfe7-CTFPickup_Flag
	.section	".rodata"
	.align 2
.LC49:
	.string	"The %s flag has returned!\n"
	.section	".text"
	.align 2
	.type	 CTFDropFlagThink,@function
CTFDropFlagThink:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lis 29,.LC11@ha
	lwz 3,280(31)
	la 4,.LC11@l(29)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L273
	la 30,.LC11@l(29)
	li 31,0
	b .L279
.L281:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L282
	mr 3,31
	bl G_FreeEdict
	b .L279
.L282:
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
.L279:
	mr 3,31
	li 4,280
	mr 5,30
	bl G_Find
	mr. 31,3
	bc 4,2,.L281
	lis 5,.LC13@ha
	lis 4,.LC49@ha
	la 4,.LC49@l(4)
	la 5,.LC13@l(5)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
	b .L290
.L273:
	lwz 3,280(31)
	lis 31,.LC12@ha
	la 4,.LC12@l(31)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L290
	la 30,.LC12@l(31)
	li 31,0
	b .L297
.L299:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L300
	mr 3,31
	bl G_FreeEdict
	b .L297
.L300:
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
.L297:
	mr 3,31
	li 4,280
	mr 5,30
	bl G_Find
	mr. 31,3
	bc 4,2,.L299
	lis 5,.LC14@ha
	lis 4,.LC49@ha
	la 4,.LC49@l(4)
	la 5,.LC14@l(5)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
.L290:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 CTFDropFlagThink,.Lfe8-CTFDropFlagThink
	.section	".rodata"
	.align 2
.LC50:
	.string	"%s lost the %s flag!\n"
	.align 2
.LC51:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl CTFDeadDropFlag
	.type	 CTFDeadDropFlag,@function
CTFDeadDropFlag:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 9,flag1_item@ha
	mr 31,3
	lwz 0,flag1_item@l(9)
	li 27,0
	lis 26,flag1_item@ha
	lis 25,flag2_item@ha
	cmpwi 0,0,0
	bc 12,2,.L310
	lwz 0,flag2_item@l(25)
	cmpwi 0,0,0
	bc 4,2,.L309
.L310:
	lis 29,gi@ha
	lis 3,.LC7@ha
	la 29,gi@l(29)
	lis 4,.LC8@ha
	lwz 9,144(29)
	la 4,.LC8@l(4)
	li 5,4
	la 3,.LC7@l(3)
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
	lwz 0,flag1_item@l(26)
	lis 9,ctf_forcejoin@ha
	stw 3,ctf_forcejoin@l(9)
	cmpwi 0,0,0
	bc 4,2,.L311
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	bl FindItemByClassname
	stw 3,flag1_item@l(26)
.L311:
	lis 9,flag2_item@ha
	lwz 0,flag2_item@l(9)
	cmpwi 0,0,0
	bc 4,2,.L312
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	bl FindItemByClassname
	stw 3,flag2_item@l(25)
.L312:
	lis 3,ctfgame@ha
	li 4,0
	la 3,ctfgame@l(3)
	li 5,24
	crxor 6,6,6
	bl memset
	lis 9,techspawn@ha
	stw 27,techspawn@l(9)
.L309:
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 10,84(31)
	lwz 4,flag1_item@l(9)
	la 30,itemlist@l(11)
	lis 29,0x286b
	ori 29,29,51739
	addi 10,10,740
	subf 0,30,4
	mullw 0,0,29
	rlwinm 0,0,0,0,29
	lwzx 28,10,0
	cmpwi 0,28,0
	bc 12,2,.L314
	mr 3,31
	bl Drop_Item
	lwz 0,flag1_item@l(26)
	li 11,0
	mr 27,3
	lwz 9,84(31)
	lis 6,.LC13@ha
	lis 4,.LC50@ha
	subf 0,30,0
	la 4,.LC50@l(4)
	mullw 0,0,29
	addi 9,9,740
	la 6,.LC13@l(6)
	li 3,2
	rlwinm 0,0,0,0,29
	stwx 11,9,0
	lwz 5,84(31)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
	b .L320
.L314:
	lis 9,flag2_item@ha
	lwz 4,flag2_item@l(9)
	subf 0,30,4
	mullw 0,0,29
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L320
	mr 3,31
	bl Drop_Item
	lwz 0,flag2_item@l(25)
	mr 27,3
	lis 6,.LC14@ha
	lwz 9,84(31)
	lis 4,.LC50@ha
	la 6,.LC14@l(6)
	subf 0,30,0
	la 4,.LC50@l(4)
	mullw 0,0,29
	addi 9,9,740
	li 3,2
	rlwinm 0,0,0,0,29
	stwx 28,9,0
	lwz 5,84(31)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
.L320:
	cmpwi 0,27,0
	bc 12,2,.L327
	lis 11,CTFDropFlagThink@ha
	lis 9,.LC51@ha
	la 11,CTFDropFlagThink@l(11)
	la 9,.LC51@l(9)
	lis 10,level+4@ha
	stw 11,436(27)
	lfs 0,level+4@l(10)
	lfs 13,0(9)
	lis 9,CTFDropFlagTouch@ha
	la 9,CTFDropFlagTouch@l(9)
	fadds 0,0,13
	stw 9,444(27)
	stfs 0,428(27)
.L327:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 CTFDeadDropFlag,.Lfe9-CTFDeadDropFlag
	.section	".rodata"
	.align 2
.LC52:
	.string	"Only lusers drop flags.\n"
	.align 2
.LC53:
	.string	"Winners don't drop flags.\n"
	.align 2
.LC55:
	.string	"CTFFlagSetup: %s startsolid at %s\n"
	.align 3
.LC56:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC57:
	.long 0xc1700000
	.align 2
.LC58:
	.long 0x41700000
	.align 2
.LC59:
	.long 0x0
	.align 2
.LC60:
	.long 0xc3000000
	.section	".text"
	.align 2
	.globl CTFFlagSetup
	.type	 CTFFlagSetup,@function
CTFFlagSetup:
	stwu 1,-112(1)
	mflr 0
	stmw 29,100(1)
	stw 0,116(1)
	lis 9,.LC57@ha
	lis 11,.LC57@ha
	la 9,.LC57@l(9)
	la 11,.LC57@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC57@ha
	lfs 2,0(11)
	la 9,.LC57@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC58@ha
	lfs 13,0(11)
	la 9,.LC58@l(9)
	lfs 1,0(9)
	lis 9,.LC58@ha
	stfs 13,188(31)
	la 9,.LC58@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC58@ha
	stfs 0,192(31)
	la 9,.LC58@l(9)
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
	bc 12,2,.L334
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L335
.L334:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L335:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC59@ha
	stw 9,444(31)
	addi 29,31,4
	la 11,.LC59@l(11)
	lis 9,.LC60@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC60@l(9)
	lis 11,.LC59@ha
	lfs 3,0(9)
	la 11,.LC59@l(11)
	lfs 2,0(11)
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
	bc 12,2,.L336
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC55@ha
	la 3,.LC55@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L333
.L336:
	lfs 0,24(1)
	mr 3,31
	lfs 13,28(1)
	lfs 12,20(1)
	stfs 0,8(31)
	stfs 13,12(31)
	stfs 12,4(31)
	lwz 0,72(30)
	mtlr 0
	blrl
	lis 11,level+4@ha
	lis 10,.LC56@ha
	lfs 0,level+4@l(11)
	lis 9,CTFFlagThink@ha
	lfd 13,.LC56@l(10)
	la 9,CTFFlagThink@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L333:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe10:
	.size	 CTFFlagSetup,.Lfe10-CTFFlagSetup
	.section	".rodata"
	.align 2
.LC61:
	.string	"players/male/flag1.md2"
	.align 2
.LC62:
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
	rlwinm 8,9,0,12,13
	stw 8,64(31)
	bc 4,1,.L338
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
	bc 12,2,.L339
	oris 0,8,0x4
	stw 0,64(31)
.L339:
	lis 9,flag2_item@ha
	lwz 11,84(31)
	lwz 0,flag2_item@l(9)
	addi 11,11,740
	subf 0,7,0
	mullw 0,0,10
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L338
	lwz 0,64(31)
	oris 0,0,0x8
	stw 0,64(31)
.L338:
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
	bc 12,2,.L341
	lis 9,gi+32@ha
	lis 3,.LC61@ha
	lwz 0,gi+32@l(9)
	la 3,.LC61@l(3)
	b .L345
.L341:
	lis 9,flag2_item@ha
	lwz 0,flag2_item@l(9)
	subf 0,8,0
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 10,10,0
	cmpwi 0,10,0
	bc 12,2,.L343
	lis 9,gi+32@ha
	lis 3,.LC62@ha
	lwz 0,gi+32@l(9)
	la 3,.LC62@l(3)
.L345:
	mtlr 0
	blrl
	stw 3,48(31)
	b .L342
.L343:
	stw 10,48(31)
.L342:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 CTFEffects,.Lfe11-CTFEffects
	.section	".rodata"
	.align 2
.LC63:
	.long 0x0
	.align 3
.LC64:
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
	lis 9,.LC63@ha
	stw 0,8(8)
	li 6,0
	la 9,.LC63@l(9)
	stw 0,12(8)
	lfs 13,0(9)
	lfs 0,20(7)
	fcmpu 0,13,0
	bc 4,0,.L348
	lis 9,g_edicts@ha
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	mr 5,7
	la 11,game@l(11)
	lis 9,.LC64@ha
	lis 4,0x4330
	la 9,.LC64@l(9)
	addi 10,10,1040
	lfd 12,0(9)
	li 7,0
.L350:
	lwz 0,0(10)
	addi 10,10,952
	cmpwi 0,0,0
	bc 12,2,.L349
	lwz 0,1028(11)
	add 9,7,0
	lwz 0,3452(9)
	cmpwi 0,0,1
	bc 4,2,.L352
	lwz 9,3448(9)
	lwz 0,8(8)
	add 0,0,9
	stw 0,8(8)
	b .L349
.L352:
	cmpwi 0,0,2
	bc 4,2,.L349
	lwz 9,3448(9)
	lwz 0,12(8)
	add 0,0,9
	stw 0,12(8)
.L349:
	addi 6,6,1
	lfs 13,20(5)
	xoris 0,6,0x8000
	addi 7,7,3864
	stw 0,12(1)
	stw 4,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L350
.L348:
	la 1,16(1)
	blr
.Lfe12:
	.size	 CTFCalcScores,.Lfe12-CTFCalcScores
	.section	".rodata"
	.align 2
.LC65:
	.string	"Disabling player identication display.\n"
	.align 2
.LC66:
	.string	"Activating player identication display.\n"
	.align 3
.LC67:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 2
.LC68:
	.long 0x0
	.align 2
.LC69:
	.long 0x44800000
	.align 2
.LC70:
	.long 0x3f800000
	.align 3
.LC71:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
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
	lis 11,.LC68@ha
	addi 4,1,8
	la 11,.LC68@l(11)
	li 5,0
	sth 0,174(9)
	li 6,0
	lwz 3,84(30)
	lfs 29,0(11)
	addi 3,3,3672
	bl AngleVectors
	lis 9,.LC69@ha
	addi 3,1,8
	la 9,.LC69@l(9)
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
	lis 9,.LC70@ha
	lfs 13,48(1)
	la 9,.LC70@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L360
	lwz 9,92(1)
	cmpwi 0,9,0
	bc 12,2,.L360
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L360
	lis 11,g_edicts@ha
	lis 0,0x46fd
	lwz 10,84(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,55623
	subf 9,9,30
	b .L369
.L360:
	lwz 3,84(30)
	addi 4,1,8
	li 5,0
	li 6,0
	li 27,0
	addi 3,3,3672
	li 28,1
	bl AngleVectors
	lis 24,maxclients@ha
	lis 9,.LC70@ha
	lis 11,maxclients@ha
	la 9,.LC70@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L362
	lis 11,.LC71@ha
	lis 25,g_edicts@ha
	la 11,.LC71@l(11)
	lis 26,0x4330
	lfd 30,0(11)
	li 29,952
.L364:
	lwz 0,g_edicts@l(25)
	add 31,0,29
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L363
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
	bc 4,1,.L363
	mr 3,30
	mr 4,31
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L363
	fmr 29,31
	mr 27,31
.L363:
	addi 28,28,1
	lwz 11,maxclients@l(24)
	xoris 0,28,0x8000
	addi 29,29,952
	stw 0,116(1)
	stw 26,112(1)
	lfd 0,112(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L364
.L362:
	lis 9,.LC67@ha
	fmr 13,29
	lfd 0,.LC67@l(9)
	fcmpu 0,13,0
	bc 4,1,.L359
	lis 11,g_edicts@ha
	lis 0,0x46fd
	lwz 10,84(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,55623
	subf 9,9,27
.L369:
	mullw 9,9,0
	srawi 9,9,3
	addi 9,9,1311
	sth 9,174(10)
.L359:
	lwz 0,180(1)
	mtlr 0
	lmw 24,120(1)
	lfd 29,152(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe13:
	.size	 CTFSetIDView,.Lfe13-CTFSetIDView
	.section	".rodata"
	.align 2
.LC72:
	.string	"ctfsb1"
	.align 2
.LC73:
	.string	"ctfsb2"
	.align 2
.LC74:
	.string	"i_ctf1"
	.align 2
.LC75:
	.string	"i_ctf1d"
	.align 2
.LC76:
	.string	"i_ctf1t"
	.align 2
.LC77:
	.string	"i_ctf2"
	.align 2
.LC78:
	.string	"i_ctf2d"
	.align 2
.LC79:
	.string	"i_ctf2t"
	.align 2
.LC80:
	.string	"i_ctfj"
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
	.align 2
.LC84:
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
	lis 3,.LC72@ha
	lwz 9,40(29)
	la 3,.LC72@l(3)
	lis 27,level@ha
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,.LC73@ha
	sth 3,168(9)
	lwz 0,40(29)
	la 3,.LC73@l(11)
	mtlr 0
	blrl
	lwz 9,84(31)
	lis 10,.LC81@ha
	lis 11,level+200@ha
	la 10,.LC81@l(10)
	sth 3,170(9)
	lfs 13,0(10)
	lfs 0,level+200@l(11)
	lis 10,ctfgame@ha
	fcmpu 0,0,13
	bc 12,2,.L371
	lwz 0,level@l(27)
	andi. 11,0,8
	bc 12,2,.L371
	la 11,ctfgame@l(10)
	lwz 9,ctfgame@l(10)
	lwz 0,4(11)
	cmpw 0,9,0
	bc 12,1,.L422
	cmpw 0,0,9
	bc 12,1,.L423
	lwz 9,12(11)
	lwz 0,8(11)
	cmpw 0,0,9
	bc 4,1,.L376
.L422:
	lwz 9,84(31)
	li 0,0
	sth 0,168(9)
	b .L371
.L376:
	cmpw 0,9,0
	bc 4,1,.L378
.L423:
	lwz 9,84(31)
	li 0,0
	sth 0,170(9)
	b .L371
.L419:
	lis 9,gi+40@ha
	lwz 3,36(3)
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,172(9)
	b .L381
.L378:
	lwz 9,84(31)
	li 0,0
	sth 0,168(9)
	lwz 11,84(31)
	sth 0,170(11)
.L371:
	lwz 10,84(31)
	li 11,0
	lis 9,tnames@ha
	la 3,tnames@l(9)
	sth 11,172(10)
	lwzx 0,3,11
	cmpwi 0,0,0
	bc 12,2,.L381
	lis 9,itemlist@ha
	lis 29,0x286b
	la 28,itemlist@l(9)
	mr 30,3
	ori 29,29,51739
.L382:
	lwz 3,0(30)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L383
	subf 0,28,3
	lwz 11,84(31)
	mullw 0,0,29
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L419
.L383:
	lwzu 0,4(30)
	cmpwi 0,0,0
	bc 4,2,.L382
.L381:
	lis 9,gi@ha
	lis 3,.LC74@ha
	la 30,gi@l(9)
	la 3,.LC74@l(3)
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
	bc 12,2,.L385
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L386
	lwz 0,40(30)
	lis 3,.LC75@ha
	la 3,.LC75@l(3)
	mtlr 0
	blrl
	lis 9,maxclients@ha
	lis 10,.LC82@ha
	lwz 11,maxclients@l(9)
	la 10,.LC82@l(10)
	mr 28,3
	lfs 0,0(10)
	li 7,1
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L385
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
	lis 9,.LC83@ha
	mullw 10,10,0
	lis 11,0x4330
	la 9,.LC83@l(9)
	addi 8,8,952
	lfd 13,0(9)
	rlwinm 10,10,0,0,29
.L390:
	lwz 0,88(8)
	cmpwi 0,0,0
	bc 12,2,.L389
	lwz 9,84(8)
	addi 9,9,740
	lwzx 0,9,10
	cmpwi 0,0,0
	bc 4,2,.L420
.L389:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,952
	stw 0,20(1)
	stw 11,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L390
	b .L385
.L420:
	lis 9,gi+40@ha
	lis 3,.LC76@ha
	lwz 0,gi+40@l(9)
	la 3,.LC76@l(3)
	b .L424
.L386:
	lwz 0,284(3)
	andis. 9,0,1
	bc 12,2,.L385
	lwz 0,40(30)
	lis 3,.LC75@ha
	la 3,.LC75@l(3)
.L424:
	mtlr 0
	blrl
	mr 28,3
.L385:
	lis 9,gi@ha
	lis 3,.LC77@ha
	la 30,gi@l(9)
	la 3,.LC77@l(3)
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
	bc 12,2,.L395
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L396
	lwz 0,40(30)
	lis 3,.LC78@ha
	la 3,.LC78@l(3)
	mtlr 0
	blrl
	lis 9,maxclients@ha
	lis 10,.LC82@ha
	lwz 11,maxclients@l(9)
	la 10,.LC82@l(10)
	mr 29,3
	lfs 0,0(10)
	li 7,1
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L395
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
	lis 9,.LC83@ha
	mullw 10,10,0
	lis 11,0x4330
	la 9,.LC83@l(9)
	addi 8,8,952
	lfd 13,0(9)
	rlwinm 10,10,0,0,29
.L400:
	lwz 0,88(8)
	cmpwi 0,0,0
	bc 12,2,.L399
	lwz 9,84(8)
	addi 9,9,740
	lwzx 0,9,10
	cmpwi 0,0,0
	bc 4,2,.L421
.L399:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,952
	stw 0,20(1)
	stw 11,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L400
	b .L395
.L421:
	lis 9,gi+40@ha
	lis 3,.LC79@ha
	lwz 0,gi+40@l(9)
	la 3,.LC79@l(3)
	b .L425
.L396:
	lwz 0,284(3)
	andis. 9,0,1
	bc 12,2,.L395
	lwz 0,40(30)
	lis 3,.LC78@ha
	la 3,.LC78@l(3)
.L425:
	mtlr 0
	blrl
	mr 29,3
.L395:
	lis 10,.LC81@ha
	lwz 11,84(31)
	lis 9,ctfgame@ha
	la 10,.LC81@l(10)
	lfs 0,0(10)
	sth 28,154(11)
	la 10,ctfgame@l(9)
	lwz 9,84(31)
	sth 29,158(9)
	lfs 12,16(10)
	fcmpu 0,12,0
	bc 12,2,.L405
	lis 9,level+4@ha
	lis 11,.LC84@ha
	lfs 0,level+4@l(9)
	la 11,.LC84@l(11)
	lfs 13,0(11)
	fsubs 0,0,12
	fcmpu 0,0,13
	bc 4,0,.L405
	lwz 0,20(10)
	cmpwi 0,0,1
	bc 4,2,.L406
	lwz 0,level@l(27)
	andi. 0,0,8
	bc 12,2,.L407
	lwz 9,84(31)
	sth 28,154(9)
	b .L405
.L407:
	lwz 9,84(31)
	sth 0,154(9)
	b .L405
.L406:
	lwz 0,level@l(27)
	andi. 0,0,8
	bc 12,2,.L410
	lwz 9,84(31)
	sth 29,158(9)
	b .L405
.L410:
	lwz 9,84(31)
	sth 0,158(9)
.L405:
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
	lwz 0,3452(10)
	cmpwi 0,0,1
	bc 4,2,.L412
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
	bc 12,2,.L412
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L412
	lis 9,gi+40@ha
	lis 3,.LC77@ha
	lwz 0,gi+40@l(9)
	la 3,.LC77@l(3)
	b .L426
.L412:
	lwz 10,84(31)
	lwz 0,3452(10)
	cmpwi 0,0,2
	bc 4,2,.L413
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
	bc 12,2,.L413
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L413
	lis 9,gi+40@ha
	lis 3,.LC74@ha
	lwz 0,gi+40@l(9)
	la 3,.LC74@l(3)
.L426:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,162(9)
.L413:
	lwz 11,84(31)
	li 0,0
	sth 0,164(11)
	lwz 9,84(31)
	sth 0,166(9)
	lwz 11,84(31)
	lwz 0,3452(11)
	cmpwi 0,0,1
	bc 4,2,.L415
	lis 9,gi+40@ha
	lis 3,.LC80@ha
	lwz 0,gi+40@l(9)
	la 3,.LC80@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,164(9)
	b .L416
.L415:
	cmpwi 0,0,2
	bc 4,2,.L416
	lis 9,gi+40@ha
	lis 3,.LC80@ha
	lwz 0,gi+40@l(9)
	la 3,.LC80@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,166(9)
.L416:
	lwz 11,84(31)
	li 0,0
	sth 0,174(11)
	lwz 9,84(31)
	lwz 0,3476(9)
	cmpwi 0,0,0
	bc 12,2,.L418
	mr 3,31
	bl CTFSetIDView
.L418:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe14:
	.size	 SetCTFStats,.Lfe14-SetCTFStats
	.section	".rodata"
	.align 2
.LC86:
	.string	"weapons/grapple/grreset.wav"
	.align 2
.LC88:
	.string	"weapons/grapple/grpull.wav"
	.align 2
.LC89:
	.string	"weapons/grapple/grhit.wav"
	.align 2
.LC87:
	.long 0x3e4ccccd
	.align 2
.LC90:
	.long 0x3f800000
	.align 2
.LC91:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFGrappleTouch
	.type	 CTFGrappleTouch,@function
CTFGrappleTouch:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 26,16(1)
	stw 0,52(1)
	mr 31,3
	mr 29,4
	lwz 30,256(31)
	lis 9,.LC90@ha
	mr 27,5
	la 9,.LC90@l(9)
	cmpw 0,29,30
	lfs 31,0(9)
	bc 12,2,.L434
	lwz 9,84(30)
	lwz 28,3836(9)
	cmpwi 0,28,0
	bc 4,2,.L434
	cmpwi 0,6,0
	bc 12,2,.L437
	lwz 0,16(6)
	andi. 11,0,4
	bc 12,2,.L437
	lwz 0,3832(9)
	cmpwi 0,0,0
	bc 12,2,.L434
	lwz 0,3768(9)
	lis 9,.LC90@ha
	cmpwi 0,0,0
	la 9,.LC90@l(9)
	lfs 31,0(9)
	bc 12,2,.L439
	lis 9,.LC87@ha
	lfs 31,.LC87@l(9)
.L439:
	lis 29,gi@ha
	lis 3,.LC86@ha
	la 29,gi@l(29)
	la 3,.LC86@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC90@ha
	lis 11,.LC91@ha
	fmr 1,31
	la 9,.LC90@l(9)
	la 11,.LC91@l(11)
	mr 5,3
	lfs 2,0(9)
	mtlr 0
	li 4,17
	mr 3,30
	lfs 3,0(11)
	blrl
	lwz 11,256(31)
	lis 10,level+4@ha
	mr 3,31
	lwz 9,84(11)
	stw 28,3832(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 28,3836(9)
	b .L448
.L437:
	lis 9,vec3_origin@ha
	addi 4,31,4
	lwz 3,256(31)
	lfs 13,vec3_origin@l(9)
	la 26,vec3_origin@l(9)
	mr 28,4
	li 5,2
	stfs 13,376(31)
	lfs 0,4(26)
	stfs 0,380(31)
	lfs 13,8(26)
	stfs 13,384(31)
	bl PlayerNoise
	lwz 10,512(29)
	cmpwi 0,10,0
	bc 12,2,.L441
	lwz 9,516(31)
	li 0,34
	li 26,0
	lwz 5,256(31)
	mr 3,29
	mr 7,28
	stw 0,12(1)
	mr 8,27
	mr 4,31
	stw 26,8(1)
	addi 6,31,376
	li 10,1
	bl T_Damage
	lwz 30,256(31)
	lwz 9,84(30)
	lwz 0,3832(9)
	cmpwi 0,0,0
	bc 12,2,.L434
	lwz 0,3768(9)
	lis 9,.LC90@ha
	cmpwi 0,0,0
	la 9,.LC90@l(9)
	lfs 31,0(9)
	bc 12,2,.L443
	lis 9,.LC87@ha
	lfs 31,.LC87@l(9)
.L443:
	lis 29,gi@ha
	lis 3,.LC86@ha
	la 29,gi@l(29)
	la 3,.LC86@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC90@ha
	lis 11,.LC91@ha
	fmr 1,31
	la 9,.LC90@l(9)
	la 11,.LC91@l(11)
	mr 5,3
	lfs 2,0(9)
	mtlr 0
	li 4,17
	mr 3,30
	lfs 3,0(11)
	blrl
	lwz 11,256(31)
	lis 10,level+4@ha
	mr 3,31
	lwz 9,84(11)
	stw 26,3832(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 26,3836(9)
.L448:
	andi. 0,0,191
	stfs 0,3840(9)
	stb 0,16(9)
	bl G_FreeEdict
	b .L434
.L441:
	lwz 11,256(31)
	li 0,1
	lwz 9,84(11)
	stw 0,3836(9)
	lwz 30,256(31)
	stw 29,540(31)
	stw 10,248(31)
	lwz 9,84(30)
	lwz 0,3768(9)
	cmpwi 0,0,0
	bc 12,2,.L445
	lis 9,.LC87@ha
	lfs 31,.LC87@l(9)
.L445:
	lis 9,gi@ha
	lis 3,.LC88@ha
	la 29,gi@l(9)
	la 3,.LC88@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC90@ha
	lwz 11,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC90@l(9)
	li 4,17
	lfs 2,0(9)
	mtlr 11
	mr 3,30
	lis 9,.LC91@ha
	la 9,.LC91@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,36(29)
	lis 3,.LC89@ha
	la 3,.LC89@l(3)
	mtlr 9
	blrl
	lis 9,.LC90@ha
	lwz 11,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC90@l(9)
	li 4,1
	lfs 2,0(9)
	mtlr 11
	mr 3,31
	lis 9,.LC91@ha
	la 9,.LC91@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,100(29)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,9
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	cmpwi 0,27,0
	bc 4,2,.L446
	lwz 0,124(29)
	mr 3,26
	mtlr 0
	blrl
	b .L447
.L446:
	lwz 0,124(29)
	mr 3,27
	mtlr 0
	blrl
.L447:
	lis 9,gi+88@ha
	mr 3,28
	lwz 0,gi+88@l(9)
	li 4,2
	mtlr 0
	blrl
.L434:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 CTFGrappleTouch,.Lfe15-CTFGrappleTouch
	.section	".rodata"
	.align 3
.LC92:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC93:
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
	addi 3,3,3672
	bl AngleVectors
	lis 9,.LC92@ha
	lwz 10,256(31)
	lis 0,0x4180
	la 9,.LC92@l(9)
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
	lis 9,.LC93@ha
	la 9,.LC93@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L449
	mr 3,31
	bl ACEND_GrapFired
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
	lis 0,0x46fd
	lwz 11,g_edicts@l(9)
	ori 0,0,55623
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
.L449:
	lwz 0,132(1)
	mtlr 0
	lmw 28,112(1)
	la 1,128(1)
	blr
.Lfe16:
	.size	 CTFGrappleDrawCable,.Lfe16-CTFGrappleDrawCable
	.section	".rodata"
	.align 2
.LC94:
	.string	"weapon_grapple"
	.align 2
.LC96:
	.string	"weapons/grapple/grhurt.wav"
	.align 2
.LC97:
	.string	"weapons/grapple/grhang.wav"
	.align 2
.LC95:
	.long 0x3e4ccccd
	.align 2
.LC98:
	.long 0x44228000
	.align 2
.LC99:
	.long 0x3f800000
	.align 2
.LC100:
	.long 0x0
	.align 2
.LC101:
	.long 0x3f000000
	.align 3
.LC102:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC103:
	.long 0x42800000
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
	lis 4,.LC94@ha
	lwz 10,256(31)
	la 4,.LC94@l(4)
	lwz 9,84(10)
	lwz 11,1788(9)
	lwz 3,0(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L452
	lwz 30,256(31)
	lwz 9,84(30)
	lwz 28,3568(9)
	cmpwi 0,28,0
	bc 4,2,.L452
	lwz 0,3604(9)
	cmpwi 0,0,3
	bc 12,2,.L452
	cmpwi 0,0,1
	bc 12,2,.L452
	lwz 0,3832(9)
	cmpwi 0,0,0
	bc 12,2,.L451
	lwz 0,3768(9)
	lis 8,.LC99@ha
	la 8,.LC99@l(8)
	cmpwi 0,0,0
	lfs 31,0(8)
	bc 12,2,.L454
	lis 9,.LC95@ha
	lfs 31,.LC95@l(9)
.L454:
	lis 29,gi@ha
	lis 3,.LC86@ha
	la 29,gi@l(29)
	la 3,.LC86@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC99@ha
	lis 9,.LC100@ha
	fmr 1,31
	la 9,.LC100@l(9)
	mr 5,3
	la 8,.LC99@l(8)
	mr 3,30
	lfs 3,0(9)
	mtlr 0
	li 4,17
	lfs 2,0(8)
	blrl
	lwz 11,256(31)
	lis 10,level+4@ha
	mr 3,31
	lwz 9,84(11)
	stw 28,3832(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 28,3836(9)
	b .L472
.L452:
	lwz 3,540(31)
	cmpwi 0,3,0
	bc 12,2,.L456
	lwz 28,248(3)
	cmpwi 0,28,0
	bc 4,2,.L457
	lwz 30,256(31)
	lwz 9,84(30)
	lwz 0,3832(9)
	cmpwi 0,0,0
	bc 12,2,.L451
	lwz 0,3768(9)
	lis 8,.LC99@ha
	la 8,.LC99@l(8)
	cmpwi 0,0,0
	lfs 31,0(8)
	bc 12,2,.L459
	lis 9,.LC95@ha
	lfs 31,.LC95@l(9)
.L459:
	lis 29,gi@ha
	lis 3,.LC86@ha
	la 29,gi@l(29)
	la 3,.LC86@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC99@ha
	lis 9,.LC100@ha
	fmr 1,31
	la 9,.LC100@l(9)
	mr 5,3
	la 8,.LC99@l(8)
	mr 3,30
	lfs 3,0(9)
	mtlr 0
	li 4,17
	lfs 2,0(8)
	blrl
	lwz 11,256(31)
	lis 10,level+4@ha
	mr 3,31
	lwz 9,84(11)
	stw 28,3832(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 28,3836(9)
	b .L472
.L457:
	cmpwi 0,28,2
	bc 4,2,.L461
	lis 8,.LC101@ha
	addi 3,3,236
	la 8,.LC101@l(8)
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
	b .L462
.L461:
	lfs 0,376(3)
	stfs 0,376(31)
	lfs 13,380(3)
	stfs 13,380(31)
	lfs 0,384(3)
	stfs 0,384(31)
.L462:
	lwz 3,540(31)
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L463
	lwz 4,256(31)
	crxor 6,6,6
	bl CheckTeamDamage
	mr. 11,3
	bc 4,2,.L463
	lwz 5,256(31)
	lis 8,.LC99@ha
	la 8,.LC99@l(8)
	lwz 9,84(5)
	lfs 31,0(8)
	lwz 0,3768(9)
	cmpwi 0,0,0
	bc 12,2,.L464
	lis 9,.LC95@ha
	lfs 31,.LC95@l(9)
.L464:
	lwz 3,540(31)
	li 0,34
	lis 8,vec3_origin@ha
	la 8,vec3_origin@l(8)
	stw 0,12(1)
	mr 4,31
	li 9,1
	stw 11,8(1)
	addi 6,31,376
	addi 7,31,4
	li 10,1
	bl T_Damage
	lis 29,gi@ha
	lis 3,.LC96@ha
	la 29,gi@l(29)
	la 3,.LC96@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC99@ha
	lis 9,.LC100@ha
	fmr 1,31
	mr 5,3
	la 8,.LC99@l(8)
	la 9,.LC100@l(9)
	li 4,1
	lfs 2,0(8)
	mtlr 0
	mr 3,31
	lfs 3,0(9)
	blrl
.L463:
	lwz 9,540(31)
	lwz 0,492(9)
	cmpwi 0,0,0
	bc 12,2,.L456
	lwz 30,256(31)
	lwz 9,84(30)
	lwz 0,3832(9)
	cmpwi 0,0,0
	bc 12,2,.L451
	lwz 0,3768(9)
	lis 8,.LC99@ha
	la 8,.LC99@l(8)
	cmpwi 0,0,0
	lfs 31,0(8)
	bc 12,2,.L467
	lis 9,.LC95@ha
	lfs 31,.LC95@l(9)
.L467:
	lis 29,gi@ha
	lis 3,.LC86@ha
	la 29,gi@l(29)
	la 3,.LC86@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC99@ha
	lis 9,.LC100@ha
	fmr 1,31
	la 8,.LC99@l(8)
	la 9,.LC100@l(9)
	mr 5,3
	lfs 2,0(8)
	mtlr 0
	li 4,17
	mr 3,30
	lfs 3,0(9)
	blrl
	lwz 11,256(31)
	li 8,0
	lis 10,level+4@ha
	mr 3,31
	lwz 9,84(11)
	stw 8,3832(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 8,3836(9)
.L472:
	andi. 0,0,191
	stfs 0,3840(9)
	stb 0,16(9)
	bl G_FreeEdict
	b .L451
.L456:
	mr 3,31
	bl CTFGrappleDrawCable
	lwz 9,256(31)
	lwz 3,84(9)
	lwz 0,3836(3)
	cmpwi 0,0,0
	bc 4,1,.L451
	addi 3,3,3672
	addi 4,1,48
	li 5,0
	addi 6,1,64
	bl AngleVectors
	lwz 9,256(31)
	lis 10,0x4330
	lfs 10,4(31)
	lis 8,.LC102@ha
	addi 3,1,16
	lfs 0,4(9)
	la 8,.LC102@l(8)
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
	lis 8,.LC103@ha
	lwz 9,256(31)
	la 8,.LC103@l(8)
	lfs 0,0(8)
	lwz 11,84(9)
	fcmpu 7,1,0
	lwz 0,3836(11)
	xori 0,0,1
	subfic 10,0,0
	adde 0,10,0
	mfcr 9
	rlwinm 9,9,29,1
	and. 8,0,9
	bc 12,2,.L470
	lwz 0,3768(11)
	lis 9,.LC99@ha
	la 9,.LC99@l(9)
	cmpwi 0,0,0
	lfs 31,0(9)
	bc 12,2,.L471
	lis 9,.LC95@ha
	lfs 31,.LC95@l(9)
.L471:
	lbz 0,16(11)
	lis 29,gi@ha
	lis 3,.LC97@ha
	la 29,gi@l(29)
	la 3,.LC97@l(3)
	ori 0,0,64
	stb 0,16(11)
	lwz 9,36(29)
	lwz 28,256(31)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC99@ha
	lis 9,.LC100@ha
	fmr 1,31
	la 9,.LC100@l(9)
	mr 5,3
	la 8,.LC99@l(8)
	lfs 3,0(9)
	mtlr 0
	li 4,17
	mr 3,28
	lfs 2,0(8)
	blrl
	lwz 11,256(31)
	li 0,2
	lwz 9,84(11)
	stw 0,3836(9)
.L470:
	addi 3,1,16
	bl VectorNormalize
	lis 9,.LC98@ha
	addi 3,1,16
	lfs 1,.LC98@l(9)
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
.L451:
	lwz 0,116(1)
	mtlr 0
	lmw 28,88(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe17:
	.size	 CTFGrapplePull,.Lfe17-CTFGrapplePull
	.section	".rodata"
	.align 2
.LC104:
	.string	"models/weapons/grapple/hook/tris.md2"
	.align 2
.LC106:
	.string	"weapons/grapple/grfire.wav"
	.align 2
.LC105:
	.long 0x3e4ccccd
	.align 2
.LC107:
	.long 0x3f800000
	.align 3
.LC108:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC109:
	.long 0x41c00000
	.align 2
.LC110:
	.long 0x41000000
	.align 2
.LC111:
	.long 0xc0000000
	.align 2
.LC112:
	.long 0x0
	.align 3
.LC113:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC114:
	.long 0xc1200000
	.section	".text"
	.align 2
	.globl CTFGrappleFire
	.type	 CTFGrappleFire,@function
CTFGrappleFire:
	stwu 1,-224(1)
	mflr 0
	stfd 30,208(1)
	stfd 31,216(1)
	stmw 21,164(1)
	stw 0,228(1)
	mr 30,3
	lis 9,.LC107@ha
	lwz 3,84(30)
	la 9,.LC107@l(9)
	mr 28,4
	mr 21,5
	mr 23,6
	lfs 30,0(9)
	lwz 0,3836(3)
	cmpwi 0,0,0
	bc 12,1,.L475
	addi 29,1,24
	addi 4,1,8
	addi 3,3,3672
	mr 5,29
	li 6,0
	lis 22,0x4330
	bl AngleVectors
	addi 25,30,4
	lis 9,.LC108@ha
	lis 10,.LC109@ha
	lfs 12,0(28)
	la 9,.LC108@l(9)
	la 10,.LC109@l(10)
	lfs 10,8(28)
	lfd 31,0(9)
	addi 24,1,40
	lwz 9,508(30)
	mr 4,25
	mr 7,29
	lfs 0,0(10)
	addi 5,1,56
	addi 6,1,8
	addi 9,9,-6
	lis 10,.LC110@ha
	lfs 13,4(28)
	xoris 9,9,0x8000
	la 10,.LC110@l(10)
	lwz 3,84(30)
	stw 9,156(1)
	fadds 12,12,0
	mr 8,24
	stw 22,152(1)
	lfd 0,152(1)
	lfs 11,0(10)
	stfs 12,56(1)
	fsub 0,0,31
	fadds 13,13,11
	frsp 0,0
	stfs 13,60(1)
	fadds 0,0,10
	stfs 0,64(1)
	bl P_ProjectSource
	lis 9,.LC111@ha
	lwz 4,84(30)
	addi 3,1,8
	la 9,.LC111@l(9)
	lfs 1,0(9)
	addi 4,4,3620
	bl VectorScale
	lwz 11,84(30)
	lis 0,0xbf80
	stw 0,3608(11)
	lwz 9,84(30)
	lwz 0,3768(9)
	cmpwi 0,0,0
	bc 12,2,.L477
	lis 9,.LC105@ha
	lfs 30,.LC105@l(9)
.L477:
	lis 29,gi@ha
	lis 3,.LC106@ha
	la 29,gi@l(29)
	la 3,.LC106@l(3)
	lwz 9,36(29)
	addi 27,1,8
	li 28,650
	mtlr 9
	blrl
	lis 9,.LC107@ha
	lis 10,.LC112@ha
	fmr 1,30
	la 9,.LC107@l(9)
	mr 5,3
	lfs 2,0(9)
	la 10,.LC112@l(10)
	li 4,17
	lwz 9,16(29)
	mr 3,30
	lfs 3,0(10)
	mtlr 9
	blrl
	mr 3,27
	bl VectorNormalize
	bl G_Spawn
	lfs 0,40(1)
	mr 31,3
	mr 3,27
	addi 4,31,16
	addi 26,31,4
	stfs 0,4(31)
	lfs 0,44(1)
	stfs 0,8(31)
	lfs 13,48(1)
	stfs 13,12(31)
	lfs 0,40(1)
	stfs 0,28(31)
	lfs 13,44(1)
	stfs 13,32(31)
	lfs 0,48(1)
	stfs 0,36(31)
	bl vectoangles
	xoris 28,28,0x8000
	stw 28,156(1)
	addi 4,31,376
	mr 3,27
	stw 22,152(1)
	lfd 1,152(1)
	fsub 1,1,31
	frsp 1,1
	bl VectorScale
	lwz 11,64(31)
	lis 0,0x600
	li 9,0
	li 10,8
	li 8,2
	stw 9,200(31)
	ori 0,0,3
	or 11,11,23
	stw 10,260(31)
	stw 8,248(31)
	lis 3,.LC104@ha
	stw 0,252(31)
	la 3,.LC104@l(3)
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
	li 0,0
	la 9,CTFGrappleTouch@l(9)
	stw 21,516(31)
	mr 3,31
	stw 9,444(31)
	stw 30,256(31)
	lwz 9,84(30)
	stw 31,3832(9)
	lwz 11,84(30)
	stw 0,3836(11)
	lwz 9,72(29)
	mtlr 9
	blrl
	lwz 0,48(29)
	lis 9,0x600
	mr 4,25
	ori 9,9,3
	addi 3,1,72
	li 5,0
	li 6,0
	mtlr 0
	mr 7,26
	mr 8,31
	blrl
	lfs 0,80(1)
	lis 9,.LC113@ha
	la 9,.LC113@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L479
	lis 10,.LC114@ha
	mr 3,26
	la 10,.LC114@l(10)
	mr 5,3
	lfs 1,0(10)
	mr 4,27
	bl VectorMA
	lwz 0,444(31)
	mr 3,31
	li 5,0
	lwz 4,124(1)
	li 6,0
	mtlr 0
	blrl
.L479:
	mr 3,30
	mr 4,24
	li 5,1
	bl PlayerNoise
.L475:
	lwz 0,228(1)
	mtlr 0
	lmw 21,164(1)
	lfd 30,208(1)
	lfd 31,216(1)
	la 1,224(1)
	blr
.Lfe18:
	.size	 CTFGrappleFire,.Lfe18-CTFGrappleFire
	.section	".data"
	.align 2
	.type	 pause_frames.117,@object
pause_frames.117:
	.long 10
	.long 18
	.long 27
	.long 0
	.align 2
	.type	 fire_frames.118,@object
fire_frames.118:
	.long 6
	.long 0
	.section	".rodata"
	.align 2
.LC115:
	.long 0x3e4ccccd
	.align 2
.LC116:
	.long 0x3f800000
	.align 2
.LC117:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFWeapon_Grapple
	.type	 CTFWeapon_Grapple,@function
CTFWeapon_Grapple:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	mr 30,3
	lwz 9,84(30)
	lwz 0,3552(9)
	andi. 11,0,1
	bc 12,2,.L492
	lwz 0,3604(9)
	cmpwi 0,0,3
	bc 4,2,.L482
	lwz 0,3832(9)
	cmpwi 0,0,0
	bc 12,2,.L482
	li 0,9
	stw 0,92(9)
.L482:
	lwz 9,84(30)
	lwz 0,3552(9)
	andi. 9,0,1
	bc 4,2,.L483
.L492:
	lwz 9,84(30)
	lwz 31,3832(9)
	cmpwi 0,31,0
	bc 12,2,.L483
	lwz 28,256(31)
	lwz 9,84(28)
	lwz 0,3832(9)
	cmpwi 0,0,0
	bc 12,2,.L486
	lwz 0,3768(9)
	lis 11,.LC116@ha
	la 11,.LC116@l(11)
	cmpwi 0,0,0
	lfs 31,0(11)
	bc 12,2,.L485
	lis 9,.LC115@ha
	lfs 31,.LC115@l(9)
.L485:
	lis 29,gi@ha
	lis 3,.LC86@ha
	la 29,gi@l(29)
	la 3,.LC86@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC116@ha
	lis 11,.LC117@ha
	fmr 1,31
	la 9,.LC116@l(9)
	la 11,.LC117@l(11)
	mr 5,3
	lfs 2,0(9)
	mtlr 0
	li 4,17
	lfs 3,0(11)
	mr 3,28
	blrl
	lwz 11,256(31)
	li 8,0
	lis 10,level+4@ha
	mr 3,31
	lwz 9,84(11)
	stw 8,3832(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 8,3836(9)
	andi. 0,0,191
	stfs 0,3840(9)
	stb 0,16(9)
	bl G_FreeEdict
.L486:
	lwz 9,84(30)
	lwz 0,3604(9)
	cmpwi 0,0,3
	bc 4,2,.L483
	li 0,0
	stw 0,3604(9)
.L483:
	lwz 9,84(30)
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 12,2,.L488
	lwz 0,3836(9)
	cmpwi 0,0,0
	bc 4,1,.L488
	lwz 0,3604(9)
	cmpwi 0,0,3
	bc 4,2,.L488
	li 0,2
	li 11,32
	stw 0,3604(9)
	lwz 9,84(30)
	stw 11,92(9)
.L488:
	lwz 11,84(30)
	lis 8,pause_frames.117@ha
	lis 9,fire_frames.118@ha
	lis 10,CTFWeapon_Grapple_Fire@ha
	la 8,pause_frames.117@l(8)
	lwz 29,3604(11)
	la 9,fire_frames.118@l(9)
	la 10,CTFWeapon_Grapple_Fire@l(10)
	mr 3,30
	li 4,5
	li 5,9
	li 6,31
	li 7,36
	bl Weapon_Generic
	cmpwi 0,29,1
	bc 4,2,.L489
	lwz 9,84(30)
	lwz 0,3604(9)
	cmpwi 0,0,0
	bc 4,2,.L489
	lwz 0,3836(9)
	cmpwi 0,0,0
	bc 4,1,.L489
	lwz 0,3552(9)
	andi. 11,0,1
	li 0,5
	bc 4,2,.L490
	li 0,9
.L490:
	stw 0,92(9)
	lwz 9,84(30)
	li 0,3
	stw 0,3604(9)
.L489:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 CTFWeapon_Grapple,.Lfe19-CTFWeapon_Grapple
	.section	".rodata"
	.align 2
.LC118:
	.string	"You are on the %s team.\n"
	.align 2
.LC119:
	.string	"red"
	.align 2
.LC120:
	.string	"blue"
	.align 2
.LC121:
	.string	"Unknown team %s.\n"
	.align 2
.LC122:
	.string	"You are already on the %s team.\n"
	.align 2
.LC123:
	.string	"skin"
	.align 2
.LC124:
	.string	"%s joined the %s team.\n"
	.align 2
.LC125:
	.string	"%s changed to the %s team.\n"
	.section	".text"
	.align 2
	.globl CTFTeam_f
	.type	 CTFTeam_f,@function
CTFTeam_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi+164@ha
	mr 31,3
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 30,3
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L495
	lwz 9,84(31)
	lwz 0,3452(9)
	cmpwi 0,0,1
	bc 12,2,.L496
	cmpwi 0,0,2
	bc 12,2,.L497
	b .L500
.L496:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L499
.L497:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L499
.L500:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L499:
	lis 5,.LC118@ha
	mr 3,31
	la 5,.LC118@l(5)
	b .L522
.L495:
	lis 4,.LC119@ha
	mr 3,30
	la 4,.LC119@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L501
	li 30,1
	b .L502
.L501:
	lis 4,.LC120@ha
	mr 3,30
	la 4,.LC120@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L503
	lis 5,.LC121@ha
	mr 3,31
	la 5,.LC121@l(5)
	mr 6,30
	b .L522
.L503:
	li 30,2
.L502:
	lwz 9,84(31)
	lwz 0,3452(9)
	cmpw 0,0,30
	bc 4,2,.L505
	cmpwi 0,30,1
	bc 12,2,.L506
	cmpwi 0,30,2
	bc 12,2,.L507
	b .L510
.L506:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L509
.L507:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L509
.L510:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L509:
	lis 5,.LC122@ha
	mr 3,31
	la 5,.LC122@l(5)
.L522:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L494
.L505:
	lwz 0,264(31)
	li 29,0
	lis 4,.LC123@ha
	stw 29,184(31)
	la 4,.LC123@l(4)
	rlwinm 0,0,0,28,26
	stw 0,264(31)
	stw 30,3452(9)
	lwz 9,84(31)
	stw 29,3456(9)
	lwz 3,84(31)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl CTFAssignSkin
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L511
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
	bc 12,2,.L512
	cmpwi 0,30,2
	bc 12,2,.L513
	b .L516
.L512:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L515
.L513:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L515
.L516:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L515:
	lis 4,.LC124@ha
	li 3,2
	la 4,.LC124@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L494
.L511:
	lis 6,0x1
	lis 7,vec3_origin@ha
	stw 29,480(31)
	mr 5,31
	la 7,vec3_origin@l(7)
	mr 3,31
	mr 4,31
	ori 6,6,34464
	bl player_die
	li 0,2
	mr 3,31
	stw 0,492(31)
	bl respawn
	lwz 11,84(31)
	cmpwi 0,30,1
	stw 29,3448(11)
	lwz 9,84(31)
	addi 5,9,700
	bc 12,2,.L517
	cmpwi 0,30,2
	bc 12,2,.L518
	b .L521
.L517:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L520
.L518:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L520
.L521:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L520:
	lis 4,.LC125@ha
	li 3,2
	la 4,.LC125@l(4)
	crxor 6,6,6
	bl safe_bprintf
.L494:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 CTFTeam_f,.Lfe20-CTFTeam_f
	.section	".rodata"
	.align 2
.LC126:
	.string	"if 24 xv 8 yv 8 pic 24 endif xv 40 yv 28 string \"%4d/%-3d\" xv 98 yv 12 num 2 18 if 25 xv 168 yv 8 pic 25 endif xv 200 yv 28 string \"%4d/%-3d\" xv 256 yv 12 num 2 20 "
	.align 2
.LC127:
	.string	"ctf 0 %d %d %d %d "
	.align 2
.LC128:
	.string	"xv 56 yv %d picn sbfctf2 "
	.align 2
.LC129:
	.string	"ctf 160 %d %d %d %d "
	.align 2
.LC130:
	.string	"xv 216 yv %d picn sbfctf1 "
	.align 2
.LC131:
	.string	"xv 0 yv %d string2 \"Spectators\" "
	.align 2
.LC132:
	.string	"ctf %d %d %d %d %d "
	.align 2
.LC133:
	.string	"xv 8 yv %d string \"..and %d more\" "
	.align 2
.LC134:
	.string	"xv 168 yv %d string \"..and %d more\" "
	.align 2
.LC135:
	.long 0x0
	.align 3
.LC136:
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
	bc 4,0,.L525
	lis 9,g_edicts@ha
	mr 20,8
	lwz 16,g_edicts@l(9)
	mr 12,17
	mr 19,14
	addi 18,1,4488
	mr 15,17
.L527:
	mulli 9,24,952
	addi 22,24,1
	add 31,9,16
	lwz 0,1040(31)
	cmpwi 0,0,0
	bc 12,2,.L526
	mulli 9,24,3864
	lwz 0,1028(20)
	mr 8,9
	add 9,9,0
	lwz 0,3452(9)
	cmpwi 0,0,1
	bc 4,2,.L529
	li 10,0
	b .L530
.L529:
	cmpwi 0,0,2
	bc 4,2,.L526
	li 10,1
.L530:
	slwi 0,10,2
	lwz 9,1028(20)
	li 27,0
	lwzx 11,12,0
	mr 3,0
	slwi 7,10,10
	add 9,8,9
	addi 6,1,4488
	cmpw 0,27,11
	lwz 30,3448(9)
	addi 4,1,2440
	addi 22,24,1
	bc 4,0,.L534
	lwzx 0,18,7
	cmpw 0,30,0
	bc 12,1,.L534
	lwzx 11,3,15
	add 9,7,6
.L535:
	addi 27,27,1
	cmpw 0,27,11
	bc 4,0,.L534
	lwzu 0,4(9)
	cmpw 0,30,0
	bc 4,1,.L535
.L534:
	lwzx 28,3,12
	slwi 23,27,2
	cmpw 0,28,27
	bc 4,1,.L540
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
.L542:
	lwz 9,0(10)
	addi 28,28,-1
	cmpw 0,28,27
	addi 10,10,-4
	stwx 9,11,29
	lwz 0,0(8)
	addi 8,8,-4
	stwx 0,11,5
	addi 11,11,-4
	bc 12,1,.L542
.L540:
	add 0,23,7
	stwx 24,4,0
	stwx 30,6,0
	lwzx 9,3,19
	lwzx 11,3,12
	add 9,9,30
	addi 11,11,1
	stwx 9,3,19
	stwx 11,3,12
.L526:
	lwz 0,1544(20)
	mr 24,22
	cmpw 0,24,0
	bc 12,0,.L527
.L525:
	li 0,0
	lwz 7,4(14)
	lis 4,.LC126@ha
	lwz 8,4(17)
	la 4,.LC126@l(4)
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
	b .L577
.L549:
	lwz 9,6536(1)
	li 0,0
	stb 0,8(1)
	cmpw 0,24,9
	bc 4,0,.L550
	addi 29,1,2440
	slwi 28,24,2
	lwzx 0,29,28
	lis 9,game+1028@ha
	lis 10,g_edicts@ha
	lwz 8,game+1028@l(9)
	addi 3,1,8
	mulli 9,0,952
	lwz 11,g_edicts@l(10)
	mr 23,3
	mulli 0,0,3864
	addi 9,9,952
	add 30,8,0
	add 31,11,9
	bl strlen
	lwz 11,184(30)
	slwi 9,24,3
	lis 4,.LC127@ha
	addi 27,9,42
	lwzx 6,29,28
	la 4,.LC127@l(4)
	cmpwi 7,11,1000
	lwz 7,3448(30)
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
	bc 12,2,.L552
	mr 3,23
	bl strlen
	lis 4,.LC128@ha
	mr 5,27
	la 4,.LC128@l(4)
	add 3,23,3
	crxor 6,6,6
	bl sprintf
.L552:
	mr 3,23
	subfic 29,22,1000
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L550
	mr 4,23
	mr 3,21
	bl strcat
	mr 25,24
	mr 3,21
	bl strlen
	mr 22,3
.L550:
	lwz 0,4(17)
	cmpw 0,24,0
	bc 4,0,.L547
	addi 29,1,3464
	slwi 28,24,2
	lwzx 0,29,28
	lis 9,game+1028@ha
	lis 10,g_edicts@ha
	lwz 8,game+1028@l(9)
	addi 3,1,8
	mulli 9,0,952
	lwz 11,g_edicts@l(10)
	mr 23,3
	mulli 0,0,3864
	addi 9,9,952
	add 30,8,0
	add 31,11,9
	bl strlen
	lwz 11,184(30)
	slwi 9,24,3
	lis 4,.LC129@ha
	addi 27,9,42
	lwzx 6,29,28
	la 4,.LC129@l(4)
	cmpwi 7,11,1000
	lwz 7,3448(30)
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
	bc 12,2,.L556
	mr 3,23
	bl strlen
	lis 4,.LC130@ha
	mr 5,27
	la 4,.LC130@l(4)
	add 3,23,3
	crxor 6,6,6
	bl sprintf
.L556:
	mr 3,23
	subfic 29,22,1000
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L547
	mr 4,23
	mr 3,21
	bl strcat
	mr 26,24
	mr 3,21
	bl strlen
	mr 22,3
.L547:
	addi 24,24,1
	cmpwi 0,24,15
	bc 12,1,.L546
	lwz 0,6536(1)
.L577:
	cmpw 0,24,0
	bc 12,0,.L549
	lwz 0,4(17)
	cmpw 0,24,0
	bc 12,0,.L549
.L546:
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
	bc 4,1,.L561
	lis 9,maxclients@ha
	lis 10,.LC135@ha
	lwz 11,maxclients@l(9)
	la 10,.LC135@l(10)
	li 24,0
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L561
	lis 9,game@ha
	lis 14,g_edicts@ha
	la 15,game@l(9)
	mr 23,21
	lis 16,0x4330
	li 19,0
	li 20,952
.L565:
	lwz 0,g_edicts@l(14)
	lwz 11,1028(15)
	add 31,0,20
	lwz 9,88(31)
	add 30,11,19
	cmpwi 0,9,0
	bc 12,2,.L564
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L564
	lwz 9,84(31)
	lwz 0,3452(9)
	cmpwi 0,0,0
	bc 4,2,.L564
	cmpwi 0,28,0
	bc 4,2,.L568
	lis 4,.LC131@ha
	mr 5,27
	addi 3,1,8
	la 4,.LC131@l(4)
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
.L568:
	addi 3,1,8
	subfic 29,22,1000
	mr 31,3
	bl strlen
	lwz 11,184(30)
	rlwinm 5,18,0,31,31
	lis 4,.LC132@ha
	cmpwi 4,5,0
	lwz 8,3448(30)
	la 4,.LC132@l(4)
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
	bc 4,1,.L572
	mr 4,31
	mr 3,23
	bl strcat
	mr 3,23
	bl strlen
	mr 22,3
.L572:
	mfcr 0
	rlwinm 0,0,19,1
	addi 9,27,8
	neg 0,0
	addi 18,18,1
	andc 9,9,0
	and 0,27,0
	or 27,0,9
.L564:
	lis 10,maxclients@ha
	addi 24,24,1
	lwz 11,maxclients@l(10)
	xoris 0,24,0x8000
	lis 10,.LC136@ha
	stw 0,6572(1)
	addi 19,19,3864
	la 10,.LC136@l(10)
	stw 16,6568(1)
	addi 20,20,952
	lfd 12,0(10)
	lfd 0,6568(1)
	lfs 13,20(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L565
.L561:
	lwz 0,6536(1)
	subf 0,25,0
	cmpwi 0,0,1
	bc 4,1,.L575
	mr 3,21
	bl strlen
	lwz 6,6536(1)
	slwi 5,25,3
	lis 4,.LC133@ha
	la 4,.LC133@l(4)
	addi 5,5,50
	subf 6,25,6
	add 3,21,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L575:
	lwz 0,4(17)
	subf 0,26,0
	cmpwi 0,0,1
	bc 4,1,.L576
	mr 3,21
	bl strlen
	lwz 6,4(17)
	slwi 5,26,3
	lis 4,.LC134@ha
	la 4,.LC134@l(4)
	addi 5,5,50
	subf 6,26,6
	add 3,21,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L576:
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
.Lfe21:
	.size	 CTFScoreboardMessage,.Lfe21-CTFScoreboardMessage
	.section	".rodata"
	.align 2
.LC137:
	.string	"You already have a TECH powerup."
	.align 2
.LC138:
	.long 0x40000000
	.section	".text"
	.align 2
	.globl CTFPickup_Tech
	.type	 CTFPickup_Tech,@function
CTFPickup_Tech:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 25,12(1)
	stw 0,52(1)
	lis 9,tnames@ha
	mr 27,3
	la 3,tnames@l(9)
	mr 30,4
	lwz 0,0(3)
	lis 25,level@ha
	cmpwi 0,0,0
	bc 12,2,.L588
	lis 9,itemlist@ha
	lis 31,0x286b
	la 28,itemlist@l(9)
	mr 29,3
	lis 9,.LC138@ha
	ori 31,31,51739
	la 9,.LC138@l(9)
	lis 26,.LC137@ha
	lfs 31,0(9)
.L589:
	lwz 3,0(29)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L590
	subf 0,28,3
	lwz 10,84(30)
	mullw 0,0,31
	addi 11,10,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L590
	la 31,level@l(25)
	lfs 13,3852(10)
	lfs 0,4(31)
	fsubs 0,0,13
	fcmpu 0,0,31
	bc 4,1,.L592
	la 4,.LC137@l(26)
	mr 3,30
	crxor 6,6,6
	bl safe_centerprintf
	lfs 0,4(31)
	lwz 9,84(30)
	stfs 0,3852(9)
.L592:
	li 3,0
	b .L594
.L590:
	lwzu 0,4(29)
	cmpwi 0,0,0
	bc 4,2,.L589
.L588:
	lwz 0,648(27)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	lwz 10,84(30)
	subf 0,9,0
	lis 8,level+4@ha
	mullw 0,0,11
	addi 10,10,740
	li 3,1
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
	lfs 0,level+4@l(8)
	lwz 11,84(30)
	stfs 0,3844(11)
.L594:
	lwz 0,52(1)
	mtlr 0
	lmw 25,12(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe22:
	.size	 CTFPickup_Tech,.Lfe22-CTFPickup_Tech
	.section	".rodata"
	.align 2
.LC139:
	.string	"info_player_deathmatch"
	.align 3
.LC140:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC141:
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
	lis 9,tnames@ha
	mr 28,3
	la 3,tnames@l(9)
	lwz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L613
	lis 9,itemlist@ha
	lis 30,0x1b4e
	la 21,itemlist@l(9)
	lis 11,level@ha
	lis 9,TechThink@ha
	lis 27,0x286b
	la 23,TechThink@l(9)
	la 22,level@l(11)
	lis 9,.LC140@ha
	mr 24,3
	la 9,.LC140@l(9)
	ori 30,30,33205
	lfd 31,0(9)
	lis 25,0x4330
	li 26,0
	lis 9,.LC141@ha
	ori 27,27,51739
	la 9,.LC141@l(9)
	lfs 30,0(9)
.L614:
	lwz 3,0(24)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L615
	subf 0,21,3
	lwz 11,84(28)
	mullw 0,0,27
	addi 11,11,740
	rlwinm 31,0,0,0,29
	lwzx 9,11,31
	cmpwi 0,9,0
	bc 12,2,.L615
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
.L615:
	lwzu 0,4(24)
	cmpwi 0,0,0
	bc 4,2,.L614
.L613:
	lwz 0,100(1)
	mtlr 0
	lmw 21,36(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe23:
	.size	 CTFDeadDropTech,.Lfe23-CTFDeadDropTech
	.section	".rodata"
	.align 3
.LC142:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC143:
	.long 0x42c80000
	.align 2
.LC144:
	.long 0x41800000
	.align 2
.LC145:
	.long 0x42700000
	.section	".text"
	.align 2
	.type	 SpawnTech,@function
SpawnTech:
	stwu 1,-112(1)
	mflr 0
	stmw 25,84(1)
	stw 0,116(1)
	mr 28,3
	mr 26,4
	bl G_Spawn
	li 25,0
	lwz 10,0(28)
	mr 29,3
	lis 0,0x1
	stw 0,284(29)
	lis 11,0x4170
	lis 9,0xc170
	stw 10,280(29)
	li 8,512
	lis 27,gi@ha
	stw 28,648(29)
	la 27,gi@l(27)
	lwz 0,28(28)
	stw 8,68(29)
	stw 0,64(29)
	stw 11,208(29)
	stw 11,200(29)
	stw 11,204(29)
	stw 9,196(29)
	stw 9,188(29)
	stw 9,192(29)
	lwz 9,44(27)
	lwz 4,24(28)
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
	stw 25,40(1)
	bl rand
	lis 0,0xb60b
	mr 9,3
	stw 25,48(1)
	ori 0,0,24759
	srawi 10,9,31
	mulhw 0,9,0
	lis 8,0x4330
	lis 7,.LC142@ha
	addi 3,1,40
	add 0,0,9
	la 7,.LC142@l(7)
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
	lfs 0,4(26)
	lis 9,.LC144@ha
	lis 7,.LC143@ha
	la 9,.LC144@l(9)
	la 7,.LC143@l(7)
	lfs 12,0(9)
	addi 3,1,8
	addi 4,29,376
	stfs 0,4(29)
	lfs 13,8(26)
	lfs 1,0(7)
	stfs 13,8(29)
	lfs 0,12(26)
	fadds 0,0,12
	stfs 0,12(29)
	bl VectorScale
	lis 0,0x4396
	lis 7,.LC145@ha
	stw 0,384(29)
	lis 11,level+4@ha
	la 7,.LC145@l(7)
	lfs 0,level+4@l(11)
	lis 9,TechThink@ha
	mr 3,29
	lfs 13,0(7)
	la 9,TechThink@l(9)
	stw 9,436(29)
	fadds 0,0,13
	stfs 0,428(29)
	lwz 0,72(27)
	mtlr 0
	blrl
	lwz 0,116(1)
	mtlr 0
	lmw 25,84(1)
	la 1,112(1)
	blr
.Lfe24:
	.size	 SpawnTech,.Lfe24-SpawnTech
	.section	".sdata","aw"
	.align 2
	.type	 tech.161,@object
	.size	 tech.161,4
tech.161:
	.long 0
	.section	".rodata"
	.align 2
.LC147:
	.string	"ctf/tech1.wav"
	.section	".sdata","aw"
	.align 2
	.type	 tech.165,@object
	.size	 tech.165,4
tech.165:
	.long 0
	.align 2
	.type	 tech.169,@object
	.size	 tech.169,4
tech.169:
	.long 0
	.section	".rodata"
	.align 2
.LC149:
	.string	"ctf/tech2x.wav"
	.align 2
.LC150:
	.string	"ctf/tech2.wav"
	.align 2
.LC148:
	.long 0x3e4ccccd
	.align 2
.LC151:
	.long 0x3f800000
	.align 3
.LC152:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC153:
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
	lis 7,.LC151@ha
	lwz 9,84(31)
	la 7,.LC151@l(7)
	lfs 31,0(7)
	cmpwi 0,9,0
	bc 12,2,.L649
	lwz 0,3768(9)
	cmpwi 0,0,0
	bc 12,2,.L649
	lis 9,.LC148@ha
	lfs 31,.LC148@l(9)
.L649:
	lis 29,tech.169@ha
	lwz 0,tech.169@l(29)
	cmpwi 0,0,0
	bc 4,2,.L656
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,tech.169@l(29)
	bc 12,2,.L651
.L656:
	lwz 8,84(31)
	cmpwi 0,8,0
	bc 12,2,.L651
	lwz 0,tech.169@l(29)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,0
	addi 10,8,740
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L651
	lis 11,level@ha
	lfs 0,3848(8)
	la 9,level@l(11)
	lfs 13,4(9)
	fcmpu 0,0,13
	bc 4,0,.L652
	lis 7,.LC151@ha
	la 7,.LC151@l(7)
	lis 10,0x4330
	lfs 0,0(7)
	lis 7,.LC152@ha
	la 7,.LC152@l(7)
	fadds 0,13,0
	lfd 12,0(7)
	stfs 0,3848(8)
	lwz 0,level@l(11)
	lwz 11,84(31)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	lfs 13,3744(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L653
	lis 29,gi@ha
	lis 3,.LC149@ha
	la 29,gi@l(29)
	la 3,.LC149@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC151@ha
	lis 9,.LC153@ha
	fmr 1,31
	mr 5,3
	la 7,.LC151@l(7)
	la 9,.LC153@l(9)
	li 4,2
	lfs 2,0(7)
	mtlr 0
	mr 3,31
	lfs 3,0(9)
	blrl
	b .L652
.L653:
	lis 29,gi@ha
	lis 3,.LC150@ha
	la 29,gi@l(29)
	la 3,.LC150@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC151@ha
	lis 9,.LC153@ha
	fmr 1,31
	mr 5,3
	la 7,.LC151@l(7)
	la 9,.LC153@l(9)
	li 4,2
	lfs 2,0(7)
	mtlr 0
	mr 3,31
	lfs 3,0(9)
	blrl
.L652:
	li 3,1
	b .L655
.L651:
	li 3,0
.L655:
	lwz 0,52(1)
	mtlr 0
	lmw 29,28(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe25:
	.size	 CTFApplyStrengthSound,.Lfe25-CTFApplyStrengthSound
	.section	".sdata","aw"
	.align 2
	.type	 tech.173,@object
	.size	 tech.173,4
tech.173:
	.long 0
	.align 2
	.type	 tech.177,@object
	.size	 tech.177,4
tech.177:
	.long 0
	.section	".rodata"
	.align 2
.LC155:
	.string	"ctf/tech3.wav"
	.align 2
.LC154:
	.long 0x3e4ccccd
	.align 2
.LC156:
	.long 0x3f800000
	.align 2
.LC157:
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
	lis 9,.LC156@ha
	mr 31,3
	la 9,.LC156@l(9)
	lfs 31,0(9)
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L661
	lwz 0,3768(9)
	cmpwi 0,0,0
	bc 12,2,.L661
	lis 9,.LC154@ha
	lfs 31,.LC154@l(9)
.L661:
	lis 29,tech.177@ha
	lwz 0,tech.177@l(29)
	cmpwi 0,0,0
	bc 4,2,.L664
	lis 3,.LC3@ha
	la 3,.LC3@l(3)
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,tech.177@l(29)
	bc 12,2,.L663
.L664:
	lwz 8,84(31)
	cmpwi 0,8,0
	bc 12,2,.L663
	lwz 0,tech.177@l(29)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,0
	addi 10,8,740
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L663
	lis 9,level+4@ha
	lfs 0,3848(8)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L663
	lis 9,.LC156@ha
	lis 29,gi@ha
	la 9,.LC156@l(9)
	la 29,gi@l(29)
	lfs 0,0(9)
	lis 3,.LC155@ha
	la 3,.LC155@l(3)
	fadds 0,13,0
	stfs 0,3848(8)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC156@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC156@l(9)
	li 4,2
	lfs 2,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC157@ha
	la 9,.LC157@l(9)
	lfs 3,0(9)
	blrl
.L663:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 CTFApplyHasteSound,.Lfe26-CTFApplyHasteSound
	.section	".sdata","aw"
	.align 2
	.type	 tech.181,@object
	.size	 tech.181,4
tech.181:
	.long 0
	.section	".rodata"
	.align 2
.LC159:
	.string	"ctf/tech4.wav"
	.align 2
.LC158:
	.long 0x3e4ccccd
	.align 2
.LC160:
	.long 0x3f800000
	.align 3
.LC161:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC162:
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
	mr 30,3
	lis 9,.LC160@ha
	lwz 29,84(30)
	la 9,.LC160@l(9)
	li 28,0
	lfs 31,0(9)
	cmpwi 0,29,0
	bc 12,2,.L665
	lwz 0,3768(29)
	cmpwi 0,0,0
	bc 12,2,.L667
	lis 9,.LC158@ha
	lfs 31,.LC158@l(9)
.L667:
	lis 31,tech.181@ha
	lwz 0,tech.181@l(31)
	cmpwi 0,0,0
	bc 4,2,.L676
	lis 3,.LC4@ha
	la 3,.LC4@l(3)
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,tech.181@l(31)
	bc 12,2,.L665
.L676:
	lwz 0,tech.181@l(31)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,0
	addi 10,29,740
	mullw 0,0,11
	mr 31,10
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L665
	lis 9,level+4@ha
	lfs 0,3844(29)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L670
	stfs 13,3844(29)
	lwz 9,480(30)
	cmpwi 0,9,149
	bc 12,1,.L671
	addi 0,9,5
	cmpwi 0,0,150
	stw 0,480(30)
	bc 4,1,.L672
	li 0,150
	stw 0,480(30)
.L672:
	lfs 0,3844(29)
	lis 9,.LC161@ha
	li 28,1
	la 9,.LC161@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3844(29)
.L671:
	mr 3,30
	bl ArmorIndex
	mr. 3,3
	bc 12,2,.L670
	slwi 3,3,2
	lwzx 9,31,3
	cmpwi 0,9,149
	bc 12,1,.L670
	addi 0,9,5
	cmpwi 0,0,150
	stwx 0,31,3
	bc 4,1,.L674
	li 0,150
	stwx 0,31,3
.L674:
	lfs 0,3844(29)
	lis 9,.LC161@ha
	li 28,1
	la 9,.LC161@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3844(29)
.L670:
	cmpwi 0,28,0
	bc 12,2,.L665
	lwz 11,84(30)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3848(11)
	fcmpu 0,0,13
	bc 4,0,.L665
	lis 9,.LC160@ha
	lis 29,gi@ha
	la 9,.LC160@l(9)
	la 29,gi@l(29)
	lfs 0,0(9)
	lis 3,.LC159@ha
	la 3,.LC159@l(3)
	fadds 0,13,0
	stfs 0,3848(11)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC160@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC160@l(9)
	li 4,2
	lfs 2,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC162@ha
	la 9,.LC162@l(9)
	lfs 3,0(9)
	blrl
.L665:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 CTFApplyRegeneration,.Lfe27-CTFApplyRegeneration
	.section	".sdata","aw"
	.align 2
	.type	 tech.185,@object
	.size	 tech.185,4
tech.185:
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
	.long .LC163
	.long 2
	.long .LC164
	.long 2
	.long .LC165
	.long 3
	.long .LC166
	.long 4
	.long .LC167
	.long 4
	.long .LC168
	.long 4
	.long .LC169
	.long 4
	.long .LC170
	.long 4
	.long .LC171
	.long 4
	.long .LC172
	.long 4
	.long .LC173
	.long 4
	.long .LC174
	.long 5
	.long .LC175
	.long 5
	.long .LC176
	.long 6
	.long .LC177
	.long 6
	.long .LC178
	.long 6
	.long .LC179
	.long 7
	.long .LC180
	.long 7
	.long .LC181
	.long 7
	.long .LC182
	.long 7
	.long .LC183
	.long 8
	.long .LC184
	.long 8
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC184:
	.string	"item_pack"
	.align 2
.LC183:
	.string	"item_bandolier"
	.align 2
.LC182:
	.string	"item_adrenaline"
	.align 2
.LC181:
	.string	"item_enviro"
	.align 2
.LC180:
	.string	"item_breather"
	.align 2
.LC179:
	.string	"item_silencer"
	.align 2
.LC178:
	.string	"item_armor_jacket"
	.align 2
.LC177:
	.string	"item_armor_combat"
	.align 2
.LC176:
	.string	"item_armor_body"
	.align 2
.LC175:
	.string	"item_power_shield"
	.align 2
.LC174:
	.string	"item_power_screen"
	.align 2
.LC173:
	.string	"weapon_shotgun"
	.align 2
.LC172:
	.string	"weapon_supershotgun"
	.align 2
.LC171:
	.string	"weapon_machinegun"
	.align 2
.LC170:
	.string	"weapon_grenadelauncher"
	.align 2
.LC169:
	.string	"weapon_chaingun"
	.align 2
.LC168:
	.string	"weapon_hyperblaster"
	.align 2
.LC167:
	.string	"weapon_rocketlauncher"
	.align 2
.LC166:
	.string	"weapon_railgun"
	.align 2
.LC165:
	.string	"weapon_bfg"
	.align 2
.LC164:
	.string	"item_invulnerability"
	.align 2
.LC163:
	.string	"item_quad"
	.size	 loc_names,200
	.align 2
.LC186:
	.string	"nowhere"
	.align 2
.LC187:
	.string	"in the water "
	.align 2
.LC188:
	.string	"above "
	.align 2
.LC189:
	.string	"below "
	.align 2
.LC190:
	.string	"near "
	.align 2
.LC191:
	.string	"the red "
	.align 2
.LC192:
	.string	"the blue "
	.align 2
.LC193:
	.string	"the "
	.align 2
.LC185:
	.long 0x497423f0
	.align 2
.LC194:
	.long 0x44800000
	.align 3
.LC195:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC196:
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
	lis 11,.LC185@ha
	la 20,loc_names+4@l(9)
	lfs 31,.LC185@l(11)
	mr 27,3
	lis 9,.LC194@ha
	addi 17,20,-4
	la 9,.LC194@l(9)
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
.L681:
	cmpwi 0,30,0
	bc 4,2,.L684
	lwz 31,g_edicts@l(21)
	b .L685
.L732:
	mr 30,31
	b .L697
.L684:
	addi 31,30,952
.L685:
	la 11,globals@l(15)
	lwz 9,g_edicts@l(21)
	lwz 0,72(11)
	mulli 0,0,952
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L698
	mr 24,11
	addi 28,31,188
	addi 30,31,200
	addi 29,31,4
.L688:
	lwz 0,-112(30)
	cmpwi 0,0,0
	bc 12,2,.L690
	li 0,3
	lis 9,.LC195@ha
	mtctr 0
	la 9,.LC195@l(9)
	mr 8,29
	lfd 10,0(9)
	mr 10,28
	mr 11,30
	li 9,0
.L734:
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
	bdnz .L734
	addi 3,1,24
	bl VectorLength
	fcmpu 0,1,30
	bc 4,1,.L732
.L690:
	lwz 9,72(24)
	addi 31,31,952
	addi 28,28,952
	lwz 0,g_edicts@l(21)
	addi 30,30,952
	addi 29,29,952
	mulli 9,9,952
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L688
.L698:
	li 30,0
.L697:
	cmpwi 0,30,0
	bc 12,2,.L682
	li 31,0
	b .L699
.L701:
	addi 31,31,1
.L699:
	slwi 28,31,3
	lwzx 4,17,28
	mr 29,28
	cmpwi 0,4,0
	bc 12,2,.L681
	lwz 3,280(30)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L701
	lwzx 0,17,29
	cmpwi 0,0,0
	bc 12,2,.L681
	mr 3,30
	mr 4,27
	bl loc_CanSee
	cmpwi 7,22,0
	addic 0,3,-1
	subfe 9,0,3
	mfcr 0
	rlwinm 0,0,31,1
	and. 11,9,0
	bc 12,2,.L706
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
	b .L681
.L706:
	cmpwi 4,3,0
	addic 0,22,-1
	subfe 9,0,22
	mfcr 0
	rlwinm 0,0,19,1
	and. 11,9,0
	bc 4,2,.L681
	bc 12,30,.L708
	lwzx 0,20,29
	cmpw 0,23,0
	bc 12,0,.L681
.L708:
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
	bc 12,0,.L710
	bc 12,18,.L681
	lwzx 0,20,28
	cmpw 0,0,23
	bc 4,0,.L681
.L710:
	mr 26,30
	fmr 31,1
	mr 4,27
	mr 3,26
	mr 23,31
	bl loc_CanSee
	mr 22,3
	b .L681
.L682:
	cmpwi 0,26,0
	bc 4,2,.L711
	b .L735
.L733:
	li 16,1
	b .L713
.L711:
	li 30,0
	lis 31,.LC11@ha
	lis 29,.LC12@ha
	b .L712
.L714:
	cmpw 0,30,26
	bc 12,2,.L712
	la 5,.LC11@l(31)
	li 3,0
	li 4,280
	bl G_Find
	mr. 31,3
	bc 12,2,.L713
	la 5,.LC12@l(29)
	li 3,0
	li 4,280
	bl G_Find
	mr. 30,3
	bc 12,2,.L713
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
	bc 12,0,.L733
	bc 4,1,.L713
	li 16,2
	b .L713
.L712:
	lwz 5,280(26)
	mr 3,30
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L714
.L713:
	lwz 3,280(26)
	bl FindItemByClassname
	mr. 31,3
	bc 4,2,.L721
.L735:
	lis 9,.LC186@ha
	la 11,.LC186@l(9)
	lwz 0,.LC186@l(9)
	lwz 10,4(11)
	stw 0,0(25)
	stw 10,4(25)
	b .L680
.L721:
	lwz 0,612(27)
	cmpwi 0,0,0
	bc 12,2,.L722
	lis 11,.LC187@ha
	lwz 10,.LC187@l(11)
	la 9,.LC187@l(11)
	lhz 8,12(9)
	lwz 0,4(9)
	lwz 11,8(9)
	stw 10,0(25)
	stw 0,4(25)
	stw 11,8(25)
	sth 8,12(25)
	b .L723
.L722:
	stb 0,0(25)
.L723:
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
	bc 4,1,.L724
	fmr 0,10
	fabs 0,0
	fcmpu 0,12,0
	bc 4,1,.L724
	lis 9,.LC196@ha
	la 9,.LC196@l(9)
	lfs 0,0(9)
	fcmpu 0,11,0
	bc 4,1,.L725
	lis 4,.LC188@ha
	mr 3,25
	la 4,.LC188@l(4)
	bl strcat
	b .L727
.L725:
	lis 4,.LC189@ha
	mr 3,25
	la 4,.LC189@l(4)
	bl strcat
	b .L727
.L724:
	lis 4,.LC190@ha
	mr 3,25
	la 4,.LC190@l(4)
	bl strcat
.L727:
	cmpwi 0,16,1
	bc 4,2,.L728
	lis 4,.LC191@ha
	mr 3,25
	la 4,.LC191@l(4)
	bl strcat
	b .L729
.L728:
	cmpwi 0,16,2
	bc 4,2,.L730
	lis 4,.LC192@ha
	mr 3,25
	la 4,.LC192@l(4)
	bl strcat
	b .L729
.L730:
	lis 4,.LC193@ha
	mr 3,25
	la 4,.LC193@l(4)
	bl strcat
.L729:
	lwz 4,40(31)
	mr 3,25
	bl strcat
.L680:
	lwz 0,132(1)
	lwz 12,40(1)
	mtlr 0
	lmw 15,44(1)
	lfd 30,112(1)
	lfd 31,120(1)
	mtcrf 8,12
	la 1,128(1)
	blr
.Lfe28:
	.size	 CTFSay_Team_Location,.Lfe28-CTFSay_Team_Location
	.section	".rodata"
	.align 2
.LC197:
	.string	"cells"
	.align 2
.LC198:
	.string	"%s with %i cells "
	.align 2
.LC199:
	.string	"Power Screen"
	.align 2
.LC200:
	.string	"Power Shield"
	.align 2
.LC201:
	.string	"and "
	.align 2
.LC202:
	.string	"%i units of %s"
	.align 2
.LC203:
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
	bc 12,2,.L737
	lis 3,.LC197@ha
	lwz 29,84(30)
	la 3,.LC197@l(3)
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
	bc 12,2,.L737
	mr 3,31
	bl strlen
	cmpwi 0,28,1
	add 3,31,3
	bc 4,2,.L739
	lis 9,.LC199@ha
	la 5,.LC199@l(9)
	b .L740
.L739:
	lis 9,.LC200@ha
	la 5,.LC200@l(9)
.L740:
	lis 4,.LC198@ha
	mr 6,29
	la 4,.LC198@l(4)
	crxor 6,6,6
	bl sprintf
.L737:
	mr 3,30
	bl ArmorIndex
	mr. 29,3
	bc 12,2,.L741
	mr 3,29
	bl GetItemByIndex
	mr. 28,3
	bc 12,2,.L741
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L743
	lis 4,.LC201@ha
	mr 3,31
	la 4,.LC201@l(4)
	bl strcat
.L743:
	mr 3,31
	bl strlen
	lwz 9,84(30)
	slwi 0,29,2
	lis 4,.LC202@ha
	lwz 6,40(28)
	la 4,.LC202@l(4)
	add 3,31,3
	addi 9,9,740
	lwzx 5,9,0
	crxor 6,6,6
	bl sprintf
.L741:
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 4,2,.L744
	lis 9,.LC203@ha
	lwz 10,.LC203@l(9)
	la 11,.LC203@l(9)
	lbz 0,8(11)
	lwz 9,4(11)
	stb 0,8(31)
	stw 10,0(31)
	stw 9,4(31)
.L744:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 CTFSay_Team_Armor,.Lfe29-CTFSay_Team_Armor
	.section	".rodata"
	.align 2
.LC204:
	.string	"dead"
	.align 2
.LC205:
	.string	"%i health"
	.align 2
.LC206:
	.string	"the %s"
	.align 2
.LC207:
	.string	"no powerup"
	.align 2
.LC208:
	.string	"none"
	.align 2
.LC209:
	.string	", "
	.align 2
.LC210:
	.string	" and "
	.align 2
.LC211:
	.string	"no one"
	.align 2
.LC212:
	.long 0x3f800000
	.align 3
.LC213:
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
	lis 9,.LC212@ha
	stb 27,1032(1)
	li 24,1
	la 9,.LC212@l(9)
	stb 27,8(1)
	lis 19,maxclients@ha
	lfs 13,0(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L759
	lis 11,.LC213@ha
	lis 20,g_edicts@ha
	la 11,.LC213@l(11)
	lis 21,.LC209@ha
	lfd 31,0(11)
	lis 22,0x4330
	li 25,952
.L761:
	lwz 0,g_edicts@l(20)
	add 30,0,25
	lwz 9,88(30)
	xor 0,30,26
	subfic 11,0,0
	adde 0,11,0
	subfic 11,9,0
	adde 9,11,9
	or. 28,9,0
	bc 4,2,.L760
	mr 3,30
	mr 4,26
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L760
	lbz 0,1032(1)
	addi 31,1,1032
	cmpwi 0,0,0
	bc 12,2,.L764
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,3
	cmplwi 0,29,1023
	bc 12,1,.L765
	cmpwi 0,27,0
	bc 12,2,.L766
	addi 3,1,8
	la 4,.LC209@l(21)
	bl strcat
.L766:
	addi 3,1,8
	mr 4,31
	bl strcat
	stb 28,1032(1)
.L765:
	addi 27,27,1
.L764:
	lwz 4,84(30)
	mr 3,31
	addi 4,4,700
	bl strcpy
.L760:
	addi 24,24,1
	lwz 11,maxclients@l(19)
	xoris 0,24,0x8000
	addi 25,25,952
	stw 0,2076(1)
	stw 22,2072(1)
	lfd 0,2072(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L761
.L759:
	lbz 0,1032(1)
	cmpwi 0,0,0
	bc 12,2,.L768
	addi 31,1,1032
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,6
	cmplwi 0,29,1023
	bc 12,1,.L769
	cmpwi 0,27,0
	bc 12,2,.L770
	lis 4,.LC210@ha
	addi 3,1,8
	la 4,.LC210@l(4)
	bl strcat
.L770:
	mr 4,31
	addi 3,1,8
	bl strcat
.L769:
	mr 3,23
	addi 4,1,8
	bl strcpy
	b .L771
.L768:
	lis 9,.LC211@ha
	lwz 10,.LC211@l(9)
	la 11,.LC211@l(9)
	lbz 0,6(11)
	lhz 9,4(11)
	stb 0,6(23)
	stw 10,0(23)
	sth 9,4(23)
.L771:
	lwz 0,2148(1)
	mtlr 0
	lmw 19,2084(1)
	lfd 31,2136(1)
	la 1,2144(1)
	blr
.Lfe30:
	.size	 CTFSay_Team_Sight,.Lfe30-CTFSay_Team_Sight
	.section	".rodata"
	.align 2
.LC214:
	.string	"(%s): %s\n"
	.align 2
.LC215:
	.long 0x0
	.align 3
.LC216:
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
	bc 4,2,.L773
	mr 3,30
	bl strlen
	add 3,3,30
	stb 31,-1(3)
	addi 30,30,1
.L773:
	lbz 9,0(30)
	addi 31,1,8
	lis 23,maxclients@ha
	mr 24,31
	cmpwi 0,9,0
	bc 12,2,.L775
.L777:
	cmpwi 0,9,37
	bc 4,2,.L779
	lbzu 9,1(30)
	addi 9,9,-65
	cmplwi 0,9,54
	bc 12,1,.L805
	lis 11,.L806@ha
	slwi 10,9,2
	la 11,.L806@l(11)
	lis 9,.L806@ha
	lwzx 0,10,11
	la 9,.L806@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L806:
	.long .L784-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L786-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L782-.L806
	.long .L805-.L806
	.long .L804-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L791-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L799-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L784-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L786-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L782-.L806
	.long .L805-.L806
	.long .L804-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L791-.L806
	.long .L805-.L806
	.long .L805-.L806
	.long .L799-.L806
.L782:
	addi 29,1,1032
	mr 3,27
	mr 4,29
	addi 30,30,1
	bl CTFSay_Team_Location
	b .L817
.L784:
	addi 29,1,1032
	mr 3,27
	mr 4,29
	addi 30,30,1
	bl CTFSay_Team_Armor
	b .L817
.L786:
	lwz 5,480(27)
	cmpwi 0,5,0
	bc 12,1,.L787
	lis 9,.LC204@ha
	la 11,.LC204@l(9)
	lwz 0,.LC204@l(9)
	lbz 10,4(11)
	stw 0,1032(1)
	stb 10,1036(1)
	b .L789
.L787:
	lis 4,.LC205@ha
	addi 3,1,1032
	la 4,.LC205@l(4)
	crxor 6,6,6
	bl sprintf
.L789:
	addi 29,1,1032
	mr 3,31
	mr 4,29
	addi 30,30,1
	b .L818
.L816:
	lwz 5,40(3)
	lis 4,.LC206@ha
	addi 3,1,1032
	la 4,.LC206@l(4)
	crxor 6,6,6
	bl sprintf
	b .L796
.L791:
	lis 9,tnames@ha
	addi 30,30,1
	la 3,tnames@l(9)
	addi 25,1,1032
	lwz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L797
	lis 9,itemlist@ha
	lis 29,0x286b
	la 26,itemlist@l(9)
	mr 28,3
	ori 29,29,51739
.L794:
	lwz 3,0(28)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L795
	subf 0,26,3
	lwz 11,84(27)
	mullw 0,0,29
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L816
.L795:
	lwzu 0,4(28)
	cmpwi 0,0,0
	bc 4,2,.L794
.L797:
	lis 9,.LC207@ha
	la 11,.LC207@l(9)
	lwz 10,.LC207@l(9)
	lbz 8,10(11)
	lwz 0,4(11)
	lhz 9,8(11)
	stw 10,1032(1)
	stw 0,1036(1)
	sth 9,1040(1)
	stb 8,1042(1)
.L796:
	mr 3,31
	mr 4,25
	bl strcpy
	mr 3,25
	b .L819
.L799:
	lwz 9,84(27)
	lwz 9,1788(9)
	cmpwi 0,9,0
	bc 12,2,.L800
	lwz 4,40(9)
	addi 3,1,1032
	bl strcpy
	b .L802
.L800:
	lis 9,.LC208@ha
	la 11,.LC208@l(9)
	lwz 0,.LC208@l(9)
	lbz 10,4(11)
	stw 0,1032(1)
	stb 10,1036(1)
.L802:
	addi 29,1,1032
	mr 3,31
	mr 4,29
	addi 30,30,1
	b .L818
.L804:
	addi 29,1,1032
	mr 3,27
	mr 4,29
	addi 30,30,1
	bl CTFSay_Team_Sight
.L817:
	mr 3,31
	mr 4,29
.L818:
	bl strcpy
	mr 3,29
.L819:
	bl strlen
	add 31,31,3
	b .L776
.L805:
	lbz 0,0(30)
	addi 30,30,1
	stb 0,0(31)
	b .L820
.L779:
	stb 9,0(31)
	addi 30,30,1
.L820:
	addi 31,31,1
.L776:
	lbz 9,0(30)
	cmpwi 0,9,0
	bc 12,2,.L775
	subf 0,24,31
	cmplwi 0,0,1022
	bc 4,1,.L777
.L775:
	lis 9,maxclients@ha
	li 0,0
	lwz 11,maxclients@l(9)
	li 30,0
	lis 9,.LC215@ha
	stb 0,0(31)
	la 9,.LC215@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,13,0
	bc 4,0,.L810
	lis 9,.LC216@ha
	lis 26,g_edicts@ha
	la 9,.LC216@l(9)
	lis 28,.LC214@ha
	lfd 31,0(9)
	lis 29,0x4330
	li 31,952
.L812:
	lwz 0,g_edicts@l(26)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L811
	lwz 9,84(3)
	lwz 6,84(27)
	lwz 11,3452(9)
	lwz 0,3452(6)
	cmpw 0,11,0
	bc 4,2,.L811
	addi 6,6,700
	li 4,3
	la 5,.LC214@l(28)
	addi 7,1,8
	crxor 6,6,6
	bl safe_cprintf
.L811:
	addi 30,30,1
	lwz 11,maxclients@l(23)
	xoris 0,30,0x8000
	addi 31,31,952
	stw 0,2076(1)
	stw 29,2072(1)
	lfd 0,2072(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L812
.L810:
	lwz 0,2132(1)
	mtlr 0
	lmw 23,2084(1)
	lfd 31,2120(1)
	la 1,2128(1)
	blr
.Lfe31:
	.size	 CTFSay_Team,.Lfe31-CTFSay_Team
	.section	".rodata"
	.align 2
.LC218:
	.string	"models/ctf/banner/tris.md2"
	.align 2
.LC220:
	.string	"models/ctf/banner/small.md2"
	.globl creditsmenu
	.section	".data"
	.align 2
	.type	 creditsmenu,@object
creditsmenu:
	.long .LC222
	.long 1
	.long 0
	.long 0
	.long .LC223
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC224
	.long 1
	.long 0
	.long 0
	.long .LC225
	.long 1
	.long 0
	.long 0
	.long .LC226
	.long 1
	.long 0
	.long 0
	.long .LC227
	.long 1
	.long 0
	.long 0
	.long .LC228
	.long 1
	.long 0
	.long 0
	.long .LC225
	.long 1
	.long 0
	.long 0
	.long .LC229
	.long 1
	.long 0
	.long 0
	.long .LC230
	.long 1
	.long 0
	.long 0
	.long .LC231
	.long 1
	.long 0
	.long 0
	.long .LC232
	.long 1
	.long 0
	.long 0
	.long .LC233
	.long 1
	.long 0
	.long 0
	.long .LC234
	.long 1
	.long 0
	.long 0
	.long .LC235
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC236
	.long 0
	.long 0
	.long CTFReturnToMain
	.section	".rodata"
	.align 2
.LC236:
	.string	"Return to Main Menu"
	.align 2
.LC235:
	.string	"Brian 'Whaleboy' Cozzens"
	.align 2
.LC234:
	.string	"*Original CTF Art Design"
	.align 2
.LC233:
	.string	"Tom 'Bjorn' Klok"
	.align 2
.LC232:
	.string	"*Sound"
	.align 2
.LC231:
	.string	"Kevin Cloud"
	.align 2
.LC230:
	.string	"Adrian Carmack Paul Steed"
	.align 2
.LC229:
	.string	"*Art"
	.align 2
.LC228:
	.string	"Tim Willits"
	.align 2
.LC227:
	.string	"Christian Antkow"
	.align 2
.LC226:
	.string	"*Level Design"
	.align 2
.LC225:
	.string	"Dave 'Zoid' Kirsch"
	.align 2
.LC224:
	.string	"*Programming"
	.align 2
.LC223:
	.string	"*ThreeWave Capture the Flag"
	.align 2
.LC222:
	.string	"*Quake II"
	.size	 creditsmenu,288
	.globl joinmenu
	.section	".data"
	.align 2
	.type	 joinmenu,@object
joinmenu:
	.long .LC222
	.long 1
	.long 0
	.long 0
	.long .LC223
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
	.long .LC237
	.long 0
	.long 0
	.long CTFJoinTeam1
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC238
	.long 0
	.long 0
	.long CTFJoinTeam2
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC239
	.long 0
	.long 0
	.long CTFChaseCam
	.long .LC240
	.long 0
	.long 0
	.long CTFCredits
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC241
	.long 0
	.long 0
	.long 0
	.long .LC242
	.long 0
	.long 0
	.long 0
	.long .LC243
	.long 0
	.long 0
	.long 0
	.long .LC244
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC245
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC245:
	.string	"v1.02"
	.align 2
.LC244:
	.string	"(TAB to Return)"
	.align 2
.LC243:
	.string	"ESC to Exit Menu"
	.align 2
.LC242:
	.string	"ENTER to select"
	.align 2
.LC241:
	.string	"Use [ and ] to move cursor"
	.align 2
.LC240:
	.string	"Credits"
	.align 2
.LC239:
	.string	"Chase Camera"
	.align 2
.LC238:
	.string	"Join Blue Team"
	.align 2
.LC237:
	.string	"Join Red Team"
	.size	 joinmenu,272
	.lcomm	levelname.237,32,4
	.lcomm	team1players.238,32,4
	.lcomm	team2players.239,32,4
	.align 2
.LC246:
	.string	"Leave Chase Camera"
	.align 2
.LC247:
	.string	"  (%d players)"
	.align 2
.LC248:
	.long 0x0
	.align 3
.LC249:
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
	lis 11,.LC237@ha
	la 29,joinmenu@l(9)
	lis 10,CTFJoinTeam1@ha
	lis 9,.LC238@ha
	lis 8,CTFJoinTeam2@ha
	lis 30,ctf_forcejoin@ha
	la 11,.LC237@l(11)
	lwz 7,ctf_forcejoin@l(30)
	la 10,CTFJoinTeam1@l(10)
	la 9,.LC238@l(9)
	la 8,CTFJoinTeam2@l(8)
	stw 11,64(29)
	mr 31,3
	stw 10,76(29)
	stw 9,96(29)
	stw 8,108(29)
	lwz 3,4(7)
	cmpwi 0,3,0
	bc 12,2,.L857
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L857
	lis 4,.LC119@ha
	la 4,.LC119@l(4)
	bl stricmp
	mr. 3,3
	bc 4,2,.L858
	stw 3,108(29)
	stw 3,96(29)
	b .L857
.L858:
	lwz 9,ctf_forcejoin@l(30)
	lis 4,.LC120@ha
	la 4,.LC120@l(4)
	lwz 3,4(9)
	bl stricmp
	mr. 3,3
	bc 4,2,.L857
	stw 3,76(29)
	stw 3,64(29)
.L857:
	lwz 9,84(31)
	lwz 0,3856(9)
	cmpwi 0,0,0
	bc 12,2,.L861
	lis 9,.LC246@ha
	lis 11,joinmenu+128@ha
	la 9,.LC246@l(9)
	b .L884
.L861:
	lis 9,.LC239@ha
	lis 11,joinmenu+128@ha
	la 9,.LC239@l(9)
.L884:
	stw 9,joinmenu+128@l(11)
	lis 9,g_edicts@ha
	lis 11,levelname.237@ha
	lwz 10,g_edicts@l(9)
	li 0,42
	la 3,levelname.237@l(11)
	stb 0,levelname.237@l(11)
	lwz 4,276(10)
	cmpwi 0,4,0
	bc 12,2,.L863
	addi 3,3,1
	li 5,30
	bl strncpy
	b .L864
.L863:
	lis 4,level+72@ha
	addi 3,3,1
	la 4,level+72@l(4)
	li 5,30
	bl strncpy
.L864:
	lis 9,maxclients@ha
	lis 11,levelname.237+31@ha
	lwz 10,maxclients@l(9)
	li 0,0
	lis 4,.LC248@ha
	la 4,.LC248@l(4)
	stb 0,levelname.237+31@l(11)
	li 31,0
	lfs 0,0(4)
	li 30,0
	li 7,0
	lfs 13,20(10)
	fcmpu 0,0,13
	bc 4,0,.L866
	lis 9,g_edicts@ha
	fmr 12,13
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	la 5,game@l(11)
	lis 6,0x4330
	lis 9,.LC249@ha
	li 8,0
	la 9,.LC249@l(9)
	addi 10,10,1040
	lfd 13,0(9)
.L868:
	lwz 0,0(10)
	addi 10,10,952
	cmpwi 0,0,0
	bc 12,2,.L867
	lwz 9,1028(5)
	add 9,8,9
	lwz 11,3452(9)
	cmpwi 0,11,1
	bc 4,2,.L870
	addi 30,30,1
	b .L867
.L870:
	xori 11,11,2
	addi 9,31,1
	srawi 4,11,31
	xor 0,4,11
	subf 0,0,4
	srawi 0,0,31
	andc 9,9,0
	and 0,31,0
	or 31,0,9
.L867:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,3864
	stw 0,28(1)
	stw 6,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L868
.L866:
	lis 29,.LC247@ha
	lis 3,team1players.238@ha
	la 4,.LC247@l(29)
	mr 5,30
	la 3,team1players.238@l(3)
	crxor 6,6,6
	bl sprintf
	lis 3,team2players.239@ha
	la 4,.LC247@l(29)
	la 3,team2players.239@l(3)
	mr 5,31
	crxor 6,6,6
	bl sprintf
	lis 11,joinmenu@ha
	lis 9,levelname.237@ha
	la 11,joinmenu@l(11)
	la 9,levelname.237@l(9)
	lwz 0,64(11)
	stw 9,32(11)
	cmpwi 0,0,0
	bc 12,2,.L874
	lis 9,team1players.238@ha
	la 9,team1players.238@l(9)
	stw 9,80(11)
	b .L875
.L874:
	stw 0,80(11)
.L875:
	lis 9,joinmenu@ha
	la 11,joinmenu@l(9)
	lwz 0,96(11)
	cmpwi 0,0,0
	bc 12,2,.L876
	lis 9,team2players.239@ha
	la 9,team2players.239@l(9)
	stw 9,112(11)
	b .L877
.L876:
	stw 0,112(11)
.L877:
	cmpw 0,30,31
	bc 12,1,.L885
	cmpw 0,31,30
	bc 4,1,.L879
.L885:
	li 3,1
	b .L883
.L879:
	bl rand
	andi. 0,3,1
	mfcr 3
	rlwinm 3,3,3,1
	neg 3,3
	addi 0,3,1
	rlwinm 3,3,0,30,30
	or 3,3,0
.L883:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe32:
	.size	 CTFUpdateJoinMenu,.Lfe32-CTFUpdateJoinMenu
	.section	".rodata"
	.align 2
.LC250:
	.string	"Capturelimit hit.\n"
	.align 2
.LC251:
	.string	"Couldn't find destination\n"
	.align 2
.LC252:
	.long 0x47800000
	.align 2
.LC253:
	.long 0x43b40000
	.align 2
.LC254:
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
	bc 12,2,.L903
	lwz 5,296(29)
	li 3,0
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L905
	lis 9,gi+4@ha
	lis 3,.LC251@ha
	lwz 0,gi+4@l(9)
	la 3,.LC251@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L903
.L905:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 12,2,.L907
	lwz 3,3832(3)
	cmpwi 0,3,0
	bc 12,2,.L907
	bl CTFResetGrapple
.L907:
	lis 9,gi+76@ha
	mr 3,31
	lwz 0,gi+76@l(9)
	addi 28,31,376
	mtlr 0
	blrl
	lfs 0,4(30)
	lis 9,.LC252@ha
	lis 11,.LC253@ha
	la 9,.LC252@l(9)
	la 11,.LC253@l(11)
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
.L914:
	lwz 10,84(31)
	add 0,6,6
	lfsx 0,7,5
	addi 6,6,1
	addi 9,10,3480
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
	bdnz .L914
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
	stfs 0,3672(9)
	lfs 0,20(30)
	lwz 11,84(31)
	stfs 0,3676(11)
	lfs 13,24(30)
	lwz 9,84(31)
	stfs 13,3680(9)
	lwz 3,84(31)
	addi 3,3,3672
	bl AngleVectors
	lis 9,.LC254@ha
	addi 3,1,8
	la 9,.LC254@l(9)
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
.L903:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe33:
	.size	 old_teleporter_touch,.Lfe33-old_teleporter_touch
	.section	".rodata"
	.align 2
.LC255:
	.string	"teleporter without a target.\n"
	.align 2
.LC256:
	.string	"world/hum1.wav"
	.align 2
.LC257:
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
	bc 4,2,.L916
	lis 9,gi+4@ha
	lis 3,.LC255@ha
	lwz 0,gi+4@l(9)
	la 3,.LC255@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L915
.L916:
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
	lis 9,.LC257@ha
	mtctr 0
	la 9,.LC257@l(9)
	mr 30,3
	lfs 12,0(9)
	addi 8,31,200
	addi 10,31,188
	stw 30,540(31)
	addi 11,30,4
	li 9,0
.L922:
	lfsx 13,9,10
	lfsx 0,9,8
	addi 9,9,4
	fsubs 0,0,13
	fmadds 0,0,12,13
	stfs 0,0(11)
	addi 11,11,4
	bdnz .L922
	lis 29,gi@ha
	lis 3,.LC256@ha
	la 29,gi@l(29)
	la 3,.LC256@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,76(30)
	lwz 0,72(29)
	mr 3,30
	mtlr 0
	blrl
.L915:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 SP_trigger_teleport,.Lfe34-SP_trigger_teleport
	.comm	ctf,4,4
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
	li 5,4
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
	bc 4,2,.L36
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	bl FindItemByClassname
	stw 3,flag1_item@l(31)
.L36:
	lis 29,flag2_item@ha
	lwz 0,flag2_item@l(29)
	cmpwi 0,0,0
	bc 4,2,.L37
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	bl FindItemByClassname
	stw 3,flag2_item@l(29)
.L37:
	lis 3,ctfgame@ha
	li 4,0
	la 3,ctfgame@l(3)
	li 5,24
	crxor 6,6,6
	bl memset
	lis 9,techspawn@ha
	li 0,0
	stw 0,techspawn@l(9)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 CTFInit,.Lfe35-CTFInit
	.align 2
	.globl SP_info_player_team1
	.type	 SP_info_player_team1,@function
SP_info_player_team1:
	blr
.Lfe36:
	.size	 SP_info_player_team1,.Lfe36-SP_info_player_team1
	.align 2
	.globl SP_info_player_team2
	.type	 SP_info_player_team2,@function
SP_info_player_team2:
	blr
.Lfe37:
	.size	 SP_info_player_team2,.Lfe37-SP_info_player_team2
	.align 2
	.globl CTFTeamName
	.type	 CTFTeamName,@function
CTFTeamName:
	cmpwi 0,3,1
	bc 12,2,.L40
	cmpwi 0,3,2
	bc 12,2,.L41
	b .L39
.L40:
	lis 3,.LC13@ha
	la 3,.LC13@l(3)
	blr
.L41:
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	blr
.L39:
	lis 3,.LC15@ha
	la 3,.LC15@l(3)
	blr
.Lfe38:
	.size	 CTFTeamName,.Lfe38-CTFTeamName
	.align 2
	.globl CTFOtherTeamName
	.type	 CTFOtherTeamName,@function
CTFOtherTeamName:
	cmpwi 0,3,1
	bc 12,2,.L46
	cmpwi 0,3,2
	bc 12,2,.L47
	b .L45
.L46:
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	blr
.L47:
	lis 3,.LC13@ha
	la 3,.LC13@l(3)
	blr
.L45:
	lis 3,.LC15@ha
	la 3,.LC15@l(3)
	blr
.Lfe39:
	.size	 CTFOtherTeamName,.Lfe39-CTFOtherTeamName
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
	bc 12,2,.L329
	lis 5,.LC52@ha
	mr 3,31
	la 5,.LC52@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L330
.L329:
	lis 5,.LC53@ha
	mr 3,31
	la 5,.LC53@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L330:
	li 3,0
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe40:
	.size	 CTFDrop_Flag,.Lfe40-CTFDrop_Flag
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
	lwz 0,3476(9)
	cmpwi 0,0,0
	bc 12,2,.L357
	lis 5,.LC65@ha
	la 5,.LC65@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,0
	b .L926
.L357:
	lis 5,.LC66@ha
	mr 3,31
	la 5,.LC66@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,1
.L926:
	stw 0,3476(9)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe41:
	.size	 CTFID_f,.Lfe41-CTFID_f
	.align 2
	.globl CTFResetFlag
	.type	 CTFResetFlag,@function
CTFResetFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	cmpwi 0,3,1
	bc 12,2,.L182
	cmpwi 0,3,2
	bc 12,2,.L183
	b .L180
.L182:
	lis 9,.LC11@ha
	la 29,.LC11@l(9)
	b .L181
.L183:
	lis 9,.LC12@ha
	la 29,.LC12@l(9)
.L181:
	lis 9,gi@ha
	li 31,0
	la 28,gi@l(9)
	li 30,1
	b .L186
.L188:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L189
	mr 3,31
	bl G_FreeEdict
	b .L186
.L189:
	lwz 0,184(31)
	mr 3,31
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(28)
	mtlr 9
	blrl
	stw 30,80(31)
.L186:
	mr 3,31
	li 4,280
	mr 5,29
	bl G_Find
	mr. 31,3
	bc 4,2,.L188
.L180:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe42:
	.size	 CTFResetFlag,.Lfe42-CTFResetFlag
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
	lwz 0,3452(9)
	cmpwi 0,0,1
	bc 4,2,.L177
	lis 9,flag2_item@ha
	lwz 10,flag2_item@l(9)
	b .L178
.L177:
	lis 9,flag1_item@ha
	lwz 10,flag1_item@l(9)
.L178:
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
	lwz 9,3452(3)
	lwz 0,3452(8)
	cmpw 0,9,0
	bclr 12,2
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	stfs 0,3460(8)
	blr
.Lfe43:
	.size	 CTFCheckHurtCarrier,.Lfe43-CTFCheckHurtCarrier
	.align 2
	.globl CTFPlayerResetGrapple
	.type	 CTFPlayerResetGrapple,@function
CTFPlayerResetGrapple:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L430
	lwz 3,3832(3)
	cmpwi 0,3,0
	bc 12,2,.L430
	bl CTFResetGrapple
.L430:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe44:
	.size	 CTFPlayerResetGrapple,.Lfe44-CTFPlayerResetGrapple
	.section	".rodata"
	.align 2
.LC258:
	.long 0x3e4ccccd
	.align 2
.LC259:
	.long 0x3f800000
	.align 2
.LC260:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFResetGrapple
	.type	 CTFResetGrapple,@function
CTFResetGrapple:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 29,12(1)
	stw 0,36(1)
	mr 31,3
	lwz 30,256(31)
	lwz 9,84(30)
	lwz 0,3832(9)
	cmpwi 0,0,0
	bc 12,2,.L432
	lwz 0,3768(9)
	lis 9,.LC259@ha
	cmpwi 0,0,0
	la 9,.LC259@l(9)
	lfs 31,0(9)
	bc 12,2,.L433
	lis 9,.LC258@ha
	lfs 31,.LC258@l(9)
.L433:
	lis 29,gi@ha
	lis 3,.LC86@ha
	la 29,gi@l(29)
	la 3,.LC86@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC259@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC259@l(9)
	mr 3,30
	lfs 2,0(9)
	mtlr 0
	li 4,17
	lis 9,.LC260@ha
	la 9,.LC260@l(9)
	lfs 3,0(9)
	blrl
	lwz 11,256(31)
	li 8,0
	lis 10,level+4@ha
	mr 3,31
	lwz 9,84(11)
	stw 8,3832(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 8,3836(9)
	andi. 0,0,191
	stfs 0,3840(9)
	stb 0,16(9)
	bl G_FreeEdict
.L432:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe45:
	.size	 CTFResetGrapple,.Lfe45-CTFResetGrapple
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
	bc 12,2,.L582
	lis 9,itemlist@ha
	lis 31,0x286b
	la 28,itemlist@l(9)
	mr 30,3
	ori 31,31,51739
.L583:
	lwz 3,0(30)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L584
	subf 0,28,3
	lwz 11,84(29)
	mullw 0,0,31
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L927
.L584:
	lwzu 0,4(30)
	cmpwi 0,0,0
	bc 4,2,.L583
.L582:
	li 3,0
.L927:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe46:
	.size	 CTFWhat_Tech,.Lfe46-CTFWhat_Tech
	.section	".rodata"
	.align 2
.LC261:
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
	lis 9,.LC261@ha
	lis 11,level+4@ha
	la 9,.LC261@l(9)
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
.Lfe47:
	.size	 CTFDrop_Tech,.Lfe47-CTFDrop_Tech
	.section	".rodata"
	.align 2
.LC262:
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
	lis 31,techspawn@ha
	lwz 0,techspawn@l(31)
	cmpwi 0,0,0
	bc 4,2,.L638
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 0,11,8
	bc 4,2,.L638
	bl G_Spawn
	lis 9,.LC262@ha
	lis 11,level+4@ha
	la 9,.LC262@l(9)
	lfs 0,level+4@l(11)
	li 0,1
	lfs 13,0(9)
	lis 9,SpawnTechs@ha
	la 9,SpawnTechs@l(9)
	fadds 0,0,13
	stw 9,436(3)
	stfs 0,428(3)
	stw 0,techspawn@l(31)
.L638:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe48:
	.size	 CTFSetupTechSpawn,.Lfe48-CTFSetupTechSpawn
	.section	".rodata"
	.align 2
.LC263:
	.long 0x3e4ccccd
	.align 2
.LC264:
	.long 0x3f800000
	.align 2
.LC265:
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
	mr 30,3
	lis 11,.LC264@ha
	lwz 9,84(30)
	la 11,.LC264@l(11)
	mr 31,4
	lfs 31,0(11)
	cmpwi 0,9,0
	bc 12,2,.L642
	lwz 0,3768(9)
	cmpwi 0,0,0
	bc 12,2,.L642
	lis 9,.LC263@ha
	lfs 31,.LC263@l(9)
.L642:
	lis 29,tech.161@ha
	lwz 0,tech.161@l(29)
	cmpwi 0,0,0
	bc 4,2,.L643
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	bl FindItemByClassname
	stw 3,tech.161@l(29)
.L643:
	cmpwi 0,31,0
	bc 12,2,.L644
	lwz 10,tech.161@l(29)
	cmpwi 0,10,0
	bc 12,2,.L644
	lwz 11,84(30)
	cmpwi 0,11,0
	bc 12,2,.L644
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
	bc 12,2,.L644
	lis 29,gi@ha
	lis 3,.LC147@ha
	la 29,gi@l(29)
	la 3,.LC147@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC264@ha
	lis 11,.LC265@ha
	fmr 1,31
	mr 5,3
	la 9,.LC264@l(9)
	la 11,.LC265@l(11)
	mr 3,30
	lfs 2,0(9)
	mtlr 0
	li 4,2
	lfs 3,0(11)
	blrl
	srwi 3,31,31
	add 3,31,3
	srawi 3,3,1
	b .L928
.L644:
	mr 3,31
.L928:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe49:
	.size	 CTFApplyResistance,.Lfe49-CTFApplyResistance
	.align 2
	.globl CTFApplyStrength
	.type	 CTFApplyStrength,@function
CTFApplyStrength:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 31,tech.165@ha
	mr 29,3
	lwz 0,tech.165@l(31)
	mr 30,4
	cmpwi 0,0,0
	bc 4,2,.L646
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	bl FindItemByClassname
	stw 3,tech.165@l(31)
.L646:
	cmpwi 0,30,0
	bc 12,2,.L647
	lwz 11,tech.165@l(31)
	cmpwi 0,11,0
	bc 12,2,.L647
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 12,2,.L647
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,11
	mullw 9,9,0
	addi 11,3,740
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L647
	slwi 3,30,1
	b .L929
.L647:
	mr 3,30
.L929:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe50:
	.size	 CTFApplyStrength,.Lfe50-CTFApplyStrength
	.align 2
	.globl CTFApplyHaste
	.type	 CTFApplyHaste,@function
CTFApplyHaste:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 31,tech.173@ha
	mr 30,3
	lwz 0,tech.173@l(31)
	cmpwi 0,0,0
	bc 4,2,.L931
	lis 3,.LC3@ha
	la 3,.LC3@l(3)
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,tech.173@l(31)
	bc 12,2,.L659
.L931:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 12,2,.L659
	lwz 0,tech.173@l(31)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,0
	addi 10,3,740
	mullw 0,0,11
	li 3,1
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L930
.L659:
	li 3,0
.L930:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe51:
	.size	 CTFApplyHaste,.Lfe51-CTFApplyHaste
	.align 2
	.globl CTFHasRegeneration
	.type	 CTFHasRegeneration,@function
CTFHasRegeneration:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 31,tech.185@ha
	mr 30,3
	lwz 0,tech.185@l(31)
	cmpwi 0,0,0
	bc 4,2,.L933
	lis 3,.LC4@ha
	la 3,.LC4@l(3)
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,tech.185@l(31)
	bc 12,2,.L679
.L933:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 12,2,.L679
	lwz 0,tech.185@l(31)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,0
	addi 10,3,740
	mullw 0,0,11
	li 3,1
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L932
.L679:
	li 3,0
.L932:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe52:
	.size	 CTFHasRegeneration,.Lfe52-CTFHasRegeneration
	.align 2
	.globl CTFRespawnTech
	.type	 CTFRespawnTech,@function
CTFRespawnTech:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	li 30,0
	bl rand
	srawi 0,3,31
	srwi 0,0,28
	add 0,3,0
	rlwinm 0,0,0,0,27
	subf 31,0,3
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L635
	lis 29,.LC139@ha
.L634:
	mr 3,30
	li 4,280
	la 5,.LC139@l(29)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L634
.L635:
	cmpwi 0,30,0
	bc 4,2,.L934
	lis 5,.LC139@ha
	li 3,0
	la 5,.LC139@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 12,2,.L631
.L934:
	lwz 3,648(28)
	mr 4,30
	bl SpawnTech
.L631:
	mr 3,28
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe53:
	.size	 CTFRespawnTech,.Lfe53-CTFRespawnTech
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
	lwz 0,3856(9)
	cmpwi 0,0,0
	bc 12,2,.L887
	li 5,8
	b .L888
.L887:
	xori 9,5,1
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	rlwinm 0,0,0,29,30
	ori 5,0,4
.L888:
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
.Lfe54:
	.size	 CTFOpenJoinMenu,.Lfe54-CTFOpenJoinMenu
	.align 2
	.globl CTFStartClient
	.type	 CTFStartClient,@function
CTFStartClient:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 8,84(31)
	lwz 0,3452(8)
	cmpwi 0,0,0
	bc 4,2,.L894
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 10,11,0x2
	bc 4,2,.L894
	lwz 0,184(31)
	li 9,1
	lis 11,gi+72@ha
	stw 9,260(31)
	mr 3,31
	ori 0,0,1
	stw 10,248(31)
	stw 0,184(31)
	stw 10,3452(8)
	lwz 9,84(31)
	stw 10,88(9)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	mr 3,31
	bl CTFUpdateJoinMenu
	lwz 9,84(31)
	mr 5,3
	lwz 0,3856(9)
	cmpwi 0,0,0
	bc 12,2,.L895
	li 5,8
	b .L896
.L895:
	xori 9,5,1
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	rlwinm 0,0,0,29,30
	ori 5,0,4
.L896:
	lis 4,joinmenu@ha
	mr 3,31
	la 4,joinmenu@l(4)
	li 6,17
	bl PMenu_Open
	li 3,1
	b .L935
.L894:
	li 3,0
.L935:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe55:
	.size	 CTFStartClient,.Lfe55-CTFStartClient
	.section	".rodata"
	.align 2
.LC266:
	.long 0x0
	.align 3
.LC267:
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
	lis 11,.LC266@ha
	lis 9,capturelimit@ha
	la 11,.LC266@l(11)
	lfs 0,0(11)
	lwz 11,capturelimit@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L901
	lis 9,ctfgame@ha
	lwz 0,ctfgame@l(9)
	la 8,ctfgame@l(9)
	lis 10,0x4330
	lis 9,.LC267@ha
	xoris 0,0,0x8000
	la 9,.LC267@l(9)
	stw 0,12(1)
	stw 10,8(1)
	lfd 12,0(9)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 12,3,.L902
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
	bc 4,3,.L901
.L902:
	lis 4,.LC250@ha
	li 3,2
	la 4,.LC250@l(4)
	crxor 6,6,6
	bl safe_bprintf
	li 3,1
	b .L936
.L901:
	li 3,0
.L936:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe56:
	.size	 CTFCheckRules,.Lfe56-CTFCheckRules
	.section	".rodata"
	.align 3
.LC268:
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
	lis 3,.LC218@ha
	stw 0,260(31)
	la 30,gi@l(9)
	la 3,.LC218@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,284(31)
	stw 3,40(31)
	andi. 9,0,1
	bc 12,2,.L823
	li 0,1
	stw 0,60(31)
.L823:
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
	lis 11,.LC268@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC268@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe57:
	.size	 SP_misc_ctf_banner,.Lfe57-SP_misc_ctf_banner
	.section	".rodata"
	.align 3
.LC269:
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
	lis 3,.LC220@ha
	stw 0,260(31)
	la 30,gi@l(9)
	la 3,.LC220@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,284(31)
	stw 3,40(31)
	andi. 9,0,1
	bc 12,2,.L825
	li 0,1
	stw 0,60(31)
.L825:
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
	lis 11,.LC269@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC269@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe58:
	.size	 SP_misc_ctf_small_banner,.Lfe58-SP_misc_ctf_small_banner
	.section	".rodata"
	.align 2
.LC270:
	.long 0x41800000
	.section	".text"
	.align 2
	.globl SP_info_teleport_destination
	.type	 SP_info_teleport_destination,@function
SP_info_teleport_destination:
	lis 9,.LC270@ha
	lfs 0,12(3)
	la 9,.LC270@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,12(3)
	blr
.Lfe59:
	.size	 SP_info_teleport_destination,.Lfe59-SP_info_teleport_destination
	.comm	ctfgame,24,4
	.comm	ctf_forcejoin,4,4
	.align 2
	.globl stuffcmd
	.type	 stuffcmd,@function
stuffcmd:
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
.Lfe60:
	.size	 stuffcmd,.Lfe60-stuffcmd
	.section	".sbss","aw",@nobits
	.align 2
flag1_item:
	.space	4
	.size	 flag1_item,4
	.align 2
flag2_item:
	.space	4
	.size	 flag2_item,4
	.section	".text"
	.align 2
	.globl CTFOtherTeam
	.type	 CTFOtherTeam,@function
CTFOtherTeam:
	cmpwi 0,3,1
	bc 12,2,.L52
	cmpwi 0,3,2
	bc 12,2,.L53
	b .L51
.L52:
	li 3,2
	blr
.L53:
	li 3,1
	blr
.L51:
	li 3,-1
	blr
.Lfe61:
	.size	 CTFOtherTeam,.Lfe61-CTFOtherTeam
	.section	".rodata"
	.align 2
.LC271:
	.long 0x41e00000
	.section	".text"
	.align 2
	.type	 CTFDropFlagTouch,@function
CTFDropFlagTouch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,256(3)
	cmpw 0,4,0
	bc 4,2,.L271
	lis 9,level+4@ha
	lfs 0,428(3)
	lis 11,.LC271@ha
	lfs 13,level+4@l(9)
	la 11,.LC271@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,1,.L270
.L271:
	bl Touch_Item
.L270:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe62:
	.size	 CTFDropFlagTouch,.Lfe62-CTFDropFlagTouch
	.section	".rodata"
	.align 3
.LC272:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.type	 CTFFlagThink,@function
CTFFlagThink:
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 12,2,.L332
	lwz 9,56(3)
	addi 9,9,-172
	srawi 0,9,31
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	addi 9,9,173
	stw 9,56(3)
.L332:
	lis 9,level+4@ha
	lis 11,.LC272@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC272@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe63:
	.size	 CTFFlagThink,.Lfe63-CTFFlagThink
	.section	".rodata"
	.align 3
.LC273:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC274:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC275:
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
	lis 11,.LC273@ha
	stw 0,72(1)
	la 11,.LC273@l(11)
	addi 4,31,376
	lfd 0,0(11)
	mr 3,30
	lfd 1,72(1)
	fsub 1,1,0
	frsp 1,1
	bl VectorScale
	lwz 11,64(31)
	lis 0,0x600
	li 9,0
	li 10,8
	li 8,2
	stw 9,200(31)
	ori 0,0,3
	or 11,11,26
	stw 10,260(31)
	lis 29,gi@ha
	stw 8,248(31)
	lis 3,.LC104@ha
	la 29,gi@l(29)
	stw 0,252(31)
	la 3,.LC104@l(3)
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
	li 0,0
	la 9,CTFGrappleTouch@l(9)
	stw 25,516(31)
	mr 3,31
	stw 9,444(31)
	stw 27,256(31)
	lwz 9,84(27)
	stw 31,3832(9)
	lwz 11,84(27)
	stw 0,3836(11)
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
	lis 9,.LC274@ha
	la 9,.LC274@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L474
	lis 11,.LC275@ha
	mr 3,24
	la 11,.LC275@l(11)
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
.L474:
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe64:
	.size	 CTFFireGrapple,.Lfe64-CTFFireGrapple
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
.Lfe65:
	.size	 CTFWeapon_Grapple_Fire,.Lfe65-CTFWeapon_Grapple_Fire
	.section	".rodata"
	.align 2
.LC276:
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
	lis 9,.LC276@ha
	lfs 13,3852(11)
	la 9,.LC276@l(9)
	lfs 12,0(9)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L579
	lis 4,.LC137@ha
	la 4,.LC137@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	lfs 0,4(30)
	lwz 9,84(31)
	stfs 0,3852(9)
.L579:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe66:
	.size	 CTFHasTech,.Lfe66-CTFHasTech
	.section	".rodata"
	.align 2
.LC277:
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
	bc 12,2,.L606
	lis 28,.LC139@ha
.L605:
	mr 3,30
	li 4,280
	la 5,.LC139@l(28)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L605
.L606:
	cmpwi 0,30,0
	bc 4,2,.L938
	lis 5,.LC139@ha
	li 3,0
	la 5,.LC139@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 12,2,.L602
.L938:
	lwz 3,648(29)
	mr 4,30
	bl SpawnTech
	mr 3,29
	bl G_FreeEdict
	b .L609
.L602:
	lis 9,.LC277@ha
	lis 11,level+4@ha
	la 9,.LC277@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,TechThink@ha
	la 9,TechThink@l(9)
	fadds 0,0,13
	stw 9,436(29)
	stfs 0,428(29)
.L609:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe67:
	.size	 TechThink,.Lfe67-TechThink
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
	bc 12,2,.L620
	mr 26,9
	lis 25,.LC139@ha
.L621:
	slwi 0,31,2
	addi 27,31,1
	lwzx 3,26,0
	bl FindItemByClassname
	mr. 28,3
	bc 12,2,.L622
	bl rand
	li 30,0
	srawi 0,3,31
	srwi 0,0,28
	add 0,3,0
	rlwinm 0,0,0,0,27
	subf 31,0,3
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L626
	lis 29,.LC139@ha
.L625:
	mr 3,30
	li 4,280
	la 5,.LC139@l(29)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L625
.L626:
	cmpwi 0,30,0
	bc 4,2,.L939
	li 3,0
	li 4,280
	la 5,.LC139@l(25)
	bl G_Find
	mr. 30,3
	bc 12,2,.L622
.L939:
	mr 3,28
	mr 4,30
	bl SpawnTech
.L622:
	mr 31,27
	slwi 0,31,2
	lwzx 9,26,0
	cmpwi 0,9,0
	bc 4,2,.L621
.L620:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe68:
	.size	 SpawnTechs,.Lfe68-SpawnTechs
	.section	".rodata"
	.align 3
.LC278:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.type	 misc_ctf_banner_think,@function
misc_ctf_banner_think:
	lwz 9,56(3)
	lis 10,level+4@ha
	lis 11,.LC278@ha
	lfd 13,.LC278@l(11)
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
.Lfe69:
	.size	 misc_ctf_banner_think,.Lfe69-misc_ctf_banner_think
	.align 2
	.globl CTFJoinTeam
	.type	 CTFJoinTeam,@function
CTFJoinTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	mr 31,4
	bl PMenu_Close
	lwz 0,184(29)
	li 10,0
	lis 4,.LC123@ha
	lwz 11,84(29)
	la 4,.LC123@l(4)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	stw 31,3452(11)
	lwz 9,84(29)
	stw 10,3456(9)
	lwz 3,84(29)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,29
	bl CTFAssignSkin
	mr 3,29
	bl PutClientInServer
	lwz 8,84(29)
	li 0,6
	li 11,32
	stw 0,80(29)
	li 10,14
	cmpwi 0,31,1
	stb 11,16(8)
	lwz 9,84(29)
	stb 10,17(9)
	lwz 11,84(29)
	addi 5,11,700
	bc 12,2,.L827
	cmpwi 0,31,2
	bc 12,2,.L828
	b .L831
.L827:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L830
.L828:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L830
.L831:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L830:
	lis 4,.LC124@ha
	li 3,2
	la 4,.LC124@l(4)
	crxor 6,6,6
	bl safe_bprintf
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe70:
	.size	 CTFJoinTeam,.Lfe70-CTFJoinTeam
	.align 2
	.globl CTFJoinTeam1
	.type	 CTFJoinTeam1,@function
CTFJoinTeam1:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 28,1
	bl PMenu_Close
	lwz 0,184(29)
	li 10,0
	lis 4,.LC123@ha
	lwz 11,84(29)
	la 4,.LC123@l(4)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	stw 28,3452(11)
	lwz 9,84(29)
	stw 10,3456(9)
	lwz 3,84(29)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,29
	bl CTFAssignSkin
	mr 3,29
	bl PutClientInServer
	lwz 11,84(29)
	li 0,6
	li 9,32
	stw 0,80(29)
	li 10,14
	lis 6,.LC13@ha
	stb 9,16(11)
	lis 4,.LC124@ha
	la 6,.LC13@l(6)
	lwz 9,84(29)
	la 4,.LC124@l(4)
	li 3,2
	stb 10,17(9)
	lwz 5,84(29)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe71:
	.size	 CTFJoinTeam1,.Lfe71-CTFJoinTeam1
	.align 2
	.globl CTFJoinTeam2
	.type	 CTFJoinTeam2,@function
CTFJoinTeam2:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 28,2
	bl PMenu_Close
	lwz 0,184(29)
	li 10,0
	lis 4,.LC123@ha
	lwz 11,84(29)
	la 4,.LC123@l(4)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	stw 28,3452(11)
	lwz 9,84(29)
	stw 10,3456(9)
	lwz 3,84(29)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,29
	bl CTFAssignSkin
	mr 3,29
	bl PutClientInServer
	lwz 11,84(29)
	li 0,6
	li 9,32
	stw 0,80(29)
	li 10,14
	lis 6,.LC14@ha
	stb 9,16(11)
	lis 4,.LC124@ha
	la 6,.LC14@l(6)
	lwz 9,84(29)
	la 4,.LC124@l(4)
	li 3,2
	stb 10,17(9)
	lwz 5,84(29)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe72:
	.size	 CTFJoinTeam2,.Lfe72-CTFJoinTeam2
	.section	".rodata"
	.align 3
.LC279:
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
	lwz 0,3856(9)
	cmpwi 0,0,0
	bc 12,2,.L847
	li 0,0
	stw 0,3856(9)
	bl PMenu_Close
	b .L846
.L847:
	li 8,1
	b .L848
.L850:
	addi 8,8,1
.L848:
	xoris 0,8,0x8000
	lis 9,0x4330
	stw 0,20(1)
	lis 11,.LC279@ha
	la 11,.LC279@l(11)
	stw 9,16(1)
	lfd 12,0(11)
	lfd 0,16(1)
	lis 11,maxclients@ha
	lwz 9,maxclients@l(11)
	fsub 0,0,12
	lfs 13,20(9)
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L846
	lis 9,g_edicts@ha
	mulli 11,8,952
	lwz 0,g_edicts@l(9)
	add 11,0,11
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L850
	lwz 0,248(11)
	cmpwi 0,0,0
	bc 12,2,.L850
	lwz 9,84(31)
	mr 3,31
	stw 11,3856(9)
	bl PMenu_Close
	lwz 9,84(31)
	li 0,1
	stw 0,3860(9)
.L846:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe73:
	.size	 CTFChaseCam,.Lfe73-CTFChaseCam
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
.Lfe74:
	.size	 CTFReturnToMain,.Lfe74-CTFReturnToMain
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
.Lfe75:
	.size	 CTFCredits,.Lfe75-CTFCredits
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
	stw 0,3524(11)
	lwz 9,84(29)
	stw 10,3536(9)
	bl DeathmatchScoreboard
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe76:
	.size	 CTFShowScores,.Lfe76-CTFShowScores
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
