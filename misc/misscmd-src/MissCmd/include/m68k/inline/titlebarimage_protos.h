#ifndef _VBCCINLINE_TITLEBARIMAGE_H
#define _VBCCINLINE_TITLEBARIMAGE_H

#ifndef EXEC_TYPES_H
#include <exec/types.h>
#endif

Class * __ObtainTBIClass(__reg("a6") struct Library *)="\tjsr\t-30(a6)";
#define ObtainTBIClass() __ObtainTBIClass(TitlebarImageBase)

#endif /*  _VBCCINLINE_TITLEBARIMAGE_H  */
