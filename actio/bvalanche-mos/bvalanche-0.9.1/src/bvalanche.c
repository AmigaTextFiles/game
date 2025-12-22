#include <stdio.h>
#include <stdlib.h>
#include <SDL/SDL.h>

#include "GameOver.h"
#include "bool.h"
#include "constants.h"
#include "crate_object.h"
#include "framerate.h"
#include "graphics.h"
#include "lava.h"

void bvalanche(SDL_Surface* gameScreen)
{
    SDL_Event event;
    bool gameLoop = true;
    Uint8* keystate = NULL;
    int freshUpKey = true;
    bool gameOver = false;
    int crate_id;
    int crate_count = 0;
    int crate_delay_counter = 0;
    crate *crates = NULL;
    int collisions = 0;
    int down_collision_count = 0;
    int up_collision_count = 0;
    int fixed_playerX;
    int fixed_playerY;
    int cameraY = 0;
    int cameraYVel = 0;
    int playerX = 0;
    int playerY = SCREEN_HEIGHT - PLAYER_HEIGHT*2;
    int old_playerX = 0;
    int old_playerY = 0;
    int playerXVel = 0;
    int playerYVel = 0;
    int playerJumpVel = 0;
    bool resolved;
    int lava_height;

    /* Allocate crate array, require success */
    crates = (crate *)malloc(sizeof(crate)*MAX_CRATE_COUNT);
    require(crates!=NULL, "successfull crates array allocation");

    /* Initialize lava */
    InitLava();

    while(gameLoop)
    {
        /* limit FPS */
        LimitFPS();

        /* refresh keystate */
        keystate = SDL_GetKeyState(NULL);

        /* detect quit event */
        while(SDL_PollEvent(&event))
            if(event.type==SDL_QUIT)
                gameLoop = false;

        /* key actions -------------------------------------- */

        if(keystate[SDLK_ESCAPE] || keystate[SDLK_q])
            gameLoop = false;

        if(keystate[SDLK_RIGHT])
            if(playerXVel++ > MAX_PLAYER_XVEL)
                playerXVel = MAX_PLAYER_XVEL;

        if(keystate[SDLK_LEFT])
            if(playerXVel-- < 0-MAX_PLAYER_XVEL)
                playerXVel = 0-MAX_PLAYER_XVEL;

        if(keystate[SDLK_UP])
        {
            if(freshUpKey==true && playerJumpVel==0 && playerYVel==0)
            {
                playerJumpVel = MAX_PLAYER_YVEL;
            }

            freshUpKey = false;
        }
        else
        {
            freshUpKey = true;
        }

        if(keystate[SDLK_r])		/* force reset */
            gameOver = true;

        /* -------------------------------------------------- */

        /* movement physics --------------------------------- */

        playerX += playerXVel;
        playerY += playerYVel - playerJumpVel;

        if(playerX > SCREEN_WIDTH)
            playerX = 0-PLAYER_WIDTH;

        if(playerX < 0-PLAYER_WIDTH)
            playerX = SCREEN_WIDTH;

        if(playerXVel>0 && !keystate[SDLK_RIGHT])
            playerXVel--;

        if(playerXVel<0 && !keystate[SDLK_LEFT])
            playerXVel++;

        if(playerJumpVel>0)
            playerJumpVel--;

        if(playerYVel<MAX_PLAYER_YVEL)
            playerYVel++;

        if(playerY-cameraY > SCREEN_HEIGHT)
        {
            gameOver = true;
        }

        /* -------------------------------------------------- */

        /* player-crate collisions -------------------------- */

        /*
         * if there are collisions agains tops /and/ bottoms of
         * crates, the player has been smashed
         */
        up_collision_count = 0;
        down_collision_count = 0;

        /* collision code assigns new values to player(X | Y) via "fixed" prefix */
        fixed_playerX = playerX;
        fixed_playerY = playerY;

        /* the floor is built-in */
        if(playerY>SCREEN_HEIGHT-PLAYER_HEIGHT)
        {
            /* hit floor */
            playerY = SCREEN_HEIGHT - PLAYER_HEIGHT;
            playerYVel = 0;
            playerJumpVel = 0;
            down_collision_count++;
        }

        for(crate_id = 1; crate_id <= crate_count; crate_id ++)
        {
            /* check for collision with crate # crate_id */
            if(RC_collides(playerX, playerY,
                           PLAYER_WIDTH, PLAYER_HEIGHT,
                           crates[crate_id].x, crates[crate_id].y,
                           crates[crate_id].size, crates[crate_id].size))
            {
                resolved = false;

                /* determine collision type */

                if(old_playerY + PLAYER_HEIGHT <= crates[crate_id].y)
                {
                    /* top of crate */
                    fixed_playerY = crates[crate_id].y - PLAYER_HEIGHT;
                    playerYVel = 0;
                    playerJumpVel = 0;
                    down_collision_count++;
                    resolved = true;
                }
                else if(old_playerX + PLAYER_WIDTH <= crates[crate_id].x)
                {
                    /* left of crate */
                    fixed_playerX = crates[crate_id].x - PLAYER_WIDTH;
                    resolved = true;
                }
                else if(old_playerX >= crates[crate_id].x + crates[crate_id].size)
                {
                    /* right of crate */
                    fixed_playerX = crates[crate_id].x + crates[crate_id].size;
                    resolved = true;
                }
                else if(old_playerY > crates[crate_id].y + crates[crate_id].size)
                {
                    /* bottom of crate */
                    fixed_playerY = crates[crate_id].y + crates[crate_id].size + 1;
                    playerYVel = 0;
                    playerJumpVel = 0;
                    up_collision_count++;
                    resolved = true;
                }
                else if(crates[crate_id].y + crates[crate_id].size - crates[crate_id].velocity < old_playerY)
                {
                    /* bottom of crate */
                    fixed_playerY = crates[crate_id].y + crates[crate_id].size + 1;
                    playerYVel = 0;
                    playerJumpVel = 0;
                    up_collision_count++;
                    resolved = true;
                }

                if(resolved==false)
                {
                    /*
                     * collision not belonging to any of the above types
                             * default to game over
                     */
                    gameOver = true;
                }
            }
        }

        if(up_collision_count>0 && down_collision_count>0)
        {
            /* player stuck between two crates */
            playerYVel = 0;
            playerJumpVel = 0;
            gameOver = true;
        }

        /* store new coordinates */
        playerY = fixed_playerY;
        playerX = fixed_playerX;

        /* -------------------------------------------------- */

        /* manage crates ------------------------------------ */

        if(crate_delay_counter++ > CRATE_FRAME_DELAY)
        {
            /* Create new crate */
            crate_delay_counter = 0;
            initializeCrate(&crates[++crate_count], cameraY);
        }

        DoCratesPhysics(crates, crate_count);

        /* -------------------------------------------------- */

        /* track player with camera ------------------------ */

        if(playerY-cameraY < 100)
        {
            if(cameraYVel < 20)
            {
                cameraYVel++;
            }
        }
        else
        {
            if(cameraYVel > 0)
            {
                cameraYVel--;
            }
        }

        cameraY -= cameraYVel;

        /* -------------------------------------------------- */

        /* manage lava -------------------------------------- */

        lava_height = ManageLava();

        if(playerY+PLAYER_HEIGHT/2 >= lava_height)
        {
            /* Player fell in lava */
            gameOver = true;
        }

        /* -------------------------------------------------- */

        /* draw the whole scene ----------------------------- */

        DrawBackground(gameScreen);
        DrawCrates(gameScreen, crates, crate_count, cameraY);
        DrawPlayer(gameScreen, playerX, playerY - cameraY);
        DrawLava(gameScreen, cameraY);

        SDL_Flip(gameScreen);

        /* -------------------------------------------------- */

        /* "old" variables ---------------------------------- */

        old_playerX = playerX;
        old_playerY = playerY;

        /* -------------------------------------------------- */

        /* game reset on gameOver --------------------------- */

        if(gameOver)
        {
            GameOverMovie(gameScreen, crates, crate_count, cameraY, playerX, playerY - cameraY);

            cameraY = 0;
            gameOver = false;
            playerY = SCREEN_HEIGHT - PLAYER_HEIGHT*2;
            crate_count = 0;
            crate_delay_counter = 0;

            InitLava();
        }

        /* -------------------------------------------------- */

    }

    free(crates);

}

