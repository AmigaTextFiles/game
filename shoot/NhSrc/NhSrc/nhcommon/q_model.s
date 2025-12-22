	.file	"q_model.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 stuff_light,@object
	.size	 stuff_light,4
stuff_light:
	.long 1
	.section	".rodata"
	.align 2
.LC0:
	.string	"predator_model"
	.align 2
.LC1:
	.string	"nhpred"
	.align 2
.LC2:
	.string	"predator_skin"
	.align 2
.LC3:
	.string	"marine_model"
	.align 2
.LC4:
	.string	"male"
	.align 2
.LC5:
	.string	"marine_skin"
	.align 2
.LC6:
	.string	"nightops"
	.section	".text"
	.align 2
	.globl initSkins
	.type	 initSkins,@function
initSkins:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,predator_model@ha
	lwz 3,predator_model@l(9)
	lwz 0,16(3)
	cmpwi 0,0,0
	bc 12,2,.L39
	lwz 3,4(3)
	cmpwi 0,3,0
	bc 12,2,.L40
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L39
.L40:
	lis 9,gi+148@ha
	lis 3,.LC0@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC0@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L39:
	lis 9,predator_skin@ha
	lis 11,predator_model@ha
	lwz 3,predator_skin@l(9)
	lwz 10,predator_model@l(11)
	lwz 0,16(3)
	lwz 31,4(10)
	cmpwi 0,0,0
	bc 12,2,.L44
	lwz 3,4(3)
	cmpwi 0,3,0
	bc 12,2,.L45
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L44
.L45:
	lis 9,gi+148@ha
	lis 3,.LC2@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC2@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L44:
	lis 11,predator_skin@ha
	mr 3,31
	lwz 9,predator_skin@l(11)
	lwz 4,4(9)
	bl setLivePredatorSkin
	bl setDefaultMarineSkin
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe1:
	.size	 initSkins,.Lfe1-initSkins
	.section	".rodata"
	.align 2
.LC7:
	.string	"%s/%s"
	.align 2
.LC8:
	.string	"female/jungle"
	.align 2
.LC9:
	.string	"male/nightops"
	.section	".text"
	.align 2
	.globl setDefaultMarineSkin
	.type	 setDefaultMarineSkin,@function
setDefaultMarineSkin:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,marine_model@ha
	lis 31,marine_model@ha
	lwz 3,marine_model@l(9)
	lwz 0,16(3)
	cmpwi 0,0,0
	bc 12,2,.L56
	lwz 3,4(3)
	cmpwi 0,3,0
	bc 12,2,.L57
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L56
.L57:
	lis 9,gi+148@ha
	lis 3,.LC3@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC4@ha
	la 3,.LC3@l(3)
	la 4,.LC4@l(4)
	mtlr 0
	blrl
.L56:
	lis 9,marine_model@ha
	lis 3,predatorSkin@ha
	lwz 11,marine_model@l(9)
	la 3,predatorSkin@l(3)
	lwz 4,4(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L55
	lwz 3,marine_model@l(31)
	lwz 0,16(3)
	cmpwi 0,0,0
	bc 12,2,.L62
	lwz 3,4(3)
	cmpwi 0,3,0
	bc 12,2,.L63
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L62
.L63:
	lis 9,gi+148@ha
	lis 3,.LC3@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC4@ha
	la 3,.LC3@l(3)
	la 4,.LC4@l(4)
	mtlr 0
	blrl
.L62:
	lis 9,marine_model@ha
	lis 4,.LC4@ha
	lwz 11,marine_model@l(9)
	la 4,.LC4@l(4)
	lwz 3,4(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L61
	lis 3,marineSkin@ha
	lis 4,.LC8@ha
	la 3,marineSkin@l(3)
	la 4,.LC8@l(4)
	crxor 6,6,6
	bl sprintf
	b .L68
.L61:
	lis 3,marineSkin@ha
	lis 4,.LC9@ha
	la 3,marineSkin@l(3)
	la 4,.LC9@l(4)
	crxor 6,6,6
	bl sprintf
	b .L68
.L55:
	lwz 3,marine_model@l(31)
	lwz 0,16(3)
	cmpwi 0,0,0
	bc 12,2,.L69
	lwz 3,4(3)
	cmpwi 0,3,0
	bc 12,2,.L70
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L69
.L70:
	lis 9,gi+148@ha
	lis 3,.LC3@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC4@ha
	la 3,.LC3@l(3)
	la 4,.LC4@l(4)
	mtlr 0
	blrl
.L69:
	lis 9,marine_skin@ha
	lis 11,marine_model@ha
	lwz 3,marine_skin@l(9)
	lwz 10,marine_model@l(11)
	lwz 0,16(3)
	lwz 31,4(10)
	cmpwi 0,0,0
	bc 12,2,.L74
	lwz 3,4(3)
	cmpwi 0,3,0
	bc 12,2,.L75
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L74
.L75:
	lis 9,gi+148@ha
	lis 3,.LC5@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC6@ha
	la 3,.LC5@l(3)
	la 4,.LC6@l(4)
	mtlr 0
	blrl
.L74:
	lis 9,marine_skin@ha
	lis 3,marineSkin@ha
	lwz 11,marine_skin@l(9)
	lis 4,.LC7@ha
	la 3,marineSkin@l(3)
	la 4,.LC7@l(4)
	mr 5,31
	lwz 6,4(11)
	crxor 6,6,6
	bl sprintf
.L68:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe2:
	.size	 setDefaultMarineSkin,.Lfe2-setDefaultMarineSkin
	.section	".rodata"
	.align 2
.LC10:
	.string	"skin"
	.align 2
.LC11:
	.string	"%s\\%s"
	.align 2
.LC12:
	.string	"/"
	.align 2
.LC13:
	.string	""
	.string	""
	.comm	showscores,4,4
	.comm	nextdynamicset,4,4
	.comm	predatorModel,32,4
	.comm	predatorSkin,64,4
	.comm	marineSkin,64,4
	.section	".text"
	.align 2
	.globl validatePredatorModel
	.type	 validatePredatorModel,@function
validatePredatorModel:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,predator_model@ha
	lwz 11,predator_model@l(9)
	lwz 3,4(11)
	cmpwi 0,3,0
	bc 12,2,.L8
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L7
.L8:
	lis 9,gi+148@ha
	lis 3,.LC0@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC0@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L7:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe3:
	.size	 validatePredatorModel,.Lfe3-validatePredatorModel
	.align 2
	.globl getPredatorModel
	.type	 getPredatorModel,@function
getPredatorModel:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,predator_model@ha
	lwz 3,predator_model@l(9)
	lwz 0,16(3)
	cmpwi 0,0,0
	bc 12,2,.L10
	lwz 3,4(3)
	cmpwi 0,3,0
	bc 12,2,.L11
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L10
.L11:
	lis 9,gi+148@ha
	lis 3,.LC0@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC0@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L10:
	lis 9,predator_model@ha
	lwz 11,predator_model@l(9)
	lwz 3,4(11)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe4:
	.size	 getPredatorModel,.Lfe4-getPredatorModel
	.align 2
	.globl validatePredatorSkin
	.type	 validatePredatorSkin,@function
validatePredatorSkin:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,predator_skin@ha
	lwz 11,predator_skin@l(9)
	lwz 3,4(11)
	cmpwi 0,3,0
	bc 12,2,.L16
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L15
.L16:
	lis 9,gi+148@ha
	lis 3,.LC2@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC2@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L15:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe5:
	.size	 validatePredatorSkin,.Lfe5-validatePredatorSkin
	.align 2
	.globl getPredatorSkin
	.type	 getPredatorSkin,@function
getPredatorSkin:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,predator_skin@ha
	lwz 3,predator_skin@l(9)
	lwz 0,16(3)
	cmpwi 0,0,0
	bc 12,2,.L18
	lwz 3,4(3)
	cmpwi 0,3,0
	bc 12,2,.L19
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L18
.L19:
	lis 9,gi+148@ha
	lis 3,.LC2@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC2@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L18:
	lis 9,predator_skin@ha
	lwz 11,predator_skin@l(9)
	lwz 3,4(11)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 getPredatorSkin,.Lfe6-getPredatorSkin
	.align 2
	.globl validateMarineModel
	.type	 validateMarineModel,@function
validateMarineModel:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,marine_model@ha
	lwz 11,marine_model@l(9)
	lwz 3,4(11)
	cmpwi 0,3,0
	bc 12,2,.L24
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L23
.L24:
	lis 9,gi+148@ha
	lis 3,.LC3@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC4@ha
	la 3,.LC3@l(3)
	la 4,.LC4@l(4)
	mtlr 0
	blrl
.L23:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe7:
	.size	 validateMarineModel,.Lfe7-validateMarineModel
	.align 2
	.globl getMarineModel
	.type	 getMarineModel,@function
getMarineModel:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,marine_model@ha
	lwz 3,marine_model@l(9)
	lwz 0,16(3)
	cmpwi 0,0,0
	bc 12,2,.L26
	lwz 3,4(3)
	cmpwi 0,3,0
	bc 12,2,.L27
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L26
.L27:
	lis 9,gi+148@ha
	lis 3,.LC3@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC4@ha
	la 3,.LC3@l(3)
	la 4,.LC4@l(4)
	mtlr 0
	blrl
.L26:
	lis 9,marine_model@ha
	lwz 11,marine_model@l(9)
	lwz 3,4(11)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe8:
	.size	 getMarineModel,.Lfe8-getMarineModel
	.align 2
	.globl validateMarineSkin
	.type	 validateMarineSkin,@function
validateMarineSkin:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,marine_skin@ha
	lwz 11,marine_skin@l(9)
	lwz 3,4(11)
	cmpwi 0,3,0
	bc 12,2,.L32
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L31
.L32:
	lis 9,gi+148@ha
	lis 3,.LC5@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC6@ha
	la 3,.LC5@l(3)
	la 4,.LC6@l(4)
	mtlr 0
	blrl
.L31:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 validateMarineSkin,.Lfe9-validateMarineSkin
	.align 2
	.globl getMarineSkin
	.type	 getMarineSkin,@function
getMarineSkin:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,marine_skin@ha
	lwz 3,marine_skin@l(9)
	lwz 0,16(3)
	cmpwi 0,0,0
	bc 12,2,.L34
	lwz 3,4(3)
	cmpwi 0,3,0
	bc 12,2,.L35
	bl strlen
	cmpwi 0,3,0
	bc 4,2,.L34
.L35:
	lis 9,gi+148@ha
	lis 3,.LC5@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC6@ha
	la 3,.LC5@l(3)
	la 4,.LC6@l(4)
	mtlr 0
	blrl
.L34:
	lis 9,marine_skin@ha
	lwz 11,marine_skin@l(9)
	lwz 3,4(11)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 getMarineSkin,.Lfe10-getMarineSkin
	.align 2
	.globl setLivePredatorSkin
	.type	 setLivePredatorSkin,@function
setLivePredatorSkin:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr. 30,3
	mr 31,4
	bc 12,2,.L51
	mr 3,30
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L51
	cmpwi 0,31,0
	bc 12,2,.L51
	mr 3,31
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L51
	mr 3,30
	bl strlen
	mr 29,3
	mr 3,31
	bl strlen
	add 29,29,3
	cmplwi 0,29,64
	bc 4,1,.L50
.L51:
	lis 29,.LC1@ha
	lis 3,predatorSkin@ha
	la 5,.LC1@l(29)
	lis 4,.LC7@ha
	la 3,predatorSkin@l(3)
	la 4,.LC7@l(4)
	mr 6,5
	crxor 6,6,6
	bl sprintf
	lwz 7,.LC1@l(29)
	la 10,.LC1@l(29)
	lis 9,predatorModel@ha
	lbz 8,6(10)
	la 11,predatorModel@l(9)
	lhz 0,4(10)
	stw 7,predatorModel@l(9)
	stb 8,6(11)
	sth 0,4(11)
	b .L52
.L50:
	lis 3,predatorSkin@ha
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	la 3,predatorSkin@l(3)
	mr 6,31
	mr 5,30
	crxor 6,6,6
	bl sprintf
	lis 3,predatorModel@ha
	mr 4,30
	la 3,predatorModel@l(3)
	bl strcpy
.L52:
	lis 3,predatorSkin@ha
	la 3,predatorSkin@l(3)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 setLivePredatorSkin,.Lfe11-setLivePredatorSkin
	.align 2
	.globl getLivePredatorSkin
	.type	 getLivePredatorSkin,@function
getLivePredatorSkin:
	lis 3,predatorSkin@ha
	la 3,predatorSkin@l(3)
	blr
.Lfe12:
	.size	 getLivePredatorSkin,.Lfe12-getLivePredatorSkin
	.section	".rodata"
	.align 2
.LC14:
	.long 0x0
	.section	".text"
	.align 2
	.globl checkMarineSkin
	.type	 checkMarineSkin,@function
checkMarineSkin:
	stwu 1,-160(1)
	mflr 0
	stmw 29,148(1)
	stw 0,164(1)
	mr 29,3
	lis 9,.LC10@ha
	mr 3,4
	la 4,.LC10@l(9)
	bl Info_ValueForKey
	mr 30,3
	addi 3,1,8
	mr 4,30
	bl strcpy
	lis 9,.LC14@ha
	lis 11,marine_allow_custom@ha
	la 9,.LC14@l(9)
	lfs 13,0(9)
	lwz 9,marine_allow_custom@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L88
	addi 31,1,72
	mr 3,30
	mr 4,31
	addi 5,1,104
	bl parseSkin
	cmpwi 0,3,0
	bc 12,2,.L88
	lis 4,predatorModel@ha
	mr 3,31
	la 4,predatorModel@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L82
.L88:
	lis 4,marineSkin@ha
	mr 3,29
	la 4,marineSkin@l(4)
	bl setMarineSkin
	b .L79
.L82:
	mr 3,29
	addi 4,1,8
	bl setMarineSkin
.L79:
	lwz 0,164(1)
	mtlr 0
	lmw 29,148(1)
	la 1,160(1)
	blr
.Lfe13:
	.size	 checkMarineSkin,.Lfe13-checkMarineSkin
	.align 2
	.globl setMarineSkin
	.type	 setMarineSkin,@function
setMarineSkin:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,g_edicts@ha
	mr 29,3
	mr 5,4
	lwz 11,g_edicts@l(9)
	lis 0,0x46fd
	lwz 4,84(29)
	ori 0,0,55623
	lis 28,gi@ha
	subf 29,11,29
	lis 3,.LC11@ha
	mullw 29,29,0
	la 28,gi@l(28)
	addi 4,4,700
	la 3,.LC11@l(3)
	srawi 29,29,3
	addi 29,29,1311
	crxor 6,6,6
	bl va
	lwz 0,24(28)
	mr 4,3
	mr 3,29
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 setMarineSkin,.Lfe14-setMarineSkin
	.align 2
	.globl parseSkin
	.type	 parseSkin,@function
parseSkin:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,5
	li 0,0
	mr 28,4
	cmpwi 0,31,0
	mr 30,3
	stb 0,0(28)
	stb 0,0(31)
	li 3,0
	bc 12,2,.L89
	mr 3,30
	li 4,47
	bl strchr
	cmpwi 0,3,0
	bc 12,2,.L87
	addi 29,1,8
	lis 4,.LC12@ha
	stw 30,8(1)
	la 4,.LC12@l(4)
	mr 3,29
	bl strsep
	mr 4,3
	mr 3,28
	bl strcpy
	lis 4,.LC13@ha
	mr 3,29
	la 4,.LC13@l(4)
	bl strsep
	mr 4,3
	mr 3,31
	bl strcpy
	li 3,1
	b .L89
.L87:
	li 3,0
.L89:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 parseSkin,.Lfe15-parseSkin
	.comm	maplist_lastmap,64,4
	.comm	maplist2_lastmap,64,4
	.comm	maplist3_lastmap,64,4
	.comm	last_beat,4,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
