	.file	"g_cvars.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 stuff_light,@object
	.size	 stuff_light,4
stuff_light:
	.long 1
	.section	".rodata"
	.align 2
.LC1:
	.string	"maxrate"
	.align 2
.LC2:
	.string	"0"
	.align 2
.LC4:
	.string	"maxmarinekill"
	.align 2
.LC5:
	.string	"5"
	.align 2
.LC6:
	.string	"penalty_threshold"
	.align 2
.LC7:
	.long 0x0
	.align 2
.LC8:
	.long 0x41a00000
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl getPenalty
	.type	 getPenalty,@function
getPenalty:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 9,penalty_threshold@ha
	lwz 31,penalty_threshold@l(9)
	lwz 0,16(31)
	cmpwi 0,0,0
	bc 12,2,.L31
	lis 9,.LC7@ha
	lfs 0,20(31)
	la 9,.LC7@l(9)
	lfs 12,0(9)
	fcmpu 0,0,12
	bc 12,0,.L32
	lis 9,maxmarinekill@ha
	lwz 9,maxmarinekill@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L33
	lfs 13,20(9)
	fcmpu 0,13,12
	bc 12,0,.L34
	lis 10,.LC8@ha
	la 10,.LC8@l(10)
	lfs 0,0(10)
	fcmpu 0,13,0
	bc 4,1,.L33
.L34:
	lis 9,gi+148@ha
	lis 3,.LC4@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC5@ha
	la 3,.LC4@l(3)
	la 4,.LC5@l(4)
	mtlr 0
	blrl
.L33:
	lis 10,maxmarinekill@ha
	lfs 11,20(31)
	lwz 8,maxmarinekill@l(10)
	mr 11,9
	lis 0,0x4330
	lis 10,.LC9@ha
	lfs 0,20(8)
	la 10,.LC9@l(10)
	lfd 12,0(10)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	xoris 9,9,0x8000
	stw 9,20(1)
	stw 0,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,11,0
	cror 3,2,1
	bc 4,3,.L31
.L32:
	lis 9,gi+148@ha
	lis 3,.LC6@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC2@ha
	la 3,.LC6@l(3)
	la 4,.LC2@l(4)
	mtlr 0
	blrl
.L31:
	lis 11,penalty_threshold@ha
	lwz 9,penalty_threshold@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 3,20(1)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 getPenalty,.Lfe1-getPenalty
	.section	".rodata"
	.align 2
.LC11:
	.string	"maxtime"
	.align 2
.LC12:
	.string	"300"
	.align 2
.LC14:
	.string	"minscore"
	.align 2
.LC15:
	.string	"-10"
	.align 2
.LC17:
	.string	"sv_maplist_small_max"
	.align 2
.LC18:
	.string	"4"
	.align 2
.LC21:
	.string	"sv_maplist_medium_max"
	.align 2
.LC22:
	.string	"8"
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.align 2
.LC24:
	.long 0x477fff00
	.align 2
.LC25:
	.long 0x44fa0000
	.section	".text"
	.align 2
	.globl validateMaxRate
	.type	 validateMaxRate,@function
validateMaxRate:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC25@ha
	lis 9,maxrate@ha
	la 11,.LC25@l(11)
	lfs 0,0(11)
	lwz 11,maxrate@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L8
	lis 9,.LC24@ha
	lfs 0,.LC24@l(9)
	fcmpu 0,13,0
	bc 4,1,.L7
.L8:
	lis 9,gi+148@ha
	lis 3,.LC1@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC2@ha
	la 3,.LC1@l(3)
	la 4,.LC2@l(4)
	mtlr 0
	blrl
.L7:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe2:
	.size	 validateMaxRate,.Lfe2-validateMaxRate
	.section	".rodata"
	.align 2
.LC26:
	.long 0x477fff00
	.align 2
.LC27:
	.long 0x44fa0000
	.section	".text"
	.align 2
	.globl getMaxRate
	.type	 getMaxRate,@function
getMaxRate:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,maxrate@ha
	lwz 9,maxrate@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L10
	lfs 13,20(9)
	lis 9,.LC27@ha
	la 9,.LC27@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L11
	lis 9,.LC26@ha
	lfs 0,.LC26@l(9)
	fcmpu 0,13,0
	bc 4,1,.L10
.L11:
	lis 9,gi+148@ha
	lis 3,.LC1@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC2@ha
	la 3,.LC1@l(3)
	la 4,.LC2@l(4)
	mtlr 0
	blrl
.L10:
	lis 11,maxrate@ha
	lwz 9,maxrate@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe3:
	.size	 getMaxRate,.Lfe3-getMaxRate
	.section	".rodata"
	.align 2
.LC28:
	.long 0x0
	.align 2
.LC29:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl validateMaxMarineKill
	.type	 validateMaxMarineKill,@function
validateMaxMarineKill:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC28@ha
	lis 9,maxmarinekill@ha
	la 11,.LC28@l(11)
	lfs 0,0(11)
	lwz 11,maxmarinekill@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L16
	lis 9,.LC29@ha
	la 9,.LC29@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L15
.L16:
	lis 9,gi+148@ha
	lis 3,.LC4@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC5@ha
	la 3,.LC4@l(3)
	la 4,.LC5@l(4)
	mtlr 0
	blrl
.L15:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 validateMaxMarineKill,.Lfe4-validateMaxMarineKill
	.section	".rodata"
	.align 2
.LC30:
	.long 0x0
	.align 2
.LC31:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl getMaxMarineKill
	.type	 getMaxMarineKill,@function
getMaxMarineKill:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,maxmarinekill@ha
	lwz 9,maxmarinekill@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L18
	lfs 13,20(9)
	lis 9,.LC30@ha
	la 9,.LC30@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L19
	lis 9,.LC31@ha
	la 9,.LC31@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L18
.L19:
	lis 9,gi+148@ha
	lis 3,.LC4@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC5@ha
	la 3,.LC4@l(3)
	la 4,.LC5@l(4)
	mtlr 0
	blrl
.L18:
	lis 11,maxmarinekill@ha
	lwz 9,maxmarinekill@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe5:
	.size	 getMaxMarineKill,.Lfe5-getMaxMarineKill
	.section	".rodata"
	.align 2
.LC32:
	.long 0x44988000
	.align 2
.LC33:
	.long 0x0
	.section	".text"
	.align 2
	.globl validateMaxTime
	.type	 validateMaxTime,@function
validateMaxTime:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC33@ha
	lis 9,maxtime@ha
	la 11,.LC33@l(11)
	lfs 0,0(11)
	lwz 11,maxtime@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L42
	lis 9,.LC32@ha
	lfs 0,.LC32@l(9)
	fcmpu 0,13,0
	bc 4,1,.L41
.L42:
	lis 9,gi+148@ha
	lis 3,.LC11@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC12@ha
	la 3,.LC11@l(3)
	la 4,.LC12@l(4)
	mtlr 0
	blrl
.L41:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 validateMaxTime,.Lfe6-validateMaxTime
	.section	".rodata"
	.align 2
.LC34:
	.long 0x44988000
	.align 2
.LC35:
	.long 0x0
	.section	".text"
	.align 2
	.globl getMaxTime
	.type	 getMaxTime,@function
getMaxTime:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,maxtime@ha
	lwz 9,maxtime@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L44
	lfs 13,20(9)
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L45
	lis 9,.LC34@ha
	lfs 0,.LC34@l(9)
	fcmpu 0,13,0
	bc 4,1,.L44
.L45:
	lis 9,gi+148@ha
	lis 3,.LC11@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC12@ha
	la 3,.LC11@l(3)
	la 4,.LC12@l(4)
	mtlr 0
	blrl
.L44:
	lis 11,maxtime@ha
	lwz 9,maxtime@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 getMaxTime,.Lfe7-getMaxTime
	.section	".rodata"
	.align 2
.LC36:
	.long 0xc1200000
	.align 2
.LC37:
	.long 0x0
	.section	".text"
	.align 2
	.globl validateMinScore
	.type	 validateMinScore,@function
validateMinScore:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC36@ha
	lis 9,minscore@ha
	la 11,.LC36@l(11)
	lfs 0,0(11)
	lwz 11,minscore@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L50
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L49
.L50:
	lis 9,gi+148@ha
	lis 3,.LC14@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC15@ha
	la 3,.LC14@l(3)
	la 4,.LC15@l(4)
	mtlr 0
	blrl
.L49:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 validateMinScore,.Lfe8-validateMinScore
	.section	".rodata"
	.align 2
.LC38:
	.long 0xc1200000
	.align 2
.LC39:
	.long 0x0
	.section	".text"
	.align 2
	.globl getMinScore
	.type	 getMinScore,@function
getMinScore:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,minscore@ha
	lwz 9,minscore@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L52
	lfs 13,20(9)
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L53
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L52
.L53:
	lis 9,gi+148@ha
	lis 3,.LC14@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC15@ha
	la 3,.LC14@l(3)
	la 4,.LC15@l(4)
	mtlr 0
	blrl
.L52:
	lis 11,minscore@ha
	lwz 9,minscore@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 getMinScore,.Lfe9-getMinScore
	.section	".rodata"
	.align 2
.LC40:
	.long 0x4479c000
	.align 2
.LC41:
	.long 0x0
	.section	".text"
	.align 2
	.globl validateMaplistMediumMax
	.type	 validateMaplistMediumMax,@function
validateMaplistMediumMax:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC41@ha
	lis 9,sv_maplist_medium_max@ha
	la 11,.LC41@l(11)
	lfs 0,0(11)
	lwz 11,sv_maplist_medium_max@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L66
	lis 9,.LC40@ha
	lfs 0,.LC40@l(9)
	fcmpu 0,13,0
	bc 4,1,.L65
.L66:
	lis 9,gi+148@ha
	lis 3,.LC21@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC22@ha
	la 3,.LC21@l(3)
	la 4,.LC22@l(4)
	mtlr 0
	blrl
.L65:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 validateMaplistMediumMax,.Lfe10-validateMaplistMediumMax
	.section	".rodata"
	.align 2
.LC42:
	.long 0x4479c000
	.align 2
.LC43:
	.long 0x0
	.section	".text"
	.align 2
	.globl getMaplistMediumMax
	.type	 getMaplistMediumMax,@function
getMaplistMediumMax:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,sv_maplist_medium_max@ha
	lwz 9,sv_maplist_medium_max@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L68
	lfs 13,20(9)
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L69
	lis 9,.LC42@ha
	lfs 0,.LC42@l(9)
	fcmpu 0,13,0
	bc 4,1,.L68
.L69:
	lis 9,gi+148@ha
	lis 3,.LC21@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC22@ha
	la 3,.LC21@l(3)
	la 4,.LC22@l(4)
	mtlr 0
	blrl
.L68:
	lis 11,sv_maplist_medium_max@ha
	lwz 9,sv_maplist_medium_max@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 getMaplistMediumMax,.Lfe11-getMaplistMediumMax
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.section	".rodata"
	.align 2
.LC44:
	.long 0x0
	.align 2
.LC45:
	.long 0x41a00000
	.align 3
.LC46:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl validatePenalty
	.type	 validatePenalty,@function
validatePenalty:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 9,penalty_threshold@ha
	lis 10,.LC44@ha
	lwz 31,penalty_threshold@l(9)
	la 10,.LC44@l(10)
	lfs 12,0(10)
	lfs 0,20(31)
	fcmpu 0,0,12
	bc 12,0,.L24
	lis 9,maxmarinekill@ha
	lwz 9,maxmarinekill@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L25
	lfs 13,20(9)
	fcmpu 0,13,12
	bc 12,0,.L26
	lis 11,.LC45@ha
	la 11,.LC45@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,1,.L25
.L26:
	lis 9,gi+148@ha
	lis 3,.LC4@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC5@ha
	la 3,.LC4@l(3)
	la 4,.LC5@l(4)
	mtlr 0
	blrl
.L25:
	lis 10,maxmarinekill@ha
	lfs 11,20(31)
	lwz 8,maxmarinekill@l(10)
	mr 11,9
	lis 0,0x4330
	lis 10,.LC46@ha
	lfs 0,20(8)
	la 10,.LC46@l(10)
	lfd 12,0(10)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	xoris 9,9,0x8000
	stw 9,20(1)
	stw 0,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,11,0
	cror 3,2,1
	bc 4,3,.L23
.L24:
	lis 9,gi+148@ha
	lis 3,.LC6@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC2@ha
	la 3,.LC6@l(3)
	la 4,.LC2@l(4)
	mtlr 0
	blrl
.L23:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 validatePenalty,.Lfe12-validatePenalty
	.section	".rodata"
	.align 2
.LC47:
	.long 0x4479c000
	.align 2
.LC48:
	.long 0x0
	.section	".text"
	.align 2
	.globl validateMaplistSmallMax
	.type	 validateMaplistSmallMax,@function
validateMaplistSmallMax:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC48@ha
	lis 9,sv_maplist_small_max@ha
	la 11,.LC48@l(11)
	lfs 0,0(11)
	lwz 11,sv_maplist_small_max@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,0,.L58
	lis 9,.LC47@ha
	lfs 0,.LC47@l(9)
	fcmpu 0,13,0
	bc 4,1,.L57
.L58:
	lis 9,gi+148@ha
	lis 3,.LC17@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC18@ha
	la 3,.LC17@l(3)
	la 4,.LC18@l(4)
	mtlr 0
	blrl
.L57:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 validateMaplistSmallMax,.Lfe13-validateMaplistSmallMax
	.section	".rodata"
	.align 2
.LC49:
	.long 0x4479c000
	.align 2
.LC50:
	.long 0x0
	.section	".text"
	.align 2
	.globl getMaplistSmallMax
	.type	 getMaplistSmallMax,@function
getMaplistSmallMax:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,sv_maplist_small_max@ha
	lwz 9,sv_maplist_small_max@l(9)
	lwz 0,16(9)
	cmpwi 0,0,0
	bc 12,2,.L60
	lfs 13,20(9)
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,0,.L61
	lis 9,.LC49@ha
	lfs 0,.LC49@l(9)
	fcmpu 0,13,0
	bc 4,1,.L60
.L61:
	lis 9,gi+148@ha
	lis 3,.LC17@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC18@ha
	la 3,.LC17@l(3)
	la 4,.LC18@l(4)
	mtlr 0
	blrl
.L60:
	lis 11,sv_maplist_small_max@ha
	lwz 9,sv_maplist_small_max@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 getMaplistSmallMax,.Lfe14-getMaplistSmallMax
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
