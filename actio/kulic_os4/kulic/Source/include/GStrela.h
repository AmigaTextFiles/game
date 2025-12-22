// GStrela.h: interface for the GStrela class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_GSTRELA_H__194F7A40_3464_11D4_8F75_B0131965891D__INCLUDED_)
#define AFX_GSTRELA_H__194F7A40_3464_11D4_8F75_B0131965891D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "GClasses.h"
#include "zbrane.h"

class GStrela  
{
public:
	void InitMulti(int x, int y, int angle, int ID, int who);
	bool Hit(int x, int y, int dst);
	int  GetDemage(GMap  *map, GRun *run);
	void Draw(BITMAP *dst, int CX, int CY, BITMAP *tmp, bool light, bool transparent);
	void Move(GMap *map, GRun *run);
	void Init(int x, int y, int angle, int ID, int who, double speed, int zbranID);
	GStrela();
	virtual ~GStrela();

	bool m_active; // zda je strela aktivni
	int m_x;  // soucasna souradnice
	int m_y;  // soucasna souradnice
	int m_dx; // prirustek v pohybu po x
	int m_dy; // prirustek v pohybu po y
	double m_angleRad; // uhelpohybu v radianech
	int  m_angle; // uhel pohybu v 0-255
	int  m_ID;  // typ strely
	int  m_who;  // seznam jiz trefenych panacku (viz exploze)
	double m_speed; // rychlost strely
	int m_distance; // jakou vzdalenost muze jeste strela uletet

	bool m_network; // zda je sstrela od jineho hrace v multiplayeru (pak se s ni tolik nepocita (pohyb))

	int m_dist; // polomer ucinnosti

	RECT m_rect;  // obdelnik poskozeni
};

#endif // !defined(AFX_GSTRELA_H__194F7A40_3464_11D4_8F75_B0131965891D__INCLUDED_)
