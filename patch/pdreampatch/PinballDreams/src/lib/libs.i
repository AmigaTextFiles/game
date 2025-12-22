
	include	"exec/types.i"
	include	"exec/macros.i"
	include	"exec/memory.i"
	include	"exec/libraries.i"
	include	"exec/execbase.i"

	include "dos/dos.i"
	include	"hardware/custom.i"
	include	"hardware/intbits.i"
	include	"graphics/gfxbase.i"


STD_DISK_SIZE = 901120	; standard dos copiable disks
B12_DISK_SIZE = 970752	; 12 sectored 79 tracks disks, dos bootblock
S12_DISK_SIZE = 983040	; 12 sectored 79 tracks disks, dos bootblock

	MACHINE	68000
