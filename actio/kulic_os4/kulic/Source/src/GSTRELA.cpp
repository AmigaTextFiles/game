// GStrela.cpp: implementation of the GStrela class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "GStrela.h"
#include "GMap.h"
#include "GRun.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

GStrela::GStrela()
{
	m_dist = 5;
	m_active = false;
}

GStrela::~GStrela()
{

}

/*////////////////////////////////////////////////////////////////////////////////
	Inicializace parametru strely
*/
void GStrela::Init(int x, int y, int angle, int ID, int who, double speed, int zbranID)
{
	m_active = true;
	m_angleRad = angle*DPI/256;
	m_angle = angle;

	if (zbranID != -1) {
		m_x = x + Zparams[zbranID].ddst * cos(-m_angleRad - Zparams[zbranID].datan);
		m_y = y + Zparams[zbranID].ddst * sin(-m_angleRad - Zparams[zbranID].datan);
	} 
	else {
		m_x = x;
		m_y = y;
	}

	m_ID = ID;
	m_speed = Nparams[m_ID].speed;
	if (speed > 0) m_speed += speed;
	if (Nparams[m_ID].rspeed != 0)  m_speed += rand()%Nparams[m_ID].rspeed;

	m_distance = Nparams[m_ID].dist;
	if (Nparams[m_ID].rdist != 0)  m_distance += rand()%Nparams[m_ID].rdist;

	m_dx = cos(m_angleRad) * m_speed;
	m_dy = sin(m_angleRad) * m_speed;


	m_who = who; // aby hrac netrefil sam sebe ;)
	m_network = false;
}

/*////////////////////////////////////////////////////////////////////////////////
	Pohyb strely - a pripadny vybuch :)
*/
void GStrela::Move(GMap *map, GRun *run)
{
	if (m_network) return;

	bool podm = map->CanShoot(m_x, m_y, m_angleRad, m_speed, Nparams[m_ID].level);

	if (podm) {
		m_x += m_dx;
		m_y -= m_dy;
		m_distance -= m_speed;
	}

	if ((m_x < -10) || (m_y < -10) ||
		(m_x > map->m_sx+10) || (m_y > map->m_sy+10)) {
		m_active = false;
		return;
	}
	if ((m_distance < 0)||(!podm)) {
			for (int i = 0; i < Nparams[m_ID].explosive; i++)
				map->NewStrela(m_x+rand()%30-15, m_y+rand()%30-15, rand()%256, Nparams[m_ID].eID, m_who, 0, -1);
			run->m_sshoots.Play(Nparams[m_ID].expl, m_x, m_y, run->m_sold[0].m_x, run->m_sold[0].m_y);
			m_active = false;
			return;
	}
}

/*////////////////////////////////////////////////////////////////////////////////
	Kresleni strely
*/
void GStrela::Draw(BITMAP *dst, int CX, int CY, BITMAP *tmp, bool light, bool transparent)
{
	CX = m_x - CX + (DF_X) / 2;
	CY = m_y - CY + (DF_Y)  / 2;

	if (CX > DF_X + 40 || CX < -40 ||
		 CY > DF_Y + 40 || CY < -40) return;

	int i;
	if ((transparent || light)&&(Nparams[m_ID].kour != 0)) {
		BITMAP *colored = create_bitmap(b_kour_mask[0]->w, b_kour_mask[0]->h);
		clear_to_color(colored, makecol(128, 128, 128));
		for (i = 1; i < Nparams[m_ID].kour+1; i++)
			hmasked_sprite(dst, colored, b_kour_mask[i-1], CX-b_kour_mask[0]->w/2-cos(m_angleRad)*i*11, CY-b_kour_mask[0]->h/2+sin(m_angleRad)*i*11);
		destroy_bitmap(colored);
		// ohen za strelou
		colored = create_bitmap(20, 20);
		rotate_sprite(colored, b_plamen[0], 0,0, itofix(-m_angle));
		hmasked_spritetcm(dst, colored, b_plamen[1], CX-10-cos(m_angleRad)*5, CY-10+sin(m_angleRad)*5);
		destroy_bitmap(colored);
	}
	else 	
		if (Nparams[m_ID].kour != 0) {
			for (i = 1; i < Nparams[m_ID].kour+1; i++)
				rotate_sprite(dst, b_kour[0], CX-b_kour[0]->w/2-cos(m_angleRad)*i*11, CY-b_kour[0]->h/2+sin(m_angleRad)*i*11, itofix(rand()%255));
			rotate_sprite(dst, b_plamen[0], CX-10-cos(m_angleRad)*5, CY-10+sin(m_angleRad)*5, itofix(-m_angle));
		}


	if (transparent && Nparams[m_ID].mask != -1) {
		BITMAP *b2 = create_bitmap(20,20);
		clear_to_color(b2, makecol(255, 0, 255));
		rotate_sprite(b2, b_strel[m_ID], 5, 5, itofix(-m_angle));

		BITMAP *b1 = create_bitmap(20,20);
		clear_to_color(b1, makecol(255, 255, 255));
		rotate_sprite(b1, b_strely_mask[Nparams[m_ID].mask], 5, 5, itofix(-m_angle));

		hmasked_spritetcm(dst, b2, b1, CX-10, CY-10);

		destroy_bitmap(b2);
		destroy_bitmap(b1);
	}
	else 
		rotate_sprite(dst, b_strel[m_ID], CX-b_strel[m_ID]->w/2, CY-b_strel[m_ID]->h/2, itofix(-m_angle));


	// kdyz svetlo
	if (light && Nparams[m_ID].light != -1)
		hdraw_light_sprite(dst, b_lights_mask[Nparams[m_ID].light], CX-b_lights_mask[Nparams[m_ID].light]->w/2, CY-b_lights_mask[Nparams[m_ID].light]->h/2);

}

/*////////////////////////////////////////////////////////////////////////////////
	Vrati poskozeni a exploduje
*/
int GStrela::GetDemage(GMap  *map, GRun *run)
{
	for (int i = 0; i < Nparams[m_ID].explosive; i++)
		map->NewStrela(m_x+rand()%30-15, m_y+rand()%30-15, rand()%256, Nparams[m_ID].eID, m_who, 0, -1);
	run->m_sshoots.Play(Nparams[m_ID].expl, m_x, m_y, run->m_sold[0].m_x, run->m_sold[0].m_y);
	m_active = false;

	return Nparams[m_ID].demage;
}

bool GStrela::Hit(int x, int y, int dst)
{
	int sx, sy;
   int dist = m_dist + dst;

	if (!IsOut(x, y, m_x, m_y, dist)) return true; // strela zasah

	sx = m_x + cos(m_angleRad) * m_speed / 2;
	sy = m_y - cos(m_angleRad) * m_speed / 2;
	if (!IsOut(x, y, sx, sy, dist)) return true; // strela zasah

	sx = m_x - cos(m_angleRad) * m_speed / 2;
	sy = m_y + cos(m_angleRad) * m_speed / 2;
	if (!IsOut(x, y, sx, sy, dist)) return true; // strela zasah

	return false;
}

void GStrela::InitMulti(int x, int y, int angle, int ID, int who)
{
	m_active = true;
	m_angleRad = angle*DPI/256;
	m_angle = angle;

	m_x = x;
	m_y = y;

	m_ID = ID;
	m_speed = Nparams[ID].speed;
	m_distance = 50;
	m_dx = 0;
	m_dy = 0;


	m_who = who; // aby hrac netrefil sam sebe ;)
	m_network = true;
}
