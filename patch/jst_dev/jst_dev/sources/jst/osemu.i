	IFND	OSEMU_I_INCLUDED
OSEMU_I_INCLUDED	=	1

	MC68000


; ** OSEmu configuration structure offsets

OSM_SLVTRAINER	= 4
OSM_LASTLOADSEG	= 8
OSM_ID		= 12
OSM_VER		= 16
OSM_RELEASE	= 18
OSM_COPPERADDR	= 20
OSM_ICONIFYCODE	= 24
OSM_ICONIFYKEY	= 28
OSM_JSTFLAGS	= 32	; this and all this above for OSEmu v1.0
OSM_EXPMEM	= 36
OSM_EXPSIZE	= 40	; this and all this above for OSEmu v1.3
OSM_DEBUGENTRY  = 44    ; this and all this above for OSEmu v1.4

	ENDC
