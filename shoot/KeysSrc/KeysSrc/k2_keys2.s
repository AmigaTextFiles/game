	.file	"k2_keys2.c"
gcc2_compiled.:
	.section	".data"
	.align 2
	.type	 VEC_ORIGIN,@object
	.size	 VEC_ORIGIN,12
VEC_ORIGIN:
	.long 0x0
	.long 0x0
	.long 0x0
	.section	".rodata"
	.align 2
.LC0:
	.string	"haste"
	.align 2
.LC1:
	.string	"4"
	.align 2
.LC2:
	.string	"regeneration"
	.align 2
.LC3:
	.string	"futility"
	.align 2
.LC4:
	.string	"infliction"
	.align 2
.LC5:
	.string	"bfk"
	.align 2
.LC6:
	.string	"stealth"
	.align 2
.LC7:
	.string	"antikey"
	.align 2
.LC8:
	.string	"homing"
	.align 2
.LC9:
	.long 0x0
	.section	".text"
	.align 2
	.globl K2_SpawnAllKeys
	.type	 K2_SpawnAllKeys,@function
K2_SpawnAllKeys:
	stwu 1,-64(1)
	mflr 0
	stmw 23,28(1)
	stw 0,68(1)
	lis 11,.LC9@ha
	lis 9,haste@ha
	la 11,.LC9@l(11)
	lis 30,haste@ha
	lfs 0,0(11)
	lis 29,regeneration@ha
	lis 28,futility@ha
	lwz 11,haste@l(9)
	lis 27,infliction@ha
	lis 26,bfk@ha
	lis 25,stealth@ha
	lis 24,antikey@ha
	lfs 13,20(11)
	lis 23,homing@ha
	fcmpu 0,13,0
	bc 12,2,.L7
	fmr 0,13
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpwi 0,9,4
	bc 4,1,.L8
	lis 9,gi+148@ha
	lis 3,.LC0@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC0@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L8:
	lwz 9,haste@l(30)
	li 31,0
	b .L63
.L12:
	li 3,0
	li 4,16
	li 5,0
	addi 31,31,1
	bl K2_SpawnKey
	lwz 9,haste@l(30)
.L63:
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpw 0,31,0
	bc 12,0,.L12
.L7:
	lis 11,.LC9@ha
	lis 9,regeneration@ha
	la 11,.LC9@l(11)
	lfs 0,0(11)
	lwz 11,regeneration@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L14
	fmr 0,13
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpwi 0,9,4
	bc 4,1,.L15
	lis 9,gi+148@ha
	lis 3,.LC2@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC2@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L15:
	lwz 9,regeneration@l(29)
	li 31,0
	b .L64
.L19:
	li 3,0
	li 4,2
	li 5,0
	addi 31,31,1
	bl K2_SpawnKey
	lwz 9,regeneration@l(29)
.L64:
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpw 0,31,0
	bc 12,0,.L19
.L14:
	lis 11,.LC9@ha
	lis 9,futility@ha
	la 11,.LC9@l(11)
	lfs 0,0(11)
	lwz 11,futility@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L21
	fmr 0,13
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpwi 0,9,4
	bc 4,1,.L22
	lis 9,gi+148@ha
	lis 3,.LC3@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC3@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L22:
	lwz 9,futility@l(28)
	li 31,0
	b .L65
.L26:
	li 3,0
	li 4,4
	li 5,0
	addi 31,31,1
	bl K2_SpawnKey
	lwz 9,futility@l(28)
.L65:
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpw 0,31,0
	bc 12,0,.L26
.L21:
	lis 11,.LC9@ha
	lis 9,infliction@ha
	la 11,.LC9@l(11)
	lfs 0,0(11)
	lwz 11,infliction@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L28
	fmr 0,13
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpwi 0,9,4
	bc 4,1,.L29
	lis 9,gi+148@ha
	lis 3,.LC4@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC4@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L29:
	lwz 9,infliction@l(27)
	li 31,0
	b .L66
.L33:
	li 3,0
	li 4,8
	li 5,0
	addi 31,31,1
	bl K2_SpawnKey
	lwz 9,infliction@l(27)
.L66:
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpw 0,31,0
	bc 12,0,.L33
.L28:
	lis 11,.LC9@ha
	lis 9,bfk@ha
	la 11,.LC9@l(11)
	lfs 0,0(11)
	lwz 11,bfk@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L35
	fmr 0,13
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpwi 0,9,4
	bc 4,1,.L36
	lis 9,gi+148@ha
	lis 3,.LC5@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC5@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L36:
	lwz 9,bfk@l(26)
	li 31,0
	b .L67
.L40:
	li 3,0
	li 4,128
	li 5,0
	addi 31,31,1
	bl K2_SpawnKey
	lwz 9,bfk@l(26)
.L67:
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpw 0,31,0
	bc 12,0,.L40
.L35:
	lis 11,.LC9@ha
	lis 9,stealth@ha
	la 11,.LC9@l(11)
	lfs 0,0(11)
	lwz 11,stealth@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L42
	fmr 0,13
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpwi 0,9,4
	bc 4,1,.L43
	lis 9,gi+148@ha
	lis 3,.LC6@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC6@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L43:
	lwz 9,stealth@l(25)
	li 31,0
	b .L68
.L47:
	li 3,0
	li 4,32
	li 5,0
	addi 31,31,1
	bl K2_SpawnKey
	lwz 9,stealth@l(25)
.L68:
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpw 0,31,0
	bc 12,0,.L47
.L42:
	lis 11,.LC9@ha
	lis 9,antikey@ha
	la 11,.LC9@l(11)
	lfs 0,0(11)
	lwz 11,antikey@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L49
	fmr 0,13
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpwi 0,9,4
	bc 4,1,.L50
	lis 9,gi+148@ha
	lis 3,.LC7@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC7@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L50:
	lwz 9,antikey@l(24)
	li 31,0
	b .L69
.L54:
	li 3,0
	li 4,1
	li 5,0
	addi 31,31,1
	bl K2_SpawnKey
	lwz 9,antikey@l(24)
.L69:
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpw 0,31,0
	bc 12,0,.L54
.L49:
	lis 11,.LC9@ha
	lis 9,homing@ha
	la 11,.LC9@l(11)
	lfs 0,0(11)
	lwz 11,homing@l(9)
	lfs 13,20(11)
	fcmpu 0,13,0
	bc 12,2,.L56
	fmr 0,13
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	cmpwi 0,9,4
	bc 4,1,.L57
	lis 9,gi+148@ha
	lis 3,.LC8@ha
	lwz 0,gi+148@l(9)
	lis 4,.LC1@ha
	la 3,.LC8@l(3)
	la 4,.LC1@l(4)
	mtlr 0
	blrl
.L57:
	lwz 9,homing@l(23)
	li 31,0
	b .L70
.L61:
	li 3,0
	li 4,64
	li 5,0
	addi 31,31,1
	bl K2_SpawnKey
	lwz 9,homing@l(23)
.L70:
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpw 0,31,0
	bc 12,0,.L61
.L56:
	lwz 0,68(1)
	mtlr 0
	lmw 23,28(1)
	la 1,64(1)
	blr
.Lfe1:
	.size	 K2_SpawnAllKeys,.Lfe1-K2_SpawnAllKeys
	.section	".rodata"
	.align 3
.LC10:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC11:
	.long 0x4009851e
	.long 0xb851eb85
	.align 2
.LC12:
	.long 0x0
	.section	".text"
	.align 2
	.globl K2_SpawnItem
	.type	 K2_SpawnItem,@function
K2_SpawnItem:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	mr 29,4
	mr 30,5
	mr 3,29
	bl PrecacheItem
	lis 7,keyshells@ha
	li 0,0
	stw 29,648(31)
	lwz 8,keyshells@l(7)
	lis 11,level+4@ha
	lis 10,.LC10@ha
	stw 0,512(31)
	lis 9,.LC12@ha
	lfs 0,level+4@l(11)
	la 9,.LC12@l(9)
	li 0,512
	lfd 13,.LC10@l(10)
	li 11,1
	lfs 12,0(9)
	lis 9,K2_droptofloor@ha
	stw 11,64(31)
	la 9,K2_droptofloor@l(9)
	stw 0,68(31)
	stw 9,436(31)
	fadd 0,0,13
	stw 11,80(31)
	frsp 0,0
	stfs 0,428(31)
	lfs 13,20(8)
	fcmpu 0,13,12
	bc 4,2,.L72
	li 0,8
	stw 0,68(31)
.L72:
	lwz 9,keyshells@l(7)
	lfs 0,20(9)
	fcmpu 0,0,12
	bc 12,2,.L73
	lis 9,qversion@ha
	lis 11,.LC11@ha
	lfs 0,qversion@l(9)
	lfd 13,.LC11@l(11)
	fcmpu 0,0,13
	bc 12,1,.L75
	bc 4,0,.L74
.L75:
	cmpwi 0,30,64
	bc 4,2,.L76
	lwz 0,64(31)
	lwz 9,68(31)
	b .L105
.L76:
	cmpwi 0,30,4
	bc 4,2,.L78
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,6144
	b .L106
.L78:
	cmpwi 0,30,8
	bc 4,2,.L80
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,4096
	b .L106
.L80:
	cmpwi 0,30,2
	bc 4,2,.L82
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,5120
	b .L106
.L82:
	cmpwi 0,30,128
	bc 4,2,.L84
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,1024
	b .L106
.L84:
	cmpwi 0,30,1
	bc 4,2,.L86
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,7168
	b .L106
.L86:
	cmpwi 0,30,16
	bc 4,2,.L73
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,3072
	b .L106
.L74:
	cmpwi 0,30,64
	bc 4,2,.L90
	lwz 0,64(31)
	lwz 9,68(31)
	b .L105
.L90:
	cmpwi 0,30,4
	bc 4,2,.L92
	lwz 0,64(31)
	lwz 9,68(31)
	oris 0,0,0x800
	ori 0,0,256
	ori 9,9,4096
	b .L106
.L92:
	cmpwi 0,30,8
	bc 4,2,.L94
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,4096
	b .L106
.L94:
	cmpwi 0,30,2
	bc 4,2,.L96
	lwz 0,64(31)
	lwz 9,68(31)
	oris 0,0,0x800
	ori 0,0,256
	ori 9,9,1024
	b .L106
.L96:
	cmpwi 0,30,128
	bc 4,2,.L98
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,1024
	b .L106
.L98:
	cmpwi 0,30,1
	bc 4,2,.L100
	lwz 0,64(31)
	lwz 9,68(31)
	ori 0,0,256
	ori 9,9,7168
	b .L106
.L100:
	cmpwi 0,30,16
	bc 4,2,.L73
	lwz 0,64(31)
	lwz 9,68(31)
	oris 0,0,0x800
.L105:
	ori 0,0,256
	ori 9,9,2048
.L106:
	stw 0,64(31)
	stw 9,68(31)
.L73:
	cmpwi 0,30,32
	bc 4,2,.L103
	stw 30,68(31)
.L103:
	lwz 3,268(31)
	cmpwi 0,3,0
	bc 12,2,.L104
	lis 9,gi+32@ha
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
.L104:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 K2_SpawnItem,.Lfe2-K2_SpawnItem
	.section	".rodata"
	.align 2
.LC13:
	.string	"Regeneration Key"
	.align 2
.LC14:
	.string	"Haste Key"
	.align 2
.LC15:
	.string	"Futility Key"
	.align 2
.LC16:
	.string	"Infliction Key"
	.align 2
.LC17:
	.string	"BFK"
	.align 2
.LC18:
	.string	"Stealth Key"
	.align 2
.LC19:
	.string	"Anti-Key"
	.align 2
.LC20:
	.string	"Homing Key"
	.align 2
.LC22:
	.string	"Couldn't find deathmatch start\n"
	.align 2
.LC23:
	.string	"Couldn't find %s\n"
	.align 2
.LC21:
	.long 0x46fffe00
	.align 2
.LC24:
	.long 0x43960000
	.align 3
.LC25:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl K2_SpawnKey
	.type	 K2_SpawnKey,@function
K2_SpawnKey:
	stwu 1,-192(1)
	mflr 0
	stfd 31,184(1)
	stmw 23,148(1)
	stw 0,196(1)
	mr 26,4
	mr 24,3
	cmpwi 0,26,2
	mr 25,5
	li 30,0
	li 29,0
	bc 4,2,.L108
	lis 9,.LC13@ha
	la 29,.LC13@l(9)
	b .L109
.L108:
	cmpwi 0,26,16
	bc 4,2,.L110
	lis 9,.LC14@ha
	la 29,.LC14@l(9)
	b .L109
.L110:
	cmpwi 0,26,4
	bc 4,2,.L112
	lis 9,.LC15@ha
	la 29,.LC15@l(9)
	b .L109
.L112:
	cmpwi 0,26,8
	bc 4,2,.L114
	lis 9,.LC16@ha
	la 29,.LC16@l(9)
	b .L109
.L114:
	cmpwi 0,26,128
	bc 4,2,.L116
	lis 9,.LC17@ha
	la 29,.LC17@l(9)
	b .L109
.L116:
	cmpwi 0,26,32
	bc 4,2,.L118
	lis 9,.LC18@ha
	la 29,.LC18@l(9)
	b .L109
.L118:
	cmpwi 0,26,1
	bc 4,2,.L120
	lis 9,.LC19@ha
	la 29,.LC19@l(9)
	b .L109
.L120:
	cmpwi 0,26,64
	bc 4,2,.L109
	lis 9,.LC20@ha
	la 29,.LC20@l(9)
.L109:
	bl G_Spawn
	cmpwi 0,30,0
	mr 31,3
	bc 4,2,.L124
.L125:
	bl K2_SelectRandomDeathmatchSpawnPoint
	mr. 30,3
	bc 12,2,.L125
.L124:
	mr 3,29
	bl FindItem
	mr. 23,3
	bc 12,2,.L127
	cmpwi 7,25,0
	xori 9,25,3
	subfic 0,9,0
	adde 9,0,9
	mfcr 0
	rlwinm 0,0,31,1
	or. 11,0,9
	bc 12,2,.L128
	cmpwi 0,30,0
	bc 12,2,.L133
	lis 0,0xc170
	lis 9,0x4170
	stw 0,196(31)
	lis 11,.LC24@ha
	addi 29,1,24
	stw 9,208(31)
	la 11,.LC24@l(11)
	addi 4,1,8
	stw 0,188(31)
	addi 3,31,16
	mr 5,29
	stw 0,192(31)
	li 6,0
	addi 27,30,4
	stw 9,200(31)
	addi 28,31,4
	stw 9,204(31)
	lfs 0,4(30)
	lfs 31,0(11)
	stfs 0,4(31)
	lfs 13,8(30)
	stfs 13,8(31)
	lfs 0,12(30)
	stfs 0,12(31)
	lfs 13,16(30)
	stfs 13,16(31)
	lfs 0,20(30)
	stfs 0,20(31)
	lfs 13,24(30)
	stfs 13,24(31)
	bl AngleVectors
	lis 11,0xc180
	lis 0,0x41c0
	li 9,0
	stw 0,40(1)
	addi 4,1,40
	stw 9,44(1)
	addi 5,1,8
	mr 6,29
	stw 11,48(1)
	mr 3,27
	mr 7,28
	bl G_ProjectSource
	lis 9,gi+48@ha
	addi 5,31,188
	lwz 0,gi+48@l(9)
	mr 4,27
	mr 7,28
	li 9,1
	mr 8,30
	mtlr 0
	addi 6,31,200
	addi 3,1,56
	blrl
	lfs 0,68(1)
	stfs 0,4(31)
	lfs 13,72(1)
	stfs 13,8(31)
	lfs 0,76(1)
	stfs 0,12(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,140(1)
	lis 11,.LC25@ha
	addi 4,31,376
	la 11,.LC25@l(11)
	stw 0,136(1)
	addi 3,1,8
	lfd 13,0(11)
	lfd 1,136(1)
	lis 11,.LC21@ha
	lfs 0,.LC21@l(11)
	fsub 1,1,13
	frsp 1,1
	fdivs 1,1,0
	fmuls 1,1,31
	bl VectorScale
	stfs 31,384(31)
	b .L137
.L128:
	cmpwi 0,25,4
	bc 4,2,.L132
	cmpwi 0,30,0
	bc 12,2,.L133
	lis 0,0xc170
	lis 9,0x4170
	stw 0,196(31)
	lis 11,.LC24@ha
	addi 29,1,24
	stw 9,208(31)
	la 11,.LC24@l(11)
	addi 4,1,8
	stw 0,188(31)
	addi 3,31,16
	mr 5,29
	stw 0,192(31)
	li 6,0
	addi 27,30,4
	stw 9,200(31)
	addi 28,31,4
	stw 9,204(31)
	lfs 0,4(30)
	lfs 31,0(11)
	stfs 0,4(31)
	lfs 13,8(30)
	stfs 13,8(31)
	lfs 0,12(30)
	stfs 0,12(31)
	lfs 13,16(30)
	stfs 13,16(31)
	lfs 0,20(30)
	stfs 0,20(31)
	lfs 13,24(30)
	stfs 13,24(31)
	bl AngleVectors
	lis 11,0xc180
	lis 0,0x41c0
	li 9,0
	stw 0,40(1)
	addi 4,1,40
	stw 9,44(1)
	addi 5,1,8
	mr 6,29
	stw 11,48(1)
	mr 3,27
	mr 7,28
	bl G_ProjectSource
	lis 9,gi+48@ha
	addi 5,31,188
	lwz 0,gi+48@l(9)
	mr 4,27
	mr 7,28
	li 9,1
	mr 8,30
	mtlr 0
	addi 6,31,200
	addi 3,1,56
	blrl
	lfs 0,68(1)
	stfs 0,4(31)
	lfs 13,72(1)
	stfs 13,8(31)
	lfs 0,76(1)
	stfs 0,12(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,140(1)
	lis 11,.LC25@ha
	addi 4,31,376
	la 11,.LC25@l(11)
	stw 0,136(1)
	addi 3,1,8
	lfd 13,0(11)
	lfd 1,136(1)
	lis 11,.LC21@ha
	lfs 0,.LC21@l(11)
	fsub 1,1,13
	frsp 1,1
	fdivs 1,1,0
	fmuls 1,1,31
	bl VectorScale
	stfs 31,384(31)
	mr 3,31
	mr 4,23
	stw 24,1332(31)
	b .L139
.L133:
	lis 9,gi+4@ha
	lis 3,.LC22@ha
	lwz 0,gi+4@l(9)
	la 3,.LC22@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L138
.L132:
	bc 12,30,.L138
	lis 0,0xc170
	lis 9,0x4170
	stw 0,196(31)
	addi 29,1,24
	addi 4,1,8
	stw 9,208(31)
	mr 5,29
	li 6,0
	stw 0,188(31)
	addi 28,24,4
	addi 27,31,4
	stw 0,192(31)
	stw 9,200(31)
	stw 9,204(31)
	lwz 3,84(24)
	addi 3,3,3700
	bl AngleVectors
	lis 11,0x4300
	lis 0,0x4280
	li 9,0
	stw 0,40(1)
	addi 4,1,40
	stw 9,44(1)
	addi 5,1,8
	mr 6,29
	stw 11,48(1)
	mr 3,28
	mr 7,27
	bl G_ProjectSource
	lis 9,gi+48@ha
	addi 3,1,56
	lwz 0,gi+48@l(9)
	mr 4,28
	mr 7,27
	li 9,1
	addi 5,31,188
	mtlr 0
	addi 6,31,200
	mr 8,24
	blrl
	lfs 13,68(1)
	lis 9,.LC24@ha
	addi 3,1,8
	la 9,.LC24@l(9)
	addi 4,31,376
	lfs 1,0(9)
	stfs 13,4(31)
	lfs 0,72(1)
	stfs 0,8(31)
	lfs 13,76(1)
	stfs 13,12(31)
	bl VectorScale
	cmpwi 0,25,2
	lis 0,0x4396
	stw 0,384(31)
	bc 4,2,.L137
	stw 24,1332(31)
.L137:
	mr 3,31
	mr 4,23
.L139:
	mr 5,26
	bl K2_SpawnItem
	b .L138
.L127:
	lis 9,gi+4@ha
	lis 3,.LC23@ha
	lwz 0,gi+4@l(9)
	la 3,.LC23@l(3)
	mr 4,29
	mtlr 0
	crxor 6,6,6
	blrl
.L138:
	lwz 0,196(1)
	mtlr 0
	lmw 23,148(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe3:
	.size	 K2_SpawnKey,.Lfe3-K2_SpawnKey
	.section	".rodata"
	.align 2
.LC26:
	.string	"K2_droptofloor: %s startsolid at %s\n"
	.align 2
.LC27:
	.string	"Spawning new key\n"
	.align 2
.LC28:
	.string	"misc/spawn1.wav"
	.align 2
.LC29:
	.long 0xc1700000
	.align 2
.LC30:
	.long 0x41700000
	.align 3
.LC31:
	.long 0x405e0000
	.long 0x0
	.align 3
.LC32:
	.long 0x404e0000
	.long 0x0
	.align 2
.LC33:
	.long 0x0
	.align 2
.LC34:
	.long 0xc3000000
	.align 2
.LC35:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl K2_droptofloor
	.type	 K2_droptofloor,@function
K2_droptofloor:
	stwu 1,-128(1)
	mflr 0
	stmw 27,108(1)
	stw 0,132(1)
	lis 9,.LC29@ha
	lis 11,.LC29@ha
	la 9,.LC29@l(9)
	la 11,.LC29@l(11)
	lfs 1,0(9)
	mr 31,3
	lis 9,.LC29@ha
	lfs 2,0(11)
	la 9,.LC29@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lis 9,.LC30@ha
	lfs 13,0(11)
	la 9,.LC30@l(9)
	lfs 1,0(9)
	lis 9,.LC30@ha
	stfs 13,188(31)
	la 9,.LC30@l(9)
	lfs 0,4(11)
	lfs 2,0(9)
	lis 9,.LC30@ha
	stfs 0,192(31)
	la 9,.LC30@l(9)
	lfs 13,8(11)
	lfs 3,0(9)
	stfs 13,196(31)
	bl tv
	mr 11,3
	lwz 4,268(31)
	lfs 13,0(11)
	cmpwi 0,4,0
	stfs 13,200(31)
	lfs 0,4(11)
	stfs 0,204(31)
	lfs 13,8(11)
	stfs 13,208(31)
	bc 12,2,.L141
	lis 9,gi+44@ha
	mr 3,31
	lwz 0,gi+44@l(9)
	mtlr 0
	blrl
	b .L142
.L141:
	lis 9,gi+44@ha
	lwz 11,648(31)
	mr 3,31
	lwz 0,gi+44@l(9)
	lwz 4,24(11)
	mtlr 0
	blrl
.L142:
	lis 9,respawntime@ha
	lis 11,K2_RespawnKey@ha
	lis 10,K2_Touch_Item@ha
	lwz 7,respawntime@l(9)
	la 11,K2_RespawnKey@l(11)
	la 10,K2_Touch_Item@l(10)
	li 0,1
	stw 11,436(31)
	li 8,7
	stw 0,248(31)
	stw 8,260(31)
	stw 10,444(31)
	lfs 0,20(7)
	fctiwz 13,0
	stfd 13,96(1)
	lwz 9,100(1)
	cmpwi 0,9,120
	bc 4,2,.L143
	lis 9,level+4@ha
	lis 11,.LC31@ha
	lfs 0,level+4@l(9)
	la 11,.LC31@l(11)
	b .L147
.L143:
	lis 9,level+4@ha
	lis 11,.LC32@ha
	lfs 0,level+4@l(9)
	la 11,.LC32@l(11)
.L147:
	lfd 13,0(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lis 9,.LC33@ha
	lis 11,.LC33@ha
	la 9,.LC33@l(9)
	la 11,.LC33@l(11)
	lfs 1,0(9)
	addi 27,31,4
	lis 9,.LC34@ha
	lfs 2,0(11)
	la 9,.LC34@l(9)
	lfs 3,0(9)
	bl tv
	mr 11,3
	lfs 11,4(31)
	lis 9,gi@ha
	lfs 0,0(11)
	la 30,gi@l(9)
	addi 3,1,8
	lfs 12,8(31)
	mr 4,27
	addi 5,31,188
	lfs 13,12(31)
	addi 6,31,200
	addi 7,1,72
	fadds 11,11,0
	lwz 10,48(30)
	mr 8,31
	li 9,3
	mtlr 10
	stfs 11,72(1)
	lfs 0,4(11)
	fadds 12,12,0
	stfs 12,76(1)
	lfs 0,8(11)
	fadds 13,13,0
	stfs 13,80(1)
	blrl
	lwz 0,12(1)
	cmpwi 0,0,0
	bc 12,2,.L145
	mr 3,31
	bl K2_KeyType
	mr 28,3
	lwz 29,280(31)
	mr 3,27
	bl vtos
	mr 5,3
	lwz 9,4(30)
	mr 4,29
	lis 3,.LC26@ha
	mtlr 9
	la 3,.LC26@l(3)
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	lwz 0,4(30)
	lis 3,.LC27@ha
	la 3,.LC27@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 4,28
	li 3,0
	li 5,0
	bl K2_SpawnKey
	b .L140
.L145:
	lfs 12,20(1)
	lis 29,bonus_head@ha
	mr 3,31
	lfs 0,24(1)
	lfs 13,28(1)
	lwz 4,bonus_head@l(29)
	stfs 12,4(31)
	stfs 0,8(31)
	stfs 13,12(31)
	bl AddToItemList
	lwz 9,72(30)
	stw 3,bonus_head@l(29)
	mr 3,31
	mtlr 9
	blrl
	lwz 0,1332(31)
	cmpwi 0,0,0
	bc 4,2,.L140
	lwz 9,36(30)
	lis 3,.LC28@ha
	la 3,.LC28@l(3)
	mtlr 9
	blrl
	lis 9,.LC35@ha
	lwz 0,16(30)
	lis 11,.LC35@ha
	la 9,.LC35@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC35@l(11)
	li 4,0
	mtlr 0
	lis 9,.LC33@ha
	mr 3,31
	lfs 2,0(11)
	la 9,.LC33@l(9)
	lfs 3,0(9)
	blrl
.L140:
	lwz 0,132(1)
	mtlr 0
	lmw 27,108(1)
	la 1,128(1)
	blr
.Lfe4:
	.size	 K2_droptofloor,.Lfe4-K2_droptofloor
	.section	".rodata"
	.align 2
.LC36:
	.string	"player"
	.align 2
.LC37:
	.string	"You already have a key!\n"
	.align 2
.LC39:
	.string	"misc/keytry.wav"
	.align 2
.LC40:
	.string	"You dropped this key.\nYou can't have it back yet.\n"
	.align 2
.LC41:
	.string	"%s got the %s!\n"
	.align 2
.LC42:
	.string	"You got the HASTE Key!\n"
	.align 2
.LC43:
	.string	"You got the REGENERATION Key!\n"
	.align 2
.LC44:
	.string	"You got the FUTILITY Key!\n"
	.align 2
.LC45:
	.string	"You got the INFLICTION Key!\n"
	.align 2
.LC46:
	.string	"You got the STEALTH Key!\n"
	.align 2
.LC47:
	.string	"You got the ANTI-KEY Key!\n"
	.align 2
.LC48:
	.string	"You got the BFK!\n"
	.align 2
.LC49:
	.string	"You got the HOMING Key!\n"
	.align 2
.LC38:
	.long 0x3e4ccccd
	.align 2
.LC50:
	.long 0x3f800000
	.align 2
.LC51:
	.long 0x0
	.align 3
.LC52:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC53:
	.long 0x40080000
	.long 0x0
	.section	".text"
	.align 2
	.globl K2_Touch_Item
	.type	 K2_Touch_Item,@function
K2_Touch_Item:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	mr 31,4
	mr 30,3
	lis 9,.LC50@ha
	lwz 3,280(31)
	lis 4,.LC36@ha
	la 9,.LC50@l(9)
	la 4,.LC36@l(4)
	lfs 31,0(9)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L148
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L148
	lwz 9,648(30)
	lwz 0,4(9)
	cmpwi 0,0,0
	bc 12,2,.L148
	lwz 9,84(31)
	lwz 0,4012(9)
	cmpwi 0,0,0
	bc 4,2,.L148
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 12,2,.L153
	lfs 12,4060(9)
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 0,0(9)
	lis 9,level@ha
	fcmpu 0,12,0
	bc 12,2,.L155
	lwz 0,level@l(9)
	lis 11,0x4330
	lis 10,.LC52@ha
	la 10,.LC52@l(10)
	xoris 0,0,0x8000
	lfd 13,0(10)
	stw 0,20(1)
	stw 11,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,1,.L148
.L155:
	lis 4,.LC37@ha
	mr 3,31
	la 4,.LC37@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	mr 3,31
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L156
	lis 9,.LC38@ha
	lfs 31,.LC38@l(9)
.L156:
	lis 29,gi@ha
	lis 3,.LC39@ha
	la 29,gi@l(29)
	la 3,.LC39@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC50@ha
	lis 10,.LC51@ha
	fmr 1,31
	la 9,.LC50@l(9)
	la 10,.LC51@l(10)
	mr 5,3
	lfs 2,0(9)
	mtlr 0
	li 4,3
	b .L182
.L153:
	lwz 0,1332(30)
	cmpw 0,0,31
	bc 4,2,.L157
	lfs 12,4060(9)
	lis 9,.LC51@ha
	la 9,.LC51@l(9)
	lfs 0,0(9)
	lis 9,level@ha
	fcmpu 0,12,0
	bc 12,2,.L159
	lwz 0,level@l(9)
	lis 11,0x4330
	lis 10,.LC52@ha
	la 10,.LC52@l(10)
	xoris 0,0,0x8000
	lfd 13,0(10)
	stw 0,20(1)
	stw 11,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,1,.L148
.L159:
	lis 4,.LC40@ha
	mr 3,31
	la 4,.LC40@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	mr 3,31
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L160
	lis 9,.LC38@ha
	lfs 31,.LC38@l(9)
.L160:
	lis 29,gi@ha
	lis 3,.LC39@ha
	la 29,gi@l(29)
	la 3,.LC39@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC50@ha
	lis 10,.LC51@ha
	fmr 1,31
	la 9,.LC50@l(9)
	la 10,.LC51@l(10)
	mr 5,3
	lfs 2,0(9)
	mtlr 0
	li 4,0
.L182:
	lfs 3,0(10)
	mr 3,31
	blrl
	lis 10,level@ha
	lwz 8,84(31)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC52@ha
	addi 9,9,30
	la 10,.LC52@l(10)
	xoris 9,9,0x8000
	lfd 13,0(10)
	stw 9,20(1)
	stw 0,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,4060(8)
	b .L148
.L157:
	mr 3,31
	bl K2_CanPickupKey
	cmpwi 0,3,0
	bc 12,2,.L148
	lwz 9,648(30)
	mr 3,30
	mr 4,31
	lwz 0,4(9)
	mtlr 0
	blrl
	cmpwi 0,3,0
	bc 12,2,.L148
	stw 31,1332(30)
	lis 29,level@ha
	lwz 9,level@l(29)
	lis 0,0x4330
	lis 10,.LC52@ha
	la 10,.LC52@l(10)
	la 29,level@l(29)
	addi 9,9,30
	lfd 13,0(10)
	mr 3,30
	xoris 9,9,0x8000
	lwz 10,84(31)
	stw 9,20(1)
	stw 0,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,4060(10)
	bl K2_KeyType
	lwz 11,84(31)
	lis 9,gi@ha
	la 28,gi@l(9)
	stw 3,3988(11)
	lwz 9,648(30)
	lwz 11,40(28)
	lwz 3,36(9)
	mtlr 11
	blrl
	lwz 9,84(31)
	lis 11,itemlist@ha
	lis 0,0x286b
	la 11,itemlist@l(11)
	ori 0,0,51739
	sth 3,134(9)
	lis 9,.LC53@ha
	lwz 10,84(31)
	mr 3,31
	la 9,.LC53@l(9)
	lfd 13,0(9)
	lwz 9,648(30)
	subf 9,11,9
	mullw 9,9,0
	srawi 9,9,2
	addi 9,9,1056
	sth 9,136(10)
	lfs 0,4(29)
	lwz 9,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,3804(9)
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L163
	lis 9,.LC38@ha
	lfs 31,.LC38@l(9)
.L163:
	lwz 11,36(28)
	lwz 9,648(30)
	mtlr 11
	lwz 3,20(9)
	blrl
	lwz 0,16(28)
	lis 9,.LC50@ha
	lis 10,.LC51@ha
	fmr 1,31
	la 9,.LC50@l(9)
	mr 5,3
	la 10,.LC51@l(10)
	lfs 2,0(9)
	li 4,3
	mtlr 0
	mr 3,31
	lfs 3,0(10)
	blrl
	lis 9,.LC51@ha
	lis 11,pickupannounce@ha
	la 9,.LC51@l(9)
	lfs 13,0(9)
	lwz 9,pickupannounce@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L164
	lwz 9,648(30)
	lis 4,.LC41@ha
	li 3,2
	lwz 5,84(31)
	la 4,.LC41@l(4)
	lwz 6,40(9)
	addi 5,5,700
	crxor 6,6,6
	bl my_bprintf
.L164:
	lwz 9,84(31)
	lwz 3,3988(9)
	bl K2_SetClientKeyTimer
	lwz 9,84(31)
	stfs 1,3984(9)
	lwz 11,84(31)
	lwz 0,3988(11)
	cmpwi 0,0,16
	bc 4,2,.L165
	lis 4,.LC42@ha
	mr 3,31
	la 4,.LC42@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L166
.L165:
	cmpwi 0,0,2
	bc 4,2,.L167
	lis 4,.LC43@ha
	mr 3,31
	la 4,.LC43@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L166
.L167:
	cmpwi 0,0,4
	bc 4,2,.L169
	lis 4,.LC44@ha
	mr 3,31
	la 4,.LC44@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L166
.L169:
	cmpwi 0,0,8
	bc 4,2,.L171
	lis 4,.LC45@ha
	mr 3,31
	la 4,.LC45@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L166
.L171:
	cmpwi 0,0,32
	bc 4,2,.L173
	lis 4,.LC46@ha
	mr 3,31
	la 4,.LC46@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L166
.L173:
	cmpwi 0,0,1
	bc 4,2,.L175
	lis 4,.LC47@ha
	mr 3,31
	la 4,.LC47@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L166
.L175:
	cmpwi 0,0,128
	bc 4,2,.L177
	lis 4,.LC48@ha
	mr 3,31
	la 4,.LC48@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L166
.L177:
	cmpwi 0,0,64
	bc 4,2,.L166
	lis 4,.LC49@ha
	mr 3,31
	la 4,.LC49@l(4)
	crxor 6,6,6
	bl safe_centerprintf
.L166:
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L180
	mr 3,31
	bl K2_IsBFK
	cmpwi 0,3,0
	bc 4,2,.L181
	mr 3,31
	bl K2_IsHoming
	cmpwi 0,3,0
	bc 12,2,.L180
.L181:
	lwz 9,1068(31)
	lis 0,0x40a0
	stw 0,4(9)
.L180:
	mr 3,30
	bl G_FreeEdict
.L148:
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 K2_Touch_Item,.Lfe5-K2_Touch_Item
	.section	".rodata"
	.align 2
.LC54:
	.string	"Type \"drop key\" at the console to drop keys\n"
	.align 2
.LC55:
	.string	"You're already using the key.\n"
	.align 2
.LC57:
	.string	"misc/keyuse.wav"
	.align 2
.LC58:
	.string	"You don't have a key to drop.\n"
	.align 2
.LC59:
	.string	"REGENERATION KEY"
	.align 2
.LC60:
	.string	"HASTE KEY"
	.align 2
.LC61:
	.string	"INFLICTION KEY"
	.align 2
.LC62:
	.string	"FUTILITY KEY"
	.align 2
.LC63:
	.string	"STEALTH KEY"
	.align 2
.LC64:
	.string	"ANTI-KEY"
	.align 2
.LC65:
	.string	"HOMING KEY"
	.align 2
.LC66:
	.string	"\nYour %s Has Expired\n"
	.align 2
.LC67:
	.string	"%s dropped the %s!\n"
	.align 3
.LC68:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl K2_RemoveKeyFromInventory
	.type	 K2_RemoveKeyFromInventory,@function
K2_RemoveKeyFromInventory:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	bl K2_IsBFK
	cmpwi 0,3,0
	bc 12,2,.L191
	lis 9,.LC17@ha
	la 30,.LC17@l(9)
	b .L192
.L191:
	mr 3,31
	bl K2_IsRegen
	cmpwi 0,3,0
	bc 12,2,.L193
	lis 9,.LC59@ha
	la 30,.LC59@l(9)
	b .L192
.L193:
	mr 3,31
	bl K2_IsHaste
	cmpwi 0,3,0
	bc 12,2,.L195
	lis 9,.LC60@ha
	la 30,.LC60@l(9)
	b .L192
.L195:
	mr 3,31
	bl K2_IsInfliction
	cmpwi 0,3,0
	bc 12,2,.L197
	lis 9,.LC61@ha
	la 30,.LC61@l(9)
	b .L192
.L197:
	mr 3,31
	bl K2_IsFutility
	cmpwi 0,3,0
	bc 12,2,.L199
	lis 9,.LC62@ha
	la 30,.LC62@l(9)
	b .L192
.L199:
	mr 3,31
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L201
	lis 9,.LC63@ha
	la 30,.LC63@l(9)
	b .L192
.L201:
	mr 3,31
	bl K2_IsAnti
	cmpwi 0,3,0
	bc 12,2,.L203
	lis 9,.LC64@ha
	la 30,.LC64@l(9)
	b .L192
.L203:
	mr 3,31
	bl K2_IsHoming
	cmpwi 0,3,0
	bc 12,2,.L190
	lis 9,.LC65@ha
	la 30,.LC65@l(9)
.L192:
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L207
	mr 3,31
	bl K2_IsBFK
	cmpwi 0,3,0
	bc 4,2,.L208
	mr 3,31
	bl K2_IsHoming
	cmpwi 0,3,0
	bc 12,2,.L207
.L208:
	lwz 9,1072(31)
	lwz 11,1068(31)
	lfs 0,20(9)
	stfs 0,4(11)
.L207:
	mr 3,30
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 10,10,740
	mullw 3,3,0
	lis 9,.LC68@ha
	li 7,-1
	la 9,.LC68@l(9)
	lis 6,level@ha
	rlwinm 3,3,0,0,29
	lfd 12,0(9)
	lwzx 9,10,3
	lis 5,0x4330
	addi 9,9,-1
	stwx 9,10,3
	lwz 11,84(31)
	stw 7,736(11)
	lwz 0,level@l(6)
	lwz 9,84(31)
	xoris 0,0,0x8000
	stw 0,20(1)
	stw 5,16(1)
	lfd 0,16(1)
	lfs 13,3984(9)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L209
	lis 4,.LC66@ha
	mr 3,31
	la 4,.LC66@l(4)
	mr 5,30
	crxor 6,6,6
	bl safe_centerprintf
.L209:
	lwz 5,84(31)
	lis 4,.LC67@ha
	mr 6,30
	la 4,.LC67@l(4)
	li 3,2
	addi 5,5,700
	crxor 6,6,6
	bl my_bprintf
.L190:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 K2_RemoveKeyFromInventory,.Lfe6-K2_RemoveKeyFromInventory
	.section	".rodata"
	.align 2
.LC69:
	.string	"info_player_deathmatch"
	.align 2
.LC70:
	.string	"You got %i bonus frags!\n"
	.align 2
.LC71:
	.long 0x0
	.section	".text"
	.align 2
	.globl K2_BonusFrags
	.type	 K2_BonusFrags,@function
K2_BonusFrags:
	stwu 1,-368(1)
	mflr 0
	stfd 31,360(1)
	stmw 22,320(1)
	stw 0,372(1)
	mr 30,5
	mr 31,3
	lwz 9,84(30)
	mr 26,4
	li 27,0
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 4,2,.L239
	bl K2_IsBFK
	cmpwi 0,3,0
	bc 4,2,.L221
	mr 3,31
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L220
.L221:
	li 27,3
	b .L226
.L220:
	mr 3,31
	bl K2_IsFutility
	cmpwi 0,3,0
	bc 4,2,.L224
	mr 3,31
	bl K2_IsHoming
	cmpwi 0,3,0
	bc 12,2,.L228
.L224:
	li 27,2
	b .L226
.L239:
	mr 3,31
	bl K2_IsBFK
	cmpwi 0,3,0
	bc 4,2,.L228
	mr 3,31
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 4,2,.L228
	mr 3,31
	bl K2_IsHoming
	cmpwi 0,3,0
	bc 12,2,.L226
.L228:
	li 27,1
.L226:
	cmpwi 0,27,0
	bc 4,1,.L229
	lwz 11,84(30)
	li 28,0
	cmpw 0,28,27
	lwz 0,3464(11)
	add 0,0,27
	stw 0,3464(11)
	lwz 9,84(30)
	lwz 0,3516(9)
	add 0,0,27
	stw 0,3516(9)
	bc 4,0,.L236
	lis 9,.LC71@ha
	lis 22,botfraglogging@ha
	la 9,.LC71@l(9)
	lis 23,level@ha
	lfs 31,0(9)
	addi 29,1,8
	lis 24,gi@ha
	lis 25,qwfraglog@ha
.L233:
	lwz 0,968(30)
	cmpwi 0,0,0
	bc 4,2,.L232
	lwz 0,968(31)
	cmpwi 0,0,0
	bc 12,2,.L235
	lwz 9,botfraglogging@l(22)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L236
.L235:
	la 4,level@l(23)
	li 5,304
	mr 3,29
	crxor 6,6,6
	bl memcpy
	la 3,gi@l(24)
	mr 4,29
	mr 5,31
	mr 6,26
	mr 7,30
	bl sl_WriteStdLogDeath
	lwz 9,qwfraglog@l(25)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L232
	mr 3,31
	mr 4,26
	mr 5,30
	bl WriteQWLogDeath
.L232:
	addi 28,28,1
	cmpw 0,28,27
	bc 12,0,.L233
.L236:
	lis 4,.LC70@ha
	mr 3,30
	la 4,.LC70@l(4)
	mr 5,27
	crxor 6,6,6
	bl safe_centerprintf
.L229:
	lwz 0,372(1)
	mtlr 0
	lmw 22,320(1)
	lfd 31,360(1)
	la 1,368(1)
	blr
.Lfe7:
	.size	 K2_BonusFrags,.Lfe7-K2_BonusFrags
	.section	".rodata"
	.align 2
.LC72:
	.string	"No one around to take a key from\n"
	.align 2
.LC73:
	.string	"items/m_health.wav"
	.align 2
.LC74:
	.string	"%s took your key!\n"
	.align 2
.LC75:
	.string	"You took %s's key!\n"
	.align 2
.LC76:
	.long 0x0
	.align 2
.LC77:
	.long 0x447a0000
	.align 2
.LC78:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl K2_TakePlayerKey
	.type	 K2_TakePlayerKey,@function
K2_TakePlayerKey:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 25,44(1)
	stw 0,84(1)
	lis 9,.LC76@ha
	mr 31,3
	la 9,.LC76@l(9)
	li 30,0
	lfs 31,0(9)
	li 28,0
	li 27,0
	li 26,1000
	lis 25,ctf@ha
	li 29,4
.L244:
	lis 11,.LC77@ha
	mr 3,30
	la 11,.LC77@l(11)
	addi 4,31,4
	lfs 1,0(11)
	bl findradius
	mr. 30,3
	bc 12,2,.L243
	lwz 11,84(30)
	cmpwi 0,11,0
	bc 12,2,.L243
	cmpw 0,30,31
	bc 12,2,.L243
	lwz 0,3988(11)
	cmpwi 0,0,0
	bc 12,2,.L243
	lwz 9,ctf@l(25)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L249
	lwz 9,84(31)
	lwz 11,3468(11)
	lwz 0,3468(9)
	cmpw 0,11,0
	bc 12,2,.L243
.L249:
	mr 3,31
	mr 4,30
	bl IsVisible
	cmpwi 0,3,0
	bc 12,2,.L243
	lfs 0,4(30)
	addi 3,1,8
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(30)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(30)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	fctiwz 0,1
	stfd 0,32(1)
	lwz 0,36(1)
	cmpw 0,0,26
	bc 4,0,.L243
	mr 26,0
	mr 27,30
.L243:
	addic. 29,29,-1
	bc 4,2,.L244
	cmpwi 0,27,0
	bc 4,2,.L262
	lis 9,num_players@ha
	lis 30,num_players@ha
	lwz 0,num_players@l(9)
	cmpw 0,28,0
	bc 4,0,.L254
	lis 9,players@ha
	slwi 0,28,2
	la 9,players@l(9)
	add 29,0,9
.L257:
	lwz 27,0(29)
	addi 28,28,1
	addi 29,29,4
	lwz 0,968(27)
	xor 9,27,31
	subfic 11,9,0
	adde 9,11,9
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L259
	lwz 9,84(27)
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 12,2,.L259
	mr 3,31
	mr 4,27
	bl SameTeam
	cmpwi 0,3,0
	bc 4,2,.L259
	mr 3,31
	mr 4,27
	bl IsVisible
	cmpwi 0,3,0
	bc 4,2,.L254
.L259:
	lwz 0,num_players@l(30)
	li 27,0
	cmpw 0,28,0
	bc 12,0,.L257
.L254:
	cmpwi 0,27,0
	bc 4,2,.L262
	lis 5,.LC72@ha
	mr 3,31
	la 5,.LC72@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L240
.L262:
	mr 3,31
	li 29,0
	bl K2_RemoveKeyFromInventory
	li 28,0
	mr 30,27
	lwz 9,84(31)
	li 5,4
	mr 3,31
	lis 27,.LC73@ha
	lwz 4,3988(9)
	bl K2_SpawnKey
	lwz 11,84(31)
	mr 3,30
	stw 29,64(31)
	stw 29,68(31)
	stw 29,3988(11)
	lwz 9,84(31)
	stw 28,3980(9)
	lwz 11,84(31)
	stw 28,3984(11)
	lwz 9,84(30)
	lwz 11,84(31)
	lwz 0,3988(9)
	stw 0,3988(11)
	bl K2_RemoveKeyFromInventory
	lwz 11,84(30)
	stw 29,64(30)
	stw 29,68(30)
	stw 29,3988(11)
	lwz 9,84(30)
	stw 28,3980(9)
	lwz 11,84(30)
	stw 28,3984(11)
	lwz 9,84(31)
	lwz 3,3988(9)
	bl K2_SetClientKeyTimer
	lwz 9,84(31)
	lis 29,gi@ha
	la 3,.LC73@l(27)
	la 29,gi@l(29)
	stfs 1,3984(9)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC78@ha
	lwz 11,16(29)
	mr 5,3
	la 9,.LC78@l(9)
	li 4,3
	lfs 1,0(9)
	mtlr 11
	mr 3,31
	lis 9,.LC78@ha
	la 9,.LC78@l(9)
	lfs 2,0(9)
	lis 9,.LC76@ha
	la 9,.LC76@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,36(29)
	la 3,.LC73@l(27)
	mtlr 9
	blrl
	lis 9,.LC78@ha
	lwz 0,16(29)
	lis 11,.LC78@ha
	la 9,.LC78@l(9)
	mr 5,3
	lfs 1,0(9)
	la 11,.LC78@l(11)
	li 4,3
	mtlr 0
	lis 9,.LC76@ha
	mr 3,30
	lfs 2,0(11)
	la 9,.LC76@l(9)
	lfs 3,0(9)
	blrl
	lwz 5,84(31)
	lis 4,.LC74@ha
	mr 3,30
	la 4,.LC74@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_centerprintf
	lwz 5,84(30)
	lis 4,.LC75@ha
	mr 3,31
	la 4,.LC75@l(4)
	addi 5,5,700
	crxor 6,6,6
	bl safe_centerprintf
.L240:
	lwz 0,84(1)
	mtlr 0
	lmw 25,44(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe8:
	.size	 K2_TakePlayerKey,.Lfe8-K2_TakePlayerKey
	.section	".rodata"
	.align 2
.LC79:
	.string	"You can't have a key for\n%i more seconds\n"
	.align 2
.LC80:
	.string	"misc/secret.wav"
	.align 2
.LC81:
	.string	"Couldn't access QW Log File\n"
	.align 2
.LC82:
	.string	"/%s/%s/\n"
	.align 2
.LC83:
	.string	"No %s for %s.\n"
	.align 2
.LC84:
	.string	"Not enough %s for %s.\n"
	.align 3
.LC85:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC86:
	.long 0x41200000
	.align 2
.LC87:
	.long 0x0
	.section	".text"
	.align 2
	.globl K2_SetClientKeyTimer
	.type	 K2_SetClientKeyTimer,@function
K2_SetClientKeyTimer:
	stwu 1,-16(1)
	cmpwi 0,3,2
	bc 4,2,.L328
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 10,.LC86@ha
	lis 9,.LC85@ha
	la 10,.LC86@l(10)
	xoris 0,0,0x8000
	la 9,.LC85@l(9)
	lfs 12,0(10)
	stw 0,12(1)
	stw 8,8(1)
	lfd 13,0(9)
	lfd 1,8(1)
	lis 9,regentime@ha
	lwz 10,regentime@l(9)
	b .L344
.L328:
	cmpwi 0,3,16
	bc 4,2,.L330
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 10,.LC86@ha
	lis 9,.LC85@ha
	la 10,.LC86@l(10)
	xoris 0,0,0x8000
	la 9,.LC85@l(9)
	lfs 12,0(10)
	stw 0,12(1)
	stw 8,8(1)
	lfd 13,0(9)
	lfd 1,8(1)
	lis 9,hastetime@ha
	lwz 10,hastetime@l(9)
	b .L344
.L330:
	cmpwi 0,3,4
	bc 4,2,.L332
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 10,.LC86@ha
	lis 9,.LC85@ha
	la 10,.LC86@l(10)
	xoris 0,0,0x8000
	la 9,.LC85@l(9)
	lfs 12,0(10)
	stw 0,12(1)
	stw 8,8(1)
	lfd 13,0(9)
	lfd 1,8(1)
	lis 9,futilitytime@ha
	lwz 10,futilitytime@l(9)
	b .L344
.L332:
	cmpwi 0,3,8
	bc 4,2,.L334
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 10,.LC86@ha
	lis 9,.LC85@ha
	la 10,.LC86@l(10)
	xoris 0,0,0x8000
	la 9,.LC85@l(9)
	lfs 12,0(10)
	stw 0,12(1)
	stw 8,8(1)
	lfd 13,0(9)
	lfd 1,8(1)
	lis 9,inflictiontime@ha
	lwz 10,inflictiontime@l(9)
	b .L344
.L334:
	cmpwi 0,3,128
	bc 4,2,.L336
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 10,.LC86@ha
	lis 9,.LC85@ha
	la 10,.LC86@l(10)
	xoris 0,0,0x8000
	la 9,.LC85@l(9)
	lfs 12,0(10)
	stw 0,12(1)
	stw 8,8(1)
	lfd 13,0(9)
	lfd 1,8(1)
	lis 9,bfktime@ha
	lwz 10,bfktime@l(9)
	b .L344
.L336:
	cmpwi 0,3,32
	bc 4,2,.L338
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 10,.LC86@ha
	lis 9,.LC85@ha
	la 10,.LC86@l(10)
	xoris 0,0,0x8000
	la 9,.LC85@l(9)
	lfs 12,0(10)
	stw 0,12(1)
	stw 8,8(1)
	lfd 13,0(9)
	lfd 1,8(1)
	lis 9,stealthtime@ha
	lwz 10,stealthtime@l(9)
	b .L344
.L338:
	cmpwi 0,3,1
	bc 4,2,.L340
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 10,.LC86@ha
	lis 9,.LC85@ha
	la 10,.LC86@l(10)
	xoris 0,0,0x8000
	la 9,.LC85@l(9)
	lfs 12,0(10)
	stw 0,12(1)
	stw 8,8(1)
	lfd 13,0(9)
	lfd 1,8(1)
	lis 9,antitime@ha
	lwz 10,antitime@l(9)
	b .L344
.L340:
	cmpwi 0,3,64
	bc 12,2,.L329
	lis 9,.LC87@ha
	la 9,.LC87@l(9)
	lfs 1,0(9)
	b .L343
.L329:
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 8,0x4330
	lis 10,.LC85@ha
	la 10,.LC85@l(10)
	lis 9,homingtime@ha
	xoris 0,0,0x8000
	lfd 13,0(10)
	stw 0,12(1)
	lis 10,.LC86@ha
	stw 8,8(1)
	la 10,.LC86@l(10)
	lfd 1,8(1)
	lfs 12,0(10)
	lwz 10,homingtime@l(9)
.L344:
	fsub 1,1,13
	lfs 0,20(10)
	frsp 1,1
	fmadds 1,0,12,1
.L343:
	la 1,16(1)
	blr
.Lfe9:
	.size	 K2_SetClientKeyTimer,.Lfe9-K2_SetClientKeyTimer
	.section	".rodata"
	.align 2
.LC88:
	.string	"Blaster"
	.align 2
.LC89:
	.string	"Shotgun"
	.align 2
.LC90:
	.string	"Super Shotgun"
	.align 2
.LC91:
	.string	"Machinegun"
	.align 2
.LC92:
	.string	"Chaingun"
	.align 2
.LC93:
	.string	"Grenade Launcher"
	.align 2
.LC94:
	.string	"Rocket Launcher"
	.align 2
.LC95:
	.string	"Hyperblaster"
	.align 2
.LC96:
	.string	"Railgun"
	.align 2
.LC97:
	.string	"BFG10K"
	.align 2
.LC98:
	.string	"Combat Armor"
	.align 2
.LC99:
	.string	"Jacket Armor"
	.align 2
.LC100:
	.string	"Body Armor"
	.align 2
.LC101:
	.string	"***KEYS2 ERROR!! - Starting armor type is invalid!\n"
	.align 2
.LC102:
	.string	"Shells"
	.align 2
.LC103:
	.string	"Grenades"
	.align 2
.LC104:
	.string	"Rockets"
	.align 2
.LC105:
	.string	"Slugs"
	.align 2
.LC106:
	.string	"Cells"
	.align 2
.LC107:
	.string	"Bullets"
	.align 2
.LC108:
	.string	"Grapple"
	.align 2
.LC109:
	.long 0x0
	.section	".text"
	.align 2
	.globl K2_InitClientPersistant
	.type	 K2_InitClientPersistant,@function
K2_InitClientPersistant:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 21,28(1)
	stw 0,84(1)
	mr 31,3
	li 4,0
	li 5,1628
	addi 3,31,188
	crxor 6,6,6
	bl memset
	lis 29,0x286b
	addi 28,31,740
	lis 9,.LC109@ha
	lis 3,.LC88@ha
	la 9,.LC109@l(9)
	la 3,.LC88@l(3)
	lfs 31,0(9)
	ori 29,29,51739
	li 27,1
	bl FindItem
	lis 9,itemlist@ha
	lis 11,giveshotgun@ha
	la 26,itemlist@l(9)
	lwz 10,giveshotgun@l(11)
	subf 3,26,3
	mullw 3,3,29
	rlwinm 3,3,0,0,29
	stwx 27,28,3
	lfs 0,20(10)
	fcmpu 0,0,31
	bc 12,2,.L346
	lis 3,.LC89@ha
	la 3,.LC89@l(3)
	bl FindItem
	subf 3,26,3
	mullw 3,3,29
	rlwinm 3,3,0,0,29
	stwx 27,28,3
.L346:
	lis 9,givesupershotgun@ha
	lwz 11,givesupershotgun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L347
	lis 3,.LC90@ha
	la 3,.LC90@l(3)
	bl FindItem
	subf 3,26,3
	mullw 3,3,29
	rlwinm 3,3,0,0,29
	stwx 27,28,3
.L347:
	lis 9,givemachinegun@ha
	lwz 11,givemachinegun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L348
	lis 3,.LC91@ha
	la 3,.LC91@l(3)
	bl FindItem
	subf 3,26,3
	mullw 3,3,29
	rlwinm 3,3,0,0,29
	stwx 27,28,3
.L348:
	lis 9,givechaingun@ha
	lwz 11,givechaingun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L349
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	bl FindItem
	subf 3,26,3
	mullw 3,3,29
	rlwinm 3,3,0,0,29
	stwx 27,28,3
.L349:
	lis 9,givegrenadelauncher@ha
	lwz 11,givegrenadelauncher@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L350
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	bl FindItem
	subf 3,26,3
	mullw 3,3,29
	rlwinm 3,3,0,0,29
	stwx 27,28,3
.L350:
	lis 9,giverocketlauncher@ha
	lwz 11,giverocketlauncher@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L351
	lis 3,.LC94@ha
	la 3,.LC94@l(3)
	bl FindItem
	subf 3,26,3
	mullw 3,3,29
	rlwinm 3,3,0,0,29
	stwx 27,28,3
.L351:
	lis 9,givehyperblaster@ha
	lwz 11,givehyperblaster@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L352
	lis 3,.LC95@ha
	la 3,.LC95@l(3)
	bl FindItem
	subf 3,26,3
	mullw 3,3,29
	rlwinm 3,3,0,0,29
	stwx 27,28,3
.L352:
	lis 9,giverailgun@ha
	lwz 11,giverailgun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L353
	lis 3,.LC96@ha
	la 3,.LC96@l(3)
	bl FindItem
	subf 3,26,3
	mullw 3,3,29
	rlwinm 3,3,0,0,29
	stwx 27,28,3
.L353:
	lis 9,givebfg@ha
	lwz 11,givebfg@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L354
	lis 3,.LC97@ha
	la 3,.LC97@l(3)
	bl FindItem
	subf 3,26,3
	mullw 3,3,29
	rlwinm 3,3,0,0,29
	stwx 27,28,3
.L354:
	lis 9,startingarmorcount@ha
	mr 27,28
	lwz 11,startingarmorcount@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L355
	lis 11,startingarmortype@ha
	lwz 9,startingarmortype@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpwi 0,0,1
	bc 4,2,.L356
	lis 3,.LC98@ha
	la 3,.LC98@l(3)
	bl FindItem
	subf 3,26,3
	mullw 3,3,29
	srawi 0,3,2
	b .L357
.L356:
	cmpwi 0,0,2
	bc 4,2,.L358
	lis 3,.LC99@ha
	la 3,.LC99@l(3)
	b .L390
.L358:
	cmpwi 0,0,3
	bc 4,2,.L360
	lis 3,.LC100@ha
	la 3,.LC100@l(3)
.L390:
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	mullw 3,3,0
	srawi 0,3,2
	b .L357
.L360:
	li 0,0
.L357:
	cmpwi 0,0,0
	bc 12,2,.L362
	lis 11,startingarmorcount@ha
	lwz 10,startingarmorcount@l(11)
	slwi 0,0,2
	addi 11,31,740
	lfs 0,20(10)
	mr 27,11
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	stwx 9,11,0
	b .L355
.L362:
	lis 9,gi+4@ha
	lis 3,.LC101@ha
	lwz 0,gi+4@l(9)
	la 3,.LC101@l(3)
	addi 27,31,740
	mtlr 0
	crxor 6,6,6
	blrl
.L355:
	lis 11,.LC109@ha
	lis 9,startingshells@ha
	la 11,.LC109@l(11)
	lis 29,startingshells@ha
	lfs 31,0(11)
	lwz 11,startingshells@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L364
	lis 3,.LC102@ha
	la 3,.LC102@l(3)
	bl FindItem
	lwz 11,startingshells@l(29)
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	lfs 0,20(11)
	subf 3,9,3
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,27,3
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	add 0,0,11
	stwx 0,27,3
.L364:
	lis 9,startinggrenades@ha
	lwz 0,startinggrenades@l(9)
	cmpwi 0,0,0
	bc 12,2,.L365
	lis 3,.LC103@ha
	la 3,.LC103@l(3)
	bl FindItem
	lis 9,startinggrenades@ha
	lis 11,itemlist@ha
	lwz 10,startinggrenades@l(9)
	lis 0,0x286b
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 3,11,3
	lfs 0,20(10)
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,27,3
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	add 0,0,9
	stwx 0,27,3
.L365:
	lis 9,startingrockets@ha
	lwz 0,startingrockets@l(9)
	cmpwi 0,0,0
	bc 12,2,.L366
	lis 3,.LC104@ha
	la 3,.LC104@l(3)
	bl FindItem
	lis 9,startingrockets@ha
	lis 11,itemlist@ha
	lwz 10,startingrockets@l(9)
	lis 0,0x286b
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 3,11,3
	lfs 0,20(10)
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,27,3
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	add 0,0,9
	stwx 0,27,3
.L366:
	lis 9,startingslugs@ha
	lwz 0,startingslugs@l(9)
	cmpwi 0,0,0
	bc 12,2,.L367
	lis 3,.LC105@ha
	la 3,.LC105@l(3)
	bl FindItem
	lis 9,startingslugs@ha
	lis 11,itemlist@ha
	lwz 10,startingslugs@l(9)
	lis 0,0x286b
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 3,11,3
	lfs 0,20(10)
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,27,3
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	add 0,0,9
	stwx 0,27,3
.L367:
	lis 9,startingcells@ha
	lwz 0,startingcells@l(9)
	cmpwi 0,0,0
	bc 12,2,.L368
	lis 3,.LC106@ha
	la 3,.LC106@l(3)
	bl FindItem
	lis 9,startingcells@ha
	lis 11,itemlist@ha
	lwz 10,startingcells@l(9)
	lis 0,0x286b
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 3,11,3
	lfs 0,20(10)
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,27,3
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	add 0,0,9
	stwx 0,27,3
.L368:
	lis 9,startingbullets@ha
	lwz 0,startingbullets@l(9)
	cmpwi 0,0,0
	bc 12,2,.L369
	lis 3,.LC107@ha
	la 3,.LC107@l(3)
	bl FindItem
	lis 9,startingbullets@ha
	lis 11,itemlist@ha
	lwz 10,startingbullets@l(9)
	lis 0,0x286b
	la 11,itemlist@l(11)
	ori 0,0,51739
	subf 3,11,3
	lfs 0,20(10)
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,27,3
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	add 0,0,9
	stwx 0,27,3
.L369:
	lis 11,startingweapon@ha
	lwz 9,startingweapon@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpwi 0,0,1
	bc 4,2,.L370
	lis 3,.LC88@ha
	la 3,.LC88@l(3)
	bl FindItem
	b .L371
.L370:
	cmpwi 0,0,2
	bc 4,2,.L372
	lis 9,noshotgun@ha
	lwz 11,noshotgun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 4,2,.L372
	lis 9,giveshotgun@ha
	lwz 11,giveshotgun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L372
	lwz 9,startingshells@l(29)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L372
	lis 3,.LC89@ha
	la 3,.LC89@l(3)
	bl FindItem
	b .L371
.L372:
	lis 10,startingweapon@ha
	lwz 9,startingweapon@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	cmpwi 0,11,3
	bc 4,2,.L374
	lis 11,.LC109@ha
	lis 9,nosupershotgun@ha
	la 11,.LC109@l(11)
	lfs 13,0(11)
	lwz 11,nosupershotgun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L374
	lis 9,givesupershotgun@ha
	lwz 11,givesupershotgun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L374
	lis 10,startingshells@ha
	lwz 9,startingshells@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	cmpwi 0,11,1
	bc 4,1,.L374
	lis 3,.LC90@ha
	la 3,.LC90@l(3)
	bl FindItem
	b .L371
.L374:
	lis 10,startingweapon@ha
	lwz 9,startingweapon@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	cmpwi 0,11,4
	bc 4,2,.L376
	lis 11,.LC109@ha
	lis 9,nomachinegun@ha
	la 11,.LC109@l(11)
	lfs 13,0(11)
	lwz 11,nomachinegun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L376
	lis 9,givemachinegun@ha
	lwz 11,givemachinegun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L376
	lis 9,startingbullets@ha
	lwz 11,startingbullets@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L376
	lis 3,.LC91@ha
	la 3,.LC91@l(3)
	bl FindItem
	b .L371
.L376:
	lis 10,startingweapon@ha
	lwz 9,startingweapon@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	cmpwi 0,11,5
	bc 4,2,.L378
	lis 11,.LC109@ha
	lis 9,nochaingun@ha
	la 11,.LC109@l(11)
	lfs 13,0(11)
	lwz 11,nochaingun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L378
	lis 9,givechaingun@ha
	lwz 11,givechaingun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L378
	lis 9,startingbullets@ha
	lwz 11,startingbullets@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L378
	lis 3,.LC92@ha
	la 3,.LC92@l(3)
	bl FindItem
	b .L371
.L378:
	lis 10,startingweapon@ha
	lwz 9,startingweapon@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	cmpwi 0,11,6
	bc 4,2,.L380
	lis 11,.LC109@ha
	lis 9,nogrenadelauncher@ha
	la 11,.LC109@l(11)
	lfs 13,0(11)
	lwz 11,nogrenadelauncher@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L380
	lis 9,givegrenadelauncher@ha
	lwz 11,givegrenadelauncher@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L380
	lis 9,startinggrenades@ha
	lwz 11,startinggrenades@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L380
	lis 3,.LC93@ha
	la 3,.LC93@l(3)
	bl FindItem
	b .L371
.L380:
	lis 10,startingweapon@ha
	lwz 9,startingweapon@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	cmpwi 0,11,7
	bc 4,2,.L382
	lis 11,.LC109@ha
	lis 9,norocketlauncher@ha
	la 11,.LC109@l(11)
	lfs 13,0(11)
	lwz 11,norocketlauncher@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L382
	lis 9,giverocketlauncher@ha
	lwz 11,giverocketlauncher@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L382
	lis 9,startingrockets@ha
	lwz 11,startingrockets@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L382
	lis 3,.LC94@ha
	la 3,.LC94@l(3)
	bl FindItem
	b .L371
.L382:
	lis 10,startingweapon@ha
	lwz 9,startingweapon@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	cmpwi 0,11,8
	bc 4,2,.L384
	lis 11,.LC109@ha
	lis 9,nohyperblaster@ha
	la 11,.LC109@l(11)
	lfs 13,0(11)
	lwz 11,nohyperblaster@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L384
	lis 9,givehyperblaster@ha
	lwz 11,givehyperblaster@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L384
	lis 9,startingcells@ha
	lwz 11,startingcells@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L384
	lis 3,.LC95@ha
	la 3,.LC95@l(3)
	bl FindItem
	b .L371
.L384:
	lis 10,startingweapon@ha
	lwz 9,startingweapon@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	cmpwi 0,11,9
	bc 4,2,.L386
	lis 11,.LC109@ha
	lis 9,norailgun@ha
	la 11,.LC109@l(11)
	lfs 13,0(11)
	lwz 11,norailgun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L386
	lis 9,giverailgun@ha
	lwz 11,giverailgun@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L386
	lis 9,startingslugs@ha
	lwz 11,startingslugs@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L386
	lis 3,.LC96@ha
	la 3,.LC96@l(3)
	bl FindItem
	b .L371
.L386:
	lis 10,startingweapon@ha
	lwz 9,startingweapon@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	cmpwi 0,11,10
	bc 4,2,.L388
	lis 11,.LC109@ha
	lis 9,nobfg@ha
	la 11,.LC109@l(11)
	lfs 13,0(11)
	lwz 11,nobfg@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L388
	lis 9,givebfg@ha
	lwz 11,givebfg@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L388
	lis 10,startingcells@ha
	lwz 9,startingcells@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	cmpwi 0,11,49
	bc 4,1,.L388
	lis 3,.LC97@ha
	la 3,.LC97@l(3)
	bl FindItem
	b .L371
.L388:
	lis 3,.LC88@ha
	la 3,.LC88@l(3)
	bl FindItem
.L371:
	lis 29,itemlist@ha
	lis 28,0x286b
	stw 3,1792(31)
	la 29,itemlist@l(29)
	ori 28,28,51739
	stw 3,1788(31)
	subf 0,29,3
	mullw 0,0,28
	lis 3,.LC108@ha
	la 3,.LC108@l(3)
	srawi 0,0,2
	stw 0,736(31)
	bl FindItem
	subf 3,29,3
	lis 9,startinghealth@ha
	lwz 5,startinghealth@l(9)
	mullw 3,3,28
	li 21,1
	lis 8,maxbullets@ha
	lis 9,maxhealth@ha
	lis 29,maxshells@ha
	lwz 24,maxhealth@l(9)
	rlwinm 3,3,0,0,29
	stwx 21,27,3
	lis 9,maxrockets@ha
	mr 7,11
	lfs 0,20(5)
	lis 3,maxgrenades@ha
	mr 10,11
	lwz 27,maxbullets@l(8)
	mr 6,11
	mr 5,11
	lwz 26,maxshells@l(29)
	mr 4,11
	mr 28,11
	lwz 25,maxrockets@l(9)
	mr 29,11
	lis 8,maxcells@ha
	lwz 23,maxgrenades@l(3)
	lis 9,maxslugs@ha
	li 0,0
	lwz 3,maxcells@l(8)
	li 22,0
	fctiwz 13,0
	lwz 8,maxslugs@l(9)
	stfd 13,16(1)
	lwz 11,20(1)
	stw 11,724(31)
	lfs 0,20(24)
	fctiwz 11,0
	stfd 11,16(1)
	lwz 7,20(1)
	stw 7,728(31)
	lfs 0,20(27)
	fctiwz 12,0
	stfd 12,16(1)
	lwz 10,20(1)
	stw 10,1764(31)
	lfs 0,20(26)
	fctiwz 10,0
	stfd 10,16(1)
	lwz 6,20(1)
	stw 6,1768(31)
	lfs 0,20(25)
	fctiwz 9,0
	stfd 9,16(1)
	lwz 5,20(1)
	stw 5,1772(31)
	lfs 0,20(23)
	fctiwz 8,0
	stfd 8,16(1)
	lwz 4,20(1)
	stw 4,1776(31)
	lfs 0,20(3)
	fctiwz 7,0
	stfd 7,16(1)
	lwz 29,20(1)
	stw 29,1780(31)
	lfs 0,20(8)
	stw 0,3984(31)
	stw 21,720(31)
	stw 22,3988(31)
	stw 0,3980(31)
	fctiwz 6,0
	stfd 6,16(1)
	lwz 28,20(1)
	stw 28,1784(31)
	lwz 0,84(1)
	mtlr 0
	lmw 21,28(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe10:
	.size	 K2_InitClientPersistant,.Lfe10-K2_InitClientPersistant
	.align 2
	.globl K2_KeyType
	.type	 K2_KeyType,@function
K2_KeyType:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 4,.LC13@ha
	lwz 9,648(31)
	la 4,.LC13@l(4)
	lwz 3,40(9)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L392
	li 3,2
	b .L408
.L392:
	lwz 9,648(31)
	lis 4,.LC16@ha
	la 4,.LC16@l(4)
	lwz 3,40(9)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L394
	li 3,8
	b .L408
.L394:
	lwz 9,648(31)
	lis 4,.LC14@ha
	la 4,.LC14@l(4)
	lwz 3,40(9)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L396
	li 3,16
	b .L408
.L396:
	lwz 9,648(31)
	lis 4,.LC15@ha
	la 4,.LC15@l(4)
	lwz 3,40(9)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L398
	li 3,4
	b .L408
.L398:
	lwz 9,648(31)
	lis 4,.LC18@ha
	la 4,.LC18@l(4)
	lwz 3,40(9)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L400
	li 3,32
	b .L408
.L400:
	lwz 9,648(31)
	lis 4,.LC19@ha
	la 4,.LC19@l(4)
	lwz 3,40(9)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L402
	li 3,1
	b .L408
.L402:
	lwz 9,648(31)
	lis 4,.LC20@ha
	la 4,.LC20@l(4)
	lwz 3,40(9)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L404
	lwz 9,648(31)
	lis 4,.LC17@ha
	la 4,.LC17@l(4)
	lwz 3,40(9)
	bl Q_stricmp
	addic 3,3,-1
	subfe 3,3,3
	rlwinm 3,3,0,24,24
	b .L408
.L404:
	li 3,64
.L408:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 K2_KeyType,.Lfe11-K2_KeyType
	.section	".rodata"
	.align 3
.LC110:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC111:
	.long 0x0
	.section	".text"
	.align 2
	.globl K2_SetClientEffects
	.type	 K2_SetClientEffects,@function
K2_SetClientEffects:
	stwu 1,-16(1)
	lis 9,level@ha
	lwz 0,level@l(9)
	lis 10,0x4330
	lis 9,.LC110@ha
	xoris 0,0,0x8000
	la 9,.LC110@l(9)
	stw 0,12(1)
	stw 10,8(1)
	lfd 12,0(9)
	lfd 0,8(1)
	lwz 9,84(3)
	fsub 0,0,12
	lfs 13,3776(9)
	frsp 12,0
	fcmpu 0,13,12
	bc 12,1,.L411
	lfs 0,3772(9)
	fcmpu 0,0,12
	bc 4,1,.L410
.L411:
	li 7,4
	b .L412
.L410:
	li 7,8
.L412:
	lwz 9,84(3)
	lwz 0,3520(9)
	cmpwi 0,0,0
	bc 4,2,.L414
	lwz 0,968(3)
	cmpwi 0,0,0
	bc 12,2,.L413
.L414:
	li 0,0
	stw 0,184(3)
.L413:
	lwz 9,84(3)
	lwz 0,3508(9)
	cmpwi 0,0,0
	bc 12,2,.L415
	li 0,1
	stw 0,184(3)
	b .L409
.L415:
	cmpwi 0,9,0
	li 0,0
	bc 12,2,.L418
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 4,2,.L419
	li 0,0
	b .L418
.L419:
	xori 0,0,32
	subfic 11,0,0
	adde 0,11,0
.L418:
	cmpwi 0,0,0
	bc 12,2,.L416
	lwz 11,84(3)
	lwz 9,3760(11)
	addi 9,9,-3
	cmplwi 0,9,1
	bc 12,1,.L422
	lwz 0,68(3)
	li 9,0
	stw 9,184(3)
	andi. 0,0,160
	b .L478
.L422:
	lis 9,.LC111@ha
	lis 11,totalstealth@ha
	la 9,.LC111@l(9)
	lfs 13,0(9)
	lwz 9,totalstealth@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L424
	lwz 0,184(3)
	ori 0,0,1
	stw 0,184(3)
.L424:
	lwz 0,68(3)
	ori 0,0,160
.L478:
	stw 0,68(3)
.L416:
	lis 11,level@ha
	lwz 8,84(3)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC110@ha
	lfs 12,4020(8)
	xoris 0,0,0x8000
	la 11,.LC110@l(11)
	stw 0,12(1)
	stw 10,8(1)
	lfd 13,0(11)
	lfd 0,8(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L425
	li 9,0
	lis 0,0x100
	stw 9,184(3)
	stw 0,64(3)
	stw 9,68(3)
	b .L409
.L425:
	lis 11,.LC111@ha
	lwz 0,64(3)
	lis 9,ctf@ha
	la 11,.LC111@l(11)
	lfs 13,0(11)
	rlwinm 0,0,0,7,7
	lwz 11,ctf@l(9)
	stw 0,64(3)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L427
	lis 9,level@ha
	lwz 0,level@l(9)
	and. 9,0,7
	bc 4,2,.L409
.L427:
	cmpwi 0,8,0
	li 0,0
	bc 12,2,.L430
	lwz 0,3988(8)
	cmpwi 0,0,0
	bc 4,2,.L431
	li 0,0
	b .L430
.L431:
	xori 0,0,128
	subfic 11,0,0
	adde 0,11,0
.L430:
	cmpwi 0,0,0
	bc 12,2,.L428
	lwz 0,64(3)
	lwz 9,68(3)
	ori 0,0,320
	ori 9,9,1024
	stw 0,64(3)
	stw 9,68(3)
.L428:
	lis 9,.LC111@ha
	lis 11,playershells@ha
	la 9,.LC111@l(9)
	lfs 13,0(9)
	lwz 9,playershells@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L434
	lwz 0,84(3)
	cmpwi 0,0,0
	mr 9,0
	li 0,0
	bc 12,2,.L437
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 4,2,.L438
	li 0,0
	b .L437
.L438:
	xori 0,0,8
	subfic 11,0,0
	adde 0,11,0
.L437:
	cmpwi 0,0,0
	bc 12,2,.L435
	lwz 0,64(3)
	li 9,4096
	stw 9,68(3)
	ori 0,0,256
	b .L479
.L435:
	cmpwi 0,9,0
	li 0,0
	bc 12,2,.L444
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 4,2,.L445
	li 0,0
	b .L444
.L445:
	xori 0,0,16
	subfic 11,0,0
	adde 0,11,0
.L444:
	cmpwi 0,0,0
	bc 12,2,.L442
	lwz 0,64(3)
	li 9,3072
	stw 9,68(3)
	ori 0,0,256
	b .L479
.L442:
	cmpwi 0,9,0
	li 0,0
	bc 12,2,.L451
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 4,2,.L452
	li 0,0
	b .L451
.L452:
	xori 0,0,4
	subfic 11,0,0
	adde 0,11,0
.L451:
	cmpwi 0,0,0
	bc 12,2,.L449
	lwz 0,64(3)
	li 9,6144
	stw 9,68(3)
	ori 0,0,256
	b .L479
.L449:
	cmpwi 0,9,0
	li 0,0
	bc 12,2,.L458
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 4,2,.L459
	li 0,0
	b .L458
.L459:
	xori 0,0,2
	subfic 11,0,0
	adde 0,11,0
.L458:
	cmpwi 0,0,0
	bc 12,2,.L456
	lwz 0,64(3)
	li 9,5120
	stw 9,68(3)
	ori 0,0,256
	b .L479
.L456:
	cmpwi 0,9,0
	li 0,0
	bc 12,2,.L465
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 4,2,.L466
	li 0,0
	b .L465
.L466:
	xori 0,0,1
	subfic 9,0,0
	adde 0,9,0
.L465:
	cmpwi 0,0,0
	bc 12,2,.L463
	lwz 0,64(3)
	li 9,7168
	stw 9,68(3)
	ori 0,0,256
	b .L479
.L463:
	lwz 9,84(3)
	cmpwi 0,9,0
	li 0,0
	bc 12,2,.L472
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 4,2,.L473
	li 0,0
	b .L472
.L473:
	xori 0,0,64
	subfic 11,0,0
	adde 0,11,0
.L472:
	cmpwi 0,0,0
	bc 12,2,.L434
	lwz 0,64(3)
	li 9,2048
	stw 9,68(3)
	ori 0,0,320
.L479:
	stw 0,64(3)
.L434:
	lwz 11,84(3)
	lis 9,level+4@ha
	lfs 13,level+4@l(9)
	lfs 0,4056(11)
	fcmpu 0,0,13
	bc 4,1,.L476
	lwz 0,64(3)
	oris 0,0,0x2
	b .L480
.L476:
	lwz 0,64(3)
	rlwinm 0,0,0,15,13
.L480:
	stw 0,64(3)
.L409:
	la 1,16(1)
	blr
.Lfe12:
	.size	 K2_SetClientEffects,.Lfe12-K2_SetClientEffects
	.section	".rodata"
	.align 2
.LC112:
	.string	"You are in Chase Cam mode.\nPress Fire to follow a different player\n\nPress TAB for the game menu\nOR\nType \"join\" at the console"
	.align 2
.LC113:
	.string	"You are in Observer mode.\nPress TAB for the game menu\nOR\nType \"join\" at the console"
	.align 2
.LC114:
	.string	"You are in Spectator mode.\nType \"spectator 0\" at the console\nto rejoin the game"
	.align 2
.LC115:
	.string	"k_bluekey"
	.align 2
.LC116:
	.string	"k_redkey"
	.align 2
.LC117:
	.string	"k_security"
	.align 2
.LC118:
	.string	"k_datacd"
	.align 2
.LC119:
	.string	"k_powercube"
	.align 2
.LC120:
	.string	"k_dataspin"
	.align 2
.LC121:
	.string	"k_comhead"
	.align 2
.LC122:
	.string	"k_pyramid"
	.align 3
.LC123:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC124:
	.long 0x0
	.align 2
.LC125:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl K2_SetClientStats
	.type	 K2_SetClientStats,@function
K2_SetClientStats:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 28,24(1)
	stw 0,52(1)
	mr 31,3
	mr 28,4
	lwz 10,84(31)
	lis 29,level@ha
	lwz 0,3520(10)
	cmpwi 0,0,0
	bc 4,2,.L482
	lwz 0,3560(10)
	cmpwi 0,0,0
	bc 4,2,.L482
	lwz 0,level@l(29)
	lis 11,0x4330
	lis 7,.LC123@ha
	lfs 12,4060(10)
	xoris 0,0,0x8000
	la 7,.LC123@l(7)
	stw 0,20(1)
	stw 11,16(1)
	lfd 13,0(7)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,0,.L482
	lwz 0,3860(10)
	cmpwi 0,0,0
	bc 12,2,.L483
	lis 4,.LC112@ha
	la 4,.LC112@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	b .L484
.L483:
	lis 4,.LC113@ha
	mr 3,31
	la 4,.LC113@l(4)
	crxor 6,6,6
	bl safe_centerprintf
.L484:
	lis 10,level@ha
	lwz 8,84(31)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 7,.LC123@ha
	la 7,.LC123@l(7)
	addi 9,9,170
	lfd 13,0(7)
	xoris 9,9,0x8000
	stw 9,20(1)
	stw 0,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,4060(8)
.L482:
	lwz 10,84(31)
	lwz 0,3508(10)
	cmpwi 0,0,0
	bc 12,2,.L485
	lis 11,level@ha
	lfs 13,4060(10)
	lwz 0,level@l(11)
	lis 30,0x4330
	lis 8,.LC123@ha
	la 8,.LC123@l(8)
	xoris 0,0,0x8000
	lfd 31,0(8)
	stw 0,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,13,0
	bc 4,0,.L485
	lis 4,.LC114@ha
	mr 3,31
	la 4,.LC114@l(4)
	crxor 6,6,6
	bl safe_centerprintf
	lwz 9,level@l(29)
	lwz 10,84(31)
	addi 9,9,220
	xoris 9,9,0x8000
	stw 9,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	stfs 0,4060(10)
.L485:
	lis 11,timelimit@ha
	lis 7,.LC124@ha
	lwz 9,timelimit@l(11)
	la 7,.LC124@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L486
	lwz 11,84(31)
	lwz 0,3552(11)
	cmpwi 0,0,0
	bc 4,2,.L486
	lis 9,k2_timeleft@ha
	lwz 0,k2_timeleft@l(9)
	la 10,k2_timeleft@l(9)
	cmpwi 0,0,0
	bc 4,1,.L487
	lhz 9,2(10)
	addi 9,9,1
	sth 9,178(11)
	b .L489
.L487:
	lhz 0,2(10)
	sth 0,178(11)
	b .L489
.L486:
	lwz 9,84(31)
	li 0,0
	sth 0,178(9)
.L489:
	lis 9,ctf@ha
	lis 8,.LC124@ha
	lwz 10,84(31)
	lwz 11,ctf@l(9)
	la 8,.LC124@l(8)
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L490
	lis 9,capturelimit@ha
	lwz 11,capturelimit@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L490
	lwz 0,3552(10)
	cmpwi 0,0,0
	bc 4,2,.L490
	lis 9,k2_capsleft+2@ha
	lhz 0,k2_capsleft+2@l(9)
	sth 0,180(10)
	b .L491
.L490:
	lis 11,.LC124@ha
	lis 9,ctf@ha
	la 11,.LC124@l(11)
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L492
	lis 9,fraglimit@ha
	lwz 11,fraglimit@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L492
	lwz 0,3552(10)
	cmpwi 0,0,0
	bc 4,2,.L492
	lis 9,k2_fragsleft+2@ha
	lhz 0,k2_fragsleft+2@l(9)
	sth 0,180(10)
	b .L491
.L492:
	lwz 9,84(31)
	li 0,0
	sth 0,180(9)
.L491:
	lis 11,ctf@ha
	lis 7,.LC124@ha
	lwz 9,ctf@l(11)
	la 7,.LC124@l(7)
	lfs 13,0(7)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L494
	lwz 9,84(31)
	lhz 0,4054(9)
	sth 0,182(9)
.L494:
	lis 11,level@ha
	lwz 8,84(31)
	lwz 11,level@l(11)
	lis 10,0x4330
	lis 7,.LC123@ha
	la 7,.LC123@l(7)
	lfs 12,3984(8)
	xoris 0,11,0x8000
	lfd 13,0(7)
	stw 0,20(1)
	stw 10,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L495
	cmpwi 0,28,0
	bc 12,2,.L496
	andi. 0,11,8
	bc 12,2,.L497
	li 0,0
	sth 0,152(8)
	lwz 9,84(31)
	sth 0,176(9)
	b .L481
.L497:
	sth 0,138(8)
	lwz 9,84(31)
	sth 0,140(9)
.L496:
	lwz 0,84(31)
	cmpwi 0,0,0
	mr 10,0
	li 0,0
	bc 12,2,.L501
	lwz 0,3988(10)
	cmpwi 0,0,0
	bc 4,2,.L502
	li 0,0
	b .L501
.L502:
	xori 0,0,2
	subfic 8,0,0
	adde 0,8,0
.L501:
	cmpwi 0,0,0
	bc 12,2,.L499
	lis 9,gi+40@ha
	lis 3,.LC115@ha
	lwz 0,gi+40@l(9)
	la 3,.LC115@l(3)
	b .L556
.L499:
	cmpwi 0,10,0
	li 0,0
	bc 12,2,.L508
	lwz 0,3988(10)
	cmpwi 0,0,0
	bc 4,2,.L509
	li 0,0
	b .L508
.L509:
	xori 0,0,16
	subfic 7,0,0
	adde 0,7,0
.L508:
	cmpwi 0,0,0
	bc 12,2,.L506
	lis 9,gi+40@ha
	lis 3,.LC116@ha
	lwz 0,gi+40@l(9)
	la 3,.LC116@l(3)
	b .L556
.L506:
	cmpwi 0,10,0
	li 0,0
	bc 12,2,.L515
	lwz 0,3988(10)
	cmpwi 0,0,0
	bc 4,2,.L516
	li 0,0
	b .L515
.L516:
	xori 0,0,4
	subfic 7,0,0
	adde 0,7,0
.L515:
	cmpwi 0,0,0
	bc 12,2,.L513
	lis 9,gi+40@ha
	lis 3,.LC117@ha
	lwz 0,gi+40@l(9)
	la 3,.LC117@l(3)
	b .L556
.L513:
	cmpwi 0,10,0
	li 0,0
	bc 12,2,.L522
	lwz 0,3988(10)
	cmpwi 0,0,0
	bc 4,2,.L523
	li 0,0
	b .L522
.L523:
	xori 0,0,8
	subfic 7,0,0
	adde 0,7,0
.L522:
	cmpwi 0,0,0
	bc 12,2,.L520
	lis 9,gi+40@ha
	lis 3,.LC118@ha
	lwz 0,gi+40@l(9)
	la 3,.LC118@l(3)
	b .L556
.L520:
	cmpwi 0,10,0
	li 0,0
	bc 12,2,.L529
	lwz 0,3988(10)
	cmpwi 0,0,0
	bc 4,2,.L530
	li 0,0
	b .L529
.L530:
	xori 0,0,32
	subfic 7,0,0
	adde 0,7,0
.L529:
	cmpwi 0,0,0
	bc 12,2,.L527
	lis 9,gi+40@ha
	lis 3,.LC119@ha
	lwz 0,gi+40@l(9)
	la 3,.LC119@l(3)
	b .L556
.L527:
	cmpwi 0,10,0
	li 0,0
	bc 12,2,.L536
	lwz 0,3988(10)
	cmpwi 0,0,0
	bc 4,2,.L537
	li 0,0
	b .L536
.L537:
	xori 0,0,1
	subfic 7,0,0
	adde 0,7,0
.L536:
	cmpwi 0,0,0
	bc 12,2,.L534
	lis 9,gi+40@ha
	lis 3,.LC120@ha
	lwz 0,gi+40@l(9)
	la 3,.LC120@l(3)
	b .L556
.L534:
	cmpwi 0,10,0
	li 0,0
	bc 12,2,.L543
	lwz 0,3988(10)
	cmpwi 0,0,0
	bc 4,2,.L544
	li 0,0
	b .L543
.L544:
	xori 0,0,64
	subfic 7,0,0
	adde 0,7,0
.L543:
	cmpwi 0,0,0
	bc 12,2,.L541
	lis 9,gi+40@ha
	lis 3,.LC121@ha
	lwz 0,gi+40@l(9)
	la 3,.LC121@l(3)
	b .L556
.L541:
	lwz 9,84(31)
	cmpwi 0,9,0
	li 0,0
	bc 12,2,.L550
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 4,2,.L551
	li 0,0
	b .L550
.L551:
	xori 0,0,128
	subfic 7,0,0
	adde 0,7,0
.L550:
	cmpwi 0,0,0
	bc 12,2,.L554
	lis 9,gi+40@ha
	lis 3,.LC122@ha
	lwz 0,gi+40@l(9)
	la 3,.LC122@l(3)
.L556:
	mtlr 0
	blrl
	lwz 11,84(31)
	lis 10,level@ha
	lis 8,0x4330
	lis 7,.LC123@ha
	sth 3,152(11)
	la 7,.LC123@l(7)
	lwz 0,level@l(10)
	lis 11,.LC125@ha
	lfd 11,0(7)
	la 11,.LC125@l(11)
	xoris 0,0,0x8000
	lwz 7,84(31)
	stw 0,20(1)
	stw 8,16(1)
	lfd 13,16(1)
	lfs 0,3984(7)
	lfs 10,0(11)
	fsub 13,13,11
	mr 11,9
	frsp 13,13
	fsubs 0,0,13
	fdivs 0,0,10
	fctiwz 12,0
	stfd 12,16(1)
	lwz 11,20(1)
	sth 11,176(7)
	b .L554
.L495:
	li 0,0
	sth 0,152(8)
	lwz 9,84(31)
	sth 0,176(9)
.L554:
	lwz 11,84(31)
	li 0,0
	sth 0,174(11)
	lwz 9,84(31)
	lwz 0,3492(9)
	cmpwi 0,0,0
	bc 12,2,.L481
	mr 3,31
	bl CTFSetIDView
.L481:
	lwz 0,52(1)
	mtlr 0
	lmw 28,24(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe13:
	.size	 K2_SetClientStats,.Lfe13-K2_SetClientStats
	.section	".rodata"
	.align 2
.LC126:
	.string	"%s has entered the Fragfest\n"
	.align 2
.LC127:
	.string	"stdlogname"
	.align 2
.LC128:
	.string	"StdLog.log"
	.align 2
.LC129:
	.string	"TempStd.log"
	.align 2
.LC130:
	.string	"r+t"
	.align 2
.LC131:
	.string	"a+t"
	.align 2
.LC132:
	.string	"Couldn't open temporary file %s...logging OFF\n"
	.align 2
.LC133:
	.string	"stdlogfile"
	.align 2
.LC134:
	.string	"0"
	.align 2
.LC135:
	.string	"Verifying %s\n"
	.align 2
.LC136:
	.string	"%c"
	.align 2
.LC137:
	.string	""
	.align 2
.LC138:
	.string	"\t\tGameEnd"
	.align 2
.LC139:
	.string	"GameEnd is good\n"
	.align 2
.LC140:
	.string	"GameEnd is bad..adjusted\n"
	.align 2
.LC141:
	.string	"%s"
	.align 2
.LC142:
	.string	"\t\tGameEnd\t\t\t0.0\n"
	.align 2
.LC143:
	.string	"%s verify completed\n"
	.align 2
.LC144:
	.string	"%s verify failed\n"
	.section	".text"
	.align 2
	.globl K2_FixGSLogFile
	.type	 K2_FixGSLogFile,@function
K2_FixGSLogFile:
	stwu 1,-576(1)
	mflr 0
	mfcr 12
	stmw 19,524(1)
	stw 0,580(1)
	stw 12,520(1)
	lis 9,gi@ha
	lis 11,.LC128@ha
	la 31,gi@l(9)
	lis 3,.LC127@ha
	lwz 9,144(31)
	la 4,.LC128@l(11)
	la 3,.LC127@l(3)
	li 5,4
	mr 24,4
	mtlr 9
	li 27,0
	li 19,0
	blrl
	mr. 3,3
	lis 9,.LC129@ha
	la 20,.LC129@l(9)
	bc 12,2,.L571
	lwz 24,4(3)
.L571:
	lis 4,.LC130@ha
	mr 3,24
	la 4,.LC130@l(4)
	bl fopen
	mr 29,3
	lis 4,.LC131@ha
	la 4,.LC131@l(4)
	mr 3,20
	bl fopen
	cmpwi 0,29,0
	mr 26,3
	bc 12,2,.L570
	cmpwi 0,26,0
	bc 4,2,.L573
	lis 3,.LC132@ha
	mr 4,20
	la 3,.LC132@l(3)
	crxor 6,6,6
	bl printf
	lwz 0,152(31)
	lis 3,.LC133@ha
	lis 4,.LC134@ha
	la 3,.LC133@l(3)
	la 4,.LC134@l(4)
	mtlr 0
	blrl
	mr 3,29
	bl fclose
	b .L570
.L573:
	lis 3,.LC135@ha
	mr 4,24
	la 3,.LC135@l(3)
	addi 28,1,264
	crxor 6,6,6
	bl printf
	lhz 0,12(29)
	andi. 9,0,32
	bc 4,2,.L575
	lis 21,.LC136@ha
	addi 30,1,8
	lis 25,.LC136@ha
	li 22,0
	lis 23,.LC137@ha
.L576:
	li 31,0
	mr 3,29
	la 4,.LC136@l(21)
	addi 5,1,8
	crxor 6,6,6
	bl fscanf
.L580:
	lbzx 0,30,31
	cmpwi 7,31,254
	xori 0,0,10
	neg 0,0
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	srwi 0,0,31
	and. 11,0,9
	bc 12,2,.L578
	addi 31,31,1
	mr 3,29
	la 4,.LC136@l(25)
	add 5,30,31
	crxor 6,6,6
	bl fscanf
	lbzx 0,30,31
	cmpwi 0,0,10
	bc 4,2,.L580
.L578:
	addi 0,31,1
	mr 3,30
	stbx 22,30,0
	li 4,9
	bl strchr
	cmpwi 0,3,0
	bc 12,2,.L575
	mr 3,28
	mr 4,30
	bl strcpy
	addi 27,27,1
	lbz 0,.LC137@l(23)
	stb 0,8(1)
	lhz 9,12(29)
	andi. 0,9,32
	bc 12,2,.L576
.L575:
	lis 4,.LC138@ha
	mr 3,28
	la 4,.LC138@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L584
	lis 9,gi+4@ha
	lis 3,.LC139@ha
	lwz 0,gi+4@l(9)
	la 3,.LC139@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L585
.L584:
	lis 3,.LC140@ha
	li 19,1
	la 3,.LC140@l(3)
	addi 27,27,-1
	crxor 6,6,6
	bl printf
.L585:
	mr 3,29
	li 4,0
	li 5,0
	li 31,0
	bl fseek
	cmpwi 4,19,0
	cmpw 0,31,27
	bc 4,0,.L587
	lis 21,.LC136@ha
	addi 30,1,8
	lis 25,.LC136@ha
	lis 22,.LC141@ha
	li 23,0
.L589:
	mr 3,29
	la 4,.LC136@l(21)
	addi 5,1,8
	addi 28,31,1
	crxor 6,6,6
	bl fscanf
	li 31,0
.L593:
	lbzx 0,30,31
	cmpwi 7,31,254
	xori 0,0,10
	neg 0,0
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	srwi 0,0,31
	and. 11,0,9
	bc 12,2,.L591
	addi 31,31,1
	mr 3,29
	la 4,.LC136@l(25)
	add 5,30,31
	crxor 6,6,6
	bl fscanf
	lbzx 0,30,31
	cmpwi 0,0,10
	bc 4,2,.L593
.L591:
	addi 0,31,1
	mr 3,26
	stbx 23,30,0
	la 4,.LC141@l(22)
	mr 5,30
	crxor 6,6,6
	bl fprintf
	mr 31,28
	cmpw 0,31,27
	bc 12,0,.L589
.L587:
	bc 12,18,.L595
	lis 4,.LC142@ha
	mr 3,26
	la 4,.LC142@l(4)
	crxor 6,6,6
	bl fprintf
.L595:
	mr 3,26
	bl fclose
	mr 3,29
	bl fclose
	mr 3,24
	bl remove
	mr 3,20
	mr 4,24
	bl rename
	cmpwi 0,3,0
	bc 4,2,.L596
	lis 9,gi+4@ha
	lis 3,.LC143@ha
	lwz 0,gi+4@l(9)
	la 3,.LC143@l(3)
	mr 4,24
	mtlr 0
	crxor 6,6,6
	blrl
	b .L570
.L596:
	lis 9,gi+4@ha
	lis 3,.LC144@ha
	lwz 0,gi+4@l(9)
	la 3,.LC144@l(3)
	mr 4,24
	mtlr 0
	crxor 6,6,6
	blrl
.L570:
	lwz 0,580(1)
	lwz 12,520(1)
	mtlr 0
	lmw 19,524(1)
	mtcrf 8,12
	la 1,576(1)
	blr
.Lfe14:
	.size	 K2_FixGSLogFile,.Lfe14-K2_FixGSLogFile
	.section	".rodata"
	.align 2
.LC145:
	.string	"items/s_health.wav"
	.align 3
.LC146:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC147:
	.long 0x3f800000
	.align 2
.LC148:
	.long 0x40400000
	.align 2
.LC149:
	.long 0x0
	.section	".text"
	.align 2
	.globl K2_Regeneration
	.type	 K2_Regeneration,@function
K2_Regeneration:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 31,3
	lwz 28,84(31)
	cmpwi 0,28,0
	li 0,0
	bc 12,2,.L602
	lwz 0,3988(28)
	cmpwi 0,0,0
	bc 4,2,.L603
	li 0,0
	b .L602
.L603:
	xori 0,0,2
	subfic 9,0,0
	adde 0,9,0
.L602:
	cmpwi 0,0,0
	bc 4,2,.L600
	lwz 9,84(31)
	cmpwi 0,9,0
	li 0,0
	bc 12,2,.L607
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 4,2,.L608
	li 0,0
	b .L607
.L608:
	xori 0,0,128
	subfic 10,0,0
	adde 0,10,0
.L607:
	cmpwi 0,0,0
	bc 12,2,.L599
.L600:
	mr 3,31
	bl ArmorIndex
	mr. 30,3
	mfcr 29
	bc 12,2,.L611
	mr 3,30
	bl GetItemByIndex
	lwz 27,64(3)
.L611:
	lis 11,level@ha
	lwz 10,84(31)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC146@ha
	lfs 12,3980(10)
	xoris 0,0,0x8000
	la 11,.LC146@l(11)
	stw 0,20(1)
	stw 8,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	cror 3,2,0
	bc 4,3,.L599
	lwz 9,480(31)
	lwz 0,484(31)
	cmpw 0,9,0
	bc 12,0,.L614
	mtcrf 128,29
	bc 12,2,.L613
	slwi 10,30,2
	addi 9,28,740
	lwz 11,4(27)
	lwzx 0,9,10
	cmpw 0,0,11
	bc 4,0,.L613
.L614:
	lis 29,gi@ha
	lis 3,.LC145@ha
	la 29,gi@l(29)
	la 3,.LC145@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 0,16(29)
	lis 9,.LC147@ha
	lis 10,.LC148@ha
	lis 11,.LC149@ha
	mr 5,3
	la 9,.LC147@l(9)
	la 10,.LC148@l(10)
	mtlr 0
	la 11,.LC149@l(11)
	li 4,3
	lfs 1,0(9)
	mr 3,31
	lfs 2,0(10)
	lfs 3,0(11)
	blrl
.L613:
	lwz 11,480(31)
	lwz 9,484(31)
	cmpw 0,11,9
	bc 4,0,.L615
	addi 0,11,5
	cmpw 0,0,9
	stw 0,480(31)
	bc 4,1,.L615
	stw 9,480(31)
.L615:
	cmpwi 0,30,0
	bc 12,2,.L617
	slwi 3,30,2
	addi 9,28,740
	lwz 0,4(27)
	lwzx 11,9,3
	cmpw 0,11,0
	bc 4,0,.L617
	addi 0,11,5
	stwx 0,9,3
	lwz 11,4(27)
	cmpw 0,0,11
	bc 4,1,.L617
	stwx 11,9,3
.L617:
	lis 10,level@ha
	lwz 8,84(31)
	lwz 9,level@l(10)
	lis 0,0x4330
	lis 10,.LC146@ha
	addi 9,9,5
	la 10,.LC146@l(10)
	xoris 9,9,0x8000
	lfd 13,0(10)
	stw 9,20(1)
	stw 0,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,3980(8)
.L599:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe15:
	.size	 K2_Regeneration,.Lfe15-K2_Regeneration
	.section	".rodata"
	.align 2
.LC151:
	.string	""
	.globl memset
	.align 2
.LC152:
	.string	"game"
	.align 2
.LC153:
	.string	"baseq2"
	.align 2
.LC154:
	.string	"%s/connect.log"
	.align 2
.LC155:
	.string	"Couldn't open %s"
	.align 2
.LC156:
	.string	"ip"
	.align 2
.LC157:
	.string	"name"
	.align 2
.LC158:
	.string	"%s/%s\n"
	.align 2
.LC159:
	.string	"boss3/BS3ATCK2.WAV"
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.comm	last_trail_time,4,4
	.comm	bot_frametime,8,8
	.comm	max_bots,4,4
	.comm	last_bot_spawn,4,4
	.comm	bot_male_names_used,4,4
	.comm	bot_female_names_used,4,4
	.comm	bot_count,4,4
	.comm	bot_teams,256,4
	.comm	total_teams,4,4
	.comm	the_client,4,4
	.comm	num_players,4,4
	.comm	players,1024,4
	.comm	weapons_head,4,4
	.comm	health_head,4,4
	.comm	bonus_head,4,4
	.comm	ammo_head,4,4
	.comm	item_shells,4,4
	.comm	item_cells,4,4
	.comm	item_rockets,4,4
	.comm	item_grenades,4,4
	.comm	item_slugs,4,4
	.comm	item_bullets,4,4
	.comm	item_shotgun,4,4
	.comm	item_hyperblaster,4,4
	.comm	item_supershotgun,4,4
	.comm	item_grenadelauncher,4,4
	.comm	item_chaingun,4,4
	.comm	item_railgun,4,4
	.comm	item_machinegun,4,4
	.comm	item_bfg10k,4,4
	.comm	item_rocketlauncher,4,4
	.comm	item_blaster,4,4
	.comm	botinfo_list,4,4
	.comm	total_bots,4,4
	.comm	teambot_list,4,4
	.comm	paused,4,4
	.section	".text"
	.align 2
	.globl K2_InitClientVars
	.type	 K2_InitClientVars,@function
K2_InitClientVars:
	lwz 11,84(3)
	li 0,0
	li 10,0
	stw 0,4016(11)
	lwz 9,84(3)
	stw 0,4044(9)
	lwz 11,84(3)
	stw 0,4032(11)
	lwz 9,84(3)
	stw 10,4028(9)
	lwz 11,84(3)
	stw 10,4024(11)
	lwz 9,84(3)
	stw 0,3996(9)
	lwz 11,84(3)
	stw 0,4000(11)
	lwz 9,84(3)
	stw 0,4008(9)
	lwz 11,84(3)
	stw 10,4040(11)
	lwz 9,84(3)
	stw 10,4048(9)
	lwz 11,84(3)
	stw 0,4052(11)
	lwz 9,84(3)
	stw 10,4060(9)
	lwz 11,84(3)
	stw 10,4064(11)
	lwz 9,84(3)
	stw 10,4068(9)
	blr
.Lfe16:
	.size	 K2_InitClientVars,.Lfe16-K2_InitClientVars
	.align 2
	.globl K2_ResetClientKeyVars
	.type	 K2_ResetClientKeyVars,@function
K2_ResetClientKeyVars:
	lwz 11,84(3)
	li 0,0
	li 10,0
	stw 0,64(3)
	stw 0,68(3)
	stw 0,3988(11)
	lwz 9,84(3)
	stw 10,3980(9)
	lwz 11,84(3)
	stw 10,3984(11)
	blr
.Lfe17:
	.size	 K2_ResetClientKeyVars,.Lfe17-K2_ResetClientKeyVars
	.align 2
	.globl K2_Drop_Key
	.type	 K2_Drop_Key,@function
K2_Drop_Key:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 5,.LC54@ha
	li 4,2
	la 5,.LC54@l(5)
	crxor 6,6,6
	bl safe_cprintf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 K2_Drop_Key,.Lfe18-K2_Drop_Key
	.align 2
	.globl K2_RespawnKey
	.type	 K2_RespawnKey,@function
K2_RespawnKey:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	bl K2_KeyType
	mr 4,3
	li 5,3
	mr 3,29
	bl K2_SpawnKey
	mr 3,29
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe19:
	.size	 K2_RespawnKey,.Lfe19-K2_RespawnKey
	.align 2
	.globl K2_UseKey
	.type	 K2_UseKey,@function
K2_UseKey:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 5,.LC55@ha
	li 4,2
	la 5,.LC55@l(5)
	crxor 6,6,6
	bl safe_cprintf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe20:
	.size	 K2_UseKey,.Lfe20-K2_UseKey
	.align 2
	.globl K2_SelectRandomDeathmatchSpawnPoint
	.type	 K2_SelectRandomDeathmatchSpawnPoint,@function
K2_SelectRandomDeathmatchSpawnPoint:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	bl rand
	li 30,0
	srawi 0,3,31
	srwi 0,0,28
	add 0,3,0
	rlwinm 0,0,0,0,27
	subf 31,0,3
	cmpwi 0,31,0
	addi 31,31,-1
	bc 12,2,.L212
	lis 29,.LC69@ha
.L213:
	mr 3,30
	li 4,280
	la 5,.LC69@l(29)
	bl G_Find
	cmpwi 0,31,0
	mr 30,3
	addi 31,31,-1
	bc 4,2,.L213
.L212:
	cmpwi 0,30,0
	bc 4,2,.L215
	lis 5,.LC69@ha
	li 3,0
	la 5,.LC69@l(5)
	li 4,280
	bl G_Find
	mr 30,3
.L215:
	mr 3,30
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 K2_SelectRandomDeathmatchSpawnPoint,.Lfe21-K2_SelectRandomDeathmatchSpawnPoint
	.section	".rodata"
	.align 2
.LC161:
	.long 0x3e4ccccd
	.align 2
.LC162:
	.long 0x3f800000
	.align 2
.LC163:
	.long 0x40400000
	.align 2
.LC164:
	.long 0x0
	.section	".text"
	.align 2
	.globl K2_DropKeyCommand
	.type	 K2_DropKeyCommand,@function
K2_DropKeyCommand:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 29,12(1)
	stw 0,36(1)
	lis 9,.LC162@ha
	mr 31,3
	la 9,.LC162@l(9)
	lfs 31,0(9)
	lwz 9,84(31)
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 12,2,.L187
	bl K2_RemoveKeyFromInventory
	lwz 9,84(31)
	li 5,2
	mr 3,31
	lwz 4,3988(9)
	bl K2_SpawnKey
	mr 3,31
	bl K2_ResetClientKeyVars
	lis 9,pickuptime@ha
	lis 10,level+4@ha
	lwz 8,84(31)
	lwz 11,pickuptime@l(9)
	mr 3,31
	lfs 0,level+4@l(10)
	lfs 13,20(11)
	fadds 0,0,13
	stfs 0,4072(8)
	bl K2_IsStealth
	cmpwi 0,3,0
	bc 12,2,.L188
	lis 9,.LC161@ha
	lfs 31,.LC161@l(9)
.L188:
	lis 29,gi@ha
	lis 3,.LC57@ha
	la 29,gi@l(29)
	la 3,.LC57@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC163@ha
	lwz 0,16(29)
	mr 5,3
	fmr 1,31
	la 9,.LC163@l(9)
	li 4,0
	lfs 2,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC164@ha
	la 9,.LC164@l(9)
	lfs 3,0(9)
	blrl
	b .L189
.L187:
	lis 5,.LC58@ha
	mr 3,31
	la 5,.LC58@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L189:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 K2_DropKeyCommand,.Lfe22-K2_DropKeyCommand
	.section	".rodata"
	.align 2
.LC165:
	.long 0x3f800000
	.align 3
.LC166:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl K2_ChaseCam
	.type	 K2_ChaseCam,@function
K2_ChaseCam:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3972(9)
	cmpwi 0,0,0
	bc 12,2,.L558
	li 0,0
	stw 0,3972(9)
	bl K2Menu_Close
	b .L557
.L647:
	lwz 9,84(31)
	mr 3,31
	stw 11,3972(9)
	bl K2Menu_Close
	lwz 9,84(31)
	li 0,1
	stw 0,3976(9)
	b .L557
.L558:
	lis 11,.LC165@ha
	lis 9,maxclients@ha
	la 11,.LC165@l(11)
	li 10,1
	lfs 0,0(11)
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L557
	lis 9,g_edicts@ha
	fmr 12,13
	lis 8,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC166@ha
	la 9,.LC166@l(9)
	addi 11,11,1352
	lfd 13,0(9)
.L562:
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L561
	lwz 0,248(11)
	cmpwi 0,0,0
	bc 12,2,.L561
	lwz 0,968(11)
	cmpwi 0,0,0
	bc 12,2,.L647
.L561:
	addi 10,10,1
	xoris 0,10,0x8000
	addi 11,11,1352
	stw 0,20(1)
	stw 8,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L562
.L557:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 K2_ChaseCam,.Lfe23-K2_ChaseCam
	.align 2
	.globl K2_StartClient
	.type	 K2_StartClient,@function
K2_StartClient:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 8,84(31)
	lwz 10,3520(8)
	cmpwi 0,10,0
	bc 4,2,.L566
	lwz 0,184(31)
	li 9,1
	lis 11,gi+72@ha
	stw 9,260(31)
	ori 0,0,1
	stw 10,248(31)
	stw 0,184(31)
	stw 10,88(8)
	lwz 9,84(31)
	stw 10,3520(9)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	mr 3,31
	bl K2_OpenWelcomeMenu
	li 3,1
	b .L648
.L566:
	li 3,0
.L648:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe24:
	.size	 K2_StartClient,.Lfe24-K2_StartClient
	.section	".rodata"
	.align 3
.LC167:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC168:
	.long 0x0
	.section	".text"
	.align 2
	.globl K2_KeyExpiredCheck
	.type	 K2_KeyExpiredCheck,@function
K2_KeyExpiredCheck:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stw 31,36(1)
	stw 0,52(1)
	mr 31,3
	lwz 10,84(31)
	lwz 0,3988(10)
	cmpwi 0,0,0
	bc 12,2,.L621
	lis 11,level@ha
	lfs 13,3984(10)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC167@ha
	xoris 0,0,0x8000
	la 11,.LC167@l(11)
	stw 0,28(1)
	stw 10,24(1)
	lfd 12,0(11)
	lfd 0,24(1)
	lis 11,.LC168@ha
	la 11,.LC168@l(11)
	lfs 31,0(11)
	fsub 0,0,12
	frsp 0,0
	fsubs 13,13,0
	fcmpu 0,13,31
	cror 3,2,0
	bc 4,3,.L621
	bl K2_RemoveKeyFromInventory
	lwz 9,84(31)
	li 3,0
	li 5,0
	lwz 4,3988(9)
	bl K2_SpawnKey
	lwz 11,84(31)
	li 0,0
	stw 0,64(31)
	stw 0,68(31)
	stw 0,3988(11)
	lwz 9,84(31)
	stfs 31,3980(9)
	lwz 11,84(31)
	stfs 31,3984(11)
.L621:
	lwz 0,52(1)
	mtlr 0
	lwz 31,36(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe25:
	.size	 K2_KeyExpiredCheck,.Lfe25-K2_KeyExpiredCheck
	.section	".rodata"
	.align 2
.LC169:
	.long 0x461c4000
	.section	".text"
	.align 2
	.globl K2_ClearPrevOwner
	.type	 K2_ClearPrevOwner,@function
K2_ClearPrevOwner:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	li 3,0
	b .L624
.L626:
	lwz 0,648(3)
	cmpwi 0,0,0
	bc 12,2,.L624
	lwz 0,1332(3)
	cmpwi 0,0,0
	cmpw 7,0,31
	bc 12,2,.L624
	li 0,0
	bc 4,30,.L624
	stw 0,1332(3)
.L624:
	lis 9,.LC169@ha
	addi 4,31,4
	lfs 1,.LC169@l(9)
	bl findradius
	mr. 3,3
	bc 4,2,.L626
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe26:
	.size	 K2_ClearPrevOwner,.Lfe26-K2_ClearPrevOwner
	.align 2
	.globl K2_IsHaste
	.type	 K2_IsHaste,@function
K2_IsHaste:
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 4,2,.L267
	li 3,0
	blr
.L267:
	lwz 3,3988(3)
	cmpwi 0,3,0
	bc 12,2,.L268
	xori 3,3,16
	subfic 0,3,0
	adde 3,0,3
	blr
.L268:
	li 3,0
	blr
.Lfe27:
	.size	 K2_IsHaste,.Lfe27-K2_IsHaste
	.align 2
	.globl K2_IsRegen
	.type	 K2_IsRegen,@function
K2_IsRegen:
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 4,2,.L272
	li 3,0
	blr
.L272:
	lwz 3,3988(3)
	cmpwi 0,3,0
	bc 12,2,.L273
	xori 3,3,2
	subfic 0,3,0
	adde 3,0,3
	blr
.L273:
	li 3,0
	blr
.Lfe28:
	.size	 K2_IsRegen,.Lfe28-K2_IsRegen
	.align 2
	.globl K2_IsInfliction
	.type	 K2_IsInfliction,@function
K2_IsInfliction:
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 4,2,.L277
	li 3,0
	blr
.L277:
	lwz 3,3988(3)
	cmpwi 0,3,0
	bc 12,2,.L278
	xori 3,3,8
	subfic 0,3,0
	adde 3,0,3
	blr
.L278:
	li 3,0
	blr
.Lfe29:
	.size	 K2_IsInfliction,.Lfe29-K2_IsInfliction
	.align 2
	.globl K2_IsFutility
	.type	 K2_IsFutility,@function
K2_IsFutility:
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 4,2,.L282
	li 3,0
	blr
.L282:
	lwz 3,3988(3)
	cmpwi 0,3,0
	bc 12,2,.L283
	xori 3,3,4
	subfic 0,3,0
	adde 3,0,3
	blr
.L283:
	li 3,0
	blr
.Lfe30:
	.size	 K2_IsFutility,.Lfe30-K2_IsFutility
	.align 2
	.globl K2_IsHoming
	.type	 K2_IsHoming,@function
K2_IsHoming:
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 4,2,.L287
	li 3,0
	blr
.L287:
	lwz 3,3988(3)
	cmpwi 0,3,0
	bc 12,2,.L288
	xori 3,3,64
	subfic 0,3,0
	adde 3,0,3
	blr
.L288:
	li 3,0
	blr
.Lfe31:
	.size	 K2_IsHoming,.Lfe31-K2_IsHoming
	.align 2
	.globl K2_IsBFK
	.type	 K2_IsBFK,@function
K2_IsBFK:
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 4,2,.L292
	li 3,0
	blr
.L292:
	lwz 3,3988(3)
	cmpwi 0,3,0
	bc 12,2,.L293
	xori 3,3,128
	subfic 0,3,0
	adde 3,0,3
	blr
.L293:
	li 3,0
	blr
.Lfe32:
	.size	 K2_IsBFK,.Lfe32-K2_IsBFK
	.align 2
	.globl K2_IsAnti
	.type	 K2_IsAnti,@function
K2_IsAnti:
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 4,2,.L297
	li 3,0
	blr
.L297:
	lwz 3,3988(3)
	cmpwi 0,3,0
	bc 12,2,.L298
	xori 3,3,1
	subfic 0,3,0
	adde 3,0,3
	blr
.L298:
	li 3,0
	blr
.Lfe33:
	.size	 K2_IsAnti,.Lfe33-K2_IsAnti
	.align 2
	.globl K2_IsStealth
	.type	 K2_IsStealth,@function
K2_IsStealth:
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 4,2,.L302
	li 3,0
	blr
.L302:
	lwz 3,3988(3)
	cmpwi 0,3,0
	bc 12,2,.L303
	xori 3,3,32
	subfic 0,3,0
	adde 3,0,3
	blr
.L303:
	li 3,0
	blr
.Lfe34:
	.size	 K2_IsStealth,.Lfe34-K2_IsStealth
	.align 2
	.globl K2_IsProtected
	.type	 K2_IsProtected,@function
K2_IsProtected:
	lwz 11,84(3)
	cmpwi 0,11,0
	bc 12,2,.L307
	lis 9,level+4@ha
	lfs 13,4056(11)
	lfs 0,level+4@l(9)
	fcmpu 7,13,0
	mfcr 3
	rlwinm 3,3,30,1
	blr
.L307:
	li 3,0
	blr
.Lfe35:
	.size	 K2_IsProtected,.Lfe35-K2_IsProtected
	.section	".rodata"
	.align 2
.LC170:
	.long 0x0
	.align 3
.LC171:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC172:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl K2_CanPickupKey
	.type	 K2_CanPickupKey,@function
K2_CanPickupKey:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	lis 30,level@ha
	lwz 11,84(31)
	la 9,level@l(30)
	lfs 10,4(9)
	lfs 11,4072(11)
	fcmpu 0,11,10
	bc 4,1,.L311
	lis 9,.LC170@ha
	lfs 12,4060(11)
	la 9,.LC170@l(9)
	lfs 0,0(9)
	fcmpu 0,12,0
	bc 12,2,.L313
	lwz 0,level@l(30)
	lis 11,0x4330
	lis 10,.LC171@ha
	xoris 0,0,0x8000
	la 10,.LC171@l(10)
	stw 0,28(1)
	stw 11,24(1)
	lfd 13,0(10)
	lfd 0,24(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,1,.L312
.L313:
	fsubs 0,11,10
	lis 4,.LC79@ha
	la 4,.LC79@l(4)
	mr 3,31
	fctiwz 13,0
	stfd 13,24(1)
	lwz 5,28(1)
	crxor 6,6,6
	bl safe_centerprintf
	lis 29,gi@ha
	lis 3,.LC80@ha
	la 29,gi@l(29)
	la 3,.LC80@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC172@ha
	lwz 0,16(29)
	lis 10,.LC172@ha
	la 9,.LC172@l(9)
	la 10,.LC172@l(10)
	lfs 1,0(9)
	mr 5,3
	mtlr 0
	li 4,3
	lis 9,.LC170@ha
	lfs 2,0(10)
	mr 3,31
	la 9,.LC170@l(9)
	lfs 3,0(9)
	blrl
	lwz 9,level@l(30)
	lis 0,0x4330
	lis 10,.LC171@ha
	addi 9,9,30
	la 10,.LC171@l(10)
	xoris 9,9,0x8000
	lfd 13,0(10)
	stw 9,28(1)
	stw 0,24(1)
	lfd 0,24(1)
	lwz 10,84(31)
	fsub 0,0,13
	frsp 0,0
	stfs 0,4060(10)
.L312:
	li 3,0
	b .L658
.L311:
	li 3,1
.L658:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe36:
	.size	 K2_CanPickupKey,.Lfe36-K2_CanPickupKey
	.section	".rodata"
	.align 2
.LC173:
	.long 0x0
	.section	".text"
	.align 2
	.globl WriteQWLogDeath
	.type	 WriteQWLogDeath,@function
WriteQWLogDeath:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 11,.LC173@ha
	lis 9,qwfraglog@ha
	la 11,.LC173@l(11)
	mr 30,3
	lfs 13,0(11)
	mr 31,5
	lwz 11,qwfraglog@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L315
	lis 9,QWLogFile@ha
	lis 29,QWLogFile@ha
	lwz 0,QWLogFile@l(9)
	cmpwi 0,0,0
	bc 4,2,.L317
	lis 9,gi+28@ha
	lis 3,.LC81@ha
	lwz 0,gi+28@l(9)
	la 3,.LC81@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L317:
	cmpw 0,31,30
	bc 4,2,.L318
	lwz 5,84(30)
	lis 4,.LC82@ha
	lwz 3,QWLogFile@l(29)
	la 4,.LC82@l(4)
	addi 5,5,700
	mr 6,5
	crxor 6,6,6
	bl fprintf
	b .L315
.L318:
	cmpwi 0,31,0
	bc 12,2,.L320
	lwz 5,84(31)
	cmpwi 0,5,0
	bc 12,2,.L320
	lwz 6,84(30)
	lis 4,.LC82@ha
	addi 5,5,700
	lwz 3,QWLogFile@l(29)
	la 4,.LC82@l(4)
	addi 6,6,700
	crxor 6,6,6
	bl fprintf
	b .L315
.L320:
	lwz 5,84(30)
	lis 9,QWLogFile@ha
	lis 4,.LC82@ha
	lwz 3,QWLogFile@l(9)
	la 4,.LC82@l(4)
	addi 5,5,700
	mr 6,5
	crxor 6,6,6
	bl fprintf
.L315:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe37:
	.size	 WriteQWLogDeath,.Lfe37-WriteQWLogDeath
	.align 2
	.globl DummyThink
	.type	 DummyThink,@function
DummyThink:
	blr
.Lfe38:
	.size	 DummyThink,.Lfe38-DummyThink
	.section	".rodata"
	.align 2
.LC174:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cycle_Weapon
	.type	 Cycle_Weapon,@function
Cycle_Weapon:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lwz 9,84(31)
	lwz 0,1788(9)
	cmpw 0,30,0
	bc 12,2,.L322
	li 0,0
	stw 0,4044(9)
	lwz 9,84(31)
	stw 0,4032(9)
	lwz 11,84(31)
	stw 0,4016(11)
	lwz 3,52(30)
	cmpwi 0,3,0
	bc 12,2,.L324
	lis 9,.LC174@ha
	lis 11,g_select_empty@ha
	la 9,.LC174@l(9)
	lfs 13,0(9)
	lwz 9,g_select_empty@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L324
	lwz 0,56(30)
	andi. 9,0,2
	bc 4,2,.L324
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,3
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 9,11,9
	cmpwi 0,9,0
	bc 4,2,.L325
	lwz 6,40(3)
	lis 5,.LC83@ha
	li 4,2
	lwz 7,40(30)
	mr 3,31
	la 5,.LC83@l(5)
	crxor 6,6,6
	bl safe_cprintf
	b .L322
.L325:
	lwz 0,48(30)
	cmpw 0,9,0
	bc 4,0,.L324
	lwz 6,40(3)
	lis 5,.LC84@ha
	li 4,2
	lwz 7,40(30)
	mr 3,31
	la 5,.LC84@l(5)
	crxor 6,6,6
	bl safe_cprintf
	b .L322
.L324:
	lwz 9,84(31)
	stw 30,3596(9)
.L322:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe39:
	.size	 Cycle_Weapon,.Lfe39-Cycle_Weapon
	.align 2
	.globl K2EnterGame
	.type	 K2EnterGame,@function
K2EnterGame:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 9,84(31)
	lwz 0,3860(9)
	cmpwi 0,0,0
	bc 12,2,.L568
	li 0,0
	stw 0,3860(9)
	bl botAddPlayer
.L568:
	mr 3,31
	bl K2Menu_Close
	lwz 0,184(31)
	li 11,1
	mr 3,31
	lwz 9,84(31)
	rlwinm 0,0,0,0,30
	stw 0,184(31)
	stw 11,3520(9)
	bl PutClientInServer
	lwz 11,84(31)
	li 0,6
	li 9,32
	stw 0,80(31)
	li 10,14
	lis 4,.LC126@ha
	stb 9,16(11)
	la 4,.LC126@l(4)
	li 3,2
	lwz 9,84(31)
	stb 10,17(9)
	lwz 5,84(31)
	addi 5,5,700
	crxor 6,6,6
	bl my_bprintf
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe40:
	.size	 K2EnterGame,.Lfe40-K2EnterGame
	.align 2
	.globl K2_LogPlayerIP
	.type	 K2_LogPlayerIP,@function
K2_LogPlayerIP:
	stwu 1,-96(1)
	mflr 0
	stmw 29,84(1)
	stw 0,100(1)
	lis 9,.LC151@ha
	mr 30,3
	lbz 0,.LC151@l(9)
	addi 3,1,9
	li 4,0
	li 5,49
	stb 0,8(1)
	crxor 6,6,6
	bl memset
	lis 9,gi@ha
	lis 3,.LC152@ha
	la 29,gi@l(9)
	lis 4,.LC153@ha
	lwz 9,144(29)
	la 4,.LC153@l(4)
	li 5,4
	la 3,.LC152@l(3)
	mtlr 9
	blrl
	lwz 5,4(3)
	lis 4,.LC154@ha
	la 4,.LC154@l(4)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	lis 4,.LC131@ha
	addi 3,1,8
	la 4,.LC131@l(4)
	bl fopen
	mr. 31,3
	bc 4,2,.L632
	lwz 0,4(29)
	lis 3,.LC155@ha
	addi 4,1,8
	la 3,.LC155@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L631
.L632:
	lis 4,.LC156@ha
	mr 3,30
	la 4,.LC156@l(4)
	bl Info_ValueForKey
	mr 29,3
	lis 4,.LC157@ha
	la 4,.LC157@l(4)
	mr 3,30
	bl Info_ValueForKey
	mr 5,3
	lis 4,.LC158@ha
	mr 6,29
	la 4,.LC158@l(4)
	mr 3,31
	crxor 6,6,6
	bl fprintf
	mr 3,31
	bl fclose
.L631:
	lwz 0,100(1)
	mtlr 0
	lmw 29,84(1)
	la 1,96(1)
	blr
.Lfe41:
	.size	 K2_LogPlayerIP,.Lfe41-K2_LogPlayerIP
	.section	".rodata"
	.align 2
.LC175:
	.long 0x3f4ccccd
	.align 2
.LC176:
	.long 0x3f800000
	.align 2
.LC177:
	.long 0x0
	.section	".text"
	.align 2
	.globl K2ApplyHasteSound
	.type	 K2ApplyHasteSound,@function
K2ApplyHasteSound:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 9,84(31)
	cmpwi 0,9,0
	li 0,0
	bc 12,2,.L638
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 4,2,.L639
	li 0,0
	b .L638
.L639:
	xori 0,0,16
	subfic 9,0,0
	adde 0,9,0
.L638:
	cmpwi 0,0,0
	bc 4,2,.L636
	lwz 9,84(31)
	cmpwi 0,9,0
	li 0,0
	bc 12,2,.L643
	lwz 0,3988(9)
	cmpwi 0,0,0
	bc 4,2,.L644
	li 0,0
	b .L643
.L644:
	xori 0,0,128
	subfic 9,0,0
	adde 0,9,0
.L643:
	cmpwi 0,0,0
	bc 12,2,.L635
.L636:
	lis 29,gi@ha
	lis 3,.LC159@ha
	la 29,gi@l(29)
	la 3,.LC159@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC175@ha
	lwz 0,16(29)
	mr 5,3
	lfs 1,.LC175@l(9)
	mr 3,31
	li 4,0
	lis 9,.LC176@ha
	mtlr 0
	la 9,.LC176@l(9)
	lfs 2,0(9)
	lis 9,.LC177@ha
	la 9,.LC177@l(9)
	lfs 3,0(9)
	blrl
.L635:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe42:
	.size	 K2ApplyHasteSound,.Lfe42-K2ApplyHasteSound
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
