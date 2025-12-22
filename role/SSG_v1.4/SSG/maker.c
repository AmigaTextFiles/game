/* $Revision Header built automatically *************** (do not edit) ************
**
** © Copyright by Thule Software
**
** File             : HardCore:Code/Project/SolarGen93/maker.c
** Created on       : Monday, 28.06.93 13:23:33
** Created by       : Nils Peter Sudmann
** Current revision : V1.4
**
**
** Purpose
** -------
**   - A random star-system generator based on the GURPS (tm)
**     system. Designed to be used with any sf-rpg.
**
** Revision V1.4
** --------------
** created on Mandag, 06.02.95 18:00:47  by  Nils Peter Sudmann.   LogMessage :
**   - Added extended help.
**
** Revision V1.3
** --------------
** created on Monday, 05.07.93 11:05:57  by  Nils Peter Sudmann.   LogMessage :
**   - Further enchantments. Removed a enforcer hit. Added info
**     about terrain and climate.
**
** Revision V1.2
** --------------
** created on Monday, 28.06.93 13:31:30  by  Nils Peter Sudmann.   LogMessage :
**   - AAArghh, lost the file 'intuition.c' and have therefore
**     decided to drop the GUI interface. CLI options added,
**     and a major cleanup of the code. Maybe I will return to GUI
**     later.
**
** Revision V1.1
** --------------
** created on ???  by  Nils Peter Sudmann.   LogMessage :
**   - Switched from the MegaTraveller (tm) system to GURPS (tm),
**     because the GURPS system was easier and produced more
**     details.
**
** Revision V1.0
** --------------
** created on ??? by  Nils Peter Sudmann.   LogMessage :
**     --- Initial release ---
**
*********************************************************************************/
#define REVISION "1.4"
#define REVDATE  "06.02.95"
#define REVTIME  "18:00:47"
#define AUTHOR   "Nils Peter Sudmann"
#define VERNUM   1
#define REVNUM   4
#define PROGNAME "SSG"

#include <exec/types.h>
#include <exec/memory.h>
#include <math.h>
#include "maker.h"
#include <proto/exec.h>
#include <proto/dos.h>
#include <dos/rdargs.h>
#include <math.h>
#include <time.h>
#include <dos.h>
#include <stdlib.h>
#include <stdio.h>

const char vs[]="$VER: "PROGNAME" "REVISION" ("REVDATE"/"REVTIME"/C)(c) "AUTHOR;

char * body1[26] = {"Alpha","Beta","Gamma","Delta","Epsilon","Zeta",
	"Eta","Theta","Iota","Kappa","Lambda","Mu","Nu","Xi","Omicron",
	"Pi","Rho","Sigma","Tau","Upsilon","Phi","Chi","Psi","Omega",
	"FO Alpha","FO Beta"
	};
char * body2[26] = {"Ay","Bee","See","Dee","Ee","Eff","Gee","Aitch",
	"Eye","Jay","Kay","Ell","Em","En","Oh","Pee","Cue","Are","Ess",
	"Tee","You","Vee","Double-You","Eks","Wye","Zee"
	};
char * press[8] = {"None","Trace","Very thin","Thin","Standard","Dense",
	"Very dense","Superdense"
	};
char * atype[5] = {"Reducing","Exotic","Standard","Polluted","Corrosive"};
char * agas[13] = {"Hydrogen","Methane","Carbon oxides","Nitrogen","Ammonia",
	"Chlorine","Fluorine","Oxygen","Nitrides","Sulfur components",
	"Water vapor","Pollution","Helium"
	};
char sclass[8] = {"OBAFGKM"};
char * scdesc[7] = {"Blue","Blue-white","White","Yellow-white","Yellow","Orange","Red"};
char * ssize[8] = {"Ia","Ib","II","III","IV","V","VI","D"};
char * ssdesc[8] = {"supergiant","supergiant","large giant","giant","subgiant","main sequence","subdwarf","dwarf"};
char * mine[MAX_MINERALS] = {
	"Gemstones/Ind. Crystals:",
	"Rare/Special Minerals  :",
	"Radioactives           :",
	"Heavy metals           :",
	"Industrial metals      :",
	"Light metals           :",
	};
char * mdes[5] = {"Very rare","Rare","Common","Plentiful","Very plentiful"};
char * cdes[11] = {"Scorched","Very hot","Hot","Tropical","Warm","Normal","Cool","Chilly","Cold","Very cold","Frozen"};
char * tdes[4] = {"Very flat (plains/steppe)","Flat (barren/desert)","Rough (hilly)","Very rough (mountainous/volcanic)"};
char * pdes[5] = {"radiation","too wet","too dry","gravity","climate"};
struct Star   star[MAX_STAR];

struct {
  int Avail;
  struct Satelite *planet;
  struct Satelite *moon[MAX_MOON];
  struct Star *star;
} Orbits[MAX_STAR][MAX_PLANET];

char  cgas[13];
int MemKey=0;
struct RDArgs *Args;
char *Filter,*SysName;
int Cheat,BioOnly;

struct StarData stardata[7][7] = {
		 70,790,1190, 16,0.2, 0, 0,-12,		/* Star O */
		 60,630, 950, 13,0.1, 0, 0,-12,
		  0,  0,   0,  0,  0, 0, 0,  0,
		  0,  0,   0,  0,  0, 0, 0,  0,
		  0,  0,   0,  0,  0, 0, 0,  0,
		 50,500, 750, 10,  0, 0, 0, -9,
		  0,  0,   0,  0,  0, 0, 0,  0,
		 50,500, 750, 10,0.2, 0, 0,-10,		/* Star B */
		 40,320, 480,6.3,0.1, 0, 0,-10,
		 35,250, 375,5.0,0.1, 5,19,-10,
		 30,200, 300,4.0,  0, 5,19,-10,
		 20,180, 270,3.8,  0, 5,19,-10,
		 10, 30,  45,0.6,  0,10,18, -9,
 		  0,  0,   0,  0,  0, 0, 0,  0,
		 30,200, 300,4.0,0.6, 5,20,-10,		/* Star A */
		 16, 50,  75,1.0,0.2, 5,20,-10,
		 10, 20,  30,0.4,  0, 5,20,-10,
		  6,  5, 7.5,  0,  0, 5,19,-10,
		  4,  4,   6,  0,  0,10,18,-10,
		  3,3.1, 4.7,  0,  0,15,17, -9,
		  0,  0,   0,  0,  0, 0, 0,  0,
		 15,200, 300,  4,0.8,10,20,-10,		/* Star F */
		 13, 50,  75,  1,0.2,10,20,-10,
		  8, 13,  19,0.3,  0,10,19, -9,
    2.5,2.5, 3.7,0.1,  0,10,18, -9,
		2.2,  2,   3,  0,  0,25,18, -9,
		1.9,1.6, 2.4,  0,  0,65,17, -8,
		  0,  0,   0,  0,  0, 0, 0,  0,
		 12,160, 240,3.1,1.4,25,20,-10,		/* Star G */
		 10, 50,  75,1.0,0.4,25,20,-10,
		  6, 13,  19,0.3,0.1,25,19, -9,
		2.7,3.1, 4.7,0.1,  0,25,18, -8,
		1.8,1.0, 1.5,  0,  0,30,17, -6,
		1.1,0.8, 1.2,  0,  0,90,16,  0,
		0.8,0.5, 0.8,  0,  0,90,13, +1,
		 15,125, 190,2.5,3.0,50,20,-10,		/* Star K */
		 12, 50,  75,  1,  1,90,20,-10,
		  6, 13,  19,0.3,0.2,90,19, -9,
		  3,  4, 5.9,0.1,  0,90,18, -7,
		2.3,  1, 1.5,  0,  0,90,17, -5,
		0.9,0.5, 0.6,  0,  0,90,16,  0,
		0.5,0.2, 0.3,  0,  0,90,13, +1,
		 20,100, 150,  2,  7,90,18,-10,		/* Star M */
		 16, 50,  76,  1,4.2,90,18,-10,
		  8, 16,  24,0.3,1.1,90,18, -9,
		  4,  5, 7.5,0.1,0.3,90,18, -6,
		  0,  0,   0,  0,  0, 0, 0,  0,
		0.3,0.1, 0.2,  0,  0,90,16, +1,
		0.2,0.1, 0.11,  0,  0,90,14, +2
	};

double orbitdis(starnr,orbit)
int starnr,orbit;
{
	double distance;
	if (orbit==0) distance=star[starnr].dcon;
	if (orbit==1) distance=star[starnr].dcon+star[starnr].bcon;
	if (orbit>1)  distance=star[starnr].dcon+(1<<(orbit-1))*star[starnr].bcon;
	return(distance);
}

void mstar(starnr,mstarnr,orbit)	/* star, mother star, orbit */
int starnr,mstarnr,orbit;
{
	int a,b;
	if (starnr!=0)
		if (Orbits[mstarnr][orbit].Avail!=NO_OBJECT) {
      star[starnr].orbit=orbit;
      Orbits[mstarnr][orbit].star=&star[starnr];
      star[starnr].orbdis=orbitdis(mstarnr,orbit)*(rnd(13)+94)/100;
    } else return;
  else star[starnr].orbit=-1;

	b=rnd(100)+1;
	a=b-star[mstarnr].type*13;
	if (b>14 && a<15) a=15;

	if (a<15)         star[starnr].type=7;
	if (a<25 && a>14) star[starnr].type=6;
	if (a<85 && a>24) star[starnr].type=5;
	if (a<92 && a>84) star[starnr].type=4;
	if (a<97 && a>91) star[starnr].type=3;
	if (a<99 && a>96) star[starnr].type=2;
	if (a==99)        star[starnr].type=1;
	if (a==100)       star[starnr].type=0;

	a=rnd(100)+1;
	a=a-star[mstarnr].size*12;

	if (star[starnr].type==5) {
		if (a<53)         star[starnr].size=6;
		if (a<63 && a>52) star[starnr].size=5;
		if (a<73 && a>62) star[starnr].size=4;
		if (a<83 && a>72) star[starnr].size=3;
		if (a<93 && a>82) star[starnr].size=2;
		if (a<97 && a>92) star[starnr].size=1;
		if (a>96)         star[starnr].size=0;
	}
	if (star[starnr].type<5) {
		if (a<11)         star[starnr].size=6;
		if (a<41 && a>10) star[starnr].size=5;
		if (a<71 && a>40) star[starnr].size=2;
		if (a<91 && a>70) star[starnr].size=1;
		if (a>90)         star[starnr].size=0;
		if (star[starnr].size==0 && star[starnr].type>1)  star[starnr].type=1;
		if (star[starnr].size==6 && star[starnr].type==4) star[starnr].type=5;
	}
	if (star[starnr].type==6) {
		if (a<61)         star[starnr].size=6;
		if (a<81 && a>60) star[starnr].size=5;
		if (a>80)         star[starnr].size=4;
	}
	star[starnr].mother=mstarnr;
	star[starnr].spec=rnd(10);
	if (star[starnr].size==6 && star[starnr].type==6) star[starnr].bcon=(double)(rnd(11)+20)/100;
		else star[starnr].bcon=(double)(rnd(11)+30)/100;
	star[starnr].dcon=(double)(rnd(5)+1)/10;
	a=0;
	while (stardata[star[starnr].size][star[starnr].type].inner>orbitdis(starnr,a)) {
		Orbits[starnr][a].Avail=NO_OBJECT;
		a++;
	}
	if (rnd(100)<stardata[star[starnr].size][star[starnr].type].planets)
		a=rnd(stardata[star[starnr].size][star[starnr].type].number)+1; else
		a=0;
	for (b=a;b<MAX_PLANET;b++) Orbits[starnr][b].Avail=NO_PLANET;
	if (starnr!=0) {
		for (b=0;b<MAX_PLANET;b++)
			if (orbitdis(mstarnr,b)>orbitdis(mstarnr,orbit)/3 &&
        orbitdis(mstarnr,b)<orbitdis(mstarnr,orbit)*3)
				Orbits[mstarnr][b].Avail=NO_OBJECT;
		for (b=0;b<MAX_PLANET;b++)
			if (orbitdis(starnr,b)>orbitdis(mstarnr,orbit)/3)
        Orbits[starnr][b].Avail=NO_OBJECT;
	}
}

void stars()
{
	int a,b,o1,o2,o3;
	for (a=0;a<MAX_STAR;a++) {
    star[a].orbit=-2;
    star[a].type=0;
    star[a].spec=0;
    star[a].age=rnd(9); /* do something!!!!!!!!!!!!!!!!!!!!!!!!!!*/
		for (b=0;b<MAX_PLANET;b++)
			Orbits[a][b].Avail=AVAILABLE;
  }
  mstar(0,0,0);

  a=rnd(100)+1;
	if (a>60) {
		if (rnd(4)==3) o1=rnd(13)+7; else o1=rnd(6)+1;
		mstar(1,0,o1);
	}
	if (a>90) {
		if (o1<7) {
			o2=rnd(13)+7;
			mstar(2,0,o2);
		} else {
			o2=rnd(6)+1;
			b=rnd(2);
			mstar(2,b,o2);
		}
	}
	if (a>95) {
		o3=rnd(6)+1;
		if (o2>6) mstar(3,2,o3); else
			if (b==0) mstar(3,1,o3); else mstar(3,0,o3);
	}
}

void size(starnr,orbit)
int starnr,orbit;
{
	int w,moons,siz;
	double size,orbdis;
	struct Satelite *NewPlanet=NULL,*NewMoon=NULL;

	if (Orbits[starnr][orbit].Avail==AVAILABLE) {
		orbdis=orbitdis(starnr,orbit)*(rnd(13)+94)/100;
		if (orbdis<stardata[star[starnr].size][star[starnr].type].ibio) {
			switch (rnd(20)) {
				case 0:
				case 1:
				case 2:
				case 3:
				case 4:
					siz=0;
					break;
				case 14:
				case 15:
				case 16:
				case 17:
					switch (rnd(6)) {
						case 0: siz=-1; break;
						case 1:
						case 2:
						case 3: siz=-2; break;
						case 4:
						case 5: siz=-3; break;
					} break;
				case 18:
				case 19:
					if (orbit!=0) siz=rnd(100000)+200000;
				  break;
				default:
					siz=rnd(MAX_PLANET_SIZE)+1;
			}
		} else if (orbdis>stardata[star[starnr].size][star[starnr].type].obio) {
			switch (rnd(10)) {
				case 0:
				case 1:
					siz=0;
					break;
				case 2:
					switch (rnd(6)) {
						case 0: siz=-1; break;
						case 1:
						case 2:
						case 3: siz=-2; break;
						case 4:
						case 5: siz=-3; break;
					} break;
				case 5:
				case 6:
				case 7:
				case 8:
				case 9:
					switch (rnd(8)) {
						case 0:
							siz=rnd(100000)+200000;
							break;
						case 1:
						case 2:
							siz=rnd(40000)+40000;
							break;
						case 3:
						case 4:
							siz=rnd(50000)+80000;
							break;
						case 5:
						case 6:
						case 7:
							siz=rnd(70000)+130000;
							break;
					} break;
				default:
					siz=rnd(MAX_PLANET_SIZE)+1;
			}
		} else {
      if (Cheat) w=10; else w=rnd(20);
			switch (w) {
				case 0:
				case 1:
				case 2:
				case 3:
					siz=0;
					break;
				case 14:
				case 15:
				case 16:
				case 17:
					switch (rnd(6)) {
						case 0: siz=-1; break;
						case 1:
						case 2:
						case 3: siz=-2; break;
						case 4:
						case 5: siz=-3; break;
					} break;
				case 18:
					siz=rnd(100000)+200000;
					break;
				case 19:
					siz=rnd(70000)+130000;
					break;
				default:
					siz=rnd(MAX_PLANET_SIZE)+1;
			}
		}
		if (siz!=0) {
			NewPlanet=NEW(struct Satelite);
      Orbits[starnr][orbit].planet=NewPlanet;
      NewPlanet->diameter=siz;
      NewPlanet->orbdis=orbdis;
      NewPlanet->star=starnr;
      NewPlanet->orbit=orbit;
      NewPlanet->sorbit=-1;
		}
		if (NewPlanet!=NULL) {
			moons=0;
			if (NewPlanet->diameter>0) moons=rnd(10)-5;
			if (NewPlanet->diameter>MAX_PLANET_SIZE) moons=rnd(11);
			if (NewPlanet->diameter>80000) moons=rnd(11)+5;
			if (NewPlanet->diameter>130000) moons=rnd(11)+10;
			if (NewPlanet->diameter>200000) moons=rnd(6)+15;
			if (moons>0) for (w=0;w<moons;w++) {
				size=calcbas((double)rnd(11));
				if (size<0.005) size=0.005;
				size=calcsiz(size,(double)NewPlanet->diameter);
				size=size*(rnd(41)+80)/100;
        if (size>MAX_PLANET_SIZE) size=MAX_PLANET_SIZE-rnd(500);
        if (size<1) size=1;
				NewMoon=NEW(struct Satelite);
        Orbits[starnr][orbit].moon[w]=NewMoon;
				NewMoon->diameter=(int)size;
        NewMoon->orbdis=orbdis;
        NewMoon->orbit=orbit;
        NewMoon->sorbit=w;
        NewMoon->star=starnr;
			}
		}
	}
}

void density(object)
struct Satelite *object;
{
	if (object->diameter>MAX_PLANET_SIZE) {
		object->density=(double)(rnd(20)+6)/10-(star[object->star].age-5)*.2;
		if (object->density>2.5) object->density=2.5;
		if (object->density<0.6) object->density=0.6;
	} else {
		object->density=(double)(rnd(56)+23)/10-(star[object->star].age-5)*.2;
		if (object->density>7.8) object->density=7.8;
		if (object->density<2.3) object->density=2.3;
	}
}

void axial(object)
struct Satelite *object;
{
	int a;
	a=rnd(100)+1;
	if (a<19)		  object->axial=0;
	if (a>18 && a<57) object->axial=rnd(20)+1;
	if (a>56 && a<85) object->axial=rnd(12)+21;
	if (a>84 && a<93) object->axial=rnd(20)+33;
	if (a>92)		  object->axial=rnd(50)+53;
	if (object->axial>90) object->axial=90;
}

void daylength(object)
struct Satelite *object;
{
	int a;
	a=rnd(8)-1;
	if (object->orbit==0) a=a+3;
	if (object->orbit==1) a=a+2;
	if (object->diameter<EARTHSIZE/2) a++;
	if (object->diameter<EARTHSIZE*3) a--;
	if (object->diameter<EARTHSIZE*6) a--;
	if (object->diameter<EARTHSIZE*9) a--;
	if (a<0) a=0;
	if (a>7) a=7;
	object->daylength=rnd(16<<a)+((16<<a)*2/10);
}

void atmos(object)
struct Satelite *object;
{
	int a,b,c,gas;
	a=rnd(10);
	a=a+(object->diameter/EARTHSIZE-1)*5;
	if (object->orbdis>stardata[star[object->star].size][star[object->star].type].obio) a=a-3;
	if (object->orbdis>stardata[star[object->star].size][star[object->star].type].obio*3) a--;
	if (object->orbdis>stardata[star[object->star].size][star[object->star].type].obio*6) a--;
	if (object->orbdis>stardata[star[object->star].size][star[object->star].type].obio*9) a--;
	if (star[object->star].size==5) a--;
	if (star[object->star].size==6) a=a-2;
	if (a<0) a=0;
	switch (a) {
		case 0: object->atmospress=0; break;
		case 1: object->atmospress=1; break;
		case 2:	object->atmospress=2; break;
		case 3:	object->atmospress=3; break;
		case 4:
		case 5:
		case 6: object->atmospress=4; break;
		case 7: object->atmospress=5; break;
		case 8: object->atmospress=6; break;
		default: object->atmospress=7; break;
	}
	for (a=0;a<13;a++) cgas[a]=-1;
	for (a=0;a<MAX_GAS;a++) object->atmosgas[a]=-1;
	a=rnd(10);
	if (object->atmospress==7) a=3;
	if (object->diameter>MAX_PLANET_SIZE) a=-1;
	if (object->atmospress>0)
		switch (a) {
			case -1:
				cgas[0]=0;
				cgas[12]=1;
				cgas[1]=2;
				break;
			case 0:
			case 1:
			case 2:
				cgas[0]=0;
				cgas[2]=1;
				cgas[1]=2;
				break;
			case 3:
				a=rnd(MAX_GAS)+1;
				for (c=0;c<a;c++) {
					b=rnd(6);
					if (object->orbdis<stardata[star[object->star].size][star[object->star].type].obio) b++;
					if (object->orbdis<stardata[star[object->star].size][star[object->star].type].ibio) b++;
					switch (b) {
						case 0:
							gas=0;
							break;
						case 1:
							gas=1;
							break;
						case 2:
							gas=2;
							break;
						case 3:
							b=rnd(6)+3;
							if (object->orbdis<stardata[star[object->star].size][star[object->star].type].obio) b++;
							if (object->orbdis<stardata[star[object->star].size][star[object->star].type].ibio) b++;
							if (b<4) b=4;
							gas=b;
							break;
						default:
							gas=3;
					}
					if (cgas[gas]!=-1) c--; else cgas[gas]=c;
				}
				break;
			case 4:
			case 5:
			case 6:
				cgas[3]=0;
				cgas[7]=1;
				break;
			case 7:
				cgas[3]=0;
				cgas[7]=1;
				cgas[11]=2;
				break;
			default:
				a=rnd(MAX_GAS)+1;
				for (c=0;c<a;c++) {
					b=rnd(6)+3;
					if (object->orbdis<stardata[star[object->star].size][star[object->star].type].obio) b++;
					if (object->orbdis<stardata[star[object->star].size][star[object->star].type].ibio) b++;
					if (b<4) b=4;
					gas=b;
					if (cgas[gas]!=-1) c--; else cgas[gas]=c;
				}
		}
	for (a=0;a<MAX_GAS;a++)
		for (b=0;b<13;b++)
			if (cgas[b]==a) {
				object->atmosgas[a]=b;
				if (a==0) object->atmosper[a]=rnd(25)+65;
				if (a==1) object->atmosper[a]=98-object->atmosper[0];
				if (a>1) object->atmosper[a]=1;
			}

}

void climate(object)
struct Satelite *object;
{
	object->climate=(int) 2 + 7*
    ((object->orbdis-stardata[star[object->star].size][star[object->star].type].ibio)/
    (stardata[star[object->star].size][star[object->star].type].obio-
		stardata[star[object->star].size][star[object->star].type].ibio)); /* +object->atmospress*12);*/
/*  if (object->climate>10) object->climate=10;
  if (object->climate<0) object->climate=0;*/
}

void watersurf(object)
struct Satelite *object;
{
	object->liquidsurf=rnd(101);
}

void humidity(object)
struct Satelite *object;
{
	object->humidity=rnd(9)*10+object->liquidsurf/4-(object->climate-5)*5;
	if (object->humidity>100) object->humidity=100;
  if (object->humidity<1) object->humidity=1;
}

void terrain(object)
struct Satelite *object;
{
  int terrain;
  terrain=rnd(4);
  terrain-=object->atmospress-4;
  terrain+=object->density-5;
	object->terrain[0]=terrain<0?0:terrain>3?3:terrain;
  while ((object->terrain[1]=rnd(4))==object->terrain[0]);
}

void minerals(object)
struct Satelite *object;
{
	int a,b;
	for (a=0;a<MAX_MINERALS;a++) {
		b=rnd(11);
		if (a!=6) {
			b=b-3;
			if (object->density>=3.1) b=b+2;
			if (object->density>=6.1) b=b+3;
			if (object->density>=7.1) b=b+2;
			if (object->liquidsurf>=90) b--;
			if (object->liquidsurf<=30) b++;
		}
		switch (a) {
			case 0: b-=3; break;
			case 1: b-=2; break;
			case 2: b-=2; break;
			case 3: b--;  break;
			case 4: b++;  break;
			case 5: b+=3; break;
		}
		if (b<4) b=4;
		switch (b) {
			case 4: object->minerals[a]=0; break;
			case 5:
			case 6: object->minerals[a]=1; break;
			case 7: object->minerals[a]=2; break;
			case 8:
			case 9: object->minerals[a]=3; break;
			default: object->minerals[a]=4; break;
		}
	}
}

int lifechance(object)
struct Satelite *object;
{
  int terra=100;
  /*
  dis=object->orbdis;
  if (dis<stardata[star[object->star].size][star[object->star].type].ibio ||
    dis>stardata[star[object->star].size][star[object->star].type].obio) return(0);
  */
  if (grav(object->diameter,object->density)<1)
    terra-=pow(2-grav(object->diameter,object->density),3.0)*10;
  else
    terra-=pow(grav(object->diameter,object->density),3.0)*10;
  if (object->density<=3.0) terra-=20;
  if (object->density>=6.1) terra-=20;
  if (object->density>=7.1) terra-=20;
  terra-=abs(5-object->climate)*5;
  terra+=stardata[star[object->star].size][star[object->star].type].life*3;
  return(terra<0?0:terra);
}


void tabs(n)
int n;
{
	int t;
	for (t=0;t<n;t++) printf("\t");
}

void output_world(object)
struct Satelite *object;
{
  int check,siz,t,tag;
  double year;

  if (object->tag!=0) {
    tag=object->tag;
    t=1;
  } else {
    tag=Orbits[object->star][object->orbit].planet->tag;
    t=2;
  }

	siz=object->diameter;
  if (siz<0) {
    tabs(t);
		if (siz==-1) printf("Type M Asteroid belt.\n");
    if (siz==-2) printf("Type S Asteroid belt.\n");
	  if (siz==-3) printf("Type C Asteroid belt.\n");
  } else {

    tabs(t-1);
    printf("Orbit: %2d%c '%s %s %s",object->orbit+1,'A'+object->sorbit,body1[object->star],SysName,body1[tag-1]);
    if (object->sorbit==-1) printf("'. "); else printf(" %s'. ",body2[object->sorbit]);

    if (object->sorbit==-1) {
      if (siz<=4500) printf("Small Planet.\n");
			if (siz>4500 && siz<=9000) printf("Medium Planet.\n");
			if (siz>9000 && siz<=13500) printf("Large Planet.\n");
			if (siz>13500 && siz<=MAX_PLANET_SIZE) printf("Huge Planet.\n");
    } else {
      if (siz<=600) printf("Moonlet.\n");
			if (siz>600 && siz<=1200) printf("Small Moon.\n");
			if (siz>1200 && siz<=3000) printf("Medium Moon.\n");
			if (siz>3000 && siz<=6000) printf("Large Moon.\n");
			if (siz>6000) printf("Huge Moon.\n");
    }
  	if (siz>=40000 && siz<80000) printf("Small Gas Giant.\n");
		if (siz>=80000 && siz<130000) printf("Medium Gas Giant.\n");
  	if (siz>=130000 && siz<200000) printf("Large Gas Giant.\n");
	  if (siz>=200000) printf("Huge Gas Giant.\n");
    if (!((!strcmpi(Filter,"LIGHT") && siz<=1000) ||
        (!strcmpi(Filter,"MEDIUM") && siz<=3000) ||
        (!strcmpi(Filter,"HEAVY") && siz<=6000))) {
    	tabs(t); printf("Size: %6d km.\n",siz);
	   	tabs(t); printf("Density: %1.1f g/cm³.\n",object->density);
	    tabs(t); printf("Gravity: %1.2f G.\n",grav(siz,object->density));
    	tabs(t); printf("Axial Tilt:%2d°.\n",object->axial);
	   	tabs(t); printf("Daylength:%4d hours.\n",object->daylength);
      year=yearl(Orbits[object->star][object->orbit].planet->orbdis,stardata[star[object->star].size][star[object->star].type].mass);
      tabs(t); printf("Yearlength:%d days.",(int)((year*365*24)/object->daylength));
      printf(" (%1.2f earth years.)\n",year);
	    tabs(t); printf("Atmospress:%s.\n",press[object->atmospress]);
    	for (check=0;check<MAX_GAS;check++)
	    	if (object->atmosgas[check]!=-1) {
		   		tabs(t);
  		  	printf(" -%s %d%%. \n",agas[object->atmosgas[check]],object->atmosper[check]);
    			}
      if (siz<=MAX_PLANET_SIZE) {
        tabs(t); printf("Primary terrain: %s.\n",tdes[object->terrain[0]]);
        tabs(t); printf("Secondary terrain: %s.\n",tdes[object->terrain[1]]);
        tabs(t); printf("++++ Resources ++++ \n");
	    	for (check=0;check<6;check++) {
           tabs(t); printf("- %s %s.\n",mine[check],mdes[object->minerals[check]]);
        }
        tabs(t); printf("++++ If terraformed ++++\n");
        tabs(t); printf("- Average climate: %s.\n",cdes[object->climate<0?0:object->climate>10?10:object->climate]);
        tabs(t); printf("- Air humidity: %d%%.\n",object->humidity);
        tabs(t); printf("- Liquid surface: %d%%\n",object->liquidsurf);
        tabs(t); printf("- Terra life suitabillity: %d%%.\n",lifechance(object));
      }
    }
  }
}

void output_orbit(starnr,orbit)
int starnr,orbit;
{
	double dis;

  if (Orbits[starnr][orbit].star!=NULL) {
    dis=Orbits[starnr][orbit].star->orbdis;
    printf("Orbit: %2d. Distance: %1.1f million km. (%1.2f AU) ; ",
      orbit+1,dis*AU_CON,dis);
    printf(" (Subsystem.) \n");
  } else {
    if (Orbits[starnr][orbit].planet!=NULL)
      dis=Orbits[starnr][orbit].planet->orbdis;
    else
      dis=orbitdis(starnr,orbit);
    printf("Orbit: %2d. Distance: %1.1f million km. (%1.2f AU) ; ",
      orbit+1,dis*AU_CON,dis);
    if (dis<stardata[star[starnr].size][star[starnr].type].ibio)
    	printf(" (Inner orbit.) \n"); else
  	  if (dis>stardata[star[starnr].size][star[starnr].type].obio)
			  printf(" (Outer orbit.) \n"); else printf(" (Bio zone.) \n");

  }
}

void print_star(starnr)
int starnr;
{
	int orbit,world,check;

	printf("\n--- Star: %d '%s %s'. Type: %c%d Size:%s. MotherStar: %d. ---\n",
		starnr+1,body1[starnr],SysName,sclass[star[starnr].size],star[starnr].spec,
		ssize[star[starnr].type],star[starnr].mother+1);
  printf(" Description: %s %s star.\n\n",scdesc[star[starnr].size],ssdesc[star[starnr].type]);
	for (orbit=0;orbit<MAX_PLANET;orbit++) {
    if (!BioOnly || (Orbits[starnr][orbit].planet!=NULL &&
      Orbits[starnr][orbit].planet->orbdis <=
       stardata[star[starnr].size][star[starnr].type].obio &&
      Orbits[starnr][orbit].planet->orbdis >=
       stardata[star[starnr].size][star[starnr].type].ibio)) {
  		if (Orbits[starnr][orbit].Avail==AVAILABLE) {
        output_orbit(starnr,orbit);
        if (Orbits[starnr][orbit].planet!=NULL) {
          output_world(Orbits[starnr][orbit].planet);
          for (world=0;world<MAX_MOON;world++)
            if (Orbits[starnr][orbit].moon[world]!=NULL) output_world(Orbits[starnr][orbit].moon[world]);
        } else { tabs(1); printf("Empty orbit.\n"); }
      }
    }
    for (check=1;check<MAX_STAR;check++)
      if (star[check].orbit==orbit && star[check].mother==starnr) {
        output_orbit(starnr,orbit);
        tabs(1); printf("* Star: %d '%s %s'.\n",check+1,body1[check],SysName);
      }
  }
}

void tag_planets()
{
  int checks,check,used;

  for (checks=0;checks<MAX_STAR;checks++)
    for (check=0,used=0;check<MAX_PLANET;check++)
      if (Orbits[checks][check].planet!=NULL && Orbits[checks][check].planet->diameter>0) {
        Orbits[checks][check].planet->tag=++used;
      }
}

void print_info()
{
  int starnr,orbit,world;
  int Planets[MAX_STAR],Moons[MAX_STAR],GasGiants[MAX_STAR],Asteroids[MAX_STAR];

  for (starnr=0;starnr<MAX_STAR;starnr++)
    if (star[starnr].orbit!=-2) {
      Planets[starnr]=0; GasGiants[starnr]=0;
      Asteroids[starnr]=0; Moons[starnr]=0;
      for (orbit=0;orbit<MAX_PLANET;orbit++)
        if (Orbits[starnr][orbit].planet!=NULL) {
          if (Orbits[starnr][orbit].planet->diameter<0) Asteroids[starnr]++;
          if (Orbits[starnr][orbit].planet->diameter>0 && Orbits[starnr][orbit].planet->diameter<MAX_PLANET_SIZE) Planets[starnr]++;
          if (Orbits[starnr][orbit].planet->diameter>MAX_PLANET_SIZE) GasGiants[starnr]++;
          for (world=0;world<MAX_MOON;world++) {
            if (Orbits[starnr][orbit].moon[world]!=NULL) Moons[starnr]++;
            }
        }
    }
  printf("+------+----------+----------+----------+----------+\n");
  printf("| Star | #Planets |#GasGiants|  #Moons  |#Asteroids|\n");
  printf("+------+----------+----------+----------+----------+\n");
  for (starnr=0;starnr<MAX_STAR;starnr++)
    if (star[starnr].orbit!=-2) {
      printf("|%6d|%10d|%10d|%10d|%10d|\n",
        starnr+1,Planets[starnr],GasGiants[starnr],Moons[starnr],Asteroids[starnr]);
    }
  printf("+------+----------+----------+----------+----------+\n");
}

void cleanup()
{
  FreeArgs(Args);
  FreeRMem(MemKey);
}

void main(argv,argc)
int argc;
char *argv[];
{
  #define TEMPLATE "SEED/N,FILTER/K,CHEAT/S,NAME/K,BIOONLY/S"

  int starnr,orbit,world;
  LONG ArgRes[5];
  long Seed=0;
  time_t tim;
  struct Satelite *object;

  onexit(cleanup);
  ArgRes[0]=NULL;
  ArgRes[1]=(long)&"NONE";
  ArgRes[2]=FALSE;
  ArgRes[3]=(long)&"System";
  ArgRes[4]=FALSE;

  Args = (struct RDArgs *)AllocDosObject(DOS_RDARGS,NULL);

	Args->RDA_ExtHelp = "\33[4mSSG v"REVISION" by "AUTHOR".\33[0m\n\n"\
"\33[1mFormat:\33[0mSSG [SEED <number>] [FILTER light|medium|heavy] [CHEAT] [NAME <system name>] [BIOONLY]\n\n"\
"\33[1mTemplate:\33[0m"TEMPLATE"\n\n"\
"\33[1mSpecification:\33[0m\n"\
"\33[3mSEED:\33[0m The seed number to use for this system. If no number is given a random seed will be used.\n"\
"\33[3mFILTER:\33[0m Setting the filter supresses output for objects less than 1000, 3000 or 6000 km in diameter.\n"\
"\33[3mCHEAT:\33[0m This option tries to force a earth size planet into the bio zone.\n"\
"\33[3mNAME:\33[0m The name of the system. Defaults to 'system'.\n"\
"\33[3mBIOONLY:\33[0m Output only the bio zone of this system.\n";

  if (Args=ReadArgs(TEMPLATE,ArgRes,Args)) {

    if (!ArgRes[0]) Seed=time(&tim);
      else Seed=*(long *)ArgRes[0];
    srand(Seed); printf("Seed for this system is %d. ",Seed);
    Filter=(char *)ArgRes[1];
    Cheat=ArgRes[2];
    if (Cheat) printf("Cheat is ON.\n"); else printf("Cheat is OFF.\n");
    SysName=(char *)ArgRes[3];
    BioOnly=ArgRes[4];

  	stars();
  	for (starnr=0;starnr<MAX_STAR;starnr++)
	   	if (star[starnr].orbit>=-1)
		  	for (orbit=0;orbit<MAX_PLANET;orbit++) {
			  	size(starnr,orbit);
          tag_planets();
  				for (world=-1;world<MAX_MOON;world++) {
            if (world==-1) object=Orbits[starnr][orbit].planet;
              else object=Orbits[starnr][orbit].moon[world];
			  		if (object!=NULL && object->diameter>0) {
				  		density(object);
					  	axial(object);
						  daylength(object);
  						atmos(object);
	  					climate(object);
		  				watersurf(object);
			  			humidity(object);
				  		terrain(object);
					  	minerals(object);
  					}
          }
		  	}
    print_info();
    for (starnr=0;starnr<MAX_STAR;starnr++)
      if (star[starnr].orbit>=-1) print_star(starnr);
  } else PrintFault(IoErr(),"*** ");
}
