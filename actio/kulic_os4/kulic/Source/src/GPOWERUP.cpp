// GPowerUp.cpp: implementation of the GPowerUp class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "GPowerUp.h"
#include "GSoldier.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

GPowerUp::GPowerUp()
{

}

GPowerUp::~GPowerUp()
{

}

/*////////////////////////////////////////////////////////////////////////////////
	Kresli powerUp
*/
void GPowerUp::Draw(BITMAP *dst, int CX, int CY)
{
	CX = m_x - CX + (DF_X-5) / 2;
	CY = m_y - CY + (DF_Y-5)  / 2;
	draw_sprite(dst, b_powerups[m_ID], CX, CY);
}

/*////////////////////////////////////////////////////////////////////////////////
	Inicializuje powerup
*/
void GPowerUp::Init(int x, int y, int type)
{
	m_x = x;
	m_y = y;
	m_ID = type;
}

/*////////////////////////////////////////////////////////////////////////////////
	Testuje sebrani powerupu
*/
bool GPowerUp::Picked(GSoldier *sold, GPowerUp **me)
{
	if (IsOut(m_x, m_y, sold->m_x, sold->m_y, 20)) return false;
	if (sold->m_health <= 0) return false;

	if (Pparams[m_ID].typ < PUP_LEKARNA) {
		sold->m_bonusy[Pparams[m_ID].typ] += Pparams[m_ID].cnt;
	}
	else {
		// zdravi
		if ((sold->m_health += Pparams[m_ID].health)  > Sparams[sold->m_ID].health) sold->m_health = Sparams[sold->m_ID].health;

		// stity
		if ((sold->m_shield += Pparams[m_ID].shields) > Sparams[sold->m_ID].shields) sold->m_shield = Sparams[sold->m_ID].shields;

		// strelivo
		if ((sold->m_naboje[Pparams[m_ID].nID] += Pparams[m_ID].cnt) > Nparams[Pparams[m_ID].nID].strel) sold->m_naboje[Pparams[m_ID].nID] = Nparams[Pparams[m_ID].nID].strel;
	}

	*me = NULL;
	delete this;

	return true;
}
