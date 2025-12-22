	.file	"g_newdm.c"
gcc2_compiled.:
	.section	".rodata"
	.align 2
.LC0:
	.long 0x0
	.section	".text"
	.align 2
	.globl InitGameRules
	.type	 InitGameRules,@function
InitGameRules:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lis 3,DMGame@ha
	li 4,0
	la 3,DMGame@l(3)
	li 5,48
	crxor 6,6,6
	bl memset
	lis 9,gamerules@ha
	lwz 9,gamerules@l(9)
	cmpwi 0,9,0
	bc 12,2,.L7
	lis 11,.LC0@ha
	lfs 0,20(9)
	la 11,.LC0@l(11)
	lfs 13,0(11)
	fcmpu 0,0,13
	bc 12,2,.L7
	stfs 13,20(9)
.L7:
	lis 9,DMGame@ha
	lwz 0,DMGame@l(9)
	cmpwi 0,0,0
	bc 12,2,.L11
	mtlr 0
	blrl
.L11:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe1:
	.size	 InitGameRules,.Lfe1-InitGameRules
	.align 2
	.globl DoRandomRespawn
	.type	 DoRandomRespawn,@function
DoRandomRespawn:
	li 3,0
	blr
.Lfe2:
	.size	 DoRandomRespawn,.Lfe2-DoRandomRespawn
	.align 2
	.globl PrecacheForRandomRespawn
	.type	 PrecacheForRandomRespawn,@function
PrecacheForRandomRespawn:
	stwu 1,-32(1)
	mflr 0
	stmw 29,20(1)
	stw 0,36(1)
	lis 9,game@ha
	li 30,0
	la 9,game@l(9)
	lis 11,itemlist@ha
	lwz 0,1556(9)
	la 31,itemlist@l(11)
	cmpw 0,30,0
	bc 4,0,.L18
	mr 29,9
.L20:
	lwz 0,32(31)
	cmpwi 0,0,0
	bc 12,2,.L19
	mr 3,31
	bl PrecacheItem
.L19:
	lwz 0,1556(29)
	addi 30,30,1
	addi 31,31,44
	cmpw 0,30,0
	bc 12,0,.L20
.L18:
	lwz 0,36(1)
	mtlr 0
	lmw 29,20(1)
	la 1,32(1)
	blr
.Lfe3:
	.size	 PrecacheForRandomRespawn,.Lfe3-PrecacheForRandomRespawn
	.comm	DMGame,48,4
	.align 2
	.globl FindSubstituteItem
	.type	 FindSubstituteItem,@function
FindSubstituteItem:
	li 3,0
	blr
.Lfe4:
	.size	 FindSubstituteItem,.Lfe4-FindSubstituteItem
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
