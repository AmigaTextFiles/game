// GAI.cpp: implementation of the GAI class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "GAI.h"
#include "GRun.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

GAI::GAI()
{
	for (int i = 0; i < MAXAIDAT; i++)
		m_aidat[0] = 0;
}

GAI::~GAI()
{

}

void GAI::Move(GRun *run, int ID)
{
	m_run = run;
	m_ID  = ID;
	m_s   = &(run->m_sold[ID]);
	switch (m_s->m_AI_l) {
	case 0 :
		CompLev1();
		break;
	case 1 :
		CompLev2();
		break;
	case 2 :
		CompLev3();
		break;
	case 3 :
		CompLev4();
		break;
	}
}

void GAI::CompLev1()
{
	int enem = GetNearestEnemy();

	GotoXY(m_run->m_sold[enem].m_x, m_run->m_sold[enem].m_y, 30);

	if (m_s->m_naboje[Zparams[m_s->m_zbran].strelaID] == 1) m_s->m_chzbran = true;
	else m_s->m_chzbran = false;

	m_s->m_fwd = true;    // chuze vpred
	m_s->m_back = false;

	m_s->m_sleft = false;  // vypnuti strafovani
	m_s->m_sright = false;	
	
	TestAllShooting();

	if (rand()%40 == 0) m_s->m_liveup = true; // poctac se chce ozivit
	else m_s->m_liveup = false;
}

void GAI::CompLev2()
{
	int enem = GetNearestEnemy();

	int dst = Dts(m_run->m_sold[enem].m_x, m_run->m_sold[enem].m_y, m_s->m_x, m_s->m_y);

	// natoceni
	if (dst > 20)
		GotoXY(m_run->m_sold[enem].m_x, m_run->m_sold[enem].m_y, 30);
	else
		GotoXY(-m_run->m_sold[enem].m_x, -m_run->m_sold[enem].m_y, 30);

	if (dst > 200)
		m_s->m_run = true;
	else
		m_s->m_run = false;

	// pohyb
	m_s->m_fwd = false;    // chuze vpred
	m_s->m_back = false;
	if (dst > 70)
		m_s->m_fwd   = true;    // chuze vpred
	if (dst < 40)
		m_s->m_back = true;  // chuze vzad

	m_s->m_sleft = false;
	m_s->m_sright = false;


	if (m_s->m_naboje[Zparams[m_s->m_zbran].strelaID] == 0) m_s->m_chzbran = true;
	else m_s->m_chzbran = false;

	TestAllShooting();

	if (rand()%40 == 0) m_s->m_liveup = true; // poctac se chce ozivit
	else m_s->m_liveup = false;
}

void GAI::GotoXY(int x, int y, int dist)
{
	int  TSTangle = atan2(m_s->m_y - y, x - m_s->m_x)*256/DPI; // uhel, pod kterym chceme jet
	while (TSTangle < 0) TSTangle += 256;

	int angle = (int)(m_s->m_angle);
	while (angle < 0) angle += 256;
	angle %= 256;


	if (abs(TSTangle - angle) > Sparams[m_s->m_ID].turning) {

		int dl;
		int dr;
		if (TSTangle > angle) {
			dl = TSTangle - angle;
			dr = 256 - dl;
		}
		else {
			dr = angle - TSTangle;
			dl = 256 - dr;
		}

		if (dl < dr) m_s->m_left  = true;   // zataceni vlevo
		else m_s->m_left = false;

		if (dr < dl) m_s->m_right = true;
		else m_s->m_right = false;
	}
	else {
		m_s->m_left = false;
		m_s->m_right = false;
	}
}

int GAI::GetNearesHeal()
{
	return -1;
}

int GAI::GetNearestEnemy()
{
	if (m_run->m_kill_mee) 
		return 0;  // vsichni utoci na hrace

	int max = 0, k = 4000,  j;
	for (int i = 0; i < m_run->m_soldiers; i++)
		if (i != m_ID && m_run->m_sold[i].m_health > 0 && (m_run->m_sold[i].m_bonusy[BON_INVIS] == 0)) {
			j = Dts(m_run->m_sold[i].m_x, m_run->m_sold[i].m_y, m_s->m_x, m_s->m_y);
			if (j < k) {
				k  = j;
				max = i;
			}
		}
	return max;
}

int GAI::GetNearestPup()
{
	return -1;
}

int GAI::Dts(int x, int y, int x2, int y2)
{
//	return pow(pow(x-x2,2)+pow(y-y2,2),0.5);
	return (abs(x-x2) + abs(y-y2));
}

void GAI::TestAllShooting()
{
//	RECT rect;
/*	rect.left = m_s->m_x;
	rect.left = m_s->m_x;
	rect.left = m_s->m_x;
	rect.left = m_s->m_x;*/
//	m_s->m_shoot = true;
	if (rand()%10 > 6) m_s->m_shoot = true;
	else m_s->m_shoot = false;

}

void GAI::Init()
{
	// zatim takhle ;)
	m_ID = -1;
	m_run = NULL;
	m_s = NULL;
}

void GAI::CompLev3()
{
	int enem = GetNearestEnemy();

	int dst = Dts(m_run->m_sold[enem].m_x, m_run->m_sold[enem].m_y, m_s->m_x, m_s->m_y);

	// natoceni
	if (dst > 20)
		GotoXY(m_run->m_sold[enem].m_x, m_run->m_sold[enem].m_y, 30);
	else
		GotoXY(-m_run->m_sold[enem].m_x, -m_run->m_sold[enem].m_y, 30);

	if (dst > 200)
		m_s->m_run = true;
	else
		m_s->m_run = false;

	// pohyb
	m_s->m_fwd = false;    // chuze vpred
	m_s->m_back = false;
	if (dst > 50)
		m_s->m_fwd   = true;    // chuze vpred

	if (dst < 30)
		m_s->m_back = true;  // chuze vzad

	// strafovani
	if (dst < 50)
		if (m_aidat[0] == 0) m_aidat[0] = rand()%2 + 1;
	
	if (m_aidat[0] == 1) m_s->m_sleft = true;
	else m_s->m_sleft = false;
	if (m_aidat[0] == 2)	m_s->m_sright = true;
	else m_s->m_sright = false;


	if (--m_aidat[1] <= 0) {
		m_aidat[1] = 20 + rand()%20 + rand()%20 + rand()%20;
		if (rand()%5 == 0) m_aidat[0] = rand()%2 + 1;
		else m_aidat[0] = 0;
	}


	// meneni zbrane
	if (m_s->m_naboje[Zparams[m_s->m_zbran].strelaID] == 0) m_s->m_chzbran = true;
	else m_s->m_chzbran = false;

	// strelba
	if ((rand()%10 > 6) || (dst < 200)) m_s->m_shoot = true;
	else m_s->m_shoot = false;

	if (rand()%40 == 0) m_s->m_liveup = true; // poctac se chce ozivit
	else m_s->m_liveup = false;
}


void GAI::GotoXYT(int x, int y, int dist)
{
	int  TSTangle = atan2(m_s->m_y - y, x - m_s->m_x)*256/DPI; // uhel, pod kterym chceme jet
	while (TSTangle < 0) TSTangle += 256;

	int angle = (int)(m_s->m_angle);
	while (angle < 0) angle += 256;
	angle %= 256;


	if (abs(TSTangle - angle) > Sparams[m_s->m_ID].turning) {

		int dl;
		int dr;
		if (TSTangle > angle) {
			dl = TSTangle - angle;
			dr = 256 - dl;
		}
		else {
			dr = angle - TSTangle;
			dl = 256 - dr;
		}

		if (dl < dr) m_s->m_left  = true;   // zataceni vlevo
		else m_s->m_left = false;

		if (dr < dl) m_s->m_right = true;
		else m_s->m_right = false;

		// panacek se otaci rychle
		if ((m_s->m_turnspeed = abs(TSTangle - angle)) > 40) m_s->m_turnspeed = 40;
		if (m_s->m_turnspeed < TURNSENSITIVE/2) m_s->m_turnspeed = TURNSENSITIVE/2;
	}
	else {
		m_s->m_left = false;
		m_s->m_right = false;
	}
}

void GAI::CompLev4()
{
	int enem = GetNearestEnemy();

	int dst = Dts(m_run->m_sold[enem].m_x, m_run->m_sold[enem].m_y, m_s->m_x, m_s->m_y);

	// natoceni
	if (dst > 20)
		GotoXYT(m_run->m_sold[enem].m_x, m_run->m_sold[enem].m_y, 30);
	else
		GotoXYT(-m_run->m_sold[enem].m_x, -m_run->m_sold[enem].m_y, 30);

	if (dst > 50)
		m_s->m_run = true;
	else
		m_s->m_run = false;

	// pohyb
	m_s->m_fwd = false;    // chuze vpred
	m_s->m_back = false;
	if (dst > 60)
		m_s->m_fwd   = true;    // chuze vpred

	if (dst < 40)
		m_s->m_back = true;  // chuze vzad

	// strafovani
	if (dst < 60)
		if (m_aidat[0] == 0) m_aidat[0] = rand()%2 + 1;
	
	if (m_aidat[0] == 1) m_s->m_sleft = true;
	else m_s->m_sleft = false;
	if (m_aidat[0] == 2)	m_s->m_sright = true;
	else m_s->m_sright = false;


	if (--m_aidat[1] <= 0) {
		m_aidat[1] = 20 + rand()%20 + rand()%20 + rand()%20;
		if (rand()%5 == 0) m_aidat[0] = rand()%2 + 1;
		else m_aidat[0] = 0;
	}


	// meneni zbrane
	if ((m_s->m_naboje[Zparams[m_s->m_zbran].strelaID] == 0) || (rand()%100 == 0)) m_s->m_chzbran = true;
	else m_s->m_chzbran = false;

	// strelba
	if ((rand()%10 > 6) || (dst < 300)) m_s->m_shoot = true;
	else m_s->m_shoot = false;

	if (rand()%40 == 0) m_s->m_liveup = true; // poctac se chce ozivit
	else m_s->m_liveup = false;
}
