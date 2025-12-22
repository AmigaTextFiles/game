/* created by MUIBuilder, using TA.MUIB */

#include <libraries/mui.h>
#include <libraries/gadtools.h>
#include <proto/muimaster.h>
#include <clib/exec_protos.h>
#include <exec/memory.h>
#include <clib/alib_protos.h>

struct ObjApp
{
	APTR	App;
	APTR	WINDOW;
	APTR	GRP_PAGES;
	APTR	TX_STATUS;
	APTR	GRP_PLAYER;
	APTR	CY_PLAYER;
	APTR	STR_LIVES;
	APTR	STR_MONEY;
	APTR	GRP_LS;
	APTR	GA_STATUS;
	char *	STR_TX_TITLE;
	char *	STR_TX_STATUS;
	char *	STR_GRP_PAGES[4];
	char *	CY_PLAYERContent[3];
};

#define ID_ABOUT 1
#define ID_ABOUT_MUI 2
#define ID_PLAYER 3
#define ID_LIVES 4
#define ID_MONEY 5
#define ID_LOAD 6
#define ID_SAVE 7
#define ID_PAGES 8

extern struct ObjApp * CreateApp(void);
extern void DisposeApp(struct ObjApp *);
