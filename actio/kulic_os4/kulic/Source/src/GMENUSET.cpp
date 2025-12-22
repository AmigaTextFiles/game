// GMenuSet.cpp: implementation of the GMenuSet class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "GMenuSet.h"
#include <iostream.h>
//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

GMenuSet::GMenuSet()
{
	m_item = 0;
}

GMenuSet::~GMenuSet()
{
}

void GMenuSet::Run(GRun *run, GMenuBack *back)
{
	m_run = run;
	m_back = back;
   clear_keybuf();
	for(;;) {
		tmr  = 5; // 50 ms; -> 20 refreshu za sekundu
		Draw();
		if (ProcessKeys()) break;
		while (tmr != 0); // cekame, za dobehe timer
	}
	m_back->Screen();
	m_back->FadeOut();
}

bool GMenuSet::LoadGfx()
{
	return true;
}

void GMenuSet::Destroy()
{	
}

bool GMenuSet::ProcessKeys()
{
	int  c, c2;

	if (keypressed()) {
		c2 = readkey();
		c = (c2 >> 8);

		switch (c) {
		case KEY_UP : 
			if(--m_item < 0) m_item = it_zpet;
			m_back->Click();
			break;
		case KEY_DOWN :
			m_back->Click();
			if(++m_item > it_zpet) m_item = 0;
			break;
		case KEY_LEFT :
			if (m_item == it_postava) {
				m_back->Click();
				if(--m_run->m_sold[0].m_ID < 0) m_run->m_sold[0].m_ID = MAX_SOLDIERS-1;
			}
			if (m_item == it_mapa) {
				m_back->Click();
				if(--m_run->m_mapa < 1) m_run->m_mapa = 1;
			}
			if (m_item == it_svetlo) {
				m_back->Click();
				m_run->m_svetlo = GFX_LOADED_NORMAL;
			}
			break;
		case KEY_RIGHT :
			if (m_item == it_postava) {
				m_back->Click();
				if((++m_run->m_sold[0].m_ID) >= MAX_SOLDIERS) m_run->m_sold[0].m_ID = 0;
			}
			if (m_item == it_mapa) {
				if(++m_run->m_mapa > m_run->m_maps) m_run->m_mapa = m_run->m_maps;
				m_back->Click();
			}
			if (m_item == it_svetlo) {
				m_back->Click();
				m_run->m_svetlo = GFX_LOADED_DARK;
			}
			break;
		case KEY_ENTER :

			if (m_item == it_zpet) return true;
			break;
		case KEY_BACKSPACE :
		case KEY_DEL :
			if (m_run->m_sold[0].m_name[0] != '\0')
				m_run->m_sold[0].m_name[strlen(m_run->m_sold[0].m_name)-1] = '\0';
				m_back->Click();
			break;
		default :
			c = c2 & 0xff;
			if (islower(c)) c = _toupper(c); // aby se nepsalo malejma pismenkama
			if ((GetFontID(c) != -1) && (c != ' ')) {
				m_back->Click();
				int len = strlen(	m_run->m_sold[0].m_name);
				if (len < 50) {
					m_run->m_sold[0].m_name[len] = c;
					m_run->m_sold[0].m_name[len+1] = '\0';
				}
			}
		}
	}
	clear_keybuf();

	return false;
}

void GMenuSet::Draw()
{
	m_back->Acquire();
	m_back->Clear();

	// menu
	draw_sprite(hscreen.m_back, b_solds_big[Sparams[m_run->m_sold[0].m_ID].bindex], 300, 90);

	char s[80];
	sprintf(s, T_MSINGLE_NAME, m_run->m_sold[0].m_name);
	DrawMyFontCenter(hscreen.m_back, 320, 140, Col(0), s);
	DrawMyFontCenter(hscreen.m_back, 320, 180, Col(1), T_MSINGLE_POSTAVA);
	sprintf(s, "< MAPA %d >", m_run->m_mapa);
	DrawMyFontCenter(hscreen.m_back, 320, 220, Col(2), s);
	if (m_run->m_svetlo == GFX_LOADED_NORMAL)
		DrawMyFontCenter(hscreen.m_back, 320, 260, Col(3), T_MSINGLE_DEN);
	else
		DrawMyFontCenter(hscreen.m_back, 320, 260, Col(3), T_MSINGLE_NOC);

	DrawMyFontCenter(hscreen.m_back, 320, 300, Col(4), T_MENU_ZPET);

	// okoli
	DrawMyFontCenter(hscreen.m_back, 320,  50, makecol(255,10,10), T_MMAIN_NASTAVENI);
	m_back->Release();;

	m_back->Flip();
}

int GMenuSet::Col(int index)
{
	if (index == m_item) return makecol(255,255,255);
	return makecol(128,128,128);
}

