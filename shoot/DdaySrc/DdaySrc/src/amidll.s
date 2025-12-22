	.file	"amidll.c"
gcc2_compiled.:
	.globl DLL_ExportSymbols
	.section	".data"
	.align 2
	.type	 DLL_ExportSymbols,@object
DLL_ExportSymbols:
	.long dllFindResource
	.long .LC0
	.long dllLoadResource
	.long .LC1
	.long dllFreeResource
	.long .LC2
	.long GetGameAPI
	.long .LC3
	.long 0
	.long 0
	.section	".rodata"
	.align 2
.LC3:
	.string	"GetGameAPI"
	.align 2
.LC2:
	.string	"dllFreeResource"
	.align 2
.LC1:
	.string	"dllLoadResource"
	.align 2
.LC0:
	.string	"dllFindResource"
	.size	 DLL_ExportSymbols,40
	.globl DLL_ImportSymbols
	.section	".data"
	.align 2
	.type	 DLL_ImportSymbols,@object
DLL_ImportSymbols:
	.long 0
	.long 0
	.long 0
	.long 0
	.size	 DLL_ImportSymbols,16
	.comm	is_silenced,1,1
	.comm	maplist,1060,4
	.comm	team_list,8,4
	.section	".text"
	.align 2
	.globl DLL_Init
	.type	 DLL_Init,@function
DLL_Init:
	stwu 1,-160(1)
	lis 9,DOSBase@ha
	lis 11,PowerPCBase@ha
	lwz 10,DOSBase@l(9)
	li 0,0
	addi 4,1,8
	li 9,-492
	lwz 3,PowerPCBase@l(11)
	stw 9,12(1)
	stw 10,8(1)
	stw 0,16(1)
	stw 10,84(1)
	stw 0,20(1)
	stw 0,24(1)
	lwz 0,-298(3)
	
	stwu	1,-32(1)
	mflr	12
	stw	12,28(1)
	mfcr	12
	stw	12,24(1)
	mtlr	0
	blrl
	lwz	12,24(1)
	mtcr	12
	lwz	12,28(1)
	mtlr	12
	la	1,32(1)
	
	lwz 9,28(1)
	cmpwi 0,9,0
	bc 12,2,.L10
	lwz 0,60(9)
	li 3,1
	lis 9,SegList@ha
	stw 0,SegList@l(9)
	b .L12
.L10:
	li 3,0
.L12:
	la 1,160(1)
	blr
.Lfe1:
	.size	 DLL_Init,.Lfe1-DLL_Init
	.align 2
	.globl DLL_DeInit
	.type	 DLL_DeInit,@function
DLL_DeInit:
	blr
.Lfe2:
	.size	 DLL_DeInit,.Lfe2-DLL_DeInit
	.align 2
	.globl dllFindResource
	.type	 dllFindResource,@function
dllFindResource:
	li 3,0
	blr
.Lfe3:
	.size	 dllFindResource,.Lfe3-dllFindResource
	.align 2
	.globl dllLoadResource
	.type	 dllLoadResource,@function
dllLoadResource:
	li 3,0
	blr
.Lfe4:
	.size	 dllLoadResource,.Lfe4-dllLoadResource
	.align 2
	.globl dllFreeResource
	.type	 dllFreeResource,@function
dllFreeResource:
	blr
.Lfe5:
	.size	 dllFreeResource,.Lfe5-dllFreeResource
	.comm	SegList,4,4
	.ident	"GCC: (GNU) 2.95.3 20010315 (release)"
