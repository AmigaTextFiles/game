#include <exec/types.h>

extern __asm void c2p_6_040(register __a0 UBYTE *chunky,
							register __a1 void *raster,
							register __a2 UBYTE *compare_buffer,
							register __a4 UBYTE *xlate,
							register __d1 ULONG plsiz,
							register __d2 BOOL pal_change);

void c2p_6_040_kludge(UBYTE *chunky_data,
					  void *raster,
					  UBYTE *compare_buffer,
					  UBYTE *xlate,
					  ULONG plsiz,
					  BOOL pal_change) {

	c2p_6_040(chunky_data, raster, compare_buffer, xlate, plsiz, pal_change);

}
