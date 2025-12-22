*
* MOB defintions.
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*


; MOB - describes a currently visible or invisible movable object
		rsreset
MOxpos		rs.w	1
MOypos		rs.w	1
MOheight	rs.w	1
MOwidth		rs.w	1	; width in 16-bit words
MOimage		rs.l	1
MOmask		rs.l	1
MObobv1		rs.l	1	; linked BOB in View1
MObobv2		rs.l	1	; linked BOB in View2
MOvisible	rs.b	1	; true, when currently visible
MOreserved	rs.b	1
sizeof_MOB	rs.b	0
