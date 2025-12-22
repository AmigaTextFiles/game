	.file	"fog.c"
gcc2_compiled.:
	.section	".rodata"
	.align 3
.LC0:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl Smooth_Fog_Think
	.type	 Smooth_Fog_Think,@function
Smooth_Fog_Think:
	stwu 1,-16(1)
	mflr 0
	stw 0,20(1)
	lwz 9,256(3)
	li 0,1
	stw 0,916(9)
	lfs 12,896(3)
	lfs 11,328(3)
	lwz 9,256(3)
	fsubs 0,12,11
	lfs 13,896(9)
	fcmpu 0,13,0
	bc 4,0,.L124
	fadds 0,13,11
	stfs 0,896(9)
	b .L125
.L124:
	fcmpu 7,13,12
	bc 12,28,.L153
	fadds 0,12,11
	fcmpu 0,13,0
	bc 4,1,.L128
	fsubs 0,13,11
	stfs 0,896(9)
	b .L125
.L128:
	bc 4,29,.L125
.L153:
	stfs 12,896(9)
.L125:
	lfs 12,900(3)
	lfs 11,328(3)
	lwz 9,256(3)
	fsubs 0,12,11
	lfs 13,900(9)
	fcmpu 0,13,0
	bc 4,0,.L131
	fadds 0,13,11
	stfs 0,900(9)
	b .L132
.L131:
	fcmpu 7,13,12
	bc 12,28,.L154
	fadds 0,12,11
	fcmpu 0,13,0
	bc 4,1,.L135
	fsubs 0,13,11
	stfs 0,900(9)
	b .L132
.L135:
	bc 4,29,.L132
.L154:
	stfs 12,900(9)
.L132:
	lfs 12,904(3)
	lfs 11,328(3)
	lwz 9,256(3)
	fsubs 0,12,11
	lfs 13,904(9)
	fcmpu 0,13,0
	bc 4,0,.L138
	fadds 0,13,11
	stfs 0,904(9)
	b .L139
.L138:
	fcmpu 7,13,12
	bc 12,28,.L155
	fadds 0,12,11
	fcmpu 0,13,0
	bc 4,1,.L142
	fsubs 0,13,11
	stfs 0,904(9)
	b .L139
.L142:
	bc 4,29,.L139
.L155:
	stfs 12,904(9)
.L139:
	lfs 12,908(3)
	lfs 11,328(3)
	lwz 9,256(3)
	fsubs 0,12,11
	lfs 13,908(9)
	fcmpu 0,13,0
	bc 4,0,.L145
	fadds 0,13,11
	stfs 0,908(9)
	b .L146
.L145:
	fcmpu 7,13,12
	bc 12,28,.L156
	fadds 0,12,11
	fcmpu 0,13,0
	bc 4,1,.L149
	fsubs 0,13,11
	stfs 0,908(9)
	b .L146
.L149:
	bc 4,29,.L146
.L156:
	stfs 12,908(9)
.L146:
	lwz 9,256(3)
	lfs 13,896(3)
	lfs 0,896(9)
	fcmpu 0,13,0
	bc 4,2,.L152
	lfs 13,900(3)
	lfs 0,900(9)
	fcmpu 0,13,0
	bc 4,2,.L152
	lfs 13,904(3)
	lfs 0,904(9)
	fcmpu 0,13,0
	bc 4,2,.L152
	lfs 13,908(3)
	lfs 0,908(9)
	fcmpu 0,13,0
	bc 4,2,.L152
	lwz 3,920(9)
	bl G_FreeEdict
	b .L123
.L152:
	lis 9,level+4@ha
	lis 11,.LC0@ha
	lfs 0,level+4@l(9)
	lfd 13,.LC0@l(11)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(3)
.L123:
	lwz 0,20(1)
	mtlr 0
	la 1,16(1)
	blr
.Lfe1:
	.size	 Smooth_Fog_Think,.Lfe1-Smooth_Fog_Think
	.align 2
	.globl Fog_Update
	.type	 Fog_Update,@function
Fog_Update:
	stwu 1,-32(1)
	la 1,32(1)
	blr
.Lfe2:
	.size	 Fog_Update,.Lfe2-Fog_Update
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
	.section	".rodata"
	.align 2
.LC5:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_trigger_fog
	.type	 SP_trigger_fog,@function
SP_trigger_fog:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,FullGL@ha
	mr 31,3
	lwz 0,FullGL@l(9)
	cmpwi 0,0,0
	bc 4,2,.L163
	bl G_FreeEdict
	b .L162
.L163:
	lis 9,.LC5@ha
	lfs 13,908(31)
	la 9,.LC5@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L164
	lis 0,0x3f80
	stw 0,908(31)
.L164:
	lwz 0,912(31)
	cmpwi 0,0,0
	bc 4,2,.L165
	li 0,1
	stw 0,912(31)
.L165:
	mr 3,31
	bl InitTrigger
	lis 9,trigger_fog_touch@ha
	la 9,trigger_fog_touch@l(9)
	stw 9,444(31)
.L162:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe3:
	.size	 SP_trigger_fog,.Lfe3-SP_trigger_fog
	.section	".rodata"
	.align 2
.LC6:
	.long 0x3dcccccd
	.align 2
.LC7:
	.long 0x0
	.section	".text"
	.align 2
	.globl SP_trigger_smooth_fog
	.type	 SP_trigger_smooth_fog,@function
SP_trigger_smooth_fog:
	stwu 1,-16(1)
	mflr 0
	stw 31,12(1)
	stw 0,20(1)
	lis 9,FullGL@ha
	mr 31,3
	lwz 0,FullGL@l(9)
	cmpwi 0,0,0
	bc 4,2,.L167
	bl G_FreeEdict
	b .L166
.L167:
	mr 3,31
	bl InitTrigger
	lis 9,.LC7@ha
	lfs 0,908(31)
	la 9,.LC7@l(9)
	lfs 13,0(9)
	lis 9,trigger_smooth_fog_touch@ha
	la 9,trigger_smooth_fog_touch@l(9)
	fcmpu 0,0,13
	stw 9,444(31)
	bc 4,2,.L171
	lis 0,0x3f80
	stw 0,908(31)
.L171:
	lwz 0,912(31)
	cmpwi 0,0,0
	bc 4,2,.L172
	li 0,1
	stw 0,912(31)
.L172:
	lis 9,.LC7@ha
	lfs 13,328(31)
	la 9,.LC7@l(9)
	lfs 0,0(9)
	fcmpu 0,13,0
	bc 4,2,.L166
	lis 9,.LC6@ha
	lfs 0,.LC6@l(9)
	stfs 0,328(31)
.L166:
	lwz 0,20(1)
	mtlr 0
	lwz 31,12(1)
	la 1,16(1)
	blr
.Lfe4:
	.size	 SP_trigger_smooth_fog,.Lfe4-SP_trigger_smooth_fog
	.align 2
	.globl trigger_fog_touch
	.type	 trigger_fog_touch,@function
trigger_fog_touch:
	lfs 0,896(3)
	stfs 0,896(4)
	lfs 13,900(3)
	stfs 13,900(4)
	lfs 0,904(3)
	stfs 0,904(4)
	lfs 13,908(3)
	stfs 13,908(4)
	lwz 0,284(3)
	andi. 9,0,1
	li 0,1
	bc 12,2,.L121
	li 0,0
.L121:
	stw 0,912(4)
	li 0,1
	stw 0,916(4)
	blr
.Lfe5:
	.size	 trigger_fog_touch,.Lfe5-trigger_fog_touch
	.section	".rodata"
	.align 3
.LC8:
	.long 0x3fb99999
	.long 0x9999999a
	.section	".text"
	.align 2
	.globl trigger_smooth_fog_touch
	.type	 trigger_smooth_fog_touch,@function
trigger_smooth_fog_touch:
	stwu 1,-16(1)
	mflr 0
	stmw 30,8(1)
	stw 0,20(1)
	mr 31,4
	mr 30,3
	lwz 0,84(31)
	cmpwi 0,0,0
	bc 4,2,.L158
	lfs 13,896(30)
	li 0,1
	stfs 13,896(31)
	lfs 0,900(30)
	stfs 0,900(31)
	lfs 13,904(30)
	stfs 13,904(31)
	lfs 0,908(30)
	stw 0,912(31)
	stfs 0,908(31)
	b .L157
.L158:
	lwz 3,920(31)
	cmpwi 0,3,0
	bc 12,2,.L159
	bl G_FreeEdict
.L159:
	bl G_Spawn
	stw 3,920(31)
	lfs 0,896(30)
	stfs 0,896(3)
	lfs 0,900(30)
	lwz 9,920(31)
	stfs 0,900(9)
	lfs 0,904(30)
	lwz 11,920(31)
	stfs 0,904(11)
	lfs 0,908(30)
	lwz 9,920(31)
	stfs 0,908(9)
	lwz 0,284(30)
	andi. 9,0,1
	li 0,1
	bc 12,2,.L160
	li 0,0
.L160:
	stw 0,912(31)
	lfs 0,328(30)
	lis 9,.LC8@ha
	lis 10,Smooth_Fog_Think@ha
	lwz 11,920(31)
	la 10,Smooth_Fog_Think@l(10)
	lis 8,level+4@ha
	lfd 13,.LC8@l(9)
	lis 7,gi+72@ha
	stfs 0,328(11)
	lwz 9,920(31)
	stw 31,256(9)
	lwz 11,920(31)
	stw 10,436(11)
	lfs 0,level+4@l(8)
	lwz 9,920(31)
	fadd 0,0,13
	frsp 0,0
	stfs 0,428(9)
	lwz 0,gi+72@l(7)
	lwz 3,920(31)
	mtlr 0
	blrl
.L157:
	lwz 0,20(1)
	mtlr 0
	lmw 30,8(1)
	la 1,16(1)
	blr
.Lfe6:
	.size	 trigger_smooth_fog_touch,.Lfe6-trigger_smooth_fog_touch
	.ident	"GCC: (GNU) 2.95.2 19991024 (release)"
