#ifndef _SOLDS_PARAMS_INCLUDE_
#define _SOLDS_PARAMS_INCLUDE_


#define DF_SOLD_X 20
#define DF_SOLD_Y 20

// globalni grafika
#define MAX_SOLDIERS  3  // celkovy pocet vojaku
#define MAX_SOLD_BITMAPS  3 // celkovy pocet bitmap ( i ruzbych odstinu )
#define MAX_DEADS_BITMAPS 7 // pocet mrtvol (odpovida poctu zbrani)

#define MAX_RUN_BITMAPS   8
#define MAX_WALK_BITMAPS  8
#define MAX_WATER_BITMAPS 3


// v stdh.cpp
extern BITMAP*  b_solds[MAX_SOLD_BITMAPS];  // bitmapy vojaku
extern BITMAP*  b_solds_big[MAX_SOLD_BITMAPS];  // bitmapy vojaku - velke do menu
extern BITMAP*  b_deads[MAX_SOLD_BITMAPS][MAX_DEADS_BITMAPS]; // bitmapy k objektum

// animace okolo vojacku
extern BITMAP*  b_s_run[MAX_RUN_BITMAPS];     // bitmapy nohou pri behu
extern BITMAP*  b_s_walk[MAX_WALK_BITMAPS];   // bitmapy nohou pri chuzi
extern BITMAP*  b_s_water[MAX_WATER_BITMAPS]; // bitmapy strikajici wody okolo vojaka


#define MAX_KREV_ANIM            5 // pocet krvavych bitmap
#define MAX_STIT_ANIM            5 // pocet bitmap stitu
extern  BITMAP* b_krev[MAX_KREV_ANIM];		// animace krve
extern  BITMAP* b_stit[MAX_STIT_ANIM];		// animace stitu

// parametry jednotlyvych modelu auta
// u sebe jsou parametry se stejnymi "jednotkami"
typedef struct {
  // technicke udaje
	double speed;  // rychlost vpred
	double speedB; // rychlost vzad

	double health;    // zdravi
	double shields;   // stity
	int    dshields;  // dorustani stitu
	
	double turning;  // rychlost toceni

  // graficke udaje
	int    bindex;  // index bitmapy;
} st_GSold_params;


const st_GSold_params  Sparams[MAX_SOLDIERS] = {
// lehky
	{ 8.5, -8,   100,  200, 5, 7, 0},
// stredni
	{   7, -7,   200,  300, 5, 6, 1},
// tezky
	{   5, -6,   300,  400, 5, 4, 2},
};


#endif // #ifndef _SOLDS_PARAMS_INCLUDE_
