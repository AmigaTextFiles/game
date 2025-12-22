;***************************************************************
; Object-to-Background collision detection structure:
;***************************************************************

	rsreset
CBGD_MASK	rs.l	1	;collision enable mask
CBGD_AREA	rs.l	1	;collision area number
CBGD_X1	rs.w	1	;x coord to check
CBGD_Y1	rs.w	1	;y coord to check
CBGD_NEXT	rs.l	1	;ptr to next obj-to-bg collision struct
CBGD_SIZEOF	rs.b	0	;size of cbgd struct

;***************************************************************
; Object-to-Object collision detection structure:
;***************************************************************

	rsreset
COBJ_TYPE	rs.l	1	;type of collision area
COBJ_MASK	rs.l	1	;collision enable mask
COBJ_AREA	rs.l	1	;collision area number
COBJ_X1	rs.w	1	;left edge of area
COBJ_Y1	rs.w	1	;top edge of area
COBJ_X2	rs.w	1	;right edge of area
COBJ_Y2	rs.w	1	;bottom edge of area
COBJ_NEXT	rs.l	1	;ptr to next obj-to-obj collision struct
COBJ_SIZEOF	rs.b	0	;size of cobj struct

;******************************************************************************
; The blitter structure
;******************************************************************************

	rsreset
BLIT_DATA  rs.l     1         ;Address of data image to blit
BLIT_MASK  rs.l     1         ;Address of data mask
BLIT_SAVE  rs.l     1         ;Address of save area for saving background.
;                             ;0 = nosave (don't use BLIT_RESTORE!)
BLIT_DEPTH  rs.l    1         ;number of bit planes in image to blit to screen.
BLIT_PLANES rs.l    1         ;Defines which bit planes to draw into (like a
;                             ;BOB PlanePick).  1 = draw into appropriate
;                             ;bitplane.  ex.  00000101 = use planes 0 and 2.
BLIT_WIDTH  rs.l    1         ;Width of data image (in words)
BLIT_HEIGHT rs.l    1         ;Height of of data image (horizontal lines)
BLIT_IMG_SZ rs.l    1         ;Size (in bytes) of image (width * height)
BLIT_X_OFF  rs.l    1         ;X offset from left edge of image to be added
;                             ;to the X coordinate passed to "Blit_Image".
BLIT_Y_OFF  rs.l    1         ;Y offset from top edge of image to be added
;                             ;to the Y coordinate passed to "Blit_Image"
BLIT_FLAGS  rs.l    1         ;Flags (see below)
BLIT_COLL_BG rs.l   1         ;Pointer to collision detection list (null if no
;                             ;collision detection) for background gfx.
BLIT_COLLISION rs.l 1         ;Pointer to collision detection list (null if no
;                             ;collision detection) for anim obj area detect.
BLIT_PREV   rs.l    1         ;Ptr to previous image in an animation sequence
BLIT_NEXT   rs.l    1         ;Ptr to next image in an animation sequence
;*	-------------- RESERVED ------------------------
BLIT_ADDR	  rs.l	1	;Offset of blit from start (low byte) of screen
;			(returned).  For quick restore.
BLIT_MODULO rs.w	1	;Modulo (in bytes) for screen.  To find modulo,
;			take the number of bytes on your screen line,
;			and subtract the width (in bytes) of your image.
BLIT_SHIFT  rs.w	1	;Shift value of image.  Stored by blit_save_bg
;			so blit_image2 doesn't have to recompute it.
BLIT_SIZEOF rs.b    0         ;Size of blitter struct

* ---------------------------------------------------------------------------
*
* The blitter flags:
* -----------------

BLIT_MERGE	EQU	$01000000	;don't clear unaffected planes
BLIT_1SHOT_FORWARD	EQU	$02000000	;anim does not repeat when played forward
BLIT_1SHOT_BACKWARD	EQU	$04000000	;anim does not repeat when played backward
BLIT_DATACOPY	EQU	$08000000	;data is a copy area, don't free (internal use)
BLIT_CPUBLIT	EQU	$10000000	;use CPU to blit image instead of blitter

;***************************************************************
; Anim complex struct:
;***************************************************************

	rsreset
CPLX_CNT	rs.w	1	;number anim sequences in the complex
CPLX_SEQ	rs.w	1	;current anim sequence number (0 - n)
CPLX_WIDTH rs.w	1	;max width of complex (in bytes)
CPLX_HEIGHT rs.w	1	;max height of complex (scan lines)
CPLX_ARRAY_NUM rs.w	1	;array element number
CPLX_LABEL rs.w	1	;user label/ID
CPLX_LIST	rs.l	1	;ptr to list of anim sequences
CPLX_ANIM	rs.l	1	;ptr to current anim on screen
CPLX_SIZEOF	rs.b	0	;size of anim complex struct

;***************************************************************
; Anim struct:
;***************************************************************

	rsreset
ANIM_LIST	rs.l	1	;ptr to 1st image (blitter struct) in anim sequence
ANIM_IMG	rs.l	1	;ptr to current image on screen
ANIM_ATTACH rs.l	1	;ptr to next attached anim
ANIM_ARRAY_NUM rs.w	1	;ptr to array element number
ANIM_LABEL rs.w	1	;user label/ID
ANIM_COUNT rs.w	1	;number of images in the anim sequence
ANIM_X	rs.w	1	;current x coord of image on screen
ANIM_Y	rs.w	1	;current y coord of image on screen
ANIM_XA	rs.w	1	;attached anim X offset from parent
ANIM_YA	rs.w	1	;attached anim Y offste from parent
ANIM_WIDTH rs.w	1	;max width of image (in bytes)
ANIM_HEIGHT rs.w	1	;max height of image (scan lines)
ANIM_CELL	rs.w	1	;current cell number on screen (0 - n)
ANIM_PRIO	rs.w	1	;image display priority
ANIM_FLAGS rs.l	1	;flags (see below)
; ----------- INTERNAL USE --------------------------
ANIM_SHIFT1 rs.w	1	;save area for blitter shift value
ANIM_SHIFT2 rs.w	1	;save area for blitter shift value
ANIM_SAVE1 rs.l	1	;ptr to 1st background save area
ANIM_SAVE2 rs.l	1	;ptr to 2nd background save area
ANIM_OFFSET1 rs.l	1	;screen offset for save area 1
ANIM_OFFSET2 rs.l	1	;screen offset for save area 2
ANIM_SAVSIZ rs.l	1	;size of save area (in bytes)
ANIM_IMAGE1 rs.l	1	;ptr to image displayed in bitmap 1
ANIM_IMAGE2 rs.l	1	;ptr to image displayed in bitmap 2
ANIM_COLLIDE rs.l	1	;ptr to colliding anim
ANIM_PREV	rs.l	1	;ptr to previous anim in system
ANIM_NEXT	rs.l	1	;ptr to next anim in system
ANIM_CPLX_NEXT rs.l	1	;ptr to next anim obj in complex
ANIM_CPLX	rs.l	1	;ptr to parent anim complex (if any)
ANIM_SIZEOF	rs.b	0	;size of anim struct

* ---------------------------------------------------------------------------
*
* The anim flags:
* --------------

ANIM_SAVE_BG	EQU	$01000000	;Save background before blitting image to screen
ANIM_COLLISION	EQU	$02000000	;Object to object collision detection enable
ANIM_ACTIVE	EQU	$20000000	;Anim is active in a display system
ANIM_INVISIBLE	EQU	$40000000	;Anim not visible on screen
ANIM_ONSCREEN	EQU	$80000000	;Anim is displayed on screen
ANIM_CLEAR 	EQU	$00010000	;If NOT SAVE_BG, call blit_clear before calling
;				blit_image
ANIM_COPY		EQU	$00020000	;Use blit_copy instead of blit_image
ANIM_REVERSE	EQU	$00040000	;Anim is running in reverse
ANIM_PARENT	EQU	$00080000	;Anim is a parent with attached anims
ANIM_MERGE	EQU	$00100000	;Anim merges with existing graphics onscreen
ANIM_FLICKER	EQU	$00200000	;Image appears on bitmap 1 ONLY
ANIM_COLLISION_BG EQU	$00400000	;Object to background collision detection enable
ANIM_IMGCOPY	EQU	$00800000	;Anim is a copy, don't free it's images
ANIM_BOUNDS_X1	EQU	$00000100	;Anim obj tried to move past left edge
ANIM_BOUNDS_Y1	EQU	$00000200	;Anim obj tried to move past top edge
ANIM_BOUNDS_X2	EQU	$00000400	;Anim obj tried to move past right edge
ANIM_BOUNDS_Y2	EQU	$00000800	;Anim obj tried to move past bottom edge
ANIM_CPUBLIT	EQU	$00001000	;CPU used to blit images in this anim
ANIM_VSPACE	EQU	$00002000	;Object lies in virtual space
ANIM_VCOLLIDE	EQU	$00004000	;Allow object-to-object collisions in virtual space

;***************************************************************
; Anim attachment array specification
;***************************************************************

; undefined until next release

;***************************************************************
; Anim load struct
;***************************************************************

	rsreset
ALOAD_NAME	rs.l	1	;ptr to null terminated char string of file to load
ALOAD_ANIM	rs.l	1	;ptr to anim or complex obj after load
ALOAD_ATTACH	rs.l	1	;ptr to attachment array specification (filled)
ALOAD_CMAP	rs.l	1	;ptr to color map array (filled)
ALOAD_CMAP_ENTRIES	rs.l	1	;number of color map entries (filled)
ALOAD_CMAP_SIZE	rs.l	1	;number of bits per color value (4 or 8) (user defined
ALOAD_TYPE	rs.l	1	;type 0 = anim, 1 = complex (filled)
ALOAD_ELEMENTS	rs.l	1	;size of array to create (1 - n) (user defined)
ALOAD_FLAGS	rs.l	1	;load flags.  Set ONLY user bits, some used by CITAS

* ---------------------------------------------------------------------------
*
* The anim load flags:
* -------------------

ALOAD_NOCOLOR	EQU	$00000001	;don't load color table if one exists in file
ALOAD_FASTRAM	EQU	$00000002	;load anim to Fast RAM if available
ALOAD_NOFASTRAM	EQU	$00000004	;don't use Fast RAM even if flagged in file

* ---------------------------------------------------------------------------
*
* Save area allocation flags:
* --------------------------

SINGLE_BUFF  EQU 0x00  ;object will be used in a single buffered display
DOUBLE_BUFF  EQU 0x01  ;object will be used in a double buffered display
