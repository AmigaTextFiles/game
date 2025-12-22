#ifdef KITSCHY_DEBUG_MEMORY 
#include "debug_memorymanager.h"
#endif

#ifdef _WIN32
#include "windows.h"
#endif

#include "stdio.h"
#include "math.h"
#include "stdlib.h"
#include "string.h"

#include "GL/gl.h"
#include "GL/glu.h"
#include "SDL.h"
#include "SDL_mixer.h"

#include "List.h"
#include "Symbol.h"
#include "2DCMC.h"
#include "auxiliar.h"
#include "GLTile.h"
#include "2DCMC.h"
#include "sound.h"
#include "keyboardstate.h"
#include "randomc.h"
#include "VirtualController.h"

#include "GLTManager.h"
#include "SFXManager.h"
#include "GObject.h"
#include "GO_enemy.h"
#include "GO_fratelli.h"
#include "GMap.h"
#include "TheGoonies.h"
#include "TheGooniesApp.h"

#define GAME_FADE_IN_TIME	25



int TheGooniesApp::game_cycle(KEYBOARDSTATE *k)
{
	// music volume specified and music channel available
	if (m_title_music_current_volume>0 && m_title_music_channel!=-1) {
		m_title_music_current_volume-=2;
		// crossfade title music and game music
		Mix_Volume(m_title_music_channel,m_title_music_current_volume);
		if (m_title_music_current_volume<=0) {
			Mix_HaltChannel(m_title_music_channel);
			m_title_music_channel=-1;
		} // if
	}

	if (m_game_state==0 && m_state_cycle>=GAME_FADE_IN_TIME) m_game_state=1;
	if (m_game_state==2 && m_state_cycle>=50) return THEGOONIES_STATE_KONAMI;

	if (m_game_state==2) {
		float f=0;
		f=float(50-m_state_cycle)/50.0F;
		m_game->set_music_volume((int)(m_music_volume*f));
		m_game->set_sfx_volume((int)(m_sfx_volume*f));
		m_game->set_ambient_volume((int)(m_ambient_volume*f));
	} // if 

	if (k->keyboard[m_keys_configuration[GKEY_QUIT]] &&
		!k->old_keyboard[m_keys_configuration[GKEY_QUIT]] && m_game_state==1) {
		m_game_state=2;
		m_state_cycle=0;
	} // if 

	m_vc->new_cycle();
	if (k->keyboard[m_keys_configuration[GKEY_UP]]) m_vc->m_joystick[VC_UP]=true;
											   else m_vc->m_joystick[VC_UP]=false;
	if (k->keyboard[m_keys_configuration[GKEY_RIGHT]]) m_vc->m_joystick[VC_RIGHT]=true;
											      else m_vc->m_joystick[VC_RIGHT]=false;
	if (k->keyboard[m_keys_configuration[GKEY_DOWN]]) m_vc->m_joystick[VC_DOWN]=true;
											     else m_vc->m_joystick[VC_DOWN]=false;
	if (k->keyboard[m_keys_configuration[GKEY_LEFT]]) m_vc->m_joystick[VC_LEFT]=true;
											     else m_vc->m_joystick[VC_LEFT]=false;
	if (k->keyboard[m_keys_configuration[GKEY_FIRE]]) m_vc->m_button[0]=true;
											     else m_vc->m_button[0]=false;
	m_vc->m_button[1]=false;
	if (k->keyboard[m_keys_configuration[GKEY_PAUSE]]) m_vc->m_pause=true;
											      else m_vc->m_pause=false;
	if (k->keyboard[m_keys_configuration[GKEY_QUIT]]) m_vc->m_quit=true;
											     else m_vc->m_quit=false;

	if (!m_game->cycle(m_vc,m_GLTM,m_SFXM)) {
		if (m_game->levelCompleteP()) {
			// Go to the level finished state ( ... )
			m_gameover_state=0;
			m_interlevel_state=0;
			m_interlevel_cycle=0;
			if (m_current_level==4) return THEGOONIES_STATE_ENDSEQUENCE;
							   else return THEGOONIES_STATE_INTERLEVEL;
		} else {
			m_gameover_state=0;
			Sound_play(m_SFXM->get("gameover"),m_music_volume);
			return THEGOONIES_STATE_GAMEOVER;
		} // if 
	} // if 

	return THEGOONIES_STATE_GAME;
} /* TheGooniesApp::game_cycle */ 


void TheGooniesApp::game_draw(void)
{
	glClearColor(0,0,0,1);
    glClear(GL_COLOR_BUFFER_BIT);

	m_game->draw(m_GLTM);

	if (m_game_state==0) {
		glEnable(GL_COLOR_MATERIAL);

		{
			float f=0;
			f=float(GAME_FADE_IN_TIME-m_state_cycle)/GAME_FADE_IN_TIME;
			glColor4f(0,0,0,f);
		}
		glNormal3f(0.0,0.0,1.0);

		glDisable(GL_DEPTH_TEST);
		glBegin(GL_QUADS);
		glVertex3f(0,0,0);
		glVertex3f(0,480,0);
		glVertex3f(640,480,0);
		glVertex3f(640,0,0);
		glEnd();
		glEnable(GL_DEPTH_TEST);
	} // if 

	if (m_game_state==2) {
		glEnable(GL_COLOR_MATERIAL);

		{
			float f=0;
			f=float(m_state_cycle)/50.0F;
			glColor4f(0,0,0,f);
		}
		glNormal3f(0.0,0.0,1.0);

		glDisable(GL_DEPTH_TEST);
		glBegin(GL_QUADS);
		glVertex3f(0,0,0);
		glVertex3f(0,480,0);
		glVertex3f(640,480,0);
		glVertex3f(640,0,0);
		glEnd();
		glEnable(GL_DEPTH_TEST);
	} // if 


} /* TheGooniesApp::game_draw */ 

