// GRun.h: interface for the GRun class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _G_RUN_INCLUDE_
#define _G_RUN_INCLUDE_

#include "GClasses.h"
#include "GSoldier.h"
#include "GView.h"
#include "GMap.h"
//#include "GNet.h"
//#include "CDPlayer.h"
#include "GSShoots.h"

#define GFX_LOADED_NO     0
#define GFX_LOADED_NORMAL 1
#define GFX_LOADED_DARK   2 

typedef unsigned int DWORD;

class GRun  // hlavni trida hry - MUZE BYT JEN JEDNA INSTANCE TETO TRIDY !!!!!!!
{
public:
	void StartEffect();
	void Demo();
	bool LoadMasksBitmaps(BITMAP **pole, int kolik, int zacatek, char *file);
	void DestroyRunBitmaps();
	int  SearchForMaps(char * path);
	void DarkBitmaps(BITMAP **pole, int kolik);
	bool UpdateGFX(int type);
	bool LightGFX();
	bool DarkGFX();

	void UpdateInput();
	void Animate();
	void SetCurPlCtrl();
	void DestroyBitmaps(BITMAP **pole, int kolik);
	void InitDemo();
	void ProcessKeys();
	void CompMove();
	bool Init(int minAI, int maxAI);
	void InitSingle(int players);
	void Crash();
	void Move();
	void Draw();
	bool LoadGFX();
	void Destroy();
	bool LoadBitmaps(BITMAP **pole, int kolik, int zacatek, char *file); 
	void Run();
	GRun();
	virtual ~GRun();

	GView     m_view;                 // kamera
	GSoldier  m_sold[MAX_PLAYERS];    // vojaci
	GMap      m_map;                  // mapa objektu
//	GNet      m_net;
	GSShoots  m_sshoots;              // zvuky strel a explozi

	int       m_soldiers;              // pocet vojaku
	int       m_monsol;                // index monitorovaneho vojaka

	unsigned int     m_game_speed;            // urcuje rychlost hry v milisekundach

	bool    m_autorun;

	bool    m_server;	// zda je tento hrac ve hre server
	bool    m_multi;  // zda bezi multi player

	bool    m_kill_mee; // zda se hraje systemem - vsichni pocitace proti hraci

	int     m_gfx_loaded; // typ nactene grafiky

	int     m_mapa;   // cilslo mapy k nacteni
	int     m_maps;   // celkovy pocet map

	int     m_svetlo; // stav svetla

	bool    m_effects; // zapnuti efeku
	bool    m_lighteffects; // zapnuti efeku svetla
	// nastavovaci promene
	int     m_maxstrel;    // zba po smrti vojak dostane kolik % vybaveni
	bool    m_doruststrel; // zda probiha dorustani strel
};

#endif // #ifndef _G_RUN_INCLUDE_
