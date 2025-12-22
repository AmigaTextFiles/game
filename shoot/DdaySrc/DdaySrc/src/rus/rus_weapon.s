	.file	"rus_weapon.c"
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
	.globl Weapon_tt33
	.type	 Weapon_tt33,@function
Weapon_tt33:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	lwz 10,84(3)
	lis 9,rus_index@ha
	lis 7,fire_frames.7@ha
	lwz 11,rus_index@l(9)
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
	.size	 Weapon_tt33,.Lfe1-Weapon_tt33
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
	.globl Weapon_m9130
	.type	 Weapon_m9130,@function
Weapon_m9130:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	lwz 8,84(3)
	lis 10,rus_index@ha
	lis 7,fire_frames.12@ha
	lwz 11,rus_index@l(10)
	li 6,0
	lwz 9,4392(8)
	mulli 11,11,48
	srawi 10,9,31
	xor 0,10,9
	addi 11,11,4400
	subf 0,0,10
	srawi 0,0,31
	andi. 0,0,86
	ori 0,0,4
	stw 0,fire_frames.12@l(7)
	lwz 10,84(3)
	add 9,10,11
	addi 9,9,20
	stw 9,4500(10)
	lwz 8,84(3)
	add 11,8,11
	addi 11,11,16
	stw 11,4496(8)
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
	cmpwi 0,9,85
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
	cmpwi 0,10,86
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
	cmpwi 0,9,87
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
	cmpwi 0,9,88
	bc 4,2,.L31
	b .L23
.L30:
	cmpwi 0,9,6
	bc 12,2,.L23
.L31:
	lwz 0,4392(11)
	lwz 9,92(11)
	cmpwi 0,0,0
	bc 12,2,.L32
	cmpwi 0,9,89
	bc 4,2,.L33
	b .L23
.L32:
	cmpwi 0,9,7
	bc 12,2,.L23
.L33:
	lwz 0,4392(11)
	lwz 9,92(11)
	cmpwi 0,0,0
	bc 12,2,.L34
	cmpwi 0,9,90
	bc 4,2,.L35
	b .L23
.L34:
	cmpwi 0,9,8
	bc 12,2,.L23
.L35:
	lwz 0,4392(11)
	lwz 9,92(11)
	cmpwi 0,0,0
	bc 12,2,.L36
	cmpwi 0,9,91
	bc 4,2,.L37
	b .L23
.L36:
	cmpwi 0,9,9
	bc 12,2,.L23
.L37:
	lwz 0,4392(11)
	lwz 9,92(11)
	cmpwi 0,0,0
	bc 12,2,.L38
	cmpwi 0,9,92
	bc 4,2,.L39
	b .L23
.L38:
	cmpwi 0,9,10
	bc 12,2,.L23
.L39:
	lwz 0,4392(11)
	lwz 9,92(11)
	cmpwi 0,0,0
	bc 12,2,.L40
	cmpwi 0,9,93
	bc 4,2,.L41
	b .L23
.L40:
	cmpwi 0,9,11
	bc 12,2,.L23
.L41:
	lwz 0,4392(11)
	lwz 9,92(11)
	cmpwi 0,0,0
	bc 12,2,.L42
	cmpwi 0,9,94
	bc 4,2,.L43
	b .L23
.L42:
	cmpwi 0,9,12
	bc 12,2,.L23
.L43:
	lwz 0,4392(11)
	lwz 9,92(11)
	cmpwi 0,0,0
	bc 12,2,.L44
	cmpwi 0,9,95
	bc 4,2,.L45
	b .L23
.L44:
	cmpwi 0,9,13
	bc 12,2,.L23
.L45:
	lwz 0,4392(11)
	lwz 9,92(11)
	cmpwi 0,0,0
	bc 12,2,.L46
	cmpwi 0,9,96
	bc 4,2,.L47
	b .L23
.L46:
	cmpwi 0,9,14
	bc 12,2,.L23
.L47:
	lwz 0,4392(11)
	lwz 9,92(11)
	cmpwi 0,0,0
	bc 12,2,.L48
	cmpwi 0,9,97
	bc 4,2,.L49
	b .L23
.L48:
	cmpwi 0,9,15
	bc 12,2,.L23
.L49:
	lwz 0,4392(11)
	lwz 9,92(11)
	cmpwi 0,0,0
	bc 12,2,.L50
	cmpwi 0,9,98
	bc 4,2,.L51
	b .L23
.L50:
	cmpwi 0,9,16
	bc 12,2,.L23
.L51:
	lwz 0,4392(11)
	li 10,0
	lis 8,0x3f80
	addic 0,0,-1
	subfe 0,0,0
	nor 9,0,0
	andi. 9,9,98
	rlwinm 0,0,0,27,27
	or 0,0,9
	stw 0,92(11)
	lwz 9,84(3)
	stw 10,4192(9)
	lwz 11,84(3)
	lwz 0,4140(11)
	ori 0,0,1
	stw 0,4140(11)
	lwz 9,84(3)
	stw 8,4684(9)
	b .L54
.L23:
	lwz 9,84(3)
	lwz 0,4132(9)
	rlwinm 0,0,0,0,30
	stw 0,4132(9)
	lwz 11,84(3)
	lwz 0,4140(11)
	rlwinm 0,0,0,0,30
	stw 0,4140(11)
.L54:
	lis 9,Weapon_Generic@ha
	lis 11,Weapon_Rifle_Fire@ha
	lwz 12,Weapon_Generic@l(9)
	li 4,3
	li 5,16
	lwz 0,Weapon_Rifle_Fire@l(11)
	li 6,56
	li 7,78
	li 8,78
	li 9,82
	mtlr 12
	li 10,85
	stw 0,24(1)
	lis 11,pause_frames.11@ha
	lis 29,fire_frames.12@ha
	la 11,pause_frames.11@l(11)
	la 29,fire_frames.12@l(29)
	li 0,98
	stw 11,16(1)
	li 28,105
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
	.size	 Weapon_m9130,.Lfe2-Weapon_m9130
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
	.globl Weapon_m9130s
	.type	 Weapon_m9130s,@function
Weapon_m9130s:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lwz 10,84(3)
	lis 9,rus_index@ha
	lis 7,fire_frames.37@ha
	lwz 8,rus_index@l(9)
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
	lwz 9,84(3)
	lwz 0,4392(9)
	cmpwi 0,0,0
	bc 12,2,.L82
	lwz 11,92(9)
	lwz 0,8(6)
	cmpw 0,11,0
	bc 12,1,.L84
	lwz 0,12(6)
	cmpw 0,11,0
	bc 12,1,.L83
.L84:
	li 0,1
	b .L82
.L83:
	li 0,0
.L82:
	stw 0,4528(9)
	lwz 9,84(3)
	lwz 0,4192(9)
	mr 10,9
	subfic 9,0,0
	adde 11,9,0
	xori 0,0,3
	subfic 9,0,0
	adde 0,9,0
	or. 9,0,11
	bc 12,2,.L87
	lis 9,.LC2@ha
	lfs 13,4684(10)
	la 9,.LC2@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L87
	lwz 0,4132(10)
	andi. 9,0,1
	bc 12,2,.L87
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L88
	cmpwi 0,9,51
	bc 4,2,.L89
	b .L87
.L88:
	cmpwi 0,9,3
	bc 12,2,.L87
.L89:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L90
	cmpwi 0,9,52
	bc 4,2,.L91
	b .L87
.L90:
	cmpwi 0,9,4
	bc 12,2,.L87
.L91:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L92
	cmpwi 0,9,53
	bc 4,2,.L93
	b .L87
.L92:
	cmpwi 0,9,5
	bc 12,2,.L87
.L93:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L94
	cmpwi 0,9,54
	bc 4,2,.L95
	b .L87
.L94:
	cmpwi 0,9,6
	bc 12,2,.L87
.L95:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L96
	cmpwi 0,9,55
	bc 4,2,.L97
	b .L87
.L96:
	cmpwi 0,9,7
	bc 12,2,.L87
.L97:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L98
	cmpwi 0,9,56
	bc 4,2,.L99
	b .L87
.L98:
	cmpwi 0,9,8
	bc 12,2,.L87
.L99:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L100
	cmpwi 0,9,57
	bc 4,2,.L101
	b .L87
.L100:
	cmpwi 0,9,9
	bc 12,2,.L87
.L101:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L102
	cmpwi 0,9,58
	bc 4,2,.L103
	b .L87
.L102:
	cmpwi 0,9,10
	bc 12,2,.L87
.L103:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L104
	cmpwi 0,9,59
	bc 4,2,.L105
	b .L87
.L104:
	cmpwi 0,9,11
	bc 12,2,.L87
.L105:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L106
	cmpwi 0,9,60
	bc 4,2,.L107
	b .L87
.L106:
	cmpwi 0,9,12
	bc 12,2,.L87
.L107:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L108
	cmpwi 0,9,61
	bc 4,2,.L109
	b .L87
.L108:
	cmpwi 0,9,13
	bc 12,2,.L87
.L109:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L110
	cmpwi 0,9,62
	bc 4,2,.L111
	b .L87
.L110:
	cmpwi 0,9,14
	bc 12,2,.L87
.L111:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L112
	cmpwi 0,9,63
	bc 4,2,.L113
	b .L87
.L112:
	cmpwi 0,9,15
	bc 12,2,.L87
.L113:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L114
	cmpwi 0,9,64
	bc 4,2,.L115
	b .L87
.L114:
	cmpwi 0,9,16
	bc 12,2,.L87
.L115:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L116
	cmpwi 0,9,65
	bc 4,2,.L117
	b .L87
.L116:
	cmpwi 0,9,17
	bc 12,2,.L87
.L117:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L118
	cmpwi 0,9,66
	bc 4,2,.L119
	b .L87
.L118:
	cmpwi 0,9,18
	bc 12,2,.L87
.L119:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L120
	cmpwi 0,9,67
	bc 4,2,.L121
	b .L87
.L120:
	cmpwi 0,9,19
	bc 12,2,.L87
.L121:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L122
	cmpwi 0,9,68
	bc 4,2,.L123
	b .L87
.L122:
	cmpwi 0,9,20
	bc 12,2,.L87
.L123:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L124
	cmpwi 0,9,69
	bc 4,2,.L125
	b .L87
.L124:
	cmpwi 0,9,21
	bc 12,2,.L87
.L125:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L126
	cmpwi 0,9,70
	bc 4,2,.L127
	b .L87
.L126:
	cmpwi 0,9,22
	bc 12,2,.L87
.L127:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L128
	cmpwi 0,9,71
	bc 4,2,.L129
	b .L87
.L128:
	cmpwi 0,9,23
	bc 12,2,.L87
.L129:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L130
	cmpwi 0,9,72
	bc 4,2,.L131
	b .L87
.L130:
	cmpwi 0,9,24
	bc 12,2,.L87
.L131:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L132
	cmpwi 0,9,73
	bc 4,2,.L133
	b .L87
.L132:
	cmpwi 0,9,25
	bc 12,2,.L87
.L133:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L134
	cmpwi 0,9,74
	bc 4,2,.L135
	b .L87
.L134:
	cmpwi 0,9,26
	bc 12,2,.L87
.L135:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L136
	cmpwi 0,9,75
	bc 4,2,.L137
	b .L87
.L136:
	cmpwi 0,9,3
	bc 12,2,.L87
.L137:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L138
	cmpwi 0,9,76
	bc 4,2,.L139
	b .L87
.L138:
	cmpwi 0,9,4
	bc 12,2,.L87
.L139:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L140
	cmpwi 0,9,77
	bc 4,2,.L141
	b .L87
.L140:
	cmpwi 0,9,5
	bc 12,2,.L87
.L141:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L142
	cmpwi 0,9,78
	bc 4,2,.L143
	b .L87
.L142:
	cmpwi 0,9,6
	bc 12,2,.L87
.L143:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L144
	cmpwi 0,9,79
	bc 4,2,.L145
	b .L87
.L144:
	cmpwi 0,9,7
	bc 12,2,.L87
.L145:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L146
	cmpwi 0,9,80
	bc 4,2,.L147
	b .L87
.L146:
	cmpwi 0,9,8
	bc 12,2,.L87
.L147:
	lwz 9,84(3)
	lwz 0,92(9)
	cmpwi 0,0,3
	bc 12,1,.L148
	li 0,4
	stw 0,92(9)
.L148:
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
	b .L149
.L87:
	lwz 0,4132(10)
	rlwinm 0,0,0,0,30
	stw 0,4132(10)
	lwz 9,84(3)
	lwz 0,4140(9)
	rlwinm 0,0,0,0,30
	stw 0,4140(9)
.L149:
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
	.size	 Weapon_m9130s,.Lfe3-Weapon_m9130s
	.section	".rodata"
	.align 2
.LC3:
	.string	"weapons/noammo.wav"
	.align 2
.LC4:
	.string	"*** Firing System Error\n"
	.align 2
.LC5:
	.long 0x3f800000
	.align 2
.LC6:
	.long 0x0
	.align 3
.LC7:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC8:
	.long 0x40040000
	.long 0x0
	.align 2
.LC9:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Weapon_Bayoneted_Rifle_Fire
	.type	 Weapon_Bayoneted_Rifle_Fire,@function
Weapon_Bayoneted_Rifle_Fire:
	stwu 1,-128(1)
	mflr 0
	stmw 25,100(1)
	stw 0,132(1)
	mr 31,3
	lwz 10,84(31)
	lwz 9,1796(10)
	addi 11,10,4416
	lwz 6,100(9)
	lwz 7,96(9)
	mulli 0,6,48
	lwzx 9,11,0
	cmpwi 0,9,1
	bc 12,2,.L151
	lwz 9,92(10)
	addi 9,9,1
	stw 9,92(10)
.L151:
	lwz 8,84(31)
	lwz 0,4132(8)
	andi. 9,0,1
	bc 4,2,.L152
	lwz 0,4392(8)
	cmpwi 0,0,0
	bc 12,2,.L153
	lwz 0,36(7)
	b .L173
.L153:
	lwz 0,32(7)
.L173:
	stw 0,92(8)
	lwz 9,84(31)
	li 10,0
	stw 10,4320(9)
	lwz 11,84(31)
	lwz 0,4132(11)
	ori 0,0,1
	stw 0,4132(11)
	lwz 9,84(31)
	stw 10,4192(9)
	b .L150
.L152:
	lis 11,ptrlevel@ha
	lwz 10,4384(8)
	lwz 9,ptrlevel@l(11)
	lwz 0,0(9)
	cmpw 0,10,0
	bc 4,1,.L155
	lwz 0,4392(8)
	cmpwi 0,0,0
	bc 12,2,.L156
	lwz 9,36(7)
	b .L174
.L156:
	lwz 9,32(7)
.L174:
	addi 9,9,1
	stw 9,92(8)
.L155:
	lwz 10,84(31)
	lwz 9,4496(10)
	lwz 0,0(9)
	cmpwi 0,0,0
	bc 4,2,.L158
	lwz 0,4392(10)
	cmpwi 0,0,0
	bc 12,2,.L159
	lwz 9,36(7)
	b .L175
.L159:
	lwz 9,32(7)
.L175:
	addi 0,9,1
	lis 9,ptrlevel@ha
	stw 0,92(10)
	lwz 11,ptrlevel@l(9)
	lfs 13,468(31)
	lfs 0,4(11)
	fcmpu 0,0,13
	cror 3,2,1
	bc 4,3,.L150
	lis 9,ptrgi@ha
	lis 3,.LC3@ha
	lwz 29,ptrgi@l(9)
	la 3,.LC3@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lis 9,.LC5@ha
	lwz 0,16(29)
	lis 11,.LC5@ha
	la 9,.LC5@l(9)
	la 11,.LC5@l(11)
	lfs 1,0(9)
	mr 5,3
	li 4,2
	mtlr 0
	lis 9,.LC6@ha
	lfs 2,0(11)
	mr 3,31
	la 9,.LC6@l(9)
	lfs 3,0(9)
	blrl
	lis 9,ptrlevel@ha
	lwz 11,ptrlevel@l(9)
	lis 9,.LC5@ha
	la 9,.LC5@l(9)
	lfs 0,4(11)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,468(31)
	b .L150
.L158:
	lis 9,ptrlevel@ha
	lwz 0,4384(10)
	lwz 11,ptrlevel@l(9)
	lwz 9,0(11)
	cmpw 0,0,9
	bc 12,1,.L150
	lwz 0,100(7)
	mulli 11,6,48
	add 0,9,0
	mr 25,11
	stw 0,4384(10)
	lwz 10,84(31)
	addi 9,10,4416
	lwzx 0,9,11
	cmpwi 0,0,1
	bc 4,2,.L163
	lwz 11,40(7)
	lis 9,Play_WepSound@ha
	li 0,4
	lwz 8,Play_WepSound@l(9)
	mr 3,31
	addi 11,11,1
	stw 11,92(10)
	mtlr 8
	lwz 9,84(31)
	stw 0,4192(9)
	lwz 4,84(7)
	blrl
.L163:
	li 0,2
	addi 30,1,24
	mtctr 0
	addi 28,1,40
	addi 27,31,4
	addi 26,1,56
.L166:
	bdnz .L166
	lwz 11,84(31)
	lis 9,AngleVectors@ha
	mr 4,30
	lwz 0,AngleVectors@l(9)
	mr 5,28
	li 6,0
	lwz 9,4320(11)
	mtlr 0
	addi 9,9,1
	stw 9,4320(11)
	lwz 3,84(31)
	addi 3,3,4264
	blrl
	lis 9,.LC7@ha
	lwz 10,84(31)
	li 0,4
	la 9,.LC7@l(9)
	lfd 13,0(9)
	lis 29,0x4330
	mr 4,27
	lwz 8,1796(10)
	lis 9,P_ProjectSource@ha
	mr 5,26
	lwz 10,P_ProjectSource@l(9)
	mr 6,30
	mr 7,28
	stw 0,68(8)
	li 9,0
	lwz 0,512(31)
	addi 8,1,8
	mtlr 10
	lwz 3,84(31)
	xoris 0,0,0x8000
	stw 9,60(1)
	stw 0,92(1)
	stw 29,88(1)
	lfd 0,88(1)
	stw 9,56(1)
	fsub 0,0,13
	frsp 0,0
	stfs 0,64(1)
	blrl
	lwz 9,84(31)
	lwz 0,4392(9)
	cmpwi 0,0,0
	bc 12,2,.L171
	lfs 0,4200(9)
	lis 11,.LC8@ha
	la 11,.LC8@l(11)
	lfd 13,0(11)
	fsub 0,0,13
	frsp 0,0
	b .L176
.L171:
	lis 11,.LC9@ha
	lfs 0,4200(9)
	la 11,.LC9@l(11)
	lfs 13,0(11)
	fsubs 0,0,13
.L176:
	stfs 0,4200(9)
	lwz 11,84(31)
	addi 11,11,4416
	lwzx 9,11,25
	addi 9,9,-1
	stwx 9,11,25
.L150:
	lwz 0,132(1)
	mtlr 0
	lmw 25,100(1)
	la 1,128(1)
	blr
.Lfe4:
	.size	 Weapon_Bayoneted_Rifle_Fire,.Lfe4-Weapon_Bayoneted_Rifle_Fire
	.comm	g_edicts,4,4
	.comm	team_list,8,4
	.comm	id_GameCmds,492,4
	.lcomm	UserDLLImports,48,4
	.comm	rus_index,4,4
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
	.comm	Weapon_Grenade,4,4
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
	.align 2
	.globl Weapon_ppsh41
	.type	 Weapon_ppsh41,@function
Weapon_ppsh41:
	stwu 1,-80(1)
	mflr 0
	stmw 20,32(1)
	stw 0,84(1)
	mr 25,3
	lis 9,rus_index@ha
	lwz 11,84(25)
	lis 29,fire_frames.17@ha
	lis 10,Weapon_Generic@ha
	lwz 27,rus_index@l(9)
	la 21,fire_frames.17@l(29)
	lis 8,Weapon_Submachinegun_Fire@ha
	lwz 9,4392(11)
	li 4,3
	mulli 27,27,48
	lwz 12,Weapon_Generic@l(10)
	li 5,5
	li 6,45
	addic 9,9,-1
	subfe 9,9,9
	lwz 20,Weapon_Submachinegun_Fire@l(8)
	li 7,81
	nor 0,9,9
	addi 27,27,4400
	mtlr 12
	andi. 0,0,89
	rlwinm 9,9,0,29,29
	or 9,9,0
	li 8,81
	stw 9,fire_frames.17@l(29)
	li 10,88
	li 22,0
	lwz 11,84(25)
	li 9,85
	lis 26,pause_frames.16@ha
	la 26,pause_frames.16@l(26)
	li 23,90
	lwz 0,4392(11)
	li 24,102
	addic 0,0,-1
	subfe 0,0,0
	nor 11,0,0
	andi. 11,11,90
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
.Lfe5:
	.size	 Weapon_ppsh41,.Lfe5-Weapon_ppsh41
	.align 2
	.globl Weapon_pps43
	.type	 Weapon_pps43,@function
Weapon_pps43:
	stwu 1,-80(1)
	mflr 0
	stmw 20,32(1)
	stw 0,84(1)
	mr 25,3
	lis 9,rus_index@ha
	lwz 11,84(25)
	lis 29,fire_frames.22@ha
	lis 10,Weapon_Generic@ha
	lwz 27,rus_index@l(9)
	la 21,fire_frames.22@l(29)
	lis 8,Weapon_LMG_Fire@ha
	lwz 9,4392(11)
	li 4,3
	mulli 27,27,48
	lwz 12,Weapon_Generic@l(10)
	li 5,5
	li 6,45
	srawi 11,9,31
	lwz 20,Weapon_LMG_Fire@l(8)
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
	stw 0,fire_frames.22@l(29)
	lis 26,pause_frames.21@ha
	li 23,80
	lwz 11,84(25)
	la 26,pause_frames.21@l(26)
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
.Lfe6:
	.size	 Weapon_pps43,.Lfe6-Weapon_pps43
	.align 2
	.globl Weapon_dpm
	.type	 Weapon_dpm,@function
Weapon_dpm:
	stwu 1,-80(1)
	mflr 0
	stmw 21,36(1)
	stw 0,84(1)
	mr 26,3
	lis 29,fire_frames.27@ha
	lwz 10,84(26)
	la 22,fire_frames.27@l(29)
	lis 9,rus_index@ha
	lwz 28,rus_index@l(9)
	lis 8,Weapon_Generic@ha
	lwz 11,4392(10)
	lis 9,Weapon_HMG_Fire@ha
	li 4,20
	mulli 28,28,48
	lwz 12,Weapon_Generic@l(8)
	li 5,22
	li 6,62
	addic 11,11,-1
	subfe 11,11,11
	lwz 21,Weapon_HMG_Fire@l(9)
	li 7,79
	nor 0,11,11
	li 8,79
	mtlr 12
	andi. 0,0,86
	andi. 11,11,21
	or 11,11,0
	li 9,82
	stw 11,fire_frames.27@l(29)
	li 10,85
	li 23,0
	lwz 29,84(26)
	lis 27,pause_frames.26@ha
	li 24,87
	la 27,pause_frames.26@l(27)
	li 25,99
	lwz 11,4392(29)
	srawi 31,11,31
	xor 0,31,11
	subf 0,0,31
	srawi 0,0,31
	andi. 0,0,87
	ori 0,0,22
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
.Lfe7:
	.size	 Weapon_dpm,.Lfe7-Weapon_dpm
	.align 2
	.globl Weapon_Psk
	.type	 Weapon_Psk,@function
Weapon_Psk:
	stwu 1,-80(1)
	mflr 0
	stmw 22,40(1)
	stw 0,84(1)
	mr 26,3
	lis 9,rus_index@ha
	lwz 10,84(26)
	lis 24,fire_frames.32@ha
	lis 8,Weapon_Generic@ha
	lwz 29,rus_index@l(9)
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
.Lfe8:
	.size	 Weapon_Psk,.Lfe8-Weapon_Psk
	.comm	Play_WepSound,4,4
	.comm	fire_gun,4,4
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
