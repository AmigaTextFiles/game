#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <SDL.h>

#include "board.h"
#include "graphics.h"
#include "menu.h"
#include "score.h"
#include "bonus.h"
#include "game.h"

#ifdef __MORPHOS__
const char *version_tag = "$VER: GemZ 0.97.0 (26.07.2006)";
#endif

/* ************************************************************************ */
/* FUNCTION PROTOTYPES */
/* ************************************************************************ */
int init(screen_t* screen);
int game_loop(game_t* game, screen_t* screen);
void end_game(screen_t* screen);
void draw_screen(game_t* game, screen_t* screen);
void mouse_click(game_t* game, SDL_MouseButtonEvent click);

/* ************************************************************************ */
/* FUNCTION main */
/* Performs 4 operatiosn: */
/*  1. Initialize the game */
/*  2. Display and obtain user input from a menu */
/*  3. Start the game loop */
/*  4. Clean up before the program exits */
/* ************************************************************************ */
int main()
{
    game_t game;
    screen_t screen;
    
    /* initialize various systems (sounds, graphics, input, etc) */
    if (init(&screen)) 
    {       
        /* menu() gets saved game or new game, also allows the user to change*/
        /* tileset*/
        while(menu(&game, &screen))
        /* start the game loop */
            if (!game_loop(&game, &screen))
                break;
    }
    else
        printf("init failed\n");
	      
    /* at this point the game is over, show an exit screen */
    end_game(&screen);
    
    return 0;
}

/* ************************************************************************ */
/* FUNCTION init */
/* Initialize SDL */
/* Initialize graphics */
/* Initialize audio */
/* ************************************************************************ */
int init(screen_t* screen)
{
    if((SDL_Init(0)==-1))
    { 
        printf("Could not initialize SDL: %s.\n", SDL_GetError());
        exit(-1);
    }
    
    screen->screen = init_graphics();
    if (!load_tileset("tilesets/default", &(screen->tileset)))
        return 0;
    if (!(screen->background = IMG_Load("gfx/background.png")))
        return 0;
    if (!(screen->bonus = IMG_Load("gfx/bonus.png")))
        return 0;
    if (!(screen->selector = IMG_Load("gfx/selector.png")))
        return 0;
    //init_audio();
    return 1;
}

/* ************************************************************************ */
/* FUNCTION game_loop */
/* Draw the screen */
/* Wait for input */
/* Update pieces */
/* Repeat until no moves can be made*/
/* ************************************************************************ */
int game_loop(game_t* game, screen_t* screen)
{
    int done, i;
    SDL_Event event;
    
    for (i = 0; i < SDL_NUMEVENTS; i++)
        SDL_EventState(i, SDL_IGNORE);

    SDL_EventState(SDL_MOUSEBUTTONDOWN, SDL_ENABLE);
    SDL_EventState(SDL_QUIT, SDL_ENABLE);
    
    draw_screen(game, screen);
    
    done = 0;
    while(!done)
    {
        update_board(game, screen);
        draw_screen(game, screen);
        if (!find_move(game, screen))
            break;
        
        SDL_WaitEvent(&event);
        switch(event.type)
        {
        case SDL_MOUSEBUTTONDOWN:
            mouse_click(game, event.button);
            break;
        case SDL_QUIT:
            done = 1;
            break;
        }
    }
    return !done;
}

void mouse_click(game_t* game, SDL_MouseButtonEvent click)
{
    int x, y;

    click.x -= LEFT_BORDER;
    click.y -= TOP_BORDER;
    
    x = click.x / PIECE_WIDTH;
    y = click.y / PIECE_HEIGHT;
    
    /* clicking outside the board unselects current square */
    if (x < 0 || y < 0 || x >= BOARD_WIDTH || y >= BOARD_HEIGHT)
    {
        game->board.sel_x = -1;
        game->board.sel_y = -1;        
        return;
    }

    /* clicking on a square unselects it */
    if (game->board.sel_x == x && game->board.sel_y == y)
    {
        game->board.sel_x = -1;
        game->board.sel_y = -1;        
        return;
    }

    if (game->board.sel_x == -1)
    {
        game->board.sel_x = x;
        game->board.sel_y = y;
    }
    else
    {
       /* move_piece() leaves board unchanged if the move wasn't valid */
        if(((game->board.sel_x + 1) == x) && (game->board.sel_y == y))
        {
            move_piece(&(game->board), RIGHT);
        }
        else if(((game->board.sel_x - 1) == x) && (game->board.sel_y == y))
        {
            move_piece(&(game->board), LEFT);
        }
        else if(((game->board.sel_y - 1) == y) && (game->board.sel_x == x))
        {
            move_piece(&(game->board), UP);
        }
        else if(((game->board.sel_y + 1) == y) && (game->board.sel_x == x))
        {
            move_piece(&(game->board), DOWN);
        }
        else
        {
           /* user didn't click on a square next to selected one */
           /* make this square the selected one instead */
            game->board.sel_x = x;
            game->board.sel_y = y;
            return;
        }
        
        game->board.sel_x = -1;
        game->board.sel_y = -1;
    }
}
    
void draw_screen(game_t* game, screen_t* screen)
{
    if (screen)
    {
        draw_canvas(screen->background, screen, 0, 0);
	draw_selector(&(game->board), screen);
	draw_board(&(game->board), screen);
	draw_score(game, screen, 475, 80);
	draw_level(game, screen, 475, 171);
	draw_bonus(game, screen, 535, 239);    
	
	SDL_Flip(screen->screen);
    }
}

void end_game(screen_t* screen)
{
    free_tileset(&(screen->tileset));
    free_font();
    SDL_FreeSurface(screen->background);
    SDL_FreeSurface(screen->bonus);
    SDL_FreeSurface(screen->selector);
    SDL_FreeSurface(screen->screen);
}
