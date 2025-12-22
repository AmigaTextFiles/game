	.file	"ModUtils.c"
gcc2_compiled.:
	.section	".rodata"
	.align 3
.LC0:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl PlayerHasShellEffects
	.type	 PlayerHasShellEffects,@function
PlayerHasShellEffects:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	mr. 31,3
	bc 4,2,.L24
	li 3,0
	b .L36
.L24:
	lis 9,level+4@ha
	lfs 13,500(31)
	lfs 0,level+4@l(9)
	fcmpu 0,13,0
	bc 4,1,.L25
	mr 3,31
	bl PowerArmorType
	cmpwi 0,3,1
	bc 12,2,.L34
	cmpwi 0,3,2
	bc 12,2,.L34
.L25:
	lis 11,level@ha
	lwz 10,84(31)
	lwz 0,level@l(11)
	lis 8,0x4330
	lis 11,.LC0@ha
	lfs 12,3728(10)
	mr 7,10
	xoris 0,0,0x8000
	la 11,.LC0@l(11)
	stw 0,20(1)
	stw 8,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L29
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpwi 0,0,30
	bc 12,1,.L34
	andi. 9,0,4
	bc 4,2,.L34
.L29:
	lis 11,level@ha
	lfs 12,3732(7)
	lwz 0,level@l(11)
	lis 10,0x4330
	lis 11,.LC0@ha
	xoris 0,0,0x8000
	la 11,.LC0@l(11)
	stw 0,20(1)
	stw 10,16(1)
	lfd 13,0(11)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,12,0
	bc 4,1,.L32
	fsubs 0,12,0
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpwi 0,0,30
	bc 12,1,.L34
	andi. 9,0,4
	bc 12,2,.L32
.L34:
	li 3,1
	b .L36
.L32:
	lwz 3,264(31)
	rlwinm 3,3,28,31,31
.L36:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 PlayerHasShellEffects,.Lfe1-PlayerHasShellEffects
	.section	".rodata"
	.align 2
.LC1:
	.string	"ModUtils: no clients for random client?\n"
	.align 2
.LC2:
	.long 0x3f800000
	.align 3
.LC3:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl GetRandomClient
	.type	 GetRandomClient,@function
GetRandomClient:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 11,.LC2@ha
	lis 9,maxclients@ha
	la 11,.LC2@l(11)
	li 31,0
	lfs 0,0(11)
	li 7,1
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L91
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	addi 8,11,892
	lfd 13,0(9)
.L84:
	lwz 0,88(8)
	cmpwi 0,0,0
	bc 12,2,.L85
	lwz 0,84(8)
	cmpwi 0,0,0
	bc 4,2,.L86
.L85:
	li 9,0
	b .L87
.L86:
	li 9,1
.L87:
	addi 7,7,1
	xoris 0,7,0x8000
	addic 9,9,-1
	subfe 9,9,9
	stw 0,20(1)
	addi 10,31,1
	addi 8,8,892
	stw 6,16(1)
	and 0,31,9
	lfd 0,16(1)
	andc 9,10,9
	or 31,0,9
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L84
.L91:
	cmpwi 0,31,0
	bc 4,2,.L93
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
	b .L102
.L93:
	bl rand
	divw 0,3,31
	lis 9,maxclients@ha
	li 7,0
	lwz 11,maxclients@l(9)
	li 8,1
	lis 9,.LC2@ha
	la 9,.LC2@l(9)
	lfs 13,20(11)
	lfs 0,0(9)
	fcmpu 0,0,13
	mullw 0,0,31
	subf 10,0,3
	cror 3,2,0
	bc 4,3,.L95
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC3@ha
	la 9,.LC3@l(9)
	addi 3,11,892
	lfd 13,0(9)
.L97:
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L96
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 12,2,.L96
	cmpw 0,7,10
	bc 12,2,.L102
	addi 7,7,1
.L96:
	addi 8,8,1
	xoris 0,8,0x8000
	addi 3,3,892
	stw 0,20(1)
	stw 6,16(1)
	lfd 0,16(1)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L97
.L95:
	lis 9,gi+4@ha
	lis 3,.LC1@ha
	lwz 0,gi+4@l(9)
	la 3,.LC1@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	li 3,0
.L102:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 GetRandomClient,.Lfe2-GetRandomClient
	.section	".rodata"
	.align 2
.LC4:
	.string	"<b>"
	.align 2
.LC5:
	.string	"</b>"
	.section	".text"
	.align 2
	.globl FormatBoldString
	.type	 FormatBoldString,@function
FormatBoldString:
	stwu 1,-32(1)
	stmw 27,12(1)
	li 31,0
	li 29,0
	lbzx 0,3,31
	li 12,0
	cmpwi 0,0,0
	bc 12,2,.L113
	lis 9,.LC4@ha
	lis 11,.LC5@ha
	la 27,.LC4@l(9)
	la 28,.LC5@l(11)
.L115:
	add 5,3,12
	lis 6,0xf
	mr 30,5
	mr 4,27
	ori 6,6,16959
.L118:
	lbz 8,0(4)
	lbz 7,0(5)
	addi 4,4,1
	cmpwi 0,8,0
	addi 5,5,1
	bc 12,2,.L153
	cmpwi 0,6,0
	addi 6,6,-1
	bc 12,2,.L153
	cmpw 0,8,7
	bc 12,2,.L126
	addi 0,8,-97
	addi 9,7,-97
	subfic 0,0,25
	subfe 0,0,0
	subfic 9,9,25
	subfe 9,9,9
	addi 11,8,-32
	addi 10,7,-32
	andc 11,11,0
	andc 10,10,9
	and 0,8,0
	and 9,7,9
	or 8,0,11
	or 7,9,10
	cmpw 0,8,7
	bc 4,2,.L149
.L126:
	cmpwi 0,8,0
	bc 4,2,.L118
.L153:
	li 0,1
.L120:
	cmpwi 0,0,0
	bc 12,2,.L116
	li 29,1
	addi 12,12,2
	b .L114
.L149:
	li 0,0
	b .L120
.L152:
	li 0,0
	b .L133
.L116:
	lis 6,0xf
	mr 5,30
	mr 4,28
	ori 6,6,16959
.L131:
	lbz 8,0(4)
	lbz 7,0(5)
	addi 4,4,1
	cmpwi 0,8,0
	addi 5,5,1
	bc 12,2,.L154
	cmpwi 0,6,0
	addi 6,6,-1
	bc 12,2,.L154
	cmpw 0,8,7
	bc 12,2,.L139
	addi 0,8,-97
	addi 9,7,-97
	subfic 0,0,25
	subfe 0,0,0
	subfic 9,9,25
	subfe 9,9,9
	addi 11,8,-32
	addi 10,7,-32
	andc 11,11,0
	andc 10,10,9
	and 0,8,0
	and 9,7,9
	or 8,0,11
	or 7,9,10
	cmpw 0,8,7
	bc 4,2,.L152
.L139:
	cmpwi 0,8,0
	bc 4,2,.L131
.L154:
	li 0,1
.L133:
	cmpwi 0,0,0
	bc 12,2,.L129
	li 29,0
	addi 12,12,3
	b .L114
.L129:
	cmpwi 0,29,0
	bc 12,2,.L142
	lbzx 9,3,12
	cmpwi 0,9,10
	bc 4,2,.L143
	stbx 9,3,31
	b .L155
.L143:
	addi 0,9,128
	b .L156
.L142:
	lbzx 0,3,12
.L156:
	stbx 0,3,31
.L155:
	addi 31,31,1
.L114:
	addi 12,12,1
	lbzx 0,3,12
	cmpwi 0,0,0
	bc 4,2,.L115
.L113:
	li 0,0
	stbx 0,3,31
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 FormatBoldString,.Lfe3-FormatBoldString
	.comm	highscore,1080,4
	.comm	gamescore,540,4
	.align 2
	.globl StrBeginsWith
	.type	 StrBeginsWith,@function
StrBeginsWith:
	lis 6,0xf
	ori 6,6,16959
.L16:
	lbz 8,0(3)
	lbz 7,0(4)
	addi 3,3,1
	cmpwi 0,8,0
	addi 4,4,1
	bc 4,2,.L10
.L158:
	li 3,1
	blr
.L10:
	cmpwi 0,6,0
	addi 6,6,-1
	bc 12,2,.L158
	cmpw 0,8,7
	bc 12,2,.L9
	addi 0,8,-97
	addi 9,7,-97
	subfic 0,0,25
	subfe 0,0,0
	subfic 9,9,25
	subfe 9,9,9
	addi 11,8,-32
	addi 10,7,-32
	andc 11,11,0
	andc 10,10,9
	and 0,8,0
	and 9,7,9
	or 8,0,11
	or 7,9,10
	cmpw 0,8,7
	bc 12,2,.L9
	li 3,0
	blr
.L9:
	cmpwi 0,8,0
	bc 4,2,.L16
	li 3,1
	blr
.Lfe4:
	.size	 StrBeginsWith,.Lfe4-StrBeginsWith
	.align 2
	.globl SetPlayerShellColor
	.type	 SetPlayerShellColor,@function
SetPlayerShellColor:
	mr. 4,4
	li 0,0
	stw 0,64(3)
	bc 4,2,.L18
	lwz 0,68(3)
	stw 4,64(3)
	rlwinm 0,0,0,22,18
	stw 0,68(3)
	blr
.L18:
	lwz 0,68(3)
	li 9,256
	stw 9,64(3)
	rlwinm 0,0,0,22,18
	or 0,0,4
	stw 0,68(3)
	blr
.Lfe5:
	.size	 SetPlayerShellColor,.Lfe5-SetPlayerShellColor
	.section	".rodata"
	.align 2
.LC6:
	.long 0x3f800000
	.align 3
.LC7:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl FindClientByNetname
	.type	 FindClientByNetname,@function
FindClientByNetname:
	stwu 1,-64(1)
	mflr 0
	stfd 31,56(1)
	stmw 25,28(1)
	stw 0,68(1)
	lis 11,.LC6@ha
	lis 9,maxclients@ha
	la 11,.LC6@l(11)
	mr 28,3
	lfs 13,0(11)
	li 29,1
	lis 25,maxclients@ha
	lwz 11,maxclients@l(9)
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L39
	lis 9,.LC7@ha
	lis 26,g_edicts@ha
	la 9,.LC7@l(9)
	lis 27,0x4330
	lfd 31,0(9)
	li 30,892
.L41:
	lwz 0,g_edicts@l(26)
	add 31,0,30
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L40
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L40
	addic. 4,0,700
	bc 12,2,.L40
	mr 3,28
	bl Q_strcasecmp
	cmpwi 0,3,0
	bc 4,2,.L40
	mr 3,31
	b .L159
.L40:
	addi 29,29,1
	lwz 11,maxclients@l(25)
	xoris 0,29,0x8000
	addi 30,30,892
	stw 0,20(1)
	stw 27,16(1)
	lfd 0,16(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L41
.L39:
	li 3,0
.L159:
	lwz 0,68(1)
	mtlr 0
	lmw 25,28(1)
	lfd 31,56(1)
	la 1,64(1)
	blr
.Lfe6:
	.size	 FindClientByNetname,.Lfe6-FindClientByNetname
	.section	".rodata"
	.align 2
.LC8:
	.long 0x3f800000
	.align 3
.LC9:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl FindClientByMatchingNetname
	.type	 FindClientByMatchingNetname,@function
FindClientByMatchingNetname:
	stwu 1,-80(1)
	mflr 0
	stfd 31,72(1)
	stmw 23,36(1)
	stw 0,84(1)
	lis 11,.LC8@ha
	lis 9,maxclients@ha
	la 11,.LC8@l(11)
	mr 27,3
	lfs 13,0(11)
	li 28,0
	li 29,1
	lwz 11,maxclients@l(9)
	lis 23,maxclients@ha
	lfs 0,20(11)
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L49
	lis 9,.LC9@ha
	lis 24,g_edicts@ha
	la 9,.LC9@l(9)
	lis 25,0x4330
	lfd 31,0(9)
	li 30,892
.L51:
	lwz 0,g_edicts@l(24)
	add 31,0,30
	lwz 9,88(31)
	cmpwi 0,9,0
	bc 12,2,.L50
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 12,2,.L50
	addic. 3,0,700
	bc 12,2,.L50
	mr 4,27
	bl strstr
	cmpwi 0,3,0
	bc 12,2,.L50
	mr 26,31
	addi 28,28,1
.L50:
	addi 29,29,1
	lwz 11,maxclients@l(23)
	xoris 0,29,0x8000
	addi 30,30,892
	stw 0,28(1)
	stw 25,24(1)
	lfd 0,24(1)
	lfs 13,20(11)
	fsub 0,0,31
	frsp 0,0
	fcmpu 0,0,13
	cror 3,2,0
	bc 12,3,.L51
.L49:
	xori 3,28,1
	addic 3,3,-1
	subfe 3,3,3
	and 3,26,3
	lwz 0,84(1)
	mtlr 0
	lmw 23,36(1)
	lfd 31,72(1)
	la 1,80(1)
	blr
.Lfe7:
	.size	 FindClientByMatchingNetname,.Lfe7-FindClientByMatchingNetname
	.align 2
	.globl MakeBoldString
	.type	 MakeBoldString,@function
MakeBoldString:
	lbz 9,0(3)
	cmpwi 0,9,0
	bclr 12,2
.L107:
	cmpwi 0,9,10
	bc 12,2,.L161
	addi 0,9,128
	stb 0,0(3)
.L161:
	addi 3,3,1
	lbz 9,0(3)
	cmpwi 0,9,0
	bc 4,2,.L107
	blr
.Lfe8:
	.size	 MakeBoldString,.Lfe8-MakeBoldString
	.section	".rodata"
	.align 2
.LC10:
	.long 0x3f800000
	.align 3
.LC11:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CountActiveClients
	.type	 CountActiveClients,@function
CountActiveClients:
	stwu 1,-16(1)
	lis 11,.LC10@ha
	lis 9,maxclients@ha
	la 11,.LC10@l(11)
	li 3,0
	lfs 0,0(11)
	li 7,1
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L65
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC11@ha
	la 9,.LC11@l(9)
	addi 8,11,892
	lfd 13,0(9)
.L67:
	lwz 0,88(8)
	cmpwi 0,0,0
	bc 12,2,.L69
	lwz 0,84(8)
	cmpwi 0,0,0
	bc 4,2,.L70
.L69:
	li 9,0
	b .L71
.L70:
	li 9,1
.L71:
	addi 7,7,1
	xoris 0,7,0x8000
	addic 9,9,-1
	subfe 9,9,9
	stw 0,12(1)
	addi 10,3,1
	addi 8,8,892
	stw 6,8(1)
	and 0,3,9
	lfd 0,8(1)
	andc 9,10,9
	or 3,0,9
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L67
.L65:
	la 1,16(1)
	blr
.Lfe9:
	.size	 CountActiveClients,.Lfe9-CountActiveClients
	.section	".rodata"
	.align 2
.LC12:
	.long 0x3f800000
	.align 3
.LC13:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl CountConnectedClients
	.type	 CountConnectedClients,@function
CountConnectedClients:
	stwu 1,-16(1)
	lis 11,.LC12@ha
	lis 9,maxclients@ha
	la 11,.LC12@l(11)
	li 3,0
	lfs 0,0(11)
	li 7,1
	lwz 11,maxclients@l(9)
	lfs 13,20(11)
	fcmpu 0,0,13
	cror 3,2,0
	bc 4,3,.L76
	lis 9,g_edicts@ha
	fmr 12,13
	lis 6,0x4330
	lwz 11,g_edicts@l(9)
	lis 9,.LC13@ha
	la 9,.LC13@l(9)
	addi 8,11,980
	lfd 13,0(9)
.L78:
	addi 7,7,1
	lwz 0,0(8)
	xoris 9,7,0x8000
	addi 11,3,1
	stw 9,12(1)
	addic 0,0,-1
	subfe 0,0,0
	addi 8,8,892
	stw 6,8(1)
	andc 11,11,0
	lfd 0,8(1)
	and 0,3,0
	or 3,0,11
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L78
.L76:
	la 1,16(1)
	blr
.Lfe10:
	.size	 CountConnectedClients,.Lfe10-CountConnectedClients
	.align 2
	.globl IsActiveClient
	.type	 IsActiveClient,@function
IsActiveClient:
	lwz 0,88(3)
	cmpwi 0,0,0
	bc 12,2,.L61
	lwz 0,84(3)
	cmpwi 0,0,0
	bc 4,2,.L60
.L61:
	li 3,0
	blr
.L60:
	li 3,1
	blr
.Lfe11:
	.size	 IsActiveClient,.Lfe11-IsActiveClient
	.align 2
	.globl SetPlayerShellColor314Hack
	.type	 SetPlayerShellColor314Hack,@function
SetPlayerShellColor314Hack:
	mr. 4,4
	li 0,0
	stw 0,64(3)
	bc 4,2,.L21
	lwz 0,68(3)
	stw 4,64(3)
	rlwinm 0,0,0,22,18
	stw 0,68(3)
	blr
.L21:
	lwz 0,68(3)
	li 9,256
	stw 9,64(3)
	rlwinm 0,0,0,22,18
	or 0,0,4
	stw 0,68(3)
	blr
.Lfe12:
	.size	 SetPlayerShellColor314Hack,.Lfe12-SetPlayerShellColor314Hack
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
