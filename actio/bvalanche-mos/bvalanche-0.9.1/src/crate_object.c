#include <stdio.h>
#include <stdlib.h>

#include <SDL/SDL.h>

#include "bool.h"
#include "constants.h"
#include "crate_object.h"
#include "graphics.h"
#include "RectangularCollision.h"

/* Crate colors */
#define CRATE_COLORS_COUNT 3
int crate_colors_r[] = { 255, 0, 127 };
int crate_colors_g[] = { 80, 105, 30 };
int crate_colors_b[] = { 127, 0, 255 };

/* Crate sizes */
#define CRATE_SIZES_COUNT 5
int crate_sizes[] = { 110, 120, 105, 90, 130 };

void initializeCrate(crate* crate, int cameraY)
{
    float RandomNumber = rand();

    crate->size = crate_sizes[(int)(CRATE_SIZES_COUNT * (RandomNumber/RAND_MAX))];

    crate->x = (SCREEN_WIDTH - crate->size) * (RandomNumber/RAND_MAX);
    crate->y = cameraY - crate->size;

    crate->r = crate_colors_r[(int)(CRATE_COLORS_COUNT * (RandomNumber/RAND_MAX))];
    crate->g = crate_colors_g[(int)(CRATE_COLORS_COUNT * (RandomNumber/RAND_MAX))];
    crate->b = crate_colors_b[(int)(CRATE_COLORS_COUNT * (RandomNumber/RAND_MAX))];

    crate->velocity = 0;
    crate->moving = true;
}

void DrawCrates(SDL_Surface* screen, crate* crates, int crate_count, int cameraY)
{
    int crate_id;

    for(crate_id = 1; crate_id <= crate_count; crate_id++)
    {
        DrawRectangle(screen,
                      crates[crate_id].x, crates[crate_id].y - cameraY,
                      crates[crate_id].size, crates[crate_id].size,
                      crates[crate_id].r, crates[crate_id].g, crates[crate_id].b);

        /*
         * printf("Drawing crate # %d : %d, %d ; %d, %d, %d\n", crate_id,
         *	crates[crate_id].x, crates[crate_id].y,
         *	crates[crate_id].r, crates[crate_id].g,
         *	crates[crate_id].b);
         */
    }
}

void DoCratesPhysics(crate* crates, int crate_count)
{
    int crate_id;
    int other_crate_id;

    for(crate_id = 1; crate_id <= crate_count; crate_id++)
    {
        if(crates[crate_id].moving)
        {

            /* Check for potential collisions with other crates */
            for(other_crate_id = 1; other_crate_id <= crate_count; other_crate_id++)
            {
                if(other_crate_id != crate_id)
                {
                    if(RC_collides(crates[crate_id].x, crates[crate_id].y + crates[crate_id].velocity,
                                   crates[crate_id].size, crates[crate_id].size,
                                   crates[other_crate_id].x, crates[other_crate_id].y,
                                   crates[other_crate_id].size, crates[other_crate_id].size))
                    {
                        /* Collision detected, freeze crates */
                        crates[crate_id].moving = false;
                        crates[other_crate_id].moving = false;

                        crates[crate_id].velocity = 0;
                        crates[crate_id].y = crates[other_crate_id].y - crates[crate_id].size;
                    }
                }
            }

            crates[crate_id].y += crates[crate_id].velocity;

            if(crates[crate_id].velocity < MAX_CRATE_VEL)
            {
                crates[crate_id].velocity++;
            }

            if(crates[crate_id].y > SCREEN_HEIGHT - crates[crate_id].size)
            {
                /* hit floor */
                crates[crate_id].y = SCREEN_HEIGHT - crates[crate_id].size;
                crates[crate_id].velocity = 0;
                crates[crate_id].moving = false;
            }

        }
    }
}

