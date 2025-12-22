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
	.ascii	"150 \tpic 2 endif if 4 \txv\t174 \tnum 2 4 endif if 6 \txv\t"
	.ascii	"288 \tpic 6 endif yb\t-50 \txv\t4 if 11 \tyt\t12 \txl\t48 \t"
	.ascii	"pic\t11 endif if 20 \tyt\t44 \txl\t48 \tpic\t20 endif if 21 "
	.ascii	"\tyt\t76 \txl\t48 \tpic\t21 endif if 22 \tyt\t108 \txl\t48 \t"
	.ascii	"pic\t22 endif if 23 \tyt\t140 \txl\t48 \tpic\t23 endif if 24"
	.ascii	" \tyt\t172 \txl\t48 \tpic\t24 endif \txl\t0 if 16 \tyb\t-50 "
	.ascii	"\tpic 16 endif if 17 \tyb\t-74 \tpic 17 endif if 18 \tyb\t-9"
	.ascii	"8 \tpic 18 endif if 19 \tyb\t-122 \tpic 19 endif if 7 \txv\t"
	.ascii	"0 \tyv\t0 \tpic\t7 endif if 25 xv 0 yb -58 string \"Viewing\""
	.ascii	" xv 64 stat_string 25 endif if 8 \tyb\t-50 \txr\t-24 \tpic 8"
	.ascii	" endif if 9 \txr\t-72 \tnum"
	.string	" 3 9endif xr\t-50 yt 2 num 3 14 yb -129 if 26 xr -26 pic 26 endif yb -102 if 26 xr -26 pic 26 endif xr -62 num 2 27 yb -75 if 28 xr -26 pic 28 endif xr -62 num 2 29 if 5 yt 26 xr -24 pic 5 endif if 27 xv 0 yb -58 string \"Viewing\" xv 64 stat_string 27 endif "
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
	.align 2
.LC5:
	.string	"%s"
	.align 2
.LC6:
	.string	"%d"
	.align 2
.LC7:
	.string	"%f"
	.section	".text"
	.align 2
	.globl _stuffcmd
	.type	 _stuffcmd,@function
_stuffcmd:
	stwu 1,-288(1)
	mflr 0
	stmw 26,264(1)
	stw 0,292(1)
	lis 29,0x200
	addi 0,1,296
	stw 5,16(1)
	addi 11,1,8
	stw 0,244(1)
	mr 26,3
	stw 11,248(1)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	stw 29,240(1)
	bc 4,6,.L8
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L8:
	addi 9,1,240
	addi 10,1,224
	lwz 0,8(9)
	li 31,0
	mr 27,4
	lwz 11,4(9)
	mr 28,31
	addi 30,1,112
	stw 29,224(1)
	stw 0,8(10)
	stw 11,4(10)
	lbzx 0,27,31
	cmpwi 0,0,0
	bc 12,2,.L10
	mr 29,27
.L12:
	lbz 0,0(29)
	cmpwi 0,0,37
	bc 4,2,.L13
	lbz 0,1(29)
	cmpwi 0,0,115
	bc 4,2,.L14
	lbz 11,224(1)
	add 3,30,31
	cmplwi 0,11,7
	bc 12,1,.L31
	addi 9,11,1
	lwz 0,232(1)
	slwi 11,11,2
	stb 9,224(1)
	add 5,0,11
	b .L20
.L31:
	lwz 5,228(1)
	addi 0,5,4
	stw 0,228(1)
.L20:
	lwz 5,0(5)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	crxor 6,6,6
	bl sprintf
	b .L77
.L14:
	cmpwi 0,0,100
	bc 4,2,.L35
	lbz 11,224(1)
	add 3,30,31
	cmplwi 0,11,7
	bc 12,1,.L52
	addi 9,11,1
	lwz 0,232(1)
	slwi 11,11,2
	stb 9,224(1)
	add 5,0,11
	b .L41
.L52:
	lwz 5,228(1)
	addi 0,5,4
	stw 0,228(1)
.L41:
	lwz 5,0(5)
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	crxor 6,6,6
	bl sprintf
	b .L77
.L35:
	cmpwi 0,0,102
	bc 4,2,.L34
	lbz 10,225(1)
	add 3,30,31
	cmplwi 0,10,7
	bc 12,1,.L58
	slwi 9,10,3
	lwz 11,232(1)
	addi 0,10,1
	addi 9,9,32
	stb 0,225(1)
	add 9,11,9
	b .L62
.L58:
	lwz 9,228(1)
	addi 9,9,7
	rlwinm 9,9,0,0,28
	addi 0,9,8
	stw 0,228(1)
.L62:
	lfd 1,0(9)
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	creqv 6,6,6
	bl sprintf
.L77:
	add 31,31,3
.L34:
	addi 29,29,1
	addi 28,28,1
	b .L11
.L13:
	stbx 0,30,31
	addi 31,31,1
.L11:
	lbzu 0,1(29)
	addi 28,28,1
	cmpwi 0,0,0
	bc 4,2,.L12
.L10:
	lis 29,gi@ha
	li 3,11
	lbzx 0,27,28
	la 29,gi@l(29)
	lwz 11,100(29)
	stbx 0,30,31
	mtlr 11
	blrl
	lwz 9,116(29)
	mr 3,30
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,26
	li 4,1
	mtlr 0
	blrl
	lwz 0,292(1)
	mtlr 0
	lmw 26,264(1)
	la 1,288(1)
	blr
.Lfe1:
	.size	 _stuffcmd,.Lfe1-_stuffcmd
	.section	".rodata"
	.align 3
.LC8:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC9:
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
	bc 4,2,.L95
	b .L105
.L104:
	li 3,1
	b .L103
.L95:
	mr 10,3
	lfs 12,188(3)
	addi 11,3,188
	lfsu 9,4(10)
	addi 8,3,200
	lis 9,.LC8@ha
	lfs 7,200(3)
	la 9,.LC8@l(9)
	lfd 6,0(9)
	lis 6,0x4330
	addi 28,1,168
	fadds 8,9,12
	lis 9,gi@ha
	lis 27,vec3_origin@ha
	fadds 9,9,7
	la 26,gi@l(9)
	addi 31,1,72
	lis 9,.LC9@ha
	addi 29,1,156
	stfs 8,72(1)
	fsubs 12,8,12
	la 9,.LC9@l(9)
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
.L100:
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
	bc 12,2,.L104
	addi 31,31,12
	cmpw 0,31,29
	bc 4,1,.L100
.L105:
	li 3,0
.L103:
	lwz 0,228(1)
	mtlr 0
	lmw 26,192(1)
	lfd 31,216(1)
	la 1,224(1)
	blr
.Lfe2:
	.size	 loc_CanSee,.Lfe2-loc_CanSee
	.section	".rodata"
	.align 2
.LC10:
	.string	"Initialising CTF\n"
	.align 2
.LC11:
	.string	"ctf_forcejoin"
	.align 2
.LC12:
	.string	""
	.align 2
.LC13:
	.string	"item_flag_team1"
	.align 2
.LC14:
	.string	"item_flag_team2"
	.align 2
.LC15:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFInit
	.type	 CTFInit,@function
CTFInit:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,.LC15@ha
	lis 11,ctf@ha
	la 9,.LC15@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L106
	lis 29,gi@ha
	lis 3,.LC10@ha
	la 29,gi@l(29)
	la 3,.LC10@l(3)
	lwz 9,4(29)
	lis 31,flag1_item@ha
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,144(29)
	lis 3,.LC11@ha
	lis 4,.LC12@ha
	la 3,.LC11@l(3)
	la 4,.LC12@l(4)
	mtlr 0
	li 5,0
	blrl
	lwz 0,flag1_item@l(31)
	lis 9,ctf_forcejoin@ha
	stw 3,ctf_forcejoin@l(9)
	cmpwi 0,0,0
	bc 4,2,.L108
	lis 3,.LC13@ha
	la 3,.LC13@l(3)
	bl FindItemByClassname
	stw 3,flag1_item@l(31)
.L108:
	lis 29,flag2_item@ha
	lwz 0,flag2_item@l(29)
	cmpwi 0,0,0
	bc 4,2,.L109
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	bl FindItemByClassname
	stw 3,flag2_item@l(29)
.L109:
	lis 3,ctfgame@ha
	li 4,0
	la 3,ctfgame@l(3)
	li 5,24
	crxor 6,6,6
	bl memset
	lis 9,techspawn@ha
	li 0,0
	stw 0,techspawn@l(9)
.L106:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 CTFInit,.Lfe3-CTFInit
	.section	".rodata"
	.align 2
.LC16:
	.string	"RED"
	.align 2
.LC17:
	.string	"BLUE"
	.align 2
.LC18:
	.string	"UKNOWN"
	.align 2
.LC19:
	.string	"male/"
	.align 2
.LC20:
	.string	"%s\\%s%s"
	.align 2
.LC21:
	.string	"ep1ob1"
	.align 2
.LC22:
	.string	"ep1maul"
	.align 2
.LC23:
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
	lis 0,0x6205
	mr 30,4
	ori 0,0,46533
	lis 5,.LC5@ha
	subf 9,9,29
	addi 3,1,8
	mullw 9,9,0
	la 5,.LC5@l(5)
	li 4,64
	mr 6,30
	srawi 9,9,2
	addi 31,9,-1
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,8
	li 4,47
	bl strrchr
	mr. 3,3
	bc 12,2,.L129
	li 0,0
	stb 0,1(3)
	b .L130
.L129:
	lis 9,.LC19@ha
	la 11,.LC19@l(9)
	lwz 0,.LC19@l(9)
	lhz 10,4(11)
	stw 0,8(1)
	sth 10,12(1)
.L130:
	lwz 9,84(29)
	lwz 3,4048(9)
	mr 4,9
	cmpwi 0,3,1
	bc 12,2,.L132
	cmpwi 0,3,2
	bc 12,2,.L133
	b .L134
.L132:
	lis 29,gi@ha
	lis 3,.LC20@ha
	lis 6,.LC21@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC20@l(3)
	la 6,.LC21@l(6)
	b .L136
.L133:
	lis 29,gi@ha
	lis 3,.LC20@ha
	lis 6,.LC22@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC20@l(3)
	la 6,.LC22@l(6)
.L136:
	addi 5,1,8
	crxor 6,6,6
	bl va
	lwz 9,24(29)
	addi 0,31,1312
	mr 4,3
	mr 3,0
	mtlr 9
	blrl
	b .L131
.L134:
	lis 29,gi@ha
	lis 3,.LC23@ha
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC23@l(3)
	mr 5,30
	crxor 6,6,6
	bl va
	lwz 9,24(29)
	addi 0,31,1312
	mr 4,3
	mr 3,0
	mtlr 9
	blrl
.L131:
	lwz 0,100(1)
	mtlr 0
	lmw 29,84(1)
	la 1,96(1)
	blr
.Lfe4:
	.size	 CTFAssignSkin,.Lfe4-CTFAssignSkin
	.section	".rodata"
	.align 2
.LC24:
	.long 0x0
	.align 2
.LC25:
	.long 0x3f800000
	.align 3
.LC26:
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
	lis 11,.LC24@ha
	lis 9,ctf@ha
	la 11,.LC24@l(11)
	mr 31,3
	lfs 13,0(11)
	li 8,0
	li 7,0
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L137
	lis 10,dmflags@ha
	stw 8,4052(31)
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 0,11,2
	bc 4,2,.L139
	stw 7,4048(31)
	b .L137
.L139:
	lis 11,.LC25@ha
	lis 9,maxclients@ha
	la 11,.LC25@l(11)
	li 10,1
	lfs 0,0(11)
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L152
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC26@ha
	la 9,.LC26@l(9)
	addi 11,11,1076
	lfd 13,0(9)
.L143:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L142
	lwz 9,84(11)
	cmpw 0,9,31
	bc 12,2,.L142
	lwz 0,4048(9)
	cmpwi 0,0,1
	bc 12,2,.L147
	cmpwi 0,0,2
	bc 12,2,.L148
	b .L142
.L147:
	addi 8,8,1
	b .L142
.L148:
	addi 7,7,1
.L142:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,1076
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L143
.L152:
	cmpw 0,7,8
	bc 12,0,.L156
	bl rand
	andi. 0,3,1
	li 0,1
	bc 4,2,.L158
.L156:
	li 0,2
.L158:
	stw 0,4048(31)
.L137:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 CTFAssignTeam,.Lfe5-CTFAssignTeam
	.section	".rodata"
	.align 2
.LC27:
	.string	"info_player_team1"
	.align 2
.LC28:
	.string	"info_player_team2"
	.align 2
.LC29:
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
	lwz 0,4052(9)
	cmpwi 0,0,0
	bc 12,2,.L160
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,512
	bc 12,2,.L184
	bl SelectFarthestDeathmatchSpawnPoint
	b .L183
.L160:
	li 0,1
	stw 0,4052(9)
	lwz 9,84(3)
	lwz 3,4048(9)
	cmpwi 0,3,1
	bc 12,2,.L164
	cmpwi 0,3,2
	bc 12,2,.L165
	b .L184
.L164:
	lis 9,.LC27@ha
	la 27,.LC27@l(9)
	b .L163
.L165:
	lis 9,.LC28@ha
	la 27,.LC28@l(9)
.L163:
	lis 9,.LC29@ha
	li 30,0
	lfs 31,.LC29@l(9)
	li 28,0
	li 29,0
	fmr 30,31
	b .L168
.L170:
	mr 3,30
	addi 31,31,1
	bl PlayersRangeFromSpot
	fcmpu 0,1,30
	bc 4,0,.L171
	fmr 30,1
	mr 29,30
	b .L168
.L171:
	fcmpu 0,1,31
	bc 4,0,.L168
	fmr 31,1
	mr 28,30
.L168:
	mr 3,30
	li 4,280
	mr 5,27
	bl G_Find
	mr. 30,3
	bc 4,2,.L170
	cmpwi 0,31,0
	bc 4,2,.L175
.L184:
	bl SelectRandomDeathmatchSpawnPoint
	b .L183
.L175:
	cmpwi 0,31,2
	bc 12,1,.L176
	li 28,0
	li 29,0
	b .L177
.L176:
	addi 31,31,-2
.L177:
	bl rand
	li 30,0
	divw 0,3,31
	mullw 0,0,31
	subf 31,0,3
.L182:
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
	bc 4,2,.L182
.L183:
	lwz 0,68(1)
	mtlr 0
	lmw 27,28(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 SelectCTFSpawnPoint,.Lfe6-SelectCTFSpawnPoint
	.section	".rodata"
	.align 2
.LC30:
	.string	"BONUS: %d points for fragging enemy flag carrier.\n"
	.align 2
.LC31:
	.string	"%s defends %s's flag carrier against an agressive enemy\n"
	.align 2
.LC32:
	.string	"%s defends the %s base.\n"
	.align 2
.LC33:
	.string	"%s defends the %s flag.\n"
	.align 2
.LC34:
	.string	"%s defends the %s's flag carrier.\n"
	.align 2
.LC35:
	.long 0x0
	.align 2
.LC36:
	.long 0x3f800000
	.align 3
.LC37:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC38:
	.long 0x41000000
	.align 2
.LC39:
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
	lis 10,.LC35@ha
	lwz 11,ctf@l(9)
	la 10,.LC35@l(10)
	mr 27,3
	lfs 13,0(10)
	mr 29,5
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L185
	lwz 0,84(27)
	cmpwi 0,0,0
	mr 8,0
	bc 12,2,.L185
	lwz 0,84(29)
	xor 9,27,29
	subfic 11,9,0
	adde 9,11,9
	mr 7,0
	subfic 10,0,0
	adde 0,10,0
	or. 11,0,9
	bc 4,2,.L185
	lwz 0,4048(8)
	cmpwi 0,0,1
	bc 12,2,.L189
	cmpwi 0,0,2
	bc 12,2,.L190
	b .L193
.L189:
	li 30,2
	b .L192
.L190:
	li 30,1
	b .L192
.L193:
	li 30,-1
.L192:
	cmpwi 0,30,0
	bc 12,0,.L185
	lwz 0,4048(8)
	cmpwi 0,0,1
	bc 4,2,.L195
	lis 9,flag1_item@ha
	lis 11,flag2_item@ha
	lwz 26,flag1_item@l(9)
	lwz 0,flag2_item@l(11)
	b .L196
.L195:
	lis 9,flag2_item@ha
	lis 11,flag1_item@ha
	lwz 26,flag2_item@l(9)
	lwz 0,flag1_item@l(11)
.L196:
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
	bc 12,2,.L197
	lis 9,level+4@ha
	lis 5,.LC30@ha
	lfs 0,level+4@l(9)
	mr 3,29
	la 5,.LC30@l(5)
	li 4,1
	li 6,2
	stfs 0,4068(7)
	lwz 11,84(29)
	lwz 9,4032(11)
	addi 9,9,2
	stw 9,4032(11)
	crxor 6,6,6
	bl safe_cprintf
	lis 9,maxclients@ha
	lis 10,.LC36@ha
	lwz 11,maxclients@l(9)
	la 10,.LC36@l(10)
	lfs 13,0(10)
	lfs 0,20(11)
	li 10,1
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L185
	lis 9,g_edicts@ha
	mr 8,11
	lwz 11,g_edicts@l(9)
	li 6,0
	lis 7,0x4330
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	addi 11,11,1076
	lfd 12,0(9)
.L201:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L200
	lwz 9,84(11)
	lwz 0,4048(9)
	cmpw 0,0,30
	bc 4,2,.L200
	stw 6,4056(9)
.L200:
	addi 10,10,1
	lfs 13,20(8)
	xoris 0,10,0x8000
	addi 11,11,1076
	stw 0,44(1)
	stw 7,40(1)
	lfd 0,40(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L201
	b .L185
.L197:
	lis 11,.LC35@ha
	lfs 12,4056(8)
	la 11,.LC35@l(11)
	lfs 0,0(11)
	fcmpu 0,12,0
	bc 12,2,.L204
	lis 9,level+4@ha
	lis 11,.LC38@ha
	lfs 0,level+4@l(9)
	la 11,.LC38@l(11)
	lfs 13,0(11)
	fsubs 0,0,12
	fcmpu 0,0,13
	bc 4,0,.L204
	subf 0,6,26
	addi 11,7,740
	mullw 0,0,10
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L204
	lwz 9,4032(7)
	addi 9,9,2
	stw 9,4032(7)
	lwz 11,84(29)
	lwz 0,4048(11)
	addi 5,11,700
	cmpwi 0,0,1
	bc 12,2,.L205
	cmpwi 0,0,2
	bc 12,2,.L206
	b .L209
.L205:
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
	b .L208
.L206:
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L208
.L209:
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
.L208:
	lis 4,.LC31@ha
	li 3,1
	la 4,.LC31@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L185
.L204:
	lwz 0,4048(7)
	cmpwi 0,0,1
	bc 12,2,.L211
	cmpwi 0,0,2
	bc 12,2,.L212
	b .L185
.L211:
	lis 9,.LC13@ha
	la 28,.LC13@l(9)
	b .L210
.L212:
	lis 9,.LC14@ha
	la 28,.LC14@l(9)
.L210:
	li 30,0
.L218:
	mr 3,30
	li 4,280
	mr 5,28
	bl G_Find
	mr. 30,3
	mcrf 7,0
	bc 12,30,.L185
	lwz 0,284(30)
	andis. 9,0,1
	bc 4,2,.L218
	bc 12,30,.L185
	lis 9,maxclients@ha
	lis 10,.LC36@ha
	lfs 11,4(27)
	lwz 11,maxclients@l(9)
	la 10,.LC36@l(10)
	lfs 0,0(10)
	lfs 13,20(11)
	li 10,1
	lfs 10,4(30)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L221
	lis 11,g_edicts@ha
	lis 9,itemlist@ha
	fmr 12,13
	lis 0,0x286b
	la 9,itemlist@l(9)
	lwz 7,g_edicts@l(11)
	ori 0,0,51739
	subf 9,9,26
	lis 11,.LC37@ha
	mullw 9,9,0
	lis 6,0x4330
	la 11,.LC37@l(11)
	lfd 13,0(11)
	rlwinm 8,9,0,0,29
	li 11,1076
.L223:
	add 31,7,11
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L224
	lwz 9,84(31)
	addi 9,9,740
	lwzx 0,9,8
	cmpwi 0,0,0
	bc 4,2,.L221
.L224:
	addi 10,10,1
	xoris 0,10,0x8000
	li 31,0
	stw 0,44(1)
	addi 11,11,1076
	stw 6,40(1)
	lfd 0,40(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L223
.L221:
	fsubs 10,11,10
	lfs 13,8(27)
	lis 9,.LC39@ha
	addi 3,1,8
	lfs 12,12(27)
	la 9,.LC39@l(9)
	lfs 11,4(29)
	stfs 10,8(1)
	lfs 0,8(30)
	lfs 10,8(29)
	lfs 9,12(29)
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
	bc 12,0,.L227
	addi 28,1,24
	mr 3,28
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L227
	mr 3,30
	mr 4,27
	bl loc_CanSee
	cmpwi 0,3,0
	bc 4,2,.L227
	mr 3,30
	mr 4,29
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L226
.L227:
	lwz 9,84(29)
	lwz 11,4032(9)
	addi 11,11,1
	stw 11,4032(9)
	lwz 0,248(30)
	cmpwi 0,0,0
	bc 4,2,.L228
	lwz 9,84(29)
	lwz 0,4048(9)
	addi 5,9,700
	cmpwi 0,0,1
	bc 12,2,.L229
	cmpwi 0,0,2
	bc 12,2,.L230
	b .L233
.L229:
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
	b .L232
.L230:
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L232
.L233:
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
.L232:
	lis 4,.LC32@ha
	li 3,1
	la 4,.LC32@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L185
.L228:
	lwz 9,84(29)
	lwz 0,4048(9)
	addi 5,9,700
	cmpwi 0,0,1
	bc 12,2,.L235
	cmpwi 0,0,2
	bc 12,2,.L236
	b .L239
.L235:
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
	b .L238
.L236:
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L238
.L239:
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
.L238:
	lis 4,.LC33@ha
	li 3,1
	la 4,.LC33@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L185
.L226:
	xor 0,31,29
	addic 9,31,-1
	subfe 11,9,31
	addic 10,0,-1
	subfe 9,10,0
	and. 0,11,9
	bc 12,2,.L185
	lfs 13,4(31)
	addi 3,1,8
	lfs 0,4(27)
	lfs 12,8(27)
	lfs 11,12(27)
	fsubs 0,0,13
	lfs 10,4(29)
	lfs 9,8(29)
	stfs 0,8(1)
	lfs 13,8(31)
	lfs 8,12(29)
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
	bc 12,0,.L242
	mr 3,28
	bl VectorLength
	fcmpu 0,1,31
	bc 12,0,.L242
	mr 4,27
	mr 3,31
	bl loc_CanSee
	cmpwi 0,3,0
	bc 4,2,.L242
	mr 3,31
	mr 4,29
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L185
.L242:
	lwz 9,84(29)
	lwz 11,4032(9)
	addi 11,11,1
	stw 11,4032(9)
	lwz 10,84(29)
	lwz 0,4048(10)
	addi 5,10,700
	cmpwi 0,0,1
	bc 12,2,.L243
	cmpwi 0,0,2
	bc 12,2,.L244
	b .L247
.L243:
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
	b .L246
.L244:
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L246
.L247:
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
.L246:
	lis 4,.LC34@ha
	li 3,1
	la 4,.LC34@l(4)
	crxor 6,6,6
	bl safe_bprintf
.L185:
	lwz 0,84(1)
	mtlr 0
	lmw 26,48(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe7:
	.size	 CTFFragBonuses,.Lfe7-CTFFragBonuses
	.section	".rodata"
	.align 2
.LC40:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFResetFlags
	.type	 CTFResetFlags,@function
CTFResetFlags:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,.LC40@ha
	lis 11,ctf@ha
	la 9,.LC40@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L270
	lis 9,.LC13@ha
	lis 11,gi@ha
	la 28,.LC13@l(9)
	la 29,gi@l(11)
	li 31,0
	li 30,1
	b .L275
.L277:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L278
	mr 3,31
	bl G_FreeEdict
	b .L275
.L278:
	lwz 0,184(31)
	mr 3,31
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(29)
	mtlr 9
	blrl
	stw 30,80(31)
.L275:
	mr 3,31
	li 4,280
	mr 5,28
	bl G_Find
	mr. 31,3
	bc 4,2,.L277
.L270:
	lis 9,.LC40@ha
	lis 11,ctf@ha
	la 9,.LC40@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L282
	lis 9,.LC14@ha
	lis 11,gi@ha
	la 28,.LC14@l(9)
	la 29,gi@l(11)
	li 31,0
	li 30,1
	b .L287
.L289:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L290
	mr 3,31
	bl G_FreeEdict
	b .L287
.L290:
	lwz 0,184(31)
	mr 3,31
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(29)
	mtlr 9
	blrl
	stw 30,80(31)
.L287:
	mr 3,31
	li 4,280
	mr 5,28
	bl G_Find
	mr. 31,3
	bc 4,2,.L289
.L282:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 CTFResetFlags,.Lfe8-CTFResetFlags
	.section	".rodata"
	.align 2
.LC41:
	.string	"Don't know what team the flag is on.\n"
	.align 2
.LC42:
	.string	"%s captured the %s flag!\n"
	.align 2
.LC43:
	.string	"ctf/jawacapt.wav"
	.align 2
.LC44:
	.string	"ctf/ewokcapt.wav"
	.align 2
.LC45:
	.string	"%s gets an assist for returning the flag!\n"
	.align 2
.LC46:
	.string	"%s gets an assist for fragging the flag carrier!\n"
	.align 2
.LC47:
	.string	"%s returned the %s flag!\n"
	.align 2
.LC48:
	.string	"ctf/jawartrn.wav"
	.align 2
.LC49:
	.string	"ctf/ewokrtrn.wav"
	.align 2
.LC50:
	.string	"%s got the %s flag!\n"
	.align 2
.LC51:
	.long 0x3f800000
	.align 2
.LC52:
	.long 0x0
	.align 3
.LC53:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC54:
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
	lis 4,.LC13@ha
	la 4,.LC13@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L294
	li 28,1
	b .L295
.L294:
	lwz 3,280(31)
	lis 4,.LC14@ha
	la 4,.LC14@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L296
	lis 5,.LC41@ha
	mr 3,31
	la 5,.LC41@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L352:
	li 3,0
	b .L349
.L296:
	li 28,2
.L295:
	cmpwi 4,28,1
	bc 4,18,.L298
	lis 9,flag1_item@ha
	lis 11,flag2_item@ha
	lwz 27,flag1_item@l(9)
	lwz 29,flag2_item@l(11)
	b .L299
.L298:
	lis 9,flag2_item@ha
	lis 11,flag1_item@ha
	lwz 27,flag2_item@l(9)
	lwz 29,flag1_item@l(11)
.L299:
	lwz 5,84(30)
	lwz 0,4048(5)
	cmpw 0,28,0
	bc 4,2,.L300
	lwz 0,284(31)
	andis. 9,0,1
	bc 4,2,.L301
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
	bc 12,2,.L352
	addi 5,5,700
	bc 12,18,.L303
	cmpwi 0,28,2
	bc 12,2,.L304
	b .L307
.L303:
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L306
.L304:
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
	b .L306
.L307:
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
.L306:
	lis 4,.LC42@ha
	li 3,2
	la 4,.LC42@l(4)
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
	bc 4,18,.L308
	lwz 9,ctfgame@l(6)
	addi 9,9,1
	stw 9,ctfgame@l(6)
	b .L309
.L308:
	lwz 9,4(7)
	addi 9,9,1
	stw 9,4(7)
.L309:
	bc 4,18,.L310
	lis 29,gi@ha
	lis 3,.LC43@ha
	la 29,gi@l(29)
	la 3,.LC43@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC51@ha
	lwz 0,16(29)
	lis 10,.LC52@ha
	la 9,.LC51@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC52@l(10)
	li 4,26
	mtlr 0
	lis 9,.LC52@ha
	mr 3,31
	lfs 2,0(10)
	la 9,.LC52@l(9)
	lfs 3,0(9)
	blrl
	b .L311
.L310:
	lis 29,gi@ha
	lis 3,.LC44@ha
	la 29,gi@l(29)
	la 3,.LC44@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC51@ha
	lwz 0,16(29)
	lis 10,.LC52@ha
	la 9,.LC51@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC52@l(10)
	li 4,26
	mtlr 0
	lis 9,.LC52@ha
	mr 3,31
	lfs 2,0(10)
	la 9,.LC52@l(9)
	lfs 3,0(9)
	blrl
.L311:
	lis 10,.LC51@ha
	lwz 11,84(30)
	lis 9,maxclients@ha
	la 10,.LC51@l(10)
	li 27,1
	lfs 13,0(10)
	lis 21,maxclients@ha
	lwz 10,maxclients@l(9)
	lwz 9,4032(11)
	addi 9,9,15
	stw 9,4032(11)
	lfs 0,20(10)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L313
	lis 9,.LC53@ha
	lis 22,g_edicts@ha
	la 9,.LC53@l(9)
	lis 23,0xc0a0
	lfd 30,0(9)
	lis 24,0x4330
	li 28,1076
	lis 25,.LC45@ha
	lis 26,.LC46@ha
.L315:
	lwz 0,g_edicts@l(22)
	add 29,0,28
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L314
	lwz 10,84(29)
	lwz 9,84(30)
	lwz 11,4048(10)
	lwz 0,4048(9)
	cmpw 0,11,0
	bc 12,2,.L350
	stw 23,4056(10)
	b .L314
.L350:
	cmpw 0,29,30
	bc 12,2,.L320
	lwz 9,4032(10)
	addi 9,9,10
	stw 9,4032(10)
.L320:
	lwz 5,84(29)
	lis 10,.LC54@ha
	la 31,level@l(20)
	la 10,.LC54@l(10)
	lfs 13,4(31)
	lfs 31,0(10)
	lfs 0,4060(5)
	fadds 0,0,31
	fcmpu 0,0,13
	bc 4,1,.L321
	addi 5,5,700
	li 3,2
	la 4,.LC45@l(25)
	crxor 6,6,6
	bl safe_bprintf
	lwz 11,84(29)
	lwz 9,4032(11)
	addi 9,9,1
	stw 9,4032(11)
.L321:
	lwz 5,84(29)
	lfs 13,4(31)
	lfs 0,4068(5)
	fadds 0,0,31
	fcmpu 0,0,13
	bc 4,1,.L314
	addi 5,5,700
	li 3,2
	la 4,.LC46@l(26)
	crxor 6,6,6
	bl safe_bprintf
	lwz 11,84(29)
	lwz 9,4032(11)
	addi 9,9,2
	stw 9,4032(11)
.L314:
	addi 27,27,1
	lwz 11,maxclients@l(21)
	xoris 0,27,0x8000
	addi 28,28,1076
	stw 0,20(1)
	stw 24,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L315
.L313:
	bl CTFResetFlags
	b .L352
.L301:
	addi 5,5,700
	bc 12,18,.L324
	cmpwi 0,28,2
	bc 12,2,.L325
	b .L328
.L324:
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
	b .L327
.L325:
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L327
.L328:
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
.L327:
	lis 4,.LC47@ha
	li 3,2
	la 4,.LC47@l(4)
	crxor 6,6,6
	bl safe_bprintf
	lwz 10,84(30)
	lis 8,level+4@ha
	lwz 9,4032(10)
	addi 9,9,1
	stw 9,4032(10)
	lfs 0,level+4@l(8)
	lwz 11,84(30)
	stfs 0,4060(11)
	bc 4,18,.L329
	lis 29,gi@ha
	lis 3,.LC48@ha
	la 29,gi@l(29)
	la 3,.LC48@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC51@ha
	lwz 0,16(29)
	lis 10,.LC52@ha
	la 9,.LC51@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC52@l(10)
	li 4,26
	mtlr 0
	lis 9,.LC52@ha
	mr 3,31
	lfs 2,0(10)
	la 9,.LC52@l(9)
	lfs 3,0(9)
	blrl
	b .L330
.L329:
	lis 29,gi@ha
	lis 3,.LC49@ha
	la 29,gi@l(29)
	la 3,.LC49@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC51@ha
	lwz 0,16(29)
	lis 10,.LC52@ha
	la 9,.LC51@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC52@l(10)
	li 4,26
	mtlr 0
	lis 9,.LC52@ha
	mr 3,31
	lfs 2,0(10)
	la 9,.LC52@l(9)
	lfs 3,0(9)
	blrl
.L330:
	lis 9,.LC52@ha
	lis 11,ctf@ha
	la 9,.LC52@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L352
	bc 12,18,.L333
	cmpwi 0,28,2
	bc 12,2,.L334
	b .L352
.L333:
	lis 9,.LC13@ha
	la 30,.LC13@l(9)
	b .L336
.L334:
	lis 9,.LC14@ha
	la 30,.LC14@l(9)
.L336:
	lis 9,gi@ha
	li 29,0
	la 28,gi@l(9)
	li 31,1
	b .L337
.L339:
	lwz 0,284(29)
	andis. 10,0,1
	bc 12,2,.L340
	mr 3,29
	bl G_FreeEdict
	b .L337
.L340:
	lwz 0,184(29)
	mr 3,29
	stw 31,248(29)
	rlwinm 0,0,0,0,30
	stw 0,184(29)
	lwz 9,72(28)
	mtlr 9
	blrl
	stw 31,80(29)
.L337:
	mr 3,29
	li 4,280
	mr 5,30
	bl G_Find
	mr. 29,3
	bc 4,2,.L339
	b .L352
.L300:
	addi 5,5,700
	bc 12,18,.L343
	cmpwi 0,28,2
	bc 12,2,.L344
	b .L347
.L343:
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
	b .L346
.L344:
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L346
.L347:
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
.L346:
	lis 4,.LC50@ha
	li 3,2
	la 4,.LC50@l(4)
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
	stfs 0,4064(10)
	lwz 0,284(31)
	andis. 11,0,0x1
	bc 4,2,.L348
	lwz 0,264(31)
	lwz 9,184(31)
	oris 0,0,0x8000
	stw 11,248(31)
	ori 9,9,1
	stw 0,264(31)
	stw 9,184(31)
.L348:
	li 3,1
.L349:
	lwz 0,100(1)
	lwz 12,28(1)
	mtlr 0
	lmw 20,32(1)
	lfd 30,80(1)
	lfd 31,88(1)
	mtcrf 8,12
	la 1,96(1)
	blr
.Lfe9:
	.size	 CTFPickup_Flag,.Lfe9-CTFPickup_Flag
	.section	".rodata"
	.align 2
.LC55:
	.string	"The %s flag has returned!\n"
	.align 2
.LC56:
	.long 0x0
	.section	".text"
	.align 2
	.type	 CTFDropFlagThink,@function
CTFDropFlagThink:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lis 29,.LC13@ha
	lwz 3,280(31)
	la 4,.LC13@l(29)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L356
	lis 9,.LC56@ha
	lis 11,ctf@ha
	la 9,.LC56@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L358
	la 30,.LC13@l(29)
	li 31,0
	b .L363
.L365:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L366
	mr 3,31
	bl G_FreeEdict
	b .L363
.L366:
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
.L363:
	mr 3,31
	li 4,280
	mr 5,30
	bl G_Find
	mr. 31,3
	bc 4,2,.L365
.L358:
	lis 5,.LC16@ha
	lis 4,.LC55@ha
	la 4,.LC55@l(4)
	la 5,.LC16@l(5)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
	b .L374
.L356:
	lwz 3,280(31)
	lis 31,.LC14@ha
	la 4,.LC14@l(31)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L374
	lis 9,.LC56@ha
	lis 11,ctf@ha
	la 9,.LC56@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L377
	la 30,.LC14@l(31)
	li 31,0
	b .L382
.L384:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L385
	mr 3,31
	bl G_FreeEdict
	b .L382
.L385:
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
.L382:
	mr 3,31
	li 4,280
	mr 5,30
	bl G_Find
	mr. 31,3
	bc 4,2,.L384
.L377:
	lis 5,.LC17@ha
	lis 4,.LC55@ha
	la 4,.LC55@l(4)
	la 5,.LC17@l(5)
	li 3,2
	crxor 6,6,6
	bl safe_bprintf
.L374:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 CTFDropFlagThink,.Lfe10-CTFDropFlagThink
	.section	".rodata"
	.align 2
.LC57:
	.string	"%s lost the %s flag!\n"
	.align 3
.LC58:
	.long 0x3f847ae1
	.long 0x47ae147b
	.align 2
.LC59:
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
	lis 11,.LC59@ha
	lis 9,ctf@ha
	la 11,.LC59@l(11)
	mr 29,3
	lfs 13,0(11)
	li 30,0
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L393
	lis 9,flag1_item@ha
	lwz 0,flag1_item@l(9)
	cmpwi 0,0,0
	bc 12,2,.L396
	lis 9,flag2_item@ha
	lwz 0,flag2_item@l(9)
	cmpwi 0,0,0
	bc 4,2,.L395
.L396:
	bl CTFInit
.L395:
	lis 9,flag1_item@ha
	lis 11,itemlist@ha
	lwz 10,84(29)
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
	bc 12,2,.L397
	mr 3,29
	bl Drop_Item
	lis 9,flag1_item@ha
	li 11,0
	lwz 0,flag1_item@l(9)
	mr 30,3
	lis 6,.LC16@ha
	lwz 9,84(29)
	lis 4,.LC57@ha
	la 6,.LC16@l(6)
	subf 0,28,0
	la 4,.LC57@l(4)
	mullw 0,0,31
	addi 9,9,740
	li 3,2
	rlwinm 0,0,0,0,29
	stwx 11,9,0
	lwz 5,84(29)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
	b .L403
.L397:
	lis 27,flag2_item@ha
	lwz 4,flag2_item@l(27)
	subf 0,28,4
	mullw 0,0,31
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L403
	mr 3,29
	bl Drop_Item
	lwz 0,flag2_item@l(27)
	mr 30,3
	lis 6,.LC17@ha
	lwz 9,84(29)
	lis 4,.LC57@ha
	la 6,.LC17@l(6)
	subf 0,28,0
	la 4,.LC57@l(4)
	mullw 0,0,31
	addi 9,9,740
	li 3,2
	rlwinm 0,0,0,0,29
	stwx 26,9,0
	lwz 5,84(29)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
.L403:
	cmpwi 0,30,0
	bc 12,2,.L393
	lis 9,flagsnap@ha
	lis 11,CTFDropFlagTouch@ha
	la 9,flagsnap@l(9)
	la 11,CTFDropFlagTouch@l(11)
	lis 0,0xc1c0
	stw 9,452(30)
	lis 10,Critter_Panic@ha
	stw 11,444(30)
	lis 5,0xc180
	lis 4,0x4180
	stw 0,196(30)
	lis 9,0x4200
	la 10,Critter_Panic@l(10)
	li 8,5
	li 7,2
	stw 9,208(30)
	lis 11,0x4234
	li 0,50
	stw 5,192(30)
	stw 4,204(30)
	lis 6,level+4@ha
	lis 9,.LC58@ha
	stw 8,260(30)
	stw 7,248(30)
	stw 11,420(30)
	stw 0,400(30)
	stw 10,436(30)
	stw 5,188(30)
	stw 4,200(30)
	lfs 0,level+4@l(6)
	lfd 13,.LC58@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
.L393:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 CTFDeadDropFlag,.Lfe11-CTFDeadDropFlag
	.section	".rodata"
	.align 2
.LC60:
	.string	"Only lusers drop flags.\n"
	.align 2
.LC61:
	.string	"Winners don't drop flags.\n"
	.align 2
.LC63:
	.string	"CTFFlagSetup: %s startsolid at %s\n"
	.align 3
.LC64:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC65:
	.long 0xc1700000
	.align 2
.LC66:
	.long 0x41700000
	.align 2
.LC67:
	.long 0x0
	.align 2
.LC68:
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
	lis 9,.LC65@ha
	lis 11,.LC65@ha
	la 9,.LC65@l(9)
	la 11,.LC65@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC65@ha
	lfs 2,0(11)
	la 9,.LC65@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC66@ha
	lfs 13,0(11)
	la 9,.LC66@l(9)
	lfs 1,0(9)
	lis 9,.LC66@ha
	stfs 13,188(31)
	la 9,.LC66@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC66@ha
	stfs 0,192(31)
	la 9,.LC66@l(9)
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
	bc 12,2,.L416
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L417
.L416:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L417:
	li 11,1
	lis 9,Touch_Item@ha
	stw 11,248(31)
	la 9,Touch_Item@l(9)
	li 0,7
	lis 11,.LC67@ha
	stw 9,444(31)
	addi 29,31,4
	la 11,.LC67@l(11)
	lis 9,.LC68@ha
	stw 0,260(31)
	lfs 1,0(11)
	la 9,.LC68@l(9)
	lis 11,.LC67@ha
	lfs 3,0(9)
	la 11,.LC67@l(11)
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
	bc 12,2,.L418
	mr 3,29
	lwz 29,280(31)
	bl vtos
	mr 5,3
	lwz 0,4(30)
	mr 4,29
	lis 3,.LC63@ha
	la 3,.LC63@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L415
.L418:
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
	lis 10,.LC64@ha
	lfs 0,level+4@l(11)
	lis 9,CTFFlagThink@ha
	lfd 13,.LC64@l(10)
	la 9,CTFFlagThink@l(9)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L415:
	lwz 0,116(1)
	mtlr 0
	lmw 29,100(1)
	la 1,112(1)
	blr
.Lfe12:
	.size	 CTFFlagSetup,.Lfe12-CTFFlagSetup
	.section	".rodata"
	.align 2
.LC69:
	.string	"players/male/w_jawa.md2"
	.align 2
.LC70:
	.string	"players/male/w_ewok.md2"
	.align 2
.LC71:
	.long 0x0
	.align 3
.LC72:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CTFCalcScores
	.type	 CTFCalcScores,@function
CTFCalcScores:
	stwu 1,-16(1)
	lis 11,.LC71@ha
	lis 9,ctf@ha
	la 11,.LC71@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L425
	lis 9,ctfgame@ha
	lis 11,maxclients@ha
	lwz 7,maxclients@l(11)
	la 8,ctfgame@l(9)
	li 0,0
	stw 0,8(8)
	li 6,0
	stw 0,12(8)
	lfs 0,20(7)
	fcmpu 0,13,0
	bc 4,0,.L425
	lis 9,g_edicts@ha
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	mr 5,7
	la 11,game@l(11)
	lis 9,.LC72@ha
	lis 4,0x4330
	la 9,.LC72@l(9)
	addi 10,10,1164
	lfd 12,0(9)
	li 7,0
.L430:
	lwz 0,0(10)
	addi 10,10,1076
	cmpwi 0,0,0
	bc 12,2,.L429
	lwz 0,1028(11)
	add 9,7,0
	lwz 0,4048(9)
	cmpwi 0,0,1
	bc 4,2,.L432
	lwz 9,4032(9)
	lwz 0,8(8)
	add 0,0,9
	stw 0,8(8)
	b .L429
.L432:
	cmpwi 0,0,2
	bc 4,2,.L429
	lwz 9,4032(9)
	lwz 0,12(8)
	add 0,0,9
	stw 0,12(8)
.L429:
	addi 6,6,1
	lfs 13,20(5)
	xoris 0,6,0x8000
	addi 7,7,4956
	stw 0,12(1)
	stw 4,8(1)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L430
.L425:
	la 1,16(1)
	blr
.Lfe13:
	.size	 CTFCalcScores,.Lfe13-CTFCalcScores
	.section	".rodata"
	.align 2
.LC73:
	.string	"Disabling player identication display.\n"
	.align 2
.LC74:
	.string	"Activating player identication display.\n"
	.align 3
.LC75:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 2
.LC76:
	.long 0x0
	.align 2
.LC77:
	.long 0x44800000
	.align 2
.LC78:
	.long 0x3f800000
	.align 3
.LC79:
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
	lis 11,.LC76@ha
	addi 4,1,8
	la 11,.LC76@l(11)
	li 5,0
	sth 0,174(9)
	li 6,0
	lwz 3,84(30)
	lfs 29,0(11)
	addi 3,3,4252
	bl AngleVectors
	lis 9,.LC77@ha
	addi 3,1,8
	la 9,.LC77@l(9)
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
	lis 9,.LC78@ha
	lfs 13,48(1)
	la 9,.LC78@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L440
	lwz 9,92(1)
	cmpwi 0,9,0
	bc 12,2,.L440
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L440
	lis 11,g_edicts@ha
	lis 0,0x6205
	lwz 10,84(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,46533
	subf 9,9,30
	b .L449
.L440:
	lwz 3,84(30)
	addi 4,1,8
	li 5,0
	li 6,0
	li 27,0
	addi 3,3,4252
	li 28,1
	bl AngleVectors
	lis 24,maxclients@ha
	lis 9,.LC78@ha
	lis 11,maxclients@ha
	la 9,.LC78@l(9)
	lfs 13,0(9)
	lwz 9,maxclients@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L442
	lis 11,.LC79@ha
	lis 25,g_edicts@ha
	la 11,.LC79@l(11)
	lis 26,0x4330
	lfd 30,0(11)
	li 29,1076
.L444:
	lwz 0,g_edicts@l(25)
	add 31,0,29
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L443
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
	bc 4,1,.L443
	mr 3,30
	mr 4,31
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L443
	fmr 29,31
	mr 27,31
.L443:
	addi 28,28,1
	lwz 11,maxclients@l(24)
	xoris 0,28,0x8000
	addi 29,29,1076
	stw 0,116(1)
	stw 26,112(1)
	lfd 0,112(1)
	lfs 13,20(11)
	fsub 0,0,30
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L444
.L442:
	lis 9,.LC75@ha
	fmr 13,29
	lfd 0,.LC75@l(9)
	fcmpu 0,13,0
	bc 4,1,.L439
	lis 11,g_edicts@ha
	lis 0,0x6205
	lwz 10,84(30)
	lwz 9,g_edicts@l(11)
	ori 0,0,46533
	subf 9,9,27
.L449:
	mullw 9,9,0
	srawi 9,9,2
	addi 9,9,1311
	sth 9,174(10)
.L439:
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
.LC80:
	.string	"ctf/teamlight"
	.align 2
.LC81:
	.string	"ctf/teamdark"
	.align 2
.LC82:
	.string	"ctf/i_ctf1"
	.align 2
.LC83:
	.string	"ctf/i_ctf1d"
	.align 2
.LC84:
	.string	"ctf/i_ctf1t"
	.align 2
.LC85:
	.string	"ctf/i_ctf2"
	.align 2
.LC86:
	.string	"ctf/i_ctf2d"
	.align 2
.LC87:
	.string	"ctf/i_ctf2t"
	.align 2
.LC88:
	.long 0x0
	.align 2
.LC89:
	.long 0x3f800000
	.align 3
.LC90:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC91:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl SetCTFStats
	.type	 SetCTFStats,@function
SetCTFStats:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	lis 9,ctf@ha
	lis 10,.LC88@ha
	lwz 11,ctf@l(9)
	la 10,.LC88@l(10)
	mr 31,3
	lfs 31,0(10)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L450
	lis 29,gi@ha
	lis 3,.LC80@ha
	la 29,gi@l(29)
	la 3,.LC80@l(3)
	lwz 9,40(29)
	lis 27,level@ha
	mtlr 9
	blrl
	lwz 9,84(31)
	lis 11,.LC81@ha
	sth 3,180(9)
	lwz 0,40(29)
	la 3,.LC81@l(11)
	mtlr 0
	blrl
	lwz 9,84(31)
	lis 11,level+200@ha
	lis 10,ctfgame@ha
	sth 3,182(9)
	lfs 0,level+200@l(11)
	fcmpu 0,0,31
	bc 12,2,.L452
	lwz 0,level@l(27)
	andi. 9,0,8
	bc 12,2,.L452
	la 11,ctfgame@l(10)
	lwz 9,ctfgame@l(10)
	lwz 0,4(11)
	cmpw 0,9,0
	bc 12,1,.L500
	cmpw 0,0,9
	bc 12,1,.L501
	lwz 9,12(11)
	lwz 0,8(11)
	cmpw 0,0,9
	bc 4,1,.L457
.L500:
	lwz 9,84(31)
	li 0,0
	sth 0,180(9)
	b .L452
.L457:
	cmpw 0,9,0
	bc 4,1,.L459
.L501:
	lwz 9,84(31)
	li 0,0
	sth 0,182(9)
	b .L452
.L497:
	lis 9,gi+40@ha
	lwz 3,36(3)
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,172(9)
	b .L462
.L459:
	lwz 9,84(31)
	li 0,0
	sth 0,180(9)
	lwz 11,84(31)
	sth 0,182(11)
.L452:
	lwz 10,84(31)
	li 11,0
	lis 9,tnames@ha
	la 3,tnames@l(9)
	sth 11,172(10)
	lwzx 0,3,11
	cmpwi 0,0,0
	bc 12,2,.L462
	lis 9,itemlist@ha
	lis 29,0x286b
	la 28,itemlist@l(9)
	mr 30,3
	ori 29,29,51739
.L463:
	lwz 3,0(30)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L464
	subf 0,28,3
	lwz 11,84(31)
	mullw 0,0,29
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L497
.L464:
	lwzu 0,4(30)
	cmpwi 0,0,0
	bc 4,2,.L463
.L462:
	lis 9,gi@ha
	lis 3,.LC82@ha
	la 30,gi@l(9)
	la 3,.LC82@l(3)
	lwz 9,40(30)
	mtlr 9
	blrl
	mr 28,3
	lis 5,.LC13@ha
	la 5,.LC13@l(5)
	li 3,0
	li 4,280
	bl G_Find
	mr. 3,3
	bc 12,2,.L466
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L467
	lwz 0,40(30)
	lis 3,.LC83@ha
	la 3,.LC83@l(3)
	mtlr 0
	blrl
	lis 9,maxclients@ha
	lis 10,.LC89@ha
	lwz 11,maxclients@l(9)
	la 10,.LC89@l(10)
	mr 28,3
	lfs 0,0(10)
	li 7,1
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L466
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
	lis 9,.LC90@ha
	mullw 10,10,0
	lis 11,0x4330
	la 9,.LC90@l(9)
	addi 8,8,1076
	lfd 13,0(9)
	rlwinm 10,10,0,0,29
.L471:
	lwz 0,88(8)
	cmpwi 0,0,0
	bc 12,2,.L470
	lwz 9,84(8)
	addi 9,9,740
	lwzx 0,9,10
	cmpwi 0,0,0
	bc 4,2,.L498
.L470:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,1076
	stw 0,28(1)
	stw 11,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L471
	b .L466
.L498:
	lis 9,gi+40@ha
	lis 3,.LC84@ha
	lwz 0,gi+40@l(9)
	la 3,.LC84@l(3)
	b .L502
.L467:
	lwz 0,284(3)
	andis. 9,0,1
	bc 12,2,.L466
	lwz 0,40(30)
	lis 3,.LC83@ha
	la 3,.LC83@l(3)
.L502:
	mtlr 0
	blrl
	mr 28,3
.L466:
	lis 9,gi@ha
	lis 3,.LC85@ha
	la 30,gi@l(9)
	la 3,.LC85@l(3)
	lwz 9,40(30)
	mtlr 9
	blrl
	mr 29,3
	lis 5,.LC14@ha
	la 5,.LC14@l(5)
	li 3,0
	li 4,280
	bl G_Find
	mr. 3,3
	bc 12,2,.L476
	lwz 0,248(3)
	cmpwi 0,0,0
	bc 4,2,.L477
	lwz 0,40(30)
	lis 3,.LC86@ha
	la 3,.LC86@l(3)
	mtlr 0
	blrl
	lis 9,maxclients@ha
	lis 10,.LC89@ha
	lwz 11,maxclients@l(9)
	la 10,.LC89@l(10)
	mr 29,3
	lfs 0,0(10)
	li 7,1
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L476
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
	lis 9,.LC90@ha
	mullw 10,10,0
	lis 11,0x4330
	la 9,.LC90@l(9)
	addi 8,8,1076
	lfd 13,0(9)
	rlwinm 10,10,0,0,29
.L481:
	lwz 0,88(8)
	cmpwi 0,0,0
	bc 12,2,.L480
	lwz 9,84(8)
	addi 9,9,740
	lwzx 0,9,10
	cmpwi 0,0,0
	bc 4,2,.L499
.L480:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,1076
	stw 0,28(1)
	stw 11,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L481
	b .L476
.L499:
	lis 9,gi+40@ha
	lis 3,.LC87@ha
	lwz 0,gi+40@l(9)
	la 3,.LC87@l(3)
	b .L503
.L477:
	lwz 0,284(3)
	andis. 9,0,1
	bc 12,2,.L476
	lwz 0,40(30)
	lis 3,.LC86@ha
	la 3,.LC86@l(3)
.L503:
	mtlr 0
	blrl
	mr 29,3
.L476:
	lis 10,.LC88@ha
	lwz 11,84(31)
	lis 9,ctfgame@ha
	la 10,.LC88@l(10)
	lfs 0,0(10)
	sth 28,172(11)
	la 10,ctfgame@l(9)
	lwz 9,84(31)
	sth 29,176(9)
	lfs 12,16(10)
	fcmpu 0,12,0
	bc 12,2,.L486
	lis 9,level+4@ha
	lis 11,.LC91@ha
	lfs 0,level+4@l(9)
	la 11,.LC91@l(11)
	lfs 13,0(11)
	fsubs 0,0,12
	fcmpu 0,0,13
	bc 4,0,.L486
	lwz 0,20(10)
	cmpwi 0,0,1
	bc 4,2,.L487
	lwz 0,level@l(27)
	andi. 0,0,8
	bc 12,2,.L488
	lwz 9,84(31)
	sth 28,172(9)
	b .L486
.L488:
	lwz 9,84(31)
	sth 0,172(9)
	b .L486
.L487:
	lwz 0,level@l(27)
	andi. 0,0,8
	bc 12,2,.L491
	lwz 9,84(31)
	sth 29,176(9)
	b .L486
.L491:
	lwz 9,84(31)
	sth 0,176(9)
.L486:
	lis 11,ctfgame@ha
	lwz 9,84(31)
	li 8,0
	la 11,ctfgame@l(11)
	lhz 0,2(11)
	sth 0,174(9)
	lhz 10,6(11)
	lwz 9,84(31)
	sth 10,178(9)
	lwz 11,84(31)
	sth 8,130(11)
	lwz 10,84(31)
	lwz 0,4048(10)
	cmpwi 0,0,1
	bc 4,2,.L493
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
	bc 12,2,.L493
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L493
	lis 9,gi+40@ha
	lis 3,.LC85@ha
	lwz 0,gi+40@l(9)
	la 3,.LC85@l(3)
	b .L504
.L493:
	lwz 10,84(31)
	lwz 0,4048(10)
	cmpwi 0,0,2
	bc 4,2,.L494
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
	bc 12,2,.L494
	lis 9,level@ha
	lwz 0,level@l(9)
	andi. 9,0,8
	bc 12,2,.L494
	lis 9,gi+40@ha
	lis 3,.LC82@ha
	lwz 0,gi+40@l(9)
	la 3,.LC82@l(3)
.L504:
	mtlr 0
	blrl
	lwz 9,84(31)
	sth 3,130(9)
.L494:
	lwz 11,84(31)
	li 0,0
	sth 0,174(11)
	lwz 9,84(31)
	lwz 0,4072(9)
	cmpwi 0,0,0
	bc 12,2,.L450
	mr 3,31
	bl CTFSetIDView
.L450:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe15:
	.size	 SetCTFStats,.Lfe15-SetCTFStats
	.align 2
	.globl CTFGrappleTouch
	.type	 CTFGrappleTouch,@function
CTFGrappleTouch:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 31,3
	mr 29,4
	lwz 9,256(31)
	mr 27,5
	cmpw 0,29,9
	bc 12,2,.L512
	lwz 11,84(9)
	lwz 10,4768(11)
	cmpwi 0,10,0
	bc 4,2,.L512
	cmpwi 0,6,0
	bc 12,2,.L515
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L515
	lwz 0,4764(11)
	cmpwi 0,0,0
	bc 12,2,.L512
	lis 9,level+4@ha
	stw 10,4764(11)
	lbz 0,16(11)
	lfs 0,level+4@l(9)
	andi. 0,0,191
	stb 0,16(11)
	stfs 0,4772(11)
	bl G_FreeEdict
	b .L512
.L515:
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
	bc 12,2,.L519
	lwz 9,516(31)
	li 0,34
	li 30,0
	lwz 5,256(31)
	mr 3,29
	mr 7,28
	stw 0,12(1)
	mr 8,27
	mr 4,31
	stw 30,8(1)
	addi 6,31,376
	li 10,1
	bl T_Damage
	lwz 9,256(31)
	lwz 11,84(9)
	lwz 0,4764(11)
	cmpwi 0,0,0
	bc 12,2,.L512
	lis 9,level+4@ha
	stw 30,4764(11)
	mr 3,31
	lfs 0,level+4@l(9)
	lbz 0,16(11)
	stw 30,4768(11)
	andi. 0,0,191
	stfs 0,4772(11)
	stb 0,16(11)
	bl G_FreeEdict
	b .L512
.L519:
	lwz 11,256(31)
	lis 9,gi@ha
	li 0,1
	la 30,gi@l(9)
	li 3,3
	lwz 9,84(11)
	stw 0,4768(9)
	stw 10,248(31)
	stw 29,540(31)
	lwz 9,100(30)
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,9
	mtlr 9
	blrl
	lwz 9,120(30)
	mr 3,28
	mtlr 9
	blrl
	cmpwi 0,27,0
	bc 4,2,.L524
	lwz 0,124(30)
	mr 3,26
	mtlr 0
	blrl
	b .L525
.L524:
	lwz 0,124(30)
	mr 3,27
	mtlr 0
	blrl
.L525:
	lis 9,gi+88@ha
	mr 3,28
	lwz 0,gi+88@l(9)
	li 4,2
	mtlr 0
	blrl
.L512:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe16:
	.size	 CTFGrappleTouch,.Lfe16-CTFGrappleTouch
	.section	".rodata"
	.align 3
.LC94:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC95:
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
	addi 3,3,4252
	bl AngleVectors
	lis 9,.LC94@ha
	lwz 10,256(31)
	lis 0,0x4180
	la 9,.LC94@l(9)
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
	lis 9,.LC95@ha
	la 9,.LC95@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L526
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
	lis 0,0x6205
	lwz 11,g_edicts@l(9)
	ori 0,0,46533
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
.L526:
	lwz 0,132(1)
	mtlr 0
	lmw 28,112(1)
	la 1,128(1)
	blr
.Lfe17:
	.size	 CTFGrappleDrawCable,.Lfe17-CTFGrappleDrawCable
	.section	".rodata"
	.align 2
.LC96:
	.string	"weapon_grapple"
	.align 2
.LC98:
	.long 0x44228000
	.align 2
.LC99:
	.long 0x3f000000
	.align 3
.LC100:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC101:
	.long 0x42800000
	.section	".text"
	.align 2
	.globl CTFGrapplePull
	.type	 CTFGrapplePull,@function
CTFGrapplePull:
	stwu 1,-112(1)
	mflr 0
	stw 31,108(1)
	stw 0,116(1)
	mr 31,3
	lis 4,.LC96@ha
	lwz 10,256(31)
	la 4,.LC96@l(4)
	lwz 9,84(10)
	lwz 11,1764(9)
	lwz 3,0(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L529
	lwz 9,256(31)
	lwz 11,84(9)
	lwz 10,4148(11)
	cmpwi 0,10,0
	bc 4,2,.L529
	lwz 0,4184(11)
	cmpwi 0,0,3
	bc 12,2,.L529
	cmpwi 0,0,1
	bc 4,2,.L549
.L529:
	lwz 3,540(31)
	cmpwi 0,3,0
	bc 12,2,.L533
	lwz 10,248(3)
	cmpwi 0,10,0
	bc 4,2,.L534
	lwz 9,256(31)
	lwz 11,84(9)
.L549:
	lwz 0,4764(11)
	cmpwi 0,0,0
	bc 12,2,.L528
	lis 9,level+4@ha
	stw 10,4764(11)
	mr 3,31
	lfs 0,level+4@l(9)
	lbz 0,16(11)
	stw 10,4768(11)
	andi. 0,0,191
	stfs 0,4772(11)
	stb 0,16(11)
	bl G_FreeEdict
	b .L528
.L534:
	cmpwi 0,10,2
	bc 4,2,.L538
	lis 8,.LC99@ha
	addi 3,3,236
	la 8,.LC99@l(8)
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
	b .L539
.L538:
	lfs 0,376(3)
	stfs 0,376(31)
	lfs 13,380(3)
	stfs 13,380(31)
	lfs 0,384(3)
	stfs 0,384(31)
.L539:
	lwz 3,540(31)
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L540
	lwz 4,256(31)
	bl CheckTeamDamage
	mr. 9,3
	bc 4,2,.L540
	lwz 5,256(31)
	li 0,34
	lis 8,vec3_origin@ha
	lwz 3,540(31)
	la 8,vec3_origin@l(8)
	mr 4,31
	stw 9,8(1)
	addi 6,31,376
	addi 7,31,4
	stw 0,12(1)
	li 9,1
	li 10,1
	bl T_Damage
.L540:
	lwz 9,540(31)
	lwz 0,492(9)
	cmpwi 0,0,0
	bc 12,2,.L533
	lwz 9,256(31)
	lwz 10,84(9)
	lwz 0,4764(10)
	cmpwi 0,0,0
	bc 12,2,.L528
	li 11,0
	lis 9,level+4@ha
	lbz 0,16(10)
	stw 11,4764(10)
	mr 3,31
	lfs 0,level+4@l(9)
	andi. 0,0,191
	stb 0,16(10)
	stw 11,4768(10)
	stfs 0,4772(10)
	bl G_FreeEdict
	b .L528
.L533:
	mr 3,31
	bl CTFGrappleDrawCable
	lwz 9,256(31)
	lwz 3,84(9)
	lwz 0,4768(3)
	cmpwi 0,0,0
	bc 4,1,.L528
	addi 3,3,4252
	addi 4,1,48
	li 5,0
	addi 6,1,64
	bl AngleVectors
	lwz 9,256(31)
	lis 10,0x4330
	lfs 10,4(31)
	lis 8,.LC100@ha
	addi 3,1,16
	lfs 0,4(9)
	la 8,.LC100@l(8)
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
	stw 0,100(1)
	stw 10,96(1)
	lfd 0,96(1)
	fsub 0,0,8
	frsp 0,0
	fadds 12,12,0
	fsubs 9,9,12
	stfs 12,40(1)
	stfs 9,24(1)
	bl VectorLength
	lis 8,.LC101@ha
	lwz 9,256(31)
	la 8,.LC101@l(8)
	lfs 0,0(8)
	lwz 11,84(9)
	fcmpu 7,1,0
	lwz 0,4768(11)
	xori 0,0,1
	subfic 10,0,0
	adde 0,10,0
	mfcr 9
	rlwinm 9,9,29,1
	and. 8,0,9
	bc 12,2,.L547
	lbz 0,16(11)
	li 10,2
	ori 0,0,64
	stb 0,16(11)
	lwz 9,256(31)
	lwz 11,84(9)
	stw 10,4768(11)
.L547:
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
.L528:
	lwz 0,116(1)
	mtlr 0
	lwz 31,108(1)
	la 1,112(1)
	blr
.Lfe18:
	.size	 CTFGrapplePull,.Lfe18-CTFGrapplePull
	.section	".rodata"
	.align 2
.LC102:
	.string	"models/weapons/grapple/hook/tris.md2"
	.align 3
.LC104:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC105:
	.long 0x41c00000
	.align 2
.LC106:
	.long 0x41000000
	.align 2
.LC107:
	.long 0xc0000000
	.align 3
.LC108:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC109:
	.long 0xc1200000
	.section	".text"
	.align 2
	.globl CTFGrappleFire
	.type	 CTFGrappleFire,@function
CTFGrappleFire:
	stwu 1,-192(1)
	mflr 0
	stfd 31,184(1)
	stmw 22,144(1)
	stw 0,196(1)
	mr 30,3
	mr 31,4
	lwz 3,84(30)
	mr 22,5
	mr 23,6
	lwz 0,4768(3)
	cmpwi 0,0,0
	bc 12,1,.L552
	addi 29,1,24
	addi 4,1,8
	mr 5,29
	addi 3,3,4252
	li 6,0
	lis 28,0x4330
	bl AngleVectors
	addi 27,30,4
	lis 9,.LC104@ha
	lis 10,.LC105@ha
	lfs 12,0(31)
	la 9,.LC104@l(9)
	la 10,.LC105@l(10)
	lfs 10,8(31)
	lfd 31,0(9)
	addi 6,1,8
	lwz 9,508(30)
	addi 24,1,40
	mr 26,6
	lfs 0,0(10)
	mr 7,29
	addi 5,1,56
	addi 9,9,-6
	lis 10,.LC106@ha
	lfs 13,4(31)
	xoris 9,9,0x8000
	la 10,.LC106@l(10)
	lwz 3,84(30)
	stw 9,140(1)
	fadds 12,12,0
	mr 8,24
	mr 4,27
	stw 28,136(1)
	li 29,650
	lfd 0,136(1)
	lfs 11,0(10)
	stfs 12,56(1)
	fsub 0,0,31
	fadds 13,13,11
	frsp 0,0
	stfs 13,60(1)
	fadds 0,0,10
	stfs 0,64(1)
	bl P_ProjectSource
	lis 9,.LC107@ha
	lwz 4,84(30)
	addi 3,1,8
	la 9,.LC107@l(9)
	lfs 1,0(9)
	addi 4,4,4200
	bl VectorScale
	lwz 9,84(30)
	lis 0,0xbf80
	mr 3,26
	stw 0,4188(9)
	bl VectorNormalize
	bl G_Spawn
	lfs 0,40(1)
	mr 31,3
	mr 3,26
	addi 4,31,16
	addi 25,31,4
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
	xoris 29,29,0x8000
	stw 29,140(1)
	addi 4,31,376
	mr 3,26
	stw 28,136(1)
	lfd 1,136(1)
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
	lis 29,gi@ha
	stw 8,248(31)
	lis 3,.LC102@ha
	la 29,gi@l(29)
	stw 0,252(31)
	la 3,.LC102@l(3)
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
	stw 22,516(31)
	mr 3,31
	stw 9,444(31)
	stw 30,256(31)
	lwz 9,84(30)
	stw 31,4764(9)
	lwz 11,84(30)
	stw 0,4768(11)
	lwz 9,72(29)
	mtlr 9
	blrl
	lwz 0,48(29)
	lis 9,0x600
	mr 4,27
	ori 9,9,3
	addi 3,1,72
	li 5,0
	li 6,0
	mtlr 0
	mr 7,25
	mr 8,31
	blrl
	lfs 0,80(1)
	lis 9,.LC108@ha
	la 9,.LC108@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L556
	lis 10,.LC109@ha
	mr 3,25
	la 10,.LC109@l(10)
	mr 5,3
	lfs 1,0(10)
	mr 4,26
	bl VectorMA
	lwz 0,444(31)
	mr 3,31
	li 5,0
	lwz 4,124(1)
	li 6,0
	mtlr 0
	blrl
.L556:
	mr 3,30
	mr 4,24
	li 5,1
	bl PlayerNoise
.L552:
	lwz 0,196(1)
	mtlr 0
	lmw 22,144(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe19:
	.size	 CTFGrappleFire,.Lfe19-CTFGrappleFire
	.section	".data"
	.align 2
	.type	 pause_frames.120,@object
pause_frames.120:
	.long 10
	.long 18
	.long 27
	.long 0
	.align 2
	.type	 fire_frames.121,@object
fire_frames.121:
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
	lwz 0,4132(9)
	andi. 11,0,1
	bc 12,2,.L569
	lwz 0,4184(9)
	cmpwi 0,0,3
	bc 4,2,.L559
	lwz 0,4764(9)
	cmpwi 0,0,0
	bc 12,2,.L559
	li 0,9
	stw 0,92(9)
.L559:
	lwz 9,84(31)
	lwz 0,4132(9)
	andi. 9,0,1
	bc 4,2,.L560
.L569:
	lwz 9,84(31)
	lwz 3,4764(9)
	cmpwi 0,3,0
	bc 12,2,.L560
	lwz 9,256(3)
	lwz 10,84(9)
	lwz 0,4764(10)
	cmpwi 0,0,0
	bc 12,2,.L563
	li 11,0
	lis 9,level+4@ha
	lbz 0,16(10)
	stw 11,4764(10)
	lfs 0,level+4@l(9)
	andi. 0,0,191
	stb 0,16(10)
	stw 11,4768(10)
	stfs 0,4772(10)
	bl G_FreeEdict
.L563:
	lwz 9,84(31)
	lwz 0,4184(9)
	cmpwi 0,0,3
	bc 4,2,.L560
	li 0,0
	stw 0,4184(9)
.L560:
	lwz 9,84(31)
	lwz 0,4148(9)
	cmpwi 0,0,0
	bc 12,2,.L565
	lwz 0,4768(9)
	cmpwi 0,0,0
	bc 4,1,.L565
	lwz 0,4184(9)
	cmpwi 0,0,3
	bc 4,2,.L565
	li 0,2
	li 11,32
	stw 0,4184(9)
	lwz 9,84(31)
	stw 11,92(9)
.L565:
	lwz 9,84(31)
	lis 8,Reload_NULL@ha
	lis 11,CTFWeapon_Grapple_Fire@ha
	la 8,Reload_NULL@l(8)
	la 11,CTFWeapon_Grapple_Fire@l(11)
	lwz 29,4184(9)
	lis 10,fire_frames.121@ha
	mr 3,31
	stw 8,12(1)
	lis 9,pause_frames.120@ha
	la 10,fire_frames.121@l(10)
	stw 11,8(1)
	la 9,pause_frames.120@l(9)
	li 4,5
	li 5,9
	li 6,31
	li 7,36
	li 8,36
	bl Weapon_Generic
	cmpwi 0,29,1
	bc 4,2,.L566
	lwz 9,84(31)
	lwz 0,4184(9)
	cmpwi 0,0,0
	bc 4,2,.L566
	lwz 0,4768(9)
	cmpwi 0,0,0
	bc 4,1,.L566
	lwz 0,4132(9)
	andi. 11,0,1
	li 0,5
	bc 4,2,.L567
	li 0,9
.L567:
	stw 0,92(9)
	lwz 9,84(31)
	li 0,3
	stw 0,4184(9)
.L566:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 CTFWeapon_Grapple,.Lfe20-CTFWeapon_Grapple
	.section	".rodata"
	.align 2
.LC111:
	.string	"You are on the %s team.\n"
	.align 2
.LC112:
	.string	"red"
	.align 2
.LC113:
	.string	"blue"
	.align 2
.LC114:
	.string	"Unknown team %s.\n"
	.align 2
.LC115:
	.string	"You are already on the %s team.\n"
	.align 2
.LC116:
	.string	"skin"
	.align 2
.LC117:
	.string	"%s joined the %s team.\n"
	.align 2
.LC118:
	.string	"%s changed to the %s team.\n"
	.align 2
.LC119:
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
	lis 11,.LC119@ha
	lis 9,ctf@ha
	la 11,.LC119@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L571
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 30,3
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L573
	lwz 9,84(31)
	lwz 0,4048(9)
	cmpwi 0,0,1
	bc 12,2,.L574
	cmpwi 0,0,2
	bc 12,2,.L575
	b .L578
.L574:
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
	b .L577
.L575:
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L577
.L578:
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
.L577:
	lis 5,.LC111@ha
	mr 3,31
	la 5,.LC111@l(5)
	b .L600
.L573:
	lis 4,.LC112@ha
	mr 3,30
	la 4,.LC112@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L579
	li 30,1
	b .L580
.L579:
	lis 4,.LC113@ha
	mr 3,30
	la 4,.LC113@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L581
	lis 5,.LC114@ha
	mr 3,31
	la 5,.LC114@l(5)
	mr 6,30
	b .L600
.L581:
	li 30,2
.L580:
	lwz 9,84(31)
	lwz 0,4048(9)
	cmpw 0,0,30
	bc 4,2,.L583
	cmpwi 0,30,1
	bc 12,2,.L584
	cmpwi 0,30,2
	bc 12,2,.L585
	b .L588
.L584:
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
	b .L587
.L585:
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L587
.L588:
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
.L587:
	lis 5,.LC115@ha
	mr 3,31
	la 5,.LC115@l(5)
.L600:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L571
.L583:
	lwz 0,264(31)
	li 29,0
	lis 4,.LC116@ha
	stw 29,184(31)
	la 4,.LC116@l(4)
	rlwinm 0,0,0,28,26
	stw 0,264(31)
	stw 30,4048(9)
	lwz 9,84(31)
	stw 29,4052(9)
	lwz 3,84(31)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl CTFAssignSkin
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L589
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
	bc 12,2,.L590
	cmpwi 0,30,2
	bc 12,2,.L591
	b .L594
.L590:
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
	b .L593
.L591:
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L593
.L594:
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
.L593:
	lis 4,.LC117@ha
	li 3,2
	la 4,.LC117@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L571
.L589:
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
	stw 29,4032(11)
	lwz 9,84(31)
	addi 5,9,700
	bc 12,2,.L595
	cmpwi 0,30,2
	bc 12,2,.L596
	b .L599
.L595:
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
	b .L598
.L596:
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L598
.L599:
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
.L598:
	lis 4,.LC118@ha
	li 3,2
	la 4,.LC118@l(4)
	crxor 6,6,6
	bl safe_bprintf
.L571:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 CTFTeam_f,.Lfe21-CTFTeam_f
	.section	".rodata"
	.align 2
.LC120:
	.string	"if 24 xv 8 yv 8 pic 24 endif xv 40 yv 28 string \"%4d/%-3d\" xv 98 yv 12 num 2 18 if 25 xv 168 yv 8 pic 25 endif xv 200 yv 28 string \"%4d/%-3d\" xv 256 yv 12 num 2 20 "
	.align 2
.LC121:
	.string	"ctf 0 %d %d %d %d "
	.align 2
.LC122:
	.string	"xv 56 yv %d picn sbfctf2 "
	.align 2
.LC123:
	.string	"ctf 160 %d %d %d %d "
	.align 2
.LC124:
	.string	"xv 216 yv %d picn sbfctf1 "
	.align 2
.LC125:
	.string	"xv 0 yv %d string2 \"Spectators\" "
	.align 2
.LC126:
	.string	"ctf %d %d %d %d %d "
	.align 2
.LC127:
	.string	"xv 8 yv %d string \"..and %d more\" "
	.align 2
.LC128:
	.string	"xv 168 yv %d string \"..and %d more\" "
	.align 2
.LC129:
	.long 0x0
	.align 3
.LC130:
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
	lis 9,.LC129@ha
	lis 11,ctf@ha
	la 9,.LC129@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L601
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
	bc 4,0,.L604
	lis 9,g_edicts@ha
	mr 20,8
	lwz 16,g_edicts@l(9)
	mr 12,17
	mr 19,14
	addi 18,1,4488
	mr 15,17
.L606:
	mulli 9,24,1076
	addi 22,24,1
	add 31,9,16
	lwz 0,1164(31)
	cmpwi 0,0,0
	bc 12,2,.L605
	mulli 9,24,4956
	lwz 0,1028(20)
	mr 8,9
	add 9,9,0
	lwz 0,4048(9)
	cmpwi 0,0,1
	bc 4,2,.L608
	li 10,0
	b .L609
.L608:
	cmpwi 0,0,2
	bc 4,2,.L605
	li 10,1
.L609:
	slwi 0,10,2
	lwz 9,1028(20)
	li 27,0
	lwzx 11,12,0
	mr 3,0
	slwi 7,10,10
	add 9,8,9
	addi 6,1,4488
	cmpw 0,27,11
	lwz 30,4032(9)
	addi 4,1,2440
	addi 22,24,1
	bc 4,0,.L613
	lwzx 0,18,7
	cmpw 0,30,0
	bc 12,1,.L613
	lwzx 11,3,15
	add 9,7,6
.L614:
	addi 27,27,1
	cmpw 0,27,11
	bc 4,0,.L613
	lwzu 0,4(9)
	cmpw 0,30,0
	bc 4,1,.L614
.L613:
	lwzx 28,3,12
	slwi 23,27,2
	cmpw 0,28,27
	bc 4,1,.L619
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
.L621:
	lwz 9,0(10)
	addi 28,28,-1
	cmpw 0,28,27
	addi 10,10,-4
	stwx 9,11,29
	lwz 0,0(8)
	addi 8,8,-4
	stwx 0,11,5
	addi 11,11,-4
	bc 12,1,.L621
.L619:
	add 0,23,7
	stwx 24,4,0
	stwx 30,6,0
	lwzx 9,3,19
	lwzx 11,3,12
	add 9,9,30
	addi 11,11,1
	stwx 9,3,19
	stwx 11,3,12
.L605:
	lwz 0,1544(20)
	mr 24,22
	cmpw 0,24,0
	bc 12,0,.L606
.L604:
	li 0,0
	lwz 7,4(14)
	lis 4,.LC120@ha
	lwz 8,4(17)
	la 4,.LC120@l(4)
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
	b .L656
.L628:
	lwz 9,6536(1)
	li 0,0
	stb 0,8(1)
	cmpw 0,24,9
	bc 4,0,.L629
	addi 29,1,2440
	slwi 28,24,2
	lwzx 0,29,28
	lis 9,game+1028@ha
	lis 10,g_edicts@ha
	lwz 8,game+1028@l(9)
	addi 3,1,8
	mulli 9,0,1076
	lwz 11,g_edicts@l(10)
	mr 23,3
	mulli 0,0,4956
	addi 9,9,1076
	add 30,8,0
	add 31,11,9
	bl strlen
	lwz 11,184(30)
	slwi 9,24,3
	lis 4,.LC121@ha
	addi 27,9,42
	lwzx 6,29,28
	la 4,.LC121@l(4)
	cmpwi 7,11,1000
	lwz 7,4032(30)
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
	bc 12,2,.L631
	mr 3,23
	bl strlen
	lis 4,.LC122@ha
	mr 5,27
	la 4,.LC122@l(4)
	add 3,23,3
	crxor 6,6,6
	bl sprintf
.L631:
	mr 3,23
	subfic 29,22,1000
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L629
	mr 4,23
	mr 3,21
	bl strcat
	mr 25,24
	mr 3,21
	bl strlen
	mr 22,3
.L629:
	lwz 0,4(17)
	cmpw 0,24,0
	bc 4,0,.L626
	addi 29,1,3464
	slwi 28,24,2
	lwzx 0,29,28
	lis 9,game+1028@ha
	lis 10,g_edicts@ha
	lwz 8,game+1028@l(9)
	addi 3,1,8
	mulli 9,0,1076
	lwz 11,g_edicts@l(10)
	mr 23,3
	mulli 0,0,4956
	addi 9,9,1076
	add 30,8,0
	add 31,11,9
	bl strlen
	lwz 11,184(30)
	slwi 9,24,3
	lis 4,.LC123@ha
	addi 27,9,42
	lwzx 6,29,28
	la 4,.LC123@l(4)
	cmpwi 7,11,1000
	lwz 7,4032(30)
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
	bc 12,2,.L635
	mr 3,23
	bl strlen
	lis 4,.LC124@ha
	mr 5,27
	la 4,.LC124@l(4)
	add 3,23,3
	crxor 6,6,6
	bl sprintf
.L635:
	mr 3,23
	subfic 29,22,1000
	bl strlen
	cmplw 0,29,3
	bc 4,1,.L626
	mr 4,23
	mr 3,21
	bl strcat
	mr 26,24
	mr 3,21
	bl strlen
	mr 22,3
.L626:
	addi 24,24,1
	cmpwi 0,24,15
	bc 12,1,.L625
	lwz 0,6536(1)
.L656:
	cmpw 0,24,0
	bc 12,0,.L628
	lwz 0,4(17)
	cmpw 0,24,0
	bc 12,0,.L628
.L625:
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
	bc 4,1,.L640
	lis 9,maxclients@ha
	lis 10,.LC129@ha
	lwz 11,maxclients@l(9)
	la 10,.LC129@l(10)
	li 24,0
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L640
	lis 9,game@ha
	lis 14,g_edicts@ha
	la 15,game@l(9)
	mr 23,21
	lis 16,0x4330
	li 19,0
	li 20,1076
.L644:
	lwz 0,g_edicts@l(14)
	lwz 11,1028(15)
	add 31,0,20
	lwz 9,88(31)
	add 30,11,19
	cmpwi 0,9,0
	bc 12,2,.L643
	lwz 0,248(31)
	cmpwi 0,0,0
	bc 4,2,.L643
	lwz 9,84(31)
	lwz 0,4048(9)
	cmpwi 0,0,0
	bc 4,2,.L643
	cmpwi 0,28,0
	bc 4,2,.L647
	lis 4,.LC125@ha
	mr 5,27
	addi 3,1,8
	la 4,.LC125@l(4)
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
.L647:
	addi 3,1,8
	subfic 29,22,1000
	mr 31,3
	bl strlen
	lwz 11,184(30)
	rlwinm 5,18,0,31,31
	lis 4,.LC126@ha
	cmpwi 4,5,0
	lwz 8,4032(30)
	la 4,.LC126@l(4)
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
	bc 4,1,.L651
	mr 4,31
	mr 3,23
	bl strcat
	mr 3,23
	bl strlen
	mr 22,3
.L651:
	mfcr 0
	rlwinm 0,0,19,1
	addi 9,27,8
	neg 0,0
	addi 18,18,1
	andc 9,9,0
	and 0,27,0
	or 27,0,9
.L643:
	lis 10,maxclients@ha
	addi 24,24,1
	lwz 11,maxclients@l(10)
	xoris 0,24,0x8000
	lis 10,.LC130@ha
	stw 0,6572(1)
	addi 19,19,4956
	la 10,.LC130@l(10)
	stw 16,6568(1)
	addi 20,20,1076
	lfd 12,0(10)
	lfd 0,6568(1)
	lfs 13,20(11)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L644
.L640:
	lwz 0,6536(1)
	subf 0,25,0
	cmpwi 0,0,1
	bc 4,1,.L654
	mr 3,21
	bl strlen
	lwz 6,6536(1)
	slwi 5,25,3
	lis 4,.LC127@ha
	la 4,.LC127@l(4)
	addi 5,5,50
	subf 6,25,6
	add 3,21,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L654:
	lwz 0,4(17)
	subf 0,26,0
	cmpwi 0,0,1
	bc 4,1,.L655
	mr 3,21
	bl strlen
	lwz 6,4(17)
	slwi 5,26,3
	lis 4,.LC128@ha
	la 4,.LC128@l(4)
	addi 5,5,50
	subf 6,26,6
	add 3,21,3
	addi 6,6,-1
	crxor 6,6,6
	bl sprintf
.L655:
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
.L601:
	lwz 0,6660(1)
	lwz 12,6580(1)
	mtlr 0
	lmw 14,6584(1)
	mtcrf 8,12
	la 1,6656(1)
	blr
.Lfe22:
	.size	 CTFScoreboardMessage,.Lfe22-CTFScoreboardMessage
	.section	".rodata"
	.align 2
.LC131:
	.string	"You already have a TECH powerup."
	.align 2
.LC132:
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
	bc 12,2,.L667
	lis 9,itemlist@ha
	lis 31,0x286b
	la 28,itemlist@l(9)
	mr 29,3
	lis 9,.LC132@ha
	ori 31,31,51739
	la 9,.LC132@l(9)
	lis 26,.LC131@ha
	lfs 31,0(9)
.L668:
	lwz 3,0(29)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L669
	subf 0,28,3
	lwz 10,84(30)
	mullw 0,0,31
	addi 11,10,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L669
	la 31,level@l(25)
	lfs 13,4784(10)
	lfs 0,4(31)
	fsubs 0,0,13
	fcmpu 0,0,31
	bc 4,1,.L671
	la 4,.LC131@l(26)
	mr 3,30
	crxor 6,6,6
	bl safe_centerprintf
	lfs 0,4(31)
	lwz 9,84(30)
	stfs 0,4784(9)
.L671:
	li 3,0
	b .L673
.L669:
	lwzu 0,4(29)
	cmpwi 0,0,0
	bc 4,2,.L668
.L667:
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
	stfs 0,4776(11)
.L673:
	lwz 0,52(1)
	mtlr 0
	lmw 25,12(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe23:
	.size	 CTFPickup_Tech,.Lfe23-CTFPickup_Tech
	.section	".rodata"
	.align 2
.LC133:
	.string	"info_player_deathmatch"
	.align 3
.LC134:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC135:
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
	bc 12,2,.L693
	lis 9,itemlist@ha
	lis 30,0x1b4e
	la 21,itemlist@l(9)
	lis 11,level@ha
	lis 9,TechThink@ha
	lis 27,0x286b
	la 23,TechThink@l(9)
	la 22,level@l(11)
	lis 9,.LC134@ha
	mr 24,3
	la 9,.LC134@l(9)
	ori 30,30,33205
	lfd 31,0(9)
	lis 25,0x4330
	li 26,0
	lis 9,.LC135@ha
	ori 27,27,51739
	la 9,.LC135@l(9)
	lfs 30,0(9)
.L694:
	lwz 3,0(24)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L695
	subf 0,21,3
	lwz 11,84(28)
	mullw 0,0,27
	addi 11,11,740
	rlwinm 31,0,0,0,29
	lwzx 9,11,31
	cmpwi 0,9,0
	bc 12,2,.L695
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
.L695:
	lwzu 0,4(24)
	cmpwi 0,0,0
	bc 4,2,.L694
.L693:
	lwz 0,100(1)
	mtlr 0
	lmw 21,36(1)
	lfd 30,80(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe24:
	.size	 CTFDeadDropTech,.Lfe24-CTFDeadDropTech
	.section	".rodata"
	.align 3
.LC136:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC137:
	.long 0x42c80000
	.align 2
.LC138:
	.long 0x41800000
	.align 2
.LC139:
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
	lis 7,.LC136@ha
	addi 3,1,40
	add 0,0,9
	la 7,.LC136@l(7)
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
	lis 9,.LC138@ha
	lis 7,.LC137@ha
	la 9,.LC138@l(9)
	la 7,.LC137@l(7)
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
	lis 7,.LC139@ha
	stw 0,384(29)
	lis 11,level+4@ha
	la 7,.LC139@l(7)
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
.Lfe25:
	.size	 SpawnTech,.Lfe25-SpawnTech
	.section	".sdata","aw"
	.align 2
	.type	 tech.164,@object
	.size	 tech.164,4
tech.164:
	.long 0
	.align 2
	.type	 tech.168,@object
	.size	 tech.168,4
tech.168:
	.long 0
	.align 2
	.type	 tech.172,@object
	.size	 tech.172,4
tech.172:
	.long 0
	.align 2
	.type	 tech.176,@object
	.size	 tech.176,4
tech.176:
	.long 0
	.align 2
	.type	 tech.180,@object
	.size	 tech.180,4
tech.180:
	.long 0
	.align 2
	.type	 tech.184,@object
	.size	 tech.184,4
tech.184:
	.long 0
	.section	".rodata"
	.align 3
.LC144:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC145:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl CTFApplyRegeneration
	.type	 CTFApplyRegeneration,@function
CTFApplyRegeneration:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 28,0
	lwz 30,84(29)
	cmpwi 0,30,0
	bc 12,2,.L740
	lis 31,tech.184@ha
	lwz 0,tech.184@l(31)
	cmpwi 0,0,0
	bc 4,2,.L749
	lis 3,.LC4@ha
	la 3,.LC4@l(3)
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,tech.184@l(31)
	bc 12,2,.L740
.L749:
	lwz 0,tech.184@l(31)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,0
	addi 10,30,740
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L740
	lis 9,level+4@ha
	lfs 0,4776(30)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L745
	stfs 13,4776(30)
	lwz 9,480(29)
	cmpwi 0,9,149
	bc 12,1,.L745
	addi 0,9,5
	cmpwi 0,0,150
	stw 0,480(29)
	bc 4,1,.L747
	li 0,150
	stw 0,480(29)
.L747:
	lfs 0,4776(30)
	lis 9,.LC144@ha
	li 28,1
	la 9,.LC144@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,4776(30)
.L745:
	cmpwi 0,28,0
	bc 12,2,.L740
	lwz 3,84(29)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,4780(3)
	fcmpu 0,0,13
	bc 4,0,.L740
	lis 9,.LC145@ha
	la 9,.LC145@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,4780(3)
.L740:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 CTFApplyRegeneration,.Lfe26-CTFApplyRegeneration
	.section	".sdata","aw"
	.align 2
	.type	 tech.188,@object
	.size	 tech.188,4
tech.188:
	.long 0
	.globl loc_names
	.section	".data"
	.align 2
	.type	 loc_names,@object
loc_names:
	.long .LC13
	.long 1
	.long .LC14
	.long 1
	.long .LC146
	.long 2
	.long .LC147
	.long 3
	.long .LC148
	.long 4
	.long .LC149
	.long 4
	.long .LC150
	.long 4
	.long .LC151
	.long 4
	.long .LC152
	.long 4
	.long .LC153
	.long 4
	.long .LC154
	.long 4
	.long .LC155
	.long 4
	.long .LC156
	.long 5
	.long .LC157
	.long 5
	.long .LC158
	.long 7
	.long .LC159
	.long 7
	.long .LC160
	.long 7
	.long .LC161
	.long 8
	.long .LC162
	.long 8
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC162:
	.string	"item_pack"
	.align 2
.LC161:
	.string	"item_bandolier"
	.align 2
.LC160:
	.string	"item_enviro"
	.align 2
.LC159:
	.string	"item_breather"
	.align 2
.LC158:
	.string	"item_silencer"
	.align 2
.LC157:
	.string	"item_power_shield"
	.align 2
.LC156:
	.string	"item_power_screen"
	.align 2
.LC155:
	.string	"weapon_shotgun"
	.align 2
.LC154:
	.string	"weapon_supershotgun"
	.align 2
.LC153:
	.string	"weapon_machinegun"
	.align 2
.LC152:
	.string	"weapon_grenadelauncher"
	.align 2
.LC151:
	.string	"weapon_chaingun"
	.align 2
.LC150:
	.string	"weapon_hyperblaster"
	.align 2
.LC149:
	.string	"weapon_rocketlauncher"
	.align 2
.LC148:
	.string	"weapon_railgun"
	.align 2
.LC147:
	.string	"weapon_bfg"
	.align 2
.LC146:
	.string	"item_invulnerability"
	.size	 loc_names,160
	.align 2
.LC164:
	.string	"nowhere"
	.align 2
.LC165:
	.string	"in the water "
	.align 2
.LC166:
	.string	"above "
	.align 2
.LC167:
	.string	"below "
	.align 2
.LC168:
	.string	"near "
	.align 2
.LC169:
	.string	"the red "
	.align 2
.LC170:
	.string	"the blue "
	.align 2
.LC171:
	.string	"the "
	.align 2
.LC163:
	.long 0x497423f0
	.align 2
.LC172:
	.long 0x44800000
	.align 3
.LC173:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC174:
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
	lis 11,.LC163@ha
	la 20,loc_names+4@l(9)
	lfs 31,.LC163@l(11)
	mr 27,3
	lis 9,.LC172@ha
	addi 17,20,-4
	la 9,.LC172@l(9)
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
.L754:
	cmpwi 0,30,0
	bc 4,2,.L757
	lwz 31,g_edicts@l(21)
	b .L758
.L805:
	mr 30,31
	b .L770
.L757:
	addi 31,30,1076
.L758:
	la 11,globals@l(15)
	lwz 9,g_edicts@l(21)
	lwz 0,72(11)
	mulli 0,0,1076
	add 9,9,0
	cmplw 0,31,9
	bc 4,0,.L771
	mr 24,11
	addi 28,31,188
	addi 30,31,200
	addi 29,31,4
.L761:
	lwz 0,-112(30)
	cmpwi 0,0,0
	bc 12,2,.L763
	li 0,3
	lis 9,.LC173@ha
	mtctr 0
	la 9,.LC173@l(9)
	mr 8,29
	lfd 10,0(9)
	mr 10,28
	mr 11,30
	li 9,0
.L807:
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
	bdnz .L807
	addi 3,1,24
	bl VectorLength
	fcmpu 0,1,30
	bc 4,1,.L805
.L763:
	lwz 9,72(24)
	addi 31,31,1076
	addi 28,28,1076
	lwz 0,g_edicts@l(21)
	addi 30,30,1076
	addi 29,29,1076
	mulli 9,9,1076
	add 0,0,9
	cmplw 0,31,0
	bc 12,0,.L761
.L771:
	li 30,0
.L770:
	cmpwi 0,30,0
	bc 12,2,.L755
	li 31,0
	b .L772
.L774:
	addi 31,31,1
.L772:
	slwi 28,31,3
	lwzx 4,17,28
	mr 29,28
	cmpwi 0,4,0
	bc 12,2,.L754
	lwz 3,280(30)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L774
	lwzx 0,17,29
	cmpwi 0,0,0
	bc 12,2,.L754
	mr 3,30
	mr 4,27
	bl loc_CanSee
	cmpwi 7,22,0
	addic 0,3,-1
	subfe 9,0,3
	mfcr 0
	rlwinm 0,0,31,1
	and. 11,9,0
	bc 12,2,.L779
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
	b .L754
.L779:
	cmpwi 4,3,0
	addic 0,22,-1
	subfe 9,0,22
	mfcr 0
	rlwinm 0,0,19,1
	and. 11,9,0
	bc 4,2,.L754
	bc 12,30,.L781
	lwzx 0,20,29
	cmpw 0,23,0
	bc 12,0,.L754
.L781:
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
	bc 12,0,.L783
	bc 12,18,.L754
	lwzx 0,20,28
	cmpw 0,0,23
	bc 4,0,.L754
.L783:
	mr 26,30
	fmr 31,1
	mr 4,27
	mr 3,26
	mr 23,31
	bl loc_CanSee
	mr 22,3
	b .L754
.L755:
	cmpwi 0,26,0
	bc 4,2,.L784
	b .L808
.L806:
	li 16,1
	b .L786
.L784:
	li 30,0
	lis 31,.LC13@ha
	lis 29,.LC14@ha
	b .L785
.L787:
	cmpw 0,30,26
	bc 12,2,.L785
	la 5,.LC13@l(31)
	li 3,0
	li 4,280
	bl G_Find
	mr. 31,3
	bc 12,2,.L786
	la 5,.LC14@l(29)
	li 3,0
	li 4,280
	bl G_Find
	mr. 30,3
	bc 12,2,.L786
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
	bc 12,0,.L806
	bc 4,1,.L786
	li 16,2
	b .L786
.L785:
	lwz 5,280(26)
	mr 3,30
	li 4,280
	bl G_Find
	mr. 30,3
	bc 4,2,.L787
.L786:
	lwz 3,280(26)
	bl FindItemByClassname
	mr. 31,3
	bc 4,2,.L794
.L808:
	lis 9,.LC164@ha
	la 11,.LC164@l(9)
	lwz 0,.LC164@l(9)
	lwz 10,4(11)
	stw 0,0(25)
	stw 10,4(25)
	b .L753
.L794:
	lwz 0,612(27)
	cmpwi 0,0,0
	bc 12,2,.L795
	lis 11,.LC165@ha
	lwz 10,.LC165@l(11)
	la 9,.LC165@l(11)
	lhz 8,12(9)
	lwz 0,4(9)
	lwz 11,8(9)
	stw 10,0(25)
	stw 0,4(25)
	stw 11,8(25)
	sth 8,12(25)
	b .L796
.L795:
	stb 0,0(25)
.L796:
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
	bc 4,1,.L797
	fmr 0,10
	fabs 0,0
	fcmpu 0,12,0
	bc 4,1,.L797
	lis 9,.LC174@ha
	la 9,.LC174@l(9)
	lfs 0,0(9)
	fcmpu 0,11,0
	bc 4,1,.L798
	lis 4,.LC166@ha
	mr 3,25
	la 4,.LC166@l(4)
	bl strcat
	b .L800
.L798:
	lis 4,.LC167@ha
	mr 3,25
	la 4,.LC167@l(4)
	bl strcat
	b .L800
.L797:
	lis 4,.LC168@ha
	mr 3,25
	la 4,.LC168@l(4)
	bl strcat
.L800:
	cmpwi 0,16,1
	bc 4,2,.L801
	lis 4,.LC169@ha
	mr 3,25
	la 4,.LC169@l(4)
	bl strcat
	b .L802
.L801:
	cmpwi 0,16,2
	bc 4,2,.L803
	lis 4,.LC170@ha
	mr 3,25
	la 4,.LC170@l(4)
	bl strcat
	b .L802
.L803:
	lis 4,.LC171@ha
	mr 3,25
	la 4,.LC171@l(4)
	bl strcat
.L802:
	lwz 4,40(31)
	mr 3,25
	bl strcat
.L753:
	lwz 0,132(1)
	lwz 12,40(1)
	mtlr 0
	lmw 15,44(1)
	lfd 30,112(1)
	lfd 31,120(1)
	mtcrf 8,12
	la 1,128(1)
	blr
.Lfe27:
	.size	 CTFSay_Team_Location,.Lfe27-CTFSay_Team_Location
	.section	".rodata"
	.align 2
.LC175:
	.string	"dead"
	.align 2
.LC176:
	.string	"%i health"
	.align 2
.LC177:
	.string	"the %s"
	.align 2
.LC178:
	.string	"no powerup"
	.align 2
.LC179:
	.string	"none"
	.align 2
.LC180:
	.string	", "
	.align 2
.LC181:
	.string	" and "
	.align 2
.LC182:
	.string	"no one"
	.align 2
.LC183:
	.long 0x3f800000
	.align 3
.LC184:
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
	lis 9,.LC183@ha
	stb 27,1032(1)
	li 24,1
	la 9,.LC183@l(9)
	stb 27,8(1)
	lis 19,maxclients@ha
	lfs 13,0(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L823
	lis 11,.LC184@ha
	lis 20,g_edicts@ha
	la 11,.LC184@l(11)
	lis 21,.LC180@ha
	lfd 31,0(11)
	lis 22,0x4330
	li 25,1076
.L825:
	lwz 0,g_edicts@l(20)
	add 30,0,25
	lwz 9,88(30)
	xor 0,30,26
	subfic 11,0,0
	adde 0,11,0
	subfic 11,9,0
	adde 9,11,9
	or. 28,9,0
	bc 4,2,.L824
	mr 3,30
	mr 4,26
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L824
	lbz 0,1032(1)
	addi 31,1,1032
	cmpwi 0,0,0
	bc 12,2,.L828
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,3
	cmplwi 0,29,1023
	bc 12,1,.L829
	cmpwi 0,27,0
	bc 12,2,.L830
	addi 3,1,8
	la 4,.LC180@l(21)
	bl strcat
.L830:
	addi 3,1,8
	mr 4,31
	bl strcat
	stb 28,1032(1)
.L829:
	addi 27,27,1
.L828:
	lwz 4,84(30)
	mr 3,31
	addi 4,4,700
	bl strcpy
.L824:
	addi 24,24,1
	lwz 11,maxclients@l(19)
	xoris 0,24,0x8000
	addi 25,25,1076
	stw 0,2076(1)
	stw 22,2072(1)
	lfd 0,2072(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L825
.L823:
	lbz 0,1032(1)
	cmpwi 0,0,0
	bc 12,2,.L832
	addi 31,1,1032
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	addi 29,29,6
	cmplwi 0,29,1023
	bc 12,1,.L833
	cmpwi 0,27,0
	bc 12,2,.L834
	lis 4,.LC181@ha
	addi 3,1,8
	la 4,.LC181@l(4)
	bl strcat
.L834:
	mr 4,31
	addi 3,1,8
	bl strcat
.L833:
	mr 3,23
	addi 4,1,8
	bl strcpy
	b .L835
.L832:
	lis 9,.LC182@ha
	lwz 10,.LC182@l(9)
	la 11,.LC182@l(9)
	lbz 0,6(11)
	lhz 9,4(11)
	stb 0,6(23)
	stw 10,0(23)
	sth 9,4(23)
.L835:
	lwz 0,2148(1)
	mtlr 0
	lmw 19,2084(1)
	lfd 31,2136(1)
	la 1,2144(1)
	blr
.Lfe28:
	.size	 CTFSay_Team_Sight,.Lfe28-CTFSay_Team_Sight
	.section	".rodata"
	.align 2
.LC185:
	.string	"(%s): %s\n"
	.align 2
.LC186:
	.long 0x0
	.align 3
.LC187:
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
	mr 25,3
	lbz 0,0(30)
	cmpwi 0,0,34
	bc 4,2,.L837
	mr 3,30
	bl strlen
	add 3,3,30
	stb 31,-1(3)
	addi 30,30,1
.L837:
	lbz 9,0(30)
	addi 31,1,8
	lis 23,maxclients@ha
	mr 24,31
	cmpwi 0,9,0
	bc 12,2,.L839
.L841:
	cmpwi 0,9,37
	bc 4,2,.L843
	lbzu 9,1(30)
	addi 9,9,-72
	cmplwi 0,9,47
	bc 12,1,.L868
	lis 11,.L869@ha
	slwi 10,9,2
	la 11,.L869@l(11)
	lis 9,.L869@ha
	lwzx 0,10,11
	la 9,.L869@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L869:
	.long .L849-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L846-.L869
	.long .L868-.L869
	.long .L867-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L854-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L862-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L849-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L849-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L846-.L869
	.long .L868-.L869
	.long .L867-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L854-.L869
	.long .L868-.L869
	.long .L868-.L869
	.long .L862-.L869
.L846:
	addi 29,1,1032
	mr 3,25
	mr 4,29
	addi 30,30,1
	bl CTFSay_Team_Location
	b .L880
.L849:
	lwz 5,480(25)
	cmpwi 0,5,0
	bc 12,1,.L850
	lis 9,.LC175@ha
	la 11,.LC175@l(9)
	lwz 0,.LC175@l(9)
	lbz 10,4(11)
	stw 0,1032(1)
	stb 10,1036(1)
	b .L852
.L850:
	lis 4,.LC176@ha
	addi 3,1,1032
	la 4,.LC176@l(4)
	crxor 6,6,6
	bl sprintf
.L852:
	addi 29,1,1032
	mr 3,31
	mr 4,29
	addi 30,30,1
	b .L881
.L879:
	lwz 5,40(3)
	lis 4,.LC177@ha
	addi 3,1,1032
	la 4,.LC177@l(4)
	crxor 6,6,6
	bl sprintf
	b .L859
.L854:
	lis 9,tnames@ha
	addi 30,30,1
	la 3,tnames@l(9)
	addi 26,1,1032
	lwz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L860
	lis 9,itemlist@ha
	lis 29,0x286b
	la 27,itemlist@l(9)
	mr 28,3
	ori 29,29,51739
.L857:
	lwz 3,0(28)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L858
	subf 0,27,3
	lwz 11,84(25)
	mullw 0,0,29
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L879
.L858:
	lwzu 0,4(28)
	cmpwi 0,0,0
	bc 4,2,.L857
.L860:
	lis 9,.LC178@ha
	la 11,.LC178@l(9)
	lwz 10,.LC178@l(9)
	lbz 8,10(11)
	lwz 0,4(11)
	lhz 9,8(11)
	stw 10,1032(1)
	stw 0,1036(1)
	sth 9,1040(1)
	stb 8,1042(1)
.L859:
	mr 3,31
	mr 4,26
	bl strcpy
	mr 3,26
	b .L882
.L862:
	lwz 9,84(25)
	lwz 9,1764(9)
	cmpwi 0,9,0
	bc 12,2,.L863
	lwz 4,40(9)
	addi 3,1,1032
	bl strcpy
	b .L865
.L863:
	lis 9,.LC179@ha
	la 11,.LC179@l(9)
	lwz 0,.LC179@l(9)
	lbz 10,4(11)
	stw 0,1032(1)
	stb 10,1036(1)
.L865:
	addi 29,1,1032
	mr 3,31
	mr 4,29
	addi 30,30,1
	b .L881
.L867:
	addi 29,1,1032
	mr 3,25
	mr 4,29
	addi 30,30,1
	bl CTFSay_Team_Sight
.L880:
	mr 3,31
	mr 4,29
.L881:
	bl strcpy
	mr 3,29
.L882:
	bl strlen
	add 31,31,3
	b .L840
.L868:
	lbz 0,0(30)
	addi 30,30,1
	stb 0,0(31)
	b .L883
.L843:
	stb 9,0(31)
	addi 30,30,1
.L883:
	addi 31,31,1
.L840:
	lbz 9,0(30)
	cmpwi 0,9,0
	bc 12,2,.L839
	subf 0,24,31
	cmplwi 0,0,1022
	bc 4,1,.L841
.L839:
	lis 9,maxclients@ha
	li 0,0
	lwz 11,maxclients@l(9)
	li 30,0
	lis 9,.LC186@ha
	stb 0,0(31)
	la 9,.LC186@l(9)
	lfs 0,20(11)
	lfs 13,0(9)
	fcmpu 0,13,0
	bc 4,0,.L873
	lis 9,.LC187@ha
	lis 27,g_edicts@ha
	la 9,.LC187@l(9)
	lis 28,.LC185@ha
	lfd 31,0(9)
	lis 29,0x4330
	li 31,1076
.L875:
	lwz 0,g_edicts@l(27)
	add 3,0,31
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L874
	lwz 9,84(3)
	lwz 6,84(25)
	lwz 11,4048(9)
	lwz 0,4048(6)
	cmpw 0,11,0
	bc 4,2,.L874
	addi 6,6,700
	li 4,3
	la 5,.LC185@l(28)
	addi 7,1,8
	crxor 6,6,6
	bl safe_cprintf
.L874:
	addi 30,30,1
	lwz 11,maxclients@l(23)
	xoris 0,30,0x8000
	addi 31,31,1076
	stw 0,2076(1)
	stw 29,2072(1)
	lfd 0,2072(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L875
.L873:
	lwz 0,2132(1)
	mtlr 0
	lmw 23,2084(1)
	lfd 31,2120(1)
	la 1,2128(1)
	blr
.Lfe29:
	.size	 CTFSay_Team,.Lfe29-CTFSay_Team
	.section	".rodata"
	.align 2
.LC189:
	.string	"models/ctf/banner/tris.md2"
	.align 2
.LC191:
	.string	"models/ctf/banner/small.md2"
	.globl creditsmenu
	.section	".data"
	.align 2
	.type	 creditsmenu,@object
creditsmenu:
	.long .LC193
	.long 1
	.long 0
	.long 0
	.long .LC194
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC195
	.long 1
	.long 0
	.long 0
	.long .LC196
	.long 1
	.long 0
	.long 0
	.long .LC197
	.long 1
	.long 0
	.long 0
	.long .LC198
	.long 1
	.long 0
	.long 0
	.long .LC199
	.long 1
	.long 0
	.long 0
	.long .LC196
	.long 1
	.long 0
	.long 0
	.long .LC200
	.long 1
	.long 0
	.long 0
	.long .LC201
	.long 1
	.long 0
	.long 0
	.long .LC202
	.long 1
	.long 0
	.long 0
	.long .LC203
	.long 1
	.long 0
	.long 0
	.long .LC204
	.long 1
	.long 0
	.long 0
	.long .LC205
	.long 1
	.long 0
	.long 0
	.long .LC206
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC207
	.long 0
	.long 0
	.long CTFReturnToMain
	.section	".rodata"
	.align 2
.LC207:
	.string	"Return to Main Menu"
	.align 2
.LC206:
	.string	"Brian 'Whaleboy' Cozzens"
	.align 2
.LC205:
	.string	"*Original CTF Art Design"
	.align 2
.LC204:
	.string	"Tom 'Bjorn' Klok"
	.align 2
.LC203:
	.string	"*Sound"
	.align 2
.LC202:
	.string	"Kevin Cloud"
	.align 2
.LC201:
	.string	"Adrian Carmack Paul Steed"
	.align 2
.LC200:
	.string	"*Art"
	.align 2
.LC199:
	.string	"Tim Willits"
	.align 2
.LC198:
	.string	"Christian Antkow"
	.align 2
.LC197:
	.string	"*Level Design"
	.align 2
.LC196:
	.string	"Dave 'Zoid' Kirsch"
	.align 2
.LC195:
	.string	"*Programming"
	.align 2
.LC194:
	.string	"*ThreeWave Capture the Flag"
	.align 2
.LC193:
	.string	"*Quake II"
	.size	 creditsmenu,288
	.globl joinmenu
	.section	".data"
	.align 2
	.type	 joinmenu,@object
joinmenu:
	.long .LC208
	.long 1
	.long 0
	.long 0
	.long .LC209
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
	.long .LC210
	.long 0
	.long 0
	.long CTFJoinTeam1
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC211
	.long 0
	.long 0
	.long CTFJoinTeam2
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC212
	.long 0
	.long 0
	.long CTFChaseCam
	.long .LC213
	.long 0
	.long 0
	.long CTFCredits
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC214
	.long 0
	.long 0
	.long 0
	.long .LC215
	.long 0
	.long 0
	.long 0
	.long .LC216
	.long 0
	.long 0
	.long 0
	.long .LC217
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC218
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC218:
	.string	"v1.0"
	.align 2
.LC217:
	.string	"(TAB to Return)"
	.align 2
.LC216:
	.string	"ESC to Exit Menu"
	.align 2
.LC215:
	.string	"ENTER to select"
	.align 2
.LC214:
	.string	"Use [ and ] to move cursor"
	.align 2
.LC213:
	.string	"Credits"
	.align 2
.LC212:
	.string	"Chase Camera"
	.align 2
.LC211:
	.string	"Join Dark Side"
	.align 2
.LC210:
	.string	"Join Light Side"
	.align 2
.LC209:
	.string	"*Capture The Office Chair"
	.align 2
.LC208:
	.string	"*Star Wars Quake2"
	.size	 joinmenu,272
	.lcomm	levelname.237,32,4
	.lcomm	team1players.238,32,4
	.lcomm	team2players.239,32,4
	.align 2
.LC219:
	.string	"Join Red Team"
	.align 2
.LC220:
	.string	"Join Blue Team"
	.align 2
.LC221:
	.string	"Leave Chase Camera"
	.align 2
.LC222:
	.string	"  (%d players)"
	.align 2
.LC223:
	.long 0x0
	.align 3
.LC224:
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
	lis 9,ctf@ha
	lis 4,.LC223@ha
	lwz 11,ctf@l(9)
	la 4,.LC223@l(4)
	mr 30,3
	lfs 13,0(4)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L924
	li 3,0
	b .L951
.L924:
	lis 9,joinmenu@ha
	lis 8,.LC219@ha
	la 29,joinmenu@l(9)
	lis 11,CTFJoinTeam1@ha
	lis 9,.LC220@ha
	lis 10,CTFJoinTeam2@ha
	lis 31,ctf_forcejoin@ha
	la 8,.LC219@l(8)
	lwz 7,ctf_forcejoin@l(31)
	la 11,CTFJoinTeam1@l(11)
	la 9,.LC220@l(9)
	la 10,CTFJoinTeam2@l(10)
	stw 8,64(29)
	stw 11,76(29)
	stw 9,96(29)
	stw 10,108(29)
	lwz 3,4(7)
	cmpwi 0,3,0
	bc 12,2,.L925
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 12,2,.L925
	lis 4,.LC112@ha
	la 4,.LC112@l(4)
	bl stricmp
	mr. 3,3
	bc 4,2,.L926
	stw 3,108(29)
	stw 3,96(29)
	b .L925
.L926:
	lwz 9,ctf_forcejoin@l(31)
	lis 4,.LC113@ha
	la 4,.LC113@l(4)
	lwz 3,4(9)
	bl stricmp
	mr. 3,3
	bc 4,2,.L925
	stw 3,76(29)
	stw 3,64(29)
.L925:
	lwz 9,84(30)
	lwz 0,4408(9)
	cmpwi 0,0,0
	bc 12,2,.L929
	lis 9,.LC221@ha
	lis 11,joinmenu+128@ha
	la 9,.LC221@l(9)
	b .L952
.L929:
	lis 9,.LC212@ha
	lis 11,joinmenu+128@ha
	la 9,.LC212@l(9)
.L952:
	stw 9,joinmenu+128@l(11)
	lis 9,g_edicts@ha
	lis 11,levelname.237@ha
	lwz 10,g_edicts@l(9)
	li 0,42
	la 3,levelname.237@l(11)
	stb 0,levelname.237@l(11)
	lwz 4,276(10)
	cmpwi 0,4,0
	bc 12,2,.L931
	addi 3,3,1
	li 5,30
	bl strncpy
	b .L932
.L931:
	lis 4,level+72@ha
	addi 3,3,1
	la 4,level+72@l(4)
	li 5,30
	bl strncpy
.L932:
	lis 9,maxclients@ha
	lis 11,levelname.237+31@ha
	lwz 10,maxclients@l(9)
	li 0,0
	lis 4,.LC223@ha
	la 4,.LC223@l(4)
	stb 0,levelname.237+31@l(11)
	li 31,0
	lfs 0,0(4)
	li 30,0
	li 7,0
	lfs 13,20(10)
	fcmpu 0,0,13
	bc 4,0,.L934
	lis 9,g_edicts@ha
	fmr 12,13
	lis 11,game@ha
	lwz 10,g_edicts@l(9)
	la 5,game@l(11)
	lis 6,0x4330
	lis 9,.LC224@ha
	li 8,0
	la 9,.LC224@l(9)
	addi 10,10,1164
	lfd 13,0(9)
.L936:
	lwz 0,0(10)
	addi 10,10,1076
	cmpwi 0,0,0
	bc 12,2,.L935
	lwz 9,1028(5)
	add 9,8,9
	lwz 11,4048(9)
	cmpwi 0,11,1
	bc 4,2,.L938
	addi 30,30,1
	b .L935
.L938:
	xori 11,11,2
	addi 9,31,1
	srawi 4,11,31
	xor 0,4,11
	subf 0,0,4
	srawi 0,0,31
	andc 9,9,0
	and 0,31,0
	or 31,0,9
.L935:
	addi 7,7,1
	xoris 0,7,0x8000
	addi 8,8,4956
	stw 0,28(1)
	stw 6,24(1)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L936
.L934:
	lis 29,.LC222@ha
	lis 3,team1players.238@ha
	la 4,.LC222@l(29)
	mr 5,30
	la 3,team1players.238@l(3)
	crxor 6,6,6
	bl sprintf
	lis 3,team2players.239@ha
	la 4,.LC222@l(29)
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
	bc 12,2,.L942
	lis 9,team1players.238@ha
	la 9,team1players.238@l(9)
	stw 9,80(11)
	b .L943
.L942:
	stw 0,80(11)
.L943:
	lis 9,joinmenu@ha
	la 11,joinmenu@l(9)
	lwz 0,96(11)
	cmpwi 0,0,0
	bc 12,2,.L944
	lis 9,team2players.239@ha
	la 9,team2players.239@l(9)
	stw 9,112(11)
	b .L945
.L944:
	stw 0,112(11)
.L945:
	cmpw 0,30,31
	bc 12,1,.L953
	cmpw 0,31,30
	bc 4,1,.L947
.L953:
	li 3,1
	b .L951
.L947:
	bl rand
	andi. 0,3,1
	mfcr 3
	rlwinm 3,3,3,1
	neg 3,3
	addi 0,3,1
	rlwinm 3,3,0,30,30
	or 3,3,0
.L951:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe30:
	.size	 CTFUpdateJoinMenu,.Lfe30-CTFUpdateJoinMenu
	.section	".rodata"
	.align 2
.LC225:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFStartClient
	.type	 CTFStartClient,@function
CTFStartClient:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	lis 9,.LC225@ha
	lis 30,ctf@ha
	la 9,.LC225@l(9)
	mr 31,3
	lfs 31,0(9)
	lwz 9,ctf@l(30)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L965
	lwz 8,84(31)
	lwz 0,4048(8)
	cmpwi 0,0,0
	bc 4,2,.L965
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andis. 10,11,0x2
	bc 4,2,.L965
	lwz 0,184(31)
	li 9,1
	lis 11,gi+72@ha
	stw 9,260(31)
	mr 3,31
	ori 0,0,1
	stw 10,248(31)
	stw 0,184(31)
	stw 10,4048(8)
	lwz 9,84(31)
	stw 10,88(9)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 9,ctf@l(30)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L967
	mr 3,31
	bl CTFUpdateJoinMenu
	lwz 9,84(31)
	mr 5,3
	lwz 0,4408(9)
	cmpwi 0,0,0
	bc 12,2,.L968
	li 5,8
	b .L969
.L968:
	xori 9,5,1
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	rlwinm 0,0,0,29,30
	ori 5,0,4
.L969:
	lis 4,joinmenu@ha
	mr 3,31
	la 4,joinmenu@l(4)
	li 6,17
	bl PMenu_Open
.L967:
	li 3,1
	b .L972
.L965:
	li 3,0
.L972:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe31:
	.size	 CTFStartClient,.Lfe31-CTFStartClient
	.section	".rodata"
	.align 2
.LC226:
	.string	"Capturelimit hit.\n"
	.align 2
.LC227:
	.string	"Couldn't find destination\n"
	.align 2
.LC228:
	.long 0x47800000
	.align 2
.LC229:
	.long 0x43b40000
	.align 2
.LC230:
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
	bc 12,2,.L977
	lwz 5,296(29)
	li 3,0
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L979
	lis 9,gi+4@ha
	lis 3,.LC227@ha
	lwz 0,gi+4@l(9)
	la 3,.LC227@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L977
.L979:
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 12,2,.L981
	lwz 3,4764(3)
	cmpwi 0,3,0
	bc 12,2,.L981
	bl CTFResetGrapple
.L981:
	lis 9,gi+76@ha
	mr 3,31
	lwz 0,gi+76@l(9)
	addi 28,31,376
	mtlr 0
	blrl
	lfs 0,4(30)
	lis 9,.LC228@ha
	lis 11,.LC229@ha
	la 9,.LC228@l(9)
	la 11,.LC229@l(11)
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
.L988:
	lwz 10,84(31)
	add 0,6,6
	lfsx 0,7,5
	addi 6,6,1
	addi 9,10,4036
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
	bdnz .L988
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
	stfs 0,4252(9)
	lfs 0,20(30)
	lwz 11,84(31)
	stfs 0,4256(11)
	lfs 13,24(30)
	lwz 9,84(31)
	stfs 13,4260(9)
	lwz 3,84(31)
	addi 3,3,4252
	bl AngleVectors
	lis 9,.LC230@ha
	addi 3,1,8
	la 9,.LC230@l(9)
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
.L977:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe32:
	.size	 old_teleporter_touch,.Lfe32-old_teleporter_touch
	.section	".rodata"
	.align 2
.LC231:
	.string	"teleporter without a target.\n"
	.align 2
.LC232:
	.string	"world/amb_ionus_light_hum2_loop.wav"
	.align 2
.LC233:
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
	bc 4,2,.L990
	lis 9,gi+4@ha
	lis 3,.LC231@ha
	lwz 0,gi+4@l(9)
	la 3,.LC231@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L989
.L990:
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
	lis 9,.LC233@ha
	mtctr 0
	la 9,.LC233@l(9)
	mr 30,3
	lfs 12,0(9)
	addi 8,31,200
	addi 10,31,188
	stw 30,540(31)
	addi 11,30,4
	li 9,0
.L996:
	lfsx 13,9,10
	lfsx 0,9,8
	addi 9,9,4
	fsubs 0,0,13
	fmadds 0,0,12,13
	stfs 0,0(11)
	addi 11,11,4
	bdnz .L996
	lis 29,gi@ha
	lis 3,.LC232@ha
	la 29,gi@l(29)
	la 3,.LC232@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	stw 3,76(30)
	lwz 0,72(29)
	mr 3,30
	mtlr 0
	blrl
.L989:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe33:
	.size	 SP_trigger_teleport,.Lfe33-SP_trigger_teleport
	.section	".rodata"
	.align 3
.LC234:
	.long 0x3f847ae1
	.long 0x47ae147b
	.align 2
.LC235:
	.long 0x46fffe00
	.align 3
.LC236:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC237:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC238:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl Critter_Panic
	.type	 Critter_Panic,@function
Critter_Panic:
	stwu 1,-80(1)
	mflr 0
	stfd 29,56(1)
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 29,44(1)
	stw 0,84(1)
	mr 31,3
	lis 9,.LC234@ha
	lwz 10,56(31)
	lis 11,level+4@ha
	lfd 13,.LC234@l(9)
	addi 9,10,1
	stw 9,56(31)
	cmpwi 0,9,33
	lfs 0,level+4@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 4,2,.L999
	bl Set_Panic
	b .L1000
.L999:
	cmpwi 0,9,41
	bc 12,2,.L1022
	cmpwi 0,9,53
	bc 12,2,.L1022
	addi 0,10,-41
	cmplwi 0,0,10
	bc 12,1,.L1005
	bl rand
	lis 29,0x4330
	lis 9,.LC236@ha
	rlwinm 3,3,0,17,31
	la 9,.LC236@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC235@ha
	lis 10,.LC237@ha
	lfs 30,.LC235@l(11)
	la 10,.LC237@l(10)
	stw 3,36(1)
	stw 29,32(1)
	lfd 0,32(1)
	lfd 12,0(10)
	lis 10,.LC238@ha
	fsub 0,0,31
	la 10,.LC238@l(10)
	lfs 29,0(10)
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fsub 13,13,12
	frsp 13,13
	stfs 13,20(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,36(1)
	stw 29,32(1)
	lfd 0,32(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,29
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,36(1)
	stw 29,32(1)
	lfd 0,32(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmuls 0,0,29
	stfs 0,12(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,8(1)
	xoris 3,3,0x8000
	lfs 13,12(1)
	stw 3,36(1)
	stw 29,32(1)
	lfd 0,32(1)
	lfs 9,376(31)
	lfs 10,380(31)
	fsub 0,0,31
	lfs 11,384(31)
	fadds 12,12,9
	fadds 13,13,10
	frsp 0,0
	stfs 12,376(31)
	stfs 13,380(31)
	fdivs 0,0,30
	fmuls 0,0,29
	b .L1023
.L1005:
	cmpwi 0,9,59
	bc 12,2,.L1022
	addi 0,10,-53
	cmplwi 0,0,4
	bc 12,1,.L1009
	bl rand
	lis 29,0x4330
	lis 9,.LC236@ha
	rlwinm 3,3,0,17,31
	la 9,.LC236@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC235@ha
	lis 10,.LC237@ha
	lfs 30,.LC235@l(11)
	la 10,.LC237@l(10)
	stw 3,36(1)
	stw 29,32(1)
	lfd 0,32(1)
	lfd 12,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fsub 13,13,12
	frsp 13,13
	stfs 13,20(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,36(1)
	stw 29,32(1)
	lfd 0,32(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,36(1)
	stw 29,32(1)
	lfd 0,32(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	stfs 0,12(1)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,8(1)
	xoris 3,3,0x8000
	lfs 13,12(1)
	stw 3,36(1)
	stw 29,32(1)
	lfd 0,32(1)
	lfs 9,376(31)
	lfs 10,380(31)
	fsub 0,0,31
	lfs 11,384(31)
	fadds 12,12,9
	fadds 13,13,10
	frsp 0,0
	stfs 12,376(31)
	stfs 13,380(31)
	fdivs 0,0,30
.L1023:
	fadds 11,0,11
	stfs 0,16(1)
	stfs 11,384(31)
	b .L1000
.L1009:
	cmpwi 0,9,65
	bc 12,2,.L1022
	cmpwi 0,9,69
	bc 12,2,.L1022
	addi 0,10,-69
	cmplwi 0,0,5
	bc 12,1,.L1015
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L1000
	li 0,76
	stw 0,56(31)
	b .L1000
.L1015:
	cmpwi 0,9,87
	bc 4,2,.L1019
.L1022:
	mr 3,31
	bl Set_Panic
	b .L1000
.L1019:
	lwz 0,56(31)
	cmpwi 0,0,97
	bc 4,2,.L1000
	mr 3,31
	bl Set_Panic
.L1000:
	lwz 0,84(1)
	mtlr 0
	lmw 29,44(1)
	lfd 29,56(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe34:
	.size	 Critter_Panic,.Lfe34-Critter_Panic
	.section	".rodata"
	.align 2
.LC239:
	.long 0x46fffe00
	.align 3
.LC240:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 3
.LC241:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC242:
	.long 0x3fe66666
	.long 0x66666666
	.align 3
.LC243:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC244:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Set_Panic
	.type	 Set_Panic,@function
Set_Panic:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	bl rand
	lis 9,.LC243@ha
	rlwinm 3,3,0,17,31
	lwz 0,284(31)
	la 9,.LC243@l(9)
	xoris 3,3,0x8000
	lfd 10,0(9)
	lis 8,0x4330
	lis 11,.LC239@ha
	lfs 11,.LC239@l(11)
	andis. 7,0,0x1
	stw 3,20(1)
	mr 10,9
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,10
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,16(1)
	lwz 0,20(1)
	bc 4,2,.L1025
	xoris 0,0,0x8000
	lis 11,.LC240@ha
	stw 0,20(1)
	stw 8,16(1)
	lfd 13,16(1)
	lfd 0,.LC240@l(11)
	fsub 13,13,10
	fcmpu 0,13,0
	bc 4,1,.L1026
	li 0,33
	b .L1037
.L1026:
	lis 9,.LC241@ha
	lfd 0,.LC241@l(9)
	fcmpu 0,13,0
	bc 4,1,.L1028
	li 0,59
	b .L1037
.L1028:
	lis 9,.LC242@ha
	lfd 0,.LC242@l(9)
	fcmpu 0,13,0
	bc 4,1,.L1030
	li 0,87
	b .L1037
.L1030:
	stw 7,56(31)
	b .L1032
.L1025:
	xoris 0,0,0x8000
	stw 0,20(1)
	lis 11,.LC241@ha
	stw 8,16(1)
	lfd 13,16(1)
	lfd 0,.LC241@l(11)
	fsub 13,13,10
	fcmpu 0,13,0
	bc 4,1,.L1033
	li 0,33
	b .L1037
.L1033:
	lis 9,.LC244@ha
	la 9,.LC244@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	li 0,53
	bc 4,1,.L1035
	li 0,41
.L1035:
.L1037:
	stw 0,56(31)
.L1032:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 Set_Panic,.Lfe35-Set_Panic
	.section	".rodata"
	.align 2
.LC246:
	.string	"jawa/j_cry1.wav"
	.align 2
.LC247:
	.string	"jawa/j_cry2.wav"
	.comm	node_count,2,2
	.comm	path_not_time_yet,4,4
	.comm	ctf_forcejoin,4,4
	.comm	ctf,4,4
	.comm	conversation_content,7760,4
	.comm	highlighted,4,4
	.comm	yeah_you,4,4
	.comm	its_me,4,4
	.comm	holdthephone,4,4
	.comm	NoTouch,4,4
	.comm	showingit,4,4
	.comm	path_time,4,4
	.comm	print_time,4,4
	.section	".text"
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
	bc 12,2,.L112
	cmpwi 0,3,2
	bc 12,2,.L113
	b .L111
.L112:
	lis 3,.LC16@ha
	la 3,.LC16@l(3)
	blr
.L113:
	lis 3,.LC17@ha
	la 3,.LC17@l(3)
	blr
.L111:
	lis 3,.LC18@ha
	la 3,.LC18@l(3)
	blr
.Lfe38:
	.size	 CTFTeamName,.Lfe38-CTFTeamName
	.align 2
	.globl CTFOtherTeamName
	.type	 CTFOtherTeamName,@function
CTFOtherTeamName:
	cmpwi 0,3,1
	bc 12,2,.L118
	cmpwi 0,3,2
	bc 12,2,.L119
	b .L117
.L118:
	lis 3,.LC17@ha
	la 3,.LC17@l(3)
	blr
.L119:
	lis 3,.LC16@ha
	la 3,.LC16@l(3)
	blr
.L117:
	lis 3,.LC18@ha
	la 3,.LC18@l(3)
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
	bc 12,2,.L412
	lis 5,.LC60@ha
	mr 3,31
	la 5,.LC60@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L413
.L412:
	lis 5,.LC61@ha
	mr 3,31
	la 5,.LC61@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L413:
	li 3,0
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe40:
	.size	 CTFDrop_Flag,.Lfe40-CTFDrop_Flag
	.section	".rodata"
	.align 2
.LC248:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFEffects
	.type	 CTFEffects,@function
CTFEffects:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC248@ha
	lis 9,ctf@ha
	la 11,.LC248@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L419
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
	bc 12,2,.L421
	lis 9,gi+32@ha
	lis 3,.LC69@ha
	lwz 0,gi+32@l(9)
	la 3,.LC69@l(3)
	b .L1045
.L421:
	lis 9,flag2_item@ha
	lwz 0,flag2_item@l(9)
	subf 0,8,0
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 10,10,0
	cmpwi 0,10,0
	bc 12,2,.L423
	lis 9,gi+32@ha
	lis 3,.LC70@ha
	lwz 0,gi+32@l(9)
	la 3,.LC70@l(3)
.L1045:
	mtlr 0
	blrl
	stw 3,48(31)
	b .L419
.L423:
	stw 10,48(31)
.L419:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe41:
	.size	 CTFEffects,.Lfe41-CTFEffects
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
	lwz 0,4072(9)
	cmpwi 0,0,0
	bc 12,2,.L437
	lis 5,.LC73@ha
	la 5,.LC73@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,0
	b .L1046
.L437:
	lis 5,.LC74@ha
	mr 3,31
	la 5,.LC74@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 9,84(31)
	li 0,1
.L1046:
	stw 0,4072(9)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe42:
	.size	 CTFID_f,.Lfe42-CTFID_f
	.section	".rodata"
	.align 2
.LC249:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFResetFlag
	.type	 CTFResetFlag,@function
CTFResetFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,.LC249@ha
	lis 9,ctf@ha
	la 11,.LC249@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L255
	cmpwi 0,3,1
	bc 12,2,.L258
	cmpwi 0,3,2
	bc 12,2,.L259
	b .L255
.L258:
	lis 9,.LC13@ha
	la 29,.LC13@l(9)
	b .L257
.L259:
	lis 9,.LC14@ha
	la 29,.LC14@l(9)
.L257:
	lis 9,gi@ha
	li 31,0
	la 28,gi@l(9)
	li 30,1
	b .L262
.L264:
	lwz 0,284(31)
	andis. 9,0,1
	bc 12,2,.L265
	mr 3,31
	bl G_FreeEdict
	b .L262
.L265:
	lwz 0,184(31)
	mr 3,31
	stw 30,248(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	lwz 9,72(28)
	mtlr 9
	blrl
	stw 30,80(31)
.L262:
	mr 3,31
	li 4,280
	mr 5,29
	bl G_Find
	mr. 31,3
	bc 4,2,.L264
.L255:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe43:
	.size	 CTFResetFlag,.Lfe43-CTFResetFlag
	.section	".rodata"
	.align 2
.LC250:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFCheckHurtCarrier
	.type	 CTFCheckHurtCarrier,@function
CTFCheckHurtCarrier:
	lis 11,.LC250@ha
	lis 9,ctf@ha
	la 11,.LC250@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bclr 12,2
	lwz 0,84(3)
	cmpwi 0,0,0
	mr 10,0
	bclr 12,2
	lwz 0,84(4)
	cmpwi 0,0,0
	mr 8,0
	bclr 12,2
	lwz 0,4048(10)
	cmpwi 0,0,1
	bc 4,2,.L252
	lis 9,flag2_item@ha
	lwz 11,flag2_item@l(9)
	b .L253
.L252:
	lis 9,flag1_item@ha
	lwz 11,flag1_item@l(9)
.L253:
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,11
	mullw 9,9,0
	addi 11,10,740
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bclr 12,2
	lwz 9,4048(10)
	lwz 0,4048(8)
	cmpw 0,9,0
	bclr 12,2
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	stfs 0,4056(8)
	blr
.Lfe44:
	.size	 CTFCheckHurtCarrier,.Lfe44-CTFCheckHurtCarrier
	.align 2
	.globl CTFPlayerResetGrapple
	.type	 CTFPlayerResetGrapple,@function
CTFPlayerResetGrapple:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L508
	lwz 3,4764(3)
	cmpwi 0,3,0
	bc 12,2,.L508
	bl CTFResetGrapple
.L508:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe45:
	.size	 CTFPlayerResetGrapple,.Lfe45-CTFPlayerResetGrapple
	.align 2
	.globl CTFResetGrapple
	.type	 CTFResetGrapple,@function
CTFResetGrapple:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,256(3)
	lwz 10,84(9)
	lwz 0,4764(10)
	cmpwi 0,0,0
	bc 12,2,.L510
	li 11,0
	lis 9,level+4@ha
	lbz 0,16(10)
	stw 11,4764(10)
	lfs 0,level+4@l(9)
	andi. 0,0,191
	stb 0,16(10)
	stw 11,4768(10)
	stfs 0,4772(10)
	bl G_FreeEdict
.L510:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe46:
	.size	 CTFResetGrapple,.Lfe46-CTFResetGrapple
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
	bc 12,2,.L661
	lis 9,itemlist@ha
	lis 31,0x286b
	la 28,itemlist@l(9)
	mr 30,3
	ori 31,31,51739
.L662:
	lwz 3,0(30)
	bl FindItemByClassname
	mr. 3,3
	bc 12,2,.L663
	subf 0,28,3
	lwz 11,84(29)
	mullw 0,0,31
	addi 11,11,740
	rlwinm 0,0,0,0,29
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 4,2,.L1047
.L663:
	lwzu 0,4(30)
	cmpwi 0,0,0
	bc 4,2,.L662
.L661:
	li 3,0
.L1047:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe47:
	.size	 CTFWhat_Tech,.Lfe47-CTFWhat_Tech
	.section	".rodata"
	.align 2
.LC252:
	.long 0x0
	.align 2
.LC253:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl CTFDrop_Tech
	.type	 CTFDrop_Tech,@function
CTFDrop_Tech:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 11,.LC252@ha
	lis 9,ctf@ha
	la 11,.LC252@l(11)
	mr 30,3
	lfs 13,0(11)
	mr 31,4
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L689
	bl Drop_Item
	lis 9,.LC253@ha
	lis 11,level+4@ha
	la 9,.LC253@l(9)
	lfs 0,level+4@l(11)
	lis 0,0x286b
	lfs 13,0(9)
	lis 11,itemlist@ha
	ori 0,0,51739
	lis 9,TechThink@ha
	la 11,itemlist@l(11)
	la 9,TechThink@l(9)
	subf 11,11,31
	fadds 0,0,13
	stw 9,436(3)
	mullw 11,11,0
	li 10,0
	rlwinm 11,11,0,0,29
	stfs 0,428(3)
	lwz 9,84(30)
	addi 9,9,740
	stwx 10,9,11
.L689:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe48:
	.size	 CTFDrop_Tech,.Lfe48-CTFDrop_Tech
	.section	".rodata"
	.align 2
.LC254:
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
	bc 4,2,.L718
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andis. 0,11,8
	bc 4,2,.L718
	bl G_Spawn
	lis 9,.LC254@ha
	lis 11,level+4@ha
	la 9,.LC254@l(9)
	lfs 0,level+4@l(11)
	li 0,1
	lfs 13,0(9)
	lis 9,SpawnTechs@ha
	la 9,SpawnTechs@l(9)
	fadds 0,0,13
	stw 9,436(3)
	stfs 0,428(3)
	stw 0,techspawn@l(31)
.L718:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe49:
	.size	 CTFSetupTechSpawn,.Lfe49-CTFSetupTechSpawn
	.align 2
	.globl CTFApplyResistance
	.type	 CTFApplyResistance,@function
CTFApplyResistance:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 30,tech.164@ha
	mr 29,3
	lwz 0,tech.164@l(30)
	mr 31,4
	cmpwi 0,0,0
	bc 4,2,.L723
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	bl FindItemByClassname
	stw 3,tech.164@l(30)
.L723:
	cmpwi 0,31,0
	bc 12,2,.L724
	lwz 11,tech.164@l(30)
	cmpwi 0,11,0
	bc 12,2,.L724
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 12,2,.L724
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
	bc 12,2,.L724
	srwi 3,31,31
	add 3,31,3
	srawi 3,3,1
	b .L1048
.L724:
	mr 3,31
.L1048:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe50:
	.size	 CTFApplyResistance,.Lfe50-CTFApplyResistance
	.align 2
	.globl CTFApplyStrength
	.type	 CTFApplyStrength,@function
CTFApplyStrength:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 31,tech.168@ha
	mr 29,3
	lwz 0,tech.168@l(31)
	mr 30,4
	cmpwi 0,0,0
	bc 4,2,.L726
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	bl FindItemByClassname
	stw 3,tech.168@l(31)
.L726:
	cmpwi 0,30,0
	bc 12,2,.L727
	lwz 11,tech.168@l(31)
	cmpwi 0,11,0
	bc 12,2,.L727
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 12,2,.L727
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
	bc 12,2,.L727
	slwi 3,30,1
	b .L1049
.L727:
	mr 3,30
.L1049:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe51:
	.size	 CTFApplyStrength,.Lfe51-CTFApplyStrength
	.section	".rodata"
	.align 2
.LC257:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl CTFApplyStrengthSound
	.type	 CTFApplyStrengthSound,@function
CTFApplyStrengthSound:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 31,tech.172@ha
	mr 30,3
	lwz 0,tech.172@l(31)
	cmpwi 0,0,0
	bc 4,2,.L1051
	lis 3,.LC2@ha
	la 3,.LC2@l(3)
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,tech.172@l(31)
	bc 12,2,.L731
.L1051:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 12,2,.L731
	lwz 0,tech.172@l(31)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,0
	addi 10,3,740
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L731
	lis 9,level+4@ha
	lfs 0,4780(3)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L732
	lis 9,.LC257@ha
	la 9,.LC257@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,4780(3)
.L732:
	li 3,1
	b .L1050
.L731:
	li 3,0
.L1050:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe52:
	.size	 CTFApplyStrengthSound,.Lfe52-CTFApplyStrengthSound
	.align 2
	.globl CTFApplyHaste
	.type	 CTFApplyHaste,@function
CTFApplyHaste:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 31,tech.176@ha
	mr 30,3
	lwz 0,tech.176@l(31)
	cmpwi 0,0,0
	bc 4,2,.L1053
	lis 3,.LC3@ha
	la 3,.LC3@l(3)
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,tech.176@l(31)
	bc 12,2,.L735
.L1053:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 12,2,.L735
	lwz 0,tech.176@l(31)
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
	bc 4,2,.L1052
.L735:
	li 3,0
.L1052:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe53:
	.size	 CTFApplyHaste,.Lfe53-CTFApplyHaste
	.section	".rodata"
	.align 2
.LC259:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl CTFApplyHasteSound
	.type	 CTFApplyHasteSound,@function
CTFApplyHasteSound:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 31,tech.180@ha
	mr 30,3
	lwz 0,tech.180@l(31)
	cmpwi 0,0,0
	bc 4,2,.L1054
	lis 3,.LC3@ha
	la 3,.LC3@l(3)
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,tech.180@l(31)
	bc 12,2,.L739
.L1054:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 12,2,.L739
	lwz 0,tech.180@l(31)
	lis 9,itemlist@ha
	lis 11,0x286b
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,0
	addi 10,3,740
	mullw 0,0,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 12,2,.L739
	lis 9,level+4@ha
	lfs 0,4780(3)
	lfs 13,level+4@l(9)
	fcmpu 0,0,13
	bc 4,0,.L739
	lis 9,.LC259@ha
	la 9,.LC259@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,4780(3)
.L739:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe54:
	.size	 CTFApplyHasteSound,.Lfe54-CTFApplyHasteSound
	.align 2
	.globl CTFHasRegeneration
	.type	 CTFHasRegeneration,@function
CTFHasRegeneration:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 31,tech.188@ha
	mr 30,3
	lwz 0,tech.188@l(31)
	cmpwi 0,0,0
	bc 4,2,.L1056
	lis 3,.LC4@ha
	la 3,.LC4@l(3)
	bl FindItemByClassname
	cmpwi 0,3,0
	stw 3,tech.188@l(31)
	bc 12,2,.L752
.L1056:
	lwz 3,84(30)
	cmpwi 0,3,0
	bc 12,2,.L752
	lwz 0,tech.188@l(31)
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
	bc 4,2,.L1055
.L752:
	li 3,0
.L1055:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe55:
	.size	 CTFHasRegeneration,.Lfe55-CTFHasRegeneration
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
	bc 12,2,.L715
	lis 29,.LC133@ha
.L714:
	mr 3,30
	li 4,280
	la 5,.LC133@l(29)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L714
.L715:
	cmpwi 0,30,0
	bc 4,2,.L1057
	lis 5,.LC133@ha
	li 3,0
	la 5,.LC133@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 12,2,.L711
.L1057:
	lwz 3,648(28)
	mr 4,30
	bl SpawnTech
.L711:
	mr 3,28
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe56:
	.size	 CTFRespawnTech,.Lfe56-CTFRespawnTech
	.section	".rodata"
	.align 2
.LC260:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFOpenJoinMenu
	.type	 CTFOpenJoinMenu,@function
CTFOpenJoinMenu:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC260@ha
	lis 9,ctf@ha
	la 11,.LC260@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L954
	bl CTFUpdateJoinMenu
	lwz 9,84(31)
	mr 5,3
	lwz 0,4408(9)
	cmpwi 0,0,0
	bc 12,2,.L956
	li 5,8
	b .L957
.L956:
	xori 9,5,1
	srawi 11,9,31
	xor 0,11,9
	subf 0,0,11
	srawi 0,0,31
	rlwinm 0,0,0,29,30
	ori 5,0,4
.L957:
	lis 4,joinmenu@ha
	mr 3,31
	la 4,joinmenu@l(4)
	li 6,17
	bl PMenu_Open
.L954:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe57:
	.size	 CTFOpenJoinMenu,.Lfe57-CTFOpenJoinMenu
	.section	".rodata"
	.align 2
.LC261:
	.long 0x0
	.align 3
.LC262:
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
	lis 11,.LC261@ha
	lis 9,ctf@ha
	la 11,.LC261@l(11)
	lfs 12,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,12
	bc 12,2,.L975
	lis 9,capturelimit@ha
	lwz 11,capturelimit@l(9)
	lfs 13,20(11)
	fcmpu 0,13,12
	bc 12,2,.L975
	lis 9,ctfgame@ha
	lwz 0,ctfgame@l(9)
	la 8,ctfgame@l(9)
	lis 10,0x4330
	lis 9,.LC262@ha
	xoris 0,0,0x8000
	la 9,.LC262@l(9)
	stw 0,12(1)
	stw 10,8(1)
	lfd 12,0(9)
	lfd 0,8(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,1
	bc 12,3,.L976
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
	bc 4,3,.L975
.L976:
	lis 4,.LC226@ha
	li 3,2
	la 4,.LC226@l(4)
	crxor 6,6,6
	bl safe_bprintf
	li 3,1
	b .L1058
.L975:
	li 3,0
.L1058:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe58:
	.size	 CTFCheckRules,.Lfe58-CTFCheckRules
	.section	".rodata"
	.align 3
.LC263:
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
	lis 3,.LC189@ha
	stw 0,260(31)
	la 30,gi@l(9)
	la 3,.LC189@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,284(31)
	stw 3,40(31)
	andi. 9,0,1
	bc 12,2,.L886
	li 0,1
	stw 0,60(31)
.L886:
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
	lis 11,.LC263@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC263@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe59:
	.size	 SP_misc_ctf_banner,.Lfe59-SP_misc_ctf_banner
	.section	".rodata"
	.align 3
.LC264:
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
	lis 3,.LC191@ha
	stw 0,260(31)
	la 30,gi@l(9)
	la 3,.LC191@l(3)
	lwz 9,32(30)
	mtlr 9
	blrl
	lwz 0,284(31)
	stw 3,40(31)
	andi. 9,0,1
	bc 12,2,.L888
	li 0,1
	stw 0,60(31)
.L888:
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
	lis 11,.LC264@ha
	stw 9,436(31)
	lfs 0,level+4@l(10)
	lfd 13,.LC264@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe60:
	.size	 SP_misc_ctf_small_banner,.Lfe60-SP_misc_ctf_small_banner
	.section	".rodata"
	.align 2
.LC265:
	.long 0x41800000
	.section	".text"
	.align 2
	.globl SP_info_teleport_destination
	.type	 SP_info_teleport_destination,@function
SP_info_teleport_destination:
	lis 9,.LC265@ha
	lfs 0,12(3)
	la 9,.LC265@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,12(3)
	blr
.Lfe61:
	.size	 SP_info_teleport_destination,.Lfe61-SP_info_teleport_destination
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
.Lfe62:
	.size	 stuffcmd,.Lfe62-stuffcmd
	.section	".rodata"
	.align 2
.LC266:
	.long 0x46fffe00
	.align 3
.LC267:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC268:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC269:
	.long 0x3f800000
	.align 2
.LC270:
	.long 0x0
	.section	".text"
	.align 2
	.globl flagsnap
	.type	 flagsnap,@function
flagsnap:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	mr 31,3
	mr 30,5
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,44(1)
	lis 10,.LC267@ha
	lis 11,.LC266@ha
	la 10,.LC267@l(10)
	stw 0,40(1)
	lfd 13,0(10)
	lfd 0,40(1)
	lis 10,.LC268@ha
	lfs 12,.LC266@l(11)
	la 10,.LC268@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	cror 3,2,1
	bc 4,3,.L1039
	lis 29,gi@ha
	lis 3,.LC246@ha
	la 29,gi@l(29)
	la 3,.LC246@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC269@ha
	lis 10,.LC269@ha
	lis 11,.LC270@ha
	mr 5,3
	la 9,.LC269@l(9)
	la 10,.LC269@l(10)
	mtlr 0
	la 11,.LC270@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L1040
.L1039:
	lis 29,gi@ha
	lis 3,.LC247@ha
	la 29,gi@l(29)
	la 3,.LC247@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC269@ha
	lis 10,.LC269@ha
	lis 11,.LC270@ha
	mr 5,3
	la 9,.LC269@l(9)
	la 10,.LC269@l(10)
	mtlr 0
	la 11,.LC270@l(11)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L1040:
	cmpwi 0,30,20
	bc 4,1,.L1041
	xoris 0,30,0x8000
	lfs 12,16(1)
	stw 0,44(1)
	lis 10,0x4330
	mr 9,11
	stw 10,40(1)
	slwi 0,30,2
	lfd 13,40(1)
	xoris 0,0,0x8000
	lis 11,.LC267@ha
	stw 0,44(1)
	la 11,.LC267@l(11)
	stw 10,40(1)
	lfd 11,0(11)
	lfd 0,40(1)
	li 11,70
	lfs 9,384(31)
	fsub 13,13,11
	lfs 8,376(31)
	fsub 0,0,11
	lfs 10,380(31)
	fadds 12,12,9
	stw 11,56(31)
	frsp 13,13
	frsp 0,0
	stfs 13,8(1)
	fadds 8,13,8
	fadds 10,0,10
	stfs 12,384(31)
	stfs 0,12(1)
	stfs 8,376(31)
	stfs 10,380(31)
	b .L1042
.L1041:
	li 0,65
	stw 0,56(31)
.L1042:
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe63:
	.size	 flagsnap,.Lfe63-flagsnap
	.comm	ctfgame,24,4
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
	bc 12,2,.L124
	cmpwi 0,3,2
	bc 12,2,.L125
	b .L123
.L124:
	li 3,2
	blr
.L125:
	li 3,1
	blr
.L123:
	li 3,-1
	blr
.Lfe64:
	.size	 CTFOtherTeam,.Lfe64-CTFOtherTeam
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
	bc 4,2,.L354
	lis 9,level+4@ha
	lfs 0,428(3)
	lis 11,.LC271@ha
	lfs 13,level+4@l(9)
	la 11,.LC271@l(11)
	lfs 12,0(11)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,1,.L353
.L354:
	bl Touch_Item
.L353:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe65:
	.size	 CTFDropFlagTouch,.Lfe65-CTFDropFlagTouch
	.section	".rodata"
	.align 3
.LC272:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.type	 CTFFlagThink,@function
CTFFlagThink:
	lis 9,level+4@ha
	lis 11,.LC272@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC272@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.Lfe66:
	.size	 CTFFlagThink,.Lfe66-CTFFlagThink
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
	lis 3,.LC102@ha
	la 29,gi@l(29)
	stw 0,252(31)
	la 3,.LC102@l(3)
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
	stw 31,4764(9)
	lwz 11,84(27)
	stw 0,4768(11)
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
	bc 4,0,.L551
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
.L551:
	lwz 0,116(1)
	mtlr 0
	lmw 24,80(1)
	la 1,112(1)
	blr
.Lfe67:
	.size	 CTFFireGrapple,.Lfe67-CTFFireGrapple
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
.Lfe68:
	.size	 CTFWeapon_Grapple_Fire,.Lfe68-CTFWeapon_Grapple_Fire
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
	lfs 13,4784(11)
	la 9,.LC276@l(9)
	lfs 12,0(9)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 4,1,.L658
	lis 4,.LC131@ha
	la 4,.LC131@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	lfs 0,4(30)
	lwz 9,84(31)
	stfs 0,4784(9)
.L658:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe69:
	.size	 CTFHasTech,.Lfe69-CTFHasTech
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
	bc 12,2,.L685
	lis 28,.LC133@ha
.L684:
	mr 3,30
	li 4,280
	la 5,.LC133@l(28)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L684
.L685:
	cmpwi 0,30,0
	bc 4,2,.L1060
	lis 5,.LC133@ha
	li 3,0
	la 5,.LC133@l(5)
	li 4,280
	bl G_Find
	mr. 30,3
	bc 12,2,.L681
.L1060:
	lwz 3,648(29)
	mr 4,30
	bl SpawnTech
	mr 3,29
	bl G_FreeEdict
	b .L688
.L681:
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
.L688:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe70:
	.size	 TechThink,.Lfe70-TechThink
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
	bc 12,2,.L700
	mr 26,9
	lis 25,.LC133@ha
.L701:
	slwi 0,31,2
	addi 27,31,1
	lwzx 3,26,0
	bl FindItemByClassname
	mr. 28,3
	bc 12,2,.L702
	bl rand
	li 30,0
	srawi 0,3,31
	srwi 0,0,28
	add 0,3,0
	rlwinm 0,0,0,0,27
	subf 31,0,3
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L706
	lis 29,.LC133@ha
.L705:
	mr 3,30
	li 4,280
	la 5,.LC133@l(29)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L705
.L706:
	cmpwi 0,30,0
	bc 4,2,.L1061
	li 3,0
	li 4,280
	la 5,.LC133@l(25)
	bl G_Find
	mr. 30,3
	bc 12,2,.L702
.L1061:
	mr 3,28
	mr 4,30
	bl SpawnTech
.L702:
	mr 31,27
	slwi 0,31,2
	lwzx 9,26,0
	cmpwi 0,9,0
	bc 4,2,.L701
.L700:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe71:
	.size	 SpawnTechs,.Lfe71-SpawnTechs
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
.Lfe72:
	.size	 misc_ctf_banner_think,.Lfe72-misc_ctf_banner_think
	.section	".rodata"
	.align 2
.LC279:
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
	lis 11,.LC279@ha
	lis 9,ctf@ha
	la 11,.LC279@l(11)
	mr 31,3
	lfs 13,0(11)
	mr 30,4
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L889
	bl PMenu_Close
	lwz 0,184(31)
	li 10,0
	lis 4,.LC116@ha
	lwz 11,84(31)
	la 4,.LC116@l(4)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	stw 30,4048(11)
	lwz 9,84(31)
	stw 10,4052(9)
	lwz 3,84(31)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl CTFAssignSkin
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
	bc 12,2,.L891
	cmpwi 0,30,2
	bc 12,2,.L892
	b .L895
.L891:
	lis 9,.LC16@ha
	la 6,.LC16@l(9)
	b .L894
.L892:
	lis 9,.LC17@ha
	la 6,.LC17@l(9)
	b .L894
.L895:
	lis 9,.LC18@ha
	la 6,.LC18@l(9)
.L894:
	lis 4,.LC117@ha
	li 3,2
	la 4,.LC117@l(4)
	crxor 6,6,6
	bl safe_bprintf
.L889:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe73:
	.size	 CTFJoinTeam,.Lfe73-CTFJoinTeam
	.section	".rodata"
	.align 2
.LC280:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFJoinTeam1
	.type	 CTFJoinTeam1,@function
CTFJoinTeam1:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC280@ha
	lis 9,ctf@ha
	la 11,.LC280@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L898
	bl PMenu_Close
	lwz 9,184(31)
	li 0,1
	li 10,0
	lwz 11,84(31)
	lis 4,.LC116@ha
	rlwinm 9,9,0,0,30
	la 4,.LC116@l(4)
	stw 9,184(31)
	stw 0,4048(11)
	lwz 9,84(31)
	stw 10,4052(9)
	lwz 3,84(31)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl CTFAssignSkin
	mr 3,31
	bl PutClientInServer
	lwz 11,84(31)
	li 0,6
	li 9,32
	stw 0,80(31)
	li 10,14
	lis 6,.LC16@ha
	stb 9,16(11)
	lis 4,.LC117@ha
	la 6,.LC16@l(6)
	lwz 9,84(31)
	la 4,.LC117@l(4)
	li 3,2
	stb 10,17(9)
	lwz 5,84(31)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
.L898:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe74:
	.size	 CTFJoinTeam1,.Lfe74-CTFJoinTeam1
	.section	".rodata"
	.align 2
.LC281:
	.long 0x0
	.section	".text"
	.align 2
	.globl CTFJoinTeam2
	.type	 CTFJoinTeam2,@function
CTFJoinTeam2:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC281@ha
	lis 9,ctf@ha
	la 11,.LC281@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L906
	bl PMenu_Close
	lwz 9,184(31)
	li 0,2
	li 10,0
	lwz 11,84(31)
	lis 4,.LC116@ha
	rlwinm 9,9,0,0,30
	la 4,.LC116@l(4)
	stw 9,184(31)
	stw 0,4048(11)
	lwz 9,84(31)
	stw 10,4052(9)
	lwz 3,84(31)
	addi 3,3,188
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl CTFAssignSkin
	mr 3,31
	bl PutClientInServer
	lwz 11,84(31)
	li 0,6
	li 9,32
	stw 0,80(31)
	li 10,14
	lis 6,.LC17@ha
	stb 9,16(11)
	lis 4,.LC117@ha
	la 6,.LC17@l(6)
	lwz 9,84(31)
	la 4,.LC117@l(4)
	li 3,2
	stb 10,17(9)
	lwz 5,84(31)
	addi 5,5,700
	crxor 6,6,6
	bl safe_bprintf
.L906:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe75:
	.size	 CTFJoinTeam2,.Lfe75-CTFJoinTeam2
	.section	".rodata"
	.align 2
.LC282:
	.long 0x0
	.align 3
.LC283:
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
	lis 11,.LC282@ha
	lis 9,ctf@ha
	la 11,.LC282@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L912
	lwz 9,84(31)
	lwz 0,4408(9)
	mr 7,9
	cmpwi 0,0,0
	bc 12,2,.L914
	li 0,0
	stw 0,4408(7)
	bl PMenu_Close
	b .L912
.L914:
	li 8,1
	b .L915
.L917:
	addi 8,8,1
.L915:
	xoris 0,8,0x8000
	lis 9,0x4330
	stw 0,20(1)
	lis 11,.LC283@ha
	la 11,.LC283@l(11)
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
	bc 4,3,.L912
	lis 9,g_edicts@ha
	mulli 11,8,1076
	lwz 0,g_edicts@l(9)
	add 11,0,11
	lwz 9,88(11)
	cmpwi 0,9,0
	bc 12,2,.L917
	lwz 0,248(11)
	cmpwi 0,0,0
	bc 12,2,.L917
	stw 11,4408(7)
	mr 3,31
	bl PMenu_Close
	lwz 9,84(31)
	li 0,1
	stw 0,4412(9)
.L912:
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
	.section	".rodata"
	.align 2
.LC284:
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
	lis 11,.LC284@ha
	lis 9,ctf@ha
	la 11,.LC284@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L960
	bl PMenu_Close
	lis 4,creditsmenu@ha
	mr 3,31
	la 4,creditsmenu@l(4)
	li 5,-1
	li 6,18
	bl PMenu_Open
.L960:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
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
	stw 0,4112(11)
	lwz 9,84(29)
	stw 10,4116(9)
	bl DeathmatchScoreboard
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe79:
	.size	 CTFShowScores,.Lfe79-CTFShowScores
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
