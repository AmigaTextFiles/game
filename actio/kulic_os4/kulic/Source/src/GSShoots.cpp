// GSShoots.cpp: implementation of the GSShoots class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "GSShoots.h"
#include "shoots.h"
#include "inifile.h"
extern st_inifile ini;


GSShoots::GSShoots()
{
	m_soundsatd = NULL;
	for (int i = 0; i < MAX_SAMPLES; i++)
			m_voices[i] = -1;
}

GSShoots::~GSShoots()
{
}

bool GSShoots::LoadSFX()
{
	if (!ini.zvuky) return true;
	if((m_soundsatd = load_datafile("sfx/shoots.dat")) == NULL) 
		if((m_soundsatd = load_datafile("/usr/local/share/kulic/sfx/shoots.dat")) == NULL) 
			if((m_soundsatd = load_datafile("/usr/share/kulic/sfx/shoots.dat")) == NULL) 
				return true;

	for (int i = 0; i < MAX_SAMPLES; i++)
		if((m_voices[i] = allocate_voice((SAMPLE *)m_soundsatd[i].dat)) == -1) 
		{
			allegro_message("Unable to allocate voices.");
			return false;
		}

	return true;
}

void GSShoots::DestroySFX()
{
	if (!ini.zvuky) return;

	for (int i = 0; i < MAX_SAMPLES; i++)
		if (m_voices[i] != -1) {
			deallocate_voice(m_voices[i]);
			m_voices[i] = -1;
		}
	

	if (m_soundsatd) {
		unload_datafile(m_soundsatd);
		m_soundsatd = NULL;
	}
}

void GSShoots::Play(int sound, int volume, int pan)
{
//	sound = 0;
	if (!ini.zvuky || !m_soundsatd) return;
//	play_sample((SAMPLE *)m_soundsatd[sound].dat, 128, 128, 1000, 0);

	if (voice_get_position(m_voices[sound]) == -1) 	{
		voice_start(m_voices[sound]);
		voice_set_pan(m_voices[sound], pan);
		voice_set_volume(m_voices[sound], volume);
	}
	else if (voice_get_volume(m_voices[sound]) <= volume) {
		voice_set_position(m_voices[sound], 0);
		voice_set_pan(m_voices[sound], pan);
		voice_set_volume(m_voices[sound], volume);
	}
}

void GSShoots::Play(int sound, int mx, int my, int sx, int sy)
{
	if (sound == -1) return;
	int vol = 255-(abs(mx-sx) + abs(my-sy))/4;
	int pan = 128+(mx-sx)/2;
	if (pan < 0) pan = 0;
	if (pan > 255) pan = 255;
	
	if (vol > 10)
		Play(sound, vol, pan);
}
