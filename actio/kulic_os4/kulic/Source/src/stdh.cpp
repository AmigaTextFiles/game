
#include "stdh.h"
#include "soldiers.h"
#include "zbrane.h"

HScreen hscreen;


int   errno;     // sice nepouzivam, ale jinak bude unresolved exernal pri linkovani :)

char  errch[50]; // chybove hlaseni

int  DF_X = 640; // x-ove rozliseni obrazovky == 640
int  DF_Y = 480;  // y-ove rozliseni obrazovky == 480

volatile int  tmr = 0;  // 10-ms timer

BITMAP*  b_solds[MAX_SOLD_BITMAPS];    // bitmapy k objektum
BITMAP*  b_solds_big[MAX_SOLD_BITMAPS];  // bitmapy vojaku - velke do menu
BITMAP*  b_deads[MAX_SOLD_BITMAPS][MAX_DEADS_BITMAPS];   // bitmapy smrti k objektum
BITMAP*  b_s_run[MAX_RUN_BITMAPS];     // bitmapy nohou pri behu
BITMAP*  b_s_walk[MAX_WALK_BITMAPS];   // bitmapy nohou pri chuzi
BITMAP*  b_s_water[MAX_WATER_BITMAPS]; // bitmapy strikajici wody okolo vojaka
BITMAP*  b_s_bonus[MAX_BONUS];			// obrazky bonusu u vojaka

BITMAP*  b_krev[MAX_KREV_ANIM];				// animace krve
BITMAP*  b_stit[MAX_STIT_ANIM];				// animace stitu
BITMAP*  b_strel[MAX_STREL];				// obrazky strel
BITMAP*  b_strely_mask[MAX_STREL_MASKS];				// masky polopruhlednosti u strel
BITMAP*  b_zbraneB[MAX_ZBRANE];				// velke obrazky zbrani
BITMAP*  b_zbrane[MAX_ZBRANE][MAX_ZBRAN_ANIM];	// male obrazky zbrani (pod panackem)
BITMAP*  b_zbrane_fire[MAX_ZBRANE_FIRE];    // obrazky zablesku hlavni
BITMAP*  b_zbrane_fire_l[MAX_ZBRANE_FIRE];  // obrazky svetel pri strelbe
BITMAP*  b_powerups[MAX_POWERUPS];			// obrazky bonusu
BITMAP*  b_kour[MAX_KOUR];			// obrazky koure
BITMAP*  b_kour_mask[MAX_KOUR_MASKS];       // polopruhledny kour
BITMAP*  b_plamen[MAX_PLAMENU];  // plameny (za bazukou)


BITMAP*  b_lights_mask[MAX_LIGHTS_MASKS]; // masky svetel

DATAFILE *fonts; // fonty vseho druhu


// funkce na zjisteni hit - optimalizovane
// if (dist > pow((pow(abs(x-m_x),2)+pow(abs(y-m_y),2)),0.5)) return true; // strela zasah
// if (!IsOut(x, y, m_x, m_y, dist) return true;  // strela zasah

bool IsOut(int x1, int y1, int x2, int y2, int dst) {
	if (abs(x1-x2) * 0.8 > dst) return true;
	if (abs(y1-y2) * 0.8 > dst) return true;

	return false;
}


