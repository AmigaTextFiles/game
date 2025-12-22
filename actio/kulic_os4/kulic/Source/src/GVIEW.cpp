// GView.cpp: implementation of the GView class.
//
//////////////////////////////////////////////////////////////////////

#include <iostream.h>
#include "stdh.h"
#include "soldiers.h"
#include "zbrane.h"
#include "GSoldier.h"
#include "GView.h"
#include "GMap.h"
#include "GRun.h"


#define DXTABLE    900
#define DXTABLESN  30

#define DABELSKY_NAPIS_S 80 // 4 sekundy pro napis SES DABEL - MAS 666 FRAGU

BITMAP*  b_gv[MAX_GV_BITMAPS];         /// bitmapy pro GView
BITMAP*  b_topten[3];
BITMAP*  b_bestsold[MAX_BESTSOLD_ANIM];



//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

/*////////////////////////////////////////////////////////////////////////////////
  NULL-ovaci konstruktor
*/
GView::GView()
{
	m_zamerovac = false;
}

/*////////////////////////////////////////////////////////////////////////////////
  Prazdnu destruktor
*/
GView::~GView()
{
}

/*////////////////////////////////////////////////////////////////////////////////
  Nakresli uplne vsechno na hscreen.back
*/
void GView::Draw(BITMAP *dst, GRun *run, bool light, bool shadow)
{
	int i;

 // cast pod vojaky
	run->m_map.Draw(dst, m_Cx, m_Cy, light);

	DrawBestSold(dst);
	for (i = 0 ; i < run->m_soldiers; i++) 
		run->m_sold[i].Draw(dst, m_Cx, m_Cy, light, shadow);


	run->m_map.DrawStrely(dst, m_Cx, m_Cy, light, shadow);
	

// soucasny vojak
	DrawCurSold(dst, run);
	DrawMenu(dst, run);

	// ji-li nas hrac mrtvy, tak nakreslime tabulku fragu
	if (run->m_sold[run->m_monsol].m_health <= 0)
		DrawFrags(run);
	else m_dxtable = DXTABLE;
}

/*////////////////////////////////////////////////////////////////////////////////
  Inicializuje GView tridu
  car  : ukazatel na moniotrovane auto
*/
void GView::Init(GSoldier *sol)
{
	m_Cx = sol->m_x - DF_X/2;
	m_Cy = sol->m_y - DF_Y/2;
	// resetovani zprav
	int i;
	for (i = 0; i < MAX_MESSAGES; i++)
		m_mess[i][0] = '\0';

	m_dabel = DABELSKY_NAPIS_S;
}

/*////////////////////////////////////////////////////////////////////////////////
  Posune kameru smerem k jejimu pozadovanemumistu ( to zavisi na smeru a rychlosti auta )
*/
void GView::UpdateCamera(GRun *run)
{
	GSoldier *sol = &(run->m_sold[0]);
	GMap *map = &(run->m_map);
	// vypocet posunuti kamery
	m_Cx = sol->m_x /*- DF_X/2*/;
	m_Cy = sol->m_y /*- DF_Y/2*/;

	if(m_Cx < DF_X/2) m_Cx = DF_X/2;
	if(m_Cy < DF_Y/2) m_Cy = DF_Y/2;
	if(m_Cx > map->m_sx - DF_X/2) m_Cx = map->m_sx - DF_X/2;
	if(m_Cy > map->m_sy  - DF_Y/2) m_Cy = map->m_sy - DF_Y/2;

	CountFrags(run);
}

/*////////////////////////////////////////////////////////////////////////////////
  Pred ukoncenim programu znici ( uvolni ) vsechny alokovane bitmapy
*/
void GView::Destroy()
{
	int i;
	for ( i = 0; i < MAX_GV_BITMAPS; i++) {
		if (b_gv[i] == NULL) destroy_bitmap(b_gv[i]);
		b_gv[i] = NULL;
	}

	for ( i = 0; i < 3; i++) {
		if (b_topten[i] == NULL) destroy_bitmap(b_topten[i]);
		b_topten[i] = NULL;
	}

	for ( i = 0; i < MAX_BESTSOLD_ANIM; i++) {
		if (b_bestsold[i] == NULL) destroy_bitmap(b_bestsold[i]);
		b_bestsold[i] = NULL;
	}
}

/*////////////////////////////////////////////////////////////////////////////////
  Nacte grafiku
*/
bool GView::LoadGFX(GRun *run)
{
	Destroy();

	if (!run->LoadBitmaps(&b_gv[0], MAX_GV_BITMAPS, 1, "gfx/view/V%d.bmp")) return false;

	if (!run->LoadBitmaps(&b_topten[0], 3, 1, "gfx/view/TOPTEN%d.BMP")) return false;

	if (!run->LoadBitmaps(&b_bestsold[0], MAX_BESTSOLD_ANIM, 1, "gfx/view/BSOLD%d.BMP")) return false;

	return true;
}

/*////////////////////////////////////////////////////////////////////////////////
  Zobrazi grafiku pro naseho vojaka
*/
void GView::DrawCurSold(BITMAP *dst, GRun *run)
{
	int i;
	GSoldier *sold = &run->m_sold[run->m_monsol];

	int x = sold->m_x - m_Cx + (DF_X) / 2;
	int y = sold->m_y - m_Cy + (DF_Y) / 2;

	// zdravicko a ramecek
	draw_sprite(dst, b_gv[GV_RAMECEK], x-15, y-15);
	if (sold->m_health > 0)
		line(dst, x-12,y+12, x-12+22*sold->m_health/Sparams[sold->m_ID].health, y+12, makecol(255,0,0));
	if (sold->m_shield > 0)
		line(dst, x-12,y+14, x-12+22*sold->m_shield/Sparams[sold->m_ID].shields, y+14, makecol(200,200,255));
 
	// bonusy - pri jejich dochazeni blikaji
	for (i = 0; i < MAX_BONUS; i++) 
		if ((sold->m_bonusy[i] > 60) || ((sold->m_bonusy[i] > 0) && (sold->m_bonusy[i]%10 < 5))) 
			draw_sprite(dst, b_s_bonus[i], x - 25 + i*10, y+16);

	// zamerovac
	if (m_zamerovac && sold->m_health > 0 ) {
		int sx,sy,dx,dy;
		// vojak ma naboje
		if (sold->m_naboje[Zparams[sold->m_zbran].strelaID] > 0) {  
			double alpha = -atan2(Zparams[sold->m_zbran].dy, Zparams[sold->m_zbran].dx);
			double dest   = pow(pow(Zparams[sold->m_zbran].dx,2)+pow(Zparams[sold->m_zbran].dy,2),0.5);
			sx = x + dest*cos(-sold->m_angleRad-alpha);
			sy = y + dest*sin(-sold->m_angleRad-alpha);
			dx = sx + Nparams[Zparams[sold->m_zbran].strelaID].dist*cos(-sold->m_angleRad);
			dy = sy + Nparams[Zparams[sold->m_zbran].strelaID].dist*sin(-sold->m_angleRad);
			// kdyz nema vojak nabyto, tak kreslime caru cervene
			if (sold->m_nrtf == 0)
				line(dst, sx, sy, dx, dy, makecol(rand()%256, rand()%256, rand()%256));
			else
				line(dst, sx, sy, dx, dy, makecol(250, 0, 0));
		}
		// vojak nema zadne naboje
		else {
			sx = x +   20 * cos(-sold->m_angleRad);
			sy = y +   20 * sin(-sold->m_angleRad);
			dx = sx + 300 * cos(-sold->m_angleRad);
			dy = sy + 300 * sin(-sold->m_angleRad);

			// kdyz nema vojak nabyto, tak kreslime caru cervene
			line(hscreen.m_back, sx, sy, dx, dy, makecol(250, 0, 0));
		}
			 
	}
}

/*////////////////////////////////////////////////////////////////////////////////
  Prida zpravu o sebrani bonusu
*/
void GView::AddBonMessage(int ID)
{
	char c[60];
	sprintf(c, "SEBRAL JSI %s",Pparams[ID].name);
	AddMessage(c);
}

/*////////////////////////////////////////////////////////////////////////////////
  Prida zpravu o zabiti
*/
void GView::AddKillMessage(int kdo, int koho, GRun *run) 
{
	char c[60];
	if (kdo != run->m_monsol && koho != run->m_monsol) return;

	if (kdo == run->m_monsol)
		sprintf(c, "%s %s", run->m_sold[koho].m_name, u_kill[rand()%MAX_UKILL]);
	
	if (koho == run->m_monsol)
		sprintf(c, "%s %s", run->m_sold[kdo].m_name, u_killed[rand()%MAX_UKILLED]);
	
	/*
	sprintf(c, "%s zabil %s",run->m_sold[kdo].m_name, run->m_sold[koho].m_name);
	*/
	AddMessage(c);
}

/*////////////////////////////////////////////////////////////////////////////////
  Prida zpravu
*/
void GView::AddMessage(char *c)
{
	int i;

	// hledame prazdne misto pro zpravu
	for (i = 0; i < MAX_MESSAGES; i++)
		if (m_mess[i][0] == '\0') break;


	// poseneme zpravy v poli
	if (i == MAX_MESSAGES) {
		for (i = 1; i < MAX_MESSAGES; i++)
			strcpy(m_mess[i-1],m_mess[i]);
		i = MAX_MESSAGES-1;
	}

	strcpy(m_mess[i], c);
	
}

/*////////////////////////////////////////////////////////////////////////////////
  Prida zpravu
*/
void GView::AddFragsMess(int kdo, GRun *run)
{
	char c[60];
	if (kdo == run->m_monsol) {
		sprintf(c ,T_MESSAGE_FRAGS, run->m_sold[kdo].m_frags);
		AddMessage(c);
	}
}

/*////////////////////////////////////////////////////////////////////////////////
  Kresli tabulku fragu
*/
int compare(const void *arg1, const void *arg2);

void GView::DrawFrags(GRun *run)
{
	int i,j;

	j = run->m_soldiers;
	if (j > 10) j = 10;

	// vlastni kresleni tabulky
	int top;
	int hei = b_topten[1]->h;
	top = 240 - j*hei/2;
	draw_sprite(hscreen.m_back, b_topten[0], 320-b_topten[0]->w/2, top-b_topten[0]->h - m_dxtable/2);
	draw_sprite(hscreen.m_back, b_topten[2], 320-b_topten[2]->w/2, top+j*hei + m_dxtable/2);

	int cent;
	int col;
	for ( i = 0; i < j; i++) {
		if (i % 2  == 0)
			cent = 320 + m_dxtable;
		else 
			cent = 320 - m_dxtable;

		draw_sprite(hscreen.m_back, b_topten[1], cent-b_topten[1]->w/2, top+hei*i);

		draw_sprite(hscreen.m_back, b_solds[Sparams[ftable[i]->m_ID].bindex], cent-90, top + hei*i + 5);
		if (ftable[i]->m_index == 0) col = makecol(250, 250, 100);
		else col = makecol(250,100,100);
		textprintf_centre(hscreen.m_back, font, cent,  top+hei*i+10, col, ftable[i]->m_name);
		textprintf_centre(hscreen.m_back, font, cent+75,  top+i*hei+10, col, "%d", ftable[i]->m_frags);
	}

	if (m_dxtable != 0) m_dxtable -= DXTABLESN;
}

/*////////////////////////////////////////////////////////////////////////////////
  Pro QSORT
*/
int compare(const void *arg1, const void *arg2)
{
	return ((*((GSoldier**)arg2))->m_frags - (*((GSoldier**)arg1))->m_frags);
}

void GView::CountFrags(GRun *run)
{
	int i;

	for (i = 0; i < run->m_soldiers; i++) 
		ftable[i] = &run->m_sold[i];
	

	// z nepochipitelneho duvodu to nefunguje
	qsort(ftable, run->m_soldiers, sizeof(GSoldier*),  compare);
	// buble sort
}

void GView::DrawBestSold(BITMAP *dst)
{
	static int i = 0;

	int x = ftable[0]->m_x - m_Cx + ((DF_X) / 2);

	int y = ftable[0]->m_y - m_Cy + ((DF_Y) / 2);

	draw_sprite(dst, b_bestsold[i], x-b_bestsold[i]->w/2, y-b_bestsold[i]->h/2);


	if (++i >= MAX_BESTSOLD_ANIM) i = 0;
}

/*////////////////////////////////////////////////////////////////////////////////
  Kresli na m_aabufer a pak na m_back
*/
void GView::DrawAA(GRun *run, bool light, bool shadow)
{
	int i;

 // cast pod vojaky
	run->m_map.Draw(hscreen.m_aabuffer, m_Cx, m_Cy, light);

	DrawBestSold(hscreen.m_aabuffer);
	for (i = 0 ; i < run->m_soldiers; i++) 
		run->m_sold[i].Draw(hscreen.m_aabuffer, m_Cx, m_Cy, light, shadow);


	run->m_map.DrawStrely(hscreen.m_aabuffer, m_Cx, m_Cy, light, shadow);


// soucasny vojak
	DrawCurSold(hscreen.m_aabuffer, run);

	hscreen.AABufToBack();


	DrawMenu(hscreen.m_back, run);

	// ji-li nas hrac mrtvy, tak nakreslime tabulku fragu
	if (run->m_sold[run->m_monsol].m_health <= 0)
		DrawFrags(run);
	else m_dxtable = DXTABLE;
}

void GView::DrawMenu(BITMAP *dst, GRun *run)
{
	int i;
	// radek dole
	GSoldier *sold = &run->m_sold[run->m_monsol];

	// zpravy
	for (i = 0; i < MAX_MESSAGES; i++)
		if (m_mess[i][0] != '\0')
			textout(hscreen.m_back, font, m_mess[i], 10, 10+20*i, makecol(200, 255, 0));

	// soucasna zbran
	if (sold->m_naboje[Zparams[sold->m_zbran].strelaID] > 0) {
		draw_sprite(hscreen.m_back, b_zbraneB[sold->m_zbran], 0, 405);
		draw_sprite(hscreen.m_back, b_gv[GV_AMMO+sold->m_zbran],   150, 405);
	}
	textprintf_centre(hscreen.m_back, (FONT *)fonts[FNT_GAME].dat, 250, 427, makecol(160,160, 90), "%d",sold->m_naboje[Zparams[sold->m_zbran].strelaID]);

	// fragy
	draw_sprite(hscreen.m_back, b_gv[GV_FRAGS],  290, 405);
	textprintf_centre(hscreen.m_back, (FONT *)fonts[FNT_GAME].dat, 375, 427, makecol(255, 6,  6), "%d",sold->m_frags);

	draw_sprite(hscreen.m_back, b_gv[GV_STIT],   405, 405);
	if (sold->m_shield <= 0) i = 0;
	else i = sold->m_shield*100/Sparams[sold->m_ID].shields;
	textprintf_centre(hscreen.m_back, (FONT *)fonts[FNT_GAME].dat, 484, 427, makecol(166,166, 90), "%d",i);

	draw_sprite(hscreen.m_back, b_gv[GV_ZDRAVI], 510, 405);
	if (sold->m_health <= 0) i = 0;
	else i = sold->m_health*100/Sparams[sold->m_ID].health;
	textprintf_centre(hscreen.m_back, (FONT *)fonts[FNT_GAME].dat, 595, 427, makecol(166,166, 90), "%d",i);

	// dabelsky napis
	if ((sold->m_frags >= 666) && (m_dabel > 0)){
		textprintf_centre(hscreen.m_back, (FONT *)fonts[FNT_GAME].dat, 320, 180, makecol(rand()%256, rand()%256, rand()%256), T_DABVELSKYNAPIS);
		m_dabel--;
	}

}
