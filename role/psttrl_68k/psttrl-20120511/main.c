#include <stdio.h>
/* srand */
#include <stdlib.h>
/* strcmp */
#include <string.h>
#include <pdcurses/curses.h>

#include "config.h"

#ifdef HAVE_TERM_H
/* setupterm */
/* <term.h> must be after <curses.h> */
#include <pdcurses/term.h>
#endif /* HAVE_TERM_H */

#ifdef USE_HOME_TO_SAVE

/* getenv */
#include <stdlib.h>
/* stat */
#include <sys/stat.h>
/* errno */
#include <errno.h>
/* strerror */
#include <string.h>

/* mkdir */
#ifdef HAVE_IO_H
#include <io.h>
#else /* not HAVE_IO_H */
#include <sys/stat.h>
#endif /* not HAVE_IO_H */

#endif /* USE_HOME_TO_SAVE */

#include "world.h"
#include "loop.h"
#include "save.h"
#include "dungeon.h"
#include "build.h"
#include "util.h"
#include "jkiss32.h"

#ifdef USE_HOME_TO_SAVE
static char *save_dir_in_home(void);
#endif /* USE_HOME_TO_SAVE */

static int check_window(void);
static int do_version(void);
static int do_help(void);

static char *
save_dir_in_home(void)
{
#ifdef USE_HOME_TO_SAVE
  struct stat buf_stat;
  char *save_dir = NULL;

  if (getenv ("HOME") == NULL)
    return NULL;

  save_dir = concat_string(3, getenv ("HOME"), "/", ".psttrl");
  if (save_dir == NULL)
  {
    fprintf(stderr, "save_dir_in_home: concat_string failed\n");
    return NULL;
  }

  errno = 0;
  if (stat(save_dir, &buf_stat) != 0)
  {
    if (errno == ENOENT)
    {
      if (mkdir(save_dir, S_IRWXU | S_IRWXG | S_IRWXO) != 0)
      {
        fprintf(stderr, "save_dir_in_home: mkdir failed\n");
        /* continue anyway */
      }
    }
    else
    {
      fprintf(stderr, "save_dir_in_home: stat failed (%s)\n",
              strerror(errno));
      free(save_dir);
      save_dir = NULL;
      return NULL;
    }
  }


  return save_dir;
#endif /* USE_HOME_TO_SAVE */

  return NULL;
}

static int
check_window(void)
{
#if HAVE_TERM_H
  int errret;
  int scr_size_x;
  int scr_size_y;
  int scr_size_x_needed;
  int scr_size_y_needed;

  if (setupterm(NULL, 1, &errret) != OK)
  {
    fprintf(stderr, "check_window: setupterm failed\n");
    return 1;
  }

  scr_size_x = tigetnum("cols");
  if (scr_size_x < 0)
  {
    fprintf(stderr, "check_window: tigetnum(cols) failed\n");
    return 1;
  }
  scr_size_y = tigetnum("lines");
  if (scr_size_y < 0)
  {
    fprintf(stderr, "check_window: tigetnum(lines) failed\n");
    return 1;
  }

  scr_size_x_needed = 80;
  scr_size_y_needed = 24;
  if ((scr_size_x < scr_size_x_needed)
      || (scr_size_y < scr_size_y_needed))
  {
    fprintf(stderr, "The window size %dx%d is too small.\n",
            scr_size_x, scr_size_y);
    fprintf(stderr, "It must be %dx%d or larger.\n",
            scr_size_x_needed, scr_size_y_needed);
    return 1;
  }

  if (has_colors() != TRUE)
  {
    fprintf(stderr, "The window must support colors.\n");
    return 1;
  }

#endif /* HAVE_TERM_H */

  return 0;
}

static int
do_version(void)
{
  printf("psttrl (Professional Sword Tester the Roguelike)\n");
  printf("Fri, 11 May 2012 release\n");
  printf("Copyright (C) 2012 Oohara Yuuma <oohara@libra.interq.or.jp>\n");
  printf("This program is free software;\n");
  printf("see the file LICENSE in the source code for details.\n");
  printf("psttrl comes with NO WARRANTY, to the extent "
         "permitted by law.\n");

  return 0;
}

static int
do_help(void)
{
  char *save_dir = NULL;

  save_dir = save_dir_in_home();

  printf("Usage: psttrl [options]\n");
  printf("kill a dragon with your favorite weapon\n");
#ifdef USE_BUILT_IN_RAND
  printf("uses built-in RNG\n");
#else /* not USE_BUILT_IN_RAND */
  printf("uses library rand()\n");
#endif /* not USE_BUILT_IN_RAND */
  printf("Options:\n");
  printf("--save-dir _dir_          save and load game in this directory\n");

  printf("  (default: ");
  if (save_dir != NULL)
  {
    printf("%s", save_dir);
    free(save_dir);
    save_dir = NULL;
  }
  else
  {
    printf("current directory");
  }
  printf(")\n");

  printf("--help                    print this message\n");
  printf("--version                 print version information\n");
  printf("--cheat-color-by-threat   highlight dangerous monsters (cheat)\n");
  printf("\n");
  printf("Report bugs to <oohara@libra.interq.or.jp>.\n");

  return 0;
}

int
main(int argc, char *argv[])
{
  int i;
  int flag_help;
  int flag_version;
  int cheat_color_by_threat;
  world *wp = NULL;
  char *save_dir = NULL;

  flag_help = 0;
  flag_version = 0;
  cheat_color_by_threat = 0;
  for (i = 1; i < argc; i++)
  {
    if (!strcmp(argv[i], "--help"))
    {
      flag_help = 1;
    }
    else if (!strcmp(argv[i], "--version"))
    {
      flag_version = 1;
    }
    else if (!strcmp(argv[i], "--save-dir"))
    {
      if (i + 1 >= argc)
      {
        fprintf(stderr, "main: missing argument for --save-dir\n");
        return 1;
      }
      save_dir = argv[i + 1];
      i++;
    }
    else if (!strcmp(argv[i], "--cheat-color-by-threat"))
    {
      cheat_color_by_threat = 1;
    }
    else
    {
      fprintf(stderr, "main: unknown option: %s\n", argv[i]);
      fprintf(stderr, "Type %s --help for the list of options.\n", argv[0]);
      return 1;
    }
  }

  if (flag_version)
    do_version();
  if (flag_help)
    do_help();
  if ((flag_help) || (flag_version))
    return 0;

  if (check_window() != 0)
    return 1;

  if (initialize_rand() != 0)
  {
    fprintf(stderr, "main: initialize_rand failed\n");
    return 1;
  }

  wp = world_new();
  if (wp == NULL)
  {
    fprintf(stderr, "main: world_new failed\n");
    return 1;
  }

  if (save_dir != NULL)
  {
    wp->save_dir = concat_string(1, save_dir);
  }
  else
  {
    wp->save_dir = save_dir_in_home();
  }

  if (load_game(wp) != 0)
  {
    if (build_new_game(wp) != 0)
    {
      fprintf(stderr, "main: build_new_game failed\n");
      return 1;
    }
    add_log(wp, "welcome");
  }
  else
  {
    add_log(wp, "welcome back");
  }

  if (cheat_color_by_threat)
    wp->cheat_color_by_threat = 1;

  if (world_init_curses(wp) != 0)
  {
    fprintf(stderr, "main: world_init_curses failed\n");
    return 1;
  }

  main_loop(wp);

  world_delete(wp);
  wp = NULL;

  return 0;
}
