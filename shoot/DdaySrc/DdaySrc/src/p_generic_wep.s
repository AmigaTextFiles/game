	.file	"p_generic_wep.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"%i / %i - %s\n"
	.align 2
.LC1:
	.string	"BHMG"
	.align 2
.LC2:
	.string	"weapons/sshotr1b.wav"
	.align 2
.LC3:
	.string	"weapons/grenl1b1.wav"
	.align 2
.LC4:
	.string	"weapons/noammo.wav"
	.align 2
.LC5:
	.long 0x3f800000
	.align 2
.LC6:
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_Generic
	.type	 Weapon_Generic,@function
Weapon_Generic:
	stwu 1,-80(1)
	mflr 0
	stmw 15,12(1)
	stw 0,84(1)
	mr 31,3
	mr 17,4
	lwz 19,96(1)
	lwz 4,84(31)
	mr 18,5
	mr 23,6
	lwz 3,88(1)
	mr 27,10
	addi 21,17,1
	lwz 0,4392(4)
	addi 26,18,1
	addi 11,27,1
	lwz 5,92(1)
	addi 3,3,1
	mr 25,9
	lwz 6,1796(4)
	addic 0,0,-1
	subfe 0,0,0
	mr 22,7
	andc 5,5,0
	andc 11,11,0
	lwz 20,100(1)
	andc 3,3,0
	and 9,21,0
	lwz 16,104(1)
	and 10,26,0
	cmpwi 0,6,0
	and 0,23,0
	mr 24,8
	or 15,0,5
	or 21,9,11
	or 26,10,3
	bc 12,2,.L13
	lwz 6,40(6)
	cmpwi 0,6,0
	bc 12,2,.L13
	lis 9,frame_output@ha
	lwz 0,frame_output@l(9)
	cmpwi 0,0,0
	bc 12,2,.L13
	lis 9,gi+4@ha
	lis 3,.LC0@ha
	lwz 5,92(4)
	lwz 0,gi+4@l(9)
	la 3,.LC0@l(3)
	lwz 4,4192(4)
	mtlr 0
	crxor 6,6,6
	blrl
.L13:
	lwz 9,84(31)
	lwz 11,1796(9)
	lwz 3,52(11)
	cmpwi 0,3,0
	bc 12,2,.L14
	bl FindItem
	lis 11,itemlist@ha
	mr 29,3
	lwz 10,84(31)
	la 11,itemlist@l(11)
	lis 0,0xc4ec
	subf 11,11,29
	ori 0,0,20165
	mullw 11,11,0
	srawi 30,11,3
	slwi 9,30,2
	addi 9,9,740
	add 28,10,9
.L14:
	lwz 9,84(31)
	lwz 0,4392(9)
	mr 10,9
	cmpwi 0,0,0
	bc 12,2,.L155
	lwz 9,1796(10)
	lwz 0,68(9)
	cmpwi 0,0,10
	bc 12,2,.L15
	lwz 9,92(10)
	addi 0,27,-1
	cmpw 0,9,0
	bc 12,0,.L15
	lis 0,0x429c
	stw 0,112(10)
	b .L16
.L15:
	lwz 0,4392(10)
	cmpwi 0,0,0
	bc 4,2,.L16
.L155:
	lwz 11,84(31)
	lwz 9,1796(11)
	lwz 0,68(9)
	cmpwi 0,0,10
	bc 12,2,.L16
	lis 0,0x42aa
	stw 0,112(11)
.L16:
	lwz 9,84(31)
	lwz 0,4192(9)
	cmpwi 0,0,5
	bc 4,2,.L18
	lis 0,0x42aa
	stw 0,112(9)
	lwz 10,84(31)
	lwz 9,1796(10)
	lwz 0,68(9)
	cmpwi 0,0,10
	bc 4,2,.L19
	lwz 9,3448(10)
	li 11,1
	addi 10,10,4724
	lwz 0,84(9)
	slwi 0,0,2
	stwx 11,10,0
.L19:
	lwz 11,84(31)
	addi 9,23,1
	mr 8,9
	lwz 0,92(11)
	cmpw 0,0,9
	bc 4,2,.L20
	li 0,-1
	stw 0,4328(11)
	lwz 0,672(31)
	cmpwi 0,0,1
	bc 4,2,.L21
	li 0,66
	lwz 11,84(31)
	li 9,62
	b .L158
.L21:
	cmpwi 0,0,2
	bc 4,2,.L23
	li 0,173
	lwz 11,84(31)
	li 9,169
	b .L158
.L23:
	cmpwi 0,0,4
	bc 4,2,.L20
	li 0,234
	lwz 11,84(31)
	li 9,230
.L158:
	stw 0,56(31)
	stw 9,4324(11)
.L20:
	lwz 10,84(31)
	lwz 11,4392(10)
	cmpwi 0,11,0
	bc 12,2,.L26
	lwz 9,92(10)
	addi 0,25,1
	cmpw 7,9,0
	bc 4,30,.L27
	li 0,0
	stw 0,4392(10)
	b .L6
.L27:
	cmpw 0,9,27
	bc 12,1,.L30
	bc 4,28,.L29
.L30:
	stw 27,92(10)
	b .L6
.L29:
	addi 0,9,-1
	stw 0,92(10)
	b .L6
.L26:
	lwz 9,92(10)
	cmpw 0,9,8
	bc 12,0,.L33
	cmpw 0,9,22
	bc 4,1,.L32
.L33:
	stw 8,92(10)
	b .L18
.L32:
	bc 4,0,.L35
	addi 0,9,1
	stw 0,92(10)
	lwz 10,84(31)
	lwz 9,1796(10)
	lwz 9,96(9)
	cmpwi 0,9,0
	bc 12,2,.L18
	addi 9,9,52
	lwzx 0,9,11
	cmpwi 0,0,0
	bc 12,2,.L38
	lis 9,gi@ha
	li 30,0
	la 28,gi@l(9)
	li 29,0
.L40:
	lwz 9,84(31)
	lwz 11,1796(9)
	lwz 10,92(9)
	lwz 11,96(11)
	addi 9,11,52
	lwzx 0,9,29
	cmpw 0,10,0
	bc 4,2,.L39
	lwz 9,36(28)
	lwz 3,48(11)
	mtlr 9
	blrl
	lis 9,.LC5@ha
	lwz 11,16(28)
	mr 5,3
	la 9,.LC5@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	mtlr 11
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 2,0(9)
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 3,0(9)
	blrl
.L39:
	lwz 10,84(31)
	addi 30,30,4
	addi 29,29,4
	lwz 11,1796(10)
	lwz 9,96(11)
	addi 9,9,52
	lwzx 0,9,30
	cmpwi 0,0,0
	bc 4,2,.L40
.L38:
	lwz 9,1796(10)
	lwz 11,96(9)
	lwz 0,68(11)
	cmpwi 0,0,0
	bc 12,2,.L18
	lis 9,gi@ha
	li 30,0
	la 28,gi@l(9)
	li 29,0
.L46:
	lwz 9,84(31)
	lwz 11,1796(9)
	lwz 10,92(9)
	lwz 11,96(11)
	addi 9,11,68
	lwzx 0,9,29
	cmpw 0,10,0
	bc 4,2,.L45
	lwz 9,36(28)
	lwz 3,64(11)
	mtlr 9
	blrl
	lis 9,.LC5@ha
	lwz 11,16(28)
	mr 5,3
	la 9,.LC5@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	mtlr 11
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 2,0(9)
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 3,0(9)
	blrl
.L45:
	lwz 10,84(31)
	addi 30,30,4
	addi 29,29,4
	lwz 11,1796(10)
	lwz 9,96(11)
	addi 9,9,68
	lwzx 0,9,30
	cmpwi 0,0,0
	bc 4,2,.L46
	b .L18
.L35:
	stw 26,92(10)
	lwz 9,84(31)
	stw 11,4192(9)
	lwz 10,84(31)
	lwz 9,1796(10)
	lwz 0,72(9)
	cmpwi 0,0,1
	bc 4,2,.L50
	lwz 0,0(28)
	cmpwi 0,0,0
	bc 12,2,.L18
	addi 10,10,740
	slwi 7,30,2
	lwzx 9,10,7
	addi 9,9,-1
	stwx 9,10,7
	lwz 11,84(31)
	lwz 9,4496(11)
	lwz 8,4500(11)
	lwz 10,0(9)
	lwz 0,0(8)
	add 0,0,10
	stw 0,0(8)
	lwz 11,48(29)
	cmpw 0,0,11
	bc 12,0,.L52
	lwz 9,84(31)
	lwz 10,4500(9)
	lwz 0,0(10)
	subf 0,11,0
	stw 0,0(10)
	lwz 11,84(31)
	addi 11,11,740
	lwzx 9,11,7
	addi 9,9,1
	stwx 9,11,7
.L52:
	lwz 10,84(31)
	addi 9,10,740
	lwzx 0,9,7
	cmpwi 0,0,0
	bc 12,2,.L53
	lwz 9,4496(10)
	lwz 0,48(29)
	b .L159
.L53:
	lwz 9,4500(10)
	lwz 11,4496(10)
	lwz 0,0(9)
	stw 0,0(11)
	b .L18
.L50:
	cmpwi 0,0,2
	lwz 0,0(28)
	cmpwi 0,0,0
	bc 12,2,.L18
	slwi 0,30,2
	addi 11,10,740
	lwzx 9,11,0
	addi 9,9,-1
	stwx 9,11,0
	lwz 10,84(31)
	lwz 0,48(29)
	lwz 9,4496(10)
.L159:
	stw 0,0(9)
.L18:
	lwz 9,84(31)
	lwz 8,4192(9)
	mr 10,9
	cmpwi 0,8,4
	bc 4,2,.L60
	lis 0,0x42aa
	stw 0,112(10)
	lwz 10,84(31)
	lwz 9,1796(10)
	lwz 0,68(9)
	cmpwi 0,0,10
	bc 4,2,.L61
	lwz 9,3448(10)
	li 11,0
	addi 10,10,4724
	lwz 0,84(9)
	slwi 0,0,2
	stwx 11,10,0
.L61:
	cmpw 0,24,22
	bc 4,2,.L62
	lwz 11,84(31)
	addi 0,18,1
	li 10,0
	mr 3,31
	stw 0,92(11)
	lwz 9,84(31)
	stw 10,4192(9)
	lwz 11,84(31)
	stw 10,4392(11)
	bl WeighPlayer
	b .L6
.L62:
	lwz 11,84(31)
	addi 7,22,1
	lwz 9,92(11)
	cmpw 0,9,7
	bc 4,0,.L63
	stw 7,92(11)
	b .L6
.L63:
	cmpw 0,9,24
	bc 4,0,.L65
	addi 0,9,1
	stw 0,92(11)
	b .L6
.L65:
	li 0,0
	mr 3,31
	stw 0,4192(11)
	lwz 9,84(31)
	stw 0,4392(9)
	bl WeighPlayer
	b .L6
.L60:
	lwz 0,40(31)
	cmpwi 0,0,255
	bc 4,2,.L6
	cmpwi 0,8,2
	bc 4,2,.L68
	lwz 0,4720(10)
	cmpwi 0,0,0
	bc 4,2,.L70
	lwz 0,92(10)
	cmpw 0,0,25
	bc 4,2,.L69
.L70:
	li 0,0
	mr 3,31
	stw 0,4720(10)
	lwz 9,84(31)
	stw 0,4392(9)
	bl ChangeWeapon
	b .L6
.L69:
	subf 0,0,25
	cmpwi 0,0,4
	bc 4,2,.L141
	li 0,-1
	stw 0,4328(10)
	lwz 0,672(31)
	cmpwi 0,0,1
	bc 4,2,.L73
	li 0,66
	lwz 11,84(31)
	li 9,62
	b .L160
.L73:
	cmpwi 0,0,2
	bc 4,2,.L75
	li 0,173
	lwz 11,84(31)
	li 9,169
	b .L160
.L75:
	cmpwi 0,0,4
	bc 4,2,.L141
	li 0,234
	lwz 11,84(31)
	li 9,230
.L160:
	stw 0,56(31)
	stw 9,4324(11)
	b .L141
.L68:
	cmpwi 0,8,1
	bc 4,2,.L78
	lwz 9,1796(10)
	lwz 0,68(9)
	cmpwi 0,0,10
	bc 4,2,.L79
	lwz 9,3448(10)
	addi 11,10,4724
	lwz 0,84(9)
	slwi 0,0,2
	stwx 8,11,0
.L79:
	lwz 11,84(31)
	lwz 0,92(11)
	cmpw 0,0,17
	bc 4,2,.L80
	lwz 9,4496(11)
	cmpwi 0,9,0
	bc 12,2,.L81
	lwz 30,0(9)
	cmpwi 0,30,0
	bc 4,2,.L81
	lwz 9,4500(11)
	cmpwi 0,9,0
	bc 12,2,.L82
	lwz 0,0(9)
	cmpwi 0,0,0
	bc 4,2,.L81
.L82:
	lwz 9,1796(11)
	lwz 3,52(9)
	bl FindItem
	lwz 11,84(31)
	lwz 9,1796(11)
	lwz 9,96(9)
	cmpwi 0,9,0
	bc 12,2,.L81
	lwz 11,4496(11)
	lwz 0,112(9)
	stw 0,0(11)
	lwz 9,84(31)
	lwz 11,1796(9)
	lwz 10,96(11)
	stw 30,112(10)
.L81:
	lwz 9,84(31)
	li 0,0
	stw 0,4192(9)
	lwz 11,84(31)
	stw 26,92(11)
	b .L6
.L80:
	lwz 9,1796(11)
	lis 4,.LC1@ha
	la 4,.LC1@l(4)
	lwz 3,40(9)
	bl stricmp
	cmpwi 0,3,0
	bc 4,2,.L141
	lwz 9,84(31)
	lwz 0,92(9)
	cmpwi 0,0,18
	bc 4,2,.L86
	lis 29,gi@ha
	lis 3,.LC2@ha
	la 29,gi@l(29)
	la 3,.LC2@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC5@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC5@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 2,0(9)
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 3,0(9)
	blrl
	b .L141
.L86:
	cmpwi 0,0,13
	bc 4,2,.L141
	lis 29,gi@ha
	lis 3,.LC3@ha
	la 29,gi@l(29)
	la 3,.LC3@l(3)
	b .L166
.L78:
	lwz 0,4148(10)
	cmpwi 0,0,0
	bc 12,2,.L89
	cmpwi 0,8,3
	bc 12,2,.L89
	li 0,2
	addi 11,25,-1
	stw 0,4192(10)
	subf 11,24,11
	lwz 9,84(31)
	cmpwi 0,11,3
	addi 0,24,1
	stw 0,92(9)
	bc 12,1,.L6
	lwz 9,84(31)
	li 0,-1
	stw 0,4328(9)
	lwz 0,672(31)
	cmpwi 0,0,1
	bc 4,2,.L91
	lwz 9,84(31)
	li 0,66
	li 11,62
	b .L161
.L91:
	cmpwi 0,0,2
	bc 4,2,.L93
	lwz 9,84(31)
	li 0,173
	li 11,169
	b .L161
.L93:
	cmpwi 0,0,4
	bc 4,2,.L6
	lwz 9,84(31)
	li 0,234
	li 11,230
.L161:
	stw 0,56(31)
	stw 11,4324(9)
	b .L6
.L89:
	lwz 0,4192(10)
	cmpwi 0,0,0
	bc 4,2,.L96
	lwz 0,4140(10)
	lwz 11,4132(10)
	or 0,0,11
	andi. 9,0,1
	bc 12,2,.L100
	lwz 0,620(31)
	cmpwi 0,0,2
	bc 4,1,.L98
	lwz 9,1796(10)
	lwz 0,68(9)
	cmpwi 0,0,1
	bc 12,2,.L98
	cmpwi 0,0,8
	bc 12,2,.L98
	lwz 0,4136(10)
	cmpw 0,11,0
	bc 12,2,.L99
	lis 29,gi@ha
	lis 3,.LC4@ha
	la 29,gi@l(29)
	la 3,.LC4@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC5@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC5@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 2,0(9)
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 3,0(9)
	blrl
.L99:
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L100
.L98:
	lwz 11,84(31)
	li 10,3
	lwz 0,4140(11)
	rlwinm 0,0,0,0,30
	stw 0,4140(11)
	lwz 9,84(31)
	stw 21,92(9)
	lwz 11,84(31)
	stw 10,4192(11)
	b .L96
.L100:
	lwz 9,84(31)
	li 0,0
	stw 0,4320(9)
	lwz 10,84(31)
	lwz 8,1796(10)
	lwz 0,68(8)
	cmpwi 0,0,10
	bc 4,2,.L102
	lwz 0,4392(10)
	cmpwi 0,0,0
	bc 12,2,.L102
	lwz 9,3448(10)
	addi 11,10,4724
	lwz 0,84(9)
	slwi 0,0,2
	lwzx 9,11,0
	cmpwi 0,9,0
	bc 12,2,.L102
	lwz 0,4196(10)
	cmpwi 0,0,4
	bc 12,2,.L102
	lwz 9,96(8)
	lwz 0,28(9)
	stw 0,92(10)
	b .L103
.L102:
	lwz 9,84(31)
	lwz 0,92(9)
	mr 10,9
	cmpw 0,0,15
	bc 4,0,.L105
	cmpw 0,0,26
	bc 12,0,.L105
	lwz 0,4196(10)
	cmpwi 0,0,4
	bc 4,2,.L103
.L105:
	stw 26,92(10)
	b .L6
.L103:
	cmpwi 0,19,0
	bc 12,2,.L141
	lwz 0,0(19)
	cmpwi 0,0,0
	bc 12,2,.L141
	mr 29,19
.L110:
	lwz 9,84(31)
	lwz 11,0(29)
	lwz 0,92(9)
	cmpw 0,0,11
	bc 4,2,.L109
	bl rand
	andi. 0,3,15
	bc 4,2,.L6
.L109:
	lwzu 0,4(29)
	cmpwi 0,0,0
	bc 4,2,.L110
	b .L141
.L96:
	lwz 9,84(31)
	lwz 0,4192(9)
	mr 10,9
	cmpwi 0,0,3
	bc 4,2,.L114
	lwz 0,0(20)
	li 29,0
	cmpwi 0,0,0
	bc 12,2,.L156
	mr 11,20
.L118:
	lwz 9,92(10)
	lwz 0,0(11)
	cmpw 0,9,0
	bc 4,2,.L117
	lwz 0,620(31)
	cmpwi 0,0,2
	bc 4,1,.L120
	lwz 9,1796(10)
	lwz 0,68(9)
	cmpwi 0,0,1
	bc 12,2,.L120
	cmpwi 0,0,8
	bc 4,2,.L157
.L120:
	mr 3,31
	mtlr 16
	blrl
	b .L116
.L117:
	lwzu 0,4(11)
	addi 29,29,1
	cmpwi 0,0,0
	bc 4,2,.L118
.L116:
	slwi 0,29,2
	lwzx 9,20,0
	cmpwi 0,9,0
	bc 4,2,.L123
.L156:
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
.L123:
	lwz 11,84(31)
	lwz 9,4132(11)
	lwz 0,4140(11)
	or 0,0,9
	andi. 9,0,1
	bc 12,2,.L126
	lwz 9,1796(11)
	lwz 0,96(9)
	cmpwi 0,0,0
	bc 12,2,.L125
	lwz 0,4496(11)
	cmpwi 0,0,0
	bc 12,2,.L126
.L125:
	li 0,4
	stw 0,4328(11)
	lwz 0,672(31)
	cmpwi 0,0,2
	bc 4,2,.L127
	lwz 11,84(31)
	li 10,162
	lwz 9,92(11)
	srwi 0,9,31
	add 0,9,0
	rlwinm 0,0,0,0,30
	subf 9,0,9
	addi 9,9,160
	b .L162
.L127:
	cmpwi 0,0,4
	bc 4,2,.L129
	lwz 11,84(31)
	li 10,223
	lwz 9,92(11)
	srwi 0,9,31
	add 0,9,0
	rlwinm 0,0,0,0,30
	subf 9,0,9
	addi 9,9,221
	b .L162
.L129:
	lwz 9,84(31)
	lwz 0,4540(9)
	cmpwi 0,0,0
	bc 12,2,.L131
	lwz 0,4392(9)
	cmpwi 0,0,0
	bc 4,2,.L131
	lwz 11,56(31)
	addi 0,11,-46
	cmplwi 0,0,7
	bc 12,1,.L126
	stw 11,4324(9)
	b .L126
.L131:
	lwz 11,84(31)
	li 10,48
	lwz 9,92(11)
	srwi 0,9,31
	add 0,9,0
	rlwinm 0,0,0,0,30
	subf 9,0,9
	addi 9,9,46
.L162:
	stw 9,56(31)
	stw 10,4324(11)
.L126:
	lwz 3,84(31)
	lwz 0,92(3)
	cmpw 0,0,26
	bc 12,0,.L6
	li 0,0
	stw 0,4192(3)
	b .L6
.L114:
	cmpwi 0,0,6
	bc 4,2,.L134
	cmpwi 0,27,0
	bc 12,2,.L163
	li 6,1
	stw 6,4392(10)
	lwz 10,84(31)
	lwz 8,1796(10)
	lwz 0,68(8)
	cmpwi 0,0,10
	bc 4,2,.L136
	lwz 9,3448(10)
	addi 11,10,4724
	lwz 0,84(9)
	slwi 0,0,2
	lwzx 7,11,0
	cmpwi 0,7,0
	bc 4,2,.L136
	lwz 8,96(8)
	stw 7,4528(10)
	lwz 9,84(31)
	stw 7,4392(9)
	lwz 9,84(31)
	lwz 10,20(8)
	lwz 11,92(9)
	cmpw 0,11,10
	bc 12,0,.L138
	lwz 0,24(8)
	cmpw 0,11,0
	bc 4,1,.L137
.L138:
	stw 10,92(9)
	b .L6
.L137:
	bc 4,0,.L140
	lwz 9,1796(9)
	lwz 9,96(9)
	lwz 0,108(9)
	cmpw 0,11,0
	bc 4,2,.L141
	lis 29,gi@ha
	lwz 3,104(9)
	la 29,gi@l(29)
.L166:
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC5@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC5@l(9)
	li 4,1
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 2,0(9)
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 3,0(9)
	blrl
.L141:
	lwz 11,84(31)
	lwz 9,92(11)
	addi 9,9,1
	stw 9,92(11)
	b .L6
.L140:
	lwz 0,0(8)
	stw 0,92(9)
	lwz 9,84(31)
	stw 7,4192(9)
	lwz 11,84(31)
	lwz 9,3448(11)
	addi 11,11,4724
	lwz 0,84(9)
	slwi 0,0,2
	stwx 6,11,0
	b .L6
.L136:
	lwz 10,84(31)
	addi 0,25,1
	lwz 9,92(10)
	cmpw 0,9,0
	bc 12,0,.L164
	cmpw 0,9,27
	bc 12,0,.L145
	li 0,1
	li 11,0
	stw 0,4392(10)
	lwz 9,84(31)
	stw 11,4192(9)
	lwz 11,84(31)
	lwz 9,1796(11)
	lwz 0,68(9)
	cmpwi 0,0,10
	bc 4,2,.L134
	lis 0,0x41c8
	stw 0,112(11)
	b .L134
.L145:
	addi 0,9,1
.L164:
	stw 0,92(10)
.L134:
	lwz 10,84(31)
	lwz 0,4192(10)
	cmpwi 0,0,7
	bc 4,2,.L6
	cmpwi 0,27,0
	bc 4,2,.L149
.L163:
	stw 27,4392(10)
	lwz 9,84(31)
	stw 27,4192(9)
	b .L6
.L149:
	lis 0,0x42aa
	addi 9,25,1
	stw 0,112(10)
	lwz 8,84(31)
	lwz 10,92(8)
	cmpw 7,10,9
	bc 4,30,.L150
	li 29,0
	mr 3,31
	stw 29,4392(8)
	bl WeighPlayer
	lwz 9,84(31)
	stw 29,4192(9)
	b .L6
.L150:
	cmpw 0,10,27
	bc 12,1,.L153
	bc 4,28,.L152
.L153:
	stw 27,92(8)
	b .L6
.L157:
	li 0,0
	stw 0,4192(10)
	lwz 9,84(31)
	stw 26,92(9)
	b .L6
.L152:
	addi 0,10,-1
	stw 0,92(8)
.L6:
	lwz 0,84(1)
	mtlr 0
	lmw 15,12(1)
	la 1,80(1)
	blr
.Lfe1:
	.size	 Weapon_Generic,.Lfe1-Weapon_Generic
	.comm	is_silenced,1,1
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.align 2
	.globl ifchangewep
	.type	 ifchangewep,@function
ifchangewep:
	blr
.Lfe2:
	.size	 ifchangewep,.Lfe2-ifchangewep
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
