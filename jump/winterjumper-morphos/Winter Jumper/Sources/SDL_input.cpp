#include "_variables.h"

//int JoyButtonIndex;
Uint8 *keys;

bool Key_UP;        int Key_UP_pressed_value;        bool Key_UP_pressed;
bool Key_RIGHT;     int Key_RIGHT_pressed_value;     bool Key_RIGHT_pressed;
bool Key_DOWN;      int Key_DOWN_pressed_value;      bool Key_DOWN_pressed;
bool Key_LEFT;      int Key_LEFT_pressed_value;      bool Key_LEFT_pressed;
bool Key_ESCAPE;    int Key_ESCAPE_pressed_value;    bool Key_ESCAPE_pressed;
bool Key_ENTER;     int Key_ENTER_pressed_value;     bool Key_ENTER_pressed;

bool Key_1;         int Key_1_pressed_value;         bool Key_1_pressed;
bool Key_2;         int Key_2_pressed_value;         bool Key_2_pressed;
bool Key_3;         int Key_3_pressed_value;         bool Key_3_pressed;
bool Key_4;         int Key_4_pressed_value;         bool Key_4_pressed;
bool Key_5;         int Key_5_pressed_value;         bool Key_5_pressed;
bool Key_6;         int Key_6_pressed_value;         bool Key_6_pressed;
bool Key_7;         int Key_7_pressed_value;         bool Key_7_pressed;
bool Key_8;         int Key_8_pressed_value;         bool Key_8_pressed;
bool Key_9;         int Key_9_pressed_value;         bool Key_9_pressed;
bool Key_0;         int Key_0_pressed_value;         bool Key_0_pressed;
bool Button_0;      int Button_0_pressed_value;      bool Button_0_pressed;
bool Button_1;      int Button_1_pressed_value;      bool Button_1_pressed;
bool Button_2;      int Button_2_pressed_value;      bool Button_2_pressed;
bool Button_3;      int Button_3_pressed_value;      bool Button_3_pressed;
bool Button_4;      int Button_4_pressed_value;      bool Button_4_pressed;

//bool JumpKey;
int JumpKey; int RELEASED_JumpKey;

void getInput()
{
	void SDL_PumpEvents(void);
	if(SDL_PollEvent(&sdlEvent)==0) //IS NEDDED! (WHY?)
	{
	keys = SDL_GetKeyState(NULL);
    Key_ESCAPE = false;
    Key_ENTER = false;
	Key_UP = false;
	Key_DOWN = false;
	Key_LEFT = false;
	Key_RIGHT = false;
	Button_0 = false;
	Button_1 = false;
	Button_2 = false;
	Button_3 = false;
	Key_1 = false;
	Key_2 = false;
	Key_3 = false;
    Key_4 = false;
    Key_5 = false;
    Key_6 = false;
    Key_7 = false;
    Key_8 = false;
    Key_9 = false;
    Key_0 = false;
    JumpKey = 0;

	if (keys[SDLK_ESCAPE] == true)		{Key_ESCAPE	=	true;}
 	if (keys[SDLK_RETURN] == true)		{Key_ENTER	=	true;}
	if (keys[SDLK_LEFT] == true)		{Key_LEFT	=	true;}
	if (keys[SDLK_RIGHT] == true)		{Key_RIGHT	=	true;}
	if (keys[SDLK_DOWN] == true)		{Key_DOWN	=	true;}
	if (keys[SDLK_UP] == true)			{Key_UP		=	true;}
	if (keys[SDLK_RSHIFT] == true)		{Button_1	=	true;}
    if (keys[SDLK_1] == true)		    {Key_1	    =	true;}
    if (keys[SDLK_2] == true)		    {Key_2	    =	true;}
    if (keys[SDLK_3] == true)		    {Key_3	    =	true;}        
    if (keys[SDLK_4] == true)		    {Key_4	    =	true;}
    if (keys[SDLK_5] == true)		    {Key_5	    =	true;}
    if (keys[SDLK_6] == true)		    {Key_6	    =	true;}
    if (keys[SDLK_7] == true)		    {Key_7	    =	true;}
    if (keys[SDLK_8] == true)		    {Key_8	    =	true;}
    if (keys[SDLK_9] == true)		    {Key_9	    =	true;}                    	
    if (keys[SDLK_0] == true)		    {Key_0	    =	true;}

	if(SDL_JoystickGetButton(SDL_JoystickOpen(0),2)) {Key_LEFT = true;}	// = left button
	if(SDL_JoystickGetButton(SDL_JoystickOpen(0),6)) {Key_RIGHT = true;}	// = right button
	if(SDL_JoystickGetButton(SDL_JoystickOpen(0),13)) {Key_UP = true;}	// = B button
	
    if(SDL_JoystickGetButton(SDL_JoystickOpen(0),8)) {Key_ENTER = true;}	// = start button
	if(SDL_JoystickGetButton(SDL_JoystickOpen(0),9)) {Key_ESCAPE = true;}	// = select button
	if(SDL_JoystickGetButton(SDL_JoystickOpen(0),14)) {Button_1 = true;}	// = X button


    if (Key_ENTER == false)	{Key_ENTER_pressed_value =	0; Key_ESCAPE_pressed = false;} else
                            {if (Key_ENTER_pressed_value == 2){Key_ENTER_pressed_value = 1; Key_ENTER_pressed = false;}
                             if (Key_ENTER_pressed_value == 0){Key_ENTER_pressed_value = 2; Key_ENTER_pressed = true;}}                             
    if (Key_ESCAPE == false){Key_ESCAPE_pressed_value =	0; Key_ESCAPE_pressed = false;} else
                            {if (Key_ESCAPE_pressed_value == 2){Key_ESCAPE_pressed_value = 1; Key_ESCAPE_pressed = false;}
                             if (Key_ESCAPE_pressed_value == 0){Key_ESCAPE_pressed_value = 2; Key_ESCAPE_pressed = true;}}
    if (Key_UP == false)	{Key_UP_pressed_value =	0; Key_UP_pressed = false;} else
                    {if (Key_UP_pressed_value == 2){Key_UP_pressed_value = 1; Key_UP_pressed = false;}
                     if (Key_UP_pressed_value == 0){Key_UP_pressed_value = 2; Key_UP_pressed = true;}}
    if (Key_LEFT == false)	{Key_LEFT_pressed_value =	0; Key_LEFT_pressed = false;} else
                    {if (Key_LEFT_pressed_value == 2){Key_LEFT_pressed_value = 1; Key_LEFT_pressed = false;}
                     if (Key_LEFT_pressed_value == 0){Key_LEFT_pressed_value = 2; Key_LEFT_pressed = true;}}
    if (Key_DOWN == false)	{Key_DOWN_pressed_value =	0; Key_DOWN_pressed = false;} else
                    {if (Key_DOWN_pressed_value == 2){Key_DOWN_pressed_value = 1; Key_DOWN_pressed = false;}
                     if (Key_DOWN_pressed_value == 0){Key_DOWN_pressed_value = 2; Key_DOWN_pressed = true;}}
    if (Key_RIGHT == false)	{Key_RIGHT_pressed_value =	0; Key_RIGHT_pressed = false;} else
                    {if (Key_RIGHT_pressed_value == 2){Key_RIGHT_pressed_value = 1; Key_RIGHT_pressed = false;}
                     if (Key_RIGHT_pressed_value == 0){Key_RIGHT_pressed_value = 2; Key_RIGHT_pressed = true;}}
                             
    if (Key_1 == false)	{Key_1_pressed_value =	0; Key_1_pressed = false;} else
                    {if (Key_1_pressed_value == 2){Key_1_pressed_value = 1; Key_1_pressed = false;}
                     if (Key_1_pressed_value == 0){Key_1_pressed_value = 2; Key_1_pressed = true;}}
    if (Key_2 == false)	{Key_2_pressed_value =	0; Key_2_pressed = false;} else
                    {if (Key_2_pressed_value == 2){Key_2_pressed_value = 1; Key_2_pressed = false;}
                     if (Key_2_pressed_value == 0){Key_2_pressed_value = 2; Key_2_pressed = true;}}
    if (Key_3 == false)	{Key_3_pressed_value =	0; Key_3_pressed = false;} else
                    {if (Key_3_pressed_value == 2){Key_3_pressed_value = 1; Key_3_pressed = false;}
                     if (Key_3_pressed_value == 0){Key_3_pressed_value = 2; Key_3_pressed = true;}}
    if (Key_4 == false)	{Key_4_pressed_value =	0; Key_4_pressed = false;} else
                    {if (Key_4_pressed_value == 2){Key_4_pressed_value = 1; Key_4_pressed = false;}
                     if (Key_4_pressed_value == 0){Key_4_pressed_value = 2; Key_4_pressed = true;}}
    if (Key_5 == false)	{Key_5_pressed_value =	0; Key_5_pressed = false;} else
                    {if (Key_5_pressed_value == 2){Key_5_pressed_value = 1; Key_5_pressed = false;}
                     if (Key_5_pressed_value == 0){Key_5_pressed_value = 2; Key_5_pressed = true;}}
    if (Key_6 == false)	{Key_6_pressed_value =	0; Key_6_pressed = false;} else
                    {if (Key_6_pressed_value == 2){Key_6_pressed_value = 1; Key_6_pressed = false;}
                     if (Key_6_pressed_value == 0){Key_6_pressed_value = 2; Key_6_pressed = true;}}
    if (Key_7 == false)	{Key_7_pressed_value =	0; Key_7_pressed = false;} else
                    {if (Key_7_pressed_value == 2){Key_7_pressed_value = 1; Key_7_pressed = false;}
                     if (Key_7_pressed_value == 0){Key_7_pressed_value = 2; Key_7_pressed = true;}}
    if (Key_8 == false)	{Key_8_pressed_value =	0; Key_8_pressed = false;} else
                    {if (Key_8_pressed_value == 2){Key_8_pressed_value = 1; Key_8_pressed = false;}
                     if (Key_8_pressed_value == 0){Key_8_pressed_value = 2; Key_8_pressed = true;}}
    if (Key_9 == false)	{Key_9_pressed_value =	0; Key_9_pressed = false;} else
                    {if (Key_9_pressed_value == 2){Key_9_pressed_value = 1; Key_9_pressed = false;}
                     if (Key_9_pressed_value == 0){Key_9_pressed_value = 2; Key_9_pressed = true;}}
    if (Key_0 == false)	{Key_0_pressed_value =	0; Key_0_pressed = false;} else
                    {if (Key_0_pressed_value == 2){Key_0_pressed_value = 1; Key_0_pressed = false;}
                     if (Key_0_pressed_value == 0){Key_0_pressed_value = 2; Key_0_pressed = true;}}
	}

	
	if (Key_UP == true && RELEASED_JumpKey == 0)  {JumpKey = 1;}
	if (Key_UP == false){RELEASED_JumpKey = 0;}
	if (Key_UP == true) {if(Giana.jumpcounter > 0){JumpKey = 1;}}
	if (Key_UP == true)
	{
		if(Giana.jumpcounter == 0 && Giana.onground == 0 && RELEASED_JumpKey == 0)	
		{RELEASED_JumpKey = 0;}
		else {RELEASED_JumpKey = 1;}
	}


	//if (SDL_JoystickGetButton(SDL_JoystickOpen(0),0) && Giana.jumpcounter == 0)		{RELEASED_JumpKey = 1;}

	}
//}

