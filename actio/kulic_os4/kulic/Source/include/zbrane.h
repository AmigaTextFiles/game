#ifndef _ZBRANE_PARAMS_INCLUDE_
#define _ZBRANE_PARAMS_INCLUDE_

#include "shoots.h"

#define MAX_ZBRANE        7  // pocet zbrani
#define MAX_ZBRANE_FIRE   3  // pocet zbrani, ktere se meni pri vystrelu
#define MAX_STREL        10  // pocet druhu streliva
#define MAX_STREL_MASKS   6  // pocet masek pruhlednosti u streliva
#define MAX_POWERUPS     13  // pocet power-upu
#define MAX_ZBRAN_ANIM    6  // maximalni pocet animovacich policek pro zbran
#define MAX_KOUR          1  // pocet typu koure
#define MAX_KOUR_MASKS    8  // pocet masek koure
#define MAX_PLAMENU       2  // pocet bitmapek ohne

extern BITMAP*  b_strel[MAX_STREL];				// obrazky strel
extern BITMAP*  b_strely_mask[MAX_STREL_MASKS];				// masky polopruhlednosti u strel
extern BITMAP*  b_zbraneB[MAX_ZBRANE];				// velke obrazky zbrani
extern BITMAP*  b_zbrane[MAX_ZBRANE][MAX_ZBRAN_ANIM];				// male obrazky zbrani
extern BITMAP*  b_zbrane_fire[MAX_ZBRANE_FIRE];    // obrazky zablesku hlavni
extern BITMAP*  b_zbrane_fire_l[MAX_ZBRANE_FIRE];  // obrazky svetel pri strelbe
extern BITMAP*  b_powerups[MAX_POWERUPS];			// obrazky bonusu

extern BITMAP*  b_kour[MAX_KOUR];			// obrazky koure
extern BITMAP*  b_kour_mask[MAX_KOUR_MASKS];       // polopruhledny kour
extern BITMAP*  b_plamen[MAX_PLAMENU];  // plameny (za bazukou)

#define MAX_LIGHTS_MASKS 4
#define SOLDIER_SHADOW   3 // stin u vajaka
extern BITMAP*  b_lights_mask[MAX_LIGHTS_MASKS]; // masky svetel


// bonusy
#define MAX_BONUS 5
extern BITMAP*  b_s_bonus[MAX_BONUS];			// obrazky bonusu u vojaka

#define BON_ZRYCHLENI   0  // zrychli panacka
#define BON_INVIS       1  // neviditelnost
#define BON_NESMRT      2  // nesmrtelnost
#define BON_2KULBA      3  // dvojnasobna strelba
#define BON_ZMRAZEN     4  // zmrazeni


// powerupy
#define PUP_ZRYCHLENI   0  // zrychli panacka
#define PUP_INVIS       1  // neviditelnost
#define PUP_NESMRT      2  // nesmrtelnost
#define PUP_2KULBA      3  // dvojnasobna strelba

#define PUP_LEKARNA     4  // doplnuje stity, nebo zdravi
#define PUP_NABOJE      5  // doplnuje naboje

// parametry zbrani
typedef struct {
	char   name[15]; //jmeno pusky
	int    rate;  // rychlost strelby
	int    strelaID; // typ streliva
	int    angle;  // uhlovy rozptyl
	int    dx,dy;  // posun zacatku strelby (aby se strilelo opravdu z hlavne)
	double datan;  // uhel posunu
	int    ddst;   // delka posunu
	int    anim;   // pocet animaci zbrane
	bool   so;     // pouze pri strelbe
	bool   nad;    // zda se maji kreslit nad, nebo pod panacka
	int    light;  // id bitmpay svetla zbrane (-1 - zbran nesviti)
	bool   fire;   // zda zablesk hlavne a osvetleni okoli
	int    sound;  // id vystreleneho zvuku
} st_Zbrane_params;

// parametry strel
typedef struct {
	char    name[15];  // nazev
	double  speed;  // rychlost
	int     rspeed; // randomni pripocitani rychlosti - aby byly ybuchy napaditejsi
	int     demage;  // schopnost nicit
	int     dist;   // dolet
	int     rdist;  // velikost nahodneho doletu (aby vybuchy nemizely zcela naraz, ale postupne)
   int     rng;   // velikost vybuchu
	int     attime; // strel najednou
	int	  strel;  // max pocet strel (u vojaka)
	int     raise;  // rychlost dorustani naboju
	int     explosive;  // zda vybuchuje ( do kolika buchu )
	bool    target;  // automireni
	int     eID;     // id explozni strely
	int     dead;   // typ smrti
	int     level;  // vyska, ve ktere strela leti
	int     kour;   // delka koure za strelou
	int     light;  // id bitmpay svetla naboje (-1 == nesviti)
	int     mask;   // id masky polopruhlednosti (-1 == nema masku)
	int     expl;   // id zvuku vybuchu
} st_GStrela_params;

// parametry poweru-upu
typedef struct {
	char   name[20];  // nazev
	int    typ;       // typ power upu
	int    health;    // pocet zivotu, ktere pridava
	int    shields;   // kolik pridava stitu
	int    nID;       // ID naboju, ktere pridava
	int    cnt;       // kolik jich pridava
} st_powerups;




const st_Zbrane_params  Zparams[MAX_ZBRANE] = {
	{ "Kulomet",      1,  0,   10, 22, 8, -0.34, 23, 4, true,  false, -1, true,  SHOOT_KULOMET   },
	{ "Mrazak",       3,  1,    1, 23, 0,     0, 23, 4, false, false,  0, false, SHOOT_MRAZAK    },
	{ "Granatomet",   4,  2,    1, 20, 0,     0, 20, 1, true,  false, -1, false, SHOOT_GRANATOMET},
	{ "Plamenomet",   1,  4,    6, 30, 0,     0, 30, 3, false, false,  0, false, SHOOT_PLAMENOMET},
	{ "Elimonator",   3,  5,    1, 23, 0,     0, 23, 4, false, false,  0, false, SHOOT_ELIMINATOR},
	{ "Brok",        10,  7,   25, 22, 0,     0, 22, 1, false, false, -1, true,  SHOOT_BROKOVNICE},
	{ "Raketak",     20,  8,    0, 22, 6, -0.26, 23, 1, false, true,  -1, false, SHOOT_BAZOOKA},
};

const st_GStrela_params  Nparams[MAX_STREL] = {
	{ "Kulky",        38, 0,  35,  600, 30,  0,  2, 150, 10,   0, false, 0, 0, 2, 0, -1, -1, -1},
	{ "Led",          31, 0,  70,  500, 10,  0,  1, 100, 20,   0, false, 0, 1, 2, 0,  1,  0, -1},
	{ "Granat",       22, 0,   0,  200, 12, 50,  1,  30, 50,  20, false, 3, 2, 3, 0, -1, -1, SHOOT_GRANAT_BUM},
	{ "Granat buch",   3, 2,  15,   30,  7,  0,  1,   0,  0,   0, false, 0, 2, 3, 0,  2,  1, -1},
	{ "Plamen",       10, 0, 100,  200,  5,  0,  1, 130, 45,   0, false, 0, 3, 2, 0,  2,  2, -1},
	{ "Plazma",       29, 0,  50,  250,  8, 20,  1,  80, 30,   8, false, 6, 4, 2, 0,  1,  3, -1},
	{ "Plazma bum",    3, 2,  20,   20,  5,  0,  1,   0,  0,   0, false, 0, 4, 2, 0,  1,  4, -1},
	{ "Brok",         40, 0,  50,  300, 10,  0, 20,  30, 30,   0, false, 0, 5, 2, 0, -1, -1, -1},
	{ "Raketa",       25, 0, 590, 2000, 50, 70,  1,  10, 10,  24, false, 9, 6, 2, 8,  1, -1, SHOOT_BAZOOKA_BUM},
	{ "Raketa buch",   3, 4,  25,   40, 15,  0,  1,   0,  0,   0, false, 0, 6, 2, 0,  2,  5, -1},
};

const st_powerups Pparams[MAX_POWERUPS] = {
	{ "LEKARNU",         PUP_LEKARNA, 700,   0, 0,   0},
	{ "BATERKU",         PUP_LEKARNA,   0, 700, 0,   0},

	{ "ZASOBNIK",        PUP_NABOJE,    0,   0, 0,  50},
	{ "FREONY",          PUP_NABOJE,    0,   0, 1,  20},
	{ "GRANATY",         PUP_NABOJE,    0,   0, 2,  10},
	{ "KANISTR BENZINU", PUP_NABOJE,    0,   0, 4,  40},
	{ "PLAZMA KYSELINU", PUP_NABOJE,    0,   0, 5,  20},
	{ "CHUTNY BROK",     PUP_NABOJE,    0,   0, 7,  10},
	{ "PAR RAKET",       PUP_NABOJE,    0,   0, 8,   5},

	{ "STEREOIDY",       PUP_ZRYCHLENI, 0,   0, 0,  400},
	{ "ZNEVIDITELNOVAC", PUP_INVIS,     0,   0, 0,  200},
	{ "SUPER STIT",      PUP_NESMRT,    0,   0, 0,  100},
	{ "CHLADIC HLAVNE",  PUP_2KULBA,    0,   0, 0,  400},
};

#endif
