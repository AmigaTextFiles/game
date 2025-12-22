;***************************************************************
; The Rectangle struct (same as Commodore's Rectangle struct)
;***************************************************************

	rsreset
GSRECT_MINX rs.w  1  ;left edge of rectangle
GSRECT_MINY rs.w  1  ;top edge of rectangle
GSRECT_MAXX rs.w  1  ;right edge of rectangle
GSRECT_MAXY rs.w  1  ;bottom edge of rectangle
GSRECT_SIZEOF rs.b  0

;***************************************************************
; The gs_viewport struct
;***************************************************************

	rsreset
GSVP_NEXT      rs.l  1  ;ptr to next viewport in display
GSVP_COLORTBL  rs.l  1  ;ptr to color talbe for viewport
GSVP_COLORS    rs.l  1  ;number of color table entries
GSVP_UCOP      rs.l  1  ;ptr to user copper list struct (or NULL if none)
GSVP_HEIGHT    rs.l  1  ;height of viewport in scan lines
GSVP_WIDTH     rs.l  1  ;width of viewport in pixels
GSVP_DEPTH     rs.l  1  ;number of bitplanes to use for viewport
GSVP_BMHEIGHT  rs.l  1  ;bitmap height (in rows) (used only if allocating bitmap)
GSVP_BMWIDTH   rs.l  1  ;bitmap width (in pixels) (used only if allocating bitmap)
GSVP_TOP       rs.l  1  ;viewport Y offset (in rows) from display start
GSVP_LEFT      rs.l  1  ;viewport X offset (in pixels) from display start
GSVP_XOFF      rs.l  1  ;X offset within bitmap (in pixels)
GSVP_YOFF      rs.l  1  ;Y offset within bitmap (in pixels)
GSVP_FLAGS     rs.l  1  ;flags for display routines
GSVP_VPE1      rs.l  1  ;ptr to 2.xx & up ViewPortExtra struct (SYSTEM USE)
GSVP_VPE2      rs.l  1  ;ptr to 2.xx & up ViewPortExtra struct (SYSTEM USE)
GSVP_BITMAP1   rs.l  1  ;ptr to 1st bitmap struct
GSVP_BITMAP2   rs.l  1  ;ptr to 2nd bitmap struct
GSVP_EXTEND    rs.l  1  ;reserved for future expansion
GSVP_DCLIP     rs.b  GSRECT_SIZEOF  ;display clip for 2.xx & up displays
; remainder is for GDS system use ONLY!!
GSVP_VIEWPORT1 rs.l  1  ;ptr to system ViewPort struct for 1st display page
GSVP_VIEWPORT2 rs.l  1  ;ptr to system ViewPort struct for 2nd display page
GSVP_RASINFO1  rs.l  1  ;ptr to system RasInfo struct for 1st display page
GSVP_RASINFO2  rs.l  1  ;ptr to system RasInfo struct for 2nd display page
GSVP_LOF_BPLCON1 rs.l 1 ;offset to horizontal shift register copper instruction
GSVP_LOF_BPLPTR1 rs.l 1 ;offset to 1st bitplane pointer copper instruction
GSVP_SHF_BPLCON1 rs.l 1 ;offset to horizontal shift register copper instruction
GSVP_SHF_BPLPTR1 rs.l 1 ;offset to 1st bitplane pointer copper instruction
GSVP_LOF_BPLCON2 rs.l 1 ;offset to horizontal shift register copper instruction
GSVP_LOF_BPLPTR2 rs.l 1 ;offset to 1st bitplane pointer copper instruction
GSVP_SHF_BPLCON2 rs.l 1 ;offset to horizontal shift register copper instruction
GSVP_SHF_BPLPTR2 rs.l 1 ;offset to 1st bitplane pointer copper instruction
GSVP_pf1scroll rs.w  1  ;horizontal scroll value, playfield 1
GSVP_pf2scroll rs.w  1  ;horizontal scroll value, playfield 2
GSVP_XOFF2     rs.l  1  ;playfield 2 X offset within bitmap
GSVP_YOFF2     rs.l  1  ;playfield 2 Y offset within bitmap
GSVP_LOF_COP1  rs.w  1  ;offset to viewport copper list within display list
GSVP_SHF_COP1  rs.w  1
GSVP_LOF_COP2  rs.w  1
GSVP_SHF_COP2  rs.w  1
GSVP_LOF_PLANES1 rs.l 8 ;bitplane pointers
GSVP_SHF_PLANES1 rs.l 8
GSVP_LOF_PLANES2 rs.l 8
GSVP_SHF_PLANES2 rs.l 8
GSVP_SIZEOF    rs.l  0

; gs_viewport flags:

GSVPF_ALLOCBM  EQU   $01   ;let the display setup routine allocate bitmap(s)
GSVPF_DCLIP    EQU   $02   ;user specified display clip
GSVPF_DPF      EQU   $04   ;set viewport to operate in dual playfield mode

;***************************************************************
; The display struct
;***************************************************************

	rsreset
GSV_OLDVIEW    rs.l  1  ;ptr to previous display view
GSV_VE1        rs.l  1  ;2.xx & up ViewExtra struct (ptr to)
GSV_VE2        rs.l  1  ;2.xx & up ViewExtra struct (ptr to)
GSV_DXOFFSET   rs.l  1  ;display X offset (in pixels) for 1.3 OS
GSV_DYOFFSET   rs.l  1  ;display Y offset (in rows) for 1.3 OS
GSV_MODES      rs.l  1  ;display mode ID
GSV_FLAGS      rs.l  1  ;flags for display routines
GSV_VIEWPORT   rs.l  1  ;ptr to 1st gs_viewport in display
GSV_EXTEND     rs.l  1  ;reserved for future expansion
; remainder is for GDS system use ONLY
GSV_VIEW1      rs.l  1  ;ptr to system View struct for 1st display page
GSV_VIEW2      rs.l  1  ;ptr to system View struct for 2nd display page
GSV_LOF_COP1   rs.l  1  ;ptr to long frame hardware copper list for view 1
GSV_SHF_COP1   rs.l  1  ;ptr to short frame hardware copper list for view 1
GSV_LOF_COP2   rs.l  1  ;ptr to long frame hardware copper list for view 2
GSV_SHF_COP2   rs.l  1  ;ptr to short frame hardware copper list for view 2
GSV_SIZEOF     rs.b  0  ;size of display struct

; display flags:

GSVF_DOUBLE    EQU   $0001    ;double buffered display
GSVF_PAGE1     EQU   $0002    ;SYSTEM FLAG: page 1 currently display
GSVF_EASY      EQU   $0004    ;SYSTEM FLAG: display set up through easy call
GSVF_DISPLAYED EQU   $0008    ;SYSTEM FLAG: custom display has been shown on screen
GSVF_FLIP      EQU   $0010    ;set by gs_flip_display & cleared when new page shown
GSVF_SCROLL1   EQU   $0020    ;SYSTEM FLAG: reload copper list with new scroll values
GSVF_SCROLL2   EQU   $0040    ;SYSTEM FLAG: reload copper list with new scroll values
GSVF_ECSENA    EQU   $0080    ;SYSTEM FLAG: used by AGA chipset scroll handling
GSVF_BPAGEM    EQU   $0100    ;SYSTEM FLAG: (ditto)
GSVF_AGA_SCROLL EQU  $0200    ;SYSTEM FLAG: use enhanced GA scrolling methods
GSVF_SUPER     EQU   $0400    ;SYSTEM FLAG: used by AGA chipset scroll handling
GSVF_SCROLLABLE EQU  $0800    ;allow view to be scrolled
GSVF_DDFADJUST EQU   $1000    ;display system adjusted data fetch for smooth scrolling

; return values for gs_scroll_vp:

GSVP_PF1_LEFT      EQU   $01   ;display at leftmost edge
GSVP_PF1_RIGHT     EQU   $02   ;display at rightmost edge
GSVP_PF1_TOP       EQU   $04   ;display at topmost edge
GSVP_PF1_BOTTOM    EQU   $08   ;display at bottom most edge
GSVP_PF2_LEFT      EQU   $10   ;display at leftmost edge
GSVP_PF2_RIGHT     EQU   $20   ;display at rightmost edge
GSVP_PF2_TOP       EQU   $40   ;display at topmost edge
GSVP_PF2_BOTTOM    EQU   $80   ;display at bottom most edge
GSVP_NOVP      EQU   -1    ;invalid viewport specified

