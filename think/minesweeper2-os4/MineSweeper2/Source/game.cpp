#include <iostream>
#include <vector>
#include <cmath>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>

#include "options.h"
#include "window.h"
#include "tile.h"
#include "game.h"

Game::Game(Options options):
  gameoptions(options),
  gameover(false),
  started(false),
  flags(0),
  time_started(0)
{
  hover_tile.x = 0;
  hover_tile.y = 0;
  gamewindow = new Window(options);
  initImages();
  initGrid();
}

Game::~Game()
{
  delete gamewindow;
}

void Game::initImages()
{
  SDL_Surface *tempimg = IMG_Load("msfont1.bmp");
  font1 = SDL_DisplayFormat(tempimg);
}

void Game::initGrid()
{
  grid.resize(gameoptions.columns);
  for (int i=0; i<gameoptions.columns; i++) {
    grid[i].resize(gameoptions.rows);
    for (int j=0; j<grid[i].size(); j++) {
      grid[i][j].hidden = true;
      grid[i][j].mined = false;
      grid[i][j].flagged = false;
      gamewindow->drawTile(font1, 'H', i, j);
    }
  }
}

int random(int min, int max)
{
  //generate random number and put it in desired range
  int range = (max+1) - min;
  int random_number = rand()%range;
  random_number += min;
  //return random number
  return random_number;
}

void Game::generateMines(unsigned short int x, unsigned short int y)
{
  unsigned short int mousepos_x =
    static_cast<unsigned short int> (floor(x / FONT_SIZE));
  unsigned short int mousepos_y =
    static_cast<unsigned short int> (floor( (y - FONT_SIZE) / FONT_SIZE));
  srand((unsigned)time(NULL));
  int rand_x, rand_y;
  for (int i=0; i<gameoptions.mines; i++) {
    int rand_x = random(0, gameoptions.columns-1);
    int rand_y = random(0, gameoptions.rows-1);
    if (grid[rand_x][rand_y].mined == true || (mousepos_x == rand_x && mousepos_y == rand_y))
      i--;
    else {
      grid[rand_x][rand_y].mined = true;
      if (gameoptions.cheat == true)
        gamewindow->drawTile(font1, 'M', rand_x, rand_y);
    }
  }
}

void Game::updateHoverTile(unsigned short int x, unsigned short int y,
        bool leftmousebuttondown)
{
  //get grid coordinates
  unsigned short int mousepos_x =
    static_cast<unsigned short int> (floor(x / FONT_SIZE));
  unsigned short int mousepos_y =
    static_cast<unsigned short int> (floor( (y - FONT_SIZE) / FONT_SIZE));
  //determine what hover tile to show, depending on state of left mouse button
  char hovertilechar;
  if (leftmousebuttondown == true)
    hovertilechar = '0';
  else
    hovertilechar = 'I';
  //update the hover tile
  if (mousepos_y >= 0 && mousepos_y < gameoptions.rows)
  {
    if (grid[mousepos_x][mousepos_y].hidden == true &&
            grid[mousepos_x][mousepos_y].flagged == false &&
            gameover == false)
    {
      if (mousepos_x != hover_tile.x || mousepos_y != hover_tile.y ||
              leftmousebuttondown == true)
      {
        if (grid[hover_tile.x][hover_tile.y].hidden == true) {
          if (grid[hover_tile.x][hover_tile.y].flagged == false) {
            if (grid[hover_tile.x][hover_tile.y].mined == true &&
                  gameoptions.cheat == true)
              gamewindow->drawTile(font1, 'M', hover_tile.x, hover_tile.y);
            else
              gamewindow->drawTile(font1, 'H', hover_tile.x, hover_tile.y);
          }
          else
            gamewindow->drawTile(font1, 'F', hover_tile.x, hover_tile.y);
        }
        hover_tile.x = mousepos_x;
        hover_tile.y = mousepos_y;
        gamewindow->drawTile(font1, hovertilechar, hover_tile.x, hover_tile.y);
      }
    }
  }
}

void Game::clearTileAt(unsigned short int x, unsigned short int y)
{
  unsigned short int mousepos_x =
    static_cast<unsigned short int> (floor(x / FONT_SIZE));
  unsigned short int mousepos_y =
    static_cast<unsigned short int> (floor( (y - FONT_SIZE) / FONT_SIZE));
  if (mousepos_y >= 0 && mousepos_y < gameoptions.rows)
  {
    if (grid[mousepos_x][mousepos_y].hidden == true &&
            grid[mousepos_x][mousepos_y].flagged == false &&
            gameover == false)
    {
      grid[mousepos_x][mousepos_y].hidden = false;
      if (grid[mousepos_x][mousepos_y].mined == true)
        loseGame(mousepos_x, mousepos_y);
      else
      {
        gamewindow->drawTile(font1, '0', mousepos_x, mousepos_y);
        if (countAdjacentMinesAt(mousepos_x, mousepos_y) == 0)
          clearAdjacentTilesAt(mousepos_x, mousepos_y);
        else
          showAdjacentMinesAt(mousepos_x, mousepos_y);
      }
    }
    //check if player won
    unsigned short int hiddentiles = 0;
    for (int i=0; i<gameoptions.columns; i++)
    {
      for (int j=0; j<gameoptions.rows; j++)
      {
        if (grid[i][j].hidden == true)
          hiddentiles++;
      }
    }
    if (hiddentiles == gameoptions.mines)
      winGame();
  }
}

void Game::setFlagAt(unsigned short int x, unsigned short int y)
{
  unsigned short int mousepos_x =
    static_cast<unsigned short int> (floor(x / FONT_SIZE));
  unsigned short int mousepos_y =
    static_cast<unsigned short int> (floor( (y - FONT_SIZE) / FONT_SIZE));
  if (grid[mousepos_x][mousepos_y].hidden == true && gameover == false)
  {
    if (grid[mousepos_x][mousepos_y].flagged == false)
    { //tile is not flagged => flag it
      grid[mousepos_x][mousepos_y].flagged = true;
      gamewindow->drawTile(font1, 'F', mousepos_x, mousepos_y);
      flags++;
      gamewindow->writeInBlack(gameoptions.columns-3, flags);
    }
    else
    { //tile is already flagged => unflag it
      grid[mousepos_x][mousepos_y].flagged = false;
      gamewindow->drawTile(font1, 'H', mousepos_x, mousepos_y);
      flags--;
      gamewindow->writeInBlack(gameoptions.columns-3, flags);
    }
  }
}

const unsigned short int Game::countAdjacentMinesAt(unsigned short int mousepos_x,
        unsigned short int mousepos_y)
{
  unsigned short int minesnear = 0;
  short int xstart = -1;
  short int xend = 1;
  short int ystart = -1;
  short int yend = 1;
  if ((mousepos_x+1) == gameoptions.columns)
    xend = 0;
  if (mousepos_x == 0)
    xstart = 0;
  if ((mousepos_y+1) == gameoptions.rows)
    yend = 0;
  if (mousepos_y == 0)
    ystart = 0;
  for (int i = xstart; i <= xend; i++) {
    for (int j = ystart; j <= yend; j++) {
      if (grid[mousepos_x+i][mousepos_y+j].mined == true)
        minesnear++;
    }
  }
  return minesnear;
}

const unsigned short int Game::showAdjacentMinesAt(unsigned short int mousepos_x,
        unsigned short int mousepos_y)
{
  unsigned short int minesnear = countAdjacentMinesAt(mousepos_x,mousepos_y);
  const char showfigure = static_cast<char>(minesnear+48);
  gamewindow->drawTile(font1, showfigure, mousepos_x, mousepos_y);
}

void Game::clearAdjacentTilesAt(unsigned short int mousepos_x,
        unsigned short int mousepos_y)
{
  unsigned short int minesnear = 0;
  short int xstart = -1;
  short int xend = 1;
  short int ystart = -1;
  short int yend = 1;
  if ((mousepos_x+1) == gameoptions.columns)
    xend = 0;
  if (mousepos_x == 0)
    xstart = 0;
  if ((mousepos_y+1) == gameoptions.rows)
    yend = 0;
  if (mousepos_y == 0)
    ystart = 0;
  for (int i = xstart; i <= xend; i++) {
    for (int j = ystart; j <= yend; j++)
      clearTileAt((mousepos_x + i)*FONT_SIZE, ((mousepos_y + j)*FONT_SIZE)+FONT_SIZE);
  }
}

void Game::loseGame(unsigned short int mousepos_x, unsigned short int mousepos_y)
{
  //set gameover flag
  gameover = true;
  //show all mines and check flags
  for (int i=0; i<gameoptions.columns; i++)
  {
    for (int j=0; j<gameoptions.rows; j++)
    {
      if (grid[i][j].flagged == true)
      {
        if (grid[i][j].mined != true)
          gamewindow->drawTile(font1, 'X', i, j);
      }
      else if (grid[i][j].mined == true)
        gamewindow->drawTile(font1, 'M', i, j);
    }
  }
  //show killer mine
  gamewindow->drawTile(font1, 'K', mousepos_x, mousepos_y);
  gamewindow->writeInBlack(3, "T");
}

void Game::winGame()
{
  gameover = true;
  gamewindow->writeInBlack(3, "W");
}

void Game::handleDoubleClick(unsigned short int x, unsigned short int y)
{
  unsigned short int mousepos_x =
    static_cast<unsigned short int> (floor(x / FONT_SIZE));
  unsigned short int mousepos_y =
    static_cast<unsigned short int> (floor( (y - FONT_SIZE) / FONT_SIZE));
  if (countAdjacentFlagsAt(mousepos_x, mousepos_y) ==
          countAdjacentMinesAt(mousepos_x, mousepos_y) &&
          grid[mousepos_x][mousepos_y].hidden == false)
  {
    short int xstart = -1;
    short int xend = 1;
    short int ystart = -1;
    short int yend = 1;
    if ((mousepos_x+1) == gameoptions.columns)
      xend = 0;
    if (mousepos_x == 0)
      xstart = 0;
    if ((mousepos_y+1) == gameoptions.rows)
      yend = 0;
    if (mousepos_y == 0)
      ystart = 0;
    for (int i = xstart; i <= xend; i++) {
      for (int j = ystart; j <= yend; j++)
        clearTileAt((mousepos_x + i)*FONT_SIZE, ((mousepos_y + j)*FONT_SIZE)+FONT_SIZE);
    }
  }
}

const unsigned short int Game::countAdjacentFlagsAt(unsigned short int mousepos_x,
        unsigned short int mousepos_y)
{
  unsigned short int flagsnear = 0;
  short int xstart = -1;
  short int xend = 1;
  short int ystart = -1;
  short int yend = 1;
  if ((mousepos_x+1) == gameoptions.columns)
    xend = 0;
  if (mousepos_x == 0)
    xstart = 0;
  if ((mousepos_y+1) == gameoptions.rows)
    yend = 0;
  if (mousepos_y == 0)
    ystart = 0;
  for (int i = xstart; i <= xend; i++) {
    for (int j = ystart; j <= yend; j++) {
      if (grid[mousepos_x+i][mousepos_y+j].flagged == true)
        flagsnear++;
    }
  }
  return flagsnear;
}

void Game::showCurrentTime()
{
  const unsigned int current_time = floor( (SDL_GetTicks() - time_started) / 1000 );
  if (started == true && gameover == false)
    gamewindow->writeInBlack(0, current_time);
}
