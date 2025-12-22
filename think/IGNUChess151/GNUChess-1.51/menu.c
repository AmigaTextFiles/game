/************************************************************************/
/* Menu definitions														*/
/************************************************************************/

#include <intuition/intuition.h>

#include <libraries/gadtools.h>

#include "global.h"

struct NewMenu NM[] = {
	{ NM_TITLE, "Project"		, NULL, 0, 0, NULL },
	{ NM_ITEM , "About"			, NULL, 0, 0, NULL },
	{ NM_ITEM , "New game"		, NULL, 0, 0, NULL },
	{ NM_ITEM , "Get game"		, "O" , 0, 0, NULL },
	{ NM_ITEM , "Save game"		, "S" , 0, 0, NULL },
	{ NM_ITEM , "Save extended"	, NULL, 0, 0, NULL },
	{ NM_ITEM , "List game"		, NULL, 0, 0, NULL },
	{ NM_ITEM , "Quit"			, "Q" , 0, 0, NULL },

	{ NM_TITLE, "Edit"			, NULL, 0, 0, NULL },
	{ NM_ITEM , "Edit board"	, NULL, 0, 0, NULL },
	{ NM_ITEM , "Game data"		, NULL, 0, 0, NULL },
	{ NM_ITEM , "Force move"	, NULL, 0, 0, NULL },

	{ NM_TITLE, "Game"			, NULL, 0, 0, NULL },
	{ NM_ITEM , "Undo"			, NULL, 0, 0, NULL },
	{ NM_ITEM , "Remove"		, NULL, 0, 0, NULL },
	{ NM_ITEM , "Hint"			, NULL, 0, 0, NULL },
	{ NM_ITEM , "Switch sides"	, NULL, 0, 0, NULL },
	{ NM_ITEM , "Computer white", NULL, CHECKIT				, ~0x1F, NULL },
	{ NM_ITEM , "Computer black", NULL, CHECKIT | CHECKED	, ~0x2F, NULL },
	{ NM_ITEM , "Computer both"	, NULL, CHECKIT				, ~0x4F, NULL },
	{ NM_ITEM , NM_BARLABEL		, NULL, 0, 0, NULL },
	{ NM_ITEM , "Reset Vars"    , NULL, 0, 0, NULL },

	{ NM_TITLE, "Level", NULL, 0, 0, NULL },
	{ NM_ITEM , "60 moves in   5 minutes" , NULL, CHECKIT			, ~0x001, NULL },
	{ NM_ITEM , "60 moves in  15 minutes" , NULL, CHECKIT			, ~0x002, NULL },
	{ NM_ITEM , "60 moves in  30 minutes" , NULL, CHECKIT | CHECKED	, ~0x004, NULL },
	{ NM_ITEM , "40 moves in  30 minutes" , NULL, CHECKIT			, ~0x008, NULL },
	{ NM_ITEM , "40 moves in  60 minutes" , NULL, CHECKIT			, ~0x010, NULL },
	{ NM_ITEM , "40 moves in 120 minutes" , NULL, CHECKIT			, ~0x020, NULL },
	{ NM_ITEM , "40 moves in 240 minutes" , NULL, CHECKIT			, ~0x040, NULL },
	{ NM_ITEM , " 1 move  in  15 minutes" , NULL, CHECKIT			, ~0x080, NULL },
	{ NM_ITEM , " 1 move  in  60 minutes" , NULL, CHECKIT			, ~0x100, NULL },
	{ NM_ITEM , " 1 move  in 600 minutes" , NULL, CHECKIT			, ~0x200, NULL },

	{ NM_TITLE, "Properties", NULL, 0, 0, NULL },
	{ NM_ITEM , "Hash"			, NULL, CHECKIT | MENUTOGGLE | CHECKED,	0, NULL },
	{ NM_ITEM , "Book"			, NULL, CHECKIT | MENUTOGGLE | CHECKED,	0, NULL },
	{ NM_ITEM , "Beep"			, NULL, CHECKIT | MENUTOGGLE | CHECKED,	0, NULL },
	{ NM_ITEM , "Post"			, NULL, CHECKIT | MENUTOGGLE,			0, NULL },
	{ NM_ITEM , "Reverse"		, NULL, CHECKIT | MENUTOGGLE,			0, NULL },
	{ NM_ITEM , "Random"		, NULL, CHECKIT | MENUTOGGLE,			0, NULL },

	{ NM_TITLE, "Debug", NULL, 0, 0, NULL },
	{ NM_ITEM , "Change alpha window"	, NULL, 0, 0, NULL },
	{ NM_ITEM , "Change beta  window"	, NULL, 0, 0, NULL },
	{ NM_ITEM , "Search depth"			, NULL, 0, 0, NULL },
	{ NM_ITEM , "Contempt"				, NULL, 0, 0, NULL },
	{ NM_ITEM , "Change X window"		, NULL, 0, 0, NULL },
	{ NM_ITEM , "Test"					, NULL, 0, 0, NULL },
	{ NM_ITEM , "Show position values"	, NULL, 0, 0, NULL },
	{ NM_ITEM , "Debug"					, NULL, 0, 0, NULL },

	{ NM_END  , NULL, NULL, 0, 0, NULL }
};

struct Menu *Menu;
