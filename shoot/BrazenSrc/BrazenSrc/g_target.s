	.file	"g_target.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"target_speaker with no noise set at %s\n"
	.align 2
.LC1:
	.string	".wav"
	.align 2
.LC2:
	.string	"%s.wav"
	.align 2
.LC3:
	.long 0x0
	.align 2
.LC4:
	.long 0xbf800000
	.section	".text"
	.align 2
	.globl SP_target_speaker
	.type	 SP_target_speaker,@function
SP_target_speaker:
	stwu 1,-96(1)
	mflr 0
	stmw 29,84(1)
	stw 0,100(1)
	lis 9,st@ha
	mr 31,3
	la 29,st@l(9)
	lwz 3,36(29)
	cmpwi 0,3,0
	bc 4,2,.L20
	lis 29,gi@ha
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC0@ha
	la 3,.LC0@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L19
.L20:
	lis 4,.LC1@ha
	la 4,.LC1@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 4,2,.L21
	lis 5,.LC2@ha
	lwz 6,36(29)
	addi 3,1,8
	la 5,.LC2@l(5)
	li 4,64
	crxor 6,6,6
	bl Com_sprintf
	b .L22
.L21:
	lwz 4,36(29)
	addi 3,1,8
	li 5,64
	bl strncpy
.L22:
	lis 9,gi+36@ha
	addi 3,1,8
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
	lis 9,.LC3@ha
	lfs 0,584(31)
	la 9,.LC3@l(9)
	stw 3,576(31)
	lfs 12,0(9)
	fcmpu 0,0,12
	bc 4,2,.L23
	lis 0,0x3f80
	stw 0,584(31)
.L23:
	lfs 13,588(31)
	fcmpu 0,13,12
	bc 4,2,.L24
	lis 0,0x3f80
	stw 0,588(31)
	b .L25
.L24:
	lis 9,.LC4@ha
	la 9,.LC4@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L25
	stfs 12,588(31)
.L25:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L27
	lwz 0,576(31)
	stw 0,76(31)
.L27:
	lis 9,Use_Target_Speaker@ha
	lis 11,gi+72@ha
	la 9,Use_Target_Speaker@l(9)
	mr 3,31
	stw 9,448(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
.L19:
	lwz 0,100(1)
	mtlr 0
	lmw 29,84(1)
	la 1,96(1)
	blr
.Lfe1:
	.size	 SP_target_speaker,.Lfe1-SP_target_speaker
	.section	".rodata"
	.align 2
.LC5:
	.string	"%s with no message at %s\n"
	.align 2
.LC6:
	.string	"misc/secret.wav"
	.align 2
.LC7:
	.string	"mine3"
	.align 2
.LC8:
	.string	"You have found a secret area."
	.align 2
.LC9:
	.string	"0"
	.align 2
.LC10:
	.string	"*"
	.align 2
.LC11:
	.string	"%s exited the level.\n"
	.align 2
.LC12:
	.long 0x0
	.align 2
.LC13:
	.long 0xc2200000
	.align 2
.LC14:
	.long 0x44000000
	.section	".text"
	.align 2
	.globl use_target_changelevel
	.type	 use_target_changelevel,@function
use_target_changelevel:
	stwu 1,-96(1)
	mflr 0
	stfd 31,88(1)
	stmw 25,60(1)
	stw 0,100(1)
	lis 11,.LC12@ha
	lis 9,level+200@ha
	la 11,.LC12@l(11)
	lfs 0,level+200@l(9)
	mr 28,3
	lfs 13,0(11)
	mr 27,4
	mr 31,5
	fcmpu 0,0,13
	bc 4,2,.L49
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L51
	lwz 0,552(31)
	li 30,0
	cmpwi 0,0,0
	bc 4,2,.L52
	lwz 9,84(31)
	lis 11,.LC13@ha
	la 11,.LC13@l(11)
	lfs 13,0(11)
	lfs 0,4768(9)
	fcmpu 0,0,13
	bc 4,0,.L52
	lfs 0,384(31)
	fcmpu 0,0,13
	bc 4,0,.L52
	li 30,1
.L52:
	lwz 3,504(28)
	lis 4,.LC10@ha
	la 4,.LC10@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 4,2,.L54
	cmpwi 0,30,0
	bc 12,2,.L53
.L54:
	lwz 0,184(31)
	li 9,0
	li 11,1
	lwz 10,84(31)
	lis 8,gi+72@ha
	mr 3,31
	ori 0,0,1
	stw 9,248(31)
	li 30,1
	stw 11,260(31)
	stw 0,184(31)
	stw 9,88(10)
	stw 9,492(31)
	lwz 0,gi+72@l(8)
	mtlr 0
	blrl
	lis 9,game+1544@ha
	lwz 0,game+1544@l(9)
	cmpw 0,30,0
	bc 12,1,.L53
	lis 11,g_edicts@ha
	mr 8,0
	lwz 9,g_edicts@l(11)
	addi 9,9,1084
.L58:
	mr 10,9
	lwz 0,88(10)
	cmpwi 0,0,0
	bc 12,2,.L57
	lwz 11,84(10)
	cmpwi 0,11,0
	bc 12,2,.L57
	lwz 0,1812(11)
	cmpwi 0,0,0
	bc 4,2,.L57
	lwz 0,492(10)
	cmpwi 0,0,0
	bc 4,2,.L80
.L57:
	addi 30,30,1
	addi 9,9,1084
	cmpw 0,30,8
	bc 4,1,.L58
.L53:
	lis 9,game@ha
	li 30,1
	la 9,game@l(9)
	lwz 0,1544(9)
	cmpw 0,30,0
	bc 12,1,.L51
	mr 25,9
	lis 26,g_edicts@ha
	lis 9,.LC14@ha
	li 29,1084
	la 9,.LC14@l(9)
	lfs 31,0(9)
.L67:
	lwz 0,g_edicts@l(26)
	add 10,0,29
	lwz 9,88(10)
	cmpwi 0,9,0
	bc 12,2,.L66
	lwz 9,84(10)
	cmpwi 0,9,0
	bc 12,2,.L66
	lwz 0,1812(9)
	cmpwi 0,0,0
	bc 4,2,.L66
	lwz 0,260(10)
	cmpwi 0,0,1
	bc 12,2,.L66
	lfs 0,4(10)
	addi 3,1,16
	lfs 13,4(31)
	lfs 12,8(31)
	lfs 11,12(31)
	fsubs 13,13,0
	stfs 13,16(1)
	lfs 0,8(10)
	fsubs 12,12,0
	stfs 12,20(1)
	lfs 0,12(10)
	fsubs 11,11,0
	stfs 11,24(1)
	bl VectorLength
	fcmpu 0,1,31
	bc 12,1,.L49
.L66:
	lwz 0,1544(25)
	addi 30,30,1
	addi 29,29,1084
	cmpw 0,30,0
	bc 4,1,.L67
.L51:
	lis 11,.LC12@ha
	lis 9,deathmatch@ha
	la 11,.LC12@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L74
	lis 9,coop@ha
	lwz 11,coop@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L74
	lis 9,g_edicts@ha
	lwz 11,g_edicts@l(9)
	lwz 0,1564(11)
	cmpwi 0,0,0
	bc 4,1,.L49
.L74:
	lis 9,.LC12@ha
	lis 11,deathmatch@ha
	la 9,.LC12@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L76
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,48(1)
	lwz 11,52(1)
	andi. 11,11,4096
	bc 4,2,.L76
	lis 9,g_edicts@ha
	lwz 0,g_edicts@l(9)
	cmpw 0,27,0
	bc 12,2,.L76
	lwz 9,484(27)
	lis 6,vec3_origin@ha
	mr 3,27
	mr 4,28
	la 6,vec3_origin@l(6)
	stw 11,8(1)
	li 0,28
	mulli 9,9,10
	mr 5,4
	stw 0,12(1)
	addi 7,3,4
	mr 8,6
	li 10,1000
	bl T_Damage
	b .L49
.L80:
	bl CheckCoopAllDead
	b .L49
.L76:
	lis 9,.LC12@ha
	lis 11,deathmatch@ha
	la 9,.LC12@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L77
	cmpwi 0,31,0
	bc 12,2,.L77
	lwz 3,84(31)
	cmpwi 0,3,0
	bc 12,2,.L77
	lis 9,gi@ha
	lis 4,.LC11@ha
	lwz 0,gi@l(9)
	addi 5,3,700
	la 4,.LC11@l(4)
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L77:
	lwz 3,504(28)
	lis 4,.LC10@ha
	la 4,.LC10@l(4)
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L79
	lis 9,game@ha
	la 9,game@l(9)
	lwz 0,1552(9)
	rlwinm 0,0,0,0,23
	stw 0,1552(9)
.L79:
	mr 3,28
	bl BeginIntermission
.L49:
	lwz 0,100(1)
	mtlr 0
	lmw 25,60(1)
	lfd 31,88(1)
	la 1,96(1)
	blr
.Lfe2:
	.size	 use_target_changelevel,.Lfe2-use_target_changelevel
	.section	".rodata"
	.align 2
.LC15:
	.string	"target_changelevel with no map at %s\n"
	.align 2
.LC16:
	.string	"fact1"
	.align 2
.LC17:
	.string	"fact3"
	.align 2
.LC18:
	.string	"fact3$secret1"
	.align 2
.LC19:
	.string	"weapons/laser2.wav"
	.align 3
.LC20:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC21:
	.long 0x3f000000
	.align 2
.LC22:
	.long 0x45000000
	.section	".text"
	.align 2
	.globl target_laser_think
	.type	 target_laser_think,@function
target_laser_think:
	stwu 1,-176(1)
	mflr 0
	stmw 24,144(1)
	stw 0,180(1)
	mr 31,3
	lwz 9,284(31)
	lwz 3,540(31)
	cmpwi 7,9,0
	cmpwi 0,3,0
	cror 31,30,29
	mfcr 0
	rlwinm 0,0,0,1
	neg 0,0
	nor 9,0,0
	rlwinm 0,0,0,29,29
	rlwinm 9,9,0,28,28
	or 24,0,9
	bc 12,2,.L109
	lis 9,.LC21@ha
	lfs 12,340(31)
	addi 4,3,236
	lfs 13,344(31)
	la 9,.LC21@l(9)
	addi 5,1,112
	lfs 0,348(31)
	addi 3,3,212
	addi 29,31,340
	lfs 1,0(9)
	stfs 12,128(1)
	stfs 13,132(1)
	stfs 0,136(1)
	bl VectorMA
	lfs 12,112(1)
	mr 3,29
	lfs 11,4(31)
	lfs 13,116(1)
	lfs 0,120(1)
	fsubs 12,12,11
	lfs 10,8(31)
	lfs 11,12(31)
	fsubs 13,13,10
	stfs 12,340(31)
	fsubs 0,0,11
	stfs 13,344(31)
	stfs 0,348(31)
	bl VectorNormalize
	mr 3,29
	addi 4,1,128
	bl VectorCompare
	cmpwi 0,3,0
	bc 4,2,.L109
	lwz 0,284(31)
	oris 0,0,0x8000
	stw 0,284(31)
.L109:
	lis 9,.LC22@ha
	lfs 13,4(31)
	addi 4,31,340
	lfs 12,8(31)
	la 9,.LC22@l(9)
	addi 5,1,32
	lfs 0,12(31)
	mr 25,4
	mr 26,5
	lfs 1,0(9)
	addi 3,1,16
	mr 29,31
	stfs 13,16(1)
	stfs 12,20(1)
	stfs 0,24(1)
	bl VectorMA
	lwz 0,1016(31)
	cmpwi 0,0,0
	bc 12,2,.L111
	lwz 9,540(31)
	cmpwi 0,9,0
	bc 12,2,.L111
	lfs 0,4(9)
	stfs 0,32(1)
	lfs 13,8(9)
	stfs 13,36(1)
	lfs 0,12(9)
	stfs 0,40(1)
.L111:
	lis 9,gi@ha
	addi 28,1,48
	la 30,gi@l(9)
	addi 27,1,60
.L114:
	lwz 0,284(31)
	andi. 9,0,128
	bc 12,2,.L115
	lwz 11,48(30)
	lis 9,0x600
	mr 8,29
	mr 3,28
	addi 4,1,16
	li 5,0
	li 6,0
	mtlr 11
	mr 7,26
	ori 9,9,3
	blrl
	b .L116
.L115:
	lwz 11,48(30)
	lis 9,0x600
	mr 8,29
	mr 3,28
	addi 4,1,16
	li 5,0
	li 6,0
	mtlr 11
	mr 7,26
	ori 9,9,1
	blrl
.L116:
	lwz 3,100(1)
	cmpwi 0,3,0
	bc 12,2,.L113
	lwz 0,512(3)
	cmpwi 0,0,0
	bc 12,2,.L118
	lwz 0,264(3)
	andi. 9,0,4
	bc 4,2,.L118
	lwz 5,548(31)
	li 0,4
	li 11,30
	lwz 9,516(31)
	lis 8,vec3_origin@ha
	mr 4,31
	stw 0,8(1)
	la 8,vec3_origin@l(8)
	mr 6,25
	stw 11,12(1)
	addi 7,1,60
	li 10,1
	bl T_Damage
.L118:
	lwz 9,100(1)
	lwz 11,184(9)
	andi. 0,11,4
	bc 4,2,.L119
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 4,2,.L119
	andi. 9,11,8
	bc 4,2,.L119
	lwz 0,284(31)
	cmpwi 0,0,0
	bc 4,0,.L113
	rlwinm 0,0,0,1,31
	li 3,3
	stw 0,284(31)
	lwz 9,100(30)
	mtlr 9
	blrl
	lwz 9,100(30)
	li 3,15
	mtlr 9
	blrl
	lwz 9,100(30)
	mr 3,24
	mtlr 9
	blrl
	lwz 9,120(30)
	mr 3,27
	mtlr 9
	blrl
	lwz 9,124(30)
	addi 3,1,72
	mtlr 9
	blrl
	lwz 9,100(30)
	lwz 3,60(31)
	mtlr 9
	blrl
	lwz 0,88(30)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	b .L113
.L119:
	lfs 0,60(1)
	lfs 13,64(1)
	lfs 12,68(1)
	stfs 0,16(1)
	stfs 13,20(1)
	stfs 12,24(1)
	lwz 29,100(1)
	b .L114
.L113:
	lfs 0,64(1)
	lis 9,level+4@ha
	lis 11,.LC20@ha
	lfs 13,68(1)
	lfs 12,60(1)
	stfs 0,32(31)
	stfs 13,36(31)
	stfs 12,28(31)
	lfs 0,level+4@l(9)
	lfd 13,.LC20@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(31)
	lwz 0,180(1)
	mtlr 0
	lmw 24,144(1)
	la 1,176(1)
	blr
.Lfe3:
	.size	 target_laser_think,.Lfe3-target_laser_think
	.section	".rodata"
	.align 2
.LC23:
	.string	"%s at %s: %s is a bad target\n"
	.section	".text"
	.align 2
	.globl target_laser_start
	.type	 target_laser_start,@function
target_laser_start:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	li 10,0
	lwz 9,284(31)
	li 11,1
	lwz 0,68(31)
	andi. 8,9,64
	stw 10,248(31)
	ori 0,0,160
	stw 11,40(31)
	stw 0,68(31)
	stw 10,260(31)
	li 0,4
	bc 12,2,.L132
	li 0,16
.L132:
	stw 0,56(31)
	lwz 0,284(31)
	andi. 9,0,2
	bc 12,2,.L134
	lis 0,0xf2f2
	ori 0,0,61680
	b .L154
.L134:
	andi. 8,0,4
	bc 12,2,.L136
	lis 0,0xd0d1
	ori 0,0,53971
	b .L154
.L136:
	andi. 9,0,8
	bc 12,2,.L138
	lis 0,0xf3f3
	ori 0,0,61937
	b .L154
.L138:
	andi. 8,0,16
	bc 12,2,.L140
	lis 0,0xdcdd
	ori 0,0,57055
	b .L154
.L140:
	andi. 9,0,32
	bc 12,2,.L135
	lis 0,0xe0e1
	ori 0,0,58083
.L154:
	stw 0,60(31)
.L135:
	lwz 0,540(31)
	lis 29,gi@ha
	cmpwi 0,0,0
	bc 4,2,.L143
	lwz 5,296(31)
	cmpwi 0,5,0
	bc 12,2,.L144
	li 3,0
	li 4,300
	bl G_Find
	mr. 30,3
	bc 4,2,.L145
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC23@ha
	lwz 6,296(31)
	la 3,.LC23@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L145:
	stw 30,540(31)
	b .L143
.L144:
	addi 3,31,16
	addi 4,31,340
	bl G_SetMovedir
.L143:
	lwz 0,516(31)
	lis 9,target_laser_use@ha
	lis 11,target_laser_think@ha
	la 9,target_laser_use@l(9)
	la 11,target_laser_think@l(11)
	cmpwi 0,0,0
	stw 9,448(31)
	stw 11,436(31)
	bc 4,2,.L147
	li 0,1
	stw 0,516(31)
.L147:
	lis 0,0xc100
	lis 9,0x4100
	lis 11,gi+72@ha
	stw 0,196(31)
	mr 3,31
	stw 9,208(31)
	stw 0,188(31)
	stw 0,192(31)
	stw 9,200(31)
	stw 9,204(31)
	lwz 0,gi+72@l(11)
	mtlr 0
	blrl
	lwz 11,284(31)
	andi. 0,11,1
	bc 12,2,.L148
	lwz 0,548(31)
	cmpwi 0,0,0
	bc 4,2,.L149
	stw 31,548(31)
.L149:
	lwz 0,284(31)
	mr 3,31
	lwz 9,184(31)
	oris 0,0,0x8000
	ori 0,0,1
	rlwinm 9,9,0,0,30
	stw 0,284(31)
	stw 9,184(31)
	bl target_laser_think
	b .L151
.L148:
	lwz 0,184(31)
	rlwinm 11,11,0,0,30
	li 9,0
	stw 9,428(31)
	ori 0,0,1
	stw 11,284(31)
	stw 0,184(31)
.L151:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 target_laser_start,.Lfe4-target_laser_start
	.section	".rodata"
	.align 3
.LC24:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC25:
	.long 0x42c20000
	.align 3
.LC26:
	.long 0x43300000
	.long 0x0
	.section	".text"
	.align 2
	.globl target_lightramp_think
	.type	 target_lightramp_think,@function
target_lightramp_think:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 29,44(1)
	stw 0,68(1)
	lis 29,level@ha
	mr 31,3
	la 29,level@l(29)
	lfs 12,288(31)
	lis 11,.LC24@ha
	lfs 0,4(29)
	lis 9,.LC25@ha
	lis 10,gi+24@ha
	lfd 31,.LC24@l(11)
	la 9,.LC25@l(9)
	addi 4,1,8
	lfs 10,0(9)
	fsubs 0,0,12
	lfs 13,340(31)
	lfs 12,348(31)
	lwz 11,540(31)
	lwz 0,gi+24@l(10)
	fadds 13,13,10
	mtlr 0
	fdiv 0,0,31
	fmadd 0,0,12,13
	fctiwz 11,0
	stfd 11,32(1)
	lwz 9,36(1)
	slwi 9,9,8
	sth 9,8(1)
	lwz 3,644(11)
	addi 3,3,800
	blrl
	lfs 12,4(29)
	lfs 0,288(31)
	lfs 13,328(31)
	fsubs 0,12,0
	fcmpu 0,0,13
	bc 4,0,.L157
	fmr 0,12
	fadd 0,0,31
	frsp 0,0
	stfs 0,428(31)
	b .L158
.L157:
	lwz 0,284(31)
	andi. 9,0,1
	bc 12,2,.L158
	lfs 0,340(31)
	lis 0,0x4330
	mr 11,9
	lis 10,.LC26@ha
	lfs 13,348(31)
	la 10,.LC26@l(10)
	lfs 11,344(31)
	lfd 10,0(10)
	fneg 13,13
	stfs 11,340(31)
	fctiwz 12,0
	stfs 13,348(31)
	stfd 12,32(1)
	lwz 9,36(1)
	rlwinm 9,9,0,0xff
	stw 9,36(1)
	stw 0,32(1)
	lfd 0,32(1)
	fsub 0,0,10
	frsp 0,0
	stfs 0,344(31)
.L158:
	lwz 0,68(1)
	mtlr 0
	lmw 29,44(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe5:
	.size	 target_lightramp_think,.Lfe5-target_lightramp_think
	.section	".rodata"
	.align 2
.LC27:
	.string	"light"
	.align 2
.LC28:
	.string	"%s at %s "
	.align 2
.LC29:
	.string	"target %s (%s at %s) is not a light\n"
	.align 2
.LC30:
	.string	"%s target %s not found at %s\n"
	.align 2
.LC31:
	.string	"target_lightramp has bad ramp (%s) at %s\n"
	.align 2
.LC32:
	.string	"%s with no target at %s\n"
	.align 3
.LC33:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC34:
	.long 0x0
	.align 3
.LC35:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl SP_target_lightramp
	.type	 SP_target_lightramp,@function
SP_target_lightramp:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 3,276(31)
	cmpwi 0,3,0
	bc 12,2,.L172
	bl strlen
	cmpwi 0,3,2
	bc 4,2,.L172
	lwz 7,276(31)
	lbz 9,0(7)
	cmplwi 0,9,96
	bc 4,1,.L172
	cmplwi 0,9,122
	bc 12,1,.L172
	lbz 0,1(7)
	cmplwi 0,0,96
	bc 4,1,.L172
	cmplwi 0,0,122
	bc 12,1,.L172
	cmpw 0,9,0
	bc 4,2,.L171
.L172:
	lis 29,gi@ha
	lwz 28,276(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC31@ha
	la 3,.LC31@l(3)
	b .L175
.L171:
	lis 9,.LC34@ha
	lis 11,deathmatch@ha
	la 9,.LC34@l(9)
	lfs 13,0(9)
	lwz 9,deathmatch@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 4,2,.L176
	lwz 0,296(31)
	cmpwi 0,0,0
	bc 4,2,.L174
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC32@ha
	la 3,.LC32@l(3)
.L175:
	mtlr 0
	crxor 6,6,6
	blrl
.L176:
	mr 3,31
	bl G_FreeEdict
	b .L170
.L174:
	lis 9,target_lightramp_use@ha
	lwz 0,184(31)
	lis 11,target_lightramp_think@ha
	la 9,target_lightramp_use@l(9)
	la 11,target_lightramp_think@l(11)
	lfs 11,328(31)
	stw 9,448(31)
	ori 0,0,1
	lis 8,.LC33@ha
	lis 9,.LC35@ha
	stw 0,184(31)
	la 9,.LC35@l(9)
	stw 11,436(31)
	lis 0,0x4330
	lfd 10,0(9)
	mr 11,10
	lbz 9,0(7)
	lfd 0,.LC33@l(8)
	addi 9,9,-97
	xoris 9,9,0x8000
	stw 9,12(1)
	fdiv 11,11,0
	stw 0,8(1)
	lfd 12,8(1)
	fsub 12,12,10
	frsp 12,12
	stfs 12,340(31)
	lbz 9,1(7)
	addi 9,9,-97
	xoris 9,9,0x8000
	stw 9,12(1)
	stw 0,8(1)
	lfd 13,8(1)
	fsub 13,13,10
	frsp 13,13
	fsubs 12,13,12
	stfs 13,344(31)
	fmr 0,12
	fdiv 0,0,11
	frsp 0,0
	stfs 0,348(31)
.L170:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe6:
	.size	 SP_target_lightramp,.Lfe6-SP_target_lightramp
	.section	".rodata"
	.align 2
.LC36:
	.long 0x46fffe00
	.align 3
.LC37:
	.long 0x4062c000
	.long 0x0
	.align 3
.LC38:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC39:
	.long 0x3f800000
	.align 2
.LC40:
	.long 0x0
	.align 3
.LC41:
	.long 0x3fe00000
	.long 0x0
	.align 3
.LC42:
	.long 0x43300000
	.long 0x80000000
	.align 3
.LC43:
	.long 0x40590000
	.long 0x0
	.section	".text"
	.align 2
	.globl target_earthquake_think
	.type	 target_earthquake_think,@function
target_earthquake_think:
	stwu 1,-80(1)
	mflr 0
	stfd 27,40(1)
	stfd 28,48(1)
	stfd 29,56(1)
	stfd 30,64(1)
	stfd 31,72(1)
	stmw 26,16(1)
	stw 0,84(1)
	mr 30,3
	lwz 0,284(30)
	andi. 9,0,1
	bc 4,2,.L178
	lis 9,level@ha
	lfs 13,476(30)
	la 31,level@l(9)
	lfs 0,4(31)
	fcmpu 0,13,0
	bc 4,0,.L178
	lis 9,gi+20@ha
	addi 3,30,4
	lwz 6,576(30)
	lwz 0,gi+20@l(9)
	mr 4,30
	li 5,0
	lis 9,.LC39@ha
	la 9,.LC39@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfs 2,0(9)
	lis 9,.LC40@ha
	la 9,.LC40@l(9)
	lfs 3,0(9)
	blrl
	lfs 0,4(31)
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfd 13,0(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,476(30)
.L178:
	lis 9,globals@ha
	li 29,1
	la 10,globals@l(9)
	lis 11,g_edicts@ha
	lwz 0,72(10)
	lwz 9,g_edicts@l(11)
	cmpw 0,29,0
	addi 31,9,1084
	bc 4,0,.L181
	lis 9,.LC36@ha
	lis 11,.LC37@ha
	lfs 28,.LC36@l(9)
	mr 26,10
	li 27,0
	lis 9,.LC42@ha
	lfd 29,.LC37@l(11)
	lis 28,0x4330
	la 9,.LC42@l(9)
	lfd 31,0(9)
	lis 9,.LC41@ha
	la 9,.LC41@l(9)
	lfd 30,0(9)
	lis 9,.LC43@ha
	la 9,.LC43@l(9)
	lfd 27,0(9)
.L183:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L182
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L182
	lwz 0,552(31)
	cmpwi 0,0,0
	bc 12,2,.L182
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
.L182:
	lwz 0,72(26)
	addi 29,29,1
	addi 31,31,1084
	cmpw 0,29,0
	bc 12,0,.L183
.L181:
	lis 9,level+4@ha
	lfs 0,288(30)
	lfs 13,level+4@l(9)
	fcmpu 0,13,0
	bc 4,0,.L188
	fmr 0,13
	lis 9,.LC38@ha
	lfd 13,.LC38@l(9)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(30)
.L188:
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
.Lfe7:
	.size	 target_earthquake_think,.Lfe7-target_earthquake_think
	.section	".rodata"
	.align 2
.LC45:
	.string	"untargeted %s at %s\n"
	.align 2
.LC46:
	.string	"world/quake.wav"
	.section	".text"
	.align 2
	.globl Use_Target_Tent
	.type	 Use_Target_Tent,@function
Use_Target_Tent:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 28,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	addi 27,28,4
	mtlr 9
	blrl
	lwz 9,100(29)
	lwz 3,644(28)
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,2
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 Use_Target_Tent,.Lfe8-Use_Target_Tent
	.align 2
	.globl SP_target_temp_entity
	.type	 SP_target_temp_entity,@function
SP_target_temp_entity:
	lis 9,Use_Target_Tent@ha
	la 9,Use_Target_Tent@l(9)
	stw 9,448(3)
	blr
.Lfe9:
	.size	 SP_target_temp_entity,.Lfe9-SP_target_temp_entity
	.section	".rodata"
	.align 2
.LC47:
	.long 0x0
	.section	".text"
	.align 2
	.globl Use_Target_Speaker
	.type	 Use_Target_Speaker,@function
Use_Target_Speaker:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 5,284(3)
	andi. 9,5,2
	bc 12,2,.L9
	lwz 0,76(3)
	cmpwi 0,0,0
	bc 12,2,.L14
	li 0,0
	stw 0,76(3)
	b .L12
.L9:
	andi. 0,5,3
	bc 12,2,.L13
	lwz 0,76(3)
	cmpwi 0,0,0
	bc 12,2,.L14
	stw 9,76(3)
	b .L12
.L14:
	lwz 0,576(3)
	stw 0,76(3)
	b .L12
.L13:
	lis 9,gi+20@ha
	rlwinm 5,5,0,29,29
	lwz 0,gi+20@l(9)
	neg 5,5
	mr 4,3
	srawi 5,5,31
	lis 9,.LC47@ha
	lwz 6,576(4)
	andi. 5,5,18
	la 9,.LC47@l(9)
	lfs 1,584(4)
	mtlr 0
	addi 3,3,4
	lfs 3,0(9)
	ori 5,5,2
	lfs 2,588(4)
	blrl
.L12:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe10:
	.size	 Use_Target_Speaker,.Lfe10-Use_Target_Speaker
	.align 2
	.globl Use_Target_Help
	.type	 Use_Target_Help,@function
Use_Target_Help:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,284(3)
	andi. 9,0,1
	bc 12,2,.L29
	lwz 4,276(3)
	li 5,511
	lis 3,game@ha
	la 3,game@l(3)
	bl strncpy
	b .L30
.L29:
	lwz 4,276(3)
	li 5,511
	lis 3,game+512@ha
	la 3,game+512@l(3)
	bl strncpy
.L30:
	lis 11,game@ha
	la 11,game@l(11)
	lwz 9,1024(11)
	addi 9,9,1
	stw 9,1024(11)
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe11:
	.size	 Use_Target_Help,.Lfe11-Use_Target_Help
	.section	".rodata"
	.align 2
.LC48:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_help
	.type	 SP_target_help,@function
SP_target_help:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,.LC48@ha
	lis 9,deathmatch@ha
	la 11,.LC48@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L32
	bl G_FreeEdict
	b .L31
.L32:
	lwz 0,276(31)
	cmpwi 0,0,0
	bc 4,2,.L33
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC5@ha
	la 3,.LC5@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L31
.L33:
	lis 9,Use_Target_Help@ha
	la 9,Use_Target_Help@l(9)
	stw 9,448(31)
.L31:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 SP_target_help,.Lfe12-SP_target_help
	.section	".rodata"
	.align 2
.LC49:
	.long 0x3f800000
	.align 2
.LC50:
	.long 0x0
	.section	".text"
	.align 2
	.globl use_target_secret
	.type	 use_target_secret,@function
use_target_secret:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,gi+16@ha
	mr 29,3
	lwz 0,gi+16@l(9)
	mr 28,5
	lis 9,.LC49@ha
	lwz 5,576(29)
	li 4,2
	la 9,.LC49@l(9)
	mtlr 0
	lfs 1,0(9)
	lis 9,.LC49@ha
	la 9,.LC49@l(9)
	lfs 2,0(9)
	lis 9,.LC50@ha
	la 9,.LC50@l(9)
	lfs 3,0(9)
	blrl
	lis 11,level@ha
	mr 3,29
	la 11,level@l(11)
	mr 4,28
	lwz 9,272(11)
	addi 9,9,1
	stw 9,272(11)
	bl G_UseTargets
	mr 3,29
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe13:
	.size	 use_target_secret,.Lfe13-use_target_secret
	.section	".rodata"
	.align 2
.LC51:
	.long 0x0
	.align 2
.LC52:
	.long 0x438c0000
	.align 2
.LC53:
	.long 0xc5000000
	.align 2
.LC54:
	.long 0xc41c0000
	.section	".text"
	.align 2
	.globl SP_target_secret
	.type	 SP_target_secret,@function
SP_target_secret:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC51@ha
	lis 9,deathmatch@ha
	la 11,.LC51@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L36
	bl G_FreeEdict
	b .L35
.L36:
	lis 9,use_target_secret@ha
	lis 11,st@ha
	la 9,use_target_secret@l(9)
	la 11,st@l(11)
	stw 9,448(31)
	lwz 0,36(11)
	cmpwi 0,0,0
	bc 4,2,.L37
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	stw 9,36(11)
.L37:
	lis 9,gi+36@ha
	lwz 3,36(11)
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
	li 0,1
	lis 11,level@ha
	stw 3,576(31)
	la 11,level@l(11)
	stw 0,184(31)
	lis 4,.LC7@ha
	lwz 9,268(11)
	addi 3,11,72
	la 4,.LC7@l(4)
	addi 9,9,1
	stw 9,268(11)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L35
	lis 9,.LC52@ha
	lfs 13,4(31)
	la 9,.LC52@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L35
	lis 11,.LC53@ha
	lfs 13,8(31)
	la 11,.LC53@l(11)
	lfs 0,0(11)
	fcmpu 0,13,0
	bc 4,2,.L35
	lis 9,.LC54@ha
	lfs 13,12(31)
	la 9,.LC54@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L35
	lis 9,.LC8@ha
	la 9,.LC8@l(9)
	stw 9,276(31)
.L35:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 SP_target_secret,.Lfe14-SP_target_secret
	.section	".rodata"
	.align 2
.LC55:
	.long 0x3f800000
	.align 2
.LC56:
	.long 0x0
	.section	".text"
	.align 2
	.globl use_target_goal
	.type	 use_target_goal,@function
use_target_goal:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 31,3
	la 29,gi@l(9)
	mr 30,5
	lis 9,.LC55@ha
	lwz 11,16(29)
	la 9,.LC55@l(9)
	li 4,2
	lwz 5,576(31)
	lfs 1,0(9)
	mtlr 11
	lis 9,.LC55@ha
	la 9,.LC55@l(9)
	lfs 2,0(9)
	lis 9,.LC56@ha
	la 9,.LC56@l(9)
	lfs 3,0(9)
	blrl
	lis 11,level@ha
	la 11,level@l(11)
	lwz 9,280(11)
	lwz 0,276(11)
	addi 9,9,1
	cmpw 0,9,0
	stw 9,280(11)
	bc 4,2,.L40
	lwz 0,24(29)
	lis 4,.LC9@ha
	li 3,1
	la 4,.LC9@l(4)
	mtlr 0
	blrl
.L40:
	mr 3,31
	mr 4,30
	bl G_UseTargets
	mr 3,31
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe15:
	.size	 use_target_goal,.Lfe15-use_target_goal
	.section	".rodata"
	.align 2
.LC57:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_goal
	.type	 SP_target_goal,@function
SP_target_goal:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC57@ha
	lis 9,deathmatch@ha
	la 11,.LC57@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L42
	bl G_FreeEdict
	b .L41
.L42:
	lis 9,use_target_goal@ha
	lis 11,st@ha
	la 9,use_target_goal@l(9)
	la 11,st@l(11)
	stw 9,448(31)
	lwz 0,36(11)
	cmpwi 0,0,0
	bc 4,2,.L43
	lis 9,.LC6@ha
	la 9,.LC6@l(9)
	stw 9,36(11)
.L43:
	lis 9,gi+36@ha
	lwz 3,36(11)
	lwz 0,gi+36@l(9)
	mtlr 0
	blrl
	li 0,1
	lis 11,level@ha
	stw 3,576(31)
	stw 0,184(31)
	la 11,level@l(11)
	lwz 9,276(11)
	addi 9,9,1
	stw 9,276(11)
.L41:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe16:
	.size	 SP_target_goal,.Lfe16-SP_target_goal
	.section	".rodata"
	.align 3
.LC58:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl target_explosion_explode
	.type	 target_explosion_explode,@function
target_explosion_explode:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 27,36(1)
	stw 0,68(1)
	lis 29,gi@ha
	mr 28,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	addi 27,28,4
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,5
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,27
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,27
	li 4,1
	mtlr 0
	blrl
	lwz 11,516(28)
	lis 8,0x4330
	mr 9,10
	lis 7,.LC58@ha
	lwz 4,548(28)
	xoris 0,11,0x8000
	la 7,.LC58@l(7)
	stw 0,28(1)
	addi 11,11,40
	li 5,0
	stw 8,24(1)
	xoris 11,11,0x8000
	li 6,25
	lfd 1,24(1)
	mr 3,28
	stw 11,28(1)
	stw 8,24(1)
	lfd 0,0(7)
	lfd 2,24(1)
	fsub 1,1,0
	fsub 2,2,0
	frsp 1,1
	frsp 2,2
	bl T_RadiusDamage
	lfs 31,596(28)
	li 0,0
	mr 3,28
	lwz 4,548(28)
	stw 0,596(28)
	bl G_UseTargets
	stfs 31,596(28)
	lwz 0,68(1)
	mtlr 0
	lmw 27,36(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe17:
	.size	 target_explosion_explode,.Lfe17-target_explosion_explode
	.section	".rodata"
	.align 2
.LC59:
	.long 0x0
	.align 3
.LC60:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl use_target_explosion
	.type	 use_target_explosion,@function
use_target_explosion:
	stwu 1,-48(1)
	mflr 0
	stfd 30,32(1)
	stfd 31,40(1)
	stmw 28,16(1)
	stw 0,52(1)
	lis 7,.LC59@ha
	mr 31,3
	la 7,.LC59@l(7)
	lfs 13,596(31)
	lfs 30,0(7)
	stw 5,548(31)
	fcmpu 0,13,30
	bc 4,2,.L46
	lis 29,gi@ha
	li 3,3
	la 29,gi@l(29)
	addi 28,31,4
	lwz 9,100(29)
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,5
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,1
	mtlr 0
	blrl
	lwz 11,516(31)
	lis 8,0x4330
	mr 9,10
	lis 7,.LC60@ha
	lwz 4,548(31)
	xoris 0,11,0x8000
	la 7,.LC60@l(7)
	stw 0,12(1)
	addi 11,11,40
	li 5,0
	stw 8,8(1)
	xoris 11,11,0x8000
	li 6,25
	lfd 1,8(1)
	mr 3,31
	stw 11,12(1)
	stw 8,8(1)
	lfd 0,0(7)
	lfd 2,8(1)
	fsub 1,1,0
	fsub 2,2,0
	frsp 1,1
	frsp 2,2
	bl T_RadiusDamage
	lfs 31,596(31)
	mr 3,31
	lwz 4,548(31)
	stfs 30,596(31)
	bl G_UseTargets
	stfs 31,596(31)
	b .L45
.L46:
	lis 9,target_explosion_explode@ha
	lis 11,level+4@ha
	la 9,target_explosion_explode@l(9)
	stw 9,436(31)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	stfs 0,428(31)
.L45:
	lwz 0,52(1)
	mtlr 0
	lmw 28,16(1)
	lfd 30,32(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe18:
	.size	 use_target_explosion,.Lfe18-use_target_explosion
	.align 2
	.globl SP_target_explosion
	.type	 SP_target_explosion,@function
SP_target_explosion:
	lis 9,use_target_explosion@ha
	li 0,1
	la 9,use_target_explosion@l(9)
	stw 0,184(3)
	stw 9,448(3)
	blr
.Lfe19:
	.size	 SP_target_explosion,.Lfe19-SP_target_explosion
	.align 2
	.globl SP_target_changelevel
	.type	 SP_target_changelevel,@function
SP_target_changelevel:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,504(31)
	cmpwi 0,0,0
	bc 4,2,.L82
	lis 29,gi@ha
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 4,3
	lwz 0,4(29)
	lis 3,.LC15@ha
	la 3,.LC15@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L81
.L82:
	lis 3,level+72@ha
	lis 4,.LC16@ha
	la 3,level+72@l(3)
	la 4,.LC16@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L83
	lwz 3,504(31)
	lis 4,.LC17@ha
	la 4,.LC17@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L83
	lis 9,.LC18@ha
	la 9,.LC18@l(9)
	stw 9,504(31)
.L83:
	lis 9,use_target_changelevel@ha
	li 0,1
	la 9,use_target_changelevel@l(9)
	stw 0,184(31)
	stw 9,448(31)
.L81:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 SP_target_changelevel,.Lfe20-SP_target_changelevel
	.section	".rodata"
	.align 3
.LC61:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl use_target_splash
	.type	 use_target_splash,@function
use_target_splash:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 31,3
	la 29,gi@l(29)
	li 3,3
	lwz 9,100(29)
	mr 30,5
	addi 28,31,4
	mtlr 9
	blrl
	lwz 9,100(29)
	li 3,10
	mtlr 9
	blrl
	lwz 9,100(29)
	lwz 3,532(31)
	mtlr 9
	blrl
	lwz 9,120(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 9,124(29)
	addi 3,31,340
	mtlr 9
	blrl
	lwz 9,100(29)
	lwz 3,528(31)
	mtlr 9
	blrl
	lwz 0,88(29)
	mr 3,28
	li 4,2
	mtlr 0
	blrl
	lwz 11,516(31)
	cmpwi 0,11,0
	bc 12,2,.L85
	xoris 0,11,0x8000
	stw 0,12(1)
	lis 10,0x4330
	mr 3,31
	stw 10,8(1)
	addi 0,11,40
	mr 4,30
	mr 11,9
	lfd 1,8(1)
	xoris 0,0,0x8000
	lis 9,.LC61@ha
	stw 0,12(1)
	li 5,0
	la 9,.LC61@l(9)
	stw 10,8(1)
	li 6,29
	lfd 0,0(9)
	lfd 2,8(1)
	fsub 1,1,0
	fsub 2,2,0
	frsp 1,1
	frsp 2,2
	bl T_RadiusDamage
.L85:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 use_target_splash,.Lfe21-use_target_splash
	.align 2
	.globl SP_target_splash
	.type	 SP_target_splash,@function
SP_target_splash:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,use_target_splash@ha
	mr 31,3
	la 9,use_target_splash@l(9)
	addi 3,31,16
	stw 9,448(31)
	addi 4,31,340
	bl G_SetMovedir
	lwz 0,532(31)
	cmpwi 0,0,0
	bc 4,2,.L87
	li 0,32
	stw 0,532(31)
.L87:
	li 0,1
	stw 0,184(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe22:
	.size	 SP_target_splash,.Lfe22-SP_target_splash
	.section	".rodata"
	.align 2
.LC62:
	.long 0x0
	.section	".text"
	.align 2
	.globl use_target_spawner
	.type	 use_target_spawner,@function
use_target_spawner:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,3
	bl G_Spawn
	lwz 0,296(30)
	mr 31,3
	stw 0,280(31)
	lfs 0,4(30)
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
	bl ED_CallSpawn
	lis 29,gi@ha
	mr 3,31
	la 29,gi@l(29)
	lwz 9,76(29)
	mtlr 9
	blrl
	mr 3,31
	bl KillBox
	lwz 0,72(29)
	mr 3,31
	mtlr 0
	blrl
	lis 9,.LC62@ha
	lfs 13,328(30)
	la 9,.LC62@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 12,2,.L89
	lfs 0,340(30)
	stfs 0,376(31)
	lfs 13,344(30)
	stfs 13,380(31)
	lfs 0,348(30)
	stfs 0,384(31)
.L89:
	lwz 0,68(31)
	ori 0,0,32768
	stw 0,68(31)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 use_target_spawner,.Lfe23-use_target_spawner
	.section	".rodata"
	.align 2
.LC63:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_spawner
	.type	 SP_target_spawner,@function
SP_target_spawner:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,.LC63@ha
	mr 31,3
	la 9,.LC63@l(9)
	lfs 0,328(31)
	li 0,1
	lfs 13,0(9)
	lis 9,use_target_spawner@ha
	stw 0,184(31)
	la 9,use_target_spawner@l(9)
	fcmpu 0,0,13
	stw 9,448(31)
	bc 12,2,.L91
	addi 29,31,340
	addi 3,31,16
	mr 4,29
	bl G_SetMovedir
	lfs 1,328(31)
	mr 3,29
	mr 4,3
	bl VectorScale
.L91:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe24:
	.size	 SP_target_spawner,.Lfe24-SP_target_spawner
	.section	".rodata"
	.align 2
.LC64:
	.long 0x3f800000
	.align 2
.LC65:
	.long 0x0
	.section	".text"
	.align 2
	.globl use_target_blaster
	.type	 use_target_blaster,@function
use_target_blaster:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 29,3
	lfs 0,328(29)
	addi 4,29,4
	lwz 6,516(29)
	addi 5,29,340
	li 9,33
	li 8,8
	fctiwz 13,0
	stfd 13,24(1)
	lwz 7,28(1)
	bl fire_blaster
	lis 9,gi+16@ha
	mr 3,29
	lwz 0,gi+16@l(9)
	li 4,2
	lis 9,.LC64@ha
	lwz 5,576(3)
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
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe25:
	.size	 use_target_blaster,.Lfe25-use_target_blaster
	.section	".rodata"
	.align 2
.LC66:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_blaster
	.type	 SP_target_blaster,@function
SP_target_blaster:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,use_target_blaster@ha
	mr 31,3
	la 9,use_target_blaster@l(9)
	addi 3,31,16
	addi 4,31,340
	stw 9,448(31)
	bl G_SetMovedir
	lis 9,gi+36@ha
	lis 3,.LC19@ha
	lwz 0,gi+36@l(9)
	la 3,.LC19@l(3)
	mtlr 0
	blrl
	lwz 0,516(31)
	stw 3,576(31)
	cmpwi 0,0,0
	bc 4,2,.L98
	li 0,15
	stw 0,516(31)
.L98:
	lis 9,.LC66@ha
	lfs 13,328(31)
	la 9,.LC66@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L99
	lis 0,0x447a
	stw 0,328(31)
.L99:
	li 0,1
	stw 0,184(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe26:
	.size	 SP_target_blaster,.Lfe26-SP_target_blaster
	.align 2
	.globl trigger_crosslevel_trigger_use
	.type	 trigger_crosslevel_trigger_use,@function
trigger_crosslevel_trigger_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 9,game@ha
	lwz 11,284(3)
	la 9,game@l(9)
	lwz 0,1552(9)
	or 0,0,11
	stw 0,1552(9)
	bl G_FreeEdict
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe27:
	.size	 trigger_crosslevel_trigger_use,.Lfe27-trigger_crosslevel_trigger_use
	.align 2
	.globl SP_target_crosslevel_trigger
	.type	 SP_target_crosslevel_trigger,@function
SP_target_crosslevel_trigger:
	lis 9,trigger_crosslevel_trigger_use@ha
	li 0,1
	la 9,trigger_crosslevel_trigger_use@l(9)
	stw 0,184(3)
	stw 9,448(3)
	blr
.Lfe28:
	.size	 SP_target_crosslevel_trigger,.Lfe28-SP_target_crosslevel_trigger
	.align 2
	.globl target_crosslevel_target_think
	.type	 target_crosslevel_target_think,@function
target_crosslevel_target_think:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 11,game+1552@ha
	lwz 10,284(31)
	lwz 0,game+1552@l(11)
	rlwinm 9,10,0,24,31
	and 0,0,9
	cmpw 0,10,0
	bc 4,2,.L103
	mr 4,31
	bl G_UseTargets
	mr 3,31
	bl G_FreeEdict
.L103:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe29:
	.size	 target_crosslevel_target_think,.Lfe29-target_crosslevel_target_think
	.section	".rodata"
	.align 2
.LC67:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_crosslevel_target
	.type	 SP_target_crosslevel_target,@function
SP_target_crosslevel_target:
	lis 9,.LC67@ha
	lfs 0,596(3)
	la 9,.LC67@l(9)
	lfs 13,0(9)
	fcmpu 0,0,13
	bc 4,2,.L105
	lis 0,0x3f80
	stw 0,596(3)
.L105:
	lis 9,target_crosslevel_target_think@ha
	li 0,1
	lfs 13,596(3)
	la 9,target_crosslevel_target_think@l(9)
	stw 0,184(3)
	lis 11,level+4@ha
	stw 9,436(3)
	lfs 0,level+4@l(11)
	fadds 0,0,13
	stfs 0,428(3)
	blr
.Lfe30:
	.size	 SP_target_crosslevel_target,.Lfe30-SP_target_crosslevel_target
	.align 2
	.globl target_laser_on
	.type	 target_laser_on,@function
target_laser_on:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 11,3
	lwz 0,548(11)
	cmpwi 0,0,0
	bc 4,2,.L123
	stw 11,548(11)
.L123:
	lwz 0,284(11)
	mr 3,11
	lwz 9,184(11)
	oris 0,0,0x8000
	ori 0,0,1
	rlwinm 9,9,0,0,30
	stw 0,284(11)
	stw 9,184(11)
	bl target_laser_think
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe31:
	.size	 target_laser_on,.Lfe31-target_laser_on
	.align 2
	.globl target_laser_off
	.type	 target_laser_off,@function
target_laser_off:
	lwz 0,284(3)
	li 11,0
	lwz 9,184(3)
	rlwinm 0,0,0,0,30
	stw 11,428(3)
	ori 9,9,1
	stw 0,284(3)
	stw 9,184(3)
	blr
.Lfe32:
	.size	 target_laser_off,.Lfe32-target_laser_off
	.align 2
	.globl target_laser_use
	.type	 target_laser_use,@function
target_laser_use:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	lwz 11,284(10)
	stw 5,548(10)
	andi. 0,11,1
	bc 12,2,.L126
	lwz 0,184(10)
	rlwinm 11,11,0,0,30
	li 9,0
	stw 9,428(10)
	ori 0,0,1
	stw 11,284(10)
	stw 0,184(10)
	b .L128
.L126:
	cmpwi 0,5,0
	bc 4,2,.L129
	stw 10,548(10)
.L129:
	lwz 0,284(10)
	mr 3,10
	lwz 9,184(10)
	oris 0,0,0x8000
	ori 0,0,1
	rlwinm 9,9,0,0,30
	stw 0,284(10)
	stw 9,184(10)
	bl target_laser_think
.L128:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe33:
	.size	 target_laser_use,.Lfe33-target_laser_use
	.section	".rodata"
	.align 2
.LC68:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl SP_target_laser
	.type	 SP_target_laser,@function
SP_target_laser:
	lis 9,target_laser_start@ha
	lis 11,level+4@ha
	la 9,target_laser_start@l(9)
	stw 9,436(3)
	lis 9,.LC68@ha
	lfs 0,level+4@l(11)
	la 9,.LC68@l(9)
	lfs 13,0(9)
	fadds 0,0,13
	stfs 0,428(3)
	blr
.Lfe34:
	.size	 SP_target_laser,.Lfe34-SP_target_laser
	.align 2
	.globl target_lightramp_use
	.type	 target_lightramp_use,@function
target_lightramp_use:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	mr 31,3
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L161
	lis 9,gi@ha
	li 27,0
	la 30,gi@l(9)
	lis 24,.LC27@ha
	lis 25,.LC28@ha
	lis 26,.LC29@ha
	b .L164
.L165:
	lwz 3,280(27)
	la 4,.LC27@l(24)
	bl strcmp
	cmpwi 0,3,0
	bc 12,2,.L166
	lwz 29,280(31)
	addi 3,31,4
	bl vtos
	lwz 9,4(30)
	mr 5,3
	mr 4,29
	la 3,.LC28@l(25)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 29,296(31)
	addi 3,27,4
	lwz 28,280(27)
	bl vtos
	lwz 9,4(30)
	mr 6,3
	mr 4,29
	mr 5,28
	la 3,.LC29@l(26)
	mtlr 9
	crxor 6,6,6
	blrl
	b .L164
.L166:
	stw 27,540(31)
.L164:
	lwz 5,296(31)
	mr 3,27
	li 4,300
	bl G_Find
	mr. 27,3
	bc 4,2,.L165
	lwz 0,540(31)
	cmpwi 0,0,0
	bc 4,2,.L161
	lis 29,gi@ha
	lwz 27,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	lwz 28,296(31)
	bl vtos
	mr 6,3
	lwz 0,4(29)
	mr 4,27
	lis 3,.LC30@ha
	mr 5,28
	la 3,.LC30@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,31
	bl G_FreeEdict
	b .L160
.L161:
	lis 9,level+4@ha
	mr 3,31
	lfs 0,level+4@l(9)
	stfs 0,288(31)
	bl target_lightramp_think
.L160:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe35:
	.size	 target_lightramp_use,.Lfe35-target_lightramp_use
	.section	".rodata"
	.align 3
.LC69:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC70:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl target_earthquake_use
	.type	 target_earthquake_use,@function
target_earthquake_use:
	stwu 1,-16(1)
	lwz 0,532(3)
	lis 8,0x4330
	lis 9,.LC70@ha
	lis 10,.LC69@ha
	xoris 0,0,0x8000
	la 9,.LC70@l(9)
	lfd 11,.LC69@l(10)
	stw 0,12(1)
	li 10,0
	stw 8,8(1)
	lfd 12,0(9)
	lfd 0,8(1)
	lis 9,level@ha
	la 9,level@l(9)
	lfs 13,4(9)
	fsub 0,0,12
	frsp 0,0
	fadds 13,13,0
	stfs 13,288(3)
	lfs 0,4(9)
	stw 10,476(3)
	stw 5,548(3)
	fadd 0,0,11
	frsp 0,0
	stfs 0,428(3)
	la 1,16(1)
	blr
.Lfe36:
	.size	 target_earthquake_use,.Lfe36-target_earthquake_use
	.section	".rodata"
	.align 2
.LC71:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_earthquake
	.type	 SP_target_earthquake,@function
SP_target_earthquake:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 31,3
	lwz 0,300(31)
	cmpwi 0,0,0
	bc 4,2,.L191
	lis 29,gi@ha
	lwz 28,280(31)
	addi 3,31,4
	la 29,gi@l(29)
	bl vtos
	mr 5,3
	lwz 0,4(29)
	mr 4,28
	lis 3,.LC45@ha
	la 3,.LC45@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L191:
	lwz 0,532(31)
	cmpwi 0,0,0
	bc 4,2,.L192
	li 0,5
	stw 0,532(31)
.L192:
	lis 8,.LC71@ha
	lfs 13,328(31)
	la 8,.LC71@l(8)
	lfs 0,0(8)
	fcmpu 0,13,0
	bc 4,2,.L193
	lis 0,0x4348
	stw 0,328(31)
.L193:
	lwz 10,284(31)
	lis 9,target_earthquake_think@ha
	lis 11,target_earthquake_use@ha
	lwz 0,184(31)
	la 9,target_earthquake_think@l(9)
	la 11,target_earthquake_use@l(11)
	andi. 8,10,1
	stw 9,436(31)
	ori 0,0,1
	stw 11,448(31)
	stw 0,184(31)
	bc 4,2,.L194
	lis 9,gi+36@ha
	lis 3,.LC46@ha
	lwz 0,gi+36@l(9)
	la 3,.LC46@l(3)
	mtlr 0
	blrl
	stw 3,576(31)
.L194:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe37:
	.size	 SP_target_earthquake,.Lfe37-SP_target_earthquake
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
