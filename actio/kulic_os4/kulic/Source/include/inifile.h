#ifndef _INIFILE_INCLUDE_
#define _INIFILE_INCLUDE_

#define INIFILE  "kulic.cfg"

#define CTRL_KEYB     0
#define CTRL_KEYMOUS  1

typedef struct {
// nastaveni obecne
	int   bpp;
	int   zvuky;
	int   zvuky_vol;
	int   hudba;
	int   hudba_vol;
	int   com;
	int   com_speed;
	char  ip[50];

	bool  cd; // zda ma byt hudba z cd

// vlastni
	int   ovladani;

// nastaveni pro menu
	int   postava;
	char  jmeno[60];
	int   mapa;
	int   pocitacu;
	int   autorun;
	int   zamerovac; 
	int   svetlo;   // hra noc/den; 1 == den, 2 == noc
	int   effects;  // ruzne efekty (svetlo)
	int   seffects; // efekty obrazovky (FadeDown a FadeUp)
	int   meffects; // efekty menu (vlneni)

// nastaveni hry
	int  killme;   // typ chovani pocitacu
	int   flipmode; // typ page flippingu
	int   mrtvol;   // pocet mrtvol, kdy se prekresli obrazovka
	int   resolution; // rozliseni pri hre 0 == 640*480;  1 = 320*240
	int  antialaising; // povoleni pouzivani anti-aliasingu
	int  nesmrt;   // docasna nesmrtelnost pri oziveni

	int  fps;  // zda se maji zobrazovat framy za sekundu
	int  feffect; // efekty prolinani jednotlivych obrazovek v menu

	float turnsen; // jemnost toceni

// nastaveni ve hre
	int minAI;  // minimalni inteligence
	int maxAI;  // maximalni inteligence

	int   rychlost; // 0 - noraml, 10 pomale
	
} st_inifile;



#endif // _INIFILE_INCLUDE_
