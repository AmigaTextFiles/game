/*
 * data.c V1.1
 *
 * global data
 *
 * (c) 1992-1993 Holger Brunst
 */

#include <CClock.h>

/* Global data */
struct MsgPort  *IDCMPPort;
struct Screen   *Screen;
APTR			*ScreenVI;
UpdateWinFunc   *UpdateWindow = NULL;

struct TextAttr GrntAttr = {
	(STRPTR) "garnet.font",
	9,
	FS_NORMAL,
	FS_NORMAL };
