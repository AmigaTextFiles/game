	.file	"s_conversation.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"jdan.ucs"
	.align 2
.LC1:
	.string	"Error Loading Conversation File"
	.align 2
.LC2:
	.string	"game"
	.align 2
.LC3:
	.string	""
	.align 2
.LC4:
	.string	"basedir"
	.align 2
.LC5:
	.string	"."
	.align 2
.LC6:
	.string	"baseq2"
	.align 2
.LC7:
	.string	"%s"
	.align 2
.LC8:
	.string	"%s\\%s\\conversation\\%s"
	.align 2
.LC9:
	.string	"r"
	.align 2
.LC10:
	.string	"Error Opening %s 001\n"
	.align 2
.LC11:
	.string	"msg"
	.align 2
.LC12:
	.string	"bck"
	.align 2
.LC13:
	.string	"nme"
	.align 2
.LC14:
	.string	"pic"
	.align 2
.LC15:
	.string	"ded"
	.align 2
.LC16:
	.string	"wav"
	.align 2
.LC17:
	.string	"del"
	.align 2
.LC18:
	.string	"tgt"
	.align 2
.LC19:
	.string	"spt"
	.align 2
.LC20:
	.string	"con"
	.align 2
.LC21:
	.string	"end"
	.align 2
.LC22:
	.string	"-_Incorrect Underscore Placement_-\n"
	.section	".text"
	.align 2
	.globl loadconversation
	.type	 loadconversation,@function
loadconversation:
	stwu 1,-976(1)
	mflr 0
	stmw 15,908(1)
	stw 0,980(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	lis 28,.LC3@ha
	lwz 9,144(29)
	lis 3,.LC2@ha
	la 4,.LC3@l(28)
	li 5,0
	la 3,.LC2@l(3)
	mtlr 9
	blrl
	mr 31,3
	lwz 0,144(29)
	lis 4,.LC5@ha
	lis 3,.LC4@ha
	la 4,.LC5@l(4)
	li 5,0
	mtlr 0
	la 3,.LC4@l(3)
	blrl
	mr 30,3
	la 4,.LC3@l(28)
	lwz 3,4(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L9
	addi 29,1,264
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	b .L40
.L9:
	addi 29,1,264
	lwz 5,4(31)
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
.L40:
	mr 6,29
	lwz 5,4(30)
	lis 4,.LC8@ha
	mr 7,27
	la 4,.LC8@l(4)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	lis 4,.LC9@ha
	addi 3,1,8
	la 4,.LC9@l(4)
	bl fopen
	mr. 28,3
	bc 4,2,.L11
	lis 9,gi+4@ha
	lis 3,.LC10@ha
	lwz 0,gi+4@l(9)
	la 3,.LC10@l(3)
	mr 4,27
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L39
.L11:
	lis 11,conversation_content+128@ha
	lis 9,gi@ha
	la 11,conversation_content+128@l(11)
	la 21,gi@l(9)
	mr 25,11
	li 19,1
	addi 15,25,-64
	addi 17,25,512
	addi 16,25,548
	addi 18,25,580
	li 20,1
	lis 26,output_string@ha
	addi 31,1,856
	addi 27,11,-128
	addi 24,11,-96
	addi 22,11,-24
	li 30,0
	addi 23,1,888
.L14:
	mr 3,28
	bl fgetc
	rlwinm 3,3,0,0xff
	cmpwi 0,3,95
	bc 4,2,.L12
	addi 29,1,344
	li 4,4
	mr 5,28
	mr 3,29
	bl fgets
	lis 4,.LC11@ha
	mr 3,29
	la 4,.LC11@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L16
	addi 25,25,776
	li 4,512
	mr 3,25
	mr 5,28
	bl fgets
	addi 22,22,776
	addi 27,27,776
	addi 24,24,776
	addi 30,30,776
	stw 20,0(22)
	b .L12
.L16:
	lis 4,.LC12@ha
	mr 3,29
	la 4,.LC12@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L18
	mr 5,28
	li 4,512
	mr 3,24
	bl fgets
	mr 4,24
	b .L41
.L18:
	lis 4,.LC13@ha
	mr 3,29
	la 4,.LC13@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L20
	add 3,30,15
	b .L42
.L20:
	lis 4,.LC14@ha
	mr 3,29
	la 4,.LC14@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L22
	mr 5,28
	li 4,32
	mr 3,27
	bl fgets
	mr 4,27
.L41:
	la 3,output_string@l(26)
	bl strcpy
	la 3,output_string@l(26)
	bl givemequotes
	lwz 9,40(21)
	la 3,output_string@l(26)
	mtlr 9
	blrl
	b .L12
.L22:
	lis 4,.LC15@ha
	mr 3,29
	la 4,.LC15@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L24
	stw 20,100(27)
	b .L12
.L24:
	lis 4,.LC16@ha
	mr 3,29
	la 4,.LC16@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L26
	li 4,2
	mr 5,28
	mr 3,31
	add 29,30,17
	bl fgets
	li 4,32
	mr 5,28
	mr 3,31
	bl fgets
	mr 3,31
	bl strlen
	addi 5,3,-1
	mr 4,31
	mr 3,29
	bl strncat
	b .L12
.L26:
	lis 4,.LC17@ha
	mr 3,29
	la 4,.LC17@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L28
	li 4,4
	mr 5,28
	mr 3,23
	bl fgets
	mr 3,23
	bl atoi
	stw 3,672(27)
	b .L12
.L28:
	lis 4,.LC18@ha
	mr 3,29
	la 4,.LC18@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L30
	add 3,30,16
	b .L42
.L30:
	lis 4,.LC19@ha
	mr 3,29
	la 4,.LC19@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L32
	add 3,30,18
.L42:
	li 4,32
	mr 5,28
	bl fgets
	b .L12
.L32:
	lis 4,.LC20@ha
	mr 3,29
	la 4,.LC20@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L34
	lis 3,conversation_content+740@ha
	li 4,32
	la 3,conversation_content+740@l(3)
	mr 5,28
	add 3,30,3
	bl fgets
	b .L12
.L34:
	lis 4,.LC21@ha
	mr 3,29
	la 4,.LC21@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L36
	li 19,0
	b .L12
.L36:
	lwz 9,4(21)
	lis 3,.LC22@ha
	la 3,.LC22@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
.L12:
	cmpwi 0,19,0
	bc 4,2,.L14
	mr 3,28
	bl fclose
	li 3,1
.L39:
	lwz 0,980(1)
	mtlr 0
	lmw 15,908(1)
	la 1,976(1)
	blr
.Lfe1:
	.size	 loadconversation,.Lfe1-loadconversation
	.align 2
	.globl clearglobals
	.type	 clearglobals,@function
clearglobals:
	blr
.Lfe2:
	.size	 clearglobals,.Lfe2-clearglobals
	.section	".rodata"
	.align 2
.LC23:
	.string	"xv 0 yv 0 picn"
	.align 2
.LC24:
	.string	" xv 4 yv 10 string "
	.align 2
.LC25:
	.string	"xv 4 yv 10 string "
	.align 2
.LC26:
	.string	" xv 229 yv 0 picn"
	.align 2
.LC27:
	.string	" xv 20 yv 26 string "
	.align 2
.LC28:
	.string	" xv 20 yv 34 string "
	.align 2
.LC29:
	.string	" xv 20 yv 42 string "
	.align 2
.LC30:
	.string	" xv 20 yv 50 string "
	.align 2
.LC31:
	.string	" xv 20 yv 58 string "
	.align 2
.LC32:
	.string	" xv 20 yv 66 string "
	.align 2
.LC33:
	.string	" xv 0 yv "
	.align 2
.LC34:
	.string	"%d "
	.align 2
.LC35:
	.string	"string2 "
	.align 2
.LC36:
	.string	"string "
	.align 2
.LC37:
	.string	"Error: Too long string"
	.align 2
.LC38:
	.string	"xv 12 yv 12 string2 \"Error; Too long string\" "
	.section	".text"
	.align 2
	.globl ConversationRedraw
	.type	 ConversationRedraw,@function
ConversationRedraw:
	stwu 1,-1232(1)
	mflr 0
	stmw 15,1164(1)
	stw 0,1236(1)
	lis 9,.LC3@ha
	lis 11,output_string@ha
	lbz 0,.LC3@l(9)
	la 30,.LC3@l(9)
	lis 31,conversation_content+808@ha
	la 3,conversation_content+808@l(31)
	mr 4,30
	stb 0,output_string@l(11)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L50
	lis 9,.LC23@ha
	addi 29,1,8
	lwz 8,.LC23@l(9)
	la 3,conversation_content+808@l(31)
	la 9,.LC23@l(9)
	lbz 7,14(9)
	lwz 0,4(9)
	lwz 11,8(9)
	lhz 10,12(9)
	stw 8,8(1)
	stw 0,4(29)
	stw 11,8(29)
	sth 10,12(29)
	stb 7,14(29)
	bl strlen
	addi 5,3,-1
	la 4,conversation_content+808@l(31)
	mr 3,29
	bl strncat
.L50:
	lis 3,conversation_content+840@ha
	mr 4,30
	la 3,conversation_content+840@l(3)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L51
	la 3,conversation_content+808@l(31)
	mr 4,30
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L52
	lis 4,.LC24@ha
	addi 3,1,8
	la 4,.LC24@l(4)
	bl strcat
	b .L53
.L52:
	lis 9,.LC25@ha
	addi 11,1,8
	lwz 5,.LC25@l(9)
	la 9,.LC25@l(9)
	lbz 0,18(9)
	lwz 10,4(9)
	lwz 8,8(9)
	lwz 7,12(9)
	lhz 6,16(9)
	stw 5,8(1)
	stb 0,18(11)
	stw 10,4(11)
	stw 8,8(11)
	stw 7,12(11)
	sth 6,16(11)
.L53:
	lis 29,conversation_content+840@ha
	lis 28,output_string@ha
	la 3,conversation_content+840@l(29)
	bl strlen
	addi 5,3,-1
	la 4,conversation_content+840@l(29)
	la 3,output_string@l(28)
	bl strncat
	la 4,output_string@l(28)
	addi 3,1,8
	bl strcat
.L51:
	lis 29,conversation_content+776@ha
	lis 4,.LC3@ha
	la 4,.LC3@l(4)
	la 3,conversation_content+776@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L54
	lis 4,.LC26@ha
	addi 3,1,8
	la 4,.LC26@l(4)
	bl strcat
	la 3,conversation_content+776@l(29)
	bl strlen
	addi 5,3,-1
	la 4,conversation_content+776@l(29)
	addi 3,1,8
	bl strncat
.L54:
	lis 9,conversation_content@ha
	la 31,conversation_content@l(9)
	lwz 0,880(31)
	cmpwi 0,0,1
	bc 4,2,.L55
	lis 4,.LC27@ha
	addi 3,1,8
	la 4,.LC27@l(4)
	bl strcat
	li 5,0
	li 4,20
	addi 3,31,904
	bl MakeMeStrings
	mr 4,3
	addi 3,1,8
	bl strcat
	addi 3,31,904
	bl strlen
	cmplwi 0,3,20
	bc 4,1,.L56
	lis 4,.LC28@ha
	addi 3,1,8
	la 4,.LC28@l(4)
	bl strcat
	li 4,20
	addi 3,31,904
	li 5,1
	bl MakeMeStrings
	mr 4,3
	addi 3,1,8
	bl strcat
.L56:
	addi 3,31,904
	bl strlen
	cmplwi 0,3,40
	bc 4,1,.L57
	lis 4,.LC29@ha
	addi 3,1,8
	la 4,.LC29@l(4)
	bl strcat
	li 4,20
	addi 3,31,904
	li 5,2
	bl MakeMeStrings
	mr 4,3
	addi 3,1,8
	bl strcat
.L57:
	addi 3,31,904
	bl strlen
	cmplwi 0,3,60
	bc 4,1,.L58
	lis 4,.LC30@ha
	addi 3,1,8
	la 4,.LC30@l(4)
	bl strcat
	li 4,20
	addi 3,31,904
	li 5,3
	bl MakeMeStrings
	mr 4,3
	addi 3,1,8
	bl strcat
.L58:
	addi 3,31,904
	bl strlen
	cmplwi 0,3,80
	bc 4,1,.L59
	lis 4,.LC31@ha
	addi 3,1,8
	la 4,.LC31@l(4)
	bl strcat
	li 4,20
	addi 3,31,904
	li 5,4
	bl MakeMeStrings
	mr 4,3
	addi 3,1,8
	bl strcat
.L59:
	addi 3,31,904
	bl strlen
	cmplwi 0,3,100
	bc 4,1,.L55
	lis 4,.LC32@ha
	addi 3,1,8
	la 4,.LC32@l(4)
	bl strcat
	li 4,20
	addi 3,31,904
	li 5,5
	bl MakeMeStrings
	mr 4,3
	addi 3,1,8
	bl strcat
.L55:
	lis 9,conversation_content@ha
	li 17,1
	la 16,conversation_content@l(9)
	addi 22,1,1032
	addi 19,16,128
	addi 15,16,108
	mr 18,19
	lis 20,.LC35@ha
	lis 21,.LC36@ha
	addi 23,16,884
	li 25,776
	li 24,40
.L63:
	addi 25,25,776
	addi 9,16,104
	lwzx 0,9,25
	addi 23,23,776
	addi 24,24,40
	addi 17,17,1
	cmpwi 0,0,1
	bc 4,2,.L61
	lis 4,.LC33@ha
	addi 3,1,8
	la 4,.LC33@l(4)
	lis 26,.LC33@ha
	bl strcat
	mr 31,24
	mr 30,22
	lis 4,.LC34@ha
	addi 5,24,30
	la 4,.LC34@l(4)
	mr 3,22
	crxor 6,6,6
	bl sprintf
	lis 27,.LC34@ha
	addi 3,1,8
	mr 4,22
	bl strcat
	lwz 0,0(23)
	cmpwi 0,0,1
	bc 4,2,.L65
	addi 3,1,8
	la 4,.LC35@l(20)
	bl strcat
	b .L66
.L65:
	addi 3,1,8
	la 4,.LC36@l(21)
	bl strcat
.L66:
	add 29,25,18
	li 5,0
	li 4,20
	mr 3,29
	bl MakeMeStrings
	mr 28,25
	mr 4,3
	addi 3,1,8
	bl strcat
	mr 3,29
	bl strlen
	cmplwi 0,3,20
	bc 4,1,.L67
	addi 3,1,8
	la 4,.LC33@l(26)
	bl strcat
	la 4,.LC34@l(27)
	addi 5,31,38
	mr 3,30
	crxor 6,6,6
	bl sprintf
	addi 3,1,8
	mr 4,30
	bl strcat
	lwz 0,0(23)
	cmpwi 0,0,1
	bc 4,2,.L68
	addi 3,1,8
	la 4,.LC35@l(20)
	bl strcat
	b .L69
.L68:
	addi 3,1,8
	la 4,.LC36@l(21)
	bl strcat
.L69:
	li 4,20
	add 3,28,19
	li 5,1
	bl MakeMeStrings
	mr 4,3
	addi 3,1,8
	bl strcat
.L67:
	add 3,28,18
	bl strlen
	cmplwi 0,3,40
	bc 4,1,.L70
	addi 3,1,8
	la 4,.LC33@l(26)
	bl strcat
	la 4,.LC34@l(27)
	addi 5,31,46
	mr 3,30
	crxor 6,6,6
	bl sprintf
	addi 3,1,8
	mr 4,30
	bl strcat
	lwzx 0,15,28
	cmpwi 0,0,1
	bc 4,2,.L71
	addi 3,1,8
	la 4,.LC35@l(20)
	bl strcat
	b .L72
.L71:
	addi 3,1,8
	la 4,.LC36@l(21)
	bl strcat
.L72:
	li 4,20
	add 3,28,19
	li 5,2
	bl MakeMeStrings
	mr 4,3
	addi 3,1,8
	bl strcat
.L70:
	add 3,28,18
	bl strlen
	cmplwi 0,3,60
	bc 4,1,.L61
	addi 3,1,8
	la 4,.LC33@l(26)
	bl strcat
	la 4,.LC34@l(27)
	addi 5,31,52
	mr 3,30
	crxor 6,6,6
	bl sprintf
	mr 4,30
	addi 3,1,8
	bl strcat
	lwzx 0,15,28
	cmpwi 0,0,1
	bc 4,2,.L74
	addi 3,1,8
	la 4,.LC35@l(20)
	bl strcat
	b .L75
.L74:
	addi 3,1,8
	la 4,.LC36@l(21)
	bl strcat
.L75:
	li 4,20
	add 3,28,19
	li 5,3
	bl MakeMeStrings
	mr 4,3
	addi 3,1,8
	bl strcat
.L61:
	cmpwi 0,17,10
	bc 4,2,.L63
	addi 3,1,8
	bl strlen
	cmplwi 0,3,1024
	bc 12,1,.L77
	addi 3,1,8
	b .L78
.L77:
	lis 9,gi+4@ha
	lis 3,.LC37@ha
	lwz 0,gi+4@l(9)
	la 3,.LC37@l(3)
	addi 29,1,8
	mtlr 0
	crxor 6,6,6
	blrl
	lis 4,.LC38@ha
	mr 3,29
	la 4,.LC38@l(4)
	li 5,46
	crxor 6,6,6
	bl memcpy
	mr 3,29
.L78:
	lwz 0,1236(1)
	mtlr 0
	lmw 15,1164(1)
	la 1,1232(1)
	blr
.Lfe3:
	.size	 ConversationRedraw,.Lfe3-ConversationRedraw
	.section	".rodata"
	.align 2
.LC39:
	.string	"-_Error_-2"
	.section	".text"
	.align 2
	.globl MakeMeStrings
	.type	 MakeMeStrings,@function
MakeMeStrings:
	stwu 1,-32(1)
	stmw 29,20(1)
	mullw. 11,4,5
	li 7,0
	bc 12,2,.L80
	add 9,11,3
	addi 5,5,1
	lbz 0,-1(9)
	cmpwi 0,0,95
	bc 12,2,.L85
	addi 0,11,-1
	add 9,0,3
.L83:
	lbzu 0,-1(9)
	addi 11,11,-1
	cmpwi 0,0,95
	bc 4,2,.L83
	b .L85
.L80:
	lbz 0,0(3)
	addi 5,5,1
	cmpwi 0,0,95
	bc 4,2,.L85
.L88:
	addi 11,11,1
	lbzx 0,3,11
	cmpwi 0,0,95
	bc 12,2,.L88
.L85:
	lis 31,output_string@ha
	mullw 4,4,5
	addi 0,7,3
	la 6,output_string@l(31)
	li 29,95
	add 10,0,6
	li 30,10
	li 12,0
	lis 5,output_string@ha
.L92:
	li 8,0
	li 9,0
.L95:
	addi 11,11,1
	addi 8,8,1
	lbzx 0,3,11
	cmpwi 0,0,95
	bc 12,2,.L99
	bc 12,1,.L93
	cmpwi 0,0,0
	bc 12,2,.L99
	cmpwi 0,0,10
	bc 4,2,.L93
.L99:
	li 9,1
.L93:
	cmpwi 0,9,1
	bc 4,2,.L95
	cmpw 0,11,4
	bc 4,1,.L103
	la 3,output_string@l(31)
	b .L115
.L103:
	mr 9,11
	subf 11,8,9
	cmpw 0,11,9
	bc 12,2,.L105
	la 8,output_string@l(5)
.L106:
	lbzx 0,3,11
	addi 10,10,1
	addi 11,11,1
	cmpw 0,11,9
	stbx 0,8,7
	addi 7,7,1
	bc 4,2,.L106
.L105:
	stb 29,-2(10)
	li 9,0
	addi 8,7,1
	stb 30,-1(10)
	stb 12,0(10)
	lbzx 0,3,11
	cmpwi 0,0,0
	bc 12,2,.L110
	cmpwi 0,0,10
	bc 4,2,.L108
.L110:
	li 9,2
.L108:
	cmpwi 0,9,2
	bc 4,2,.L92
	stbx 12,6,8
	mr 3,6
.L115:
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 MakeMeStrings,.Lfe4-MakeMeStrings
	.section	".rodata"
	.align 2
.LC40:
	.string	"%s\\%s\\sound\\%s"
	.align 2
.LC41:
	.long 0x3f800000
	.align 2
.LC42:
	.long 0x0
	.align 3
.LC43:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl IChooseYou
	.type	 IChooseYou,@function
IChooseYou:
	stwu 1,-1408(1)
	mflr 0
	stmw 26,1384(1)
	stw 0,1412(1)
	lis 9,highlighted@ha
	lis 11,conversation_content+640@ha
	lwz 3,highlighted@l(9)
	la 11,conversation_content+640@l(11)
	li 0,1
	lis 9,NoTouch@ha
	lis 4,.LC3@ha
	mulli 3,3,776
	stw 0,NoTouch@l(9)
	la 4,.LC3@l(4)
	lis 27,highlighted@ha
	lis 26,.LC3@ha
	add 3,3,11
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L127
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 4,.LC3@l(26)
	lwz 9,144(29)
	li 5,0
	la 3,.LC2@l(3)
	mtlr 9
	blrl
	mr 31,3
	lwz 0,144(29)
	lis 4,.LC5@ha
	lis 3,.LC4@ha
	la 4,.LC5@l(4)
	li 5,0
	mtlr 0
	la 3,.LC4@l(3)
	blrl
	mr 28,3
	la 4,.LC3@l(26)
	lwz 3,4(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L128
	addi 29,1,264
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	b .L140
.L128:
	addi 29,1,264
	lwz 5,4(31)
	lis 4,.LC7@ha
	la 4,.LC7@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
.L140:
	mr 6,29
	lis 9,highlighted@ha
	lis 11,conversation_content+640@ha
	lwz 5,4(28)
	lwz 7,highlighted@l(9)
	la 30,conversation_content+640@l(11)
	lis 4,.LC40@ha
	la 4,.LC40@l(4)
	addi 3,1,8
	mulli 7,7,776
	add 7,7,30
	crxor 6,6,6
	bl sprintf
	lis 4,.LC9@ha
	addi 3,1,8
	la 4,.LC9@l(4)
	bl fopen
	mr. 3,3
	bc 4,2,.L130
	bl G_Spawn
	lis 9,IChooseYou2@ha
	mr 29,3
	la 9,IChooseYou2@l(9)
	lis 0,0x3f80
	stw 9,436(29)
	stw 0,428(29)
	b .L126
.L130:
	bl fclose
	lis 29,output_string@ha
	lwz 4,highlighted@l(27)
	la 31,output_string@l(29)
	addi 28,1,344
	mr 3,31
	mulli 4,4,776
	add 4,4,30
	bl strcpy
	mr 3,31
	bl strlen
	li 11,0
	li 0,34
	cmpw 0,11,3
	stb 0,344(1)
	bc 12,2,.L134
	li 10,1
.L133:
	lbzx 9,31,11
	mr 0,10
	mr 11,0
	cmpw 0,11,3
	stbx 9,10,28
	addi 10,10,1
	bc 4,2,.L133
.L134:
	lbzx 10,31,11
	addi 9,11,1
	li 0,34
	stbx 0,28,9
	addi 11,11,2
	addi 4,1,344
	stbx 10,28,11
	mr 3,31
	bl strcpy
	lis 29,gi@ha
	lis 3,output_string@ha
	la 29,gi@l(29)
	la 3,output_string@l(3)
	lwz 11,36(29)
	lis 9,its_me@ha
	lwz 28,its_me@l(9)
	mtlr 11
	blrl
	lis 9,.LC41@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC41@l(9)
	mr 3,28
	lfs 1,0(9)
	mtlr 0
	li 4,2
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfs 2,0(9)
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	lfs 3,0(9)
	blrl
	bl G_Spawn
	lis 9,highlighted@ha
	lis 11,conversation_content@ha
	lwz 10,highlighted@l(9)
	la 11,conversation_content@l(11)
	addi 11,11,672
	lis 7,0x4330
	mulli 10,10,776
	lis 9,.LC43@ha
	mr 29,3
	la 9,.LC43@l(9)
	lwzx 0,11,10
	lfd 13,0(9)
	xoris 0,0,0x8000
	lis 9,IChooseYou2@ha
	stw 0,1380(1)
	la 9,IChooseYou2@l(9)
	stw 7,1376(1)
	lfd 0,1376(1)
	stw 9,436(29)
	fsub 0,0,13
	frsp 0,0
	stfs 0,428(29)
.L127:
	lis 9,highlighted@ha
	lis 11,conversation_content+676@ha
	lwz 3,highlighted@l(9)
	la 31,conversation_content+676@l(11)
	lis 4,.LC3@ha
	la 4,.LC3@l(4)
	mulli 3,3,776
	add 3,3,31
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L136
	bl G_Spawn
	lwz 0,highlighted@l(27)
	lis 9,its_me@ha
	mr 29,3
	lwz 4,its_me@l(9)
	mulli 0,0,776
	add 0,0,31
	stw 0,296(29)
	bl G_UseTargets
	mr 3,29
	bl G_FreeEdict
.L136:
	lwz 0,highlighted@l(27)
	addi 11,31,-576
	addi 30,31,-676
	mulli 0,0,776
	lwzx 9,11,0
	cmpwi 0,9,1
	bc 4,2,.L137
	lis 9,its_me@ha
	li 0,0
	lwz 8,its_me@l(9)
	lis 11,holdthephone@ha
	lis 10,NoTouch@ha
	stw 0,holdthephone@l(11)
	lwz 9,84(8)
	stw 0,NoTouch@l(10)
	stw 0,4112(9)
	b .L126
.L137:
	addi 31,31,64
	la 4,.LC3@l(26)
	add 3,0,31
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L126
	lwz 3,highlighted@l(27)
	mulli 3,3,776
	add 3,3,31
	bl loadconversation
	mr. 29,3
	bc 4,2,.L139
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,NoTouch@ha
	stw 29,NoTouch@l(9)
	b .L126
.L139:
	li 8,1
	li 0,2
	lis 10,NoTouch@ha
	li 11,0
	stw 0,highlighted@l(27)
	lis 9,holdthephone@ha
	stw 11,NoTouch@l(10)
	stw 8,holdthephone@l(9)
	stw 8,1660(30)
.L126:
	lwz 0,1412(1)
	mtlr 0
	lmw 26,1384(1)
	la 1,1408(1)
	blr
.Lfe5:
	.size	 IChooseYou,.Lfe5-IChooseYou
	.align 2
	.globl IChooseYou2
	.type	 IChooseYou2,@function
IChooseYou2:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	bl G_FreeEdict
	lis 30,highlighted@ha
	lis 28,.LC3@ha
	lwz 3,highlighted@l(30)
	lis 9,conversation_content+676@ha
	la 4,.LC3@l(28)
	la 31,conversation_content+676@l(9)
	mulli 3,3,776
	add 3,3,31
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L142
	bl G_Spawn
	lwz 0,highlighted@l(30)
	lis 9,its_me@ha
	mr 29,3
	lwz 4,its_me@l(9)
	mulli 0,0,776
	add 0,0,31
	stw 0,296(29)
	bl G_UseTargets
	mr 3,29
	bl G_FreeEdict
.L142:
	lwz 0,highlighted@l(30)
	addi 11,31,-576
	addi 29,31,-676
	mulli 0,0,776
	lwzx 9,11,0
	cmpwi 0,9,1
	bc 4,2,.L143
	lis 9,its_me@ha
	li 0,0
	lwz 8,its_me@l(9)
	lis 11,holdthephone@ha
	lis 10,NoTouch@ha
	stw 0,holdthephone@l(11)
	lwz 9,84(8)
	stw 0,NoTouch@l(10)
	stw 0,4112(9)
	b .L141
.L143:
	addi 31,31,64
	la 4,.LC3@l(28)
	add 3,0,31
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L141
	lwz 3,highlighted@l(30)
	mulli 3,3,776
	add 3,3,31
	bl loadconversation
	mr. 31,3
	bc 4,2,.L145
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,NoTouch@ha
	stw 31,NoTouch@l(9)
	b .L141
.L145:
	li 8,1
	li 0,2
	lis 10,NoTouch@ha
	li 11,0
	stw 0,highlighted@l(30)
	lis 9,holdthephone@ha
	stw 11,NoTouch@l(10)
	stw 8,holdthephone@l(9)
	stw 8,1660(29)
.L141:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 IChooseYou2,.Lfe6-IChooseYou2
	.comm	node_count,2,2
	.comm	path_not_time_yet,4,4
	.align 2
	.globl JustTalk
	.type	 JustTalk,@function
JustTalk:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	bl clearglobals
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	bl loadconversation
	cmpwi 0,3,0
	bc 4,2,.L7
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L7:
	li 6,1
	lis 9,conversation_content+1660@ha
	lis 8,highlighted@ha
	li 0,2
	stw 6,conversation_content+1660@l(9)
	stw 0,highlighted@l(8)
	lis 7,NoTouch@ha
	li 11,0
	lis 10,holdthephone@ha
	lis 8,yeah_you@ha
	stw 11,NoTouch@l(7)
	lis 9,its_me@ha
	stw 6,holdthephone@l(10)
	stw 31,yeah_you@l(8)
	stw 30,its_me@l(9)
.L6:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe7:
	.size	 JustTalk,.Lfe7-JustTalk
	.align 2
	.globl givemequotes
	.type	 givemequotes,@function
givemequotes:
	stwu 1,-1040(1)
	mflr 0
	stw 31,1036(1)
	stw 0,1044(1)
	mr 31,3
	bl strlen
	li 11,0
	li 0,34
	cmpw 0,11,3
	addi 4,1,8
	stb 0,8(1)
	bc 12,2,.L118
	mr 8,4
	li 10,1
.L119:
	lbzx 9,31,11
	mr 0,10
	mr 11,0
	cmpw 0,11,3
	stbx 9,10,8
	addi 10,10,1
	bc 4,2,.L119
.L118:
	lbzx 10,31,11
	addi 9,11,1
	li 0,34
	stbx 0,4,9
	addi 11,11,2
	mr 3,31
	stbx 10,4,11
	bl strcpy
	lwz 0,1044(1)
	mtlr 0
	lwz 31,1036(1)
	la 1,1040(1)
	blr
.Lfe8:
	.size	 givemequotes,.Lfe8-givemequotes
	.align 2
	.globl givemequotes2
	.type	 givemequotes2,@function
givemequotes2:
	stwu 1,-1040(1)
	mflr 0
	stw 0,1044(1)
	lis 3,output_string@ha
	la 3,output_string@l(3)
	bl strlen
	li 10,0
	li 0,92
	cmpw 0,10,3
	li 9,34
	stb 0,8(1)
	addi 4,1,8
	stb 9,9(1)
	bc 12,2,.L123
	lis 9,output_string@ha
	addi 11,1,10
	la 9,output_string@l(9)
.L124:
	lbzx 0,9,10
	addi 10,10,1
	cmpw 0,10,3
	stb 0,0(11)
	addi 11,11,1
	bc 4,2,.L124
.L123:
	addi 9,10,2
	li 0,92
	stbx 0,4,9
	addi 11,10,3
	lis 3,output_string@ha
	li 0,34
	addi 9,10,4
	stbx 0,4,11
	la 3,output_string@l(3)
	li 0,0
	stbx 0,4,9
	bl strcpy
	lwz 0,1044(1)
	mtlr 0
	la 1,1040(1)
	blr
.Lfe9:
	.size	 givemequotes2,.Lfe9-givemequotes2
	.comm	conversation_content,7760,4
	.comm	highlighted,4,4
	.comm	yeah_you,4,4
	.comm	its_me,4,4
	.comm	holdthephone,4,4
	.comm	NoTouch,4,4
	.comm	showingit,4,4
	.comm	path_time,4,4
	.comm	print_time,4,4
	.comm	output_string,1024,4
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
