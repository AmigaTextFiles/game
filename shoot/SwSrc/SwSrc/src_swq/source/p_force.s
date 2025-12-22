	.file	"p_force.c"
gcc2_compiled.:
	.globl powerlist
	.section	".data"
	.align 2
	.type	 powerlist,@object
powerlist:
	.long 0
	.space	40
	.long force_push
	.long 0
	.long .LC0
	.long .LC1
	.long .LC2
	.long .LC3
	.long 0x3f800000
	.long 0x40a00000
	.short 0
	.short 2
	.short 1
	.space	2
	.long 0
	.long force_pull
	.long 0
	.long .LC4
	.long .LC5
	.long .LC6
	.long .LC7
	.long 0x3f800000
	.long 0x40a00000
	.short 0
	.short 2
	.short 1
	.space	2
	.long 1000
	.long force_levitate
	.long 0
	.long .LC8
	.long .LC9
	.long .LC10
	.long .LC11
	.long 0x3f800000
	.long 0x41200000
	.short 0
	.short 1
	.short 2
	.space	2
	.long 60
	.long force_negate
	.long 0
	.long .LC12
	.long .LC13
	.long .LC14
	.long .LC15
	.long 0x3f800000
	.long 0x41a00000
	.short 0
	.short 0
	.short 1
	.space	2
	.long 50
	.long force_jump
	.long 0
	.long .LC16
	.long .LC17
	.long .LC18
	.long .LC19
	.long 0x3f800000
	.long 0x41200000
	.short 0
	.short 1
	.short 2
	.space	2
	.long 20
	.long force_speed
	.long 0
	.long .LC20
	.long .LC21
	.long .LC22
	.long .LC23
	.long 0x3f800000
	.long 0x41f00000
	.short 0
	.short 1
	.short 2
	.space	2
	.long 20
	.long force_lightheal
	.long 0
	.long .LC24
	.long .LC25
	.long .LC26
	.long .LC27
	.long 0x3f800000
	.long 0x41200000
	.short 1
	.short 2
	.short 3
	.space	2
	.long 10
	.long force_wall_of_light
	.long 0
	.long .LC28
	.long .LC29
	.long .LC30
	.long .LC31
	.long 0x3f800000
	.long 0x42200000
	.short 1
	.short 0
	.short 3
	.space	2
	.long 90
	.long force_shield
	.long 0
	.long .LC32
	.long .LC33
	.long .LC34
	.long .LC35
	.long 0x3f800000
	.long 0x41200000
	.short 1
	.short 1
	.short 4
	.space	2
	.long 30
	.long force_invisibility
	.long 0
	.long .LC36
	.long .LC37
	.long .LC38
	.long .LC39
	.long 0x3f800000
	.long 0x425c0000
	.short 1
	.short 1
	.short 4
	.space	2
	.long 70
	.long force_wind
	.long 0
	.long .LC40
	.long .LC41
	.long .LC42
	.long .LC43
	.long 0x3f800000
	.long 0x41c80000
	.short 1
	.short 2
	.short 5
	.space	2
	.long 50
	.long force_reflect
	.long 0
	.long .LC44
	.long .LC45
	.long .LC46
	.long .LC47
	.long 0x3f800000
	.long 0x428c0000
	.short 1
	.short 1
	.short 4
	.space	2
	.long 80
	.long force_scout
	.long 0
	.long .LC48
	.long .LC49
	.long .LC50
	.long .LC51
	.long 0x3f800000
	.long 0x41200000
	.short 1
	.short 1
	.short 3
	.space	2
	.long 60
	.long force_darkheal
	.long 0
	.long .LC52
	.long .LC53
	.long .LC54
	.long .LC55
	.long 0x3f800000
	.long 0x40800000
	.short -1
	.short 2
	.short 3
	.space	2
	.long -30
	.long force_lightning
	.long 0
	.long .LC56
	.long .LC57
	.long .LC58
	.long .LC59
	.long 0x3f800000
	.long 0x40800000
	.short -1
	.short 2
	.short 4
	.space	2
	.long -50
	.long force_choke
	.long 0
	.long .LC60
	.long .LC61
	.long .LC62
	.long .LC63
	.long 0x3f800000
	.long 0x41a00000
	.short -1
	.short 2
	.short 5
	.space	2
	.long -10
	.long force_absorb
	.long 0
	.long .LC64
	.long .LC65
	.long .LC66
	.long .LC67
	.long 0x3f800000
	.long 0x41200000
	.short -1
	.short 1
	.short 255
	.space	2
	.long -80
	.long force_wall_of_darkness
	.long 0
	.long .LC68
	.long .LC69
	.long .LC70
	.long .LC71
	.long 0x3f800000
	.long 0x42480000
	.short -1
	.short 0
	.short 3
	.space	2
	.long -90
	.long force_taint
	.long 0
	.long .LC72
	.long .LC73
	.long .LC74
	.long .LC75
	.long 0x3f800000
	.long 0x42200000
	.short -1
	.short 1
	.short 4
	.space	2
	.long -60
	.long force_inferno
	.long 0
	.long .LC76
	.long .LC77
	.long .LC78
	.long .LC79
	.long 0x3f800000
	.long 0x42960000
	.short -1
	.short 0
	.short 5
	.space	2
	.long -70
	.long force_rage
	.long 0
	.long .LC80
	.long .LC81
	.long .LC82
	.long .LC83
	.long 0x3f800000
	.long 0x420c0000
	.short -1
	.short 0
	.short 3
	.space	2
	.long -40
	.long 0
	.space	40
	.section	".rodata"
	.align 2
.LC83:
	.string	"rage"
	.align 2
.LC82:
	.string	"force/dark/rage3"
	.align 2
.LC81:
	.string	"force/dark/rage2"
	.align 2
.LC80:
	.string	"force/dark/rage1"
	.align 2
.LC79:
	.string	"inferno"
	.align 2
.LC78:
	.string	"force/dark/inferno3"
	.align 2
.LC77:
	.string	"force/dark/inferno2"
	.align 2
.LC76:
	.string	"force/dark/inferno1"
	.align 2
.LC75:
	.string	"taint"
	.align 2
.LC74:
	.string	"force/dark/taint3"
	.align 2
.LC73:
	.string	"force/dark/taint2"
	.align 2
.LC72:
	.string	"force/dark/taint1"
	.align 2
.LC71:
	.string	"darkness"
	.align 2
.LC70:
	.string	"force/dark/darkness3"
	.align 2
.LC69:
	.string	"force/dark/darkness2"
	.align 2
.LC68:
	.string	"force/dark/darkness1"
	.align 2
.LC67:
	.string	"absorb"
	.align 2
.LC66:
	.string	"force/dark/absorb3"
	.align 2
.LC65:
	.string	"force/dark/absorb2"
	.align 2
.LC64:
	.string	"force/dark/absorb1"
	.align 2
.LC63:
	.string	"choke"
	.align 2
.LC62:
	.string	"force/dark/choke3"
	.align 2
.LC61:
	.string	"force/dark/choke2"
	.align 2
.LC60:
	.string	"force/dark/choke1"
	.align 2
.LC59:
	.string	"lightning"
	.align 2
.LC58:
	.string	"force/dark/lightning3"
	.align 2
.LC57:
	.string	"force/dark/lightning2"
	.align 2
.LC56:
	.string	"force/dark/lightning1"
	.align 2
.LC55:
	.string	"dark_heal"
	.align 2
.LC54:
	.string	"force/dark/heal3"
	.align 2
.LC53:
	.string	"force/dark/heal2"
	.align 2
.LC52:
	.string	"force/dark/heal1"
	.align 2
.LC51:
	.string	"scout"
	.align 2
.LC50:
	.string	"force/light/scout3"
	.align 2
.LC49:
	.string	"force/light/scout2"
	.align 2
.LC48:
	.string	"force/light/scout1"
	.align 2
.LC47:
	.string	"reflect"
	.align 2
.LC46:
	.string	"force/light/reflect3"
	.align 2
.LC45:
	.string	"force/light/reflect2"
	.align 2
.LC44:
	.string	"force/light/reflect1"
	.align 2
.LC43:
	.string	"wind"
	.align 2
.LC42:
	.string	"force/light/wind3"
	.align 2
.LC41:
	.string	"force/light/wind2"
	.align 2
.LC40:
	.string	"force/light/wind1"
	.align 2
.LC39:
	.string	"invisibility"
	.align 2
.LC38:
	.string	"force/light/invisi3"
	.align 2
.LC37:
	.string	"force/light/invisi2"
	.align 2
.LC36:
	.string	"force/light/invisi1"
	.align 2
.LC35:
	.string	"shield"
	.align 2
.LC34:
	.string	"force/light/shield3"
	.align 2
.LC33:
	.string	"force/light/shield2"
	.align 2
.LC32:
	.string	"force/light/shield1"
	.align 2
.LC31:
	.string	"wall_of_light"
	.align 2
.LC30:
	.string	"force/light/wall3"
	.align 2
.LC29:
	.string	"force/light/wall2"
	.align 2
.LC28:
	.string	"force/light/wall1"
	.align 2
.LC27:
	.string	"light_heal"
	.align 2
.LC26:
	.string	"force/light/heal3"
	.align 2
.LC25:
	.string	"force/light/heal2"
	.align 2
.LC24:
	.string	"force/light/heal1"
	.align 2
.LC23:
	.string	"speed"
	.align 2
.LC22:
	.string	"force/neutral/speed3"
	.align 2
.LC21:
	.string	"force/neutral/speed2"
	.align 2
.LC20:
	.string	"force/neutral/speed1"
	.align 2
.LC19:
	.string	"jump"
	.align 2
.LC18:
	.string	"force/neutral/jump3"
	.align 2
.LC17:
	.string	"force/neutral/jump2"
	.align 2
.LC16:
	.string	"force/neutral/jump1"
	.align 2
.LC15:
	.string	"negate"
	.align 2
.LC14:
	.string	"force/neutral/negate3"
	.align 2
.LC13:
	.string	"force/neutral/negate2"
	.align 2
.LC12:
	.string	"force/neutral/negate1"
	.align 2
.LC11:
	.string	"levitate"
	.align 2
.LC10:
	.string	"force/neutral/levitate3"
	.align 2
.LC9:
	.string	"force/neutral/levitate2"
	.align 2
.LC8:
	.string	"force/neutral/levitate1"
	.align 2
.LC7:
	.string	"pull"
	.align 2
.LC6:
	.string	"force/neutral/pull3"
	.align 2
.LC5:
	.string	"force/neutral/pull2"
	.align 2
.LC4:
	.string	"force/neutral/pull1"
	.align 2
.LC3:
	.string	"push"
	.align 2
.LC2:
	.string	"force/neutral/push3"
	.align 2
.LC1:
	.string	"force/neutral/push2"
	.align 2
.LC0:
	.string	"force/neutral/push1"
	.size	 powerlist,1012
	.align 2
.LC84:
	.long 0x0
	.align 3
.LC85:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC86:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl calc_top_level_value
	.type	 calc_top_level_value,@function
calc_top_level_value:
	stwu 1,-32(1)
	stw 31,28(1)
	lis 9,.LC84@ha
	li 7,0
	la 9,.LC84@l(9)
	li 0,1
	lfs 11,0(9)
	lwz 9,84(3)
	lfs 0,1956(9)
	fcmpu 0,0,11
	bc 12,1,.L31
	bc 4,0,.L31
	li 0,0
.L31:
	lwz 3,84(3)
	mr 5,0
	lis 9,powerlist@ha
	la 31,powerlist@l(9)
	xori 12,5,1
	addi 4,3,1856
	addi 6,3,1984
	li 8,1
.L37:
	slwi 10,8,2
	lwzx 0,4,10
	cmpwi 0,0,0
	bc 12,2,.L36
	mulli 9,8,44
	add 9,9,31
	lhz 11,32(9)
	extsh 9,11
	cmpwi 0,9,0
	bc 12,2,.L45
	srawi 0,9,15
	subf 0,11,0
	rlwinm 0,0,17,31,31
	and. 11,0,5
	bc 4,2,.L45
	srwi 0,9,31
	and. 9,0,12
	bc 12,2,.L36
.L45:
	lfsx 0,6,10
	addi 7,7,1
	fadds 11,11,0
.L36:
	addi 0,8,1
	rlwinm 8,0,0,0xffff
	cmplwi 0,8,22
	bc 4,1,.L37
	xoris 0,7,0x8000
	lis 11,0x4330
	stw 0,20(1)
	lis 10,.LC85@ha
	stw 11,16(1)
	la 10,.LC85@l(10)
	lfd 13,0(10)
	lis 11,.LC86@ha
	lfd 0,16(1)
	la 11,.LC86@l(11)
	lfs 12,0(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,11,0
	fdivs 0,0,12
	stfs 0,1952(3)
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 calc_top_level_value,.Lfe1-calc_top_level_value
	.section	".rodata"
	.align 2
.LC87:
	.string	"CHECK1 NEUTRAL: skill req too high %i > %f\n"
	.align 2
.LC88:
	.string	"CHECK1 skill req too high %i > %f < %f\n"
	.align 2
.LC89:
	.string	"CHECK2 LIGHT skillreq greater than SG value %i > %f\n"
	.align 2
.LC90:
	.string	"CHECK2 DARK skillreq greater than SG value %i > %f\n"
	.align 2
.LC91:
	.long 0x42480000
	.align 3
.LC92:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Force_Power_Available
	.type	 Force_Power_Available,@function
Force_Power_Available:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mulli 4,4,44
	lis 9,powerlist@ha
	lwz 11,84(3)
	lis 5,.LC91@ha
	la 9,powerlist@l(9)
	la 5,.LC91@l(5)
	add 4,4,9
	lfs 13,0(5)
	li 6,0
	lha 0,32(4)
	lfs 0,1956(11)
	cmpwi 0,0,0
	fsubs 11,0,13
	fadds 12,0,13
	bc 4,2,.L75
	lwz 11,40(4)
	lis 10,0x4330
	lis 8,.LC92@ha
	xoris 0,11,0x8000
	la 8,.LC92@l(8)
	stw 0,12(1)
	mr 7,11
	stw 10,8(1)
	lfd 13,0(8)
	b .L93
.L75:
	lwz 11,40(4)
	lis 10,0x4330
	lis 5,.LC92@ha
	xoris 0,11,0x8000
	la 5,.LC92@l(5)
	stw 0,12(1)
	mr 7,11
	stw 10,8(1)
	lfd 13,0(5)
.L93:
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,1,.L88
	fcmpu 0,0,11
	bc 12,0,.L88
	lha 0,32(4)
	cmpwi 0,0,0
	bc 12,0,.L83
	xoris 0,7,0x8000
	lwz 10,84(3)
	stw 0,12(1)
	lis 11,0x4330
	lis 8,.LC92@ha
	la 8,.LC92@l(8)
	stw 11,8(1)
	addi 10,10,1960
	lfd 13,0(8)
	lfd 0,8(1)
	lhz 0,36(4)
	fsub 0,0,13
	slwi 0,0,2
	lfsx 1,10,0
	frsp 0,0
	fcmpu 0,0,1
	bc 4,1,.L86
	cmpwi 0,6,0
	bc 12,2,.L88
	lis 9,gi+4@ha
	lis 3,.LC89@ha
	lwz 0,gi+4@l(9)
	la 3,.LC89@l(3)
	b .L92
.L83:
	neg 0,7
	lwz 10,84(3)
	xoris 0,0,0x8000
	lis 8,0x4330
	lhz 9,36(4)
	stw 0,12(1)
	lis 5,.LC92@ha
	addi 10,10,1960
	la 5,.LC92@l(5)
	stw 8,8(1)
	slwi 9,9,2
	lfd 13,0(5)
	lfd 0,8(1)
	lfsx 1,10,9
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,1
	bc 4,1,.L86
	cmpwi 0,6,0
	bc 12,2,.L88
	lis 9,gi+4@ha
	lis 3,.LC90@ha
	lwz 0,gi+4@l(9)
	la 3,.LC90@l(3)
.L92:
	mr 4,7
	mtlr 0
	creqv 6,6,6
	blrl
.L88:
	li 3,0
	b .L89
.L86:
	li 3,1
.L89:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe2:
	.size	 Force_Power_Available,.Lfe2-Force_Power_Available
	.section	".rodata"
	.align 2
.LC93:
	.long 0x0
	.align 3
.LC94:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl force_unlearn
	.type	 force_unlearn,@function
force_unlearn:
	stwu 1,-32(1)
	stw 31,28(1)
	lis 11,.LC93@ha
	lis 9,deathmatch@ha
	la 11,.LC93@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L106
	lis 11,powerlist@ha
	mulli 9,4,44
	la 11,powerlist@l(11)
	add 9,9,11
	lha 6,32(9)
	cmpwi 0,6,0
	bc 12,2,.L106
	addi 5,11,76
	lis 9,.LC94@ha
	li 11,22
	la 9,.LC94@l(9)
	mtctr 11
	lfd 12,0(9)
	mr 10,4
	li 12,0
	li 7,1
	lis 31,0x4330
	li 8,4
.L120:
	lha 0,0(5)
	addi 5,5,44
	cmpw 0,0,6
	bc 12,2,.L111
	cmpwi 0,0,0
	bc 12,2,.L111
	xoris 0,12,0x8000
	lwz 9,84(3)
	stw 0,20(1)
	stw 31,16(1)
	addi 9,9,1984
	lfd 0,16(1)
	lfsx 13,9,8
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L111
	fmr 0,13
	mr 9,11
	mr 10,7
	fctiwz 13,0
	stfd 13,16(1)
	lwz 12,20(1)
.L111:
	addi 8,8,4
	addi 7,7,1
	bdnz .L120
	cmpw 0,10,4
	bc 12,2,.L106
	lwz 11,84(3)
	slwi 0,10,2
	lis 9,.LC93@ha
	la 9,.LC93@l(9)
	addi 11,11,1984
	lfs 13,0(9)
	lfsx 0,11,0
	fsubs 0,0,1
	stfsx 0,11,0
	lwz 9,84(3)
	addi 3,9,1984
	lfsx 0,3,0
	fcmpu 0,0,13
	bc 4,0,.L106
	stfsx 13,3,0
.L106:
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 force_unlearn,.Lfe3-force_unlearn
	.section	".rodata"
	.align 2
.LC95:
	.long 0x0
	.align 2
.LC96:
	.long 0x447a0000
	.align 2
.LC97:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl force_learn
	.type	 force_learn,@function
force_learn:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 30,16(1)
	stw 0,36(1)
	mr. 30,4
	mr 31,3
	bc 12,2,.L130
	lis 9,.LC95@ha
	lis 11,deathmatch@ha
	la 9,.LC95@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L130
	lwz 11,84(31)
	lis 9,.LC96@ha
	slwi 0,30,2
	la 9,.LC96@l(9)
	addi 11,11,1984
	lfs 12,0(9)
	lfsx 0,11,0
	lis 9,.LC97@ha
	la 9,.LC97@l(9)
	lfs 13,0(9)
	fdivs 1,12,0
	fadds 0,0,1
	fdivs 31,1,13
	stfsx 0,11,0
	lwz 9,84(31)
	addi 9,9,1984
	lfsx 0,9,0
	fcmpu 0,0,12
	bc 4,1,.L133
	stfsx 12,9,0
.L133:
	mr 3,31
	mr 4,30
	bl force_unlearn
	mulli 0,30,44
	lis 9,powerlist@ha
	li 7,1
	la 9,powerlist@l(9)
	li 10,4
	add 6,0,9
	addi 8,9,80
	li 0,22
	mtctr 0
.L143:
	lhz 9,0(8)
	lhz 0,36(6)
	addi 8,8,44
	cmpw 0,9,0
	bc 4,2,.L139
	cmpw 0,7,30
	bc 12,2,.L139
	lwz 11,84(31)
	lis 9,.LC96@ha
	la 9,.LC96@l(9)
	addi 11,11,1984
	lfs 13,0(9)
	lfsx 0,11,10
	fadds 0,0,31
	stfsx 0,11,10
	lwz 9,84(31)
	addi 9,9,1984
	lfsx 0,9,10
	fcmpu 0,0,13
	bc 4,1,.L139
	stfsx 13,9,10
.L139:
	addi 10,10,4
	addi 7,7,1
	bdnz .L143
.L130:
	lwz 0,36(1)
	mtlr 0
	lmw 30,16(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 force_learn,.Lfe4-force_learn
	.section	".rodata"
	.align 2
.LC99:
	.string	"killsound.wav"
	.align 3
.LC100:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC101:
	.long 0x41200000
	.align 2
.LC102:
	.long 0x0
	.align 2
.LC103:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Check_Active_Powers
	.type	 Check_Active_Powers,@function
Check_Active_Powers:
	stwu 1,-80(1)
	mflr 0
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 18,8(1)
	stw 0,84(1)
	mr 31,3
	li 0,0
	lwz 11,84(31)
	li 30,0
	sth 0,154(11)
	lwz 9,84(31)
	sth 0,156(9)
	lwz 11,84(31)
	sth 0,158(11)
	lwz 9,84(31)
	lhz 0,2104(9)
	cmpw 0,30,0
	bc 4,0,.L152
	lis 9,powerlist+8@ha
	lis 11,.LC100@ha
	la 22,powerlist+8@l(9)
	lfd 31,.LC100@l(11)
	lis 23,gi@ha
	lis 9,level@ha
	addi 24,22,20
	la 25,level@l(9)
	la 18,gi@l(23)
	lis 9,.LC101@ha
	li 26,255
	la 9,.LC101@l(9)
	lis 27,.LC99@ha
	lfs 30,0(9)
	li 20,2
	li 29,0
	li 21,4
	li 19,6
.L154:
	cmpwi 0,30,1
	bc 12,2,.L161
	bc 12,1,.L178
	cmpwi 0,30,0
	bc 12,2,.L156
	b .L153
.L178:
	cmpwi 0,30,2
	bc 12,2,.L166
	cmpwi 0,30,3
	bc 12,2,.L171
	b .L153
.L156:
	lwz 9,84(31)
	mr 3,31
	la 28,gi@l(23)
	addi 9,9,2092
	lhzx 4,9,30
	bl force_learn
	lwz 9,84(31)
	lwz 11,40(28)
	addi 9,9,2092
	lhzx 0,9,30
	mtlr 11
	mulli 0,0,44
	lwzx 3,22,0
	blrl
	lwz 9,84(31)
	sth 3,154(9)
	lwz 11,84(31)
	addi 9,11,2092
	lhzx 0,9,30
	cmpwi 0,0,5
	bc 12,2,.L153
	lfs 0,4456(11)
	lfs 13,4(25)
	fcmpu 0,0,13
	bc 12,1,.L153
	fmr 0,13
	mulli 0,0,44
	lis 9,.LC102@ha
	la 9,.LC102@l(9)
	lfs 12,0(9)
	fadd 0,0,31
	frsp 0,0
	stfs 0,4456(11)
	lfsx 13,24,0
	lwz 9,84(31)
	fdivs 13,13,30
	lfs 0,1852(9)
	fsubs 0,0,13
	stfs 0,1852(9)
	lwz 9,84(31)
	lfs 0,1852(9)
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L153
	stfs 12,1852(9)
	la 3,.LC99@l(27)
	lwz 9,84(31)
	sth 30,2092(9)
	lwz 11,84(31)
	sth 30,2094(11)
	lwz 9,84(31)
	sth 30,2096(9)
	lwz 11,84(31)
	sth 30,2098(11)
	lwz 9,84(31)
	sth 30,2104(9)
	b .L180
.L161:
	lwz 9,84(31)
	mr 3,31
	la 28,gi@l(23)
	addi 9,9,2092
	lhzx 4,9,20
	bl force_learn
	lwz 9,84(31)
	lwz 11,40(28)
	addi 9,9,2092
	lhzx 0,9,20
	mtlr 11
	mulli 0,0,44
	lwzx 3,22,0
	blrl
	lwz 9,84(31)
	sth 3,156(9)
	lwz 11,84(31)
	addi 9,11,2092
	lhzx 0,9,20
	b .L181
.L166:
	lwz 9,84(31)
	mr 3,31
	la 28,gi@l(23)
	addi 9,9,2092
	lhzx 4,9,21
	bl force_learn
	lwz 9,84(31)
	lwz 11,40(28)
	addi 9,9,2092
	lhzx 0,9,21
	mtlr 11
	mulli 0,0,44
	lwzx 3,22,0
	blrl
	lwz 9,84(31)
	sth 3,158(9)
	lwz 11,84(31)
	addi 9,11,2092
	lhzx 0,9,21
.L181:
	cmpwi 0,0,5
	bc 12,2,.L153
	lfs 0,4456(11)
	lfs 13,4(25)
	fcmpu 0,0,13
	bc 12,1,.L153
	fmr 0,13
	mulli 0,0,44
	lis 9,.LC102@ha
	la 9,.LC102@l(9)
	lfs 12,0(9)
	fadd 0,0,31
	frsp 0,0
	stfs 0,4456(11)
	lfsx 13,24,0
	lwz 9,84(31)
	fdivs 13,13,30
	lfs 0,1852(9)
	fsubs 0,0,13
	stfs 0,1852(9)
	lwz 9,84(31)
	lfs 0,1852(9)
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L153
	stfs 12,1852(9)
	la 3,.LC99@l(27)
	lwz 9,84(31)
	sth 29,2092(9)
	lwz 11,84(31)
	sth 29,2094(11)
	lwz 9,84(31)
	sth 29,2096(9)
	lwz 11,84(31)
	sth 29,2098(11)
	lwz 9,84(31)
	sth 29,2104(9)
.L180:
	stw 26,40(31)
	lwz 9,36(28)
	mtlr 9
	blrl
	lis 9,.LC103@ha
	lwz 0,16(28)
	mr 5,3
	la 9,.LC103@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC103@ha
	la 9,.LC103@l(9)
	lfs 2,0(9)
	lis 9,.LC102@ha
	la 9,.LC102@l(9)
	lfs 3,0(9)
	blrl
	b .L153
.L171:
	lwz 9,84(31)
	mr 3,31
	addi 9,9,2092
	lhzx 4,9,19
	bl force_learn
	lwz 11,84(31)
	addi 9,11,2092
	lhzx 0,9,19
	cmpwi 0,0,5
	bc 12,2,.L153
	lfs 0,4456(11)
	lfs 13,4(25)
	fcmpu 0,0,13
	bc 12,1,.L153
	fmr 0,13
	mulli 0,0,44
	lis 9,.LC102@ha
	la 9,.LC102@l(9)
	lfs 12,0(9)
	fadd 0,0,31
	frsp 0,0
	stfs 0,4456(11)
	lfsx 13,24,0
	lwz 9,84(31)
	fdivs 13,13,30
	lfs 0,1852(9)
	fsubs 0,0,13
	stfs 0,1852(9)
	lwz 9,84(31)
	lfs 0,1852(9)
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L153
	stfs 12,1852(9)
	la 3,.LC99@l(27)
	lwz 9,84(31)
	sth 29,2092(9)
	lwz 11,84(31)
	sth 29,2094(11)
	lwz 9,84(31)
	sth 29,2096(9)
	lwz 11,84(31)
	sth 29,2098(11)
	lwz 9,84(31)
	sth 29,2104(9)
	stw 26,40(31)
	lwz 9,36(18)
	mtlr 9
	blrl
	lis 9,.LC103@ha
	lwz 11,16(18)
	mr 5,3
	la 9,.LC103@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 11
	lis 9,.LC103@ha
	la 9,.LC103@l(9)
	lfs 2,0(9)
	lis 9,.LC102@ha
	la 9,.LC102@l(9)
	lfs 3,0(9)
	blrl
.L153:
	lwz 9,84(31)
	addi 30,30,1
	lhz 0,2104(9)
	cmpw 0,30,0
	bc 12,0,.L154
.L152:
	lwz 0,84(1)
	mtlr 0
	lmw 18,8(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe5:
	.size	 Check_Active_Powers,.Lfe5-Check_Active_Powers
	.section	".rodata"
	.align 2
.LC104:
	.long 0x42480000
	.align 3
.LC105:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl check_new_powers_available
	.type	 check_new_powers_available,@function
check_new_powers_available:
	stwu 1,-16(1)
	lis 9,.LC104@ha
	lwz 11,84(3)
	li 0,22
	la 9,.LC104@l(9)
	lis 10,.LC105@ha
	mtctr 0
	lfs 13,0(9)
	la 10,.LC105@l(10)
	lis 6,0x4330
	lfs 0,1956(11)
	lis 9,powerlist@ha
	li 7,1
	la 9,powerlist@l(9)
	lfd 11,0(10)
	addi 8,9,44
	li 10,4
	fsubs 12,0,13
	fadds 13,0,13
.L193:
	lwz 9,84(3)
	addi 11,9,1856
	lwzx 0,11,10
	cmpwi 0,0,1
	bc 12,2,.L185
	lha 0,32(8)
	cmpwi 0,0,0
	bc 12,2,.L185
	lwz 0,40(8)
	xoris 0,0,0x8000
	stw 0,12(1)
	stw 6,8(1)
	lfd 0,8(1)
	fsub 0,0,11
	frsp 0,0
	fcmpu 0,0,13
	bc 4,0,.L185
	fcmpu 0,0,12
	bc 4,1,.L185
	stwx 7,11,10
	lwz 9,84(3)
	lfs 0,24(8)
	addi 9,9,1984
	stfsx 0,9,10
.L185:
	addi 8,8,44
	addi 10,10,4
	bdnz .L193
	la 1,16(1)
	blr
.Lfe6:
	.size	 check_new_powers_available,.Lfe6-check_new_powers_available
	.section	".rodata"
	.align 2
.LC106:
	.long 0x3f800000
	.align 2
.LC107:
	.long 0x0
	.section	".text"
	.align 2
	.globl Think_Force
	.type	 Think_Force,@function
Think_Force:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lhz 0,946(31)
	andi. 9,0,2
	bc 4,2,.L196
	lhz 0,948(31)
	andi. 0,0,16
	bc 12,2,.L195
.L196:
	li 0,0
	sth 0,948(31)
	sth 0,944(31)
	sth 0,946(31)
	b .L194
.L195:
	lwz 10,492(31)
	sth 0,948(31)
	cmpwi 0,10,0
	sth 0,944(31)
	sth 0,946(31)
	bc 4,2,.L194
	lwz 11,84(31)
	lwz 0,4140(11)
	mr 8,11
	lwz 9,4132(11)
	or 0,0,9
	andi. 0,0,2
	bc 12,2,.L198
	lhz 0,4716(11)
	cmpwi 0,0,1
	bc 4,2,.L199
	mr 3,31
	bl select_menu_power
	lis 11,.LC106@ha
	lis 9,level+4@ha
	la 11,.LC106@l(11)
	lfs 0,level+4@l(9)
	lfs 13,0(11)
	lwz 11,84(31)
	fsubs 0,0,13
	stfs 0,4476(11)
	b .L194
.L199:
	lhz 0,4468(11)
	cmpwi 0,0,0
	bc 12,2,.L200
	lwz 9,2076(11)
	lhz 0,34(9)
	cmpwi 0,0,2
	bc 12,2,.L200
	sth 10,152(11)
	b .L194
.L218:
	mr 4,30
	b .L207
.L200:
	lwz 11,2076(8)
	lis 9,powerlist@ha
	li 30,0
	la 29,powerlist@l(9)
	lwz 28,20(11)
.L203:
	lwz 3,20(29)
	cmpwi 0,3,0
	bc 12,2,.L205
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L218
.L205:
	addi 30,30,1
	addi 29,29,44
	cmpwi 0,30,22
	bc 4,1,.L203
	li 4,0
.L207:
	cmpwi 0,4,0
	bc 4,2,.L210
	li 30,0
	b .L211
.L210:
	mulli 0,4,44
	lis 9,powerlist@ha
	la 9,powerlist@l(9)
	add 30,0,9
.L211:
	mr 3,31
	bl Force_Power_Available
	cmpwi 0,3,0
	bc 12,2,.L219
	lwz 9,84(31)
	li 0,1
	lfs 13,28(30)
	lfs 0,1852(9)
	fcmpu 0,0,13
	bc 4,0,.L213
.L219:
	li 0,0
.L213:
	cmpwi 0,0,0
	bc 12,2,.L194
	lwz 11,84(31)
	mr 3,31
	li 4,1
	lwz 9,2076(11)
	lwz 0,0(9)
	mtlr 0
	blrl
	lwz 9,84(31)
	li 0,1
	sth 0,4468(9)
	lwz 11,84(31)
	lwz 9,2076(11)
	lhz 0,34(9)
	cmpwi 0,0,1
	bc 12,2,.L194
	lhz 4,2106(11)
	mr 3,31
	bl force_learn
	lwz 10,84(31)
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	lwz 11,2076(10)
	mtlr 0
	lwz 3,8(11)
	blrl
	lis 9,.LC107@ha
	la 9,.LC107@l(9)
	lfs 12,0(9)
	lwz 9,84(31)
	sth 3,152(9)
	lwz 11,84(31)
	lwz 9,2076(11)
	lfs 0,1852(11)
	lfs 13,28(9)
	fsubs 0,0,13
	stfs 0,1852(11)
	lwz 9,84(31)
	lfs 0,1852(9)
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L194
	stfs 12,1852(9)
	li 0,0
	li 10,255
	lwz 9,84(31)
	sth 0,2092(9)
	lwz 11,84(31)
	sth 0,2094(11)
	lwz 9,84(31)
	sth 0,2096(9)
	lwz 11,84(31)
	sth 0,2098(11)
	lwz 9,84(31)
	sth 0,2104(9)
	stw 10,40(31)
	b .L194
.L198:
	sth 0,152(11)
	lwz 9,84(31)
	sth 0,4468(9)
.L194:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 Think_Force,.Lfe7-Think_Force
	.align 2
	.globl Think_Force_hold
	.type	 Think_Force_hold,@function
Think_Force_hold:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	lwz 9,84(30)
	lwz 11,4140(9)
	lwz 0,4132(9)
	or 0,11,0
	andi. 10,0,2
	bc 12,2,.L221
	rlwinm 0,11,0,31,29
	li 10,1
	stw 0,4140(9)
	li 4,0
	lwz 9,84(30)
	sth 10,4468(9)
	lwz 11,84(30)
	lwz 9,2076(11)
	lwz 0,0(9)
	mtlr 0
	blrl
	lwz 10,84(30)
	lis 9,gi+40@ha
	lwz 0,gi+40@l(9)
	lwz 11,2076(10)
	mtlr 0
	lwz 3,8(11)
	blrl
	lwz 9,84(30)
	sth 3,152(9)
	b .L220
.L233:
	mr 4,31
	b .L230
.L221:
	lhz 0,4468(9)
	cmpwi 0,0,0
	bc 12,2,.L220
	lwz 11,2076(9)
	li 31,0
	lis 9,powerlist@ha
	lwz 28,20(11)
	la 29,powerlist@l(9)
.L226:
	lwz 3,20(29)
	cmpwi 0,3,0
	bc 12,2,.L228
	mr 4,28
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L233
.L228:
	addi 31,31,1
	addi 29,29,44
	cmpwi 0,31,22
	bc 4,1,.L226
	li 4,0
.L230:
	mr 3,30
	bl Force_Power_Available
	cmpwi 0,3,0
	bc 12,2,.L220
	lwz 11,84(30)
	mr 3,30
	li 4,1
	lwz 9,2076(11)
	lwz 0,0(9)
	mtlr 0
	blrl
	lwz 11,84(30)
	li 0,0
	li 10,0
	li 8,0
	sth 0,4468(11)
	lwz 9,84(30)
	stw 10,4456(9)
	lwz 11,84(30)
	stw 8,4460(11)
	lwz 9,84(30)
	sth 8,152(9)
.L220:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 Think_Force_hold,.Lfe8-Think_Force_hold
	.section	".rodata"
	.align 2
.LC109:
	.string	"sprites/s_flash.sp2"
	.align 2
.LC110:
	.long 0x46fffe00
	.align 3
.LC111:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC112:
	.long 0x44fa0000
	.align 3
.LC113:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC114:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl heal_effect_spawn
	.type	 heal_effect_spawn,@function
heal_effect_spawn:
	stwu 1,-64(1)
	mflr 0
	stmw 27,44(1)
	stw 0,68(1)
	mr 29,3
	mr 28,4
	lfs 11,0(29)
	mr 27,5
	addi 3,1,8
	lfs 12,4(28)
	lfs 10,4(29)
	lfs 13,8(28)
	fsubs 12,12,11
	lfs 0,12(28)
	lfs 11,8(29)
	fsubs 13,13,10
	stfs 12,8(1)
	fsubs 0,0,11
	stfs 13,12(1)
	stfs 0,16(1)
	bl VectorNormalize
	bl G_Spawn
	lfs 13,0(29)
	mr 31,3
	lis 9,.LC112@ha
	la 9,.LC112@l(9)
	addi 3,1,8
	lfs 1,0(9)
	addi 4,31,376
	stfs 13,4(31)
	lfs 0,4(29)
	stfs 0,8(31)
	lfs 13,8(29)
	stfs 13,12(31)
	bl VectorScale
	li 9,0
	li 0,8
	stw 0,260(31)
	lis 11,gi+32@ha
	lis 3,.LC109@ha
	stw 9,248(31)
	la 3,.LC109@l(3)
	stw 9,532(31)
	lwz 0,gi+32@l(11)
	mtlr 0
	blrl
	cmpwi 0,27,0
	stw 3,40(31)
	stw 28,256(31)
	bc 12,2,.L239
	lwz 0,64(31)
	oris 0,0,0x400
	b .L243
.L239:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,36(1)
	lis 10,.LC113@ha
	lis 11,.LC110@ha
	la 10,.LC113@l(10)
	stw 0,32(1)
	lfd 13,0(10)
	lfd 0,32(1)
	lis 10,.LC114@ha
	lfs 12,.LC110@l(11)
	la 10,.LC114@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,1,.L241
	lwz 0,64(31)
	oris 0,0,0x4
	b .L243
.L241:
	lwz 0,64(31)
	oris 0,0,0x8
.L243:
	stw 0,64(31)
	lwz 0,64(31)
	lis 11,0xc040
	lis 10,0x4040
	stw 11,196(31)
	lis 8,level+4@ha
	lis 7,.LC111@ha
	ori 0,0,8192
	stw 10,208(31)
	lis 9,heal_effect_update@ha
	stw 0,64(31)
	la 9,heal_effect_update@l(9)
	lis 6,gi+72@ha
	stw 11,188(31)
	mr 3,31
	stw 11,192(31)
	stw 10,200(31)
	stw 10,204(31)
	lfs 0,level+4@l(8)
	lfd 13,.LC111@l(7)
	stw 9,436(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,gi+72@l(6)
	mtlr 0
	blrl
	lwz 0,68(1)
	mtlr 0
	lmw 27,44(1)
	la 1,64(1)
	blr
.Lfe9:
	.size	 heal_effect_spawn,.Lfe9-heal_effect_spawn
	.section	".rodata"
	.align 2
.LC116:
	.string	"worldspawn"
	.align 3
.LC117:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC118:
	.long 0x44800000
	.align 2
.LC119:
	.long 0x0
	.align 2
.LC120:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl force_push_hold
	.type	 force_push_hold,@function
force_push_hold:
	stwu 1,-160(1)
	mflr 0
	stmw 28,144(1)
	stw 0,164(1)
	mr 31,3
	addi 30,1,56
	lwz 3,84(31)
	mr 28,4
	li 5,0
	mr 4,30
	li 6,0
	addi 3,3,4252
	bl AngleVectors
	lwz 9,84(31)
	lwz 0,4460(9)
	cmpwi 0,0,0
	bc 4,2,.L251
	lwz 0,508(31)
	lis 11,0x4330
	lis 10,.LC117@ha
	lfs 12,12(31)
	addi 29,1,24
	xoris 0,0,0x8000
	la 10,.LC117@l(10)
	lfs 10,4(31)
	stw 0,140(1)
	addi 3,1,8
	mr 4,30
	stw 11,136(1)
	mr 5,29
	lfd 11,0(10)
	lfd 0,136(1)
	lis 10,.LC118@ha
	lfs 13,8(31)
	la 10,.LC118@l(10)
	lfs 1,0(10)
	fsub 0,0,11
	stfs 10,8(1)
	stfs 13,12(1)
	frsp 0,0
	fadds 12,12,0
	stfs 12,16(1)
	bl VectorMA
	lis 9,gi+48@ha
	mr 7,29
	lwz 0,gi+48@l(9)
	addi 3,1,72
	addi 4,1,8
	li 9,-1
	li 5,0
	li 6,0
	mr 8,31
	mtlr 0
	blrl
	lwz 9,124(1)
	cmpwi 0,9,0
	bc 12,2,.L250
	lwz 3,280(9)
	lis 4,.LC116@ha
	la 4,.LC116@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L250
	lwz 11,124(1)
	lwz 0,248(11)
	cmpwi 0,0,2
	bc 4,2,.L250
	lwz 9,84(31)
	stw 11,4460(9)
.L251:
	lwz 11,84(31)
	lis 9,.LC119@ha
	la 9,.LC119@l(9)
	lfs 13,0(9)
	lfs 0,4456(11)
	fcmpu 0,0,13
	bc 4,2,.L254
	lis 9,level@ha
	la 9,level@l(9)
	lfs 0,4(9)
	stfs 0,4456(11)
.L254:
	lwz 11,84(31)
	lis 9,level+4@ha
	cmpwi 0,28,0
	lfs 13,level+4@l(9)
	lfs 0,4456(11)
	fsubs 13,13,0
	bc 12,2,.L250
	lis 10,.LC120@ha
	mr 3,30
	la 10,.LC120@l(10)
	addi 4,1,40
	lfs 1,0(10)
	fmuls 1,13,1
	bl VectorScale
	lwz 9,84(31)
	lfs 13,40(1)
	lwz 11,4460(9)
	lfs 0,376(11)
	fadds 0,0,13
	stfs 0,376(11)
	lwz 9,84(31)
	lfs 13,44(1)
	lwz 11,4460(9)
	lfs 0,380(11)
	fadds 0,0,13
	stfs 0,380(11)
	lwz 9,84(31)
	lfs 13,48(1)
	lwz 11,4460(9)
	lfs 0,384(11)
	fadds 0,0,13
	stfs 0,384(11)
.L250:
	lwz 0,164(1)
	mtlr 0
	lmw 28,144(1)
	la 1,160(1)
	blr
.Lfe10:
	.size	 force_push_hold,.Lfe10-force_push_hold
	.section	".rodata"
	.align 2
.LC121:
	.string	"func_button"
	.align 2
.LC122:
	.long 0x3f800000
	.align 2
.LC123:
	.long 0x3f000000
	.align 2
.LC124:
	.long 0x41200000
	.align 2
.LC125:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl fire_airburst
	.type	 fire_airburst,@function
fire_airburst:
	stwu 1,-176(1)
	mflr 0
	stfd 28,144(1)
	stfd 29,152(1)
	stfd 30,160(1)
	stfd 31,168(1)
	stmw 29,132(1)
	stw 0,180(1)
	mr 31,3
	mr 29,4
	lwz 9,84(31)
	mr 4,5
	mr 3,29
	addi 5,1,8
	lfs 30,1988(9)
	fadds 1,30,30
	bl VectorMA
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	ori 9,9,27
	mr 4,29
	addi 3,1,40
	li 5,0
	li 6,0
	addi 7,1,8
	mtlr 0
	mr 8,31
	blrl
	lis 9,.LC122@ha
	lfs 13,48(1)
	la 9,.LC122@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L262
	lwz 9,92(1)
	lis 4,.LC121@ha
	la 4,.LC121@l(4)
	lwz 3,280(9)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L264
	mr 4,31
	lwz 3,92(1)
	mr 5,4
	bl button_use
	b .L262
.L264:
	lwz 9,92(1)
	lwz 0,184(9)
	andi. 11,0,4
	bc 4,2,.L266
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L265
.L266:
	addi 29,1,24
	addi 3,31,16
	mr 4,29
	li 5,0
	li 6,0
	bl AngleVectors
	lis 9,.LC123@ha
	mr 3,29
	la 9,.LC123@l(9)
	mr 4,3
	lfs 1,0(9)
	fmuls 1,30,1
	bl VectorScale
	lwz 9,92(1)
	lfs 0,24(1)
	lfs 13,376(9)
	fadds 0,0,13
	stfs 0,376(9)
	lwz 11,92(1)
	lfs 0,28(1)
	lfs 13,380(11)
	fadds 0,0,13
	stfs 0,380(11)
	lwz 9,92(1)
	lfs 0,32(1)
	lfs 13,384(9)
	fadds 0,0,13
	stfs 0,384(9)
	b .L262
.L265:
	lwz 0,248(9)
	cmpwi 0,0,3
	bc 4,2,.L262
	mr 3,31
	addi 4,1,52
	li 5,2
	li 29,0
	bl PlayerNoise
	lis 9,.LC122@ha
	lis 11,.LC124@ha
	la 9,.LC122@l(9)
	la 11,.LC124@l(11)
	lfs 28,0(9)
	lfs 29,0(11)
	b .L269
.L271:
	lwz 0,512(29)
	cmpwi 0,0,0
	bc 12,2,.L269
	lfs 13,4(29)
	addi 3,1,104
	lfs 0,52(1)
	lfs 12,56(1)
	lfs 11,60(1)
	fsubs 13,13,0
	stfs 13,104(1)
	lfs 0,8(29)
	fsubs 0,0,12
	stfs 0,108(1)
	lfs 13,12(29)
	fsubs 13,13,11
	stfs 13,112(1)
	bl VectorLength
	fdivs 31,28,1
	addi 3,1,104
	fmuls 31,30,31
	fmuls 31,31,29
	bl VectorNormalize
	addi 3,1,104
	fmr 1,31
	mr 4,3
	bl VectorScale
	lfs 13,104(1)
	lfs 0,376(29)
	lfs 12,380(29)
	lfs 11,384(29)
	fadds 13,13,0
	stfs 13,376(29)
	lfs 0,108(1)
	fadds 0,0,12
	stfs 0,380(29)
	lfs 13,112(1)
	fadds 13,13,11
	stfs 13,384(29)
.L269:
	lis 9,.LC125@ha
	mr 3,29
	la 9,.LC125@l(9)
	addi 4,1,52
	lfs 1,0(9)
	bl findradius
	mr. 29,3
	bc 4,2,.L271
.L262:
	lwz 0,180(1)
	mtlr 0
	lmw 29,132(1)
	lfd 28,144(1)
	lfd 29,152(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe11:
	.size	 fire_airburst,.Lfe11-fire_airburst
	.section	".rodata"
	.align 2
.LC126:
	.string	"force/pull.wav"
	.align 2
.LC127:
	.long 0x447a0000
	.align 2
.LC128:
	.long 0x40400000
	.align 3
.LC129:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC130:
	.long 0x3f000000
	.align 2
.LC131:
	.long 0x3f800000
	.align 2
.LC132:
	.long 0x0
	.section	".text"
	.align 2
	.globl force_push
	.type	 force_push,@function
force_push:
	stwu 1,-112(1)
	mflr 0
	stfd 31,104(1)
	stmw 29,92(1)
	stw 0,116(1)
	mr 31,3
	addi 4,1,24
	lwz 3,84(31)
	addi 5,1,40
	li 6,0
	addi 3,3,4252
	bl AngleVectors
	lwz 4,84(31)
	lis 9,.LC127@ha
	addi 3,1,24
	la 9,.LC127@l(9)
	lfs 0,0(9)
	lfs 31,1988(4)
	lis 9,.LC128@ha
	la 9,.LC128@l(9)
	addi 4,4,4200
	lfs 13,0(9)
	fdivs 31,31,0
	fmuls 31,31,13
	fneg 31,31
	fmr 1,31
	bl VectorScale
	lwz 9,84(31)
	lis 29,0x4330
	li 0,0
	lis 10,0x40e0
	stfs 31,4188(9)
	addi 5,1,56
	addi 7,1,40
	lis 9,.LC129@ha
	lwz 3,84(31)
	addi 8,1,8
	la 9,.LC129@l(9)
	addi 6,1,24
	lfd 13,0(9)
	addi 4,31,4
	lwz 9,508(31)
	stw 0,56(1)
	addi 9,9,-8
	stw 10,60(1)
	xoris 9,9,0x8000
	stw 9,84(1)
	stw 29,80(1)
	lfd 0,80(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	bl P_ProjectSource
	addi 4,1,8
	addi 5,1,24
	mr 3,31
	bl fire_airburst
	mr 3,31
	addi 4,1,8
	li 5,1
	bl PlayerNoise
	lwz 11,84(31)
	lwz 9,4808(11)
	cmpwi 0,9,0
	bc 12,1,.L278
	li 0,1
	stw 0,4804(11)
	lwz 11,84(31)
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L279
	li 0,111
	li 9,116
	b .L292
.L279:
	li 0,70
	li 9,81
.L292:
	stw 0,56(31)
	stw 9,4308(11)
	mr 3,31
	bl ForceAnimCD
	b .L281
.L278:
	cmpwi 0,9,1
	bc 4,2,.L281
	lwz 0,4804(11)
	cmpwi 0,0,1
	bc 4,2,.L283
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L284
	li 0,113
	li 9,116
	b .L293
.L284:
	li 0,72
	li 9,75
.L293:
	stw 0,56(31)
	stw 9,4308(11)
	b .L281
.L283:
	stw 9,4804(11)
	lwz 11,84(31)
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L287
	li 0,111
	li 9,116
	b .L294
.L287:
	li 0,70
	li 9,81
.L294:
	stw 0,56(31)
	stw 9,4308(11)
	mr 3,31
	bl ForceAnimCD
.L281:
	lwz 9,84(31)
	lwz 0,4796(9)
	cmpwi 0,0,0
	bc 4,2,.L289
	lis 9,.LC130@ha
	li 4,0
	la 9,.LC130@l(9)
	mr 3,31
	lfs 1,0(9)
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC126@ha
	la 29,gi@l(29)
	la 3,.LC126@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC131@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC131@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC131@ha
	la 9,.LC131@l(9)
	lfs 2,0(9)
	lis 9,.LC132@ha
	la 9,.LC132@l(9)
	lfs 3,0(9)
	blrl
	b .L290
.L289:
	cmpwi 0,0,2
	bc 4,2,.L290
	lis 9,.LC130@ha
	li 4,0
	la 9,.LC130@l(9)
	mr 3,31
	lfs 1,0(9)
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC126@ha
	la 29,gi@l(29)
	la 3,.LC126@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC131@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC131@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC131@ha
	la 9,.LC131@l(9)
	lfs 2,0(9)
	lis 9,.LC132@ha
	la 9,.LC132@l(9)
	lfs 3,0(9)
	blrl
.L290:
	lwz 0,116(1)
	mtlr 0
	lmw 29,92(1)
	lfd 31,104(1)
	la 1,112(1)
	blr
.Lfe12:
	.size	 force_push,.Lfe12-force_push
	.section	".rodata"
	.align 3
.LC133:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC134:
	.long 0x44800000
	.align 2
.LC135:
	.long 0x3f000000
	.align 2
.LC136:
	.long 0x3f800000
	.align 2
.LC137:
	.long 0x0
	.align 2
.LC138:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl force_pull
	.type	 force_pull,@function
force_pull:
	stwu 1,-192(1)
	mflr 0
	stfd 31,184(1)
	stmw 28,168(1)
	stw 0,196(1)
	mr 31,3
	addi 29,1,40
	lwz 3,84(31)
	addi 28,1,24
	li 6,0
	mr 4,29
	li 5,0
	addi 3,3,4252
	mr 30,29
	bl AngleVectors
	lwz 0,508(31)
	lis 11,0x4330
	lis 10,.LC133@ha
	lfs 12,12(31)
	addi 3,1,8
	xoris 0,0,0x8000
	la 10,.LC133@l(10)
	lfs 10,4(31)
	stw 0,164(1)
	mr 4,29
	mr 5,28
	stw 11,160(1)
	lfd 11,0(10)
	lfd 0,160(1)
	lis 10,.LC134@ha
	lfs 13,8(31)
	la 10,.LC134@l(10)
	lfs 1,0(10)
	fsub 0,0,11
	stfs 10,8(1)
	stfs 13,12(1)
	frsp 0,0
	fadds 12,12,0
	stfs 12,16(1)
	bl VectorMA
	lis 9,gi+48@ha
	mr 7,28
	lwz 0,gi+48@l(9)
	addi 3,1,88
	addi 4,1,8
	li 5,0
	li 6,0
	mtlr 0
	mr 8,31
	lis 9,0x600
	blrl
	lwz 11,84(31)
	lwz 0,4808(11)
	cmpwi 0,0,0
	bc 12,1,.L296
	li 0,2
	stw 0,4804(11)
	lwz 11,84(31)
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L297
	li 0,111
	li 9,116
	b .L318
.L297:
	li 0,70
	li 9,81
.L318:
	stw 0,56(31)
	stw 9,4308(11)
	mr 3,31
	bl ForceAnimCD
	b .L299
.L296:
	cmpwi 0,0,1
	bc 4,2,.L299
	lwz 0,4804(11)
	cmpwi 0,0,2
	bc 4,2,.L301
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L302
	li 0,113
	li 9,116
	b .L319
.L302:
	li 0,72
	li 9,75
.L319:
	stw 0,56(31)
	stw 9,4308(11)
	b .L299
.L301:
	li 0,2
	stw 0,4804(11)
	lwz 11,84(31)
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L305
	li 0,111
	li 9,116
	b .L320
.L305:
	li 0,70
	li 9,81
.L320:
	stw 0,56(31)
	stw 9,4308(11)
	mr 3,31
	bl ForceAnimCD
.L299:
	lwz 9,84(31)
	lwz 0,4796(9)
	cmpwi 0,0,0
	bc 4,2,.L307
	lis 9,.LC135@ha
	li 4,0
	la 9,.LC135@l(9)
	mr 3,31
	lfs 1,0(9)
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC126@ha
	la 29,gi@l(29)
	la 3,.LC126@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC136@ha
	lis 10,.LC136@ha
	lis 11,.LC137@ha
	mr 5,3
	la 9,.LC136@l(9)
	la 10,.LC136@l(10)
	mtlr 0
	la 11,.LC137@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L308
.L307:
	cmpwi 0,0,2
	bc 4,2,.L308
	lis 9,.LC135@ha
	li 4,0
	la 9,.LC135@l(9)
	mr 3,31
	lfs 1,0(9)
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC126@ha
	la 29,gi@l(29)
	la 3,.LC126@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC136@ha
	lis 10,.LC136@ha
	lis 11,.LC137@ha
	mr 5,3
	la 9,.LC136@l(9)
	la 10,.LC136@l(10)
	mtlr 0
	la 11,.LC137@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L308:
	lwz 11,140(1)
	cmpwi 0,11,0
	bc 4,2,.L310
	lwz 9,84(31)
	lwz 0,4460(9)
	cmpwi 0,0,0
	bc 12,2,.L295
.L310:
	lwz 3,280(11)
	lis 4,.LC116@ha
	la 4,.LC116@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L313
	lwz 9,140(1)
	lwz 0,248(9)
	cmpwi 0,0,2
	bc 12,2,.L312
.L313:
	lwz 9,84(31)
	lwz 0,4460(9)
	cmpwi 0,0,0
	bc 12,2,.L295
.L312:
	lwz 0,140(1)
	cmpwi 0,0,0
	bc 12,2,.L315
	lwz 9,84(31)
	stw 0,4460(9)
.L315:
	lis 11,.LC137@ha
	lwz 10,84(31)
	lis 9,deathmatch@ha
	la 11,.LC137@l(11)
	lwz 8,deathmatch@l(9)
	lfs 13,0(11)
	lwz 11,4460(10)
	lfs 31,1992(10)
	lhz 0,944(11)
	ori 0,0,2
	sth 0,944(11)
	lfs 0,20(8)
	fcmpu 0,0,13
	bc 12,2,.L316
	lwz 11,84(31)
	addi 3,1,72
	mr 4,30
	lfs 0,4(31)
	lwz 9,4460(11)
	lfs 13,8(31)
	lfs 12,4(9)
	lfs 11,12(31)
	b .L321
.L316:
	lis 9,.LC138@ha
	lwz 11,84(31)
	addi 3,1,72
	la 9,.LC138@l(9)
	lfs 0,4(31)
	mr 4,30
	lfs 13,0(9)
	lwz 9,4460(11)
	lfs 11,12(31)
	lfs 12,4(9)
	fdivs 31,31,13
	lfs 13,8(31)
.L321:
	fsubs 0,0,12
	stfs 0,72(1)
	lwz 9,4460(11)
	lfs 0,8(9)
	fsubs 13,13,0
	stfs 13,76(1)
	lwz 9,4460(11)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,80(1)
	bl VectorNormalize2
	fmr 1,31
	mr 3,30
	addi 4,1,56
	bl VectorScale
	lwz 9,84(31)
	lfs 13,56(1)
	lwz 11,4460(9)
	lfs 0,376(11)
	fadds 0,0,13
	stfs 0,376(11)
	lwz 9,84(31)
	lfs 13,60(1)
	lwz 11,4460(9)
	lfs 0,380(11)
	fadds 0,0,13
	stfs 0,380(11)
	lwz 9,84(31)
	lfs 13,64(1)
	lwz 11,4460(9)
	lfs 0,384(11)
	fadds 0,0,13
	stfs 0,384(11)
.L295:
	lwz 0,196(1)
	mtlr 0
	lmw 28,168(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe13:
	.size	 force_pull,.Lfe13-force_pull
	.section	".rodata"
	.align 2
.LC140:
	.string	"force/levstart.wav"
	.align 2
.LC141:
	.string	"force/levloop.wav"
	.align 2
.LC139:
	.long 0x402f8d50
	.align 2
.LC142:
	.long 0x3fe353f8
	.align 2
.LC143:
	.long 0x3f800000
	.align 2
.LC144:
	.long 0x0
	.section	".text"
	.align 2
	.globl force_levitate
	.type	 force_levitate,@function
force_levitate:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	li 0,6
	mr 31,3
	mtctr 0
	lwz 9,84(31)
	li 11,0
	addi 9,9,2092
.L343:
	lhz 0,0(9)
	addi 9,9,2
	cmpwi 0,0,3
	bc 12,2,.L342
	addi 11,11,1
	bdnz .L343
	li 8,255
.L327:
	lwz 9,84(31)
	lwz 0,4316(9)
	cmpwi 0,0,0
	bc 12,2,.L330
	li 0,3
	li 10,111
	stw 0,4804(9)
	li 11,116
	b .L344
.L342:
	mr 8,11
	b .L327
.L330:
	li 0,3
	li 10,70
	stw 0,4804(9)
	li 11,81
.L344:
	lwz 9,84(31)
	stw 10,56(31)
	stw 11,4308(9)
	cmpwi 0,8,255
	bc 4,2,.L332
	lwz 9,84(31)
	lhz 11,2104(9)
	cmpwi 0,11,6
	bc 12,2,.L322
	add 11,11,11
	addi 9,9,2092
	li 0,3
	sthx 0,9,11
	lwz 10,84(31)
	lhz 9,2104(10)
	addi 9,9,1
	sth 9,2104(10)
	lwz 11,84(31)
	lwz 0,4796(11)
	cmpwi 0,0,0
	bc 4,2,.L334
	lis 9,.LC139@ha
	li 4,2
	lfs 1,.LC139@l(9)
	mr 3,31
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC140@ha
	la 29,gi@l(29)
	la 3,.LC140@l(3)
	b .L345
.L334:
	cmpwi 0,0,2
	bc 4,2,.L322
	lis 9,.LC139@ha
	li 4,2
	lfs 1,.LC139@l(9)
	mr 3,31
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC140@ha
	la 29,gi@l(29)
	la 3,.LC140@l(3)
	b .L345
.L332:
	lwz 9,84(31)
	add 11,8,8
	li 0,255
	addi 9,9,2092
	sthx 0,9,11
	lwz 11,84(31)
	lhz 9,2104(11)
	cmpwi 0,9,0
	bc 12,2,.L338
	addi 0,9,-1
	sth 0,2104(11)
.L338:
	lwz 9,84(31)
	lwz 0,4796(9)
	cmpwi 0,0,2
	bc 4,2,.L339
	lis 9,.LC139@ha
	li 4,0
	lfs 1,.LC139@l(9)
	mr 3,31
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC141@ha
	la 29,gi@l(29)
	la 3,.LC141@l(3)
.L345:
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC143@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC143@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC143@ha
	la 9,.LC143@l(9)
	lfs 2,0(9)
	lis 9,.LC144@ha
	la 9,.LC144@l(9)
	lfs 3,0(9)
	blrl
	b .L322
.L339:
	cmpwi 0,0,0
	bc 4,2,.L322
	lis 9,.LC142@ha
	li 4,2
	lfs 1,.LC142@l(9)
	mr 3,31
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC141@ha
	la 29,gi@l(29)
	la 3,.LC141@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC143@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC143@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC143@ha
	la 9,.LC143@l(9)
	lfs 2,0(9)
	lis 9,.LC144@ha
	la 9,.LC144@l(9)
	lfs 3,0(9)
	blrl
.L322:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 force_levitate,.Lfe14-force_levitate
	.section	".rodata"
	.align 2
.LC145:
	.string	"force/negate.wav"
	.align 2
.LC146:
	.long 0x3f000000
	.align 2
.LC147:
	.long 0x3f800000
	.align 2
.LC148:
	.long 0x0
	.section	".text"
	.align 2
	.globl force_negate
	.type	 force_negate,@function
force_negate:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,4316(9)
	cmpwi 0,0,0
	bc 12,2,.L347
	li 0,4
	li 10,111
	stw 0,4804(9)
	li 11,116
	b .L359
.L347:
	li 0,4
	li 10,70
	stw 0,4804(9)
	li 11,81
.L359:
	lwz 9,84(31)
	stw 10,56(31)
	stw 11,4308(9)
	lwz 9,84(31)
	lwz 0,4796(9)
	cmpwi 0,0,0
	bc 4,2,.L349
	lis 9,.LC146@ha
	li 4,0
	la 9,.LC146@l(9)
	mr 3,31
	lfs 1,0(9)
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC145@ha
	la 29,gi@l(29)
	la 3,.LC145@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC147@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC147@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC147@ha
	la 9,.LC147@l(9)
	lfs 2,0(9)
	lis 9,.LC148@ha
	la 9,.LC148@l(9)
	lfs 3,0(9)
	blrl
	b .L350
.L349:
	cmpwi 0,0,2
	bc 4,2,.L350
	lis 9,.LC146@ha
	li 4,2
	la 9,.LC146@l(9)
	mr 3,31
	lfs 1,0(9)
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC145@ha
	la 29,gi@l(29)
	la 3,.LC145@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC147@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC147@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC147@ha
	la 9,.LC147@l(9)
	lfs 2,0(9)
	lis 9,.LC148@ha
	la 9,.LC148@l(9)
	lfs 3,0(9)
	blrl
.L350:
	lis 9,.LC148@ha
	lis 11,deathmatch@ha
	la 9,.LC148@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L352
	lis 9,num_players@ha
	lwz 0,num_players@l(9)
	cmpwi 0,0,0
	bc 4,1,.L352
	mtctr 0
	lis 9,players@ha
	li 10,0
	la 11,players@l(9)
.L356:
	lwz 9,0(11)
	addi 11,11,4
	lwz 9,84(9)
	lwz 0,4460(9)
	cmpw 0,0,31
	bc 4,2,.L355
	stw 10,4460(9)
.L355:
	bdnz .L356
.L352:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 force_negate,.Lfe15-force_negate
	.align 2
	.globl force_jump
	.type	 force_jump,@function
force_jump:
	li 0,6
	lwz 9,84(3)
	li 11,0
	mtctr 0
	addi 9,9,2092
.L375:
	lhz 0,0(9)
	addi 9,9,2
	cmpwi 0,0,5
	bc 12,2,.L374
	addi 11,11,1
	bdnz .L375
	li 8,255
.L365:
	lwz 9,84(3)
	lwz 0,4316(9)
	cmpwi 0,0,0
	bc 12,2,.L368
	li 0,5
	li 10,111
	stw 0,4804(9)
	li 11,116
	b .L376
.L374:
	mr 8,11
	b .L365
.L368:
	li 0,5
	li 10,70
	stw 0,4804(9)
	li 11,81
.L376:
	lwz 9,84(3)
	stw 10,56(3)
	stw 11,4308(9)
	cmpwi 0,8,255
	bc 4,2,.L370
	lwz 9,84(3)
	lhz 10,2104(9)
	cmpwi 0,10,6
	bclr 12,2
	addi 9,9,2092
	add 10,10,10
	li 0,5
	sthx 0,9,10
	lwz 11,84(3)
	lhz 9,2104(11)
	addi 9,9,1
	sth 9,2104(11)
	blr
.L370:
	lwz 9,84(3)
	add 11,8,8
	li 0,255
	addi 9,9,2092
	sthx 0,9,11
	lwz 3,84(3)
	lhz 9,2104(3)
	cmpwi 0,9,0
	bclr 12,2
	addi 0,9,-1
	sth 0,2104(3)
	blr
.Lfe16:
	.size	 force_jump,.Lfe16-force_jump
	.align 2
	.globl force_speed
	.type	 force_speed,@function
force_speed:
	li 0,6
	lwz 9,84(3)
	li 11,0
	mtctr 0
	addi 9,9,2092
.L392:
	lhz 0,0(9)
	addi 9,9,2
	cmpwi 0,0,6
	bc 12,2,.L391
	addi 11,11,1
	bdnz .L392
	li 8,255
.L382:
	lwz 9,84(3)
	lwz 0,4316(9)
	cmpwi 0,0,0
	bc 12,2,.L385
	li 0,6
	li 10,111
	stw 0,4804(9)
	li 11,116
	b .L393
.L391:
	mr 8,11
	b .L382
.L385:
	li 0,6
	li 10,70
	stw 0,4804(9)
	li 11,81
.L393:
	lwz 9,84(3)
	stw 10,56(3)
	stw 11,4308(9)
	cmpwi 0,8,255
	bc 4,2,.L387
	lwz 9,84(3)
	lhz 10,2104(9)
	cmpwi 0,10,6
	bclr 12,2
	addi 9,9,2092
	add 10,10,10
	li 0,6
	sthx 0,9,10
	lwz 11,84(3)
	lhz 9,2104(11)
	addi 9,9,1
	sth 9,2104(11)
	blr
.L387:
	lwz 9,84(3)
	add 11,8,8
	li 0,255
	addi 9,9,2092
	sthx 0,9,11
	lwz 3,84(3)
	lhz 9,2104(3)
	cmpwi 0,9,0
	bclr 12,2
	addi 0,9,-1
	sth 0,2104(3)
	blr
.Lfe17:
	.size	 force_speed,.Lfe17-force_speed
	.section	".rodata"
	.align 2
.LC150:
	.string	"force/lightheal.wav"
	.align 2
.LC149:
	.long 0x3e4ccccd
	.align 2
.LC151:
	.long 0x46fffe00
	.align 2
.LC152:
	.long 0x3f800000
	.align 2
.LC153:
	.long 0x0
	.align 2
.LC154:
	.long 0x42480000
	.align 3
.LC155:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC156:
	.long 0x46000000
	.align 2
.LC157:
	.long 0x45800000
	.align 2
.LC158:
	.long 0x44800000
	.align 2
.LC159:
	.long 0x44000000
	.section	".text"
	.align 2
	.globl force_lightheal
	.type	 force_lightheal,@function
force_lightheal:
	stwu 1,-160(1)
	mflr 0
	stfd 26,112(1)
	stfd 27,120(1)
	stfd 28,128(1)
	stfd 29,136(1)
	stfd 30,144(1)
	stfd 31,152(1)
	stmw 28,96(1)
	stw 0,164(1)
	mr 31,3
	lwz 11,84(31)
	lwz 0,4808(11)
	cmpwi 0,0,0
	bc 12,1,.L396
	li 0,7
	stw 0,4804(11)
	lwz 11,84(31)
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L397
	li 0,111
	li 9,116
	b .L419
.L397:
	li 0,70
	li 9,81
.L419:
	stw 0,56(31)
	stw 9,4308(11)
	mr 3,31
	bl ForceAnimCD
	b .L399
.L396:
	cmpwi 0,0,1
	bc 4,2,.L399
	lwz 0,4804(11)
	cmpwi 0,0,7
	bc 4,2,.L401
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L402
	li 0,113
	li 9,116
	b .L420
.L402:
	li 0,72
	li 9,75
.L420:
	stw 0,56(31)
	stw 9,4308(11)
	b .L399
.L401:
	li 0,7
	stw 0,4804(11)
	lwz 11,84(31)
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L405
	li 0,111
	li 9,116
	b .L421
.L405:
	li 0,70
	li 9,81
.L421:
	stw 0,56(31)
	stw 9,4308(11)
	mr 3,31
	bl ForceAnimCD
.L399:
	lwz 9,84(31)
	lwz 0,4796(9)
	cmpwi 0,0,0
	bc 4,2,.L407
	lis 9,.LC149@ha
	li 4,0
	lfs 1,.LC149@l(9)
	mr 3,31
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC150@ha
	la 29,gi@l(29)
	la 3,.LC150@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC152@ha
	lwz 0,16(29)
	lis 11,.LC152@ha
	la 9,.LC152@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC152@l(11)
	li 4,3
	mtlr 0
	lis 9,.LC153@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC153@l(9)
	lfs 3,0(9)
	blrl
	b .L408
.L407:
	cmpwi 0,0,2
	bc 4,2,.L408
	lis 9,.LC149@ha
	li 4,0
	lfs 1,.LC149@l(9)
	mr 3,31
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC150@ha
	la 29,gi@l(29)
	la 3,.LC150@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC152@ha
	lwz 0,16(29)
	lis 11,.LC152@ha
	la 9,.LC152@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC152@l(11)
	li 4,3
	mtlr 0
	lis 9,.LC153@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC153@l(9)
	lfs 3,0(9)
	blrl
.L408:
	lwz 0,480(31)
	cmpwi 0,0,99
	bc 12,1,.L395
	lwz 9,84(31)
	lis 11,.LC154@ha
	la 11,.LC154@l(11)
	lfs 0,0(11)
	lfs 11,2012(9)
	lis 11,.LC152@ha
	la 11,.LC152@l(11)
	lfs 13,0(11)
	fdivs 11,11,0
	fcmpu 0,11,13
	bc 4,0,.L411
	lis 9,.LC152@ha
	la 9,.LC152@l(9)
	lfs 11,0(9)
.L411:
	xoris 0,0,0x8000
	lwz 10,484(31)
	stw 0,92(1)
	lis 8,0x4330
	lis 9,.LC155@ha
	la 9,.LC155@l(9)
	stw 8,88(1)
	lfd 10,0(9)
	lfd 0,88(1)
	mr 9,11
	fsub 0,0,10
	frsp 0,0
	fadds 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,88(1)
	lwz 9,92(1)
	cmpw 0,9,10
	stw 9,480(31)
	bc 4,1,.L412
	stw 10,480(31)
.L412:
	fmr 13,11
	mr 11,9
	mr 10,9
	fctiwz 0,13
	stfd 0,88(1)
	lwz 9,92(1)
	srwi 0,9,31
	add 9,9,0
	srawi 9,9,1
	xoris 9,9,0x8000
	stw 9,92(1)
	stw 8,88(1)
	lfd 0,88(1)
	fsub 0,0,10
	frsp 11,0
	fmr 13,11
	fctiwz 12,13
	stfd 12,88(1)
	lwz 0,92(1)
	cmpwi 0,0,0
	bc 4,1,.L395
	lis 11,gi@ha
	lis 9,.LC151@ha
	la 28,gi@l(11)
	lfs 30,.LC151@l(9)
	mr 29,0
	lis 11,.LC155@ha
	lis 9,.LC156@ha
	la 11,.LC155@l(11)
	la 9,.LC156@l(9)
	lfd 31,0(11)
	lis 30,0x4330
	lis 11,.LC157@ha
	lfs 28,0(9)
	la 11,.LC157@l(11)
	lis 9,.LC158@ha
	lfs 29,0(11)
	la 9,.LC158@l(9)
	lis 11,.LC159@ha
	lfs 26,0(9)
	la 11,.LC159@l(11)
	lfs 27,0(11)
.L415:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,92(1)
	stw 30,88(1)
	lfd 0,88(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmsubs 0,0,28,29
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,92(1)
	stw 30,88(1)
	lfd 0,88(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmsubs 0,0,28,29
	stfs 0,12(1)
	bl rand
	rlwinm 0,3,0,17,31
	lwz 10,48(28)
	xoris 0,0,0x8000
	addi 3,1,24
	stw 0,92(1)
	addi 4,31,4
	li 5,0
	mtlr 10
	stw 30,88(1)
	li 6,0
	addi 7,1,8
	lfd 0,88(1)
	mr 8,31
	li 9,-1
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmsubs 0,0,26,27
	stfs 0,16(1)
	blrl
	addi 3,1,36
	mr 4,31
	li 5,0
	bl heal_effect_spawn
	addic. 29,29,-1
	bc 4,2,.L415
.L395:
	lwz 0,164(1)
	mtlr 0
	lmw 28,96(1)
	lfd 26,112(1)
	lfd 27,120(1)
	lfd 28,128(1)
	lfd 29,136(1)
	lfd 30,144(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe18:
	.size	 force_lightheal,.Lfe18-force_lightheal
	.section	".rodata"
	.align 2
.LC161:
	.string	"force/shield.wav"
	.align 2
.LC160:
	.long 0x3e4ccccd
	.align 2
.LC162:
	.long 0x3f800000
	.align 2
.LC163:
	.long 0x0
	.section	".text"
	.align 2
	.globl force_shield
	.type	 force_shield,@function
force_shield:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	li 0,6
	mr 31,3
	mtctr 0
	lwz 9,84(31)
	li 11,0
	addi 9,9,2092
.L451:
	lhz 0,0(9)
	addi 9,9,2
	cmpwi 0,0,9
	bc 12,2,.L450
	addi 11,11,1
	bdnz .L451
	li 8,255
.L438:
	lwz 9,84(31)
	lwz 0,4316(9)
	cmpwi 0,0,0
	bc 12,2,.L441
	li 0,9
	li 10,111
	stw 0,4804(9)
	li 11,116
	b .L452
.L450:
	mr 8,11
	b .L438
.L441:
	li 0,9
	li 10,70
	stw 0,4804(9)
	li 11,81
.L452:
	lwz 9,84(31)
	stw 10,56(31)
	stw 11,4308(9)
	cmpwi 0,8,255
	bc 4,2,.L443
	lwz 9,84(31)
	lhz 11,2104(9)
	cmpwi 0,11,6
	bc 12,2,.L433
	add 11,11,11
	addi 9,9,2092
	li 0,9
	sthx 0,9,11
	lwz 10,84(31)
	lhz 9,2104(10)
	addi 9,9,1
	sth 9,2104(10)
	lwz 11,84(31)
	lwz 0,4796(11)
	cmpwi 0,0,0
	bc 4,2,.L445
	lis 9,.LC160@ha
	li 4,0
	b .L453
.L445:
	cmpwi 0,0,2
	bc 4,2,.L433
	lis 9,.LC160@ha
	li 4,2
.L453:
	lfs 1,.LC160@l(9)
	mr 3,31
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC161@ha
	la 29,gi@l(29)
	la 3,.LC161@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC162@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC162@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC162@ha
	la 9,.LC162@l(9)
	lfs 2,0(9)
	lis 9,.LC163@ha
	la 9,.LC163@l(9)
	lfs 3,0(9)
	blrl
	b .L433
.L443:
	lwz 9,84(31)
	add 11,8,8
	li 0,255
	addi 9,9,2092
	sthx 0,9,11
	lwz 3,84(31)
	lhz 9,2104(3)
	cmpwi 0,9,0
	bc 12,2,.L433
	addi 0,9,-1
	sth 0,2104(3)
.L433:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 force_shield,.Lfe19-force_shield
	.section	".rodata"
	.align 2
.LC165:
	.string	"force/invis.wav"
	.align 2
.LC164:
	.long 0x3f19999a
	.align 2
.LC166:
	.long 0x3f800000
	.align 2
.LC167:
	.long 0x0
	.section	".text"
	.align 2
	.globl force_invisibility
	.type	 force_invisibility,@function
force_invisibility:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	li 0,6
	mr 31,3
	mtctr 0
	lwz 9,84(31)
	li 11,0
	addi 9,9,2092
.L472:
	lhz 0,0(9)
	addi 9,9,2
	cmpwi 0,0,10
	bc 12,2,.L471
	addi 11,11,1
	bdnz .L472
	li 8,255
.L459:
	lwz 9,84(31)
	lwz 0,4316(9)
	cmpwi 0,0,0
	bc 12,2,.L462
	li 0,10
	li 10,111
	stw 0,4804(9)
	li 11,116
	b .L473
.L471:
	mr 8,11
	b .L459
.L462:
	li 0,10
	li 10,70
	stw 0,4804(9)
	li 11,81
.L473:
	lwz 9,84(31)
	stw 10,56(31)
	stw 11,4308(9)
	cmpwi 0,8,255
	bc 4,2,.L464
	lwz 9,84(31)
	lhz 11,2104(9)
	cmpwi 0,11,6
	bc 12,2,.L454
	add 11,11,11
	addi 9,9,2092
	li 0,10
	lis 10,level+4@ha
	sthx 0,9,11
	lis 9,.LC166@ha
	lwz 11,84(31)
	la 9,.LC166@l(9)
	lfs 13,0(9)
	lhz 9,2104(11)
	addi 9,9,1
	sth 9,2104(11)
	lfs 0,level+4@l(10)
	lwz 11,84(31)
	fsubs 0,0,13
	stfs 0,4464(11)
	lwz 9,84(31)
	lwz 0,4796(9)
	cmpwi 0,0,0
	bc 4,2,.L466
	lis 9,.LC164@ha
	li 4,0
	b .L474
.L466:
	cmpwi 0,0,2
	bc 4,2,.L454
	lis 9,.LC164@ha
	li 4,2
.L474:
	lfs 1,.LC164@l(9)
	mr 3,31
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC165@ha
	la 29,gi@l(29)
	la 3,.LC165@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC166@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC166@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC166@ha
	la 9,.LC166@l(9)
	lfs 2,0(9)
	lis 9,.LC167@ha
	la 9,.LC167@l(9)
	lfs 3,0(9)
	blrl
	b .L454
.L464:
	lwz 9,84(31)
	add 11,8,8
	li 0,255
	addi 9,9,2092
	sthx 0,9,11
	lwz 11,84(31)
	lhz 9,2104(11)
	cmpwi 0,9,0
	bc 12,2,.L470
	addi 0,9,-1
	sth 0,2104(11)
.L470:
	li 0,255
	stw 0,40(31)
.L454:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 force_invisibility,.Lfe20-force_invisibility
	.section	".rodata"
	.align 2
.LC170:
	.string	"force/wind.wav"
	.align 2
.LC168:
	.long 0x461c4000
	.align 2
.LC169:
	.long 0x3ecccccd
	.align 2
.LC171:
	.long 0x41f00000
	.align 3
.LC172:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC173:
	.long 0x40000000
	.align 2
.LC174:
	.long 0x3f800000
	.align 2
.LC175:
	.long 0x0
	.section	".text"
	.align 2
	.globl force_wind
	.type	 force_wind,@function
force_wind:
	stwu 1,-64(1)
	mflr 0
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 28,32(1)
	stw 0,68(1)
	mr 31,3
	lis 9,powerlist+512@ha
	lwz 11,84(31)
	lfs 13,powerlist+512@l(9)
	lfs 0,1852(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L486
	lwz 0,4316(11)
	addi 30,31,4
	lis 9,.LC168@ha
	lfs 30,.LC168@l(9)
	mr 28,30
	li 29,0
	cmpwi 0,0,0
	lfs 31,2028(11)
	bc 12,2,.L488
	li 0,11
	li 10,111
	stw 0,4804(11)
	lwz 9,84(31)
	li 11,116
	b .L503
.L488:
	li 0,11
	li 10,70
	stw 0,4804(11)
	lwz 9,84(31)
	li 11,81
.L503:
	stw 10,56(31)
	stw 11,4308(9)
	b .L490
.L492:
	lwz 0,512(29)
	cmpwi 0,0,0
	bc 12,2,.L490
	lwz 0,248(29)
	cmpwi 0,0,2
	bc 4,2,.L490
	cmpw 0,29,31
	bc 12,2,.L490
	lis 9,gi+56@ha
	mr 3,28
	lwz 0,gi+56@l(9)
	addi 4,29,4
	mtlr 0
	blrl
	cmpwi 0,3,0
	bc 12,2,.L490
	lfs 0,0(30)
	addi 3,1,8
	lfs 13,4(29)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 13,4(30)
	lfs 0,8(29)
	fsubs 0,0,13
	stfs 0,12(1)
	lfs 0,8(30)
	lfs 13,12(29)
	fsubs 13,13,0
	stfs 13,16(1)
	bl VectorLength
	lis 9,.LC171@ha
	lfs 0,16(1)
	addi 3,1,8
	la 9,.LC171@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,16(1)
	bl VectorNormalize
	fmr 1,30
	addi 3,1,8
	mr 4,3
	bl VectorScale
	lfs 13,8(1)
	lfs 0,376(29)
	lfs 12,380(29)
	lfs 11,384(29)
	fadds 13,13,0
	stfs 13,376(29)
	lfs 0,12(1)
	fadds 0,0,12
	stfs 0,380(29)
	lfs 13,16(1)
	fadds 13,13,11
	stfs 13,384(29)
.L490:
	fmr 1,31
	mr 3,29
	mr 4,30
	bl findradius
	mr. 29,3
	bc 4,2,.L492
	lwz 10,84(31)
	lis 8,0x4330
	lis 9,.LC172@ha
	lwz 0,4616(10)
	la 9,.LC172@l(9)
	lfd 13,0(9)
	xoris 0,0,0x8000
	lis 9,level@ha
	stw 0,28(1)
	la 30,level@l(9)
	stw 8,24(1)
	lfd 0,24(1)
	lfs 12,4(30)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 4,3,.L499
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,51
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,1
	mtlr 0
	blrl
	lis 9,.LC173@ha
	lfs 0,4(30)
	la 9,.LC173@l(9)
	lwz 11,84(31)
	lfs 12,0(9)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	stw 9,4616(11)
.L499:
	lwz 9,84(31)
	lwz 0,4796(9)
	cmpwi 0,0,0
	bc 4,2,.L500
	lis 9,.LC169@ha
	li 4,0
	lfs 1,.LC169@l(9)
	mr 3,31
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC170@ha
	la 29,gi@l(29)
	la 3,.LC170@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC174@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC174@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC174@ha
	la 9,.LC174@l(9)
	lfs 2,0(9)
	lis 9,.LC175@ha
	la 9,.LC175@l(9)
	lfs 3,0(9)
	blrl
	b .L486
.L500:
	cmpwi 0,0,2
	bc 4,2,.L486
	lis 9,.LC169@ha
	li 4,2
	lfs 1,.LC169@l(9)
	mr 3,31
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC170@ha
	la 29,gi@l(29)
	la 3,.LC170@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC174@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC174@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC174@ha
	la 9,.LC174@l(9)
	lfs 2,0(9)
	lis 9,.LC175@ha
	la 9,.LC175@l(9)
	lfs 3,0(9)
	blrl
.L486:
	lwz 0,68(1)
	mtlr 0
	lmw 28,32(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe21:
	.size	 force_wind,.Lfe21-force_wind
	.section	".rodata"
	.align 2
.LC177:
	.string	"force/reflect.wav"
	.align 2
.LC176:
	.long 0x3e4ccccd
	.align 2
.LC178:
	.long 0x3f800000
	.align 2
.LC179:
	.long 0x0
	.section	".text"
	.align 2
	.globl force_reflect
	.type	 force_reflect,@function
force_reflect:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	li 0,6
	mr 31,3
	mtctr 0
	lwz 9,84(31)
	li 11,0
	addi 9,9,2092
.L522:
	lhz 0,0(9)
	addi 9,9,2
	cmpwi 0,0,12
	bc 12,2,.L521
	addi 11,11,1
	bdnz .L522
	li 8,255
.L509:
	lwz 9,84(31)
	lwz 0,4316(9)
	cmpwi 0,0,0
	bc 12,2,.L512
	li 0,12
	li 10,111
	stw 0,4804(9)
	li 11,116
	b .L523
.L521:
	mr 8,11
	b .L509
.L512:
	li 0,12
	li 10,70
	stw 0,4804(9)
	li 11,81
.L523:
	lwz 9,84(31)
	stw 10,56(31)
	stw 11,4308(9)
	cmpwi 0,8,255
	bc 4,2,.L514
	lwz 9,84(31)
	lhz 11,2104(9)
	cmpwi 0,11,6
	bc 12,2,.L504
	add 11,11,11
	addi 9,9,2092
	li 0,12
	sthx 0,9,11
	lwz 10,84(31)
	lhz 9,2104(10)
	addi 9,9,1
	sth 9,2104(10)
	lwz 11,84(31)
	lwz 0,4796(11)
	cmpwi 0,0,0
	bc 4,2,.L516
	lis 9,.LC176@ha
	li 4,0
	b .L524
.L516:
	cmpwi 0,0,2
	bc 4,2,.L504
	lis 9,.LC176@ha
	li 4,2
.L524:
	lfs 1,.LC176@l(9)
	mr 3,31
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC177@ha
	la 29,gi@l(29)
	la 3,.LC177@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC178@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC178@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC178@ha
	la 9,.LC178@l(9)
	lfs 2,0(9)
	lis 9,.LC179@ha
	la 9,.LC179@l(9)
	lfs 3,0(9)
	blrl
	b .L504
.L514:
	lwz 9,84(31)
	add 11,8,8
	li 0,255
	addi 9,9,2092
	sthx 0,9,11
	lwz 3,84(31)
	lhz 9,2104(3)
	cmpwi 0,9,0
	bc 12,2,.L504
	addi 0,9,-1
	sth 0,2104(3)
.L504:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 force_reflect,.Lfe22-force_reflect
	.section	".rodata"
	.align 2
.LC180:
	.string	"force/scout.wav"
	.align 2
.LC181:
	.long 0x3f800000
	.align 2
.LC182:
	.long 0x0
	.section	".text"
	.align 2
	.globl force_scout
	.type	 force_scout,@function
force_scout:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	li 0,6
	mr 31,3
	mtctr 0
	lwz 9,84(31)
	li 11,0
	addi 9,9,2092
.L543:
	lhz 0,0(9)
	addi 9,9,2
	cmpwi 0,0,13
	bc 12,2,.L542
	addi 11,11,1
	bdnz .L543
	li 8,255
.L530:
	lwz 9,84(31)
	lwz 0,4316(9)
	cmpwi 0,0,0
	bc 12,2,.L533
	li 0,13
	li 10,111
	stw 0,4804(9)
	li 11,116
	b .L544
.L542:
	mr 8,11
	b .L530
.L533:
	li 0,13
	li 10,70
	stw 0,4804(9)
	li 11,81
.L544:
	lwz 9,84(31)
	stw 10,56(31)
	stw 11,4308(9)
	cmpwi 0,8,255
	bc 4,2,.L535
	lwz 9,84(31)
	lhz 11,2104(9)
	cmpwi 0,11,6
	bc 12,2,.L525
	add 11,11,11
	addi 9,9,2092
	li 0,13
	sthx 0,9,11
	lwz 10,84(31)
	lhz 9,2104(10)
	addi 9,9,1
	sth 9,2104(10)
	lwz 11,84(31)
	lwz 0,4796(11)
	cmpwi 0,0,0
	bc 4,2,.L537
	lis 9,.LC181@ha
	li 4,0
	b .L545
.L537:
	cmpwi 0,0,2
	bc 4,2,.L525
	lis 9,.LC181@ha
	li 4,2
.L545:
	la 9,.LC181@l(9)
	mr 3,31
	lfs 1,0(9)
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC180@ha
	la 29,gi@l(29)
	la 3,.LC180@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC181@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC181@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC181@ha
	la 9,.LC181@l(9)
	lfs 2,0(9)
	lis 9,.LC182@ha
	la 9,.LC182@l(9)
	lfs 3,0(9)
	blrl
	b .L525
.L535:
	lwz 9,84(31)
	add 11,8,8
	li 0,255
	addi 9,9,2092
	sthx 0,9,11
	lwz 3,84(31)
	lhz 9,2104(3)
	cmpwi 0,9,0
	bc 12,2,.L525
	addi 0,9,-1
	sth 0,2104(3)
.L525:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 force_scout,.Lfe23-force_scout
	.section	".rodata"
	.align 2
.LC184:
	.string	"force/bind.wav"
	.align 2
.LC183:
	.long 0x3e4ccccd
	.align 3
.LC185:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC186:
	.long 0x44800000
	.align 2
.LC187:
	.long 0x3f800000
	.align 2
.LC188:
	.long 0x0
	.section	".text"
	.align 2
	.globl force_bind
	.type	 force_bind,@function
force_bind:
	stwu 1,-144(1)
	mflr 0
	stmw 28,128(1)
	stw 0,148(1)
	mr 31,3
	lwz 11,84(31)
	lwz 0,4808(11)
	cmpwi 0,0,0
	bc 12,1,.L547
	li 0,14
	stw 0,4804(11)
	lwz 11,84(31)
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L548
	li 0,111
	li 9,116
	b .L568
.L548:
	li 0,70
	li 9,81
.L568:
	stw 0,56(31)
	stw 9,4308(11)
	mr 3,31
	bl ForceAnimCD
	b .L550
.L547:
	cmpwi 0,0,1
	bc 4,2,.L550
	lwz 0,4804(11)
	cmpwi 0,0,14
	bc 4,2,.L552
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L553
	li 0,113
	li 9,116
	b .L569
.L553:
	li 0,72
	li 9,75
.L569:
	stw 0,56(31)
	stw 9,4308(11)
	b .L550
.L552:
	li 0,14
	stw 0,4804(11)
	lwz 11,84(31)
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L556
	li 0,111
	li 9,116
	b .L570
.L556:
	li 0,70
	li 9,81
.L570:
	stw 0,56(31)
	stw 9,4308(11)
	mr 3,31
	bl ForceAnimCD
.L550:
	lwz 3,84(31)
	addi 29,1,40
	addi 28,1,24
	li 6,0
	mr 4,29
	li 5,0
	addi 3,3,4252
	bl AngleVectors
	lwz 0,508(31)
	lis 11,0x4330
	lis 10,.LC185@ha
	lfs 12,12(31)
	mr 4,29
	xoris 0,0,0x8000
	la 10,.LC185@l(10)
	lfs 10,4(31)
	stw 0,124(1)
	addi 3,1,8
	mr 5,28
	stw 11,120(1)
	lfd 11,0(10)
	lfd 0,120(1)
	lis 10,.LC186@ha
	lfs 13,8(31)
	la 10,.LC186@l(10)
	lfs 1,0(10)
	fsub 0,0,11
	stfs 10,8(1)
	stfs 13,12(1)
	frsp 0,0
	fadds 12,12,0
	stfs 12,16(1)
	bl VectorMA
	lis 9,gi@ha
	mr 7,28
	la 29,gi@l(9)
	addi 3,1,56
	lwz 11,48(29)
	lis 9,0x600
	addi 4,1,8
	li 5,0
	li 6,0
	mr 8,31
	mtlr 11
	blrl
	lwz 9,84(31)
	lwz 0,4796(9)
	cmpwi 0,0,0
	bc 4,2,.L558
	lis 9,.LC183@ha
	li 4,0
	lfs 1,.LC183@l(9)
	mr 3,31
	bl sound_delay
	lwz 9,36(29)
	lis 3,.LC184@ha
	la 3,.LC184@l(3)
	mtlr 9
	blrl
	lis 9,.LC187@ha
	lwz 0,16(29)
	lis 10,.LC187@ha
	la 9,.LC187@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC187@l(10)
	li 4,3
	mtlr 0
	lis 9,.LC188@ha
	mr 3,31
	lfs 2,0(10)
	la 9,.LC188@l(9)
	lfs 3,0(9)
	blrl
	b .L559
.L558:
	cmpwi 0,0,2
	bc 4,2,.L559
	lis 9,.LC183@ha
	li 4,2
	lfs 1,.LC183@l(9)
	mr 3,31
	bl sound_delay
	lwz 9,36(29)
	lis 3,.LC184@ha
	la 3,.LC184@l(3)
	mtlr 9
	blrl
	lis 9,.LC187@ha
	lwz 0,16(29)
	lis 10,.LC187@ha
	la 9,.LC187@l(9)
	mr 5,3
	lfs 1,0(9)
	la 10,.LC187@l(10)
	li 4,3
	mtlr 0
	lis 9,.LC188@ha
	mr 3,31
	lfs 2,0(10)
	la 9,.LC188@l(9)
	lfs 3,0(9)
	blrl
.L559:
	lwz 11,108(1)
	cmpwi 0,11,0
	bc 4,2,.L561
	lwz 9,84(31)
	lwz 0,4460(9)
	cmpwi 0,0,0
	bc 12,2,.L546
.L561:
	lwz 3,280(11)
	lis 4,.LC116@ha
	la 4,.LC116@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L564
	lwz 11,108(1)
	lwz 0,248(11)
	cmpwi 0,0,2
	bc 12,2,.L563
.L564:
	lwz 9,84(31)
	lwz 0,4460(9)
	cmpwi 0,0,0
	bc 12,2,.L546
	b .L566
.L563:
	cmpwi 0,11,0
	bc 12,2,.L566
	lwz 9,84(31)
	stw 11,4460(9)
.L566:
	lwz 9,84(31)
	lwz 11,4460(9)
	lhz 0,946(11)
	ori 0,0,128
	sth 0,946(11)
.L546:
	lwz 0,148(1)
	mtlr 0
	lmw 28,128(1)
	la 1,144(1)
	blr
.Lfe24:
	.size	 force_bind,.Lfe24-force_bind
	.section	".rodata"
	.align 2
.LC190:
	.string	"force/darkheal.wav"
	.align 2
.LC189:
	.long 0x3e99999a
	.align 2
.LC191:
	.long 0x46fffe00
	.align 2
.LC192:
	.long 0x3f800000
	.align 2
.LC193:
	.long 0x0
	.align 2
.LC194:
	.long 0x42c80000
	.align 3
.LC195:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC196:
	.long 0x46000000
	.align 2
.LC197:
	.long 0x45800000
	.align 2
.LC198:
	.long 0x44800000
	.align 2
.LC199:
	.long 0x44000000
	.section	".text"
	.align 2
	.globl force_darkheal
	.type	 force_darkheal,@function
force_darkheal:
	stwu 1,-160(1)
	mflr 0
	stfd 26,112(1)
	stfd 27,120(1)
	stfd 28,128(1)
	stfd 29,136(1)
	stfd 30,144(1)
	stfd 31,152(1)
	stmw 28,96(1)
	stw 0,164(1)
	mr 31,3
	lwz 11,84(31)
	lwz 0,4808(11)
	cmpwi 0,0,0
	bc 12,1,.L572
	li 0,15
	stw 0,4804(11)
	lwz 11,84(31)
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L573
	li 0,111
	li 9,116
	b .L595
.L573:
	li 0,70
	li 9,81
.L595:
	stw 0,56(31)
	stw 9,4308(11)
	mr 3,31
	bl ForceAnimCD
	b .L575
.L572:
	cmpwi 0,0,1
	bc 4,2,.L575
	lwz 0,4804(11)
	cmpwi 0,0,15
	bc 4,2,.L577
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L578
	li 0,113
	li 9,116
	b .L596
.L578:
	li 0,72
	li 9,75
.L596:
	stw 0,56(31)
	stw 9,4308(11)
	b .L575
.L577:
	li 0,15
	stw 0,4804(11)
	lwz 11,84(31)
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L581
	li 0,111
	li 9,116
	b .L597
.L581:
	li 0,70
	li 9,81
.L597:
	stw 0,56(31)
	stw 9,4308(11)
	mr 3,31
	bl ForceAnimCD
.L575:
	lwz 9,84(31)
	lwz 0,4796(9)
	cmpwi 0,0,0
	bc 4,2,.L583
	lis 9,.LC189@ha
	li 4,0
	lfs 1,.LC189@l(9)
	mr 3,31
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC190@ha
	la 29,gi@l(29)
	la 3,.LC190@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC192@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC192@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC192@ha
	la 9,.LC192@l(9)
	lfs 2,0(9)
	lis 9,.LC193@ha
	la 9,.LC193@l(9)
	lfs 3,0(9)
	blrl
	b .L584
.L583:
	cmpwi 0,0,2
	bc 4,2,.L584
	lis 9,.LC189@ha
	li 4,2
	lfs 1,.LC189@l(9)
	mr 3,31
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC190@ha
	la 29,gi@l(29)
	la 3,.LC190@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC192@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC192@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC192@ha
	la 9,.LC192@l(9)
	lfs 2,0(9)
	lis 9,.LC193@ha
	la 9,.LC193@l(9)
	lfs 3,0(9)
	blrl
.L584:
	lwz 0,480(31)
	cmpwi 0,0,99
	bc 12,1,.L571
	lwz 7,84(31)
	lis 9,.LC194@ha
	la 9,.LC194@l(9)
	lfs 0,0(9)
	lfs 10,2012(7)
	lis 9,.LC192@ha
	la 9,.LC192@l(9)
	lfs 13,0(9)
	fdivs 10,10,0
	fcmpu 0,10,13
	bc 4,0,.L587
	lis 9,.LC192@ha
	la 9,.LC192@l(9)
	lfs 10,0(9)
.L587:
	xoris 0,0,0x8000
	stw 0,92(1)
	lis 6,0x4330
	lis 9,.LC195@ha
	la 9,.LC195@l(9)
	stw 6,88(1)
	mr 10,11
	lfd 9,0(9)
	mr 8,11
	lfd 0,88(1)
	mr 9,11
	fsub 0,0,9
	frsp 0,0
	fadds 0,0,10
	fmr 13,0
	fctiwz 12,13
	stfd 12,88(1)
	lwz 9,92(1)
	stw 9,480(31)
	lwz 0,4720(7)
	xoris 0,0,0x8000
	stw 0,92(1)
	stw 6,88(1)
	lfd 0,88(1)
	fsub 0,0,9
	frsp 0,0
	fadds 0,0,10
	fmr 13,0
	fctiwz 11,13
	stfd 11,88(1)
	lwz 8,92(1)
	stw 8,4720(7)
	lwz 9,484(31)
	lwz 0,480(31)
	cmpw 0,0,9
	bc 4,1,.L588
	stw 9,480(31)
.L588:
	fmr 13,10
	mr 11,9
	mr 10,9
	fctiwz 0,13
	stfd 0,88(1)
	lwz 9,92(1)
	srwi 0,9,31
	add 9,9,0
	srawi 9,9,1
	xoris 9,9,0x8000
	stw 9,92(1)
	stw 6,88(1)
	lfd 0,88(1)
	fsub 0,0,9
	frsp 10,0
	fmr 13,10
	fctiwz 12,13
	stfd 12,88(1)
	lwz 0,92(1)
	cmpwi 0,0,0
	bc 4,1,.L571
	lis 9,.LC191@ha
	lis 11,gi@ha
	lfs 30,.LC191@l(9)
	la 28,gi@l(11)
	mr 29,0
	lis 9,.LC195@ha
	lis 30,0x4330
	la 9,.LC195@l(9)
	lfd 31,0(9)
	lis 9,.LC196@ha
	la 9,.LC196@l(9)
	lfs 28,0(9)
	lis 9,.LC197@ha
	la 9,.LC197@l(9)
	lfs 29,0(9)
	lis 9,.LC198@ha
	la 9,.LC198@l(9)
	lfs 26,0(9)
	lis 9,.LC199@ha
	la 9,.LC199@l(9)
	lfs 27,0(9)
.L591:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,92(1)
	stw 30,88(1)
	lfd 0,88(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmsubs 0,0,28,29
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,92(1)
	stw 30,88(1)
	lfd 0,88(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmsubs 0,0,28,29
	stfs 0,12(1)
	bl rand
	rlwinm 0,3,0,17,31
	lwz 10,48(28)
	xoris 0,0,0x8000
	addi 3,1,24
	stw 0,92(1)
	addi 4,31,4
	li 5,0
	mtlr 10
	stw 30,88(1)
	li 6,0
	addi 7,1,8
	lfd 0,88(1)
	mr 8,31
	li 9,-1
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmsubs 0,0,26,27
	stfs 0,16(1)
	blrl
	addi 3,1,36
	mr 4,31
	li 5,1
	bl heal_effect_spawn
	addic. 29,29,-1
	bc 4,2,.L591
.L571:
	lwz 0,164(1)
	mtlr 0
	lmw 28,96(1)
	lfd 26,112(1)
	lfd 27,120(1)
	lfd 28,128(1)
	lfd 29,136(1)
	lfd 30,144(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe25:
	.size	 force_darkheal,.Lfe25-force_darkheal
	.section	".rodata"
	.align 2
.LC200:
	.long 0xc0000000
	.align 2
.LC201:
	.long 0x45fd0000
	.align 2
.LC202:
	.long 0x42a00000
	.section	".text"
	.align 2
	.globl fire_lightning
	.type	 fire_lightning,@function
fire_lightning:
	stwu 1,-192(1)
	mflr 0
	stmw 24,160(1)
	stw 0,196(1)
	mr 31,3
	addi 29,1,32
	lwz 3,84(31)
	mr 28,4
	addi 30,1,48
	addi 4,1,16
	mr 5,29
	li 6,0
	addi 3,3,4252
	bl AngleVectors
	addi 27,31,4
	lis 25,g_edicts@ha
	lwz 3,84(31)
	addi 26,1,64
	addi 6,1,16
	mr 7,29
	mr 5,28
	mr 8,30
	mr 4,27
	bl P_ProjectSource
	lis 28,0x6205
	lis 9,.LC200@ha
	lwz 4,84(31)
	addi 24,1,92
	la 9,.LC200@l(9)
	addi 3,1,16
	lfs 1,0(9)
	addi 4,4,4200
	ori 28,28,46533
	bl VectorScale
	lis 11,.LC201@ha
	lwz 9,84(31)
	lis 0,0xbf80
	la 11,.LC201@l(11)
	addi 4,1,16
	lfs 1,0(11)
	mr 3,27
	mr 5,26
	stw 0,4188(9)
	bl VectorMA
	lis 29,gi@ha
	lis 9,0x600
	la 29,gi@l(29)
	ori 9,9,3
	lwz 11,48(29)
	addi 3,1,80
	mr 7,26
	mr 4,30
	li 5,0
	li 6,0
	mr 8,31
	mtlr 11
	blrl
	lwz 9,100(29)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,33
	mtlr 9
	blrl
	lwz 3,132(1)
	lwz 0,g_edicts@l(25)
	lwz 11,104(29)
	subf 3,0,3
	mullw 3,3,28
	mtlr 11
	srawi 3,3,2
	blrl
	lwz 3,g_edicts@l(25)
	lwz 9,104(29)
	subf 3,3,31
	mullw 3,3,28
	mtlr 9
	srawi 3,3,2
	blrl
	lwz 9,120(29)
	mr 3,24
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,30
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,30
	li 4,2
	mtlr 0
	blrl
	lis 9,.LC202@ha
	lwz 3,132(1)
	la 9,.LC202@l(9)
	lfs 12,0(9)
	lwz 9,84(31)
	lwz 0,512(3)
	lfs 0,2048(9)
	cmpwi 0,0,0
	fdivs 0,0,12
	fctiwz 13,0
	stfd 13,152(1)
	lwz 11,156(1)
	bc 12,2,.L599
	li 9,13
	li 0,4
	stw 9,12(1)
	mr 7,24
	mr 4,31
	stw 0,8(1)
	mr 9,11
	mr 5,31
	addi 6,1,16
	addi 8,1,104
	li 10,0
	bl T_Damage
.L599:
	mr 3,31
	mr 4,30
	li 5,1
	bl PlayerNoise
	lwz 0,196(1)
	mtlr 0
	lmw 24,160(1)
	la 1,192(1)
	blr
.Lfe26:
	.size	 fire_lightning,.Lfe26-fire_lightning
	.section	".rodata"
	.align 2
.LC204:
	.string	"force/lght1.wav"
	.align 2
.LC206:
	.string	"force/lght2.wav"
	.align 2
.LC207:
	.string	"force/lght3.wav"
	.align 2
.LC208:
	.string	"force/lght4.wav"
	.align 2
.LC209:
	.string	"force/lghtloop.wav"
	.align 2
.LC203:
	.long 0x46fffe00
	.align 3
.LC205:
	.long 0x3fe51eb8
	.long 0x51eb851f
	.align 3
.LC210:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC211:
	.long 0x3fe80000
	.long 0x0
	.align 2
.LC212:
	.long 0x3f800000
	.align 2
.LC213:
	.long 0x0
	.align 3
.LC214:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl force_lightning
	.type	 force_lightning,@function
force_lightning:
	stwu 1,-80(1)
	mflr 0
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 29,52(1)
	stw 0,84(1)
	mr 31,3
	lwz 9,508(31)
	lis 8,0x4330
	lis 10,.LC210@ha
	la 10,.LC210@l(10)
	lis 0,0x4160
	addi 9,9,-4
	lfd 13,0(10)
	xoris 9,9,0x8000
	lis 10,0x4040
	stw 0,8(1)
	stw 9,44(1)
	addi 4,1,8
	stw 8,40(1)
	lfd 0,40(1)
	stw 10,12(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,16(1)
	bl fire_lightning
	lwz 11,84(31)
	lwz 0,4808(11)
	cmpwi 0,0,0
	bc 12,1,.L601
	li 0,16
	stw 0,4804(11)
	lwz 11,84(31)
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L602
	li 0,111
	li 9,116
	b .L622
.L602:
	li 0,70
	li 9,81
.L622:
	stw 0,56(31)
	stw 9,4308(11)
	mr 3,31
	bl ForceAnimCD
	b .L604
.L601:
	cmpwi 0,0,1
	bc 4,2,.L604
	lwz 0,4804(11)
	cmpwi 0,0,16
	bc 4,2,.L606
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L607
	li 0,113
	li 9,116
	b .L623
.L607:
	li 0,72
	li 9,75
.L623:
	stw 0,56(31)
	stw 9,4308(11)
	b .L604
.L606:
	li 0,16
	stw 0,4804(11)
	lwz 11,84(31)
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L610
	li 0,111
	li 9,116
	b .L624
.L610:
	li 0,70
	li 9,81
.L624:
	stw 0,56(31)
	stw 9,4308(11)
	mr 3,31
	bl ForceAnimCD
.L604:
	lwz 9,84(31)
	lwz 0,4796(9)
	cmpwi 0,0,0
	bc 4,2,.L612
	mr 3,31
	lis 29,0x4330
	bl makelightning
	lis 9,.LC210@ha
	li 0,12
	la 9,.LC210@l(9)
	lfd 31,0(9)
	lwz 9,84(31)
	stw 0,4816(9)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC203@ha
	stw 3,44(1)
	lis 10,.LC211@ha
	stw 29,40(1)
	la 10,.LC211@l(10)
	lfd 0,40(1)
	lfs 30,.LC203@l(11)
	lfd 12,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L613
	lis 29,gi@ha
	lis 3,.LC204@ha
	la 29,gi@l(29)
	la 3,.LC204@l(3)
	b .L625
.L613:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC205@ha
	stw 3,44(1)
	stw 29,40(1)
	lfd 0,40(1)
	lfd 12,.LC205@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L615
	lis 29,gi@ha
	lis 3,.LC206@ha
	la 29,gi@l(29)
	la 3,.LC206@l(3)
	b .L625
.L615:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 10,.LC214@ha
	stw 3,44(1)
	la 10,.LC214@l(10)
	stw 29,40(1)
	lfd 0,40(1)
	lfd 12,0(10)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L617
	lis 29,gi@ha
	lis 3,.LC207@ha
	la 29,gi@l(29)
	la 3,.LC207@l(3)
	b .L625
.L617:
	lis 29,gi@ha
	lis 3,.LC208@ha
	la 29,gi@l(29)
	la 3,.LC208@l(3)
.L625:
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC212@ha
	lis 10,.LC212@ha
	lis 11,.LC213@ha
	mr 5,3
	la 9,.LC212@l(9)
	la 10,.LC212@l(10)
	mtlr 0
	la 11,.LC213@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
	b .L619
.L612:
	cmpwi 0,0,2
	bc 4,2,.L619
	lwz 0,4816(9)
	cmpwi 0,0,0
	bc 12,1,.L621
	li 0,11
	lis 29,gi@ha
	stw 0,4816(9)
	la 29,gi@l(29)
	lis 3,.LC209@ha
	lwz 9,36(29)
	la 3,.LC209@l(3)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC212@ha
	lis 10,.LC212@ha
	lis 11,.LC213@ha
	mr 5,3
	la 9,.LC212@l(9)
	la 10,.LC212@l(10)
	mtlr 0
	la 11,.LC213@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L621:
	lwz 9,84(31)
	li 0,3
	stw 0,4812(9)
.L619:
	lwz 0,84(1)
	mtlr 0
	lmw 29,52(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe27:
	.size	 force_lightning,.Lfe27-force_lightning
	.section	".rodata"
	.align 2
.LC215:
	.long 0x44800000
	.align 3
.LC216:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl force_choke
	.type	 force_choke,@function
force_choke:
	stwu 1,-160(1)
	mflr 0
	stmw 28,144(1)
	stw 0,164(1)
	mr 31,3
	addi 29,1,48
	lwz 3,84(31)
	addi 28,1,32
	li 6,0
	mr 4,29
	li 5,0
	addi 3,3,4252
	bl AngleVectors
	lis 9,.LC215@ha
	lwz 0,508(31)
	lis 11,0x4330
	la 9,.LC215@l(9)
	lis 10,.LC216@ha
	lfs 12,12(31)
	lfs 1,0(9)
	xoris 0,0,0x8000
	la 10,.LC216@l(10)
	lfd 11,0(10)
	addi 3,1,16
	stw 0,140(1)
	mr 4,29
	mr 5,28
	stw 11,136(1)
	lfd 0,136(1)
	lfs 10,4(31)
	lfs 13,8(31)
	fsub 0,0,11
	stfs 10,16(1)
	stfs 13,20(1)
	frsp 0,0
	fadds 12,12,0
	stfs 12,24(1)
	bl VectorMA
	lis 9,gi+48@ha
	mr 7,28
	lwz 0,gi+48@l(9)
	addi 3,1,64
	addi 4,1,16
	li 5,0
	li 6,0
	mtlr 0
	mr 8,31
	lis 9,0x600
	blrl
	lwz 11,84(31)
	lwz 0,4808(11)
	cmpwi 0,0,0
	bc 12,1,.L627
	li 0,17
	stw 0,4804(11)
	lwz 11,84(31)
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L628
	li 0,117
	li 9,122
	b .L646
.L628:
	li 0,76
	li 9,81
.L646:
	stw 0,56(31)
	stw 9,4308(11)
	mr 3,31
	bl ForceAnimCD
	b .L630
.L627:
	cmpwi 0,0,1
	bc 4,2,.L630
	lwz 0,4804(11)
	cmpwi 0,0,17
	bc 4,2,.L632
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L633
	li 0,119
	li 9,122
	b .L647
.L633:
	li 0,78
	li 9,81
.L647:
	stw 0,56(31)
	stw 9,4308(11)
	b .L630
.L632:
	li 0,17
	stw 0,4804(11)
	lwz 11,84(31)
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L636
	li 0,117
	li 9,122
	b .L648
.L636:
	li 0,76
	li 9,81
.L648:
	stw 0,56(31)
	stw 9,4308(11)
	mr 3,31
	bl ForceAnimCD
.L630:
	lwz 11,116(1)
	cmpwi 0,11,0
	bc 4,2,.L638
	lwz 9,84(31)
	lwz 0,4460(9)
	cmpwi 0,0,0
	bc 12,2,.L626
.L638:
	lwz 3,280(11)
	lis 4,.LC116@ha
	la 4,.LC116@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L640
	lwz 9,84(31)
	lwz 0,4460(9)
	cmpwi 0,0,0
	bc 12,2,.L626
	b .L642
.L640:
	lwz 11,116(1)
	cmpwi 0,11,0
	bc 12,2,.L642
	lwz 0,512(11)
	cmpwi 0,0,0
	bc 12,2,.L626
	lwz 9,84(31)
	stw 11,4460(9)
	lwz 11,116(1)
	lwz 10,84(11)
	lwz 9,4828(10)
	addi 9,9,1
	stw 9,4828(10)
	lwz 11,116(1)
	lwz 10,84(11)
	lwz 9,4828(10)
	addi 9,9,1
	stw 9,4828(10)
.L642:
	lwz 9,84(31)
	lwz 3,4460(9)
	lwz 0,492(3)
	cmpwi 0,0,0
	bc 4,2,.L626
	lfs 0,1988(9)
	lis 29,0x51eb
	lis 6,vec3_origin@ha
	ori 29,29,34079
	mr 4,31
	la 6,vec3_origin@l(6)
	li 0,1
	li 11,12
	stw 0,8(1)
	mr 5,4
	addi 7,3,4
	stw 11,12(1)
	mr 8,6
	li 10,1
	fctiwz 13,0
	stfd 13,136(1)
	lwz 9,140(1)
	rlwinm 9,9,0,0xffff
	mulhwu 9,9,29
	rlwinm 9,9,27,16,31
	addi 9,9,1
	bl T_Damage
.L626:
	lwz 0,164(1)
	mtlr 0
	lmw 28,144(1)
	la 1,160(1)
	blr
.Lfe28:
	.size	 force_choke,.Lfe28-force_choke
	.align 2
	.globl force_absorb
	.type	 force_absorb,@function
force_absorb:
	li 0,6
	lwz 9,84(3)
	li 11,0
	mtctr 0
	addi 9,9,2092
.L664:
	lhz 0,0(9)
	addi 9,9,2
	cmpwi 0,0,18
	bc 12,2,.L663
	addi 11,11,1
	bdnz .L664
	li 8,255
.L654:
	lwz 9,84(3)
	lwz 0,4316(9)
	cmpwi 0,0,0
	bc 12,2,.L657
	li 0,18
	li 10,111
	stw 0,4804(9)
	li 11,116
	b .L665
.L663:
	mr 8,11
	b .L654
.L657:
	li 0,18
	li 10,70
	stw 0,4804(9)
	li 11,81
.L665:
	lwz 9,84(3)
	stw 10,56(3)
	stw 11,4308(9)
	cmpwi 0,8,255
	bc 4,2,.L659
	lwz 9,84(3)
	lhz 10,2104(9)
	cmpwi 0,10,6
	bclr 12,2
	addi 9,9,2092
	add 10,10,10
	li 0,18
	sthx 0,9,10
	lwz 11,84(3)
	lhz 9,2104(11)
	addi 9,9,1
	sth 9,2104(11)
	blr
.L659:
	lwz 9,84(3)
	add 11,8,8
	li 0,255
	addi 9,9,2092
	sthx 0,9,11
	lwz 3,84(3)
	lhz 9,2104(3)
	cmpwi 0,9,0
	bclr 12,2
	addi 0,9,-1
	sth 0,2104(3)
	blr
.Lfe29:
	.size	 force_absorb,.Lfe29-force_absorb
	.section	".rodata"
	.align 2
.LC217:
	.string	"force/walldark.wav"
	.align 2
.LC218:
	.long 0x41200000
	.align 2
.LC219:
	.long 0x0
	.align 2
.LC220:
	.long 0x40000000
	.align 2
.LC221:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl force_wall_of_darkness
	.type	 force_wall_of_darkness,@function
force_wall_of_darkness:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 27,20(1)
	stw 0,52(1)
	mr 31,3
	lis 9,.LC218@ha
	lwz 11,84(31)
	la 9,.LC218@l(9)
	lfs 13,0(9)
	lwz 0,4808(11)
	lfs 0,2060(11)
	cmpwi 0,0,0
	fdivs 31,0,13
	bc 12,1,.L667
	li 0,19
	stw 0,4804(11)
	lwz 11,84(31)
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L668
	li 0,111
	li 9,116
	b .L689
.L668:
	li 0,70
	li 9,81
.L689:
	stw 0,56(31)
	stw 9,4308(11)
	mr 3,31
	bl ForceAnimCD
	b .L670
.L667:
	cmpwi 0,0,1
	bc 4,2,.L670
	lwz 0,4804(11)
	cmpwi 0,0,19
	bc 4,2,.L672
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L673
	li 0,113
	li 9,116
	b .L690
.L673:
	li 0,72
	li 9,75
.L690:
	stw 0,56(31)
	stw 9,4308(11)
	b .L670
.L672:
	li 0,19
	stw 0,4804(11)
	lwz 11,84(31)
	lwz 0,4316(11)
	cmpwi 0,0,0
	bc 12,2,.L676
	li 0,111
	li 9,116
	b .L691
.L676:
	li 0,70
	li 9,81
.L691:
	stw 0,56(31)
	stw 9,4308(11)
	mr 3,31
	bl ForceAnimCD
.L670:
	lis 9,.LC219@ha
	lis 11,deathmatch@ha
	la 9,.LC219@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L678
	lwz 9,84(31)
	lwz 0,4796(9)
	cmpwi 0,0,0
	bc 4,2,.L679
	lis 9,.LC220@ha
	li 4,0
	la 9,.LC220@l(9)
	mr 3,31
	lfs 1,0(9)
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC217@ha
	la 29,gi@l(29)
	la 3,.LC217@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC221@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC221@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC221@ha
	la 9,.LC221@l(9)
	lfs 2,0(9)
	lis 9,.LC219@ha
	la 9,.LC219@l(9)
	lfs 3,0(9)
	blrl
	b .L680
.L679:
	cmpwi 0,0,2
	bc 4,2,.L680
	lis 9,.LC220@ha
	li 4,2
	la 9,.LC220@l(9)
	mr 3,31
	lfs 1,0(9)
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC217@ha
	la 29,gi@l(29)
	la 3,.LC217@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC221@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC221@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC221@ha
	la 9,.LC221@l(9)
	lfs 2,0(9)
	lis 9,.LC219@ha
	la 9,.LC219@l(9)
	lfs 3,0(9)
	blrl
.L680:
	lis 9,num_players@ha
	li 30,0
	lwz 0,num_players@l(9)
	lis 27,num_players@ha
	cmpw 0,30,0
	bc 4,0,.L678
	lis 9,players@ha
	li 29,0
	la 28,players@l(9)
.L685:
	lwzx 4,29,28
	mr 3,31
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L684
	lwzx 11,29,28
	lwz 9,84(11)
	lfs 0,1952(9)
	fcmpu 0,0,31
	cror 3,2,0
	bc 4,3,.L684
	lhz 0,948(11)
	ori 0,0,16
	sth 0,948(11)
.L684:
	lwz 0,num_players@l(27)
	addi 30,30,1
	addi 29,29,4
	cmpw 0,30,0
	bc 12,0,.L685
.L678:
	lwz 0,52(1)
	mtlr 0
	lmw 27,20(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe30:
	.size	 force_wall_of_darkness,.Lfe30-force_wall_of_darkness
	.section	".rodata"
	.align 2
.LC222:
	.string	"force/taint.wav"
	.align 2
.LC223:
	.long 0x3f800000
	.align 2
.LC224:
	.long 0x0
	.section	".text"
	.align 2
	.globl force_taint
	.type	 force_taint,@function
force_taint:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	li 0,6
	mr 31,3
	mtctr 0
	lwz 9,84(31)
	li 11,0
	addi 9,9,2092
.L710:
	lhz 0,0(9)
	addi 9,9,2
	cmpwi 0,0,20
	bc 12,2,.L709
	addi 11,11,1
	bdnz .L710
	li 8,255
.L697:
	lwz 9,84(31)
	lwz 0,4316(9)
	cmpwi 0,0,0
	bc 12,2,.L700
	li 0,20
	li 10,111
	stw 0,4804(9)
	li 11,116
	b .L711
.L709:
	mr 8,11
	b .L697
.L700:
	li 0,20
	li 10,70
	stw 0,4804(9)
	li 11,81
.L711:
	lwz 9,84(31)
	stw 10,56(31)
	stw 11,4308(9)
	cmpwi 0,8,255
	bc 4,2,.L702
	lwz 9,84(31)
	lhz 11,2104(9)
	cmpwi 0,11,6
	bc 12,2,.L692
	add 11,11,11
	addi 9,9,2092
	li 0,20
	sthx 0,9,11
	lwz 10,84(31)
	lhz 9,2104(10)
	addi 9,9,1
	sth 9,2104(10)
	lwz 11,84(31)
	lwz 0,4796(11)
	cmpwi 0,0,0
	bc 4,2,.L704
	lis 9,.LC223@ha
	li 4,0
	b .L712
.L704:
	cmpwi 0,0,2
	bc 4,2,.L692
	lis 9,.LC223@ha
	li 4,2
.L712:
	la 9,.LC223@l(9)
	mr 3,31
	lfs 1,0(9)
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC222@ha
	la 29,gi@l(29)
	la 3,.LC222@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC223@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC223@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC223@ha
	la 9,.LC223@l(9)
	lfs 2,0(9)
	lis 9,.LC224@ha
	la 9,.LC224@l(9)
	lfs 3,0(9)
	blrl
	b .L692
.L702:
	lwz 9,84(31)
	add 11,8,8
	li 0,255
	addi 9,9,2092
	sthx 0,9,11
	lwz 3,84(31)
	lhz 9,2104(3)
	cmpwi 0,9,0
	bc 12,2,.L692
	addi 0,9,-1
	sth 0,2104(3)
.L692:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe31:
	.size	 force_taint,.Lfe31-force_taint
	.globl inferno
	.section	".data"
	.align 2
	.type	 inferno,@object
inferno:
	.long 0x0
	.long 0x0
	.long 0x0
	.long 0x0
	.long 0x42800000
	.long 0x0
	.long 0x42000000
	.long 0x42c00000
	.long 0x0
	.long 0x42800000
	.long 0x42800000
	.long 0x0
	.long 0x42400000
	.long 0x42400000
	.long 0x0
	.long 0x42000000
	.long 0x42000000
	.long 0x0
	.long 0x41200000
	.long 0x41200000
	.long 0x0
	.size	 inferno,84
	.section	".rodata"
	.align 3
.LC225:
	.long 0x3fc99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl Inferno_Effect_Think
	.type	 Inferno_Effect_Think,@function
Inferno_Effect_Think:
	stwu 1,-128(1)
	mflr 0
	stmw 28,112(1)
	stw 0,132(1)
	mr 31,3
	lis 9,.LC225@ha
	lfs 0,428(31)
	addi 29,1,32
	addi 4,1,16
	lfd 13,.LC225@l(9)
	addi 3,31,628
	mr 5,29
	lfs 11,4(31)
	li 6,0
	addi 30,31,4
	lfs 10,8(31)
	lfs 12,12(31)
	lwz 9,56(31)
	fadd 0,0,13
	stfs 11,28(31)
	addi 9,9,1
	stfs 10,32(31)
	stw 9,56(31)
	frsp 0,0
	stfs 12,36(31)
	stfs 0,428(31)
	bl AngleVectors
	lwz 0,56(31)
	lis 4,inferno@ha
	addi 5,1,16
	lwz 3,256(31)
	la 4,inferno@l(4)
	mr 7,30
	mulli 0,0,12
	mr 6,29
	addi 3,3,4
	add 4,0,4
	bl G_ProjectSource
	lis 11,gi+48@ha
	lwz 7,256(31)
	lis 9,0x600
	lwz 0,gi+48@l(11)
	addi 3,1,48
	mr 4,30
	addi 7,7,4
	li 5,0
	mtlr 0
	li 6,0
	mr 8,31
	ori 9,9,3
	blrl
	lwz 3,100(1)
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L720
	lwz 5,256(31)
	cmpw 0,3,5
	bc 12,2,.L720
	lwz 9,516(31)
	li 11,0
	li 0,4
	stw 0,8(1)
	mr 7,30
	mr 4,31
	stw 11,12(1)
	addi 6,31,376
	li 8,0
	li 10,1
	bl T_Damage
	mr 3,31
	bl G_FreeEdict
.L720:
	lis 9,gi@ha
	addi 29,31,4
	la 30,gi@l(9)
	mr 3,29
	lwz 9,52(30)
	mtlr 9
	blrl
	cmpwi 0,3,1
	bc 4,2,.L727
	lwz 3,100(1)
	addi 28,1,72
	lwz 5,256(31)
	cmpw 0,3,5
	bc 12,2,.L727
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L730
	lwz 9,516(31)
	li 0,4
	li 11,0
	stw 0,8(1)
	mr 7,29
	mr 8,28
	stw 11,12(1)
	mr 4,31
	addi 6,31,376
	li 10,1
	bl T_Damage
	b .L731
.L730:
	lwz 9,100(30)
	li 3,3
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,2
	mtlr 9
	blrl
	lwz 9,120(30)
	mr 3,29
	mtlr 9
	blrl
	lwz 9,124(30)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(30)
	mr 3,29
	li 4,2
	mtlr 0
	blrl
.L731:
	mr 3,31
	bl G_FreeEdict
.L727:
	lwz 0,56(31)
	cmpwi 0,0,6
	bc 4,2,.L734
	mr 3,31
	bl G_FreeEdict
.L734:
	lwz 0,132(1)
	mtlr 0
	lmw 28,112(1)
	la 1,128(1)
	blr
.Lfe32:
	.size	 Inferno_Effect_Think,.Lfe32-Inferno_Effect_Think
	.section	".rodata"
	.align 2
.LC226:
	.string	"monsters/trooper/tris.md2"
	.align 3
.LC227:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl Inferno_Effect_Spawn
	.type	 Inferno_Effect_Spawn,@function
Inferno_Effect_Spawn:
	stwu 1,-80(1)
	mflr 0
	stmw 26,56(1)
	stw 0,84(1)
	mr 28,3
	mr 27,4
	bl G_Spawn
	mr 29,3
	addi 26,1,24
	addi 4,1,8
	mr 5,26
	stw 28,256(29)
	mr 3,27
	li 6,0
	bl AngleVectors
	lis 4,inferno@ha
	mr 6,26
	addi 7,29,4
	addi 3,28,4
	la 4,inferno@l(4)
	addi 5,1,8
	bl G_ProjectSource
	lfs 0,4(28)
	lis 26,gi@ha
	la 26,gi@l(26)
	lis 3,.LC226@ha
	la 3,.LC226@l(3)
	stfs 0,28(29)
	lfs 0,8(28)
	stfs 0,32(29)
	lfs 13,12(28)
	stfs 13,36(29)
	lfs 0,0(27)
	stfs 0,628(29)
	lfs 13,4(27)
	stfs 13,632(29)
	lfs 0,8(27)
	stfs 0,636(29)
	lwz 9,84(28)
	lfs 0,2068(9)
	fctiwz 12,0
	stfd 12,48(1)
	lwz 11,52(1)
	stw 11,516(29)
	lwz 9,32(26)
	mtlr 9
	blrl
	lis 9,Inferno_Effect_Touch@ha
	lis 10,Inferno_Effect_Think@ha
	stw 3,40(29)
	la 9,Inferno_Effect_Touch@l(9)
	lis 0,0xc180
	stw 9,444(29)
	lis 11,0x4180
	li 8,0
	la 10,Inferno_Effect_Think@l(10)
	li 9,1
	stw 0,196(29)
	stw 11,208(29)
	lis 7,level+4@ha
	lis 6,.LC227@ha
	stw 9,248(29)
	mr 3,29
	stw 8,260(29)
	stw 10,436(29)
	stw 0,188(29)
	stw 0,192(29)
	stw 11,200(29)
	stw 11,204(29)
	stw 8,56(29)
	lfs 0,level+4@l(7)
	lfd 13,.LC227@l(6)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,72(26)
	mtlr 0
	blrl
	lwz 0,84(1)
	mtlr 0
	lmw 26,56(1)
	la 1,80(1)
	blr
.Lfe33:
	.size	 Inferno_Effect_Spawn,.Lfe33-Inferno_Effect_Spawn
	.section	".rodata"
	.align 2
.LC228:
	.string	"force/inferno.wav"
	.align 2
.LC229:
	.long 0x3f800000
	.align 2
.LC230:
	.long 0x0
	.section	".text"
	.align 2
	.globl force_inferno
	.type	 force_inferno,@function
force_inferno:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	li 29,0
	mr 31,3
	addi 4,1,8
	stw 29,12(1)
	stw 29,8(1)
	stw 29,16(1)
	bl Inferno_Effect_Spawn
	lis 0,0x42b4
	addi 4,1,8
	stw 29,8(1)
	stw 0,12(1)
	mr 3,31
	bl Inferno_Effect_Spawn
	lis 0,0x4334
	addi 4,1,8
	stw 29,8(1)
	stw 0,12(1)
	mr 3,31
	bl Inferno_Effect_Spawn
	lis 0,0x4387
	stw 29,8(1)
	mr 3,31
	stw 0,12(1)
	addi 4,1,8
	bl Inferno_Effect_Spawn
	lwz 9,84(31)
	lwz 0,4316(9)
	cmpwi 0,0,0
	bc 12,2,.L739
	li 0,21
	li 10,111
	stw 0,4804(9)
	li 11,116
	b .L744
.L739:
	li 0,21
	li 10,70
	stw 0,4804(9)
	li 11,81
.L744:
	lwz 9,84(31)
	stw 10,56(31)
	stw 11,4308(9)
	lwz 9,84(31)
	lwz 0,4796(9)
	cmpwi 0,0,0
	bc 4,2,.L741
	lis 9,.LC229@ha
	li 4,0
	la 9,.LC229@l(9)
	mr 3,31
	lfs 1,0(9)
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC228@ha
	la 29,gi@l(29)
	la 3,.LC228@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC229@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC229@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC229@ha
	la 9,.LC229@l(9)
	lfs 2,0(9)
	lis 9,.LC230@ha
	la 9,.LC230@l(9)
	lfs 3,0(9)
	blrl
	b .L742
.L741:
	cmpwi 0,0,2
	bc 4,2,.L742
	lis 9,.LC229@ha
	li 4,2
	la 9,.LC229@l(9)
	mr 3,31
	lfs 1,0(9)
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC228@ha
	la 29,gi@l(29)
	la 3,.LC228@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC229@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC229@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC229@ha
	la 9,.LC229@l(9)
	lfs 2,0(9)
	lis 9,.LC230@ha
	la 9,.LC230@l(9)
	lfs 3,0(9)
	blrl
.L742:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe34:
	.size	 force_inferno,.Lfe34-force_inferno
	.section	".rodata"
	.align 2
.LC232:
	.string	"force/rage.wav"
	.align 2
.LC231:
	.long 0x401820c5
	.align 2
.LC233:
	.long 0x41200000
	.align 2
.LC234:
	.long 0x42c80000
	.align 2
.LC235:
	.long 0x3f800000
	.align 2
.LC236:
	.long 0x0
	.section	".text"
	.align 2
	.globl force_rage
	.type	 force_rage,@function
force_rage:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,480(31)
	cmpwi 0,0,50
	bc 4,1,.L745
	lwz 9,84(31)
	lwz 0,4316(9)
	cmpwi 0,0,0
	bc 12,2,.L747
	li 0,22
	li 10,111
	stw 0,4804(9)
	li 11,116
	b .L752
.L747:
	li 0,22
	li 10,70
	stw 0,4804(9)
	li 11,81
.L752:
	lwz 9,84(31)
	stw 10,56(31)
	stw 11,4308(9)
	lwz 11,84(31)
	lis 9,.LC233@ha
	la 9,.LC233@l(9)
	lfs 0,2072(11)
	lfs 13,0(9)
	lis 9,.LC234@ha
	la 9,.LC234@l(9)
	fdivs 0,0,13
	lfs 12,0(9)
	fadds 0,0,12
	stfs 0,1852(11)
	lwz 9,480(31)
	lwz 11,84(31)
	addi 9,9,-50
	stw 9,480(31)
	lwz 0,4796(11)
	cmpwi 0,0,0
	bc 4,2,.L749
	lis 9,.LC231@ha
	li 4,0
	lfs 1,.LC231@l(9)
	mr 3,31
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC232@ha
	la 29,gi@l(29)
	la 3,.LC232@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC235@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC235@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC235@ha
	la 9,.LC235@l(9)
	lfs 2,0(9)
	lis 9,.LC236@ha
	la 9,.LC236@l(9)
	lfs 3,0(9)
	blrl
	b .L745
.L749:
	cmpwi 0,0,2
	bc 4,2,.L745
	lis 9,.LC231@ha
	li 4,2
	lfs 1,.LC231@l(9)
	mr 3,31
	bl sound_delay
	lis 29,gi@ha
	lis 3,.LC232@ha
	la 29,gi@l(29)
	la 3,.LC232@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC235@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC235@l(9)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC235@ha
	la 9,.LC235@l(9)
	lfs 2,0(9)
	lis 9,.LC236@ha
	la 9,.LC236@l(9)
	lfs 3,0(9)
	blrl
.L745:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 force_rage,.Lfe35-force_rage
	.section	".rodata"
	.align 2
.LC237:
	.string	"Blaster"
	.align 2
.LC238:
	.string	"Trooper_Rifle"
	.align 2
.LC239:
	.string	"Repeater"
	.align 2
.LC240:
	.string	"Bowcaster"
	.align 2
.LC241:
	.string	"Wrist_Rocket"
	.align 2
.LC242:
	.string	"Rocket_Launcher"
	.align 2
.LC243:
	.string	"Disruptor"
	.align 2
.LC244:
	.string	"Night_Stinger"
	.align 2
.LC245:
	.string	"Beam_Tube"
	.align 2
.LC246:
	.string	"Thermals"
	.align 2
.LC247:
	.string	"Lightsaber"
	.section	".text"
	.align 2
	.globl weapon_menu_use
	.type	 weapon_menu_use,@function
weapon_menu_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 11,84(3)
	lwz 9,4624(11)
	addi 11,11,4704
	addi 9,9,-1
	add 9,9,9
	lhzx 10,11,9
	cmplwi 0,10,12
	bc 12,1,.L768
	lis 11,.L769@ha
	slwi 10,10,2
	la 11,.L769@l(11)
	lis 9,.L769@ha
	lwzx 0,10,11
	la 9,.L769@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L769:
	.long .L767-.L769
	.long .L756-.L769
	.long .L757-.L769
	.long .L758-.L769
	.long .L767-.L769
	.long .L760-.L769
	.long .L761-.L769
	.long .L762-.L769
	.long .L763-.L769
	.long .L764-.L769
	.long .L765-.L769
	.long .L766-.L769
	.long .L767-.L769
.L756:
	lis 3,.LC238@ha
	la 3,.LC238@l(3)
	bl FindItem
	b .L754
.L757:
	lis 3,.LC239@ha
	la 3,.LC239@l(3)
	bl FindItem
	b .L754
.L758:
	lis 3,.LC240@ha
	la 3,.LC240@l(3)
	bl FindItem
	b .L754
.L760:
	lis 3,.LC241@ha
	la 3,.LC241@l(3)
	bl FindItem
	b .L754
.L761:
	lis 3,.LC242@ha
	la 3,.LC242@l(3)
	bl FindItem
	b .L754
.L762:
	lis 3,.LC243@ha
	la 3,.LC243@l(3)
	bl FindItem
	b .L754
.L763:
	lis 3,.LC244@ha
	la 3,.LC244@l(3)
	bl FindItem
	b .L754
.L764:
	lis 3,.LC245@ha
	la 3,.LC245@l(3)
	bl FindItem
	b .L754
.L765:
	lis 3,.LC246@ha
	la 3,.LC246@l(3)
	bl FindItem
	b .L754
.L766:
	lis 3,.LC247@ha
	la 3,.LC247@l(3)
	bl FindItem
	b .L754
.L767:
	lis 3,.LC237@ha
	la 3,.LC237@l(3)
	bl FindItem
	b .L754
.L768:
	lis 3,.LC237@ha
	la 3,.LC237@l(3)
	bl FindItem
.L754:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe36:
	.size	 weapon_menu_use,.Lfe36-weapon_menu_use
	.align 2
	.globl setup_weap_menu
	.type	 setup_weap_menu,@function
setup_weap_menu:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 31,3
	li 0,0
	lwz 11,84(31)
	lis 9,.LC237@ha
	lis 30,0x286b
	la 26,.LC237@l(9)
	ori 30,30,51739
	sth 0,4692(11)
	mr 3,26
	lwz 9,84(31)
	sth 0,4694(9)
	lwz 11,84(31)
	sth 0,4696(11)
	lwz 9,84(31)
	sth 0,4698(9)
	bl FindItem
	lis 9,itemlist@ha
	mr 29,3
	lwz 11,84(31)
	la 27,itemlist@l(9)
	subf 0,27,29
	addi 11,11,740
	mullw 0,0,30
	rlwinm 28,0,0,0,29
	lwzx 9,11,28
	cmpwi 0,9,0
	bc 4,2,.L776
	li 11,0
	b .L777
.L776:
	lis 3,.LC247@ha
	mr 4,26
	la 3,.LC247@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L778
	li 11,1
	b .L777
.L778:
	lwz 3,52(29)
	bl FindItem
	subf 3,27,3
	lwz 10,84(31)
	li 11,1
	mullw 3,3,30
	addi 9,10,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	cmpwi 0,0,0
	bc 4,2,.L777
	addi 9,10,1792
	lwzx 0,9,28
	addic 9,0,-1
	subfe 11,9,0
.L777:
	cmpwi 0,11,0
	bc 12,2,.L775
	lwz 9,84(31)
	li 0,1
	stw 0,4628(9)
	lwz 11,84(31)
	lhz 9,4692(11)
	addi 9,9,1
	sth 9,4692(11)
	b .L780
.L775:
	lwz 9,84(31)
	stw 11,4628(9)
.L780:
	lis 9,.LC238@ha
	lis 30,0x286b
	la 27,.LC238@l(9)
	ori 30,30,51739
	mr 3,27
	bl FindItem
	lis 9,itemlist@ha
	mr 29,3
	lwz 11,84(31)
	la 26,itemlist@l(9)
	subf 0,26,29
	addi 11,11,740
	mullw 0,0,30
	rlwinm 28,0,0,0,29
	lwzx 9,11,28
	cmpwi 0,9,0
	bc 4,2,.L782
	li 11,0
	b .L783
.L782:
	lis 3,.LC247@ha
	mr 4,27
	la 3,.LC247@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L784
	li 11,1
	b .L783
.L784:
	lwz 3,52(29)
	bl FindItem
	subf 3,26,3
	lwz 10,84(31)
	li 11,1
	mullw 3,3,30
	addi 9,10,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	cmpwi 0,0,0
	bc 4,2,.L783
	addi 9,10,1792
	lwzx 0,9,28
	addic 9,0,-1
	subfe 11,9,0
.L783:
	cmpwi 0,11,0
	bc 12,2,.L781
	lwz 9,84(31)
	li 0,1
	stw 0,4632(9)
	lwz 11,84(31)
	lhz 9,4692(11)
	addi 9,9,1
	sth 9,4692(11)
	b .L786
.L781:
	lwz 9,84(31)
	stw 11,4632(9)
.L786:
	lis 9,.LC239@ha
	lis 30,0x286b
	la 27,.LC239@l(9)
	ori 30,30,51739
	mr 3,27
	bl FindItem
	lis 9,itemlist@ha
	mr 29,3
	lwz 11,84(31)
	la 26,itemlist@l(9)
	subf 0,26,29
	addi 11,11,740
	mullw 0,0,30
	rlwinm 28,0,0,0,29
	lwzx 9,11,28
	cmpwi 0,9,0
	bc 4,2,.L788
	li 11,0
	b .L789
.L788:
	lis 3,.LC247@ha
	mr 4,27
	la 3,.LC247@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L790
	li 11,1
	b .L789
.L790:
	lwz 3,52(29)
	bl FindItem
	subf 3,26,3
	lwz 10,84(31)
	li 11,1
	mullw 3,3,30
	addi 9,10,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	cmpwi 0,0,0
	bc 4,2,.L789
	addi 9,10,1792
	lwzx 0,9,28
	addic 9,0,-1
	subfe 11,9,0
.L789:
	cmpwi 0,11,0
	bc 12,2,.L787
	lwz 9,84(31)
	li 0,1
	stw 0,4636(9)
	lwz 11,84(31)
	lhz 9,4692(11)
	addi 9,9,1
	sth 9,4692(11)
	b .L792
.L787:
	lwz 9,84(31)
	stw 11,4636(9)
.L792:
	lis 9,.LC240@ha
	lis 30,0x286b
	la 27,.LC240@l(9)
	ori 30,30,51739
	mr 3,27
	bl FindItem
	lis 9,itemlist@ha
	mr 29,3
	lwz 11,84(31)
	la 26,itemlist@l(9)
	subf 0,26,29
	addi 11,11,740
	mullw 0,0,30
	rlwinm 28,0,0,0,29
	lwzx 9,11,28
	cmpwi 0,9,0
	bc 4,2,.L794
	li 11,0
	b .L795
.L794:
	lis 3,.LC247@ha
	mr 4,27
	la 3,.LC247@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L796
	li 11,1
	b .L795
.L796:
	lwz 3,52(29)
	bl FindItem
	subf 3,26,3
	lwz 10,84(31)
	li 11,1
	mullw 3,3,30
	addi 9,10,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	cmpwi 0,0,0
	bc 4,2,.L795
	addi 9,10,1792
	lwzx 0,9,28
	addic 9,0,-1
	subfe 11,9,0
.L795:
	cmpwi 0,11,0
	bc 12,2,.L793
	lwz 9,84(31)
	li 0,1
	stw 0,4640(9)
	lwz 11,84(31)
	lhz 9,4692(11)
	addi 9,9,1
	sth 9,4692(11)
	b .L798
.L793:
	lwz 9,84(31)
	stw 11,4640(9)
.L798:
	lwz 11,84(31)
	lis 9,.LC241@ha
	li 0,0
	la 26,.LC241@l(9)
	lis 30,0x286b
	stw 0,4644(11)
	mr 3,26
	ori 30,30,51739
	bl FindItem
	lis 9,itemlist@ha
	mr 29,3
	lwz 11,84(31)
	la 27,itemlist@l(9)
	subf 0,27,29
	addi 11,11,740
	mullw 0,0,30
	rlwinm 28,0,0,0,29
	lwzx 9,11,28
	cmpwi 0,9,0
	bc 4,2,.L800
	li 11,0
	b .L801
.L800:
	lis 3,.LC247@ha
	mr 4,26
	la 3,.LC247@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L802
	li 11,1
	b .L801
.L802:
	lwz 3,52(29)
	bl FindItem
	subf 3,27,3
	lwz 10,84(31)
	li 11,1
	mullw 3,3,30
	addi 9,10,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	cmpwi 0,0,0
	bc 4,2,.L801
	addi 9,10,1792
	lwzx 0,9,28
	addic 9,0,-1
	subfe 11,9,0
.L801:
	cmpwi 0,11,0
	bc 12,2,.L799
	lwz 9,84(31)
	li 0,1
	stw 0,4648(9)
	lwz 11,84(31)
	lhz 9,4694(11)
	addi 9,9,1
	sth 9,4694(11)
	b .L804
.L799:
	lwz 9,84(31)
	stw 11,4648(9)
.L804:
	lis 9,.LC242@ha
	lis 30,0x286b
	la 27,.LC242@l(9)
	ori 30,30,51739
	mr 3,27
	bl FindItem
	lis 9,itemlist@ha
	mr 29,3
	lwz 11,84(31)
	la 26,itemlist@l(9)
	subf 0,26,29
	addi 11,11,740
	mullw 0,0,30
	rlwinm 28,0,0,0,29
	lwzx 9,11,28
	cmpwi 0,9,0
	bc 4,2,.L806
	li 11,0
	b .L807
.L806:
	lis 3,.LC247@ha
	mr 4,27
	la 3,.LC247@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L808
	li 11,1
	b .L807
.L808:
	lwz 3,52(29)
	bl FindItem
	subf 3,26,3
	lwz 10,84(31)
	li 11,1
	mullw 3,3,30
	addi 9,10,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	cmpwi 0,0,0
	bc 4,2,.L807
	addi 9,10,1792
	lwzx 0,9,28
	addic 9,0,-1
	subfe 11,9,0
.L807:
	cmpwi 0,11,0
	bc 12,2,.L805
	lwz 9,84(31)
	li 0,1
	stw 0,4652(9)
	lwz 11,84(31)
	lhz 9,4694(11)
	addi 9,9,1
	sth 9,4694(11)
	b .L810
.L805:
	lwz 9,84(31)
	stw 11,4652(9)
.L810:
	lis 9,.LC243@ha
	lis 30,0x286b
	la 27,.LC243@l(9)
	ori 30,30,51739
	mr 3,27
	bl FindItem
	lis 9,itemlist@ha
	mr 29,3
	lwz 11,84(31)
	la 26,itemlist@l(9)
	subf 0,26,29
	addi 11,11,740
	mullw 0,0,30
	rlwinm 28,0,0,0,29
	lwzx 9,11,28
	cmpwi 0,9,0
	bc 4,2,.L812
	li 11,0
	b .L813
.L812:
	lis 3,.LC247@ha
	mr 4,27
	la 3,.LC247@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L814
	li 11,1
	b .L813
.L814:
	lwz 3,52(29)
	bl FindItem
	subf 3,26,3
	lwz 10,84(31)
	li 11,1
	mullw 3,3,30
	addi 9,10,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	cmpwi 0,0,0
	bc 4,2,.L813
	addi 9,10,1792
	lwzx 0,9,28
	addic 9,0,-1
	subfe 11,9,0
.L813:
	cmpwi 0,11,0
	bc 12,2,.L811
	lwz 9,84(31)
	li 0,1
	stw 0,4656(9)
	lwz 11,84(31)
	lhz 9,4696(11)
	addi 9,9,1
	sth 9,4696(11)
	b .L816
.L811:
	lwz 9,84(31)
	stw 11,4656(9)
.L816:
	lis 9,.LC244@ha
	lis 30,0x286b
	la 27,.LC244@l(9)
	ori 30,30,51739
	mr 3,27
	bl FindItem
	lis 9,itemlist@ha
	mr 29,3
	lwz 11,84(31)
	la 26,itemlist@l(9)
	subf 0,26,29
	addi 11,11,740
	mullw 0,0,30
	rlwinm 28,0,0,0,29
	lwzx 9,11,28
	cmpwi 0,9,0
	bc 4,2,.L818
	li 11,0
	b .L819
.L818:
	lis 3,.LC247@ha
	mr 4,27
	la 3,.LC247@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L820
	li 11,1
	b .L819
.L820:
	lwz 3,52(29)
	bl FindItem
	subf 3,26,3
	lwz 10,84(31)
	li 11,1
	mullw 3,3,30
	addi 9,10,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	cmpwi 0,0,0
	bc 4,2,.L819
	addi 9,10,1792
	lwzx 0,9,28
	addic 9,0,-1
	subfe 11,9,0
.L819:
	cmpwi 0,11,0
	bc 12,2,.L817
	lwz 9,84(31)
	li 0,1
	stw 0,4660(9)
	lwz 11,84(31)
	lhz 9,4696(11)
	addi 9,9,1
	sth 9,4696(11)
	b .L822
.L817:
	lwz 9,84(31)
	stw 11,4660(9)
.L822:
	lis 9,.LC245@ha
	lis 30,0x286b
	la 27,.LC245@l(9)
	ori 30,30,51739
	mr 3,27
	bl FindItem
	lis 9,itemlist@ha
	mr 29,3
	lwz 11,84(31)
	la 26,itemlist@l(9)
	subf 0,26,29
	addi 11,11,740
	mullw 0,0,30
	rlwinm 28,0,0,0,29
	lwzx 9,11,28
	cmpwi 0,9,0
	bc 4,2,.L824
	li 11,0
	b .L825
.L824:
	lis 3,.LC247@ha
	mr 4,27
	la 3,.LC247@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L826
	li 11,1
	b .L825
.L826:
	lwz 3,52(29)
	bl FindItem
	subf 3,26,3
	lwz 10,84(31)
	li 11,1
	mullw 3,3,30
	addi 9,10,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	cmpwi 0,0,0
	bc 4,2,.L825
	addi 9,10,1792
	lwzx 0,9,28
	addic 9,0,-1
	subfe 11,9,0
.L825:
	cmpwi 0,11,0
	bc 12,2,.L823
	lwz 9,84(31)
	li 0,1
	stw 0,4664(9)
	lwz 11,84(31)
	lhz 9,4696(11)
	addi 9,9,1
	sth 9,4696(11)
	b .L828
.L823:
	lwz 9,84(31)
	stw 11,4664(9)
.L828:
	lis 9,.LC246@ha
	lis 30,0x286b
	la 27,.LC246@l(9)
	ori 30,30,51739
	mr 3,27
	bl FindItem
	lis 9,itemlist@ha
	mr 29,3
	lwz 11,84(31)
	la 26,itemlist@l(9)
	subf 0,26,29
	addi 11,11,740
	mullw 0,0,30
	rlwinm 28,0,0,0,29
	lwzx 9,11,28
	cmpwi 0,9,0
	bc 4,2,.L830
	li 11,0
	b .L831
.L830:
	lis 3,.LC247@ha
	mr 4,27
	la 3,.LC247@l(3)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L832
	li 11,1
	b .L831
.L832:
	lwz 3,52(29)
	bl FindItem
	subf 3,26,3
	lwz 10,84(31)
	li 11,1
	mullw 3,3,30
	addi 9,10,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	cmpwi 0,0,0
	bc 4,2,.L831
	addi 9,10,1792
	lwzx 0,9,28
	addic 9,0,-1
	subfe 11,9,0
.L831:
	cmpwi 0,11,0
	bc 12,2,.L829
	lwz 9,84(31)
	li 0,1
	stw 0,4668(9)
	lwz 11,84(31)
	lhz 9,4698(11)
	addi 9,9,1
	sth 9,4698(11)
	b .L834
.L829:
	lwz 9,84(31)
	stw 11,4668(9)
.L834:
	lis 9,.LC247@ha
	lis 30,0x286b
	la 27,.LC247@l(9)
	ori 30,30,51739
	mr 3,27
	bl FindItem
	lis 9,itemlist@ha
	mr 29,3
	lwz 11,84(31)
	la 26,itemlist@l(9)
	subf 0,26,29
	addi 11,11,740
	mullw 0,0,30
	rlwinm 28,0,0,0,29
	lwzx 9,11,28
	cmpwi 0,9,0
	bc 4,2,.L836
	li 11,0
	b .L837
.L836:
	mr 3,27
	mr 4,3
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L838
	li 11,1
	b .L837
.L838:
	lwz 3,52(29)
	bl FindItem
	subf 3,26,3
	lwz 10,84(31)
	li 11,1
	mullw 3,3,30
	addi 9,10,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	cmpwi 0,0,0
	bc 4,2,.L837
	addi 9,10,1792
	lwzx 0,9,28
	addic 9,0,-1
	subfe 11,9,0
.L837:
	cmpwi 0,11,0
	bc 12,2,.L835
	lwz 9,84(31)
	li 0,1
	stw 0,4672(9)
	lwz 11,84(31)
	lhz 9,4698(11)
	addi 9,9,1
	sth 9,4698(11)
	b .L840
.L835:
	lwz 9,84(31)
	stw 11,4672(9)
.L840:
	lwz 9,84(31)
	li 0,0
	stw 0,4676(9)
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe37:
	.size	 setup_weap_menu,.Lfe37-setup_weap_menu
	.section	".rodata"
	.align 2
.LC248:
	.string	"weapons/menu1"
	.align 2
.LC249:
	.string	"weapons/wm_pist2"
	.align 2
.LC250:
	.string	"weapons/wm_trpr2"
	.align 2
.LC251:
	.string	"weapons/wm_rapid2"
	.align 2
.LC252:
	.string	"weapons/wm_arrw2"
	.section	".text"
	.align 2
	.globl set_sub_menu1_weap
	.type	 set_sub_menu1_weap,@function
set_sub_menu1_weap:
	stwu 1,-64(1)
	mflr 0
	stmw 23,28(1)
	stw 0,68(1)
	mr 31,3
	li 0,255
	lwz 11,84(31)
	stw 0,20(1)
	stw 0,8(1)
	stw 0,12(1)
	stw 0,16(1)
	lhz 9,4620(11)
	cmpwi 0,9,1
	bc 4,2,.L841
	lis 9,gi@ha
	lis 3,.LC248@ha
	la 9,gi@l(9)
	la 3,.LC248@l(3)
	lwz 0,40(9)
	mr 29,9
	li 30,0
	li 23,0
	li 24,40
	mtlr 0
	li 25,40
	li 26,40
	li 27,40
	li 28,40
	blrl
	lwz 9,84(31)
	sth 3,142(9)
.L846:
	lwz 9,84(31)
	lwz 0,4628(9)
	mr 11,9
	cmpwi 0,0,0
	bc 12,2,.L847
	lwz 0,8(1)
	cmpwi 0,0,255
	bc 4,2,.L847
	stw 30,8(1)
	lis 3,.LC249@ha
	lwz 9,40(29)
	la 3,.LC249@l(3)
	mtlr 9
	blrl
	lwz 11,84(31)
	add 0,30,30
	addi 11,11,120
	sthx 3,11,28
	lwz 9,84(31)
	addi 9,9,4704
	sthx 23,9,0
	b .L845
.L847:
	lwz 0,4632(11)
	cmpwi 0,0,0
	bc 12,2,.L848
	lwz 0,12(1)
	cmpwi 0,0,255
	bc 4,2,.L848
	stw 30,12(1)
	lis 3,.LC250@ha
	lwz 9,40(29)
	la 3,.LC250@l(3)
	mtlr 9
	blrl
	lwz 11,84(31)
	add 10,30,30
	li 0,1
	addi 11,11,120
	sthx 3,11,27
	b .L853
.L848:
	lwz 0,4636(11)
	cmpwi 0,0,0
	bc 12,2,.L849
	lwz 0,16(1)
	cmpwi 0,0,255
	bc 4,2,.L849
	stw 30,16(1)
	lis 3,.LC251@ha
	lwz 9,40(29)
	la 3,.LC251@l(3)
	mtlr 9
	blrl
	lwz 11,84(31)
	add 10,30,30
	li 0,2
	addi 11,11,120
	sthx 3,11,26
	b .L853
.L849:
	lwz 0,4640(11)
	cmpwi 0,0,0
	bc 12,2,.L850
	lwz 0,20(1)
	cmpwi 0,0,255
	bc 4,2,.L850
	stw 30,20(1)
	lis 3,.LC252@ha
	lwz 9,40(29)
	la 3,.LC252@l(3)
	mtlr 9
	blrl
	lwz 11,84(31)
	add 10,30,30
	li 0,3
	addi 11,11,120
	sthx 3,11,25
.L853:
	lwz 9,84(31)
	addi 9,9,4704
	sthx 0,9,10
	b .L845
.L850:
	lwz 9,84(31)
	addi 9,9,120
	sthx 23,9,24
.L845:
	addi 30,30,1
	addi 24,24,2
	cmpwi 0,30,4
	addi 25,25,2
	addi 26,26,2
	addi 27,27,2
	addi 28,28,2
	bc 4,1,.L846
	lwz 3,84(31)
	lha 0,160(3)
	cmpwi 0,0,0
	bc 12,2,.L841
	lwz 9,4624(3)
	addi 10,3,120
	addi 9,9,19
	add 9,9,9
	lhzx 11,10,9
	addi 11,11,-1
	sthx 11,10,9
.L841:
	lwz 0,68(1)
	mtlr 0
	lmw 23,28(1)
	la 1,64(1)
	blr
.Lfe38:
	.size	 set_sub_menu1_weap,.Lfe38-set_sub_menu1_weap
	.section	".rodata"
	.align 2
.LC253:
	.string	"weapons/menu2"
	.align 2
.LC254:
	.string	"weapons/wm_tdlauncher2"
	.align 2
.LC255:
	.string	"weapons/wm_wrstrkt2"
	.align 2
.LC256:
	.string	"weapons/wm_mtube2"
	.section	".text"
	.align 2
	.globl set_sub_menu2_weap
	.type	 set_sub_menu2_weap,@function
set_sub_menu2_weap:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	mr 31,3
	li 0,255
	lwz 11,84(31)
	stw 0,16(1)
	stw 0,8(1)
	stw 0,12(1)
	lhz 9,4620(11)
	cmpwi 0,9,2
	bc 4,2,.L854
	lis 9,gi@ha
	lis 3,.LC253@ha
	la 9,gi@l(9)
	la 3,.LC253@l(3)
	lwz 0,40(9)
	mr 25,9
	li 30,0
	li 26,40
	li 27,40
	mtlr 0
	li 28,40
	li 29,40
	blrl
	lwz 9,84(31)
	sth 3,142(9)
.L859:
	lwz 9,84(31)
	lwz 0,4644(9)
	mr 11,9
	cmpwi 0,0,0
	bc 12,2,.L860
	lwz 0,8(1)
	cmpwi 0,0,255
	bc 4,2,.L860
	stw 30,8(1)
	lis 3,.LC254@ha
	lwz 9,40(25)
	la 3,.LC254@l(3)
	mtlr 9
	blrl
	lwz 11,84(31)
	add 10,30,30
	li 0,4
	addi 11,11,120
	sthx 3,11,29
	b .L865
.L860:
	lwz 0,4648(11)
	cmpwi 0,0,0
	bc 12,2,.L861
	lwz 0,12(1)
	cmpwi 0,0,255
	bc 4,2,.L861
	stw 30,12(1)
	lis 3,.LC255@ha
	lwz 9,40(25)
	la 3,.LC255@l(3)
	mtlr 9
	blrl
	lwz 11,84(31)
	add 10,30,30
	li 0,5
	addi 11,11,120
	sthx 3,11,28
	b .L865
.L861:
	lwz 0,4652(11)
	cmpwi 0,0,0
	bc 12,2,.L862
	lwz 0,16(1)
	cmpwi 0,0,255
	bc 4,2,.L862
	stw 30,16(1)
	lis 3,.LC256@ha
	lwz 9,40(25)
	la 3,.LC256@l(3)
	mtlr 9
	blrl
	lwz 11,84(31)
	add 10,30,30
	li 0,6
	addi 11,11,120
	sthx 3,11,27
.L865:
	lwz 9,84(31)
	addi 9,9,4704
	sthx 0,9,10
	b .L858
.L862:
	lwz 9,84(31)
	li 0,0
	addi 9,9,120
	sthx 0,9,26
.L858:
	addi 30,30,1
	addi 26,26,2
	cmpwi 0,30,4
	addi 27,27,2
	addi 28,28,2
	addi 29,29,2
	bc 4,1,.L859
	lwz 3,84(31)
	lha 0,160(3)
	cmpwi 0,0,0
	bc 12,2,.L854
	lwz 9,4624(3)
	addi 10,3,120
	addi 9,9,19
	add 9,9,9
	lhzx 11,10,9
	addi 11,11,-1
	sthx 11,10,9
.L854:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe39:
	.size	 set_sub_menu2_weap,.Lfe39-set_sub_menu2_weap
	.section	".rodata"
	.align 2
.LC257:
	.string	"weapons/menu3"
	.align 2
.LC258:
	.string	"weapons/wm_dis2"
	.align 2
.LC259:
	.string	"weapons/wm_nstg2"
	.align 2
.LC260:
	.string	"weapons/wm_beam2"
	.section	".text"
	.align 2
	.globl set_sub_menu3_weap
	.type	 set_sub_menu3_weap,@function
set_sub_menu3_weap:
	stwu 1,-64(1)
	mflr 0
	stmw 25,36(1)
	stw 0,68(1)
	mr 31,3
	li 0,255
	lwz 11,84(31)
	stw 0,16(1)
	stw 0,8(1)
	stw 0,12(1)
	lhz 9,4620(11)
	cmpwi 0,9,3
	bc 4,2,.L866
	lis 9,gi@ha
	lis 3,.LC257@ha
	la 9,gi@l(9)
	la 3,.LC257@l(3)
	lwz 0,40(9)
	mr 25,9
	li 30,0
	li 26,40
	li 27,40
	mtlr 0
	li 28,40
	li 29,40
	blrl
	lwz 9,84(31)
	sth 3,142(9)
.L871:
	lwz 9,84(31)
	lwz 0,4656(9)
	mr 11,9
	cmpwi 0,0,0
	bc 12,2,.L872
	lwz 0,8(1)
	cmpwi 0,0,255
	bc 4,2,.L872
	stw 30,8(1)
	lis 3,.LC258@ha
	lwz 9,40(25)
	la 3,.LC258@l(3)
	mtlr 9
	blrl
	lwz 11,84(31)
	add 10,30,30
	li 0,7
	addi 11,11,120
	sthx 3,11,29
	b .L877
.L872:
	lwz 0,4660(11)
	cmpwi 0,0,0
	bc 12,2,.L873
	lwz 0,12(1)
	cmpwi 0,0,255
	bc 4,2,.L873
	stw 30,12(1)
	lis 3,.LC259@ha
	lwz 9,40(25)
	la 3,.LC259@l(3)
	mtlr 9
	blrl
	lwz 11,84(31)
	add 10,30,30
	li 0,8
	addi 11,11,120
	sthx 3,11,28
	b .L877
.L873:
	lwz 0,4664(11)
	cmpwi 0,0,0
	bc 12,2,.L874
	lwz 0,16(1)
	cmpwi 0,0,255
	bc 4,2,.L874
	stw 30,16(1)
	lis 3,.LC260@ha
	lwz 9,40(25)
	la 3,.LC260@l(3)
	mtlr 9
	blrl
	lwz 11,84(31)
	add 10,30,30
	li 0,9
	addi 11,11,120
	sthx 3,11,27
.L877:
	lwz 9,84(31)
	addi 9,9,4704
	sthx 0,9,10
	b .L870
.L874:
	lwz 9,84(31)
	li 0,0
	addi 9,9,120
	sthx 0,9,26
.L870:
	addi 30,30,1
	addi 26,26,2
	cmpwi 0,30,4
	addi 27,27,2
	addi 28,28,2
	addi 29,29,2
	bc 4,1,.L871
	lwz 3,84(31)
	lha 0,160(3)
	cmpwi 0,0,0
	bc 12,2,.L866
	lwz 9,4624(3)
	addi 10,3,120
	addi 9,9,19
	add 9,9,9
	lhzx 11,10,9
	addi 11,11,-1
	sthx 11,10,9
.L866:
	lwz 0,68(1)
	mtlr 0
	lmw 25,36(1)
	la 1,64(1)
	blr
.Lfe40:
	.size	 set_sub_menu3_weap,.Lfe40-set_sub_menu3_weap
	.section	".rodata"
	.align 2
.LC261:
	.string	"weapons/menu4"
	.align 2
.LC262:
	.string	"weapons/wm_thrm2"
	.align 2
.LC263:
	.string	"weapons/wm_sabr2"
	.section	".text"
	.align 2
	.globl set_sub_menu4_weap
	.type	 set_sub_menu4_weap,@function
set_sub_menu4_weap:
	stwu 1,-64(1)
	mflr 0
	stmw 24,32(1)
	stw 0,68(1)
	mr 31,3
	li 0,255
	lwz 11,84(31)
	stw 0,16(1)
	stw 0,8(1)
	stw 0,12(1)
	lhz 9,4620(11)
	cmpwi 0,9,4
	bc 4,2,.L878
	lis 9,gi@ha
	lis 3,.LC261@ha
	la 9,gi@l(9)
	la 3,.LC261@l(3)
	lwz 0,40(9)
	mr 25,9
	li 30,0
	lis 24,.LC262@ha
	li 26,40
	mtlr 0
	li 27,40
	li 28,40
	li 29,40
	blrl
	lwz 9,84(31)
	sth 3,142(9)
.L883:
	lwz 9,84(31)
	lwz 0,4668(9)
	mr 11,9
	cmpwi 0,0,0
	bc 12,2,.L884
	lwz 0,8(1)
	cmpwi 0,0,255
	bc 4,2,.L884
	stw 30,8(1)
	la 3,.LC262@l(24)
	lwz 9,40(25)
	mtlr 9
	blrl
	lwz 11,84(31)
	add 10,30,30
	li 0,10
	addi 11,11,120
	sthx 3,11,29
	b .L889
.L884:
	lwz 0,4672(11)
	cmpwi 0,0,0
	bc 12,2,.L885
	lwz 0,12(1)
	cmpwi 0,0,255
	bc 4,2,.L885
	stw 30,12(1)
	lis 3,.LC263@ha
	lwz 9,40(25)
	la 3,.LC263@l(3)
	mtlr 9
	blrl
	lwz 11,84(31)
	add 10,30,30
	li 0,11
	addi 11,11,120
	sthx 3,11,28
	b .L889
.L885:
	lwz 0,4676(11)
	cmpwi 0,0,0
	bc 12,2,.L886
	lwz 0,16(1)
	cmpwi 0,0,255
	bc 4,2,.L886
	stw 30,16(1)
	la 3,.LC262@l(24)
	lwz 9,40(25)
	mtlr 9
	blrl
	lwz 11,84(31)
	add 10,30,30
	li 0,12
	addi 11,11,120
	sthx 3,11,27
.L889:
	lwz 9,84(31)
	addi 9,9,4704
	sthx 0,9,10
	b .L882
.L886:
	lwz 9,84(31)
	li 0,0
	addi 9,9,120
	sthx 0,9,26
.L882:
	addi 30,30,1
	addi 26,26,2
	cmpwi 0,30,4
	addi 27,27,2
	addi 28,28,2
	addi 29,29,2
	bc 4,1,.L883
	lwz 3,84(31)
	lha 0,160(3)
	cmpwi 0,0,0
	bc 12,2,.L878
	lwz 9,4624(3)
	addi 10,3,120
	addi 9,9,19
	add 9,9,9
	lhzx 11,10,9
	addi 11,11,-1
	sthx 11,10,9
.L878:
	lwz 0,68(1)
	mtlr 0
	lmw 24,32(1)
	la 1,64(1)
	blr
.Lfe41:
	.size	 set_sub_menu4_weap,.Lfe41-set_sub_menu4_weap
	.align 2
	.globl setup_force_menu
	.type	 setup_force_menu,@function
setup_force_menu:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	li 0,6
	mr 30,3
	mtctr 0
	li 31,0
	li 11,0
.L903:
	lwz 9,84(30)
	add 0,31,31
	addi 31,31,1
	addi 9,9,4480
	sthx 11,9,0
	bdnz .L903
	lis 9,powerlist@ha
	li 31,0
	la 29,powerlist@l(9)
	li 28,0
.L899:
	lwz 9,84(30)
	addi 9,9,1856
	lwzx 0,9,28
	cmpwi 0,0,1
	bc 4,2,.L898
	mr 3,30
	mr 4,31
	bl Force_Power_Available
	cmpwi 0,3,0
	bc 12,2,.L898
	lwz 10,84(30)
	lhz 9,36(29)
	addi 8,10,4480
	add 11,9,9
	addi 10,10,4492
	lhzx 0,8,11
	mulli 9,9,20
	add 0,0,0
	add 0,0,9
	sthx 31,10,0
	lwz 11,84(30)
	lhz 0,36(29)
	addi 11,11,4480
	add 0,0,0
	lhzx 9,11,0
	addi 9,9,1
	sthx 9,11,0
.L898:
	addi 31,31,1
	addi 29,29,44
	cmpwi 0,31,22
	addi 28,28,4
	bc 4,1,.L899
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe42:
	.size	 setup_force_menu,.Lfe42-setup_force_menu
	.section	".rodata"
	.align 2
.LC264:
	.string	"force/menu1"
	.section	".text"
	.align 2
	.globl set_sub_menu1
	.type	 set_sub_menu1,@function
set_sub_menu1:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 30,3
	lwz 9,84(30)
	lhz 0,4470(9)
	cmpwi 0,0,1
	bc 4,2,.L905
	lis 9,gi@ha
	lis 3,.LC264@ha
	la 29,gi@l(9)
	la 3,.LC264@l(3)
	lwz 9,40(29)
	mtlr 9
	blrl
	lwz 9,84(30)
	sth 3,142(9)
	lwz 11,84(30)
	lhz 28,4482(11)
	cmpwi 0,28,0
	bc 12,2,.L905
	li 31,0
	cmpw 0,31,28
	bc 4,0,.L909
	lis 9,powerlist+12@ha
	mr 26,29
	la 27,powerlist+12@l(9)
	li 29,40
.L911:
	lwz 9,84(30)
	add 11,31,31
	lwz 10,40(26)
	addi 31,31,1
	addi 9,9,4512
	lhzx 0,9,11
	mtlr 10
	mulli 0,0,44
	lwzx 3,27,0
	blrl
	lwz 9,84(30)
	cmpw 0,31,28
	addi 9,9,120
	sthx 3,9,29
	addi 29,29,2
	bc 12,0,.L911
.L909:
	lwz 10,84(30)
	lis 9,gi+40@ha
	lis 11,powerlist@ha
	lwz 8,gi+40@l(9)
	la 11,powerlist@l(11)
	lhz 31,4472(10)
	addi 11,11,16
	addi 10,10,4512
	mtlr 8
	add 0,31,31
	lhzx 0,10,0
	mulli 9,0,44
	lwzx 3,11,9
	blrl
	lwz 9,84(30)
	addi 0,31,20
	add 0,0,0
	addi 9,9,120
	sthx 3,9,0
.L905:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe43:
	.size	 set_sub_menu1,.Lfe43-set_sub_menu1
	.section	".rodata"
	.align 2
.LC265:
	.string	"force/menu2"
	.section	".text"
	.align 2
	.globl set_sub_menu2
	.type	 set_sub_menu2,@function
set_sub_menu2:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 30,3
	lwz 9,84(30)
	lhz 0,4470(9)
	cmpwi 0,0,2
	bc 4,2,.L913
	lis 9,gi@ha
	lis 3,.LC265@ha
	la 29,gi@l(9)
	la 3,.LC265@l(3)
	lwz 9,40(29)
	mtlr 9
	blrl
	lwz 9,84(30)
	sth 3,142(9)
	lwz 11,84(30)
	lhz 28,4484(11)
	cmpwi 0,28,0
	bc 12,2,.L913
	li 31,0
	cmpw 0,31,28
	bc 4,0,.L917
	lis 9,powerlist+12@ha
	mr 26,29
	la 27,powerlist+12@l(9)
	li 29,40
.L919:
	lwz 9,84(30)
	add 11,31,31
	lwz 10,40(26)
	addi 31,31,1
	addi 9,9,4532
	lhzx 0,9,11
	mtlr 10
	mulli 0,0,44
	lwzx 3,27,0
	blrl
	lwz 9,84(30)
	cmpw 0,31,28
	addi 9,9,120
	sthx 3,9,29
	addi 29,29,2
	bc 12,0,.L919
.L917:
	lwz 10,84(30)
	lis 9,gi+40@ha
	lis 11,powerlist@ha
	lwz 8,gi+40@l(9)
	la 11,powerlist@l(11)
	lhz 31,4472(10)
	addi 11,11,16
	addi 10,10,4532
	mtlr 8
	add 0,31,31
	lhzx 0,10,0
	mulli 9,0,44
	lwzx 3,11,9
	blrl
	lwz 9,84(30)
	addi 0,31,20
	add 0,0,0
	addi 9,9,120
	sthx 3,9,0
.L913:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe44:
	.size	 set_sub_menu2,.Lfe44-set_sub_menu2
	.section	".rodata"
	.align 2
.LC266:
	.string	"force/menu3"
	.section	".text"
	.align 2
	.globl set_sub_menu3
	.type	 set_sub_menu3,@function
set_sub_menu3:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 30,3
	lwz 9,84(30)
	lhz 0,4470(9)
	cmpwi 0,0,3
	bc 4,2,.L921
	lis 9,gi@ha
	lis 3,.LC266@ha
	la 29,gi@l(9)
	la 3,.LC266@l(3)
	lwz 9,40(29)
	mtlr 9
	blrl
	lwz 9,84(30)
	sth 3,142(9)
	lwz 11,84(30)
	lhz 28,4486(11)
	cmpwi 0,28,0
	bc 12,2,.L921
	li 31,0
	cmpw 0,31,28
	bc 4,0,.L925
	lis 9,powerlist+12@ha
	mr 26,29
	la 27,powerlist+12@l(9)
	li 29,40
.L927:
	lwz 9,84(30)
	add 11,31,31
	lwz 10,40(26)
	addi 31,31,1
	addi 9,9,4552
	lhzx 0,9,11
	mtlr 10
	mulli 0,0,44
	lwzx 3,27,0
	blrl
	lwz 9,84(30)
	cmpw 0,31,28
	addi 9,9,120
	sthx 3,9,29
	addi 29,29,2
	bc 12,0,.L927
.L925:
	lwz 10,84(30)
	lis 9,gi+40@ha
	lis 11,powerlist@ha
	lwz 8,gi+40@l(9)
	la 11,powerlist@l(11)
	lhz 31,4472(10)
	addi 11,11,16
	addi 10,10,4552
	mtlr 8
	add 0,31,31
	lhzx 0,10,0
	mulli 9,0,44
	lwzx 3,11,9
	blrl
	lwz 9,84(30)
	addi 0,31,20
	add 0,0,0
	addi 9,9,120
	sthx 3,9,0
.L921:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe45:
	.size	 set_sub_menu3,.Lfe45-set_sub_menu3
	.section	".rodata"
	.align 2
.LC267:
	.string	"force/menu4"
	.section	".text"
	.align 2
	.globl set_sub_menu4
	.type	 set_sub_menu4,@function
set_sub_menu4:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 30,3
	lwz 9,84(30)
	lhz 0,4470(9)
	cmpwi 0,0,4
	bc 4,2,.L929
	lis 9,gi@ha
	lis 3,.LC267@ha
	la 29,gi@l(9)
	la 3,.LC267@l(3)
	lwz 9,40(29)
	mtlr 9
	blrl
	lwz 9,84(30)
	sth 3,142(9)
	lwz 11,84(30)
	lhz 28,4488(11)
	cmpwi 0,28,0
	bc 12,2,.L929
	li 31,0
	cmpw 0,31,28
	bc 4,0,.L933
	lis 9,powerlist+12@ha
	mr 26,29
	la 27,powerlist+12@l(9)
	li 29,40
.L935:
	lwz 9,84(30)
	add 11,31,31
	lwz 10,40(26)
	addi 31,31,1
	addi 9,9,4572
	lhzx 0,9,11
	mtlr 10
	mulli 0,0,44
	lwzx 3,27,0
	blrl
	lwz 9,84(30)
	cmpw 0,31,28
	addi 9,9,120
	sthx 3,9,29
	addi 29,29,2
	bc 12,0,.L935
.L933:
	lwz 10,84(30)
	lis 9,gi+40@ha
	lis 11,powerlist@ha
	lwz 8,gi+40@l(9)
	la 11,powerlist@l(11)
	lhz 31,4472(10)
	addi 11,11,16
	addi 10,10,4572
	mtlr 8
	add 0,31,31
	lhzx 0,10,0
	mulli 9,0,44
	lwzx 3,11,9
	blrl
	lwz 9,84(30)
	addi 0,31,20
	add 0,0,0
	addi 9,9,120
	sthx 3,9,0
.L929:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe46:
	.size	 set_sub_menu4,.Lfe46-set_sub_menu4
	.section	".rodata"
	.align 2
.LC268:
	.string	"force/menu5"
	.section	".text"
	.align 2
	.globl set_sub_menu5
	.type	 set_sub_menu5,@function
set_sub_menu5:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 30,3
	lwz 9,84(30)
	lhz 0,4470(9)
	cmpwi 0,0,5
	bc 4,2,.L937
	lis 9,gi@ha
	lis 3,.LC268@ha
	la 29,gi@l(9)
	la 3,.LC268@l(3)
	lwz 9,40(29)
	mtlr 9
	blrl
	lwz 9,84(30)
	sth 3,142(9)
	lwz 11,84(30)
	lhz 28,4490(11)
	cmpwi 0,28,0
	bc 12,2,.L937
	li 31,0
	cmpw 0,31,28
	bc 4,0,.L941
	lis 9,powerlist+12@ha
	mr 26,29
	la 27,powerlist+12@l(9)
	li 29,40
.L943:
	lwz 9,84(30)
	add 11,31,31
	lwz 10,40(26)
	addi 31,31,1
	addi 9,9,4592
	lhzx 0,9,11
	mtlr 10
	mulli 0,0,44
	lwzx 3,27,0
	blrl
	lwz 9,84(30)
	cmpw 0,31,28
	addi 9,9,120
	sthx 3,9,29
	addi 29,29,2
	bc 12,0,.L943
.L941:
	lwz 10,84(30)
	lis 9,gi+40@ha
	lis 11,powerlist@ha
	lwz 8,gi+40@l(9)
	la 11,powerlist@l(11)
	lhz 31,4472(10)
	addi 11,11,16
	addi 10,10,4592
	mtlr 8
	add 0,31,31
	lhzx 0,10,0
	mulli 9,0,44
	lwzx 3,11,9
	blrl
	lwz 9,84(30)
	addi 0,31,20
	add 0,0,0
	addi 9,9,120
	sthx 3,9,0
.L937:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe47:
	.size	 set_sub_menu5,.Lfe47-set_sub_menu5
	.section	".rodata"
	.align 2
.LC269:
	.string	"force/menu6"
	.section	".text"
	.align 2
	.globl set_sub_menu6
	.type	 set_sub_menu6,@function
set_sub_menu6:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 30,3
	lwz 9,84(30)
	lhz 0,4470(9)
	cmpwi 0,0,6
	bc 4,2,.L945
	lis 9,gi@ha
	lis 3,.LC269@ha
	la 29,gi@l(9)
	la 3,.LC269@l(3)
	lwz 9,40(29)
	mtlr 9
	blrl
	lwz 9,84(30)
	sth 3,142(9)
	lwz 11,84(30)
	lhz 28,4492(11)
	cmpwi 0,28,0
	bc 12,2,.L945
	li 31,0
	cmpw 0,31,28
	bc 4,0,.L949
	lis 9,powerlist+12@ha
	mr 26,29
	la 27,powerlist+12@l(9)
	li 29,40
.L951:
	lwz 9,84(30)
	add 11,31,31
	lwz 10,40(26)
	addi 31,31,1
	addi 9,9,4612
	lhzx 0,9,11
	mtlr 10
	mulli 0,0,44
	lwzx 3,27,0
	blrl
	lwz 9,84(30)
	cmpw 0,31,28
	addi 9,9,120
	sthx 3,9,29
	addi 29,29,2
	bc 12,0,.L951
.L949:
	lwz 10,84(30)
	lis 9,gi+40@ha
	lis 11,powerlist@ha
	lwz 8,gi+40@l(9)
	la 11,powerlist@l(11)
	lhz 31,4472(10)
	addi 11,11,16
	addi 10,10,4612
	mtlr 8
	add 0,31,31
	lhzx 0,10,0
	mulli 9,0,44
	lwzx 3,11,9
	blrl
	lwz 9,84(30)
	addi 0,31,20
	add 0,0,0
	addi 9,9,120
	sthx 3,9,0
.L945:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe48:
	.size	 set_sub_menu6,.Lfe48-set_sub_menu6
	.comm	node_count,2,2
	.comm	path_not_time_yet,4,4
	.comm	conversation_content,7760,4
	.comm	highlighted,4,4
	.comm	yeah_you,4,4
	.comm	its_me,4,4
	.comm	holdthephone,4,4
	.comm	NoTouch,4,4
	.comm	showingit,4,4
	.comm	path_time,4,4
	.comm	print_time,4,4
	.align 2
	.globl FindPowerByName
	.type	 FindPowerByName,@function
FindPowerByName:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,powerlist@ha
	mr 29,3
	la 30,powerlist@l(9)
	li 31,0
.L10:
	lwz 3,20(30)
	cmpwi 0,3,0
	bc 12,2,.L9
	mr 4,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L9
	mr 3,31
	b .L964
.L9:
	addi 31,31,1
	addi 30,30,44
	cmpwi 0,31,22
	bc 4,1,.L10
	li 3,0
.L964:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe49:
	.size	 FindPowerByName,.Lfe49-FindPowerByName
	.align 2
	.globl GetPowerByIndex
	.type	 GetPowerByIndex,@function
GetPowerByIndex:
	mr. 3,3
	bc 12,2,.L15
	mulli 0,3,44
	lis 3,powerlist@ha
	la 3,powerlist@l(3)
	add 3,0,3
	blr
.L15:
	li 3,0
	blr
.Lfe50:
	.size	 GetPowerByIndex,.Lfe50-GetPowerByIndex
	.section	".rodata"
	.align 2
.LC274:
	.long 0x0
	.section	".text"
	.align 2
	.globl force_frame
	.type	 force_frame,@function
force_frame:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC274@ha
	lis 9,deathmatch@ha
	la 11,.LC274@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L18
	lis 9,ctf@ha
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L17
.L18:
	mr 3,31
	bl Check_Active_Powers
	b .L16
.L17:
	mr 3,31
	bl calc_subgroup_values
	mr 3,31
	bl calc_darklight_value
	mr 3,31
	bl calc_top_level_value
	mr 3,31
	bl Check_Active_Powers
	mr 3,31
	bl sort_useable_powers
.L16:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe51:
	.size	 force_frame,.Lfe51-force_frame
	.section	".rodata"
	.align 2
.LC275:
	.long 0x0
	.section	".text"
	.align 2
	.globl sort_useable_powers
	.type	 sort_useable_powers,@function
sort_useable_powers:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 27,20(1)
	stw 0,52(1)
	lis 9,.LC275@ha
	mr 31,3
	la 9,.LC275@l(9)
	li 29,1
	lfs 31,0(9)
	lis 27,0x4120
	li 28,0
	li 30,4
.L24:
	mr 3,31
	mr 4,29
	bl Force_Power_Available
	cmpwi 0,3,1
	bc 4,2,.L25
	lwz 9,84(31)
	addi 9,9,1856
	stwx 3,9,30
	lwz 11,84(31)
	addi 11,11,1984
	lfsx 0,11,30
	fcmpu 0,0,31
	bc 4,2,.L23
	stwx 27,11,30
	b .L23
.L25:
	lwz 9,84(31)
	addi 9,9,1856
	stwx 28,9,30
.L23:
	addi 29,29,1
	addi 30,30,4
	cmpwi 0,29,22
	bc 4,1,.L24
	lwz 0,52(1)
	mtlr 0
	lmw 27,20(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe52:
	.size	 sort_useable_powers,.Lfe52-sort_useable_powers
	.section	".rodata"
	.align 2
.LC276:
	.long 0x0
	.align 3
.LC277:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC278:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl calc_darklight_value
	.type	 calc_darklight_value,@function
calc_darklight_value:
	stwu 1,-16(1)
	lis 9,powerlist@ha
	lwz 11,84(3)
	li 7,0
	la 4,powerlist@l(9)
	li 10,1
	lis 9,.LC276@ha
	mr 5,11
	la 9,.LC276@l(9)
	addi 11,11,1856
	lfs 11,0(9)
	addi 6,5,1984
.L50:
	slwi 9,10,2
	lwzx 0,11,9
	mr 8,9
	cmpwi 0,0,0
	bc 12,2,.L49
	cmpwi 0,10,0
	bc 4,2,.L52
	li 9,0
	b .L53
.L52:
	mulli 0,10,44
	add 9,0,4
.L53:
	lha 0,32(9)
	lfsx 0,6,8
	cmpwi 0,0,1
	bc 4,2,.L54
	fadds 11,11,0
	b .L966
.L54:
	cmpwi 0,0,-1
	bc 4,2,.L49
	fsubs 11,11,0
.L966:
	addi 7,7,1
.L49:
	addi 0,10,1
	rlwinm 10,0,0,0xffff
	cmplwi 0,10,22
	bc 4,1,.L50
	xoris 0,7,0x8000
	lis 11,0x4330
	stw 0,12(1)
	lis 10,.LC277@ha
	stw 11,8(1)
	la 10,.LC277@l(10)
	lfd 13,0(10)
	lis 11,.LC278@ha
	lfd 0,8(1)
	la 11,.LC278@l(11)
	lfs 12,0(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,11,0
	fdivs 0,0,12
	stfs 0,1956(5)
	la 1,16(1)
	blr
.Lfe53:
	.size	 calc_darklight_value,.Lfe53-calc_darklight_value
	.section	".rodata"
	.align 3
.LC279:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC280:
	.long 0x41200000
	.align 2
.LC281:
	.long 0x0
	.section	".text"
	.align 2
	.globl calc_subgroup_values
	.type	 calc_subgroup_values,@function
calc_subgroup_values:
	stwu 1,-128(1)
	stmw 28,112(1)
	lis 9,powerlist@ha
	addi 12,1,8
	la 29,powerlist@l(9)
	mr 30,12
	lis 9,.LC279@ha
	li 10,1
	la 9,.LC279@l(9)
	li 31,1
	lfd 12,0(9)
	lis 28,0x4330
	lis 9,.LC280@ha
	la 9,.LC280@l(9)
	lfs 11,0(9)
.L63:
	lis 9,.LC281@ha
	li 6,0
	la 9,.LC281@l(9)
	addi 4,10,1
	lfs 13,0(9)
	li 9,1
.L67:
	slwi 8,9,2
	addi 5,9,1
	lwzx 0,30,8
	cmpwi 0,0,1
	bc 12,2,.L66
	mulli 0,9,44
	lwz 11,84(3)
	add 7,0,29
	addi 9,11,1856
	lwzx 0,9,8
	cmpwi 0,0,0
	bc 12,2,.L66
	lhz 0,36(7)
	addi 9,11,1984
	cmpw 0,0,10
	bc 4,2,.L66
	lfsx 0,9,8
	addi 6,6,1
	stwx 31,12,8
	fadds 13,13,0
.L66:
	rlwinm 9,5,0,0xffff
	cmplwi 0,9,22
	bc 4,1,.L67
	cmpwi 0,6,0
	bc 12,2,.L62
	xoris 0,6,0x8000
	lwz 11,84(3)
	stw 0,108(1)
	slwi 10,10,2
	stw 28,104(1)
	addi 11,11,1960
	lfd 0,104(1)
	fsub 0,0,12
	frsp 0,0
	fdivs 0,13,0
	fdivs 0,0,11
	stfsx 0,11,10
.L62:
	rlwinm 10,4,0,0xffff
	cmplwi 0,10,5
	bc 4,1,.L63
	lmw 28,112(1)
	la 1,128(1)
	blr
.Lfe54:
	.size	 calc_subgroup_values,.Lfe54-calc_subgroup_values
	.align 2
	.globl Force_constant_active
	.type	 Force_constant_active,@function
Force_constant_active:
	li 0,6
	lwz 9,84(3)
	mtctr 0
	li 3,0
	addi 9,9,2092
.L968:
	lhz 0,0(9)
	addi 9,9,2
	cmpw 0,0,4
	bclr 12,2
	addi 3,3,1
	bdnz .L968
	li 3,255
	blr
.Lfe55:
	.size	 Force_constant_active,.Lfe55-Force_constant_active
	.align 2
	.globl Force_Power_Useable
	.type	 Force_Power_Useable,@function
Force_Power_Useable:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr. 4,4
	mr 31,3
	bc 4,2,.L102
	li 30,0
	b .L103
.L102:
	mulli 0,4,44
	lis 9,powerlist@ha
	la 9,powerlist@l(9)
	add 30,0,9
.L103:
	mr 3,31
	bl Force_Power_Available
	cmpwi 0,3,0
	bc 12,2,.L104
	lwz 9,84(31)
	lfs 13,28(30)
	lfs 0,1852(9)
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,29,1
	xori 3,3,1
	b .L969
.L104:
	li 3,0
.L969:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe56:
	.size	 Force_Power_Useable,.Lfe56-Force_Power_Useable
	.section	".rodata"
	.align 2
.LC282:
	.long 0x447a0000
	.section	".text"
	.align 2
	.globl force_group_learn
	.type	 force_group_learn,@function
force_group_learn:
	mulli 0,4,44
	lis 9,powerlist@ha
	li 8,1
	la 9,powerlist@l(9)
	li 10,4
	add 6,0,9
	addi 7,9,80
	li 0,22
	mtctr 0
.L970:
	lhz 9,0(7)
	lhz 0,36(6)
	addi 7,7,44
	cmpw 0,9,0
	bc 4,2,.L124
	cmpw 0,8,4
	bc 12,2,.L124
	lwz 11,84(3)
	lis 9,.LC282@ha
	la 9,.LC282@l(9)
	addi 11,11,1984
	lfs 13,0(9)
	lfsx 0,11,10
	fadds 0,0,1
	stfsx 0,11,10
	lwz 9,84(3)
	addi 9,9,1984
	lfsx 0,9,10
	fcmpu 0,0,13
	bc 4,1,.L124
	stfsx 13,9,10
.L124:
	addi 10,10,4
	addi 8,8,1
	bdnz .L970
	blr
.Lfe57:
	.size	 force_group_learn,.Lfe57-force_group_learn
	.section	".rodata"
	.align 2
.LC283:
	.long 0x0
	.section	".text"
	.align 2
	.globl Drain_Force_Pool
	.type	 Drain_Force_Pool,@function
Drain_Force_Pool:
	lis 9,powerlist@ha
	lwz 11,84(3)
	mulli 4,4,44
	lis 10,.LC283@ha
	la 9,powerlist@l(9)
	la 10,.LC283@l(10)
	addi 9,9,28
	lfs 0,1852(11)
	lfsx 13,9,4
	lfs 12,0(10)
	fsubs 0,0,13
	stfs 0,1852(11)
	lwz 9,84(3)
	lfs 0,1852(9)
	fcmpu 0,0,12
	cror 3,2,0
	bclr 4,3
	stfs 12,1852(9)
	li 0,0
	li 10,255
	lwz 9,84(3)
	sth 0,2092(9)
	lwz 11,84(3)
	sth 0,2094(11)
	lwz 9,84(3)
	sth 0,2096(9)
	lwz 11,84(3)
	sth 0,2098(11)
	lwz 9,84(3)
	sth 0,2104(9)
	stw 10,40(3)
	blr
.Lfe58:
	.size	 Drain_Force_Pool,.Lfe58-Drain_Force_Pool
	.section	".rodata"
	.align 3
.LC284:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC285:
	.long 0x41200000
	.align 2
.LC286:
	.long 0x0
	.align 2
.LC287:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Drain_Force_Pool_Constant
	.type	 Drain_Force_Pool_Constant,@function
Drain_Force_Pool_Constant:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	cmpwi 0,4,5
	mr 31,3
	bc 12,2,.L146
	lwz 10,84(31)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,4456(10)
	fcmpu 0,0,13
	bc 12,1,.L146
	fmr 0,13
	lis 11,.LC284@ha
	lis 9,powerlist@ha
	mulli 0,4,44
	lfd 13,.LC284@l(11)
	la 9,powerlist@l(9)
	lis 11,.LC285@ha
	addi 9,9,28
	la 11,.LC285@l(11)
	fadd 0,0,13
	lfs 12,0(11)
	lis 11,.LC286@ha
	la 11,.LC286@l(11)
	frsp 0,0
	lfs 11,0(11)
	stfs 0,4456(10)
	lfsx 13,9,0
	lwz 11,84(31)
	fdivs 13,13,12
	lfs 0,1852(11)
	fsubs 0,0,13
	stfs 0,1852(11)
	lwz 9,84(31)
	lfs 0,1852(9)
	fcmpu 0,0,11
	cror 3,2,0
	bc 4,3,.L146
	stfs 11,1852(9)
	li 0,0
	li 10,255
	lwz 11,84(31)
	lis 29,gi@ha
	lis 3,.LC99@ha
	la 29,gi@l(29)
	la 3,.LC99@l(3)
	sth 0,2092(11)
	lwz 9,84(31)
	sth 0,2094(9)
	lwz 11,84(31)
	sth 0,2096(11)
	lwz 9,84(31)
	sth 0,2098(9)
	lwz 11,84(31)
	sth 0,2104(11)
	stw 10,40(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC287@ha
	lwz 0,16(29)
	lis 11,.LC287@ha
	la 9,.LC287@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC287@l(11)
	li 4,3
	mtlr 0
	lis 9,.LC286@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC286@l(9)
	lfs 3,0(9)
	blrl
.L146:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe59:
	.size	 Drain_Force_Pool_Constant,.Lfe59-Drain_Force_Pool_Constant
	.section	".rodata"
	.align 3
.LC288:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC289:
	.long 0x0
	.align 2
.LC290:
	.long 0x47800000
	.align 2
.LC291:
	.long 0x44fa0000
	.section	".text"
	.align 2
	.globl heal_effect_update
	.type	 heal_effect_update,@function
heal_effect_update:
	stwu 1,-48(1)
	mflr 0
	stw 31,44(1)
	stw 0,52(1)
	lis 9,level+4@ha
	lis 11,.LC288@ha
	lfs 0,level+4@l(9)
	mr 31,3
	lfd 13,.LC288@l(11)
	lwz 9,532(31)
	addi 9,9,1
	cmpwi 0,9,15
	stw 9,532(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	bc 12,1,.L971
	lis 9,.LC289@ha
	lfs 13,380(31)
	la 9,.LC289@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L971
	lwz 9,256(31)
	addi 3,1,24
	lfs 13,4(31)
	lfs 0,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,24(1)
	lfs 0,8(9)
	fsubs 12,12,0
	stfs 12,28(1)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,32(1)
	bl VectorLengthSquared
	lis 9,.LC290@ha
	la 9,.LC290@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L237
.L971:
	mr 3,31
	bl G_FreeEdict
	b .L234
.L237:
	lwz 9,256(31)
	addi 3,1,8
	lfs 0,4(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorNormalize
	lis 9,.LC291@ha
	addi 4,31,376
	la 9,.LC291@l(9)
	addi 3,1,8
	lfs 1,0(9)
	bl VectorScale
.L234:
	lwz 0,52(1)
	mtlr 0
	lwz 31,44(1)
	la 1,48(1)
	blr
.Lfe60:
	.size	 heal_effect_update,.Lfe60-heal_effect_update
	.section	".rodata"
	.align 2
.LC292:
	.long 0x46fffe00
	.align 3
.LC293:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC294:
	.long 0x46000000
	.align 2
.LC295:
	.long 0x45800000
	.align 2
.LC296:
	.long 0x44800000
	.align 2
.LC297:
	.long 0x44000000
	.section	".text"
	.align 2
	.globl heal_effect
	.type	 heal_effect,@function
heal_effect:
	stwu 1,-176(1)
	mflr 0
	stfd 26,128(1)
	stfd 27,136(1)
	stfd 28,144(1)
	stfd 29,152(1)
	stfd 30,160(1)
	stfd 31,168(1)
	stmw 27,108(1)
	stw 0,180(1)
	mr. 0,4
	mr 30,3
	mr 28,5
	mtctr 0
	bc 4,1,.L246
	lis 9,.LC292@ha
	lis 11,gi@ha
	lfs 30,.LC292@l(9)
	la 27,gi@l(11)
	mfctr 31
	lis 9,.LC293@ha
	lis 29,0x4330
	la 9,.LC293@l(9)
	lfd 31,0(9)
	lis 9,.LC294@ha
	la 9,.LC294@l(9)
	lfs 28,0(9)
	lis 9,.LC295@ha
	la 9,.LC295@l(9)
	lfs 29,0(9)
	lis 9,.LC296@ha
	la 9,.LC296@l(9)
	lfs 26,0(9)
	lis 9,.LC297@ha
	la 9,.LC297@l(9)
	lfs 27,0(9)
.L248:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,100(1)
	stw 29,96(1)
	lfd 0,96(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmsubs 0,0,28,29
	stfs 0,8(1)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,100(1)
	stw 29,96(1)
	lfd 0,96(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmsubs 0,0,28,29
	stfs 0,12(1)
	bl rand
	rlwinm 0,3,0,17,31
	lwz 10,48(27)
	xoris 0,0,0x8000
	addi 3,1,24
	stw 0,100(1)
	addi 4,30,4
	li 5,0
	mtlr 10
	stw 29,96(1)
	li 6,0
	addi 7,1,8
	lfd 0,96(1)
	mr 8,30
	li 9,-1
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmsubs 0,0,26,27
	stfs 0,16(1)
	blrl
	addi 3,1,36
	mr 4,30
	mr 5,28
	bl heal_effect_spawn
	addic. 31,31,-1
	bc 4,2,.L248
.L246:
	lwz 0,180(1)
	mtlr 0
	lmw 27,108(1)
	lfd 26,128(1)
	lfd 27,136(1)
	lfd 28,144(1)
	lfd 29,152(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe61:
	.size	 heal_effect,.Lfe61-heal_effect
	.section	".rodata"
	.align 2
.LC298:
	.long 0x3f800000
	.align 2
.LC299:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl airburst
	.type	 airburst,@function
airburst:
	stwu 1,-80(1)
	mflr 0
	stfd 27,40(1)
	stfd 28,48(1)
	stfd 29,56(1)
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 30,32(1)
	stw 0,84(1)
	lis 9,.LC298@ha
	fmr 29,1
	mr 30,4
	la 9,.LC298@l(9)
	fmr 30,2
	li 31,0
	lfs 27,0(9)
	lis 9,.LC299@ha
	la 9,.LC299@l(9)
	lfs 28,0(9)
	b .L257
.L259:
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 12,2,.L257
	lfs 0,0(30)
	lfs 13,4(31)
	lfs 12,4(30)
	lfs 11,8(30)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(31)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(31)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorLength
	fdivs 31,27,1
	addi 3,1,8
	fmuls 31,29,31
	fmuls 31,31,28
	bl VectorNormalize
	addi 3,1,8
	fmr 1,31
	mr 4,3
	bl VectorScale
	lfs 13,8(1)
	lfs 0,376(31)
	lfs 12,380(31)
	lfs 11,384(31)
	fadds 13,13,0
	stfs 13,376(31)
	lfs 0,12(1)
	fadds 0,0,12
	stfs 0,380(31)
	lfs 13,16(1)
	fadds 13,13,11
	stfs 13,384(31)
.L257:
	fmr 1,30
	mr 3,31
	mr 4,30
	bl findradius
	mr. 31,3
	addi 3,1,8
	bc 4,2,.L259
	lwz 0,84(1)
	mtlr 0
	lmw 30,32(1)
	lfd 27,40(1)
	lfd 28,48(1)
	lfd 29,56(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe62:
	.size	 airburst,.Lfe62-airburst
	.section	".rodata"
	.align 2
.LC300:
	.long 0x447a0000
	.align 2
.LC301:
	.long 0x40400000
	.align 3
.LC302:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl force_push_fire
	.type	 force_push_fire,@function
force_push_fire:
	stwu 1,-128(1)
	mflr 0
	stfd 31,120(1)
	stmw 27,100(1)
	stw 0,132(1)
	mr 29,3
	addi 28,1,24
	lwz 3,84(29)
	addi 27,1,40
	li 6,0
	mr 5,27
	mr 4,28
	addi 3,3,4252
	bl AngleVectors
	lwz 4,84(29)
	lis 9,.LC300@ha
	mr 3,28
	la 9,.LC300@l(9)
	lfs 0,0(9)
	lfs 31,1988(4)
	lis 9,.LC301@ha
	la 9,.LC301@l(9)
	addi 4,4,4200
	lfs 13,0(9)
	fdivs 31,31,0
	fmuls 31,31,13
	fneg 31,31
	fmr 1,31
	bl VectorScale
	lwz 9,84(29)
	mr 7,27
	lis 27,0x4330
	li 0,0
	stfs 31,4188(9)
	lis 10,0x40e0
	addi 5,1,56
	lis 9,.LC302@ha
	lwz 3,84(29)
	addi 8,1,8
	la 9,.LC302@l(9)
	addi 4,29,4
	lfd 13,0(9)
	mr 6,28
	lwz 9,508(29)
	stw 0,56(1)
	addi 9,9,-8
	stw 10,60(1)
	xoris 9,9,0x8000
	stw 9,92(1)
	stw 27,88(1)
	lfd 0,88(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	bl P_ProjectSource
	mr 5,28
	mr 3,29
	addi 4,1,8
	bl fire_airburst
	mr 3,29
	addi 4,1,8
	li 5,1
	bl PlayerNoise
	lwz 0,132(1)
	mtlr 0
	lmw 27,100(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe63:
	.size	 force_push_fire,.Lfe63-force_push_fire
	.align 2
	.globl force_saber_throw
	.type	 force_saber_throw,@function
force_saber_throw:
	blr
.Lfe64:
	.size	 force_saber_throw,.Lfe64-force_saber_throw
	.section	".rodata"
	.align 2
.LC303:
	.long 0x41200000
	.align 2
.LC304:
	.long 0x0
	.section	".text"
	.align 2
	.globl force_wall_of_light
	.type	 force_wall_of_light,@function
force_wall_of_light:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 27,20(1)
	stw 0,52(1)
	mr 30,3
	lwz 9,84(30)
	lwz 0,4316(9)
	cmpwi 0,0,0
	bc 12,2,.L423
	li 0,8
	li 10,111
	stw 0,4804(9)
	li 11,116
	b .L972
.L423:
	li 0,8
	li 10,70
	stw 0,4804(9)
	li 11,81
.L972:
	lwz 9,84(30)
	stw 10,56(30)
	stw 11,4308(9)
	lwz 10,84(30)
	lis 9,.LC303@ha
	la 9,.LC303@l(9)
	lfs 11,0(9)
	lfs 0,2016(10)
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lis 9,.LC304@ha
	fdivs 0,0,11
	la 9,.LC304@l(9)
	lfs 13,20(11)
	lfs 12,0(9)
	fcmpu 0,13,12
	fneg 31,0
	bc 12,2,.L425
	lis 9,num_players@ha
	li 29,0
	lwz 0,num_players@l(9)
	lis 27,num_players@ha
	cmpw 0,29,0
	bc 4,0,.L425
	lis 9,players@ha
	li 31,0
	la 28,players@l(9)
.L429:
	lwzx 4,31,28
	mr 3,30
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L428
	lwzx 11,31,28
	lwz 9,84(11)
	lfs 0,1952(9)
	fcmpu 0,0,31
	cror 3,2,1
	bc 4,3,.L428
	lhz 0,946(11)
	ori 0,0,2
	sth 0,946(11)
.L428:
	lwz 0,num_players@l(27)
	addi 29,29,1
	addi 31,31,4
	cmpw 0,29,0
	bc 12,0,.L429
.L425:
	lwz 0,52(1)
	mtlr 0
	lmw 27,20(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe65:
	.size	 force_wall_of_light,.Lfe65-force_wall_of_light
	.align 2
	.globl Check_Weapon
	.type	 Check_Weapon,@function
Check_Weapon:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 27,3
	mr 30,4
	mr 3,30
	lis 31,0x286b
	bl FindItem
	ori 31,31,51739
	lis 9,itemlist@ha
	mr 29,3
	lwz 11,84(27)
	la 26,itemlist@l(9)
	subf 0,26,29
	addi 11,11,740
	mullw 0,0,31
	rlwinm 28,0,0,0,29
	lwzx 9,11,28
	cmpwi 0,9,0
	li 3,0
	bc 12,2,.L973
	lis 3,.LC247@ha
	mr 4,30
	la 3,.LC247@l(3)
	bl strcmp
	cmpwi 0,3,0
	li 3,1
	bc 12,2,.L973
	lwz 3,52(29)
	bl FindItem
	subf 3,26,3
	lwz 11,84(27)
	mullw 3,3,31
	addi 9,11,740
	rlwinm 3,3,0,0,29
	lwzx 0,9,3
	cmpwi 0,0,0
	bc 4,2,.L773
	addi 9,11,1792
	li 3,0
	lwzx 0,9,28
	cmpwi 0,0,0
	bc 12,2,.L973
.L773:
	li 3,1
.L973:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe66:
	.size	 Check_Weapon,.Lfe66-Check_Weapon
	.align 2
	.globl select_menu_power
	.type	 select_menu_power,@function
select_menu_power:
	lwz 11,84(3)
	lis 10,powerlist@ha
	la 10,powerlist@l(10)
	lhz 0,4470(11)
	addi 7,11,4492
	lhz 9,4472(11)
	mulli 0,0,20
	add 9,9,9
	add 9,9,0
	lhzx 8,7,9
	mulli 0,8,44
	add 0,0,10
	stw 0,2076(11)
	lwz 9,84(3)
	sth 8,2106(9)
	blr
.Lfe67:
	.size	 select_menu_power,.Lfe67-select_menu_power
	.align 2
	.globl sound_delay
	.type	 sound_delay,@function
sound_delay:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	mr 29,3
	fmr 31,1
	mr 28,4
	bl G_Spawn
	lis 11,level+4@ha
	lis 9,sound_reinit@ha
	lfs 0,level+4@l(11)
	la 9,sound_reinit@l(9)
	li 0,1
	stw 9,436(3)
	stw 28,480(3)
	fadds 0,0,31
	stw 29,540(3)
	stfs 0,428(3)
	lwz 9,84(29)
	stw 0,4796(9)
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe68:
	.size	 sound_delay,.Lfe68-sound_delay
	.align 2
	.globl sound_reinit
	.type	 sound_reinit,@function
sound_reinit:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lwz 10,540(9)
	lwz 0,480(9)
	lwz 11,84(10)
	stw 0,4796(11)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe69:
	.size	 sound_reinit,.Lfe69-sound_reinit
	.section	".rodata"
	.align 3
.LC305:
	.long 0x3f847ae1
	.long 0x47ae147b
	.section	".text"
	.align 2
	.globl ForceAnimCD
	.type	 ForceAnimCD,@function
ForceAnimCD:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	li 0,5
	lwz 9,84(29)
	stw 0,4808(9)
	bl G_Spawn
	lis 11,level+4@ha
	lis 10,.LC305@ha
	lfs 0,level+4@l(11)
	lis 9,ForceAnim@ha
	lfd 13,.LC305@l(10)
	la 9,ForceAnim@l(9)
	stw 29,540(3)
	stw 9,436(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe70:
	.size	 ForceAnimCD,.Lfe70-ForceAnimCD
	.section	".rodata"
	.align 3
.LC306:
	.long 0x3f847ae1
	.long 0x47ae147b
	.section	".text"
	.align 2
	.globl ForceAnim
	.type	 ForceAnim,@function
ForceAnim:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 10,540(3)
	lwz 9,84(10)
	lwz 0,4808(9)
	cmpwi 0,0,0
	bc 12,1,.L957
	li 0,0
	stw 0,4804(9)
	lwz 9,540(3)
	lwz 11,84(9)
	lwz 0,4804(11)
	cmpwi 0,0,16
	bc 4,2,.L959
	bl G_FreeEdict
	b .L959
.L957:
	lis 9,level+4@ha
	lis 11,.LC306@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC306@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	lwz 11,84(10)
	lwz 9,4808(11)
	addi 9,9,-1
	stw 9,4808(11)
.L959:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe71:
	.size	 ForceAnim,.Lfe71-ForceAnim
	.section	".rodata"
	.align 3
.LC307:
	.long 0x3f847ae1
	.long 0x47ae147b
	.section	".text"
	.align 2
	.globl makelightning
	.type	 makelightning,@function
makelightning:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	li 0,3
	lwz 11,84(29)
	li 10,2
	stw 0,4812(11)
	lwz 9,84(29)
	stw 10,4796(9)
	bl G_Spawn
	lis 11,level+4@ha
	lis 10,.LC307@ha
	lfs 0,level+4@l(11)
	lis 9,l_count@ha
	lfd 13,.LC307@l(10)
	la 9,l_count@l(9)
	stw 29,540(3)
	stw 9,436(3)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe72:
	.size	 makelightning,.Lfe72-makelightning
	.section	".rodata"
	.align 3
.LC308:
	.long 0x3f847ae1
	.long 0x47ae147b
	.section	".text"
	.align 2
	.globl l_count
	.type	 l_count,@function
l_count:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 10,540(3)
	lwz 9,84(10)
	lwz 0,4812(9)
	cmpwi 0,0,0
	bc 12,1,.L962
	li 0,0
	stw 0,4796(9)
	bl G_FreeEdict
	b .L963
.L962:
	lis 9,level+4@ha
	lis 11,.LC308@ha
	lfs 0,level+4@l(9)
	li 0,2
	lfd 13,.LC308@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	lwz 10,84(10)
	lwz 9,4812(10)
	addi 9,9,-1
	stw 9,4812(10)
	lwz 11,540(3)
	lwz 9,84(11)
	stw 0,4796(9)
	lwz 11,540(3)
	lwz 10,84(11)
	lwz 9,4816(10)
	addi 9,9,-1
	stw 9,4816(10)
.L963:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe73:
	.size	 l_count,.Lfe73-l_count
	.section	".rodata"
	.align 2
.LC309:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl airburst_wind
	.type	 airburst_wind,@function
airburst_wind:
	stwu 1,-64(1)
	mflr 0
	stfd 29,40(1)
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 28,24(1)
	stw 0,68(1)
	mr 30,3
	mr 29,4
	fmr 30,1
	lwz 9,84(30)
	fmr 31,2
	li 31,0
	lwz 0,4316(9)
	cmpwi 0,0,0
	bc 12,2,.L476
	li 0,11
	li 10,111
	stw 0,4804(9)
	li 11,116
	b .L974
.L476:
	li 0,11
	li 10,70
	stw 0,4804(9)
	li 11,81
.L974:
	lwz 9,84(30)
	stw 10,56(30)
	stw 11,4308(9)
	lis 11,.LC309@ha
	lis 9,gi@ha
	la 11,.LC309@l(11)
	la 28,gi@l(9)
	lfs 29,0(11)
	b .L478
.L480:
	lwz 0,512(31)
	cmpwi 0,0,0
	bc 12,2,.L478
	lwz 0,248(31)
	cmpw 7,31,30
	cmpwi 0,0,2
	bc 4,2,.L478
	addi 4,31,4
	addi 3,30,4
	bc 12,30,.L478
	lwz 9,56(28)
	mtlr 9
	blrl
	cmpwi 0,3,0
	addi 3,1,8
	bc 12,2,.L478
	lfs 0,0(29)
	lfs 13,4(31)
	lfs 12,4(29)
	lfs 11,8(29)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(31)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(31)
	fsubs 13,13,11
	stfs 13,16(1)
	bl VectorLength
	lfs 0,16(1)
	addi 3,1,8
	fadds 0,0,29
	stfs 0,16(1)
	bl VectorNormalize
	fmr 1,30
	addi 3,1,8
	mr 4,3
	bl VectorScale
	lfs 13,8(1)
	lfs 0,376(31)
	lfs 12,380(31)
	lfs 11,384(31)
	fadds 13,13,0
	stfs 13,376(31)
	lfs 0,12(1)
	fadds 0,0,12
	stfs 0,380(31)
	lfs 13,16(1)
	fadds 13,13,11
	stfs 13,384(31)
.L478:
	fmr 1,31
	mr 3,31
	mr 4,29
	bl findradius
	mr. 31,3
	bc 4,2,.L480
	lwz 0,68(1)
	mtlr 0
	lmw 28,24(1)
	lfd 29,40(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe74:
	.size	 airburst_wind,.Lfe74-airburst_wind
	.align 2
	.globl Inferno_Effect_Touch
	.type	 Inferno_Effect_Touch,@function
Inferno_Effect_Touch:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 31,3
	mr 28,5
	lwz 10,256(31)
	mr 3,4
	cmpw 0,3,10
	bc 12,2,.L713
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L715
	lwz 9,516(31)
	li 0,4
	li 11,0
	mr 5,10
	stw 0,8(1)
	mr 8,28
	stw 11,12(1)
	mr 4,31
	addi 6,31,376
	addi 7,31,4
	li 10,1
	bl T_Damage
	b .L716
.L715:
	lis 9,gi@ha
	li 3,3
	la 30,gi@l(9)
	addi 29,31,4
	lwz 9,100(30)
	mr 27,29
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,2
	mtlr 9
	blrl
	lwz 9,120(30)
	mr 3,29
	mtlr 9
	blrl
	cmpwi 0,28,0
	bc 4,2,.L717
	lwz 0,124(30)
	lis 3,vec3_origin@ha
	la 3,vec3_origin@l(3)
	mtlr 0
	blrl
	b .L718
.L717:
	lwz 0,124(30)
	mr 3,28
	mtlr 0
	blrl
.L718:
	lis 9,gi+88@ha
	mr 3,27
	lwz 0,gi+88@l(9)
	li 4,2
	mtlr 0
	blrl
.L716:
	mr 3,31
	bl G_FreeEdict
.L713:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe75:
	.size	 Inferno_Effect_Touch,.Lfe75-Inferno_Effect_Touch
	.align 2
	.globl Inferno_Effect
	.type	 Inferno_Effect,@function
Inferno_Effect:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	li 29,0
	mr 28,3
	addi 4,1,8
	stw 29,12(1)
	stw 29,8(1)
	stw 29,16(1)
	bl Inferno_Effect_Spawn
	lis 0,0x42b4
	addi 4,1,8
	stw 29,8(1)
	stw 0,12(1)
	mr 3,28
	bl Inferno_Effect_Spawn
	lis 0,0x4334
	mr 3,28
	stw 29,8(1)
	stw 0,12(1)
	addi 4,1,8
	bl Inferno_Effect_Spawn
	lis 0,0x4387
	stw 29,8(1)
	mr 3,28
	stw 0,12(1)
	addi 4,1,8
	bl Inferno_Effect_Spawn
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe76:
	.size	 Inferno_Effect,.Lfe76-Inferno_Effect
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
