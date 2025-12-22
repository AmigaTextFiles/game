// GAI.h: interface for the GAI class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_GAI_H__B25604A1_415E_11D4_8F75_BB50F7F77D1D__INCLUDED_)
#define AFX_GAI_H__B25604A1_415E_11D4_8F75_BB50F7F77D1D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "GClasses.h"

#define COMPAILEVELS 4

#define MAXAIDAT 5

class GAI  
{
public:
	void Init();
	void Move(GRun *run, int ID);
	GAI();
	virtual ~GAI();

private :
	void TestAllShooting();
	int Dts(int x, int y, int x2, int y2);
	int GetNearestPup();
	int GetNearestEnemy();
	int GetNearesHeal();
	void GotoXY(int x, int y, int dist);
	GRun     *m_run;  // docasna promena
	GSoldier *m_s;    // nas vojak
	int       m_ID;   // ID vojaka
	void CompLev2();
	void CompLev1();
	void GotoXYT(int x, int y, int dist);
	void CompLev3();
	void CompLev4();

	int m_aidat[MAXAIDAT]; // interni promene dane inteligence
};

#endif // !defined(AFX_GAI_H__B25604A1_415E_11D4_8F75_BB50F7F77D1D__INCLUDED_)
