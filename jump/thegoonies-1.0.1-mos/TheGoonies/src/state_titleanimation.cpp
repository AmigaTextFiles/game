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

#include "GLTManager.h"
#include "SFXManager.h"
#include "GObject.h"
#include "GO_enemy.h"
#include "GO_fratelli.h"
#include "GMap.h"
#include "TheGoonies.h"
#include "TheGooniesApp.h"

#include "font_extractor.h"

#define TITLE_INTRO_TIME	300
//#define TITLE_INTRO_TIME	50

extern bool fullscreen;
extern SDL_Surface *screen_sfc;
extern SDL_Surface *toogle_video_mode(bool fullscreen);


int TheGooniesApp::titleanimation_cycle(KEYBOARDSTATE *k)
{
	switch(m_titleanimation_state) {
	case 0:	// appearing
			if (m_state_cycle>=50) {
				m_titleanimation_state=1;
				m_titleanimation_cycle=0;
				m_state_cycle=0;
			} // if
			break;
	case 1:	// animation
			m_titleanimation_cycle++;
			if (m_titleanimation_cycle>=2200 ||
				(k->keyboard[SDLK_ESCAPE] && !k->old_keyboard[SDLK_ESCAPE]) ||
				(k->keyboard[SDLK_SPACE] && !k->old_keyboard[SDLK_SPACE])) {
				m_titleanimation_state=2;
				m_state_cycle=0;
			} /* if */ 
			break;
	case 2:	// disppearing
			m_titleanimation_cycle++;
			if (m_state_cycle>=50) {
				m_title_current_menu=0;
				m_title_next_menu=-1;
				m_title_state=1;
				m_state_cycle=0;
				m_title_option_selected=0;
				return THEGOONIES_STATE_TITLE;
			} // if
			break;
	} // switch 

	return THEGOONIES_STATE_TITLEANIMATION;
} /* TheGooniesApp::titleanimation_cycle */ 


void TheGooniesApp::titleanimation_draw(void)
{
	glClearColor(0,0,0,1);
    glClear(GL_COLOR_BUFFER_BIT);

	m_GLTM->get("bg_copyright")->draw(0,0,0,0,1);
	m_GLTM->get_smooth("title_logo")->draw(46,17,0,0,1);

	switch(m_titleanimation_state) {
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
	case 2:
			{
				float f=1;
				int i;
				bool scissor_state=(glIsEnabled(GL_SCISSOR_TEST) ? true:false);
				int scissor_window[4];

				if (m_titleanimation_state==1) f=1;
				if (m_titleanimation_state==2) f=float(50-m_state_cycle)/50;
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
				if (m_titleanimation_cycle>50 &&
					m_titleanimation_cycle<=300) {
					// running right:
					int sp=(m_titleanimation_cycle/8)%4;
					if (sp==0) m_GLTM->get("intro-character-r1")->draw(1,1,1,f,512-(300-m_titleanimation_cycle)*2.5f,296,0,0,1);
					if (sp==1) m_GLTM->get("intro-character-r2")->draw(1,1,1,f,512-(300-m_titleanimation_cycle)*2.5f,296,0,0,1);
					if (sp==2) m_GLTM->get("intro-character-r1")->draw(1,1,1,f,512-(300-m_titleanimation_cycle)*2.5f,296,0,0,1);
					if (sp==3) m_GLTM->get("intro-character-r3")->draw(1,1,1,f,512-(300-m_titleanimation_cycle)*2.5f,296,0,0,1);
				} // if 
				if (m_titleanimation_cycle>300 &&
					m_titleanimation_cycle<=1500) {
					// standing left:
					m_GLTM->get("intro-character-standing-l")->draw(1,1,1,f,512,296,0,0,1);
				} // if 
				if (m_titleanimation_cycle>1500 &&
					m_titleanimation_cycle<=1850) {
					int sp=(m_titleanimation_cycle/8)%2;
					// standing left:
					if (sp==0) m_GLTM->get("intro-character-knocked1")->draw(1,1,1,f,512,296,0,0,1);
					if (sp==1) m_GLTM->get("intro-character-knocked2")->draw(1,1,1,f,512,296,0,0,1);
				} // if 
				if (m_titleanimation_cycle>1850 &&
					m_titleanimation_cycle<=1900) {
					// standing left:
					m_GLTM->get("intro-character-standing-l")->draw(1,1,1,f,512,296,0,0,1);
				} // if 
				if (m_titleanimation_cycle>1900 &&
					m_titleanimation_cycle<=2200) {
					// running right:
					int sp=(m_titleanimation_cycle/8)%4;
					if (sp==0) m_GLTM->get("intro-character-l1")->draw(1,1,1,f,512-(m_titleanimation_cycle-1900)*2.5f,296,0,0,1);
					if (sp==1) m_GLTM->get("intro-character-l2")->draw(1,1,1,f,512-(m_titleanimation_cycle-1900)*2.5f,296,0,0,1);
					if (sp==2) m_GLTM->get("intro-character-l1")->draw(1,1,1,f,512-(m_titleanimation_cycle-1900)*2.5f,296,0,0,1);
					if (sp==3) m_GLTM->get("intro-character-l3")->draw(1,1,1,f,512-(m_titleanimation_cycle-1900)*2.5f,296,0,0,1);
				} // if 

				// kids:
				for(i=0;i<7;i++) {
					if (m_titleanimation_cycle>300+i*150 &&
						m_titleanimation_cycle<=500+i*150) {
						// running right:
						int sp=(m_titleanimation_cycle/8)%2;
						if (sp==0) m_GLTM->get("intro-kid-r1")->draw(1,1,1,f,(464-i*60)-(500+i*150-m_titleanimation_cycle)*2.5f,312,0,0,1);
						if (sp==1) m_GLTM->get("intro-kid-r2")->draw(1,1,1,f,(464-i*60)-(500+i*150-m_titleanimation_cycle)*2.5f,312,0,0,1);
					} // if 
					if (m_titleanimation_cycle>500+i*150 &&
						m_titleanimation_cycle<=1624+i*24) {
						// standing left:
						m_GLTM->get("intro-kid-standing")->draw(1,1,1,f,float(464-i*60),312,0,0,1);
					} // if 
				} // for

				// Fratelli:
				if (m_titleanimation_cycle>1400 &&
					m_titleanimation_cycle<=1500) {
					// wlking left:
					int sp=(m_titleanimation_cycle/8)%2;
					if (sp==0) m_GLTM->get("intro-fratelli-l1")->draw(1,1,1,f,544+(1500-m_titleanimation_cycle)*2.5f,296,0,0,1);
					if (sp==1) m_GLTM->get("intro-fratelli-l2")->draw(1,1,1,f,544+(1500-m_titleanimation_cycle)*2.5f,296,0,0,1);
				} // if 
				if (m_titleanimation_cycle>1500 &&
					m_titleanimation_cycle<=1600) {
					// standing left:
					m_GLTM->get("intro-fratelli-l1")->draw(1,1,1,f,544,296,0,0,1);
				} // if 
				if (m_titleanimation_cycle>1600 &&
					m_titleanimation_cycle<=1780) {
					// wlking left:
					int sp=(m_titleanimation_cycle/8)%2;
					if (sp==0) m_GLTM->get("intro-fratelli-l1")->draw(1,1,1,f,544-(m_titleanimation_cycle-1600)*2.5f,296,0,0,1);
					if (sp==1) m_GLTM->get("intro-fratelli-l2")->draw(1,1,1,f,544-(m_titleanimation_cycle-1600)*2.5f,296,0,0,1);
				} // if 
				if (m_titleanimation_cycle>1780 &&
					m_titleanimation_cycle<=1900) {
					// standing left:
					m_GLTM->get("intro-fratelli-r1")->draw(1,1,1,f,94,296,0,0,1);
				} // if 
				if (m_titleanimation_cycle>1900 &&
					m_titleanimation_cycle<=2000) {
					// wlking left:
					int sp=(m_titleanimation_cycle/8)%2;
					if (sp==0) m_GLTM->get("intro-fratelli-l1")->draw(1,1,1,f,94-(m_titleanimation_cycle-1900)*2.5f,296,0,0,1);
					if (sp==1) m_GLTM->get("intro-fratelli-l2")->draw(1,1,1,f,94-(m_titleanimation_cycle-1900)*2.5f,296,0,0,1);
				} // if 

				if (!scissor_state) glDisable(GL_SCISSOR_TEST);
				if (scissor_state) glScissor(scissor_window[0],scissor_window[1],scissor_window[2],scissor_window[3]);

			}
			break;
	} // switch

} /* TheGooniesApp::titleanimation_draw */ 

