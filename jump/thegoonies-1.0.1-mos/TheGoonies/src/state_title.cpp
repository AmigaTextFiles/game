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
extern int difficulty;
extern SDL_Surface *screen_sfc;
extern SDL_Surface *toogle_video_mode(bool fullscreen);

int TheGooniesApp::title_cycle(KEYBOARDSTATE *k)
{
	if (m_title_music_channel==-1) {
		m_title_music_channel=Sound_play_continuous(m_SFXM->get("title"),m_music_volume);
		m_title_music_current_volume=m_music_volume;
	} // if 

	if (m_title_music_channel!=-1 && m_title_state==2 && m_title_current_menu==0 && m_title_next_menu==-1 && m_title_option_selected==4) {
		float f=m_state_cycle/50.0f;
		Mix_Volume(m_title_music_channel,int(m_music_volume*(1-f)));
	} // if 


	if (m_title_state==0 && m_state_cycle>TITLE_INTRO_TIME) {
		m_time_since_last_key=0;
		m_title_state=1;
		m_state_cycle=0;
	} // if 

	if (m_title_state==2 && m_state_cycle>=25) {
		m_time_since_last_key=0;
		if (m_title_next_menu==-1) {
		} else if (m_title_next_menu==-2) {
			// go to intro animation:
			m_titleanimation_state=0;
			return THEGOONIES_STATE_TITLEANIMATION;
		} else if (m_title_next_menu==-3) {
			// go to how to play:
			m_howtoplay_state=0;
			m_howtoplay_cycle=0;
			return THEGOONIES_STATE_HOWTOPLAY;
		} else if (m_title_next_menu==-4) {
			// go to credits:
			m_credits_state=0;
			m_credits_cycle=0;
			return THEGOONIES_STATE_CREDITS;
		} else {
			m_title_current_menu=m_title_next_menu;
			m_title_next_menu=-1;
			m_title_state=1;
			m_state_cycle=0;
			m_title_option_selected=0;
		} // if 
	} // if 

	if (m_title_state==2 && m_state_cycle>=50) {
		switch(m_title_current_menu) {
		case 0:
			if (m_title_next_menu==-1) {
				m_title_password[0]=0;
				if (m_title_option_selected==0) {
					return THEGOONIES_STATE_GAMESTART;
				} // if 
				if (m_title_option_selected==4) {
					Mix_HaltChannel(m_title_music_channel);
					m_title_music_channel=-1;
					return THEGOONIES_STATE_NONE;
				} // if 
			} else {
			} // if 
			break;
		case 1:
			if (m_title_next_menu==-1) {
				Mix_HaltChannel(m_title_music_channel);
				m_title_music_channel=-1;
				return THEGOONIES_STATE_GAMESTART;
			} else {
			} // if 
			break;
		} // switch 
	} // if 

	switch(m_title_state) {
		case 0:
				if ((k->keyboard[SDLK_ESCAPE] && !k->old_keyboard[SDLK_ESCAPE]) ||
					(k->keyboard[SDLK_SPACE] && !k->old_keyboard[SDLK_SPACE])) {
					m_title_state=1;
					m_state_cycle=0;
				} // if 
				break;
		case 1:
				switch(m_title_current_menu) {
				case 0: // main menu:
					{
						if (k->keyboard[SDLK_k] && 
							!k->old_keyboard[SDLK_k]) {
							m_title_state=2;
							m_state_cycle=0;
							m_title_next_menu=1;
							m_title_password[0]=0;
							Sound_play(m_SFXM->get("sfx/cursor_select"),m_sfx_volume);
							m_time_since_last_key=0;
						} // if 

						if ((k->keyboard[SDLK_ESCAPE] && !k->old_keyboard[SDLK_ESCAPE])) {
							m_title_option_selected=4;
							m_title_state=2;
							m_state_cycle=0;
							m_title_next_menu=-1;
							Sound_play(m_SFXM->get("sfx/cursor_select"),m_sfx_volume);
							m_time_since_last_key=0;
						} // if 

						if ((k->keyboard[SDLK_UP] && !k->old_keyboard[SDLK_UP])) {
							m_title_option_selected--;
							if (m_title_option_selected<0) m_title_option_selected=4;
							Sound_play(m_SFXM->get("sfx/cursor_move"),m_sfx_volume);
							m_time_since_last_key=0;
						} // if 

						if ((k->keyboard[SDLK_DOWN] && !k->old_keyboard[SDLK_DOWN])) {
							m_title_option_selected++;
							if (m_title_option_selected>4) m_title_option_selected=0;
							Sound_play(m_SFXM->get("sfx/cursor_move"),m_sfx_volume);
							m_time_since_last_key=0;
						} // if 

						if ((k->keyboard[SDLK_SPACE] && !k->old_keyboard[SDLK_SPACE]) ||
							(k->keyboard[SDLK_RETURN] && !k->old_keyboard[SDLK_RETURN])) {
							if (m_title_option_selected==0 ||
								m_title_option_selected==4) {
								m_title_state=2;
								m_state_cycle=0;
								m_title_next_menu=-1;
								Sound_play(m_SFXM->get("sfx/cursor_select"),m_sfx_volume);
							} // if 
							if (m_title_option_selected==2) {
								m_title_state=2;
								m_state_cycle=0;
								m_title_next_menu=2;
								Sound_play(m_SFXM->get("sfx/cursor_select"),m_sfx_volume);
							} // if 
							if (m_title_option_selected==1) {
								// HOW TO PLAY
								m_title_state=2;
								m_state_cycle=0;
								m_title_next_menu=-3;
								Sound_play(m_SFXM->get("sfx/cursor_select"),m_sfx_volume);
							} // if 
							if (m_title_option_selected==3) {
								// CREDITS
								m_title_state=2;
								m_state_cycle=0;
								m_title_next_menu=-4;
								Sound_play(m_SFXM->get("sfx/cursor_select"),m_sfx_volume);
							} // if 
							m_time_since_last_key=0;
						} /* if */ 

					}
					m_time_since_last_key++;
					if (m_time_since_last_key>1000) {
						// Show intro animation:
						m_title_state=2;
						m_state_cycle=0;
						m_title_next_menu=-2;
					} // if 
					break;

				case 1: // entering password:
					{
						int i;
						int letters[37]={SDLK_a,SDLK_b,SDLK_c,SDLK_d,SDLK_e,
									     SDLK_f,SDLK_g,SDLK_h,SDLK_i,SDLK_j,
									     SDLK_k,SDLK_l,SDLK_m,SDLK_n,SDLK_o,
									     SDLK_p,SDLK_q,SDLK_r,SDLK_s,SDLK_t,
									     SDLK_u,SDLK_v,SDLK_w,SDLK_x,SDLK_y,
									     SDLK_z,SDLK_SPACE,
									     SDLK_0,SDLK_1,SDLK_2,SDLK_3,SDLK_4,
									     SDLK_5,SDLK_6,SDLK_7,SDLK_8,SDLK_9};
						char characters[37]={'a','b','c','d','e',
											 'f','g','h','i','j',
											 'k','l','m','n','o',
											 'p','q','r','s','t',
											 'u','v','w','x','y',
											 'z',' ',
											 '0','1','2','3','4',
											 '5','6','7','8','9'};
										

						if ((k->keyboard[SDLK_ESCAPE] && !k->old_keyboard[SDLK_ESCAPE])) {
							m_title_state=2;
							m_state_cycle=0;
							m_title_next_menu=0;
							Sound_play(m_SFXM->get("sfx/cursor_select"),m_sfx_volume);
						} // if 

						if ((k->keyboard[SDLK_RETURN] && !k->old_keyboard[SDLK_RETURN])) {
							m_title_state=2;
							m_state_cycle=0;
							m_title_next_menu=-1;
							Sound_play(m_SFXM->get("sfx/cursor_select"),m_sfx_volume);
						} // if 

						if ((k->keyboard[SDLK_BACKSPACE] && !k->old_keyboard[SDLK_BACKSPACE])) {
							int l=strlen(m_title_password);
							if (l>0) {
								l--;
								m_title_password[l]=0;
								Sound_play(m_SFXM->get("sfx/cursor_move"),m_sfx_volume);
							} // if 
						} /* if */ 

						for(i=0;i<37;i++) {
							if ((k->keyboard[letters[i]] && !k->old_keyboard[letters[i]])) {
								int l=strlen(m_title_password);
								if (l==15) l--;

								m_title_password[l++]=characters[i];
								m_title_password[l]=0;
								Sound_play(m_SFXM->get("sfx/cursor_move"),m_sfx_volume);
							} // if 
						} // for 

					}
					break;

				case 2: // OPTIONS
					{
						if ((k->keyboard[SDLK_ESCAPE] && !k->old_keyboard[SDLK_ESCAPE])) {
							m_title_option_selected=6;
							m_title_state=2;
							m_state_cycle=0;
							m_title_next_menu=0;
							Sound_play(m_SFXM->get("sfx/cursor_select"),m_sfx_volume);
						} // if 

						if ((k->keyboard[SDLK_UP] && !k->old_keyboard[SDLK_UP])) {
							m_title_option_selected--;
							if (m_title_option_selected<0) m_title_option_selected=6;
							Sound_play(m_SFXM->get("sfx/cursor_move"),m_sfx_volume);
						} // if 

						if ((k->keyboard[SDLK_DOWN] && !k->old_keyboard[SDLK_DOWN])) {
							m_title_option_selected++;
							if (m_title_option_selected>6) m_title_option_selected=0;
							Sound_play(m_SFXM->get("sfx/cursor_move"),m_sfx_volume);
						} // if 

						if ((k->keyboard[SDLK_SPACE] && !k->old_keyboard[SDLK_SPACE]) ||
							(k->keyboard[SDLK_RETURN] && !k->old_keyboard[SDLK_RETURN])) {
							if (m_title_option_selected==0) {
                				fullscreen=(fullscreen ? false : true);				
								screen_sfc=toogle_video_mode(fullscreen);
							} // if 
							if (m_title_option_selected==1) {
								switch(m_sfx_volume) {
								case 0: m_sfx_volume=32;
										break;
								case 32: m_sfx_volume=64;
										break;
								case 64: m_sfx_volume=96;
										break;
								case 96: m_sfx_volume=MIX_MAX_VOLUME;
										break;
								case MIX_MAX_VOLUME: m_sfx_volume=0;
										break;
								default:m_sfx_volume=0;
								} // switch
								Sound_play(m_SFXM->get("sfx/cursor_select"),m_sfx_volume);
							} // if 
							if (m_title_option_selected==2) {
								switch(m_music_volume) {
								case 0: m_music_volume=32;
										break;
								case 32: m_music_volume=64;
										break;
								case 64: m_music_volume=96;
										break;
								case 96: m_music_volume=MIX_MAX_VOLUME;
										break;
								case MIX_MAX_VOLUME: m_music_volume=0;
										break;
								default:m_music_volume=0;
								} // switch
								if (m_title_music_channel!=-1) Mix_Volume(m_title_music_channel,m_music_volume);
								m_title_music_current_volume=m_music_volume;
								Sound_play(m_SFXM->get("sfx/cursor_select"),m_sfx_volume);
							} // if 
							if (m_title_option_selected==3) {
								switch(m_ambient_volume) {
									case 0: m_ambient_volume=32;
										break;
									case 32: m_ambient_volume=64;
										break;
									case 64: m_ambient_volume=96;
										break;
									case 96: m_ambient_volume=MIX_MAX_VOLUME;
										break;
									case MIX_MAX_VOLUME: m_ambient_volume=0;
										break;
									default:m_ambient_volume=0;
								} // switch
								Sound_play(m_SFXM->get("sfx/cursor_select"),m_sfx_volume);
							} // if 							
							if (m_title_option_selected==4) {
								Sound_play(m_SFXM->get("sfx/cursor_select"),m_sfx_volume);
								switch(difficulty) {
									case  25: difficulty=50;  break;
									case  50: difficulty=100; break;
									case 100: difficulty=150; break;
									case 150: difficulty=25;  break;
									default:  difficulty=100;
								}
							} // difficulty option
							if (m_title_option_selected==5) {
								m_title_state=2;
								m_state_cycle=0;
								m_title_next_menu=3;
								Sound_play(m_SFXM->get("sfx/cursor_select"),m_sfx_volume);
							} // if 
							if (m_title_option_selected==6) {
								m_title_state=2;
								m_state_cycle=0;
								m_title_next_menu=0;
								Sound_play(m_SFXM->get("sfx/cursor_select"),m_sfx_volume);
							} // if 

							save_configuration();
						} /* if */ 
					}

					break;

				case 3: // KEYBOARD
					{
						if (m_title_waiting_keystroke) {
							if (!k->keyevents.EmptyP()) {
								m_keys_configuration[m_title_option_selected]=k->keyevents[0]->sym;
								m_title_waiting_keystroke=false;

								save_configuration();
							} // if 
						} else {
							if ((k->keyboard[SDLK_ESCAPE] && !k->old_keyboard[SDLK_ESCAPE])) {
								m_title_option_selected=7;
								m_title_state=2;
								m_state_cycle=0;
								m_title_next_menu=2;
								Sound_play(m_SFXM->get("sfx/cursor_select"),m_sfx_volume);
							} // if 

							if ((k->keyboard[SDLK_UP] && !k->old_keyboard[SDLK_UP])) {
								m_title_option_selected--;
								if (m_title_option_selected<0) m_title_option_selected=7;
								Sound_play(m_SFXM->get("sfx/cursor_move"),m_sfx_volume);
							} // if 

							if ((k->keyboard[SDLK_DOWN] && !k->old_keyboard[SDLK_DOWN])) {
								m_title_option_selected++;
								if (m_title_option_selected>7) m_title_option_selected=0;
								Sound_play(m_SFXM->get("sfx/cursor_move"),m_sfx_volume);
							} // if 

							if ((k->keyboard[SDLK_SPACE] && !k->old_keyboard[SDLK_SPACE]) ||
								(k->keyboard[SDLK_RETURN] && !k->old_keyboard[SDLK_RETURN])) {								
								if (m_title_option_selected==7) {
									m_title_state=2;
									m_state_cycle=0;
									m_title_next_menu=2;
									Sound_play(m_SFXM->get("sfx/cursor_select"),m_sfx_volume);
								} else {
									m_title_waiting_keystroke=true;
								} // if 
							} /* if */ 
						} // if 
					}

					break;
				} // switch
				break;
		case 2:
				break;
	} // switch 


	return THEGOONIES_STATE_TITLE;
} /* TheGooniesApp::title_cycle */ 


void TheGooniesApp::title_draw(void)
{
	int menu_y=255;

	glClearColor(0,0,0,1);
    glClear(GL_COLOR_BUFFER_BIT);

	switch(m_title_state) {
	case 0:	
			{
				m_GLTM->get("bg_copyright");	// this line is just to freload the background
				if (m_state_cycle>(TITLE_INTRO_TIME-100)) {
					float f=float(m_state_cycle-(TITLE_INTRO_TIME-100))/100;
					if (f>=1) f=1;
					m_GLTM->get("bg_copyright")->draw(1,1,1,f);
				} // if 

				{
					float f=float(m_state_cycle)/TITLE_INTRO_TIME;
					if (f>=1) f=1;
					f=float(sqrt(f));
//					m_GLTM->get_smooth("title_logo")->draw(-5600,-850,0,0,16);
//					m_GLTM->get_smooth("title_logo")->draw(45,24,0,0,1);
					m_GLTM->get_smooth("title_logo")->draw((-5600)*(1-f)+46*f,(-850)*(1-f)+17*f,0,0,16*(1-f)+1*f);

				}



				if (m_state_cycle<100) {
					glEnable(GL_COLOR_MATERIAL);

					{
						float f=0;
						f=abs(int(100-m_state_cycle))/100.0F;
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
			}
			break;

	case 1:
	case 2:
			{
				int i;
				float f=m_state_cycle/25.0f;
				char *menu0_options[5]={"start","how to play","options","credits","quit"};
//				char *menu1_options[2]={"enter password:",""};
				char *menu2_options[7]={"fullscreen/window","sfx volume maximum ","music volume maximum","ambience maximum","difficulty normal","keyboard","back"};
				char *menu3_options[8]={"up/jump","right","down","left","punch","pause","quit","back"};

				m_GLTM->get("bg_copyright")->draw(0,0,0,0,1);
				m_GLTM->get_smooth("title_logo")->draw(46,17,0,0,1);

				if (m_title_state==2) f=1-f;
				if (f<0) f=0;
				if (f>1) f=1;

				switch(m_title_current_menu) {
				case 0: // MAIN MENU
					for(i=0;i<5;i++) {
						if (m_title_option_selected==i) {
							int x,y,dx,dy;
							font_print_c(320,menu_y+i*38,0,0,f,"font_hl",menu0_options[i],-4);
							font_box_c("font_hl",menu0_options[i],&x,&y,&dx,&dy,-4);
							m_GLTM->get("skull_cursor")->set_hotspot(m_GLTM->get("skull_cursor")->get_dx()/2,
																	 m_GLTM->get("skull_cursor")->get_dy()/2);
							m_GLTM->get("skull_cursor")->draw(float(320+(x-24)),float(menu_y+i*38),0,m_state_cycle*4.0f,f);
							m_GLTM->get("skull_cursor")->draw(float(320+(x+dx+24)),float(menu_y+i*38),0,-m_state_cycle*4.0f,f);
						} else {
							font_print_c(320,menu_y+i*38,0,0,f,"font",menu0_options[i],-2);
						} // if 
					} // for 
					break;
				case 1:	// ENTER PASSWORD
					{
						int x,y,dx,dy;

						font_print_c(320,menu_y+1*38,0,0,f,"font","enter password:",-2);
						
						font_print_c(320,menu_y+3*38,0,0,f,"font_hl",m_title_password,-4);
						font_box_c("font_hl",m_title_password,&x,&y,&dx,&dy,-4);
						m_GLTM->get("skull_cursor")->set_hotspot(m_GLTM->get("skull_cursor")->get_dx()/2,
																 m_GLTM->get("skull_cursor")->get_dy()/2);
						m_GLTM->get("skull_cursor")->draw(float(320+(x+dx+24)),float(menu_y+3*38),0,-m_state_cycle*4.0f,f);					
					}
					break;
				case 2:	// OPTIONS
					{
						char tmp[80];
						float factor=0.66f;

						for(i=0;i<7;i++) {
							sprintf(tmp,menu2_options[i]);
							if (i==1) {
								if (m_sfx_volume==0) sprintf(tmp,"sfx volume silent");
								if (m_sfx_volume==32) sprintf(tmp,"sfx volume low");
								if (m_sfx_volume==64) sprintf(tmp,"sfx volume medium");
								if (m_sfx_volume==96) sprintf(tmp,"sfx volume high");
								if (m_sfx_volume==MIX_MAX_VOLUME) sprintf(tmp,"sfx volume maximum");
							} // if
							if (i==2) {
								if (m_music_volume==0) sprintf(tmp,"music volume silent");
								if (m_music_volume==32) sprintf(tmp,"music volume low");
								if (m_music_volume==64) sprintf(tmp,"music volume medium");
								if (m_music_volume==96) sprintf(tmp,"music volume high");
								if (m_music_volume==MIX_MAX_VOLUME) sprintf(tmp,"music volume maximum");
							} // if							
							if (i==3) {
								if (m_ambient_volume==0) sprintf(tmp,"ambience silent");
								if (m_ambient_volume==32) sprintf(tmp,"ambience low");
								if (m_ambient_volume==64) sprintf(tmp,"ambience medium");
								if (m_ambient_volume==96) sprintf(tmp,"ambience high");
								if (m_ambient_volume==MIX_MAX_VOLUME) sprintf(tmp,"ambience maximum");
							} // if											
							if (i==4) {
								if (difficulty==0)   sprintf(tmp,"difficulty: god mode/no damage");
								if (difficulty==25)  sprintf(tmp,"difficulty: wimp/baby");
								if (difficulty==50)  sprintf(tmp,"difficulty: chunk/easy");
								if (difficulty==100) sprintf(tmp,"difficulty: mikey/normal");
								if (difficulty==150) sprintf(tmp,"difficulty: goonie/hard");
							}
							if (m_title_option_selected==i) {
								int x,y,dx,dy;
								font_print_c(320,(int)(menu_y+i*38*factor),0,0,f*factor,"font_hl",tmp,-4);
								font_box_c("font_hl",tmp,&x,&y,&dx,&dy,-4);
								m_GLTM->get("skull_cursor")->set_hotspot(m_GLTM->get("skull_cursor")->get_dx()/2,
																		 m_GLTM->get("skull_cursor")->get_dy()/2);
								m_GLTM->get("skull_cursor")->draw(320+(x-24)*factor,menu_y+i*38*factor,0,m_state_cycle*4.0f,f*factor);
								m_GLTM->get("skull_cursor")->draw(320+(x+dx+24)*factor,menu_y+i*38*factor,0,-m_state_cycle*4.0f,f*factor);
							} else {
								font_print_c(320,(int)(menu_y+i*38*factor),0,0,f*factor,"font",tmp,-2);
							} // if 
						} // for 
					}
					break;
				case 3: // KEYBOARD CONFIGURATION:
					{
						float factor=0.66f;
						char tmp[256]; 

						for(i=0;i<8;i++) {
							if (i<7) {
								if (m_title_waiting_keystroke && i==m_title_option_selected) {
									sprintf(tmp,"%s        -",menu3_options[i]);
								} else {
									sprintf(tmp,"%s        [%s]",menu3_options[i],SDL_GetKeyName(SDLKey(m_keys_configuration[i])));
								} // if 
							} else {
								sprintf(tmp,menu3_options[i]);
							} //
							if (m_title_option_selected==i) {
								int x,y,dx,dy;
								font_print_c(320,(int)(menu_y+i*38*factor),0,0,f*factor,"font_hl",tmp,-4);
								font_box_c("font_hl",tmp,&x,&y,&dx,&dy,-4);
								m_GLTM->get("skull_cursor")->set_hotspot(m_GLTM->get("skull_cursor")->get_dx()/2,
																		 m_GLTM->get("skull_cursor")->get_dy()/2);
								m_GLTM->get("skull_cursor")->draw(320+(x-24)*factor,menu_y+i*38*factor,0,m_state_cycle*4.0f,f*factor);
								m_GLTM->get("skull_cursor")->draw(320+(x+dx+24)*factor,menu_y+i*38*factor,0,-m_state_cycle*4.0f,f*factor);
							} else {
								font_print_c(320,(int)(menu_y+i*38*factor),0,0,f*factor,"font",tmp,-2);
							} // if 
						} // for 
					}
					break;
				} // switch

			}

			if (m_title_state==2 && m_title_next_menu==-1) {
				
				glEnable(GL_COLOR_MATERIAL);

				{
					float f=0;
					f=abs(int(m_state_cycle))/50.0F;
					if (f>=1) f=1;
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
			break;
	} // switch 

} /* TheGooniesApp::title_draw */ 

