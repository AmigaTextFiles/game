#include <iostream>
#include <sstream>
#include <vector>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>

#include "tile.h"
#include "options.h"
#include "window.h"
#include "game.h"
#include "session.h"

short GetNumber(std::string argument) {
  std::istringstream s(argument);
  short integer;
  s >> integer;
  return integer;
}

int main(int argc, char **argv)
{
  //Init SDL
  SDL_Init(SDL_INIT_EVERYTHING);

  //Options
  Options beginner;
  beginner.rows = 9;
  beginner.columns = 9;
  beginner.mines = 10;
  beginner.cheat = false;

  Options intermediate;
  intermediate.rows = 16;
  intermediate.columns = 16;
  intermediate.mines = 40;
  intermediate.cheat = false;

  Options expert;
  expert.rows = 16;
  expert.columns = 30;
  expert.mines = 99;
  expert.cheat = false;

  //CLI
  std::vector<std::string> arguments;
  Options cli_options;
  cli_options = expert;
  if (argc > 1) {
    for (int count = 1; count < argc; count++) {
      arguments.resize(count);
      arguments[count-1] += argv[count];
      if (arguments[count-1].substr(0,5) == "mode=") {
        if (arguments[count-1].substr(5) == "beginner")
          cli_options = beginner;
        if (arguments[count-1].substr(5) == "intermediate")
          cli_options = intermediate;
        if (arguments[count-1].substr(5) == "expert")
          cli_options = expert;
      }
      if (arguments[count-1].substr(0,6) == "width=")
        cli_options.columns = GetNumber(arguments[count-1].substr(6)) > 9
                ? GetNumber(arguments[count-1].substr(6)) : 9;
      if (arguments[count-1].substr(0,7) == "height=")
        cli_options.rows = GetNumber(arguments[count-1].substr(7)) > 9
                ? GetNumber(arguments[count-1].substr(6)) : 9;
      if (arguments[count-1].substr(0,6) == "mines=")
        cli_options.mines = GetNumber(arguments[count-1].substr(6)) <
                (cli_options.rows * cli_options.columns) - 1 ?
                GetNumber(arguments[count-1].substr(6)) :
                (cli_options.rows * cli_options.columns) / 5;
      if (arguments[count-1] == "cheat=true")
        cli_options.cheat = true;
    }
  }

  //program loop
  Session gamesession(cli_options);
  bool quitprogram = false;
  bool leftdown = false;
  SDL_Event event;
  while ( quitprogram == false ) {
    SDL_WaitEvent(&event);
      switch(event.type) {
        case SDL_QUIT:
          quitprogram = true;
          break;
        case SDL_MOUSEMOTION:
          gamesession.handleMouseMotion(event.button.x, event.button.y);
          gamesession.current_game->showCurrentTime();
          break;
        case SDL_MOUSEBUTTONDOWN:
          if (event.button.button == SDL_BUTTON_LEFT)
            gamesession.handleLeftMouseButtonDown(event.button.x, event.button.y);
          else if (event.button.button == SDL_BUTTON_RIGHT)
            gamesession.handleRightMouseButtonDown(event.button.x, event.button.y);
          gamesession.current_game->showCurrentTime();
          break;
        case SDL_MOUSEBUTTONUP:
          if (event.button.button == SDL_BUTTON_LEFT)
            gamesession.handleLeftMouseButtonUp(event.button.x, event.button.y);
          else if (event.button.button == SDL_BUTTON_RIGHT)
            gamesession.handleRightMouseButtonUp(event.button.x, event.button.y);
          gamesession.current_game->showCurrentTime();
          break;
        case SDL_KEYDOWN:
          switch(event.key.keysym.sym) 
          {
            case SDLK_F2:
              gamesession.newGame();
              break;
            case SDLK_n:
              gamesession.newGame();
              break;
          }
          gamesession.current_game->showCurrentTime();
          break;
      }
  }

  //kill resources and window
  SDL_Quit();
}
