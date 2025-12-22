#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>

#include "bool.h"
#include "constants.h"
#include "crate_object.h"
#include "framerate.h"
#include "graphics.h"
#include "GameOver.h"

void GameOverMovie(SDL_Surface* screen, crate* crates, int crate_count,
                   int cameraY, int playerX, int playerY)
{
    int game_over_timer = 50;
    int explo_speed = 10;

    int fragment_size = PLAYER_WIDTH / 2;

    int fragmentA_x = playerX;
    int fragmentA_y = playerY;

    int fragmentB_x = playerX;
    int fragmentB_y = playerY;

    int fragmentC_x = playerX;
    int fragmentC_y = playerY;

    int fragmentD_x = playerX;
    int fragmentD_y = playerY;

    while(game_over_timer--)
    {
        /* Animate fragments */
        fragmentA_x -= explo_speed;
        fragmentA_y -= explo_speed;

        fragmentB_x -= explo_speed;
        fragmentB_y += explo_speed;

        fragmentC_x += explo_speed;
        fragmentC_y -= explo_speed;

        fragmentD_x += explo_speed;
        fragmentD_y += explo_speed;

        if(explo_speed)
            --explo_speed;

        if(fragment_size)
            --fragment_size;

        /* Animate crates */
        DoCratesPhysics(crates, crate_count);

        /* Animate lava */
        ManageLava();

        /* Draw screen, crates, lava */
        DrawBackground(screen);
        DrawCrates(screen, crates, crate_count, cameraY);
        DrawLava(screen, cameraY);

        /* Draw fragments */
        DrawRectangle(screen, fragmentA_x, fragmentA_y,
                      fragment_size, fragment_size,
                      0, 0, 0);
        DrawRectangle(screen, fragmentB_x, fragmentB_y,
                      fragment_size, fragment_size,
                      0, 0, 0);
        DrawRectangle(screen, fragmentC_x, fragmentC_y,
                      fragment_size, fragment_size,
                      0, 0, 0);
        DrawRectangle(screen, fragmentD_x, fragmentD_y,
                      fragment_size, fragment_size,
                      0, 0, 0);

        /* Flip buffers */
        SDL_Flip(screen);

        /* Limit FPS */
        LimitFPS();
    }
}
