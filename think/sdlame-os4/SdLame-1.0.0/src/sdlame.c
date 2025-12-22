#include <SDL.h>
#include <SDL_events.h>
#include <SDL_image.h>
#include <SDL_ttf.h>
#include <SDL_mixer.h>
#include <SDL_thread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sdlame.h"
#include "vars.h"

int main(int argc, char *argv[])
{
  int exit = 0;

  /* Initialize SDL */
  SDL_Init(SDL_INIT_EVENTTHREAD | SDL_INIT_JOYSTICK | SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_TIMER);

  /* Load Font Module */
  TTF_Init();

  /* Load Audio Device */
  Mix_OpenAudio(MIX_DEFAULT_FREQUENCY, AUDIO_S16, MIX_DEFAULT_CHANNELS, 128);

  /* Initialize the Font and Screen */
  if(argc == 2)
  {
    screen_width = 320; //is set to 800 in the next step
  }

  switch_resolution();

  /* Set Title for Window Managers */
  SDL_WM_SetCaption("SdLame", "SdLame");

  /* Set Icon for Window Managers */
  SDL_WM_SetIcon(SDL_LoadBMP("img/icon.bmp"), NULL);

  /* Remove Cursor */
  SDL_ShowCursor (0);

  /* Aktivate Joystick */
  SDL_JoystickOpen(0);

  /* Printf Version */
  VERSION;

  /* Draw Background */
  background(1);

  /* Update Screen */
  SDL_Flip(screen);

  /* Loop, while Start is not pressed */
  key_loop();

  /* Set Menu Position to one, because it's unset before */
  menu_position = 1;

  /* Set Mode to Single Player by default */
  mode = 1;

  /* Create a new Game */
  new_game();

  /* Draw Menu to Display */
  menu();

  while(exit != 1)
  {
    if(player == 1)
    {
      turn_player_1();
    }
    else
    {
      if(mode == 1)
      {
        turn_computer();
      }
      else if(mode == 2)
      {
        turn_player_2();
      }
    }
  }

  menu();
  nexit();
  return 1;
}
