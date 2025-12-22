	.file	"e_team.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.string	"onSameTeam passed null player\n"
	.align 2
.LC1:
	.string	"You are on team %s\n"
	.align 2
.LC2:
	.string	"List of all teams:\n"
	.align 2
.LC3:
	.string	"  %s: wearing %s\n"
	.align 2
.LC4:
	.string	"Type \"team [teamname]\" to change team\n"
	.section	".text"
	.align 2
	.globl printTeamInfo
	.type	 printTeamInfo,@function
printTeamInfo:
	stwu 1,-48(1)
	mflr 0
	stmw 26,24(1)
	stw 0,52(1)
	lis 10,dmflags@ha
	lwz 11,dmflags@l(10)
	mr 30,3
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 0,9,192
	bc 12,2,.L37
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 9,11,256
	bc 12,2,.L38
	lwz 9,84(30)
	lwz 0,3476(9)
	nor 0,0,0
	addic 9,0,-1
	subfe 11,9,0
	mr 0,11
	b .L39
.L38:
	li 0,1
	b .L39
.L37:
	li 0,0
.L39:
	cmpwi 0,0,0
	bc 12,2,.L34
	lwz 11,84(30)
	lis 9,gTeams@ha
	lis 3,.LC1@ha
	la 9,gTeams@l(9)
	lis 29,gi@ha
	lwz 0,3476(11)
	la 29,gi@l(29)
	la 3,.LC1@l(3)
	mulli 0,0,20
	lwzx 4,9,0
	crxor 6,6,6
	bl va
	bl greenText
	lwz 0,8(29)
	mr 5,3
	li 4,2
	mr 3,30
	mtlr 0
	crxor 6,6,6
	blrl
.L34:
	lis 9,gi@ha
	lis 5,.LC2@ha
	la 29,gi@l(9)
	la 5,.LC2@l(5)
	lwz 9,8(29)
	mr 3,30
	li 4,2
	li 31,0
	lis 26,sv_numteams@ha
	mtlr 9
	crxor 6,6,6
	blrl
	lis 11,sv_numteams@ha
	lwz 9,sv_numteams@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpw 0,31,0
	bc 4,0,.L43
	lis 9,gTeams@ha
	mr 27,29
	la 29,gTeams@l(9)
	lis 28,.LC3@ha
.L45:
	lwz 9,8(27)
	mr 3,30
	li 4,2
	lwz 6,0(29)
	la 5,.LC3@l(28)
	addi 31,31,1
	lwz 7,4(29)
	mtlr 9
	addi 29,29,20
	crxor 6,6,6
	blrl
	lwz 9,sv_numteams@l(26)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpw 0,31,0
	bc 12,0,.L45
.L43:
	lis 29,gi@ha
	lis 3,.LC4@ha
	la 29,gi@l(29)
	la 3,.LC4@l(3)
	crxor 6,6,6
	bl va
	bl greenText
	lwz 0,8(29)
	mr 5,3
	li 4,2
	mr 3,30
	mtlr 0
	crxor 6,6,6
	blrl
	lwz 0,52(1)
	mtlr 0
	lmw 26,24(1)
	la 1,48(1)
	blr
.Lfe1:
	.size	 printTeamInfo,.Lfe1-printTeamInfo
	.section	".rodata"
	.align 2
.LC5:
	.string	"/"
	.lcomm	model.36,1024,1
	.section	".sbss","aw",@nobits
	.align 2
whichModel.37:
	.space	4
	.size	 whichModel.37,4
	.lcomm	skin.41,1024,1
	.align 2
whichSkin.42:
	.space	4
	.size	 whichSkin.42,4
	.section	".rodata"
	.align 2
.LC6:
	.string	""
	.section	".text"
	.align 2
	.globl weakerTeam
	.type	 weakerTeam,@function
weakerTeam:
	lis 9,gTeams@ha
	mulli 0,4,20
	mr 8,3
	la 9,gTeams@l(9)
	mulli 11,8,20
	addi 9,9,12
	lwzx 10,9,0
	lwzx 0,9,11
	cmpw 0,0,10
	bclr 12,0
	cmpw 0,10,0
	bc 4,0,.L79
	mr 3,4
	blr
.L79:
	lis 9,game+1544@ha
	li 7,0
	lwz 0,game+1544@l(9)
	cmpwi 0,0,0
	bc 4,1,.L88
	lis 11,g_edicts@ha
	mtctr 0
	lwz 9,g_edicts@l(11)
	addi 9,9,916
.L84:
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L87
	lwz 11,84(9)
	cmpwi 0,11,0
	bc 12,2,.L87
	lwz 0,3476(11)
	cmpw 0,0,8
	bc 4,2,.L87
	lwz 0,3432(11)
	add 7,7,0
.L87:
	addi 9,9,916
	bdnz .L84
.L88:
	lis 9,game+1544@ha
	li 10,0
	lwz 0,game+1544@l(9)
	cmpwi 0,0,0
	bc 4,1,.L96
	lis 11,g_edicts@ha
	mtctr 0
	lwz 9,g_edicts@l(11)
	addi 9,9,916
.L92:
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L95
	lwz 11,84(9)
	cmpwi 0,11,0
	bc 12,2,.L95
	lwz 0,3476(11)
	cmpw 0,0,4
	bc 4,2,.L95
	lwz 0,3432(11)
	add 10,10,0
.L95:
	addi 9,9,916
	bdnz .L92
.L96:
	cmpw 7,7,10
	mfcr 3
	rlwinm 3,3,29,1
	neg 3,3
	andc 0,4,3
	and 3,8,3
	or 3,3,0
	blr
.Lfe2:
	.size	 weakerTeam,.Lfe2-weakerTeam
	.section	".rodata"
	.align 2
.LC7:
	.string	"%s has been assigned to team %s\n"
	.section	".text"
	.align 2
	.globl assignToTeam
	.type	 assignToTeam,@function
assignToTeam:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 9,sv_expflags@ha
	lwz 10,sv_expflags@l(9)
	mr 30,3
	lwz 9,84(30)
	lfs 0,20(10)
	lwz 31,3476(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,256
	bc 12,2,.L107
	cmpwi 0,31,-1
	bc 4,2,.L109
	cmpwi 0,4,-1
	bc 4,2,.L110
	lis 9,sv_numteams@ha
	lwz 11,sv_numteams@l(9)
	li 3,0
	lis 29,sv_numteams@ha
	mr 31,3
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	cmpw 0,3,0
	bc 4,0,.L115
.L113:
	mr 4,3
	mr 3,31
	bl weakerTeam
	addi 31,31,1
	lwz 9,sv_numteams@l(29)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 0,28(1)
	cmpw 0,31,0
	bc 12,0,.L113
.L115:
	mr 31,3
	b .L117
.L110:
	mr 31,4
.L117:
	mr 4,31
	mr 3,30
	bl addPlayerToTeam
	lis 11,gi@ha
	mulli 0,31,20
	lwz 5,84(30)
	lis 9,gTeams@ha
	lwz 11,gi@l(11)
	la 9,gTeams@l(9)
	lis 4,.LC7@ha
	addi 5,5,700
	lwzx 6,9,0
	la 4,.LC7@l(4)
	li 3,2
	mtlr 11
	crxor 6,6,6
	blrl
	mr 3,30
	bl printTeamInfo
	mr 3,30
	bl enforceTeamModelSkin
	b .L107
.L109:
	lis 9,gTeams@ha
	mulli 0,31,20
	la 9,gTeams@l(9)
	addi 9,9,12
	lwzx 11,9,0
	addi 11,11,1
	stwx 11,9,0
.L107:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe3:
	.size	 assignToTeam,.Lfe3-assignToTeam
	.section	".rodata"
	.align 2
.LC8:
	.string	"misc/comp_up.wav"
	.align 2
.LC9:
	.string	":::: Your team now has %d more\nplayers than Team %s. ::::\n"
	.align 2
.LC10:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl removePlayerFromTeam
	.type	 removePlayerFromTeam,@function
removePlayerFromTeam:
	stwu 1,-80(1)
	mflr 0
	stmw 16,16(1)
	stw 0,84(1)
	lis 11,sv_expflags@ha
	lwz 6,sv_expflags@l(11)
	lfs 0,20(6)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	andi. 0,9,256
	bc 12,2,.L121
	lwz 11,84(3)
	lis 9,gTeams@ha
	li 8,-1
	la 5,gTeams@l(9)
	lwz 0,3476(11)
	addi 7,5,12
	mulli 0,0,20
	lwzx 9,7,0
	addi 9,9,-1
	stwx 9,7,0
	lwz 11,84(3)
	lwz 0,3476(11)
	mulli 0,0,20
	lwzx 19,7,0
	stw 8,3476(11)
	lfs 0,20(6)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 10,12(1)
	andi. 9,10,1024
	bc 4,2,.L121
	lis 11,sv_numteams@ha
	lwzx 20,5,0
	lwz 9,sv_numteams@l(11)
	li 28,0
	lis 16,sv_numteams@ha
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 0,12(1)
	cmpw 0,28,0
	bc 4,0,.L121
	lis 9,gi@ha
	lis 11,game@ha
	la 17,gi@l(9)
	la 21,game@l(11)
	mr 18,7
	lis 22,game@ha
.L128:
	mulli 9,28,20
	addi 24,28,1
	lwzx 0,18,9
	subf 27,19,0
	cmpwi 0,27,1
	bc 4,1,.L127
	lwz 9,36(17)
	lis 3,.LC8@ha
	li 30,1
	la 3,.LC8@l(3)
	lis 23,g_edicts@ha
	mtlr 9
	lis 25,.LC9@ha
	blrl
	lwz 0,1544(21)
	lis 9,g_edicts@ha
	mr 29,3
	lwz 11,g_edicts@l(9)
	cmpw 0,30,0
	addi 31,11,916
	bc 12,1,.L136
	la 26,game@l(22)
.L132:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L133
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L133
	lwz 0,3476(9)
	cmpw 0,0,28
	bc 4,2,.L133
	lis 9,.LC10@ha
	mr 3,31
	la 9,.LC10@l(9)
	mr 4,29
	lfs 1,0(9)
	bl unicastSound
.L133:
	lwz 0,1544(26)
	addi 30,30,1
	addi 31,31,916
	cmpw 0,30,0
	bc 4,1,.L132
.L136:
	mr 4,27
	mr 5,20
	la 3,.LC9@l(25)
	li 30,1
	crxor 6,6,6
	bl va
	bl greenText
	lwz 0,1544(21)
	mr 29,3
	lwz 9,g_edicts@l(23)
	cmpw 0,30,0
	addi 31,9,916
	bc 12,1,.L127
	lis 9,gi@ha
	la 26,game@l(22)
	la 27,gi@l(9)
.L139:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L140
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L140
	lwz 0,3476(9)
	cmpw 0,0,28
	bc 4,2,.L140
	lwz 9,8(27)
	mr 3,31
	li 4,2
	mr 5,29
	mtlr 9
	crxor 6,6,6
	blrl
.L140:
	lwz 0,1544(26)
	addi 30,30,1
	addi 31,31,916
	cmpw 0,30,0
	bc 4,1,.L139
.L127:
	lwz 9,sv_numteams@l(16)
	mr 28,24
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 0,12(1)
	cmpw 0,28,0
	bc 12,0,.L128
.L121:
	lwz 0,84(1)
	mtlr 0
	lmw 16,16(1)
	la 1,80(1)
	blr
.Lfe4:
	.size	 removePlayerFromTeam,.Lfe4-removePlayerFromTeam
	.section	".rodata"
	.align 2
.LC11:
	.string	"%s has left team %s\n"
	.section	".text"
	.align 2
	.globl teamDisconnect
	.type	 teamDisconnect,@function
teamDisconnect:
	stwu 1,-32(1)
	mflr 0
	stw 31,28(1)
	stw 0,36(1)
	lis 10,sv_expflags@ha
	lwz 11,sv_expflags@l(10)
	mr 31,3
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 0,9,256
	bc 12,2,.L145
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 9,11,192
	bc 12,2,.L150
	lwz 9,84(31)
	lwz 0,3476(9)
	nor 0,0,0
	addic 9,0,-1
	subfe 11,9,0
	mr 0,11
	b .L152
.L150:
	li 0,0
.L152:
	cmpwi 0,0,0
	bc 12,2,.L145
	lwz 10,84(31)
	lis 11,gi@ha
	lis 9,gTeams@ha
	lwz 11,gi@l(11)
	la 9,gTeams@l(9)
	lis 4,.LC11@ha
	lwz 0,3476(10)
	li 3,2
	addi 5,10,700
	la 4,.LC11@l(4)
	mtlr 11
	mulli 0,0,20
	lwzx 6,9,0
	crxor 6,6,6
	blrl
	mr 3,31
	bl removePlayerFromTeam
.L145:
	lwz 0,36(1)
	mtlr 0
	lwz 31,28(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 teamDisconnect,.Lfe5-teamDisconnect
	.align 2
	.globl killAndSwitchTeam
	.type	 killAndSwitchTeam,@function
killAndSwitchTeam:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	mr 31,3
	li 30,0
	lwz 0,264(31)
	mr 29,4
	lis 6,0x1
	lis 7,vec3_origin@ha
	mr 5,31
	stw 30,184(31)
	rlwinm 0,0,0,28,26
	la 7,vec3_origin@l(7)
	stw 30,480(31)
	stw 0,264(31)
	mr 4,31
	ori 6,6,34464
	bl player_die
	li 0,2
	mr 3,31
	stw 0,492(31)
	bl removePlayerFromTeam
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,256
	bc 12,2,.L157
	lwz 9,84(31)
	lis 10,gTeams@ha
	la 10,gTeams@l(10)
	stw 30,3432(9)
	addi 10,10,12
	lwz 9,84(31)
	stw 29,3476(9)
	lwz 11,84(31)
	lwz 0,3476(11)
	mulli 0,0,20
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
.L157:
	lwz 9,84(31)
	mr 3,31
	stw 30,3436(9)
	bl respawn
	mr 3,31
	bl enforceTeamModelSkin
	lis 10,sv_utilflags@ha
	lwz 9,sv_utilflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 11,28(1)
	andi. 0,11,1
	bc 12,2,.L158
	mulli 0,29,20
	lis 9,gTeams@ha
	lwz 3,84(31)
	la 9,gTeams@l(9)
	lwzx 4,9,0
	addi 3,3,700
	bl gsTeamChange
.L158:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe6:
	.size	 killAndSwitchTeam,.Lfe6-killAndSwitchTeam
	.section	".rodata"
	.align 2
.LC12:
	.string	"Teams are not enforced\n"
	.align 2
.LC13:
	.string	"Team is determined by skin\n"
	.align 2
.LC14:
	.string	"Team is determined by model\n"
	.align 2
.LC15:
	.string	"Teamplay not enabled\n"
	.align 2
.LC16:
	.string	"Unknown team \"%s\"\n"
	.align 2
.LC17:
	.string	"Teams are not even, so you are being\nassigned to the team that needs you most\n"
	.align 2
.LC18:
	.string	"You are already on team %s\n"
	.align 2
.LC19:
	.string	"Team switching is disabled on this server"
	.align 2
.LC20:
	.string	"You can only change to a team with less players\n"
	.align 2
.LC21:
	.string	"%s switched to team %s\n"
	.section	".text"
	.align 2
	.globl Cmd_Team_f
	.type	 Cmd_Team_f,@function
Cmd_Team_f:
	stwu 1,-48(1)
	mflr 0
	stmw 27,28(1)
	stw 0,52(1)
	lis 10,sv_expflags@ha
	lwz 11,sv_expflags@l(10)
	mr 29,3
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 0,9,256
	bc 4,2,.L161
	lis 30,dmflags@ha
	lwz 9,dmflags@l(30)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 9,11,192
	bc 12,2,.L162
	lis 9,gi@ha
	lis 5,.LC12@ha
	la 31,gi@l(9)
	la 5,.LC12@l(5)
	lwz 9,8(31)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 11,dmflags@l(30)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 0,9,64
	bc 12,2,.L160
	lwz 0,8(31)
	lis 5,.LC13@ha
	mr 3,29
	la 5,.LC13@l(5)
	b .L202
.L162:
	lis 9,gi+8@ha
	lis 5,.LC15@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC15@l(5)
	b .L202
.L161:
	lis 9,gi+164@ha
	lwz 0,gi+164@l(9)
	mtlr 0
	blrl
	mr 28,3
	lbz 0,0(28)
	cmpwi 0,0,0
	bc 4,2,.L169
	mr 3,29
	bl printTeamInfo
	b .L160
.L169:
	mr 3,29
	bl floodProt
	cmpwi 0,3,0
	bc 4,2,.L160
	lis 9,sv_numteams@ha
	lwz 11,sv_numteams@l(9)
	li 31,0
	lis 27,sv_numteams@ha
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpw 0,31,0
	bc 4,0,.L177
	lis 9,gTeams@ha
	la 30,gTeams@l(9)
.L173:
	lwz 4,0(30)
	mr 3,28
	addi 30,30,20
	bl Q_stricmp
	cmpwi 0,3,0
	bc 12,2,.L175
	lwz 9,sv_numteams@l(27)
	addi 31,31,1
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpw 0,31,0
	bc 12,0,.L173
.L177:
	li 31,-1
.L175:
	cmpwi 0,31,-1
	bc 4,2,.L178
	lis 9,gi+8@ha
	lis 5,.LC16@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC16@l(5)
	mr 6,28
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L160
.L178:
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,192
	bc 12,2,.L182
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 9,11,256
	bc 12,2,.L183
	lwz 9,84(29)
	lwz 0,3476(9)
	nor 0,0,0
	addic 9,0,-1
	subfe 11,9,0
	mr 0,11
	b .L184
.L183:
	li 0,1
	b .L184
.L182:
	li 0,0
.L184:
	cmpwi 0,0,0
	bc 4,2,.L179
	mr 3,29
	bl IsObserver
	cmpwi 0,3,0
	bc 12,2,.L160
	lis 9,sv_numteams@ha
	lwz 11,sv_numteams@l(9)
	li 6,1
	li 8,1
	lis 9,gTeams@ha
	lfs 0,20(11)
	la 9,gTeams@l(9)
	lwz 7,12(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpw 0,6,0
	bc 4,0,.L188
	lwz 0,32(9)
	b .L203
.L189:
	lis 11,sv_numteams@ha
	lwz 9,sv_numteams@l(11)
	addi 8,8,1
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpw 0,8,0
	bc 4,0,.L188
	lis 9,gTeams@ha
	mulli 11,8,20
	la 9,gTeams@l(9)
	addi 9,9,12
	lwzx 0,9,11
.L203:
	cmpw 0,7,0
	bc 12,2,.L189
	li 6,0
.L188:
	cmpwi 0,6,0
	bc 4,2,.L193
	lis 9,gi+8@ha
	lis 5,.LC17@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC17@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	mr 3,29
	bl ObserverToPlayer
	b .L160
.L193:
	mr 3,29
	mr 4,31
	bl ObserverToTeam
	b .L160
.L179:
	lwz 9,84(29)
	lwz 8,3476(9)
	cmpw 0,8,31
	bc 4,2,.L195
	lis 11,gi+8@ha
	mulli 0,31,20
	lis 9,gTeams@ha
	lwz 11,gi+8@l(11)
	la 9,gTeams@l(9)
	lis 5,.LC18@ha
	lwzx 6,9,0
	mr 3,29
	la 5,.LC18@l(5)
	li 4,2
	mtlr 11
	crxor 6,6,6
	blrl
	b .L160
.L195:
	lis 11,sv_expflags@ha
	lwz 9,sv_expflags@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	andi. 9,0,1024
	bc 12,2,.L197
	lis 9,gi+8@ha
	lis 5,.LC19@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC19@l(5)
	b .L202
.L197:
	andi. 9,0,512
	mulli 30,31,20
	bc 12,2,.L198
	lis 9,gTeams@ha
	mulli 11,8,20
	la 9,gTeams@l(9)
	addi 9,9,12
	lwzx 10,9,11
	lwzx 0,9,30
	cmpw 0,0,10
	bc 12,0,.L198
	lis 9,gi+8@ha
	lis 5,.LC20@ha
	lwz 0,gi+8@l(9)
	mr 3,29
	la 5,.LC20@l(5)
.L202:
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L160
.L198:
	mr 4,31
	mr 3,29
	bl killAndSwitchTeam
	lis 11,gi@ha
	lwz 5,84(29)
	lis 9,gTeams@ha
	lwz 0,gi@l(11)
	la 9,gTeams@l(9)
	lis 4,.LC21@ha
	lwzx 6,9,30
	la 4,.LC21@l(4)
	addi 5,5,700
	li 3,2
	mtlr 0
	crxor 6,6,6
	blrl
.L160:
	lwz 0,52(1)
	mtlr 0
	lmw 27,28(1)
	la 1,48(1)
	blr
.Lfe7:
	.size	 Cmd_Team_f,.Lfe7-Cmd_Team_f
	.section	".rodata"
	.align 2
.LC22:
	.string	"Invalid team number.\n"
	.align 2
.LC23:
	.string	"Team Number %d:\n"
	.align 2
.LC24:
	.string	"  Name: %s\n"
	.align 2
.LC25:
	.string	"  Skins: %s\n"
	.align 2
.LC26:
	.string	"  Members: %d\n"
	.section	".text"
	.align 2
	.globl Cmd_Examine_Teams
	.type	 Cmd_Examine_Teams,@function
Cmd_Examine_Teams:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 31,3
	la 30,gi@l(9)
	li 3,1
	lwz 9,160(30)
	mtlr 9
	blrl
	bl atoi
	mr. 29,3
	bc 12,0,.L206
	lis 9,sv_numteams@ha
	lwz 0,sv_numteams@l(9)
	cmpw 0,29,0
	bc 12,0,.L205
.L206:
	lwz 0,8(30)
	lis 5,.LC22@ha
	mr 3,31
	la 5,.LC22@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L204
.L205:
	lwz 9,8(30)
	lis 5,.LC23@ha
	mr 6,29
	mulli 28,29,20
	la 5,.LC23@l(5)
	mr 3,31
	mtlr 9
	li 4,2
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 29,gTeams@ha
	lis 5,.LC24@ha
	la 29,gTeams@l(29)
	la 5,.LC24@l(5)
	lwzx 6,29,28
	mtlr 9
	mr 3,31
	li 4,2
	crxor 6,6,6
	blrl
	lwz 11,8(30)
	addi 9,29,4
	lis 5,.LC25@ha
	la 5,.LC25@l(5)
	lwzx 6,9,28
	mr 3,31
	li 4,2
	mtlr 11
	crxor 6,6,6
	blrl
	lwz 0,8(30)
	addi 29,29,12
	lis 5,.LC26@ha
	lwzx 6,29,28
	mr 3,31
	la 5,.LC26@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L204:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe8:
	.size	 Cmd_Examine_Teams,.Lfe8-Cmd_Examine_Teams
	.section	".rodata"
	.align 2
.LC27:
	.string	"setSkinAndModel passed null model/skin path\n"
	.align 2
.LC28:
	.string	"%s\\%s"
	.align 2
.LC29:
	.string	"players/%s/tris.md2"
	.section	".text"
	.align 2
	.globl setSkinAndModel
	.type	 setSkinAndModel,@function
setSkinAndModel:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 9,g_edicts@ha
	lis 27,whichModel.37@ha
	lwz 11,g_edicts@l(9)
	mr 30,3
	lis 0,0x478b
	lwz 9,whichModel.37@l(27)
	ori 0,0,48365
	mr 31,4
	subf 11,11,30
	lis 4,.LC5@ha
	mullw 11,11,0
	xori 9,9,1
	la 4,.LC5@l(4)
	stw 9,whichModel.37@l(27)
	mr 3,31
	srawi 26,11,2
	bl strcspn
	lwz 0,whichModel.37@l(27)
	lis 29,model.36@ha
	mr 28,3
	la 29,model.36@l(29)
	mr 5,28
	slwi 0,0,9
	mr 4,31
	add 3,0,29
	bl strncpy
	lwz 0,whichModel.37@l(27)
	cmpwi 0,31,0
	li 9,0
	slwi 0,0,9
	add 28,28,0
	add 27,0,29
	stbx 9,29,28
	bc 4,2,.L209
	lis 9,gi+4@ha
	lis 3,.LC27@ha
	lwz 0,gi+4@l(9)
	la 3,.LC27@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L207
.L209:
	lwz 4,84(30)
	lis 29,gi@ha
	lis 3,.LC28@ha
	mr 5,31
	la 29,gi@l(29)
	addi 4,4,700
	la 3,.LC28@l(3)
	crxor 6,6,6
	bl va
	lwz 9,24(29)
	addi 0,26,1311
	mr 4,3
	mr 3,0
	mtlr 9
	blrl
	lis 3,.LC29@ha
	mr 4,27
	la 3,.LC29@l(3)
	crxor 6,6,6
	bl va
	stw 3,268(30)
.L207:
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe9:
	.size	 setSkinAndModel,.Lfe9-setSkinAndModel
	.align 2
	.type	 getPathRating,@function
getPathRating:
	stwu 1,-48(1)
	mflr 0
	stmw 24,16(1)
	stw 0,52(1)
	mr 31,3
	mr 30,4
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L211
	li 3,3
	b .L223
.L211:
	lis 27,whichModel.37@ha
	lis 26,.LC5@ha
	lwz 0,whichModel.37@l(27)
	la 4,.LC5@l(26)
	mr 3,31
	li 25,0
	lis 24,.LC5@ha
	xori 0,0,1
	stw 0,whichModel.37@l(27)
	bl strcspn
	lwz 0,whichModel.37@l(27)
	lis 28,model.36@ha
	mr 29,3
	la 28,model.36@l(28)
	mr 5,29
	slwi 0,0,9
	mr 4,31
	add 3,0,28
	bl strncpy
	lwz 0,whichModel.37@l(27)
	la 4,.LC5@l(26)
	mr 3,30
	slwi 26,0,9
	xori 0,0,1
	add 29,29,26
	stw 0,whichModel.37@l(27)
	add 26,26,28
	stbx 25,28,29
	bl strcspn
	lwz 0,whichModel.37@l(27)
	mr 29,3
	mr 4,30
	mr 5,29
	slwi 0,0,9
	add 3,0,28
	bl strncpy
	lwz 4,whichModel.37@l(27)
	mr 3,26
	slwi 4,4,9
	add 29,29,4
	add 4,4,28
	stbx 25,28,29
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L215
	li 3,2
	b .L223
.L215:
	lis 9,whichSkin.42@ha
	la 4,.LC5@l(24)
	lwz 0,whichSkin.42@l(9)
	mr 3,31
	lis 27,whichSkin.42@ha
	xori 0,0,1
	stw 0,whichSkin.42@l(9)
	bl strcspn
	mr 29,3
	mr 3,31
	bl strlen
	cmpw 0,29,3
	bc 12,2,.L216
	la 4,.LC5@l(24)
	mr 3,31
	bl strcspn
	mr 29,3
	mr 3,31
	bl strlen
	addi 3,3,-1
	cmpw 0,29,3
	bc 4,2,.L217
.L216:
	lis 9,.LC6@ha
	la 31,.LC6@l(9)
	b .L218
.L217:
	lwz 29,whichSkin.42@l(27)
	lis 28,skin.41@ha
	la 4,.LC5@l(24)
	la 28,skin.41@l(28)
	mr 3,31
	slwi 29,29,9
	add 29,29,28
	bl strcspn
	add 4,31,3
	mr 3,29
	addi 4,4,1
	bl strcpy
	lwz 0,whichSkin.42@l(27)
	slwi 0,0,9
	add 31,0,28
.L218:
	lis 9,whichSkin.42@ha
	lis 4,.LC5@ha
	lwz 0,whichSkin.42@l(9)
	la 4,.LC5@l(4)
	mr 3,30
	xori 0,0,1
	stw 0,whichSkin.42@l(9)
	bl strcspn
	mr 29,3
	mr 3,30
	bl strlen
	cmpw 0,29,3
	bc 12,2,.L219
	la 4,.LC5@l(24)
	mr 3,30
	bl strcspn
	mr 29,3
	mr 3,30
	bl strlen
	addi 3,3,-1
	cmpw 0,29,3
	bc 4,2,.L220
.L219:
	lis 9,.LC6@ha
	la 4,.LC6@l(9)
	b .L221
.L220:
	lwz 29,whichSkin.42@l(27)
	lis 28,skin.41@ha
	la 4,.LC5@l(24)
	la 28,skin.41@l(28)
	mr 3,30
	slwi 29,29,9
	add 29,29,28
	bl strcspn
	add 4,30,3
	addi 4,4,1
	mr 3,29
	bl strcpy
	lwz 0,whichSkin.42@l(27)
	slwi 0,0,9
	add 4,0,28
.L221:
	mr 3,31
	bl Q_stricmp
	subfic 0,3,0
	adde 3,0,3
.L223:
	lwz 0,52(1)
	mtlr 0
	lmw 24,16(1)
	la 1,48(1)
	blr
.Lfe10:
	.size	 getPathRating,.Lfe10-getPathRating
	.section	".rodata"
	.align 2
.LC30:
	.string	"skin"
	.align 2
.LC31:
	.string	"enforceTeamModelSkin called with teamless player %s\n"
	.align 2
.LC32:
	.string	";"
	.align 2
.LC34:
	.string	"Player %s had set skin %s.\nSetting skin to %s\n"
	.align 2
.LC35:
	.string	"Player %s had set model/skin %s.\nSince model teams and user chosen model\nalready matched team model, not changing user setting\n"
	.align 2
.LC36:
	.string	"Player %s had set skin %s.\nOverriding skin and model to %s\nsince model %s not allowed for team\n"
	.align 3
.LC33:
	.long 0x41dfffff
	.long 0xffc00000
	.align 3
.LC37:
	.long 0x43300000
	.long 0x80000000
	.align 2
.LC38:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl enforceTeamModelSkin
	.type	 enforceTeamModelSkin,@function
enforceTeamModelSkin:
	stwu 1,-1088(1)
	mflr 0
	stmw 21,1044(1)
	stw 0,1092(1)
	mr 25,3
	lis 4,.LC30@ha
	lwz 3,84(25)
	la 4,.LC30@l(4)
	addi 3,3,188
	bl Info_ValueForKey
	lis 11,sv_expflags@ha
	lwz 10,sv_expflags@l(11)
	mr 30,3
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,1032(1)
	lwz 9,1036(1)
	andi. 0,9,256
	bc 12,2,.L224
	lwz 4,84(25)
	lwz 0,3476(4)
	cmpwi 0,0,-1
	bc 4,2,.L226
	lis 9,gi+4@ha
	lis 3,.LC31@ha
	lwz 0,gi+4@l(9)
	la 3,.LC31@l(3)
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L224
.L226:
	lis 9,gTeams@ha
	mulli 0,0,20
	addi 3,1,8
	la 9,gTeams@l(9)
	li 27,1
	addi 11,9,8
	addi 9,9,4
	lwzx 5,11,0
	lwzx 4,9,0
	bl strncpy
	lis 4,.LC32@ha
	addi 3,1,8
	la 4,.LC32@l(4)
	bl strtok
	mr 31,3
	mr 4,30
	bl getPathRating
	mr 28,3
	b .L227
.L229:
	mr 3,29
	mr 4,30
	bl getPathRating
	cmpw 0,3,28
	bc 4,1,.L230
	mr 31,29
	mr 28,3
	li 27,1
	b .L227
.L230:
	bc 4,2,.L227
	bl rand
	addi 27,27,1
	xoris 3,3,0x8000
	stw 3,1036(1)
	lis 8,0x4330
	lis 11,.LC37@ha
	stw 8,1032(1)
	la 11,.LC37@l(11)
	lis 10,.LC33@ha
	lfd 10,0(11)
	xoris 0,27,0x8000
	lfd 12,1032(1)
	mr 11,9
	lfd 11,.LC33@l(10)
	lis 9,.LC38@ha
	stw 0,1036(1)
	la 9,.LC38@l(9)
	fsub 12,12,10
	stw 8,1032(1)
	lfd 0,1032(1)
	lfs 13,0(9)
	fdiv 12,12,11
	fsub 0,0,10
	frsp 0,0
	fdivs 13,13,0
	fcmpu 0,12,13
	bc 4,0,.L227
	mr 31,29
.L227:
	lis 4,.LC32@ha
	li 3,0
	la 4,.LC32@l(4)
	bl strtok
	mr. 29,3
	bc 4,2,.L229
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1032(1)
	lwz 11,1036(1)
	andi. 24,11,64
	bc 12,2,.L235
	mr 3,25
	mr 4,31
	bl setSkinAndModel
	lwz 3,84(25)
	addi 3,3,3500
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L224
	lis 9,gi+4@ha
	lwz 4,84(25)
	lis 3,.LC34@ha
	lwz 0,gi+4@l(9)
	la 3,.LC34@l(3)
	mr 5,30
	addi 4,4,700
	mr 6,31
	mtlr 0
	crxor 6,6,6
	blrl
	b .L224
.L235:
	lis 28,whichModel.37@ha
	lis 26,.LC5@ha
	lwz 0,whichModel.37@l(28)
	la 4,.LC5@l(26)
	mr 3,30
	lis 23,.LC5@ha
	lis 21,whichSkin.42@ha
	xori 0,0,1
	stw 0,whichModel.37@l(28)
	bl strcspn
	lwz 0,whichModel.37@l(28)
	lis 29,model.36@ha
	mr 27,3
	la 29,model.36@l(29)
	mr 5,27
	slwi 0,0,9
	mr 4,30
	add 3,0,29
	bl strncpy
	lwz 0,whichModel.37@l(28)
	la 4,.LC5@l(26)
	mr 3,31
	slwi 9,0,9
	xori 0,0,1
	add 27,27,9
	stw 0,whichModel.37@l(28)
	add 22,9,29
	stbx 24,29,27
	bl strcspn
	lwz 0,whichModel.37@l(28)
	mr 27,3
	mr 4,31
	mr 5,27
	slwi 0,0,9
	add 3,0,29
	bl strncpy
	lwz 0,whichModel.37@l(28)
	lis 11,whichSkin.42@ha
	la 4,.LC5@l(26)
	lwz 9,whichSkin.42@l(11)
	mr 3,30
	slwi 0,0,9
	add 27,27,0
	xori 9,9,1
	stbx 24,29,27
	add 28,0,29
	stw 9,whichSkin.42@l(11)
	bl strcspn
	mr 29,3
	mr 3,30
	bl strlen
	cmpw 0,29,3
	bc 12,2,.L241
	la 4,.LC5@l(23)
	mr 3,30
	bl strcspn
	mr 29,3
	mr 3,30
	bl strlen
	addi 3,3,-1
	cmpw 0,29,3
	bc 12,2,.L241
	lwz 29,whichSkin.42@l(21)
	lis 9,skin.41@ha
	la 4,.LC5@l(23)
	la 9,skin.41@l(9)
	mr 3,30
	slwi 29,29,9
	add 29,29,9
	bl strcspn
	add 4,30,3
	mr 3,29
	addi 4,4,1
	bl strcpy
.L241:
	lis 9,whichSkin.42@ha
	lis 4,.LC5@ha
	lwz 0,whichSkin.42@l(9)
	la 4,.LC5@l(4)
	mr 3,31
	xori 0,0,1
	stw 0,whichSkin.42@l(9)
	bl strcspn
	mr 29,3
	mr 3,31
	bl strlen
	cmpw 0,29,3
	bc 12,2,.L244
	la 4,.LC5@l(23)
	mr 3,31
	bl strcspn
	mr 29,3
	mr 3,31
	bl strlen
	addi 3,3,-1
	cmpw 0,29,3
	bc 12,2,.L244
	lwz 29,whichSkin.42@l(21)
	lis 9,skin.41@ha
	la 4,.LC5@l(23)
	la 9,skin.41@l(9)
	mr 3,31
	slwi 29,29,9
	add 29,29,9
	bl strcspn
	add 4,31,3
	mr 3,29
	addi 4,4,1
	bl strcpy
.L244:
	mr 4,28
	mr 3,22
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L245
	mr 3,25
	mr 4,30
	bl setSkinAndModel
	lis 9,gi+4@ha
	lwz 4,84(25)
	lis 3,.LC35@ha
	lwz 0,gi+4@l(9)
	la 3,.LC35@l(3)
	mr 5,30
	addi 4,4,700
	mtlr 0
	crxor 6,6,6
	blrl
	b .L224
.L245:
	mr 3,25
	mr 4,31
	bl setSkinAndModel
	lis 9,gi+4@ha
	lwz 4,84(25)
	lis 3,.LC36@ha
	lwz 0,gi+4@l(9)
	la 3,.LC36@l(3)
	mr 5,30
	addi 4,4,700
	mr 6,31
	mr 7,22
	mtlr 0
	crxor 6,6,6
	blrl
.L224:
	lwz 0,1092(1)
	mtlr 0
	lmw 21,1044(1)
	la 1,1088(1)
	blr
.Lfe11:
	.size	 enforceTeamModelSkin,.Lfe11-enforceTeamModelSkin
	.section	".sdata","aw"
	.align 2
	.type	 precacheCounter,@object
	.size	 precacheCounter,4
precacheCounter:
	.long 0
	.section	".rodata"
	.align 2
.LC39:
	.string	"expert\\%s"
	.align 2
.LC40:
	.string	"="
	.align 2
.LC41:
	.string	"ERROR: Malformed team string detected, team name but no skins: %s\n"
	.align 2
.LC42:
	.string	"; \t"
	.align 2
.LC43:
	.string	"Skipping invalid skin/model path %s\n"
	.section	".text"
	.align 2
	.type	 setTeamEntry,@function
setTeamEntry:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	mr 27,3
	mr 28,4
	bl trimWhitespace
	lbz 0,0(27)
	cmpwi 0,0,35
	bc 12,2,.L267
	mr 3,27
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L267
	lis 31,.LC40@ha
	mr 3,27
	la 4,.LC40@l(31)
	bl strcspn
	mr 29,3
	mr 3,27
	bl strlen
	cmpw 0,29,3
	bc 4,2,.L251
	lis 9,gi+4@ha
	lis 3,.LC41@ha
	lwz 0,gi+4@l(9)
	la 3,.LC41@l(3)
	mr 4,27
	mtlr 0
	crxor 6,6,6
	blrl
	b .L267
.L251:
	la 4,.LC40@l(31)
	mr 3,27
	mulli 28,28,20
	bl strtok
	mr 27,3
	bl strlen
	addi 3,3,1
	bl malloc
	lis 29,gTeams@ha
	mr 0,3
	la 29,gTeams@l(29)
	mr 4,27
	stwx 0,29,28
	bl strcpy
	lwzx 3,29,28
	bl trimWhitespace
	mr 27,28
	b .L252
.L255:
	mr 3,28
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L257
	lis 31,.LC5@ha
	mr 3,28
	la 4,.LC5@l(31)
	bl strcspn
	mr 29,3
	mr 3,28
	bl strlen
	cmpw 0,29,3
	bc 12,2,.L257
	la 4,.LC5@l(31)
	mr 3,28
	bl strcspn
	mr 29,3
	mr 3,28
	bl strlen
	addi 3,3,-1
	cmpw 0,29,3
	bc 4,2,.L258
.L257:
	li 0,0
	b .L259
.L258:
	li 0,1
.L259:
	cmpwi 0,0,0
	bc 12,2,.L256
	lis 9,gTeams@ha
	la 30,gTeams@l(9)
	addi 31,30,4
	lwzx 3,31,27
	cmpwi 0,3,0
	bc 4,2,.L260
	mr 3,28
	bl strlen
	addi 29,3,2
	mr 3,29
	bl malloc
	mr 4,28
	stwx 3,31,27
	bl strcpy
	b .L268
.L260:
	bl strlen
	mr 29,3
	mr 3,28
	bl strlen
	add 29,29,3
	addi 29,29,2
	lwzx 3,31,27
	mr 4,29
	bl realloc
	mr 0,3
	lis 4,.LC32@ha
	la 4,.LC32@l(4)
	stwx 0,31,27
	bl strcat
	lwzx 3,31,27
	mr 4,28
	bl strcat
.L268:
	addi 9,30,8
	stwx 29,9,27
	lis 11,precacheCounter@ha
	mr 4,28
	lwz 9,precacheCounter@l(11)
	lis 29,gi@ha
	lis 3,.LC39@ha
	la 29,gi@l(29)
	la 3,.LC39@l(3)
	addi 28,9,1440
	addi 9,9,1
	stw 9,precacheCounter@l(11)
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	b .L252
.L256:
	lis 9,gi+4@ha
	lis 3,.LC43@ha
	lwz 0,gi+4@l(9)
	la 3,.LC43@l(3)
	mr 4,28
	mtlr 0
	crxor 6,6,6
	blrl
.L252:
	lis 4,.LC42@ha
	li 3,0
	la 4,.LC42@l(4)
	bl strtok
	mr. 28,3
	bc 12,2,.L253
	lbz 0,0(28)
	cmpwi 0,0,35
	bc 4,2,.L255
.L253:
	lis 9,gTeams@ha
	la 9,gTeams@l(9)
	addi 11,9,4
	lwzx 0,11,27
	cmpwi 0,0,0
	li 3,1
	bc 4,2,.L266
	lwzx 3,9,27
	bl free
.L267:
	li 3,0
.L266:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe12:
	.size	 setTeamEntry,.Lfe12-setTeamEntry
	.section	".rodata"
	.align 2
.LC44:
	.string	"Enforced Teams enabled but neither skin teams nor\nmodel teams set.  Disabling Enforced Teams.\n"
	.align 2
.LC45:
	.string	"expflags"
	.align 2
.LC46:
	.string	"%d"
	.align 2
.LC47:
	.string	"Teamplay enabled but cvar \"numteams\" set less than 2, disabling teamplay\n"
	.align 2
.LC48:
	.string	"dmflags"
	.align 2
.LC49:
	.string	"\n~~~~~~~~~~~~~~~~~~~~~~\nExpert Quake2 Teamplay\nLoading team definitions...\n"
	.align 2
.LC50:
	.string	"%s/%s"
	.align 2
.LC51:
	.string	"teams.txt"
	.align 2
.LC52:
	.string	"r"
	.align 2
.LC53:
	.string	"ERROR: Couldn't open %s.  Teamplay disabled.\n"
	.align 2
.LC54:
	.string	"Hit max team limit while reading team file: %s"
	.align 2
.LC55:
	.string	"ERROR: Unable to load 2 team definitions from %s.\nDisabling teamplay.\n"
	.align 2
.LC56:
	.string	"Unable to load %d team definitions from %s.\nReducing the number of teams to %d.\n"
	.align 2
.LC57:
	.string	"numteams"
	.align 2
.LC58:
	.string	"Too many teams for CTF, reducing to 2 teams\n"
	.align 2
.LC59:
	.string	"2"
	.align 2
.LC60:
	.string	"Using %d teams out of %d defined in %s\n~~~~~~~~~~~~~~~~~~~~~~\n\n"
	.align 2
.LC61:
	.long 0x0
	.section	".text"
	.align 2
	.globl loadTeams
	.type	 loadTeams,@function
loadTeams:
	stwu 1,-1056(1)
	mflr 0
	stmw 27,1036(1)
	stw 0,1060(1)
	addi 3,1,8
	li 4,0
	li 5,1000
	li 31,0
	crxor 6,6,6
	bl memset
	lis 27,dmflags@ha
	lis 10,dmflags@ha
	lwz 9,dmflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1024(1)
	lwz 11,1028(1)
	andi. 0,11,192
	bc 4,2,.L270
	lis 31,sv_expflags@ha
	lwz 9,sv_expflags@l(31)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1024(1)
	lwz 11,1028(1)
	andi. 9,11,256
	bc 12,2,.L269
	lis 29,gi@ha
	lis 3,.LC44@ha
	la 29,gi@l(29)
	la 3,.LC44@l(3)
	lwz 9,4(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,sv_expflags@l(31)
	lis 3,.LC46@ha
	la 3,.LC46@l(3)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1024(1)
	lwz 4,1028(1)
	rlwinm 4,4,0,24,22
	crxor 6,6,6
	bl va
	mr 4,3
	lwz 0,148(29)
	lis 3,.LC45@ha
	la 3,.LC45@l(3)
	b .L286
.L270:
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1024(1)
	lwz 11,1028(1)
	andi. 0,11,256
	bc 12,2,.L269
	lis 10,sv_numteams@ha
	lwz 9,sv_numteams@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1024(1)
	lwz 11,1028(1)
	cmpwi 0,11,1
	bc 12,1,.L275
	lis 29,gi@ha
	lis 3,.LC47@ha
	la 29,gi@l(29)
	la 3,.LC47@l(3)
	lwz 9,4(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,dmflags@l(27)
	lis 3,.LC46@ha
	la 3,.LC46@l(3)
	lfs 0,20(9)
	b .L287
.L275:
	lis 3,gTeams@ha
	li 5,640
	li 4,0
	la 3,gTeams@l(3)
	crxor 6,6,6
	bl memset
	lis 28,.LC51@ha
	lis 9,gi@ha
	lis 3,.LC49@ha
	la 30,gi@l(9)
	la 3,.LC49@l(3)
	lwz 11,4(30)
	lis 9,precacheCounter@ha
	stw 31,precacheCounter@l(9)
	mtlr 11
	crxor 6,6,6
	blrl
	lis 9,levelCycle@ha
	lis 11,gamedir@ha
	lwz 10,levelCycle@l(9)
	lis 3,.LC50@ha
	lis 5,.LC51@ha
	lwz 9,gamedir@l(11)
	la 5,.LC51@l(5)
	la 3,.LC50@l(3)
	lwz 4,4(10)
	lwz 29,4(9)
	crxor 6,6,6
	bl va
	mr 4,3
	lis 5,.LC52@ha
	mr 3,29
	la 5,.LC52@l(5)
	bl OpenGamedirFile
	mr. 29,3
	bc 4,2,.L276
	lwz 9,4(30)
	lis 3,.LC53@ha
	la 4,.LC51@l(28)
	la 3,.LC53@l(3)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,dmflags@l(27)
	lis 3,.LC46@ha
	la 3,.LC46@l(3)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1024(1)
	lwz 4,1028(1)
	rlwinm 4,4,0,26,23
	crxor 6,6,6
	bl va
	mr 4,3
	lwz 0,148(30)
	b .L288
.L276:
	lis 27,.LC54@ha
	b .L277
.L280:
	mr 4,31
	addi 3,1,8
	bl setTeamEntry
	xori 3,3,1
	addi 9,31,1
	srawi 11,3,31
	xor 0,11,3
	subf 0,0,11
	srawi 0,0,31
	andc 9,9,0
	and 0,31,0
	or 31,0,9
.L277:
	addi 3,1,8
	li 4,1000
	mr 5,29
	bl fgets
	cmpwi 0,3,0
	bc 12,2,.L278
	cmpwi 0,31,32
	bc 4,2,.L280
	lwz 0,4(30)
	la 3,.LC54@l(27)
	la 4,.LC51@l(28)
	mtlr 0
	crxor 6,6,6
	blrl
.L278:
	mr 3,29
	bl fclose
	cmpwi 0,31,0
	bc 12,1,.L283
	lis 29,gi@ha
	lis 3,.LC55@ha
	la 29,gi@l(29)
	lis 4,.LC51@ha
	lwz 9,4(29)
	la 3,.LC55@l(3)
	la 4,.LC51@l(4)
	mtlr 9
	crxor 6,6,6
	blrl
	lis 9,dmflags@ha
	lwz 11,dmflags@l(9)
	lis 3,.LC46@ha
	la 3,.LC46@l(3)
	lfs 0,20(11)
.L287:
	fctiwz 13,0
	stfd 13,1024(1)
	lwz 4,1028(1)
	rlwinm 4,4,0,26,23
	crxor 6,6,6
	bl va
	mr 4,3
	lwz 0,148(29)
.L288:
	lis 3,.LC48@ha
	la 3,.LC48@l(3)
.L286:
	mtlr 0
	blrl
	b .L269
.L283:
	lis 11,sv_numteams@ha
	lwz 9,sv_numteams@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,1024(1)
	lwz 4,1028(1)
	cmpw 0,31,4
	bc 4,0,.L284
	lis 29,gi@ha
	lis 3,.LC56@ha
	la 29,gi@l(29)
	lis 5,.LC51@ha
	lwz 9,4(29)
	la 3,.LC56@l(3)
	la 5,.LC51@l(5)
	mr 6,31
	mtlr 9
	crxor 6,6,6
	blrl
	lis 3,.LC46@ha
	mr 4,31
	la 3,.LC46@l(3)
	crxor 6,6,6
	bl va
	mr 4,3
	lwz 0,148(29)
	lis 3,.LC57@ha
	la 3,.LC57@l(3)
	mtlr 0
	blrl
.L284:
	lis 9,.LC61@ha
	lis 11,ctf@ha
	la 9,.LC61@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L285
	lis 9,sv_numteams@ha
	lwz 11,sv_numteams@l(9)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,1024(1)
	lwz 9,1028(1)
	cmpwi 0,9,2
	bc 4,1,.L285
	lis 29,gi@ha
	lis 3,.LC58@ha
	la 29,gi@l(29)
	la 3,.LC58@l(3)
	lwz 9,4(29)
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,148(29)
	lis 3,.LC57@ha
	lis 4,.LC59@ha
	la 3,.LC57@l(3)
	la 4,.LC59@l(4)
	mtlr 0
	blrl
.L285:
	lis 9,sv_numteams@ha
	lis 11,gi+4@ha
	lwz 10,sv_numteams@l(9)
	lis 3,.LC60@ha
	lwz 0,gi+4@l(11)
	lis 6,.LC51@ha
	la 3,.LC60@l(3)
	lfs 0,20(10)
	mr 5,31
	la 6,.LC51@l(6)
	mtlr 0
	fctiwz 13,0
	stfd 13,1024(1)
	lwz 4,1028(1)
	crxor 6,6,6
	blrl
.L269:
	lwz 0,1060(1)
	mtlr 0
	lmw 27,1036(1)
	la 1,1056(1)
	blr
.Lfe13:
	.size	 loadTeams,.Lfe13-loadTeams
	.section	".rodata"
	.align 2
.LC62:
	.string	"To send any message, type \n\"ta [message number]\"\nat the console\n\n"
	.align 2
.LC63:
	.string	"Team-Wide Radio Messages:\n\n"
	.align 2
.LC64:
	.string	"incoming \"enemy units incoming\"\n"
	.align 2
.LC65:
	.string	"overrun \"base is overrun, available units pull back\"\n"
	.align 2
.LC66:
	.string	"Short Range Radio Messages:\n"
	.align 2
.LC67:
	.string	"staying \"I have this covered\"\n"
	.align 2
.LC68:
	.string	"hold \"Hold this position\"\n"
	.align 2
.LC69:
	.string	"follow \"Follow me\"\n"
	.align 2
.LC70:
	.string	"cover \"Cover me, I need an escort\"\n"
	.align 2
.LC71:
	.string	"ok \"You got it\"\n"
	.align 2
.LC72:
	.string	"no \"No can do\"\n"
	.align 2
.LC73:
	.string	"base \"Get back to base\"\n"
	.align 2
.LC74:
	.string	"flag \"Find the enemy carrier\"\n"
	.align 2
.LC75:
	.string	"escort \"Find our carrier and cover him\"\n"
	.align 2
.LC76:
	.long 0x0
	.section	".text"
	.align 2
	.globl printAudioCmds
	.type	 printAudioCmds,@function
printAudioCmds:
	stwu 1,-32(1)
	mflr 0
	stfd 31,24(1)
	stmw 29,12(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 31,3
	la 30,gi@l(9)
	lis 5,.LC62@ha
	lwz 11,8(30)
	la 5,.LC62@l(5)
	li 4,2
	lis 9,.LC76@ha
	mtlr 11
	la 9,.LC76@l(9)
	lis 29,ctf@ha
	lfs 31,0(9)
	crxor 6,6,6
	blrl
	lwz 9,ctf@l(29)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L300
	lwz 9,8(30)
	lis 5,.LC63@ha
	mr 3,31
	la 5,.LC63@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC64@ha
	mr 3,31
	la 5,.LC64@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC65@ha
	mr 3,31
	la 5,.LC65@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
.L300:
	lwz 9,8(30)
	lis 5,.LC66@ha
	mr 3,31
	la 5,.LC66@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC67@ha
	mr 3,31
	la 5,.LC67@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC68@ha
	mr 3,31
	la 5,.LC68@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC69@ha
	mr 3,31
	la 5,.LC69@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC70@ha
	mr 3,31
	la 5,.LC70@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC71@ha
	mr 3,31
	la 5,.LC71@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC72@ha
	mr 3,31
	la 5,.LC72@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,ctf@l(29)
	lfs 0,20(9)
	fcmpu 0,0,31
	bc 12,2,.L301
	lwz 9,8(30)
	lis 5,.LC73@ha
	mr 3,31
	la 5,.LC73@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 9,8(30)
	lis 5,.LC74@ha
	mr 3,31
	la 5,.LC74@l(5)
	li 4,2
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 0,8(30)
	lis 5,.LC75@ha
	mr 3,31
	la 5,.LC75@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L301:
	lwz 0,36(1)
	mtlr 0
	lmw 29,12(1)
	lfd 31,24(1)
	la 1,32(1)
	blr
.Lfe14:
	.size	 printAudioCmds,.Lfe14-printAudioCmds
	.section	".rodata"
	.align 2
.LC77:
	.string	"bind f2 \"ta base\"\n"
	.align 2
.LC78:
	.string	"bind f3 \"ta flag\"\n"
	.align 2
.LC79:
	.string	"bind f4 \"ta escort\"\n"
	.align 2
.LC80:
	.string	"bind f11 \"ta incoming\"\n"
	.align 2
.LC81:
	.string	"bind f12 \"ta overrun\"\n"
	.align 2
.LC82:
	.string	"bind f5 \"ta staying\"\n"
	.align 2
.LC83:
	.string	"bind f6 \"ta hold\"\n"
	.align 2
.LC84:
	.string	"bind f7 \"ta follow\"\n"
	.align 2
.LC85:
	.string	"bind f8 \"ta cover\"\n"
	.align 2
.LC86:
	.string	"bind f9 \"ta ok\"\n"
	.align 2
.LC87:
	.string	"bind f10 \"ta no\"\n"
	.align 2
.LC88:
	.string	"female"
	.align 2
.LC89:
	.string	"male"
	.align 2
.LC90:
	.string	"player/%s/%s.wav"
	.align 2
.LC91:
	.long 0x3f800000
	.align 2
.LC92:
	.long 0x43c80000
	.align 3
.LC93:
	.long 0x43300000
	.long 0x80000000
	.section	".text"
	.align 2
	.globl localRadio
	.type	 localRadio,@function
localRadio:
	stwu 1,-80(1)
	mflr 0
	stmw 23,44(1)
	stw 0,84(1)
	lis 10,.LC91@ha
	lis 9,maxclients@ha
	la 10,.LC91@l(10)
	lis 11,g_edicts@ha
	lfs 13,0(10)
	mr 30,3
	mr 26,4
	lwz 10,maxclients@l(9)
	li 27,1
	lis 23,g_edicts@ha
	lwz 9,g_edicts@l(11)
	lis 24,maxclients@ha
	lfs 0,20(10)
	addi 31,9,916
	fcmpu 0,13,0
	cror 3,2,0
	bc 4,3,.L313
	lis 9,gi@ha
	lis 25,0x4330
	la 28,gi@l(9)
.L315:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L316
	lwz 9,84(31)
	lwz 11,84(30)
	lwz 10,3476(9)
	lwz 0,3476(11)
	cmpw 0,10,0
	bc 4,2,.L316
	lfs 0,4(31)
	addi 3,1,8
	lfs 13,4(30)
	lfs 12,8(30)
	lfs 11,12(30)
	fsubs 13,13,0
	stfs 13,8(1)
	lfs 0,8(31)
	fsubs 12,12,0
	stfs 12,12(1)
	lfs 0,12(31)
	fsubs 11,11,0
	stfs 11,16(1)
	bl VectorLength
	lis 9,.LC92@ha
	la 9,.LC92@l(9)
	lfs 0,0(9)
	fcmpu 0,1,0
	bc 12,0,.L318
	mr 3,30
	mr 4,31
	bl loc_CanSee
	cmpwi 0,3,0
	bc 12,2,.L316
.L318:
	lis 9,gi@ha
	mr 3,30
	la 29,gi@l(9)
	bl IsFemale
	cmpwi 0,3,0
	bc 12,2,.L319
	lis 9,.LC88@ha
	la 4,.LC88@l(9)
	b .L320
.L319:
	lis 9,.LC89@ha
	la 4,.LC89@l(9)
.L320:
	lis 3,.LC90@ha
	mr 5,26
	la 3,.LC90@l(3)
	crxor 6,6,6
	bl va
	lwz 0,36(29)
	mtlr 0
	blrl
	lis 9,.LC91@ha
	mr 4,3
	la 9,.LC91@l(9)
	mr 3,31
	lfs 1,0(9)
	bl unicastSound
	lwz 9,100(28)
	li 3,1
	mtlr 9
	blrl
	lwz 3,g_edicts@l(23)
	lis 0,0x478b
	ori 0,0,48365
	lwz 11,104(28)
	subf 3,3,31
	mullw 3,3,0
	mtlr 11
	srawi 3,3,2
	blrl
	lwz 9,100(28)
	li 3,14
	mtlr 9
	blrl
	lwz 9,92(28)
	mr 3,31
	li 4,1
	mtlr 9
	blrl
.L316:
	addi 27,27,1
	lwz 11,maxclients@l(24)
	xoris 0,27,0x8000
	lis 10,.LC93@ha
	stw 0,36(1)
	la 10,.LC93@l(10)
	addi 31,31,916
	stw 25,32(1)
	lfd 13,0(10)
	lfd 0,32(1)
	lfs 12,20(11)
	fsub 0,0,13
	frsp 0,0
	fcmpu 0,0,12
	cror 3,2,0
	bc 12,3,.L315
.L313:
	lis 9,level+4@ha
	lwz 11,84(30)
	lfs 0,level+4@l(9)
	stfs 0,4000(11)
	lwz 0,84(1)
	mtlr 0
	lmw 23,44(1)
	la 1,80(1)
	blr
.Lfe15:
	.size	 localRadio,.Lfe15-localRadio
	.section	".rodata"
	.align 2
.LC94:
	.string	"incoming"
	.align 2
.LC95:
	.string	"overrun"
	.align 2
.LC96:
	.string	"secure"
	.align 2
.LC97:
	.string	"base"
	.align 2
.LC98:
	.string	"escort"
	.align 2
.LC99:
	.string	"flag"
	.align 2
.LC100:
	.string	"staying"
	.align 2
.LC101:
	.string	"hold"
	.align 2
.LC102:
	.string	"follow"
	.align 2
.LC103:
	.string	"cover"
	.align 2
.LC104:
	.string	"ok"
	.align 2
.LC105:
	.string	"no"
	.align 2
.LC106:
	.string	"Bad audio property: name %s, value %s\nAssuming local radio, no gesture\n"
	.align 2
.LC107:
	.string	"Bad TeamAudio sound name\n"
	.align 2
.LC108:
	.long 0x0
	.align 2
.LC109:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl sendRadio
	.type	 sendRadio,@function
sendRadio:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 11,.LC108@ha
	lis 9,ctf@ha
	la 11,.LC108@l(11)
	mr 26,3
	lfs 13,0(11)
	mr 31,4
	li 27,-1
	lwz 11,ctf@l(9)
	li 25,0
	li 30,0
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L337
	lis 29,.LC94@ha
	mr 3,31
	la 4,.LC94@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L338
	la 30,.LC94@l(29)
	li 25,1
	b .L337
.L338:
	lis 29,.LC95@ha
	mr 3,31
	la 4,.LC95@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L340
	la 30,.LC95@l(29)
	li 25,1
	b .L337
.L340:
	lis 29,.LC96@ha
	mr 3,31
	la 4,.LC96@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L342
	la 30,.LC96@l(29)
	li 25,1
	b .L337
.L342:
	lis 29,.LC97@ha
	mr 3,31
	la 4,.LC97@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L344
	la 30,.LC97@l(29)
	b .L381
.L344:
	lis 29,.LC98@ha
	mr 3,31
	la 4,.LC98@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L346
	la 30,.LC98@l(29)
	b .L381
.L346:
	lis 29,.LC99@ha
	mr 3,31
	la 4,.LC99@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L337
	la 30,.LC99@l(29)
.L381:
	li 27,4
.L337:
	lis 29,.LC100@ha
	mr 3,31
	la 4,.LC100@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L349
	la 30,.LC100@l(29)
	b .L350
.L349:
	lis 29,.LC101@ha
	mr 3,31
	la 4,.LC101@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L351
	la 30,.LC101@l(29)
	li 27,4
	b .L350
.L351:
	lis 29,.LC102@ha
	mr 3,31
	la 4,.LC102@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L353
	la 30,.LC102@l(29)
	li 27,3
	b .L350
.L353:
	lis 29,.LC103@ha
	mr 3,31
	la 4,.LC103@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L355
	la 30,.LC103@l(29)
	li 27,3
	b .L350
.L355:
	lis 29,.LC104@ha
	mr 3,31
	la 4,.LC104@l(29)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L357
	la 30,.LC104@l(29)
	li 27,1
	b .L350
.L357:
	lis 29,.LC105@ha
	mr 3,31
	la 4,.LC105@l(29)
	bl Q_stricmp
	srawi 9,3,31
	la 29,.LC105@l(29)
	xor 0,9,3
	subf 0,0,9
	srawi 0,0,31
	andc 29,29,0
	and 0,30,0
	or 30,0,29
.L350:
	cmpwi 0,30,0
	bc 4,2,.L360
	lis 9,gProperties@ha
	mr 4,31
	lwz 3,gProperties@l(9)
	bl getProp
	mr. 28,3
	bc 12,2,.L361
	lis 29,errno@ha
	mr 3,28
	stw 30,errno@l(29)
	bl atoi
	lwz 0,errno@l(29)
	cmpwi 0,0,0
	bc 4,2,.L362
	rlwinm 25,3,29,31,31
	rlwinm 3,3,0,29,27
	subfic 0,3,4
	subfe 0,0,0
	andc 9,3,0
	and 0,27,0
	or 27,0,9
	b .L364
.L362:
	lis 9,gi+4@ha
	lis 3,.LC106@ha
	lwz 0,gi+4@l(9)
	la 3,.LC106@l(3)
	mr 5,28
	mr 4,31
	mtlr 0
	crxor 6,6,6
	blrl
.L364:
	mr 30,31
	b .L360
.L361:
	lis 9,gi+8@ha
	lis 5,.LC107@ha
	lwz 0,gi+8@l(9)
	mr 3,26
	la 5,.LC107@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
	b .L336
.L360:
	cmpwi 0,25,0
	bc 4,2,.L366
	mr 4,30
	mr 3,26
	bl localRadio
	cmpwi 0,27,-1
	bc 12,2,.L336
	mr 3,26
	mr 4,27
	bl wave
	b .L336
.L366:
	lis 9,gi@ha
	lwz 29,84(26)
	mr 3,26
	la 28,gi@l(9)
	bl IsFemale
	cmpwi 0,3,0
	bc 12,2,.L369
	lis 9,.LC88@ha
	la 4,.LC88@l(9)
	b .L370
.L369:
	lis 9,.LC89@ha
	la 4,.LC89@l(9)
.L370:
	lis 3,.LC90@ha
	mr 5,30
	la 3,.LC90@l(3)
	li 31,1
	crxor 6,6,6
	bl va
	lwz 0,36(28)
	mtlr 0
	blrl
	lis 9,game@ha
	lis 11,g_edicts@ha
	lwz 30,3476(29)
	la 10,game@l(9)
	mr 28,3
	lwz 0,1544(10)
	lwz 9,g_edicts@l(11)
	cmpw 0,31,0
	addi 29,9,916
	bc 12,1,.L379
	mr 27,10
.L375:
	lwz 0,88(29)
	cmpwi 0,0,0
	bc 12,2,.L376
	lwz 9,84(29)
	cmpwi 0,9,0
	bc 12,2,.L376
	lwz 0,3476(9)
	cmpw 0,0,30
	bc 4,2,.L376
	lis 9,.LC109@ha
	mr 3,29
	la 9,.LC109@l(9)
	mr 4,28
	lfs 1,0(9)
	bl unicastSound
.L376:
	lwz 0,1544(27)
	addi 31,31,1
	addi 29,29,916
	cmpw 0,31,0
	bc 4,1,.L375
.L379:
	lis 9,level+4@ha
	lwz 11,84(26)
	lfs 0,level+4@l(9)
	stfs 0,4000(11)
.L336:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe16:
	.size	 sendRadio,.Lfe16-sendRadio
	.section	".rodata"
	.align 2
.LC110:
	.string	"bind"
	.align 2
.LC111:
	.string	"You can only use TeamAudio once per second\n"
	.align 2
.LC112:
	.long 0x0
	.align 3
.LC113:
	.long 0x3ff00000
	.long 0x0
	.section	".text"
	.align 2
	.globl Cmd_TeamAudio_f
	.type	 Cmd_TeamAudio_f,@function
Cmd_TeamAudio_f:
	stwu 1,-48(1)
	mflr 0
	stmw 29,36(1)
	stw 0,52(1)
	lis 10,dmflags@ha
	lwz 11,dmflags@l(10)
	mr 31,3
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,24(1)
	lwz 9,28(1)
	andi. 0,9,192
	bc 4,2,.L383
	lis 9,gi+4@ha
	lis 3,.LC15@ha
	lwz 0,gi+4@l(9)
	la 3,.LC15@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
	b .L382
.L383:
	lis 9,gi@ha
	la 29,gi@l(9)
	lwz 9,164(29)
	mtlr 9
	blrl
	mr 30,3
	lbz 0,0(30)
	cmpwi 0,0,0
	bc 4,2,.L386
	mr 3,31
	bl printAudioCmds
	b .L382
.L386:
	lis 4,.LC110@ha
	mr 3,30
	la 4,.LC110@l(4)
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L387
	lis 9,.LC112@ha
	lis 11,ctf@ha
	la 9,.LC112@l(9)
	lfs 13,0(9)
	lwz 9,ctf@l(11)
	lfs 0,20(9)
	fcmpu 0,0,13
	bc 12,2,.L388
	lis 4,.LC77@ha
	mr 3,31
	la 4,.LC77@l(4)
	bl StuffCmd
	lis 4,.LC78@ha
	mr 3,31
	la 4,.LC78@l(4)
	bl StuffCmd
	lis 4,.LC79@ha
	mr 3,31
	la 4,.LC79@l(4)
	bl StuffCmd
	lis 4,.LC80@ha
	mr 3,31
	la 4,.LC80@l(4)
	bl StuffCmd
	lis 4,.LC81@ha
	mr 3,31
	la 4,.LC81@l(4)
	bl StuffCmd
.L388:
	lis 4,.LC82@ha
	mr 3,31
	la 4,.LC82@l(4)
	bl StuffCmd
	lis 4,.LC83@ha
	mr 3,31
	la 4,.LC83@l(4)
	bl StuffCmd
	lis 4,.LC84@ha
	mr 3,31
	la 4,.LC84@l(4)
	bl StuffCmd
	lis 4,.LC85@ha
	mr 3,31
	la 4,.LC85@l(4)
	bl StuffCmd
	lis 4,.LC86@ha
	mr 3,31
	la 4,.LC86@l(4)
	bl StuffCmd
	lis 4,.LC87@ha
	mr 3,31
	la 4,.LC87@l(4)
	bl StuffCmd
	b .L382
.L387:
	lwz 11,84(31)
	lis 9,level+4@ha
	lis 10,.LC113@ha
	lfs 0,level+4@l(9)
	la 10,.LC113@l(10)
	lfs 13,4000(11)
	lfd 12,0(10)
	fsubs 0,0,13
	fcmpu 0,0,12
	cror 3,2,1
	bc 4,3,.L390
	mr 3,31
	mr 4,30
	bl sendRadio
	b .L382
.L390:
	lwz 0,8(29)
	lis 5,.LC111@ha
	mr 3,31
	la 5,.LC111@l(5)
	li 4,2
	mtlr 0
	crxor 6,6,6
	blrl
.L382:
	lwz 0,52(1)
	mtlr 0
	lmw 29,36(1)
	la 1,48(1)
	blr
.Lfe17:
	.size	 Cmd_TeamAudio_f,.Lfe17-Cmd_TeamAudio_f
	.comm	gametype,4,4
	.comm	flags,4,4
	.comm	gCauseTable,4,4
	.align 2
	.globl teamplayEnabled
	.type	 teamplayEnabled,@function
teamplayEnabled:
	stwu 1,-16(1)
	lis 11,dmflags@ha
	lwz 9,dmflags@l(11)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 3,12(1)
	rlwinm 3,3,0,24,25
	neg 3,3
	srwi 3,3,31
	la 1,16(1)
	blr
.Lfe18:
	.size	 teamplayEnabled,.Lfe18-teamplayEnabled
	.align 2
	.globl playerIsOnATeam
	.type	 playerIsOnATeam,@function
playerIsOnATeam:
	stwu 1,-16(1)
	lis 10,dmflags@ha
	lwz 11,dmflags@l(10)
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	andi. 0,9,192
	bc 12,2,.L9
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 11,12(1)
	andi. 9,11,256
	bc 12,2,.L12
	lwz 9,84(3)
	lwz 0,3476(9)
	nor 0,0,0
	addic 9,0,-1
	subfe 3,9,0
	b .L394
.L12:
	li 3,1
	b .L394
.L9:
	li 3,0
.L394:
	la 1,16(1)
	blr
.Lfe19:
	.size	 playerIsOnATeam,.Lfe19-playerIsOnATeam
	.align 2
	.globl onSameTeam
	.type	 onSameTeam,@function
onSameTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 11,dmflags@ha
	lwz 10,dmflags@l(11)
	mr 31,3
	mr 30,4
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 9,20(1)
	andi. 0,9,192
	bc 12,2,.L23
	subfic 11,31,0
	adde 9,11,31
	subfic 11,30,0
	adde 0,11,30
	or. 11,9,0
	bc 12,2,.L18
	lis 9,gi+4@ha
	lis 3,.LC0@ha
	lwz 0,gi+4@l(9)
	la 3,.LC0@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L18:
	lwz 7,84(31)
	cmpwi 0,7,0
	bc 12,2,.L23
	lwz 8,84(30)
	cmpwi 0,8,0
	bc 12,2,.L23
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,256
	bc 12,2,.L21
	lwz 9,3476(7)
	lwz 0,3476(8)
	cmpw 0,9,0
	bc 4,2,.L23
	li 3,1
	b .L395
.L21:
	mr 3,31
	mr 4,30
	bl OnSameTeam
	b .L395
.L23:
	li 3,0
.L395:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe20:
	.size	 onSameTeam,.Lfe20-onSameTeam
	.align 2
	.globl validSkinName
	.type	 validSkinName,@function
validSkinName:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr. 31,3
	bc 12,2,.L63
	mr 3,31
	bl strlen
	cmpwi 0,3,0
	bc 12,2,.L63
	lis 30,.LC5@ha
	mr 3,31
	la 4,.LC5@l(30)
	bl strcspn
	mr 29,3
	mr 3,31
	bl strlen
	cmpw 0,29,3
	bc 12,2,.L63
	la 4,.LC5@l(30)
	mr 3,31
	bl strcspn
	mr 29,3
	mr 3,31
	bl strlen
	addi 3,3,-1
	cmpw 0,29,3
	bc 4,2,.L62
.L63:
	li 3,0
	b .L396
.L62:
	li 3,1
.L396:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe21:
	.size	 validSkinName,.Lfe21-validSkinName
	.align 2
	.globl nameForTeam
	.type	 nameForTeam,@function
nameForTeam:
	mulli 3,3,20
	lis 9,gTeams@ha
	la 9,gTeams@l(9)
	lwzx 3,9,3
	blr
.Lfe22:
	.size	 nameForTeam,.Lfe22-nameForTeam
	.align 2
	.globl teamForName
	.type	 teamForName,@function
teamForName:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,sv_numteams@ha
	lwz 11,sv_numteams@l(9)
	li 31,0
	mr 29,3
	lis 28,sv_numteams@ha
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 0,12(1)
	cmpw 0,31,0
	bc 4,0,.L27
	lis 9,gTeams@ha
	la 30,gTeams@l(9)
.L29:
	lwz 4,0(30)
	mr 3,29
	addi 30,30,20
	bl Q_stricmp
	cmpwi 0,3,0
	bc 4,2,.L28
	mr 3,31
	b .L397
.L28:
	lwz 9,sv_numteams@l(28)
	addi 31,31,1
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 0,12(1)
	cmpw 0,31,0
	bc 12,0,.L29
.L27:
	li 3,-1
.L397:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe23:
	.size	 teamForName,.Lfe23-teamForName
	.align 2
	.globl memberCount
	.type	 memberCount,@function
memberCount:
	lis 9,gTeams@ha
	mulli 3,3,20
	la 9,gTeams@l(9)
	addi 9,9,12
	lwzx 3,9,3
	blr
.Lfe24:
	.size	 memberCount,.Lfe24-memberCount
	.align 2
	.globl teamSound
	.type	 teamSound,@function
teamSound:
	stwu 1,-48(1)
	mflr 0
	stfd 31,40(1)
	stmw 27,20(1)
	stw 0,52(1)
	lis 9,game@ha
	lis 11,g_edicts@ha
	fmr 31,1
	la 10,game@l(9)
	li 30,1
	lwz 0,1544(10)
	mr 28,3
	mr 29,4
	lwz 9,g_edicts@l(11)
	cmpw 0,30,0
	addi 31,9,916
	bc 12,1,.L49
	mr 27,10
.L51:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L52
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L52
	lwz 0,3476(9)
	cmpw 0,0,28
	bc 4,2,.L52
	fmr 1,31
	mr 3,31
	mr 4,29
	bl unicastSound
.L52:
	lwz 0,1544(27)
	addi 30,30,1
	addi 31,31,916
	cmpw 0,30,0
	bc 4,1,.L51
.L49:
	lwz 0,52(1)
	mtlr 0
	lmw 27,20(1)
	lfd 31,40(1)
	la 1,48(1)
	blr
.Lfe25:
	.size	 teamSound,.Lfe25-teamSound
	.align 2
	.globl teamPrint
	.type	 teamPrint,@function
teamPrint:
	stwu 1,-48(1)
	mflr 0
	stmw 25,20(1)
	stw 0,52(1)
	lis 9,game@ha
	lis 11,g_edicts@ha
	la 10,game@l(9)
	li 30,1
	lwz 0,1544(10)
	mr 27,3
	mr 28,4
	lwz 9,g_edicts@l(11)
	mr 29,5
	cmpw 0,30,0
	addi 31,9,916
	bc 12,1,.L56
	lis 9,gi@ha
	mr 25,10
	la 26,gi@l(9)
.L58:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L59
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L59
	lwz 0,3476(9)
	cmpw 0,0,27
	bc 4,2,.L59
	lwz 9,8(26)
	mr 3,31
	mr 4,28
	mr 5,29
	mtlr 9
	crxor 6,6,6
	blrl
.L59:
	lwz 0,1544(25)
	addi 30,30,1
	addi 31,31,916
	cmpw 0,30,0
	bc 4,1,.L58
.L56:
	lwz 0,52(1)
	mtlr 0
	lmw 25,20(1)
	la 1,48(1)
	blr
.Lfe26:
	.size	 teamPrint,.Lfe26-teamPrint
	.align 2
	.globl InitTeamAudio
	.type	 InitTeamAudio,@function
InitTeamAudio:
	blr
.Lfe27:
	.size	 InitTeamAudio,.Lfe27-InitTeamAudio
	.align 2
	.globl assignTeam
	.type	 assignTeam,@function
assignTeam:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	li 4,-1
	bl assignToTeam
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe28:
	.size	 assignTeam,.Lfe28-assignTeam
	.align 2
	.globl addPlayerToTeam
	.type	 addPlayerToTeam,@function
addPlayerToTeam:
	stwu 1,-16(1)
	lis 11,sv_expflags@ha
	lwz 10,sv_expflags@l(11)
	lfs 0,20(10)
	fctiwz 13,0
	stfd 13,8(1)
	lwz 9,12(1)
	andi. 0,9,256
	bc 12,2,.L119
	lwz 9,84(3)
	li 0,0
	lis 10,gTeams@ha
	la 10,gTeams@l(10)
	stw 0,3432(9)
	addi 10,10,12
	lwz 9,84(3)
	stw 4,3476(9)
	lwz 11,84(3)
	lwz 0,3476(11)
	mulli 0,0,20
	lwzx 9,10,0
	addi 9,9,1
	stwx 9,10,0
.L119:
	la 1,16(1)
	blr
.Lfe29:
	.size	 addPlayerToTeam,.Lfe29-addPlayerToTeam
	.align 2
	.globl shutdownTeamplay
	.type	 shutdownTeamplay,@function
shutdownTeamplay:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 10,sv_expflags@ha
	lwz 9,sv_expflags@l(10)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 11,20(1)
	andi. 0,11,256
	bc 12,2,.L289
	lis 9,gTeams@ha
	la 31,gTeams@l(9)
	addi 30,31,620
.L294:
	lwz 3,0(31)
	cmpwi 0,3,0
	bc 12,2,.L295
	bl free
.L295:
	lwz 3,4(31)
	cmpwi 0,3,0
	bc 12,2,.L296
	bl free
.L296:
	lwz 3,16(31)
	cmpwi 0,3,0
	bc 12,2,.L293
	bl free
.L293:
	addi 31,31,20
	cmpw 0,31,30
	bc 4,1,.L294
.L289:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe30:
	.size	 shutdownTeamplay,.Lfe30-shutdownTeamplay
	.comm	gTeams,640,4
	.align 2
	.globl modelFromString
	.type	 modelFromString,@function
modelFromString:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	lis 27,whichModel.37@ha
	mr 26,3
	lwz 0,whichModel.37@l(27)
	lis 4,.LC5@ha
	la 4,.LC5@l(4)
	xori 0,0,1
	stw 0,whichModel.37@l(27)
	bl strcspn
	lwz 0,whichModel.37@l(27)
	lis 29,model.36@ha
	mr 28,3
	la 29,model.36@l(29)
	mr 5,28
	slwi 0,0,9
	mr 4,26
	add 3,0,29
	bl strncpy
	lwz 3,whichModel.37@l(27)
	li 0,0
	slwi 3,3,9
	add 28,28,3
	add 3,3,29
	stbx 0,29,28
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe31:
	.size	 modelFromString,.Lfe31-modelFromString
	.align 2
	.globl skinFromString
	.type	 skinFromString,@function
skinFromString:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 27,whichSkin.42@ha
	mr 31,3
	lwz 0,whichSkin.42@l(27)
	lis 30,.LC5@ha
	la 4,.LC5@l(30)
	xori 0,0,1
	stw 0,whichSkin.42@l(27)
	bl strcspn
	mr 29,3
	mr 3,31
	bl strlen
	cmpw 0,29,3
	bc 12,2,.L67
	la 4,.LC5@l(30)
	mr 3,31
	bl strcspn
	mr 29,3
	mr 3,31
	bl strlen
	addi 3,3,-1
	cmpw 0,29,3
	bc 4,2,.L66
.L67:
	lis 3,.LC6@ha
	la 3,.LC6@l(3)
	b .L398
.L66:
	lwz 29,whichSkin.42@l(27)
	lis 28,skin.41@ha
	la 4,.LC5@l(30)
	la 28,skin.41@l(28)
	mr 3,31
	slwi 29,29,9
	add 29,29,28
	bl strcspn
	add 4,31,3
	mr 3,29
	addi 4,4,1
	bl strcpy
	lwz 3,whichSkin.42@l(27)
	slwi 3,3,9
	add 3,3,28
.L398:
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe32:
	.size	 skinFromString,.Lfe32-skinFromString
	.align 2
	.globl totalTeamScore
	.type	 totalTeamScore,@function
totalTeamScore:
	lis 9,game+1544@ha
	mr 10,3
	lwz 0,game+1544@l(9)
	li 3,0
	cmpwi 0,0,0
	bclr 4,1
	lis 11,g_edicts@ha
	mtctr 0
	lwz 9,g_edicts@l(11)
	addi 9,9,916
.L72:
	lwz 0,88(9)
	cmpwi 0,0,0
	bc 12,2,.L71
	lwz 11,84(9)
	cmpwi 0,11,0
	bc 12,2,.L71
	lwz 0,3476(11)
	cmpw 0,0,10
	bc 4,2,.L71
	lwz 0,3432(11)
	add 3,3,0
.L71:
	addi 9,9,916
	bdnz .L72
	blr
.Lfe33:
	.size	 totalTeamScore,.Lfe33-totalTeamScore
	.align 2
	.globl weakestTeam
	.type	 weakestTeam,@function
weakestTeam:
	stwu 1,-32(1)
	mflr 0
	stmw 30,24(1)
	stw 0,36(1)
	lis 9,sv_numteams@ha
	lwz 11,sv_numteams@l(9)
	li 3,0
	lis 30,sv_numteams@ha
	mr 31,3
	lfs 0,20(11)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpw 0,3,0
	bc 4,0,.L102
.L104:
	mr 4,3
	mr 3,31
	bl weakerTeam
	addi 31,31,1
	lwz 9,sv_numteams@l(30)
	lfs 0,20(9)
	fctiwz 13,0
	stfd 13,16(1)
	lwz 0,20(1)
	cmpw 0,31,0
	bc 12,0,.L104
.L102:
	lwz 0,36(1)
	mtlr 0
	lmw 30,24(1)
	la 1,32(1)
	blr
.Lfe34:
	.size	 weakestTeam,.Lfe34-weakestTeam
	.align 2
	.globl hackPrecacheModelSkin
	.type	 hackPrecacheModelSkin,@function
hackPrecacheModelSkin:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 11,precacheCounter@ha
	mr 4,3
	lwz 9,precacheCounter@l(11)
	lis 29,gi@ha
	lis 3,.LC39@ha
	la 29,gi@l(29)
	la 3,.LC39@l(3)
	addi 28,9,1440
	addi 9,9,1
	stw 9,precacheCounter@l(11)
	crxor 6,6,6
	bl va
	lwz 0,24(29)
	mr 4,3
	mr 3,28
	mtlr 0
	blrl
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe35:
	.size	 hackPrecacheModelSkin,.Lfe35-hackPrecacheModelSkin
	.section	".rodata"
	.align 2
.LC114:
	.long 0x0
	.section	".text"
	.align 2
	.globl audioBind
	.type	 audioBind,@function
audioBind:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 11,.LC114@ha
	lis 9,ctf@ha
	la 11,.LC114@l(11)
	mr 31,3
	lfs 13,0(11)
	lwz 11,ctf@l(9)
	lfs 0,20(11)
	fcmpu 0,0,13
	bc 12,2,.L303
	lis 4,.LC77@ha
	la 4,.LC77@l(4)
	bl StuffCmd
	lis 4,.LC78@ha
	mr 3,31
	la 4,.LC78@l(4)
	bl StuffCmd
	lis 4,.LC79@ha
	mr 3,31
	la 4,.LC79@l(4)
	bl StuffCmd
	lis 4,.LC80@ha
	mr 3,31
	la 4,.LC80@l(4)
	bl StuffCmd
	lis 4,.LC81@ha
	mr 3,31
	la 4,.LC81@l(4)
	bl StuffCmd
.L303:
	lis 4,.LC82@ha
	mr 3,31
	la 4,.LC82@l(4)
	bl StuffCmd
	lis 4,.LC83@ha
	mr 3,31
	la 4,.LC83@l(4)
	bl StuffCmd
	lis 4,.LC84@ha
	mr 3,31
	la 4,.LC84@l(4)
	bl StuffCmd
	lis 4,.LC85@ha
	mr 3,31
	la 4,.LC85@l(4)
	bl StuffCmd
	lis 4,.LC86@ha
	mr 3,31
	la 4,.LC86@l(4)
	bl StuffCmd
	lis 4,.LC87@ha
	mr 3,31
	la 4,.LC87@l(4)
	bl StuffCmd
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe36:
	.size	 audioBind,.Lfe36-audioBind
	.align 2
	.globl sexString
	.type	 sexString,@function
sexString:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	bl IsFemale
	cmpwi 0,3,0
	bc 12,2,.L305
	lis 9,.LC88@ha
	la 3,.LC88@l(9)
	b .L306
.L305:
	lis 9,.LC89@ha
	la 3,.LC89@l(9)
.L306:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe37:
	.size	 sexString,.Lfe37-sexString
	.align 2
	.globl soundPath
	.type	 soundPath,@function
soundPath:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,4
	bl IsFemale
	cmpwi 0,3,0
	bc 12,2,.L308
	lis 9,.LC88@ha
	la 4,.LC88@l(9)
	b .L309
.L308:
	lis 9,.LC89@ha
	la 4,.LC89@l(9)
.L309:
	lis 3,.LC90@ha
	mr 5,31
	la 3,.LC90@l(3)
	crxor 6,6,6
	bl va
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe38:
	.size	 soundPath,.Lfe38-soundPath
	.section	".rodata"
	.align 2
.LC115:
	.long 0x3f800000
	.section	".text"
	.align 2
	.globl globalRadio
	.type	 globalRadio,@function
globalRadio:
	stwu 1,-32(1)
	mflr 0
	stmw 26,8(1)
	stw 0,36(1)
	mr 29,3
	lis 9,gi@ha
	la 27,gi@l(9)
	lwz 28,84(29)
	mr 31,4
	bl IsFemale
	cmpwi 0,3,0
	bc 12,2,.L325
	lis 9,.LC88@ha
	la 4,.LC88@l(9)
	b .L326
.L325:
	lis 9,.LC89@ha
	la 4,.LC89@l(9)
.L326:
	lis 3,.LC90@ha
	mr 5,31
	la 3,.LC90@l(3)
	li 30,1
	crxor 6,6,6
	bl va
	lwz 0,36(27)
	mtlr 0
	blrl
	lis 9,game@ha
	lis 11,g_edicts@ha
	lwz 28,3476(28)
	la 10,game@l(9)
	mr 27,3
	lwz 0,1544(10)
	lwz 9,g_edicts@l(11)
	cmpw 0,30,0
	addi 31,9,916
	bc 12,1,.L335
	mr 26,10
.L331:
	lwz 0,88(31)
	cmpwi 0,0,0
	bc 12,2,.L332
	lwz 9,84(31)
	cmpwi 0,9,0
	bc 12,2,.L332
	lwz 0,3476(9)
	cmpw 0,0,28
	bc 4,2,.L332
	lis 9,.LC115@ha
	mr 3,31
	la 9,.LC115@l(9)
	mr 4,27
	lfs 1,0(9)
	bl unicastSound
.L332:
	lwz 0,1544(26)
	addi 30,30,1
	addi 31,31,916
	cmpw 0,30,0
	bc 4,1,.L331
.L335:
	lis 9,level+4@ha
	lwz 11,84(29)
	lfs 0,level+4@l(9)
	stfs 0,4000(11)
	lwz 0,36(1)
	mtlr 0
	lmw 26,8(1)
	la 1,32(1)
	blr
.Lfe39:
	.size	 globalRadio,.Lfe39-globalRadio
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
