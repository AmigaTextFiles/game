// GMap.cpp: implementation of the GMap class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "GMap.h"
#include "GView.h"
#include "GRun.h"

#include "inifile.h"
extern st_inifile ini;


BITMAP *m_bstmp; // temp bitmapa pro kresleni strel

/*////////////////////////////////////////////////////////////////////////////////
  Konstruktor
*/
GMap::GMap()
{
	m_bGround = NULL;
	m_bWalk   = NULL;
	m_music   = NULL;

	int i;

	for(i = 0; i < MAX_STREL_ON_MAP; i++)
		m_strely[i].m_active = false;
	m_strel = 0;

	for(i = 0; i < MAX_POWERUPS_ON_MAP; i++)
			m_power[i] = NULL;

	m_nextpwr = 0;


	m_sx = 1280;
	m_sy = 1280;

	m_mode = 0;
}

/*////////////////////////////////////////////////////////////////////////////////
  Destruktor
*/
GMap::~GMap()
{
	DestroyArrays();
}

/*////////////////////////////////////////////////////////////////////////////////
  Smaze vsechna data a pripravi se na nove zadavani
  road   :  pocet bodu silnice
  object :  pocet objektu
*/
void GMap::Reset(int X, int Y)
{
	DestroyArrays();
	m_sx = X;
	m_sy = Y;
}

/*////////////////////////////////////////////////////////////////////////////////
  Oznamuje, ze byla hotova inicializace (pri nacitani ze souboru)
*/
void GMap::InitDone()
{
	if (m_mode == TYPE_LARGE)
		FillLargeGround();
	m_mrtvol = 0;
}
/*////////////////////////////////////////////////////////////////////////////////
  Znici alokovane bitmapy
*/


/*////////////////////////////////////////////////////////////////////////////////
  Kresli mapu - podklad (travu a silnice)
  CX  :  x-ova souradnice kamery
  CY  :  y-ova souradnice kamery
*/
void GMap::Draw(BITMAP *dst, int CX, int CY, bool light)
{
	int i;
	// podklad
	if (m_mode == 0)
		blit(m_bGround, dst, (CX - DF_X/2), (CY - DF_Y/2), 0, 0, DF_X, DF_Y);
	else 
		blit(m_bWalk, dst, (CX - DF_X/2), (CY - DF_Y/2), 0, 0, DF_X, DF_Y);

	for(i = 0; i < MAX_POWERUPS_ON_MAP; i++)
		if (m_power[i] != NULL) m_power[i]->Draw(dst, CX, CY);

}

/*////////////////////////////////////////////////////////////////////////////////
  Nacte graficka data
*/
bool GMap::LoadGFX()
{
	// grafika se nacita az pri zadani levelu
	m_bstmp = create_bitmap(20,20);

	return (m_bstmp != NULL);
}
/*////////////////////////////////////////////////////////////////////////////////
  Pohne vsemi objekty
*/
void GMap::Move(GRun *run)
{
	int i;

	if(--m_nextpwr <= 0) 
		NewPowerUp();  // jak dlouho zbyva do pridani dalsiho powerupu


	m_strelA = 0;
	for(i = 0; i < MAX_STREL_ON_MAP; i++)
		if (m_strely[i].m_active) {
			m_strely[i].Move(this, run);
			m_strelA++;
		}

	if ((ini.mrtvol != 0) && (m_mrtvol > ini.mrtvol))
//	if ((m_mrtvol > 70))
		ClearGround();
}

/*////////////////////////////////////////////////////////////////////////////////
  Rusi pole m_objects
*/
void GMap::DestroyArrays()
{
	int i;

	for(i = 0; i < MAX_STREL_ON_MAP; i++)
		m_strely[i].m_active = false;
	m_strel = 0;

	for(i = 0; i < MAX_POWERUPS_ON_MAP; i++)
		if (m_power[i] != NULL) {
			delete m_power[i];
			m_power[i] = NULL;
		}
}

/*////////////////////////////////////////////////////////////////////////////////
  Testuje narazy - bere vsechna auticka a zkousi je na vsechny objekty
*/

void GMap::FillLargeGround(){

}

/*////////////////////////////////////////////////////////////////////////////////
  Nici bitmapy 
*/
void GMap::Destroy()
{
	if (m_bGround != NULL)
		destroy_bitmap(m_bGround);
	m_bGround = NULL;
	if (m_bGroundZal != NULL)
		destroy_bitmap(m_bGroundZal);
	m_bGroundZal = NULL;
	if (m_bWalk != NULL)
		destroy_bitmap(m_bWalk);
	m_bWalk = NULL;
	if (m_bstmp != NULL)
		destroy_bitmap(m_bstmp);
	m_bstmp = NULL;

	if (m_music != NULL)
		destroy_sample(m_music);
	m_music = NULL;
	DestroyArrays();
}

/*////////////////////////////////////////////////////////////////////////////////
  prida novou strelu
*/
void GMap::NewStrela(int x, int y, int angle, int ID, int who, double speed, int zbranID)
{
	m_strel++;
	int i;
	for(i = 0; i < MAX_STREL_ON_MAP; i++)
		if(!m_strely[i].m_active) break;
	if (i == MAX_STREL_ON_MAP) return;
	m_strely[i].Init(x,y,angle,ID,who, speed, zbranID);
}

/*////////////////////////////////////////////////////////////////////////////////
	Zkusi zasahy do hracu
*/
void GMap::ShootHits(GRun *run)
{
	int i, who = 0, ID;
	for(i = 0; i < MAX_STREL_ON_MAP; i++)
		if (m_strely[i].m_active) {
			who = m_strely[i].m_who;
			ID  = m_strely[i].m_ID;
			for( int k = 0; k < run->m_soldiers; k++) {
				if (!m_strely[i].m_active) break;
				if (Hit(&run->m_sold[k], &m_strely[i], run)) {
					if (!run->m_multi) {
						InsertKilled(run->m_sold[k].m_x, run->m_sold[k].m_y, run->m_sold[k].m_ID, Nparams[ID].dead, run->m_sold[k].m_angle);
						if((++run->m_sold[who].m_frags)%10 == 0) 
							run->m_view.AddFragsMess(who, run);
					}
					else 
					if (k == 0) {
//						run->m_net.SendFrag(who, Nparams[ID].dead);
						InsertKilled(run->m_sold[k].m_x, run->m_sold[k].m_y, run->m_sold[k].m_ID, Nparams[ID].dead, run->m_sold[k].m_angle);
					}
				}
			}
		}
}

/*////////////////////////////////////////////////////////////////////////////////
	Zda se dana strela trefila
*/
bool GMap::Hit(GSoldier *sold, GStrela *strela, GRun *run)
{
	GStrela *str = strela;
	bool ret = false;

	// aby hrac nezabil sam sebe
	if (sold->m_health <= 0) return false;
	if (str->m_who == sold->m_index) return false;


	// test narazu
	// testuje se pozice strely a naledujici a predchazenici v pohybu
	if (!strela->Hit(sold->m_x, sold->m_y, sold->m_dist)) return false;

	// zasah
	if ((ret = sold->HitBy(str->m_ID, str->GetDemage(this, run),str->m_who)) == true) {
		// vojak byl zabit - tak to oznamime
		run->m_view.AddKillMessage(str->m_who, sold->m_index, run);
	}

	// umazani strely 
	strela->m_active = false;

	return ret;
}

/*////////////////////////////////////////////////////////////////////////////////
	Prida do hry jeden dalsi bonus
*/
void GMap::NewPowerUp()
{
	int i;
	for(i = 0; i < MAX_POWERUPS_ON_MAP; i++) 
		if (m_power[i] == NULL) break;
	if (i == MAX_POWERUPS_ON_MAP) return;

	m_power[i] = new GPowerUp();

	int x,y;
	GetFreePos(&x, &y, 20);

	m_power[i]->Init(x, y, rand()%MAX_POWERUPS);

	m_nextpwr = 5+rand()%10;
}

/*////////////////////////////////////////////////////////////////////////////////
	Zajistuje zbirani powerupu
*/
void GMap::PickPowerUps(GRun *run)
{
	int i,j;
	for(i = 0; i < MAX_POWERUPS_ON_MAP; i++)
		if (m_power[i] != NULL)
			for( int k = 0; k < run->m_soldiers; k++) {
				if (m_power[i] == NULL) break;
				j = m_power[i]->m_ID;
				if (m_power[i]->Picked(&run->m_sold[k], &m_power[i])) {
					if (k == run->m_monsol) run->m_view.AddBonMessage(j);
					break;
				}
			}
}

/*////////////////////////////////////////////////////////////////////////////////
	Vlozi mrtvolu vojaka na zem
*/
void GMap::InsertKilled(int x, int y, int ID, int smrt, int angle)
{
	m_mrtvol++;
	rotate_sprite(m_bGround, b_deads[ID][smrt],  x-20, y-20, itofix(-angle));
}

/*////////////////////////////////////////////////////////////////////////////////
	Vrati volnou pozici na mape
*/
void GMap::GetFreePos(int *x, int *y, int dst)
{
	do {
		*x = rand()%m_sx-80;
		*y = rand()%m_sy-80;
	} while (!CanMove(*x, *y, 1));
}

/*////////////////////////////////////////////////////////////////////////////////
	Vrati zda je dana pozice pristrelna
*/
bool GMap::CanMove(int x, int y, int level)
{
	int mlevel = getpixel(m_bWalk, x, y);
	
	if (mlevel == -1) return false;
	if (mlevel > level)  return false;
	return true;
}

/*////////////////////////////////////////////////////////////////////////////////
	Cisti plochu od mrtvol
*/
void GMap::ClearGround()
{
	m_mrtvol = 0;
	draw_sprite(m_bGround, m_bGroundZal, 0, 0);
}

/*////////////////////////////////////////////////////////////////////////////////
	Zda se da jit danym smerem 
*/
int GMap::CanWalk(int x, int y, double angle, double speed)
{
	// tes X souradnice a Y souradnice, ale zvlast
	double cx = cos(angle);
	double sy = sin(angle);

	bool podm = true;

	int ds;
	if (speed < 0) ds = -1;
	else ds = 1;

	for (int i = ds ; abs(i) <= abs(speed); i += ds)
		if (!CanMove(x+cx*i, y-sy*i, 1)) podm = false;

	if (!CanMove(x+cx*speed, y-sy*speed, 1)) podm = false;

	if (podm == false) {
		int ret = CAN_WALK_ALL;
		for (int j = ds; abs(j) <= abs(speed+ds); j += ds) {
			if (!CanMove(x+cx*j,y, 1)) ret &= ~CAN_WALK_X;
			if (!CanMove(x,y-sy*j, 1)) ret &= ~CAN_WALK_Y;
		}
		if (ret == CAN_WALK_ALL) 
			if (rand()%2 == 1) ret = CAN_WALK_X;
			else ret = CAN_WALK_Y;
		return ret;
	}

	return CAN_WALK_ALL;
}

/*////////////////////////////////////////////////////////////////////////////////
	Vrati zda je mozne strilet danym smerem
*/
bool GMap::CanShoot(int x, int y, double angle, double speed, int level)
{
	// test X souradnice a Y souradnice naraz
	double cx = cos(angle);
	double sy = sin(angle);
	int i;

	for (i = 1 ; i < speed; i += 2)
		if (!CanMove(x+cx*i, y-sy*i, level)) return false;

	if (!CanMove(x+cx*speed, y-sy*speed, level)) return false;

	return true;
}

/*////////////////////////////////////////////////////////////////////////////////
	nacte danou mapu
*/
bool GMap::LoadMap(int mapa, int svetlo)
{
	Destroy();
	char s[70];

	draw_loading();

	sprintf(s, "maps/map%d.jpg", mapa);
	if (!(m_bGround    = hload_bitmap(s))) return false;

	
	if (svetlo == GFX_LOADED_DARK) {
		hfade_sprite(m_bGround);
	}

	if (!(m_bGroundZal = create_bitmap(m_bGround->w, m_bGround->h))) return false;
	draw_sprite(m_bGroundZal, m_bGround, 0, 0);

	sprintf(s, "maps/map%db.pcx", mapa);
	if (!(m_bWalk   = hload_bitmap(s))) return false;

	m_sx = m_bGround->w;
	m_sy = m_bGround->h;

	int col0 = makecol(  0,   0, 255);
	int col1 = makecol(255, 255, 255);
	int col2 = makecol(  0, 255,   0);
	int col3 = makecol(255,   0,   0);
	int col4 = makecol(  0,   0,   0);

	int i,j;
	for(i = 0; i < m_sx; i++) {
		for (j = 0; j < m_sy-DF_SOLD_Y/2-85; j++) {
			int col = getpixel(m_bWalk, i, j);
			int level = 0;
			if (col == col0) level =  0;
			if (col == col1) level =  1;
			if (col == col2) level =  2;
			if (col == col3) level =  3;
			if (col == col4) level =  4;

			putpixel(m_bWalk, i, j, level);
		}
		for (; j < m_sy; j++) {
			int col = getpixel(m_bWalk, i, j);
			int level = 0;
			if (col == col0) level =  2;
			if (col == col1) level =  2;
			if (col == col2) level =  2;
			if (col == col3) level =  3;
			if (col == col4) level =  4;

			putpixel(m_bWalk, i, j, level);
		}
	}

	m_mapa = mapa;

	sprintf(s, "maps/map%d.wav", mapa);
	if ((m_music = load_wav(s)) == NULL) {
		sprintf(s, "/usr/local/share/kulic/maps/map%d.wav", mapa);
		if ((m_music = load_wav(s)) == NULL) {
			sprintf(s, "/usr/share/kulic/maps/map%d.wav", mapa);
			m_music = load_wav(s);
		}
	}

	return true;
}

/*////////////////////////////////////////////////////////////////////////////////
	Vrati zda je na danem miste voda
*/
bool GMap::IsWater(int x, int y)
{
	int col = getpixel(m_bWalk, x, y);
	if (col == makecol(0,0,255)) return true;
	return false;
}

/*////////////////////////////////////////////////////////////////////////////////
	Aktivuje novou strelu, kterou nam poslal kolega z multiplyeru
*/
void GMap::NewNetStrela(int x, int y, int angle, int ID, int who)
{
	m_strel++;
	int i;
	for(i = 0; i < MAX_STREL_ON_MAP; i++)
		if(!m_strely[i].m_active) break;
	if (i == MAX_STREL_ON_MAP) return;
	m_strely[i].InitMulti(x, y, angle, ID, who);
}

/*////////////////////////////////////////////////////////////////////////////////
	Smaze vsechny strely daneho hrace
*/
void GMap::DelStrelyFrom(int who)
{
	for (int i = 0; i < MAX_STREL_ON_MAP; i++)
		if (m_strely[i].m_active && (m_strely[i].m_who == who)) {
			m_strely[i].m_active = false;
			m_strel--;
		}
}

/*////////////////////////////////////////////////////////////////////////////////
	Nakresli strely
*/
void GMap::DrawStrely(BITMAP *dst, int CX, int CY, bool light, bool transparent)
{
	// kresleni strel
	set_trans_blender(  0, 0, 0, 128);
	for(int i = 0; i < MAX_STREL_ON_MAP; i++)
		if(m_strely[i].m_active) m_strely[i].Draw(dst, CX, CY, m_bstmp, light, transparent);
}

void GMap::StartGame()
{
	if(ini.hudba && m_music)
		play_sample(m_music, 255, 128, 1000, 1);
}

void GMap::StopGame()
{
	if(ini.hudba && m_music)
		stop_sample(m_music);
}
