// ping.cpp - The main body of code that calls all the other functions
//            and builds the interface with them. Most of the actual
//            content of the program is contained in the other files.
//            
// Author: Josh Wheeler
// For copyright information, read the file COPYING in the directory.

#include <iostream>

// Stuff brought in by the author.
#include "init.h"
#include "ball.h"
#include "paddle.h"
#include <unistd.h>

#ifdef __MORPHOS__
#include <exec/types.h>
ULONG __stack = 1000000;
#undef sleep
#define sleep(x) usleep((int)x*1000UL)
#endif

// Stuff brought in by SDL.
#include "SDL_keysym.h"
#include "SDL.h"
#include "SDL_main.h"

using namespace std;

int main() {
   // Boolean to stop the while loop when the game is over.
   bool gameOver = false;
   // Initialize the paddles and the ball.
   paddle *userPaddle;
   paddle *compPaddle;
   ball *bouncyBall;
   // Prepare SDL to listen for keyboard input with an event listening variable.
   SDL_Event keyIn;
   // Initialize the user's and the computer's scores.
   int userScore = 0;
   int compScore = 0;

   // Dual-purpose if-statement that starts SDL with video enabled
   // and dumps an error if SDL doesn't start properly.
   if((SDL_Init(SDL_INIT_VIDEO)) == -1) {
      cout << "Unable to initialize SDL: ";
      cout << SDL_GetError() << endl;
   }

   // Start the screen at 640x480 resolution.
   SDL_Surface *screen;
   screen = SDL_SetVideoMode(640, 480, 8, SDL_SWSURFACE);
      if(screen == NULL) {
         cerr << "Couldn't set 640x480x8 video mode";
         cerr <<  SDL_GetError() << endl;
         exit(1);
      }

   // Call the function to initialize SDL.
   initialize(screen);
   // Sleep for 5 seconds, then clear the screen.
   sleep(5);
   clearScreen(screen);
   sleep(1);

   // Enable UNICODE translation so the keyboard can be read from
   SDL_EnableUNICODE(0);

   // Construct the user's paddle, the ball, and the AI paddle.
   userPaddle = new paddle(screen, 600, 190, 100, 15);
   bouncyBall = new ball(screen, 315, 235, 10, 10, -1);
   compPaddle = new paddle(screen, 40, 190, 100, 15);

   while(!gameOver) {
      // Redraw the screen every cycle through the while loop so that
      // the change in position of the objects will be visible.
      SDL_UpdateRect(screen, 0, 0, 0, 0);
      // Make sure that the ball isn't going too fast before it gets moved.
      bouncyBall->velocityCheck(screen, bouncyBall);
      // Move the ball to its new position according to its velocities and make sure it kept its dimensions.
      bouncyBall->move(screen);
      bouncyBall->resetBall(bouncyBall);
      // Check functions to move the ball and computer's paddle.
      bouncyBall->paddleCheck(screen, compPaddle, userPaddle, bouncyBall, userScore, compScore);
      // While loop to smooth out the computer's paddle movement.
      bouncyBall->aiPaddleCheck(screen, compPaddle, bouncyBall);
                 
      while(SDL_PollEvent(&keyIn)) {
         // Series of tiered if-statements to move the paddle when receiving
         // the proper keyboard input and quit on escape.
         if(keyIn.type == SDL_KEYDOWN){
            if(keyIn.key.keysym.sym == SDLK_UP) userPaddle->move(screen, 10);
            if(keyIn.key.keysym.sym == SDLK_DOWN) userPaddle->move(screen, -10);
            if(keyIn.key.keysym.sym == SDLK_ESCAPE) {
              SDL_WM_ToggleFullScreen(screen);
              SDL_Quit();
              exit(1);
            }
         }
         if(keyIn.type == SDL_KEYUP){
            if(keyIn.key.keysym.sym == SDLK_UP) userPaddle->move(screen, 10);
            if(keyIn.key.keysym.sym == SDLK_DOWN) userPaddle->move(screen, -10);
         }
      }
      if(userScore > 20 || compScore > 20) gameOver = false;
      sleep(.1);
   }
   
   SDL_Quit();
   return 0;	
}
