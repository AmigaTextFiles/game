#include "gameparams.h"

GameParams getParamsFromArgs (int argc, char **argv) {
  GameParams p = {0,{0,0}};

	if (argc==1)
		printf ("type %s -help for help\n",argv[0]);

  while (argc--) {
    char *arg = *argv;

    if (!strcasecmp(arg,"-fs"))
      p.fullscreen = 1;
    if (!strcasecmp(arg,"-gg-black"))
      p.gg_play[0] = 1;
    if (!strcasecmp(arg,"-gg-white"))
      p.gg_play[1] = 1;
    if (!strcasecmp(arg,"-help")) {
      printf (
        "usage : ./goboss [OPTIONS]\n"
        "options are:\n"
        "        -fs       : play in fullscreen\n"
        "        -gg-black : gnugo plays blacks\n"
        "        -gg-white : gnugo plays whites\n");
			exit(0);
		}

    argv++;
  }
  return p;
}
