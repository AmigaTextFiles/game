// Generic control stuff (keyboard+joystick)

#include <stdio.h>		// kbhit, getch
#include <stdlib.h>
#include "control.h"

#include <SDL.h>



// Key names
/*
typedef struct {
	unsigned keycode,
	const char* name;
} keyname_t;

const static keyname_t keynames[] = {
#include "keynames.h"
};

static const char *joynames[10] = {
	"Joy Fire 1",
	"Joy Fire 2",
	"Joy Fire 3",
	"Joy Fire 4",
	"Joy Up",
	"Joy Down",
	"Joy Left",
	"Joy Right",
	"Joy Fire 5",
	"Joy Fire 6"
};
*/



static int usejoy;





static int flag_to_index(unsigned long flag){
	int index = 0;
	unsigned long bit = 1;

	while(!((bit<<index)&flag) && index<31) ++index;
	return index;
}

SDL_Joystick *joy0, *joy1;








void control_exit(){
	SDL_JoystickClose(joy0);
	SDL_JoystickClose(joy1);
	usejoy = 0;
}



void control_init(int joy_enable){
//	if(joy_enable) usejoy = joy_init();
	joy0 = SDL_JoystickOpen(0);
	joy1 = SDL_JoystickOpen(1);
	if(joy0 || joy1)
	{
		SDL_JoystickEventState(SDL_ENABLE);
	}
}



int control_usejoy(int enable)
{
	usejoy = enable;
//	if(usejoy) return joy_init();
//	joy_exit();
	return 0;
}


int control_getjoyenabled(void)
{
	return usejoy;
}




void control_setkey(s_playercontrols * pcontrols, unsigned int flag, int key){
	if(!pcontrols) return;
	pcontrols->settings[flag_to_index(flag)] = key;
	pcontrols->keyflags = pcontrols->newkeyflags = 0;
}

static int lastkey;
int keyboard_getlastkey(void)
{
	int ret = lastkey;
	lastkey = 0;

	return ret;
}


// Scan input for newly-pressed keys.
// Return value:
// 0  = no key was pressed
// >0 = key code for pressed key
// <0 = error
int control_scankey(void)
{
	return keyboard_getlastkey();
#if 0
	static int ready = 0;
	int k=0, b=0;
	int index;

	k = keyboard_getlastkey();
	if(usejoy) b = joy_getstate();

	if(ready && (k|b)){
		ready = 0;
		if(k) return k;
		if(b & JOY_1) return CONTROL_JOY_1;
		if(b & JOY_2) return CONTROL_JOY_2;
		if(b & JOY_3) return CONTROL_JOY_3;
		if(b & JOY_4) return CONTROL_JOY_4;
		if(b & JOY_5) return CONTROL_JOY_5;
		if(b & JOY_6) return CONTROL_JOY_6;
		if(b & JOY_UP) return CONTROL_JOY_UP;
		if(b & JOY_DOWN) return CONTROL_JOY_DOWN;
		if(b & JOY_LEFT) return CONTROL_JOY_LEFT;
		if(b & JOY_RIGHT) return CONTROL_JOY_RIGHT;
		return -1;
	}
	ready = (!(k|b));
#endif
	return 0;
}



/*
static int cmp(const void* v1, const void *v2)
{
	return ((keyname_t*)v1)->keycode - ((keyname_t*)v2)->keycode;
}
*/

char * control_getkeyname(unsigned int keycode){

/*
	keyname_t tmp,*find;
	tmp.keycode = keycode;
	find = bsearch(&tmp,keynames,sizeof(keynames)/sizeof(keyname_t),sizeof(keyname_t),&cmp);
	if (find) return find->name;
	return "...";
*/
	switch(keycode) {
	case CONTROL_JOY_1:return "JOY Fire 1";
	case CONTROL_JOY_2:return "JOY Fire 2";
	case CONTROL_JOY_3:return "JOY Fire 3";
	case CONTROL_JOY_4:return "JOY Fire 4";
	case CONTROL_JOY_5:return "JOY Fire 5";
	case CONTROL_JOY_6:return "JOY Fire 6";
	case CONTROL_JOY_UP:return "JOY_UP";
	case CONTROL_JOY_DOWN:return "JOY_DOWN";
	case CONTROL_JOY_LEFT:return "JOY_LEFT";
	case CONTROL_JOY_RIGHT:return "JOY_RIGHT";
	default:
		return SDL_GetKeyName(keycode);
	}
}







void control_update(s_playercontrols ** playercontrols, int numplayers){

	unsigned long k;
	unsigned long jf;
	unsigned long i;
	int player;
	int t;
	s_playercontrols * pcontrols;
	int kb_break = 0; //keyboard_checkbreak();
//	if(usejoy) jf = joy_getstate();
//	if(jf == 0xFFFFFFFF) usejoy = 0;
	Uint8* keystate;
	
	SDL_Event ev;

	static unsigned long ktmp[2] = {0, 0};

	while(SDL_PollEvent(&ev)) {
		switch(ev.type) {
		case SDL_KEYDOWN:
			lastkey = ev.key.keysym.sym;
			if (lastkey==SDLK_F11) video_fullscreen_flip();
			if (lastkey!=SDLK_F10) break;
		case SDL_QUIT:
			exit(0);
			break;

		case SDL_JOYHATMOTION:
			if(ev.jhat.which < 2)
			{
				if(ev.jhat.value & SDL_HAT_LEFT)
				{
					ktmp[ev.jaxis.which] |= (1 << 2);
				}
				else
				{
					ktmp[ev.jaxis.which] &= ~(1 << 2);
				}

				if(ev.jhat.value & SDL_HAT_RIGHT)
				{
					ktmp[ev.jaxis.which] |= (1 << 3);
				}
				else
				{
					ktmp[ev.jaxis.which] &= ~(1 << 3);
				}

				if(ev.jhat.value & SDL_HAT_UP)
				{
					ktmp[ev.jaxis.which] |= (1 << 4);
				}
				else
				{
					ktmp[ev.jaxis.which] &= ~(1 << 4);
				}

				if(ev.jhat.value & SDL_HAT_DOWN)
				{
					ktmp[ev.jaxis.which] |= (1 << 5);
				}
				else
				{
					ktmp[ev.jaxis.which] &= ~(1 << 5);
				}
			}
			break;

			//ktmp[ev.jaxis.which] |= (1 << 0); // esc
			//ktmp[ev.jaxis.which] |= (1 << 1); // pause

		case SDL_JOYBUTTONDOWN:
		case SDL_JOYBUTTONUP:
			if(ev.jhat.which < 2)
			{
				switch(ev.jbutton.button)
				{
					case 0:
						if(ev.jbutton.state)
						{
							ktmp[ev.jaxis.which] |= (1 << 6);
						}
						else
						{
							ktmp[ev.jaxis.which] &= ~(1 << 6);
						}
						break;

					case 1:
						if(ev.jbutton.state)
						{
							ktmp[ev.jaxis.which] |= (1 << 7);
						}
						else
						{
							ktmp[ev.jaxis.which] &= ~(1 << 7);
						}
						break;

					case 2:
						if(ev.jbutton.state)
						{
							ktmp[ev.jaxis.which] |= (1 << 8);
						}
						else
						{
							ktmp[ev.jaxis.which] &= ~(1 << 8);
						}
						break;

					case 4: // start
						if(ev.jbutton.state)
						{
							ktmp[ev.jaxis.which] |= (1 << 1);
						}
						else
						{
							ktmp[ev.jaxis.which] &= ~(1 << 1);
						}
						break;

					default:
						break;
				}
			}
			break;

		default:
			break;
		}
	}
	
	keystate = SDL_GetKeyState(NULL);

	for(player=0; player<numplayers; player++){

		pcontrols = playercontrols[player];

		k = 0;

		for(i=0; i<32; i++){
			t = pcontrols->settings[i];
			if(t >= SDLK_FIRST && t < SDLK_LAST){
				if(keystate[t]) k |= (1<<i);
			}
		}
		pcontrols->kb_break = kb_break;

#if 0
		if(usejoy){
			for(i=0; i<32; i++){
				t = pcontrols->settings[i];
				switch(t){
					case CONTROL_JOY_1:
						if(jf & JOY_1) k |= (1<<i);
						break;
					case CONTROL_JOY_2:
						if(jf & JOY_2) k |= (1<<i);
						break;
					case CONTROL_JOY_3:
						if(jf & JOY_3) k |= (1<<i);
						break;
					case CONTROL_JOY_4:
						if(jf & JOY_4) k |= (1<<i);
						break;
					case CONTROL_JOY_UP:
						if(jf & JOY_UP) k |= (1<<i);
						break;
					case CONTROL_JOY_DOWN:
						if(jf & JOY_DOWN) k |= (1<<i);
						break;
					case CONTROL_JOY_LEFT:
						if(jf & JOY_LEFT) k |= (1<<i);
						break;
					case CONTROL_JOY_RIGHT:
						if(jf & JOY_RIGHT) k |= (1<<i);
						break;
					case CONTROL_JOY_5:
						if(jf & JOY_5) k |= (1<<i);
						break;
					case CONTROL_JOY_6:
						if(jf & JOY_6) k |= (1<<i);
						break;
				}
			}
		}
#endif
		if(numplayers < 3)
		{
			k |= ktmp[player];
		}

		pcontrols->newkeyflags = k & (~pcontrols->keyflags);
		pcontrols->keyflags = k;
	}
}













