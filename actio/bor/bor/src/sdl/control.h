#ifndef	CONTROL_H
#define	CONTROL_H

// Generic control stuff (keyboard+joystick).
#include <SDL_keysym.h>


#define		CONTROL_JOY_1		(SDLK_LAST)
#define		CONTROL_JOY_2		(SDLK_LAST+1)
#define		CONTROL_JOY_3		(SDLK_LAST+2)
#define		CONTROL_JOY_4		(SDLK_LAST+3)
#define		CONTROL_JOY_UP		(SDLK_LAST+4)
#define		CONTROL_JOY_DOWN	(SDLK_LAST+5)
#define		CONTROL_JOY_LEFT	(SDLK_LAST+6)
#define		CONTROL_JOY_RIGHT	(SDLK_LAST+7)
#define		CONTROL_JOY_5		(SDLK_LAST+8)
#define		CONTROL_JOY_6		(SDLK_LAST+9)



#define		CONTROL_ESC		SDLK_ESCAPE
#define		CONTROL_DEFAULT_START	SDLK_RETURN
#define		CONTROL_DEFAULT_UP	SDLK_UP
#define		CONTROL_DEFAULT_DOWN	SDLK_DOWN
#define		CONTROL_DEFAULT_LEFT	SDLK_LEFT
#define		CONTROL_DEFAULT_RIGHT	SDLK_RIGHT
#define		CONTROL_DEFAULT_FIRE1	SDLK_LCTRL		// ctrl
#define		CONTROL_DEFAULT_FIRE2	SDLK_LALT		// alt
#define		CONTROL_DEFAULT_FIRE3	SDLK_LSHIFT		// lshift
#define		CONTROL_DEFAULT_FIRE4	SDLK_RSHIFT	// rshift
#define		CONTROL_DEFAULT_FIRE5	SDLK_SPACE		// spacebar
#define		CONTROL_DEFAULT_FIRE6	SDLK_RCTRL		// r-ctrl
#define		CONTROL_DEFAULT_SCREENSHOT	SDLK_F12	// F12




typedef struct{
	int		settings[32];
	unsigned long	keyflags, newkeyflags;
	int		kb_break;
}s_playercontrols;





void control_exit(void);
void control_init(int joy_enable);
int control_usejoy(int enable);
int control_getjoyenabled(void);

void control_setkey(s_playercontrols * pcontrols, unsigned int flag, int key);
int control_scankey(void);

char * control_getkeyname(unsigned int keycode);
void control_update(s_playercontrols ** playercontrols, int numplayers);


#endif

