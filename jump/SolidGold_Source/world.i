*
* World definitions
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*

; Loading music volume (0-64)
LOADWORLD_VOL	equ	48


; File definitions for each world
		rsreset
WFworld		rs.b	1
WFpicture	rs.b	1
WFloadmod	rs.b	1
WFtypes		rs.b	1
WFtiles		rs.b	1
WFfg		rs.b	1
WFcopper	rs.b	1
WFmonstchar	rs.b	1
WFmonst16	rs.b	1
WFmonst20	rs.b	1
WFmod		rs.b	1
WFgetready	rs.b	1	; song position of Get Ready jingle
WFgameover	rs.b	1	; song position of Game Over jingle
WFleveldone	rs.b	1	; song position of Well Done jingle
WFlevelstats	rs.b	1	; song position for level statistics
WFsfxset	rs.b	1
sizeof_WF	rs.b	0

; A world's types file. Contains all kinds of tables for maps and tiles.
		rsreset
TTcolormap	rs.w	NCOLORS	; world's color map
TTtilestypes	rs.b	256	; background tiles types (unmasked, empty)
TTfgtypes	rs.b	256	; foreground blocks types (masked, empty)
TTfganimphases	rs.b	256	; number of animation phases for fg blocks
TTfganimspeed	rs.b	256	; animation speed in frames for fg blocks
TTmonst16types	rs.b	256	; monster16 image types (masked, empty)
TTmonst20types	rs.b	256	; monster20 image types (masked, empty)
TTsolidblocks	rs.b	256	; solid blocks table
TTbackgdblocks	rs.b	256	; background block types table
TTfgblktypes	rs.b	256	; foreground block types table
TTanimtypes	rs.b	256	; animated background tiles types table
TTanimphspd	rs.b	512	; anim bg tiles: number of phases and speed
				; For each type: 1 byte nPhase, 1 byte speed
sizeof_Types	rs.b	0
