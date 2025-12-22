	.file	"ini.c"
gcc2_compiled.:
	.section	".text"
	.align 2
	.globl CountNumberOfSections
	.type	 CountNumberOfSections,@function
CountNumberOfSections:
	stwu 1,-4128(1)
	mflr 0
	stmw 26,4104(1)
	stw 0,4132(1)
	mr 31,3
	li 29,0
	lwz 0,12(31)
	addi 27,1,8
	cmpw 0,29,0
	bc 4,0,.L35
	li 26,0
.L37:
	lwz 11,20(31)
	slwi 9,29,2
	addi 28,29,1
	mr 30,9
	lwzx 3,9,11
	bl strlen
	li 11,0
	stw 26,0(31)
	cmpw 0,11,3
	bc 4,0,.L50
	lwz 8,20(31)
	mr 10,30
.L41:
	lwzx 9,10,8
	lbzx 0,9,11
	cmpwi 0,0,32
	bc 12,2,.L49
	bc 4,1,.L43
	cmpwi 0,0,91
	bc 4,2,.L50
	stw 11,0(31)
	li 0,1
	b .L47
.L43:
	cmpwi 0,0,9
	bc 4,2,.L50
.L49:
	addi 11,11,1
	cmpw 0,11,3
	bc 12,0,.L41
.L50:
	li 0,0
.L47:
	cmpwi 0,0,0
	bc 12,2,.L36
	lwz 9,20(31)
	lwzx 3,30,9
	bl strlen
	lwz 9,0(31)
	stw 26,4(31)
	addi 11,9,1
	cmpw 0,11,3
	bc 4,0,.L64
	lwz 8,20(31)
	mr 10,30
.L54:
	lwzx 9,10,8
	lbzx 0,9,11
	cmpwi 0,0,13
	bc 12,2,.L64
	bc 4,1,.L56
	cmpwi 0,0,59
	bc 12,2,.L64
	cmpwi 0,0,93
	bc 4,2,.L63
	stw 11,4(31)
	li 0,1
	b .L61
.L56:
	cmpwi 0,0,10
	bc 12,2,.L64
.L63:
	addi 11,11,1
	cmpw 0,11,3
	bc 12,0,.L54
.L64:
	li 0,0
.L61:
	cmpwi 0,0,0
	bc 12,2,.L36
	lwz 9,16(31)
	addi 0,9,1
	slwi 9,9,2
	stwx 29,27,9
	stw 0,16(31)
.L36:
	lwz 0,12(31)
	mr 29,28
	cmpw 0,29,0
	bc 12,0,.L37
.L35:
	lwz 3,16(31)
	slwi 3,3,2
	bl malloc
	lwz 5,16(31)
	mr 0,3
	mr 4,27
	stw 0,28(31)
	slwi 5,5,2
	crxor 6,6,6
	bl memcpy
	lwz 0,4132(1)
	mtlr 0
	lmw 26,4104(1)
	la 1,4128(1)
	blr
.Lfe1:
	.size	 CountNumberOfSections,.Lfe1-CountNumberOfSections
	.align 2
	.globl GetSectionNames
	.type	 GetSectionNames,@function
GetSectionNames:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	mr 31,3
	li 30,0
	lwz 0,16(31)
	cmpw 0,30,0
	bc 4,0,.L68
	li 24,0
.L70:
	lwz 10,28(31)
	slwi 9,30,2
	addi 25,30,1
	lwz 11,20(31)
	mr 26,9
	lwzx 0,9,10
	slwi 30,0,2
	lwzx 3,30,11
	bl strlen
	li 11,0
	stw 24,0(31)
	cmpw 0,11,3
	bc 4,0,.L79
	lwz 8,20(31)
	mr 10,30
.L73:
	lwzx 9,10,8
	lbzx 0,9,11
	cmpwi 0,0,32
	bc 12,2,.L81
	bc 12,1,.L75
	cmpwi 0,0,9
	bc 12,2,.L81
	b .L79
.L75:
	cmpwi 0,0,91
	bc 4,2,.L79
	stw 11,0(31)
	b .L79
.L81:
	addi 11,11,1
	cmpw 0,11,3
	bc 12,0,.L73
.L79:
	lwz 9,28(31)
	lwz 11,20(31)
	lwzx 0,26,9
	slwi 30,0,2
	lwzx 3,30,11
	bl strlen
	lwz 9,0(31)
	stw 24,4(31)
	addi 11,9,1
	cmpw 0,11,3
	bc 4,0,.L92
	lwz 8,20(31)
	mr 10,30
.L85:
	lwzx 9,10,8
	lbzx 0,9,11
	cmpwi 0,0,13
	bc 12,2,.L92
	bc 4,1,.L87
	cmpwi 0,0,59
	bc 12,2,.L92
	cmpwi 0,0,93
	bc 4,2,.L94
	stw 11,4(31)
	b .L92
.L87:
	cmpwi 0,0,10
	bc 12,2,.L92
.L94:
	addi 11,11,1
	cmpw 0,11,3
	bc 12,0,.L85
.L92:
	lwz 0,0(31)
	li 27,0
	lwz 29,4(31)
	subf 29,0,29
	mr 3,29
	addi 28,29,-1
	bl malloc
	lwz 11,24(31)
	li 4,0
	mr 5,29
	stwx 3,26,11
	lwz 9,24(31)
	lwzx 3,26,9
	bl memset
	lwz 10,28(31)
	cmpw 0,27,28
	lwz 8,20(31)
	lwzx 9,26,10
	lwz 11,0(31)
	slwi 9,9,2
	lwzx 30,9,8
	add 11,30,11
	addi 30,11,1
	bc 4,0,.L69
.L99:
	lwz 9,24(31)
	mr 4,30
	mr 5,28
	mr 29,28
	addi 27,27,1
	lwzx 3,26,9
	bl strncpy
	cmpw 0,27,29
	bc 12,0,.L99
.L69:
	lwz 0,16(31)
	mr 30,25
	cmpw 0,30,0
	bc 12,0,.L70
.L68:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 GetSectionNames,.Lfe2-GetSectionNames
	.align 2
	.globl AddEntryValue
	.type	 AddEntryValue,@function
AddEntryValue:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	mr 28,5
	mr 3,30
	bl strlen
	lwz 9,4(31)
	li 0,-1
	stw 0,12(31)
	addi 8,9,1
	cmpw 0,8,3
	bc 4,0,.L211
.L200:
	lbzx 9,30,8
	addi 9,9,-9
	cmplwi 0,9,50
	bc 12,1,.L201
	lis 11,.L202@ha
	slwi 10,9,2
	la 11,.L202@l(11)
	lis 9,.L202@ha
	lwzx 0,10,11
	la 9,.L202@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L202:
	.long .L210-.L202
	.long .L211-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L211-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L210-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L201-.L202
	.long .L211-.L202
.L201:
	stw 8,12(31)
	li 0,1
	b .L209
.L210:
	addi 8,8,1
	cmpw 0,8,3
	bc 12,0,.L200
.L211:
	li 0,0
.L209:
	rlwinm 29,0,0,0xff
	cmpwi 0,29,0
	bc 12,2,.L197
	mr 3,30
	slwi 27,28,2
	bl strlen
	lwz 9,12(31)
	stw 3,16(31)
	b .L222
.L214:
	lbzx 0,30,9
	cmpwi 0,0,13
	bc 12,2,.L217
	bc 12,1,.L216
	cmpwi 0,0,10
	bc 12,2,.L217
	b .L222
.L216:
	cmpwi 0,0,59
	bc 4,2,.L222
.L217:
	stw 9,16(31)
	b .L220
.L222:
	addi 9,9,1
	cmpw 0,9,3
	bc 12,0,.L214
.L220:
	lwz 9,16(31)
	lwz 11,12(31)
	addi 9,9,-1
	addi 11,11,-1
	cmpw 0,9,11
	bc 4,1,.L231
.L226:
	lbzx 0,30,9
	cmpwi 0,0,9
	bc 12,2,.L232
	cmpwi 0,0,32
	bc 4,2,.L235
.L232:
	addi 9,9,-1
	cmpw 0,9,11
	bc 12,1,.L226
.L231:
	lwz 0,12(31)
	lwz 29,16(31)
	subf 29,0,29
	addi 29,29,1
	addi 28,29,1
	mr 3,28
	bl malloc
	lwz 11,28(31)
	li 4,0
	mr 5,28
	stwx 3,27,11
	lwz 9,28(31)
	lwzx 3,27,9
	bl memset
	lwz 9,28(31)
	mr 5,29
	lwz 4,12(31)
	lwzx 3,27,9
	add 4,30,4
	bl strncpy
	b .L234
.L235:
	stw 9,16(31)
	b .L231
.L197:
	li 3,1
	bl malloc
	lwz 11,28(31)
	slwi 10,28,2
	stwx 3,10,11
	lwz 9,28(31)
	lwzx 11,10,9
	stb 29,0(11)
.L234:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 AddEntryValue,.Lfe3-AddEntryValue
	.align 2
	.globl ReadIniEntry
	.type	 ReadIniEntry,@function
ReadIniEntry:
	stwu 1,-64(1)
	mflr 0
	stmw 19,12(1)
	stw 0,68(1)
	mr 30,3
	mr 27,4
	lwz 9,32(30)
	slwi 10,27,2
	li 8,0
	li 0,-1
	mr 19,5
	lwzx 11,10,9
	subf 20,19,6
	li 31,0
	cmpw 0,31,20
	stw 8,20(11)
	lwz 9,32(30)
	lwzx 11,10,9
	stw 0,0(11)
	lwz 9,32(30)
	lwzx 11,10,9
	stw 0,4(11)
	lwz 9,32(30)
	lwzx 11,10,9
	stw 0,8(11)
	bc 4,0,.L238
.L240:
	add 0,19,31
	lwz 10,20(30)
	slwi 11,27,2
	slwi 9,0,2
	lwz 8,32(30)
	addi 22,31,1
	lwzx 28,9,10
	mr 25,0
	mr 24,11
	lwzx 31,11,8
	mr 3,28
	bl strlen
	li 8,0
	li 0,-1
	cmpw 0,8,3
	stw 0,0(31)
	bc 4,0,.L256
.L244:
	lbzx 9,28,8
	addi 9,9,-9
	cmplwi 0,9,52
	bc 12,1,.L245
	lis 11,.L246@ha
	slwi 10,9,2
	la 11,.L246@l(11)
	lis 9,.L246@ha
	lwzx 0,10,11
	la 9,.L246@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L246:
	.long .L255-.L246
	.long .L256-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L256-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L255-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L245-.L246
	.long .L256-.L246
	.long .L245-.L246
	.long .L256-.L246
.L245:
	stw 8,0(31)
	li 0,1
	b .L254
.L255:
	addi 8,8,1
	cmpw 0,8,3
	bc 12,0,.L244
.L256:
	li 0,0
.L254:
	cmpwi 0,0,0
	bc 12,2,.L239
	lwz 10,20(30)
	slwi 9,25,2
	lwz 11,32(30)
	lwzx 31,9,10
	lwzx 29,24,11
	mr 3,31
	bl strlen
	lwz 9,0(29)
	li 0,-1
	stw 0,4(29)
	b .L269
.L260:
	lbzx 0,31,9
	cmpwi 0,0,13
	bc 12,2,.L321
	bc 4,1,.L262
	cmpwi 0,0,59
	bc 12,2,.L321
	cmpwi 0,0,61
	bc 4,2,.L269
	stw 9,4(29)
	li 0,1
	b .L267
.L262:
	cmpwi 0,0,10
	bc 12,2,.L321
.L269:
	addi 9,9,1
	cmpw 0,9,3
	bc 12,0,.L260
.L321:
	li 0,0
.L267:
	cmpwi 0,0,0
	bc 12,2,.L239
	lwz 10,32(30)
	slwi 11,27,2
	lwzx 8,11,10
	lwz 9,20(8)
	addi 9,9,1
	stw 9,20(8)
.L239:
	mr 31,22
	cmpw 0,31,20
	bc 12,0,.L240
.L238:
	lwz 11,32(30)
	slwi 29,27,2
	li 31,0
	mr 24,29
	li 21,0
	lwzx 9,29,11
	lwz 3,20(9)
	slwi 3,3,2
	bl malloc
	lwz 9,32(30)
	lwzx 11,29,9
	stw 3,24(11)
	lwz 9,32(30)
	lwzx 11,29,9
	lwz 3,20(11)
	slwi 3,3,2
	bl malloc
	lwz 11,32(30)
	cmpw 0,31,20
	lwzx 9,29,11
	stw 3,28(9)
	bc 4,0,.L273
.L275:
	add 0,19,31
	lwz 10,20(30)
	addi 22,31,1
	slwi 9,0,2
	lwz 11,32(30)
	mr 25,0
	lwzx 29,9,10
	lwzx 31,24,11
	mr 3,29
	bl strlen
	li 8,0
	li 0,-1
	cmpw 0,8,3
	stw 0,0(31)
	bc 4,0,.L291
.L279:
	lbzx 9,29,8
	addi 9,9,-9
	cmplwi 0,9,52
	bc 12,1,.L280
	lis 11,.L281@ha
	slwi 10,9,2
	la 11,.L281@l(11)
	lis 9,.L281@ha
	lwzx 0,10,11
	la 9,.L281@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L281:
	.long .L290-.L281
	.long .L291-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L291-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L290-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L280-.L281
	.long .L291-.L281
	.long .L280-.L281
	.long .L291-.L281
.L280:
	stw 8,0(31)
	li 0,1
	b .L289
.L290:
	addi 8,8,1
	cmpw 0,8,3
	bc 12,0,.L279
.L291:
	li 0,0
.L289:
	cmpwi 0,0,0
	bc 12,2,.L274
	lwz 10,20(30)
	slwi 9,25,2
	lwz 11,32(30)
	lwzx 29,9,10
	lwzx 31,24,11
	mr 3,29
	bl strlen
	lwz 9,0(31)
	li 0,-1
	stw 0,4(31)
	b .L304
.L295:
	lbzx 0,29,9
	cmpwi 0,0,13
	bc 12,2,.L322
	bc 4,1,.L297
	cmpwi 0,0,59
	bc 12,2,.L322
	cmpwi 0,0,61
	bc 4,2,.L304
	stw 9,4(31)
	li 0,1
	b .L302
.L297:
	cmpwi 0,0,10
	bc 12,2,.L322
.L304:
	addi 9,9,1
	cmpw 0,9,3
	bc 12,0,.L295
.L322:
	li 0,0
.L302:
	cmpwi 0,0,0
	bc 12,2,.L274
	lwz 9,32(30)
	slwi 10,25,2
	li 0,-1
	lwz 11,20(30)
	addi 23,21,1
	lwzx 31,24,9
	lwzx 26,10,11
	lwz 9,0(31)
	lwz 11,4(31)
	addi 9,9,-1
	stw 0,8(31)
	cmpw 0,11,9
	bc 4,1,.L315
.L308:
	lbzx 0,26,11
	cmpwi 0,0,32
	bc 12,2,.L316
	bc 12,1,.L310
	cmpwi 0,0,9
	b .L323
.L310:
	cmpwi 0,0,61
.L323:
	bc 12,2,.L316
	stw 11,8(31)
	b .L315
.L316:
	addi 11,11,-1
	cmpw 0,11,9
	bc 12,1,.L308
.L315:
	lwz 0,8(31)
	cmpwi 0,0,-1
	bc 12,2,.L319
	lwz 28,0(31)
	slwi 27,21,2
	subf 28,28,0
	addi 28,28,1
	addi 29,28,1
	mr 3,29
	bl malloc
	lwz 11,24(31)
	li 4,0
	mr 5,29
	stwx 3,27,11
	lwz 9,24(31)
	lwzx 3,27,9
	bl memset
	lwz 9,24(31)
	mr 5,28
	lwz 4,0(31)
	lwzx 3,27,9
	add 4,26,4
	bl strncpy
.L319:
	lwz 9,32(30)
	slwi 10,25,2
	mr 5,21
	lwz 11,20(30)
	mr 21,23
	lwzx 3,24,9
	lwzx 4,10,11
	bl AddEntryValue
.L274:
	mr 31,22
	cmpw 0,31,20
	bc 12,0,.L275
.L273:
	lwz 0,68(1)
	mtlr 0
	lmw 19,12(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 ReadIniEntry,.Lfe4-ReadIniEntry
	.section	".rodata"
	.align 2
.LC0:
	.string	"rb"
	.section	".text"
	.align 2
	.globl Ini_ReadIniFile
	.type	 Ini_ReadIniFile,@function
Ini_ReadIniFile:
	stwu 1,-1056(1)
	mflr 0
	stmw 26,1032(1)
	stw 0,1060(1)
	mr 31,4
	li 0,0
	lis 4,.LC0@ha
	stw 0,16(31)
	la 4,.LC0@l(4)
	stw 0,12(31)
	bl fopen
	mr. 26,3
	bc 4,2,.L325
	stb 26,8(31)
	li 3,0
	b .L351
.L325:
	li 0,1
	mr 3,26
	stb 0,8(31)
	li 4,0
	li 5,0
	bl fseek
	b .L352
.L328:
	addi 3,1,8
	li 4,1024
	mr 5,26
	bl fgets
	lwz 9,12(31)
	addi 9,9,1
	stw 9,12(31)
.L352:
	lhz 0,12(26)
	andi. 9,0,32
	bc 12,2,.L328
	lwz 3,12(31)
	li 28,0
	slwi 3,3,2
	bl malloc
	stw 3,20(31)
	li 4,0
	li 5,0
	mr 3,26
	bl fseek
	lwz 0,12(31)
	cmpw 0,28,0
	bc 4,0,.L331
	addi 30,1,8
	li 27,0
.L333:
	li 4,0
	li 5,1024
	mr 3,30
	addi 28,28,1
	crxor 6,6,6
	bl memset
	li 4,1024
	mr 5,26
	mr 3,30
	bl fgets
	mr 3,30
	bl strlen
	addi 29,3,1
	mr 3,29
	bl malloc
	lwz 11,20(31)
	mr 5,29
	li 4,0
	stwx 3,27,11
	lwz 9,20(31)
	lwzx 3,27,9
	bl memset
	lwz 9,20(31)
	mr 4,30
	lwzx 3,27,9
	addi 27,27,4
	bl strcpy
	lwz 0,12(31)
	cmpw 0,28,0
	bc 12,0,.L333
.L331:
	mr 3,31
	bl CountNumberOfSections
	lwz 3,16(31)
	cmpwi 0,3,0
	bc 4,2,.L335
	lwz 0,12(31)
	li 28,0
	stb 3,8(31)
	cmpw 0,28,0
	bc 4,0,.L337
	li 30,0
.L339:
	lwz 9,20(31)
	addi 28,28,1
	lwzx 3,30,9
	addi 30,30,4
	bl free
	lwz 0,12(31)
	cmpw 0,28,0
	bc 12,0,.L339
.L337:
	lwz 3,20(31)
	bl free
	li 3,0
	b .L351
.L335:
	slwi 3,3,2
	li 28,0
	bl malloc
	stw 3,24(31)
	mr 3,31
	bl GetSectionNames
	lwz 3,16(31)
	slwi 3,3,2
	bl malloc
	lwz 0,16(31)
	stw 3,32(31)
	addic. 9,0,-1
	bc 4,1,.L342
	li 29,0
.L344:
	li 3,32
	bl malloc
	lwz 11,32(31)
	mr 4,28
	addi 28,28,1
	stwx 3,29,11
	lwz 9,28(31)
	mr 3,31
	add 11,29,9
	lwzx 5,29,9
	lwz 6,4(11)
	addi 29,29,4
	bl ReadIniEntry
	lwz 9,16(31)
	addi 9,9,-1
	cmpw 0,28,9
	bc 12,0,.L344
.L342:
	li 3,32
	li 28,0
	bl malloc
	lwz 9,16(31)
	lwz 0,32(31)
	slwi 9,9,2
	add 9,9,0
	stw 3,-4(9)
	lwz 4,16(31)
	mr 3,31
	lwz 0,28(31)
	slwi 9,4,2
	lwz 6,12(31)
	add 9,9,0
	addi 4,4,-1
	lwz 5,-4(9)
	bl ReadIniEntry
	mr 3,26
	bl fclose
	lwz 0,12(31)
	cmpw 0,28,0
	bc 4,0,.L347
	li 30,0
.L349:
	lwz 9,20(31)
	addi 28,28,1
	lwzx 3,30,9
	addi 30,30,4
	bl free
	lwz 0,12(31)
	cmpw 0,28,0
	bc 12,0,.L349
.L347:
	lwz 3,20(31)
	bl free
	li 3,1
.L351:
	lwz 0,1060(1)
	mtlr 0
	lmw 26,1032(1)
	la 1,1056(1)
	blr
.Lfe5:
	.size	 Ini_ReadIniFile,.Lfe5-Ini_ReadIniFile
	.align 2
	.globl Ini_GetValue
	.type	 Ini_GetValue,@function
Ini_GetValue:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 29,3
	li 31,0
	lwz 0,16(29)
	mr 28,4
	mr 27,5
	cmpw 0,31,0
	bc 4,0,.L413
	li 30,0
.L409:
	lwz 9,24(29)
	mr 3,28
	lwzx 4,30,9
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L438
	lwz 0,16(29)
	addi 31,31,1
	addi 30,30,4
	cmpw 0,31,0
	bc 12,0,.L409
.L413:
	li 9,-1
.L411:
	cmpwi 0,9,-1
	bc 4,2,.L414
.L440:
	li 3,0
	b .L437
.L438:
	mr 9,31
	b .L411
.L439:
	mr 9,31
	b .L419
.L414:
	lwz 11,32(29)
	slwi 9,9,2
	li 31,0
	lwzx 30,9,11
	lwz 0,20(30)
	cmpw 0,31,0
	bc 4,0,.L421
	li 29,0
.L417:
	lwz 9,24(30)
	mr 3,27
	lwzx 4,29,9
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L439
	lwz 0,20(30)
	addi 31,31,1
	addi 29,29,4
	cmpw 0,31,0
	bc 12,0,.L417
.L421:
	li 9,-1
.L419:
	cmpwi 0,9,-1
	bc 12,2,.L440
	lwz 11,28(30)
	slwi 9,9,2
	lwzx 3,9,11
.L437:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 Ini_GetValue,.Lfe6-Ini_GetValue
	.align 2
	.globl Ini_SectionEntries
	.type	 Ini_SectionEntries,@function
Ini_SectionEntries:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	li 31,0
	lwz 0,16(30)
	mr 28,4
	cmpw 0,31,0
	bc 4,0,.L393
	li 29,0
.L389:
	lwz 9,24(30)
	mr 3,28
	lwzx 4,29,9
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L442
	lwz 0,16(30)
	addi 31,31,1
	addi 29,29,4
	cmpw 0,31,0
	bc 12,0,.L389
.L393:
	li 11,-1
.L391:
	cmpwi 0,11,-1
	bc 12,2,.L394
	lwz 9,32(30)
	slwi 11,11,2
	lwzx 10,11,9
	lwz 3,24(10)
	b .L441
.L442:
	mr 11,31
	b .L391
.L394:
	li 3,0
.L441:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 Ini_SectionEntries,.Lfe7-Ini_SectionEntries
	.align 2
	.globl Ini_NumberOfEntries
	.type	 Ini_NumberOfEntries,@function
Ini_NumberOfEntries:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	li 31,0
	lwz 0,16(30)
	mr 28,4
	cmpw 0,31,0
	bc 4,0,.L403
	li 29,0
.L399:
	lwz 9,24(30)
	mr 3,28
	lwzx 4,29,9
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L444
	lwz 0,16(30)
	addi 31,31,1
	addi 29,29,4
	cmpw 0,31,0
	bc 12,0,.L399
.L403:
	li 11,-1
.L401:
	cmpwi 0,11,-1
	bc 12,2,.L404
	lwz 9,32(30)
	slwi 11,11,2
	lwzx 10,11,9
	lwz 3,20(10)
	b .L443
.L444:
	mr 11,31
	b .L401
.L404:
	li 3,-1
.L443:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 Ini_NumberOfEntries,.Lfe8-Ini_NumberOfEntries
	.align 2
	.globl Ini_FreeIniFile
	.type	 Ini_FreeIniFile,@function
Ini_FreeIniFile:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 28,3
	lbz 0,8(28)
	cmpwi 0,0,0
	bc 12,2,.L425
	lwz 0,16(28)
	li 10,0
	cmpw 0,10,0
	bc 4,0,.L427
.L429:
	lwz 11,32(28)
	slwi 9,10,2
	li 29,0
	mr 27,9
	addi 26,10,1
	lwzx 31,9,11
	lwz 0,20(31)
	cmpw 0,29,0
	bc 4,0,.L434
	li 30,0
.L432:
	lwz 9,24(31)
	addi 29,29,1
	lwzx 3,30,9
	bl free
	lwz 9,28(31)
	lwzx 3,30,9
	addi 30,30,4
	bl free
	lwz 0,20(31)
	cmpw 0,29,0
	bc 12,0,.L432
.L434:
	lwz 3,24(31)
	bl free
	lwz 3,28(31)
	bl free
	lwz 9,24(28)
	lwzx 3,27,9
	bl free
	lwz 0,16(28)
	mr 10,26
	cmpw 0,10,0
	bc 12,0,.L429
.L427:
	lwz 3,24(28)
	bl free
	lwz 3,32(28)
	bl free
	lwz 3,28(28)
	bl free
.L425:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 Ini_FreeIniFile,.Lfe9-Ini_FreeIniFile
	.align 2
	.globl FirstLetterIsOpenBracket
	.type	 FirstLetterIsOpenBracket,@function
FirstLetterIsOpenBracket:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,4
	slwi 30,3,2
	lwz 9,20(31)
	lwzx 3,30,9
	bl strlen
	li 11,0
	li 0,0
	cmpw 0,11,3
	stw 0,0(31)
	bc 4,0,.L8
	lwz 8,20(31)
	mr 10,30
.L10:
	lwzx 9,10,8
	lbzx 0,9,11
	cmpwi 0,0,32
	bc 12,2,.L9
	bc 4,1,.L17
	cmpwi 0,0,91
	bc 4,2,.L8
	stw 11,0(31)
	li 3,1
	b .L445
.L17:
	cmpwi 0,0,9
	bc 4,2,.L8
.L9:
	addi 11,11,1
	cmpw 0,11,3
	bc 12,0,.L10
.L8:
	li 3,0
.L445:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe10:
	.size	 FirstLetterIsOpenBracket,.Lfe10-FirstLetterIsOpenBracket
	.align 2
	.globl ContainsCloseBracket
	.type	 ContainsCloseBracket,@function
ContainsCloseBracket:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,4
	slwi 30,3,2
	lwz 9,20(31)
	lwzx 3,30,9
	bl strlen
	lwz 9,0(31)
	li 0,0
	stw 0,4(31)
	addi 11,9,1
	cmpw 0,11,3
	bc 4,0,.L21
	lwz 8,20(31)
	mr 10,30
.L23:
	lwzx 9,10,8
	lbzx 0,9,11
	cmpwi 0,0,13
	bc 12,2,.L21
	bc 4,1,.L31
	cmpwi 0,0,59
	bc 12,2,.L21
	cmpwi 0,0,93
	bc 4,2,.L22
	stw 11,4(31)
	li 3,1
	b .L446
.L31:
	cmpwi 0,0,10
	bc 12,2,.L21
.L22:
	addi 11,11,1
	cmpw 0,11,3
	bc 12,0,.L23
.L21:
	li 3,0
.L446:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 ContainsCloseBracket,.Lfe11-ContainsCloseBracket
	.align 2
	.globl HasEntryName
	.type	 HasEntryName,@function
HasEntryName:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,3
	mr 31,4
	mr 3,31
	bl strlen
	li 8,0
	li 0,-1
	cmpw 0,8,3
	stw 0,0(30)
	bc 4,0,.L104
.L106:
	lbzx 9,31,8
	addi 9,9,-9
	cmplwi 0,9,52
	bc 12,1,.L114
	lis 11,.L115@ha
	slwi 10,9,2
	la 11,.L115@l(11)
	lis 9,.L115@ha
	lwzx 0,10,11
	la 9,.L115@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L115:
	.long .L105-.L115
	.long .L104-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L104-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L105-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L114-.L115
	.long .L104-.L115
	.long .L114-.L115
	.long .L104-.L115
.L114:
	stw 8,0(30)
	li 3,1
	b .L447
.L105:
	addi 8,8,1
	cmpw 0,8,3
	bc 12,0,.L106
.L104:
	li 3,0
.L447:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 HasEntryName,.Lfe12-HasEntryName
	.align 2
	.globl ContainsEqualsSign
	.type	 ContainsEqualsSign,@function
ContainsEqualsSign:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	mr 3,30
	bl strlen
	lwz 9,0(31)
	li 0,-1
	stw 0,4(31)
	b .L120
.L121:
	lbzx 0,30,9
	cmpwi 0,0,13
	bc 12,2,.L449
	bc 4,1,.L129
	cmpwi 0,0,59
	bc 12,2,.L449
	cmpwi 0,0,61
	bc 4,2,.L120
	stw 9,4(31)
	li 3,1
	b .L448
.L129:
	cmpwi 0,0,10
	bc 12,2,.L449
.L120:
	addi 9,9,1
	cmpw 0,9,3
	bc 12,0,.L121
.L449:
	li 3,0
.L448:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe13:
	.size	 ContainsEqualsSign,.Lfe13-ContainsEqualsSign
	.align 2
	.globl LastLetterBeforeEquals
	.type	 LastLetterBeforeEquals,@function
LastLetterBeforeEquals:
	lwz 9,0(3)
	li 0,-1
	lwz 11,4(3)
	addi 9,9,-1
	stw 0,8(3)
	cmpw 0,11,9
	bclr 4,1
.L135:
	lbzx 0,4,11
	cmpwi 0,0,32
	bc 12,2,.L134
	bc 12,1,.L142
	cmpwi 0,0,9
	b .L450
.L142:
	cmpwi 0,0,61
.L450:
	bc 12,2,.L134
	stw 11,8(3)
	blr
.L134:
	addi 11,11,-1
	cmpw 0,11,9
	bc 12,1,.L135
	blr
.Lfe14:
	.size	 LastLetterBeforeEquals,.Lfe14-LastLetterBeforeEquals
	.align 2
	.globl AddEntryName
	.type	 AddEntryName,@function
AddEntryName:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	li 0,-1
	lwz 9,0(31)
	mr 30,4
	mr 27,5
	lwz 11,4(31)
	addi 9,9,-1
	stw 0,8(31)
	cmpw 0,11,9
	bc 4,1,.L154
.L147:
	lbzx 0,30,11
	cmpwi 0,0,32
	bc 12,2,.L155
	bc 12,1,.L149
	cmpwi 0,0,9
	b .L451
.L149:
	cmpwi 0,0,61
.L451:
	bc 12,2,.L155
	stw 11,8(31)
	b .L154
.L155:
	addi 11,11,-1
	cmpw 0,11,9
	bc 12,1,.L147
.L154:
	lwz 0,8(31)
	cmpwi 0,0,-1
	bc 12,2,.L144
	lwz 29,0(31)
	slwi 27,27,2
	subf 29,29,0
	addi 29,29,1
	addi 28,29,1
	mr 3,28
	bl malloc
	lwz 11,24(31)
	li 4,0
	mr 5,28
	stwx 3,27,11
	lwz 9,24(31)
	lwzx 3,27,9
	bl memset
	lwz 9,24(31)
	mr 5,29
	lwz 4,0(31)
	lwzx 3,27,9
	add 4,30,4
	bl strncpy
.L144:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 AddEntryName,.Lfe15-AddEntryName
	.align 2
	.globl FirstLetterAfterEquals
	.type	 FirstLetterAfterEquals,@function
FirstLetterAfterEquals:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	mr 3,30
	bl strlen
	lwz 9,4(31)
	li 0,-1
	stw 0,12(31)
	addi 8,9,1
	cmpw 0,8,3
	bc 4,0,.L160
.L162:
	lbzx 9,30,8
	addi 9,9,-9
	cmplwi 0,9,50
	bc 12,1,.L169
	lis 11,.L170@ha
	slwi 10,9,2
	la 11,.L170@l(11)
	lis 9,.L170@ha
	lwzx 0,10,11
	la 9,.L170@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L170:
	.long .L161-.L170
	.long .L160-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L160-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L161-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L169-.L170
	.long .L160-.L170
.L169:
	stw 8,12(31)
	li 3,1
	b .L452
.L161:
	addi 8,8,1
	cmpw 0,8,3
	bc 12,0,.L162
.L160:
	li 3,0
.L452:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe16:
	.size	 FirstLetterAfterEquals,.Lfe16-FirstLetterAfterEquals
	.align 2
	.globl LastLetterAfterEquals
	.type	 LastLetterAfterEquals,@function
LastLetterAfterEquals:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	mr 3,30
	bl strlen
	lwz 9,12(31)
	stw 3,16(31)
	b .L175
.L176:
	lbzx 0,30,9
	cmpwi 0,0,13
	bc 12,2,.L180
	bc 12,1,.L183
	cmpwi 0,0,10
	bc 12,2,.L180
	b .L175
.L183:
	cmpwi 0,0,59
	bc 4,2,.L175
.L180:
	stw 9,16(31)
	b .L172
.L175:
	addi 9,9,1
	cmpw 0,9,3
	bc 12,0,.L176
.L172:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe17:
	.size	 LastLetterAfterEquals,.Lfe17-LastLetterAfterEquals
	.align 2
	.globl RemoveTrailingSpaces
	.type	 RemoveTrailingSpaces,@function
RemoveTrailingSpaces:
	lwz 9,16(3)
	lwz 11,12(3)
	addi 9,9,-1
	addi 11,11,-1
	cmpw 0,9,11
	bclr 4,1
.L189:
	lbzx 0,4,9
	cmpwi 0,0,9
	bc 12,2,.L188
	cmpwi 0,0,32
	bc 12,2,.L188
	stw 9,16(3)
	blr
.L188:
	addi 9,9,-1
	cmpw 0,9,11
	bc 12,1,.L189
	blr
.Lfe18:
	.size	 RemoveTrailingSpaces,.Lfe18-RemoveTrailingSpaces
	.align 2
	.globl FindSection
	.type	 FindSection,@function
FindSection:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	li 31,0
	lwz 0,16(30)
	mr 28,4
	cmpw 0,31,0
	bc 4,0,.L355
	li 29,0
.L357:
	lwz 9,24(30)
	mr 3,28
	lwzx 4,29,9
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L356
	mr 3,31
	b .L453
.L356:
	lwz 0,16(30)
	addi 31,31,1
	addi 29,29,4
	cmpw 0,31,0
	bc 12,0,.L357
.L355:
	li 3,-1
.L453:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 FindSection,.Lfe19-FindSection
	.align 2
	.globl FindEntry
	.type	 FindEntry,@function
FindEntry:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	li 31,0
	lwz 0,20(30)
	mr 28,4
	cmpw 0,31,0
	bc 4,0,.L362
	li 29,0
.L364:
	lwz 9,24(30)
	mr 3,28
	lwzx 4,29,9
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L363
	mr 3,31
	b .L454
.L363:
	lwz 0,20(30)
	addi 31,31,1
	addi 29,29,4
	cmpw 0,31,0
	bc 12,0,.L364
.L362:
	li 3,-1
.L454:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 FindEntry,.Lfe20-FindEntry
	.align 2
	.globl EntryValue
	.type	 EntryValue,@function
EntryValue:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 30,3
	li 31,0
	lwz 0,20(30)
	mr 28,4
	cmpw 0,31,0
	bc 4,0,.L374
	li 29,0
.L370:
	lwz 9,24(30)
	mr 3,28
	lwzx 4,29,9
	bl stricmp
	cmpwi 0,3,0
	bc 12,2,.L456
	lwz 0,20(30)
	addi 31,31,1
	addi 29,29,4
	cmpw 0,31,0
	bc 12,0,.L370
.L374:
	li 9,-1
.L372:
	cmpwi 0,9,-1
	bc 12,2,.L375
	lwz 11,28(30)
	slwi 9,9,2
	lwzx 3,9,11
	b .L455
.L456:
	mr 9,31
	b .L372
.L375:
	li 3,0
.L455:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 EntryValue,.Lfe21-EntryValue
	.align 2
	.globl NumberOfEntries
	.type	 NumberOfEntries,@function
NumberOfEntries:
	lwz 3,20(3)
	blr
.Lfe22:
	.size	 NumberOfEntries,.Lfe22-NumberOfEntries
	.align 2
	.globl SectionNames
	.type	 SectionNames,@function
SectionNames:
	lwz 3,24(3)
	blr
.Lfe23:
	.size	 SectionNames,.Lfe23-SectionNames
	.align 2
	.globl NumberOfSections
	.type	 NumberOfSections,@function
NumberOfSections:
	lwz 3,16(3)
	blr
.Lfe24:
	.size	 NumberOfSections,.Lfe24-NumberOfSections
	.align 2
	.globl EntryNames
	.type	 EntryNames,@function
EntryNames:
	lwz 3,24(3)
	blr
.Lfe25:
	.size	 EntryNames,.Lfe25-EntryNames
	.align 2
	.globl Ini_FreeIniEntry
	.type	 Ini_FreeIniEntry,@function
Ini_FreeIniEntry:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	li 29,0
	lwz 0,20(31)
	cmpw 0,29,0
	bc 4,0,.L382
	li 30,0
.L384:
	lwz 9,24(31)
	addi 29,29,1
	lwzx 3,30,9
	bl free
	lwz 9,28(31)
	lwzx 3,30,9
	addi 30,30,4
	bl free
	lwz 0,20(31)
	cmpw 0,29,0
	bc 12,0,.L384
.L382:
	lwz 3,24(31)
	bl free
	lwz 3,28(31)
	bl free
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 Ini_FreeIniEntry,.Lfe26-Ini_FreeIniEntry
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
