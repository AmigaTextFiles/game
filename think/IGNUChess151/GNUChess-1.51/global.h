#ifndef GLOBAL_H
#define GLOBAL_H

/* _B und _C in ctype.h, werden aber nicht gebraucht */

#ifdef _B
#	undef _B
#endif

#ifdef _C
#	undef _C
#endif

#define _A	0
#define _B	1
#define _C	2
#define _D	3
#define _E	4
#define _F	5
#define _G	6
#define _H	7

#define _1	0
#define _2	1
#define _3	2
#define _4	3
#define _5	4
#define _6	5
#define _7	6
#define _8	7

#define COLOR_BCK		0
#define COLOR_RAHMEN	1
#define COLOR_WFIG		2
#define COLOR_REQBAR	3
#define COLOR_EMPTY		4
#define COLOR_SFIG		5
#define COLOR_WFELD		6
#define COLOR_SFELD		7
#define COLOR_MENUBCK	8
#define COLOR_BLOCK		9
#define COLOR_TXTBCK	10
#define COLOR_TXTFGR	11
#define COLOR_REQBCK	12
#define COLOR_MARK		13
#define COLOR_FMARK		14

extern APTR					vi;
extern struct Window		*w;
extern struct RastPort		*rp;
extern struct TextAttr		TA_Times18;
extern struct TextAttr		TA_Courier15;
extern struct NewMenu		NM[];
extern struct Menu			*Menu;
extern struct Gadget		*EdB_GL;
extern struct Gadget		*EdB_GL2;
extern struct Gadget		*Req_GL;
extern struct Gadget		*Gad[];
extern struct Image			Req1Image;
extern struct FileRequester	*freq;

#define ZF_SCHACH	0x00000001
#define ZF_MATT		0x00000002
#define ZF_WWIN		0x00000004
#define ZF_SWIN		0x00000008
#define ZF_EP		0x00000010
#define ZF_CONVT	0x00000020
#define ZF_CONVS	0x00000040
#define ZF_CONVL	0x00000080
#define ZF_CONVD	0x00000100
#define ZF_WMOVE	0x00000200

extern void ResetGfx(void);
extern void DrawFeld(int, int, int);
extern void InitNotation(void);
extern void About(void);
extern void PartieData(void);
extern void InitGads(void);
extern void FreeGads(void);
extern void SaveData(int);
extern void LoadData(void);
extern int  MFeld(struct IntuiMessage *, int *);
extern void	XField(int, int);
extern int	NumberRequest(char *, int);
extern char	*StringRequest(char *, char *);

#define MarkField(F)	XField((F),COLOR_FMARK)
#define UnMarkField(F)	XField((F),COLOR_RAHMEN)

#define STRSIZE	85

#define WHITE	0
#define BLACK	1

extern char	Player1[], Player2[], Turnier[], Opening[], Notiz[];

#define NTXT_ANZAHL	10
#define NTXT_BREITE	30
#define NTXT_HEIGHT	11

extern char Notation[NTXT_ANZAHL][NTXT_BREITE];

#define PROJECT_ABOUT		FULLMENUNUM(0, 0, 0x1F)
#define PROJECT_NEWGAME		FULLMENUNUM(0, 1, 0x1F)
#define PROJECT_GETGAME		FULLMENUNUM(0, 2, 0x1F)
#define PROJECT_SAVEGAME	FULLMENUNUM(0, 3, 0x1F)
#define PROJECT_SAVEEXT		FULLMENUNUM(0, 4, 0x1F)
#define PROJECT_LISTGAME	FULLMENUNUM(0, 5, 0x1F)
#define PROJECT_QUIT		FULLMENUNUM(0, 6, 0x1F)

#define EDIT_EDITBOARD		FULLMENUNUM(1, 0, 0x1F)
#define EDIT_GAMEDATA		FULLMENUNUM(1, 1, 0x1F)
#define EDIT_FORCE			FULLMENUNUM(1, 2, 0x1F)

#define GAME_UNDO			FULLMENUNUM(2, 0, 0x1F)
#define GAME_REMOVE			FULLMENUNUM(2, 1, 0x1F)
#define GAME_HINT			FULLMENUNUM(2, 2, 0x1F)
#define GAME_SWITCHSIDES	FULLMENUNUM(2, 3, 0x1F)
#define GAME_COMPUTERWHITE	FULLMENUNUM(2, 4, 0x1F)
#define GAME_COMPUTERBLACK	FULLMENUNUM(2, 5, 0x1F)
#define GAME_COMPUTERBOTH	FULLMENUNUM(2, 6, 0x1F)
#define GAME_DUMMY1
#define GAME_RESETVARS		FULLMENUNUM(2, 8, 0x1F)

#define LEVEL_60_IN_005		FULLMENUNUM(3, 0, 0x1F)
#define LEVEL_60_IN_015		FULLMENUNUM(3, 1, 0x1F)
#define LEVEL_60_IN_030		FULLMENUNUM(3, 2, 0x1F)
#define LEVEL_40_IN_030		FULLMENUNUM(3, 3, 0x1F)
#define LEVEL_40_IN_060		FULLMENUNUM(3, 4, 0x1F)
#define LEVEL_40_IN_120		FULLMENUNUM(3, 5, 0x1F)
#define LEVEL_40_IN_240		FULLMENUNUM(3, 6, 0x1F)
#define LEVEL_01_IN_015		FULLMENUNUM(3, 7, 0x1F)
#define LEVEL_01_IN_060		FULLMENUNUM(3, 8, 0x1F)
#define LEVEL_01_IN_600		FULLMENUNUM(3, 9, 0x1F)

#define PROPERTIES_HASH		FULLMENUNUM(4, 0, 0x1F)
#define PROPERTIES_BOOK		FULLMENUNUM(4, 1, 0x1F)
#define PROPERTIES_BEEP		FULLMENUNUM(4, 2, 0x1F)
#define PROPERTIES_POST		FULLMENUNUM(4, 3, 0x1F)
#define PROPERTIES_REVERSE	FULLMENUNUM(4, 4, 0x1F)
#define PROPERTIES_RANDOM	FULLMENUNUM(4, 5, 0x1F)

#define DEBUG_AWINDOW		FULLMENUNUM(5, 0, 0x1F)
#define DEBUG_BWINDOW		FULLMENUNUM(5, 1, 0x1F)
#define DEBUG_DEPTH			FULLMENUNUM(5, 2, 0x1F)
#define DEBUG_CONTEMPT		FULLMENUNUM(5, 3, 0x1F)
#define DEBUG_XWINDOW		FULLMENUNUM(5, 4, 0x1F)
#define DEBUG_TEST			FULLMENUNUM(5, 5, 0x1F)
#define DEBUG_SHOWPOSTNVAL	FULLMENUNUM(5, 6, 0x1F)
#define DEBUG_DEBUG			FULLMENUNUM(5, 7, 0x1F)

extern struct Gadget *GAD_ToMove;
extern struct Gadget *GAD_MoveNum;
extern struct Gadget *GAD_Ok;

#define STR_GADGETS		5
#define GADGETS			15

#define GAD_WHITE		0
#define GAD_BLACK		1
#define GAD_TOURNAMENT	2
#define GAD_OPENING		3
#define GAD_NOTE		4
#define GAD_OK			100
#define GAD_CANCEL		101
#define GAD_CLEAR		102
#define GAD_DEFAULT		103
#define GAD_TOMOVE		104
#define GAD_MOVENUM		105

#define GAD_WB			200
#define GAD_SB			201
#define GAD_WS			202
#define GAD_SS			203
#define GAD_WL			204
#define GAD_SL			205
#define GAD_WT			206
#define GAD_ST			207
#define GAD_WD			208
#define GAD_SD			209
#define GAD_WK			210
#define GAD_SK			211

#define IDCMPORT		(w->UserPort)
#define CLASS(M)		((M)->Class)
#define CODE(M)			((M)->Code)
#define GADGET(M)		((struct Gadget *)((M)->IAddress))
#define GADGETID(M)		(GADGET(M)->GadgetID)
#define GADGETSTR(G)	(((struct StringInfo *)((G)->SpecialInfo))->Buffer)
#define GADGETINT(G)	(((struct StringInfo *)((G)->SpecialInfo))->LongInt)
#define MOUSEX(M)		((M)->MouseX)
#define MOUSEY(M)		((M)->MouseY)

#endif
