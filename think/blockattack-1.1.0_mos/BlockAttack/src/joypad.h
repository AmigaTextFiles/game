//headerfile joypad.h

#include <SDL.h>
#include <stdlib.h>
#include <iostream>

#define NRofPADS 4
#define NRofBUTTONS 12

using namespace std;

struct Joypad_status{
    bool padLeft[NRofPADS];
    bool padRight[NRofPADS];
    bool padUp[NRofPADS];
    bool padDown[NRofPADS];
    bool button[NRofBUTTONS];
};

//Contains the init code
bool Joypad_init();

//How many joypads are availble?
#define Joypad_number SDL_NumJoysticks()

//Open a joystick
#define Joypad_open(X) SDL_JoystickOpen(X)

//Returns the status of the joypad
Joypad_status Joypad_getStatus(SDL_Joystick);

class Joypad{
    private:
        SDL_Joystick *joystick;
    static int Joy_count;
    public:
        bool up,down,left,right,but1,but2;
        bool upREL,downREL,leftREL,rightREL,but1REL,but2REL;
        bool working;
    
    Joypad();
    ~Joypad();
    
    void update();
};
