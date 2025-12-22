#include <ctype.h>
#include <stdlib.h>
#include <string.h>

#include "const.h"
#include "communic.h"
#include "case.h"
#include "gameparams.h"
#include "goutils.h"
#include "display.h"
#include "spot.h"

#include <SDL_thread.h>
#include <SDL.h>

/* JEU */

typedef struct {
  ComPipe *pipe;
  int gg_play[2];
  int captures[2];
  int col;
  int comp_is_playing;
  Case dernierePose;
} GameInfo;

GameInfo *game_new (GameParams params);


/* gestion du plateau */

void poserPion (GameInfo *game, Case c);

// nb captured by col
int gg_captures (GameInfo *game, int col);

Uint32 line_anim_callback (Uint32 interval, Spot *spot);

//SDL_Rect hline (int py,int centerx);
//SDL_Rect vline (int px,int centery);

//typedef struct {
//  SDL_Rect rect;
//} DisplayText;

/*Uint32 display_text_callback (Uint32 interval, DisplayText *text) {
  SDL_Event e;

  e.type = SDL_USEREVENT;
  e.user.code = USER_EVENT_CLEARTEXT;
  e.user.data1 = text;
  e.user.data2 = NULL;

  SDL_PushEvent (&e);
  return 0;
}*/

//DisplayText *afficherTexte (TTF_Font *font, const char *text, int x, int y);
//void afficherTexte (TTF_Font *font, const char *text, int x, int y);

/*** thread de l'AI ***/

int make_gg_play (GameInfo *gi);
void init_sdl_stuff (GameParams params);


/* MAIN FUNCTION */

int main (int argc, char **argv) {
  Msg msg;
  GameInfo *game;
  SDL_Thread *comp_thread;

  GameParams params = getParamsFromArgs (argc, argv);
  game = game_new (params);
  init_sdl_stuff (params);

  while (1) {
    SDL_Event ev;

    if (game->gg_play [game->col] && (!game->comp_is_playing)) {
      game->comp_is_playing = 1;
      comp_thread = SDL_CreateThread (make_gg_play, game);
    }

    while (SDL_PollEvent (&ev)) {
      switch (ev.type) {

        case SDL_USEREVENT:
          if (ev.user.code == USER_EVENT_DRAWSPOT) {
            Spot *spot = ev.user.data1;
            spot_draw (spot);
            spot_approche_cible (spot);
          }
          else if (ev.user.code == USER_EVENT_GGPLAYED) {
            poserPion (game, *((Case*)ev.user.data1));
            game->col = game->col ? 0 : 1;
            game->comp_is_playing = 0;
          }
          break;

        case SDL_QUIT:
          if (game->comp_is_playing)
            SDL_WaitThread (comp_thread, NULL);
          TELL_GNUGO (game->pipe, "quit\n\n");
          SDL_Quit ();
          return 1;
        case SDL_KEYDOWN:
          if ((ev.key.keysym.sym == SDLK_q)
							|| (ev.key.keysym.sym == SDLK_ESCAPE)) {
            if (game->comp_is_playing)
              SDL_WaitThread (comp_thread, NULL);
            TELL_GNUGO (game->pipe, "quit\n\n");
            SDL_Quit ();
            return 1;
          }
          if ((ev.key.keysym.sym == SDLK_SPACE) && (!caseNulle (game->dernierePose))) {
            SDL_AddTimer(1, line_anim_callback, spot_new (game->dernierePose,game->col?0x22222222:0xdddddddd));
          }
          if ((ev.key.keysym.sym == SDLK_u) && (!game->gg_play[game->col])) {
            do {
              TELL_GNUGO (game->pipe, "undo\n");
              ASK_GNUGO (game->pipe, msg);
              redrawGoban (game->pipe);
              game->col = game->col ? 0 : 1;
            }
            while ((game->gg_play[game->col]) && (msg[0]=='='));
            game->captures [0] = gg_captures (game, 0);
            game->captures [1] = gg_captures (game, 1);
          }
          break;
        case SDL_MOUSEBUTTONDOWN: {
          Case c = getCase (ev.button.x, ev.button.y);
          if ((!caseNulle(c)) && (!game->gg_play[game->col])) {

            sprintf (msg, "%s %s\t\r\n", PLAYER_NAME(game->col), getStrPos(c.x,c.y));
            TELL_GNUGO (game->pipe, msg);
            ASK_GNUGO (game->pipe,msg);

            if (msg[0]=='=') {
              poserPion (game, c);
              game->col = game->col ? 0 : 1;
            }
          }
          break;
        }
      }

    }
  }
  return 0;
}




int gg_captures (GameInfo *game, int col) {
  int cap = -1;
  Msg msg;
  sprintf (msg, "captures %s\n", PLAYER_NAME(col));
  TELL_GNUGO(game->pipe,msg);
  ASK_GNUGO(game->pipe,msg);
  if (msg[0]=='=')
    sscanf (msg, "= %d", &cap);
  return cap;
}


void poserPion (GameInfo *game, Case c) {

  int cap;
  poserPionALEcran (game->col, c, 1);
  game->dernierePose = c;
  cap = gg_captures (game, game->col);
  if ((cap>0)&&(cap != game->captures[game->col])) {
    faireLeMenageAutourDe (c, game->pipe);
    game->captures[game->col] = cap;
  }
}


int getCouleurDansGG (Case c, ComPipe *pipe) {

  char msg [128];
  sprintf (msg, "color %s\n", getStrPos (c.x, c.y));
  TELL_GNUGO (pipe, msg);
  ASK_GNUGO (pipe, msg);
  if (msg [2] == 'b')
    return 0;
  if (msg [2] == 'w')
    return 1;
  return -1;
}




/*
void afficherTexte (TTF_Font *font, const char *text, int x, int y) {

  DisplayText *text;

  SDL_Color bcol = {0,0,0,0};
  SDL_Color wcol = {0xff,0xff,0xff,0xff};
  SDL_Surface *surf;
  SDL_Rect rect;

  rect.x = x; rect.y = y;
  surf = TTF_RenderText_Blended (font, text, wcol);
  rect.w = surf->w;
  rect.h = surf->h;

  text = malloc (sizeof (DisplayText));
  text->rect=rect;

  SDL_BlitSurface (surf, NULL, screen, &rect);
  SDL_FreeSurface (surf);

}
*/


/** init **/

GameInfo *game_new (GameParams params) {
  Msg msg;
  GameInfo *game = malloc (sizeof(GameInfo));

  game->gg_play [0] = params.gg_play [0]; // quels joueurs joue l'ordi?
  game->gg_play [1] = params.gg_play [1];

  game->captures[0] = 0;
  game->captures[1] = 0;
  game->col = 0; // couleur qui joue
  game->pipe = com_pipe_new (); // tube de communication

//  TELL_GNUGO (game->pipe, "level 0\n");
//  ASK_GNUGO (game->pipe, msg);

  game->comp_is_playing = 0;
  game->dernierePose.x = -1;
  game->dernierePose.y = -1;
  return game;
}




Uint32 line_anim_callback (Uint32 interval, Spot *spot) {

  SDL_Event e;

  e.type = SDL_USEREVENT;
  e.user.code = USER_EVENT_DRAWSPOT;
  e.user.data1 = spot;
  e.user.data2 = NULL;

  SDL_PushEvent (&e);

  if ((spot->x1 == -1)
    && (spot->x2 == -1)
    && (spot->y1 == -1)
    && (spot->y2 == -1))
      return 0;

  return 70;
}


int make_gg_play (GameInfo *gi) {
  Msg msg;
  SDL_Event e;
  Case *c = NULL;

  sprintf (msg, "genmove_%s\n", PLAYER_NAME(gi->col));
  TELL_GNUGO (gi->pipe,msg);
  ASK_GNUGO (gi->pipe,msg);
  if (msg[0] == '=') {
    c = malloc (sizeof (Case));
    *c = strToCase (getMessageIn (msg));
  }

  e.type = SDL_USEREVENT;
  e.user.code = USER_EVENT_GGPLAYED;
  e.user.data1 = c;
  e.user.data2 = NULL;

  SDL_PushEvent (&e);

  return 0;
}


