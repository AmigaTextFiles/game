	.file	"super.cpp"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Cloaking Disabled\n"
	.align 2
.LC1:
	.string	"Power Cube"
	.section	".text"
	.align 2
	.globl KOTSCloak
	.type	 KOTSCloak,@function
KOTSCloak:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	lwz 29,84(31)
	lwz 0,1844(29)
	cmpwi 0,0,0
	bc 12,2,.L20
	lwz 11,492(31)
	cmpwi 0,11,0
	bc 4,2,.L20
	lbz 0,1(4)
	andi. 27,0,1
	bc 12,2,.L9
	lwz 0,184(31)
	lis 9,gi+8@ha
	lis 5,.LC0@ha
	mr 3,31
	la 5,.LC0@l(5)
	rlwinm 0,0,0,0,30
	li 4,2
	stw 0,184(31)
	stw 11,1844(29)
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L20:
	li 3,0
	b .L19
.L9:
	lwz 0,184(31)
	andi. 9,0,1
	bc 12,2,.L14
	lis 28,.LC1@ha
	lis 30,0x286b
	la 3,.LC1@l(28)
	ori 30,30,51739
	bl FindItem
	addi 11,29,740
	lis 9,itemlist@ha
	la 29,itemlist@l(9)
	subf 3,29,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,11,3
	cmpwi 0,0,0
	bc 4,1,.L15
	lwz 10,84(31)
	lwz 9,1848(10)
	addi 9,9,1
	stw 9,1848(10)
	lwz 11,84(31)
	lwz 0,1848(11)
	cmpwi 0,0,10
	bc 4,2,.L14
	la 3,.LC1@l(28)
	bl FindItem
	subf 3,29,3
	lwz 10,84(31)
	mullw 3,3,30
	addi 10,10,740
	rlwinm 3,3,0,0,29
	lwzx 9,10,3
	addi 9,9,-1
	stwx 9,10,3
	lwz 11,84(31)
	stw 27,1848(11)
	b .L14
.L15:
	lis 9,gi+8@ha
	lis 5,.LC0@ha
	lwz 0,gi+8@l(9)
	la 5,.LC0@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,184(31)
	lwz 9,84(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	stw 27,1844(9)
.L14:
	li 3,1
.L19:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 KOTSCloak,.Lfe1-KOTSCloak
	.section	".rodata"
	.align 2
.LC2:
	.string	"weapons/rockfly.wav"
	.align 2
.LC3:
	.string	"Low Gravity Disabled\n"
	.align 2
.LC4:
	.long 0x3f800000
	.align 2
.LC5:
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSFly
	.type	 KOTSFly,@function
KOTSFly:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 31,3
	lwz 29,84(31)
	lwz 0,1852(29)
	cmpwi 0,0,0
	bc 12,2,.L23
	lwz 28,492(31)
	cmpwi 0,28,0
	bc 12,2,.L22
.L23:
	li 3,0
	b .L28
.L22:
	lis 27,.LC1@ha
	lis 30,0x286b
	la 3,.LC1@l(27)
	ori 30,30,51739
	bl FindItem
	addi 11,29,740
	lis 9,itemlist@ha
	la 29,itemlist@l(9)
	subf 3,29,3
	mullw 3,3,30
	rlwinm 3,3,0,0,29
	lwzx 0,11,3
	cmpwi 0,0,0
	bc 12,1,.L24
	lis 9,gi+8@ha
	lis 5,.LC3@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC3@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 9,84(31)
	li 3,0
	stw 28,1852(9)
	b .L28
.L24:
	lwz 10,84(31)
	lwz 9,1856(10)
	addi 9,9,1
	stw 9,1856(10)
	lwz 11,84(31)
	lwz 0,1856(11)
	cmpwi 0,0,10
	bc 4,2,.L26
	la 3,.LC1@l(27)
	bl FindItem
	subf 0,29,3
	lwz 10,84(31)
	mullw 0,0,30
	lis 29,gi@ha
	lis 3,.LC2@ha
	addi 10,10,740
	la 29,gi@l(29)
	rlwinm 0,0,0,0,29
	la 3,.LC2@l(3)
	lwzx 9,10,0
	addi 9,9,-1
	stwx 9,10,0
	lwz 11,84(31)
	stw 28,1856(11)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC4@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC4@l(9)
	li 4,4
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfs 2,0(9)
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 3,0(9)
	blrl
.L26:
	lis 0,0x4348
	li 3,1
	stw 0,384(31)
.L28:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 KOTSFly,.Lfe2-KOTSFly
	.section	".rodata"
	.align 2
.LC6:
	.string	"blaster"
	.align 3
.LC7:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC8:
	.long 0x3fe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSKnock
	.type	 KOTSKnock,@function
KOTSKnock:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	mr 29,3
	mr 31,5
	mr 30,4
	bl KOTSGetUser__FP7edict_s
	cmpwi 0,31,199
	bc 4,1,.L74
	subfic 0,29,0
	adde 9,0,29
	subfic 8,30,0
	adde 0,8,30
	or. 11,9,0
	bc 4,2,.L74
	cmpwi 0,3,0
	bc 12,2,.L74
	cmpw 0,29,30
	bc 12,2,.L74
	lwz 0,492(29)
	cmpwi 0,0,0
	bc 4,2,.L74
	lwz 26,492(30)
	cmpwi 0,26,0
	bc 4,2,.L74
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,7
	bc 4,1,.L74
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L74
	lwz 4,84(30)
	cmpwi 0,4,0
	bc 12,2,.L74
	xoris 11,31,0x8000
	lwz 0,480(30)
	stw 11,20(1)
	lis 10,0x4330
	lis 8,.LC7@ha
	stw 10,16(1)
	mr 11,9
	xoris 0,0,0x8000
	lfd 13,16(1)
	la 8,.LC7@l(8)
	stw 0,20(1)
	lis 9,.LC8@ha
	stw 10,16(1)
	la 9,.LC8@l(9)
	lfd 12,0(8)
	lfd 0,16(1)
	lfd 11,0(9)
	fsub 13,13,12
	fsub 0,0,12
	fmul 0,0,11
	fcmpu 0,13,0
	bc 12,0,.L74
	lwz 31,1788(4)
	cmpwi 0,31,0
	bc 12,2,.L74
	lis 29,itemlist@ha
	lis 28,0x286b
	la 29,itemlist@l(29)
	ori 28,28,51739
	subf 0,29,31
	lis 3,.LC6@ha
	mullw 0,0,28
	la 3,.LC6@l(3)
	srawi 27,0,2
	bl FindItem
	subf 3,29,3
	mullw 3,3,28
	srawi 3,3,2
	cmpw 0,27,3
	bc 12,2,.L74
	mr 3,30
	bl Cmd_WeapNext_f
	mr 4,31
	mr 3,30
	bl Drop_Item
	lwz 9,84(30)
	slwi 0,27,2
	addi 9,9,740
	stwx 26,9,0
.L74:
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 KOTSKnock,.Lfe3-KOTSKnock
	.section	".rodata"
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl KOTSDamage
	.type	 KOTSDamage,@function
KOTSDamage:
	stwu 1,-64(1)
	mflr 0
	stmw 27,44(1)
	stw 0,68(1)
	mr 30,3
	mr 28,4
	li 27,0
	bl KOTSGetUser__FP7edict_s
	lis 29,0x3f80
	mr. 31,3
	bc 12,2,.L89
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 12,2,.L88
.L89:
	li 3,0
	b .L169
.L88:
	addi 4,28,-1
	cmplwi 0,4,14
	bc 12,1,.L90
	lis 11,.L167@ha
	slwi 10,4,2
	la 11,.L167@l(11)
	lis 9,.L167@ha
	lwzx 0,10,11
	la 9,.L167@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L167:
	.long .L91-.L167
	.long .L97-.L167
	.long .L105-.L167
	.long .L111-.L167
	.long .L119-.L167
	.long .L125-.L167
	.long .L90-.L167
	.long .L131-.L167
	.long .L90-.L167
	.long .L135-.L167
	.long .L143-.L167
	.long .L151-.L167
	.long .L90-.L167
	.long .L90-.L167
	.long .L159-.L167
.L91:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	li 27,80
	cmpwi 0,3,5
	bc 12,1,.L170
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,4
	bc 12,1,.L178
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,2
	b .L172
.L97:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	li 27,4
	cmpwi 0,3,7
	bc 12,1,.L173
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,6
	bc 12,1,.L174
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,4
	bc 12,1,.L170
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,2
	b .L175
.L105:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	li 27,6
	cmpwi 0,3,9
	bc 12,1,.L170
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,8
	bc 12,1,.L178
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,7
	b .L172
.L111:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	li 27,8
	cmpwi 0,3,6
	bc 12,1,.L173
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,5
	bc 12,1,.L174
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,2
	bc 12,1,.L170
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,1
	b .L175
.L119:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	li 27,6
	cmpwi 0,3,10
	bc 12,1,.L170
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,9
	bc 12,1,.L178
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,5
	b .L172
.L125:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	li 27,120
	cmpwi 0,3,12
	bc 12,1,.L170
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,9
	bc 12,1,.L178
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,6
	b .L172
.L131:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	li 27,120
	cmpwi 0,3,12
	bc 12,1,.L170
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,11
.L175:
	bc 4,1,.L90
.L178:
	lis 29,0x4000
	b .L90
.L135:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	li 27,20
	cmpwi 0,3,13
	bc 4,1,.L136
.L173:
	lis 29,0x4060
	b .L90
.L136:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,12
	bc 12,1,.L174
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,10
	bc 12,1,.L178
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,9
	b .L172
.L143:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	li 27,100
	cmpwi 0,3,14
	bc 4,1,.L144
.L174:
	lis 29,0x4040
	b .L90
.L144:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,13
	bc 12,1,.L170
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,12
	bc 12,1,.L178
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,10
.L172:
	bc 4,1,.L90
.L179:
	lis 29,0x3fc0
	b .L90
.L151:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	li 27,35
	cmpwi 0,3,15
	bc 12,1,.L170
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,14
	bc 12,1,.L178
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,12
	bc 12,1,.L179
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,10
	b .L177
.L159:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	li 27,125
	cmpwi 0,3,8
	bc 4,1,.L160
.L170:
	lis 29,0x4020
	b .L90
.L160:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,7
	bc 12,1,.L178
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,5
	bc 12,1,.L179
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,3
.L177:
	bc 4,1,.L90
	lis 29,0x3fa0
.L90:
	xoris 11,27,0x8000
	stw 29,8(1)
	stw 11,36(1)
	lis 0,0x4330
	mr 3,9
	lis 11,.LC9@ha
	stw 0,32(1)
	la 11,.LC9@l(11)
	lfd 0,32(1)
	lfd 13,0(11)
	fsub 0,0,13
	lfs 13,8(1)
	frsp 0,0
	fmuls 0,0,13
	fmr 13,0
	fctiwz 12,13
	stfd 12,32(1)
	lwz 3,36(1)
.L169:
	lwz 0,68(1)
	mtlr 0
	lmw 27,44(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 KOTSDamage,.Lfe4-KOTSDamage
	.align 2
	.globl KOTSSilent
	.type	 KOTSSilent,@function
KOTSSilent:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L186
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L186
	addi 4,30,-1
	cmplwi 0,4,11
	bc 12,1,.L186
	lis 11,.L197@ha
	slwi 10,4,2
	la 11,.L197@l(11)
	lis 9,.L197@ha
	lwzx 0,10,11
	la 9,.L197@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L197:
	.long .L187-.L197
	.long .L188-.L197
	.long .L189-.L197
	.long .L190-.L197
	.long .L193-.L197
	.long .L194-.L197
	.long .L186-.L197
	.long .L193-.L197
	.long .L186-.L197
	.long .L194-.L197
	.long .L195-.L197
	.long .L196-.L197
.L187:
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,1
	mfcr 3
	rlwinm 3,3,30,1
	b .L200
.L188:
.L189:
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,5
	mfcr 3
	rlwinm 3,3,30,1
	b .L200
.L190:
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,3
	mfcr 3
	rlwinm 3,3,30,1
	b .L200
.L193:
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,7
	mfcr 3
	rlwinm 3,3,30,1
	b .L200
.L194:
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,8
	mfcr 3
	rlwinm 3,3,30,1
	b .L200
.L195:
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,9
	mfcr 3
	rlwinm 3,3,30,1
	b .L200
.L196:
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,11
	mfcr 3
	rlwinm 3,3,30,1
	b .L200
.L186:
	li 3,0
.L200:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 KOTSSilent,.Lfe5-KOTSSilent
	.align 2
	.globl KOTSSpecial
	.type	 KOTSSpecial,@function
KOTSSpecial:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	mr 28,4
	mr 30,5
	bl KOTSGetUser__FP7edict_s
	mr. 31,3
	bc 12,2,.L224
	lwz 0,492(29)
	cmpwi 0,0,0
	bc 4,2,.L224
	addi 4,28,-1
	cmplwi 0,4,14
	bc 12,1,.L224
	lis 11,.L266@ha
	slwi 10,4,2
	la 11,.L266@l(11)
	lis 9,.L266@ha
	lwzx 0,10,11
	la 9,.L266@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L266:
	.long .L225-.L266
	.long .L249-.L266
	.long .L252-.L266
	.long .L270-.L266
	.long .L238-.L266
	.long .L263-.L266
	.long .L224-.L266
	.long .L260-.L266
	.long .L224-.L266
	.long .L224-.L266
	.long .L263-.L266
	.long .L229-.L266
	.long .L224-.L266
	.long .L224-.L266
	.long .L232-.L266
.L225:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,3
	li 3,120
	bc 12,1,.L269
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	addi 0,3,-1
	or 0,0,3
	srawi 0,0,31
	nor 9,0,0
	andi. 0,0,80
	andi. 9,9,100
	or 3,0,9
	b .L269
.L229:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,13
	mfcr 3
	rlwinm 3,3,30,1
	b .L269
.L232:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpw 7,3,30
	cror 31,30,29
	mfcr 3
	rlwinm 3,3,0,1
	b .L269
.L238:
	cmpwi 0,30,9
	bc 12,2,.L260
	b .L253
.L249:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,3
	mfcr 3
	rlwinm 3,3,30,1
	b .L269
.L252:
	cmpwi 0,30,5
	bc 4,2,.L253
.L270:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,4
	mfcr 3
	rlwinm 3,3,30,1
	b .L269
.L253:
	cmpwi 0,30,7
	bc 4,2,.L224
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,6
	mfcr 3
	rlwinm 3,3,30,1
	b .L269
.L260:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,8
	mfcr 3
	rlwinm 3,3,30,1
	b .L269
.L263:
	mr 3,31
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,11
	mfcr 3
	rlwinm 3,3,30,1
	b .L269
.L224:
	li 3,0
.L269:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 KOTSSpecial,.Lfe6-KOTSSpecial
	.section	".rodata"
	.align 3
.LC10:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC11:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC12:
	.long 0x3fd00000
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSModDamage
	.type	 KOTSModDamage,@function
KOTSModDamage:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 30,3
	mr 31,4
	mr 29,5
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L274
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 4,2,.L274
	addi 5,29,-7
	cmplwi 0,5,22
	bc 12,1,.L274
	lis 11,.L290@ha
	slwi 10,5,2
	la 11,.L290@l(11)
	lis 9,.L290@ha
	lwzx 0,10,11
	la 9,.L290@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L290:
	.long .L277-.L290
	.long .L274-.L290
	.long .L280-.L290
	.long .L274-.L290
	.long .L274-.L290
	.long .L274-.L290
	.long .L274-.L290
	.long .L274-.L290
	.long .L274-.L290
	.long .L277-.L290
	.long .L282-.L290
	.long .L284-.L290
	.long .L286-.L290
	.long .L274-.L290
	.long .L274-.L290
	.long .L288-.L290
	.long .L274-.L290
	.long .L277-.L290
	.long .L274-.L290
	.long .L274-.L290
	.long .L274-.L290
	.long .L274-.L290
	.long .L280-.L290
.L277:
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,6
	bc 4,1,.L274
	xoris 11,31,0x8000
	stw 11,28(1)
	lis 0,0x4330
	lis 11,.LC10@ha
	stw 0,24(1)
	la 11,.LC10@l(11)
	lfd 0,24(1)
	lfd 11,0(11)
	lis 11,.LC11@ha
	la 11,.LC11@l(11)
	b .L293
.L280:
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,10
	bc 4,1,.L274
	xoris 11,31,0x8000
	stw 11,28(1)
	lis 0,0x4330
	lis 11,.LC10@ha
	stw 0,24(1)
	la 11,.LC10@l(11)
	lfd 0,24(1)
	lfd 11,0(11)
	lis 11,.LC11@ha
	la 11,.LC11@l(11)
	b .L293
.L282:
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,6
	b .L294
.L284:
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,6
	b .L294
.L286:
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,7
	b .L294
.L288:
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,5
.L294:
	bc 4,1,.L274
	xoris 11,31,0x8000
	stw 11,28(1)
	lis 0,0x4330
	lis 11,.LC10@ha
	stw 0,24(1)
	la 11,.LC10@l(11)
	lfd 0,24(1)
	lfd 11,0(11)
	lis 11,.LC12@ha
	la 11,.LC12@l(11)
.L293:
	lfd 12,0(11)
	fsub 0,0,11
	mr 11,9
	fmul 0,0,12
	fctiwz 13,0
	stfd 13,24(1)
	lwz 31,28(1)
.L274:
	mr 3,31
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 KOTSModDamage,.Lfe7-KOTSModDamage
	.section	".rodata"
	.align 2
.LC13:
	.string	"you need 40 power cubes to create a mega health!!!\n"
	.align 2
.LC14:
	.string	"Health"
	.align 2
.LC15:
	.string	"models/items/mega_h/tris.md2"
	.align 2
.LC16:
	.string	"item_health_mega"
	.section	".text"
	.align 2
	.globl KOTSMakeMega
	.type	 KOTSMakeMega,@function
KOTSMakeMega:
	stwu 1,-112(1)
	mflr 0
	stmw 26,88(1)
	stw 0,116(1)
	mr 30,3
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L295
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 4,2,.L295
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,7
	bc 4,1,.L295
	lis 26,.LC1@ha
	lwz 29,84(30)
	lis 31,0x286b
	la 3,.LC1@l(26)
	ori 31,31,51739
	bl FindItem
	lis 9,itemlist@ha
	addi 29,29,740
	la 27,itemlist@l(9)
	subf 3,27,3
	mullw 3,3,31
	rlwinm 3,3,0,0,29
	lwzx 0,29,3
	cmpwi 0,0,24
	bc 12,1,.L299
	lis 9,gi+8@ha
	lis 5,.LC13@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC13@l(5)
	li 4,1
	mtlr 0
	crxor 6,6,6
	blrl
	b .L295
.L299:
	lis 3,.LC14@ha
	la 3,.LC14@l(3)
	bl FindItem
	mr. 28,3
	bc 12,2,.L295
	addi 29,1,8
	mr 4,28
	li 5,76
	mr 3,29
	crxor 6,6,6
	bl memcpy
	lis 9,.LC15@ha
	lis 11,.LC16@ha
	la 11,.LC16@l(11)
	la 9,.LC15@l(9)
	stw 11,8(1)
	mr 4,29
	mr 3,30
	stw 9,32(1)
	bl Drop_Item
	mr. 11,3
	bc 12,2,.L295
	li 9,50
	li 0,1
	stw 28,648(11)
	stw 9,532(11)
	la 3,.LC1@l(26)
	stw 0,644(11)
	bl FindItem
	subf 3,27,3
	lwz 11,84(30)
	mullw 3,3,31
	addi 11,11,740
	rlwinm 3,3,0,0,29
	lwzx 9,11,3
	addi 9,9,-25
	stwx 9,11,3
.L295:
	lwz 0,116(1)
	mtlr 0
	lmw 26,88(1)
	la 1,112(1)
	blr
.Lfe8:
	.size	 KOTSMakeMega,.Lfe8-KOTSMakeMega
	.align 2
	.globl KOTSStopCloak
	.type	 KOTSStopCloak,@function
KOTSStopCloak:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 11,3
	lwz 8,84(11)
	lwz 0,1844(8)
	cmpwi 0,0,0
	bc 12,2,.L2
	lwz 10,492(11)
	cmpwi 0,10,0
	bc 4,2,.L2
	lwz 0,184(11)
	lis 9,gi+8@ha
	lis 5,.LC0@ha
	la 5,.LC0@l(5)
	rlwinm 0,0,0,0,30
	li 4,2
	stw 0,184(11)
	stw 10,1844(8)
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L2:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 KOTSStopCloak,.Lfe9-KOTSStopCloak
	.section	".rodata"
	.align 3
.LC17:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC18:
	.long 0x3fe80000
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSResist
	.type	 KOTSResist,@function
KOTSResist:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 30,3
	mr 31,4
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L32
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 4,2,.L32
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,9
	bc 4,1,.L32
	xoris 11,31,0x8000
	stw 11,20(1)
	lis 0,0x4330
	lis 11,.LC17@ha
	stw 0,16(1)
	la 11,.LC17@l(11)
	lfd 0,16(1)
	lfd 11,0(11)
	lis 11,.LC18@ha
	la 11,.LC18@l(11)
	lfd 12,0(11)
	fsub 0,0,11
	mr 11,9
	fmul 0,0,12
	fctiwz 13,0
	stfd 13,16(1)
	lwz 31,20(1)
.L32:
	mr 3,31
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 KOTSResist,.Lfe10-KOTSResist
	.align 2
	.globl KOTSSilentJump
	.type	 KOTSSilentJump,@function
KOTSSilentJump:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L35
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L34
.L35:
	li 3,0
	b .L303
.L34:
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,4
	mfcr 3
	rlwinm 3,3,30,1
.L303:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 KOTSSilentJump,.Lfe11-KOTSSilentJump
	.align 2
	.globl KOTSSilentWalk
	.type	 KOTSSilentWalk,@function
KOTSSilentWalk:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L38
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L37
.L38:
	li 3,0
	b .L304
.L37:
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,1
	mfcr 3
	rlwinm 3,3,30,1
.L304:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 KOTSSilentWalk,.Lfe12-KOTSSilentWalk
	.align 2
	.globl KOTSSilentPickup
	.type	 KOTSSilentPickup,@function
KOTSSilentPickup:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L41
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L40
.L41:
	li 3,0
	b .L305
.L40:
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,2
	mfcr 3
	rlwinm 3,3,30,1
.L305:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe13:
	.size	 KOTSSilentPickup,.Lfe13-KOTSSilentPickup
	.align 2
	.globl KOTSHighJump
	.type	 KOTSHighJump,@function
KOTSHighJump:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L44
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L43
.L44:
	li 3,0
	b .L306
.L43:
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,4
	mfcr 3
	rlwinm 3,3,30,1
.L306:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 KOTSHighJump,.Lfe14-KOTSHighJump
	.align 2
	.globl KOTSArmorProtection
	.type	 KOTSArmorProtection,@function
KOTSArmorProtection:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 28,4
	bl KOTSGetUser__FP7edict_s
	mr. 30,3
	bc 12,2,.L47
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L46
.L47:
	li 3,0
	b .L307
.L46:
	mr 3,31
	bl ArmorIndex
	mr. 29,3
	li 3,0
	bc 12,2,.L307
	mr 3,30
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,10
	bc 4,1,.L49
	li 10,3
	b .L50
.L49:
	mr 3,30
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,8
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	nor 9,0,0
	rlwinm 0,0,0,31,31
	rlwinm 9,9,0,30,30
	or 10,0,9
.L50:
	lwz 0,0(28)
	slwi 11,29,2
	lwz 9,84(31)
	divw 3,0,10
	addi 9,9,740
	lwzx 11,9,11
	cmpw 0,3,11
	bc 12,0,.L307
	mr 3,11
	mullw 0,3,10
	stw 0,0(28)
.L307:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 KOTSArmorProtection,.Lfe15-KOTSArmorProtection
	.align 2
	.globl KOTSSwitch
	.type	 KOTSSwitch,@function
KOTSSwitch:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L56
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L55
.L56:
	li 3,0
	b .L308
.L55:
	li 4,0
	bl Level__5CUserPl
	srawi 0,3,31
	subf 0,3,0
	srwi 3,0,31
.L308:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe16:
	.size	 KOTSSwitch,.Lfe16-KOTSSwitch
	.section	".rodata"
	.align 3
.LC19:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC20:
	.long 0x3fd00000
	.long 0x0
	.section	".text"
	.align 2
	.globl KOTSVampire
	.type	 KOTSVampire,@function
KOTSVampire:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	mr 30,4
	mr 29,5
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L57
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L57
	lwz 0,480(30)
	cmpwi 0,0,0
	bc 4,1,.L57
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,8
	bc 4,1,.L57
	lwz 0,480(31)
	lwz 7,484(31)
	cmpw 0,0,7
	bc 4,0,.L57
	lwz 11,480(30)
	xoris 0,0,0x8000
	stw 0,28(1)
	lis 8,0x4330
	mr 10,9
	cmpw 7,29,11
	stw 8,24(1)
	lis 6,.LC19@ha
	lfd 13,24(1)
	la 6,.LC19@l(6)
	lfd 11,0(6)
	lis 9,.LC20@ha
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	la 9,.LC20@l(9)
	neg 0,0
	lfd 10,0(9)
	andc 11,11,0
	fsub 13,13,11
	and 0,29,0
	or 0,0,11
	xoris 0,0,0x8000
	stw 0,28(1)
	stw 8,24(1)
	lfd 0,24(1)
	fsub 0,0,11
	fmadd 0,0,10,13
	fctiwz 12,0
	stfd 12,24(1)
	lwz 9,28(1)
	cmpw 0,9,7
	stw 9,480(31)
	bc 4,1,.L57
	stw 7,480(31)
.L57:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 KOTSVampire,.Lfe17-KOTSVampire
	.section	".rodata"
	.align 3
.LC21:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl KOTSRegen
	.type	 KOTSRegen,@function
KOTSRegen:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	bl KOTSGetUser__FP7edict_s
	mr. 30,3
	bc 12,2,.L64
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 4,2,.L64
	mr 3,30
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,8
	bc 4,1,.L67
	li 7,4
	b .L68
.L67:
	mr 3,30
	li 4,0
	bl Level__5CUserPl
	cmpwi 0,3,6
	bc 4,1,.L64
	li 7,2
.L68:
	lwz 8,84(31)
	lis 10,0x4330
	lis 9,.LC21@ha
	lwz 0,1828(8)
	la 9,.LC21@l(9)
	lfd 13,0(9)
	xoris 0,0,0x8000
	lis 9,level+4@ha
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	lfs 12,level+4@l(9)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,1
	bc 12,3,.L64
	fmr 0,12
	mr 9,11
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	stw 9,1828(8)
	lwz 0,480(31)
	lwz 9,484(31)
	cmpw 0,0,9
	bc 4,0,.L64
	add 0,0,7
	cmpw 0,0,9
	stw 0,480(31)
	bc 4,1,.L73
	stw 9,480(31)
.L73:
	lwz 11,84(31)
	lwz 9,1828(11)
	addi 9,9,1
	stw 9,1828(11)
.L64:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 KOTSRegen,.Lfe18-KOTSRegen
	.align 2
	.globl KOTSHaste
	.type	 KOTSHaste,@function
KOTSHaste:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl KOTSGetUser__FP7edict_s
	cmpwi 0,3,0
	bc 12,2,.L182
	lwz 0,492(31)
	cmpwi 0,0,0
.L182:
	li 3,0
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe19:
	.size	 KOTSHaste,.Lfe19-KOTSHaste
	.align 2
	.globl KOTSSpeed
	.type	 KOTSSpeed,@function
KOTSSpeed:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,3
	mr 31,4
	li 29,0
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L203
	lwz 0,492(30)
	cmpwi 0,0,0
	bc 12,2,.L202
.L203:
	li 3,1
	b .L310
.L202:
	cmpwi 0,31,8
	bc 12,2,.L208
	bc 12,1,.L216
	cmpwi 0,31,6
	bc 12,2,.L205
	b .L204
.L216:
	cmpwi 0,31,10
	bc 12,2,.L211
	b .L204
.L205:
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,10
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	nor 9,0,0
	andi. 0,0,600
	andi. 9,9,800
	b .L311
.L208:
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,10
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	nor 9,0,0
	andi. 0,0,650
	andi. 9,9,800
	b .L311
.L211:
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,11
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	nor 9,0,0
	andi. 0,0,1000
	andi. 9,9,1500
.L311:
	or 29,0,9
.L204:
	mr 3,29
.L310:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 KOTSSpeed,.Lfe20-KOTSSpeed
	.align 2
	.globl KOTSModKarma
	.type	 KOTSModKarma,@function
KOTSModKarma:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl KOTSGetUser__FP7edict_s
	mr. 3,3
	bc 12,2,.L219
	lwz 0,492(31)
	cmpwi 0,0,0
	bc 12,2,.L218
.L219:
	li 3,1
	b .L312
.L218:
	li 4,0
	bl Level__5CUserPl
	cmpwi 7,3,9
	mfcr 3
	rlwinm 3,3,30,1
	neg 3,3
	rlwinm 3,3,0,30,31
	ori 3,3,1
.L312:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe21:
	.size	 KOTSModKarma,.Lfe21-KOTSModKarma
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
