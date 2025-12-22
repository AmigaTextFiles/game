// GMenuSingle.h: interface for the GMenuSet class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_GMENUSINGLE_H__F46D0F01_6C92_11D4_8F75_8E54C4C8091C__INCLUDED_)
#define AFX_GMENUSINGLE_H__F46D0F01_6C92_11D4_8F75_8E54C4C8091C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "GRun.h"
#include "GMenuBack.h"

class GMenuSingle
{
public:
	void Run(GRun *run, GMenuBack *back);
	GMenuSingle();
	virtual ~GMenuSingle();

private:
	int Col(int index);
	void RunSingle(bool kill_me);
	void Draw();
	bool ProcessKeys();
	void Destroy();
	bool LoadGfx();

	GRun *m_run;
	GMenuBack *m_back;

	int  m_item;
	int  m_enemy; // pocet protivniku

	enum {
		it_enemy = 0,
		it_ai_diff,
		it_kill_me,
		it_play,
		it_zpet
	};

};

#endif // !defined(AFX_GMENUSINGLE_H__F46D0F01_6C92_11D4_8F75_8E54C4C8091C__INCLUDED_)
