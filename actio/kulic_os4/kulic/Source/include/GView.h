// GView.h: interface for the GView class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _G_VIEW_INCLUDE_
#define _G_VIEW_INCLUDE_

#include "GClasses.h"

#define MAX_GV_BITMAPS 11
#define GV_RAMECEK 0
#define GV_ZDRAVI  1
#define GV_STIT    2
#define GV_FRAGS   3
#define GV_AMMO    4


#define MAX_BESTSOLD_ANIM 4

extern BITMAP* b_gv[MAX_GV_BITMAPS];
extern BITMAP* b_topten[3];
extern BITMAP* b_bestsold[MAX_BESTSOLD_ANIM];

typedef struct {
	int   frags;
	char  name[50];
	int   ID;
} st_fragstable;

#define MAX_MESSAGES  6  // maximalni pocet zprav vlevo nahore na obrazovce

class GView  
{
public:
	void DrawMenu(BITMAP *dst, GRun *run);
	void DrawAA(GRun *run, bool light, bool shadow);
	void CountFrags(GRun *run);
	void DrawFrags(GRun *run);

	void AddFragsMess(int kdo, GRun *run);
	void AddMessage(char *c);
	void AddKillMessage(int kdo, int koho, GRun *run);
	void AddBonMessage(int ID);
	bool LoadGFX(GRun *run);
	void Destroy();
	void UpdateCamera(GRun *run);
	void Init(GSoldier *car);
	void Draw(BITMAP *dst, GRun *run, bool light, bool shadow);
	GView();
	virtual ~GView();

	int  m_Cx; // X-ova souradnice pohledu (Camera x)
	int  m_Cy; // Y-ova souradnice pohledu (Camera y)
	bool m_zamerovac;  // zda se ma kreslit zamerovac
	int  m_dxtable;  // posunuti tabulky

	int  m_dabel;   // jde o napsani napisu "SES DABEL - MAS 666 FRAGU" nebo neco takoveho - aby drzel na obrazovce 4 sekund

	char      m_mess[MAX_MESSAGES][100];
	GSoldier  *(ftable[MAX_PLAYERS+1]); // tabulka poradi dle fragu 

private:
	void DrawBestSold(BITMAP *dst);
	void DrawCurSold(BITMAP *dst, GRun *run);

};

#endif // #ifndef _G_VIEW_INCLUDE_
