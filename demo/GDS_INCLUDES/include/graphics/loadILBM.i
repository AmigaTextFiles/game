;***************************************************************
; The loadILBM struct
;***************************************************************

	rsreset
ILOAD_FILE     rs.l  1  ;ptr to null terminated string with file to load
ILOAD_BITMAP1  rs.l  1  ;ptr to 1st bitmap
ILOAD_BITMAP2  rs.l  1  ;ptr to 2nd bitmap (if any)
ILOAD_CTBL     rs.l  1  ;ptr to color table to be filled
ILOAD_COLORS   rs.l  1  ;number of entries in color table
ILOAD_DHEIGHT  rs.l  1  ;display height (filled from file)
ILOAD_DWIDTH   rs.l  1  ;display width (filled)
ILOAD_XOFF     rs.l  1  ;X display offset (filled)
ILOAD_YOFF     rs.l  1  ;Y display offset (filled)
ILOAD_MODES    rs.l  1  ;display modes (filled)
ILOAD_LOADX    rs.l  1  ;X load offset (from left) in bytes
ILOAD_LOADY    rs.l  1  ;Y load offset (from top) in rows
ILOAD_FLAGS    rs.l  1  ;load flags
ILOAD_FILL     rs.l  1  ;mask of planes to fill in bitmap(s)
ILOAD_SELECT   rs.l  1  ;mask of planes to use from file
ILOAD_BMH      rs.l  1  ;ptr to BitMapHeader struct to fill or NULL
ILOAD_SIZEOF   rs.b  0  ;size of loadILBM struct

; The BitMapHeader struct as defined by Commodore

	rsreset
BMH_W          rs.w  1  ;raster width in pixels
BMH_H          rs.w  1  ;raster height in pixels
BMH_X          rs.w  1  ;pixel X position (same as xoff)
BMH_Y          rs.w  1  ;pixel Y position (same as yoff)
BMH_PLANES     rs.b  1  ;number of bitplanes (without mask if any)
BMH_MASKING    rs.b  1  ;mask value (see CBM docs on ILBMs)
BMH_COMP       rs.b  1  ;compression algorithm used on image data
BMH_RSRV       rs.b  1  ;reserved; ignore on read, write as 0
BMH_TRANS      rs.w  1  ;transparent color number, usually 0 (background)
BMH_XASP       rs.b  1  ;X pixel aspect (ratio of width to height)
BMH_YASP       rs.b  1  ;Y pixel aspect
BMH_PAGEW      rs.w  1  ;source page width in pixels (same as dwidth)
BMH_PAGEH      rs.w  1  ;source page height in pixels (same as dheight)
BMH_SIZEOF     rs.b  1  ;size of BitMapHeader struct

* ---------------------------------------------------------------------------
*
* The loadILBM flags:
* ------------------

ILBM_COLOR	EQU	1	;fill color map with colors from file
ILBM_ALLOC	EQU	2	;allocate one bitmap before loading
ILBM_ALLOC2	EQU	4	;allocate two bitmaps before loading
