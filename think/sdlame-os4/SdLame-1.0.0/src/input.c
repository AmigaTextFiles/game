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

void key_loop()
{
  int exit = 0;
  SDL_Event event;

  if(GP2X_MODE == 1)
  {
    while(exit != 1)
    {
      while(SDL_PollEvent(&event))
      {
        switch(event.type)
        {
          case SDL_JOYBUTTONDOWN:
               switch(event.jbutton.button)
               {
                 case GP2X_BUTTON_START:
                      exit = 1;
                      break;
                 default:
                      exit = 0;
                      break;
               }
               break;
        }
      }
    }
  }
  else
  {
    while(exit != 1)
    {
      while(SDL_PollEvent(&event))
      {
        switch(event.type)
        {
          case SDL_KEYDOWN:
               switch(event.key.keysym.sym)
               {
                 case SDLK_RETURN:
                      exit = 1;
                      break;
                 default:
                      exit = 0;
                      break;
               }
               break;
        }
      }
    }
  }
}

void input_gp2x(char (*input)[2])
{
  int exit = 0;
  SDL_Event event;

  while(exit == 0)
  {
    while(SDL_PollEvent(&event))
    {
      switch(event.type)
      {
        case SDL_JOYBUTTONDOWN:
          switch(event.jbutton.button)
          {
            case GP2X_BUTTON_START:
              exit = 1;
              (*input)[0] = 'e';
              break;
            case GP2X_BUTTON_UP:
              exit = 1;
              (*input)[0] = 'u';
              break;
            case GP2X_BUTTON_DOWN:
              exit = 1;
              (*input)[0] = 'd';
              break;
            case GP2X_BUTTON_RIGHT:
              exit = 1;
              (*input)[0] = 'r';
              break;
            case GP2X_BUTTON_LEFT:
              exit = 1;
              (*input)[0] = 'l';
              break;
            case GP2X_BUTTON_CLICK:
              exit = 1;
              (*input)[0] = 'c';
              break;
            case GP2X_BUTTON_B:
              exit = 1;
              (*input)[0] = 'm';
              break;
            case GP2X_BUTTON_Y:
              exit = 1;
              (*input)[0] = 'n';
              break;
            default:
              exit = 0;
              break;
          }
          break;
      }
    }
  }
}

void input_pc(char (*input)[2])
{
  int exit = 0;
  SDL_Event event;

  while(exit == 0)
  {
    while(SDL_PollEvent(&event))
    {
      switch(event.type)
      {
        case SDL_KEYDOWN:
          switch(event.key.keysym.sym)
          {
            case SDLK_ESCAPE:
              (*input)[0] = 'e';
              exit = 1;
              break;
            case SDLK_UP:
              (*input)[0] = 'u';
              exit = 1;
              break;
            case SDLK_DOWN:
              (*input)[0] = 'd';
              exit = 1;
              break;
            case SDLK_LEFT:
              (*input)[0] = 'l';
              exit = 1;
              break;
            case SDLK_RIGHT:
              (*input)[0] = 'r';
              exit = 1;
              break;
            case SDLK_SPACE:
              (*input)[0] = 'c';
              exit = 1;
              break;
            case SDLK_RETURN:
              (*input)[0] = 'm';
              exit = 1;
              break;
            case SDLK_n:
              (*input)[0] = 'n';
              exit = 1;
              break;
            default:
              exit = 0;
              break;
          }
          break;
      }
    }
  }
}

int input_menu()
{
  int exit = 0;
  SDL_Event event;

  while(exit != 1)
  {
    if(GP2X_MODE == 1)
    {
      while(SDL_PollEvent(&event))
      {
        switch(event.type)
        {
          case SDL_JOYBUTTONDOWN:
            switch(event.jbutton.button)
            {
              case GP2X_BUTTON_START:
                return 1;
                break;
              case GP2X_BUTTON_UP:
                menu_position--;
                exit = 1;
                break;
              case GP2X_BUTTON_DOWN:
                menu_position++;
                exit = 1;
                break;
              case GP2X_BUTTON_CLICK:
                return 1;
                break;
              case GP2X_BUTTON_B:
                return 1;
                break;
              default:
                exit = 0;
                break;
            }
            break;
        }
      }
    }
    else
    {
      while(SDL_PollEvent(&event))
      {
        switch(event.type)
        {
          case SDL_KEYDOWN:
            switch(event.key.keysym.sym)
            {
              case SDLK_UP:
                menu_position--;
                exit = 1;
                break;
              case SDLK_DOWN:
                menu_position++;
                exit = 1;
                break;
              case SDLK_SPACE:
                return 1;
                break;
              case SDLK_RETURN:
                return 1;
                break;
              default:
                exit = 0;
                break;
            }
            break;
        }
      }
    }
  } //while(exit != 1)

  return 0;
}
