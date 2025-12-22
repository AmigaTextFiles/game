// ball.cpp - Defines all the functions related to the ball class
//            including the constructor, the draw function, and the
//            move function.
//
// Author: Josh Wheeler
// For copyright information, read the file COPYING in the directory.
// 

#include <time.h>
#include <iostream>
#include <unistd.h>
#include <math.h>
#include <stdlib.h>
#include "paddle.h"
#include "ball.h"
#include "SDL.h"

#ifdef __MORPHOS__
#undef sleep
#define sleep(x) usleep((int)x*1000UL)
#endif

using namespace std;

ball::ball(SDL_Surface *screen, int xPos, int yPos, int height, int width, int speed) :
   // Call the paddle constructor to initialize the ball.
   paddle(screen, xPos, yPos, height, width),
   velocX(speed),
   velocY(speed) {
// No body required because of the call to the paddle constructor.
}

void  ball::move(SDL_Surface *screen) {
   SDL_Rect eraser;
   eraser.h = 10;
   eraser.w = 10;
   // Set up the black color integer.
   int blackColor = SDL_MapRGB(screen->format, 0x00, 0x00, 0x00);
   // Set up the white color integer.
   int whiteColor = SDL_MapRGB(screen->format, 0xFF, 0xFF, 0xFF);

   // Make sure the ball is within the bounds of the screen.
   if((this->y > 0) && ((this->y + this->h) < 480)) {
      // Set the eraser up to erase the whole "previous" ball.
      eraser.x = this->x;
      eraser.y = this->y;
      
      // Set the eraser rectangle to be black.
      SDL_FillRect(screen, &eraser, blackColor);
      // Subtract the integer speed from the y position.
      this->y -= velocY;
      this->x -= velocX;
      // Set the paddle rectangle to be white.
      SDL_FillRect(screen, this, whiteColor);
   }
   else if((this->y == 0) || ((this->y + this->h) == 480)) {
      eraser.x = this->x;
      eraser.y = this->y;

      // Set the eraser rectangle to be black.
      SDL_FillRect(screen, &eraser, blackColor);
      // Subtract the integer speed from the y position.
      this->velocY = this->velocY * -1;
      this->y -= velocY;
      this->x -= velocX;
      // Set the paddle rectangle to be white.
      SDL_FillRect(screen, this, whiteColor);
   }
}

void ball::paddleCheck(SDL_Surface *screen, paddle *comp, paddle *user, ball *bouncyBall, int userScore, int compScore) {
   // Seed the random number generator.
   srand((unsigned int) time(0));

   // Eraser to remove the ball after it leaves the field of play.
   SDL_Rect eraser;
   eraser.h = 15;
   eraser.w = 15;
   // Set up the black color integer.
   int blackColor = SDL_MapRGB(screen->format, 0x00, 0x00, 0x00);

   // Tiered if-statements to check if the ball has contacted the user's paddle.
   if((bouncyBall->x == 590) || (bouncyBall->x == 589)) {
      if((bouncyBall->y >= user->y) && (bouncyBall->y + 10) <= (user->y + user->h)) {
         cerr << "user contact" << endl;
         bouncyBall->velocY = (bouncyBall->velocY * -1) + 2-(rand() % 4);
         bouncyBall->velocX = (bouncyBall->velocX * -1) + 2-(rand() % 2);
      }
   }
   // Tiered if-statements to check if the ball has contacted the computer's paddle.
   if((bouncyBall->x == 56) || (bouncyBall->x == 55)) {
      if((bouncyBall->y >= comp->y) && (bouncyBall->y + 10) <= (comp->y + comp->h)) {
         cerr << "comp contact" << endl;
         bouncyBall->velocY = (bouncyBall->velocY * -1)/* + 2-(rand() % 4)*/;
         bouncyBall->velocX = (bouncyBall->velocX * -1)/* + 0-(rand() % 2)*/;
      }
   }
   // Check if the user has scored.
   else if(bouncyBall->x < comp->x - 30) {
      userScore++;
      eraser.x = bouncyBall->x;
      eraser.y = bouncyBall->y;
      // Set the eraser rectangle to be black.
      SDL_FillRect(screen, &eraser, blackColor);
      // Move the bouncy ball back to the center of the screen.
      bouncyBall->x = 315;
      bouncyBall->y = 235;
      comp->resetPaddle(comp, 40);
      comp->resetPaddle(user, 600);
      bouncyBall->velocY = (bouncyBall->velocY * -1) + 2-(rand() % 4);
      bouncyBall->velocX = (bouncyBall->velocX * -1) + 0-(rand() % 2);
      sleep(2);
   }
   // Check if the computer has scored.
   else if(bouncyBall->x > user->x + 30) {
      compScore++;
      eraser.x = bouncyBall->x;
      eraser.y = bouncyBall->y;
      // Set the eraser rectangle to be black.
      SDL_FillRect(screen, &eraser, blackColor);
      // Move the bouncy ball back to the center of the screen.
      bouncyBall->x = 315;
      bouncyBall->y = 235;
      comp->resetPaddle(comp, 40);
      comp->resetPaddle(user, 600);
      bouncyBall->velocY = (bouncyBall->velocY * -1) + 2-(rand() % 4);
      bouncyBall->velocX = (bouncyBall->velocX * -1) + 2-(rand() % 2);
      sleep(2);
   }
}

void ball::aiPaddleCheck(SDL_Surface *screen, paddle *comp, ball *bouncyBall) {
   // If the paddle isn't trying to leave the screen, move it toward the ball.
   if((comp->y >= 0) && ((comp->y + comp->h) <= 480)) {
      if(bouncyBall->y <= comp->y + 10) comp->move(screen, 5);
      else if(bouncyBall->y >= comp->y + 100) comp->move(screen, -5);
   }
}

void ball::velocityCheck(SDL_Surface *screen, ball *bouncyBall) {
   // If the ball's velocity is too high, slow it down.
   if(bouncyBall->velocY > 2) bouncyBall->velocY -= 1;
   else if(bouncyBall->velocX > 2) bouncyBall->velocX -= 1;
   // If the ball's negative velocity is too high, slow it down.
   if(bouncyBall->velocY < -2) bouncyBall->velocY += 1;
   else if(bouncyBall->velocX < -2) bouncyBall->velocX += 1;
}

void ball::resetBall(ball *bouncyBall) {
   bouncyBall->h = 10;
   bouncyBall->w = 10;
   
}
