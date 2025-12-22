#ifndef BALL_H
#define BALL_H

#include "paddle.h"

class ball : public paddle {
  public:
   ball(SDL_Surface *screen, int xPos, int yPos, int height, int width, int speed);
   void move(SDL_Surface *screen);
   void paddleCheck(SDL_Surface *screen, paddle *comp, paddle *user, ball *bouncyBall, int userScore, int compScore);
   void aiPaddleCheck(SDL_Surface *screen, paddle *compPaddle, ball *bouncyBall);
   void velocityCheck(SDL_Surface *screen, ball *bouncyBall);
   void resetBall(ball *bouncyBall);
  private:
   int velocX;
   int velocY;
};

#endif
