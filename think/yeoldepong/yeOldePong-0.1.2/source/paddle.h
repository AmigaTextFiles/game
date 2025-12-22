#ifndef PADDLE_H
#define PADDLE_H

#include "SDL.h"

class paddle : public SDL_Rect {
  public:
   paddle(SDL_Surface *screen, int xPos, int yPos, int height, int width);
   void  move(SDL_Surface *screen, int speed);
   void resetPaddle(paddle *pdl, int xPos);
  private:
   int ballSideX;
};

#endif
