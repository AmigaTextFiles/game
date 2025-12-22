// GMenuBack.cpp: implementation of the GMenuBack class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "GMenuBack.h"
#include "inifile.h"
#include "menudat.h"
extern st_inifile ini;

BITMAP *b_menu;
//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

GMenuBack::GMenuBack()
{
	m_dat  = NULL;
	m_back = NULL;
}

GMenuBack::~GMenuBack()
{

}

void GMenuBack::Flip()
{
	hscreen.Flip();
}

void GMenuBack::FadeOut()
{
	return;
}

bool GMenuBack::LoadGFX()
{
	if (!(b_menu = hload_bitmap("gfx/other/menu.jpg"))) {
		allegro_message("Missing file gfx/other/menu.jpg");
		return false;
	}

	if (ini.hudba)
		if ((m_dat = load_datafile("sfx/menu.dat")) == NULL)
			if ((m_dat = load_datafile("/usr/local/share/kulic/sfx/menu.dat")) == NULL)
				m_dat = load_datafile("/usr/share/kulic/sfx/menu.dat");

	
	
	return true;
}

void GMenuBack::Destroy()
{
	if (b_menu != NULL) destroy_bitmap(b_menu);
	b_menu = NULL;

	if (m_dat) {
		unload_datafile(m_dat);
		m_dat = NULL;
	}

}

void GMenuBack::Clear()
{
	static int x = 320, y = 240;
	static int dx = rand()%440+100, dy = rand()%280+100;
	static int dist = rand()%150+70;
	static int counter = 0;

	if (ini.meffects) {
		draw_sprite(hscreen.m_back, b_menu, 0, 0);
		hwarp2(hscreen.m_back, b_menu, x-100, y-100, 200, 200, counter, 0.3, 20);

		counter += 15;
		if ( counter > 853) counter -= 853;

		if (x < dx) x += 2;
		if (x > dx) x -= 2;
		if (y < dy) y += 2;
		if (y > dy) y -= 2;

		if (y > 379) y = 379;
		if (y < 100) y = 100;
		if (x > 539) y = 539;
		if (x < 100) x = 100;

		if (dist-- == 0) {
		  	dist = rand()%150+70;
			dx = rand()%440+100;
			dy = rand()%280+100;
		}
	}
	else
		draw_sprite(hscreen.m_back, b_menu, 0, 0);
}

void GMenuBack::Acquire()
{
//	acquire_bitmap(hscreen.m_back);
}



void GMenuBack::Start()
{
	if (m_dat)
		play_sample((SAMPLE*) m_dat[SAMP_MENU].dat, 255, 128, 1000, 1);
}


void GMenuBack::Stop()
{
	if (m_dat) {
		stop_sample((SAMPLE*) m_dat[SAMP_MENU].dat);
		stop_sample((SAMPLE*) m_dat[SAMP_BUTTON].dat);
		stop_sample((SAMPLE*) m_dat[SAMP_SCREEN].dat);
	}
}

void GMenuBack::Click()
{
	if (m_dat) {
		stop_sample((SAMPLE*) m_dat[SAMP_BUTTON].dat);
		play_sample((SAMPLE*) m_dat[SAMP_BUTTON].dat, 255, 128, 1000, 0);
	}

}

void GMenuBack::Release()
{
//	release_bitmap(hscreen.m_back);
}

void GMenuBack::Screen()
{
	if (m_dat) {
		stop_sample((SAMPLE*) m_dat[SAMP_SCREEN].dat);
		play_sample((SAMPLE*) m_dat[SAMP_SCREEN].dat, 255, 128, 1000, 0);
	}
}

/*
BITMAP *GMenuBack::m_back()
{
	return hscreen.m_back;
}
*/
