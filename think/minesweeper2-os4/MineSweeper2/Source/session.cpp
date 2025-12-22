#include <iostream>
#include <vector>
#include <cmath>
#include <SDL/SDL.h>

#include "options.h"
#include "tile.h"
#include "window.h"
#include "game.h"
#include "session.h"

Session::Session(Options options):
  current_options(options),
  leftmousebuttondown(false),
  rightmousebuttondown(false),
  mouseovernewgameicon(false)
{
  current_game = new Game(options);
}

Session::~Session()
{
  delete current_game;
}

void Session::newGame()
{
  delete current_game;
  current_game = new Game(current_options);
}

void Session::handleLeftMouseButtonDown(unsigned short int x, unsigned short int y)
{
  unsigned short int mousepos_x =
    static_cast<unsigned short int> (floor(x / FONT_SIZE));
  unsigned short int mousepos_y =
    static_cast<unsigned short int> (floor( (y - FONT_SIZE) / FONT_SIZE));
  leftmousebuttondown = true;
  if (mousepos_x == 3 && mousepos_y == current_options.rows)
    current_game->gamewindow->writeInBlack(3, "S");
  else
  {
    current_game->updateHoverTile(x, y, leftmousebuttondown);
    current_game->gamewindow->writeInBlack(3, "R");
  }
}

void Session::handleLeftMouseButtonUp(unsigned short int x, unsigned short int y)
{
  unsigned short int mousepos_x =
    static_cast<unsigned short int> (floor(x / FONT_SIZE));
  unsigned short int mousepos_y =
    static_cast<unsigned short int> (floor( (y - FONT_SIZE) / FONT_SIZE));
  leftmousebuttondown = false;
  if (rightmousebuttondown == true)
    current_game->handleDoubleClick(x, y);
  else if (mousepos_x == 3 && mousepos_y == current_options.rows)
  {
    current_game->gamewindow->writeInBlack(3, "U");
    newGame();
  }
  else
  {
    if (current_game->started == false) {
      current_game->generateMines(x, y);
      current_game->started = true;
      current_game->time_started = SDL_GetTicks();
    }
    current_game->gamewindow->writeInBlack(3, "U");
    current_game->clearTileAt(x, y);
  }
}

void Session::handleRightMouseButtonDown(unsigned short int x, unsigned short int y)
{
  rightmousebuttondown = true;
}

void Session::handleRightMouseButtonUp(unsigned short int x, unsigned short int y)
{
  rightmousebuttondown = false;
  if (leftmousebuttondown == true)
    current_game->handleDoubleClick(x, y);
  else
    current_game->setFlagAt(x, y);
}

void Session::handleMouseMotion(unsigned short int x, unsigned short int y)
{
  unsigned short int mousepos_x =
    static_cast<unsigned short int> (floor(x / FONT_SIZE));
  unsigned short int mousepos_y =
    static_cast<unsigned short int> (floor( (y - FONT_SIZE) / FONT_SIZE));
  //newgame icon
  if (mousepos_x == 3 && mousepos_y == current_options.rows)
  {
    if (mouseovernewgameicon == false)
    {
      mouseovernewgameicon = true;
      current_game->gamewindow->writeInBlack(3, "V");
    }
  }
  else
  {
    //hovertile on minefield/grid
    if (mousepos_y >= 0 && mousepos_y < current_options.rows)
      current_game->updateHoverTile(x, y, leftmousebuttondown);
    if (mouseovernewgameicon == true)
    {
      mouseovernewgameicon = false;
      current_game->gamewindow->writeInBlack(3, "U");
    }
  }
}
