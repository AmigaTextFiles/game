#include <SDL.h>
#include <SDL_events.h>
#include <SDL_image.h>
#include <SDL_ttf.h>
#include <SDL_mixer.h>
#include <SDL_thread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "sdlame.h"
#include "vars.h"

int turn_computer()
{
  output("Computer Player not supported!");

  player = 1;
  //output("Player 1...");
  draw_cursor(cursor_x, cursor_y, 1);
  return 1;
}
