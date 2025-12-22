	.file	"ServObits.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"%s%s"
	.section	".text"
	.align 2
	.globl PerformSubstitutions
	.type	 PerformSubstitutions,@function
PerformSubstitutions:
	stwu 1,-2112(1)
	mflr 0
	stmw 21,2068(1)
	stw 0,2116(1)
	mr 28,3
	li 27,0
	li 26,0
	bl strlen
	mr 22,3
	addi 25,1,1032
	cmpw 0,27,22
	bc 4,0,.L48
	li 21,0
.L49:
	lbzx 0,28,26
	cmpwi 0,0,37
	mr 11,0
	bc 4,2,.L50
	addi 31,26,1
	lbzx 9,28,31
	mr 24,31
	b .L72
.L53:
	addi 31,31,1
	lbzx 9,28,31
.L72:
	xori 0,9,37
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,9,0
	bc 4,2,.L53
	lbzx 0,28,31
	cmpwi 0,0,0
	bc 4,2,.L56
	stbx 11,25,27
	mr 26,24
	b .L73
.L56:
	addi 29,31,-1
	add 4,28,26
	subf 29,26,29
	addi 4,4,1
	mr 5,29
	addi 3,1,8
	bl strncpy
	addi 30,1,8
	lis 9,ServObitSubstitutionList@ha
	stbx 21,30,29
	mr 23,30
	lwz 29,ServObitSubstitutionList@l(9)
	cmpwi 0,29,0
	bc 12,2,.L62
.L59:
	lwz 4,0(29)
	mr 3,30
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L61
	lwz 29,12(29)
	cmpwi 0,29,0
	bc 4,2,.L59
.L62:
	li 29,0
.L61:
	cmpwi 0,29,0
	bc 12,2,.L74
	lwz 0,8(29)
	cmpwi 0,0,0
	bc 4,2,.L66
.L74:
	li 30,0
	b .L64
.L66:
	bl rand
	lwz 9,8(29)
	lwz 11,4(29)
	divw 0,3,9
	mullw 0,0,9
	subf 3,0,3
	slwi 3,3,2
	lwzx 30,3,11
.L64:
	cmpwi 0,30,0
	bc 4,2,.L68
	lbzx 0,28,26
	mr 26,24
	stbx 0,25,27
	b .L73
.L68:
	add 9,23,27
	add 3,25,27
	stb 21,1024(9)
	mr 4,30
	addi 26,31,1
	bl strcat
	mr 3,30
	bl strlen
	add 27,27,3
	b .L47
.L50:
	stbx 0,25,27
	addi 26,26,1
.L73:
	addi 27,27,1
.L47:
	cmpw 0,26,22
	bc 12,0,.L49
.L48:
	li 0,0
	mr 3,28
	stbx 0,25,27
	mr 4,25
	bl strcpy
	lwz 0,2116(1)
	mtlr 0
	lmw 21,2068(1)
	la 1,2112(1)
	blr
.Lfe1:
	.size	 PerformSubstitutions,.Lfe1-PerformSubstitutions
	.section	".rodata"
	.align 2
.LC1:
	.string	"sup"
	.align 2
.LC2:
	.string	"sh"
	.align 2
.LC3:
	.string	"bfg_b"
	.align 2
.LC4:
	.string	"bfg_l"
	.align 2
.LC5:
	.string	"bfg_e"
	.align 2
.LC6:
	.string	"bl"
	.align 2
.LC7:
	.string	"hy"
	.align 2
.LC8:
	.string	"ha"
	.align 2
.LC9:
	.string	"hg_s"
	.align 2
.LC10:
	.string	"hg_h"
	.align 2
.LC11:
	.string	"gr"
	.align 2
.LC12:
	.string	"g_"
	.align 2
.LC13:
	.string	"ro"
	.align 2
.LC14:
	.string	"r_"
	.align 2
.LC15:
	.string	"ra"
	.align 2
.LC16:
	.string	"c"
	.align 2
.LC17:
	.string	"m"
	.align 2
.LC18:
	.string	"te"
	.align 2
.LC19:
	.string	"lav"
	.align 2
.LC20:
	.string	"las"
	.align 2
.LC21:
	.string	"ex"
	.align 2
.LC22:
	.string	"we"
	.align 2
.LC23:
	.string	"wa"
	.align 2
.LC24:
	.string	"sl"
	.align 2
.LC25:
	.string	"sui"
	.align 2
.LC26:
	.string	"f"
	.align 2
.LC27:
	.string	"to"
	.align 2
.LC28:
	.string	"sq"
	.align 2
.LC29:
	.string	"e"
	.section	".text"
	.align 2
	.globl ConvertObitWeaponSpec
	.type	 ConvertObitWeaponSpec,@function
ConvertObitWeaponSpec:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 3,.LC1@ha
	mr 4,31
	la 3,.LC1@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,4
	bc 4,2,.L168
	lis 3,.LC2@ha
	mr 4,31
	la 3,.LC2@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,3
	bc 4,2,.L168
	lis 3,.LC3@ha
	mr 4,31
	la 3,.LC3@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,18
	bc 4,2,.L168
	lis 3,.LC4@ha
	mr 4,31
	la 3,.LC4@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,16
	bc 4,2,.L168
	lis 3,.LC5@ha
	mr 4,31
	la 3,.LC5@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,17
	bc 4,2,.L168
	lis 3,.LC6@ha
	mr 4,31
	la 3,.LC6@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,2
	bc 4,2,.L168
	lis 3,.LC7@ha
	mr 4,31
	la 3,.LC7@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,14
	bc 4,2,.L168
	lis 3,.LC8@ha
	mr 4,31
	la 3,.LC8@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,9
	bc 4,2,.L168
	lis 3,.LC9@ha
	mr 4,31
	la 3,.LC9@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,10
	bc 4,2,.L168
	lis 3,.LC10@ha
	mr 4,31
	la 3,.LC10@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,11
	bc 4,2,.L168
	lis 3,.LC11@ha
	mr 4,31
	la 3,.LC11@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,7
	bc 4,2,.L168
	lis 3,.LC12@ha
	mr 4,31
	la 3,.LC12@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,8
	bc 4,2,.L168
	lis 3,.LC13@ha
	mr 4,31
	la 3,.LC13@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,12
	bc 4,2,.L168
	lis 3,.LC14@ha
	mr 4,31
	la 3,.LC14@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,13
	bc 4,2,.L168
	lis 3,.LC15@ha
	mr 4,31
	la 3,.LC15@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,15
	bc 4,2,.L168
	lis 3,.LC16@ha
	mr 4,31
	la 3,.LC16@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,6
	bc 4,2,.L168
	lis 3,.LC17@ha
	mr 4,31
	la 3,.LC17@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,5
	bc 4,2,.L168
	lis 3,.LC18@ha
	mr 4,31
	la 3,.LC18@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,19
	bc 4,2,.L168
	lis 3,.LC19@ha
	mr 4,31
	la 3,.LC19@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,51
	bc 4,2,.L168
	lis 3,.LC20@ha
	mr 4,31
	la 3,.LC20@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,58
	bc 4,2,.L168
	lis 3,.LC21@ha
	mr 4,31
	la 3,.LC21@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,57
	bc 4,2,.L168
	lis 3,.LC22@ha
	mr 4,31
	la 3,.LC22@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,20
	bc 4,2,.L168
	lis 3,.LC23@ha
	mr 4,31
	la 3,.LC23@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,53
	bc 4,2,.L168
	lis 3,.LC24@ha
	mr 4,31
	la 3,.LC24@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,52
	bc 4,2,.L168
	lis 3,.LC25@ha
	mr 4,31
	la 3,.LC25@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,21
	bc 4,2,.L168
	lis 3,.LC26@ha
	mr 4,31
	la 3,.LC26@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,54
	bc 4,2,.L168
	lis 3,.LC27@ha
	mr 4,31
	la 3,.LC27@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,56
	bc 4,2,.L168
	lis 3,.LC28@ha
	mr 4,31
	la 3,.LC28@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,55
	bc 4,2,.L168
	lis 3,.LC29@ha
	mr 4,31
	la 3,.LC29@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 4,2,.L164
	lbz 3,0(31)
	xori 3,3,42
	addic 3,3,-1
	subfe 3,3,3
	andi. 3,3,80
	b .L168
.L164:
	li 3,59
.L168:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 ConvertObitWeaponSpec,.Lfe2-ConvertObitWeaponSpec
	.section	".rodata"
	.align 2
.LC30:
	.string	"Parse Error in %s of line %d; value = '%s'\n"
	.align 2
.LC31:
	.string	"-->Text: %s\n"
	.align 2
.LC32:
	.string	"$"
	.align 2
.LC33:
	.string	"$N"
	.align 2
.LC34:
	.string	"$HIS"
	.align 2
.LC35:
	.string	"$HIM"
	.align 2
.LC36:
	.string	"$HERSELF"
	.align 2
.LC37:
	.string	"$SHE"
	.align 2
.LC38:
	.string	"ERROR: line %d: Can't understand $ specifier starting with '%s'\n"
	.align 2
.LC39:
	.string	"--> %s\n"
	.section	".text"
	.align 2
	.globl ComplainInvalidConnectNameSpecifiers
	.type	 ComplainInvalidConnectNameSpecifiers,@function
ComplainInvalidConnectNameSpecifiers:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 29,3
	mr 27,4
	mr 31,29
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L173
	lis 9,ServObit@ha
	lis 30,LOG@ha
	la 28,ServObit@l(9)
.L174:
	lis 3,.LC32@ha
	mr 4,31
	la 3,.LC32@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L175
	lis 3,.LC33@ha
	mr 4,31
	la 3,.LC33@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L176
	addi 31,31,2
	b .L172
.L176:
	lis 3,.LC34@ha
	mr 4,31
	la 3,.LC34@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 4,2,.L188
	lis 3,.LC35@ha
	mr 4,31
	la 3,.LC35@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 4,2,.L188
	lis 3,.LC36@ha
	mr 4,31
	la 3,.LC36@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L182
	addi 31,31,8
	b .L172
.L182:
	lis 3,.LC37@ha
	mr 4,31
	la 3,.LC37@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L184
.L188:
	addi 31,31,4
	b .L172
.L184:
	lwz 3,LOG@l(30)
	lis 4,.LC38@ha
	mr 6,31
	la 4,.LC38@l(4)
	mr 5,27
	crxor 6,6,6
	bl fprintf
	addi 31,31,1
	lwz 3,LOG@l(30)
	bl fflush
	lwz 3,LOG@l(30)
	lis 4,.LC39@ha
	mr 5,29
	la 4,.LC39@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(30)
	bl fflush
	lwz 9,56(28)
	addi 9,9,1
	stw 9,56(28)
	b .L172
.L175:
	addi 31,31,1
.L172:
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 4,2,.L174
.L173:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 ComplainInvalidConnectNameSpecifiers,.Lfe3-ComplainInvalidConnectNameSpecifiers
	.section	".rodata"
	.align 2
.LC40:
	.string	"$V"
	.align 2
.LC41:
	.string	"$K"
	.align 2
.LC42:
	.string	"$HISK"
	.align 2
.LC43:
	.string	"$HISV"
	.align 2
.LC44:
	.string	"$HIMK"
	.align 2
.LC45:
	.string	"$HIMV"
	.align 2
.LC46:
	.string	"$HERSELFV"
	.align 2
.LC47:
	.string	"$HERSELFK"
	.align 2
.LC48:
	.string	"$SHEK"
	.align 2
.LC49:
	.string	"$SHEV"
	.align 2
.LC50:
	.string	"$Q"
	.align 2
.LC51:
	.string	"$G"
	.section	".text"
	.align 2
	.globl ComplainInvalidNameSpecifiers
	.type	 ComplainInvalidNameSpecifiers,@function
ComplainInvalidNameSpecifiers:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 29,3
	mr 27,4
	mr 31,29
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L191
	lis 9,ServObit@ha
	lis 30,LOG@ha
	la 28,ServObit@l(9)
.L192:
	lis 3,.LC32@ha
	mr 4,31
	la 3,.LC32@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L193
	lis 3,.LC40@ha
	mr 4,31
	la 3,.LC40@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 4,2,.L220
	lis 3,.LC41@ha
	mr 4,31
	la 3,.LC41@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 4,2,.L220
	lis 3,.LC42@ha
	mr 4,31
	la 3,.LC42@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 4,2,.L221
	lis 3,.LC43@ha
	mr 4,31
	la 3,.LC43@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 4,2,.L221
	lis 3,.LC44@ha
	mr 4,31
	la 3,.LC44@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 4,2,.L221
	lis 3,.LC45@ha
	mr 4,31
	la 3,.LC45@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 4,2,.L221
	lis 3,.LC46@ha
	mr 4,31
	la 3,.LC46@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 4,2,.L222
	lis 3,.LC47@ha
	mr 4,31
	la 3,.LC47@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L208
.L222:
	addi 31,31,9
	b .L190
.L208:
	lis 3,.LC48@ha
	mr 4,31
	la 3,.LC48@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 4,2,.L221
	lis 3,.LC49@ha
	mr 4,31
	la 3,.LC49@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L212
.L221:
	addi 31,31,5
	b .L190
.L212:
	lis 3,.LC50@ha
	mr 4,31
	la 3,.LC50@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 4,2,.L220
	lis 3,.LC51@ha
	mr 4,31
	la 3,.LC51@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L216
.L220:
	addi 31,31,2
	b .L190
.L216:
	lwz 3,LOG@l(30)
	lis 4,.LC38@ha
	mr 6,31
	la 4,.LC38@l(4)
	mr 5,27
	crxor 6,6,6
	bl fprintf
	addi 31,31,1
	lwz 3,LOG@l(30)
	bl fflush
	lwz 3,LOG@l(30)
	lis 4,.LC39@ha
	mr 5,29
	la 4,.LC39@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(30)
	bl fflush
	lwz 9,56(28)
	addi 9,9,1
	stw 9,56(28)
	b .L190
.L193:
	addi 31,31,1
.L190:
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 4,2,.L192
.L191:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 ComplainInvalidNameSpecifiers,.Lfe4-ComplainInvalidNameSpecifiers
	.section	".rodata"
	.align 2
.LC52:
	.string	"ERROR: line %d: Started substitution '%s' with no closing %%\n"
	.align 2
.LC53:
	.string	"ERROR: line %d: Substitution '%s' not defined!\n"
	.section	".text"
	.align 2
	.globl ComplainInvalidSubstitutions
	.type	 ComplainInvalidSubstitutions,@function
ComplainInvalidSubstitutions:
	stwu 1,-560(1)
	mflr 0
	stmw 24,528(1)
	stw 0,564(1)
	mr 26,3
	mr 25,4
	bl strlen
	mr 3,26
	li 4,37
	bl strchr
	mr. 6,3
	bc 12,2,.L225
	lis 9,ServObit@ha
	lis 30,LOG@ha
	la 27,ServObit@l(9)
	lis 24,.LC39@ha
.L226:
	mr 31,6
	lbzu 9,1(31)
	xori 0,9,37
	mr 4,31
	b .L242
.L229:
	lbzu 9,1(31)
	xori 0,9,37
.L242:
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,9,0
	bc 4,2,.L229
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 4,2,.L231
	lwz 3,LOG@l(30)
	lis 4,.LC52@ha
	mr 5,25
	la 4,.LC52@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(30)
	bl fflush
	lwz 3,LOG@l(30)
	la 4,.LC39@l(24)
	mr 5,26
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(30)
	bl fflush
	lwz 9,56(27)
	addi 9,9,1
	stw 9,56(27)
	b .L225
.L241:
	mr 4,31
	b .L237
.L231:
	li 0,0
	addi 3,1,8
	stb 0,0(31)
	addi 28,31,1
	bl strcpy
	li 0,37
	lis 9,ServObitSubstitutionList@ha
	stb 0,0(31)
	addi 29,1,8
	lwz 31,ServObitSubstitutionList@l(9)
	cmpwi 0,31,0
	bc 12,2,.L238
.L235:
	lwz 4,0(31)
	mr 3,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L241
	lwz 31,12(31)
	cmpwi 0,31,0
	bc 4,2,.L235
.L238:
	li 4,0
.L237:
	cmpwi 0,4,0
	bc 4,2,.L239
	lwz 3,LOG@l(30)
	lis 4,.LC53@ha
	addi 6,1,8
	la 4,.LC53@l(4)
	mr 5,25
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(30)
	bl fflush
	lwz 3,LOG@l(30)
	la 4,.LC39@l(24)
	mr 5,26
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(30)
	bl fflush
	lwz 9,56(27)
	addi 9,9,1
	stw 9,56(27)
.L239:
	mr 3,28
	li 4,37
	bl strchr
	mr. 6,3
	bc 4,2,.L226
.L225:
	lwz 0,564(1)
	mtlr 0
	lmw 24,528(1)
	la 1,560(1)
	blr
.Lfe5:
	.size	 ComplainInvalidSubstitutions,.Lfe5-ComplainInvalidSubstitutions
	.section	".rodata"
	.align 2
.LC54:
	.string	"ERROR: line %d: unknown obit substitution: %s\n"
	.align 2
.LC55:
	.string	"ERROR: line %d: Exceeded MaxObitMessages.  Increase its value in ServObit.ini\n"
	.align 2
.LC56:
	.string	"ERROR: Line %d: Exceeded MaxObitMessages.  Increase its value in ServObit.ini\n"
	.section	".text"
	.align 2
	.globl AddMessageToServObit
	.type	 AddMessageToServObit,@function
AddMessageToServObit:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	mr 26,4
	mr 30,3
	lbz 0,0(26)
	mr 25,5
	cmpwi 0,0,91
	bc 4,2,.L246
	addi 26,26,1
	li 4,93
	mr 3,26
	bl strchr
	mr. 3,3
	bc 12,2,.L247
	li 0,0
	stb 0,0(3)
.L247:
	lis 9,ServObitSubstitutionList@ha
	lwz 29,ServObitSubstitutionList@l(9)
	cmpwi 0,29,0
	bc 12,2,.L253
.L250:
	lwz 4,0(29)
	mr 3,26
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L267
	lwz 29,12(29)
	cmpwi 0,29,0
	bc 4,2,.L250
.L253:
	li 28,0
.L252:
	cmpwi 0,28,0
	bc 4,2,.L254
	lis 29,LOG@ha
	lis 4,.LC54@ha
	lwz 3,LOG@l(29)
	la 4,.LC54@l(4)
	mr 5,25
	mr 6,26
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lis 11,ServObit@ha
	la 11,ServObit@l(11)
	lwz 9,56(11)
	addi 9,9,1
	stw 9,56(11)
	b .L263
.L267:
	mr 28,29
	b .L252
.L254:
	lwz 0,8(28)
	li 27,0
	cmpw 0,27,0
	bc 4,0,.L263
	lis 9,ServObit@ha
	li 31,0
	la 24,ServObit@l(9)
.L259:
	lwz 10,28(30)
	lwz 0,8(24)
	cmpw 0,10,0
	bc 12,2,.L268
	lwz 9,4(28)
	slwi 10,10,2
	mr 4,25
	lwz 11,24(30)
	addi 27,27,1
	lwzx 0,31,9
	stwx 0,10,11
	lwz 9,28(30)
	addi 9,9,1
	stw 9,28(30)
	lwz 11,4(28)
	lwzx 29,31,11
	addi 31,31,4
	mr 3,29
	bl ComplainInvalidSubstitutions
	mr 3,29
	mr 4,25
	bl ComplainInvalidNameSpecifiers
	lwz 0,8(28)
	cmpw 0,27,0
	bc 12,0,.L259
	b .L263
.L246:
	lis 9,ServObit@ha
	lwz 10,28(30)
	la 31,ServObit@l(9)
	lwz 0,8(31)
	cmpw 0,10,0
	bc 4,2,.L264
	lis 29,LOG@ha
	lis 4,.LC56@ha
	lwz 3,LOG@l(29)
	la 4,.LC56@l(4)
	mr 5,25
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lwz 3,LOG@l(29)
	lis 4,.LC39@ha
	mr 5,26
	la 4,.LC39@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lwz 9,56(31)
	addi 9,9,1
	stw 9,56(31)
	b .L263
.L268:
	lis 29,LOG@ha
	lis 4,.LC55@ha
	lwz 3,LOG@l(29)
	la 4,.LC55@l(4)
	mr 5,25
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lwz 3,LOG@l(29)
	lis 4,.LC39@ha
	mr 5,26
	la 4,.LC39@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lwz 9,56(24)
	addi 9,9,1
	stw 9,56(24)
	b .L263
.L264:
	lwz 11,24(30)
	slwi 9,10,2
	mr 3,26
	mr 4,25
	stwx 26,9,11
	bl ComplainInvalidSubstitutions
	mr 3,26
	mr 4,25
	bl ComplainInvalidNameSpecifiers
	lwz 9,28(30)
	addi 9,9,1
	stw 9,28(30)
.L263:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 AddMessageToServObit,.Lfe6-AddMessageToServObit
	.section	".rodata"
	.align 2
.LC57:
	.string	"KillerType"
	.align 2
.LC58:
	.string	"WeaponType"
	.align 2
.LC59:
	.string	"PowerType"
	.align 2
.LC60:
	.string	"KillerGender"
	.align 2
.LC61:
	.string	"VictimGender"
	.align 2
.LC62:
	.string	"BodyState"
	.section	".text"
	.align 2
	.globl ParseObitLine
	.type	 ParseObitLine,@function
ParseObitLine:
	stwu 1,-1584(1)
	mflr 0
	stmw 24,1552(1)
	stw 0,1588(1)
	mr 31,3
	mr 25,4
	li 3,32
	bl malloc
	mr 30,3
	lis 9,ServObit+8@ha
	lwz 3,ServObit+8@l(9)
	slwi 3,3,2
	bl malloc
	li 0,0
	stw 3,24(30)
	li 9,0
	stb 0,1288(1)
	mr 3,31
	stw 9,28(30)
	stb 0,8(1)
	stb 0,264(1)
	stb 0,520(1)
	stb 0,776(1)
	stb 0,1032(1)
	bl strlen
	cmplwi 0,3,255
	bc 12,1,.L270
	mr 3,31
	bl strlen
	b .L271
.L270:
	li 3,256
.L271:
	li 7,0
	li 8,0
	addi 28,1,8
	addi 4,1,264
	addi 5,1,520
	addi 27,1,776
	addi 26,1,1032
	addi 29,1,1288
	b .L272
.L275:
	stbx 10,28,7
	addi 8,8,1
	addi 7,7,1
.L272:
	cmpw 0,8,3
	bc 4,0,.L273
	lbzx 0,31,8
	rlwinm 11,0,0,0xff
	mr 10,0
	xori 9,11,32
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,9
	subfic 6,0,0
	adde 0,6,0
	or. 24,9,0
	bc 4,2,.L277
	cmpwi 0,11,10
	bc 4,2,.L278
.L277:
	li 0,1
	b .L279
.L278:
	li 0,0
.L279:
	cmpwi 0,0,0
	bc 12,2,.L275
.L273:
	li 0,0
	addi 8,8,1
	stbx 0,28,7
	mr 6,4
	li 7,0
	b .L282
.L285:
	stbx 10,6,7
	addi 8,8,1
	addi 7,7,1
.L282:
	cmpw 0,8,3
	bc 4,0,.L283
	lbzx 0,31,8
	rlwinm 11,0,0,0xff
	mr 10,0
	xori 9,11,32
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,9
	subfic 24,0,0
	adde 0,24,0
	or. 24,9,0
	bc 4,2,.L287
	cmpwi 0,11,10
	bc 4,2,.L288
.L287:
	li 0,1
	b .L289
.L288:
	li 0,0
.L289:
	cmpwi 0,0,0
	bc 12,2,.L285
.L283:
	li 0,0
	addi 8,8,1
	stbx 0,4,7
	mr 6,5
	li 7,0
	b .L292
.L295:
	stbx 10,6,7
	addi 8,8,1
	addi 7,7,1
.L292:
	cmpw 0,8,3
	bc 4,0,.L293
	lbzx 0,31,8
	rlwinm 11,0,0,0xff
	mr 10,0
	xori 9,11,32
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,9
	subfic 24,0,0
	adde 0,24,0
	or. 24,9,0
	bc 4,2,.L297
	cmpwi 0,11,10
	bc 4,2,.L298
.L297:
	li 0,1
	b .L299
.L298:
	li 0,0
.L299:
	cmpwi 0,0,0
	bc 12,2,.L295
.L293:
	li 0,0
	addi 8,8,1
	stbx 0,5,7
	mr 6,27
	li 7,0
	b .L302
.L305:
	stbx 10,6,7
	addi 8,8,1
	addi 7,7,1
.L302:
	cmpw 0,8,3
	bc 4,0,.L303
	lbzx 0,31,8
	rlwinm 11,0,0,0xff
	mr 10,0
	xori 9,11,32
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,9
	subfic 5,0,0
	adde 0,5,0
	or. 24,9,0
	bc 4,2,.L307
	cmpwi 0,11,10
	bc 4,2,.L308
.L307:
	li 0,1
	b .L309
.L308:
	li 0,0
.L309:
	cmpwi 0,0,0
	bc 12,2,.L305
.L303:
	li 0,0
	addi 8,8,1
	stbx 0,27,7
	mr 6,26
	li 7,0
	b .L312
.L315:
	stbx 10,6,7
	addi 8,8,1
	addi 7,7,1
.L312:
	cmpw 0,8,3
	bc 4,0,.L313
	lbzx 0,31,8
	rlwinm 11,0,0,0xff
	mr 10,0
	xori 9,11,32
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,9
	subfic 5,0,0
	adde 0,5,0
	or. 24,9,0
	bc 4,2,.L317
	cmpwi 0,11,10
	bc 4,2,.L318
.L317:
	li 0,1
	b .L319
.L318:
	li 0,0
.L319:
	cmpwi 0,0,0
	bc 12,2,.L315
.L313:
	li 0,0
	addi 8,8,1
	stbx 0,26,7
	mr 6,29
	li 7,0
	b .L322
.L325:
	stbx 10,6,7
	addi 8,8,1
	addi 7,7,1
.L322:
	cmpw 0,8,3
	bc 4,0,.L323
	lbzx 0,31,8
	rlwinm 11,0,0,0xff
	mr 10,0
	xori 9,11,32
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,9
	subfic 5,0,0
	adde 0,5,0
	or. 24,9,0
	bc 4,2,.L327
	cmpwi 0,11,10
	bc 4,2,.L328
.L327:
	li 0,1
	b .L329
.L328:
	li 0,0
.L329:
	cmpwi 0,0,0
	bc 12,2,.L325
.L323:
	li 0,0
	stbx 0,29,7
	lbz 11,8(1)
	xori 9,11,83
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,115
	subfic 5,0,0
	adde 0,5,0
	or. 6,9,0
	bc 12,2,.L332
	li 0,2
	b .L333
.L332:
	xori 9,11,69
	subfic 10,9,0
	adde 9,10,9
	xori 0,11,101
	subfic 24,0,0
	adde 0,24,0
	or. 5,9,0
	bc 12,2,.L335
	li 0,3
	b .L333
.L335:
	xori 9,11,87
	subfic 6,9,0
	adde 9,6,9
	xori 0,11,119
	subfic 10,0,0
	adde 0,10,0
	or. 24,9,0
	li 0,4
	bc 4,2,.L333
	xori 0,11,42
	subfic 5,0,0
	adde 0,5,0
.L333:
	stw 0,0(30)
	mr 3,4
	bl ConvertObitWeaponSpec
	lbz 11,520(1)
	stw 3,4(30)
	cmpwi 0,11,42
	bc 4,2,.L341
	li 0,1
	b .L342
.L341:
	xori 9,11,81
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,113
	subfic 5,0,0
	adde 0,5,0
	or. 6,9,0
	bc 12,2,.L344
	li 0,2
	b .L342
.L344:
	xori 9,11,110
	subfic 10,9,0
	adde 9,10,9
	xori 0,11,78
	subfic 24,0,0
	adde 0,24,0
	or 0,0,9
	neg 0,0
	rlwinm 0,0,0,30,31
.L342:
	stw 0,8(30)
	mr 3,27
	bl ConvertGenderSpec
	stw 3,12(30)
	mr 3,26
	bl ConvertGenderSpec
	lbz 11,1288(1)
	stw 3,16(30)
	cmpwi 0,11,42
	bc 4,2,.L348
	li 11,4
	b .L349
.L348:
	xori 9,11,77
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,109
	subfic 5,0,0
	adde 0,5,0
	or. 6,9,0
	bc 12,2,.L351
	li 11,3
	b .L349
.L351:
	xori 9,11,71
	subfic 10,9,0
	adde 9,10,9
	xori 0,11,103
	subfic 24,0,0
	adde 0,24,0
	or. 5,9,0
	bc 12,2,.L353
	li 11,2
	b .L349
.L353:
	xori 9,11,110
	subfic 6,9,0
	adde 9,6,9
	xori 0,11,78
	subfic 10,0,0
	adde 0,10,0
	or 11,0,9
.L349:
	lwz 0,0(30)
	lis 9,.LC57@ha
	la 5,.LC57@l(9)
	stw 11,20(30)
	cmpwi 0,0,0
	bc 4,2,.L358
	lis 29,LOG@ha
	lis 4,.LC30@ha
	lwz 3,LOG@l(29)
	mr 7,28
	la 4,.LC30@l(4)
	mr 6,25
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lwz 3,LOG@l(29)
	lis 4,.LC31@ha
	mr 5,31
	la 4,.LC31@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lis 11,ServObit@ha
	la 11,ServObit@l(11)
	lwz 9,56(11)
	addi 9,9,1
	stw 9,56(11)
.L358:
	lwz 0,4(30)
	lis 9,.LC58@ha
	la 5,.LC58@l(9)
	cmpwi 0,0,0
	bc 4,2,.L360
	lis 29,LOG@ha
	lis 4,.LC30@ha
	lwz 3,LOG@l(29)
	la 4,.LC30@l(4)
	mr 6,25
	addi 7,1,264
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lwz 3,LOG@l(29)
	lis 4,.LC31@ha
	mr 5,31
	la 4,.LC31@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lis 11,ServObit@ha
	la 11,ServObit@l(11)
	lwz 9,56(11)
	addi 9,9,1
	stw 9,56(11)
.L360:
	lwz 0,8(30)
	lis 9,.LC59@ha
	la 5,.LC59@l(9)
	cmpwi 0,0,0
	bc 4,2,.L362
	lis 29,LOG@ha
	lis 4,.LC30@ha
	lwz 3,LOG@l(29)
	la 4,.LC30@l(4)
	mr 6,25
	addi 7,1,520
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lwz 3,LOG@l(29)
	lis 4,.LC31@ha
	mr 5,31
	la 4,.LC31@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lis 11,ServObit@ha
	la 11,ServObit@l(11)
	lwz 9,56(11)
	addi 9,9,1
	stw 9,56(11)
.L362:
	lwz 0,12(30)
	lis 9,.LC60@ha
	la 5,.LC60@l(9)
	cmpwi 0,0,0
	bc 4,2,.L364
	lis 29,LOG@ha
	lis 4,.LC30@ha
	lwz 3,LOG@l(29)
	la 4,.LC30@l(4)
	mr 6,25
	addi 7,1,776
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lwz 3,LOG@l(29)
	lis 4,.LC31@ha
	mr 5,31
	la 4,.LC31@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lis 11,ServObit@ha
	la 11,ServObit@l(11)
	lwz 9,56(11)
	addi 9,9,1
	stw 9,56(11)
.L364:
	lwz 0,16(30)
	lis 9,.LC61@ha
	la 5,.LC61@l(9)
	cmpwi 0,0,0
	bc 4,2,.L366
	lis 29,LOG@ha
	lis 4,.LC30@ha
	lwz 3,LOG@l(29)
	la 4,.LC30@l(4)
	mr 6,25
	addi 7,1,1032
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lwz 3,LOG@l(29)
	lis 4,.LC31@ha
	mr 5,31
	la 4,.LC31@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lis 11,ServObit@ha
	la 11,ServObit@l(11)
	lwz 9,56(11)
	addi 9,9,1
	stw 9,56(11)
.L366:
	lwz 0,20(30)
	lis 9,.LC62@ha
	la 5,.LC62@l(9)
	cmpwi 0,0,0
	bc 4,2,.L368
	lis 29,LOG@ha
	lis 4,.LC30@ha
	lwz 3,LOG@l(29)
	mr 6,25
	la 4,.LC30@l(4)
	addi 7,1,1288
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lwz 3,LOG@l(29)
	lis 4,.LC31@ha
	mr 5,31
	la 4,.LC31@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lis 11,ServObit@ha
	la 11,ServObit@l(11)
	lwz 9,56(11)
	addi 9,9,1
	stw 9,56(11)
.L368:
	mr 3,30
	lwz 0,1588(1)
	mtlr 0
	lmw 24,1552(1)
	la 1,1584(1)
	blr
.Lfe7:
	.size	 ParseObitLine,.Lfe7-ParseObitLine
	.section	".rodata"
	.align 2
.LC63:
	.string	"%d"
	.align 2
.LC64:
	.string	"End"
	.align 2
.LC65:
	.string	"Welcome"
	.align 2
.LC66:
	.string	"Connect"
	.align 2
.LC67:
	.string	"Disconnect"
	.align 2
.LC68:
	.string	"Substitutions"
	.align 2
.LC69:
	.string	"Include"
	.section	".text"
	.align 2
	.globl ServObitCommandParse
	.type	 ServObitCommandParse,@function
ServObitCommandParse:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lbz 0,0(31)
	cmpwi 0,0,32
	li 3,3
	bc 12,2,.L389
	lis 3,.LC64@ha
	mr 4,31
	la 3,.LC64@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,6
	bc 4,2,.L389
	lis 3,.LC65@ha
	mr 4,31
	la 3,.LC65@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,4
	bc 4,2,.L389
	lis 3,.LC66@ha
	mr 4,31
	la 3,.LC66@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,1
	bc 4,2,.L389
	lis 3,.LC67@ha
	mr 4,31
	la 3,.LC67@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	li 3,2
	bc 4,2,.L389
	lis 3,.LC68@ha
	mr 4,31
	la 3,.LC68@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 4,2,.L385
	lis 3,.LC69@ha
	mr 4,31
	la 3,.LC69@l(3)
	bl StrBeginsWith
	srawi 0,3,31
	xor 3,0,3
	subf 3,3,0
	srawi 3,3,31
	nor 0,3,3
	andi. 3,3,9
	rlwinm 0,0,0,29,31
	or 3,3,0
	b .L389
.L385:
	li 3,8
.L389:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 ServObitCommandParse,.Lfe8-ServObitCommandParse
	.lcomm	line.81,512,4
	.lcomm	obit.82,512,4
	.section	".rodata"
	.align 2
.LC70:
	.string	"$H"
	.align 2
.LC71:
	.string	"ERROR"
	.align 2
.LC72:
	.string	"mega-gibbed"
	.align 2
.LC73:
	.string	"gibbed"
	.align 2
.LC74:
	.string	"destroyed"
	.align 2
.LC75:
	.string	"Quad "
	.section	".text"
	.align 2
	.globl FormatObituaryMessage
	.type	 FormatObituaryMessage,@function
FormatObituaryMessage:
	stwu 1,-64(1)
	mflr 0
	stmw 18,8(1)
	stw 0,68(1)
	lis 29,obit.82@ha
	mr 21,3
	mr 22,4
	mr 25,6
	mr 26,7
	mr 20,8
	mr 23,9
	mr 4,5
	la 3,obit.82@l(29)
	li 28,0
	bl strcpy
	li 30,0
	la 3,obit.82@l(29)
	bl PerformSubstitutions
	la 29,obit.82@l(29)
	lbz 0,0(29)
	cmpwi 0,0,0
	bc 12,2,.L409
	lis 9,line.81@ha
	mr 24,29
	la 27,line.81@l(9)
	lis 18,.LC71@ha
.L410:
	lbzx 9,24,28
	addi 0,9,-36
	cmplwi 0,0,1
	bc 4,1,.L411
	stbx 9,27,30
	addi 28,28,1
	addi 30,30,1
	b .L408
.L411:
	add 29,28,24
	lis 3,.LC40@ha
	la 3,.LC40@l(3)
	mr 4,29
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L413
	mr 3,21
	addi 28,28,2
	bl strlen
	mr 29,3
	mr 4,21
	b .L444
.L413:
	lis 3,.LC41@ha
	mr 4,29
	la 3,.LC41@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L415
	mr 3,22
	addi 28,28,2
	bl strlen
	mr 29,3
	mr 4,22
	b .L444
.L415:
	lis 3,.LC70@ha
	mr 4,29
	la 3,.LC70@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L417
	lis 3,.LC42@ha
	mr 4,29
	la 3,.LC42@l(3)
	la 31,.LC71@l(18)
	bl StrBeginsWith
	cmpwi 0,3,0
	mr 3,25
	bc 4,2,.L445
	lis 3,.LC43@ha
	mr 4,29
	la 3,.LC43@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L420
	mr 3,26
.L445:
	li 19,5
	bl GenderToHisHer
	mr 31,3
	b .L419
.L420:
	lis 3,.LC44@ha
	mr 4,29
	la 3,.LC44@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	mr 3,25
	bc 4,2,.L446
	lis 3,.LC45@ha
	mr 4,29
	la 3,.LC45@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L424
	mr 3,26
.L446:
	li 19,5
	bl GenderToHimHer
	mr 31,3
	b .L419
.L424:
	lis 3,.LC46@ha
	mr 4,29
	la 3,.LC46@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	mr 3,26
	bc 4,2,.L447
	lis 3,.LC47@ha
	mr 4,29
	la 3,.LC47@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L428
	mr 3,25
.L447:
	li 19,9
	bl GenderToHimselfHerself
	mr 31,3
	b .L419
.L428:
	lbzx 0,24,28
	addi 28,28,1
	stbx 0,27,30
	addi 30,30,1
.L419:
	mr 3,31
	add 28,28,19
	bl strlen
	mr 29,3
	mr 4,31
.L444:
	add 3,30,27
	mr 5,29
	bl strncpy
	add 30,30,29
	b .L408
.L417:
	lis 3,.LC37@ha
	mr 4,29
	la 3,.LC37@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L431
	lis 3,.LC48@ha
	mr 4,29
	la 3,.LC48@l(3)
	bl StrBeginsWith
	cmpwi 0,3,0
	mr 3,26
	bc 12,2,.L432
	mr 3,25
.L432:
	bl GenderToSheHe
	mr 31,3
	mr 3,31
	add 29,30,27
	bl strlen
	addi 28,28,5
	b .L449
.L431:
	addi 0,28,1
	lbzx 11,24,0
	xori 9,11,71
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,103
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 12,2,.L435
	cmpwi 0,23,3
	bc 4,2,.L436
	lis 9,.LC72@ha
	la 31,.LC72@l(9)
	b .L437
.L436:
	cmpwi 0,23,2
	bc 4,2,.L438
	lis 9,.LC73@ha
	la 31,.LC73@l(9)
	b .L437
.L438:
	lis 9,.LC74@ha
	la 31,.LC74@l(9)
.L437:
	mr 3,31
	add 29,30,27
	bl strlen
	addi 28,28,2
.L449:
	mr 5,3
	mr 4,31
	mr 3,29
	bl strncpy
	mr 3,31
	bl strlen
	add 30,30,3
	b .L408
.L435:
	xori 9,11,113
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,81
	subfic 10,0,0
	adde 0,10,0
	or. 11,0,9
	bc 12,2,.L408
	cmpwi 0,20,2
	bc 4,2,.L442
	lis 4,.LC75@ha
	add 3,30,27
	la 4,.LC75@l(4)
	li 5,5
	bl strncpy
	addi 30,30,5
.L442:
	addi 28,28,2
.L408:
	lbzx 0,24,28
	cmpwi 0,0,0
	bc 4,2,.L410
.L409:
	lis 29,line.81@ha
	li 0,0
	la 29,line.81@l(29)
	mr 3,29
	stbx 0,29,30
	bl FormatBoldString
	mr 3,29
	lwz 0,68(1)
	mtlr 0
	lmw 18,8(1)
	la 1,64(1)
	blr
.Lfe9:
	.size	 FormatObituaryMessage,.Lfe9-FormatObituaryMessage
	.section	".rodata"
	.align 2
.LC76:
	.string	"obits.txt"
	.align 2
.LC77:
	.string	"r"
	.align 2
.LC78:
	.string	"ServObit Error: COULD NOT OPEN SERVOBIT FILE %s!\n"
	.align 2
.LC79:
	.string	"ERROR: Could not open %s!\n"
	.align 2
.LC80:
	.string	"ERROR: Couldn't understand command at line %d.\n"
	.align 2
.LC81:
	.string	"-->%s\n"
	.align 2
.LC82:
	.string	"Warning: Welcome will last default 5 seconds\n"
	.align 2
.LC83:
	.string	""
	.align 2
.LC84:
	.string	"ERROR: line %d: Substitution entry without definition\n"
	.align 2
.LC85:
	.string	"---> %s\n"
	.align 2
.LC86:
	.string	"ERROR: line %d: Substitution exceeded max %d per definition\n"
	.align 2
.LC87:
	.string	"       Set MaxObitMessages in ServObit.ini to a higher number\n"
	.align 2
.LC88:
	.string	"ERROR: line %d; Exceeded maximum number of Connect messages\n"
	.align 2
.LC89:
	.string	"ERROR: line %d; Exceeded maximum number of Disconnect messages\n"
	.align 2
.LC90:
	.string	"ERROR: line %d; Exceeded maximum number of characters in welcome\n"
	.align 2
.LC91:
	.string	"ERROR: ignoring non-comment line %d; expecting command\n"
	.align 2
.LC92:
	.string	"ServObit Error: Exceeded Max Obits %d in line %d\n"
	.align 2
.LC93:
	.string	"\n\n\n\nServObit ERROR: Found %d parse errors.\nCheck SrbObLog.txt\n\n\n\n"
	.align 2
.LC94:
	.string	"ServObit loaded.\n"
	.section	".text"
	.align 2
	.globl ReadServerObits
	.type	 ReadServerObits,@function
ReadServerObits:
	stwu 1,-1600(1)
	mflr 0
	stmw 19,1548(1)
	stw 0,1604(1)
	lis 9,ServObits@ha
	li 22,0
	lwz 11,ServObits@l(9)
	lis 10,ServObitSubstitutionList@ha
	lis 6,.LC76@ha
	lis 4,.LC0@ha
	lis 5,obitsDir@ha
	stw 22,0(11)
	la 4,.LC0@l(4)
	la 5,obitsDir@l(5)
	la 6,.LC76@l(6)
	stw 22,ServObitSubstitutionList@l(10)
	addi 3,1,264
	crxor 6,6,6
	bl sprintf
	li 23,-1
	li 21,0
	addi 31,1,264
	lis 4,.LC77@ha
	mr 3,31
	la 4,.LC77@l(4)
	bl fopen
	lis 19,ServObitSubstitutionList@ha
	mr. 20,3
	bc 4,2,.L452
	lis 9,gi+4@ha
	lis 3,.LC78@ha
	lwz 0,gi+4@l(9)
	mr 4,31
	la 3,.LC78@l(3)
	lis 29,LOG@ha
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 3,LOG@l(29)
	lis 4,.LC79@ha
	mr 5,31
	la 4,.LC79@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	b .L450
.L452:
	li 27,0
	li 25,0
	addi 24,1,520
	b .L453
.L455:
	addi 3,1,8
	li 29,0
	bl strlen
	addi 27,27,1
	addi 31,1,8
	addi 3,3,-1
	stbx 29,31,3
	lbz 0,8(1)
	cmpwi 0,0,35
	bc 12,2,.L453
	mr 3,31
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L453
	lbz 0,8(1)
	cmpwi 0,0,58
	bc 4,2,.L459
	addi 3,1,9
	bl ServObitCommandParse
	mr 28,3
	cmpwi 0,28,7
	bc 4,2,.L460
	lis 29,LOG@ha
	lis 4,.LC80@ha
	lwz 3,LOG@l(29)
	la 4,.LC80@l(4)
	mr 5,27
	li 28,5
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lwz 3,LOG@l(29)
	lis 4,.LC81@ha
	mr 5,31
	la 4,.LC81@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lwz 9,56(30)
	addi 9,9,1
	stw 9,56(30)
	b .L461
.L460:
	cmpwi 0,28,3
	bc 4,2,.L462
	addi 3,1,10
	mr 4,27
	bl ParseObitLine
	addi 23,23,1
	lis 9,ServObits@ha
	slwi 10,23,2
	lwz 11,ServObits@l(9)
	stwx 3,10,11
	b .L461
.L462:
	cmpwi 0,28,8
	bc 12,2,.L461
	cmpwi 0,28,4
	bc 4,2,.L466
	li 29,5
	mr 3,31
	stw 29,24(30)
	bl strlen
	cmplwi 0,3,8
	bc 4,1,.L467
	lis 4,.LC63@ha
	stw 29,24(30)
	addi 3,1,16
	la 4,.LC63@l(4)
	addi 5,30,24
	crxor 6,6,6
	bl sscanf
	cmpwi 0,3,1
	bc 12,2,.L468
	stw 29,24(30)
	b .L473
.L468:
	lwz 0,24(30)
	cmpwi 0,0,0
	bc 12,1,.L470
	li 0,2
	stw 0,24(30)
	b .L473
.L470:
	cmpwi 0,0,998
	bc 4,1,.L473
	li 0,999
	stw 0,24(30)
	b .L473
.L467:
	lis 29,LOG@ha
	lis 4,.LC82@ha
	lwz 3,LOG@l(29)
	la 4,.LC82@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
.L473:
	lis 9,.LC83@ha
	lis 11,ServObit+44@ha
	la 9,.LC83@l(9)
	li 0,0
	stw 9,ServObit+44@l(11)
	stb 0,520(1)
	b .L461
.L466:
	xori 0,28,6
	srawi 11,0,31
	xor 9,11,0
	subf 9,9,11
	srawi 9,9,31
	nor 0,9,9
	and 9,28,9
	andi. 0,0,5
	or 28,9,0
.L461:
	mr 26,28
	b .L453
.L459:
	cmpwi 0,26,8
	bc 4,2,.L477
	cmpwi 0,0,91
	bc 4,2,.L478
	addi 31,1,9
	li 4,93
	mr 3,31
	bl strchr
	mr. 3,3
	bc 12,2,.L479
	stb 29,0(3)
.L479:
	mr 3,31
	li 28,0
	bl strdup
	mr 29,3
	li 3,16
	bl malloc
	mr 31,3
	lwz 3,20(30)
	stw 29,0(31)
	slwi 3,3,2
	stw 28,8(31)
	stw 28,12(31)
	bl malloc
	lwz 0,20(30)
	cmpwi 7,25,0
	li 10,0
	stw 3,4(31)
	cmpw 0,28,0
	bc 4,0,.L484
	mr 5,30
	li 8,0
	li 11,0
.L482:
	lwz 9,4(31)
	addi 10,10,1
	stwx 8,11,9
	lwz 0,20(5)
	addi 11,11,4
	cmpw 0,10,0
	bc 12,0,.L482
.L484:
	bc 12,30,.L485
	stw 31,12(25)
.L485:
	lis 9,ServObitSubstitutionList@ha
	mr 25,31
	lwz 0,ServObitSubstitutionList@l(9)
	cmpwi 0,0,0
	bc 4,2,.L453
	stw 25,ServObitSubstitutionList@l(19)
	b .L453
.L478:
	cmpwi 0,25,0
	bc 4,2,.L489
	lis 29,LOG@ha
	lis 4,.LC84@ha
	lwz 3,LOG@l(29)
	la 4,.LC84@l(4)
	b .L514
.L489:
	lwz 0,8(25)
	lwz 6,8(30)
	cmpw 0,0,6
	bc 12,0,.L491
	lis 29,LOG@ha
	lis 4,.LC86@ha
	lwz 3,LOG@l(29)
	mr 5,27
	la 4,.LC86@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lwz 3,LOG@l(29)
	lis 4,.LC87@ha
	la 4,.LC87@l(4)
	crxor 6,6,6
	bl fprintf
	b .L515
.L491:
	mr 3,31
	bl strdup
	lwz 9,8(25)
	lwz 10,4(25)
	slwi 11,9,2
	stwx 3,11,10
	addi 9,9,1
	stw 9,8(25)
	b .L453
.L477:
	cmpwi 0,26,1
	bc 4,2,.L494
	lwz 0,12(30)
	cmpw 0,21,0
	bc 4,2,.L495
	lis 29,LOG@ha
	lis 4,.LC88@ha
	lwz 3,LOG@l(29)
	la 4,.LC88@l(4)
	b .L514
.L495:
	mr 3,31
	bl strdup
	lwz 11,28(30)
	slwi 9,21,2
	mr 4,27
	addi 21,21,1
	b .L516
.L494:
	cmpwi 0,26,2
	bc 4,2,.L499
	lwz 0,12(30)
	cmpw 0,22,0
	bc 4,2,.L500
	lis 29,LOG@ha
	lis 4,.LC89@ha
	lwz 3,LOG@l(29)
	la 4,.LC89@l(4)
	b .L514
.L500:
	mr 3,31
	bl strdup
	lwz 11,32(30)
	slwi 9,22,2
	mr 4,27
	addi 22,22,1
.L516:
	stwx 3,9,11
	mr 3,31
	bl ComplainInvalidSubstitutions
	mr 3,31
	mr 4,27
	bl ComplainInvalidConnectNameSpecifiers
	b .L453
.L499:
	cmpwi 0,26,4
	bc 4,2,.L504
	mr 3,31
	bl strlen
	li 0,10
	stbx 0,31,3
	mr 3,31
	bl strlen
	stbx 29,31,3
	mr 3,24
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	cmplwi 0,29,1023
	bc 4,1,.L505
	lis 29,LOG@ha
	lis 4,.LC90@ha
	lwz 3,LOG@l(29)
	la 4,.LC90@l(4)
.L514:
	mr 5,27
	crxor 6,6,6
	bl fprintf
.L515:
	lwz 3,LOG@l(29)
	bl fflush
	lwz 3,LOG@l(29)
	lis 4,.LC85@ha
	mr 5,31
	la 4,.LC85@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lwz 9,56(30)
	addi 9,9,1
	stw 9,56(30)
	b .L453
.L505:
	mr 3,24
	bl strlen
	mr 4,31
	add 3,24,3
	bl strcpy
	b .L453
.L504:
	cmpwi 0,26,3
	bc 4,2,.L508
	lis 9,ServObits@ha
	slwi 10,23,2
	lwz 11,ServObits@l(9)
	mr 3,31
	lwzx 29,10,11
	bl strdup
	mr 4,3
	mr 5,27
	mr 3,29
	bl AddMessageToServObit
	b .L453
.L508:
	lwz 9,56(30)
	lis 29,LOG@ha
	lis 4,.LC91@ha
	lwz 3,LOG@l(29)
	la 4,.LC91@l(4)
	mr 5,27
	addi 9,9,1
	stw 9,56(30)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lwz 3,LOG@l(29)
	lis 4,.LC39@ha
	mr 5,31
	la 4,.LC39@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
.L453:
	addi 3,1,8
	li 4,256
	mr 5,20
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L454
	lis 9,ServObit@ha
	la 30,ServObit@l(9)
	lwz 0,16(30)
	cmpw 0,23,0
	bc 12,0,.L455
.L454:
	lis 9,ServObit@ha
	la 30,ServObit@l(9)
	lwz 0,16(30)
	cmpw 0,23,0
	bc 4,2,.L511
	lis 29,LOG@ha
	lis 4,.LC92@ha
	lwz 3,LOG@l(29)
	la 4,.LC92@l(4)
	mr 6,27
	li 5,1000
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lwz 11,16(30)
	lis 9,ServObits@ha
	li 10,0
	lwz 0,ServObits@l(9)
	slwi 11,11,2
	add 11,11,0
	stw 10,-4(11)
	lwz 9,56(30)
	addi 9,9,1
	stw 9,56(30)
	b .L512
.L511:
	lis 9,ServObits@ha
	slwi 10,23,2
	lwz 11,ServObits@l(9)
	li 0,0
	stwx 0,10,11
.L512:
	mr 3,20
	bl fclose
	lis 29,ServObit@ha
	mr 3,24
	la 29,ServObit@l(29)
	stw 21,36(29)
	stw 22,40(29)
	bl strdup
	lwz 4,56(29)
	stw 3,44(29)
	cmpwi 0,4,0
	bc 12,2,.L513
	lis 9,gi+4@ha
	lis 3,.LC93@ha
	lwz 0,gi+4@l(9)
	la 3,.LC93@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L513:
	lis 9,gi+4@ha
	lis 3,.LC94@ha
	lwz 0,gi+4@l(9)
	la 3,.LC94@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L450:
	lwz 0,1604(1)
	mtlr 0
	lmw 19,1548(1)
	la 1,1600(1)
	blr
.Lfe10:
	.size	 ReadServerObits,.Lfe10-ReadServerObits
	.align 2
	.globl FormatConnectMessage
	.type	 FormatConnectMessage,@function
FormatConnectMessage:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 29,3
	mr 30,4
	mr 27,5
	mr 25,6
	li 28,0
	bl PerformSubstitutions
	li 31,0
	stb 28,0(30)
	lis 9,.LC33@ha
	lbzx 0,29,28
	la 26,.LC33@l(9)
	cmpwi 0,0,0
	bc 12,2,.L526
.L520:
	mr 3,26
	add 4,29,31
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L521
	mr 3,27
	bl strlen
	add 3,31,3
	cmplwi 0,3,1024
	bc 4,0,.L524
	mr 4,27
	add 3,30,28
	bl strcpy
	mr 3,27
	bl strlen
	add 28,28,3
	mr 3,26
	bl strlen
	add 31,31,3
	b .L518
.L521:
	lbzx 0,29,31
	addi 31,31,1
	stbx 0,30,28
	addi 28,28,1
.L518:
	lbzx 0,29,31
	cmpwi 7,31,1024
	neg 0,0
	srwi 0,0,31
	mfcr 9
	rlwinm 9,9,29,1
	and. 11,0,9
	bc 4,2,.L520
.L526:
	cmpwi 0,28,1024
	bc 4,0,.L527
	li 0,0
	stbx 0,30,28
	b .L524
.L527:
	li 0,0
	stb 0,1023(30)
.L524:
	mr 4,30
	mr 3,29
	bl strcpy
	li 28,0
	li 31,0
	mr 3,25
	bl GenderToHimHer
	stb 28,0(30)
	lis 9,.LC35@ha
	mr 27,3
	lbzx 0,29,28
	la 26,.LC35@l(9)
	cmpwi 0,0,0
	bc 12,2,.L537
.L531:
	mr 3,26
	add 4,29,31
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L532
	mr 3,27
	bl strlen
	add 3,31,3
	cmplwi 0,3,1024
	bc 4,0,.L535
	mr 4,27
	add 3,30,28
	bl strcpy
	mr 3,27
	bl strlen
	add 28,28,3
	mr 3,26
	bl strlen
	add 31,31,3
	b .L529
.L532:
	lbzx 0,29,31
	addi 31,31,1
	stbx 0,30,28
	addi 28,28,1
.L529:
	lbzx 0,29,31
	cmpwi 7,31,1024
	neg 0,0
	srwi 0,0,31
	mfcr 9
	rlwinm 9,9,29,1
	and. 11,0,9
	bc 4,2,.L531
.L537:
	cmpwi 0,28,1024
	bc 4,0,.L538
	li 0,0
	stbx 0,30,28
	b .L535
.L538:
	li 0,0
	stb 0,1023(30)
.L535:
	mr 4,30
	mr 3,29
	bl strcpy
	li 28,0
	li 31,0
	mr 3,25
	bl GenderToHisHer
	stb 28,0(30)
	lis 9,.LC34@ha
	mr 27,3
	lbzx 0,29,28
	la 26,.LC34@l(9)
	cmpwi 0,0,0
	bc 12,2,.L548
.L542:
	mr 3,26
	add 4,29,31
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L543
	mr 3,27
	bl strlen
	add 3,31,3
	cmplwi 0,3,1024
	bc 4,0,.L546
	mr 4,27
	add 3,30,28
	bl strcpy
	mr 3,27
	bl strlen
	add 28,28,3
	mr 3,26
	bl strlen
	add 31,31,3
	b .L540
.L543:
	lbzx 0,29,31
	addi 31,31,1
	stbx 0,30,28
	addi 28,28,1
.L540:
	lbzx 0,29,31
	cmpwi 7,31,1024
	neg 0,0
	srwi 0,0,31
	mfcr 9
	rlwinm 9,9,29,1
	and. 11,0,9
	bc 4,2,.L542
.L548:
	cmpwi 0,28,1024
	bc 4,0,.L549
	li 0,0
	stbx 0,30,28
	b .L546
.L549:
	li 0,0
	stb 0,1023(30)
.L546:
	mr 4,30
	mr 3,29
	bl strcpy
	li 28,0
	li 31,0
	mr 3,25
	bl GenderToSheHe
	stb 28,0(30)
	lis 9,.LC37@ha
	mr 27,3
	lbzx 0,29,28
	la 26,.LC37@l(9)
	cmpwi 0,0,0
	bc 12,2,.L559
.L553:
	mr 3,26
	add 4,29,31
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L554
	mr 3,27
	bl strlen
	add 3,31,3
	cmplwi 0,3,1024
	bc 4,0,.L557
	mr 4,27
	add 3,30,28
	bl strcpy
	mr 3,27
	bl strlen
	add 28,28,3
	mr 3,26
	bl strlen
	add 31,31,3
	b .L551
.L554:
	lbzx 0,29,31
	addi 31,31,1
	stbx 0,30,28
	addi 28,28,1
.L551:
	lbzx 0,29,31
	cmpwi 7,31,1024
	neg 0,0
	srwi 0,0,31
	mfcr 9
	rlwinm 9,9,29,1
	and. 11,0,9
	bc 4,2,.L553
.L559:
	cmpwi 0,28,1024
	bc 4,0,.L560
	li 0,0
	stbx 0,30,28
	b .L557
.L560:
	li 0,0
	stb 0,1023(30)
.L557:
	mr 4,30
	mr 3,29
	bl strcpy
	li 28,0
	li 31,0
	mr 3,25
	bl GenderToHimselfHerself
	stb 28,0(30)
	lis 9,.LC36@ha
	mr 27,3
	lbzx 0,29,28
	la 26,.LC36@l(9)
	cmpwi 0,0,0
	bc 12,2,.L570
.L564:
	mr 3,26
	add 4,29,31
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L565
	mr 3,27
	bl strlen
	add 3,31,3
	cmplwi 0,3,1024
	bc 4,0,.L568
	mr 4,27
	add 3,30,28
	bl strcpy
	mr 3,27
	bl strlen
	add 28,28,3
	mr 3,26
	bl strlen
	add 31,31,3
	b .L562
.L565:
	lbzx 0,29,31
	addi 31,31,1
	stbx 0,30,28
	addi 28,28,1
.L562:
	lbzx 0,29,31
	cmpwi 7,31,1024
	neg 0,0
	srwi 0,0,31
	mfcr 9
	rlwinm 9,9,29,1
	and. 11,0,9
	bc 4,2,.L564
.L570:
	cmpwi 0,28,1024
	bc 4,0,.L571
	li 0,0
	stbx 0,30,28
	b .L568
.L571:
	li 0,0
	stb 0,1023(30)
.L568:
	mr 3,30
	bl FormatBoldString
	li 9,10
	li 0,0
	stb 0,1023(30)
	stb 9,1022(30)
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe11:
	.size	 FormatConnectMessage,.Lfe11-FormatConnectMessage
	.section	".rodata"
	.align 2
.LC95:
	.string	"%s\n"
	.align 2
.LC96:
	.string	"%s killed %s\n"
	.align 2
.LC97:
	.string	"%s decided to end it all\n"
	.align 2
.LC98:
	.string	"%s became one with the map\n"
	.align 2
.LC99:
	.string	"%s died for unknown reasons\n"
	.section	".text"
	.align 2
	.globl DisplayObituary
	.type	 DisplayObituary,@function
DisplayObituary:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 11,ServObits@ha
	mr 30,3
	lwz 11,ServObits@l(11)
	mr 25,4
	mr 27,6
	mr 28,7
	mr 29,9
	lwz 0,0(11)
	mr 31,10
	cmpwi 0,0,0
	bc 12,2,.L575
	mr 6,11
	li 4,0
.L577:
	lwz 7,0(6)
	mr 26,4
	lwz 10,4(7)
	xori 0,10,80
	addic 3,10,-1
	subfe 11,3,10
	addic 3,0,-1
	subfe 9,3,0
	and. 0,11,9
	bc 12,2,.L579
	cmpw 0,8,10
	bc 4,2,.L606
.L579:
	lwz 0,0(7)
	cmplwi 0,0,1
	bc 4,1,.L581
	cmpw 0,0,5
	bc 4,2,.L606
.L581:
	lwz 10,12(7)
	xori 0,10,4
	addic 3,10,-1
	subfe 11,3,10
	addic 3,0,-1
	subfe 9,3,0
	and. 0,11,9
	bc 12,2,.L583
	cmpw 0,10,27
	bc 4,2,.L606
.L583:
	lwz 10,16(7)
	xori 0,10,4
	addic 3,10,-1
	subfe 11,3,10
	addic 3,0,-1
	subfe 9,3,0
	and. 0,11,9
	bc 12,2,.L585
	cmpw 0,10,28
	bc 4,2,.L606
.L585:
	lwz 10,20(7)
	xori 0,10,4
	addic 3,10,-1
	subfe 11,3,10
	addic 3,0,-1
	subfe 9,3,0
	and. 0,11,9
	bc 12,2,.L587
	cmpwi 0,10,4
	bc 4,2,.L588
	li 0,1
	b .L589
.L588:
	cmpw 7,10,31
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
.L589:
	cmpwi 0,0,0
	bc 4,2,.L587
.L606:
	li 9,0
	b .L580
.L587:
	lwz 0,8(7)
	li 9,1
	cmplwi 0,0,1
	bc 4,1,.L580
	xor 9,0,29
	subfic 3,9,0
	adde 9,3,9
.L580:
	cmpwi 0,9,0
	bc 12,2,.L576
	lwz 9,0(6)
	lwz 0,28(9)
	cmpwi 0,0,0
	bc 4,2,.L605
.L576:
	lwzu 0,4(6)
	addi 4,4,4
	cmpwi 0,0,0
	bc 4,2,.L577
.L575:
	cmpwi 0,5,3
	bc 4,2,.L598
	lis 9,gi@ha
	lis 4,.LC96@ha
	lwz 0,gi@l(9)
	la 4,.LC96@l(4)
	mr 5,25
	mr 6,30
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L599
.L598:
	cmpwi 0,5,2
	bc 4,2,.L600
	lis 9,gi@ha
	lis 4,.LC97@ha
	lwz 0,gi@l(9)
	la 4,.LC97@l(4)
	b .L607
.L600:
	cmpwi 0,5,4
	bc 4,2,.L602
	lis 9,gi@ha
	lis 4,.LC98@ha
	lwz 0,gi@l(9)
	la 4,.LC98@l(4)
.L607:
	mr 5,30
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L599
.L605:
	bl rand
	lis 9,ServObits@ha
	mr 11,3
	lwz 10,ServObits@l(9)
	mr 8,29
	mr 4,25
	mr 9,31
	mr 7,28
	lwzx 5,26,10
	mr 6,27
	mr 3,30
	lwz 10,28(5)
	lwz 29,24(5)
	divw 0,11,10
	mullw 0,0,10
	subf 11,0,11
	slwi 11,11,2
	lwzx 5,11,29
	bl FormatObituaryMessage
	lis 9,gi@ha
	mr 5,3
	lwz 0,gi@l(9)
	lis 4,.LC95@ha
	li 3,1
	la 4,.LC95@l(4)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,2
	b .L604
.L602:
	lis 9,gi@ha
	lis 4,.LC99@ha
	lwz 0,gi@l(9)
	la 4,.LC99@l(4)
	mr 5,30
	li 3,1
	mtlr 0
	crxor 6,6,6
	blrl
.L599:
	li 3,1
.L604:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe12:
	.size	 DisplayObituary,.Lfe12-DisplayObituary
	.section	".rodata"
	.align 2
.LC100:
	.string	"ServObit.ini"
	.align 2
.LC101:
	.string	"ServObit Error: Couldn't open %s.\n                Using default values.\n"
	.align 2
.LC102:
	.string	"="
	.align 2
.LC103:
	.string	"MaxConnectMessages"
	.align 2
.LC104:
	.string	"ServObit Warning: Set MaxConnectMessages to 5\n"
	.align 2
.LC105:
	.string	"MaxSelectors"
	.align 2
.LC106:
	.string	"ServObit Warning: Set MaxSelectors to 500\n"
	.align 2
.LC107:
	.string	"MaxObitMessages"
	.align 2
.LC108:
	.string	"ServObit Warning: Set MaxObitMessages to 10\n"
	.align 2
.LC109:
	.string	"MaxSubstitutions"
	.align 2
.LC110:
	.string	"ServObit Warning: Set MaxSubstitutions to 5\n"
	.section	".text"
	.align 2
	.globl ReadServObitInitFile
	.type	 ReadServObitInitFile,@function
ReadServObitInitFile:
	stwu 1,-816(1)
	mflr 0
	stmw 25,788(1)
	stw 0,820(1)
	addi 3,1,264
	lis 6,.LC100@ha
	lis 4,.LC0@ha
	lis 5,obitsDir@ha
	la 4,.LC0@l(4)
	la 6,.LC100@l(6)
	la 5,obitsDir@l(5)
	mr 31,3
	crxor 6,6,6
	bl sprintf
	lis 4,.LC77@ha
	mr 3,31
	la 4,.LC77@l(4)
	bl fopen
	mr. 25,3
	bc 4,2,.L610
	lis 9,gi+4@ha
	lis 3,.LC101@ha
	lwz 0,gi+4@l(9)
	la 3,.LC101@l(3)
	mr 4,31
	mtlr 0
	crxor 6,6,6
	blrl
	b .L608
.L610:
	lis 9,ServObit@ha
	lis 28,LOG@ha
	la 26,ServObit@l(9)
	b .L611
.L613:
	addi 3,1,8
	li 27,0
	bl strlen
	addi 29,1,8
	addi 3,3,-1
	stbx 27,29,3
	lbz 0,8(1)
	cmpwi 0,0,35
	bc 12,2,.L611
	cmpwi 0,0,0
	bc 12,2,.L611
	lis 4,.LC102@ha
	mr 3,29
	la 4,.LC102@l(4)
	bl strcspn
	mr 31,3
	lbzx 0,29,31
	cmpwi 0,0,0
	bc 12,2,.L611
	addi 30,1,520
	mr 4,29
	stbx 27,29,31
	mr 3,30
	bl strcpy
	add 3,29,31
	addi 3,3,1
	bl atoi
	mr 31,3
	lis 4,.LC103@ha
	la 4,.LC103@l(4)
	mr 3,30
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L617
	cmpwi 0,31,4
	bc 12,1,.L618
	lwz 3,LOG@l(28)
	lis 4,.LC104@ha
	li 31,5
	la 4,.LC104@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(28)
	bl fflush
.L618:
	stw 31,12(26)
	b .L611
.L617:
	lis 4,.LC105@ha
	mr 3,30
	la 4,.LC105@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L620
	cmpwi 0,31,499
	bc 12,1,.L621
	lwz 3,LOG@l(28)
	lis 4,.LC106@ha
	li 31,500
	la 4,.LC106@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(28)
	bl fflush
.L621:
	stw 31,16(26)
	b .L611
.L620:
	lis 4,.LC107@ha
	mr 3,30
	la 4,.LC107@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L623
	cmpwi 0,31,9
	bc 12,1,.L624
	lwz 3,LOG@l(28)
	lis 4,.LC108@ha
	li 31,10
	la 4,.LC108@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(28)
	bl fflush
.L624:
	stw 31,8(26)
	b .L611
.L623:
	lis 4,.LC109@ha
	mr 3,30
	la 4,.LC109@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L611
	cmpwi 0,31,4
	bc 12,1,.L627
	lwz 3,LOG@l(28)
	lis 4,.LC110@ha
	li 31,5
	la 4,.LC110@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(28)
	bl fflush
.L627:
	stw 31,20(26)
.L611:
	addi 3,1,8
	li 4,256
	mr 5,25
	bl fgets
	cmpwi 0,3,0
	bc 4,2,.L613
.L608:
	lwz 0,820(1)
	mtlr 0
	lmw 25,788(1)
	la 1,816(1)
	blr
.Lfe13:
	.size	 ReadServObitInitFile,.Lfe13-ReadServObitInitFile
	.section	".rodata"
	.align 2
.LC111:
	.string	"ServObit 1.4"
	.section	".text"
	.align 2
	.globl InitServObitData
	.type	 InitServObitData,@function
InitServObitData:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 29,ServObit@ha
	lis 9,.LC111@ha
	la 29,ServObit@l(29)
	la 9,.LC111@l(9)
	stw 9,44(29)
	li 11,20
	li 10,5
	li 9,1000
	li 0,-80
	stw 11,8(29)
	stw 9,16(29)
	lis 28,ServObits@ha
	stw 10,20(29)
	stw 11,12(29)
	stw 10,24(29)
	stw 0,48(29)
	bl ReadServObitInitFile
	lwz 3,12(29)
	slwi 3,3,2
	bl malloc
	lwz 0,12(29)
	stw 3,28(29)
	slwi 3,0,2
	bl malloc
	lwz 0,16(29)
	stw 3,32(29)
	slwi 3,0,2
	bl malloc
	stw 3,ServObits@l(28)
	li 9,-1
	li 0,0
	stw 0,56(29)
	stw 9,36(29)
	stw 9,40(29)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 InitServObitData,.Lfe14-InitServObitData
	.section	".rodata"
	.align 2
.LC112:
	.string	"SrvObLog.txt"
	.align 2
.LC113:
	.string	"w"
	.align 2
.LC114:
	.string	"\n\n\n\nServObit ERROR: Could not open log file %s!\n\n\n\n"
	.comm	highscore,1080,4
	.comm	gamescore,540,4
	.comm	ServObit,60,4
	.section	".text"
	.align 2
	.globl ServObitInsertValue
	.type	 ServObitInsertValue,@function
ServObitInsertValue:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	li 24,0
	mr 27,3
	mr 28,7
	mr 29,4
	stb 24,0(27)
	lbzx 0,29,24
	cmpw 7,24,28
	mr 25,5
	mr 26,6
	li 31,0
	neg 0,0
	li 30,0
	b .L634
.L13:
	mr 3,25
	add 4,29,31
	bl StrBeginsWith
	cmpwi 0,3,0
	bc 12,2,.L14
	mr 3,26
	bl strlen
	add 3,31,3
	cmplw 0,3,28
	bc 4,0,.L15
	mr 4,26
	add 3,27,30
	bl strcpy
	addi 24,24,1
	mr 3,26
	bl strlen
	add 30,30,3
	mr 3,25
	bl strlen
	add 31,31,3
	b .L11
.L15:
	li 3,-1
	b .L633
.L14:
	lbzx 0,29,31
	addi 31,31,1
	stbx 0,27,30
	addi 30,30,1
.L11:
	lbzx 0,29,31
	cmpw 7,31,28
	neg 0,0
.L634:
	srwi 0,0,31
	mfcr 9
	rlwinm 9,9,29,1
	and. 11,0,9
	bc 4,2,.L13
	cmpw 0,30,28
	bc 4,0,.L19
	li 0,0
	stbx 0,27,30
	b .L20
.L19:
	add 9,28,27
	li 0,0
	stb 0,-1(9)
.L20:
	mr 3,24
.L633:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 ServObitInsertValue,.Lfe15-ServObitInsertValue
	.align 2
	.globl IsEnvironmentWeapon
	.type	 IsEnvironmentWeapon,@function
IsEnvironmentWeapon:
	addi 3,3,-50
	subfic 3,3,10
	li 3,0
	adde 3,3,3
	blr
.Lfe16:
	.size	 IsEnvironmentWeapon,.Lfe16-IsEnvironmentWeapon
	.align 2
	.globl IsEnemyWeapon
	.type	 IsEnemyWeapon,@function
IsEnemyWeapon:
	addi 3,3,-1
	subfic 3,3,22
	li 3,0
	adde 3,3,3
	blr
.Lfe17:
	.size	 IsEnemyWeapon,.Lfe17-IsEnemyWeapon
	.align 2
	.globl InitializeServObit
	.type	 InitializeServObit,@function
InitializeServObit:
	stwu 1,-272(1)
	mflr 0
	stmw 30,264(1)
	stw 0,276(1)
	addi 31,1,8
	lis 6,.LC112@ha
	lis 4,.LC0@ha
	lis 5,obitsDir@ha
	la 4,.LC0@l(4)
	la 6,.LC112@l(6)
	la 5,obitsDir@l(5)
	mr 3,31
	crxor 6,6,6
	bl sprintf
	lis 30,LOG@ha
	lis 4,.LC113@ha
	mr 3,31
	la 4,.LC113@l(4)
	bl fopen
	cmpwi 0,3,0
	stw 3,LOG@l(30)
	bc 4,2,.L632
	lis 9,gi+4@ha
	lis 3,.LC114@ha
	lwz 0,gi+4@l(9)
	la 3,.LC114@l(3)
	mr 4,31
	mtlr 0
	crxor 6,6,6
	blrl
	b .L630
.L632:
	bl InitServObitData
	bl ReadServerObits
	lwz 3,LOG@l(30)
	bl fclose
.L630:
	lwz 0,276(1)
	mtlr 0
	lmw 30,264(1)
	la 1,272(1)
	blr
.Lfe18:
	.size	 InitializeServObit,.Lfe18-InitializeServObit
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
	.comm	LOG,4,4
	.comm	ServObits,4,4
	.comm	ServObitSubstitutionList,4,4
	.align 2
	.globl IsTokenSeparator
	.type	 IsTokenSeparator,@function
IsTokenSeparator:
	xori 9,3,32
	subfic 0,9,0
	adde 9,0,9
	xori 0,3,9
	subfic 11,0,0
	adde 0,11,0
	or. 11,9,0
	bc 4,2,.L8
	cmpwi 0,3,10
	bc 4,2,.L7
.L8:
	li 3,1
	blr
.L7:
	li 3,0
	blr
.Lfe19:
	.size	 IsTokenSeparator,.Lfe19-IsTokenSeparator
	.align 2
	.globl WriteServObitPathname
	.type	 WriteServObitPathname,@function
WriteServObitPathname:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 6,4
	lis 5,obitsDir@ha
	lis 4,.LC0@ha
	la 5,obitsDir@l(5)
	la 4,.LC0@l(4)
	crxor 6,6,6
	bl sprintf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe20:
	.size	 WriteServObitPathname,.Lfe20-WriteServObitPathname
	.align 2
	.globl BodyStateSameOrWorseThan
	.type	 BodyStateSameOrWorseThan,@function
BodyStateSameOrWorseThan:
	cmpwi 0,4,4
	bc 12,2,.L25
	cmpw 7,4,3
	cror 31,30,28
	mfcr 3
	rlwinm 3,3,0,1
	blr
.L25:
	li 3,1
	blr
.Lfe21:
	.size	 BodyStateSameOrWorseThan,.Lfe21-BodyStateSameOrWorseThan
	.align 2
	.globl FindServObitSubstitution
	.type	 FindServObitSubstitution,@function
FindServObitSubstitution:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,ServObitSubstitutionList@ha
	mr 30,3
	lwz 31,ServObitSubstitutionList@l(9)
	cmpwi 0,31,0
	bc 12,2,.L31
.L32:
	lwz 4,0(31)
	mr 3,30
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L33
	mr 3,31
	b .L637
.L33:
	lwz 31,12(31)
	cmpwi 0,31,0
	bc 4,2,.L32
.L31:
	li 3,0
.L637:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe22:
	.size	 FindServObitSubstitution,.Lfe22-FindServObitSubstitution
	.align 2
	.globl GetRandomSubstitution
	.type	 GetRandomSubstitution,@function
GetRandomSubstitution:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,ServObitSubstitutionList@ha
	mr 30,3
	lwz 31,ServObitSubstitutionList@l(9)
	cmpwi 0,31,0
	bc 12,2,.L41
.L38:
	lwz 4,0(31)
	mr 3,30
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L40
	lwz 31,12(31)
	cmpwi 0,31,0
	bc 4,2,.L38
.L41:
	li 31,0
.L40:
	cmpwi 0,31,0
	bc 12,2,.L44
	lwz 0,8(31)
	cmpwi 0,0,0
	bc 12,2,.L44
	bl rand
	lwz 9,8(31)
	lwz 11,4(31)
	divw 0,3,9
	mullw 0,0,9
	subf 3,0,3
	slwi 3,3,2
	lwzx 3,3,11
	b .L638
.L44:
	li 3,0
.L638:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe23:
	.size	 GetRandomSubstitution,.Lfe23-GetRandomSubstitution
	.align 2
	.globl MakeServObitSubstitution
	.type	 MakeServObitSubstitution,@function
MakeServObitSubstitution:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	mr 28,4
	li 3,16
	bl malloc
	lis 9,ServObit@ha
	mr 31,3
	la 30,ServObit@l(9)
	li 0,0
	stw 29,0(31)
	lwz 3,20(30)
	stw 0,12(31)
	stw 0,8(31)
	slwi 3,3,2
	bl malloc
	lwz 0,20(30)
	li 10,0
	stw 3,4(31)
	cmpw 0,10,0
	bc 4,0,.L77
	mr 7,30
	li 8,0
	li 11,0
.L79:
	lwz 9,4(31)
	addi 10,10,1
	stwx 8,11,9
	lwz 0,20(7)
	addi 11,11,4
	cmpw 0,10,0
	bc 12,0,.L79
.L77:
	cmpwi 0,28,0
	bc 12,2,.L81
	stw 31,12(28)
.L81:
	mr 3,31
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 MakeServObitSubstitution,.Lfe24-MakeServObitSubstitution
	.align 2
	.globl ConvertObitBodyStateSpec
	.type	 ConvertObitBodyStateSpec,@function
ConvertObitBodyStateSpec:
	lbz 3,0(3)
	cmpwi 0,3,42
	bc 4,2,.L83
	li 3,4
	blr
.L83:
	xori 9,3,77
	subfic 0,9,0
	adde 9,0,9
	xori 0,3,109
	subfic 11,0,0
	adde 0,11,0
	or. 11,9,0
	bc 12,2,.L85
	li 3,3
	blr
.L85:
	xori 9,3,71
	subfic 0,9,0
	adde 9,0,9
	xori 0,3,103
	subfic 11,0,0
	adde 0,11,0
	or. 11,9,0
	bc 4,2,.L87
	xori 0,3,110
	subfic 9,0,0
	adde 0,9,0
	xori 3,3,78
	subfic 11,3,0
	adde 3,11,3
	or 3,3,0
	blr
.L87:
	li 3,2
	blr
.Lfe25:
	.size	 ConvertObitBodyStateSpec,.Lfe25-ConvertObitBodyStateSpec
	.align 2
	.globl ConvertObitPowerSpec
	.type	 ConvertObitPowerSpec,@function
ConvertObitPowerSpec:
	lbz 3,0(3)
	cmpwi 0,3,42
	bc 4,2,.L92
	li 3,1
	blr
.L92:
	xori 9,3,81
	subfic 0,9,0
	adde 9,0,9
	xori 0,3,113
	subfic 11,0,0
	adde 0,11,0
	or. 11,9,0
	bc 4,2,.L94
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
.L94:
	li 3,2
	blr
.Lfe26:
	.size	 ConvertObitPowerSpec,.Lfe26-ConvertObitPowerSpec
	.align 2
	.globl ConvertObitKillerSpec
	.type	 ConvertObitKillerSpec,@function
ConvertObitKillerSpec:
	lbz 3,0(3)
	xori 9,3,83
	subfic 0,9,0
	adde 9,0,9
	xori 0,3,115
	subfic 11,0,0
	adde 0,11,0
	or. 11,9,0
	bc 12,2,.L99
	li 3,2
	blr
.L99:
	xori 9,3,69
	subfic 0,9,0
	adde 9,0,9
	xori 0,3,101
	subfic 11,0,0
	adde 0,11,0
	or. 11,9,0
	bc 12,2,.L101
	li 3,3
	blr
.L101:
	xori 9,3,87
	subfic 0,9,0
	adde 9,0,9
	xori 0,3,119
	subfic 11,0,0
	adde 0,11,0
	or. 11,9,0
	bc 4,2,.L103
	xori 3,3,42
	subfic 0,3,0
	adde 3,0,3
	blr
.L103:
	li 3,4
	blr
.Lfe27:
	.size	 ConvertObitKillerSpec,.Lfe27-ConvertObitKillerSpec
	.align 2
	.globl ComplainInvalidServObitInput
	.type	 ComplainInvalidServObitInput,@function
ComplainInvalidServObitInput:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	cmpwi 0,3,0
	mr 0,6
	mr 31,4
	mr 6,7
	bc 4,2,.L170
	lis 29,LOG@ha
	lis 4,.LC30@ha
	lwz 3,LOG@l(29)
	mr 7,0
	la 4,.LC30@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lwz 3,LOG@l(29)
	lis 4,.LC31@ha
	mr 5,31
	la 4,.LC31@l(4)
	crxor 6,6,6
	bl fprintf
	lwz 3,LOG@l(29)
	bl fflush
	lis 11,ServObit@ha
	li 3,1
	la 11,ServObit@l(11)
	lwz 9,56(11)
	addi 9,9,1
	stw 9,56(11)
.L170:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe28:
	.size	 ComplainInvalidServObitInput,.Lfe28-ComplainInvalidServObitInput
	.align 2
	.globl ComplainInvalidServObitMessageSpecifiers
	.type	 ComplainInvalidServObitMessageSpecifiers,@function
ComplainInvalidServObitMessageSpecifiers:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	mr 28,4
	bl ComplainInvalidSubstitutions
	mr 3,29
	mr 4,28
	bl ComplainInvalidNameSpecifiers
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 ComplainInvalidServObitMessageSpecifiers,.Lfe29-ComplainInvalidServObitMessageSpecifiers
	.align 2
	.globl ComplainInvalidServObitConnectMessageSpecifiers
	.type	 ComplainInvalidServObitConnectMessageSpecifiers,@function
ComplainInvalidServObitConnectMessageSpecifiers:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	mr 28,4
	bl ComplainInvalidSubstitutions
	mr 3,29
	mr 4,28
	bl ComplainInvalidConnectNameSpecifiers
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 ComplainInvalidServObitConnectMessageSpecifiers,.Lfe30-ComplainInvalidServObitConnectMessageSpecifiers
	.align 2
	.globl ParseWelcomeDisplayTime
	.type	 ParseWelcomeDisplayTime,@function
ParseWelcomeDisplayTime:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,ServObit@ha
	li 30,5
	la 31,ServObit@l(9)
	lis 4,.LC63@ha
	la 4,.LC63@l(4)
	stw 30,24(31)
	addi 5,31,24
	crxor 6,6,6
	bl sscanf
	cmpwi 0,3,1
	bc 12,2,.L370
	stw 30,24(31)
	b .L369
.L370:
	lwz 0,24(31)
	cmpwi 0,0,0
	bc 12,1,.L371
	li 0,2
	b .L643
.L371:
	cmpwi 0,0,998
	bc 4,1,.L369
	li 0,999
.L643:
	stw 0,24(31)
.L369:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe31:
	.size	 ParseWelcomeDisplayTime,.Lfe31-ParseWelcomeDisplayTime
	.align 2
	.globl MatchObituary
	.type	 MatchObituary,@function
MatchObituary:
	stwu 1,-16(1)
	stw 31,12(1)
	lwz 12,4(3)
	mr 31,8
	xori 0,12,80
	addic 8,12,-1
	subfe 10,8,12
	addic 8,0,-1
	subfe 11,8,0
	mr 8,9
	and. 9,10,11
	bc 12,2,.L391
	cmpw 0,7,12
	bc 4,2,.L645
.L391:
	lwz 0,0(3)
	cmplwi 0,0,1
	bc 4,1,.L392
	cmpw 0,0,4
	bc 4,2,.L645
.L392:
	lwz 10,12(3)
	xori 0,10,4
	addic 7,10,-1
	subfe 11,7,10
	addic 7,0,-1
	subfe 9,7,0
	and. 0,11,9
	bc 12,2,.L394
	cmpw 0,10,5
	bc 4,2,.L645
.L394:
	lwz 10,16(3)
	xori 0,10,4
	addic 7,10,-1
	subfe 11,7,10
	addic 7,0,-1
	subfe 9,7,0
	and. 0,11,9
	bc 12,2,.L396
	cmpw 0,10,6
	bc 4,2,.L645
.L396:
	lwz 10,20(3)
	xori 0,10,4
	addic 7,10,-1
	subfe 11,7,10
	addic 7,0,-1
	subfe 9,7,0
	and. 0,11,9
	bc 12,2,.L398
	cmpwi 0,10,4
	bc 4,2,.L400
	li 0,1
	b .L401
.L400:
	cmpw 7,10,8
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
.L401:
	cmpwi 0,0,0
	bc 4,2,.L398
.L645:
	li 3,0
	b .L644
.L398:
	lwz 3,8(3)
	cmplwi 0,3,1
	bc 4,1,.L405
	cmpw 0,3,31
	li 3,0
	bc 4,2,.L644
.L405:
	li 3,1
.L644:
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe32:
	.size	 MatchObituary,.Lfe32-MatchObituary
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
