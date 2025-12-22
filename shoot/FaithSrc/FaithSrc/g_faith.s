	.file	"g_faith.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"DEMON"
	.align 2
.LC1:
	.string	"DEVIL"
	.align 2
.LC2:
	.string	"HELL FIEND"
	.align 2
.LC3:
	.string	"SUCCUBUS"
	.align 2
.LC4:
	.string	"INCUBUS"
	.align 2
.LC5:
	.string	"LORD OF HELL"
	.align 2
.LC6:
	.string	"ARCHANGEL"
	.align 2
.LC7:
	.string	"VIRTUE"
	.align 2
.LC8:
	.string	"PRINCIPALITY"
	.align 2
.LC9:
	.string	"DOMINION"
	.align 2
.LC10:
	.string	"CHERUBUM"
	.align 2
.LC11:
	.string	"SERAPHIM"
	.align 2
.LC12:
	.string	"You are now a %s"
	.section	".text"
	.align 2
	.globl holylevel
	.type	 holylevel,@function
holylevel:
	stwu 1,-32(1)
	mflr 0
	stw 0,36(1)
	mr 6,3
	lwz 9,84(6)
	lwz 11,3460(9)
	addi 0,11,-1
	cmplwi 0,0,5
	bc 12,1,.L7
	lwz 0,3428(9)
	cmpwi 0,0,1
	bc 4,2,.L8
	cmpwi 0,11,1
	bc 4,2,.L9
	lis 9,.LC0@ha
	la 11,.LC0@l(9)
	lwz 0,.LC0@l(9)
	lhz 10,4(11)
	stw 0,8(1)
	sth 10,12(1)
.L9:
	lwz 9,84(6)
	lwz 0,3460(9)
	cmpwi 0,0,2
	bc 4,2,.L10
	lis 9,.LC1@ha
	la 11,.LC1@l(9)
	lwz 0,.LC1@l(9)
	lhz 10,4(11)
	stw 0,8(1)
	sth 10,12(1)
.L10:
	lwz 9,84(6)
	lwz 0,3460(9)
	cmpwi 0,0,3
	bc 4,2,.L11
	lis 9,.LC2@ha
	addi 11,1,8
	lwz 7,.LC2@l(9)
	la 9,.LC2@l(9)
	lbz 0,10(9)
	lwz 10,4(9)
	lhz 8,8(9)
	stw 7,8(1)
	stb 0,10(11)
	stw 10,4(11)
	sth 8,8(11)
.L11:
	lwz 9,84(6)
	lwz 0,3460(9)
	cmpwi 0,0,4
	bc 4,2,.L12
	lis 9,.LC3@ha
	addi 8,1,8
	lwz 10,.LC3@l(9)
	la 9,.LC3@l(9)
	lbz 0,8(9)
	lwz 11,4(9)
	stw 10,8(1)
	stb 0,8(8)
	stw 11,4(8)
.L12:
	lwz 9,84(6)
	lwz 0,3460(9)
	cmpwi 0,0,5
	bc 4,2,.L13
	lis 9,.LC4@ha
	la 11,.LC4@l(9)
	lwz 0,.LC4@l(9)
	lwz 10,4(11)
	stw 0,8(1)
	stw 10,12(1)
.L13:
	lwz 9,84(6)
	lwz 0,3460(9)
	cmpwi 0,0,6
	bc 4,2,.L8
	lis 9,.LC5@ha
	addi 11,1,8
	lwz 7,.LC5@l(9)
	la 9,.LC5@l(9)
	lbz 0,12(9)
	lwz 10,4(9)
	lwz 8,8(9)
	stw 7,8(1)
	stb 0,12(11)
	stw 10,4(11)
	stw 8,8(11)
.L8:
	lwz 9,84(6)
	lwz 0,3428(9)
	cmpwi 0,0,2
	bc 4,2,.L15
	lwz 0,3460(9)
	cmpwi 0,0,1
	bc 4,2,.L16
	lis 9,.LC6@ha
	addi 8,1,8
	lwz 10,.LC6@l(9)
	la 9,.LC6@l(9)
	lhz 0,8(9)
	lwz 11,4(9)
	stw 10,8(1)
	sth 0,8(8)
	stw 11,4(8)
.L16:
	lwz 9,84(6)
	lwz 0,3460(9)
	cmpwi 0,0,2
	bc 4,2,.L17
	lis 9,.LC7@ha
	addi 8,1,8
	lwz 10,.LC7@l(9)
	la 9,.LC7@l(9)
	lbz 0,6(9)
	lhz 11,4(9)
	stw 10,8(1)
	stb 0,6(8)
	sth 11,4(8)
.L17:
	lwz 9,84(6)
	lwz 0,3460(9)
	cmpwi 0,0,3
	bc 4,2,.L18
	lis 9,.LC8@ha
	addi 11,1,8
	lwz 7,.LC8@l(9)
	la 9,.LC8@l(9)
	lbz 0,12(9)
	lwz 10,4(9)
	lwz 8,8(9)
	stw 7,8(1)
	stb 0,12(11)
	stw 10,4(11)
	stw 8,8(11)
.L18:
	lwz 9,84(6)
	lwz 0,3460(9)
	cmpwi 0,0,4
	bc 4,2,.L19
	lis 9,.LC9@ha
	addi 8,1,8
	lwz 10,.LC9@l(9)
	la 9,.LC9@l(9)
	lbz 0,8(9)
	lwz 11,4(9)
	stw 10,8(1)
	stb 0,8(8)
	stw 11,4(8)
.L19:
	lwz 9,84(6)
	lwz 0,3460(9)
	cmpwi 0,0,5
	bc 4,2,.L20
	lis 9,.LC10@ha
	addi 8,1,8
	lwz 10,.LC10@l(9)
	la 9,.LC10@l(9)
	lbz 0,8(9)
	lwz 11,4(9)
	stw 10,8(1)
	stb 0,8(8)
	stw 11,4(8)
.L20:
	lwz 9,84(6)
	lwz 0,3460(9)
	cmpwi 0,0,6
	bc 4,2,.L15
	lis 9,.LC11@ha
	addi 8,1,8
	lwz 10,.LC11@l(9)
	la 9,.LC11@l(9)
	lbz 0,8(9)
	lwz 11,4(9)
	stw 10,8(1)
	stb 0,8(8)
	stw 11,4(8)
.L15:
	lwz 11,84(6)
	lis 8,gi+12@ha
	lis 4,.LC12@ha
	mr 3,6
	la 4,.LC12@l(4)
	lwz 9,3456(11)
	addi 5,1,8
	addi 9,9,1
	stw 9,3456(11)
	lwz 10,84(6)
	lwz 9,728(10)
	addi 9,9,15
	stw 9,728(10)
	lwz 11,484(6)
	lwz 10,84(6)
	addi 11,11,15
	stw 11,484(6)
	lwz 9,1764(10)
	addi 9,9,30
	stw 9,1764(10)
	lwz 11,84(6)
	lwz 9,1768(11)
	addi 9,9,25
	stw 9,1768(11)
	lwz 10,84(6)
	lwz 9,1772(10)
	addi 9,9,15
	stw 9,1772(10)
	lwz 11,84(6)
	lwz 9,1776(11)
	addi 9,9,15
	stw 9,1776(11)
	lwz 10,84(6)
	lwz 9,1780(10)
	addi 9,9,30
	stw 9,1780(10)
	lwz 11,84(6)
	lwz 9,1784(11)
	addi 9,9,25
	stw 9,1784(11)
	lwz 0,gi+12@l(8)
	mtlr 0
	crxor 6,6,6
	blrl
.L7:
	lwz 0,36(1)
	mtlr 0
	la 1,32(1)
	blr
.Lfe1:
	.size	 holylevel,.Lfe1-holylevel
	.section	".rodata"
	.align 2
.LC13:
	.string	"yell/"
	.align 2
.LC14:
	.string	"Must have a sound\n"
	.align 2
.LC15:
	.string	".wav"
	.align 2
.LC16:
	.string	"models/statue/bluestatue.md2"
	.align 2
.LC17:
	.string	"models/statue/redstatue.md2"
	.align 2
.LC19:
	.string	"models/flame/tris.md2"
	.align 2
.LC22:
	.string	"models/fire/tris.md2"
	.align 2
.LC24:
	.string	"misc_explobox"
	.align 3
.LC25:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC26:
	.long 0x41a00000
	.align 2
.LC27:
	.long 0x3f000000
	.align 2
.LC28:
	.long 0x45000000
	.align 2
.LC29:
	.long 0x43800000
	.section	".text"
	.align 2
	.globl item_angel_statue_think
	.type	 item_angel_statue_think,@function
item_angel_statue_think:
	stwu 1,-208(1)
	mflr 0
	stmw 23,172(1)
	stw 0,212(1)
	mr 30,3
	li 26,0
	b .L36
.L51:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,15
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,4
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,124(29)
	addi 3,1,120
	mtlr 9
	blrl
	lwz 9,100(29)
	lwz 3,60(30)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	b .L44
.L38:
	lwz 0,256(30)
	cmpw 0,26,0
	bc 12,2,.L36
	cmpw 0,26,30
	bc 12,2,.L36
	lwz 0,512(26)
	cmpwi 0,0,0
	bc 12,2,.L36
	lwz 0,184(26)
	andi. 9,0,4
	bc 4,2,.L42
	lwz 0,84(26)
	cmpwi 0,0,0
	bc 4,2,.L42
	lwz 3,280(26)
	lis 4,.LC24@ha
	la 4,.LC24@l(4)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L36
.L42:
	lis 9,.LC26@ha
	lfs 0,12(30)
	lis 11,.LC27@ha
	la 9,.LC26@l(9)
	lfs 11,4(30)
	la 11,.LC27@l(11)
	lfs 13,0(9)
	addi 29,1,32
	addi 5,1,16
	lfs 12,8(30)
	addi 28,1,48
	addi 27,1,64
	lfs 1,0(11)
	addi 4,26,236
	addi 3,26,212
	fadds 0,0,13
	stfs 11,80(1)
	mr 31,30
	stfs 12,84(1)
	stfs 0,88(1)
	bl VectorMA
	lfs 11,80(1)
	mr 3,29
	lfs 12,16(1)
	lfs 13,20(1)
	lfs 10,84(1)
	fsubs 12,12,11
	lfs 0,24(1)
	lfs 11,88(1)
	fsubs 13,13,10
	stfs 12,32(1)
	fsubs 0,0,11
	stfs 13,36(1)
	stfs 0,40(1)
	bl VectorNormalize
	lis 9,.LC28@ha
	lfs 12,80(1)
	mr 3,28
	la 9,.LC28@l(9)
	lfs 13,84(1)
	mr 4,29
	lfs 0,88(1)
	mr 5,27
	lfs 1,0(9)
	stfs 12,48(1)
	stfs 13,52(1)
	stfs 0,56(1)
	bl VectorMA
	mr 23,29
	mr 24,28
	mr 25,27
	addi 28,1,108
	addi 29,1,96
	addi 27,1,80
	b .L45
.L46:
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L47
	lwz 0,264(3)
	andi. 9,0,4
	bc 4,2,.L47
	lwz 5,256(30)
	cmpw 0,3,5
	bc 12,2,.L47
	li 9,12
	li 0,4
	lis 8,vec3_origin@ha
	stw 9,12(1)
	mr 4,30
	stw 0,8(1)
	la 8,vec3_origin@l(8)
	mr 6,23
	mr 7,28
	li 9,3
	li 10,1
	bl T_Damage
.L47:
	lwz 8,148(1)
	lwz 0,184(8)
	mr 9,8
	andi. 11,0,4
	bc 4,2,.L48
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L51
.L48:
	lfs 0,108(1)
	mr 31,8
	lfs 13,112(1)
	lfs 12,116(1)
	stfs 0,48(1)
	stfs 13,52(1)
	stfs 12,56(1)
.L45:
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	mr 3,29
	mr 8,31
	mr 4,24
	li 5,0
	li 6,0
	mr 7,25
	mtlr 0
	ori 9,9,1
	blrl
	lwz 3,148(1)
	cmpwi 0,3,0
	bc 4,2,.L46
.L44:
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,23
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,1
	mtlr 0
	blrl
.L36:
	lis 9,.LC29@ha
	mr 3,26
	la 9,.LC29@l(9)
	addi 4,30,4
	lfs 1,0(9)
	bl findradius
	mr. 26,3
	bc 4,2,.L38
	lis 9,level+4@ha
	lis 11,.LC25@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC25@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
	lwz 0,212(1)
	mtlr 0
	lmw 23,172(1)
	la 1,208(1)
	blr
.Lfe2:
	.size	 item_angel_statue_think,.Lfe2-item_angel_statue_think
	.section	".rodata"
	.align 2
.LC30:
	.string	"models/statue/tris.md2"
	.align 2
.LC33:
	.string	"You don't know this spell level"
	.align 2
.LC34:
	.string	"You do not have the mana to cast a spell"
	.align 2
.LC36:
	.string	"You are blinded by a spell!!!\n"
	.align 2
.LC37:
	.string	"%s is blinded by your spell!\n"
	.align 3
.LC35:
	.long 0x4052c000
	.long 0x0
	.align 2
.LC38:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl Flash_Explode
	.type	 Flash_Explode,@function
Flash_Explode:
	stwu 1,-64(1)
	mflr 0
	stmw 28,48(1)
	stw 0,68(1)
	mr 28,3
	li 31,0
	b .L67
.L69:
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L67
	mr 3,28
	mr 4,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L67
	mr 3,31
	mr 4,28
	bl infront
	cmpwi 0,3,0
	bc 12,2,.L67
	lwz 9,84(28)
	lwz 0,3428(9)
	cmpwi 0,0,1
	bc 4,2,.L73
	lwz 9,84(31)
	b .L76
.L73:
	lwz 9,84(31)
	li 0,0
.L76:
	stw 0,3820(9)
	lwz 11,84(31)
	lis 9,.LC35@ha
	lis 0,0x4248
	lfd 13,.LC35@l(9)
	lis 29,gi@ha
	lis 5,.LC36@ha
	lfs 0,3812(11)
	la 29,gi@l(29)
	la 5,.LC36@l(5)
	mr 3,31
	li 4,2
	fadd 0,0,13
	frsp 0,0
	stfs 0,3812(11)
	lwz 9,84(31)
	stw 0,3816(9)
	lwz 9,8(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 6,84(31)
	lis 5,.LC37@ha
	li 4,2
	lwz 0,8(29)
	la 5,.LC37@l(5)
	addi 6,6,700
	lwz 3,256(28)
	mtlr 0
	crxor 6,6,6
	blrl
.L67:
	lis 9,.LC38@ha
	addi 30,28,4
	la 9,.LC38@l(9)
	mr 3,31
	lfs 1,0(9)
	mr 4,30
	bl findradius
	mr. 31,3
	bc 4,2,.L69
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,21
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,30
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,30
	li 4,2
	mtlr 0
	blrl
	lwz 0,68(1)
	mtlr 0
	lmw 28,48(1)
	la 1,64(1)
	blr
.Lfe3:
	.size	 Flash_Explode,.Lfe3-Flash_Explode
	.section	".rodata"
	.align 2
.LC39:
	.long 0x46fffe00
	.align 3
.LC40:
	.long 0x4062c000
	.long 0x0
	.align 3
.LC41:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC42:
	.long 0x3f800000
	.align 2
.LC43:
	.long 0x0
	.align 3
.LC44:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC45:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC46:
	.long 0x40590000
	.long 0x0
	.section	".text"
	.align 2
	.globl Spell_earthquake_think
	.type	 Spell_earthquake_think,@function
Spell_earthquake_think:
	stwu 1,-80(1)
	mflr 0
	stfd 27,40(1)
	stfd 28,48(1)
	stfd 29,56(1)
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 26,16(1)
	stw 0,84(1)
	lis 9,level@ha
	mr 30,3
	la 31,level@l(9)
	lfs 13,476(30)
	lfs 0,4(31)
	fcmpu 0,13,0
	bc 4,0,.L78
	lis 9,gi+20@ha
	addi 3,30,4
	lwz 6,576(30)
	lwz 0,gi+20@l(9)
	mr 4,30
	li 5,0
	lis 9,.LC42@ha
	la 9,.LC42@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 2,0(9)
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfs 3,0(9)
	blrl
	lfs 0,4(31)
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,476(30)
.L78:
	lis 9,globals@ha
	li 29,1
	la 10,globals@l(9)
	lis 11,g_edicts@ha
	lwz 0,72(10)
	lwz 9,g_edicts@l(11)
	cmpw 0,29,0
	addi 31,9,904
	bc 4,0,.L80
	lis 9,.LC39@ha
	lis 11,.LC40@ha
	lfs 28,.LC39@l(9)
	mr 26,10
	li 27,0
	lis 9,.LC45@ha
	lfd 29,.LC40@l(11)
	lis 28,0x4330
	la 9,.LC45@l(9)
	lfd 31,0(9)
	lis 9,.LC44@ha
	la 9,.LC44@l(9)
	lfd 30,0(9)
	lis 9,.LC46@ha
	la 9,.LC46@l(9)
	lfd 27,0(9)
.L82:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L81
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L81
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L81
	stw 27,552(31)
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,376(31)
	xoris 3,3,0x8000
	stw 3,12(1)
	stw 28,8(1)
	lfd 13,8(1)
	fsub 13,13,31
	frsp 13,13
	fdivs 13,13,28
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,29,12
	frsp 0,0
	stfs 0,376(31)
	bl rand
	rlwinm 3,3,0,17,31
	lwz 0,400(31)
	xoris 3,3,0x8000
	mr 11,9
	lfs 11,380(31)
	stw 3,12(1)
	xoris 0,0,0x8000
	stw 28,8(1)
	lfd 13,8(1)
	stw 0,12(1)
	stw 28,8(1)
	fsub 13,13,31
	lfd 12,8(1)
	frsp 13,13
	fsub 12,12,31
	fdivs 13,13,28
	fdiv 12,27,12
	fmr 0,13
	fsub 0,0,30
	fadd 0,0,0
	fmadd 0,0,29,11
	frsp 0,0
	stfs 0,380(31)
	lfs 13,328(30)
	fmul 13,13,12
	frsp 13,13
	stfs 13,384(31)
.L81:
	lwz 0,72(26)
	addi 29,29,1
	addi 31,31,904
	cmpw 0,29,0
	bc 12,0,.L82
.L80:
	lis 9,level+4@ha
	lfs 0,288(30)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L87
	fmr 0,13
	lis 9,.LC41@ha
	lfd 13,.LC41@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
	b .L88
.L87:
	mr 3,30
	bl G_FreeEdict
.L88:
	lwz 0,84(1)
	mtlr 0
	lmw 26,16(1)
	lfd 27,40(1)
	lfd 28,48(1)
	lfd 29,56(1)
	lfd 30,64(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe4:
	.size	 Spell_earthquake_think,.Lfe4-Spell_earthquake_think
	.section	".rodata"
	.align 2
.LC48:
	.string	"world/quake.wav"
	.align 3
.LC49:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC50:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl SpellFour
	.type	 SpellFour,@function
SpellFour:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	bl PMenu_Close
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,2
	bc 12,1,.L91
	lis 9,gi+12@ha
	lis 4,.LC33@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC33@l(4)
	b .L96
.L91:
	lwz 0,3464(9)
	cmpwi 0,0,1
	bc 12,2,.L92
	lis 9,gi+12@ha
	lis 4,.LC34@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC34@l(4)
.L96:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L90
.L92:
	lwz 0,3428(9)
	cmpwi 0,0,1
	bc 4,2,.L93
	li 0,0
	stw 0,3464(9)
	bl G_Spawn
	mr 29,3
	li 9,5
	lwz 0,184(29)
	lis 10,Spell_earthquake_think@ha
	lis 8,0x4416
	stw 9,532(29)
	la 10,Spell_earthquake_think@l(10)
	lis 11,level@ha
	ori 0,0,1
	lis 9,.LC50@ha
	stw 10,436(29)
	stw 0,184(29)
	la 11,level@l(11)
	la 9,.LC50@l(9)
	stw 8,328(29)
	li 0,0
	lis 10,gi+36@ha
	lfs 13,4(11)
	lis 3,.LC48@ha
	lfs 0,0(9)
	la 3,.LC48@l(3)
	lis 9,.LC49@ha
	fadds 13,13,0
	stfs 13,288(29)
	lfs 0,4(11)
	lfd 13,.LC49@l(9)
	stw 0,476(29)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,gi+36@l(10)
	mtlr 0
	blrl
	stw 3,576(29)
.L93:
	lwz 9,84(31)
	lwz 0,3428(9)
	cmpwi 0,0,2
	bc 4,2,.L90
	li 0,0
	mr 3,31
	stw 0,3464(9)
	li 4,0
	bl SP_Decoy
.L90:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 SpellFour,.Lfe5-SpellFour
	.section	".rodata"
	.align 2
.LC52:
	.string	"info_divine"
	.align 2
.LC53:
	.string	"models/objects/gibs/head/tris.md2"
	.align 2
.LC54:
	.string	"az/hum1.wav"
	.align 3
.LC55:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC56:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl Divine
	.type	 Divine,@function
Divine:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	lwz 3,900(31)
	cmpwi 0,3,0
	bc 12,2,.L114
	bl G_FreeEdict
	li 0,0
	stw 0,900(31)
.L114:
	lis 9,.LC56@ha
	lfs 0,12(31)
	la 9,.LC56@l(9)
	lfs 11,4(31)
	lfs 13,0(9)
	lfs 12,8(31)
	stfs 11,8(1)
	fadds 0,0,13
	stfs 12,12(1)
	stfs 0,16(1)
	bl G_Spawn
	mr 29,3
	lis 9,.LC52@ha
	stw 31,256(29)
	la 10,.LC52@l(9)
	lis 28,gi@ha
	stw 29,900(31)
	la 28,gi@l(28)
	lis 3,.LC53@ha
	lwz 8,.LC52@l(9)
	la 3,.LC53@l(3)
	lwz 0,8(10)
	lwz 11,4(10)
	lwz 9,280(29)
	stw 0,8(9)
	stw 11,4(9)
	stw 8,0(9)
	lfs 0,8(1)
	stfs 0,4(29)
	lfs 13,12(1)
	stfs 13,8(29)
	lfs 0,16(1)
	stfs 0,12(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	lwz 9,36(28)
	lis 3,.LC54@ha
	la 3,.LC54@l(3)
	mtlr 9
	blrl
	lis 0,0x8
	lis 11,divine_think@ha
	stw 3,76(29)
	lis 9,0xc2b4
	ori 0,0,32768
	la 11,divine_think@l(11)
	stw 9,24(29)
	lis 10,level+4@ha
	stw 0,64(29)
	lis 9,.LC55@ha
	mr 3,29
	stw 11,436(29)
	lfs 0,level+4@l(10)
	lfd 13,.LC55@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 Divine,.Lfe6-Divine
	.globl RedMenu
	.section	".data"
	.align 2
	.type	 RedMenu,@object
RedMenu:
	.long .LC57
	.long 1
	.long 0
	.long 0
	.long .LC58
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC59
	.long 0
	.long 0
	.long SpellOne
	.long .LC60
	.long 0
	.long 0
	.long SpellTwo
	.long .LC61
	.long 0
	.long 0
	.long SpellThree
	.long .LC62
	.long 0
	.long 0
	.long SpellFour
	.long .LC63
	.long 0
	.long 0
	.long SpellFive
	.long .LC64
	.long 0
	.long 0
	.long SpellSix
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC65
	.long 0
	.long 0
	.long 0
	.long .LC66
	.long 0
	.long 0
	.long 0
	.long .LC67
	.long 0
	.long 0
	.long 0
	.long .LC68
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC69
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC69:
	.string	"v1.02"
	.align 2
.LC68:
	.string	"(TAB to Return)"
	.align 2
.LC67:
	.string	"ESC to Exit Menu"
	.align 2
.LC66:
	.string	"ENTER to select"
	.align 2
.LC65:
	.string	"Use [ and ] to move cursor"
	.align 2
.LC64:
	.string	"Cast Summon Hellspawn"
	.align 2
.LC63:
	.string	"Cast Unclean Spirit"
	.align 2
.LC62:
	.string	"Cast Earthquake"
	.align 2
.LC61:
	.string	"Cast Shockwave"
	.align 2
.LC60:
	.string	"Cast Unholy Darkness"
	.align 2
.LC59:
	.string	"Cast Dark Energy"
	.align 2
.LC58:
	.string	"*Faith Capture the Flag"
	.align 2
.LC57:
	.string	"*Quake II"
	.size	 RedMenu,256
	.globl BlueMenu
	.section	".data"
	.align 2
	.type	 BlueMenu,@object
BlueMenu:
	.long .LC57
	.long 1
	.long 0
	.long 0
	.long .LC58
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC70
	.long 0
	.long 0
	.long SpellOne
	.long .LC71
	.long 0
	.long 0
	.long SpellTwo
	.long .LC72
	.long 0
	.long 0
	.long SpellThree
	.long .LC73
	.long 0
	.long 0
	.long SpellFour
	.long .LC74
	.long 0
	.long 0
	.long SpellFive
	.long .LC75
	.long 0
	.long 0
	.long SpellSix
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC65
	.long 0
	.long 0
	.long 0
	.long .LC66
	.long 0
	.long 0
	.long 0
	.long .LC67
	.long 0
	.long 0
	.long 0
	.long .LC68
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC69
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC75:
	.string	"Cast Divine Summoning"
	.align 2
.LC74:
	.string	"Cast Flag Seek"
	.align 2
.LC73:
	.string	"Cast Illusion"
	.align 2
.LC72:
	.string	"Cast Chaos Seek"
	.align 2
.LC71:
	.string	"Cast Light of Faith"
	.align 2
.LC70:
	.string	"Cast Prayer Heal"
	.size	 BlueMenu,256
	.section	".data"
	.align 2
	.type	 pause_frames.81,@object
pause_frames.81:
	.long 10
	.long 18
	.long 27
	.long 0
	.align 2
	.type	 fire_frames.82,@object
fire_frames.82:
	.long 6
	.long 0
	.section	".rodata"
	.align 2
.LC79:
	.string	"az/redspel.wav"
	.align 2
.LC80:
	.string	"az/bluspel.wav"
	.align 2
.LC76:
	.long 0x46fffe00
	.align 3
.LC77:
	.long 0x3fd66666
	.long 0x66666666
	.align 3
.LC78:
	.long 0x3fe66666
	.long 0x66666666
	.align 2
.LC81:
	.long 0x3f800000
	.align 3
.LC82:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC83:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC84:
	.long 0x0
	.align 2
.LC85:
	.long 0x42700000
	.section	".text"
	.align 2
	.globl Weapon_HolyFire_Fire
	.type	 Weapon_HolyFire_Fire,@function
Weapon_HolyFire_Fire:
	stwu 1,-176(1)
	mflr 0
	stfd 27,136(1)
	stfd 28,144(1)
	stfd 29,152(1)
	stfd 30,160(1)
	stfd 31,168(1)
	stmw 22,96(1)
	stw 0,180(1)
	mr 31,3
	lwz 7,84(31)
	lwz 0,3548(7)
	andi. 9,0,1
	bc 4,2,.L126
	lwz 9,92(7)
	addi 9,9,1
	stw 9,92(7)
	b .L125
.L126:
	lis 9,level+4@ha
	lfs 0,3824(7)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L125
	lis 11,.LC81@ha
	lis 9,is_quad@ha
	la 11,.LC81@l(11)
	lis 10,.LC77@ha
	lfs 0,0(11)
	lis 8,.LC78@ha
	addi 25,1,56
	lwz 11,is_quad@l(9)
	addi 27,1,24
	addi 26,1,40
	lis 9,.LC76@ha
	lfd 27,.LC77@l(10)
	addi 24,31,4
	addic 11,11,-1
	subfe 11,11,11
	lfs 29,.LC76@l(9)
	fadds 0,13,0
	addi 23,1,72
	nor 0,11,11
	lis 9,.LC82@ha
	lfd 28,.LC78@l(8)
	rlwinm 11,11,0,28,31
	rlwinm 0,0,0,26,29
	or 22,11,0
	la 9,.LC82@l(9)
	stfs 0,3824(7)
	lis 11,.LC83@ha
	lfd 30,0(9)
	lis 28,0x4330
	la 11,.LC83@l(11)
	li 29,4
	lfd 31,0(11)
	li 30,2
.L133:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 11,84(31)
	xoris 3,3,0x8000
	stw 3,92(1)
	addi 11,11,3616
	stw 28,88(1)
	lfd 13,88(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmul 0,0,27
	frsp 0,0
	stfsx 0,11,29
	bl rand
	rlwinm 3,3,0,17,31
	lwz 11,84(31)
	xoris 3,3,0x8000
	addic. 30,30,-1
	stw 3,92(1)
	addi 11,11,3604
	stw 28,88(1)
	lfd 13,88(1)
	fsub 13,13,30
	frsp 13,13
	fdivs 13,13,29
	fmr 0,13
	fsub 0,0,31
	fadd 0,0,0
	fmul 0,0,28
	frsp 0,0
	stfsx 0,11,29
	addi 29,29,4
	bc 4,2,.L133
	lwz 9,84(31)
	mr 3,25
	mr 4,27
	mr 5,26
	li 6,0
	lfs 13,3604(9)
	lfs 0,3668(9)
	fadds 0,0,13
	stfs 0,56(1)
	lfs 0,3608(9)
	lfs 13,3672(9)
	fadds 13,13,0
	stfs 13,60(1)
	lfs 12,3612(9)
	lfs 0,3676(9)
	fadds 0,0,12
	stfs 0,64(1)
	bl AngleVectors
	lwz 9,508(31)
	lis 8,0x4330
	lis 11,.LC82@ha
	lwz 3,84(31)
	lis 0,0x4100
	addi 9,9,-8
	la 11,.LC82@l(11)
	stw 0,76(1)
	xoris 9,9,0x8000
	lfd 13,0(11)
	mr 4,24
	stw 9,92(1)
	li 11,0
	mr 5,23
	stw 8,88(1)
	mr 7,26
	mr 6,27
	lfd 0,88(1)
	addi 8,1,8
	stw 11,72(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,80(1)
	bl P_ProjectSource
	lwz 9,84(31)
	lwz 0,3428(9)
	cmpwi 0,0,1
	bc 4,2,.L135
	lis 29,gi@ha
	lis 3,.LC79@ha
	la 29,gi@l(29)
	la 3,.LC79@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC81@ha
	lwz 0,16(29)
	lis 11,.LC81@ha
	la 9,.LC81@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC81@l(11)
	li 4,1
	mtlr 0
	lis 9,.LC84@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC84@l(9)
	lfs 3,0(9)
	blrl
	b .L136
.L135:
	lis 29,gi@ha
	lis 3,.LC80@ha
	la 29,gi@l(29)
	la 3,.LC80@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC81@ha
	lwz 0,16(29)
	lis 11,.LC81@ha
	la 9,.LC81@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC81@l(11)
	li 4,1
	mtlr 0
	lis 9,.LC84@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC84@l(9)
	lfs 3,0(9)
	blrl
.L136:
	lis 9,.LC85@ha
	mr 3,31
	la 9,.LC85@l(9)
	mr 5,27
	lfs 1,0(9)
	mr 6,22
	addi 4,1,8
	li 7,550
	li 8,60
	bl fire_holyfire
.L125:
	lwz 0,180(1)
	mtlr 0
	lmw 22,96(1)
	lfd 27,136(1)
	lfd 28,144(1)
	lfd 29,152(1)
	lfd 30,160(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe7:
	.size	 Weapon_HolyFire_Fire,.Lfe7-Weapon_HolyFire_Fire
	.section	".rodata"
	.align 2
.LC87:
	.string	"models/weapons/holyfire/tris.md2"
	.align 2
.LC88:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC89:
	.string	"weapons/rockfly.wav"
	.align 2
.LC90:
	.string	"holy_fire"
	.align 2
.LC91:
	.string	"body"
	.align 2
.LC92:
	.long 0x47800000
	.align 2
.LC93:
	.long 0x43b40000
	.align 2
.LC94:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl SendtoFlag
	.type	 SendtoFlag,@function
SendtoFlag:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	mr 31,4
	mr 30,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L154
	mr 3,31
	addi 29,31,376
	bl CTFPlayerResetGrapple
	lis 9,gi+76@ha
	mr 3,31
	lwz 0,gi+76@l(9)
	mtlr 0
	blrl
	lfs 0,4(30)
	lis 9,.LC92@ha
	li 0,0
	la 9,.LC92@l(9)
	lwz 10,84(31)
	li 11,20
	lfs 10,0(9)
	li 8,6
	addi 5,30,16
	stfs 0,4(31)
	lis 9,.LC93@ha
	li 6,0
	lfs 13,8(30)
	la 9,.LC93@l(9)
	li 7,0
	lfs 11,0(9)
	li 9,3
	stfs 13,8(31)
	mtctr 9
	lfs 0,12(30)
	stfs 0,12(31)
	lfs 13,4(30)
	stfs 13,28(31)
	lfs 0,8(30)
	stfs 0,32(31)
	lfs 13,12(30)
	stw 0,376(31)
	stw 0,384(31)
	stfs 13,36(31)
	stw 0,380(31)
	stb 11,17(10)
	lwz 9,84(31)
	lbz 0,16(9)
	ori 0,0,32
	stb 0,16(9)
	stw 8,80(31)
.L162:
	lwz 10,84(31)
	add 0,6,6
	lfsx 0,7,5
	addi 6,6,1
	addi 9,10,3472
	lfsx 13,9,7
	addi 10,10,20
	addi 7,7,4
	fsubs 0,0,13
	fmuls 0,0,10
	fdivs 0,0,11
	fctiwz 12,0
	stfd 12,40(1)
	lwz 11,44(1)
	sthx 11,10,0
	bdnz .L162
	li 0,0
	lwz 11,84(31)
	addi 4,1,8
	stw 0,16(31)
	li 5,0
	li 6,0
	lfs 13,20(30)
	stw 0,24(31)
	stfs 13,20(31)
	lfs 0,16(30)
	stfs 0,28(11)
	lfs 0,20(30)
	lwz 9,84(31)
	stfs 0,32(9)
	lfs 0,24(30)
	lwz 11,84(31)
	stfs 0,36(11)
	lfs 0,16(30)
	lwz 9,84(31)
	stfs 0,3668(9)
	lfs 0,20(30)
	lwz 11,84(31)
	stfs 0,3672(11)
	lfs 13,24(30)
	lwz 9,84(31)
	stfs 13,3676(9)
	lwz 3,84(31)
	addi 3,3,3668
	bl AngleVectors
	lis 9,.LC94@ha
	addi 3,1,8
	la 9,.LC94@l(9)
	mr 4,29
	lfs 1,0(9)
	bl VectorScale
	mr 3,31
	bl KillBox
	lis 9,gi+72@ha
	mr 3,31
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L154:
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe8:
	.size	 SendtoFlag,.Lfe8-SendtoFlag
	.globl FlagMenu
	.section	".data"
	.align 2
	.type	 FlagMenu,@object
FlagMenu:
	.long .LC57
	.long 1
	.long 0
	.long 0
	.long .LC58
	.long 1
	.long 0
	.long 0
	.long 0
	.long 1
	.long 0
	.long 0
	.long .LC95
	.long 0
	.long 0
	.long FindRedFlag
	.long .LC96
	.long 0
	.long 0
	.long FindBlueFlag
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC65
	.long 0
	.long 0
	.long 0
	.long .LC66
	.long 0
	.long 0
	.long 0
	.long .LC67
	.long 0
	.long 0
	.long 0
	.long .LC68
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long 0
	.long .LC69
	.long 2
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC96:
	.string	"Find Blue Flag"
	.align 2
.LC95:
	.string	"Find Red Flag"
	.size	 FlagMenu,192
	.align 2
.LC97:
	.string	"item_flag_team1"
	.align 2
.LC98:
	.string	"item_flag_team2"
	.align 2
.LC99:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl SpellFive
	.type	 SpellFive,@function
SpellFive:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,3
	bl PMenu_Close
	lwz 9,84(30)
	lwz 0,3456(9)
	cmpwi 0,0,4
	bc 12,1,.L179
	lis 9,gi+12@ha
	lis 4,.LC33@ha
	lwz 0,gi+12@l(9)
	mr 3,30
	la 4,.LC33@l(4)
	b .L190
.L179:
	lwz 0,3464(9)
	cmpwi 0,0,1
	bc 12,2,.L180
	lis 9,gi+12@ha
	lis 4,.LC34@ha
	lwz 0,gi+12@l(9)
	mr 3,30
	la 4,.LC34@l(4)
.L190:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L178
.L180:
	lwz 0,3428(9)
	cmpwi 0,0,1
	bc 4,2,.L181
	li 0,0
	li 31,0
	stw 0,3464(9)
	addi 29,30,4
	b .L182
.L184:
	lwz 3,280(31)
	lis 4,.LC91@ha
	la 4,.LC91@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L182
	mr 3,30
	li 4,1
	bl SP_Decoy
	mr 3,31
	bl G_FreeEdict
.L182:
	lis 9,.LC99@ha
	mr 3,31
	la 9,.LC99@l(9)
	mr 4,29
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	bc 4,2,.L184
.L181:
	lwz 9,84(30)
	lwz 0,3428(9)
	cmpwi 0,0,2
	bc 4,2,.L178
	li 0,0
	lis 4,FlagMenu@ha
	stw 0,3464(9)
	mr 3,30
	la 4,FlagMenu@l(4)
	li 5,0
	li 6,12
	bl PMenu_Open
.L178:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 SpellFive,.Lfe9-SpellFive
	.section	".rodata"
	.align 2
.LC100:
	.long 0x46fffe00
	.align 3
.LC101:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC102:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC103:
	.long 0x3fe80000
	.long 0x0
	.section	".text"
	.align 2
	.globl FindRandomFlag
	.type	 FindRandomFlag,@function
FindRandomFlag:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	mr 29,3
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,28(1)
	lis 10,.LC101@ha
	lis 11,.LC100@ha
	la 10,.LC101@l(10)
	stw 0,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	lis 10,.LC102@ha
	lfs 12,.LC100@l(11)
	la 10,.LC102@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 31,0,12
	fmr 13,31
	fcmpu 0,13,11
	bc 4,0,.L192
	mr 3,29
	li 30,1
	bl PMenu_Close
	lis 9,globals@ha
	lis 11,g_edicts@ha
	la 9,globals@l(9)
	lwz 10,g_edicts@l(11)
	lwz 0,72(9)
	addi 31,10,904
	cmpw 0,30,0
	bc 4,0,.L192
	mr 27,9
	lis 28,.LC98@ha
.L195:
	lwz 3,280(31)
	la 4,.LC98@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L197
	mr 3,31
	mr 4,29
	bl SendtoFlag
.L197:
	lwz 0,72(27)
	addi 30,30,1
	addi 31,31,904
	cmpw 0,30,0
	bc 12,0,.L195
.L192:
	lis 9,.LC103@ha
	fmr 13,31
	la 9,.LC103@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,1,.L200
	mr 3,29
	li 30,1
	bl PMenu_Close
	lis 9,globals@ha
	lis 11,g_edicts@ha
	la 9,globals@l(9)
	lwz 10,g_edicts@l(11)
	lwz 0,72(9)
	addi 31,10,904
	cmpw 0,30,0
	bc 4,0,.L200
	mr 27,9
	lis 28,.LC97@ha
.L203:
	lwz 3,280(31)
	la 4,.LC97@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L205
	mr 3,31
	mr 4,29
	bl SendtoFlag
.L205:
	lwz 0,72(27)
	addi 30,30,1
	addi 31,31,904
	cmpw 0,30,0
	bc 12,0,.L203
.L200:
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe10:
	.size	 FindRandomFlag,.Lfe10-FindRandomFlag
	.section	".rodata"
	.align 2
.LC104:
	.long 0x46fffe00
	.align 3
.LC105:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC106:
	.long 0x42c80000
	.align 2
.LC107:
	.long 0x43960000
	.section	".text"
	.align 2
	.globl ShockwaveExplode
	.type	 ShockwaveExplode,@function
ShockwaveExplode:
	stwu 1,-128(1)
	mflr 0
	stfd 27,88(1)
	stfd 28,96(1)
	stfd 29,104(1)
	stfd 30,112(1)
	stfd 31,120(1)
	stmw 26,64(1)
	stw 0,132(1)
	lis 9,.LC104@ha
	mr 30,3
	lfs 27,.LC104@l(9)
	lis 11,gi@ha
	addi 26,30,4
	lis 9,.LC105@ha
	la 29,gi@l(11)
	la 9,.LC105@l(9)
	li 31,0
	lfd 29,0(9)
	addi 27,1,32
	lis 28,0x4330
	lis 9,.LC106@ha
	la 9,.LC106@l(9)
	lfs 28,0(9)
.L217:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,60(1)
	stw 28,56(1)
	lfd 0,56(1)
	fsub 0,0,29
	frsp 0,0
	fdivs 30,0,27
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,60(1)
	stw 28,56(1)
	lfd 0,56(1)
	fsub 0,0,29
	fmuls 30,30,28
	frsp 0,0
	fdivs 31,0,27
	bl rand
	rlwinm 0,3,0,17,31
	xoris 0,0,0x8000
	li 3,3
	stw 0,60(1)
	stw 28,56(1)
	andi. 0,31,1
	lfd 0,56(1)
	addi 31,31,1
	fsub 0,0,29
	fmuls 31,31,28
	frsp 0,0
	fdivs 11,0,27
	fmuls 11,11,28
	bc 4,2,.L218
	fneg 30,30
	fneg 31,31
	fneg 11,11
.L218:
	lfs 0,4(30)
	lfs 12,8(30)
	lfs 13,12(30)
	fadds 30,30,0
	lwz 9,100(29)
	fadds 31,31,12
	fadds 11,11,13
	mtlr 9
	stfs 30,32(1)
	stfs 31,36(1)
	stfs 11,40(1)
	blrl
	lwz 9,100(29)
	li 3,7
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,88(29)
	addi 3,30,4
	li 4,1
	mtlr 9
	blrl
	cmpwi 0,31,5
	bc 4,1,.L217
	li 31,0
	li 27,4
	li 28,0
	lis 29,vec3_origin@ha
	b .L220
.L222:
	lwz 0,512(31)
	li 10,1
	cmpwi 0,0,0
	bc 12,2,.L220
	lfs 0,4(31)
	lfs 13,4(30)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,16(1)
	lfs 0,8(31)
	fsubs 12,12,0
	stfs 12,20(1)
	lfs 0,12(31)
	stw 27,8(1)
	stw 28,12(1)
	fsubs 11,11,0
	stfs 11,24(1)
	bl T_Damage
.L220:
	lis 9,.LC107@ha
	mr 3,31
	la 9,.LC107@l(9)
	mr 4,26
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	mr 4,30
	mr 5,30
	addi 6,1,16
	la 8,vec3_origin@l(29)
	li 9,40
	mr 3,31
	addi 7,31,4
	bc 4,2,.L222
	lwz 0,132(1)
	mtlr 0
	lmw 26,64(1)
	lfd 27,88(1)
	lfd 28,96(1)
	lfd 29,104(1)
	lfd 30,112(1)
	lfd 31,120(1)
	la 1,128(1)
	blr
.Lfe11:
	.size	 ShockwaveExplode,.Lfe11-ShockwaveExplode
	.section	".sbss","aw",@nobits
	.align 2
is_quad:
	.space	4
	.size	 is_quad,4
	.section	".rodata"
	.align 2
.LC110:
	.long 0x3f800000
	.align 2
.LC111:
	.long 0x0
	.section	".text"
	.align 2
	.globl Yell
	.type	 Yell,@function
Yell:
	stwu 1,-64(1)
	mflr 0
	stmw 29,52(1)
	stw 0,68(1)
	lis 9,gi@ha
	addi 31,1,8
	la 30,gi@l(9)
	mr 29,3
	lwz 9,164(30)
	mtlr 9
	blrl
	lis 9,.LC13@ha
	lwz 0,.LC13@l(9)
	la 9,.LC13@l(9)
	lhz 11,4(9)
	stw 0,8(1)
	sth 11,4(31)
	lbz 0,0(3)
	cmpwi 0,0,0
	bc 4,2,.L23
	lwz 0,8(30)
	lis 5,.LC14@ha
	mr 3,29
	la 5,.LC14@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L24
.L23:
	mr 4,3
	mr 3,31
	bl strcat
	lis 4,.LC15@ha
	mr 3,31
	la 4,.LC15@l(4)
	bl strcat
	lwz 9,36(30)
	mr 3,31
	mtlr 9
	blrl
	lis 9,.LC110@ha
	lwz 0,16(30)
	mr 5,3
	la 9,.LC110@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,29
	mtlr 0
	lis 9,.LC110@ha
	la 9,.LC110@l(9)
	lfs 2,0(9)
	lis 9,.LC111@ha
	la 9,.LC111@l(9)
	lfs 3,0(9)
	blrl
.L24:
	lwz 0,68(1)
	mtlr 0
	lmw 29,52(1)
	la 1,64(1)
	blr
.Lfe12:
	.size	 Yell,.Lfe12-Yell
	.align 2
	.globl SP_item_blue_statue
	.type	 SP_item_blue_statue,@function
SP_item_blue_statue:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 28,gi@ha
	mr 29,3
	la 28,gi@l(28)
	lis 4,.LC16@ha
	lwz 9,44(28)
	la 4,.LC16@l(4)
	mtlr 9
	blrl
	li 8,0
	lis 7,0xc180
	lis 6,0x4180
	li 0,2
	stw 8,56(29)
	lis 9,0x8
	li 11,0
	stw 0,248(29)
	lis 10,0x4220
	stw 9,64(29)
	mr 3,29
	stw 7,192(29)
	stw 11,196(29)
	stw 6,204(29)
	stw 10,208(29)
	stw 8,60(29)
	stw 7,188(29)
	stw 6,200(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 SP_item_blue_statue,.Lfe13-SP_item_blue_statue
	.align 2
	.globl SP_item_red_statue
	.type	 SP_item_red_statue,@function
SP_item_red_statue:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 28,gi@ha
	mr 29,3
	la 28,gi@l(28)
	lis 4,.LC17@ha
	lwz 9,44(28)
	la 4,.LC17@l(4)
	mtlr 9
	blrl
	li 8,0
	lis 7,0xc180
	lis 6,0x4180
	li 0,2
	stw 8,56(29)
	lis 9,0x4
	li 11,0
	stw 0,248(29)
	lis 10,0x4220
	stw 9,64(29)
	mr 3,29
	stw 7,192(29)
	stw 11,196(29)
	stw 6,204(29)
	stw 10,208(29)
	stw 8,60(29)
	stw 7,188(29)
	stw 6,200(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 SP_item_red_statue,.Lfe14-SP_item_red_statue
	.section	".rodata"
	.align 3
.LC112:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_torch_think
	.type	 misc_torch_think,@function
misc_torch_think:
	lwz 9,56(3)
	addi 9,9,1
	cmpwi 0,9,5
	stw 9,56(3)
	bc 12,1,.L28
	lis 9,level+4@ha
	lis 11,.LC112@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC112@l(11)
.L229:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.L28:
	li 0,0
	lis 11,level+4@ha
	stw 0,56(3)
	lis 9,.LC112@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC112@l(9)
	b .L229
.Lfe15:
	.size	 misc_torch_think,.Lfe15-misc_torch_think
	.section	".rodata"
	.align 3
.LC113:
	.long 0x3fc99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_torch
	.type	 SP_misc_torch,@function
SP_misc_torch:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 0,0
	stw 0,260(29)
	lis 8,0xc080
	lis 7,0x4080
	li 11,8
	li 10,0
	stw 8,192(29)
	lis 0,0x41d0
	li 9,2
	stw 11,68(29)
	lis 28,gi@ha
	stw 10,196(29)
	lis 3,.LC19@ha
	la 28,gi@l(28)
	stw 0,208(29)
	la 3,.LC19@l(3)
	stw 9,248(29)
	stw 7,204(29)
	stw 8,188(29)
	stw 7,200(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 9,misc_torch_think@ha
	stw 3,40(29)
	lis 10,level+4@ha
	la 9,misc_torch_think@l(9)
	lis 11,.LC113@ha
	stw 9,436(29)
	mr 3,29
	lfs 0,level+4@l(10)
	lfd 13,.LC113@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe16:
	.size	 SP_misc_torch,.Lfe16-SP_misc_torch
	.section	".rodata"
	.align 3
.LC114:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl misc_fire_think
	.type	 misc_fire_think,@function
misc_fire_think:
	lwz 9,56(3)
	addi 9,9,1
	cmpwi 0,9,10
	stw 9,56(3)
	bc 12,1,.L32
	lis 9,level+4@ha
	lis 11,.LC114@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC114@l(11)
.L230:
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
	blr
.L32:
	li 0,0
	lis 11,level+4@ha
	stw 0,56(3)
	lis 9,.LC114@ha
	lfs 0,level+4@l(11)
	lfd 13,.LC114@l(9)
	b .L230
.Lfe17:
	.size	 misc_fire_think,.Lfe17-misc_fire_think
	.section	".rodata"
	.align 3
.LC115:
	.long 0x3fc99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_misc_fire
	.type	 SP_misc_fire,@function
SP_misc_fire:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 29,3
	li 0,0
	stw 0,260(29)
	lis 8,0xc080
	lis 7,0x4080
	li 11,8
	li 10,0
	stw 8,192(29)
	lis 0,0x41d0
	li 9,2
	stw 11,68(29)
	lis 28,gi@ha
	stw 10,196(29)
	lis 3,.LC22@ha
	la 28,gi@l(28)
	stw 0,208(29)
	la 3,.LC22@l(3)
	stw 9,248(29)
	stw 7,204(29)
	stw 8,188(29)
	stw 7,200(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 9,misc_fire_think@ha
	stw 3,40(29)
	lis 10,level+4@ha
	la 9,misc_fire_think@l(9)
	lis 11,.LC115@ha
	stw 9,436(29)
	mr 3,29
	lfs 0,level+4@l(10)
	lfd 13,.LC115@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe18:
	.size	 SP_misc_fire,.Lfe18-SP_misc_fire
	.section	".rodata"
	.align 3
.LC116:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl SP_item_angel_statue
	.type	 SP_item_angel_statue,@function
SP_item_angel_statue:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 28,gi@ha
	mr 29,3
	la 28,gi@l(28)
	lis 4,.LC30@ha
	lwz 9,44(28)
	la 4,.LC30@l(4)
	mtlr 9
	blrl
	lis 11,item_angel_statue_think@ha
	li 4,2
	stw 29,256(29)
	lis 5,0xc200
	lis 6,0x4200
	stw 4,56(29)
	li 0,0
	li 9,512
	stw 5,192(29)
	la 11,item_angel_statue_think@l(11)
	li 10,0
	stw 9,68(29)
	lis 8,0x4280
	stw 0,60(29)
	lis 7,level+4@ha
	stw 10,196(29)
	lis 9,.LC116@ha
	mr 3,29
	stw 6,204(29)
	stw 8,208(29)
	stw 11,436(29)
	stw 4,248(29)
	stw 5,188(29)
	stw 6,200(29)
	lfs 0,level+4@l(7)
	lfd 13,.LC116@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 SP_item_angel_statue,.Lfe19-SP_item_angel_statue
	.section	".rodata"
	.align 2
.LC117:
	.long 0x46fffe00
	.align 3
.LC118:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC119:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC120:
	.long 0xbfe00000
	.long 0x0
	.section	".text"
	.align 2
	.globl target_gravity_use
	.type	 target_gravity_use,@function
target_gravity_use:
	stwu 1,-64(1)
	mflr 0
	stfd 28,32(1)
	stfd 29,40(1)
	stfd 30,48(1)
	stfd 31,56(1)
	stw 31,28(1)
	stw 0,68(1)
	lis 9,.LC117@ha
	lis 31,0x4330
	lfs 28,.LC117@l(9)
	lis 9,.LC118@ha
	la 9,.LC118@l(9)
	lfd 29,0(9)
	lis 9,.LC119@ha
	la 9,.LC119@l(9)
	lfd 30,0(9)
	lis 9,.LC120@ha
	la 9,.LC120@l(9)
	lfd 31,0(9)
.L57:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	stw 3,20(1)
	stw 31,16(1)
	lfd 0,16(1)
	fsub 0,0,29
	frsp 0,0
	fdivs 13,0,28
	fmr 0,13
	fcmpu 0,0,30
	bc 4,0,.L57
	fcmpu 0,0,31
	bc 4,1,.L57
	lis 9,sv_gravity@ha
	lwz 11,sv_gravity@l(9)
	lfs 0,20(11)
	fmuls 0,0,13
	stfs 0,20(11)
	lwz 0,68(1)
	mtlr 0
	lwz 31,28(1)
	lfd 28,32(1)
	lfd 29,40(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe20:
	.size	 target_gravity_use,.Lfe20-target_gravity_use
	.align 2
	.globl SP_target_gravity
	.type	 SP_target_gravity,@function
SP_target_gravity:
	lis 9,target_gravity_use@ha
	la 9,target_gravity_use@l(9)
	stw 9,448(3)
	blr
.Lfe21:
	.size	 SP_target_gravity,.Lfe21-SP_target_gravity
	.align 2
	.globl SpellOne
	.type	 SpellOne,@function
SpellOne:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl PMenu_Close
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,0
	bc 12,1,.L60
	lis 9,gi+12@ha
	lis 4,.LC33@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC33@l(4)
	b .L231
.L60:
	lwz 0,3464(9)
	cmpwi 0,0,1
	bc 12,2,.L61
	lis 9,gi+12@ha
	lis 4,.LC34@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC34@l(4)
.L231:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L59
.L61:
	lwz 0,3428(9)
	cmpwi 0,0,1
	bc 4,2,.L62
	mr 3,31
	crxor 6,6,6
	bl SuperJump
.L62:
	lwz 9,84(31)
	lwz 0,3428(9)
	cmpwi 0,0,2
	bc 4,2,.L59
	mr 3,31
	crxor 6,6,6
	bl Heal
.L59:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe22:
	.size	 SpellOne,.Lfe22-SpellOne
	.section	".rodata"
	.align 3
.LC121:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC122:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Spell_earthquake
	.type	 Spell_earthquake,@function
Spell_earthquake:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	bl G_Spawn
	mr 29,3
	li 9,5
	lwz 0,184(29)
	lis 11,Spell_earthquake_think@ha
	lis 8,0x4416
	stw 9,532(29)
	la 11,Spell_earthquake_think@l(11)
	lis 10,level@ha
	ori 0,0,1
	lis 9,.LC122@ha
	stw 11,436(29)
	stw 0,184(29)
	la 10,level@l(10)
	la 9,.LC122@l(9)
	stw 8,328(29)
	li 0,0
	lis 11,gi+36@ha
	lfs 13,4(10)
	lis 3,.LC48@ha
	lfs 0,0(9)
	la 3,.LC48@l(3)
	lis 9,.LC121@ha
	lfd 12,.LC121@l(9)
	fadds 13,13,0
	stfs 13,288(29)
	lfs 0,4(10)
	stw 0,476(29)
	fadd 0,0,12
	frsp 0,0
	stfs 0,428(29)
	lwz 0,gi+36@l(11)
	mtlr 0
	blrl
	stw 3,576(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 Spell_earthquake,.Lfe23-Spell_earthquake
	.align 2
	.globl SpellThree
	.type	 SpellThree,@function
SpellThree:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl PMenu_Close
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,2
	bc 12,1,.L209
	lis 9,gi+12@ha
	lis 4,.LC33@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC33@l(4)
	b .L232
.L209:
	lwz 0,3464(9)
	cmpwi 0,0,1
	bc 12,2,.L210
	lis 9,gi+12@ha
	lis 4,.LC34@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC34@l(4)
.L232:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L208
.L210:
	lwz 0,3428(9)
	cmpwi 0,0,1
	bc 4,2,.L211
	li 0,0
	mr 3,31
	stw 0,3464(9)
	bl Shockwave
.L211:
	lwz 9,84(31)
	lwz 0,3428(9)
	cmpwi 0,0,2
	bc 4,2,.L208
	li 0,0
	mr 3,31
	stw 0,3464(9)
	bl FindRandomFlag
.L208:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe24:
	.size	 SpellThree,.Lfe24-SpellThree
	.align 2
	.globl SpellTwo
	.type	 SpellTwo,@function
SpellTwo:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl PMenu_Close
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,1
	bc 12,1,.L98
	lis 9,gi+12@ha
	lis 4,.LC33@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC33@l(4)
	b .L233
.L98:
	lwz 0,3464(9)
	cmpwi 0,0,1
	bc 12,2,.L99
	lis 9,gi+12@ha
	lis 4,.LC34@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC34@l(4)
.L233:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L97
.L99:
	lwz 0,3428(9)
	cmpwi 0,0,1
	bc 4,2,.L100
	li 0,0
	mr 3,31
	stw 0,3464(9)
	bl Flash_Explode
.L100:
	lwz 9,84(31)
	lwz 0,3428(9)
	cmpwi 0,0,2
	bc 4,2,.L97
	li 0,0
	mr 3,31
	stw 0,3464(9)
	bl Flash_Explode
.L97:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 SpellTwo,.Lfe25-SpellTwo
	.align 2
	.globl SpellMenu
	.type	 SpellMenu,@function
SpellMenu:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,84(3)
	lwz 0,3428(9)
	cmpwi 0,0,1
	bc 4,2,.L122
	lis 4,RedMenu@ha
	li 5,0
	la 4,RedMenu@l(4)
	li 6,16
	bl PMenu_Open
	b .L123
.L122:
	lis 4,BlueMenu@ha
	li 5,0
	la 4,BlueMenu@l(4)
	li 6,16
	bl PMenu_Open
.L123:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe26:
	.size	 SpellMenu,.Lfe26-SpellMenu
	.section	".rodata"
	.align 2
.LC123:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl CheckforDivine
	.type	 CheckforDivine,@function
CheckforDivine:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,.LC52@ha
	mr 31,3
	la 30,.LC52@l(9)
	li 3,0
.L120:
	lis 9,.LC123@ha
	addi 4,31,4
	la 9,.LC123@l(9)
	lfs 1,0(9)
	bl findradius
	mr. 3,3
	bc 12,2,.L117
	lwz 0,280(3)
	cmpw 0,0,30
	bc 4,2,.L120
	lwz 0,256(3)
	cmpw 0,0,31
	bc 4,2,.L120
	lwz 11,84(31)
	lwz 9,3424(11)
	addi 9,9,1
	stw 9,3424(11)
.L117:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe27:
	.size	 CheckforDivine,.Lfe27-CheckforDivine
	.comm	maplist,292,4
	.section	".rodata"
	.align 2
.LC124:
	.long 0xbca3d70a
	.align 3
.LC125:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl holyfire_touch
	.type	 holyfire_touch,@function
holyfire_touch:
	stwu 1,-80(1)
	mflr 0
	stmw 27,60(1)
	stw 0,84(1)
	mr 31,3
	mr 30,4
	lwz 0,256(31)
	mr 28,5
	cmpw 0,30,0
	bc 12,2,.L137
	cmpwi 0,6,0
	bc 12,2,.L139
	lwz 0,16(6)
	andi. 9,0,4
	bc 12,2,.L139
	bl G_FreeEdict
	b .L137
.L139:
	lis 9,.LC124@ha
	addi 3,31,4
	lfs 1,.LC124@l(9)
	addi 29,31,376
	mr 27,3
	mr 4,29
	addi 5,1,16
	bl VectorMA
	lwz 0,512(30)
	cmpwi 0,0,0
	bc 12,2,.L140
	lwz 5,256(31)
	li 0,0
	li 11,8
	lwz 9,516(31)
	mr 6,29
	mr 8,28
	stw 0,8(1)
	mr 3,30
	mr 4,31
	stw 11,12(1)
	mr 7,27
	li 10,0
	bl T_Damage
.L140:
	lwz 0,520(31)
	lis 11,0x4330
	lis 10,.LC125@ha
	lfs 2,524(31)
	mr 5,30
	xoris 0,0,0x8000
	la 10,.LC125@l(10)
	lwz 4,256(31)
	stw 0,52(1)
	mr 3,31
	li 6,9
	stw 11,48(1)
	lfd 1,48(1)
	lfd 0,0(10)
	fsub 1,1,0
	frsp 1,1
	bl T_RadiusDamage
	lis 9,gi@ha
	li 3,3
	la 29,gi@l(9)
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 0,612(31)
	cmpwi 0,0,0
	bc 12,2,.L141
	lwz 0,100(29)
	li 3,17
	mtlr 0
	blrl
	b .L142
.L141:
	lwz 0,100(29)
	li 3,7
	mtlr 0
	blrl
.L142:
	lis 29,gi@ha
	addi 3,1,16
	la 29,gi@l(29)
	lwz 9,120(29)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,1
	mtlr 0
	blrl
	mr 3,31
	bl G_FreeEdict
.L137:
	lwz 0,84(1)
	mtlr 0
	lmw 27,60(1)
	la 1,80(1)
	blr
.Lfe28:
	.size	 holyfire_touch,.Lfe28-holyfire_touch
	.section	".rodata"
	.align 3
.LC126:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl fire_holyfire
	.type	 fire_holyfire,@function
fire_holyfire:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 25,28(1)
	stw 0,68(1)
	mr 28,5
	mr 29,4
	fmr 31,1
	mr 27,7
	mr 26,6
	mr 25,8
	mr 30,3
	bl G_Spawn
	lfs 13,0(29)
	mr 31,3
	mr 3,28
	addi 4,31,16
	stfs 13,4(31)
	lfs 0,4(29)
	stfs 0,8(31)
	lfs 13,8(29)
	stfs 13,12(31)
	lfs 0,0(28)
	stfs 0,340(31)
	lfs 13,4(28)
	stfs 13,344(31)
	lfs 0,8(28)
	stfs 0,348(31)
	bl vectoangles
	xoris 0,27,0x8000
	stw 0,20(1)
	lis 11,0x4330
	lis 10,.LC126@ha
	stw 11,16(1)
	la 10,.LC126@l(10)
	mr 3,28
	lfd 1,16(1)
	addi 4,31,376
	lfd 0,0(10)
	fsub 1,1,0
	frsp 1,1
	bl VectorScale
	lis 0,0x600
	li 9,8
	ori 0,0,3
	li 11,2
	stw 9,260(31)
	stw 0,252(31)
	stw 11,248(31)
	lwz 9,84(30)
	lwz 0,3428(9)
	cmpwi 0,0,2
	bc 4,2,.L144
	lwz 0,64(31)
	oris 0,0,0x8
	b .L234
.L144:
	lwz 0,64(31)
	oris 0,0,0x4
.L234:
	stw 0,64(31)
	li 0,0
	stw 0,200(31)
	stw 0,196(31)
	stw 0,192(31)
	stw 0,188(31)
	stw 0,208(31)
	stw 0,204(31)
	lwz 9,84(30)
	lwz 0,3428(9)
	cmpwi 0,0,2
	bc 4,2,.L146
	lis 9,gi+32@ha
	lis 3,.LC87@ha
	lwz 0,gi+32@l(9)
	la 3,.LC87@l(3)
	b .L235
.L146:
	lis 9,gi+32@ha
	lis 3,.LC88@ha
	lwz 0,gi+32@l(9)
	la 3,.LC88@l(3)
.L235:
	mtlr 0
	blrl
	stw 3,40(31)
	li 0,8000
	stw 30,256(31)
	divw 0,0,27
	lis 7,0x4330
	lis 9,.LC126@ha
	la 9,.LC126@l(9)
	lis 8,level+4@ha
	lfd 12,0(9)
	lis 11,G_FreeEdict@ha
	lis 29,gi@ha
	lis 9,holyfire_touch@ha
	la 11,G_FreeEdict@l(11)
	la 9,holyfire_touch@l(9)
	la 29,gi@l(29)
	stw 9,444(31)
	lis 3,.LC89@ha
	lfs 13,level+4@l(8)
	la 3,.LC89@l(3)
	stw 11,436(31)
	stw 26,516(31)
	stw 25,520(31)
	stfs 31,524(31)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 7,16(1)
	lfd 0,16(1)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,428(31)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC90@ha
	stw 3,76(31)
	la 9,.LC90@l(9)
	mr 3,31
	stw 9,280(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe29:
	.size	 fire_holyfire,.Lfe29-fire_holyfire
	.align 2
	.globl FindRedFlag
	.type	 FindRedFlag,@function
FindRedFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 29,3
	li 30,1
	bl PMenu_Close
	lis 9,globals@ha
	lis 11,g_edicts@ha
	la 9,globals@l(9)
	lwz 10,g_edicts@l(11)
	lwz 0,72(9)
	addi 31,10,904
	cmpw 0,30,0
	bc 4,0,.L165
	mr 27,9
	lis 28,.LC97@ha
.L167:
	lwz 3,280(31)
	la 4,.LC97@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L166
	mr 3,31
	mr 4,29
	bl SendtoFlag
.L166:
	lwz 0,72(27)
	addi 30,30,1
	addi 31,31,904
	cmpw 0,30,0
	bc 12,0,.L167
.L165:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 FindRedFlag,.Lfe30-FindRedFlag
	.align 2
	.globl FindBlueFlag
	.type	 FindBlueFlag,@function
FindBlueFlag:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 29,3
	li 30,1
	bl PMenu_Close
	lis 9,globals@ha
	lis 11,g_edicts@ha
	la 9,globals@l(9)
	lwz 10,g_edicts@l(11)
	lwz 0,72(9)
	addi 31,10,904
	cmpw 0,30,0
	bc 4,0,.L173
	mr 27,9
	lis 28,.LC98@ha
.L175:
	lwz 3,280(31)
	la 4,.LC98@l(28)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L174
	mr 3,31
	mr 4,29
	bl SendtoFlag
.L174:
	lwz 0,72(27)
	addi 30,30,1
	addi 31,31,904
	cmpw 0,30,0
	bc 12,0,.L175
.L173:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe31:
	.size	 FindBlueFlag,.Lfe31-FindBlueFlag
	.section	".rodata"
	.align 3
.LC127:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC128:
	.long 0x41f00000
	.section	".text"
	.align 2
	.globl Shockwave
	.type	 Shockwave,@function
Shockwave:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 27,3
	bl G_Spawn
	lfs 0,4(27)
	mr 29,3
	lis 9,.LC128@ha
	la 9,.LC128@l(9)
	lis 0,0x4040
	lfs 13,0(9)
	lis 10,level@ha
	lis 11,ShockwaveThink@ha
	stfs 0,4(29)
	la 10,level@l(10)
	la 11,ShockwaveThink@l(11)
	lfs 0,8(27)
	lis 9,.LC127@ha
	lis 28,gi@ha
	lfd 12,.LC127@l(9)
	la 28,gi@l(28)
	lis 3,.LC88@ha
	la 3,.LC88@l(3)
	stfs 0,8(29)
	lfs 0,12(27)
	stw 0,596(29)
	fadds 0,0,13
	stfs 0,12(29)
	lfs 13,4(10)
	stw 11,436(29)
	stfs 13,288(29)
	lfs 0,4(10)
	fadd 0,0,12
	frsp 0,0
	stfs 0,428(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	lwz 0,72(28)
	mr 3,29
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe32:
	.size	 Shockwave,.Lfe32-Shockwave
	.align 2
	.globl SuperJump
	.type	 SuperJump,@function
SuperJump:
	lwz 11,84(3)
	li 0,0
	li 10,1
	stw 0,3464(11)
	lwz 9,84(3)
	stw 10,3468(9)
	blr
.Lfe33:
	.size	 SuperJump,.Lfe33-SuperJump
	.align 2
	.globl Heal
	.type	 Heal,@function
Heal:
	lwz 0,484(3)
	li 11,0
	lwz 9,84(3)
	stw 0,480(3)
	stw 11,3464(9)
	blr
.Lfe34:
	.size	 Heal,.Lfe34-Heal
	.align 2
	.globl SpellSix
	.type	 SpellSix,@function
SpellSix:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl PMenu_Close
	lwz 9,84(31)
	lwz 0,3456(9)
	cmpwi 0,0,3
	bc 12,1,.L103
	lis 9,gi+12@ha
	lis 4,.LC33@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC33@l(4)
	b .L236
.L103:
	lwz 0,3464(9)
	cmpwi 0,0,1
	bc 12,2,.L104
	lis 9,gi+12@ha
	lis 4,.LC34@ha
	lwz 0,gi+12@l(9)
	mr 3,31
	la 4,.LC34@l(4)
.L236:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L102
.L104:
	lwz 0,3428(9)
	cmpwi 0,0,1
	bc 4,2,.L105
	li 0,0
	mr 3,31
	stw 0,3464(9)
	crxor 6,6,6
	bl SP_monster_mutant
.L105:
	lwz 9,84(31)
	lwz 0,3428(9)
	cmpwi 0,0,2
	bc 4,2,.L102
	li 0,0
	mr 3,31
	stw 0,3464(9)
	bl Divine
.L102:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe35:
	.size	 SpellSix,.Lfe35-SpellSix
	.section	".rodata"
	.align 3
.LC129:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC130:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl divine_think
	.type	 divine_think,@function
divine_think:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	li 30,1
	li 3,0
.L112:
	lis 9,.LC130@ha
	addi 4,31,4
	la 9,.LC130@l(9)
	lfs 1,0(9)
	bl findradius
	mr. 3,3
	bc 12,2,.L109
	lwz 9,84(3)
	cmpwi 0,9,0
	bc 12,2,.L112
	lwz 0,256(31)
	cmpw 0,3,0
	bc 4,2,.L112
	stw 30,3464(9)
	lwz 0,484(3)
	stw 0,480(3)
.L109:
	lis 9,level+4@ha
	lis 11,.LC129@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC129@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe36:
	.size	 divine_think,.Lfe36-divine_think
	.align 2
	.globl Weapon_HolyFire
	.type	 Weapon_HolyFire,@function
Weapon_HolyFire:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 8,pause_frames.81@ha
	lis 9,fire_frames.82@ha
	lis 10,Weapon_HolyFire_Fire@ha
	la 8,pause_frames.81@l(8)
	la 9,fire_frames.82@l(9)
	la 10,Weapon_HolyFire_Fire@l(10)
	li 4,5
	li 5,9
	li 6,31
	li 7,36
	bl Weapon_Generic
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 Weapon_HolyFire,.Lfe37-Weapon_HolyFire
	.section	".rodata"
	.align 2
.LC131:
	.long 0x43480000
	.section	".text"
	.align 2
	.globl CheckForBody
	.type	 CheckForBody,@function
CheckForBody:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,3
	li 31,0
	lis 29,.LC91@ha
	b .L149
.L151:
	lwz 3,280(31)
	bl Q_stricmp
	cmpwi 0,3,0
	li 4,1
	mr 3,30
	bc 4,2,.L149
	bl SP_Decoy
	mr 3,31
	bl G_FreeEdict
.L149:
	lis 9,.LC131@ha
	mr 3,31
	la 9,.LC131@l(9)
	addi 4,30,4
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	la 4,.LC91@l(29)
	bc 4,2,.L151
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe38:
	.size	 CheckForBody,.Lfe38-CheckForBody
	.align 2
	.globl FindFlag
	.type	 FindFlag,@function
FindFlag:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 4,FlagMenu@ha
	li 5,0
	la 4,FlagMenu@l(4)
	li 6,12
	bl PMenu_Open
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe39:
	.size	 FindFlag,.Lfe39-FindFlag
	.section	".rodata"
	.align 3
.LC132:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl ShockwaveThink
	.type	 ShockwaveThink,@function
ShockwaveThink:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 9,level+4@ha
	lfs 0,288(31)
	lfs 13,596(31)
	lfs 12,level+4@l(9)
	fadds 0,0,13
	fcmpu 0,12,0
	bc 4,1,.L226
	bl ShockwaveExplode
	mr 3,31
	bl G_FreeEdict
	b .L227
.L226:
	lis 9,.LC132@ha
	fmr 0,12
	lfd 13,.LC132@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
.L227:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe40:
	.size	 ShockwaveThink,.Lfe40-ShockwaveThink
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
