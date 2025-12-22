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



int TheGooniesApp::endsequence_cycle(KEYBOARDSTATE *k)
{
	switch(m_endsequence_state) {
	case 0:	// appearing
			if (m_state_cycle==0) m_endsequence_music_channel=Sound_play(m_SFXM->get("levelclear"),m_music_volume);
			if (m_state_cycle>=50) {
				m_endsequence_state=1;
				m_endsequence_cycle=0;
				m_state_cycle=0;
			} // if
			break;
	case 1:	// text
			m_endsequence_cycle++;
			if (m_endsequence_cycle>=200 ||
				(k->keyboard[SDLK_ESCAPE] && !k->old_keyboard[SDLK_ESCAPE]) ||
				(k->keyboard[SDLK_SPACE] && !k->old_keyboard[SDLK_SPACE])) {
				m_endsequence_state=2;
				m_endsequence_cycle=0;
				m_state_cycle=0;

				Mix_HaltChannel(m_endsequence_music_channel);
				m_endsequence_music_channel=Sound_play_continuous(m_SFXM->get("cutscene"),m_music_volume);
				if (m_game!=0) m_game->clear();
			} /* if */ 
			break;
	case 2:	// animation
			m_endsequence_cycle++;
			if (m_endsequence_cycle>=2000 ||
				(k->keyboard[SDLK_ESCAPE] && !k->old_keyboard[SDLK_ESCAPE]) ||
				(k->keyboard[SDLK_SPACE] && !k->old_keyboard[SDLK_SPACE])) {
				m_endsequence_state=3;
				m_state_cycle=0;
			} /* if */ 
			break;
	case 3:	// disppearing
			m_endsequence_cycle++;
			if (m_endsequence_music_channel!=-1) {
				float f=1-(m_state_cycle/50.0f);
				Mix_Volume(m_endsequence_music_channel,int(m_music_volume*f));
			} // if
			if (m_state_cycle>=50) {
				if (m_endsequence_music_channel!=-1) {
					Mix_HaltChannel(m_endsequence_music_channel);
				} // if 
				m_endsequence_music_channel=Sound_play_continuous(m_SFXM->get("endcredits"),m_music_volume);
				m_endsequence_state=4;
				m_endsequence_cycle=0;
				m_state_cycle=0;
			} // if
			break;
	case 4: // appearing credits:
			m_endsequence_cycle++;
			if (m_state_cycle>=50) {
				m_endsequence_state=5;
				m_state_cycle=0;
			} // if
			break;
	case 5: // credits:
			m_endsequence_cycle++;
			if (m_endsequence_cycle>=9250 ||
				(k->keyboard[SDLK_ESCAPE] && !k->old_keyboard[SDLK_ESCAPE]) ||
				(k->keyboard[SDLK_SPACE] && !k->old_keyboard[SDLK_SPACE])) {
				m_endsequence_state=6;
				m_state_cycle=0;
			} /* if */ 
			break;
	case 6: // disappearing credits:
			m_endsequence_cycle++;
			if (m_state_cycle>=50) {
				if (m_endsequence_music_channel!=-1) {
					Mix_HaltChannel(m_endsequence_music_channel);
					m_endsequence_music_channel=-1;
				} // if 
				return THEGOONIES_STATE_KONAMI;
			} // if
			break;
	} // switch 
	return THEGOONIES_STATE_ENDSEQUENCE;
} /* TheGooniesApp::endsequence_cycle */ 


void TheGooniesApp::endsequence_draw(void)
{
	glClearColor(0,0,0,1);
    glClear(GL_COLOR_BUFFER_BIT);

	switch(m_endsequence_state) {
	case 0:	{
				float f=float(m_state_cycle)/50;

				if (m_game!=0) m_game->draw(m_GLTM);

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

				if (m_game!=0) m_game->draw(m_GLTM);

				sprintf(tmp,"level clear!");

				// 1: text appearing
				if (m_endsequence_cycle>=0 && m_endsequence_cycle<50) {
					int x,y,dx,dy;
					float f=(1-(m_endsequence_cycle/50.0f));
					font_box_c("font",tmp,&x,&y,&dx,&dy,-2);

					f*=f;
					x=(int)(320+f*640);
					font_print_c(x,150,0,0,2,"font",tmp,-2);
				} // if 

				// 2: text braking
				if (m_endsequence_cycle>=50 && m_endsequence_cycle<150) {
					font_print_c(320,150,0,0,2,"font",tmp,-2);
				} // if

				// 3: text disappearing
				if (m_endsequence_cycle>=150 && m_endsequence_cycle<200) {
					int x,y,dx,dy;
					float f=(((m_endsequence_cycle-150)/50.0f));
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

				if (m_endsequence_state==2) f=1;
				if (m_endsequence_state==3) f=float(50-m_state_cycle)/50;
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
				if (m_endsequence_cycle>50 &&
					m_endsequence_cycle<=300) {
					// running right:
					int sp=(m_endsequence_cycle/8)%4;
					if (sp==0) m_GLTM->get("intro-character-r1")->draw(1,1,1,f,512-(300-m_endsequence_cycle)*2.5f,296,0,0,1);
					if (sp==1) m_GLTM->get("intro-character-r2")->draw(1,1,1,f,512-(300-m_endsequence_cycle)*2.5f,296,0,0,1);
					if (sp==2) m_GLTM->get("intro-character-r1")->draw(1,1,1,f,512-(300-m_endsequence_cycle)*2.5f,296,0,0,1);
					if (sp==3) m_GLTM->get("intro-character-r3")->draw(1,1,1,f,512-(300-m_endsequence_cycle)*2.5f,296,0,0,1);
				} // if 
				if (m_endsequence_cycle>300 &&
					m_endsequence_cycle<=1400) {
					// standing left:
					m_GLTM->get("intro-character-standing-l")->draw(1,1,1,f,512,296,0,0,1);
				} // if 
				if (m_endsequence_cycle>1400 &&
					m_endsequence_cycle<=1600) {
					// standing right:
					m_GLTM->get("intro-character-r1")->draw(1,1,1,f,512,296,0,0,1);
				} // if 
				if (m_endsequence_cycle>1600) {
					// standing right:
					m_GLTM->get("intro-character-thumbsup")->draw(1,1,1,f,512,296,0,0,1);
				} // if 

				// kids:
				for(i=0;i<7;i++) {
					if (m_endsequence_cycle>300+i*150 &&
						m_endsequence_cycle<=500+i*150) {
						// running right:
						int sp=(m_endsequence_cycle/8)%2;
						if (sp==0) m_GLTM->get("intro-kid-r1")->draw(1,1,1,f,(464-i*60)-(500+i*150-m_endsequence_cycle)*2.5f,312,0,0,1);
						if (sp==1) m_GLTM->get("intro-kid-r2")->draw(1,1,1,f,(464-i*60)-(500+i*150-m_endsequence_cycle)*2.5f,312,0,0,1);
					} // if 
					if (m_endsequence_cycle>500+i*150 &&
						m_endsequence_cycle<=1600) {
						// standing left:
						m_GLTM->get("intro-kid-standing")->draw(1,1,1,f,float(464-i*60),312,0,0,1);
					} // if 
					if (m_endsequence_cycle>1600) {
						// standing left:
						m_GLTM->get("intro-kid-happy")->draw(1,1,1,f,float(464-i*60),312,0,0,1);
					} // if 
				} // for

				// Fratelli:
				if (m_endsequence_cycle>1400 &&
					m_endsequence_cycle<=1500) {
					// wlking left:
					int sp=(m_endsequence_cycle/8)%2;
					if (sp==0) m_GLTM->get("intro-fratelli-l1")->draw(1,1,1,f,560+(1500-m_endsequence_cycle)*2.5f,296,0,0,1);
					if (sp==1) m_GLTM->get("intro-fratelli-l2")->draw(1,1,1,f,560+(1500-m_endsequence_cycle)*2.5f,296,0,0,1);
				} // if 
				if (m_endsequence_cycle>1500) {
					// taken down:
					int sp=(m_endsequence_cycle/8)%2;
					if (sp==0) m_GLTM->get("intro-fratelli-down1")->draw(1,1,1,f,560,296,0,0,1);
					if (sp==1) m_GLTM->get("intro-fratelli-down2")->draw(1,1,1,f,560,296,0,0,1);
				} // if 

				if (!scissor_state) glDisable(GL_SCISSOR_TEST);
				if (scissor_state) glScissor(scissor_window[0],scissor_window[1],scissor_window[2],scissor_window[3]);


				{
					char tmp[24];

					sprintf(tmp,"the end");
					// 1: text appearing
					if (m_endsequence_state==2 && m_endsequence_cycle>1500 && m_endsequence_cycle<1550) {
						int x;
						float f=(1-((m_endsequence_cycle-1500)/50.0f));
						f*=f;
						x=(int)(320+f*640);
						font_print_c(x,150,0,0,1,"font",tmp,-2);
					} // if 

					// 2: text braking
					if (m_endsequence_state==2 && m_endsequence_cycle>=1550) {
						font_print_c(320,150,0,0,1,"font",tmp,-2);
					} // if

					// 3: text disappearing
					if (m_endsequence_state==3 && m_endsequence_cycle>1950) {
						int x;
						float f=(((m_state_cycle-1950)/50.0f));
						f*=f;
						x=(int)(320-f*640);
						font_print_c(x,150,0,0,1,"font",tmp,-2);
					} // if 
				}


			}
			break;
			
	case 4:
	case 5:
	case 6:
			{
				char *text[]={
							"*- original game -",
							".konami 1986",
							".",
							"*- remake -",
							".brain games 2006",
							".",
							"*coding:",
							".santi \"popolon\" onta–on",
							".jorrith \"jorito\" schaap",
							".patrick \"patsie\" lina",
							".nene franz",
							".",
							"*graphics:",
							".david \"dfcastelao\" fernandez",
							".miikka \"mp83\" poikela",
							".daedalus",
							".kelesisv",
							".nene franz",
							".",
							"*music/sfx:",
							".jorrith \"jorito\" schaap",
							".",
							"*map creation:",
							".jesus \"[dk]\" perez rosales",
							".mauricio \"iamweasel\" braga",
							".patrick \"patsie\" lina",
							".santi \"popolon\" onta–on",
							".",
							"*beta testers:",
							".all of the above",
							".albert \"bifimsx\" beevendorp",
							".patrick \"vampier\" van arkel",
							".",
							"*special thanks:",
							".jason eames for web hosting",
							".jay r zay for the menu font",
							".the openmsx and bluemsx teams",
							".",
							""};
								
				float f=1;
				int start_y=500-m_endsequence_cycle/4;
				int i;

				if (m_endsequence_state==5) f=1;
				if (m_endsequence_state==4) f=float(m_state_cycle)/50;
				if (m_endsequence_state==6) f=float(50-m_state_cycle)/50;

				m_GLTM->get("bg_copyright_3")->draw(0,0,0,0,1);

				for(i=0;text[i][0]!=0;i++) {
					if ((start_y+i*30)<500)
						if (text[i][0]=='.') font_print_c(320,start_y+i*45,0,0,0.8f,"font",text[i]+1,-2);
										else font_print_c(320,start_y+i*45,0,0,1,"font_hl",text[i]+1,-2);
				} // for
				
				if (f!=1) {
					glColor4f(0,0,0,1-f);
					glBegin(GL_QUADS);
					glVertex3f(0,0,0);
					glVertex3f(0,480,0);
					glVertex3f(640,480,0);
					glVertex3f(640,0,0);
					glEnd();
				} // if

			}
			break;
	} // switch

} /* TheGooniesApp::endsequence_draw */ 

