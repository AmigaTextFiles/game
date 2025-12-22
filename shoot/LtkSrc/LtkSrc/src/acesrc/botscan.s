	.file	"botscan.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 tokenNames.6,@object
tokenNames.6:
	.long .LC0
	.long .LC1
	.long .LC2
	.long .LC3
	.long .LC4
	.long .LC5
	.long .LC6
	.long .LC7
	.long .LC8
	.long .LC9
	.long .LC10
	.long .LC11
	.long .LC12
	.long .LC13
	.long .LC14
	.long .LC15
	.long .LC16
	.long .LC17
	.long .LC18
	.long .LC19
	.long .LC20
	.long .LC21
	.section	".rodata"
	.align 2
.LC21:
	.string	"UNDEF"
	.align 2
.LC20:
	.string	"EOL"
	.align 2
.LC19:
	.string	"BANG"
	.align 2
.LC18:
	.string	"HASH"
	.align 2
.LC17:
	.string	"ASSIGNOP"
	.align 2
.LC16:
	.string	"POWOP"
	.align 2
.LC15:
	.string	"DIVOP"
	.align 2
.LC14:
	.string	"MUXOP"
	.align 2
.LC13:
	.string	"MINUSOP"
	.align 2
.LC12:
	.string	"PLUSOP"
	.align 2
.LC11:
	.string	"APOST"
	.align 2
.LC10:
	.string	"PERIOD"
	.align 2
.LC9:
	.string	"COMMA"
	.align 2
.LC8:
	.string	"COLON"
	.align 2
.LC7:
	.string	"SEMIC"
	.align 2
.LC6:
	.string	"RPAREN"
	.align 2
.LC5:
	.string	"LPAREN"
	.align 2
.LC4:
	.string	"STRLIT"
	.align 2
.LC3:
	.string	"REALLIT"
	.align 2
.LC2:
	.string	"INTLIT"
	.align 2
.LC1:
	.string	"SYMBOL"
	.align 2
.LC0:
	.string	"LEXERR"
	.section	".text"
	.align 2
	.globl scanner
	.type	 scanner,@function
scanner:
	lwz 9,0(3)
	lbz 10,0(9)
	mr 7,9
	xori 11,10,32
	subfic 0,11,0
	adde 11,0,11
	xori 0,10,9
	subfic 9,0,0
	adde 0,9,0
	or. 9,11,0
	bc 4,2,.L10
	cmpwi 0,10,10
	bc 12,2,.L10
	cmpwi 0,10,13
	bc 4,2,.L45
.L10:
	lwz 11,0(3)
	addi 0,11,1
	stw 0,0(3)
	mr 7,0
	lbz 11,1(11)
	xori 9,11,32
	subfic 10,9,0
	adde 9,10,9
	xori 0,11,9
	subfic 10,0,0
	adde 0,10,0
	or. 10,9,0
	bc 4,2,.L10
	cmpwi 0,11,10
	bc 12,2,.L10
	cmpwi 0,11,13
	bc 12,2,.L10
.L45:
	lbz 8,0(7)
	rlwinm 11,8,0,0xff
	cmpwi 0,11,0
	bc 4,2,.L13
	li 0,20
	stw 0,0(5)
	blr
.L13:
	addi 9,11,-65
	addi 0,11,-97
	subfic 9,9,25
	li 9,0
	adde 9,9,9
	subfic 0,0,25
	li 0,0
	adde 0,0,0
	or. 10,9,0
	bc 12,2,.L14
	li 0,1
	stw 0,0(5)
	lwz 11,0(3)
	b .L47
.L17:
	lwz 11,0(3)
	lbz 0,0(11)
	addi 11,11,1
	stb 0,0(4)
	stw 11,0(3)
	addi 4,4,1
.L47:
	lbz 11,0(11)
	rlwinm 9,11,0,0xff
	addi 0,9,-97
	addi 9,9,-65
	subfic 0,0,25
	li 0,0
	adde 0,0,0
	subfic 9,9,25
	li 9,0
	adde 9,9,9
	or. 10,9,0
	bc 4,2,.L17
	addi 0,11,-48
	cmplwi 0,0,9
	bc 4,1,.L17
.L48:
	li 0,0
	stb 0,0(4)
	blr
.L14:
	cmpwi 0,11,34
	bc 4,2,.L19
	li 0,4
	stw 0,0(5)
	lwz 11,0(3)
	addi 0,11,1
	stw 0,0(3)
	lbz 9,1(11)
	xori 0,9,34
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 11,0,9
	bc 12,2,.L21
.L22:
	lwz 11,0(3)
	lbz 0,0(11)
	addi 11,11,1
	stb 0,0(4)
	stw 11,0(3)
	addi 4,4,1
	lbz 9,0(11)
	xori 0,9,34
	neg 9,9
	neg 0,0
	srwi 9,9,31
	srwi 0,0,31
	and. 10,0,9
	bc 4,2,.L22
.L21:
	lwz 9,0(3)
	li 0,0
	addi 9,9,1
	stw 9,0(3)
	stb 0,0(4)
	blr
.L19:
	addi 0,8,-48
	rlwinm 0,0,0,0xff
	cmplwi 0,0,9
	bc 12,1,.L24
	li 0,2
	stw 0,0(5)
	lwz 11,0(3)
	lbz 9,0(11)
	addi 9,9,-48
	cmplwi 0,9,9
	bc 12,1,.L48
	li 10,3
.L27:
	lbz 0,0(11)
	addi 9,11,1
	stb 0,0(4)
	stw 9,0(3)
	addi 4,4,1
	lbz 0,1(11)
	cmpwi 0,0,46
	bc 4,2,.L25
	stw 10,0(5)
	lwz 9,0(3)
	lbz 0,0(9)
	addi 9,9,1
	stb 0,0(4)
	stw 9,0(3)
	addi 4,4,1
.L25:
	lwz 11,0(3)
	lbz 9,0(11)
	addi 9,9,-48
	cmplwi 0,9,9
	bc 4,1,.L27
	b .L48
.L24:
	cmpwi 0,11,40
	bc 4,2,.L30
	li 0,5
.L49:
	stw 0,0(5)
	lwz 9,0(3)
	lbz 0,0(9)
	addi 9,9,1
	stb 0,0(4)
	stw 9,0(3)
	stb 10,1(4)
	blr
.L30:
	cmpwi 0,11,41
	bc 4,2,.L31
	li 0,6
	b .L49
.L31:
	cmpwi 0,11,59
	bc 4,2,.L32
	li 0,7
	b .L49
.L32:
	cmpwi 0,11,58
	bc 4,2,.L33
	li 0,8
	b .L49
.L33:
	cmpwi 0,11,44
	bc 4,2,.L34
	li 0,9
	b .L49
.L34:
	cmpwi 0,11,46
	li 0,10
	bc 12,2,.L49
	lbz 0,0(7)
	cmpwi 0,0,39
	bc 4,2,.L36
	li 0,11
	b .L49
.L36:
	cmpwi 0,0,43
	bc 4,2,.L37
	li 0,12
.L50:
	li 11,0
	stw 0,0(5)
	lwz 9,0(3)
	lbz 0,0(9)
	addi 9,9,1
	stb 0,0(4)
	stw 9,0(3)
	stb 11,1(4)
	blr
.L37:
	cmpwi 0,0,45
	bc 4,2,.L38
	li 0,13
	b .L50
.L38:
	cmpwi 0,0,42
	bc 4,2,.L39
	li 0,14
	b .L50
.L39:
	cmpwi 0,0,47
	bc 4,2,.L40
	li 0,15
	b .L50
.L40:
	cmpwi 0,0,94
	bc 4,2,.L41
	li 0,16
	b .L50
.L41:
	cmpwi 0,0,61
	bc 4,2,.L42
	li 0,17
	b .L50
.L42:
	cmpwi 0,0,35
	bc 4,2,.L43
	li 0,18
	b .L50
.L43:
	cmpwi 0,0,33
	li 0,19
	bc 12,2,.L50
	li 0,0
	stw 0,0(5)
	blr
.Lfe1:
	.size	 scanner,.Lfe1-scanner
	.align 2
	.globl nmtoken
	.type	 nmtoken,@function
nmtoken:
	lis 9,tokenNames.6@ha
	slwi 3,3,2
	la 9,tokenNames.6@l(9)
	lwzx 3,9,3
	blr
.Lfe2:
	.size	 nmtoken,.Lfe2-nmtoken
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
