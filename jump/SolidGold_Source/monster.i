*
* Monster constants
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*


; Maximum number of monsters in a map, MAXMONSTERS, is defined in map.i.

; number of different monster types in a world
MAXMONSTERTYPES	equ	11

; width and height of a monster image
MONSTW		equ	16
MONST16H	equ	16
MONST20H	equ	20

; size of unmasked monster image in bytes
MONST16SIZE	equ	(MONSTW>>3)*MONST16H*PLANES
MONST20SIZE	equ	(MONSTW>>3)*MONST20H*PLANES

; normal gravity on solid ground (vy)
MONSTGRAV_NORM	equ	7

; vy for leaps (MSTRAT_LEAP)
MONSTGRAV_LEAP	equ	-21

; monster jump preparation delay (MSTRAT_JMP)
MONSTJMP_DELAY	equ	20

; monster fall/return delays (MSTRAT_FALL)
MONSTFALL_DELAY	equ	30
MONSTRET_DELAY	equ	20

; flying height (MSTRAT_LRFRD)
MONSTFRD_HEIGHT	equ	24

; wait, before switching to prev. m.type when hero is invis. (MSTRAT_ARCH)
MONSTARCH_WAIT	equ	100	; 2 seconds

; maximum wizard-hero distance for starting a protection spell
MONSTWIZ_DISTX	equ	80
MONSTWIZ_DISTY	equ	80

; wizard vulnerability/invulnerability delays (MSTRAT_WIZ)
MONSTWIZ_VULN	equ	100	; vulnerable for 2 seconds after a spell
MONSTWIZ_SPELLS	equ	3	; cast the protection spell three times

; hardcoded spell preparation animation (not enough animation slots for it)
WIZANIM_START	equ	424*4	; first animation phase (monst20: 256+168)
WIZANIM_END	equ	425*4	; last animation phase (monst20: 256+169)
WIZANIM_FRAMES	equ	15	; number of frames for each animation phase

; monster is used as a spring-board for some time (MSTRAT_COV)
TMPBOUNCE_TIME	equ	150	; 3 seconds


; Monster type definitions.
MT_ANIMFRAMES	equ	39	; maximum animation frames for a movement

		rsreset
MTstrat		rs.w	1	; movement strategies
MTheight	rs.w	1	; monster height in pixels
MTspeed		rs.w	1	; movement speed
MTpoints	rs.w	1	; points when killed
MTcollx0	rs.w	1	; collision rectangle left
MTcolly0	rs.w	1	; collision rectangle top
MTcollx1	rs.w	1	; collision rectangle right
MTcolly1	rs.w	1	; collision rectangle bottom
MTktype		rs.w	1	; type of animation to show when killed
MTksound	rs.w	1	; sound to play when killed
MTleftframes	rs.w	1	; number of move-left anim frames
MTleftanim	rs.w	MT_ANIMFRAMES
MTrightframes	rs.w	1	; number of move-right anim frames
MTrightanim	rs.w	MT_ANIMFRAMES
MTlkillframes	rs.w	1	; number of killed-left anim frames
MTlkillanim	rs.w	MT_ANIMFRAMES
MTrkillframes	rs.w	1	; number of killed-right anim frames
MTrkillanim	rs.w	MT_ANIMFRAMES
sizeof_MT	rs.b	0

; movement strategies
MSTRAT_NONE	equ	0	; no movement, only animation
MSTRAT_LR	equ	2	; move left/right, fall from platforms
MSTRAT_LRP	equ	4	; move left/right, stay on a platform
MSTRAT_LRF	equ	6	; fly left/right on sinus wave, turn at obst.
MSTRAT_JMP	equ	8	; jump, fall back to base position
MSTRAT_UDBLK	equ	10	; move up/down within a block
MSTRAT_FALL	equ	12	; falling down, then move back to base pos
MSTRAT_DROP	equ	14	; drop down, then start again at base pos
MSTRAT_LRPRNM	equ	16	; like LRP, randomly switch to next m.type
MSTRAT_LRFRD	equ	18	; like LRF, randomly descend and switch m.type
MSTRAT_SHT	equ	20	; shoot, restart after hitting an obstacle
MSTRAT_LEAP	equ	22	; randomly leap forward
MSTRAT_COV	equ	24	; protects itself, can be used for jumping
MSTRAT_UD	equ	26	; move/fly up/down, turn at obstacle
MSTRAT_LRPYNM	equ	28	; like LRP, switch to next m. when same h.ypos
MSTRAT_ARCH	equ	30	; aim at h., switch to prev. when h.ypos diff.
MSTRAT_MIS	equ	32	; flies horiz., killed on hitting an obstacle
MSTRAT_HOR	equ	34	; fly left/right, turn at obstacle
MSTRAT_WIZ	equ	36	; like LRP, magic protection when hero is near

; killing animation types
MKILL_NONE	equ	2	; no animation, just disappear
MKILL_DROP	equ	4	; squash animation and drop dead
MKILL_FALL	equ	8	; fall out of the screen
MKILL_VANISH	equ	12	; vanishing animation
MKILL_RVANISH	equ	14	; like above, but always use MTrkillanim
