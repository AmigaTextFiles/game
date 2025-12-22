// GMenuBackFading.cpp: implementation of the GMenuBackFading class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "GMenuBackFading.h"

extern BITMAP *b_menu;

#define  ALPHA_INCR  40
//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

GMenuBackFading::GMenuBackFading()
{
	m_faded = false;
}

GMenuBackFading::~GMenuBackFading()
{

}

void GMenuBackFading::Flip()
{
	if (!m_faded) {
		if ((m_alpha += ALPHA_INCR) > 255) m_alpha = 255;
	}
	else 
		if ((m_alpha -= ALPHA_INCR) < 0) m_alpha = 0;

	if (m_alpha == 255) 
		draw_sprite(hscreen.m_back, m_back, 0, 0);
	else {
		draw_sprite(hscreen.m_back, m_zaloha, 0, 0);
		set_trans_blender(0, 0, 0, m_alpha);
		draw_trans_sprite(hscreen.m_back, m_back, 0, 0);
	}

	hscreen.Flip();
}

void GMenuBackFading::FadeOut()
{
	Zaloha();
	m_faded = true;
	while (m_alpha != 0) Flip();
	m_faded = false;
}

bool GMenuBackFading::LoadGFX()
{
	if (!GMenuBack::LoadGFX()) return false;

	m_back = create_bitmap(hscreen.m_back->w, hscreen.m_back->h);
	if (!m_back) {
		allegro_message("Unable to create bitmap !!");
		return false;
	}

	m_zaloha = create_bitmap(hscreen.m_back->w, hscreen.m_back->h);
	if (!m_zaloha) {
		allegro_message("Unable to create bitmap !!");
		return false;
	}
	return true;
}

void GMenuBackFading::Destroy()
{
	GMenuBack::Destroy();

	if (m_back != NULL) destroy_bitmap(m_back);
	m_back = NULL;

	if (m_zaloha != NULL) destroy_bitmap(m_zaloha);
	m_zaloha = NULL;
}

void GMenuBackFading::Zaloha()
{
	blit(m_back, m_zaloha, 0, 0, 0, 0, 640, 480);
}

