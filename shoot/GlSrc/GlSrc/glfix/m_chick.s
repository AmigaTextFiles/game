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
	.long 0
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
	lwz 0,580(31)
	lwz 11,576(31)
	srwi 9,0,31
	add 0,0,9
	srawi 0,0,1
	cmpw 0,11,0
	bc 4,0,.L20
	li 0,1
	stw 0,60(31)
.L20:
	lis 9,level+4@ha
	lfs 0,560(31)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 12,0,.L19
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	lfs 0,0(9)
	fadds 0,13,0
	stfs 0,560(31)
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
	b .L31
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
.L31:
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
	cmpwi 0,30,10
	bc 12,1,.L27
	lis 9,chick_move_pain1@ha
	la 9,chick_move_pain1@l(9)
	b .L32
.L27:
	cmpwi 0,30,25
	bc 12,1,.L29
	lis 9,chick_move_pain2@ha
	la 9,chick_move_pain2@l(9)
	b .L32
.L29:
	lis 9,chick_move_pain3@ha
	la 9,chick_move_pain3@l(9)
.L32:
	stw 9,868(31)
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
	lwz 9,576(31)
	lwz 0,584(31)
	cmpw 0,9,0
	bc 12,1,.L35
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
.L39:
	mr 3,31
	la 4,.LC11@l(27)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L39
	li 30,4
.L44:
	mr 3,31
	la 4,.LC12@l(26)
	mr 5,28
	li 6,0
	bl ThrowGib
	addic. 30,30,-1
	bc 4,2,.L44
	lis 4,.LC13@ha
	mr 5,28
	la 4,.LC13@l(4)
	mr 3,31
	li 6,0
	bl ThrowHead
	li 0,2
	stw 0,588(31)
	b .L34
.L35:
	lwz 0,588(31)
	cmpwi 0,0,2
	bc 12,2,.L34
	li 0,2
	li 9,1
	stw 0,588(31)
	stw 9,608(31)
	bl rand
	srwi 0,3,31
	add 0,3,0
	rlwinm 0,0,0,0,30
	cmpw 0,3,0
	bc 4,2,.L47
	lis 9,chick_move_death1@ha
	lis 11,gi+16@ha
	la 9,chick_move_death1@l(9)
	lis 10,sound_death1@ha
	stw 9,868(31)
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
	b .L34
.L47:
	lis 9,chick_move_death2@ha
	lis 11,gi+16@ha
	la 9,chick_move_death2@l(9)
	lis 10,sound_death2@ha
	stw 9,868(31)
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
.L34:
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
	.long chick_duck_down
	.long ai_move
	.long 0x3f800000
	.long 0
	.long ai_move
	.long 0x40800000
	.long chick_duck_hold
	.long ai_move
	.long 0xc0800000
	.long 0
	.long ai_move
	.long 0xc0a00000
	.long chick_duck_up
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
	.globl chick_frames_start_attack1
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
.LC21:
	.string	"chick/chkatck1.wav"
	.align 2
.LC22:
	.string	"chick/chkatck2.wav"
	.align 2
.LC23:
	.string	"chick/chkatck3.wav"
	.align 2
.LC24:
	.string	"chick/chkatck4.wav"
	.align 2
.LC25:
	.string	"chick/chkatck5.wav"
	.align 2
.LC26:
	.string	"chick/chkdeth1.wav"
	.align 2
.LC27:
	.string	"chick/chkdeth2.wav"
	.align 2
.LC28:
	.string	"chick/chkfall1.wav"
	.align 2
.LC29:
	.string	"chick/chkidle1.wav"
	.align 2
.LC30:
	.string	"chick/chkidle2.wav"
	.align 2
.LC31:
	.string	"chick/chkpain1.wav"
	.align 2
.LC32:
	.string	"chick/chkpain2.wav"
	.align 2
.LC33:
	.string	"chick/chkpain3.wav"
	.align 2
.LC34:
	.string	"chick/chksght1.wav"
	.align 2
.LC35:
	.string	"chick/chksrch1.wav"
	.align 2
.LC36:
	.string	"models/monsters/bitch/tris.md2"
	.section	".text"
	.align 2
	.globl SP_monster_chick
	.type	 SP_monster_chick,@function
SP_monster_chick:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 28,gi@ha
	mr 29,3
	la 28,gi@l(28)
	lis 3,.LC21@ha
	lwz 9,36(28)
	la 3,.LC21@l(3)
	mtlr 9
	blrl
	lwz 10,36(28)
	lis 9,sound_missile_prelaunch@ha
	lis 11,.LC22@ha
	stw 3,sound_missile_prelaunch@l(9)
	mtlr 10
	la 3,.LC22@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_missile_launch@ha
	lis 11,.LC23@ha
	stw 3,sound_missile_launch@l(9)
	mtlr 10
	la 3,.LC23@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_melee_swing@ha
	lis 11,.LC24@ha
	stw 3,sound_melee_swing@l(9)
	mtlr 10
	la 3,.LC24@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_melee_hit@ha
	lis 11,.LC25@ha
	stw 3,sound_melee_hit@l(9)
	mtlr 10
	la 3,.LC25@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_missile_reload@ha
	lis 11,.LC26@ha
	stw 3,sound_missile_reload@l(9)
	mtlr 10
	la 3,.LC26@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_death1@ha
	lis 11,.LC27@ha
	stw 3,sound_death1@l(9)
	mtlr 10
	la 3,.LC27@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_death2@ha
	lis 11,.LC28@ha
	stw 3,sound_death2@l(9)
	mtlr 10
	la 3,.LC28@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_fall_down@ha
	lis 11,.LC29@ha
	stw 3,sound_fall_down@l(9)
	mtlr 10
	la 3,.LC29@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_idle1@ha
	lis 11,.LC30@ha
	stw 3,sound_idle1@l(9)
	mtlr 10
	la 3,.LC30@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_idle2@ha
	lis 11,.LC31@ha
	stw 3,sound_idle2@l(9)
	mtlr 10
	la 3,.LC31@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_pain1@ha
	lis 11,.LC32@ha
	stw 3,sound_pain1@l(9)
	mtlr 10
	la 3,.LC32@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_pain2@ha
	lis 11,.LC33@ha
	stw 3,sound_pain2@l(9)
	mtlr 10
	la 3,.LC33@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_pain3@ha
	lis 11,.LC34@ha
	stw 3,sound_pain3@l(9)
	mtlr 10
	la 3,.LC34@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_sight@ha
	lis 11,.LC35@ha
	stw 3,sound_sight@l(9)
	mtlr 10
	la 3,.LC35@l(11)
	blrl
	lis 9,sound_search@ha
	li 0,5
	stw 3,sound_search@l(9)
	li 11,2
	stw 0,260(29)
	lis 3,.LC36@ha
	stw 11,248(29)
	la 3,.LC36@l(3)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 9,chick_pain@ha
	lis 11,chick_die@ha
	stw 3,40(29)
	lis 10,chick_stand@ha
	lis 8,chick_walk@ha
	la 9,chick_pain@l(9)
	la 11,chick_die@l(11)
	la 10,chick_stand@l(10)
	la 8,chick_walk@l(8)
	stw 9,548(29)
	stw 11,552(29)
	lis 7,chick_run@ha
	lis 6,chick_dodge@ha
	stw 10,884(29)
	lis 5,chick_attack@ha
	lis 4,chick_melee@ha
	stw 8,896(29)
	lis 27,chick_sight@ha
	li 9,200
	la 7,chick_run@l(7)
	la 6,chick_dodge@l(6)
	stw 9,496(29)
	la 5,chick_attack@l(5)
	la 4,chick_melee@l(4)
	stw 7,900(29)
	la 27,chick_sight@l(27)
	lis 26,0xc180
	stw 6,904(29)
	lis 25,0x4180
	li 0,0
	stw 26,192(29)
	lis 8,0x4260
	li 11,175
	stw 0,196(29)
	li 10,-70
	stw 25,204(29)
	mr 3,29
	stw 8,208(29)
	stw 11,576(29)
	stw 10,584(29)
	stw 5,908(29)
	stw 4,912(29)
	stw 27,916(29)
	stw 26,188(29)
	stw 25,200(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lis 9,chick_move_stand@ha
	lis 0,0x3f80
	la 9,chick_move_stand@l(9)
	stw 0,880(29)
	mr 3,29
	stw 9,868(29)
	bl walkmonster_start
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 SP_monster_chick,.Lfe3-SP_monster_chick
	.section	".rodata"
	.align 2
.LC37:
	.string	"chick"
	.align 2
.LC38:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl SP_monster_chick2
	.type	 SP_monster_chick2,@function
SP_monster_chick2:
	stwu 1,-64(1)
	mflr 0
	stmw 24,32(1)
	stw 0,68(1)
	mr 28,3
	li 4,36
	li 5,100
	li 6,10
	bl CheckBounds
	cmpwi 0,3,0
	bc 12,2,.L78
	bl G_Spawn
	lwz 9,84(28)
	mr 29,3
	li 6,0
	addi 4,1,8
	li 5,0
	addi 3,9,3636
	addi 27,29,4
	bl AngleVectors
	lis 9,.LC38@ha
	mr 5,27
	la 9,.LC38@l(9)
	addi 4,1,8
	lfs 1,0(9)
	addi 3,28,4
	bl VectorMA
	lfs 0,20(28)
	li 3,1
	lis 28,gi@ha
	la 28,gi@l(28)
	stfs 0,20(29)
	lwz 9,100(28)
	mtlr 9
	blrl
	lis 9,g_edicts@ha
	lis 0,0xbdef
	lwz 10,104(28)
	lwz 3,g_edicts@l(9)
	ori 0,0,31711
	mtlr 10
	subf 3,3,29
	mullw 3,3,0
	srawi 3,3,5
	blrl
	lwz 9,100(28)
	li 3,9
	mtlr 9
	blrl
	lwz 9,88(28)
	li 4,2
	mr 3,27
	mtlr 9
	blrl
	lwz 9,36(28)
	lis 3,.LC21@ha
	la 3,.LC21@l(3)
	mtlr 9
	blrl
	lwz 10,36(28)
	lis 9,sound_missile_prelaunch@ha
	lis 11,.LC22@ha
	stw 3,sound_missile_prelaunch@l(9)
	mtlr 10
	la 3,.LC22@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_missile_launch@ha
	lis 11,.LC23@ha
	stw 3,sound_missile_launch@l(9)
	mtlr 10
	la 3,.LC23@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_melee_swing@ha
	lis 11,.LC24@ha
	stw 3,sound_melee_swing@l(9)
	mtlr 10
	la 3,.LC24@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_melee_hit@ha
	lis 11,.LC25@ha
	stw 3,sound_melee_hit@l(9)
	mtlr 10
	la 3,.LC25@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_missile_reload@ha
	lis 11,.LC26@ha
	stw 3,sound_missile_reload@l(9)
	mtlr 10
	la 3,.LC26@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_death1@ha
	lis 11,.LC27@ha
	stw 3,sound_death1@l(9)
	mtlr 10
	la 3,.LC27@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_death2@ha
	lis 11,.LC28@ha
	stw 3,sound_death2@l(9)
	mtlr 10
	la 3,.LC28@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_fall_down@ha
	lis 11,.LC29@ha
	stw 3,sound_fall_down@l(9)
	mtlr 10
	la 3,.LC29@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_idle1@ha
	lis 11,.LC30@ha
	stw 3,sound_idle1@l(9)
	mtlr 10
	la 3,.LC30@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_idle2@ha
	lis 11,.LC31@ha
	stw 3,sound_idle2@l(9)
	mtlr 10
	la 3,.LC31@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_pain1@ha
	lis 11,.LC32@ha
	stw 3,sound_pain1@l(9)
	mtlr 10
	la 3,.LC32@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_pain2@ha
	lis 11,.LC33@ha
	stw 3,sound_pain2@l(9)
	mtlr 10
	la 3,.LC33@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_pain3@ha
	lis 11,.LC34@ha
	stw 3,sound_pain3@l(9)
	mtlr 10
	la 3,.LC34@l(11)
	blrl
	lwz 10,36(28)
	lis 9,sound_sight@ha
	lis 11,.LC35@ha
	stw 3,sound_sight@l(9)
	mtlr 10
	la 3,.LC35@l(11)
	blrl
	lis 9,sound_search@ha
	li 0,5
	stw 3,sound_search@l(9)
	li 11,2
	stw 0,260(29)
	lis 3,.LC36@ha
	stw 11,248(29)
	la 3,.LC36@l(3)
	lwz 9,32(28)
	mtlr 9
	blrl
	lis 9,chick_pain@ha
	lis 11,chick_die@ha
	stw 3,40(29)
	lis 10,chick_stand@ha
	lis 8,chick_walk@ha
	la 9,chick_pain@l(9)
	la 11,chick_die@l(11)
	la 10,chick_stand@l(10)
	la 8,chick_walk@l(8)
	stw 9,548(29)
	stw 11,552(29)
	lis 7,chick_run@ha
	lis 6,chick_dodge@ha
	stw 10,884(29)
	lis 5,chick_attack@ha
	lis 4,chick_melee@ha
	stw 8,896(29)
	lis 27,chick_sight@ha
	lis 26,.LC37@ha
	li 9,200
	la 7,chick_run@l(7)
	la 6,chick_dodge@l(6)
	la 5,chick_attack@l(5)
	stw 9,496(29)
	la 4,chick_melee@l(4)
	la 27,chick_sight@l(27)
	stw 7,900(29)
	la 26,.LC37@l(26)
	lis 25,0xc180
	stw 6,904(29)
	lis 24,0x4180
	li 0,0
	stw 25,192(29)
	lis 8,0x4260
	li 11,175
	stw 0,196(29)
	li 10,-70
	stw 24,204(29)
	mr 3,29
	stw 8,208(29)
	stw 11,576(29)
	stw 10,584(29)
	stw 5,908(29)
	stw 4,912(29)
	stw 27,916(29)
	stw 26,280(29)
	stw 25,188(29)
	stw 24,200(29)
	lwz 0,72(28)
	mtlr 0
	blrl
	lis 9,chick_move_stand@ha
	lis 0,0x3f80
	la 9,chick_move_stand@l(9)
	stw 0,880(29)
	mr 3,29
	stw 9,868(29)
	bl walkmonster_start
.L78:
	lwz 0,68(1)
	mtlr 0
	lmw 24,32(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 SP_monster_chick2,.Lfe4-SP_monster_chick2
	.comm	maplist,292,4
	.align 2
	.globl chick_stand
	.type	 chick_stand,@function
chick_stand:
	lis 9,chick_move_stand@ha
	la 9,chick_move_stand@l(9)
	stw 9,868(3)
	blr
.Lfe5:
	.size	 chick_stand,.Lfe5-chick_stand
	.align 2
	.globl chick_run
	.type	 chick_run,@function
chick_run:
	lwz 0,872(3)
	andi. 9,0,1
	bc 12,2,.L15
	lis 9,chick_move_stand@ha
	la 9,chick_move_stand@l(9)
.L81:
	stw 9,868(3)
	blr
.L15:
	lwz 0,868(3)
	lis 9,chick_move_walk@ha
	la 9,chick_move_walk@l(9)
	cmpw 0,0,9
	bc 12,2,.L17
	lis 9,chick_move_start_run@ha
	la 9,chick_move_start_run@l(9)
	cmpw 0,0,9
	bc 4,2,.L81
.L17:
	lis 9,chick_move_run@ha
	la 9,chick_move_run@l(9)
	b .L81
.Lfe6:
	.size	 chick_run,.Lfe6-chick_run
	.section	".rodata"
	.align 2
.LC39:
	.long 0x46fffe00
	.align 3
.LC40:
	.long 0x3feccccc
	.long 0xcccccccd
	.align 3
.LC41:
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
	lwz 4,636(31)
	lwz 0,576(4)
	cmpwi 0,0,0
	bc 4,1,.L69
	bl range
	cmpwi 0,3,0
	bc 4,2,.L69
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC41@ha
	lis 10,.LC39@ha
	la 11,.LC41@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC40@ha
	lfs 11,.LC39@l(10)
	lfd 12,.LC40@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,0
	bc 4,3,.L71
	lis 9,chick_move_slash@ha
	la 9,chick_move_slash@l(9)
	b .L82
.L71:
.L69:
	lis 9,chick_move_end_slash@ha
	la 9,chick_move_end_slash@l(9)
.L82:
	stw 9,868(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe7:
	.size	 chick_reslash,.Lfe7-chick_reslash
	.section	".rodata"
	.align 2
.LC42:
	.long 0x46fffe00
	.align 3
.LC43:
	.long 0x3fe33333
	.long 0x33333333
	.align 3
.LC44:
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
	lwz 4,636(31)
	lwz 0,576(4)
	cmpwi 0,0,0
	bc 4,1,.L63
	bl range
	cmpwi 0,3,0
	bc 4,1,.L63
	lwz 4,636(31)
	mr 3,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L63
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC44@ha
	lis 10,.LC42@ha
	la 11,.LC44@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC43@ha
	lfs 11,.LC42@l(10)
	lfd 12,.LC43@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,0
	bc 4,3,.L63
	lis 9,chick_move_attack1@ha
	la 9,chick_move_attack1@l(9)
	b .L83
.L63:
	lis 9,chick_move_end_attack1@ha
	la 9,chick_move_end_attack1@l(9)
.L83:
	stw 9,868(31)
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 chick_rerocket,.Lfe8-chick_rerocket
	.align 2
	.globl chick_attack1
	.type	 chick_attack1,@function
chick_attack1:
	lis 9,chick_move_attack1@ha
	la 9,chick_move_attack1@l(9)
	stw 9,868(3)
	blr
.Lfe9:
	.size	 chick_attack1,.Lfe9-chick_attack1
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
.LC45:
	.long 0x46fffe00
	.align 3
.LC46:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC47:
	.long 0x3fe00000
	.long 0x0
	.align 2
.LC48:
	.long 0x3f800000
	.align 2
.LC49:
	.long 0x40000000
	.align 2
.LC50:
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
	lis 10,.LC46@ha
	lis 11,.LC45@ha
	la 10,.LC46@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC47@ha
	lfs 12,.LC45@l(11)
	la 10,.LC47@l(10)
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
	lis 10,.LC50@ha
	mr 3,31
	lwz 5,sound_idle1@l(11)
	lis 9,.LC49@ha
	la 10,.LC50@l(10)
	lis 11,.LC48@ha
	la 9,.LC49@l(9)
	lfs 3,0(10)
	mtlr 0
	la 11,.LC48@l(11)
	li 4,2
	lfs 2,0(9)
	lfs 1,0(11)
	blrl
	b .L8
.L7:
	lis 9,gi+16@ha
	lis 11,sound_idle2@ha
	lwz 0,gi+16@l(9)
	lis 10,.LC49@ha
	mr 3,31
	lwz 5,sound_idle2@l(11)
	lis 9,.LC48@ha
	la 10,.LC49@l(10)
	lis 11,.LC50@ha
	la 9,.LC48@l(9)
	lfs 2,0(10)
	mtlr 0
	la 11,.LC50@l(11)
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
.Lfe10:
	.size	 ChickMoan,.Lfe10-ChickMoan
	.section	".rodata"
	.align 2
.LC51:
	.long 0x46fffe00
	.align 3
.LC52:
	.long 0x3fd33333
	.long 0x33333333
	.align 3
.LC53:
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
	lwz 0,872(31)
	andi. 9,0,1
	bc 4,2,.L9
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 11,.LC53@ha
	lis 10,.LC51@ha
	la 11,.LC53@l(11)
	stw 0,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	lis 11,.LC52@ha
	lfs 11,.LC51@l(10)
	lfd 12,.LC52@l(11)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,11
	fmr 13,0
	fcmpu 0,13,12
	cror 3,2,0
	bc 4,3,.L9
	lis 9,chick_move_fidget@ha
	la 9,chick_move_fidget@l(9)
	stw 9,868(31)
.L9:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe11:
	.size	 chick_fidget,.Lfe11-chick_fidget
	.align 2
	.globl chick_walk
	.type	 chick_walk,@function
chick_walk:
	lis 9,chick_move_walk@ha
	la 9,chick_move_walk@l(9)
	stw 9,868(3)
	blr
.Lfe12:
	.size	 chick_walk,.Lfe12-chick_walk
	.section	".rodata"
	.align 2
.LC54:
	.long 0x41a00000
	.section	".text"
	.align 2
	.globl chick_dead
	.type	 chick_dead,@function
chick_dead:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 9,3
	lis 10,0x4180
	lwz 0,184(9)
	lis 7,0xc180
	li 6,0
	li 8,7
	lis 11,.LC54@ha
	stw 6,524(9)
	ori 0,0,2
	stw 7,192(9)
	la 11,.LC54@l(11)
	stw 10,208(9)
	lis 4,level+4@ha
	lis 5,gi+72@ha
	stw 8,260(9)
	stw 0,184(9)
	stw 7,188(9)
	stw 6,196(9)
	stw 10,200(9)
	stw 10,204(9)
	lfs 0,level+4@l(4)
	lfs 13,0(11)
	lis 11,G_FreeEdict@ha
	la 11,G_FreeEdict@l(11)
	fadds 0,0,13
	stw 11,532(9)
	stfs 0,524(9)
	lwz 0,gi+72@l(5)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe13:
	.size	 chick_dead,.Lfe13-chick_dead
	.section	".rodata"
	.align 2
.LC55:
	.long 0x42000000
	.align 2
.LC56:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl chick_duck_down
	.type	 chick_duck_down,@function
chick_duck_down:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	lwz 0,872(10)
	andi. 9,0,2048
	bc 4,2,.L49
	lis 9,.LC55@ha
	lfs 13,208(10)
	ori 0,0,2048
	la 9,.LC55@l(9)
	stw 0,872(10)
	lis 11,level+4@ha
	lfs 0,0(9)
	li 9,1
	stw 9,608(10)
	fsubs 13,13,0
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 12,0(9)
	stfs 13,208(10)
	lis 9,gi+72@ha
	lfs 0,level+4@l(11)
	fadds 0,0,12
	stfs 0,924(10)
	lwz 0,gi+72@l(9)
	mtlr 0
	blrl
.L49:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe14:
	.size	 chick_duck_down,.Lfe14-chick_duck_down
	.align 2
	.globl chick_duck_hold
	.type	 chick_duck_hold,@function
chick_duck_hold:
	lis 9,level+4@ha
	lfs 0,924(3)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	cror 3,2,1
	bc 4,3,.L52
	lwz 0,872(3)
	rlwinm 0,0,0,25,23
	stw 0,872(3)
	blr
.L52:
	lwz 0,872(3)
	ori 0,0,128
	stw 0,872(3)
	blr
.Lfe15:
	.size	 chick_duck_hold,.Lfe15-chick_duck_hold
	.section	".rodata"
	.align 2
.LC57:
	.long 0x42000000
	.section	".text"
	.align 2
	.globl chick_duck_up
	.type	 chick_duck_up,@function
chick_duck_up:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC57@ha
	mr 9,3
	la 11,.LC57@l(11)
	lfs 0,208(9)
	lis 10,gi+72@ha
	lfs 13,0(11)
	lwz 0,872(9)
	li 11,2
	stw 11,608(9)
	fadds 0,0,13
	rlwinm 0,0,0,21,19
	stw 0,872(9)
	stfs 0,208(9)
	lwz 0,gi+72@l(10)
	mtlr 0
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe16:
	.size	 chick_duck_up,.Lfe16-chick_duck_up
	.section	".rodata"
	.align 2
.LC58:
	.long 0x46fffe00
	.align 3
.LC59:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC60:
	.long 0x3fd00000
	.long 0x0
	.section	".text"
	.align 2
	.globl chick_dodge
	.type	 chick_dodge,@function
chick_dodge:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	mr 31,3
	mr 30,4
	bl rand
	rlwinm 3,3,0,17,31
	xoris 3,3,0x8000
	lis 0,0x4330
	stw 3,20(1)
	lis 10,.LC59@ha
	lis 11,.LC58@ha
	la 10,.LC59@l(10)
	stw 0,16(1)
	lfd 13,0(10)
	lfd 0,16(1)
	lis 10,.LC60@ha
	lfs 12,.LC58@l(11)
	la 10,.LC60@l(10)
	lfd 11,0(10)
	fsub 0,0,13
	frsp 0,0
	fdivs 0,0,12
	fmr 13,0
	fcmpu 0,13,11
	bc 12,1,.L55
	lwz 0,636(31)
	cmpwi 0,0,0
	bc 4,2,.L57
	stw 30,636(31)
.L57:
	lis 9,chick_move_duck@ha
	la 9,chick_move_duck@l(9)
	stw 9,868(31)
.L55:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe17:
	.size	 chick_dodge,.Lfe17-chick_dodge
	.section	".rodata"
	.align 2
.LC61:
	.long 0x3f800000
	.align 2
.LC62:
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
	lis 9,.LC61@ha
	lfs 0,188(29)
	la 9,.LC61@l(9)
	lwz 5,sound_melee_swing@l(11)
	mtlr 10
	lis 0,0x42a0
	lfs 1,0(9)
	lis 9,.LC61@ha
	stw 0,8(1)
	la 9,.LC61@l(9)
	stfs 0,12(1)
	lfs 2,0(9)
	lis 9,.LC62@ha
	la 9,.LC62@l(9)
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
.Lfe18:
	.size	 ChickSlash,.Lfe18-ChickSlash
	.section	".rodata"
	.align 3
.LC63:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl ChickRocket
	.type	 ChickRocket,@function
ChickRocket:
	stwu 1,-128(1)
	mflr 0
	stmw 26,104(1)
	stw 0,132(1)
	addi 29,1,24
	mr 28,3
	addi 4,1,8
	addi 3,28,16
	mr 5,29
	li 6,0
	bl AngleVectors
	addi 27,1,40
	lis 4,monster_flash_offset+684@ha
	addi 26,1,56
	mr 6,29
	la 4,monster_flash_offset+684@l(4)
	addi 5,1,8
	mr 7,27
	addi 3,28,4
	bl G_ProjectSource
	lwz 9,636(28)
	lis 10,0x4330
	lfs 13,40(1)
	lis 8,.LC63@ha
	mr 3,26
	lfs 12,4(9)
	la 8,.LC63@l(8)
	lfs 10,44(1)
	lfd 9,0(8)
	stfs 12,72(1)
	lfs 0,8(9)
	fsubs 12,12,13
	lfs 11,48(1)
	stfs 0,76(1)
	lfs 13,12(9)
	fsubs 0,0,10
	stfs 13,80(1)
	lwz 0,604(9)
	stfs 0,60(1)
	xoris 0,0,0x8000
	stfs 12,56(1)
	stw 0,100(1)
	stw 10,96(1)
	lfd 0,96(1)
	fsub 0,0,9
	frsp 0,0
	fadds 13,13,0
	fsubs 11,13,11
	stfs 13,80(1)
	stfs 11,64(1)
	bl VectorNormalize
	mr 3,28
	mr 4,27
	mr 5,26
	li 6,70
	li 7,700
	li 8,57
	bl monster_fire_hrocket
	lwz 0,132(1)
	mtlr 0
	lmw 26,104(1)
	la 1,128(1)
	blr
.Lfe19:
	.size	 ChickRocket,.Lfe19-ChickRocket
	.section	".rodata"
	.align 2
.LC64:
	.long 0x3f800000
	.align 2
.LC65:
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
	lis 9,.LC64@ha
	lwz 5,sound_missile_prelaunch@l(11)
	la 9,.LC64@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC64@ha
	la 9,.LC64@l(9)
	lfs 2,0(9)
	lis 9,.LC65@ha
	la 9,.LC65@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe20:
	.size	 Chick_PreAttack1,.Lfe20-Chick_PreAttack1
	.section	".rodata"
	.align 2
.LC66:
	.long 0x3f800000
	.align 2
.LC67:
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
	lis 9,.LC66@ha
	lwz 5,sound_missile_reload@l(11)
	la 9,.LC66@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC66@ha
	la 9,.LC66@l(9)
	lfs 2,0(9)
	lis 9,.LC67@ha
	la 9,.LC67@l(9)
	lfs 3,0(9)
	blrl
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe21:
	.size	 ChickReload,.Lfe21-ChickReload
	.align 2
	.globl chick_slash
	.type	 chick_slash,@function
chick_slash:
	lis 9,chick_move_slash@ha
	la 9,chick_move_slash@l(9)
	stw 9,868(3)
	blr
.Lfe22:
	.size	 chick_slash,.Lfe22-chick_slash
	.align 2
	.globl chick_melee
	.type	 chick_melee,@function
chick_melee:
	lis 9,chick_move_start_slash@ha
	la 9,chick_move_start_slash@l(9)
	stw 9,868(3)
	blr
.Lfe23:
	.size	 chick_melee,.Lfe23-chick_melee
	.align 2
	.globl chick_attack
	.type	 chick_attack,@function
chick_attack:
	lis 9,chick_move_start_attack1@ha
	la 9,chick_move_start_attack1@l(9)
	stw 9,868(3)
	blr
.Lfe24:
	.size	 chick_attack,.Lfe24-chick_attack
	.align 2
	.globl chick_sight
	.type	 chick_sight,@function
chick_sight:
	blr
.Lfe25:
	.size	 chick_sight,.Lfe25-chick_sight
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
