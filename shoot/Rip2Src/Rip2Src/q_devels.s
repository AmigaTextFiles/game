	.file	"q_devels.c"
gcc2_compiled.:
	.lcomm	st.9,100,4
	.section	".text"
	.align 2
	.globl localcmd
	.type	 localcmd,@function
localcmd:
	stwu 1,-160(1)
	mflr 0
	stmw 29,148(1)
	stw 0,164(1)
	lis 12,0x100
	addi 11,1,168
	stw 4,12(1)
	addi 0,1,8
	stw 11,132(1)
	stw 0,136(1)
	stw 5,16(1)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	stw 12,128(1)
	bc 4,6,.L8
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L8:
	addi 11,1,128
	addi 9,1,112
	lwz 0,4(11)
	mr 4,3
	lis 29,st.9@ha
	lwz 10,8(11)
	mr 5,9
	la 3,st.9@l(29)
	stw 12,112(1)
	stw 0,4(9)
	stw 10,8(9)
	bl vsprintf
	lis 9,gi+168@ha
	la 3,st.9@l(29)
	lwz 0,gi+168@l(9)
	mtlr 0
	blrl
	lwz 0,164(1)
	mtlr 0
	lmw 29,148(1)
	la 1,160(1)
	blr
.Lfe1:
	.size	 localcmd,.Lfe1-localcmd
	.section	".rodata"
	.align 2
.LC0:
	.string	"player"
	.lcomm	st.16,100,4
	.section	".text"
	.align 2
	.globl strcat_
	.type	 strcat_,@function
strcat_:
	stwu 1,-160(1)
	mflr 0
	stmw 29,148(1)
	stw 0,164(1)
	lis 12,0x200
	addi 0,1,168
	stw 5,16(1)
	addi 11,1,8
	stw 0,132(1)
	mr 31,3
	stw 11,136(1)
	stw 6,20(1)
	stw 7,24(1)
	stw 8,28(1)
	stw 9,32(1)
	stw 10,36(1)
	stw 12,128(1)
	bc 4,6,.L19
	stfd 1,40(1)
	stfd 2,48(1)
	stfd 3,56(1)
	stfd 4,64(1)
	stfd 5,72(1)
	stfd 6,80(1)
	stfd 7,88(1)
	stfd 8,96(1)
.L19:
	addi 11,1,128
	addi 9,1,112
	lwz 10,8(11)
	lis 29,st.16@ha
	mr 5,9
	lwz 0,4(11)
	la 3,st.16@l(29)
	stw 12,112(1)
	stw 0,4(9)
	stw 10,8(9)
	bl vsprintf
	mr 3,31
	la 4,st.16@l(29)
	bl strcat
	lwz 0,164(1)
	mtlr 0
	lmw 29,148(1)
	la 1,160(1)
	blr
.Lfe2:
	.size	 strcat_,.Lfe2-strcat_
	.section	".rodata"
	.align 2
.LC1:
	.string	"ERROR: ent is not fully in the game\n"
	.section	".text"
	.align 2
	.globl ent_by_name
	.type	 ent_by_name,@function
ent_by_name:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 30,3
	lis 5,.LC0@ha
	b .L10
.L12:
	mr 3,31
	bl G_ClientExists
	cmpwi 0,3,0
	bc 12,2,.L30
	lwz 3,84(31)
	mr 4,30
	addi 3,3,700
	bl stricmp
	addic 3,3,-1
	subfe 3,3,3
	and 3,31,3
	b .L29
.L10:
	la 5,.LC0@l(5)
	li 3,0
	li 4,280
	bl G_Find
	mr. 31,3
	bc 4,2,.L12
.L30:
	li 3,0
.L29:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 ent_by_name,.Lfe3-ent_by_name
	.comm	nodes_done,4,4
	.comm	check_nodes_done,4,4
	.comm	loaded_trail_flag,4,4
	.comm	trail,3000,4
	.align 2
	.globl stuffcmd
	.type	 stuffcmd,@function
stuffcmd:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 3,11
	lwz 9,100(29)
	mr 28,4
	mtlr 9
	blrl
	lwz 9,116(29)
	mr 3,28
	mtlr 9
	blrl
	lwz 0,92(29)
	mr 3,27
	li 4,1
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe4:
	.size	 stuffcmd,.Lfe4-stuffcmd
	.align 2
	.globl GetAngle
	.type	 GetAngle,@function
GetAngle:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 28,8(1)
	stw 0,36(1)
	mr 29,3
	mr 28,4
	bl VectorLength
	fmr 31,1
	mr 3,28
	bl VectorLength
	lfs 12,4(28)
	lfs 13,4(29)
	fmuls 31,31,1
	lfs 0,0(29)
	lfs 11,0(28)
	fmuls 13,13,12
	lfs 1,8(29)
	lfs 12,8(28)
	fmadds 0,0,11,13
	fmadds 1,1,12,0
	fdivs 1,1,31
	bl asin
	frsp 1,1
	lwz 0,36(1)
	mtlr 0
	lmw 28,8(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 GetAngle,.Lfe5-GetAngle
	.section	".rodata"
	.align 2
.LC2:
	.long 0x41000000
	.section	".text"
	.align 2
	.globl WriteMessage
	.type	 WriteMessage,@function
WriteMessage:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L22
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L22
	cmpwi 7,4,0
	bc 12,30,.L28
	lwz 0,88(4)
	cmpwi 0,0,0
	bc 12,2,.L28
	lis 9,.LC2@ha
	li 7,0
	la 9,.LC2@l(9)
	lfs 10,0(9)
.L25:
	lfs 0,4(4)
	mr 11,9
	mr 10,9
	lwz 8,84(3)
	fmuls 0,0,10
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	sth 9,4(8)
	lfs 0,8(4)
	lwz 9,84(3)
	fmuls 0,0,10
	fctiwz 12,0
	stfd 12,8(1)
	lwz 11,12(1)
	sth 11,6(9)
	lfs 0,12(4)
	lwz 11,84(3)
	fmuls 0,0,10
	fctiwz 11,0
	stfd 11,8(1)
	lwz 10,12(1)
	sth 10,8(11)
	lfs 0,16(4)
	lwz 9,84(3)
	stfs 0,28(9)
	lfs 0,20(4)
	lwz 11,84(3)
	stfs 0,32(11)
	lfs 0,24(4)
	lwz 10,84(3)
	stfs 0,36(10)
	lwz 9,84(3)
	stw 7,88(9)
	bc 12,30,.L28
	lwz 0,88(4)
	cmpwi 0,0,0
	bc 4,2,.L25
	b .L28
.L22:
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L28:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe6:
	.size	 WriteMessage,.Lfe6-WriteMessage
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
