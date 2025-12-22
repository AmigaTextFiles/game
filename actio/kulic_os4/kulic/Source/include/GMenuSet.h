// GMenuSet.h: interface for the GMenuSet class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_GMENUSET_H__F46D0F01_6C92_11D4_8F75_8E54C4C8091C__INCLUDED_)
#define AFX_GMENUSET_H__F46D0F01_6C92_11D4_8F75_8E54C4C8091C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "GRun.h"
#include "GMenuBack.h"

class GMenuSet  
{
public:
	int Col(int index);
	void Run(GRun *run, GMenuBack *back);
	GMenuSet();
	virtual ~GMenuSet();

private:
	void Draw();
	bool ProcessKeys();
	void Destroy();
	bool LoadGfx();

	GRun *m_run;
	GMenuBack *m_back;

	int  m_item;

	enum {
		it_jmeno = 0,
		it_postava,
		it_mapa,
		it_svetlo,
		it_zpet
	};

};

#endif // !defined(AFX_GMENUSET_H__F46D0F01_6C92_11D4_8F75_8E54C4C8091C__INCLUDED_)
