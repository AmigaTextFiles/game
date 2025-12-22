VERSION = 0
REVISION = 9

.macro DATE
.ascii "1.11.2006"
.endm

.macro VERS
.ascii "MissCmd 0.9"
.endm

.macro VSTRING
.ascii "MissCmd 0.9 (1.11.2006)"
.byte 13,10,0
.endm

.macro VERSTAG
.byte 0
.ascii "$VER: MissCmd 0.9 (1.11.2006)"
.byte 0
.endm
