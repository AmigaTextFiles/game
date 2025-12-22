// GMenu.h: interface for the GMenu class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_GMENU_H__67921400_3F05_11D4_8F75_C0DCED0EBB18__INCLUDED_)
#define AFX_GMENU_H__67921400_3F05_11D4_8F75_C0DCED0EBB18__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "GRun.h"

#include "inifile.h"
#include "GMenuBack.h"

extern st_inifile ini;

class GMenu  
{
public:
	void DrawCredits(int y);
	void Destroy(GRun *run);
	void LoadGFX(GRun *run);
	int  Col(int index);
	void Run(GRun *run);
	GMenu();
	virtual ~GMenu();

private:
	void RunDemo();
	void RunCredits();
	void RunMenuMulti();
	void RunMenuSingle();
	void RunMenuSet();

	bool ProccesKeys();
	void Draw();
	int  m_item;

	GRun      *m_run;
	GMenuBack *m_back;

	SAMPLE    *m_music; // hudba na pozadi mapy

	enum {
		it_multi = 0,
		it_single,
		it_demo,
		it_nastaveni,
		it_konec
	};
};

#endif // !defined(AFX_GMENU_H__67921400_3F05_11D4_8F75_C0DCED0EBB18__INCLUDED_)
