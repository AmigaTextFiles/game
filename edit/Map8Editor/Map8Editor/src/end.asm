*
* This must be the last object to link.
* It defines the last address of the merged Data-Bss segment.
*
* BSSEnd
*


	section	__MERGED,bss


	cnop	0,4
	xdef	BSSEnd
BSSEnd:
