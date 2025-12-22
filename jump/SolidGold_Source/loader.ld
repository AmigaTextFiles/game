SECTIONS {
	. = 0x60000;  /* LOADERBASE */
	.text: { *(CODE) }
	.data: { *(DATA) }
	.sdata: {
		_LinkerDB = . + 0x7ffe;
		_SDA_BASE_ = . + 0x7ffe;
		*(.sdata __MERGED)
	}
	.bss: { *(BSS) }
}
