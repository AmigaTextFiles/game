#include "stdh.h"
#include "GSoldier.h"
#include "GMap.h"
#include "GRun.h"

#include "inifile.h"
extern st_inifile ini;


double turnsensitive = TURNSENSITIVE; // = TURNSENSITIVE 


//////////////////////////////////////////////////////////////////////////////////
//                          INICIALIZACNI FUNKCE
//////////////////////////////////////////////////////////////////////////////////

/*////////////////////////////////////////////////////////////////////////////////
  konstructor - nuluje promene
*/
GSoldier::GSoldier()
{
	m_x = 0;
	m_y = 0;
	m_angle = 0;
	m_speed = 0;
	m_dist = 10;
}

/*////////////////////////////////////////////////////////////////////////////////
  destruktor
*/
GSoldier::~GSoldier()
{
}

/*////////////////////////////////////////////////////////////////////////////////
  pri novem zavodu - vymaze vse a nasatvi pozici auta 
  index :  index v poli u GRUN
  x,y   :  pozice na hraci plose
*/
void GSoldier::Init(int index, int x, int y, int zbran, bool dorust, int vybaven, GMap *map)
{
	m_tochange = 0;
	m_index = index;
	m_sx     = x;
	m_sy     = y;
	m_frags  = 0;
	m_zbran  = zbran;

	m_a_zbran  = 0;
	m_a_nohy   = 0;
	m_a_shield = -1;
	m_a_krev   = -1;
	m_a_water  = -1;

	m_lastkill   = -1;  
	m_lastkilled = -1;

	m_AI.Init();

	RaiseFromDead(map, vybaven, ini.nesmrt);
}

/*////////////////////////////////////////////////////////////////////////////////
  Nastavi pozadavky ridice
  fwd   : zda chce jet vpred
  back  : pro jizdu vzad(brzdu)
  left  : zatoceni wlevo
  right : zatoceni wpravo
*/
void GSoldier::SetKeys(bool fwd, bool back, bool left, bool right, bool sleft, bool sright, bool run, bool shoot, bool chzbran, bool liveup)
{
	m_fwd     = fwd;
	m_back    = back;
	m_left    = left;
	m_right   = right;
	m_sleft   = sleft;
	m_sright  = sright;
	m_run     = run;
	m_shoot   = shoot;
	m_chzbran = chzbran;
	m_liveup  = liveup;
}




//////////////////////////////////////////////////////////////////////////////////
//                              GRAFICKE FUNKCE
//////////////////////////////////////////////////////////////////////////////////

/*////////////////////////////////////////////////////////////////////////////////
  Kresli vojaka na danou bitmapu ( zavodni plochu )
  dest - pointer na bitmapu, kam se ma auto nakreslit (velikosti DF_X, DF_X )
  x,y  - souradnice stredu dest vuci trati
*/

void GSoldier::Draw(BITMAP *dest, int x, int y, bool light, bool shadow)
{
	// uprava parametru
	x = m_x - x + (DF_X) / 2;
	y = m_y - y + (DF_Y) / 2;

	if (x > DF_X + 40 || x < -40 ||
		 y > DF_Y + 40 || y < -40) return;

	// kresleni vojaka
	if (m_health > 0 && (m_bonusy[BON_INVIS] == 0)) {
		// strikajici woda
		if (m_a_water != -1) {
			rotate_sprite(dest, b_s_water[m_a_water], x-b_s_water[m_a_water]->w/2, y-b_s_water[m_a_water]->h/2, itofix(-m_angle));
			if (++m_a_water >= MAX_WATER_BITMAPS) m_a_water = 0;
		}

		// pekelny stin - nepovedlo se :( (nevypada to pekne)
	//	if (shadow)
	//		hdraw_shadow_sprite(hscreen.m_back, b_lights_mask[SOLDIER_SHADOW], x-b_lights_mask[SOLDIER_SHADOW]->w/2, y-b_lights_mask[SOLDIER_SHADOW]->h/2);
			

		// nohy
		if (m_animate & ANIM_RUN)
			rotate_sprite(dest, b_s_run[m_a_nohy], x-b_s_run[m_a_nohy]->w/2, y-b_s_run[m_a_nohy]->h/2, itofix(-m_angle));
		else
			rotate_sprite(dest, b_s_walk[m_a_nohy], x-b_s_walk[m_a_nohy]->w/2, y-b_s_walk[m_a_nohy]->h/2, itofix(-m_angle));

		// zbran
		if(!Zparams[m_zbran].nad && m_naboje[Zparams[m_zbran].strelaID] > 0) 
			if(b_zbrane[m_zbran][m_a_zbran] != NULL) 
				rotate_sprite(dest, b_zbrane[m_zbran][m_a_zbran], x-b_zbrane[m_zbran][m_a_zbran]->w/2, y-b_zbrane[m_zbran][m_a_zbran]->h/2, itofix(-m_angle));
		// telo
		rotate_sprite(dest, b_solds[Sparams[m_ID].bindex], x-b_solds[Sparams[m_ID].bindex]->w/2, y-b_solds[Sparams[m_ID].bindex]->h/2, itofix(-m_angle));

		// zbran
		if(Zparams[m_zbran].nad && m_naboje[Zparams[m_zbran].strelaID]  > 0)  {
			if(b_zbrane[m_zbran][m_a_zbran] != NULL) 
				rotate_sprite(dest, b_zbrane[m_zbran][m_a_zbran], x-b_zbrane[m_zbran][m_a_zbran]->w/2, y-b_zbrane[m_zbran][m_a_zbran]->h/2, itofix(-m_angle));
		}

		// napsani jmena
		if (light) 
			textout_centre(dest, (FONT *)fonts[FNT_SMALL].dat, m_name, x, y-30, makecol(100,100,0));
		else
			textout_centre(dest, (FONT *)fonts[FNT_SMALL].dat, m_name, x, y-30, makecol(200,200,0));

		// svetlo zbrane
		if (light && Zparams[m_zbran].light != -1 && m_naboje[Zparams[m_zbran].strelaID]  > 0)
			hdraw_light_sprite(dest, b_lights_mask[Zparams[m_zbran].light], x-b_lights_mask[Zparams[m_zbran].light]->w/2, y-b_lights_mask[Zparams[m_zbran].light]->h/2);

		// zablesk strelby
		if ((m_a_fire != -1) && (Zparams[m_zbran].fire) && (shadow || light)) {

			int fx = x + (Zparams[m_zbran].ddst) * cos(-m_angleRad-Zparams[m_zbran].datan);
			int fy = y + (Zparams[m_zbran].ddst) * sin(-m_angleRad-Zparams[m_zbran].datan);

			rotate_sprite(dest, b_zbrane_fire[m_a_fire], fx-5, fy-5, itofix(-m_angle));
		
			if (light) 
				hdraw_light_sprite(dest, b_zbrane_fire_l[m_a_fire], fx-b_zbrane_fire_l[m_a_fire]->w/2, fy-b_zbrane_fire_l[m_a_fire]->h/2);
		}

	}


	// trocha krve
	if (m_a_krev >= 0) {
		draw_sprite(dest, b_krev[m_a_krev], x-b_krev[m_a_krev]->w/2, y-b_krev[m_a_krev]->h/2);
		m_a_krev--;
	}
	// malikej stit
	if (m_a_shield >= 0) {
		draw_sprite(dest, b_stit[m_a_shield], x-b_stit[m_a_shield]->w/2, y-b_stit[m_a_shield]->h/2);
		m_a_shield--;
	}

#ifdef _DEBUG
	if(m_index == 0) {

		char s[60];
		sprintf(s,"x=%.2f y=%.2f angle=%d frags=%d health=%d stit=%d",m_x, m_y, m_angle, m_frags, m_health, m_shield);
		textout(hscreen.m_back, font, s, 10, 10, makecol(200,200,200));
	}
#endif

}


/*////////////////////////////////////////////////////////////////////////////////
  Pripravi grafika data
*/
bool GSoldier::LoadGFX()
{
	Destroy();

	return true;
}
/*////////////////////////////////////////////////////////////////////////////////
  Znici grafika data
*/
void GSoldier::Destroy()
{
}


//////////////////////////////////////////////////////////////////////////////////
//                              POHYBOVE FUNKCE
//////////////////////////////////////////////////////////////////////////////////

/*////////////////////////////////////////////////////////////////////////////////
   Udela Pohyb 
*/
void GSoldier::Move(GRun *run)
{
	int i;

	if (m_health <= 0) {
		if (m_liveup) RaiseFromDead(&run->m_map, run->m_maxstrel, ini.nesmrt);
		return;
	}

		double speed = Sparams[m_ID].speed;
		int ret;
		double angle2 = 0;
		double turning; 
		if (m_AI_l == -1)
			turning = (Sparams[m_ID].turning * m_turnspeed/turnsensitive)*DPI/255;
		else 
			turning = (Sparams[m_ID].turning * m_turnspeed/TURNSENSITIVE)*DPI/255;

		if (m_run) speed *= 2; // nasobeni 2
		if (m_bonusy[BON_ZRYCHLENI]) {
			speed *= 2; 
			// bylo tady i zrychleni zataceni, ale to byl spise trest ;)
		}
		if (m_bonusy[BON_ZMRAZEN]) {
			speed   /= 3;
			turning /= 2;
		}
		
		if (m_fwd && !m_back) m_speed = speed;
		else if (!m_fwd && m_back) m_speed = -speed;
			  else m_speed = 0;

		// zataceni
		if (m_left && !m_right) m_angleRad += turning;
		if (!m_left && m_right) m_angleRad -= turning;
		// toto je nutne, aby nevznikaly tak velike nepresnosti ve vypoctech (byly opravdu velike pri dostatecnem uhlu)
		if (m_angleRad > DPI) m_angleRad -= DPI;
		if (m_angleRad < -DPI) m_angleRad += DPI;
		m_angle = m_angleRad*255/DPI;

		 // chozen ido stran
		if (m_sleft && !m_sright) angle2 = PI2;
		if (!m_sleft && m_sright) angle2 = -PI2;
		

		// vlastni posum souradnic
		ret = run->m_map.CanWalk(m_x, m_y, m_angleRad, m_speed);
		if (ret & CAN_WALK_X) m_x += cos(m_angleRad) * m_speed;
		if (ret & CAN_WALK_Y) m_y -= sin(m_angleRad) * m_speed;

		// chozeni do strany
		if(angle2 != 0){ 
			ret = run->m_map.CanWalk(m_x, m_y, m_angleRad+angle2, speed);
			if (ret & CAN_WALK_X) m_x += cos(m_angleRad+angle2) * speed;
			if (ret & CAN_WALK_Y) m_y -= sin(m_angleRad+angle2) * speed;
		}
		

	// strelba
	if (m_shoot && m_nrtf==0 && m_naboje[Zparams[m_zbran].strelaID] > 0) {

		int vystrelu = Nparams[Zparams[m_zbran].strelaID].attime;
		if (m_bonusy[BON_2KULBA] && (vystrelu > 1)) vystrelu *=2;
		for(int i = 0; i < vystrelu; i++) {
			int angle = m_angle + rand()%(Zparams[m_zbran].angle+1)-Zparams[m_zbran].angle/2;
			run->m_map.NewStrela(m_x+rand()%6-3,m_y+rand()%6-3,angle,Zparams[m_zbran].strelaID, m_index, m_speed, m_zbran);
		}

		m_naboje[Zparams[m_zbran].strelaID]--;

		m_nrtf = Zparams[m_zbran].rate;

		if (m_bonusy[BON_2KULBA])
			m_nrtf /= 2;

		if (Zparams[m_zbran].so) m_animate |= ANIM_GUN; // animace zbrane pri strelbe
		m_animate |= ANIM_FIRE;

		// zvuk vystrelu
//		if (m_index == 0)
/*
		GSoldier* sold = &run->m_sold[0];

		int vol = 255-(abs(m_x-sold->m_x) + abs(m_y-sold->m_y))/4;
		int pan = 128+(m_x-sold->m_x)/2;
		if (pan < 0) pan = 0;
		if (pan > 255) pan = 255;
		
		if (vol > 10)
			run->m_sshoots.Play(Zparams[m_zbran].sound, vol, pan);*/
		run->m_sshoots.Play(Zparams[m_zbran].sound, m_x, m_y, run->m_sold[0].m_x, run->m_sold[0].m_y);
	}
	if (!Zparams[m_zbran].so) m_animate |= ANIM_GUN; // animace zbrane ne pri strelbe

	if (m_x < DF_SOLD_X/2) m_x = DF_SOLD_X/2;
	if (m_y < DF_SOLD_Y/2) m_y = DF_SOLD_Y/2;
	if (m_x > run->m_map.m_sx-DF_SOLD_X/2) { m_x = run->m_map.m_sx-DF_SOLD_X/2; }
	if (m_y > run->m_map.m_sy-DF_SOLD_Y/2-85) { m_y = run->m_map.m_sy-DF_SOLD_Y/2-85; }

	// dorustani veci
	if (++m_nshield > Sparams[m_ID].dshields) {
		m_nshield = 0;
		if(m_shield < Sparams[m_ID].shields) m_shield++;
	}
	if (m_nrtf > 0) m_nrtf--;

	// meneni zbrane
	if (m_tochange > 0) m_tochange--;
	if ((m_chzbran == true && m_tochange == 0)||(m_naboje[Zparams[m_zbran].strelaID] <= 0)) {
		if(++m_zbran >= MAX_ZBRANE)
			m_zbran = 0;
		m_tochange = 10;
		m_nrtf = 0; // kdyz zmenime zbran, tak ad muzeme rovnou strilet
	}

	// animace wody
	if (run->m_map.IsWater(m_x, m_y) && (m_fwd||m_back)) 
		m_animate |= ANIM_WATER; // animace vody

	// ubrani bonusu
	for(i = 0; i < MAX_BONUS; i++)
		if (m_bonusy[i] > 0) m_bonusy[i]--;

	// animace nohou
	if (m_fwd || m_back)
		if (m_run) m_animate |= ANIM_RUN;
		else m_animate |= ANIM_WALK;
}


/*////////////////////////////////////////////////////////////////////////////////
   Probudi vojaka k zivotu
*/
void GSoldier::RaiseFromDead(GMap *map, int vybaven, bool nesmrt){
	int i;

	m_angle  = rand()%256;

	m_angleRad = m_angle*DPI/255;

	m_speed = 0;

	int a, b;
	map->GetFreePos(&a, &b, 20);
	m_x = a;
	m_y = b;

	m_health = Sparams[m_ID].health;
	m_shield = Sparams[m_ID].shields;

	for(i = 0; i < MAX_STREL; i++) {
		m_naboje[i] = (Nparams[i].strel*vybaven)/100;
		m_narust[i] = Nparams[i].raise;
	}

	for(i = 0; i < MAX_BONUS; i++)
		m_bonusy[i] = 0;

	if (nesmrt) 
		m_bonusy[BON_NESMRT] = 20;

	m_lasthit = -1; 

	m_nrtf = 0; // aby moh hned po smrti zacit strilet (problem bazuky)
}

//////////////////////////////////////////////////////////////////////////////////
//                              NARAZOVE FUNKCE
//////////////////////////////////////////////////////////////////////////////////


bool GSoldier::HitBy(int strelaID, int demage, int who)
{
	if (strelaID == 1) m_bonusy[BON_ZMRAZEN] = 30;

	if (m_bonusy[BON_NESMRT]) return false;

	m_shield -= demage;
	if (m_shield < 0) {
		m_health += m_shield;
		m_shield = 0;
		m_animate |= ANIM_KREV; // animace krve
	}
	else  {
		m_animate |= ANIM_SHIELD; // animace stitu
	}
	if (m_health <= 0) return true;

	return false;
}

void GSoldier::CompMove(GRun *run, int ID)
{
	m_turnspeed = TURNSENSITIVE;
	m_AI.Move(run, ID);
}


/*////////////////////////////////////////////////////////////////////////////////
   Provede animaci
*/
void GSoldier::Animate()
{
	// stiti
	if (m_animate & ANIM_SHIELD)
		if (m_a_shield != 0) m_a_shield = MAX_STIT_ANIM-1; 

	// krev
	if (m_animate & ANIM_KREV)
		if (m_a_krev != 0) m_a_krev = MAX_KREV_ANIM-1; 

	// woda
	if (m_animate & ANIM_WATER) {
		if (m_a_water == -1) m_a_water = 0;
	}
	else m_a_water = -1;

	// zbran
	if (m_animate & ANIM_GUN) m_a_zbran++;
	if (m_a_zbran >= Zparams[m_zbran].anim) m_a_zbran = 0;

	// zablesk hlavne
	if (m_animate & ANIM_FIRE)
		m_a_fire = rand()%MAX_ZBRANE_FIRE;
	else 
		m_a_fire = -1;

	// nohy
	if (m_animate & ANIM_WALK) 
		if (m_a_nohy > MAX_WALK_BITMAPS-2) m_a_nohy = 0;
			else m_a_nohy++;
	else 
		if (m_animate & ANIM_RUN) 
			if (m_a_nohy > MAX_RUN_BITMAPS-2) m_a_nohy = 0;
				else m_a_nohy++;
		else m_a_nohy = 0; // ani jedna z animaci neplati

	m_animate = ANIM_RESET;
	m_animate = 0;
}
