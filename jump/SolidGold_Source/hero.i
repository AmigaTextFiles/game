*
* Hero constants
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*


; width and height of hero image
HEROW		equ	16
HEROH		equ	22

; size of unmasked hero image in bytes
HEROSIZE	equ	(HEROW>>3)*HEROH*PLANES

; always try to align the xpos to a value where the masked bits are zero
HERO_ALIGNMASK	equ	3

; hero's speed, when running left or right
HEROSPEED	equ	2

; speed when climbing stairs
HEROCLIMBSPEED	equ	1

; collisions are deadly within this rectangle
LETHALX0	equ	1
LETHALY0	equ	1
LETHALX1	equ	HEROW-2
LETHALY1	equ	HEROH-1

; hero's feet have to be so many pixel higher than monster's to kill it
JMPKILLMINH	equ	2

; gravity
HEROGRAV_NORM	equ	7
HEROGRAV_BOUNCE	equ	-11
HEROGRAV_JUMP	equ	-21
HEROGRAV_SPRING	equ	-31
HEROGRAV_MAX	equ	16	; 4 pixels/frame is maximum vy

; switch to idle animation, when time has passed
HERO_IDLETIME	equ	300	; 6 seconds

; animations
MAXHEROSLOTS	equ	128	; type and image slots in the BMP image
MAXHEROANIMS	equ	64	; maximum number of used animation slots

; Hero_anim
HERO_IDLE	equ	45<<2
HERO_ANIMLEFT	equ	20<<2
HERO_ANIMRIGHT	equ	80<<2
HERO_STANDLEFT	equ	1<<2
HERO_STANDRIGHT	equ	62<<2
HERO_JUMPLEFT	equ	2<<2
HERO_JUMPRIGHT	equ	61<<2
HERO_CLIMBLEFT	equ	40<<2
HERO_CLIMBRIGHT	equ	100<<2
HERO_DFALLING	equ	25<<2
HERO_DDROWNING	equ	48<<2
HERO_DONE	equ	66<<2

; Hero_facing
FACING_LEFT	equ	0
FACING_MID	equ	2
FACING_RIGHT	equ	4

; Hero_climb
CLIMB_LEFT	equ	-1
CLIMB_NONE	equ	0
CLIMB_RIGHT	equ	1

; safety margin for tile collision checks in pixels
HCOLL_MARGIN	equ	2

; types of death
DEATH_FALLING	equ	2
DEATH_DROWNING	equ	4
