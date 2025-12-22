#ifndef	CONTROL_H
#define	CONTROL_H

// Generic control stuff (keyboard+joystick).
enum {
	PAD_SQUARE = 1,
	PAD_TRIANGLE,
	PAD_CIRCLE,
	PAD_CROSS,
	PAD_UP,
	PAD_DOWN,
	PAD_LEFT,
	PAD_RIGHT,
	PAD_START,
	PAD_SELECT,
	PAD_LTRIGGER,
	PAD_RTRIGGER,
	PAD_HOLD,
};


#define		CONTROL_JOY_1		PAD_CROSS
#define		CONTROL_JOY_2		PAD_CIRCLE
#define		CONTROL_JOY_3		PAD_TRIANGLE
#define		CONTROL_JOY_4		PAD_SQUARE
#define		CONTROL_JOY_UP		PAD_UP
#define		CONTROL_JOY_DOWN	PAD_DOWN
#define		CONTROL_JOY_LEFT	PAD_LEFT
#define		CONTROL_JOY_RIGHT	PAD_RIGHT
#define		CONTROL_JOY_5		PAD_START
#define		CONTROL_JOY_6		PAD_SELECT



#define		CONTROL_ESC		PAD_SELECT
#define		CONTROL_DEFAULT_START	PAD_START
#define		CONTROL_DEFAULT_UP	PAD_UP
#define		CONTROL_DEFAULT_DOWN	PAD_DOWN
#define		CONTROL_DEFAULT_LEFT	PAD_LEFT
#define		CONTROL_DEFAULT_RIGHT	PAD_RIGHT
#define		CONTROL_DEFAULT_FIRE1	PAD_CROSS		// ctrl
#define		CONTROL_DEFAULT_FIRE2	PAD_CIRCLE		// alt
#define		CONTROL_DEFAULT_FIRE3	PAD_TRIANGLE		// lshift
#define		CONTROL_DEFAULT_FIRE4	PAD_SQUARE	// rshift
#define		CONTROL_DEFAULT_FIRE5	PAD_LTRIGGER		// spacebar
#define		CONTROL_DEFAULT_FIRE6	PAD_RTIGGER		// r-ctrl
#define		CONTROL_DEFAULT_SCREENSHOT	0	// F12




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

