#include "audio.h"
#include "sim.h"
#include "game.h"

void sound_refresh(game *g)
{
  static int last_clock=-1;

  /* clock sounds */

  if(last_clock!= -1) {
    if(g->type == BATTLE) {
      if(g->sim.clock < 6000 && g->sim.clock/1000 != last_clock/1000)
	play_sound("sounds/clock_tick.wav");
      
      if(g->sim.clock < 60000 && last_clock >= 60000)
	play_sound("sounds/one_minute.wav");
    }
  }
  last_clock = g->sim.clock;
}  

void sound_handle_event(game *g, int event, float x, float y, direction dir)
{
  switch(event) {
  case GET_MOUSE:
    play_sound("sounds/get_mouse.wav");
    break;
  case GET_MOUSE_50:
    play_sound("sounds/get_mouse_50.wav");
    break;
  case GET_MOUSE_Q:
    play_sound("sounds/get_mouse_q.wav");
    break;
  case GET_CAT:
    play_sound("sounds/get_cat.wav");
    break;
  case START_GAME:
    play_sound("sounds/start_game.wav");
    break;
  case PAUSE_GAME:
    play_sound("sounds/pause_game.wav");
    break;
  }
}  

