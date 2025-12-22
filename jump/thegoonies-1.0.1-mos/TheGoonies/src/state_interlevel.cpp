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

#include "font_extractor.h"

extern bool fullscreen;
extern SDL_Surface *screen_sfc;
extern SDL_Surface *toogle_video_mode(bool fullscreen);


int TheGooniesApp::interlevel_cycle(KEYBOARDSTATE *k)
{
	switch(m_interlevel_state) {
	case 0:	// appearing
			if (m_state_cycle==0) m_interlevel_music_channel=Sound_play(m_SFXM->get("levelclear"),m_music_volume);
			if (m_state_cycle>=50) {
				m_interlevel_state=1;
				m_interlevel_cycle=0;
				m_state_cycle=0;
			} // if
			break;
	case 1:	// text
			m_interlevel_cycle++;
			if (m_interlevel_cycle>=200 ||
				(k->keyboard[SDLK_ESCAPE] && !k->old_keyboard[SDLK_ESCAPE]) ||
				(k->keyboard[SDLK_SPACE] && !k->old_keyboard[SDLK_SPACE])) {
				m_interlevel_state=2;
				m_interlevel_cycle=0;
				m_state_cycle=0;
				Mix_HaltChannel(m_interlevel_music_channel);
				m_interlevel_music_channel=Sound_play_continuous(m_SFXM->get("cutscene"),m_music_volume);
				m_game->clear();
			} /* if */ 
			break;
	case 2:	// animation
			m_interlevel_cycle++;
			if (m_interlevel_cycle>=2200 ||
				(k->keyboard[SDLK_ESCAPE] && !k->old_keyboard[SDLK_ESCAPE]) ||
				(k->keyboard[SDLK_SPACE] && !k->old_keyboard[SDLK_SPACE])) {
				m_interlevel_state=3;
				m_state_cycle=0;
			} /* if */ 
			break;
	case 3:	// disppearing
			m_interlevel_cycle++;
			if (m_state_cycle>=50) {
				if (m_interlevel_music_channel!=-1) {
					Mix_HaltChannel(m_interlevel_music_channel);
					m_interlevel_music_channel=-1;
				} // if 
				m_current_level++;
				switch(m_current_level) {
				case 1:
					m_game->level_change(2,1,2,m_GLTM);
					break;
				case 2:
					m_game->level_change(3,1,2,m_GLTM);
					break;
				case 3:
					m_game->level_change(4,4,1,m_GLTM);
					break;
				case 4:
					m_game->level_change(5,1,2,m_GLTM);
					break;
				default:
					return THEGOONIES_STATE_MSX;
				} // switch 
				m_vc->reset();
				m_game_state=0;
				return THEGOONIES_STATE_GAME;
			} // if
			break;
	} // switch 

	return THEGOONIES_STATE_INTERLEVEL;
} /* TheGooniesApp::interlevel_cycle */ 


void TheGooniesApp::interlevel_draw(void)
{
	glClearColor(0,0,0,1);
    glClear(GL_COLOR_BUFFER_BIT);

	m_game->draw(m_GLTM);

	switch(m_interlevel_state) {
	case 0:	{
				float f=float(m_state_cycle)/50;

				glColor4f(0,0,0,f);
				glBegin(GL_QUADS);
				glVertex3f(0,256,0);
				glVertex3f(0,400,0);
				glVertex3f(640,400,0);
				glVertex3f(640,256,0);
				glEnd();
			}
			break;
	case 1:
			{
				char tmp[16];

				sprintf(tmp,"level clear!");

				// 1: text appearing
				if (m_interlevel_cycle>=0 && m_interlevel_cycle<50) {
					int x,y,dx,dy;
					float f=(1-(m_interlevel_cycle/50.0f));
					font_box_c("font",tmp,&x,&y,&dx,&dy,-2);

					f*=f;
					x=(int)(320+f*640);
					font_print_c(x,150,0,0,2,"font",tmp,-2);
				} // if 

				// 2: text braking
				if (m_interlevel_cycle>=50 && m_interlevel_cycle<150) {
					font_print_c(320,150,0,0,2,"font",tmp,-2);
				} // if

				// 3: text disappearing
				if (m_interlevel_cycle>=150 && m_interlevel_cycle<200) {
					int x,y,dx,dy;
					float f=(((m_interlevel_cycle-150)/50.0f));
					font_box_c("font",tmp,&x,&y,&dx,&dy,-2);

					f*=f;
					x=(int)(320-f*640);
					font_print_c(x,150,0,0,2,"font",tmp,-2);
				} // if 
			}
			break;
	case 2:	
	case 3:
			{
				float f=1;
				int i;
				bool scissor_state=(glIsEnabled(GL_SCISSOR_TEST) ? true:false);
				int scissor_window[4];

				if (m_interlevel_state==2) f=1;
				if (m_interlevel_state==3) f=float(50-m_state_cycle)/50;
				glEnable(GL_SCISSOR_TEST);
				if (scissor_state) glGetIntegerv(GL_SCISSOR_BOX,scissor_window);
				glScissor(screen_x(0),screen_y(80),screen_x(640),screen_y(144));

				glColor4f(0,0,0,f);
				glBegin(GL_QUADS);
				glVertex3f(0,0,0);
				glVertex3f(0,480,0);
				glVertex3f(640,480,0);
				glVertex3f(640,0,0);
				glEnd();

				// character:
				if (m_interlevel_cycle>50 &&
					m_interlevel_cycle<=300) {
					// running right:
					int sp=(m_interlevel_cycle/8)%4;
					if (sp==0) m_GLTM->get("intro-character-r1")->draw(1,1,1,f,512-(300-m_interlevel_cycle)*2.5f,296,0,0,1);
					if (sp==1) m_GLTM->get("intro-character-r2")->draw(1,1,1,f,512-(300-m_interlevel_cycle)*2.5f,296,0,0,1);
					if (sp==2) m_GLTM->get("intro-character-r1")->draw(1,1,1,f,512-(300-m_interlevel_cycle)*2.5f,296,0,0,1);
					if (sp==3) m_GLTM->get("intro-character-r3")->draw(1,1,1,f,512-(300-m_interlevel_cycle)*2.5f,296,0,0,1);
				} // if 
				if (m_interlevel_cycle>300 &&
					m_interlevel_cycle<=1500) {
					// standing left:
					m_GLTM->get("intro-character-standing-l")->draw(1,1,1,f,512,296,0,0,1);
				} // if 
				if (m_interlevel_cycle>1500 &&
					m_interlevel_cycle<=1850) {
					int sp=(m_interlevel_cycle/8)%2;
					// standing left:
					if (sp==0) m_GLTM->get("intro-character-knocked1")->draw(1,1,1,f,512,296,0,0,1);
					if (sp==1) m_GLTM->get("intro-character-knocked2")->draw(1,1,1,f,512,296,0,0,1);
				} // if 
				if (m_interlevel_cycle>1850 &&
					m_interlevel_cycle<=1900) {
					// standing left:
					m_GLTM->get("intro-character-standing-l")->draw(1,1,1,f,512,296,0,0,1);
				} // if 
				if (m_interlevel_cycle>1900 &&
					m_interlevel_cycle<=2200) {
					// running right:
					int sp=(m_interlevel_cycle/8)%4;
					if (sp==0) m_GLTM->get("intro-character-l1")->draw(1,1,1,f,512-(m_interlevel_cycle-1900)*2.5f,296,0,0,1);
					if (sp==1) m_GLTM->get("intro-character-l2")->draw(1,1,1,f,512-(m_interlevel_cycle-1900)*2.5f,296,0,0,1);
					if (sp==2) m_GLTM->get("intro-character-l1")->draw(1,1,1,f,512-(m_interlevel_cycle-1900)*2.5f,296,0,0,1);
					if (sp==3) m_GLTM->get("intro-character-l3")->draw(1,1,1,f,512-(m_interlevel_cycle-1900)*2.5f,296,0,0,1);
				} // if 

				// kids:
				for(i=0;i<7;i++) {
					if (m_interlevel_cycle>300+i*150 &&
						m_interlevel_cycle<=500+i*150) {
						// running right:
						int sp=(m_interlevel_cycle/8)%2;
						if (sp==0) m_GLTM->get("intro-kid-r1")->draw(1,1,1,f,(464-i*60)-(500+i*150-m_interlevel_cycle)*2.5f,312,0,0,1);
						if (sp==1) m_GLTM->get("intro-kid-r2")->draw(1,1,1,f,(464-i*60)-(500+i*150-m_interlevel_cycle)*2.5f,312,0,0,1);
					} // if 
					if (m_interlevel_cycle>500+i*150 &&
						m_interlevel_cycle<=1624+i*24) {
						// standing left:
						m_GLTM->get("intro-kid-standing")->draw(1,1,1,f,float(464-i*60),312,0,0,1);
					} // if 
				} // for

				// Fratelli:
				if (m_interlevel_cycle>1400 &&
					m_interlevel_cycle<=1500) {
					// wlking left:
					int sp=(m_interlevel_cycle/8)%2;
					if (sp==0) m_GLTM->get("intro-fratelli-l1")->draw(1,1,1,f,544+(1500-m_interlevel_cycle)*2.5f,296,0,0,1);
					if (sp==1) m_GLTM->get("intro-fratelli-l2")->draw(1,1,1,f,544+(1500-m_interlevel_cycle)*2.5f,296,0,0,1);
				} // if 
				if (m_interlevel_cycle>1500 &&
					m_interlevel_cycle<=1600) {
					// standing left:
					m_GLTM->get("intro-fratelli-l1")->draw(1,1,1,f,544,296,0,0,1);
				} // if 
				if (m_interlevel_cycle>1600 &&
					m_interlevel_cycle<=1780) {
					// wlking left:
					int sp=(m_interlevel_cycle/8)%2;
					if (sp==0) m_GLTM->get("intro-fratelli-l1")->draw(1,1,1,f,544-(m_interlevel_cycle-1600)*2.5f,296,0,0,1);
					if (sp==1) m_GLTM->get("intro-fratelli-l2")->draw(1,1,1,f,544-(m_interlevel_cycle-1600)*2.5f,296,0,0,1);
				} // if 
				if (m_interlevel_cycle>1780 &&
					m_interlevel_cycle<=1900) {
					// standing left:
					m_GLTM->get("intro-fratelli-r1")->draw(1,1,1,f,94,296,0,0,1);
				} // if 
				if (m_interlevel_cycle>1900 &&
					m_interlevel_cycle<=2000) {
					// wlking left:
					int sp=(m_interlevel_cycle/8)%2;
					if (sp==0) m_GLTM->get("intro-fratelli-l1")->draw(1,1,1,f,94-(m_interlevel_cycle-1900)*2.5f,296,0,0,1);
					if (sp==1) m_GLTM->get("intro-fratelli-l2")->draw(1,1,1,f,94-(m_interlevel_cycle-1900)*2.5f,296,0,0,1);
				} // if 

				if (!scissor_state) glDisable(GL_SCISSOR_TEST);
				if (scissor_state) glScissor(scissor_window[0],scissor_window[1],scissor_window[2],scissor_window[3]);

			}
			break;

	} // switch

	// password
	if (m_current_level<4) {
		int i;
		char tmp[2][24];
		char *passwords[5]={"goonies","mr sloth","goon docks","doubloon","one eyed willy"};

		sprintf(tmp[0],"password");
		sprintf(tmp[1],passwords[m_current_level+1]);
		for(i=0;i<2;i++) {
			// 1: text appearing
			if (m_interlevel_state==2 && m_state_cycle<50) {
				int x;
				float f=(1-(m_state_cycle/50.0f));
				f*=f;
				x=(int)(320+f*640);
				font_print_c(x,150+i*48,0,0,1,"font",tmp[i],-2);
			} // if 

			// 2: text braking
			if (m_interlevel_state==2 && m_state_cycle>=50) {
				font_print_c(320,150+i*48,0,0,1,"font",tmp[i],-2);
			} // if

			// 3: text disappearing
			if (m_interlevel_state==3 && m_state_cycle<50) {
				int x;
				float f=((m_state_cycle/50.0f));
				f*=f;
				x=(int)(320-f*640);
				font_print_c(x,150+i*48,0,0,1,"font",tmp[i],-2);
			} // if 
		} // for
	} // if 

} /* TheGooniesApp::interlevel_draw */ 

