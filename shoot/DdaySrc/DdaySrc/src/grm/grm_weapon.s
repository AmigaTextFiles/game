	.file	"grm_weapon.c"
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
	.globl Weapon_P38
	.type	 Weapon_P38,@function
Weapon_P38:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	lwz 8,84(3)
	lis 10,grm_index@ha
	lis 7,fire_frames.7@ha
	lwz 11,grm_index@l(10)
	li 6,0
	lwz 9,4392(8)
	mulli 11,11,48
	srawi 10,9,31
	xor 0,10,9
	addi 11,11,4400
	subf 0,0,10
	srawi 0,0,31
	andi. 0,0,71
	ori 0,0,4
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
	cmpwi 0,9,70
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
	cmpwi 0,10,71
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
	cmpwi 0,9,72
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
	cmpwi 0,9,73
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
	li 7,58
	li 8,61
	li 9,65
	mtlr 12
	li 10,70
	stw 0,24(1)
	lis 11,pause_frames.6@ha
	lis 29,fire_frames.7@ha
	la 11,pause_frames.6@l(11)
	la 29,fire_frames.7@l(29)
	li 0,73
	stw 11,16(1)
	li 28,84
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
	.size	 Weapon_P38,.Lfe1-Weapon_P38
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
	.globl Weapon_m98k
	.type	 Weapon_m98k,@function
Weapon_m98k:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	lwz 8,84(3)
	lis 10,grm_index@ha
	lis 7,fire_frames.12@ha
	lwz 11,grm_index@l(10)
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
	li 28,100
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
	.size	 Weapon_m98k,.Lfe2-Weapon_m98k
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
	.globl Weapon_m98ks
	.type	 Weapon_m98ks,@function
Weapon_m98ks:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lwz 10,84(3)
	lis 9,grm_index@ha
	lis 7,fire_frames.37@ha
	lwz 8,grm_index@l(9)
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
	bc 12,2,.L82
	lis 9,fire_frames.37@ha
	lwz 0,fire_frames.37@l(9)
	lwz 9,92(11)
	cmpw 0,9,0
	bc 12,0,.L85
	lwz 0,4(6)
	cmpw 0,9,0
	bc 4,1,.L84
.L85:
	lwz 0,12(6)
	cmpw 0,9,0
	bc 12,0,.L83
.L84:
	lwz 9,84(3)
	li 0,1
	stw 0,4528(9)
	b .L87
.L83:
	li 0,0
.L82:
	stw 0,4528(11)
.L87:
	lwz 9,84(3)
	lwz 0,4192(9)
	mr 10,9
	subfic 9,0,0
	adde 11,9,0
	xori 0,0,3
	subfic 9,0,0
	adde 0,9,0
	or. 9,0,11
	bc 12,2,.L88
	lis 9,.LC2@ha
	lfs 13,4684(10)
	la 9,.LC2@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L88
	lwz 0,4132(10)
	andi. 9,0,1
	bc 12,2,.L88
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L89
	cmpwi 0,9,51
	bc 4,2,.L90
	b .L88
.L89:
	cmpwi 0,9,3
	bc 12,2,.L88
.L90:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L91
	cmpwi 0,9,52
	bc 4,2,.L92
	b .L88
.L91:
	cmpwi 0,9,4
	bc 12,2,.L88
.L92:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L93
	cmpwi 0,9,53
	bc 4,2,.L94
	b .L88
.L93:
	cmpwi 0,9,5
	bc 12,2,.L88
.L94:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L95
	cmpwi 0,9,54
	bc 4,2,.L96
	b .L88
.L95:
	cmpwi 0,9,6
	bc 12,2,.L88
.L96:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L97
	cmpwi 0,9,55
	bc 4,2,.L98
	b .L88
.L97:
	cmpwi 0,9,7
	bc 12,2,.L88
.L98:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L99
	cmpwi 0,9,56
	bc 4,2,.L100
	b .L88
.L99:
	cmpwi 0,9,8
	bc 12,2,.L88
.L100:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L101
	cmpwi 0,9,57
	bc 4,2,.L102
	b .L88
.L101:
	cmpwi 0,9,9
	bc 12,2,.L88
.L102:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L103
	cmpwi 0,9,58
	bc 4,2,.L104
	b .L88
.L103:
	cmpwi 0,9,10
	bc 12,2,.L88
.L104:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L105
	cmpwi 0,9,59
	bc 4,2,.L106
	b .L88
.L105:
	cmpwi 0,9,11
	bc 12,2,.L88
.L106:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L107
	cmpwi 0,9,60
	bc 4,2,.L108
	b .L88
.L107:
	cmpwi 0,9,12
	bc 12,2,.L88
.L108:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L109
	cmpwi 0,9,61
	bc 4,2,.L110
	b .L88
.L109:
	cmpwi 0,9,13
	bc 12,2,.L88
.L110:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L111
	cmpwi 0,9,62
	bc 4,2,.L112
	b .L88
.L111:
	cmpwi 0,9,14
	bc 12,2,.L88
.L112:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L113
	cmpwi 0,9,63
	bc 4,2,.L114
	b .L88
.L113:
	cmpwi 0,9,15
	bc 12,2,.L88
.L114:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L115
	cmpwi 0,9,64
	bc 4,2,.L116
	b .L88
.L115:
	cmpwi 0,9,16
	bc 12,2,.L88
.L116:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L117
	cmpwi 0,9,65
	bc 4,2,.L118
	b .L88
.L117:
	cmpwi 0,9,17
	bc 12,2,.L88
.L118:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L119
	cmpwi 0,9,66
	bc 4,2,.L120
	b .L88
.L119:
	cmpwi 0,9,18
	bc 12,2,.L88
.L120:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L121
	cmpwi 0,9,67
	bc 4,2,.L122
	b .L88
.L121:
	cmpwi 0,9,19
	bc 12,2,.L88
.L122:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L123
	cmpwi 0,9,68
	bc 4,2,.L124
	b .L88
.L123:
	cmpwi 0,9,20
	bc 12,2,.L88
.L124:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L125
	cmpwi 0,9,69
	bc 4,2,.L126
	b .L88
.L125:
	cmpwi 0,9,21
	bc 12,2,.L88
.L126:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L127
	cmpwi 0,9,70
	bc 4,2,.L128
	b .L88
.L127:
	cmpwi 0,9,22
	bc 12,2,.L88
.L128:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L129
	cmpwi 0,9,71
	bc 4,2,.L130
	b .L88
.L129:
	cmpwi 0,9,23
	bc 12,2,.L88
.L130:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L131
	cmpwi 0,9,72
	bc 4,2,.L132
	b .L88
.L131:
	cmpwi 0,9,24
	bc 12,2,.L88
.L132:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L133
	cmpwi 0,9,73
	bc 4,2,.L134
	b .L88
.L133:
	cmpwi 0,9,25
	bc 12,2,.L88
.L134:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L135
	cmpwi 0,9,74
	bc 4,2,.L136
	b .L88
.L135:
	cmpwi 0,9,26
	bc 12,2,.L88
.L136:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L137
	cmpwi 0,9,75
	bc 4,2,.L138
	b .L88
.L137:
	cmpwi 0,9,3
	bc 12,2,.L88
.L138:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L139
	cmpwi 0,9,76
	bc 4,2,.L140
	b .L88
.L139:
	cmpwi 0,9,4
	bc 12,2,.L88
.L140:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L141
	cmpwi 0,9,77
	bc 4,2,.L142
	b .L88
.L141:
	cmpwi 0,9,5
	bc 12,2,.L88
.L142:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L143
	cmpwi 0,9,78
	bc 4,2,.L144
	b .L88
.L143:
	cmpwi 0,9,6
	bc 12,2,.L88
.L144:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L145
	cmpwi 0,9,79
	bc 4,2,.L146
	b .L88
.L145:
	cmpwi 0,9,7
	bc 12,2,.L88
.L146:
	lwz 0,4392(10)
	lwz 9,92(10)
	cmpwi 0,0,0
	bc 12,2,.L147
	cmpwi 0,9,80
	bc 4,2,.L148
	b .L88
.L147:
	cmpwi 0,9,8
	bc 12,2,.L88
.L148:
	lwz 9,84(3)
	lwz 0,92(9)
	cmpwi 0,0,3
	bc 12,1,.L149
	li 0,4
	stw 0,92(9)
.L149:
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
	b .L150
.L88:
	lwz 0,4132(10)
	rlwinm 0,0,0,0,30
	stw 0,4132(10)
	lwz 9,84(3)
	lwz 0,4140(9)
	rlwinm 0,0,0,0,30
	stw 0,4140(9)
.L150:
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
	.size	 Weapon_m98ks,.Lfe3-Weapon_m98ks
	.comm	g_edicts,4,4
	.comm	team_list,8,4
	.comm	id_GameCmds,492,4
	.lcomm	UserDLLImports,48,4
	.comm	grm_index,4,4
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
	.globl Weapon_MP40
	.type	 Weapon_MP40,@function
Weapon_MP40:
	stwu 1,-80(1)
	mflr 0
	stmw 20,32(1)
	stw 0,84(1)
	mr 25,3
	lis 9,grm_index@ha
	lwz 11,84(25)
	lis 29,fire_frames.17@ha
	lis 10,Weapon_Generic@ha
	lwz 27,grm_index@l(9)
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
	.size	 Weapon_MP40,.Lfe4-Weapon_MP40
	.align 2
	.globl Weapon_MP43
	.type	 Weapon_MP43,@function
Weapon_MP43:
	stwu 1,-80(1)
	mflr 0
	stmw 20,32(1)
	stw 0,84(1)
	mr 25,3
	lis 9,grm_index@ha
	lwz 11,84(25)
	lis 29,fire_frames.22@ha
	lis 10,Weapon_Generic@ha
	lwz 27,grm_index@l(9)
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
.Lfe5:
	.size	 Weapon_MP43,.Lfe5-Weapon_MP43
	.align 2
	.globl Weapon_MG42
	.type	 Weapon_MG42,@function
Weapon_MG42:
	stwu 1,-80(1)
	mflr 0
	stmw 21,36(1)
	stw 0,84(1)
	mr 26,3
	lis 29,fire_frames.27@ha
	lwz 10,84(26)
	la 22,fire_frames.27@l(29)
	lis 9,grm_index@ha
	lwz 28,grm_index@l(9)
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
.Lfe6:
	.size	 Weapon_MG42,.Lfe6-Weapon_MG42
	.align 2
	.globl Weapon_Psk
	.type	 Weapon_Psk,@function
Weapon_Psk:
	stwu 1,-80(1)
	mflr 0
	stmw 22,40(1)
	stw 0,84(1)
	mr 26,3
	lis 9,grm_index@ha
	lwz 10,84(26)
	lis 24,fire_frames.32@ha
	lis 8,Weapon_Generic@ha
	lwz 29,grm_index@l(9)
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
	.size	 Weapon_Psk,.Lfe7-Weapon_Psk
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
