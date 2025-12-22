// GSoldier.h: interface for the GSoldier class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _G_SOLDIER_INCLUDE_
#define _G_SOLDIER_INCLUDE_

// includy
#include "GClasses.h"
#include "soldiers.h"
#include "GAI.h"
#include "zbrane.h"

// Ainmace
// pro GSoldier::m_animate
#define ANIM_RESET   0x00

#define ANIM_SHIELD  0x01  // animace zasah do stitu
#define ANIM_KREV    0x02  // animace zasahu do krve
#define ANIM_WATER   0x04  // animace behu ve vode
#define ANIM_GUN     0x08  // animace zbrane
#define ANIM_WALK    0x10  // animace chuze
#define ANIM_RUN     0x20  // animace behu
#define ANIM_FIRE    0x40  // zablesk u hlavne



#define TURNSENSITIVE  10.0
extern double turnsensitive;

// vlastni trida zapouzdrujici auta
class GSoldier  
{
public:
	void Animate();
	void CompMove(GRun *run, int ID);
	bool HitBy(int strelaID, int demage, int who);
  // aktualni nastaveni auta
   int    m_angle;     // uhel natoceni ( 0 == doprava vodorovne, dokola je 256 )
	double m_angleRad;  // uhel v radianech

	double m_x, m_y; // pozice
	double m_speed;  // rychlost
	int    m_health;  // zdravi;
	int    m_shield;  // stit
	int    m_frags;

	int    m_position; // poradi ve hre (0 == nejlepsi hrac - nejvice fragousku)


	// animace zasahu
	int    m_a_shield;
	int    m_a_krev;
	int    m_a_nohy;
	int    m_a_zbran;   // animace zbrane
	int    m_a_fire;    // animace strelby

	int    m_a_water;   // animace vody

	unsigned char   m_animate;   // po bytec, co se ma animovat


	int    m_dist; // polomer vojaka (pro zasah)
	int    m_zbran;
	int    m_tochange;

	int    m_nshield; // pro dorustani stitu
	int    m_nrtf;    // redy to fire

	int    m_sx, m_sy;  // rozmer mapy

	bool   m_active; // zda je vojak aktivni ( kdyz neni, tak ani nezavodi )


  // pozadavky ridice
	bool  m_fwd;    // chuze vpred
	bool  m_back;   // chuze vzad
	bool  m_left;   // zataceni vlevo
	bool  m_right;  // zataceni vpravo
	bool  m_sleft;   // chodi vlevo
	bool  m_sright;  // chodi vpravo
	bool  m_run;    // beha
	bool  m_shoot;  // strili
	bool  m_chzbran;   // chce zmenit zbran
	bool  m_liveup;    // chce vstat z mrtvych
	int   m_turnspeed; // pripouziti mysi - rychlost toceni


	// AI
	int   m_AI_l;   // uroven AI
	GAI   m_AI;

	int   m_lastkill;   // posledni zabity
	int   m_lastkilled; // poslednim zabytym
	int   m_lasthit;    // poslednim zasahly


	// vybaveni
	int   m_naboje[MAX_STREL];
	int   m_narust[MAX_STREL];
	bool  m_zbrane[MAX_ZBRANE];

	int   m_bonusy[MAX_BONUS];

	bool  m_dorustani;

  // init & nastavovaci fce 
	GSoldier();
	virtual ~GSoldier();
	void Init(int index, int x, int y, int zbran, bool dorust, int vybaven, GMap *map);
	void SetKeys(bool fwd, bool back, bool left, bool right, bool sleft, bool sright, bool run, bool shoot, bool chzbran, bool liveup);

  // graficke fce 
	bool LoadGFX();
	void Destroy();
	void Draw(BITMAP *dest, int x, int y, bool light, bool shadow);
	void RaiseFromDead(GMap *map, int vybaven, bool nesmrt);

	char m_name[50]; // jmeno hrace (vojaka)

	int m_ID; // ID v m_par
	int m_index;  // index v poli u GRun

  // pohybove fce 
	void Move(GRun *run);

  // fce pro narazy ( tech je )
   RECT   m_rect;  // vrcholy rotvane bitmapy auta (a s otocenim)
};

#endif // #ifndef _G_SOLDIER_INCLUDE_
