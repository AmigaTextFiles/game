	.file	"user.cpp"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"0"
	.align 2
.LC1:
	.string	"\\/:*?\"<>|"
	.align 2
.LC2:
	.string	"%c"
	.align 2
.LC3:
	.string	".kots"
	.section	".text"
	.align 2
	.globl GetUserPath__5CUserPCcT1Pc
	.type	 GetUserPath__5CUserPCcT1Pc,@function
GetUserPath__5CUserPCcT1Pc:
	stwu 1,-832(1)
	mflr 0
	stmw 19,780(1)
	stw 0,836(1)
	mr 28,4
	mr 19,3
	addi 29,1,264
	mr 21,5
	addi 3,1,8
	bl strcpy
	mr 24,29
	mr 4,28
	mr 3,29
	bl strcpy
	addi 3,1,8
	bl strlen
	addic. 28,3,-1
	bc 12,0,.L9
	addi 0,1,9
	addi 27,1,8
	add 29,0,28
	mr 30,24
	li 25,0
	lis 26,.LC0@ha
	mr 31,29
.L11:
	lbz 0,-1(29)
	cmpwi 0,0,95
	bc 4,2,.L10
	mr 4,31
	mr 3,30
	bl strcpy
	la 4,.LC0@l(26)
	stb 25,0(29)
	mr 3,27
	bl strcat
	mr 3,27
	mr 4,30
	bl strcat
.L10:
	addic. 28,28,-1
	addi 29,29,-1
	addi 31,31,-1
	bc 4,0,.L11
.L9:
	lis 9,.LC1@ha
	mr 26,24
	la 20,.LC1@l(9)
	li 30,0
	addi 31,1,8
	li 22,95
	li 23,0
	addi 27,1,520
	lis 24,.LC2@ha
.L17:
	addi 25,30,1
	b .L18
.L20:
	subf 28,31,3
	addi 29,28,1
	mr 3,26
	stbx 22,31,28
	add 4,31,29
	bl strcpy
	addi 5,30,49
	la 4,.LC2@l(24)
	stbx 23,31,29
	mr 3,27
	crxor 6,6,6
	bl sprintf
	mr 4,27
	mr 3,31
	bl strcat
	mr 3,31
	mr 4,26
	bl strcat
.L18:
	lbzx 4,20,30
	addi 3,1,8
	bl strchr
	mr. 3,3
	bc 4,2,.L20
	mr 30,25
	cmpwi 0,30,8
	bc 4,1,.L17
	mr 4,19
	mr 3,21
	bl strcpy
	addi 4,1,8
	mr 3,21
	bl strcat
	lis 4,.LC3@ha
	mr 3,21
	la 4,.LC3@l(4)
	bl strcat
	mr 3,21
	lwz 0,836(1)
	mtlr 0
	lmw 19,780(1)
	la 1,832(1)
	blr
.Lfe1:
	.size	 GetUserPath__5CUserPCcT1Pc,.Lfe1-GetUserPath__5CUserPCcT1Pc
	.align 2
	.globl SetAllMax__5CUser
	.type	 SetAllMax__5CUser,@function
SetAllMax__5CUser:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,5
	bc 4,1,.L37
	li 10,4
	b .L38
.L37:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,3
	bc 4,1,.L39
	li 10,3
	b .L38
.L39:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,2
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	nor 9,0,0
	rlwinm 0,0,0,31,31
	rlwinm 9,9,0,30,30
	or 10,0,9
.L38:
	lwz 0,38(31)
	cmpwi 0,0,1
	bc 4,1,.L43
	li 0,1
	stw 0,38(31)
.L43:
	lwz 0,38(31)
	cmpwi 0,0,0
	bc 4,0,.L45
	li 0,0
	stw 0,38(31)
.L45:
	lwz 0,42(31)
	cmpwi 0,0,1
	bc 4,1,.L46
	li 0,1
	stw 0,42(31)
.L46:
	lwz 0,42(31)
	cmpwi 0,0,0
	bc 4,0,.L48
	li 0,0
	stw 0,42(31)
.L48:
	lwz 0,46(31)
	cmpwi 0,0,1
	bc 4,1,.L49
	li 0,1
	stw 0,46(31)
.L49:
	lwz 0,46(31)
	cmpwi 0,0,0
	bc 4,0,.L51
	li 0,0
	stw 0,46(31)
.L51:
	lwz 0,50(31)
	cmpwi 0,0,1
	bc 4,1,.L52
	li 0,1
	stw 0,50(31)
.L52:
	lwz 0,50(31)
	cmpwi 0,0,0
	bc 4,0,.L54
	li 0,0
	stw 0,50(31)
.L54:
	lwz 0,54(31)
	cmpwi 0,0,1
	bc 4,1,.L55
	li 0,1
	stw 0,54(31)
.L55:
	lwz 0,54(31)
	cmpwi 0,0,0
	bc 4,0,.L57
	li 0,0
	stw 0,54(31)
.L57:
	lwz 0,58(31)
	li 9,1
	cmpwi 0,0,1
	bc 4,1,.L58
	stw 9,58(31)
.L58:
	lwz 0,58(31)
	cmpwi 0,0,0
	bc 4,0,.L60
	li 0,0
	stw 0,58(31)
.L60:
	lwz 0,62(31)
	cmpwi 0,0,1
	bc 4,1,.L61
	stw 9,62(31)
.L61:
	lwz 0,62(31)
	cmpwi 0,0,0
	bc 4,0,.L63
	li 0,0
	stw 0,62(31)
.L63:
	lwz 0,66(31)
	cmpwi 0,0,1
	bc 4,1,.L64
	stw 9,66(31)
.L64:
	lwz 0,66(31)
	cmpwi 0,0,0
	bc 4,0,.L66
	li 0,0
	stw 0,66(31)
.L66:
	lwz 0,70(31)
	cmpwi 0,0,1
	bc 4,1,.L67
	stw 9,70(31)
.L67:
	lwz 0,70(31)
	cmpwi 0,0,0
	bc 4,0,.L69
	li 0,0
	stw 0,70(31)
.L69:
	lwz 0,74(31)
	cmpwi 0,0,1
	bc 4,1,.L70
	stw 9,74(31)
.L70:
	lwz 0,74(31)
	cmpwi 0,0,0
	bc 4,0,.L72
	li 0,0
	stw 0,74(31)
.L72:
	mulli 0,10,200
	lwz 9,108(31)
	cmpw 0,9,0
	mr 11,0
	bc 4,1,.L73
	stw 11,108(31)
.L73:
	lwz 0,108(31)
	cmpwi 0,0,0
	bc 4,0,.L75
	li 0,0
	stw 0,108(31)
.L75:
	mulli 9,10,100
	lwz 0,112(31)
	cmpw 0,0,9
	bc 4,1,.L76
	stw 9,112(31)
.L76:
	lwz 0,112(31)
	cmpwi 0,0,0
	bc 4,0,.L78
	li 0,0
	stw 0,112(31)
.L78:
	mulli 9,10,50
	lwz 0,124(31)
	cmpw 0,0,9
	bc 4,1,.L79
	stw 9,124(31)
.L79:
	lwz 0,124(31)
	cmpwi 0,0,0
	bc 4,0,.L81
	li 0,0
	stw 0,124(31)
.L81:
	lwz 0,120(31)
	cmpw 0,0,9
	bc 4,1,.L82
	stw 9,120(31)
.L82:
	lwz 0,120(31)
	cmpwi 0,0,0
	bc 4,0,.L84
	li 0,0
	stw 0,120(31)
.L84:
	lwz 0,116(31)
	cmpw 0,0,11
	bc 4,1,.L85
	stw 11,116(31)
.L85:
	lwz 0,116(31)
	cmpwi 0,0,0
	bc 4,0,.L87
	li 0,0
	stw 0,116(31)
.L87:
	lwz 0,128(31)
	cmpw 0,0,9
	bc 4,1,.L88
	stw 9,128(31)
.L88:
	lwz 0,128(31)
	cmpwi 0,0,0
	bc 4,0,.L90
	li 0,0
	stw 0,128(31)
.L90:
	lwz 0,232(31)
	cmpw 0,0,11
	bc 4,1,.L91
	stw 11,232(31)
.L91:
	lwz 0,232(31)
	cmpwi 0,0,0
	bc 4,0,.L93
	li 0,0
	stw 0,232(31)
.L93:
	lwz 0,228(31)
	cmpwi 0,0,20
	bc 4,1,.L94
	li 0,20
	stw 0,228(31)
.L94:
	lwz 0,228(31)
	cmpwi 0,0,0
	bc 4,0,.L96
	li 0,0
	stw 0,228(31)
.L96:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	slwi 9,3,2
	lwz 0,192(31)
	add 9,9,3
	addi 9,9,200
	cmpw 0,0,9
	bc 4,1,.L98
	stw 9,192(31)
.L98:
	lwz 0,192(31)
	cmpwi 0,0,0
	bc 4,0,.L100
	li 0,0
	stw 0,192(31)
.L100:
	mr 3,31
	bl GetMaxHealth__5CUser
	lwz 0,196(31)
	cmpw 0,0,3
	bc 4,1,.L101
	stw 3,196(31)
.L101:
	lwz 0,196(31)
	cmpwi 0,0,0
	bc 4,0,.L103
	li 0,0
	stw 0,196(31)
.L103:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 SetAllMax__5CUser,.Lfe2-SetAllMax__5CUser
	.section	".rodata"
	.align 2
.LC4:
	.string	"rb"
	.section	".text"
	.align 2
	.globl Load__5CUserPCcT1
	.type	 Load__5CUserPCcT1,@function
Load__5CUserPCcT1:
	stwu 1,-288(1)
	mflr 0
	stmw 28,272(1)
	stw 0,292(1)
	mr. 28,5
	mr 30,3
	mr 3,4
	bc 12,2,.L134
	mr 4,28
	addi 5,1,8
	bl GetUserPath__5CUserPCcT1Pc
	b .L135
.L134:
	mr 4,3
	addi 3,1,8
	bl strcpy
.L135:
	li 4,0
	li 5,793
	mr 3,30
	bl memset
	lis 4,.LC4@ha
	addi 3,1,8
	la 4,.LC4@l(4)
	bl fopen
	mr. 31,3
	li 3,2
	bc 12,2,.L157
	li 4,1
	li 5,793
	mr 6,31
	mr 3,30
	bl fread
	mr 29,3
	li 0,0
	stw 0,0(30)
	mr 3,31
	bl fclose
	cmpwi 0,29,793
	bc 4,2,.L159
	cmpwi 0,28,0
	li 0,30
	mtctr 0
	li 11,0
	addi 8,30,78
	addi 7,30,8
	addi 10,30,132
	mfcr 31
.L158:
	lhz 0,0(10)
	addi 10,10,2
	cmpwi 0,0,0
	bc 12,2,.L160
	lbzx 9,7,11
	cmpwi 0,9,0
	bc 4,2,.L144
	srwi 0,0,5
	b .L160
.L144:
	divw 0,0,9
.L160:
	stbx 0,8,11
	addi 11,11,1
	bdnz .L158
	mr 3,30
	bl SetAllMax__5CUser
	mtcrf 128,31
	bc 12,2,.L149
	addi 31,30,8
	mr 3,31
	bl strlen
	mr 29,3
	mr 3,28
	bl strlen
	cmpw 0,29,3
	li 3,0
	bc 4,2,.L152
	mr 3,31
	bl strlen
	mr 5,3
	mr 4,28
	mr 3,31
	bl strncasecmp
	subfic 0,3,0
	adde 3,0,3
.L152:
	cmpwi 0,3,0
	bc 4,2,.L149
.L159:
	mr 3,30
	li 4,0
	li 5,793
	bl memset
	li 3,6
	b .L157
.L149:
	lwz 0,196(30)
	cmpwi 0,0,0
	bc 12,1,.L156
	mr 3,30
	bl SafeRespawn__5CUser
.L156:
	li 3,0
.L157:
	lwz 0,292(1)
	mtlr 0
	lmw 28,272(1)
	la 1,288(1)
	blr
.Lfe3:
	.size	 Load__5CUserPCcT1,.Lfe3-Load__5CUserPCcT1
	.section	".rodata"
	.align 2
.LC5:
	.string	"wb"
	.section	".text"
	.align 2
	.globl Save__5CUserPCcb
	.type	 Save__5CUserPCcb,@function
Save__5CUserPCcb:
	stwu 1,-288(1)
	mflr 0
	stmw 28,272(1)
	stw 0,292(1)
	mr 31,3
	mr 30,5
	mr 3,4
	addi 29,31,8
	mr 4,29
	addi 5,1,8
	bl GetUserPath__5CUserPCcT1Pc
	lwz 0,0(31)
	cmpwi 0,0,0
	bc 4,2,.L189
	cmpwi 0,30,0
	bc 12,2,.L163
	addi 3,31,220
	bl time
.L163:
	lwz 0,265(31)
	cmpwi 0,0,0
	bc 4,2,.L164
	addi 3,31,265
	bl time
.L164:
	lis 4,.LC5@ha
	addi 3,1,8
	la 4,.LC5@l(4)
	bl fopen
	mr. 28,3
	bc 4,2,.L165
.L189:
	li 3,0
	b .L186
.L165:
	li 0,30
	addi 30,31,78
	mtctr 0
	mr 7,29
	mr 8,30
	li 10,0
	li 6,0
	addi 11,31,132
.L188:
	lbzx 0,7,10
	cmpwi 0,0,0
	bc 4,2,.L171
	lbzx 0,8,10
	slwi 0,0,5
	b .L190
.L171:
	lbzx 9,8,10
	rlwinm 0,0,0,0xff
	mullw 0,0,9
.L190:
	sth 0,0(11)
	stbx 6,8,10
	addi 11,11,2
	addi 10,10,1
	bdnz .L188
	li 4,1
	li 5,793
	mr 6,28
	mr 3,31
	bl fwrite
	mr 3,28
	bl fclose
	li 0,30
	mr 10,30
	mtctr 0
	mr 4,29
	addi 3,31,132
	li 11,0
.L187:
	lhz 0,0(3)
	addi 3,3,2
	cmpwi 0,0,0
	bc 12,2,.L191
	lbzx 9,4,11
	cmpwi 0,9,0
	bc 4,2,.L181
	srwi 0,0,5
	b .L191
.L181:
	divw 0,0,9
.L191:
	stbx 0,10,11
	addi 11,11,1
	bdnz .L187
	li 3,1
.L186:
	lwz 0,292(1)
	mtlr 0
	lmw 28,272(1)
	la 1,288(1)
	blr
.Lfe4:
	.size	 Save__5CUserPCcb,.Lfe4-Save__5CUserPCcb
	.section	".rodata"
	.align 2
.LC6:
	.string	"changeme"
	.section	".text"
	.align 2
	.globl SafeRespawn__5CUser
	.type	 SafeRespawn__5CUser,@function
SafeRespawn__5CUser:
	lwz 9,200(3)
	li 10,0
	li 0,100
.L217:
	cmpw 0,9,0
	bc 12,0,.L218
	add 0,0,0
	addi 10,10,1
	b .L217
.L218:
	lwz 0,228(3)
	li 9,0
	stw 9,108(3)
	cmpwi 0,0,1
	stw 9,112(3)
	stw 9,116(3)
	stw 9,120(3)
	stw 9,128(3)
	stw 9,124(3)
	bc 12,1,.L223
	li 0,2
	stw 0,228(3)
.L223:
	cmpwi 0,10,7
	li 0,1
	stw 9,42(3)
	stw 0,38(3)
	stw 9,46(3)
	stw 9,50(3)
	stw 9,54(3)
	stw 9,58(3)
	stw 9,62(3)
	stw 9,66(3)
	stw 9,70(3)
	stw 9,74(3)
	bc 4,1,.L224
	li 0,50
	stw 0,192(3)
	b .L225
.L224:
	stw 9,192(3)
.L225:
	li 0,100
	li 11,0
	mtctr 0
	li 8,3
	addi 9,3,269
.L239:
	add 0,11,11
	cmpw 0,10,0
	bc 12,0,.L228
	stw 8,0(9)
.L228:
	addi 9,9,4
	addi 11,11,1
	bdnz .L239
	lwz 9,200(3)
	li 11,0
	li 0,100
.L232:
	cmpw 0,9,0
	bc 12,0,.L233
	add 0,0,0
	addi 11,11,1
	b .L232
.L233:
	slwi 9,11,2
	add 9,9,11
	addi 9,9,100
	stw 9,196(3)
	blr
.Lfe5:
	.size	 SafeRespawn__5CUser,.Lfe5-SafeRespawn__5CUser
	.align 2
	.globl SetMax__5CUserRll
	.type	 SetMax__5CUserRll,@function
SetMax__5CUserRll:
	lwz 0,0(4)
	cmpw 0,0,5
	bc 4,1,.L24
	stw 5,0(4)
.L24:
	lwz 0,0(4)
	cmpwi 0,0,0
	bclr 4,0
	li 0,0
	stw 0,0(4)
	blr
.Lfe6:
	.size	 SetMax__5CUserRll,.Lfe6-SetMax__5CUserRll
	.align 2
	.globl SetMaxItems__5CUserRUcUc
	.type	 SetMaxItems__5CUserRUcUc,@function
SetMaxItems__5CUserRUcUc:
	lbz 0,0(4)
	cmplw 0,0,5
	bclr 4,1
	stb 5,0(4)
	blr
.Lfe7:
	.size	 SetMaxItems__5CUserRUcUc,.Lfe7-SetMaxItems__5CUserRUcUc
	.align 2
	.globl GetMaxArmor__5CUser
	.type	 GetMaxArmor__5CUser,@function
GetMaxArmor__5CUser:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,0
	bl Level__5CUserPl
	slwi 9,3,2
	add 9,9,3
	addi 3,9,200
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 GetMaxArmor__5CUser,.Lfe8-GetMaxArmor__5CUser
	.align 2
	.globl GetAmmoMulti__5CUser
	.type	 GetAmmoMulti__5CUser,@function
GetAmmoMulti__5CUser:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,5
	li 3,4
	bc 12,1,.L32
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,3
	li 3,3
	bc 12,1,.L32
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,2
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	nor 9,0,0
	rlwinm 0,0,0,31,31
	rlwinm 9,9,0,30,30
	or 3,0,9
.L32:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe9:
	.size	 GetAmmoMulti__5CUser,.Lfe9-GetAmmoMulti__5CUser
	.align 2
	.globl Level__5CUserPl
	.type	 Level__5CUserPl,@function
Level__5CUserPl:
	mr. 4,4
	mr 11,3
	li 3,0
	li 9,100
	mcrf 7,0
.L105:
	lwz 0,200(11)
	cmpw 0,0,9
	bc 4,0,.L108
	bclr 12,30
	stw 9,0(4)
	blr
.L108:
	add 9,9,9
	addi 3,3,1
	b .L105
.Lfe10:
	.size	 Level__5CUserPl,.Lfe10-Level__5CUserPl
	.align 2
	.globl CheckName__5CUserPCc
	.type	 CheckName__5CUserPCc,@function
CheckName__5CUserPCc:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	addi 31,3,8
	mr 30,4
	mr 3,31
	bl strlen
	mr 29,3
	mr 3,30
	bl strlen
	cmpw 0,29,3
	bc 4,2,.L111
	mr 3,31
	bl strlen
	mr 5,3
	mr 4,30
	mr 3,31
	bl strncasecmp
	subfic 0,3,0
	adde 3,0,3
	b .L243
.L111:
	li 3,0
.L243:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 CheckName__5CUserPCc,.Lfe11-CheckName__5CUserPCc
	.align 2
	.globl Encrypt__5CUser
	.type	 Encrypt__5CUser,@function
Encrypt__5CUser:
	li 0,30
	li 8,0
	mtctr 0
	addi 6,3,8
	addi 7,3,78
	li 5,0
	addi 9,3,132
.L244:
	lbzx 0,6,8
	addi 10,3,78
	cmpwi 0,0,0
	rlwinm 11,0,0,0xff
	bc 4,2,.L118
	lbzx 0,7,8
	slwi 0,0,5
	b .L245
.L118:
	lbzx 0,7,8
	addi 10,3,78
	mullw 0,11,0
.L245:
	sth 0,0(9)
	stbx 5,10,8
	addi 9,9,2
	addi 8,8,1
	bdnz .L244
	blr
.Lfe12:
	.size	 Encrypt__5CUser,.Lfe12-Encrypt__5CUser
	.align 2
	.globl Decrypt__5CUser
	.type	 Decrypt__5CUser,@function
Decrypt__5CUser:
	li 0,30
	addi 10,3,78
	mtctr 0
	addi 8,3,8
	li 11,0
	addi 3,3,132
.L246:
	lhz 0,0(3)
	addi 3,3,2
	cmpwi 0,0,0
	bc 12,2,.L247
	lbzx 9,8,11
	cmpwi 0,9,0
	bc 4,2,.L128
	srwi 0,0,5
	b .L247
.L128:
	divw 0,0,9
.L247:
	stbx 0,10,11
	addi 11,11,1
	bdnz .L246
	li 3,1
	blr
.Lfe13:
	.size	 Decrypt__5CUser,.Lfe13-Decrypt__5CUser
	.align 2
	.globl CheckVersion__5CUser
	.type	 CheckVersion__5CUser,@function
CheckVersion__5CUser:
	blr
.Lfe14:
	.size	 CheckVersion__5CUser,.Lfe14-CheckVersion__5CUser
	.align 2
	.globl Score__5CUserl
	.type	 Score__5CUserl,@function
Score__5CUserl:
	mr 9,3
	lwz 11,200(9)
	lwz 0,240(9)
	mr 3,11
	subf 3,0,3
	add 3,3,4
	cmpw 0,3,11
	bc 4,0,.L193
	subf 0,3,11
	stw 0,240(9)
	blr
.L193:
	li 0,0
	stw 3,200(9)
	stw 0,240(9)
	blr
.Lfe15:
	.size	 Score__5CUserl,.Lfe15-Score__5CUserl
	.section	".rodata"
	.align 3
.LC7:
	.long 0x43300000
	.long 0x0
	.align 2
.LC8:
	.long 0x3f800000
	.align 2
.LC9:
	.long 0x0
	.align 2
.LC10:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl Ratio__5CUser
	.type	 Ratio__5CUser,@function
Ratio__5CUser:
	stwu 1,-16(1)
	lwz 11,208(3)
	lis 10,0x4330
	lwz 0,212(3)
	lis 8,.LC7@ha
	la 8,.LC7@l(8)
	add 0,11,0
	lfd 12,0(8)
	stw 0,12(1)
	lis 8,.LC8@ha
	stw 10,8(1)
	la 8,.LC8@l(8)
	lfd 0,8(1)
	lfs 13,0(8)
	fsub 0,0,12
	frsp 1,0
	fcmpu 0,1,13
	bc 4,0,.L196
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfs 1,0(9)
	b .L197
.L196:
	lis 8,.LC10@ha
	stw 11,12(1)
	la 8,.LC10@l(8)
	stw 10,8(1)
	lfd 0,8(1)
	lfs 13,0(8)
	fsub 0,0,12
	frsp 0,0
	fdivs 1,0,1
	fmuls 1,1,13
.L197:
	la 1,16(1)
	blr
.Lfe16:
	.size	 Ratio__5CUser,.Lfe16-Ratio__5CUser
	.align 2
	.globl NextLevel__5CUser
	.type	 NextLevel__5CUser,@function
NextLevel__5CUser:
	stwu 1,-32(1)
	lwz 9,200(3)
	addi 11,1,8
	li 0,100
.L199:
	cmpw 0,9,0
	bc 12,0,.L200
	add 0,0,0
	b .L199
.L200:
	cmpwi 0,11,0
	bc 12,2,.L202
	stw 0,0(11)
.L202:
	lwz 3,8(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 NextLevel__5CUser,.Lfe17-NextLevel__5CUser
	.align 2
	.globl CheckPass__5CUserPCc
	.type	 CheckPass__5CUserPCc,@function
CheckPass__5CUserPCc:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	addi 31,3,78
	mr 30,4
	mr 3,31
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L207
	lis 4,.LC6@ha
	mr 3,31
	la 4,.LC6@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L206
.L207:
	mr 3,31
	mr 4,30
	bl strcpy
	li 3,1
	b .L248
.L206:
	mr 3,31
	mr 4,30
	bl strcmp
	subfic 0,3,0
	adde 3,0,3
.L248:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe18:
	.size	 CheckPass__5CUserPCc,.Lfe18-CheckPass__5CUserPCc
	.align 2
	.globl GetMaxHealth__5CUser
	.type	 GetMaxHealth__5CUser,@function
GetMaxHealth__5CUser:
	lwz 11,200(3)
	li 9,0
	li 0,100
.L210:
	cmpw 0,11,0
	bc 12,0,.L211
	add 0,0,0
	addi 9,9,1
	b .L210
.L211:
	slwi 3,9,2
	add 3,3,9
	addi 3,3,100
	blr
.Lfe19:
	.size	 GetMaxHealth__5CUser,.Lfe19-GetMaxHealth__5CUser
	.section	".rodata"
	.align 3
.LC11:
	.long 0x43300000
	.long 0x0
	.align 2
.LC12:
	.long 0x0
	.section	".text"
	.align 2
	.globl KillsPerMin__5CUser
	.type	 KillsPerMin__5CUser,@function
KillsPerMin__5CUser:
	stwu 1,-16(1)
	lwz 9,224(3)
	cmpwi 0,9,0
	bc 12,2,.L241
	lis 0,0x8888
	lwz 8,208(3)
	ori 0,0,34953
	lis 10,0x4330
	mulhwu 0,9,0
	lis 7,.LC11@ha
	mr 9,11
	la 7,.LC11@l(7)
	srwi 0,0,5
	lfd 13,0(7)
	stw 0,12(1)
	stw 10,8(1)
	lfd 0,8(1)
	stw 8,12(1)
	stw 10,8(1)
	lfd 1,8(1)
	fsub 0,0,13
	fsub 1,1,13
	frsp 0,0
	frsp 1,1
	fdivs 1,1,0
	b .L249
.L241:
	lis 9,.LC12@ha
	la 9,.LC12@l(9)
	lfs 1,0(9)
.L249:
	la 1,16(1)
	blr
.Lfe20:
	.size	 KillsPerMin__5CUser,.Lfe20-KillsPerMin__5CUser
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
