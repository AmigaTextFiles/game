	.file	"menu.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 menuList,@object
	.size	 menuList,4
menuList:
	.long 0
	.section	".text"
	.align 2
	.globl Chicken_MenuInsert
	.type	 Chicken_MenuInsert,@function
Chicken_MenuInsert:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi+132@ha
	mr 30,3
	lwz 0,gi+132@l(9)
	li 3,12
	li 4,765
	mtlr 0
	blrl
	mr. 31,3
	bc 4,2,.L23
	li 3,-1
	bl exit
.L23:
	mr 3,31
	li 4,0
	li 5,12
	crxor 6,6,6
	bl memset
	lis 9,menuList@ha
	stw 30,0(31)
	lwz 0,menuList@l(9)
	cmpwi 0,0,0
	bc 4,2,.L25
	stw 31,menuList@l(9)
	b .L24
.L25:
	mr 9,0
	li 11,0
	lwz 0,0(9)
	cmpw 0,0,30
	bc 4,0,.L32
	lwz 0,8(9)
	mr 3,30
	cmpwi 0,0,0
	bc 12,2,.L28
	mr 10,3
.L29:
	mr 11,9
	lwz 9,8(11)
	lwz 0,0(9)
	cmpw 0,0,10
	bc 4,0,.L32
	lwz 0,8(9)
	cmpwi 0,0,0
	bc 4,2,.L29
.L28:
	lwz 0,0(9)
	cmpw 0,0,3
	bc 4,0,.L32
	lwz 0,8(9)
	stw 0,8(31)
	stw 31,8(9)
	b .L24
.L32:
	cmpwi 0,11,0
	bc 12,2,.L34
	lis 9,menuList@ha
	lwz 0,menuList@l(9)
	stw 0,8(31)
	stw 31,menuList@l(9)
	b .L24
.L34:
	lwz 0,8(11)
	stw 0,8(31)
	stw 31,8(11)
.L24:
	li 3,0
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe1:
	.size	 Chicken_MenuInsert,.Lfe1-Chicken_MenuInsert
	.align 2
	.globl Chicken_MenuItemInsert
	.type	 Chicken_MenuItemInsert,@function
Chicken_MenuItemInsert:
	stwu 1,-176(1)
	mflr 0
	stmw 25,148(1)
	stw 0,180(1)
	stw 9,32(1)
	lis 0,0x600
	addi 11,1,184
	addi 9,1,8
	stw 0,128(1)
	mr 28,4
	stw 11,132(1)
	mr 27,5
	mr 26,6
	stw 9,136(1)
	mr 25,7
	stw 10,36(1)
	bc 4,6,.L43
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L43:
	lis 9,menuList@ha
	mr 31,8
	lwz 29,menuList@l(9)
	cmpwi 7,28,20
	b .L211
.L46:
	lwz 29,8(29)
.L211:
	cmpwi 0,29,0
	bc 12,2,.L48
	lwz 0,0(29)
	cmpw 0,0,3
	bc 4,2,.L46
.L48:
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	addic 11,29,-1
	subfe 0,11,29
	and. 11,0,9
	bc 12,2,.L50
	lis 9,gi+132@ha
	li 3,44
	lwz 0,gi+132@l(9)
	li 4,765
	mtlr 0
	blrl
	mr. 30,3
	bc 4,2,.L51
	li 3,-1
	bl exit
.L51:
	mr 3,30
	li 4,0
	li 5,44
	crxor 6,6,6
	bl memset
	stb 28,0(30)
	addi 10,1,128
	cmplwi 0,31,4
	stw 27,4(30)
	addi 8,1,112
	stw 26,8(30)
	stw 25,12(30)
	stw 31,16(30)
	lwz 0,128(1)
	lwz 9,8(10)
	lwz 11,4(10)
	stw 0,112(1)
	stw 9,8(8)
	stw 11,4(8)
	bc 12,1,.L197
	lis 11,.L198@ha
	slwi 10,31,2
	la 11,.L198@l(11)
	lis 9,.L198@ha
	lwzx 0,10,11
	la 9,.L198@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L198:
	.long .L66-.L198
	.long .L93-.L198
	.long .L188-.L198
	.long .L168-.L198
	.long .L53-.L198
.L66:
	lbz 11,112(1)
	cmplwi 0,11,7
	bc 12,1,.L71
	addi 9,11,1
	lwz 0,120(1)
	slwi 11,11,2
	stb 9,112(1)
	add 9,0,11
	b .L60
.L71:
	lwz 9,116(1)
	addi 0,9,4
	stw 0,116(1)
.L60:
	lwz 0,0(9)
	stw 0,20(30)
	lbz 11,112(1)
	cmplwi 0,11,7
	bc 12,1,.L90
	addi 9,11,1
	lwz 0,120(1)
	slwi 11,11,2
	stb 9,112(1)
	add 9,0,11
	b .L79
.L90:
	lwz 9,116(1)
	addi 0,9,4
	stw 0,116(1)
.L79:
	lwz 0,0(9)
	stw 0,24(30)
	b .L53
.L93:
	li 0,0
	stw 0,32(30)
	lbz 11,112(1)
	cmplwi 0,11,7
	bc 12,1,.L110
	addi 9,11,1
	lwz 0,120(1)
	slwi 11,11,2
	stb 9,112(1)
	add 9,0,11
	b .L99
.L110:
	lwz 9,116(1)
	addi 0,9,4
	stw 0,116(1)
.L99:
	lwz 0,0(9)
	stw 0,20(30)
	lbz 11,112(1)
	cmplwi 0,11,7
	bc 12,1,.L129
	addi 9,11,1
	lwz 0,120(1)
	slwi 11,11,2
	stb 9,112(1)
	add 9,0,11
	b .L118
.L129:
	lwz 9,116(1)
	addi 0,9,4
	stw 0,116(1)
.L118:
	lwz 31,0(9)
	cmpwi 0,31,-1
	bc 12,2,.L133
	addi 28,30,20
.L134:
	lwz 9,32(30)
	lwz 3,24(30)
	addi 9,9,1
	slwi 4,9,2
	stw 9,32(30)
	bl realloc
	cmpwi 0,3,0
	stw 3,4(28)
	bc 4,2,.L135
	li 3,-1
	bl exit
.L135:
	lwz 9,32(30)
	lwz 0,24(30)
	slwi 9,9,2
	add 9,9,0
	stw 31,-4(9)
	lbz 11,112(1)
	cmplwi 0,11,7
	bc 12,1,.L152
	addi 9,11,1
	lwz 0,120(1)
	slwi 11,11,2
	stb 9,112(1)
	add 9,0,11
	b .L141
.L152:
	lwz 9,116(1)
	addi 0,9,4
	stw 0,116(1)
.L141:
	lwz 31,0(9)
	cmpwi 0,31,-1
	bc 4,2,.L134
.L133:
	lwz 9,28(30)
	lwz 10,24(30)
	slwi 9,9,2
	lwz 11,20(30)
	lwzx 0,9,10
	stw 0,0(11)
	b .L53
.L168:
	lbz 11,112(1)
	cmplwi 0,11,7
	bc 4,1,.L212
	b .L193
.L188:
	lbz 11,112(1)
	cmplwi 0,11,7
	bc 12,1,.L193
.L212:
	addi 9,11,1
	lwz 0,120(1)
	slwi 11,11,2
	stb 9,112(1)
	add 9,0,11
	b .L182
.L193:
	lwz 9,116(1)
	addi 0,9,4
	stw 0,116(1)
.L182:
	lwz 0,0(9)
	stw 0,20(30)
	b .L53
.L197:
	li 3,-1
	bl exit
.L53:
	lwz 0,4(29)
	cmpwi 0,0,0
	mr 7,0
	bc 4,2,.L199
	stw 30,4(29)
	b .L50
.L199:
	lbz 0,0(30)
	mr 11,7
	lbz 9,0(11)
	rlwinm 10,0,0,0xff
	mr 8,0
	cmplw 0,9,10
	bc 4,0,.L206
	lwz 0,36(11)
	cmpwi 0,0,0
	bc 12,2,.L202
	mr 9,10
.L203:
	lwz 11,36(11)
	lbz 0,0(11)
	cmplw 0,0,9
	bc 4,0,.L206
	lwz 0,36(11)
	cmpwi 0,0,0
	bc 4,2,.L203
.L202:
	lbz 0,0(11)
	cmplw 0,0,8
	bc 4,0,.L206
	lwz 0,36(11)
	stw 11,40(30)
	stw 0,36(30)
	lwz 9,36(11)
	cmpwi 0,9,0
	bc 12,2,.L207
	stw 30,40(9)
.L207:
	stw 30,36(11)
	b .L50
.L206:
	lwz 9,40(11)
	cmpwi 0,9,0
	bc 12,2,.L209
	stw 7,36(30)
	lwz 9,4(29)
	stw 30,40(9)
	stw 30,4(29)
	b .L50
.L209:
	stw 30,36(9)
	stw 11,40(30)
	lwz 0,36(11)
	stw 0,36(30)
	stw 30,40(11)
.L50:
	li 3,0
	lwz 0,180(1)
	mtlr 0
	lmw 25,148(1)
	la 1,176(1)
	blr
.Lfe2:
	.size	 Chicken_MenuItemInsert,.Lfe2-Chicken_MenuItemInsert
	.section	".rodata"
	.align 2
.LC0:
	.string	"%s turned %s off\n"
	.align 2
.LC1:
	.string	"someone"
	.align 2
.LC2:
	.string	"%s turned %s on\n"
	.align 2
.LC3:
	.string	"%s changed %s to %d\n"
	.section	".text"
	.align 2
	.globl Chicken_MenuItemSelect
	.type	 Chicken_MenuItemSelect,@function
Chicken_MenuItemSelect:
	stwu 1,-80(1)
	mflr 0
	stmw 30,72(1)
	stw 0,84(1)
	mr 31,3
	li 30,0
	lwz 11,84(31)
	lwz 9,3756(11)
	lwz 10,16(9)
	cmplwi 0,10,4
	bc 12,1,.L263
	lis 11,.L264@ha
	slwi 10,10,2
	la 11,.L264@l(11)
	lis 9,.L264@ha
	lwzx 0,10,11
	la 9,.L264@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L264:
	.long .L241-.L264
	.long .L248-.L264
	.long .L261-.L264
	.long .L251-.L264
	.long .L240-.L264
.L241:
	lwz 9,84(31)
	lwz 11,3756(9)
	lwz 9,20(11)
	lwz 0,0(9)
	cmpwi 0,0,0
	bc 12,2,.L242
	li 0,0
	stw 0,0(9)
	lwz 5,84(31)
	cmpwi 0,5,0
	bc 12,2,.L243
	addi 5,5,700
	b .L244
.L243:
	lis 9,.LC1@ha
	la 5,.LC1@l(9)
.L244:
	lwz 11,84(31)
	lis 4,.LC0@ha
	addi 3,1,8
	la 4,.LC0@l(4)
	lwz 9,3756(11)
	lwz 6,4(9)
	crxor 6,6,6
	bl sprintf
	b .L265
.L242:
	li 0,1
	stw 0,0(9)
	lwz 5,84(31)
	cmpwi 0,5,0
	bc 12,2,.L246
	addi 5,5,700
	b .L247
.L246:
	lis 9,.LC1@ha
	la 5,.LC1@l(9)
.L247:
	lwz 11,84(31)
	lis 4,.LC2@ha
	addi 3,1,8
	la 4,.LC2@l(4)
	lwz 9,3756(11)
	lwz 6,4(9)
	crxor 6,6,6
	bl sprintf
	b .L265
.L248:
	lwz 11,84(31)
	lwz 10,3756(11)
	lwz 9,28(10)
	addi 9,9,1
	stw 9,28(10)
	lwz 11,84(31)
	lwz 10,3756(11)
	lwz 9,28(10)
	lwz 11,32(10)
	divw 0,9,11
	mullw 0,0,11
	subf 9,0,9
	stw 9,28(10)
	lwz 11,84(31)
	lwz 9,3756(11)
	lwz 10,28(9)
	lwz 8,24(9)
	slwi 10,10,2
	lwz 11,20(9)
	lwzx 0,10,8
	stw 0,0(11)
	lwz 5,84(31)
	cmpwi 0,5,0
	bc 12,2,.L249
	addi 5,5,700
	b .L250
.L249:
	lis 9,.LC1@ha
	la 5,.LC1@l(9)
.L250:
	lwz 10,84(31)
	lis 4,.LC3@ha
	addi 3,1,8
	la 4,.LC3@l(4)
	lwz 9,3756(10)
	lwz 11,20(9)
	lwz 6,4(9)
	lwz 7,0(11)
	crxor 6,6,6
	bl sprintf
.L265:
	lis 9,gi@ha
	li 3,2
	lwz 0,gi@l(9)
	addi 4,1,8
	mtlr 0
	crxor 6,6,6
	blrl
	b .L240
.L251:
	lwz 9,84(31)
	lwz 11,3756(9)
	lwz 3,20(11)
	bl MenuFind
	lwz 9,84(31)
	cmpwi 0,3,0
	stw 3,3752(9)
	bc 12,2,.L240
	lwz 9,84(31)
	li 11,0
	lwz 3,3752(9)
	mr 10,9
	cmpwi 0,3,0
	bc 12,2,.L253
	lwz 11,4(3)
	b .L266
.L256:
	lwz 11,36(11)
.L266:
	cmpwi 0,11,0
	bc 12,2,.L253
	lwz 0,16(11)
	cmpwi 0,0,4
	bc 12,2,.L256
.L253:
	stw 11,3756(10)
	b .L240
.L261:
	lwz 11,84(31)
	mr 3,31
	lwz 9,3756(11)
	lwz 0,20(9)
	mtlr 0
	blrl
	mr 30,3
	b .L240
.L263:
	li 3,-1
	bl exit
.L240:
	mr 3,30
	lwz 0,84(1)
	mtlr 0
	lmw 30,72(1)
	la 1,80(1)
	blr
.Lfe3:
	.size	 Chicken_MenuItemSelect,.Lfe3-Chicken_MenuItemSelect
	.section	".rodata"
	.align 2
.LC4:
	.string	"xv 32 yv 12 picn chicken_options "
	.align 2
.LC5:
	.string	"yv %d xv %d "
	.align 2
.LC6:
	.string	"%s \"%-*.*s%-*.*s\" "
	.align 2
.LC7:
	.string	"string "
	.align 2
.LC8:
	.string	"string2"
	.align 2
.LC9:
	.string	" "
	.align 2
.LC10:
	.string	"%s \"%-*.*s\" "
	.align 2
.LC11:
	.string	"%s \"%*.*s\" "
	.align 2
.LC12:
	.string	"%s \"%-1s%-*.*s%-*.*s%-*.*s %3s\" "
	.align 2
.LC13:
	.string	"\r"
	.align 2
.LC14:
	.string	"on"
	.align 2
.LC15:
	.string	"off"
	.align 2
.LC16:
	.string	"%s \"%-1s%-*.*s %3s\" "
	.align 2
.LC17:
	.string	"%s \"%-1s%*.*s %3s\" "
	.align 2
.LC18:
	.string	"%s \"%-1s%-*.*s%-*.*s%-*.*s %3d\" "
	.align 2
.LC19:
	.string	"%s \"%-1s%-*.*s %3d\" "
	.align 2
.LC20:
	.string	"%s \"%-1s%*.*s %3d\" "
	.section	".text"
	.align 2
	.globl Chicken_MenuDisplay
	.type	 Chicken_MenuDisplay,@function
Chicken_MenuDisplay:
	stwu 1,-1472(1)
	mflr 0
	stmw 27,1452(1)
	stw 0,1476(1)
	mr 27,3
	lwz 9,84(27)
	lwz 9,3752(9)
	cmpwi 0,9,0
	bc 12,2,.L268
	lis 4,.LC4@ha
	lwz 31,4(9)
	addi 3,1,32
	la 4,.LC4@l(4)
	crxor 6,6,6
	bl sprintf
	cmpwi 0,31,0
	bc 12,2,.L270
.L271:
	lwz 3,4(31)
	cmpwi 0,3,0
	bc 12,2,.L272
	bl strlen
	mr 28,3
	b .L273
.L272:
	li 28,0
.L273:
	addi 3,1,32
	mr 29,3
	bl strlen
	mr 30,29
	lbz 5,0(31)
	lis 4,.LC5@ha
	add 3,29,3
	la 4,.LC5@l(4)
	li 6,50
	slwi 5,5,3
	addi 5,5,32
	crxor 6,6,6
	bl sprintf
	lwz 10,16(31)
	cmplwi 0,10,4
	bc 12,1,.L274
	lis 11,.L367@ha
	slwi 10,10,2
	la 11,.L367@l(11)
	lis 9,.L367@ha
	lwzx 0,10,11
	la 9,.L367@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L367:
	.long .L293-.L367
	.long .L348-.L367
	.long .L293-.L367
	.long .L293-.L367
	.long .L275-.L367
.L275:
	lwz 0,12(31)
	cmpwi 0,0,1
	bc 12,2,.L277
	cmplwi 0,0,1
	bc 12,0,.L281
	cmpwi 0,0,2
	bc 12,2,.L285
	b .L274
.L277:
	addi 3,1,32
	bl strlen
	lwz 0,8(31)
	add 3,30,3
	cmpwi 0,0,0
	bc 4,2,.L278
	lis 9,.LC7@ha
	la 5,.LC7@l(9)
	b .L279
.L278:
	lis 9,.LC8@ha
	la 5,.LC8@l(9)
.L279:
	lwz 11,4(31)
	subfic 0,28,27
	lis 10,.LC9@ha
	srwi 9,0,31
	stw 11,8(1)
	add 0,0,9
	lwz 11,4(31)
	srawi 6,0,1
	cmpwi 0,11,0
	bc 4,2,.L280
	la 0,.LC9@l(10)
	stw 0,8(1)
.L280:
	mr 9,28
	lis 4,.LC6@ha
	lis 8,.LC9@ha
	la 4,.LC6@l(4)
	la 8,.LC9@l(8)
	mr 7,6
	mr 10,9
	crxor 6,6,6
	bl sprintf
	b .L274
.L281:
	addi 3,1,32
	bl strlen
	lwz 0,8(31)
	add 3,30,3
	cmpwi 0,0,0
	bc 4,2,.L282
	lis 9,.LC7@ha
	la 5,.LC7@l(9)
	b .L283
.L282:
	lis 9,.LC8@ha
	la 5,.LC8@l(9)
.L283:
	lwz 8,4(31)
	cmpwi 0,8,0
	bc 4,2,.L284
	lis 9,.LC9@ha
	la 8,.LC9@l(9)
.L284:
	lis 4,.LC10@ha
	li 6,27
	la 4,.LC10@l(4)
	b .L370
.L285:
	addi 3,1,32
	bl strlen
	lwz 0,8(31)
	add 3,30,3
	cmpwi 0,0,0
	bc 4,2,.L286
	lis 9,.LC7@ha
	la 5,.LC7@l(9)
	b .L287
.L286:
	lis 9,.LC8@ha
	la 5,.LC8@l(9)
.L287:
	lwz 8,4(31)
	cmpwi 0,8,0
	bc 4,2,.L288
	lis 9,.LC9@ha
	la 8,.LC9@l(9)
.L288:
	lis 4,.LC11@ha
	li 6,27
	la 4,.LC11@l(4)
.L370:
	li 7,27
	crxor 6,6,6
	bl sprintf
	b .L274
.L293:
	lwz 0,12(31)
	cmpwi 0,0,1
	bc 12,2,.L295
	cmplwi 0,0,1
	bc 12,0,.L312
	cmpwi 0,0,2
	bc 12,2,.L329
	b .L274
.L295:
	addi 3,1,32
	bl strlen
	lwz 0,8(31)
	add 3,30,3
	cmpwi 0,0,0
	bc 4,2,.L296
	lis 9,.LC7@ha
	la 5,.LC7@l(9)
	b .L297
.L296:
	lis 9,.LC8@ha
	la 5,.LC8@l(9)
.L297:
	lwz 9,84(27)
	lwz 0,3756(9)
	cmpw 0,31,0
	bc 4,2,.L298
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L299
.L298:
	lis 9,.LC9@ha
	la 6,.LC9@l(9)
.L299:
	stw 28,8(1)
	subfic 0,28,22
	lwz 11,16(31)
	mr 10,0
	srwi 9,0,31
	add 0,0,9
	cmpwi 0,11,0
	srawi 7,0,1
	bc 4,2,.L300
	lwz 9,20(31)
	lwz 0,0(9)
	cmpwi 0,0,0
	bc 12,2,.L302
	lwz 0,24(31)
	stw 0,12(1)
	lwz 9,24(31)
	cmpwi 0,9,0
	bc 4,2,.L301
.L302:
.L300:
	lwz 0,4(31)
	stw 0,12(1)
	lwz 9,4(31)
	cmpwi 0,9,0
	bc 4,2,.L301
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	stw 9,12(1)
.L301:
	srwi 0,10,31
	lis 9,.LC9@ha
	add 0,10,0
	la 11,.LC9@l(9)
	srawi 0,0,1
	stw 11,24(1)
	stw 0,20(1)
	stw 0,16(1)
	lwz 9,16(31)
	cmpwi 0,9,0
	bc 4,2,.L308
	lwz 9,20(31)
	lwz 0,0(9)
	cmpwi 0,0,0
	bc 12,2,.L310
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	stw 9,28(1)
	b .L309
.L310:
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	stw 9,28(1)
	b .L309
.L308:
	stw 11,28(1)
.L309:
	lis 4,.LC12@ha
	lis 9,.LC9@ha
	la 4,.LC12@l(4)
	la 9,.LC9@l(9)
	mr 10,28
	mr 8,7
	crxor 6,6,6
	bl sprintf
	b .L274
.L312:
	addi 3,1,32
	bl strlen
	lwz 0,8(31)
	add 3,30,3
	cmpwi 0,0,0
	bc 4,2,.L313
	lis 9,.LC7@ha
	la 5,.LC7@l(9)
	b .L314
.L313:
	lis 9,.LC8@ha
	la 5,.LC8@l(9)
.L314:
	lwz 9,84(27)
	lwz 0,3756(9)
	cmpw 0,31,0
	bc 4,2,.L315
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L316
.L315:
	lis 9,.LC9@ha
	la 6,.LC9@l(9)
.L316:
	lwz 0,16(31)
	cmpwi 0,0,0
	mr 10,0
	bc 4,2,.L317
	lwz 9,20(31)
	lwz 0,0(9)
	cmpwi 0,0,0
	bc 12,2,.L319
	lwz 11,24(31)
	cmpwi 0,11,0
	bc 4,2,.L318
.L319:
.L317:
	lwz 11,4(31)
	cmpwi 0,11,0
	bc 4,2,.L318
	lis 9,.LC9@ha
	la 11,.LC9@l(9)
.L318:
	cmpwi 0,10,0
	bc 4,2,.L325
	lwz 9,20(31)
	lwz 0,0(9)
	cmpwi 0,0,0
	bc 12,2,.L327
	lis 9,.LC14@ha
	la 10,.LC14@l(9)
	b .L326
.L327:
	lis 9,.LC15@ha
	la 10,.LC15@l(9)
	b .L326
.L325:
	lis 9,.LC9@ha
	la 10,.LC9@l(9)
.L326:
	lis 4,.LC16@ha
	mr 9,11
	la 4,.LC16@l(4)
	b .L371
.L329:
	addi 3,1,32
	bl strlen
	lwz 0,8(31)
	add 3,30,3
	cmpwi 0,0,0
	bc 4,2,.L330
	lis 9,.LC7@ha
	la 5,.LC7@l(9)
	b .L331
.L330:
	lis 9,.LC8@ha
	la 5,.LC8@l(9)
.L331:
	lwz 9,84(27)
	lwz 0,3756(9)
	cmpw 0,31,0
	bc 4,2,.L332
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L333
.L332:
	lis 9,.LC9@ha
	la 6,.LC9@l(9)
.L333:
	lwz 0,16(31)
	cmpwi 0,0,0
	mr 10,0
	bc 4,2,.L334
	lwz 9,20(31)
	lwz 0,0(9)
	cmpwi 0,0,0
	bc 12,2,.L336
	lwz 11,24(31)
	cmpwi 0,11,0
	bc 4,2,.L335
.L336:
.L334:
	lwz 11,4(31)
	cmpwi 0,11,0
	bc 4,2,.L335
	lis 9,.LC9@ha
	la 11,.LC9@l(9)
.L335:
	cmpwi 0,10,0
	bc 4,2,.L342
	lwz 9,20(31)
	lwz 0,0(9)
	cmpwi 0,0,0
	bc 12,2,.L344
	lis 9,.LC14@ha
	la 10,.LC14@l(9)
	b .L343
.L344:
	lis 9,.LC15@ha
	la 10,.LC15@l(9)
	b .L343
.L342:
	lis 9,.LC9@ha
	la 10,.LC9@l(9)
.L343:
	lis 4,.LC17@ha
	mr 9,11
	la 4,.LC17@l(4)
.L371:
	li 7,22
	li 8,22
	crxor 6,6,6
	bl sprintf
	b .L274
.L348:
	lwz 0,12(31)
	cmpwi 0,0,1
	bc 12,2,.L350
	cmplwi 0,0,1
	bc 12,0,.L355
	cmpwi 0,0,2
	bc 12,2,.L360
	b .L274
.L350:
	addi 3,1,32
	bl strlen
	lwz 0,8(31)
	add 3,30,3
	cmpwi 0,0,0
	bc 4,2,.L351
	lis 9,.LC7@ha
	la 5,.LC7@l(9)
	b .L352
.L351:
	lis 9,.LC8@ha
	la 5,.LC8@l(9)
.L352:
	lwz 9,84(27)
	lwz 0,3756(9)
	cmpw 0,31,0
	bc 4,2,.L353
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L354
.L353:
	lis 9,.LC9@ha
	la 6,.LC9@l(9)
.L354:
	subfic 0,28,22
	stw 28,8(1)
	lis 9,.LC9@ha
	srwi 11,0,31
	lwz 10,4(31)
	la 9,.LC9@l(9)
	add 0,0,11
	stw 9,24(1)
	lis 4,.LC18@ha
	srawi 0,0,1
	stw 10,12(1)
	la 4,.LC18@l(4)
	stw 0,16(1)
	mr 7,0
	mr 10,28
	stw 0,20(1)
	mr 8,7
	lwz 11,20(31)
	lwz 0,0(11)
	stw 0,28(1)
	crxor 6,6,6
	bl sprintf
	b .L274
.L355:
	addi 3,1,32
	bl strlen
	lwz 0,8(31)
	add 3,30,3
	cmpwi 0,0,0
	bc 4,2,.L356
	lis 9,.LC7@ha
	la 5,.LC7@l(9)
	b .L357
.L356:
	lis 9,.LC8@ha
	la 5,.LC8@l(9)
.L357:
	lwz 9,84(27)
	lwz 0,3756(9)
	cmpw 0,31,0
	bc 4,2,.L358
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L359
.L358:
	lis 9,.LC9@ha
	la 6,.LC9@l(9)
.L359:
	lwz 11,20(31)
	lis 4,.LC19@ha
	li 7,22
	lwz 9,4(31)
	la 4,.LC19@l(4)
	li 8,22
	lwz 10,0(11)
	crxor 6,6,6
	bl sprintf
	b .L274
.L360:
	addi 3,1,32
	bl strlen
	lwz 0,8(31)
	add 3,30,3
	cmpwi 0,0,0
	bc 4,2,.L361
	lis 9,.LC7@ha
	la 5,.LC7@l(9)
	b .L362
.L361:
	lis 9,.LC8@ha
	la 5,.LC8@l(9)
.L362:
	lwz 9,84(27)
	lwz 0,3756(9)
	cmpw 0,31,0
	bc 4,2,.L363
	lis 9,.LC13@ha
	la 6,.LC13@l(9)
	b .L364
.L363:
	lis 9,.LC9@ha
	la 6,.LC9@l(9)
.L364:
	lwz 11,20(31)
	lis 4,.LC20@ha
	li 7,22
	lwz 9,4(31)
	la 4,.LC20@l(4)
	li 8,22
	lwz 10,0(11)
	crxor 6,6,6
	bl sprintf
.L274:
	lwz 31,36(31)
	cmpwi 0,31,0
	bc 4,2,.L271
.L270:
	lis 29,gi@ha
	li 3,4
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,116(29)
	addi 3,1,32
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,27
	li 4,0
	mtlr 0
	blrl
.L268:
	lwz 0,1476(1)
	mtlr 0
	lmw 27,1452(1)
	la 1,1472(1)
	blr
.Lfe4:
	.size	 Chicken_MenuDisplay,.Lfe4-Chicken_MenuDisplay
	.align 2
	.globl Chicken_MenuSelect
	.type	 Chicken_MenuSelect,@function
Chicken_MenuSelect:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	mr 3,4
	bl MenuFind
	lwz 9,84(31)
	cmpwi 0,3,0
	stw 3,3752(9)
	bc 12,2,.L14
	lwz 9,84(31)
	li 11,0
	lwz 9,3752(9)
	cmpwi 0,9,0
	bc 12,2,.L15
	lwz 11,4(9)
	b .L372
.L18:
	lwz 11,36(11)
.L372:
	cmpwi 0,11,0
	bc 12,2,.L15
	lwz 0,16(11)
	cmpwi 0,0,4
	bc 12,2,.L18
.L15:
	lwz 9,84(31)
	stw 11,3756(9)
.L14:
	lwz 9,84(31)
	lwz 0,3752(9)
	addic 9,0,-1
	subfe 3,9,0
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 Chicken_MenuSelect,.Lfe5-Chicken_MenuSelect
	.align 2
	.globl Chicken_MenuItemPrev
	.type	 Chicken_MenuItemPrev,@function
Chicken_MenuItemPrev:
	lwz 11,84(3)
	lwz 9,3756(11)
	cmpwi 0,9,0
	bclr 12,2
	lwz 9,40(9)
	cmpwi 0,9,0
	bc 4,2,.L373
	lwz 9,3752(11)
	lwz 9,4(9)
	b .L375
.L227:
	lwz 9,36(9)
.L375:
	lwz 0,36(9)
	cmpwi 0,0,0
	bc 4,2,.L227
	cmpwi 0,9,0
	bc 12,2,.L230
.L373:
	lwz 0,16(9)
	cmpwi 0,0,4
	bc 4,2,.L230
	mr 10,11
.L231:
	lwz 9,40(9)
	cmpwi 0,9,0
	bc 4,2,.L374
	lwz 9,3752(10)
	lwz 9,4(9)
	b .L376
.L236:
	lwz 9,36(9)
.L376:
	lwz 0,36(9)
	cmpwi 0,0,0
	bc 4,2,.L236
	cmpwi 0,9,0
	bc 12,2,.L230
.L374:
	lwz 0,16(9)
	cmpwi 0,0,4
	bc 12,2,.L231
.L230:
	stw 9,3756(11)
	blr
.Lfe6:
	.size	 Chicken_MenuItemPrev,.Lfe6-Chicken_MenuItemPrev
	.align 2
	.globl Chicken_MenuItemNext
	.type	 Chicken_MenuItemNext,@function
Chicken_MenuItemNext:
	lwz 11,84(3)
	lwz 9,3756(11)
	cmpwi 0,9,0
	bclr 12,2
	lwz 9,36(9)
	cmpwi 0,9,0
	bc 4,2,.L377
	lwz 9,3752(11)
	mr 10,11
	lwz 9,4(9)
	cmpwi 0,9,0
	bc 12,2,.L217
.L377:
	lwz 0,16(9)
	mr 10,11
	cmpwi 0,0,4
	bc 4,2,.L217
.L218:
	lwz 9,36(9)
	cmpwi 0,9,0
	bc 4,2,.L378
	lwz 9,3752(11)
	lwz 9,4(9)
	cmpwi 0,9,0
	bc 12,2,.L217
.L378:
	lwz 0,16(9)
	cmpwi 0,0,4
	bc 12,2,.L218
.L217:
	stw 9,3756(10)
	blr
.Lfe7:
	.size	 Chicken_MenuItemNext,.Lfe7-Chicken_MenuItemNext
	.align 2
	.type	 MenuFind,@function
MenuFind:
	lis 9,menuList@ha
	mr 11,3
	lwz 3,menuList@l(9)
	cmpwi 0,3,0
	bclr 12,2
	lwz 0,0(3)
	cmpw 0,0,11
	bclr 12,2
.L39:
	lwz 3,8(3)
	cmpwi 0,3,0
	bclr 12,2
	lwz 0,0(3)
	cmpw 0,0,11
	bc 4,2,.L39
	blr
.Lfe8:
	.size	 MenuFind,.Lfe8-MenuFind
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
