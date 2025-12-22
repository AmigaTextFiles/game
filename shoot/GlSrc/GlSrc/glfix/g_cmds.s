	.file	"g_cmds.c"
gcc2_compiled.:
	.section	".rodata"
	.align 3
.LC0:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC1:
	.long 0x42480000
	.section	".text"
	.align 2
	.globl Waypoint_Think
	.type	 Waypoint_Think,@function
Waypoint_Think:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,3
	li 31,0
	lwz 9,324(30)
	lwz 0,588(9)
	cmpwi 0,0,2
	bc 4,2,.L7
	bl G_FreeEdict
.L7:
	lis 9,Waypoint_Think@ha
	la 9,Waypoint_Think@l(9)
	stw 9,532(30)
	addi 29,30,4
	b .L8
.L10:
	lwz 0,184(31)
	andi. 9,0,4
	bc 12,2,.L8
	lwz 0,256(30)
	cmpw 0,31,0
	bc 12,2,.L8
	lwz 0,608(31)
	cmpwi 0,0,0
	bc 12,2,.L8
	lwz 0,324(30)
	cmpw 0,0,31
	bc 4,2,.L8
	lwz 0,576(31)
	cmpwi 0,0,0
	bc 4,1,.L8
	mr 3,30
	mr 4,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L8
	lwz 11,884(31)
	li 29,0
	mr 3,31
	lwz 0,872(31)
	stw 29,508(31)
	mtlr 11
	ori 0,0,3
	stw 0,872(31)
	blrl
	stw 29,324(31)
	mr 3,30
	stw 29,636(31)
	bl G_FreeEdict
	b .L9
.L8:
	lis 9,.LC1@ha
	mr 3,31
	la 9,.LC1@l(9)
	mr 4,29
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	bc 4,2,.L10
.L9:
	lis 9,level+4@ha
	lis 11,.LC0@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC0@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(30)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 Waypoint_Think,.Lfe1-Waypoint_Think
	.section	".rodata"
	.align 2
.LC2:
	.string	"patrol2"
	.align 2
.LC3:
	.string	"patrol1"
	.align 3
.LC4:
	.long 0x3fb99999
	.long 0x9999999a
	.align 2
.LC5:
	.long 0x42c80000
	.section	".text"
	.align 2
	.globl Patrol_Think
	.type	 Patrol_Think,@function
Patrol_Think:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,3
	li 31,0
	lwz 9,324(30)
	lwz 0,588(9)
	cmpwi 0,0,2
	bc 4,2,.L19
	bl G_FreeEdict
.L19:
	lis 9,Patrol_Think@ha
	la 9,Patrol_Think@l(9)
	stw 9,532(30)
	addi 29,30,4
	b .L20
.L22:
	lwz 0,184(31)
	andi. 9,0,4
	bc 12,2,.L20
	lwz 0,256(30)
	cmpw 0,31,0
	bc 12,2,.L20
	lwz 0,608(31)
	cmpwi 0,0,0
	bc 12,2,.L20
	lwz 0,576(31)
	cmpwi 0,0,0
	bc 4,1,.L20
	lwz 0,324(30)
	cmpw 0,0,31
	bc 4,2,.L20
	lwz 0,332(31)
	cmpwi 0,0,0
	bc 12,2,.L20
	lwz 0,328(31)
	cmpwi 0,0,0
	bc 12,2,.L20
	mr 3,30
	mr 4,31
	bl visible
	cmpwi 0,3,0
	bc 12,2,.L20
	lwz 3,280(30)
	lis 4,.LC2@ha
	la 4,.LC2@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L31
	lwz 0,328(31)
	stw 0,508(31)
	stw 0,512(31)
.L31:
	lwz 3,280(30)
	lis 4,.LC3@ha
	la 4,.LC3@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L32
	lwz 0,332(31)
	stw 0,508(31)
	stw 0,512(31)
.L32:
	lwz 0,896(31)
	lwz 3,512(31)
	mtlr 0
	blrl
	b .L21
.L20:
	lis 9,.LC5@ha
	mr 3,31
	la 9,.LC5@l(9)
	mr 4,29
	lfs 1,0(9)
	bl findradius
	mr. 31,3
	bc 4,2,.L22
.L21:
	lis 9,level+4@ha
	lis 11,.LC4@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC4@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,524(30)
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Patrol_Think,.Lfe2-Patrol_Think
	.lcomm	value.12,512,4
	.section	".rodata"
	.align 2
.LC6:
	.string	"skin"
	.section	".text"
	.align 2
	.globl OnSameTeam
	.type	 OnSameTeam,@function
OnSameTeam:
	stwu 1,-1072(1)
	mflr 0
	stmw 27,1052(1)
	stw 0,1076(1)
	lis 11,dmflags@ha
	lwz 10,dmflags@l(11)
	mr 28,4
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 9,1044(1)
	andi. 0,9,192
	bc 4,2,.L39
	li 3,0
	b .L49
.L39:
	lis 9,value.12@ha
	li 30,0
	stb 30,value.12@l(9)
	la 31,value.12@l(9)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L51
	lis 4,.LC6@ha
	addi 3,3,188
	la 4,.LC6@l(4)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl strcpy
	mr 3,31
	li 4,47
	bl strchr
	mr. 3,3
	bc 12,2,.L51
	lis 9,dmflags@ha
	lwz 11,dmflags@l(9)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 9,1044(1)
	andi. 0,9,128
	bc 12,2,.L43
	stb 30,0(3)
.L51:
	mr 3,31
	b .L41
.L43:
	addi 3,3,1
.L41:
	mr 4,3
	li 29,0
	addi 3,1,8
	bl strcpy
	lis 9,value.12@ha
	addi 30,1,520
	stb 29,value.12@l(9)
	mr 27,30
	la 31,value.12@l(9)
	lwz 3,84(28)
	cmpwi 0,3,0
	bc 12,2,.L53
	lis 4,.LC6@ha
	addi 3,3,188
	la 4,.LC6@l(4)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl strcpy
	mr 3,31
	li 4,47
	bl strchr
	mr. 3,3
	bc 12,2,.L53
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1040(1)
	lwz 11,1044(1)
	andi. 0,11,128
	bc 12,2,.L47
	stb 29,0(3)
.L53:
	mr 3,31
	b .L45
.L47:
	addi 3,3,1
.L45:
	mr 4,3
	mr 3,30
	bl strcpy
	mr 4,27
	addi 3,1,8
	bl strcmp
	subfic 0,3,0
	adde 3,0,3
.L49:
	lwz 0,1076(1)
	mtlr 0
	lmw 27,1052(1)
	la 1,1072(1)
	blr
.Lfe3:
	.size	 OnSameTeam,.Lfe3-OnSameTeam
	.section	".rodata"
	.align 2
.LC7:
	.string	"You cannot spawn anything outside level!"
	.align 2
.LC8:
	.string	"Another monster too close\n"
	.align 2
.LC9:
	.string	"Player too close\n"
	.align 2
.LC10:
	.string	"Too many monsters in this area (exceeded nearby monster limit)\n"
	.align 3
.LC11:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC12:
	.long 0x44360000
	.section	".text"
	.align 2
	.globl CheckRadius
	.type	 CheckRadius,@function
CheckRadius:
	stwu 1,-64(1)
	mflr 0
	stmw 27,44(1)
	stw 0,68(1)
	mr 28,3
	lis 9,gi@ha
	lwz 11,84(28)
	la 30,gi@l(9)
	addi 3,1,8
	lfs 12,4(28)
	mr 29,4
	li 31,0
	lfs 0,40(11)
	lfs 13,8(28)
	lfs 11,12(28)
	fadds 12,12,0
	lwz 9,52(30)
	mtlr 9
	stfs 12,8(1)
	lfs 0,44(11)
	fadds 13,13,0
	stfs 13,12(1)
	lfs 0,48(11)
	fadds 11,11,0
	stfs 11,16(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L55
	lwz 0,8(30)
	lis 5,.LC7@ha
	mr 3,28
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L54
.L73:
	lis 9,gi+8@ha
	lis 5,.LC8@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC8@l(5)
	b .L76
.L74:
	lis 9,gi+8@ha
	lis 5,.LC9@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC9@l(5)
	b .L76
.L75:
	lis 9,gi+8@ha
	lis 5,.LC10@ha
	lwz 0,gi+8@l(9)
	mr 3,28
	la 5,.LC10@l(5)
.L76:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L54
.L55:
	li 27,0
	addi 30,28,4
	b .L56
.L58:
	lwz 0,184(31)
	andi. 9,0,4
	bc 12,2,.L56
	lwz 0,576(31)
	cmpwi 0,0,0
	bc 12,1,.L73
.L56:
	xoris 0,29,0x8000
	stw 0,36(1)
	lis 9,0x4330
	lis 10,.LC11@ha
	la 10,.LC11@l(10)
	stw 9,32(1)
	mr 3,31
	lfd 0,0(10)
	mr 4,30
	lfd 1,32(1)
	fsub 1,1,0
	frsp 1,1
	bl findradius
	mr. 31,3
	bc 4,2,.L58
	add 29,29,29
	b .L61
.L63:
	lwz 0,292(31)
	cmpwi 0,0,0
	bc 4,1,.L61
	lwz 0,576(31)
	cmpwi 0,0,0
	bc 12,1,.L74
.L61:
	xoris 0,29,0x8000
	stw 0,36(1)
	lis 9,0x4330
	lis 10,.LC11@ha
	la 10,.LC11@l(10)
	stw 9,32(1)
	mr 3,31
	lfd 0,0(10)
	mr 4,30
	lfd 1,32(1)
	fsub 1,1,0
	frsp 1,1
	bl findradius
	mr. 31,3
	bc 4,2,.L63
	b .L66
.L68:
	lwz 0,184(31)
	andi. 9,0,4
	bc 12,2,.L69
	lwz 9,576(31)
	addi 11,27,1
	addi 0,9,-1
	or 9,9,0
	srawi 9,9,31
	andc 11,11,9
	and 9,27,9
	or 27,9,11
.L69:
	cmpwi 0,27,7
	bc 12,1,.L75
.L66:
	lis 10,.LC12@ha
	mr 3,31
	la 10,.LC12@l(10)
	mr 4,30
	lfs 1,0(10)
	bl findradius
	mr. 31,3
	bc 4,2,.L68
	li 3,1
.L54:
	lwz 0,68(1)
	mtlr 0
	lmw 27,44(1)
	la 1,64(1)
	blr
.Lfe4:
	.size	 CheckRadius,.Lfe4-CheckRadius
	.section	".rodata"
	.align 2
.LC13:
	.string	"Not Enough Cells for that operation\n"
	.align 2
.LC14:
	.string	"     NAME              RANGE        \n\n"
	.align 2
.LC15:
	.string	"%16s          %i              \n"
	.align 2
.LC16:
	.string	"%s"
	.align 3
.LC17:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC18:
	.long 0x46000000
	.align 2
.LC19:
	.long 0x44000000
	.section	".text"
	.align 2
	.globl Cmd_id_f
	.type	 Cmd_id_f,@function
Cmd_id_f:
	stwu 1,-672(1)
	mflr 0
	stmw 27,652(1)
	stw 0,676(1)
	mr 31,3
	lis 4,.LC14@ha
	addi 3,1,8
	la 4,.LC14@l(4)
	crxor 6,6,6
	bl sprintf
	lwz 0,604(31)
	lis 11,0x4330
	lis 10,.LC17@ha
	lfs 13,12(31)
	mr 30,3
	xoris 0,0,0x8000
	la 10,.LC17@l(10)
	lfs 10,4(31)
	stw 0,644(1)
	addi 28,1,536
	addi 27,1,520
	stw 11,640(1)
	addi 29,1,552
	li 6,0
	lfd 0,640(1)
	mr 4,28
	li 5,0
	lfd 11,0(10)
	lfs 12,8(31)
	lwz 3,84(31)
	fsub 0,0,11
	stfs 10,520(1)
	stfs 12,524(1)
	addi 3,3,3636
	frsp 0,0
	fadds 13,13,0
	stfs 13,528(1)
	bl AngleVectors
	lis 9,.LC18@ha
	mr 4,28
	la 9,.LC18@l(9)
	mr 3,27
	lfs 1,0(9)
	mr 5,29
	bl VectorMA
	lis 11,gi@ha
	lis 9,0x600
	la 28,gi@l(11)
	li 5,0
	lwz 11,48(28)
	ori 9,9,27
	mr 4,27
	mr 7,29
	addi 3,1,568
	li 6,0
	mr 8,31
	mtlr 11
	blrl
	lwz 9,620(1)
	lwz 5,84(9)
	cmpwi 0,5,0
	bc 12,2,.L90
	lis 9,.LC19@ha
	lfs 0,576(1)
	la 9,.LC19@l(9)
	addi 29,1,8
	lfs 12,0(9)
	lis 4,.LC15@ha
	addi 5,5,700
	la 4,.LC15@l(4)
	add 3,29,30
	fmuls 0,0,12
	fctiwz 13,0
	stfd 13,640(1)
	lwz 6,644(1)
	crxor 6,6,6
	bl sprintf
	lwz 0,12(28)
	lis 4,.LC16@ha
	mr 3,31
	la 4,.LC16@l(4)
	mr 5,29
	mtlr 0
	crxor 6,6,6
	blrl
.L90:
	lwz 0,676(1)
	mtlr 0
	lmw 27,652(1)
	la 1,672(1)
	blr
.Lfe5:
	.size	 Cmd_id_f,.Lfe5-Cmd_id_f
	.section	".rodata"
	.align 2
.LC21:
	.string	"waypoint"
	.align 2
.LC22:
	.string	"models/objects/target/tris.md2"
	.align 3
.LC20:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC23:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC24:
	.long 0x46000000
	.align 2
.LC25:
	.long 0x42000000
	.align 2
.LC26:
	.long 0x42340000
	.section	".text"
	.align 2
	.globl Cmd_Select_f
	.type	 Cmd_Select_f,@function
Cmd_Select_f:
	stwu 1,-144(1)
	mflr 0
	stmw 28,128(1)
	stw 0,148(1)
	mr 31,3
	lwz 0,604(31)
	lis 11,0x4330
	lis 10,.LC23@ha
	la 10,.LC23@l(10)
	lfs 13,12(31)
	addi 29,1,24
	xoris 0,0,0x8000
	lfd 11,0(10)
	addi 28,1,40
	stw 0,124(1)
	li 6,0
	mr 4,29
	stw 11,120(1)
	li 5,0
	lfd 0,120(1)
	lfs 10,4(31)
	lfs 12,8(31)
	fsub 0,0,11
	lwz 3,84(31)
	stfs 10,8(1)
	stfs 12,12(1)
	addi 3,3,3636
	frsp 0,0
	fadds 13,13,0
	stfs 13,16(1)
	bl AngleVectors
	lis 9,.LC24@ha
	addi 3,1,8
	la 9,.LC24@l(9)
	mr 4,29
	lfs 1,0(9)
	mr 5,28
	bl VectorMA
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	ori 9,9,27
	mr 7,28
	addi 3,1,56
	addi 4,1,8
	li 5,0
	li 6,0
	mtlr 0
	mr 8,31
	blrl
	lwz 9,108(1)
	cmpwi 0,9,0
	bc 12,2,.L91
	lwz 0,184(9)
	andi. 10,0,4
	bc 12,2,.L92
	stw 9,324(31)
	b .L91
.L92:
	lwz 0,324(31)
	cmpwi 0,0,0
	mr 3,0
	bc 12,2,.L94
	lwz 29,324(3)
	cmpwi 0,29,0
	bc 4,2,.L94
	lwz 0,576(3)
	cmpwi 0,0,0
	bc 4,1,.L91
	lwz 3,328(3)
	cmpwi 0,3,0
	bc 12,2,.L96
	bl G_FreeEdict
	lwz 9,324(31)
	lwz 3,332(9)
	cmpwi 0,3,0
	bc 12,2,.L97
	bl G_FreeEdict
.L97:
	lwz 9,324(31)
	stw 29,328(9)
	lwz 11,324(31)
	stw 29,332(11)
.L96:
	bl G_Spawn
	lfs 0,68(1)
	mr 29,3
	lis 9,.LC25@ha
	la 9,.LC25@l(9)
	lis 10,level@ha
	lfs 13,0(9)
	lis 11,.LC26@ha
	la 10,level@l(10)
	stfs 0,4(29)
	la 11,.LC26@l(11)
	lis 9,.LC20@ha
	lfs 0,72(1)
	lis 8,.LC21@ha
	lis 28,gi@ha
	lfs 11,0(11)
	la 8,.LC21@l(8)
	la 28,gi@l(28)
	lfd 12,.LC20@l(9)
	lis 11,Waypoint_Think@ha
	lis 3,.LC22@ha
	stfs 0,8(29)
	la 11,Waypoint_Think@l(11)
	la 3,.LC22@l(3)
	lfs 0,76(1)
	fadds 0,0,13
	stfs 0,12(29)
	lfs 13,4(10)
	fadds 13,13,11
	stfs 13,692(29)
	lfs 0,4(10)
	stw 11,532(29)
	fadd 0,0,12
	frsp 0,0
	stfs 0,524(29)
	lwz 0,324(31)
	stw 8,280(29)
	stw 0,324(29)
	lwz 9,32(28)
	mtlr 9
	blrl
	stw 3,40(29)
	lwz 11,324(31)
	stw 29,508(11)
	stw 29,512(11)
	lwz 9,324(31)
	stw 29,324(9)
	lwz 11,324(31)
	lwz 0,896(11)
	mr 3,11
	mtlr 0
	blrl
	lwz 0,72(28)
	mr 3,29
	mtlr 0
	blrl
	b .L91
.L94:
	lwz 0,108(1)
	cmpwi 0,0,0
	bc 12,2,.L91
	cmpwi 0,3,0
	bc 12,2,.L91
	lwz 3,324(3)
	cmpwi 0,3,0
	bc 12,2,.L91
	lwz 0,184(3)
	andi. 9,0,4
	bc 4,2,.L100
	bl G_FreeEdict
.L100:
	lwz 11,324(31)
	li 0,0
	stw 0,324(11)
	lwz 9,324(31)
	stw 0,508(9)
	lwz 11,324(31)
	stw 0,636(11)
	lwz 10,324(31)
	lwz 0,872(10)
	ori 0,0,3
	stw 0,872(10)
	lwz 9,324(31)
	lwz 0,884(9)
	mr 3,9
	mtlr 0
	blrl
.L91:
	lwz 0,148(1)
	mtlr 0
	lmw 28,128(1)
	la 1,144(1)
	blr
.Lfe6:
	.size	 Cmd_Select_f,.Lfe6-Cmd_Select_f
	.section	".rodata"
	.align 3
.LC27:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC28:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl Cmd_Select2_f
	.type	 Cmd_Select2_f,@function
Cmd_Select2_f:
	stwu 1,-144(1)
	mflr 0
	stmw 28,128(1)
	stw 0,148(1)
	mr 31,3
	lwz 0,604(31)
	lis 11,0x4330
	lis 10,.LC27@ha
	la 10,.LC27@l(10)
	lfs 13,12(31)
	addi 29,1,24
	xoris 0,0,0x8000
	lfd 11,0(10)
	addi 28,1,40
	stw 0,124(1)
	li 6,0
	mr 4,29
	stw 11,120(1)
	li 5,0
	lfd 0,120(1)
	lfs 10,4(31)
	lfs 12,8(31)
	fsub 0,0,11
	lwz 3,84(31)
	stfs 10,8(1)
	stfs 12,12(1)
	addi 3,3,3636
	frsp 0,0
	fadds 13,13,0
	stfs 13,16(1)
	bl AngleVectors
	lis 9,.LC28@ha
	addi 3,1,8
	la 9,.LC28@l(9)
	mr 4,29
	lfs 1,0(9)
	mr 5,28
	bl VectorMA
	lis 11,gi+48@ha
	lis 9,0x600
	lwz 0,gi+48@l(11)
	ori 9,9,27
	mr 7,28
	addi 3,1,56
	addi 4,1,8
	li 5,0
	li 6,0
	mtlr 0
	mr 8,31
	blrl
	lwz 9,108(1)
	cmpwi 0,9,0
	bc 12,2,.L101
	lwz 0,184(9)
	andi. 10,0,4
	bc 12,2,.L102
	lwz 0,324(31)
	cmpwi 0,0,0
	bc 4,2,.L102
	stw 9,324(31)
	b .L101
.L102:
	lwz 0,108(1)
	cmpwi 0,0,0
	mr 9,0
	bc 12,2,.L101
	lwz 0,324(31)
	cmpwi 0,0,0
	mr 3,0
	bc 12,2,.L104
	lwz 0,184(9)
	andi. 11,0,4
	bc 12,2,.L104
	lwz 0,576(3)
	cmpwi 0,0,0
	bc 4,1,.L101
	lwz 3,328(3)
	cmpwi 0,3,0
	bc 12,2,.L106
	bl G_FreeEdict
	lwz 9,324(31)
	lwz 3,332(9)
	bl G_FreeEdict
	lwz 11,324(31)
	li 0,0
	stw 0,328(11)
	lwz 9,324(31)
	stw 0,332(9)
.L106:
	lwz 9,324(31)
	li 0,0
	stw 0,324(9)
	lwz 0,108(1)
	lwz 11,324(31)
	stw 0,508(11)
	stw 0,512(11)
	lwz 0,108(1)
	lwz 10,324(31)
	stw 0,324(10)
	lwz 9,324(31)
	lwz 0,896(9)
	mr 3,9
	mtlr 0
	blrl
	b .L101
.L104:
	cmpwi 0,9,0
	bc 12,2,.L101
	cmpwi 0,3,0
	bc 12,2,.L101
	cmpw 0,9,3
	bc 4,2,.L101
	li 29,0
	stw 29,324(9)
	lwz 9,324(31)
	stw 29,508(9)
	lwz 11,324(31)
	stw 29,636(11)
	lwz 10,324(31)
	lwz 0,872(10)
	ori 0,0,3
	stw 0,872(10)
	lwz 9,324(31)
	lwz 0,884(9)
	mr 3,9
	mtlr 0
	blrl
	stw 29,324(31)
.L101:
	lwz 0,148(1)
	mtlr 0
	lmw 28,128(1)
	la 1,144(1)
	blr
.Lfe7:
	.size	 Cmd_Select2_f,.Lfe7-Cmd_Select2_f
	.section	".rodata"
	.align 3
.LC29:
	.long 0x3fb99999
	.long 0x9999999a
	.align 3
.LC30:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC31:
	.long 0x46000000
	.align 2
.LC32:
	.long 0x42000000
	.align 2
.LC33:
	.long 0x43110000
	.section	".text"
	.align 2
	.globl Cmd_Patrol_f
	.type	 Cmd_Patrol_f,@function
Cmd_Patrol_f:
	stwu 1,-144(1)
	mflr 0
	stmw 28,128(1)
	stw 0,148(1)
	mr 31,3
	lwz 0,604(31)
	lis 11,0x4330
	lis 10,.LC30@ha
	la 10,.LC30@l(10)
	lfs 13,12(31)
	addi 29,1,24
	xoris 0,0,0x8000
	lfd 11,0(10)
	addi 28,1,40
	stw 0,124(1)
	li 6,0
	mr 4,29
	stw 11,120(1)
	li 5,0
	lfd 0,120(1)
	lfs 10,4(31)
	lfs 12,8(31)
	fsub 0,0,11
	lwz 3,84(31)
	stfs 10,8(1)
	stfs 12,12(1)
	addi 3,3,3636
	frsp 0,0
	fadds 13,13,0
	stfs 13,16(1)
	bl AngleVectors
	lis 9,.LC31@ha
	addi 3,1,8
	la 9,.LC31@l(9)
	mr 4,29
	lfs 1,0(9)
	mr 5,28
	bl VectorMA
	lis 11,gi@ha
	lis 9,0x600
	la 30,gi@l(11)
	ori 9,9,27
	lwz 11,48(30)
	mr 7,28
	addi 3,1,56
	addi 4,1,8
	li 5,0
	li 6,0
	mr 8,31
	mtlr 11
	blrl
	lwz 9,108(1)
	cmpwi 0,9,0
	bc 12,2,.L109
	lwz 0,184(9)
	andi. 10,0,4
	bc 12,2,.L110
	stw 9,324(31)
	b .L111
.L110:
	lwz 3,324(31)
	cmpwi 0,3,0
	bc 12,2,.L111
	lwz 29,328(3)
	cmpwi 0,29,0
	bc 4,2,.L111
	lwz 0,576(3)
	cmpwi 0,0,0
	bc 4,1,.L109
	lwz 3,324(3)
	cmpwi 0,3,0
	bc 12,2,.L114
	bl G_FreeEdict
	lwz 9,324(31)
	stw 29,324(9)
	lwz 11,324(31)
	stw 29,508(11)
	lwz 10,324(31)
	lwz 0,872(10)
	ori 0,0,3
	stw 0,872(10)
	lwz 9,324(31)
	lwz 0,884(9)
	mr 3,9
	mtlr 0
	blrl
	lwz 9,324(31)
	stw 29,636(9)
.L114:
	bl G_Spawn
	lfs 0,68(1)
	mr 28,3
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lis 10,level@ha
	lfs 13,0(9)
	lis 11,.LC33@ha
	la 10,level@l(10)
	stfs 0,4(28)
	la 11,.LC33@l(11)
	lis 9,.LC29@ha
	lfs 0,72(1)
	lis 8,.LC3@ha
	lis 3,.LC22@ha
	lfs 11,0(11)
	la 8,.LC3@l(8)
	la 3,.LC22@l(3)
	lfd 12,.LC29@l(9)
	lis 11,Patrol_Think@ha
	stfs 0,8(28)
	la 11,Patrol_Think@l(11)
	lfs 0,76(1)
	fadds 0,0,13
	stfs 0,12(28)
	lwz 0,324(31)
	stw 0,324(28)
	lfs 13,4(10)
	fadds 13,13,11
	stfs 13,692(28)
	lfs 0,4(10)
	stw 11,532(28)
	stw 8,280(28)
	fadd 0,0,12
	frsp 0,0
	stfs 0,524(28)
	lwz 9,32(30)
	mtlr 9
	blrl
	stw 3,40(28)
	lwz 9,324(31)
	mr 3,28
	stw 28,328(9)
	lwz 0,72(30)
	b .L120
.L111:
	lwz 0,108(1)
	cmpwi 0,0,0
	mr 11,0
	bc 12,2,.L109
	lwz 0,324(31)
	cmpwi 0,0,0
	mr 9,0
	bc 12,2,.L115
	lwz 0,328(9)
	cmpwi 0,0,0
	bc 12,2,.L115
	lwz 0,332(9)
	cmpwi 0,0,0
	bc 4,2,.L115
	lwz 0,576(9)
	cmpwi 0,0,0
	bc 4,1,.L109
	bl G_Spawn
	lfs 0,68(1)
	mr 28,3
	lis 9,.LC32@ha
	la 9,.LC32@l(9)
	lis 10,level@ha
	lfs 13,0(9)
	lis 11,.LC33@ha
	la 10,level@l(10)
	stfs 0,4(28)
	la 11,.LC33@l(11)
	lis 9,.LC29@ha
	lfs 0,72(1)
	lis 8,.LC2@ha
	lis 29,gi@ha
	lfs 11,0(11)
	la 8,.LC2@l(8)
	la 29,gi@l(29)
	lfd 12,.LC29@l(9)
	lis 11,Patrol_Think@ha
	lis 3,.LC22@ha
	stfs 0,8(28)
	la 11,Patrol_Think@l(11)
	la 3,.LC22@l(3)
	lfs 0,76(1)
	fadds 0,0,13
	stfs 0,12(28)
	lwz 0,324(31)
	stw 0,324(28)
	lfs 13,4(10)
	fadds 13,13,11
	stfs 13,692(28)
	lfs 0,4(10)
	stw 11,532(28)
	stw 8,280(28)
	fadd 0,0,12
	frsp 0,0
	stfs 0,524(28)
	lwz 9,32(29)
	mtlr 9
	blrl
	stw 3,40(28)
	lwz 11,324(31)
	stw 28,332(11)
	lwz 9,324(31)
	lwz 0,328(9)
	stw 0,508(9)
	stw 0,512(9)
	lwz 11,324(31)
	lwz 0,896(11)
	mr 3,11
	mtlr 0
	blrl
	lwz 0,72(29)
	mr 3,28
.L120:
	mtlr 0
	blrl
	b .L109
.L115:
	cmpwi 0,11,0
	bc 12,2,.L109
	cmpwi 0,9,0
	bc 12,2,.L109
	lwz 0,328(9)
	cmpwi 0,0,0
	bc 12,2,.L109
	lwz 0,332(9)
	cmpwi 0,0,0
	bc 12,2,.L109
	li 29,0
	stw 29,508(9)
	lwz 11,324(31)
	lwz 0,872(11)
	ori 0,0,3
	stw 0,872(11)
	lwz 9,324(31)
	lwz 0,884(9)
	mr 3,9
	mtlr 0
	blrl
	lwz 9,324(31)
	stw 29,636(9)
	lwz 11,324(31)
	lwz 3,328(11)
	lwz 0,576(3)
	cmpwi 0,0,0
	bc 12,1,.L119
	bl G_FreeEdict
	lwz 11,324(31)
	lwz 9,328(11)
	lwz 0,576(9)
	cmpwi 0,0,0
	bc 12,1,.L119
	lwz 3,332(11)
	bl G_FreeEdict
.L119:
	lwz 9,324(31)
	li 0,0
	stw 0,328(9)
	lwz 11,324(31)
	stw 0,332(11)
.L109:
	lwz 0,148(1)
	mtlr 0
	lmw 28,128(1)
	la 1,144(1)
	blr
.Lfe8:
	.size	 Cmd_Patrol_f,.Lfe8-Cmd_Patrol_f
	.section	".rodata"
	.align 2
.LC34:
	.string	"misc/windfly.wav"
	.align 2
.LC36:
	.string	"Cells"
	.align 2
.LC37:
	.string	"You need to wait for your mental energies to recharge.\n"
	.align 2
.LC35:
	.long 0x451c4000
	.align 3
.LC38:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC39:
	.long 0x3f800000
	.align 2
.LC40:
	.long 0x0
	.align 2
.LC41:
	.long 0x41200000
	.align 2
.LC42:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl Cmd_Push_f
	.type	 Cmd_Push_f,@function
Cmd_Push_f:
	stwu 1,-160(1)
	mflr 0
	stfd 31,152(1)
	stmw 26,128(1)
	stw 0,164(1)
	mr 31,3
	lwz 0,336(31)
	lis 26,0x4330
	lis 9,.LC38@ha
	la 9,.LC38@l(9)
	xoris 0,0,0x8000
	lfd 31,0(9)
	stw 0,124(1)
	lis 9,level@ha
	stw 26,120(1)
	la 27,level@l(9)
	lfd 0,120(1)
	lfs 13,4(27)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 4,0,.L122
	lis 29,gi@ha
	lis 3,.LC34@ha
	la 29,gi@l(29)
	la 3,.LC34@l(3)
	lwz 9,36(29)
	addi 30,1,24
	addi 28,1,40
	mtlr 9
	blrl
	lis 9,.LC39@ha
	lis 11,.LC40@ha
	la 9,.LC39@l(9)
	la 11,.LC40@l(11)
	lfs 2,0(9)
	mr 5,3
	li 4,4
	lfs 3,0(11)
	lis 9,.LC39@ha
	mr 3,31
	lwz 11,16(29)
	la 9,.LC39@l(9)
	lfs 1,0(9)
	mtlr 11
	blrl
	lis 9,.LC41@ha
	lfs 0,4(27)
	li 6,0
	la 9,.LC41@l(9)
	lwz 0,604(31)
	mr 4,30
	lfs 12,0(9)
	li 5,0
	xoris 0,0,0x8000
	lfs 10,12(31)
	mr 11,9
	lfs 11,8(31)
	fadds 0,0,12
	lwz 3,84(31)
	lfs 12,4(31)
	stfs 11,12(1)
	addi 3,3,3636
	stfs 12,8(1)
	fctiwz 13,0
	stfd 13,120(1)
	lwz 9,124(1)
	stw 0,124(1)
	stw 26,120(1)
	lfd 0,120(1)
	stw 9,336(31)
	fsub 0,0,31
	frsp 0,0
	fadds 10,10,0
	stfs 10,16(1)
	bl AngleVectors
	lis 9,.LC42@ha
	addi 3,1,8
	la 9,.LC42@l(9)
	mr 4,30
	lfs 1,0(9)
	mr 5,28
	bl VectorMA
	lwz 0,48(29)
	lis 9,0x600
	mr 7,28
	ori 9,9,3
	addi 3,1,56
	addi 4,1,8
	li 5,0
	mtlr 0
	li 6,0
	mr 8,31
	blrl
	lwz 9,108(1)
	cmpwi 0,9,0
	bc 12,2,.L126
	lwz 0,184(9)
	andi. 11,0,4
	bc 4,2,.L124
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L126
.L124:
	lis 9,.LC35@ha
	mr 3,30
	lfs 1,.LC35@l(9)
	mr 4,3
	bl VectorScale
	lwz 9,108(1)
	lfs 0,24(1)
	lfs 13,472(9)
	fadds 0,0,13
	stfs 0,472(9)
	lwz 11,108(1)
	lfs 0,28(1)
	lfs 13,476(11)
	fadds 0,0,13
	stfs 0,476(11)
	lwz 10,108(1)
	lfs 0,32(1)
	lfs 13,480(10)
	fadds 0,0,13
	stfs 0,480(10)
	lwz 9,108(1)
	lwz 0,184(9)
	andi. 9,0,4
	bc 12,2,.L126
	b .L127
.L122:
	lis 9,gi+8@ha
	lis 5,.LC37@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC37@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L127:
	lis 3,.LC36@ha
	la 3,.LC36@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 9,11,3
	addi 9,9,5
	stwx 9,11,3
.L126:
	lwz 0,164(1)
	mtlr 0
	lmw 26,128(1)
	lfd 31,152(1)
	la 1,160(1)
	blr
.Lfe9:
	.size	 Cmd_Push_f,.Lfe9-Cmd_Push_f
	.section	".rodata"
	.align 2
.LC43:
	.string	"You must run the server with '+set cheats 1' to enable this command.\n"
	.align 2
.LC44:
	.string	"all"
	.align 2
.LC45:
	.string	"health"
	.align 2
.LC46:
	.string	"weapons"
	.align 2
.LC47:
	.string	"ammo"
	.align 2
.LC48:
	.string	"armor"
	.align 2
.LC49:
	.string	"Jacket Armor"
	.align 2
.LC50:
	.string	"Combat Armor"
	.align 2
.LC51:
	.string	"Body Armor"
	.align 2
.LC52:
	.string	"Power Shield"
	.align 2
.LC53:
	.string	"unknown item\n"
	.align 2
.LC54:
	.string	"non-pickup item\n"
	.align 2
.LC55:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Give_f
	.type	 Cmd_Give_f,@function
Cmd_Give_f:
	stwu 1,-48(1)
	mflr 0
	mfcr 12
	stmw 26,24(1)
	stw 0,52(1)
	stw 12,20(1)
	lis 9,deathmatch@ha
	lis 10,.LC55@ha
	lwz 11,deathmatch@l(9)
	la 10,.LC55@l(10)
	mr 31,3
	lfs 13,0(10)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L161
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L161
	lis 9,gi+8@ha
	lis 5,.LC43@ha
	lwz 0,gi+8@l(9)
	la 5,.LC43@l(5)
	b .L212
.L161:
	lis 9,gi@ha
	la 28,gi@l(9)
	lwz 9,164(28)
	mtlr 9
	blrl
	mr 30,3
	lis 4,.LC44@ha
	la 4,.LC44@l(4)
	bl Q_stricmp
	subfic 0,3,0
	adde. 27,0,3
	mfcr 29
	bc 4,2,.L165
	lwz 9,160(28)
	li 3,1
	rlwinm 29,29,16,0xffffffff
	mtcrf 8,29
	rlwinm 29,29,16,0xffffffff
	mtlr 9
	blrl
	lis 4,.LC45@ha
	la 4,.LC45@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L164
.L165:
	lwz 9,156(28)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L166
	lwz 0,160(28)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	stw 3,576(31)
	b .L167
.L166:
	lwz 0,580(31)
	stw 0,576(31)
.L167:
	cmpwi 4,27,0
	bc 12,18,.L160
.L164:
	bc 4,18,.L170
	lis 4,.LC46@ha
	mr 3,30
	la 4,.LC46@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L169
.L170:
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L172
	lis 9,itemlist@ha
	mr 7,11
	la 8,itemlist@l(9)
	li 10,0
.L174:
	mr 27,8
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L173
	lwz 0,56(27)
	andi. 9,0,1
	bc 12,2,.L173
	lwz 11,84(31)
	addi 11,11,740
	lwzx 9,11,10
	addi 9,9,1
	stwx 9,11,10
.L173:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 8,8,76
	cmpw 0,29,0
	bc 12,0,.L174
.L172:
	bc 12,18,.L160
.L169:
	bc 4,18,.L180
	lis 4,.LC47@ha
	mr 3,30
	la 4,.LC47@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L179
.L180:
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L182
	lis 9,itemlist@ha
	mr 26,11
	la 28,itemlist@l(9)
.L184:
	mr 27,28
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 12,2,.L183
	lwz 0,56(27)
	andi. 9,0,2
	bc 12,2,.L183
	mr 4,27
	mr 3,31
	li 5,1000
	bl Add_Ammo
.L183:
	lwz 0,1556(26)
	addi 29,29,1
	addi 28,28,76
	cmpw 0,29,0
	bc 12,0,.L184
.L182:
	bc 12,18,.L160
.L179:
	bc 4,18,.L190
	lis 4,.LC48@ha
	mr 3,30
	la 4,.LC48@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L189
.L190:
	lis 3,.LC49@ha
	lis 28,0x286b
	la 3,.LC49@l(3)
	ori 28,28,51739
	bl FindItem
	li 27,0
	lis 29,itemlist@ha
	lwz 9,84(31)
	lis 11,.LC50@ha
	la 29,itemlist@l(29)
	subf 0,29,3
	addi 9,9,740
	mullw 0,0,28
	la 3,.LC50@l(11)
	rlwinm 0,0,0,0,29
	stwx 27,9,0
	bl FindItem
	subf 0,29,3
	lwz 9,84(31)
	mullw 0,0,28
	lis 3,.LC51@ha
	addi 9,9,740
	la 3,.LC51@l(3)
	rlwinm 0,0,0,0,29
	stwx 27,9,0
	bl FindItem
	mr 27,3
	lwz 9,84(31)
	lwz 11,64(27)
	subf 29,29,27
	mullw 29,29,28
	addi 9,9,740
	lwz 0,4(11)
	rlwinm 29,29,0,0,29
	stwx 0,9,29
	bc 12,18,.L160
.L189:
	bc 4,18,.L193
	lis 4,.LC52@ha
	mr 3,30
	la 4,.LC52@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L192
.L193:
	lis 3,.LC52@ha
	la 3,.LC52@l(3)
	bl FindItem
	mr 27,3
	bl G_Spawn
	lwz 0,0(27)
	mr 29,3
	mr 4,27
	stw 0,280(29)
	bl SpawnItem
	mr 3,29
	mr 4,31
	li 5,0
	li 6,0
	bl Touch_Item
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L194
	mr 3,29
	bl G_FreeEdict
.L194:
	bc 12,18,.L160
.L192:
	bc 12,18,.L196
	lis 9,game@ha
	li 29,0
	la 11,game@l(9)
	lwz 0,1556(11)
	cmpw 0,29,0
	bc 4,0,.L160
	lis 9,itemlist@ha
	mr 7,11
	la 11,itemlist@l(9)
	li 8,1
	li 10,0
.L200:
	lwz 0,4(11)
	cmpwi 0,0,0
	bc 12,2,.L199
	lwz 0,56(11)
	andi. 9,0,7
	bc 4,2,.L199
	lwz 9,84(31)
	addi 9,9,740
	stwx 8,9,10
.L199:
	lwz 0,1556(7)
	addi 29,29,1
	addi 10,10,4
	addi 11,11,76
	cmpw 0,29,0
	bc 12,0,.L200
	b .L160
.L196:
	mr 3,30
	bl FindItem
	mr. 27,3
	bc 4,2,.L204
	lis 9,gi@ha
	li 3,1
	la 29,gi@l(9)
	lwz 9,160(29)
	mtlr 9
	blrl
	bl FindItem
	mr. 27,3
	bc 4,2,.L204
	lwz 0,8(29)
	lis 5,.LC53@ha
	mr 3,31
	la 5,.LC53@l(5)
	b .L212
.L204:
	lwz 0,4(27)
	cmpwi 0,0,0
	bc 4,2,.L206
	lis 9,gi+8@ha
	lis 5,.LC54@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC54@l(5)
.L212:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L160
.L206:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,56(27)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,27
	andi. 10,11,2
	mullw 9,9,0
	srawi 28,9,2
	bc 12,2,.L207
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,3
	bc 4,2,.L208
	lwz 0,160(29)
	li 3,2
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(31)
	slwi 0,28,2
	addi 9,9,740
	stwx 3,9,0
	b .L160
.L208:
	lwz 9,84(31)
	slwi 10,28,2
	lwz 11,48(27)
	addi 9,9,740
	lwzx 0,9,10
	add 0,0,11
	stwx 0,9,10
	b .L160
.L207:
	bl G_Spawn
	lwz 0,0(27)
	mr 29,3
	mr 4,27
	stw 0,280(29)
	bl SpawnItem
	mr 4,31
	mr 3,29
	li 5,0
	li 6,0
	bl Touch_Item
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L160
	mr 3,29
	bl G_FreeEdict
.L160:
	lwz 0,52(1)
	lwz 12,20(1)
	mtlr 0
	lmw 26,24(1)
	mtcrf 8,12
	la 1,48(1)
	blr
.Lfe10:
	.size	 Cmd_Give_f,.Lfe10-Cmd_Give_f
	.section	".rodata"
	.align 2
.LC56:
	.string	"godmode OFF\n"
	.align 2
.LC57:
	.string	"godmode ON\n"
	.align 2
.LC58:
	.string	"notarget OFF\n"
	.align 2
.LC59:
	.string	"notarget ON\n"
	.align 2
.LC60:
	.string	"noclip OFF\n"
	.align 2
.LC61:
	.string	"noclip ON\n"
	.align 2
.LC62:
	.string	"unknown item: %s\n"
	.align 2
.LC63:
	.string	"Item is not usable.\n"
	.align 2
.LC64:
	.string	"Out of item: %s\n"
	.align 2
.LC65:
	.string	"Item is not dropable.\n"
	.align 2
.LC66:
	.string	"No item to use.\n"
	.section	".text"
	.align 2
	.globl Cmd_InvUse_f
	.type	 Cmd_InvUse_f,@function
Cmd_InvUse_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 7,84(31)
	lwz 11,736(7)
	addi 10,7,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L242
	lwz 0,3796(7)
	cmpwi 0,0,0
	bc 12,2,.L243
	bl ChaseNext
	b .L242
.L255:
	stw 11,736(7)
	b .L242
.L243:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L256:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L249
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L249
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L255
.L249:
	addi 8,8,1
	bdnz .L256
	li 0,-1
	stw 0,736(7)
.L242:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L253
	lis 9,gi+8@ha
	lis 5,.LC66@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC66@l(5)
	b .L257
.L253:
	mulli 0,0,76
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,8(4)
	cmpwi 0,0,0
	bc 4,2,.L254
	lis 9,gi+8@ha
	lis 5,.LC63@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC63@l(5)
.L257:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L240
.L254:
	mr 3,31
	mtlr 0
	blrl
.L240:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe11:
	.size	 Cmd_InvUse_f,.Lfe11-Cmd_InvUse_f
	.section	".rodata"
	.align 2
.LC67:
	.string	"No item to drop.\n"
	.section	".text"
	.align 2
	.globl Cmd_InvDrop_f
	.type	 Cmd_InvDrop_f,@function
Cmd_InvDrop_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lwz 7,84(31)
	lwz 11,736(7)
	addi 10,7,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L288
	lwz 0,3796(7)
	cmpwi 0,0,0
	bc 12,2,.L289
	bl ChaseNext
	b .L288
.L301:
	stw 11,736(7)
	b .L288
.L289:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L302:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L295
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L295
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L301
.L295:
	addi 8,8,1
	bdnz .L302
	li 0,-1
	stw 0,736(7)
.L288:
	lwz 9,84(31)
	lwz 0,736(9)
	cmpwi 0,0,-1
	bc 4,2,.L299
	lis 9,gi+8@ha
	lis 5,.LC67@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC67@l(5)
	b .L303
.L299:
	mulli 0,0,76
	lis 9,itemlist@ha
	la 9,itemlist@l(9)
	add 4,0,9
	lwz 0,12(4)
	cmpwi 0,0,0
	bc 4,2,.L300
	lis 9,gi+8@ha
	lis 5,.LC65@ha
	lwz 0,gi+8@l(9)
	mr 3,31
	la 5,.LC65@l(5)
.L303:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L286
.L300:
	mr 3,31
	mtlr 0
	blrl
.L286:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe12:
	.size	 Cmd_InvDrop_f,.Lfe12-Cmd_InvDrop_f
	.section	".rodata"
	.align 2
.LC68:
	.string	"%3i %s\n"
	.align 2
.LC69:
	.string	"...\n"
	.align 2
.LC70:
	.string	"%s\n%i players\n"
	.align 2
.LC71:
	.long 0x0
	.align 3
.LC72:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_Players_f
	.type	 Cmd_Players_f,@function
Cmd_Players_f:
	stwu 1,-2432(1)
	mflr 0
	stmw 23,2396(1)
	stw 0,2436(1)
	lis 11,.LC71@ha
	lis 9,maxclients@ha
	la 11,.LC71@l(11)
	mr 23,3
	lfs 13,0(11)
	li 27,0
	li 31,0
	lwz 11,maxclients@l(9)
	addi 29,1,1352
	addi 30,1,72
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L313
	lis 9,game+1028@ha
	mr 8,11
	lwz 11,game+1028@l(9)
	lis 7,0x4330
	mr 10,29
	lis 9,.LC72@ha
	la 9,.LC72@l(9)
	addi 11,11,720
	lfd 12,0(9)
.L315:
	lwz 0,0(11)
	addi 11,11,3804
	cmpwi 0,0,0
	bc 12,2,.L314
	stw 31,0(10)
	addi 27,27,1
	addi 10,10,4
.L314:
	addi 31,31,1
	lfs 13,20(8)
	xoris 0,31,0x8000
	stw 0,2388(1)
	stw 7,2384(1)
	lfd 0,2384(1)
	fsub 0,0,12
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L315
.L313:
	lis 6,PlayerSort@ha
	mr 3,29
	la 6,PlayerSort@l(6)
	mr 4,27
	li 5,4
	li 31,0
	bl qsort
	cmpw 0,31,27
	li 0,0
	stb 0,72(1)
	bc 4,0,.L319
	lis 9,game@ha
	mr 28,29
	la 24,game@l(9)
	lis 26,.LC68@ha
	lis 25,.LC69@ha
.L321:
	lwz 7,0(28)
	addi 3,1,8
	li 4,64
	lwz 0,1028(24)
	la 5,.LC68@l(26)
	addi 28,28,4
	mulli 7,7,3804
	add 7,7,0
	lha 6,148(7)
	addi 7,7,700
	crxor 6,6,6
	bl Com_sprintf
	addi 3,1,8
	bl strlen
	mr 29,3
	mr 3,30
	bl strlen
	add 29,29,3
	cmplwi 0,29,1180
	bc 4,1,.L322
	la 4,.LC69@l(25)
	mr 3,30
	bl strcat
	b .L319
.L322:
	mr 3,30
	addi 4,1,8
	bl strcat
	addi 31,31,1
	cmpw 0,31,27
	bc 12,0,.L321
.L319:
	lis 9,gi+8@ha
	lis 5,.LC70@ha
	lwz 0,gi+8@l(9)
	mr 3,23
	la 5,.LC70@l(5)
	mr 6,30
	mr 7,27
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,2436(1)
	mtlr 0
	lmw 23,2396(1)
	la 1,2432(1)
	blr
.Lfe13:
	.size	 Cmd_Players_f,.Lfe13-Cmd_Players_f
	.section	".rodata"
	.align 2
.LC73:
	.string	"flipoff\n"
	.align 2
.LC74:
	.string	"salute\n"
	.align 2
.LC75:
	.string	"taunt\n"
	.align 2
.LC76:
	.string	"wave\n"
	.align 2
.LC77:
	.string	"point\n"
	.section	".text"
	.align 2
	.globl Cmd_Wave_f
	.type	 Cmd_Wave_f,@function
Cmd_Wave_f:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,gi+160@ha
	mr 31,3
	lwz 0,gi+160@l(9)
	li 3,1
	mtlr 0
	blrl
	bl atoi
	lwz 9,84(31)
	lbz 0,16(9)
	andi. 11,0,1
	bc 4,2,.L324
	lwz 0,3696(9)
	cmpwi 0,0,1
	bc 12,1,.L324
	cmplwi 0,3,4
	li 0,1
	stw 0,3696(9)
	bc 12,1,.L333
	lis 11,.L334@ha
	slwi 10,3,2
	la 11,.L334@l(11)
	lis 9,.L334@ha
	lwzx 0,10,11
	la 9,.L334@l(9)
	add 0,0,9
	mtctr 0
	bctr
	.align 2
	.align 2
.L334:
	.long .L328-.L334
	.long .L329-.L334
	.long .L330-.L334
	.long .L331-.L334
	.long .L333-.L334
.L328:
	lis 9,gi+8@ha
	lis 5,.LC73@ha
	lwz 0,gi+8@l(9)
	la 5,.LC73@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,71
	li 9,83
	b .L335
.L329:
	lis 9,gi+8@ha
	lis 5,.LC74@ha
	lwz 0,gi+8@l(9)
	la 5,.LC74@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,83
	li 9,94
	b .L335
.L330:
	lis 9,gi+8@ha
	lis 5,.LC75@ha
	lwz 0,gi+8@l(9)
	la 5,.LC75@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,94
	li 9,111
	b .L335
.L331:
	lis 9,gi+8@ha
	lis 5,.LC76@ha
	lwz 0,gi+8@l(9)
	la 5,.LC76@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,111
	li 9,122
	b .L335
.L333:
	lis 9,gi+8@ha
	lis 5,.LC77@ha
	lwz 0,gi+8@l(9)
	la 5,.LC77@l(5)
	mr 3,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 11,84(31)
	li 0,122
	li 9,134
.L335:
	stw 0,56(31)
	stw 9,3692(11)
.L324:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe14:
	.size	 Cmd_Wave_f,.Lfe14-Cmd_Wave_f
	.section	".rodata"
	.align 2
.LC78:
	.string	"(%s): "
	.align 2
.LC79:
	.string	"%s: "
	.align 2
.LC80:
	.string	" "
	.align 2
.LC81:
	.string	"\n"
	.align 2
.LC82:
	.string	"You can't talk for %d more seconds\n"
	.align 2
.LC83:
	.string	"Flood protection:  You can't talk for %d seconds.\n"
	.align 2
.LC84:
	.long 0x0
	.align 3
.LC85:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC86:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl Cmd_Say_f
	.type	 Cmd_Say_f,@function
Cmd_Say_f:
	stwu 1,-2112(1)
	mflr 0
	mfcr 12
	stmw 24,2080(1)
	stw 0,2116(1)
	stw 12,2076(1)
	lis 9,gi+156@ha
	mr 28,3
	lwz 0,gi+156@l(9)
	mr 30,4
	mr 31,5
	mtlr 0
	blrl
	cmpwi 0,3,1
	bc 12,1,.L337
	cmpwi 0,31,0
	bc 12,2,.L336
.L337:
	lis 10,dmflags@ha
	lwz 11,dmflags@l(10)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,2064(1)
	lwz 9,2068(1)
	rlwinm 9,9,0,24,25
	neg 9,9
	srawi 9,9,31
	and. 30,30,9
	bc 12,2,.L339
	lwz 6,84(28)
	lis 5,.LC78@ha
	addi 3,1,8
	la 5,.LC78@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
	b .L340
.L339:
	lwz 6,84(28)
	lis 5,.LC79@ha
	addi 3,1,8
	la 5,.LC79@l(5)
	li 4,2048
	addi 6,6,700
	crxor 6,6,6
	bl Com_sprintf
.L340:
	cmpwi 0,31,0
	bc 12,2,.L341
	lis 29,gi@ha
	li 3,0
	la 29,gi@l(29)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	lis 4,.LC80@ha
	addi 3,1,8
	la 4,.LC80@l(4)
	bl strcat
	lwz 0,164(29)
	mtlr 0
	blrl
	mr 4,3
	addi 3,1,8
	bl strcat
	b .L342
.L341:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 29,3
	lbz 0,0(29)
	cmpwi 0,0,34
	bc 4,2,.L343
	addi 29,29,1
	mr 3,29
	bl strlen
	add 3,3,29
	stb 31,-1(3)
.L343:
	mr 4,29
	addi 3,1,8
	bl strcat
.L342:
	addi 3,1,8
	bl strlen
	cmplwi 0,3,150
	bc 4,1,.L344
	li 0,0
	stb 0,158(1)
.L344:
	lis 4,.LC81@ha
	addi 3,1,8
	la 4,.LC81@l(4)
	bl strcat
	lis 9,.LC84@ha
	la 9,.LC84@l(9)
	lfs 8,0(9)
	lis 9,flood_msgs@ha
	lwz 11,flood_msgs@l(9)
	lfs 9,20(11)
	fcmpu 0,9,8
	bc 12,2,.L345
	lwz 7,84(28)
	lis 9,level+4@ha
	lfs 10,level+4@l(9)
	lfs 0,3744(7)
	fcmpu 0,10,0
	bc 4,0,.L346
	fsubs 0,0,10
	lis 9,gi+8@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC82@ha
	mr 3,28
	la 5,.LC82@l(5)
	li 4,2
	mtlr 0
	fctiwz 13,0
	stfd 13,2064(1)
	b .L359
.L346:
	lwz 0,3788(7)
	lis 10,0x4330
	lis 11,.LC85@ha
	addi 8,7,3748
	mr 6,0
	la 11,.LC85@l(11)
	xoris 0,0,0x8000
	lfd 13,0(11)
	stw 0,2068(1)
	lis 11,.LC86@ha
	stw 10,2064(1)
	la 11,.LC86@l(11)
	lfd 0,2064(1)
	mr 10,8
	lfs 11,0(11)
	mr 11,9
	fsub 0,0,13
	frsp 0,0
	fsubs 0,0,9
	fadds 0,0,11
	fmr 13,0
	fctiwz 12,13
	stfd 12,2064(1)
	lwz 11,2068(1)
	nor 0,11,11
	addi 9,11,10
	srawi 0,0,31
	andc 9,9,0
	and 11,11,0
	or 11,11,9
	slwi 11,11,2
	lfsx 0,8,11
	fcmpu 0,0,8
	bc 12,2,.L348
	lis 11,flood_persecond@ha
	fsubs 13,10,0
	lwz 9,flood_persecond@l(11)
	lfs 0,20(9)
	fcmpu 0,13,0
	bc 4,0,.L348
	lis 9,flood_waitdelay@ha
	lis 10,gi+8@ha
	lwz 11,flood_waitdelay@l(9)
	lis 5,.LC83@ha
	mr 3,28
	la 5,.LC83@l(5)
	lfs 13,20(11)
	li 4,3
	fadds 13,10,13
	stfs 13,3744(7)
	lfs 0,20(11)
	lwz 0,gi+8@l(10)
	mtlr 0
	fctiwz 12,0
	stfd 12,2064(1)
.L359:
	lwz 6,2068(1)
	crxor 6,6,6
	blrl
	b .L336
.L348:
	lis 0,0xcccc
	addi 9,6,1
	ori 0,0,52429
	lis 11,level+4@ha
	mulhwu 0,9,0
	srwi 0,0,3
	mulli 0,0,10
	subf 9,0,9
	stw 9,3788(7)
	lfs 0,level+4@l(11)
	slwi 9,9,2
	stfsx 0,10,9
.L345:
	lis 9,.LC84@ha
	lis 11,dedicated@ha
	la 9,.LC84@l(9)
	lfs 13,0(9)
	lwz 9,dedicated@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L349
	lis 9,gi+8@ha
	lis 5,.LC16@ha
	lwz 0,gi+8@l(9)
	la 5,.LC16@l(5)
	li 3,0
	li 4,3
	addi 6,1,8
	mtlr 0
	crxor 6,6,6
	blrl
.L349:
	lis 9,game@ha
	li 31,1
	la 11,game@l(9)
	lwz 0,1544(11)
	cmpw 0,31,0
	bc 12,1,.L336
	cmpwi 4,30,0
	lis 9,gi@ha
	la 24,gi@l(9)
	mr 25,11
	lis 26,g_edicts@ha
	lis 27,.LC16@ha
	li 30,992
.L353:
	lwz 0,g_edicts@l(26)
	add 29,0,30
	lwz 9,88(29)
	cmpwi 0,9,0
	bc 12,2,.L352
	lwz 0,84(29)
	cmpwi 0,0,0
	bc 12,2,.L352
	bc 12,18,.L356
	mr 3,28
	mr 4,29
	bl OnSameTeam
	cmpwi 0,3,0
	bc 12,2,.L352
.L356:
	lwz 9,8(24)
	mr 3,29
	li 4,3
	la 5,.LC16@l(27)
	addi 6,1,8
	mtlr 9
	crxor 6,6,6
	blrl
.L352:
	lwz 0,1544(25)
	addi 31,31,1
	addi 30,30,992
	cmpw 0,31,0
	bc 4,1,.L353
.L336:
	lwz 0,2116(1)
	lwz 12,2076(1)
	mtlr 0
	lmw 24,2080(1)
	mtcrf 8,12
	la 1,2112(1)
	blr
.Lfe15:
	.size	 Cmd_Say_f,.Lfe15-Cmd_Say_f
	.section	".rodata"
	.align 2
.LC87:
	.string	"Monster Awaiting move order\n"
	.align 2
.LC88:
	.long 0x459c4000
	.align 3
.LC89:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC90:
	.long 0x46000000
	.section	".text"
	.align 2
	.globl Cmd_MonsterMove_f
	.type	 Cmd_MonsterMove_f,@function
Cmd_MonsterMove_f:
	stwu 1,-160(1)
	mflr 0
	stmw 27,140(1)
	stw 0,164(1)
	lis 28,gi@ha
	mr 29,3
	la 28,gi@l(28)
	lis 5,.LC87@ha
	lwz 9,8(28)
	la 5,.LC87@l(5)
	li 4,2
	addi 31,1,24
	mtlr 9
	addi 27,1,40
	crxor 6,6,6
	blrl
	lwz 0,604(29)
	lis 11,0x4330
	lis 10,.LC89@ha
	lfs 13,12(29)
	li 6,0
	xoris 0,0,0x8000
	la 10,.LC89@l(10)
	lfs 10,4(29)
	stw 0,132(1)
	mr 4,31
	li 5,0
	stw 11,128(1)
	lfd 0,128(1)
	lfd 11,0(10)
	lfs 12,8(29)
	lwz 3,84(29)
	fsub 0,0,11
	stfs 10,8(1)
	stfs 12,12(1)
	addi 3,3,3636
	frsp 0,0
	fadds 13,13,0
	stfs 13,16(1)
	bl AngleVectors
	lis 9,.LC90@ha
	addi 3,1,8
	la 9,.LC90@l(9)
	mr 4,31
	lfs 1,0(9)
	mr 5,27
	bl VectorMA
	lwz 0,48(28)
	lis 9,0x600
	mr 7,27
	ori 9,9,3
	mr 8,29
	addi 3,1,56
	addi 4,1,8
	mtlr 0
	li 5,0
	li 6,0
	blrl
	lwz 9,108(1)
	cmpwi 0,9,0
	bc 12,2,.L361
	lwz 0,184(9)
	andi. 10,0,4
	bc 4,2,.L362
	lwz 0,84(9)
	cmpwi 0,0,0
	bc 12,2,.L361
.L362:
	lis 9,.LC88@ha
	mr 3,31
	lfs 1,.LC88@l(9)
	mr 4,3
	bl VectorScale
	lwz 9,108(1)
	lfs 0,24(1)
	lfs 13,472(9)
	fadds 0,0,13
	stfs 0,472(9)
	lwz 11,108(1)
	lfs 0,28(1)
	lfs 13,476(11)
	fadds 0,0,13
	stfs 0,476(11)
	lwz 9,108(1)
	lfs 0,32(1)
	lfs 13,480(9)
	fadds 0,0,13
	stfs 0,480(9)
.L361:
	lwz 0,164(1)
	mtlr 0
	lmw 27,140(1)
	la 1,160(1)
	blr
.Lfe16:
	.size	 Cmd_MonsterMove_f,.Lfe16-Cmd_MonsterMove_f
	.section	".rodata"
	.align 2
.LC91:
	.string	"%02d:%02d %4d %3d %s%s\n"
	.align 2
.LC92:
	.string	" (spectator)"
	.align 2
.LC93:
	.string	""
	.align 2
.LC94:
	.string	"And more...\n"
	.align 2
.LC95:
	.long 0x0
	.align 3
.LC96:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl Cmd_PlayerList_f
	.type	 Cmd_PlayerList_f,@function
Cmd_PlayerList_f:
	stwu 1,-1568(1)
	mflr 0
	stmw 20,1520(1)
	stw 0,1572(1)
	lis 9,maxclients@ha
	li 0,0
	lwz 11,maxclients@l(9)
	lis 10,g_edicts@ha
	mr 27,3
	lis 9,.LC95@ha
	stb 0,96(1)
	li 28,0
	la 9,.LC95@l(9)
	lfs 0,20(11)
	lis 22,maxclients@ha
	lfs 13,0(9)
	addi 31,1,96
	lis 21,gi@ha
	lwz 9,g_edicts@l(10)
	lis 20,.LC16@ha
	fcmpu 0,13,0
	addi 30,9,992
	bc 4,0,.L365
	lis 9,.LC92@ha
	lis 11,.LC93@ha
	la 23,.LC92@l(9)
	la 24,.LC93@l(11)
	lis 25,level@ha
	lis 26,0x4330
.L367:
	lwz 0,88(30)
	cmpwi 0,0,0
	bc 12,2,.L366
	lwz 10,84(30)
	lis 11,0x1b4e
	lis 8,0x6666
	lwz 9,level@l(25)
	ori 11,11,33205
	ori 8,8,26215
	lwz 0,3444(10)
	addi 29,10,700
	lwz 7,3464(10)
	subf 9,0,9
	lwz 3,184(10)
	mulhw 11,9,11
	lwz 4,3448(10)
	cmpwi 0,7,0
	srawi 10,9,31
	srawi 11,11,6
	subf 6,10,11
	mulli 0,6,600
	subf 9,0,9
	mulhw 8,9,8
	srawi 9,9,31
	srawi 8,8,2
	subf 7,9,8
	bc 12,2,.L369
	stw 23,8(1)
	b .L370
.L369:
	stw 24,8(1)
.L370:
	mr 8,3
	mr 9,4
	lis 5,.LC91@ha
	mr 10,29
	addi 3,1,16
	la 5,.LC91@l(5)
	li 4,80
	crxor 6,6,6
	bl Com_sprintf
	mr 3,31
	bl strlen
	mr 29,3
	addi 3,1,16
	bl strlen
	add 29,29,3
	cmplwi 0,29,1350
	bc 4,1,.L371
	mr 3,31
	bl strlen
	lis 4,.LC94@ha
	add 3,31,3
	la 4,.LC94@l(4)
	crxor 6,6,6
	bl sprintf
	la 9,gi@l(21)
	mr 3,27
	lwz 0,8(9)
	la 5,.LC16@l(20)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L363
.L371:
	mr 3,31
	addi 4,1,16
	bl strcat
.L366:
	addi 28,28,1
	lwz 11,maxclients@l(22)
	xoris 0,28,0x8000
	lis 10,.LC96@ha
	stw 0,1516(1)
	la 10,.LC96@l(10)
	addi 30,30,992
	stw 26,1512(1)
	lfd 13,0(10)
	lfd 0,1512(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 12,0,.L367
.L365:
	lis 9,gi+8@ha
	lis 5,.LC16@ha
	lwz 0,gi+8@l(9)
	mr 3,27
	la 5,.LC16@l(5)
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L363:
	lwz 0,1572(1)
	mtlr 0
	lmw 20,1520(1)
	la 1,1568(1)
	blr
.Lfe17:
	.size	 Cmd_PlayerList_f,.Lfe17-Cmd_PlayerList_f
	.section	".rodata"
	.align 2
.LC97:
	.string	"quad"
	.align 2
.LC98:
	.string	"megahealth"
	.align 2
.LC99:
	.string	"barrel"
	.align 2
.LC100:
	.string	"You will spawn with perma quad when you die\n"
	.align 2
.LC101:
	.string	"regeneration"
	.align 2
.LC102:
	.string	"You will regenerate yourself after you die\n"
	.align 2
.LC103:
	.string	"You will spawn with full ammo after you die\n"
	.align 2
.LC104:
	.string	"say"
	.align 2
.LC105:
	.string	"say_team"
	.align 2
.LC106:
	.string	"players"
	.align 2
.LC107:
	.string	"id"
	.align 2
.LC108:
	.string	"score"
	.align 2
.LC109:
	.string	"help"
	.align 2
.LC110:
	.string	"special"
	.align 2
.LC111:
	.string	"nogameleader"
	.align 2
.LC112:
	.string	"Now you can't be selected as gameleader(This map).\n"
	.align 2
.LC113:
	.string	"Now you can be selected as gameleader.\n"
	.align 2
.LC114:
	.string	"gameleader"
	.align 2
.LC115:
	.string	"You are already a player.\n"
	.align 2
.LC116:
	.string	"There can be only one GameLeader.\n"
	.align 2
.LC117:
	.string	"Gameleader is %s.\n"
	.align 2
.LC118:
	.string	"player"
	.align 2
.LC119:
	.string	"You were Gameleader, changed to player.\n"
	.align 2
.LC120:
	.string	"%s is now player.\n"
	.align 2
.LC121:
	.string	"glicarus"
	.align 2
.LC122:
	.string	"Returning to normal state.\n"
	.align 2
.LC123:
	.string	"You cannot spawn outside level!\n"
	.align 2
.LC124:
	.string	"HyperBlaster"
	.align 2
.LC125:
	.string	"Your mental energies are recharging ,wait for : %i seconds.\n"
	.align 2
.LC126:
	.string	"thup"
	.align 2
.LC127:
	.string	"thdown"
	.align 2
.LC128:
	.string	"move"
	.align 2
.LC129:
	.string	"trap"
	.align 2
.LC130:
	.string	"teleporter"
	.align 2
.LC131:
	.string	"mine"
	.align 2
.LC132:
	.string	"push"
	.align 2
.LC133:
	.string	"berserk"
	.align 2
.LC134:
	.string	"makron"
	.align 2
.LC135:
	.string	"jorg"
	.align 2
.LC136:
	.string	"flyboss"
	.align 2
.LC137:
	.string	"icarus"
	.align 2
.LC138:
	.string	"target"
	.align 2
.LC139:
	.string	"escort"
	.align 2
.LC140:
	.string	"patrol"
	.align 2
.LC141:
	.string	"follow"
	.align 2
.LC142:
	.string	"Monsters follow turned on.\n"
	.align 2
.LC143:
	.string	"Monsters follow turned off.\n"
	.align 2
.LC144:
	.string	"soldier_ss"
	.align 2
.LC145:
	.string	"flipper"
	.align 2
.LC146:
	.string	"supertank"
	.align 2
.LC147:
	.string	"tank"
	.align 2
.LC148:
	.string	"tankcommander"
	.align 2
.LC149:
	.string	"medic"
	.align 2
.LC150:
	.string	"mutant"
	.align 2
.LC151:
	.string	"soldier"
	.align 2
.LC152:
	.string	"soldier_light"
	.align 2
.LC153:
	.string	"parasite"
	.align 2
.LC154:
	.string	"enforcer"
	.align 2
.LC155:
	.string	"brains"
	.align 2
.LC156:
	.string	"chick"
	.align 2
.LC157:
	.string	"gunner"
	.align 2
.LC158:
	.string	"gladiator"
	.align 2
.LC159:
	.string	"flyer"
	.align 2
.LC160:
	.string	"floater"
	.align 2
.LC161:
	.string	"use"
	.align 2
.LC162:
	.string	"drop"
	.align 2
.LC163:
	.string	"give"
	.align 2
.LC164:
	.string	"god"
	.align 2
.LC165:
	.string	"notarget"
	.align 2
.LC166:
	.string	"inven"
	.align 2
.LC167:
	.string	"invnext"
	.align 2
.LC168:
	.string	"invprev"
	.align 2
.LC169:
	.string	"invnextw"
	.align 2
.LC170:
	.string	"invprevw"
	.align 2
.LC171:
	.string	"invnextp"
	.align 2
.LC172:
	.string	"invprevp"
	.align 2
.LC173:
	.string	"invuse"
	.align 2
.LC174:
	.string	"invdrop"
	.align 2
.LC175:
	.string	"weapprev"
	.align 2
.LC176:
	.string	"weapnext"
	.align 2
.LC177:
	.string	"weaplast"
	.align 2
.LC178:
	.string	"kill"
	.align 2
.LC179:
	.string	"putaway"
	.align 2
.LC180:
	.string	"wave"
	.align 2
.LC181:
	.string	"playerlist"
	.align 2
.LC182:
	.string	"maplist"
	.align 2
.LC183:
	.string	"flashlight"
	.align 2
.LC184:
	.long 0x0
	.align 3
.LC185:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC186:
	.long 0x41c80000
	.align 2
.LC187:
	.long 0x41f00000
	.align 2
.LC188:
	.long 0x43960000
	.align 2
.LC189:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl ClientCommand
	.type	 ClientCommand,@function
ClientCommand:
	stwu 1,-176(1)
	mflr 0
	stfd 31,168(1)
	stmw 14,96(1)
	stw 0,180(1)
	mr 30,3
	lwz 0,84(30)
	cmpwi 0,0,0
	bc 12,2,.L387
	lis 9,gi@ha
	li 3,0
	la 29,gi@l(9)
	lwz 9,160(29)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC104@ha
	la 4,.LC104@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L389
	mr 3,30
	li 4,0
	b .L838
.L389:
	lis 4,.LC105@ha
	mr 3,31
	la 4,.LC105@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L390
	mr 3,30
	li 4,1
.L838:
	li 5,0
	bl Cmd_Say_f
	b .L387
.L390:
	lis 4,.LC106@ha
	mr 3,31
	la 4,.LC106@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L391
	mr 3,30
	bl Cmd_Players_f
	b .L387
.L391:
	lis 4,.LC107@ha
	mr 3,31
	la 4,.LC107@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L392
	mr 3,30
	bl Cmd_id_f
	b .L387
.L392:
	lis 4,.LC108@ha
	mr 3,31
	la 4,.LC108@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L393
	mr 3,30
	bl Cmd_Score_f
	b .L387
.L393:
	lis 4,.LC109@ha
	mr 3,31
	la 4,.LC109@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L394
	mr 3,30
	bl Cmd_Help_f
	b .L387
.L394:
	lis 4,.LC110@ha
	mr 3,31
	la 4,.LC110@l(4)
	bl Q_stricmp
	mr. 28,3
	bc 4,2,.L395
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 31,3
	lis 4,.LC97@ha
	la 4,.LC97@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L396
	li 0,1
	lis 5,.LC100@ha
	stw 0,352(30)
	mr 3,30
	la 5,.LC100@l(5)
	lwz 0,8(29)
	b .L839
.L396:
	lis 4,.LC101@ha
	mr 3,31
	la 4,.LC101@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L398
	li 0,2
	lis 5,.LC102@ha
	stw 0,352(30)
	mr 3,30
	la 5,.LC102@l(5)
	lwz 0,8(29)
	b .L839
.L398:
	lis 4,.LC47@ha
	mr 3,31
	la 4,.LC47@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L400
	li 0,3
	lis 5,.LC103@ha
	stw 0,352(30)
	mr 3,30
	la 5,.LC103@l(5)
	lwz 0,8(29)
	b .L839
.L400:
	stw 28,352(30)
	b .L387
.L395:
	lis 4,.LC111@ha
	mr 3,31
	la 4,.LC111@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L403
	lwz 9,380(30)
	addi 9,9,1
	cmpwi 0,9,1
	stw 9,380(30)
	bc 4,1,.L404
	stw 3,380(30)
.L404:
	lwz 0,380(30)
	cmpwi 0,0,1
	bc 4,2,.L405
	lwz 0,8(29)
	lis 5,.LC112@ha
	mr 3,30
	la 5,.LC112@l(5)
	b .L839
.L405:
	lis 9,gi+8@ha
	lis 5,.LC113@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC113@l(5)
	b .L839
.L403:
	lis 9,level@ha
	la 28,level@l(9)
	lwz 0,8(28)
	cmpwi 0,0,3
	bc 12,2,.L408
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,88(1)
	lwz 11,92(1)
	andis. 0,11,1
	bc 12,2,.L407
.L408:
	lis 4,.LC114@ha
	mr 3,31
	la 4,.LC114@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L407
	lwz 0,292(30)
	cmpwi 0,0,1
	bc 4,2,.L410
	lwz 0,8(29)
	lis 5,.LC115@ha
	mr 3,30
	la 5,.LC115@l(5)
	b .L839
.L410:
	lwz 0,20(28)
	cmpwi 0,0,1
	bc 4,2,.L411
	lis 9,gi+8@ha
	lis 5,.LC116@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC116@l(5)
	b .L839
.L411:
	lis 9,maxclients@ha
	lis 8,.LC184@ha
	lwz 11,maxclients@l(9)
	la 8,.LC184@l(8)
	li 31,0
	lfs 13,0(8)
	lis 24,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L414
	lis 9,gi@ha
	lis 25,g_edicts@ha
	la 26,gi@l(9)
	lis 27,.LC117@ha
	lis 9,.LC185@ha
	lis 28,0x4330
	la 9,.LC185@l(9)
	li 29,992
	lfd 31,0(9)
.L416:
	lwz 0,g_edicts@l(25)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L415
	lwz 6,84(30)
	li 4,2
	la 5,.LC117@l(27)
	lwz 9,8(26)
	addi 6,6,700
	mtlr 9
	crxor 6,6,6
	blrl
.L415:
	addi 31,31,1
	lwz 11,maxclients@l(24)
	xoris 0,31,0x8000
	addi 29,29,992
	stw 0,92(1)
	stw 28,88(1)
	lfd 0,88(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L416
.L414:
	lwz 9,64(30)
	li 11,1
	li 10,0
	lwz 0,184(30)
	lis 8,level+20@ha
	oris 9,9,0x2
	stw 10,292(30)
	rlwinm 0,0,0,0,30
	stw 9,64(30)
	stw 0,184(30)
	stw 11,260(30)
	stw 11,320(30)
	stw 11,level+20@l(8)
	b .L387
.L407:
	lis 9,level+8@ha
	lwz 0,level+8@l(9)
	cmpwi 0,0,3
	bc 12,2,.L420
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,88(1)
	lwz 11,92(1)
	andis. 0,11,1
	bc 12,2,.L419
.L420:
	lis 4,.LC118@ha
	mr 3,31
	la 4,.LC118@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L419
	lwz 0,320(30)
	cmpwi 0,0,0
	bc 12,1,.L387
	lwz 0,292(30)
	cmpwi 0,0,0
	bc 4,1,.L424
	lis 9,gi+8@ha
	lis 5,.LC115@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC115@l(5)
	b .L839
.L424:
	lis 9,maxclients@ha
	lis 8,.LC184@ha
	lwz 11,maxclients@l(9)
	la 8,.LC184@l(8)
	li 31,0
	lfs 13,0(8)
	lis 24,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,13,0
	bc 4,0,.L426
	lis 9,gi@ha
	lis 25,g_edicts@ha
	la 26,gi@l(9)
	lis 27,.LC120@ha
	lis 9,.LC185@ha
	lis 28,0x4330
	la 9,.LC185@l(9)
	li 29,992
	lfd 31,0(9)
.L428:
	lwz 0,g_edicts@l(25)
	add 3,0,29
	lwz 9,88(3)
	cmpwi 0,9,0
	bc 12,2,.L427
	lwz 6,84(30)
	li 4,2
	la 5,.LC120@l(27)
	lwz 9,8(26)
	addi 6,6,700
	mtlr 9
	crxor 6,6,6
	blrl
.L427:
	addi 31,31,1
	lwz 11,maxclients@l(24)
	xoris 0,31,0x8000
	addi 29,29,992
	stw 0,92(1)
	stw 28,88(1)
	lfd 0,88(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	bc 12,0,.L428
.L426:
	li 0,1
	mr 3,30
	stw 0,292(30)
	bl respawn
	b .L387
.L419:
	lwz 0,320(30)
	cmpwi 0,0,0
	bc 4,1,.L431
	lis 4,.LC121@ha
	mr 3,31
	la 4,.LC121@l(4)
	bl Q_stricmp
	mr. 28,3
	bc 4,2,.L432
	lwz 0,320(30)
	cmpwi 0,0,2
	bc 4,2,.L433
	lis 9,gi+8@ha
	lis 5,.LC122@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC122@l(5)
	li 4,2
	li 29,1
	mtlr 0
	crxor 6,6,6
	blrl
	lis 8,.LC186@ha
	lis 11,level+4@ha
	stw 29,320(30)
	la 8,.LC186@l(8)
	lfs 0,level+4@l(11)
	lfs 12,0(8)
	lis 3,.LC36@ha
	la 3,.LC36@l(3)
	fadds 0,0,12
	fctiwz 13,0
	stfd 13,88(1)
	lwz 9,92(1)
	stw 9,336(30)
	bl FindItem
	lwz 11,84(30)
	mr 31,3
	li 0,100
	stw 31,1788(11)
	lwz 9,84(30)
	stw 31,3532(9)
	lwz 11,84(30)
	stw 29,260(30)
	stw 28,248(30)
	stw 28,88(11)
	lwz 9,84(30)
	stw 28,3736(9)
	stw 0,576(30)
	b .L387
.L433:
	lwz 0,336(30)
	lis 10,0x4330
	lis 8,.LC185@ha
	lis 11,level+4@ha
	xoris 0,0,0x8000
	la 8,.LC185@l(8)
	lfs 12,level+4@l(11)
	stw 0,92(1)
	stw 10,88(1)
	lfd 13,0(8)
	lfd 0,88(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	bc 4,0,.L434
	lwz 11,84(30)
	lis 9,gi@ha
	addi 3,1,8
	lfs 13,4(30)
	la 29,gi@l(9)
	lfs 0,40(11)
	lfs 12,8(30)
	lfs 11,12(30)
	fadds 13,13,0
	lwz 9,52(29)
	mtlr 9
	stfs 13,8(1)
	lfs 0,44(11)
	fadds 12,12,0
	stfs 12,12(1)
	lfs 0,48(11)
	fadds 11,11,0
	stfs 11,16(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L435
	lwz 0,8(29)
	lis 5,.LC123@ha
	mr 3,30
	la 5,.LC123@l(5)
	b .L839
.L435:
	lwz 11,84(30)
	lis 9,.LC36@ha
	addi 3,1,24
	lfs 13,4(30)
	la 31,.LC36@l(9)
	lfs 0,40(11)
	lfs 12,8(30)
	lfs 11,12(30)
	fadds 13,13,0
	lwz 9,52(29)
	mtlr 9
	stfs 13,24(1)
	lfs 0,44(11)
	fadds 12,12,0
	stfs 12,28(1)
	lfs 0,48(11)
	fadds 11,11,0
	stfs 11,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L437
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L438
.L437:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,15
	bc 4,0,.L439
	lwz 0,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	li 26,0
	crxor 6,6,6
	blrl
	b .L438
.L439:
	mr 3,30
	li 4,150
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L441
	li 26,0
	b .L438
.L441:
	lwz 11,84(30)
	li 26,1
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-15
	stwx 9,11,31
.L438:
	cmpwi 0,26,0
	bc 12,2,.L387
	li 0,2
	li 9,100
	li 11,4
	li 10,22
	stw 9,576(30)
	lis 3,.LC124@ha
	stw 11,260(30)
	stw 0,608(30)
	la 3,.LC124@l(3)
	stw 0,320(30)
	stw 0,248(30)
	stw 10,604(30)
	bl FindItem
	lwz 11,84(30)
	mr 31,3
	stw 31,1788(11)
	lwz 9,84(30)
	stw 31,3532(9)
	lwz 11,84(30)
	lwz 0,1788(11)
	cmpw 0,0,31
	bc 4,2,.L443
	lis 9,gi+32@ha
	lwz 3,32(31)
	lwz 0,gi+32@l(9)
	mtlr 0
	blrl
	lwz 9,84(30)
	stw 3,88(9)
.L443:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 10,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,31
	lwz 11,736(10)
	mullw 9,9,0
	srawi 31,9,2
	cmpw 0,11,31
	bc 4,2,.L444
	lis 11,gi+32@ha
	lwz 9,1788(10)
	lwz 0,gi+32@l(11)
	lwz 3,32(9)
	mtlr 0
	blrl
	lwz 9,84(30)
	stw 3,88(9)
.L444:
	lwz 9,84(30)
	mr 3,30
	stw 31,736(9)
	bl Think_Weapon
	mr 3,30
	bl ChangeWeapon
	b .L387
.L434:
	fsubs 0,0,12
	lis 9,gi+8@ha
	lwz 0,gi+8@l(9)
	lis 5,.LC125@ha
	mr 3,30
	la 5,.LC125@l(5)
	li 4,2
	mtlr 0
	fctiwz 13,0
	stfd 13,88(1)
	lwz 6,92(1)
	crxor 6,6,6
	blrl
	b .L387
.L432:
	lis 4,.LC126@ha
	mr 3,31
	la 4,.LC126@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L447
	lis 8,.LC187@ha
	lfs 0,480(30)
	lis 9,.LC188@ha
	la 8,.LC187@l(8)
	la 9,.LC188@l(9)
	lfs 13,0(8)
	lfs 12,0(9)
	fadds 0,0,13
	fcmpu 0,0,12
	stfs 0,480(30)
	bc 4,1,.L387
	stfs 12,480(30)
	b .L387
.L447:
	lis 4,.LC127@ha
	mr 3,31
	la 4,.LC127@l(4)
	bl Q_stricmp
	lis 4,.LC128@ha
	mr 3,31
	la 4,.LC128@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L450
	mr 3,30
	bl Cmd_MonsterMove_f
	b .L387
.L450:
	lis 4,.LC129@ha
	mr 3,31
	la 4,.LC129@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L451
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 31,gi@l(11)
	la 29,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(31)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L453
	lwz 0,8(31)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L454
.L453:
	mr 3,29
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,11,3
	cmpwi 0,0,10
	bc 4,0,.L455
	lwz 0,8(31)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	li 21,0
	crxor 6,6,6
	blrl
	b .L454
.L455:
	li 21,1
.L454:
	cmpwi 0,21,0
	bc 12,2,.L387
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 31,3
	lis 4,.LC97@ha
	la 4,.LC97@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L456
	mr 3,30
	li 4,1
	bl SP_boobytrap
	b .L387
.L456:
	lis 4,.LC98@ha
	mr 3,31
	la 4,.LC98@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L458
	mr 3,30
	li 4,2
	bl SP_boobytrap
	b .L387
.L458:
	lis 4,.LC99@ha
	mr 3,31
	la 4,.LC99@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L460
	mr 3,30
	li 4,3
	bl SP_boobytrap
	b .L387
.L460:
	mr 3,30
	li 4,0
	bl SP_boobytrap
	b .L387
.L451:
	lis 4,.LC130@ha
	mr 3,31
	la 4,.LC130@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L463
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L465
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L466
.L465:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,50
	bc 4,0,.L467
	lwz 0,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	li 27,0
	crxor 6,6,6
	blrl
	b .L466
.L467:
	mr 3,30
	li 4,300
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L469
	li 27,0
	b .L466
.L469:
	lwz 11,84(30)
	li 27,1
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-50
	stwx 9,11,31
.L466:
	cmpwi 0,27,0
	bc 12,2,.L387
	mr 3,30
	bl SP_func_DoomSpawngl
	b .L387
.L463:
	lis 4,.LC131@ha
	mr 3,31
	la 4,.LC131@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L471
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 31,gi@l(11)
	la 29,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(31)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L473
	lwz 0,8(31)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L474
.L473:
	mr 3,29
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,11,3
	cmpwi 0,0,2
	bc 4,0,.L475
	lwz 0,8(31)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	li 19,0
	crxor 6,6,6
	blrl
	b .L474
.L475:
	li 19,1
.L474:
	cmpwi 0,19,0
	bc 12,2,.L387
	mr 3,30
	li 4,0
	crxor 6,6,6
	bl SP_minetrap
	b .L387
.L471:
	lis 4,.LC132@ha
	mr 3,31
	la 4,.LC132@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L476
	lis 3,.LC36@ha
	la 3,.LC36@l(3)
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 9,11,3
	cmpwi 0,9,5
	bc 4,0,.L478
	lis 9,gi+8@ha
	lis 5,.LC13@ha
	lwz 0,gi+8@l(9)
	la 5,.LC13@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 9,0
	b .L479
.L478:
	addi 0,9,-5
	li 9,1
	stwx 0,11,3
.L479:
	cmpwi 0,9,0
	bc 12,2,.L387
	mr 3,30
	bl Cmd_Push_f
	b .L387
.L476:
	lis 4,.LC133@ha
	mr 3,31
	la 4,.LC133@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L481
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L483
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L484
.L483:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,5
	bc 4,0,.L485
	lwz 0,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	li 25,0
	crxor 6,6,6
	blrl
	b .L484
.L485:
	mr 3,30
	li 4,175
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L487
	li 25,0
	b .L484
.L487:
	lwz 11,84(30)
	li 25,1
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-5
	stwx 9,11,31
.L484:
	cmpwi 0,25,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_berserk2
	b .L387
.L481:
	lis 4,.LC134@ha
	mr 3,31
	la 4,.LC134@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L489
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L491
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L492
.L491:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,130
	bc 4,0,.L493
	lwz 0,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	li 24,0
	crxor 6,6,6
	blrl
	b .L492
.L493:
	mr 3,30
	li 4,200
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L495
	li 24,0
	b .L492
.L495:
	lwz 11,84(30)
	li 24,1
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-130
	stwx 9,11,31
.L492:
	cmpwi 0,24,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_makron2
	b .L387
.L489:
	lis 4,.LC135@ha
	mr 3,31
	la 4,.LC135@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L497
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L499
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L500
.L499:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,300
	bc 4,0,.L501
	lwz 0,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	li 23,0
	crxor 6,6,6
	blrl
	b .L500
.L501:
	mr 3,30
	li 4,225
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L503
	li 23,0
	b .L500
.L503:
	lwz 11,84(30)
	li 23,1
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-300
	stwx 9,11,31
.L500:
	cmpwi 0,23,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_jorg2
	b .L387
.L497:
	lis 4,.LC136@ha
	mr 3,31
	la 4,.LC136@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L505
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L507
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L508
.L507:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,80
	bc 4,0,.L509
	lwz 0,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	li 22,0
	crxor 6,6,6
	blrl
	b .L508
.L509:
	mr 3,30
	li 4,225
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L511
	li 22,0
	b .L508
.L511:
	lwz 11,84(30)
	li 22,1
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-80
	stwx 9,11,31
.L508:
	cmpwi 0,22,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_boss02
	b .L387
.L505:
	lis 4,.LC137@ha
	mr 3,31
	la 4,.LC137@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L513
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L515
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L516
.L515:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,12
	bc 4,0,.L517
	lwz 0,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	li 20,0
	crxor 6,6,6
	blrl
	b .L516
.L517:
	mr 3,30
	li 4,175
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L519
	li 20,0
	b .L516
.L519:
	lwz 11,84(30)
	li 20,1
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-12
	stwx 9,11,31
.L516:
	cmpwi 0,20,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_hover2
	b .L387
.L513:
	lis 4,.LC138@ha
	mr 3,31
	la 4,.LC138@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L521
	mr 3,30
	bl Cmd_Select_f
	b .L387
.L521:
	lis 4,.LC139@ha
	mr 3,31
	la 4,.LC139@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L522
	mr 3,30
	bl Cmd_Select2_f
	b .L387
.L522:
	lis 4,.LC140@ha
	mr 3,31
	la 4,.LC140@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L523
	mr 3,30
	bl Cmd_Patrol_f
	b .L387
.L523:
	lis 4,.LC141@ha
	mr 3,31
	la 4,.LC141@l(4)
	bl Q_stricmp
	mr. 29,3
	bc 4,2,.L524
	lwz 0,384(30)
	cmpwi 0,0,0
	bc 4,2,.L525
	lis 9,gi+8@ha
	lis 5,.LC142@ha
	lwz 0,gi+8@l(9)
	la 5,.LC142@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 0,1
	stw 0,384(30)
	b .L387
.L525:
	lis 9,gi+8@ha
	lis 5,.LC143@ha
	lwz 0,gi+8@l(9)
	la 5,.LC143@l(5)
	mr 3,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	stw 29,384(30)
	b .L387
.L524:
	lis 4,.LC144@ha
	mr 3,31
	la 4,.LC144@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L527
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L529
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L530
.L529:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,4
	bc 4,0,.L531
	lwz 0,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	li 18,0
	crxor 6,6,6
	blrl
	b .L530
.L531:
	mr 3,30
	li 4,175
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L533
	li 18,0
	b .L530
.L533:
	lwz 11,84(30)
	li 18,1
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-4
	stwx 9,11,31
.L530:
	cmpwi 0,18,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_soldier_ss2
	b .L387
.L527:
	lis 4,.LC145@ha
	mr 3,31
	la 4,.LC145@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L535
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L537
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L538
.L537:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,5
	bc 4,0,.L539
	lwz 0,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	li 17,0
	crxor 6,6,6
	blrl
	b .L538
.L539:
	mr 3,30
	li 4,175
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L541
	li 17,0
	b .L538
.L541:
	lwz 11,84(30)
	li 17,1
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-5
	stwx 9,11,31
.L538:
	cmpwi 0,17,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_flipper2
	b .L387
.L535:
	lis 4,.LC146@ha
	mr 3,31
	la 4,.LC146@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L543
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L545
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L546
.L545:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,50
	bc 4,0,.L547
	lwz 0,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	li 16,0
	crxor 6,6,6
	blrl
	b .L546
.L547:
	mr 3,30
	li 4,250
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L549
	li 16,0
	b .L546
.L549:
	lwz 11,84(30)
	li 16,1
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-50
	stwx 9,11,31
.L546:
	cmpwi 0,16,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_supertank2
	b .L387
.L543:
	lis 4,.LC147@ha
	mr 3,31
	la 4,.LC147@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L551
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L553
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L554
.L553:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,25
	bc 4,0,.L555
	lwz 0,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	li 15,0
	crxor 6,6,6
	blrl
	b .L554
.L555:
	mr 3,30
	li 4,225
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L557
	li 15,0
	b .L554
.L557:
	lwz 11,84(30)
	li 15,1
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-25
	stwx 9,11,31
.L554:
	cmpwi 0,15,0
	bc 12,2,.L387
	mr 3,30
	li 4,0
	bl SP_monster_tank2
	b .L387
.L551:
	lis 4,.LC148@ha
	mr 3,31
	la 4,.LC148@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L559
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L561
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L562
.L561:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,35
	bc 4,0,.L563
	lwz 0,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	li 14,0
	crxor 6,6,6
	blrl
	b .L562
.L563:
	mr 3,30
	li 4,230
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L565
	li 14,0
	b .L562
.L565:
	lwz 11,84(30)
	li 14,1
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-35
	stwx 9,11,31
.L562:
	cmpwi 0,14,0
	bc 12,2,.L387
	mr 3,30
	li 4,1
	bl SP_monster_tank2
	b .L387
.L559:
	lis 4,.LC149@ha
	mr 3,31
	la 4,.LC149@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L567
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L569
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L570
.L569:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,15
	bc 4,0,.L571
	lwz 9,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 9
	li 0,0
	stw 0,40(1)
	crxor 6,6,6
	blrl
	b .L570
.L571:
	mr 3,30
	li 4,175
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L573
	li 0,0
	stw 0,40(1)
	b .L570
.L573:
	lwz 11,84(30)
	li 8,1
	stw 8,40(1)
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-15
	stwx 9,11,31
.L570:
	lwz 9,40(1)
	cmpwi 0,9,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_medic2
	b .L387
.L567:
	lis 4,.LC150@ha
	mr 3,31
	la 4,.LC150@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L575
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L577
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L578
.L577:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,20
	bc 4,0,.L579
	lwz 9,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 9
	li 0,0
	stw 0,44(1)
	crxor 6,6,6
	blrl
	b .L578
.L579:
	mr 3,30
	li 4,200
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L581
	li 0,0
	stw 0,44(1)
	b .L578
.L581:
	lwz 11,84(30)
	li 8,1
	stw 8,44(1)
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-20
	stwx 9,11,31
.L578:
	lwz 9,44(1)
	cmpwi 0,9,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_mutant2
	b .L387
.L575:
	lis 4,.LC151@ha
	mr 3,31
	la 4,.LC151@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L583
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L585
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L586
.L585:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,4
	bc 4,0,.L587
	lwz 9,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 9
	li 0,0
	stw 0,48(1)
	crxor 6,6,6
	blrl
	b .L586
.L587:
	mr 3,30
	li 4,175
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L589
	li 0,0
	stw 0,48(1)
	b .L586
.L589:
	lwz 11,84(30)
	li 8,1
	stw 8,48(1)
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-4
	stwx 9,11,31
.L586:
	lwz 9,48(1)
	cmpwi 0,9,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_soldier2
	b .L387
.L583:
	lis 4,.LC152@ha
	mr 3,31
	la 4,.LC152@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L591
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L593
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L594
.L593:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,2
	bc 4,0,.L595
	lwz 9,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 9
	li 0,0
	stw 0,52(1)
	crxor 6,6,6
	blrl
	b .L594
.L595:
	mr 3,30
	li 4,175
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L597
	li 0,0
	stw 0,52(1)
	b .L594
.L597:
	lwz 11,84(30)
	li 8,1
	stw 8,52(1)
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-2
	stwx 9,11,31
.L594:
	lwz 9,52(1)
	cmpwi 0,9,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_soldier_light2
	b .L387
.L591:
	lis 4,.LC153@ha
	mr 3,31
	la 4,.LC153@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L599
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L601
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L602
.L601:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,8
	bc 4,0,.L603
	lwz 9,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 9
	li 0,0
	stw 0,56(1)
	crxor 6,6,6
	blrl
	b .L602
.L603:
	mr 3,30
	li 4,175
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L605
	li 0,0
	stw 0,56(1)
	b .L602
.L605:
	lwz 11,84(30)
	li 8,1
	stw 8,56(1)
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-8
	stwx 9,11,31
.L602:
	lwz 9,56(1)
	cmpwi 0,9,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_parasite2
	b .L387
.L599:
	lis 4,.LC154@ha
	mr 3,31
	la 4,.LC154@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L607
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L609
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L610
.L609:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,5
	bc 4,0,.L611
	lwz 9,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 9
	li 0,0
	stw 0,60(1)
	crxor 6,6,6
	blrl
	b .L610
.L611:
	mr 3,30
	li 4,175
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L613
	li 0,0
	stw 0,60(1)
	b .L610
.L613:
	lwz 11,84(30)
	li 8,1
	stw 8,60(1)
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-5
	stwx 9,11,31
.L610:
	lwz 9,60(1)
	cmpwi 0,9,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_infantry2
	b .L387
.L607:
	lis 4,.LC155@ha
	mr 3,31
	la 4,.LC155@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L615
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L617
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L618
.L617:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,8
	bc 4,0,.L619
	lwz 9,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 9
	li 0,0
	stw 0,64(1)
	crxor 6,6,6
	blrl
	b .L618
.L619:
	mr 3,30
	li 4,175
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L621
	li 0,0
	stw 0,64(1)
	b .L618
.L621:
	lwz 11,84(30)
	li 8,1
	stw 8,64(1)
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-8
	stwx 9,11,31
.L618:
	lwz 9,64(1)
	cmpwi 0,9,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_brain2
	b .L387
.L615:
	lis 4,.LC156@ha
	mr 3,31
	la 4,.LC156@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L623
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L625
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L626
.L625:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,10
	bc 4,0,.L627
	lwz 9,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 9
	li 0,0
	stw 0,68(1)
	crxor 6,6,6
	blrl
	b .L626
.L627:
	mr 3,30
	li 4,175
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L629
	li 0,0
	stw 0,68(1)
	b .L626
.L629:
	lwz 11,84(30)
	li 8,1
	stw 8,68(1)
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-10
	stwx 9,11,31
.L626:
	lwz 9,68(1)
	cmpwi 0,9,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_chick2
	b .L387
.L623:
	lis 4,.LC157@ha
	mr 3,31
	la 4,.LC157@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L631
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L633
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L634
.L633:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,10
	bc 4,0,.L635
	lwz 9,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 9
	li 0,0
	stw 0,72(1)
	crxor 6,6,6
	blrl
	b .L634
.L635:
	mr 3,30
	li 4,175
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L637
	li 0,0
	stw 0,72(1)
	b .L634
.L637:
	lwz 11,84(30)
	li 8,1
	stw 8,72(1)
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-10
	stwx 9,11,31
.L634:
	lwz 9,72(1)
	cmpwi 0,9,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_gunner2
	b .L387
.L631:
	lis 4,.LC158@ha
	mr 3,31
	la 4,.LC158@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L639
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L641
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L642
.L641:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,20
	bc 4,0,.L643
	lwz 9,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 9
	li 0,0
	stw 0,76(1)
	crxor 6,6,6
	blrl
	b .L642
.L643:
	mr 3,30
	li 4,175
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L645
	li 0,0
	stw 0,76(1)
	b .L642
.L645:
	lwz 11,84(30)
	li 8,1
	stw 8,76(1)
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-20
	stwx 9,11,31
.L642:
	lwz 9,76(1)
	cmpwi 0,9,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_gladiator2
	b .L387
.L639:
	lis 4,.LC159@ha
	mr 3,31
	la 4,.LC159@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L647
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L649
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L650
.L649:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,6
	bc 4,0,.L651
	lwz 9,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 9
	li 0,0
	stw 0,80(1)
	crxor 6,6,6
	blrl
	b .L650
.L651:
	mr 3,30
	li 4,175
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L653
	li 0,0
	stw 0,80(1)
	b .L650
.L653:
	lwz 11,84(30)
	li 8,1
	stw 8,80(1)
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-6
	stwx 9,11,31
.L650:
	lwz 9,80(1)
	cmpwi 0,9,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_flyer2
	b .L387
.L647:
	lis 4,.LC160@ha
	mr 3,31
	la 4,.LC160@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L431
	lwz 10,84(30)
	lis 11,gi@ha
	lis 9,.LC36@ha
	lfs 11,4(30)
	la 29,gi@l(11)
	la 31,.LC36@l(9)
	lfs 0,40(10)
	addi 3,1,24
	lfs 13,8(30)
	lfs 12,12(30)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,24(1)
	lfs 0,44(10)
	fadds 13,13,0
	stfs 13,28(1)
	lfs 0,48(10)
	fadds 12,12,0
	stfs 12,32(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L657
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,30
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L658
.L657:
	mr 3,31
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 31,3,0,0,29
	lwzx 0,11,31
	cmpwi 0,0,7
	bc 4,0,.L659
	lwz 9,8(29)
	lis 5,.LC13@ha
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 9
	li 0,0
	stw 0,84(1)
	crxor 6,6,6
	blrl
	b .L658
.L659:
	mr 3,30
	li 4,175
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L661
	li 0,0
	stw 0,84(1)
	b .L658
.L661:
	lwz 11,84(30)
	li 8,1
	stw 8,84(1)
	addi 11,11,740
	lwzx 9,11,31
	addi 9,9,-7
	stwx 9,11,31
.L658:
	lwz 9,84(1)
	cmpwi 0,9,0
	bc 12,2,.L387
	mr 3,30
	bl SP_monster_floater2
	b .L387
.L431:
	lis 8,.LC184@ha
	lis 9,level+220@ha
	la 8,.LC184@l(8)
	lfs 0,level+220@l(9)
	lfs 13,0(8)
	fcmpu 0,0,13
	bc 4,2,.L387
	lis 4,.LC161@ha
	mr 3,31
	la 4,.LC161@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L664
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 31,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L665
	lwz 0,8(29)
	lis 5,.LC62@ha
	mr 3,30
	la 5,.LC62@l(5)
	b .L840
.L665:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L667
	lwz 0,8(29)
	lis 5,.LC63@ha
	mr 3,30
	la 5,.LC63@l(5)
	b .L839
.L667:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L841
	b .L674
.L664:
	lwz 0,292(30)
	cmpwi 0,0,1
	bc 4,2,.L670
	lis 4,.LC162@ha
	mr 3,31
	la 4,.LC162@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L670
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 31,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L671
	lwz 0,8(29)
	lis 5,.LC62@ha
	mr 3,30
	la 5,.LC62@l(5)
	b .L840
.L671:
	lwz 10,12(4)
	cmpwi 0,10,0
	bc 4,2,.L673
	lwz 0,8(29)
	lis 5,.LC65@ha
	mr 3,30
	la 5,.LC65@l(5)
	b .L839
.L673:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L674
.L841:
	lwz 0,8(29)
	lis 5,.LC64@ha
	mr 3,30
	la 5,.LC64@l(5)
.L840:
	mr 6,31
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L387
.L674:
	mr 3,30
	mtlr 10
	blrl
	b .L387
.L670:
	lis 4,.LC163@ha
	mr 3,31
	la 4,.LC163@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L676
	mr 3,30
	bl Cmd_Give_f
	b .L387
.L676:
	lis 4,.LC164@ha
	mr 3,31
	la 4,.LC164@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L678
	lis 9,deathmatch@ha
	lis 8,.LC184@ha
	lwz 11,deathmatch@l(9)
	la 8,.LC184@l(8)
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L679
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L679
	lis 9,gi+8@ha
	lis 5,.LC43@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC43@l(5)
	b .L839
.L679:
	lwz 0,264(30)
	xori 0,0,16
	andi. 8,0,16
	stw 0,264(30)
	bc 4,2,.L681
	lis 9,.LC56@ha
	la 5,.LC56@l(9)
	b .L688
.L681:
	lis 9,.LC57@ha
	la 5,.LC57@l(9)
	b .L688
.L678:
	lis 4,.LC165@ha
	mr 3,31
	la 4,.LC165@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L684
	lis 9,deathmatch@ha
	lis 8,.LC184@ha
	lwz 11,deathmatch@l(9)
	la 8,.LC184@l(8)
	lfs 13,0(8)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L685
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L685
	lis 9,gi+8@ha
	lis 5,.LC43@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC43@l(5)
	b .L839
.L685:
	lwz 0,264(30)
	xori 0,0,32
	andi. 8,0,32
	stw 0,264(30)
	bc 4,2,.L687
	lis 9,.LC58@ha
	la 5,.LC58@l(9)
	b .L688
.L687:
	lis 9,.LC59@ha
	la 5,.LC59@l(9)
.L688:
	lis 9,gi+8@ha
	mr 3,30
	lwz 0,gi+8@l(9)
.L839:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L387
.L684:
	lis 4,.LC166@ha
	mr 3,31
	la 4,.LC166@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L690
	lwz 29,84(30)
	lwz 0,3500(29)
	stw 3,3496(29)
	cmpwi 0,0,0
	stw 3,3504(29)
	bc 12,2,.L691
	stw 3,3500(29)
	b .L387
.L691:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3500(29)
	li 3,5
	lwz 0,100(9)
	addi 31,29,1760
	mr 28,9
	addi 29,29,740
	mtlr 0
	blrl
.L695:
	lwz 9,104(28)
	lwz 3,0(29)
	mtlr 9
	addi 29,29,4
	blrl
	cmpw 0,29,31
	bc 4,1,.L695
	lis 9,gi+92@ha
	mr 3,30
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
	b .L387
.L690:
	lis 4,.LC167@ha
	mr 3,31
	la 4,.LC167@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L699
	lwz 8,84(30)
	lwz 0,3796(8)
	cmpwi 0,0,0
	bc 4,2,.L842
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L837:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L706
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L706
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L830
.L706:
	addi 7,7,1
	bdnz .L837
	b .L843
.L699:
	lis 4,.LC168@ha
	mr 3,31
	la 4,.LC168@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L711
	lwz 7,84(30)
	lwz 0,3796(7)
	cmpwi 0,0,0
	bc 4,2,.L844
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L836:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L718
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L718
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L831
.L718:
	addi 11,11,-1
	bdnz .L836
	b .L845
.L711:
	lis 4,.LC169@ha
	mr 3,31
	la 4,.LC169@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L723
	lwz 8,84(30)
	lwz 0,3796(8)
	cmpwi 0,0,0
	bc 4,2,.L842
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L835:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L730
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L730
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L830
.L730:
	addi 7,7,1
	bdnz .L835
	b .L843
.L723:
	lis 4,.LC170@ha
	mr 3,31
	la 4,.LC170@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L735
	lwz 7,84(30)
	lwz 0,3796(7)
	cmpwi 0,0,0
	bc 4,2,.L844
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L834:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L742
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L742
	lwz 0,56(10)
	andi. 9,0,1
	bc 4,2,.L831
.L742:
	addi 11,11,-1
	bdnz .L834
	b .L845
.L735:
	lis 4,.LC171@ha
	mr 3,31
	la 4,.LC171@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L747
	lwz 8,84(30)
	lwz 0,3796(8)
	cmpwi 0,0,0
	bc 12,2,.L748
.L842:
	mr 3,30
	bl ChaseNext
	b .L387
.L748:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 4,itemlist@l(9)
	addi 6,8,740
.L833:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L754
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L754
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L830
.L754:
	addi 7,7,1
	bdnz .L833
.L843:
	li 0,-1
	stw 0,736(8)
	b .L387
.L747:
	lis 4,.LC172@ha
	mr 3,31
	la 4,.LC172@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L759
	lwz 7,84(30)
	lwz 0,3796(7)
	cmpwi 0,0,0
	bc 12,2,.L760
.L844:
	mr 3,30
	bl ChasePrev
	b .L387
.L760:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L832:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L766
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L766
	lwz 0,56(10)
	andi. 9,0,32
	bc 4,2,.L831
.L766:
	addi 11,11,-1
	bdnz .L832
.L845:
	li 0,-1
	stw 0,736(7)
	b .L387
.L759:
	lis 4,.LC173@ha
	mr 3,31
	la 4,.LC173@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L771
	mr 3,30
	bl Cmd_InvUse_f
	b .L387
.L771:
	lwz 0,292(30)
	cmpwi 0,0,1
	bc 4,2,.L773
	lis 4,.LC174@ha
	mr 3,31
	la 4,.LC174@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L773
	mr 3,30
	bl Cmd_InvDrop_f
	b .L387
.L773:
	lis 4,.LC175@ha
	mr 3,31
	la 4,.LC175@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L775
	lwz 28,84(30)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L387
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 31,1
	subf 9,9,11
	addi 26,28,740
	mullw 9,9,0
	srawi 27,9,2
.L780:
	add 11,27,31
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L782
	mulli 0,11,76
	add 29,0,25
	lwz 9,8(29)
	cmpwi 0,9,0
	bc 12,2,.L782
	lwz 0,56(29)
	andi. 8,0,1
	bc 12,2,.L782
	mr 3,30
	mr 4,29
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,29
	bc 12,2,.L387
.L782:
	addi 31,31,1
	cmpwi 0,31,256
	bc 4,1,.L780
	b .L387
.L775:
	lis 4,.LC176@ha
	mr 3,31
	la 4,.LC176@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L788
	lwz 28,84(30)
	lwz 11,1788(28)
	cmpwi 0,11,0
	bc 12,2,.L387
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 27,1
	subf 9,9,11
	addi 26,28,740
	mullw 9,9,0
	srawi 9,9,2
	addi 31,9,255
.L793:
	srawi 0,31,31
	srwi 0,0,24
	add 0,31,0
	rlwinm 0,0,0,0,23
	subf 11,0,31
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L795
	mulli 0,11,76
	add 29,0,25
	lwz 9,8(29)
	cmpwi 0,9,0
	bc 12,2,.L795
	lwz 0,56(29)
	andi. 8,0,1
	bc 12,2,.L795
	mr 3,30
	mr 4,29
	mtlr 9
	blrl
	lwz 0,1788(28)
	cmpw 0,0,29
	bc 12,2,.L387
.L795:
	addi 27,27,1
	addi 31,31,-1
	cmpwi 0,27,256
	bc 4,1,.L793
	b .L387
.L788:
	lis 4,.LC177@ha
	mr 3,31
	la 4,.LC177@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L801
	lwz 10,84(30)
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L387
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L387
	lis 11,itemlist@ha
	lis 9,0x286b
	la 4,itemlist@l(11)
	ori 9,9,51739
	subf 0,4,0
	addi 11,10,740
	mullw 0,0,9
	srawi 10,0,2
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L387
	mulli 0,10,76
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L387
	lwz 0,56(4)
	andi. 8,0,1
	bc 12,2,.L387
	mr 3,30
	mtlr 9
	blrl
	b .L387
.L801:
	lis 4,.LC178@ha
	mr 3,31
	la 4,.LC178@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L809
	lwz 10,320(30)
	cmpwi 0,10,0
	bc 4,2,.L387
	lwz 11,84(30)
	lis 9,level+4@ha
	lis 8,.LC189@ha
	lfs 0,level+4@l(9)
	la 8,.LC189@l(8)
	lfs 13,3792(11)
	lfs 12,0(8)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L387
	lwz 0,264(30)
	mr 3,30
	lis 11,meansOfDeath@ha
	stw 10,576(30)
	li 9,23
	lis 6,0x1
	rlwinm 0,0,0,28,26
	lis 7,vec3_origin@ha
	stw 0,264(30)
	la 7,vec3_origin@l(7)
	mr 4,3
	stw 9,meansOfDeath@l(11)
	mr 5,3
	ori 6,6,34464
	bl player_die
	b .L387
.L809:
	lis 4,.LC179@ha
	mr 3,31
	la 4,.LC179@l(4)
	bl Q_stricmp
	mr. 3,3
	bc 4,2,.L814
	lwz 9,84(30)
	stw 3,3496(9)
	lwz 11,84(30)
	stw 3,3504(11)
	lwz 9,84(30)
	stw 3,3500(9)
	b .L387
.L814:
	lis 4,.LC180@ha
	mr 3,31
	la 4,.LC180@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L817
	mr 3,30
	bl Cmd_Wave_f
	b .L387
.L817:
	lis 4,.LC181@ha
	mr 3,31
	la 4,.LC181@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L819
	mr 3,30
	bl Cmd_PlayerList_f
	b .L387
.L819:
	lis 4,.LC182@ha
	mr 3,31
	la 4,.LC182@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L821
	mr 3,30
	bl Cmd_Maplist_f
	b .L387
.L821:
	lis 4,.LC183@ha
	mr 3,31
	la 4,.LC183@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L823
	lwz 0,292(30)
	cmpwi 0,0,0
	bc 4,1,.L387
	mr 3,30
	bl FL_make
	b .L387
.L830:
	stw 11,736(8)
	b .L387
.L831:
	stw 8,736(7)
	b .L387
.L823:
	mr 3,30
	li 4,0
	li 5,1
	bl Cmd_Say_f
.L387:
	lwz 0,180(1)
	mtlr 0
	lmw 14,96(1)
	lfd 31,168(1)
	la 1,176(1)
	blr
.Lfe18:
	.size	 ClientCommand,.Lfe18-ClientCommand
	.align 2
	.globl EnoughStuff
	.type	 EnoughStuff,@function
EnoughStuff:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	mr 31,3
	lis 9,gi@ha
	lwz 11,84(31)
	la 29,gi@l(9)
	addi 3,1,8
	lfs 11,4(31)
	mr 28,4
	mr 30,5
	lfs 0,40(11)
	mr 27,6
	lfs 13,8(31)
	lfs 12,12(31)
	fadds 11,11,0
	lwz 9,52(29)
	mtlr 9
	stfs 11,8(1)
	lfs 0,44(11)
	fadds 13,13,0
	stfs 13,12(1)
	lfs 0,48(11)
	fadds 12,12,0
	stfs 12,16(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L78
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,31
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L77
.L78:
	mr 3,30
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 30,3,0,0,29
	lwzx 0,11,30
	cmpw 0,0,28
	bc 4,0,.L79
	lwz 0,8(29)
	lis 5,.LC13@ha
	mr 3,31
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L77
.L79:
	mr 4,27
	mr 3,31
	bl CheckRadius
	cmpwi 0,3,0
	bc 4,2,.L81
	li 3,0
	b .L77
.L81:
	lwz 9,84(31)
	li 3,1
	addi 9,9,740
	lwzx 0,9,30
	subf 0,28,0
	stwx 0,9,30
.L77:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe19:
	.size	 EnoughStuff,.Lfe19-EnoughStuff
	.align 2
	.globl ValidateSelectedItem
	.type	 ValidateSelectedItem,@function
ValidateSelectedItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 7,84(3)
	lwz 11,736(7)
	addi 10,7,740
	slwi 0,11,2
	lwzx 9,10,0
	cmpwi 0,9,0
	bc 4,2,.L148
	lwz 0,3796(7)
	cmpwi 0,0,0
	bc 12,2,.L150
	bl ChaseNext
	b .L148
.L847:
	stw 11,736(7)
	b .L148
.L150:
	li 0,256
	lis 9,itemlist@ha
	mtctr 0
	mr 5,11
	la 4,itemlist@l(9)
	mr 6,10
	li 8,1
.L848:
	add 11,5,8
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L156
	mulli 0,11,76
	add 10,0,4
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L156
	lwz 0,56(10)
	cmpwi 0,0,0
	bc 4,2,.L847
.L156:
	addi 8,8,1
	bdnz .L848
	li 0,-1
	stw 0,736(7)
.L148:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe20:
	.size	 ValidateSelectedItem,.Lfe20-ValidateSelectedItem
	.comm	maplist,292,4
	.align 2
	.globl ClientTeam
	.type	 ClientTeam,@function
ClientTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 9,value.12@ha
	li 30,0
	stb 30,value.12@l(9)
	la 31,value.12@l(9)
	lwz 3,84(3)
	cmpwi 0,3,0
	bc 12,2,.L850
	lis 4,.LC6@ha
	addi 3,3,188
	la 4,.LC6@l(4)
	bl Info_ValueForKey
	mr 4,3
	mr 3,31
	bl strcpy
	mr 3,31
	li 4,47
	bl strchr
	mr. 3,3
	bc 12,2,.L850
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,128
	bc 4,2,.L37
	addi 3,3,1
	b .L849
.L37:
	stb 30,0(3)
.L850:
	mr 3,31
.L849:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 ClientTeam,.Lfe21-ClientTeam
	.align 2
	.globl EnoughCells
	.type	 EnoughCells,@function
EnoughCells:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,3
	mr 31,4
	mr 3,5
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(30)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 9,3,0,0,29
	lwzx 0,11,9
	cmpw 0,0,31
	bc 12,0,.L84
	subf 0,31,0
	li 3,1
	stwx 0,11,9
	b .L851
.L84:
	lis 9,gi+8@ha
	lis 5,.LC13@ha
	lwz 0,gi+8@l(9)
	mr 3,30
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
.L851:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe22:
	.size	 EnoughCells,.Lfe22-EnoughCells
	.align 2
	.globl EnoughStuff2
	.type	 EnoughStuff2,@function
EnoughStuff2:
	stwu 1,-48(1)
	mflr 0
	stmw 28,32(1)
	stw 0,52(1)
	mr 31,3
	lis 9,gi@ha
	lwz 11,84(31)
	la 29,gi@l(9)
	addi 3,1,8
	lfs 12,4(31)
	mr 28,4
	mr 30,5
	lfs 0,40(11)
	lfs 13,8(31)
	lfs 11,12(31)
	fadds 12,12,0
	lwz 9,52(29)
	mtlr 9
	stfs 12,8(1)
	lfs 0,44(11)
	fadds 13,13,0
	stfs 13,12(1)
	lfs 0,48(11)
	fadds 11,11,0
	stfs 11,16(1)
	blrl
	andi. 0,3,1
	bc 12,2,.L87
	lwz 0,8(29)
	lis 5,.LC7@ha
	mr 3,31
	la 5,.LC7@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L86
.L87:
	mr 3,30
	bl FindItem
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 3,9,3
	addi 11,11,740
	mullw 3,3,0
	rlwinm 3,3,0,0,29
	lwzx 0,11,3
	cmpw 0,0,28
	bc 12,0,.L88
	li 3,1
	b .L86
.L88:
	lwz 0,8(29)
	lis 5,.LC13@ha
	mr 3,31
	la 5,.LC13@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
.L86:
	lwz 0,52(1)
	mtlr 0
	lmw 28,32(1)
	la 1,48(1)
	blr
.Lfe23:
	.size	 EnoughStuff2,.Lfe23-EnoughStuff2
	.align 2
	.globl SelectNextItem
	.type	 SelectNextItem,@function
SelectNextItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 8,84(3)
	lwz 0,3796(8)
	cmpwi 0,0,0
	bc 12,2,.L129
	bl ChaseNext
	b .L128
.L853:
	stw 11,736(8)
	b .L128
.L129:
	li 0,256
	lis 9,itemlist@ha
	lwz 5,736(8)
	mtctr 0
	li 7,1
	la 3,itemlist@l(9)
	addi 6,8,740
.L854:
	add 11,5,7
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L132
	mulli 0,11,76
	add 10,0,3
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L132
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L853
.L132:
	addi 7,7,1
	bdnz .L854
	li 0,-1
	stw 0,736(8)
.L128:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe24:
	.size	 SelectNextItem,.Lfe24-SelectNextItem
	.align 2
	.globl SelectPrevItem
	.type	 SelectPrevItem,@function
SelectPrevItem:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 7,84(3)
	lwz 0,3796(7)
	cmpwi 0,0,0
	bc 12,2,.L139
	bl ChasePrev
	b .L138
.L855:
	stw 8,736(7)
	b .L138
.L139:
	li 0,256
	lwz 11,736(7)
	lis 9,itemlist@ha
	mtctr 0
	addi 6,7,740
	la 5,itemlist@l(9)
	addi 11,11,255
.L856:
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 8,0,11
	slwi 9,8,2
	lwzx 0,6,9
	cmpwi 0,0,0
	bc 12,2,.L142
	mulli 0,8,76
	add 10,0,5
	lwz 9,8(10)
	cmpwi 0,9,0
	bc 12,2,.L142
	lwz 0,56(10)
	and. 9,0,4
	bc 4,2,.L855
.L142:
	addi 11,11,-1
	bdnz .L856
	li 0,-1
	stw 0,736(7)
.L138:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe25:
	.size	 SelectPrevItem,.Lfe25-SelectPrevItem
	.section	".rodata"
	.align 2
.LC190:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_God_f
	.type	 Cmd_God_f,@function
Cmd_God_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC190@ha
	lis 9,deathmatch@ha
	la 11,.LC190@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L214
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L214
	lis 9,gi+8@ha
	lis 5,.LC43@ha
	lwz 0,gi+8@l(9)
	la 5,.LC43@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L213
.L214:
	lwz 0,264(3)
	xori 0,0,16
	andi. 9,0,16
	stw 0,264(3)
	bc 4,2,.L215
	lis 9,.LC56@ha
	la 5,.LC56@l(9)
	b .L216
.L215:
	lis 9,.LC57@ha
	la 5,.LC57@l(9)
.L216:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L213:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe26:
	.size	 Cmd_God_f,.Lfe26-Cmd_God_f
	.section	".rodata"
	.align 2
.LC191:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Notarget_f
	.type	 Cmd_Notarget_f,@function
Cmd_Notarget_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC191@ha
	lis 9,deathmatch@ha
	la 11,.LC191@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L218
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L218
	lis 9,gi+8@ha
	lis 5,.LC43@ha
	lwz 0,gi+8@l(9)
	la 5,.LC43@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L217
.L218:
	lwz 0,264(3)
	xori 0,0,32
	andi. 9,0,32
	stw 0,264(3)
	bc 4,2,.L219
	lis 9,.LC58@ha
	la 5,.LC58@l(9)
	b .L220
.L219:
	lis 9,.LC59@ha
	la 5,.LC59@l(9)
.L220:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L217:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe27:
	.size	 Cmd_Notarget_f,.Lfe27-Cmd_Notarget_f
	.section	".rodata"
	.align 2
.LC192:
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_Noclip_f
	.type	 Cmd_Noclip_f,@function
Cmd_Noclip_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 11,.LC192@ha
	lis 9,deathmatch@ha
	la 11,.LC192@l(11)
	lfs 13,0(11)
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L222
	lis 9,sv_cheats@ha
	lwz 11,sv_cheats@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 4,2,.L222
	lis 9,gi+8@ha
	lis 5,.LC43@ha
	lwz 0,gi+8@l(9)
	la 5,.LC43@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L221
.L222:
	lwz 0,260(3)
	cmpwi 0,0,1
	bc 4,2,.L223
	li 0,4
	lis 9,.LC60@ha
	stw 0,260(3)
	la 5,.LC60@l(9)
	b .L224
.L223:
	li 0,1
	lis 9,.LC61@ha
	stw 0,260(3)
	la 5,.LC61@l(9)
.L224:
	lis 9,gi+8@ha
	li 4,2
	lwz 0,gi+8@l(9)
	mtlr 0
	crxor 6,6,6
	blrl
.L221:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 Cmd_Noclip_f,.Lfe28-Cmd_Noclip_f
	.align 2
	.globl Cmd_Use_f
	.type	 Cmd_Use_f,@function
Cmd_Use_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 31,3
	la 29,gi@l(9)
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 30,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L226
	lwz 0,8(29)
	lis 5,.LC62@ha
	mr 3,31
	la 5,.LC62@l(5)
	b .L857
.L226:
	lwz 10,8(4)
	cmpwi 0,10,0
	bc 4,2,.L227
	lwz 0,8(29)
	lis 5,.LC63@ha
	mr 3,31
	la 5,.LC63@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L225
.L227:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L228
	lwz 0,8(29)
	lis 5,.LC64@ha
	mr 3,31
	la 5,.LC64@l(5)
.L857:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L225
.L228:
	mr 3,31
	mtlr 10
	blrl
.L225:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe29:
	.size	 Cmd_Use_f,.Lfe29-Cmd_Use_f
	.align 2
	.globl Cmd_Drop_f
	.type	 Cmd_Drop_f,@function
Cmd_Drop_f:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 31,3
	la 29,gi@l(9)
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 30,3
	bl FindItem
	mr. 4,3
	bc 4,2,.L230
	lwz 0,8(29)
	lis 5,.LC62@ha
	mr 3,31
	la 5,.LC62@l(5)
	b .L858
.L230:
	lwz 10,12(4)
	cmpwi 0,10,0
	bc 4,2,.L231
	lwz 0,8(29)
	lis 5,.LC65@ha
	mr 3,31
	la 5,.LC65@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L229
.L231:
	lis 9,itemlist@ha
	lis 0,0x286b
	lwz 11,84(31)
	la 9,itemlist@l(9)
	ori 0,0,51739
	subf 9,9,4
	addi 11,11,740
	mullw 9,9,0
	rlwinm 9,9,0,0,29
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 4,2,.L232
	lwz 0,8(29)
	lis 5,.LC64@ha
	mr 3,31
	la 5,.LC64@l(5)
.L858:
	mr 6,30
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L229
.L232:
	mr 3,31
	mtlr 10
	blrl
.L229:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 Cmd_Drop_f,.Lfe30-Cmd_Drop_f
	.align 2
	.globl Cmd_Inven_f
	.type	 Cmd_Inven_f,@function
Cmd_Inven_f:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	mr 28,3
	li 9,0
	lwz 31,84(28)
	lwz 0,3500(31)
	stw 9,3496(31)
	cmpwi 0,0,0
	stw 9,3504(31)
	bc 12,2,.L234
	stw 9,3500(31)
	b .L233
.L234:
	li 0,1
	lis 9,gi@ha
	la 9,gi@l(9)
	stw 0,3500(31)
	li 3,5
	lwz 0,100(9)
	addi 30,31,1760
	mr 29,9
	addi 31,31,740
	mtlr 0
	blrl
.L238:
	lwz 9,104(29)
	lwz 3,0(31)
	mtlr 9
	addi 31,31,4
	blrl
	cmpw 0,31,30
	bc 4,1,.L238
	lis 9,gi+92@ha
	mr 3,28
	lwz 0,gi+92@l(9)
	li 4,1
	mtlr 0
	blrl
.L233:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe31:
	.size	 Cmd_Inven_f,.Lfe31-Cmd_Inven_f
	.align 2
	.globl Cmd_WeapPrev_f
	.type	 Cmd_WeapPrev_f,@function
Cmd_WeapPrev_f:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 28,3
	lwz 29,84(28)
	lwz 11,1788(29)
	cmpwi 0,11,0
	bc 12,2,.L258
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 30,1
	subf 9,9,11
	addi 26,29,740
	mullw 9,9,0
	srawi 27,9,2
.L263:
	add 11,27,30
	srawi 0,11,31
	srwi 0,0,24
	add 0,11,0
	rlwinm 0,0,0,0,23
	subf 11,0,11
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L262
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L262
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L262
	mr 3,28
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L258
.L262:
	addi 30,30,1
	cmpwi 0,30,256
	bc 4,1,.L263
.L258:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe32:
	.size	 Cmd_WeapPrev_f,.Lfe32-Cmd_WeapPrev_f
	.align 2
	.globl Cmd_WeapNext_f
	.type	 Cmd_WeapNext_f,@function
Cmd_WeapNext_f:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	mr 27,3
	lwz 29,84(27)
	lwz 11,1788(29)
	cmpwi 0,11,0
	bc 12,2,.L269
	lis 9,itemlist@ha
	lis 0,0x286b
	la 9,itemlist@l(9)
	ori 0,0,51739
	mr 25,9
	li 28,1
	subf 9,9,11
	addi 26,29,740
	mullw 9,9,0
	srawi 9,9,2
	addi 30,9,255
.L274:
	srawi 0,30,31
	srwi 0,0,24
	add 0,30,0
	rlwinm 0,0,0,0,23
	subf 11,0,30
	slwi 9,11,2
	lwzx 0,26,9
	cmpwi 0,0,0
	bc 12,2,.L273
	mulli 0,11,76
	add 31,0,25
	lwz 9,8(31)
	cmpwi 0,9,0
	bc 12,2,.L273
	lwz 0,56(31)
	andi. 11,0,1
	bc 12,2,.L273
	mr 3,27
	mr 4,31
	mtlr 9
	blrl
	lwz 0,1788(29)
	cmpw 0,0,31
	bc 12,2,.L269
.L273:
	addi 28,28,1
	addi 30,30,-1
	cmpwi 0,28,256
	bc 4,1,.L274
.L269:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe33:
	.size	 Cmd_WeapNext_f,.Lfe33-Cmd_WeapNext_f
	.align 2
	.globl Cmd_WeapLast_f
	.type	 Cmd_WeapLast_f,@function
Cmd_WeapLast_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 10,84(3)
	lwz 0,1788(10)
	cmpwi 0,0,0
	bc 12,2,.L280
	lwz 0,1792(10)
	cmpwi 0,0,0
	bc 12,2,.L280
	lis 11,itemlist@ha
	lis 9,0x286b
	la 4,itemlist@l(11)
	ori 9,9,51739
	subf 0,4,0
	addi 11,10,740
	mullw 0,0,9
	srawi 10,0,2
	slwi 9,10,2
	lwzx 0,11,9
	cmpwi 0,0,0
	bc 12,2,.L280
	mulli 0,10,76
	add 4,0,4
	lwz 9,8(4)
	cmpwi 0,9,0
	bc 12,2,.L280
	lwz 0,56(4)
	andi. 11,0,1
	bc 12,2,.L280
	mtlr 9
	blrl
.L280:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe34:
	.size	 Cmd_WeapLast_f,.Lfe34-Cmd_WeapLast_f
	.section	".rodata"
	.align 2
.LC193:
	.long 0x40a00000
	.section	".text"
	.align 2
	.globl Cmd_Kill_f
	.type	 Cmd_Kill_f,@function
Cmd_Kill_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	mr 10,3
	lwz 8,320(10)
	cmpwi 0,8,0
	bc 4,2,.L304
	lwz 11,84(10)
	lis 9,level+4@ha
	lis 7,.LC193@ha
	lfs 0,level+4@l(9)
	la 7,.LC193@l(7)
	lfs 13,3792(11)
	lfs 12,0(7)
	fsubs 0,0,13
	fcmpu 0,0,12
	bc 12,0,.L304
	lwz 0,264(10)
	lis 11,meansOfDeath@ha
	stw 8,576(10)
	li 9,23
	lis 6,0x1
	rlwinm 0,0,0,28,26
	lis 7,vec3_origin@ha
	stw 0,264(10)
	la 7,vec3_origin@l(7)
	mr 4,3
	stw 9,meansOfDeath@l(11)
	mr 5,3
	ori 6,6,34464
	bl player_die
.L304:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe35:
	.size	 Cmd_Kill_f,.Lfe35-Cmd_Kill_f
	.align 2
	.globl Cmd_PutAway_f
	.type	 Cmd_PutAway_f,@function
Cmd_PutAway_f:
	lwz 9,84(3)
	li 0,0
	stw 0,3496(9)
	lwz 11,84(3)
	stw 0,3504(11)
	lwz 9,84(3)
	stw 0,3500(9)
	blr
.Lfe36:
	.size	 Cmd_PutAway_f,.Lfe36-Cmd_PutAway_f
	.align 2
	.globl PlayerSort
	.type	 PlayerSort,@function
PlayerSort:
	lwz 9,0(3)
	lis 11,game+1028@ha
	lwz 3,0(4)
	lwz 0,game+1028@l(11)
	mulli 9,9,3804
	mulli 11,3,3804
	add 9,9,0
	add 11,11,0
	lha 9,148(9)
	lha 3,148(11)
	cmpw 0,9,3
	li 3,-1
	bclr 12,0
	mfcr 3
	rlwinm 3,3,2,1
	blr
.Lfe37:
	.size	 PlayerSort,.Lfe37-PlayerSort
	.align 2
	.globl SpawnWhat
	.type	 SpawnWhat,@function
SpawnWhat:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi+164@ha
	mr 30,3
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 31,3
	lis 4,.LC97@ha
	la 4,.LC97@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L374
	mr 3,30
	li 4,1
	bl SP_boobytrap
	b .L375
.L374:
	lis 4,.LC98@ha
	mr 3,31
	la 4,.LC98@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L376
	mr 3,30
	li 4,2
	bl SP_boobytrap
	b .L375
.L376:
	lis 4,.LC99@ha
	mr 3,31
	la 4,.LC99@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L378
	mr 3,30
	li 4,3
	bl SP_boobytrap
	b .L375
.L378:
	mr 3,30
	li 4,0
	bl SP_boobytrap
.L375:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe38:
	.size	 SpawnWhat,.Lfe38-SpawnWhat
	.align 2
	.globl SpecialWhat
	.type	 SpecialWhat,@function
SpecialWhat:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 31,3
	la 29,gi@l(9)
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 30,3
	lis 4,.LC97@ha
	la 4,.LC97@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L381
	li 0,1
	lis 5,.LC100@ha
	stw 0,352(31)
	mr 3,31
	la 5,.LC100@l(5)
	b .L860
.L381:
	lis 4,.LC101@ha
	mr 3,30
	la 4,.LC101@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L383
	li 0,2
	lis 5,.LC102@ha
	stw 0,352(31)
	mr 3,31
	la 5,.LC102@l(5)
	b .L860
.L383:
	lis 4,.LC47@ha
	mr 3,30
	la 4,.LC47@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L385
	li 0,3
	lis 5,.LC103@ha
	stw 0,352(31)
	mr 3,31
	la 5,.LC103@l(5)
.L860:
	lwz 0,8(29)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L382
.L385:
	li 0,0
	stw 0,352(31)
.L382:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe39:
	.size	 SpecialWhat,.Lfe39-SpecialWhat
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
