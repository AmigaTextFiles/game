	.file	"g_svcmds.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"Svcmd_Test_f()\n"
	.align 2
.LC1:
	.string	"game"
	.align 2
.LC2:
	.string	""
	.align 2
.LC3:
	.string	"basedir"
	.align 2
.LC4:
	.string	"."
	.align 2
.LC5:
	.string	"baseq2"
	.align 2
.LC6:
	.string	"%s"
	.align 2
.LC7:
	.string	"%s\\%s\\routes\\%s.dat"
	.align 2
.LC8:
	.string	"wb"
	.align 2
.LC9:
	.string	"Error opening file\n"
	.align 2
.LC10:
	.string	"Saving file with %d nodes\n"
	.section	".text"
	.align 2
	.globl cmd_Save_f
	.type	 cmd_Save_f,@function
cmd_Save_f:
	stwu 1,-432(1)
	mflr 0
	stmw 21,388(1)
	stw 0,436(1)
	lis 29,gi@ha
	lis 28,.LC2@ha
	la 29,gi@l(29)
	lis 3,.LC1@ha
	lwz 10,144(29)
	lis 9,node_count@ha
	la 4,.LC2@l(28)
	li 5,0
	la 3,.LC1@l(3)
	lhz 11,node_count@l(9)
	mtlr 10
	li 0,1
	stw 0,348(1)
	sth 11,344(1)
	blrl
	mr 31,3
	lwz 0,144(29)
	lis 4,.LC4@ha
	lis 3,.LC3@ha
	la 4,.LC4@l(4)
	li 5,0
	mtlr 0
	la 3,.LC3@l(3)
	blrl
	mr 30,3
	la 4,.LC2@l(28)
	lwz 3,4(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L8
	addi 29,1,264
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	b .L22
.L8:
	addi 29,1,264
	lwz 5,4(31)
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
.L22:
	mr 6,29
	lwz 5,4(30)
	lis 4,.LC7@ha
	lis 7,level+72@ha
	la 4,.LC7@l(4)
	la 7,level+72@l(7)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	lis 4,.LC8@ha
	addi 3,1,8
	la 4,.LC8@l(4)
	bl fopen
	mr. 31,3
	bc 4,2,.L10
	lis 4,.LC9@ha
	li 3,1
	la 4,.LC9@l(4)
	crxor 6,6,6
	bl safe_bprintf
	b .L7
.L10:
	lhz 5,344(1)
	lis 4,.LC10@ha
	li 3,1
	la 4,.LC10@l(4)
	li 29,0
	crxor 6,6,6
	bl safe_bprintf
	li 4,4
	li 5,1
	mr 6,31
	addi 3,1,348
	bl fwrite
	addi 3,1,344
	li 4,2
	li 5,1
	mr 6,31
	bl fwrite
	lhz 0,344(1)
	cmplw 0,29,0
	bc 4,0,.L12
	lis 9,node_list@ha
	lis 11,node_flags@ha
	la 23,node_list@l(9)
	la 21,node_flags@l(11)
	addi 22,23,8
	addi 25,1,346
.L14:
	mulli 0,29,12
	addi 9,23,4
	addi 3,1,352
	li 4,4
	li 5,1
	lfsx 12,9,0
	mr 6,31
	li 30,0
	lfsx 13,22,0
	addi 24,29,1
	lfsx 0,23,0
	stfs 12,356(1)
	stfs 13,360(1)
	stfs 0,352(1)
	bl fwrite
	addi 3,1,356
	li 4,4
	li 5,1
	mr 6,31
	bl fwrite
	li 4,4
	li 5,1
	mr 6,31
	addi 3,1,360
	bl fwrite
	slwi 0,29,2
	addi 3,1,364
	lwzx 9,21,0
	li 4,4
	li 5,1
	mr 6,31
	stw 9,364(1)
	bl fwrite
	lhz 0,344(1)
	cmplw 0,30,0
	bc 4,0,.L16
	lis 9,distance_table@ha
	lis 28,0xfff
	la 27,distance_table@l(9)
	slwi 26,29,12
	ori 28,28,65535
.L18:
	slwi 0,30,2
	add 29,0,26
	lwzx 9,27,29
	cmpw 0,9,28
	bc 12,1,.L17
	li 4,2
	li 5,1
	sth 30,346(1)
	mr 6,31
	mr 3,25
	bl fwrite
	lwzx 0,27,29
	addi 3,1,368
	li 4,4
	li 5,1
	mr 6,31
	stw 0,368(1)
	bl fwrite
.L17:
	addi 0,30,1
	lhz 9,344(1)
	rlwinm 30,0,0,0xffff
	cmplw 0,30,9
	bc 12,0,.L18
.L16:
	li 0,-1
	mr 3,25
	sth 0,346(1)
	li 4,2
	li 5,1
	mr 6,31
	rlwinm 29,24,0,0xffff
	bl fwrite
	lhz 0,344(1)
	cmplw 0,29,0
	bc 12,0,.L14
.L12:
	mr 3,31
	bl fclose
.L7:
	lwz 0,436(1)
	mtlr 0
	lmw 21,388(1)
	la 1,432(1)
	blr
.Lfe1:
	.size	 cmd_Save_f,.Lfe1-cmd_Save_f
	.section	".rodata"
	.align 2
.LC11:
	.string	"rb"
	.align 2
.LC12:
	.string	".....route file for %s not found\n"
	.align 2
.LC13:
	.string	".....mapping turned off\n"
	.align 2
.LC14:
	.string	".....mapping turned on\n"
	.align 2
.LC15:
	.string	"ERROR: Nodefile is incorrect version\n"
	.align 2
.LC16:
	.string	".....route file for %s found\n"
	.align 2
.LC17:
	.string	".....loading file with %d nodes\n"
	.align 2
.LC18:
	.string	"\nError loading file with %d nodes\n"
	.align 2
.LC19:
	.string	"Mapping automatically turned on\n"
	.align 2
.LC20:
	.string	".....loading complete\n"
	.align 2
.LC21:
	.long 0x0
	.section	".text"
	.align 2
	.globl cmd_Load_f
	.type	 cmd_Load_f,@function
cmd_Load_f:
	stwu 1,-416(1)
	mflr 0
	stmw 22,376(1)
	stw 0,420(1)
	lis 29,gi@ha
	lis 28,.LC2@ha
	la 29,gi@l(29)
	lis 3,.LC1@ha
	lwz 11,144(29)
	lis 9,node_count@ha
	la 4,.LC2@l(28)
	li 5,0
	la 3,.LC1@l(3)
	lhz 0,node_count@l(9)
	mtlr 11
	sth 0,344(1)
	blrl
	mr 31,3
	lwz 0,144(29)
	lis 4,.LC4@ha
	lis 3,.LC3@ha
	la 4,.LC4@l(4)
	li 5,0
	mtlr 0
	la 3,.LC3@l(3)
	blrl
	mr 30,3
	la 4,.LC2@l(28)
	lwz 3,4(31)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L24
	addi 29,1,264
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
	b .L41
.L24:
	addi 29,1,264
	lwz 5,4(31)
	lis 4,.LC6@ha
	la 4,.LC6@l(4)
	mr 3,29
	crxor 6,6,6
	bl sprintf
.L41:
	mr 6,29
	lwz 5,4(30)
	lis 4,.LC7@ha
	lis 28,level+72@ha
	la 4,.LC7@l(4)
	la 7,level+72@l(28)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	lis 4,.LC11@ha
	addi 3,1,8
	la 4,.LC11@l(4)
	bl fopen
	mr. 29,3
	bc 4,2,.L26
	lis 9,gi@ha
	lis 3,.LC12@ha
	la 31,gi@l(9)
	la 3,.LC12@l(3)
	lwz 9,4(31)
	la 4,level+72@l(28)
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,.LC21@ha
	la 9,.LC21@l(9)
	lfs 13,0(9)
	lis 9,deathmatch@ha
	lwz 11,deathmatch@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L27
	lwz 11,4(31)
	lis 3,.LC13@ha
	lis 9,path_time@ha
	la 3,.LC13@l(3)
	stfs 13,path_time@l(9)
	mtlr 11
	crxor 6,6,6
	blrl
.L27:
	lwz 11,4(31)
	lis 3,.LC14@ha
	lis 9,path_time@ha
	la 3,.LC14@l(3)
	lis 0,0x4316
	mtlr 11
	stw 0,path_time@l(9)
	crxor 6,6,6
	blrl
	b .L23
.L26:
	addi 3,1,348
	li 4,4
	li 5,1
	mr 6,29
	bl fread
	lwz 0,348(1)
	cmpwi 0,0,1
	bc 12,2,.L28
	mr 3,29
	bl fclose
	lis 9,gi+4@ha
	lis 3,.LC15@ha
	lwz 0,gi+4@l(9)
	la 3,.LC15@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L23
.L28:
	li 5,1
	mr 6,29
	addi 3,1,344
	li 4,2
	bl fread
	lis 9,gi@ha
	lis 3,.LC16@ha
	la 30,gi@l(9)
	la 3,.LC16@l(3)
	lwz 9,4(30)
	la 4,level+72@l(28)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,4(30)
	lis 3,.LC17@ha
	la 3,.LC17@l(3)
	lhz 4,344(1)
	mtlr 9
	crxor 6,6,6
	blrl
	lhz 0,344(1)
	rlwinm 31,0,0,0xffff
	cmpwi 0,31,0
	bc 4,2,.L29
	mr 3,29
	bl fclose
	lwz 9,4(30)
	lis 3,.LC18@ha
	la 3,.LC18@l(3)
	lhz 4,344(1)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,4(30)
	lis 3,.LC19@ha
	la 3,.LC19@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	lis 9,node_count@ha
	sth 31,node_count@l(9)
	b .L23
.L29:
	li 28,0
	lis 9,node_count@ha
	cmplw 0,28,31
	sth 0,node_count@l(9)
	bc 4,0,.L31
	lis 9,node_list@ha
	lis 11,node_flags@ha
	la 26,node_list@l(9)
	li 27,0
	lis 9,distance_table@ha
	la 22,node_flags@l(11)
	addi 23,26,4
	addi 24,26,8
	la 25,distance_table@l(9)
	ori 27,27,65535
.L33:
	addi 3,1,352
	mr 6,29
	li 4,4
	li 5,1
	bl fread
	li 30,0
	addi 3,1,356
	mr 6,29
	li 4,4
	li 5,1
	bl fread
	mr 6,29
	addi 3,1,360
	li 4,4
	li 5,1
	bl fread
	lfs 12,352(1)
	mulli 0,28,12
	addi 3,1,364
	li 4,4
	lfs 0,360(1)
	li 5,1
	mr 6,29
	lfs 13,356(1)
	stfsx 12,26,0
	stfsx 0,24,0
	stfsx 13,23,0
	bl fread
	lwz 9,364(1)
	slwi 0,28,2
	stwx 9,22,0
	addi 31,28,1
	b .L34
.L38:
	addi 3,1,368
	li 4,4
	li 5,1
	mr 6,29
	bl fread
	lhz 0,346(1)
	slwi 10,28,12
	addi 9,30,1
	lwz 11,368(1)
	rlwinm 30,9,0,0xffff
	slwi 0,0,2
	add 0,0,10
	stwx 11,25,0
.L34:
	lhz 0,344(1)
	cmplw 0,30,0
	bc 4,0,.L32
	addi 3,1,346
	li 4,2
	li 5,1
	mr 6,29
	bl fread
	lhz 0,346(1)
	cmpw 0,0,27
	bc 4,2,.L38
.L32:
	lhz 0,344(1)
	rlwinm 28,31,0,0xffff
	cmplw 0,28,0
	bc 12,0,.L33
.L31:
	mr 3,29
	bl fclose
	lis 29,gi@ha
	lis 3,.LC20@ha
	la 29,gi@l(29)
	la 3,.LC20@l(3)
	lwz 11,4(29)
	li 0,0
	lis 9,path_time@ha
	stw 0,path_time@l(9)
	mtlr 11
	crxor 6,6,6
	blrl
	lwz 0,4(29)
	lis 3,.LC13@ha
	la 3,.LC13@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L23:
	lwz 0,420(1)
	mtlr 0
	lmw 22,376(1)
	la 1,416(1)
	blr
.Lfe2:
	.size	 cmd_Load_f,.Lfe2-cmd_Load_f
	.section	".rodata"
	.align 2
.LC22:
	.string	"Bad filter address: %s\n"
	.section	".text"
	.align 2
	.type	 StringToFilter,@function
StringToFilter:
	stwu 1,-192(1)
	mflr 0
	stmw 24,160(1)
	stw 0,196(1)
	li 10,4
	addi 28,1,136
	mtctr 10
	addi 29,1,140
	mr 11,28
	mr 9,29
	mr 31,3
	mr 27,4
	li 30,0
	li 0,0
.L61:
	stbx 0,30,11
	stbx 0,30,9
	addi 30,30,1
	bdnz .L61
	li 30,0
	lis 24,.LC22@ha
	li 25,0
	li 26,255
.L51:
	lbz 9,0(31)
	addi 9,9,-48
	cmplwi 0,9,9
	bc 4,1,.L52
	li 3,0
	la 5,.LC22@l(24)
	mr 6,31
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	li 3,0
	b .L60
.L52:
	addi 3,1,8
	li 11,0
	mr 10,3
.L55:
	lbz 0,0(31)
	lbzu 9,1(31)
	stbx 0,10,11
	addi 9,9,-48
	addi 11,11,1
	cmplwi 0,9,9
	bc 4,1,.L55
	stbx 25,3,11
	bl atoi
	rlwinm 0,3,0,0xff
	stbx 3,30,28
	cmpwi 0,0,0
	bc 12,2,.L57
	stbx 26,30,29
.L57:
	lbz 0,0(31)
	cmpwi 0,0,0
	bc 12,2,.L49
	addi 30,30,1
	addi 31,31,1
	cmpwi 0,30,3
	bc 4,1,.L51
.L49:
	lwz 9,140(1)
	li 3,1
	lwz 0,136(1)
	stw 9,0(27)
	stw 0,4(27)
.L60:
	lwz 0,196(1)
	mtlr 0
	lmw 24,160(1)
	la 1,192(1)
	blr
.Lfe3:
	.size	 StringToFilter,.Lfe3-StringToFilter
	.section	".rodata"
	.align 2
.LC23:
	.long 0x0
	.section	".text"
	.align 2
	.globl SV_FilterPacket
	.type	 SV_FilterPacket,@function
SV_FilterPacket:
	stwu 1,-32(1)
	lbz 0,0(3)
	li 8,0
	cmpwi 0,0,0
	bc 12,2,.L64
	addi 6,1,8
	li 5,0
.L65:
	stbx 5,8,6
	lbz 10,0(3)
	addi 0,10,-48
	cmplwi 0,0,9
	bc 12,1,.L67
	mr 7,6
	mr 9,5
.L68:
	rlwinm 9,9,0,0xff
	mulli 9,9,10
	addi 9,9,208
	add 11,10,9
	lbzu 10,1(3)
	mr 9,11
	addi 0,10,-48
	cmplwi 0,0,9
	bc 4,1,.L68
	stbx 11,8,7
.L67:
	lbz 0,0(3)
	xori 9,0,58
	subfic 11,9,0
	adde 9,11,9
	subfic 11,0,0
	adde 0,11,0
	or. 11,0,9
	bc 4,2,.L64
	addi 8,8,1
	lbzu 0,1(3)
	cmpwi 7,8,3
	neg 0,0
	srwi 0,0,31
	cror 31,30,28
	mfcr 9
	rlwinm 9,9,0,1
	and. 11,0,9
	bc 4,2,.L65
.L64:
	lis 9,numipfilters@ha
	li 8,0
	lwz 6,8(1)
	lwz 0,numipfilters@l(9)
	cmpw 0,8,0
	bc 4,0,.L73
	lis 9,filterban@ha
	lis 11,ipfilters@ha
	lwz 7,filterban@l(9)
	mr 10,0
	la 11,ipfilters@l(11)
.L75:
	lwz 0,0(11)
	lwz 9,4(11)
	and 0,6,0
	cmpw 0,0,9
	bc 4,2,.L74
	lfs 0,20(7)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 3,28(1)
	b .L78
.L74:
	addi 8,8,1
	addi 11,11,8
	cmpw 0,8,10
	bc 12,0,.L75
.L73:
	lis 9,.LC23@ha
	lis 11,filterban@ha
	la 9,.LC23@l(9)
	lfs 13,0(9)
	lwz 9,filterban@l(11)
	lfs 0,20(9)
	fcmpu 7,0,13
	mfcr 3
	rlwinm 3,3,31,1
.L78:
	la 1,32(1)
	blr
.Lfe4:
	.size	 SV_FilterPacket,.Lfe4-SV_FilterPacket
	.section	".rodata"
	.align 2
.LC24:
	.string	"Usage:  addip <ip-mask>\n"
	.align 2
.LC25:
	.string	"IP filter list is full\n"
	.section	".text"
	.align 2
	.globl SVCmd_AddIP_f
	.type	 SVCmd_AddIP_f,@function
SVCmd_AddIP_f:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	lis 9,gi+156@ha
	lwz 0,gi+156@l(9)
	mtlr 0
	blrl
	cmpwi 0,3,2
	bc 12,1,.L81
	lis 5,.LC24@ha
	li 3,0
	la 5,.LC24@l(5)
	b .L91
.L81:
	lis 9,numipfilters@ha
	li 31,0
	lwz 11,numipfilters@l(9)
	cmpw 0,31,11
	bc 4,0,.L83
	lis 9,ipfilters@ha
	la 9,ipfilters@l(9)
	lwz 0,4(9)
	addi 10,9,4
	cmpwi 0,0,-1
	bc 12,2,.L83
	mr 9,10
.L84:
	addi 31,31,1
	cmpw 0,31,11
	bc 4,0,.L83
	lwzu 0,8(9)
	cmpwi 0,0,-1
	bc 4,2,.L84
.L83:
	lis 9,numipfilters@ha
	lwz 0,numipfilters@l(9)
	cmpw 0,31,0
	bc 4,2,.L88
	cmpwi 0,31,1024
	bc 4,2,.L89
	lis 5,.LC25@ha
	li 3,0
	la 5,.LC25@l(5)
.L91:
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L80
.L89:
	addi 0,31,1
	lis 9,numipfilters@ha
	stw 0,numipfilters@l(9)
.L88:
	lis 9,gi+160@ha
	li 3,2
	lwz 0,gi+160@l(9)
	slwi 31,31,3
	mtlr 0
	blrl
	lis 9,ipfilters@ha
	la 30,ipfilters@l(9)
	add 4,31,30
	bl StringToFilter
	cmpwi 0,3,0
	bc 4,2,.L80
	addi 9,30,4
	li 0,-1
	stwx 0,9,31
.L80:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe5:
	.size	 SVCmd_AddIP_f,.Lfe5-SVCmd_AddIP_f
	.section	".rodata"
	.align 2
.LC26:
	.string	"Usage:  sv removeip <ip-mask>\n"
	.align 2
.LC27:
	.string	"Removed.\n"
	.align 2
.LC28:
	.string	"Didn't find %s.\n"
	.section	".text"
	.align 2
	.globl SVCmd_RemoveIP_f
	.type	 SVCmd_RemoveIP_f,@function
SVCmd_RemoveIP_f:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,156(29)
	mtlr 9
	blrl
	cmpwi 0,3,2
	bc 12,1,.L93
	lis 5,.LC26@ha
	li 3,0
	la 5,.LC26@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L92
.L93:
	lwz 0,160(29)
	li 3,2
	addi 29,1,8
	mtlr 0
	blrl
	mr 4,29
	bl StringToFilter
	cmpwi 0,3,0
	bc 12,2,.L92
	lis 9,numipfilters@ha
	li 10,0
	lwz 0,numipfilters@l(9)
	lis 8,numipfilters@ha
	cmpw 0,10,0
	bc 4,0,.L96
	lis 9,ipfilters@ha
	lis 7,numipfilters@ha
	la 11,ipfilters@l(9)
	lis 6,numipfilters@ha
	mr 4,11
.L98:
	lwz 9,0(11)
	lwz 0,8(1)
	cmpw 0,9,0
	bc 4,2,.L97
	lwz 9,4(11)
	lwz 0,4(29)
	cmpw 0,9,0
	bc 4,2,.L97
	lwz 0,numipfilters@l(8)
	addi 10,10,1
	lis 5,.LC27@ha
	mtctr 10
	cmpw 0,10,0
	bc 4,0,.L101
	slwi 0,10,3
	lwz 9,numipfilters@l(6)
	add 11,0,4
	mfctr 0
	subf 0,0,9
	mtctr 0
.L103:
	lfd 0,0(11)
	stfd 0,-8(11)
	addi 11,11,8
	bdnz .L103
.L101:
	lwz 9,numipfilters@l(7)
	la 5,.LC27@l(5)
	li 3,0
	li 4,2
	addi 9,9,-1
	stw 9,numipfilters@l(7)
	crxor 6,6,6
	bl safe_cprintf
	b .L92
.L97:
	lwz 0,numipfilters@l(8)
	addi 10,10,1
	addi 11,11,8
	cmpw 0,10,0
	bc 12,0,.L98
.L96:
	lis 9,gi+160@ha
	li 3,2
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	mr 6,3
	lis 5,.LC28@ha
	la 5,.LC28@l(5)
	li 3,0
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L92:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 SVCmd_RemoveIP_f,.Lfe6-SVCmd_RemoveIP_f
	.section	".rodata"
	.align 2
.LC29:
	.string	"Filter list:\n"
	.align 2
.LC30:
	.string	"%3i.%3i.%3i.%3i\n"
	.align 2
.LC31:
	.string	"%s/listip.cfg"
	.align 2
.LC32:
	.string	"swtc"
	.align 2
.LC33:
	.string	"Writing %s.\n"
	.align 2
.LC34:
	.string	"Couldn't open %s\n"
	.align 2
.LC35:
	.string	"set filterban %d\n"
	.align 2
.LC36:
	.string	"sv addip %i.%i.%i.%i\n"
	.section	".text"
	.align 2
	.globl SVCmd_WriteIP_f
	.type	 SVCmd_WriteIP_f,@function
SVCmd_WriteIP_f:
	stwu 1,-192(1)
	mflr 0
	stmw 26,168(1)
	stw 0,196(1)
	lis 9,gi+144@ha
	lis 3,.LC1@ha
	lwz 0,gi+144@l(9)
	lis 4,.LC2@ha
	li 5,0
	la 3,.LC1@l(3)
	la 4,.LC2@l(4)
	mtlr 0
	blrl
	lwz 5,4(3)
	lbz 0,0(5)
	cmpwi 0,0,0
	bc 4,2,.L113
	lis 4,.LC31@ha
	lis 5,.LC32@ha
	la 4,.LC31@l(4)
	la 5,.LC32@l(5)
	addi 3,1,8
	crxor 6,6,6
	bl sprintf
	b .L114
.L113:
	lis 4,.LC31@ha
	addi 3,1,8
	la 4,.LC31@l(4)
	crxor 6,6,6
	bl sprintf
.L114:
	lis 5,.LC33@ha
	li 4,2
	li 3,0
	la 5,.LC33@l(5)
	addi 6,1,8
	crxor 6,6,6
	bl safe_cprintf
	lis 4,.LC8@ha
	addi 3,1,8
	la 4,.LC8@l(4)
	bl fopen
	mr. 28,3
	bc 4,2,.L115
	lis 5,.LC34@ha
	li 3,0
	la 5,.LC34@l(5)
	li 4,2
	addi 6,1,8
	crxor 6,6,6
	bl safe_cprintf
	b .L112
.L115:
	lis 9,filterban@ha
	lwz 11,filterban@l(9)
	lis 4,.LC35@ha
	mr 3,28
	la 4,.LC35@l(4)
	li 29,0
	lfs 0,20(11)
	lis 26,numipfilters@ha
	fctiwz 13,0
	stfd 13,160(1)
	lwz 5,164(1)
	crxor 6,6,6
	bl fprintf
	lis 9,numipfilters@ha
	lwz 0,numipfilters@l(9)
	cmpw 0,29,0
	bc 4,0,.L117
	lis 9,ipfilters@ha
	addi 31,1,136
	la 9,ipfilters@l(9)
	lis 27,.LC36@ha
	addi 30,9,4
.L119:
	lwz 5,0(30)
	mr 3,28
	la 4,.LC36@l(27)
	addi 29,29,1
	addi 30,30,8
	stw 5,136(1)
	lbz 6,1(31)
	srwi 5,5,24
	lbz 7,2(31)
	lbz 8,3(31)
	crxor 6,6,6
	bl fprintf
	lwz 0,numipfilters@l(26)
	cmpw 0,29,0
	bc 12,0,.L119
.L117:
	mr 3,28
	bl fclose
.L112:
	lwz 0,196(1)
	mtlr 0
	lmw 26,168(1)
	la 1,192(1)
	blr
.Lfe7:
	.size	 SVCmd_WriteIP_f,.Lfe7-SVCmd_WriteIP_f
	.section	".rodata"
	.align 2
.LC37:
	.string	"test"
	.align 2
.LC38:
	.string	"addip"
	.align 2
.LC39:
	.string	"removeip"
	.align 2
.LC40:
	.string	"listip"
	.align 2
.LC41:
	.string	"writeip"
	.align 2
.LC42:
	.string	"Unknown server command \"%s\"\n"
	.section	".text"
	.align 2
	.globl ServerCommand
	.type	 ServerCommand,@function
ServerCommand:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 9,gi+160@ha
	li 3,1
	lwz 0,gi+160@l(9)
	mtlr 0
	blrl
	mr 31,3
	lis 4,.LC37@ha
	la 4,.LC37@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L122
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	b .L124
.L122:
	lis 4,.LC38@ha
	mr 3,31
	la 4,.LC38@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L125
	bl SVCmd_AddIP_f
	b .L124
.L125:
	lis 4,.LC39@ha
	mr 3,31
	la 4,.LC39@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L127
	bl SVCmd_RemoveIP_f
	b .L124
.L127:
	lis 4,.LC40@ha
	mr 3,31
	la 4,.LC40@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L129
	lis 5,.LC29@ha
	li 3,0
	la 5,.LC29@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	li 30,0
	lis 27,numipfilters@ha
	lis 9,numipfilters@ha
	lwz 0,numipfilters@l(9)
	cmpw 0,30,0
	bc 4,0,.L124
	lis 9,ipfilters@ha
	addi 31,1,8
	la 9,ipfilters@l(9)
	lis 28,.LC30@ha
	addi 29,9,4
.L132:
	lwz 6,0(29)
	li 3,0
	li 4,2
	la 5,.LC30@l(28)
	addi 30,30,1
	stw 6,8(1)
	addi 29,29,8
	lbz 7,1(31)
	srwi 6,6,24
	lbz 8,2(31)
	lbz 9,3(31)
	crxor 6,6,6
	bl safe_cprintf
	lwz 0,numipfilters@l(27)
	cmpw 0,30,0
	bc 12,0,.L132
	b .L124
.L129:
	lis 4,.LC41@ha
	mr 3,31
	la 4,.LC41@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L137
	bl SVCmd_WriteIP_f
	b .L124
.L137:
	lis 5,.LC42@ha
	mr 6,31
	la 5,.LC42@l(5)
	li 3,0
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
.L124:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe8:
	.size	 ServerCommand,.Lfe8-ServerCommand
	.comm	node_count,2,2
	.comm	path_not_time_yet,4,4
	.comm	conversation_content,7760,4
	.comm	highlighted,4,4
	.comm	yeah_you,4,4
	.comm	its_me,4,4
	.comm	holdthephone,4,4
	.comm	NoTouch,4,4
	.comm	showingit,4,4
	.comm	path_time,4,4
	.comm	print_time,4,4
	.align 2
	.globl Svcmd_Test_f
	.type	 Svcmd_Test_f,@function
Svcmd_Test_f:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 5,.LC0@ha
	li 3,0
	la 5,.LC0@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe9:
	.size	 Svcmd_Test_f,.Lfe9-Svcmd_Test_f
	.comm	ipfilters,8192,4
	.comm	numipfilters,4,4
	.align 2
	.globl SVCmd_ListIP_f
	.type	 SVCmd_ListIP_f,@function
SVCmd_ListIP_f:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 5,.LC29@ha
	li 3,0
	la 5,.LC29@l(5)
	li 4,2
	crxor 6,6,6
	bl safe_cprintf
	li 30,0
	lis 27,numipfilters@ha
	lis 9,numipfilters@ha
	lwz 0,numipfilters@l(9)
	cmpw 0,30,0
	bc 4,0,.L108
	lis 9,ipfilters@ha
	addi 31,1,8
	la 9,ipfilters@l(9)
	lis 28,.LC30@ha
	addi 29,9,4
.L110:
	lwz 6,0(29)
	li 3,0
	li 4,2
	la 5,.LC30@l(28)
	addi 30,30,1
	stw 6,8(1)
	addi 29,29,8
	lbz 7,1(31)
	srwi 6,6,24
	lbz 8,2(31)
	lbz 9,3(31)
	crxor 6,6,6
	bl safe_cprintf
	lwz 0,numipfilters@l(27)
	cmpw 0,30,0
	bc 12,0,.L110
.L108:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 SVCmd_ListIP_f,.Lfe10-SVCmd_ListIP_f
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
