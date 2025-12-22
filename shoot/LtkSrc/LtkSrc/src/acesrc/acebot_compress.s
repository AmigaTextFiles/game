	.file	"acebot_compress.c"
gcc2_compiled.:
	.globl textsize
	.section	".sdata","aw"
	.align 2
	.type	 textsize,@object
	.size	 textsize,4
textsize:
	.long 0
	.globl codesize
	.align 2
	.type	 codesize,@object
	.size	 codesize,4
codesize:
	.long 0
	.globl printcount
	.align 2
	.type	 printcount,@object
	.size	 printcount,4
printcount:
	.long 0
	.section	".text"
	.align 2
	.globl InsertNode
	.type	 InsertNode,@function
InsertNode:
	stwu 1,-48(1)
	stmw 24,16(1)
	lis 9,text_buf@ha
	lis 10,rson@ha
	la 9,text_buf@l(9)
	slwi 0,3,2
	lbzx 5,3,9
	li 8,4096
	lis 11,lson@ha
	la 10,rson@l(10)
	la 11,lson@l(11)
	stwx 8,10,0
	mr 12,9
	li 7,0
	add 4,3,9
	lis 6,match_length@ha
	stwx 8,11,0
	lis 9,dad@ha
	stw 7,match_length@l(6)
	mr 24,12
	mr 31,0
	la 25,dad@l(9)
	addi 5,5,4097
	li 7,1
	lis 26,match_length@ha
	lis 27,rson@ha
	lis 28,lson@ha
	lis 29,match_length@ha
	lis 30,match_position@ha
.L18:
	cmpwi 0,7,0
	bc 12,0,.L21
	la 11,rson@l(27)
	slwi 9,5,2
	lwzx 0,11,9
	cmpwi 0,0,4096
	bc 4,2,.L38
	stwx 3,11,9
	stwx 5,25,31
	b .L17
.L21:
	la 10,lson@l(28)
	slwi 11,5,2
	lwzx 0,10,11
	cmpwi 0,0,4096
	bc 12,2,.L37
.L38:
	mr 5,0
	addi 0,5,1
	li 11,1
	lbzx 9,12,0
	slwi 6,3,2
	slwi 8,5,2
	lbzx 0,4,11
	subf. 7,9,0
	bc 4,2,.L28
	add 9,5,24
	addi 10,9,1
.L29:
	addi 11,11,1
	cmpwi 0,11,17
	bc 12,1,.L28
	lbzx 9,4,11
	lbzu 0,1(10)
	subf. 7,0,9
	bc 12,2,.L29
.L28:
	lwz 0,match_length@l(29)
	cmpw 0,11,0
	bc 4,1,.L18
	cmpwi 0,11,17
	stw 5,match_position@l(30)
	stw 11,match_length@l(26)
	bc 4,1,.L18
	lis 9,lson@ha
	lis 11,rson@ha
	la 4,lson@l(9)
	la 7,rson@l(11)
	lwzx 10,4,8
	lis 9,dad@ha
	lwzx 0,7,8
	la 9,dad@l(9)
	stwx 10,4,6
	stwx 0,7,6
	lwzx 10,9,8
	lwzx 0,4,8
	lwzx 11,7,8
	stwx 10,9,6
	slwi 0,0,2
	stwx 3,9,0
	slwi 11,11,2
	stwx 3,9,11
	lwzx 0,9,8
	slwi 0,0,2
	lwzx 9,7,0
	cmpw 0,9,5
	bc 4,2,.L35
	stwx 3,7,0
	b .L36
.L37:
	lis 9,dad@ha
	slwi 0,3,2
	stwx 3,10,11
	la 9,dad@l(9)
	stwx 5,9,0
	b .L17
.L35:
	stwx 3,4,0
.L36:
	lis 9,dad@ha
	li 0,4096
	la 9,dad@l(9)
	stwx 0,9,8
.L17:
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 InsertNode,.Lfe1-InsertNode
	.align 2
	.globl DeleteNode
	.type	 DeleteNode,@function
DeleteNode:
	lis 9,dad@ha
	slwi 11,3,2
	la 9,dad@l(9)
	lwzx 0,9,11
	cmpwi 0,0,4096
	bclr 12,2
	lis 9,rson@ha
	la 10,rson@l(9)
	lwzx 0,10,11
	cmpwi 0,0,4096
	bc 4,2,.L41
	lis 9,lson@ha
	mr 12,11
	la 9,lson@l(9)
	lwzx 5,9,11
	b .L42
.L41:
	lis 9,lson@ha
	mr 5,0
	la 9,lson@l(9)
	mr 12,11
	lwzx 0,9,11
	cmpwi 0,0,4096
	bc 12,2,.L42
	mr 5,0
	slwi 0,5,2
	lwzx 9,10,0
	cmpwi 0,9,4096
	bc 12,2,.L45
	mr 9,10
.L49:
	slwi 0,5,2
	lwzx 5,9,0
	slwi 4,5,2
	lwzx 0,9,4
	cmpwi 0,0,4096
	bc 4,2,.L49
	lis 9,lson@ha
	lis 10,dad@ha
	la 9,lson@l(9)
	la 10,dad@l(10)
	lwzx 0,9,12
	lis 8,rson@ha
	lwzx 6,9,4
	la 8,rson@l(8)
	stwx 0,9,4
	lwzx 0,10,4
	slwi 7,6,2
	lwzx 11,9,12
	stwx 0,10,7
	slwi 0,0,2
	slwi 11,11,2
	stwx 6,8,0
	stwx 5,10,11
.L45:
	lis 9,rson@ha
	slwi 8,5,2
	la 9,rson@l(9)
	lis 11,dad@ha
	lwzx 10,9,12
	la 11,dad@l(11)
	stwx 10,9,8
	lwzx 0,9,12
	slwi 0,0,2
	stwx 5,11,0
.L42:
	lis 9,dad@ha
	slwi 8,5,2
	la 9,dad@l(9)
	lis 11,rson@ha
	lwzx 10,9,12
	la 11,rson@l(11)
	stwx 10,9,8
	lwzx 0,9,12
	slwi 0,0,2
	lwzx 9,11,0
	cmpw 0,9,3
	bc 4,2,.L50
	stwx 5,11,0
	b .L51
.L50:
	lis 9,lson@ha
	la 9,lson@l(9)
	stwx 5,9,0
.L51:
	lis 9,dad@ha
	li 0,4096
	la 9,dad@l(9)
	stwx 0,9,12
	blr
.Lfe2:
	.size	 DeleteNode,.Lfe2-DeleteNode
	.section	".rodata"
	.align 2
.LC0:
	.string	"wb"
	.section	".text"
	.align 2
	.globl Encode
	.type	 Encode,@function
Encode:
	stwu 1,-128(1)
	mflr 0
	stmw 14,56(1)
	stw 0,132(1)
	mr 17,4
	stw 5,44(1)
	li 22,0
	lis 4,.LC0@ha
	stw 6,40(1)
	la 4,.LC0@l(4)
	bl fopen
	mr. 28,3
	bc 12,2,.L126
	li 4,4
	li 5,1
	mr 6,28
	addi 3,1,40
	bl fwrite
	addi 3,1,44
	li 4,4
	li 5,1
	mr 6,28
	bl fwrite
	li 11,256
	lis 9,rson@ha
	mtctr 11
	la 9,rson@l(9)
	li 0,4096
	addi 9,9,16388
.L125:
	stw 0,0(9)
	addi 9,9,4
	bdnz .L125
	li 0,4096
	lis 9,dad@ha
	mtctr 0
	la 9,dad@l(9)
	addi 9,9,16380
.L124:
	stw 0,0(9)
	addi 9,9,-4
	bdnz .L124
	li 23,4078
	li 0,0
	mtctr 23
	lis 9,text_buf@ha
	stb 0,8(1)
	li 20,1
	la 9,text_buf@l(9)
	li 26,1
	addi 9,9,4077
	li 25,0
	li 0,32
.L123:
	stb 0,0(9)
	addi 9,9,-1
	bdnz .L123
	lwz 0,44(1)
	li 24,0
	cmpw 0,22,0
	bc 4,0,.L71
	lis 9,text_buf@ha
	la 9,text_buf@l(9)
	addi 9,9,4078
.L73:
	lbzx 31,17,22
	addi 24,24,1
	cmpwi 0,24,17
	addi 22,22,1
	stb 31,0(9)
	addi 9,9,1
	bc 12,1,.L71
	cmpw 0,22,0
	bc 12,0,.L73
.L71:
	cmpwi 0,24,0
	lis 9,textsize@ha
	stw 24,textsize@l(9)
	bc 4,2,.L76
.L126:
	li 3,-1
	b .L121
.L76:
	lis 19,match_length@ha
	addi 21,1,8
	li 31,4077
	li 30,18
.L80:
	mr 3,31
	bl InsertNode
	addi 31,31,-1
	addic. 30,30,-1
	bc 4,2,.L80
	li 3,4078
	lis 14,match_length@ha
	bl InsertNode
	lis 15,match_position@ha
	mr 18,21
	lis 16,codesize@ha
.L110:
	lwz 0,match_length@l(14)
	cmpw 0,0,24
	bc 4,1,.L85
	stw 24,match_length@l(19)
.L85:
	lwz 0,match_length@l(19)
	cmpwi 0,0,2
	bc 12,1,.L86
	lbz 0,8(1)
	lis 11,text_buf@ha
	la 9,text_buf@l(11)
	lbzx 10,9,23
	or 0,20,0
	li 11,1
	stb 0,8(1)
	stbx 10,21,26
	stw 11,match_length@l(19)
	b .L127
.L86:
	la 9,match_position@l(15)
	lwz 0,match_position@l(15)
	lbz 10,3(9)
	lis 9,match_length@ha
	srawi 0,0,4
	la 9,match_length@l(9)
	rlwinm 0,0,0,0,27
	lbz 11,3(9)
	stbx 10,18,26
	addi 11,11,-3
	addi 26,26,1
	or 0,0,11
	stbx 0,18,26
.L127:
	addi 26,26,1
	rlwinm. 20,20,1,24,30
	bc 4,2,.L88
	li 30,0
	cmpw 0,30,26
	bc 4,0,.L90
.L92:
	lwz 9,8(28)
	lbzx 3,21,30
	addi 9,9,-1
	cmpwi 0,9,0
	stw 9,8(28)
	bc 4,0,.L93
	lwz 0,24(28)
	cmpw 0,9,0
	bc 12,0,.L94
	cmpwi 0,3,10
	bc 12,2,.L94
.L93:
	lwz 9,0(28)
	stb 3,0(9)
	addi 9,9,1
	stw 9,0(28)
	b .L91
.L94:
	mr 4,28
	bl __swbuf
.L91:
	addi 30,30,1
	cmpw 0,30,26
	bc 12,0,.L92
.L90:
	lwz 0,codesize@l(16)
	li 9,0
	li 20,1
	stb 9,8(1)
	add 0,0,26
	stw 0,codesize@l(16)
	li 26,1
.L88:
	lwz 29,match_length@l(19)
	li 30,0
	cmpw 0,30,29
	bc 4,0,.L99
	lwz 0,44(1)
	cmpw 0,22,0
	bc 4,0,.L99
	lis 9,text_buf@ha
	la 27,text_buf@l(9)
.L101:
	lbzx 31,17,22
	mr 3,25
	bl DeleteNode
	addi 22,22,1
	cmpwi 0,25,16
	stbx 31,27,25
	bc 12,1,.L103
	addi 0,25,4096
	stbx 31,27,0
.L103:
	addi 0,23,1
	addi 9,25,1
	rlwinm 23,0,0,20,31
	rlwinm 25,9,0,20,31
	mr 3,23
	addi 30,30,1
	bl InsertNode
	cmpw 0,30,29
	bc 4,0,.L99
	lwz 0,44(1)
	cmpw 0,22,0
	bc 12,0,.L101
.L99:
	mr 0,30
	cmpw 0,0,29
	addi 30,30,1
	bc 4,0,.L122
.L107:
	mr 3,25
	bl DeleteNode
	addic. 24,24,-1
	addi 0,25,1
	addi 9,23,1
	rlwinm 25,0,0,20,31
	rlwinm 23,9,0,20,31
	bc 12,2,.L105
	mr 3,23
	bl InsertNode
.L105:
	mr 0,30
	cmpw 0,0,29
	addi 30,30,1
	bc 12,0,.L107
.L122:
	cmpwi 0,24,0
	bc 12,1,.L110
	cmpwi 0,26,1
	bc 4,1,.L111
	li 30,0
	cmpw 0,30,26
	bc 4,0,.L113
.L115:
	lwz 9,8(28)
	lbzx 3,21,30
	addi 9,9,-1
	cmpwi 0,9,0
	stw 9,8(28)
	bc 4,0,.L116
	lwz 0,24(28)
	cmpw 0,9,0
	bc 12,0,.L117
	cmpwi 0,3,10
	bc 12,2,.L117
.L116:
	lwz 9,0(28)
	stb 3,0(9)
	addi 9,9,1
	stw 9,0(28)
	b .L114
.L117:
	mr 4,28
	bl __swbuf
.L114:
	addi 30,30,1
	cmpw 0,30,26
	bc 12,0,.L115
.L113:
	lis 9,codesize@ha
	lwz 0,codesize@l(9)
	add 0,0,26
	stw 0,codesize@l(9)
.L111:
	mr 3,28
	bl fclose
	lis 9,codesize@ha
	lwz 3,codesize@l(9)
.L121:
	lwz 0,132(1)
	mtlr 0
	lmw 14,56(1)
	la 1,128(1)
	blr
.Lfe3:
	.size	 Encode,.Lfe3-Encode
	.section	".rodata"
	.align 2
.LC1:
	.string	"rb"
	.section	".text"
	.align 2
	.globl Decode
	.type	 Decode,@function
Decode:
	stwu 1,-64(1)
	mflr 0
	stmw 24,32(1)
	stw 0,68(1)
	mr 25,4
	mr 26,5
	lis 4,.LC1@ha
	li 28,0
	la 4,.LC1@l(4)
	bl fopen
	mr. 31,3
	bc 4,2,.L129
.L165:
	li 3,-1
	b .L161
.L129:
	addi 29,1,8
	li 4,4
	li 5,1
	mr 6,31
	mr 3,29
	lis 24,text_buf@ha
	bl fread
	mr 3,29
	li 4,4
	li 5,1
	mr 6,31
	bl fread
	li 11,4078
	la 9,text_buf@l(24)
	mtctr 11
	li 0,32
	addi 9,9,4077
.L164:
	stb 0,0(9)
	addi 9,9,-1
	bdnz .L164
	li 30,4078
	li 27,0
	b .L135
.L139:
	ori 27,3,65280
.L138:
	andi. 0,27,1
	bc 12,2,.L142
	lwz 9,4(31)
	addi 9,9,-1
	cmpwi 0,9,0
	stw 9,4(31)
	bc 4,0,.L144
	mr 3,31
	bl __srget
	b .L145
.L144:
	lwz 9,0(31)
	lbz 3,0(9)
	addi 9,9,1
	stw 9,0(31)
.L145:
	cmpwi 0,3,-1
	bc 12,2,.L136
	stbx 3,25,28
	addi 28,28,1
	cmpw 0,28,26
	bc 12,1,.L165
	la 9,text_buf@l(24)
	stbx 3,9,30
	addi 30,30,1
	rlwinm 30,30,0,20,31
	b .L135
.L142:
	lwz 9,4(31)
	addi 9,9,-1
	cmpwi 0,9,0
	stw 9,4(31)
	bc 4,0,.L149
	mr 3,31
	bl __srget
	mr 29,3
	b .L150
.L149:
	lwz 9,0(31)
	lbz 29,0(9)
	addi 9,9,1
	stw 9,0(31)
.L150:
	cmpwi 0,29,-1
	bc 12,2,.L136
	lwz 9,4(31)
	addi 9,9,-1
	cmpwi 0,9,0
	stw 9,4(31)
	bc 4,0,.L152
	mr 3,31
	bl __srget
	mr 11,3
	b .L153
.L152:
	lwz 9,0(31)
	lbz 11,0(9)
	addi 9,9,1
	stw 9,0(31)
.L153:
	cmpwi 0,11,-1
	bc 12,2,.L136
	rlwinm 0,11,4,20,23
	rlwinm 9,11,0,28,31
	addi 11,9,2
	li 10,0
	cmpw 0,10,11
	or 29,29,0
	bc 12,1,.L135
	lis 9,text_buf@ha
	la 9,text_buf@l(9)
.L157:
	add 0,29,10
	rlwinm 0,0,0,20,31
	lbzx 3,9,0
	stbx 3,25,28
	addi 28,28,1
	cmpw 0,28,26
	bc 12,1,.L165
	addi 10,10,1
	stbx 3,9,30
	cmpw 0,10,11
	addi 30,30,1
	rlwinm 30,30,0,20,31
	bc 4,1,.L157
.L135:
	srwi 27,27,1
	andi. 0,27,256
	bc 4,2,.L138
	lwz 9,4(31)
	addi 9,9,-1
	cmpwi 0,9,0
	stw 9,4(31)
	bc 4,0,.L140
	mr 3,31
	bl __srget
	b .L141
.L140:
	lwz 9,0(31)
	lbz 3,0(9)
	addi 9,9,1
	stw 9,0(31)
.L141:
	cmpwi 0,3,-1
	bc 4,2,.L139
.L136:
	mr 3,31
	bl fclose
	mr 3,28
.L161:
	lwz 0,68(1)
	mtlr 0
	lmw 24,32(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 Decode,.Lfe4-Decode
	.comm	text_buf,4113,4
	.comm	match_position,4,4
	.comm	match_length,4,4
	.comm	lson,16388,4
	.comm	rson,17412,4
	.comm	dad,16388,4
	.align 2
	.globl InitTree
	.type	 InitTree,@function
InitTree:
	li 11,256
	lis 9,rson@ha
	mtctr 11
	la 9,rson@l(9)
	li 0,4096
	addi 9,9,16388
.L167:
	stw 0,0(9)
	addi 9,9,4
	bdnz .L167
	li 0,4096
	lis 9,dad@ha
	mtctr 0
	la 9,dad@l(9)
	addi 9,9,16380
.L166:
	stw 0,0(9)
	addi 9,9,-4
	bdnz .L166
	blr
.Lfe5:
	.size	 InitTree,.Lfe5-InitTree
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
