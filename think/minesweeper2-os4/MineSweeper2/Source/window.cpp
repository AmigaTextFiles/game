#include <iostream>
#include <cmath>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>

#include "options.h"
#include "window.h"

Window::Window(Options options):
  WINDOW_WIDTH(options.columns * FONT_SIZE),
  WINDOW_HEIGHT((options.rows * FONT_SIZE) + (FONT_SIZE*2)),
  screen(NULL)
{
  SDL_Surface* icon = IMG_Load("icon.gif");
  SDL_WM_SetIcon(icon, NULL);
  screen = SDL_SetVideoMode(WINDOW_WIDTH, WINDOW_HEIGHT, SCREEN_BPP, SDL_SWSURFACE);
  if (options.columns > 13)
    SDL_WM_SetCaption("Minesweeper 2", NULL);
  else
    SDL_WM_SetCaption("MS2", NULL);
  SDL_Surface* temp = IMG_Load("msfont2.bmp");
  font2 = SDL_DisplayFormat(temp);
  writeInBlack(3, "U");
  writeInBlack((WINDOW_WIDTH/FONT_SIZE)-4, "F000");
  writeInBlack(0, "000");
}

void Window::drawTile(SDL_Surface *image, const char tile,
        unsigned short int x, unsigned short int y)
{
  const unsigned short int ascii = static_cast<unsigned short int> (tile);
  SDL_Rect dstrec;
  dstrec.x = x * FONT_SIZE;
  dstrec.y = (y * FONT_SIZE) + FONT_SIZE;
  SDL_Rect srcrec;
  unsigned short int temp = static_cast<unsigned short int> ( floor( ascii / 16 ) );
  srcrec.y = temp * FONT_SIZE;
  srcrec.x = ( ascii - (temp * 16) ) * FONT_SIZE;
  srcrec.w = FONT_SIZE;
  srcrec.h = FONT_SIZE;
  SDL_BlitSurface(image, &srcrec, screen, &dstrec);
  SDL_Flip(screen);
}

void Window::writeInBlack(unsigned short int xcoord, std::string text)
{
  for (int i=0; i<text.length(); i++)
    drawTile(font2, text[i], xcoord+i, ((WINDOW_HEIGHT-2)/FONT_SIZE)-1);
}

void Window::writeInBlack(unsigned short int xcoord, unsigned short int number)
{
  if (number > 999)
    number = 999;
  unsigned short int hundreds = static_cast<unsigned short int> (floor(number/100));
  unsigned short int tens =
          static_cast<unsigned short int> ( floor((number-(hundreds*100))/10) );
  unsigned short int units = number - (hundreds*100) - (tens*10);
  std::string s_hundreds(1, char(hundreds+48));
  std::string s_tens(1, char(tens+48));
  std::string s_units(1, char(units+48));
  writeInBlack(xcoord, s_hundreds);
  writeInBlack(xcoord+1, s_tens);
  writeInBlack(xcoord+2, s_units);
}

void Window::redrawScreen()
{

}
