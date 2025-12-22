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
	.ascii	" 246 num 2 10 xv 296 pic 9 endif if 11 xv 148 pic 11 endif x"
	.ascii	"r\t-50 yt 2 num 3 14 yb -129 if 26 x"
	.string	"r -26 pic 26 endif yb -102 if 17 xr -26 pic 17 endif xr -62 num 2 18 if 22 yb -104 xr -28 pic 22 endif yb -75 if 19 xr -26 pic 19 endif xr -62 num 2 20 if 23 yb -77 xr -28 pic 23 endif if 21 yt 26 xr -24 pic 21 endif if 27 xv 0 yb -58 stat_string 27 endif "
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
	lis 0,0xf3b3
	lwz 9,g_edicts@l(11)
	ori 0,0,8069
	mr 30,4
	lis 11,.LC22@ha
	lfs 0,20(10)
	la 11,.LC22@l(11)
	subf 9,9,29
	lfs 13,0(11)
	mullw 9,9,0
	srawi 9,9,2
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
	lwz 3,3464(9)
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
	stw 8,3468(31)
	bc 4,2,.L67
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 0,11,2
	bc 4,2,.L67
	stw 8,3464(31)
	b .L65
.L67:
	lis 11,.LC24@ha
	lis 9,maxclients@ha
	la 11,.LC24@l(11)
	li 10,1
	lfs 0,0(11)
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L69
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	addi 11,11,1332
	lfd 13,0(9)
.L71:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L70
	lwz 9,84(11)
	cmpw 0,9,31
	bc 12,2,.L70
	lwz 0,3464(9)
	cmpwi 0,0,1
	bc 12,2,.L75
	cmpwi 0,0,2
	bc 12,2,.L76
	b .L70
.L75:
	addi 8,8,1
	b .L70
.L76:
	addi 7,7,1
.L70:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,1332
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L71
.L69:
	cmpw 0,8,7
	bc 4,0,.L80
	li 0,1
	b .L86
.L80:
	cmpw 0,7,8
	bc 12,0,.L84
	bl rand
	andi. 0,3,1
	li 0,1
	bc 4,2,.L86
.L84:
	li 0,2
.L86:
	stw 0,3464(31)
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
	lwz 0,3468(9)
	cmpwi 0,0,0
	bc 12,2,.L88
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,512
	bc 12,2,.L112
	bl SelectFarthestDeathmatchSpawnPoint
	b .L111
.L88:
	li 0,1
	stw 0,3468(9)
	lwz 9,84(3)
	lwz 3,3464(9)
	cmpwi 0,3,1
	bc 12,2,.L92
	cmpwi 0,3,2
	bc 12,2,.L93
	b .L112
.L92:
	lis 9,.LC26@ha
	la 27,.LC26@l(9)
	b .L91
.L93:
	lis 9,.LC27@ha
	la 27,.LC27@l(9)
.L91:
	lis 9,.LC28@ha
	li 30,0
	lfs 31,.LC28@l(9)
	li 28,0
	li 29,0
	fmr 30,31
	b .L96
.L98:
	mr 3,30
	addi 31,31,1
	bl PlayersRangeFromSpot
	fcmpu 0,1,30
	bc 4,0,.L99
	fmr 30,1
	mr 29,30
	b .L96
.L99:
	fcmpu 0,1,31
	bc 4,0,.L96
	fmr 31,1
	mr 28,30
.L96:
	mr 3,30
	li 4,280
	mr 5,27
	bl G_Find
	mr. 30,3
	bc 4,2,.L98
	cmpwi 0,31,0
	bc 4,2,.L103
.L112:
	bl SelectRandomDeathmatchSpawnPoint
	b .L111
.L103:
	cmpwi 0,31,2
	bc 12,1,.L104
	li 28,0
	li 29,0
	b .L105
.L104:
	addi 31,31,-2
.L105:
	bl rand
	li 30,0
	divw 0,3,31
	mullw 0,0,31
	subf 31,0,3
.L110:
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
	bc 4,2,.L110
.L111:
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
	.long 0x40000000
	.align 2
.LC39:
	.long 0x3f800000
	.align 3
.LC40:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC41:
	.long 0x41000000
	.align 2
.LC42:
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
	bc 12,2,.L113
	lwz 0,84(27)
	cmpwi 0,0,0
	mr 8,0
	bc 12,2,.L113
	lwz 0,84(28)
	xor 9,27,28
	subfic 11,9,0
	adde 9,11,9
	mr 7,0
	subfic 10,0,0
	adde 0,10,0
	or. 11,0,9
	bc 4,2,.L113
	lwz 0,3464(8)
	cmpwi 0,0,1
	bc 12,2,.L117
	cmpwi 0,0,2
	bc 12,2,.L118
	b .L121
.L117:
	li 30,2
	b .L120
.L118:
	li 30,1
	b .L120
.L121:
	li 30,-1
.L120:
	cmpwi 0,30,0
	bc 12,0,.L113
	lwz 0,3464(8)
	cmpwi 0,0,1
	bc 4,2,.L123
	lis 9,flag1_item@ha
	lis 11,flag2_item@ha
	lwz 26,flag1_item@l(9)
	lwz 0,flag2_item@l(11)
	b .L124
.L123:
	lis 9,flag2_item@ha
	lis 11,flag1_item@ha
	lwz 26,flag2_item@l(9)
	lwz 0,flag1_item@l(11)
.L124:
	lis 9,itemlist@ha
	lis 10,0x38e3
	la 6,itemlist@l(9)
	ori 10,10,36409
	subf 0,6,0
	addi 11,8,740
	mullw 0,0,10
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L125
	lis 9,level@ha
	lis 10,.LC38@ha
	la 31,level@l(9)
	la 10,.LC38@l(10)
	lfs 0,4(31)
	lfs 13,0(10)
	stfs 0,3484(7)
	lwz 9,84(28)
	lfs 0,3512(9)
	fadds 0,0,13
	stfs 0,3512(9)
	lwz 0,968(28)
	cmpwi 0,0,0
	bc 4,2,.L126
	lis 9,gi+8@ha
	lis 5,.LC29@ha
	lwz 0,gi+8@l(9)
	la 5,.LC29@l(5)
	mr 3,28
	li 4,1
	li 6,2
	mtlr 0
	crxor 6,6,6
	blrl
.L126:
	lis 9,niq_enable@ha
	lis 10,.LC37@ha
	lwz 11,niq_enable@l(9)
	la 10,.LC37@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L127
	lis 9,niq_logfile@ha
	lwz 11,niq_logfile@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L127
	lwz 4,84(28)
	lis 3,gi@ha
	lis 6,.LC30@ha
	lfs 1,4(31)
	la 3,gi@l(3)
	la 6,.LC30@l(6)
	addi 4,4,700
	li 5,0
	li 7,0
	li 8,2
	bl sl_LogScore
.L127:
	lis 9,maxclients@ha
	lis 10,.LC39@ha
	lwz 11,maxclients@l(9)
	la 10,.LC39@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	li 10,1
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L113
	lis 9,g_edicts@ha
	mr 8,11
	lwz 11,g_edicts@l(9)
	li 6,0
	lis 7,0x4330
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	addi 11,11,1332
	lfd 12,0(9)
.L131:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L130
	lwz 9,84(11)
	lwz 0,3464(9)
	cmpw 0,0,30
	bc 4,2,.L130
	stw 6,3472(9)
.L130:
	addi 10,10,1
	lfs 13,20(8)
	xoris 0,10,0x8000
	addi 11,11,1332
	stw 0,44(1)
	stw 7,40(1)
	lfd 0,40(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L131
	b .L113
.L125:
	lis 11,.LC37@ha
	lfs 12,3472(8)
	la 11,.LC37@l(11)
	lfs 0,0(11)
	fcmpu 0,12,0
	bc 12,2,.L134
	lis 9,level+4@ha
	lis 11,.LC41@ha
	lfs 0,level+4@l(9)
	la 11,.LC41@l(11)
	lfs 13,0(11)
	fsubs 0,0,12
	fcmpu 0,0,13
	bc 4,0,.L134
	subf 0,6,26
	addi 11,7,740
	mullw 0,0,10
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L134
	lis 9,.LC38@ha
	lfs 0,3512(7)
	la 9,.LC38@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,3512(7)
	lwz 9,84(28)
	lwz 0,3464(9)
	addi 5,9,700
	cmpwi 0,0,1
	bc 12,2,.L135
	cmpwi 0,0,2
	bc 12,2,.L136
	b .L139
.L135:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L138
.L136:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L138
.L139:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L138:
	lis 4,.LC31@ha
	li 3,1
	la 4,.LC31@l(4)
	crxor 6,6,6
	bl my_bprintf
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 13,0(9)
	lis 9,niq_enable@ha
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L113
	lis 9,niq_logfile@ha
	lwz 11,niq_logfile@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L113
	lis 9,level+4@ha
	lwz 4,84(28)
	lis 3,gi@ha
	lfs 1,level+4@l(9)
	lis 6,.LC32@ha
	la 3,gi@l(3)
	addi 4,4,700
	la 6,.LC32@l(6)
	li 5,0
	li 7,0
	li 8,2
	bl sl_LogScore
	b .L113
.L134:
	lwz 0,3464(7)
	cmpwi 0,0,1
	bc 12,2,.L142
	cmpwi 0,0,2
	bc 12,2,.L143
	b .L113
.L142:
	lis 9,.LC11@ha
	la 29,.LC11@l(9)
	b .L141
.L143:
	lis 9,.LC12@ha
	la 29,.LC12@l(9)
.L141:
	li 30,0
.L149:
	mr 3,30
	li 4,280
	mr 5,29
	bl G_Find
	mr. 30,3
	mcrf 7,0
	bc 12,30,.L113
	lwz 0,284(30)
	andis. 9,0,1
	bc 4,2,.L149
	bc 12,30,.L113
	lis 9,maxclients@ha
	lis 10,.LC39@ha
	lfs 11,4(27)
	lwz 11,maxclients@l(9)
	la 10,.LC39@l(10)
	lfs 0,0(10)
	lfs 13,20(11)
	li 10,1
	lfs 10,4(30)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L152
	lis 9,itemlist@ha
	lis 11,g_edicts@ha
	fmr 12,13
	lis 0,0x38e3
	la 9,itemlist@l(9)
	lwz 7,g_edicts@l(11)
	ori 0,0,36409
	subf 9,9,26
	mullw 9,9,0
	lis 11,.LC40@ha
	lis 6,0x4330
	la 11,.LC40@l(11)
	lfd 13,0(11)
	srawi 9,9,3
	li 11,1332
	slwi 8,9,2
.L154:
	add 31,7,11
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L155
	lwz 9,84(31)
	addi 9,9,740
	lwzx 0,9,8
	cmpwi 0,0,0
	bc 4,2,.L152
.L155:
	addi 10,10,1
	xoris 0,10,0x8000
	li 31,0
	stw 0,44(1)
	addi 11,11,1332
	stw 6,40(1)
	lfd 0,40(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L154
.L152:
	fsubs 10,11,10
	lfs 13,8(27)
	lis 9,.LC42@ha
	addi 3,1,8
	lfs 12,12(27)
	la 9,.LC42@l(9)
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
	bc 12,0,.L158
	addi 29,1,24
	mr 3,29
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L158
	mr 3,30
	mr 4,27
	bl loc_CanSee
	cmpwi 0,3,0
	bc 4,2,.L158
	mr 3,30
	mr 4,28
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L157
.L158:
	lwz 9,84(28)
	lis 10,.LC39@ha
	la 10,.LC39@l(10)
	lfs 0,3512(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,3512(9)
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 4,2,.L159
	lwz 9,84(28)
	lwz 0,3464(9)
	addi 5,9,700
	cmpwi 0,0,1
	bc 12,2,.L160
	cmpwi 0,0,2
	bc 12,2,.L161
	b .L164
.L160:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L163
.L161:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L163
.L164:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L163:
	lis 4,.LC33@ha
	li 3,1
	la 4,.LC33@l(4)
	crxor 6,6,6
	bl my_bprintf
	b .L165
.L159:
	lwz 9,84(28)
	lwz 0,3464(9)
	addi 5,9,700
	cmpwi 0,0,1
	bc 12,2,.L166
	cmpwi 0,0,2
	bc 12,2,.L167
	b .L170
.L166:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L169
.L167:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L169
.L170:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L169:
	lis 4,.LC34@ha
	li 3,1
	la 4,.LC34@l(4)
	crxor 6,6,6
	bl my_bprintf
.L165:
	lis 9,niq_enable@ha
	lis 10,.LC37@ha
	lwz 11,niq_enable@l(9)
	la 10,.LC37@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L113
	lis 9,niq_logfile@ha
	lwz 11,niq_logfile@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L113
	lis 9,level+4@ha
	lwz 4,84(28)
	lis 3,gi@ha
	lfs 1,level+4@l(9)
	lis 6,.LC35@ha
	la 3,gi@l(3)
	addi 4,4,700
	la 6,.LC35@l(6)
	li 5,0
	li 7,0
	li 8,1
	bl sl_LogScore
	b .L113
.L157:
	xor 0,31,28
	addic 9,31,-1
	subfe 11,9,31
	addic 10,0,-1
	subfe 9,10,0
	and. 0,11,9
	bc 12,2,.L113
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
	bc 12,2,.L113
.L174:
	lwz 11,84(28)
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 13,0(9)
	lfs 0,3512(11)
	fadds 0,0,13
	stfs 0,3512(11)
	lwz 9,84(28)
	lwz 0,3464(9)
	addi 5,9,700
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
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 13,0(9)
	lis 9,niq_enable@ha
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L113
	lis 9,niq_logfile@ha
	lwz 11,niq_logfile@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L113
	lis 9,level+4@ha
	lwz 4,84(28)
	lis 3,gi@ha
	lfs 1,level+4@l(9)
	lis 6,.LC32@ha
	la 3,gi@l(3)
	addi 4,4,700
	la 6,.LC32@l(6)
	li 5,0
	li 7,0
	li 8,1
	bl sl_LogScore
.L113:
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
	b .L205
.L207:
	lwz 0,284(31)
	andis. 11,0,1
	bc 12,2,.L208
	mr 3,31
	bl RemoveFromItemList
	mr 3,31
	bl G_FreeEdict
	b .L205
.L208:
	lwz 0,184(31)
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	stw 30,80(31)
.L205:
	mr 3,31
	li 4,280
	mr 5,29
	li 30,1
	bl G_Find
	mr. 31,3
	lis 9,gi+72@ha
	mr 3,31
	bc 4,2,.L207
	lis 9,.LC12@ha
	lis 11,gi@ha
	la 28,.LC12@l(9)
	la 29,gi@l(11)
	li 31,0
	b .L216
.L218:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L219
	mr 3,31
	bl RemoveFromItemList
	mr 3,31
	bl G_FreeEdict
	b .L216
.L219:
	lwz 0,184(31)
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(29)
	mtlr 9
	blrl
	stw 30,80(31)
.L216:
	mr 3,31
	li 4,280
	mr 5,28
	bl G_Find
	mr. 31,3
	mr 3,31
	bc 4,2,.L218
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 CTFResetFlags,.Lfe7-CTFResetFlags
	.section	".rodata"
	.align 2
.LC43:
	.string	"Don't know what team the flag is on.\n"
	.align 2
.LC44:
	.string	"%s captured the %s flag!\n"
	.align 2
.LC45:
	.string	"F Capture"
	.align 2
.LC46:
	.string	"ctf/flagcap.wav"
	.align 2
.LC47:
	.string	"Team Score"
	.align 2
.LC48:
	.string	"%s gets an assist for returning the flag!\n"
	.align 2
.LC49:
	.string	"F Return Assist"
	.align 2
.LC50:
	.string	"%s gets an assist for fragging the flag carrier!\n"
	.align 2
.LC51:
	.string	"FC Frag Assist"
	.align 2
.LC52:
	.string	"%s returned the %s flag!\n"
	.align 2
.LC53:
	.string	"F Return"
	.align 2
.LC54:
	.string	"ctf/flagret.wav"
	.align 2
.LC55:
	.string	"%s got the %s flag!\n"
	.align 2
.LC56:
	.string	"F Pickup"
	.align 2
.LC57:
	.long 0x0
	.align 2
.LC58:
	.long 0x3f800000
	.align 2
.LC59:
	.long 0x41700000
	.align 2
.LC60:
	.long 0x41200000
	.align 2
.LC61:
	.long 0x40000000
	.align 3
.LC62:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFPickup_Flag
	.type	 CTFPickup_Flag,@function
CTFPickup_Flag:
	stwu 1,-80(1)
	mflr 0
	mfcr 12
	stfd 31,72(1)
	stmw 21,28(1)
	stw 0,84(1)
	stw 12,24(1)
	mr 30,4
	mr 31,3
	lwz 3,280(31)
	lis 4,.LC11@ha
	la 4,.LC11@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L223
	li 28,1
	b .L224
.L223:
	lwz 3,280(31)
	lis 4,.LC12@ha
	la 4,.LC12@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L225
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L284
	lis 9,gi+8@ha
	lis 5,.LC43@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC43@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L284
.L225:
	li 28,2
.L224:
	cmpwi 4,28,1
	bc 4,18,.L228
	lis 9,flag1_item@ha
	lis 11,flag2_item@ha
	lwz 27,flag1_item@l(9)
	lwz 29,flag2_item@l(11)
	b .L229
.L228:
	lis 9,flag2_item@ha
	lis 11,flag1_item@ha
	lwz 27,flag2_item@l(9)
	lwz 29,flag1_item@l(11)
.L229:
	lwz 0,968(30)
	cmpwi 0,0,0
	bc 12,2,.L230
	lwz 0,416(30)
	cmpw 0,0,31
	bc 4,2,.L230
	li 0,0
	stw 0,416(30)
.L230:
	lwz 5,84(30)
	lwz 0,3464(5)
	cmpw 0,28,0
	bc 4,2,.L231
	lwz 0,284(31)
	andis. 9,0,1
	bc 4,2,.L232
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,29
	addi 11,5,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L284
	addi 5,5,700
	bc 12,18,.L234
	cmpwi 0,28,2
	bc 12,2,.L235
	b .L238
.L234:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L237
.L235:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L237
.L238:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L237:
	lis 4,.LC44@ha
	li 3,2
	la 4,.LC44@l(4)
	lis 22,gi@ha
	crxor 6,6,6
	bl my_bprintf
	lis 25,niq_enable@ha
	lis 21,level@ha
	lis 9,.LC57@ha
	lis 0,0x38e3
	lwz 10,84(30)
	la 9,.LC57@l(9)
	ori 0,0,36409
	lfs 13,0(9)
	lis 11,niq_enable@ha
	addi 10,10,740
	lis 9,itemlist@ha
	lwz 8,niq_enable@l(11)
	la 9,itemlist@l(9)
	subf 9,9,29
	mullw 9,9,0
	li 0,0
	srawi 9,9,3
	slwi 9,9,2
	stwx 0,10,9
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L239
	lis 9,niq_logfile@ha
	lwz 11,niq_logfile@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L239
	la 9,level@l(21)
	lwz 4,84(30)
	lis 6,.LC45@ha
	lfs 1,4(9)
	la 6,.LC45@l(6)
	la 3,gi@l(22)
	addi 4,4,700
	li 5,0
	li 7,0
	li 8,15
	bl sl_LogScore
.L239:
	lis 9,level+4@ha
	lis 10,ctfgame@ha
	lfs 0,level+4@l(9)
	la 11,ctfgame@l(10)
	stw 28,20(11)
	stfs 0,16(11)
	bc 4,18,.L240
	lwz 9,ctfgame@l(10)
	addi 9,9,1
	stw 9,ctfgame@l(10)
	b .L241
.L240:
	lwz 9,4(11)
	addi 9,9,1
	stw 9,4(11)
.L241:
	lis 29,gi@ha
	lis 3,.LC46@ha
	la 29,gi@l(29)
	la 3,.LC46@l(3)
	lwz 9,36(29)
	li 26,1
	lis 23,maxclients@ha
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC58@ha
	lis 10,.LC57@ha
	lis 11,.LC57@ha
	la 9,.LC58@l(9)
	la 10,.LC57@l(10)
	la 11,.LC57@l(11)
	lfs 1,0(9)
	mtlr 0
	mr 5,3
	lfs 2,0(10)
	li 4,26
	lfs 3,0(11)
	mr 3,31
	blrl
	lwz 11,84(30)
	lis 9,.LC59@ha
	la 9,.LC59@l(9)
	lfs 13,0(9)
	lfs 0,3512(11)
	lis 9,maxclients@ha
	lwz 10,maxclients@l(9)
	lis 9,.LC58@ha
	fadds 0,0,13
	la 9,.LC58@l(9)
	lfs 12,0(9)
	stfs 0,3512(11)
	lfs 13,20(10)
	fcmpu 0,12,13
	cror 3,2,0
	bc 4,3,.L243
	lis 10,.LC60@ha
	lis 27,niq_logfile@ha
	la 10,.LC60@l(10)
	li 28,1332
	lfs 31,0(10)
	lis 24,0x4330
.L245:
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	add 29,0,28
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L244
	lwz 0,968(29)
	cmpwi 0,0,0
	bc 12,2,.L247
	lwz 0,324(29)
	cmpw 0,0,30
	bc 4,2,.L247
	li 0,0
	stw 0,324(29)
.L247:
	lwz 10,84(29)
	lwz 9,84(30)
	lwz 11,3464(10)
	lwz 0,3464(9)
	cmpw 0,11,0
	bc 12,2,.L283
	lis 0,0xc0a0
	stw 0,3472(10)
	b .L244
.L283:
	cmpw 0,29,30
	bc 12,2,.L251
	lfs 0,3512(10)
	lis 11,.LC57@ha
	lwz 9,niq_enable@l(25)
	la 11,.LC57@l(11)
	lfs 12,0(11)
	fadds 0,0,31
	stfs 0,3512(10)
	lfs 13,20(9)
	fcmpu 0,13,12
	bc 12,2,.L251
	lwz 9,niq_logfile@l(27)
	lfs 0,20(9)
	fcmpu 0,0,12
	bc 12,2,.L251
	la 9,level@l(21)
	lwz 4,84(29)
	lis 6,.LC47@ha
	lfs 1,4(9)
	la 6,.LC47@l(6)
	la 3,gi@l(22)
	addi 4,4,700
	li 5,0
	li 7,0
	li 8,10
	bl sl_LogScore
.L251:
	lwz 5,84(29)
	la 31,level@l(21)
	lfs 13,4(31)
	lfs 0,3476(5)
	fadds 0,0,31
	fcmpu 0,0,13
	bc 4,1,.L253
	lis 4,.LC48@ha
	addi 5,5,700
	la 4,.LC48@l(4)
	li 3,2
	crxor 6,6,6
	bl my_bprintf
	lis 9,.LC57@ha
	lis 10,.LC58@ha
	lwz 11,niq_enable@l(25)
	la 9,.LC57@l(9)
	la 10,.LC58@l(10)
	lfs 12,0(9)
	lwz 9,84(29)
	lfs 13,0(10)
	lfs 0,3512(9)
	fadds 0,0,13
	stfs 0,3512(9)
	lfs 13,20(11)
	fcmpu 0,13,12
	bc 12,2,.L253
	lwz 9,niq_logfile@l(27)
	lfs 0,20(9)
	fcmpu 0,0,12
	bc 12,2,.L253
	lwz 4,84(29)
	lis 6,.LC49@ha
	la 3,gi@l(22)
	lfs 1,4(31)
	la 6,.LC49@l(6)
	li 5,0
	li 7,0
	li 8,1
	addi 4,4,700
	bl sl_LogScore
.L253:
	lwz 5,84(29)
	la 31,level@l(21)
	lfs 13,4(31)
	lfs 0,3484(5)
	fadds 0,0,31
	fcmpu 0,0,13
	bc 4,1,.L244
	lis 4,.LC50@ha
	addi 5,5,700
	la 4,.LC50@l(4)
	li 3,2
	crxor 6,6,6
	bl my_bprintf
	lis 9,.LC57@ha
	lis 10,.LC61@ha
	lwz 11,niq_enable@l(25)
	la 9,.LC57@l(9)
	la 10,.LC61@l(10)
	lfs 12,0(9)
	lwz 9,84(29)
	lfs 13,0(10)
	lfs 0,3512(9)
	fadds 0,0,13
	stfs 0,3512(9)
	lfs 13,20(11)
	fcmpu 0,13,12
	bc 12,2,.L244
	lwz 9,niq_logfile@l(27)
	lfs 0,20(9)
	fcmpu 0,0,12
	bc 12,2,.L244
	lwz 4,84(29)
	lis 6,.LC51@ha
	la 3,gi@l(22)
	lfs 1,4(31)
	la 6,.LC51@l(6)
	li 5,0
	addi 4,4,700
	li 7,0
	li 8,2
	bl sl_LogScore
.L244:
	addi 26,26,1
	lwz 11,maxclients@l(23)
	xoris 0,26,0x8000
	lis 10,.LC62@ha
	stw 0,20(1)
	la 10,.LC62@l(10)
	addi 28,28,1332
	stw 24,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L245
.L243:
	bl CTFResetFlags
.L284:
	li 3,0
	b .L282
.L232:
	addi 5,5,700
	bc 12,18,.L258
	cmpwi 0,28,2
	bc 12,2,.L259
	b .L262
.L258:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L261
.L259:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L261
.L262:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L261:
	lis 4,.LC52@ha
	li 3,2
	la 4,.LC52@l(4)
	lis 22,gi@ha
	crxor 6,6,6
	bl my_bprintf
	lis 21,level@ha
	lis 9,.LC57@ha
	la 9,.LC57@l(9)
	lfs 13,0(9)
	lis 9,niq_enable@ha
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L263
	lis 9,niq_logfile@ha
	lwz 11,niq_logfile@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L263
	la 9,level@l(21)
	lwz 4,84(30)
	lis 6,.LC53@ha
	lfs 1,4(9)
	la 3,gi@l(22)
	la 6,.LC53@l(6)
	addi 4,4,700
	li 5,0
	li 7,0
	li 8,1
	bl sl_LogScore
.L263:
	lwz 11,84(30)
	lis 9,.LC58@ha
	lis 10,level+4@ha
	la 9,.LC58@l(9)
	lis 29,gi@ha
	lfs 0,3512(11)
	la 29,gi@l(29)
	lis 3,.LC54@ha
	lfs 13,0(9)
	la 3,.LC54@l(3)
	fadds 0,0,13
	stfs 0,3512(11)
	lfs 0,level+4@l(10)
	lwz 9,84(30)
	stfs 0,3476(9)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC58@ha
	lis 10,.LC57@ha
	lis 11,.LC57@ha
	mr 5,3
	la 9,.LC58@l(9)
	la 10,.LC57@l(10)
	mtlr 0
	la 11,.LC57@l(11)
	li 4,26
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	bc 12,18,.L264
	cmpwi 0,28,2
	bc 12,2,.L265
	b .L284
.L264:
	lis 9,.LC11@ha
	la 30,.LC11@l(9)
	b .L267
.L265:
	lis 9,.LC12@ha
	la 30,.LC12@l(9)
.L267:
	lis 9,gi@ha
	li 29,0
	la 28,gi@l(9)
	li 31,1
	b .L269
.L271:
	lwz 0,284(29)
	andis. 9,0,1
	bc 12,2,.L272
	mr 3,29
	bl RemoveFromItemList
	mr 3,29
	bl G_FreeEdict
	b .L269
.L272:
	lwz 0,184(29)
	mr 3,29
	stw 31,248(29)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	lwz 9,72(28)
	mtlr 9
	blrl
	stw 31,80(29)
.L269:
	mr 3,29
	li 4,280
	mr 5,30
	bl G_Find
	mr. 29,3
	bc 4,2,.L271
	b .L284
.L231:
	addi 5,5,700
	bc 12,18,.L275
	cmpwi 0,28,2
	bc 12,2,.L276
	b .L279
.L275:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L278
.L276:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L278
.L279:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L278:
	lis 4,.LC55@ha
	li 3,2
	la 4,.LC55@l(4)
	lis 21,level@ha
	crxor 6,6,6
	bl my_bprintf
	lwz 11,84(30)
	lis 9,.LC57@ha
	la 9,.LC57@l(9)
	lfs 12,0(9)
	lfs 0,3512(11)
	lis 9,niq_enable@ha
	lwz 10,niq_enable@l(9)
	fadds 0,0,12
	stfs 0,3512(11)
	lfs 13,20(10)
	fcmpu 0,13,12
	bc 12,2,.L280
	lis 9,niq_logfile@ha
	lwz 11,niq_logfile@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L280
	la 9,level@l(21)
	lwz 4,84(30)
	lis 3,gi@ha
	lfs 1,4(9)
	lis 6,.LC56@ha
	la 3,gi@l(3)
	addi 4,4,700
	la 6,.LC56@l(6)
	li 5,0
	li 7,0
	li 8,0
	bl sl_LogScore
.L280:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 10,84(30)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,27
	addi 10,10,740
	mullw 9,9,0
	li 8,1
	lis 7,level+4@ha
	srawi 9,9,3
	slwi 9,9,2
	stwx 8,10,9
	lfs 0,level+4@l(7)
	lwz 11,84(30)
	stfs 0,3480(11)
	lwz 0,284(31)
	andis. 11,0,0x1
	bc 4,2,.L281
	lwz 0,264(31)
	lwz 9,184(31)
	oris 0,0,0x8000
	stw 11,248(31)
	ori 9,9,1
	stw 0,264(31)
	stw 9,184(31)
.L281:
	li 3,1
.L282:
	lwz 0,84(1)
	lwz 12,24(1)
	mtlr 0
	lmw 21,28(1)
	lfd 31,72(1)
	mtcrf 8,12
	la 1,80(1)
	blr
.Lfe8:
	.size	 CTFPickup_Flag,.Lfe8-CTFPickup_Flag
	.section	".rodata"
	.align 2
.LC63:
	.string	"The %s flag has returned!\n"
	.align 3
.LC64:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC65:
	.long 0x41f00000
	.align 2
.LC66:
	.long 0x447a0000
	.section	".text"
	.align 2
	.type	 CTFDropFlagThink,@function
CTFDropFlagThink:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 27,20(1)
	stw 0,52(1)
	lis 11,.LC65@ha
	lis 9,level+4@ha
	la 11,.LC65@l(11)
	lfs 0,level+4@l(9)
	mr 29,3
	lfs 12,0(11)
	lfs 13,288(29)
	fsubs 0,0,12
	fcmpu 0,13,0
	bc 4,0,.L288
	lwz 3,280(29)
	lis 31,.LC11@ha
	la 4,.LC11@l(31)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L289
	la 30,.LC11@l(31)
	li 31,0
	b .L295
.L297:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L298
	mr 3,31
	bl RemoveFromItemList
	mr 3,31
	bl G_FreeEdict
	b .L295
.L298:
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
.L295:
	mr 3,31
	li 4,280
	mr 5,30
	bl G_Find
	mr. 31,3
	bc 4,2,.L297
	lis 5,.LC13@ha
	lis 4,.LC63@ha
	la 4,.LC63@l(4)
	la 5,.LC13@l(5)
	b .L331
.L289:
	lwz 3,280(29)
	lis 31,.LC12@ha
	la 4,.LC12@l(31)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L324
	la 30,.LC12@l(31)
	li 31,0
	b .L313
.L315:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L316
	mr 3,31
	bl RemoveFromItemList
	mr 3,31
	bl G_FreeEdict
	b .L313
.L316:
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
.L313:
	mr 3,31
	li 4,280
	mr 5,30
	bl G_Find
	mr. 31,3
	bc 4,2,.L315
	lis 5,.LC14@ha
	lis 4,.LC63@ha
	la 4,.LC63@l(4)
	la 5,.LC14@l(5)
.L331:
	li 3,2
	crxor 6,6,6
	bl my_bprintf
	b .L324
.L288:
	lis 9,num_players@ha
	li 30,0
	lwz 0,num_players@l(9)
	lis 27,num_players@ha
	cmpw 0,30,0
	bc 4,0,.L326
	lis 11,.LC66@ha
	lis 9,players@ha
	la 11,.LC66@l(11)
	la 28,players@l(9)
	lfs 31,0(11)
	li 31,0
.L328:
	lwzx 4,31,28
	mr 3,29
	bl entdist
	fcmpu 0,1,31
	bc 12,1,.L327
	lwzx 9,31,28
	stw 29,416(9)
.L327:
	lwz 0,num_players@l(27)
	addi 30,30,1
	addi 31,31,4
	cmpw 0,30,0
	bc 12,0,.L328
.L326:
	lis 9,level+4@ha
	lis 11,.LC64@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC64@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
.L324:
	lwz 0,52(1)
	mtlr 0
	lmw 27,20(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe9:
	.size	 CTFDropFlagThink,.Lfe9-CTFDropFlagThink
	.section	".rodata"
	.align 2
.LC67:
	.string	"%s lost the %s flag!\n"
	.align 3
.LC68:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC69:
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
	lis 11,.LC69@ha
	lis 9,ctf@ha
	la 11,.LC69@l(11)
	mr 30,3
	lfs 13,0(11)
	li 26,0
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L332
	lis 9,flag1_item@ha
	lwz 0,flag1_item@l(9)
	cmpwi 0,0,0
	bc 12,2,.L335
	lis 9,flag2_item@ha
	lwz 0,flag2_item@l(9)
	cmpwi 0,0,0
	bc 4,2,.L334
.L335:
	bl CTFInit
.L334:
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 10,84(30)
	lwz 4,flag1_item@l(9)
	la 29,itemlist@l(11)
	lis 31,0x38e3
	ori 31,31,36409
	addi 10,10,740
	subf 0,29,4
	mullw 0,0,31
	srawi 0,0,3
	slwi 0,0,2
	lwzx 27,10,0
	cmpwi 0,27,0
	bc 12,2,.L336
	mr 3,30
	bl Drop_Item
	lis 9,flag1_item@ha
	li 11,0
	lwz 0,flag1_item@l(9)
	mr 26,3
	lis 6,.LC13@ha
	lwz 9,84(30)
	lis 4,.LC67@ha
	la 6,.LC13@l(6)
	subf 0,29,0
	la 4,.LC67@l(4)
	mullw 0,0,31
	addi 9,9,740
	li 3,2
	srawi 0,0,3
	slwi 0,0,2
	stwx 11,9,0
	lwz 5,84(30)
	addi 5,5,700
	crxor 6,6,6
	bl my_bprintf
	b .L342
.L336:
	lis 28,flag2_item@ha
	lwz 4,flag2_item@l(28)
	subf 0,29,4
	mullw 0,0,31
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L342
	mr 3,30
	bl Drop_Item
	lwz 0,flag2_item@l(28)
	mr 26,3
	lis 6,.LC14@ha
	lwz 9,84(30)
	lis 4,.LC67@ha
	la 6,.LC14@l(6)
	subf 0,29,0
	la 4,.LC67@l(4)
	mullw 0,0,31
	addi 9,9,740
	li 3,2
	srawi 0,0,3
	slwi 0,0,2
	stwx 27,9,0
	lwz 5,84(30)
	addi 5,5,700
	crxor 6,6,6
	bl my_bprintf
.L342:
	cmpwi 0,26,0
	bc 12,2,.L332
	lis 9,CTFDropFlagThink@ha
	lis 10,level+4@ha
	la 9,CTFDropFlagThink@l(9)
	lis 8,.LC68@ha
	stw 9,436(26)
	lis 11,CTFDropFlagTouch@ha
	lfs 0,level+4@l(10)
	la 11,CTFDropFlagTouch@l(11)
	lfd 13,.LC68@l(8)
	stw 11,444(26)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(26)
.L332:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 CTFDeadDropFlag,.Lfe10-CTFDeadDropFlag
	.section	".rodata"
	.align 2
.LC70:
	.string	"Only losers drop flags.\n"
	.align 2
.LC71:
	.string	"Winners don't drop flags.\n"
	.align 2
.LC73:
	.string	"CTFFlagSetup: %s startsolid at %s\n"
	.align 3
.LC74:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC75:
	.long 0xc1700000
	.align 2
.LC76:
	.long 0x41700000
	.align 2
.LC77:
	.long 0x0
	.align 2
.LC78:
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
	lis 9,.LC75@ha
	lis 11,.LC75@ha
	la 9,.LC75@l(9)
	la 11,.LC75@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC75@ha
	lfs 2,0(11)
	la 9,.LC75@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC76@ha
	lfs 13,0(11)
	la 9,.LC76@l(9)
	lfs 1,0(9)
	lis 9,.LC76@ha
	stfs 13,188(31)
	la 9,.LC76@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC76@ha
	stfs 0,192(31)
	la 9,.LC76@l(9)
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
	bc 12,2,.L358
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L359
.L358:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L359:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC77@ha
	stw 9,444(31)
	addi 29,31,4
	la 11,.LC77@l(11)
	lis 9,.LC78@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC78@l(9)
	lis 11,.LC77@ha
	lfs 3,0(9)
	la 11,.LC77@l(11)
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
	bc 12,2,.L360
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC73@ha
	la 3,.LC73@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L357
.L360:
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
	lis 10,.LC74@ha
	lfs 0,level+4@l(11)
	lis 9,CTFFlagThink@ha
	lfd 13,.LC74@l(10)
	la 9,CTFFlagThink@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L357:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe11:
	.size	 CTFFlagSetup,.Lfe11-CTFFlagSetup
	.section	".rodata"
	.align 2
.LC79:
	.string	"players/male/flag1.md2"
	.align 2
.LC80:
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
	bc 4,1,.L362
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 0,flag1_item@l(9)
	la 7,itemlist@l(11)
	lis 10,0x38e3
	ori 10,10,36409
	lwz 11,84(31)
	subf 0,7,0
	mullw 0,0,10
	addi 11,11,740
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L363
	oris 0,8,0x4
	stw 0,64(31)
.L363:
	lis 9,flag2_item@ha
	lwz 11,84(31)
	lwz 0,flag2_item@l(9)
	addi 11,11,740
	subf 0,7,0
	mullw 0,0,10
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L362
	lwz 0,64(31)
	oris 0,0,0x8
	stw 0,64(31)
.L362:
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 10,84(31)
	lwz 0,flag1_item@l(9)
	la 8,itemlist@l(11)
	lis 11,0x38e3
	addi 10,10,740
	ori 11,11,36409
	subf 0,8,0
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L365
	lis 9,gi+32@ha
	lis 3,.LC79@ha
	lwz 0,gi+32@l(9)
	la 3,.LC79@l(3)
	b .L369
.L365:
	lis 9,flag2_item@ha
	lwz 0,flag2_item@l(9)
	subf 0,8,0
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 10,10,0
	cmpwi 0,10,0
	bc 12,2,.L367
	lis 9,gi+32@ha
	lis 3,.LC80@ha
	lwz 0,gi+32@l(9)
	la 3,.LC80@l(3)
.L369:
	mtlr 0
	blrl
	stw 3,48(31)
	b .L366
.L367:
	stw 10,48(31)
.L366:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 CTFEffects,.Lfe12-CTFEffects
	.section	".rodata"
	.align 2
.LC81:
	.long 0x0
	.align 3
.LC82:
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
	li 6,0
	lis 9,.LC81@ha
	la 9,.LC81@l(9)
	lfs 13,0(9)
	stfs 13,12(8)
	stfs 13,8(8)
	lfs 0,20(7)
	fcmpu 0,13,0
	bc 4,0,.L372
	lis 9,g_edicts@ha
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	mr 5,7
	la 11,game@l(11)
	lis 9,.LC82@ha
	lis 4,0x4330
	la 9,.LC82@l(9)
	addi 10,10,1420
	lfd 12,0(9)
	li 7,0
.L374:
	lwz 0,0(10)
	addi 10,10,1332
	cmpwi 0,0,0
	bc 12,2,.L373
	lwz 0,1028(11)
	add 9,7,0
	lwz 0,3464(9)
	cmpwi 0,0,1
	bc 4,2,.L376
	lfs 13,3512(9)
	lfs 0,8(8)
	fadds 0,0,13
	stfs 0,8(8)
	b .L373
.L376:
	cmpwi 0,0,2
	bc 4,2,.L373
	lfs 13,3512(9)
	lfs 0,12(8)
	fadds 0,0,13
	stfs 0,12(8)
.L373:
	addi 6,6,1
	lfs 13,20(5)
	xoris 0,6,0x8000
	addi 7,7,3968
	stw 0,12(1)
	stw 4,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L374
.L372:
	la 1,16(1)
	blr
.Lfe13:
	.size	 CTFCalcScores,.Lfe13-CTFCalcScores
	.section	".rodata"
	.align 2
.LC83:
	.string	"Disabling player identication display.\n"
	.align 2
.LC84:
	.string	"Activating player identication display.\n"
	.align 3
.LC85:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 2
.LC86:
	.long 0x0
	.align 2
.LC87:
	.long 0x44800000
	.align 2
.LC88:
	.long 0x3f800000
	.align 3
.LC89:
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
	lis 11,.LC86@ha
	lis 9,niq_enable@ha
	la 11,.LC86@l(11)
	mr 30,3
	lfs 30,0(11)
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,30
	bc 4,2,.L387
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,30
	bc 4,2,.L386
.L387:
	lwz 9,84(30)
	li 0,255
	b .L398
.L386:
	lwz 9,84(30)
	li 0,0
.L398:
	sth 0,174(9)
	lwz 3,84(30)
	addi 4,1,8
	li 5,0
	li 6,0
	addi 3,3,3716
	bl AngleVectors
	lis 9,.LC87@ha
	addi 3,1,8
	la 9,.LC87@l(9)
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
	lis 9,.LC88@ha
	lfs 13,48(1)
	la 9,.LC88@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L389
	lwz 9,92(1)
	cmpwi 0,9,0
	bc 12,2,.L389
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L389
	lis 11,g_edicts@ha
	lis 0,0xf3b3
	lwz 10,84(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,8069
	subf 9,9,30
	b .L399
.L389:
	lwz 3,84(30)
	addi 4,1,8
	li 5,0
	li 6,0
	li 27,0
	addi 3,3,3716
	li 28,1
	bl AngleVectors
	lis 24,maxclients@ha
	lis 9,.LC88@ha
	lis 11,maxclients@ha
	la 9,.LC88@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L391
	lis 11,.LC89@ha
	lis 25,g_edicts@ha
	la 11,.LC89@l(11)
	lis 26,0x4330
	lfd 29,0(11)
	li 29,1332
.L393:
	lwz 0,g_edicts@l(25)
	add 31,0,29
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L392
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
	fcmpu 0,31,30
	bc 4,1,.L392
	mr 3,30
	mr 4,31
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L392
	fmr 30,31
	mr 27,31
.L392:
	addi 28,28,1
	lwz 11,maxclients@l(24)
	xoris 0,28,0x8000
	addi 29,29,1332
	stw 0,116(1)
	stw 26,112(1)
	lfd 0,112(1)
	lfs 13,20(11)
	fsub 0,0,29
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L393
.L391:
	lis 9,.LC85@ha
	fmr 13,30
	lfd 0,.LC85@l(9)
	fcmpu 0,13,0
	bc 4,1,.L385
	lis 11,g_edicts@ha
	lis 0,0xf3b3
	lwz 10,84(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,8069
	subf 9,9,27
.L399:
	mullw 9,9,0
	srawi 9,9,2
	addi 9,9,1311
	sth 9,174(10)
.L385:
	lwz 0,180(1)
	mtlr 0
	lmw 24,120(1)
	lfd 29,152(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe14:
	.size	 CTFSetIDView,.Lfe14-CTFSetIDView
	.section	".rodata"
	.align 2
.LC90:
	.string	"ctfsb1"
	.align 2
.LC91:
	.string	"ctfsb2"
	.align 2
.LC92:
	.string	"i_ctf1"
	.align 2
.LC93:
	.string	"i_ctf1d"
	.align 2
.LC94:
	.string	"i_ctf1t"
	.align 2
.LC95:
	.string	"i_ctf2"
	.align 2
.LC96:
	.string	"i_ctf2d"
	.align 2
.LC97:
	.string	"i_ctf2t"
	.align 2
.LC98:
	.string	"i_ctfj"
	.align 2
.LC99:
	.long 0x0
	.align 2
.LC100:
	.long 0x3f800000
	.align 3
.LC101:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC102:
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
	lis 3,.LC90@ha
	lwz 9,40(29)
	la 3,.LC90@l(3)
	lis 27,level@ha
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,.LC91@ha
	sth 3,168(9)
	lwz 0,40(29)
	la 3,.LC91@l(11)
	mtlr 0
	blrl
	lwz 9,84(31)
	lis 10,.LC99@ha
	lis 11,level+200@ha
	la 10,.LC99@l(10)
	sth 3,170(9)
	lfs 13,0(10)
	lfs 0,level+200@l(11)
	lis 10,ctfgame@ha
	fcmpu 0,0,13
	bc 12,2,.L401
	lwz 0,level@l(27)
	andi. 11,0,8
	bc 12,2,.L401
	la 11,ctfgame@l(10)
	lwz 9,ctfgame@l(10)
	lwz 0,4(11)
	cmpw 0,9,0
	bc 12,1,.L453
	cmpw 0,0,9
	bc 12,1,.L454
	lfs 13,12(11)
	lfs 0,8(11)
	fcmpu 0,0,13
	bc 4,1,.L406
.L453:
	lwz 9,84(31)
	li 0,0
	sth 0,168(9)
	b .L401
.L406:
	fcmpu 0,13,0
	bc 4,1,.L408
.L454:
	lwz 9,84(31)
	li 0,0
	sth 0,170(9)
	b .L401
.L450:
	lis 9,gi+40@ha
	lwz 3,36(3)
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,172(9)
	b .L411
.L408:
	lwz 9,84(31)
	li 0,0
	sth 0,168(9)
	lwz 11,84(31)
	sth 0,170(11)
.L401:
	lwz 10,84(31)
	li 11,0
	lis 9,tnames@ha
	la 3,tnames@l(9)
	sth 11,172(10)
	lwzx 0,3,11
	cmpwi 0,0,0
	bc 12,2,.L411
	lis 9,itemlist@ha
	lis 29,0x38e3
	la 28,itemlist@l(9)
	mr 30,3
	ori 29,29,36409
.L412:
	lwz 3,0(30)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L413
	subf 0,28,3
	lwz 11,84(31)
	mullw 0,0,29
	addi 11,11,740
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L450
.L413:
	lwzu 0,4(30)
	cmpwi 0,0,0
	bc 4,2,.L412
.L411:
	lis 9,gi@ha
	lis 3,.LC92@ha
	la 30,gi@l(9)
	la 3,.LC92@l(3)
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
	bc 12,2,.L415
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L416
	lwz 0,40(30)
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	mtlr 0
	blrl
	lis 9,maxclients@ha
	lis 10,.LC100@ha
	lwz 11,maxclients@l(9)
	la 10,.LC100@l(10)
	mr 28,3
	lfs 0,0(10)
	li 7,1
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L415
	lis 11,flag1_item@ha
	lis 9,itemlist@ha
	fmr 12,13
	lwz 0,flag1_item@l(11)
	la 9,itemlist@l(9)
	lis 10,g_edicts@ha
	lis 11,0x38e3
	lwz 8,g_edicts@l(10)
	ori 11,11,36409
	subf 0,9,0
	mullw 0,0,11
	lis 10,0x4330
	addi 8,8,1332
	lis 11,.LC101@ha
	la 11,.LC101@l(11)
	srawi 0,0,3
	lfd 13,0(11)
	slwi 11,0,2
.L420:
	lwz 0,88(8)
	cmpwi 0,0,0
	bc 12,2,.L419
	lwz 9,84(8)
	addi 9,9,740
	lwzx 0,9,11
	cmpwi 0,0,0
	bc 4,2,.L451
.L419:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,1332
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L420
	b .L415
.L451:
	lis 9,gi+40@ha
	lis 3,.LC94@ha
	lwz 0,gi+40@l(9)
	la 3,.LC94@l(3)
	b .L455
.L416:
	lwz 0,284(3)
	andis. 9,0,1
	bc 12,2,.L415
	lwz 0,40(30)
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
.L455:
	mtlr 0
	blrl
	mr 28,3
.L415:
	lis 9,gi@ha
	lis 3,.LC95@ha
	la 30,gi@l(9)
	la 3,.LC95@l(3)
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
	bc 12,2,.L425
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L426
	lwz 0,40(30)
	lis 3,.LC96@ha
	la 3,.LC96@l(3)
	mtlr 0
	blrl
	lis 9,maxclients@ha
	lis 10,.LC100@ha
	lwz 11,maxclients@l(9)
	la 10,.LC100@l(10)
	mr 29,3
	lfs 0,0(10)
	li 7,1
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L425
	lis 11,flag2_item@ha
	lis 9,itemlist@ha
	fmr 12,13
	lwz 0,flag2_item@l(11)
	la 9,itemlist@l(9)
	lis 10,g_edicts@ha
	lis 11,0x38e3
	lwz 8,g_edicts@l(10)
	ori 11,11,36409
	subf 0,9,0
	mullw 0,0,11
	lis 10,0x4330
	addi 8,8,1332
	lis 11,.LC101@ha
	la 11,.LC101@l(11)
	srawi 0,0,3
	lfd 13,0(11)
	slwi 11,0,2
.L430:
	lwz 0,88(8)
	cmpwi 0,0,0
	bc 12,2,.L429
	lwz 9,84(8)
	addi 9,9,740
	lwzx 0,9,11
	cmpwi 0,0,0
	bc 4,2,.L452
.L429:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,1332
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L430
	b .L425
.L452:
	lis 9,gi+40@ha
	lis 3,.LC97@ha
	lwz 0,gi+40@l(9)
	la 3,.LC97@l(3)
	b .L456
.L426:
	lwz 0,284(3)
	andis. 9,0,1
	bc 12,2,.L425
	lwz 0,40(30)
	lis 3,.LC96@ha
	la 3,.LC96@l(3)
.L456:
	mtlr 0
	blrl
	mr 29,3
.L425:
	lis 10,.LC99@ha
	lwz 11,84(31)
	lis 9,ctfgame@ha
	la 10,.LC99@l(10)
	lfs 0,0(10)
	sth 28,154(11)
	la 10,ctfgame@l(9)
	lwz 9,84(31)
	sth 29,158(9)
	lfs 12,16(10)
	fcmpu 0,12,0
	bc 12,2,.L435
	lis 9,level+4@ha
	lis 11,.LC102@ha
	lfs 0,level+4@l(9)
	la 11,.LC102@l(11)
	lfs 13,0(11)
	fsubs 0,0,12
	fcmpu 0,0,13
	bc 4,0,.L435
	lwz 0,20(10)
	cmpwi 0,0,1
	bc 4,2,.L436
	lwz 0,level@l(27)
	andi. 0,0,8
	bc 12,2,.L437
	lwz 9,84(31)
	sth 28,154(9)
	b .L435
.L437:
	lwz 9,84(31)
	sth 0,154(9)
	b .L435
.L436:
	lwz 0,level@l(27)
	andi. 0,0,8
	bc 12,2,.L440
	lwz 9,84(31)
	sth 29,158(9)
	b .L435
.L440:
	lwz 9,84(31)
	sth 0,158(9)
.L435:
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
	lwz 0,3464(10)
	cmpwi 0,0,1
	bc 4,2,.L442
	lis 9,flag2_item@ha
	lis 11,itemlist@ha
	lwz 0,flag2_item@l(9)
	la 11,itemlist@l(11)
	addi 10,10,740
	lis 9,0x38e3
	ori 9,9,36409
	subf 0,11,0
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L442
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L442
	lis 9,gi+40@ha
	lis 3,.LC95@ha
	lwz 0,gi+40@l(9)
	la 3,.LC95@l(3)
	b .L457
.L442:
	lwz 10,84(31)
	lwz 0,3464(10)
	cmpwi 0,0,2
	bc 4,2,.L443
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 0,flag1_item@l(9)
	la 11,itemlist@l(11)
	addi 10,10,740
	lis 9,0x38e3
	ori 9,9,36409
	subf 0,11,0
	mullw 0,0,9
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L443
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L443
	lis 9,gi+40@ha
	lis 3,.LC92@ha
	lwz 0,gi+40@l(9)
	la 3,.LC92@l(3)
.L457:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,162(9)
.L443:
	lwz 11,84(31)
	li 0,0
	sth 0,164(11)
	lwz 9,84(31)
	sth 0,166(9)
	lwz 11,84(31)
	lwz 0,3464(11)
	cmpwi 0,0,1
	bc 4,2,.L445
	lis 9,gi+40@ha
	lis 3,.LC98@ha
	lwz 0,gi+40@l(9)
	la 3,.LC98@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,164(9)
	b .L446
.L445:
	cmpwi 0,0,2
	bc 4,2,.L446
	lis 9,gi+40@ha
	lis 3,.LC98@ha
	lwz 0,gi+40@l(9)
	la 3,.LC98@l(3)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,166(9)
.L446:
	lis 9,ctf@ha
	lwz 10,84(31)
	li 0,0
	lwz 11,ctf@l(9)
	lis 9,.LC99@ha
	sth 0,174(10)
	la 9,.LC99@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L448
	lwz 9,84(31)
	li 0,255
	sth 0,174(9)
.L448:
	lwz 9,84(31)
	lwz 0,3488(9)
	cmpwi 0,0,0
	bc 12,2,.L449
	lwz 0,3584(9)
	cmpwi 0,0,0
	bc 4,2,.L449
	lwz 0,3568(9)
	cmpwi 0,0,0
	bc 4,2,.L449
	lwz 0,3536(9)
	xori 9,0,9
	subfic 10,9,0
	adde 9,10,9
	subfic 11,0,0
	adde 0,11,0
	or. 10,0,9
	bc 12,2,.L449
	mr 3,31
	bl CTFSetIDView
.L449:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 SetCTFStats,.Lfe15-SetCTFStats
	.section	".rodata"
	.align 2
.LC104:
	.string	"weapons/grapple/grreset.wav"
	.align 2
.LC106:
	.string	"weapons/grapple/grpull.wav"
	.align 2
.LC107:
	.string	"weapons/grapple/grhit.wav"
	.align 2
.LC105:
	.long 0x3e4ccccd
	.align 2
.LC108:
	.long 0x3f800000
	.align 2
.LC109:
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
	lis 9,.LC108@ha
	mr 27,5
	la 9,.LC108@l(9)
	cmpw 0,29,30
	lfs 31,0(9)
	bc 12,2,.L465
	lwz 9,84(30)
	lwz 28,3916(9)
	cmpwi 0,28,0
	bc 4,2,.L465
	cmpwi 0,6,0
	bc 12,2,.L468
	lwz 0,16(6)
	andi. 11,0,4
	bc 12,2,.L468
	lwz 0,3912(9)
	cmpwi 0,0,0
	bc 12,2,.L465
	lwz 0,3812(9)
	lis 9,.LC108@ha
	cmpwi 0,0,0
	la 9,.LC108@l(9)
	lfs 31,0(9)
	bc 12,2,.L470
	lis 9,.LC105@ha
	lfs 31,.LC105@l(9)
.L470:
	lis 29,gi@ha
	lis 3,.LC104@ha
	la 29,gi@l(29)
	la 3,.LC104@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC108@ha
	lis 11,.LC109@ha
	fmr 1,31
	la 9,.LC108@l(9)
	la 11,.LC109@l(11)
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
	stw 28,3912(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 28,3916(9)
	b .L479
.L468:
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
	lwz 8,512(29)
	cmpwi 0,8,0
	bc 12,2,.L472
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
	lwz 0,3912(9)
	cmpwi 0,0,0
	bc 12,2,.L465
	lwz 0,3812(9)
	lis 9,.LC108@ha
	cmpwi 0,0,0
	la 9,.LC108@l(9)
	lfs 31,0(9)
	bc 12,2,.L474
	lis 9,.LC105@ha
	lfs 31,.LC105@l(9)
.L474:
	lis 29,gi@ha
	lis 3,.LC104@ha
	la 29,gi@l(29)
	la 3,.LC104@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC108@ha
	lis 11,.LC109@ha
	fmr 1,31
	la 9,.LC108@l(9)
	la 11,.LC109@l(11)
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
	stw 26,3912(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 26,3916(9)
.L479:
	andi. 0,0,191
	stfs 0,3920(9)
	stb 0,16(9)
	bl G_FreeEdict
	b .L465
.L472:
	lwz 11,256(31)
	li 0,1
	lis 10,level+4@ha
	lwz 9,84(11)
	stw 0,3916(9)
	stw 29,540(31)
	lwz 11,256(31)
	lfs 0,level+4@l(10)
	lwz 9,84(11)
	stfs 0,3924(9)
	lwz 30,256(31)
	stw 8,248(31)
	lwz 9,84(30)
	lwz 0,3812(9)
	cmpwi 0,0,0
	bc 12,2,.L476
	lis 9,.LC105@ha
	lfs 31,.LC105@l(9)
.L476:
	lis 9,gi@ha
	lis 3,.LC106@ha
	la 29,gi@l(9)
	la 3,.LC106@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC108@ha
	lwz 11,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC108@l(9)
	li 4,17
	lfs 2,0(9)
	mtlr 11
	mr 3,30
	lis 9,.LC109@ha
	la 9,.LC109@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,36(29)
	lis 3,.LC107@ha
	la 3,.LC107@l(3)
	mtlr 9
	blrl
	lis 9,.LC108@ha
	lwz 11,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC108@l(9)
	li 4,1
	lfs 2,0(9)
	mtlr 11
	mr 3,31
	lis 9,.LC109@ha
	la 9,.LC109@l(9)
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
	bc 4,2,.L477
	lwz 0,124(29)
	mr 3,26
	mtlr 0
	blrl
	b .L478
.L477:
	lwz 0,124(29)
	mr 3,27
	mtlr 0
	blrl
.L478:
	lis 9,gi+88@ha
	mr 3,28
	lwz 0,gi+88@l(9)
	li 4,2
	mtlr 0
	blrl
.L465:
	lwz 0,52(1)
	mtlr 0
	lmw 26,16(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe16:
	.size	 CTFGrappleTouch,.Lfe16-CTFGrappleTouch
	.section	".rodata"
	.align 3
.LC110:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC111:
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
	addi 3,3,3716
	bl AngleVectors
	lis 9,.LC110@ha
	lwz 10,256(31)
	lis 0,0x4180
	la 9,.LC110@l(9)
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
	lis 9,.LC111@ha
	la 9,.LC111@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L480
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
	lis 0,0xf3b3
	lwz 11,g_edicts@l(9)
	ori 0,0,8069
	lwz 10,104(29)
	subf 3,11,3
	mullw 3,3,0
	mtlr 10
	srawi 3,3,2
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
.L480:
	lwz 0,132(1)
	mtlr 0
	lmw 28,112(1)
	la 1,128(1)
	blr
.Lfe17:
	.size	 CTFGrappleDrawCable,.Lfe17-CTFGrappleDrawCable
	.section	".rodata"
	.align 2
.LC112:
	.string	"weapon_grapple"
	.align 2
.LC114:
	.string	"weapons/grapple/grhurt.wav"
	.align 2
.LC115:
	.string	"weapons/grapple/grhang.wav"
	.align 2
.LC113:
	.long 0x3e4ccccd
	.align 2
.LC116:
	.long 0x44228000
	.align 2
.LC117:
	.long 0x3f800000
	.align 2
.LC118:
	.long 0x0
	.align 2
.LC119:
	.long 0x3f000000
	.align 3
.LC120:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC121:
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
	lwz 9,256(31)
	lwz 0,968(9)
	cmpwi 0,0,0
	bc 4,2,.L483
	lwz 9,84(9)
	lis 4,.LC112@ha
	la 4,.LC112@l(4)
	lwz 11,1788(9)
	lwz 3,0(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L483
	lwz 30,256(31)
	lwz 9,84(30)
	lwz 28,3612(9)
	cmpwi 0,28,0
	bc 4,2,.L483
	lwz 0,3648(9)
	cmpwi 0,0,3
	bc 12,2,.L483
	cmpwi 0,0,1
	bc 12,2,.L483
	lwz 0,3912(9)
	cmpwi 0,0,0
	bc 12,2,.L482
	lwz 0,3812(9)
	lis 8,.LC117@ha
	la 8,.LC117@l(8)
	cmpwi 0,0,0
	lfs 31,0(8)
	bc 12,2,.L486
	lis 9,.LC113@ha
	lfs 31,.LC113@l(9)
.L486:
	lis 29,gi@ha
	lis 3,.LC104@ha
	la 29,gi@l(29)
	la 3,.LC104@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC117@ha
	lis 9,.LC118@ha
	fmr 1,31
	la 9,.LC118@l(9)
	mr 5,3
	la 8,.LC117@l(8)
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
	stw 28,3912(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 28,3916(9)
	b .L505
.L483:
	lwz 3,540(31)
	cmpwi 0,3,0
	bc 12,2,.L488
	lwz 28,248(3)
	cmpwi 0,28,0
	bc 4,2,.L489
	lwz 30,256(31)
	lwz 9,84(30)
	lwz 0,3912(9)
	cmpwi 0,0,0
	bc 12,2,.L482
	lwz 0,3812(9)
	lis 8,.LC117@ha
	la 8,.LC117@l(8)
	cmpwi 0,0,0
	lfs 31,0(8)
	bc 12,2,.L491
	lis 9,.LC113@ha
	lfs 31,.LC113@l(9)
.L491:
	lis 29,gi@ha
	lis 3,.LC104@ha
	la 29,gi@l(29)
	la 3,.LC104@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC117@ha
	lis 9,.LC118@ha
	fmr 1,31
	la 9,.LC118@l(9)
	mr 5,3
	la 8,.LC117@l(8)
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
	stw 28,3912(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 28,3916(9)
	b .L505
.L489:
	cmpwi 0,28,2
	bc 4,2,.L493
	lis 8,.LC119@ha
	addi 3,3,236
	la 8,.LC119@l(8)
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
	b .L494
.L493:
	lfs 0,376(3)
	stfs 0,376(31)
	lfs 13,380(3)
	stfs 13,380(31)
	lfs 0,384(3)
	stfs 0,384(31)
.L494:
	lwz 3,540(31)
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L495
	lwz 4,256(31)
	bl CheckTeamDamage
	mr. 11,3
	bc 4,2,.L495
	lwz 5,256(31)
	lis 8,.LC117@ha
	la 8,.LC117@l(8)
	lwz 9,84(5)
	lfs 31,0(8)
	lwz 0,3812(9)
	cmpwi 0,0,0
	bc 12,2,.L496
	lis 9,.LC113@ha
	lfs 31,.LC113@l(9)
.L496:
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
	lis 3,.LC114@ha
	la 29,gi@l(29)
	la 3,.LC114@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC117@ha
	lis 9,.LC118@ha
	fmr 1,31
	mr 5,3
	la 8,.LC117@l(8)
	la 9,.LC118@l(9)
	li 4,1
	lfs 2,0(8)
	mtlr 0
	mr 3,31
	lfs 3,0(9)
	blrl
	b .L482
.L495:
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L498
	lwz 0,492(9)
	cmpwi 0,0,0
	bc 12,2,.L488
.L498:
	lwz 30,256(31)
	lwz 9,84(30)
	lwz 0,3912(9)
	cmpwi 0,0,0
	bc 12,2,.L482
	lwz 0,3812(9)
	lis 8,.LC117@ha
	la 8,.LC117@l(8)
	cmpwi 0,0,0
	lfs 31,0(8)
	bc 12,2,.L500
	lis 9,.LC113@ha
	lfs 31,.LC113@l(9)
.L500:
	lis 29,gi@ha
	lis 3,.LC104@ha
	la 29,gi@l(29)
	la 3,.LC104@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC117@ha
	lis 9,.LC118@ha
	fmr 1,31
	la 8,.LC117@l(8)
	la 9,.LC118@l(9)
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
	stw 8,3912(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 8,3916(9)
.L505:
	andi. 0,0,191
	stfs 0,3920(9)
	stb 0,16(9)
	bl G_FreeEdict
	b .L482
.L488:
	mr 3,31
	bl CTFGrappleDrawCable
	lwz 9,256(31)
	lwz 3,84(9)
	lwz 0,3916(3)
	cmpwi 0,0,0
	bc 4,1,.L482
	addi 3,3,3716
	addi 4,1,48
	li 5,0
	addi 6,1,64
	bl AngleVectors
	lwz 9,256(31)
	lis 10,0x4330
	lfs 10,4(31)
	lis 8,.LC120@ha
	addi 3,1,16
	lfs 0,4(9)
	la 8,.LC120@l(8)
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
	lis 8,.LC121@ha
	lwz 9,256(31)
	la 8,.LC121@l(8)
	lfs 0,0(8)
	lwz 11,84(9)
	fcmpu 7,1,0
	lwz 0,3916(11)
	xori 0,0,1
	subfic 10,0,0
	adde 0,10,0
	mfcr 9
	rlwinm 9,9,29,1
	and. 8,0,9
	bc 12,2,.L503
	lwz 0,3812(11)
	lis 9,.LC117@ha
	la 9,.LC117@l(9)
	cmpwi 0,0,0
	lfs 31,0(9)
	bc 12,2,.L504
	lis 9,.LC113@ha
	lfs 31,.LC113@l(9)
.L504:
	lbz 0,16(11)
	lis 29,gi@ha
	lis 3,.LC115@ha
	la 29,gi@l(29)
	la 3,.LC115@l(3)
	ori 0,0,64
	stb 0,16(11)
	lwz 9,36(29)
	lwz 28,256(31)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 8,.LC117@ha
	lis 9,.LC118@ha
	fmr 1,31
	la 9,.LC118@l(9)
	mr 5,3
	la 8,.LC117@l(8)
	lfs 3,0(9)
	mtlr 0
	li 4,17
	mr 3,28
	lfs 2,0(8)
	blrl
	lwz 11,256(31)
	li 0,2
	lwz 9,84(11)
	stw 0,3916(9)
.L503:
	addi 3,1,16
	bl VectorNormalize
	lis 9,.LC116@ha
	addi 3,1,16
	lfs 1,.LC116@l(9)
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
.L482:
	lwz 0,116(1)
	mtlr 0
	lmw 28,88(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe18:
	.size	 CTFGrapplePull,.Lfe18-CTFGrapplePull
	.section	".rodata"
	.align 2
.LC122:
	.string	"models/weapons/grapple/hook/tris.md2"
	.align 2
.LC124:
	.string	"weapons/grapple/grfire.wav"
	.align 2
.LC123:
	.long 0x3e4ccccd
	.align 2
.LC125:
	.long 0x3f800000
	.align 3
.LC126:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC127:
	.long 0x41c00000
	.align 2
.LC128:
	.long 0x41000000
	.align 2
.LC129:
	.long 0xc0000000
	.align 2
.LC130:
	.long 0x0
	.align 3
.LC131:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC132:
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
	lis 9,.LC125@ha
	lwz 3,84(30)
	la 9,.LC125@l(9)
	mr 28,4
	mr 21,5
	mr 23,6
	lfs 30,0(9)
	lwz 0,3916(3)
	cmpwi 0,0,0
	bc 12,1,.L508
	addi 29,1,24
	addi 4,1,8
	addi 3,3,3716
	mr 5,29
	li 6,0
	lis 22,0x4330
	bl AngleVectors
	addi 25,30,4
	lis 9,.LC126@ha
	lis 10,.LC127@ha
	lfs 12,0(28)
	la 9,.LC126@l(9)
	la 10,.LC127@l(10)
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
	lis 10,.LC128@ha
	lfs 13,4(28)
	xoris 9,9,0x8000
	la 10,.LC128@l(10)
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
	lis 9,.LC129@ha
	lwz 4,84(30)
	addi 3,1,8
	la 9,.LC129@l(9)
	lfs 1,0(9)
	addi 4,4,3664
	bl VectorScale
	lwz 11,84(30)
	lis 0,0xbf80
	stw 0,3652(11)
	lwz 9,84(30)
	lwz 0,3812(9)
	cmpwi 0,0,0
	bc 12,2,.L510
	lis 9,.LC123@ha
	lfs 30,.LC123@l(9)
.L510:
	lis 29,gi@ha
	lis 3,.LC124@ha
	la 29,gi@l(29)
	la 3,.LC124@l(3)
	lwz 9,36(29)
	addi 27,1,8
	li 28,650
	mtlr 9
	blrl
	lis 9,.LC125@ha
	lis 10,.LC130@ha
	fmr 1,30
	la 9,.LC125@l(9)
	mr 5,3
	lfs 2,0(9)
	la 10,.LC130@l(10)
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
	lis 3,.LC122@ha
	stw 0,252(31)
	la 3,.LC122@l(3)
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
	stw 31,3912(9)
	lwz 11,84(30)
	stw 0,3916(11)
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
	lis 9,.LC131@ha
	la 9,.LC131@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L512
	lis 10,.LC132@ha
	mr 3,26
	la 10,.LC132@l(10)
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
.L512:
	mr 4,24
	mr 3,30
	li 5,1
	bl PlayerNoise
	lwz 0,968(30)
	cmpwi 0,0,0
	bc 4,2,.L508
	lfs 0,4(30)
	lfs 12,8(30)
	lfs 13,12(30)
	stfs 0,1016(30)
	stfs 12,1020(30)
	stfs 13,1024(30)
.L508:
	lwz 0,228(1)
	mtlr 0
	lmw 21,164(1)
	lfd 30,208(1)
	lfd 31,216(1)
	la 1,224(1)
	blr
.Lfe19:
	.size	 CTFGrappleFire,.Lfe19-CTFGrappleFire
	.section	".data"
	.align 2
	.type	 pause_frames.114,@object
pause_frames.114:
	.long 10
	.long 18
	.long 27
	.long 0
	.align 2
	.type	 fire_frames.115,@object
fire_frames.115:
	.long 6
	.long 0
	.section	".rodata"
	.align 2
.LC133:
	.long 0x3e4ccccd
	.align 2
.LC134:
	.long 0x3f800000
	.align 2
.LC135:
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
	lwz 0,3596(9)
	andi. 11,0,1
	bc 12,2,.L526
	lwz 0,3648(9)
	cmpwi 0,0,3
	bc 4,2,.L516
	lwz 0,3912(9)
	cmpwi 0,0,0
	bc 12,2,.L516
	li 0,9
	stw 0,92(9)
.L516:
	lwz 9,84(30)
	lwz 0,3596(9)
	andi. 9,0,1
	bc 4,2,.L517
.L526:
	lwz 9,84(30)
	lwz 31,3912(9)
	cmpwi 0,31,0
	bc 12,2,.L517
	lwz 28,256(31)
	lwz 9,84(28)
	lwz 0,3912(9)
	cmpwi 0,0,0
	bc 12,2,.L520
	lwz 0,3812(9)
	lis 11,.LC134@ha
	la 11,.LC134@l(11)
	cmpwi 0,0,0
	lfs 31,0(11)
	bc 12,2,.L519
	lis 9,.LC133@ha
	lfs 31,.LC133@l(9)
.L519:
	lis 29,gi@ha
	lis 3,.LC104@ha
	la 29,gi@l(29)
	la 3,.LC104@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC134@ha
	lis 11,.LC135@ha
	fmr 1,31
	la 9,.LC134@l(9)
	la 11,.LC135@l(11)
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
	stw 8,3912(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 8,3916(9)
	andi. 0,0,191
	stfs 0,3920(9)
	stb 0,16(9)
	bl G_FreeEdict
.L520:
	lwz 9,84(30)
	lwz 0,3648(9)
	cmpwi 0,0,3
	bc 4,2,.L517
	li 0,0
	stw 0,3648(9)
.L517:
	lwz 9,84(30)
	lwz 0,3612(9)
	cmpwi 0,0,0
	bc 12,2,.L522
	lwz 0,3916(9)
	cmpwi 0,0,0
	bc 4,1,.L522
	lwz 0,3648(9)
	cmpwi 0,0,3
	bc 4,2,.L522
	li 0,2
	li 11,32
	stw 0,3648(9)
	lwz 9,84(30)
	stw 11,92(9)
.L522:
	lwz 11,84(30)
	lis 8,pause_frames.114@ha
	lis 9,fire_frames.115@ha
	lis 10,CTFWeapon_Grapple_Fire@ha
	la 8,pause_frames.114@l(8)
	lwz 29,3648(11)
	la 9,fire_frames.115@l(9)
	la 10,CTFWeapon_Grapple_Fire@l(10)
	mr 3,30
	li 4,5
	li 5,9
	li 6,31
	li 7,36
	bl Weapon_Generic
	cmpwi 0,29,1
	bc 4,2,.L523
	lwz 9,84(30)
	lwz 0,3648(9)
	cmpwi 0,0,0
	bc 4,2,.L523
	lwz 0,3916(9)
	cmpwi 0,0,0
	bc 4,1,.L523
	lwz 0,3596(9)
	andi. 11,0,1
	li 0,5
	bc 4,2,.L524
	li 0,9
.L524:
	stw 0,92(9)
	lwz 9,84(30)
	li 0,3
	stw 0,3648(9)
.L523:
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 CTFWeapon_Grapple,.Lfe20-CTFWeapon_Grapple
	.section	".rodata"
	.align 2
.LC136:
	.string	"You are on the %s team.\n"
	.align 2
.LC137:
	.string	"red"
	.align 2
.LC138:
	.string	"blue"
	.align 2
.LC139:
	.string	"Unknown team %s.\n"
	.align 2
.LC140:
	.string	"You are already on the %s team.\n"
	.align 2
.LC141:
	.string	"skin"
	.align 2
.LC142:
	.string	"%s joined the %s team.\n"
	.align 2
.LC143:
	.string	"%s changed to the %s team.\n"
	.align 2
.LC144:
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
	lis 11,.LC144@ha
	lis 9,ctf@ha
	la 11,.LC144@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L528
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 30,3
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L530
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L528
	lwz 9,84(31)
	lwz 0,3464(9)
	cmpwi 0,0,1
	bc 12,2,.L532
	cmpwi 0,0,2
	bc 12,2,.L533
	b .L536
.L532:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L535
.L533:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L535
.L536:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L535:
	lwz 0,8(29)
	lis 5,.LC136@ha
	mr 3,31
	la 5,.LC136@l(5)
	b .L566
.L530:
	lis 4,.LC137@ha
	mr 3,30
	la 4,.LC137@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L537
	li 30,1
	b .L538
.L537:
	lis 4,.LC138@ha
	mr 3,30
	la 4,.LC138@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L539
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L528
	lwz 0,8(29)
	lis 5,.LC139@ha
	mr 3,31
	la 5,.LC139@l(5)
	mr 6,30
	b .L566
.L539:
	li 30,2
.L538:
	lwz 9,84(31)
	lwz 0,3464(9)
	cmpw 0,0,30
	bc 4,2,.L542
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L528
	cmpwi 0,30,1
	lis 9,gi@ha
	la 11,gi@l(9)
	bc 12,2,.L544
	cmpwi 0,30,2
	bc 12,2,.L545
	b .L548
.L544:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L547
.L545:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L547
.L548:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L547:
	lwz 0,8(11)
	lis 5,.LC140@ha
	mr 3,31
	la 5,.LC140@l(5)
.L566:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L528
.L542:
	lwz 0,264(31)
	li 11,0
	lis 4,.LC141@ha
	stw 11,184(31)
	la 4,.LC141@l(4)
	rlwinm 0,0,0,28,26
	stw 0,264(31)
	stw 30,3464(9)
	lwz 9,84(31)
	stw 11,3468(9)
	lwz 3,84(31)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl CTFAssignSkin
	lis 9,.LC144@ha
	la 9,.LC144@l(9)
	lfs 13,0(9)
	lis 9,niq_enable@ha
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L549
	lis 9,niq_logfile@ha
	lwz 11,niq_logfile@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L549
	lwz 9,84(31)
	lwz 0,3464(9)
	addi 4,9,700
	cmpwi 0,0,1
	bc 12,2,.L550
	cmpwi 0,0,2
	bc 12,2,.L551
	b .L554
.L550:
	lis 9,.LC13@ha
	la 5,.LC13@l(9)
	b .L553
.L551:
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
	b .L553
.L554:
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
.L553:
	lis 9,level+4@ha
	lis 3,gi@ha
	lfs 1,level+4@l(9)
	la 3,gi@l(3)
	bl sl_LogPlayerTeamChange
.L549:
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L555
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
	bc 12,2,.L556
	cmpwi 0,30,2
	bc 12,2,.L557
	b .L560
.L556:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L559
.L557:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L559
.L560:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L559:
	lis 4,.LC142@ha
	li 3,2
	la 4,.LC142@l(4)
	crxor 6,6,6
	bl my_bprintf
	b .L528
.L555:
	li 0,0
	lis 6,0x1
	lis 7,vec3_origin@ha
	mr 5,31
	stw 0,480(31)
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
	li 0,0
	cmpwi 0,30,1
	stw 0,3512(11)
	lwz 9,84(31)
	addi 5,9,700
	bc 12,2,.L561
	cmpwi 0,30,2
	bc 12,2,.L562
	b .L565
.L561:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L564
.L562:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L564
.L565:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L564:
	lis 4,.LC143@ha
	li 3,2
	la 4,.LC143@l(4)
	crxor 6,6,6
	bl my_bprintf
.L528:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 CTFTeam_f,.Lfe21-CTFTeam_f
	.section	".rodata"
	.align 2
.LC145:
	.string	"You already have a TECH powerup."
	.align 2
.LC146:
	.long 0x40000000
	.align 2
.LC147:
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
	lis 8,0x38e3
	ori 8,8,36409
	mr 31,4
	subf 0,6,0
	lwz 9,84(31)
	mr 30,3
	mullw 0,0,8
	addi 7,9,740
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,7,0
	cmpwi 0,9,0
	bc 4,2,.L580
	lis 9,item_tech2@ha
	lwz 0,item_tech2@l(9)
	subf 0,6,0
	mullw 0,0,8
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,7,0
	cmpwi 0,9,0
	bc 4,2,.L580
	lis 9,item_tech3@ha
	lwz 0,item_tech3@l(9)
	subf 0,6,0
	mullw 0,0,8
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,7,0
	cmpwi 0,9,0
	bc 4,2,.L580
	lis 9,item_tech4@ha
	lwz 0,item_tech4@l(9)
	subf 0,6,0
	mullw 0,0,8
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,7,0
	cmpwi 0,9,0
	bc 12,2,.L579
.L580:
	lis 9,level@ha
	lwz 11,84(31)
	lis 10,.LC146@ha
	la 29,level@l(9)
	la 10,.LC146@l(10)
	lfs 13,3936(11)
	lfs 0,4(29)
	lfs 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L583
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L582
	lis 9,gi+12@ha
	lis 4,.LC145@ha
	lwz 0,gi+12@l(9)
	la 4,.LC145@l(4)
	mr 3,31
	mtlr 0
	crxor 6,6,6
	blrl
.L582:
	lfs 0,4(29)
	lwz 9,84(31)
	stfs 0,3936(9)
.L583:
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L584
	lwz 0,416(31)
	cmpw 0,0,30
	bc 4,2,.L584
	li 0,0
	lis 10,.LC147@ha
	stw 0,416(31)
	lis 9,level+4@ha
	la 10,.LC147@l(10)
	stw 0,412(31)
	lfs 0,level+4@l(9)
	lfs 13,0(10)
	fadds 0,0,13
	stfs 0,1296(30)
.L584:
	li 3,0
	b .L585
.L579:
	lwz 0,648(30)
	lis 11,level+4@ha
	li 10,1
	li 3,1
	subf 0,6,0
	mullw 0,0,8
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,7,0
	addi 9,9,1
	stwx 9,7,0
	lfs 0,level+4@l(11)
	lwz 9,84(31)
	stfs 0,3928(9)
	lwz 11,84(31)
	stw 10,3900(11)
.L585:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 CTFPickup_Tech,.Lfe22-CTFPickup_Tech
	.section	".rodata"
	.align 2
.LC148:
	.string	"info_player_deathmatch"
	.align 2
.LC149:
	.long 0x0
	.align 3
.LC150:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC151:
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
	lis 11,.LC149@ha
	lis 9,ctf@ha
	la 11,.LC149@l(11)
	mr 28,3
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L602
	lis 9,tnames@ha
	la 3,tnames@l(9)
	lwz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L602
	lis 9,itemlist@ha
	lis 11,level@ha
	la 21,itemlist@l(9)
	la 22,level@l(11)
	lis 9,TechThink@ha
	lis 11,.LC151@ha
	la 23,TechThink@l(9)
	la 11,.LC151@l(11)
	lis 9,.LC150@ha
	lfs 30,0(11)
	lis 30,0x1b4e
	la 9,.LC150@l(9)
	lis 27,0x38e3
	lfd 31,0(9)
	mr 24,3
	ori 30,30,33205
	lis 25,0x4330
	li 26,0
	ori 27,27,36409
.L606:
	lwz 3,0(24)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L607
	subf 0,21,3
	lwz 11,84(28)
	mullw 0,0,27
	addi 11,11,740
	srawi 0,0,3
	slwi 31,0,2
	lwzx 9,11,31
	cmpwi 0,9,0
	bc 12,2,.L607
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
.L607:
	lwzu 0,4(24)
	cmpwi 0,0,0
	bc 4,2,.L606
.L602:
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
	.align 2
.LC152:
	.long 0x0
	.align 3
.LC153:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC154:
	.long 0x42c80000
	.align 2
.LC155:
	.long 0x41800000
	.align 2
.LC156:
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
	lis 7,.LC152@ha
	lwz 11,ctf@l(9)
	la 7,.LC152@l(7)
	mr 30,3
	lfs 31,0(7)
	mr 31,4
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L609
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
	lis 7,.LC153@ha
	addi 3,1,40
	add 0,0,9
	la 7,.LC153@l(7)
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
	lis 9,.LC155@ha
	lis 7,.LC154@ha
	la 9,.LC155@l(9)
	la 7,.LC154@l(7)
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
	lis 7,.LC156@ha
	lis 11,level+4@ha
	stw 0,384(29)
	la 7,.LC156@l(7)
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
	bc 12,2,.L612
.L613:
	lwzu 0,4(9)
	addi 11,11,1
	cmpwi 0,0,0
	bc 4,2,.L613
.L612:
	cmpwi 0,11,2
	bc 12,1,.L609
	lis 9,titems@ha
	slwi 0,11,2
	la 9,titems@l(9)
	stwx 30,9,0
.L609:
	lwz 0,116(1)
	mtlr 0
	lmw 27,84(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe24:
	.size	 SpawnTech,.Lfe24-SpawnTech
	.section	".sdata","aw"
	.align 2
	.type	 tech.158,@object
	.size	 tech.158,4
tech.158:
	.long 0
	.section	".rodata"
	.align 2
.LC158:
	.string	"ctf/tech1.wav"
	.section	".sdata","aw"
	.align 2
	.type	 tech.162,@object
	.size	 tech.162,4
tech.162:
	.long 0
	.align 2
	.type	 tech.166,@object
	.size	 tech.166,4
tech.166:
	.long 0
	.section	".rodata"
	.align 2
.LC160:
	.string	"ctf/tech2x.wav"
	.align 2
.LC161:
	.string	"ctf/tech2.wav"
	.align 2
.LC159:
	.long 0x3e4ccccd
	.align 2
.LC162:
	.long 0x3f800000
	.align 3
.LC163:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC164:
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
	lis 7,.LC162@ha
	lwz 9,84(31)
	la 7,.LC162@l(7)
	lfs 31,0(7)
	cmpwi 0,9,0
	bc 12,2,.L649
	lwz 0,3812(9)
	cmpwi 0,0,0
	bc 12,2,.L649
	lis 9,.LC159@ha
	lfs 31,.LC159@l(9)
.L649:
	lis 11,tech.166@ha
	lwz 0,tech.166@l(11)
	cmpwi 0,0,0
	bc 4,2,.L656
	lis 9,item_tech2@ha
	lwz 0,item_tech2@l(9)
	cmpwi 0,0,0
	stw 0,tech.166@l(11)
	bc 12,2,.L651
.L656:
	lwz 8,84(31)
	cmpwi 0,8,0
	bc 12,2,.L651
	lwz 0,tech.166@l(11)
	lis 9,itemlist@ha
	addi 10,8,740
	la 9,itemlist@l(9)
	lis 11,0x38e3
	subf 0,9,0
	ori 11,11,36409
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L651
	lis 11,level@ha
	lfs 0,3932(8)
	la 9,level@l(11)
	lfs 13,4(9)
	fcmpu 0,0,13
	bc 4,0,.L652
	lis 9,.LC162@ha
	lis 10,0x4330
	la 9,.LC162@l(9)
	lis 7,.LC163@ha
	lfs 0,0(9)
	la 7,.LC163@l(7)
	lfd 12,0(7)
	fadds 0,13,0
	stfs 0,3932(8)
	lwz 0,level@l(11)
	lwz 11,84(31)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	lfs 13,3788(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L653
	lis 29,gi@ha
	lis 3,.LC160@ha
	la 29,gi@l(29)
	la 3,.LC160@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC162@ha
	lis 9,.LC164@ha
	fmr 1,31
	mr 5,3
	la 7,.LC162@l(7)
	la 9,.LC164@l(9)
	li 4,2
	lfs 2,0(7)
	mtlr 0
	mr 3,31
	lfs 3,0(9)
	blrl
	b .L652
.L653:
	lis 29,gi@ha
	lis 3,.LC161@ha
	la 29,gi@l(29)
	la 3,.LC161@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 7,.LC162@ha
	lis 9,.LC164@ha
	fmr 1,31
	mr 5,3
	la 7,.LC162@l(7)
	la 9,.LC164@l(9)
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
	.type	 tech.170,@object
	.size	 tech.170,4
tech.170:
	.long 0
	.align 2
	.type	 tech.174,@object
	.size	 tech.174,4
tech.174:
	.long 0
	.section	".rodata"
	.align 2
.LC166:
	.string	"ctf/tech3.wav"
	.align 2
.LC165:
	.long 0x3e4ccccd
	.align 2
.LC167:
	.long 0x3f800000
	.align 2
.LC168:
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
	lis 9,.LC167@ha
	mr 31,3
	la 9,.LC167@l(9)
	lfs 31,0(9)
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L662
	lwz 0,3812(9)
	cmpwi 0,0,0
	bc 12,2,.L662
	lis 9,.LC165@ha
	lfs 31,.LC165@l(9)
.L662:
	lis 11,tech.174@ha
	lwz 0,tech.174@l(11)
	cmpwi 0,0,0
	bc 4,2,.L665
	lis 9,item_tech3@ha
	lwz 0,item_tech3@l(9)
	cmpwi 0,0,0
	stw 0,tech.174@l(11)
	bc 12,2,.L664
.L665:
	lwz 8,84(31)
	cmpwi 0,8,0
	bc 12,2,.L664
	lwz 0,tech.174@l(11)
	lis 9,itemlist@ha
	addi 10,8,740
	la 9,itemlist@l(9)
	lis 11,0x38e3
	subf 0,9,0
	ori 11,11,36409
	mullw 0,0,11
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L664
	lis 9,level+4@ha
	lfs 0,3932(8)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L664
	lis 9,.LC167@ha
	lis 29,gi@ha
	la 9,.LC167@l(9)
	la 29,gi@l(29)
	lfs 0,0(9)
	lis 3,.LC166@ha
	la 3,.LC166@l(3)
	fadds 0,13,0
	stfs 0,3932(8)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC167@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC167@l(9)
	li 4,2
	lfs 2,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC168@ha
	la 9,.LC168@l(9)
	lfs 3,0(9)
	blrl
.L664:
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
	.type	 tech.178,@object
	.size	 tech.178,4
tech.178:
	.long 0
	.section	".rodata"
	.align 2
.LC170:
	.string	"ctf/tech4.wav"
	.align 2
.LC169:
	.long 0x3e4ccccd
	.align 2
.LC171:
	.long 0x3f800000
	.align 3
.LC172:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC173:
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
	lis 9,.LC171@ha
	lwz 29,84(31)
	la 9,.LC171@l(9)
	li 28,0
	lfs 31,0(9)
	cmpwi 0,29,0
	bc 12,2,.L666
	lwz 0,3812(29)
	cmpwi 0,0,0
	bc 12,2,.L668
	lis 9,.LC169@ha
	lfs 31,.LC169@l(9)
.L668:
	lis 11,tech.178@ha
	lwz 0,tech.178@l(11)
	cmpwi 0,0,0
	bc 4,2,.L677
	lis 9,item_tech4@ha
	lwz 0,item_tech4@l(9)
	cmpwi 0,0,0
	stw 0,tech.178@l(11)
	bc 12,2,.L666
.L677:
	lwz 0,tech.178@l(11)
	lis 9,itemlist@ha
	addi 10,29,740
	la 9,itemlist@l(9)
	lis 11,0x38e3
	subf 0,9,0
	ori 11,11,36409
	mullw 0,0,11
	mr 30,10
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L666
	lis 9,level+4@ha
	lfs 0,3928(29)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L671
	stfs 13,3928(29)
	lwz 9,480(31)
	cmpwi 0,9,149
	bc 12,1,.L672
	addi 0,9,5
	cmpwi 0,0,150
	stw 0,480(31)
	bc 4,1,.L673
	li 0,150
	stw 0,480(31)
.L673:
	lfs 0,3928(29)
	lis 9,.LC172@ha
	li 28,1
	la 9,.LC172@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3928(29)
.L672:
	mr 3,31
	bl ArmorIndex
	mr. 3,3
	bc 12,2,.L671
	slwi 3,3,2
	lwzx 9,30,3
	cmpwi 0,9,149
	bc 12,1,.L671
	addi 0,9,5
	cmpwi 0,0,150
	stwx 0,30,3
	bc 4,1,.L675
	li 0,150
	stwx 0,30,3
.L675:
	lfs 0,3928(29)
	lis 9,.LC172@ha
	li 28,1
	la 9,.LC172@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3928(29)
.L671:
	cmpwi 0,28,0
	bc 12,2,.L666
	lwz 11,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,3932(11)
	fcmpu 0,0,13
	bc 4,0,.L666
	lis 9,.LC171@ha
	lis 29,gi@ha
	la 9,.LC171@l(9)
	la 29,gi@l(29)
	lfs 0,0(9)
	lis 3,.LC170@ha
	la 3,.LC170@l(3)
	fadds 0,13,0
	stfs 0,3932(11)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC171@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC171@l(9)
	li 4,2
	lfs 2,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC173@ha
	la 9,.LC173@l(9)
	lfs 3,0(9)
	blrl
.L666:
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
	.type	 tech.182,@object
	.size	 tech.182,4
tech.182:
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
	.long .LC174
	.long 2
	.long .LC175
	.long 2
	.long .LC176
	.long 3
	.long .LC177
	.long 4
	.long .LC178
	.long 4
	.long .LC179
	.long 4
	.long .LC180
	.long 4
	.long .LC181
	.long 4
	.long .LC182
	.long 4
	.long .LC183
	.long 4
	.long .LC184
	.long 4
	.long .LC185
	.long 5
	.long .LC186
	.long 5
	.long .LC187
	.long 6
	.long .LC188
	.long 6
	.long .LC189
	.long 6
	.long .LC190
	.long 7
	.long .LC191
	.long 7
	.long .LC192
	.long 7
	.long .LC193
	.long 7
	.long .LC194
	.long 8
	.long .LC195
	.long 8
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC195:
	.string	"item_pack"
	.align 2
.LC194:
	.string	"item_bandolier"
	.align 2
.LC193:
	.string	"item_adrenaline"
	.align 2
.LC192:
	.string	"item_enviro"
	.align 2
.LC191:
	.string	"item_breather"
	.align 2
.LC190:
	.string	"item_silencer"
	.align 2
.LC189:
	.string	"item_armor_jacket"
	.align 2
.LC188:
	.string	"item_armor_combat"
	.align 2
.LC187:
	.string	"item_armor_body"
	.align 2
.LC186:
	.string	"item_power_shield"
	.align 2
.LC185:
	.string	"item_power_screen"
	.align 2
.LC184:
	.string	"weapon_shotgun"
	.align 2
.LC183:
	.string	"weapon_supershotgun"
	.align 2
.LC182:
	.string	"weapon_machinegun"
	.align 2
.LC181:
	.string	"weapon_grenadelauncher"
	.align 2
.LC180:
	.string	"weapon_chaingun"
	.align 2
.LC179:
	.string	"weapon_hyperblaster"
	.align 2
.LC178:
	.string	"weapon_rocketlauncher"
	.align 2
.LC177:
	.string	"weapon_railgun"
	.align 2
.LC176:
	.string	"weapon_bfg"
	.align 2
.LC175:
	.string	"item_invulnerability"
	.align 2
.LC174:
	.string	"item_quad"
	.size	 loc_names,200
	.align 2
.LC197:
	.string	"nowhere"
	.align 2
.LC198:
	.string	"in the water "
	.align 2
.LC199:
	.string	"above "
	.align 2
.LC200:
	.string	"below "
	.align 2
.LC201:
	.string	"near "
	.align 2
.LC202:
	.string	"the red "
	.align 2
.LC203:
	.string	"the blue "
	.align 2
.LC204:
	.string	"the "
	.align 2
.LC196:
	.long 0x497423f0
	.align 2
.LC205:
	.long 0x44800000
	.align 3
.LC206:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC207:
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
	lis 11,.LC196@ha
	la 20,loc_names+4@l(9)
	lfs 31,.LC196@l(11)
	mr 27,3
	lis 9,.LC205@ha
	addi 17,20,-4
	la 9,.LC205@l(9)
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
.L682:
	cmpwi 0,30,0
	bc 4,2,.L685
	lwz 31,g_edicts@l(21)
	b .L686
.L733:
	mr 30,31
	b .L698
.L685:
	addi 31,30,1332
.L686:
	la 11,globals@l(15)
	lwz 9,g_edicts@l(21)
	lwz 0,72(11)
	mulli 0,0,1332
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L699
	mr 24,11
	addi 28,31,188
	addi 30,31,200
	addi 29,31,4
.L689:
	lwz 0,-112(30)
	cmpwi 0,0,0
	bc 12,2,.L691
	li 0,3
	lis 9,.LC206@ha
	mtctr 0
	la 9,.LC206@l(9)
	mr 8,29
	lfd 10,0(9)
	mr 10,28
	mr 11,30
	li 9,0
.L735:
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
	bdnz .L735
	addi 3,1,24
	bl VectorLength
	fcmpu 0,1,30
	bc 4,1,.L733
.L691:
	lwz 9,72(24)
	addi 31,31,1332
	addi 28,28,1332
	lwz 0,g_edicts@l(21)
	addi 30,30,1332
	addi 29,29,1332
	mulli 9,9,1332
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L689
.L699:
	li 30,0
.L698:
	cmpwi 0,30,0
	bc 12,2,.L683
	li 31,0
	b .L700
.L702:
	addi 31,31,1
.L700:
	slwi 28,31,3
	lwzx 4,17,28
	mr 29,28
	cmpwi 0,4,0
	bc 12,2,.L682
	lwz 3,280(30)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L702
	lwzx 0,17,29
	cmpwi 0,0,0
	bc 12,2,.L682
	mr 3,30
	mr 4,27
	bl loc_CanSee
	cmpwi 7,22,0
	addic 0,3,-1
	subfe 9,0,3
	mfcr 0
	rlwinm 0,0,31,1
	and. 11,9,0
	bc 12,2,.L707
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
	b .L682
.L707:
	cmpwi 4,3,0
	addic 0,22,-1
	subfe 9,0,22
	mfcr 0
	rlwinm 0,0,19,1
	and. 11,9,0
	bc 4,2,.L682
	bc 12,30,.L709
	lwzx 0,20,29
	cmpw 0,23,0
	bc 12,0,.L682
.L709:
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
	bc 12,0,.L711
	bc 12,18,.L682
	lwzx 0,20,28
	cmpw 0,0,23
	bc 4,0,.L682
.L711:
	mr 26,30
	fmr 31,1
	mr 4,27
	mr 3,26
	mr 23,31
	bl loc_CanSee
	mr 22,3
	b .L682
.L683:
	cmpwi 0,26,0
	bc 4,2,.L712
	b .L736
.L734:
	li 16,1
	b .L714
.L712:
	li 30,0
	lis 31,.LC11@ha
	lis 29,.LC12@ha
	b .L713
.L715:
	cmpw 0,30,26
	bc 12,2,.L713
	la 5,.LC11@l(31)
	li 3,0
	li 4,280
	bl G_Find
	mr. 31,3
	bc 12,2,.L714
	la 5,.LC12@l(29)
	li 3,0
	li 4,280
	bl G_Find
	mr. 30,3
	bc 12,2,.L714
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
	bc 12,0,.L734
	bc 4,1,.L714
	li 16,2
	b .L714
.L713:
	lwz 5,280(26)
	mr 3,30
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L715
.L714:
	lwz 3,280(26)
	bl FindItemByClassname
	mr. 31,3
	bc 4,2,.L722
.L736:
	lis 9,.LC197@ha
	la 11,.LC197@l(9)
	lwz 0,.LC197@l(9)
	lwz 10,4(11)
	stw 0,0(25)
	stw 10,4(25)
	b .L681
.L722:
	lwz 0,612(27)
	cmpwi 0,0,0
	bc 12,2,.L723
	lis 11,.LC198@ha
	lwz 10,.LC198@l(11)
	la 9,.LC198@l(11)
	lhz 8,12(9)
	lwz 0,4(9)
	lwz 11,8(9)
	stw 10,0(25)
	stw 0,4(25)
	stw 11,8(25)
	sth 8,12(25)
	b .L724
.L723:
	stb 0,0(25)
.L724:
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
	bc 4,1,.L725
	fmr 0,10
	fabs 0,0
	fcmpu 0,12,0
	bc 4,1,.L725
	lis 9,.LC207@ha
	la 9,.LC207@l(9)
	lfs 0,0(9)
	fcmpu 0,11,0
	bc 4,1,.L726
	lis 4,.LC199@ha
	mr 3,25
	la 4,.LC199@l(4)
	bl strcat
	b .L728
.L726:
	lis 4,.LC200@ha
	mr 3,25
	la 4,.LC200@l(4)
	bl strcat
	b .L728
.L725:
	lis 4,.LC201@ha
	mr 3,25
	la 4,.LC201@l(4)
	bl strcat
.L728:
	cmpwi 0,16,1
	bc 4,2,.L729
	lis 4,.LC202@ha
	mr 3,25
	la 4,.LC202@l(4)
	bl strcat
	b .L730
.L729:
	cmpwi 0,16,2
	bc 4,2,.L731
	lis 4,.LC203@ha
	mr 3,25
	la 4,.LC203@l(4)
	bl strcat
	b .L730
.L731:
	lis 4,.LC204@ha
	mr 3,25
	la 4,.LC204@l(4)
	bl strcat
.L730:
	lwz 4,40(31)
	mr 3,25
	bl strcat
.L681:
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
.LC208:
	.string	"cells"
	.align 2
.LC209:
	.string	"%s with %i cells "
	.align 2
.LC210:
	.string	"Power Screen"
	.align 2
.LC211:
	.string	"Power Shield"
	.align 2
.LC212:
	.string	"and "
	.align 2
.LC213:
	.string	"%i units of %s"
	.align 2
.LC214:
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
	bc 12,2,.L738
	lis 3,.LC208@ha
	lwz 29,84(30)
	la 3,.LC208@l(3)
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
	lwzx 29,29,3
	cmpwi 0,29,0
	bc 12,2,.L738
	mr 3,31
	bl strlen
	cmpwi 0,28,1
	add 3,31,3
	bc 4,2,.L740
	lis 9,.LC210@ha
	la 5,.LC210@l(9)
	b .L741
.L740:
	lis 9,.LC211@ha
	la 5,.LC211@l(9)
.L741:
	lis 4,.LC209@ha
	mr 6,29
	la 4,.LC209@l(4)
	crxor 6,6,6
	bl sprintf
.L738:
	mr 3,30
	bl ArmorIndex
	mr. 29,3
	bc 12,2,.L742
	mr 3,29
	bl GetItemByIndex
	mr. 28,3
	bc 12,2,.L742
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L744
	lis 4,.LC212@ha
	mr 3,31
	la 4,.LC212@l(4)
	bl strcat
.L744:
	mr 3,31
	bl strlen
	lwz 9,84(30)
	slwi 0,29,2
	lis 4,.LC213@ha
	lwz 6,40(28)
	la 4,.LC213@l(4)
	add 3,31,3
	addi 9,9,740
	lwzx 5,9,0
	crxor 6,6,6
	bl sprintf
.L742:
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 4,2,.L745
	lis 9,.LC214@ha
	lwz 10,.LC214@l(9)
	la 11,.LC214@l(9)
	lbz 0,8(11)
	lwz 9,4(11)
	stb 0,8(31)
	stw 10,0(31)
	stw 9,4(31)
.L745:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 CTFSay_Team_Armor,.Lfe29-CTFSay_Team_Armor
	.section	".rodata"
	.align 2
.LC215:
	.string	"dead"
	.align 2
.LC216:
	.string	"%i health"
	.align 2
.LC217:
	.string	"the %s"
	.align 2
.LC218:
	.string	"no powerup"
	.align 2
.LC219:
	.string	"none"
	.align 2
.LC220:
	.string	", "
	.align 2
.LC221:
	.string	" and "
	.align 2
.LC222:
	.string	"no one"
	.align 2
.LC223:
	.long 0x3f800000
	.align 3
.LC224:
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
	lis 9,.LC223@ha
	stb 27,1032(1)
	li 24,1
	la 9,.LC223@l(9)
	stb 27,8(1)
	lis 19,maxclients@ha
	lfs 13,0(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L760
	lis 11,.LC224@ha
	lis 20,g_edicts@ha
	la 11,.LC224@l(11)
	lis 21,.LC220@ha
	lfd 31,0(11)
	lis 22,0x4330
	li 25,1332
.L762:
	lwz 0,g_edicts@l(20)
	add 30,0,25
	lwz 9,88(30)
	xor 0,30,26
	subfic 11,0,0
	adde 0,11,0
	subfic 11,9,0
	adde 9,11,9
	or. 28,9,0
	bc 4,2,.L761
	mr 3,30
	mr 4,26
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L761
	lbz 0,1032(1)
	addi 31,1,1032
	cmpwi 0,0,0
	bc 12,2,.L765
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,3
	cmplwi 0,29,1023
	bc 12,1,.L766
	cmpwi 0,27,0
	bc 12,2,.L767
	addi 3,1,8
	la 4,.LC220@l(21)
	bl strcat
.L767:
	addi 3,1,8
	mr 4,31
	bl strcat
	stb 28,1032(1)
.L766:
	addi 27,27,1
.L765:
	lwz 4,84(30)
	mr 3,31
	addi 4,4,700
	bl strcpy
.L761:
	addi 24,24,1
	lwz 11,maxclients@l(19)
	xoris 0,24,0x8000
	addi 25,25,1332
	stw 0,2076(1)
	stw 22,2072(1)
	lfd 0,2072(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L762
.L760:
	lbz 0,1032(1)
	cmpwi 0,0,0
	bc 12,2,.L769
	addi 31,1,1032
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,6
	cmplwi 0,29,1023
	bc 12,1,.L770
	cmpwi 0,27,0
	bc 12,2,.L771
	lis 4,.LC221@ha
	addi 3,1,8
	la 4,.LC221@l(4)
	bl strcat
.L771:
	mr 4,31
	addi 3,1,8
	bl strcat
.L770:
	mr 3,23
	addi 4,1,8
	bl strcpy
	b .L772
.L769:
	lis 9,.LC222@ha
	lwz 10,.LC222@l(9)
	la 11,.LC222@l(9)
	lbz 0,6(11)
	lhz 9,4(11)
	stb 0,6(23)
	stw 10,0(23)
	sth 9,4(23)
.L772:
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
.LC225:
	.string	"(%s): %s\n"
	.align 2
.LC226:
	.long 0x0
	.align 3
.LC227:
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
	bc 4,2,.L774
	mr 3,30
	bl strlen
	add 3,3,30
	stb 31,-1(3)
	addi 30,30,1
.L774:
	lbz 9,0(30)
	addi 31,1,8
	lis 23,maxclients@ha
	mr 24,31
	cmpwi 0,9,0
	bc 12,2,.L776
.L778:
	cmpwi 0,9,37
	bc 4,2,.L780
	lbzu 9,1(30)
	addi 9,9,-65
	cmplwi 0,9,54
	bc 12,1,.L806
	lis 11,.L807@ha
	slwi 10,9,2
	la 11,.L807@l(11)
	lis 9,.L807@ha
	lwzx 0,10,11
	la 9,.L807@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L807:
	.long .L785-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L787-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L783-.L807
	.long .L806-.L807
	.long .L805-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L792-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L800-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L785-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L787-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L783-.L807
	.long .L806-.L807
	.long .L805-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L792-.L807
	.long .L806-.L807
	.long .L806-.L807
	.long .L800-.L807
.L783:
	addi 29,1,1032
	mr 3,27
	mr 4,29
	addi 30,30,1
	bl CTFSay_Team_Location
	b .L819
.L785:
	addi 29,1,1032
	mr 3,27
	mr 4,29
	addi 30,30,1
	bl CTFSay_Team_Armor
	b .L819
.L787:
	lwz 5,480(27)
	cmpwi 0,5,0
	bc 12,1,.L788
	lis 9,.LC215@ha
	la 11,.LC215@l(9)
	lwz 0,.LC215@l(9)
	lbz 10,4(11)
	stw 0,1032(1)
	stb 10,1036(1)
	b .L790
.L788:
	lis 4,.LC216@ha
	addi 3,1,1032
	la 4,.LC216@l(4)
	crxor 6,6,6
	bl sprintf
.L790:
	addi 29,1,1032
	mr 3,31
	mr 4,29
	addi 30,30,1
	b .L820
.L818:
	lwz 5,40(3)
	lis 4,.LC217@ha
	addi 3,1,1032
	la 4,.LC217@l(4)
	crxor 6,6,6
	bl sprintf
	b .L797
.L792:
	lis 9,tnames@ha
	addi 30,30,1
	la 3,tnames@l(9)
	addi 26,1,1032
	lwz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L798
	lis 9,itemlist@ha
	lis 29,0x38e3
	la 25,itemlist@l(9)
	mr 28,3
	ori 29,29,36409
.L795:
	lwz 3,0(28)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L796
	subf 0,25,3
	lwz 11,84(27)
	mullw 0,0,29
	addi 11,11,740
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L818
.L796:
	lwzu 0,4(28)
	cmpwi 0,0,0
	bc 4,2,.L795
.L798:
	lis 9,.LC218@ha
	la 11,.LC218@l(9)
	lwz 10,.LC218@l(9)
	lbz 8,10(11)
	lwz 0,4(11)
	lhz 9,8(11)
	stw 10,1032(1)
	stw 0,1036(1)
	sth 9,1040(1)
	stb 8,1042(1)
.L797:
	mr 3,31
	mr 4,26
	bl strcpy
	mr 3,26
	b .L821
.L800:
	lwz 9,84(27)
	lwz 9,1788(9)
	cmpwi 0,9,0
	bc 12,2,.L801
	lwz 4,40(9)
	addi 3,1,1032
	bl strcpy
	b .L803
.L801:
	lis 9,.LC219@ha
	la 11,.LC219@l(9)
	lwz 0,.LC219@l(9)
	lbz 10,4(11)
	stw 0,1032(1)
	stb 10,1036(1)
.L803:
	addi 29,1,1032
	mr 3,31
	mr 4,29
	addi 30,30,1
	b .L820
.L805:
	addi 29,1,1032
	mr 3,27
	mr 4,29
	addi 30,30,1
	bl CTFSay_Team_Sight
.L819:
	mr 3,31
	mr 4,29
.L820:
	bl strcpy
	mr 3,29
.L821:
	bl strlen
	add 31,31,3
	b .L777
.L806:
	lbz 0,0(30)
	addi 30,30,1
	stb 0,0(31)
	b .L822
.L780:
	stb 9,0(31)
	addi 30,30,1
.L822:
	addi 31,31,1
.L777:
	lbz 9,0(30)
	cmpwi 0,9,0
	bc 12,2,.L776
	subf 0,24,31
	cmplwi 0,0,1022
	bc 4,1,.L778
.L776:
	lis 9,maxclients@ha
	li 0,0
	lwz 11,maxclients@l(9)
	li 30,0
	lis 9,.LC226@ha
	stb 0,0(31)
	la 9,.LC226@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,13,0
	bc 4,0,.L811
	lis 9,gi@ha
	lis 25,g_edicts@ha
	la 26,gi@l(9)
	lis 28,.LC225@ha
	lis 9,.LC227@ha
	lis 29,0x4330
	la 9,.LC227@l(9)
	li 31,1332
	lfd 31,0(9)
.L813:
	lwz 0,g_edicts@l(25)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L812
	lwz 9,84(3)
	lwz 6,84(27)
	lwz 11,3464(9)
	lwz 0,3464(6)
	cmpw 0,11,0
	bc 4,2,.L812
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 4,2,.L812
	lwz 9,8(26)
	addi 6,6,700
	li 4,3
	la 5,.LC225@l(28)
	addi 7,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L812:
	addi 30,30,1
	lwz 11,maxclients@l(23)
	xoris 0,30,0x8000
	addi 31,31,1332
	stw 0,2076(1)
	stw 29,2072(1)
	lfd 0,2072(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L813
.L811:
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
.LC229:
	.string	"models/ctf/banner/tris.md2"
	.align 2
.LC231:
	.string	"models/ctf/banner/small.md2"
	.align 2
.LC233:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFJoinTeam
	.type	 CTFJoinTeam,@function
CTFJoinTeam:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	lis 11,.LC233@ha
	lis 9,ctf@ha
	la 11,.LC233@l(11)
	mr 31,3
	lfs 31,0(11)
	mr 30,4
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L828
	bl PMenu_Close
	lwz 0,184(31)
	li 10,0
	lis 4,.LC141@ha
	lwz 11,84(31)
	la 4,.LC141@l(4)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	stw 30,3464(11)
	lwz 9,84(31)
	stw 10,3468(9)
	lwz 3,84(31)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl CTFAssignSkin
	lis 9,niq_enable@ha
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L830
	lis 9,niq_logfile@ha
	lwz 11,niq_logfile@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L830
	lwz 9,84(31)
	lwz 0,3464(9)
	addi 4,9,700
	cmpwi 0,0,1
	bc 12,2,.L831
	cmpwi 0,0,2
	bc 12,2,.L832
	b .L835
.L831:
	lis 9,.LC13@ha
	la 5,.LC13@l(9)
	b .L834
.L832:
	lis 9,.LC14@ha
	la 5,.LC14@l(9)
	b .L834
.L835:
	lis 9,.LC15@ha
	la 5,.LC15@l(9)
.L834:
	lis 9,level+4@ha
	lis 3,gi@ha
	lfs 1,level+4@l(9)
	la 3,gi@l(3)
	bl sl_LogPlayerName
.L830:
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
	bc 12,2,.L836
	cmpwi 0,30,2
	bc 12,2,.L837
	b .L840
.L836:
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L839
.L837:
	lis 9,.LC14@ha
	la 6,.LC14@l(9)
	b .L839
.L840:
	lis 9,.LC15@ha
	la 6,.LC15@l(9)
.L839:
	lis 4,.LC142@ha
	li 3,2
	la 4,.LC142@l(4)
	crxor 6,6,6
	bl my_bprintf
.L828:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe32:
	.size	 CTFJoinTeam,.Lfe32-CTFJoinTeam
	.globl creditsmenu
	.section	".data"
	.align 2
	.type	 creditsmenu,@object
creditsmenu:
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
	.long 1
	.long 0
	.long 0
	.long .LC237
	.long 1
	.long 0
	.long 0
	.long .LC238
	.long 1
	.long 0
	.long 0
	.long .LC239
	.long 1
	.long 0
	.long 0
	.long .LC240
	.long 1
	.long 0
	.long 0
	.long .LC237
	.long 1
	.long 0
	.long 0
	.long .LC241
	.long 1
	.long 0
	.long 0
	.long .LC242
	.long 1
	.long 0
	.long 0
	.long .LC243
	.long 1
	.long 0
	.long 0
	.long .LC244
	.long 1
	.long 0
	.long 0
	.long .LC245
	.long 1
	.long 0
	.long 0
	.long .LC246
	.long 1
	.long 0
	.long 0
	.long .LC247
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC248
	.long 0
	.long 0
	.long CTFReturnToMain
	.section	".rodata"
	.align 2
.LC248:
	.string	"Return to Main Menu"
	.align 2
.LC247:
	.string	"Brian 'Whaleboy' Cozzens"
	.align 2
.LC246:
	.string	"*Original CTF Art Design"
	.align 2
.LC245:
	.string	"Tom 'Bjorn' Klok"
	.align 2
.LC244:
	.string	"*Sound"
	.align 2
.LC243:
	.string	"Kevin Cloud"
	.align 2
.LC242:
	.string	"Adrian Carmack Paul Steed"
	.align 2
.LC241:
	.string	"*Art"
	.align 2
.LC240:
	.string	"Tim Willits"
	.align 2
.LC239:
	.string	"Christian Antkow"
	.align 2
.LC238:
	.string	"*Level Design"
	.align 2
.LC237:
	.string	"Dave 'Zoid' Kirsch"
	.align 2
.LC236:
	.string	"*Programming"
	.align 2
.LC235:
	.string	"*ThreeWave Capture the Flag"
	.align 2
.LC234:
	.string	"*Quake II"
	.size	 creditsmenu,288
	.globl joinmenu
	.section	".data"
	.align 2
	.type	 joinmenu,@object
joinmenu:
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
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC249
	.long 0
	.long 0
	.long CTFJoinTeam1
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC250
	.long 0
	.long 0
	.long CTFJoinTeam2
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC251
	.long 0
	.long 0
	.long CTFChaseCam
	.long .LC252
	.long 0
	.long 0
	.long CTFCredits
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC253
	.long 0
	.long 0
	.long 0
	.long .LC254
	.long 0
	.long 0
	.long 0
	.long .LC255
	.long 0
	.long 0
	.long 0
	.long .LC256
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC257
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC257:
	.string	"v1.02"
	.align 2
.LC256:
	.string	"(TAB to Return)"
	.align 2
.LC255:
	.string	"ESC to Exit Menu"
	.align 2
.LC254:
	.string	"ENTER to select"
	.align 2
.LC253:
	.string	"Use [ and ] to move cursor"
	.align 2
.LC252:
	.string	"Credits"
	.align 2
.LC251:
	.string	"Chase Camera"
	.align 2
.LC250:
	.string	"Join Blue Team"
	.align 2
.LC249:
	.string	"Join Red Team"
	.size	 joinmenu,272
	.lcomm	levelname.234,32,4
	.lcomm	team1players.235,32,4
	.lcomm	team2players.236,32,4
	.align 2
.LC258:
	.string	"Leave Chase Camera"
	.align 2
.LC259:
	.string	"  (%d players)"
	.align 2
.LC260:
	.long 0x0
	.align 3
.LC261:
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
	lis 11,.LC249@ha
	la 29,joinmenu@l(9)
	lis 10,CTFJoinTeam1@ha
	lis 9,.LC250@ha
	lis 8,CTFJoinTeam2@ha
	lis 30,ctf_forcejoin@ha
	la 11,.LC249@l(11)
	lwz 7,ctf_forcejoin@l(30)
	la 10,CTFJoinTeam1@l(10)
	la 9,.LC250@l(9)
	la 8,CTFJoinTeam2@l(8)
	stw 11,64(29)
	mr 31,3
	stw 10,76(29)
	stw 9,96(29)
	stw 8,108(29)
	lwz 3,4(7)
	cmpwi 0,3,0
	bc 12,2,.L855
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L855
	lis 4,.LC137@ha
	la 4,.LC137@l(4)
	bl stricmp
	mr. 3,3
	bc 4,2,.L856
	stw 3,108(29)
	stw 3,96(29)
	b .L855
.L856:
	lwz 9,ctf_forcejoin@l(30)
	lis 4,.LC138@ha
	la 4,.LC138@l(4)
	lwz 3,4(9)
	bl stricmp
	mr. 3,3
	bc 4,2,.L855
	stw 3,76(29)
	stw 3,64(29)
.L855:
	lwz 9,84(31)
	lwz 0,3940(9)
	cmpwi 0,0,0
	bc 12,2,.L859
	lis 9,.LC258@ha
	lis 11,joinmenu+128@ha
	la 9,.LC258@l(9)
	b .L882
.L859:
	lis 9,.LC251@ha
	lis 11,joinmenu+128@ha
	la 9,.LC251@l(9)
.L882:
	stw 9,joinmenu+128@l(11)
	lis 9,g_edicts@ha
	lis 11,levelname.234@ha
	lwz 10,g_edicts@l(9)
	li 0,42
	la 3,levelname.234@l(11)
	stb 0,levelname.234@l(11)
	lwz 4,276(10)
	cmpwi 0,4,0
	bc 12,2,.L861
	addi 3,3,1
	li 5,30
	bl strncpy
	b .L862
.L861:
	lis 4,level+72@ha
	addi 3,3,1
	la 4,level+72@l(4)
	li 5,30
	bl strncpy
.L862:
	lis 9,maxclients@ha
	lis 11,levelname.234+31@ha
	lwz 10,maxclients@l(9)
	li 0,0
	lis 4,.LC260@ha
	la 4,.LC260@l(4)
	stb 0,levelname.234+31@l(11)
	li 31,0
	lfs 0,0(4)
	li 30,0
	li 7,0
	lfs 13,20(10)
	fcmpu 0,0,13
	bc 4,0,.L864
	lis 9,g_edicts@ha
	fmr 12,13
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	la 5,game@l(11)
	lis 6,0x4330
	lis 9,.LC261@ha
	li 8,0
	la 9,.LC261@l(9)
	addi 10,10,1420
	lfd 13,0(9)
.L866:
	lwz 0,0(10)
	addi 10,10,1332
	cmpwi 0,0,0
	bc 12,2,.L865
	lwz 9,1028(5)
	add 9,8,9
	lwz 11,3464(9)
	cmpwi 0,11,1
	bc 4,2,.L868
	addi 30,30,1
	b .L865
.L868:
	xori 11,11,2
	addi 9,31,1
	srawi 4,11,31
	xor 0,4,11
	subf 0,0,4
	srawi 0,0,31
	andc 9,9,0
	and 0,31,0
	or 31,0,9
.L865:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,3968
	stw 0,28(1)
	stw 6,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L866
.L864:
	lis 29,.LC259@ha
	lis 3,team1players.235@ha
	la 4,.LC259@l(29)
	mr 5,30
	la 3,team1players.235@l(3)
	crxor 6,6,6
	bl sprintf
	lis 3,team2players.236@ha
	la 4,.LC259@l(29)
	la 3,team2players.236@l(3)
	mr 5,31
	crxor 6,6,6
	bl sprintf
	lis 11,joinmenu@ha
	lis 9,levelname.234@ha
	la 11,joinmenu@l(11)
	la 9,levelname.234@l(9)
	lwz 0,64(11)
	stw 9,32(11)
	cmpwi 0,0,0
	bc 12,2,.L872
	lis 9,team1players.235@ha
	la 9,team1players.235@l(9)
	stw 9,80(11)
	b .L873
.L872:
	stw 0,80(11)
.L873:
	lis 9,joinmenu@ha
	la 11,joinmenu@l(9)
	lwz 0,96(11)
	cmpwi 0,0,0
	bc 12,2,.L874
	lis 9,team2players.236@ha
	la 9,team2players.236@l(9)
	stw 9,112(11)
	b .L875
.L874:
	stw 0,112(11)
.L875:
	cmpw 0,30,31
	bc 12,1,.L883
	cmpw 0,31,30
	bc 4,1,.L877
.L883:
	li 3,1
	b .L881
.L877:
	bl rand
	andi. 0,3,1
	mfcr 3
	rlwinm 3,3,3,1
	neg 3,3
	addi 0,3,1
	rlwinm 3,3,0,30,30
	or 3,3,0
.L881:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe33:
	.size	 CTFUpdateJoinMenu,.Lfe33-CTFUpdateJoinMenu
	.section	".rodata"
	.align 2
.LC263:
	.string	"Capturelimit hit.\n"
	.align 3
.LC262:
	.long 0x3f50624d
	.long 0xd2f1a9fc
	.align 2
.LC264:
	.long 0x0
	.align 3
.LC265:
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
	lis 11,.LC264@ha
	lis 9,capturelimit@ha
	la 11,.LC264@l(11)
	lfs 0,0(11)
	lwz 11,capturelimit@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L901
	lis 9,ctfgame@ha
	lwz 0,ctfgame@l(9)
	la 8,ctfgame@l(9)
	lis 10,0x4330
	lis 9,.LC265@ha
	xoris 0,0,0x8000
	la 9,.LC265@l(9)
	stw 0,12(1)
	stw 10,8(1)
	lfd 11,0(9)
	lfd 0,8(1)
	fsub 0,0,11
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 12,3,.L902
	fsubs 0,13,0
	lis 9,.LC262@ha
	lfd 12,.LC262@l(9)
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L902
	lwz 0,4(8)
	mr 9,11
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 10,8(1)
	lfd 0,8(1)
	fsub 0,0,11
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 12,3,.L902
	fsubs 0,13,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L901
.L902:
	lis 4,.LC263@ha
	li 3,2
	la 4,.LC263@l(4)
	crxor 6,6,6
	bl my_bprintf
	li 3,1
	b .L903
.L901:
	li 3,0
.L903:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe34:
	.size	 CTFCheckRules,.Lfe34-CTFCheckRules
	.section	".rodata"
	.align 2
.LC266:
	.string	"Couldn't find destination\n"
	.align 2
.LC267:
	.long 0x47800000
	.align 2
.LC268:
	.long 0x43b40000
	.align 2
.LC269:
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
	bc 12,2,.L904
	lwz 5,296(29)
	li 3,0
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L906
	lis 9,gi+4@ha
	lis 3,.LC266@ha
	lwz 0,gi+4@l(9)
	la 3,.LC266@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L904
.L906:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 12,2,.L908
	lwz 3,3912(3)
	cmpwi 0,3,0
	bc 12,2,.L908
	bl CTFResetGrapple
.L908:
	lis 9,gi+76@ha
	mr 3,31
	lwz 0,gi+76@l(9)
	addi 28,31,376
	mtlr 0
	blrl
	lfs 0,4(30)
	lis 9,.LC267@ha
	lis 11,.LC268@ha
	la 9,.LC267@l(9)
	la 11,.LC268@l(11)
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
.L915:
	lwz 10,84(31)
	add 0,6,6
	lfsx 0,7,5
	addi 6,6,1
	addi 9,10,3492
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
	bdnz .L915
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
	stfs 0,3716(9)
	lfs 0,20(30)
	lwz 11,84(31)
	stfs 0,3720(11)
	lfs 13,24(30)
	lwz 9,84(31)
	stfs 13,3724(9)
	lwz 3,84(31)
	addi 3,3,3716
	bl AngleVectors
	lis 9,.LC269@ha
	addi 3,1,8
	la 9,.LC269@l(9)
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
.L904:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe35:
	.size	 old_teleporter_touch,.Lfe35-old_teleporter_touch
	.section	".rodata"
	.align 2
.LC270:
	.string	"teleporter without a target.\n"
	.align 2
.LC271:
	.string	"world/hum1.wav"
	.align 2
.LC272:
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
	bc 4,2,.L917
	lis 9,gi+4@ha
	lis 3,.LC270@ha
	lwz 0,gi+4@l(9)
	la 3,.LC270@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L916
.L917:
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
	lis 9,.LC272@ha
	mtctr 0
	la 9,.LC272@l(9)
	mr 30,3
	lfs 12,0(9)
	addi 8,31,200
	addi 10,31,188
	stw 30,540(31)
	addi 11,30,4
	li 9,0
.L923:
	lfsx 13,9,10
	lfsx 0,9,8
	addi 9,9,4
	fsubs 0,0,13
	fmadds 0,0,12,13
	stfs 0,0(11)
	addi 11,11,4
	bdnz .L923
	lis 29,gi@ha
	lis 3,.LC271@ha
	la 29,gi@l(29)
	la 3,.LC271@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,76(30)
	lwz 0,72(29)
	mr 3,30
	mtlr 0
	blrl
.L916:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe36:
	.size	 SP_trigger_teleport,.Lfe36-SP_trigger_teleport
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
.Lfe37:
	.size	 SP_info_player_team1,.Lfe37-SP_info_player_team1
	.align 2
	.globl SP_info_player_team2
	.type	 SP_info_player_team2,@function
SP_info_player_team2:
	blr
.Lfe38:
	.size	 SP_info_player_team2,.Lfe38-SP_info_player_team2
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
.Lfe39:
	.size	 CTFTeamName,.Lfe39-CTFTeamName
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
.Lfe40:
	.size	 CTFOtherTeamName,.Lfe40-CTFOtherTeamName
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
	bc 12,2,.L351
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L353
	lis 9,gi+8@ha
	lis 5,.LC70@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC70@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L353
.L351:
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L353
	lis 9,gi+8@ha
	lis 5,.LC71@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC71@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L353:
	li 3,0
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe41:
	.size	 CTFDrop_Flag,.Lfe41-CTFDrop_Flag
	.align 2
	.globl CTFScoreboardMessage
	.type	 CTFScoreboardMessage,@function
CTFScoreboardMessage:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl niq_CTFScoreboardMessage
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe42:
	.size	 CTFScoreboardMessage,.Lfe42-CTFScoreboardMessage
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
	lwz 0,3488(9)
	cmpwi 0,0,0
	bc 12,2,.L381
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L382
	lis 9,gi+8@ha
	lis 5,.LC83@ha
	lwz 0,gi+8@l(9)
	la 5,.LC83@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L382:
	lwz 9,84(31)
	li 0,0
	b .L927
.L381:
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L384
	lis 9,gi+8@ha
	lis 5,.LC84@ha
	lwz 0,gi+8@l(9)
	la 5,.LC84@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L384:
	lwz 9,84(31)
	li 0,1
.L927:
	stw 0,3488(9)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe43:
	.size	 CTFID_f,.Lfe43-CTFID_f
	.align 2
	.globl CTFResetFlag
	.type	 CTFResetFlag,@function
CTFResetFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	cmpwi 0,3,1
	bc 12,2,.L189
	cmpwi 0,3,2
	bc 12,2,.L190
	b .L187
.L189:
	lis 9,.LC11@ha
	la 29,.LC11@l(9)
	b .L188
.L190:
	lis 9,.LC12@ha
	la 29,.LC12@l(9)
.L188:
	lis 9,gi@ha
	li 31,0
	la 28,gi@l(9)
	li 30,1
	b .L193
.L195:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L196
	mr 3,31
	bl RemoveFromItemList
	mr 3,31
	bl G_FreeEdict
	b .L193
.L196:
	lwz 0,184(31)
	mr 3,31
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(28)
	mtlr 9
	blrl
	stw 30,80(31)
.L193:
	mr 3,31
	li 4,280
	mr 5,29
	bl G_Find
	mr. 31,3
	bc 4,2,.L195
.L187:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe44:
	.size	 CTFResetFlag,.Lfe44-CTFResetFlag
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
	lwz 0,3464(9)
	cmpwi 0,0,1
	bc 4,2,.L184
	lis 9,flag2_item@ha
	lwz 10,flag2_item@l(9)
	b .L185
.L184:
	lis 9,flag1_item@ha
	lwz 10,flag1_item@l(9)
.L185:
	lis 9,itemlist@ha
	lis 0,0x38e3
	lwz 3,84(3)
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,10
	addi 11,3,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bclr 12,2
	lwz 9,3464(3)
	lwz 0,3464(8)
	cmpw 0,9,0
	bclr 12,2
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	stfs 0,3472(8)
	blr
.Lfe45:
	.size	 CTFCheckHurtCarrier,.Lfe45-CTFCheckHurtCarrier
	.align 2
	.globl CTFPlayerResetGrapple
	.type	 CTFPlayerResetGrapple,@function
CTFPlayerResetGrapple:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L461
	lwz 3,3912(3)
	cmpwi 0,3,0
	bc 12,2,.L461
	bl CTFResetGrapple
.L461:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe46:
	.size	 CTFPlayerResetGrapple,.Lfe46-CTFPlayerResetGrapple
	.section	".rodata"
	.align 2
.LC273:
	.long 0x3e4ccccd
	.align 2
.LC274:
	.long 0x3f800000
	.align 2
.LC275:
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
	lwz 0,3912(9)
	cmpwi 0,0,0
	bc 12,2,.L463
	lwz 0,3812(9)
	lis 9,.LC274@ha
	cmpwi 0,0,0
	la 9,.LC274@l(9)
	lfs 31,0(9)
	bc 12,2,.L464
	lis 9,.LC273@ha
	lfs 31,.LC273@l(9)
.L464:
	lis 29,gi@ha
	lis 3,.LC104@ha
	la 29,gi@l(29)
	la 3,.LC104@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC274@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC274@l(9)
	mr 3,30
	lfs 2,0(9)
	mtlr 0
	li 4,17
	lis 9,.LC275@ha
	la 9,.LC275@l(9)
	lfs 3,0(9)
	blrl
	lwz 11,256(31)
	li 8,0
	lis 10,level+4@ha
	mr 3,31
	lwz 9,84(11)
	stw 8,3912(9)
	lfs 0,level+4@l(10)
	lbz 0,16(9)
	stw 8,3916(9)
	andi. 0,0,191
	stfs 0,3920(9)
	stb 0,16(9)
	bl G_FreeEdict
.L463:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe47:
	.size	 CTFResetGrapple,.Lfe47-CTFResetGrapple
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
	bc 12,2,.L574
	lis 9,itemlist@ha
	lis 31,0x38e3
	la 28,itemlist@l(9)
	mr 30,3
	ori 31,31,36409
.L575:
	lwz 3,0(30)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L576
	subf 0,28,3
	lwz 11,84(29)
	mullw 0,0,31
	addi 11,11,740
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L928
.L576:
	lwzu 0,4(30)
	cmpwi 0,0,0
	bc 4,2,.L575
.L574:
	li 3,0
.L928:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe48:
	.size	 CTFWhat_Tech,.Lfe48-CTFWhat_Tech
	.section	".rodata"
	.align 2
.LC276:
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
	lis 9,.LC276@ha
	lis 11,level+4@ha
	la 9,.LC276@l(9)
	lfs 0,level+4@l(11)
	lis 0,0x38e3
	lfs 13,0(9)
	lis 11,TechThink@ha
	ori 0,0,36409
	lis 9,itemlist@ha
	la 11,TechThink@l(11)
	la 9,itemlist@l(9)
	stw 11,436(3)
	fadds 0,0,13
	subf 29,9,29
	li 11,0
	mullw 29,29,0
	stfs 0,428(3)
	srawi 29,29,3
	lwz 9,84(28)
	slwi 29,29,2
	addi 9,9,740
	stwx 11,9,29
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe49:
	.size	 CTFDrop_Tech,.Lfe49-CTFDrop_Tech
	.section	".rodata"
	.align 2
.LC277:
	.long 0x0
	.align 2
.LC278:
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
	lis 11,.LC277@ha
	lis 9,niq_enable@ha
	la 11,.LC277@l(11)
	lfs 13,0(11)
	lwz 11,niq_enable@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L636
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L636
	lis 31,techspawn@ha
	lwz 0,techspawn@l(31)
	cmpwi 0,0,0
	bc 4,2,.L636
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 0,11,8
	bc 4,2,.L636
	bl G_Spawn
	lis 9,.LC278@ha
	lis 11,level+4@ha
	la 9,.LC278@l(9)
	lfs 0,level+4@l(11)
	li 0,1
	lfs 13,0(9)
	lis 9,SpawnTechs@ha
	la 9,SpawnTechs@l(9)
	fadds 0,0,13
	stw 9,436(3)
	stfs 0,428(3)
	stw 0,techspawn@l(31)
.L636:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe50:
	.size	 CTFSetupTechSpawn,.Lfe50-CTFSetupTechSpawn
	.section	".rodata"
	.align 2
.LC279:
	.long 0x3e4ccccd
	.align 2
.LC280:
	.long 0x3f800000
	.align 2
.LC281:
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
	lis 11,.LC280@ha
	lwz 9,84(30)
	la 11,.LC280@l(11)
	mr 31,4
	lfs 31,0(11)
	cmpwi 0,9,0
	bc 12,2,.L642
	lwz 0,3812(9)
	cmpwi 0,0,0
	bc 12,2,.L642
	lis 9,.LC279@ha
	lfs 31,.LC279@l(9)
.L642:
	lis 11,tech.158@ha
	lwz 0,tech.158@l(11)
	cmpwi 0,0,0
	bc 4,2,.L643
	lis 9,item_tech1@ha
	lwz 0,item_tech1@l(9)
	stw 0,tech.158@l(11)
.L643:
	cmpwi 0,31,0
	bc 12,2,.L644
	lwz 10,tech.158@l(11)
	cmpwi 0,10,0
	bc 12,2,.L644
	lwz 11,84(30)
	cmpwi 0,11,0
	bc 12,2,.L644
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,10
	addi 11,11,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L644
	lis 29,gi@ha
	lis 3,.LC158@ha
	la 29,gi@l(29)
	la 3,.LC158@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC280@ha
	lis 11,.LC281@ha
	fmr 1,31
	mr 5,3
	la 9,.LC280@l(9)
	la 11,.LC281@l(11)
	mr 3,30
	lfs 2,0(9)
	mtlr 0
	li 4,2
	lfs 3,0(11)
	blrl
	srwi 3,31,31
	add 3,31,3
	srawi 3,3,1
	b .L929
.L644:
	mr 3,31
.L929:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe51:
	.size	 CTFApplyResistance,.Lfe51-CTFApplyResistance
	.align 2
	.globl CTFApplyStrength
	.type	 CTFApplyStrength,@function
CTFApplyStrength:
	lis 10,tech.162@ha
	lwz 0,tech.162@l(10)
	cmpwi 0,0,0
	bc 4,2,.L646
	lis 9,item_tech2@ha
	lwz 0,item_tech2@l(9)
	stw 0,tech.162@l(10)
.L646:
	cmpwi 0,4,0
	bc 12,2,.L647
	lwz 10,tech.162@l(10)
	cmpwi 0,10,0
	bc 12,2,.L647
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L647
	lis 9,itemlist@ha
	lis 0,0x38e3
	la 9,itemlist@l(9)
	ori 0,0,36409
	subf 9,9,10
	addi 11,3,740
	mullw 9,9,0
	srawi 9,9,3
	slwi 9,9,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L647
	slwi 3,4,1
	blr
.L647:
	mr 3,4
	blr
.Lfe52:
	.size	 CTFApplyStrength,.Lfe52-CTFApplyStrength
	.section	".rodata"
	.align 2
.LC282:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFApplyHaste
	.type	 CTFApplyHaste,@function
CTFApplyHaste:
	lis 11,.LC282@ha
	lis 9,ctf@ha
	la 11,.LC282@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L658
	li 3,0
	blr
.L658:
	lis 11,tech.170@ha
	lwz 0,tech.170@l(11)
	cmpwi 0,0,0
	bc 4,2,.L932
	lis 9,item_tech3@ha
	lwz 0,item_tech3@l(9)
	cmpwi 0,0,0
	stw 0,tech.170@l(11)
	bc 12,2,.L660
.L932:
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L660
	lwz 0,tech.170@l(11)
	lis 9,itemlist@ha
	addi 10,3,740
	la 9,itemlist@l(9)
	lis 11,0x38e3
	subf 0,9,0
	ori 11,11,36409
	mullw 0,0,11
	li 3,1
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bclr 4,2
.L660:
	li 3,0
	blr
.Lfe53:
	.size	 CTFApplyHaste,.Lfe53-CTFApplyHaste
	.align 2
	.globl CTFHasRegeneration
	.type	 CTFHasRegeneration,@function
CTFHasRegeneration:
	lis 11,tech.182@ha
	lwz 0,tech.182@l(11)
	cmpwi 0,0,0
	bc 4,2,.L934
	lis 9,item_tech4@ha
	lwz 0,item_tech4@l(9)
	cmpwi 0,0,0
	stw 0,tech.182@l(11)
	bc 12,2,.L680
.L934:
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L680
	lwz 0,tech.182@l(11)
	lis 9,itemlist@ha
	addi 10,3,740
	la 9,itemlist@l(9)
	lis 11,0x38e3
	subf 0,9,0
	ori 11,11,36409
	mullw 0,0,11
	li 3,1
	srawi 0,0,3
	slwi 0,0,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bclr 4,2
.L680:
	li 3,0
	blr
.Lfe54:
	.size	 CTFHasRegeneration,.Lfe54-CTFHasRegeneration
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
	bc 12,2,.L633
	lis 28,.LC148@ha
.L632:
	mr 3,30
	li 4,280
	la 5,.LC148@l(28)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L632
.L633:
	cmpwi 0,30,0
	bc 4,2,.L935
	lis 5,.LC148@ha
	li 3,0
	la 5,.LC148@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 12,2,.L629
.L935:
	lwz 3,648(29)
	mr 4,30
	bl SpawnTech
.L629:
	mr 3,29
	bl RemoveFromItemList
	mr 3,29
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe55:
	.size	 CTFRespawnTech,.Lfe55-CTFRespawnTech
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
	lwz 0,3940(9)
	cmpwi 0,0,0
	bc 12,2,.L885
	li 5,8
	b .L886
.L885:
	xori 9,5,1
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	rlwinm 0,0,0,29,30
	ori 5,0,4
.L886:
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
.Lfe56:
	.size	 CTFOpenJoinMenu,.Lfe56-CTFOpenJoinMenu
	.section	".rodata"
	.align 2
.LC283:
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
	lis 11,.LC283@ha
	lis 9,ctf@ha
	la 11,.LC283@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L894
	lwz 8,84(31)
	lwz 0,3464(8)
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
	stw 10,3464(8)
	lwz 9,84(31)
	stw 10,88(9)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	mr 3,31
	bl CTFUpdateJoinMenu
	lwz 9,84(31)
	mr 5,3
	lwz 0,3940(9)
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
	b .L936
.L894:
	li 3,0
.L936:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe57:
	.size	 CTFStartClient,.Lfe57-CTFStartClient
	.section	".rodata"
	.align 3
.LC284:
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
	lis 3,.LC229@ha
	stw 0,260(31)
	la 30,gi@l(9)
	la 3,.LC229@l(3)
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
	lis 11,.LC284@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC284@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe58:
	.size	 SP_misc_ctf_banner,.Lfe58-SP_misc_ctf_banner
	.section	".rodata"
	.align 3
.LC285:
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
	lis 3,.LC231@ha
	stw 0,260(31)
	la 30,gi@l(9)
	la 3,.LC231@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,284(31)
	stw 3,40(31)
	andi. 9,0,1
	bc 12,2,.L827
	li 0,1
	stw 0,60(31)
.L827:
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
	lis 11,.LC285@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC285@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe59:
	.size	 SP_misc_ctf_small_banner,.Lfe59-SP_misc_ctf_small_banner
	.section	".rodata"
	.align 2
.LC286:
	.long 0x41800000
	.section	".text"
	.align 2
	.globl SP_info_teleport_destination
	.type	 SP_info_teleport_destination,@function
SP_info_teleport_destination:
	lis 9,.LC286@ha
	lfs 0,12(3)
	la 9,.LC286@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,12(3)
	blr
.Lfe60:
	.size	 SP_info_teleport_destination,.Lfe60-SP_info_teleport_destination
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
.Lfe61:
	.size	 CTFOtherTeam,.Lfe61-CTFOtherTeam
	.section	".rodata"
	.align 2
.LC287:
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
	bc 4,2,.L286
	lis 9,level+4@ha
	lfs 0,428(3)
	lis 11,.LC287@ha
	lfs 13,level+4@l(9)
	la 11,.LC287@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,1,.L285
.L286:
	bl Touch_Item
.L285:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe62:
	.size	 CTFDropFlagTouch,.Lfe62-CTFDropFlagTouch
	.section	".rodata"
	.align 3
.LC288:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl CTFFlagThink
	.type	 CTFFlagThink,@function
CTFFlagThink:
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 12,2,.L356
	lwz 9,56(3)
	addi 9,9,-172
	srawi 0,9,31
	srwi 0,0,28
	add 0,9,0
	rlwinm 0,0,0,0,27
	subf 9,0,9
	addi 9,9,173
	stw 9,56(3)
.L356:
	lis 9,level+4@ha
	lis 11,.LC288@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC288@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe63:
	.size	 CTFFlagThink,.Lfe63-CTFFlagThink
	.section	".rodata"
	.align 3
.LC289:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC290:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC291:
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
	lis 11,.LC289@ha
	stw 0,72(1)
	la 11,.LC289@l(11)
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
	lis 3,.LC122@ha
	la 29,gi@l(29)
	stw 0,252(31)
	la 3,.LC122@l(3)
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
	stw 31,3912(9)
	lwz 11,84(27)
	stw 0,3916(11)
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
	lis 9,.LC290@ha
	la 9,.LC290@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L507
	lis 11,.LC291@ha
	mr 3,24
	la 11,.LC291@l(11)
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
.L507:
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
.LC292:
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
	lis 9,.LC292@ha
	lfs 13,3936(11)
	la 9,.LC292@l(9)
	lfs 12,0(9)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L570
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 4,2,.L571
	lis 9,gi+12@ha
	lis 4,.LC145@ha
	lwz 0,gi+12@l(9)
	la 4,.LC145@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L571:
	lfs 0,4(30)
	lwz 9,84(31)
	stfs 0,3936(9)
.L570:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe66:
	.size	 CTFHasTech,.Lfe66-CTFHasTech
	.section	".rodata"
	.align 2
.LC293:
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
	bc 12,2,.L597
	lis 28,.LC148@ha
.L596:
	mr 3,30
	li 4,280
	la 5,.LC148@l(28)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L596
.L597:
	cmpwi 0,30,0
	bc 4,2,.L938
	lis 5,.LC148@ha
	li 3,0
	la 5,.LC148@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 12,2,.L593
.L938:
	lwz 3,648(29)
	mr 4,30
	bl SpawnTech
	mr 3,29
	bl RemoveFromItemList
	mr 3,29
	bl G_FreeEdict
	b .L600
.L593:
	lis 9,.LC293@ha
	lis 11,level+4@ha
	la 9,.LC293@l(9)
	lfs 0,level+4@l(11)
	lfs 13,0(9)
	lis 9,TechThink@ha
	la 9,TechThink@l(9)
	fadds 0,0,13
	stw 9,436(29)
	stfs 0,428(29)
.L600:
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
	bc 12,2,.L618
	mr 26,9
	lis 25,.LC148@ha
.L619:
	slwi 0,31,2
	addi 27,31,1
	lwzx 3,26,0
	bl FindItemByClassname
	mr. 28,3
	bc 12,2,.L620
	bl rand
	li 30,0
	srawi 0,3,31
	srwi 0,0,28
	add 0,3,0
	rlwinm 0,0,0,0,27
	subf 31,0,3
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L624
	lis 29,.LC148@ha
.L623:
	mr 3,30
	li 4,280
	la 5,.LC148@l(29)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L623
.L624:
	cmpwi 0,30,0
	bc 4,2,.L939
	li 3,0
	li 4,280
	la 5,.LC148@l(25)
	bl G_Find
	mr. 30,3
	bc 12,2,.L620
.L939:
	mr 3,28
	mr 4,30
	bl SpawnTech
.L620:
	mr 31,27
	slwi 0,31,2
	lwzx 9,26,0
	cmpwi 0,9,0
	bc 4,2,.L619
.L618:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe68:
	.size	 SpawnTechs,.Lfe68-SpawnTechs
	.section	".rodata"
	.align 3
.LC294:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.type	 misc_ctf_banner_think,@function
misc_ctf_banner_think:
	lwz 9,56(3)
	lis 10,level+4@ha
	lis 11,.LC294@ha
	lfd 13,.LC294@l(11)
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
.Lfe70:
	.size	 CTFJoinTeam1,.Lfe70-CTFJoinTeam1
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
.Lfe71:
	.size	 CTFJoinTeam2,.Lfe71-CTFJoinTeam2
	.section	".rodata"
	.align 3
.LC295:
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
	lwz 0,3940(9)
	cmpwi 0,0,0
	bc 12,2,.L844
	li 0,0
	stw 0,3940(9)
	bl PMenu_Close
	b .L843
.L844:
	li 8,1
	b .L845
.L847:
	addi 8,8,1
.L845:
	xoris 0,8,0x8000
	lis 9,0x4330
	stw 0,20(1)
	lis 11,.LC295@ha
	la 11,.LC295@l(11)
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
	bc 4,3,.L843
	lis 9,g_edicts@ha
	mulli 11,8,1332
	lwz 0,g_edicts@l(9)
	add 11,0,11
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L847
	lwz 0,248(11)
	cmpwi 0,0,0
	bc 12,2,.L847
	lwz 9,84(31)
	mr 3,31
	stw 11,3940(9)
	bl PMenu_Close
	lwz 9,84(31)
	li 0,1
	stw 0,3944(9)
.L843:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe72:
	.size	 CTFChaseCam,.Lfe72-CTFChaseCam
	.section	".rodata"
	.align 2
.LC296:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFReturnToMain
	.type	 CTFReturnToMain,@function
CTFReturnToMain:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl PMenu_Close
	mr 3,31
	bl CTFOpenJoinMenu
	lis 9,.LC296@ha
	lis 11,ctf@ha
	la 9,.LC296@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L852
	mr 3,31
	bl niq_updatescreen
.L852:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe73:
	.size	 CTFReturnToMain,.Lfe73-CTFReturnToMain
	.section	".rodata"
	.align 2
.LC297:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFCredits
	.type	 CTFCredits,@function
CTFCredits:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl PMenu_Close
	lis 4,creditsmenu@ha
	mr 3,31
	la 4,creditsmenu@l(4)
	li 5,-1
	li 6,18
	bl PMenu_Open
	lis 9,.LC297@ha
	lis 11,ctf@ha
	la 9,.LC297@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L890
	mr 3,31
	bl niq_updatescreen
.L890:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe74:
	.size	 CTFCredits,.Lfe74-CTFCredits
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
	stw 0,3568(11)
	lwz 9,84(29)
	stw 10,3580(9)
	bl DeathmatchScoreboard
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe75:
	.size	 CTFShowScores,.Lfe75-CTFShowScores
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
