#include "robot.h"
#include <stdarg.h>

void error(const char *msg, ...)
{
	va_list argptr;
	char *str;

	va_start(argptr, msg);
	if (vasprintf(&str, msg, argptr) == -1)
		fprintf(stderr, "Error too long to print out: %s\n", msg);
	else
	{
		fprintf(stderr, "%s\n", str);
		free(str);
	}
	va_end(argptr);

	exit(1);
}

int main(int argc, char *argv[])
{
	int score = -1;

	random_seed();
	setupvideo();
	setupfonts();
	startaudio();
	clearscreen();
	updatescreen();

	while (showmenu(score))
		score = playgame();

	argc = argc, argv = argv;
	return 0;
}
