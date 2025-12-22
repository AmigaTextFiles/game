	.file	"m_chick.c"
gcc2_compiled.:
	.globl chick_frames_fidget
	.section	".data"
	.align 2
	.type	 chick_frames_fidget,@object
chick_frames_fidget:
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
	.long ChickMoan
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
	.size	 chick_frames_fidget,360
	.globl chick_move_fidget
	.align 2
	.type	 chick_move_fidget,@object
	.size	 chick_move_fidget,16
chick_move_fidget:
	.long 151
	.long 180
	.long chick_frames_fidget
	.long chick_stand
	.globl chick_frames_stand
	.align 2
	.type	 chick_frames_stand,@object
chick_frames_stand:
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
	.long chick_fidget
	.size	 chick_frames_stand,360
	.globl chick_move_stand
	.align 2
	.type	 chick_move_stand,@object
	.size	 chick_move_stand,16
chick_move_stand:
	.long 121
	.long 150
	.long chick_frames_stand
	.long 0
	.globl chick_frames_start_run
	.align 2
	.type	 chick_frames_start_run,@object
chick_frames_start_run:
	.long ai_run
	.long 0x3f800000
	.long 0
	.long ai_run
	.long 0x0
	.long 0
	.long ai_run
	.long 0x0
	.long 0
	.long ai_run
	.long 0xbf800000
	.long 0
	.long ai_run
	.long 0xbf800000
	.long 0
	.long ai_run
	.long 0x0
	.long 0
	.long ai_run
	.long 0x3f800000
	.long 0
	.long ai_run
	.long 0x40400000
	.long 0
	.long ai_run
	.long 0x40c00000
	.long 0
	.long ai_run
	.long 0x40400000
	.long 0
	.size	 chick_frames_start_run,120
	.globl chick_move_start_run
	.align 2
	.type	 chick_move_start_run,@object
	.size	 chick_move_start_run,16
chick_move_start_run:
	.long 181
	.long 190
	.long chick_frames_start_run
	.long chick_run
	.globl chick_frames_run
	.align 2
	.type	 chick_frames_run,@object
chick_frames_run:
	.long ai_run
	.long 0x40c00000
	.long 0
	.long ai_run
	.long 0x41000000
	.long 0
	.long ai_run
	.long 0x41500000
	.long 0
	.long ai_run
	.long 0x40a00000
	.long monster_done_dodge
	.long ai_run
	.long 0x40e00000
	.long 0
	.long ai_run
	.long 0x40800000
	.long 0
	.long ai_run
	.long 0x41300000
	.long 0
	.long ai_run
	.long 0x40a00000
	.long 0
	.long ai_run
	.long 0x41100000
	.long 0
	.long ai_run
	.long 0x40e00000
	.long 0
	.size	 chick_frames_run,120
	.globl chick_move_run
	.align 2
	.type	 chick_move_run,@object
	.size	 chick_move_run,16
chick_move_run:
	.long 191
	.long 200
	.long chick_frames_run
	.long 0
	.globl chick_frames_walk
	.align 2
	.type	 chick_frames_walk,@object
chick_frames_walk:
	.long ai_walk
	.long 0x40c00000
	.long 0
	.long ai_walk
	.long 0x41000000
	.long 0
	.long ai_walk
	.long 0x41500000
	.long 0
	.long ai_walk
	.long 0x40a00000
	.long 0
	.long ai_walk
	.long 0x40e00000
	.long 0
	.long ai_walk
	.long 0x40800000
	.long 0
	.long ai_walk
	.long 0x41300000
	.long 0
	.long ai_walk
	.long 0x40a00000
	.long 0
	.long ai_walk
	.long 0x41100000
	.long 0
	.long ai_walk
	.long 0x40e00000
	.long 0
	.size	 chick_frames_walk,120
	.globl chick_move_walk
	.align 2
	.type	 chick_move_walk,@object
	.size	 chick_move_walk,16
chick_move_walk:
	.long 191
	.long 200
	.long chick_frames_walk
	.long 0
	.globl chick_frames_pain1
	.align 2
	.type	 chick_frames_pain1,@object
chick_frames_pain1:
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
	.size	 chick_frames_pain1,60
	.globl chick_move_pain1
	.align 2
	.type	 chick_move_pain1,@object
	.size	 chick_move_pain1,16
chick_move_pain1:
	.long 90
	.long 94
	.long chick_frames_pain1
	.long chick_run
	.globl chick_frames_pain2
	.align 2
	.type	 chick_frames_pain2,@object
chick_frames_pain2:
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
	.size	 chick_frames_pain2,60
	.globl chick_move_pain2
	.align 2
	.type	 chick_move_pain2,@object
	.size	 chick_move_pain2,16
chick_move_pain2:
	.long 95
	.long 99
	.long chick_frames_pain2
	.long chick_run
	.globl chick_frames_pain3
	.align 2
	.type	 chick_frames_pain3,@object
chick_frames_pain3:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0xc0c00000
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0x41300000
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x40800000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0xc0400000
	.long 0
	.long ai_move
	.long 0xc0800000
	.long 0
	.long ai_move
	.long 0x40a00000
	.long 0
	.long ai_move
	.long 0x40e00000
	.long 0
	.long ai_move
	.long 0xc0000000
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0xc0a00000
	.long 0
	.long ai_move
	.long 0xc0000000
	.long 0
	.long ai_move
	.long 0xc1000000
	.long 0
	.long ai_move
	.long 0x40000000
	.long 0
	.size	 chick_frames_pain3,252
	.globl chick_move_pain3
	.align 2
	.type	 chick_move_pain3,@object
	.size	 chick_move_pain3,16
chick_move_pain3:
	.long 100
	.long 120
	.long chick_frames_pain3
	.long chick_run
	.section	".rodata"
	.align 2
.LC3:
	.long 0x46fffe00
	.align 3
.LC4:
	.long 0x3fd51eb8
	.long 0x51eb851f
	.align 3
.LC5:
	.long 0x3fe51eb8
	.long 0x51eb851f
	.align 2
.LC6:
	.long 0x40400000
	.align 3
.LC7:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC8:
	.long 0x3f800000
	.align 2
.LC9:
	.long 0x0
	.section	".text"
	.align 2
	.globl chick_pain
	.type	 chick_pain,@function
chick_pain:
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
	bc 4,0,.L20
	lwz 0,60(31)
	ori 0,0,1
	stw 0,60(31)
.L20:
	lis 9,level+4@ha
	lfs 0,464(31)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L19
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,464(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC7@ha
	lis 10,.LC3@ha
	la 11,.LC7@l(11)
	stw 0,16(1)
	lfd 12,0(11)
	lfd 0,16(1)
	lis 11,.LC4@ha
	lfs 11,.LC3@l(10)
	lfd 13,.LC4@l(11)
	fsub 0,0,12
	frsp 0,0
	fdivs 0,0,11
	fmr 12,0
	fcmpu 0,12,13
	bc 4,0,.L22
	lis 9,gi+16@ha
	lis 11,sound_pain1@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC8@ha
	lwz 5,sound_pain1@l(11)
	b .L32
.L22:
	lis 9,.LC5@ha
	lfd 0,.LC5@l(9)
	fcmpu 0,12,0
	bc 4,0,.L24
	lis 9,gi+16@ha
	lis 11,sound_pain2@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC8@ha
	lwz 5,sound_pain2@l(11)
.L32:
	la 9,.LC8@l(9)
	lis 11,.LC8@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC8@l(11)
	lis 9,.LC9@ha
	lfs 2,0(11)
	la 9,.LC9@l(9)
	lfs 3,0(9)
	blrl
	b .L23
.L24:
	lis 9,gi+16@ha
	lis 11,sound_pain3@ha
	lwz 0,gi+16@l(9)
	mr 3,31
	li 4,2
	lis 9,.LC8@ha
	lwz 5,sound_pain3@l(11)
	la 9,.LC8@l(9)
	lis 11,.LC8@ha
	mtlr 0
	lfs 1,0(9)
	la 11,.LC8@l(11)
	lis 9,.LC9@ha
	lfs 2,0(11)
	la 9,.LC9@l(9)
	lfs 3,0(9)
	blrl
.L23:
	lis 9,.LC6@ha
	lis 11,skill@ha
	la 9,.LC6@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L19
	lwz 0,776(31)
	cmpwi 0,30,10
	rlwinm 0,0,0,16,14
	stw 0,776(31)
	bc 12,1,.L27
	lis 9,chick_move_pain1@ha
	la 9,chick_move_pain1@l(9)
	b .L33
.L27:
	cmpwi 0,30,25
	bc 12,1,.L29
	lis 9,chick_move_pain2@ha
	la 9,chick_move_pain2@l(9)
	b .L33
.L29:
	lis 9,chick_move_pain3@ha
	la 9,chick_move_pain3@l(9)
.L33:
	stw 9,772(31)
	lwz 0,776(31)
	andi. 11,0,2048
	bc 12,2,.L19
	mr 3,31
	bl monster_duck_up
.L19:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 chick_pain,.Lfe1-chick_pain
	.globl chick_frames_death2
	.section	".data"
	.align 2
	.type	 chick_frames_death2,@object
chick_frames_death2:
	.long ai_move
	.long 0xc0c00000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0xc0a00000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0xbf800000
	.long 0
	.long ai_move
	.long 0xc0000000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x41200000
	.long 0
	.long ai_move
	.long 0x40000000
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x40000000
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0xc0400000
	.long 0
	.long ai_move
	.long 0xc0a00000
	.long 0
	.long ai_move
	.long 0x40800000
	.long 0
	.long ai_move
	.long 0x41700000
	.long 0
	.long ai_move
	.long 0x41600000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.size	 chick_frames_death2,276
	.globl chick_move_death2
	.align 2
	.type	 chick_move_death2,@object
	.size	 chick_move_death2,16
chick_move_death2:
	.long 60
	.long 82
	.long chick_frames_death2
	.long chick_dead
	.globl chick_frames_death1
	.align 2
	.type	 chick_frames_death1,@object
chick_frames_death1:
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0x0
	.long 0
	.long ai_move
	.long 0xc0e00000
	.long 0
	.long ai_move
	.long 0x40800000
	.long 0
	.long ai_move
	.long 0x41300000
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
	.size	 chick_frames_death1,144
	.globl chick_move_death1
	.align 2
	.type	 chick_move_death1,@object
	.size	 chick_move_death1,16
chick_move_death1:
	.long 48
	.long 59
	.long chick_frames_death1
	.long chick_dead
	.section	".rodata"
	.align 2
.LC10:
	.string	"misc/udeath.wav"
	.align 2
.LC11:
	.string	"models/objects/gibs/bone/tris.md2"
	.align 2
.LC12:
	.string	"models/objects/gibs/sm_meat/tris.md2"
	.align 2
.LC13:
	.string	"models/objects/gibs/head2/tris.md2"
	.align 2
.LC14:
	.long 0x3f800000
	.align 2
.LC15:
	.long 0x0
	.section	".text"
	.align 2
	.globl chick_die
	.type	 chick_die,@function
chick_die:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 31,3
	mr 28,6
	lwz 9,480(31)
	lwz 0,488(31)
	cmpw 0,9,0
	bc 12,1,.L36
	lis 29,gi@ha
	lis 3,.LC10@ha
	la 29,gi@l(29)
	la 3,.LC10@l(3)
	lwz 9,36(29)
	lis 27,.LC11@ha
	lis 26,.LC12@ha
	li 30,2
	mtlr 9
	blrl
	lis 9,.LC14@ha
	lwz 0,16(29)
	mr 5,3
	la 9,.LC14@l(9)
	li 4,2
	lfs 1,0(9)
	mr 3,31
	mtlr 0
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 2,0(9)
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 3,0(9)
	blrl
.L40:
	mr 3,31
	la 4,.LC11@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L40
	li 30,4
.L45:
	mr 3,31
	la 4,.LC12@l(26)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L45
	lis 4,.LC13@ha
	mr 5,28
	la 4,.LC13@l(4)
	mr 3,31
	li 6,0
	bl ThrowHead
	li 0,2
	stw 0,492(31)
	b .L35
.L36:
	lwz 0,492(31)
	cmpwi 0,0,2
	bc 12,2,.L35
	li 0,2
	li 9,1
	stw 0,492(31)
	stw 9,512(31)
	bl rand
	srwi 0,3,31
	add 0,3,0
	rlwinm 0,0,0,0,30
	cmpw 0,3,0
	bc 4,2,.L48
	lis 9,chick_move_death1@ha
	lis 11,gi+16@ha
	la 9,chick_move_death1@l(9)
	lis 10,sound_death1@ha
	stw 9,772(31)
	mr 3,31
	li 4,2
	lis 9,.LC14@ha
	lwz 0,gi+16@l(11)
	la 9,.LC14@l(9)
	lwz 5,sound_death1@l(10)
	lfs 1,0(9)
	mtlr 0
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 2,0(9)
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 3,0(9)
	blrl
	b .L35
.L48:
	lis 9,chick_move_death2@ha
	lis 11,gi+16@ha
	la 9,chick_move_death2@l(9)
	lis 10,sound_death2@ha
	stw 9,772(31)
	mr 3,31
	li 4,2
	lis 9,.LC14@ha
	lwz 0,gi+16@l(11)
	la 9,.LC14@l(9)
	lwz 5,sound_death2@l(10)
	lfs 1,0(9)
	mtlr 0
	lis 9,.LC14@ha
	la 9,.LC14@l(9)
	lfs 2,0(9)
	lis 9,.LC15@ha
	la 9,.LC15@l(9)
	lfs 3,0(9)
	blrl
.L35:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 chick_die,.Lfe2-chick_die
	.globl chick_frames_duck
	.section	".data"
	.align 2
	.type	 chick_frames_duck,@object
chick_frames_duck:
	.long ai_move
	.long 0x0
	.long monster_duck_down
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x40800000
	.long monster_duck_hold
	.long ai_move
	.long 0xc0800000
	.long 0
	.long ai_move
	.long 0xc0a00000
	.long monster_duck_up
	.long ai_move
	.long 0x40400000
	.long 0
	.long ai_move
	.long 0x3f800000
	.long 0
	.size	 chick_frames_duck,84
	.globl chick_move_duck
	.align 2
	.type	 chick_move_duck,@object
	.size	 chick_move_duck,16
chick_move_duck:
	.long 83
	.long 89
	.long chick_frames_duck
	.long chick_run
	.section	".rodata"
	.align 2
.LC16:
	.long 0x46fffe00
	.align 3
.LC17:
	.long 0x3fd51eb8
	.long 0x51eb851f
	.align 3
.LC18:
	.long 0x3fc33333
	.long 0x33333333
	.align 3
.LC19:
	.long 0x3fc99999
	.long 0x9999999a
	.align 2
.LC20:
	.long 0x42c80000
	.align 2
.LC21:
	.long 0x43fa0000
	.align 3
.LC22:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC23:
	.long 0x40400000
	.align 3
.LC24:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC25:
	.long 0xc1200000
	.align 2
.LC26:
	.long 0x41200000
	.section	".text"
	.align 2
	.globl ChickRocket
	.type	 ChickRocket,@function
ChickRocket:
	stwu 1,-240(1)
	mflr 0
	mfcr 12
	stfd 31,232(1)
	stmw 22,192(1)
	stw 0,244(1)
	stw 12,188(1)
	mr 30,3
	lwz 9,540(30)
	lwz 0,776(30)
	cmpwi 0,9,0
	rlwinm 31,0,16,31,31
	bc 12,2,.L51
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L51
	addi 29,1,24
	addi 4,1,8
	addi 3,30,16
	mr 5,29
	li 6,0
	cmpwi 4,31,0
	bl AngleVectors
	mr 22,29
	addi 7,1,40
	lis 4,monster_flash_offset+684@ha
	mr 25,7
	la 4,monster_flash_offset+684@l(4)
	addi 3,30,4
	addi 5,1,8
	mr 6,29
	bl G_ProjectSource
	lis 11,.LC20@ha
	lis 9,skill@ha
	la 11,.LC20@l(11)
	lfs 11,0(11)
	lwz 11,skill@l(9)
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 0,20(11)
	lfs 12,0(9)
	fmadds 0,0,11,12
	fctiwz 13,0
	stfd 13,176(1)
	lwz 24,180(1)
	bc 12,18,.L56
	lfs 0,956(30)
	lfs 13,960(30)
	lfs 12,964(30)
	stfs 0,152(1)
	stfs 13,156(1)
	stfs 12,160(1)
	b .L57
.L56:
	lwz 9,540(30)
	lfs 0,4(9)
	stfs 0,152(1)
	lfs 13,8(9)
	stfs 13,156(1)
	lfs 0,12(9)
	stfs 0,160(1)
.L57:
	bc 12,18,.L58
	lfs 11,152(1)
	lfs 10,156(1)
	lfs 9,160(1)
	lfs 0,40(1)
	lfs 13,44(1)
	lfs 12,48(1)
	fsubs 0,11,0
	stfs 11,72(1)
	fsubs 13,10,13
	stfs 10,76(1)
	fsubs 12,9,12
	stfs 9,80(1)
	stfs 0,56(1)
	stfs 13,60(1)
	stfs 12,64(1)
	b .L59
.L58:
	bl rand
	lis 9,.LC22@ha
	rlwinm 3,3,0,17,31
	la 9,.LC22@l(9)
	xoris 3,3,0x8000
	lfd 8,0(9)
	lis 8,0x4330
	lis 10,.LC16@ha
	lfs 11,.LC16@l(10)
	lis 11,.LC17@ha
	stw 3,180(1)
	stw 8,176(1)
	lfd 0,176(1)
	lfd 12,.LC17@l(11)
	fsub 0,0,8
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 12,0,.L61
	lwz 9,540(30)
	lfs 9,48(1)
	lfs 0,220(9)
	fcmpu 0,9,0
	bc 4,0,.L60
.L61:
	lfs 11,152(1)
	lfs 10,156(1)
	lfs 12,160(1)
	lwz 11,540(30)
	stfs 11,72(1)
	stfs 12,80(1)
	stfs 10,76(1)
	lwz 0,508(11)
	lfs 0,40(1)
	xoris 0,0,0x8000
	lfs 13,44(1)
	stw 0,180(1)
	fsubs 11,11,0
	stw 8,176(1)
	lfd 0,176(1)
	fsubs 10,10,13
	lfs 13,48(1)
	stfs 11,56(1)
	fsub 0,0,8
	stfs 10,60(1)
	frsp 0,0
	fadds 12,12,0
	fsubs 13,12,13
	stfs 12,80(1)
	stfs 13,64(1)
	b .L59
.L60:
	lfs 13,152(1)
	lfs 12,156(1)
	lfs 0,160(1)
	stfs 13,72(1)
	stfs 12,76(1)
	stfs 0,80(1)
	lfs 11,220(9)
	lfs 0,40(1)
	lfs 10,44(1)
	fsubs 9,11,9
	stfs 11,80(1)
	fsubs 13,13,0
	fsubs 12,12,10
	stfs 9,64(1)
	stfs 13,56(1)
	stfs 12,60(1)
.L59:
	addi 28,1,56
	addi 31,1,72
	bc 4,18,.L63
	bl rand
	lis 29,0x4330
	lis 9,.LC22@ha
	rlwinm 3,3,0,17,31
	la 9,.LC22@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 7,.LC16@ha
	lis 10,skill@ha
	lfs 9,.LC16@l(7)
	lis 11,.LC23@ha
	stw 3,180(1)
	la 11,.LC23@l(11)
	lis 8,.LC19@ha
	stw 29,176(1)
	lfd 0,176(1)
	lwz 9,skill@l(10)
	lfs 13,0(11)
	fsub 0,0,31
	lfs 12,20(9)
	lis 11,.LC18@ha
	lfd 10,.LC18@l(11)
	lfd 11,.LC19@l(8)
	frsp 0,0
	fsubs 13,13,12
	fdivs 0,0,9
	fmr 12,0
	fmadd 13,13,10,11
	fcmpu 0,12,13
	bc 4,0,.L63
	mr 3,28
	bl VectorLength
	xoris 0,24,0x8000
	lwz 4,540(30)
	stw 0,180(1)
	mr 3,31
	mr 5,31
	stw 29,176(1)
	addi 4,4,376
	lfd 0,176(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 1,1,0
	bl VectorMA
	lfs 11,40(1)
	lfs 13,72(1)
	lfs 12,76(1)
	lfs 10,44(1)
	fsubs 13,13,11
	lfs 0,80(1)
	lfs 11,48(1)
	fsubs 12,12,10
	stfs 13,56(1)
	fsubs 0,0,11
	stfs 12,60(1)
	stfs 0,64(1)
.L63:
	mr 3,28
	lis 26,vec3_origin@ha
	bl VectorNormalize
	lis 9,gi@ha
	addi 29,1,88
	la 27,gi@l(9)
	la 5,vec3_origin@l(26)
	lwz 11,48(27)
	lis 9,0x600
	mr 3,29
	mr 4,25
	mr 6,5
	mr 7,31
	mr 8,30
	mtlr 11
	ori 9,9,3
	mr 23,29
	blrl
	bc 12,18,.L64
	lwz 0,92(1)
	cmpwi 0,0,0
	bc 4,2,.L65
	lwz 0,88(1)
	cmpwi 0,0,0
	bc 4,2,.L65
	lfs 0,96(1)
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L65
	lwz 0,60(30)
	andi. 11,0,2
	bc 12,2,.L77
	mr 3,30
	mr 4,25
	mr 5,28
	mr 7,24
	li 6,50
	li 8,57
	bl monster_fire_flamerocket
	b .L51
.L65:
	lis 9,.LC25@ha
	lfs 12,152(1)
	mr 5,31
	lfs 13,156(1)
	la 9,.LC25@l(9)
	mr 4,22
	lfs 0,160(1)
	mr 3,31
	lfs 1,0(9)
	stfs 12,72(1)
	stfs 13,76(1)
	stfs 0,80(1)
	bl VectorMA
	lfs 11,40(1)
	mr 3,28
	lfs 12,72(1)
	lfs 13,76(1)
	lfs 10,44(1)
	fsubs 12,12,11
	lfs 0,80(1)
	lfs 11,48(1)
	fsubs 13,13,10
	stfs 12,56(1)
	fsubs 0,0,11
	stfs 13,60(1)
	stfs 0,64(1)
	bl VectorNormalize
	lis 11,gi+48@ha
	lis 5,vec3_origin@ha
	lwz 0,gi+48@l(11)
	la 5,vec3_origin@l(5)
	lis 9,0x600
	mr 3,23
	mr 4,25
	mtlr 0
	mr 6,5
	mr 7,31
	mr 8,30
	ori 9,9,3
	blrl
	lwz 0,92(1)
	cmpwi 0,0,0
	bc 4,2,.L69
	lwz 0,88(1)
	cmpwi 0,0,0
	bc 4,2,.L69
	lfs 0,96(1)
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 4,0,.L77
.L69:
	lis 9,.LC26@ha
	lfs 12,152(1)
	mr 5,31
	lfs 13,156(1)
	la 9,.LC26@l(9)
	mr 4,22
	lfs 0,160(1)
	mr 3,31
	lfs 1,0(9)
	stfs 12,72(1)
	stfs 13,76(1)
	stfs 0,80(1)
	bl VectorMA
	lfs 11,40(1)
	mr 3,28
	lfs 12,72(1)
	lfs 13,76(1)
	lfs 10,44(1)
	fsubs 12,12,11
	lfs 0,80(1)
	lfs 11,48(1)
	fsubs 13,13,10
	stfs 12,56(1)
	fsubs 0,0,11
	stfs 13,60(1)
	stfs 0,64(1)
	bl VectorNormalize
	lis 11,gi+48@ha
	lis 5,vec3_origin@ha
	lwz 0,gi+48@l(11)
	la 5,vec3_origin@l(5)
	lis 9,0x600
	mr 3,23
	mr 7,31
	mtlr 0
	mr 4,25
	mr 6,5
	mr 8,30
	ori 9,9,3
	blrl
	lwz 0,92(1)
	cmpwi 0,0,0
	bc 4,2,.L51
	lwz 0,88(1)
	cmpwi 0,0,0
	bc 4,2,.L51
	lfs 0,96(1)
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,0,.L51
.L77:
	mr 3,30
	mr 4,25
	mr 5,28
	mr 7,24
	li 6,50
	li 8,57
	bl monster_fire_rocket
	b .L51
.L64:
	lwz 0,48(27)
	la 5,vec3_origin@l(26)
	lis 9,0x600
	mr 3,29
	mr 7,31
	mtlr 0
	mr 4,25
	mr 6,5
	mr 8,30
	ori 9,9,3
	blrl
	lwz 11,140(1)
	lwz 0,540(30)
	cmpw 0,11,0
	bc 12,2,.L74
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,11,0
	bc 4,2,.L51
.L74:
	lfs 0,96(1)
	lis 9,.LC24@ha
	la 9,.LC24@l(9)
	lfd 13,0(9)
	fcmpu 0,0,13
	bc 12,1,.L76
	cmpwi 0,11,0
	bc 12,2,.L51
	lwz 0,84(11)
	cmpwi 0,0,0
	bc 12,2,.L51
.L76:
	mr 3,30
	mr 4,25
	mr 5,28
	mr 7,24
	li 6,50
	li 8,57
	bl monster_fire_rocket
.L51:
	lwz 0,244(1)
	lwz 12,188(1)
	mtlr 0
	lmw 22,192(1)
	lfd 31,232(1)
	mtcrf 8,12
	la 1,240(1)
	blr
.Lfe3:
	.size	 ChickRocket,.Lfe3-ChickRocket
	.globl chick_frames_start_attack1
	.section	".data"
	.align 2
	.type	 chick_frames_start_attack1,@object
chick_frames_start_attack1:
	.long ai_charge
	.long 0x0
	.long Chick_PreAttack1
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x40800000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0xc0400000
	.long 0
	.long ai_charge
	.long 0x40400000
	.long 0
	.long ai_charge
	.long 0x40a00000
	.long 0
	.long ai_charge
	.long 0x40e00000
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
	.long chick_attack1
	.size	 chick_frames_start_attack1,156
	.globl chick_move_start_attack1
	.align 2
	.type	 chick_move_start_attack1,@object
	.size	 chick_move_start_attack1,16
chick_move_start_attack1:
	.long 0
	.long 12
	.long chick_frames_start_attack1
	.long 0
	.globl chick_frames_attack1
	.align 2
	.type	 chick_frames_attack1,@object
chick_frames_attack1:
	.long ai_charge
	.long 0x41980000
	.long ChickRocket
	.long ai_charge
	.long 0xc0c00000
	.long 0
	.long ai_charge
	.long 0xc0a00000
	.long 0
	.long ai_charge
	.long 0xc0000000
	.long 0
	.long ai_charge
	.long 0xc0e00000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x3f800000
	.long 0
	.long ai_charge
	.long 0x41200000
	.long ChickReload
	.long ai_charge
	.long 0x40800000
	.long 0
	.long ai_charge
	.long 0x40a00000
	.long 0
	.long ai_charge
	.long 0x40c00000
	.long 0
	.long ai_charge
	.long 0x40c00000
	.long 0
	.long ai_charge
	.long 0x40800000
	.long 0
	.long ai_charge
	.long 0x40400000
	.long chick_rerocket
	.size	 chick_frames_attack1,168
	.globl chick_move_attack1
	.align 2
	.type	 chick_move_attack1,@object
	.size	 chick_move_attack1,16
chick_move_attack1:
	.long 13
	.long 26
	.long chick_frames_attack1
	.long 0
	.globl chick_frames_end_attack1
	.align 2
	.type	 chick_frames_end_attack1,@object
chick_frames_end_attack1:
	.long ai_charge
	.long 0xc0400000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0xc0c00000
	.long 0
	.long ai_charge
	.long 0xc0800000
	.long 0
	.long ai_charge
	.long 0xc0000000
	.long 0
	.size	 chick_frames_end_attack1,60
	.globl chick_move_end_attack1
	.align 2
	.type	 chick_move_end_attack1,@object
	.size	 chick_move_end_attack1,16
chick_move_end_attack1:
	.long 27
	.long 31
	.long chick_frames_end_attack1
	.long chick_run
	.globl chick_frames_slash
	.align 2
	.type	 chick_frames_slash,@object
chick_frames_slash:
	.long ai_charge
	.long 0x3f800000
	.long 0
	.long ai_charge
	.long 0x40e00000
	.long ChickSlash
	.long ai_charge
	.long 0xc0e00000
	.long 0
	.long ai_charge
	.long 0x3f800000
	.long 0
	.long ai_charge
	.long 0xbf800000
	.long 0
	.long ai_charge
	.long 0x3f800000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.long ai_charge
	.long 0x3f800000
	.long 0
	.long ai_charge
	.long 0xc0000000
	.long chick_reslash
	.size	 chick_frames_slash,108
	.globl chick_move_slash
	.align 2
	.type	 chick_move_slash,@object
	.size	 chick_move_slash,16
chick_move_slash:
	.long 35
	.long 43
	.long chick_frames_slash
	.long 0
	.globl chick_frames_end_slash
	.align 2
	.type	 chick_frames_end_slash,@object
chick_frames_end_slash:
	.long ai_charge
	.long 0xc0c00000
	.long 0
	.long ai_charge
	.long 0xbf800000
	.long 0
	.long ai_charge
	.long 0xc0c00000
	.long 0
	.long ai_charge
	.long 0x0
	.long 0
	.size	 chick_frames_end_slash,48
	.globl chick_move_end_slash
	.align 2
	.type	 chick_move_end_slash,@object
	.size	 chick_move_end_slash,16
chick_move_end_slash:
	.long 44
	.long 47
	.long chick_frames_end_slash
	.long chick_run
	.globl chick_frames_start_slash
	.align 2
	.type	 chick_frames_start_slash,@object
chick_frames_start_slash:
	.long ai_charge
	.long 0x3f800000
	.long 0
	.long ai_charge
	.long 0x41000000
	.long 0
	.long ai_charge
	.long 0x40400000
	.long 0
	.size	 chick_frames_start_slash,36
	.globl chick_move_start_slash
	.align 2
	.type	 chick_move_start_slash,@object
	.size	 chick_move_start_slash,16
chick_move_start_slash:
	.long 32
	.long 34
	.long chick_frames_start_slash
	.long chick_slash
	.section	".rodata"
	.align 2
.LC32:
	.long 0x3ecccccd
	.align 2
.LC33:
	.long 0x3dcccccd
	.align 2
.LC34:
	.long 0x46fffe00
	.align 3
.LC35:
	.long 0x3ff00000
	.long 0x0
	.align 2
.LC36:
	.long 0x3f800000
	.align 3
.LC37:
	.long 0x401e0000
	.long 0x0
	.align 3
.LC38:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC39:
	.long 0x40160000
	.long 0x0
	.section	".text"
	.align 2
	.globl chick_attack
	.type	 chick_attack,@function
chick_attack:
	stwu 1,-64(1)
	mflr 0
	stfd 28,32(1)
	stfd 29,40(1)
	stfd 30,48(1)
	stfd 31,56(1)
	stmw 30,24(1)
	stw 0,68(1)
	mr 31,3
	bl monster_done_dodge
	lwz 0,868(31)
	cmpwi 0,0,5
	bc 4,2,.L95
	lfs 13,952(31)
	lis 9,.LC35@ha
	la 9,.LC35@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L96
	lis 11,.LC36@ha
	la 11,.LC36@l(11)
	lfs 30,0(11)
	b .L97
.L96:
	lis 9,.LC37@ha
	la 9,.LC37@l(9)
	lfd 0,0(9)
	fcmpu 0,13,0
	bc 4,0,.L98
	lis 9,.LC32@ha
	lfs 30,.LC32@l(9)
	b .L97
.L98:
	lis 9,.LC33@ha
	lfs 30,.LC33@l(9)
.L97:
	bl rand
	lis 30,0x4330
	lis 9,.LC38@ha
	rlwinm 3,3,0,17,31
	la 9,.LC38@l(9)
	xoris 3,3,0x8000
	lfd 31,0(9)
	lis 11,.LC34@ha
	lfs 29,.LC34@l(11)
	stw 3,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	fsub 0,0,31
	frsp 0,0
	fdivs 28,0,29
	bl rand
	rlwinm 3,3,0,17,31
	lfs 12,952(31)
	xoris 3,3,0x8000
	lis 11,.LC39@ha
	stw 3,20(1)
	la 11,.LC39@l(11)
	lis 4,vec3_origin@ha
	stw 30,16(1)
	addi 3,31,956
	la 4,vec3_origin@l(4)
	lfd 0,16(1)
	lfd 11,0(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fmr 13,0
	fadd 13,13,11
	fadd 12,12,13
	frsp 12,12
	stfs 12,952(31)
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L94
	fcmpu 0,28,30
	bc 12,1,.L94
	lwz 0,776(31)
	lis 9,chick_move_start_attack1@ha
	la 9,chick_move_start_attack1@l(9)
	oris 0,0,0x1
	stw 9,772(31)
	stw 0,776(31)
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 11,level+4@ha
	stw 3,20(1)
	stw 30,16(1)
	lfd 0,16(1)
	lfs 13,level+4@l(11)
	fsub 0,0,31
	frsp 0,0
	fdivs 0,0,29
	fadds 0,0,0
	fadds 13,13,0
	stfs 13,832(31)
	b .L94
.L95:
	lis 9,chick_move_start_attack1@ha
	la 9,chick_move_start_attack1@l(9)
	stw 9,772(31)
.L94:
	lwz 0,68(1)
	mtlr 0
	lmw 30,24(1)
	lfd 28,32(1)
	lfd 29,40(1)
	lfd 30,48(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 chick_attack,.Lfe4-chick_attack
	.section	".rodata"
	.align 2
.LC42:
	.string	"chick/chkatck1.wav"
	.align 2
.LC43:
	.string	"chick/chkatck2.wav"
	.align 2
.LC44:
	.string	"chick/chkatck3.wav"
	.align 2
.LC45:
	.string	"chick/chkatck4.wav"
	.align 2
.LC46:
	.string	"chick/chkatck5.wav"
	.align 2
.LC47:
	.string	"chick/chkdeth1.wav"
	.align 2
.LC48:
	.string	"chick/chkdeth2.wav"
	.align 2
.LC49:
	.string	"chick/chkfall1.wav"
	.align 2
.LC50:
	.string	"chick/chkidle1.wav"
	.align 2
.LC51:
	.string	"chick/chkidle2.wav"
	.align 2
.LC52:
	.string	"chick/chkpain1.wav"
	.align 2
.LC53:
	.string	"chick/chkpain2.wav"
	.align 2
.LC54:
	.string	"chick/chkpain3.wav"
	.align 2
.LC55:
	.string	"chick/chksght1.wav"
	.align 2
.LC56:
	.string	"chick/chksrch1.wav"
	.align 2
.LC57:
	.string	"models/monsters/bitch/tris.md2"
	.align 2
.LC58:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_monster_chick_normal
	.type	 SP_monster_chick_normal,@function
SP_monster_chick_normal:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 24,8(1)
	stw 0,52(1)
	lis 11,.LC58@ha
	lis 9,deathmatch@ha
	la 11,.LC58@l(11)
	mr 31,3
	lfs 31,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L118
	bl G_FreeEdict
	b .L117
.L118:
	lis 29,gi@ha
	lis 3,.LC42@ha
	la 29,gi@l(29)
	la 3,.LC42@l(3)
	lwz 9,36(29)
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_missile_prelaunch@ha
	lis 11,.LC43@ha
	stw 3,sound_missile_prelaunch@l(9)
	mtlr 10
	la 3,.LC43@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_missile_launch@ha
	lis 11,.LC44@ha
	stw 3,sound_missile_launch@l(9)
	mtlr 10
	la 3,.LC44@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_melee_swing@ha
	lis 11,.LC45@ha
	stw 3,sound_melee_swing@l(9)
	mtlr 10
	la 3,.LC45@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_melee_hit@ha
	lis 11,.LC46@ha
	stw 3,sound_melee_hit@l(9)
	mtlr 10
	la 3,.LC46@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_missile_reload@ha
	lis 11,.LC47@ha
	stw 3,sound_missile_reload@l(9)
	mtlr 10
	la 3,.LC47@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_death1@ha
	lis 11,.LC48@ha
	stw 3,sound_death1@l(9)
	mtlr 10
	la 3,.LC48@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_death2@ha
	lis 11,.LC49@ha
	stw 3,sound_death2@l(9)
	mtlr 10
	la 3,.LC49@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_fall_down@ha
	lis 11,.LC50@ha
	stw 3,sound_fall_down@l(9)
	mtlr 10
	la 3,.LC50@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_idle1@ha
	lis 11,.LC51@ha
	stw 3,sound_idle1@l(9)
	mtlr 10
	la 3,.LC51@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_idle2@ha
	lis 11,.LC52@ha
	stw 3,sound_idle2@l(9)
	mtlr 10
	la 3,.LC52@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain1@ha
	lis 11,.LC53@ha
	stw 3,sound_pain1@l(9)
	mtlr 10
	la 3,.LC53@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain2@ha
	lis 11,.LC54@ha
	stw 3,sound_pain2@l(9)
	mtlr 10
	la 3,.LC54@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain3@ha
	lis 11,.LC55@ha
	stw 3,sound_pain3@l(9)
	mtlr 10
	la 3,.LC55@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_sight@ha
	lis 11,.LC56@ha
	stw 3,sound_sight@l(9)
	mtlr 10
	la 3,.LC56@l(11)
	blrl
	lis 9,sound_search@ha
	li 0,5
	stw 3,sound_search@l(9)
	li 11,2
	stw 0,260(31)
	lis 3,.LC57@ha
	stw 11,248(31)
	la 3,.LC57@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,chick_pain@ha
	lis 11,chick_die@ha
	stw 3,40(31)
	lis 10,chick_stand@ha
	lis 8,chick_walk@ha
	stfs 31,196(31)
	lis 7,chick_run@ha
	la 9,chick_pain@l(9)
	la 11,chick_die@l(11)
	la 10,chick_stand@l(10)
	stw 9,452(31)
	la 8,chick_walk@l(8)
	la 7,chick_run@l(7)
	stw 11,456(31)
	stw 10,788(31)
	lis 6,M_MonsterDodge@ha
	lis 5,chick_duck@ha
	stw 8,800(31)
	lis 4,monster_duck_up@ha
	lis 28,chick_sidestep@ha
	stw 7,804(31)
	lis 27,chick_attack@ha
	lis 26,chick_melee@ha
	lis 25,chick_sight@ha
	lis 24,chick_blocked@ha
	lis 8,0xc180
	lis 7,0x4180
	la 6,M_MonsterDodge@l(6)
	la 5,chick_duck@l(5)
	stw 8,192(31)
	la 4,monster_duck_up@l(4)
	li 10,175
	stw 6,808(31)
	li 9,-70
	li 11,200
	stw 5,920(31)
	la 28,chick_sidestep@l(28)
	la 27,chick_attack@l(27)
	stw 7,204(31)
	la 26,chick_melee@l(26)
	la 25,chick_sight@l(25)
	stw 10,480(31)
	la 24,chick_blocked@l(24)
	lis 0,0x4260
	stw 9,488(31)
	stw 11,400(31)
	mr 3,31
	stw 4,924(31)
	stw 8,188(31)
	stw 7,200(31)
	stw 0,208(31)
	stw 28,928(31)
	stw 27,812(31)
	stw 26,816(31)
	stw 25,820(31)
	stw 24,892(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lis 9,chick_move_stand@ha
	lis 11,SP_monster_chick_normal@ha
	lis 0,0x3f80
	la 9,chick_move_stand@l(9)
	la 11,SP_monster_chick_normal@l(11)
	li 10,1
	stw 0,784(31)
	stw 9,772(31)
	mr 3,31
	stw 10,948(31)
	stw 11,992(31)
	bl walkmonster_start
	lwz 0,1136(31)
	ori 0,0,24
	stw 0,1136(31)
.L117:
	lwz 0,52(1)
	mtlr 0
	lmw 24,8(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe5:
	.size	 SP_monster_chick_normal,.Lfe5-SP_monster_chick_normal
	.section	".rodata"
	.align 2
.LC59:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_monster_chick_fire
	.type	 SP_monster_chick_fire,@function
SP_monster_chick_fire:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 23,20(1)
	stw 0,68(1)
	lis 11,.LC59@ha
	lis 9,deathmatch@ha
	la 11,.LC59@l(11)
	mr 31,3
	lfs 31,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,31
	bc 12,2,.L120
	bl G_FreeEdict
	b .L119
.L120:
	lis 29,gi@ha
	lis 3,.LC42@ha
	la 29,gi@l(29)
	la 3,.LC42@l(3)
	lwz 9,36(29)
	li 23,2
	mtlr 9
	blrl
	lwz 10,36(29)
	lis 9,sound_missile_prelaunch@ha
	lis 11,.LC43@ha
	stw 3,sound_missile_prelaunch@l(9)
	mtlr 10
	la 3,.LC43@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_missile_launch@ha
	lis 11,.LC44@ha
	stw 3,sound_missile_launch@l(9)
	mtlr 10
	la 3,.LC44@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_melee_swing@ha
	lis 11,.LC45@ha
	stw 3,sound_melee_swing@l(9)
	mtlr 10
	la 3,.LC45@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_melee_hit@ha
	lis 11,.LC46@ha
	stw 3,sound_melee_hit@l(9)
	mtlr 10
	la 3,.LC46@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_missile_reload@ha
	lis 11,.LC47@ha
	stw 3,sound_missile_reload@l(9)
	mtlr 10
	la 3,.LC47@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_death1@ha
	lis 11,.LC48@ha
	stw 3,sound_death1@l(9)
	mtlr 10
	la 3,.LC48@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_death2@ha
	lis 11,.LC49@ha
	stw 3,sound_death2@l(9)
	mtlr 10
	la 3,.LC49@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_fall_down@ha
	lis 11,.LC50@ha
	stw 3,sound_fall_down@l(9)
	mtlr 10
	la 3,.LC50@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_idle1@ha
	lis 11,.LC51@ha
	stw 3,sound_idle1@l(9)
	mtlr 10
	la 3,.LC51@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_idle2@ha
	lis 11,.LC52@ha
	stw 3,sound_idle2@l(9)
	mtlr 10
	la 3,.LC52@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain1@ha
	lis 11,.LC53@ha
	stw 3,sound_pain1@l(9)
	mtlr 10
	la 3,.LC53@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain2@ha
	lis 11,.LC54@ha
	stw 3,sound_pain2@l(9)
	mtlr 10
	la 3,.LC54@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_pain3@ha
	lis 11,.LC55@ha
	stw 3,sound_pain3@l(9)
	mtlr 10
	la 3,.LC55@l(11)
	blrl
	lwz 10,36(29)
	lis 9,sound_sight@ha
	lis 11,.LC56@ha
	stw 3,sound_sight@l(9)
	mtlr 10
	la 3,.LC56@l(11)
	blrl
	lis 9,sound_search@ha
	li 0,5
	stw 3,sound_search@l(9)
	stw 0,260(31)
	lis 3,.LC57@ha
	stw 23,248(31)
	la 3,.LC57@l(3)
	lwz 9,32(29)
	mtlr 9
	blrl
	lis 9,chick_pain@ha
	lis 11,chick_die@ha
	stw 3,40(31)
	lis 10,chick_stand@ha
	lis 8,chick_walk@ha
	stfs 31,196(31)
	la 9,chick_pain@l(9)
	la 11,chick_die@l(11)
	la 10,chick_stand@l(10)
	la 8,chick_walk@l(8)
	stw 9,452(31)
	stw 11,456(31)
	lis 7,chick_run@ha
	lis 6,M_MonsterDodge@ha
	stw 10,788(31)
	lis 5,chick_duck@ha
	lis 4,monster_duck_up@ha
	stw 8,800(31)
	lis 28,chick_sidestep@ha
	lis 27,chick_attack@ha
	lis 26,chick_melee@ha
	lis 25,chick_sight@ha
	lis 24,chick_blocked@ha
	lis 10,0xc180
	lis 8,0x4180
	li 11,250
	stw 10,192(31)
	la 7,chick_run@l(7)
	la 6,M_MonsterDodge@l(6)
	stw 8,204(31)
	la 5,chick_duck@l(5)
	la 4,monster_duck_up@l(4)
	stw 7,804(31)
	lis 9,0x4260
	la 28,chick_sidestep@l(28)
	stw 6,808(31)
	la 27,chick_attack@l(27)
	la 26,chick_melee@l(26)
	stw 5,920(31)
	la 25,chick_sight@l(25)
	la 24,chick_blocked@l(24)
	stw 9,208(31)
	li 0,-70
	stw 11,400(31)
	mr 3,31
	stw 4,924(31)
	stw 10,188(31)
	stw 8,200(31)
	stw 11,480(31)
	stw 0,488(31)
	stw 28,928(31)
	stw 27,812(31)
	stw 26,816(31)
	stw 25,820(31)
	stw 24,892(31)
	lwz 0,72(29)
	mtlr 0
	blrl
	lis 9,chick_move_stand@ha
	lis 11,SP_monster_chick_fire@ha
	lis 0,0x3f80
	la 9,chick_move_stand@l(9)
	la 11,SP_monster_chick_fire@l(11)
	li 10,1
	stw 0,784(31)
	stw 9,772(31)
	mr 3,31
	stw 10,948(31)
	stw 11,992(31)
	bl walkmonster_start
	li 0,0
	stw 23,60(31)
	stw 0,1136(31)
.L119:
	lwz 0,68(1)
	mtlr 0
	lmw 23,20(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 SP_monster_chick_fire,.Lfe6-SP_monster_chick_fire
	.align 2
	.globl chick_stand
	.type	 chick_stand,@function
chick_stand:
	lis 9,chick_move_stand@ha
	la 9,chick_move_stand@l(9)
	stw 9,772(3)
	blr
.Lfe7:
	.size	 chick_stand,.Lfe7-chick_stand
	.align 2
	.globl chick_run
	.type	 chick_run,@function
chick_run:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	bl monster_done_dodge
	lwz 0,776(31)
	andi. 9,0,1
	bc 12,2,.L15
	lis 9,chick_move_stand@ha
	la 9,chick_move_stand@l(9)
	b .L16
.L15:
	lwz 0,772(31)
	lis 9,chick_move_walk@ha
	la 9,chick_move_walk@l(9)
	cmpw 0,0,9
	bc 12,2,.L17
	lis 9,chick_move_start_run@ha
	la 9,chick_move_start_run@l(9)
	cmpw 0,0,9
	bc 4,2,.L16
.L17:
	lis 9,chick_move_run@ha
	la 9,chick_move_run@l(9)
.L16:
	stw 9,772(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe8:
	.size	 chick_run,.Lfe8-chick_run
	.section	".rodata"
	.align 2
.LC62:
	.long 0x46fffe00
	.align 3
.LC63:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 3
.LC64:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl chick_reslash
	.type	 chick_reslash,@function
chick_reslash:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 4,540(31)
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L88
	bl range
	cmpwi 0,3,0
	bc 4,2,.L88
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC64@ha
	lis 10,.LC62@ha
	la 11,.LC64@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC63@ha
	lfs 11,.LC62@l(10)
	lfd 12,.LC63@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,0
	bc 4,3,.L90
	lis 9,chick_move_slash@ha
	la 9,chick_move_slash@l(9)
	b .L124
.L90:
.L88:
	lis 9,chick_move_end_slash@ha
	la 9,chick_move_end_slash@l(9)
.L124:
	stw 9,772(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 chick_reslash,.Lfe9-chick_reslash
	.section	".rodata"
	.align 2
.LC65:
	.long 0x46fffe00
	.align 3
.LC66:
	.long 0x3fa99999
	.long 0x9999999a
	.align 3
.LC67:
	.long 0x3fe33333
	.long 0x33333333
	.align 3
.LC68:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl chick_rerocket
	.type	 chick_rerocket,@function
chick_rerocket:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,776(31)
	andis. 9,0,1
	bc 12,2,.L81
	lis 9,chick_move_end_attack1@ha
	rlwinm 0,0,0,16,14
	la 9,chick_move_end_attack1@l(9)
	stw 0,776(31)
	b .L125
.L81:
	lwz 4,540(31)
	lwz 0,480(4)
	cmpwi 0,0,0
	bc 4,1,.L82
	mr 3,31
	bl range
	cmpwi 0,3,0
	bc 4,1,.L82
	lwz 4,540(31)
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L82
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC68@ha
	lis 10,.LC65@ha
	la 11,.LC68@l(11)
	stw 0,16(1)
	lis 8,.LC66@ha
	lfd 13,0(11)
	lis 7,.LC67@ha
	lfd 0,16(1)
	lis 11,skill@ha
	lfs 9,.LC65@l(10)
	lwz 9,skill@l(11)
	fsub 0,0,13
	lfd 10,.LC66@l(8)
	lfs 12,20(9)
	lfd 11,.LC67@l(7)
	frsp 0,0
	fdivs 0,0,9
	fmadd 12,12,10,11
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,0
	bc 4,3,.L82
	lis 9,chick_move_attack1@ha
	la 9,chick_move_attack1@l(9)
	b .L125
.L82:
	lis 9,chick_move_end_attack1@ha
	la 9,chick_move_end_attack1@l(9)
.L125:
	stw 9,772(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe10:
	.size	 chick_rerocket,.Lfe10-chick_rerocket
	.align 2
	.globl chick_attack1
	.type	 chick_attack1,@function
chick_attack1:
	lis 9,chick_move_attack1@ha
	la 9,chick_move_attack1@l(9)
	stw 9,772(3)
	blr
.Lfe11:
	.size	 chick_attack1,.Lfe11-chick_attack1
	.section	".sbss","aw",@nobits
	.align 2
sound_missile_prelaunch:
	.space	4
	.size	 sound_missile_prelaunch,4
	.align 2
sound_missile_launch:
	.space	4
	.size	 sound_missile_launch,4
	.align 2
sound_melee_swing:
	.space	4
	.size	 sound_melee_swing,4
	.align 2
sound_melee_hit:
	.space	4
	.size	 sound_melee_hit,4
	.align 2
sound_missile_reload:
	.space	4
	.size	 sound_missile_reload,4
	.align 2
sound_death1:
	.space	4
	.size	 sound_death1,4
	.align 2
sound_death2:
	.space	4
	.size	 sound_death2,4
	.align 2
sound_fall_down:
	.space	4
	.size	 sound_fall_down,4
	.align 2
sound_idle1:
	.space	4
	.size	 sound_idle1,4
	.align 2
sound_idle2:
	.space	4
	.size	 sound_idle2,4
	.align 2
sound_pain1:
	.space	4
	.size	 sound_pain1,4
	.align 2
sound_pain2:
	.space	4
	.size	 sound_pain2,4
	.align 2
sound_pain3:
	.space	4
	.size	 sound_pain3,4
	.align 2
sound_sight:
	.space	4
	.size	 sound_sight,4
	.align 2
sound_search:
	.space	4
	.size	 sound_search,4
	.section	".rodata"
	.align 2
.LC69:
	.long 0x46fffe00
	.align 3
.LC70:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC71:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC72:
	.long 0x3f800000
	.align 2
.LC73:
	.long 0x40000000
	.align 2
.LC74:
	.long 0x0
	.section	".text"
	.align 2
	.globl ChickMoan
	.type	 ChickMoan,@function
ChickMoan:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC70@ha
	lis 11,.LC69@ha
	la 10,.LC70@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC71@ha
	lfs 12,.LC69@l(11)
	la 10,.LC71@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 4,0,.L7
	lis 9,gi+16@ha
	lis 11,sound_idle1@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC74@ha
	mr 3,31
	lwz 5,sound_idle1@l(11)
	lis 9,.LC73@ha
	la 10,.LC74@l(10)
	lis 11,.LC72@ha
	la 9,.LC73@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC72@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L8
.L7:
	lis 9,gi+16@ha
	lis 11,sound_idle2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC73@ha
	mr 3,31
	lwz 5,sound_idle2@l(11)
	lis 9,.LC72@ha
	la 10,.LC73@l(10)
	lis 11,.LC74@ha
	la 9,.LC72@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC74@l(11)
	li 4,2
	lfs 1,0(9)
	lfs 3,0(11)
	blrl
.L8:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 ChickMoan,.Lfe12-ChickMoan
	.section	".rodata"
	.align 2
.LC75:
	.long 0x46fffe00
	.align 3
.LC76:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC77:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl chick_fidget
	.type	 chick_fidget,@function
chick_fidget:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,776(31)
	andi. 9,0,1
	bc 4,2,.L9
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC77@ha
	lis 10,.LC75@ha
	la 11,.LC77@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC76@ha
	lfs 11,.LC75@l(10)
	lfd 12,.LC76@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,0
	bc 4,3,.L9
	lis 9,chick_move_fidget@ha
	la 9,chick_move_fidget@l(9)
	stw 9,772(31)
.L9:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 chick_fidget,.Lfe13-chick_fidget
	.align 2
	.globl chick_walk
	.type	 chick_walk,@function
chick_walk:
	lis 9,chick_move_walk@ha
	la 9,chick_move_walk@l(9)
	stw 9,772(3)
	blr
.Lfe14:
	.size	 chick_walk,.Lfe14-chick_walk
	.align 2
	.globl chick_dead
	.type	 chick_dead,@function
chick_dead:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 29,3
	lis 9,0x4180
	lwz 0,184(29)
	lis 10,0xc180
	li 8,0
	li 11,7
	stw 9,208(29)
	ori 0,0,2
	stw 9,200(29)
	stw 0,184(29)
	stw 9,204(29)
	stw 10,192(29)
	stw 11,260(29)
	stw 8,428(29)
	stw 10,188(29)
	stw 8,196(29)
	bl SetMonsterRespawn
	lis 9,gi+72@ha
	mr 3,29
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 chick_dead,.Lfe15-chick_dead
	.section	".rodata"
	.align 2
.LC78:
	.long 0x3f800000
	.align 2
.LC79:
	.long 0x0
	.section	".text"
	.align 2
	.globl ChickSlash
	.type	 ChickSlash,@function
ChickSlash:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,gi+16@ha
	mr 29,3
	lwz 10,gi+16@l(9)
	lis 11,sound_melee_swing@ha
	li 4,1
	lis 9,.LC78@ha
	lfs 0,188(29)
	la 9,.LC78@l(9)
	lwz 5,sound_melee_swing@l(11)
	mtlr 10
	lis 0,0x42a0
	lfs 1,0(9)
	lis 9,.LC78@ha
	stw 0,8(1)
	la 9,.LC78@l(9)
	stfs 0,12(1)
	lfs 2,0(9)
	lis 9,.LC79@ha
	la 9,.LC79@l(9)
	lfs 3,0(9)
	lis 9,0x4120
	stw 9,16(1)
	blrl
	bl rand
	lis 0,0x2aaa
	mr 5,3
	ori 0,0,43691
	srawi 9,5,31
	mulhw 0,5,0
	mr 3,29
	addi 4,1,8
	li 6,100
	subf 0,9,0
	mulli 0,0,6
	subf 5,0,5
	addi 5,5,10
	bl fire_hit
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe16:
	.size	 ChickSlash,.Lfe16-ChickSlash
	.section	".rodata"
	.align 2
.LC80:
	.long 0x3f800000
	.align 2
.LC81:
	.long 0x0
	.section	".text"
	.align 2
	.globl Chick_PreAttack1
	.type	 Chick_PreAttack1,@function
Chick_PreAttack1:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_missile_prelaunch@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC80@ha
	lwz 5,sound_missile_prelaunch@l(11)
	la 9,.LC80@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC80@ha
	la 9,.LC80@l(9)
	lfs 2,0(9)
	lis 9,.LC81@ha
	la 9,.LC81@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe17:
	.size	 Chick_PreAttack1,.Lfe17-Chick_PreAttack1
	.section	".rodata"
	.align 2
.LC82:
	.long 0x3f800000
	.align 2
.LC83:
	.long 0x0
	.section	".text"
	.align 2
	.globl ChickReload
	.type	 ChickReload,@function
ChickReload:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_missile_reload@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC82@ha
	lwz 5,sound_missile_reload@l(11)
	la 9,.LC82@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC82@ha
	la 9,.LC82@l(9)
	lfs 2,0(9)
	lis 9,.LC83@ha
	la 9,.LC83@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe18:
	.size	 ChickReload,.Lfe18-ChickReload
	.align 2
	.globl chick_slash
	.type	 chick_slash,@function
chick_slash:
	lis 9,chick_move_slash@ha
	la 9,chick_move_slash@l(9)
	stw 9,772(3)
	blr
.Lfe19:
	.size	 chick_slash,.Lfe19-chick_slash
	.align 2
	.globl chick_melee
	.type	 chick_melee,@function
chick_melee:
	lis 9,chick_move_start_slash@ha
	la 9,chick_move_start_slash@l(9)
	stw 9,772(3)
	blr
.Lfe20:
	.size	 chick_melee,.Lfe20-chick_melee
	.section	".rodata"
	.align 2
.LC84:
	.long 0x3f800000
	.align 2
.LC85:
	.long 0x0
	.section	".text"
	.align 2
	.globl chick_sight
	.type	 chick_sight,@function
chick_sight:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,gi+16@ha
	lis 11,sound_sight@ha
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC84@ha
	lwz 5,sound_sight@l(11)
	la 9,.LC84@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC84@ha
	la 9,.LC84@l(9)
	lfs 2,0(9)
	lis 9,.LC85@ha
	la 9,.LC85@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 chick_sight,.Lfe21-chick_sight
	.section	".rodata"
	.align 3
.LC86:
	.long 0x3fa99999
	.long 0x9999999a
	.align 3
.LC87:
	.long 0x3fd00000
	.long 0x0
	.section	".text"
	.align 2
	.globl chick_blocked
	.type	 chick_blocked,@function
chick_blocked:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stw 31,20(1)
	stw 0,36(1)
	lis 9,skill@ha
	fmr 31,1
	lis 11,.LC86@ha
	lwz 10,skill@l(9)
	mr 31,3
	lis 9,.LC87@ha
	lfd 0,.LC86@l(11)
	lfs 1,20(10)
	la 9,.LC87@l(9)
	lfd 13,0(9)
	fmadd 1,1,0,13
	frsp 1,1
	bl blocked_checkshot
	cmpwi 0,3,0
	li 3,1
	bc 4,2,.L126
	fmr 1,31
	mr 3,31
	bl blocked_checkplat
	addic 9,3,-1
	subfe 0,9,3
	mr 3,0
.L126:
	lwz 0,36(1)
	mtlr 0
	lwz 31,20(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe22:
	.size	 chick_blocked,.Lfe22-chick_blocked
	.section	".rodata"
	.align 3
.LC88:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC89:
	.long 0x0
	.align 2
.LC90:
	.long 0x3f800000
	.align 2
.LC91:
	.long 0x40400000
	.section	".text"
	.align 2
	.globl chick_duck
	.type	 chick_duck,@function
chick_duck:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 9,chick_move_start_attack1@ha
	lwz 0,772(31)
	la 9,chick_move_start_attack1@l(9)
	cmpw 0,0,9
	bc 12,2,.L108
	lis 9,chick_move_attack1@ha
	la 9,chick_move_attack1@l(9)
	cmpw 0,0,9
	bc 4,2,.L107
.L108:
	lis 9,.LC89@ha
	lis 11,skill@ha
	la 9,.LC89@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L107
	lwz 0,776(31)
	rlwinm 0,0,0,21,19
	stw 0,776(31)
	b .L106
.L107:
	lis 11,.LC89@ha
	lis 9,skill@ha
	la 11,.LC89@l(11)
	lfs 0,0(11)
	lwz 11,skill@l(9)
	lfs 12,20(11)
	fcmpu 0,12,0
	bc 4,2,.L110
	lis 9,level+4@ha
	lis 11,.LC90@ha
	lfs 0,level+4@l(9)
	la 11,.LC90@l(11)
	lfs 13,0(11)
	fadds 0,0,1
	fadds 0,0,13
	b .L127
.L110:
	lis 11,.LC91@ha
	lis 9,level+4@ha
	la 11,.LC91@l(11)
	lfs 13,level+4@l(9)
	lfs 0,0(11)
	lis 9,.LC88@ha
	fadds 13,13,1
	fsubs 0,0,12
	lfd 12,.LC88@l(9)
	fmadd 0,0,12,13
	frsp 0,0
.L127:
	stfs 0,940(31)
	mr 3,31
	bl monster_duck_down
	lis 9,chick_move_duck@ha
	li 0,83
	la 9,chick_move_duck@l(9)
	stw 0,780(31)
	stw 9,772(31)
.L106:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe23:
	.size	 chick_duck,.Lfe23-chick_duck
	.section	".rodata"
	.align 2
.LC92:
	.long 0x0
	.section	".text"
	.align 2
	.globl chick_sidestep
	.type	 chick_sidestep,@function
chick_sidestep:
	lis 9,chick_move_start_attack1@ha
	lwz 0,772(3)
	la 9,chick_move_start_attack1@l(9)
	cmpw 0,0,9
	bc 12,2,.L114
	lis 9,chick_move_attack1@ha
	la 9,chick_move_attack1@l(9)
	cmpw 0,0,9
	bc 4,2,.L113
.L114:
	lis 9,.LC92@ha
	lis 11,skill@ha
	la 9,.LC92@l(9)
	lfs 13,0(9)
	lwz 9,skill@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L113
	lwz 0,776(3)
	rlwinm 0,0,0,14,12
	stw 0,776(3)
	blr
.L113:
	lwz 0,772(3)
	lis 9,chick_move_run@ha
	la 9,chick_move_run@l(9)
	cmpw 0,0,9
	bclr 12,2
	stw 9,772(3)
	blr
.Lfe24:
	.size	 chick_sidestep,.Lfe24-chick_sidestep
	.section	".rodata"
	.align 2
.LC93:
	.long 0x46fffe00
	.align 3
.LC94:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC95:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SP_monster_chick
	.type	 SP_monster_chick,@function
SP_monster_chick:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr 31,3
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC95@ha
	lis 10,.LC93@ha
	la 11,.LC95@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC94@ha
	lfs 11,.LC93@l(10)
	lfd 12,.LC94@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	bc 4,1,.L122
	mr 3,31
	bl SP_monster_chick_normal
	b .L123
.L122:
	mr 3,31
	bl SP_monster_chick_fire
.L123:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe25:
	.size	 SP_monster_chick,.Lfe25-SP_monster_chick
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
