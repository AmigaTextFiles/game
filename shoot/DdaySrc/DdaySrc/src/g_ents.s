	.file	"g_ents.c"
gcc2_compiled.:
	.section	".sdata","aw"
	.align 2
	.type	 GlobalUserDLLList,@object
	.size	 GlobalUserDLLList,4
GlobalUserDLLList:
	.long 0
	.globl Last_Team_Winner
	.align 2
	.type	 Last_Team_Winner,@object
	.size	 Last_Team_Winner,4
Last_Team_Winner:
	.long 99
	.section	".rodata"
	.align 2
.LC0:
	.string	"trigger_enough_troops_use called\n"
	.align 2
.LC1:
	.string	"TRIGGER return code 1\n"
	.align 2
.LC2:
	.string	"TRIGGER return code 2 \n"
	.align 2
.LC3:
	.string	"TRIGGER return code 3\n"
	.align 2
.LC4:
	.string	"%i more to go..."
	.align 2
.LC5:
	.string	"TRIGGER return code 4\n"
	.align 2
.LC6:
	.string	"Ok, we got 'em all here!"
	.align 2
.LC7:
	.string	"TRIGGER return code 5\n"
	.align 2
.LC8:
	.string	"TRIGGER return code 6\n"
	.section	".text"
	.align 2
	.globl trigger_enough_troops_use
	.type	 trigger_enough_troops_use,@function
trigger_enough_troops_use:
	stwu 1,-32(1)
	mflr 0
	stmw 28,16(1)
	stw 0,36(1)
	lis 9,gi@ha
	mr 31,3
	la 29,gi@l(9)
	lis 3,.LC0@ha
	lwz 9,4(29)
	la 3,.LC0@l(3)
	mr 30,5
	mtlr 9
	crxor 6,6,6
	blrl
	lwz 10,952(31)
	cmpwi 0,10,1
	bc 12,1,.L7
	lwz 9,84(30)
	lwz 11,3448(9)
	lwz 0,84(11)
	cmpw 0,0,10
	bc 12,2,.L7
	lwz 0,4(29)
	lis 3,.LC1@ha
	la 3,.LC1@l(3)
	b .L21
.L7:
	lwz 0,536(31)
	cmpwi 0,0,0
	bc 4,2,.L8
	lis 9,gi+4@ha
	lis 3,.LC2@ha
	lwz 0,gi+4@l(9)
	la 3,.LC2@l(3)
	b .L21
.L8:
	lwz 9,84(30)
	lwz 10,484(31)
	lwz 11,3448(9)
	lwz 0,4(11)
	cmpw 0,0,10
	bc 12,2,.L9
	cmpwi 0,10,99
	bc 12,2,.L9
	lwz 0,952(31)
	lis 9,team_list@ha
	li 10,0
	la 9,team_list@l(9)
	lis 8,gi+4@ha
	slwi 0,0,2
	lis 3,.LC3@ha
	lwzx 11,9,0
	la 3,.LC3@l(3)
	stw 10,92(11)
	lwz 9,84(30)
	lwz 11,3448(9)
	lwz 0,84(11)
	stw 0,952(31)
	lwz 0,gi+4@l(8)
	b .L21
.L9:
	lis 9,gi@ha
	lis 11,team_list@ha
	la 29,gi@l(9)
	la 28,team_list@l(11)
	li 8,0
.L13:
	lwz 10,968(31)
	slwi 11,8,2
	lwzx 0,11,10
	cmpwi 0,0,0
	bc 12,2,.L14
	xor 0,0,30
	srawi 11,0,31
	xor 9,11,0
	subf 9,9,11
	srawi 9,9,31
	nor 0,9,9
	and 9,8,9
	rlwinm 0,0,0,27,27
	or 8,9,0
	b .L12
.L14:
	lwz 9,536(31)
	addi 9,9,-1
	stw 9,536(31)
	stwx 30,11,10
	lwz 11,84(30)
	lwz 5,536(31)
	lwz 9,3448(11)
	cmpwi 0,5,0
	lwz 0,84(9)
	stw 0,952(31)
	bc 12,2,.L16
	lwz 0,288(31)
	andi. 9,0,1
	bc 4,2,.L17
	lwz 9,12(29)
	lis 4,.LC4@ha
	mr 3,30
	la 4,.LC4@l(4)
	mtlr 9
	crxor 6,6,6
	blrl
.L17:
	lwz 0,4(29)
	lis 3,.LC5@ha
	la 3,.LC5@l(3)
.L21:
	mtlr 0
	crxor 6,6,6
	blrl
	b .L6
.L16:
	lwz 0,288(31)
	andi. 9,0,1
	bc 4,2,.L19
	lwz 9,12(29)
	lis 4,.LC6@ha
	mr 3,30
	la 4,.LC6@l(4)
	mtlr 9
	crxor 6,6,6
	blrl
.L19:
	lwz 10,84(30)
	lis 3,.LC7@ha
	lwz 11,520(31)
	la 3,.LC7@l(3)
	lwz 9,3448(10)
	stw 11,88(9)
	lwz 0,952(31)
	lfs 13,604(31)
	slwi 0,0,2
	lwzx 9,28,0
	lfs 0,92(9)
	fadds 0,0,13
	stfs 0,92(9)
	lwz 9,4(29)
	mtlr 9
	crxor 6,6,6
	blrl
	stw 30,556(31)
	mr 3,31
	bl multi_trigger
	li 8,16
.L12:
	addi 8,8,1
	cmpwi 0,8,15
	bc 4,1,.L13
	lis 9,gi+4@ha
	lis 3,.LC8@ha
	lwz 0,gi+4@l(9)
	la 3,.LC8@l(3)
	mtlr 0
	crxor 6,6,6
	blrl
.L6:
	lwz 0,36(1)
	mtlr 0
	lmw 28,16(1)
	la 1,32(1)
	blr
.Lfe1:
	.size	 trigger_enough_troops_use,.Lfe1-trigger_enough_troops_use
	.section	".rodata"
	.align 2
.LC9:
	.string	"%s has captured an objective point for team %s!\n"
	.section	".text"
	.align 2
	.globl SP_info_team_start
	.type	 SP_info_team_start,@function
SP_info_team_start:
	stwu 1,-32(1)
	mflr 0
	stmw 27,12(1)
	stw 0,36(1)
	lis 29,gi@ha
	mr 27,3
	la 29,gi@l(29)
	li 4,766
	lwz 28,952(27)
	lwz 9,132(29)
	li 3,248
	slwi 31,28,2
	mtlr 9
	blrl
	lis 9,team_list@ha
	lwz 11,132(29)
	li 4,766
	la 30,team_list@l(9)
	stwx 3,31,30
	mtlr 11
	li 3,4
	blrl
	lwzx 9,31,30
	li 4,766
	stw 3,0(9)
	lwzx 11,31,30
	li 3,64
	lwz 0,280(27)
	stw 0,0(11)
	lwz 0,132(29)
	mtlr 0
	blrl
	lwzx 11,31,30
	li 0,0
	stw 3,228(11)
	lwzx 9,31,30
	stw 0,76(9)
	lwzx 11,31,30
	stw 0,72(11)
	lwzx 9,31,30
	stw 28,84(9)
	lwzx 11,31,30
	stw 0,88(11)
	lwz 0,508(27)
	cmpwi 0,0,0
	bc 12,2,.L34
	lwzx 9,31,30
	stw 0,228(9)
	b .L35
.L34:
	lwzx 11,31,30
	lis 9,level+72@ha
	la 9,level+72@l(9)
	stw 9,228(11)
.L35:
	lwz 10,536(27)
	cmpwi 0,10,99
	bc 4,2,.L37
	lis 9,Last_Team_Winner@ha
	lwz 0,Last_Team_Winner@l(9)
	cmpwi 0,0,99
	bc 4,2,.L36
.L37:
	cmpwi 0,10,1
	bc 4,2,.L38
	lis 9,team_list@ha
	slwi 0,28,2
	la 9,team_list@l(9)
	mr 8,0
	lwzx 11,9,0
	b .L48
.L38:
	cmpwi 0,10,0
	bc 4,2,.L40
	lis 9,team_list@ha
	slwi 0,28,2
	la 9,team_list@l(9)
	mr 8,0
	lwzx 11,9,0
	b .L48
.L40:
	lis 9,team_list@ha
	slwi 0,28,2
	la 9,team_list@l(9)
	li 10,2
	b .L49
.L36:
	cmpw 0,0,28
	bc 4,2,.L43
	lis 9,team_list@ha
	slwi 0,28,2
	la 9,team_list@l(9)
	li 10,1
	b .L49
.L43:
	lis 9,team_list@ha
	slwi 0,28,2
	la 9,team_list@l(9)
	li 10,0
.L49:
	lwzx 11,9,0
	mr 8,0
.L48:
	stw 10,4(11)
	lis 9,team_list@ha
	li 0,0
	la 9,team_list@l(9)
	lwzx 11,8,9
	stw 0,92(11)
	lwz 0,484(27)
	cmpwi 0,0,0
	lwzx 9,8,9
	stw 0,236(9)
	lwz 0,520(27)
	cmpwi 0,0,0
	bc 12,2,.L47
	lis 9,team_list@ha
	la 9,team_list@l(9)
	lwzx 11,8,9
	stw 0,232(11)
.L47:
	mr 4,28
	mr 3,27
	bl LoadUserDLLs
	mr 4,28
	bl InitializeUserDLLs
	mr 3,27
	bl G_FreeEdict
	lwz 0,36(1)
	mtlr 0
	lmw 27,12(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 SP_info_team_start,.Lfe2-SP_info_team_start
	.comm	is_silenced,1,1
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.comm	id_GameCmds,492,4
	.lcomm	UserDLLImports,48,4
	.align 2
	.globl SP_trigger_enough_troops
	.type	 SP_trigger_enough_troops,@function
SP_trigger_enough_troops:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	mr 31,3
	lis 0,0xbf80
	lwz 9,536(31)
	stw 0,600(31)
	cmpwi 0,9,0
	bc 4,2,.L23
	li 0,2
	stw 0,536(31)
.L23:
	lis 9,gi+132@ha
	li 3,16256
	lwz 0,gi+132@l(9)
	li 4,766
	mtlr 0
	blrl
	lis 9,trigger_enough_troops_use@ha
	stw 3,968(31)
	la 9,trigger_enough_troops_use@l(9)
	stw 9,452(31)
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 SP_trigger_enough_troops,.Lfe3-SP_trigger_enough_troops
	.align 2
	.globl SP_info_Mission_Results
	.type	 SP_info_Mission_Results,@function
SP_info_Mission_Results:
	blr
.Lfe4:
	.size	 SP_info_Mission_Results,.Lfe4-SP_info_Mission_Results
	.align 2
	.globl target_objective_use
	.type	 target_objective_use,@function
target_objective_use:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	mr 30,5
	mr 31,3
	lwz 9,84(30)
	lwz 10,952(31)
	lwz 11,3448(9)
	lwz 0,84(11)
	cmpw 0,10,0
	bc 12,2,.L25
	lis 9,team_list@ha
	slwi 0,10,2
	la 29,team_list@l(9)
	lwzx 11,29,0
	cmpwi 0,11,0
	bc 12,2,.L27
	lwz 0,88(11)
	lwz 9,520(31)
	subf 0,9,0
	stw 0,88(11)
.L27:
	lwz 0,952(31)
	lis 11,gi@ha
	lis 4,.LC9@ha
	lwz 11,gi@l(11)
	la 4,.LC9@l(4)
	li 3,2
	slwi 0,0,2
	lwz 5,84(30)
	lwzx 9,29,0
	mtlr 11
	addi 5,5,700
	lwz 6,0(9)
	crxor 6,6,6
	blrl
	lwz 11,84(30)
	lwz 10,520(31)
	lwz 9,3448(11)
	lwz 0,84(9)
	stw 0,952(31)
	slwi 11,0,2
	lwzx 9,11,29
	lwz 0,88(9)
	add 0,0,10
	stw 0,88(9)
.L25:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe5:
	.size	 target_objective_use,.Lfe5-target_objective_use
	.section	".rodata"
	.align 2
.LC10:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_target_objective
	.type	 SP_target_objective,@function
SP_target_objective:
	lis 9,.LC10@ha
	lfs 13,604(3)
	lis 0,0xbf80
	la 9,.LC10@l(9)
	stw 0,600(3)
	lfs 0,0(9)
	lis 9,target_objective_use@ha
	la 9,target_objective_use@l(9)
	fcmpu 0,13,0
	stw 9,452(3)
	bclr 12,2
	lwz 0,952(3)
	cmpwi 0,0,99
	bclr 12,2
	lis 11,level+4@ha
	lis 9,team_list@ha
	lfs 0,level+4@l(11)
	la 9,team_list@l(9)
	slwi 0,0,2
	lwzx 11,9,0
	fadds 0,0,13
	stfs 0,92(11)
	blr
.Lfe6:
	.size	 SP_target_objective,.Lfe6-SP_target_objective
	.section	".rodata"
	.align 2
.LC11:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_info_reinforcement_start
	.type	 SP_info_reinforcement_start,@function
SP_info_reinforcement_start:
	lis 9,.LC11@ha
	lfs 12,604(3)
	lis 11,level+4@ha
	la 9,.LC11@l(9)
	lfs 0,0(9)
	lis 9,reinforcement_think@ha
	la 9,reinforcement_think@l(9)
	fcmpu 0,12,0
	stw 9,440(3)
	lfs 13,level+4@l(11)
	bc 12,2,.L31
	fadds 0,13,12
	b .L32
.L31:
	lis 9,RI@ha
	lwz 11,RI@l(9)
	lfs 0,20(11)
	fadds 0,13,0
.L32:
	li 0,1
	stfs 0,1008(3)
	stw 0,972(3)
	stfs 0,432(3)
	blr
.Lfe7:
	.size	 SP_info_reinforcement_start,.Lfe7-SP_info_reinforcement_start
	.align 2
	.globl SP_info_Max_MOS
	.type	 SP_info_Max_MOS,@function
SP_info_Max_MOS:
	blr
.Lfe8:
	.size	 SP_info_Max_MOS,.Lfe8-SP_info_Max_MOS
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
