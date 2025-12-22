*
* Loader module definitions
*
* Written by Frank Wille in 2013.
*
* I, the copyright holder of this work, hereby release it into the
* public domain. This applies worldwide.
*

; loader base address (in Chip RAM)
LOADERBASE	equ	$60000

; display dimensions
DISPW		equ	320
DISPH		equ	152
BPR		equ	DISPW/8
PLANES		equ	4
NCOLORS		equ	1<<PLANES

; display window in raster coordinates (HSTART must be odd)
HSTART		equ	129
VSTART		equ	80
VEND		equ	VSTART+DISPH

; display data fetch start/stop
DFETCHSTART	equ	HSTART/2-8
DFETCHSTOP	equ	DFETCHSTART+8*((DISPW/16)-1)
