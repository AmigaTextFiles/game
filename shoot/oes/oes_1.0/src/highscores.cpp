#include "snipe2d.h"
#include <pwd.h>

extern PREFS gPrefs;
char uName[9];
char names[10][9];
int scores[10];

extern void fillrect (int x1, int y1, int x2, int y2, int color);


void
oes_fillrect (SDL_Surface *screen, int x1, int y1, int x2, int y2, int color)
{
    SDL_Rect r;
    r.x = x1;
    r.y = y1;
    r.w = x2-x1;
    r.h = y2-y1;
    int sdlcolor = SDL_MapRGB(screen->format,
                              (color >> 16) & 0xff,
                              (color >> 8) & 0xff,
                              (color >> 0) & 0xff);
    SDL_FillRect(screen, &r, sdlcolor);
}


int
draw_hiscores (SDL_Surface *screen, const SDL_Rect *r)
{
  char score[256];
  FILE *f;
  int i;
  int row, toprow;
  int col;
  int x, y, w, h;
  int xp, xq;  /* horizontal scale factor (p/q) */
  int yp, yq;  /* vertical scale factor (p/q) */

  if ((f = fopen(gPrefs.scorepath, "rb")))
    {
      fread(&Game.HiScore, sizeof(SCORES), 1, f);
      fclose(f);
    }

  x = r->x; y = r->y; w = r->w; h = r->h;
  /* map  640 * p/q  =>  screen->w */
  xp = screen->w;
  yp = screen->h;
  xq = 640;
  yq = 480;
#define X(n) (x + (n * xp / xq))
#define Y(n) (y + (n * yp / yq))
  oes_fillrect(screen, X(0), Y(0), X(640), Y(480), 0);
  oes_fillrect(screen, X(19), Y(59), X(621), Y(421), 0x007f00);
  oes_fillrect(screen, X(20), Y(60), X(620), Y(420), 0x003f00);
  oes_fillrect(screen, X(19), Y(80), X(621), Y(81), 0x007f00);
  print(X(224 + 12), Y(412), COLOR_GREEN, "click to play | press ESC to quit");
  toprow = 88 + 40;

  row = toprow;
  printShadow(X(30), Y(row), "  Top Ten (Difficulty: Easy");
  row += 8;
  for (i = 0; i < 10; i ++)
    {
      col = 24;
      printShadow(X(col), Y(row), Game.HiScore.easy_n[i]);
      snprintf(score, sizeof(score), "%d", Game.HiScore.easy_s[i]);
      if (Game.HiScore.easy_s[i])
        printShadow(X(col + 48), Y(row), score);
      row += 8;
    }

  row = toprow;
  printShadow(X(250), Y(row), "Top Ten (Difficulty: Medium)");
  row += 8;
  for (i = 0; i < 10; i++)
    {
      col = 250;
      printShadow(X(col), Y(row), Game.HiScore.medium_n[i]);
      snprintf(score, sizeof(score), "%d", Game.HiScore.medium_s[i]);
      if (Game.HiScore.medium_s[i])
          printShadow(X(col + 48), Y(row), score);
      row += 8;
    }

  row = toprow;
  printShadow(X(476), Y(row), " Top Ten (Difficulty: Hard)");
  row += 8;
  for (i = 0; i < 10; i++)
    {
      col = 476;
      printShadow(X(col), Y(row), Game.HiScore.hard_n[i]);
      snprintf(score, sizeof(score), "%d", Game.HiScore.hard_s[i]);
      if (Game.HiScore.hard_s[i])
          printShadow(X(col + 48), Y(row), score);
      row += 8;
    }

  row = toprow;

#undef X
#undef Y
  return 1;
}

#if 0
void show_hiscores()
{
    char score[256];
    FILE *f;
    int i;

    Game.GameState = 0;
    SDL_ShowCursor (1);
    if ((f = fopen (gPrefs.scorepath, "rb")))
	{
	    fread (&Game.HiScore, sizeof(SCORES), 1, f);
	    fclose (f);
	}

    Game.GameState = 0;
    fillrect(0,0,640,480,0);
    fillrect(19,59,621,421,0x007f00);
    fillrect(20,60,620,420,0x003f00);
    fillrect(19,80,621,81,0x007f00);
    print(224 + 12, 412, COLOR_GREEN, "click to play | press ESC to quit");
    int row = 88 +40;

    printShadow (30, row, "  Top Ten (Difficulty: Easy");
    row += 8;
    for (i = 0; i < 10; i++)
	{
	    printShadow (24, row, Game.HiScore.easy_n[i]);
	    snprintf (score, sizeof(score), "%d", Game.HiScore.easy_s[i]);
	    if (Game.HiScore.easy_s[i])
		printShadow (24+48, row, score);
	    row += 8;
	}
    row = 88+40;

    printShadow (250, row, "Top Ten (Difficulty: Medium)");
    row += 8;
    for (i = 0; i < 10; i++)
	{
	    printShadow (250, row, Game.HiScore.medium_n[i]);
	    snprintf (score, sizeof(score), "%d", Game.HiScore.medium_s[i]);
	    if (Game.HiScore.medium_s[i])
		printShadow (298, row, score);
	    row += 8;
	}
    row = 88+40;

    printShadow (476, row, " Top Ten (Difficulty: Hard)");
    row += 8;
    for (i = 0; i < 10; i++)
	{
	    printShadow (476, row, Game.HiScore.hard_n[i]);
	    snprintf (score, sizeof(score), "%d", Game.HiScore.hard_s[i]);
	    if (Game.HiScore.hard_s[i])
		printShadow (476+48, row, score);
	    row += 8;
	}
    row = 88+40;

    SDL_Flip (Game.Screen);
}
#endif /* 0 */

void shove_hiscores(int pos) // Shift scorecard down, bump last one.
{
    int i;

    for (i = 9; i > pos; i--)
	if (i > 0)
	    {
		snprintf (names[i], 9, "%s", names[i-1]);
		names[i][8] = '\0';
		scores[i] = scores[i-1];
	    }

    scores[i] = Game.Score;
    snprintf (names[i], 9, "%s", uName);
    names[i][8] = '\0';
}

void init_hiscores()
{
    char path[256];
    struct passwd *pw_ent = getpwuid (geteuid());
    FILE *f;

    memset (&Game.HiScore, 0, sizeof(SCORES));
    snprintf (uName, 9, "%s", getenv("USER"));
    uName[8] = '\0';

    snprintf (path, 256, "%s/.oes/scores.bin", pw_ent->pw_dir);
    path[255] = '\0';
    f = fopen (path, "rb");
    if (f)
	{
	    fread (&Game.HiScore, sizeof(SCORES), 1, f);
	    fclose (f);
	}
}

void save_hiscores()
{
    FILE *f;
    if (!(f = fopen(gPrefs.scorepath, "wb")))
	{
	    fprintf (stderr, "Unable to open hiscore file.  Ignoring...\n");
	    return;
	}
    fwrite (&Game.HiScore, sizeof (SCORES), 1, f);
    fclose (f);
}

void process_hiscore()
{
    int i;

    if (Game.Score < 0)
	return;
    if (gPrefs.difficulty == 1)
	{
	    memcpy (&scores, &Game.HiScore.easy_s, sizeof(int)*10);
	    memcpy (&names, &Game.HiScore.easy_n, sizeof(char)*90);
	}
    else if (gPrefs.difficulty == 2)
	{
	    memcpy (&scores, &Game.HiScore.medium_s, sizeof(int)*10);
	    memcpy (&names, &Game.HiScore.medium_n, sizeof(char)*90);
	}
    else
	{
	    memcpy (&scores, &Game.HiScore.hard_s, sizeof(int)*10);
	    memcpy (&names, &Game.HiScore.hard_n, sizeof(char)*90);
	}
    for (i = 0; i < 10; i++)
	if (Game.Score > scores[i])
	    break;

    if (i > 9)
	return;

    shove_hiscores(i);

    if (gPrefs.difficulty == 1)
	{
	    memcpy (&Game.HiScore.easy_s, &scores, sizeof(int)*10);
	    memcpy (&Game.HiScore.easy_n, &names, sizeof(char)*90);
	}
    else if (gPrefs.difficulty == 2)
	{
	    memcpy (&Game.HiScore.medium_s, &scores, sizeof(int)*10);
	    memcpy (&Game.HiScore.medium_n, &names, sizeof(char)*90);
	}
    else
	{
	    memcpy (&Game.HiScore.hard_s, &scores, sizeof(int)*10);
	    memcpy (&Game.HiScore.hard_n, &names, sizeof(char)*90);
	}

    save_hiscores();
}


