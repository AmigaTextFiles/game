	.file	"fogstub.c"
gcc2_compiled.:
	.section	".text"
	.align 2
	.globl CGF_SFX_InstallFogSupport
	.type	 CGF_SFX_InstallFogSupport,@function
CGF_SFX_InstallFogSupport:
	blr
.Lfe1:
	.size	 CGF_SFX_InstallFogSupport,.Lfe1-CGF_SFX_InstallFogSupport
	.align 2
	.globl CGF_SFX_AdjustFogForMap
	.type	 CGF_SFX_AdjustFogForMap,@function
CGF_SFX_AdjustFogForMap:
	blr
.Lfe2:
	.size	 CGF_SFX_AdjustFogForMap,.Lfe2-CGF_SFX_AdjustFogForMap
	.align 2
	.globl CGF_SFX_IsFogEnabled
	.type	 CGF_SFX_IsFogEnabled,@function
CGF_SFX_IsFogEnabled:
	li 3,0
	blr
.Lfe3:
	.size	 CGF_SFX_IsFogEnabled,.Lfe3-CGF_SFX_IsFogEnabled
	.section	".rodata"
	.align 2
.LC0:
	.long 0x0
	.section	".text"
	.align 2
	.globl CGF_SFX_GetFogForDistance
	.type	 CGF_SFX_GetFogForDistance,@function
CGF_SFX_GetFogForDistance:
	lis 9,.LC0@ha
	la 9,.LC0@l(9)
	lfs 1,0(9)
	blr
.Lfe4:
	.size	 CGF_SFX_GetFogForDistance,.Lfe4-CGF_SFX_GetFogForDistance
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
