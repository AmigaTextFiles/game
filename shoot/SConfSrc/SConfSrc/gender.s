	.file	"gender.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"male"
	.align 2
.LC1:
	.string	"female"
	.align 2
.LC2:
	.string	"cyborg"
	.align 2
.LC3:
	.string	"crakhor"
	.section	".text"
	.align 2
	.globl GetModelGenderFromMap
	.type	 GetModelGenderFromMap,@function
GetModelGenderFromMap:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	lbz 0,0(29)
	xori 9,0,109
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,77
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L14
	lis 4,.LC0@ha
	la 4,.LC0@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L14
	li 3,1
	b .L28
.L14:
	lbz 0,0(29)
	xori 9,0,102
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,70
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L16
	lis 4,.LC1@ha
	mr 3,29
	la 4,.LC1@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L30
.L16:
	lbz 0,0(29)
	xori 9,0,99
	subfic 11,9,0
	adde 9,11,9
	xori 0,0,67
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 12,2,.L15
	lis 4,.LC2@ha
	mr 3,29
	la 4,.LC2@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	li 3,1
	bc 12,2,.L28
	lis 4,.LC3@ha
	mr 3,29
	la 4,.LC3@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L15
.L30:
	li 3,2
	b .L28
.L29:
	lwz 9,ModelGenderMap@l(28)
	lwzx 11,30,9
	lwz 3,4(11)
	b .L28
.L15:
	lis 9,ModelGenderMap@ha
	lis 28,ModelGenderMap@ha
	lwz 9,ModelGenderMap@l(9)
	cmpwi 0,9,0
	bc 12,2,.L22
	li 0,0
	slwi 30,0,2
	lwzx 9,30,9
	cmpwi 0,9,0
	bc 12,2,.L22
	mr 31,30
.L25:
	lwz 11,ModelGenderMap@l(28)
	mr 3,29
	lwzx 9,31,11
	lwz 4,0(9)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L29
	addi 31,31,4
	lwz 9,ModelGenderMap@l(28)
	mr 30,31
	lwzx 0,30,9
	cmpwi 0,0,0
	bc 4,2,.L25
.L22:
	li 3,0
.L28:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 GetModelGenderFromMap,.Lfe1-GetModelGenderFromMap
	.section	".rodata"
	.align 2
.LC4:
	.string	"%s%s"
	.align 2
.LC5:
	.string	"r"
	.align 2
.LC6:
	.string	"ModelGender Error: Couldn't open file %s, check config.txt file settings\n"
	.align 2
.LC7:
	.string	"ModelGender Error: Couldn't understand line %d in %s:\n"
	.align 2
.LC8:
	.string	"--> %s\n"
	.section	".text"
	.align 2
	.globl ReadModelGenders
	.type	 ReadModelGenders,@function
ReadModelGenders:
	stwu 1,-400(1)
	mflr 0
	stmw 20,352(1)
	stw 0,404(1)
	li 11,60
	mr 24,3
	mtctr 11
	addi 31,1,264
	lis 20,ModelGenderMap@ha
	li 0,0
	addi 9,1,323
.L64:
	stb 0,0(9)
	addi 9,9,-1
	bdnz .L64
	cmpwi 0,24,0
	li 27,0
	bc 4,2,.L44
	lis 9,ModelGenderMap@ha
	li 3,0
	stw 24,ModelGenderMap@l(9)
	b .L63
.L44:
	lis 4,.LC4@ha
	lis 5,ModelGenDir@ha
	la 4,.LC4@l(4)
	la 5,ModelGenDir@l(5)
	mr 6,24
	mr 3,31
	crxor 6,6,6
	bl sprintf
	lis 4,.LC5@ha
	mr 3,31
	la 4,.LC5@l(4)
	bl fopen
	mr. 30,3
	bc 4,2,.L46
	lis 9,gi+4@ha
	lis 3,.LC6@ha
	lwz 0,gi+4@l(9)
	la 3,.LC6@l(3)
	mr 4,31
	lis 9,ModelGenderMap@ha
	mtlr 0
	stw 30,ModelGenderMap@l(9)
	crxor 6,6,6
	blrl
	li 3,0
	b .L63
.L48:
	lbz 0,8(1)
	cmpwi 0,0,35
	bc 12,2,.L46
	addic 9,0,-1
	subfe 9,9,9
	addi 0,27,1
	andc 0,0,9
	and 9,27,9
	or 27,9,0
.L46:
	addi 3,1,8
	li 4,256
	mr 5,30
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L48
	addi 3,27,1
	lis 29,ModelGenderMap@ha
	slwi 3,3,2
	li 27,0
	bl malloc
	li 26,0
	li 25,0
	stw 3,ModelGenderMap@l(29)
	li 4,0
	li 5,0
	mr 3,30
	lis 21,.LC7@ha
	bl fseek
	lis 22,.LC8@ha
	lis 9,gi@ha
	la 23,gi@l(9)
	b .L52
.L54:
	lbz 0,8(1)
	addi 27,27,1
	cmpwi 0,0,35
	bc 12,2,.L52
	addi 3,1,8
	li 29,0
	bl strlen
	addi 31,1,8
	addi 3,3,-1
	stbx 29,31,3
	lbz 0,8(1)
	cmpwi 0,0,0
	bc 12,2,.L52
	mr 3,31
	li 4,58
	bl strchr
	mr. 3,3
	bc 4,2,.L57
	lwz 9,4(23)
	la 3,.LC7@l(21)
	mr 4,27
	mr 5,24
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,4(23)
	mr 4,31
	la 3,.LC8@l(22)
	mtlr 9
	crxor 6,6,6
	blrl
	b .L52
.L57:
	addi 28,3,1
	stb 29,0(3)
	addi 26,26,1
	li 3,8
	bl malloc
	mr 29,3
	mr 3,28
	bl ConvertGenderSpec
	mr 0,3
	srawi 11,0,31
	mr 3,31
	xor 9,11,0
	subf 9,9,11
	srawi 9,9,31
	addi 11,9,1
	and 0,0,9
	or 0,0,11
	stw 0,4(29)
	bl strdup
	lwz 9,ModelGenderMap@l(20)
	stw 3,0(29)
	stwx 29,25,9
	addi 25,25,4
.L52:
	addi 3,1,8
	li 4,256
	mr 5,30
	bl fgets
	mr. 31,3
	bc 4,2,.L54
	mr 3,30
	bl fclose
	cmpwi 0,26,0
	bc 4,2,.L61
	lis 9,ModelGenderMap@ha
	stw 26,ModelGenderMap@l(9)
	b .L62
.L61:
	lis 9,ModelGenderMap@ha
	slwi 10,26,2
	lwz 11,ModelGenderMap@l(9)
	stwx 31,10,11
.L62:
	li 3,1
.L63:
	lwz 0,404(1)
	mtlr 0
	lmw 20,352(1)
	la 1,400(1)
	blr
.Lfe2:
	.size	 ReadModelGenders,.Lfe2-ReadModelGenders
	.section	".rodata"
	.align 2
.LC9:
	.string	"his"
	.align 2
.LC10:
	.string	"her"
	.align 2
.LC11:
	.string	"its"
	.align 2
.LC12:
	.string	"him"
	.align 2
.LC13:
	.string	"it"
	.align 2
.LC14:
	.string	"himself"
	.align 2
.LC15:
	.string	"herself"
	.align 2
.LC16:
	.string	"itself"
	.align 2
.LC17:
	.string	"he"
	.align 2
.LC18:
	.string	"she"
	.align 2
.LC19:
	.string	"boy"
	.align 2
.LC20:
	.string	"girl"
	.align 2
.LC21:
	.string	"thing"
	.align 2
.LC22:
	.string	"man"
	.align 2
.LC23:
	.string	"woman"
	.align 2
.LC24:
	.string	"neuter"
	.align 2
.LC25:
	.string	"unknown"
	.align 2
.LC26:
	.string	"sex"
	.align 2
.LC27:
	.string	"skin"
	.section	".text"
	.align 2
	.globl UserSetPlayerGender
	.type	 UserSetPlayerGender,@function
UserSetPlayerGender:
	stwu 1,-1056(1)
	mflr 0
	stmw 29,1044(1)
	stw 0,1060(1)
	mr 29,3
	lwz 3,84(29)
	cmpwi 0,3,0
	bc 4,2,.L120
	li 3,0
	b .L141
.L120:
	lis 4,.LC26@ha
	addi 3,3,188
	la 4,.LC26@l(4)
	bl Info_ValueForKey
	mr 4,3
	addi 3,1,8
	bl strcpy
	lbz 11,8(1)
	cmpwi 0,11,42
	bc 4,2,.L121
	li 30,4
	b .L122
.L121:
	xori 9,11,77
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,109
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 12,2,.L124
	li 30,1
	b .L122
.L124:
	xori 9,11,70
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,102
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 12,2,.L126
	li 30,2
	b .L122
.L126:
	xori 9,11,110
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,78
	subfic 10,0,0
	adde 0,10,0
	or 0,0,9
	neg 0,0
	rlwinm 30,0,0,30,31
.L122:
	subfic 10,30,0
	adde 0,10,30
	xori 9,30,4
	subfic 11,9,0
	adde 9,11,9
	lwz 3,84(29)
	or 9,9,0
	lis 4,.LC27@ha
	addic 9,9,-1
	subfe 9,9,9
	la 4,.LC27@l(4)
	addi 0,9,1
	addi 3,3,188
	and 9,30,9
	or 30,9,0
	bl Info_ValueForKey
	addi 31,1,8
	mr 4,3
	mr 3,31
	bl strcpy
	mr 3,31
	bl strlen
.L134:
	addic. 3,3,-1
	bc 12,0,.L137
	lbzx 0,31,3
	cmpwi 0,0,47
	bc 4,2,.L134
	li 0,0
	stbx 0,31,3
.L137:
	addi 3,1,8
	bl GetModelGenderFromMap
	mr. 11,3
	bc 12,2,.L139
	xor 9,11,30
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,3
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 4,2,.L139
	lwz 9,84(29)
	li 3,0
	stw 11,3452(9)
	b .L141
.L139:
	lwz 9,84(29)
	mr 3,30
	stw 30,3452(9)
.L141:
	lwz 0,1060(1)
	mtlr 0
	lmw 29,1044(1)
	la 1,1056(1)
	blr
.Lfe3:
	.size	 UserSetPlayerGender,.Lfe3-UserSetPlayerGender
	.section	".rodata"
	.align 2
.LC28:
	.string	"Use \"cmd gender me\" to find out your\n"
	.align 2
.LC29:
	.string	"gender according to this mod.\n\n"
	.align 2
.LC30:
	.string	"Use \"set sex VALUE u\" to specify\n"
	.align 2
.LC31:
	.string	"your gender, where VALUE is m (male),\n"
	.align 2
.LC32:
	.string	"f (female), or n (neuter).  Put this\n"
	.align 2
.LC33:
	.string	"in your config.cfg or autoexec.cfg\n"
	.align 2
.LC34:
	.string	"*** %s ***\n"
	.align 2
.LC35:
	.string	"GenderMod Support"
	.align 2
.LC36:
	.string	"ModelGen.dat"
	.align 2
.LC37:
	.string	"GenderMod loaded.\n"
	.align 2
.LC38:
	.string	"help"
	.align 2
.LC39:
	.string	"me"
	.align 2
.LC40:
	.string	"Your gender is recorded as '%s'.\n"
	.align 2
.LC41:
	.string	"players"
	.align 2
.LC42:
	.string	"%s: (%d) %s\n"
	.align 2
.LC43:
	.long 0x3f800000
	.align 3
.LC44:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_Gender_f
	.type	 Cmd_Gender_f,@function
Cmd_Gender_f:
	stwu 1,-80(1)
	mflr 0
	stmw 19,28(1)
	stw 0,84(1)
	lis 9,gi@ha
	mr 30,3
	la 29,gi@l(9)
	li 3,1
	lwz 9,160(29)
	lis 19,gi@ha
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC38@ha
	la 4,.LC38@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L148
	lwz 9,8(29)
	lis 5,.LC28@ha
	mr 3,30
	la 5,.LC28@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC29@ha
	mr 3,30
	la 5,.LC29@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC30@ha
	mr 3,30
	la 5,.LC30@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC31@ha
	mr 3,30
	la 5,.LC31@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC32@ha
	mr 3,30
	la 5,.LC32@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC33@ha
	mr 3,30
	la 5,.LC33@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L150
.L148:
	lis 4,.LC39@ha
	mr 3,31
	la 4,.LC39@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L151
	lwz 9,84(30)
	cmpwi 0,9,0
	bc 12,2,.L150
	lwz 0,3452(9)
	cmpwi 0,0,1
	bc 4,2,.L153
	lis 9,.LC0@ha
	la 6,.LC0@l(9)
	b .L154
.L153:
	cmpwi 0,0,2
	bc 4,2,.L156
	lis 9,.LC1@ha
	la 6,.LC1@l(9)
	b .L154
.L156:
	cmpwi 0,0,3
	bc 4,2,.L158
	lis 9,.LC24@ha
	la 6,.LC24@l(9)
	b .L154
.L158:
	lis 9,.LC25@ha
	la 6,.LC25@l(9)
.L154:
	lwz 0,8(29)
	lis 5,.LC40@ha
	mr 3,30
	la 5,.LC40@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L150
.L151:
	lis 4,.LC41@ha
	mr 3,31
	la 4,.LC41@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L161
	lis 9,maxclients@ha
	lis 10,.LC43@ha
	lwz 11,maxclients@l(9)
	la 10,.LC43@l(10)
	li 25,1
	lfs 13,0(10)
	lis 20,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L150
	lis 21,g_edicts@ha
	lis 22,0x4330
	li 26,892
	lis 23,.LC0@ha
	lis 24,.LC1@ha
.L165:
	lwz 0,g_edicts@l(21)
	add 31,0,26
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L164
	lwz 6,84(31)
	cmpwi 0,6,0
	bc 12,2,.L164
	lwz 3,3452(6)
	la 27,gi@l(19)
	addi 28,6,700
	cmpwi 0,3,0
	bc 4,2,.L184
	mr 3,31
	bl UserSetPlayerGender
.L184:
	mr 29,3
	lwz 9,84(31)
	cmpwi 0,9,0
	li 3,0
	bc 12,2,.L172
	lwz 3,3452(9)
	cmpwi 0,3,0
	bc 4,2,.L172
	mr 3,31
	bl UserSetPlayerGender
.L172:
	cmpwi 0,3,1
	bc 4,2,.L174
	la 8,.LC0@l(23)
	b .L175
.L174:
	cmpwi 0,3,2
	bc 4,2,.L177
	la 8,.LC1@l(24)
	b .L175
.L177:
	cmpwi 0,3,3
	bc 4,2,.L179
	lis 9,.LC24@ha
	la 8,.LC24@l(9)
	b .L175
.L179:
	lis 9,.LC25@ha
	la 8,.LC25@l(9)
.L175:
	lwz 0,8(27)
	lis 5,.LC42@ha
	mr 6,28
	la 5,.LC42@l(5)
	mr 7,29
	mr 3,30
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
.L164:
	addi 25,25,1
	lwz 11,maxclients@l(20)
	xoris 0,25,0x8000
	lis 10,.LC44@ha
	stw 0,20(1)
	la 10,.LC44@l(10)
	addi 26,26,892
	stw 22,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L165
	b .L150
.L161:
	lwz 9,8(29)
	lis 5,.LC28@ha
	mr 3,30
	la 5,.LC28@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC29@ha
	mr 3,30
	la 5,.LC29@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC30@ha
	mr 3,30
	la 5,.LC30@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC31@ha
	mr 3,30
	la 5,.LC31@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC32@ha
	mr 3,30
	la 5,.LC32@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC33@ha
	mr 3,30
	la 5,.LC33@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
.L150:
	lwz 0,84(1)
	mtlr 0
	lmw 19,28(1)
	la 1,80(1)
	blr
.Lfe4:
	.size	 Cmd_Gender_f,.Lfe4-Cmd_Gender_f
	.comm	highscore,1080,4
	.comm	gamescore,540,4
	.align 2
	.globl GenderModInitGame
	.type	 GenderModInitGame,@function
GenderModInitGame:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 29,gi@ha
	lis 3,.LC34@ha
	la 29,gi@l(29)
	lis 4,.LC35@ha
	lwz 9,4(29)
	la 3,.LC34@l(3)
	la 4,.LC35@l(4)
	mtlr 9
	crxor 6,6,6
	blrl
	lis 3,.LC36@ha
	la 3,.LC36@l(3)
	bl ReadModelGenders
	lwz 0,4(29)
	lis 3,.LC37@ha
	la 3,.LC37@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 GenderModInitGame,.Lfe5-GenderModInitGame
	.align 2
	.globl GetPlayerGender
	.type	 GetPlayerGender,@function
GetPlayerGender:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lwz 3,84(9)
	cmpwi 0,3,0
	bc 4,2,.L143
	li 3,0
	b .L185
.L143:
	lwz 3,3452(3)
	cmpwi 0,3,0
	bc 4,2,.L185
	mr 3,9
	bl UserSetPlayerGender
.L185:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 GetPlayerGender,.Lfe6-GetPlayerGender
	.align 2
	.globl ConvertGenderSpec
	.type	 ConvertGenderSpec,@function
ConvertGenderSpec:
	lbz 3,0(3)
	cmpwi 0,3,42
	bc 4,2,.L111
	li 3,4
	blr
.L111:
	xori 9,3,77
	subfic 0,9,0
	adde 9,0,9
	xori 0,3,109
	subfic 11,0,0
	adde 0,11,0
	or. 11,9,0
	bc 12,2,.L113
	li 3,1
	blr
.L113:
	xori 9,3,70
	subfic 0,9,0
	adde 9,0,9
	xori 0,3,102
	subfic 11,0,0
	adde 0,11,0
	or. 11,9,0
	bc 4,2,.L115
	xori 0,3,110
	subfic 9,0,0
	adde 0,9,0
	xori 3,3,78
	subfic 11,3,0
	adde 3,11,3
	or 3,3,0
	neg 3,3
	rlwinm 3,3,0,30,31
	blr
.L115:
	li 3,2
	blr
.Lfe7:
	.size	 ConvertGenderSpec,.Lfe7-ConvertGenderSpec
	.align 2
	.globl GenderToName
	.type	 GenderToName,@function
GenderToName:
	cmpwi 0,3,1
	bc 4,2,.L104
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	blr
.L104:
	cmpwi 0,3,2
	bc 4,2,.L106
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	blr
.L106:
	cmpwi 0,3,3
	bc 12,2,.L108
	lis 3,.LC25@ha
	la 3,.LC25@l(3)
	blr
.L108:
	lis 3,.LC24@ha
	la 3,.LC24@l(3)
	blr
.Lfe8:
	.size	 GenderToName,.Lfe8-GenderToName
	.align 2
	.globl GenderToSheHe
	.type	 GenderToSheHe,@function
GenderToSheHe:
	cmpwi 0,3,1
	bc 4,2,.L87
.L189:
	lis 3,.LC17@ha
	la 3,.LC17@l(3)
	blr
.L87:
	cmpwi 0,3,2
	bc 4,2,.L89
	lis 3,.LC18@ha
	la 3,.LC18@l(3)
	blr
.L89:
	cmpwi 0,3,3
	bc 4,2,.L189
	lis 3,.LC13@ha
	la 3,.LC13@l(3)
	blr
.Lfe9:
	.size	 GenderToSheHe,.Lfe9-GenderToSheHe
	.align 2
	.globl GenderToHimHer
	.type	 GenderToHimHer,@function
GenderToHimHer:
	cmpwi 0,3,1
	bc 4,2,.L73
.L191:
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	blr
.L73:
	cmpwi 0,3,2
	bc 4,2,.L75
	lis 3,.LC10@ha
	la 3,.LC10@l(3)
	blr
.L75:
	cmpwi 0,3,3
	bc 4,2,.L191
	lis 3,.LC13@ha
	la 3,.LC13@l(3)
	blr
.Lfe10:
	.size	 GenderToHimHer,.Lfe10-GenderToHimHer
	.align 2
	.globl GenderToHisHer
	.type	 GenderToHisHer,@function
GenderToHisHer:
	cmpwi 0,3,1
	bc 4,2,.L66
.L193:
	lis 3,.LC9@ha
	la 3,.LC9@l(3)
	blr
.L66:
	cmpwi 0,3,2
	bc 4,2,.L68
	lis 3,.LC10@ha
	la 3,.LC10@l(3)
	blr
.L68:
	cmpwi 0,3,3
	bc 4,2,.L193
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	blr
.Lfe11:
	.size	 GenderToHisHer,.Lfe11-GenderToHisHer
	.align 2
	.globl GenderToHimselfHerself
	.type	 GenderToHimselfHerself,@function
GenderToHimselfHerself:
	cmpwi 0,3,1
	bc 4,2,.L80
.L195:
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	blr
.L80:
	cmpwi 0,3,2
	bc 4,2,.L82
	lis 3,.LC15@ha
	la 3,.LC15@l(3)
	blr
.L82:
	cmpwi 0,3,3
	bc 4,2,.L195
	lis 3,.LC16@ha
	la 3,.LC16@l(3)
	blr
.Lfe12:
	.size	 GenderToHimselfHerself,.Lfe12-GenderToHimselfHerself
	.align 2
	.globl GenderToBoyGirl
	.type	 GenderToBoyGirl,@function
GenderToBoyGirl:
	cmpwi 0,3,1
	bc 4,2,.L94
	lis 3,.LC19@ha
	la 3,.LC19@l(3)
	blr
.L94:
	cmpwi 0,3,2
	bc 12,2,.L96
	lis 3,.LC21@ha
	la 3,.LC21@l(3)
	blr
.L96:
	lis 3,.LC20@ha
	la 3,.LC20@l(3)
	blr
.Lfe13:
	.size	 GenderToBoyGirl,.Lfe13-GenderToBoyGirl
	.align 2
	.globl GenderToManWoman
	.type	 GenderToManWoman,@function
GenderToManWoman:
	cmpwi 0,3,1
	bc 4,2,.L99
	lis 3,.LC22@ha
	la 3,.LC22@l(3)
	blr
.L99:
	cmpwi 0,3,2
	bc 12,2,.L101
	lis 3,.LC21@ha
	la 3,.LC21@l(3)
	blr
.L101:
	lis 3,.LC23@ha
	la 3,.LC23@l(3)
	blr
.Lfe14:
	.size	 GenderToManWoman,.Lfe14-GenderToManWoman
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
	.comm	ModelGenderMap,4,4
	.align 2
	.globl MakeModelGenderEntry
	.type	 MakeModelGenderEntry,@function
MakeModelGenderEntry:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 27,3
	mr 28,4
	li 3,8
	bl malloc
	mr 29,3
	mr 3,28
	bl ConvertGenderSpec
	mr 0,3
	srawi 11,0,31
	mr 3,27
	xor 9,11,0
	subf 9,9,11
	srawi 9,9,31
	addi 11,9,1
	and 0,0,9
	or 0,0,11
	stw 0,4(29)
	bl strdup
	stw 3,0(29)
	mr 3,29
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 MakeModelGenderEntry,.Lfe15-MakeModelGenderEntry
	.align 2
	.globl DefaultModelGender
	.type	 DefaultModelGender,@function
DefaultModelGender:
	lbz 3,0(3)
	xori 9,3,77
	subfic 0,9,0
	adde 9,0,9
	xori 0,3,109
	subfic 11,0,0
	adde 0,11,0
	or. 11,9,0
	bc 4,2,.L9
	xori 0,3,102
	subfic 9,0,0
	adde 0,9,0
	xori 3,3,70
	subfic 11,3,0
	adde 3,11,3
	or 3,3,0
	neg 3,3
	srawi 3,3,31
	addi 0,3,1
	rlwinm 3,3,0,30,30
	or 3,3,0
	blr
.L9:
	li 3,1
	blr
.Lfe16:
	.size	 DefaultModelGender,.Lfe16-DefaultModelGender
	.align 2
	.globl TrimSkinToModel
	.type	 TrimSkinToModel,@function
TrimSkinToModel:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl strlen
.L34:
	addic. 3,3,-1
	bc 12,0,.L33
	lbzx 0,31,3
	cmpwi 0,0,47
	bc 4,2,.L34
	li 0,0
	stbx 0,31,3
.L33:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe17:
	.size	 TrimSkinToModel,.Lfe17-TrimSkinToModel
	.align 2
	.globl GenderModUsage
	.type	 GenderModUsage,@function
GenderModUsage:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 28,3
	la 29,gi@l(29)
	lis 5,.LC28@ha
	lwz 9,8(29)
	la 5,.LC28@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC29@ha
	mr 3,28
	la 5,.LC29@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC30@ha
	mr 3,28
	la 5,.LC30@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC31@ha
	mr 3,28
	la 5,.LC31@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(29)
	lis 5,.LC32@ha
	mr 3,28
	la 5,.LC32@l(5)
	li 4,1
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(29)
	lis 5,.LC33@ha
	mr 3,28
	la 5,.LC33@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 GenderModUsage,.Lfe18-GenderModUsage
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
