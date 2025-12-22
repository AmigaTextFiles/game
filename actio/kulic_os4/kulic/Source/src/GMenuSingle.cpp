// GMenuSingle.cpp: implementation of the GMenuSet class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "GMenuSingle.h"
#include "GRun.h"

#include "inifile.h"
extern st_inifile ini;

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

GMenuSingle::GMenuSingle()
{
	m_item = 0;
	m_enemy = ini.pocitacu;

}

GMenuSingle::~GMenuSingle()
{
	ini.pocitacu = m_enemy;
}

void GMenuSingle::Run(GRun *run, GMenuBack *back)
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
	m_back->Click();
	m_back->FadeOut();
}

bool GMenuSingle::LoadGfx()
{
	return true;
}

void GMenuSingle::Destroy()
{	
}

bool GMenuSingle::ProcessKeys()
{
	int  c, c2;

	if (keypressed()) {
		c2 = readkey();
		c = (c2 >> 8);

		switch (c) {

		case KEY_UP : 
			m_back->Click();
			if(--m_item < 0) m_item = it_zpet;
			break;
		case KEY_DOWN :
			m_back->Click();
			if(++m_item > it_zpet) m_item = 0;
			break;

		case KEY_LEFT :
			if (m_item == it_enemy) {
				m_back->Click();
				if(--m_enemy < 0) m_enemy = 0;
			}

			if (m_item == it_ai_diff) {
				m_back->Click();
				if (ini.minAI > 0) ini.minAI--;
				else if (ini.maxAI > 0) ini.maxAI--;
			}

			break;
		case KEY_RIGHT :
			if (m_item == it_enemy) {
				m_back->Click();
				if(++m_enemy >= MAX_PLAYERS-1) m_enemy = MAX_PLAYERS-1;
			}

			if (m_item == it_ai_diff) {
				m_back->Click();
				if (ini.maxAI < COMPAILEVELS-1) ini.maxAI++;
				else if (ini.minAI < COMPAILEVELS-1) ini.minAI++;
			}

			break;

		case KEY_ENTER :

			if (m_item == it_zpet) return true;

			if (m_item == it_play) RunSingle(false);

			if (m_item == it_kill_me) RunSingle(true);

			break;
		}
	}
	clear_keybuf();

	return false;
}

void GMenuSingle::Draw()
{
	m_back->Acquire();
	m_back->Clear();


	// menu
	char s[80];
	sprintf(s, T_MPOCITAC_COMPU, m_enemy);
	DrawMyFontCenter(hscreen.m_back, 320, 140, Col(0), s);
	sprintf(s, T_MPOCITAC_AI_DIFF, ini.minAI+1, ini.maxAI+1);
	DrawMyFontCenter(hscreen.m_back, 320, 180, Col(1), s);
	DrawMyFontCenter(hscreen.m_back, 320, 220, Col(2), T_MPOCITAC_KILLME);
	DrawMyFontCenter(hscreen.m_back, 320, 260, Col(3), T_MPOCITAC_PROTI);
	DrawMyFontCenter(hscreen.m_back, 320, 300, Col(4), T_MENU_ZPET);

	DrawMyFontCenter(hscreen.m_back, 320,  50, makecol(255,10,10), T_MMAIN_SINGLE);
	m_back->Release();

	m_back->Flip();
}

int GMenuSingle::Col(int index)
{
	if (index == m_item) return makecol(255,255,255);
	return makecol(128,128,128);
}


void GMenuSingle::RunSingle(bool kill_me)
{
	m_back->Screen();
	hscreen.FadeDown();


	m_back->Stop();
	m_run->m_kill_mee = kill_me;

//	m_run->m_net.m_connected = false;
	m_run->InitSingle(m_enemy+1);
	m_run->Init(ini.minAI, ini.maxAI);
	m_run->Run();

	m_back->Start();
	m_back->Screen();

//run.m_net.ShutDown();
}
