// GMap.h: interface for the GMap class.
//
//////////////////////////////////////////////////////////////////////

#ifndef _G_MAP_INCLUDE_
#define _G_MAP_INCLUDE_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "GClasses.h"
#include "GStrela.h"
#include "GPowerUp.h"

#define MAX_POWERUPS_ON_MAP   10
#define MAX_STREL_ON_MAP    1000 // maximali pocet strel na mape

enum {
	TYPE_SMALL = 0,
	TYPE_LARGE
};

#define CAN_WALK_NO   0x0000
#define CAN_WALK_X    0x0001
#define CAN_WALK_Y    0x0002
#define CAN_WALK_ALL  0x0003



class GMap  // obasahuje kompletni mapu cele hry !!
{
public:
	void StopGame();
	void StartGame();
	void DrawStrely(BITMAP *dst, int CX, int CY, bool light, bool transparent);
	void DelStrelyFrom(int who);
	void NewNetStrela(int x, int y, int angle, int ID, int who);
	bool IsWater(int x, int y);
	bool LoadMap(int mapa, int svetlo);

	bool CanShoot(int x, int y, double angle, double speed, int level);
	int  CanWalk(int x, int y, double angle, double speed);
	bool CanMove(int x, int y, int level);

	void ClearGround();
	void GetFreePos(int *x, int *y, int dst);
	void InsertKilled(int x, int y, int ID, int smrt, int angle);
	void PickPowerUps(GRun *run);
	void NewPowerUp();
	bool Hit(GSoldier *sold, GStrela *strela, GRun *run);
	void ShootHits(GRun *run);
	void NewStrela(int x, int y, int angle, int ID, int who, double speed, int zbranID);
	void Destroy();
	void DestroyArrays();
	void Move(GRun *run);
	bool LoadGFX();
	// kreslici fce
	void Draw(BITMAP *dst, int CX, int CY, bool light);


	void InitDone();
	void Reset(int X, int Y);

	GMap();
	virtual ~GMap();

	BITMAP *m_bGround;    // pohrch podkladu
	BITMAP *m_bGroundZal; // zaloha pohrchu podkladu (aby slo vycistit mrtvoly)
	BITMAP *m_bWalk;      // mapa pruchodnosti - aby se mihl uzivatel podivat

	int     m_mode; // typ vykreslovani (TYPE_SMALL, TYPE_LARGE)

	int     m_mapa;

	int     m_mrtvol; // slouzi pri pocitani mrtvol - jejich pripadne pozdejsi vymazani

	int     m_sx; // velikost x pro hraci plochu
	int     m_sy; // velikost y pro hraci plochu

	GPowerUp  *m_power[MAX_POWERUPS_ON_MAP]; // pocet powerupu na mape
	int      m_nextpwr;  // jak dlouho zbyva do pridani dalsiho powerupu

	GStrela  m_strely[MAX_STREL_ON_MAP];
	int      m_strel;
	int      m_strelA; // naprosto celkovy pocet strel

private:
	void FillLargeGround();
	SAMPLE  *m_music; // hudba na pozadi mapy

};

#endif // #ifndef _G_MAP_INCLUDE_
