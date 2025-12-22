// paddle.cpp - Contains all the functions related to the paddle class
//              as defined in paddle.h. This includes the constructor,
//              the draw function, and the move function.
//
// Author: Josh Wheeler
// For copyright information, read the file COPYING in the directory.
// 

#include <iostream>
#include "paddle.h"
#include "SDL.h"

using namespace std;

paddle::paddle(SDL_Surface *screen, int xPos, int yPos, int height, int width) :
   SDL_Rect() {
      x = xPos;
      y = yPos;
      h = height;
      w = width;
      
      // Set up the white color integer.
      int whiteColor = SDL_MapRGB(screen->format, 0xFF, 0xFF, 0xFF);
      // Set the screen-blanking rectangle to be black.
      SDL_FillRect(screen, this, whiteColor);
}

void  paddle::move(SDL_Surface *screen, int speed) {
   SDL_Rect eraser;
   eraser.h = speed;
   eraser.w = 20;
   // Set up the black color integer.
   int blackColor = SDL_MapRGB(screen->format, 0x00, 0x00, 0x00);
   // Set up the white color integer.
   int whiteColor = SDL_MapRGB(screen->format, 0xFF, 0xFF, 0xFF);

   // Make sure the ball/paddle is within the bounds of the screen.
   if((this->y > 0) && ((this->y + this->h) < 480)) {
      // Set the eraser up according to whether the paddle is going up or down.
      if(speed > 0) {
         eraser.x = this->x;
         eraser.y = (this->y + this->h) - speed;
      }
      else {
         eraser.x = this->x;
         eraser.y = this->y;
      }
      // Set the eraser rectangle to be black.
      SDL_FillRect(screen, &eraser, blackColor);
      // Subtract the integer speed from the y position.
      this->y -= speed;
      // Set the paddle rectangle to be white.
      SDL_FillRect(screen, this, whiteColor);
   }
   // Bounce the ball/paddle back if it's trying to go above the screen.
   else if(this->y == 0) {
      eraser.x = this->x;
      eraser.y = this->y;
      // Set the eraser rectangle to be black.
      SDL_FillRect(screen, &eraser, blackColor);
      // Subtract the integer speed from the y position.
      this->y -= -10;
      // Set the paddle rectangle to be white.
      SDL_FillRect(screen, this, whiteColor);
   }
   // Bounce the ball/paddle back if it's trying to go below the screen.
   else if((this->y + this->h) == 480) {
      eraser.x = this->x;
      eraser.y = (this->y + this->h) - 10;
      // Set the eraser rectangle to be black.
      SDL_FillRect(screen, &eraser, blackColor);
      // Subtract the integer speed from the y position.
      this->y -= 10;
      // Set the paddle rectangle to be white.
      SDL_FillRect(screen, this, whiteColor);
   }
}

void paddle::resetPaddle(paddle *pdl, int xPos) {
   // Reset all the paddle variables.
   pdl->x = xPos;
}
