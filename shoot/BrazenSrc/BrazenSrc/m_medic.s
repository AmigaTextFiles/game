	.file	"m_medic.c"
gcc2_compiled.:
	.globl reinforcements
	.section	".data"
	.align 2
	.type	 reinforcements,@object
reinforcements:
	.long .LC0
	.long .LC1
	.long .LC2
	.long .LC3
	.long .LC4
	.long .LC5
	.long .LC6
	.section	".rodata"
	.align 2
.LC6:
	.string	"monster_gladiator"
	.align 2
.LC5:
	.string	"monster_medic"
	.align 2
.LC4:
	.string	"monster_gunner"
	.align 2
.LC3:
	.string	"monster_infantry"
	.align 2
.LC2:
	.string	"monster_soldier_ss"
	.align 2
.LC1:
	.string	"monster_soldier"
	.align 2
.LC0:
	.string	"monster_soldier_light"
	.size	 reinforcements,28
	.globl reinforcement_mins
	.section	".data"
	.align 2
	.type	 reinforcement_mins,@object
reinforcement_mins:
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.long 0xc1800000
	.long 0xc1800000
	.long 0xc1c00000
	.long 0xc2000000
	.long 0xc2000000
	.long 0xc1c00000
	.size	 reinforcement_mins,84
	.globl reinforcement_maxs
	.align 2
	.type	 reinforcement_maxs,@object
reinforcement_maxs:
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.long 0x41800000
	.long 0x41800000
	.long 0x42000000
	.long 0x42000000
	.long 0x42000000
	.long 0x42800000
	.size	 reinforcement_maxs,84
	.globl reinforcement_position
	.align 2
	.type	 reinforcement_position,@object
reinforcement_position:
	.long 0x42a00000
	.long 0x0
	.long 0x0
	.long 0x42200000
	.long 0x42700000
	.long 0x0
	.long 0x42200000
	.long 0xc2700000
	.long 0x0
	.long 0x0
	.long 0x42a00000
	.long 0x0
	.long 0x0
	.long 0xc2a00000
	.long 0x0
	.size	 reinforcement_position,60
	.align 2
	.type	 pain_normal.9,@object
	.size	 pain_normal.9,12
pain_normal.9:
	.long 0x0
	.long 0x0
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl abortHeal
	.type	 abortHeal,@function
abortHeal:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	lwz 9,540(31)
	mr 28,5
	mr 29,6
	cmpwi 0,9,0
	bc 12,2,.L10
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L10
	li 0,0
	li 10,1
	stw 0,916(9)
	lwz 11,540(31)
	lwz 0,776(11)
	rlwinm 0,0,0,18,16
	stw 0,776(11)
	lwz 9,540(31)
	stw 10,512(9)
	lwz 3,540(31)
	bl M_SetEffects
.L10:
	cmpwi 0,30,0
	bc 12,2,.L12
	li 0,228
	stw 0,780(31)
.L12:
	cmpwi 0,29,0
	bc 12,2,.L13
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L13
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L13
	lwz 9,908(9)
	cmpwi 0,9,0
	bc 12,2,.L14
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L14
	lwz 3,280(9)
	lis 4,.LC5@ha
	li 5,13
	la 4,.LC5@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 4,2,.L14
	lwz 9,540(31)
	stw 31,912(9)
	b .L13
.L14:
	lwz 9,540(31)
	stw 31,908(9)
.L13:
	cmpwi 0,28,0
	bc 12,2,.L16
	lwz 3,540(31)
	cmpwi 0,3,0
	bc 12,2,.L16
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L16
	lwz 9,488(3)
	li 11,0
	lis 6,vec3_origin@ha
	lis 8,pain_normal.9@ha
	stw 11,12(1)
	la 6,vec3_origin@l(6)
	neg 0,9
	stw 11,8(1)
	la 8,pain_normal.9@l(8)
	addic 9,9,-1
	subfe 9,9,9
	mr 4,31
	andc 0,0,9
	mr 5,31
	andi. 9,9,500
	addi 7,3,4
	or 9,9,0
	li 10,0
	bl T_Damage
.L16:
	lwz 9,544(31)
	lwz 0,776(31)
	cmpwi 0,9,0
	rlwinm 0,0,0,19,17
	stw 0,776(31)
	bc 12,2,.L19
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L19
	stw 9,540(31)
	b .L20
.L19:
	li 0,0
	stw 0,540(31)
.L20:
	li 0,0
	stw 0,904(31)
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 abortHeal,.Lfe1-abortHeal
	.section	".rodata"
	.align 2
.LC7:
	.string	"player"
	.align 2
.LC8:
	.long 0x44800000
	.align 2
.LC9:
	.long 0x43c80000
	.align 2
.LC10:
	.long 0x0
	.align 2
.LC11:
	.long 0x42000000
	.align 3
.LC12:
	.long 0x40240000
	.long 0x0
	.section	".text"
	.align 2
	.globl medic_FindDeadMonster
	.type	 medic_FindDeadMonster,@function
medic_FindDeadMonster:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	mr 30,3
	lis 9,.LC8@ha
	lwz 0,776(30)
	la 9,.LC8@l(9)
	li 31,0
	li 29,0
	lfs 31,0(9)
	andi. 11,0,1
	bc 12,2,.L25
	lis 9,.LC9@ha
	la 9,.LC9@l(9)
	lfs 31,0(9)
.L25:
	addi 28,30,4
	b .L27
.L29:
	cmpw 0,31,30
	bc 12,2,.L27
	lwz 0,184(31)
	andi. 11,0,4
	bc 12,2,.L27
	lwz 0,776(31)
	andi. 9,0,256
	bc 4,2,.L27
	lwz 0,908(31)
	cmpw 0,0,30
	bc 12,2,.L27
	lwz 0,912(31)
	cmpw 0,0,30
	bc 12,2,.L27
	lwz 9,916(31)
	cmpwi 0,9,0
	bc 12,2,.L35
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L35
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L35
	lwz 0,184(9)
	andi. 11,0,4
	bc 12,2,.L35
	lwz 0,776(9)
	andi. 9,0,8192
	bc 4,2,.L27
.L35:
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 12,1,.L27
	lis 11,.LC10@ha
	lfs 13,428(31)
	la 11,.LC10@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 12,2,.L38
	lwz 0,436(31)
	lis 9,M_FliesOn@ha
	la 9,M_FliesOn@l(9)
	cmpw 0,0,9
	bc 12,2,.L38
	lis 9,M_FliesOff@ha
	la 9,M_FliesOff@l(9)
	cmpw 0,0,9
	bc 4,2,.L27
.L38:
	mr 3,30
	mr 4,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L27
	lwz 3,280(31)
	lis 4,.LC7@ha
	li 5,6
	la 4,.LC7@l(4)
	bl strncmp
	cmpwi 0,3,0
	bc 12,2,.L27
	mr 3,30
	mr 4,31
	bl realrange
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	cror 3,2,0
	bc 12,3,.L27
	cmpwi 0,29,0
	bc 4,2,.L42
	mr 29,31
	b .L27
.L42:
	lwz 11,484(29)
	lwz 9,484(31)
	cmpw 7,9,11
	cror 31,30,28
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	andc 9,31,0
	and 0,29,0
	or 29,0,9
.L27:
	fmr 1,31
	mr 3,31
	mr 4,28
	bl findradius
	mr. 31,3
	bc 4,2,.L29
	cmpwi 0,29,0
	bc 12,2,.L45
	lis 9,level+4@ha
	lis 11,.LC12@ha
	lfs 0,level+4@l(9)
	la 11,.LC12@l(11)
	lfd 13,0(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,288(30)
.L45:
	mr 3,29
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 medic_FindDeadMonster,.Lfe2-medic_FindDeadMonster
	.globl medic_frames_stand
	.section	".data"
	.align 2
	.type	 medic_frames_stand,@object
medic_frames_stand:
	.long ai_stand
	.long 0x0
	.long medic_idle
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.long ai_stand
	.long 0x0
	.long 0
	.size	 medic_frames_stand,1080
	.globl medic_move_stand
	.align 2
	.type	 medic_move_stand,@object
	.size	 medic_move_stand,16
medic_move_stand:
	.long 12
	.long 101
	.long medic_frames_stand
	.long 0
	.globl medic_frames_walk
	.align 2
	.type	 medic_frames_walk,@object
medic_frames_walk:
	.long ai_walk
	.long 0x40c66666
	.long 0
	.long ai_walk
	.long 0x4190cccd
	.long 0
	.long ai_walk
	.long 0x3f800000
	.long 0
	.long ai_walk
	.long 0x41100000
	.long 0
	.long ai_walk
	.long 0x41200000
	.long 0
	.long ai_walk
	.long 0x41100000
	.long 0
	.long ai_walk
	.long 0x41300000
	.long 0
	.long ai_walk
	.long 0x4139999a
	.long 0
	.long ai_walk
	.long 0x40000000
	.long 0
	.long ai_walk
	.long 0x411e6666
	.long 0
	.long ai_walk
	.long 0x41600000
	.long 0
	.long ai_walk
	.long 0x4114cccd
	.long 0
	.size	 medic_frames_walk,144
	.globl medic_move_walk
	.align 2
	.type	 medic_move_walk,@object
	.size	 medic_move_walk,16
medic_move_walk:
	.long 0
	.long 11
	.long medic_frames_walk
	.long 0
	.globl medic_frames_run
	.align 2
	.type	 medic_frames_run,@object
medic_frames_run:
	.long ai_run
	.long 0x41900000
	.long 0
	.long ai_run
	.long 0x41b40000
	.long 0
	.long ai_run
	.long 0x41cb3333
	.long monster_done_dodge
	.long ai_run
	.long 0x41bb3333
	.long 0
	.long ai_run
	.long 0x41c00000
	.long 0
	.long ai_run
	.long 0x420e6666
	.long 0
	.size	 medic_frames_run,72
	.globl medic_move_run
	.align 2
	.type	 medic_move_run,@object
	.size	 medic_move_run,16
medic_move_run:
	.long 102
	.long 107
	.long medic_frames_run
	.long 0
	.globl medic_frames_pain1
	.align 2
	.type	 medic_frames_pain1,@object
medic_frames_pain1:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 medic_frames_pain1,96
	.globl medic_move_pain1
	.align 2
	.type	 medic_move_pain1,@object
	.size	 medic_move_pain1,16
medic_move_pain1:
	.long 108
	.long 115
	.long medic_frames_pain1
	.long medic_run
	.globl medic_frames_pain2
	.align 2
	.type	 medic_frames_pain2,@object
medic_frames_pain2:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 medic_frames_pain2,180
	.globl medic_move_pain2
	.align 2
	.type	 medic_move_pain2,@object
	.size	 medic_move_pain2,16
medic_move_pain2:
	.long 116
	.long 130
	.long medic_frames_pain2
	.long medic_run
	.section	".rodata"
	.align 2
.LC13:
	.long 0x46fffe00
	.align 3
.LC14:
	.long 0x3f747ae1
	.long 0x47ae147b
	.align 2
.LC15:
	.long 0x40400000
	.align 2
.LC16:
	.long 0x3f800000
	.align 2
.LC17:
	.long 0x0
	.align 3
.LC18:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC19:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl medic_pain
	.type	 medic_pain,@function
medic_pain:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	mr 30,5
	bl monster_done_dodge
	lwz 0,484(31)
	lwz 11,480(31)
	srwi 9,0,31
	add 0,0,9
	srawi 0,0,1
	cmpw 0,11,0
	bc 4,0,.L67
	lwz 0,400(31)
	cmpwi 0,0,400
	li 0,1
	bc 4,1,.L68
	li 0,3
.L68:
	stw 0,60(31)
.L67:
	lis 9,level+4@ha
	lfs 0,464(31)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L66
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 0,0(9)
	lwz 9,776(31)
	fadds 0,13,0
	andi. 10,9,8192
	stfs 0,464(31)
	bc 4,2,.L66
	lwz 0,400(31)
	cmpwi 0,0,400
	bc 4,1,.L72
	cmpwi 0,30,34
	bc 12,1,.L73
	lis 9,gi+16@ha
	lis 11,commander_sound_pain1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC17@ha
	mr 3,31
	lwz 5,commander_sound_pain1@l(11)
	lis 9,.LC16@ha
	la 10,.LC17@l(10)
	lis 11,.LC16@ha
	la 9,.LC16@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC16@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L66
.L73:
	rlwinm 0,9,0,16,14
	lis 11,gi+16@ha
	rlwinm 0,0,0,25,23
	lis 9,commander_sound_pain2@ha
	stw 0,776(31)
	lis 10,.LC16@ha
	mr 3,31
	lwz 0,gi+16@l(11)
	la 10,.LC16@l(10)
	li 4,2
	lwz 5,commander_sound_pain2@l(9)
	lis 11,.LC17@ha
	lis 9,.LC16@ha
	la 11,.LC17@l(11)
	lfs 2,0(10)
	mtlr 0
	la 9,.LC16@l(9)
	lfs 3,0(11)
	lfs 1,0(9)
	blrl
	bl rand
	lis 9,.LC18@ha
	rlwinm 3,3,0,17,31
	la 9,.LC18@l(9)
	xoris 3,3,0x8000
	lfd 9,0(9)
	lis 8,0x4330
	lis 10,.LC19@ha
	la 10,.LC19@l(10)
	stw 3,20(1)
	mr 11,9
	xoris 0,30,0x8000
	stw 8,16(1)
	lfd 11,0(10)
	lfd 0,16(1)
	lis 10,.LC13@ha
	lfs 10,.LC13@l(10)
	lis 9,.LC14@ha
	stw 0,20(1)
	fsub 0,0,11
	stw 8,16(1)
	lfd 13,16(1)
	lfd 12,.LC14@l(9)
	frsp 0,0
	fsub 13,13,11
	fdivs 0,0,10
	frsp 13,13
	fmr 11,0
	fmr 0,13
	fmul 0,0,12
	fcmpu 0,0,9
	bc 4,0,.L75
	fcmpu 0,11,0
	bc 12,0,.L76
	b .L74
.L75:
	fcmpu 0,11,9
	bc 4,0,.L74
.L76:
	lis 9,medic_move_pain2@ha
	la 9,medic_move_pain2@l(9)
	stw 9,772(31)
	b .L78
.L74:
	lis 9,medic_move_pain1@ha
	la 9,medic_move_pain1@l(9)
	stw 9,772(31)
	b .L78
.L72:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC19@ha
	lis 11,.LC13@ha
	la 10,.LC19@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC18@ha
	lfs 12,.LC13@l(11)
	la 10,.LC18@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L79
	lis 9,medic_move_pain1@ha
	lis 11,gi+16@ha
	la 9,medic_move_pain1@l(9)
	lis 10,sound_pain1@ha
	stw 9,772(31)
	mr 3,31
	li 4,2
	lwz 0,gi+16@l(11)
	lis 9,.LC16@ha
	lwz 5,sound_pain1@l(10)
	lis 11,.LC16@ha
	la 9,.LC16@l(9)
	lis 10,.LC17@ha
	la 11,.LC16@l(11)
	lfs 2,0(9)
	mtlr 0
	la 10,.LC17@l(10)
	lfs 1,0(11)
	lfs 3,0(10)
	blrl
	b .L78
.L79:
	lis 9,medic_move_pain2@ha
	lis 11,gi+16@ha
	la 9,medic_move_pain2@l(9)
	lis 10,sound_pain2@ha
	stw 9,772(31)
	mr 3,31
	li 4,2
	lis 9,.LC16@ha
	lwz 0,gi+16@l(11)
	la 9,.LC16@l(9)
	lis 11,.LC16@ha
	lwz 5,sound_pain2@l(10)
	lfs 1,0(9)
	la 11,.LC16@l(11)
	mtlr 0
	lis 9,.LC17@ha
	lfs 2,0(11)
	la 9,.LC17@l(9)
	lfs 3,0(9)
	blrl
.L78:
	lwz 0,776(31)
	andi. 9,0,2048
	bc 12,2,.L66
	mr 3,31
	bl monster_duck_up
.L66:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 medic_pain,.Lfe3-medic_pain
	.section	".rodata"
	.align 2
.LC20:
	.string	"tesla"
	.align 3
.LC21:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl medic_fire_blaster
	.type	 medic_fire_blaster,@function
medic_fire_blaster:
	stwu 1,-128(1)
	mflr 0
	stmw 27,108(1)
	stw 0,132(1)
	mr 31,3
	li 27,2
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L83
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L83
	lwz 11,56(31)
	xori 9,11,185
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,188
	subfic 8,0,0
	adde 0,8,0
	or. 10,9,0
	bc 12,2,.L86
	li 30,8
	b .L87
.L86:
	xori 9,11,195
	subfic 0,9,0
	adde 9,0,9
	xori 0,11,198
	subfic 8,0,0
	adde 0,8,0
	or. 10,9,0
	bc 4,2,.L89
	cmpwi 0,11,201
	bc 12,2,.L89
	cmpwi 0,11,204
	bc 4,2,.L88
.L89:
	li 30,64
	b .L87
.L88:
	li 30,0
.L87:
	addi 29,1,24
	addi 28,1,40
	mr 4,29
	addi 3,31,16
	mr 5,28
	li 6,0
	bl AngleVectors
	lis 4,monster_flash_offset+720@ha
	mr 5,29
	la 4,monster_flash_offset+720@l(4)
	mr 6,28
	addi 3,31,4
	addi 7,1,8
	bl G_ProjectSource
	lwz 9,540(31)
	lis 10,0x4330
	lfs 13,8(1)
	lis 8,.LC21@ha
	lis 4,.LC20@ha
	lfs 12,4(9)
	la 8,.LC21@l(8)
	la 4,.LC20@l(4)
	lfs 10,12(1)
	lfd 9,0(8)
	stfs 12,56(1)
	lfs 0,8(9)
	fsubs 12,12,13
	lfs 11,16(1)
	stfs 0,60(1)
	lfs 13,12(9)
	fsubs 0,0,10
	stfs 13,64(1)
	lwz 0,508(9)
	stfs 0,76(1)
	xoris 0,0,0x8000
	stfs 12,72(1)
	stw 0,100(1)
	stw 10,96(1)
	lfd 0,96(1)
	fsub 0,0,9
	frsp 0,0
	fadds 13,13,0
	fsubs 11,13,11
	stfs 13,64(1)
	stfs 11,80(1)
	lwz 3,280(9)
	bl strcmp
	srawi 8,3,31
	lwz 11,400(31)
	xor 0,8,3
	subf 0,0,8
	cmpwi 0,11,400
	srawi 0,0,31
	nor 9,0,0
	and 0,27,0
	rlwinm 9,9,0,30,31
	or 27,0,9
	bc 4,1,.L92
	mr 3,31
	mr 6,27
	mr 9,30
	addi 4,1,8
	addi 5,1,72
	li 7,1000
	li 8,146
	bl monster_fire_blaster2
	b .L83
.L92:
	mr 3,31
	mr 6,27
	mr 9,30
	addi 4,1,8
	addi 5,1,72
	li 7,1000
	li 8,60
	bl monster_fire_blaster
.L83:
	lwz 0,132(1)
	mtlr 0
	lmw 27,108(1)
	la 1,128(1)
	blr
.Lfe4:
	.size	 medic_fire_blaster,.Lfe4-medic_fire_blaster
	.section	".rodata"
	.align 2
.LC22:
	.long 0x0
	.long 0x0
	.long 0x3f800000
	.align 2
.LC25:
	.string	"models/monsters/medic/dead/tris.md2"
	.align 2
.LC26:
	.string	"mutant/mutatck2.wav"
	.align 2
.LC23:
	.long 0x46fffe00
	.align 3
.LC24:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC27:
	.long 0x0
	.align 3
.LC28:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC29:
	.long 0x41f00000
	.align 3
.LC30:
	.long 0x40080000
	.long 0x0
	.align 2
.LC31:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl medic_touch
	.type	 medic_touch,@function
medic_touch:
	stwu 1,-64(1)
	mflr 0
	stmw 27,44(1)
	stw 0,68(1)
	lis 8,.LC27@ha
	mr 30,3
	la 8,.LC27@l(8)
	lfs 0,428(30)
	lis 9,.LC22@ha
	lfs 13,0(8)
	addi 10,1,8
	mr 31,4
	lwz 8,.LC22@l(9)
	la 9,.LC22@l(9)
	fcmpu 0,0,13
	lwz 0,8(9)
	lwz 11,4(9)
	stw 8,8(1)
	stw 0,8(10)
	stw 11,4(10)
	bc 4,2,.L94
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L94
	lwz 0,480(31)
	cmpwi 0,0,0
	bc 4,1,.L94
	li 3,20
	bl GetItemByTag
	mr 29,3
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,36(1)
	lis 8,.LC28@ha
	lis 11,.LC23@ha
	stw 0,32(1)
	la 8,.LC28@l(8)
	lis 10,.LC29@ha
	lfd 0,32(1)
	la 10,.LC29@l(10)
	cmpwi 0,29,0
	lfd 11,0(8)
	lfs 13,.LC23@l(11)
	lfs 10,0(10)
	fsub 0,0,11
	mr 10,9
	frsp 0,0
	fdivs 0,0,13
	fmadds 0,0,10,10
	fmr 13,0
	fctiwz 12,13
	stfd 12,32(1)
	lwz 28,36(1)
	bc 12,2,.L94
	lwz 9,84(31)
	lwz 0,4916(9)
	cmpwi 0,0,0
	bc 4,2,.L99
	lis 9,gi+40@ha
	lwz 3,12(29)
	lwz 0,gi+40@l(9)
	mtlr 0
	blrl
	lwz 11,84(31)
	lis 10,level+4@ha
	lis 9,.LC24@ha
	lfd 13,.LC24@l(9)
	sth 3,158(11)
	lfs 0,level+4@l(10)
	lwz 9,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,5212(9)
	b .L94
.L99:
	lis 9,gi@ha
	lis 3,.LC25@ha
	la 27,gi@l(9)
	la 3,.LC25@l(3)
	lwz 9,32(27)
	mtlr 9
	blrl
	li 0,0
	stw 3,40(30)
	mr 4,28
	stw 0,56(30)
	mr 3,29
	li 5,0
	lwz 6,28(29)
	mr 7,31
	crxor 6,6,6
	bl Pickup_BAItem
	cmpwi 0,3,0
	bc 12,2,.L100
	lwz 9,84(31)
	lis 0,0x3e80
	stw 0,4716(9)
	lwz 0,40(27)
	lwz 3,12(29)
	mtlr 0
	blrl
	lis 9,itemlist@ha
	lis 0,0xba2e
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,35747
	subf 9,9,29
	sth 3,126(11)
	lis 10,level+4@ha
	mullw 9,9,0
	lwz 11,84(31)
	lis 8,.LC30@ha
	la 8,.LC30@l(8)
	srawi 9,9,2
	lfd 13,0(8)
	addi 9,9,1056
	sth 9,128(11)
	lfs 0,level+4@l(10)
	lwz 9,84(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,4836(9)
	b .L101
.L100:
	mr 4,29
	mr 5,28
	lwz 7,28(4)
	mr 3,30
	li 6,0
	bl MonsterDropItem
.L101:
	addi 5,1,8
	addi 4,30,4
	li 6,50
	li 3,1
	bl SpawnDamage
	lis 29,gi@ha
	lis 3,.LC26@ha
	la 29,gi@l(29)
	la 3,.LC26@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 11,16(29)
	lis 8,.LC31@ha
	lis 9,.LC31@ha
	lis 10,.LC27@ha
	la 8,.LC31@l(8)
	la 9,.LC31@l(9)
	la 10,.LC27@l(10)
	mtlr 11
	lfs 1,0(8)
	mr 5,3
	lfs 2,0(9)
	li 4,1
	mr 3,31
	lfs 3,0(10)
	blrl
	li 0,0
	mr 3,30
	stw 0,444(30)
	lwz 0,72(29)
	mtlr 0
	blrl
.L94:
	lwz 0,68(1)
	mtlr 0
	lmw 27,44(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 medic_touch,.Lfe5-medic_touch
	.globl medic_frames_death
	.section	".data"
	.align 2
	.type	 medic_frames_death,@object
medic_frames_death:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.size	 medic_frames_death,360
	.globl medic_move_death
	.align 2
	.type	 medic_move_death,@object
	.size	 medic_move_death,16
medic_move_death:
	.long 147
	.long 176
	.long medic_frames_death
	.long medic_dead
	.section	".rodata"
	.align 2
.LC32:
	.string	"misc/udeath.wav"
	.align 2
.LC33:
	.string	"models/objects/gibs/bone/tris.md2"
	.align 2
.LC34:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC35:
	.string	"models/objects/gibs/head2/tris.md2"
	.globl medic_frames_duck
	.section	".data"
	.align 2
	.type	 medic_frames_duck,@object
medic_frames_duck:
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long monster_duck_down
	.long ai_move
	.long 0xbf800000
	.long monster_duck_hold
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long monster_duck_up
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.size	 medic_frames_duck,192
	.globl medic_move_duck
	.align 2
	.type	 medic_move_duck,@object
	.size	 medic_move_duck,16
medic_move_duck:
	.long 131
	.long 146
	.long medic_frames_duck
	.long medic_run
	.globl medic_frames_attackHyperBlaster
	.align 2
	.type	 medic_frames_attackHyperBlaster,@object
medic_frames_attackHyperBlaster:
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long medic_fire_blaster
	.long ai_charge
	.long 0x0
	.long medic_fire_blaster
	.long ai_charge
	.long 0x0
	.long medic_fire_blaster
	.long ai_charge
	.long 0x0
	.long medic_fire_blaster
	.long ai_charge
	.long 0x0
	.long medic_fire_blaster
	.long ai_charge
	.long 0x0
	.long medic_fire_blaster
	.long ai_charge
	.long 0x0
	.long medic_fire_blaster
	.long ai_charge
	.long 0x0
	.long medic_fire_blaster
	.long ai_charge
	.long 0x0
	.long medic_fire_blaster
	.long ai_charge
	.long 0x0
	.long medic_fire_blaster
	.long ai_charge
	.long 0x0
	.long medic_fire_blaster
	.long ai_charge
	.long 0x0
	.long medic_fire_blaster
	.size	 medic_frames_attackHyperBlaster,192
	.globl medic_move_attackHyperBlaster
	.align 2
	.type	 medic_move_attackHyperBlaster,@object
	.size	 medic_move_attackHyperBlaster,16
medic_move_attackHyperBlaster:
	.long 191
	.long 206
	.long medic_frames_attackHyperBlaster
	.long medic_run
	.globl medic_frames_attackBlaster
	.align 2
	.type	 medic_frames_attackBlaster,@object
medic_frames_attackBlaster:
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x40a00000
	.long 0
	.long ai_charge
	.long 0x40a00000
	.long 0
	.long ai_charge
	.long 0x40400000
	.long 0
	.long ai_charge
	.long 0x40000000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long medic_fire_blaster
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long medic_fire_blaster
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long medic_continue
	.size	 medic_frames_attackBlaster,168
	.globl medic_move_attackBlaster
	.align 2
	.type	 medic_move_attackBlaster,@object
	.size	 medic_move_attackBlaster,16
medic_move_attackBlaster:
	.long 177
	.long 190
	.long medic_frames_attackBlaster
	.long medic_run
	.align 2
	.type	 medic_cable_offsets,@object
medic_cable_offsets:
	.long 0x42340000
	.long 0xc1133333
	.long 0x41780000
	.long 0x4241999a
	.long 0xc11b3333
	.long 0x41733333
	.long 0x423f3333
	.long 0xc11ccccd
	.long 0x417ccccd
	.long 0x423d3333
	.long 0xc114cccd
	.long 0x4164cccd
	.long 0x4235999a
	.long 0xc121999a
	.long 0x4151999a
	.long 0x4227999a
	.long 0xc14b3333
	.long 0x41400000
	.long 0x42173333
	.long 0xc17ccccd
	.long 0x41333333
	.long 0x42093333
	.long 0xc1933333
	.long 0x412b3333
	.long 0x4202cccd
	.long 0xc19d999a
	.long 0x41266666
	.long 0x4202cccd
	.long 0xc19d999a
	.long 0x41266666
	.size	 medic_cable_offsets,120
	.section	".rodata"
	.align 2
.LC38:
	.long 0x4cbebc20
	.align 2
.LC39:
	.long 0x42000000
	.align 3
.LC40:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC41:
	.long 0x3f800000
	.align 2
.LC42:
	.long 0x0
	.align 2
.LC43:
	.long 0x42400000
	.align 2
.LC44:
	.long 0x41000000
	.align 2
.LC45:
	.long 0x3f000000
	.section	".text"
	.align 2
	.globl medic_cable_attack
	.type	 medic_cable_attack,@function
medic_cable_attack:
	stwu 1,-224(1)
	mflr 0
	stmw 24,192(1)
	stw 0,228(1)
	mr 31,3
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L126
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L126
	lwz 0,64(9)
	andi. 11,0,2
	bc 12,2,.L125
.L126:
	mr 3,31
	li 4,1
	li 5,0
	b .L155
.L125:
	lwz 30,84(9)
	cmpwi 0,30,0
	bc 4,2,.L128
	lwz 0,480(9)
	cmpwi 0,0,0
	bc 4,1,.L127
.L128:
	mr 3,31
	li 4,1
	li 5,0
	b .L155
.L127:
	addi 29,1,56
	addi 27,1,72
	addi 3,31,16
	mr 4,29
	mr 5,27
	li 6,0
	bl AngleVectors
	addi 28,31,4
	mr 24,29
	lwz 9,56(31)
	lis 11,medic_cable_offsets@ha
	addi 7,1,24
	la 11,medic_cable_offsets@l(11)
	mr 26,7
	addi 9,9,-218
	addi 10,11,8
	mulli 9,9,12
	addi 8,11,4
	mr 6,27
	mr 3,28
	addi 4,1,8
	lfsx 12,10,9
	mr 5,29
	mr 25,28
	lfsx 0,8,9
	lfsx 13,11,9
	stfs 12,16(1)
	stfs 0,12(1)
	stfs 13,8(1)
	bl G_ProjectSource
	lwz 9,540(31)
	addi 3,1,152
	lfs 13,24(1)
	lfs 0,4(9)
	lfs 12,28(1)
	lfs 11,32(1)
	fsubs 13,13,0
	stfs 13,152(1)
	lfs 0,8(9)
	fsubs 12,12,0
	stfs 12,156(1)
	lfs 0,12(9)
	fsubs 11,11,0
	stfs 11,160(1)
	bl VectorLength
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L156
	lis 9,gi+48@ha
	lwz 7,540(31)
	addi 29,1,88
	lwz 0,gi+48@l(9)
	mr 3,29
	mr 4,26
	li 9,3
	addi 7,7,4
	li 5,0
	li 6,0
	mtlr 0
	mr 8,31
	blrl
	lfs 0,96(1)
	lis 9,.LC40@ha
	mr 3,29
	la 9,.LC40@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L130
	lwz 10,140(1)
	lwz 11,540(31)
	cmpw 0,10,11
	bc 12,2,.L130
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,10,0
	bc 4,2,.L131
	lwz 9,904(31)
	cmpwi 0,9,1
	bc 4,1,.L132
	mr 3,31
	li 4,1
	li 5,0
	li 6,1
	bl abortHeal
	b .L124
.L132:
	cmpwi 0,11,0
	addi 0,9,1
	stw 0,904(31)
	bc 12,2,.L133
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L133
	stw 30,916(11)
	lwz 9,540(31)
	lwz 0,776(9)
	rlwinm 0,0,0,18,16
	stw 0,776(9)
	lwz 11,540(31)
	li 0,1
	stw 0,512(11)
	lwz 3,540(31)
	bl M_SetEffects
.L133:
	li 0,228
	stw 0,780(31)
	b .L124
.L131:
	mr 3,31
	li 4,1
	li 5,0
	b .L155
.L130:
	lwz 0,56(31)
	cmpwi 0,0,219
	bc 4,2,.L136
	lwz 0,400(31)
	cmpwi 0,0,400
	bc 4,2,.L137
	lis 9,gi+16@ha
	lis 11,sound_hook_hit@ha
	lwz 3,540(31)
	lwz 0,gi+16@l(9)
	li 4,0
	lis 9,.LC41@ha
	lwz 5,sound_hook_hit@l(11)
	la 9,.LC41@l(9)
	lis 11,.LC41@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC41@l(11)
	lis 9,.LC42@ha
	lfs 2,0(11)
	la 9,.LC42@l(9)
	lfs 3,0(9)
	blrl
	b .L138
.L137:
	lis 9,gi+16@ha
	lis 11,commander_sound_hook_hit@ha
	lwz 3,540(31)
	lwz 0,gi+16@l(9)
	li 4,0
	lis 9,.LC41@ha
	lwz 5,commander_sound_hook_hit@l(11)
	la 9,.LC41@l(9)
	lis 11,.LC41@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC41@l(11)
	lis 9,.LC42@ha
	lfs 2,0(11)
	la 9,.LC42@l(9)
	lfs 3,0(9)
	blrl
.L138:
	lwz 11,540(31)
	li 10,0
	lwz 0,776(11)
	ori 0,0,16384
	stw 0,776(11)
	lwz 9,540(31)
	stw 10,512(9)
	lwz 3,540(31)
	bl M_SetEffects
	b .L139
.L136:
	cmpwi 0,0,226
	bc 4,2,.L140
	lwz 11,540(31)
	li 0,0
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lis 8,gi+48@ha
	stw 0,284(11)
	addi 6,1,168
	lwz 10,540(31)
	lfs 12,0(9)
	stw 0,776(10)
	lis 9,0x202
	lwz 11,540(31)
	ori 9,9,3
	stw 0,296(11)
	lwz 10,540(31)
	stw 0,300(10)
	lwz 11,540(31)
	stw 0,320(11)
	lwz 10,540(31)
	stw 0,316(10)
	lwz 11,540(31)
	stw 31,916(11)
	lwz 10,540(31)
	lwz 0,gi+48@l(8)
	lfs 0,200(10)
	addi 4,10,4
	mr 8,10
	mtlr 0
	addi 5,10,188
	mr 7,4
	stfs 0,168(1)
	lfs 13,204(10)
	stfs 13,172(1)
	lfs 0,208(10)
	fadds 0,0,12
	stfs 0,176(1)
	blrl
	lwz 0,92(1)
	cmpwi 0,0,0
	bc 4,2,.L156
	lwz 29,88(1)
	cmpwi 0,29,0
	bc 4,2,.L156
	lis 9,g_edicts@ha
	lwz 11,140(1)
	lwz 0,g_edicts@l(9)
	cmpw 0,11,0
	bc 12,2,.L144
.L156:
	mr 3,31
	li 4,1
	li 5,1
.L155:
	li 6,0
	bl abortHeal
	b .L124
.L144:
	lwz 9,540(31)
	lwz 0,776(9)
	oris 0,0,0x40
	stw 0,776(9)
	lwz 3,540(31)
	bl ED_CallSpawn
	lwz 11,540(31)
	lwz 0,436(11)
	cmpwi 0,0,0
	bc 12,2,.L146
	lis 9,level+4@ha
	lfs 0,level+4@l(9)
	stfs 0,428(11)
	lwz 9,540(31)
	lwz 0,436(9)
	mr 3,9
	mtlr 0
	blrl
.L146:
	lwz 9,540(31)
	lwz 0,776(9)
	rlwinm 0,0,0,18,16
	stw 0,776(9)
	lwz 11,540(31)
	lwz 0,776(11)
	oris 0,0,0x60
	stw 0,776(11)
	lwz 10,540(31)
	lwz 0,64(10)
	rlwinm 0,0,0,18,16
	stw 0,64(10)
	lwz 9,540(31)
	stw 29,916(9)
	lwz 11,544(31)
	cmpwi 0,11,0
	bc 12,2,.L147
	lwz 0,88(11)
	cmpwi 0,0,0
	bc 12,2,.L147
	lwz 0,480(11)
	cmpwi 0,0,0
	bc 4,1,.L147
	lwz 9,540(31)
	stw 11,540(9)
	lwz 3,540(31)
	bl FoundTarget
	b .L139
.L147:
	lwz 9,540(31)
	li 29,0
	stw 29,540(9)
	lwz 3,540(31)
	bl FindTarget
	cmpwi 0,3,0
	bc 4,2,.L149
	lis 9,level+4@ha
	lis 11,.LC38@ha
	lwz 10,540(31)
	lfs 0,level+4@l(9)
	lfs 13,.LC38@l(11)
	fadds 0,0,13
	stfs 0,828(10)
	lwz 9,540(31)
	lwz 0,788(9)
	mr 3,9
	mtlr 0
	blrl
.L149:
	stw 29,544(31)
	mr 3,31
	stw 29,540(31)
	bl FindTarget
	cmpwi 0,3,0
	bc 4,2,.L139
	lis 9,level+4@ha
	lis 11,.LC38@ha
	lwz 10,788(31)
	lfs 0,level+4@l(9)
	mr 3,31
	lfs 13,.LC38@l(11)
	mtlr 10
	fadds 0,0,13
	stfs 0,828(31)
	blrl
	b .L124
.L140:
	cmpwi 0,0,220
	bc 4,2,.L139
	lwz 0,400(31)
	cmpwi 0,0,400
	bc 4,2,.L153
	lis 9,gi+16@ha
	lis 11,sound_hook_heal@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,1
	lis 9,.LC41@ha
	lwz 5,sound_hook_heal@l(11)
	la 9,.LC41@l(9)
	lis 11,.LC41@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC41@l(11)
	lis 9,.LC42@ha
	lfs 2,0(11)
	la 9,.LC42@l(9)
	lfs 3,0(9)
	blrl
	b .L139
.L153:
	lis 9,gi+16@ha
	lis 11,commander_sound_hook_heal@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,1
	lis 9,.LC41@ha
	lwz 5,commander_sound_hook_heal@l(11)
	la 9,.LC41@l(9)
	lis 11,.LC41@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC41@l(11)
	lis 9,.LC42@ha
	lfs 2,0(11)
	la 9,.LC42@l(9)
	lfs 3,0(9)
	blrl
.L139:
	lis 9,.LC44@ha
	mr 4,24
	la 9,.LC44@l(9)
	mr 5,26
	lfs 1,0(9)
	mr 3,26
	bl VectorMA
	lwz 9,540(31)
	lis 11,.LC45@ha
	lis 29,gi@ha
	la 11,.LC45@l(11)
	la 29,gi@l(29)
	lfs 13,4(9)
	li 3,3
	lfs 11,0(11)
	lwz 11,100(29)
	stfs 13,40(1)
	lfs 0,8(9)
	mtlr 11
	stfs 0,44(1)
	lfs 13,12(9)
	stfs 13,48(1)
	lfs 12,220(9)
	lfs 0,244(9)
	fmadds 0,0,11,12
	stfs 0,48(1)
	blrl
	lwz 9,100(29)
	li 3,19
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xa27a
	lwz 10,104(29)
	lwz 3,g_edicts@l(9)
	ori 0,0,52719
	mtlr 10
	subf 3,3,31
	mullw 3,3,0
	srawi 3,3,2
	blrl
	lwz 9,120(29)
	mr 3,26
	mtlr 9
	blrl
	lwz 9,120(29)
	addi 3,1,40
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,25
	li 4,2
	mtlr 0
	blrl
.L124:
	lwz 0,228(1)
	mtlr 0
	lmw 24,192(1)
	la 1,224(1)
	blr
.Lfe6:
	.size	 medic_cable_attack,.Lfe6-medic_cable_attack
	.globl medic_frames_attackCable
	.section	".data"
	.align 2
	.type	 medic_frames_attackCable,@object
medic_frames_attackCable:
	.long ai_charge
	.long 0x40000000
	.long 0
	.long ai_charge
	.long 0x40400000
	.long 0
	.long ai_charge
	.long 0x40a00000
	.long 0
	.long ai_charge
	.long 0xc08ccccd
	.long 0
	.long ai_charge
	.long 0xc0966666
	.long 0
	.long ai_charge
	.long 0xc0a00000
	.long 0
	.long ai_charge
	.long 0xc0c00000
	.long 0
	.long ai_charge
	.long 0xc0800000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long medic_hook_launch
	.long ai_move
	.long 0x0
	.long medic_cable_attack
	.long ai_move
	.long 0x0
	.long medic_cable_attack
	.long ai_move
	.long 0x0
	.long medic_cable_attack
	.long ai_move
	.long 0x0
	.long medic_cable_attack
	.long ai_move
	.long 0x0
	.long medic_cable_attack
	.long ai_move
	.long 0x0
	.long medic_cable_attack
	.long ai_move
	.long 0x0
	.long medic_cable_attack
	.long ai_move
	.long 0x0
	.long medic_cable_attack
	.long ai_move
	.long 0x0
	.long medic_cable_attack
	.long ai_move
	.long 0x0
	.long medic_hook_retract
	.long ai_move
	.long 0xbfc00000
	.long 0
	.long ai_move
	.long 0xbf99999a
	.long 0
	.long ai_move
	.long 0xc0400000
	.long 0
	.long ai_move
	.long 0xc0000000
	.long 0
	.long ai_move
	.long 0x3e99999a
	.long 0
	.long ai_move
	.long 0x3f333333
	.long 0
	.long ai_move
	.long 0x3f99999a
	.long 0
	.long ai_move
	.long 0x3fa66666
	.long 0
	.size	 medic_frames_attackCable,336
	.globl medic_move_attackCable
	.align 2
	.type	 medic_move_attackCable,@object
	.size	 medic_move_attackCable,16
medic_move_attackCable:
	.long 209
	.long 236
	.long medic_frames_attackCable
	.long medic_run
	.section	".rodata"
	.align 2
.LC47:
	.long 0x46fffe00
	.align 3
.LC48:
	.long 0x3fa99999
	.long 0x9999999a
	.align 3
.LC49:
	.long 0x3fc33333
	.long 0x33333333
	.align 3
.LC50:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC51:
	.long 0x3fee6666
	.long 0x66666666
	.align 3
.LC52:
	.long 0x3feb3333
	.long 0x33333333
	.align 3
.LC53:
	.long 0x3fe66666
	.long 0x66666666
	.align 3
.LC54:
	.long 0x40768000
	.long 0x0
	.align 3
.LC55:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC56:
	.long 0x41200000
	.align 2
.LC57:
	.long 0x42000000
	.align 2
.LC58:
	.long 0x43800000
	.align 2
.LC59:
	.long 0xbf800000
	.align 2
.LC60:
	.long 0x43340000
	.section	".text"
	.align 2
	.globl medic_determine_spawn
	.type	 medic_determine_spawn,@function
medic_determine_spawn:
	stwu 1,-192(1)
	mflr 0
	stfd 31,184(1)
	stmw 15,116(1)
	stw 0,196(1)
	mr 22,3
	li 21,0
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,108(1)
	lis 11,.LC55@ha
	lis 10,.LC47@ha
	stw 0,104(1)
	la 11,.LC55@l(11)
	mr 7,9
	lfd 13,0(11)
	lis 8,.LC48@ha
	lfd 0,104(1)
	lis 11,skill@ha
	lfs 10,.LC47@l(10)
	lwz 9,skill@l(11)
	fsub 0,0,13
	lfd 11,.LC48@l(8)
	lfs 13,20(9)
	frsp 0,0
	fdivs 0,0,10
	fmr 10,0
	fctiwz 12,13
	fcmpu 0,10,11
	stfd 12,104(1)
	lwz 11,108(1)
	bc 4,0,.L165
	addi 11,11,-3
	b .L166
.L165:
	lis 9,.LC49@ha
	lfd 0,.LC49@l(9)
	fcmpu 0,10,0
	bc 4,0,.L167
	addi 11,11,-2
	b .L166
.L167:
	lis 9,.LC50@ha
	lfd 0,.LC50@l(9)
	fcmpu 0,10,0
	bc 4,0,.L169
	addi 11,11,-1
	b .L166
.L169:
	lis 9,.LC51@ha
	lfd 0,.LC51@l(9)
	fcmpu 0,10,0
	bc 4,1,.L171
	addi 11,11,3
	b .L166
.L171:
	lis 9,.LC52@ha
	lfd 0,.LC52@l(9)
	fcmpu 0,10,0
	bc 4,1,.L173
	addi 11,11,2
	b .L166
.L173:
	lis 9,.LC53@ha
	addi 0,11,1
	lfd 0,.LC53@l(9)
	fcmpu 0,10,0
	bc 4,1,.L166
	mr 11,0
.L166:
	nor 0,11,11
	addi 5,1,24
	srawi 0,0,31
	mr 18,5
	and 25,11,0
	addi 3,22,16
	stw 25,1032(22)
	addi 4,1,8
	li 6,0
	bl AngleVectors
	cmpwi 0,25,0
	bc 12,2,.L177
	srwi 9,25,31
	add 9,25,9
	rlwinm 9,9,0,0,30
	subf 9,9,25
	addi 9,9,-1
	add 28,25,9
	b .L178
.L177:
	li 28,1
.L178:
	li 29,0
	cmpw 0,29,28
	bc 4,0,.L180
	lis 9,reinforcement_position@ha
	lis 11,reinforcement_mins@ha
	mulli 20,28,12
	la 23,reinforcement_position@l(9)
	la 17,reinforcement_mins@l(11)
	lis 9,reinforcement_maxs@ha
	addi 24,1,56
	la 19,reinforcement_maxs@l(9)
	addi 26,1,72
	lis 9,.LC56@ha
	mr 27,23
	la 9,.LC56@l(9)
	lfs 31,0(9)
.L182:
	lfs 0,0(27)
	srwi 0,29,31
	addi 4,1,40
	add 0,29,0
	addi 5,1,8
	rlwinm 0,0,0,0,30
	addi 3,22,4
	stfs 0,40(1)
	subf 0,0,29
	mr 6,18
	lfs 13,4(27)
	add 31,29,0
	mr 7,24
	stfs 13,44(1)
	lfs 0,8(27)
	stfs 0,48(1)
	bl G_ProjectSource
	lfs 0,64(1)
	subf 0,31,25
	lis 9,.LC57@ha
	mulli 0,0,12
	la 9,.LC57@l(9)
	mr 3,24
	lfs 1,0(9)
	mr 6,26
	fadds 0,0,31
	add 30,0,19
	add 31,0,17
	mr 4,31
	mr 5,30
	stfs 0,64(1)
	bl FindSpawnPoint
	cmpwi 0,3,0
	bc 12,2,.L181
	lis 9,.LC58@ha
	lis 11,.LC59@ha
	la 9,.LC58@l(9)
	la 11,.LC59@l(11)
	lfs 1,0(9)
	mr 4,31
	mr 5,30
	lfs 2,0(11)
	mr 3,26
	bl CheckGroundSpawnPoint
	cmpwi 0,3,0
	bc 12,2,.L181
	addi 21,21,1
	add 27,20,23
	mr 29,28
.L181:
	addi 29,29,1
	addi 27,27,12
	cmpw 0,29,28
	bc 12,0,.L182
.L180:
	cmpwi 0,21,0
	bc 4,2,.L196
	cmpw 0,21,28
	li 29,0
	bc 4,0,.L188
	lis 9,reinforcement_position@ha
	lis 11,reinforcement_mins@ha
	mulli 19,28,12
	la 20,reinforcement_position@l(9)
	la 15,reinforcement_mins@l(11)
	lis 9,reinforcement_maxs@ha
	mr 27,20
	la 16,reinforcement_maxs@l(9)
	addi 17,27,4
	lis 9,.LC56@ha
	addi 23,1,56
	la 9,.LC56@l(9)
	addi 24,1,72
	lfs 31,0(9)
	li 26,0
.L190:
	lfs 0,0(27)
	srwi 0,29,31
	addi 4,1,40
	lfsx 13,17,26
	add 0,29,0
	addi 5,1,8
	rlwinm 0,0,0,0,30
	addi 3,22,4
	fneg 11,0
	stfs 0,40(1)
	subf 0,0,29
	mr 6,18
	stfs 13,44(1)
	fneg 12,13
	add 31,29,0
	mr 7,23
	lfs 0,8(27)
	stfs 11,40(1)
	stfs 12,44(1)
	stfs 0,48(1)
	bl G_ProjectSource
	lfs 0,64(1)
	subf 0,31,25
	lis 9,.LC57@ha
	mulli 0,0,12
	la 9,.LC57@l(9)
	mr 3,23
	lfs 1,0(9)
	mr 6,24
	fadds 0,0,31
	add 30,0,16
	add 31,0,15
	mr 4,31
	mr 5,30
	stfs 0,64(1)
	bl FindSpawnPoint
	cmpwi 0,3,0
	bc 12,2,.L189
	lis 9,.LC58@ha
	lis 11,.LC59@ha
	la 9,.LC58@l(9)
	la 11,.LC59@l(11)
	lfs 1,0(9)
	mr 4,31
	mr 5,30
	lfs 2,0(11)
	mr 3,24
	bl CheckGroundSpawnPoint
	cmpwi 0,3,0
	bc 12,2,.L189
	mulli 26,28,12
	addi 21,21,1
	add 27,19,20
	mr 29,28
.L189:
	addi 29,29,1
	addi 27,27,12
	cmpw 0,29,28
	addi 26,26,12
	bc 12,0,.L190
.L188:
	cmpwi 0,21,0
	bc 12,2,.L197
	lwz 0,776(22)
	lfs 1,20(22)
	oris 0,0,0x1
	stw 0,776(22)
	bl anglemod
	lis 9,.LC60@ha
	la 9,.LC60@l(9)
	lfs 0,0(9)
	lis 9,.LC54@ha
	lfd 13,.LC54@l(9)
	fadds 1,1,0
	fmr 0,1
	stfs 1,424(22)
	fcmpu 0,0,13
	bc 4,1,.L196
	fsub 0,0,13
	frsp 0,0
	stfs 0,424(22)
	b .L196
.L197:
	li 0,229
	stw 0,780(22)
.L196:
	lwz 0,196(1)
	mtlr 0
	lmw 15,116(1)
	lfd 31,184(1)
	la 1,192(1)
	blr
.Lfe7:
	.size	 medic_determine_spawn,.Lfe7-medic_determine_spawn
	.section	".rodata"
	.align 3
.LC61:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC62:
	.long 0x41200000
	.align 2
.LC63:
	.long 0x42000000
	.align 2
.LC64:
	.long 0x43800000
	.align 2
.LC65:
	.long 0xbf800000
	.section	".text"
	.align 2
	.globl medic_spawngrows
	.type	 medic_spawngrows,@function
medic_spawngrows:
	stwu 1,-160(1)
	mflr 0
	stfd 31,152(1)
	stmw 16,88(1)
	stw 0,164(1)
	mr 26,3
	li 20,0
	lwz 0,776(26)
	andis. 9,0,1
	bc 12,2,.L199
	lfs 1,20(26)
	bl anglemod
	lfs 13,424(26)
	lis 9,.LC61@ha
	lfd 0,.LC61@l(9)
	fsubs 1,1,13
	fabs 1,1
	fcmpu 0,1,0
	bc 4,1,.L200
	lwz 0,776(26)
	ori 0,0,128
	stw 0,776(26)
	b .L198
.L200:
	lwz 0,776(26)
	rlwinm 0,0,0,25,23
	rlwinm 0,0,0,16,14
	stw 0,776(26)
.L199:
	addi 5,1,24
	lwz 25,1032(26)
	addi 3,26,16
	mr 16,5
	addi 4,1,8
	li 6,0
	bl AngleVectors
	cmpwi 0,25,0
	bc 12,2,.L201
	srwi 9,25,31
	add 9,25,9
	rlwinm 9,9,0,0,30
	subf 9,9,25
	addi 9,9,-1
	add 22,25,9
	b .L202
.L201:
	li 22,1
.L202:
	li 27,0
	cmpw 0,27,22
	bc 4,0,.L204
	lis 9,reinforcement_position@ha
	lis 11,reinforcement_mins@ha
	la 24,reinforcement_position@l(9)
	la 17,reinforcement_mins@l(11)
	lis 9,reinforcement_maxs@ha
	addi 18,24,4
	la 19,reinforcement_maxs@l(9)
	addi 23,1,56
	lis 9,.LC62@ha
	addi 28,1,72
	la 9,.LC62@l(9)
	li 21,0
	lfs 31,0(9)
.L206:
	srwi 0,27,31
	lfs 13,0(24)
	addi 4,1,40
	add 0,27,0
	lfsx 12,18,21
	addi 5,1,8
	lfs 0,8(24)
	rlwinm 0,0,0,0,30
	addi 3,26,4
	subf 0,0,27
	stfs 13,40(1)
	mr 6,16
	add 0,27,0
	stfs 12,44(1)
	mr 7,23
	stfs 0,48(1)
	subf 29,0,25
	bl G_ProjectSource
	lfs 0,64(1)
	lis 9,.LC63@ha
	mulli 0,29,12
	mr 3,23
	la 9,.LC63@l(9)
	mr 6,28
	lfs 1,0(9)
	add 30,0,19
	add 31,0,17
	fadds 0,0,31
	mr 4,31
	mr 5,30
	stfs 0,64(1)
	bl FindSpawnPoint
	cmpwi 0,3,0
	bc 12,2,.L205
	lis 9,.LC64@ha
	mr 4,31
	la 9,.LC64@l(9)
	mr 5,30
	lfs 1,0(9)
	mr 3,28
	lis 9,.LC65@ha
	la 9,.LC65@l(9)
	lfs 2,0(9)
	bl CheckGroundSpawnPoint
	cmpwi 0,3,0
	bc 12,2,.L205
	cmpwi 0,29,3
	addi 20,20,1
	bc 4,1,.L209
	mr 3,28
	li 4,1
	bl SpawnGrow_Spawn
	b .L205
.L209:
	mr 3,28
	li 4,0
	bl SpawnGrow_Spawn
.L205:
	addi 27,27,1
	addi 24,24,12
	cmpw 0,27,22
	addi 21,21,12
	bc 12,0,.L206
.L204:
	cmpwi 0,20,0
	bc 4,2,.L198
	li 0,229
	stw 0,780(26)
.L198:
	lwz 0,164(1)
	mtlr 0
	lmw 16,88(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe8:
	.size	 medic_spawngrows,.Lfe8-medic_spawngrows
	.section	".rodata"
	.align 2
.LC66:
	.long 0x41200000
	.align 2
.LC67:
	.long 0x42000000
	.align 2
.LC68:
	.long 0x0
	.section	".text"
	.align 2
	.globl medic_finish_spawn
	.type	 medic_finish_spawn,@function
medic_finish_spawn:
	stwu 1,-160(1)
	mflr 0
	stmw 14,88(1)
	stw 0,164(1)
	mr 28,3
	lwz 0,1032(28)
	cmpwi 0,0,0
	bc 4,0,.L214
	neg 0,0
	stw 0,1032(28)
.L214:
	addi 3,28,16
	lwz 25,1032(28)
	addi 5,1,24
	mr 18,3
	addi 4,1,8
	li 6,0
	bl AngleVectors
	cmpwi 0,25,0
	bc 12,2,.L215
	srwi 9,25,31
	add 9,25,9
	rlwinm 9,9,0,0,30
	subf 9,9,25
	addi 9,9,-1
	add 21,25,9
	b .L216
.L215:
	li 21,1
.L216:
	li 26,0
	cmpw 0,26,21
	bc 4,0,.L218
	lis 9,reinforcement_position@ha
	lis 11,reinforcement_mins@ha
	la 19,reinforcement_position@l(9)
	la 14,reinforcement_mins@l(11)
	lis 9,reinforcement_maxs@ha
	lis 11,reinforcements@ha
	la 15,reinforcement_maxs@l(9)
	la 16,reinforcements@l(11)
	lis 9,level@ha
	addi 22,1,56
	la 17,level@l(9)
	addi 24,1,72
	mr 23,19
	li 20,0
.L220:
	srwi 0,26,31
	addi 9,19,4
	lfs 0,0(23)
	add 0,26,0
	lfsx 12,9,20
	addi 4,1,40
	lfs 13,8(23)
	rlwinm 0,0,0,0,30
	addi 5,1,8
	subf 0,0,26
	stfs 0,40(1)
	addi 6,1,24
	add 0,26,0
	addi 3,28,4
	stfs 12,44(1)
	stfs 13,48(1)
	subf 27,0,25
	mr 7,22
	bl G_ProjectSource
	li 29,0
	lis 9,.LC66@ha
	lfs 0,64(1)
	mulli 0,27,12
	mr 3,22
	la 9,.LC66@l(9)
	mr 6,24
	lfs 13,0(9)
	add 30,0,15
	add 31,0,14
	lis 9,.LC67@ha
	mr 4,31
	la 9,.LC67@l(9)
	mr 5,30
	fadds 0,0,13
	lfs 1,0(9)
	stfs 0,64(1)
	bl FindSpawnPoint
	cmpwi 0,3,0
	bc 12,2,.L223
	mr 3,24
	mr 4,31
	mr 5,30
	bl CheckSpawnPoint
	cmpwi 0,3,0
	bc 12,2,.L223
	slwi 0,27,2
	mr 5,31
	lwzx 7,16,0
	mr 6,30
	mr 3,24
	mr 4,18
	li 8,256
	bl CreateGroundMonster
	mr 29,3
.L223:
	cmpwi 0,29,0
	bc 12,2,.L219
	lwz 0,436(29)
	cmpwi 0,0,0
	bc 12,2,.L225
	lfs 0,4(17)
	mr 3,29
	mtlr 0
	stfs 0,428(29)
	blrl
.L225:
	lwz 0,776(29)
	stw 28,976(29)
	oris 0,0,0x160
	stw 0,776(29)
	lwz 11,776(28)
	lwz 9,968(28)
	andi. 0,11,8192
	addi 9,9,-1
	stw 9,968(28)
	bc 12,2,.L226
	lwz 3,544(28)
	b .L227
.L226:
	lwz 3,540(28)
.L227:
	lis 9,coop@ha
	lwz 9,coop@l(9)
	cmpwi 0,9,0
	bc 12,2,.L228
	lfs 13,20(9)
	lis 9,.LC68@ha
	la 9,.LC68@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L228
	mr 3,29
	bl PickCoopTarget
	mr. 3,3
	bc 12,2,.L229
	lwz 0,540(28)
	cmpw 0,3,0
	bc 4,2,.L228
	mr 3,29
	bl PickCoopTarget
	mr. 3,3
	bc 4,2,.L237
.L229:
	lwz 3,540(28)
.L228:
	cmpwi 0,3,0
	bc 12,2,.L234
.L237:
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L234
	lwz 0,480(3)
	cmpwi 0,0,0
	bc 4,1,.L234
	stw 3,540(29)
	mr 3,29
	bl FoundTarget
	b .L219
.L234:
	lwz 9,788(29)
	mr 3,29
	li 0,0
	stw 0,540(29)
	mtlr 9
	blrl
.L219:
	addi 26,26,1
	addi 23,23,12
	cmpw 0,26,21
	addi 20,20,12
	bc 12,0,.L220
.L218:
	lwz 0,164(1)
	mtlr 0
	lmw 14,88(1)
	la 1,160(1)
	blr
.Lfe9:
	.size	 medic_finish_spawn,.Lfe9-medic_finish_spawn
	.globl medic_frames_callReinforcements
	.section	".data"
	.align 2
	.type	 medic_frames_callReinforcements,@object
medic_frames_callReinforcements:
	.long ai_charge
	.long 0x40000000
	.long 0
	.long ai_charge
	.long 0x40400000
	.long 0
	.long ai_charge
	.long 0x40a00000
	.long 0
	.long ai_charge
	.long 0x408ccccd
	.long 0
	.long ai_charge
	.long 0x40966666
	.long 0
	.long ai_charge
	.long 0x40a00000
	.long 0
	.long ai_charge
	.long 0x40c00000
	.long 0
	.long ai_charge
	.long 0x40800000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long medic_start_spawn
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long medic_determine_spawn
	.long ai_charge
	.long 0x0
	.long medic_spawngrows
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0xc1700000
	.long medic_finish_spawn
	.long ai_move
	.long 0xbfc00000
	.long 0
	.long ai_move
	.long 0xbf99999a
	.long 0
	.long ai_move
	.long 0xc0400000
	.long 0
	.long ai_move
	.long 0xc0000000
	.long 0
	.long ai_move
	.long 0x3e99999a
	.long 0
	.long ai_move
	.long 0x3f333333
	.long 0
	.long ai_move
	.long 0x3f99999a
	.long 0
	.long ai_move
	.long 0x3fa66666
	.long 0
	.size	 medic_frames_callReinforcements,336
	.globl medic_move_callReinforcements
	.align 2
	.type	 medic_move_callReinforcements,@object
	.size	 medic_move_callReinforcements,16
medic_move_callReinforcements:
	.long 209
	.long 236
	.long medic_frames_callReinforcements
	.long medic_run
	.section	".rodata"
	.align 2
.LC69:
	.long 0x46fffe00
	.align 3
.LC70:
	.long 0x3fe99999
	.long 0x9999999a
	.align 3
.LC71:
	.long 0x3fc99999
	.long 0x9999999a
	.align 3
.LC72:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl medic_attack
	.type	 medic_attack,@function
medic_attack:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	bl monster_done_dodge
	lwz 4,540(31)
	mr 3,31
	bl range
	lwz 0,776(31)
	mr 30,3
	andis. 9,0,1024
	bc 12,2,.L239
	lis 9,medic_move_callReinforcements@ha
	rlwinm 0,0,0,6,4
	la 9,medic_move_callReinforcements@l(9)
	stw 0,776(31)
	stw 9,772(31)
.L239:
	bl rand
	rlwinm 3,3,0,17,31
	lwz 10,776(31)
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC72@ha
	la 11,.LC72@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	andi. 0,10,8192
	lfd 0,16(1)
	lis 11,.LC69@ha
	lfs 12,.LC69@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	bc 12,2,.L240
	lwz 0,400(31)
	cmpwi 0,0,400
	bc 4,1,.L241
	fmr 13,0
	lis 9,.LC70@ha
	lfd 0,.LC70@l(9)
	fcmpu 0,13,0
	bc 4,1,.L241
	lwz 0,968(31)
	cmpwi 0,0,2
	bc 4,1,.L241
	lis 9,medic_move_callReinforcements@ha
	la 9,medic_move_callReinforcements@l(9)
	b .L247
.L241:
	lis 9,medic_move_attackCable@ha
	la 9,medic_move_attackCable@l(9)
	b .L247
.L240:
	lwz 0,868(31)
	cmpwi 0,0,5
	bc 4,2,.L244
	lis 9,medic_move_callReinforcements@ha
	la 9,medic_move_callReinforcements@l(9)
	b .L247
.L244:
	lwz 0,400(31)
	cmpwi 0,0,400
	bc 4,1,.L245
	fmr 13,0
	lis 9,.LC71@ha
	addic 0,30,-1
	subfe 11,0,30
	lfd 0,.LC71@l(9)
	fcmpu 7,13,0
	mfcr 0
	rlwinm 0,0,30,1
	and. 9,0,11
	bc 12,2,.L245
	lwz 0,968(31)
	cmpwi 0,0,2
	bc 4,1,.L245
	lis 9,medic_move_callReinforcements@ha
	la 9,medic_move_callReinforcements@l(9)
	b .L247
.L245:
	lis 9,medic_move_attackBlaster@ha
	la 9,medic_move_attackBlaster@l(9)
.L247:
	stw 9,772(31)
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 medic_attack,.Lfe10-medic_attack
	.section	".rodata"
	.align 2
.LC73:
	.long 0x46fffe00
	.align 3
.LC74:
	.long 0x3fe99999
	.long 0x9999999a
	.align 2
.LC75:
	.long 0x43cd0000
	.align 3
.LC76:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC77:
	.long 0x43160000
	.align 2
.LC78:
	.long 0x0
	.section	".text"
	.align 2
	.globl medic_checkattack
	.type	 medic_checkattack,@function
medic_checkattack:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,776(31)
	andi. 9,0,8192
	bc 12,2,.L249
	lwz 4,540(31)
	cmpwi 0,4,0
	bc 12,2,.L251
	lwz 0,88(4)
	cmpwi 0,0,0
	bc 4,2,.L250
.L251:
	mr 3,31
	li 4,1
	li 5,0
	li 6,0
	bl abortHeal
	li 3,0
	b .L259
.L250:
	lis 9,level+4@ha
	lfs 13,288(31)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L252
	mr 3,31
	li 4,1
	li 5,0
	li 6,1
	bl abortHeal
	li 0,0
	li 3,0
	stw 0,288(31)
	b .L259
.L252:
	mr 3,31
	bl realrange
	lis 9,.LC75@ha
	la 9,.LC75@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,0,.L253
	mr 3,31
	bl medic_attack
	li 3,1
	b .L259
.L253:
	li 0,1
	li 3,0
	stw 0,868(31)
	b .L259
.L249:
	lwz 4,540(31)
	lwz 0,84(4)
	cmpwi 0,0,0
	bc 12,2,.L255
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 4,2,.L255
	lwz 0,968(31)
	cmpwi 0,0,2
	bc 4,1,.L255
	li 0,5
	b .L260
.L255:
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC76@ha
	lis 10,.LC73@ha
	la 11,.LC76@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC74@ha
	lfs 11,.LC73@l(10)
	lfd 12,.LC74@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,0,.L256
	lwz 0,968(31)
	cmpwi 0,0,5
	bc 4,1,.L256
	lwz 4,540(31)
	mr 3,31
	bl realrange
	lis 9,.LC77@ha
	la 9,.LC77@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 4,1,.L256
	lwz 0,776(31)
	li 9,4
	li 3,1
	stw 9,868(31)
	oris 0,0,0x400
	stw 0,776(31)
	b .L259
.L256:
	lis 9,.LC78@ha
	lis 11,skill@ha
	la 9,.LC78@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,1,.L257
	lwz 0,776(31)
	andi. 11,0,1
	bc 12,2,.L257
	li 0,4
.L260:
	li 3,1
	stw 0,868(31)
	b .L259
.L257:
	mr 3,31
	bl M_CheckAttack
.L259:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 medic_checkattack,.Lfe11-medic_checkattack
	.section	".rodata"
	.align 2
.LC79:
	.string	"models/items/spawngro/tris.md2"
	.align 2
.LC80:
	.string	"models/items/spawngro2/tris.md2"
	.align 2
.LC83:
	.string	"models/monsters/medic/tris.md2"
	.align 2
.LC84:
	.string	"monster_medic_commander"
	.align 2
.LC85:
	.string	"medic_commander/medidle.wav"
	.align 2
.LC86:
	.string	"medic_commander/medpain1.wav"
	.align 2
.LC87:
	.string	"medic_commander/medpain2.wav"
	.align 2
.LC88:
	.string	"medic_commander/meddeth.wav"
	.align 2
.LC89:
	.string	"medic_commander/medsght.wav"
	.align 2
.LC90:
	.string	"medic_commander/medsrch.wav"
	.align 2
.LC91:
	.string	"medic_commander/medatck2c.wav"
	.align 2
.LC92:
	.string	"medic_commander/medatck3a.wav"
	.align 2
.LC93:
	.string	"medic_commander/medatck4a.wav"
	.align 2
.LC94:
	.string	"medic_commander/medatck5a.wav"
	.align 2
.LC95:
	.string	"medic_commander/monsterspawn1.wav"
	.align 2
.LC96:
	.string	"tank/tnkatck3.wav"
	.align 2
.LC97:
	.string	"medic/idle.wav"
	.align 2
.LC98:
	.string	"medic/medpain1.wav"
	.align 2
.LC99:
	.string	"medic/medpain2.wav"
	.align 2
.LC100:
	.string	"medic/meddeth1.wav"
	.align 2
.LC101:
	.string	"medic/medsght1.wav"
	.align 2
.LC102:
	.string	"medic/medsrch1.wav"
	.align 2
.LC103:
	.string	"medic/medatck2.wav"
	.align 2
.LC104:
	.string	"medic/medatck3.wav"
	.align 2
.LC105:
	.string	"medic/medatck4.wav"
	.align 2
.LC106:
	.string	"medic/medatck5.wav"
	.align 2
.LC107:
	.string	"medic/medatck1.wav"
	.align 2
.LC108:
	.long 0x0
	.align 2
.LC109:
	.long 0x3f800000
	.align 2
.LC110:
	.long 0x40000000
	.align 2
.LC111:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl SP_monster_medic
	.type	 SP_monster_medic,@function
SP_monster_medic:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 22,16(1)
	stw 0,68(1)
	lis 11,.LC108@ha
	lis 9,deathmatch@ha
	la 11,.LC108@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L285
	bl G_FreeEdict
	b .L284
.L285:
	li 0,5
	li 9,2
	lis 29,gi@ha
	stw 0,260(31)
	lis 3,.LC25@ha
	la 29,gi@l(29)
	stw 9,248(31)
	la 3,.LC25@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lwz 0,32(29)
	lis 3,.LC83@ha
	la 3,.LC83@l(3)
	mtlr 0
	blrl
	stw 3,40(31)
	lis 0,0xc1c0
	lis 11,0x41c0
	lis 9,0x4200
	lwz 3,280(31)
	lis 4,.LC84@ha
	stw 0,196(31)
	la 4,.LC84@l(4)
	stw 11,204(31)
	stw 9,208(31)
	stw 0,188(31)
	stw 0,192(31)
	stw 11,200(31)
	bl strcmp
	cmpwi 0,3,0
	bc 4,2,.L286
	lis 9,reinforcements@ha
	li 11,600
	la 27,reinforcements@l(9)
	li 0,-130
	stw 11,400(31)
	lis 9,0x4220
	lis 30,vec3_origin@ha
	stw 0,488(31)
	la 28,vec3_origin@l(30)
	addi 26,27,24
	stw 9,420(31)
	stw 11,480(31)
.L289:
	bl G_Spawn
	lfs 13,vec3_origin@l(30)
	mr 29,3
	stfs 13,4(29)
	lfs 0,4(28)
	stfs 0,8(29)
	lfs 13,8(28)
	stfs 13,12(29)
	lfs 0,vec3_origin@l(30)
	stfs 0,16(29)
	lfs 13,4(28)
	stfs 13,20(29)
	lfs 0,8(28)
	stfs 0,24(29)
	lwz 3,0(27)
	addi 27,27,4
	bl ED_NewString
	lwz 0,776(29)
	stw 3,280(29)
	oris 0,0,0x40
	mr 3,29
	stw 0,776(29)
	bl ED_CallSpawn
	mr 3,29
	bl G_FreeEdict
	cmpw 0,27,26
	bc 4,1,.L289
	lis 29,gi@ha
	lis 3,.LC79@ha
	la 29,gi@l(29)
	la 3,.LC79@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lwz 0,32(29)
	lis 3,.LC80@ha
	la 3,.LC80@l(3)
	mtlr 0
	blrl
	b .L293
.L286:
	li 0,300
	li 9,-130
	li 11,400
	stw 0,480(31)
	stw 9,488(31)
	stw 11,400(31)
.L293:
	lis 9,medic_pain@ha
	lwz 0,264(31)
	lis 11,medic_die@ha
	la 9,medic_pain@l(9)
	lis 10,medic_stand@ha
	stw 9,452(31)
	lis 8,medic_walk@ha
	lis 7,medic_run@ha
	lis 9,gi@ha
	lis 6,M_MonsterDodge@ha
	la 30,gi@l(9)
	lis 5,medic_duck@ha
	lis 4,monster_duck_up@ha
	lis 3,medic_sidestep@ha
	lis 29,medic_attack@ha
	lis 28,medic_sight@ha
	lis 27,medic_idle@ha
	lis 26,medic_search@ha
	lis 25,medic_checkattack@ha
	lis 24,medic_blocked@ha
	lis 23,MedicDMGAdjust@ha
	lis 9,.LC109@ha
	oris 0,0,0x2
	la 11,medic_die@l(11)
	la 10,medic_stand@l(10)
	la 8,medic_walk@l(8)
	stw 0,264(31)
	la 7,medic_run@l(7)
	la 6,M_MonsterDodge@l(6)
	stw 11,456(31)
	la 5,medic_duck@l(5)
	la 4,monster_duck_up@l(4)
	stw 10,788(31)
	la 3,medic_sidestep@l(3)
	la 29,medic_attack@l(29)
	stw 8,800(31)
	la 28,medic_sight@l(28)
	la 27,medic_idle@l(27)
	stw 7,804(31)
	la 26,medic_search@l(26)
	la 25,medic_checkattack@l(25)
	stw 6,808(31)
	la 24,medic_blocked@l(24)
	la 23,MedicDMGAdjust@l(23)
	stw 5,920(31)
	la 9,.LC109@l(9)
	li 22,0
	stw 4,924(31)
	stw 3,928(31)
	lfs 31,0(9)
	mr 3,31
	stw 29,812(31)
	stw 28,820(31)
	stw 27,792(31)
	stw 26,796(31)
	stw 25,824(31)
	stw 24,892(31)
	stw 23,1000(31)
	stw 22,816(31)
	lwz 9,72(30)
	mtlr 9
	blrl
	lis 9,medic_move_stand@ha
	stfs 31,784(31)
	mr 3,31
	la 9,medic_move_stand@l(9)
	stw 9,772(31)
	bl walkmonster_start
	lwz 9,400(31)
	lwz 0,776(31)
	cmpwi 0,9,400
	oris 0,0,0x20
	stw 0,776(31)
	bc 4,1,.L294
	lis 9,skill@ha
	li 0,2
	lwz 11,skill@l(9)
	lis 9,.LC108@ha
	stw 0,60(31)
	la 9,.LC108@l(9)
	lfs 13,20(11)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L295
	li 0,3
	b .L303
.L295:
	fcmpu 0,13,31
	bc 4,2,.L297
	li 0,4
	b .L303
.L297:
	lis 11,.LC110@ha
	la 11,.LC110@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 12,2,.L304
	lis 9,.LC111@ha
	la 9,.LC111@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L296
.L304:
	li 0,6
.L303:
	stw 0,968(31)
.L296:
	lis 29,gi@ha
	lis 3,.LC85@ha
	la 29,gi@l(29)
	la 3,.LC85@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,commander_sound_idle1@ha
	lis 11,.LC86@ha
	stw 3,commander_sound_idle1@l(9)
	mtlr 10
	la 3,.LC86@l(11)
	blrl
	lwz 10,36(29)
	lis 9,commander_sound_pain1@ha
	lis 11,.LC87@ha
	stw 3,commander_sound_pain1@l(9)
	mtlr 10
	la 3,.LC87@l(11)
	blrl
	lwz 10,36(29)
	lis 9,commander_sound_pain2@ha
	lis 11,.LC88@ha
	stw 3,commander_sound_pain2@l(9)
	mtlr 10
	la 3,.LC88@l(11)
	blrl
	lwz 10,36(29)
	lis 9,commander_sound_die@ha
	lis 11,.LC89@ha
	stw 3,commander_sound_die@l(9)
	mtlr 10
	la 3,.LC89@l(11)
	blrl
	lwz 10,36(29)
	lis 9,commander_sound_sight@ha
	lis 11,.LC90@ha
	stw 3,commander_sound_sight@l(9)
	mtlr 10
	la 3,.LC90@l(11)
	blrl
	lwz 10,36(29)
	lis 9,commander_sound_search@ha
	lis 11,.LC91@ha
	stw 3,commander_sound_search@l(9)
	mtlr 10
	la 3,.LC91@l(11)
	blrl
	lwz 10,36(29)
	lis 9,commander_sound_hook_launch@ha
	lis 11,.LC92@ha
	stw 3,commander_sound_hook_launch@l(9)
	mtlr 10
	la 3,.LC92@l(11)
	blrl
	lwz 10,36(29)
	lis 9,commander_sound_hook_hit@ha
	lis 11,.LC93@ha
	stw 3,commander_sound_hook_hit@l(9)
	mtlr 10
	la 3,.LC93@l(11)
	blrl
	lwz 10,36(29)
	lis 9,commander_sound_hook_heal@ha
	lis 11,.LC94@ha
	stw 3,commander_sound_hook_heal@l(9)
	mtlr 10
	la 3,.LC94@l(11)
	blrl
	lis 9,commander_sound_hook_retract@ha
	lwz 10,36(29)
	lis 11,.LC95@ha
	stw 3,commander_sound_hook_retract@l(9)
	la 3,.LC95@l(11)
	mtlr 10
	blrl
	lwz 0,36(29)
	lis 9,commander_sound_spawn@ha
	lis 11,.LC96@ha
	stw 3,commander_sound_spawn@l(9)
	la 3,.LC96@l(11)
	mtlr 0
	blrl
	b .L284
.L294:
	lwz 9,36(30)
	lis 3,.LC97@ha
	la 3,.LC97@l(3)
	mtlr 9
	blrl
	lwz 10,36(30)
	lis 9,sound_idle1@ha
	lis 11,.LC98@ha
	stw 3,sound_idle1@l(9)
	mtlr 10
	la 3,.LC98@l(11)
	blrl
	lwz 10,36(30)
	lis 9,sound_pain1@ha
	lis 11,.LC99@ha
	stw 3,sound_pain1@l(9)
	mtlr 10
	la 3,.LC99@l(11)
	blrl
	lwz 10,36(30)
	lis 9,sound_pain2@ha
	lis 11,.LC100@ha
	stw 3,sound_pain2@l(9)
	mtlr 10
	la 3,.LC100@l(11)
	blrl
	lwz 10,36(30)
	lis 9,sound_die@ha
	lis 11,.LC101@ha
	stw 3,sound_die@l(9)
	mtlr 10
	la 3,.LC101@l(11)
	blrl
	lwz 10,36(30)
	lis 9,sound_sight@ha
	lis 11,.LC102@ha
	stw 3,sound_sight@l(9)
	mtlr 10
	la 3,.LC102@l(11)
	blrl
	lwz 10,36(30)
	lis 9,sound_search@ha
	lis 11,.LC103@ha
	stw 3,sound_search@l(9)
	mtlr 10
	la 3,.LC103@l(11)
	blrl
	lwz 10,36(30)
	lis 9,sound_hook_launch@ha
	lis 11,.LC104@ha
	stw 3,sound_hook_launch@l(9)
	mtlr 10
	la 3,.LC104@l(11)
	blrl
	lwz 10,36(30)
	lis 9,sound_hook_hit@ha
	lis 11,.LC105@ha
	stw 3,sound_hook_hit@l(9)
	mtlr 10
	la 3,.LC105@l(11)
	blrl
	lwz 10,36(30)
	lis 9,sound_hook_heal@ha
	lis 11,.LC106@ha
	stw 3,sound_hook_heal@l(9)
	mtlr 10
	la 3,.LC106@l(11)
	blrl
	lwz 0,36(30)
	lis 9,sound_hook_retract@ha
	lis 11,.LC107@ha
	stw 3,sound_hook_retract@l(9)
	la 3,.LC107@l(11)
	mtlr 0
	blrl
	stw 22,60(31)
.L284:
	lwz 0,68(1)
	mtlr 0
	lmw 22,16(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe12:
	.size	 SP_monster_medic,.Lfe12-SP_monster_medic
	.section	".sbss","aw",@nobits
	.align 2
sound_idle1:
	.space	4
	.size	 sound_idle1,4
	.align 2
sound_pain1:
	.space	4
	.size	 sound_pain1,4
	.align 2
sound_pain2:
	.space	4
	.size	 sound_pain2,4
	.align 2
sound_die:
	.space	4
	.size	 sound_die,4
	.align 2
sound_sight:
	.space	4
	.size	 sound_sight,4
	.align 2
sound_search:
	.space	4
	.size	 sound_search,4
	.align 2
sound_hook_launch:
	.space	4
	.size	 sound_hook_launch,4
	.align 2
sound_hook_hit:
	.space	4
	.size	 sound_hook_hit,4
	.align 2
sound_hook_heal:
	.space	4
	.size	 sound_hook_heal,4
	.align 2
sound_hook_retract:
	.space	4
	.size	 sound_hook_retract,4
	.align 2
commander_sound_idle1:
	.space	4
	.size	 commander_sound_idle1,4
	.align 2
commander_sound_pain1:
	.space	4
	.size	 commander_sound_pain1,4
	.align 2
commander_sound_pain2:
	.space	4
	.size	 commander_sound_pain2,4
	.align 2
commander_sound_die:
	.space	4
	.size	 commander_sound_die,4
	.align 2
commander_sound_sight:
	.space	4
	.size	 commander_sound_sight,4
	.align 2
commander_sound_search:
	.space	4
	.size	 commander_sound_search,4
	.align 2
commander_sound_hook_launch:
	.space	4
	.size	 commander_sound_hook_launch,4
	.align 2
commander_sound_hook_hit:
	.space	4
	.size	 commander_sound_hook_hit,4
	.align 2
commander_sound_hook_heal:
	.space	4
	.size	 commander_sound_hook_heal,4
	.align 2
commander_sound_hook_retract:
	.space	4
	.size	 commander_sound_hook_retract,4
	.align 2
commander_sound_spawn:
	.space	4
	.size	 commander_sound_spawn,4
	.section	".text"
	.align 2
	.globl cleanupHeal
	.type	 cleanupHeal,@function
cleanupHeal:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,3
	mr 30,4
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L7
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L7
	li 0,0
	li 10,1
	stw 0,916(9)
	lwz 11,540(31)
	lwz 0,776(11)
	rlwinm 0,0,0,18,16
	stw 0,776(11)
	lwz 9,540(31)
	stw 10,512(9)
	lwz 3,540(31)
	bl M_SetEffects
.L7:
	cmpwi 0,30,0
	bc 12,2,.L8
	li 0,228
	stw 0,780(31)
.L8:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe13:
	.size	 cleanupHeal,.Lfe13-cleanupHeal
	.section	".rodata"
	.align 3
.LC112:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC113:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl canReach
	.type	 canReach,@function
canReach:
	stwu 1,-144(1)
	mflr 0
	stmw 27,124(1)
	stw 0,148(1)
	mr 28,3
	mr 31,4
	lwz 0,508(28)
	lis 7,0x4330
	lwz 10,508(31)
	mr 29,11
	lis 9,.LC112@ha
	xoris 0,0,0x8000
	la 9,.LC112@l(9)
	lfs 7,12(28)
	stw 0,116(1)
	xoris 10,10,0x8000
	lis 27,gi+48@ha
	stw 7,112(1)
	lis 5,vec3_origin@ha
	mr 8,28
	lfd 13,112(1)
	la 5,vec3_origin@l(5)
	addi 3,1,40
	stw 10,116(1)
	addi 4,1,8
	mr 6,5
	stw 7,112(1)
	lfd 11,0(9)
	addi 7,1,24
	lfd 0,112(1)
	lis 9,0x600
	lfs 12,12(31)
	ori 9,9,59
	fsub 13,13,11
	lwz 0,gi+48@l(27)
	fsub 0,0,11
	lfs 10,4(28)
	lfs 11,8(28)
	mtlr 0
	frsp 13,13
	lfs 9,4(31)
	frsp 0,0
	lfs 8,8(31)
	stfs 10,8(1)
	fadds 7,7,13
	stfs 11,12(1)
	fadds 12,12,0
	stfs 9,24(1)
	stfs 8,28(1)
	stfs 7,16(1)
	stfs 12,32(1)
	blrl
	lfs 0,48(1)
	lis 9,.LC113@ha
	la 9,.LC113@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,2,.L23
	lwz 0,92(1)
	cmpw 0,0,31
	bc 4,2,.L22
.L23:
	li 3,1
	b .L305
.L22:
	li 3,0
.L305:
	lwz 0,148(1)
	mtlr 0
	lmw 27,124(1)
	la 1,144(1)
	blr
.Lfe14:
	.size	 canReach,.Lfe14-canReach
	.section	".rodata"
	.align 2
.LC114:
	.long 0x3f800000
	.align 2
.LC115:
	.long 0x40000000
	.align 2
.LC116:
	.long 0x0
	.section	".text"
	.align 2
	.globl medic_idle
	.type	 medic_idle,@function
medic_idle:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,400(31)
	cmpwi 0,0,400
	bc 4,2,.L47
	lis 9,gi+16@ha
	lis 11,sound_idle1@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC114@ha
	lwz 5,sound_idle1@l(11)
	la 9,.LC114@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC115@ha
	la 9,.LC115@l(9)
	lfs 2,0(9)
	lis 9,.LC116@ha
	la 9,.LC116@l(9)
	lfs 3,0(9)
	blrl
	b .L48
.L47:
	lis 9,gi+16@ha
	lis 11,commander_sound_idle1@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC114@ha
	lwz 5,commander_sound_idle1@l(11)
	la 9,.LC114@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC115@ha
	la 9,.LC115@l(9)
	lfs 2,0(9)
	lis 9,.LC116@ha
	la 9,.LC116@l(9)
	lfs 3,0(9)
	blrl
.L48:
	lwz 0,544(31)
	cmpwi 0,0,0
	bc 4,2,.L49
	mr 3,31
	bl medic_FindDeadMonster
	mr. 9,3
	bc 12,2,.L49
	lwz 0,540(31)
	mr 3,31
	stw 9,540(31)
	stw 0,544(31)
	stw 31,916(9)
	lwz 0,776(31)
	ori 0,0,8192
	stw 0,776(31)
	bl FoundTarget
.L49:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe15:
	.size	 medic_idle,.Lfe15-medic_idle
	.section	".rodata"
	.align 2
.LC117:
	.long 0x3f800000
	.align 2
.LC118:
	.long 0x40000000
	.align 2
.LC119:
	.long 0x0
	.section	".text"
	.align 2
	.globl medic_search
	.type	 medic_search,@function
medic_search:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,400(31)
	cmpwi 0,0,400
	bc 4,2,.L52
	lis 9,gi+16@ha
	lis 11,sound_search@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC117@ha
	lwz 5,sound_search@l(11)
	la 9,.LC117@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC118@ha
	la 9,.LC118@l(9)
	lfs 2,0(9)
	lis 9,.LC119@ha
	la 9,.LC119@l(9)
	lfs 3,0(9)
	blrl
	b .L53
.L52:
	lis 9,gi+16@ha
	lis 11,commander_sound_search@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC117@ha
	lwz 5,commander_sound_search@l(11)
	la 9,.LC117@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC118@ha
	la 9,.LC118@l(9)
	lfs 2,0(9)
	lis 9,.LC119@ha
	la 9,.LC119@l(9)
	lfs 3,0(9)
	blrl
.L53:
	lwz 0,544(31)
	cmpwi 0,0,0
	bc 4,2,.L54
	mr 3,31
	bl medic_FindDeadMonster
	mr. 9,3
	bc 12,2,.L54
	lwz 0,540(31)
	mr 3,31
	stw 9,540(31)
	stw 0,544(31)
	stw 31,916(9)
	lwz 0,776(31)
	ori 0,0,8192
	stw 0,776(31)
	bl FoundTarget
.L54:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe16:
	.size	 medic_search,.Lfe16-medic_search
	.section	".rodata"
	.align 2
.LC120:
	.long 0x3f800000
	.align 2
.LC121:
	.long 0x0
	.section	".text"
	.align 2
	.globl medic_sight
	.type	 medic_sight,@function
medic_sight:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,400(3)
	cmpwi 0,0,400
	bc 4,2,.L57
	lis 9,gi+16@ha
	lis 11,sound_sight@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC120@ha
	lwz 5,sound_sight@l(11)
	la 9,.LC120@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC120@ha
	la 9,.LC120@l(9)
	lfs 2,0(9)
	lis 9,.LC121@ha
	la 9,.LC121@l(9)
	lfs 3,0(9)
	blrl
	b .L58
.L57:
	lis 9,gi+16@ha
	lis 11,commander_sound_sight@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC120@ha
	lwz 5,commander_sound_sight@l(11)
	la 9,.LC120@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC120@ha
	la 9,.LC120@l(9)
	lfs 2,0(9)
	lis 9,.LC121@ha
	la 9,.LC121@l(9)
	lfs 3,0(9)
	blrl
.L58:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 medic_sight,.Lfe17-medic_sight
	.align 2
	.globl medic_stand
	.type	 medic_stand,@function
medic_stand:
	lis 9,medic_move_stand@ha
	la 9,medic_move_stand@l(9)
	stw 9,772(3)
	blr
.Lfe18:
	.size	 medic_stand,.Lfe18-medic_stand
	.align 2
	.globl medic_walk
	.type	 medic_walk,@function
medic_walk:
	lis 9,medic_move_walk@ha
	la 9,medic_move_walk@l(9)
	stw 9,772(3)
	blr
.Lfe19:
	.size	 medic_walk,.Lfe19-medic_walk
	.align 2
	.globl medic_run
	.type	 medic_run,@function
medic_run:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl monster_done_dodge
	lwz 0,776(31)
	andi. 9,0,8192
	bc 4,2,.L62
	mr 3,31
	bl medic_FindDeadMonster
	mr. 9,3
	bc 12,2,.L62
	lwz 0,540(31)
	mr 3,31
	stw 9,540(31)
	stw 0,544(31)
	stw 31,916(9)
	lwz 0,776(31)
	ori 0,0,8192
	stw 0,776(31)
	bl FoundTarget
	b .L61
.L62:
	lwz 0,776(31)
	andi. 9,0,1
	bc 12,2,.L64
	lis 9,medic_move_stand@ha
	la 9,medic_move_stand@l(9)
	b .L306
.L64:
	lis 9,medic_move_run@ha
	la 9,medic_move_run@l(9)
.L306:
	stw 9,772(31)
.L61:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe20:
	.size	 medic_run,.Lfe20-medic_run
	.align 2
	.globl medic_dead
	.type	 medic_dead,@function
medic_dead:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lis 11,0xc1c0
	lwz 0,184(9)
	lis 10,medic_touch@ha
	lis 5,0xc180
	stw 11,196(9)
	lis 4,0x4180
	la 10,medic_touch@l(10)
	ori 0,0,2
	lis 8,0xc100
	stw 5,192(9)
	li 7,7
	li 11,0
	stw 4,204(9)
	stw 8,208(9)
	lis 6,gi+72@ha
	stw 7,260(9)
	stw 0,184(9)
	stw 11,428(9)
	stw 10,444(9)
	stw 5,188(9)
	stw 4,200(9)
	lwz 0,gi+72@l(6)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 medic_dead,.Lfe21-medic_dead
	.section	".rodata"
	.align 2
.LC122:
	.long 0x3f800000
	.align 2
.LC123:
	.long 0x0
	.section	".text"
	.align 2
	.globl medic_die
	.type	 medic_die,@function
medic_die:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 30,3
	mr 28,6
	lwz 9,480(30)
	lwz 0,488(30)
	cmpw 0,9,0
	bc 12,1,.L104
	lis 29,gi@ha
	lis 3,.LC32@ha
	la 29,gi@l(29)
	la 3,.LC32@l(3)
	lwz 9,36(29)
	lis 27,.LC33@ha
	lis 26,.LC34@ha
	li 31,2
	mtlr 9
	blrl
	lis 9,.LC122@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC122@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,30
	mtlr 0
	lis 9,.LC122@ha
	la 9,.LC122@l(9)
	lfs 2,0(9)
	lis 9,.LC123@ha
	la 9,.LC123@l(9)
	lfs 3,0(9)
	blrl
.L108:
	mr 3,30
	la 4,.LC33@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L108
	li 31,4
.L113:
	mr 3,30
	la 4,.LC34@l(26)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 31,31,-1
	bc 4,2,.L113
	lis 4,.LC35@ha
	mr 5,28
	la 4,.LC35@l(4)
	mr 3,30
	li 6,0
	bl ThrowHead
	li 0,2
	stw 0,492(30)
	b .L103
.L104:
	lwz 0,492(30)
	cmpwi 0,0,2
	bc 12,2,.L103
	lwz 0,400(30)
	cmpwi 0,0,400
	bc 4,2,.L116
	lis 9,gi+16@ha
	lis 11,sound_die@ha
	lwz 0,gi+16@l(9)
	mr 3,30
	li 4,2
	lis 9,.LC122@ha
	lwz 5,sound_die@l(11)
	la 9,.LC122@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC122@ha
	la 9,.LC122@l(9)
	lfs 2,0(9)
	lis 9,.LC123@ha
	la 9,.LC123@l(9)
	lfs 3,0(9)
	blrl
	b .L117
.L116:
	lis 9,gi+16@ha
	lis 11,commander_sound_die@ha
	lwz 0,gi+16@l(9)
	mr 3,30
	li 4,2
	lis 9,.LC122@ha
	lwz 5,commander_sound_die@l(11)
	la 9,.LC122@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC122@ha
	la 9,.LC122@l(9)
	lfs 2,0(9)
	lis 9,.LC123@ha
	la 9,.LC123@l(9)
	lfs 3,0(9)
	blrl
.L117:
	lis 9,medic_move_death@ha
	li 0,2
	la 9,medic_move_death@l(9)
	li 11,1
	stw 0,492(30)
	stw 9,772(30)
	stw 11,512(30)
.L103:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 medic_die,.Lfe22-medic_die
	.section	".rodata"
	.align 2
.LC124:
	.long 0x46fffe00
	.align 3
.LC125:
	.long 0x3fee6666
	.long 0x66666666
	.align 3
.LC126:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl medic_continue
	.type	 medic_continue,@function
medic_continue:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 4,540(31)
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L119
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC126@ha
	lis 10,.LC124@ha
	la 11,.LC126@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC125@ha
	lfs 11,.LC124@l(10)
	lfd 12,.LC125@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,0
	bc 4,3,.L119
	lis 9,medic_move_attackHyperBlaster@ha
	la 9,medic_move_attackHyperBlaster@l(9)
	stw 9,772(31)
.L119:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 medic_continue,.Lfe23-medic_continue
	.section	".rodata"
	.align 2
.LC127:
	.long 0x3f800000
	.align 2
.LC128:
	.long 0x0
	.section	".text"
	.align 2
	.globl medic_hook_launch
	.type	 medic_hook_launch,@function
medic_hook_launch:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,400(3)
	cmpwi 0,0,400
	bc 4,2,.L122
	lis 9,gi+16@ha
	lis 11,sound_hook_launch@ha
	lwz 0,gi+16@l(9)
	li 4,1
	lis 9,.LC127@ha
	lwz 5,sound_hook_launch@l(11)
	la 9,.LC127@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC127@ha
	la 9,.LC127@l(9)
	lfs 2,0(9)
	lis 9,.LC128@ha
	la 9,.LC128@l(9)
	lfs 3,0(9)
	blrl
	b .L123
.L122:
	lis 9,gi+16@ha
	lis 11,commander_sound_hook_launch@ha
	lwz 0,gi+16@l(9)
	li 4,1
	lis 9,.LC127@ha
	lwz 5,commander_sound_hook_launch@l(11)
	la 9,.LC127@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC127@ha
	la 9,.LC127@l(9)
	lfs 2,0(9)
	lis 9,.LC128@ha
	la 9,.LC128@l(9)
	lfs 3,0(9)
	blrl
.L123:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe24:
	.size	 medic_hook_launch,.Lfe24-medic_hook_launch
	.section	".rodata"
	.align 2
.LC129:
	.long 0x4cbebc20
	.align 2
.LC130:
	.long 0x3f800000
	.align 2
.LC131:
	.long 0x0
	.section	".text"
	.align 2
	.globl medic_hook_retract
	.type	 medic_hook_retract,@function
medic_hook_retract:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,400(31)
	cmpwi 0,0,400
	bc 4,2,.L158
	lis 9,gi+16@ha
	lis 11,sound_hook_retract@ha
	lwz 0,gi+16@l(9)
	li 4,1
	lis 9,.LC130@ha
	lwz 5,sound_hook_retract@l(11)
	la 9,.LC130@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC130@ha
	la 9,.LC130@l(9)
	lfs 2,0(9)
	lis 9,.LC131@ha
	la 9,.LC131@l(9)
	lfs 3,0(9)
	blrl
	b .L159
.L158:
	lis 9,gi+16@ha
	lis 11,sound_hook_retract@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,1
	lis 9,.LC130@ha
	lwz 5,sound_hook_retract@l(11)
	la 9,.LC130@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC130@ha
	la 9,.LC130@l(9)
	lfs 2,0(9)
	lis 9,.LC131@ha
	la 9,.LC131@l(9)
	lfs 3,0(9)
	blrl
.L159:
	lwz 9,544(31)
	lwz 0,776(31)
	cmpwi 0,9,0
	rlwinm 0,0,0,19,17
	stw 0,776(31)
	bc 12,2,.L160
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L160
	stw 9,540(31)
	b .L161
.L160:
	li 0,0
	mr 3,31
	stw 0,544(31)
	stw 0,540(31)
	bl FindTarget
	cmpwi 0,3,0
	bc 4,2,.L161
	lis 9,level+4@ha
	lis 11,.LC129@ha
	lwz 10,788(31)
	lfs 0,level+4@l(9)
	mr 3,31
	lfs 13,.LC129@l(11)
	mtlr 10
	fadds 0,0,13
	stfs 0,828(31)
	blrl
.L161:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe25:
	.size	 medic_hook_retract,.Lfe25-medic_hook_retract
	.section	".rodata"
	.align 2
.LC132:
	.long 0x3f800000
	.align 2
.LC133:
	.long 0x0
	.section	".text"
	.align 2
	.globl medic_start_spawn
	.type	 medic_start_spawn,@function
medic_start_spawn:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi+16@ha
	mr 29,3
	lwz 0,gi+16@l(9)
	lis 11,commander_sound_spawn@ha
	lis 9,.LC132@ha
	lwz 5,commander_sound_spawn@l(11)
	li 4,1
	la 9,.LC132@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC132@ha
	la 9,.LC132@l(9)
	lfs 2,0(9)
	lis 9,.LC133@ha
	la 9,.LC133@l(9)
	lfs 3,0(9)
	blrl
	li 0,224
	stw 0,780(29)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe26:
	.size	 medic_start_spawn,.Lfe26-medic_start_spawn
	.align 2
	.globl MedicCommanderCache
	.type	 MedicCommanderCache,@function
MedicCommanderCache:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 9,reinforcements@ha
	lis 28,vec3_origin@ha
	la 31,reinforcements@l(9)
	la 30,vec3_origin@l(28)
	addi 27,31,24
.L265:
	bl G_Spawn
	lfs 13,vec3_origin@l(28)
	mr 29,3
	stfs 13,4(29)
	lfs 0,4(30)
	stfs 0,8(29)
	lfs 13,8(30)
	stfs 13,12(29)
	lfs 0,vec3_origin@l(28)
	stfs 0,16(29)
	lfs 13,4(30)
	stfs 13,20(29)
	lfs 0,8(30)
	stfs 0,24(29)
	lwz 3,0(31)
	addi 31,31,4
	bl ED_NewString
	lwz 0,776(29)
	stw 3,280(29)
	oris 0,0,0x40
	mr 3,29
	stw 0,776(29)
	bl ED_CallSpawn
	mr 3,29
	bl G_FreeEdict
	cmpw 0,31,27
	bc 4,1,.L265
	lis 29,gi@ha
	lis 3,.LC79@ha
	la 29,gi@l(29)
	la 3,.LC79@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lwz 0,32(29)
	lis 3,.LC80@ha
	la 3,.LC80@l(3)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe27:
	.size	 MedicCommanderCache,.Lfe27-MedicCommanderCache
	.section	".rodata"
	.align 3
.LC134:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC135:
	.long 0x0
	.align 2
.LC136:
	.long 0x3f800000
	.align 2
.LC137:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl medic_duck
	.type	 medic_duck,@function
medic_duck:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 0,776(31)
	andi. 9,0,8192
	bc 4,2,.L267
	lwz 0,772(31)
	lis 9,medic_move_attackHyperBlaster@ha
	la 9,medic_move_attackHyperBlaster@l(9)
	cmpw 0,0,9
	bc 12,2,.L270
	lis 9,medic_move_attackCable@ha
	la 9,medic_move_attackCable@l(9)
	cmpw 0,0,9
	bc 12,2,.L270
	lis 9,medic_move_attackBlaster@ha
	la 9,medic_move_attackBlaster@l(9)
	cmpw 0,0,9
	bc 12,2,.L270
	lis 9,medic_move_callReinforcements@ha
	la 9,medic_move_callReinforcements@l(9)
	cmpw 0,0,9
	bc 4,2,.L269
.L270:
	lwz 0,776(31)
	rlwinm 0,0,0,21,19
	stw 0,776(31)
	b .L267
.L269:
	lis 11,.LC135@ha
	lis 9,skill@ha
	la 11,.LC135@l(11)
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 12,20(11)
	fcmpu 0,12,0
	bc 4,2,.L271
	lis 9,level+4@ha
	lis 11,.LC136@ha
	lfs 0,level+4@l(9)
	la 11,.LC136@l(11)
	lfs 13,0(11)
	fadds 0,0,1
	fadds 0,0,13
	b .L307
.L271:
	lis 11,.LC137@ha
	lis 9,level+4@ha
	la 11,.LC137@l(11)
	lfs 13,level+4@l(9)
	lfs 0,0(11)
	lis 9,.LC134@ha
	fadds 13,13,1
	fsubs 0,0,12
	lfd 12,.LC134@l(9)
	fmadd 0,0,12,13
	frsp 0,0
.L307:
	stfs 0,940(31)
	mr 3,31
	bl monster_duck_down
	lis 9,medic_move_duck@ha
	li 0,131
	la 9,medic_move_duck@l(9)
	stw 0,780(31)
	stw 9,772(31)
.L267:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe28:
	.size	 medic_duck,.Lfe28-medic_duck
	.section	".rodata"
	.align 2
.LC138:
	.long 0x0
	.section	".text"
	.align 2
	.globl medic_sidestep
	.type	 medic_sidestep,@function
medic_sidestep:
	lis 9,medic_move_attackHyperBlaster@ha
	lwz 0,772(3)
	la 9,medic_move_attackHyperBlaster@l(9)
	cmpw 0,0,9
	bc 12,2,.L275
	lis 9,medic_move_attackCable@ha
	la 9,medic_move_attackCable@l(9)
	cmpw 0,0,9
	bc 12,2,.L275
	lis 9,medic_move_attackBlaster@ha
	la 9,medic_move_attackBlaster@l(9)
	cmpw 0,0,9
	bc 12,2,.L275
	lis 9,medic_move_callReinforcements@ha
	la 9,medic_move_callReinforcements@l(9)
	cmpw 0,0,9
	bc 4,2,.L274
.L275:
	lis 9,.LC138@ha
	lis 11,skill@ha
	la 9,.LC138@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L274
	lwz 0,776(3)
	rlwinm 0,0,0,14,12
	stw 0,776(3)
	blr
.L274:
	lwz 0,772(3)
	lis 9,medic_move_run@ha
	la 9,medic_move_run@l(9)
	cmpw 0,0,9
	bclr 12,2
	stw 9,772(3)
	blr
.Lfe29:
	.size	 medic_sidestep,.Lfe29-medic_sidestep
	.section	".rodata"
	.align 3
.LC139:
	.long 0x3fa99999
	.long 0x9999999a
	.align 3
.LC140:
	.long 0x3fd00000
	.long 0x0
	.section	".text"
	.align 2
	.globl medic_blocked
	.type	 medic_blocked,@function
medic_blocked:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stw 31,20(1)
	stw 0,36(1)
	lis 9,skill@ha
	fmr 31,1
	lis 11,.LC139@ha
	lwz 10,skill@l(9)
	mr 31,3
	lis 9,.LC140@ha
	lfd 0,.LC139@l(11)
	lfs 1,20(10)
	la 9,.LC140@l(9)
	lfd 13,0(9)
	fmadd 1,1,0,13
	frsp 1,1
	bl blocked_checkshot
	cmpwi 0,3,0
	li 3,1
	bc 4,2,.L308
	fmr 1,31
	mr 3,31
	bl blocked_checkplat
	addic 9,3,-1
	subfe 0,9,3
	mr 3,0
.L308:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 medic_blocked,.Lfe30-medic_blocked
	.align 2
	.globl MedicDMGAdjust
	.type	 MedicDMGAdjust,@function
MedicDMGAdjust:
	andi. 0,7,16
	li 10,0
	bc 12,2,.L282
	lwz 0,484(3)
	lwz 11,480(3)
	srwi 9,0,31
	add 0,0,9
	srawi 0,0,1
	cmpw 0,11,0
	bc 4,1,.L282
	lwz 3,996(3)
	andi. 0,3,48
	bc 12,2,.L283
	andi. 0,3,1
	bc 12,2,.L283
	li 3,0
	blr
.L283:
	lis 0,0x5555
	srawi 9,6,31
	ori 0,0,21846
	mulhw 0,6,0
	subf 0,9,0
	subf 10,0,6
.L282:
	mr 3,10
	blr
.Lfe31:
	.size	 MedicDMGAdjust,.Lfe31-MedicDMGAdjust
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
