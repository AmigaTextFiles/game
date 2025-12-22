	.file	"usa_weapon.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 GlobalUserDLLList,@object
	.size	 GlobalUserDLLList,4
GlobalUserDLLList:
	.long 0
	.section	".data"
	.align 2
	.type	 pause_frames.6,@object
pause_frames.6:
	.long 0
	.section	".sbss","aw",@nobits
	.align 2
fire_frames.7:
	.space	4
	.size	 fire_frames.7,4
	.section	".rodata"
	.align 2
.LC0:
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_Colt45
	.type	 Weapon_Colt45,@function
Weapon_Colt45:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	lwz 10,84(3)
	lis 9,usa_index@ha
	lis 7,fire_frames.7@ha
	lwz 11,usa_index@l(9)
	li 6,0
	lwz 0,4392(10)
	mulli 11,11,48
	addic 0,0,-1
	subfe 0,0,0
	nor 9,0,0
	addi 11,11,4400
	andi. 9,9,75
	rlwinm 0,0,0,29,29
	or 0,0,9
	stw 0,fire_frames.7@l(7)
	lwz 8,84(3)
	add 9,8,11
	addi 9,9,4
	stw 9,4500(8)
	lwz 10,84(3)
	add 11,10,11
	stw 11,4496(10)
	lwz 9,84(3)
	stw 6,4528(9)
	lwz 11,84(3)
	lwz 0,4192(11)
	subfic 10,0,0
	adde 9,10,0
	xori 0,0,3
	subfic 10,0,0
	adde 0,10,0
	or. 10,0,9
	bc 12,2,.L9
	lis 9,.LC0@ha
	lfs 13,4684(11)
	la 9,.LC0@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L9
	lwz 0,4132(11)
	andi. 10,0,1
	bc 12,2,.L9
	lwz 0,4392(11)
	lwz 9,92(11)
	cmpwi 0,0,0
	bc 12,2,.L10
	cmpwi 0,9,74
	bc 4,2,.L11
	b .L9
.L10:
	cmpwi 0,9,3
	bc 12,2,.L9
.L11:
	lwz 9,84(3)
	lwz 0,4392(9)
	mr 11,9
	lwz 10,92(9)
	cmpwi 0,0,0
	bc 12,2,.L12
	cmpwi 0,10,75
	bc 4,2,.L13
	b .L9
.L12:
	cmpwi 0,10,4
	bc 12,2,.L9
.L13:
	lwz 0,4392(11)
	lwz 9,92(11)
	cmpwi 0,0,0
	bc 12,2,.L14
	cmpwi 0,9,76
	bc 4,2,.L15
	b .L9
.L14:
	cmpwi 0,9,5
	bc 12,2,.L9
.L15:
	lwz 0,4392(11)
	lwz 9,92(11)
	cmpwi 0,0,0
	bc 12,2,.L16
	cmpwi 0,9,77
	bc 4,2,.L17
	b .L9
.L16:
	cmpwi 0,9,6
	bc 12,2,.L9
.L17:
	lwz 9,84(3)
	lwz 0,92(9)
	cmpwi 0,0,3
	bc 12,1,.L18
	li 0,4
	stw 0,92(9)
.L18:
	lwz 9,84(3)
	li 0,0
	lis 10,0x3f80
	stw 0,4192(9)
	lwz 11,84(3)
	lwz 0,4140(11)
	ori 0,0,1
	stw 0,4140(11)
	lwz 9,84(3)
	stw 10,4684(9)
	b .L19
.L9:
	lwz 9,84(3)
	lwz 0,4132(9)
	rlwinm 0,0,0,0,30
	stw 0,4132(9)
	lwz 11,84(3)
	lwz 0,4140(11)
	rlwinm 0,0,0,0,30
	stw 0,4140(11)
.L19:
	lis 9,Weapon_Generic@ha
	lis 11,Weapon_Pistol_Fire@ha
	lwz 12,Weapon_Generic@l(9)
	li 4,3
	li 5,6
	lwz 0,Weapon_Pistol_Fire@l(11)
	li 6,47
	li 7,62
	li 8,65
	li 9,69
	mtlr 12
	li 10,74
	stw 0,24(1)
	lis 11,pause_frames.6@ha
	lis 29,fire_frames.7@ha
	la 11,pause_frames.6@l(11)
	la 29,fire_frames.7@l(29)
	li 0,77
	stw 11,16(1)
	li 28,88
	stw 0,8(1)
	stw 28,12(1)
	stw 29,20(1)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 Weapon_Colt45,.Lfe1-Weapon_Colt45
	.section	".data"
	.align 2
	.type	 pause_frames.11,@object
pause_frames.11:
	.long 0
	.section	".sbss","aw",@nobits
	.align 2
fire_frames.12:
	.space	4
	.size	 fire_frames.12,4
	.section	".rodata"
	.align 2
.LC1:
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_m1
	.type	 Weapon_m1,@function
Weapon_m1:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	lwz 8,84(3)
	lis 10,usa_index@ha
	lis 7,fire_frames.12@ha
	lwz 9,usa_index@l(10)
	li 6,0
	lwz 11,4392(8)
	mulli 9,9,48
	srawi 10,11,31
	xor 0,10,11
	subf 0,0,10
	srawi 0,0,31
	andi. 0,0,76
	ori 0,0,4
	stw 0,fire_frames.12@l(7)
	lwz 10,84(3)
	add 9,9,10
	addi 9,9,4416
	stw 9,4496(10)
	lwz 11,84(3)
	stw 6,4528(11)
	lwz 11,84(3)
	lwz 0,4192(11)
	subfic 10,0,0
	adde 9,10,0
	xori 0,0,3
	subfic 10,0,0
	adde 0,10,0
	or. 10,0,9
	bc 12,2,.L23
	lis 9,.LC1@ha
	lfs 13,4684(11)
	la 9,.LC1@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L23
	lwz 0,4132(11)
	andi. 10,0,1
	bc 12,2,.L23
	lwz 0,4392(11)
	lwz 9,92(11)
	cmpwi 0,0,0
	bc 12,2,.L24
	cmpwi 0,9,75
	bc 4,2,.L25
	b .L23
.L24:
	cmpwi 0,9,3
	bc 12,2,.L23
.L25:
	lwz 9,84(3)
	lwz 0,4392(9)
	mr 11,9
	lwz 10,92(9)
	cmpwi 0,0,0
	bc 12,2,.L26
	cmpwi 0,10,76
	bc 4,2,.L27
	b .L23
.L26:
	cmpwi 0,10,4
	bc 12,2,.L23
.L27:
	lwz 0,4392(11)
	lwz 9,92(11)
	cmpwi 0,0,0
	bc 12,2,.L28
	cmpwi 0,9,77
	bc 4,2,.L29
	b .L23
.L28:
	cmpwi 0,9,5
	bc 12,2,.L23
.L29:
	lwz 0,4392(11)
	lwz 9,92(11)
	cmpwi 0,0,0
	bc 12,2,.L30
	cmpwi 0,9,78
	bc 4,2,.L31
	b .L23
.L30:
	cmpwi 0,9,6
	bc 12,2,.L23
.L31:
	lwz 9,84(3)
	lwz 0,92(9)
	cmpwi 0,0,3
	bc 12,1,.L32
	li 0,4
	stw 0,92(9)
.L32:
	lwz 11,84(3)
	li 0,0
	lis 10,0x3f80
	stw 0,4192(11)
	lwz 9,84(3)
	stw 10,4684(9)
	b .L33
.L23:
	lwz 9,84(3)
	lwz 0,4132(9)
	rlwinm 0,0,0,0,30
	stw 0,4132(9)
	lwz 11,84(3)
	lwz 0,4140(11)
	rlwinm 0,0,0,0,30
	stw 0,4140(11)
.L33:
	lis 9,Weapon_Generic@ha
	lis 11,Weapon_Rifle_Fire@ha
	lwz 12,Weapon_Generic@l(9)
	li 4,3
	li 5,6
	lwz 0,Weapon_Rifle_Fire@l(11)
	li 6,47
	li 7,64
	li 8,67
	li 9,72
	mtlr 12
	li 10,75
	stw 0,24(1)
	lis 11,pause_frames.11@ha
	lis 29,fire_frames.12@ha
	la 11,pause_frames.11@l(11)
	la 29,fire_frames.12@l(29)
	li 0,78
	stw 11,16(1)
	li 28,89
	stw 0,8(1)
	stw 28,12(1)
	stw 29,20(1)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe2:
	.size	 Weapon_m1,.Lfe2-Weapon_m1
	.section	".data"
	.align 2
	.type	 pause_frames.16,@object
pause_frames.16:
	.long 0
	.section	".sbss","aw",@nobits
	.align 2
fire_frames.17:
	.space	8
	.size	 fire_frames.17,8
	.section	".data"
	.align 2
	.type	 pause_frames.21,@object
pause_frames.21:
	.long 0
	.section	".sbss","aw",@nobits
	.align 2
fire_frames.22:
	.space	8
	.size	 fire_frames.22,8
	.section	".data"
	.align 2
	.type	 pause_frames.26,@object
pause_frames.26:
	.long 0
	.section	".sbss","aw",@nobits
	.align 2
fire_frames.27:
	.space	8
	.size	 fire_frames.27,8
	.section	".data"
	.align 2
	.type	 pause_frames.31,@object
pause_frames.31:
	.long 0
	.section	".sbss","aw",@nobits
	.align 2
fire_frames.32:
	.space	4
	.size	 fire_frames.32,4
	.section	".data"
	.align 2
	.type	 pause_frames.36,@object
pause_frames.36:
	.long 0
	.lcomm	fire_frames.37,16,4
	.section	".rodata"
	.align 2
.LC2:
	.long 0x0
	.section	".text"
	.align 2
	.globl Weapon_Sniper
	.type	 Weapon_Sniper,@function
Weapon_Sniper:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lwz 10,84(3)
	lis 9,usa_index@ha
	lis 7,fire_frames.37@ha
	lwz 8,usa_index@l(9)
	la 6,fire_frames.37@l(7)
	lwz 11,4392(10)
	mulli 8,8,48
	srawi 9,11,31
	xor 0,9,11
	addi 8,8,4400
	subf 0,0,9
	srawi 0,0,31
	andi. 0,0,52
	ori 0,0,4
	stw 0,fire_frames.37@l(7)
	lwz 9,84(3)
	lwz 11,4392(9)
	srawi 9,11,31
	xor 0,9,11
	subf 0,0,9
	srawi 0,0,31
	rlwinm 0,0,0,26,29
	stw 0,4(6)
	lwz 9,84(3)
	lwz 11,4392(9)
	srawi 9,11,31
	xor 0,9,11
	subf 0,0,9
	srawi 0,0,31
	andi. 0,0,75
	stw 0,8(6)
	lwz 9,84(3)
	lwz 11,4392(9)
	srawi 9,11,31
	xor 0,9,11
	subf 0,0,9
	srawi 0,0,31
	andi. 0,0,80
	stw 0,12(6)
	lwz 11,84(3)
	add 9,11,8
	addi 9,9,28
	stw 9,4500(11)
	lwz 10,84(3)
	add 8,10,8
	addi 8,8,24
	stw 8,4496(10)
	lwz 11,84(3)
	lwz 0,4392(11)
	cmpwi 0,0,0
	bc 12,2,.L61
	lis 9,fire_frames.37@ha
	lwz 0,fire_frames.37@l(9)
	lwz 9,92(11)
	cmpw 0,9,0
	bc 12,0,.L64
	lwz 0,4(6)
	cmpw 0,9,0
	bc 4,1,.L63
.L64:
	lwz 0,12(6)
	cmpw 0,9,0
	bc 12,0,.L62
.L63:
	lwz 9,84(3)
	li 0,1
	stw 0,4528(9)
	b .L66
.L62:
	li 0,0
.L61:
	stw 0,4528(11)
.L66:
	lwz 9,84(3)
	lwz 0,4192(9)
	mr 10,9
	subfic 9,0,0
	adde 11,9,0
	xori 0,0,3
	subfic 9,0,0
	adde 0,9,0
	or. 9,0,11
	bc 12,2,.L67
	lis 9,.LC2@ha
	lfs 13,4684(10)
	la 9,.LC2@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L67
	lwz 0,4132(10)
	andi. 9,0,1
	bc 12,2,.L67
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L68
	cmpwi 0,9,51
	bc 4,2,.L69
	b .L67
.L68:
	cmpwi 0,9,3
	bc 12,2,.L67
.L69:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L70
	cmpwi 0,9,52
	bc 4,2,.L71
	b .L67
.L70:
	cmpwi 0,9,4
	bc 12,2,.L67
.L71:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L72
	cmpwi 0,9,53
	bc 4,2,.L73
	b .L67
.L72:
	cmpwi 0,9,5
	bc 12,2,.L67
.L73:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L74
	cmpwi 0,9,54
	bc 4,2,.L75
	b .L67
.L74:
	cmpwi 0,9,6
	bc 12,2,.L67
.L75:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L76
	cmpwi 0,9,55
	bc 4,2,.L77
	b .L67
.L76:
	cmpwi 0,9,7
	bc 12,2,.L67
.L77:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L78
	cmpwi 0,9,56
	bc 4,2,.L79
	b .L67
.L78:
	cmpwi 0,9,8
	bc 12,2,.L67
.L79:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L80
	cmpwi 0,9,57
	bc 4,2,.L81
	b .L67
.L80:
	cmpwi 0,9,9
	bc 12,2,.L67
.L81:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L82
	cmpwi 0,9,58
	bc 4,2,.L83
	b .L67
.L82:
	cmpwi 0,9,10
	bc 12,2,.L67
.L83:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L84
	cmpwi 0,9,59
	bc 4,2,.L85
	b .L67
.L84:
	cmpwi 0,9,11
	bc 12,2,.L67
.L85:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L86
	cmpwi 0,9,60
	bc 4,2,.L87
	b .L67
.L86:
	cmpwi 0,9,12
	bc 12,2,.L67
.L87:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L88
	cmpwi 0,9,61
	bc 4,2,.L89
	b .L67
.L88:
	cmpwi 0,9,13
	bc 12,2,.L67
.L89:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L90
	cmpwi 0,9,62
	bc 4,2,.L91
	b .L67
.L90:
	cmpwi 0,9,14
	bc 12,2,.L67
.L91:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L92
	cmpwi 0,9,63
	bc 4,2,.L93
	b .L67
.L92:
	cmpwi 0,9,15
	bc 12,2,.L67
.L93:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L94
	cmpwi 0,9,64
	bc 4,2,.L95
	b .L67
.L94:
	cmpwi 0,9,16
	bc 12,2,.L67
.L95:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L96
	cmpwi 0,9,65
	bc 4,2,.L97
	b .L67
.L96:
	cmpwi 0,9,17
	bc 12,2,.L67
.L97:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L98
	cmpwi 0,9,66
	bc 4,2,.L99
	b .L67
.L98:
	cmpwi 0,9,18
	bc 12,2,.L67
.L99:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L100
	cmpwi 0,9,67
	bc 4,2,.L101
	b .L67
.L100:
	cmpwi 0,9,19
	bc 12,2,.L67
.L101:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L102
	cmpwi 0,9,68
	bc 4,2,.L103
	b .L67
.L102:
	cmpwi 0,9,20
	bc 12,2,.L67
.L103:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L104
	cmpwi 0,9,69
	bc 4,2,.L105
	b .L67
.L104:
	cmpwi 0,9,21
	bc 12,2,.L67
.L105:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L106
	cmpwi 0,9,70
	bc 4,2,.L107
	b .L67
.L106:
	cmpwi 0,9,22
	bc 12,2,.L67
.L107:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L108
	cmpwi 0,9,71
	bc 4,2,.L109
	b .L67
.L108:
	cmpwi 0,9,23
	bc 12,2,.L67
.L109:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L110
	cmpwi 0,9,72
	bc 4,2,.L111
	b .L67
.L110:
	cmpwi 0,9,24
	bc 12,2,.L67
.L111:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L112
	cmpwi 0,9,73
	bc 4,2,.L113
	b .L67
.L112:
	cmpwi 0,9,25
	bc 12,2,.L67
.L113:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L114
	cmpwi 0,9,74
	bc 4,2,.L115
	b .L67
.L114:
	cmpwi 0,9,26
	bc 12,2,.L67
.L115:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L116
	cmpwi 0,9,75
	bc 4,2,.L117
	b .L67
.L116:
	cmpwi 0,9,3
	bc 12,2,.L67
.L117:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L118
	cmpwi 0,9,76
	bc 4,2,.L119
	b .L67
.L118:
	cmpwi 0,9,4
	bc 12,2,.L67
.L119:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L120
	cmpwi 0,9,77
	bc 4,2,.L121
	b .L67
.L120:
	cmpwi 0,9,5
	bc 12,2,.L67
.L121:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L122
	cmpwi 0,9,78
	bc 4,2,.L123
	b .L67
.L122:
	cmpwi 0,9,6
	bc 12,2,.L67
.L123:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L124
	cmpwi 0,9,79
	bc 4,2,.L125
	b .L67
.L124:
	cmpwi 0,9,7
	bc 12,2,.L67
.L125:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L126
	cmpwi 0,9,80
	bc 4,2,.L127
	b .L67
.L126:
	cmpwi 0,9,8
	bc 12,2,.L67
.L127:
	lwz 9,84(3)
	lwz 0,92(9)
	cmpwi 0,0,3
	bc 12,1,.L128
	li 0,4
	stw 0,92(9)
.L128:
	lwz 9,84(3)
	li 0,0
	lis 10,0x3f80
	stw 0,4192(9)
	lwz 11,84(3)
	lwz 0,4140(11)
	ori 0,0,1
	stw 0,4140(11)
	lwz 9,84(3)
	stw 10,4684(9)
	b .L129
.L67:
	lwz 0,4132(10)
	rlwinm 0,0,0,0,30
	stw 0,4132(10)
	lwz 9,84(3)
	lwz 0,4140(9)
	rlwinm 0,0,0,0,30
	stw 0,4140(9)
.L129:
	lis 9,Weapon_Generic@ha
	lis 11,Weapon_Sniper_Fire@ha
	lwz 12,Weapon_Generic@l(9)
	li 4,3
	li 5,26
	lwz 0,Weapon_Sniper_Fire@l(11)
	li 6,26
	li 7,43
	li 8,43
	li 9,48
	mtlr 12
	li 10,51
	stw 0,24(1)
	lis 11,pause_frames.36@ha
	lis 29,fire_frames.37@ha
	li 0,80
	la 11,pause_frames.36@l(11)
	la 29,fire_frames.37@l(29)
	stw 0,12(1)
	stw 11,16(1)
	stw 29,20(1)
	stw 0,8(1)
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 Weapon_Sniper,.Lfe3-Weapon_Sniper
	.comm	g_edicts,4,4
	.comm	team_list,8,4
	.comm	id_GameCmds,492,4
	.lcomm	UserDLLImports,48,4
	.comm	usa_index,4,4
	.comm	is_silenced,4,4
	.comm	Pickup_Weapon,4,4
	.comm	Drop_Weapon,4,4
	.comm	Use_Weapon,4,4
	.comm	Pickup_Ammo,4,4
	.comm	Drop_Ammo,4,4
	.comm	ptrgi,4,4
	.comm	ptrGlobals,4,4
	.comm	ptrlevel,4,4
	.comm	ptrGame,4,4
	.comm	PlayerInsertCommands,4,4
	.comm	PlayerFindFunction,4,4
	.comm	PlayerInsertItem,4,4
	.comm	FindItem,4,4
	.comm	SpawnItem,4,4
	.comm	FindItemByClassname,4,4
	.comm	Weapon_Generic,4,4
	.comm	ifchangewep,4,4
	.comm	fire_bullet,4,4
	.comm	AngleVectors,4,4
	.comm	P_ProjectSource,4,4
	.comm	PlayerNoise,4,4
	.comm	Cmd_Reload_f,4,4
	.comm	fire_rifle,4,4
	.comm	VectorScale,4,4
	.comm	fire_rocket,4,4
	.comm	PBM_FireFlameThrower,4,4
	.comm	Weapon_Pistol_Fire,4,4
	.comm	Weapon_Rifle_Fire,4,4
	.comm	Weapon_Submachinegun_Fire,4,4
	.comm	Weapon_LMG_Fire,4,4
	.comm	Weapon_HMG_Fire,4,4
	.comm	Weapon_Rocket_Fire,4,4
	.comm	Weapon_Sniper_Fire,4,4
	.comm	Weapon_Grenade,4,4
	.align 2
	.globl Weapon_Thompson
	.type	 Weapon_Thompson,@function
Weapon_Thompson:
	stwu 1,-80(1)
	mflr 0
	stmw 20,32(1)
	stw 0,84(1)
	mr 25,3
	lis 9,usa_index@ha
	lwz 11,84(25)
	lis 29,fire_frames.17@ha
	lis 10,Weapon_Generic@ha
	lwz 27,usa_index@l(9)
	la 21,fire_frames.17@l(29)
	lis 8,Weapon_Submachinegun_Fire@ha
	lwz 9,4392(11)
	li 4,3
	mulli 27,27,48
	lwz 12,Weapon_Generic@l(10)
	li 5,5
	li 6,45
	srawi 11,9,31
	lwz 20,Weapon_Submachinegun_Fire@l(8)
	li 7,71
	xor 0,11,9
	addi 27,27,4400
	mtlr 12
	subf 0,0,11
	li 8,71
	srawi 0,0,31
	li 9,75
	andi. 0,0,79
	li 10,78
	ori 0,0,4
	li 22,0
	stw 0,fire_frames.17@l(29)
	lis 26,pause_frames.16@ha
	li 23,80
	lwz 11,84(25)
	la 26,pause_frames.16@l(26)
	li 24,92
	lwz 0,4392(11)
	addic 0,0,-1
	subfe 0,0,0
	nor 11,0,0
	andi. 11,11,80
	andi. 0,0,5
	or 0,0,11
	stw 0,4(21)
	lwz 29,84(25)
	add 11,29,27
	addi 11,11,12
	stw 11,4500(29)
	lwz 28,84(25)
	add 27,28,27
	addi 27,27,8
	stw 27,4496(28)
	lwz 11,84(25)
	stw 22,4528(11)
	stw 23,8(1)
	stw 24,12(1)
	stw 26,16(1)
	stw 21,20(1)
	stw 20,24(1)
	blrl
	lwz 0,84(1)
	mtlr 0
	lmw 20,32(1)
	la 1,80(1)
	blr
.Lfe4:
	.size	 Weapon_Thompson,.Lfe4-Weapon_Thompson
	.align 2
	.globl Weapon_BAR
	.type	 Weapon_BAR,@function
Weapon_BAR:
	stwu 1,-80(1)
	mflr 0
	stmw 20,32(1)
	stw 0,84(1)
	mr 25,3
	lis 9,usa_index@ha
	lwz 11,84(25)
	lis 29,fire_frames.22@ha
	lis 10,Weapon_Generic@ha
	lwz 27,usa_index@l(9)
	la 21,fire_frames.22@l(29)
	lis 8,Weapon_LMG_Fire@ha
	lwz 9,4392(11)
	li 4,3
	mulli 27,27,48
	lwz 12,Weapon_Generic@l(10)
	li 5,5
	li 6,44
	srawi 11,9,31
	lwz 20,Weapon_LMG_Fire@l(8)
	li 7,69
	xor 0,11,9
	addi 27,27,4400
	mtlr 12
	subf 0,0,11
	li 8,69
	srawi 0,0,31
	li 9,73
	andi. 0,0,77
	li 10,76
	ori 0,0,4
	li 22,0
	stw 0,fire_frames.22@l(29)
	lis 26,pause_frames.21@ha
	li 23,78
	lwz 11,84(25)
	la 26,pause_frames.21@l(26)
	li 24,89
	lwz 0,4392(11)
	addic 0,0,-1
	subfe 0,0,0
	nor 11,0,0
	andi. 11,11,78
	andi. 0,0,5
	or 0,0,11
	stw 0,4(21)
	lwz 29,84(25)
	add 11,29,27
	addi 11,11,36
	stw 11,4500(29)
	lwz 28,84(25)
	add 27,28,27
	addi 27,27,32
	stw 27,4496(28)
	lwz 11,84(25)
	stw 22,4528(11)
	stw 23,8(1)
	stw 24,12(1)
	stw 26,16(1)
	stw 21,20(1)
	stw 20,24(1)
	blrl
	lwz 0,84(1)
	mtlr 0
	lmw 20,32(1)
	la 1,80(1)
	blr
.Lfe5:
	.size	 Weapon_BAR,.Lfe5-Weapon_BAR
	.align 2
	.globl Weapon_30cal
	.type	 Weapon_30cal,@function
Weapon_30cal:
	stwu 1,-80(1)
	mflr 0
	stmw 21,36(1)
	stw 0,84(1)
	mr 26,3
	lis 29,fire_frames.27@ha
	lwz 10,84(26)
	lis 9,usa_index@ha
	la 22,fire_frames.27@l(29)
	lwz 28,usa_index@l(9)
	lis 8,Weapon_Generic@ha
	lwz 11,4392(10)
	lis 9,Weapon_HMG_Fire@ha
	li 4,19
	mulli 28,28,48
	lwz 12,Weapon_Generic@l(8)
	li 5,21
	li 6,61
	addic 11,11,-1
	subfe 11,11,11
	lwz 21,Weapon_HMG_Fire@l(9)
	li 7,79
	nor 0,11,11
	li 8,82
	mtlr 12
	andi. 0,0,90
	andi. 11,11,20
	or 11,11,0
	li 9,85
	stw 11,fire_frames.27@l(29)
	li 10,88
	li 23,0
	lwz 11,84(26)
	lis 27,pause_frames.26@ha
	li 24,91
	la 27,pause_frames.26@l(27)
	li 25,102
	lwz 0,4392(11)
	addic 0,0,-1
	subfe 0,0,0
	nor 11,0,0
	andi. 11,11,91
	andi. 0,0,21
	or 0,0,11
	stw 0,4(22)
	lwz 29,84(26)
	add 28,28,29
	addi 28,28,4440
	stw 28,4496(29)
	lwz 11,84(26)
	stw 23,4528(11)
	stw 24,8(1)
	stw 25,12(1)
	stw 27,16(1)
	stw 22,20(1)
	stw 21,24(1)
	blrl
	lwz 0,84(1)
	mtlr 0
	lmw 21,36(1)
	la 1,80(1)
	blr
.Lfe6:
	.size	 Weapon_30cal,.Lfe6-Weapon_30cal
	.align 2
	.globl Weapon_Bazooka
	.type	 Weapon_Bazooka,@function
Weapon_Bazooka:
	stwu 1,-80(1)
	mflr 0
	stmw 22,40(1)
	stw 0,84(1)
	mr 26,3
	lis 9,usa_index@ha
	lwz 10,84(26)
	lis 24,fire_frames.32@ha
	lis 8,Weapon_Generic@ha
	lwz 29,usa_index@l(9)
	li 4,3
	lwz 11,4392(10)
	lis 9,Weapon_Rocket_Fire@ha
	li 5,5
	mulli 29,29,48
	lwz 12,Weapon_Generic@l(8)
	li 6,45
	li 7,65
	addic 11,11,-1
	subfe 11,11,11
	lwz 22,Weapon_Rocket_Fire@l(9)
	li 8,65
	nor 0,11,11
	li 9,69
	mtlr 12
	andi. 0,0,73
	rlwinm 11,11,0,29,29
	or 11,11,0
	li 10,72
	stw 11,fire_frames.32@l(24)
	li 23,0
	lis 28,pause_frames.31@ha
	lwz 27,84(26)
	la 28,pause_frames.31@l(28)
	la 24,fire_frames.32@l(24)
	li 0,75
	li 25,86
	add 29,29,27
	addi 29,29,4444
	stw 29,4496(27)
	lwz 11,84(26)
	stw 23,4528(11)
	stw 0,8(1)
	stw 25,12(1)
	stw 28,16(1)
	stw 24,20(1)
	stw 22,24(1)
	blrl
	lwz 0,84(1)
	mtlr 0
	lmw 22,40(1)
	la 1,80(1)
	blr
.Lfe7:
	.size	 Weapon_Bazooka,.Lfe7-Weapon_Bazooka
	.comm	SP_misc_banner_generic,4,4
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
