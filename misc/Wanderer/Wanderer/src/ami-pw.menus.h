
struct IntuiText IText1 = {
	3,1,COMPLEMENT,
	0,0,
	NULL,
	"Instructions        HELP",
	NULL
};

struct MenuItem MenuItem5 = {
	NULL,
	0,36,
	192,8,
	ITEMTEXT+ITEMENABLED+HIGHCOMP,
	0,
	(APTR)&IText1,
	NULL,
	NULL,
	NULL,
	MENUNULL
};

struct IntuiText IText2 = {
	3,1,COMPLEMENT,
	0,0,
	NULL,
	"Show map            F10",
	NULL
};

struct MenuItem MenuItem4 = {
	&MenuItem5,
	0,27,
	192,8,
	ITEMTEXT+ITEMENABLED+HIGHCOMP,
	0,
	(APTR)&IText2,
	NULL,
	NULL,
	NULL,
	MENUNULL
};

struct IntuiText IText3 = {
	3,1,COMPLEMENT,
	0,0,
	NULL,
	"Move to center      F3",
	NULL
};

struct MenuItem MenuItem3 = {
	&MenuItem4,
	0,18,
	192,8,
	ITEMTEXT+ITEMENABLED+HIGHCOMP,
	0,
	(APTR)&IText3,
	NULL,
	NULL,
	NULL,
	MENUNULL
};

struct IntuiText IText4 = {
	3,1,COMPLEMENT,
	0,0,
	NULL,
	"Toggle map mode     F2",
	NULL
};

struct MenuItem MenuItem2 = {
	&MenuItem3,
	0,9,
	192,8,
	ITEMTEXT+ITEMENABLED+HIGHCOMP,
	0,
	(APTR)&IText4,
	NULL,
	NULL,
	NULL,
	MENUNULL
};

struct IntuiText IText5 = {
	3,1,COMPLEMENT,
	0,0,
	NULL,
	"Jump to next level  F1",
	NULL
};

struct MenuItem MenuItem1 = {
	&MenuItem2,
	0,0,
	192,8,
	ITEMTEXT+ITEMENABLED+HIGHCOMP,
	0,
	(APTR)&IText5,
	NULL,
	NULL,
	NULL,
	MENUNULL
};

struct Menu Menu2 = {
	NULL,
	82,0,
	66,0,
	MENUENABLED,
	"Wander",
	&MenuItem1
};

struct IntuiText IText6 = {
	3,1,COMPLEMENT,
	0,0,
	NULL,
	"Quit Game       q",
	NULL
};

struct MenuItem MenuItem11 = {
	NULL,
	0,45,
	176,8,
	ITEMTEXT+ITEMENABLED+HIGHCOMP,
	0,
	(APTR)&IText6,
	NULL,
	NULL,
	NULL,
	MENUNULL
};

struct IntuiText IText7 = {
	3,1,COMPLEMENT,
	0,0,
	NULL,
	"Credits         c",
	NULL
};

struct MenuItem MenuItem10 = {
	&MenuItem11,
	0,36,
	176,8,
	ITEMTEXT+ITEMENABLED+HIGHCOMP,
	0,
	(APTR)&IText7,
	NULL,
	NULL,
	NULL,
	MENUNULL
};

struct IntuiText IText8 = {
	3,1,JAM1,
	0,0,
	NULL,
	"",
	NULL
};

struct MenuItem SubItem6 = {
	NULL,
	161,32,
	416,8,
	ITEMTEXT+ITEMENABLED+HIGHCOMP+HIGHBOX,
	0,
	(APTR)&IText8,
	NULL,
	NULL,
	NULL,
	MENUNULL
};

struct IntuiText IText9 = {
	9,1,JAM1,
	0,0,
	NULL,
	"Edit an existing screen:  wanderer -e screenfilename",
	NULL
};

struct MenuItem SubItem5 = {
	&SubItem6,
	161,24,
	416,8,
	ITEMTEXT+ITEMENABLED+HIGHCOMP+HIGHBOX,
	0,
	(APTR)&IText9,
	NULL,
	NULL,
	NULL,
	MENUNULL
};

struct IntuiText IText10 = {
	9,1,JAM1,
	0,0,
	NULL,
	"    Create a new screen:  wanderer -e",
	NULL
};

struct MenuItem SubItem4 = {
	&SubItem5,
	161,16,
	416,8,
	ITEMTEXT+ITEMENABLED+HIGHCOMP+HIGHBOX,
	0,
	(APTR)&IText10,
	NULL,
	NULL,
	NULL,
	MENUNULL
};

struct IntuiText IText11 = {
	3,1,JAM1,
	0,0,
	NULL,
	"",
	NULL
};

struct MenuItem SubItem3 = {
	&SubItem4,
	161,8,
	416,8,
	ITEMTEXT+ITEMENABLED+HIGHCOMP+HIGHBOX,
	0,
	(APTR)&IText11,
	NULL,
	NULL,
	NULL,
	MENUNULL
};

struct IntuiText IText12 = {
	3,1,JAM1,
	0,0,
	NULL,
	"from the CLI as follows:",
	NULL
};

struct MenuItem SubItem2 = {
	&SubItem3,
	161,0,
	416,8,
	ITEMTEXT+ITEMENABLED+HIGHCOMP+HIGHBOX,
	0,
	(APTR)&IText12,
	NULL,
	NULL,
	NULL,
	MENUNULL
};

struct IntuiText IText13 = {
	3,1,JAM1,
	0,0,
	NULL,
	"To edit a screen, exit the game and run wanderer",
	NULL
};

struct MenuItem SubItem1 = {
	&SubItem2,
	161,-8,
	416,8,
	ITEMTEXT+ITEMENABLED+HIGHCOMP+HIGHBOX,
	0,
	(APTR)&IText13,
	NULL,
	NULL,
	NULL,
	MENUNULL
};

struct IntuiText IText14 = {
	3,1,COMPLEMENT,
	0,0,
	NULL,
	"Edit Screen",
	NULL
};

struct MenuItem MenuItem9 = {
	&MenuItem10,
	0,27,
	176,8,
	ITEMTEXT+ITEMENABLED+HIGHCOMP,
	0,
	(APTR)&IText14,
	NULL,
	NULL,
	&SubItem1,
	MENUNULL
};

struct IntuiText IText15 = {
	3,1,COMPLEMENT,
	0,0,
	NULL,
	"Restore Game    F7",
	NULL
};

struct MenuItem MenuItem8 = {
	&MenuItem9,
	0,18,
	176,8,
	ITEMTEXT+ITEMENABLED+HIGHCOMP,
	0,
	(APTR)&IText15,
	NULL,
	NULL,
	NULL,
	MENUNULL
};

struct IntuiText IText16 = {
	3,1,COMPLEMENT,
	0,0,
	NULL,
	"Save Game       F6",
	NULL
};

struct MenuItem MenuItem7 = {
	&MenuItem8,
	0,9,
	176,8,
	ITEMTEXT+ITEMENABLED+HIGHCOMP,
	0,
	(APTR)&IText16,
	NULL,
	NULL,
	NULL,
	MENUNULL
};

struct IntuiText IText17 = {
	3,1,COMPLEMENT,
	0,0,
	NULL,
	"Redraw Screen  shift-W",
	NULL
};

struct MenuItem MenuItem6 = {
	&MenuItem7,
	0,0,
	176,8,
	ITEMTEXT+ITEMENABLED+HIGHCOMP,
	0,
	(APTR)&IText17,
	NULL,
	NULL,
	NULL,
	MENUNULL
};

struct Menu Menu1 = {
	&Menu2,
	0,0,
	75,0,
	MENUENABLED,
	"Project",
	&MenuItem6
};

#define MenuList1 Menu1
