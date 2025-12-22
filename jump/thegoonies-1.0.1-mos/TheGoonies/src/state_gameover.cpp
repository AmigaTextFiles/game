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

int TheGooniesApp::gameover_cycle(KEYBOARDSTATE *k)
{
	if (m_game!=0) m_game->cycle(m_vc,m_GLTM,m_SFXM);

	if (m_gameover_state==0) {
		if (m_state_cycle>50) {
			m_gameover_state=1;
			m_state_cycle=0;
		} // if 
	} // if 
	if (m_gameover_state==1) {
		if (m_state_cycle>50) {
			if (m_game!=0) {
				delete m_game;
				m_game=0;
			} // if 
			m_gameover_state=2;
			m_state_cycle=0;
		} // if 
	} // if 
	if (m_gameover_state==2) {
		if (m_state_cycle>250) {
			return THEGOONIES_STATE_KONAMI;
		} // if 
	} // if 

	return THEGOONIES_STATE_GAMEOVER;
} /* TheGooniesApp::gameover_cycle */ 


void TheGooniesApp::gameover_draw(void)
{
//	int MAP_DX=640,MAP_DY=400;

	glClearColor(0,0,0,1);
    glClear(GL_COLOR_BUFFER_BIT);

	if (m_game!=0) m_game->draw(m_GLTM);
	if (m_gameover_state==1) {
		float f=m_state_cycle/50.0F;
		glEnable(GL_COLOR_MATERIAL);
		glColor4f(0,0,0,1);

		glNormal3f(0.0,0.0,1.0);

		glDisable(GL_DEPTH_TEST);
		glBegin(GL_QUADS);
		glVertex3f(0,0,0);
		glVertex3f(0,480,0);
		glVertex3f(f*640,480,0);
		glVertex3f(f*640,0,0);
		glEnd();
		glEnable(GL_DEPTH_TEST);
	} // if 

	if (m_gameover_state==2) {
		char tmp[16];

		sprintf(tmp,"game over");

		// 1: text appearing
		if (m_state_cycle>=0 && m_state_cycle<50) {
			int x,y,dx,dy;
			float f=(1-(m_state_cycle/50.0f));
			font_box_c("font",tmp,&x,&y,&dx,&dy,-2);

			f*=f;
			x=(int)(320+f*640);
			font_print_c(x,150,0,0,2,"font",tmp,-2);
		} // if 

		// 2: text braking
		if (m_state_cycle>=50 && m_state_cycle<150) {
			font_print_c(320,150,0,0,2,"font",tmp,-2);
		} // if

		// 3: text disappearing
		if (m_state_cycle>=150 && m_state_cycle<200) {
			int x,y,dx,dy;
			float f=(((m_state_cycle-150)/50.0f));
			font_box_c("font",tmp,&x,&y,&dx,&dy,-2);

			f*=f;
			x=(int)(320-f*640);
			font_print_c(x,150,0,0,2,"font",tmp,-2);
		} // if 
	} // if 

} /* TheGooniesApp::gameover_draw */ 

