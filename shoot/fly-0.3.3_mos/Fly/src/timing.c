#include <SDL/SDL.h>

Uint32 actual_tick;
Uint32 last_tick;
Uint32 dt;

Uint32 fps_t0;
int num_frames;
int fps;

void Timing_init()
{
    fps_t0 = last_tick = actual_tick = SDL_GetTicks();
    num_frames = 0;
    fps = 50;
}

void Timing_update()
{
    last_tick = actual_tick;
    actual_tick = SDL_GetTicks();
    //dt = actual_tick - last_tick;
    dt = 1000 / fps;

    num_frames++;
    if(actual_tick - fps_t0 > 1000) {
	fps = num_frames;
	num_frames = 0;
	fps_t0 = actual_tick;
    }
    
}
