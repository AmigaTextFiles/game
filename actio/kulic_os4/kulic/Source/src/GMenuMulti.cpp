// GMenuMulti.cpp: implementation of the GMenuSet class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "GMenuMulti.h"
#include "GRun.h"

#include "inifile.h"
extern st_inifile ini;

/*

#define MAX_COM_SPEEDS 4

const DWORD COMSPEED[MAX_COM_SPEEDS] = {
	56000, 57600, 115200, 128000
};

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

GMenuMulti::GMenuMulti()
{
	m_item = 0;
	m_enemy = ini.pocitacu;

}

GMenuMulti::~GMenuMulti()
{
	ini.pocitacu = m_enemy;
}

void GMenuMulti::Run(GRun *run, GMenuBack *back)
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

bool GMenuMulti::LoadGfx()
{
	return true;
}

void GMenuMulti::Destroy()
{	
}

bool GMenuMulti::ProcessKeys()
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
			if(++m_item > it_zpet) m_item = 0;
			m_back->Click();
			break;

		case KEY_ENTER :

			if (m_item == it_zpet) return true;

			if (m_item == it_com)
				if (net->ConnectSERIAL(ini.com+1, COMSPEED[ini.com_speed])) {
					m_run->m_net.m_connected = true; // podarilo se navazat spojeni
					RunNetPlay();
				}
				else m_item++;

			if (m_item == it_ipx)
				if (net->ConnectIPX()) {
					m_run->m_net.m_connected = true; // podarilo se navazat spojeni
					RunNetPlay();
				}
				else m_item++;

			if (m_item == it_tcpip)
				if (net->ConnectTCPIP(ini.ip)) {
					m_run->m_net.m_connected = true; // podarilo se navazat spojeni
					RunNetPlay();
				}
				else m_item++;

			break;
		}
	}
	clear_keybuf();

	return false;
}

void GMenuMulti::Draw()
{
	m_back->Acquire();
	m_back->Clear();

	// menu
	char s[80];
	sprintf(s, "COM %d",ini.com+1);
	DrawMyFontCenter(m_back->m_back, 320, 150, Col(0), s);
	DrawMyFontCenter(m_back->m_back, 320, 190, Col(1), "IPX");
	DrawMyFontCenter(m_back->m_back, 320, 230, Col(2), "TCP-IP");
	DrawMyFontCenter(m_back->m_back, 320, 270, Col(3), T_MENU_ZPET);

	DrawMyFontCenter(m_back->m_back, 320,  50, makecol(255,10,10), T_MMAIN_VICEHRACU);
	m_back->Release();;

	m_back->Flip();
}

int GMenuMulti::Col(int index)
{
	if (index == m_item) return makecol(255,255,255);
	return makecol(128,128,128);
}


void GMenuMulti::RunNetPlay()
{
	m_back->Screen();
	hscreen.FadeDown();


	m_back->Stop();
	m_run->Init(0, COMPAILEVELS-1);
	m_run->Run();

	m_run->m_net.ShutDown();
	m_run->m_net.m_connected = false;
	m_back->Start();
}
*/
