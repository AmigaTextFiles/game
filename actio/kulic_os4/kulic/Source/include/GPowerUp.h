// GPowerUp.h: interface for the GPowerUp class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_GPOWERUP_H__7ECC0440_3E5C_11D4_8F75_A49250BF951D__INCLUDED_)
#define AFX_GPOWERUP_H__7ECC0440_3E5C_11D4_8F75_A49250BF951D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "GClasses.h"

class GPowerUp  
{
public:
	bool Picked(GSoldier *sold, GPowerUp **me);
	void Init(int x, int y, int type);
	void Draw(BITMAP *dst, int CX, int CY);
	GPowerUp();
	virtual ~GPowerUp();

	int m_x;
	int m_y;
	int m_ID;
};

#endif // !defined(AFX_GPOWERUP_H__7ECC0440_3E5C_11D4_8F75_A49250BF951D__INCLUDED_)
