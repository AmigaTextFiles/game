#ifdef KITSCHY_DEBUG_MEMORY 
#include "debug_memorymanager.h"
#endif


#ifdef _WIN32
#include "windows.h"
#endif

#include "math.h"
#include "stdlib.h"
#include "string.h"

#include "GL/gl.h"
#include "GL/glu.h"
#include "SDL.h"
#include "SDL_image.h"
#include "SDL_mixer.h"

#include "List.h"

#include "auxiliar.h"
#include "2DCMC.h"
#include "Symbol.h"
#include "GLTile.h"
#include "keyboardstate.h"
#include "sound.h"

#include "GLTManager.h"
#include "SFXManager.h"
#include "GObject.h"
#include "GO_bigrock.h"

#include "GMap.h"


GO_bigrock::GO_bigrock(int x,int y,int sfx_volume,int color) : GObject(x,y,sfx_volume)
{
	m_class=new Symbol("GO_bigrock");

	m_color=color;
	m_original_y=y;
	m_chain_channel=-1;
	m_top_y=m_middle_y=-1;

	m_state_cycle=(rand()%4)*16;

	m_n_fall=0;
} /* GObject::GObject */ 


GO_bigrock::~GO_bigrock()
{
	stop_continuous_sfx();
} /* GObject::~GObject */ 


void GO_bigrock::stop_continuous_sfx(void)
{
	if (m_chain_channel!=-1) {
		Mix_HaltChannel(m_chain_channel);
		m_chain_channel=-1;
	} // if 
} /* GO_bigrock::stop_continuous_sfx */ 


void GO_bigrock::pause_continuous_sfx(void)
{
	if (m_chain_channel!=-1) {
		Mix_Pause(m_chain_channel);
	} // if 
} /* GO_bigrock::pause_continuous_sfx */ 


void GO_bigrock::resume_continuous_sfx(void)
{
	if (m_chain_channel!=-1) {
		Mix_Resume(m_chain_channel);
	} // if 
} /* GO_bigrock::resume_continuous_sfx */ 


bool GO_bigrock::cycle(VirtualController *k,GMap *map,int layer,GLTManager *GLTM,SFXManager *SFXM)
{
	// detect whether is normal big rock or a two heights big rock:
	if (m_top_y==-1) {
		m_last_tile_used=GLTM->get("ob_rock");
		if (map->collision_with_background(this,0,-20,GLTM)) {
			// normal big rock:
			m_top_y=m_original_y;
		} else {
			// two heights big rock:
			int offs=0;
			while(!map->collision_with_background(this,0,offs-20,GLTM) && m_original_y+offs>-40) {
				offs-=20;
			} // while
			m_top_y=m_original_y+offs;
			m_y=float(m_top_y);
			m_middle_y=m_original_y;
		} // if 
	} // if

	switch(m_state) {
	case 0:	// rock up
			m_top_y=(int)m_y;
			m_state_cycle++;
			if (m_state_cycle>64) {
				m_state=1;
				m_state_cycle=0;
				m_n_fall++;
			} // if 
			break;
	case 1: // rock falling
			if (m_chain_channel==-1) {
				m_chain_channel=Sound_play_continuous(SFXM->get("sfx/bigrock_winch"),m_sfx_volume);
			} // if 
			m_y+=4;
			if (m_middle_y==-1 || (m_n_fall%4)==3) {
				// normal fall
				if (map->collision_with_background(this,0,4,GLTM)) {
					if (m_chain_channel!=-1) {
						Mix_HaltChannel(m_chain_channel);
						m_chain_channel=-1;
					} // if 
					Sound_play(SFXM->get("sfx/bigrock_fall"),m_sfx_volume);
					map->set_shake();
					m_state=2;
					m_state_cycle=0;
				} // if 
			} else {
				// middle height fall
				if (m_y>=m_middle_y) {
					if (m_chain_channel!=-1) {
						Mix_HaltChannel(m_chain_channel);
						m_chain_channel=-1;
					} // if 
					Sound_play(SFXM->get("sfx/bigrock_fall"),m_sfx_volume);
					m_state=2;
					m_state_cycle=0;
				} // if 
			} // if
			break;
	case 2:	// rock down
			m_state_cycle++;
			if (m_state_cycle>64) {
				m_state=3;
				m_state_cycle=0;
			} // if 
			break;
	case 3: // rock rising
			if (m_chain_channel==-1) {
				m_chain_channel=Sound_play_continuous(SFXM->get("sfx/bigrock_winch"),m_sfx_volume);
			} // if 
			m_y--;
			if (m_y<=m_top_y) {
				if (m_chain_channel!=-1) {
					Mix_HaltChannel(m_chain_channel);
					m_chain_channel=-1;
				} // if 
				m_y=float(m_top_y);
				m_state=0;
				m_state_cycle=(rand()%4)*16;
			} // if 
			break;
	} // switch
	return true;
} /* GO_bigrock::cycle */ 


void GO_bigrock::draw(GLTManager *GLTM)
{
	int i;
	if (m_top_y!=-1) {
		for(i=m_top_y-20;i<m_y;i+=20) {
			GLTM->get("ob_chain")->draw(m_x,float(i),0,0,1);
		} // for 
	} // if
	if (m_color==0) m_last_tile_used=GLTM->get("ob_rock");
	if (m_color==1) m_last_tile_used=GLTM->get("ob_rock_blue");
	if (m_color==2) m_last_tile_used=GLTM->get("ob_rock_green");
	if (m_color==3) m_last_tile_used=GLTM->get("ob_rock_yellow");
	m_last_tile_used->draw(m_x,m_y,0,0,1);
} /* GO_bigrock::draw */ 


bool GO_bigrock::is_a(Symbol *c)
{
	if (c->cmp("GO_bigrock")) return true;

	return GObject::is_a(c);
} /* GO_bigrock::is_a */ 


bool GO_bigrock::is_a(char *c)
{
	bool retval;
	Symbol *s=new Symbol(c);

	retval=is_a(s);

	delete s;

	return retval;
} /* GO_bigrock::is_a */ 
