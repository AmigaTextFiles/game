extern void c2p_8_040 (UBYTE *chunky_data    __asm("a0"),
					   PLANEPTR raster       __asm("a1"),
					   UBYTE *compare_buffer __asm("a2"),
					   ULONG plsiz           __asm("d1"));

extern void       c2p_6_040 ( UBYTE *chunky_data         __asm("a0"),
					   PLANEPTR raster            __asm("a1"),
					   UBYTE *compare_buffer      __asm("a2"),
					   UBYTE *xlate               __asm("a4"),
					   ULONG plsiz                __asm("d1"),
					   BOOL video_palette_changed __asm("d2"));
