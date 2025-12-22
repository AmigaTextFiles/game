/* Load.h - Protos for Load.c v0.1 */

#ifndef LOAD_H
#define LOAD_H

#include <exec/types.h>
// Error constants
enum {FILEERROR=1,SCREENERROR,WINERROR,ALLOCERROR,TIMERERROR,LUCYERROR,BREAKERROR,CTRLC};

BOOL LoadGfx(void);
BOOL LoadPalette(STRPTR name, ULONG palette[770]);

#endif
