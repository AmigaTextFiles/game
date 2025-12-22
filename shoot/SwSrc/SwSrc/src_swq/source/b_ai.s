	.file	"b_ai.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC1:
	.long 0x3f800000
	.align 2
.LC2:
	.long 0x40000000
	.align 2
.LC3:
	.long 0x40800000
	.align 2
.LC4:
	.long 0x40400000
	.align 2
.LC5:
	.long 0x40a00000
	.align 2
.LC6:
	.long 0x40c00000
	.align 2
.LC7:
	.long 0x41000000
	.align 2
.LC8:
	.long 0x41200000
	.align 2
.LC9:
	.long 0x0
	.section	".text"
	.align 2
	.globl Bot_Find_Item_Weight
	.type	 Bot_Find_Item_Weight,@function
Bot_Find_Item_Weight:
	lwz 0,8(3)
	cmpwi 0,0,14
	bc 4,2,.L19
	lis 9,.LC1@ha
	la 9,.LC1@l(9)
	lfs 1,0(9)
	blr
.L19:
	cmpwi 0,0,15
	bc 4,2,.L21
.L59:
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	lfs 1,0(9)
	blr
.L21:
	cmpwi 0,0,16
	bc 4,2,.L23
.L58:
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	lfs 1,0(9)
	blr
.L23:
	cmpwi 0,0,17
	bc 12,2,.L58
	cmpwi 0,0,18
	bc 12,2,.L59
	cmpwi 0,0,19
	bc 4,2,.L29
.L60:
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfs 1,0(9)
	blr
.L29:
	cmpwi 0,0,20
	bc 12,2,.L60
	cmpwi 0,0,22
	bc 4,2,.L33
.L61:
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 1,0(9)
	blr
.L33:
	cmpwi 0,0,23
	bc 12,2,.L61
	cmpwi 0,0,10
	bc 4,2,.L37
.L62:
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 1,0(9)
	blr
.L37:
	lwz 3,8(3)
	cmpwi 0,3,1
	bc 12,2,.L59
	cmpwi 0,3,2
	bc 12,2,.L61
	cmpwi 0,3,3
	bc 12,2,.L61
	cmpwi 0,3,4
	bc 12,2,.L62
	cmpwi 0,3,5
	bc 4,2,.L47
.L63:
	lis 9,.LC7@ha
	la 9,.LC7@l(9)
	lfs 1,0(9)
	blr
.L47:
	cmpwi 0,3,6
	bc 12,2,.L63
	cmpwi 0,3,7
	bc 4,2,.L51
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	lfs 1,0(9)
	blr
.L51:
	cmpwi 0,3,8
	bc 12,2,.L53
	lis 9,.LC8@ha
	cmpwi 0,3,9
	la 9,.LC8@l(9)
	lfs 1,0(9)
	bclr 12,2
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfs 1,0(9)
	blr
.L53:
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	lfs 1,0(9)
	blr
.Lfe1:
	.size	 Bot_Find_Item_Weight,.Lfe1-Bot_Find_Item_Weight
	.align 2
	.globl Bot_Needs_Item
	.type	 Bot_Needs_Item,@function
Bot_Needs_Item:
	lwz 0,8(4)
	mr 9,3
	cmpwi 0,0,14
	bc 4,2,.L65
	li 3,20
	li 0,14
	b .L66
.L65:
	cmpwi 0,0,15
	bc 4,2,.L67
	li 3,25
	li 0,15
	b .L66
.L67:
	cmpwi 0,0,16
	bc 4,2,.L69
	li 3,10
	li 0,16
	b .L66
.L69:
	cmpwi 0,0,17
	bc 4,2,.L71
	li 3,3
	li 0,17
	b .L66
.L71:
	cmpwi 0,0,18
	bc 4,2,.L73
	li 3,6
	li 0,18
	b .L66
.L73:
	cmpwi 0,0,19
	bc 4,2,.L75
	li 3,3
	li 0,19
	b .L66
.L75:
	cmpwi 0,0,20
	bc 4,2,.L77
	li 3,6
	li 0,20
	b .L66
.L77:
	cmpwi 0,0,22
	bc 4,2,.L79
	li 3,70
	li 0,22
	b .L66
.L79:
	cmpwi 0,0,23
	bc 4,2,.L81
	li 3,5
	li 0,23
	b .L66
.L81:
	cmpwi 0,0,10
	bc 4,2,.L83
	li 3,10
	li 0,10
	b .L66
.L83:
	lwz 0,8(4)
	cmpwi 0,0,1
	bc 12,2,.L101
	cmpwi 0,0,2
	bc 12,2,.L101
	cmpwi 0,0,3
	bc 12,2,.L101
	cmpwi 0,0,4
	bc 12,2,.L101
	cmpwi 0,0,5
	bc 12,2,.L101
	cmpwi 0,0,6
	bc 12,2,.L101
	cmpwi 0,0,7
	bc 12,2,.L101
	cmpwi 0,0,8
	bc 12,2,.L101
	cmpwi 0,0,9
	li 3,0
	bclr 4,2
.L101:
	li 3,5
.L66:
	lwz 9,84(9)
	slwi 11,0,2
	addi 9,9,740
	lwzx 0,9,11
	cmpw 7,0,3
	mfcr 3
	rlwinm 3,3,29,1
	blr
.Lfe2:
	.size	 Bot_Needs_Item,.Lfe2-Bot_Needs_Item
	.section	".rodata"
	.align 2
.LC10:
	.string	"Lightsaber"
	.align 2
.LC11:
	.string	"Thermals"
	.align 2
.LC12:
	.string	"Rocket_Launcher"
	.align 2
.LC13:
	.string	"Beam_Tube"
	.align 2
.LC14:
	.string	"Night_Stinger"
	.align 2
.LC15:
	.string	"Disruptor"
	.align 2
.LC16:
	.string	"Wrist_Rocket"
	.align 2
.LC17:
	.string	"Bowcaster"
	.align 2
.LC18:
	.string	"Repeater"
	.align 2
.LC19:
	.string	"Trooper_Rifle"
	.align 2
.LC20:
	.string	"Blaster"
	.align 2
.LC21:
	.long 0x0
	.align 2
.LC22:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl Bot_Choose_Weapon
	.type	 Bot_Choose_Weapon,@function
Bot_Choose_Weapon:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 11,.LC21@ha
	lis 9,saberonly@ha
	la 11,.LC21@l(11)
	mr 30,3
	lfs 13,0(11)
	lwz 11,saberonly@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L216
	lis 9,.LC22@ha
	lis 11,skill@ha
	la 9,.LC22@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L119
	lis 3,.LC11@ha
	la 3,.LC11@l(3)
	bl FindItem
	mr 31,3
	lwz 3,52(31)
	cmpwi 0,3,0
	bc 12,2,.L120
	bl FindItem
	lis 9,itemlist@ha
	lis 11,0x286b
	lwz 8,84(30)
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,31
	subf 3,9,3
	mullw 0,0,11
	addi 10,8,1792
	mullw 3,3,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	srawi 0,3,2
	cmpwi 0,9,0
	bc 4,2,.L120
	slwi 0,0,2
	addi 9,8,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 12,2,.L196
.L120:
	lwz 10,84(30)
	lwz 0,1764(10)
	cmpw 0,31,0
	bc 12,2,.L197
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,31
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L125
.L196:
	li 0,0
	b .L123
.L125:
	stw 31,4148(10)
.L197:
	li 0,1
.L123:
	cmpwi 0,0,0
	bc 4,2,.L111
.L119:
	lis 9,.LC22@ha
	lis 11,skill@ha
	la 9,.LC22@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L126
	lis 3,.LC12@ha
	la 3,.LC12@l(3)
	bl FindItem
	mr 31,3
	lwz 3,52(31)
	cmpwi 0,3,0
	bc 12,2,.L127
	bl FindItem
	lis 9,itemlist@ha
	lis 11,0x286b
	lwz 8,84(30)
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,31
	subf 3,9,3
	mullw 0,0,11
	addi 10,8,1792
	mullw 3,3,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	srawi 0,3,2
	cmpwi 0,9,0
	bc 4,2,.L127
	slwi 0,0,2
	addi 9,8,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 12,2,.L198
.L127:
	lwz 10,84(30)
	lwz 0,1764(10)
	cmpw 0,31,0
	bc 12,2,.L199
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,31
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L132
.L198:
	li 0,0
	b .L130
.L132:
	stw 31,4148(10)
.L199:
	li 0,1
.L130:
	cmpwi 0,0,0
	bc 4,2,.L111
.L126:
	lis 9,.LC22@ha
	lis 11,skill@ha
	la 9,.LC22@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L133
	lis 3,.LC13@ha
	la 3,.LC13@l(3)
	bl FindItem
	mr 31,3
	lwz 3,52(31)
	cmpwi 0,3,0
	bc 12,2,.L134
	bl FindItem
	lis 9,itemlist@ha
	lis 11,0x286b
	lwz 8,84(30)
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,31
	subf 3,9,3
	mullw 0,0,11
	addi 10,8,1792
	mullw 3,3,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	srawi 0,3,2
	cmpwi 0,9,0
	bc 4,2,.L134
	slwi 0,0,2
	addi 9,8,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 12,2,.L200
.L134:
	lwz 10,84(30)
	lwz 0,1764(10)
	cmpw 0,31,0
	bc 12,2,.L201
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,31
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L139
.L200:
	li 0,0
	b .L137
.L139:
	stw 31,4148(10)
.L201:
	li 0,1
.L137:
	cmpwi 0,0,0
	bc 4,2,.L111
.L133:
	lis 9,.LC22@ha
	lis 11,skill@ha
	la 9,.LC22@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L140
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	bl FindItem
	mr 31,3
	lwz 3,52(31)
	cmpwi 0,3,0
	bc 12,2,.L141
	bl FindItem
	lis 9,itemlist@ha
	lis 11,0x286b
	lwz 8,84(30)
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,31
	subf 3,9,3
	mullw 0,0,11
	addi 10,8,1792
	mullw 3,3,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	srawi 0,3,2
	cmpwi 0,9,0
	bc 4,2,.L141
	slwi 0,0,2
	addi 9,8,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 12,2,.L202
.L141:
	lwz 10,84(30)
	lwz 0,1764(10)
	cmpw 0,31,0
	bc 12,2,.L203
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,31
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L146
.L202:
	li 0,0
	b .L144
.L146:
	stw 31,4148(10)
.L203:
	li 0,1
.L144:
	cmpwi 0,0,0
	bc 4,2,.L111
.L140:
	lis 3,.LC15@ha
	la 3,.LC15@l(3)
	bl FindItem
	mr 31,3
	lwz 3,52(31)
	cmpwi 0,3,0
	bc 12,2,.L148
	bl FindItem
	lis 9,itemlist@ha
	lis 11,0x286b
	lwz 8,84(30)
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,31
	subf 3,9,3
	mullw 0,0,11
	addi 10,8,1792
	mullw 3,3,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	srawi 0,3,2
	cmpwi 0,9,0
	bc 4,2,.L148
	slwi 0,0,2
	addi 9,8,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 12,2,.L204
.L148:
	lwz 10,84(30)
	lwz 0,1764(10)
	cmpw 0,31,0
	bc 12,2,.L205
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,31
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L153
.L204:
	li 0,0
	b .L151
.L153:
	stw 31,4148(10)
.L205:
	li 0,1
.L151:
	cmpwi 0,0,0
	bc 4,2,.L111
	lis 3,.LC16@ha
	la 3,.LC16@l(3)
	bl FindItem
	mr 31,3
	lwz 3,52(31)
	cmpwi 0,3,0
	bc 12,2,.L155
	bl FindItem
	lis 9,itemlist@ha
	lis 11,0x286b
	lwz 8,84(30)
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,31
	subf 3,9,3
	mullw 0,0,11
	addi 10,8,1792
	mullw 3,3,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	srawi 0,3,2
	cmpwi 0,9,0
	bc 4,2,.L155
	slwi 0,0,2
	addi 9,8,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 12,2,.L206
.L155:
	lwz 10,84(30)
	lwz 0,1764(10)
	cmpw 0,31,0
	bc 12,2,.L207
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,31
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L160
.L206:
	li 0,0
	b .L158
.L160:
	stw 31,4148(10)
.L207:
	li 0,1
.L158:
	cmpwi 0,0,0
	bc 4,2,.L111
	lis 3,.LC17@ha
	la 3,.LC17@l(3)
	bl FindItem
	mr 31,3
	lwz 3,52(31)
	cmpwi 0,3,0
	bc 12,2,.L162
	bl FindItem
	lis 9,itemlist@ha
	lis 11,0x286b
	lwz 8,84(30)
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,31
	subf 3,9,3
	mullw 0,0,11
	addi 10,8,1792
	mullw 3,3,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	srawi 0,3,2
	cmpwi 0,9,0
	bc 4,2,.L162
	slwi 0,0,2
	addi 9,8,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 12,2,.L208
.L162:
	lwz 10,84(30)
	lwz 0,1764(10)
	cmpw 0,31,0
	bc 12,2,.L209
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,31
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L167
.L208:
	li 0,0
	b .L165
.L167:
	stw 31,4148(10)
.L209:
	li 0,1
.L165:
	cmpwi 0,0,0
	bc 4,2,.L111
	lis 3,.LC18@ha
	la 3,.LC18@l(3)
	bl FindItem
	mr 31,3
	lwz 3,52(31)
	cmpwi 0,3,0
	bc 12,2,.L169
	bl FindItem
	lis 9,itemlist@ha
	lis 11,0x286b
	lwz 8,84(30)
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,31
	subf 3,9,3
	mullw 0,0,11
	addi 10,8,1792
	mullw 3,3,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	srawi 0,3,2
	cmpwi 0,9,0
	bc 4,2,.L169
	slwi 0,0,2
	addi 9,8,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 12,2,.L210
.L169:
	lwz 10,84(30)
	lwz 0,1764(10)
	cmpw 0,31,0
	bc 12,2,.L211
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,31
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L174
.L210:
	li 0,0
	b .L172
.L174:
	stw 31,4148(10)
.L211:
	li 0,1
.L172:
	cmpwi 0,0,0
	bc 4,2,.L111
	lis 3,.LC19@ha
	la 3,.LC19@l(3)
	bl FindItem
	mr 31,3
	lwz 3,52(31)
	cmpwi 0,3,0
	bc 12,2,.L176
	bl FindItem
	lis 9,itemlist@ha
	lis 11,0x286b
	lwz 8,84(30)
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,31
	subf 3,9,3
	mullw 0,0,11
	addi 10,8,1792
	mullw 3,3,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	srawi 0,3,2
	cmpwi 0,9,0
	bc 4,2,.L176
	slwi 0,0,2
	addi 9,8,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 12,2,.L212
.L176:
	lwz 10,84(30)
	lwz 0,1764(10)
	cmpw 0,31,0
	bc 12,2,.L213
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,31
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L181
.L212:
	li 0,0
	b .L179
.L181:
	stw 31,4148(10)
.L213:
	li 0,1
.L179:
	cmpwi 0,0,0
	bc 4,2,.L111
	lis 3,.LC20@ha
	la 3,.LC20@l(3)
	bl FindItem
	mr 31,3
	lwz 3,52(31)
	cmpwi 0,3,0
	bc 12,2,.L183
	bl FindItem
	lis 9,itemlist@ha
	lis 11,0x286b
	lwz 8,84(30)
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,31
	subf 3,9,3
	mullw 0,0,11
	addi 10,8,1792
	mullw 3,3,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	srawi 0,3,2
	cmpwi 0,9,0
	bc 4,2,.L183
	slwi 0,0,2
	addi 9,8,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 12,2,.L214
.L183:
	lwz 10,84(30)
	lwz 0,1764(10)
	cmpw 0,31,0
	bc 12,2,.L215
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,31
	addi 11,10,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L188
.L214:
	li 0,0
	b .L186
.L188:
	stw 31,4148(10)
.L215:
	li 0,1
.L186:
	cmpwi 0,0,0
	bc 4,2,.L111
.L216:
	lis 3,.LC10@ha
	la 3,.LC10@l(3)
	bl FindItem
	mr 31,3
	lwz 3,52(31)
	cmpwi 0,3,0
	bc 12,2,.L190
	bl FindItem
	lis 9,itemlist@ha
	lis 11,0x286b
	lwz 8,84(30)
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,31
	subf 3,9,3
	mullw 0,0,11
	addi 10,8,1792
	mullw 3,3,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	srawi 0,3,2
	cmpwi 0,9,0
	bc 4,2,.L190
	slwi 0,0,2
	addi 9,8,740
	lwzx 11,9,0
	cmpwi 0,11,0
	bc 12,2,.L111
.L190:
	lwz 3,84(30)
	lwz 0,1764(3)
	cmpw 0,31,0
	bc 12,2,.L111
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,31
	addi 11,3,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L111
	stw 31,4148(3)
.L111:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 Bot_Choose_Weapon,.Lfe3-Bot_Choose_Weapon
	.section	".rodata"
	.align 3
.LC23:
	.long 0x40668000
	.long 0x0
	.align 3
.LC24:
	.long 0x400921fb
	.long 0x54442d18
	.align 2
.LC25:
	.long 0x46fffe00
	.align 3
.LC26:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC27:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC28:
	.long 0x3fe33333
	.long 0x33333333
	.align 3
.LC29:
	.long 0x3fd99999
	.long 0x9999999a
	.align 3
.LC30:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC31:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC32:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 3
.LC33:
	.long 0x3fe4cccc
	.long 0xcccccccd
	.align 3
.LC34:
	.long 0x3fee6666
	.long 0x66666666
	.align 2
.LC35:
	.long 0x0
	.align 2
.LC36:
	.long 0x43b40000
	.align 3
.LC37:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC38:
	.long 0x45800000
	.align 2
.LC39:
	.long 0x46800000
	.align 3
.LC40:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC41:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Bot_Attack
	.type	 Bot_Attack,@function
Bot_Attack:
	stwu 1,-80(1)
	mflr 0
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 27,44(1)
	stw 0,84(1)
	mr 30,3
	mr 28,4
	lfs 11,4(30)
	mr 31,5
	addi 3,1,8
	lfs 12,4(28)
	lfs 10,8(30)
	lfs 13,8(28)
	fsubs 12,12,11
	lfs 0,12(28)
	lfs 11,12(30)
	fsubs 13,13,10
	stfs 12,8(1)
	fsubs 0,0,11
	stfs 13,12(1)
	stfs 0,16(1)
	bl vectoyaw
	lfs 0,12(1)
	lfs 13,8(1)
	stfs 1,20(30)
	fmuls 0,0,0
	stfs 1,424(30)
	fmadds 31,13,13,0
	fmr 1,31
	bl sqrt
	frsp 2,1
	lfs 1,16(1)
	bl atan2
	lis 9,.LC23@ha
	fneg 1,1
	lis 11,.LC24@ha
	lfd 13,.LC23@l(9)
	lfd 0,.LC24@l(11)
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	fmul 1,1,13
	lfs 12,0(9)
	fdiv 1,1,0
	frsp 1,1
	fcmpu 0,1,12
	stfs 1,16(30)
	bc 4,0,.L218
	lis 11,.LC36@ha
	la 11,.LC36@l(11)
	lfs 0,0(11)
	fadds 0,1,0
	stfs 0,16(30)
.L218:
	lis 3,.LC10@ha
	lwz 29,84(30)
	la 3,.LC10@l(3)
	bl FindItem
	lwz 0,1764(29)
	cmpw 0,0,3
	bc 4,2,.L219
	lwz 0,952(30)
	andi. 9,0,50
	bc 12,2,.L220
	bl rand
	lis 9,.LC25@ha
	rlwinm 3,3,0,17,31
	lfs 11,.LC25@l(9)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,36(1)
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	stw 0,32(1)
	lfd 13,0(9)
	lfd 0,32(1)
	lis 9,.LC26@ha
	lfd 12,.LC26@l(9)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 12,1,.L283
.L220:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,36(1)
	lis 11,.LC37@ha
	lis 10,.LC25@ha
	la 11,.LC37@l(11)
	stw 0,32(1)
	lfd 13,0(11)
	lfd 0,32(1)
	lis 11,.LC27@ha
	lfs 11,.LC25@l(10)
	lfd 12,.LC27@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L221
.L283:
	li 27,1
.L221:
	lwz 0,952(28)
	andi. 9,0,50
	bc 12,2,.L223
	lwz 0,972(28)
	addic 0,0,-1
	subfe 0,0,0
	and 27,27,0
.L223:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,36(1)
	lis 11,.LC37@ha
	stw 0,32(1)
	la 11,.LC37@l(11)
	addi 3,1,8
	lfd 13,0(11)
	lfd 0,32(1)
	lis 11,.LC25@ha
	lfs 12,.LC25@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 31,0,12
	bl VectorLengthSquared
	lwz 9,84(30)
	lwz 0,4184(9)
	cmpwi 0,0,3
	bc 4,2,.L224
	lhz 0,4416(9)
	cmpwi 0,0,1
	bc 4,2,.L225
	lbz 0,1(31)
	li 9,0
	sth 9,8(31)
	b .L284
.L225:
	cmpwi 0,0,5
	bc 4,2,.L227
	lbz 0,1(31)
	li 9,-100
	sth 9,10(31)
	b .L284
.L227:
	cmpwi 0,0,6
	bc 4,2,.L229
	lbz 0,1(31)
	li 9,100
	sth 9,10(31)
	b .L284
.L229:
	cmpwi 0,0,15
	bc 4,2,.L231
	lbz 0,1(31)
	li 11,-100
	li 9,-400
	sth 9,12(31)
	ori 0,0,1
	sth 11,8(31)
	stb 0,1(31)
	sth 11,10(31)
	b .L271
.L231:
	cmpwi 0,0,16
	bc 4,2,.L233
	lbz 0,1(31)
	li 9,-400
	li 11,100
	li 10,-100
	sth 9,12(31)
	ori 0,0,1
	sth 11,10(31)
	stb 0,1(31)
	sth 10,8(31)
	b .L271
.L233:
	cmpwi 0,0,2
	bc 4,2,.L235
	lbz 0,1(31)
	li 9,400
	sth 9,8(31)
	b .L284
.L235:
	cmpwi 0,0,11
	bc 4,2,.L237
	lbz 0,1(31)
	li 9,-100
	li 11,-400
	sth 9,8(31)
	ori 0,0,1
	sth 11,12(31)
	b .L285
.L237:
	cmpwi 0,0,14
	bc 4,2,.L239
	lbz 0,1(31)
	li 9,-100
	li 11,-400
	sth 9,8(31)
	ori 0,0,1
	sth 11,12(31)
	b .L285
.L239:
	cmpwi 0,0,8
	bc 4,2,.L241
	lbz 0,1(31)
	li 9,-400
	sth 9,12(31)
	b .L284
.L241:
	lwz 9,84(30)
	lhz 0,4416(9)
	cmpwi 0,0,7
	bc 4,2,.L243
	lbz 0,1(31)
	li 9,-400
	sth 9,12(31)
	b .L284
.L243:
	lbz 0,1(31)
	li 9,400
	sth 9,8(31)
	b .L284
.L224:
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 0,0(9)
	addic 11,27,-1
	subfe 9,11,27
	fcmpu 7,1,0
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	and. 11,0,9
	bc 12,2,.L246
	lwz 9,84(28)
	lwz 0,4184(9)
	cmpwi 0,0,3
	bc 12,2,.L246
	lis 9,.LC27@ha
	fmr 1,31
	lfd 0,.LC27@l(9)
	fcmpu 0,1,0
	bc 4,1,.L247
	lbz 0,1(31)
	b .L286
.L247:
	lis 9,.LC28@ha
	lfd 0,.LC28@l(9)
	fcmpu 0,1,0
	bc 4,1,.L249
	lbz 0,1(31)
	li 9,-100
	sth 9,10(31)
	b .L286
.L249:
	lis 9,.LC29@ha
	lfd 0,.LC29@l(9)
	fcmpu 0,1,0
	bc 4,1,.L251
	lbz 0,1(31)
	li 9,100
	sth 9,10(31)
	b .L286
.L251:
	lis 9,.LC30@ha
	lfd 0,.LC30@l(9)
	fcmpu 0,1,0
	bc 4,1,.L253
	lbz 0,1(31)
	li 9,-100
	li 11,-400
	sth 9,10(31)
	ori 0,0,1
	sth 11,12(31)
	b .L287
.L253:
	lis 9,.LC26@ha
	lfd 0,.LC26@l(9)
	fcmpu 0,1,0
	bc 4,1,.L255
	lbz 0,1(31)
	li 9,100
	li 11,-400
	sth 9,10(31)
	ori 0,0,1
	sth 11,12(31)
	b .L287
.L255:
	lbz 0,1(31)
	li 9,400
	sth 9,8(31)
.L286:
	ori 0,0,1
.L287:
	stb 0,1(31)
	lwz 0,952(30)
	ori 0,0,50
	stw 0,952(30)
	b .L271
.L246:
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	cror 3,2,0
	bc 4,3,.L258
	lwz 0,952(30)
	li 9,-51
	li 11,-200
	b .L288
.L258:
	lis 11,.LC39@ha
	la 11,.LC39@l(11)
	lfs 0,0(11)
	fcmpu 0,1,0
	cror 3,2,0
	bc 4,3,.L260
	bl rand
	lis 29,0x4330
	lis 9,.LC37@ha
	rlwinm 3,3,0,17,31
	la 9,.LC37@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 10,.LC25@ha
	lis 11,.LC31@ha
	lfs 30,.LC25@l(10)
	stw 3,36(1)
	stw 29,32(1)
	lfd 0,32(1)
	lfd 12,.LC31@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L260
	lwz 9,952(30)
	li 0,-51
	andi. 11,9,264
	and 0,9,0
	stw 0,952(30)
	bc 12,2,.L261
	li 0,50
	sth 0,10(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC32@ha
	stw 3,36(1)
	stw 29,32(1)
	lfd 0,32(1)
	lfd 12,.LC32@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L271
	lwz 0,952(30)
	li 9,-297
	b .L289
.L261:
	andi. 11,9,68
	bc 12,2,.L264
	li 0,-50
	sth 0,10(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC32@ha
	stw 3,36(1)
	stw 29,32(1)
	lfd 0,32(1)
	lfd 12,.LC32@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L271
	lwz 0,952(30)
	li 9,-101
	b .L289
.L264:
	ori 0,0,598
	stw 0,952(30)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC32@ha
	stw 3,36(1)
	stw 29,32(1)
	lfd 0,32(1)
	lfd 12,.LC32@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L271
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,.LC40@ha
	stw 3,36(1)
	la 11,.LC40@l(11)
	stw 29,32(1)
	lfd 0,32(1)
	lfd 12,0(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,30
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L268
	lwz 0,952(30)
	li 9,-599
	ori 0,0,296
	b .L289
.L268:
	lwz 0,952(30)
	li 9,-599
	ori 0,0,100
.L289:
	and 0,0,9
	stw 0,952(30)
	b .L271
.L260:
	lwz 0,952(30)
	li 9,-51
	li 11,400
.L288:
	and 0,0,9
	stw 0,952(30)
	sth 11,8(31)
	b .L271
.L219:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,36(1)
	lis 11,.LC37@ha
	lis 10,.LC25@ha
	la 11,.LC37@l(11)
	stw 0,32(1)
	lfd 12,0(11)
	lfd 0,32(1)
	lis 11,.LC26@ha
	lfs 11,.LC25@l(10)
	lfd 13,.LC26@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 31,0,11
	fmr 1,31
	fcmpu 0,1,13
	bc 4,0,.L272
	li 0,-400
	sth 0,10(31)
	b .L273
.L272:
	lis 9,.LC29@ha
	lfd 0,.LC29@l(9)
	fcmpu 0,1,0
	bc 4,0,.L274
	li 0,400
	sth 0,10(31)
	b .L273
.L274:
	lis 9,.LC33@ha
	lfd 0,.LC33@l(9)
	fcmpu 0,1,0
	bc 4,0,.L276
	li 0,-400
	sth 0,8(31)
	b .L273
.L276:
	lis 9,.LC32@ha
	lfd 0,.LC32@l(9)
	fcmpu 0,1,0
	bc 4,0,.L278
	li 0,400
	sth 0,8(31)
	b .L273
.L278:
	lis 9,.LC34@ha
	lfd 0,.LC34@l(9)
	fcmpu 0,1,0
	bc 4,0,.L280
	li 0,-400
	b .L290
.L280:
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfd 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L273
	li 0,400
.L290:
	sth 0,12(31)
.L273:
	lbz 0,1(31)
.L284:
	ori 0,0,1
.L285:
	stb 0,1(31)
.L271:
	lwz 0,84(1)
	mtlr 0
	lmw 27,44(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe4:
	.size	 Bot_Attack,.Lfe4-Bot_Attack
	.section	".rodata"
	.align 2
.LC43:
	.string	"weapon_saber"
	.align 2
.LC45:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Bot_Find_Nearest_Node
	.type	 Bot_Find_Nearest_Node,@function
Bot_Find_Nearest_Node:
	stwu 1,-176(1)
	mflr 0
	stfd 31,168(1)
	stmw 17,108(1)
	stw 0,180(1)
	lis 0,0xcccc
	mr 29,3
	ori 0,0,52428
	mr 22,4
	cmpw 0,29,0
	bc 12,2,.L309
	cmpwi 0,29,0
	bc 4,2,.L298
.L309:
	li 3,0
	ori 3,3,65535
	b .L308
.L298:
	lis 9,node_count@ha
	li 28,0
	lhz 0,node_count@l(9)
	li 26,0
	lis 24,0x10
	ori 26,26,65535
	lis 17,node_count@ha
	cmplw 0,28,0
	bc 4,0,.L300
	lis 9,node_list+4@ha
	li 25,0
	la 23,node_list+4@l(9)
	lis 11,gi@ha
	lis 9,.LC45@ha
	addi 18,23,4
	la 9,.LC45@l(9)
	la 19,gi@l(11)
	lfs 31,0(9)
	lis 20,node_list@ha
	ori 25,25,32768
	lis 21,vec3_origin@ha
.L302:
	cmpw 0,28,22
	bc 12,2,.L301
	mulli 30,28,12
	la 27,node_list@l(20)
	lfs 10,4(29)
	addi 3,1,8
	lfs 12,8(29)
	lfs 13,12(29)
	lfsx 0,18,30
	lfsx 11,27,30
	lfsx 9,23,30
	fsubs 13,13,0
	fsubs 10,10,11
	fsubs 12,12,9
	stfs 13,16(1)
	stfs 10,8(1)
	stfs 12,12(1)
	bl VectorLengthSquared
	fctiwz 0,1
	stfd 0,96(1)
	lwz 31,100(1)
	cmpw 0,31,25
	bc 12,1,.L301
	cmpw 0,31,24
	bc 4,0,.L301
	lwz 11,48(19)
	la 5,vec3_origin@l(21)
	add 7,30,27
	addi 3,1,24
	addi 4,29,4
	mr 6,5
	mr 8,29
	mtlr 11
	li 9,3
	blrl
	lfs 0,32(1)
	fcmpu 0,0,31
	bc 4,2,.L301
	mr 24,31
	mr 26,28
.L301:
	addi 0,28,1
	lhz 9,node_count@l(17)
	rlwinm 28,0,0,0xffff
	cmplw 0,28,9
	bc 12,0,.L302
.L300:
	mr 3,26
.L308:
	lwz 0,180(1)
	mtlr 0
	lmw 17,108(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe5:
	.size	 Bot_Find_Nearest_Node,.Lfe5-Bot_Find_Nearest_Node
	.section	".rodata"
	.align 2
.LC46:
	.long 0x0
	.align 2
.LC47:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Bot_Find_Enemy
	.type	 Bot_Find_Enemy,@function
Bot_Find_Enemy:
	stwu 1,-80(1)
	mflr 0
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 25,36(1)
	stw 0,84(1)
	lis 9,num_players@ha
	li 28,0
	lwz 0,num_players@l(9)
	mr 31,3
	lis 25,num_players@ha
	lis 9,.LC46@ha
	cmpw 0,28,0
	la 9,.LC46@l(9)
	lfs 30,0(9)
	bc 4,0,.L319
	lis 9,players@ha
	lis 11,level@ha
	la 29,players@l(9)
	la 26,level@l(11)
	lis 9,gi@ha
	li 30,0
	la 27,gi@l(9)
.L321:
	lwzx 3,30,29
	cmpw 0,3,31
	bc 12,2,.L320
	lwz 0,264(3)
	andi. 9,0,32
	bc 4,2,.L320
	lis 9,.LC46@ha
	lis 11,ctf@ha
	la 9,.LC46@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L324
	lwz 9,84(31)
	lwz 11,84(3)
	lwz 10,4048(9)
	lwz 0,4048(11)
	cmpw 0,10,0
	bc 12,2,.L320
.L324:
	li 4,10
	bl Force_constant_active
	cmpwi 0,3,255
	bc 12,2,.L326
	lwzx 11,30,29
	lfs 13,4(26)
	lwz 9,84(11)
	lfs 0,4464(9)
	fcmpu 0,0,13
	bc 12,0,.L320
.L326:
	lwzx 9,30,29
	lwz 0,492(9)
	cmpwi 0,0,0
	bc 4,2,.L320
	lfs 0,4(9)
	addi 3,1,8
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLengthSquared
	lis 9,.LC47@ha
	la 9,.LC47@l(9)
	lfs 0,0(9)
	fdivs 31,0,1
	fcmpu 0,31,30
	bc 4,1,.L320
	lwzx 4,30,29
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L320
	lwzx 4,30,29
	addi 3,31,4
	lwz 9,56(27)
	addi 4,4,4
	mtlr 9
	blrl
	cmpwi 0,3,0
	bc 12,2,.L320
	lwzx 0,30,29
	fmr 30,31
	stw 0,540(31)
.L320:
	lwz 0,num_players@l(25)
	addi 28,28,1
	addi 30,30,4
	cmpw 0,28,0
	bc 12,0,.L321
.L319:
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 12,2,.L331
	lis 9,.LC46@ha
	lis 11,saberonly@ha
	la 9,.LC46@l(9)
	lfs 13,0(9)
	lwz 9,saberonly@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L332
	lwz 0,1000(31)
	rlwinm 0,0,0,29,27
	stw 0,1000(31)
.L332:
	li 3,1
	b .L333
.L331:
	li 3,0
.L333:
	lwz 0,84(1)
	mtlr 0
	lmw 25,36(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe6:
	.size	 Bot_Find_Enemy,.Lfe6-Bot_Find_Enemy
	.section	".rodata"
	.align 2
.LC48:
	.long 0x46fffe00
	.align 2
.LC49:
	.long 0x477fff00
	.align 3
.LC50:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC51:
	.long 0x40000000
	.align 2
.LC52:
	.long 0x0
	.align 2
.LC53:
	.long 0x3f800000
	.align 2
.LC54:
	.long 0x42480000
	.align 2
.LC55:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl Bot_Find_Roam_Goal
	.type	 Bot_Find_Roam_Goal,@function
Bot_Find_Roam_Goal:
	stwu 1,-128(1)
	mflr 0
	stfd 30,112(1)
	stfd 31,120(1)
	stmw 14,40(1)
	stw 0,132(1)
	mr 22,3
	li 31,0
	lhz 0,992(22)
	ori 31,31,65535
	cmpw 0,0,31
	bc 12,2,.L335
	lwz 0,996(22)
	lis 10,0x4330
	lis 11,.LC50@ha
	xoris 0,0,0x8000
	la 11,.LC50@l(11)
	stw 0,36(1)
	stw 10,32(1)
	lfd 13,0(11)
	lfd 0,32(1)
	lis 11,level+4@ha
	lfs 12,level+4@l(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 12,0,.L334
.L335:
	lwz 0,1000(22)
	andi. 9,0,8
	bc 12,2,.L336
	lwz 9,324(22)
	lwz 9,248(9)
	cmpwi 0,9,0
	bc 4,2,.L334
	rlwinm 0,0,0,29,27
	stw 9,324(22)
	stw 0,1000(22)
.L336:
	lwz 0,996(22)
	lis 29,0x4330
	lis 11,.LC50@ha
	xoris 0,0,0x8000
	la 11,.LC50@l(11)
	stw 0,36(1)
	stw 29,32(1)
	lfd 31,0(11)
	lfd 0,32(1)
	lis 11,level@ha
	la 30,level@l(11)
	lfs 13,4(30)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L339
	lhz 4,990(22)
	mr 3,22
	bl Bot_Find_Nearest_Node
	lwz 0,1000(22)
	mr 31,3
	ori 0,0,1
	stw 0,1000(22)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 13,4(30)
	xoris 3,3,0x8000
	lis 9,.LC51@ha
	sth 31,992(22)
	stw 3,36(1)
	la 9,.LC51@l(9)
	lis 10,.LC48@ha
	stw 29,32(1)
	lfd 0,32(1)
	lfs 11,0(9)
	mr 9,11
	fsub 0,0,31
	fadds 13,13,11
	lfs 11,.LC48@l(10)
	frsp 0,0
	fdivs 0,0,11
	fadds 13,13,0
	fctiwz 12,13
	stfd 12,32(1)
	lwz 9,36(1)
	stw 9,996(22)
	b .L334
.L339:
	li 4,0
	mr 3,22
	ori 4,4,65535
	bl Bot_Find_Nearest_Node
	mr 18,3
	cmpw 0,18,31
	bc 12,2,.L334
	lis 11,.LC52@ha
	lis 9,saberonly@ha
	la 11,.LC52@l(11)
	lfs 30,0(11)
	lwz 11,saberonly@l(9)
	lfs 0,20(11)
	fcmpu 0,0,30
	bc 4,2,.L341
	lis 9,num_items@ha
	li 23,0
	lwz 0,num_items@l(9)
	cmpw 0,23,0
	bc 4,0,.L341
	lis 9,item_table@ha
	la 16,item_table@l(9)
.L345:
	mulli 9,23,12
	addi 19,23,1
	mr 17,9
	lwzx 9,16,9
	lwz 0,280(9)
	cmpwi 0,0,0
	bc 12,2,.L344
	lwz 0,248(9)
	cmpwi 0,0,0
	bc 12,2,.L344
	add 31,17,16
	mr 3,22
	mr 4,31
	bl Bot_Needs_Item
	cmpwi 0,3,0
	bc 12,2,.L344
	mr 3,31
	bl Bot_Find_Item_Weight
	lis 9,.LC52@ha
	fmr 31,1
	la 9,.LC52@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 12,2,.L344
	lhz 30,4(31)
	li 0,0
	ori 0,0,65535
	cmpw 0,30,0
	bc 12,2,.L344
	cmpw 0,18,0
	li 26,0
	bc 4,2,.L351
	lis 9,.LC49@ha
	lis 15,.LC49@ha
	lfs 12,.LC49@l(9)
	b .L352
.L406:
	xoris 0,26,0x8000
	stw 0,36(1)
	lis 11,.LC50@ha
	lis 0,0x4330
	la 11,.LC50@l(11)
	stw 0,32(1)
	lfd 13,0(11)
	lfd 0,32(1)
	fsub 0,0,13
	frsp 12,0
	b .L352
.L351:
	lis 9,graph+2048@ha
	lis 27,0xfff
	la 20,graph+2048@l(9)
	mr 3,18
	lis 15,.LC49@ha
	lis 21,graph@ha
	slwi 25,30,2
	ori 27,27,65535
	add 29,30,30
.L355:
	cmpw 0,3,30
	bc 12,2,.L406
	mulli 31,3,6144
	la 28,graph@l(21)
	add 0,25,31
	lwzx 9,20,0
	cmpw 0,9,27
	bc 4,1,.L411
	mr 4,30
	bl Dijkstra_ShortestPath
	cmpwi 0,3,0
	bc 12,2,.L410
.L411:
	add 0,29,31
	lhzx 3,28,0
	addi 26,26,1
	cmpwi 0,26,1023
	bc 4,1,.L355
.L410:
	lfs 12,.LC49@l(15)
.L352:
	lfs 0,.LC49@l(15)
	fcmpu 0,12,0
	bc 12,2,.L344
	lis 9,.LC53@ha
	la 9,.LC53@l(9)
	lfs 0,0(9)
	fdivs 0,0,12
	fmuls 0,0,31
	fcmpu 0,0,30
	bc 4,1,.L344
	fmr 30,0
	lwzx 14,16,17
	stw 23,8(1)
.L344:
	lis 11,num_items@ha
	mr 23,19
	lwz 0,num_items@l(11)
	cmpw 0,23,0
	bc 12,0,.L345
.L341:
	lwz 11,544(22)
	cmpwi 0,11,0
	bc 4,2,.L366
	lis 9,num_players@ha
	li 23,0
	lwz 0,num_players@l(9)
	cmpw 0,11,0
	bc 4,0,.L393
	lis 9,players@ha
	lis 11,level@ha
	la 20,players@l(9)
	la 16,level@l(11)
	lis 17,0x4330
.L370:
	slwi 0,23,2
	addi 19,23,1
	lwzx 3,20,0
	mr 25,0
	cmpwi 0,3,0
	bc 12,2,.L369
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L369
	cmpw 0,3,22
	bc 12,2,.L369
	lwz 0,264(3)
	andi. 9,0,32
	bc 4,2,.L369
	lwz 0,492(3)
	cmpwi 0,0,0
	bc 4,2,.L369
	li 4,10
	bl Force_constant_active
	cmpwi 0,3,255
	bc 12,2,.L376
	lwzx 11,20,25
	lfs 13,4(16)
	lwz 9,84(11)
	lfs 0,4464(9)
	fcmpu 0,0,13
	bc 12,0,.L369
.L376:
	lwzx 3,20,25
	li 4,0
	addi 19,23,1
	ori 4,4,65535
	bl Bot_Find_Nearest_Node
	li 0,0
	mr 24,3
	ori 0,0,65535
	cmpw 0,24,0
	bc 12,2,.L369
	cmpw 0,18,0
	li 27,0
	bc 4,2,.L378
	lis 9,.LC49@ha
	lis 15,.LC49@ha
	lfs 12,.LC49@l(9)
	b .L379
.L408:
	xoris 0,27,0x8000
	stw 0,36(1)
	lis 11,.LC50@ha
	la 11,.LC50@l(11)
	stw 17,32(1)
	lfd 13,0(11)
	lfd 0,32(1)
	fsub 0,0,13
	frsp 12,0
	b .L379
.L378:
	lis 9,graph+2048@ha
	lis 28,0xfff
	la 21,graph+2048@l(9)
	mr 3,18
	lis 15,.LC49@ha
	lis 23,graph@ha
	slwi 26,24,2
	ori 28,28,65535
	add 30,24,24
.L382:
	cmpw 0,3,24
	bc 12,2,.L408
	mulli 31,3,6144
	la 29,graph@l(23)
	add 0,26,31
	lwzx 9,21,0
	cmpw 0,9,28
	bc 4,1,.L413
	mr 4,24
	bl Dijkstra_ShortestPath
	cmpwi 0,3,0
	bc 12,2,.L412
.L413:
	add 0,30,31
	lhzx 3,29,0
	addi 27,27,1
	cmpwi 0,27,1023
	bc 4,1,.L382
.L412:
	lfs 12,.LC49@l(15)
.L379:
	lfs 0,.LC49@l(15)
	fcmpu 0,12,0
	bc 12,2,.L369
	lis 9,.LC53@ha
	lis 11,.LC54@ha
	la 9,.LC53@l(9)
	la 11,.LC54@l(11)
	lfs 0,0(9)
	lfs 13,0(11)
	fdivs 0,0,12
	fmuls 0,0,13
	fcmpu 0,0,30
	bc 4,1,.L369
	fmr 30,0
	lwzx 14,20,25
.L369:
	lis 9,num_players@ha
	mr 23,19
	lwz 0,num_players@l(9)
	cmpw 0,23,0
	bc 12,0,.L370
	b .L393
.L366:
	stw 11,540(22)
.L393:
	cmpwi 0,14,0
	bc 12,2,.L334
	li 11,1
	cmpwi 0,11,0
	mfcr 31
	bc 12,2,.L395
	li 4,0
	mr 3,14
	ori 4,4,65535
	bl Bot_Find_Nearest_Node
	lwz 0,1000(22)
	mr 24,3
	rlwinm 0,0,0,29,27
	stw 0,1000(22)
	b .L396
.L395:
	lwz 0,8(1)
	cmpwi 0,0,0
	bc 12,2,.L396
	mulli 11,0,12
	lis 9,item_table@ha
	la 9,item_table@l(9)
	add 11,11,9
	lhz 24,4(11)
.L396:
	li 0,0
	ori 0,0,65535
	xor 9,24,0
	subfic 11,9,0
	adde 9,11,9
	xor 0,18,0
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L334
	lhz 0,990(22)
	mtcrf 128,31
	mfcr 9
	rlwinm 9,9,3,1
	xor 0,0,24
	subfic 11,0,0
	adde 0,11,0
	and. 11,0,9
	bc 12,2,.L399
	lwz 0,1000(22)
	stw 14,324(22)
	ori 0,0,8
	stw 0,1000(22)
	b .L334
.L399:
	cmpw 0,18,24
	bc 4,2,.L400
	mr 31,24
	b .L401
.L400:
	lis 9,graph@ha
	mulli 31,18,6144
	slwi 0,24,2
	la 30,graph@l(9)
	lis 11,0xfff
	add 0,0,31
	addi 9,30,2048
	lwzx 10,9,0
	ori 11,11,65535
	cmpw 0,10,11
	bc 4,1,.L414
	mr 3,18
	mr 4,24
	bl Dijkstra_ShortestPath
	cmpwi 0,3,0
	bc 12,2,.L334
.L414:
	add 0,24,24
	add 0,0,31
	lhzx 31,30,0
.L401:
	lwz 0,1000(22)
	ori 0,0,1
	stw 0,1000(22)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,36(1)
	lis 11,.LC50@ha
	lis 8,.LC48@ha
	la 11,.LC50@l(11)
	stw 0,32(1)
	lis 10,level+4@ha
	lfd 11,0(11)
	lfd 13,32(1)
	lis 11,.LC55@ha
	lfs 10,.LC48@l(8)
	la 11,.LC55@l(11)
	lfs 0,level+4@l(10)
	fsub 13,13,11
	lfs 9,0(11)
	mr 11,9
	sth 31,992(22)
	frsp 13,13
	fadds 0,0,9
	fdivs 13,13,10
	fadds 0,0,13
	fctiwz 12,0
	stfd 12,32(1)
	lwz 11,36(1)
	stw 11,996(22)
.L334:
	lwz 0,132(1)
	mtlr 0
	lmw 14,40(1)
	lfd 30,112(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe7:
	.size	 Bot_Find_Roam_Goal,.Lfe7-Bot_Find_Roam_Goal
	.section	".rodata"
	.align 2
.LC56:
	.long 0x46fffe00
	.align 2
.LC57:
	.long 0x477fff00
	.align 3
.LC58:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC59:
	.long 0x40000000
	.align 2
.LC60:
	.long 0x0
	.align 2
.LC61:
	.long 0x3f800000
	.align 2
.LC62:
	.long 0x42480000
	.align 2
.LC63:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl Bot_CTF_Think
	.type	 Bot_CTF_Think,@function
Bot_CTF_Think:
	stwu 1,-128(1)
	mflr 0
	stfd 30,112(1)
	stfd 31,120(1)
	stmw 14,40(1)
	stw 0,132(1)
	mr 22,3
	li 31,0
	lhz 0,992(22)
	ori 31,31,65535
	cmpw 0,0,31
	bc 12,2,.L416
	lwz 0,996(22)
	lis 10,0x4330
	lis 11,.LC58@ha
	xoris 0,0,0x8000
	la 11,.LC58@l(11)
	stw 0,36(1)
	stw 10,32(1)
	lfd 13,0(11)
	lfd 0,32(1)
	lis 11,level+4@ha
	lfs 12,level+4@l(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 12,0,.L415
.L416:
	lwz 0,1000(22)
	andi. 9,0,8
	bc 12,2,.L417
	lwz 9,324(22)
	lwz 9,248(9)
	cmpwi 0,9,0
	bc 4,2,.L415
	rlwinm 0,0,0,29,27
	stw 9,324(22)
	stw 0,1000(22)
.L417:
	lwz 0,996(22)
	lis 29,0x4330
	lis 11,.LC58@ha
	xoris 0,0,0x8000
	la 11,.LC58@l(11)
	stw 0,36(1)
	stw 29,32(1)
	lfd 31,0(11)
	lfd 0,32(1)
	lis 11,level@ha
	la 30,level@l(11)
	lfs 13,4(30)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,1,.L420
	lhz 4,990(22)
	mr 3,22
	bl Bot_Find_Nearest_Node
	lwz 0,1000(22)
	mr 31,3
	ori 0,0,1
	stw 0,1000(22)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 13,4(30)
	xoris 3,3,0x8000
	lis 9,.LC59@ha
	sth 31,992(22)
	stw 3,36(1)
	la 9,.LC59@l(9)
	lis 10,.LC56@ha
	stw 29,32(1)
	lfd 0,32(1)
	lfs 11,0(9)
	mr 9,11
	fsub 0,0,31
	fadds 13,13,11
	lfs 11,.LC56@l(10)
	frsp 0,0
	fdivs 0,0,11
	fadds 13,13,0
	fctiwz 12,13
	stfd 12,32(1)
	lwz 9,36(1)
	stw 9,996(22)
	b .L415
.L420:
	li 4,0
	mr 3,22
	ori 4,4,65535
	bl Bot_Find_Nearest_Node
	mr 18,3
	cmpw 0,18,31
	bc 12,2,.L415
	lis 11,.LC60@ha
	lis 9,saberonly@ha
	la 11,.LC60@l(11)
	lfs 30,0(11)
	lwz 11,saberonly@l(9)
	lfs 0,20(11)
	fcmpu 0,0,30
	bc 4,2,.L422
	lis 9,num_items@ha
	li 23,0
	lwz 0,num_items@l(9)
	cmpw 0,23,0
	bc 4,0,.L422
	lis 9,item_table@ha
	la 16,item_table@l(9)
.L426:
	mulli 9,23,12
	addi 19,23,1
	mr 17,9
	lwzx 9,16,9
	lwz 0,280(9)
	cmpwi 0,0,0
	bc 12,2,.L425
	lwz 0,248(9)
	cmpwi 0,0,0
	bc 12,2,.L425
	add 31,17,16
	mr 3,22
	mr 4,31
	bl Bot_Needs_Item
	cmpwi 0,3,0
	bc 12,2,.L425
	mr 3,31
	bl Bot_Find_Item_Weight
	lis 9,.LC60@ha
	fmr 31,1
	la 9,.LC60@l(9)
	lfs 0,0(9)
	fcmpu 0,31,0
	bc 12,2,.L425
	lhz 30,4(31)
	li 0,0
	ori 0,0,65535
	cmpw 0,30,0
	bc 12,2,.L425
	cmpw 0,18,0
	li 26,0
	bc 4,2,.L432
	lis 9,.LC57@ha
	lis 15,.LC57@ha
	lfs 12,.LC57@l(9)
	b .L433
.L487:
	xoris 0,26,0x8000
	stw 0,36(1)
	lis 11,.LC58@ha
	lis 0,0x4330
	la 11,.LC58@l(11)
	stw 0,32(1)
	lfd 13,0(11)
	lfd 0,32(1)
	fsub 0,0,13
	frsp 12,0
	b .L433
.L432:
	lis 9,graph+2048@ha
	lis 27,0xfff
	la 20,graph+2048@l(9)
	mr 3,18
	lis 15,.LC57@ha
	lis 21,graph@ha
	slwi 25,30,2
	ori 27,27,65535
	add 29,30,30
.L436:
	cmpw 0,3,30
	bc 12,2,.L487
	mulli 31,3,6144
	la 28,graph@l(21)
	add 0,25,31
	lwzx 9,20,0
	cmpw 0,9,27
	bc 4,1,.L492
	mr 4,30
	bl Dijkstra_ShortestPath
	cmpwi 0,3,0
	bc 12,2,.L491
.L492:
	add 0,29,31
	lhzx 3,28,0
	addi 26,26,1
	cmpwi 0,26,1023
	bc 4,1,.L436
.L491:
	lfs 12,.LC57@l(15)
.L433:
	lfs 0,.LC57@l(15)
	fcmpu 0,12,0
	bc 12,2,.L425
	lis 9,.LC61@ha
	la 9,.LC61@l(9)
	lfs 0,0(9)
	fdivs 0,0,12
	fmuls 0,0,31
	fcmpu 0,0,30
	bc 4,1,.L425
	fmr 30,0
	lwzx 14,16,17
	stw 23,8(1)
.L425:
	lis 11,num_items@ha
	mr 23,19
	lwz 0,num_items@l(11)
	cmpw 0,23,0
	bc 12,0,.L426
.L422:
	lwz 11,544(22)
	cmpwi 0,11,0
	bc 4,2,.L447
	lis 9,num_players@ha
	li 23,0
	lwz 0,num_players@l(9)
	cmpw 0,11,0
	bc 4,0,.L474
	lis 9,players@ha
	lis 11,level@ha
	la 20,players@l(9)
	la 16,level@l(11)
	lis 17,0x4330
.L451:
	slwi 0,23,2
	addi 19,23,1
	lwzx 3,20,0
	mr 25,0
	cmpwi 0,3,0
	bc 12,2,.L450
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L450
	cmpw 0,3,22
	bc 12,2,.L450
	lwz 0,264(3)
	andi. 9,0,32
	bc 4,2,.L450
	lwz 0,492(3)
	cmpwi 0,0,0
	bc 4,2,.L450
	li 4,10
	bl Force_constant_active
	cmpwi 0,3,255
	bc 12,2,.L457
	lwzx 11,20,25
	lfs 13,4(16)
	lwz 9,84(11)
	lfs 0,4464(9)
	fcmpu 0,0,13
	bc 12,0,.L450
.L457:
	lwzx 3,20,25
	li 4,0
	addi 19,23,1
	ori 4,4,65535
	bl Bot_Find_Nearest_Node
	li 0,0
	mr 24,3
	ori 0,0,65535
	cmpw 0,24,0
	bc 12,2,.L450
	cmpw 0,18,0
	li 27,0
	bc 4,2,.L459
	lis 9,.LC57@ha
	lis 15,.LC57@ha
	lfs 12,.LC57@l(9)
	b .L460
.L489:
	xoris 0,27,0x8000
	stw 0,36(1)
	lis 11,.LC58@ha
	la 11,.LC58@l(11)
	stw 17,32(1)
	lfd 13,0(11)
	lfd 0,32(1)
	fsub 0,0,13
	frsp 12,0
	b .L460
.L459:
	lis 9,graph+2048@ha
	lis 28,0xfff
	la 21,graph+2048@l(9)
	mr 3,18
	lis 15,.LC57@ha
	lis 23,graph@ha
	slwi 26,24,2
	ori 28,28,65535
	add 30,24,24
.L463:
	cmpw 0,3,24
	bc 12,2,.L489
	mulli 31,3,6144
	la 29,graph@l(23)
	add 0,26,31
	lwzx 9,21,0
	cmpw 0,9,28
	bc 4,1,.L494
	mr 4,24
	bl Dijkstra_ShortestPath
	cmpwi 0,3,0
	bc 12,2,.L493
.L494:
	add 0,30,31
	lhzx 3,29,0
	addi 27,27,1
	cmpwi 0,27,1023
	bc 4,1,.L463
.L493:
	lfs 12,.LC57@l(15)
.L460:
	lfs 0,.LC57@l(15)
	fcmpu 0,12,0
	bc 12,2,.L450
	lis 9,.LC61@ha
	lis 11,.LC62@ha
	la 9,.LC61@l(9)
	la 11,.LC62@l(11)
	lfs 0,0(9)
	lfs 13,0(11)
	fdivs 0,0,12
	fmuls 0,0,13
	fcmpu 0,0,30
	bc 4,1,.L450
	fmr 30,0
	lwzx 14,20,25
.L450:
	lis 9,num_players@ha
	mr 23,19
	lwz 0,num_players@l(9)
	cmpw 0,23,0
	bc 12,0,.L451
	b .L474
.L447:
	stw 11,540(22)
.L474:
	cmpwi 0,14,0
	bc 12,2,.L415
	li 11,1
	cmpwi 0,11,0
	mfcr 31
	bc 12,2,.L476
	li 4,0
	mr 3,14
	ori 4,4,65535
	bl Bot_Find_Nearest_Node
	lwz 0,1000(22)
	mr 24,3
	rlwinm 0,0,0,29,27
	stw 0,1000(22)
	b .L477
.L476:
	lwz 0,8(1)
	cmpwi 0,0,0
	bc 12,2,.L477
	mulli 11,0,12
	lis 9,item_table@ha
	la 9,item_table@l(9)
	add 11,11,9
	lhz 24,4(11)
.L477:
	li 0,0
	ori 0,0,65535
	xor 9,24,0
	subfic 11,9,0
	adde 9,11,9
	xor 0,18,0
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L415
	lhz 0,990(22)
	mtcrf 128,31
	mfcr 9
	rlwinm 9,9,3,1
	xor 0,0,24
	subfic 11,0,0
	adde 0,11,0
	and. 11,0,9
	bc 12,2,.L480
	lwz 0,1000(22)
	stw 14,324(22)
	ori 0,0,8
	stw 0,1000(22)
	b .L415
.L480:
	cmpw 0,18,24
	bc 4,2,.L481
	mr 31,24
	b .L482
.L481:
	lis 9,graph@ha
	mulli 31,18,6144
	slwi 0,24,2
	la 30,graph@l(9)
	lis 11,0xfff
	add 0,0,31
	addi 9,30,2048
	lwzx 10,9,0
	ori 11,11,65535
	cmpw 0,10,11
	bc 4,1,.L495
	mr 3,18
	mr 4,24
	bl Dijkstra_ShortestPath
	cmpwi 0,3,0
	bc 12,2,.L415
.L495:
	add 0,24,24
	add 0,0,31
	lhzx 31,30,0
.L482:
	lwz 0,1000(22)
	ori 0,0,1
	stw 0,1000(22)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,36(1)
	lis 11,.LC58@ha
	lis 8,.LC56@ha
	la 11,.LC58@l(11)
	stw 0,32(1)
	lis 10,level+4@ha
	lfd 11,0(11)
	lfd 13,32(1)
	lis 11,.LC63@ha
	lfs 10,.LC56@l(8)
	la 11,.LC63@l(11)
	lfs 0,level+4@l(10)
	fsub 13,13,11
	lfs 9,0(11)
	mr 11,9
	sth 31,992(22)
	frsp 13,13
	fadds 0,0,9
	fdivs 13,13,10
	fadds 0,0,13
	fctiwz 12,0
	stfd 12,32(1)
	lwz 11,36(1)
	stw 11,996(22)
.L415:
	lwz 0,132(1)
	mtlr 0
	lmw 14,40(1)
	lfd 30,112(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe8:
	.size	 Bot_CTF_Think,.Lfe8-Bot_CTF_Think
	.section	".rodata"
	.align 2
.LC64:
	.long 0x46fffe00
	.align 3
.LC65:
	.long 0x3fefae14
	.long 0x7ae147ae
	.align 3
.LC66:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC67:
	.long 0x44800000
	.align 2
.LC68:
	.long 0x45800000
	.align 3
.LC69:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC70:
	.long 0x43b40000
	.align 2
.LC71:
	.long 0x43340000
	.align 2
.LC72:
	.long 0x0
	.align 2
.LC73:
	.long 0x47800000
	.align 2
.LC74:
	.long 0x41c80000
	.align 3
.LC75:
	.long 0x40490000
	.long 0x0
	.section	".text"
	.align 2
	.globl Bot_AI_Think
	.type	 Bot_AI_Think,@function
Bot_AI_Think:
	stwu 1,-80(1)
	mflr 0
	stmw 29,68(1)
	stw 0,84(1)
	mr 31,3
	li 0,0
	lwz 11,84(31)
	addi 3,1,8
	li 4,0
	mr 29,3
	li 5,16
	lfs 13,28(11)
	stfs 13,16(31)
	lfs 0,32(11)
	stfs 0,20(31)
	lfs 13,36(11)
	stfs 13,24(31)
	sth 0,20(11)
	lwz 9,84(31)
	sth 0,22(9)
	lwz 11,84(31)
	sth 0,24(11)
	crxor 6,6,6
	bl memset
	lwz 0,492(31)
	li 10,0
	lwz 9,540(31)
	cmpwi 0,0,0
	stw 10,540(31)
	stw 9,544(31)
	bc 12,2,.L517
	lwz 9,84(31)
	li 11,1
	stw 10,4132(9)
	lwz 0,492(31)
	stb 11,9(1)
	cmpwi 0,0,0
	bc 4,2,.L498
.L517:
	lhz 11,992(31)
	li 30,0
	ori 30,30,65535
	cmpw 0,11,30
	bc 12,2,.L501
	lwz 0,1000(31)
	andi. 9,0,8
	bc 4,2,.L501
	lis 9,node_list@ha
	mulli 0,11,12
	lfs 10,4(31)
	addi 3,1,24
	la 9,node_list@l(9)
	lfs 13,8(31)
	addi 11,9,8
	addi 10,9,4
	lfsx 12,9,0
	lfsx 9,11,0
	lfsx 11,10,0
	lfs 0,12(31)
	fsubs 10,10,12
	fsubs 13,13,11
	fsubs 0,0,9
	stfs 10,24(1)
	stfs 13,28(1)
	stfs 0,32(1)
	bl VectorLengthSquared
	lis 9,.LC67@ha
	la 9,.LC67@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L501
	mr 3,31
	bl Bot_Find_Roam_Goal
	lhz 0,992(31)
	sth 30,992(31)
	sth 0,990(31)
.L501:
	mr 3,31
	bl Bot_Find_Enemy
	cmpwi 0,3,0
	bc 4,2,.L503
	mr 3,31
	bl Bot_Find_Roam_Goal
	lwz 0,1000(31)
	andi. 9,0,8
	bc 12,2,.L504
	lwz 9,324(31)
	lfs 0,4(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,24(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,28(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,32(1)
	b .L505
.L504:
	lhz 0,992(31)
	lis 9,node_list@ha
	la 9,node_list@l(9)
	lfs 9,4(31)
	mulli 0,0,12
	addi 11,9,8
	addi 10,9,4
	lfs 10,8(31)
	lfs 11,12(31)
	lfsx 0,11,0
	lfsx 13,10,0
	lfsx 12,9,0
	fsubs 0,0,11
	fsubs 13,13,10
	fsubs 12,12,9
	stfs 0,32(1)
	stfs 13,28(1)
	stfs 12,24(1)
.L505:
	addi 3,1,24
	bl vectoyaw
	addi 3,31,376
	stfs 1,20(31)
	stfs 1,424(31)
	bl VectorLengthSquared
	lis 9,.LC68@ha
	la 9,.LC68@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L507
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L507
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,20(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,60(1)
	lis 10,.LC69@ha
	lis 11,.LC64@ha
	la 10,.LC69@l(10)
	stw 0,56(1)
	lfd 11,0(10)
	li 0,-400
	lfd 0,56(1)
	lis 10,.LC70@ha
	lfs 13,.LC64@l(11)
	la 10,.LC70@l(10)
	lfs 9,0(10)
	fsub 0,0,11
	lis 10,.LC71@ha
	sth 0,8(29)
	la 10,.LC71@l(10)
	lfs 10,0(10)
	frsp 0,0
	fdivs 0,0,13
	fmsubs 0,0,9,10
	fadds 12,12,0
	stfs 12,20(31)
	b .L512
.L507:
	lwz 9,84(31)
	lis 4,.LC43@ha
	la 4,.LC43@l(4)
	lwz 11,1764(9)
	lwz 3,0(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L509
	li 0,200
	sth 0,8(29)
	b .L512
.L509:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,60(1)
	lis 10,.LC69@ha
	lis 11,.LC65@ha
	la 10,.LC69@l(10)
	stw 0,56(1)
	lfd 13,0(10)
	lfd 0,56(1)
	lis 10,.LC64@ha
	lfs 11,.LC64@l(10)
	lfd 12,.LC65@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L511
	li 0,400
	sth 0,12(29)
.L511:
	li 0,400
	sth 0,8(29)
	b .L512
.L503:
	lis 11,.LC72@ha
	lis 9,ctf@ha
	la 11,.LC72@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L513
	lis 9,saberonly@ha
	lwz 11,saberonly@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L514
	mr 3,31
	bl Bot_Choose_Weapon
	mr 3,31
	bl Bot_Find_Roam_Goal
.L514:
	lwz 4,540(31)
	mr 3,31
	addi 5,1,8
	bl Bot_Attack
	b .L512
.L513:
	mr 3,31
	bl Bot_CTF_Think
	mr 3,31
	bl Bot_Choose_Weapon
	lwz 4,540(31)
	mr 3,31
	addi 5,1,8
	bl Bot_Attack
.L512:
	lwz 11,552(31)
	cmpwi 0,11,0
	bc 4,2,.L498
	lwz 9,84(31)
	li 0,1
	stw 11,4132(9)
	stb 0,9(1)
.L498:
	lis 9,.LC73@ha
	lfs 12,16(31)
	lis 10,.LC70@ha
	la 9,.LC73@l(9)
	lfs 13,20(31)
	la 10,.LC70@l(10)
	lfs 8,0(9)
	lfs 7,0(10)
	lfs 0,24(31)
	fmuls 12,12,8
	mr 9,10
	mr 11,10
	fmuls 13,13,8
	fmuls 0,0,8
	fdivs 12,12,7
	fdivs 13,13,7
	fdivs 0,0,7
	fctiwz 11,12
	fctiwz 10,13
	fctiwz 9,0
	stfd 11,56(1)
	lwz 10,60(1)
	stfd 10,56(1)
	lwz 9,60(1)
	stfd 9,56(1)
	lwz 11,60(1)
	sth 10,10(1)
	sth 9,12(1)
	sth 11,14(1)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,60(1)
	lis 10,.LC69@ha
	lis 11,.LC64@ha
	stw 0,56(1)
	la 10,.LC69@l(10)
	lfd 13,0(10)
	lfd 0,56(1)
	lis 10,.LC74@ha
	lfs 12,.LC64@l(11)
	la 10,.LC74@l(10)
	lfs 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmuls 0,0,11
	fmr 1,0
	bl ceil
	lis 9,.LC75@ha
	lwz 11,84(31)
	mr 3,31
	la 9,.LC75@l(9)
	addi 4,1,8
	lfd 13,0(9)
	fadd 1,1,13
	fctiwz 0,1
	stfd 0,56(1)
	lwz 9,60(1)
	rlwinm 0,9,0,0xff
	stb 9,8(1)
	stw 0,184(11)
	bl ClientThink
	lis 9,level+4@ha
	lis 11,.LC66@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC66@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,84(1)
	mtlr 0
	lmw 29,68(1)
	la 1,80(1)
	blr
.Lfe9:
	.size	 Bot_AI_Think,.Lfe9-Bot_AI_Think
	.comm	node_count,2,2
	.comm	path_not_time_yet,4,4
	.comm	conversation_content,7760,4
	.comm	highlighted,4,4
	.comm	yeah_you,4,4
	.comm	its_me,4,4
	.comm	holdthephone,4,4
	.comm	NoTouch,4,4
	.comm	showingit,4,4
	.comm	path_time,4,4
	.comm	print_time,4,4
	.section	".rodata"
	.align 2
.LC76:
	.long 0x477fff00
	.align 3
.LC77:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Bot_Calc_Path_Cost
	.type	 Bot_Calc_Path_Cost,@function
Bot_Calc_Path_Cost:
	stwu 1,-64(1)
	mflr 0
	stmw 23,28(1)
	stw 0,68(1)
	li 0,0
	mr 30,4
	ori 0,0,65535
	li 27,0
	xor 9,30,0
	subfic 10,9,0
	adde 9,10,9
	xor 0,3,0
	subfic 11,0,0
	adde 0,11,0
	or. 10,0,9
	bc 12,2,.L7
	b .L521
.L519:
	xoris 0,27,0x8000
	stw 0,20(1)
	lis 11,0x4330
	lis 10,.LC77@ha
	la 10,.LC77@l(10)
	stw 11,16(1)
	lfd 0,0(10)
	lfd 1,16(1)
	fsub 1,1,0
	frsp 1,1
	b .L518
.L7:
	lis 9,graph+2048@ha
	lis 26,0xfff
	la 23,graph+2048@l(9)
	lis 24,graph@ha
	slwi 25,30,2
	ori 26,26,65535
	add 29,30,30
.L10:
	cmpw 0,3,30
	bc 12,2,.L519
	mulli 31,3,6144
	la 28,graph@l(24)
	add 0,25,31
	lwzx 9,23,0
	cmpw 0,9,26
	bc 4,1,.L522
	mr 4,30
	bl Dijkstra_ShortestPath
	cmpwi 0,3,0
	bc 12,2,.L521
.L522:
	add 0,29,31
	lhzx 3,28,0
	addi 27,27,1
	cmpwi 0,27,1023
	bc 4,1,.L10
.L521:
	lis 9,.LC76@ha
	lfs 1,.LC76@l(9)
.L518:
	lwz 0,68(1)
	mtlr 0
	lmw 23,28(1)
	la 1,64(1)
	blr
.Lfe10:
	.size	 Bot_Calc_Path_Cost,.Lfe10-Bot_Calc_Path_Cost
	.align 2
	.globl Bot_ChangeWeapon
	.type	 Bot_ChangeWeapon,@function
Bot_ChangeWeapon:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,4
	mr 30,3
	lwz 3,52(31)
	cmpwi 0,3,0
	bc 12,2,.L106
	bl FindItem
	lis 9,itemlist@ha
	lis 11,0x286b
	lwz 8,84(30)
	la 9,itemlist@l(9)
	ori 11,11,51739
	subf 0,9,31
	subf 3,9,3
	mullw 0,0,11
	addi 10,8,1792
	mullw 3,3,11
	rlwinm 0,0,0,0,29
	lwzx 9,10,0
	srawi 0,3,2
	cmpwi 0,9,0
	bc 4,2,.L106
	slwi 0,0,2
	addi 9,8,740
	lwzx 11,9,0
	cmpwi 0,11,0
	li 3,0
	bc 12,2,.L523
.L106:
	lwz 3,84(30)
	lwz 0,1764(3)
	cmpw 0,31,0
	bc 4,2,.L109
	li 3,1
	b .L523
.L109:
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,31
	addi 11,3,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L110
	stw 31,4148(3)
	li 3,1
	b .L523
.L110:
	li 3,0
.L523:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 Bot_ChangeWeapon,.Lfe11-Bot_ChangeWeapon
	.section	".rodata"
	.align 2
.LC78:
	.long 0x46fffe00
	.align 3
.LC79:
	.long 0x3fefae14
	.long 0x7ae147ae
	.align 2
.LC80:
	.long 0x45800000
	.align 3
.LC81:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC82:
	.long 0x43b40000
	.align 2
.LC83:
	.long 0x43340000
	.section	".text"
	.align 2
	.globl Bot_Move
	.type	 Bot_Move,@function
Bot_Move:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	addi 3,31,376
	bl VectorLengthSquared
	lis 9,.LC80@ha
	la 9,.LC80@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L292
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L292
	bl rand
	rlwinm 3,3,0,17,31
	lfs 11,20(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC81@ha
	lis 11,.LC78@ha
	la 10,.LC81@l(10)
	stw 0,16(1)
	lfd 12,0(10)
	li 0,-400
	lfd 0,16(1)
	lis 10,.LC82@ha
	lfs 13,.LC78@l(11)
	la 10,.LC82@l(10)
	lfs 9,0(10)
	fsub 0,0,12
	lis 10,.LC83@ha
	la 10,.LC83@l(10)
	lfs 10,0(10)
	frsp 0,0
	fdivs 0,0,13
	fmsubs 0,0,9,10
	fadds 11,11,0
	stfs 11,20(31)
	b .L524
.L292:
	lwz 9,84(31)
	lis 4,.LC43@ha
	la 4,.LC43@l(4)
	lwz 11,1764(9)
	lwz 3,0(11)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L293
	li 0,200
	b .L524
.L293:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC81@ha
	lis 11,.LC79@ha
	la 10,.LC81@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC78@ha
	lfs 11,.LC78@l(10)
	lfd 12,.LC79@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L295
	li 0,400
	sth 0,12(30)
.L295:
	li 0,400
.L524:
	sth 0,8(30)
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 Bot_Move,.Lfe12-Bot_Move
	.section	".rodata"
	.align 2
.LC84:
	.long 0x44800000
	.section	".text"
	.align 2
	.globl Bot_Check_Node_Dist
	.type	 Bot_Check_Node_Dist,@function
Bot_Check_Node_Dist:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	li 30,0
	lhz 11,992(31)
	ori 30,30,65535
	cmpw 0,11,30
	bc 12,2,.L310
	lwz 0,1000(31)
	andi. 9,0,8
	bc 4,2,.L310
	lis 9,node_list@ha
	mulli 0,11,12
	lfs 10,4(31)
	addi 3,1,8
	la 9,node_list@l(9)
	lfs 13,8(31)
	addi 11,9,8
	addi 10,9,4
	lfsx 12,9,0
	lfsx 9,11,0
	lfsx 11,10,0
	lfs 0,12(31)
	fsubs 10,10,12
	fsubs 13,13,11
	fsubs 0,0,9
	stfs 10,8(1)
	stfs 13,12(1)
	stfs 0,16(1)
	bl VectorLengthSquared
	lis 9,.LC84@ha
	la 9,.LC84@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L310
	mr 3,31
	bl Bot_Find_Roam_Goal
	lhz 0,992(31)
	sth 30,992(31)
	sth 0,990(31)
.L310:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 Bot_Check_Node_Dist,.Lfe13-Bot_Check_Node_Dist
	.align 2
	.globl Bot_Turn_To_Goal
	.type	 Bot_Turn_To_Goal,@function
Bot_Turn_To_Goal:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,1000(31)
	andi. 9,0,8
	bc 12,2,.L315
	lwz 9,324(31)
	lfs 0,4(31)
	lfs 13,4(9)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(9)
	fsubs 0,0,12
	stfs 0,12(1)
	lfs 13,12(9)
	fsubs 13,13,11
	stfs 13,16(1)
	b .L316
.L315:
	lhz 0,992(31)
	lis 9,node_list@ha
	la 9,node_list@l(9)
	lfs 9,4(31)
	mulli 0,0,12
	addi 11,9,8
	addi 10,9,4
	lfs 10,8(31)
	lfs 11,12(31)
	lfsx 0,11,0
	lfsx 13,10,0
	lfsx 12,9,0
	fsubs 0,0,11
	fsubs 13,13,10
	fsubs 12,12,9
	stfs 0,16(1)
	stfs 13,12(1)
	stfs 12,8(1)
.L316:
	addi 3,1,8
	bl vectoyaw
	stfs 1,20(31)
	stfs 1,424(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 Bot_Turn_To_Goal,.Lfe14-Bot_Turn_To_Goal
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
