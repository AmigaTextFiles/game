/*
  FOP: Fight or Perish

  Based on Jack Pavelich's "Dandy" ('Thesis of Terror')
  and Atari Games' "Gauntlet"

  by Bill Kendrick <bill@newbreedsoftware.com>
  http://www.newbreedsoftware.com/fop/

  February 25, 2009 - March 15, 2009
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "SDL.h"
#include "SDL_image.h"

#define SCREENW 640
#define SCREENH 480

#define TILEW 32
#define TILEH 32

#define MAXHEALTH 1200

#define FPS 10

typedef struct arrow_s {
  int alive;
  int x, y, xm, ym;
} arrow_t;

#define MAXARROWS 3

typedef struct map_s {
  int w, h;
  char * m;
  int startx[4], starty[4];
} map_t;

#define setmap(M, y, x, c) (M)->m[((y) * (M)->w) + (x)] = (c)
#define getmap(M, y, x) ((M)->m[((y) * (M)->w) + (x)])

/* Characters:
  1 - Fast with weak weapon
  2 - Slow but strong
  3 - Evenly balanced
  4 - Weak but with powerful weapon
*/

int char_speeds[4] = {3, 1, 2, 2};
int char_healths[4] = {2, 3, 2, 1};
int char_weapons[4] = {1, 2, 2, 3};
Uint32 char_colors[4] = {0xffff00, 0xff00ff, 0x00ff00, 0x0000ff};

enum {
  UPGRADE_NONE = -1,
  UPGRADE_HEALTH,
  UPGRADE_WEAPON,
  UPGRADE_SPEED,
  NUM_UPGRADES
};
#define UPGRADE_INIT_TIME 200

enum {
  KEY_DOWN,
  KEY_UP,
  KEY_LEFT,
  KEY_RIGHT,
  KEY_FIRE,
  KEY_BOMB,
  NUM_KEYS
};

int key_codes[4][NUM_KEYS];

typedef struct stick_code_s {
  int joy, axis, axis_sign, btn;
} stick_code_t;

stick_code_t stick_codes[4][NUM_KEYS];

#define speed_check(toggle, speed) (((toggle) % (4 - (((speed) <= 3 ? (speed) : 3)))) == 0)

SDL_Surface * screen;
SDL_Surface * img_title, * img_playerselect, * img_stats, * img_numbers;
SDL_Surface * img_generators, * img_collectibles, * img_blockers, * img_badguys;
SDL_Surface * img_player[4], * img_arrows[4];
int num_players;
int plytype[4];
int level;
int plyx[4], plyy[4], score[4], oldplyx[4], oldplyy[4], health[4], maxhealth[4], bombs[4], keys[4], oldhealth[4], oldscore[4], hurting[4], plymovetoggle[4], upgrade[4], upgradetime[4], exited[4];

enum {
  MENU_START,
  MENU_OPTIONS,
  MENU_QUIT
};

enum {
  STARTGAME_START,
  STARTGAME_BACK,
  STARTGAME_QUIT
};

enum {
  GAME_NEXTLEVEL,
  GAME_FINISHED,
  GAME_BACK,
  GAME_QUIT
};

#define sign(x) (((x) < 0) ? -1 : (((x) > 0) ? 1 : 0))
void setup(int argc, char * argv[]);
map_t * loadmap(int level);
void freemap(map_t * * map);
int safe(map_t * map, int x, int y, int toggle);
int bomb(map_t * map, int plyx, int plyy);
void opendoor(map_t * map, int x, int y);
SDL_Surface * loadimage(char * fname);
void drawimage(SDL_Surface * screen, SDL_Surface * sheet, int tilew, int tileh, int tilex, int tiley, int x, int y);
int closestplayer(map_t * map, int plyx[4], int plyy[4], int health[4], int x, int y);
int menu(void);
int startgame(void);
int game(int level);

int main(int argc, char * argv[])
{
  int option, quit, i;

  setup(argc, argv);

  /* Initialize start-game settings */

  level = 1;
  num_players = 1;
  for (i = 0; i < 4; i++)
    plytype[i] = i;

  quit = 0;

  do
  {
    option = menu();

    if (option == MENU_QUIT)
      quit = 1;
    else if (option == MENU_START)
    {
      i = startgame();
      if (i == STARTGAME_START)
      {
        do
        {
          i = game(level);
          if (i == GAME_NEXTLEVEL)
            level++;
        }
        while (i == GAME_NEXTLEVEL);
        if (i == GAME_QUIT)
          quit = 1;
      }
      else if (i == STARTGAME_QUIT)
        quit = 1;
    }
  }
  while (!quit);

  SDL_FreeSurface(img_title);
  SDL_FreeSurface(img_playerselect);
  SDL_FreeSurface(img_stats);
  SDL_FreeSurface(img_numbers);
  SDL_FreeSurface(img_generators);
  SDL_FreeSurface(img_collectibles);
  SDL_FreeSurface(img_blockers);
  SDL_FreeSurface(img_badguys);
  for (i = 0; i < 4; i++)
  {
    SDL_FreeSurface(img_player[i]);
    SDL_FreeSurface(img_arrows[i]);
  }

  SDL_Quit();

  return(0);
}

int game(int level)
{
  int done, results;
  int i, j, k, x, y, x2, y2, found, want, anyalive, allexited;
  int scrollx, scrolly;
  int finescrollx, finescrolly, finescrollwantx, finescrollwanty;
  map_t * map;
  char c, c2;
  int got;
  SDL_Rect dest;
  SDL_Event event;
  SDLKey key;
  Uint32 timestamp, nowtimestamp;
  int toggle;
  int key_up[4], key_down[4], key_left[4], key_right[4], key_fire[4];
  int oldkey_up[4], oldkey_down[4], oldkey_left[4], oldkey_right[4];
  int plydirx[4], plydiry[4];
  int minx, maxx, miny, maxy;
  arrow_t arrows[4][MAXARROWS];
  char str[16];

  results = -1;

  map = loadmap(level);
  if (map == NULL)
    return(GAME_FINISHED);

  scrollx = scrolly = 0;
  finescrollx = finescrolly = finescrollwantx = finescrollwanty = 0;

  for (i = 0; i < 4; i++)
  {
    key_up[i] = key_down[i] = key_left[i] = key_right[i] = key_fire[i] = 0;

    exited[i] = 0;

    /* Start out facing down */
    plydirx[i] = 2;
    plydiry[i] = 3;
    plyx[i] = map->startx[i];
    plyy[i] = map->starty[i];

    setmap(map, plyy[i], plyx[i], ' ');
    plymovetoggle[i] = 0;

    for (j = 0; j < MAXARROWS; j++)
      arrows[i][j].alive = 0;
  }

  done = 0;
  toggle = 0;


  /* Main loop: */

  do
  {
    timestamp = SDL_GetTicks();
    toggle++;

    /* Determine center of all live player's positions, to center scrolling: */

    maxx = 0;
    maxy = 0;
    minx = map->w;
    miny = map->h;
    j = 0;
    for (i = 0; i < 4; i++)
    {
      if (health[i] > 0 && exited[i] == 0)
      {
        if (plyx[i] < minx)
          minx = plyx[i];
        if (plyx[i] > maxx)
          maxx = plyx[i];

        if (plyy[i] < miny)
          miny = plyy[i];
        if (plyy[i] > maxy)
          maxy = plyy[i];

        j++;
      }
    }
    if (j > 0)
    {
      scrollx = ((maxx - minx) / 2) + minx;
      scrolly = ((maxy - miny) / 2) + miny;
    }

    if (scrollx < (SCREENW / TILEW) / 2)
      scrollx = (SCREENW / TILEW) / 2;
    else if (scrollx > map->w - (SCREENW / TILEW) / 2)
      scrollx = map->w - (SCREENW / TILEW) / 2;

    if (scrolly < (SCREENH / TILEH) / 2)
      scrolly = (SCREENH / TILEH) / 2;
    else if (scrolly > map->h - (SCREENH / TILEH) / 2)
      scrolly = map->h - (SCREENH / TILEH) / 2;

    finescrollwantx = scrollx * TILEW;
    finescrollwanty = scrolly * TILEH;

    if (finescrollx != finescrollwantx)
    {
      finescrollx += ((finescrollwantx - finescrollx) / (TILEW / 4)) + sign(finescrollwantx - finescrollx);
    }
    if (finescrolly != finescrollwanty)
    {
      finescrolly += ((finescrollwanty - finescrolly) / (TILEH / 4)) + sign(finescrollwanty - finescrolly);
    }

    for (i = 0; i < 4; i++)
    {
      /* Temporarily keep track of old state for comparison or rollback: */

      oldhealth[i] = health[i];

      oldplyx[i] = plyx[i];
      oldplyy[i] = plyy[i];

      oldkey_up[i] = key_up[i];
      oldkey_down[i] = key_down[i];
      oldkey_left[i] = key_left[i];
      oldkey_right[i] = key_right[i];

      oldscore[i] = score[i];
    }


    /* Handle events: */

    while (SDL_PollEvent(&event) > 0)
    {
      if (event.type == SDL_QUIT)
      {
        done = 1;
        results = GAME_QUIT;
      }
      else if (event.type == SDL_KEYDOWN)
      {
        key = event.key.keysym.sym;
        if (key == SDLK_ESCAPE)
        {
          done = 1;
          results = GAME_BACK;
        }
        else
        {
          for (i = 0; i < 4; i++)
          {
            if (key == key_codes[i][KEY_DOWN])
              key_down[i] = 1;
            else if (key == key_codes[i][KEY_UP])
              key_up[i] = 1;
            else if (key == key_codes[i][KEY_LEFT])
              key_left[i] = 1;
            else if (key == key_codes[i][KEY_RIGHT])
              key_right[i] = 1;
            else if (key == key_codes[i][KEY_FIRE])
              key_fire[i] = 1;
            else if (key == key_codes[i][KEY_BOMB])
            {
              if (bombs[i] > 0 && health[i] > 0 && exited[i] == 0)
              {
                score[i] += bomb(map, scrollx, scrolly);
                bombs[i]--;
              }
            }
          }
        }
      }
      else if (event.type == SDL_KEYUP)
      {
        key = event.key.keysym.sym;
        for (i = 0; i < 4; i++)
        {
          if (key == key_codes[i][KEY_DOWN])
            key_down[i] = 0;
          else if (key == key_codes[i][KEY_UP])
            key_up[i] = 0;
          else if (key == key_codes[i][KEY_LEFT])
            key_left[i] = 0;
          else if (key == key_codes[i][KEY_RIGHT])
            key_right[i] = 0;
          else if (key == key_codes[i][KEY_FIRE])
            key_fire[i] = 0;
        }
      }
      else if (event.type == SDL_JOYAXISMOTION)
      {
        for (i = 0; i < 4; i++)
        {
          for (j = 0; j < NUM_KEYS; j++)
          {
            if (event.jaxis.which == stick_codes[i][j].joy &&
                event.jaxis.axis == stick_codes[i][j].axis)
            {
              if ((event.jaxis.value > 0 && stick_codes[i][j].axis_sign > 0) ||
                  (event.jaxis.value < 0 && stick_codes[i][j].axis_sign < 0))
              {
                if (j == KEY_UP)
                {
                  key_up[i] = 1;
                  key_down[i] = 0;
                }
                else if (j == KEY_DOWN)
                {
                  key_down[i] = 1;
                  key_up[i] = 0;
                }
                else if (j == KEY_LEFT)
                {
                  key_left[i] = 1;
                  key_right[i] = 0;
                }
                else if (j == KEY_RIGHT)
                {
                  key_right[i] = 1;
                  key_left[i] = 0;
                }
              }
              else if (event.jaxis.value == 0)
              {
                if (j == KEY_UP)
                  key_up[i] = 0;
                else if (j == KEY_DOWN)
                  key_down[i] = 0;
                else if (j == KEY_LEFT)
                  key_left[i] = 0;
                else if (j == KEY_RIGHT)
                  key_right[i] = 0;
              }
            }
          }
        }
      }
      else if (event.type == SDL_JOYBUTTONDOWN)
      {
        for (i = 0; i < 4; i++)
        {
          for (j = 0; j < NUM_KEYS; j++)
          {
            if (event.jbutton.which == stick_codes[i][j].joy &&
                event.jbutton.button == stick_codes[i][j].btn)
            {
              if (j == KEY_UP)
                key_up[i] = 1;
              else if (j == KEY_DOWN)
                key_down[i] = 1;
              else if (j == KEY_LEFT)
                key_left[i] = 1;
              else if (j == KEY_RIGHT)
                key_right[i] = 1;
              else if (j == KEY_FIRE)
                key_fire[i] = 1;
              else if (j == KEY_BOMB)
              {
                if (bombs[i] > 0 && health[i] > 0 && exited[i] == 0)
                {
                  score[i] += bomb(map, scrollx, scrolly);
                  bombs[i]--;
                }
              }
            }
          }
        }
      }
      else if (event.type == SDL_JOYBUTTONUP)
      {
        for (i = 0; i < 4; i++)
        {
          for (j = 0; j < NUM_KEYS; j++)
          {
            if (event.jbutton.which == stick_codes[i][j].joy &&
                event.jbutton.button == stick_codes[i][j].btn)
            {
              if (j == KEY_UP)
                key_up[i] = 0;
              else if (j == KEY_DOWN)
                key_down[i] = 0;
              else if (j == KEY_LEFT)
                key_left[i] = 0;
              else if (j == KEY_RIGHT)
                key_right[i] = 0;
              else if (j == KEY_FIRE)
                key_fire[i] = 0;
            }
          }
        }
      }
    }

    /* Based on keys, which direction is the player facing? */

    for (i = 0; i < 4; i++)
    {
      if (key_up[i])
        plydiry[i] = 1;
      else if (key_down[i])
        plydiry[i] = 3;
      else if (key_right[i] || key_left[i])
        plydiry[i] = 2;

      if (key_left[i])
        plydirx[i] = 1;
      else if (key_right[i])
        plydirx[i] = 3;
      else if (key_up[i] || key_down[i])
        plydirx[i] = 2;

      if (speed_check(toggle, char_speeds[plytype[i]] + (upgrade[i] == UPGRADE_SPEED ? 1 : 0)))
        plymovetoggle[i] = !plymovetoggle[i];

      got = -1;

      if (health[i] > 0 && exited[i] == 0)
      {
        if (key_fire[i])
        {
          /* If pressing [Fire], and a direction, try to shoot: */

          found = -1;
          if ((key_up[i] && !oldkey_up[i]) ||
              (key_down[i] && !oldkey_down[i]) ||
              (key_left[i] && !oldkey_left[i]) ||
              (key_right[i] && !oldkey_right[i]))
          {
            for (j = 0; j < MAXARROWS && found == -1; j++)
            {
              if (arrows[i][j].alive == 0)
                found = j;
            }
          }

          if (found != -1)
          {
            /* Add an arrow: */

            arrows[i][found].alive = 1;
            arrows[i][found].x = plyx[i];
            arrows[i][found].y = plyy[i];

            if (key_up[i])
              arrows[i][found].ym = -1;
            else if (key_down[i])
              arrows[i][found].ym = 1;
            else
              arrows[i][found].ym = 0;

            if (key_left[i])
              arrows[i][found].xm = -1;
            else if (key_right[i])
              arrows[i][found].xm = 1;
            else
              arrows[i][found].xm = 0;

            /* Directional handicap for weak weapons: */
            if (char_weapons[plytype[i]] == 1 && upgrade[i] != UPGRADE_WEAPON)
            {
              if (arrows[i][found].xm != 0 && arrows[i][found].ym != 0)
              {
                if (toggle % 2)
                  arrows[i][found].xm = 0;
                else
                  arrows[i][found].xm = 0;
              }
            }

            /* FIXME: Sound effect */
          }
        }
        else if (speed_check(toggle, char_speeds[plytype[i]] + (upgrade[i] == UPGRADE_SPEED ? 1 : 0)))
        {
          /* Not pressing [Fire]; move the player, if they're pressing any arrow key(s): */

          /* Note: We cannot move diagonally in a single frame, so we use 'toggle % 2'
             determine which direction to go if the user is pressing two arrow keys at once. */

          if (key_up[i] && plyy[i] > scrolly - ((SCREENH / TILEH) / 2))
          {
            if ((key_left[i] == 0 && key_right[i] == 0) || plymovetoggle[i] == 0)
            {
              got = safe(map, plyx[i], plyy[i] - 1, toggle);
              if (got != -1)
                plyy[i]--;
            }
          }
          else if (key_down[i] && plyy[i] < scrolly + ((SCREENH / TILEH) / 2))
          {
            if ((key_left[i] == 0 && key_right[i] == 0) || plymovetoggle[i] == 0)
            {
              got = safe(map, plyx[i], plyy[i] + 1, toggle);
              if (got != -1)
                plyy[i]++;
            }
          }

          if (key_left[i] && plyx[i] > scrollx - ((SCREENW / TILEW) / 2))
          {
            if ((key_up[i] == 0 && key_down[i] == 0) || plymovetoggle[i] == 1)
            {
              got = safe(map, plyx[i] - 1, plyy[i], toggle);
              if (got != -1)
                plyx[i]--;
            }
          }
          else if (key_right[i] && plyx[i] < scrollx + ((SCREENW / TILEW) / 2) - 1)
          {
            if ((key_up[i] == 0 && key_down[i] == 0) || plymovetoggle[i] == 1)
            {
              got = safe(map, plyx[i] + 1, plyy[i], toggle);
              if (got != -1)
                plyx[i]++;
            }
          }
        }
      }

      /* If they player bumped into something that we can act upon... */

      if (got == '$')
      {
        /* Money */

        setmap(map, plyy[i], plyx[i], ' ');
        score[i] += 10;
        /* FIXME: Sound effect */
      }
      else if (got == '?')
      {
        /* Random bonus */

        setmap(map, plyy[i], plyx[i], ' ');
        upgrade[i] = rand() % NUM_UPGRADES;
        upgradetime[i] = UPGRADE_INIT_TIME;
        score[i] += 10;
        /* FIXME: Sound effect */
      }
      else if (got == 'b')
      {
        /* A bomb */

        setmap(map, plyy[i], plyx[i], ' ');
        bombs[i]++;
        /* FIXME: Sound effect */
      }
      else if (got == 'k')
      {
        /* A key */

        setmap(map, plyy[i], plyx[i], ' ');
        keys[i]++;
        /* FIXME: Sound effect */
      }
      else if (got == '=')
      {
        /* A door */

        if (keys[i] > 0)
        {
          /* We have a key; remove the door: */

          keys[i]--;
          opendoor(map, plyx[i], plyy[i]);
          /* FIXME: Sound effect */
        }
        else
        {
          /* No keys; user cannot go through the door! */

          plyx[i] = oldplyx[i];
          plyy[i] = oldplyy[i];
          /* FIXME: Sound effect */
        }
      }
      else if (got == '%')
      {
        exited[i] = 1;
      }
      else if (got == 'F')
      {
        /* Food */

        setmap(map, plyy[i], plyx[i], ' ');
        health[i] += (MAXHEALTH / 30);
        if (health[i] > maxhealth[i])
          health[i] = maxhealth[i];
        /* FIXME: Sound effect */
      }
      else if (got == 'C' || got == 'B' || got == '3' || got == '2')
      {
        /* A bad guy or generator, higher than level 1:
           Reduce the bad guy or generator, bounce player back, reduce player's health */

        setmap(map, plyy[i], plyx[i], getmap(map, plyy[i], plyy[i]) - 1);
        plyx[i] = oldplyx[i];
        plyy[i] = oldplyy[i];
        if (upgrade[i] != UPGRADE_HEALTH)
          health[i] -= 10;
        score[i] += 10;
        /* FIXME: Sound effect */
      }
      else if (got == 'A' || got == '1')
      {
        /* A bad guy or generator, at level 1:
           Remove the bad guy or generator, reduce player's health */

        setmap(map, plyy[i], plyx[i], ' ');
        if (upgrade[i] != UPGRADE_HEALTH)
          health[i] -= 10;
        score[i] += 10;
        /* FIXME: Sound effect */
      }
      else if (got == 'w' || got == 'x' || got == 'y' || got == 'z')
      {
        /* A dead player's treasure */

        score[i] += 100;
        keys[i] += keys[got - 'w'];
        bombs[i] += bombs[got - 'w'];
        setmap(map, plyy[i], plyx[i], ' ');
        keys[got - 'w'] = 0;
        bombs[got - 'w'] = 0;
      }


      /* Handle arrows: */
      /* FIXME: These can be handled as part of the map's cellular automata -bjk 2009.02.26 */

      for (j = 0; j < MAXARROWS; j++)
      {
        /* Since bad guys can move into the arrow's position as the arrow
           is about to go by, we check whether the arrow hit anything before and after
           moving it. */

        for (k = 0; k < 2; k++)
        {
          if (k == 1 && arrows[i][j].alive)
          {
            /* Arrow exists;
               If we've already checked for bad guys at the original position,
               move it (and see if it's still on the map) */

            arrows[i][j].x += arrows[i][j].xm;
            arrows[i][j].y += arrows[i][j].ym;
            if (arrows[i][j].y < 0 || arrows[i][j].y >= map->h || arrows[i][j].x < 0 || arrows[i][j].x >= map->w ||
                arrows[i][j].y < scrolly - ((SCREENH / TILEH) / 2) ||
                arrows[i][j].y > scrolly + ((SCREENH / TILEH) / 2) ||
                arrows[i][j].x < scrollx - ((SCREENW / TILEW) / 2) ||
                arrows[i][j].x > scrollx + ((SCREENW / TILEW) / 2))
              arrows[i][j].alive = 0;
          }

          if (arrows[i][j].alive)
          {
            /* Arrow still exists; see what it hit into */

            c = getmap(map, arrows[i][j].y, arrows[i][j].x);
            if (c == 'B' || c == 'C' || c == '2' || c == '3')
            {
              /* A bad guy or generator, higher than level 1:
                 Reduce the bad guy or generator */

              setmap(map, arrows[i][j].y, arrows[i][j].x, (c - 1));
              score[i] += 10;
              /* FIXME: Sound effect */
            }
            else if (c == 'A' || c == '1')
            {
              /* A bad guy or generator, at level 1:
                 Remove the bad guy or generator */

              setmap(map, arrows[i][j].y, arrows[i][j].x, ' ');
              score[i] += 10;
              /* FIXME: Sound effect */

              /* Some players' arrows keep going after a kill */
              if (char_weapons[plytype[i]] + (upgrade[i] == UPGRADE_WEAPON ? 1 : 0) == 3)
                c = ' ';
            }
            else if (c == 'b')
            {
              /* A bomb; activate it now! */

              setmap(map, arrows[i][j].y, arrows[i][j].x, ' ');
              score[i] += (bomb(map, scrollx, scrolly) / 2);
              /* FIXME: Sound effect */
            } 
            else if (c == 'F')
            {
              /* Food; remove it (don't shoot food!!!) */

              setmap(map, arrows[i][j].y, arrows[i][j].x, ' ');
              /* FIXME: Sound effect */
            } 


            /* Arrows go away once they hit _anything_ */

            if (c != ' ')
              arrows[i][j].alive = 0;
          }
        }
      }
    }


    /* Handle objects on the map, as a cellular automata: */

    for (y = 0; y < map->h; y++)
    {
      for (x = 0; x < map->w; x++)
      {
        want = closestplayer(map, plyx, plyy, health, x, y);

        /* For those objects interested, which way do we go to
           head towards the player */

        if (plyy[want] > y)
          y2 = y + 1;
        else if (plyy[want] < y)
          y2 = y - 1;
        else
          y2 = y;

        if (plyx[want] > x)
          x2 = x + 1;
        else if (plyx[want] < x)
          x2 = x - 1;
        else
          x2 = x;

        /* Note: We cannot move diagonally in a single frame,
           so use (toggle % 2) to determine which way to go
           (up/down, or left/right), if we're headed diagonally */

        if (y2 != y && x2 != x)
        {
          if (toggle % 2 == 0)
            x2 = x;
          else
            y2 = y;
        }

        /* What's at our current position (and the one we want to
           go to, if we're a bad-guy) */

        c = getmap(map, y, x);
        c2 = getmap(map, y2, x2);

        /* FIXME: Here, we could decide bad guys move semi-randomly
           towards the player they're chasing, if they cannot move into
           an empty space */

        if (c == 'A' || c == 'B' || c == 'C')
        {
          /* Bad guys (who haven't moved already) */

          /* See if we're walking into a player */

          k = -1;
          for (i = 0; i < 4; i++)
          {
            if (health[i] > 0 && exited[i] == 0)
            {
              if (x2 == plyx[i] && y2 == plyy[i])
              {
                k = i;
              }
            }
          }

          if (k != -1)
          {
            /* If we're adjacent to the player, try to do a melee attack */

            if (key_fire[k] == 0)
            {
              /* If player is not trying to attack us,
                 try to attack them.
                 (Our chance of succeeding in the melee attack depends
                 on what level we are) */

              if (upgrade[k] != UPGRADE_HEALTH)
              {
                if (c == 'A' && (rand() % 10) < 3)
                  health[k] -= 10;
                else if (c == 'B' && (rand() % 10) < 5)
                  health[k] -= 10;
                else if (c == 'C' && (rand() % 10) < 7)
                  health[k] -= 10;

                if (health[k] < oldhealth[k])
                {
                  /* FIXME: Sound effect */
                }
              }
            }
          }
          else
          {
            /* Head toward's the player we're chasing */
            /* Note: We place a modified bad guy onto the map, so that
               they can't move right or down more than once per frame,
               as we traverse the map.  They get replaced with normal
               bad guys after the entire map has been processed */

            if (c2 == ' ' && (rand() % 10) < 3)
            {
              setmap(map, y, x, ' ');
              setmap(map, y2, x2, (c - 'A' + 'X'));
            }
          }
        }
        else if (c == '1' || c == '2' || c == '3')
        {
          /* Generators */

          /* Pick a random adjacent spot */
          x2 = x + (rand() % 3) - 1;
          y2 = y + (rand() % 3) - 1;

          /* If the spot is empty, generate a bad guy of
             our level into the spot (but not one who
             can move this frame...) */

          if (getmap(map, y2, x2) == ' ')
            setmap(map, y2, x2, (c - '1' + 'X'));
        }
      }
    }

    /* Convert modified ('has already moved this frame') bad guys
       back to normal */
    for (y = 0; y < map->h; y++)
    {
      for (x = 0; x < map->w; x++)
      {
        c = getmap(map, y, x);
        if (c == 'X' || c == 'Y' || c == 'Z')
          setmap(map, y, x, (c - 'X' + 'A'));
      }
    }


    /* Handle players' heath- and timer-related things: */

    for (i = 0; i < 4; i++)
    {
      /* See if a player has earned enough points for a health upgrade */

      if (health[i] > 0 && (oldscore[i] / 1000) < (score[i] / 1000))
      {
        health[i] = maxhealth[i];
        maxhealth[i] += (MAXHEALTH / 4);
        if (maxhealth[i] > MAXHEALTH)
          maxhealth[i] = MAXHEALTH; 
        /* FIXME: Sound effect */
      }


      /* Constantly reduce player health: */

      if (toggle % 2 == 0 && exited[i] == 0)
        health[i]--;


      /* Are we still alive?! */

      if (health[i] <= 0)
      {
        health[i] = 0;
        if (oldhealth[i] > 0)
        {
          setmap(map, plyy[i], plyx[i], ('w' + i));
          /* FIXME: Sound effect */
        }
      }

      if (health[i] < oldhealth[i] - 1)
        hurting[i] = 1;
      else
        hurting[i] = 0;


      /* Reduce upgrade time: */
      if (upgradetime[i] > 0)
      {
        upgradetime[i]--;
        if (upgradetime[i] <= 0)
          upgrade[i] = UPGRADE_NONE;
      }
    }

    /* Determine if anyone is alive, and who has exited */

    anyalive = 0;
    allexited = 1;
    for (i = 0; i < num_players; i++)
    {
      anyalive += health[i];
      if (health[i] > 0 && exited[i] == 0)
        allexited = 0;
    }

    if (allexited)
    {
      done = 1;
      results = GAME_NEXTLEVEL;
    }


    /* Clear the screen */

    if (anyalive > 0)
      SDL_FillRect(screen, NULL, SDL_MapRGB(screen->format, 0, 0, 0));
    else
      SDL_FillRect(screen, NULL, SDL_MapRGB(screen->format, 32, 0, 0));


    /* Draw the objects we can see from here */

    for (y = (finescrolly - (SCREENH / 2)) / TILEH; y <= (finescrolly + (SCREENH / 2)) / TILEH; y++)
    {
      for (x = (finescrollx - (SCREENW / 2)) / TILEW; x <= (finescrollx + (SCREENW / 2)) / TILEW; x++)
      {
        if (y >= 0 && y < map->h && x >= 0 && x < map->w)
        {
          /* Draw map objects: */

          c = getmap(map, y, x);
          //dest.x = (x - scrollx + (SCREENW / TILEW) / 2) * TILEW;
          //dest.y = (y - scrolly + (SCREENH / TILEH) / 2) * TILEH;
          dest.x = ((x + (SCREENW / TILEW) / 2) * TILEW) - finescrollx;
          dest.y = ((y + (SCREENH / TILEH) / 2) * TILEH) - finescrolly;
          dest.w = TILEW;
          dest.h = TILEH;

          if (c == '#')
            drawimage(screen, img_blockers, 2, 1, 1, 1, dest.x, dest.y);
          else if (c == '$')
            drawimage(screen, img_collectibles, 5, 1, 4, 1, dest.x, dest.y);
          else if (c == '?')
            drawimage(screen, img_collectibles, 5, 1, 5, 1, dest.x, dest.y);
          else if (c == '=')
            drawimage(screen, img_blockers, 2, 1, 2, 1, dest.x, dest.y);
          else if (c == '%')
            SDL_FillRect(screen, &dest, SDL_MapRGB(screen->format,
                                                   rand() % 255,
                                                   rand() % 255,
                                                   rand() % 255));
          else if (c == 'F')
            drawimage(screen, img_collectibles, 5, 1, 1, 1, dest.x, dest.y);
          else if (c == '1')
            drawimage(screen, img_generators, 3, 1, 1, 1, dest.x, dest.y);
          else if (c == '2')
            drawimage(screen, img_generators, 3, 1, 2, 1, dest.x, dest.y);
          else if (c == '3')
            drawimage(screen, img_generators, 3, 1, 3, 1, dest.x, dest.y);
          else if (c == 'A' || c == 'B' || c == 'C')
          {
            want = closestplayer(map, plyx, plyy, health, x, y);
            drawimage(screen, img_badguys, 6, 9,
              (plyx[want] < x ? 1 : (plyx[want] == x ? 2 : 3)) + (3 * (rand() % 2)),
              (plyy[want] < y ? 1 : (plyy[want] == y ? 2 : 3)) + (3 * (c - 'A')),
              dest.x, dest.y);
          }
          else if (c == 'k')
            drawimage(screen, img_collectibles, 5, 1, 2, 1, dest.x, dest.y);
          else if (c == 'b')
            drawimage(screen, img_collectibles, 5, 1, 3, 1, dest.x, dest.y);
          else if (c == 'w' || c == 'x' || c == 'y' || c == 'z')
            drawimage(screen, img_player[0], 6, 12,
              2, 2 + ((c - 'w') * 3),
              dest.x, dest.y);

          /* Draw the players */

          for (i = 0; i < 4; i++)
          {
            if (x == plyx[i] && y == plyy[i] && health[i] > 0 && exited[i] == 0)
            {
              /* Flash around player if they just got hurt */

              if (hurting[i])
                SDL_FillRect(screen, &dest, SDL_MapRGB(screen->format, 255, 255, 255));

              drawimage(screen, img_player[plytype[i]], 6, 12,
                plydirx[i] + (((key_up[i] || key_down[i] || key_left[i] || key_right[i]) && !key_fire[i]) ? (3 * (toggle % 2)) : 0),
                plydiry[i] + (i * 3),
                dest.x, dest.y);
            }

            /* Draw any arrows we can still see: */

            for (j = 0; j < MAXARROWS; j++)
            {
              if (arrows[i][j].alive && x == arrows[i][j].x && y == arrows[i][j].y)
              {
                drawimage(screen, img_arrows[plytype[i]], 3, 3, 2 + arrows[i][j].xm, 2 + arrows[i][j].ym, dest.x, dest.y);
              }
            }
          }
        }
      }
    }

    for (i = 0; i < 4; i++)
    {
      /* FIXME: Better HUD display */

      if (health[i] > 0)
      {
        /* Draw our health meter */

        y = ((TILEH * 4) * i) + TILEH / 4;

        drawimage(screen, img_stats, 4, 1, 1, 1, 0, y);

        /* Max health */

        dest.x = img_stats->w / 4;
        dest.y = y;
        dest.w = (maxhealth[i] * (TILEW * 4)) / MAXHEALTH;
        dest.h = img_stats->h;

        SDL_FillRect(screen, &dest, SDL_MapRGB(screen->format,
                                                 ((char_colors[i] & 0xff0000) >> 16) / 2,
                                                 ((char_colors[i] & 0x00ff00) >> 8) / 2,
                                                 ((char_colors[i] & 0x0000ff) / 2)));

        /* Current meter: */

        dest.x = img_stats->w / 4;
        dest.y = y;
        dest.w = (health[i] * (TILEW * 4)) / MAXHEALTH;
        dest.h = img_stats->h;

        /* Flash if it's low! */

        if (health[i] > MAXHEALTH / 10 || (toggle % 2) == 0)
          SDL_FillRect(screen, &dest, SDL_MapRGB(screen->format,
                                                 (char_colors[i] & 0xff0000) >> 16,
                                                 (char_colors[i] & 0x00ff00) >> 8,
                                                 (char_colors[i] & 0x0000ff)));
        else
          SDL_FillRect(screen, &dest, SDL_MapRGB(screen->format, 255, 0, 0));


        /* Draw our collected objects */


        /* Treasure */

        dest.x = img_stats->w / 4;
        dest.y = y + img_stats->h;

        drawimage(screen, img_stats, 4, 1, 4, 1, 0, dest.y);
        
        snprintf(str, sizeof(str), "%06d", score[i]);
        for (j = 0; j < strlen(str); j++)
        {
          x = (img_stats->w / 4) + (img_numbers->w / 10) * j;
          drawimage(screen, img_numbers, 10, 1, (str[j] - '0') + 1, 1, x, y + img_stats->h);
        }

        /* Keys */

        for (j = 0; j < keys[i]; j++)
        {
          dest.x = (j * TILEW);
          dest.y = y + img_stats->h * 2;
          drawimage(screen, img_collectibles, 5, 1, 2, 1, dest.x, dest.y);
        }

        /* Bombs */

        for (j = 0; j < bombs[i]; j++)
        {
          dest.x = (j * TILEW);
          dest.y = y + img_stats->h * 2 + TILEH;
          drawimage(screen, img_collectibles, 5, 1, 3, 1, dest.x, dest.y);
        }

        /* Any temporary upgrade */
        if (upgrade[i] != UPGRADE_NONE)
        {
          dest.x = 0;
          dest.y = y + img_stats->h * 2 + TILEH * 2;
          drawimage(screen, img_stats, 4, 1, upgrade[i] + 1, 1, dest.x, dest.y);

          dest.x = img_stats->w / 4;
          dest.w = (upgradetime[i] * (TILEW * 4)) / UPGRADE_INIT_TIME;
          dest.h = img_stats->h;
          SDL_FillRect(screen, &dest, SDL_MapRGB(screen->format, 0xff, 0xff, 0xff));
        }
      }
    }


    /* Update the screen, and keep framerate throttled: */

    SDL_Flip(screen);

    nowtimestamp = SDL_GetTicks();
    if (nowtimestamp - timestamp < (1000 / FPS))
      SDL_Delay(timestamp + (1000 / FPS) - nowtimestamp);
  }
  while (!done);

  freemap(&map);

  return(results);
}


/* Determine whether player can move into a particular spot */

int safe(map_t * map, int x, int y, int toggle)
{
  char c;

  if (x < 0 || y < 0 || x >= map->w || y >= map->h)
    return -1;

  c = getmap(map, y, x);

  if (c == '#')
  {
    /* Cannot walk through walls: */
    return -1;
  }
  else if (c == 'A' || c == 'B' || c == 'C' ||
           c == '1' || c == '2' || c == '3')  
  {
    /* Can only melee attack bad guys occassionally */
    if ((toggle % 4) >= 2)
      return -1;
  }

  /* Otherwise, go ahead and try moving there */
  /* Note: We may be bounced back (e.g., if you try to walk
     through a door without any keys, or you're melee-attacking
     a bad guy, you'll get bounced back, even though we report
     it as being 'safe' here). */

  return (int) c;
}


/* Explode a bomb - hurt all bad things visible on the screen */

int bomb(map_t * map, int plyx, int plyy)
{
  int x, y;
  char c;
  int score;

  score = 0;

  for (y = plyy - (SCREENH / TILEH) / 2; y <= plyy + (SCREENH / TILEH) / 2; y++)
  {
    for (x = plyx - (SCREENW / TILEW) / 2; x <= plyx + (SCREENW / TILEW) / 2; x++)
    {
      if (y >= 0 && y < map->h && x >= 0 && x < map->w)
      {
        c = getmap(map, y, x);
        if (c == 'B' || c == 'C' || c == '2' || c == '3')
        {
          /* A bad guy or generator, higher than level 1:
             Reduce the bad guy or generator */

          setmap(map, y, x, c - 1);
          score += 10;
        }
        else if (c == 'A' || c == '1')
        {
          /* A bad guy or generator, at level 1:
             Remove the bad guy or generator */

          setmap(map, y, x, ' ');
          score += 10;
        }
      }
    }
  }

  return(score);
}


/* 'Open' a door, by removing all door pieces that touch.
   Note: a recursive function, but uses two x/y coordinates
   and does up/down/left/right adjacency tests to crawl
   along the door and remove it.  This means no more than
   two door pieces should touch on the map, or the door
   won't open right! */

void opendoor(map_t * map, int x, int y)
{
  int x1, y1, x2, y2;
  char c1l, c1r, c1u, c1d;
  char c2l, c2r, c2u, c2d;
  int done;

  /* Start at the spot on the door that the player touched */

  x1 = x2 = x;
  y1 = y2 = y;

  do
  {
    done = 1;

    /* Look around x/y coordinate #1 */

    c1l = getmap(map, y1, x1 - 1);
    c1r = getmap(map, y1, x1 + 1);
    c1u = getmap(map, y1 - 1, x1);
    c1d = getmap(map, y1 + 1, x1);


    /* Remove door at x/y coordinates #1 and #2 */

    setmap(map, y1, x1, ' ');
    setmap(map, y2, x2, ' ');

    /* Crawl x/y coordinate #1 towards any door piece
       that's adjacent */

    if (c1l == '=')
    {
      done = 0;
      x1--;
    }
    else if (c1r == '=')
    {
      done = 0;
      x1++;
    }
    else if (c1u == '=')
    {
      done = 0;
      y1--;
    }
    else if (c1d == '=')
    {
      done = 0;
      y1++;
    }

    /* If we found a piece, remove it
       (so that x/y coordinate #2 doesn't see it) */

    if (!done)
      setmap(map, y1, x1, ' ');


    /* Look around x/y coordinate #1 */

    c2l = getmap(map, y2, x2 - 1);
    c2r = getmap(map, y2, x2 + 1);
    c2u = getmap(map, y2 - 1, x2);
    c2d = getmap(map, y2 + 1, x2);

    /* Crawl x/y coordinate #1 towards any door piece
       that's adjacent */

    if (c2l == '=')
    {
      done = 0;
      x2--;
    }
    else if (c2r == '=')
    {
      done = 0;
      x2++;
    }
    else if (c2u == '=')
    {
      done = 0;
      y2--;
    }
    else if (c2d == '=')
    {
      done = 0;
      y2++;
    }

    /* Note: The piece at x/y coordinate #2 will be removed
       when this loop repeats. */
  }
  while (!done);

  /* Note: Loop stops repeating once all adjacent door pieces have
     been found. */
}

SDL_Surface * loadimage(char * fname)
{
  char fullfname[1024];
  SDL_Surface * tmp1, * tmp2;

  snprintf(fullfname, sizeof(fullfname), "data/images/%s", fname);
  tmp1 = IMG_Load(fullfname);
  if (tmp1 == NULL)
  {
    fprintf(stderr, "Couldn't load %s: %s\n", fullfname, SDL_GetError());
    SDL_Quit();
    exit(1);
  }

  tmp2 = SDL_DisplayFormatAlpha(tmp1);
  SDL_FreeSurface(tmp1);
  if (tmp2 == NULL)
  {
    fprintf(stderr, "Couldn't convert %s: %s\n", fullfname, SDL_GetError());
    SDL_Quit();
    exit(1);
  }
  
  return(tmp2);
}

void drawimage(SDL_Surface * screen, SDL_Surface * sheet, int tilew, int tileh, int tilex, int tiley, int x, int y)
{
  SDL_Rect src, dest;

  src.x = (sheet->w / tilew) * (tilex - 1);
  src.y = (sheet->h / tileh) * (tiley - 1);
  src.w = (sheet->w / tilew);
  src.h = (sheet->h / tileh);

  dest.x = x;
  dest.y = y;

  SDL_BlitSurface(sheet, &src, screen, &dest);
}

int closestplayer(map_t * map, int plyx[4], int plyy[4], int health[4], int x, int y)
{
  int i, want, dx, dy, thisdist, dist;

  /* Default (in case everyone's dead) */

  want = ((x + y) % 4);
  dist = map->w * map->h;

  for (i = 0; i < 4; i++)
  {
    if (health[i] > 0)
    {
      dx = plyx[i] - x;
      dy = plyy[i] - y;
      thisdist = sqrt((dx * dx) + (dy * dy));
      if (thisdist < dist)
      {
        want = i;
        dist = thisdist;
      }
    }
  }

  return(want);
}

/* Free a map */

void freemap(map_t * * map)
{
  if ((*map) != NULL)
  {
    if ((*map)->m != NULL)
      free((*map)->m);

    free((*map));
    *map = NULL;
  }
}


/* Load a map */

map_t * loadmap(int level)
{
  char fname[1024], line[1024];
  FILE * fi;
  int x, y, i, j;
  map_t * map;
  void * dummy;

  snprintf(fname, sizeof(fname), "data/maps/%d.txt", level);
  fi = fopen(fname, "r");
  if (fi == NULL)
    return(NULL);

  map = (map_t *) malloc(sizeof(map_t));

  dummy = fgets(line, 1024, fi);
  map->w = atoi(line);
  dummy = fgets(line, 1024, fi);
  map->h = atoi(line);

  for (i = 0; i < 4; i++)
  {
    map->startx[i] = i + 1;
    map->starty[i] = 1;
  }

  map->m = (char *) malloc(sizeof(char) * (map->w * map->h));

  for (y = 0; y < map->h; y++)
  {
    dummy = fgets(line, 1024, fi);

    for (x = 0; x < map->w; x++)
    {
      map->m[(y * map->w) + x] = line[x];

      if (line[x] >= '5' && line[x] <= '8')
      {
        j = line[x] - '5';
        line[x] = ' ';

        map->startx[j] = x;
        map->starty[j] = y;
      }
    }
  }

  return(map);
}

int menu(void)
{
  int option, done;
  Uint32 timestamp, nowtimestamp;
  SDLKey key;
  SDL_Event event;
  SDL_Rect dest;

  /* FIXME: Provide access to an options screen */

  option = MENU_START;
  done = 0;

  do
  {
    timestamp = SDL_GetTicks();

    while (SDL_PollEvent(&event) > 0)
    {
      if (event.type == SDL_QUIT)
      {
        option = MENU_QUIT;
        done = 1;
      }
      else if (event.type == SDL_KEYDOWN)
      {
        key = event.key.keysym.sym;
        if (key == SDLK_ESCAPE)
        {
          option = MENU_QUIT;
          done = 1;
        }
        else if (key == SDLK_RETURN || key == SDLK_SPACE)
        {
          done = 1;
        }
      }
    }

    SDL_FillRect(screen, NULL, SDL_MapRGB(screen->format, 0, 0, 0));

    dest.x = (screen->w - img_title->w) / 2;
    dest.y = 0;
    SDL_BlitSurface(img_title, NULL, screen, &dest);

    SDL_Flip(screen);

    nowtimestamp = SDL_GetTicks();
    if (nowtimestamp - timestamp < (1000 / FPS))
      SDL_Delay(timestamp + (1000 / FPS) - nowtimestamp);
  }
  while (!done);

  return(option);
}


int startgame(void)
{
  int option, done, i, j, x, y;
  Uint32 timestamp, nowtimestamp;
  SDLKey key;
  SDL_Event event;
  SDL_Rect dest;
  int key_left[4], key_right[4];
  int oldkey_left[4], oldkey_right[4];
  char str[16];

  done = 0;
  option = STARTGAME_START;

  for (i = 0; i < 4; i++)
    key_left[i] = key_right[i] = 0;

  do
  {
    timestamp = SDL_GetTicks();

    for (i = 0; i < 4; i++)
    {
      oldkey_left[i] = key_left[i];
      oldkey_right[i] = key_right[i];
    }

    while (SDL_PollEvent(&event) > 0)
    {
      if (event.type == SDL_QUIT)
      {
        option = STARTGAME_QUIT;
        done = 1;
      }
      else if (event.type == SDL_KEYDOWN)
      {
        key = event.key.keysym.sym;
        if (key == SDLK_ESCAPE)
        {
          /* [Esc] back to main menu */

          option = STARTGAME_BACK;
          done = 1;
        }
        else if (key >= SDLK_1 && key <= SDLK_4)
        {
          /* [1]-[4] to choose number of players */

          num_players = (key - SDLK_1) + 1;
        }
        else if (key == SDLK_RETURN || key == SDLK_SPACE)
        {
          /* [Enter/Return] or [Space] to begin */

          option = STARTGAME_START;
          done = 1;
        }
        else if (key == SDLK_PAGEUP)
        {
          level++;
          if (level > 99)
            level = 1;
        }
        else if (key == SDLK_PAGEDOWN)
        {
          level--;
          if (level < 1)
            level = 99;
        }
        else
        {
          /* Allow players to change their character: */

          for (i = 0; i < 4; i++)
          {
            if (key == key_codes[i][KEY_RIGHT])
            {
              plytype[i]++;
              if (plytype[i] > 3)
                plytype[i] = 0;
            }
            else if (key == key_codes[i][KEY_LEFT])
            {
              plytype[i]--;
              if (plytype[i] < 0)
                plytype[i] = 3;
            }
          }
        }
      }
      else if (event.type == SDL_JOYAXISMOTION)
      {
        for (i = 0; i < 4; i++)
        {
          for (j = 0; j < NUM_KEYS; j++)
          {
            if (event.jaxis.which == stick_codes[i][j].joy &&
                event.jaxis.axis == stick_codes[i][j].axis)
            {
              if ((event.jaxis.value > 0 && stick_codes[i][j].axis_sign > 0) ||
                  (event.jaxis.value < 0 && stick_codes[i][j].axis_sign < 0))
              {
                if (j == KEY_LEFT)
                {
                  key_left[i] = 1;
                  key_right[i] = 0;
                }
                else if (j == KEY_RIGHT)
                {
                  key_right[i] = 1;
                  key_left[i] = 0;
                }
              }
              else if (event.jaxis.value == 0)
              {
                if (j == KEY_LEFT)
                  key_left[i] = 0;
                else if (j == KEY_RIGHT)
                  key_right[i] = 0;
              }
            }
          }
        }
      }
      else if (event.type == SDL_JOYBUTTONDOWN)
      {
        for (i = 0; i < 4; i++)
        {
          for (j = 0; j < NUM_KEYS; j++)
          {
            if (event.jbutton.which == stick_codes[i][j].joy &&
                event.jbutton.button == stick_codes[i][j].btn)
            {
              if (j == KEY_LEFT)
                key_left[i] = 1;
              else if (j == KEY_RIGHT)
                key_right[i] = 1;
            }
          }
        }
      }
      else if (event.type == SDL_JOYBUTTONUP)
      {
        for (i = 0; i < 4; i++)
        {
          for (j = 0; j < NUM_KEYS; j++)
          {
            if (event.jbutton.which == stick_codes[i][j].joy &&
                event.jbutton.button == stick_codes[i][j].btn)
            {
              if (j == KEY_LEFT)
                key_left[i] = 0;
              else if (j == KEY_RIGHT)
                key_right[i] = 0;
            }
          }
        }
      }
    }


    for (i = 0; i < 4; i++)
    {
      if (key_right[i] && oldkey_right[i] == 0)
      {
        plytype[i]++;
        if (plytype[i] > 3)
          plytype[i] = 0;
      }
      else if (key_left[i] && oldkey_left[i] == 0)
      {
        plytype[i]--;
        if (plytype[i] < 0)
          plytype[i] = 3;
      }
    }

    /* Draw screen */

    SDL_FillRect(screen, NULL, SDL_MapRGB(screen->format, 0, 0, 0));

    /* Title: */
    dest.x = (screen->w - img_title->w) / 2;
    dest.y = 0;
    SDL_BlitSurface(img_title, NULL, screen, &dest);

    /* Instructions: */
    dest.x = (screen->w - img_playerselect->w) / 2;
    dest.y = img_title->h;
    SDL_BlitSurface(img_playerselect, NULL, screen, &dest);

    /* Players: */
    for (i = 0; i < 4; i++)
    {
      x = ((screen->w - TILEW * 8) / 2) + (i * (TILEW * 2));
      y = img_title->h + img_playerselect->h + TILEH;
      dest.x = x;
      dest.y = y;

      drawimage(screen, img_player[plytype[i]], 6, 12,
              3, 2 + (i * 3),
              dest.x, dest.y);

      if (i >= num_players)
      {
        /* Fade-out effect over disabled players */

        for (j = 0; j < TILEH; j += 2)
        {
          dest.x = x;
          dest.y = y + j;
          dest.w = TILEW;
          dest.h = 1;
          SDL_FillRect(screen, &dest, SDL_MapRGB(screen->format, 0, 0, 0));
        }
      } else {
        /* Show player's character stats: */

        for (j = 0; j < char_healths[plytype[i]]; j++)
          drawimage(screen, img_stats, 4, 1, 1, 1, x + (img_stats->w / 4) * j, y + TILEH);
        for (j = 0; j < char_weapons[plytype[i]]; j++)
          drawimage(screen, img_stats, 4, 1, 2, 1, x + (img_stats->w / 4) * j, y + TILEH + img_stats->h);
        for (j = 0; j < char_speeds[plytype[i]]; j++)
          drawimage(screen, img_stats, 4, 1, 3, 1, x + (img_stats->w / 4) * j, y + TILEH + img_stats->h * 2);
      }
    }

    /* Level selection */
    snprintf(str, sizeof(str), "%d", level);
    y = screen->h - img_numbers->h;
    x = (screen->w - (img_numbers->w / 10) * strlen(str)) / 2;
    for (i = 0; i < strlen(str); i++)
      drawimage(screen, img_numbers, 10, 1, str[i] - '0' + 1, 1, x + (i * (img_numbers->w / 10)), y);

    SDL_Flip(screen);

    nowtimestamp = SDL_GetTicks();
    if (nowtimestamp - timestamp < (1000 / FPS))
      SDL_Delay(timestamp + (1000 / FPS) - nowtimestamp);
  }
  while (!done);

  /* Set initial game state: */

  if (option == STARTGAME_START)
  {
    for (i = 0; i < 4; i++)
    {
      score[i] = 0;
      bombs[i] = 0;
      upgrade[i] = UPGRADE_NONE;
      upgradetime[i] = 0;
      keys[i] = 0;

      maxhealth[i] = (MAXHEALTH / 3) * char_healths[plytype[i]];

      if (i < num_players)
        health[i] = maxhealth[i];
      else
        health[i] = 0;
    }
  }

  return(option);
}

void setup(int argc, char * argv[])
{
  FILE * fi;
  char line[1024], fname[1024];
  void * dummy;
  int ply, want, joy, axis, btn, i, j;
  char * valstr;
  int num_joysticks;
  SDL_Joystick * js;

  /* Set defaults: */

  for (i = 0; i < 4; i++)
    for (j = 0; j < NUM_KEYS; j++)
      stick_codes[i][j].joy = -1;

  key_codes[0][KEY_DOWN] = SDLK_DOWN;
  key_codes[0][KEY_UP] = SDLK_UP;
  key_codes[0][KEY_LEFT] = SDLK_LEFT;
  key_codes[0][KEY_RIGHT] = SDLK_RIGHT;
  key_codes[0][KEY_FIRE] = SDLK_RCTRL;
  key_codes[0][KEY_BOMB] = SDLK_1;

  key_codes[1][KEY_DOWN] = SDLK_s;
  key_codes[1][KEY_UP] = SDLK_w;
  key_codes[1][KEY_LEFT] = SDLK_a;
  key_codes[1][KEY_RIGHT] = SDLK_d;
  key_codes[1][KEY_FIRE] = SDLK_q;
  key_codes[1][KEY_BOMB] = SDLK_2;

  key_codes[2][KEY_DOWN] = SDLK_KP2;
  key_codes[2][KEY_UP] = SDLK_KP8;
  key_codes[2][KEY_LEFT] = SDLK_KP4;
  key_codes[2][KEY_RIGHT] = SDLK_KP6;
  key_codes[2][KEY_FIRE] = SDLK_KP0;
  key_codes[2][KEY_BOMB] = SDLK_3;

  key_codes[3][KEY_DOWN] = SDLK_g;
  key_codes[3][KEY_UP] = SDLK_t;
  key_codes[3][KEY_LEFT] = SDLK_f;
  key_codes[3][KEY_RIGHT] = SDLK_h;
  key_codes[3][KEY_FIRE] = SDLK_r;
  key_codes[3][KEY_BOMB] = SDLK_4;

  /* FIXME: Read config-file arguments */
  if (getenv("HOME") != NULL)
  {
    snprintf(fname, sizeof(fname), "%s/.foprc", getenv("HOME"));
    fi = fopen(fname, "r");
    if (fi != NULL)
    {
      do
      {
        dummy = fgets(line, sizeof(line), fi);
        if (!feof(fi))
        {
          line[strlen(line) - 1] = '\0';
          if (line[0] == 'P' && line[1] >= '1' && line[1] <= '4' && line[2] == '_')
          {
            ply = line[1] - '1';

            if (strstr(line, "FIRE = ") == line + 3)
              want = KEY_FIRE;
            else if (strstr(line, "BOMB = ") == line + 3)
              want = KEY_BOMB;
            else if (strstr(line, "UP = ") == line + 3)
              want = KEY_UP;
            else if (strstr(line, "DOWN = ") == line + 3)
              want = KEY_DOWN;
            else if (strstr(line, "LEFT = ") == line + 3)
              want = KEY_LEFT;
            else if (strstr(line, "RIGHT = ") == line + 3)
              want = KEY_RIGHT;
            else
            {
              fprintf(stderr, "Unknown option: %s\n", line);
              want = -1;
            }

            if (want != -1)
            {
              valstr = strstr(line, " = ") + 3;
              if (strstr(valstr, "KEY_") == valstr)
              {
                key_codes[ply][want] = atoi(valstr + 4);
                stick_codes[ply][want].joy = -1;
              }
              else if (strstr(valstr, "JOY") == valstr)
              {
                joy = atoi(valstr + 3);

                if (strstr(valstr, "_AXIS") == valstr + 4)
                {
                  axis = atoi(valstr + 9);

                  if (strstr(valstr, "_POS") >= valstr + 10)
                  {
                    key_codes[ply][want] = -1;
                    stick_codes[ply][want].joy = joy;
                    stick_codes[ply][want].axis = axis;
                    stick_codes[ply][want].axis_sign = 1;
                    stick_codes[ply][want].btn = -1;
                  }
                  else if (strstr(valstr, "_NEG") >= valstr + 10)
                  {
                    key_codes[ply][want] = -1;
                    stick_codes[ply][want].joy = joy;
                    stick_codes[ply][want].axis = axis;
                    stick_codes[ply][want].axis_sign = -1;
                    stick_codes[ply][want].btn = -1;
                  }
                  else
                    fprintf(stderr, "Unknown option: %s\n", line);
                }
                else if (strstr(valstr, "_BTN") == valstr + 4)
                {
                  btn = atoi(valstr + 8);

                  key_codes[ply][want] = -1;
                  stick_codes[ply][want].joy = joy;
                  stick_codes[ply][want].axis = -1;
                  stick_codes[ply][want].btn = btn;
                }
                else
                {
                  fprintf(stderr, "Unknown option: %s\n", line);
                }
              }
            }
          }
        }
      }
      while (!feof(fi));
      fclose(fi);
    }
  }

/*
  for (i = 0; i < 4; i++)
    for (j = 0; j < NUM_KEYS; j++)
      printf("ply%d key%d : joy=%d axis=%d(%d) btn=%d\n", i+1, j,
        stick_codes[i][j].joy,
        stick_codes[i][j].axis,
        stick_codes[i][j].axis_sign,
        stick_codes[i][j].btn);
*/

  /* FIXME: Parse command-line arguments */

  /* Initialize SDL */

  if (SDL_Init(SDL_INIT_VIDEO) < 0)
  {
    fprintf(stderr, "Error init'ing SDL: %s\n", SDL_GetError());
    exit(1);
  }

  if (SDL_Init(SDL_INIT_JOYSTICK) < 0)
  {
    fprintf(stderr, "Warning: Error init'ing SDL: %s\n", SDL_GetError());
  }
  else
  {
    num_joysticks = SDL_NumJoysticks();

    for (i = 0; i < num_joysticks; i++)
      js = SDL_JoystickOpen(i);
  }

  /* Open a window / screen */

  screen = SDL_SetVideoMode(SCREENW, SCREENH, 0, 0);
  if (screen == NULL)
  {
    fprintf(stderr, "Error opening video: %s\n", SDL_GetError());
    SDL_Quit();
    exit(1);
  }

  SDL_WM_SetCaption("Fight or Perish (v" VERSION ")", "FOP");

  /* Load imagery */

  img_title = loadimage("title.png");
  img_playerselect = loadimage("playerselect.png");
  img_stats = loadimage("stats.png");
  img_numbers = loadimage("numbers.png");
  img_generators = loadimage("generators.png");
  img_collectibles = loadimage("collectibles.png");
  img_blockers = loadimage("blockers.png");
  img_badguys = loadimage("badguys.png");
  img_player[0] = loadimage("playera.png");
  img_arrows[0] = loadimage("arrowsa.png");
  img_player[1] = loadimage("playerb.png");
  img_arrows[1] = loadimage("arrowsb.png");
  img_player[2] = loadimage("playerc.png");
  img_arrows[2] = loadimage("arrowsc.png");
  img_player[3] = loadimage("playerd.png");
  img_arrows[3] = loadimage("arrowsd.png");
}

