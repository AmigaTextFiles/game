// GMenu.cpp: implementation of the GMenu class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "GMenu.h"

#include "GMenuSet.h"
#include "GMenuSingle.h"
//#include "GMenuMulti.h"

#include "GMenuBackFading.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

GMenu::GMenu()
{
	m_back     = NULL;
	m_item     = 1;
	m_music    = NULL;
}

GMenu::~GMenu()
{
}

void GMenu::Run(GRun *run)
{

	m_back->Start();
   clear_keybuf();
	m_run = run;
	for(;;) {
		tmr  = 5; // 50 ms; -> 20 refreshu za sekundu
		Draw();
		if (ProccesKeys()) break;
		while (tmr != 0); // cekame, za dobehe timer
	}
	RunCredits();
	// CHQ_BRANCH: Already faded down - this just causes a delay!
	//hscreen.FadeDown();
	m_back->Stop();
}

void GMenu::Draw()
{
	m_back->Acquire();

	m_back->Clear();


	// menu
//	DrawMyFontCenter(hscreen.m_back, 320, 140, Col(0), T_MMAIN_VICEHRACU);
	DrawMyFontCenter(hscreen.m_back, 320, 180, Col(1), T_MMAIN_SINGLE);
	DrawMyFontCenter(hscreen.m_back, 320, 220, Col(2), T_MMAIN_DEMO);
	DrawMyFontCenter(hscreen.m_back, 320, 260, Col(3), T_MMAIN_NASTAVENI);
	DrawMyFontCenter(hscreen.m_back, 320, 300, Col(4), T_MMAIN_KONEC);

	// okoli
	DrawMyFontCenter(hscreen.m_back, 320,  50, makecol(255,10,10), T_MMAIN_NADPIS);


	m_back->Release();

	m_back->Flip();
}

bool GMenu::ProccesKeys()
{
	int  c, c2;
	if(keypressed()) {
		c2 = readkey();
		c = (c2 >> 8);

		switch (c) {
		case KEY_UP : 
			if(--m_item < 1) m_item = it_konec;
			m_back->Click();
			break;
		case KEY_DOWN :
			m_back->Click();
			if(++m_item > it_konec) m_item = 1;
			break;

		case KEY_ENTER :
			if (m_item == it_multi)
				RunMenuMulti();

			if (m_item == it_single) 
				RunMenuSingle();

			if (m_item == it_demo)
				RunDemo();

			if (m_item == it_konec) 
				return true;

			if (m_item == it_nastaveni)
				RunMenuSet();

			break;
		}
	}
	clear_keybuf();


	return false;
}

int GMenu::Col(int index)
{
	if (index == m_item) return makecol(255,255,255);
	return makecol(128,128,128);
}

void GMenu::LoadGFX(GRun *run)
{
	draw_loading();
	Destroy(NULL);

	if (ini.feffect)
		m_back = new GMenuBackFading;
	else
		m_back = new GMenuBack;

	m_back->LoadGFX();

}

void GMenu::Destroy(GRun *run)
{
	if (m_back != NULL) {
		m_back->Destroy();
		delete m_back;
		m_back = NULL;
	}
}



void GMenu::RunMenuSet()
{
	m_back->Screen();
	m_back->FadeOut();
	GMenuSet mn;
	mn.Run(m_run, m_back);
}

void GMenu::RunMenuSingle()
{
	m_back->Screen();
	m_back->FadeOut();
	GMenuSingle mn;
	mn.Run(m_run, m_back);

}

void GMenu::RunMenuMulti()
{
//	m_back->Screen();
//	m_back->FadeOut();
//	GMenuMulti mn;
//	mn.Run(m_run, m_back);
}

void GMenu::RunCredits()
{
	m_back->Screen();
	m_back->FadeOut();

	// titulky
	clear_keybuf();
	for (int y = 480; y > -200; y -= 5) {
		tmr  = 5; // 50 ms; -> 20 refreshu za sekundu
		DrawCredits(y);
		while (tmr != 0); // cekame, za dobehe timer
		if (keypressed()) break;
	}

	hscreen.FadeDown();

	// kulic II
	BITMAP *temp;
	if ((temp = hload_bitmap("gfx/other/kulic_2.jpg")) != NULL) {
		tmr  = 1000; // 10s

		draw_sprite(hscreen.m_back, temp, 0, 0);
		hscreen.Flip();

		clear_keybuf();
		while (tmr != 0) { // cekame, za dobehe timer
			if (keypressed()) break;
			draw_sprite(hscreen.m_back, temp, 0, 0);
			hscreen.Flip();
		}
		destroy_bitmap(temp);
	}
	hscreen.FadeDown();

}


void GMenu::RunDemo()
{
	m_back->Click();
 	hscreen.FadeDown();
	m_back->Stop();
	m_run->Demo();
	m_back->Start();
}

void GMenu::DrawCredits(int y)
{
	m_back->Acquire();

	m_back->Clear();

	// menu
	DrawMyFontCenter(hscreen.m_back, 320, y, makecol(255, 10, 10), T_MCREDITS_AUTORI);
	DrawMyFontCenter(hscreen.m_back, 320, y+40, makecol(255, 255, 255), "BERNARD LIDICKY");
	DrawMyFontCenter(hscreen.m_back, 320, y+80, makecol(255, 255, 255), "ZDENEK BOSWART");
	DrawMyFontCenter(hscreen.m_back, 320, y+140, makecol(255, 255, 255), "HIPPO GAMES - 2003");

	m_back->Release();

	m_back->Flip();
}
