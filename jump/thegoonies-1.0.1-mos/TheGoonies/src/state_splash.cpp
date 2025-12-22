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



int TheGooniesApp::splash_cycle(KEYBOARDSTATE *k)
{
/*
	if ((k->keyboard[SDLK_ESCAPE] && !k->old_keyboard[SDLK_ESCAPE]) ||
		(k->keyboard[SDLK_SPACE] && !k->old_keyboard[SDLK_SPACE])) {
		if (m_state_cycle<450) {
			if (m_state_cycle<50) m_state_cycle=500-m_state_cycle;
						     else m_state_cycle=450;
		} // if 
	} // if  
*/
	if (m_state_cycle>=650) {
		return THEGOONIES_STATE_DISCLAIMER;
//		return THEGOONIES_STATE_MSX;
	} /* if */ 

	return THEGOONIES_STATE_SPLASH;
} /* TheGooniesApp::splash_cycle */ 


void TheGooniesApp::splash_draw(void)
{
	glClearColor(0,0,0,1);
    glClear(GL_COLOR_BUFFER_BIT);

	if (m_state_cycle>=50 && m_state_cycle<100) m_GLTM->get("2006_640x480")->draw((m_state_cycle-50)*0.02F,(m_state_cycle-50)*0.02F,(m_state_cycle-50)*0.02F,1.0F);
	if (m_state_cycle>=100 && m_state_cycle<600) m_GLTM->get("2006_640x480")->draw();
	if (m_state_cycle>=600 && m_state_cycle<650) m_GLTM->get("2006_640x480")->draw((650-m_state_cycle)*0.02F,(650-m_state_cycle)*0.02F,(650-m_state_cycle)*0.02F,1.0F);

} /* TheGooniesApp::splash_draw */ 

